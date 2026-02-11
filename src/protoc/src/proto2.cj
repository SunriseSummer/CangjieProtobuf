/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
// gencode for proto2

package protoc

/* field variable define */
func getFieldVarDefine2(field: FieldDescriptorProto) {
    if (field.hasDefaultValue) {
        match (field.type_) {
            case TYPE_DOUBLE | TYPE_FLOAT => if (!field.defaultValue.contains(".")) { field.defaultValue = if (field.defaultValue[0] == b'-') { "-.${field.defaultValue[1 ..]}" } else { ".${field.defaultValue}" } }
            case TYPE_STRING => field.defaultValue = "\"${field.defaultValue}\""
            case TYPE_ENUM => field.defaultValue = getEnumItemName(field.defaultValue)
            case TYPE_BYTES => throw Exception("NOT SUPPORT BYTES DEFAULT VALUE")
            case _ => ()
        }
    }

    match {
        case field.label == LABEL_REPEATED => getFieldVarDefine(field)
        case field.type_ == TYPE_MESSAGE => "private var p_${field.name}: PbMessage<${field.typeName}>"
        case _ => "private var p_${field.name}: ?${typeConvert(field)}"
    }
}

/* field variable default */
func getFieldVarDefault2(field: FieldDescriptorProto) {
    match {
        case field.label == LABEL_REPEATED => getFieldVarDefault(field)
        case _ => "?${typeConvert(field)} = None"
    }
}

/* field variable init */
func getFieldVarInit2(field: FieldDescriptorProto) {
    match {
        case field.label == LABEL_REPEATED => getFieldVarInit(field)
        case field.type_ == TYPE_MESSAGE => "p_${field.name} = PbMessage<${field.typeName}>(${field.propName})"
        case field.hasDefaultValue => let pn = field.propName; "p_${field.name} = if (${pn} != ${field.defaultValue}) { ${pn} } else { None }"
        case _ => "p_${field.name} = ${field.propName}"
    }
}

/* field variable init from src builder */
func getFieldVarInitSrc2(field: FieldDescriptorProto) {
    match {
        case field.label == LABEL_REPEATED => getFieldVarInitSrc(field)
        case field.type_ == TYPE_MESSAGE => "p_${field.name} = PbMessage<${field.typeName}>(src.${field.propName})"
        case field.hasDefaultValue => let pn = field.propName; "p_${field.name} = if (src.${pn} != ${field.defaultValue}) { src.${pn} } else { None }"
        case _ => "p_${field.name} = src.${field.propName}"
    }
}

/* field is not empty expr */
func getFieldNoEmptyExpr2(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return "!${field.propName}.isEmpty()"
    }

    if (field.type_ == TYPE_MESSAGE) {
        return "let Some(_v) <- p_${field.name}.data"
    }

    return "let Some(_v) <- p_${field.name}"
}

/* field clear expr */
func getFieldClearExpr2(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return "${field.propName}.clear()"
    }

    if (field.type_ == TYPE_MESSAGE) {
        return "p_${field.name}.removeFrom(this)"
    }

    return "p_${field.name} = None"
}

/* field size expr */
func getFieldSizeExpr2(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return getFieldSizeExpr(field)
    }

    return "_x += ${tagSize(UInt32(field.number))} + " + namedSize("_v", field)
}

/* field hashCode expr */
func getFieldHashExpr2(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return "_x.write(${field.propName}.hashCode())"
    }

    let arg = match (field.type_) {
        case TYPE_BYTES | TYPE_STRING | TYPE_MESSAGE | TYPE_ENUM => "_v.hashCode()"
        case _ => "_v"
    }

    return "_x.write(${arg})"
}

/* field unpack expr */
func getFieldUnpackExpr2(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return getFieldUnpackExpr(field)
    }

    if (field.type_ == TYPE_MESSAGE) {
        return "p_${field.name}.getOrDefault(this).unpack(subReader(src))"
    }

    if (field.hasDefaultValue) {
        return namedParseSrc(field.propName, "src", field)
    }

    return namedParseSrc("p_${field.name}", "src", field)
}

/* normal field mut prop expr */
func getFieldPropVarExpr2(field: FieldDescriptorProto) {
    if (!field.hasDefaultValue) {
        return "get() { p_${field.name}.getOrThrow() } set(_x) { p_${field.name} = _x; markDirty() }"
    }

    return "get() { p_${field.name} ?? ${field.defaultValue} } set(_x) { p_${field.name} = if (_x == ${field.defaultValue}) { None } else { _x }; markDirty() }"
}

/* message class and member variable define */
func genCodeMessageFieldClass2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("public class ${typeName} <: MessageLite & TypedMessage<${typeName}> {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("    ${getFieldVarDefine2(field)}\n")
    }

    for ((name, _) in helper.oneofDecl) {
        append("    private var p_${name}: ${typeName}_Oneof_${titleCase(name)}\n")
    }
}

/* message init */
func genCodeMessageFieldInit2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    /* init with named params */
    append("\n    public init(")
    var flag = false
    for (field in fields where !field.hasOneofIndex) {
        if (flag) { append(",\n") } else { flag = true; append("\n") }
        append("        ${field.propName}!: ${getFieldVarDefault2(field)}")
    }

    for ((name, _) in helper.oneofDecl) {
        if (flag) { append(",\n") } else { flag = true; append("\n") }
        append("        ${getMessagePropName(name)}!: ${typeName}_Oneof_${titleCase(name)} = ${typeName}_Oneof_${titleCase(name)}.None")
    }

    if (flag) {
        append("\n    ")
    }
    append(") {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("        this.${getFieldVarInit2(field)}\n")
    }

    for ((name, _) in helper.oneofDecl) {
        append("        this.p_${name} = ${getMessagePropName(name)}\n")
    }

    append("        m_init()\n")
    append("    }\n")

    /* init from builder */
    append("\n    public init(src: ${typeName}__Builder) {\n")
    for (field in fields where !field.hasOneofIndex) {
        append("        this.${getFieldVarInitSrc2(field)}\n")
    }

    for ((name, _) in helper.oneofDecl) {
        append("        this.p_${name} = src.${getMessagePropName(name)}\n")
    }

    append("        m_init()\n")
    append("    }\n")

    /* m_init */
    append("\n    private func m_init() {\n")

    for (field in fields where !field.hasOneofIndex) {
        if (field.label == LABEL_REPEATED) {
            append("        m_init(${field.propName})\n")
        } else if (field.type_ == TYPE_MESSAGE) {
            append("        if (let Some(_v) <- p_${field.name}.data) { m_init(_v) }\n")
        }
    }

    for ((name, _) in helper.oneofDecl) {
        append("        m_init(${getMessagePropName(name)})\n")
    }

    append("        m_innerInit()\n")
    append("    }\n")
}

/* message props define */
func genCodeMessageFieldProps2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    // normal field props
    for (field in fields where !field.hasOneofIndex && field.label != LABEL_REPEATED) {
        let uName = titleCase(field.name)
        let pName = "p_${field.name}"

        append("\n")
        if (field.type_ == TYPE_MESSAGE) {
            append("    public func clear${uName}() { ${pName}.removeFrom(this); markDirty() }\n")
            append("    public prop has${uName}: Bool { get() { isPresent(${pName}.data) } }\n")
            append("    public mut prop ${field.propName}: ${field.typeName} { get() { ${pName}.data.getOrThrow() } set(_v) { ${pName}.set(this, _v); markDirty() } }\n")
        } else {
            append("    public func clear${uName}() { ${pName} = None; markDirty() }\n")
            append("    public prop has${uName}: Bool { get() { isPresent(${pName}) } }\n")
            append("    public mut prop ${field.propName}: ${typeConvert(field)} { ${getFieldPropVarExpr2(field)} }\n")
        }
    }

    // oneof field props
    for ((name, ofields) in helper.oneofDecl) {
        append("\n")
        append("    public mut prop ${getMessagePropName(name)}: ${typeName}_Oneof_${titleCase(name)} { get() { p_${name} } set(_v) { m_assign(p_${name}, _v); p_${name} = _v; markDirty() } }\n")
        for (field in ofields) {
            append("\n")
            append("    public prop has${titleCase(field.name)}: Bool { get() { match(p_${name}) { case ${enumCase(field.name)}(_) => true case _ => false } } }\n")
            append("    public mut prop ${field.propName}: ${typeConvert(field)} { get() { ${getFieldOneofPropGetExpr(name, field)} } set(_v) { ${getFieldOneofPropSetExpr(typeName, name, field)} } }\n")
        }
    }
}

/* message m_size */
func genCodeMessageFieldSize2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_size(): Int64 {\n")
    append("        var _x = 0\n")

    /* normal fields size */
    for (field in fields where !field.hasOneofIndex) {
        append("        if (${getFieldNoEmptyExpr2(field)}) { ${getFieldSizeExpr2(field)} }\n")
    }

    /* oneof fields size */
    for ((name, ofields) in helper.oneofDecl) {
        append("        match (p_${name}) {\n")
        for (field in ofields) {
            append("            case ${enumCase(field.name)}(_v) => _x += ${tagSize(UInt32(field.number))} + ${namedSize("_v", field)}\n")
        }
        append("            case _ => ()\n        }\n")
    }

    append("        return _x\n")
    append("    }\n")
}

/* message m_hashCode */
func genCodeMessageFieldHash2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_hashCode(): Int64 {\n")
    append("        var _x = DefaultHasher()\n")

    /* normal fields hashCode */
    for (field in fields where !field.hasOneofIndex) {
        append("        if (${getFieldNoEmptyExpr2(field)}) { ${getFieldHashExpr2(field)} }\n")
    }

    /* oneof fields hashCode */
    for ((name, ofields) in helper.oneofDecl) {
        append("        if (!p_${name}.isEmpty()) { _x.write(p_${name}.hashCode()) }\n")
    }

    append("        return _x.finish()\n")
    append("    }\n")
}

/* message m_isEmpty */
func genCodeMessageFieldIsEmpty2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper) {
    let append: (String) -> Unit = helper.outbuf.append
    let sepOut = LineSepOut(helper.outbuf, sep: " &&", sn: 8)

    append("\n")
    append("    protected func m_isEmpty(): Bool {\n")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        sepOut.append(match {
            case field.label == LABEL_REPEATED => "${field.propName}.isEmpty()"
            case field.type_ == TYPE_MESSAGE => "isNone(p_${field.name}.data)"
            case _ => "isNone(p_${field.name})"
        })
    }

    /* oneof fields */
    for ((name, _) in helper.oneofDecl) {
        sepOut.append("p_${name}.isEmpty()")
    }

    append("\n")
    append("    }\n")
}

/* message m_clear */
func genCodeMessageFieldClear2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_clear(): Unit {\n")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        append("        ${getFieldClearExpr2(field)}\n")
    }

    /* oneof fields */
    for ((name, _) in helper.oneofDecl) {
        append("        m_assign(p_${name}); p_${name} = None\n")
    }

    append("    }\n")
}

/* message == != */
func genCodeMessageFieldEquat2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper) {
    let append: (String) -> Unit = helper.outbuf.append
    let sepOut = LineSepOut(helper.outbuf, sep: " &&", sn: 8)

    append("\n")
    append("    public operator func !=(src: ${typeName}): Bool { !(this == src) }\n")
    append("    public operator func ==(src: ${typeName}): Bool {\n")
    /* common pre compare */
    sepOut.append("hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        sepOut.append(match {
            case field.label == LABEL_REPEATED => "${field.propName} == src.${field.propName}"
            case field.type_ == TYPE_MESSAGE => "p_${field.name}.data == src.p_${field.name}.data"
            case _ => "p_${field.name} == src.p_${field.name}"
        })
    }

    /* oneof fields */
    for ((name, _) in helper.oneofDecl) {
        sepOut.append("p_${name} == src.p_${name}")
    }

    append("\n")
    append("    }\n")
}

/* message mergeFrom */
func genCodeMessageFieldMergeFrom2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func mergeFrom(src: ${typeName}): Unit {\n")

    /* normal fields hashCode */
    for (field in fields where !field.hasOneofIndex) {
        if (field.label == LABEL_REPEATED) {
            let name = field.propName
            let mergeFunc = if (field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">")) { "putAll" } else { "appendAll" }
            append("        if (!src.${name}.isEmpty()) { ${name}.${mergeFunc}(src.${name}) }\n")
        } else if (field.type_ == TYPE_MESSAGE) {
            append("        if (let Some(_v) <- src.p_${field.name}.data) { p_${field.name}.getOrDefault(this).mergeFrom(_v) }\n")
        } else {
            append("        if (let Some(_v) <- src.p_${field.name}) { p_${field.name} = _v }\n")
        }
    }

    /* oneof fields hashCode */
    for ((name, ofields) in helper.oneofDecl) {
        append("        if (!src.p_${name}.isEmpty()) { ${getMessagePropName(name)} = src.p_${name}.clone() }\n")
    }

    append("        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }\n")
    append("        markDirty()\n")
    append("    }\n")
}

/* message copyFrom */
func genCodeMessageFieldCopyFrom2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func copyFrom(src: ${typeName}): ${typeName} {\n")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        let name = field.propName
        let pName = "p_${field.name}"

        if (field.label == LABEL_REPEATED) {
            append("        ${name}.copyFrom(src.${name})\n")
        } else if (field.type_ == TYPE_MESSAGE) {
            append("        ${pName}.copyFrom(this, src.${pName}.data)\n")
        } else {
            append("        ${pName} = src.${pName}\n")
        }
    }

    /* oneof fields */
    for ((name, _) in helper.oneofDecl) {
        append("        m_assign(p_${name}); p_${name} = m_init(src.p_${name}.clone())\n")
    }

    append("        m_innerCopyFrom(src)\n")
    append("        return this\n")
    append("    }\n")
}

/* message unpack */
func genCodeMessageFieldUnpack2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func unpack<T>(src: T): Unit where T <: BytesReader {\n")
    append("        while (!src.isEmpty()) {\n")
    append("            let _x = src.parseTag()\n")
    append("            match (_x[0]) {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("                case ${field.number} => ${getFieldUnpackExpr2(field)}\n")
    }

    for ((name, ofields) in helper.oneofDecl) {
        for (field in ofields) {
            append("                case ${field.number} => ${getOneofFieldUnapckExpr(typeName, name, field)}\n")
        }
    }

    append("                case _ => m_unknown(src, _x)\n")
    append("            }\n")
    append("        }\n")
    append("        markDirty()\n")
    append("    }\n")
}

/* message check */
func genCodeMessageFieldCheck2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func check(): Unit /* throws RequiredFieldNotSetException */ {\n")

    for (field in fields where !field.hasOneofIndex && field.label == LABEL_REQUIRED && field.hasDefaultValue == false) {
        let empty = if (field.type_ == TYPE_MESSAGE) {
            "isNone(p_${field.name}.data)"
        } else {
            "isNone(p_${field.name})"
        }
        append("        if (${empty}) { throw RequiredFieldNotSetException(\"${field.name}\") }\n")
    }

    append("    }\n")
}

/* message pack */
func genCodeMessageFieldPack2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func pack<T>(out: T): Unit where T <: BytesWriter {\n")
    append("        check()\n")

    for (field in fields where !field.hasOneofIndex) {
        if (field.label == LABEL_REPEATED) {
            append("        if (!${field.propName}.isEmpty()) { ${getFieldPackExpr(field)} }\n")
        } else {
            append("        if (${getFieldNoEmptyExpr2(field)}) { ${namedPack("_v", field)} }\n")
        }
    }

    for ((name, ofields) in helper.oneofDecl) {
        append("        match (p_${name}) {\n")
        for (field in ofields) {
            append("            case ${enumCase(field.name)}(_v) => ${namedPack("_v", field)}\n")
        }
        append("            case _ => ()\n")
        append("        }\n")
    }
    append("        m_unknown(out)\n")
    append("    }\n")
}

/* message toString */
func genCodeMessageFieldToString2(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func toString(): String {\n")
    append("        var _x = StructPrinter()\n")

    for (field in fields where !field.hasOneofIndex) {
        if (field.label == LABEL_REPEATED) {
            let name = field.propName
            append("        if (!${name}.isEmpty()) { _x.append(\"${field.name}\", ${name}) }\n")
        } else {
            append("        if (${getFieldNoEmptyExpr2(field)}) { _x.append(\"${field.name}\", _v) }\n")
        }
    }

    for ((name, ofields) in helper.oneofDecl) {
        append("        if (!p_${name}.isEmpty()) { _x.append(p_${name}.which(), p_${name}) }\n")
    }

    append("        return _x.done().toString()\n")
    append("    }\n")
}

/* message builder */
func genCodeMessageBuilder2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("public class ${typeName}__Builder {\n")

    for (field in fields where !field.hasOneofIndex) {
        let pName = field.propName
        let type_ = match {
            case field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">") => "Array<(${field.typeName[field.typeName.indexOf("<").getOrThrow() + 1 .. field.typeName.size - 1]})>"
            case field.label == LABEL_REPEATED && field.type_ == TYPE_BYTES => "Array<Bytes>"
            case field.label == LABEL_REPEATED => "Array<${typeConvert(field)}>"
            case _ => "${typeConvert(field)}"
        }
        append("    public var ${pName}: ${getFieldVarDefault2(field)}\n")
        append("    public func set${titleCase(field.name)}(${pName}: ${type_}) { this.${pName} = ${pName}; return this }\n\n")
    }

    for ((name, _) in helper.oneofDecl) {
        let pName = getMessagePropName(name)
        let type_ = "${typeName}_Oneof_${titleCase(name)}"
        append("    public var ${pName} = ${type_}.None\n")
        append("    public func set${titleCase(name)}(${pName}: ${type_}) { this.${pName} = ${pName}; return this }\n\n")
    }

    append("    public func build() { ${typeName}(this) }\n")
    append("}\n")
}

/* gen proto2 message codes */
func genCodeMessageField2(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    // class and member variable define
    genCodeMessageFieldClass2(typeName, fields, helper)

    // init define
    genCodeMessageFieldInit2(typeName, fields, helper)

    // props define
    genCodeMessageFieldProps2(typeName, fields, helper)

    // func m_size
    genCodeMessageFieldSize2(fields, helper)

    // func m_hashCode
    genCodeMessageFieldHash2(fields, helper)

    // func m_isEmpty
    genCodeMessageFieldIsEmpty2(fields, helper)

    // func m_clear
    genCodeMessageFieldClear2(fields, helper)

    // operator == !=
    genCodeMessageFieldEquat2(typeName, fields, helper)

    // func mergeFrom
    genCodeMessageFieldMergeFrom2(typeName, fields, helper)

    // func copyFrom
    genCodeMessageFieldCopyFrom2(typeName, fields, helper)

    // func clone
    genCodeMessageFieldClone(typeName, helper)

    // func unpack
    genCodeMessageFieldUnpack2(typeName, fields, helper)

    // func check
    genCodeMessageFieldCheck2(fields, helper)

    // func pack
    genCodeMessageFieldPack2(fields, helper)

    // func toString
    genCodeMessageFieldToString2(fields, helper)

    // impl interface
    append(getImplIterfaceApi(typeName))

    // end
    append("}\n")

    // message builder
    genCodeMessageBuilder2(typeName, fields, helper)
}
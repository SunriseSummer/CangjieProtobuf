/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
// gencode for proto3

package protoc

/* field variable define */
func getFieldVarDefine(field: FieldDescriptorProto) {
    match {
        case field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">") => "public let ${field.propName}: ${field.typeName}"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_MESSAGE => "public let ${field.propName}: RepeatedMessage<${field.shortTypeName}>"
        case field.label == LABEL_REPEATED => "public let ${field.propName}: RepeatedField<${typeConvert(field)}>"
        case field.type_ == TYPE_MESSAGE => "private var p_${field.name}: PbMessage<${field.shortTypeName}>"
        case _ => "private var p_${field.name}: ${typeConvert(field)}"
    }
}

/* field variable default */
func getFieldVarDefault(field: FieldDescriptorProto) {
    match {
        case field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">") => "Array<(${field.typeName[field.typeName.indexOf("<").getOrThrow() + 1 .. field.typeName.size - 1]})> = []"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_BYTES => "Array<Bytes> = []"
        case field.label == LABEL_REPEATED => "Array<${typeConvert(field)}> = []"
        case field.type_ == TYPE_MESSAGE => "?${field.shortTypeName} = None"
        case _ => "${typeConvert(field)} = ${initValue(field)}"
    }
}

/* field variable init */
func getFieldVarInit(field: FieldDescriptorProto) {
    let name = field.propName
    match {
        case field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">") => "${name} = ${field.typeName}(${name})"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_MESSAGE => "${name} = RepeatedMessage<${field.shortTypeName}>(${name})"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_BYTES => "${name} = RepeatedField<BytesSlice>(${name}.size) { _i => BytesSlice(${name}[_i]) }"
        case field.label == LABEL_REPEATED => "${name} = RepeatedField<${typeConvert(field)}>(${name})"
        case field.type_ == TYPE_MESSAGE => "p_${field.name} = PbMessage<${field.shortTypeName}>(${name})"
        case _ => "p_${field.name} = ${name}"
    }
}

/* field variable init from src builder */
func getFieldVarInitSrc(field: FieldDescriptorProto) {
    let name = field.propName
    match {
        case field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">") => "${name} = ${field.typeName}(src.${name})"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_MESSAGE => "${name} = RepeatedMessage<${field.shortTypeName}>(src.${name})"
        case field.label == LABEL_REPEATED && field.type_ == TYPE_BYTES => "${name} = RepeatedField<BytesSlice>(src.${name}.size) { _i => BytesSlice(src.${name}[_i]) }"
        case field.label == LABEL_REPEATED => "${name} = RepeatedField<${typeConvert(field)}>(src.${name})"
        case field.type_ == TYPE_MESSAGE => "p_${field.name} = PbMessage(src.${name})"
        case _ => "p_${field.name} = src.${name}"
    }
}

/* field is not empty expr */
func getFieldNoEmptyExpr(field: FieldDescriptorProto) {
    /* repeated fields */
    if (field.label == LABEL_REPEATED) {
        return "!${field.propName}.isEmpty()"
    }

    if (field.type_ == TYPE_MESSAGE) {
        return "let Some(_v) <- p_${field.name}.nonEmptyData()"
    }

    /* normal fields */
    namedNoEmpty("p_${field.name}", field)
}

/* field clear expr */
func getFieldClearExpr(field: FieldDescriptorProto) {
    /* repeated fields */
    if (field.label == LABEL_REPEATED) {
        return "${field.propName}.clear()"
    }

    let pName = "p_${field.name}"

    /* normal fields */
    match (field.type_) {
        case TYPE_DOUBLE | TYPE_FLOAT => "${pName} = .0"
        case TYPE_BOOL => "${pName} = false"
        case TYPE_ENUM => "${pName} = ${field.shortTypeName}.empty()"
        case TYPE_MESSAGE => "${pName}.removeFrom(this)"
        case TYPE_STRING => "${pName} = \"\""
        case TYPE_BYTES => "${pName} = BytesSlice()"
        case _ => "${pName} = 0"
    }
}

/* field size expr */
func getFieldSizeExpr(field: FieldDescriptorProto) {
    let name = field.propName
    let tsize = tagSize(UInt32(field.number))

    /* map */
    if (field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">")) {
        let ek = field.mapEntry[0]
        let ev = field.mapEntry[1]
        return "for ((_k, _v) in ${name}) { var _s = 0; if (${namedNoEmpty("_k", ek)}) { _s += 1 + ${namedSize("_k", ek)} }; if (${namedNoEmpty("_v", ev)}) { _s += 1 + ${namedSize("_v", ev)} }; _x += ${tsize} + varintSize(_s) + _s }"
    }

    /* normal fields */
    if (field.label != LABEL_REPEATED) {
        return "_x += ${tsize} + " + match (field.type_) {
            case TYPE_MESSAGE => "binSize(_v)"
            case _ => namedSize("p_${field.name}", field)
        }
    }

    /* packed repeated fields */
    if (field.hasOptions && field.options.hasPacked && field.options.packed) {
        return match (field.type_) {
            case TYPE_BOOL => "let _s = ${name}.size"
            case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "let _s = 8 * ${name}.size"
            case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "let _s = 4 * ${name}.size"
            case TYPE_SINT32 | TYPE_SINT64 => "var _s = 0; for (_i in ${name}) { _s += sintSize(_i) }"
            case _ => "var _s = 0; for (_i in ${name}) { _s += varintSize(_i) }"
        } + "; _x += ${tsize} + varintSize(_s) + _s"
    }

    /* repeated fields */
    match (field.type_) {
        case TYPE_BOOL => "_x += (${tsize} + 1) * ${name}.size"
        case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "_x += (${tsize} + 8) * ${name}.size"
        case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "_x += (${tsize} + 4) * ${name}.size"
        case TYPE_BYTES | TYPE_STRING | TYPE_MESSAGE => "for (_i in ${name}) { _x += ${tsize} + binSize(_i) }"
        case TYPE_SINT32 | TYPE_SINT64 => "for (_i in ${name}) { _x += ${tsize} + sintSize(_i) }"
        case _ => "for (_i in ${name}) { _x += ${tsize} + varintSize(_i) }"
    }
}

/* field hashCode expr */
func getFieldHashExpr(field: FieldDescriptorProto) {
    if (field.label == LABEL_REPEATED) {
        return "_x.write(${field.propName}.hashCode())"
    }

    let arg = match (field.type_) {
        case TYPE_BYTES | TYPE_STRING | TYPE_ENUM => "p_${field.name}.hashCode()"
        case TYPE_MESSAGE => "_v.hashCode()"
        case _ => "p_${field.name}"
    }

    return "_x.write(${arg})"
}

/* field pack expr */
func getFieldPackExpr(field: FieldDescriptorProto) {
    let name = field.propName

    /* map */
    if (field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">")) {
        let ek = field.mapEntry[0]
        let ev = field.mapEntry[1]
        return "for ((_k, _v) in ${name}) { ${packTagOut(field.number, PREFIXED)}; var _s = 0; if (${namedNoEmpty("_k", ek)}) { _s += 1 + ${namedSize("_k", ek)} }; if (${namedNoEmpty("_v", ev)}) { _s += 1 + ${namedSize("_v", ev)} }; out.packVarint(_s); if (${namedNoEmpty("_k", ek)}) { ${namedPack("_k", ek)} }; if (${namedNoEmpty("_v", ev)}) { ${namedPack("_v", ev)} } }"
    }

    /* normal fields */
    if (field.label != LABEL_REPEATED) {
        return match (field.type_) {
            case TYPE_MESSAGE => "${packTagOut(field.number, PREFIXED)}; out.packVarint(_v.size); _v.pack(out)"
            case _ => namedPack("p_${field.name}", field)
        }
    }

    /* packed repeated fields */
    if (field.hasOptions && field.options.hasPacked && field.options.packed) {
        return "${packTagOut(field.number, PREFIXED)}; " + match (field.type_) {
            case TYPE_BOOL => "out.packVarint(${name}.size); for (_i in ${name}) { out.packBool(_i) }"
            case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "out.packVarint(8 * ${name}.size); for (_i in ${name}) { out.packFixed(_i) }"
            case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "out.packVarint(4 * ${name}.size); for (_i in ${name}) { out.packFixed(_i) }"
            case TYPE_SINT32 | TYPE_SINT64 => "var _s = 0; for (_i in ${name}) { _s += sintSize(_i) }; out.packVarint(_s); for (_i in ${name}) { out.packSInt(_i) }"
            case _ => "var _s = 0; for (_i in ${name}) { _s += varintSize(_i) }; out.packVarint(_s); for (_i in ${name}) { out.packVarint(_i) }"
        }
    }

    /* repeated fields */
    match (field.type_) {
        case TYPE_BOOL => "for (_i in ${name}) { ${packTagOut(field.number, VARINT)}; out.packBool(_i) }"
        case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "for (_i in ${name}) { ${packTagOut(field.number, BIT64)}; out.packFixed(_i) }"
        case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "for (_i in ${name}) { ${packTagOut(field.number, BIT32)}; out.packFixed(_i) }"
        case TYPE_STRING | TYPE_BYTES => "for (_i in ${name}) { ${packTagOut(field.number, PREFIXED)}; out.packBin(_i) }"
        case TYPE_MESSAGE => "for (_i in ${name}) { ${packTagOut(field.number, PREFIXED)}; out.packVarint(_i.size); _i.pack(out) }" /* for performance */
        case TYPE_SINT32 | TYPE_SINT64 => "for (_i in ${name}) { ${packTagOut(field.number, VARINT)}; out.packSInt(_i) }"
        case _ => "for (_i in ${name}) { ${packTagOut(field.number, VARINT)}; out.packVarint(_i) }"
    }
}

/* field unpack expr */
func getFieldUnpackExpr(field: FieldDescriptorProto) {
    let name: String = field.propName

    /* map */
    if (field.type_ == TYPE_MESSAGE && field.typeName.endsWith(">")) {
        let ek = field.mapEntry[0]
        let ev = field.mapEntry[1]
        return "let _s = subReader(src); " +
        "var _k = ${initValue(ek)}; " +
        "var _v = ${initValue(ev)}; " +
        "while (!_s.isEmpty()) { " +
            "match (_s.parseTag()[0]) { " +
                "case 1 => ${namedParseSrc("_k", "_s", ek)} " +
                "case 2 => ${namedParseSrc("_v", "_s", ev)} " +
                "case _ => throw ParseValueExecption(\"map\") " +
            "} " +
        "}; " +
        "s_add(${name}, _k, _v)"
    }

    /* normal fields */
    if (field.label != LABEL_REPEATED) {
        return match (field.type_) {
            case TYPE_MESSAGE => "p_${field.name}.getOrDefault(this).unpack(subReader(src))"
            case _ => namedParseSrc("p_${field.name}", "src", field)
        }
    }

    /* repeated fields */
    return match (field.type_) {
        case TYPE_MESSAGE => "s_add(${name}, src)"
        case TYPE_STRING => "s_add(${name}, src.parseString())"
        case TYPE_BYTES => "s_add(${name}, src.parseBytesSlice())"
        /* packable repeated fields */
        case _ => getRepeatedFieldsUnpackExpr(field, name)
    }
}

/* packable repeated fields */
func getRepeatedFieldsUnpackExpr(field: FieldDescriptorProto, name: String): String {
    /* packed repeated fields */
    let packed = "let _s = subReader(src); while (!_s.isEmpty()) { s_add(${name}, " +
    match (field.type_) {
        case TYPE_DOUBLE => "_s.parseFloat64()"
        case TYPE_FLOAT => "_s.parseFloat32()"
        case TYPE_INT64 => "_s.parseInt64()"
        case TYPE_UINT64 => "_s.parseUInt64()"
        case TYPE_INT32 => "_s.parseInt32()"
        case TYPE_UINT32 => "_s.parseUInt32()"
        case TYPE_ENUM => "${field.shortTypeName}.parse(_s.parseInt32())"
        case TYPE_BOOL => "_s.parseBool()"
        case TYPE_FIXED64 => "_s.parseFixed64()"
        case TYPE_FIXED32 => "_s.parseFixed32()"
        case TYPE_SFIXED32 => "_s.parseSFixed32()"
        case TYPE_SFIXED64 => "_s.parseSFixed64()"
        case TYPE_SINT32 => "_s.parseSInt32()"
        case TYPE_SINT64 => "_s.parseSInt64()"
        case _ => throw Exception("UNSUPPORTED TYPE")
    } + ") }"

    /* repeated fields */
    let repeated = "s_add(${name}, " +
    match (field.type_) {
        case TYPE_DOUBLE => "src.parseFloat64()"
        case TYPE_FLOAT => "src.parseFloat32()"
        case TYPE_INT64 => "src.parseInt64()"
        case TYPE_UINT64 => "src.parseUInt64()"
        case TYPE_INT32 => "src.parseInt32()"
        case TYPE_UINT32 => "src.parseUInt32()"
        case TYPE_ENUM => "${field.shortTypeName}.parse(src.parseInt32())"
        case TYPE_BOOL => "src.parseBool()"
        case TYPE_FIXED64 => "src.parseFixed64()"
        case TYPE_FIXED32 => "src.parseFixed32()"
        case TYPE_SFIXED32 => "src.parseSFixed32()"
        case TYPE_SFIXED64 => "src.parseSFixed64()"
        case TYPE_SINT32 => "src.parseSInt32()"
        case TYPE_SINT64 => "src.parseSInt64()"
        case _ => throw Exception("UNSUPPORTED TYPE")
    } + ")"

    return "if (_x[1] == PREFIXED) { ${packed} } else { ${repeated} }"
}

/* oneof field prop get expr */
func getFieldOneofPropGetExpr(name: String, field: FieldDescriptorProto) {
    "match (p_${name}) { " +
        "case ${enumCase(field.name)}(_v) => _v " +
        "case _ => throw UnexpectedOneofException() " +
    "}"
}

/* oneof field prop set expr */
func getFieldOneofPropSetExpr(typeName: String, name: String, field: FieldDescriptorProto) {
    let set = "p_${name} = ${typeName}_Oneof_${titleCase(name)}.${enumCase(field.name)}(_v)"

    if (field.type_ == TYPE_MESSAGE) {
        return "m_assign(p_${name}, _v); ${set}; markDirty()"
    }

    return "m_assign(p_${name}); ${set}; markDirty()"
}

/* message class and member variable define */
func genCodeMessageFieldClass(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("public class ${typeName} <: MessageLite & TypedMessage<${typeName}> {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("    ${getFieldVarDefine(field)}\n")
    }

    for ((name, _) in helper.oneofDecl) {
        append("    private var p_${name}: ${typeName}_Oneof_${titleCase(name)}\n")
    }
}

/* message init */
func genCodeMessageFieldInit(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    /* init with named params */
    append("\n    public init(")
    var flag = false
    for (field in fields where !field.hasOneofIndex) {
        if (flag) { append(",\n") } else { flag = true; append("\n") }
        append("        ${field.propName}!: ${getFieldVarDefault(field)}")
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
        append("        this.${getFieldVarInit(field)}\n")
    }

    for ((name, _) in helper.oneofDecl) {
        append("        this.p_${name} = ${getMessagePropName(name)}\n")
    }

    append("        m_init()\n")
    append("    }\n")

    /* init from builder */
    append("\n    public init(src: ${typeName}__Builder) {\n")
    for (field in fields where !field.hasOneofIndex) {
        append("        this.${getFieldVarInitSrc(field)}\n")
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
        append("        m_init(p_${name})\n")
    }

    append("        m_innerInit()\n")
    append("    }\n")
}

/* message props define */
func genCodeMessageFieldProps(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    // normal field props
    for (field in fields where !field.hasOneofIndex && field.label != LABEL_REPEATED) {
        let name = field.propName
        let pName = "p_${field.name}"

        append("\n")
        if (field.type_ == TYPE_MESSAGE) {
            append("    public mut prop ${name}: ${field.shortTypeName} { get() { ${pName}.getOrDefault(this) } set(_v) { ${pName}.set(this, _v); markDirty() } }\n")
        } else {
            append("    public mut prop ${name}: ${typeConvert(field)} { get() { ${pName} } set(_v) { ${pName} = _v; markDirty() } }\n")
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
func genCodeMessageFieldSize(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_size(): Int64 {\n")
    append("        var _x = 0\n")

    /* normal fields size */
    for (field in fields where !field.hasOneofIndex) {
        append("        if (${getFieldNoEmptyExpr(field)}) { ${getFieldSizeExpr(field)} }\n")
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
func genCodeMessageFieldHash(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_hashCode(): Int64 {\n")
    append("        var _x = DefaultHasher()\n")

    /* normal fields hashCode */
    for (field in fields where !field.hasOneofIndex) {
        append("        if (${getFieldNoEmptyExpr(field)}) { ${getFieldHashExpr(field)} }\n")
    }

    /* oneof fields hashCode */
    for ((name, ofields) in helper.oneofDecl) {
        append("        if (!p_${name}.isEmpty()) { _x.write(p_${name}.hashCode()) }\n")
    }

    append("        return _x.finish()\n")
    append("    }\n")
}

/* message m_isEmpty */
func genCodeMessageFieldIsEmpty(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper) {
    let append: (String) -> Unit = helper.outbuf.append
    let sepOut = LineSepOut(helper.outbuf, sep: " &&", sn: 8)

    append("\n")
    append("    protected func m_isEmpty(): Bool {\n")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        sepOut.append(if (field.label == LABEL_REPEATED) {
            "${field.propName}.isEmpty()"
        } else {
            let pName = "p_${field.name}"
            match (field.type_) {
                case TYPE_DOUBLE | TYPE_FLOAT => "${pName} == .0"
                case TYPE_BOOL => "${pName} == false"
                case TYPE_ENUM | TYPE_MESSAGE | TYPE_STRING | TYPE_BYTES => "${pName}.isEmpty()"
                case _ => "${pName} == 0"
            }
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
func genCodeMessageFieldClear(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    protected func m_clear(): Unit {\n")

    /* normal fields */
    for (field in fields where !field.hasOneofIndex) {
        append("        ${getFieldClearExpr(field)}\n")
    }

    /* oneof fields */
    for ((name, _) in helper.oneofDecl) {
        append("        m_assign(p_${name}); p_${name} = None\n")
    }

    append("    }\n")
}

/* message == != */
func genCodeMessageFieldEquat(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper) {
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
func genCodeMessageFieldMergeFrom(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
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
            append("        if (${namedNoEmpty("src.p_${field.name}", field)}) { p_${field.name} = src.p_${field.name} }\n")
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
func genCodeMessageFieldCopyFrom(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
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

/* message clone */
func genCodeMessageFieldClone(typeName: String, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func clone(): ${typeName} {\n")
    append("        return ${typeName}().copyFrom(this)\n")
    append("    }\n")
}

/* message unpack */
func genCodeMessageFieldUnpack(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func unpack<T>(src: T): Unit where T <: BytesReader {\n")
    append("        while (!src.isEmpty()) {\n")
    append("            let _x = src.parseTag()\n")
    append("            match (_x[0]) {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("                case ${field.number} => ${getFieldUnpackExpr(field)}\n")
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

/* message pack */
func genCodeMessageFieldPack(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func pack<T>(out: T): Unit where T <: BytesWriter {\n")

    for (field in fields where !field.hasOneofIndex) {
        append("        if (${getFieldNoEmptyExpr(field)}) { ${getFieldPackExpr(field)} }\n")
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
func genCodeMessageFieldToString(fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    append("\n")
    append("    public func toString(): String {\n")
    append("        var _x = StructPrinter()\n")

    for (field in fields where !field.hasOneofIndex) {
        let str = match {
            case field.label == LABEL_REPEATED => field.propName
            case field.type_ == TYPE_MESSAGE => "_v"
            case _ => "p_${field.name}"
        }
        append("        if (${getFieldNoEmptyExpr(field)}) { _x.append(\"${field.name}\", ${str}) }\n")
    }

    for ((name, ofields) in helper.oneofDecl) {
        append("        if (!p_${name}.isEmpty()) { _x.append(p_${name}.which(), p_${name}) }\n")
    }

    append("        return _x.done().toString()\n")
    append("    }\n")
}

/* message builder */
func genCodeMessageBuilder(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
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
        append("    public var ${pName}: ${getFieldVarDefault(field)}\n")
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

/* gen proto3 message codes */
func genCodeMessageField(typeName: String, fields: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append

    // class and member variable define
    genCodeMessageFieldClass(typeName, fields, helper)

    // init define
    genCodeMessageFieldInit(typeName, fields, helper)

    // props define
    genCodeMessageFieldProps(typeName, fields, helper)

    // func m_size
    genCodeMessageFieldSize(fields, helper)

    // func m_hashCode
    genCodeMessageFieldHash(fields, helper)

    // func m_isEmpty
    genCodeMessageFieldIsEmpty(fields, helper)

    // func m_clear
    genCodeMessageFieldClear(fields, helper)

    // operator == !=
    genCodeMessageFieldEquat(typeName, fields, helper)

    // func mergeFrom
    genCodeMessageFieldMergeFrom(typeName, fields, helper)

    // func copyFrom
    genCodeMessageFieldCopyFrom(typeName, fields, helper)

    // func clone
    genCodeMessageFieldClone(typeName, helper)

    // func unpack
    genCodeMessageFieldUnpack(typeName, fields, helper)

    // func pack
    genCodeMessageFieldPack(fields, helper)

    // func toString
    genCodeMessageFieldToString(fields, helper)

    // impl interface
    append(getImplIterfaceApi(typeName))

    // message end
    append("}\n")

    // message builder
    genCodeMessageBuilder(typeName, fields, helper)
}
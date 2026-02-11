/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file about: protoc
 */
package protoc

internal import google.protobuf.*
internal import google.protobuf.compiler.*
internal import protobuf.*
internal import std.collection.*
internal import std.unicode.*

/**
 * The Function is cj_generator
 *
 * @param inbuf of ArrayList<UInt8>
 * @param outbuf of ArrayList<UInt8>
 *
 * @return Type of Unit
 * @since 0.29.3
 */
public func cj_generator(input: Array<UInt8>): Array<UInt8> {
    let req = CodeGeneratorRequest()
    req.unpack(input)

    let resp = CodeGeneratorResponse()

    // A collection of files that need to generate code
    let genfiles = HashSet<String>()
    for (path in req.fileToGenerate) {
        genfiles.add(path)
    }

    let filePackage = HashMap<String, String>()
    // Processing files that require code generation
    for (desc in req.protoFile) {
        if(!desc.hasPackage){
            desc.package_ = "default"
        }
        filePackage[desc.name] = desc.package_

        if (!genfiles.contains(desc.name)) {
            continue
        }

        // get dependency
        let deps = HashSet<String>()
        for (dep in desc.dependency) {
            deps.add(filePackage[dep])
        }

        // generate file
        fileProcess(desc, deps, resp.file.add())
    }

    resp.pack()
}

/* Get dest filename */
func getDestFileName(package_: String, fileName: String): String {
    let pbName = fileName.replace(".proto", ".pb.cj")
    if (package_ == "") {
        return pbName
    }

    return "${package_.replace(".", "/")}/${pbName}"
}

class LineSepOut {
    LineSepOut (
        let outbuf: StringBuilder,
        let sep!: String = ",",     // Separator
        let sn!: Int64 = 8,         // Number of spaces automatically added to a new line
        let ln!: Int64 = 120 - sep.size    // One line limit characters
    ) {
        ss = " " * sn
        cn = sn
    }

    let ss: String
    var cn: Int64
    var first = true

    /* Append s */
    func append(s: String) {
        if (first) {
            cn += s.size
            outbuf.append(ss)
            outbuf.append(s)
            first = false
            return
        }
        // Not the first, append separator
        cn += sep.size
        outbuf.append(sep)
        // Judge whether line feed is required
        if (cn + 1 + s.size > ln) {
            cn = sn + s.size
            outbuf.append('\n')
            outbuf.append(ss)
            outbuf.append(s)
        } else {
            cn += 1 + s.size
            outbuf.append(' ')
            outbuf.append(s)
        }
    }
}

/* save or process context of every proto file */
class GenCodeHelper {
    /* Get type name based on nesting level */
    let nested = ArrayList<String>()
    func nestedPush(name: String) { nested.add(name) }
    func nestedPop() { nested.remove(at: nested.size - 1) }
    func getNestedTypeName(name: String) {
        if (nested.isEmpty()) { return name }
        let sb = StringBuilder()
        for (n in nested) {
            sb.append(n)
            sb.append('_')
        }
        sb.append(name)
        sb.toString()
    }

    /* proto file outbuf */
    let outbuf = StringBuilder()
    /* package prefix of the proto file */
    let pkgPrefix: String
    /* all packages prefix */
    let packages = ArrayList<String>()

    /* file level gencode context. */
    GenCodeHelper (package_: String, deps: HashSet<String>, fileName: String,
        let proto2: Bool
    ) {
        pkgPrefix = if (package_ == "") { "." } else { ".${package_}." }

        /* proc and check deps */
        deps.remove(package_)
        deps.remove("protobuf")
        if (package_ == "protobuf" && !deps.isEmpty()) {
            /* Dependency on external packages is not allowed in protobuf packages, and circular dependency on packages is not allowed in Cangjie */
            throw Exception("CIRCULAR DEPENDENCY")
        }

        packages.add(pkgPrefix)
        for (pkg in deps) { packages.add(".${pkg}.") }
        packages.sortBy { a, b => if (a == b) { Ordering.EQ } else if (a < b) { Ordering.GT } else { Ordering.LT } }
    }

    /* set enum/message type name */
    func setFieldsTypeName(fields: RepeatedMessage<FieldDescriptorProto>): Unit {
        for (f in fields) {
            f.name = lowerCamelCase(f.name)
            match (f.type_) {
                case TYPE_ENUM => f.typeName = getTypeName(f.typeName)
                case TYPE_MESSAGE => f.typeName = getMessageTypeName(f)
                case _ => ()
            }
        }
    }

    /* set options */
    func setFieldsOptions(fields: RepeatedMessage<FieldDescriptorProto>): Unit {
        if (proto2) {
            return
        }

        for (f in fields where f.label == LABEL_REPEATED) {
            match (f.type_) {
                case TYPE_BYTES | TYPE_MESSAGE | TYPE_STRING | TYPE_GROUP => continue
                case _ => ()
            }

            if (!f.hasOptions) {
                f.options = FieldOptions(packed: true)
                continue
            }

            if (!f.options.hasPacked) {
                f.options.packed = true
            }
        }
    }

    public func getTypeName(typeName: String) {
        for (p in packages where typeName.startsWith(p)) {
            if (p == pkgPrefix) {
                return String.join(typeName[p.size ..].split("."), delimiter: "_")
            }
            return p[1 ..] + String.join(typeName[p.size ..].split("."), delimiter: "_")
        }
        throw Exception("INVALID TYPE NAME")
    }

    // special process type_ message if it is a map
    private func getMessageTypeName(f: FieldDescriptorProto): String {
        if (f.mapEntry.isEmpty()) {
            /* normal message field */
            return getTypeName(f.typeName)
        }

        setFieldsTypeName(f.mapEntry)

        let mapTypeName = if (f.mapEntry[1].type_ == TYPE_MESSAGE) { "MapMessage" } else { "MapField" }
        "${mapTypeName}<${typeConvert(f.mapEntry[0])}, ${typeConvert(f.mapEntry[1])}>"
    }

    let oneofDecl = ArrayList<(String, RepeatedMessage<FieldDescriptorProto>)>()
    func calcOneofDecl(decls: RepeatedMessage<OneofDescriptorProto>, fields: RepeatedMessage<FieldDescriptorProto>) {
        oneofDecl.clear()
        for (decl in decls) {
            decl.name = lowerCamelCase(decl.name)
            oneofDecl.add((decl.name, RepeatedMessage<FieldDescriptorProto>()))
        }
        for (field in fields where field.hasOneofIndex) {
            oneofDecl[Int64(field.oneofIndex)][1].append(field)
        }
    }
}

extend DescriptorProto {
    func isMapEntry(): Bool {
        hasOptions && options.hasMapEntry && options.mapEntry
    }
}

func preProcMapEntry(fields: RepeatedMessage<FieldDescriptorProto>, nestedType: RepeatedMessage<DescriptorProto>): Unit {
    for (field in fields where field.type_ == TYPE_MESSAGE && field.label == LABEL_REPEATED) {
        let entryName = "${titleCase(lowerCamelCase(field.name))}Entry"
        if (!field.typeName.endsWith(entryName)) {
            continue
        }

        // looking for entry in nestedtype
        for (n in nestedType) {
            // other nested message
            if (n.field.size != 2 || n.name != entryName) {
                continue
            }

            // not map entry
            if (!n.isMapEntry()) {
                break
            }

            // save map entry's fields
            field.mapEntry.copyFrom(n.field)
        }
    }
}

func fileProcess(desc: FileDescriptorProto, deps: HashSet<String>, file: CodeGeneratorResponse_File) {
    // Destination file path
    if (!desc.hasPackage) { desc.package_ = "" }
    if (!desc.hasSyntax) { desc.syntax = "proto2" }

    let fileName = desc.name[(desc.name.lastIndexOf("/") ?? -1) + 1 .. ]
    let proto2 = desc.syntax == "proto2"
    let helper = GenCodeHelper(desc.package_, deps, fileName, proto2)

    // Header information
    genCodeHeader(desc, deps, helper)

    // all message
    for (msg in desc.messageType) {
        genCodeMessage(msg, helper)
    }

    // all enum
    for (e in desc.enumType) {
        genCodeEnum(e, helper)
    }

    // all service
    for (ser in desc.service) {
        genCodeService(ser, helper)
    }

    // all extension
    for (ext in desc.extension) {
        genCodeExtension(ext, helper)
    }

    // Target file content
    file.content = helper.outbuf.toString()
    file.name = getDestFileName(desc.package_, fileName)
}

func genCodeHeader(desc: FileDescriptorProto, deps: HashSet<String>, helper: GenCodeHelper): Unit {
    let append: (String) -> Unit = helper.outbuf.append
    // package
    if (desc.package_ != "") { append("package ${desc.package_}\n\n") }
    // import
    append("import std.collection.*\n")
    if (desc.package_ != "protobuf") {
        append("import protobuf.*\n")
    }
    for (pkg in deps) {
        append("import ${pkg} as pkg_${pkg.replace(".","_")}\n")
        append("import ${pkg}.*\n")
    }
}

func genCodeMessageExtension(typeName: String, extensions: RepeatedMessage<FieldDescriptorProto>, helper: GenCodeHelper): Unit {
    // todo
}

func genCodeMessage(msg: DescriptorProto, helper: GenCodeHelper): Unit {
    let typeName = helper.getNestedTypeName(msg.name)
    let fields = msg.field
    let extensions = msg.extension

    // nested push
    helper.nestedPush(msg.name)

    // gen nested message
    for (m in msg.nestedType) { genCodeMessage(m, helper) }

    // gen nested enum
    for (e in msg.enumType) { genCodeEnum(e, helper) }

    // nested pop
    helper.nestedPop()

    // pre-process map entry
    preProcMapEntry(fields, msg.nestedType)

    // no generating map code
    if (msg.isMapEntry()) { return }

    // set enum/message/map type name
    helper.setFieldsTypeName(fields)

    // set options
    helper.setFieldsOptions(fields)

    // preprocess oneof decl
    helper.calcOneofDecl(msg.oneofDecl, fields)

    // fields
    match {
        case fields.isEmpty() => helper.outbuf.append(getImplEmptyMessage(typeName))
        case helper.proto2 => genCodeMessageField2(typeName, fields, helper)
        case _ => genCodeMessageField(typeName, fields, helper)
    }

    // extensions
    genCodeMessageExtension(typeName, extensions, helper)

    // oneof group enum
    genCodeOneofGroup(typeName, helper)

    // todo extension range
    // todo reserved range
}

func genCodeEnum(e: EnumDescriptorProto, helper: GenCodeHelper): Unit {
    let typeName = helper.getNestedTypeName(e.name)
    let values = e.value
    let append: (String) -> Unit = helper.outbuf.append
    let sepOut = LineSepOut(helper.outbuf, sep: " |", sn: 4)

    // enum items
    append("\npublic enum ${typeName} <: Enum<${typeName}> {\n")
    for (v in values) { sepOut.append("${getEnumItemName(v.name)}") }
    append("\n\n")

    // value
    append("    public func value(): Int32 {\n        match(this) {\n")
    for (v in values) { append("            case ${getEnumItemName(v.name)} => ${v.number}\n") }
    append("        }\n    }\n")

    // toString
    append("\n    public func toString(): String {\n        match(this) {\n")
    for (v in values) { append("            case ${getEnumItemName(v.name)} => \"${v.name}\"\n") }
    append("        }\n    }\n")

    // operator ==
    append("\n    public operator func==(value: ${typeName}) {\n        match((this, value)) {\n")
    for (v in values) { append("            case (${getEnumItemName(v.name)}, ${getEnumItemName(v.name)}) => true\n") }
    append("            case _ => false\n        }\n    }\n")

    // isEmpty & empty
    if (!helper.proto2) {
        append("\n    public func isEmpty() { match (this) { case ${getEnumItemName(values[0].name)} => true case _ => false } }\n")
        append("\n    public static func empty(): ${typeName} { ${getEnumItemName(values[0].name)} }\n")
    }

    // parse
    append("\n    public static func parse(value: Int32): ${typeName} {\n        match(value) {\n")
    for (v in values) { append("            case ${v.number} => ${getEnumItemName(v.name)}\n") }
    append("            case _ => throw InvalidEnumValueException(\"${typeName}\", value)\n        }\n    }\n")

    // parse, from string
    append("\n    public static func parse(value: String): ${typeName} {\n        match(value) {\n")
    for (v in values) { append("            case \"${v.name}\" => ${getEnumItemName(v.name)}\n") }
    append("            case _ => throw UnmatchedEnumStringException(\"${typeName}\", value)\n        }\n    }\n")

    // done
    append("}\n")
}

func genCodeService(ser: ServiceDescriptorProto, helper: GenCodeHelper): Unit {
    // ignore
}

func genCodeExtension(ext: FieldDescriptorProto, helper: GenCodeHelper): Unit {
    // todo
}

/* gen oneof group type define (enum) */
func genCodeOneofGroup(typeName: String, helper: GenCodeHelper): Unit {
    for ((name, fields) in helper.oneofDecl) {
        let append: (String) -> Unit = helper.outbuf.append
        let sepOut = LineSepOut(helper.outbuf, sep: " |", sn: 4)
        let groupType = "${typeName}_Oneof_${titleCase(name)}"

        append("\npublic enum ${groupType} <: OneofGroup & Equatable<${groupType}> {\n")
        for (f in fields) { sepOut.append("${enumCase(f.name)}(${typeConvert(f)})") }
        sepOut.append("None\n\n")

        // gen clone()
        append("    public func clone(): ${groupType} {\n        match (this) {\n")
        for (field in fields where field.type_ == TYPE_MESSAGE) { append("            case ${enumCase(field.name)}(v) => ${groupType}.${enumCase(field.name)}(v.clone())\n") }
        append("            case _ => this\n        }\n    }\n\n")

        // gen mutableData()
        append("    public func mutableData(): ?MessageLite {\n        match (this) {\n")
        for (field in fields where field.type_ == TYPE_MESSAGE) { append("            case ${enumCase(field.name)}(v) => v\n") }
        append("            case _ => Option<MessageLite>.None\n        }\n    }\n\n")

        // gen isEmpty()
        append(getImplOneofGroupIsEmpty())

        // operator == !=
        append("    public operator func !=(that: ${groupType}): Bool { !(this == that) }\n")
        append("    public operator func ==(that: ${groupType}): Bool {\n        match ((this, that)) {\n")
        for (field in fields) { append("            case (${enumCase(field.name)}(v1), ${enumCase(field.name)}(v2)) => v1 == v2\n") }
        append("            case (None, None) => true\n            case _ => false\n        }\n    }\n\n")

        // gen toString()
        append("    public func toString() {\n        match (this) {\n")
        for (field in fields) { append("            case ${enumCase(field.name)}(v) => ${if (field.type_ == TYPE_STRING) { "\"\\\"\${v}\\\"\"" } else { "v.toString()" }}\n") }
        append("            case None => \"\"\n        }\n    }\n\n")

        // gen hashCode()
        append("    public func hashCode(): Int64 {\n        match (this) {\n")
        for (field in fields) { append("            case ${enumCase(field.name)}(v) => v.hashCode()\n") }
        append("            case None => 0\n        }\n    }\n\n")

        // gen which()
        append("    public func which() {\n        match (this) {\n")
        for (field in fields) { append("            case ${enumCase(field.name)}(_) => \"${field.name}\"\n") }
        append("            case None => \"\"\n        }\n    }\n")

        // done
        append("}\n")
    }
}

/* oneof unpack expr */
func getOneofFieldUnapckExpr(typeName: String, name: String, field: FieldDescriptorProto) {
    "${getMessagePropName(name)} = ${typeName}_Oneof_${titleCase(name)}.${enumCase(field.name)}(" + match (field.type_) {
        case TYPE_DOUBLE => "src.parseFloat64()"
        case TYPE_FLOAT => "src.parseFloat32()"
        case TYPE_INT64 => "src.parseInt64()"
        case TYPE_UINT64 => "src.parseUInt64()"
        case TYPE_INT32 => "src.parseInt32()"
        case TYPE_UINT32 => "src.parseUInt32()"
        case TYPE_ENUM => "${field.shortTypeName}.parse(src.parseInt32())"
        case TYPE_BOOL => "src.parseBool()"
        case TYPE_STRING => "src.parseString()"
        case TYPE_MESSAGE => "${field.shortTypeName}.fromBytes(subReader(src))"
        case TYPE_BYTES => "src.parseBytesSlice()"
        case TYPE_FIXED64 => "src.parseFixed64()"
        case TYPE_FIXED32 => "src.parseFixed32()"
        case TYPE_SFIXED32 => "src.parseSFixed32()"
        case TYPE_SFIXED64 => "src.parseSFixed64()"
        case TYPE_SINT32 => "src.parseSInt32()"
        case TYPE_SINT64 => "src.parseSInt64()"
        case _ => throw Exception("UNSUPPORTED TYPE")
    } + ")"
}

/* impl oneof group isEmpty */
func getImplOneofGroupIsEmpty() {
"""
    public func isEmpty(): Bool {
        match (this) {
            case None => true
            case _ => false
        }
    }

"""
}

/* impl interface api */
func getImplIterfaceApi(typeName: String) {
"""

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ${typeName}() }
    public static func newBuilder() { ${typeName}__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ${typeName}(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ${typeName}(); _x.unpack(src); _x }
"""
}

/* convert pb type to cj type */
func typeConvert(field: FieldDescriptorProto) {
    match (field.type_) {
        case TYPE_DOUBLE => "Float64"
        case TYPE_FLOAT => "Float32"
        case TYPE_INT64 => "Int64"
        case TYPE_UINT64 => "UInt64"
        case TYPE_INT32 => "Int32"
        case TYPE_UINT32 => "UInt32"
        case TYPE_ENUM => "${field.shortTypeName}"
        case TYPE_BOOL => "Bool"
        case TYPE_STRING => "String"
        case TYPE_MESSAGE => "${field.shortTypeName}"
        case TYPE_BYTES => "BytesSlice"
        case TYPE_FIXED64 => "UInt64"
        case TYPE_FIXED32 => "UInt32"
        case TYPE_SFIXED32 => "Int32"
        case TYPE_SFIXED64 => "Int64"
        case TYPE_SINT32 => "Int32"
        case TYPE_SINT64 => "Int64"
        case _ => throw Exception("UNSUPPORTED TYPE")
    }
}

/* typed init value */
func initValue(field: FieldDescriptorProto) {
    match (field.type_) {
        case TYPE_DOUBLE => ".0"
        case TYPE_FLOAT => "Float32(.0)"
        case TYPE_INT64 => "0"
        case TYPE_UINT64 => "UInt64(0)"
        case TYPE_INT32 => "Int32(0)"
        case TYPE_UINT32 => "UInt32(0)"
        case TYPE_ENUM => "${field.shortTypeName}.empty()"
        case TYPE_BOOL => "false"
        case TYPE_STRING => "\"\""
        case TYPE_MESSAGE => "${field.shortTypeName}()"
        case TYPE_BYTES => "BytesSlice()"
        case TYPE_FIXED64 => "UInt64(0)"
        case TYPE_FIXED32 => "UInt32(0)"
        case TYPE_SFIXED32 => "Int32(0)"
        case TYPE_SFIXED64 => "0"
        case TYPE_SINT32 => "Int32(0)"
        case TYPE_SINT64 => "0"
        case _ => throw Exception("UNSUPPORTED TYPE")
    }
}

/* pack tag out */
func packTagOut(number: Int32, typ: WireNum) {
    if (number <= 15) {
        return "out.append(${UInt8(number) << 3 | typ})"
    }

    return "out.packTag(${number}, ${WireType.parse(typ)})"
}

/* named no empty */
func namedNoEmpty(name: String, field: FieldDescriptorProto) {
    match (field.type_) {
        case TYPE_DOUBLE | TYPE_FLOAT => "${name} != .0"
        case TYPE_BOOL => "${name}"
        case TYPE_ENUM | TYPE_MESSAGE | TYPE_STRING | TYPE_BYTES => "!${name}.isEmpty()"
        case _ => "${name} != 0"
    }
}

/* named size */
func namedSize(name: String, field: FieldDescriptorProto) {
    match (field.type_) {
        case TYPE_BOOL => "1"
        case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "8"
        case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "4"
        case TYPE_BYTES | TYPE_STRING | TYPE_MESSAGE => "binSize(${name})"
        case TYPE_SINT32 | TYPE_SINT64 => "sintSize(${name})"
        case _ => "varintSize(${name})"
    }
}

/* named pack */
func namedPack(name: String, field: FieldDescriptorProto) {
    match (field.type_) {
        case TYPE_BOOL => "${packTagOut(field.number, VARINT)}; out.packBool(${name})"
        case TYPE_DOUBLE | TYPE_FIXED64 | TYPE_SFIXED64 => "${packTagOut(field.number, BIT64)}; out.packFixed(${name})"
        case TYPE_FIXED32 | TYPE_SFIXED32 | TYPE_FLOAT => "${packTagOut(field.number, BIT32)}; out.packFixed(${name})"
        case TYPE_BYTES | TYPE_STRING => "${packTagOut(field.number, PREFIXED)}; out.packBin(${name})"
        case TYPE_MESSAGE => "${packTagOut(field.number, PREFIXED)}; out.packVarint(${name}.size); ${name}.pack(out)" /* for performance */
        case TYPE_SINT32 | TYPE_SINT64 => "${packTagOut(field.number, VARINT)}; out.packSInt(${name})"
        case _ => "${packTagOut(field.number, VARINT)}; out.packVarint(${name})"
    }
}

/* named parse src */
func namedParseSrc(name: String, src: String, field: FieldDescriptorProto) {
    name + match (field.type_) {
        case TYPE_DOUBLE => " = ${src}.parseFloat64()"
        case TYPE_FLOAT => " = ${src}.parseFloat32()"
        case TYPE_INT64 => " = ${src}.parseInt64()"
        case TYPE_UINT64 => " = ${src}.parseUInt64()"
        case TYPE_INT32 => " = ${src}.parseInt32()"
        case TYPE_UINT32 => " = ${src}.parseUInt32()"
        case TYPE_ENUM => " = ${field.shortTypeName}.parse(${src}.parseInt32())"
        case TYPE_BOOL => " = ${src}.parseBool()"
        case TYPE_STRING => " = ${src}.parseString()"
        case TYPE_MESSAGE => ".unpack(subReader(${src}))"
        case TYPE_BYTES => " = ${src}.parseBytesSlice()"
        case TYPE_FIXED64 => " = ${src}.parseFixed64()"
        case TYPE_FIXED32 => " = ${src}.parseFixed32()"
        case TYPE_SFIXED32 => " = ${src}.parseSFixed32()"
        case TYPE_SFIXED64 => " = ${src}.parseSFixed64()"
        case TYPE_SINT32 => " = ${src}.parseSInt32()"
        case TYPE_SINT64 => " = ${src}.parseSInt64()"
        case _ => throw Exception("UNSUPPORTED TYPE")
    }
}

/* impl empty message */
func getImplEmptyMessage(typeName: String) {
"""

public class ${typeName} <: MessageLite & TypedMessage<${typeName}> {
    public init() { m_innerInit() }
    protected func m_size(): Int64 { 0 }
    protected func m_hashCode(): Int64 { 0 }
    protected func m_isEmpty(): Bool { true }
    protected func m_clear(): Unit { }
    public operator func !=(src: ${typeName}): Bool { !(this == src) }
    public operator func ==(src: ${typeName}): Bool { hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields }
    public func mergeFrom(src: ${typeName}): Unit { if(!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) } }
    public func copyFrom(src: ${typeName}): ${typeName} { m_innerCopyFrom(src); return this }
    public func clone(): ${typeName} { return ${typeName}().copyFrom(this) }
    public func unpack<T>(src: T): Unit where T <: BytesReader { while (!src.isEmpty()) { m_unknown(src, src.parseTag()) }; markDirty() }
    public func pack<T>(out: T): Unit where T <: BytesWriter { m_unknown(out) }
    public func toString(): String { "{}" }
    public func packi(out: BytesWriter) { pack(out) }
    public func unpacki(src: BytesReader) { unpack(src) }

    public static func empty() { ${typeName}() }
    public static func fromBytes(src: Collection<Byte>) { let m = ${typeName}(); m.unpack(src); m }
    public static func fromBytes(src: BytesReader) { let m = ${typeName}(); m.unpack(src); m }
}
"""
}

/* Define reserved words */
let cangjieKeyWords = HashSet<String>([
    "abstract", "as", "break", "case", "catch", "class", "continue", "do",
    "else", "enum", "extend", "false", "finally", "for", "foreign", "from",
    "func", "if", "import", "in", "init", "interface", "is", "let", "macro",
    "match", "mut", "open", "operator", "override", "package", "private",
    "prop", "protected", "public", "quote", "record", "redef", "return",
    "spawn", "static", "super", "synchronized", "this", "throw", "true", "try",
    "type", "This", "unsafe", "var", "where", "while"
])
let protobufRsvdWords = HashSet<String>([
    "protobuf", "protoc", "toString", "toJson", "isEmpty", "empty"
])
let messageRsvdWords = HashSet<String>([
    "size", "clear", "clone", "unpack", "pack", "check", "packi", "unpacki",
    "fromBytes", "fromJson", "src", "out"
])
let enumRsvdWords = HashSet<String>([
    "value", "parse"
])

func getEnumItemName(name: String) {
    if (cangjieKeyWords.contains(name) || enumRsvdWords.contains(name)) {
        return name + "_"
    }

    return name
}

func getMessagePropName(name: String) {
    if (cangjieKeyWords.contains(name) || messageRsvdWords.contains(name)) {
        return name + "_"
    }

    return name
}

func titleCase(str: String) {
    "${Rune(str[0]).toUpperCase()}${str[1 ..]}"
}

func enumCase(str: String) {
    str.toAsciiUpper()
}

/* lower camel case */
func lowerCamelCase(name: String) {
    let arr = "${Rune(name[0]).toLowerCase()}${name[1 ..]}".split("_")

    for (i in 1..arr.size where !arr[i].isEmpty()) {
        arr[i] = titleCase(arr[i])
    }

    return String.join(arr)
}

extend FieldDescriptorProto {
    prop propName: String { get() {
        getMessagePropName(name)
    } }
}
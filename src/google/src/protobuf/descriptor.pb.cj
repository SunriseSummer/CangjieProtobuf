/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package google.protobuf

import std.collection.*
import protobuf.*

public class FileDescriptorSet <: MessageLite & TypedMessage<FileDescriptorSet> {
    public let file: RepeatedMessage<FileDescriptorProto>

    public init(
        file!: Array<FileDescriptorProto> = []
    ) {
        this.file = RepeatedMessage<FileDescriptorProto>(file)
        m_init()
    }

    public init(src: FileDescriptorSet__Builder) {
        this.file = RepeatedMessage<FileDescriptorProto>(src.file)
        m_init()
    }

    private func m_init() {
        m_init(file)
        m_innerInit()
    }

    protected func m_size(): Int64 {
        var _x = 0
        if (!file.isEmpty()) { for (_i in file) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!file.isEmpty()) { _x.write(file.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        file.isEmpty()
    }

    protected func m_clear(): Unit {
        file.clear()
    }

    public operator func !=(src: FileDescriptorSet): Bool { !(this == src) }
    public operator func ==(src: FileDescriptorSet): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && file == src.file
    }

    public func mergeFrom(src: FileDescriptorSet): Unit {
        if (!src.file.isEmpty()) { file.appendAll(src.file) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FileDescriptorSet): FileDescriptorSet {
        file.copyFrom(src.file)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FileDescriptorSet {
        return FileDescriptorSet().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => s_add(file, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!file.isEmpty()) { for (_i in file) { out.append(10); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!file.isEmpty()) { _x.append("file", file) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FileDescriptorSet() }
    public static func newBuilder() { FileDescriptorSet__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FileDescriptorSet(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FileDescriptorSet(); _x.unpack(src); _x }
}

public class FileDescriptorSet__Builder {
    public var file: Array<FileDescriptorProto> = []
    public func setFile(file: Array<FileDescriptorProto>) { this.file = file; return this }

    public func build() { FileDescriptorSet(this) }
}

public class FileDescriptorProto <: MessageLite & TypedMessage<FileDescriptorProto> {
    private var p_name: ?String
    private var p_package: ?String
    public let dependency: RepeatedField<String>
    public let publicDependency: RepeatedField<Int32>
    public let weakDependency: RepeatedField<Int32>
    public let messageType: RepeatedMessage<DescriptorProto>
    public let enumType: RepeatedMessage<EnumDescriptorProto>
    public let service: RepeatedMessage<ServiceDescriptorProto>
    public let extension: RepeatedMessage<FieldDescriptorProto>
    private var p_options: PbMessage<FileOptions>
    private var p_sourceCodeInfo: PbMessage<SourceCodeInfo>
    private var p_syntax: ?String

    public init(
        name!: ?String = None,
        package_!: ?String = None,
        dependency!: Array<String> = [],
        publicDependency!: Array<Int32> = [],
        weakDependency!: Array<Int32> = [],
        messageType!: Array<DescriptorProto> = [],
        enumType!: Array<EnumDescriptorProto> = [],
        service!: Array<ServiceDescriptorProto> = [],
        extension!: Array<FieldDescriptorProto> = [],
        options!: ?FileOptions = None,
        sourceCodeInfo!: ?SourceCodeInfo = None,
        syntax!: ?String = None
    ) {
        this.p_name = name
        this.p_package = package_
        this.dependency = RepeatedField<String>(dependency)
        this.publicDependency = RepeatedField<Int32>(publicDependency)
        this.weakDependency = RepeatedField<Int32>(weakDependency)
        this.messageType = RepeatedMessage<DescriptorProto>(messageType)
        this.enumType = RepeatedMessage<EnumDescriptorProto>(enumType)
        this.service = RepeatedMessage<ServiceDescriptorProto>(service)
        this.extension = RepeatedMessage<FieldDescriptorProto>(extension)
        this.p_options = PbMessage<FileOptions>(options)
        this.p_sourceCodeInfo = PbMessage<SourceCodeInfo>(sourceCodeInfo)
        this.p_syntax = syntax
        m_init()
    }

    public init(src: FileDescriptorProto__Builder) {
        this.p_name = src.name
        this.p_package = src.package_
        this.dependency = RepeatedField<String>(src.dependency)
        this.publicDependency = RepeatedField<Int32>(src.publicDependency)
        this.weakDependency = RepeatedField<Int32>(src.weakDependency)
        this.messageType = RepeatedMessage<DescriptorProto>(src.messageType)
        this.enumType = RepeatedMessage<EnumDescriptorProto>(src.enumType)
        this.service = RepeatedMessage<ServiceDescriptorProto>(src.service)
        this.extension = RepeatedMessage<FieldDescriptorProto>(src.extension)
        this.p_options = PbMessage<FileOptions>(src.options)
        this.p_sourceCodeInfo = PbMessage<SourceCodeInfo>(src.sourceCodeInfo)
        this.p_syntax = src.syntax
        m_init()
    }

    private func m_init() {
        m_init(dependency)
        m_init(publicDependency)
        m_init(weakDependency)
        m_init(messageType)
        m_init(enumType)
        m_init(service)
        m_init(extension)
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        if (let Some(_v) <- p_sourceCodeInfo.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearPackage() { p_package = None; markDirty() }
    public prop hasPackage: Bool { get() { isPresent(p_package) } }
    public mut prop package_: String { get() { p_package.getOrThrow() } set(_x) { p_package = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: FileOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    public func clearSourceCodeInfo() { p_sourceCodeInfo.removeFrom(this); markDirty() }
    public prop hasSourceCodeInfo: Bool { get() { isPresent(p_sourceCodeInfo.data) } }
    public mut prop sourceCodeInfo: SourceCodeInfo { get() { p_sourceCodeInfo.data.getOrThrow() } set(_v) { p_sourceCodeInfo.set(this, _v); markDirty() } }

    public func clearSyntax() { p_syntax = None; markDirty() }
    public prop hasSyntax: Bool { get() { isPresent(p_syntax) } }
    public mut prop syntax: String { get() { p_syntax.getOrThrow() } set(_x) { p_syntax = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_package) { _x += 1 + binSize(_v) }
        if (!dependency.isEmpty()) { for (_i in dependency) { _x += 1 + binSize(_i) } }
        if (!publicDependency.isEmpty()) { for (_i in publicDependency) { _x += 1 + varintSize(_i) } }
        if (!weakDependency.isEmpty()) { for (_i in weakDependency) { _x += 1 + varintSize(_i) } }
        if (!messageType.isEmpty()) { for (_i in messageType) { _x += 1 + binSize(_i) } }
        if (!enumType.isEmpty()) { for (_i in enumType) { _x += 1 + binSize(_i) } }
        if (!service.isEmpty()) { for (_i in service) { _x += 1 + binSize(_i) } }
        if (!extension.isEmpty()) { for (_i in extension) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_sourceCodeInfo.data) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_syntax) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_package) { _x.write(_v.hashCode()) }
        if (!dependency.isEmpty()) { _x.write(dependency.hashCode()) }
        if (!publicDependency.isEmpty()) { _x.write(publicDependency.hashCode()) }
        if (!weakDependency.isEmpty()) { _x.write(weakDependency.hashCode()) }
        if (!messageType.isEmpty()) { _x.write(messageType.hashCode()) }
        if (!enumType.isEmpty()) { _x.write(enumType.hashCode()) }
        if (!service.isEmpty()) { _x.write(service.hashCode()) }
        if (!extension.isEmpty()) { _x.write(extension.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_sourceCodeInfo.data) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_syntax) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_package) && dependency.isEmpty() && publicDependency.isEmpty() &&
        weakDependency.isEmpty() && messageType.isEmpty() && enumType.isEmpty() && service.isEmpty() &&
        extension.isEmpty() && isNone(p_options.data) && isNone(p_sourceCodeInfo.data) && isNone(p_syntax)
    }

    protected func m_clear(): Unit {
        p_name = None
        p_package = None
        dependency.clear()
        publicDependency.clear()
        weakDependency.clear()
        messageType.clear()
        enumType.clear()
        service.clear()
        extension.clear()
        p_options.removeFrom(this)
        p_sourceCodeInfo.removeFrom(this)
        p_syntax = None
    }

    public operator func !=(src: FileDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: FileDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_package == src.p_package && dependency == src.dependency &&
        publicDependency == src.publicDependency && weakDependency == src.weakDependency &&
        messageType == src.messageType && enumType == src.enumType && service == src.service &&
        extension == src.extension && p_options.data == src.p_options.data &&
        p_sourceCodeInfo.data == src.p_sourceCodeInfo.data && p_syntax == src.p_syntax
    }

    public func mergeFrom(src: FileDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_package) { p_package = _v }
        if (!src.dependency.isEmpty()) { dependency.appendAll(src.dependency) }
        if (!src.publicDependency.isEmpty()) { publicDependency.appendAll(src.publicDependency) }
        if (!src.weakDependency.isEmpty()) { weakDependency.appendAll(src.weakDependency) }
        if (!src.messageType.isEmpty()) { messageType.appendAll(src.messageType) }
        if (!src.enumType.isEmpty()) { enumType.appendAll(src.enumType) }
        if (!src.service.isEmpty()) { service.appendAll(src.service) }
        if (!src.extension.isEmpty()) { extension.appendAll(src.extension) }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_sourceCodeInfo.data) { p_sourceCodeInfo.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_syntax) { p_syntax = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FileDescriptorProto): FileDescriptorProto {
        p_name = src.p_name
        p_package = src.p_package
        dependency.copyFrom(src.dependency)
        publicDependency.copyFrom(src.publicDependency)
        weakDependency.copyFrom(src.weakDependency)
        messageType.copyFrom(src.messageType)
        enumType.copyFrom(src.enumType)
        service.copyFrom(src.service)
        extension.copyFrom(src.extension)
        p_options.copyFrom(this, src.p_options.data)
        p_sourceCodeInfo.copyFrom(this, src.p_sourceCodeInfo.data)
        p_syntax = src.p_syntax
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FileDescriptorProto {
        return FileDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => p_package = src.parseString()
                case 3 => s_add(dependency, src.parseString())
                case 10 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(publicDependency, _s.parseInt32()) } } else { s_add(publicDependency, src.parseInt32()) }
                case 11 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(weakDependency, _s.parseInt32()) } } else { s_add(weakDependency, src.parseInt32()) }
                case 4 => s_add(messageType, src)
                case 5 => s_add(enumType, src)
                case 6 => s_add(service, src)
                case 7 => s_add(extension, src)
                case 8 => p_options.getOrDefault(this).unpack(subReader(src))
                case 9 => p_sourceCodeInfo.getOrDefault(this).unpack(subReader(src))
                case 12 => p_syntax = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_package) { out.append(18); out.packBin(_v) }
        if (!dependency.isEmpty()) { for (_i in dependency) { out.append(26); out.packBin(_i) } }
        if (!publicDependency.isEmpty()) { for (_i in publicDependency) { out.append(80); out.packVarint(_i) } }
        if (!weakDependency.isEmpty()) { for (_i in weakDependency) { out.append(88); out.packVarint(_i) } }
        if (!messageType.isEmpty()) { for (_i in messageType) { out.append(34); out.packVarint(_i.size); _i.pack(out) } }
        if (!enumType.isEmpty()) { for (_i in enumType) { out.append(42); out.packVarint(_i.size); _i.pack(out) } }
        if (!service.isEmpty()) { for (_i in service) { out.append(50); out.packVarint(_i.size); _i.pack(out) } }
        if (!extension.isEmpty()) { for (_i in extension) { out.append(58); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_options.data) { out.append(66); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_sourceCodeInfo.data) { out.append(74); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_syntax) { out.append(98); out.packBin(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_package) { _x.append("package", _v) }
        if (!dependency.isEmpty()) { _x.append("dependency", dependency) }
        if (!publicDependency.isEmpty()) { _x.append("publicDependency", publicDependency) }
        if (!weakDependency.isEmpty()) { _x.append("weakDependency", weakDependency) }
        if (!messageType.isEmpty()) { _x.append("messageType", messageType) }
        if (!enumType.isEmpty()) { _x.append("enumType", enumType) }
        if (!service.isEmpty()) { _x.append("service", service) }
        if (!extension.isEmpty()) { _x.append("extension", extension) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        if (let Some(_v) <- p_sourceCodeInfo.data) { _x.append("sourceCodeInfo", _v) }
        if (let Some(_v) <- p_syntax) { _x.append("syntax", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FileDescriptorProto() }
    public static func newBuilder() { FileDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FileDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FileDescriptorProto(); _x.unpack(src); _x }
}

public class FileDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var package_: ?String = None
    public func setPackage(package_: String) { this.package_ = package_; return this }

    public var dependency: Array<String> = []
    public func setDependency(dependency: Array<String>) { this.dependency = dependency; return this }

    public var publicDependency: Array<Int32> = []
    public func setPublicDependency(publicDependency: Array<Int32>) { this.publicDependency = publicDependency; return this }

    public var weakDependency: Array<Int32> = []
    public func setWeakDependency(weakDependency: Array<Int32>) { this.weakDependency = weakDependency; return this }

    public var messageType: Array<DescriptorProto> = []
    public func setMessageType(messageType: Array<DescriptorProto>) { this.messageType = messageType; return this }

    public var enumType: Array<EnumDescriptorProto> = []
    public func setEnumType(enumType: Array<EnumDescriptorProto>) { this.enumType = enumType; return this }

    public var service: Array<ServiceDescriptorProto> = []
    public func setService(service: Array<ServiceDescriptorProto>) { this.service = service; return this }

    public var extension: Array<FieldDescriptorProto> = []
    public func setExtension(extension: Array<FieldDescriptorProto>) { this.extension = extension; return this }

    public var options: ?FileOptions = None
    public func setOptions(options: FileOptions) { this.options = options; return this }

    public var sourceCodeInfo: ?SourceCodeInfo = None
    public func setSourceCodeInfo(sourceCodeInfo: SourceCodeInfo) { this.sourceCodeInfo = sourceCodeInfo; return this }

    public var syntax: ?String = None
    public func setSyntax(syntax: String) { this.syntax = syntax; return this }

    public func build() { FileDescriptorProto(this) }
}

public class DescriptorProto_ExtensionRange <: MessageLite & TypedMessage<DescriptorProto_ExtensionRange> {
    private var p_start: ?Int32
    private var p_end: ?Int32
    private var p_options: PbMessage<ExtensionRangeOptions>

    public init(
        start!: ?Int32 = None,
        end!: ?Int32 = None,
        options!: ?ExtensionRangeOptions = None
    ) {
        this.p_start = start
        this.p_end = end
        this.p_options = PbMessage<ExtensionRangeOptions>(options)
        m_init()
    }

    public init(src: DescriptorProto_ExtensionRange__Builder) {
        this.p_start = src.start
        this.p_end = src.end
        this.p_options = PbMessage<ExtensionRangeOptions>(src.options)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearStart() { p_start = None; markDirty() }
    public prop hasStart: Bool { get() { isPresent(p_start) } }
    public mut prop start: Int32 { get() { p_start.getOrThrow() } set(_x) { p_start = _x; markDirty() } }

    public func clearEnd() { p_end = None; markDirty() }
    public prop hasEnd: Bool { get() { isPresent(p_end) } }
    public mut prop end: Int32 { get() { p_end.getOrThrow() } set(_x) { p_end = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: ExtensionRangeOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_start) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_end) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_start) { _x.write(_v) }
        if (let Some(_v) <- p_end) { _x.write(_v) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_start) && isNone(p_end) && isNone(p_options.data)
    }

    protected func m_clear(): Unit {
        p_start = None
        p_end = None
        p_options.removeFrom(this)
    }

    public operator func !=(src: DescriptorProto_ExtensionRange): Bool { !(this == src) }
    public operator func ==(src: DescriptorProto_ExtensionRange): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_start == src.p_start && p_end == src.p_end && p_options.data == src.p_options.data
    }

    public func mergeFrom(src: DescriptorProto_ExtensionRange): Unit {
        if (let Some(_v) <- src.p_start) { p_start = _v }
        if (let Some(_v) <- src.p_end) { p_end = _v }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: DescriptorProto_ExtensionRange): DescriptorProto_ExtensionRange {
        p_start = src.p_start
        p_end = src.p_end
        p_options.copyFrom(this, src.p_options.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): DescriptorProto_ExtensionRange {
        return DescriptorProto_ExtensionRange().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_start = src.parseInt32()
                case 2 => p_end = src.parseInt32()
                case 3 => p_options.getOrDefault(this).unpack(subReader(src))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_start) { out.append(8); out.packVarint(_v) }
        if (let Some(_v) <- p_end) { out.append(16); out.packVarint(_v) }
        if (let Some(_v) <- p_options.data) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_start) { _x.append("start", _v) }
        if (let Some(_v) <- p_end) { _x.append("end", _v) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { DescriptorProto_ExtensionRange() }
    public static func newBuilder() { DescriptorProto_ExtensionRange__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = DescriptorProto_ExtensionRange(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = DescriptorProto_ExtensionRange(); _x.unpack(src); _x }
}

public class DescriptorProto_ExtensionRange__Builder {
    public var start: ?Int32 = None
    public func setStart(start: Int32) { this.start = start; return this }

    public var end: ?Int32 = None
    public func setEnd(end: Int32) { this.end = end; return this }

    public var options: ?ExtensionRangeOptions = None
    public func setOptions(options: ExtensionRangeOptions) { this.options = options; return this }

    public func build() { DescriptorProto_ExtensionRange(this) }
}

public class DescriptorProto_ReservedRange <: MessageLite & TypedMessage<DescriptorProto_ReservedRange> {
    private var p_start: ?Int32
    private var p_end: ?Int32

    public init(
        start!: ?Int32 = None,
        end!: ?Int32 = None
    ) {
        this.p_start = start
        this.p_end = end
        m_init()
    }

    public init(src: DescriptorProto_ReservedRange__Builder) {
        this.p_start = src.start
        this.p_end = src.end
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public func clearStart() { p_start = None; markDirty() }
    public prop hasStart: Bool { get() { isPresent(p_start) } }
    public mut prop start: Int32 { get() { p_start.getOrThrow() } set(_x) { p_start = _x; markDirty() } }

    public func clearEnd() { p_end = None; markDirty() }
    public prop hasEnd: Bool { get() { isPresent(p_end) } }
    public mut prop end: Int32 { get() { p_end.getOrThrow() } set(_x) { p_end = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_start) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_end) { _x += 1 + varintSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_start) { _x.write(_v) }
        if (let Some(_v) <- p_end) { _x.write(_v) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_start) && isNone(p_end)
    }

    protected func m_clear(): Unit {
        p_start = None
        p_end = None
    }

    public operator func !=(src: DescriptorProto_ReservedRange): Bool { !(this == src) }
    public operator func ==(src: DescriptorProto_ReservedRange): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_start == src.p_start && p_end == src.p_end
    }

    public func mergeFrom(src: DescriptorProto_ReservedRange): Unit {
        if (let Some(_v) <- src.p_start) { p_start = _v }
        if (let Some(_v) <- src.p_end) { p_end = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: DescriptorProto_ReservedRange): DescriptorProto_ReservedRange {
        p_start = src.p_start
        p_end = src.p_end
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): DescriptorProto_ReservedRange {
        return DescriptorProto_ReservedRange().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_start = src.parseInt32()
                case 2 => p_end = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_start) { out.append(8); out.packVarint(_v) }
        if (let Some(_v) <- p_end) { out.append(16); out.packVarint(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_start) { _x.append("start", _v) }
        if (let Some(_v) <- p_end) { _x.append("end", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { DescriptorProto_ReservedRange() }
    public static func newBuilder() { DescriptorProto_ReservedRange__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = DescriptorProto_ReservedRange(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = DescriptorProto_ReservedRange(); _x.unpack(src); _x }
}

public class DescriptorProto_ReservedRange__Builder {
    public var start: ?Int32 = None
    public func setStart(start: Int32) { this.start = start; return this }

    public var end: ?Int32 = None
    public func setEnd(end: Int32) { this.end = end; return this }

    public func build() { DescriptorProto_ReservedRange(this) }
}

public class DescriptorProto <: MessageLite & TypedMessage<DescriptorProto> {
    private var p_name: ?String
    public let field: RepeatedMessage<FieldDescriptorProto>
    public let extension: RepeatedMessage<FieldDescriptorProto>
    public let nestedType: RepeatedMessage<DescriptorProto>
    public let enumType: RepeatedMessage<EnumDescriptorProto>
    public let extensionRange: RepeatedMessage<DescriptorProto_ExtensionRange>
    public let oneofDecl: RepeatedMessage<OneofDescriptorProto>
    private var p_options: PbMessage<MessageOptions>
    public let reservedRange: RepeatedMessage<DescriptorProto_ReservedRange>
    public let reservedName: RepeatedField<String>

    public init(
        name!: ?String = None,
        field!: Array<FieldDescriptorProto> = [],
        extension!: Array<FieldDescriptorProto> = [],
        nestedType!: Array<DescriptorProto> = [],
        enumType!: Array<EnumDescriptorProto> = [],
        extensionRange!: Array<DescriptorProto_ExtensionRange> = [],
        oneofDecl!: Array<OneofDescriptorProto> = [],
        options!: ?MessageOptions = None,
        reservedRange!: Array<DescriptorProto_ReservedRange> = [],
        reservedName!: Array<String> = []
    ) {
        this.p_name = name
        this.field = RepeatedMessage<FieldDescriptorProto>(field)
        this.extension = RepeatedMessage<FieldDescriptorProto>(extension)
        this.nestedType = RepeatedMessage<DescriptorProto>(nestedType)
        this.enumType = RepeatedMessage<EnumDescriptorProto>(enumType)
        this.extensionRange = RepeatedMessage<DescriptorProto_ExtensionRange>(extensionRange)
        this.oneofDecl = RepeatedMessage<OneofDescriptorProto>(oneofDecl)
        this.p_options = PbMessage<MessageOptions>(options)
        this.reservedRange = RepeatedMessage<DescriptorProto_ReservedRange>(reservedRange)
        this.reservedName = RepeatedField<String>(reservedName)
        m_init()
    }

    public init(src: DescriptorProto__Builder) {
        this.p_name = src.name
        this.field = RepeatedMessage<FieldDescriptorProto>(src.field)
        this.extension = RepeatedMessage<FieldDescriptorProto>(src.extension)
        this.nestedType = RepeatedMessage<DescriptorProto>(src.nestedType)
        this.enumType = RepeatedMessage<EnumDescriptorProto>(src.enumType)
        this.extensionRange = RepeatedMessage<DescriptorProto_ExtensionRange>(src.extensionRange)
        this.oneofDecl = RepeatedMessage<OneofDescriptorProto>(src.oneofDecl)
        this.p_options = PbMessage<MessageOptions>(src.options)
        this.reservedRange = RepeatedMessage<DescriptorProto_ReservedRange>(src.reservedRange)
        this.reservedName = RepeatedField<String>(src.reservedName)
        m_init()
    }

    private func m_init() {
        m_init(field)
        m_init(extension)
        m_init(nestedType)
        m_init(enumType)
        m_init(extensionRange)
        m_init(oneofDecl)
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_init(reservedRange)
        m_init(reservedName)
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: MessageOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (!field.isEmpty()) { for (_i in field) { _x += 1 + binSize(_i) } }
        if (!extension.isEmpty()) { for (_i in extension) { _x += 1 + binSize(_i) } }
        if (!nestedType.isEmpty()) { for (_i in nestedType) { _x += 1 + binSize(_i) } }
        if (!enumType.isEmpty()) { for (_i in enumType) { _x += 1 + binSize(_i) } }
        if (!extensionRange.isEmpty()) { for (_i in extensionRange) { _x += 1 + binSize(_i) } }
        if (!oneofDecl.isEmpty()) { for (_i in oneofDecl) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        if (!reservedRange.isEmpty()) { for (_i in reservedRange) { _x += 1 + binSize(_i) } }
        if (!reservedName.isEmpty()) { for (_i in reservedName) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (!field.isEmpty()) { _x.write(field.hashCode()) }
        if (!extension.isEmpty()) { _x.write(extension.hashCode()) }
        if (!nestedType.isEmpty()) { _x.write(nestedType.hashCode()) }
        if (!enumType.isEmpty()) { _x.write(enumType.hashCode()) }
        if (!extensionRange.isEmpty()) { _x.write(extensionRange.hashCode()) }
        if (!oneofDecl.isEmpty()) { _x.write(oneofDecl.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        if (!reservedRange.isEmpty()) { _x.write(reservedRange.hashCode()) }
        if (!reservedName.isEmpty()) { _x.write(reservedName.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && field.isEmpty() && extension.isEmpty() && nestedType.isEmpty() && enumType.isEmpty() &&
        extensionRange.isEmpty() && oneofDecl.isEmpty() && isNone(p_options.data) && reservedRange.isEmpty() &&
        reservedName.isEmpty()
    }

    protected func m_clear(): Unit {
        p_name = None
        field.clear()
        extension.clear()
        nestedType.clear()
        enumType.clear()
        extensionRange.clear()
        oneofDecl.clear()
        p_options.removeFrom(this)
        reservedRange.clear()
        reservedName.clear()
    }

    public operator func !=(src: DescriptorProto): Bool { !(this == src) }
    public operator func ==(src: DescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && field == src.field && extension == src.extension && nestedType == src.nestedType &&
        enumType == src.enumType && extensionRange == src.extensionRange && oneofDecl == src.oneofDecl &&
        p_options.data == src.p_options.data && reservedRange == src.reservedRange &&
        reservedName == src.reservedName
    }

    public func mergeFrom(src: DescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (!src.field.isEmpty()) { field.appendAll(src.field) }
        if (!src.extension.isEmpty()) { extension.appendAll(src.extension) }
        if (!src.nestedType.isEmpty()) { nestedType.appendAll(src.nestedType) }
        if (!src.enumType.isEmpty()) { enumType.appendAll(src.enumType) }
        if (!src.extensionRange.isEmpty()) { extensionRange.appendAll(src.extensionRange) }
        if (!src.oneofDecl.isEmpty()) { oneofDecl.appendAll(src.oneofDecl) }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.reservedRange.isEmpty()) { reservedRange.appendAll(src.reservedRange) }
        if (!src.reservedName.isEmpty()) { reservedName.appendAll(src.reservedName) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: DescriptorProto): DescriptorProto {
        p_name = src.p_name
        field.copyFrom(src.field)
        extension.copyFrom(src.extension)
        nestedType.copyFrom(src.nestedType)
        enumType.copyFrom(src.enumType)
        extensionRange.copyFrom(src.extensionRange)
        oneofDecl.copyFrom(src.oneofDecl)
        p_options.copyFrom(this, src.p_options.data)
        reservedRange.copyFrom(src.reservedRange)
        reservedName.copyFrom(src.reservedName)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): DescriptorProto {
        return DescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => s_add(field, src)
                case 6 => s_add(extension, src)
                case 3 => s_add(nestedType, src)
                case 4 => s_add(enumType, src)
                case 5 => s_add(extensionRange, src)
                case 8 => s_add(oneofDecl, src)
                case 7 => p_options.getOrDefault(this).unpack(subReader(src))
                case 9 => s_add(reservedRange, src)
                case 10 => s_add(reservedName, src.parseString())
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (!field.isEmpty()) { for (_i in field) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (!extension.isEmpty()) { for (_i in extension) { out.append(50); out.packVarint(_i.size); _i.pack(out) } }
        if (!nestedType.isEmpty()) { for (_i in nestedType) { out.append(26); out.packVarint(_i.size); _i.pack(out) } }
        if (!enumType.isEmpty()) { for (_i in enumType) { out.append(34); out.packVarint(_i.size); _i.pack(out) } }
        if (!extensionRange.isEmpty()) { for (_i in extensionRange) { out.append(42); out.packVarint(_i.size); _i.pack(out) } }
        if (!oneofDecl.isEmpty()) { for (_i in oneofDecl) { out.append(66); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_options.data) { out.append(58); out.packVarint(_v.size); _v.pack(out) }
        if (!reservedRange.isEmpty()) { for (_i in reservedRange) { out.append(74); out.packVarint(_i.size); _i.pack(out) } }
        if (!reservedName.isEmpty()) { for (_i in reservedName) { out.append(82); out.packBin(_i) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (!field.isEmpty()) { _x.append("field", field) }
        if (!extension.isEmpty()) { _x.append("extension", extension) }
        if (!nestedType.isEmpty()) { _x.append("nestedType", nestedType) }
        if (!enumType.isEmpty()) { _x.append("enumType", enumType) }
        if (!extensionRange.isEmpty()) { _x.append("extensionRange", extensionRange) }
        if (!oneofDecl.isEmpty()) { _x.append("oneofDecl", oneofDecl) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        if (!reservedRange.isEmpty()) { _x.append("reservedRange", reservedRange) }
        if (!reservedName.isEmpty()) { _x.append("reservedName", reservedName) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { DescriptorProto() }
    public static func newBuilder() { DescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = DescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = DescriptorProto(); _x.unpack(src); _x }
}

public class DescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var field: Array<FieldDescriptorProto> = []
    public func setField(field: Array<FieldDescriptorProto>) { this.field = field; return this }

    public var extension: Array<FieldDescriptorProto> = []
    public func setExtension(extension: Array<FieldDescriptorProto>) { this.extension = extension; return this }

    public var nestedType: Array<DescriptorProto> = []
    public func setNestedType(nestedType: Array<DescriptorProto>) { this.nestedType = nestedType; return this }

    public var enumType: Array<EnumDescriptorProto> = []
    public func setEnumType(enumType: Array<EnumDescriptorProto>) { this.enumType = enumType; return this }

    public var extensionRange: Array<DescriptorProto_ExtensionRange> = []
    public func setExtensionRange(extensionRange: Array<DescriptorProto_ExtensionRange>) { this.extensionRange = extensionRange; return this }

    public var oneofDecl: Array<OneofDescriptorProto> = []
    public func setOneofDecl(oneofDecl: Array<OneofDescriptorProto>) { this.oneofDecl = oneofDecl; return this }

    public var options: ?MessageOptions = None
    public func setOptions(options: MessageOptions) { this.options = options; return this }

    public var reservedRange: Array<DescriptorProto_ReservedRange> = []
    public func setReservedRange(reservedRange: Array<DescriptorProto_ReservedRange>) { this.reservedRange = reservedRange; return this }

    public var reservedName: Array<String> = []
    public func setReservedName(reservedName: Array<String>) { this.reservedName = reservedName; return this }

    public func build() { DescriptorProto(this) }
}

public class ExtensionRangeOptions <: MessageLite & TypedMessage<ExtensionRangeOptions> {
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: ExtensionRangeOptions__Builder) {
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    protected func m_size(): Int64 {
        var _x = 0
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        uninterpretedOption.clear()
    }

    public operator func !=(src: ExtensionRangeOptions): Bool { !(this == src) }
    public operator func ==(src: ExtensionRangeOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: ExtensionRangeOptions): Unit {
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ExtensionRangeOptions): ExtensionRangeOptions {
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ExtensionRangeOptions {
        return ExtensionRangeOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ExtensionRangeOptions() }
    public static func newBuilder() { ExtensionRangeOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ExtensionRangeOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ExtensionRangeOptions(); _x.unpack(src); _x }
}

public class ExtensionRangeOptions__Builder {
    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { ExtensionRangeOptions(this) }
}

public enum FieldDescriptorProto_Type <: Enum<FieldDescriptorProto_Type> {
    TYPE_DOUBLE | TYPE_FLOAT | TYPE_INT64 | TYPE_UINT64 | TYPE_INT32 | TYPE_FIXED64 | TYPE_FIXED32 | TYPE_BOOL |
    TYPE_STRING | TYPE_GROUP | TYPE_MESSAGE | TYPE_BYTES | TYPE_UINT32 | TYPE_ENUM | TYPE_SFIXED32 | TYPE_SFIXED64 |
    TYPE_SINT32 | TYPE_SINT64

    public func value(): Int32 {
        match(this) {
            case TYPE_DOUBLE => 1
            case TYPE_FLOAT => 2
            case TYPE_INT64 => 3
            case TYPE_UINT64 => 4
            case TYPE_INT32 => 5
            case TYPE_FIXED64 => 6
            case TYPE_FIXED32 => 7
            case TYPE_BOOL => 8
            case TYPE_STRING => 9
            case TYPE_GROUP => 10
            case TYPE_MESSAGE => 11
            case TYPE_BYTES => 12
            case TYPE_UINT32 => 13
            case TYPE_ENUM => 14
            case TYPE_SFIXED32 => 15
            case TYPE_SFIXED64 => 16
            case TYPE_SINT32 => 17
            case TYPE_SINT64 => 18
        }
    }

    public func toString(): String {
        match(this) {
            case TYPE_DOUBLE => "TYPE_DOUBLE"
            case TYPE_FLOAT => "TYPE_FLOAT"
            case TYPE_INT64 => "TYPE_INT64"
            case TYPE_UINT64 => "TYPE_UINT64"
            case TYPE_INT32 => "TYPE_INT32"
            case TYPE_FIXED64 => "TYPE_FIXED64"
            case TYPE_FIXED32 => "TYPE_FIXED32"
            case TYPE_BOOL => "TYPE_BOOL"
            case TYPE_STRING => "TYPE_STRING"
            case TYPE_GROUP => "TYPE_GROUP"
            case TYPE_MESSAGE => "TYPE_MESSAGE"
            case TYPE_BYTES => "TYPE_BYTES"
            case TYPE_UINT32 => "TYPE_UINT32"
            case TYPE_ENUM => "TYPE_ENUM"
            case TYPE_SFIXED32 => "TYPE_SFIXED32"
            case TYPE_SFIXED64 => "TYPE_SFIXED64"
            case TYPE_SINT32 => "TYPE_SINT32"
            case TYPE_SINT64 => "TYPE_SINT64"
        }
    }

    public operator func==(value: FieldDescriptorProto_Type) {
        match((this, value)) {
            case (TYPE_DOUBLE, TYPE_DOUBLE) => true
            case (TYPE_FLOAT, TYPE_FLOAT) => true
            case (TYPE_INT64, TYPE_INT64) => true
            case (TYPE_UINT64, TYPE_UINT64) => true
            case (TYPE_INT32, TYPE_INT32) => true
            case (TYPE_FIXED64, TYPE_FIXED64) => true
            case (TYPE_FIXED32, TYPE_FIXED32) => true
            case (TYPE_BOOL, TYPE_BOOL) => true
            case (TYPE_STRING, TYPE_STRING) => true
            case (TYPE_GROUP, TYPE_GROUP) => true
            case (TYPE_MESSAGE, TYPE_MESSAGE) => true
            case (TYPE_BYTES, TYPE_BYTES) => true
            case (TYPE_UINT32, TYPE_UINT32) => true
            case (TYPE_ENUM, TYPE_ENUM) => true
            case (TYPE_SFIXED32, TYPE_SFIXED32) => true
            case (TYPE_SFIXED64, TYPE_SFIXED64) => true
            case (TYPE_SINT32, TYPE_SINT32) => true
            case (TYPE_SINT64, TYPE_SINT64) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): FieldDescriptorProto_Type {
        match(value) {
            case 1 => TYPE_DOUBLE
            case 2 => TYPE_FLOAT
            case 3 => TYPE_INT64
            case 4 => TYPE_UINT64
            case 5 => TYPE_INT32
            case 6 => TYPE_FIXED64
            case 7 => TYPE_FIXED32
            case 8 => TYPE_BOOL
            case 9 => TYPE_STRING
            case 10 => TYPE_GROUP
            case 11 => TYPE_MESSAGE
            case 12 => TYPE_BYTES
            case 13 => TYPE_UINT32
            case 14 => TYPE_ENUM
            case 15 => TYPE_SFIXED32
            case 16 => TYPE_SFIXED64
            case 17 => TYPE_SINT32
            case 18 => TYPE_SINT64
            case _ => throw InvalidEnumValueException("FieldDescriptorProto_Type", value)
        }
    }

    public static func parse(value: String): FieldDescriptorProto_Type {
        match(value) {
            case "TYPE_DOUBLE" => TYPE_DOUBLE
            case "TYPE_FLOAT" => TYPE_FLOAT
            case "TYPE_INT64" => TYPE_INT64
            case "TYPE_UINT64" => TYPE_UINT64
            case "TYPE_INT32" => TYPE_INT32
            case "TYPE_FIXED64" => TYPE_FIXED64
            case "TYPE_FIXED32" => TYPE_FIXED32
            case "TYPE_BOOL" => TYPE_BOOL
            case "TYPE_STRING" => TYPE_STRING
            case "TYPE_GROUP" => TYPE_GROUP
            case "TYPE_MESSAGE" => TYPE_MESSAGE
            case "TYPE_BYTES" => TYPE_BYTES
            case "TYPE_UINT32" => TYPE_UINT32
            case "TYPE_ENUM" => TYPE_ENUM
            case "TYPE_SFIXED32" => TYPE_SFIXED32
            case "TYPE_SFIXED64" => TYPE_SFIXED64
            case "TYPE_SINT32" => TYPE_SINT32
            case "TYPE_SINT64" => TYPE_SINT64
            case _ => throw UnmatchedEnumStringException("FieldDescriptorProto_Type", value)
        }
    }
}

public enum FieldDescriptorProto_Label <: Enum<FieldDescriptorProto_Label> {
    LABEL_OPTIONAL | LABEL_REQUIRED | LABEL_REPEATED

    public func value(): Int32 {
        match(this) {
            case LABEL_OPTIONAL => 1
            case LABEL_REQUIRED => 2
            case LABEL_REPEATED => 3
        }
    }

    public func toString(): String {
        match(this) {
            case LABEL_OPTIONAL => "LABEL_OPTIONAL"
            case LABEL_REQUIRED => "LABEL_REQUIRED"
            case LABEL_REPEATED => "LABEL_REPEATED"
        }
    }

    public operator func==(value: FieldDescriptorProto_Label) {
        match((this, value)) {
            case (LABEL_OPTIONAL, LABEL_OPTIONAL) => true
            case (LABEL_REQUIRED, LABEL_REQUIRED) => true
            case (LABEL_REPEATED, LABEL_REPEATED) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): FieldDescriptorProto_Label {
        match(value) {
            case 1 => LABEL_OPTIONAL
            case 2 => LABEL_REQUIRED
            case 3 => LABEL_REPEATED
            case _ => throw InvalidEnumValueException("FieldDescriptorProto_Label", value)
        }
    }

    public static func parse(value: String): FieldDescriptorProto_Label {
        match(value) {
            case "LABEL_OPTIONAL" => LABEL_OPTIONAL
            case "LABEL_REQUIRED" => LABEL_REQUIRED
            case "LABEL_REPEATED" => LABEL_REPEATED
            case _ => throw UnmatchedEnumStringException("FieldDescriptorProto_Label", value)
        }
    }
}

public class FieldDescriptorProto <: MessageLite & TypedMessage<FieldDescriptorProto> {
    private var p_name: ?String
    private var p_number: ?Int32
    private var p_label: ?FieldDescriptorProto_Label
    private var p_type: ?FieldDescriptorProto_Type
    private var p_typeName: ?String
    private var p_extendee: ?String
    private var p_defaultValue: ?String
    private var p_oneofIndex: ?Int32
    private var p_jsonName: ?String
    private var p_options: PbMessage<FieldOptions>
    private var p_proto3Optional: ?Bool
    public let mapEntry: RepeatedMessage<FieldDescriptorProto>

    public init(
        name!: ?String = None,
        number!: ?Int32 = None,
        label!: ?FieldDescriptorProto_Label = None,
        type_!: ?FieldDescriptorProto_Type = None,
        typeName!: ?String = None,
        extendee!: ?String = None,
        defaultValue!: ?String = None,
        oneofIndex!: ?Int32 = None,
        jsonName!: ?String = None,
        options!: ?FieldOptions = None,
        proto3Optional!: ?Bool = None,
        mapEntry!: Array<FieldDescriptorProto> = []
    ) {
        this.p_name = name
        this.p_number = number
        this.p_label = label
        this.p_type = type_
        this.p_typeName = typeName
        this.p_extendee = extendee
        this.p_defaultValue = defaultValue
        this.p_oneofIndex = oneofIndex
        this.p_jsonName = jsonName
        this.p_options = PbMessage<FieldOptions>(options)
        this.p_proto3Optional = proto3Optional
        this.mapEntry = RepeatedMessage<FieldDescriptorProto>(mapEntry)
        m_init()
    }

    public init(src: FieldDescriptorProto__Builder) {
        this.p_name = src.name
        this.p_number = src.number
        this.p_label = src.label
        this.p_type = src.type_
        this.p_typeName = src.typeName
        this.p_extendee = src.extendee
        this.p_defaultValue = src.defaultValue
        this.p_oneofIndex = src.oneofIndex
        this.p_jsonName = src.jsonName
        this.p_options = PbMessage<FieldOptions>(src.options)
        this.p_proto3Optional = src.proto3Optional
        this.mapEntry = RepeatedMessage<FieldDescriptorProto>(src.mapEntry)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_init(mapEntry)
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearNumber() { p_number = None; markDirty() }
    public prop hasNumber: Bool { get() { isPresent(p_number) } }
    public mut prop number: Int32 { get() { p_number.getOrThrow() } set(_x) { p_number = _x; markDirty() } }

    public func clearLabel() { p_label = None; markDirty() }
    public prop hasLabel: Bool { get() { isPresent(p_label) } }
    public mut prop label: FieldDescriptorProto_Label { get() { p_label.getOrThrow() } set(_x) { p_label = _x; markDirty() } }

    public func clearType() { p_type = None; markDirty() }
    public prop hasType: Bool { get() { isPresent(p_type) } }
    public mut prop type_: FieldDescriptorProto_Type { get() { p_type.getOrThrow() } set(_x) { p_type = _x; markDirty() } }

    public func clearTypeName() { p_typeName = None; markDirty() }
    public prop hasTypeName: Bool { get() { isPresent(p_typeName) } }
    public mut prop typeName: String { get() { p_typeName.getOrThrow() } set(_x) { p_typeName = _x; markDirty() } }

    public func clearExtendee() { p_extendee = None; markDirty() }
    public prop hasExtendee: Bool { get() { isPresent(p_extendee) } }
    public mut prop extendee: String { get() { p_extendee.getOrThrow() } set(_x) { p_extendee = _x; markDirty() } }

    public func clearDefaultValue() { p_defaultValue = None; markDirty() }
    public prop hasDefaultValue: Bool { get() { isPresent(p_defaultValue) } }
    public mut prop defaultValue: String { get() { p_defaultValue.getOrThrow() } set(_x) { p_defaultValue = _x; markDirty() } }

    public func clearOneofIndex() { p_oneofIndex = None; markDirty() }
    public prop hasOneofIndex: Bool { get() { isPresent(p_oneofIndex) } }
    public mut prop oneofIndex: Int32 { get() { p_oneofIndex.getOrThrow() } set(_x) { p_oneofIndex = _x; markDirty() } }

    public func clearJsonName() { p_jsonName = None; markDirty() }
    public prop hasJsonName: Bool { get() { isPresent(p_jsonName) } }
    public mut prop jsonName: String { get() { p_jsonName.getOrThrow() } set(_x) { p_jsonName = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: FieldOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    public func clearProto3Optional() { p_proto3Optional = None; markDirty() }
    public prop hasProto3Optional: Bool { get() { isPresent(p_proto3Optional) } }
    public mut prop proto3Optional: Bool { get() { p_proto3Optional.getOrThrow() } set(_x) { p_proto3Optional = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_number) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_label) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_type) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_typeName) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_extendee) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_defaultValue) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_oneofIndex) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_jsonName) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_proto3Optional) { _x += 2 + 1 }
        if (!mapEntry.isEmpty()) { for (_i in mapEntry) { _x += 3 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_number) { _x.write(_v) }
        if (let Some(_v) <- p_label) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_type) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_typeName) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_extendee) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_defaultValue) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_oneofIndex) { _x.write(_v) }
        if (let Some(_v) <- p_jsonName) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_proto3Optional) { _x.write(_v) }
        if (!mapEntry.isEmpty()) { _x.write(mapEntry.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_number) && isNone(p_label) && isNone(p_type) && isNone(p_typeName) &&
        isNone(p_extendee) && isNone(p_defaultValue) && isNone(p_oneofIndex) && isNone(p_jsonName) &&
        isNone(p_options.data) && isNone(p_proto3Optional) && mapEntry.isEmpty()
    }

    protected func m_clear(): Unit {
        p_name = None
        p_number = None
        p_label = None
        p_type = None
        p_typeName = None
        p_extendee = None
        p_defaultValue = None
        p_oneofIndex = None
        p_jsonName = None
        p_options.removeFrom(this)
        p_proto3Optional = None
        mapEntry.clear()
    }

    public operator func !=(src: FieldDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: FieldDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_number == src.p_number && p_label == src.p_label && p_type == src.p_type &&
        p_typeName == src.p_typeName && p_extendee == src.p_extendee && p_defaultValue == src.p_defaultValue &&
        p_oneofIndex == src.p_oneofIndex && p_jsonName == src.p_jsonName && p_options.data == src.p_options.data &&
        p_proto3Optional == src.p_proto3Optional && mapEntry == src.mapEntry
    }

    public func mergeFrom(src: FieldDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_number) { p_number = _v }
        if (let Some(_v) <- src.p_label) { p_label = _v }
        if (let Some(_v) <- src.p_type) { p_type = _v }
        if (let Some(_v) <- src.p_typeName) { p_typeName = _v }
        if (let Some(_v) <- src.p_extendee) { p_extendee = _v }
        if (let Some(_v) <- src.p_defaultValue) { p_defaultValue = _v }
        if (let Some(_v) <- src.p_oneofIndex) { p_oneofIndex = _v }
        if (let Some(_v) <- src.p_jsonName) { p_jsonName = _v }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_proto3Optional) { p_proto3Optional = _v }
        if (!src.mapEntry.isEmpty()) { mapEntry.appendAll(src.mapEntry) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FieldDescriptorProto): FieldDescriptorProto {
        p_name = src.p_name
        p_number = src.p_number
        p_label = src.p_label
        p_type = src.p_type
        p_typeName = src.p_typeName
        p_extendee = src.p_extendee
        p_defaultValue = src.p_defaultValue
        p_oneofIndex = src.p_oneofIndex
        p_jsonName = src.p_jsonName
        p_options.copyFrom(this, src.p_options.data)
        p_proto3Optional = src.p_proto3Optional
        mapEntry.copyFrom(src.mapEntry)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FieldDescriptorProto {
        return FieldDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 3 => p_number = src.parseInt32()
                case 4 => p_label = FieldDescriptorProto_Label.parse(src.parseInt32())
                case 5 => p_type = FieldDescriptorProto_Type.parse(src.parseInt32())
                case 6 => p_typeName = src.parseString()
                case 2 => p_extendee = src.parseString()
                case 7 => p_defaultValue = src.parseString()
                case 9 => p_oneofIndex = src.parseInt32()
                case 10 => p_jsonName = src.parseString()
                case 8 => p_options.getOrDefault(this).unpack(subReader(src))
                case 17 => p_proto3Optional = src.parseBool()
                case 9999 => s_add(mapEntry, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_number) { out.append(24); out.packVarint(_v) }
        if (let Some(_v) <- p_label) { out.append(32); out.packVarint(_v) }
        if (let Some(_v) <- p_type) { out.append(40); out.packVarint(_v) }
        if (let Some(_v) <- p_typeName) { out.append(50); out.packBin(_v) }
        if (let Some(_v) <- p_extendee) { out.append(18); out.packBin(_v) }
        if (let Some(_v) <- p_defaultValue) { out.append(58); out.packBin(_v) }
        if (let Some(_v) <- p_oneofIndex) { out.append(72); out.packVarint(_v) }
        if (let Some(_v) <- p_jsonName) { out.append(82); out.packBin(_v) }
        if (let Some(_v) <- p_options.data) { out.append(66); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_proto3Optional) { out.packTag(17, VARINT); out.packBool(_v) }
        if (!mapEntry.isEmpty()) { for (_i in mapEntry) { out.packTag(9999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_number) { _x.append("number", _v) }
        if (let Some(_v) <- p_label) { _x.append("label", _v) }
        if (let Some(_v) <- p_type) { _x.append("type", _v) }
        if (let Some(_v) <- p_typeName) { _x.append("typeName", _v) }
        if (let Some(_v) <- p_extendee) { _x.append("extendee", _v) }
        if (let Some(_v) <- p_defaultValue) { _x.append("defaultValue", _v) }
        if (let Some(_v) <- p_oneofIndex) { _x.append("oneofIndex", _v) }
        if (let Some(_v) <- p_jsonName) { _x.append("jsonName", _v) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        if (let Some(_v) <- p_proto3Optional) { _x.append("proto3Optional", _v) }
        if (!mapEntry.isEmpty()) { _x.append("mapEntry", mapEntry) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FieldDescriptorProto() }
    public static func newBuilder() { FieldDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FieldDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FieldDescriptorProto(); _x.unpack(src); _x }
}

public class FieldDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var number: ?Int32 = None
    public func setNumber(number: Int32) { this.number = number; return this }

    public var label: ?FieldDescriptorProto_Label = None
    public func setLabel(label: FieldDescriptorProto_Label) { this.label = label; return this }

    public var type_: ?FieldDescriptorProto_Type = None
    public func setType(type_: FieldDescriptorProto_Type) { this.type_ = type_; return this }

    public var typeName: ?String = None
    public func setTypeName(typeName: String) { this.typeName = typeName; return this }

    public var extendee: ?String = None
    public func setExtendee(extendee: String) { this.extendee = extendee; return this }

    public var defaultValue: ?String = None
    public func setDefaultValue(defaultValue: String) { this.defaultValue = defaultValue; return this }

    public var oneofIndex: ?Int32 = None
    public func setOneofIndex(oneofIndex: Int32) { this.oneofIndex = oneofIndex; return this }

    public var jsonName: ?String = None
    public func setJsonName(jsonName: String) { this.jsonName = jsonName; return this }

    public var options: ?FieldOptions = None
    public func setOptions(options: FieldOptions) { this.options = options; return this }

    public var proto3Optional: ?Bool = None
    public func setProto3Optional(proto3Optional: Bool) { this.proto3Optional = proto3Optional; return this }

    public var mapEntry: Array<FieldDescriptorProto> = []
    public func setMapEntry(mapEntry: Array<FieldDescriptorProto>) { this.mapEntry = mapEntry; return this }

    public func build() { FieldDescriptorProto(this) }
}

public class OneofDescriptorProto <: MessageLite & TypedMessage<OneofDescriptorProto> {
    private var p_name: ?String
    private var p_options: PbMessage<OneofOptions>

    public init(
        name!: ?String = None,
        options!: ?OneofOptions = None
    ) {
        this.p_name = name
        this.p_options = PbMessage<OneofOptions>(options)
        m_init()
    }

    public init(src: OneofDescriptorProto__Builder) {
        this.p_name = src.name
        this.p_options = PbMessage<OneofOptions>(src.options)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: OneofOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_options.data)
    }

    protected func m_clear(): Unit {
        p_name = None
        p_options.removeFrom(this)
    }

    public operator func !=(src: OneofDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: OneofDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_options.data == src.p_options.data
    }

    public func mergeFrom(src: OneofDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: OneofDescriptorProto): OneofDescriptorProto {
        p_name = src.p_name
        p_options.copyFrom(this, src.p_options.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): OneofDescriptorProto {
        return OneofDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => p_options.getOrDefault(this).unpack(subReader(src))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_options.data) { out.append(18); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { OneofDescriptorProto() }
    public static func newBuilder() { OneofDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = OneofDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = OneofDescriptorProto(); _x.unpack(src); _x }
}

public class OneofDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var options: ?OneofOptions = None
    public func setOptions(options: OneofOptions) { this.options = options; return this }

    public func build() { OneofDescriptorProto(this) }
}

public class EnumDescriptorProto_EnumReservedRange <: MessageLite & TypedMessage<EnumDescriptorProto_EnumReservedRange> {
    private var p_start: ?Int32
    private var p_end: ?Int32

    public init(
        start!: ?Int32 = None,
        end!: ?Int32 = None
    ) {
        this.p_start = start
        this.p_end = end
        m_init()
    }

    public init(src: EnumDescriptorProto_EnumReservedRange__Builder) {
        this.p_start = src.start
        this.p_end = src.end
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public func clearStart() { p_start = None; markDirty() }
    public prop hasStart: Bool { get() { isPresent(p_start) } }
    public mut prop start: Int32 { get() { p_start.getOrThrow() } set(_x) { p_start = _x; markDirty() } }

    public func clearEnd() { p_end = None; markDirty() }
    public prop hasEnd: Bool { get() { isPresent(p_end) } }
    public mut prop end: Int32 { get() { p_end.getOrThrow() } set(_x) { p_end = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_start) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_end) { _x += 1 + varintSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_start) { _x.write(_v) }
        if (let Some(_v) <- p_end) { _x.write(_v) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_start) && isNone(p_end)
    }

    protected func m_clear(): Unit {
        p_start = None
        p_end = None
    }

    public operator func !=(src: EnumDescriptorProto_EnumReservedRange): Bool { !(this == src) }
    public operator func ==(src: EnumDescriptorProto_EnumReservedRange): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_start == src.p_start && p_end == src.p_end
    }

    public func mergeFrom(src: EnumDescriptorProto_EnumReservedRange): Unit {
        if (let Some(_v) <- src.p_start) { p_start = _v }
        if (let Some(_v) <- src.p_end) { p_end = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: EnumDescriptorProto_EnumReservedRange): EnumDescriptorProto_EnumReservedRange {
        p_start = src.p_start
        p_end = src.p_end
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): EnumDescriptorProto_EnumReservedRange {
        return EnumDescriptorProto_EnumReservedRange().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_start = src.parseInt32()
                case 2 => p_end = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_start) { out.append(8); out.packVarint(_v) }
        if (let Some(_v) <- p_end) { out.append(16); out.packVarint(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_start) { _x.append("start", _v) }
        if (let Some(_v) <- p_end) { _x.append("end", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { EnumDescriptorProto_EnumReservedRange() }
    public static func newBuilder() { EnumDescriptorProto_EnumReservedRange__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = EnumDescriptorProto_EnumReservedRange(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = EnumDescriptorProto_EnumReservedRange(); _x.unpack(src); _x }
}

public class EnumDescriptorProto_EnumReservedRange__Builder {
    public var start: ?Int32 = None
    public func setStart(start: Int32) { this.start = start; return this }

    public var end: ?Int32 = None
    public func setEnd(end: Int32) { this.end = end; return this }

    public func build() { EnumDescriptorProto_EnumReservedRange(this) }
}

public class EnumDescriptorProto <: MessageLite & TypedMessage<EnumDescriptorProto> {
    private var p_name: ?String
    public let value: RepeatedMessage<EnumValueDescriptorProto>
    private var p_options: PbMessage<EnumOptions>
    public let reservedRange: RepeatedMessage<EnumDescriptorProto_EnumReservedRange>
    public let reservedName: RepeatedField<String>

    public init(
        name!: ?String = None,
        value!: Array<EnumValueDescriptorProto> = [],
        options!: ?EnumOptions = None,
        reservedRange!: Array<EnumDescriptorProto_EnumReservedRange> = [],
        reservedName!: Array<String> = []
    ) {
        this.p_name = name
        this.value = RepeatedMessage<EnumValueDescriptorProto>(value)
        this.p_options = PbMessage<EnumOptions>(options)
        this.reservedRange = RepeatedMessage<EnumDescriptorProto_EnumReservedRange>(reservedRange)
        this.reservedName = RepeatedField<String>(reservedName)
        m_init()
    }

    public init(src: EnumDescriptorProto__Builder) {
        this.p_name = src.name
        this.value = RepeatedMessage<EnumValueDescriptorProto>(src.value)
        this.p_options = PbMessage<EnumOptions>(src.options)
        this.reservedRange = RepeatedMessage<EnumDescriptorProto_EnumReservedRange>(src.reservedRange)
        this.reservedName = RepeatedField<String>(src.reservedName)
        m_init()
    }

    private func m_init() {
        m_init(value)
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_init(reservedRange)
        m_init(reservedName)
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: EnumOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (!value.isEmpty()) { for (_i in value) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        if (!reservedRange.isEmpty()) { for (_i in reservedRange) { _x += 1 + binSize(_i) } }
        if (!reservedName.isEmpty()) { for (_i in reservedName) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (!value.isEmpty()) { _x.write(value.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        if (!reservedRange.isEmpty()) { _x.write(reservedRange.hashCode()) }
        if (!reservedName.isEmpty()) { _x.write(reservedName.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && value.isEmpty() && isNone(p_options.data) && reservedRange.isEmpty() &&
        reservedName.isEmpty()
    }

    protected func m_clear(): Unit {
        p_name = None
        value.clear()
        p_options.removeFrom(this)
        reservedRange.clear()
        reservedName.clear()
    }

    public operator func !=(src: EnumDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: EnumDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && value == src.value && p_options.data == src.p_options.data &&
        reservedRange == src.reservedRange && reservedName == src.reservedName
    }

    public func mergeFrom(src: EnumDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (!src.value.isEmpty()) { value.appendAll(src.value) }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.reservedRange.isEmpty()) { reservedRange.appendAll(src.reservedRange) }
        if (!src.reservedName.isEmpty()) { reservedName.appendAll(src.reservedName) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: EnumDescriptorProto): EnumDescriptorProto {
        p_name = src.p_name
        value.copyFrom(src.value)
        p_options.copyFrom(this, src.p_options.data)
        reservedRange.copyFrom(src.reservedRange)
        reservedName.copyFrom(src.reservedName)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): EnumDescriptorProto {
        return EnumDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => s_add(value, src)
                case 3 => p_options.getOrDefault(this).unpack(subReader(src))
                case 4 => s_add(reservedRange, src)
                case 5 => s_add(reservedName, src.parseString())
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (!value.isEmpty()) { for (_i in value) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_options.data) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        if (!reservedRange.isEmpty()) { for (_i in reservedRange) { out.append(34); out.packVarint(_i.size); _i.pack(out) } }
        if (!reservedName.isEmpty()) { for (_i in reservedName) { out.append(42); out.packBin(_i) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (!value.isEmpty()) { _x.append("value", value) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        if (!reservedRange.isEmpty()) { _x.append("reservedRange", reservedRange) }
        if (!reservedName.isEmpty()) { _x.append("reservedName", reservedName) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { EnumDescriptorProto() }
    public static func newBuilder() { EnumDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = EnumDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = EnumDescriptorProto(); _x.unpack(src); _x }
}

public class EnumDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var value: Array<EnumValueDescriptorProto> = []
    public func setValue(value: Array<EnumValueDescriptorProto>) { this.value = value; return this }

    public var options: ?EnumOptions = None
    public func setOptions(options: EnumOptions) { this.options = options; return this }

    public var reservedRange: Array<EnumDescriptorProto_EnumReservedRange> = []
    public func setReservedRange(reservedRange: Array<EnumDescriptorProto_EnumReservedRange>) { this.reservedRange = reservedRange; return this }

    public var reservedName: Array<String> = []
    public func setReservedName(reservedName: Array<String>) { this.reservedName = reservedName; return this }

    public func build() { EnumDescriptorProto(this) }
}

public class EnumValueDescriptorProto <: MessageLite & TypedMessage<EnumValueDescriptorProto> {
    private var p_name: ?String
    private var p_number: ?Int32
    private var p_options: PbMessage<EnumValueOptions>

    public init(
        name!: ?String = None,
        number!: ?Int32 = None,
        options!: ?EnumValueOptions = None
    ) {
        this.p_name = name
        this.p_number = number
        this.p_options = PbMessage<EnumValueOptions>(options)
        m_init()
    }

    public init(src: EnumValueDescriptorProto__Builder) {
        this.p_name = src.name
        this.p_number = src.number
        this.p_options = PbMessage<EnumValueOptions>(src.options)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearNumber() { p_number = None; markDirty() }
    public prop hasNumber: Bool { get() { isPresent(p_number) } }
    public mut prop number: Int32 { get() { p_number.getOrThrow() } set(_x) { p_number = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: EnumValueOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_number) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_number) { _x.write(_v) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_number) && isNone(p_options.data)
    }

    protected func m_clear(): Unit {
        p_name = None
        p_number = None
        p_options.removeFrom(this)
    }

    public operator func !=(src: EnumValueDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: EnumValueDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_number == src.p_number && p_options.data == src.p_options.data
    }

    public func mergeFrom(src: EnumValueDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_number) { p_number = _v }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: EnumValueDescriptorProto): EnumValueDescriptorProto {
        p_name = src.p_name
        p_number = src.p_number
        p_options.copyFrom(this, src.p_options.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): EnumValueDescriptorProto {
        return EnumValueDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => p_number = src.parseInt32()
                case 3 => p_options.getOrDefault(this).unpack(subReader(src))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_number) { out.append(16); out.packVarint(_v) }
        if (let Some(_v) <- p_options.data) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_number) { _x.append("number", _v) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { EnumValueDescriptorProto() }
    public static func newBuilder() { EnumValueDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = EnumValueDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = EnumValueDescriptorProto(); _x.unpack(src); _x }
}

public class EnumValueDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var number: ?Int32 = None
    public func setNumber(number: Int32) { this.number = number; return this }

    public var options: ?EnumValueOptions = None
    public func setOptions(options: EnumValueOptions) { this.options = options; return this }

    public func build() { EnumValueDescriptorProto(this) }
}

public class ServiceDescriptorProto <: MessageLite & TypedMessage<ServiceDescriptorProto> {
    private var p_name: ?String
    public let method: RepeatedMessage<MethodDescriptorProto>
    private var p_options: PbMessage<ServiceOptions>

    public init(
        name!: ?String = None,
        method!: Array<MethodDescriptorProto> = [],
        options!: ?ServiceOptions = None
    ) {
        this.p_name = name
        this.method = RepeatedMessage<MethodDescriptorProto>(method)
        this.p_options = PbMessage<ServiceOptions>(options)
        m_init()
    }

    public init(src: ServiceDescriptorProto__Builder) {
        this.p_name = src.name
        this.method = RepeatedMessage<MethodDescriptorProto>(src.method)
        this.p_options = PbMessage<ServiceOptions>(src.options)
        m_init()
    }

    private func m_init() {
        m_init(method)
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: ServiceOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (!method.isEmpty()) { for (_i in method) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (!method.isEmpty()) { _x.write(method.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && method.isEmpty() && isNone(p_options.data)
    }

    protected func m_clear(): Unit {
        p_name = None
        method.clear()
        p_options.removeFrom(this)
    }

    public operator func !=(src: ServiceDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: ServiceDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && method == src.method && p_options.data == src.p_options.data
    }

    public func mergeFrom(src: ServiceDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (!src.method.isEmpty()) { method.appendAll(src.method) }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ServiceDescriptorProto): ServiceDescriptorProto {
        p_name = src.p_name
        method.copyFrom(src.method)
        p_options.copyFrom(this, src.p_options.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ServiceDescriptorProto {
        return ServiceDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => s_add(method, src)
                case 3 => p_options.getOrDefault(this).unpack(subReader(src))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (!method.isEmpty()) { for (_i in method) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_options.data) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (!method.isEmpty()) { _x.append("method", method) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ServiceDescriptorProto() }
    public static func newBuilder() { ServiceDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ServiceDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ServiceDescriptorProto(); _x.unpack(src); _x }
}

public class ServiceDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var method: Array<MethodDescriptorProto> = []
    public func setMethod(method: Array<MethodDescriptorProto>) { this.method = method; return this }

    public var options: ?ServiceOptions = None
    public func setOptions(options: ServiceOptions) { this.options = options; return this }

    public func build() { ServiceDescriptorProto(this) }
}

public class MethodDescriptorProto <: MessageLite & TypedMessage<MethodDescriptorProto> {
    private var p_name: ?String
    private var p_inputType: ?String
    private var p_outputType: ?String
    private var p_options: PbMessage<MethodOptions>
    private var p_clientStreaming: ?Bool
    private var p_serverStreaming: ?Bool
    private var p_funcName: ?String

    public init(
        name!: ?String = None,
        inputType!: ?String = None,
        outputType!: ?String = None,
        options!: ?MethodOptions = None,
        clientStreaming!: ?Bool = None,
        serverStreaming!: ?Bool = None,
        funcName!: ?String = None
    ) {
        this.p_name = name
        this.p_inputType = inputType
        this.p_outputType = outputType
        this.p_options = PbMessage<MethodOptions>(options)
        this.p_clientStreaming = if (clientStreaming != false) { clientStreaming } else { None }
        this.p_serverStreaming = if (serverStreaming != false) { serverStreaming } else { None }
        this.p_funcName = funcName
        m_init()
    }

    public init(src: MethodDescriptorProto__Builder) {
        this.p_name = src.name
        this.p_inputType = src.inputType
        this.p_outputType = src.outputType
        this.p_options = PbMessage<MethodOptions>(src.options)
        this.p_clientStreaming = if (src.clientStreaming != false) { src.clientStreaming } else { None }
        this.p_serverStreaming = if (src.serverStreaming != false) { src.serverStreaming } else { None }
        this.p_funcName = src.funcName
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_options.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearInputType() { p_inputType = None; markDirty() }
    public prop hasInputType: Bool { get() { isPresent(p_inputType) } }
    public mut prop inputType: String { get() { p_inputType.getOrThrow() } set(_x) { p_inputType = _x; markDirty() } }

    public func clearOutputType() { p_outputType = None; markDirty() }
    public prop hasOutputType: Bool { get() { isPresent(p_outputType) } }
    public mut prop outputType: String { get() { p_outputType.getOrThrow() } set(_x) { p_outputType = _x; markDirty() } }

    public func clearOptions() { p_options.removeFrom(this); markDirty() }
    public prop hasOptions: Bool { get() { isPresent(p_options.data) } }
    public mut prop options: MethodOptions { get() { p_options.data.getOrThrow() } set(_v) { p_options.set(this, _v); markDirty() } }

    public func clearClientStreaming() { p_clientStreaming = None; markDirty() }
    public prop hasClientStreaming: Bool { get() { isPresent(p_clientStreaming) } }
    public mut prop clientStreaming: Bool { get() { p_clientStreaming ?? false } set(_x) { p_clientStreaming = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearServerStreaming() { p_serverStreaming = None; markDirty() }
    public prop hasServerStreaming: Bool { get() { isPresent(p_serverStreaming) } }
    public mut prop serverStreaming: Bool { get() { p_serverStreaming ?? false } set(_x) { p_serverStreaming = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearFuncName() { p_funcName = None; markDirty() }
    public prop hasFuncName: Bool { get() { isPresent(p_funcName) } }
    public mut prop funcName: String { get() { p_funcName.getOrThrow() } set(_x) { p_funcName = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_inputType) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_outputType) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_options.data) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_clientStreaming) { _x += 1 + 1 }
        if (let Some(_v) <- p_serverStreaming) { _x += 1 + 1 }
        if (let Some(_v) <- p_funcName) { _x += 3 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_inputType) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_outputType) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_options.data) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_clientStreaming) { _x.write(_v) }
        if (let Some(_v) <- p_serverStreaming) { _x.write(_v) }
        if (let Some(_v) <- p_funcName) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_inputType) && isNone(p_outputType) && isNone(p_options.data) &&
        isNone(p_clientStreaming) && isNone(p_serverStreaming) && isNone(p_funcName)
    }

    protected func m_clear(): Unit {
        p_name = None
        p_inputType = None
        p_outputType = None
        p_options.removeFrom(this)
        p_clientStreaming = None
        p_serverStreaming = None
        p_funcName = None
    }

    public operator func !=(src: MethodDescriptorProto): Bool { !(this == src) }
    public operator func ==(src: MethodDescriptorProto): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_inputType == src.p_inputType && p_outputType == src.p_outputType &&
        p_options.data == src.p_options.data && p_clientStreaming == src.p_clientStreaming &&
        p_serverStreaming == src.p_serverStreaming && p_funcName == src.p_funcName
    }

    public func mergeFrom(src: MethodDescriptorProto): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_inputType) { p_inputType = _v }
        if (let Some(_v) <- src.p_outputType) { p_outputType = _v }
        if (let Some(_v) <- src.p_options.data) { p_options.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_clientStreaming) { p_clientStreaming = _v }
        if (let Some(_v) <- src.p_serverStreaming) { p_serverStreaming = _v }
        if (let Some(_v) <- src.p_funcName) { p_funcName = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: MethodDescriptorProto): MethodDescriptorProto {
        p_name = src.p_name
        p_inputType = src.p_inputType
        p_outputType = src.p_outputType
        p_options.copyFrom(this, src.p_options.data)
        p_clientStreaming = src.p_clientStreaming
        p_serverStreaming = src.p_serverStreaming
        p_funcName = src.p_funcName
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): MethodDescriptorProto {
        return MethodDescriptorProto().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => p_inputType = src.parseString()
                case 3 => p_outputType = src.parseString()
                case 4 => p_options.getOrDefault(this).unpack(subReader(src))
                case 5 => clientStreaming = src.parseBool()
                case 6 => serverStreaming = src.parseBool()
                case 9999 => p_funcName = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_name) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_inputType) { out.append(18); out.packBin(_v) }
        if (let Some(_v) <- p_outputType) { out.append(26); out.packBin(_v) }
        if (let Some(_v) <- p_options.data) { out.append(34); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_clientStreaming) { out.append(40); out.packBool(_v) }
        if (let Some(_v) <- p_serverStreaming) { out.append(48); out.packBool(_v) }
        if (let Some(_v) <- p_funcName) { out.packTag(9999, PREFIXED); out.packBin(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_inputType) { _x.append("inputType", _v) }
        if (let Some(_v) <- p_outputType) { _x.append("outputType", _v) }
        if (let Some(_v) <- p_options.data) { _x.append("options", _v) }
        if (let Some(_v) <- p_clientStreaming) { _x.append("clientStreaming", _v) }
        if (let Some(_v) <- p_serverStreaming) { _x.append("serverStreaming", _v) }
        if (let Some(_v) <- p_funcName) { _x.append("funcName", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { MethodDescriptorProto() }
    public static func newBuilder() { MethodDescriptorProto__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = MethodDescriptorProto(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = MethodDescriptorProto(); _x.unpack(src); _x }
}

public class MethodDescriptorProto__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var inputType: ?String = None
    public func setInputType(inputType: String) { this.inputType = inputType; return this }

    public var outputType: ?String = None
    public func setOutputType(outputType: String) { this.outputType = outputType; return this }

    public var options: ?MethodOptions = None
    public func setOptions(options: MethodOptions) { this.options = options; return this }

    public var clientStreaming: ?Bool = None
    public func setClientStreaming(clientStreaming: Bool) { this.clientStreaming = clientStreaming; return this }

    public var serverStreaming: ?Bool = None
    public func setServerStreaming(serverStreaming: Bool) { this.serverStreaming = serverStreaming; return this }

    public var funcName: ?String = None
    public func setFuncName(funcName: String) { this.funcName = funcName; return this }

    public func build() { MethodDescriptorProto(this) }
}

public enum FileOptions_OptimizeMode <: Enum<FileOptions_OptimizeMode> {
    SPEED | CODE_SIZE | LITE_RUNTIME

    public func value(): Int32 {
        match(this) {
            case SPEED => 1
            case CODE_SIZE => 2
            case LITE_RUNTIME => 3
        }
    }

    public func toString(): String {
        match(this) {
            case SPEED => "SPEED"
            case CODE_SIZE => "CODE_SIZE"
            case LITE_RUNTIME => "LITE_RUNTIME"
        }
    }

    public operator func==(value: FileOptions_OptimizeMode) {
        match((this, value)) {
            case (SPEED, SPEED) => true
            case (CODE_SIZE, CODE_SIZE) => true
            case (LITE_RUNTIME, LITE_RUNTIME) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): FileOptions_OptimizeMode {
        match(value) {
            case 1 => SPEED
            case 2 => CODE_SIZE
            case 3 => LITE_RUNTIME
            case _ => throw InvalidEnumValueException("FileOptions_OptimizeMode", value)
        }
    }

    public static func parse(value: String): FileOptions_OptimizeMode {
        match(value) {
            case "SPEED" => SPEED
            case "CODE_SIZE" => CODE_SIZE
            case "LITE_RUNTIME" => LITE_RUNTIME
            case _ => throw UnmatchedEnumStringException("FileOptions_OptimizeMode", value)
        }
    }
}

public class FileOptions <: MessageLite & TypedMessage<FileOptions> {
    private var p_javaPackage: ?String
    private var p_javaOuterClassname: ?String
    private var p_javaMultipleFiles: ?Bool
    private var p_javaGenerateEqualsAndHash: ?Bool
    private var p_javaStringCheckUtf8: ?Bool
    private var p_optimizeFor: ?FileOptions_OptimizeMode
    private var p_goPackage: ?String
    private var p_ccGenericServices: ?Bool
    private var p_javaGenericServices: ?Bool
    private var p_pyGenericServices: ?Bool
    private var p_phpGenericServices: ?Bool
    private var p_deprecated: ?Bool
    private var p_ccEnableArenas: ?Bool
    private var p_objcClassPrefix: ?String
    private var p_csharpNamespace: ?String
    private var p_swiftPrefix: ?String
    private var p_phpClassPrefix: ?String
    private var p_phpNamespace: ?String
    private var p_phpMetadataNamespace: ?String
    private var p_rubyPackage: ?String
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        javaPackage!: ?String = None,
        javaOuterClassname!: ?String = None,
        javaMultipleFiles!: ?Bool = None,
        javaGenerateEqualsAndHash!: ?Bool = None,
        javaStringCheckUtf8!: ?Bool = None,
        optimizeFor!: ?FileOptions_OptimizeMode = None,
        goPackage!: ?String = None,
        ccGenericServices!: ?Bool = None,
        javaGenericServices!: ?Bool = None,
        pyGenericServices!: ?Bool = None,
        phpGenericServices!: ?Bool = None,
        deprecated!: ?Bool = None,
        ccEnableArenas!: ?Bool = None,
        objcClassPrefix!: ?String = None,
        csharpNamespace!: ?String = None,
        swiftPrefix!: ?String = None,
        phpClassPrefix!: ?String = None,
        phpNamespace!: ?String = None,
        phpMetadataNamespace!: ?String = None,
        rubyPackage!: ?String = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_javaPackage = javaPackage
        this.p_javaOuterClassname = javaOuterClassname
        this.p_javaMultipleFiles = if (javaMultipleFiles != false) { javaMultipleFiles } else { None }
        this.p_javaGenerateEqualsAndHash = javaGenerateEqualsAndHash
        this.p_javaStringCheckUtf8 = if (javaStringCheckUtf8 != false) { javaStringCheckUtf8 } else { None }
        this.p_optimizeFor = if (optimizeFor != SPEED) { optimizeFor } else { None }
        this.p_goPackage = goPackage
        this.p_ccGenericServices = if (ccGenericServices != false) { ccGenericServices } else { None }
        this.p_javaGenericServices = if (javaGenericServices != false) { javaGenericServices } else { None }
        this.p_pyGenericServices = if (pyGenericServices != false) { pyGenericServices } else { None }
        this.p_phpGenericServices = if (phpGenericServices != false) { phpGenericServices } else { None }
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.p_ccEnableArenas = if (ccEnableArenas != true) { ccEnableArenas } else { None }
        this.p_objcClassPrefix = objcClassPrefix
        this.p_csharpNamespace = csharpNamespace
        this.p_swiftPrefix = swiftPrefix
        this.p_phpClassPrefix = phpClassPrefix
        this.p_phpNamespace = phpNamespace
        this.p_phpMetadataNamespace = phpMetadataNamespace
        this.p_rubyPackage = rubyPackage
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: FileOptions__Builder) {
        this.p_javaPackage = src.javaPackage
        this.p_javaOuterClassname = src.javaOuterClassname
        this.p_javaMultipleFiles = if (src.javaMultipleFiles != false) { src.javaMultipleFiles } else { None }
        this.p_javaGenerateEqualsAndHash = src.javaGenerateEqualsAndHash
        this.p_javaStringCheckUtf8 = if (src.javaStringCheckUtf8 != false) { src.javaStringCheckUtf8 } else { None }
        this.p_optimizeFor = if (src.optimizeFor != SPEED) { src.optimizeFor } else { None }
        this.p_goPackage = src.goPackage
        this.p_ccGenericServices = if (src.ccGenericServices != false) { src.ccGenericServices } else { None }
        this.p_javaGenericServices = if (src.javaGenericServices != false) { src.javaGenericServices } else { None }
        this.p_pyGenericServices = if (src.pyGenericServices != false) { src.pyGenericServices } else { None }
        this.p_phpGenericServices = if (src.phpGenericServices != false) { src.phpGenericServices } else { None }
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.p_ccEnableArenas = if (src.ccEnableArenas != true) { src.ccEnableArenas } else { None }
        this.p_objcClassPrefix = src.objcClassPrefix
        this.p_csharpNamespace = src.csharpNamespace
        this.p_swiftPrefix = src.swiftPrefix
        this.p_phpClassPrefix = src.phpClassPrefix
        this.p_phpNamespace = src.phpNamespace
        this.p_phpMetadataNamespace = src.phpMetadataNamespace
        this.p_rubyPackage = src.rubyPackage
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearJavaPackage() { p_javaPackage = None; markDirty() }
    public prop hasJavaPackage: Bool { get() { isPresent(p_javaPackage) } }
    public mut prop javaPackage: String { get() { p_javaPackage.getOrThrow() } set(_x) { p_javaPackage = _x; markDirty() } }

    public func clearJavaOuterClassname() { p_javaOuterClassname = None; markDirty() }
    public prop hasJavaOuterClassname: Bool { get() { isPresent(p_javaOuterClassname) } }
    public mut prop javaOuterClassname: String { get() { p_javaOuterClassname.getOrThrow() } set(_x) { p_javaOuterClassname = _x; markDirty() } }

    public func clearJavaMultipleFiles() { p_javaMultipleFiles = None; markDirty() }
    public prop hasJavaMultipleFiles: Bool { get() { isPresent(p_javaMultipleFiles) } }
    public mut prop javaMultipleFiles: Bool { get() { p_javaMultipleFiles ?? false } set(_x) { p_javaMultipleFiles = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearJavaGenerateEqualsAndHash() { p_javaGenerateEqualsAndHash = None; markDirty() }
    public prop hasJavaGenerateEqualsAndHash: Bool { get() { isPresent(p_javaGenerateEqualsAndHash) } }
    public mut prop javaGenerateEqualsAndHash: Bool { get() { p_javaGenerateEqualsAndHash.getOrThrow() } set(_x) { p_javaGenerateEqualsAndHash = _x; markDirty() } }

    public func clearJavaStringCheckUtf8() { p_javaStringCheckUtf8 = None; markDirty() }
    public prop hasJavaStringCheckUtf8: Bool { get() { isPresent(p_javaStringCheckUtf8) } }
    public mut prop javaStringCheckUtf8: Bool { get() { p_javaStringCheckUtf8 ?? false } set(_x) { p_javaStringCheckUtf8 = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearOptimizeFor() { p_optimizeFor = None; markDirty() }
    public prop hasOptimizeFor: Bool { get() { isPresent(p_optimizeFor) } }
    public mut prop optimizeFor: FileOptions_OptimizeMode { get() { p_optimizeFor ?? SPEED } set(_x) { p_optimizeFor = if (_x == SPEED) { None } else { _x }; markDirty() } }

    public func clearGoPackage() { p_goPackage = None; markDirty() }
    public prop hasGoPackage: Bool { get() { isPresent(p_goPackage) } }
    public mut prop goPackage: String { get() { p_goPackage.getOrThrow() } set(_x) { p_goPackage = _x; markDirty() } }

    public func clearCcGenericServices() { p_ccGenericServices = None; markDirty() }
    public prop hasCcGenericServices: Bool { get() { isPresent(p_ccGenericServices) } }
    public mut prop ccGenericServices: Bool { get() { p_ccGenericServices ?? false } set(_x) { p_ccGenericServices = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearJavaGenericServices() { p_javaGenericServices = None; markDirty() }
    public prop hasJavaGenericServices: Bool { get() { isPresent(p_javaGenericServices) } }
    public mut prop javaGenericServices: Bool { get() { p_javaGenericServices ?? false } set(_x) { p_javaGenericServices = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearPyGenericServices() { p_pyGenericServices = None; markDirty() }
    public prop hasPyGenericServices: Bool { get() { isPresent(p_pyGenericServices) } }
    public mut prop pyGenericServices: Bool { get() { p_pyGenericServices ?? false } set(_x) { p_pyGenericServices = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearPhpGenericServices() { p_phpGenericServices = None; markDirty() }
    public prop hasPhpGenericServices: Bool { get() { isPresent(p_phpGenericServices) } }
    public mut prop phpGenericServices: Bool { get() { p_phpGenericServices ?? false } set(_x) { p_phpGenericServices = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearCcEnableArenas() { p_ccEnableArenas = None; markDirty() }
    public prop hasCcEnableArenas: Bool { get() { isPresent(p_ccEnableArenas) } }
    public mut prop ccEnableArenas: Bool { get() { p_ccEnableArenas ?? true } set(_x) { p_ccEnableArenas = if (_x == true) { None } else { _x }; markDirty() } }

    public func clearObjcClassPrefix() { p_objcClassPrefix = None; markDirty() }
    public prop hasObjcClassPrefix: Bool { get() { isPresent(p_objcClassPrefix) } }
    public mut prop objcClassPrefix: String { get() { p_objcClassPrefix.getOrThrow() } set(_x) { p_objcClassPrefix = _x; markDirty() } }

    public func clearCsharpNamespace() { p_csharpNamespace = None; markDirty() }
    public prop hasCsharpNamespace: Bool { get() { isPresent(p_csharpNamespace) } }
    public mut prop csharpNamespace: String { get() { p_csharpNamespace.getOrThrow() } set(_x) { p_csharpNamespace = _x; markDirty() } }

    public func clearSwiftPrefix() { p_swiftPrefix = None; markDirty() }
    public prop hasSwiftPrefix: Bool { get() { isPresent(p_swiftPrefix) } }
    public mut prop swiftPrefix: String { get() { p_swiftPrefix.getOrThrow() } set(_x) { p_swiftPrefix = _x; markDirty() } }

    public func clearPhpClassPrefix() { p_phpClassPrefix = None; markDirty() }
    public prop hasPhpClassPrefix: Bool { get() { isPresent(p_phpClassPrefix) } }
    public mut prop phpClassPrefix: String { get() { p_phpClassPrefix.getOrThrow() } set(_x) { p_phpClassPrefix = _x; markDirty() } }

    public func clearPhpNamespace() { p_phpNamespace = None; markDirty() }
    public prop hasPhpNamespace: Bool { get() { isPresent(p_phpNamespace) } }
    public mut prop phpNamespace: String { get() { p_phpNamespace.getOrThrow() } set(_x) { p_phpNamespace = _x; markDirty() } }

    public func clearPhpMetadataNamespace() { p_phpMetadataNamespace = None; markDirty() }
    public prop hasPhpMetadataNamespace: Bool { get() { isPresent(p_phpMetadataNamespace) } }
    public mut prop phpMetadataNamespace: String { get() { p_phpMetadataNamespace.getOrThrow() } set(_x) { p_phpMetadataNamespace = _x; markDirty() } }

    public func clearRubyPackage() { p_rubyPackage = None; markDirty() }
    public prop hasRubyPackage: Bool { get() { isPresent(p_rubyPackage) } }
    public mut prop rubyPackage: String { get() { p_rubyPackage.getOrThrow() } set(_x) { p_rubyPackage = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_javaPackage) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_javaOuterClassname) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_javaMultipleFiles) { _x += 1 + 1 }
        if (let Some(_v) <- p_javaGenerateEqualsAndHash) { _x += 2 + 1 }
        if (let Some(_v) <- p_javaStringCheckUtf8) { _x += 2 + 1 }
        if (let Some(_v) <- p_optimizeFor) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_goPackage) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_ccGenericServices) { _x += 2 + 1 }
        if (let Some(_v) <- p_javaGenericServices) { _x += 2 + 1 }
        if (let Some(_v) <- p_pyGenericServices) { _x += 2 + 1 }
        if (let Some(_v) <- p_phpGenericServices) { _x += 2 + 1 }
        if (let Some(_v) <- p_deprecated) { _x += 2 + 1 }
        if (let Some(_v) <- p_ccEnableArenas) { _x += 2 + 1 }
        if (let Some(_v) <- p_objcClassPrefix) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_csharpNamespace) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_swiftPrefix) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_phpClassPrefix) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_phpNamespace) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_phpMetadataNamespace) { _x += 2 + binSize(_v) }
        if (let Some(_v) <- p_rubyPackage) { _x += 2 + binSize(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_javaPackage) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_javaOuterClassname) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_javaMultipleFiles) { _x.write(_v) }
        if (let Some(_v) <- p_javaGenerateEqualsAndHash) { _x.write(_v) }
        if (let Some(_v) <- p_javaStringCheckUtf8) { _x.write(_v) }
        if (let Some(_v) <- p_optimizeFor) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_goPackage) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_ccGenericServices) { _x.write(_v) }
        if (let Some(_v) <- p_javaGenericServices) { _x.write(_v) }
        if (let Some(_v) <- p_pyGenericServices) { _x.write(_v) }
        if (let Some(_v) <- p_phpGenericServices) { _x.write(_v) }
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (let Some(_v) <- p_ccEnableArenas) { _x.write(_v) }
        if (let Some(_v) <- p_objcClassPrefix) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_csharpNamespace) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_swiftPrefix) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_phpClassPrefix) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_phpNamespace) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_phpMetadataNamespace) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_rubyPackage) { _x.write(_v.hashCode()) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_javaPackage) && isNone(p_javaOuterClassname) && isNone(p_javaMultipleFiles) &&
        isNone(p_javaGenerateEqualsAndHash) && isNone(p_javaStringCheckUtf8) && isNone(p_optimizeFor) &&
        isNone(p_goPackage) && isNone(p_ccGenericServices) && isNone(p_javaGenericServices) &&
        isNone(p_pyGenericServices) && isNone(p_phpGenericServices) && isNone(p_deprecated) &&
        isNone(p_ccEnableArenas) && isNone(p_objcClassPrefix) && isNone(p_csharpNamespace) && isNone(p_swiftPrefix) &&
        isNone(p_phpClassPrefix) && isNone(p_phpNamespace) && isNone(p_phpMetadataNamespace) && isNone(p_rubyPackage) &&
        uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_javaPackage = None
        p_javaOuterClassname = None
        p_javaMultipleFiles = None
        p_javaGenerateEqualsAndHash = None
        p_javaStringCheckUtf8 = None
        p_optimizeFor = None
        p_goPackage = None
        p_ccGenericServices = None
        p_javaGenericServices = None
        p_pyGenericServices = None
        p_phpGenericServices = None
        p_deprecated = None
        p_ccEnableArenas = None
        p_objcClassPrefix = None
        p_csharpNamespace = None
        p_swiftPrefix = None
        p_phpClassPrefix = None
        p_phpNamespace = None
        p_phpMetadataNamespace = None
        p_rubyPackage = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: FileOptions): Bool { !(this == src) }
    public operator func ==(src: FileOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_javaPackage == src.p_javaPackage && p_javaOuterClassname == src.p_javaOuterClassname &&
        p_javaMultipleFiles == src.p_javaMultipleFiles &&
        p_javaGenerateEqualsAndHash == src.p_javaGenerateEqualsAndHash &&
        p_javaStringCheckUtf8 == src.p_javaStringCheckUtf8 && p_optimizeFor == src.p_optimizeFor &&
        p_goPackage == src.p_goPackage && p_ccGenericServices == src.p_ccGenericServices &&
        p_javaGenericServices == src.p_javaGenericServices && p_pyGenericServices == src.p_pyGenericServices &&
        p_phpGenericServices == src.p_phpGenericServices && p_deprecated == src.p_deprecated &&
        p_ccEnableArenas == src.p_ccEnableArenas && p_objcClassPrefix == src.p_objcClassPrefix &&
        p_csharpNamespace == src.p_csharpNamespace && p_swiftPrefix == src.p_swiftPrefix &&
        p_phpClassPrefix == src.p_phpClassPrefix && p_phpNamespace == src.p_phpNamespace &&
        p_phpMetadataNamespace == src.p_phpMetadataNamespace && p_rubyPackage == src.p_rubyPackage &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: FileOptions): Unit {
        if (let Some(_v) <- src.p_javaPackage) { p_javaPackage = _v }
        if (let Some(_v) <- src.p_javaOuterClassname) { p_javaOuterClassname = _v }
        if (let Some(_v) <- src.p_javaMultipleFiles) { p_javaMultipleFiles = _v }
        if (let Some(_v) <- src.p_javaGenerateEqualsAndHash) { p_javaGenerateEqualsAndHash = _v }
        if (let Some(_v) <- src.p_javaStringCheckUtf8) { p_javaStringCheckUtf8 = _v }
        if (let Some(_v) <- src.p_optimizeFor) { p_optimizeFor = _v }
        if (let Some(_v) <- src.p_goPackage) { p_goPackage = _v }
        if (let Some(_v) <- src.p_ccGenericServices) { p_ccGenericServices = _v }
        if (let Some(_v) <- src.p_javaGenericServices) { p_javaGenericServices = _v }
        if (let Some(_v) <- src.p_pyGenericServices) { p_pyGenericServices = _v }
        if (let Some(_v) <- src.p_phpGenericServices) { p_phpGenericServices = _v }
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (let Some(_v) <- src.p_ccEnableArenas) { p_ccEnableArenas = _v }
        if (let Some(_v) <- src.p_objcClassPrefix) { p_objcClassPrefix = _v }
        if (let Some(_v) <- src.p_csharpNamespace) { p_csharpNamespace = _v }
        if (let Some(_v) <- src.p_swiftPrefix) { p_swiftPrefix = _v }
        if (let Some(_v) <- src.p_phpClassPrefix) { p_phpClassPrefix = _v }
        if (let Some(_v) <- src.p_phpNamespace) { p_phpNamespace = _v }
        if (let Some(_v) <- src.p_phpMetadataNamespace) { p_phpMetadataNamespace = _v }
        if (let Some(_v) <- src.p_rubyPackage) { p_rubyPackage = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FileOptions): FileOptions {
        p_javaPackage = src.p_javaPackage
        p_javaOuterClassname = src.p_javaOuterClassname
        p_javaMultipleFiles = src.p_javaMultipleFiles
        p_javaGenerateEqualsAndHash = src.p_javaGenerateEqualsAndHash
        p_javaStringCheckUtf8 = src.p_javaStringCheckUtf8
        p_optimizeFor = src.p_optimizeFor
        p_goPackage = src.p_goPackage
        p_ccGenericServices = src.p_ccGenericServices
        p_javaGenericServices = src.p_javaGenericServices
        p_pyGenericServices = src.p_pyGenericServices
        p_phpGenericServices = src.p_phpGenericServices
        p_deprecated = src.p_deprecated
        p_ccEnableArenas = src.p_ccEnableArenas
        p_objcClassPrefix = src.p_objcClassPrefix
        p_csharpNamespace = src.p_csharpNamespace
        p_swiftPrefix = src.p_swiftPrefix
        p_phpClassPrefix = src.p_phpClassPrefix
        p_phpNamespace = src.p_phpNamespace
        p_phpMetadataNamespace = src.p_phpMetadataNamespace
        p_rubyPackage = src.p_rubyPackage
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FileOptions {
        return FileOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_javaPackage = src.parseString()
                case 8 => p_javaOuterClassname = src.parseString()
                case 10 => javaMultipleFiles = src.parseBool()
                case 20 => p_javaGenerateEqualsAndHash = src.parseBool()
                case 27 => javaStringCheckUtf8 = src.parseBool()
                case 9 => optimizeFor = FileOptions_OptimizeMode.parse(src.parseInt32())
                case 11 => p_goPackage = src.parseString()
                case 16 => ccGenericServices = src.parseBool()
                case 17 => javaGenericServices = src.parseBool()
                case 18 => pyGenericServices = src.parseBool()
                case 42 => phpGenericServices = src.parseBool()
                case 23 => deprecated = src.parseBool()
                case 31 => ccEnableArenas = src.parseBool()
                case 36 => p_objcClassPrefix = src.parseString()
                case 37 => p_csharpNamespace = src.parseString()
                case 39 => p_swiftPrefix = src.parseString()
                case 40 => p_phpClassPrefix = src.parseString()
                case 41 => p_phpNamespace = src.parseString()
                case 44 => p_phpMetadataNamespace = src.parseString()
                case 45 => p_rubyPackage = src.parseString()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_javaPackage) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_javaOuterClassname) { out.append(66); out.packBin(_v) }
        if (let Some(_v) <- p_javaMultipleFiles) { out.append(80); out.packBool(_v) }
        if (let Some(_v) <- p_javaGenerateEqualsAndHash) { out.packTag(20, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_javaStringCheckUtf8) { out.packTag(27, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_optimizeFor) { out.append(72); out.packVarint(_v) }
        if (let Some(_v) <- p_goPackage) { out.append(90); out.packBin(_v) }
        if (let Some(_v) <- p_ccGenericServices) { out.packTag(16, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_javaGenericServices) { out.packTag(17, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_pyGenericServices) { out.packTag(18, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_phpGenericServices) { out.packTag(42, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_deprecated) { out.packTag(23, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_ccEnableArenas) { out.packTag(31, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_objcClassPrefix) { out.packTag(36, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_csharpNamespace) { out.packTag(37, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_swiftPrefix) { out.packTag(39, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_phpClassPrefix) { out.packTag(40, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_phpNamespace) { out.packTag(41, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_phpMetadataNamespace) { out.packTag(44, PREFIXED); out.packBin(_v) }
        if (let Some(_v) <- p_rubyPackage) { out.packTag(45, PREFIXED); out.packBin(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_javaPackage) { _x.append("javaPackage", _v) }
        if (let Some(_v) <- p_javaOuterClassname) { _x.append("javaOuterClassname", _v) }
        if (let Some(_v) <- p_javaMultipleFiles) { _x.append("javaMultipleFiles", _v) }
        if (let Some(_v) <- p_javaGenerateEqualsAndHash) { _x.append("javaGenerateEqualsAndHash", _v) }
        if (let Some(_v) <- p_javaStringCheckUtf8) { _x.append("javaStringCheckUtf8", _v) }
        if (let Some(_v) <- p_optimizeFor) { _x.append("optimizeFor", _v) }
        if (let Some(_v) <- p_goPackage) { _x.append("goPackage", _v) }
        if (let Some(_v) <- p_ccGenericServices) { _x.append("ccGenericServices", _v) }
        if (let Some(_v) <- p_javaGenericServices) { _x.append("javaGenericServices", _v) }
        if (let Some(_v) <- p_pyGenericServices) { _x.append("pyGenericServices", _v) }
        if (let Some(_v) <- p_phpGenericServices) { _x.append("phpGenericServices", _v) }
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (let Some(_v) <- p_ccEnableArenas) { _x.append("ccEnableArenas", _v) }
        if (let Some(_v) <- p_objcClassPrefix) { _x.append("objcClassPrefix", _v) }
        if (let Some(_v) <- p_csharpNamespace) { _x.append("csharpNamespace", _v) }
        if (let Some(_v) <- p_swiftPrefix) { _x.append("swiftPrefix", _v) }
        if (let Some(_v) <- p_phpClassPrefix) { _x.append("phpClassPrefix", _v) }
        if (let Some(_v) <- p_phpNamespace) { _x.append("phpNamespace", _v) }
        if (let Some(_v) <- p_phpMetadataNamespace) { _x.append("phpMetadataNamespace", _v) }
        if (let Some(_v) <- p_rubyPackage) { _x.append("rubyPackage", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FileOptions() }
    public static func newBuilder() { FileOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FileOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FileOptions(); _x.unpack(src); _x }
}

public class FileOptions__Builder {
    public var javaPackage: ?String = None
    public func setJavaPackage(javaPackage: String) { this.javaPackage = javaPackage; return this }

    public var javaOuterClassname: ?String = None
    public func setJavaOuterClassname(javaOuterClassname: String) { this.javaOuterClassname = javaOuterClassname; return this }

    public var javaMultipleFiles: ?Bool = None
    public func setJavaMultipleFiles(javaMultipleFiles: Bool) { this.javaMultipleFiles = javaMultipleFiles; return this }

    public var javaGenerateEqualsAndHash: ?Bool = None
    public func setJavaGenerateEqualsAndHash(javaGenerateEqualsAndHash: Bool) { this.javaGenerateEqualsAndHash = javaGenerateEqualsAndHash; return this }

    public var javaStringCheckUtf8: ?Bool = None
    public func setJavaStringCheckUtf8(javaStringCheckUtf8: Bool) { this.javaStringCheckUtf8 = javaStringCheckUtf8; return this }

    public var optimizeFor: ?FileOptions_OptimizeMode = None
    public func setOptimizeFor(optimizeFor: FileOptions_OptimizeMode) { this.optimizeFor = optimizeFor; return this }

    public var goPackage: ?String = None
    public func setGoPackage(goPackage: String) { this.goPackage = goPackage; return this }

    public var ccGenericServices: ?Bool = None
    public func setCcGenericServices(ccGenericServices: Bool) { this.ccGenericServices = ccGenericServices; return this }

    public var javaGenericServices: ?Bool = None
    public func setJavaGenericServices(javaGenericServices: Bool) { this.javaGenericServices = javaGenericServices; return this }

    public var pyGenericServices: ?Bool = None
    public func setPyGenericServices(pyGenericServices: Bool) { this.pyGenericServices = pyGenericServices; return this }

    public var phpGenericServices: ?Bool = None
    public func setPhpGenericServices(phpGenericServices: Bool) { this.phpGenericServices = phpGenericServices; return this }

    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var ccEnableArenas: ?Bool = None
    public func setCcEnableArenas(ccEnableArenas: Bool) { this.ccEnableArenas = ccEnableArenas; return this }

    public var objcClassPrefix: ?String = None
    public func setObjcClassPrefix(objcClassPrefix: String) { this.objcClassPrefix = objcClassPrefix; return this }

    public var csharpNamespace: ?String = None
    public func setCsharpNamespace(csharpNamespace: String) { this.csharpNamespace = csharpNamespace; return this }

    public var swiftPrefix: ?String = None
    public func setSwiftPrefix(swiftPrefix: String) { this.swiftPrefix = swiftPrefix; return this }

    public var phpClassPrefix: ?String = None
    public func setPhpClassPrefix(phpClassPrefix: String) { this.phpClassPrefix = phpClassPrefix; return this }

    public var phpNamespace: ?String = None
    public func setPhpNamespace(phpNamespace: String) { this.phpNamespace = phpNamespace; return this }

    public var phpMetadataNamespace: ?String = None
    public func setPhpMetadataNamespace(phpMetadataNamespace: String) { this.phpMetadataNamespace = phpMetadataNamespace; return this }

    public var rubyPackage: ?String = None
    public func setRubyPackage(rubyPackage: String) { this.rubyPackage = rubyPackage; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { FileOptions(this) }
}

public class MessageOptions <: MessageLite & TypedMessage<MessageOptions> {
    private var p_messageSetWireFormat: ?Bool
    private var p_noStandardDescriptorAccessor: ?Bool
    private var p_deprecated: ?Bool
    private var p_mapEntry: ?Bool
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        messageSetWireFormat!: ?Bool = None,
        noStandardDescriptorAccessor!: ?Bool = None,
        deprecated!: ?Bool = None,
        mapEntry!: ?Bool = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_messageSetWireFormat = if (messageSetWireFormat != false) { messageSetWireFormat } else { None }
        this.p_noStandardDescriptorAccessor = if (noStandardDescriptorAccessor != false) { noStandardDescriptorAccessor } else { None }
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.p_mapEntry = mapEntry
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: MessageOptions__Builder) {
        this.p_messageSetWireFormat = if (src.messageSetWireFormat != false) { src.messageSetWireFormat } else { None }
        this.p_noStandardDescriptorAccessor = if (src.noStandardDescriptorAccessor != false) { src.noStandardDescriptorAccessor } else { None }
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.p_mapEntry = src.mapEntry
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearMessageSetWireFormat() { p_messageSetWireFormat = None; markDirty() }
    public prop hasMessageSetWireFormat: Bool { get() { isPresent(p_messageSetWireFormat) } }
    public mut prop messageSetWireFormat: Bool { get() { p_messageSetWireFormat ?? false } set(_x) { p_messageSetWireFormat = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearNoStandardDescriptorAccessor() { p_noStandardDescriptorAccessor = None; markDirty() }
    public prop hasNoStandardDescriptorAccessor: Bool { get() { isPresent(p_noStandardDescriptorAccessor) } }
    public mut prop noStandardDescriptorAccessor: Bool { get() { p_noStandardDescriptorAccessor ?? false } set(_x) { p_noStandardDescriptorAccessor = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearMapEntry() { p_mapEntry = None; markDirty() }
    public prop hasMapEntry: Bool { get() { isPresent(p_mapEntry) } }
    public mut prop mapEntry: Bool { get() { p_mapEntry.getOrThrow() } set(_x) { p_mapEntry = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_messageSetWireFormat) { _x += 1 + 1 }
        if (let Some(_v) <- p_noStandardDescriptorAccessor) { _x += 1 + 1 }
        if (let Some(_v) <- p_deprecated) { _x += 1 + 1 }
        if (let Some(_v) <- p_mapEntry) { _x += 1 + 1 }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_messageSetWireFormat) { _x.write(_v) }
        if (let Some(_v) <- p_noStandardDescriptorAccessor) { _x.write(_v) }
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (let Some(_v) <- p_mapEntry) { _x.write(_v) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_messageSetWireFormat) && isNone(p_noStandardDescriptorAccessor) && isNone(p_deprecated) &&
        isNone(p_mapEntry) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_messageSetWireFormat = None
        p_noStandardDescriptorAccessor = None
        p_deprecated = None
        p_mapEntry = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: MessageOptions): Bool { !(this == src) }
    public operator func ==(src: MessageOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_messageSetWireFormat == src.p_messageSetWireFormat &&
        p_noStandardDescriptorAccessor == src.p_noStandardDescriptorAccessor && p_deprecated == src.p_deprecated &&
        p_mapEntry == src.p_mapEntry && uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: MessageOptions): Unit {
        if (let Some(_v) <- src.p_messageSetWireFormat) { p_messageSetWireFormat = _v }
        if (let Some(_v) <- src.p_noStandardDescriptorAccessor) { p_noStandardDescriptorAccessor = _v }
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (let Some(_v) <- src.p_mapEntry) { p_mapEntry = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: MessageOptions): MessageOptions {
        p_messageSetWireFormat = src.p_messageSetWireFormat
        p_noStandardDescriptorAccessor = src.p_noStandardDescriptorAccessor
        p_deprecated = src.p_deprecated
        p_mapEntry = src.p_mapEntry
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): MessageOptions {
        return MessageOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => messageSetWireFormat = src.parseBool()
                case 2 => noStandardDescriptorAccessor = src.parseBool()
                case 3 => deprecated = src.parseBool()
                case 7 => p_mapEntry = src.parseBool()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_messageSetWireFormat) { out.append(8); out.packBool(_v) }
        if (let Some(_v) <- p_noStandardDescriptorAccessor) { out.append(16); out.packBool(_v) }
        if (let Some(_v) <- p_deprecated) { out.append(24); out.packBool(_v) }
        if (let Some(_v) <- p_mapEntry) { out.append(56); out.packBool(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_messageSetWireFormat) { _x.append("messageSetWireFormat", _v) }
        if (let Some(_v) <- p_noStandardDescriptorAccessor) { _x.append("noStandardDescriptorAccessor", _v) }
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (let Some(_v) <- p_mapEntry) { _x.append("mapEntry", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { MessageOptions() }
    public static func newBuilder() { MessageOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = MessageOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = MessageOptions(); _x.unpack(src); _x }
}

public class MessageOptions__Builder {
    public var messageSetWireFormat: ?Bool = None
    public func setMessageSetWireFormat(messageSetWireFormat: Bool) { this.messageSetWireFormat = messageSetWireFormat; return this }

    public var noStandardDescriptorAccessor: ?Bool = None
    public func setNoStandardDescriptorAccessor(noStandardDescriptorAccessor: Bool) { this.noStandardDescriptorAccessor = noStandardDescriptorAccessor; return this }

    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var mapEntry: ?Bool = None
    public func setMapEntry(mapEntry: Bool) { this.mapEntry = mapEntry; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { MessageOptions(this) }
}

public enum FieldOptions_CType <: Enum<FieldOptions_CType> {
    STRING | CORD | STRING_PIECE

    public func value(): Int32 {
        match(this) {
            case STRING => 0
            case CORD => 1
            case STRING_PIECE => 2
        }
    }

    public func toString(): String {
        match(this) {
            case STRING => "STRING"
            case CORD => "CORD"
            case STRING_PIECE => "STRING_PIECE"
        }
    }

    public operator func==(value: FieldOptions_CType) {
        match((this, value)) {
            case (STRING, STRING) => true
            case (CORD, CORD) => true
            case (STRING_PIECE, STRING_PIECE) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): FieldOptions_CType {
        match(value) {
            case 0 => STRING
            case 1 => CORD
            case 2 => STRING_PIECE
            case _ => throw InvalidEnumValueException("FieldOptions_CType", value)
        }
    }

    public static func parse(value: String): FieldOptions_CType {
        match(value) {
            case "STRING" => STRING
            case "CORD" => CORD
            case "STRING_PIECE" => STRING_PIECE
            case _ => throw UnmatchedEnumStringException("FieldOptions_CType", value)
        }
    }
}

public enum FieldOptions_JSType <: Enum<FieldOptions_JSType> {
    JS_NORMAL | JS_STRING | JS_NUMBER

    public func value(): Int32 {
        match(this) {
            case JS_NORMAL => 0
            case JS_STRING => 1
            case JS_NUMBER => 2
        }
    }

    public func toString(): String {
        match(this) {
            case JS_NORMAL => "JS_NORMAL"
            case JS_STRING => "JS_STRING"
            case JS_NUMBER => "JS_NUMBER"
        }
    }

    public operator func==(value: FieldOptions_JSType) {
        match((this, value)) {
            case (JS_NORMAL, JS_NORMAL) => true
            case (JS_STRING, JS_STRING) => true
            case (JS_NUMBER, JS_NUMBER) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): FieldOptions_JSType {
        match(value) {
            case 0 => JS_NORMAL
            case 1 => JS_STRING
            case 2 => JS_NUMBER
            case _ => throw InvalidEnumValueException("FieldOptions_JSType", value)
        }
    }

    public static func parse(value: String): FieldOptions_JSType {
        match(value) {
            case "JS_NORMAL" => JS_NORMAL
            case "JS_STRING" => JS_STRING
            case "JS_NUMBER" => JS_NUMBER
            case _ => throw UnmatchedEnumStringException("FieldOptions_JSType", value)
        }
    }
}

public class FieldOptions <: MessageLite & TypedMessage<FieldOptions> {
    private var p_ctype: ?FieldOptions_CType
    private var p_packed: ?Bool
    private var p_jstype: ?FieldOptions_JSType
    private var p_lazy: ?Bool
    private var p_unverifiedLazy: ?Bool
    private var p_deprecated: ?Bool
    private var p_weak: ?Bool
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        ctype!: ?FieldOptions_CType = None,
        packed!: ?Bool = None,
        jstype!: ?FieldOptions_JSType = None,
        lazy!: ?Bool = None,
        unverifiedLazy!: ?Bool = None,
        deprecated!: ?Bool = None,
        weak!: ?Bool = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_ctype = if (ctype != STRING) { ctype } else { None }
        this.p_packed = packed
        this.p_jstype = if (jstype != JS_NORMAL) { jstype } else { None }
        this.p_lazy = if (lazy != false) { lazy } else { None }
        this.p_unverifiedLazy = if (unverifiedLazy != false) { unverifiedLazy } else { None }
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.p_weak = if (weak != false) { weak } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: FieldOptions__Builder) {
        this.p_ctype = if (src.ctype != STRING) { src.ctype } else { None }
        this.p_packed = src.packed
        this.p_jstype = if (src.jstype != JS_NORMAL) { src.jstype } else { None }
        this.p_lazy = if (src.lazy != false) { src.lazy } else { None }
        this.p_unverifiedLazy = if (src.unverifiedLazy != false) { src.unverifiedLazy } else { None }
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.p_weak = if (src.weak != false) { src.weak } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearCtype() { p_ctype = None; markDirty() }
    public prop hasCtype: Bool { get() { isPresent(p_ctype) } }
    public mut prop ctype: FieldOptions_CType { get() { p_ctype ?? STRING } set(_x) { p_ctype = if (_x == STRING) { None } else { _x }; markDirty() } }

    public func clearPacked() { p_packed = None; markDirty() }
    public prop hasPacked: Bool { get() { isPresent(p_packed) } }
    public mut prop packed: Bool { get() { p_packed.getOrThrow() } set(_x) { p_packed = _x; markDirty() } }

    public func clearJstype() { p_jstype = None; markDirty() }
    public prop hasJstype: Bool { get() { isPresent(p_jstype) } }
    public mut prop jstype: FieldOptions_JSType { get() { p_jstype ?? JS_NORMAL } set(_x) { p_jstype = if (_x == JS_NORMAL) { None } else { _x }; markDirty() } }

    public func clearLazy() { p_lazy = None; markDirty() }
    public prop hasLazy: Bool { get() { isPresent(p_lazy) } }
    public mut prop lazy: Bool { get() { p_lazy ?? false } set(_x) { p_lazy = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearUnverifiedLazy() { p_unverifiedLazy = None; markDirty() }
    public prop hasUnverifiedLazy: Bool { get() { isPresent(p_unverifiedLazy) } }
    public mut prop unverifiedLazy: Bool { get() { p_unverifiedLazy ?? false } set(_x) { p_unverifiedLazy = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearWeak() { p_weak = None; markDirty() }
    public prop hasWeak: Bool { get() { isPresent(p_weak) } }
    public mut prop weak: Bool { get() { p_weak ?? false } set(_x) { p_weak = if (_x == false) { None } else { _x }; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_ctype) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_packed) { _x += 1 + 1 }
        if (let Some(_v) <- p_jstype) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_lazy) { _x += 1 + 1 }
        if (let Some(_v) <- p_unverifiedLazy) { _x += 1 + 1 }
        if (let Some(_v) <- p_deprecated) { _x += 1 + 1 }
        if (let Some(_v) <- p_weak) { _x += 1 + 1 }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_ctype) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_packed) { _x.write(_v) }
        if (let Some(_v) <- p_jstype) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_lazy) { _x.write(_v) }
        if (let Some(_v) <- p_unverifiedLazy) { _x.write(_v) }
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (let Some(_v) <- p_weak) { _x.write(_v) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_ctype) && isNone(p_packed) && isNone(p_jstype) && isNone(p_lazy) && isNone(p_unverifiedLazy) &&
        isNone(p_deprecated) && isNone(p_weak) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_ctype = None
        p_packed = None
        p_jstype = None
        p_lazy = None
        p_unverifiedLazy = None
        p_deprecated = None
        p_weak = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: FieldOptions): Bool { !(this == src) }
    public operator func ==(src: FieldOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_ctype == src.p_ctype && p_packed == src.p_packed && p_jstype == src.p_jstype && p_lazy == src.p_lazy &&
        p_unverifiedLazy == src.p_unverifiedLazy && p_deprecated == src.p_deprecated && p_weak == src.p_weak &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: FieldOptions): Unit {
        if (let Some(_v) <- src.p_ctype) { p_ctype = _v }
        if (let Some(_v) <- src.p_packed) { p_packed = _v }
        if (let Some(_v) <- src.p_jstype) { p_jstype = _v }
        if (let Some(_v) <- src.p_lazy) { p_lazy = _v }
        if (let Some(_v) <- src.p_unverifiedLazy) { p_unverifiedLazy = _v }
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (let Some(_v) <- src.p_weak) { p_weak = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FieldOptions): FieldOptions {
        p_ctype = src.p_ctype
        p_packed = src.p_packed
        p_jstype = src.p_jstype
        p_lazy = src.p_lazy
        p_unverifiedLazy = src.p_unverifiedLazy
        p_deprecated = src.p_deprecated
        p_weak = src.p_weak
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FieldOptions {
        return FieldOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => ctype = FieldOptions_CType.parse(src.parseInt32())
                case 2 => p_packed = src.parseBool()
                case 6 => jstype = FieldOptions_JSType.parse(src.parseInt32())
                case 5 => lazy = src.parseBool()
                case 15 => unverifiedLazy = src.parseBool()
                case 3 => deprecated = src.parseBool()
                case 10 => weak = src.parseBool()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_ctype) { out.append(8); out.packVarint(_v) }
        if (let Some(_v) <- p_packed) { out.append(16); out.packBool(_v) }
        if (let Some(_v) <- p_jstype) { out.append(48); out.packVarint(_v) }
        if (let Some(_v) <- p_lazy) { out.append(40); out.packBool(_v) }
        if (let Some(_v) <- p_unverifiedLazy) { out.append(120); out.packBool(_v) }
        if (let Some(_v) <- p_deprecated) { out.append(24); out.packBool(_v) }
        if (let Some(_v) <- p_weak) { out.append(80); out.packBool(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_ctype) { _x.append("ctype", _v) }
        if (let Some(_v) <- p_packed) { _x.append("packed", _v) }
        if (let Some(_v) <- p_jstype) { _x.append("jstype", _v) }
        if (let Some(_v) <- p_lazy) { _x.append("lazy", _v) }
        if (let Some(_v) <- p_unverifiedLazy) { _x.append("unverifiedLazy", _v) }
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (let Some(_v) <- p_weak) { _x.append("weak", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FieldOptions() }
    public static func newBuilder() { FieldOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FieldOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FieldOptions(); _x.unpack(src); _x }
}

public class FieldOptions__Builder {
    public var ctype: ?FieldOptions_CType = None
    public func setCtype(ctype: FieldOptions_CType) { this.ctype = ctype; return this }

    public var packed: ?Bool = None
    public func setPacked(packed: Bool) { this.packed = packed; return this }

    public var jstype: ?FieldOptions_JSType = None
    public func setJstype(jstype: FieldOptions_JSType) { this.jstype = jstype; return this }

    public var lazy: ?Bool = None
    public func setLazy(lazy: Bool) { this.lazy = lazy; return this }

    public var unverifiedLazy: ?Bool = None
    public func setUnverifiedLazy(unverifiedLazy: Bool) { this.unverifiedLazy = unverifiedLazy; return this }

    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var weak: ?Bool = None
    public func setWeak(weak: Bool) { this.weak = weak; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { FieldOptions(this) }
}

public class OneofOptions <: MessageLite & TypedMessage<OneofOptions> {
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: OneofOptions__Builder) {
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    protected func m_size(): Int64 {
        var _x = 0
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        uninterpretedOption.clear()
    }

    public operator func !=(src: OneofOptions): Bool { !(this == src) }
    public operator func ==(src: OneofOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: OneofOptions): Unit {
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: OneofOptions): OneofOptions {
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): OneofOptions {
        return OneofOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { OneofOptions() }
    public static func newBuilder() { OneofOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = OneofOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = OneofOptions(); _x.unpack(src); _x }
}

public class OneofOptions__Builder {
    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { OneofOptions(this) }
}

public class EnumOptions <: MessageLite & TypedMessage<EnumOptions> {
    private var p_allowAlias: ?Bool
    private var p_deprecated: ?Bool
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        allowAlias!: ?Bool = None,
        deprecated!: ?Bool = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_allowAlias = allowAlias
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: EnumOptions__Builder) {
        this.p_allowAlias = src.allowAlias
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearAllowAlias() { p_allowAlias = None; markDirty() }
    public prop hasAllowAlias: Bool { get() { isPresent(p_allowAlias) } }
    public mut prop allowAlias: Bool { get() { p_allowAlias.getOrThrow() } set(_x) { p_allowAlias = _x; markDirty() } }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_allowAlias) { _x += 1 + 1 }
        if (let Some(_v) <- p_deprecated) { _x += 1 + 1 }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_allowAlias) { _x.write(_v) }
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_allowAlias) && isNone(p_deprecated) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_allowAlias = None
        p_deprecated = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: EnumOptions): Bool { !(this == src) }
    public operator func ==(src: EnumOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_allowAlias == src.p_allowAlias && p_deprecated == src.p_deprecated &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: EnumOptions): Unit {
        if (let Some(_v) <- src.p_allowAlias) { p_allowAlias = _v }
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: EnumOptions): EnumOptions {
        p_allowAlias = src.p_allowAlias
        p_deprecated = src.p_deprecated
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): EnumOptions {
        return EnumOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 2 => p_allowAlias = src.parseBool()
                case 3 => deprecated = src.parseBool()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_allowAlias) { out.append(16); out.packBool(_v) }
        if (let Some(_v) <- p_deprecated) { out.append(24); out.packBool(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_allowAlias) { _x.append("allowAlias", _v) }
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { EnumOptions() }
    public static func newBuilder() { EnumOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = EnumOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = EnumOptions(); _x.unpack(src); _x }
}

public class EnumOptions__Builder {
    public var allowAlias: ?Bool = None
    public func setAllowAlias(allowAlias: Bool) { this.allowAlias = allowAlias; return this }

    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { EnumOptions(this) }
}

public class EnumValueOptions <: MessageLite & TypedMessage<EnumValueOptions> {
    private var p_deprecated: ?Bool
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        deprecated!: ?Bool = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: EnumValueOptions__Builder) {
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_deprecated) { _x += 1 + 1 }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_deprecated) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_deprecated = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: EnumValueOptions): Bool { !(this == src) }
    public operator func ==(src: EnumValueOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_deprecated == src.p_deprecated && uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: EnumValueOptions): Unit {
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: EnumValueOptions): EnumValueOptions {
        p_deprecated = src.p_deprecated
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): EnumValueOptions {
        return EnumValueOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => deprecated = src.parseBool()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_deprecated) { out.append(8); out.packBool(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { EnumValueOptions() }
    public static func newBuilder() { EnumValueOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = EnumValueOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = EnumValueOptions(); _x.unpack(src); _x }
}

public class EnumValueOptions__Builder {
    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { EnumValueOptions(this) }
}

public class ServiceOptions <: MessageLite & TypedMessage<ServiceOptions> {
    private var p_deprecated: ?Bool
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        deprecated!: ?Bool = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: ServiceOptions__Builder) {
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_deprecated) { _x += 2 + 1 }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_deprecated) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_deprecated = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: ServiceOptions): Bool { !(this == src) }
    public operator func ==(src: ServiceOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_deprecated == src.p_deprecated && uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: ServiceOptions): Unit {
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ServiceOptions): ServiceOptions {
        p_deprecated = src.p_deprecated
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ServiceOptions {
        return ServiceOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 33 => deprecated = src.parseBool()
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_deprecated) { out.packTag(33, VARINT); out.packBool(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ServiceOptions() }
    public static func newBuilder() { ServiceOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ServiceOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ServiceOptions(); _x.unpack(src); _x }
}

public class ServiceOptions__Builder {
    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { ServiceOptions(this) }
}

public enum MethodOptions_IdempotencyLevel <: Enum<MethodOptions_IdempotencyLevel> {
    IDEMPOTENCY_UNKNOWN | NO_SIDE_EFFECTS | IDEMPOTENT

    public func value(): Int32 {
        match(this) {
            case IDEMPOTENCY_UNKNOWN => 0
            case NO_SIDE_EFFECTS => 1
            case IDEMPOTENT => 2
        }
    }

    public func toString(): String {
        match(this) {
            case IDEMPOTENCY_UNKNOWN => "IDEMPOTENCY_UNKNOWN"
            case NO_SIDE_EFFECTS => "NO_SIDE_EFFECTS"
            case IDEMPOTENT => "IDEMPOTENT"
        }
    }

    public operator func==(value: MethodOptions_IdempotencyLevel) {
        match((this, value)) {
            case (IDEMPOTENCY_UNKNOWN, IDEMPOTENCY_UNKNOWN) => true
            case (NO_SIDE_EFFECTS, NO_SIDE_EFFECTS) => true
            case (IDEMPOTENT, IDEMPOTENT) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): MethodOptions_IdempotencyLevel {
        match(value) {
            case 0 => IDEMPOTENCY_UNKNOWN
            case 1 => NO_SIDE_EFFECTS
            case 2 => IDEMPOTENT
            case _ => throw InvalidEnumValueException("MethodOptions_IdempotencyLevel", value)
        }
    }

    public static func parse(value: String): MethodOptions_IdempotencyLevel {
        match(value) {
            case "IDEMPOTENCY_UNKNOWN" => IDEMPOTENCY_UNKNOWN
            case "NO_SIDE_EFFECTS" => NO_SIDE_EFFECTS
            case "IDEMPOTENT" => IDEMPOTENT
            case _ => throw UnmatchedEnumStringException("MethodOptions_IdempotencyLevel", value)
        }
    }
}

public class MethodOptions <: MessageLite & TypedMessage<MethodOptions> {
    private var p_deprecated: ?Bool
    private var p_idempotencyLevel: ?MethodOptions_IdempotencyLevel
    public let uninterpretedOption: RepeatedMessage<UninterpretedOption>

    public init(
        deprecated!: ?Bool = None,
        idempotencyLevel!: ?MethodOptions_IdempotencyLevel = None,
        uninterpretedOption!: Array<UninterpretedOption> = []
    ) {
        this.p_deprecated = if (deprecated != false) { deprecated } else { None }
        this.p_idempotencyLevel = if (idempotencyLevel != IDEMPOTENCY_UNKNOWN) { idempotencyLevel } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(uninterpretedOption)
        m_init()
    }

    public init(src: MethodOptions__Builder) {
        this.p_deprecated = if (src.deprecated != false) { src.deprecated } else { None }
        this.p_idempotencyLevel = if (src.idempotencyLevel != IDEMPOTENCY_UNKNOWN) { src.idempotencyLevel } else { None }
        this.uninterpretedOption = RepeatedMessage<UninterpretedOption>(src.uninterpretedOption)
        m_init()
    }

    private func m_init() {
        m_init(uninterpretedOption)
        m_innerInit()
    }

    public func clearDeprecated() { p_deprecated = None; markDirty() }
    public prop hasDeprecated: Bool { get() { isPresent(p_deprecated) } }
    public mut prop deprecated: Bool { get() { p_deprecated ?? false } set(_x) { p_deprecated = if (_x == false) { None } else { _x }; markDirty() } }

    public func clearIdempotencyLevel() { p_idempotencyLevel = None; markDirty() }
    public prop hasIdempotencyLevel: Bool { get() { isPresent(p_idempotencyLevel) } }
    public mut prop idempotencyLevel: MethodOptions_IdempotencyLevel { get() { p_idempotencyLevel ?? IDEMPOTENCY_UNKNOWN } set(_x) { p_idempotencyLevel = if (_x == IDEMPOTENCY_UNKNOWN) { None } else { _x }; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_deprecated) { _x += 2 + 1 }
        if (let Some(_v) <- p_idempotencyLevel) { _x += 2 + varintSize(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { _x += 2 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_deprecated) { _x.write(_v) }
        if (let Some(_v) <- p_idempotencyLevel) { _x.write(_v.hashCode()) }
        if (!uninterpretedOption.isEmpty()) { _x.write(uninterpretedOption.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_deprecated) && isNone(p_idempotencyLevel) && uninterpretedOption.isEmpty()
    }

    protected func m_clear(): Unit {
        p_deprecated = None
        p_idempotencyLevel = None
        uninterpretedOption.clear()
    }

    public operator func !=(src: MethodOptions): Bool { !(this == src) }
    public operator func ==(src: MethodOptions): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_deprecated == src.p_deprecated && p_idempotencyLevel == src.p_idempotencyLevel &&
        uninterpretedOption == src.uninterpretedOption
    }

    public func mergeFrom(src: MethodOptions): Unit {
        if (let Some(_v) <- src.p_deprecated) { p_deprecated = _v }
        if (let Some(_v) <- src.p_idempotencyLevel) { p_idempotencyLevel = _v }
        if (!src.uninterpretedOption.isEmpty()) { uninterpretedOption.appendAll(src.uninterpretedOption) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: MethodOptions): MethodOptions {
        p_deprecated = src.p_deprecated
        p_idempotencyLevel = src.p_idempotencyLevel
        uninterpretedOption.copyFrom(src.uninterpretedOption)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): MethodOptions {
        return MethodOptions().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 33 => deprecated = src.parseBool()
                case 34 => idempotencyLevel = MethodOptions_IdempotencyLevel.parse(src.parseInt32())
                case 999 => s_add(uninterpretedOption, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_deprecated) { out.packTag(33, VARINT); out.packBool(_v) }
        if (let Some(_v) <- p_idempotencyLevel) { out.packTag(34, VARINT); out.packVarint(_v) }
        if (!uninterpretedOption.isEmpty()) { for (_i in uninterpretedOption) { out.packTag(999, PREFIXED); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_deprecated) { _x.append("deprecated", _v) }
        if (let Some(_v) <- p_idempotencyLevel) { _x.append("idempotencyLevel", _v) }
        if (!uninterpretedOption.isEmpty()) { _x.append("uninterpretedOption", uninterpretedOption) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { MethodOptions() }
    public static func newBuilder() { MethodOptions__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = MethodOptions(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = MethodOptions(); _x.unpack(src); _x }
}

public class MethodOptions__Builder {
    public var deprecated: ?Bool = None
    public func setDeprecated(deprecated: Bool) { this.deprecated = deprecated; return this }

    public var idempotencyLevel: ?MethodOptions_IdempotencyLevel = None
    public func setIdempotencyLevel(idempotencyLevel: MethodOptions_IdempotencyLevel) { this.idempotencyLevel = idempotencyLevel; return this }

    public var uninterpretedOption: Array<UninterpretedOption> = []
    public func setUninterpretedOption(uninterpretedOption: Array<UninterpretedOption>) { this.uninterpretedOption = uninterpretedOption; return this }

    public func build() { MethodOptions(this) }
}

public class UninterpretedOption_NamePart <: MessageLite & TypedMessage<UninterpretedOption_NamePart> {
    private var p_namePart: ?String
    private var p_isExtension: ?Bool

    public init(
        namePart!: ?String = None,
        isExtension!: ?Bool = None
    ) {
        this.p_namePart = namePart
        this.p_isExtension = isExtension
        m_init()
    }

    public init(src: UninterpretedOption_NamePart__Builder) {
        this.p_namePart = src.namePart
        this.p_isExtension = src.isExtension
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public func clearNamePart() { p_namePart = None; markDirty() }
    public prop hasNamePart: Bool { get() { isPresent(p_namePart) } }
    public mut prop namePart: String { get() { p_namePart.getOrThrow() } set(_x) { p_namePart = _x; markDirty() } }

    public func clearIsExtension() { p_isExtension = None; markDirty() }
    public prop hasIsExtension: Bool { get() { isPresent(p_isExtension) } }
    public mut prop isExtension: Bool { get() { p_isExtension.getOrThrow() } set(_x) { p_isExtension = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_namePart) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_isExtension) { _x += 1 + 1 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_namePart) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_isExtension) { _x.write(_v) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_namePart) && isNone(p_isExtension)
    }

    protected func m_clear(): Unit {
        p_namePart = None
        p_isExtension = None
    }

    public operator func !=(src: UninterpretedOption_NamePart): Bool { !(this == src) }
    public operator func ==(src: UninterpretedOption_NamePart): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_namePart == src.p_namePart && p_isExtension == src.p_isExtension
    }

    public func mergeFrom(src: UninterpretedOption_NamePart): Unit {
        if (let Some(_v) <- src.p_namePart) { p_namePart = _v }
        if (let Some(_v) <- src.p_isExtension) { p_isExtension = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: UninterpretedOption_NamePart): UninterpretedOption_NamePart {
        p_namePart = src.p_namePart
        p_isExtension = src.p_isExtension
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): UninterpretedOption_NamePart {
        return UninterpretedOption_NamePart().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_namePart = src.parseString()
                case 2 => p_isExtension = src.parseBool()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
        if (isNone(p_namePart)) { throw RequiredFieldNotSetException("namePart") }
        if (isNone(p_isExtension)) { throw RequiredFieldNotSetException("isExtension") }
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_namePart) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_isExtension) { out.append(16); out.packBool(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_namePart) { _x.append("namePart", _v) }
        if (let Some(_v) <- p_isExtension) { _x.append("isExtension", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { UninterpretedOption_NamePart() }
    public static func newBuilder() { UninterpretedOption_NamePart__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = UninterpretedOption_NamePart(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = UninterpretedOption_NamePart(); _x.unpack(src); _x }
}

public class UninterpretedOption_NamePart__Builder {
    public var namePart: ?String = None
    public func setNamePart(namePart: String) { this.namePart = namePart; return this }

    public var isExtension: ?Bool = None
    public func setIsExtension(isExtension: Bool) { this.isExtension = isExtension; return this }

    public func build() { UninterpretedOption_NamePart(this) }
}

public class UninterpretedOption <: MessageLite & TypedMessage<UninterpretedOption> {
    public let name: RepeatedMessage<UninterpretedOption_NamePart>
    private var p_identifierValue: ?String
    private var p_positiveIntValue: ?UInt64
    private var p_negativeIntValue: ?Int64
    private var p_doubleValue: ?Float64
    private var p_stringValue: ?BytesSlice
    private var p_aggregateValue: ?String

    public init(
        name!: Array<UninterpretedOption_NamePart> = [],
        identifierValue!: ?String = None,
        positiveIntValue!: ?UInt64 = None,
        negativeIntValue!: ?Int64 = None,
        doubleValue!: ?Float64 = None,
        stringValue!: ?BytesSlice = None,
        aggregateValue!: ?String = None
    ) {
        this.name = RepeatedMessage<UninterpretedOption_NamePart>(name)
        this.p_identifierValue = identifierValue
        this.p_positiveIntValue = positiveIntValue
        this.p_negativeIntValue = negativeIntValue
        this.p_doubleValue = doubleValue
        this.p_stringValue = stringValue
        this.p_aggregateValue = aggregateValue
        m_init()
    }

    public init(src: UninterpretedOption__Builder) {
        this.name = RepeatedMessage<UninterpretedOption_NamePart>(src.name)
        this.p_identifierValue = src.identifierValue
        this.p_positiveIntValue = src.positiveIntValue
        this.p_negativeIntValue = src.negativeIntValue
        this.p_doubleValue = src.doubleValue
        this.p_stringValue = src.stringValue
        this.p_aggregateValue = src.aggregateValue
        m_init()
    }

    private func m_init() {
        m_init(name)
        m_innerInit()
    }

    public func clearIdentifierValue() { p_identifierValue = None; markDirty() }
    public prop hasIdentifierValue: Bool { get() { isPresent(p_identifierValue) } }
    public mut prop identifierValue: String { get() { p_identifierValue.getOrThrow() } set(_x) { p_identifierValue = _x; markDirty() } }

    public func clearPositiveIntValue() { p_positiveIntValue = None; markDirty() }
    public prop hasPositiveIntValue: Bool { get() { isPresent(p_positiveIntValue) } }
    public mut prop positiveIntValue: UInt64 { get() { p_positiveIntValue.getOrThrow() } set(_x) { p_positiveIntValue = _x; markDirty() } }

    public func clearNegativeIntValue() { p_negativeIntValue = None; markDirty() }
    public prop hasNegativeIntValue: Bool { get() { isPresent(p_negativeIntValue) } }
    public mut prop negativeIntValue: Int64 { get() { p_negativeIntValue.getOrThrow() } set(_x) { p_negativeIntValue = _x; markDirty() } }

    public func clearDoubleValue() { p_doubleValue = None; markDirty() }
    public prop hasDoubleValue: Bool { get() { isPresent(p_doubleValue) } }
    public mut prop doubleValue: Float64 { get() { p_doubleValue.getOrThrow() } set(_x) { p_doubleValue = _x; markDirty() } }

    public func clearStringValue() { p_stringValue = None; markDirty() }
    public prop hasStringValue: Bool { get() { isPresent(p_stringValue) } }
    public mut prop stringValue: BytesSlice { get() { p_stringValue.getOrThrow() } set(_x) { p_stringValue = _x; markDirty() } }

    public func clearAggregateValue() { p_aggregateValue = None; markDirty() }
    public prop hasAggregateValue: Bool { get() { isPresent(p_aggregateValue) } }
    public mut prop aggregateValue: String { get() { p_aggregateValue.getOrThrow() } set(_x) { p_aggregateValue = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!name.isEmpty()) { for (_i in name) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_identifierValue) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_positiveIntValue) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_negativeIntValue) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_doubleValue) { _x += 1 + 8 }
        if (let Some(_v) <- p_stringValue) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_aggregateValue) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!name.isEmpty()) { _x.write(name.hashCode()) }
        if (let Some(_v) <- p_identifierValue) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_positiveIntValue) { _x.write(_v) }
        if (let Some(_v) <- p_negativeIntValue) { _x.write(_v) }
        if (let Some(_v) <- p_doubleValue) { _x.write(_v) }
        if (let Some(_v) <- p_stringValue) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_aggregateValue) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        name.isEmpty() && isNone(p_identifierValue) && isNone(p_positiveIntValue) && isNone(p_negativeIntValue) &&
        isNone(p_doubleValue) && isNone(p_stringValue) && isNone(p_aggregateValue)
    }

    protected func m_clear(): Unit {
        name.clear()
        p_identifierValue = None
        p_positiveIntValue = None
        p_negativeIntValue = None
        p_doubleValue = None
        p_stringValue = None
        p_aggregateValue = None
    }

    public operator func !=(src: UninterpretedOption): Bool { !(this == src) }
    public operator func ==(src: UninterpretedOption): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && name == src.name &&
        p_identifierValue == src.p_identifierValue && p_positiveIntValue == src.p_positiveIntValue &&
        p_negativeIntValue == src.p_negativeIntValue && p_doubleValue == src.p_doubleValue &&
        p_stringValue == src.p_stringValue && p_aggregateValue == src.p_aggregateValue
    }

    public func mergeFrom(src: UninterpretedOption): Unit {
        if (!src.name.isEmpty()) { name.appendAll(src.name) }
        if (let Some(_v) <- src.p_identifierValue) { p_identifierValue = _v }
        if (let Some(_v) <- src.p_positiveIntValue) { p_positiveIntValue = _v }
        if (let Some(_v) <- src.p_negativeIntValue) { p_negativeIntValue = _v }
        if (let Some(_v) <- src.p_doubleValue) { p_doubleValue = _v }
        if (let Some(_v) <- src.p_stringValue) { p_stringValue = _v }
        if (let Some(_v) <- src.p_aggregateValue) { p_aggregateValue = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: UninterpretedOption): UninterpretedOption {
        name.copyFrom(src.name)
        p_identifierValue = src.p_identifierValue
        p_positiveIntValue = src.p_positiveIntValue
        p_negativeIntValue = src.p_negativeIntValue
        p_doubleValue = src.p_doubleValue
        p_stringValue = src.p_stringValue
        p_aggregateValue = src.p_aggregateValue
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): UninterpretedOption {
        return UninterpretedOption().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 2 => s_add(name, src)
                case 3 => p_identifierValue = src.parseString()
                case 4 => p_positiveIntValue = src.parseUInt64()
                case 5 => p_negativeIntValue = src.parseInt64()
                case 6 => p_doubleValue = src.parseFloat64()
                case 7 => p_stringValue = src.parseBytesSlice()
                case 8 => p_aggregateValue = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!name.isEmpty()) { for (_i in name) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_identifierValue) { out.append(26); out.packBin(_v) }
        if (let Some(_v) <- p_positiveIntValue) { out.append(32); out.packVarint(_v) }
        if (let Some(_v) <- p_negativeIntValue) { out.append(40); out.packVarint(_v) }
        if (let Some(_v) <- p_doubleValue) { out.append(49); out.packFixed(_v) }
        if (let Some(_v) <- p_stringValue) { out.append(58); out.packBin(_v) }
        if (let Some(_v) <- p_aggregateValue) { out.append(66); out.packBin(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!name.isEmpty()) { _x.append("name", name) }
        if (let Some(_v) <- p_identifierValue) { _x.append("identifierValue", _v) }
        if (let Some(_v) <- p_positiveIntValue) { _x.append("positiveIntValue", _v) }
        if (let Some(_v) <- p_negativeIntValue) { _x.append("negativeIntValue", _v) }
        if (let Some(_v) <- p_doubleValue) { _x.append("doubleValue", _v) }
        if (let Some(_v) <- p_stringValue) { _x.append("stringValue", _v) }
        if (let Some(_v) <- p_aggregateValue) { _x.append("aggregateValue", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { UninterpretedOption() }
    public static func newBuilder() { UninterpretedOption__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = UninterpretedOption(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = UninterpretedOption(); _x.unpack(src); _x }
}

public class UninterpretedOption__Builder {
    public var name: Array<UninterpretedOption_NamePart> = []
    public func setName(name: Array<UninterpretedOption_NamePart>) { this.name = name; return this }

    public var identifierValue: ?String = None
    public func setIdentifierValue(identifierValue: String) { this.identifierValue = identifierValue; return this }

    public var positiveIntValue: ?UInt64 = None
    public func setPositiveIntValue(positiveIntValue: UInt64) { this.positiveIntValue = positiveIntValue; return this }

    public var negativeIntValue: ?Int64 = None
    public func setNegativeIntValue(negativeIntValue: Int64) { this.negativeIntValue = negativeIntValue; return this }

    public var doubleValue: ?Float64 = None
    public func setDoubleValue(doubleValue: Float64) { this.doubleValue = doubleValue; return this }

    public var stringValue: ?BytesSlice = None
    public func setStringValue(stringValue: BytesSlice) { this.stringValue = stringValue; return this }

    public var aggregateValue: ?String = None
    public func setAggregateValue(aggregateValue: String) { this.aggregateValue = aggregateValue; return this }

    public func build() { UninterpretedOption(this) }
}

public class SourceCodeInfo_Location <: MessageLite & TypedMessage<SourceCodeInfo_Location> {
    public let path: RepeatedField<Int32>
    public let span: RepeatedField<Int32>
    private var p_leadingComments: ?String
    private var p_trailingComments: ?String
    public let leadingDetachedComments: RepeatedField<String>

    public init(
        path!: Array<Int32> = [],
        span!: Array<Int32> = [],
        leadingComments!: ?String = None,
        trailingComments!: ?String = None,
        leadingDetachedComments!: Array<String> = []
    ) {
        this.path = RepeatedField<Int32>(path)
        this.span = RepeatedField<Int32>(span)
        this.p_leadingComments = leadingComments
        this.p_trailingComments = trailingComments
        this.leadingDetachedComments = RepeatedField<String>(leadingDetachedComments)
        m_init()
    }

    public init(src: SourceCodeInfo_Location__Builder) {
        this.path = RepeatedField<Int32>(src.path)
        this.span = RepeatedField<Int32>(src.span)
        this.p_leadingComments = src.leadingComments
        this.p_trailingComments = src.trailingComments
        this.leadingDetachedComments = RepeatedField<String>(src.leadingDetachedComments)
        m_init()
    }

    private func m_init() {
        m_init(path)
        m_init(span)
        m_init(leadingDetachedComments)
        m_innerInit()
    }

    public func clearLeadingComments() { p_leadingComments = None; markDirty() }
    public prop hasLeadingComments: Bool { get() { isPresent(p_leadingComments) } }
    public mut prop leadingComments: String { get() { p_leadingComments.getOrThrow() } set(_x) { p_leadingComments = _x; markDirty() } }

    public func clearTrailingComments() { p_trailingComments = None; markDirty() }
    public prop hasTrailingComments: Bool { get() { isPresent(p_trailingComments) } }
    public mut prop trailingComments: String { get() { p_trailingComments.getOrThrow() } set(_x) { p_trailingComments = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!path.isEmpty()) { var _s = 0; for (_i in path) { _s += varintSize(_i) }; _x += 1 + varintSize(_s) + _s }
        if (!span.isEmpty()) { var _s = 0; for (_i in span) { _s += varintSize(_i) }; _x += 1 + varintSize(_s) + _s }
        if (let Some(_v) <- p_leadingComments) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_trailingComments) { _x += 1 + binSize(_v) }
        if (!leadingDetachedComments.isEmpty()) { for (_i in leadingDetachedComments) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!path.isEmpty()) { _x.write(path.hashCode()) }
        if (!span.isEmpty()) { _x.write(span.hashCode()) }
        if (let Some(_v) <- p_leadingComments) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_trailingComments) { _x.write(_v.hashCode()) }
        if (!leadingDetachedComments.isEmpty()) { _x.write(leadingDetachedComments.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        path.isEmpty() && span.isEmpty() && isNone(p_leadingComments) && isNone(p_trailingComments) &&
        leadingDetachedComments.isEmpty()
    }

    protected func m_clear(): Unit {
        path.clear()
        span.clear()
        p_leadingComments = None
        p_trailingComments = None
        leadingDetachedComments.clear()
    }

    public operator func !=(src: SourceCodeInfo_Location): Bool { !(this == src) }
    public operator func ==(src: SourceCodeInfo_Location): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && path == src.path &&
        span == src.span && p_leadingComments == src.p_leadingComments &&
        p_trailingComments == src.p_trailingComments && leadingDetachedComments == src.leadingDetachedComments
    }

    public func mergeFrom(src: SourceCodeInfo_Location): Unit {
        if (!src.path.isEmpty()) { path.appendAll(src.path) }
        if (!src.span.isEmpty()) { span.appendAll(src.span) }
        if (let Some(_v) <- src.p_leadingComments) { p_leadingComments = _v }
        if (let Some(_v) <- src.p_trailingComments) { p_trailingComments = _v }
        if (!src.leadingDetachedComments.isEmpty()) { leadingDetachedComments.appendAll(src.leadingDetachedComments) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: SourceCodeInfo_Location): SourceCodeInfo_Location {
        path.copyFrom(src.path)
        span.copyFrom(src.span)
        p_leadingComments = src.p_leadingComments
        p_trailingComments = src.p_trailingComments
        leadingDetachedComments.copyFrom(src.leadingDetachedComments)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): SourceCodeInfo_Location {
        return SourceCodeInfo_Location().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(path, _s.parseInt32()) } } else { s_add(path, src.parseInt32()) }
                case 2 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(span, _s.parseInt32()) } } else { s_add(span, src.parseInt32()) }
                case 3 => p_leadingComments = src.parseString()
                case 4 => p_trailingComments = src.parseString()
                case 6 => s_add(leadingDetachedComments, src.parseString())
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!path.isEmpty()) { out.append(10); var _s = 0; for (_i in path) { _s += varintSize(_i) }; out.packVarint(_s); for (_i in path) { out.packVarint(_i) } }
        if (!span.isEmpty()) { out.append(18); var _s = 0; for (_i in span) { _s += varintSize(_i) }; out.packVarint(_s); for (_i in span) { out.packVarint(_i) } }
        if (let Some(_v) <- p_leadingComments) { out.append(26); out.packBin(_v) }
        if (let Some(_v) <- p_trailingComments) { out.append(34); out.packBin(_v) }
        if (!leadingDetachedComments.isEmpty()) { for (_i in leadingDetachedComments) { out.append(50); out.packBin(_i) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!path.isEmpty()) { _x.append("path", path) }
        if (!span.isEmpty()) { _x.append("span", span) }
        if (let Some(_v) <- p_leadingComments) { _x.append("leadingComments", _v) }
        if (let Some(_v) <- p_trailingComments) { _x.append("trailingComments", _v) }
        if (!leadingDetachedComments.isEmpty()) { _x.append("leadingDetachedComments", leadingDetachedComments) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { SourceCodeInfo_Location() }
    public static func newBuilder() { SourceCodeInfo_Location__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = SourceCodeInfo_Location(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = SourceCodeInfo_Location(); _x.unpack(src); _x }
}

public class SourceCodeInfo_Location__Builder {
    public var path: Array<Int32> = []
    public func setPath(path: Array<Int32>) { this.path = path; return this }

    public var span: Array<Int32> = []
    public func setSpan(span: Array<Int32>) { this.span = span; return this }

    public var leadingComments: ?String = None
    public func setLeadingComments(leadingComments: String) { this.leadingComments = leadingComments; return this }

    public var trailingComments: ?String = None
    public func setTrailingComments(trailingComments: String) { this.trailingComments = trailingComments; return this }

    public var leadingDetachedComments: Array<String> = []
    public func setLeadingDetachedComments(leadingDetachedComments: Array<String>) { this.leadingDetachedComments = leadingDetachedComments; return this }

    public func build() { SourceCodeInfo_Location(this) }
}

public class SourceCodeInfo <: MessageLite & TypedMessage<SourceCodeInfo> {
    public let location: RepeatedMessage<SourceCodeInfo_Location>

    public init(
        location!: Array<SourceCodeInfo_Location> = []
    ) {
        this.location = RepeatedMessage<SourceCodeInfo_Location>(location)
        m_init()
    }

    public init(src: SourceCodeInfo__Builder) {
        this.location = RepeatedMessage<SourceCodeInfo_Location>(src.location)
        m_init()
    }

    private func m_init() {
        m_init(location)
        m_innerInit()
    }

    protected func m_size(): Int64 {
        var _x = 0
        if (!location.isEmpty()) { for (_i in location) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!location.isEmpty()) { _x.write(location.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        location.isEmpty()
    }

    protected func m_clear(): Unit {
        location.clear()
    }

    public operator func !=(src: SourceCodeInfo): Bool { !(this == src) }
    public operator func ==(src: SourceCodeInfo): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        location == src.location
    }

    public func mergeFrom(src: SourceCodeInfo): Unit {
        if (!src.location.isEmpty()) { location.appendAll(src.location) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: SourceCodeInfo): SourceCodeInfo {
        location.copyFrom(src.location)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): SourceCodeInfo {
        return SourceCodeInfo().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => s_add(location, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!location.isEmpty()) { for (_i in location) { out.append(10); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!location.isEmpty()) { _x.append("location", location) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { SourceCodeInfo() }
    public static func newBuilder() { SourceCodeInfo__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = SourceCodeInfo(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = SourceCodeInfo(); _x.unpack(src); _x }
}

public class SourceCodeInfo__Builder {
    public var location: Array<SourceCodeInfo_Location> = []
    public func setLocation(location: Array<SourceCodeInfo_Location>) { this.location = location; return this }

    public func build() { SourceCodeInfo(this) }
}

public class GeneratedCodeInfo_Annotation <: MessageLite & TypedMessage<GeneratedCodeInfo_Annotation> {
    public let path: RepeatedField<Int32>
    private var p_sourceFile: ?String
    private var p_begin: ?Int32
    private var p_end: ?Int32

    public init(
        path!: Array<Int32> = [],
        sourceFile!: ?String = None,
        begin!: ?Int32 = None,
        end!: ?Int32 = None
    ) {
        this.path = RepeatedField<Int32>(path)
        this.p_sourceFile = sourceFile
        this.p_begin = begin
        this.p_end = end
        m_init()
    }

    public init(src: GeneratedCodeInfo_Annotation__Builder) {
        this.path = RepeatedField<Int32>(src.path)
        this.p_sourceFile = src.sourceFile
        this.p_begin = src.begin
        this.p_end = src.end
        m_init()
    }

    private func m_init() {
        m_init(path)
        m_innerInit()
    }

    public func clearSourceFile() { p_sourceFile = None; markDirty() }
    public prop hasSourceFile: Bool { get() { isPresent(p_sourceFile) } }
    public mut prop sourceFile: String { get() { p_sourceFile.getOrThrow() } set(_x) { p_sourceFile = _x; markDirty() } }

    public func clearBegin() { p_begin = None; markDirty() }
    public prop hasBegin: Bool { get() { isPresent(p_begin) } }
    public mut prop begin: Int32 { get() { p_begin.getOrThrow() } set(_x) { p_begin = _x; markDirty() } }

    public func clearEnd() { p_end = None; markDirty() }
    public prop hasEnd: Bool { get() { isPresent(p_end) } }
    public mut prop end: Int32 { get() { p_end.getOrThrow() } set(_x) { p_end = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!path.isEmpty()) { var _s = 0; for (_i in path) { _s += varintSize(_i) }; _x += 1 + varintSize(_s) + _s }
        if (let Some(_v) <- p_sourceFile) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_begin) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_end) { _x += 1 + varintSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!path.isEmpty()) { _x.write(path.hashCode()) }
        if (let Some(_v) <- p_sourceFile) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_begin) { _x.write(_v) }
        if (let Some(_v) <- p_end) { _x.write(_v) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        path.isEmpty() && isNone(p_sourceFile) && isNone(p_begin) && isNone(p_end)
    }

    protected func m_clear(): Unit {
        path.clear()
        p_sourceFile = None
        p_begin = None
        p_end = None
    }

    public operator func !=(src: GeneratedCodeInfo_Annotation): Bool { !(this == src) }
    public operator func ==(src: GeneratedCodeInfo_Annotation): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && path == src.path &&
        p_sourceFile == src.p_sourceFile && p_begin == src.p_begin && p_end == src.p_end
    }

    public func mergeFrom(src: GeneratedCodeInfo_Annotation): Unit {
        if (!src.path.isEmpty()) { path.appendAll(src.path) }
        if (let Some(_v) <- src.p_sourceFile) { p_sourceFile = _v }
        if (let Some(_v) <- src.p_begin) { p_begin = _v }
        if (let Some(_v) <- src.p_end) { p_end = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: GeneratedCodeInfo_Annotation): GeneratedCodeInfo_Annotation {
        path.copyFrom(src.path)
        p_sourceFile = src.p_sourceFile
        p_begin = src.p_begin
        p_end = src.p_end
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): GeneratedCodeInfo_Annotation {
        return GeneratedCodeInfo_Annotation().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(path, _s.parseInt32()) } } else { s_add(path, src.parseInt32()) }
                case 2 => p_sourceFile = src.parseString()
                case 3 => p_begin = src.parseInt32()
                case 4 => p_end = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!path.isEmpty()) { out.append(10); var _s = 0; for (_i in path) { _s += varintSize(_i) }; out.packVarint(_s); for (_i in path) { out.packVarint(_i) } }
        if (let Some(_v) <- p_sourceFile) { out.append(18); out.packBin(_v) }
        if (let Some(_v) <- p_begin) { out.append(24); out.packVarint(_v) }
        if (let Some(_v) <- p_end) { out.append(32); out.packVarint(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!path.isEmpty()) { _x.append("path", path) }
        if (let Some(_v) <- p_sourceFile) { _x.append("sourceFile", _v) }
        if (let Some(_v) <- p_begin) { _x.append("begin", _v) }
        if (let Some(_v) <- p_end) { _x.append("end", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { GeneratedCodeInfo_Annotation() }
    public static func newBuilder() { GeneratedCodeInfo_Annotation__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = GeneratedCodeInfo_Annotation(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = GeneratedCodeInfo_Annotation(); _x.unpack(src); _x }
}

public class GeneratedCodeInfo_Annotation__Builder {
    public var path: Array<Int32> = []
    public func setPath(path: Array<Int32>) { this.path = path; return this }

    public var sourceFile: ?String = None
    public func setSourceFile(sourceFile: String) { this.sourceFile = sourceFile; return this }

    public var begin: ?Int32 = None
    public func setBegin(begin: Int32) { this.begin = begin; return this }

    public var end: ?Int32 = None
    public func setEnd(end: Int32) { this.end = end; return this }

    public func build() { GeneratedCodeInfo_Annotation(this) }
}

public class GeneratedCodeInfo <: MessageLite & TypedMessage<GeneratedCodeInfo> {
    public let annotation: RepeatedMessage<GeneratedCodeInfo_Annotation>

    public init(
        annotation!: Array<GeneratedCodeInfo_Annotation> = []
    ) {
        this.annotation = RepeatedMessage<GeneratedCodeInfo_Annotation>(annotation)
        m_init()
    }

    public init(src: GeneratedCodeInfo__Builder) {
        this.annotation = RepeatedMessage<GeneratedCodeInfo_Annotation>(src.annotation)
        m_init()
    }

    private func m_init() {
        m_init(annotation)
        m_innerInit()
    }

    protected func m_size(): Int64 {
        var _x = 0
        if (!annotation.isEmpty()) { for (_i in annotation) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!annotation.isEmpty()) { _x.write(annotation.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        annotation.isEmpty()
    }

    protected func m_clear(): Unit {
        annotation.clear()
    }

    public operator func !=(src: GeneratedCodeInfo): Bool { !(this == src) }
    public operator func ==(src: GeneratedCodeInfo): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        annotation == src.annotation
    }

    public func mergeFrom(src: GeneratedCodeInfo): Unit {
        if (!src.annotation.isEmpty()) { annotation.appendAll(src.annotation) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: GeneratedCodeInfo): GeneratedCodeInfo {
        annotation.copyFrom(src.annotation)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): GeneratedCodeInfo {
        return GeneratedCodeInfo().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => s_add(annotation, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!annotation.isEmpty()) { for (_i in annotation) { out.append(10); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!annotation.isEmpty()) { _x.append("annotation", annotation) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { GeneratedCodeInfo() }
    public static func newBuilder() { GeneratedCodeInfo__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = GeneratedCodeInfo(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = GeneratedCodeInfo(); _x.unpack(src); _x }
}

public class GeneratedCodeInfo__Builder {
    public var annotation: Array<GeneratedCodeInfo_Annotation> = []
    public func setAnnotation(annotation: Array<GeneratedCodeInfo_Annotation>) { this.annotation = annotation; return this }

    public func build() { GeneratedCodeInfo(this) }
}

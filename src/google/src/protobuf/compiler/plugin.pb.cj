/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package google.protobuf.compiler

internal import std.collection.*
internal import protobuf.*
internal import google.protobuf.*

public class Version <: MessageLite & TypedMessage<Version> {
    private var p_major: ?Int32
    private var p_minor: ?Int32
    private var p_patch: ?Int32
    private var p_suffix: ?String

    public init(
        major!: ?Int32 = None,
        minor!: ?Int32 = None,
        patch!: ?Int32 = None,
        suffix!: ?String = None
    ) {
        this.p_major = major
        this.p_minor = minor
        this.p_patch = patch
        this.p_suffix = suffix
        m_init()
    }

    public init(src: Version__Builder) {
        this.p_major = src.major
        this.p_minor = src.minor
        this.p_patch = src.patch
        this.p_suffix = src.suffix
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public func clearMajor() { p_major = None; markDirty() }
    public prop hasMajor: Bool { get() { isPresent(p_major) } }
    public mut prop major: Int32 { get() { p_major.getOrThrow() } set(_x) { p_major = _x; markDirty() } }

    public func clearMinor() { p_minor = None; markDirty() }
    public prop hasMinor: Bool { get() { isPresent(p_minor) } }
    public mut prop minor: Int32 { get() { p_minor.getOrThrow() } set(_x) { p_minor = _x; markDirty() } }

    public func clearPatch() { p_patch = None; markDirty() }
    public prop hasPatch: Bool { get() { isPresent(p_patch) } }
    public mut prop patch: Int32 { get() { p_patch.getOrThrow() } set(_x) { p_patch = _x; markDirty() } }

    public func clearSuffix() { p_suffix = None; markDirty() }
    public prop hasSuffix: Bool { get() { isPresent(p_suffix) } }
    public mut prop suffix: String { get() { p_suffix.getOrThrow() } set(_x) { p_suffix = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_major) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_minor) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_patch) { _x += 1 + varintSize(_v) }
        if (let Some(_v) <- p_suffix) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_major) { _x.write(_v) }
        if (let Some(_v) <- p_minor) { _x.write(_v) }
        if (let Some(_v) <- p_patch) { _x.write(_v) }
        if (let Some(_v) <- p_suffix) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_major) && isNone(p_minor) && isNone(p_patch) && isNone(p_suffix)
    }

    protected func m_clear(): Unit {
        p_major = None
        p_minor = None
        p_patch = None
        p_suffix = None
    }

    public operator func !=(src: Version): Bool { !(this == src) }
    public operator func ==(src: Version): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_major == src.p_major && p_minor == src.p_minor && p_patch == src.p_patch && p_suffix == src.p_suffix
    }

    public func mergeFrom(src: Version): Unit {
        if (let Some(_v) <- src.p_major) { p_major = _v }
        if (let Some(_v) <- src.p_minor) { p_minor = _v }
        if (let Some(_v) <- src.p_patch) { p_patch = _v }
        if (let Some(_v) <- src.p_suffix) { p_suffix = _v }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: Version): Version {
        p_major = src.p_major
        p_minor = src.p_minor
        p_patch = src.p_patch
        p_suffix = src.p_suffix
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): Version {
        return Version().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_major = src.parseInt32()
                case 2 => p_minor = src.parseInt32()
                case 3 => p_patch = src.parseInt32()
                case 4 => p_suffix = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_major) { out.append(8); out.packVarint(_v) }
        if (let Some(_v) <- p_minor) { out.append(16); out.packVarint(_v) }
        if (let Some(_v) <- p_patch) { out.append(24); out.packVarint(_v) }
        if (let Some(_v) <- p_suffix) { out.append(34); out.packBin(_v) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_major) { _x.append("major", _v) }
        if (let Some(_v) <- p_minor) { _x.append("minor", _v) }
        if (let Some(_v) <- p_patch) { _x.append("patch", _v) }
        if (let Some(_v) <- p_suffix) { _x.append("suffix", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { Version() }
    public static func newBuilder() { Version__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = Version(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = Version(); _x.unpack(src); _x }
}

public class Version__Builder {
    public var major: ?Int32 = None
    public func setMajor(major: Int32) { this.major = major; return this }

    public var minor: ?Int32 = None
    public func setMinor(minor: Int32) { this.minor = minor; return this }

    public var patch: ?Int32 = None
    public func setPatch(patch: Int32) { this.patch = patch; return this }

    public var suffix: ?String = None
    public func setSuffix(suffix: String) { this.suffix = suffix; return this }

    public func build() { Version(this) }
}

public class CodeGeneratorRequest <: MessageLite & TypedMessage<CodeGeneratorRequest> {
    public let fileToGenerate: RepeatedField<String>
    private var p_parameter: ?String
    public let protoFile: RepeatedMessage<FileDescriptorProto>
    private var p_compilerVersion: PbMessage<Version>

    public init(
        fileToGenerate!: Array<String> = [],
        parameter!: ?String = None,
        protoFile!: Array<FileDescriptorProto> = [],
        compilerVersion!: ?Version = None
    ) {
        this.fileToGenerate = RepeatedField<String>(fileToGenerate)
        this.p_parameter = parameter
        this.protoFile = RepeatedMessage<FileDescriptorProto>(protoFile)
        this.p_compilerVersion = PbMessage<Version>(compilerVersion)
        m_init()
    }

    public init(src: CodeGeneratorRequest__Builder) {
        this.fileToGenerate = RepeatedField<String>(src.fileToGenerate)
        this.p_parameter = src.parameter
        this.protoFile = RepeatedMessage<FileDescriptorProto>(src.protoFile)
        this.p_compilerVersion = PbMessage<Version>(src.compilerVersion)
        m_init()
    }

    private func m_init() {
        m_init(fileToGenerate)
        m_init(protoFile)
        if (let Some(_v) <- p_compilerVersion.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearParameter() { p_parameter = None; markDirty() }
    public prop hasParameter: Bool { get() { isPresent(p_parameter) } }
    public mut prop parameter: String { get() { p_parameter.getOrThrow() } set(_x) { p_parameter = _x; markDirty() } }

    public func clearCompilerVersion() { p_compilerVersion.removeFrom(this); markDirty() }
    public prop hasCompilerVersion: Bool { get() { isPresent(p_compilerVersion.data) } }
    public mut prop compilerVersion: Version { get() { p_compilerVersion.data.getOrThrow() } set(_v) { p_compilerVersion.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!fileToGenerate.isEmpty()) { for (_i in fileToGenerate) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_parameter) { _x += 1 + binSize(_v) }
        if (!protoFile.isEmpty()) { for (_i in protoFile) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_compilerVersion.data) { _x += 1 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!fileToGenerate.isEmpty()) { _x.write(fileToGenerate.hashCode()) }
        if (let Some(_v) <- p_parameter) { _x.write(_v.hashCode()) }
        if (!protoFile.isEmpty()) { _x.write(protoFile.hashCode()) }
        if (let Some(_v) <- p_compilerVersion.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        fileToGenerate.isEmpty() && isNone(p_parameter) && protoFile.isEmpty() && isNone(p_compilerVersion.data)
    }

    protected func m_clear(): Unit {
        fileToGenerate.clear()
        p_parameter = None
        protoFile.clear()
        p_compilerVersion.removeFrom(this)
    }

    public operator func !=(src: CodeGeneratorRequest): Bool { !(this == src) }
    public operator func ==(src: CodeGeneratorRequest): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        fileToGenerate == src.fileToGenerate && p_parameter == src.p_parameter && protoFile == src.protoFile &&
        p_compilerVersion.data == src.p_compilerVersion.data
    }

    public func mergeFrom(src: CodeGeneratorRequest): Unit {
        if (!src.fileToGenerate.isEmpty()) { fileToGenerate.appendAll(src.fileToGenerate) }
        if (let Some(_v) <- src.p_parameter) { p_parameter = _v }
        if (!src.protoFile.isEmpty()) { protoFile.appendAll(src.protoFile) }
        if (let Some(_v) <- src.p_compilerVersion.data) { p_compilerVersion.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: CodeGeneratorRequest): CodeGeneratorRequest {
        fileToGenerate.copyFrom(src.fileToGenerate)
        p_parameter = src.p_parameter
        protoFile.copyFrom(src.protoFile)
        p_compilerVersion.copyFrom(this, src.p_compilerVersion.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): CodeGeneratorRequest {
        return CodeGeneratorRequest().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => s_add(fileToGenerate, src.parseString())
                case 2 => p_parameter = src.parseString()
                case 15 => s_add(protoFile, src)
                case 3 => p_compilerVersion.getOrDefault(this).unpack(subReader(src))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!fileToGenerate.isEmpty()) { for (_i in fileToGenerate) { out.append(10); out.packBin(_i) } }
        if (let Some(_v) <- p_parameter) { out.append(18); out.packBin(_v) }
        if (!protoFile.isEmpty()) { for (_i in protoFile) { out.append(122); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_compilerVersion.data) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!fileToGenerate.isEmpty()) { _x.append("fileToGenerate", fileToGenerate) }
        if (let Some(_v) <- p_parameter) { _x.append("parameter", _v) }
        if (!protoFile.isEmpty()) { _x.append("protoFile", protoFile) }
        if (let Some(_v) <- p_compilerVersion.data) { _x.append("compilerVersion", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { CodeGeneratorRequest() }
    public static func newBuilder() { CodeGeneratorRequest__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = CodeGeneratorRequest(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = CodeGeneratorRequest(); _x.unpack(src); _x }
}

public class CodeGeneratorRequest__Builder {
    public var fileToGenerate: Array<String> = []
    public func setFileToGenerate(fileToGenerate: Array<String>) { this.fileToGenerate = fileToGenerate; return this }

    public var parameter: ?String = None
    public func setParameter(parameter: String) { this.parameter = parameter; return this }

    public var protoFile: Array<FileDescriptorProto> = []
    public func setProtoFile(protoFile: Array<FileDescriptorProto>) { this.protoFile = protoFile; return this }

    public var compilerVersion: ?Version = None
    public func setCompilerVersion(compilerVersion: Version) { this.compilerVersion = compilerVersion; return this }

    public func build() { CodeGeneratorRequest(this) }
}

public class CodeGeneratorResponse_File <: MessageLite & TypedMessage<CodeGeneratorResponse_File> {
    private var p_name: ?String
    private var p_insertionPoint: ?String
    private var p_content: ?String
    private var p_generatedCodeInfo: PbMessage<GeneratedCodeInfo>

    public init(
        name!: ?String = None,
        insertionPoint!: ?String = None,
        content!: ?String = None,
        generatedCodeInfo!: ?GeneratedCodeInfo = None
    ) {
        this.p_name = name
        this.p_insertionPoint = insertionPoint
        this.p_content = content
        this.p_generatedCodeInfo = PbMessage<GeneratedCodeInfo>(generatedCodeInfo)
        m_init()
    }

    public init(src: CodeGeneratorResponse_File__Builder) {
        this.p_name = src.name
        this.p_insertionPoint = src.insertionPoint
        this.p_content = src.content
        this.p_generatedCodeInfo = PbMessage<GeneratedCodeInfo>(src.generatedCodeInfo)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_generatedCodeInfo.data) { m_init(_v) }
        m_innerInit()
    }

    public func clearName() { p_name = None; markDirty() }
    public prop hasName: Bool { get() { isPresent(p_name) } }
    public mut prop name: String { get() { p_name.getOrThrow() } set(_x) { p_name = _x; markDirty() } }

    public func clearInsertionPoint() { p_insertionPoint = None; markDirty() }
    public prop hasInsertionPoint: Bool { get() { isPresent(p_insertionPoint) } }
    public mut prop insertionPoint: String { get() { p_insertionPoint.getOrThrow() } set(_x) { p_insertionPoint = _x; markDirty() } }

    public func clearContent() { p_content = None; markDirty() }
    public prop hasContent: Bool { get() { isPresent(p_content) } }
    public mut prop content: String { get() { p_content.getOrThrow() } set(_x) { p_content = _x; markDirty() } }

    public func clearGeneratedCodeInfo() { p_generatedCodeInfo.removeFrom(this); markDirty() }
    public prop hasGeneratedCodeInfo: Bool { get() { isPresent(p_generatedCodeInfo.data) } }
    public mut prop generatedCodeInfo: GeneratedCodeInfo { get() { p_generatedCodeInfo.data.getOrThrow() } set(_v) { p_generatedCodeInfo.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_name) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_insertionPoint) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_content) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_generatedCodeInfo.data) { _x += 2 + binSize(_v) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_name) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_insertionPoint) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_content) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_generatedCodeInfo.data) { _x.write(_v.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_name) && isNone(p_insertionPoint) && isNone(p_content) && isNone(p_generatedCodeInfo.data)
    }

    protected func m_clear(): Unit {
        p_name = None
        p_insertionPoint = None
        p_content = None
        p_generatedCodeInfo.removeFrom(this)
    }

    public operator func !=(src: CodeGeneratorResponse_File): Bool { !(this == src) }
    public operator func ==(src: CodeGeneratorResponse_File): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_name == src.p_name && p_insertionPoint == src.p_insertionPoint && p_content == src.p_content &&
        p_generatedCodeInfo.data == src.p_generatedCodeInfo.data
    }

    public func mergeFrom(src: CodeGeneratorResponse_File): Unit {
        if (let Some(_v) <- src.p_name) { p_name = _v }
        if (let Some(_v) <- src.p_insertionPoint) { p_insertionPoint = _v }
        if (let Some(_v) <- src.p_content) { p_content = _v }
        if (let Some(_v) <- src.p_generatedCodeInfo.data) { p_generatedCodeInfo.getOrDefault(this).mergeFrom(_v) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: CodeGeneratorResponse_File): CodeGeneratorResponse_File {
        p_name = src.p_name
        p_insertionPoint = src.p_insertionPoint
        p_content = src.p_content
        p_generatedCodeInfo.copyFrom(this, src.p_generatedCodeInfo.data)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): CodeGeneratorResponse_File {
        return CodeGeneratorResponse_File().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_name = src.parseString()
                case 2 => p_insertionPoint = src.parseString()
                case 15 => p_content = src.parseString()
                case 16 => p_generatedCodeInfo.getOrDefault(this).unpack(subReader(src))
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
        if (let Some(_v) <- p_insertionPoint) { out.append(18); out.packBin(_v) }
        if (let Some(_v) <- p_content) { out.append(122); out.packBin(_v) }
        if (let Some(_v) <- p_generatedCodeInfo.data) { out.packTag(16, PREFIXED); out.packVarint(_v.size); _v.pack(out) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_name) { _x.append("name", _v) }
        if (let Some(_v) <- p_insertionPoint) { _x.append("insertionPoint", _v) }
        if (let Some(_v) <- p_content) { _x.append("content", _v) }
        if (let Some(_v) <- p_generatedCodeInfo.data) { _x.append("generatedCodeInfo", _v) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { CodeGeneratorResponse_File() }
    public static func newBuilder() { CodeGeneratorResponse_File__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = CodeGeneratorResponse_File(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = CodeGeneratorResponse_File(); _x.unpack(src); _x }
}

public class CodeGeneratorResponse_File__Builder {
    public var name: ?String = None
    public func setName(name: String) { this.name = name; return this }

    public var insertionPoint: ?String = None
    public func setInsertionPoint(insertionPoint: String) { this.insertionPoint = insertionPoint; return this }

    public var content: ?String = None
    public func setContent(content: String) { this.content = content; return this }

    public var generatedCodeInfo: ?GeneratedCodeInfo = None
    public func setGeneratedCodeInfo(generatedCodeInfo: GeneratedCodeInfo) { this.generatedCodeInfo = generatedCodeInfo; return this }

    public func build() { CodeGeneratorResponse_File(this) }
}

public enum CodeGeneratorResponse_Feature <: Enum<CodeGeneratorResponse_Feature> {
    FEATURE_NONE | FEATURE_PROTO3_OPTIONAL

    public func value(): Int32 {
        match(this) {
            case FEATURE_NONE => 0
            case FEATURE_PROTO3_OPTIONAL => 1
        }
    }

    public func toString(): String {
        match(this) {
            case FEATURE_NONE => "FEATURE_NONE"
            case FEATURE_PROTO3_OPTIONAL => "FEATURE_PROTO3_OPTIONAL"
        }
    }

    public operator func==(value: CodeGeneratorResponse_Feature) {
        match((this, value)) {
            case (FEATURE_NONE, FEATURE_NONE) => true
            case (FEATURE_PROTO3_OPTIONAL, FEATURE_PROTO3_OPTIONAL) => true
            case _ => false
        }
    }

    public static func parse(value: Int32): CodeGeneratorResponse_Feature {
        match(value) {
            case 0 => FEATURE_NONE
            case 1 => FEATURE_PROTO3_OPTIONAL
            case _ => throw InvalidEnumValueException("CodeGeneratorResponse_Feature", value)
        }
    }

    public static func parse(value: String): CodeGeneratorResponse_Feature {
        match(value) {
            case "FEATURE_NONE" => FEATURE_NONE
            case "FEATURE_PROTO3_OPTIONAL" => FEATURE_PROTO3_OPTIONAL
            case _ => throw UnmatchedEnumStringException("CodeGeneratorResponse_Feature", value)
        }
    }
}

public class CodeGeneratorResponse <: MessageLite & TypedMessage<CodeGeneratorResponse> {
    private var p_error: ?String
    private var p_supportedFeatures: ?UInt64
    public let file: RepeatedMessage<CodeGeneratorResponse_File>

    public init(
        error!: ?String = None,
        supportedFeatures!: ?UInt64 = None,
        file!: Array<CodeGeneratorResponse_File> = []
    ) {
        this.p_error = error
        this.p_supportedFeatures = supportedFeatures
        this.file = RepeatedMessage<CodeGeneratorResponse_File>(file)
        m_init()
    }

    public init(src: CodeGeneratorResponse__Builder) {
        this.p_error = src.error
        this.p_supportedFeatures = src.supportedFeatures
        this.file = RepeatedMessage<CodeGeneratorResponse_File>(src.file)
        m_init()
    }

    private func m_init() {
        m_init(file)
        m_innerInit()
    }

    public func clearError() { p_error = None; markDirty() }
    public prop hasError: Bool { get() { isPresent(p_error) } }
    public mut prop error: String { get() { p_error.getOrThrow() } set(_x) { p_error = _x; markDirty() } }

    public func clearSupportedFeatures() { p_supportedFeatures = None; markDirty() }
    public prop hasSupportedFeatures: Bool { get() { isPresent(p_supportedFeatures) } }
    public mut prop supportedFeatures: UInt64 { get() { p_supportedFeatures.getOrThrow() } set(_x) { p_supportedFeatures = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_error) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_supportedFeatures) { _x += 1 + varintSize(_v) }
        if (!file.isEmpty()) { for (_i in file) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_error) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_supportedFeatures) { _x.write(_v) }
        if (!file.isEmpty()) { _x.write(file.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        isNone(p_error) && isNone(p_supportedFeatures) && file.isEmpty()
    }

    protected func m_clear(): Unit {
        p_error = None
        p_supportedFeatures = None
        file.clear()
    }

    public operator func !=(src: CodeGeneratorResponse): Bool { !(this == src) }
    public operator func ==(src: CodeGeneratorResponse): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_error == src.p_error && p_supportedFeatures == src.p_supportedFeatures && file == src.file
    }

    public func mergeFrom(src: CodeGeneratorResponse): Unit {
        if (let Some(_v) <- src.p_error) { p_error = _v }
        if (let Some(_v) <- src.p_supportedFeatures) { p_supportedFeatures = _v }
        if (!src.file.isEmpty()) { file.appendAll(src.file) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: CodeGeneratorResponse): CodeGeneratorResponse {
        p_error = src.p_error
        p_supportedFeatures = src.p_supportedFeatures
        file.copyFrom(src.file)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): CodeGeneratorResponse {
        return CodeGeneratorResponse().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_error = src.parseString()
                case 2 => p_supportedFeatures = src.parseUInt64()
                case 15 => s_add(file, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit /* throws RequiredFieldNotSetException */ {
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (let Some(_v) <- p_error) { out.append(10); out.packBin(_v) }
        if (let Some(_v) <- p_supportedFeatures) { out.append(16); out.packVarint(_v) }
        if (!file.isEmpty()) { for (_i in file) { out.append(122); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_error) { _x.append("error", _v) }
        if (let Some(_v) <- p_supportedFeatures) { _x.append("supportedFeatures", _v) }
        if (!file.isEmpty()) { _x.append("file", file) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { CodeGeneratorResponse() }
    public static func newBuilder() { CodeGeneratorResponse__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = CodeGeneratorResponse(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = CodeGeneratorResponse(); _x.unpack(src); _x }
}

public class CodeGeneratorResponse__Builder {
    public var error: ?String = None
    public func setError(error: String) { this.error = error; return this }

    public var supportedFeatures: ?UInt64 = None
    public func setSupportedFeatures(supportedFeatures: UInt64) { this.supportedFeatures = supportedFeatures; return this }

    public var file: Array<CodeGeneratorResponse_File> = []
    public func setFile(file: Array<CodeGeneratorResponse_File>) { this.file = file; return this }

    public func build() { CodeGeneratorResponse(this) }
}

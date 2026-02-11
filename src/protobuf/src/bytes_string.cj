/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

/* @Deprecated */
public type BytesString = String

/* @Deprecated */
public struct Pb3String {
    public var data: String
    public init() { data = String() }
    public init(value: String) { data = value }
    public mut func get(): String { data }
    public mut func set(str: String): Unit { data = str }
    public func isEmpty(): Bool { data.isEmpty() }
    public mut func clear() { data = String() }
    public mut func unpack<T>(src: T) where T <: BytesReader { data = src.parseString() }
}

/* @Deprecated */
public struct Pb2String {
    public var data: ?String
    public let default: ?String

    public init(value: ?String) {
        data = value
        default = None
    }

    public init(value: ?String, default: String) {
        data = value
        this.default = default
    }

    public mut func get(): String {
        data ?? default.getOrThrow()
    }

    public mut func set(str: String): Unit { data = if (default == str) { None } else { str } }
    public mut func clear() { data = None }
    public mut func unpack<T>(src: T) where T <: BytesReader { set(src.parseString()) }
}

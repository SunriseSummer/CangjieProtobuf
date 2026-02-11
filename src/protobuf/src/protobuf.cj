/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package protobuf

internal import std.collection.*

public type Tag = UInt32
public type WireNum = UInt8
public type Bytes = Array<Byte>
public type BytesSlice = RoArray<Byte>

/* typecast by bits */
func itof(v: UInt32): Float32{
    Float32.fromBits(v)
}
func ltod(v: UInt64): Float64{
    Float64.fromBits(v)
}
func ftoi(v: Float32): UInt32{
    v.toBits()
}
func dtol(v: Float64): UInt64{
    v.toBits()
}

public let VARINT: WireNum = 0
public let BIT64: WireNum = 1
public let PREFIXED: WireNum = 2
public let BIT32: WireNum = 5

/* protobuf wire type define. */
public class WireType <: ToString {
    private WireType(public let value: WireNum, private let name: String) { }
    public func toString() { name }

    public static func parse(val: WireNum): WireType {
        match (val) {
            case 0 => VARINT
            case 1 => BIT64
            case 2 => PREFIXED
            case 5 => BIT32
            case _ => throw ParseValueExecption("WireType")
        }
    }

    public static let VARINT = WireType(VARINT, "VARINT")
    public static let BIT64 = WireType(BIT64, "BIT64")
    public static let PREFIXED = WireType(PREFIXED, "PREFIXED")
    public static let BIT32 = WireType(BIT32, "BIT32")
}

/* packed size of tag. */
public func tagSize(tag: Tag) {
    if (tag < (1 << 4)) { return 1 }
    if (tag < (1 << 11)) { return 2 }
    if (tag < (1 << 18)) { return 3 }
    if (tag < (1 << 25)) { return 4 }
    return 5
}

/* packed size by varint encoding. */
public func varintSize(val: UInt64) {
    if (val < (1 << 7)) { return 1 }
    if (val < (1 << 14)) { return 2 }
    if (val < (1 << 21)) { return 3 }
    if (val < (1 << 28)) { return 4 }
    if (val < (1 << 35)) { return 5 }
    if (val < (1 << 42)) { return 6 }
    if (val < (1 << 49)) { return 7 }
    if (val < (1 << 56)) { return 8 }
    if (val < (1 << 63)) { return 9 }
    return 10
}

/* packed size by varint encoding. */
@OverflowWrapping
public func varintSize(val: Int64) {
    if (val < 0) { return 10 }
    if (val < (1 << 7)) { return 1 }
    if (val < (1 << 14)) { return 2 }
    if (val < (1 << 21)) { return 3 }
    if (val < (1 << 28)) { return 4 }
    if (val < (1 << 35)) { return 5 }
    if (val < (1 << 42)) { return 6 }
    if (val < (1 << 49)) { return 7 }
    if (val < (1 << 56)) { return 8 }
    return 9
}

/* packed size by varint encoding. */
@OverflowWrapping
public func varintSize(val: UInt32) {
    if (val < (1 << 7)) { return 1 }
    if (val < (1 << 14)) { return 2 }
    if (val < (1 << 21)) { return 3 }
    if (val < (1 << 28)) { return 4 }
	return 5
}

/* packed size by varint encoding. */
@OverflowWrapping
public func varintSize(val: Int32) {
    if (val < 0) { return 10 }
    if (val < (1 << 7)) { return 1 }
    if (val < (1 << 14)) { return 2 }
    if (val < (1 << 21)) { return 3 }
    if (val < (1 << 28)) { return 4 }
    return 5
}

/* packed size by varint encoding. */
@OverflowWrapping
public func varintSize(val: Int32Enum) {
    varintSize(val.value())
}

/* the zigzag-encoded 64-bit unsigned integer form of a 64-bit signed integer. */
@OverflowWrapping
public func zigzag(val: Int64) {
    (UInt64(val) << 1) ^ UInt64(val >> 63)
}

/* the zigzag-encoded 32-bit unsigned integer form of a 32-bit signed integer. */
@OverflowWrapping
public func zigzag(val: Int32) {
    (UInt32(val) << 1) ^ UInt32(val >> 31)
}

/* unzigzag a zigzag-encoded 64-bit unsigned integer to a 64-bit signed integer. */
@OverflowWrapping
public func unzigzag(val: UInt64) {
    Int64((val >> 1) ^ -(val & 1))
}

/* unzigzag a zigzag-encoded 32-bit unsigned integer to a 32-bit signed integer. */
@OverflowWrapping
public func unzigzag(val: UInt32) {
    Int32((val >> 1) ^ -(val & 1))
}

/* packed size of sint64. */
public func sintSize(val: Int64) {
    varintSize(zigzag(val))
}

/* packed size of sint32. */
public func sintSize(val: Int32) {
    varintSize(zigzag(val))
}

@OverflowWrapping
public func binSize(val: BytesSlice) {
    let size = val.size
    varintSize(size) + size
}

@OverflowWrapping
public func binSize(val: String) {
    let size = val.size
    varintSize(size) + size
}

@OverflowWrapping
public func binSize(val: MessageLite) {
    let size = val.size
    varintSize(size) + size
}

public interface Int32Enum <: ToString & Hashable {
    func value(): Int32
    func hashCode(): Int64 { Int64(value()) }
}

public interface Enum<E> <: Int32Enum & Equatable<E> where E <: Enum<E> {
    operator func==(e: E): Bool
    operator func!=(e: E) { !(this == e) }

    static func parse(v: Int32): E
    static func parse(v: String): E
}

public interface TypedMessage<M> <: Equatable<M> {
    func clone(): M
    func copyFrom(that: M): M
    func mergeFrom(that: M): Unit
    static func empty(): M
    static func fromBytes(src: Collection<Byte>): M
    static func fromBytes(src: BytesReader): M
}

class ParentNode {
    var next: ?ParentNode = None
    var count = 1
    ParentNode(let data: MessageLite) { }
}

struct Parents {
    var header: ?ParentNode = None

    public func markDirty(): Unit {
        var node = header
        while (let Some(n) <- node) {
            n.data.markDirty()
            node = n.next
        }
    }

    mut func insert(v: MessageLite) {
        var node = header ?? return header = ParentNode(v)
        while (!refEq(node.data, v)) {
            node = node.next ?? return node.next = ParentNode(v)
        }

        node.count++
    }

    mut func remove(v: MessageLite) {
        var node = header ?? return ()
        if (refEq(node.data, v)) {
            return if (node.count > 1) { node.count-- } else { header = node.next }
        }
        while (let Some(n) <- node.next) {
            if (refEq(n.data, v)) {
                return if (n.count > 1) { n.count -- } else { node.next = n.next }
            }
            node = n
        }
    }
}

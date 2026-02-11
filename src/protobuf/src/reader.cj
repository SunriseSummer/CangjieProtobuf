/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file about: BytesReader
 */
package protobuf

/* public interface of reader. */
public interface BytesReader {
    /* no data unread */
    func isEmpty(): Bool
    /* read and increase the offset */
    func read(): Byte
    /* read a bytes slice with length of `len` and increase the offset */
    func read(len: Int64): BytesSlice

    /* parse a tag(with wire-type) from  */
    func parseTag(): (Tag, WireNum)

    /* get varint data from bytes reader */
    func parseVarintData(): BytesSlice

    /* parse uint64 from varint encoded  */
    func parseUInt64(): UInt64

    /* parse int64 from varint encoded  */
    func parseInt64(): Int64

    /* parse uint32 from varint encoded  */
    func parseUInt32(): UInt32

    /* parse int32 from varint encoded  */
    func parseInt32(): Int32

    func parseBool(): Bool

    /* parse sint64. */
    func parseSInt64(): Int64

    /* parse sint32. */
    func parseSInt32(): Int32

    func parseFixed64(): UInt64

    func parseSFixed64(): Int64

    func parseFixed32(): UInt32

    func parseSFixed32(): Int32

    func parseFloat64(): Float64

    func parseFloat32(): Float32

    func parseBytesSlice(): BytesSlice

    func parseString(): String
}

/**
 * SimpleReader
 */
public class SimpleReader <: BytesReader {
    private var offset = 0          /* bytes offset */
    private let size: Int64         /* bytes size */

    public SimpleReader(let bytes: BytesSlice) {
        size = bytes.size
    }

    public init(data: Collection<Byte>, begin!: Int64 = 0, end!: Int64 = data.size) {
        this(BytesSlice(data)[begin .. end])
    }

    public init() {
        this(BytesSlice())
    }

    /** Returns true if this Reader contains no elements. */
    public func isEmpty() {
        return offset >= size
    }

    /** read a byte, increase the offset */
    @OverflowWrapping
    public func read() {
        offset++
        bytes[offset - 1]
    }

    /** read length of `len` bytes, return its reader. */
    @OverflowWrapping
    public func read(len: Int64) {
        offset += len
        bytes.slice(offset - len, len)
    }

    /* parse a tag(with wire-type) from  */
    @OverflowWrapping
    public func parseTag(): (Tag, WireNum) {
        var byte = read()
        if ((byte & 0xf8) == 0) {
            throw ParseValueExecption("tag", reason: "invalid tag value")
        }

        var tag = UInt32(byte & 0x7f) >> 3
        let wireType = byte & 7
        if (byte < 0x80) {
            return (tag, wireType)
        }

        var shift: UInt8 = 4
        while (shift <= 25) {
            byte = read()
            if (byte < 0x80) {
                tag |= UInt32(byte) << shift
                return (tag, wireType)
            }

            tag |= UInt32(byte & 0x7f) << shift
            shift += 7
        }

        throw ParseValueExecption("tag", reason: "invalid tag value")
    }

    /* get varint data from bytes reader */
    @OverflowWrapping
    public func parseVarintData() {
        var byte = read()
        if (byte < 0x80) {
            return unsafe { BytesSlice.move([byte]) }
        }

        let data: Bytes = [byte, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var i = 1
        while (i < 10) {
            byte = read()
            data[i] = byte
            if (byte < 0x80) {
                return unsafe { BytesSlice.move(data[.. i + 1]) }
            }
        }

        throw ParseValueExecption("varint", reason: "invalid value")
    }

    /* parse uint64 from varint encoded  */
    @OverflowWrapping
    public func parseUInt64() {
        var byte = read()
        var rv = UInt64(byte & 0x7f)
        if (byte < 0x80) {
            return rv
        }

        var shift: UInt8 = 7
        while (shift <= 63) {
            byte = read()
            if (byte < 0x80) {
                rv |= UInt64(byte) << shift
                return rv
            }
            rv |= UInt64(byte & 0x7f) << shift
            shift += 7
        }

        throw ParseValueExecption("varint", reason: "invalid value")
    }

    /* parse int64 from varint encoded  */
    @OverflowWrapping
    public func parseInt64() {
        Int64(parseUInt64())
    }

    /* parse uint32 from varint encoded  */
    @OverflowWrapping
    public func parseUInt32() {
        var byte = read()
        var rv = UInt32(byte & 0x7f)
        if (byte < 0x80) {
            return rv
        }

        byte = read()
        rv |= UInt32(byte & 0x7f) << 7
        if (byte < 0x80) {
            return rv
        }

        byte = read()
        rv |= UInt32(byte & 0x7f) << 14
        if (byte < 0x80) {
            return rv
        }

        byte = read()
        rv |= UInt32(byte & 0x7f) << 21
        if (byte < 0x80) {
            return rv
        }

        byte = read()
        rv |= UInt32(byte) << 28
        /* scan varint */
        if ((byte > 0x7f) && (read() > 0x7f) && (read() > 0x7f) && (read() > 0x7f) && (read() > 0x7f)) {
            read()
        }

        return rv
    }

    /* parse int32 from varint encoded  */
    @OverflowWrapping
    public func parseInt32() {
        Int32(parseUInt32())
    }

    public func parseBool() {
        read() != 0
    }

    /* parse sint64. */
    @OverflowWrapping
    public func parseSInt64() {
        unzigzag((parseUInt64()))
    }

    /* parse sint32. */
    @OverflowWrapping
    public func parseSInt32() {
        unzigzag((parseUInt32()))
    }

    @OverflowWrapping
    public func parseFixed64() {
        UInt64(read()) | (UInt64(read()) << 8) | (UInt64(read()) << 16) | (UInt64(read()) << 24) |
        (UInt64(read()) << 32) | (UInt64(read()) << 40) | (UInt64(read()) << 48) | (UInt64(read()) << 56)
    }

    @OverflowWrapping
    public func parseSFixed64() {
        Int64(parseFixed64())
    }

    @OverflowWrapping
    public func parseFixed32() {
        UInt32(read()) | (UInt32(read()) << 8) | (UInt32(read()) << 16) | (UInt32(read()) << 24)
    }

    @OverflowWrapping
    public func parseSFixed32() {
        Int32(parseFixed32())
    }

    public func parseFloat64() {
        unsafe { ltod(parseFixed64()) }
    }

    public func parseFloat32() {
        unsafe { itof(parseFixed32()) }
    }

    public func parseBytesSlice() {
        read(parseInt64())
    }

    public func parseString() {
        unsafe { String.fromUtf8Unchecked((read(parseInt64()).getRawArray())) }
    }
}
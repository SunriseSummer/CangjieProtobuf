/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

public struct StructPrinter <: ToString {
    private let stb = StringBuilder("{")
    private var sep = false

    public mut func append(key: String, str: ToString): Unit {
        if (sep) { stb.append(", ") } else { sep = true }
        stb.append(key)
        stb.append(": ")
        stb.append(str)
    }

    public mut func append(key: String, str: String): Unit {
        if (sep) { stb.append(", ") } else { sep = true }
        stb.append(key)
        stb.append(": \"")
        stb.append(str)
        stb.append('"')
    }

    public mut func clear(): Unit { stb.reset(); stb.append('{'); sep = false }
    public func done() { stb.append('}'); this }
    public func toString() { stb.toString() }
}

public func subReader<T>(reader: T) where T <: BytesReader {
    SimpleReader(reader.read(reader.parseInt64()))
}

public func validate<T>(reader: T) where T <: BytesReader {
    while (!reader.isEmpty()) {
		match (reader.parseTag()[1]) {
			case 0 => reader.parseUInt32()
			case 1 => reader.parseFixed64()
			case 2 => reader.read(reader.parseInt64())
			case 5 => reader.parseFixed32()
			case _ => throw Exception("Invalid wire-type")
		}
	}
}

public func isNone<T>(val: ?T) {
    match (val) {
        case None => return true
        case _ => return false
    }
}

public func isPresent<T>(val: ?T) {
    match (val) {
        case None => return false
        case _ => return true
    }
}
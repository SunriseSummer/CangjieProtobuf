/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protoc

/* 通过ffi进行stdio */

foreign func memcpy_s(dest: CPointer<UInt8>, dest_max: IntNative, src: CPointer<UInt8>, count: IntNative): IntNative
foreign func free(ptr: CPointer<UInt8>): Unit

@C
struct Buffer {
    var data = CPointer<UInt8>()
    var size: IntNative = 0
}

foreign func stdin_read(): Buffer
foreign func stdout_write(data: CPointer<UInt8>, size: IntNative): Unit

func stdin(): Array<UInt8> {
    unsafe {
        let buffer = stdin_read()
        if (buffer.data.isNull()) {
            throw Exception()
        }

        let array = Array<UInt8>(Int64(buffer.size), repeat: 0)
        let rawData = acquireArrayRawData(array)
        let err = memcpy_s(rawData.pointer, buffer.size, buffer.data, buffer.size)
        releaseArrayRawData(rawData)
        free(buffer.data)

        if (err != 0) {
            throw Exception()
        }

        return array
    }
}

func stdout(c: Array<UInt8>) {
    unsafe {
        let rawData = acquireArrayRawData(c)
        stdout_write(rawData.pointer, IntNative(rawData.array.size))
        releaseArrayRawData(rawData)
    }
}
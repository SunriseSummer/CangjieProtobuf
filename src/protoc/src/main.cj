/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2025. All rights reserved.
 */
package protoc

import std.env.*

@When[os == "Windows"]
foreign func _setmode(fd: IntNative, mode: IntNative): IntNative

@When[os != "Windows"]
func _setmode(fd: IntNative, mode: IntNative): Unit {}

main() {
    // 1. 从标准输入读取二进制数据
    unsafe {
        _setmode(0, 0x8000) //设置windows标准输入为二进制模式
    }
    let input = ArrayList<Byte>()
    let buffer = Array<Byte>(1024, repeat: 0)
    let stdIn = getStdIn()
    var len = stdIn.read(buffer)
    while (len > 0) {
        input.add(all: buffer[..len])
        len = stdIn.read(buffer)
    }
    let output = cj_generator(unsafe { input.getRawArray()[..input.size] })

    let stdOut = getStdOut()
    stdOut.write(output)
    stdOut.flush()
}

extend FieldDescriptorProto {
    prop shortTypeName: String {
        get() {
            let fullname = this.typeName
            let arr = fullname.split(".")
            if (arr.size == 1) {
                return fullname
            }
            if (arr.size == 2) {
                return "pkg_${arr[0]}.${arr[1]}"
            }
            let pkg = arr[..arr.size - 1] |> collectString(delimiter: "_")
            return "pkg_${pkg}.${arr[arr.size - 1]}"
        }
    }
}

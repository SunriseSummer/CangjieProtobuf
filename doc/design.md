### 三方库设计说明

#### 1 需求场景分析

一个用于解析 Google Protocol Buffers 文件生成仓颉代码的库。

#### 2 三方库对外提供的特性

支持 Google Protocol Buffers

#### 3 License分析

MIT License

|  Permissions   | Limitations  |
|  ----  | ----  |
| Commercial use |  |
| Modification  |  |
| Distribution  |   |
| Private use   |   |

#### 4 依赖分析

    依赖 google protobuf

#### 5 特性设计文档

##### 5.1 核心特性

###### 5.1.1 特性介绍

    解析 Google Protocol Buffers 文件生成仓颉代码

###### 5.1.2 实现方案

软件主要分为 protobuf, protoc 两个部分

    protobuf 提供 libprotobuf-cj.a, 在仓颉中使用 Google Protocol Buffers 需要链接该静态库

    protoc 提供 protoc-gen-cj, 一个 google protoc 的 plugin, 用于将.proto 文件编译为仓颉代码

###### 5.1.3 核心类和成员函数说明

💡 消息抽象类型

    public abstract class MessageLite <: ToString & Hashable 

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| prop size | | Int64 | 序列化字节数 |
| func isEmpty | 无 | Bool | 是否为空消息 |
| func clear | 无 | Unit | 清除所有字段为空 |
| func unpacki | src: BytesReader | Unit | 从src反序列化 |
| func unpack | src: Collection<Byte> | Unit | 从src反序列化 |
| func unpack | src: BytesSlice | Unit | 从src反序列化 |
| func packi | out: BytesWriter| Unit | 向out序列化 |
| func pack | out: Bytes | Unit | 向out序列化 |
| func pack | 无 | Bytes | 序列化到字节数据 |
| func markDirty | 无 | Unit | 清理缓存 |

💡 消息类型接口

    public interface TypedMessage<M> <: Equatable<M> 

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func clone | 无 | M | 消息克隆 |
| func copyFrom | that: M | M | 从that复制 |
| static func empty | 无 | M | 空消息实例 |
| static func fromBytes | src: Collection<Byte> | M | 从src反序列化消息实例 |
| static func fromBytes | src: BytesReader | M | 从src反序列化消息实例 |

💡 枚举值接口

    public interface Int32Enum <: ToString & Hashable 

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func value  | 无 | Int32 | 枚举值 |

💡 枚举类型接口

    public interface Enum<E> <: Int32Enum & Equatable<E> where E <: Enum<E> 

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| static func parse | v: Int32 | E | 从值解析枚举 |
| static func parse | v: String | E | 从名称解析枚举 |
| operator func== | e: E | Bool | == |
| operator func!= | e: E | Bool | != |

💡 只读数组类型

    public struct RoArray<T> <: Collection<T>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| unsafe static func move | data: Array<T> | RoArray<T> | 引用data创建只读数组实例 |
| unsafe func getRawArray | 无 | Array<T> | 获取raw data |
| func get | index: Int64 | ?T | 索引数据 |
| operator func [] | index: Int64 | T | 访问数据 |
| operator func [] | range: Range<Int64> | RoArray<T> | 获取分片 |
| func slice | start: Int64, len: Int64 | RoArray<T> | 获取分片 |
| func copyTo | dst: Array<T>, dstStart: Int64 | Unit | 拷贝到dst |
| func clone | 无 | RoArray<T> | 克隆 |
| func isEmpty | 无 | Bool | 是否为空 |
| func toArray | 无 | Array<T> |  |

💡 字节切片（只读字节数组别名）

    public type BytesSlice = RoArray<Byte>

💡 可重复标量字段类型

    public class RepeatedField<T> <: Collection<T>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |

💡 可重复消息字段类型

    public class RepeatedMessage<T> <: Collection<T> & ToString & Hashable where T <: MessageLite & TypedMessage<T>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |

💡 map 标量字段类型

    public class MapField<K, V> <: Map<K, V> where K <: Hashable & Equatable<K>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |

💡 map 消息字段类型

    public class MapMessage<K, V> <: Map<K, V> where K <: Hashable & Equatable<K>, V <: MessageLite & TypedMessage<V>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |

💡 oneof 组接口

    public interface OneofGroup <: ToString & Hashable

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func which | 无 | String | 当前oneof组的case |
| func which | one: String | Bool | one是否为当前oneof组的case |
| func isEmpty | 无 | Bool | 当前oneof组是否为空 |

💡 未知字段类型

    public class MessageUnknownField <: ToString & Hashable & Equatable<MessageUnknownField>

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func packSize | 无 | Int64 | 序列化大小 |
| func pack<T> where T <: BytesWriter | out: T | Unit | 向out序列化 |
| static func unpack<T> where T <: BytesReader | tag: Tag, wt: WireNum, src: T | MessageUnknownField | 从src反序列化 |

💡 字节读取源接口

    public interface BytesReader

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func isEmpty | 无 | Bool | 是否没有可读数据 |
| func read | 无 | Byte | 读取一字节 |
| func read | len: Int64 | BytesSlice | 读取长度为len的字节分片 |

💡 字节写入源接口

    public interface BytesWriter

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| func append | val: Byte | Unit | 追加一字节 |
| func appendBytes | val: Bytes | Unit | 追加字节数组 |

💡 简单字节读取器

    public class SimpleReader <: BytesReader

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| SimpleReader | bytes: BytesSlice | SimpleReader | 从字节切片创建实例 |
| SimpleReader | data: Collection<Byte>, begin!: Int64 = 0, end!: Int64 = data.size | SimpleReader | 从字节集合创建实例 |

💡 简单字节写入器

    public class SimpleWriter <: BytesWriter

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | --- |
| SimpleWriter | size: Int64 | SimpleWriter | 创建指定容量的实例 |
| func clear | 无 | Unit | 清空数据 |
| func isFull | 无 | Bool | 容量已满 |

##### 5.2 展示示例
1. 安装对应版本cangjie
2. 设置CANGJIE_PATH（用于存放编译文件）
3. 安装google protobuf
4. 拉取protobuf-cj库
5. 拉取依赖库
    - cd protobuf-cj
    - git submodule update --init --recursive
6. 编译&安装protobuf-cj库、protoc-gen-cj插件
    - make
    - make install （若权限拒绝，可尝试 sudo -E make install）
7. 使用protoc将proto文件编译为cangjie代码，生成 .pb.cj
    - protoc --cj_out=src/ -Isrc/ $(proto_files)
8. 在项目中导入*.pb.cj所在包，编译时添加-lprotobuf-cj

example.proto 文件内容
```cangjie
syntax = "proto3";
package foo;

message Person {
    string name = 1;
    int32 id = 2;
    string email = 3;
}
```
示例   
```cangjie
import collection.*
import io.*
import foo.* // The foo package is generated by the protobuf-gen-cj plugin.

main() {
    var p = Person()
    // parameter assignment
    p.name = "test"
    p.id = 1
    p.email = "test@huawei.com"
    // print
    println("Serialize to string: ${p}")
    // encode
    var b = p.pack()
    println("Serialize result: ${b}")
    // decode
    var p1 = Person.fromBytes(b)
    println("Deserialization result: ${p1}")
    return
}
```

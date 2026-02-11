## protobuf 库

### 介绍
仓颉的protobuf支持 [Google Protocol Buffers](https://developers.google.com/protocol-buffers/)

### 1 提供protobuf，支持序列化和反序列化自定义的消息格式的.proto数据

前置条件：NA
场景：
1.支持自定义的消息格式的.proto文件，序列化.和反序列化proto的数据。
约束：支持的标量数值类型double、float、int32、int64、uint32、uint64、sint32、sint64、fixed32、fixed64、sfixed32、sfixed64、bool、string、bytes。
性能：支持版本几何性能持平
可靠性： NA

#### 1.1 序列化.proto文件数据

##### 1.1.1 主要接口

```cangjie
public abstract class MessageLite <: ToString & Hashable {

    prop size: Int64

    /**
     * 判断当前 MessageLite 是否是空。
     * 返回值 Bool - 是空返回 true，否则返回 false
     */
    func isEmpty(): Bool

    /**
     * 清空当前 MessageLite。
     */
    func clear(): Unit

    /**
     * 克隆当前 MessageLite。
     * 返回值 MessageLite - 克隆后产生的新的 MessageLite
     */
    func clone(): MessageLite

    /**
     * 将 src 中的数据，反序列化到 MessageLite 当前实现类中。
     * 参数 src - BytesReader 数据结构，存储要序列化的数据
     */
    func unpacki(src: BytesReader): Unit

    /**
     * 将当前 MessageLite 实现类，序列化生成的数据存储在 out 中。
     * 参数 out - BytesWriter 数据结构，存储序列化生成的数据
     */
    func packi(out: BytesWriter): Unit

    /**
     * 将 src 中的数据，反序列化到 MessageLite 当前实现类中。
     * 参数 src - Collection<Byte> 数据结构，存储要序列化的数据
     */
    func unpack(src: Collection<Byte>): Unit

    /**
     * 将 src 中的数据，反序列化到 MessageLite 当前实现类中。
     * 参数 src - BytesSlice 数据结构，存储要序列化的数据
     */
    func unpack(src: BytesSlice): Unit

    /**
     * 将当前 MessageLite 实现类，序列化生成的数据以Bytes形式返回。
     * 返回值 Bytes - Array<Byte> 数据结构，封装序列化生成的数据
     */
    func pack(): Bytes

    /**
     * 清空消息内部缓存
     * 对消息进行修改时内部会调用，不建议手动调用
     */
    public func markDirty(): Unit

    /**
     * 未值字段
     * 保存解析器未识别的符合语法规则的序列化后的数据。
     */
    public let unknownFields: RepeatedField<MessageUnknownField>
}
```

#### 1.2 示例

TODO

### 2 提供protoc插件，用于将.proto文件编译成仓颉代码

前置条件：NA
场景：
1.支持protoc工具将.proto文编译成仓颉代码
约束：符合对应版本协议的proto书写规范
性能： NA
可靠性： NA

#### 2.1 生成protc插件
根据 README.md 中安装教程，安装好 protoc-gen-cj 插件，执行使用说明的命令6生成仓颉代码文件。

#### 2.2 示例

本项目中例如 [descriptor.pb.cj](src/google/protobuf/descriptor.pb.cj)、[plugin.pb.cj](src/google/protobuf/compiler/plugin.pb.cj) 等所有`.pb.cj`文件均由对应的`.proto`文件通过使用 `protoc` 命令和 `protoc-gen-cj` 插件编译而生成.

可以尝试修改例如 [descriptor.proto](src/google/protobuf/descriptor.proto) 然后执行 `make gencode` 可以看到生成他们的命令和 [结果](src/google/protobuf/descriptor.pb.cj)

### 3 提供grpc使用lib库

前置条件：NA
场景：
1.提供grpc lib库供grpc在仓颉开发中调用
约束： NA
性能： 支持版本几何性能持平
可靠性： NA

#### 3.1 主要接口

public enum LogVerbosity <: ToString
```cangjie
// 日志详细分类
TRACE | DEBUG | INFO | ERROR | NONE

/**
 * 转成String字符串
 *
 * 返回值 String 字符串
 */
public func toString()
```

public struct Metadata <: ToString & Collection<(String, ArrayList<String>)> 
```cangjie
/**
 * 空参构造
 */
public init()

/**
 * 构造函数
 *
 * 参数 items - 数据集合
 */
public init(items: Collection<(String, String)>)

/**
 * 转成String字符串
 *
 * 返回值 String 字符串
 */
public func toString()

/**
 * 迭代器
 *
 * 返回值 iterator 传入数据对应的迭代器
 */
public func iterator()

/**
 * 添加数据
 *
 * 参数 key - 键
 * 参数 value - 值
 */
public func append(key: String, value: String) 

/**
 * 添加数据集合
 *
 * 参数 key - 键
 * 参数 value - 值集合
 */
public func append(key: String, values: Collection<String>)

/**
 * 根据键 移除值
 *
 * 参数 key - 键
 */
public func remove(key: String) 

/**
 * 移除指定数据
 *
 * 参数 key - 键
 * 参数 value - 值
 */
public func remove(key: String, value: String): Unit

/**
 * 获取值
 *
 * 参数 key - 键
 * 返回值 Collection<String> 键对应的所有值
 */
public func get(key: String)

/**
 * 获取值
 *
 * 参数 key - 键
 * 返回值 ?String 键对应的值
 */
public func getOne(key: String): ?String

/**
 * 附加二进制数据
 *
 * 参数 key - 键
 * 参数 bin - 二进制数据
 */
public func append(key: String, bin: Array<Byte>)

/**
 * 获取二进制数据
 *
 * 参数 key - 键
 * 返回值 ?Array<Byte> 二进制数据
 */
public func getBin(key: String): ?Array<Byte>

/**
 * 克隆
 *
 * 返回值 Metadata Metadata对象
 */
public func clone()

/**
 * 清除数据
 */
public func clear()

/**
 * 判断数据是否为空
 *
 * 返回值 Bool true为空 false为非空
 */
public func isEmpty()

/**
 * 检查头键是否属于http2或grpc保留，键必须是小写
 *
 * 参数 key - 键
 * 
 * 返回值 Bool true为是 false为否
 */
public static func isReservedHeader(key: String)
```

public enum Status <: ToString
```cangjie
// 状态代码
OK | CANCELLED | UNKNOWN | INVALID_ARGUMENT | DEADLINE_EXCEEDED | NOT_FOUND | ALREADY_EXISTS |
PERMISSION_DENIED | RESOURCE_EXHAUSTED | FAILED_PRECONDITION | ABORTED | OUT_OF_RANGE | UNIMPLEMENTED |
INTERNAL | UNAVAILABLE | DATA_LOSS | UNAUTHENTICATED

/**
 * 当前状态是否为 ok
 * 
 * 返回值 Bool true为是 false为否
 */
public func ok()

/**
 * 获取当前异常
 * 
 * 返回值 ?Exception 异常信息
 */
public func exception()

/**
 * 当前状态码转为字符串
 * 
 * 返回值 String 状态码对应的字符串
 */
public func toString()

/**
 * 获取数值对应的状态码
 *
 * 参数 code - 数值
 * 
 * 返回值 Status 数值对应的状态码 按照枚举类中的书写顺序 0为OK  1为CANCELLED 以此类推
 */
public static func fromCode(code: UInt8): Status

```

public struct Address <: ToString
```cangjie
/**
 * 构造函数
 *
 * 参数 scheme - 协议
 * 参数 host - 主机地址
 * 参数 port - 端口号 
 */
public Address (
    public let scheme: String,
    public let host: String,
    public let port: UInt16
) 

/**
 * 构造函数
 *
 * 参数 url - url地址：http[s]://<host>[:<port>]
 * 
 */
public init (url: String)

/**
 * 地址转为字符串
 * 
 * 返回值 String 地址对应的字符串
 */
public func toString()
```
public interface Channel 
```cangjie
/**
 * 新建会话
 * 
 * 异常 Exception
 * 返回值 ClientSession 新会话
 */
func newSession(path: String, opts: CallOptions): ClientSession
```
public class SingleChannel <: Channel
```cangjie
/**
 * 构造函数
 *
 * 参数 addr - 地址
 * 参数 cred - 凭证
 */
public init(addr: Address, cred: Credential)

/**
 * 构造函数
 *
 * 参数 addr - 地址
 */
public init(addr: Address)

/**
 * socket连接
 * 
 */
public func connect(): SingleChannel

/**
 * 关闭连接
 * 
 */
public func close()

/**
 * 新建会话
 *
 * 异常 Exception
 * 返回值 ClientSession 新会话
 */
@OverflowWrapping
public func newSession(path: String, opts: CallOptions) 
```
// 凭证
public struct Credential

public struct Context
```cangjie
/**
 * 构造函数
 *
 * 参数 sess - Socke会话
 */
Context(let sess: ServerSession)

/**
 * 取消
 */
public func cancel()

/**
 * 发送数据头
 *
 * 参数 metadata - 数据头
 */
public func sendHeader(metadata: Metadata)

/**
 * 设置附加数据
 *
 * 参数 metadata - 附加数据
 */
public func setTrailer(metadata: Metadata)

/**
 * 获取请求数据
 *
 * 返回值 Metadata - 请求数据
 */
public func getRequsetMetadata(): Metadata

/**
 * 获取请求超时时长
 *
 * 返回值 ?Duration - 请求超时时长
 */
@OverflowWrapping
public func getRequestTimeout(): ?Duration
```

public class CallOptions
```cangjie
/**
 * 构造函数
 *
 * 参数 timeout - 超时时长
 * 参数 metadata - 请求数据
 * 参数 recHeader - 请求数据头
 * 参数 recTrailer - 附加数据
 */
public CallOptions(
    public var timeout!: ?Duration = None,
    public var metadata!: ?Metadata = None,
    public var recHeader!: ?Metadata = None,
    public var recTrailer!: ?Metadata = None
)

/**
 * 构造函数
 *
 * 参数 opts - 请求配置信息对象
 */
public init(opts: CallOptions)

/**
 * 设置超时时长
 *
 * 参数 timeout - 超时时长
 */
public func withTimeOut(timeout: ?Duration)

/**
 * 设置请求数据
 *
 * 参数 metadata - 请求数据
 */
public func withMetadata(metadata: ?Metadata)

/**
 * 设置请求头
 *
 * 参数 recHeader - 请求头
 */
public func withRecHeader(recHeader: ?Metadata)

/**
 * 设置附加数据
 *
 * 参数 recTrailer - 附加数据
 */
public func withRecTrailer(recTrailer: ?Metadata)
```

public struct ServerReader<M> where M <: MessageLite
```cangjie
/**
 * 读取数据
 *
 * 参数 m - 请求数据
 * 返回值 Bool 是否读取成功
 */
public func read(m: M): Bool
```

public struct ServerWriter<M> where M <: MessageLite
```cangjie
/**
 * 写入数据
 *
 * 参数 m - 请求数据
 */
public func write(m: M)
```

public struct ServerReaderWriter<MR, MW> where MR <: MessageLite, MW <: MessageLite
```cangjie
/**
 * 读取数据
 *
 * 参数 m - 请求数据
 * 返回值 Bool 是否读取成功
 */
public func read(m: MR): Bool
/**
 * 写入数据
 *
 * 参数 m - 请求数据
 */
public func write(m: MW)
```

public struct AsyncCaller<M> where M <: MessageLite & TypedMessage<M>
```cangjie
/**
 * 结束AsyncCaller
 *
 * 返回值 M 请求数据的unpack后的数据
 * 返回值 Status 是否读取成功
 */
public func finish(): (M, Status)
/**
 * 结束AsyncCaller
 *
 * 参数 m - 请求数据
 * 返回值 Status 是否读取成功
 */
public func finish(m: M): Status
/**
 * 取消
 */
public func cancel()
```

public struct ClientReader<M> where M <: MessageLite
```cangjie
/**
 * 读取数据
 *
 * 参数 m - 请求数据
 * 返回值 Bool 是否读取成功
 */
public func read(m: M): Bool

/**
 * 结束ClientReader
 *
 * 返回值 Status 是否读取成功
 */
public func finish(): Status
/**
 * 取消
 */
public func cancel()
```

public struct ClientWriter<MR, MW> where MR <: MessageLite & TypedMessage<MR>, MW <: MessageLite
```cangjie
/**
 * 写入数据
 *
 * 参数 m - 请求数据
 */

public func write(m: MW)
/**
 * 结束ClientWrite
 *
 * 返回值 MR 请求数据unpack后的数据
 * 返回值 Status 是否成功
 */
public func finish(): (MR, Status)

/**
 * 结束ClientWrite
 *
 * 参数 m - 请求数据
 * 返回值 Status 是否成功
 */
public func finish(m: MR): Status
/**
 * 取消
 */
public func cancel()
```

public struct ClientReaderWriter<MR, MW> where MR <: MessageLite, MW <: MessageLite 
```cangjie
/**
 * 读取数据
 *
 * 参数 m - 请求数据
 * 返回值 Bool 是否读取成功
 */
public func read(m: MR): Bool

/**
 * 写入数据
 *
 * 参数 m - 请求数据
 */
public func write(m: MW)

/**
 * 结束ClientReaderWriter
 *
 * 返回值 Status 是否成功
 */
public func finish(): Status
/**
 * 取消
 */
public func cancel()
```

public class Server
```cangjie
/**
 * 绑定服务
 *
 * 参数 ss - SocketServer类型服务
 */
public func bind(ss: SocketServer)

/**
 * 绑定服务
 *
 * 参数 addr - 地址
 */
public func bind(addr: Address)

/**
 * 绑定服务
 *
 * 参数 addr - 地址
 * 参数 cred - 凭证
 */
public func bind(addr: Address, cred: Credential) 

/**
 * 注册服务
 */
public func registerService(service: Service)

/**
 * 运行服务
 */
public func run()

/**
 * 终止服务
 */
public func shutdown(): Unit
```


#### 3.2 示例
根据 README.md 中的 grpc examples 进行操作运行。
```cangjie
package grpc.examples.example

import grpc.examples.*
import grpc.*

import std.sync.*
import std.time.*

main() {
    let addr = Address("http://0.0.0.0:8088") // addr of server
    let cred = Credential()

    let server = grpc.Server()          // grpc server
    server.bind(addr, cred)             // bind addr
    server.registerService(EchoServiceImpl())   // register echo service
    println("server start.")

    let chan = SingleChannel(addr, cred)      // client channel
    let client = EchoClient(chan)       // echo client
    let count = AtomicInt64(0)

    spawn {
        sleep(1000 * 1000 * 200)        // sleep 200ms
        chan.connect()

        let start = DateTime.now()
        for (t in 0..3) {
            spawn {
                let req = Text()
                for (i in 0..3) {
                    req.text = "hello! i'm spawn[${t}] req[${i}]"   // request
                    print("send: ${req.text}\n", flush: true)
                    let (resp, status) = client.echo(req)           // call rpc "echo"
                    print("resp: ${resp.text}, status: ${status}\n", flush: true)      // print "echo" response

                    if (count.fetchAdd(1) == 8) {
                        println("cost time ${Duration.since(start)}")
                        server.shutdown()               // server shutdown, blocked `run()` will stop.
                        println("server shutdown.")
                    }
                }
            }
        }

        let stream = client.echoDoubleStream()       // stream support
        let text = Text()
        for (i in 0..9) {
            text.text = "hello stream, req[${i}]"
            print("send: ${text}\n", flush: true)
            stream.write(text)                          // send request message to stream

            // req.clear()
            if (stream.read(text)) {                    // try to recv response message from stream
                print("recv: ${text}\n", flush: true)
            }
        }

        print("status: ${stream.finish()}\n", flush: true) // .finish() to recv grpc status, and close the stream
    }

    server.run()        // serve and block
    println("exit...")  // exit.
    0
}

/* echo service impl */
class EchoServiceImpl <: EchoService {
    public func echo(ctx: Context, req: Text) {
        (req, OK) // echo, returns req itself.
    }

    protected func echoServerStream(ctx: Context, req: Text, writer: ServerWriter<Text>): Status {
        for (i in 0..10) {
            /* send responses to client */
            writer.write(req)
        }

        /* return response status */
        OK
    }

    protected func echoClientStream(ctx: Context, reader: ServerReader<Text>): (Text, Status) {
        let resp = Text()
        let tmp = Text()

        /* recv requests from client */
        while (reader.read(tmp)) {
            resp.text += tmp.text
        }

        /* return response message and status */
        (resp, OK)
    }

    protected func echoDoubleStream(ctx: Context, stream: ServerReaderWriter<Text, Text>): Status {
        let text = Text()

        /* recv requests from client */
        while (stream.read(text)) {
            /* send responses to client */
            stream.write(text)
        }

        /* return response status */
        OK
    }
}
```

执行结果如下：

```shell
server start.
send: {text: "hello stream, req[0]"}
send: hello! i'm spawn[1] req[0]
send: hello! i'm spawn[0] req[0]
send: hello! i'm spawn[2] req[0]
resp: hello! i'm spawn[1] req[0], status: OK
recv: {text: "hello stream, req[0]"}
send: hello! i'm spawn[1] req[1]
send: {text: "hello stream, req[1]"}
resp: hello! i'm spawn[0] req[0], status: OK
send: hello! i'm spawn[0] req[1]
resp: hello! i'm spawn[2] req[0], status: OK
send: hello! i'm spawn[2] req[1]
resp: hello! i'm spawn[1] req[1], status: OK
send: hello! i'm spawn[1] req[2]
resp: hello! i'm spawn[2] req[1], status: OK
send: hello! i'm spawn[2] req[2]
recv: {text: "hello stream, req[1]"}
send: {text: "hello stream, req[2]"}
resp: hello! i'm spawn[0] req[1], status: OK
send: hello! i'm spawn[0] req[2]
resp: hello! i'm spawn[1] req[2], status: OK
recv: {text: "hello stream, req[2]"}
send: {text: "hello stream, req[3]"}
resp: hello! i'm spawn[0] req[2], status: OK
resp: hello! i'm spawn[2] req[2], status: OK
cost time 241ms760us223ns
exit...
server shutdown.
```

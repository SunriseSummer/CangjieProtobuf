# Cangjie + Node.js Protobuf Interop

本示例演示仓颉作为宿主程序，使用 C 互操作能力调用基于 N-API 的 Node.js 运行时，完成 Protobuf 数据的双向传输。

## 目录结构

```
examples/js
├── cj            # 仓颉示例工程
├── js            # Node.js 依赖与处理逻辑
├── native        # N-API 桥接层 (C++)
└── proto         # Protobuf 定义
```

## 数据结构覆盖

- 基础类型: `int32` / `int64` / `bool` / `string` / `bytes` / `float` / `double`
- 数组类型: `repeated int32` / `repeated string` / `repeated bytes`
- 复杂自定义类型: `Address` / `Item` / `CjRequest` / `JsReply`

## 依赖准备

- 安装 Cangjie 工具链 (`cjc`, `cjpm`)
- 安装 Node.js (建议 18+)
- 确保可获取 Node 头文件与 `libnode` 共享库

## 构建步骤

### 1. 安装 JS 依赖

```bash
cd examples/js/js
npm install
```

### 2. 构建 N-API 桥接库

```bash
cd examples/js/native
cmake -S . -B build \
  -DNODE_DIR=/path/to/node \
  -DNODE_LIBRARY=/path/to/libnode.so
cmake --build build
```

> `NODE_DIR` 需指向包含 `include/node` 的目录，`NODE_LIBRARY` 需指向 `libnode`。
> Cangjie 工程默认链接 `../native/build`，请保持输出目录为 `native/build`。

### 3. 构建仓颉示例

```bash
cd examples/js/cj
cjpm build
```

## 运行示例

默认会从运行目录下的 `./js/interop.js` 加载脚本，也可通过环境变量 `CJ_JS_ENTRY` 指定绝对路径。

```bash
cd examples/js
./cj/target/debug/cj_js_interop
```

运行后将看到仓颉侧输出的请求内容，以及 JS 侧处理后回传的响应内容。

## 重新生成 Cangjie 代码 (可选)

如果修改了 `proto/interop.proto`，可通过以下命令重新生成仓颉代码:

```bash
protoc --cj_out=./cj/src --proto_path=./proto interop.proto
```

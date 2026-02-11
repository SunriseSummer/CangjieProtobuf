import collection.*
import interop.*
import protobuf.*

foreign func memcpy_s(dest: CPointer<UInt8>, dest_max: IntNative, src: CPointer<UInt8>, count: IntNative): IntNative

@C
struct JsBuffer {
    var data = CPointer<UInt8>()
    var size: IntNative = 0
}

foreign func cj_js_init(): Bool
foreign func cj_js_call(data: CPointer<UInt8>, size: IntNative): JsBuffer
foreign func cj_js_free(buffer: JsBuffer): Unit
foreign func cj_js_shutdown(): Unit

func buildRequest(): CjRequest {
    let request = CjRequest()
    request.requestId = 42
    request.title = "cj-napi-demo"
    request.enabled = true
    request.timestamp = 1700000000
    request.ratio = 3.14159

    let rawBytes: Bytes = [1, 2, 3, 4, 5]
    request.raw = BytesSlice(rawBytes)

    request.scores.appendAll([98, 87, 93])
    request.tags.appendAll(["core", "ffi", "protobuf"])

    request.addresses.append(Address(street: "No.1 Road", city: "Shenzhen", zip: 518000))
    request.addresses.append(Address(street: "No.2 Road", city: "Beijing", zip: 100000))

    request.primaryItem = Item(id: 7, name: "primary", price: 12.5, available: true)
    request.items.append(Item(id: 1, name: "alpha", price: 2.5, available: true))
    request.items.append(Item(id: 2, name: "beta", price: 6.75, available: false))

    return request
}

main() {
    if (!cj_js_init()) {
        println("Failed to initialize Node runtime")
        return
    }

    let request = buildRequest()
    println("Cangjie request: ${request}")

    let packed = request.pack()
    unsafe {
        let rawData = acquireArrayRawData(packed)
        let response = cj_js_call(rawData.pointer, IntNative(rawData.array.size))
        releaseArrayRawData(rawData)

        if (response.data.isNull() || response.size == 0) {
            println("JS returned empty response")
            cj_js_free(response)
            cj_js_shutdown()
            return
        }

        let replyBytes = Array<UInt8>(Int64(response.size), repeat: 0)
        let replyRaw = acquireArrayRawData(replyBytes)
        let err = memcpy_s(replyRaw.pointer, IntNative(replyRaw.array.size), response.data, response.size)
        releaseArrayRawData(replyRaw)
        cj_js_free(response)

        if (err != 0) {
            println("Failed to copy JS response")
            cj_js_shutdown()
            return
        }

        let reply = JsReply.fromBytes(replyBytes)
        println("JS reply: ${reply}")
    }

    cj_js_shutdown()
}

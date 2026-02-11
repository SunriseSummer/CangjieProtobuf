/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package interop

internal import std.collection.*
internal import protobuf.*

public class Address <: MessageLite & TypedMessage<Address> {
    private var p_street: String
    private var p_city: String
    private var p_zip: Int32

    public init(
        street!: String = "",
        city!: String = "",
        zip!: Int32 = 0
    ) {
        this.p_street = street
        this.p_city = city
        this.p_zip = zip
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop street: String { get() { p_street } set(_x) { p_street = _x; markDirty() } }
    public mut prop city: String { get() { p_city } set(_x) { p_city = _x; markDirty() } }
    public mut prop zip: Int32 { get() { p_zip } set(_x) { p_zip = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_street.isEmpty()) { _x += 1 + binSize(p_street) }
        if (!p_city.isEmpty()) { _x += 1 + binSize(p_city) }
        if (p_zip != 0) { _x += 1 + varintSize(p_zip) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_street.isEmpty()) { _x.write(p_street.hashCode()) }
        if (!p_city.isEmpty()) { _x.write(p_city.hashCode()) }
        if (p_zip != 0) { _x.write(p_zip) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_street.isEmpty() && p_city.isEmpty() && p_zip == 0
    }

    protected func m_clear(): Unit {
        p_street = ""
        p_city = ""
        p_zip = 0
    }

    public operator func !=(src: Address): Bool { !(this == src) }
    public operator func ==(src: Address): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_street == src.p_street && p_city == src.p_city && p_zip == src.p_zip
    }

    public func mergeFrom(src: Address): Unit {
        if (!src.p_street.isEmpty()) { p_street = src.p_street }
        if (!src.p_city.isEmpty()) { p_city = src.p_city }
        if (src.p_zip != 0) { p_zip = src.p_zip }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: Address): Address {
        p_street = src.p_street
        p_city = src.p_city
        p_zip = src.p_zip
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): Address {
        return Address().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_street = src.parseString()
                case 2 => p_city = src.parseString()
                case 3 => p_zip = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit { }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!p_street.isEmpty()) { out.append(10); out.packBin(p_street) }
        if (!p_city.isEmpty()) { out.append(18); out.packBin(p_city) }
        if (p_zip != 0) { out.append(24); out.packVarint(p_zip) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_street.isEmpty()) { _x.append("street", p_street) }
        if (!p_city.isEmpty()) { _x.append("city", p_city) }
        if (p_zip != 0) { _x.append("zip", p_zip) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { Address() }
    public static func fromBytes(src: Collection<Byte>) { let _x = Address(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = Address(); _x.unpack(src); _x }
}

public class Item <: MessageLite & TypedMessage<Item> {
    private var p_id: Int32
    private var p_name: String
    private var p_price: Float32
    private var p_available: Bool

    public init(
        id!: Int32 = 0,
        name!: String = "",
        price!: Float32 = 0,
        available!: Bool = false
    ) {
        this.p_id = id
        this.p_name = name
        this.p_price = price
        this.p_available = available
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop id: Int32 { get() { p_id } set(_x) { p_id = _x; markDirty() } }
    public mut prop name: String { get() { p_name } set(_x) { p_name = _x; markDirty() } }
    public mut prop price: Float32 { get() { p_price } set(_x) { p_price = _x; markDirty() } }
    public mut prop available: Bool { get() { p_available } set(_x) { p_available = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_id != 0) { _x += 1 + varintSize(p_id) }
        if (!p_name.isEmpty()) { _x += 1 + binSize(p_name) }
        if (p_price != 0) { _x += 1 + 4 }
        if (p_available != false) { _x += 1 + 1 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_id != 0) { _x.write(p_id) }
        if (!p_name.isEmpty()) { _x.write(p_name.hashCode()) }
        if (p_price != 0) { _x.write(p_price) }
        if (p_available != false) { _x.write(p_available) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_id == 0 && p_name.isEmpty() && p_price == 0 && p_available == false
    }

    protected func m_clear(): Unit {
        p_id = 0
        p_name = ""
        p_price = 0
        p_available = false
    }

    public operator func !=(src: Item): Bool { !(this == src) }
    public operator func ==(src: Item): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_id == src.p_id && p_name == src.p_name && p_price == src.p_price && p_available == src.p_available
    }

    public func mergeFrom(src: Item): Unit {
        if (src.p_id != 0) { p_id = src.p_id }
        if (!src.p_name.isEmpty()) { p_name = src.p_name }
        if (src.p_price != 0) { p_price = src.p_price }
        if (src.p_available != false) { p_available = src.p_available }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: Item): Item {
        p_id = src.p_id
        p_name = src.p_name
        p_price = src.p_price
        p_available = src.p_available
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): Item {
        return Item().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_id = src.parseInt32()
                case 2 => p_name = src.parseString()
                case 3 => p_price = src.parseFloat32()
                case 4 => p_available = src.parseBool()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit { }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (p_id != 0) { out.append(8); out.packVarint(p_id) }
        if (!p_name.isEmpty()) { out.append(18); out.packBin(p_name) }
        if (p_price != 0) { out.append(29); out.packFixed(p_price) }
        if (p_available != false) { out.append(32); out.packBool(p_available) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_id != 0) { _x.append("id", p_id) }
        if (!p_name.isEmpty()) { _x.append("name", p_name) }
        if (p_price != 0) { _x.append("price", p_price) }
        if (p_available != false) { _x.append("available", p_available) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { Item() }
    public static func fromBytes(src: Collection<Byte>) { let _x = Item(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = Item(); _x.unpack(src); _x }
}

public class CjRequest <: MessageLite & TypedMessage<CjRequest> {
    private var p_requestId: Int32
    private var p_title: String
    private var p_enabled: Bool
    private var p_timestamp: Int64
    private var p_ratio: Float64
    private var p_raw: BytesSlice
    public let scores: RepeatedField<Int32>
    public let tags: RepeatedField<String>
    public let addresses: RepeatedMessage<Address>
    private var p_primaryItem: PbMessage<Item>
    public let items: RepeatedMessage<Item>

    public init(
        requestId!: Int32 = 0,
        title!: String = "",
        enabled!: Bool = false,
        timestamp!: Int64 = 0,
        ratio!: Float64 = 0,
        raw!: BytesSlice = BytesSlice(),
        scores!: Array<Int32> = [],
        tags!: Array<String> = [],
        addresses!: Array<Address> = [],
        primaryItem!: ?Item = None,
        items!: Array<Item> = []
    ) {
        this.p_requestId = requestId
        this.p_title = title
        this.p_enabled = enabled
        this.p_timestamp = timestamp
        this.p_ratio = ratio
        this.p_raw = raw
        this.scores = RepeatedField<Int32>(scores)
        this.tags = RepeatedField<String>(tags)
        this.addresses = RepeatedMessage<Address>(addresses)
        this.p_primaryItem = PbMessage<Item>(primaryItem)
        this.items = RepeatedMessage<Item>(items)
        m_init()
    }

    private func m_init() {
        m_init(scores)
        m_init(tags)
        m_init(addresses)
        if (let Some(_v) <- p_primaryItem.data) { m_init(_v) }
        m_init(items)
        m_innerInit()
    }

    public mut prop requestId: Int32 { get() { p_requestId } set(_x) { p_requestId = _x; markDirty() } }
    public mut prop title: String { get() { p_title } set(_x) { p_title = _x; markDirty() } }
    public mut prop enabled: Bool { get() { p_enabled } set(_x) { p_enabled = _x; markDirty() } }
    public mut prop timestamp: Int64 { get() { p_timestamp } set(_x) { p_timestamp = _x; markDirty() } }
    public mut prop ratio: Float64 { get() { p_ratio } set(_x) { p_ratio = _x; markDirty() } }
    public mut prop raw: BytesSlice { get() { p_raw } set(_x) { p_raw = _x; markDirty() } }
    public mut prop primaryItem: Item { get() { p_primaryItem.getOrDefault(this) } set(_v) { p_primaryItem.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_requestId != 0) { _x += 1 + varintSize(p_requestId) }
        if (!p_title.isEmpty()) { _x += 1 + binSize(p_title) }
        if (p_enabled != false) { _x += 1 + 1 }
        if (p_timestamp != 0) { _x += 1 + varintSize(p_timestamp) }
        if (p_ratio != 0) { _x += 1 + 8 }
        if (!p_raw.isEmpty()) { _x += 1 + binSize(p_raw) }
        if (!scores.isEmpty()) { for (_i in scores) { _x += 1 + varintSize(_i) } }
        if (!tags.isEmpty()) { for (_i in tags) { _x += 1 + binSize(_i) } }
        if (!addresses.isEmpty()) { for (_i in addresses) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_primaryItem.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (!items.isEmpty()) { for (_i in items) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_requestId != 0) { _x.write(p_requestId) }
        if (!p_title.isEmpty()) { _x.write(p_title.hashCode()) }
        if (p_enabled != false) { _x.write(p_enabled) }
        if (p_timestamp != 0) { _x.write(p_timestamp) }
        if (p_ratio != 0) { _x.write(p_ratio) }
        if (!p_raw.isEmpty()) { _x.write(p_raw.hashCode()) }
        if (!scores.isEmpty()) { _x.write(scores.hashCode()) }
        if (!tags.isEmpty()) { _x.write(tags.hashCode()) }
        if (!addresses.isEmpty()) { _x.write(addresses.hashCode()) }
        if (let Some(_v) <- p_primaryItem.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (!items.isEmpty()) { _x.write(items.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_requestId == 0 && p_title.isEmpty() && p_enabled == false && p_timestamp == 0 && p_ratio == 0 &&
        p_raw.isEmpty() && scores.isEmpty() && tags.isEmpty() && addresses.isEmpty() &&
        isNone(p_primaryItem.nonEmptyData()) && items.isEmpty()
    }

    protected func m_clear(): Unit {
        p_requestId = 0
        p_title = ""
        p_enabled = false
        p_timestamp = 0
        p_ratio = 0
        p_raw = BytesSlice()
        scores.clear()
        tags.clear()
        addresses.clear()
        p_primaryItem.removeFrom(this)
        items.clear()
    }

    public operator func !=(src: CjRequest): Bool { !(this == src) }
    public operator func ==(src: CjRequest): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_requestId == src.p_requestId && p_title == src.p_title && p_enabled == src.p_enabled &&
        p_timestamp == src.p_timestamp && p_ratio == src.p_ratio && p_raw == src.p_raw &&
        scores == src.scores && tags == src.tags && addresses == src.addresses &&
        p_primaryItem.data == src.p_primaryItem.data && items == src.items
    }

    public func mergeFrom(src: CjRequest): Unit {
        if (src.p_requestId != 0) { p_requestId = src.p_requestId }
        if (!src.p_title.isEmpty()) { p_title = src.p_title }
        if (src.p_enabled != false) { p_enabled = src.p_enabled }
        if (src.p_timestamp != 0) { p_timestamp = src.p_timestamp }
        if (src.p_ratio != 0) { p_ratio = src.p_ratio }
        if (!src.p_raw.isEmpty()) { p_raw = src.p_raw }
        if (!src.scores.isEmpty()) { scores.appendAll(src.scores) }
        if (!src.tags.isEmpty()) { tags.appendAll(src.tags) }
        if (!src.addresses.isEmpty()) { addresses.appendAll(src.addresses) }
        if (let Some(_v) <- src.p_primaryItem.nonEmptyData()) { p_primaryItem.getOrDefault(this).mergeFrom(_v) }
        if (!src.items.isEmpty()) { items.appendAll(src.items) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: CjRequest): CjRequest {
        p_requestId = src.p_requestId
        p_title = src.p_title
        p_enabled = src.p_enabled
        p_timestamp = src.p_timestamp
        p_ratio = src.p_ratio
        p_raw = src.p_raw
        scores.copyFrom(src.scores)
        tags.copyFrom(src.tags)
        addresses.copyFrom(src.addresses)
        p_primaryItem.copyFrom(this, src.p_primaryItem.data)
        items.copyFrom(src.items)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): CjRequest {
        return CjRequest().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_requestId = src.parseInt32()
                case 2 => p_title = src.parseString()
                case 3 => p_enabled = src.parseBool()
                case 4 => p_timestamp = src.parseInt64()
                case 5 => p_ratio = src.parseFloat64()
                case 6 => p_raw = src.parseBytesSlice()
                case 7 => if (_x[1] == PREFIXED) { let _s = subReader(src); while (!_s.isEmpty()) { s_add(scores, _s.parseInt32()) } } else { s_add(scores, src.parseInt32()) }
                case 8 => s_add(tags, src.parseString())
                case 9 => s_add(addresses, src)
                case 10 => p_primaryItem.getOrDefault(this).unpack(subReader(src))
                case 11 => s_add(items, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit { }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (p_requestId != 0) { out.append(8); out.packVarint(p_requestId) }
        if (!p_title.isEmpty()) { out.append(18); out.packBin(p_title) }
        if (p_enabled != false) { out.append(24); out.packBool(p_enabled) }
        if (p_timestamp != 0) { out.append(32); out.packVarint(p_timestamp) }
        if (p_ratio != 0) { out.append(41); out.packFixed(p_ratio) }
        if (!p_raw.isEmpty()) { out.append(50); out.packBin(p_raw) }
        if (!scores.isEmpty()) { for (_i in scores) { out.append(56); out.packVarint(_i) } }
        if (!tags.isEmpty()) { for (_i in tags) { out.append(66); out.packBin(_i) } }
        if (!addresses.isEmpty()) { for (_i in addresses) { out.append(74); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_primaryItem.nonEmptyData()) { out.append(82); out.packVarint(_v.size); _v.pack(out) }
        if (!items.isEmpty()) { for (_i in items) { out.append(90); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_requestId != 0) { _x.append("requestId", p_requestId) }
        if (!p_title.isEmpty()) { _x.append("title", p_title) }
        if (p_enabled != false) { _x.append("enabled", p_enabled) }
        if (p_timestamp != 0) { _x.append("timestamp", p_timestamp) }
        if (p_ratio != 0) { _x.append("ratio", p_ratio) }
        if (!p_raw.isEmpty()) { _x.append("raw", p_raw) }
        if (!scores.isEmpty()) { _x.append("scores", scores) }
        if (!tags.isEmpty()) { _x.append("tags", tags) }
        if (!addresses.isEmpty()) { _x.append("addresses", addresses) }
        if (let Some(_v) <- p_primaryItem.nonEmptyData()) { _x.append("primaryItem", _v) }
        if (!items.isEmpty()) { _x.append("items", items) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { CjRequest() }
    public static func fromBytes(src: Collection<Byte>) { let _x = CjRequest(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = CjRequest(); _x.unpack(src); _x }
}

public class JsReply <: MessageLite & TypedMessage<JsReply> {
    private var p_status: String
    public let items: RepeatedMessage<Item>
    private var p_defaultAddress: PbMessage<Address>
    public let payloads: RepeatedField<BytesSlice>
    private var p_average: Float32

    public init(
        status!: String = "",
        items!: Array<Item> = [],
        defaultAddress!: ?Address = None,
        payloads!: Array<Bytes> = [],
        average!: Float32 = 0
    ) {
        this.p_status = status
        this.items = RepeatedMessage<Item>(items)
        this.p_defaultAddress = PbMessage<Address>(defaultAddress)
        this.payloads = RepeatedField<BytesSlice>(payloads.size) { _i => BytesSlice(payloads[_i]) }
        this.p_average = average
        m_init()
    }

    private func m_init() {
        m_init(items)
        if (let Some(_v) <- p_defaultAddress.data) { m_init(_v) }
        m_init(payloads)
        m_innerInit()
    }

    public mut prop status: String { get() { p_status } set(_x) { p_status = _x; markDirty() } }
    public mut prop defaultAddress: Address { get() { p_defaultAddress.getOrDefault(this) } set(_v) { p_defaultAddress.set(this, _v); markDirty() } }
    public mut prop average: Float32 { get() { p_average } set(_x) { p_average = _x; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_status.isEmpty()) { _x += 1 + binSize(p_status) }
        if (!items.isEmpty()) { for (_i in items) { _x += 1 + binSize(_i) } }
        if (let Some(_v) <- p_defaultAddress.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (!payloads.isEmpty()) { for (_i in payloads) { _x += 1 + binSize(_i) } }
        if (p_average != 0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_status.isEmpty()) { _x.write(p_status.hashCode()) }
        if (!items.isEmpty()) { _x.write(items.hashCode()) }
        if (let Some(_v) <- p_defaultAddress.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (!payloads.isEmpty()) { _x.write(payloads.hashCode()) }
        if (p_average != 0) { _x.write(p_average) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_status.isEmpty() && items.isEmpty() && isNone(p_defaultAddress.nonEmptyData()) &&
        payloads.isEmpty() && p_average == 0
    }

    protected func m_clear(): Unit {
        p_status = ""
        items.clear()
        p_defaultAddress.removeFrom(this)
        payloads.clear()
        p_average = 0
    }

    public operator func !=(src: JsReply): Bool { !(this == src) }
    public operator func ==(src: JsReply): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_status == src.p_status && items == src.items && p_defaultAddress.data == src.p_defaultAddress.data &&
        payloads == src.payloads && p_average == src.p_average
    }

    public func mergeFrom(src: JsReply): Unit {
        if (!src.p_status.isEmpty()) { p_status = src.p_status }
        if (!src.items.isEmpty()) { items.appendAll(src.items) }
        if (let Some(_v) <- src.p_defaultAddress.nonEmptyData()) { p_defaultAddress.getOrDefault(this).mergeFrom(_v) }
        if (!src.payloads.isEmpty()) { payloads.appendAll(src.payloads) }
        if (src.p_average != 0) { p_average = src.p_average }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: JsReply): JsReply {
        p_status = src.p_status
        items.copyFrom(src.items)
        p_defaultAddress.copyFrom(this, src.p_defaultAddress.data)
        payloads.copyFrom(src.payloads)
        p_average = src.p_average
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): JsReply {
        return JsReply().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_status = src.parseString()
                case 2 => s_add(items, src)
                case 3 => p_defaultAddress.getOrDefault(this).unpack(subReader(src))
                case 4 => s_add(payloads, src.parseBytesSlice())
                case 5 => p_average = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func check(): Unit { }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        check()
        if (!p_status.isEmpty()) { out.append(10); out.packBin(p_status) }
        if (!items.isEmpty()) { for (_i in items) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (let Some(_v) <- p_defaultAddress.nonEmptyData()) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        if (!payloads.isEmpty()) { for (_i in payloads) { out.append(34); out.packBin(_i) } }
        if (p_average != 0) { out.append(45); out.packFixed(p_average) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_status.isEmpty()) { _x.append("status", p_status) }
        if (!items.isEmpty()) { _x.append("items", items) }
        if (let Some(_v) <- p_defaultAddress.nonEmptyData()) { _x.append("defaultAddress", _v) }
        if (!payloads.isEmpty()) { _x.append("payloads", payloads) }
        if (p_average != 0) { _x.append("average", p_average) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { JsReply() }
    public static func fromBytes(src: Collection<Byte>) { let _x = JsReply(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = JsReply(); _x.unpack(src); _x }
}

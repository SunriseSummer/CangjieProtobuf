/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

/* abstract class of all the protobuf message. */
public abstract class MessageLite <: ToString & Hashable {
    var m_parents = Parents()

    private var m_cachedSize = -1
    private var m_cachedHash = -1
    public func markDirty(): Unit {
        if (m_cachedSize != -1 || m_cachedHash != -1) {   /* any cached */
            m_cachedSize = -1
            m_cachedHash = -1

            m_parents.markDirty()
        }
    }

    /* message packed size */
    protected func m_size(): Int64
    public prop size: Int64 { get() {
        if (m_cachedSize == -1) {
            var sum = m_size()
            for (u in unknownFields.getRawData()) {
                sum += u.packSize()
            }

            m_cachedSize = sum
        }

        return m_cachedSize
    } }

    /* message hashCode, return `0` if isEmpty */
    protected func m_hashCode(): Int64
    public func hashCode(): Int64 {
        if (m_cachedHash == -1) {
            if (m_cachedSize == 0) {
                m_cachedHash = 0
                return 0
            }

            var hasher = DefaultHasher(res: m_hashCode())
            if (!unknownFields.isEmpty()) {
                hasher.write(unknownFields.hashCode())
            }
            m_cachedHash = match (hasher.finish()) {
                case -0x8000_0000_0000_0000 => 0x7fff_ffff_ffff_ffff
                case h where h < 0 => -h
                case h => h
            }
        }

        return m_cachedHash
    }

    /* message is empty */
    protected func m_isEmpty(): Bool
    public func isEmpty(): Bool {
        if (m_cachedSize == 0) {
            return true
        }

        if (m_cachedSize == -1 && m_isEmpty() && unknownFields.isEmpty()) {
            m_cachedSize = 0
            return true
        }

        return false
    }

    /* message clear */
    protected func m_clear(): Unit
    @Frozen
    public func clear() {
        if (m_cachedSize == 0) {
            return
        }

        m_clear()
        unknownFields.getRawData().clear()
        m_cachedSize = 0
        m_cachedHash = 0
        m_parents.markDirty()
        return
    }

    /* copy inner data from `src` */
    protected func m_innerCopyFrom(src: MessageLite) {
        unknownFields.copyFrom(src.unknownFields)
        m_cachedSize = src.m_cachedSize
        m_cachedHash = src.m_cachedHash
        m_parents.markDirty()
    }

    /* inner init, init after all member variable inited */
    protected func m_innerInit() {
        unknownFields.setParent(this)
    }

    /* unpack from bytes reader interface */
    public func unpacki(src: BytesReader): Unit

    /* pack to bytes writer interface */
    public func packi(out: BytesWriter): Unit

    /* unpack from collection. */
    public func unpack(src: Collection<Byte>): Unit { unpacki(SimpleReader(src)) }

    /* unpack from bytes slice */
    public func unpack(src: BytesSlice): Unit { unpacki(SimpleReader(src)) }

    /* pack message to bytes */
    public func pack(): Bytes {
        let out = SimpleWriter(size)
        packi(out)

        return out.data
    }

    /* pack message to bytes */
    public func pack(out: Bytes): Unit {
        if (size > out.size) {
            throw InsufficientSpaceException(size, out.size)
        }

        packi(SimpleWriter(out))
    }

    /* unknownFields */
    public let unknownFields = RepeatedField<MessageUnknownField>()

    /* unpack unknownFields */
    @Frozen
    protected func m_unknown<R>(src: R, tag: (Tag, WireNum)) where R <: BytesReader {
        unknownFields.appendDirty(MessageUnknownField.unpack(tag[0], tag[1], src))
    }

    /* pack unknownFields */
    @Frozen
    protected func m_unknown<W>(out: W) where W <: BytesWriter {
        for (field in unknownFields.getRawData()) { field.pack(out) }
    }

    /* unpack to repeated fields */
    @Frozen
    protected static func s_add<T>(fields: RepeatedField<T>, val: T) { fields.appendDirty(val) }
    @Frozen
    protected static func s_add<T, R>(fields: RepeatedMessage<T>, src: R) where T <: MessageLite & TypedMessage<T>, R <: BytesReader { fields.appendDirty(T.fromBytes(subReader(src))) }
    @Frozen
    protected static func s_add<K, V>(map: MapField<K, V>, key: K, val: V) where K <: Hashable & Equatable<K> { map.putDirty(key, val) }
    @Frozen
    protected static func s_add<K, M>(map: MapMessage<K, M>, key: K, val: M) where K <: Hashable & Equatable<K>, M <: MessageLite & TypedMessage<M> { map.putDirty(key, val) }

    /* @Deprecated */
    @Frozen
    protected static func s_add<R>(fields: RepeatedString, src: R) where R <: BytesReader { fields.appendDirty(src.parseString()) }

    /* @Deprecated */
    /* pack repeated string */
    protected static func s_pack<W>(tag: Tag, fields: RepeatedString, out: W) where W <: BytesWriter {
        if (fields.isEmpty()) { return }

        let app: UInt8 = if (tag <= 15) { UInt8(tag) << 3 | PREFIXED } else { 0 }

        for (s in fields.getRawData()) {
            if (app > 0) { out.append(app) } else { out.packTag(tag, PREFIXED) }
            out.packBin(s)
        }
    }

    /* @Deprecated */
    /* packed size of fields */
    protected static func s_size(rf: RepeatedString, tagSize: Int64) {
        var sum = tagSize * rf.size

        for (bs in rf.getRawData()) {
            sum += binSize(bs)
        }

        return sum
    }

    /* init member field's parent */
    protected func m_init(rf: MessageLite) { rf.m_parents.insert(this) }
    protected func m_init<T>(rf: RepeatedField<T>) { rf.setParent(this) }
    protected func m_init<T>(rf: RepeatedMessage<T>) where T <: MessageLite & TypedMessage<T> { rf.setParent(this) }
    protected func m_init<T>(rf: T): T where T <: OneofGroup { rf.mutableData()?.m_parents.insert(this); rf }
    protected func m_init<K, V>(rf: MapField<K, V>) where K <: Hashable & Equatable<K> { rf.setParent(this) }
    protected func m_init<K, V>(rf: MapMessage<K, V>) where K <: Hashable & Equatable<K>, V <: MessageLite & TypedMessage<V> { rf.setParent(this) }

    /* assign member old to new, reset their parent */
    protected func m_assign(old: MessageLite, new: MessageLite) { old.m_parents.remove(this); new.m_parents.insert(this) }
    protected func m_assign(old: MessageLite) { old.m_parents.remove(this) }
    protected func m_assign(old: OneofGroup, new: OneofGroup) { old.mutableData()?.m_parents.remove(this); new.mutableData()?.m_parents.insert(this) }
    protected func m_assign(old: OneofGroup, new: MessageLite) { old.mutableData()?.m_parents.remove(this); new.m_parents.insert(this) }
    protected func m_assign(old: OneofGroup) { old.mutableData()?.m_parents.remove(this) }
}

/* proto2 optional message */
public struct PbMessage<M> where M <: MessageLite & TypedMessage<M> {
    public PbMessage(public var data: ?M) { }

    public mut func set(parent: MessageLite, that: M): Unit {
        if (let Some(m) <- data) {
            let am: MessageLite = m
            am.m_parents.remove(parent)
        }

        let am: MessageLite = that
        am.m_parents.insert(parent)
        data = that
    }

    public mut func getOrDefault(parent: MessageLite): M {
        if (let Some(m) <- data) {
            return m
        }

        let m = M.empty()
        let am: MessageLite = m
        am.m_parents.insert(parent)
        data = m
        return m
    }

    public mut func removeFrom(parent: MessageLite): Unit {
        if (let Some(m) <- data) {
            let am: MessageLite = m
            am.m_parents.remove(parent)
            data = None
        }
    }

    public mut func copyFrom(parent: MessageLite, that: ?M): Unit {
        match (that) {
            case Some(m) => getOrDefault(parent).copyFrom(m)
            case _ => removeFrom(parent)
        }
    }

    public func isEmpty(): Bool { return data?.isEmpty() ?? true }
    public func nonEmptyData(): ?M { match (data) { case Some(m) where !m.isEmpty() => m case _ => None } }
    /* @Deprecated */
    public func noEmptyData(): ?M { match (data) { case Some(m) where !m.isEmpty() => m case _ => None } }
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

public class RepeatedField<T> <: Collection<T> {
    private var parent: ?MessageLite
    private var data: ArrayList<T>

    @Frozen
    public init() {
        parent = None
        data = ArrayList()
    }

    @Frozen
    public init(capacity: Int64) {
        parent = None
        data = ArrayList(capacity)
    }

    @Frozen
    public init(size: Int64, initElement: (Int64) -> T) {
        parent = None
        data = ArrayList(size, initElement)
    }

    @Frozen
    public init(elements: Array<T>) {
        parent = None
        data = ArrayList(elements)
    }

    @Frozen
    public init(elements: Collection<T>) {
        parent = None
        data = ArrayList(elements)
    }

    public func get(index: Int64): ?T {
        data.get(index)
    }

    public func set(index: Int64, element: T): Unit {
        data[index] = element
        parent?.markDirty()
    }

    public func append(element: T): Unit {
        data.add(element)
        parent?.markDirty()
    }

    public func appendAll(elements: Collection<T>): Unit {
        data.add(all: elements)
        parent?.markDirty()
    }

    public func insert(index: Int64, element: T): Unit {
        data.add(element, at: index)
        parent?.markDirty()
    }

    public func insertAll(index: Int64, elements: Collection<T>): Unit {
        data.add(all: elements, at: index)
        parent?.markDirty()
    }

    public func prepend(element: T): Unit {
        data.add(element)
        parent?.markDirty()
    }

    public func prependAll(elements: Collection<T>): Unit {
        data.add(all: elements, at: 0)
        parent?.markDirty()
    }

    public func remove(index: Int64): T {
        parent?.markDirty()
        data.remove(at: index)
    }

    public func remove(range: Range<Int64>): Unit {
        data.remove(range)
        parent?.markDirty()
    }

    public func removeIf(predicate: (T) -> Bool): Unit {
        data.removeIf(predicate)
        parent?.markDirty()
    }

    public func clear(): Unit {
        data.clear()
        parent?.markDirty()
    }

    public func copyFrom(rf: RepeatedField<T>): Unit {
        data = rf.data.clone()
        parent?.markDirty()
    }

    public func moveFrom(rf: RepeatedField<T>): Unit {
        let temp = rf.data
        rf.data = data
        rf.clear()

        data = temp
        parent?.markDirty()
    }

    public func swap(rf: RepeatedField<T>): Unit {
        let temp = rf.data
        rf.data = data
        rf.parent?.markDirty()

        data = temp
        parent?.markDirty()
    }

    public func reverse(): Unit { data.reverse() }
    public func sortBy(comparator: (T, T) -> Ordering, stable!: Bool = false): Unit { data.sortBy(stable: stable, comparator: comparator) }
    public func reserve(additional: Int64): Unit { data.reserve(additional) }
    public func toArray(): Array<T> { data.toArray() }
    public func capacity(): Int64 { data.capacity }
    @Frozen
    public func iterator(): Iterator<T> { data.iterator() }
    public prop size: Int64 { get() { data.size } }
    public func isEmpty(): Bool { data.isEmpty() }
    public func toArrayList(): ArrayList<T> { data.clone() }
    public operator func [](index: Int64): T { data[index] }
    public operator func [](index: Int64, value!: T): Unit { data[index] = value; parent?.markDirty() }

    @Frozen
    func appendDirty(element: T): Unit { data.add(element) }
    func setParent(parent: MessageLite): Unit { this.parent = parent }
    func getRawData() { data }
}

extend<T> RepeatedField<T> <: ToString where T <: ToString {
    public func toString(): String {
        let raw = getRawData()
        if (raw.isEmpty() || !(raw[0] is String)) {
            return raw.toString()
        }

        let buffer = StringBuilder("[")
        var sep = false
        for (s in this) {
            if (sep) { buffer.append(", ") } else { sep = true }
            buffer.append("\"${s}\"")
        }

        buffer.append(']')
        return buffer.toString()
    }
}

extend<T> RepeatedField<T> <: Hashable where T <: Hashable {
    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        for (v in getRawData()) {
            hasher.write(v.hashCode())
        }
        return hasher.finish()
    }
}

extend<T> RepeatedField<T> <: Equatable<RepeatedField<T>> where T <: Equatable<T> {
    public operator func ==(that: RepeatedField<T>): Bool {
        getRawData() == that.getRawData()
    }

    public operator func !=(that: RepeatedField<T>): Bool {
        getRawData() != that.getRawData()
    }

    public func contains(element: T): Bool {
        getRawData().contains(element)
    }
}

extend<T> RepeatedField<T> <: Equatable<ArrayList<T>> where T <: Equatable<T> {
    public operator func ==(that: ArrayList<T>): Bool {
        getRawData() == that
    }

    public operator func !=(that: ArrayList<T>): Bool {
        getRawData() != that
    }
}

extend RepeatedField<BytesSlice> <: Equatable<Bytes> {
    public operator func ==(that: Bytes): Bool {
        for (s in getRawData() where s != that) {
            return false
        }

        return true
    }

    public operator func !=(that: Bytes): Bool {
        !(this == that)
    }
}

public class RepeatedMessage<T> <: Collection<T> & ToString & Hashable where T <: MessageLite & TypedMessage<T> {
    private var parent: ?MessageLite
    private var data: ArrayList<T>

    @Frozen
    public init() {
        parent = None
        data = ArrayList()
    }

    @Frozen
    public init(capacity: Int64) {
        parent = None
        data = ArrayList(capacity)
    }

    @Frozen
    public init(size: Int64, initElement: (Int64) -> T) {
        parent = None
        data = ArrayList(size, initElement)
    }

    @Frozen
    public init(elements: Array<T>) {
        parent = None
        data = ArrayList(elements)
    }

    @Frozen
    public init(elements: Collection<T>) {
        parent = None
        data = ArrayList(elements)
    }

    public func get(index: Int64): ?T {
        data.get(index)
    }

    public func set(index: Int64, element: T): Unit {
        unlink(this[index])
        data[index] = element
        parent?.markDirty()
        link(element)
    }

    public func add(): T {
        let m = T.empty()
        append(m)
        m
    }

    public func append(element: T): Unit {
        data.add(element)
        parent?.markDirty()
        link(element)
    }

    public func appendAll(elements: Collection<T>): Unit {
        data.add(all: elements)
        parent?.markDirty()
        link(elements)
    }

    public func insert(index: Int64, element: T): Unit {
        data.add(element, at: index)
        parent?.markDirty()
        link(element)
    }

    public func insertAll(index: Int64, elements: Collection<T>): Unit {
        data.add(all: elements, at: index)
        parent?.markDirty()
        link(elements)
    }

    public func prepend(element: T): Unit {
        data.add(element)
        parent?.markDirty()
        link(element)
    }

    public func prependAll(elements: Collection<T>): Unit {
        data.add(all: elements, at: 0)
        parent?.markDirty()
        link(elements)
    }

    public func remove(index: Int64): T {
        unlink(data[index])
        parent?.markDirty()
        data.remove(at: index)
    }

    public func remove(range: Range<Int64>): Unit {
        unlink(data[range])
        data.remove(range)
        parent?.markDirty()
    }

    public func removeIf(predicate: (T) -> Bool): Unit {
        data.removeIf { e =>
            if (predicate(e)) { unlink(e); true } else { false }
        }
        parent?.markDirty()
    }

    @Frozen
    public func clear(): Unit {
        unlink(data)
        data.clear()
        parent?.markDirty()
    }

    public func copyFrom(rf: RepeatedMessage<T>): Unit {
        unlink(data)
        data.clear()
        for (m in rf.data) {
            let c = m.clone()
            data.add(c)
            link(c)
        }
        parent?.markDirty()
    }

    public func moveFrom(rf: RepeatedMessage<T>): Unit {
        let temp = rf.data
        rf.unlink(rf.data)
        rf.data = ArrayList()
        rf.parent?.markDirty()

        unlink(data)
        link(temp)
        data = temp
        parent?.markDirty()
    }

    public func swap(rf: RepeatedMessage<T>): Unit {
        let temp = rf.data
        rf.unlink(temp)
        rf.link(data)
        rf.data = data
        rf.parent?.markDirty()

        unlink(data)
        link(temp)
        data = temp
        parent?.markDirty()
    }

    private func link(element: MessageLite) { element.m_parents.insert(parent ?? return) }
    private func unlink(element: MessageLite) { element.m_parents.remove(parent ?? return) }

    private func link(elements: Collection<T>) {
        let m = parent ?? return ()
        for (e in elements) { let ee: MessageLite = e; ee.m_parents.insert(m) }
    }

    @Frozen
    private func unlink(elements: Collection<T>) {
        let m = parent ?? return ()
        for (e in elements) { let ee: MessageLite = e; ee.m_parents.remove(m) }
    }
    @Frozen
    private func unlink(elements: ArrayList<T>) {
        let m = parent ?? return ()
        for (e in elements) { let ee: MessageLite = e; ee.m_parents.remove(m) }
    }

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        for (m in data) {
            hasher.write(m.hashCode())
        }
        return hasher.finish()
    }

    public func reverse(): Unit { data.reverse() }
    public func sortBy(comparator: (T, T) -> Ordering, stable!: Bool = false): Unit { data.sortBy(stable: stable, comparator: comparator) }
    public func reserve(additional: Int64): Unit { data.reserve(additional) }
    public func toArray(): Array<T> { data.toArray() }
    public func capacity(): Int64 { data.capacity }
    @Frozen
    public func iterator(): Iterator<T> { data.iterator() }
    public prop size: Int64 { get() { data.size } }
    public func isEmpty(): Bool { data.isEmpty() }
    public func toArrayList(): ArrayList<T> { data.clone() }
    public func toString(): String { data.toString() }
    public operator func [](index: Int64): T { data[index] }
    public operator func [](index: Int64, value!: T): Unit { data[index] = value; parent?.markDirty(); link(value) }

    public operator func ==(that: RepeatedMessage<T>): Bool { data == that.data }
    public operator func !=(that: RepeatedMessage<T>): Bool { data != that.data }

    @Frozen
    func appendDirty(element: T): Unit { data.add(element); link(element) }
    func setParent(parent: MessageLite): Unit { this.parent = parent }
}

/* @Deprecated */
public type RepeatedString = RepeatedField<String>

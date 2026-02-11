/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

public class MapField<K, V> <: Map<K, V> where K <: Hashable & Equatable<K> {
    private var parent: ?MessageLite
    private var data: HashMap<K, V>

    public init() {
        parent = None
        data = HashMap()
    }

    public init(capacity: Int64) {
        parent = None
        data = HashMap(capacity)
    }

    public init(size: Int64, initElement: (Int64) -> (K, V)) {
        parent = None
        data = HashMap(size, initElement)
    }

    public init(elements: Array<(K, V)>) {
        parent = None
        data = HashMap(elements)
    }

    public init(elements: Collection<(K, V)>) {
        parent = None
        data = HashMap(elements)
    }

    public func get(key: K): ?V {
        data.get(key)
    }

    public operator func [](key: K): V {
        data[key]
    }

    public func contains(key: K): Bool {
        data.contains(key)
    }

    public func containsAll(all: Collection<K>): Bool {contains(all:all)}
    public func contains(all!: Collection<K>): Bool {
        data.contains(all: all)
    }

    public func entryView(key: K): MapEntryView<K, V> {
        data.entryView(key)
    }

    public operator func [](key: K, value!: V): Unit {
        data[key] = value
        parent?.markDirty()
    }

    public func put(key: K, value: V): ?V {
        add(key, value)
    }
    public func add(key: K, value: V): ?V {
        parent?.markDirty()
        data.add(key, value)
    }

    public func putAll(elements: Collection<(K, V)>): Unit {
        add(all: elements)
    }
    public func add(all!: Collection<(K, V)>): Unit {
        data.add(all: all)
        parent?.markDirty()
    }

    public func remove(key: K): Option<V> {
        parent?.markDirty()
        data.remove(key)
    }

    public func removeAll(all: Collection<K>): Unit {remove(all:all)}
    public func remove(all!: Collection<K>): Unit {
        data.remove(all: all)
        parent?.markDirty()
    }

    public func removeIf(predicate: (K, V) -> Bool): Unit {
        data.removeIf(predicate)
        parent?.markDirty()
    }

    public func clear(): Unit {
        data.clear()
        parent?.markDirty()
    }

    public func copyFrom(rf: MapField<K, V>): Unit {
        data = rf.data.clone()
        parent?.markDirty()
    }

    public func moveFrom(rf: MapField<K, V>): Unit {
        let temp = rf.data
        rf.data = data
        rf.clear()

        data = temp
        parent?.markDirty()
    }

    public func swap(rf: MapField<K, V>): Unit {
        let temp = rf.data
        rf.data = data
        rf.parent?.markDirty()

        data = temp
        parent?.markDirty()
    }

    public func reserve(additional: Int64): Unit { data.reserve(additional) }
    public func capacity(): Int64 { data.capacity }
    public func clone(): MapField<K, V> { MapField(this) }
    public func toHashMap(): HashMap<K, V> { data.clone() }
    public func keys(): EquatableCollection<K> { data.keys() }
    public func values(): Collection<V> { data.values() }
    public func iterator(): HashMapIterator<K, V> { data.iterator() }
    public prop size: Int64 { get() { data.size } }
    public func isEmpty(): Bool { data.isEmpty() }

    public func putDirty(key: K, value: V): Unit { data[key] = value }
    func setParent(parent: MessageLite): Unit { this.parent = parent }
    public func getRawData() { data }
}

extend<K, V> MapField<K, V> <: ToString where V <: ToString, K <: ToString & Hashable & Equatable<K> {
    public func toString(): String {
        var res = StructPrinter()
        for ((k, v) in getRawData()) {
            let key = match(k) {
                case k: String where k.contains(" ") => "\"${k}\""
                case _ => k.toString()
            }
            match (v) {
                case v: String => res.append(key, v)
                case _ => res.append(key, v)
            }
        }
        res.done().toString()
    }
}

extend<K, V> MapField<K, V> <: Hashable where V <: Hashable {
    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        for ((k,v) in getRawData()) {
            hasher.write(k.hashCode())
            hasher.write(v.hashCode())
        }
        return hasher.finish()
    }
}

extend<K, V> MapField<K, V> <: Equatable<MapField<K, V>> where V <: Equatable<V> {
    public operator func ==(that: MapField<K, V>): Bool {
        getRawData() == that.getRawData()
    }

    public operator func !=(that: MapField<K, V>): Bool {
        getRawData() != that.getRawData()
    }
}

extend<K, V> MapField<K, V> <: Equatable<HashMap<K, V>> where V <: Equatable<V> {
    public operator func ==(that: HashMap<K, V>): Bool {
        getRawData() == that
    }

    public operator func !=(that: HashMap<K, V>): Bool {
        getRawData() != that
    }
}

public class MapMessage<K, V> <: Map<K, V> where K <: Hashable & Equatable<K>, V <: MessageLite & TypedMessage<V> {
    private var parent: ?MessageLite
    private var data: HashMap<K, V>

    public init() {
        parent = None
        data = HashMap()
    }

    public init(capacity: Int64) {
        parent = None
        data = HashMap(capacity)
    }

    public init(size: Int64, initElement: (Int64) -> (K, V)) {
        parent = None
        data = HashMap(size, initElement)
    }

    public init(elements: Array<(K, V)>) {
        parent = None
        data = HashMap(elements)
    }

    public init(elements: Collection<(K, V)>) {
        parent = None
        data = HashMap(elements)
    }

    public func get(key: K): ?V {
        data.get(key)
    }

    public operator func [](key: K): V {
        data[key]
    }

    public func contains(key: K): Bool {
        data.contains(key)
    }

    public func containsAll(all: Collection<K>): Bool {contains(all:all)}
    public func contains(all!: Collection<K>): Bool {
        data.contains(all: all)
    }

    public func entryView(key: K): MapEntryView<K, V> {
        data.entryView(key)
    }

    public operator func [](key: K, value!: V): Unit {
        add(key, value)
    }

    public func put(key: K, value: V): ?V {add(key,value)}
    public func add(key: K, value: V): ?V {
        let old = data.add(key, value)
        if (let Some(m) <- old) { unlink(m) }

        parent?.markDirty()
        link(value)
        return old
    }

    public func putAll(all: Collection<(K, V)>): Unit {add(all:all)}
    public func add(all!: Collection<(K, V)>): Unit {
        for ((k, v) in all) {
            if (let Some(m) <- data.add(k, v)) {
                unlink(m)
            }

            link(v)
        }

        parent?.markDirty()
    }

    public func remove(key: K): Option<V> {
        if (let Some(m) <- data.remove(key)) {
            parent?.markDirty()
            unlink(m)
            return m
        }

        return None
    }

    public func removeAll(all: Collection<K>): Unit {remove(all:all)}
    public func remove(all!: Collection<K>): Unit {
        for (key in all) {
            if (let Some(m) <- data.remove(key)) {
                unlink(m)
            }
        }

        parent?.markDirty()
    }

    public func removeIf(predicate: (K, V) -> Bool): Unit {
        data.removeIf { k, v =>
            if (predicate(k, v)) {
                unlink(v)
                return true
            }

            return false
        }

        parent?.markDirty()
    }

    public func clear(): Unit {
        unlink(data.values())
        data.clear()
        parent?.markDirty()
    }

    public func copyFrom(rf: MapMessage<K, V>): Unit {
        unlink(data.values())
        data.clear()

        for ((k, v) in rf.data) {
            let m = v.clone()
            data[k] = m
            link(m)
        }

        parent?.markDirty()
    }

    public func clone(): MapMessage<K, V> {
        let new = MapMessage<K, V>(data.size)
        for ((k, v) in data) {
            data[k] = v.clone()
        }

        return new
    }

    public func moveFrom(rf: MapMessage<K, V>): Unit {
        let temp = rf.data
        rf.unlink(rf.data.values())
        rf.data = HashMap()
        rf.parent?.markDirty()

        unlink(data.values())
        link(rf.data.values())
        data = temp
        parent?.markDirty()
    }

    public func swap(rf: MapMessage<K, V>): Unit {
        let temp = rf.data
        rf.unlink(temp.values())
        rf.link(data.values())
        rf.data = data
        rf.parent?.markDirty()

        unlink(data.values())
        link(temp.values())
        data = temp
        parent?.markDirty()
    }

    private func link(element: MessageLite) { element.m_parents.insert(parent ?? return) }
    private func unlink(element: MessageLite) { element.m_parents.remove(parent ?? return) }

    private func link(elements: Collection<V>) {
        let m = parent ?? return ()
        for (e in elements) { let ee: MessageLite = e; ee.m_parents.insert(m) }
    }

    private func unlink(elements: Collection<V>) {
        let m = parent ?? return ()
        for (e in elements) { let ee: MessageLite = e; ee.m_parents.remove(m) }
    }

    public func reserve(additional: Int64): Unit { data.reserve(additional) }
    public func capacity(): Int64 { data.capacity }
    public func toHashMap(): HashMap<K, V> { data.clone() }
    public func keys(): EquatableCollection<K> { data.keys() }
    public func values(): Collection<V> { data.values() }
    public func iterator(): HashMapIterator<K, V> { data.iterator() }
    public prop size: Int64 { get() { data.size } }
    public func isEmpty(): Bool { data.isEmpty() }

    public operator func ==(that: MapMessage<K, V>): Bool { data == that.data }
    public operator func !=(that: MapMessage<K, V>): Bool { data != that.data }

    public func putDirty(key: K, value: V): Unit { if (let Some(m) <- data.add(key, value)) { unlink(m) }; link(value) }
    func setParent(parent: MessageLite): Unit { this.parent = parent }
    public func getRawData() { data }
}

extend<K, V> MapMessage<K, V> <: ToString where K <: ToString & Hashable & Equatable<K> {
    public func toString(): String {
        var res = StructPrinter()
        for ((k, v) in getRawData()) {
            res.append(match(k) {
                case k: String where k.contains(" ") => "\"${k}\""
                case _ => k.toString()
            }, v)
        }
        res.done().toString()
    }
}

extend<K, V> MapMessage<K, V> <: Hashable {
    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        for ((k,v) in getRawData()) {
            hasher.write(k.hashCode())
            hasher.write(v.hashCode())
        }
        return hasher.finish()
    }
}
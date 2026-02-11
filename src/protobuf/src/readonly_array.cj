/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package protobuf

/* read only array */
public struct RoArray<T> {
    /* raw data of ro-array */
    let data: Array<T>

    public init() {
        data = Array()
    }

    public init(size: Int64, item!: T) {
        data = Array(size, repeat: item)
    }

    /* constuct ro-array from the copy of collection */
    public init(data: Collection<T>) {
        this.data = data.toArray()
    }

    public init(size: Int64, initElement: (Int64) -> T) {
        data = Array(size, initElement)
    }

    /* [Private] constuct ro-array from array reference. */
    private init(data: Array<T>) {
        this.data = data
    }

    /* [unsafe] constuct ro-array from an array reference that will not be modified. */
    public unsafe static func move(data: Array<T>) {
        RoArray<T>(data)
    }

    /* [unsafe] get the raw array of this ro-array */
    public unsafe func getRawArray() {
        data
    }

    @Frozen
    public func get(index: Int64) {
        data.get(index)
    }

    /**
     * @throws IndexOutOfBoundsException if `index` is negative or
     *         greater than or equal to the size of array.
     */
    @Frozen
    public operator func [](index: Int64) {
        data[index]
    }

    @Frozen
    public operator func [](range: Range<Int64>) {
        RoArray(data[range])
    }

    @Frozen
    public func slice(start: Int64, len: Int64) {
        RoArray(data.slice(start, len))
    }

    @Frozen
    public func copyTo(dst: Array<T>, dstStart: Int64) {
        data.copyTo(dst, 0, dstStart, data.size)
    }

    @Frozen
    public func clone(): RoArray<T> {
        RoArray(data.clone())
    }
}

extend<T> RoArray<T> <: Collection<T> {
    /** Returns an iterator over the elements in this Array in proper sequence. */
    @Frozen
    public func iterator(): Iterator<T> {
        data.iterator()
    }

    /**
     * Call 'size' on array type variable will be processed by compiler.
     * Only call based on 'Collection' type will use this function.
     */
    @Frozen
    public prop size: Int64 {
        get() {
            data.size
        }
    }

    /** Returns true if this Array contains no elements. */
    @Frozen
    public func isEmpty(): Bool {
        data.isEmpty()
    }

    @Frozen
    public func toArray(): Array<T> {
        data.toArray()
    }
}

extend<T> RoArray<T> <: ToString where T <: ToString {
    @Frozen
    public func toString(): String {
        data.toString()
    }
}

extend RoArray<Byte> <: Hashable {
    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        for (v in data) {
            hasher.write(v)
        }
        return hasher.finish()
    }
}

extend<T> RoArray<T> <: Equatable<RoArray<T>> where T <: Equatable<T> {
    @Frozen
    public operator func ==(that: RoArray<T>): Bool {
        this.data == that.data
    }

    @Frozen
    public operator func !=(that: RoArray<T>): Bool {
        this.data != that.data
    }

    @Frozen
    public func contains(element: T): Bool {
        data.contains(element)
    }
}

extend<T> RoArray<T> <: Equatable<Array<T>> where T <: Equatable<T> {
    @Frozen
    public operator func ==(that: Array<T>): Bool {
        this.data == that
    }

    @Frozen
    public operator func !=(that: Array<T>): Bool {
        this.data != that
    }
}

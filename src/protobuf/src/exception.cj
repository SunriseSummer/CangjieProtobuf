/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file about: define protobuf exception.
 */
package protobuf

/**
 * The class is ProtobufException inherited from Exception
 * @author tutudo
 * @since 0.29.3
 */
public abstract class ProtobufException <: Exception {}

/**
 * The class is InvalidEnumValueException inherited from ProtobufException
 * @author tutudo
 * @since 0.29.3
 */
public class InvalidEnumValueException <: ProtobufException {
    public InvalidEnumValueException (public let name: String, public let value: Int32) {}

    public prop message: String {
        get() { "The value `${value}` is illegal for the enum type `${name}`" }
    }
}

/**
 * The class is UnmatchedEnumStringException inherited from ProtobufException
 * @author tutudo
 * @since 0.29.3
 */
public class UnmatchedEnumStringException <: ProtobufException {
    public UnmatchedEnumStringException (public let name: String, public let value: String) {}

    public prop message: String {
        get() { "Enum type `${name}` match `${value}` failed." }
    }
}

/**
 * The class is RequiredFieldNotSetException inherited from ProtobufException
 * @author tutudo
 * @since 0.29.3
 */
public class RequiredFieldNotSetException <: ProtobufException {
    public RequiredFieldNotSetException(public let name: String) {}

    public prop message: String {
        get() { "The field `${name}` without a default value is required to set before serialize." }
    }
}

/**
 * The class is GetFieldValueException inherited from ProtobufException
 * @author tutudo
 * @since 0.29.3
 */
public class GetFieldValueException <: ProtobufException {
    public GetFieldValueException(public let name: String) {}

    public prop message: String {
        get() { "The failed `${name}` without a default value is not allow read before set." }
    }
}

/**
 * The class is ParseValueExecption inherited from ProtobufException
 * @author tutudo
 * @since 0.29.3
 */
public class ParseValueExecption <: ProtobufException {
    public ParseValueExecption(public let name: String, public let reason!: String = "others") {}

    public prop message: String {
        get() { "Failed to parse `${name}`. [${reason}]" }
    }
}

/* Failed to get oneof case */
public class UnexpectedOneofException <: ProtobufException { }

/* insufficient buffer space to pack message */
public class InsufficientSpaceException <: ProtobufException {
    public InsufficientSpaceException(public let exp: Int64, public let act: Int64) {}

    public prop message: String {
        get() { "message size ${exp} > buffer size ${act}" }
    }
}

class PBInternalException <: ProtobufException{
    public prop message: String {
        get() { "Protobuf Internal exception" }
    }
}
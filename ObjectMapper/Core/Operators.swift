//
//  Operators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

/**
* This file defines a new operator which is used to create a mapping between an object and a JSON key value.
* There is an overloaded operator definition for each type of object that is supported in ObjectMapper.
* This provides a way to add custom logic to handle specific types of objects
*/

infix operator <- {}

// MARK:- Objects with Basic types

/// Object of Basic type
public func <- <T, C>(inout left: T, right: Map<C>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.basicType(&left, object: right.value())
    } else {
		ToJSON.basicType(left, map: right)
    }
}

/// Optional object of basic type
public func <- <T, C>(inout left: T?, right: Map<C>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalBasicType(&left, object: right.value())
    } else {
        ToJSON.optionalBasicType(left, map: right)
    }
}

/// Implicitly unwrapped optional object of basic type
public func <- <T, C>(inout left: T!, right: Map<C>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalBasicType(&left, object: right.value())
	} else {
		ToJSON.optionalBasicType(left, map: right)
	}
}

// MARK:- Raw Representable types

/// Object of Raw Representable type
public func <- <T: RawRepresentable, C>(inout left: T, right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable, C>(inout left: T?, right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable, C>(inout left: T!, right: Map<C>) {
	left <- (right, EnumTransform())
}

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [T], right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [T]?, right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [T]!, right: Map<C>) {
	left <- (right, EnumTransform())
}

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [String: T], right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [String: T]?, right: Map<C>) {
	left <- (right, EnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable, C>(inout left: [String: T]!, right: Map<C>) {
	left <- (right, EnumTransform())
}

// MARK:- Transforms

/// Object of Basic type with Transform
public func <- <T, C, Transform: TransformType where Transform.Object == T>(inout left: T, right: (Map<C>, Transform)) {
    if right.0.mappingType == MappingType.FromJSON {
        let value: T? = right.1.transformFromJSON(right.0.currentValue)
        FromJSON.basicType(&left, object: value)
    } else {
        let value: Transform.JSON? = right.1.transformToJSON(left)
		ToJSON.optionalBasicType(value, map: right.0)
    }
}

/// Optional object of basic type with Transform
public func <- <T, C, Transform: TransformType where Transform.Object == T>(inout left: T?, right: (Map<C>, Transform)) {
    if right.0.mappingType == MappingType.FromJSON {
        let value: T? = right.1.transformFromJSON(right.0.currentValue)
        FromJSON.optionalBasicType(&left, object: value)
    } else {
        let value: Transform.JSON? = right.1.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: right.0)
    }
}

/// Implicitly unwrapped optional object of basic type with Transform
public func <- <T, C, Transform: TransformType where Transform.Object == T>(inout left: T!, right: (Map<C>, Transform)) {
	if right.0.mappingType == MappingType.FromJSON {
		let value: T? = right.1.transformFromJSON(right.0.currentValue)
		FromJSON.optionalBasicType(&left, object: value)
	} else {
		let value: Transform.JSON? = right.1.transformToJSON(left)
		ToJSON.optionalBasicType(value, map: right.0)
	}
}

/// Array of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [T.Object], right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.basicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Optional array of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [T.Object]?, right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Implicitly unwrapped optional array of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [T.Object]!, right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Dictionary of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [String: T.Object], right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.basicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Optional dictionary of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [String: T.Object]?, right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Implicitly unwrapped optional dictionary of Basic type with Transform
public func <- <T: TransformType, C>(inout left: [String: T.Object]!, right: (Map<C>, T)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

private func fromJSONArrayWithTransform<T: TransformType>(input: AnyObject?, transform: T) -> [T.Object] {
	if let values = input as? [AnyObject] {
		return values.flatMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return []
	}
}

private func fromJSONDictionaryWithTransform<T: TransformType>(input: AnyObject?, transform: T) -> [String: T.Object] {
	if let values = input as? [String: AnyObject] {
		return values.filterMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return [:]
	}
}

private func toJSONArrayWithTransform<T: TransformType>(input: [T.Object]?, transform: T) -> [T.JSON]? {
	return input?.flatMap { value in
		return transform.transformToJSON(value)
	}
}

private func toJSONDictionaryWithTransform<T: TransformType>(input: [String: T.Object]?, transform: T) -> [String: T.JSON]? {
	return input?.filterMap { value in
		return transform.transformToJSON(value)
	}
}

// MARK:- Mappable Objects - <T: Mappable>

/// Object conforming to Mappable
public func <- <T: Mappable>(inout left: T, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.object(&left, map: right)
    } else {
		ToJSON.object(left, map: right)
    }
}

/// Optional Mappable objects
public func <- <T: Mappable>(inout left: T?, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObject(&left, map: right)
    } else {
		ToJSON.optionalObject(left, map: right)
    }
}

/// Implicitly unwrapped optional Mappable objects
public func <- <T: Mappable>(inout left: T!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObject(&left, map: right)
	} else {
		ToJSON.optionalObject(left, map: right)
	}
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: Mappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.objectDictionary(&left, map: right)
    } else {
        ToJSON.objectDictionary(left, map: right)
    }
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>?, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObjectDictionary(&left, map: right)
    } else {
        ToJSON.optionalObjectDictionary(left, map: right)
    }
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionary(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionary(left, map: right)
	}
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.objectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.objectDictionaryOfArrays(left, map: right)
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>?, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	}
}

// MARK:- Array of Mappable objects - Array<T: Mappable>

/// Array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.objectArray(&left, map: right)
    } else {
		ToJSON.objectArray(left, map: right)
    }
}

/// Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>?, right: Map<T.MappingContext>) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObjectArray(&left, map: right)
    } else {
		ToJSON.optionalObjectArray(left, map: right)
    }
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalObjectArray(left, map: right)
	}
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: Mappable>>

/// Array of Array Mappable objects
public func <- <T: Mappable>(inout left: Array<Array<T>>, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.twoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.twoDimensionalObjectArray(left, map: right)
	}
}

/// Optional array of Mappable objects
public func <- <T: Mappable>(inout left:Array<Array<T>>?, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<Array<T>>!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	}
}

// MARK:- Set of Mappable objects - Set<T: Mappable where T: Hashable>

/// Array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.objectSet(&left, map: right)
	} else {
		ToJSON.objectSet(left, map: right)
	}
}


/// Optional array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>?, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectSet(&left, map: right)
	} else {
		ToJSON.optionalObjectSet(left, map: right)
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>!, right: Map<T.MappingContext>) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectSet(&left, map: right)
	} else {
		ToJSON.optionalObjectSet(left, map: right)
	}
}

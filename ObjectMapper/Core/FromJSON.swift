//
//  FromJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 hearst. All rights reserved.
//

internal final class FromJSON {
	
	/// Basic type
	class func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Implicitly unwrapped optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Mappable object
	class func object<N: Mappable>(inout field: N, map: Map<N.MappingContext>) {
		if let value: N = Mapper(mappingContext: map.mappingContext).map(map.currentValue) {
			field = value
		}
	}

	/// Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N?, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).map(map.currentValue)
	}

	/// Implicitly unwrapped Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N!, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).map(map.currentValue)
	}

	/// mappable object array
	class func objectArray<N: Mappable>(inout field: Array<N>, map: Map<N.MappingContext>) {
		if let objects = Mapper<N>(mappingContext: map.mappingContext).mapArray(map.currentValue) {
			field = objects
		}
	}

	/// optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>?, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapArray(map.currentValue)
	}

	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>!, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapArray(map.currentValue)
	}
	
	/// mappable object array
	class func twoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>, map: Map<N.MappingContext>) {
		if let objects = Mapper<N>(mappingContext: map.mappingContext).mapArrayOfArrays(map.currentValue) {
			field = objects
		}
	}
	
	/// optional mappable 2 dimentional object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>?, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapArrayOfArrays(map.currentValue)
	}
	
	/// Implicitly unwrapped optional 2 dimentional mappable object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>!, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapArrayOfArrays(map.currentValue)
	}
	
	/// Dctionary containing Mappable objects
	class func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, map: Map<N.MappingContext>) {
		let parsedObjects = Mapper<N>(mappingContext: map.mappingContext).mapDictionary(map.currentValue)

		if let objects = parsedObjects {
			field = objects
		}
	}

	/// Optional dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapDictionary(map.currentValue)
	}

	/// Implicitly unwrapped Dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapDictionary(map.currentValue)
	}
	
	/// Dictionary containing Array of Mappable objects
	class func objectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>, map: Map<N.MappingContext>) {
		let parsedObjects = Mapper<N>(mappingContext: map.mappingContext).mapDictionaryOfArrays(map.currentValue)
		
		if let objects = parsedObjects {
			field = objects
		}
	}
	
	/// Optional Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>?, map: Map<N.MappingContext>) {
		field = Mapper<N>(mappingContext: map.mappingContext).mapDictionaryOfArrays(map.currentValue)
	}
	
	/// Implicitly unwrapped Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>!, map: Map<N.MappingContext>) {
		field = Mapper<N>(mappingContext: map.mappingContext).mapDictionaryOfArrays(map.currentValue)
	}

	
	/// mappable object Set
	class func objectSet<N: Mappable>(inout field: Set<N>, map: Map<N.MappingContext>) {
		let parsedObjects = Mapper<N>(mappingContext: map.mappingContext).mapSet(map.currentValue)
		
		if let objects = parsedObjects {
			field = objects
		}
	}
	
	/// optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>?, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapSet(map.currentValue)
	}
	
	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>!, map: Map<N.MappingContext>) {
		field = Mapper(mappingContext: map.mappingContext).mapSet(map.currentValue)
	}
	
}

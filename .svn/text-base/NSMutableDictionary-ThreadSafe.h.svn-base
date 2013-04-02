//
//  NSMutableDictionary-ThreadSafe.h
//  CocoatechCore
//
//  Created by Steve Gehrman on Thu Sep 12 2002.
//  Copyright (c) 2002 CocoaTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSMutableDictionaryThreadSafeProtocol <NSObject>

- (id)safeObjectForKey:(id)aKey;

- (void)safeRemoveObjectForKey:(id)aKey;
- (void)safeRemoveObjectsForKeys:(NSArray*)keys;
- (void)safeRemoveAllObjects;
- (void)safeRemoveObject:(id)anObject;
- (void)safeRemoveObjects:(NSArray*)objects;

- (void)safeSetObject:(id)anObject
					  forKey:(id)aKey;

	// returns a copy of the array
- (NSArray*)safeAllValues;
- (NSArray*)safeAllKeys;

- (NSEnumerator*)safeKeyEnumerator;
- (NSEnumerator*)safeObjectEnumerator;

- (unsigned)safeCount;

- (NSString*)safeKeyForObjectIdenticalTo:(id)anObject;

@end

@interface NSMutableDictionary (ThreadSafe) <NSMutableDictionaryThreadSafeProtocol>
@end

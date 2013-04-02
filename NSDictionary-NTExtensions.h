//
//  NSDictionary-NTExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 9/24/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSDictionary (NTExtensions)

- (NSString*)stringForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;

- (id)keyForObjectIdenticalTo:(id)object;

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(NSString *)key;

- (int)intForKey:(NSString *)key;
- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;

- (NSMutableDictionary*)deepMutableCopy;
- (id)objectForKey:(NSString *)key defaultObject:(id)defaultObject;

@end

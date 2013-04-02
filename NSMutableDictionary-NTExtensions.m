//
//  NSMutableDictionary-NTExtensions.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 5/30/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "NSMutableDictionary-NTExtensions.h"


@implementation NSMutableDictionary (NTExtensions)

- (void)setObjectIf:(id)obj forKey:(id)key;
{
	if (obj && key)
		[self setObject:obj forKey:key];
}

- (void)setBool:(BOOL)theBool forKey:(id)key;
{
	[self setObject:[NSNumber numberWithBool:theBool] forKey:key];
}

- (BOOL)boolForKey:(id)key;
{
	return [[self objectForKey:key] boolValue];
}

- (void)setInt:(int)theInt forKey:(id)key;
{
	[self setObject:[NSNumber numberWithInt:theInt] forKey:key];
}

- (int)intForKey:(id)key;
{
	return [[self objectForKey:key] intValue];
}

- (void)setObject:(id)anObject forKeys:(NSArray *)keys;
{
    unsigned int keyCount;
	
    keyCount = [keys count];
    while (keyCount--)
		[self setObject:anObject forKey:[keys objectAtIndex:keyCount]];
}

@end

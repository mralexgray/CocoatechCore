//
//  NSNumber-NTExtensions.m
//  CocoatechCore
//
//  Created by Steve Gehrman on Thu Mar 06 2003.
//  Copyright (c) 2003 CocoaTech. All rights reserved.
//

#import "NSNumber-NTExtensions.h"

@implementation NSNumber (NTExtensions)

+ (NSNumber*)numberWithSize:(NSSize)size;
{
    int x = size.width;

    x = x<<16;
    x += size.height;

    return [NSNumber numberWithUnsignedInt:x];
}

- (NSSize)sizeNumber;
{
    NSSize size;
    int x = [self unsignedIntValue];

    size.height = x & 0x0000FFFF;
    x = x>>16;
    size.width = x;

    return size;
}

// a unique NSNumber
+ (NSNumber*)unique;
{
	static unsigned counter=1;  // protected for thread safety
	unsigned intValue;
	
	@synchronized(self) {
		intValue = counter++;
	}
	
	return [NSNumber numberWithUnsignedInt:intValue];
}

@end

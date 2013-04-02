//
//  NTSingletonObject.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 6/28/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "NTSingletonObject.h"

@implementation NTSingletonObject

// subclasses must implement to provide static storage
+ (id*)staticStorageVariable;
{
	[NSException raise:@"class must implement staticStorageVariable" format:@"%@", NSStringFromClass([self class])];
	return nil;
}

+ (id)sharedInstance;
{
	id result;

    @synchronized(self) {
		id *storageRef = [self staticStorageVariable];
		
        if ((*storageRef) == nil) {
            *storageRef = [[self alloc] init];
        }
		
		result = *storageRef;
    }
	
    return result;
}

+ (void)releaseSharedInstance;
{
	@synchronized(self) {
		
		id result = *[self staticStorageVariable];
		
        if (result != nil) {
			[result release];
			
			// set back to nil;
			result = nil;
        }
	}
}

+ (id)allocWithZone:(NSZone *)zone
{
	id result;
	
    @synchronized(self) {
		result = *[self staticStorageVariable];

        if (result == nil) {
            return [super allocWithZone:zone];
        }
    }
	
    return result;
}

- (id)copyWithZone:(NSZone *)zone
{
	// copy expects a retained id
    return [self retain];
}

@end


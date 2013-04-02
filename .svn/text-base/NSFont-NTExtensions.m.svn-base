//
//  NSFont-NTExtensions.m
//  CocoaTechBase
//
//  Created by Steve Gehrman on 1/27/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "NSFont-NTExtensions.h"

@implementation NSFont (NTExtensions)

- (int)lineHeight;
{
 	float result;
	
	result = [self ascender] + (-[self descender]) + [self leading];
			
	return ceil(result);
}

@end

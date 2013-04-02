//
//  NTMetalWindowTheme.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 11/7/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NTGradientDraw;

@interface NTMetalWindowTheme : NSObject 
{
    BOOL mFlat;
	NSWindow* mWindow; // window not retained
	
	NSColor* mDefaultBackgroundColor;
	NSRect mLastWindowRect;
	
	NTGradientDraw* gradient;
	NSColor* backgroundColor;
}

@property (retain) NTGradientDraw* gradient;
@property (retain) NSColor* backgroundColor;

+ (NTMetalWindowTheme*)theme:(NSWindow*)window;

@end

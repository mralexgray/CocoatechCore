//
//  NSSplitView-NTExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 1/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSSplitView (AnimationExtensions)

- (void)setPosition:(CGFloat)position ofDividerAtIndex:(NSInteger)dividerIndex animate:(BOOL)animate;
- (float)position;

- (float)splitFraction;
- (void)setSplitFraction:(float)newFract animate:(BOOL)animate;

// sets the autosave name and the default fraction
- (void)setupSplitView:(NSString*)autosaveName 
	   defaultFraction:(float)defaultFraction;

- (void)savePositionPreference;
- (float)positionFromPreference;
@end


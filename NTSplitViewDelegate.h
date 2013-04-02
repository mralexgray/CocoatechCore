//
//  NTSplitViewDelegate.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 12/20/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTSplitViewDelegate : NSObject <NSSplitViewDelegate>
{
	id delegate; // not retained
	
	BOOL resizeProportionally;
	int resizeViewIndex;  // which view to resize when window grows
	int collapseViewIndex; // index of view to collapse on double click, set to -1 to disallow collapsing completely, default is 1
	
	int preventViewCollapseAtIndex;  // default -1 which doesn nothing
	
	float minCoordinate;
	float maxCoordinate;
}

@property (assign) id delegate;  // not retained
@property (assign) int resizeViewIndex;
@property (assign) int collapseViewIndex;   // default is 1
@property (assign) int preventViewCollapseAtIndex;
@property (assign) float minCoordinate;
@property (assign) float maxCoordinate;
@property (assign) BOOL resizeProportionally;

+ (NTSplitViewDelegate*)splitViewDelegate;
+ (NTSplitViewDelegate*)splitViewDelegate:(id)delegate;
- (void)clearDelegate;

@end

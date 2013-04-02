//
//  NTLazyMenu.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 12/20/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTLazyMenu : NSMenu <NSCopying>
{
	id mv_target;
	SEL mv_action;
	
	unsigned mv_buildID;
	
	// can be used by subclasses when building menu
	int mFontSize;
	int mIconSize;
}

+ (NTLazyMenu*)lazyMenu:(NSString*)title target:(id)target action:(SEL)action;

- (unsigned)buildID;
- (void)setBuildID:(unsigned)set;

- (id)target;
- (void)setTarget:(id)theTarget;

- (SEL)action;
- (void)setAction:(SEL)theAction;

- (int)fontSize;
- (void)setFontSize:(int)theFontSize;

- (int)iconSize;
- (void)setIconSize:(int)theIconSize;

@end

@interface NTLazyMenu (Protocols) <NSMenuDelegate>
// subclass to build your menu
// - (void)menuNeedsUpdate:(NSMenu*)menu;
@end
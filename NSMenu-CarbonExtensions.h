//
//  NSMenu-CarbonExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 2/13/09.
//  Copyright 2009 Cocoatech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if NOTSNOWLEOPARD

@interface NSMenu (CarbonExtensions)

- (void)doPopupMenuBelowRect_CARBON:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;

@end

#endif

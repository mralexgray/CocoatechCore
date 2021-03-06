//
//  NTClickState.h
//  CocoatechCore
//
//  Created by Steve Gehrman on Tue Aug 13 2002.
//  Copyright (c) 2002 CocoaTech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTClickState : NSObject
{
    BOOL _handled;  // set to true when click doesn't require any more processing

    int _renameOnMouseUpIndex;
    
    NSEvent* _event;
}

+ (NTClickState*)clickState:(NSEvent*)event;

- (BOOL)isHandled;
- (void)setHandled:(BOOL)set;

- (BOOL)tryRenameOnMouseUp;
- (void)setTryRenameOnMouseUpIndex:(int)index;
- (int)renameOnMouseUpIndex;

- (NSEvent*)event;

- (BOOL)isDoubleClick;
- (BOOL)isSingleClick;

- (BOOL)isRightClick;
- (BOOL)isLeftClick;

- (BOOL)isContextualMenuClick;  // either rightMouseDown, or leftMouseDown and controlKeyDown

- (BOOL)anyModifierDown;
- (BOOL)isShiftDown;
- (BOOL)isControlDown;
- (BOOL)isCommandDown;
- (BOOL)isOptionDown;

- (NSPoint)mousePointForView:(NSView*)view;  // in views coordinates
- (NSPoint)mousePointInWindow;  // in window coordinates

@end

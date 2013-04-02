//
//  NSEvent-Utilities.m
//  CocoatechCore
//
//  Created by Steve Gehrman on Sat Jun 22 2002.
//  Copyright (c) 2002 CocoaTech. All rights reserved.
//

#import "NSEvent-Utilities.h"
#import <Carbon/Carbon.h>

@implementation NSEvent (Utilities)

+ (BOOL)isMouseButtonDown;
{
#if SNOWLEOPARD
	NSUInteger leftMouse = (1 << 0);
	return (([NSEvent pressedMouseButtons] & leftMouse) == leftMouse);  // left mouse button
#endif
	return (GetCurrentButtonState() & 0x01) != 0;  // primary mouse button?
}

+ (BOOL)controlKeyDownNow
{
#if SNOWLEOPARD
	return (([NSEvent modifierFlags] & NSControlKeyMask) == NSControlKeyMask);
#endif
    return ((GetCurrentKeyModifiers() & controlKey) != 0);
}

+ (BOOL)optionKeyDownNow
{
#if SNOWLEOPARD
	return (([NSEvent modifierFlags] & NSAlternateKeyMask) == NSAlternateKeyMask);
#endif	
    return ((GetCurrentKeyModifiers() & optionKey) != 0);
}

+ (BOOL)commandKeyDownNow
{
#if SNOWLEOPARD
	return (([NSEvent modifierFlags] & NSCommandKeyMask) == NSCommandKeyMask);
#endif	
    return ((GetCurrentKeyModifiers() & cmdKey) != 0);
}

+ (BOOL)shiftKeyDownNow
{
#if SNOWLEOPARD
	return (([NSEvent modifierFlags] & NSShiftKeyMask) == NSShiftKeyMask);
#endif	
    return ((GetCurrentKeyModifiers() & shiftKey) != 0);
}

+ (BOOL)capsLockDownNow
{
#if SNOWLEOPARD
	return (([NSEvent modifierFlags] & NSAlphaShiftKeyMask) == NSAlphaShiftKeyMask);
#endif	
    return ((GetCurrentKeyModifiers() & alphaLock) != 0);
}

+ (unsigned)carbonModifierFlagsToCocoaModifierFlags:(unsigned)aModifierFlags;
{
	unsigned theCocoaModifierFlags = 0;
	
	if (aModifierFlags & shiftKey)
		theCocoaModifierFlags |= NSShiftKeyMask;
	if (aModifierFlags & controlKey)
		theCocoaModifierFlags |= NSControlKeyMask;
	if (aModifierFlags & optionKey)
		theCocoaModifierFlags |= NSAlternateKeyMask;
	if (aModifierFlags & cmdKey)
		theCocoaModifierFlags |= NSCommandKeyMask;
	if (aModifierFlags & 0x20000)
		theCocoaModifierFlags |= NSFunctionKeyMask;
	
	return theCocoaModifierFlags;
}

+ (BOOL)spaceKeyDownNow;
{
	KeyMapByteArray map;						// this is the endian-safe way to use GetKeys
    GetKeys(*((KeyMap*) &map));
    
    return (map[6] & 0x2);		// virtual key code for space bar is 49
}

// a simple way of looking at the event modifier flags
- (BOOL)controlKeyDown;
{
    return (([self modifierFlags] & NSControlKeyMask) != 0);
}

- (BOOL)modifierIsDown;
{
	
	if ((([self modifierFlags] & NSControlKeyMask) == NSControlKeyMask) ||
		(([self modifierFlags] & NSShiftKeyMask) == NSShiftKeyMask) ||
		(([self modifierFlags] & NSCommandKeyMask) == NSCommandKeyMask) ||
		(([self modifierFlags] & NSAlternateKeyMask) == NSAlternateKeyMask))
		return YES;
	
	return NO;
}

- (BOOL)optionKeyDown;
{
    return (([self modifierFlags] & NSAlternateKeyMask) != 0);
}

- (BOOL)commandKeyDown;
{
    return (([self modifierFlags] & NSCommandKeyMask) != 0);
}

- (BOOL)shiftKeyDown;
{
    return (([self modifierFlags] & NSShiftKeyMask) != 0);
}

- (BOOL)optionXOrCommandKeyDown;
{
    if ([self optionKeyDown])
        return ![self commandKeyDown];
    else if ([self commandKeyDown])
        return ![self optionKeyDown];
    
    return NO;
}

// this identifies and event that would signal opening a new window
- (BOOL)openInNewWindowEvent;
{
    BOOL result = [self commandKeyDown];

    // is this a menuCmd?  what about function keys?
    if (result && [self type] == NSKeyDown)
		result = NO;
    
    return result;
}

#warning user reported hang here

// does not dequeue the mouseUp event
+ (BOOL)isDragEvent:(NSEvent *)event forView:(NSView*)view dragSlop:(float)dragSlop timeOut:(NSDate*)timeOut;
{    
	// check on mouseDown only
    if ([event type] == NSLeftMouseDown);
	{
		NSPoint eventLocation;
		NSRect slopRect;
		
		eventLocation = [event locationInWindow];
		slopRect = NSInsetRect(NSMakeRect(eventLocation.x, eventLocation.y, 0.0, 0.0), -dragSlop, -dragSlop);
		
		while (YES)
		{
			NSEvent *nextEvent;
			
			NSDate *date = timeOut;
			if (!date)
				date = [NSDate dateWithTimeIntervalSinceNow:2]; // 2 second timeout so we can verify the mouse is still phsyically down - the mouseUp could have been eaten by a wacom tablet or other hack or bug
			
			nextEvent = [NSApp nextEventMatchingMask:NSLeftMouseDraggedMask | NSLeftMouseUpMask untilDate:date inMode:NSEventTrackingRunLoopMode dequeue:NO];
			
			if (nextEvent == nil)// Timeout date reached
			{
				// only return if a time out was set by the caller
				if (timeOut)
					return NO;
				else
				{
					// to avoid endless loop, check if the mouse is still down
					if (![NSEvent isMouseButtonDown])
						return NO;
				}
			}
			else if ([nextEvent type] == NSLeftMouseUp)
				return NO;
			else if ([nextEvent type] == NSLeftMouseDragged) // if mouseDrag and we moved the mouse far enough for a drag, break out of loop
			{
				// take the dragged event off the queue
				[NSApp nextEventMatchingMask:NSLeftMouseDraggedMask untilDate:[NSDate distantPast] inMode:NSEventTrackingRunLoopMode dequeue:YES];
				
				if (!NSMouseInRect([nextEvent locationInWindow], slopRect, [view isFlipped]))
					return YES;
			}
		}
    }
	
    return NO;
}

// these examine clickCount%2 so the 3rd click becomes a single click and the 4th becomes another double click
// you have to do this if the user clicks 4 times expecting events 1,2,1,2 rather than 1,2,3,4
- (BOOL)isSingleClick;
{
	int cnt = [self clickCount];

	return ((cnt % 2) == 1);
}

- (BOOL)isDoubleClick;
{
	int cnt = [self clickCount];
	
	return (cnt && ((cnt % 2) == 0));
}

- (BOOL)isRightArrowEvent;
{
	return [self characterIsDown:NSRightArrowFunctionKey];
}

- (BOOL)isArrowEvent;
{
	return ([self isLeftArrowEvent] ||
			[self isRightArrowEvent] ||
			[self isUpArrowEvent] ||
			[self isDownArrowEvent]
			);
}

- (BOOL)isLeftArrowEvent;
{
	return [self characterIsDown:NSLeftArrowFunctionKey];
}

- (BOOL)isUpArrowEvent;
{
	return [self characterIsDown:NSUpArrowFunctionKey];
}

- (BOOL)isDownArrowEvent;
{
	return [self characterIsDown:NSDownArrowFunctionKey];
}

- (BOOL)characterIsDown:(unichar)theCharacter;
{
	NSString* characters = [self characters];
	if ([characters length])
	{
		if ([characters characterAtIndex:0] == theCharacter)
			return YES;
	}
	
	return NO;	
}

- (BOOL)isHomeKeyEvent;
{
	return [self characterIsDown:NSHomeFunctionKey];
}

- (BOOL)isEndKeyEvent;
{
	return [self characterIsDown:NSEndFunctionKey];
}

- (BOOL)isPageUpKeyEvent;
{
	return [self characterIsDown:NSPageUpFunctionKey];
}

- (BOOL)isPageDownKeyEvent;
{
	return [self characterIsDown:NSPageDownFunctionKey];
}

- (BOOL)isDeleteKeyEvent;
{
	return [self characterIsDown:127];
}

- (BOOL)isReturnKeyEvent;
{
	return [self characterIsDown:0x000D];
}

- (BOOL)isEscKeyEvent;
{
	return [self characterIsDown:0x001B];
}

- (BOOL)isTabKeyEvent;
{
	return [self characterIsDown:0x0009];
}

- (BOOL)isShiftTabKeyEvent;
{
	return [self characterIsDown:0x0019];   // shift tab?
}

@end

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// keyMap utils

void logKeyMap(KeyMapByteArray keymap) 
{
	NSMutableString *string = [NSMutableString string];
	int i;
	for (i = 0; i<sizeof(KeyMapByteArray); i++)
		[string appendFormat:@" %02hhX", keymap[i]];
	
	NSLog(@"KeyMap %@", string);
}

void keyMapAddKeyCode(KeyMapByteArray keymap, int keyCode) 
{
	int half = sizeof(KeyMapByteArray) / 2;
	
	int i = keyCode / half;
	int j = keyCode % half;
	
	keymap[i] = keymap[i] | 1 << j;
}

void keyMapInvert(KeyMapByteArray keymap) 
{
	int i;
	for (i = 0; i<sizeof(KeyMapByteArray); i++)
		keymap[i] = ~keymap[i];
}

void keyMapInit(KeyMapByteArray keymap)
{
    int i;
	for (i = 0; i<sizeof(KeyMapByteArray); i++) 
		keymap[i] = 0;
}

BOOL keyMapAND(KeyMapByteArray keymap, KeyMapByteArray keymap2)
{
	int i;
	for (i = 0; i<sizeof(KeyMapByteArray); i++)
	{
		if (keymap[i] & keymap2[i])
			return YES;
	}
	
	return NO;
}

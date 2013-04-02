//
//  NTHotKeyManager.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 5/16/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "NTSingletonObject.h"

// "identifier" key has hotKey id in userInfo
#define kNTHotKeyManagerNotification @"NTHotKeyManagerNotification"

@interface NTHotKeyManager : NTSingletonObject
{
    EventHandlerRef eventHandlerRef;
    EventHandlerUPP appHotKeyFunction;    	
}

@property (assign) EventHandlerRef eventHandlerRef;
@property (assign) EventHandlerUPP appHotKeyFunction;

- (EventHotKeyRef)setHotKey:(unichar)hotKey identifier:(int)identifier modifierFlags:(int)modifierFlags;
- (void)removeHotKey:(EventHotKeyRef)hotKeyRef;

@end

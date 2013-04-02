//
//  NSMenu-CarbonExtensions.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 2/13/09.
//  Copyright 2009 Cocoatech. All rights reserved.
//

#import "NSMenu-CarbonExtensions.h"
#import "NTGeometry.h"

#if NOTSNOWLEOPARD

// undocumented ref
extern MenuRef _NSGetCarbonMenu(NSMenu *);

@interface NSMenu (CarbonExtensionsPrivate)
+ (BOOL)recursiveMenuWalk:(NSMutableArray*)menuPath menuRef:(MenuRef)menuRef menuID:(int)inMenuID menuItem:(int)inMenuItem;
- (void)triggerMenuRefCreation;
- (MenuRef)carbonMenu;

+ (NSArray*)findMenuItemPath:(MenuRef)menuRef menuID:(int)inMenuID menuItem:(int)inMenuItem;
- (void)sendActionAtPath:(NSArray*)menuPath;
+ (Point)convertGlobalPointToCarbonPoint:(NSPoint)point;
@end

@implementation NSMenu (CarbonExtensions)

- (void)doPopupMenuBelowRect_CARBON:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;
{
	// must validate the menu 
	if ([self autoenablesItems])
	{
		id delegate = [self delegate];
		
		// must must be built and updated before calling the carbon call
		if (delegate && [delegate respondsToSelector:@selector(menuNeedsUpdate:)])
			[delegate menuNeedsUpdate:self];
	}
	
	// must update so the menu is all built and the width is accurate
	[self update];	
	
	// have to use carbon menus for this
	MenuRef menuRef = [self carbonMenu];
	
	rect = [controlView convertRect:rect toView:nil];
	
	// make sure menu is at least as wide as the control
	CalcMenuSize(menuRef); // make sure we are calced, otherwise GetMenuWidth returns -1
	int menuWidth = GetMenuWidth(menuRef);
	NSPoint menuOrigin = rect.origin;
	
	// center the menu
	if (centerMenu)
	{
		if (NSWidth(rect) > menuWidth)
			menuOrigin.x += ((NSWidth(rect)/2) - (menuWidth/2));
	}
	
	NSPoint globalPoint = [[controlView window] convertBaseToScreen:menuOrigin];
	globalPoint.y -= 4; // move down a bit
	
	// make sure it's visible, otherwise PopUpMenuSelect will use 0,0
	globalPoint = [NTGeometry point:globalPoint insideRect:NSInsetRect([[NTGeometry screenForPoint:globalPoint] frame], 2, 2)];
	
	Point carbonPoint = [NSMenu convertGlobalPointToCarbonPoint:globalPoint];
	long result = PopUpMenuSelect(menuRef, carbonPoint.v, carbonPoint.h, 0);    
	
	short menuID = result >> 16;
	short menuItem = result & 0x0000FFFF;
	
	NSArray* path = [NSMenu findMenuItemPath:menuRef menuID:menuID menuItem:menuItem];
	
	if (path)
		[self sendActionAtPath:path];
}

@end

@implementation NSMenu (CarbonExtensionsPrivate)

- (MenuRef)carbonMenu;
{
    MenuRef menuRef = _NSGetCarbonMenu(self);
    if (!menuRef)
    {
        [self triggerMenuRefCreation];
        
        menuRef = _NSGetCarbonMenu(self);
    }
    
    return menuRef;
}

+ (BOOL)recursiveMenuWalk:(NSMutableArray*)menuPath menuRef:(MenuRef)menuRef menuID:(int)inMenuID menuItem:(int)inMenuItem;
{
    int i, cnt = CountMenuItems(menuRef);
    int menuID;
    OSStatus err;
    MenuRef hierMenu;
    
    menuID = GetMenuID(menuRef);
    if (inMenuID == menuID)
    {
        if (inMenuItem <= cnt)
        {
            [menuPath addObject:[NSNumber numberWithInt:inMenuItem]];
            
            return YES;
        }
    }
    
    for (i=1;i<=cnt;i++)
    {
        err = GetMenuItemHierarchicalMenu(menuRef, i, &hierMenu);
        
        if (err == noErr && hierMenu != 0)
        {
            BOOL result;
            
            [menuPath addObject:[NSNumber numberWithInt:i]];
            result = [self recursiveMenuWalk:menuPath menuRef:hierMenu menuID:inMenuID menuItem:inMenuItem];
            
            // if found, return, otherwise take the index off the path
            if (result)
                return result;
            else
                [menuPath removeLastObject];
        }
    }
    
    return NO;
}

+ (NSArray*)findMenuItemPath:(MenuRef)menuRef menuID:(int)inMenuID menuItem:(int)inMenuItem;
{
    NSMutableArray* menuPath=[NSMutableArray array];
    BOOL result;
    
    result = [self recursiveMenuWalk:menuPath menuRef:menuRef menuID:inMenuID menuItem:inMenuItem];
    
    if (result)
        return menuPath;
    
    return nil;
}

- (void)sendActionAtPath:(NSArray*)menuPath;
{
    NSMenu* menu=self;
    int i, cnt = [menuPath count];
    NSNumber* number;
    NSMenuItem* menuItem;
    
    for (i=0;i<cnt;i++)
    {
        number = [menuPath objectAtIndex:i];
		
		int itemIndex = [number intValue] - 1;
		if (itemIndex >=0 && itemIndex < [menu numberOfItems])
		{
			menuItem = (NSMenuItem*) [menu itemAtIndex:itemIndex];  // array is one based
			
			if (menuItem)
			{
				// if at end of the list, send action
				if (i == (cnt-1))
				{
					if ([menuItem action])
						[NSApp sendAction:[menuItem action] to:[menuItem target] from:menuItem];
				}
				else
					menu = [menuItem submenu];
			}
			else
				break;  // something is wrong
		}
		else
			break;  // something is wrong
	}
}

+ (Point)convertGlobalPointToCarbonPoint:(NSPoint)point;
{
    // All screens; first one is "zero" screen
    // need the zero screen to convert to Carbon coordinates
    NSArray* screens =	[NSScreen screens];
    Point result = {(int)point.y, (int)point.x};
    
    if ([screens count])
    {
        NSRect mainScreenRect = [[screens objectAtIndex:0] frame];
        float newYOrigin = NSMaxY(mainScreenRect);
        
        result.v = newYOrigin - result.v;
    }
    
    return result;
}

- (void)triggerMenuRefCreation;
{
    static NSMenuItem* sMenuItem = nil;
    
    if (!sMenuItem)
        sMenuItem = [[NSMenuItem alloc] init];
    
    [[NSApp mainMenu] addItem:sMenuItem];
    
    [sMenuItem setSubmenu:self];  // forces the menuRef to build
    [sMenuItem setSubmenu:nil];
    
    [[NSApp mainMenu] removeItem:sMenuItem];
}

@end

#endif


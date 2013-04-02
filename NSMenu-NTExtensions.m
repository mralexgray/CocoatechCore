//
//  NSMenu-NTExtensions.m
//  CocoatechCore
//
//  Created by Steve Gehrman on Sun Feb 29 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "NSMenu-NTExtensions.h"
#import "NSMenuItem-NTExtensions.h"
#import "NTImageMaker.h"
#import "NTGeometry.h"
#import "NTUtilities.h"
#import "NSMenu-CarbonExtensions.h"

@interface NSMenu (NTExtensions_Private)
- (void)doPopupMenuBelowRect_SNOWLEOPARD:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;
+ (void)recursiveHelper:(NSMenu*)menu array:(NSMutableArray*)resultArray;
+ (void)recursiveHelper:(NSMenu*)menu
			matchingTag:(int)tag
				  array:(NSMutableArray*)resultArray;
@end

@implementation NSMenu (NTExtensions)

- (void)removeAllMenuItems;
{
    while ([self numberOfItems])
        [self removeItemAtIndex: 0];
}

// set indentation level of all items in the menu
- (void)setIndentationLevel:(int)indentationLevel;
{
	NSEnumerator *enumerator = [[self itemArray] objectEnumerator];
	NSMenuItem* menuItem;
	
	while (menuItem = [enumerator nextObject])
		[menuItem setIndentationLevel:indentationLevel];
}

- (void)appendMenu:(NSMenu*)menu;
{
	NSEnumerator *enumerator = [[menu itemArray] objectEnumerator];
	NSMenuItem* newItem, *menuItem;
	
	while (menuItem = [enumerator nextObject])
	{
		newItem = [[menuItem copy] autorelease];
				
		[self addItem:newItem];
	}
}

- (void)cleanSeparators;  // remove unnecessary separators
{
	NSEnumerator *enumerator = [[self itemArray] reverseObjectEnumerator];
	NSMenuItem *menuItem;
	BOOL previousWasSeparator=NO;
	
	while (menuItem = [enumerator nextObject])
	{
		if ([menuItem isSeparatorItem])
		{
			if (previousWasSeparator)
				[self removeItem:menuItem];
			
			previousWasSeparator = YES;
		}
		else
			previousWasSeparator = NO;
	}
	
	// is first item a separator?
	if ([[self itemArray] count])
	{
		menuItem = [[self itemArray] objectAtIndex:0];
		if ([menuItem isSeparatorItem])
			[self removeItem:menuItem];
	}
	
	// is last item a separator?
	if ([[self itemArray] count])
	{
		menuItem = [[self itemArray] objectAtIndex:[[self itemArray] count]-1];
		if ([menuItem isSeparatorItem])
			[self removeItem:menuItem];
	}
}

- (void)appendMenu:(NSMenu*)menu fontSize:(int)fontSize;
{
	NSEnumerator *enumerator = [[menu itemArray] objectEnumerator];
	NSMenuItem* newItem, *menuItem;
	
	while (menuItem = [enumerator nextObject])
	{
		newItem = [[menuItem copy] autorelease];
		
		[newItem setFontSize:fontSize color:nil];

		[self addItem:newItem];
	}
}

- (void)setFontSize:(int)fontSize color:(NSColor*)color;
{
	NSEnumerator *enumerator = [[self itemArray] objectEnumerator];
	NSMenuItem *menuItem;
	
	while (menuItem = [enumerator nextObject])
	{		
		[menuItem setFontSize:fontSize color:color];
		
		if ([menuItem submenu])
			[[menuItem submenu] setFontSize:fontSize color:color]; // recursive
	}
}

- (void)removeItemsInRange:(NSRange)range;
{
	int numItems = [self numberOfItems];
	int index, cnt = MIN(numItems, NSMaxRange(range));
	int firstIndex = range.location;
	
	if (cnt)
	{
		for (index=cnt-1; index >= firstIndex; index--)
			[self removeItemAtIndex:index];
	}
}

- (void)popUpContextMenu:(NSEvent*)event forView:(NSView*)view;
{
	NSRect rect = NSZeroRect;
	
	if (![NSApp isActive])
	{
		[NSApp activateIgnoringOtherApps:YES];
		
		// post event again so it happens after the activate of the window
		[NSApp postEvent:event atStart:NO];
	}
	else
	{
		rect.origin = [view convertPoint:[event locationInWindow] fromView:nil];
		[self popupMenuBelowRect:rect inView:view centerMenu:NO];
		
		// Cocoa adds CMs itself which adds duplicates and looks ugly
		// [NSMenu popUpContextMenu:menu withEvent:event forView:view];
	}
}

- (void)popupMenuBelowRect:(NSRect)rect inView:(NSView*)controlView;
{
    [self popupMenuBelowRect:rect inView:controlView centerMenu:NO];
}

- (void)popupMenuBelowRect:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;
{
#if SNOWLEOPARD
	[self doPopupMenuBelowRect_SNOWLEOPARD:rect inView:controlView centerMenu:centerMenu];
#else
	[self doPopupMenuBelowRect_CARBON:rect inView:controlView centerMenu:centerMenu];
#endif
}

// this should be in Cocoa already?
+ (void)removeAllItems:(NSMenu*)menu
{
	MENU_DISABLE(menu);
	{	
		NSInteger cnt = [menu numberOfItems];
		
		for (NSInteger i=cnt-1;i>=0;i--)
			[menu removeItemAtIndex:i];
	}
	MENU_ENABLE(menu);
}

+ (void)copyMenuItemsFrom:(NSMenu*)newMenu toMenu:(NSMenu*)menu;
{
	MENU_DISABLE(menu);
	{	
		[self removeAllItems:menu];
		
		NSEnumerator *enumerator = [[newMenu itemArray] objectEnumerator];
		NSMenuItem* menuItem;
		
		while (menuItem = [enumerator nextObject])
			[menu addItem:[[menuItem copy] autorelease]];
	}
	MENU_ENABLE(menu);
}

+ (NSMenuItem*)itemWithAction:(SEL)action menu:(NSMenu*)menu;
{
    NSArray* itemArray = [menu itemArray];
    NSMenu* submenu;
    NSMenuItem* result=nil;
    
    for (NSMenuItem *item in itemArray)
    {
        
        submenu = [item submenu];
        if (submenu)
        {
            if (submenu != [NSApp servicesMenu])
                result = [self itemWithAction:action menu:submenu];
        }
        else
        {
            if ([item action] == action)
                result = item;
        }
        
        if (result)
            break;
    }
    
    return result;
}

+ (NSMenuItem*)itemWithKeyEquivalent:(NSString*)key modifiersMask:(unsigned)modifiersMask menu:(NSMenu*)menu;
{
	NSArray* itemArray = [menu itemArray];
    NSMenu* submenu;
    NSMenuItem* result=nil;
    
    for (NSMenuItem *item in itemArray)
    {
        
        submenu = [item submenu];
        if (submenu)
        {
            if (submenu != [NSApp servicesMenu])
                result = [self itemWithKeyEquivalent:key modifiersMask:modifiersMask menu:submenu];
        }
        else
        {				
			if (([item keyEquivalentModifierMask] == modifiersMask)
				&& ([[item keyEquivalent] isEqualToString:key]))
				result = item;
        }
        
        if (result)
            break;
    }
    
    return result;	
}

+ (NSMenuItem*)itemWithSubmenu:(NSMenu*)inMenu menu:(NSMenu*)menu;
{
    NSArray* itemArray = [menu itemArray];
    NSMenu* submenu;
    NSMenuItem* result=nil;
    
    for (NSMenuItem *item in itemArray)
    {
        submenu = [item submenu];
        if (submenu)
        {
            if (submenu != [NSApp servicesMenu])
            {
                if (submenu == inMenu)
                    result = item;
                else
                    result = [self itemWithSubmenu:inMenu menu:submenu];
            }
        }
        
        if (result)
            break;
    }
    
    return result;    
}

// returns every menuitem, except those with a submenu
+ (NSArray*)everyItemInMenu:(NSMenu*)menu;
{
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:50];
    
    [self recursiveHelper:menu array:result];
    return result;
}

- (NSArray*)itemsWithTag:(int)tag;
{
	NSMutableArray* result = [NSMutableArray arrayWithCapacity:50];
    
    [NSMenu recursiveHelper:self matchingTag:tag array:result];
    return result;	
}

+ (void)removeAllItemsBelowTag:(int)tag
{
    NSMenuItem* rootItem = [self itemWithTag:tag menu:[NSApp mainMenu]];
    NSMenu* itemsMenu = [rootItem menu];
    
    [itemsMenu removeAllItemsBelowTag:tag];
}

- (void)removeAllItemsBelowTag:(int)tag
{
    NSMenuItem* rootItem = [self itemWithTag:tag];
    
    if (rootItem)
		[self removeAllItemsBelowItem:rootItem];
}

- (void)removeAllItemsBelowItem:(NSMenuItem*)item;
{
	[self removeAllItemsAfterIndex:[self indexOfItem:item]];
}

- (void)removeAllItemsAfterIndex:(unsigned)index;
{
	int i, cnt = [self numberOfItems];
	
	for (i=cnt-1;i>index;i--)
		[self removeItemAtIndex:i];
}

// called recursively on all submenus, start with itemWithTag:[NSApp mainMenu] tag:
+ (NSMenuItem*)itemWithTag:(int)tag menu:(NSMenu*)menu;
{
    NSMenuItem* result = [menu itemWithTag:tag];
    
    // if not found, search in submenus
    if (!result)
    {
        NSArray* itemArray = [menu itemArray];
        NSMenu* submenu;
        
        for (NSMenuItem *item in itemArray)
        {
            
            submenu = [item submenu];
            if (submenu && (submenu != [NSApp servicesMenu]))
                result = [self itemWithTag:tag menu:submenu];
            
            if (result)
                break;
        }
    }
    
    return result;
}

// update doesn't update submenus, so we created updateAll
- (void)updateAll;
{
	[self update];
	
	NSEnumerator *enumerator = [[self itemArray] objectEnumerator];
	NSMenu* submenu;
	NSMenuItem* menuItem;

	while (menuItem = [enumerator nextObject])
	{		
		submenu = [menuItem submenu];
		if (submenu)
			[submenu updateAll];
	}
}

+ (NSImage*)menuColorImage:(NSColor*)color;
{
	NTImageMaker* maker = [NTImageMaker maker:NSMakeSize(16,12)];

	[maker lockFocus];
	[color set];
	[NSBezierPath fillRect:NSMakeRect(0, 0, 16, 12)];
	[[NSColor grayColor] set];
	NSFrameRect(NSMakeRect(0, 0, 16, 12));
	return [maker unlockFocus];
}

- (void)selectItemWithTag:(int)tag;
{
	NSMenuItem* selectedItem = [self itemWithTag:tag];
	
	NSEnumerator *enumerator = [[self itemArray] objectEnumerator];
	NSMenuItem* menuItem;
	
	while (menuItem = [enumerator nextObject])
		[menuItem setState:(selectedItem == menuItem) ? NSOnState : NSOffState];
}

+ (NSDictionary*)infoAttributes:(float)fontSize;
{
	static NSDictionary* sharedDictionary = nil;
	static float sharedSize = 0;
	
	if (fontSize != sharedSize)
	{
		[sharedDictionary release];
		sharedDictionary = nil;
		
		sharedSize = fontSize;
	}
	
	if (!sharedDictionary)
	{
		NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
		
		[attributes setObject:[NSFont menuFontOfSize:sharedSize] forKey:NSFontAttributeName];
		[attributes setObject:[NSColor grayColor] forKey:NSForegroundColorAttributeName];
		
		sharedDictionary = [[NSDictionary alloc] initWithDictionary:attributes];
	}
	
	return sharedDictionary;
}

- (NSMenuItem*)parentMenuItem;
{
    NSMenu* supermenu = [self supermenu];
    
    if (supermenu)
    {
        int itemIndex = [supermenu indexOfItemWithSubmenu:self];
        return (NSMenuItem*)[supermenu itemAtIndex:itemIndex];
    }
    
    return nil;
}

- (NSString*)path;
{
    NSMutableArray* components = [NSMutableArray array];
    NSMenuItem* parentItem=[self parentMenuItem];
    
    while (parentItem)
    {
        NSString *title = [parentItem title];
        
        if (![title length])
            title = @"/";
        
        [components insertObject:title atIndex:0];
        
        parentItem = [parentItem parentMenuItem];
    }
    
    return [NSString pathWithComponents:components];
}

- (void)removeAllItems;
{
    while ([self numberOfItems])
        [self removeItemAtIndex: 0];
}

- (NSMenuItem*)itemWithPath:(NSString*)path;
{
    NSEnumerator* enumerator = [[path pathComponents] objectEnumerator];
    NSString* menuTitle;
    NSMenu* currentMenu = self;
    NSMenuItem* menuItem=nil;
    
    while (menuTitle = [enumerator nextObject])
    {
        if (!currentMenu)
            return nil;
        
        if ([menuTitle isEqualToString:@"/"])
            menuTitle = @"";
        
        menuItem = (NSMenuItem*) [currentMenu itemWithTitle:menuTitle];
        
        if (!menuItem)
            return nil;
        else
            currentMenu = [menuItem submenu];
    }
    
    return menuItem;
}

- (void)addItems:(NSArray*)items;
{
	NSMenuItem* menuItem;
	
	MENU_DISABLE(self);
	{
		for (menuItem in items)
			[self addItem:menuItem];
	}
	MENU_ENABLE(self);
}

- (void)insertItems:(NSArray*)items atIndex:(int)index;
{
	NSEnumerator* enumerator = [items reverseObjectEnumerator];
	NSMenuItem* menuItem;
	
	MENU_DISABLE(self);
	{
		while (menuItem = [enumerator nextObject])
			[self insertItem:menuItem atIndex:index];
	}
	MENU_ENABLE(self);
}

@end

@implementation NSMenu (NTExtensions_Private)

+ (void)recursiveHelper:(NSMenu*)menu array:(NSMutableArray*)resultArray
{
    NSArray* itemArray = [menu itemArray];
    NSMenu* submenu;
    
    for (NSMenuItem *item in itemArray)
    {
        submenu = [item submenu];
        if (submenu)
        {
            if (submenu != [NSApp servicesMenu])
                [self recursiveHelper:submenu array:resultArray];
        }
        else
            [resultArray addObject:item];
    }
}

+ (void)recursiveHelper:(NSMenu*)menu 
			matchingTag:(int)tag
				  array:(NSMutableArray*)resultArray
{
    NSEnumerator* enumerator = [[menu itemArray] objectEnumerator];
	NSMenuItem* item;
    NSMenu* submenu;
    
    while (item = [enumerator nextObject])
    {
		if ([item tag] == tag)
			[resultArray addObject:item];
		
        submenu = [item submenu];
        if (submenu)
        {
            if (submenu != [NSApp servicesMenu])
                [self recursiveHelper:submenu matchingTag:tag array:resultArray];
        }
    }
}

- (void)doPopupMenuBelowRect_SNOWLEOPARD:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;
{
#if SNOWLEOPARD
	NSPoint location = rect.origin;
	
	if ([controlView isFlipped])
		location.y += NSHeight(rect) + 4;
	
	// center the menu
	if (centerMenu)
	{
		NSSize menuSize = [self size];
		if (NSWidth(rect) > menuSize.width)
			location.x += ((NSWidth(rect)/2) - (menuSize.width/2));
	}		
	
	[self popUpMenuPositioningItem:nil atLocation:location inView:controlView];
#endif
}

@end






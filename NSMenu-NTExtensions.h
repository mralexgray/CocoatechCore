//
//  NSMenu-NTExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on Sun Feb 29 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMenu (NTExtensions)
- (void)removeAllMenuItems;

- (void)popupMenuBelowRect:(NSRect)rect inView:(NSView*)controlView;
- (void)popupMenuBelowRect:(NSRect)rect inView:(NSView*)controlView centerMenu:(BOOL)centerMenu;
- (void)popUpContextMenu:(NSEvent*)event forView:(NSView*)view;

- (void)setIndentationLevel:(int)indentationLevel;
- (void)appendMenu:(NSMenu*)menu;
- (void)appendMenu:(NSMenu*)menu fontSize:(int)fontSize;

// recursively set all menuItems to size and color
- (void)setFontSize:(int)fontSize color:(NSColor*)color;

- (void)cleanSeparators;  // remove unnecessary separators

- (void)removeItemsInRange:(NSRange)range;
- (void)removeAllItems;

+ (void)copyMenuItemsFrom:(NSMenu*)newMenu toMenu:(NSMenu*)menu;
+ (void)removeAllItems:(NSMenu*)menu;

+ (NSArray*)everyItemInMenu:(NSMenu*)menu;
- (NSArray*)itemsWithTag:(int)tag;

+ (NSMenuItem*)itemWithTag:(int)tag menu:(NSMenu*)menu;
+ (NSMenuItem*)itemWithAction:(SEL)action menu:(NSMenu*)menu;
+ (NSMenuItem*)itemWithKeyEquivalent:(NSString*)key modifiersMask:(unsigned)modifiersMask menu:(NSMenu*)menu;
+ (NSMenuItem*)itemWithSubmenu:(NSMenu*)inMenu menu:(NSMenu*)menu;

+ (void)removeAllItemsBelowTag:(int)tag;
- (void)removeAllItemsBelowTag:(int)tag;
- (void)removeAllItemsBelowItem:(NSMenuItem*)item;
- (void)removeAllItemsAfterIndex:(unsigned)index;

// returns a 16,12 image with the color passed in
+ (NSImage*)menuColorImage:(NSColor*)color;

	// update doesn't update submenus, so we created updateAll
- (void)updateAll;

- (void)selectItemWithTag:(int)tag;

+ (NSDictionary*)infoAttributes:(float)fontSize;

- (NSMenuItem*)parentMenuItem;
- (NSString*)path;
- (NSMenuItem*)itemWithPath:(NSString*)path;

- (void)addItems:(NSArray*)items;
- (void)insertItems:(NSArray*)items atIndex:(int)index;
@end

// ---------------------------------------------------------------------------------

// MENU_DISABLE(menu);
// {
// }
// MENU_ENABLE(menu);

#define MENU_DISABLE(menu) \
BOOL restoreBuildMenu = NO; \
if ([menu menuChangedMessagesEnabled]) { \
restoreBuildMenu = YES; [menu setMenuChangedMessagesEnabled:NO]; \
}

#define MENU_ENABLE(menu) \
if (restoreBuildMenu) \
[menu setMenuChangedMessagesEnabled:YES];





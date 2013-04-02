//
//  NSView-CoreExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 1/22/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// informal protocol for a superview when using askParentToDrawBackground
@interface NSView (askParentToDrawBackground)
- (void)drawBackgroundInSubview:(NSView*)theSubview inRect:(NSRect)theRect;
@end

@interface NSView (CoreExtensions)
- (void)drawFocusRing;

+ (BOOL)drawingInMetallicWindow;

- (NSScrollView*)findScrollView;
- (NSView*)findKindOfSubview:(Class)class;
- (NSArray*)subviewsWithClass:(Class)class;
- (NSView*)findKindOfEnclosingView:(Class)class;

// used to fix antialiasing problems with layers and text
- (void)setBackgroundColorOnSubviews:(NSColor*)backColor;

- (BOOL)isVisible;
- (BOOL)mouseInRectNow;

// calls [self window], if it gets a drawerWindow, it returns the parentWindow
- (NSWindow*)contentWindow;

- (void)resizeSubviewsToParentBounds;
- (void)resizeSubviewsToParentSize;

// removesFromSuper, releases and sets to nil
- (void)removeOneView:(NSView**)view;

- (BOOL)containsFirstResponder;
- (BOOL)isFirstResponder;
- (BOOL)isInitialFirstResponder;

- (void)eraseRect:(NSRect)rect;

- (void)setScrollPositionAsPercentage:(NSPoint)scrollPosition;
- (NSPoint)scrollPositionAsPercentage;

- (void)add:(BOOL)add subview:(NSView*)view;

- (NSEvent*)trackMouseDown:(NSEvent *)event dragSlop:(float)dragSlop;

// does not dequeue the mouseUp event
- (BOOL)isDragEvent:(NSEvent *)event dragSlop:(float)dragSlop;

- (void)removeAllSubviews;

// searches up through the super views looking for a view which responds to a selector, returns that view.
// usefull if you don't want to pass delegates all the way down a complex view heirarchy.
// a controlling parent view can handle the selectors and communication with a delegate
// also returns the windows delegate if that responds to the selector
- (id)parentWhichRespondsToSelector:(SEL)sel;

- (BOOL)isParentView:(NSView*)parent;

- (NSImage *)viewImage:(NSRect)rect;  // NSZeroRect for whole view

- (void)setNeedsDisplayForSubviews;
- (void)displayIfNeededForSubviews;

+ (void)drawHighlightRing:(NSRect)theRect selected:(BOOL)theSelected;

// superview must implement : - (void)drawBackgroundInSubview:(NSView*)theSubview inRect:(NSRect)theRect;
- (void)askParentToDrawBackground;
		
// passing NO shows the super view heirarchy
- (void)debugViews:(BOOL)showSubviews;

- (void)scrollToTop;
- (void)scrollToEnd;
- (void)scrollDownByPages:(float)pagesToScroll;
- (void)scrollDownByLines:(float)linesToScroll;
- (void)scrollDownByAdjustedPixels:(float)pixels;
- (void)setFraction:(float)fraction;
- (float)fraction;

@end


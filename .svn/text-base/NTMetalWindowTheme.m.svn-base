//
//  NTMetalWindowTheme.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 11/7/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "NTMetalWindowTheme.h"
#import "NTGradientDraw.h"
#import "NTImageMaker.h"

@interface NTMetalWindowTheme (Private)
- (NSColor *)newBackground;

- (NSWindow *)window;
- (void)setWindow:(NSWindow *)theWindow;

- (NSRect)lastWindowRect;
- (void)setLastWindowRect:(NSRect)theLastWindowRect;
@end

static const int kGradientHeight = 120;

@implementation NTMetalWindowTheme

@synthesize backgroundColor, gradient;

+ (NTMetalWindowTheme*)theme:(NSWindow*)window;
{	
	NTMetalWindowTheme* result = [[NTMetalWindowTheme alloc] init];
	
	[result setWindow:window];
	
	[result setBackgroundColor:[NSColor colorWithCalibratedWhite:0.52 alpha:1]];
	[result setGradient:[NTGradientDraw gradientWithStartColor:[NSColor colorWithCalibratedWhite:0.82 alpha:1] endColor:[result backgroundColor]]];

	[window setBackgroundColor:[result newBackground]];

	[[NSNotificationCenter defaultCenter] addObserver:result 
											 selector:@selector(windowDidResize:) 
												 name:NSWindowDidResizeNotification 
											   object:nil];
	
	return [result autorelease];
}

//---------------------------------------------------------- 
// dealloc
//---------------------------------------------------------- 
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResizeNotification object:nil];
    [self setWindow:nil]; // not retained, but just being consistent
	[self setBackgroundColor:nil];
	[self setGradient:nil];
	
    [super dealloc];
}

- (void)windowDidResize:(NSNotification *)aNotification
{
	if ([aNotification object] == [self window])
	{
		NSRect windowRect = [[self window] frame];
		windowRect.origin = NSZeroPoint;
		
		if (!NSEqualRects(windowRect,[self lastWindowRect]))
		{
			[self setLastWindowRect:windowRect];
			
			[[self window] setBackgroundColor:[self newBackground]];
			
			// invalidate views
			NSRect invalidateRect = [[[self window] contentView] bounds];
			invalidateRect.origin.y = NSMaxY(invalidateRect) - kGradientHeight;
			invalidateRect.size.height = kGradientHeight;
			[[[self window] contentView] setNeedsDisplayInRect:invalidateRect];
		}
	}
}

@end

@implementation NTMetalWindowTheme (Private)

//---------------------------------------------------------- 
//  lastWindowRect 
//---------------------------------------------------------- 
- (NSRect)lastWindowRect
{
    return mLastWindowRect;
}

- (void)setLastWindowRect:(NSRect)theLastWindowRect
{
    mLastWindowRect = theLastWindowRect;
}

- (NSColor *)newBackground;
{
	NSRect windowFrame = [[self window] frame];
	NSSize backImageSize = windowFrame.size;
    NTImageMaker *imageMaker = [NTImageMaker maker:backImageSize];
    			
	// Begin drawing into our main image
	[imageMaker lockFocus];
	
	// Composite current background color into bg
	NSRect backRect = windowFrame;
	backRect.origin = NSZeroPoint;
	
	// fill window
	[[self backgroundColor] set];
	[NSBezierPath fillRect:backRect];
	
	NSRect gradientRect = backRect;
	
	// top gradient
	gradientRect.origin.y = NSMaxY(gradientRect) - kGradientHeight;
	gradientRect.size.height = kGradientHeight;
	[[self gradient] drawInRect:gradientRect 
					 horizontal:YES
						flipped:NO];
			
	return [NSColor colorWithPatternImage:[imageMaker unlockFocus]];
}

//---------------------------------------------------------- 
//  window 
//---------------------------------------------------------- 
- (NSWindow *)window
{
    return mWindow; 
}

- (void)setWindow:(NSWindow *)theWindow
{
    if (mWindow != theWindow)
        mWindow = theWindow;  // not retained, just used for comparison
}

@end


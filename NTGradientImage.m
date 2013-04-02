//
//  NTGradientImage.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 9/15/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "NTGradientImage.h"
#import "NSGraphicsContext-NTExtensions.h"
#import "NSImage-NTExtensions.h"
#import "NTGradient.h"

@interface NTGradientImage (Private)
- (int)imageHeight;
- (void)setImageHeight:(int)theImageHeight;

- (NSImage *)image;
- (void)setImage:(NSImage *)theImage;
@end

static const int kImageWidth = 10;

@implementation NTGradientImage

+ (NTGradientImage*)gradientImage:(NTGradient*)gradient color:(NSColor*)color;
{
	return [self gradientImage:gradient color:color backColor:nil];
}

+ (NTGradientImage*)gradientImage:(NTGradient*)gradient color:(NSColor*)color backColor:(NSColor*)backColor;
{
	NTGradientImage* result = [[NTGradientImage alloc] init];
	
	[result setGradient:gradient];
	[result setColor:color];
	[result setBackColor:backColor];
	
	return [result autorelease];	
}

//---------------------------------------------------------- 
// dealloc
//---------------------------------------------------------- 
- (void)dealloc
{
    [self setGradient:nil];
    [self setColor:nil];
    [self setBackColor:nil];
	[self setImage:nil];

    [super dealloc];
}

- (void)drawInRect:(NSRect)rect rotation:(float)rotation;
{
	SGS;
	[NSGraphicsContext rotateContext:rotation inRect:rect];			
	[self drawInRect:rect];
	RGS;
}

- (void)drawInRect:(NSRect)rect;
{
	NSRect drawRect = rect;
	
	if (NSWidth(drawRect) > 0)
	{
		[self setImageHeight:MAX(1, drawRect.size.height)];
		
		NSImage* image = [self image];
		
		NSRect imageRect = NSZeroRect;
		imageRect.size = [image size];
		
		[image drawInRectHQ:drawRect fromRect:imageRect operation:NSCompositeSourceOver fraction:1];
	}
}

- (void)drawInPath:(NSBezierPath*)path inRect:(NSRect)inRect rotation:(float)rotation;
{
	SGS;
	[NSGraphicsContext rotateContext:rotation inRect:inRect];			
	[self drawInPath:path];
	RGS;
}

- (void)drawInPath:(NSBezierPath*)path;
{	
	[self drawInPath:path inRect:NSZeroRect];
}

- (void)drawInPath:(NSBezierPath*)path inRect:(NSRect)inRect;
{
	if (NSIsEmptyRect(inRect))
		inRect = [path bounds];

	SGS;
		
	[path addClip];
	[self drawInRect:inRect];
	
	RGS;
}

//---------------------------------------------------------- 
//  gradient 
//---------------------------------------------------------- 
- (NTGradient *)gradient
{
    return mv_gradient; 
}

- (void)setGradient:(NTGradient *)theGradient
{
    if (mv_gradient != theGradient) {
        [mv_gradient release];
        mv_gradient = [theGradient retain];
		
		// reset image
		[self setImage:nil];
    }
}

//---------------------------------------------------------- 
//  color 
//---------------------------------------------------------- 
- (NSColor *)color
{
    return mv_color; 
}

- (void)setColor:(NSColor *)theColor
{
    if (mv_color != theColor) {
        [mv_color release];
        mv_color = [theColor retain];
		
		// reset image
		[self setImage:nil];
    }
}

//---------------------------------------------------------- 
//  backColor 
//---------------------------------------------------------- 
- (NSColor *)backColor
{
    return mBackColor; 
}

- (void)setBackColor:(NSColor *)theBackColor
{
    if (mBackColor != theBackColor) {
        [mBackColor release];
        mBackColor = [theBackColor retain];
		
		// reset image
		[self setImage:nil];
    }
}

@end

@implementation NTGradientImage (Private)

//---------------------------------------------------------- 
//  imageHeight 
//---------------------------------------------------------- 
- (int)imageHeight
{
    return mv_imageHeight;
}

- (void)setImageHeight:(int)theImageHeight
{
    mv_imageHeight = theImageHeight;
	
	// reset image if height has changed
	if (mv_imageHeight != [[self image] size].height)
		[self setImage:nil];
}

//---------------------------------------------------------- 
//  image 
//---------------------------------------------------------- 
- (NSImage *)image;
{
	if (!mv_image)
		[self setImage:[[self gradient] imageWithSize:NSMakeSize(kImageWidth, [self imageHeight]) color:[self color] backColor:[self backColor]]];
	
    return mv_image; 
}

- (void)setImage:(NSImage *)theImage
{
    if (mv_image != theImage) {
        [mv_image release];
        mv_image = [theImage retain];
    }
}

@end


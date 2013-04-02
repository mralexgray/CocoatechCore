//
//  NSImage-NTExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on Tue Nov 11 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (NTExtensions)
- (void)tileInView:(NSView*)view;
- (void)tileInView:(NSView*)view fraction:(float)fraction;
- (void)tileInView:(NSView*)view fraction:(float)fraction clipRect:(NSRect)clipRect;

- (void)tileInRect:(NSRect)rect isFlipped:(BOOL)isFlipped operation:(NSCompositingOperation)operation fraction:(float)fraction;

// drawInRect that turns on NSImageInterpolationHigh
- (void)drawInRectHQ:(NSRect)rect fromRect:(NSRect)fromRect operation:(NSCompositingOperation)op fraction:(float)delta;
- (void)compositeToPointHQ:(NSPoint)point operation:(NSCompositingOperation)op fraction:(float)delta;
- (void)drawCenteredInRectHQ:(NSRect)rect operation:(NSCompositingOperation)op fraction:(float)delta;

// centers the image within the rect
- (void)compositeInRect:(NSRect)frame operation:(NSCompositingOperation)op flipped:(BOOL)flipped fraction:(float)fraction;

- (NSImage*)copyImageWithShadow:(NSShadow*)shadow;
- (NSImage *)monochromeImage;

- (NSImage *)normalizeSize;
- (NSImage*)coloredImage:(NSColor*)color;
- (NSImage*)imageWithAlpha:(float)theAlpha;
- (NSImage*)imageWithBackground:(NSColor*)backColor;

- (NSData *)bmpData;
- (NSImageRep *)imageRepOfClass:(Class)imageRepClass;

- (NSImage*)sizeIcon:(int)size;
- (NSImage*)imageWithSize:(NSSize)theSize;
- (NSImage*)imageWithSize:(NSSize)theSize scaleLarger:(BOOL)scaleLarger;
- (NSImage*)imageWithTopMargin:(int)topMargin;

- (NSBitmapImageRep*)bitmapImageRepForSize:(int)size;

- (BOOL)hasCachedImageRep;
- (NSImage*)imageWithOnlyCachedImageRep;

- (NSImage*)imageWithMaxSize:(int)maxSize;

// returns a new image but that has toggled it's flipped state
- (NSImage*)flip;

- (void)drawFlippedInRect:(NSRect)rect fromRect:(NSRect)sourceRect operation:(NSCompositingOperation)op fraction:(float)delta;
- (void)drawFlippedInRect:(NSRect)rect fromRect:(NSRect)sourceRect operation:(NSCompositingOperation)op;
- (void)drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op fraction:(float)delta;
- (void)drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op;

	// must release
+ (CGImageRef)CGImageFromData:(NSData*)data;
+ (CGImageRef)CGImageFromNSImage:(NSImage*)image;
+ (NSImage*)imageFromCGImageRef:(CGImageRef)image;

- (NSImage*)imageWithControlImage:(NSImage*)image;

// cell template drawing
- (void)drawInRect:(NSRect)rect
			inView:(NSView*)controlView
	   highlighted:(BOOL)highlighted
   backgroundStyle:(NSBackgroundStyle)backgroundStyle;

@end

@interface NSImage (StandardImages)
+ (NSImage*)stopImage:(NSRect)rect backColor:(NSColor*)backColor lineColor:(NSColor*)lineColor;
+ (NSImage*)stopInteriorImage:(NSRect)bounds lineColor:(NSColor*)lineColor;

+ (NSImage*)plusImage:(NSRect)rect backColor:(NSColor*)backColor lineColor:(NSColor*)lineColor;
+ (NSImage*)plusInteriorImage:(NSRect)bounds lineColor:(NSColor*)lineColor;

+ (NSImage*)minusImage:(NSRect)rect backColor:(NSColor*)backColor lineColor:(NSColor*)lineColor;
+ (NSImage*)minusInteriorImage:(NSRect)bounds lineColor:(NSColor*)lineColor;
@end

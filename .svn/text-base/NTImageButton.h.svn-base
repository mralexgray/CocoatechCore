//
//  NTImageButton.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 7/24/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTImageButton : NSButton
{
    BOOL mv_mouseOver;
	
	NSMenu* menu;
	
	NSImage* dimmedImage;
	NSImage* normalImage;
	NSImage* mMouseOverImage;
	NSImage* clickedImage;
}

@property (retain) NSMenu* menu;
@property (retain) NSImage* clickedImage;
@property (retain) NSImage* normalImage;
@property (retain) NSImage* dimmedImage;

+ (NTImageButton*)button:(NSImage*)image 
		  mouseOverImage:(NSImage*)mouseOverImage;  // creates dimmed image internally

+ (NTImageButton*)button:(NSImage*)image 
		  mouseOverImage:(NSImage*)mouseOverImage
		  dimmedImage:(NSImage*)dimmedImage;

// returns the image size, make sure the button is at least this big so it doesn't scale
- (NSSize)size;

@end

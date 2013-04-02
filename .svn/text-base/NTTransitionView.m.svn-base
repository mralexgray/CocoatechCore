//
//  NTTransitionView.m
//  Path Finder
//
//  Created by Steve Gehrman on 7/24/08.
//  Copyright 2008 Cocoatech. All rights reserved.
//

#import "NTTransitionView.h"
#import "NSView-CoreExtensions.h"

@implementation NTTransitionView

@synthesize imageView;
@synthesize newImageView, delegate;

+ (NTTransitionView*)transitionView:(NSView*)theView 
							newView:(NSView*)theNewView
						   delegate:(id<NTTransitionViewDelegateProtocol>)theDelegate;
{
	NSRect theFrame = [theView frame]; // assume first view is correct frame
	NTTransitionView* result = [[NTTransitionView alloc] initWithFrame:theFrame];
	
	result.delegate = theDelegate;
	
	// set second view to same frame
	[theNewView setFrame:theFrame];
	
	// make images of the views
	result.imageView = [[[NSImageView alloc] initWithFrame:theFrame] autorelease];
	[result.imageView setImage:[theView viewImage:NSZeroRect]];
	
	result.newImageView = [[[NSImageView alloc] initWithFrame:theFrame] autorelease];
	[result.newImageView setImage:[theNewView viewImage:NSZeroRect]];

	[result addSubview:result.imageView];
	
	[result setWantsLayer:YES];
	CATransition* theTransition = [[[CATransition alloc] init] autorelease];
	[theTransition setType:kCATransitionFade];
	[theTransition setSubtype:kCATransitionFromRight];
	theTransition.delegate = result;
	[theTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[result setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:theTransition, @"subviews", nil]];
	
	return [result autorelease];
}

- (BOOL)isOpaque;
{
	return YES;
}

- (void)viewDidMoveToWindow;
{
	if (self.window)
	{
		[self setNeedsDisplay:YES];
		[self displayIfNeeded];
		
		[self.animator addSubview:self.newImageView];
		[self.imageView removeFromSuperview];
	}
}

//---------------------------------------------------------- 
// dealloc
//---------------------------------------------------------- 
- (void)dealloc
{
	if (self.delegate)
		[NSException raise:@"clear the delegate" format:@"%@", NSStringFromClass([self class])];
	
    self.imageView = nil;
    self.newImageView = nil;
	
    [super dealloc];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag 
{
	// animation is retaining us
	[self setAnimations:nil];
	
	[self.delegate transitionViewDone:self];
	
	self.delegate = nil; // one shot
}

@end

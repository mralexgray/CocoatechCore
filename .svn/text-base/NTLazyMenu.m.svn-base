//
//  NTLazyMenu.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 12/20/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import "NTLazyMenu.h"
#import "NSMenuItem-NTExtensions.h"

@implementation NTLazyMenu

+ (NTLazyMenu*)lazyMenu:(NSString*)title target:(id)target action:(SEL)action;
{
	NTLazyMenu *result = [[self alloc] initWithTitle:title ? title : @""];  // don't pass nil to initWithTitle
	
	[result setDelegate:result];
	[result setTarget:target];
	[result setAction:action];
	[result setAutoenablesItems:NO];
	[result setFontSize:kDefaultMenuFontSize];
	[result setIconSize:kDefaultMenuIconSize];

	return [result autorelease];
}

- (void)dealloc;
{
	[self setDelegate:nil];
	
	[super dealloc];	
}

- (id)copyWithZone:(NSZone *)zone;
{
	NTLazyMenu *copy = [super copyWithZone:zone];
	
	// must set delegate to self
	[copy setDelegate:copy];

	[copy setTarget:[self target]];
	[copy setAction:[self action]];
	[copy setBuildID:[self buildID]];
	[copy setFontSize:[self fontSize]];
	[copy setIconSize:[self iconSize]];

	return copy;
}

- (id)target
{
    return mv_target; 
}

- (void)setTarget:(id)theTarget
{
	mv_target = theTarget; // not retained
}

- (SEL)action
{
    return mv_action;
}

- (void)setAction:(SEL)theAction
{
    mv_action = theAction;
}

- (unsigned)buildID;
{
	return mv_buildID;
}

- (void)setBuildID:(unsigned)set;
{
	mv_buildID = set;
}

//---------------------------------------------------------- 
//  fontSize 
//---------------------------------------------------------- 
- (int)fontSize
{
    return mFontSize;
}

- (void)setFontSize:(int)theFontSize
{
    mFontSize = theFontSize;
}

//---------------------------------------------------------- 
//  iconSize 
//---------------------------------------------------------- 
- (int)iconSize
{
    return mIconSize;
}

- (void)setIconSize:(int)theIconSize
{
    mIconSize = theIconSize;
}

@end

@implementation NTLazyMenu (Protocols)

- (void)menuNeedsUpdate:(NSMenu*)menu;
{
	// subclass
}

@end


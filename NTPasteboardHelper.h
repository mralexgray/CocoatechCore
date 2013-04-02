//
//  NTPasteboardHelper.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 11/10/08.
//  Copyright 2008 Cocoatech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol NTPasteboardHelperOwnerProtocol <NSObject>
- (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSString *)type;
@end

@interface NTPasteboardHelper : NSObject
{
    NSMutableDictionary *typeToOwner;
    unsigned int responsible;
    NSPasteboard *pasteboard;
	NSString* notificationName;  // sends when owner changes
}

@property (retain) NSMutableDictionary *typeToOwner;
@property (assign) unsigned int responsible;
@property (retain) NSPasteboard *pasteboard;
@property (retain) NSString* notificationName;  // notifies before being deleted

+ (NTPasteboardHelper *)helperWithPasteboard:(NSPasteboard *)newPasteboard;

- (void)declareTypes:(NSArray *)someTypes owner:(id<NTPasteboardHelperOwnerProtocol>)anOwner;
- (void)addTypes:(NSArray *)someTypes owner:(id<NTPasteboardHelperOwnerProtocol>)anOwner;

@end

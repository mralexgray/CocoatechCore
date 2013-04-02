//
//  NSSavePanel-NTExtensions.h
//  CocoatechCore
//
//  Created by Steve Gehrman on 10/31/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSSavePanel (NTExtensions)
- (BOOL)handleSavePanelOK:(int)returnCode;
@end

#if NOTSNOWLEOPARD

@interface NSSavePanel (Undocumented)
- (BOOL)showsHiddenFiles;
- (void)setShowsHiddenFiles:(BOOL)flag;
@end

#endif
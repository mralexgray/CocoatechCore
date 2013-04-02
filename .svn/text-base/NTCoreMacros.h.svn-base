/*
 *  NTCoreMacros.h
 *  CocoatechCore
 *
 *  Created by Steve Gehrman on 10/6/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */

// This macro ensures that we call [super initialize] in our +initialize (since this behavior is necessary for some classes in Cocoa), but it keeps custom class initialization from executing more than once.
#define NTINITIALIZE \
do { \
	static BOOL hasBeenInitialized = NO; \
        [super initialize]; \
			if (hasBeenInitialized) \
				return; \
					hasBeenInitialized = YES;\
} while (0);

// use for method tracing
#define IN_M NSLog(@"in: [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#define OUT_M NSLog(@"out: [%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

#define NOW_M NSLog(@"%@", [NSString stringWithFormat:@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]);

// window macros

#define DISABLE_FLUSH_WINDOW(window_param) BOOL local_restoreFlushWindow = NO; \
if (![window_param isFlushWindowDisabled]) \
{ \
    [window_param disableFlushWindow]; \
        local_restoreFlushWindow = YES; \
} 

#define ENABLE_FLUSH_WINDOW(window_param) if (local_restoreFlushWindow) { \
	[window_param enableFlushWindow]; }

#define NOTSNOWLEOPARD MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_5
#define SNOWLEOPARD MAC_OS_X_VERSION_MAX_ALLOWED > MAC_OS_X_VERSION_10_5

// some empty protocols for compiling under SnowLeopard
#if NOTSNOWLEOPARD
@protocol NSTableViewDelegate <NSObject> @end
@protocol NSSpeechSynthesizerDelegate <NSObject> @end
@protocol NSTextViewDelegate <NSObject> @end
@protocol NSMenuDelegate <NSObject> @end
@protocol NSAnimationDelegate <NSObject> @end
@protocol NSXMLParserDelegate <NSObject> @end
@protocol NSToolbarDelegate <NSObject> @end
@protocol NSMetadataQueryDelegate <NSObject> @end
@protocol NSNetServiceDelegate <NSObject> @end
@protocol NSNetServiceBrowserDelegate <NSObject> @end
@protocol NSSplitViewDelegate <NSObject> @end
@protocol NSOutlineViewDelegate <NSObject> @end
@protocol NSBrowserDelegate <NSObject> @end
@protocol NSTabViewDelegate <NSObject> @end
@protocol NSLayoutManagerDelegate <NSObject> @end
@protocol NSOutlineViewDataSource <NSObject> @end
@protocol NSTableViewDataSource <NSObject> @end
@protocol NSTextFieldDelegate <NSObject> @end
@protocol NSWindowDelegate <NSObject> @end
@protocol NSDrawerDelegate <NSObject> @end
#endif


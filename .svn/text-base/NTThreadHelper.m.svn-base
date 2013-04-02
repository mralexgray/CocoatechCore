//
//  NTThreadHelper.m
//  CocoatechCore
//
//  Created by Steve Gehrman on 5/22/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "NTThreadHelper.h"

const NSTimeInterval kThreadTimeElapsedInterval = .25;

// NSConditionLock states
typedef enum NTThreadHelperState
{
	kNTRunningThreadState=1,
	kNTPausedThreadState
} NTThreadHelperState;

@interface NTThreadHelper (Private)
- (NSMutableArray *)queue;
- (void)setQueue:(NSMutableArray *)theQueue;

- (NSConditionLock *)conditionLock;
- (void)setConditionLock:(NSConditionLock *)theConditionLock;

- (NSDate *)lastSentProgressDate;
- (void)setLastSentProgressDate:(NSDate *)theLastSentProgressDate;
@end

@implementation NTThreadHelper

- (void)dealloc;
{
	[self setConditionLock:nil];
	[self setLastSentProgressDate:nil];
	[self setQueue:nil];
	
	[super dealloc];
}

+ (NTThreadHelper*)threadHelper;
{
	NTThreadHelper* result = [[NTThreadHelper alloc] init];

	[result setConditionLock:[[[NSConditionLock alloc] initWithCondition:kNTRunningThreadState] autorelease]];
	[result setLastSentProgressDate:[NSDate date]];
	
	return [result autorelease];
}

- (void)pause;
{
	// pause thread, tell delegate, delegate asks user and restarts this thread
	if ([[self conditionLock] tryLockWhenCondition:kNTRunningThreadState])
		[[self conditionLock] unlockWithCondition:kNTPausedThreadState];	
}

- (void)wait;
{
	// wait until the lock is set to normal (pauses thread)
	[[self conditionLock] lockWhenCondition:kNTRunningThreadState];
	[[self conditionLock] unlockWithCondition:kNTRunningThreadState];
}

- (void)resume;
{
	// if paused, set back to normal
	if ([[self conditionLock] tryLockWhenCondition:kNTPausedThreadState])
		[[self conditionLock] unlockWithCondition:kNTRunningThreadState];
}

// simple queue, adding unlocks thread, thread waits for data
- (void)addToQueue:(id)obj;
{
	[[self conditionLock] lock];
	
	if (![self queue])
		[self setQueue:[NSMutableArray array]];
	
	[[self queue] addObject:obj];
	
	// unlocks waiting thread
	[[self conditionLock] unlockWithCondition:kNTRunningThreadState];
}

// will wait if no data
- (id)nextInQueue;
{
	id result=nil;

	if (![self killed])
	{
		int newCondition = kNTPausedThreadState;
		
		[[self conditionLock] lockWhenCondition:kNTRunningThreadState];
		{
			if (![self killed])
			{
				NSMutableArray *queue = [self queue];
				if ([queue count])
				{
					result = [queue objectAtIndex:0];
					
					// before we remove, make sure it doesn't go away
					[[result retain] autorelease];
					
					[queue removeObjectAtIndex:0];
				}
				
				// continue thread if still more pending requests
				if ([queue count])
					newCondition = kNTRunningThreadState;
			}
		}
		[[self conditionLock] unlockWithCondition:newCondition];
	}
	
	return result;
}

- (BOOL)timeHasElapsed;
{
	return [self timeHasElapsed:kThreadTimeElapsedInterval];
}

- (BOOL)timeHasElapsed:(NSTimeInterval)timeInterval;
{
	BOOL result = NO;
	
	@synchronized(self) {
		if (-[[self lastSentProgressDate] timeIntervalSinceNow] >= timeInterval)
		{
			result = YES;
			
			NSDate* newDate = [[NSDate alloc] init];  // avoiding autorelease pool in thread
			[self setLastSentProgressDate:newDate];
			[newDate release];
		}
	}
	
	return result;
}

- (BOOL)killed:(unsigned*)count;
{
	BOOL result = NO;
	
	(*count)++; // increment
	if ((*count) > 5)
	{
		(*count) = 0;
		
		result = [self killed];
	}
	
	return result;
}

//---------------------------------------------------------- 
//  killed 
//---------------------------------------------------------- 
- (BOOL)killed
{
	BOOL result=NO;
	
	@synchronized(self) {
		result = mv_killed;
	}
	
	return result;
}

- (void)setKilled:(BOOL)flag
{
	@synchronized(self) {
		mv_killed = flag;
	}
}

//---------------------------------------------------------- 
//  complete 
//---------------------------------------------------------- 
- (BOOL)complete
{
	BOOL result=NO;
	
	@synchronized(self) {
		result = mv_complete;
	}
	
	return result;
}

- (void)setComplete:(BOOL)flag
{
	@synchronized(self) {
		mv_complete = flag;
	}
}

@end

@implementation NTThreadHelper (Private)

//---------------------------------------------------------- 
//  queue 
//---------------------------------------------------------- 
- (NSMutableArray *)queue
{
    return mv_queue; 
}

- (void)setQueue:(NSMutableArray *)theQueue
{
    if (mv_queue != theQueue) {
        [mv_queue release];
        mv_queue = [theQueue retain];
    }
}

//---------------------------------------------------------- 
//  condition 
//---------------------------------------------------------- 
- (NSConditionLock *)conditionLock
{
    return mv_conditionLock; 
}

- (void)setConditionLock:(NSConditionLock *)theConditionLock
{
    if (mv_conditionLock != theConditionLock) {
        [mv_conditionLock release];
        mv_conditionLock = [theConditionLock retain];
    }
}

//---------------------------------------------------------- 
//  lastSentProgressDate 
//---------------------------------------------------------- 
- (NSDate *)lastSentProgressDate
{
    return mv_lastSentProgressDate; 
}

- (void)setLastSentProgressDate:(NSDate *)theLastSentProgressDate
{
    if (mv_lastSentProgressDate != theLastSentProgressDate) {
        [mv_lastSentProgressDate release];
        mv_lastSentProgressDate = [theLastSentProgressDate retain];
    }
}

@end


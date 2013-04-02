//
//  NTSizeFormatter.m
//  CocoatechCore
//
//  Created by Steve Gehrman on Thu Feb 27 2003.
//  Copyright (c) 2003 CocoaTech. All rights reserved.
//

#import "NTSizeFormatter.h"

@interface NTSizeFormatter (Private)
- (NSNumberFormatter *)numFormatter;
- (void)setNumFormatter:(NSNumberFormatter *)theNumFormatter;

- (NSString *)byteUnit;
- (void)setByteUnit:(NSString *)theByteUnit;

- (NSString *)kiloUnit;
- (void)setKiloUnit:(NSString *)theKiloUnit;

- (NSString *)megaUnit;
- (void)setMegaUnit:(NSString *)theMegaUnit;

- (NSString *)gigaUnit;
- (void)setGigaUnit:(NSString *)theGigaUnit;
@end

static const UInt64 oneK = 1024;
static const UInt64 oneMegabyte = 1024 * 1024;
static const UInt64 oneGigabyte = 1024 * 1024 * 1024;

@implementation NTSizeFormatter

NTSINGLETON_INITIALIZE;
NTSINGLETONOBJECT_STORAGE;

- (id)init
{
    self = [super init];

	[self setByteUnit:[NTLocalizedString localize:@"bytes" table:@"CocoaTechBase"]];
    [self setKiloUnit:@"KB"];
    [self setMegaUnit:@"MB"];
    [self setGigaUnit:@"GB"];	
	
    return self;
}

- (void)dealloc
{
    [self setNumFormatter:nil];
    [self setByteUnit:nil];
    [self setKiloUnit:nil];
    [self setMegaUnit:nil];
    [self setGigaUnit:nil];
	
    [super dealloc];
}

- (NSString *)fileSize:(UInt64)numBytes;
{
	return [self fileSize:numBytes allowBytes:YES];
}

- (NSString *)fileSize:(UInt64)numBytes
			allowBytes:(BOOL)allowBytes; // allowBytes == NO means 512 bytes will be .5 KB
{
	NTSizeUnit unit;
    NSString* result = [self fileSize:numBytes outUnit:&unit allowBytes:allowBytes];

	// append unit
    result = [result stringByAppendingFormat:@" %@", [self stringForUnit:unit]];

    return result;
}

- (NSString*)fileSizeInBytes:(UInt64)numBytes;
{
    NSString* result = [self numberString:numBytes];
	
	result = [result stringByAppendingFormat:@" %@", [self stringForUnit:kByteUnit]];
	
	return result;
}

- (NSString*)numberString:(UInt64)number;
{
    NSString* result = [[self numFormatter] stringForObjectValue:[NSNumber numberWithUnsignedLongLong:number]];
		
	return result;
}

- (NSString*)sizeString:(NSSize)size;
{
	return [NSString stringWithFormat:@"%@ x %@", [[self numFormatter] stringForObjectValue:[NSNumber numberWithFloat:size.width]], [[self numFormatter] stringForObjectValue:[NSNumber numberWithFloat:size.height]]];
}

- (NSString *)fileSize:(UInt64)numBytes
			   outUnit:(NTSizeUnit*)outUnit 
			allowBytes:(BOOL)allowBytes; // use can append the unit themselves
{
    NSString* result;
    float fraction=0.0;
    UInt64 bytes;
    NTSizeUnit unit;
	
    // need to return bytes if less than a megabyte
    if ((numBytes < oneK) && allowBytes)
	{
        unit = kByteUnit;
		bytes = numBytes;
	}
    else if (numBytes < oneMegabyte)  // kilo bytes
    {
        bytes = numBytes/oneK;		
		fraction = U64Mod(numBytes,oneK);
		fraction = fraction / oneK;
		
		unit = kKiloBytesUnit;
    }
    else if (numBytes < oneGigabyte)  // mega bytes
    {
        bytes = numBytes/oneMegabyte;
		fraction = U64Mod(numBytes,oneMegabyte);
		fraction = fraction / oneMegabyte;

        unit = kMegaBytesUnit;
    }
    else // giga bytes
    {
        bytes = numBytes/oneGigabyte;
		fraction = U64Mod(numBytes,oneGigabyte);
		fraction = fraction / oneGigabyte;

        unit = kGigaBytesUnit;
    }
	
    result = [[NSNumber numberWithUnsignedLong:bytes] stringValue];
	
	int fract = (fraction*10);
	if (fract != 0)
		result = [result stringByAppendingFormat:@".%d",fract];
		
	if (outUnit)
		*outUnit = unit;
	
    return result;
}


- (NSString *)stringForUnit:(NTSizeUnit)unit;
{
	switch (unit)
	{
		case kByteUnit:
			return [self byteUnit];
		case kKiloBytesUnit:
			return [self kiloUnit];
		case kMegaBytesUnit:
			return [self megaUnit];
		case kGigaBytesUnit:
			return [self gigaUnit];
	}
	
	return @"";
}

@end

@implementation NTSizeFormatter (Private)

//---------------------------------------------------------- 
//  numFormatter 
//---------------------------------------------------------- 
- (NSNumberFormatter *)numFormatter
{
	if (!mNumFormatter)
	{
		NSNumberFormatter* formatter = [[[NSNumberFormatter alloc] init] autorelease];
		[formatter setFormat:@"#,##0.##"];
		[self setNumFormatter:formatter];		
	}
	
    return mNumFormatter; 
}

- (void)setNumFormatter:(NSNumberFormatter *)theNumFormatter
{
    if (mNumFormatter != theNumFormatter) {
        [mNumFormatter release];
        mNumFormatter = [theNumFormatter retain];
    }
}

//---------------------------------------------------------- 
//  byteUnit 
//---------------------------------------------------------- 
- (NSString *)byteUnit
{
    return mByteUnit; 
}

- (void)setByteUnit:(NSString *)theByteUnit
{
    if (mByteUnit != theByteUnit) {
        [mByteUnit release];
        mByteUnit = [theByteUnit retain];
    }
}

//---------------------------------------------------------- 
//  kiloUnit 
//---------------------------------------------------------- 
- (NSString *)kiloUnit
{
    return mKiloUnit; 
}

- (void)setKiloUnit:(NSString *)theKiloUnit
{
    if (mKiloUnit != theKiloUnit) {
        [mKiloUnit release];
        mKiloUnit = [theKiloUnit retain];
    }
}

//---------------------------------------------------------- 
//  megaUnit 
//---------------------------------------------------------- 
- (NSString *)megaUnit
{
    return mMegaUnit; 
}

- (void)setMegaUnit:(NSString *)theMegaUnit
{
    if (mMegaUnit != theMegaUnit) {
        [mMegaUnit release];
        mMegaUnit = [theMegaUnit retain];
    }
}

//---------------------------------------------------------- 
//  gigaUnit 
//---------------------------------------------------------- 
- (NSString *)gigaUnit
{
    return mGigaUnit; 
}

- (void)setGigaUnit:(NSString *)theGigaUnit
{
    if (mGigaUnit != theGigaUnit) {
        [mGigaUnit release];
        mGigaUnit = [theGigaUnit retain];
    }
}

@end


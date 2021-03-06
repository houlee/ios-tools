//
//  DataReadStream.m
//  ConnectTest
//
//  Created by Kiefer on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_DataReadStream.h"
#import "GC_NSData+AESCrypt.h"

@implementation GC_DataReadStream

@synthesize data, offset;

- (void)dealloc
{
    [data release];
    [super dealloc];
}

- (id)initWithData:(NSData *)_data
{
    if ((self = [super init])) {
        self.data = [NSData dataWithData:_data];
        self.offset = 0;
    }
    return self;
}

- (UInt8)readByte
{
    UInt8 b1;
    UInt32 len = 1;
    if ((offset + len) > self.length) return 0;
    [data getBytes:&b1 range:NSMakeRange(offset, len)];
    offset = offset + len;
    return b1;
}

- (UInt16)readShort
{
    UInt16 b1 = ([self readByte] << 8) & 0xFF00;
    UInt16 b2 =  [self readByte]       & 0x00FF;
    return b1 | b2;
}

- (UInt32)readInt
{
    UInt32 b1 = ([self readByte] << 24) & 0xFF000000;
    UInt32 b2 = ([self readByte] << 16) & 0x00FF0000;
    UInt32 b3 = ([self readByte] << 8)  & 0x0000FF00;
    UInt32 b4 =  [self readByte]        & 0x000000FF;
    return b1 | b2 | b3 | b4;
}

- (NSString *)readComposString1
{
    UInt8 len = [self readByte];
    if ((offset + len) > self.length) return nil;
    NSData *strData = [self.data subdataWithRange:NSMakeRange(offset, len)];
    NSString *str = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
    offset = offset + len;
    return str;
}



- (NSString *)readComposString1WithAES256DecryptKey:(NSString*)key
{
    UInt8 len = [self readByte];
    if ((offset + len) > self.length) return nil;
    NSData *strData = [self.data subdataWithRange:NSMakeRange(offset, len)];
    strData = [strData AES256DecryptCaiPiao365WithKey:key];
    NSString *str = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
    offset = offset + len;
    return str;
}

- (NSString *)readComposString2
{
    UInt16 len = [self readShort];
    if ((offset + len) > self.length) return nil;
    NSData *strData = [self.data subdataWithRange:NSMakeRange(offset, len)];
    NSString *str = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
    offset = offset + len;
    return str;
}

- (NSString *)readComposString4
{
    UInt32 len = [self readInt];
    if ((offset + len) > self.length) return nil;
    NSData *strData = [self.data subdataWithRange:NSMakeRange(offset, len)];
    NSString *str = [[[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding] autorelease];
    offset = offset + len;
    return str;
}

- (GC_DataReadStream *)read:(NSUInteger)len
{
    if ((offset + len) > self.length) return nil;
    NSData *_data = [self.data subdataWithRange:NSMakeRange(offset, len)];
    GC_DataReadStream *drs = [[[GC_DataReadStream alloc] initWithData:_data] autorelease];
    offset = offset + (int)len;
    return drs;
}
- (NSData *)readComposData4{
    UInt32 len = [self readInt];
    if ((offset + len) > self.length) return nil;
    NSData *strData = [self.data subdataWithRange:NSMakeRange(offset, len)];
    offset = offset + len;
    return strData;
}

- (NSUInteger)length
{
    return [self.data length];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
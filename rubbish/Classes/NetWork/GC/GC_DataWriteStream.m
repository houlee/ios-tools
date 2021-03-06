//
//  DataWriteStream.m
//  ConnectTest
//
//  Created by Kiefer on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_DataWriteStream.h"
#import "GC_Utilities.h"
#import "GC_NSData+AESCrypt.h"

@implementation GC_DataWriteStream

@synthesize data;

- (void)dealloc
{
    [data release];
    [super dealloc];
}

- (id)init
{
    if ((self = [super init])) {
        self.data = [NSMutableData data];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)numItems
{
    if ((self = [super init])) {
        self.data = [NSMutableData dataWithCapacity:numItems];
    }
    return self;
}

- (id)initWithDataWriteStream:(GC_DataWriteStream *)dws
{
    if ((self = [super init])) {
        self.data = [NSMutableData dataWithData:dws.data];
    }
    return self;
}

- (void)writeByte:(UInt8)_byte
{
    UInt8 b = _byte;
    [self.data appendBytes:&b length:sizeof(b)];
}

- (void)writeShort:(UInt16)_short
{ 
    UInt16 s = _short;
    s = [GC_Utilities reverseUInt16:s];
    [self.data appendBytes:&s length:sizeof(s)];
}

- (void)writeInt:(UInt32)_int
{
    UInt32 i = _int;
    i = [GC_Utilities reverseUInt32:i];
    [self.data appendBytes:&i length:sizeof(i)];
}

- (void)appendString1n:(NSString *)str 
{
    NSData *_data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeByte:[_data length]];
    [self appendData:_data];
}

- (void)appendString2n:(NSString *)str 
{
    NSData *_data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeShort:[_data length]];
    [self appendData:_data];
}

- (void)appendString4n:(NSString *)str 
{
    NSData *_data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeInt:(UInt32)[_data length]];
    [self appendData:_data];
}

- (void)addField:(NSData *)_data 
{
    [self writeByte:[_data length]];
    [self appendData:_data];
}

- (void)addFieldShort:(NSData *)_data
{
    [self writeShort:[_data length]];
    [self appendData:_data];
}

- (void)addFieldInt:(NSData *)_data
{
    [self writeInt:(UInt32)[_data length]];
    [self appendData:_data];
}

- (void)appendData:(NSData *)other
{
    [self.data appendData:other];
}

- (void)appendString1n:(NSString *)str aes256EncryptKey:(NSString *)aeskey
{
    NSData *_data = [str dataUsingEncoding:(NSUTF8StringEncoding)];
    _data = [_data AES256EncryptCaiPiao365WithKey:aeskey];
    [self addField:_data];
}

- (void)appendString2n:(NSString *)str aes256EncryptKey:(NSString *)aeskey
{
    NSData *_data = [str dataUsingEncoding:(NSUTF8StringEncoding)];
    _data = [_data AES256EncryptCaiPiao365WithKey:aeskey];
    [self addFieldShort:_data];
}

- (NSUInteger)length
{
    return [self.data length];
}

+ (id)stream
{
    return [[[GC_DataWriteStream alloc] init] autorelease];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  DataWriteStream.h
//  ConnectTest
//
//  Created by Kiefer on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_DataWriteStream : NSObject 
{
    
}

@property (nonatomic, retain) NSMutableData *data;

- (id)initWithCapacity:(NSUInteger)numItems;
- (id)initWithDataWriteStream:(GC_DataWriteStream *)dws;
- (void)appendData:(NSData *)other;
- (NSUInteger)length;

- (void)writeByte:(UInt8)byte;
- (void)writeShort:(UInt16)_short;
- (void)writeInt:(UInt32)_int;
- (void)appendString1n:(NSString*)str;
- (void)appendString2n:(NSString*)str;
- (void)appendString4n:(NSString *)str;
- (void)addField:(NSData *)_data;
- (void)addFieldShort:(NSData *)_data;
- (void)addFieldInt:(NSData *)_data;
- (void)appendString1n:(NSString *)str aes256EncryptKey:(NSString *)aeskey;
- (void)appendString2n:(NSString *)str aes256EncryptKey:(NSString *)aeskey;

@end

@interface GC_DataWriteStream (DataWriteStreamCreation)
+ (id)stream;
@end
//
//  DataReadStream.h
//  ConnectTest
//
//  Created by Kiefer on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GC_DataReadStream : NSObject 
{
    NSData *data;
    UInt32 offset;
}

@property (nonatomic, retain) NSData *data;
@property (nonatomic) UInt32 offset; 

- (id)initWithData:(NSData *)_data;
- (UInt8)readByte;
- (UInt16)readShort;
- (UInt32)readInt;
- (NSString *)readComposString1;
- (NSString *)readComposString2;
- (NSString *)readComposString4;
- (NSString *)readComposString1WithAES256DecryptKey:(NSString*)key;
- (NSData *)readComposData4;
- (GC_DataReadStream *)read:(NSUInteger)_len;

- (NSUInteger)length;

//- (NSString *)areadComposString1WithAES256DecryptKey:(NSString*)key;

@end

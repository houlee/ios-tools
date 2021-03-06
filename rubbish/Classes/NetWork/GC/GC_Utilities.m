//
//  Utilities.m
//  ConnectTest
//
//  Created by Kiefer on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_Utilities.h"

@implementation GC_Utilities

+ (UInt16)reverseUInt16:(UInt16)b
{   
    UInt8 b2 = b & 0x00FF; // 8个1 保证低8位数据正确
    UInt8 b1 = b >> 8;
    return (b2 << 8) | b1;
}

+ (UInt32)reverseUInt32:(UInt32)b
{   
    UInt8 b4 = b & 0xFF;
    UInt8 b3 = (b & 0xFF00) >> 8;
    UInt8 b2 = (b & 0xFF0000) >> 16;
    UInt8 b1 = (b & 0xFF000000) >> 24;
    return (b4 << 24)|(b3 << 16)|(b2 << 8)|b1;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
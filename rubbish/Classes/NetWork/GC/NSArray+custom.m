//
//  NSArray+custom.m
//  Lottery
//
//  Created by Jacob Chiang on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSArray+custom.h"

@implementation NSArray (custom)


// 排序之后
-(NSArray*)afterInOder{
    
    if (self) {
        self = [self sortedArrayUsingFunction:compareWithInteger context:NULL];
    }
    return self;
}

#pragma mark 
// 数字递增 排序
NSInteger compareWithInteger(id num1, id num2, void *context)
{
    int value1 = (int)[num1 integerValue];
    int value2 = (int)[num2 integerValue];
    
    if (value1 < value2)
        return NSOrderedAscending;
    else  if (value1 > value2)
        return NSOrderedDescending;
    else return NSOrderedSame;
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
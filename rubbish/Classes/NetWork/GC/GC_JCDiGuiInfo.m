//
//  JCDiGuiInfo.m
//  Lottery
//
//  Created by Jacob Chiang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/**
 *  递归 计算得出 的竞彩  信息
 **/

#import "GC_JCDiGuiInfo.h"
#import "GC_LotteryUtil.h"

@implementation GC_JCDiGuiInfo

@synthesize currentValue;
@synthesize oldValue;
@synthesize itemsCount;
@synthesize canChooseCount;
@synthesize fristCanChooseCount;

- (void)dealloc {
    [super dealloc];
}

- (long long)canChooseCount:(long long)moldValue  currentValue:(long long)mcurrentValue {
    
    return [GC_LotteryUtil combination:moldValue :mcurrentValue];
}

- (long long)itemsReslut:(long long)mitemsCount currentValue:(long long)mcurrentValue {
    long long total = 1;
    for(int i = 0;i < mcurrentValue; i++) {
        total *= mitemsCount;
    }
    return total;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
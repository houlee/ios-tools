//
//  BetInfo.m
//  Lottery
//
//  Created by Teng Kiefer on 12-2-16.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_BetInfo.h"

@implementation GC_BetInfo

@synthesize lotteryId, issue, betNumber, endTime, schemeTitle, schemeDescription; 
@synthesize lotteryType;
@synthesize modeType;
@synthesize baomiType;
@synthesize bets, price, multiple, totalParts, rengouParts, baodiParts, tichengPercentage, secrecyType;
@synthesize prices, zhuihaoType, payMoney, betlist;
@synthesize caizhong,wanfa;
@synthesize stopMoney;
@synthesize  beishu, lastMatch;
- (void)dealloc
{
    [lastMatch release];
    [stopMoney release];
    [caizhong release];
    [wanfa release];
    [betlist release];
    
    [lotteryId release];
    [issue release];
    [betNumber release];
    [endTime release];
    [schemeTitle release];
    [schemeDescription release];
    [super dealloc];
}

//- (GC_BetInfo *)copySelf {
//    GC_BetInfo *betInfo = [[GC_BetInfo alloc] init];
//    betInfo.beishu = self.beishu;
//    betInfo.multiple = self.multiple;
//    betInfo.stopMoney = self.stopMoney;
//    betInfo.caizhong = self.caizhong;
//    betInfo.wanfa = self.wanfa;
//    betInfo.lotteryId = self.lotteryId;
//    betInfo.issue =self.issue;
//    betInfo.betNumber = self.betNumber;
//    return betInfo;
//}

- (void)setBeishu:(short)a {
	self.multiple = a;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
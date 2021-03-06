//
//  SchemeInfo.m
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchemeInfo.h"
#import "GC_RspError.h"

@implementation SchemeInfo

@synthesize schemeNumber, lotteryType, issue, speed, state, amount, schemeBlockingTime, initiator, surplusAmount, zhanji, initiatorID, initiatorName, baodi, shengyin, yuliustring;

- (void)dealloc {
    [yuliustring release];
    [initiatorName release];
    [initiatorID release];
    [zhanji release];
    [lotteryType release];
    [state release];
    [speed release];
    [amount release];
    [issue release];
    [initiator release];
    [schemeBlockingTime release];
    [baodi release];
    [super dealloc];
}

- (id)initWithDataReadStream:(GC_DataReadStream *)drs {
    if ((self = [super init])) {
        self.schemeNumber = [drs readInt];
        self.lotteryType = [drs readComposString2];
        self.state = [drs readComposString1];
        self.speed = [drs readComposString1];
        self.amount = [drs readComposString1];
        self.issue = [drs readComposString1];
        self.initiator = [drs readComposString1];
        self.initiatorName = [drs readComposString1];
        self.surplusAmount = [drs readInt];
        self.schemeBlockingTime = [drs readComposString1];
        self.zhanji = [drs readComposString1];
        self.initiatorID = [drs readComposString1];
        self.baodi = [drs readComposString1];
        self.shengyin = [drs readByte];
        self.yuliustring = [drs readComposString1];
        
        NSLog(@"============================");
        NSLog(@"彩种:%@", lotteryType);//
        NSLog(@"状态:%@", state);
        NSLog(@"进度:%@", speed);
        NSLog(@"金额:%@", amount);
        NSLog(@"期号:%@", issue); //
        NSLog(@"发起人:%@", initiator);
        NSLog(@"发起人用户名:%@", initiatorName);
        NSLog(@"方案截止日期:%@", schemeBlockingTime);
        NSLog(@"战绩:%@", zhanji);
        NSLog(@"发起人ID:%@", initiatorID);
        NSLog(@"是否保底:%@", baodi);
        NSLog(@"============================");
    }
    return self;
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
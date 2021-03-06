//
//  LotteryTime.m
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_LotteryTime.h"
#import "GC_RspError.h"

@implementation GC_LotteryTime

@synthesize returnID, lotteryType, lastLotteryNumber, currentStartTime, currentEndTime, currentIssue, systemTime, lotteryTime, currentSurplusTime;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        self.returnID = [drs readShort];
        
        if (![GC_RspError parserError:drs returnId:returnID WithRequest:request]) {
            self.systemTime = [drs readComposString1];
            self.lotteryType = [drs readShort];
            self.currentIssue = [drs readComposString1];
            self.lastLotteryNumber = [drs readComposString1];
            self.currentStartTime = [drs readComposString1];
            self.currentEndTime = [drs readComposString1];
            self.currentSurplusTime = [drs readComposString1];
            self.lotteryTime = [drs readComposString1];
            
            NSLog(@"系统时间:%@", systemTime);
            NSLog(@"当前期号:%@", currentIssue);
            NSLog(@"上期开奖号码:%@", lastLotteryNumber);
            NSLog(@"当期开始时间:%@", currentStartTime);
            NSLog(@"当期结束时间:%@", currentEndTime);
            NSLog(@"当期剩余时间:%@", currentSurplusTime);
            NSLog(@"开奖时间:%@", lotteryTime);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc {
    [systemTime release];
    [currentIssue release];
    [lastLotteryNumber release];
    [currentStartTime release];
    [currentEndTime release];
    [currentSurplusTime release];
    [lotteryTime release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
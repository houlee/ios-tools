
//
//  LotteryTime.h
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_LotteryTime : NSObject {
    NSInteger returnID;
    NSInteger lotteryType;
    NSString *systemTime;
    NSString *currentIssue;
    NSString *lastLotteryNumber;
    NSString *currentStartTime;
    NSString *currentEndTime;
    NSString *currentSurplusTime;
    NSString *lotteryTime;
}

@property(nonatomic, assign) NSInteger returnID, lotteryType;
@property(nonatomic, copy) NSString *systemTime, *currentIssue, *lastLotteryNumber, *currentStartTime, *currentEndTime, *currentSurplusTime, *lotteryTime;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;

@end
//
//  CheckAwardTime.h
//  Lottery
//
//  Created by jym on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//开奖时间查询
@interface GC_CheckAwardTime : NSObject {
    
    NSInteger returnId;             //返回消息id
    NSString *systemTime;           //系统时间
    NSInteger lotteryId;            //彩种
    NSString *curIssueNum;          //当前期号
    NSString *fAwardNumber;         //上期开奖号码
    NSString *curIssueTime;         //当期开始时间
    NSString *curEndTime;           //当期结束时间
    NSString *curYuTime;            //当期剩余时间
    NSString *awardTime;            //开奖时间
}

@property (nonatomic) NSInteger returnId, lotteryId;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSString *curIssueNum, *fAwardNumber, *curIssueTime, *curEndTime, *curYuTime, *awardTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

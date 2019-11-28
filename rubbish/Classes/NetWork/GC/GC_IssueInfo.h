//
//  IssueInfo.h
//  Lottery
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"

@interface GC_IssueInfo : NSObject
{
    NSInteger returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    NSInteger lotteryType; // 彩种
    NSInteger recordCount; // 记录返回条数
    NSMutableArray *issueRecordList; // 彩期记录
}

@property(nonatomic) NSInteger returnId, lotteryType, recordCount;
@property(nonatomic, copy) NSString *systemTime;
@property(nonatomic, retain) NSMutableArray *issueRecordList;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface IssueRecord : NSObject
{
    NSInteger returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    NSString *lotteryName; // 彩种名称
    NSString *curIssue; // 当前期号
    NSString *lastLotteryNumber; // 上期开奖号码
    NSString *curStartTime; // 当期开始时间
    NSString *curEndTime; // 当期结束时间
    NSString *remainingTime; // 当期剩余时间
    NSString *lotteryTime; // 开奖时间
    NSString * lotteryType; // 彩种类型
    NSString *lotteryId; // 彩种编号
    NSString *lotteryStatus; //彩期状态 1，在售期  0，预售期
    NSString *zhouqi;//彩种周期
    NSString *content;//彩种宣传语
    NSString *other;//预留字段
    NSString *huodongImage;//活动图片
    NSString * luckyNumber;//双色球幸运蓝球
    NSString * activity;//活动文字内容
    NSString * iconUrl;//icon地址
    NSString * h5Url;//跳转h5地址
}

@property(nonatomic, copy) NSString *lotteryName, *curIssue, *lastLotteryNumber, *curStartTime, *curEndTime, *remainingTime, *lotteryTime, *lotteryId, *lotteryStatus ,*zhouqi,*content,*other,*systemTime,*huodongImage, * luckyNumber, *activity, * iconUrl, * h5Url, * lotteryType;
@property(nonatomic) NSInteger returnId;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
+ (void)changeOld:(IssueRecord *)old Tonew:(IssueRecord *)newIssue;
@end

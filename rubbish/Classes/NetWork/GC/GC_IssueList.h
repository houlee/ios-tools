//
//  IssueList.h
//  Lottery
//
//  Created by Teng Kiefer on 12-1-14.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_IssueList : NSObject
{
    int returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    int lotteryId; // 彩种
    int issueCount; // 期次个数
    NSMutableArray *details; // detail列表
    NSString *defaultIssue; // 默认显示期号
    int sfIssueCount;//北单胜负期号个数
    NSMutableArray * sfDetails;//北单胜负期号列表
}

@property(nonatomic) int returnId, lotteryId, issueCount, sfIssueCount;
@property(nonatomic, copy) NSString *systemTime, *defaultIssue;
@property(nonatomic, retain) NSMutableArray *details, * sfDetails;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface IssueDetail : NSObject 
{
	NSString *issue; // 期号
    NSString *stopTime; // 停售时间
    NSString *status; // 期次状态 1当前期 0预售期 3已停售
    NSString * danTuoTime;//胆拖时间
}

@property(nonatomic, copy) NSString *issue, *stopTime, *status, *danTuoTime;

@end
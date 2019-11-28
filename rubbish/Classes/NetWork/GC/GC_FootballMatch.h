//
//  FootballMatch.h
//  Lottery
//
//  Created by Teng Kiefer on 12-1-14.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_FootballMatch : NSObject
{
    NSInteger returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    NSInteger matchCount; // 对阵列表数
    NSMutableArray *matchList; // 对阵列表
    NSString * dateString;//时间戳
    NSInteger update;//是否更新
}

@property(nonatomic) NSInteger returnId, matchCount, update;
@property(nonatomic, copy) NSString *systemTime, * dateString;
@property(nonatomic, retain) NSMutableArray *matchList;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface GC_MatchInfo : NSObject 
{
    NSString *identifier; //比赛序号
    NSString *leagueName; //赛事名称
    NSString *home; //主队
    NSString *homeID; //主队id
	NSString *away; //客队
    NSString *awayID; //客队id
    NSString *startTime; //比赛开始时间
    NSString *asianPanHome; //亚盘主队
    NSString *asianPanAway; //亚盘客队
    NSString *halfScore; //半场比分
    NSString *endScore; //最终比分
    NSString *isAssign; //是否受让
    NSString *assignCount; //让球
    NSString *eurPei; //欧赔
    NSString *matchStatus; //比赛状态
    NSString *isFinish; //是否结束
    NSString *asianPanID; //亚赔序号
    NSString *caiguo; //彩果
    
    NSString *asianPan; //亚盘
    NSString *selectNumber; //选中号码
    NSString *issueStatus; // 期次状态 1当前期 0预售期 3已停售
    NSString * zlcString;//中立场
}

@property(nonatomic, copy) NSString *identifier, *leagueName, *home, *homeID, *away, *awayID, *startTime, *asianPanHome, *asianPanAway, *halfScore, *endScore, *isAssign, *assignCount, *eurPei, *matchStatus, *isFinish, *asianPanID, *caiguo;
@property(nonatomic, copy) NSString *asianPan, *selectNumber, *issueStatus, * zlcString;

@end




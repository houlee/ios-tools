//
//  FootballMatch.m
//  Lottery
//
//  Created by Teng Kiefer on 12-1-14.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_FootballMatch.h"
#import "GC_DataReadStream.h"
#import "StringUtil.h"
#import "GC_RspError.h"

@implementation GC_FootballMatch

@synthesize returnId, systemTime, matchCount, matchList, update, dateString;

- (void)dealloc
{
    [dateString release];
    [systemTime release];
    [matchList release];
    [super dealloc];
}

// 1未（未开始）；2中（进行中，包括其他所有状态）；3完（比赛结束）；4断（比赛中断）；5取（比赛取消）
- (void)disposeMatchState:(GC_MatchInfo *)match
{
    switch (match.matchStatus.intValue)
    {
        case 17: //未
            match.matchStatus = [NSString stringWithFormat:@"1"];
            break;    
        case 4: //完
        case 10: //完
            match.matchStatus = [NSString stringWithFormat:@"3"];
            break;
        case 5: //断
            match.matchStatus = [NSString stringWithFormat:@"4"];
            break;            
        case 6: //取
            match.matchStatus = [NSString stringWithFormat:@"5"];
            break;
        case 1: //上
        case 2: //中
        case 3: //下
        case 7: //加
        case 8: //加
        case 9: //加
        case 11: //点
        case 12: //全
        case 13: //延
        case 14: //斩
        case 15: //待
            match.matchStatus = [NSString stringWithFormat:@"2"];
            break;
    }
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];

        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
        {
            self.systemTime = [drs readComposString1];
            self.matchCount = [drs readShort];
            if (self.matchCount > 0) {
                self.matchList = [NSMutableArray arrayWithCapacity:self.matchCount];
                for (NSUInteger i = 0; i < self.matchCount; i++) {
                    GC_MatchInfo *info = [[GC_MatchInfo alloc] init];
                    NSString *str = [drs readComposString4];
                    NSLog(@"str = %@", str);
                    // 中国足彩网比赛序号||赛事名称||主队||主队id||客队||客队id||比赛开始时间||亚盘主队||亚盘客队||半场比分||终场比分||是否受让||让球||欧赔||比赛状态||是否结束||亚赔序号||彩果
                    NSArray *parameters = [str componentsSeparatedByString:@"||"];//[str SplitStringByChar:@"||"];
                    if ([parameters count] > 17) {
                        info.identifier = [parameters objectAtIndex:0];
                        info.leagueName = [parameters objectAtIndex:1];
                        info.home = [parameters objectAtIndex:2];
                        info.homeID = [parameters objectAtIndex:3];
                        info.away = [parameters objectAtIndex:4];
                        info.awayID = [parameters objectAtIndex:5];
                        info.startTime = [parameters objectAtIndex:6];
                        info.asianPanHome = [parameters objectAtIndex:7];
                        info.asianPanAway = [parameters objectAtIndex:8];
                        info.halfScore = [parameters objectAtIndex:9];
                        info.endScore = [parameters objectAtIndex:10];
                        info.isAssign = [parameters objectAtIndex:11];
                        info.assignCount = [parameters objectAtIndex:12];
                        info.eurPei = [parameters objectAtIndex:13];
                        info.matchStatus = [parameters objectAtIndex:14];
                        info.isFinish = [parameters objectAtIndex:15];
                        info.asianPanID = [parameters objectAtIndex:16];
                        info.caiguo = [parameters objectAtIndex:17];
                        if ([parameters count] >= 19) {
                             info.zlcString = [parameters objectAtIndex:18];
                        }
                       
                        info.asianPan = [NSString stringWithFormat:@"%@ %@ %@", info.asianPanHome, info.assignCount, info.asianPanAway];
                        NSArray *v = [info.eurPei componentsSeparatedByString:@","];//[info.eurPei SplitStringByChar:@","];
                        if (v.count > 0) {
                            NSMutableString *eurPei = [NSMutableString string];
                            for (int i = 0; i < v.count; i++) {
                                [eurPei appendString:[v objectAtIndex:i]];
                                if(i != v.count - 1) [eurPei appendString:@" "];
                            }
                            info.eurPei = eurPei;
                        }
                    }
                    [self disposeMatchState:info];
                    [self.matchList addObject:info];
                    [info release];
                }
                
              

            }
            
            self.dateString = [drs readComposString1];
            self.update = [drs readByte];
            NSLog(@"时间戳 %@", self.dateString);
            NSLog(@"是否更新 %d", (int)self.update);
            
        }
        [drs release];
    }
    return self;
}

@end

@implementation GC_MatchInfo

@synthesize identifier, leagueName, home, homeID, away, awayID, startTime, asianPanHome, asianPanAway, halfScore, endScore, isAssign, assignCount, eurPei, matchStatus, isFinish, asianPanID, caiguo, zlcString;
@synthesize asianPan, selectNumber, issueStatus;

- (void)dealloc 
{
    [zlcString release];
    [identifier release];
    [leagueName release];
    [home release];
    [homeID release];
    [away release];
    [awayID release];
    [startTime release];
    [asianPanHome release];
    [asianPanAway release];
    [halfScore release];
    [endScore release];
    [isAssign release];
    [assignCount release];
    [eurPei release];
    [matchStatus release];
    [isFinish release];
    [asianPanID release];
    [caiguo release];
    [asianPan release];
    [selectNumber release];
    [issueStatus release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
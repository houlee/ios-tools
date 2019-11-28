//
//  BetRecordDetail.m
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GC_BetRecordDetail.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_BetRecordDetail

@synthesize returnId, isRecord, betLenght,voiceLong;
@synthesize systemTime, programNumber, sponsorsName, programAmount, betStyle, betsNum, multiplenNum, drawerState, jackpot,endTime,zhongjiangInfo,longprogramNumber,kaiJiangTime,zanNum,jiangMoney,voiceEidteTime,isZan,beginTime,isZhongjiang,voiceID,other,yuceJiangjin, jiangjinyouhua, zhuihaoqingkong,shishibifen,issue,chaiInfoArray;
@synthesize lotterySeqNum, programDeclaration, sponsorsAmount, percentage, baseAmount, subscriptionAmount, projectSchedule, subscriptionNum, lotteryId, buyWay, awardNum, secretType,guguanWanfa,wanfaId,alertInfo,zhanji,yujiTime,OutorderId,outBianMa,danshiInfo;
@synthesize betContentArray;

- (void)dealloc
{
    [zhuihaoqingkong release];
    [jiangjinyouhua release];
	[systemTime release];
	[programNumber release];
	[sponsorsName release];
	[programAmount release];
	[betStyle release];
	[betsNum release];
	[endTime release];
	[multiplenNum release];
	[drawerState release];
	[jackpot release];
	[lotterySeqNum release];
	[programDeclaration release];
	[sponsorsAmount release];
	[percentage release];
	[baseAmount release];
	[subscriptionAmount release];
	[projectSchedule release];
	[subscriptionNum release];
	[lotteryId release];
	[buyWay release];
	[awardNum release];
    [secretType release];
	[betContentArray release];
	[zhongjiangInfo release];
    [guguanWanfa release];
    [wanfaId release];
    [longprogramNumber release];
    [kaiJiangTime release];
    [zanNum release];
    [jiangMoney release];
    [voiceEidteTime release];
    [other release];
    [yuceJiangjin release];
    [zhanji release];
    [yujiTime release];
    self.alertInfo = nil;
    self.voiceID = nil;
    self.beginTime = nil;
    self.isZhongjiang = nil;
    self.shishibifen = nil;
    self.issue = nil;
    self.chaiInfoArray = nil;
    self.OutorderId = nil;
    self.outBianMa = nil;
    self.danshiInfo =nil;
	[super dealloc];
}


-(id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
    [self initWithResponseData:_responseData WithRequest:request betRecordDetailType:BetRecordDetailPK];
    }
    return self;
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request betRecordDetailType:(BetRecordDetailType)betRecordDetailType
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
            
            self.systemTime = [drs readComposString1];
            self.isRecord = [drs readByte];
            self.programNumber = [drs readComposString1];
            self.sponsorsName = [drs readComposString1];
            self.programAmount = [drs readComposString1];
            self.betStyle = [drs readComposString1];
            self.betsNum = [drs readComposString1];
            self.multiplenNum = [drs readComposString1];
            self.drawerState = [drs readComposString1];
            self.jackpot = [drs readComposString1];
            self.lotterySeqNum = [drs readComposString1];
            self.programDeclaration = [drs readComposString2];
            self.sponsorsAmount = [drs readComposString1];
            self.percentage = [drs readComposString1];
            self.baseAmount = [drs readComposString1];
            self.subscriptionAmount = [drs readComposString1];
            self.projectSchedule = [drs readComposString1];
            self.subscriptionNum = [drs readComposString1];
            self.lotteryId = [drs readComposString1];
            self.buyWay = [drs readComposString1];
            self.secretType = [drs readComposString1];
            self.endTime = [drs readComposString1];
            self.awardNum = [drs readComposString1];
            self.betLenght = [drs readShort];
            
            
            NSLog(@"系统时间 %@", self.systemTime);
            NSLog(@"记录是否存在 %d", (int)self.isRecord);
            NSLog(@"方案编号 %@", self.programNumber);
            NSLog(@"发起人昵称 %@", self.sponsorsName);
            NSLog(@"方案金额 %@", self.programAmount);
            NSLog(@"投注方式 %@", self.betStyle);
            NSLog(@"注数 %@", self.betsNum);
            NSLog(@"倍数 %@", self.multiplenNum);
            NSLog(@"出票状态 %@", self.drawerState);
            NSLog(@"中奖情况 %@", self.jackpot);
            NSLog(@"彩票序列号 %@", self.lotterySeqNum);
            NSLog(@"方案宣言 %@", self.programDeclaration);
            NSLog(@"发起人认购金额 %@", self.sponsorsAmount);
            NSLog(@"提成比例 %@", self.percentage);
            NSLog(@"保底金额 %@", self.baseAmount);
            NSLog(@"可认购金额 %@", self.subscriptionAmount);
            NSLog(@"方案进度 %@", self.projectSchedule);
            NSLog(@"已认购人数 %@", self.subscriptionNum);
            NSLog(@"彩种id %@", self.lotteryId);
            NSLog(@"购买方式 %@", self.buyWay);
            NSLog(@"保密类型 %@", self.secretType);
            NSLog(@"购买截止时间 %@",self.endTime);
            NSLog(@"开奖号码 %@", self.awardNum);
            NSLog(@"投注内容长度 %d", (int)self.betLenght);
            
            if (betLenght > 0 && betRecordDetailType != BetRecordDetailHorse) {
                //	self.betContentArray = [NSMutableArray arrayWithCapacity:self.betLenght];
                self.betContentArray = [NSMutableArray arrayWithCapacity:0];
                for (int i = 0; i < self.betLenght; i++) {
                    NSString *betNumber = [drs readComposString4];
                    NSLog(@"投注内容 %@", betNumber);
                    
                    if (betNumber) {
                        [self.betContentArray addObject:betNumber];
                    }
                    
                }
                
            }
            self.zhongjiangInfo = [drs readComposString1];
            self.guguanWanfa = [drs readComposString1];
            self.wanfaId = [drs readComposString1];
            self.kaiJiangTime = [drs readComposString1];
            self.longprogramNumber = [drs readComposString1];
            
            self.voiceLong = [drs readByte];
            self.zanNum = [drs readComposString1];
            self.jiangMoney = [drs readComposString1];
            self.voiceEidteTime = [drs readComposString1];
            self.isZan = [drs readComposString1];
            self.beginTime = [drs readComposString1];
            self.isZhongjiang = [drs readComposString1];
            self.voiceID = [drs readComposString1];
            self.other = [drs readComposString1];
            self.yuceJiangjin = [drs readComposString1];
            self.jiangjinyouhua = [drs readComposString1];
            self.zhuihaoqingkong = [drs readComposString1];
            self.shishibifen = [drs readComposString1];
            self.issue = [drs readComposString1];
            NSString *chai = [drs readComposString4];
            if ([chai length]) {
                self.chaiInfoArray = [NSMutableArray arrayWithArray:[chai componentsSeparatedByString:@"&"]];
            }
            self.alertInfo = [drs readComposString1];
            self.zhanji = [drs readComposString1];
            self.yujiTime = [drs readComposString1];
            self.OutorderId = [drs readComposString1];
            self.outBianMa  = [drs readComposString1];
            self.danshiInfo = [drs readComposString2];
            if ([self.lotteryId isEqualToString:@"201"] && ([self.wanfaId isEqualToString:@"06"] || [self.wanfaId isEqualToString:@"07"])) {
                if ([self.betContentArray count]) {
                    NSString *st = [self.betContentArray objectAtIndex:0];
                    NSMutableArray *array1 = [NSMutableArray arrayWithArray:[st componentsSeparatedByString:@";"]];
                    if ([array1 count] > 8) {
                        NSString *st2 = [array1 objectAtIndex:8];
                        NSArray *info = [st2 componentsSeparatedByString:@","];
                        [self.betContentArray removeAllObjects];
                        for (int i = 0; i < [info count]; i ++) {
                            [array1 replaceObjectAtIndex:8 withObject:[info objectAtIndex:i]];
                            NSString *newInfo = [array1 componentsJoinedByString:@";"];
                            [self.betContentArray addObject:newInfo];
                        }
                    }
                }
            }
            if ([self.danshiInfo length] > 1) {
                NSArray *array = [self.danshiInfo componentsSeparatedByString:@"|"];
                if ([array count] >= 2) {
                    self.betLenght = [[array objectAtIndex:0] integerValue];
                    self.danshiInfo = [array objectAtIndex:1];
                }
            }
            
            NSLog(@"中奖情况 %@",self.zhongjiangInfo);
            NSLog(@"过关玩法%@",self.guguanWanfa);
            NSLog(@"玩法id%@",self.wanfaId);
            NSLog(@"开奖时间%@",self.kaiJiangTime);
            NSLog(@"长编号%@",self.longprogramNumber);
            NSLog(@"时长 %d",(int)self.voiceLong);
            NSLog(@"攒数量%@",self.zanNum);
            NSLog(@"将近%@",self.jiangMoney);
            NSLog(@"编辑时间%@",self.voiceEidteTime);
            NSLog(@"是否赞过%@",self.isZan);
            NSLog(@"方案发起时间%@",self.beginTime);
            NSLog(@"方案中奖%@",self.isZhongjiang);
            NSLog(@"好声音ID%@",self.voiceID);
            NSLog(@"其他%@",self.other);
            NSLog(@"预计奖金%@",self.yuceJiangjin);
            NSLog(@"奖金优化方案标记 %@", self.jiangjinyouhua);
            NSLog(@"追号情况 %@", self.zhuihaoqingkong);
            NSLog(@"是否显示时时比分 %@",self.shishibifen);
            NSLog(@"期次 %@",self.issue);
            NSLog(@"拆票 %@",self.chaiInfoArray);
            NSLog(@"提示信息 %@",self.alertInfo);
            NSLog(@"战绩 %@",self.zhanji);
            NSLog(@"预计派奖时间 %@",self.yujiTime);
            NSLog(@"OutorderId = %@",self.OutorderId);
            NSLog(@"投注方式编码 = %@",self.outBianMa);
            NSLog(@"单式内容 = %@",self.danshiInfo);
            
            
        }
        [drs release];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
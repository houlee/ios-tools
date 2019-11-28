//
//  BetRecordDetail.h
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum {
    BetRecordDetailPK,
    BetRecordDetailHorse,
}BetRecordDetailType;

//投注记录明细
@interface GC_BetRecordDetail : NSObject {

	NSInteger returnId;              //返回消息id
    NSString *systemTime;            //系统时间
	NSInteger isRecord;              //记录是否存在
	NSString *programNumber;         //方案编号
	NSString *sponsorsName;          //发起人昵称
	NSString *programAmount;         //方案金额
	NSString *betStyle;              //投注方式
	NSString *betsNum;               //注数
	NSString *multiplenNum;          //倍数
	NSString *drawerState;           //出票状态
	NSString *jackpot;               //中奖情况
	NSString *lotterySeqNum;         //彩票序列号
	NSString *programDeclaration;    //方案宣言
	NSString *sponsorsAmount;        //发起人认购金额
	NSString *percentage;            //提成比例
	NSString *baseAmount;            //保底金额
	NSString *subscriptionAmount;    //可认购金额
	NSString *projectSchedule;       //方案进度
	NSString *subscriptionNum;       //已认购人数
	NSString *lotteryId;             //彩种id 
	NSString *buyWay;                //购买方式
	NSInteger betLenght;             //投注内容长度 (单式内容重写成总投注内容)
	
	NSMutableArray *betContentArray;
	NSString *awardNum;              //开奖号码
	NSString *endTime;				 // 认购截至实现
    NSString *secretType;            //保密类型 0:公开,1:保密,2:截止后公开,3:仅对跟单者公开;4:隐藏
	NSString *zhongjiangInfo;		 //中奖情况（几等奖）
    NSString *guguanWanfa;           //过关玩法
    NSString *wanfaId;                //玩法id；
    NSString *kaiJiangTime;            //开奖时间
    NSString *longprogramNumber;      //方案编号，长的
    NSInteger voiceLong;               //好声音时长
    NSString *zanNum;                 //赞个数
    NSString *jiangMoney;                 //中奖金额
    NSString *voiceEidteTime;        //最后编辑时间
    NSString *isZan;                  //是否赞过；
    NSString *beginTime;              //方案发起时间
    NSString *isZhongjiang;           //是否中奖
    NSString *voiceID;                //好声音ID
    NSString *other;                 //预留字段（现在是是否有领取奖励的）
    NSString *yuceJiangjin;         //预计奖金
    NSString * jiangjinyouhua;         //奖金优化方案标记
    NSString * zhuihaoqingkong;         //追号情况
    NSString * shishibifen;             //是否显示时时比分按钮
    NSString * issue;                   //期次；
    NSMutableArray * chaiInfoArray;                //拆分票
    NSString * alertInfo;               //提示信息
    NSString *zhanji;                   //战绩
    NSString *yujiTime;                 //预计派奖是将
    NSString *OutorderId;               //包涵是不是竞彩2选一类型
    NSString *outBianMa;                //投注方式编码
    NSString *danshiInfo;               //单式上传信息
}

@property (nonatomic, assign) NSInteger returnId, isRecord, betLenght,voiceLong;
@property (nonatomic, copy) NSString *systemTime, *programNumber, *sponsorsName, *programAmount, *betStyle, *betsNum, *multiplenNum, *drawerState, *jackpot, *endTime,*zhongjiangInfo,*longprogramNumber,*kaiJiangTime,*zanNum,*jiangMoney,*voiceEidteTime,*isZan,*beginTime,*isZhongjiang,*voiceID,*other,*alertInfo,*zhanji,*yujiTime,*OutorderId,*outBianMa ;
@property (nonatomic, copy) NSString *lotterySeqNum, *programDeclaration, *sponsorsAmount, *percentage, *baseAmount, *subscriptionAmount, *projectSchedule, *subscriptionNum, *lotteryId, *buyWay, *awardNum, *secretType,*guguanWanfa,*wanfaId,*yuceJiangjin, * zhuihaoqingkong, *jiangjinyouhua,*shishibifen,*issue,*danshiInfo;
@property (nonatomic, retain) NSMutableArray *betContentArray,*chaiInfoArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request betRecordDetailType:(BetRecordDetailType)betRecordDetailType;


@end

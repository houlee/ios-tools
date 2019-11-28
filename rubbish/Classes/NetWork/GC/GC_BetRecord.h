//
//  BetRecord.h
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//投注记录
@interface GC_BetRecord : NSObject {

	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSString *lotteryId;		// 彩种
	NSInteger isSelf;			//是否是本人，1是是
	NSInteger totalPage;		// 总页数
	NSInteger curPage;			// 当前页
	NSInteger reRecordNum;		// 返回记录数
	NSString *ZhanghuAmount;	// 账户余额；
	NSString *jiangLiAmount;	// 奖励金额
	NSString *dongjieAmount;	// 冻结金额
	
	NSMutableArray *brInforArray;
}

@property (nonatomic, assign) NSInteger isSelf,returnId, totalPage, curPage, reRecordNum;
@property (nonatomic, copy) NSString *systemTime, *lotteryId,*ZhanghuAmount,*jiangLiAmount,*dongjieAmount;
@property (nonatomic, retain) NSMutableArray *brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


//投注信息格式定义
@interface BetRecordInfor : NSObject {
	
	NSString *betDate;            //投注时间
	NSString *lotteryName;        //彩种名称
	NSString *lotteryNum;         //彩种编号
	NSString *mode;               //玩法
	NSString *betAmount;          //投注金额
	NSString *programState;       //方案状态
	NSString *issue;              //期号
	NSString *betStyle;           //投注方式
	NSString *buyStyle;           //购买方式
	NSString *awardState;         //中奖状态
	NSString *programNumber;      //方案编号
	NSString *baomiType;		  //保密类型
    NSString * lotteryMoney;      //中奖金额
    NSInteger voiceLeng;          //声音的长度
    NSString * baodistr;          //保底
    NSString * yuliustring;       //预留字段
    NSString *lingquJiangli;//领取奖励
    NSString *other;//预留字段
}

@property (nonatomic,retain) NSString *betDate, *lotteryName, *lotteryNum, *mode, *betAmount, *programState,*baomiType,* baodistr;
@property (nonatomic,retain) NSString *issue, *betStyle, *buyStyle, *awardState, *programNumber, * lotteryMoney,* yuliustring,*lingquJiangli,*other;
@property (nonatomic, assign)NSInteger voiceLeng;

@end
//
//  MyHeMaiList.h
//  caibo
//
//  Created by yao on 12-6-28.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_BetRecord.h"
#import "ASIHTTPRequest.h"

@interface MyHeMaiList : NSObject {
	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSInteger reRecordNum;		// 返回记录数
	NSMutableArray *brInforArray;
}

@property (nonatomic, assign) NSInteger returnId,reRecordNum;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSMutableArray *brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

//合买信息格式定义
@interface BetHeRecordInfor : NSObject {
	
	
	NSString *issue;              //期号
	NSString *lotteryNum;         //彩种编号
	NSString *mode;               //玩法
	NSString *programNumber;      //方案编号
	NSString *betAmount;          //投注金额
	NSString *programState;       //方案状态
	NSString *awardState;         //中奖状态
	NSString *betDate;            //投注时间
	NSString *baomiType;		  //保密类型
	NSString *lotteryName;		 //彩种中文名称
	NSString *betStyle;			//投注方式
    NSString * lotteryMoney;      //中奖金额
    NSInteger voiceLeng;          //声音的长度
    NSString * baodistr;           //保底
    NSString * yuliustring;       //预留字段
}

- (BetRecordInfor *)getBetRecordInforBySelf;

@property (nonatomic,copy) NSString *betDate, *lotteryNum, *mode, *betAmount, *programState,*baomiType, *baodistr;
@property (nonatomic,copy) NSString *issue, *awardState, *programNumber,*lotteryName,*betStyle, * lotteryMoney, * yuliustring;
@property (nonatomic,assign)NSInteger voiceLeng;

@end

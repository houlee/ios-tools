//
//  LotteryDetails.h
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LotteryDetail : NSObject {
	
	NSDictionary *dicArray;
	
	NSString *picUrl;             //图片地址
	
	NSString *reList;             //奖级信息明细
	NSString *awards;             //奖项
	NSString *winningNote;        //中奖注数
	NSString *single_Note_Bonus;  //单注奖金
	
	NSString *lotteryNumber;      //开奖号码
	NSString *lotteryId;          //彩种id
	NSString *issue;              //彩期
	NSString *buyamont;           //销量
	NSString *sales_rx9;          //任九销量
	NSString *sales_sfc;          //胜负彩销量
	NSString *prizePool;          //奖池金额
	NSString *ernie_date;         //开奖时间
	NSString *lotteryName;        //彩种名称
	
	NSString *name1;
	NSString *name2;
	NSString *name3;
	NSString *name4;
	
	NSString *againstName;        //本期对阵表
	NSString *screening;          //场次
	NSString *teams;              //队名
	NSString *score;              //比分
	NSString *results;            //彩果
	
	NSString *msg;
	
	NSArray *reListArray;
	NSArray *againstNamesList;
	NSArray *reAgainstList;
}

@property (nonatomic, retain) NSDictionary *dicArray;
@property (nonatomic, retain) NSString *picUrl, *reList, *awards, *winningNote, *single_Note_Bonus;
@property (nonatomic, retain) NSString *lotteryNumber, *lotteryId, *issue, *buyamont, *sales_rx9, *sales_sfc, *prizePool, *ernie_date, *lotteryName;
@property (nonatomic, retain) NSString *againstName, *screening, *teams, *score, *results;
@property (nonatomic, retain) NSArray *reListArray, *againstNamesList, *reAgainstList;
@property (nonatomic, retain) NSString *name1, *name2, *name3, *name4;
@property (nonatomic, retain) NSString *msg;

- (id)initWithParse:(NSString *)jsonString;
- (id)paserWithDictionary:(NSDictionary *)dic;
- (id)paserWithDic:(NSDictionary *)dic;

@end

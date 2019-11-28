//
//  SchemeInfo.h
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"

@interface SchemeInfo : NSObject {
    NSInteger schemeNumber;         // 方案编号
    NSString *lotteryType;          // 彩种
    NSString *state;                // 状态
    NSString *speed;                // 进度
    NSString *amount;               // 金额
    NSString *issue;                // 期号
    NSString *initiator;            // 发起人
    NSString *initiatorName;        // 发起人用户名
    NSInteger surplusAmount;        // 剩余份数
    NSString *schemeBlockingTime;   // 方案截止时间
    NSString *zhanji;               // 战绩
    NSString *initiatorID;          // 发起人id
    NSString * baodi;               //是否保底
    NSInteger shengyin;             //好声音长度
    NSString * yuliustring;         //预留
    
}

@property(nonatomic, assign) NSInteger schemeNumber, surplusAmount, shengyin;
@property(nonatomic, copy) NSString *lotteryType, *state, *speed, *amount, *issue, *initiator, *schemeBlockingTime, *zhanji, *initiatorID, *initiatorName, *baodi, *yuliustring;

- (id)initWithDataReadStream:(GC_DataReadStream *)drs;

@end
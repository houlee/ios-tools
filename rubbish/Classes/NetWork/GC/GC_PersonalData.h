//
//  PersonalData.h
//  Lottery
//
//  Created by jacob chiang on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"

@interface GC_PersonalData : NSObject
{
    NSInteger returnID;
    NSString *systemTime;
    NSString *userName;
    NSString *tureName;
    NSString *identityCardNum;
    NSString *phoneNum;
    NSString *accountBalance; // 账户余额
    NSString *rewardAccount; // 奖励余额
    NSInteger priorityAccount; // 购买优先账户
    //（1: 资金账户，2 : 奖励账户）
}

@property(nonatomic) NSInteger returnID;
@property(nonatomic, copy) NSString *systemTime;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *tureName;
@property(nonatomic, copy) NSString *identityCardNum;
@property(nonatomic, copy) NSString *phoneNum;
@property(nonatomic, copy) NSString *accountBalance;
@property(nonatomic, copy) NSString *rewardAccount;
@property(nonatomic) NSInteger priorityAccount;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
- (id)initWithDataReadStream:(GC_DataReadStream *)drs;

@end

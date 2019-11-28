//
//  AccountManage.h
//  Lottery
//
//  Created by jym on 12-1-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//账户管理
@interface GC_AccountManage : NSObject {

    NSInteger returnId;             //返回消息id
    NSString *systemTime;           //系统时间
    NSInteger dataState;            //数据状态
    // 0：数据正常 1：用户名不匹配 2：数据返回失败 当该字段不等于0时，此字段后数据不存在
	NSString *accountBalance;       //帐户余额
	NSString *cash;                 //现金
	NSString *awardAccountBalance;  //奖励帐户余额
	NSString *ktxAward;             //可提现金额 现在是奖励金额
	NSString *freezedAward;         //已冻结资金
    NSString * caijinbao;           //是否购买过彩金宝
}

@property (nonatomic) NSInteger returnId, dataState;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSString *accountBalance, *cash, *awardAccountBalance, *ktxAward, *freezedAward, * caijinbao;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

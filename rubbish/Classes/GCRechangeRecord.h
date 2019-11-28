//
//  RechangeRecoud.h
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//充值记录
@interface GCRechangeRecord : NSObject {

	NSInteger returnId;        // 返回消息id
    NSString *systemTime;      // 系统时间
	NSInteger totalPage;       // 总页数
	NSInteger curPage;         // 当前页
	NSInteger reRecordNum;     // 返回记录数
	
	NSMutableArray *rrInforArray;
}

@property (nonatomic, assign) NSInteger returnId, totalPage, curPage, reRecordNum;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSMutableArray *rrInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


//充值信息格式定义
@interface RechargeInfor : NSObject {
	
	NSString *rechargeTime;       //充值时间
	NSString *amount;             //充值金额
	NSString *accountAmount;      //到账金额
	NSString *style;              //充值方式
	NSInteger state;              //充值状态
	NSString *stateExplain;       //充值状态说明
	NSString *orderNo;            //订单号
	NSString *explain;            //说明
    // 一年中的第一个
    BOOL oneBool;
}

@property (nonatomic,retain) NSString *rechargeTime, *amount, *accountAmount, *style, *stateExplain, *orderNo, *explain;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) BOOL oneBool;


@end
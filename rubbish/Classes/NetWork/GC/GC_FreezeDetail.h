//
//  FreezeDetail.h
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//冻结详情
@interface GC_FreezeDetail : NSObject {

	NSInteger returnId;        // 返回消息id
    NSString *systemTime;      // 系统时间
	NSInteger countOfPage;     // 每页记录数
	NSInteger curPage;         // 当前页
	NSInteger reRecordNum;     // 返回条数
	
	NSMutableArray *fdInforArray;
}

@property (nonatomic, assign) NSInteger returnId, countOfPage, curPage, reRecordNum;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSMutableArray *fdInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


//冻结明细信息格式定义
@interface FreezeDetailInfor : NSObject {
	
	NSString *freezeTime;         //冻结时间
	NSString *totolAmount;        //冻结总金额
	NSString *cash;               //冻结现金
	NSString *accountAmount;      //冻结奖励账户金额
	NSString *type;               //冻结类型
	NSString *state;              //冻结状态
	NSString *orderNo;            //冻结订单号
	NSString *resouce;            //冻结原因
    // 是否是一年中的第一天
    BOOL oneBool;
}

@property (nonatomic,retain) NSString *freezeTime, *totolAmount, *cash, *accountAmount, *type, *state, *orderNo, *resouce;
@property (nonatomic, assign) BOOL oneBool;

@end
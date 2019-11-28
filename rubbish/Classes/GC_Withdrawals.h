//
//  Withdrawals.h
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//提现记录
@interface GC_Withdrawals : NSObject {

	NSInteger returnId;        // 返回消息id
    NSString *systemTime;      // 系统时间
	NSInteger totalPage;       // 总页数
	NSInteger curPage;         // 当前页
	NSInteger reRecordNum;     // 返回记录数
	
	NSMutableArray *wInforArray;
}

@property (nonatomic, assign) NSInteger returnId, totalPage, curPage, reRecordNum;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSMutableArray *wInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

//提现明细信息格式定义
@interface WithdrawalsInfor : NSObject {
	
	NSString *operDate;           //交易时间
	NSString *award;              //提款金额
	NSString *type;               //提款类型
	NSString *state;              //提款状态
	NSString *orderNo;            //订单号
	NSString *remarks;            //备注
    
    // 一年中的第一个
    BOOL oneBool;
}

@property (nonatomic,retain) NSString *operDate, *award, *type, *state, *orderNo, *remarks;
@property (nonatomic,assign) BOOL oneBool;
@end

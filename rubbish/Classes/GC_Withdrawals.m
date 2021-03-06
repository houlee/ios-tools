//
//  Withdrawals.m
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GC_Withdrawals.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_Withdrawals

@synthesize returnId, totalPage, curPage, reRecordNum;
@synthesize systemTime, wInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
			self.totalPage = [drs readShort];
			self.curPage = [drs readShort];
			self.reRecordNum = [drs readByte];
			
			NSLog(@"系统时间 %@", self.systemTime);
			NSLog(@"总页数 %d", (int)self.totalPage);
			NSLog(@"当前页 %d", (int)self.curPage);
			NSLog(@"返回记录数 %d", (int)self.reRecordNum);
			
			//充值记录明细...
			if (self.reRecordNum > 0) {
				self.wInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                
                for (int i = 0; i < self.reRecordNum; i ++) {
					
					WithdrawalsInfor *wInfor = [[WithdrawalsInfor alloc] init];
					wInfor.operDate = [drs readComposString1];
					wInfor.award = [drs readComposString1];
					wInfor.type = [drs readComposString1];
					wInfor.state = [drs readComposString1];
					wInfor.orderNo = [drs readComposString1];
					wInfor.remarks = [drs readComposString1];
					
					NSLog(@"交易时间 %@", wInfor.operDate);
					NSLog(@"提款金额 %@", wInfor.award);
					NSLog(@"提款类型 %@", wInfor.type);
					NSLog(@"提款状态 %@", wInfor.state);
					NSLog(@"订单号 %@", wInfor.orderNo);
					NSLog(@"备注 %@", wInfor.remarks);
                    
                    
                   
                    
                    [self.wInforArray addObject:wInfor];
                    [wInfor release];
                }
			}
		}
		[drs release];
    }
    return self;
}

- (void)dealloc
{
	[systemTime release];
	[wInforArray release];
	[super dealloc];
}

@end


@implementation WithdrawalsInfor

@synthesize operDate, award, type, state, orderNo, remarks,oneBool;

- (void)dealloc
{
	[operDate release];
	[award release];
	[type release];
	[state release];
	[orderNo release];
	[remarks release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  RechangeRecoud.m
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GCRechangeRecord.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GCRechangeRecord

@synthesize returnId, totalPage, curPage, reRecordNum;
@synthesize systemTime, rrInforArray;

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
				self.rrInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
               
                
                for (int i = 0; i < self.reRecordNum; i ++) {
					
					RechargeInfor *rInfor = [[RechargeInfor alloc] init];
					rInfor.rechargeTime = [drs readComposString1];
					rInfor.amount = [drs readComposString1];
					rInfor.accountAmount = [drs readComposString1];
					rInfor.style = [drs readComposString1];
					rInfor.state = [drs readByte];
					rInfor.stateExplain = [drs readComposString1];
					rInfor.orderNo = [drs readComposString1];
					rInfor.explain = [drs readComposString1];
					
					NSLog(@"充值时间 %@", rInfor.rechargeTime);
					NSLog(@"充值金额 %@", rInfor.amount);
					NSLog(@"到账金额 %@", rInfor.accountAmount);
					NSLog(@"充值方式 %@", rInfor.style);
					NSLog(@"充值状态 %d", (int)rInfor.state);
					NSLog(@"充值状态说明 %@", rInfor.stateExplain);
					NSLog(@"订单号 %@", rInfor.orderNo);
					NSLog(@"说明 %@", rInfor.explain);
                    
                 
                    
                    
                    
                    [self.rrInforArray addObject:rInfor];
                    [rInfor release];
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
	[rrInforArray release];
	[super dealloc];
}

@end


@implementation RechargeInfor

@synthesize rechargeTime, amount, accountAmount, style, stateExplain, orderNo, explain,oneBool;
@synthesize state;

- (void)dealloc
{
	[rechargeTime release];
	[amount release];
	[accountAmount release];
	[style release];
	[stateExplain release];
	[orderNo release];
	[explain release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
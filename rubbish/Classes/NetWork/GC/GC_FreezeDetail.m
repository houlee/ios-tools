//
//  FreezeDetail.m
//  Lottery
//
//  Created by jym on 12-1-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GC_FreezeDetail.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_FreezeDetail

@synthesize returnId, countOfPage, curPage, reRecordNum;
@synthesize systemTime, fdInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        //DD_LOG(@"返回消息id %i", self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
			self.countOfPage = [drs readShort];
			self.curPage = [drs readShort];
			self.reRecordNum = [drs readByte];
			
			NSLog(@"系统时间 %@", self.systemTime);
			NSLog(@"每页记录数 %d", (int)self.countOfPage);
			NSLog(@"当前页 %d", (int)self.curPage);
			NSLog(@"返回条数 %d", (int)self.reRecordNum);
			
			//冻结明细...
			if (self.reRecordNum > 0) {
				self.fdInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                
                
                for (int i = 0; i < self.reRecordNum; i ++) {
					
					FreezeDetailInfor *fdInfor = [[FreezeDetailInfor alloc] init];
					fdInfor.freezeTime = [drs readComposString1];
					fdInfor.totolAmount = [drs readComposString1];
					fdInfor.cash = [drs readComposString1];
					fdInfor.accountAmount = [drs readComposString1];
					fdInfor.type = [drs readComposString1];
					fdInfor.state = [drs readComposString1];
					fdInfor.orderNo = [drs readComposString1];
					fdInfor.resouce = [drs readComposString1];
					
					NSLog(@"冻结时间 %@", fdInfor.freezeTime);
					NSLog(@"冻结总金额 %@", fdInfor.totolAmount);
					NSLog(@"冻结现金 %@", fdInfor.cash);
					NSLog(@"冻结奖励账户金额 %@", fdInfor.accountAmount);
					NSLog(@"冻结类型 %@", fdInfor.type);
					NSLog(@"冻结状态 %@", fdInfor.state);
					NSLog(@"冻结订单号 %@", fdInfor.orderNo);
					NSLog(@"冻结原因 %@", fdInfor.resouce);
                    
                   
                    
                    [self.fdInforArray addObject:fdInfor];
                    [fdInfor release];
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
	[fdInforArray release];
	[super dealloc];
}

@end


@implementation FreezeDetailInfor

@synthesize freezeTime, totolAmount, cash, accountAmount, type, state, orderNo, resouce,oneBool;

- (void)dealloc
{
	[freezeTime release];
	[totolAmount release];
	[cash release];
	[accountAmount release];
	[type release];
	[state release];
	[orderNo release];
	[resouce release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
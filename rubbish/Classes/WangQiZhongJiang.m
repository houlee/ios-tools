//
//  WangQiZhongJiang.m
//  caibo
//
//  Created by yao on 12-7-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "WangQiZhongJiang.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation WangQiZhongJiang

@synthesize returnId,reRecordNum,AllNum;
@synthesize systemTime,lottry;
@synthesize brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
			self.lottry = [drs readComposString1];
			self.reRecordNum = [drs readByte];
			self.AllNum = [drs readShort];
			//充值记录明细...
			if (self.reRecordNum > 0) {
				self.brInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                for (int i = 0; i < self.reRecordNum; i++) {
					[self.brInforArray addObject:[drs readComposString1]];
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
	[lottry release];
	[brInforArray release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
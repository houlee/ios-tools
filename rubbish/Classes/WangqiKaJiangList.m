//
//  WangqiKaJiangList.m
//  caibo
//
//  Created by yao on 12-7-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "WangqiKaJiangList.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation WangqiKaJiangList

@synthesize returnId,reRecordNum,allNum;
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
			NSLog(@"系统时间%@",self.systemTime);
			self.lottry = [drs readComposString1];
			self.reRecordNum = [drs readByte];
			//self.allNum = [drs readShort];
			//充值记录明细...
			if (self.reRecordNum > 0) {
				self.brInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                for (int i = 0; i < self.reRecordNum; i++) {
					KaiJiangInfo *info = [[KaiJiangInfo alloc] init];
					
					info.issue = [drs readComposString1];
					info.num = [drs readComposString1];
					info.kaijiangTime = [drs readComposString1];
					[self.brInforArray addObject:info];
					[info release];
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
	[brInforArray release];
	[lottry release];
	[super dealloc];
}


@end

@implementation KaiJiangInfo 

@synthesize issue, num,kaijiangTime;

- (void)dealloc
{
	[issue release];
	[num release];
	[kaijiangTime release];
	[super dealloc];
}


@end;

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
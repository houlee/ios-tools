//
//  CheckAwardTime.m
//  Lottery
//
//  Created by jym on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_CheckAwardTime.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"



@implementation GC_CheckAwardTime
@synthesize returnId, lotteryId;
@synthesize systemTime;
@synthesize curIssueNum, fAwardNumber, curIssueTime, curEndTime, curYuTime, awardTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
            {
                self.systemTime = [drs readComposString1];
                self.lotteryId = [drs readShort];
				[drs readComposString1];
                self.curIssueNum = [drs readComposString1];
                self.fAwardNumber = [drs readComposString1];
                self.curIssueTime = [drs readComposString1];
                self.curEndTime = [drs readComposString1];
                self.curYuTime = [drs readComposString1];
                self.awardTime = [drs readComposString1];
              
                NSLog(@"系统时间 %@", self.systemTime);
                NSLog(@"当前期号 %@", self.curIssueNum);
                NSLog(@"上期开奖号码 %@", self.fAwardNumber);
                NSLog(@"当期开始时间 %@", self.curIssueTime);
                NSLog(@"当期结束时间 %@", self.curEndTime);
                NSLog(@"当期剩余时间 %@", self.curYuTime);
                NSLog(@"开奖时间 %@", self.awardTime);
            }
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
	[systemTime release];
	[curIssueNum release];
	[fAwardNumber release];
	[curIssueTime release];
	[curEndTime release];
	[curYuTime release];
    [awardTime release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  MyHeMaiList.m
//  caibo
//
//  Created by yao on 12-6-28.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "MyHeMaiList.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"


@implementation MyHeMaiList

@synthesize returnId,reRecordNum;
@synthesize systemTime;
@synthesize brInforArray;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
			
			self.reRecordNum = [drs readByte];
			//充值记录明细...
			if (self.reRecordNum > 0) {
				self.brInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                for (int i = 0; i < self.reRecordNum; i++) {
					//期次	整型+字符串	1+n	1(示例, 会改变)
					//彩种	整型+字符串	1+n	 (示例, 会改变)
					//玩法	整型+字符串	1+n	 (示例, 会改变)
					//订单号	整型+字符串	1+n	18+B08401394213233239(示例, 会改变)
					//投注金额	整型+字符串	1+n	32768.0(示例, 会改变)
					//订单状态	整型+字符串	1+n	已出票(示例, 会改变)
					//中奖状态	整型+字符串	1+n	中奖(示例, 会改变)
					//投注时间	整型+字符串	1+n	2011-10-13 14:56:45(示例, 会改变)
					//保密状态	整型+字符串	1+n	(示例, 会改变)
					BetHeRecordInfor *brInfor = [[BetHeRecordInfor alloc] init];
					brInfor.issue = [drs readComposString1];
					brInfor.lotteryNum = [drs readComposString1];
					brInfor.mode = [drs readComposString1];
					brInfor.programNumber = [drs readComposString1];
					brInfor.betAmount = [drs readComposString1];
					brInfor.programState = [drs readComposString1];
					brInfor.awardState = [drs readComposString1];
					brInfor.betDate = [drs readComposString1];
					brInfor.baomiType = [drs readComposString1];
					brInfor.lotteryName = [drs readComposString1];
					brInfor.betStyle = [drs readComposString1];
                    brInfor.lotteryMoney = [drs readComposString1];
                    brInfor.voiceLeng = [drs readByte];
                    brInfor.baodistr = [drs readComposString1];
                    brInfor.yuliustring = [drs readComposString1];
                    if ([brInfor.lotteryMoney floatValue] == 0) {
                        brInfor.lotteryMoney = @"0.00";
                    }
					NSLog(@"投注时间 %@", brInfor.betDate);
					NSLog(@"彩种编号 %@", brInfor.lotteryNum);
					NSLog(@"玩法 %@", brInfor.mode);
					NSLog(@"投注金额 %@", brInfor.betAmount);
					NSLog(@"方案状态 %@", brInfor.programState);
					NSLog(@"期号 %@", brInfor.issue);
					NSLog(@"中奖状态 %@", brInfor.awardState);
					NSLog(@"方案编号 %@", brInfor.programNumber);
                    NSLog(@"保密类型 %@", brInfor.baomiType);	
					NSLog(@"猜种名称 %@",brInfor.lotteryName);
					NSLog(@"投注方式 %@",brInfor.betStyle);
                    NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
                    [self.brInforArray addObject:brInfor];
                    [brInfor release];
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
	[super dealloc];
}

@end

@implementation BetHeRecordInfor

@synthesize betDate, lotteryNum, mode, betAmount, programState,baomiType,baodistr;
@synthesize issue, awardState, programNumber,lotteryName,betStyle, lotteryMoney, voiceLeng, yuliustring;

- (BetRecordInfor *)getBetRecordInforBySelf {
	BetRecordInfor *info = [[[BetRecordInfor alloc] init] autorelease];
	info.betDate = self.betDate;
	info.lotteryNum = self.lotteryNum;
	info.mode = self.mode;
	info.betAmount = self.betAmount;
	info.programState = self.programState;
	info.baomiType = self.baomiType;
	info.issue = self.issue;
	info.awardState = self.awardState;
	info.programNumber = self.programNumber;
	info.lotteryName = self.lotteryName;
	info.betStyle = self.betStyle;
    info.lotteryMoney = self.lotteryMoney;
    info.voiceLeng = self.voiceLeng;
    info.yuliustring = self.yuliustring;
    info.baodistr = self.baodistr;
	return info;
}

- (void)dealloc
{
    [baodistr release];
    [yuliustring release];
    [lotteryMoney release];
    self.betDate = nil;
//	[betDate release];
	[lotteryNum release];
	[mode release];
	[betAmount release];
	[programState release];
	[baomiType release];
	[issue release];
	[awardState release];
	[programNumber release];
	[lotteryName release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
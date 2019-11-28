//
//  BetRecordJiangLi.m
//  caibo
//
//  Created by zhang on 2/26/13.
//
//

#import "BetRecordJiangLi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
#import "GC_BetRecord.h"

@implementation BetRecordJiangLi

@synthesize returnId, totalPage, curPage, reRecordNum,isSelf;
@synthesize systemTime, lotteryId, ZhanghuAmount,jiangLiAmount,dongjieAmount,brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            
			self.isSelf = [drs readByte];
			if (self.isSelf) {
				self.ZhanghuAmount = [drs readComposString1];
				self.jiangLiAmount = [drs readComposString1];
				self.dongjieAmount = [drs readComposString1];
			}
			self.lotteryId = [drs readComposString2];
			self.totalPage = [drs readShort];
			self.curPage = [drs readShort];
			self.reRecordNum = [drs readByte];
			NSLog(@"系统时间 %@", self.systemTime);
			NSLog(@"彩种 %@", self.lotteryId);
			NSLog(@"总页数 %ld", (long)self.totalPage);
			NSLog(@"当前页 %ld", (long)self.curPage);
			NSLog(@"返回记录数 %ld", (long)self.reRecordNum);
			
			//充值记录明细...
			if (self.reRecordNum > 0) {
				self.brInforArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                for (int i = 0; i < self.reRecordNum; i++) {
					
					BetRecordInfor *brInfor = [[BetRecordInfor alloc] init];
					brInfor.betDate = [drs readComposString1];
					brInfor.lotteryName = [drs readComposString1];
					brInfor.lotteryNum = [drs readComposString1];
					brInfor.mode = [drs readComposString1];
					brInfor.betAmount = [drs readComposString1];
					brInfor.programState = [drs readComposString1];
					brInfor.issue = [drs readComposString1];
					brInfor.betStyle = [drs readComposString1];
					brInfor.buyStyle = [drs readComposString1];
					brInfor.awardState = [drs readComposString1];
					brInfor.programNumber = [drs readComposString1];
					brInfor.baomiType = [drs readComposString1];
                    brInfor.lotteryMoney = [drs readComposString1];
                    brInfor.voiceLeng = [drs readByte];
                    brInfor.baodistr = [drs readComposString1];
                    brInfor.lingquJiangli = [drs readComposString1];
                    brInfor.other = [drs readComposString1];
                    if ([brInfor.lotteryMoney floatValue] == 0) {
                        brInfor.lotteryMoney = @"0.00";
                    }
                    
					NSLog(@"投注时间 %@", brInfor.betDate);
					NSLog(@"彩种名称 %@", brInfor.lotteryName);
					NSLog(@"彩种编号 %@", brInfor.lotteryNum);
					NSLog(@"玩法 %@", brInfor.mode);
					NSLog(@"投注金额 %@", brInfor.betAmount);
					NSLog(@"方案状态 %@", brInfor.programState);
					NSLog(@"期号 %@", brInfor.issue);
					NSLog(@"投注方式 %@", brInfor.betStyle);
					NSLog(@"购买方式 %@", brInfor.buyStyle);
					NSLog(@"中奖状态 %@", brInfor.awardState);
					NSLog(@"方案编号 %@", brInfor.programNumber);
                    NSLog(@"保密类型 %@", brInfor.baomiType);
                    NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
                    NSLog(@"声音的长度 %ld", (long)brInfor.voiceLeng);
                    NSLog(@"加奖状态 %@", brInfor.lingquJiangli);
                    NSLog(@"预留字段 %@", brInfor.other);
                    [self.brInforArray addObject:brInfor];
                    [brInfor release];
                }
			}
		}
		[drs release];
    }
    return self;
}

- (GC_BetRecord *)changeToGC_betRecord {
    GC_BetRecord *bet = [[[GC_BetRecord alloc] init] autorelease];
    bet.isSelf = self.isSelf;
    bet.returnId = self.returnId;
    bet.totalPage = self.curPage;
    bet.reRecordNum = self.reRecordNum;
    bet.systemTime = self.systemTime;
    bet.lotteryId = self.lotteryId;
    bet.ZhanghuAmount = self.ZhanghuAmount;
    bet.jiangLiAmount = self.jiangLiAmount;
    bet.dongjieAmount = self.dongjieAmount;
    bet.brInforArray = self.brInforArray;
    return bet;
}

- (void)dealloc
{
	[systemTime release];
    [lotteryId release];
	[brInforArray release];
	[ZhanghuAmount release];
	[jiangLiAmount release];
	[dongjieAmount release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
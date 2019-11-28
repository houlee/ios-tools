//
//  BuyLottery.m
//  Lottery
//
//  Created by  on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_BuyLottery.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_BuyLottery

@synthesize returnId, returnValue;
@synthesize systemTime, totalMoney, betInfoID, bettingMoney,issure;
@synthesize number, lotterytype, betresult, betResultInfo,curIssure, msgString,lotteryId,kaijiangTime,paijiangTime;
- (void)dealloc
{
    [msgString release];
    [lotterytype release];
    [betResultInfo release];
    [number release];
    [systemTime release];
	[totalMoney release];
    [betInfoID release];
    [bettingMoney release];
    [curIssure release];
    self.lotteryId = nil;
    self.kaijiangTime = nil;
    self.paijiangTime = nil;
    
	[super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData isHemaiYueyu:(BOOL)isyueyu WithRequest:(ASIHTTPRequest *)request {
    if (self = [super init]) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.lotterytype = [drs readComposString2];
            NSLog(@"彩种 %@", lotterytype);
            self.returnValue = [drs readByte];
            NSLog(@"投注结果：%d", (int)returnValue);
            self.number = [drs readComposString1];
            NSLog(@"方案编号 %@", number);
            self.issure = [drs readComposString1];
            
            NSLog(@"正确期号 %@", issure);
            self.kaijiangTime = [drs readComposString1];
            self.paijiangTime = [drs readComposString1];
            NSLog(@"开奖时间%@",self.kaijiangTime);
            NSLog(@"派奖时间%@",self.paijiangTime);
        }
    [drs release];
    }
    return self;
}


- (id)initWithResponseData:(NSData *)_responseData isYueyu:(BOOL)isyueyu WithRequest:(ASIHTTPRequest *)request {
    if (self = [super init]) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.lotterytype = [drs readComposString1];
            NSLog(@"彩种 %@", lotterytype);
            self.returnValue = [drs readByte];
            NSLog(@"投注结果：%d", (int)returnValue);
            self.betResultInfo = [drs readComposString1];
            NSLog(@"投注结果详情 %@", self.betResultInfo);
            self.number = [drs readComposString1];
            NSLog(@"方案编号 %@", number);
            self.curIssure = [drs readComposString1];
            self.issure = curIssure;
            NSLog(@"正确期号 %@", issure);
            self.kaijiangTime = [drs readComposString1];
            self.paijiangTime = [drs readComposString1];
            NSLog(@"开奖时间%@",self.kaijiangTime);
            NSLog(@"派奖时间%@",self.paijiangTime);

        } else {
        }
        [drs release];
    }
    return self;
}

- (id)initWithResponseData:(NSData *)_responseData newWithRequest:(ASIHTTPRequest *)request {
    if (self = [super init]) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.lotterytype = [drs readComposString2];
            NSLog(@"彩种 %@", lotterytype);
            self.returnValue = [drs readByte];
            NSLog(@"投注结果：%d", (int)returnValue);
            self.betResultInfo = [drs readComposString1];
            NSLog(@"投注结果详情 %@", self.betResultInfo);
           
            
        } else {
        }
        [drs release];
    }
    return self;
}
- (id)initWithResponseData:(NSData *)_responseData newNotYYWithRequest:(ASIHTTPRequest *)request {
    if (self = [super init]) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.returnValue = [drs readByte];
            NSLog(@"投注结果：%d", (int)returnValue);
            self.totalMoney = [drs readComposString1];
            NSLog(@"账户总金额 %@", totalMoney);
            self.betInfoID = [drs readComposString1];
            NSLog(@"投注信息id %@", betInfoID);
            self.bettingMoney = [drs readComposString1];
            NSLog(@"投注金额 %@", bettingMoney);
            self.betResultInfo = [drs readComposString1];
            NSLog(@"投注结果详情 %@", self.betResultInfo);
            
        } else {
        }
        [drs release];
    }
    return self;
}



- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.returnValue = [drs readByte];
            NSLog(@"返回代码 %i", (int)returnValue);
#ifdef isYueYuBan
            self.number = [drs readComposString1];
            NSLog(@"方案编号 %@", number);
            self.kaijiangTime = [drs readComposString1];
            self.paijiangTime = [drs readComposString1];
            NSLog(@"开奖时间%@",self.kaijiangTime);
            NSLog(@"派奖时间%@",self.paijiangTime);

#else
            self.totalMoney = [drs readComposString1];
            NSLog(@"账户总金额 %@", totalMoney);
            self.betInfoID = [drs readComposString1];
            NSLog(@"投注信息id %@", betInfoID);
            self.bettingMoney = [drs readComposString1];
            NSLog(@"投注金额 %@", bettingMoney);
            self.curIssure = [drs readComposString1];
            NSLog(@"当前期 %@", curIssure);
#endif
        } else {
			self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", systemTime);
            self.returnValue = [drs readByte];
            NSLog(@"返回代码 %i", (int)returnValue);
            self.totalMoney = [drs readComposString1];
            NSLog(@"账户总金额 %@", totalMoney);   
            self.betInfoID = [drs readComposString1];
            NSLog(@"投注信息id %@", betInfoID);     
            self.bettingMoney = [drs readComposString1];
            NSLog(@"投注金额 %@", bettingMoney);
            self.returnValue = -1;
            self.curIssure = [drs readComposString1];
            NSLog(@"当前期 %@", curIssure);            
//            self.systemTime = [drs readComposString1];
//             NSLog(@"系统时间 %@", systemTime);
//            self.lotterytype = [drs readComposString1];
//             NSLog(@"彩种 %@", lotterytype);
//            self.betresult = [drs readByte];
//            NSLog(@"投注结果：%d", betresult);
//            self.betResultInfo = [drs readComposString1];
//            NSLog(@"投注结果详情 %@", self.betResultInfo);
//            self.number = [drs readComposString1];
//            NSLog(@"方案编号 %@", number);
            
            
        }
        [drs release];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  JingCaiDuizhenChaXun.m
//  Lottery
//
//  Created by Jacob Chiang on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/***
 *
 *4.109	竞彩对阵查询（新）（1449）
 ********/

#import "GC_JingCaiDuizhenChaXun.h"
#import "GC_RspError.h"
#import "GC_JingCaiDuizhenResult.h"

@implementation GC_JingCaiDuizhenChaXun
@synthesize listData;
@synthesize count;
@synthesize returnId;
@synthesize sysTimeString;
@synthesize updata, dateString, beginTime, beginInfo;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        self.beginTime = @"";
        self.beginInfo = @"";
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        if (drs) {
            self.returnId= [drs readShort];
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                NSString *systemTime = [drs readComposString1];
                
                self.sysTimeString = systemTime;
                
                if (systemTime) {
                    NSLog(@"系统时间 %@", systemTime);
                }
                
                count = [drs readShort];
//                count = 10;//假数据。。。
                NSLog(@"对阵列表数目 %d", (int)count);
                if (count > 0) {
                    self.listData = [NSMutableArray arrayWithCapacity:count];
                    for (int i = 0; i < count; i++) {
                        NSString *listResult = [drs readComposString4];
                        //假数据。。。
//                        listResult = @"周五001||澳超||62162||墨尔本城||14549||珀斯光荣||2913||171900||2014-12-26 14:26||2.30 3.25 2.62 4.80 4.10 1.48 10.00 4.20 3.10 3.35 5.00 8.00 16.00 25.00 7.50 10.50 7.50 21.00 15.00 22.00 50.00 39.00 60.00 150.0 120.0 200.0 60.00 10.00 6.50 12.00 50.00 300.0 8.00 13.00 8.25 28.00 19.00 24.00 80.00 50.00 70.00 300.0 150.0 250.0 80.00 3.30 13.00 27.00 5.00 4.70 5.70 24.00 13.00 3.85||2.40 3.22 2.77||-1||-||false||-||1879940||- -||-||playvs||-||False||2014-12-26_星期五||1,15,3,4||0";
                        ////
                        NSLog(@"jie guo = %@", listResult);
                        GC_JingCaiDuizhenResult *result  = [[GC_JingCaiDuizhenResult alloc] initWithResult:listResult];
                        if (result) [self.listData insertObject:result atIndex:i]; 
                        [result release];
                    }  
                }
                self.dateString = [drs readComposString1];
                self.updata = [drs readByte];
                self.beginTime = [drs readComposString1];
                self.beginInfo = [drs readComposString1];
                NSLog(@"时间戳 %@", dateString);
                NSLog(@"是否更新 %d", (int)updata);
                NSLog(@"beginTime = %@", self.beginTime);
                NSLog(@"beginInfo = %@", self.beginInfo);
            }
        }
        [drs release];
    }
    return self;
}

-(void)dealloc{
    [beginInfo release];
    [beginTime release];
    [listData release];
    [sysTimeString release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
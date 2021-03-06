//
//  HeMaiCanYuJieXI.m
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-31.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "HeMaiCanYuJieXI.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation HeMaiCanYuJieXI

@synthesize canyurenArray;
@synthesize totleNum,curPage,curCount,returnId;
@synthesize systemTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.totleNum = [drs readByte];
            self.curPage = [drs readByte];
            self.curCount = [drs readByte];
            if (self.curCount > 0) {
                self.canyurenArray = [NSMutableArray arrayWithCapacity:self.curCount];
                for (int i = 0; i<self.curCount; i++) {
                    CanYuRen *ren = [[CanYuRen alloc] init];
                    ren.nickName = [drs readComposString1];
                    ren.name = [drs readComposString1];
                    ren.money = [drs readComposString1];
                    ren.buyFen = [drs readComposString1];
                    ren.time = [drs readComposString1];
                    ren.other = [drs readComposString1];
                    NSLog(@"昵称%@",ren.nickName);
                    NSLog(@"name%@",ren.name);
                    NSLog(@"钱%@",ren.money);
                    NSLog(@"份数%@",ren.buyFen);
                    NSLog(@"时间%@",ren.time);
                    [self.canyurenArray addObject:ren];
                    [ren release];
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
	[canyurenArray release];
	[super dealloc];
}

@end

@implementation CanYuRen

@synthesize nickName,name,money,buyFen,time,other;

- (void)dealloc {
    [nickName release];
    [name release];
    [money release];
    [buyFen release];
    [time release];
    [other release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
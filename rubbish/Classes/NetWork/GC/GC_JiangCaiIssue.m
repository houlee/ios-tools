//
//  JiangCaiIssue.m
//  Lottery
//
//  Created by Jacob Chiang on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_JiangCaiIssue.h"
#import "GC_RspError.h"

@implementation GC_JiangCaiIssue

@synthesize systemTime;
@synthesize lotteryId;
@synthesize issueData;


-(void)dealloc{
    [systemTime release];
    [issueData release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request{
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        if (drs) {
            NSInteger returnId = [drs readShort]; 
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                self.systemTime = [drs readComposString1];
                NSLog(@"xi tong shi jian = %@", self.systemTime);
                self.lotteryId = [drs readByte];
                NSLog(@"cai zhong = %d", (int)self.lotteryId);
                NSString *issue = [drs readComposString1];
                NSLog(@"qi shu = %@", issue);
                NSArray *issueList =(NSArray*)[issue componentsSeparatedByString:@","];
                self.issueData = issueList;
            }
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
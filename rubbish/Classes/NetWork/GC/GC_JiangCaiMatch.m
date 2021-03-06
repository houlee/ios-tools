//
//  JiangCaiMatch.m
//  Lottery
//
//  Created by Jacob Chiang on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/**
 *4.91	竞彩单场赛事列表（新）（1430）
 */

#import "GC_JiangCaiMatch.h"
#import "GC_RspError.h"

@implementation GC_JiangCaiMatch

@synthesize systemTime;
@synthesize matchList;

-(void)dealloc{
    [systemTime release];
    [matchList release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        if (drs) {
            NSInteger returnId = [drs readShort]; 
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
            {
                self.systemTime = [drs readComposString1];
               
                int count = [drs readShort];
                
                if (count > 0) {
                    NSMutableArray *matchdata = [[NSMutableArray alloc] init];
                    [matchdata addObject:@"全部"];
                    for (int i = 0; i < count; i++) {
                        NSString *match = [drs readComposString1];
                        if (match) [matchdata addObject:match];
                        NSLog(@"赛事名称 %@",match);
                    }
                    self.matchList = matchdata;
                    [matchdata release];
                }           
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
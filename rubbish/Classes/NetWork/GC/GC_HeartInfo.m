//
//  HeartInfo.m
//  Lottery
//
//  Created by Teng Kiefer on 12-2-8.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_HeartInfo.h"
#import "GC_RspError.h"
#import "GC_DataReadStream.h"
#import "GC_HttpService.h"

@implementation GC_HeartInfo

@synthesize returnId;
@synthesize systemTime, sessionId;

- (void)dealloc {
	[systemTime release];
	[sessionId release];
	[super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
		NSLog(@"%@",_responseData);
		GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
        {
            self.systemTime = [drs readComposString1];
            NSLog(@"系统时间 %@", self.systemTime);
            self.sessionId = [drs readComposString1];
            NSLog(@"Session id %@", self.sessionId);
            [GC_HttpService sharedInstance].sessionId = self.sessionId;
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
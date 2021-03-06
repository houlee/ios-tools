//
//  DownGoodVoiceJieXie.m
//  caibo
//
//  Created by yaofuyu on 13-1-18.
//
//

#import "DownGoodVoiceJieXie.h"

#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation DownGoodVoiceJieXie

@synthesize returnId,timeLong;
@synthesize systemTime,other,orderid ,username;
@synthesize goodVoiceData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.orderid = [drs readComposString1];
            self.goodVoiceData = [drs readComposData4];
            self.timeLong = [drs readByte];
            self.username = [drs readComposString1];
            self.other = [drs readComposString1];
            NSLog(@"系统时间%@",self.systemTime);
            NSLog(@"orderid%@",self.orderid);
            NSLog(@"发起人=%@",self.username);
            NSLog(@"预留字段%@",self.other);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
	[systemTime release];
    self.username = nil;
    self.orderid = nil;
    self.other = nil;
    self.goodVoiceData = nil;
	[super dealloc];
}
@end;

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  DIZhiJieXi.m
//  caibo
//
//  Created by cp365dev on 14-5-31.
//
//

#import "DIZhiJieXi.h"
#import "GC_RspError.h"

@implementation DIZhiJieXi

@synthesize systemTime,lingquStuse;
@synthesize returnId;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.lingquStuse = [drs readComposString1];
            NSLog(@"领取状态%@",self.lingquStuse);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc {
    self.lingquStuse = nil;
    self.systemTime = nil;
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  ShiJiHaoJieXi.m
//  caibo
//
//  Created by yaofuyu on 12-11-9.
//
//

#import "ShiJiHaoJieXi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ShiJiHaoJieXi

@synthesize returnId;
@synthesize systemTime,other,shiJiNum;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.shiJiNum = [drs readComposString1];
            self.other = [drs readComposString1];
            NSLog(@"系统时间%@",self.systemTime);
            NSLog(@"试机号%@",self.shiJiNum);
            NSLog(@"预留字段%@",self.other);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
	[systemTime release];
    self.shiJiNum = nil;
    self.other = nil;
	[super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
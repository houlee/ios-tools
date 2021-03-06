//
//  JiangLIJieXi.m
//  caibo
//
//  Created by yaofuyu on 13-2-26.
//
//

#import "JiangLIJieXi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation JiangLIJieXi


@synthesize returnId;
@synthesize other,code ,msg;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
            self.code = [drs readComposString1];
            self.msg = [drs readComposString1];
            self.other = [drs readComposString1];
            NSLog(@"code%@",self.code);
            NSLog(@"msg%@",self.msg);
            NSLog(@"预留字段%@",self.other);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
    self.msg = nil;
    self.code = nil;
    self.other = nil;
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
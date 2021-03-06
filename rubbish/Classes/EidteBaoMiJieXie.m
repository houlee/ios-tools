//
//  EidteBaoMiJieXie.m
//  caibo
//
//  Created by yaofuyu on 13-1-20.
//
//

#import "EidteBaoMiJieXie.h"

#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation EidteBaoMiJieXie

@synthesize returnId;
@synthesize systemTime,other,code ,msg;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.code = [drs readComposString1];
            self.msg = [drs readComposString1];
            self.other = [drs readComposString1];
            NSLog(@"系统时间%@",self.systemTime);
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
	[systemTime release];
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
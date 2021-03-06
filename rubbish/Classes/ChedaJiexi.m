//
//  ChedaJiexi.m
//  caibo
//
//  Created by yaofuyu on 13-5-31.
//
//

#import "ChedaJiexi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ChedaJiexi
@synthesize returnId,code;
@synthesize systemTime,msgString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
            self.systemTime = [drs readComposString1];
            self.code = [drs readComposString1];
            self.msgString = [drs readComposString1];
            NSLog(@"code %@",self.code);
        }
        [drs release];
    }
    return self;
}

- (void)dealloc {
    self.msgString = nil;
    self.code = nil;
    self.systemTime = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
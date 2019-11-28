//
//  PointExchangeJieXi.m
//  caibo
//
//  Created by cp365dev on 14-6-3.
//
//

#import "PointExchangeJieXi.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"
@implementation PointExchangeJieXi
@synthesize exchangeMess;
@synthesize exchangeState;
@synthesize returnId;
@synthesize systemTime;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if(self=[super init])
    {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.exchangeState = [drs readByte];
            self.exchangeMess = [drs readComposString1];
            NSLog(@"返回状态 %d",self.exchangeState);
            NSLog(@"返回信息 %@",self.exchangeMess);
            
        }
        [drs release];

    }
    return self;
    
}
-(void)dealloc
{
    exchangeMess = nil;
    systemTime = nil;
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  YinLianBackInfo.m
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import "GC_YinLianBackInfo.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"
@implementation GC_YinLianBackInfo
@synthesize systemTime;
@synthesize returnID;
@synthesize code;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if(self = [super init])
    {
        
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnID = [drs readShort];
        NSLog(@"返回消息id %d",(int)returnID);
        if(![GC_RspError parserError:drs returnId:returnID WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.code = [drs readByte];
            
            NSLog(@"系统时间 :%@  银联回拨状态 :%d",systemTime,(int)code);
        }
        [drs release];
        
    }
    return self;
}

-(void)dealloc
{
    
    systemTime = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  JiFenBuyLotteryData.m
//  caibo
//
//  Created by GongHe on 15-3-11.
//
//

#import "JiFenBuyLotteryData.h"
#import "ASIHTTPRequest.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation JiFenBuyLotteryData
@synthesize returnId;
@synthesize systemTime;
@synthesize returnValue;
@synthesize message;
@synthesize fangAnCode;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.returnValue = [drs readComposString1];
            self.message = [drs readComposString1];
            self.fangAnCode = [drs readComposString1];
            
            NSLog(@"返回代码 %@", returnValue);
            NSLog(@"提示信息 %@", message);
            NSLog(@"方案编号 %@", fangAnCode);

        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
    [systemTime release];
    [returnValue release];
    [message release];
    [fangAnCode release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
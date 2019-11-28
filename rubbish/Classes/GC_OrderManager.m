//
//  GC_OrderManager.m
//  caibo
//
//  Created by cp365dev on 14/12/25.
//
//

#import "GC_OrderManager.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
//充值订单
@implementation GC_OrderManager
@synthesize returnId;
@synthesize systemTime,isSucc,message,money;

-(void)dealloc{

    
    
    systemTime = nil;
    isSucc = nil;
    message = nil;
    money = nil;
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{

    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.isSucc = [drs readComposString1];
                self.message = [drs readComposString1];
                self.money = [drs readComposString1];
            }
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
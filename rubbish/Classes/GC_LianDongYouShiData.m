//
//  GC_LianDongYouShiData.m
//  caibo
//
//  Created by GongHe on 14-4-21.
//
//

#import "GC_LianDongYouShiData.h"
#import "ASIHTTPRequest.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_LianDongYouShiData
@synthesize returnId,returnMessage,payType;
@synthesize sysTime,orderNumber,showMessage,merCustId,realName,idCard;

- (void)dealloc
{
    [sysTime release];
    [orderNumber release];
    [showMessage release];
    [merCustId release];
    [realName release];
    [idCard release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                
                self.sysTime = [drs  readComposString1];
                self.returnMessage = [drs readByte];
                self.orderNumber = [drs  readComposString1];
                self.payType = [drs readByte];
                self.showMessage = [drs  readComposString1];
                self.merCustId = [drs  readComposString1];
                self.realName = [drs  readComposString1];
                self.idCard = [drs  readComposString1];

                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"返回消息 %d", (int)self.returnMessage);
                NSLog(@"订单号 %@", self.orderNumber);
                NSLog(@"支付类型 %d", (int)self.payType);
                NSLog(@"返回提示信息 %@", self.showMessage);
                NSLog(@"商户号 %@", self.merCustId);
                NSLog(@"真实姓名 %@", self.realName);
                NSLog(@"身份证号 %@", self.idCard);
                
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
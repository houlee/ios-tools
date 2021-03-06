//
//  GC_ZhiFuBaoData.m
//  caibo
//
//  Created by yaofuyu on 13-6-20.
//
//

#import "GC_ZhiFuBaoData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_ZhiFuBaoData
@synthesize sysTime, zhifubaoNum,money, name, returnId,zhifuBaoContent;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                
                self.sysTime = [drs  readComposString1];
                self.name = [drs readComposString1];
                self.money = [drs readComposString1];
                self.zhifubaoNum = [drs  readComposString1];
                self.zhifuBaoContent =[drs  readComposString4];
                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"用户名 %@", self.name);
                NSLog(@"金额%@", self.money);
                NSLog(@"支付宝流水号 %@", self.zhifubaoNum);
                NSLog(@"支付宝提交内容 %@", self.zhifuBaoContent);
                
            }
        }
        [drs release];
    }
    return self;
}

- (void)dealloc{
    [sysTime release];
    [name release];
    [money release];
    [zhifubaoNum release];
    [zhifuBaoContent release];
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
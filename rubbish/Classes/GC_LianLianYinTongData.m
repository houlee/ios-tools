//
//  GC_LianLianYinTongData.m
//  caibo
//
//  Created by yaofuyu on 14-3-13.
//
//

#import "GC_LianLianYinTongData.h"

#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_LianLianYinTongData
@synthesize sysTime, returnContent, returnMessage, returnId,Other,realInfo;

- (void)dealloc{
    [sysTime release];
    [returnContent release];
    self.Other = nil;
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                
                self.sysTime = [drs  readComposString1];
                
                if (self.returnId == 2616) {
                    self.returnMessage = [drs readByte];
                    self.returnContent = [drs  readComposString2];
                    self.Other = [drs readComposString2];
                    self.realInfo = [drs readComposString1];
                }
                else if (self.returnId == 2627) {
                    self.returnMessage = [drs readComposString1];
                    self.returnContent = [drs  readComposString1];
                    self.Other = [drs readComposString1];
                    self.realInfo = [drs readComposString1];
                }
                else {
                    self.returnMessage = [drs readByte];
                    self.returnContent = [drs  readComposString1];
                    self.Other = [drs readComposString1];
                    self.realInfo = [drs readComposString1];
                }
                
                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"返回内容 %@", self.returnContent);
                NSLog(@"预留 %@", self.Other);
                NSLog(@"其他信息%@",self.realInfo);
                
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
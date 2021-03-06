//
//  GC_YinLianData.m
//  caibo
//
//  Created by houchenguang on 13-6-2.
//
//

#import "GC_YinLianData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_YinLianData
@synthesize sysTime, returnContent, returnMessage, returnId;

- (void)dealloc{
    [sysTime release];
    [returnContent release];
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
                self.returnMessage = [drs readByte];
                self.returnContent = [drs  readComposString4];
                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"返回消息 %ld", (long)self.returnMessage);
                NSLog(@"返回内容 %@", self.returnContent);
                

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
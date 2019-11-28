//
//  PopularizeData.m
//  caibo
//
//  Created by houchenguang on 13-8-12.
//
//

#import "PopularizeData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation PopularizeData
@synthesize yuliu, sysTime, returnType, returnMsg, setyn;
@synthesize sysid;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.sysid = [drs readShort];
            NSLog(@"sysid = %ld", (long)self.sysid);
            if (![GC_RspError parserError:drs returnId:self.sysid WithRequest:request])
            {
                self.sysTime = [drs readComposString1];
                self.returnType = [drs readComposString1];//0000表示成功
                self.returnMsg = [drs readComposString1];
                self.setyn = [drs readComposString1];
                
                
                
                NSLog(@"sysTime = %@", self.sysTime);
                NSLog(@"returnType = %@", self.returnType);
                NSLog(@"returnMsg = %@", self.returnMsg);
                NSLog(@"setyn = %@", self.setyn);
                
            }
        }
        
        [drs release];
    }
    return self;
}

- (void)dealloc {
    [yuliu release];
    [sysTime release];
    [returnMsg release];
    [returnType release];
    [setyn release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
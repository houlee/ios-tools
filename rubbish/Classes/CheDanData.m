//
//  CheDanData.m
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import "CheDanData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation CheDanData
@synthesize sysid, systime, chedan, msgchedan;

- (void)dealloc{
    
    [systime release];
    [msgchedan release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysid = [drs readShort];
        NSLog(@"返回消息id %ld",(long)self.sysid);
        if (![GC_RspError parserError:drs returnId:sysid WithRequest:request])
		{
            self.systime = [drs readComposString1];
            self.chedan = [drs readByte];
            self.msgchedan = [drs readComposString1];
            
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
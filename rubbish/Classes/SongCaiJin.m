//
//  SongCaiJin.m
//  caibo
//
//  Created by houchenguang on 12-12-21.
//
//

#import "SongCaiJin.h"
#import "GC_RspError.h"
#import "GC_HttpService.h"


@implementation SongCaiJin
@synthesize sysid;
@synthesize code;
@synthesize msg;
@synthesize systime;
@synthesize succeed;
- (void)dealloc{
    
    [code release];
    [succeed release];
    [msg release];
    [systime release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.sysid = [drs readShort];
            if (![GC_RspError parserError:drs returnId:self.sysid WithRequest:request]) {
                self.systime = [drs readComposString1];
                self.code = [drs readComposString1];
                self.msg = [drs readComposString1];
                self.succeed = [drs readComposString1];

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
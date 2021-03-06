//
//  MaxIssueData.m
//  caibo
//
//  Created by houchenguang on 13-2-25.
//
//

#import "MaxIssueData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation MaxIssueData
@synthesize maxcount, systime, sysid, yuliustring, lotterId;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.sysid = [drs readShort];
            NSLog(@"sysid = %ld", (long)self.sysid);
            if (![GC_RspError parserError:drs returnId:self.sysid WithRequest:request])
            {
                self.systime = [drs readComposString1];
                self.lotterId = [drs readComposString1];
                self.maxcount = [drs readByte];
                self.yuliustring = [drs readComposString1];
            
                
                NSLog(@"systime = %@", self.systime);
                NSLog(@"lotterid = %@", self.lotterId);
                NSLog(@"maxcount = %ld", (long)self.maxcount);
                NSLog(@"yuliu = %@", self.yuliustring);
                
            }
        }

        [drs release];
    }
    return self;
}


- (void)dealloc{
    
    [systime release];
    [yuliustring release];
    [lotterId release];
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
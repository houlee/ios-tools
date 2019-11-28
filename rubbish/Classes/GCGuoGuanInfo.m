//
//  GCGuoGuanInfo.m
//  caibo
//
//  Created by houchenguang on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GCGuoGuanInfo.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GCGuoGuanInfo
@synthesize sysid, systime, lottid, issue, quanguo, caiguo, yubei;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysid = [drs readShort];
        NSLog(@"sysid = %d", (int)self.sysid);
        if (![GC_RspError parserError:drs returnId:sysid WithRequest:request]) 
        {
            self.systime = [drs readComposString1];
            self.lottid = [drs readComposString1];
            self.issue = [drs readComposString1];
            self.quanguo = [drs readComposString1];
            self.caiguo = [drs readComposString1];
            self.yubei = [drs readComposString1];
            
        }
            
            
        
        
        [drs release];
    }
    return self;
}



- (void)dealloc{
    [systime release];
    [lottid release];
    [issue release];
    [quanguo release];
    [caiguo release];
    [yubei release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
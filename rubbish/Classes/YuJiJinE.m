//
//  YuJiJinE.m
//  caibo
//
//  Created by  on 12-6-7.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "YuJiJinE.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
@implementation YuJiJinE
@synthesize sysid;
@synthesize systime;
@synthesize maxmoney;
@synthesize minmoney;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysid = [drs readShort];
          if (![GC_RspError parserError:drs returnId:self.sysid WithRequest:request])
              {
        self.systime = [drs readComposString1];
        self.maxmoney = [drs readComposString1];
        self.minmoney = [drs readComposString1];
        NSLog(@"maxmoney = %@", self.maxmoney);
        NSLog(@"minmoney = %@", self.minmoney);
             }
        [drs release];
    }
    return self;
}

- (void)dealloc{
    [systime release];
    [maxmoney release];
    [minmoney release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  ChongZhiData.m
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "ChongZhiData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ChongZhiData
@synthesize systime;
@synthesize sessionid;
@synthesize xiaoxiid;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.xiaoxiid = [drs readShort];
      //  if (![GC_RspError parserError:drs returnId:xiaoxiid])
      //      {
            self.systime = [drs readComposString1];
            self.sessionid = [drs readComposString1];
       //     }
        [drs release];
    }
    return self;
}

- (void)dealloc{
    [sessionid release];
    [systime release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
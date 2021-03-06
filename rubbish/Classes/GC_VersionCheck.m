//
//  GC_VersionCheck.m
//  caibo
//
//  Created by  on 12-6-5.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_VersionCheck.h"
#import "GC_RspError.h"

@implementation GC_VersionCheck
@synthesize systemTime, updateAddr, returnId, reVer, lastVerNum;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
            self.systemTime = [drs readComposString1];
            self.reVer = [drs readByte];
            self.lastVerNum = [drs readInt];
            self.updateAddr = [drs readComposString1];
            
            NSLog(@"系统时间 %@", self.systemTime);
            NSLog(@"最新版更新地址 %@", self.updateAddr);
            
            }
        [drs release];
    }
    return self;
}


- (void)dealloc  {
    [systemTime release];
    [updateAddr release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
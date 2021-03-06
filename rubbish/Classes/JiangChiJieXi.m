//
//  JiangChiJieXi.m
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-3.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "JiangChiJieXi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation JiangChiJieXi


@synthesize systemTime,lottoryID,issure,JiangChi,other;
@synthesize returnId;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.lottoryID = [drs readComposString1];
            self.issure = [drs readComposString1];
            self.JiangChi = [drs readComposString1];
            self.other = [drs readComposString1];
        }
        [drs release];
        
    }
    return self;
    
}

- (void)dealloc {
    self.systemTime = nil;
    self.lottoryID = nil;
    self.issure = nil;
    self.JiangChi = nil;
    self.other = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  DangQianQiData.m
//  caibo
//
//  Created by houchenguang on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DangQianQiData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation DangQianQiData
@synthesize systime;
@synthesize returnVal;
@synthesize yuliu;
@synthesize xxid;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.xxid = [drs readShort];
        if (![GC_RspError parserError:drs returnId:xxid WithRequest:request]) 
        {
            self.systime = [drs readComposString1];
            self.returnVal = [drs readComposString1];
            self.yuliu = [drs readComposString1];
            
            NSLog(@"return = %@", self.returnVal);
        }
        
        
        
        
        [drs release];
    }
    return self;
}


- (void)dealloc{
    [systime release];
    [returnVal release];
    [yuliu release];
    [super dealloc];

}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
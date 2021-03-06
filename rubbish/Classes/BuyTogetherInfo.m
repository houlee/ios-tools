//
//  BuyTogetherInfo.m
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BuyTogetherInfo.h"
#import "SchemeInfo.h"
#import "GC_RspError.h"

@implementation BuyTogetherInfo

@synthesize returnID, systemTime, pageCount, currentPageNumber, recordCount, schemeArray;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        self.returnID = [drs readShort];
        
        self.schemeArray = [NSMutableArray array];
        if (![GC_RspError parserError:drs returnId:returnID WithRequest:request]) {
            self.systemTime = [drs readComposString1];
            self.pageCount = [drs readShort];
            self.currentPageNumber = [drs readShort];
            self.recordCount = [drs readByte];
            
            for (int i = 0; i < recordCount; i++) {
                SchemeInfo *schemeInfo = [[SchemeInfo alloc] initWithDataReadStream:drs];
                [schemeArray addObject:schemeInfo];
                [schemeInfo release];
            }
            
           
        }
        
        [drs release];
    }
    return self;
}

- (void)dealloc {
    [systemTime release];
    [schemeArray release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
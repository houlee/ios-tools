//
//  GuoGuanIssue.m
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GuoGuanIssue.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GuoGuanIssue
@synthesize returnid, systime, issuelen, details;

- (void)dealloc{
    [systime release];
    [details release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnid = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnid WithRequest:request]) 
            {
            self.systime = [drs readComposString1];
            self.issuelen = [drs readByte];
            if (self.issuelen > 0) {
                self.details = [NSMutableArray arrayWithCapacity:self.issuelen];
                for (int i = 0; i < self.issuelen; i++) {
                    GuoGuanIssueDetail * guoguanis = [[GuoGuanIssueDetail alloc] init];
                    guoguanis.startTime = [drs readComposString1];
                    guoguanis.status = [drs readComposString1];
                    guoguanis.issue = [drs readComposString1];
                    guoguanis.openTime = [drs readComposString1];
                    guoguanis.endTime = [drs readComposString1];
                    
                    NSLog(@"issue = %@", guoguanis.issue);
                    NSLog(@"status = %@", guoguanis.status);
                    if ([guoguanis.status isEqualToString:@"3"]) {
                        [self.details addObject:guoguanis];
                    }
                    [guoguanis release];
                }
            }
            
            
            }
        
        [drs release];
    }
    return self;
}

@end


@implementation GuoGuanIssueDetail

@synthesize startTime, status , issue, openTime, endTime;

- (void)dealloc 
{
    [startTime release];
    [status release];
    [issue release];
    [openTime release];
    [endTime release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
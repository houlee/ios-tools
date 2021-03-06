//
//  AccountManage.m
//  Lottery
//
//  Created by jym on 12-1-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GC_AccountManage.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
#import "GC_UserInfo.h"

@implementation GC_AccountManage

@synthesize returnId, dataState; 
@synthesize systemTime;
@synthesize accountBalance, cash, awardAccountBalance, ktxAward, freezedAward, caijinbao;

- (void)dealloc
{
	[systemTime release];
	[accountBalance release];
	[cash release];
	[awardAccountBalance release];
	[ktxAward release];
	[freezedAward release];
    [caijinbao release];
	[super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.dataState = [drs readByte];
                if (self.dataState == 0) {
                    self.accountBalance = [drs readComposString1];
                    NSLog(@"account = %@", self.accountBalance);
                    self.cash = [drs readComposString1];
                    self.awardAccountBalance = [drs readComposString1];
                    NSLog(@"awardAccountBalance = %@", self.awardAccountBalance);
                    self.ktxAward = [drs readComposString1];
                    NSLog(@"ktxAward = %@", self.ktxAward);
                    self.freezedAward = [drs readComposString1];
                    self.caijinbao = [drs readComposString1];
                }
                [GC_UserInfo sharedInstance].accountManage = self;
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
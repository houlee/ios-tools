//
//  PersonalData.m
//  Lottery
//
//  Created by jacob chiang on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_PersonalData.h"
#import "GC_RspError.h"
#import "GC_HttpService.h"
#import "GC_UserInfo.h"

@implementation GC_PersonalData

@synthesize returnID, priorityAccount;
@synthesize systemTime, userName, tureName, identityCardNum, phoneNum, accountBalance, rewardAccount;

- (void)dealloc
{
    [systemTime release];
    [userName  release];
    [tureName release];
    [identityCardNum release];
    [phoneNum release];
    [accountBalance release];
    [rewardAccount release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnID = [drs readShort]; 
            if (![GC_RspError parserError:drs returnId:returnID WithRequest:request]) {
                self.systemTime = [drs readComposString1];
                self.userName = [drs readComposString1WithAES256DecryptKey:AESKey];
                self.tureName = [drs readComposString1WithAES256DecryptKey:AESKey];
                self.identityCardNum = [drs readComposString1WithAES256DecryptKey:AESKey];
                self.phoneNum = [drs readComposString1WithAES256DecryptKey:AESKey];
                self.accountBalance = [drs readComposString1];
                NSLog(@"acc = %@", self.accountBalance);
                self.rewardAccount = [drs readComposString1];
                self.priorityAccount = [drs readByte];
            }
        }
        [drs release];
        [GC_UserInfo sharedInstance].personalData = self;
    }
    return self;
}

// 登陆成功之后调用 （组合信息）
- (id)initWithDataReadStream:(GC_DataReadStream *)drs
{
    if ((self = [super init])) {
        if (drs) {
            self.systemTime = [drs readComposString1];
            self.userName = [drs readComposString1WithAES256DecryptKey:AESKey];
            self.tureName = [drs readComposString1WithAES256DecryptKey:AESKey];
            self.identityCardNum = [drs readComposString1WithAES256DecryptKey:AESKey];
            self.phoneNum = [drs readComposString1WithAES256DecryptKey:AESKey];
            self.accountBalance = [drs readComposString1];
            self.rewardAccount = [drs readComposString1];
            self.priorityAccount = [drs readByte]; 
            
        }        
        [GC_UserInfo sharedInstance].personalData = self;
    }
    return self;
}
    
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
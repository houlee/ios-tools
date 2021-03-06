//
//  DetailsData.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "DetailsData.h"

@implementation DetailsData
@synthesize event;
@synthesize against;
@synthesize result;
@synthesize bet1;
@synthesize bet2;
@synthesize bet3;
@synthesize image;
@synthesize hostName;
@synthesize guestName;
@synthesize sing;

-(id)initWithDuc:(NSDictionary *)dic{
    
        self = [super init];
        if (self) {
            self.guestName = [dic objectForKey:@"guestName"];
            self.hostName = [dic objectForKey:@"hostName"];
            self.event = [dic objectForKey:@"leagueName"];
            self.result = [dic objectForKey:@"caiGuo"];
            self.sing = [NSString stringWithFormat:@"%@",[dic objectForKey:@"singleMatchNumber"]];
            
            self.against = [NSString stringWithFormat:@"%@ vs %@", self.hostName, self.guestName];
            

            if ( [self.sing rangeOfString:@"3"].location != NSNotFound) {
                self.bet1 = @"3";
            }
            
            if ( [self.sing rangeOfString:@"1"].location != NSNotFound) {
                self.bet2 = @"1";
            }
            
            if ( [self.sing rangeOfString:@"0"].location != NSNotFound) {
                self.bet3 = @"0";
            }
       
        }
        return self;
}



- (void)dealloc{
    [sing release];
    [hostName release];
    [guestName release];
    [event release];
    [against release];
    [result release];
    [bet1 release];
    [bet2 release];
    [bet3 release];
    [image release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  PKBetData.m
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "PKBetData.h"

@implementation PKBetData
@synthesize  dandan, dannengyong, nengyong, booldan;
@synthesize event;
@synthesize date;
@synthesize time;
@synthesize team;
@synthesize but1;
@synthesize but2;
@synthesize but3;
@synthesize selection1;
@synthesize selection2;
@synthesize selection3;
@synthesize count;
@synthesize guestName;
@synthesize hostName;
@synthesize timeText, donghuarow, nengdan;

-(id)initWithDuc:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.event = [dic objectForKey:@"leagueName"];
        self.guestName = [dic objectForKey:@"guestName"];
        self.hostName = [dic objectForKey:@"hostName"];
        self.but1 = [dic objectForKey:@"eurWin"];
        self.but2 = [dic objectForKey:@"eurDraw"];
        self.but3 = [dic objectForKey:@"eurLost"];
        self.timeText = [dic objectForKey:@"gameStartDate"];
        NSArray * array = [self.timeText componentsSeparatedByString:@" "];
        NSString * str1 = @"";
        if ([array count] >= 1) {
            str1 = [array objectAtIndex:0];
        }
        
        NSArray * arraydata = [str1 componentsSeparatedByString:@"-"];
        NSString * str2 = @"";
        NSString * str3 = @"";
        if ([arraydata count] >= 2) {
            str2 = [arraydata objectAtIndex:1];
            str3 = [arraydata objectAtIndex:2];
        }
       
        self.date = [NSString stringWithFormat:@"%@-%@", str2, str3];
        
        
        NSString * str4 = @"";
        if ([array count]> 1) {
            str4 = [array objectAtIndex:1];
        }
        NSArray * arraystr = [str4 componentsSeparatedByString:@":"];
        NSString * str5 = @"";
        NSString * str6 = @"";
        if ([arraystr count] > 1) {
            str5 = [arraystr objectAtIndex:0];
            str6 = [arraystr objectAtIndex:1];
        }
        
        self.time = [NSString stringWithFormat:@"%@:%@", str5, str6];
        
   //     self.date = [array objectAtIndex:0];
      //  self.time = [array objectAtIndex:1];
        self.team = [NSString stringWithFormat:@"%@ vs %@", self.hostName, self.guestName];
    }
    return self;
}

- (GC_BetData *)changeToGC_betData {
    GC_BetData *bet = [[[GC_BetData alloc] init] autorelease];
    bet.event = self.event;
    bet.date = self.date;
    bet.time = self.time;
    bet.but1 =self.but1;
    bet.but2 = self.but2;
    bet.but3 = self.but3;
    bet.selection1 = self.selection1;
    bet.selection2 = self.selection2;
    bet.selection3 = self.selection3;
//    NSString * event;//赛事
//    NSString * date;//日期
//    NSString * time;//时间
//    NSString * tram;//哪个队对哪个队
//    NSString * but1;
//    NSString * but2;
//    NSString * but3;
//    BOOL selection1;
//    BOOL selection2;
//    BOOL selection3;
//    NSInteger count;
//    NSString * guestName;
//    NSString * hostName;
//    NSString * timeText;
//    NSInteger donghuarow;
//    BOOL dandan;//存胆值
//    BOOL nengyong;
//    BOOL dannengyong;
//    BOOL booldan;
//    BOOL nengdan;
    return bet;
}


- (void)dealloc{
    [timeText release];
    [hostName release];
    [guestName release];
    [event release];
    [date release];
    [time release];
    [team release];
    [but1 release];
    [but2 release];
    [but3 release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
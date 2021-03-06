//
//  PKBetData.m
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_BetData.h"

@implementation GC_BetData
@synthesize danimage, bufshuarr, jiantouArray;
@synthesize event;
@synthesize date;
@synthesize time;
@synthesize team;
@synthesize but1;
@synthesize but2;
@synthesize but3;
@synthesize booldan;
@synthesize booldan2;
@synthesize booldan3;
@synthesize selection1;
@synthesize selection2;
@synthesize selection3;
@synthesize count;
@synthesize guestName;
@synthesize hostName;
@synthesize timeText;
@synthesize monynum;
@synthesize saishiid;
@synthesize dandan;
@synthesize nengyong;
@synthesize numzhou;
@synthesize changhao, oupeiPeilv, aomenoupei;
@synthesize dannengyong, guestBannerImage, homeBannerImage, pluralString;
@synthesize donghuarow, nyrstr, bifen, caiguo;
@synthesize numtime, bdnum, matchLogo, worldCupBool, zlcString, onePlural, hhonePlural;
@synthesize oupeiarr, oupeistr, cellstring, numbermatch, bdzhou,nengdan, oneMacth, datetime;
@synthesize xianshi1, xianshi2, xianshi3, bisaibiaoti, guoqilefturl, guoqirighturl, yundongurl, xidanCount, zhongzu, macthType, macthTime, timeSort;

-(id)initWithDic:(NSDictionary *)dic{
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
        
        NSString * str1 = [array objectAtIndex:0];
        NSArray * arraydata = [str1 componentsSeparatedByString:@"-"];
        if (arraydata.count < 3) {
            arraydata = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        NSString * str2 = [arraydata objectAtIndex:1];
        NSString * str3 = [arraydata objectAtIndex:2];
        self.date = [NSString stringWithFormat:@"%@-%@", str2, str3];
        
        
        NSString * str4 = [array objectAtIndex:1];
        NSArray * arraystr = [str4 componentsSeparatedByString:@":"];
        if (arraystr.count < 2) {
            arraystr = [NSArray arrayWithObjects:@"",@"", nil];
        }
        NSString * str5 = [arraystr objectAtIndex:0];
        NSString * str6 = [arraystr objectAtIndex:1];
        self.time = [NSString stringWithFormat:@"%@:%@", str5, str6];
        
        //     self.date = [array objectAtIndex:0];
        //  self.time = [array objectAtIndex:1];
        self.team = [NSString stringWithFormat:@"%@,%@", self.hostName, self.guestName];
    }
    return self;
}

- (void)dealloc{
    [pluralString release];
    [hhonePlural release];
    [onePlural release];
    [timeSort release];
    [zlcString release];
    [datetime release];
    [homeBannerImage release];
    [guestBannerImage release];
    [matchLogo release];
    [jiantouArray release];
    [oneMacth release];
    [macthTime release];
    [macthType release];
    [zhongzu release];
    [aomenoupei release];
    [bdnum release];
    [bifen release];
    [caiguo release];
    [bdzhou release];
    [nyrstr release];
    [numbermatch release];
    [cellstring release];
    [bufshuarr release];
    [oupeistr release];
    [oupeiarr release];
    [numtime release];
    [guoqirighturl release];
    [guoqilefturl release];
    [yundongurl release];
    [bisaibiaoti release];
    [xianshi1 release];
    [xianshi2 release];
    [xianshi3 release];
    [danimage release];
    [changhao release];
    [numzhou release];
    [saishiid release];
    [monynum release];
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
    [oupeiPeilv release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  StateUtil.m
//  caibo
//
//  Created by user on 11-8-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StateUtil.h"


@implementation StateUtil
/*1上半场，2中场休息，3下半场
 4 90分钟完场
 5比赛中断 
 6比赛取消
 7 加时上半场
 8 加时中场休息
 9 加时下半场
 10 加时完场
 11 点球
 12 全部结束
 13 延迟
 14斩断
 15待赛
 16 金
 17未开始
 
 */
+(NSString*)getStateString:(NSString*)stateNO{
	if ([stateNO isEqualToString:@"1"]) {
		return @"上半场";
	}else if ([stateNO isEqualToString:@"2"]) {
		return @"中场休息";
	}else if ([stateNO isEqualToString:@"3"]) {
		return @"下半场";
	}else if ([stateNO isEqualToString:@"4"]) {
		return @"90分钟完场";
	}else if ([stateNO isEqualToString:@"5"]) {
		return @"比赛中断";
	}else if ([stateNO isEqualToString:@"6"]) {
		return @"比赛取消";
	}else if ([stateNO isEqualToString:@"7"]) {
		return @"加时上半场";
	}else if ([stateNO isEqualToString:@"8"]) {
		return @"加时中场休息";
	}else if ([stateNO isEqualToString:@"9"]) {
		return @"加时下半场";
	}else if ([stateNO isEqualToString:@"10"]) {
		return @"加时完场";
	}else if ([stateNO isEqualToString:@"11"]) {
		return @"点球";
	}else if ([stateNO isEqualToString:@"12"]) {
		return @"全部结束";
	}else if ([stateNO isEqualToString:@"13"]) {
		return @"延迟";
	}else if ([stateNO isEqualToString:@"14"]) {
		return @"斩断";
	}else if ([stateNO isEqualToString:@"15"]) {
		return @"待赛";
	}else if ([stateNO isEqualToString:@"16"]) {
		return @"金";
	}else if ([stateNO isEqualToString:@"17"]) {
		return @"未开始";
	}
    return nil;
}

+ (int)getState:(NSString*)state
{
    if([state isEqualToString:@""])
    {
        
    }
    return 0;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
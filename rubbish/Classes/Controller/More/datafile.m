//
//  datafile.m
//  caibo
//
//  Created by user on 11-7-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "datafile.h"


@implementation datafile




//获取数据
+ (NSString *)getDataByKey: (NSString *)key
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud stringForKey: key];
}

//写入数据
+ (void)setdata: (NSString *)string forkey: (NSString *)key
{
	NSUserDefaults *value = [NSUserDefaults standardUserDefaults];
	[value setObject: string forKey: key];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  SuperiorMdl.m
//  Experts
//
//  Created by hudong yule on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SuperiorMdl.h"

@implementation SuperiorMdl


+(instancetype)superMdlWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        self.newstar = [dict valueForKey:@"new_star"];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"expertsLeastFiveHitInfo"]) {
        self.SiperiorExpertsLeastFiveHitInfo=value;
    }
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
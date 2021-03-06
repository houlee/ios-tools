//
//  ExpertDetail.m
//  Experts
//
//  Created by v1pin on 15/11/13.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpertDetail.h"

@implementation ExpertDetail

@end

@implementation ExpertBaseInfo

+(instancetype)expertBaseInfoWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"expertsLeastFiveHitInfo"]) {
        self.expertsLeastFiveHitInfo=value;
    }
}

@end


@implementation HistoryPlanList

+(instancetype)historyPlanListWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"matchs"]) {
        self.matchs=value;
    }
}

@end


@implementation LeastTenInfo

+(instancetype)leastTenInfoWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end


@implementation NewPlanList

+(instancetype)newPlanListWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"matchs"]) {
        self.matchs=value;
    }
}

@end

@implementation NewPlanListShuZiCai

+(instancetype)newPlanListShuZiCaiWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation LeastTenPlanListShuangSeQiu

+(instancetype)leastTenPlanListShuangSeQiuWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation LeastTenPlanListDaLeTou

+(instancetype)leastTenPlanListDaLeTouWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation LeastTenPlanList_3D_PaiLie3

+(instancetype)leastTenPlanList_3D_PaiLie3WithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation DgqOlympicMdl

+(instancetype)dgqOlympicMdlWithDic:(NSDictionary *)dict
{
    return [[self alloc] initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end







int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
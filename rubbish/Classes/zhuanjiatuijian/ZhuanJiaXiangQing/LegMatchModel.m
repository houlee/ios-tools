//
//  LegMatchModel.m
//  caibo
//
//  Created by zhoujunwang on 16/1/21.
//
//

#import "LegMatchModel.h"

@implementation LegMatchModel

+(instancetype)legMatchModelWithDic:(NSDictionary *)dict
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


@implementation PurchaseMdl

+(instancetype)purchaseMdlWithDic:(NSDictionary *)dict
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
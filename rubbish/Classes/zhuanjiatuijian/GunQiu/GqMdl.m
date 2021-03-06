//
//  GqMdl.m
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import "GqMdl.h"

@implementation GqXQMdl

+(instancetype)gqXQMdlWithDic:(NSDictionary *)dict;
{
    return [[self alloc] initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.dicNo=[NSMutableDictionary dictionary];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"matchStatus"]) {
        [self.dicNo setValue:value forKey:@"matchStatus"];
    }
    if ([key isEqualToString:@"homeScore"]) {
        [self.dicNo setValue:value forKey:@"homeScore"];
    }
    if ([key isEqualToString:@"awayScore"]) {
        [self.dicNo setValue:value forKey:@"awayScore"];
    }
    if ([key isEqualToString:@"hasBeenMinutes"]) {
        [self.dicNo setValue:value forKey:@"hasBeenMinutes"];
    }
    if ([key isEqualToString:@"recommendStatus"]) {
        [self.dicNo setValue:value forKey:@"recommendStatus"];
    }
    if ([key isEqualToString:@"star"]) {
        [self.dicNo setValue:value forKey:@"star"];
    }
}

@end

@implementation GqMatchInfoMdl

+(instancetype)gqMatchInfoMdlWithDic:(NSDictionary *)dict
{
    return [[self alloc] initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.dicNo=[NSMutableDictionary dictionary];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"MATCH_STATUS"]) {
        [self.dicNo setValue:value forKey:@"MATCH_STATUS"];
    }
}

@end

@implementation GqMatchRecMdl

+(instancetype)gqMatchRecMdlWithDic:(NSDictionary *)dict
{
    return [[self alloc] initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.dicNo=[NSMutableDictionary dictionary];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"homeScore"]) {
        [self.dicNo setValue:value forKey:@"homeScore"];
    }
    if ([key isEqualToString:@"awayScore"]) {
        [self.dicNo setValue:value forKey:@"awayScore"];
    }
    if ([key isEqualToString:@"isChange"]) {
        [self.dicNo setValue:value forKey:@"isChange"];
    }
    if ([key isEqualToString:@"matchStatus"]) {
        [self.dicNo setValue:value forKey:@"matchStatus"];
    }
    if ([key isEqualToString:@"preMinutes"]) {
        [self.dicNo setValue:value forKey:@"preMinutes"];
    }
    if ([key isEqualToString:@"isHaveBought"]) {
        [self.dicNo setObject:value forKey:@"isHaveBought"];
    }
    if ([key isEqualToString:@"star"]) {
        [self.dicNo setValue:value forKey:@"star"];
    }
    if ([key isEqualToString:@"isRecommended"]) {
        [self.dicNo setValue:value forKey:@"isRecommended"];
    }
}

@end

@implementation GqYgRecMdl

+(instancetype)gqYgRecMdlWithDic:(NSDictionary *)dict;
{
    return [[self alloc] initWithDic:dict];
}

-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.dicNo=[NSMutableDictionary dictionary];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"RN"]) {
        [self.dicNo setValue:value forKey:@"RN"];
    }
    if ([key isEqualToString:@"STAR"]) {
        [self.dicNo setValue:value forKey:@"STAR"];
    }
    if ([key isEqualToString:@"AMOUNT"]) {
        [self.dicNo setValue:value forKey:@"AMOUNT"];
    }
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
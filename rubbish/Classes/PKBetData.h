//
//  PKBetData.h
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//pk投注数据接口
#import <Foundation/Foundation.h>
#import "GC_BetData.h"

@interface PKBetData : NSObject{
    NSString * event;//赛事
    NSString * date;//日期
    NSString * time;//时间
    NSString * tram;//哪个队对哪个队
    NSString * but1;
    NSString * but2;
    NSString * but3;
    BOOL selection1;
    BOOL selection2;
    BOOL selection3;
    NSInteger count;
    NSString * guestName;
    NSString * hostName;
    NSString * timeText;
    NSInteger donghuarow;
    BOOL dandan;//存胆值
    BOOL nengyong;
    BOOL dannengyong;
    BOOL booldan;
    BOOL nengdan;
}

-(id)initWithDuc:(NSDictionary *)dic;
- (GC_BetData *)changeToGC_betData;

@property (nonatomic, assign)BOOL dandan, nengyong, dannengyong, booldan, nengdan;
@property (nonatomic, retain)NSString * timeText;
@property (nonatomic, retain)NSString * hostName;
@property (nonatomic, retain)NSString * guestName;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)BOOL selection1;
@property (nonatomic, assign)BOOL selection2;
@property (nonatomic, assign)BOOL selection3;
@property (nonatomic, retain)NSString * event;
@property (nonatomic, retain)NSString * date;
@property (nonatomic, retain)NSString * time;
@property (nonatomic, retain)NSString * team;
@property (nonatomic, retain)NSString * but1;
@property (nonatomic, retain)NSString * but2;
@property (nonatomic, retain)NSString * but3;
@property (nonatomic)NSInteger donghuarow;
@end

//
//  DetailsData.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//方案详情数据接口类
#import <Foundation/Foundation.h>

@interface DetailsData : NSObject{
    NSString * event;//赛事
    NSString * against;//对阵
    NSString * result;//彩果
    NSString *  bet1;//投注
    NSString *  bet2;//投注
    NSString *  bet3;//投注
    UIImage * image;//背景图
    NSString * guestName;
    NSString * hostName;
    NSString * sing;
}
-(id)initWithDuc:(NSDictionary *)dic;
@property (nonatomic, retain)NSString * sing;
@property (nonatomic, retain)NSString * guestName;
@property (nonatomic, retain)NSString *hostName;
@property (nonatomic, retain)NSString * event;
@property (nonatomic, retain)NSString * against;
@property (nonatomic, retain)NSString * result;
@property (nonatomic, retain)NSString * bet1;
@property (nonatomic, retain)NSString * bet2;
@property (nonatomic, retain)NSString * bet3;
@property (nonatomic, retain)UIImage * image;

@end

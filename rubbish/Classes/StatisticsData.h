//
//  StatisticsData.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//第多少期 cell的数据接口  和 我的投注的cell数据接口
#import <Foundation/Foundation.h>


@interface StatisticsData : NSObject{
    NSString * use;//用户名;
    NSString * money;//奖金;
    NSString * number;//注数
    NSString * right;//全对注数;
    NSString * fieldNum;//场次
    NSString * allNum;//所有数;
    UIImage * image;//背景图片
    NSString * time;//投注时间
    NSString * timeNum;//期号
    NSString * rightField;//正确场次
    NSString * orderId;//订单ID
    NSString * userID;
    NSString * timestr;
    NSMutableAttributedString *attributedText;
    
}
-(id)initWithDuc:(NSDictionary *)dic;


@property (nonatomic, retain)NSMutableAttributedString *attributedText;
@property (nonatomic, retain)NSString * timestr;
@property (nonatomic, retain)NSString * orderId;
@property (nonatomic, retain)NSString * userID;
@property (nonatomic, retain)NSString * rightField;
@property (nonatomic, retain)NSString * timeNum;
@property (nonatomic, retain)NSString * time;
@property (nonatomic, retain)NSString * use;
@property (nonatomic, retain)NSString * money;
@property (nonatomic, retain)NSString * number;
@property (nonatomic, retain)NSString * right;
@property (nonatomic, retain)NSString * fieldNum;
@property (nonatomic, retain)NSString * allNum;
@property (nonatomic, retain)UIImage * image;

@end

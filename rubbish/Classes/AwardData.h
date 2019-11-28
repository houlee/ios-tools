//
//  AwardData.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.

//M1中奖排行cell的数据类

#import <Foundation/Foundation.h>
#import "BudgeButton.h"

@interface AwardData : NSObject{
    UIImage * image;//头像图片
    NSString * use;//用户
    NSString * date;//开奖日期
    NSString * money;//奖金
    NSString * budegeValue;//第几
    NSString * userId;//用户id
    NSString * imageUrl;//照片url
 
}

@property (nonatomic, retain)NSString * imageUrl;
@property (nonatomic, retain)NSString * userId;
@property (nonatomic, retain)UIImage * image;
@property (nonatomic, retain)NSString * use;
@property (nonatomic, retain)NSString * date;
@property (nonatomic, retain)NSString * money;
@property (nonatomic, retain)NSString * budegeValue;

@end

//
//  PlanNumTableViewCell.h
//  Experts
//
//  Created by V1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanNumTableViewCell : UITableViewCell
{
    UILabel * _typeOf;//球的种类
    UILabel * _numData;//球是多少期
    UILabel * _timeOfRelease; //发布时间
    
    
    UILabel * _price;  //价格（最近推荐）
    UIImageView * _newStatus; // 是否中 中了多少
    
    UILabel * _seleStatus; // 销售状态
    UILabel * _numPrice; // 价格(历史战绩)
    
}

#pragma mark - 最新推荐 的结构

-(void)TypeOf:(NSString *)TypeOf NumData:(NSString *)NumData TimeOfRelease:(NSString *)TimeOfRelease Price:(NSString *)Price NewStatus:(NSString *)NewStatus;

#pragma mark - 历史战绩 的结构

-(void)TypeOf:(NSString *)TypeOf NumData:(NSString *)NumData TimeOfRelease:(NSString *)TimeOfRelease SeleStatus:(NSString *)SeleStatus NumPrice:(NSString *)NumPrice;

@end

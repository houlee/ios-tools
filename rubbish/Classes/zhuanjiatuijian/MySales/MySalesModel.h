//
//  MySalesModel.h
//  Experts
//
//  Created by V1pin on 15/11/12.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySalesModel : NSObject

@property(nonatomic,strong)NSString * monthDayName;//30日-星期二
@property(nonatomic,strong)NSMutableArray * billList;

@end


@interface MonthDayDataModel : NSObject

@property(nonatomic,strong)NSString * ALL_AMOUNT;
@property(nonatomic,strong)NSString * AMOUNT;
@property(nonatomic,strong)NSString * AWAY_NAME;//客队
@property(nonatomic,strong)NSString * DAY_NAME;
@property(nonatomic,strong)NSString * ER_AGINT_ORDER_ID;
@property(nonatomic,strong)NSString * ER_ISSUE;//期次
@property(nonatomic,strong)NSString * EXPERTS_CLASS_CODE;//001、002
@property(nonatomic,strong)NSString * HOME_NAME;//主队
@property(nonatomic,strong)NSString * LOTTERY_CLASS_CODE;//202、-201   201--二串一
@property(nonatomic,strong)NSString * LOTTERY_CLASS_NAME;
@property(nonatomic,strong)NSString * TYPE_INFO;//(0:老订单,1:精选方案,2:方案套餐,3:包月计划V1,4:包月计划V2)

@end


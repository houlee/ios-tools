//
//  UUChart.h
//	Version 0.1
//  UUChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChart.h"
#import "UUColor.h"
#import "UUBarChart.h"

@class UUChart;

@protocol UUChartDataSource <NSObject>

@required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart;

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart;

- (NSArray *)chartConfigRateValue:(UUChart *)chart;

- (NSArray *)chartConfigHitValue:(UUChart *)chart;

@optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart;

//显示数值范围
- (CGRange)chartRange:(UUChart *)chart;

@end


@interface UUChart : UIView

- (id)initwithUUChartDataFrame:(CGRect)rect withSource:(id<UUChartDataSource>)dataSource;

- (void)showInView:(UIView *)view;

- (void)strokeChart;

@end

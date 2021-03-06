//
//  UUChart.m
//  UUChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUChart.h"

@interface UUChart ()

@property (strong, nonatomic) UUBarChart * barChart;

@property (assign, nonatomic) id<UUChartDataSource> dataSource;

@end

@implementation UUChart

-(id)initwithUUChartDataFrame:(CGRect)rect withSource:(id<UUChartDataSource>)dataSource{
    self.dataSource = dataSource;
    return [self initWithFrame:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)setUpChart{
    if (!_barChart) {
        _barChart = [[UUBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_barChart];
    }
    if ([self.dataSource respondsToSelector:@selector(chartRange:)]) {
        [_barChart setChooseRange:[self.dataSource chartRange:self]];
    }
    if ([self.dataSource respondsToSelector:@selector(chartConfigColors:)]) {
        [_barChart setColors:[self.dataSource chartConfigColors:self]];
    }
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(35*MyWidth/320, 0, 0.5, _barChart.frame.size.height)];
    line.backgroundColor=SEPARATORCOLOR;
    [_barChart addSubview:line];
    
    [_barChart setYValues:[self.dataSource chartConfigAxisYValue:self]];
    [_barChart setXLabels:[self.dataSource chartConfigAxisXLabel:self]];
    [_barChart setYTotalValues:[self.dataSource chartConfigRateValue:self]];
    [_barChart setHitValues:[self.dataSource chartConfigHitValue:self]];
    [_barChart strokeChart]; 
}

- (void)showInView:(UIView *)view
{
    [self setUpChart];
    [view addSubview:self];
}

-(void)strokeChart
{
	[self setUpChart];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
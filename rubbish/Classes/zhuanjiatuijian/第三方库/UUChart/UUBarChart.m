//
//  UUBarChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUBarChart.h"
#import "UUChartLabel.h"
#import "UUBar.h"

@interface UUBarChart ()
{
    UIScrollView *myScrollView;
}
@end

@implementation UUBarChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(35*MyWidth/320, 0, frame.size.width-35*MyWidth/320, frame.size.height)];
        [self addSubview:myScrollView];
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
//    [self setYLabels:yValues];
}

- (void)setYTotalValues:(NSArray *)yTotalValues{
    _yTotalValues=yTotalValues;
    [self setYLabels:_yTotalValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 5) {
        max = 5;
    }
    _yValueMin = 0;
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    float level = (_yValueMax-_yValueMin) /5.0;
    CGFloat chartCavanHeight = self.frame.size.height - 15;
    
    for (int i=0; i<6; i++) {
        CGSize headerViewSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"%.f",level * i+_yValueMin] andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(17.5*MyWidth/320-headerViewSize.width/2,chartCavanHeight-headerViewSize.height-23*i, headerViewSize.width, headerViewSize.height)];
		label.text = [NSString stringWithFormat:@"%.f",level * i+_yValueMin];
		[self addSubview:label];
    }
}

-(void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    NSInteger num;
    if (xLabels.count>=8) {
        num = 8;
    }else if (xLabels.count<=4){
        num = 4;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = myScrollView.frame.size.width/num;
    
    for (int i=0; i<xLabels.count; i++) {
        CGSize headerViewSize=[PublicMethod setNameFontSize:xLabels[i] andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(23*MyWidth/320+44*MyWidth/320*i, self.frame.size.height-headerViewSize.height-5, 20*MyWidth/320,headerViewSize.height)];
        label.text = xLabels[i];
        label.font=FONTTWENTY;
        label.textColor=BLACK_EIGHTYSEVER;
        label.textAlignment=NSTextAlignmentCenter;
        [myScrollView addSubview:label];
        [_chartLabelsForX addObject:label];
    }
    
    float max = (([xLabels count]-1)*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (myScrollView.frame.size.width < max-10) {
        myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

-(void)strokeChart
{
    for (int i=0; i<6; i++) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 135-23*i, self.frame.size.width, 0.5)];
        [view setBackgroundColor:[UIColor colorWithHexString:@"f7f3f0"]];
        [myScrollView addSubview:view];
    }
    for (int i=0; i<_yValues.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _yValues[i];
        NSArray *totalchildAry = _yTotalValues[i];
        NSArray *hitRateAry = _hitValues[i];
        for (int j=0; j<childAry.count; j++) {
            NSString *valueString = childAry[j];
            NSString *valueTotalString = totalchildAry[j];
            float value = [valueString floatValue];
            float valueTotal = [valueTotalString floatValue];
            float grade = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            float gradeTotal = ((float)valueTotal-_yValueMin) / ((float)_yValueMax-_yValueMin);
            
            UUBar * barTotal = [[UUBar alloc] initWithFrame:CGRectMake(22*MyWidth/320+44*MyWidth/320*j, 135-115*gradeTotal, 22*MyWidth/320, 115*gradeTotal)];
            barTotal.barColor = [_colors objectAtIndex:1];
//            barTotal.grade = gradeTotal;
            [myScrollView addSubview:barTotal];
            
            UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake(22*MyWidth/320+44*MyWidth/320*j, 135-115*grade, 22*MyWidth/320, 115*grade)];
            bar.barColor = [_colors objectAtIndex:0];
//            bar.grade = grade;
            [myScrollView addSubview:bar];
            
            CGSize headerViewSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"%@",[hitRateAry objectAtIndex:j]] andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

            UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(barTotal.frame.origin.x+barTotal.frame.size.width/2-headerViewSize.width/2, CGRectGetMinY(barTotal.frame)-5-headerViewSize.height, headerViewSize.width, headerViewSize.height)];
            lab.textColor=[UIColor colorWithRed:172.0/255 green:93.0/255 blue:68.0/255 alpha:0.87];
            lab.font=FONTTWENTY;
            lab.textAlignment=NSTextAlignmentCenter;
            lab.backgroundColor=[UIColor clearColor];
            lab.text=[NSString stringWithFormat:@"%@",[hitRateAry objectAtIndex:j]];
            [myScrollView addSubview:lab];
        }
    }
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
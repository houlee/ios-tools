//
//  LeftChartView.h
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import <UIKit/UIKit.h>

@class ChartFormatData;
@class YiLouChartData;

@interface LeftChartView : UIView
{
    ChartFormatData * chartFormatData;
    
    float heght;//开奖号y
    
    float myLottoryWidth;
    float myHeWidth;
}

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;

@end

//
//  ChartYiLouView.h
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import <UIKit/UIKit.h>

@class ChartFormatData;

@interface ChartYiLouView : UIView
{
    ChartFormatData * chartFormatData;
    
    CGContextRef context;
    int iii;
    int jjj;
    
//    float xAxle;//开奖号x
    float heght;//开奖号y
    
//    int spacing;//间隔数量
    
    NSString * lottoryType;//彩票类型
    NSArray * yiLouArray;//遗漏值
    NSString * sameNumber;
    
    CGRect squareRect;//最底层方形大小
    
    int firstNumber;
    
    BOOL yiLouSmall;
    
    float myLottoryWidth;
    float myHeWidth;
}

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;

@end

//
//  ChartTitleView.h
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import <UIKit/UIKit.h>

@class ChartFormatData;

@interface ChartTitleView : UIView
{
    ChartFormatData * chartFormatData;
}
- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;

@end

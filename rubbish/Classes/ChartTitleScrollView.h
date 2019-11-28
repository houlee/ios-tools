//
//  ChartTitleScrollView.h
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import <UIKit/UIKit.h>

@class ChartFormatData;

@interface ChartTitleScrollView : UIScrollView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;

@end

//
//  ChartLeftScrollView.h
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import <UIKit/UIKit.h>

@class ChartFormatData;

@interface ChartLeftScrollView : UIScrollView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;

@end

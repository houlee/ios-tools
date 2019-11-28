//
//  UITitleYiLouView.h
//  caibo
//
//  Created by houchenguang on 14-3-21.
//
//

#import <UIKit/UIKit.h>
#import "ChartFormatData.h"

@protocol UITitleYiLouViewDelegate <NSObject>
@optional
- (void)returnTitleScrollViewContOffSet:(CGPoint)point;

@end


@interface UITitleYiLouView : UIView<UIScrollViewDelegate>{

     ChartFormatData * chartFormatData;
    id<UITitleYiLouViewDelegate>delegate;
}

@property(nonatomic,retain)ChartFormatData * chartFormatData;
@property (nonatomic, assign)id<UITitleYiLouViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;
- (void)returnTitleScrollViewContOffSet:(CGPoint)point;
@end

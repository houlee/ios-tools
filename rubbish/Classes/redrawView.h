//
//  redrawView.h
//  CPgaopin
//
//  Created by houchenguang on 13-11-18.
//
//

#import <UIKit/UIKit.h>
#import "UpLoadView.h"
#import "ChartFormatData.h"

@protocol redrawViewDelegate <NSObject>
@optional
- (void)returnScrollViewContOffSet:(CGPoint)point ;

@end

@interface redrawView : UIView<UIScrollViewDelegate>
{
    ChartFormatData * chartFormatData;
    id<redrawViewDelegate>delegate;
}


-(void)reduction;

@property (nonatomic, retain)NSArray * allArray;
@property (nonatomic, retain)ChartFormatData * chartFormatData;
@property (nonatomic, assign) id<redrawViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData;
- (void)returnScrollViewContOffSet:(CGPoint)point;

@end

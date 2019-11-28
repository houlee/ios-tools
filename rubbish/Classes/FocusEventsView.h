//
//  FocusEventsView.h
//  caibo
//
//  Created by GongHe on 2016/10/11.
//
//

#import <UIKit/UIKit.h>
#import "YH_PageControl.h"
#import "GC_JingCaiDuizhenResult.h"

@class FocusEventsView;

@protocol FocusEventsViewDelegate <NSObject>

-(void)focusEventsView:(FocusEventsView *)focusEventsView;

@end

@interface FocusEventsView : UIView <UIScrollViewDelegate>
{
    NSMutableArray * _dataArray;
    YH_PageControl * _pageControl;

    NSArray * _moneySelectArray;
}

@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) UIScrollView * mainScrollView;
@property (nonatomic, retain) UIImageView * bgImageView;
@property (nonatomic, retain) UIImageView * titleImageView;

@property (nonatomic, retain) UIView * curEventView;
@property (nonatomic, retain) NSString * curSelectedOdds;
@property (nonatomic, retain) NSString * payMoney;
@property (nonatomic, assign) int curSelectedTag;

@property (nonatomic, assign) id <FocusEventsViewDelegate> delegate;

@end

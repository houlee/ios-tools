
//
//  CBRefreshTableHeaderView.m
//  caibo
//
//  Created by jacob on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

typedef enum{
	CBPullRefreshPulling = 0,      // 下拉
	CBPullRefreshNormal,           // 正常
	CBPullRefreshLoading,          // 释放正在更新	
    CBPullRefreshzhongjian
} CBPullRefreshState;

@protocol CBRefreshTableHeaderDelegate;

@interface CBRefreshTableHeaderView : UIView 
{
	id _delegate;
	CBPullRefreshState _state;

	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
    UIImageView *_activityView;
//	UIActivityIndicatorView *_activityView;
    BOOL isChangeRefresh;
    CALayer *layer1;
    
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    size_t index;
	size_t count;
    size_t num;
    size_t index3;
    NSMutableArray *imageArray;
    UIImageView *shuaxinIma;
    int imaCount;
    
    BOOL loadFinish;
}

@property(nonatomic,assign) id <CBRefreshTableHeaderDelegate> delegate;
@property(nonatomic,assign) BOOL isChangeRefresh;
@property(nonatomic,retain) CALayer* layer1;
@property(nonatomic,retain) UIImageView *_activityView;

- (id)initWithFrame:(CGRect)frame andIsChangeRefresh:(BOOL)_ischangerefresh;

- (void)refreshLastUpdatedDate;
- (void)CBRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)CBRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)CBRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)setState:(CBPullRefreshState)aState;

//- (void)play:(size_t)pic;

@end

@protocol CBRefreshTableHeaderDelegate

- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view;
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view;

@optional
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view;
@end

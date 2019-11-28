//
//  GuideView.h
//  caibo
//
//  Created by yao on 12-1-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "TouchImageView.h"
#import "YH_PageControl.h"

@interface GuideView : UIView<UIScrollViewDelegate,imageTouchDelegate> {
	UIScrollView *myScrollView;
	YH_PageControl *myPageCotntrol;
	NSInteger totlePage;
	NSInteger pageNum;
	NSInteger requestCount;
	BOOL disMiss;
}

-(void)LoadPageCount:(NSInteger)page;
-(void)LoadImageArray:(NSArray *)imageArray;

@property(nonatomic,retain)UIScrollView *myScrollView;
@property(nonatomic,retain)UIPageControl *myPageCotntrol;

@end

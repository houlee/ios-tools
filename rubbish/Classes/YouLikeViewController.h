//
//  YouLikeViewController.h
//  caibo
//
//  Created by yao on 11-12-2.
//  Copyright 2011 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
@class ASIHTTPRequest;

@interface YouLikeViewController : UIViewController<CBRefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate> {
	UITableView *mTableView;
	CBRefreshTableHeaderView *mRefreshView;
	ASIHTTPRequest *request;
	BOOL isLoading;
	UISegmentedControl *mySegment;
	NSDictionary *dataDic;
	NSInteger selectIndex;
	MoreLoadCell *fansMoreCell;
	BOOL isLoadingMore;
}

@property (nonatomic,retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,retain)UITableView *mTableView;
@property (nonatomic,retain)ASIHTTPRequest *request;
@property (nonatomic,retain)UISegmentedControl *mySegment;
@property (nonatomic,retain)NSDictionary *dataDic;

@end

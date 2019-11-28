//
//  MoreNewsViewController.h
//  caibo
//
//  Created by yao on 11-12-9.
//  Copyright 2011 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
@class ASIHTTPRequest;
@interface MoreNewsViewController : UIViewController<CBRefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate> {
	UITableView *mTableView;
	CBRefreshTableHeaderView *mRefreshView;
	BOOL isLoading;
	NSDictionary *dataDic;
	NSInteger selectIndex;
	MoreLoadCell *moreCell;
	BOOL isLoadingMore;
	NSDictionary *dicData;
}

@property (nonatomic,retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,retain)UITableView *mTableView;
@property (nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic,retain)NSDictionary *dicData;

@end
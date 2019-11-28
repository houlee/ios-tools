//
//  CollectViewController.h
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


//  用户 收藏 界面

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"

#import "MoreLoadCell.h"
#import "CPViewController.h"

@class ASIHTTPRequest;




@interface CollectViewController : CPViewController<UITableViewDelegate,UITableViewDataSource, CBRefreshTableHeaderDelegate,HomeCellDelegate> {
	
	ASIHTTPRequest *request;
	
	CBRefreshTableHeaderView *_refreshHeaderView;
    UITableView *mTableView;
	
	BOOL _reloading;
	
	
	MoreLoadCell *collectmoreCell;
	
	
	NSMutableArray *collectListarry;
	
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
	
    ASIHTTPRequest * orignalRequest;
    
    ASIHTTPRequest * likeRequest;
    
    YtTopic * likeYtTopic;
    UIButton * likeButton;
}

@property(nonatomic,retain)	NSMutableArray *collectListarry;

@property(nonatomic,retain)ASIHTTPRequest *request;

@property (nonatomic,retain)ASIHTTPRequest * orignalRequest;

@property (nonatomic,retain)ASIHTTPRequest * likeRequest;


-(void)sendCollectRequest;

- (void)reloadTableViewDataSource;


// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

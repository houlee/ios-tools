//
//  AttentionViewController.h
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// 用户 关注 人 列表 界面 需要传入 userID

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "CPViewController.h"

@class ASIHTTPRequest;

@interface AttentionViewController : CPViewController <UITableViewDelegate,UITableViewDataSource, CBRefreshTableHeaderDelegate>
{
	
	ASIHTTPRequest *request;
	
	CBRefreshTableHeaderView *_refreshHeaderView;
    
    UITableView *mTableView;
	
	BOOL _reloading;
	
	NSString *userID;
	
	NSMutableArray *mAttenList;
	
	MoreLoadCell *attenMoreCell;
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
    BOOL ishome;
}

@property(nonatomic,retain)NSMutableArray *mAttenList;

@property(nonatomic,retain)NSString *userID;

@property (nonatomic,retain)ASIHTTPRequest *request;
@property (nonatomic, assign)BOOL ishome;
- (void)reloadTableViewDataSource;


// 粉丝列表请求
-(void)attenListRequest;

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

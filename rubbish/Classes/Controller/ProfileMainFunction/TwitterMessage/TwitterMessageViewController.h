//
//  TwitterMessageViewController.h
//  caibo
//
//  Created by jacob on 11-6-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// 用户 所发 微博列表 界面 需要传入 uiserID

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"

#import "MoreLoadCell.h"
#import "CPViewController.h"
@class ASIHTTPRequest;


@interface TwitterMessageViewController : CPViewController<UITableViewDelegate,UITableViewDataSource, CBRefreshTableHeaderDelegate,HomeCellDelegate> {
	
	
	ASIHTTPRequest *request;
	
	CBRefreshTableHeaderView *_refreshHeaderView;
	
    UITableView *mTableView;
	BOOL _reloading;
	
	// 需要传入 userID
	NSString *userID;
		
	//接收 请求 返回 数据
	NSMutableArray *messageListArray;
	
	
	MoreLoadCell *messageMoreCell;
	
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
    BOOL xitongtz;
	
    ASIHTTPRequest * orignalRequest;

    ASIHTTPRequest * likeRequest;
    
    YtTopic * likeYtTopic;
    UIButton * likeButton;
}

@property (nonatomic,retain)NSMutableArray *messageListArray;

@property (nonatomic,retain)NSString *userID;

@property (nonatomic,retain)ASIHTTPRequest *request;
@property (nonatomic, assign)BOOL xitongtz;
@property (nonatomic,retain)ASIHTTPRequest *orignalRequest;

@property (nonatomic,retain)ASIHTTPRequest * likeRequest;

- (void)reloadTableViewDataSource;


// 发送  用户 发帖 列表 请求
-(void)listYtTopicByUserIdRequest;

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

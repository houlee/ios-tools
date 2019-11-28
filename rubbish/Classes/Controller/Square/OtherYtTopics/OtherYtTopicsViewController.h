//
//  OtherYtTopicsViewController.h
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"

@class MoreLoadCell;

@class ASIHTTPRequest;


@interface OtherYtTopicsViewController : UITableViewController <CBRefreshTableHeaderDelegate,UIActionSheetDelegate>{
	
	ASIHTTPRequest *request;
	
	CBRefreshTableHeaderView *_refreshHeaderView;
	
	BOOL _reloading;
	
	NSString *topictype;
	
	NSMutableArray *otherTopicListarry;
	
	
	MoreLoadCell *moreCell;
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
	
	
	// 判断是否是 登录前 
	BOOL beforeLogin;
}

@property(nonatomic,retain)NSString*topictype;

@property(nonatomic,retain)	NSMutableArray *otherTopicListarry;

@property(nonatomic,getter=beforeLogin)BOOL beforeLogin;

@property(nonatomic,retain)ASIHTTPRequest *request;


- (void)reloadTableViewDataSource;

-(id)initWithTopicType:(NSString*)topicType;



// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

-(void)sendOtherYtRequest;

@end

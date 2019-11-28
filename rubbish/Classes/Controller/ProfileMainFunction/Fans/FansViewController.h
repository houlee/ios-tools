//
//  FansViewController.h
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "CPViewController.h"
#import "CP_TabBarViewController.h"
@class ASIHTTPRequest;

@interface FansViewController : CPViewController<CP_TabBarConDelegate, UITableViewDelegate,UITableViewDataSource, CBRefreshTableHeaderDelegate, UIActionSheetDelegate> {
	
	ASIHTTPRequest *request;
    
    UIImageView *bgImage;
	
	BOOL isPK;//PK赛搜索
	BOOL cpthree;//投注站搜索
    BOOL hemai;//合买大厅的搜索
	CBRefreshTableHeaderView *_refreshHeaderView;
	
	BOOL _reloading;
	
    UITableView *mTableView;
	// 获取 粉丝 列表 需要传入的 用户ID
	NSString *userID;
	
	NSString *keyWord;
	
	
	BOOL isseachView;
	CP_TabBarViewController * tabc;
	
	NSMutableArray *fansListArray;
	
	MoreLoadCell *fansMoreCell;
	
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
	
    UIViewController *mController;
    
    NSString * userName;
    NSString * userid;
    NSString * useruname;
    BOOL rightbut;
    BOOL titlebool;
    NSString * titlestring;
}

@property (nonatomic,retain)NSString * userName, *titlestring;
@property (nonatomic, retain)NSString * userid;
@property (nonatomic, assign) BOOL rightbut, titlebool;
@property (nonatomic)BOOL cpthree;
@property (nonatomic)BOOL hemai;
@property (nonatomic)BOOL isPK;

@property(nonatomic,retain)NSMutableArray *fansListArray;

@property(nonatomic,retain)NSString*userID;

@property(nonatomic,retain)NSString *keyWord;

@property(nonatomic,retain)ASIHTTPRequest *request;

@property (nonatomic, assign) UIViewController *mController;


- (void)reloadTableViewDataSource;

-(void)reloadBackBtton;

-(id)initWithKeywords:(NSString*)keywords cpthree:(BOOL)_cphtree;

-(id)initWithKeywords:(NSString*)keywords;

// 粉丝列表请求
-(void)fansListRequest;

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

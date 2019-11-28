//
//  TopicThemeListViewController.h
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**话题下 发帖 详细列表（搜 微博 列表）
 **
 ***/


#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "YtTheme.h"
#import "ProgressBar.h"
#import "CPViewController.h"

@class ASINetworkQueue;
@class ASIHTTPRequest;


typedef enum {
    CpSanLiuWuno,
    CpSanLiuWuyes,
}CpSanLiuWu;

@interface TopicThemeListViewController: CPViewController <CBRefreshTableHeaderDelegate, UITableViewDataSource, UITableViewDelegate, PrograssBarBtnDelegate,HomeCellDelegate>
{
	CBRefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
	
	NSString *userId, *themeName, *themeId;
	
	MoreLoadCell *moreCell;
	
	UITableView *tableView;
	
	NSMutableArray *themeTopicVec;
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
    
    ProgressBar *mProgressBar;
    
    UIButton *mCollectBtn;
    UIButton *addCollectionBtn;
    UIButton *cancelCollectionBtn;
    IBOutlet UIButton * topButton;
    ASINetworkQueue *mNetworkQueue;
    ASIHTTPRequest *mRequest;
    CpSanLiuWu cpsanliu;
    BOOL three;//判断是固定话题 还是后台话题
    BOOL jinnang;
    BOOL homebool;
    IBOutlet UIImageView * upImageView;

    ASIHTTPRequest *orignalRequest;
    
    ASIHTTPRequest * likeRequest;
    
    YtTopic * likeYtTopic;
    UIButton * likeButton;
}
@property (nonatomic)BOOL three, jinnang;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *themeTopicVec;
@property (nonatomic, retain) NSString *userId, *themeName, *themeId;
@property (nonatomic, retain) UIButton *mCollectBtn;
@property (nonatomic, retain) ASIHTTPRequest *mRequest;
@property (nonatomic) CpSanLiuWu cpsanliu;
@property (nonatomic, assign)BOOL homebool;

@property (nonatomic,retain)ASIHTTPRequest *orignalRequest;

@property (nonatomic,retain)ASIHTTPRequest * likeRequest;

//@property(nonatomic,retain)ASINetworkQueue *mNetworkQueue;
- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename homebol:(BOOL)hbol;
- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename;
- (void)reloadTableViewDataSource;
- (void)sendThemeYtTopicrequet;
- (IBAction)doWriteTopic;

- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename andTest:(NSString *)testName;
// 改变收藏按钮
- (void)changeCollectBtn:(UIButton*)button;

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

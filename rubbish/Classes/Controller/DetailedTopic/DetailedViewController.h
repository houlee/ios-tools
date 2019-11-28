//
//  帖子详情列表
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressBar.h"
#import "DetailedView.h"
#import "UserCellView.h"
#import "YtTopic.h"
#import "ASIHTTPRequest.h"
#import <MessageUI/MessageUI.h>
#import "CommentViewController.h"

#import "CBRefreshTableHeaderView.h"
#import "LoadCell.h"
#import "ForwardView.h"
#import "CPViewController.h"
#import "CP_PTButton.h"

@protocol DetailedDelegate <NSObject>

@optional
- (void)returnshifouguanzhu:(NSString *)guanzhu row:(NSInteger)inrow;
- (void)returnshifoushanchu:(NSInteger)shanchu;
@end

typedef enum
{
    ActionOne = 0,
    ActionTwo
}SegmentAction;
@interface DetailedViewController : CPViewController <CBRefreshTableHeaderDelegate,UIActionSheetDelegate, UIAlertViewDelegate, ASIHTTPRequestDelegate,PrograssBarBtnDelegate,UITableViewDelegate,
UITableViewDataSource,DetailedViewDelegate> 
{
    UIScrollView *mScrollView;
    IBOutlet UIButton *mCollectBtn;
    IBOutlet UIImageView * imagedown;
    DetailedView *mDetailedView;
    UserCellView *mUserView;
    
    YtTopic *mStatus;
    ASIHTTPRequest  *mRequest;
    
    UIButton *addCollectionBtn; // 添加收藏
    UIButton *cancelCollectionBtn; // 取消收藏
   IBOutlet UIButton * pinglunbtn;
   IBOutlet UIButton * zhuanfabtn;
   IBOutlet UIButton * fenxiangbtn;
    IBOutlet UIButton * gengduobtn;
	CP_PTButton *zhucebutton;
	BOOL isNeedRefresh;
    id<DetailedDelegate>delegate;

    BOOL homebool;

    UITableView *dTableView;
    
    CBRefreshTableHeaderView *mRefreshView;
    BOOL mReloading;// 是否正在更新数据
    BOOL topicLoadedEnd;
    
    int mSection;// 当前选中的位置
    LoadCell *loadCell;
    MoreLoadCell *moreCell;
    
    NSMutableArray *mCommentArray;
    NSInteger index;
    NSInteger indexTwo;
    
    SegmentAction actionIndex;
    
    BOOL isDeleted;
    NSInteger  count_plstr;
    NSInteger inrowcount;
    ASIHTTPRequest * amRequest;

    BOOL isFromFlashAd;
    
    ASIHTTPRequest *autoRequest;
    
    BOOL isAutoQuestion;//由经典问题或近期问题进入
    
    
    UIButton *bentieButton;
    UIButton *yuantieButton;
    UILabel *yuantieLabel;
    UILabel *bentieLabel;
    UIView *SegmentView;
    UIImageView *xian;
    BOOL yuantie;
}

@property (nonatomic, assign)BOOL homebool;
@property(nonatomic, retain) ASIHTTPRequest *mRequest, *amRequest,*autoRequest;
@property(nonatomic, retain) YtTopic *mStatus;
@property(nonatomic, retain) UIButton *mCollectBtn;
@property (nonatomic, assign)id<DetailedDelegate>delegate;
@property (nonatomic,retain) NSMutableArray *mCommentArray;
@property(nonatomic, retain) UITableView *dTableView;
@property(nonatomic, retain) DetailedView *mDetailedView;
@property (nonatomic, assign)BOOL isDeleted;
@property (nonatomic, assign)BOOL isFromFlashAd;
@property (nonatomic, assign)BOOL isAutoQuestion;
- (id) initWithMessage : (YtTopic *) status;
- (id) initWithMessage : (YtTopic *) status indexrow:(NSInteger)indexrow;
- (IBAction)actionbuttonshouchang:(UIButton *)sender;
- (IBAction) actionRefresh : (id)sender;// 刷新
- (IBAction) actionCommentOrForward : (UIButton *)sender;// 评论or转发
- (IBAction) actionMore : (id)sender;// 更多
- (IBAction)actionShare:(id)sender;//分享
- (void) actionBack : (id)sender;// 返回
- (void)changeCollectBtn:(UIButton*)button; // 改变收藏按钮
+ (DetailedViewController *) getShareDetailedView;
+ (UIViewController *) getShareController;
- (void)returnshifouguanzhu:(NSString *)guanzhu row:(NSInteger)inrow;
// 跳到主页
- (void)doPushHomeView;

-(void)openSMS;
- (void)getMoreComment;
- (void)autoRefresh;

- (void)returnshifoushanchu:(NSInteger)shanchu;
@end
//
//  ProfileViewController.h
//  caibo
//
//  Created by Kiefer on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"
#import "ProgressBar.h"
#import "CPViewController.h"
#import "CP_PTButton.h"
#import "CP_TabBarViewController.h"
#import "GC_WinningInfoList.h"
#import "CP_UIAlertView.h"
@class UserInfo;
@class ASIHTTPRequest;
@class UpLoadView;

@interface ProfileViewController : CPViewController<CP_TabBarConDelegate,UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,PrograssBarBtnDelegate>
{
    UIImageView *headView; //头像
    
    UILabel *lbNickName; //昵称
    IBOutlet UITableView *mTableView; 
    IBOutlet UIActivityIndicatorView *mActivityIV; // 网络状态的圈
    
    UILabel *lbAttentionNum;
    UILabel *lbBlogNum;
    UILabel *lbFansNum;
    UILabel *lbTopicNum;
    
    UIButton *btnAttention;
    UIButton *btnBlog;
    UIButton *btnFans;
    UIButton *btnTopic;
    CP_TabBarViewController * tabc;
    UserInfo *mUserInfo;
    
    ProgressBar *mProgressBar;
    
    IBOutlet UIButton *btnRefresh;
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *btnSendMsg;
    IBOutlet UIButton *btnAddressList;
    
    UIButton *btnRelation; //
    UIButton *btnBlackList; //
    
    UIActionSheet *cancelAttAS; // 
    UIActionSheet *addBlackUserAS; // 
    UIActionSheet *delBlackUserAS; // 
    
    UIImageView *headBG;
    UIButton *btnRelAtt; //
    UIButton *btnRelCancelAtt; //
    CP_PTButton *btnRelDelBlack; //
    
    CP_PTButton *btnAddBlackUser; //
    UIButton *btnDelBlackUser; //
    
    NSString *userId; // 用户id
    NSString *himId; // 他人id
    NSString *himNickName; // 他人昵称
	NSString *relation;//关系；
    
    ASIHTTPRequest *cb_GetUserInfo;
    ASIHTTPRequest *cb_AttUser; // 添加关注
    ASIHTTPRequest *cb_CancelAtt; // 取消关注
    ASIHTTPRequest *cb_AddBlackUser; // 添加黑名单
    ASIHTTPRequest *cb_DelBlackUser; // 解除黑名单
    ASIHTTPRequest *cb_GetBlackRelation ;
    ASIHTTPRequest *cb_GetRelation;
    
    NSString *headImageUrl;
    ImageStoreReceiver *receiver;
    BOOL homebool;
    
    NSArray *all365AccountArray; // 所有365官方账户
    BOOL is365Account;//是否是365官方账号
    
    NSArray * titleArray;
    NSArray * iconNameArray;
    
//    ASIHTTPRequest * getFlagItemRequest;
//    NSArray * flagsArray;
    
//    UpLoadView *loadview;
//    GC_WinningInfoList *winningList;
//    ASIHTTPRequest *myRequest;
//    CP_UIAlertView *flagAlertView;

    NSString * userName;
    NSString * nickName;
    UILabel *weiboCount;
    UILabel *guanzhuCount;
    UILabel *fensiCount;
    UIView *middleView;
}
@property (nonatomic, assign)BOOL homebool;
@property(nonatomic, retain) UITableView *mTableView;
@property(nonatomic, retain) UIButton *btnRefresh;
@property(nonatomic, retain) UIButton *btnAdd;
@property(nonatomic, retain) UIButton *btnSendMsg;
@property(nonatomic, retain) UIButton *btnAddressList;
@property(nonatomic, retain) NSString *himNickName; 
@property(nonatomic, retain) NSString *relation;
@property(nonatomic, retain) ASIHTTPRequest* cb_GetUserInfo;
@property(nonatomic, retain) ASIHTTPRequest* cb_AttUser;// 添加关注
@property(nonatomic, retain) ASIHTTPRequest* cb_CancelAtt;// 取消关注
@property(nonatomic, retain) ASIHTTPRequest* cb_AddBlackUser;// 添加黑名单
@property(nonatomic, retain) ASIHTTPRequest* cb_DelBlackUser;// 解除黑名单
@property(nonatomic, retain) ASIHTTPRequest* cb_GetBlackRelation;
@property(nonatomic, retain) ASIHTTPRequest* cb_GetRelation;

@property(nonatomic, retain) UserInfo *mUserInfo;
@property(nonatomic, retain) NSArray *all365AccountArray;

//@property(nonatomic, retain) ASIHTTPRequest * getFlagItemRequest;

//@property (nonatomic, retain) GC_WinningInfoList *winningList;
//@property (nonatomic, retain) ASIHTTPRequest *myRequest;

// 获取图片
- (void) fetchHeadImage:(NSString *) url;
// 参数初始化
- (void)parameterInit;
// 返回
- (void)doBack;
// 跳到主页
- (void)doPushHomeView;
// 发送请求
- (void)doSendRequest;
// 关注
- (void)pushAttentionView;
// 微博
- (void)pushBlogView;
// 粉丝
- (void)pushFansView;
// 话题
- (void)pushTopicView;
// 刷新
- (void)doRefresh;
// @
- (void)doAdd;
// 发送私信
- (void)doSendMsg;
// 通讯录
- (void)doAddressList;
// 添加黑名单
- (void)doAddBlackUser;
// 解除黑名单
- (void)doDelBlackUser;
// 关注
- (void)doAttUser;
// 取消关注
- (void)doCancelAtt;
// 关闭进度条
- (void)dismissProgressBar;
// 改变关系按钮
- (void)changeRelBtn:(UIButton*)button;
// 改变黑名单按钮
- (void)changeBlackBtn:(UIButton*)button;
-(void)Tadecaipiao;
//他的合买
-(void)Tadehemai;

@end

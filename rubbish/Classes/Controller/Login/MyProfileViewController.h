//
//  MyProfileViewController.h
//  caibo
//
//  Created by Kiefer on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"
#import "CPViewController.h"
//#import "GC_WinningInfoList.h"
#import "UpLoadView.h"
#import "CP_UIAlertView.h"
#import "CP_Actionsheet.h"
#import "UIImageExtra.h"
#import "ProgressBar.h"
#import "CP_PrizeView.h"
@class UserInfo;
@class ASIHTTPRequest;
@class BudgeButton;
@class ColorView;

@protocol MyProfileDelegate <NSObject>

- (void)returnstr1:(NSInteger)str1 str2:(NSInteger)str2 str3:(NSInteger)str3 str4:(NSInteger)str4;

@end


@interface MyProfileViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,CP_ActionsheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CP_PrizeViewDelegate>
{
    UIImageView *headView; // 头像
//    UILabel *lbNickName; // 昵称
    UIButton *btnEdit; // 编辑
    UITableView *mTableView;
    UIImageView *backImage;
  //  UIActivityIndicatorView *mActivityIV; // 网络状态圈
    
    UILabel *lbAttentionNum;
    UILabel *lbBlogNum;
    UILabel *lbFansNum;
    UILabel *lbTopicNum;
    
    UIButton *btnAttention;
    UIButton *btnBlog;
    UIButton *btnFans;
    UIButton *btnTopic;
    
    UserInfo *mUserInfo;
    
    ASIHTTPRequest *reqGetUserInfo;
    ASIHTTPRequest * httprequest;
    NSString *headImageUrl;
    ImageStoreReceiver *receiver;

	
	NSString *noticeFansNum;
	
	BudgeButton *budgeButton;
	
	BOOL isRefresh;
    NSString *  fansstr;
    NSString  *pinglunstr;
    NSString  *atmestr;
    NSString  *sixinstr;
	BOOL shifou;
    UIImageView * imagenum1;
    UIImageView * imagenum2;
    UIImageView * imagenum3;
    UIImageView * imagenum4;
    UIImageView * imagenum5;
    NSInteger str11;
    NSInteger str22;
    NSInteger str33;
    NSInteger str44;
    NSInteger str55;
    NSString * guanzhustr;
    NSString * fensistr;
    BOOL myziliao;
  
    BOOL imagehidd;
    id<MyProfileDelegate>delegate;
    BOOL pophome;
    BOOL homebool;
    BOOL popyes;
    
    NSArray * titleArray;
    NSArray * iconNameArray;
    
//    NSDictionary * testDic;

//    ASIHTTPRequest * signUpRequest;
//    ASIHTTPRequest * getFlagItemRequest;
//    ASIHTTPRequest * getBonusRequest;
//    ASIHTTPRequest * getSignUpStatus;
    
//    NSArray * flagsArray;
//    int seconds;
//    NSTimer * myTimer;
    
//    CFRunLoopRef entRunLoopRef;//倒计时用的runloop

//    ColorView * myCountdown;
//    UILabel * myCaiJinLabel;
//    UIButton * mySignUpButton;
//    BOOL activeOpen;
    
//    ASIHTTPRequest *myRequest;//世界杯国旗获奖列表Request
//    GC_WinningInfoList *winningList; //获奖列表
//    UpLoadView *loadview;

    
//    CP_UIAlertView *flagAlertView;

    
    int initType;
    
    UILabel *weiboCount;
    UILabel *guanzhuCount;
    UILabel *fensiCount;
    UIImage *mHeaderImage;
    NSString *imageUrl;
    ASIHTTPRequest *reqEditPerInfo;
    ProgressBar *mProgressBar;


}

@property (nonatomic, retain)ASIHTTPRequest * httprequest;
@property (nonatomic, assign)id<MyProfileDelegate>delegate;
@property (nonatomic)BOOL myziliao;
@property (nonatomic)NSInteger str11;
@property (nonatomic)NSInteger str22;
@property (nonatomic)NSInteger str33;
@property (nonatomic)NSInteger str44;
@property (nonatomic)BOOL shifou, homebool, popyes;
@property (nonatomic, retain)NSString  *  fansstr;
@property (nonatomic, retain)NSString  *  pinglunstr;
@property (nonatomic, retain) NSString  *  atmestr;
@property (nonatomic, retain)NSString  *  sixinstr;
@property(nonatomic, retain) UIImageView *headView;
@property (nonatomic, retain)UIImage  *mHeaderImage;
//@property(nonatomic, retain) IBOutlet UILabel *lbNickName;
@property(nonatomic, retain) IBOutlet UIButton *btnEdit;
@property(nonatomic, retain) IBOutlet UITableView *mTableView;
//@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *mActivityIV;
@property(nonatomic, retain) ASIHTTPRequest *reqGetUserInfo;
@property(nonatomic, retain) UserInfo *mUserInfo;

@property(nonatomic,retain)NSString *noticeFansNum;

@property(nonatomic,retain)BudgeButton *budgeButton;
@property(nonatomic, retain) ASIHTTPRequest *reqEditPerInfo;

//@property(nonatomic, retain) ASIHTTPRequest * signUpRequest, * getFlagItemRequest, * getBonusRequest,* getSignUpStatus,*myRequest;

//@property (nonatomic,retain)NSTimer *myTimer;
//@property (nonatomic,retain)GC_WinningInfoList *winningList;


// 返回
- (void)doBack;
// 编辑
- (void)doEdit;
// 刷新
- (void)doRefresh;
// 发送请求
- (void)doSendRequest;
// 微博
- (void)pushBlogView;
// 话题
- (void)pushTopicView;

- (void)returnstr1:(NSInteger)str1 str2:(NSInteger)str2 str3:(NSInteger)str3 str4:(NSInteger)str4;

- (id)initWithType:(int)type;//0是资料 1是自己看自己

@end

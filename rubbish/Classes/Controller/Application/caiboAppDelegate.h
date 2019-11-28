//
//  caiboAppDelegate.h
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "Reachability.h"
#import "newHomeViewController.h"
#import "GifView.h"
#import "KFButton.h"
#import "CP_TabBarViewController.h"
#import "NewPostViewController.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "New_PageControl.h"
#import "StartGuidanceView.h"
#import "StartGuideView.h"
#import "CP_APPAlertFlashAdView.h"
#import "StartPageView.h"
#import <AVFoundation/AVFoundation.h>

#import "StartYindaoView.h"
#import "CP_PrizeView.h"
#import "GC_LotteryType.h"


// 提供RGB模式的UIColor定义.
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//
#define OpinionTEXT  @"#iPhone客户端意见反馈#,版本"
#define cbsource @"iPhone 客户端"
#define GIFDATALength 1048576*3
#define CBGuiteName @"游客"
#define CBGuiteID @"0"
#define CBGuiteNiceName @"游客"
#define CBGuitePassWord @"1111"

//#define CPweibo  //打开后为彩票微博的定义

//#ifdef  CPweibo
//#define appVersion    @"3.01"
//#else
//#define appVersion @"2.6"
//#endif
@protocol CBautoPushDelegate;
@class ASIHTTPRequest;

@interface caiboAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,CP_TabBarConDelegate,WXApiDelegate ,WeiboSDKDelegate, UIScrollViewDelegate,StartGuideViewDelegate,CP_AppAlertFlashViewDelegate,AVAudioPlayerDelegate,CP_PrizeViewDelegate,StartYindaoViewDelegate>
{
	ASIHTTPRequest *mrequest;
    ASIHTTPRequest *loginselfRequest;
	UIWindow *window;
    
	// 是否是切换账号
	BOOL changeAccount;
	
	// 是否需要引导；
	BOOL shouldGude;
	
	// 是否是 切换账号时，最后一个 账号，重新登录
	BOOL lastAccount;
	
	// 点击 返回主页 按钮 是否显示下拉刷新
	BOOL isNeedRefresh;
    
    IBOutlet UITabBarItem *homeItem;
    IBOutlet UITabBarItem *focusItem;
    Reachability* hostReach;
	
	//UIAlertView *myalert;
	NSTimer *timer;
	
	id delegate;
	
	GifView *welcomePage;
	ImageDownloader *imageDownloader;
    
    BOOL isBubbleTheme;
    NSString *readingMode;
    int  selectedTab;
    UILabel *msgView;
    
    BOOL needReLog;
    
	BOOL isLongTime;//长时间未操作；
    NSInteger timeCount;//心跳奇数
    BOOL gaodian;
    NSDate * jiangetime;
    NSMutableArray * hylistarray;//保存活跃信息列表
    NSInteger hylistcont;//记录活跃显示第几个
    KFButton * keFuButton;
    NSInteger loginselfcount;
    id uploadDelegatel;
    SEL uploadFinish;
    UILabel * sumsgView;
    NSString * urlVersion;
    
    UIView *sendView;
    NSMutableArray *sendViewControllerArray;
    UIImageView *IpadBackImageV;
    
    BOOL isloginIng;//二次登录锁定，防止反复调用
    
    NSInteger upDataCheck;//是否更新标志 保存
    StartGuidanceView * starGuidan;
    
    UIImage *alertImage; //应用内弹窗图片
    ImageStoreReceiver *receiver;
    
    StartGuideView *guideView; //引导页
    
    int linkType;
    NSString *linkUrl;
    ASIHTTPRequest *autoRequest;

    
    BOOL guidePageOver;
    BOOL welcomePageOver;  //欢迎页结束，弹窗待显示
    
    NSString *all365AccountTxtLength;  //官方账号txt文档 Header 大小
    
    NSString *uploadTime;//应用内弹窗图片更新时间
    
    AVAudioPlayer *audioPlayer;
    UIButton * defaultButton;
    NSString * urlDefault;//deafultbutton上的 openurl地址
    
    ModeTYPE modetype;
    LotteryTYPE lotteryType;
    NSString *jihuoHongbaoMsg;
    
}
@property (nonatomic, assign)NSInteger upDataCheck;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarItem *homeItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *focusItem;

@property (nonatomic, getter = ischangeAccount) BOOL changeAccount;
@property (nonatomic, getter = islastAccount) BOOL lastAccount;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id<CBautoPushDelegate> delegate;
@property (nonatomic, retain) ASIHTTPRequest *mrequest, *loginselfRequest;
@property (nonatomic, readonly) ImageDownloader *imageDownloader;
@property (nonatomic, readwrite) BOOL isBubbleTheme;
@property (nonatomic, retain) NSString *readingMode;
@property (nonatomic, assign) int selectedTab;
@property (nonatomic, readwrite) BOOL isNeedRefresh, gaodian;
@property (nonatomic, retain)NSDate * jiangetime;
@property (nonatomic, retain)NSMutableArray *hylistarray;
@property (nonatomic) NSInteger hylistcont;
@property (nonatomic, retain) KFButton * keFuButton;
@property (nonatomic)NSInteger loginselfcount;
@property (nonatomic, retain)NSString * urlVersion;
@property (nonatomic)BOOL isloginIng;
@property (nonatomic, copy) UIImage *alertImage;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, retain) ASIHTTPRequest *autoRequest;
@property (nonatomic, copy) NSString *uploadTime, * urlDefault;
@property (nonatomic, copy) NSString *jihuoHongbaoMsg;

- (void) openTimer;

//网络监听
- (void) reachabilityChanged:(NSNotification *)note ;
// 跳到主页
- (void) switchToHomeView;
// 跳到登录
- (void) switchToLoginView;
- (void)switchToRegiseView;
// 消息提醒
- (void) changeItemValue:(NSString*)value;
- (void) autoreleaseMessage;
- (int) unReadPushNum:(NSString*)responseString;
- (void)getCaizhongInfo;

//欢迎画面
- (void)addWelcomePage;
- (void)oneLoginFunc;

//ipad额外界面添加view
- (void)showInSencondView:(UIView *)showView ViewControllor:(UIViewController *)theControl;

//显示提示信息
- (void)showMessage:(NSString *)msg;
- (void)showMessage:(NSString *)msg HidenSelf:(BOOL) hiden;
- (void)showjianpanMessage:(NSString *)msg view:(UIWindow *)subview;
- (void)hidenMessage;
- (void)showMessagetishi:(NSString *)msg;//提示1500毫秒
- (void)LogInBySelf;
- (void)LogInBySelfWithIncreace;//sesion超时自动登陆
- (void)clearLoginSession;//清除登陆session测试session超时调用
- (void)LoginForIpad;//ipad登陆
- (void)SettingForiPad;//ipad设置
- (void)XiuGaiTouXiangForiPad:(BOOL)yesorno Save:(BOOL)ye;//ipad修改头像
- (void)upLoadGoodVoiceWithOrderID:(NSString *)orderid Path:(NSString *)path Type:(NSInteger)type Time:(NSInteger)time;
- (void)upLoadGoodVoiceWithOrderID:(NSString *)orderid Path:(NSString *)path Type:(NSInteger)type Time:(NSInteger)time Delegate:(id)delegate Finish:(SEL)finish;
- (void)clearuploadDelegate;
//@他
- (void)WriteWeiBoForiPad:(PublishType)publishtype mStatus:(YtTopic *)topic;
- (void)WriteWeiBoForiPad:(PublishType)publishtype  shareTo:(NSString *)shar isShare:(BOOL)yesOrNo;//发表新微博

- (void)WriteWeiBoForiPad:(NewPostViewController *)newpostContro;//利用创建好的NewPostViewController 直接展示为Ipad模式
- (void)WriteWeiBoForiPad:(PublishType)publishtype mStatus:(YtTopic *)topic three:(BOOL)yesoron;
+ (caiboAppDelegate *)getAppDelegate;
- (UIImage *)imageWithScreenContents;//屏幕截图
- (void) sendImageContent:(UIImage *)imageName;//微信分享图片
- (void) DologinSave;
- (UIImage *)JiePing;//截屏
- (UIImage *)screenshotWithScrollView:(UIScrollView *)scrollView bottomY:(float)bottomY titleBool:(BOOL)yesOrNo;//开奖详情截图

- (void)showNetErrore;//网络请求数据解析错误

- (void)hongBaoFunction:(NSString *)_functionType topicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid;//红包跳转

-(void)goGCPageWithlotteryID:(NSString *)lotteryid andWanfa:(NSString *)wanfa;//彩种、玩法跳转

- (void)goNewHomeView;

-(void) RespLinkContentUrl:(NSString *)url title:(NSString *)titles image:(UIImage *)images content:(NSString *)content;//微信分享链接
-(void) RespLinkContentUrl:(NSString *)url title:(NSString *)titles image:(UIImage *)images content:(NSString *)content wxScene:(int)wxScene;

- (UIImage *)JiePing;//截屏
- (UIImage *)screenshotWithScrollView:(UIScrollView *)scrollView bottomY:(float)bottomY titleBool:(BOOL)yesOrNo Moreheight:(CGFloat)moreheight;//开奖详情截图
-(UITabBarController *)createExpert;

@end

@protocol CBautoPushDelegate

-(void)autoRefresh:(NSString*)responseString;


@end

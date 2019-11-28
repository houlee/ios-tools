//
//  发送微博界面
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FaceSystem.h"
#import "ASIHTTPRequestDelegate.h"
#import "YtTopic.h"
#import "ProgressBar.h"
#import "Draft.h"
#import "CPViewController.h"
#import "CP_PTButton.h"
#import "CP_XZButton.h"
#import "UpLoadView.h"

@class ASIFormDataRequest;
@class ASIHTTPRequest;

// 发布结果
#define RESULT                  @"result"
#define RESULT_SUCC             @"succ"
#define RESULT_FAIL             @"fail"
#define RESULT_EXIST            @"exist"

typedef enum{
    CPThreeTopic,
    CPThreeTopicBack
}CPThree;

typedef enum {
	kNewTopicController,     //发布新消息类型
	kForwardTopicController, //转发类型
    kCommentTopicController, //评论类型
    kEditTopicController,    //草稿箱编辑微博
    kCommentRevert,          //2.51评论回复
    kOpinionFeedBack,         //意见反馈
	KShareController        //分享
}PublishType;

@interface NewPostViewController : CPViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextViewDelegate, UIScrollViewDelegate, ASIHTTPRequestDelegate,PrograssBarBtnDelegate,CLLocationManagerDelegate, UIAlertViewDelegate,UIPopoverControllerDelegate>
{
    UIButton * kefuButton;
    UIButton *btnwan;
    UINavigationItem *mTitle;// 标题栏信息
    UIButton *mBackBtn;      // 返回按钮
    UIButton *mPostBtn;      // 发送按钮
    UITextView *mMessage;    // 输入框控件
    UILabel *yszLabel;//预设字
    //UITextField *mMessage;
    UIButton *mTextCount;     // 输入字数
    UIView *mFunctionController;// 功能列表容器:添加表情按钮；添加图片按钮；添加视频按钮等等
    UIButton *mSaveDraft;// 保存草稿//
    UIButton *mTakeLocation;// 添加地理位置
    UIButton *mTakePhoto;// 拍照
    UIButton *mTakeTopic;// 插入话题
    UIButton *mTakeLinkMan;// @常用联系人
    UIButton *mTakeFace;// 添加表情
    UIButton *mShowPhoto;// 添加进来的图片
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    
    UIImageView *pzImage;//拍照等按钮背景图
    UIButton *pzButton;//拍照
    UIButton *fxButton;//分享
    UIButton *addButton;//@按钮
    UIButton *htButton;//#按钮
    UIButton *faceButton;
    UIButton *zfButton;//转发
    
    UIImage *mSelectImage;
    UIView * caidanview;
    
    PublishType publishType;
    NSMutableArray *viewControllers;
    
    YtTopic *mStatus;
    
    UIButton *mNonceBtn;
    UIButton *mOrignalBtn;
    
    Draft *mDraft;
    
    
    ASIFormDataRequest *mReqData;
    ASIHTTPRequest *mRequest;
    ASIHTTPRequest *mReqUpload;
    
    NSRange mIndex;
    UIImageView *tipsView;
    
    BOOL three;//判断键盘上view的功能键;
    CPThree cpthree;
    
    
    UIButton * share;//分享按钮
    
    UIButton * redButton;
    UIButton * blueButton;
    UIButton * purpleButton;
    UIButton * yellButton;
    
    UIActivityIndicatorView *yrbIndicatorView;
    UIImageView * cpthImage;
    UIImageView * baimageview;
    CP_PTButton *potButton2;
    CP_PTButton *potButton1;
    CP_PTButton *potButton3;
    CP_PTButton *potButton4;
    UIImageView * potimage;
    UIButton * delButton;
    NSString * caizhong;
	UIView *shareView;
	BOOL infoShare;
	BOOL isShare;
	BOOL share0;//新浪微博分享
    NSString * myyuce;//我的预测话题
    UINavigationBar * newpostnavbar;
    CP_XZButton *Btn1;
    CP_XZButton *Btn2;
    CP_XZButton *Btn3;
    
    NSString *orderID;
    NSString *lottery_id;
    NSString *play;
   UIWindow* tempWindow;
    float keybordH;
    NSString *shareTo;//分享到，分享模式下可用
    
    BOOL canPublice;
    UIImage * shareImage;//传入要分享的图片
    IBOutlet UINavigationBar *titleBar;
    NSString * lotteryID;//方案id 只要是从方案详情页分享的 这个字段必传
    
    NSString * weiBoContent;
    UpLoadView * loadview;
}
@property (nonatomic, retain)NSString * myyuce, *lotteryID;
@property (nonatomic, retain)NSString * caizhong;
@property (nonatomic,copy)NSString *orderID,*lottery_id,*play;
@property (nonatomic)CPThree cpthree;
@property (nonatomic)BOOL three;
@property (nonatomic, retain) UIImageView * baimageview;
@property (nonatomic, retain) IBOutlet UINavigationItem *mTitle;
@property (nonatomic, retain) IBOutlet UIButton *mBackBtn;
@property (nonatomic, retain) IBOutlet UIButton *mPostBtn;
@property (nonatomic, retain) IBOutlet UITextView *mMessage;
@property (nonatomic, retain) IBOutlet UIButton *mTextCount;
@property (nonatomic, retain) IBOutlet UIView *mFunctionController;
@property (nonatomic, retain) IBOutlet UIButton *mSaveDraft;
@property (nonatomic, retain) IBOutlet UIButton *mTakeLocation;
@property (nonatomic, retain) IBOutlet UIButton *mTakePhoto;
@property (nonatomic, retain) IBOutlet UIButton *mTakeTopic;
@property (nonatomic, retain) IBOutlet UIButton *mTakeLinkMan;
@property (nonatomic, retain) IBOutlet UIButton *mTakeFace;
@property (nonatomic, retain) IBOutlet UIButton *mShowPhoto;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UINavigationBar * newpostnavbar;
@property (nonatomic, retain) IBOutlet UIView * caidanview;

@property (nonatomic, assign) PublishType publishType;
@property (nonatomic, retain) YtTopic *mStatus;
@property (nonatomic, retain) Draft *mDraft;; // 草稿箱内容
@property (nonatomic, retain) ASIFormDataRequest *mReqData;
@property (nonatomic, retain) ASIHTTPRequest *mRequest;
@property (nonatomic, retain) ASIHTTPRequest *mReqUpload;
@property (nonatomic, retain) UIImage *mSelectImage;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) UIImageView *tipsView;
@property (nonatomic, retain) UIActivityIndicatorView *yrbIndicatorView;
@property (nonatomic,assign)BOOL isShare,infoShare;
@property (nonatomic,assign)BOOL share0;
@property (nonatomic,copy)NSString *shareTo;
@property (nonatomic, retain)IBOutlet UINavigationBar *titleBar;
@property (nonatomic, retain)UIImage * shareImage;//图片的传入

@property (nonatomic, retain)NSString * weiBoContent;//微博内容


- (void) dismissSelf:(BOOL)animated;            // 关闭该界面. 参数：是否使用动画
- (void) actionBack: (UIButton *)sender;    // 返回上一个界面
- (void) actionPublish: (UIButton *)sender; // 发送帖子
- (IBAction) actionSave: (UIButton *)sender;    // 保存草稿
- (IBAction) actionPhoto: (UIButton *)sender;   // 拍照
- (IBAction) actionTopicOrLinkMan: (UIButton *)sender;   // 插入话题　And @常用联系人
- (IBAction) actionFace: (UIButton *)sender;    // 添加表情
- (IBAction) actionShowPhoto: (UIButton *)sender;// 显示当前所选择的图片，用系统相册打开
- (IBAction) changePage:(id)sender;
- (IBAction) actionCleanText : (id) sender;
- (void) actionAtSomeTime : (UIButton *) sender;// 响应转发或评论微博时同时评论给XXX按钮
- (void) changeTextCount : (NSString *) text;

- (void) updateUI;
- (void) layoutHorizontalContainer:(UIView *)parent gap:(int)gap;
- (void) loadFaceSystemViewWithPage:(int)page;
- (void) showFaceSystem;
- (void) dismissFaceSystem;
- (void) doSaveDraft : (BOOL) exit;// 保存草稿到数据库
- (void) showPictureBtn;// 显示添加图片后的图片按钮
- (void) deleteImage;



@end
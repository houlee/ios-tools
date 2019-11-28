//
//  GouCaiHomeViewController.h
//  caibo
//
//  Created by yao on 12-5-23.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "GCScrollView.h"
#import "DownLoadImageView.h"
#import "CBRefreshTableHeaderView.h"

#import "ProgressBar.h"
#import "AddressView.h"

#import "KFMessageViewController.h"
#import "MyWebViewController.h"
//typedef enum
//{
//    wodecaipiao,
//	setting
//}XiuGaiTouXiangType;
//
//@class AddressView;
//@interface UIImage (wiRoundedRectImage)
//
//+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size;
//
//@end

@interface GouCaiHomeViewController : CPViewController<ASIHTTPRequestDelegate, UITextFieldDelegate, CP_UIAlertViewDelegate,GCScrollViewDelegate,CBRefreshTableHeaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PrograssBarBtnDelegate,MyWebViewDelegate> {
	
    UILabel *zhangLabel;
	UILabel *zhanghuLabel;
	UILabel *jiangliLabel;
    UIButton *jiangliButton;
    UIImageView *jiangliBgImage;
    UIImageView *btnBack;
    UIButton *exitLoginButton;
	UILabel *dongjieLabel;
	ASIHTTPRequest *httpRequest;
    ASIHTTPRequest *SevenDayRequest;//7天领彩金
    UITextField * text;
//    UIButton *refreshbtn;
    UIActivityIndicatorView *activityView;
    BOOL isTixian;
    BOOL isLiuShui;
    BOOL isZiZhu;
    BOOL isLoading;
    BOOL isAllRefresh;
    
    
    UIButton *Presshidden;
    UIButton *helpDJBtn;
    
    //
    UIImageView *bgView;
    UIImageView *btnbackImage;
    UIButton *jlButton;
    UIButton *pkButton;
    UIButton *yqButton;
    UIButton *dzpButton;
    UIImageView *jlmage;
    
    UIButton *jlMoneyButton;//领取奖励
    UILabel *jlMoneyLabel;
    UILabel *jlMoneyLabel2;
    UILabel *dongLabelN;
    NSString * passWord;
    UIScrollView *scr;
    NSInteger markCount;
    UIImageView * dianCjbImage;//彩金宝上的点
    NSString * caijinbao;//是否购买彩金宝
    GCScrollView * myScrollView;
    UIImageView * selfHelpImageView;
    
    UIImageView * refreshImageView;
    DownLoadImageView * touXiangImageView;
    
    // 刷新相关
    CBRefreshTableHeaderView *refreshHeaderView;
    CBRefreshTableHeaderView *mRefreshView;
    id _delegate;
	CBPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
    
    
    // 修改头像
    UIView *photoBackGroundView;
    UIImageView *backImageV;
    ASIHTTPRequest *reqUserInfo;
    
    UIBarButtonItem *leftBarBtnItem;
    
    UIBarButtonItem *rightBarBtnItem;
    
    NSString *drawal_jiangliMoney;
    
    UIImageView * myImageView;//相片显示
    UIImage *mHeadImage;// 头像
    NSString *imageUrl;
    ASIHTTPRequest *reqEditPerInfo;
    ProgressBar *mProgressBar;
    AddressView *mAddressView;
    UIImageView *btnbackImage2;
    NSString *caijinType;
//    UIImageView * myImageView;//相片显示
//    UIButton * potbutton;//拍照
//    UIButton * potbuttontwo;//相册
//    ProgressBar *mProgressBar;
//    AddressView *mAddressView;
//    UIImage *mHeadImage;// 头像
//    NSString *imageUrl;
//    ASIHTTPRequest *reqEditPerInfo;
//    BOOL padDoBack;
//    BOOL finish;
//    XiuGaiTouXiangType xiugaitouxiangtype;
    UIImageView *notPerImage;//未完善背景
    UIButton *aboutBtn;
    UILabel *yuanLabel;
    UILabel *jiangLabel;
    BOOL jiangliBOOL;
    
    DownLoadImageView *quanBuCaiPiaoImageView;
    DownLoadImageView *zhongJiangCaiPiaoImage;
    DownLoadImageView *heMaiCaiPiaoImage;
    DownLoadImageView *zhuihaoCaiPiaoImage;
}

@property (nonatomic, retain)NSString * passWord, * caijinbao,*caijinType;
@property (nonatomic, retain) ASIHTTPRequest *httpRequest,*SevenDayRequest,*reqUserInfo;
@property (nonatomic, retain)UIImageView * selfHelpImageView;
@property (nonatomic, retain)DownLoadImageView *touXiamgeImageView;

// 修改头像
@property (nonatomic, retain)UIView *photoBackGroundView;

@property (nonatomic, retain) UIBarButtonItem *leftBarBtnItem;
@property (nonatomic, retain) UIBarButtonItem *rightBarBtnItem;

@property (nonatomic, copy) NSString *drawal_jiangliMoney;

@property(nonatomic, retain) ASIHTTPRequest *reqEditPerInfo;
//@property(nonatomic, retain) ASIHTTPRequest *reqEditPerInfo;
//@property(nonatomic, assign) BOOL padDoBack;
//@property(nonatomic, assign) BOOL finish;
//@property(nonatomic, assign) XiuGaiTouXiangType xiugaitouxiangtype;



- (void)passWordOpenUrl;
@end

//
//  NewPostViewController.m
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
//   yao

#import "NewPostViewController.h"
#import "FolloweesViewController.h"
#import "UIImageExtra.h"
#import "FaceSystem.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import "pinyin.h"
#import <CoreLocation/CoreLocation.h>
#import "NetURL.h"
#import "ProgressBar.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "Info.h"
#import "Draft.h"
#import "ImageUtils.h"
#import "NSStringExtra.h"
#import "caiboAppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Draft.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "UserInfo.h"
#import "SinaBindViewController.h"
#import "TopicThemeListViewController.h"
#import "CP_XZButton.h"
#import "CP_LieBiaoView.h"
#import "KFButton.h"
#import "MobClick.h"



@interface NewPostViewController (PrivateMethods)
- (void)loadFaceSystemViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (void)doShare;
@end

@implementation NewPostViewController

@synthesize publishType, mStatus, mDraft, mSelectImage, mReqData, mRequest, mReqUpload, viewControllers, mShowPhoto, mTitle, mBackBtn, mPostBtn, mMessage, mTextCount, mFunctionController, mSaveDraft, mTakeFace, mTakePhoto, mTakeTopic, mTakeLinkMan, mTakeLocation, scrollView, pageControl,tipsView,yrbIndicatorView,orderID,lottery_id,play,shareTo, shareImage;
@synthesize three;
@synthesize cpthree;
@synthesize baimageview;
@synthesize caizhong;
@synthesize isShare;
@synthesize share0;
@synthesize myyuce;
@synthesize newpostnavbar;
@synthesize caidanview;
@synthesize titleBar, infoShare, lotteryID;
@synthesize weiBoContent;

- (id)init {
	self = [super init];
	if (self) {
		isShare = NO;
        infoShare = NO;
		share0 = NO;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
	}
	return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (publishType == kCommentTopicController) {
        [self performSelector:@selector(pressZFButton:)];
    }
#ifdef isCaiPiaoForIPad
    if (publishType == KShareController || infoShare) {
        [mMessage resignFirstResponder];
    }
    
#endif
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

- (void)LoadiPhoneView {

    self.CP_navigation.title = @"发表新微博";
    
    scrollView.frame = CGRectMake(0, self.mainView.bounds.size.height - 280, 320, scrollView.frame.size.height);
    UIImageView *chaimage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 12, 12)];
    chaimage.backgroundColor = [UIColor clearColor];
    chaimage.image = UIImageGetImageFromName(@"kbd_crossBtn.png");
    [mTextCount addSubview:chaimage];
    [chaimage release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionBack:)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btnwan addSubview:imagevi];
    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:14];
    lilable.shadowColor = [UIColor blackColor];//阴影
    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"完成";
    lilable.tag = 10;
    [btnwan addSubview:lilable];
    [lilable release];
    [btnwan addTarget:self action:@selector(actionYanZheng) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnwan];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    
    
    //表情背景
    baimageview = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)];
    //baimageview.image = UIImageGetImageFromName(@"kbd_facebackground.png");
    //[self.mainView insertSubview:baimageview atIndex:2];
    [self.mainView addSubview:baimageview];
    [baimageview release];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }
    
    [mTakeLocation removeFromSuperview];// 暂时移除定位服务功能
    
    
    
    mMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    mMessage.backgroundColor = [UIColor clearColor];
    mMessage.font = [UIFont systemFontOfSize:14];
    mMessage.dataDetectorTypes = UIDataDetectorTypeAll;
    mMessage.editable = YES;
    mMessage.delegate = self;
    [self.mainView addSubview:mMessage];
    
    UISwipeGestureRecognizer * rec = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeMessage)] autorelease];
    rec.direction = UISwipeGestureRecognizerDirectionDown;
    [mMessage addGestureRecognizer:rec];
    
    UIImageView *wbBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height - 216, 320, 220)];
    wbBgImage.image = UIImageGetImageFromName(@"wbbg6.png");
    wbBgImage.userInteractionEnabled = YES;
    [self.mainView addSubview:wbBgImage];
    [wbBgImage release];
    
    potButton1 = [[CP_PTButton alloc] initWithFrame:CGRectMake(80, self.mainView.bounds.size.height - 160, 150, 40)];
    [potButton1 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"拍 照"];
    potButton1.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton1.buttonImage.frame = potButton1.bounds;
    potButton1.buttonImage.image = [potButton1.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton1 addTarget:self action:@selector(pressPotButtona1:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:potButton1];
    if (weiBoContent.length) {
        potButton1.hidden = YES;
    }
    [potButton1 release];
    
    potButton2 = [[CP_PTButton alloc] initWithFrame:CGRectMake(80, self.mainView.bounds.size.height - 110, 150, 40)];
    [potButton2 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
    potButton2.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton2.buttonImage.frame = potButton2.bounds;
    potButton2.buttonImage.image = [potButton2.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton2 addTarget:self action:@selector(pressPotButtonb2:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:potButton2];
    if (weiBoContent.length) {
        potButton2.hidden = YES;
    }
    [potButton2 release];
    
#ifdef isGuanliyuanBanben
    potButton1.frame = CGRectMake(80, self.mainView.bounds.size.height - 200, 150, 40);
    potButton2.frame = CGRectMake(80, self.mainView.bounds.size.height - 150, 150, 40);
    potButton3 = [[CP_PTButton alloc] initWithFrame:CGRectMake(80, self.mainView.bounds.size.height - 100, 150, 40)];
    [potButton3 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"插入微博链接"];
    potButton3.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton3.buttonImage.frame = potButton1.bounds;
    potButton3.buttonImage.image = [potButton1.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton3 addTarget:self action:@selector(pressPotButtona3:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:potButton3];
    [potButton3 release];
    
    potButton4 = [[CP_PTButton alloc] initWithFrame:CGRectMake(80, self.mainView.bounds.size.height - 50, 150, 40)];
    [potButton4 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"插入方案详情链接"];
    potButton4.buttonName.font = [UIFont boldSystemFontOfSize:16];
    potButton4.buttonImage.frame = potButton4.bounds;
    potButton4.buttonImage.image = [potButton4.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton4 addTarget:self action:@selector(pressPotButtona4:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:potButton4];
    [potButton4 release];
    
#endif
    
    
    potimage = [[UIImageView alloc] initWithFrame:CGRectMake(100, self.mainView.frame.size.height - 180, 120, 120)];
    [self.mainView addSubview:potimage];
    if (!weiBoContent.length) {
        potimage.hidden = YES;
        
        delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        delButton.frame = CGRectMake(210, self.mainView.frame.size.height - 195, 30, 30);
        [delButton setTitle:@"x" forState:UIControlStateNormal];
        delButton.hidden = YES;
        [delButton addTarget:self action:@selector(pressdelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:delButton];
    }else{
        potimage.image = shareImage;
    }

    
//    [self.mainView addSubview:potButton1];
//    [self.mainView addSubview:potButton2];
    
    
    //
    pzImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 132, 320, 32)];
    pzImage.image = UIImageGetImageFromName(@"wb19.png");
    pzImage.userInteractionEnabled = YES;
    [self.mainView addSubview:pzImage];
    if (weiBoContent.length) {
        pzImage.hidden = YES;
    }
    [pzImage release];
    
   
//    [self.mainView.layer setMasksToBounds:YES];
    
    //新添加的拍照按钮
    pzButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pzButton.frame = CGRectMake(20, 1, 40, 30);
    [pzButton addTarget:self action:@selector(actionPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:pzButton];
    UIImageView *zpImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    zpImage.image = UIImageGetImageFromName(@"wb8.png");
    zpImage.tag = 333;
    [pzButton addSubview:zpImage];
    [zpImage release];
    
    
    //新添加的分享按钮
    fxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fxButton.frame = CGRectMake(80, 1, 40, 30);
    [fxButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:fxButton];
    UIImageView *fxImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    fxImage.image = UIImageGetImageFromName(@"wb10.png");
    fxImage.tag = 111;
    [fxButton addSubview:fxImage];
    [fxImage release];
    
    //新添加的@按钮
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(150, 1, 40, 30);
    addButton.tag = 1;
    [addButton addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:addButton];
    UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    addImage.image = UIImageGetImageFromName(@"wb12.png");
    [addButton addSubview:addImage];
    [addImage release];
    
    //新添加的#按钮
    htButton = [UIButton buttonWithType:UIButtonTypeCustom];
    htButton.frame = CGRectMake(220, 1, 40, 30);
    [htButton addTarget:self action:@selector(pressmTakeTopic:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:htButton];
    UIImageView *htImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    htImage.image = UIImageGetImageFromName(@"wb14.png");
    [htButton addSubview:htImage];
    [htImage release];
    
    
    //新添加的添加表情按钮
    faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faceButton.frame = CGRectMake(280, 1, 40, 30);
    [faceButton addTarget:self action:@selector(actionFace:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:faceButton];
    UIImageView *faceImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    faceImage.image = UIImageGetImageFromName(@"wb16.png");
    [faceButton addSubview:faceImage];
    [faceImage release];
    
    
    //新添加的转发按钮
    zfButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zfButton.frame = CGRectMake(10, 1, 40, 30);
    zfButton.hidden = YES;
    [zfButton addTarget:self action:@selector(pressZFButton:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:zfButton];
    UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    zfImage.image = UIImageGetImageFromName(@"wbzf.png");
    [zfButton addSubview:zfImage];
    [zfImage release];
    
    
    share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(50, 3, 48, 18);
    [share setImage:UIImageGetImageFromName(@"cpthree_share.png") forState:UIControlStateNormal];
    [share addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    
    
    redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.frame = CGRectMake(114, 1, 40, 30);
    [redButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *reImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    reImage.image = UIImageGetImageFromName(@"red111.png");
    [redButton addSubview:reImage];
    [reImage release];
    if (publishType == kNewTopicController||publishType == kCommentTopicController) {
        
        
        kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        kefuButton.frame = CGRectMake((320-88)/2, 209+5, 88, 29);
        [kefuButton addTarget:self action:@selector(pressKeFuButton:) forControlEvents:UIControlEventTouchUpInside];
        [kefuButton setImage:UIImageGetImageFromName(@"lianxikefu.png") forState:UIControlStateNormal];
//        [kefuButton setImage:UIImageGetImageFromName(@"lianxikefu_1.png") forState:UIControlStateHighlighted];
        UILabel *beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 0, 49, 29)];
        beginLabel.backgroundColor = [UIColor clearColor];
        beginLabel.textColor = [UIColor whiteColor];
        beginLabel.text = @"联系客服";
        beginLabel.font = [UIFont systemFontOfSize:11];
        beginLabel.textAlignment = NSTextAlignmentCenter;
        [kefuButton addSubview:beginLabel];
        [beginLabel release];
        [self.mainView addSubview:kefuButton];
        if ([lottery_id length] > 0) {
            kefuButton.hidden = YES;
        }
    }
    
    
    
    UILabel *redlab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    redlab.text = @"红球";
    redlab.textAlignment = NSTextAlignmentCenter;
    redlab.font = [UIFont boldSystemFontOfSize:9];
    redlab.textColor = [UIColor whiteColor];
    redlab.backgroundColor = [UIColor clearColor];
    [redButton addSubview:redlab];
    [redlab release];
    
    blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButton.frame = CGRectMake(164, 1, 40, 30);
    [blueButton addTarget:self action:@selector(pressBlueButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *blImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    blImage.image = UIImageGetImageFromName(@"blue222.png");
    [blueButton addSubview:blImage];
    [blImage release];
    
    UILabel *bluelab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    bluelab.text = @"蓝球";
    bluelab.textAlignment = NSTextAlignmentCenter;
    bluelab.font = [UIFont boldSystemFontOfSize:9];
    bluelab.textColor = [UIColor whiteColor];
    bluelab.backgroundColor = [UIColor clearColor];
    [blueButton addSubview:bluelab];
    [bluelab release];
    
    
    purpleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    purpleButton.frame = CGRectMake(210, 1, 40, 30);
    [purpleButton addTarget:self action:@selector(pressPurpleButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *puImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    puImage.image = UIImageGetImageFromName(@"yl333.png");
    [purpleButton addSubview:puImage];
    [puImage release];
    
    UILabel *purlab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    purlab.text = @"胆码";
    purlab.textAlignment = NSTextAlignmentCenter;
    purlab.font = [UIFont boldSystemFontOfSize:9];
    purlab.textColor = [UIColor whiteColor];
    purlab.backgroundColor = [UIColor clearColor];
    [purpleButton addSubview:purlab];
    [purlab release];
    
    if (publishType == kCommentTopicController) {
        zfButton.hidden = NO;
        zfButton.selected = YES;
        [mMessage becomeFirstResponder];
    }
    if(publishType == kNewTopicController)
    {
        
        pzButton.frame = CGRectMake(20, 3, 40, 30);
        fxButton.frame = CGRectMake(80, 3, 40, 30);
        addButton.frame = CGRectMake(140, 3, 40, 30);
        htButton.frame = CGRectMake(200, 3, 40, 30);
        faceButton.frame = CGRectMake(260, 3, 40, 30);
        [mSaveDraft setEnabled:NO];
        self.CP_navigation.title = @"发表新微博";
        
        if (infoShare) {
            self.CP_navigation.title = @"分享微博";
        }
        
        if ([mStatus.nick_name length] == 0 || mStatus.nick_name == nil) {
            
            yszLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 130, 30)];
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
                yszLabel.frame = CGRectMake(15, 0, 130, 30);
            }
            else {
                yszLabel.frame = CGRectMake(15, 10, 130, 15);
            }
            yszLabel.text = @"说点儿什么吧......";
            yszLabel.backgroundColor = [UIColor clearColor];
            yszLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            if (infoShare) {
                mMessage.text = @"分享自#投注站# iPhone版";
#ifdef isCaiPiaoForIPad
                mMessage.text = @"分享自#投注站# iPad版";
#endif
                canPublice = YES;
                mIndex = NSMakeRange([mMessage.text length], 0);
            }else{
            [mMessage addSubview:yszLabel];
            }
            
            
        }
        if (mStatus && mStatus.nick_name) {
            NSString * str = [NSString stringWithFormat:@"%@ ", mStatus.nick_name];
            [mMessage setText:str];
            // NSLog(@"mMessage = %@", mStatus.nick_name);
            mIndex = mMessage.selectedRange;
            [self changeTextCount:str];
            
        }
        if (self.lottery_id) {
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"yaoqingxinxi"];
            if (!str) {
                str = @"一起合买这个方案";
                UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"yaqi960.png")];
                [self.mainView addSubview:imageV];
                imageV.frame = CGRectMake(45, self.mainView.bounds.size.height - 295, 154.5, 42.5);
                [imageV release];
                UILabel *label = [[UILabel alloc] init];
                label.font = [UIFont systemFontOfSize:13];
                label.frame =imageV.bounds;
                label.text = @"从这里选择要邀请的人";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
                label.backgroundColor = [UIColor clearColor];
                [imageV addSubview:label];
                [label release];
                [imageV performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
                [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"yaoqingxinxi"];
            }
            [mMessage setText:str];
            mIndex = mMessage.selectedRange;
            [self changeTextCount:str ];
        }
        
    }
    else if (publishType == kOpinionFeedBack)
    {
        [mSaveDraft setEnabled:NO];
        self.CP_navigation.title = @"发表反馈意见";
    }
    else if(publishType == kForwardTopicController || publishType == kCommentTopicController || publishType == kCommentRevert || publishType == KShareController)
    {
        mMessage.frame = CGRectMake(15, 44, 290, 124);
        mFunctionController.frame = CGRectMake(0, 168, 320, 37);
        mTextCount.frame = CGRectMake(259, 155, 49, 21);
        if (weiBoContent.length) {
            mTextCount.frame = CGRectMake(259, 175, 49, 21);
        }
#ifdef isCaiPiaoForIPad
    
        kefuButton.frame = CGRectMake((540-80)/2,  157, 80, 16);
#else
        kefuButton.frame = CGRectMake((320-88)/2,  150, 88, 29);
#endif
        UIImageView *mTempCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 34)];
        mTempCon.backgroundColor = [UIColor yellowColor];
        [mTempCon setUserInteractionEnabled:YES];
        
        // 评论
        if (publishType == kCommentTopicController || publishType == kCommentRevert || publishType == KShareController) {
            mTakeLocation.hidden = YES;
            mTakePhoto.hidden = YES;
            share.hidden = YES;
            mTempCon.hidden = YES;
            mTakeTopic.frame = CGRectMake(23, 3,  40, 30);
            mTakeLinkMan.frame = CGRectMake(86, 3, 40, 30);
			if (publishType == KShareController) {
                if (weiBoContent.length) {
                    mMessage.text = weiBoContent;
                }else{
                    mMessage.text = @"#投注站 iPhone#";
                }
#ifdef isCaiPiaoForIPad
                mMessage.text = @"#投注站 iPad#";
#endif
				mIndex = NSMakeRange([mMessage.text length], 0);
			}
            
            zfButton.hidden = NO;
            if (infoShare) {
                zfButton.hidden = YES;
            }
            mTakeFace.frame = CGRectMake(149, 3, 40, 30);
            mTextCount.frame = CGRectMake(212, 155, 49, 21);
            if (weiBoContent.length) {
                mTextCount.frame = CGRectMake(212, 175, 49, 21);
            }
#ifdef isCaiPiaoForIPad
            kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
#else
            kefuButton.frame = CGRectMake((320-88)/2, 150, 88, 29);
#endif
            
            mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            mNonceBtn.frame = CGRectMake(17, 5, 23, 24);
            [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
            [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
            [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake(50, 5, 300, 24);
            title.backgroundColor = [UIColor clearColor];
            [title setTextColor:[UIColor whiteColor]];
            [title setText:@"同时转发到我的微博"];
            
            [mTempCon addSubview:mNonceBtn];
            [mTempCon addSubview:title];
            [title release];
        } else {// 转发
            zfButton.hidden = NO;
            mTakeLocation.hidden = YES;
            mTempCon.hidden = YES;
            if ([mStatus.orignal_id isEqualToString:@"0"]) {
                mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mNonceBtn.frame = CGRectMake(17, 5, 23, 24);
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mNonceBtn];
                
                if (mStatus.nick_name) {
                    UILabel *title = [[UILabel alloc] init];
                    title.frame = CGRectMake(50, 5, 300, 24);
                    title.backgroundColor = [UIColor clearColor];
                    [title setTextColor:[UIColor whiteColor]];
                    [title setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name]];
                    [mTempCon addSubview:title];
                    [title release];
                }
            } else {
                
                // 调整输入框位置
                mMessage.frame = CGRectMake(15, 44, 290, 90);
                mFunctionController.frame = CGRectMake(0, 134, 320, 37);
                mTextCount.frame = CGRectMake(259, 155, 49, 21);
#ifdef isCaiPiaoForIPad
                kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
#else
                kefuButton.frame = CGRectMake((320-88)/2, 150, 88, 29);
#endif
                mTempCon.hidden = YES;
                mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mNonceBtn.frame = CGRectMake(10, 7, 23, 24);
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mNonceBtn];
                
                mOrignalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mOrignalBtn.frame = CGRectMake(10, 37, 23, 24);
                [mOrignalBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mOrignalBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mOrignalBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mOrignalBtn];
                
                if (mStatus.nick_name) {
                    UILabel *title = [[UILabel alloc] init];
                    title.frame = CGRectMake(43, 6, 300, 24);
                    title.backgroundColor = [UIColor clearColor];
                    [title setTextColor:[UIColor whiteColor]];
                    [title setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name]];
                    [mTempCon addSubview:title];
                    [title release];
                }
                
                if (mStatus.nick_name_ref) {
                    UILabel *title1 = [[UILabel alloc] init];
                    title1.frame = CGRectMake(43, 36, 300, 24);
                    title1.backgroundColor = [UIColor clearColor];
                    [title1 setTextColor:[UIColor whiteColor]];
                    [title1 setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name_ref]];
                    [mTempCon addSubview:title1];
                    [title1 release];
                }
                
                if (mStatus.nick_name && mStatus.content) {
                    // 该微博是原微博时，设置输入框信息为所要转的信息
                    [mMessage setText:[@"//" stringByAppendingString: [[mStatus.nick_name stringByAppendingString:@":"]stringByAppendingString:[mStatus.content flattenPartHTML:mStatus.content]]]];
                    
                    [self changeTextCount:[mStatus.content flattenPartHTML:mStatus.content]];
                }
            }
        }
        
        if ( publishType == kCommentRevert) {
            mTempCon.hidden = YES;
            //mTempCon.frame = CGRectMake(0, 176, 320, 68);
        }
        if (publishType == kForwardTopicController || publishType == KShareController) {
            mTempCon.hidden = YES;
            shareView.hidden = YES;
            
        }
        self.tipsView = mTempCon;
        self.tipsView.hidden = YES;
        [self.mainView addSubview:self.tipsView];
        [mTempCon release];
        
        if (publishType == kForwardTopicController || publishType == KShareController) {
            //[mTitle setTitle:@"转发微博"];
            self.CP_navigation.title = @"转发微博";
			if (isShare || infoShare) {
				//[mTitle setTitle:@"分享微博"];
                self.CP_navigation.title = @"分享微博";
			}
        } else if (publishType == kCommentTopicController) {
            //[mTitle setTitle:@"评论微博"];
            self.CP_navigation.title = @"评论微博";
        } else if(publishType == kCommentRevert) {
            //[mTitle setTitle:@"回复评论"];
            self.CP_navigation.title = @"回复评论";
        }
    }
	else if(publishType == kEditTopicController) {
        //[mTitle setTitle:@"编辑微博"];
        self.CP_navigation.title = @"编辑微博";
        if (mDraft) {
            NSString *text = mDraft.text;
            if (text) {
                [mMessage setText:text];
                mIndex = NSMakeRange([text length], 0);
                [self changeTextCount:text];
            }
            UIImage *image = mDraft.mImage;
            if (image) {
                [self setMSelectImage:image];
                [self showPictureBtn];
            }
        }
    }
    
    if (three) {
        self.CP_navigation.title = @"发表预测微博";
        [addButton removeFromSuperview];
        [htButton removeFromSuperview];
        [faceButton removeFromSuperview];
        
        [pzImage addSubview:redButton];
        [pzImage addSubview:blueButton];
        [pzImage addSubview:yellButton];
        [pzImage addSubview:purpleButton];
        
        redButton.frame = CGRectMake(130, 5, 45, 24);
        blueButton.frame = CGRectMake(180, 5, 45, 24);
        //yellButton.frame = CGRectMake(201, 2, 36, 32);
        purpleButton.frame = CGRectMake(230, 5, 45, 30);
        // mFunctionController.backgroundColor = [UIColor clearColor];
        UIButton *bubutton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        bubutton.frame = CGRectMake(280, 7, 18, 18);
        bubutton.tag = 1;
        [bubutton setImage:UIImageGetImageFromName(@"wf444.png") forState:UIControlStateNormal];
        [bubutton addTarget:self action:@selector(pressbubutton:) forControlEvents:UIControlEventTouchUpInside];
        //mTextCount.frame = CGRectMake(259, 173, 49, 21);
        [pzImage addSubview:bubutton];
        
        [mFunctionController insertSubview:blueButton atIndex:79];
        mTakePhoto.frame = CGRectMake(17, 9, 48, 18);
        share.frame = CGRectMake(70, 9, 48, 18);
        mFunctionController.backgroundColor = [UIColor clearColor];
        
    }else {
        
        [mShowPhoto removeFromSuperview];
        [mTakeLocation removeFromSuperview];
        [mSaveDraft removeFromSuperview];
        //[mTakeFace removeFromSuperview];
        mTakePhoto.frame = CGRectMake(17, 9, 48, 18);
        [mFunctionController addSubview:share];
        share.frame = CGRectMake(75, 9, 48, 18);
        mTakeTopic.frame = CGRectMake(135, 3, 40, 30);
        mTakeLinkMan.frame = CGRectMake(194, 3, 40, 30);
        mTakeFace.frame = CGRectMake(250, 3, 40, 30);
        //mShowPhoto.frame = CGRectMake(290, 3, 25, 25);
        mFunctionController.backgroundColor = [UIColor clearColor];
    }
    
    if (publishType == kCommentTopicController || publishType == kCommentRevert) {
        
        [pzButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        zfButton.frame = CGRectMake(20, 1, 40, 30);
        addButton.frame = CGRectMake(100, 1, 40, 30);
        htButton.frame = CGRectMake(180, 1, 40, 30);
        faceButton.frame = CGRectMake(260, 1, 40, 30);
        
        mMessage.frame = CGRectMake(15, 54, 290, 124);
        mTextCount.frame = CGRectMake(252, 155, 49, 21);
#ifdef isCaiPiaoForIPad
        kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
#else
        kefuButton.frame = CGRectMake((320-88)/2, 150, 88, 29);
#endif
        [self.mainView insertSubview:caidanview atIndex:30];
        
    }
    
    
    if (publishType == kForwardTopicController) {
        [share removeFromSuperview];
        [pzButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        zfButton.frame = CGRectMake(20, 1, 40, 30);
        addButton.frame = CGRectMake(100, 1, 40, 30);
        htButton.frame = CGRectMake(180, 1, 40, 30);
        faceButton.frame = CGRectMake(260, 1, 40, 30);
        
        mMessage.frame = CGRectMake(15, 54, 290, 124);
        
    }
    
    if (isShare) {
        [pzButton removeFromSuperview];
        [zfButton removeFromSuperview];
        [faceButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        
        htButton.frame = CGRectMake(50, 1, 40, 30);
        addButton.frame = CGRectMake(120, 1, 40, 30);
        
    }
    if (publishType == kNewTopicController) {
        mMessage.frame = CGRectMake(15, 54, 290, 120);
    }
    
    
    [mTakeTopic addTarget:self action:@selector(pressmTakeTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /******* 表情系统相关 ******/
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 3; i++) {
        [tempArray addObject:[NSNull null]];
    }
    self.viewControllers = tempArray;
    [tempArray release];
    
    scrollView.scrollsToTop = NO;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    scrollView.backgroundColor = [UIColor clearColor];
    pageControl.backgroundColor = [UIColor clearColor];
    [self updateUI];
    
    
	[mMessage becomeFirstResponder];
	

    if (self.lottery_id) {
        mTakePhoto.enabled = NO;
        share.enabled = NO;
    }
    [self.mainView insertSubview:mMessage atIndex:0];
    [self.mainView insertSubview:mTextCount atIndex:999];
	[self.mainView insertSubview:scrollView atIndex:1000];
    [self.mainView addSubview:pageControl];
    
    pageControl.hidden = YES;
    scrollView.hidden = YES;
    pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 35, 320, 36);

    
    if (infoShare) {
        potimage.image = mSelectImage;
        potButton1.hidden = YES;
        potButton2.hidden = YES;
        potButton3.hidden = potButton1.hidden;
        potButton4.hidden = potButton1.hidden;
        delButton.hidden = NO;
        potimage.hidden = NO;
        
        [mMessage resignFirstResponder];
        
        
       
        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
        
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24, 49, 21);
          
        
        
        pzImage.frame = CGRectMake(0, self.mainView.frame.size.height - 216 - pzImage.frame.size.height, 320, 32);
       
        kefuButton.hidden = YES;
        pageControl.hidden = YES;
         mMessage.frame = CGRectMake(15, 5, 540, 160);
    }
    
     self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 64);
}
- (void)pressKeFuButton:(UIButton *)sender{
    [mMessage resignFirstResponder];
    KFButton * kfb = [[KFButton alloc] init];
    [kfb kfbuttonbig];
    [kfb release];
    
    NSArray * views = [caiboAppDelegate getAppDelegate].window.subviews;
    
    for (int i = 0; i<[views count]; i++) {
        if ([[views objectAtIndex:i] isKindOfClass:[KFMessageBoxView class]]) {
            KFMessageBoxView * kfm = [views objectAtIndex:i];
//            kfm.newpost = self;
            kfm.newpostBool = YES;
            break;
        }
    }
    
}

- (void)LoadiPadView {

    [self.navigationController setNavigationBarHidden:YES];
    self.titleBar.hidden = YES;
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 7;
    self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");//更换导航栏
    self.CP_navigation.title = @"发表新微博";
    self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
    
    
    if (infoShare) {
        self.CP_navigation.title = @"分享微博";
    }
    
    self.mainView.frame = CGRectMake(0, 0, 540, 620);
    
    scrollView.frame = CGRectMake(0, self.mainView.bounds.size.height - 280, 320, scrollView.frame.size.height);
    UIImageView *chaimage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 12, 12)];
    chaimage.backgroundColor = [UIColor clearColor];
    chaimage.image = UIImageGetImageFromName(@"kbd_crossBtn.png");
    [mTextCount addSubview:chaimage];
    [chaimage release];
    
    self.CP_navigation.leftBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(actionBack:) ImageName:@"kf-quxiao2.png"];
    
    btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btnwan addSubview:imagevi];
    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:14];
    lilable.shadowColor = [UIColor blackColor];//阴影
    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"完成";
    lilable.tag = 10;
    [btnwan addSubview:lilable];
    [lilable release];
    [btnwan addTarget:self action:@selector(actionYanZheng) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnwan];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    
    
    //表情背景
//    baimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164, 540, 320)];
//    baimageview.backgroundColor = [UIColor redColor];
//    //baimageview.image = UIImageGetImageFromName(@"kbd_facebackground.png");
//    //[self.mainView insertSubview:baimageview atIndex:2];
//    [self.mainView addSubview:baimageview];
//    [baimageview release];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [newpostnavbar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }
    
    [mTakeLocation removeFromSuperview];// 暂时移除定位服务功能
    
    //UIImageView *wbBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height - 216, 540, 220)];
    UIImageView *wbBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 264, 540, 406)];
    wbBgImage.image = UIImageGetImageFromName(@"wbbg6.png");
    wbBgImage.userInteractionEnabled = YES;
    wbBgImage.tag = 003;
    [self.mainView addSubview:wbBgImage];
    [wbBgImage release];
    
    potButton1 = [[CP_PTButton alloc] initWithFrame:CGRectMake(200, 100, 150, 40)];
    [potButton1 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"拍 照"];
    potButton1.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton1.buttonImage.frame = potButton1.bounds;
    potButton1.buttonImage.image = [potButton1.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton1 addTarget:self action:@selector(pressPotButtona1:) forControlEvents:UIControlEventTouchUpInside];
    [wbBgImage addSubview:potButton1];
    [potButton1 release];
    
    potButton2 = [[CP_PTButton alloc] initWithFrame:CGRectMake(200, 170, 150, 40)];
    [potButton2 loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
    potButton2.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton2.buttonImage.frame = potButton2.bounds;
    potButton2.buttonImage.image = [potButton2.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton2 addTarget:self action:@selector(pressPotButtonb2:) forControlEvents:UIControlEventTouchUpInside];
    [wbBgImage addSubview:potButton2];
    [potButton2 release];
   

    
    potimage = [[UIImageView alloc] initWithFrame:CGRectMake(230, 380, 120, 120)];
    potimage.hidden = YES;
    delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delButton.frame = CGRectMake(350, self.mainView.frame.size.height - 245, 30, 30);
    [delButton setTitle:@"x" forState:UIControlStateNormal];
    delButton.hidden = YES;
    [delButton addTarget:self action:@selector(pressdelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:potimage];
    [self.mainView addSubview:delButton];
    
    
    //
    pzImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 132, 540, 32)];
    pzImage.image = UIImageGetImageFromName(@"wb19.png");
    pzImage.userInteractionEnabled = YES;
    [self.mainView addSubview:pzImage];
    [pzImage release];
    
    //新添加的拍照按钮
    pzButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pzButton.frame = CGRectMake(63, 1, 40, 30);
    [pzButton addTarget:self action:@selector(actionPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:pzButton];
    UIImageView *zpImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    zpImage.image = UIImageGetImageFromName(@"wb8.png");
    zpImage.tag = 333;
    [pzButton addSubview:zpImage];
    [zpImage release];
    
    
    //新添加的分享按钮
    fxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fxButton.frame = CGRectMake(166, 1, 40, 30);
    [fxButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:fxButton];
    UIImageView *fxImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    fxImage.image = UIImageGetImageFromName(@"wb10.png");
    fxImage.tag = 111;
    [fxButton addSubview:fxImage];
    [fxImage release];
    
    //新添加的@按钮
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(269, 1, 40, 30);
    addButton.tag = 1;
    [addButton addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:addButton];
    UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    addImage.image = UIImageGetImageFromName(@"wb12.png");
    [addButton addSubview:addImage];
    [addImage release];
    
    //新添加的#按钮
    htButton = [UIButton buttonWithType:UIButtonTypeCustom];
    htButton.frame = CGRectMake(372, 1, 40, 30);
    [htButton addTarget:self action:@selector(pressmTakeTopic:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:htButton];
    UIImageView *htImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    htImage.image = UIImageGetImageFromName(@"wb14.png");
    [htButton addSubview:htImage];
    [htImage release];
    
    
    //新添加的添加表情按钮
    faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faceButton.frame = CGRectMake(475, 1, 40, 30);
    [faceButton addTarget:self action:@selector(actionFace:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:faceButton];
    UIImageView *faceImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    faceImage.image = UIImageGetImageFromName(@"wb16.png");
    [faceButton addSubview:faceImage];
    [faceImage release];
    
    
    //新添加的转发按钮
    zfButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zfButton.frame = CGRectMake(10, 1, 40, 30);
    zfButton.hidden = YES;
    [zfButton addTarget:self action:@selector(pressZFButton:) forControlEvents:UIControlEventTouchUpInside];
    [pzImage addSubview:zfButton];
    UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
    zfImage.image = UIImageGetImageFromName(@"wbzf.png");
    [zfButton addSubview:zfImage];
    [zfImage release];
    
    
    share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(50, 3, 48, 18);
    [share setImage:UIImageGetImageFromName(@"cpthree_share.png") forState:UIControlStateNormal];
    [share addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    
    
    redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.frame = CGRectMake(114, 1, 40, 30);
    [redButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *reImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    reImage.image = UIImageGetImageFromName(@"red111.png");
    [redButton addSubview:reImage];
    [reImage release];
    
    if (publishType == kNewTopicController||publishType == kCommentTopicController) {
        kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        kefuButton.frame = CGRectMake((320-80)/2, 209+2, 80, 16);
        [kefuButton addTarget:self action:@selector(pressKeFuButton:) forControlEvents:UIControlEventTouchUpInside];
        [kefuButton setImage:UIImageGetImageFromName(@"lianxikefu.png") forState:UIControlStateNormal];
//        [kefuButton setImage:UIImageGetImageFromName(@"lianxikefu_1.png") forState:UIControlStateHighlighted];
        UILabel *beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, 49, 16)];
        beginLabel.backgroundColor = [UIColor clearColor];
        beginLabel.textColor = [UIColor whiteColor];
        beginLabel.text = @"联系客服";
        beginLabel.font = [UIFont systemFontOfSize:11];
        beginLabel.textAlignment = NSTextAlignmentCenter;
        [kefuButton addSubview:beginLabel];
        [beginLabel release];
        [self.mainView addSubview:kefuButton];
        if ([lottery_id length] > 0) {
            kefuButton.hidden = YES;
        }

    }
    
    
    
    UILabel *redlab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    redlab.text = @"红球";
    redlab.textAlignment = NSTextAlignmentCenter;
    redlab.font = [UIFont boldSystemFontOfSize:9];
    redlab.textColor = [UIColor whiteColor];
    redlab.backgroundColor = [UIColor clearColor];
    [redButton addSubview:redlab];
    [redlab release];
    
    blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButton.frame = CGRectMake(164, 1, 40, 30);
    [blueButton addTarget:self action:@selector(pressBlueButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *blImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    blImage.image = UIImageGetImageFromName(@"blue222.png");
    [blueButton addSubview:blImage];
    [blImage release];
    
    UILabel *bluelab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    bluelab.text = @"蓝球";
    bluelab.textAlignment = NSTextAlignmentCenter;
    bluelab.font = [UIFont boldSystemFontOfSize:9];
    bluelab.textColor = [UIColor whiteColor];
    bluelab.backgroundColor = [UIColor clearColor];
    [blueButton addSubview:bluelab];
    [bluelab release];
    
    
    purpleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    purpleButton.frame = CGRectMake(210, 1, 40, 30);
    [purpleButton addTarget:self action:@selector(pressPurpleButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *puImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    puImage.image = UIImageGetImageFromName(@"yl333.png");
    [purpleButton addSubview:puImage];
    [puImage release];
    
    UILabel *purlab = [[UILabel alloc] initWithFrame:CGRectMake(2, 1, 21, 21)];
    purlab.text = @"胆码";
    purlab.textAlignment = NSTextAlignmentCenter;
    purlab.font = [UIFont boldSystemFontOfSize:9];
    purlab.textColor = [UIColor whiteColor];
    purlab.backgroundColor = [UIColor clearColor];
    [purpleButton addSubview:purlab];
    [purlab release];
    
    if (publishType == kCommentTopicController) {
        zfButton.hidden = NO;
        zfButton.selected = YES;
        [mMessage becomeFirstResponder];
        
        
    }
    potButton1.hidden = YES;
    potButton2.hidden = YES;
    potButton3.hidden = potButton1.hidden;
    potButton4.hidden = potButton1.hidden;
    if(publishType == kNewTopicController)
    {
        potButton1.hidden = NO;
        potButton2.hidden = NO;
        potButton3.hidden = potButton1.hidden;
        potButton4.hidden = potButton1.hidden;
        
        pzButton.frame = CGRectMake(60, 3, 40, 30);
        fxButton.frame = CGRectMake(160, 3, 40, 30);
        addButton.frame = CGRectMake(260, 3, 40, 30);
        htButton.frame = CGRectMake(360, 3, 40, 30);
        faceButton.frame = CGRectMake(460, 3, 40, 30);
        [mSaveDraft setEnabled:NO];
        self.CP_navigation.title = @"发表新微博";
        if (infoShare) {
            self.CP_navigation.title = @"分享微博";
        }
        if ([mStatus.nick_name length] == 0 || mStatus.nick_name == nil) {
            
            yszLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 130, 30)];
            yszLabel.text = @"说点儿什么吧......";
            yszLabel.backgroundColor = [UIColor clearColor];
            yszLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            if (infoShare) {
                mMessage.text = @"分享自#投注站# iPhone版";
#ifdef isCaiPiaoForIPad
                mMessage.text = @"分享自#投注站# iPad版";
#endif
                canPublice = YES;
                mIndex = NSMakeRange([mMessage.text length], 0);
            }else{
                [mMessage addSubview:yszLabel];
            }
            
        }
        if (mStatus && mStatus.nick_name) {
            NSString * str = [NSString stringWithFormat:@"%@ ", mStatus.nick_name];
            [mMessage setText:str];
            // NSLog(@"mMessage = %@", mStatus.nick_name);
            mIndex = mMessage.selectedRange;
            [self changeTextCount:str];
            
        }
        if (self.lottery_id) {
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"yaoqingxinxi"];
            if (!str) {
                str = @"一起合买这个方案";
                UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"yaqi960.png")];
                [self.mainView addSubview:imageV];
                imageV.frame = CGRectMake(45, self.mainView.bounds.size.height - 295, 154.5, 42.5);
                [imageV release];
                UILabel *label = [[UILabel alloc] init];
                label.font = [UIFont systemFontOfSize:13];
                label.frame =imageV.bounds;
                label.text = @"从这里选择要邀请的人";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
                label.backgroundColor = [UIColor clearColor];
                [imageV addSubview:label];
                [label release];
                [imageV performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
                [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"yaoqingxinxi"];
            }
            [mMessage setText:str];
            mIndex = mMessage.selectedRange;
            [self changeTextCount:str ];
        }
        
    }
    else if (publishType == kOpinionFeedBack)
    {
        [mSaveDraft setEnabled:NO];
        self.CP_navigation.title = @"发表反馈意见";
    }
    else if(publishType == kForwardTopicController || publishType == kCommentTopicController || publishType == kCommentRevert || publishType == KShareController)
    {
        mMessage.frame = CGRectMake(0, 40, 540, 160);
        mFunctionController.frame = CGRectMake(0, 168, 320, 37);
        mTextCount.frame = CGRectMake(259, 155, 49, 21);
#ifdef isCaiPiaoForIPad
        if (publishType == KShareController) {
            scrollView.hidden = YES;
            pageControl.hidden = YES;
            
        }
        kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
#else
        kefuButton.frame = CGRectMake((320-88)/2, 147, 88, 29);
#endif
        UIImageView *mTempCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 34)];
        mTempCon.backgroundColor = [UIColor clearColor];
        [mTempCon setUserInteractionEnabled:YES];
        
        // 评论
        if (publishType == kCommentTopicController || publishType == kCommentRevert || publishType == KShareController) {
            mTakeLocation.hidden = YES;
            mTakePhoto.hidden = YES;
            share.hidden = YES;
            mTempCon.hidden = YES;
            mTakeTopic.frame = CGRectMake(23, 3,  40, 30);
            mTakeLinkMan.frame = CGRectMake(86, 3, 40, 30);
			if (publishType == KShareController) {
				mMessage.text = @"#投注站 iPhone#";
#ifdef isCaiPiaoForIPad
                mMessage.text = @"#投注站 iPad#";
#endif
				mIndex = NSMakeRange([mMessage.text length], 0);
			}
            
            zfButton.hidden = NO;
            if (infoShare) {
                zfButton.hidden = YES;
            }
            mTakeFace.frame = CGRectMake(149, 3, 40, 30);
            mTextCount.frame = CGRectMake(212, 155, 49, 21);
#ifdef isCaiPiaoForIPad
            kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
#else
            kefuButton.frame = CGRectMake((320-88)/2, 147, 88, 29);
#endif
            mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            mNonceBtn.frame = CGRectMake(17, 5, 23, 24);
            [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
            [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
            [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake(50, 5, 300, 24);
            title.backgroundColor = [UIColor clearColor];
            [title setTextColor:[UIColor whiteColor]];
            [title setText:@"同时转发到我的微博"];
            
            [mTempCon addSubview:mNonceBtn];
            [mTempCon addSubview:title];
            [title release];
        } else {// 转发
            zfButton.hidden = NO;
            mTakeLocation.hidden = YES;
            mTempCon.hidden = YES;
            if ([mStatus.orignal_id isEqualToString:@"0"]) {
                mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mNonceBtn.frame = CGRectMake(17, 5, 23, 24);
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mNonceBtn];
                
                if (mStatus.nick_name) {
                    UILabel *title = [[UILabel alloc] init];
                    title.frame = CGRectMake(50, 5, 300, 24);
                    title.backgroundColor = [UIColor clearColor];
                    [title setTextColor:[UIColor whiteColor]];
                    [title setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name]];
                    [mTempCon addSubview:title];
                    [title release];
                }
            } else {
                
                // 调整输入框位置
                mMessage.frame = CGRectMake(15, 44, 290, 90);
                mFunctionController.frame = CGRectMake(0, 134, 320, 37);
                mTextCount.frame = CGRectMake(259, 155, 49, 21);
                mTempCon.hidden = YES;
                mNonceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mNonceBtn.frame = CGRectMake(10, 7, 23, 24);
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mNonceBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mNonceBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mNonceBtn];
                
                mOrignalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                mOrignalBtn.frame = CGRectMake(10, 37, 23, 24);
                [mOrignalBtn setImage:UIImageGetImageFromName(@"forward_no.png") forState:(UIControlStateNormal)];
                [mOrignalBtn setImage:UIImageGetImageFromName(@"forward_yes.png") forState:(UIControlStateSelected)];
                [mOrignalBtn addTarget:self action:@selector(actionAtSomeTime:) forControlEvents:(UIControlEventTouchUpInside)];
                [mTempCon addSubview:mOrignalBtn];
                
                if (mStatus.nick_name) {
                    UILabel *title = [[UILabel alloc] init];
                    title.frame = CGRectMake(43, 6, 300, 24);
                    title.backgroundColor = [UIColor clearColor];
                    [title setTextColor:[UIColor whiteColor]];
                    [title setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name]];
                    [mTempCon addSubview:title];
                    [title release];
                }
                
                if (mStatus.nick_name_ref) {
                    UILabel *title1 = [[UILabel alloc] init];
                    title1.frame = CGRectMake(43, 36, 300, 24);
                    title1.backgroundColor = [UIColor clearColor];
                    [title1 setTextColor:[UIColor whiteColor]];
                    [title1 setText:[@"同时评论给" stringByAppendingString:mStatus.nick_name_ref]];
                    [mTempCon addSubview:title1];
                    [title1 release];
                }
                
                if (mStatus.nick_name && mStatus.content) {
                    // 该微博是原微博时，设置输入框信息为所要转的信息
                    [mMessage setText:[@"//" stringByAppendingString: [[mStatus.nick_name stringByAppendingString:@":"]stringByAppendingString:[mStatus.content flattenPartHTML:mStatus.content]]]];
                    
                    [self changeTextCount:[mStatus.content flattenPartHTML:mStatus.content]];
                }
            }
        }
        
        if ( publishType == kCommentRevert) {
            mTempCon.hidden = YES;
            //mTempCon.frame = CGRectMake(0, 176, 320, 68);
        }
        if (publishType == kForwardTopicController || publishType == KShareController) {
            mTempCon.hidden = YES;
            shareView.hidden = YES;
            
        }
        self.tipsView = mTempCon;
        self.tipsView.hidden = YES;
        [self.mainView addSubview:self.tipsView];
        [mTempCon release];
        
        if (publishType == kForwardTopicController || publishType == KShareController) {
            //[mTitle setTitle:@"转发微博"];
            self.CP_navigation.title = @"转发微博";
			if (isShare||infoShare) {
				//[mTitle setTitle:@"分享微博"];
                self.CP_navigation.title = @"分享微博";
			}
        } else if (publishType == kCommentTopicController) {
            //[mTitle setTitle:@"评论微博"];
            self.CP_navigation.title = @"评论微博";
        } else if(publishType == kCommentRevert) {
            //[mTitle setTitle:@"回复评论"];
            self.CP_navigation.title = @"回复评论";
        }
    }
	else if(publishType == kEditTopicController) {
        //[mTitle setTitle:@"编辑微博"];
        self.CP_navigation.title = @"编辑微博";
        if (mDraft) {
            NSString *text = mDraft.text;
            if (text) {
                [mMessage setText:text];
                mIndex = NSMakeRange([text length], 0);
                [self changeTextCount:text];
            }
            UIImage *image = mDraft.mImage;
            if (image) {
                [self setMSelectImage:image];
                [self showPictureBtn];
            }
        }
    }
    
    if (three) {
        self.CP_navigation.title = @"发表预测微博";
        [addButton removeFromSuperview];
        [htButton removeFromSuperview];
        [faceButton removeFromSuperview];
        
        [pzImage addSubview:redButton];
        [pzImage addSubview:blueButton];
        [pzImage addSubview:yellButton];
        [pzImage addSubview:purpleButton];
        
        redButton.frame = CGRectMake(130, 5, 45, 24);
        blueButton.frame = CGRectMake(180, 5, 45, 24);
        //yellButton.frame = CGRectMake(201, 2, 36, 32);
        purpleButton.frame = CGRectMake(230, 5, 45, 30);
        // mFunctionController.backgroundColor = [UIColor clearColor];
        UIButton *bubutton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        bubutton.frame = CGRectMake(280, 7, 18, 18);
        bubutton.tag = 1;
        [bubutton setImage:UIImageGetImageFromName(@"wf444.png") forState:UIControlStateNormal];
        [bubutton addTarget:self action:@selector(pressbubutton:) forControlEvents:UIControlEventTouchUpInside];
        //mTextCount.frame = CGRectMake(259, 173, 49, 21);
        [pzImage addSubview:bubutton];
        
        [mFunctionController insertSubview:blueButton atIndex:79];
        mTakePhoto.frame = CGRectMake(17, 9, 48, 18);
        share.frame = CGRectMake(70, 9, 48, 18);
        mFunctionController.backgroundColor = [UIColor clearColor];
        
    }else {
        
        [mShowPhoto removeFromSuperview];
        [mTakeLocation removeFromSuperview];
        [mSaveDraft removeFromSuperview];
        //[mTakeFace removeFromSuperview];
        mTakePhoto.frame = CGRectMake(17, 9, 48, 18);
        [mFunctionController addSubview:share];
        share.frame = CGRectMake(75, 9, 48, 18);
        mTakeTopic.frame = CGRectMake(135, 3, 40, 30);
        mTakeLinkMan.frame = CGRectMake(194, 3, 40, 30);
        mTakeFace.frame = CGRectMake(250, 3, 40, 30);
        //mShowPhoto.frame = CGRectMake(290, 3, 25, 25);
        mFunctionController.backgroundColor = [UIColor clearColor];
    }
    
    if (publishType == kCommentTopicController || publishType == kCommentRevert) {
        
        [pzButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        zfButton.frame = CGRectMake(80, 1, 40, 30);
        addButton.frame = CGRectMake(200, 1, 40, 30);
        htButton.frame = CGRectMake(320, 1, 40, 30);
        faceButton.frame = CGRectMake(440, 1, 40, 30);
        
        mMessage.frame = CGRectMake(0, 40, 540, 160);
        mTextCount.frame = CGRectMake(252, 155, 49, 21);
        kefuButton.frame = CGRectMake((540-80)/2, 157, 80, 16);
        [self.mainView insertSubview:caidanview atIndex:30];
        
    }
    
    
    if (publishType == kForwardTopicController) {
        [share removeFromSuperview];
        [pzButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        zfButton.frame = CGRectMake(80, 1, 40, 30);
        addButton.frame = CGRectMake(200, 1, 40, 30);
        htButton.frame = CGRectMake(320, 1, 40, 30);
        faceButton.frame = CGRectMake(440, 1, 40, 30);
        
        mMessage.frame = CGRectMake(0, 40, 540, 160);
        
    }
    
    if (isShare) {
        [pzButton removeFromSuperview];
        [zfButton removeFromSuperview];
        [faceButton removeFromSuperview];
        [fxButton removeFromSuperview];
        fxButton = nil;
        pzButton = nil;
        
        htButton.frame = CGRectMake(50, 1, 40, 30);
        addButton.frame = CGRectMake(120, 1, 40, 30);
        
    }
    if (publishType == kNewTopicController) {
        mMessage.frame = CGRectMake(0, 40, 540, 160);
//        mMessage.backgroundColor = [UIColor redColor];
//        mMessage.frame = CGRectMake(20, 10, 530, 200);
    }
    
    
    [mTakeTopic addTarget:self action:@selector(pressmTakeTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /******* 表情系统相关 ******/
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 3; i++) {
        [tempArray addObject:[NSNull null]];
    }
    self.viewControllers = tempArray;
    [tempArray release];
    
    scrollView.scrollsToTop = NO;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    scrollView.backgroundColor = [UIColor clearColor];
    pageControl.backgroundColor = [UIColor clearColor];
    [self updateUI];
    
	[mMessage becomeFirstResponder];
	
    
    if (self.lottery_id) {
        mTakePhoto.enabled = NO;
        share.enabled = NO;
    }
    [self.mainView insertSubview:mMessage atIndex:0];
    [self.mainView insertSubview:mTextCount atIndex:999];
	[self.mainView insertSubview:scrollView atIndex:1000];
    [self.mainView addSubview:pageControl];
    pageControl.frame = CGRectMake(100, self.mainView.bounds.size.height - 35, 320, 36);
    float keybordHeight = 406;
    pzImage.frame = CGRectMake(0, 768 - keybordHeight - 160 + 18, 540, 32);
    mTextCount.frame = CGRectMake(470, 768 - keybordHeight - 160 - 4, 49, 21);
    
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:003];
    ima.frame = CGRectMake(0, 768 - keybordHeight - 160 + 50, 540, 320);
#ifdef isCaiPiaoForIPad
    ima.frame = CGRectMake(0, 768 - keybordHeight - 160 + 50, 540, 400);
#endif
    
    kefuButton.frame = CGRectMake((540-80)/2, 768 - keybordHeight - 160 - 2, 80, 16);
    
    if (self.publishType == kCommentTopicController) {
        
        pzImage.frame = CGRectMake(0, 768 - keybordHeight - 160 + 18, 540, 32);
        mTextCount.frame = CGRectMake(470, 768 - keybordHeight - 160 - 4, 49, 21);
        kefuButton.frame = CGRectMake((540-80)/2, 768 - keybordHeight - 160 - 2, 80, 16);
        
        
    }
    if (infoShare) {
        scrollView.hidden = YES;
        pageControl.hidden = YES;
        
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/-2];
        rotationAnimation.duration = 0.0f;
         potimage.image = mSelectImage;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [potimage.layer addAnimation:rotationAnimation forKey:@"run"];
        potimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);

        
        
        
       
        potButton1.hidden = YES;
        potButton2.hidden = YES;
        potButton3.hidden = potButton1.hidden;
        potButton4.hidden = potButton1.hidden;
        delButton.hidden = NO;
        potimage.hidden = NO;

    }
    
//    if (infoShare) {
//        
//        potimage.image = mSelectImage;
//        potButton1.hidden = YES;
//        potButton2.hidden = YES;
//        delButton.hidden = NO;
//        potimage.hidden = NO;
//        [mMessage resignFirstResponder];
//        
//        UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:003];
//        ima.frame = CGRectMake(0, 768 - keybordHeight/2 + 50, 540, 320);
//        
//        pzImage.frame = CGRectMake(0, 768 - keybordHeight/2 + 18, 540, 32);
//        mTextCount.frame = CGRectMake(470, 768 - keybordHeight/2 - 4, 49, 21);
//
//        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
//        
//        kefuButton.hidden = YES;
//        pageControl.hidden = YES;
//        mMessage.frame = CGRectMake(15, 5, 540, 160);
//
//
//        
//        
//        
//    }
}


// 视图载入
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
   
    if (potimage.image == nil) {
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
        
        
    }
    else{
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
        
        
    }

    
}


- (void)pressZFButton:(UIButton *)sender{
        
    if (mNonceBtn.selected) {
        mNonceBtn.selected = NO;
        //[zfButton setImage:UIImageGetImageFromName(@"wbzf.png") forState:UIControlStateNormal];
        UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
        zfImage.image = UIImageGetImageFromName(@"wbzf.png");
        [zfButton addSubview:zfImage];
        [zfImage release];
    } else {
        mNonceBtn.selected = YES;
        //[zfButton setImage:UIImageGetImageFromName(@"wbzf2.png") forState:UIControlStateNormal];
        UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 18, 18)];
        zfImage.image = UIImageGetImageFromName(@"wbzf2.png");
        [zfButton addSubview:zfImage];
        [zfImage release];
        if (publishType == kForwardTopicController) {
            
            if ([mStatus.orignal_id isEqualToString:@"0"]) {
                NSString * msg = [@"同时评论给" stringByAppendingString:mStatus.nick_name];
                [[caiboAppDelegate getAppDelegate] showjianpanMessage:msg view:tempWindow];
            }else{
                NSString * msg = [NSString stringWithFormat:@"%@ %@",[@"同时评论给" stringByAppendingString:mStatus.nick_name], [@"同时评论给" stringByAppendingString:mStatus.nick_name_ref]];
                
                [[caiboAppDelegate getAppDelegate] showjianpanMessage:msg view:tempWindow];
            }

          
        }else {//if(publishType == kCommentTopicController)
            
            //caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            NSString * msg = @"同时转发到我的微博";
            [[caiboAppDelegate getAppDelegate] showjianpanMessage:msg view:tempWindow];
            //[[caiboAppDelegate getAppDelegate] showMessage:msg HidenSelf:YES];
            
//            //旋转
//            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//            rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
//            rotationAnimation.duration = 0.0f;
//            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            [tempWindow.layer addAnimation:rotationAnimation forKey:@"run"];
//            tempWindow.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
            
        }


    
    }


}

- (void)pressmTakeTopic:(UIButton *)sender{
//    [mMessage resignFirstResponder
//     ];
//    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //分享按钮图片切换kCommentRevert
    
#ifdef  isCaiPiaoForIPad
    
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    
#endif
    
    if (publishType != kForwardTopicController && publishType != kCommentTopicController && publishType != KShareController && publishType != kCommentRevert) {
        if (!fxButton) {
            
        }
        else {
            if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb777.png");
            }
            else{
                
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb10.png");
                
            }
        }
        
        //
        //    potimage.hidden = YES;
        if (potimage.image == nil) {
            
            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
            
            
        }
        else{
            
            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
            
            
        }

    }
        

    [mMessage becomeFirstResponder];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
        NSLog(@"st = %@,  ing = %@", st, mMessage.text);
        if ([st isEqualToString:@"#"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }
        
    }
    if (mMessage.selectedRange.location !=NSNotFound) {
		mIndex = mMessage.selectedRange;
	}
	else {
		mIndex = NSMakeRange([mMessage.text length], 0);
	}

	
    NSString * name = @"##";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
}

- (void)pressdelButton:(UIButton *)sender{
    potimage.hidden = YES;
    delButton.hidden = YES;
    potButton1.hidden = NO;
    potButton2.hidden = NO;
    potButton3.hidden = potButton1.hidden;
    potButton4.hidden = potButton1.hidden;
    potimage.image = nil;
    if ([mMessage.text length] == 0 && !mSelectImage) {
        mPostBtn.enabled = NO;
        canPublice = NO;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    }
    mSelectImage = nil;
}

- (void)pressPotButtona1:(UIButton *)sender{
    shareView.hidden =YES;
   baimageview.hidden = YES;
  
  
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
//        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        
//        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:picker];
//        popoverController.delegate=self;
//        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        [picker release];
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated: YES completion:nil];
//        [self.navigationController pushViewController:picker animated:YES];
        [picker release];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
													   message:NSLocalizedString(@"have no camera",nil)
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }


    
}

- (void)pressPotButtonb2:(UIButton *)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
#ifdef isCaiPiaoForIPad
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        popoverController.delegate=self;
        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#else
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        [self presentViewController:picker animated: YES completion:nil];
//        [self.navigationController pushViewController:picker animated:YES];
        [picker release];
#endif

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
														message:NSLocalizedString(@"have no camera",nil)
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }


}

- (void)pressPotButtona3:(UIButton *)sender{
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"插入微博链接" message:@"请输入微博ID" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 111;
    [alert show];
    alert.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [alert.myTextField resignFirstResponder];
    [alert.myTextField becomeFirstResponder];
    alert.myTextField.secureTextEntry = NO;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(0, 5, 260, 30);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [alert.myTextField.superview.superview addSubview:label];
    label.text = @"在微博中插入另一个微博链接, 点链接即可查看该微博";
    [label release];
    [alert release];
}

- (void)pressPotButtona4:(UIButton *)sender{
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"插入方案详情链接" message:@"请输入方案ID" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 112;
    [alert show];
    alert.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [alert.myTextField resignFirstResponder];
    [alert.myTextField becomeFirstResponder];
    alert.myTextField.secureTextEntry = NO;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(0, 5, 260, 30);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [alert.myTextField.superview.superview addSubview:label];
    label.text = @"在您的微博中插入一个方案链接, 点链接即可查看方案";
    [label release];
    [alert release];
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (buttonIndex == 1 ) {
        if (alertView.tag == 111) {
            [self friendsViewDidSelectFriend:[NSString stringWithFormat:@" http://caipiao365.com/wbxq=%@",message]];
            
        }
        else if (alertView.tag == 112) {
            [self friendsViewDidSelectFriend:[NSString stringWithFormat:@" http://caipiao365.com/faxq=%@",message]];
        }
    }
}



- (void)pressRedButton:(UIButton *)sender{
//    [mMessage resignFirstResponder
//     ];
//    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [mMessage becomeFirstResponder];
 //   [mMessage reloadInputViews];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
      //  NSString * ing = mMessage.text;
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
      //  NSLog(@"st = %@,  ing = %@", st, ing);
        if ([st isEqualToString:@"]"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }

    }
            
    
         
    //mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
    mIndex = mMessage.selectedRange;
    

    NSString * name = @"[]";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
    [mMessage resignFirstResponder];
    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [mMessage becomeFirstResponder];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);

   // 
   
  //
}

- (void)pressbubutton:(UIButton *)sender{
    
    
    if (sender.tag == 1) {
		if (!cpthImage) {
            
			cpthImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, self.mainView.frame.size.height - keybordH - 32 - 97 , 155, 97)];
            cpthImage.userInteractionEnabled = YES;
            
//			UITextView * cpthreetext = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, 170, 160)];
//			cpthreetext.text = @"输入 [红 03] 显示 \n输入 [蓝 03] 显示 \n输入 [胆 03] 显示 \n";
//			cpthreetext.backgroundColor = [UIColor clearColor];
//			cpthreetext.textColor = [UIColor blackColor];
//            cpthreetext.font = [UIFont boldSystemFontOfSize:13];
            UILabel *redln = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 30, 15)];
            redln.text = @"输入";
            redln.textAlignment = NSTextAlignmentCenter;
            redln.font = [UIFont boldSystemFontOfSize:13];
            redln.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            redln.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:redln];
            [redln release];
            
            UILabel *redfon = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 45, 24)];
            redfon.text = @"[红 03]";
            redfon.textAlignment = NSTextAlignmentCenter;
            redfon.font = [UIFont boldSystemFontOfSize:14];
            redfon.textColor = [UIColor blackColor];
            redfon.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:redfon];
            [redfon release];
            
            UILabel *redxs = [[UILabel alloc] initWithFrame:CGRectMake(92, 15, 30, 15)];
            redxs.text = @"显示";
            redxs.textAlignment = NSTextAlignmentCenter;
            redxs.font = [UIFont boldSystemFontOfSize:13];
            redxs.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            redxs.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:redxs];
            [redxs release];
            
            UIImageView * ima1 = [[UIImageView alloc] initWithFrame:CGRectMake(125, 10, 24, 24)];
            ima1.image = UIImageGetImageFromName(@"red111.png");
            
            
            UILabel *blueln = [[UILabel alloc] initWithFrame:CGRectMake(12, 40, 30, 15)];
            blueln.text = @"输入";
            blueln.textAlignment = NSTextAlignmentCenter;
            blueln.font = [UIFont boldSystemFontOfSize:13];
            blueln.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            blueln.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:blueln];
            [blueln release];
            
            UILabel *bluefon = [[UILabel alloc] initWithFrame:CGRectMake(45, 35, 45, 24)];
            bluefon.text = @"[蓝 03]";
            bluefon.textAlignment = NSTextAlignmentCenter;
            bluefon.font = [UIFont boldSystemFontOfSize:14];
            bluefon.textColor = [UIColor blackColor];
            bluefon.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:bluefon];
            [bluefon release];
            
            UILabel *bluexs = [[UILabel alloc] initWithFrame:CGRectMake(92, 40, 30, 15)];
            bluexs.text = @"显示";
            bluexs.textAlignment = NSTextAlignmentCenter;
            bluexs.font = [UIFont boldSystemFontOfSize:13];
            bluexs.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            bluexs.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:bluexs];
            [bluexs release];

             UIImageView * ima2 = [[UIImageView alloc] initWithFrame:CGRectMake(125, 35, 24, 24)];
            ima2.image = UIImageGetImageFromName(@"blue222.png");
            
            
            UILabel *danln = [[UILabel alloc] initWithFrame:CGRectMake(12, 65, 30, 15)];
            danln.text = @"输入";
            danln.textAlignment = NSTextAlignmentCenter;
            danln.font = [UIFont boldSystemFontOfSize:13];
            danln.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            danln.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:danln];
            [danln release];
            
            UILabel *danfon = [[UILabel alloc] initWithFrame:CGRectMake(45, 60, 45, 24)];
            danfon.text = @"[胆 03]";
            danfon.textAlignment = NSTextAlignmentCenter;
            danfon.font = [UIFont boldSystemFontOfSize:14];
            danfon.textColor = [UIColor blackColor];
            danfon.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:danfon];
            [danfon release];
            
            UILabel *danxs = [[UILabel alloc] initWithFrame:CGRectMake(92, 65, 30, 15)];
            danxs.text = @"显示";
            danxs.textAlignment = NSTextAlignmentCenter;
            danxs.font = [UIFont boldSystemFontOfSize:13];
            danxs.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            danxs.backgroundColor = [UIColor clearColor];
            [cpthImage addSubview:danxs];
            [danxs release];

            UIImageView * ima3 = [[UIImageView alloc] initWithFrame:CGRectMake(125, 60, 24, 24)];
            ima3.image = UIImageGetImageFromName(@"yl333.png");
//             UIImageView * ima4 = [[UIImageView alloc] initWithFrame:CGRectMake(105, 101, 21, 21)];
            //ima4.image = UIImageGetImageFromName(@"cpthree_yelBall.png");
            UILabel * la1 = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 21, 21)];
            la1.text = @"03";
            la1.textAlignment = NSTextAlignmentCenter;
            la1.font = [UIFont systemFontOfSize:12];
            la1.textColor = [UIColor whiteColor];
            la1.backgroundColor = [UIColor clearColor];
            
            UILabel * la2 = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 21, 21)];
            la2.text = @"03";
            la2.textAlignment = NSTextAlignmentCenter;
            la2.font = [UIFont systemFontOfSize:12];
            la2.textColor = [UIColor whiteColor];
             la2.backgroundColor = [UIColor clearColor];
            UILabel * la3 = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 21, 21)];
            la3.text = @"03";
            la3.textAlignment = NSTextAlignmentCenter;
            la3.font = [UIFont systemFontOfSize:12];
            la3.textColor = [UIColor whiteColor];
             la3.backgroundColor = [UIColor clearColor];
//            UILabel * la4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
//            la4.text = @"03";
//            la4.textAlignment = NSTextAlignmentCenter;
//            la4.font = [UIFont systemFontOfSize:12];
//            la4.textColor = [UIColor whiteColor];
//             la4.backgroundColor = [UIColor clearColor];
            [ima1 addSubview:la1];
            [ima2 addSubview:la2];
            [ima3 addSubview:la3];
           // [ima4 addSubview:la4];
            [cpthImage addSubview:ima1];
            [cpthImage addSubview:ima2];
            [cpthImage addSubview:ima3];
            //[cpthImage addSubview:ima4];
			//[cpthImage addSubview:cpthreetext];
			//[cpthreetext release];
			[self.mainView addSubview:cpthImage];
			[cpthImage release];
            [ima1 release];
            [ima2 release];
            [ima3 release];
            //[ima4 release];
            [la1 release];
            [la2 release];
            [la3 release];
           // [la4 release];
		}
		//cpthImage.image = UIImageGetImageFromName(@"wb_layer.png");
        cpthImage.image = UIImageGetImageFromName(@"wf555.png");
        
        [mTextCount setHidden:YES];
        [cpthImage setHidden:NO];
        sender.tag = 0;
    }else{
        
        [mTextCount setHidden:NO];
        [cpthImage setHidden:YES];
        sender.tag = 1;
    }
}

- (void)pressBlueButton:(UIButton *)sender{
//    [mMessage resignFirstResponder
//     ];
//    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [mMessage becomeFirstResponder];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
        NSLog(@"st = %@,  ing = %@", st, mMessage.text);
        if ([st isEqualToString:@"]"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }
        
    }
    
    mIndex = mMessage.selectedRange;
    NSString * name = @"[蓝 ]";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
    [mMessage resignFirstResponder];
    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [mMessage becomeFirstResponder];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
   // [mMessage setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
}

- (void)pressPurpleButton:(UIButton *)sender{
//    [mMessage resignFirstResponder
//     ];
//    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [mMessage becomeFirstResponder];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
        NSLog(@"st = %@,  ing = %@", st, mMessage.text);
        if ([st isEqualToString:@"]"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }
        
    }
    
    mIndex = mMessage.selectedRange;
    NSString * name = @"[胆 ]";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
    [mMessage resignFirstResponder];
    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [mMessage becomeFirstResponder];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);

}

- (void)pressYellButton:(UIButton *)sender{
//    [mMessage resignFirstResponder];
//    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [mMessage becomeFirstResponder];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
        NSLog(@"st = %@,  ing = %@", st, mMessage.text);
        if ([st isEqualToString:@"]"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }
        
    }
    
    mIndex = mMessage.selectedRange;
    NSString * name = @"[飞盘 ]";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
    [mMessage resignFirstResponder];
    mMessage.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [mMessage becomeFirstResponder];
    mMessage.selectedRange = NSMakeRange(mIndex.location - 1, mIndex.length);


}

- (void) keyboardWillShow:(id)sender
{
    
   
#ifdef  isCaiPiaoForIPad
    //分享按钮图片切换
    if (publishType != kForwardTopicController && publishType != kCommentTopicController && publishType != kCommentRevert) {
        if (!fxButton) {
            
        }
        else {
            if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb777.png");
            }
            else{
                
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb10.png");
                
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    CGFloat keybordHeight = CGRectGetWidth(keybordFrame);
    if ((int)keybordHeight <= 0 ||keybordHeight == 270) {
        keybordHeight = 360;// 拆分键盘强制设定高度为380
    }
    keybordH = keybordHeight;
    NSLog(@"keybordHeight----------------------------->%f dddd= %f",keybordHeight,CGRectGetWidth(keybordFrame));
 
    pzImage.frame = CGRectMake(0, 768 - keybordHeight - 160 + 18, 540, 32);
    mTextCount.frame = CGRectMake(470, 768 - keybordHeight - 160 - 4, 49, 21);
    
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:003];
    ima.frame = CGRectMake(0, 768 - keybordHeight - 160 + 50, 540, 320);
#ifdef isCaiPiaoForIPad
    ima.frame = CGRectMake(0, 768 - keybordHeight - 160 + 50, 540, 400);
#endif
    
    kefuButton.frame = CGRectMake((540-80)/2, 768 - keybordHeight - 160 - 2, 80, 16);

        if (self.publishType == kCommentTopicController) {
            
        pzImage.frame = CGRectMake(0, 768 - keybordHeight - 160 + 18, 540, 32);
        mTextCount.frame = CGRectMake(470, 768 - keybordHeight - 160 - 4, 49, 21);
        kefuButton.frame = CGRectMake((540-80)/2, 768 - keybordHeight - 160 - 2, 80, 16);

        
    }
    if ([[[UIApplication sharedApplication] windows] count] <3) {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:[[[UIApplication sharedApplication] windows] count]-1];
    }else{
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    }
    
    
    NSLog(@"temp count = %d", [[[UIApplication sharedApplication] windows] count]);
    NSLog(@"tempwin = %@", [tempWindow description]);
    
    if (cpthImage.hidden == NO) {
        cpthImage.frame = CGRectMake(160, self.mainView.frame.size.height - keybordHeight - 160 - 32 - 97 , 155, 97);
    }
    //    cpthImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, self.mainView.frame.size.height - 216 - 32 - 97 , 155, 97)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];

#else
    //分享按钮图片切换
    if (publishType != kForwardTopicController && publishType != kCommentTopicController && publishType != kCommentRevert) {
        if (!fxButton) {
            
        }
        else {
            if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb777.png");
            }
            else{
                
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb10.png");
                
            }
        }
        //        potimage.hidden = YES;
        //拍照图片切换
        if (potimage.image == nil) {
            //            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            //            iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
            
            
        }
        else{
            //            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            //            iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
            
            
        }
        
    }
    
    
	//[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    keybordH = keybordHeight;
    if (![mMessage isFirstResponder]) {
        keybordH = keybordHeight = 216;
    }
    NSLog(@"keybordHeight----------------------------->%f",keybordHeight);
    mFunctionController.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - mFunctionController.frame.size.height/2);
#ifdef isHaoLeCai
    pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - keybordHeight - pzImage.frame.size.height - 44, 320, 32);
#else
    pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 44, 320, 32);
#endif
    NSInteger isIos7 = 0;
#ifndef isHaoLeCai
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        isIos7 = 20;
    }
#endif
    self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
    mMessage.frame = CGRectMake(15, 5 - isIos7, 290, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - self.tipsView.frame.size.height - mFunctionController.frame.size.height - 100);
#ifdef isHaoLeCai
    mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - keybordHeight - 100, 49, 21);
    
    kefuButton.frame = CGRectMake((320-88)/2, [UIScreen mainScreen].bounds.size.height - 7 - keybordHeight - 100+2, 88, 29);
#else
    mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - 100, 49, 21);
    if (weiBoContent.length) {
        mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - 100 + 20, 49, 21);
    }
    kefuButton.frame = CGRectMake((320-88)/2, [UIScreen mainScreen].bounds.size.height - 27 - keybordHeight - 100+2, 88, 29);
#endif
    
    if (self.publishType == kForwardTopicController || publishType == KShareController) {
#ifdef isHaoLeCai
        pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - keybordHeight - pzImage.frame.size.height - 44, 320, 32);
#else
        pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 44, 320, 32);
#endif

        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
        //mMessage.frame = mMessage.frame = CGRectMake(15, 54, 290, [UIScreen mainScreen].bounds.size.height -20 - keybordHeight - mFunctionController.frame.size.height - 54);// 124);
        mMessage.frame = CGRectMake(15, 5 - isIos7, 290, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - self.tipsView.frame.size.height - mFunctionController.frame.size.height - 100);
#ifdef isHaoLeCai
        mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - keybordHeight - 100, 49, 21);
        
        kefuButton.frame = CGRectMake((320-88)/2, [UIScreen mainScreen].bounds.size.height - 7 - keybordHeight - 100+2, 88, 29);
#else
        mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - 100, 49, 21);
        if (weiBoContent.length) {
            mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - 100 + 20, 49, 21);
        }
        kefuButton.frame = CGRectMake((320-88)/2, [UIScreen mainScreen].bounds.size.height - 27 - keybordHeight - 100+2, 88, 29);
#endif
        
    }
    if (self.publishType == kCommentTopicController) {
#ifdef isHaoLeCai
        pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 24, 320, 32);
#else
        pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 44, 320, 32);
#endif
        mFunctionController.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2 +5);
        
        self.tipsView.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - mFunctionController.frame.size.height/2);
#ifdef isHaoLeCai
        mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - keybordHeight - 100, 49, 21);
        
        kefuButton.frame = CGRectMake((320-88)/2,  [UIScreen mainScreen].bounds.size.height - 7 - keybordHeight - 100+2, 88, 29);
#else
        mTextCount.frame = CGRectMake(260, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - 100, 49, 21);

        kefuButton.frame = CGRectMake((320-88)/2,  [UIScreen mainScreen].bounds.size.height - 27 - keybordHeight - 100+2, 88, 29);
#endif
        mMessage.frame  = CGRectMake(15, 5 - isIos7, 290, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - self.tipsView.frame.size.height - mFunctionController.frame.size.height - 100);// 124);
        
        
    }
    if ([[[UIApplication sharedApplication] windows] count] <3) {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:[[[UIApplication sharedApplication] windows] count]-1];
    }else{
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    }
    
    
    NSLog(@"temp count = %lu", (unsigned long)[[[UIApplication sharedApplication] windows] count]);
    NSLog(@"tempwin = %@", [tempWindow description]);
    
    if (cpthImage.hidden == NO) {
        cpthImage.frame = CGRectMake(160, self.mainView.frame.size.height - keybordHeight - 32 - 97 , 155, 97);
    }
    //    cpthImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, self.mainView.frame.size.height - 216 - 32 - 97 , 155, 97)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];

#endif
        

}
- (void) keyboardWillDisapper:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    

#ifdef  isCaiPiaoForIPad
    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:003];
    ima.frame = CGRectMake(0, 768 - keybordHeight/2 + 50, 540, 400);
    
    pzImage.frame = CGRectMake(0, 768 - keybordHeight/2 + 18, 540, 32);
    mTextCount.frame = CGRectMake(470, 768 - keybordHeight/2 - 4, 49, 21);
    
#ifdef isCaiPiaoForIPad
    kefuButton.frame = CGRectMake((540-80)/2,  768 - keybordHeight/2 - 2, 80, 16);
#else
    kefuButton.frame = CGRectMake((320-88)/2,  212, 88, 29);
#endif
    mFunctionController.center = CGPointMake(160, 460 - 216 - mFunctionController.frame.size.height/2);
    
    if (self.publishType == kForwardTopicController || publishType == KShareController) {
        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
    }
    if (self.publishType == kCommentTopicController) {
        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

#else
    
    //[self.mMessage setSelectedRange:NSMakeRange(0, 0)];ddddddddd
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
#ifdef isHaoLeCai
    pzImage.frame = CGRectMake(0, self.mainView.frame.size.height - 196 - pzImage.frame.size.height, 320, 32);
    mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 4, 49, 21);
    if (weiBoContent.length) {
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 4 + 20, 49, 21);
    }
#else
    pzImage.frame = CGRectMake(0, self.mainView.frame.size.height - 216 - pzImage.frame.size.height, 320, 32);
    mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24, 49, 21);
    if (weiBoContent.length) {
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24 + 20, 49, 21);
    }
#endif

    mFunctionController.center = CGPointMake(160, 460 - 216 - mFunctionController.frame.size.height/2);
    if (self.publishType == kForwardTopicController || publishType == KShareController) {
        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
        //pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 74, 320, 32);
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24, 49, 21);
        if (weiBoContent.length) {
            mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24 + 20, 49, 21);
        }
    }
    if (self.publishType == kCommentTopicController) {
        self.tipsView.center = CGPointMake(160, mFunctionController.frame.origin.y - self.tipsView.frame.size.height/2);
        //pzImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - keybordHeight - pzImage.frame.size.height - 200, 320, 32);
#ifdef isHaoLeCai
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 4, 49, 21);
        if (weiBoContent.length) {
            mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 4 + 20, 49, 21);
        }
#else
        mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24, 49, 21);
        if (weiBoContent.length) {
            mTextCount.frame = CGRectMake(260, self.mainView.frame.size.height - 216 - pzImage.frame.size.height - 24 + 20, 49, 21);
        }
#endif
//        kefuButton.frame = CGRectMake((320-80)/2,  212, 80, 16);
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

#endif
    
}
- (void) actionAtSomeTime:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = YES;
    } else {
        sender.selected = NO;
    }
}

- (void)shareSina:(CP_XZButton *)btn {
    if (btn != Btn1) {
        Btn1.selected = NO;
    }
    if (btn != Btn2) {
        Btn2.selected = NO;
    }
    if (btn != Btn3) {
        Btn3.selected = NO;
    }

}

//分享 
- (void)doShare {
    
#ifdef isCaiPiaoForIPad
    UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
    iamgevi.image = UIImageGetImageFromName(@"wb777.png");
    [mMessage resignFirstResponder];
    
    //
    potimage.hidden = YES;
    if (potimage.image == nil) {
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
        
        
    }
    else{
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
        
        
    }
    
    
	
	if (!shareView) {
        
		shareView = [[UIView alloc] init];
		shareView.frame = CGRectMake(0, 300, 540, 184);
        shareView.userInteractionEnabled = YES;
        shareView.backgroundColor = [UIColor clearColor];
		[self.mainView addSubview:shareView];
		[shareView release];
		
		Btn1 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        Btn1.frame = CGRectMake(190, 40, 160, 30);
        [Btn1 loadButtonName:@"分享到新浪微博"];
        Btn1.buttonName.frame = CGRectMake(0, 0, 160, 30);
        [Btn1 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:Btn1];
        
//        Btn2 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
//        Btn2.frame = CGRectMake(190, 85, 160, 30);
//        [Btn2 loadButtonName:@"分享到QQ空间"];
//        [Btn2 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
//        Btn2.buttonName.frame = CGRectMake(0, 0, 160, 30);
//        
//        [shareView addSubview:Btn2];
        
        Btn3 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        Btn3.frame = CGRectMake(190, 85, 160, 30);
        [Btn3 loadButtonName:@"分享到腾讯微博"];
        [Btn3 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
        Btn3.buttonName.frame = CGRectMake(0, 0, 160, 30);
        [shareView addSubview:Btn3];
        //        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnionType"] intValue] == 2) {
        //            Btn1.enabled = NO;
        //            Btn2.enabled = NO;
        //            Btn3.enabled = NO;
        //        }
	}
	shareView.hidden =NO;
	baimageview.hidden = YES;
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    potButton1.hidden = YES;
    potButton2.hidden = YES;
    potButton3.hidden = potButton1.hidden;
    potButton4.hidden = potButton1.hidden;
    potimage.hidden = YES;
    delButton.hidden = YES;

#else
    UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
    iamgevi.image = UIImageGetImageFromName(@"wb777.png");
    [mMessage resignFirstResponder];
    
    //
    potimage.hidden = YES;
    if (potimage.image == nil) {
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
        
        
    }
    else{
        
        UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
        iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
        
        
    }
    
    
	
	if (!shareView) {
        
		shareView = [[UIView alloc] init];
		shareView.frame = CGRectMake(0, self.mainView.bounds.size.height - 214, 320, 184);
        shareView.userInteractionEnabled = YES;
		[self.mainView addSubview:shareView];
		[shareView release];
		
		Btn1 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        Btn1.frame = CGRectMake(80, 40, 160, 30);
        [Btn1 loadButtonName:@"分享到新浪微博"];
        Btn1.buttonName.frame = CGRectMake(0, 0, 160, 30);
        [Btn1 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:Btn1];
        
//        Btn2 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
//        Btn2.frame = CGRectMake(80, 85, 160, 30);
//        [Btn2 loadButtonName:@"分享到QQ空间"];
//        [Btn2 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
//        Btn2.buttonName.frame = CGRectMake(0, 0, 160, 30);
//        
//        [shareView addSubview:Btn2];
        
        Btn3 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        Btn3.frame = CGRectMake(80, 85, 160, 30);
        [Btn3 loadButtonName:@"分享到腾讯微博"];
        [Btn3 addTarget:self action:@selector(shareSina:) forControlEvents:UIControlEventTouchUpInside];
        Btn3.buttonName.frame = CGRectMake(0, 0, 160, 30);
        [shareView addSubview:Btn3];
        //        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnionType"] intValue] == 2) {
        //            Btn1.enabled = NO;
        //            Btn2.enabled = NO;
        //            Btn3.enabled = NO;
        //        }
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
#ifdef isHaoLeCai
            shareView.frame = CGRectMake(0, self.mainView.bounds.size.height - 204, 320, 184);
#else
            shareView.frame = CGRectMake(0, self.mainView.bounds.size.height - 224, 320, 184);
#endif
        }else{
            shareView.frame = CGRectMake(0, self.mainView.bounds.size.height - 184, 320, 184);
        }
        
            
//        }else{
//            if (IS_IPHONE_5) {
//                
//                
//            }else{
//                shareView.frame = CGRectMake(0, self.mainView.bounds.size.height - 124, 320, 184);
//            }
//        }
	}
	shareView.hidden =NO;
	baimageview.hidden = YES;
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    potButton1.hidden = YES;
    potButton2.hidden = YES;
    potButton3.hidden = potButton1.hidden;
    potButton4.hidden = potButton1.hidden;
    potimage.hidden = YES;
    delButton.hidden = YES;

#endif
    
}

// 返回上一个界面
- (void)actionBack:(UIButton *)sender {
    if (publishType == kForwardTopicController || publishType == KShareController || publishType == kCommentTopicController) {
        if ([mMessage.text length] > 0) {
            [mMessage resignFirstResponder];
            CP_LieBiaoView *lb1 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            lb1.delegate = self;
            lb1.tag = 101;
            [lb1 LoadButtonName:[NSArray arrayWithObjects:@"放弃",nil]];
            [lb1 show];
            [lb1 release];
        } else {
#ifdef isCaiPiaoForIPad
            [self goBackToforiPad];
#else
            [self dismissSelf:YES];
#endif
          
              
            
        }
    } else {
        if ([mMessage.text length] > 0) {
            [mMessage resignFirstResponder];
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"内容尚未发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 102;
            [alert show];
            [alert release];
            
//            CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            lb2.delegate = self;
//            lb2.tag = 102;
//            [lb2 LoadButtonName:[NSArray arrayWithObjects:@"确定",nil]];
//            [lb2 show];
//            [lb2 release];
        } else {
            
#ifdef isCaiPiaoForIPad
            [self goBackToforiPad];
#else
             [self dismissSelf:YES];
#endif
           
            
        }
    }
    
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            
            if (three) {
                [self.navigationController setNavigationBarHidden:YES animated:NO];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
#ifdef isCaiPiaoForIPad
                [self goBackToforiPad];
#else
                
                [self dismissSelf:YES];
#endif
                
            }
            
        }
    }
}

- (void)goBackToforiPad
{
	
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}

- (void)quxiaobutton{
    [mMessage becomeFirstResponder];
//    [mMessage performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:3];
}
- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (liebiaoView.tag == 101) {
        if (buttonIndex == 0) {
            [self dismissSelf:YES];
        }
    }
    if (liebiaoView.tag == 102) {
        if (buttonIndex == 0) {
        
            if (three) {
                [self.navigationController setNavigationBarHidden:YES animated:NO];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
#ifdef isCaiPiaoForIPad
                [self goBackToforiPad];
#else
                
                [self dismissSelf:YES];
#endif
                
            }

        }
    }
    if (liebiaoView.tag == 103)//清除文字
    {
        
        if (buttonIndex == 0) {
            
            [mMessage setText:@""];
            [self changeTextCount:[mMessage text]];
            mIndex = NSMakeRange([mMessage.text length], 0);
            [mMessage becomeFirstResponder  ];
        }
    }
}
- (void)uploadHeadImage:(NSData*)imageData {//图片上传
    NSString *text = @"正在发送微博...";
    if (publishType == kOpinionFeedBack) {
        text = @"正在发送意见反馈...";
    }
    [[ProgressBar getProgressBar] show:text view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
    
    NSURL *serverURL = [NSURL URLWithString:@"http://t.diyicai.com/servlet/UploadGroupPic"];
    
    [mReqData clearDelegatesAndCancel];
    self.mReqData = [ASIFormDataRequest requestWithURL:serverURL];
    [mReqData addData:imageData withFileName:@"george.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
    [mReqData setUsername:@"upload"];
    [mReqData setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mReqData setDelegate:self];
    [mReqData startAsynchronous];
    NSLog(@"%@", mReqData.url);
}


//验证微博帮顶状态决定跳转
- (void)actionYanZheng {
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if (!loadview.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
    }

    if (Btn1.selected || Btn2.selected || Btn3.selected) {
        if (Btn1.selected) {
            
                share0 = NO;
                [mRequest clearDelegatesAndCancel];
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"1"]];
                
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest setDidFinishSelector:@selector(SinaFinish:)];
                [mRequest startAsynchronous];
           
        }
        else if (Btn2.selected) {
                share0 = NO;
                [mRequest clearDelegatesAndCancel];
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"3"]];
                
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest setDidFinishSelector:@selector(qqZoneFinish:)];
                [mRequest startAsynchronous];
            
        }
        else if (Btn3.selected) {
                share0 = NO;
                [mRequest clearDelegatesAndCancel];
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"2"]];
                
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest setDidFinishSelector:@selector(qqFinish:)];
                [mRequest startAsynchronous];
            
        }
        return;
    }
    if ([self.shareTo length]) {
        if ([self.shareTo isEqualToString:@"1"]) {
           
                
                [mRequest clearDelegatesAndCancel];
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"1"]];
                
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest setDidFinishSelector:@selector(SinaFinish:)];
                [mRequest startAsynchronous];
            
        }
        else if ([self.shareTo isEqualToString:@"2"]) {
            share0 = YES;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"2"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(qqFinish:)];
            [mRequest startAsynchronous];
        }
        else if ([self.shareTo isEqualToString:@"3"]){
            share0 = YES;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"3"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(qqZoneFinish:)];
            [mRequest startAsynchronous];
        }else{
            [self actionPublish:nil];
        }
        return;
    }
#ifdef isCaiPiaoForIPad
    
    if ([mMessage.text length] ==0 && potimage.image == nil&&publishType != kForwardTopicController) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showjianpanMessage:@"您还没有发表任何东西" view:tempWindow];
        return;
    }

#endif
        [self actionPublish:nil];
}

// 发布帖子
- (void)actionPublish:(UIButton *)sender {
     NSLog(@"aaaaaaaa");
    btnwan.enabled =  NO;
    if (!canPublice) {
        [[caiboAppDelegate getAppDelegate] showjianpanMessage:@"您还没有发表任何东西" view:tempWindow];
        btnwan.enabled = YES;
        [loadview stopRemoveFromSuperview];
        loadview = nil;
        return;
    }
    if ([mTextCount.titleLabel.text intValue] < 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容已经超出字数限制" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        btnwan.enabled = YES;
        [loadview stopRemoveFromSuperview];
        loadview = nil;
        return;
    }
    [MobClick event:@"event_weibofasong"];
    if (publishType == kCommentTopicController) {// 评论微博
        NSString *is_trans_topic = @"0";
        if (mNonceBtn.selected) {
            is_trans_topic = @"1";
        }
        
        [mRequest clearDelegatesAndCancel];
        if (cpthree) {
			NSString *shareInfo =nil;
			if (share0) {
                if (Btn1.selected) {
                    shareInfo = @"share0=1";
                }
                else if (Btn2.selected){
                    shareInfo = @"share0=3";
                }
                else if (Btn3.selected){
                    shareInfo = @"share0=2";
                }
				
			}
			else {
				shareInfo = @"share0=0";
			}
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveYtComment:mStatus.topicid content:[mMessage text] userId:[[Info getInstance] userId] is_trans_topic:is_trans_topic source:@"1" share:shareInfo]];
            
            
//            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:@"" userid:[[Info getInstance] userId] lotteryId:@"" lotteryNumber:@"" content:[mMessage text]]];
//            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [mRequest setDelegate:self];
//            [mRequest setDidFinishSelector:@selector(FaBiaoDidFinishSelector:)];
//            [mRequest setNumberOfTimesToRetryOnTimeout:2];
//            [mRequest startAsynchronous];
            
            
        }else{
			NSString *shareInfo =nil;
			if (share0) {
				shareInfo = @"share0=1";
			}
			else {
				shareInfo = @"share0=0";
			}
            
                			self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveYtComment:mStatus.topicid content:[mMessage text] userId:[[Info getInstance] userId] is_trans_topic:is_trans_topic source:@"1" share:shareInfo]];
        
        [mRequest setUsername:@"comment"];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        }
        [[ProgressBar getProgressBar] show:@"发送微博评论..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
            
        return;
    }
    
    if (publishType == kCommentRevert) {// 评论回复
        NSString *totop = @"0";
        if (mNonceBtn.selected) {
            totop = @"1";
        }
        
        [mRequest clearDelegatesAndCancel];
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsendComment:[[Info getInstance] userId] content:[mMessage text] topicId:mStatus.topicid source:@"1" totop:totop]];
        [mRequest setUsername:@"comment"];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        [[ProgressBar getProgressBar] show:@"发送微博评论..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        return;
    }
    
    if (publishType == kNewTopicController || publishType == kEditTopicController || publishType == kOpinionFeedBack) {// 新微博和意见反馈
        if (mSelectImage) {
            
            float width  = mSelectImage.size.width;
            float height = mSelectImage.size.height;
            float scale;
            
            if (width > height) {
                scale = 640.0 / width;
            } else {
                scale = 480.0 / height;
            }
            
            if (scale >= 1.0) {
                [self uploadHeadImage:UIImageJPEGRepresentation(mSelectImage, 1.0)];
            } else if (scale < 1.0) {
                [self uploadHeadImage:UIImageJPEGRepresentation([mSelectImage scaleAndRotateImage:640], 1.0)];
            }
        } else {
            if (publishType == kNewTopicController || publishType == kEditTopicController) {
                [mRequest clearDelegatesAndCancel];
                
                if (three) {
                    //            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveYtComment:mStatus.topicid content:[mMessage text] userId:[[Info getInstance] userId] is_trans_topic:is_trans_topic source:@"1"]];
                    
               //     NSLog(@"mrequest = %@",[NetURL CPThreeSendPreditTopicIssue:@"" userid:[[Info getInstance] userId] lotteryId:caizhong lotteryNumber:@"" content:[mMessage text]]);
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:@"" userid:[[Info getInstance] userId] lotteryId:caizhong lotteryNumber:@"" content:[mMessage text] endtime:@""]];
                    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [mRequest setDelegate:self];
                    [mRequest setTimeOutSeconds:20.0];
                    [mRequest startAsynchronous];
                    
                    [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
                    [ProgressBar getProgressBar].mDelegate = self;
                }else{
					NSString *shareInfo =nil;
					if (share0) {
						shareInfo = @"share0=1";
                      
                        
                        if (Btn1.selected) {
                            shareInfo = @"share0=1";
                        }
                        else if (Btn2.selected) {
                            shareInfo = @"share0=3";
                        }
                        else if (Btn3.selected) {
                            shareInfo = @"share0=2";
                        }
                       
                        
					}
					else {
						shareInfo = @"share0=0";
					}
                    if (orderID) {
                        if ([[mMessage text] rangeOfString:@"@"].location == NSNotFound) {
                            UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"yaqi960.png")];
                            [self.mainView addSubview:imageV];
#ifdef isCaiPiaoForIPad
                            
                            imageV.frame = CGRectMake(170, pzImage.frame.origin.y - 40, 154.5, 42.5);
#else
                            
                            imageV.frame = CGRectMake(45, pzImage.frame.origin.y - 50, 154.5, 42.5);
#endif
                            
                            [imageV release];
                            UILabel *label = [[UILabel alloc] init];
                            label.font = [UIFont systemFontOfSize:13];
                            label.frame =imageV.bounds;
                            label.text = @"从这里选择要邀请的人";
                            label.textAlignment = NSTextAlignmentCenter;
                            label.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
                            label.backgroundColor = [UIColor clearColor];
                            [imageV addSubview:label];
                            [label release];
                            [imageV performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
                            return;
                        }
                        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"15" attach:@"0" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo orderId:orderID lottery_id:lottery_id play:play]];
                        [[NSUserDefaults standardUserDefaults] setValue:mMessage.text forKey:@"yaoqingxinxi"];
                    }
                    else {
                        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
                    }
					
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest startAsynchronous];
                
                [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
                [ProgressBar getProgressBar].mDelegate = self;

                }
            } else if (publishType == kOpinionFeedBack) {/////////////
                //　问题反馈
                NSMutableString *str = [[NSMutableString alloc] initWithCapacity:40];
                [str appendFormat:@"%@%@",OpinionTEXT,[[Info getInstance] cbVersion]];
                [str appendFormat:@"%@",[mMessage text]];
                mMessage.text = str;
                
                [mRequest clearDelegatesAndCancel];
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBqA:[[Info getInstance] userId] Content:str AttachType:0 Attach:@""]];
                [mRequest setUsername:@"opinion"];
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setTimeOutSeconds:20.0];
                [mRequest startAsynchronous];
                [[ProgressBar getProgressBar] show:@"正在发送..." view:self.mainView];
                [ProgressBar getProgressBar].mDelegate = self;
                [str release];
            }
        }
    } else if (publishType == kForwardTopicController || publishType == KShareController) {// 转发微博
        NSString *isComment = @"0";
        NSString *content = [mMessage text];
        if (![mStatus.orignal_id isEqualToString:@"0"]) {// 要转发的微博本身就是一条转发微博
            if (mNonceBtn.selected && mOrignalBtn.selected) {// 同时评论给本推作者和原推作者
                isComment = @"3";
            } else if (mOrignalBtn.selected) {
                isComment = @"2";
            } else if (mNonceBtn.selected) {
                isComment = @"1";
            }
        } else {
            if (mNonceBtn.selected) {
                isComment = @"1";
            }
        }
        if ([content length] == 0) {
            content = @"转发微博";
        }
        
        [mRequest clearDelegatesAndCancel];
		NSString *shareInfo =nil;
        if ([shareTo length]) {
                shareInfo = [NSString stringWithFormat:@"share0=%@",shareTo];
            }
            else {
                shareInfo = @"share0=0";
            }
		if (publishType == KShareController) {
            if ([shareTo length]) {
                if (weiBoContent.length) {
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
                }else{
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL sendTopicMessageToMqtopicId:mStatus.topicid ShareSource:shareTo Content:content orderID:lotteryID]];
                }
            }
            else {
                			self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL sendTopicMessageToMqtopicId:mStatus.topicid ShareSource:@"1" Content:content orderID:lotteryID]];
            }

		}
		else {
			self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:mStatus.topicid content:content attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:mStatus.orignal_id is_comment:isComment share:shareInfo shareorderId:lotteryID]];
		}
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        [[ProgressBar getProgressBar] show:@"正在转发微博..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
    }
}

- (void)FaBiaoDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSString * ss = [dict objectForKey:@"code"];
    if ([ss isEqualToString:@"0"]) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
    }
    
}
// 接收服务器返回JSON数据
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    NSLog(@"=======Result：%@", result);
    // 上传图片
    if ([request.username isEqualToString:@"upload"]) {
        
        if (!result) {
            return;
        }
        
        [mReqUpload clearDelegatesAndCancel];
        if (publishType == kNewTopicController || publishType == kEditTopicController) {
            NSString *content = [mMessage text];
            if (content == nil || [content length] == 0) {
                content = @"分享图片";
            }
			NSString *shareInfo =nil;
			if (share0) {
				shareInfo = @"share0=1";
               
                if (infoShare) {
                    shareInfo = [NSString stringWithFormat:@"share0=%@", self.shareTo];//self.shareTo;
                }
                if (Btn1.selected) {
                    shareInfo = @"share0=1";
                }
                else if (Btn2.selected) {
                    shareInfo = @"share0=3";
                }
                else if (Btn3.selected) {
                    shareInfo = @"share0=2";
                }
               
                
			}
			else {
				shareInfo = @"share0=0";
			}
        
       
            self.mReqUpload = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:content attachType:@"1" attach:result type:@"1" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
            [mReqUpload setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mReqUpload setDelegate:self];
            [mReqUpload setTimeOutSeconds:20.0];
            [mReqUpload startAsynchronous];
        } else if (publishType == kOpinionFeedBack) {
            //　问题反馈
            NSMutableString *str = [[NSMutableString alloc] initWithCapacity:40];
            [str appendFormat:@"%@%@",OpinionTEXT,[[Info getInstance] cbVersion]];
            [str appendFormat:@"%@",[mMessage text]];
            mMessage.text = str;
            
            self.mReqUpload = [ASIHTTPRequest requestWithURL:[NetURL CBqA:[[Info getInstance] userId] Content:str AttachType:1 Attach:result]];
            [mReqUpload setUsername:@"opinion"];
            [mReqUpload setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mReqUpload setDelegate:self];
            [mReqUpload setTimeOutSeconds:20.0];
            [mReqUpload startAsynchronous];
            [str release];
        }
        return;
    }
    
    // 评论
    NSDictionary *resultDict = [result JSONValue];
    if ([request.username isEqualToString:@"comment"]) {
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"评论成功!"];
        } else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
            [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
        }else {

            if ([[resultDict objectForKey:@"errorMsg"] length]) {
                [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
            }
            else {
                [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
            }
        }
    } else if ([request.username isEqualToString:@"opinion"]) {
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"问题反馈成功!"];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"问题反馈失败,请重试!"];
        }
    } else {// 发布和转发
		if (publishType == KShareController) {
            if ([weiBoContent length]) {
                if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
                    [[ProgressBar getProgressBar] setTitle:@"发布成功!"];
                }else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
                    [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
                }else  {
                    if ([[resultDict objectForKey:@"errorMsg"] length]) {
                       [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
                    }
                    else {
                        [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
                    }
                    
                }
            }else{
                if([[resultDict objectForKey:@"code"] intValue] == 1){
                    [[ProgressBar getProgressBar] setTitle:@"微博分享成功!"];
                    
                }else  {
                    [[ProgressBar getProgressBar] setTitle:@"微博分享失败!"];
                }
            }
		}
        else  if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"发布成功!"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:nil];
            [[Info getInstance] setIsNeedRefreshHome:YES];
            // 删除草稿
            if (publishType == kEditTopicController && mDraft) {
                [Draft deleteDraft:mDraft.mDate];
            }
        }else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
            [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
           
            
        }else  {
            if ([[resultDict objectForKey:@"errorMsg"] length]) {
                [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
            }
            else {
                [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
            }
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:0.8
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) onTimer : (id) sender {
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    [[ProgressBar getProgressBar] dismiss];
    [self dismissSelf:YES];
//    if (three) {
//        SachetViewController * sac = [[SachetViewController alloc] init];
//        [self.navigationController pushViewController:sac animated:YES];
//        [sac release];
//    }
}

- (void) requestFailed:(ASIHTTPRequest *)request {
    NSString * st = [request responseString];
      NSDictionary * dict = [st JSONValue];
    if ([dict objectForKey:@"security_code"]) {
        if ([[dict objectForKey:@"security_code"] intValue] != 1) {
             [[ProgressBar getProgressBar] dismiss];
            return;
        }
    }
    [[ProgressBar getProgressBar] setTitle:@"请检查您的网络,重新请求"];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)SinaFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
        Btn1.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
//        if (0 && [WeiboSDK isWeiboAppInstalled]) {
//            [WeiboSDK enableDebugMode:YES];
//            [WeiboSDK registerApp:kSinaAppKey];
//            WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//            request.redirectURI = kSinaRedirectURI;
//            request.scope = @"all";
//            [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:self,@"delegate", nil]];
//            [WeiboSDK sendRequest:request];
//        }
//        else {
            SinaBindViewController *sina = [[SinaBindViewController alloc] init];
            sina.sinaURL =[NetURL CBBangDing:@"1"];
            NSLog(@"%@",sina.sinaURL);
            sina.title = @"新浪绑定";
            sina.isBangDing = YES;
            sina.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:sina animated:YES];
            [sina release];
//        }
    }
}

- (void)qqZoneFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
        Btn2.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
            SinaBindViewController *sina = [[SinaBindViewController alloc] init];
            sina.sinaURL =[NetURL CBBangDing:@"3"];
            NSLog(@"%@",sina.sinaURL);
            sina.title = @"QQ空间绑定";
            sina.isBangDing = YES;
            sina.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:sina animated:YES];
            [sina release];
        
    }
}

- (void)qqFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
        Btn3.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"2"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"腾讯微博绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
    }
}



// 操作表对话框实现方法：
#pragma mark ActionSheet Delegate Methods
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {// 返回上一个界面：响应是否保存输入信息
        if (buttonIndex == actionSheet.firstOtherButtonIndex) {
            if (three) {
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissSelf:YES];
            }
            
            // 保存微博消息
            //[self doSaveDraft:YES];
        } else if(buttonIndex == actionSheet.cancelButtonIndex) {
		
        }
		else {
			// 不保存消息
           // [self dismissSelf:YES];
		}

	} else if (actionSheet.tag == 2) { // 拍照相关
        if (mTakeFace.tag == 0) {
            mIndex = mMessage.selectedRange;// 记录当前的输入位置
        }
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            
        } else if (buttonIndex == 0) {
			//拍照
			if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.delegate = self;
				picker.videoQuality = UIImagePickerControllerQualityTypeLow;
				picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
				picker.sourceType = UIImagePickerControllerSourceTypeCamera;
				[self presentViewController:picker animated: YES completion:nil];
//                [self.navigationController pushViewController:picker animated:YES];
				[picker release];
			} else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                                message:NSLocalizedString(@"have no camera",nil)
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
			}
		} else if (buttonIndex == 1) {
			//选择已存的照片
			if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.delegate = self;
				picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
				picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
				[self presentViewController:picker animated: YES completion:nil];
//                [self.navigationController pushViewController:picker animated:YES];
				[picker release];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                                message:NSLocalizedString(@"have no camera",nil)
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];   
                [alert release];
			}
		} else if (buttonIndex == 2) {// 删除照片
            [self deleteImage];
        }
	} else if (actionSheet.tag == 3) {
        if (buttonIndex == actionSheet.firstOtherButtonIndex) {
            // 放弃
            [self dismissSelf:YES];
        }
    } else if (actionSheet.tag == 4) {
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            [mMessage setText:@""];
            [self changeTextCount:[mMessage text]];
        }
    }
}

// 关闭该界面
- (void)dismissSelf:(BOOL)animated {
    
    if (three) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        NSLog(@"myyuce = %@", myyuce);
        
        NSArray * comarr = [myyuce componentsSeparatedByString:@" "];
        if ([comarr count] == 3) {
            TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:[comarr objectAtIndex:0]];
            topicThemeListVC.cpsanliu = CpSanLiuWuyes;
            topicThemeListVC.jinnang = YES;
            [self.navigationController pushViewController:topicThemeListVC animated:YES];
            [topicThemeListVC release];
        }else{
            TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:myyuce];
            topicThemeListVC.cpsanliu = CpSanLiuWuyes;
            topicThemeListVC.jinnang = YES;
            [self.navigationController pushViewController:topicThemeListVC animated:YES];
            [topicThemeListVC release];
        }
        
        
    
    }else{
#ifdef isCaiPiaoForIPad
        
        [self goBackToforiPad];
#else
        
//        [self dismissViewControllerAnimated: animated completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
#endif
        
    }
    

}

// 横竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (int)countWord:(NSString*)s {
    int i, n = (int)[s length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i = 0; i < n; i++) {
        c = [s characterAtIndex:i];
        if(isblank(c)) {
            b++;
        } else if(isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    
    if(a == 0 && l == 0) return 0;
    
    return l + (int)ceilf((float)(a + b) / 2.0);
}

// 输入框将要开始编辑，键盘打开
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self dismissFaceSystem];
    
//    if (mMessage.text = @"说点儿什么吧......") {
//        [mTextCount setEnabled:NO];
//    }
    // 输入字数为0时，发送按钮和保存按钮为未激活状态
    
   
    if([textView.text length] == 0 && !mSelectImage) {
        mPostBtn.enabled = false;
        canPublice = NO;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        
        [mTextCount setEnabled:NO];
        [[mTextCount imageView] setHidden:YES];
    }
    if (mSelectImage) {
        mSaveDraft.enabled = true;
    }
    // 开始输入文字时，检测“功能列表”中的添加添加表情状态
    if(mTakeFace.tag == 1) {
        mTakeFace.tag = 0;
        [mTakeFace setImage:UIImageGetImageFromName(@"kbd_takeFace.png") forState:(UIControlStateNormal)];
    }
    if (publishType == kForwardTopicController || publishType == KShareController) {
        mPostBtn.enabled = YES;
        canPublice = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
    }
    
        
    textView.selectedRange = mIndex;
    
    return YES;
}

// 监听用户输入；改变字数限制提示
- (void)textViewDidChange:(UITextView *)textView {
    
    [self changeTextCount:[textView text]];
    [yszLabel removeFromSuperview];
}

- (void) changeTextCount : (NSString *) text {
    int textCount = 140 - [self countWord:text];
    if (textCount < 0) {
        [mTextCount setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    } else {
        [mTextCount setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", textCount] forState:(UIControlStateNormal)];
    if([mMessage.text length] == 0 && !mSelectImage) {
        mSaveDraft.enabled = false;
        if (publishType == kForwardTopicController) {
            mPostBtn.enabled = true;
            canPublice = YES;
            UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
            telabel.textColor = [UIColor whiteColor];
            
        }else{
        mPostBtn.enabled = false;
            canPublice = NO;
            UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
            telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        }
        
        [mTextCount setEnabled:NO];
        [[mTextCount imageView] setHidden:YES];
    } else {
        mSaveDraft.enabled = true;
        mPostBtn.enabled = true;
         [yszLabel removeFromSuperview];
        canPublice = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
        [mTextCount setEnabled:YES];
        [[mTextCount imageView] setHidden:NO];
    }
    
    if (mIndex.location >[mMessage.text length]) {
		mIndex.location = [mMessage.text length];
	}
}

#pragma mark 保存草稿
- (IBAction)actionSave:(UIButton *)sender {
    [self doSaveDraft:NO];
}

// 保存到数据库
- (void) doSaveDraft:(BOOL)exit {
    [[ProgressBar getProgressBar] show:@"保存数据中..." view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
    
    NSData *imageData = nil;
    if (mSelectImage) {
        imageData = UIImageJPEGRepresentation(mSelectImage, 1.0);
    }
    NSString *text = mMessage.text;
    if ((!text || [text length] == 0) && mSelectImage) {
        text = @"分享图片";
    }
    if(publishType != kEditTopicController) {
        [Draft insertDraft:text ImageData:imageData];
    } else {
        // 对于从草稿箱到此界面的数据进行替换保存
        [Draft replaceDraft:text ImageData:imageData Date:mDraft.mDate];
    }
    NSString *info = @"no";
    if (exit) {
        info = @"yes";
    }
    [NSTimer scheduledTimerWithTimeInterval:0.8
                                     target:self
                                   selector:@selector(disMissDialog:)
                                   userInfo:info
                                    repeats:NO];
}

- (void) disMissDialog : (id) sender {
    if ([mMessage.text length] != 0 &&[[(NSTimer *)sender userInfo] isEqualToString:@"yes"]) {
        [mMessage setText:@""];
        [self changeTextCount:@""];
    }
    
    [self deleteImage];
    
    [mSaveDraft setEnabled: false];
    [mPostBtn setEnabled: false];
    canPublice = NO;
    UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
    telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [[ProgressBar getProgressBar] dismiss];
    
    // 是否退出该界面
    if ([[(NSTimer *)sender userInfo] isEqualToString:@"yes"]) {
        [self dismissSelf:YES];
    }
}

// 删除图片
- (void) deleteImage {
    if (mShowPhoto) {
        mShowPhoto.hidden = YES;
        [self updateUI];
    }
    
    if (mSelectImage) {
        self.mSelectImage = nil;
    }
    
    if ([mMessage.text length] == 0 && !mSelectImage) {
        mSaveDraft.enabled = NO;
    }
}


#pragma mark 拍照
- (IBAction)actionPhoto:(UIButton *)sender {
        
    UIImageView * imagev = (UIImageView *)[pzButton viewWithTag:333];
    imagev.image = UIImageGetImageFromName(@"wb888.png");
    [mMessage resignFirstResponder];

    //分享按钮图片切换
    if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
        UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
        iamgevi.image = UIImageGetImageFromName(@"wb777.png");
    }
    else{
        
        UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
        iamgevi.image = UIImageGetImageFromName(@"wb10.png");
        
    }
    //[pzButton setImage:UIImageGetImageFromName(@"wb888.png") forState:UIControlStateNormal];
        
    
	shareView.hidden =YES;
    baimageview.hidden = YES;
   
    if ([mMessage.text length] == 0 && !mSelectImage) {
        mPostBtn.enabled = NO;
        canPublice = NO;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    }
    
    if (potimage.image == nil) {
         potimage.image = nil;
        potButton1.hidden = NO;
        potButton2.hidden = NO;
        potButton3.hidden = potButton1.hidden;
        potButton4.hidden = potButton1.hidden;
        delButton.hidden = YES;
         potimage.hidden = YES;
    }else{
       
        potButton1.hidden = YES;
        potButton2.hidden = YES;
        potButton3.hidden = potButton1.hidden;
        potButton4.hidden = potButton1.hidden;
        delButton.hidden = NO;
        potimage.hidden = NO;
    }
    
    
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    
   
    
    
    //[mMessage becomeFirstResponder];
}

// 显示添加图片后的图片按钮
- (void) showPictureBtn {
    if (mShowPhoto.hidden) {
        mShowPhoto.hidden = NO;
        [self updateUI];
    }
    mShowPhoto.frame = CGRectMake(mShowPhoto.frame.origin.x, self.mainView.frame.size.height - 200, mShowPhoto.frame.size.width, mShowPhoto.frame.size.height);
    if (mSelectImage) {
        [mSaveDraft setEnabled: YES];
        [mPostBtn setEnabled: YES];
        canPublice = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
        [mShowPhoto setImage:mSelectImage forState:(UIControlStateNormal)];
    }
}

// 接收图片
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated: YES completion: nil];
    NSLog(@"info = %@",info);


    
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mediaType isEqualToString:@"public.image"]) {
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		if (image) {
			if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
				NSLog(@"111111");
			} else {
				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
                NSLog(@"222222");
			}
			
//            float width  = image.size.width;
//            float height = image.size.height;
//            float scale;
//            
//            if (width > height) {
//                scale = 640.0 / width;
//            } else {
//                scale = 480.0 / height;
//            }
            NSData *data = nil;
            data = UIImageJPEGRepresentation(image,1.0);
//            NSLog(@"bbb = %d", [data length]);
//            if (scale >= 1.0) {
//				data = UIImageJPEGRepresentation(image,1.0);
//            } else if (scale < 1.0) {
//				data = UIImageJPEGRepresentation([image scaleAndRotateImage:640],1.0);
//            }
//            NSUInteger c = 
//            long c = [data length];
//            NSLog(@"aaa = %ld , %f",c , GIFDATALength*2.2);
			if ([data length] > 3646056) {//GIFDATALength*2.3
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"图片大于2MB，会耗费较多流量，是否继续？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
                alert.tag = 1112;
				[alert show];
				[alert release];
				
			}
            
			[self setMSelectImage:image];
			//[self showPictureBtn];
            potimage.image = image;
            
            if (potimage.image) {
                mPostBtn.enabled = YES;
                canPublice = YES;
                UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
                telabel.textColor = [UIColor whiteColor];
            }else{
                mPostBtn.enabled = NO;
             canPublice = NO;
                UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
                telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
            }

            
            
            potimage.hidden = NO;
            potButton1.hidden = YES;
            potButton2.hidden = YES;
            potButton3.hidden = potButton1.hidden;
            potButton4.hidden = potButton1.hidden;
            delButton.hidden = NO;
            baimageview.hidden = YES;
            shareView.hidden =YES;
            
            scrollView.hidden = YES;
            pageControl.hidden = YES;
//            potButton1.hidden = NO;
//            potButton2.hidden = NO;
            [mMessage resignFirstResponder];
            
		} else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                            message:@"无法读取图片，请重试"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
		}
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1112) {
        if (buttonIndex == 1) {
            potimage.image = nil;
            if ([mMessage.text length] == 0 && !mSelectImage) {
                mPostBtn.enabled = NO;
                canPublice = NO;
                UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
                telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
            }
            potimage.hidden = YES;
            potButton1.hidden = NO;
            potButton2.hidden = NO;
            potButton3.hidden = potButton1.hidden;
            potButton4.hidden = potButton1.hidden;
            delButton.hidden = YES;
            baimageview.hidden = YES;
            shareView.hidden =YES;
            
            scrollView.hidden = YES;
            pageControl.hidden = YES;

        }else{
            NSLog(@"bb");
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
   
    [picker dismissViewControllerAnimated: YES completion:nil];
}

//- (void)pressbuttonimage:(UIButton *)sender{
//    UIImage *image = [sender imageForState:(UIControlStateNormal)];
//    if (image) {
//        NSMutableArray *photos = [[NSMutableArray alloc] init];
//        [photos addObject:[MWPhoto photoWithImage: image]];
//        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
//        [photoBrowser setController: self];
//        [photoBrowser setPhotoType : kTypeWithUIImage];
//        [photos release];
//        
//        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
//        navController.navigationBarHidden = NO;
//        [photoBrowser release];
//        if (navController) {
//            [self presentViewController:navController animated: YES completion:nil];
//        }
//        [navController release];
//    }
//
//}

#pragma mark 显示图片
- (IBAction)actionShowPhoto:(UIButton *)sender {
    UIImage *image = [sender imageForState:(UIControlStateNormal)];
    if (image) {
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        [photos addObject:[MWPhoto photoWithImage: image]];
        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        [photoBrowser setController: self];
        [photoBrowser setPhotoType : kTypeWithUIImage];
        [photos release];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] >= 6) {
#ifdef isCaiPiaoForIPad
            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [navController.navigationBar setBackgroundImage:[UIImageGetImageFromName(@"SDH960.png") stretchableImageWithLeftCapWidth:7 topCapHeight:20] forBarMetrics:UIBarMetricsDefault];
            
#endif
//            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        }

        navController.navigationBarHidden = NO;
        if (navController) {
            [self presentViewController:navController animated: YES completion:nil];
        }
        [navController release];
//        [self.navigationController pushViewController:photoBrowser animated:YES];
        [photoBrowser release];
    }
}

#pragma mark 插入话题  @常用联系人
- (IBAction)actionTopicOrLinkMan:(UIButton *)sender {
    //分享按钮图片切换
    if (publishType == KShareController) {
		[[caiboAppDelegate getAppDelegate] showjianpanMessage:@"稍后上线" view:tempWindow];
        return;
        
	}
        
        if (publishType != kCommentTopicController && publishType != kForwardTopicController && publishType != kCommentRevert) {
            if (!fxButton) {
                
            }
            else {
                if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
                    UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                    iamgevi.image = UIImageGetImageFromName(@"wb777.png");
                }
                else{
                    
                    UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                    iamgevi.image = UIImageGetImageFromName(@"wb10.png");
                    
                }
            }
            if (potimage.image == nil) {
                
                UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
                iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
                
                
            }
            else{
                
                UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
                iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
                
                
            }

        }
                if (faceButton.tag == 0) {
            if (mMessage.selectedRange.location == NSNotFound) {
                mMessage.selectedRange = NSMakeRange([mMessage.text length], 0);
            }
            // else {
            mIndex = mMessage.selectedRange;
            //}
            
        }


    
   

    //
//    potimage.hidden = YES;
       
#ifdef isCaiPiaoForIPad
    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
    if (sender.tag == 0) {
        followeesController.contentType = kAddTopicController;
        
        
    } else if (sender.tag == 1) {
        followeesController.contentType = kLinkManController;
        followeesController.yaoqin = YES;
        
    }
	followeesController.mController = self;
	[self.navigationController pushViewController:followeesController animated:NO];
    
    [followeesController release];
#else
    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
    if (sender.tag == 0) {
        followeesController.contentType = kAddTopicController;
        
        
    } else if (sender.tag == 1) {
        followeesController.contentType = kLinkManController;
        
    }
//	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:followeesController];
//    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//    NSString * diyistr = [devicestr substringToIndex:1];
//    if ([diyistr intValue] == 6) {
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
//    }
//    
//	if (navController) {
//        followeesController.mController = self;
//		[self presentViewController:navController animated: YES completion:nil];
//	}
//	[navController release];
    followeesController.mController = self;
    [self.navigationController pushViewController:followeesController animated:YES];
	[followeesController release];
#endif
	
    
   
}

// 常用联系人和插入话题回调函数
- (void)friendsViewDidSelectFriend:(NSString *)name {
#ifdef isCaiPiaoForIPad

   

    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", ([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    yszLabel.hidden = YES;
    [textBuffer release];

    [self.navigationController popToRootViewControllerAnimated:YES];
#else
    
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    NSLog(@"message = %@, location = %lu", mMessage.text, (unsigned long)mIndex.location);
    [textBuffer appendString:[mMessage.text substringToIndex:mIndex.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    yszLabel.hidden = YES;
    [textBuffer release];

#endif
    
}

#pragma mark 添加表情
- (IBAction)actionFace:(UIButton *)sender {
	shareView.hidden =YES;
    potButton1.hidden = YES;
    potButton2.hidden = YES;
    potButton3.hidden = potButton1.hidden;
    potButton4.hidden = potButton1.hidden;
    baimageview.hidden = NO;
    delButton.hidden = YES;
    
    
    scrollView.hidden = NO;
    pageControl.hidden = NO;
    [pageControl setNumberOfPages:3];
    [pageControl setHidesForSinglePage:NO];
    NSLog(@"11111111111111111111111111111111111111");
    //分享按钮图片切换
    if (publishType != kForwardTopicController && publishType != kCommentTopicController && publishType != kCommentRevert) {
        if (!fxButton) {
            
        }
        else {
            if (Btn1.selected == YES || Btn2.selected == YES || Btn3.selected == YES) {
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb777.png");
            }
            else{
                
                UIImageView *iamgevi = (UIImageView *)[fxButton viewWithTag:111];
                iamgevi.image = UIImageGetImageFromName(@"wb10.png");
                
            }
        }
        potimage.hidden = YES;
        //拍照图片切换
        if (potimage.image == nil) {
            
            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            iamgevi2.image = UIImageGetImageFromName(@"wb8.png");
            
            
        }
        else{
            
            UIImageView *iamgevi2 = (UIImageView *)[pzButton viewWithTag:333];
            iamgevi2.image = UIImageGetImageFromName(@"wb888.png");
            
            
        }

    }
       
    if(sender.tag == 0){
        [self showFaceSystem];
        [sender setTag:1];
        [mTakeFace setImage:UIImageGetImageFromName(@"keyboard.png") forState:(UIControlStateNormal)];
    } else {
        [self dismissFaceSystem];
        [mMessage becomeFirstResponder];
        [sender setTag:0];
        [mTakeFace setImage:UIImageGetImageFromName(@"kbd_takeFace.png") forState:(UIControlStateNormal)];
    }
}

- (IBAction) actionCleanText:(id)sender {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:nil
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:@"清除文字"
//                                  otherButtonTitles:nil,nil];
//    actionSheet.tag = 4;
//    [actionSheet showInView:self.mainView];
//    [actionSheet release];
    [mMessage resignFirstResponder];
    CP_LieBiaoView *lb3 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lb3.delegate = self;
    lb3.tag = 103;
    [lb3 LoadButtonName:[NSArray arrayWithObjects:@"清除文字",nil]];
    [lb3 show];
    [lb3 release];

}

/**
 *载入表情系统视图
 */
- (void)loadFaceSystemViewWithPage:(int)page {
    if (page < 0) return;
    if (page > 2) return;
#ifdef isCaiPiaoForIPad
    
    // 从内存中获取已加载过的视图，不重新构建
    FaceSystem *faceSystem = [viewControllers objectAtIndex:page];
    if ((NSNull *)faceSystem == [NSNull null]) {
        faceSystem = [[FaceSystem alloc] initWithPageNumber:page row:4 col:8];
        [faceSystem setController:self];
        [viewControllers replaceObjectAtIndex:page withObject:faceSystem];
        [faceSystem release];
    }
    
    if (nil == faceSystem.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        faceSystem.frame = frame;
        [scrollView addSubview:faceSystem];
    }

#else
    
    // 从内存中获取已加载过的视图，不重新构建
    FaceSystem *faceSystem = [viewControllers objectAtIndex:page];
    if ((NSNull *)faceSystem == [NSNull null]) {
        faceSystem = [[FaceSystem alloc] initWithPageNumber:page row:4 col:8];
        [faceSystem setController:self];
        [viewControllers replaceObjectAtIndex:page withObject:faceSystem];
        [faceSystem release];
    }
    
    if (nil == faceSystem.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        faceSystem.frame = frame;
        [scrollView addSubview:faceSystem];
    }

#endif
    
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    [self loadFaceSystemViewWithPage:page - 1];
    [self loadFaceSystemViewWithPage:page];
    [self loadFaceSystemViewWithPage:page + 1];
}

- (void) showFaceSystem {
#ifdef isCaiPiaoForIPad

    
    scrollView.hidden = NO;
    pageControl.hidden = NO;
    

    
    if (faceButton.tag == 0) {
        mIndex = mMessage.selectedRange;// 弹出表情时，记录当前的输入位置
    }
    
    [mMessage resignFirstResponder];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [scrollView setCenter:CGPointMake(270, 400)];
    //[scrollView setCenter:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)];
    [UIView commitAnimations];
    
    [self loadFaceSystemViewWithPage:0];

#else
    
    if (faceButton.tag == 0) {
        mIndex = mMessage.selectedRange;// 弹出表情时，记录当前的输入位置
    }
    
    [mMessage resignFirstResponder];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        if (IS_IPHONE_5) {
#ifdef isHaoLeCai
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 105)];
            pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 10, 320, 36);
#else
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 125)];
#endif

        }else{
#ifdef isHaoLeCai
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 95)];
            pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 10, 320, 36);
#else
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 115)];
            pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 30, 320, 36);
#endif
        }
        
    }else{
        
        if (IS_IPHONE_5) {
          
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 95)];
            pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height -10, 320, 36);
            
        }else{
            [scrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 95)];
            pageControl.frame = CGRectMake(0, self.mainView.bounds.size.height -5, 320, 36);
        }
    }
    
    [UIView commitAnimations];
    
    [self loadFaceSystemViewWithPage:0];

#endif    
}

- (void) dismissFaceSystem {
    if (nil == scrollView) {
        return;
    }
//    [mMessage becomeFirstResponder];
	//[mMessage setSelectedRange:<#(NSRange)#>]
    
#ifdef  isCaiPiaoForIPad
    
    scrollView.hidden = YES;
    pageControl.hidden = YES;
    
#endif
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
#ifdef isCaiPiaoForIPad
    [scrollView setCenter:CGPointMake(200, 800)];
#else
    [scrollView setCenter:CGPointMake(160, 567)];
#endif
    
    [UIView commitAnimations];
}

// 点击表情
- (void) clickFace:(NSString *)faceName {
	if (mIndex.location >[mMessage.text length]) {
		mIndex.location = [mMessage.text length];
	}
    NSMutableString *finalText = [[NSMutableString alloc] init];
    [finalText appendString:[mMessage.text substringToIndex:mIndex.location]];
    [finalText appendString:faceName];
    [finalText appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [faceName length];// 保存输入框光标位置
    
    [mMessage setText:finalText];
    [finalText release];
    
    [self textViewDidChange:mMessage];
    
    if (mSaveDraft.enabled == NO) {
        mSaveDraft.enabled = YES;
    }
    if (mPostBtn.enabled == NO) {
        mPostBtn.enabled = YES;
        canPublice = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
    }
}

- (IBAction)changePage:(id)sender {
    int page = (int)pageControl.currentPage;
    
    //[self loadFaceSystemViewWithPage:page - 1];
    [self loadFaceSystemViewWithPage:page];
    //[self loadFaceSystemViewWithPage:page + 1];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)dealloc {
//    [baimageview release];
//    [potimage release];
//    [cpthImage release];
    [lotteryID release];
    self.shareTo = nil;
    [newpostnavbar release];
    [yrbIndicatorView release];
    self.orderID= nil;
    self.lottery_id = nil;
    self.play = nil;
    [tipsView release];
    [mReqData clearDelegatesAndCancel];
    self.mReqData = nil;
    
    [mRequest clearDelegatesAndCancel];
    self.mRequest = nil;
    
    [mReqUpload clearDelegatesAndCancel];
    self.mReqUpload = nil;
    
    [mDraft release];
    [mStatus release];
    [viewControllers release];
    
    [mShowPhoto release];
    [mSelectImage release];
    
    [mTitle release];
    [mBackBtn release];
    [mPostBtn release];
    [mMessage release];
    [mTextCount release];
    [mFunctionController release];
    [mSaveDraft release];
    [mTakeLocation release];
    [mTakePhoto release];
    [mTakeTopic release];
    [mTakeLinkMan release];
    [mTakeFace release];
    [scrollView release];
    [pageControl release];
    [super dealloc];
}

- (void) updateUI {
//    int count = 0;
//    for (UIView *child in [mFunctionController subviews]) {
//        if (!child.hidden) {
//            count++;
//        }
//    }
//    int mGap = (mFunctionController.frame.size.width - count * mTakeFace.frame.size.width) / count;
//    [self layoutHorizontalContainer:mFunctionController gap:mGap];
}

- (void) layoutHorizontalContainer:(UIView *)parent gap:(int)gap {
    CGFloat left = parent.bounds.origin.x + 6;
    CGFloat top = parent.bounds.origin.y;
    CGFloat right = parent.bounds.size.width;
    CGFloat bottom = parent.bounds.size.height;
    
    NSArray *childArray = [parent subviews];
    
    for(UIView *child in childArray) {
        
        if (child.hidden == YES) {
//            child.frame = CGRectMake(left, top, 0, 0);
            continue;
        }
        
        // 父容器已经没有空间分配给子控件
        if (right - left <= 0) {
            child.frame = CGRectMake(left, top, 0, 0);
            continue;
        };
        
        int pw = child.frame.size.width;
        int ph = child.frame.size.height;
        
        top = (bottom - ph) / 2;
        
        child.frame = CGRectMake(left, top, pw, ph);
        
        left += (pw + gap);
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
	
    self.yrbIndicatorView = nil;
    self.tipsView = nil;
    self.mTitle = nil;
    self.mBackBtn = nil;
    self.mPostBtn = nil;
    self.mMessage = nil;
    self.mTextCount = nil;
    self.mFunctionController = nil;
    self.mSaveDraft = nil;
    self.mTakeLocation = nil;
    self.mTakePhoto = nil;
    self.mTakeTopic = nil;
    self.mTakeLinkMan = nil;
    self.mTakeFace = nil;
    self.mShowPhoto = nil;
    self.scrollView = nil;
    self.pageControl = nil;
    
    [super viewDidUnload];
}

- (void)prograssBarBtnDeleate:(NSInteger) type;
{
    [mReqData clearDelegatesAndCancel];
    
    [mRequest clearDelegatesAndCancel];
    
    [mReqUpload clearDelegatesAndCancel];
    
    [[ProgressBar getProgressBar] dismiss];
    
}

#pragma mark WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}

-(void)swipeMessage
{
    [mMessage resignFirstResponder];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
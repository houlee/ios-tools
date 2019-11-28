//
//  DetailedViewController.m
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "DetailedViewController.h"
#import "NewPostViewController.h"
#import "RegexKitLite.h"
#import "NetURL.h"
#import "JSON.h"
#import "ProgressBar.h"
#import "DataBase.h"
#import "User.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "UIDeviceHardware.h"
#import "ReportViewController.h"
#import "CommentViewController.h"

#import "TopicComment.h"
#import "CommentCell.h"
#import "ProfileViewController.h"
#import "SinaBindViewController.h"
#import "UserInfo.h"
#import "Info.h"
#import "LoginViewController.h"
#import "PreJiaoDianTabBarController.h"
#import "CP_LieBiaoView.h"
#import "MobClick.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MyWebViewController.h"
#import "NSStringExtra.h"
#import "SendMicroblogViewController.h"

@implementation DetailedViewController

@synthesize mRequest, mStatus,dTableView,mCommentArray,mDetailedView;
@synthesize mCollectBtn,isDeleted;
@synthesize delegate;
@synthesize homebool;
@synthesize amRequest;
@synthesize isFromFlashAd;
@synthesize autoRequest;
@synthesize isAutoQuestion;



static DetailedViewController *instance;

-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef  isCaiPiaoForIPad
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
#else
    return NO;
#endif
}

+ (UIViewController *) getShareController {
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        return VC.selectedViewController;
    }
    //    else {
    //        [NV pushViewController:controller animated:YES];
    //    }
    return NV;
}

+ (DetailedViewController *) getShareDetailedView {
    return instance;
}

- (void)zhengwenyttopic:(YtTopic *)stat{
    NSLog(@"stat = %@", stat.nick_name);
   // [[NSUserDefaults standardUserDefaults] valueForKey:@"zhengwenuser"];
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:stat];
    if (homebool) {
        detailed.homebool = YES;
    }else{
        detailed.homebool = NO;
    }
    
    [detailed setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:detailed animated:YES];
    
    [detailed release];

}

- (void)weibozhengwenhanshu:(YtTopic *)yttopic{
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:yttopic];
    
    [detailed setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:detailed animated:YES];
    
    [detailed release];

}


- (void)returnshifouguanzhu:(NSString *)guanzhu row:(NSInteger)inrow{
    if ([delegate respondsToSelector:@selector(returnshifouguanzhu:row:)]) {
        [delegate returnshifouguanzhu:guanzhu row:inrow];
        // NSLog(@"index = %d", index);
    }
}

- (void)presszhuce:(UIButton *)sender{
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginButtonHidden) name:@"loginButton" object:nil];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
	[loginVC setHidesBottomBarWhenPushed:YES];
	[loginVC setIsShowDefultAccount:YES];
	[self.navigationController pushViewController:loginVC animated:YES];
	[loginVC release];
#endif
}

- (void)loadingIphone{
    self.CP_navigation.title = @"微博正文";
    
    yuantie=NO;
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(actionBack:)];
    
    
//    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
////    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb61.png");
//    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
////    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
//    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
//    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
//    self.CP_navigation.rightBarButtonItem = rigthItemButton;
//    [rigthItemButton release];
    
    
//    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(doPushHomeView) ImageName:nil Size:CGSizeMake(70,30)];
    
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor whiteColor];
    //dTableView.backgroundView = backImage;
	[self.mainView addSubview:backImage];
    [backImage release];
    
//    imagedown.image = UIImageGetImageFromName(@"wb19.png");//底部评论等按钮背景图片
    imagedown.backgroundColor=[UIColor blackColor];
    
	mUserView = [[UserCellView alloc] initWithUserInfo:mStatus homebool:homebool];
	mUserView.ishome = homebool;
    
    UIImageView *lineIma=[[UIImageView alloc]init];
    lineIma.frame=CGRectMake(10, mUserView.frame.size.height-1, mUserView.frame.size.width, 1);
    lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
    [mUserView addSubview:lineIma];
    [lineIma release];
    UIImageView *jiantouIma=[[UIImageView alloc]init];
    jiantouIma.frame=CGRectMake(mUserView.frame.size.width-35, 25, 8, 13);
    jiantouIma.image=[UIImage imageNamed:@"jiantou.png"];
    [mUserView addSubview:jiantouIma];
    [jiantouIma release];
    
    UILabel *lab=[[UILabel alloc]init];
    lab.frame=CGRectMake(67, 35, 100, 20);
    lab.backgroundColor=[UIColor clearColor];
    lab.text=mStatus.timeformate;
    lab.textColor=[UIColor grayColor];
    lab.font=[UIFont systemFontOfSize:9];
    [mUserView addSubview:lab];
    [lab release];
    
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.frame = CGRectMake(0, 0, 0, 0);
	[imageView setImage: UIImageGetImageFromName(@"V.png")];
	imageView.backgroundColor = [UIColor clearColor];
	
	if ([mStatus.vip intValue] == 1) {
		imageView.frame = CGRectMake(42, 44, 14, 14);
	}
	else {
		imageView.frame = CGRectMake(0, 0, 0, 0);
	}
    self.mainView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:mUserView];
	[mUserView addSubview: imageView];
	[imageView release];
    
    
//    dTableView = [[UITableView alloc]initWithFrame:CGRectMake(4,48 + imageView.frame.size.height, 300, self.mainView.bounds.size.height - 48 - imageView.frame.size.height-60) style:UITableViewStylePlain];
//    dTableView = [[UITableView alloc]initWithFrame:CGRectMake(4,48 + imageView.frame.size.height+2, 300, self.mainView.bounds.size.height - 48 - imageView.frame.size.height-60) style:UITableViewStylePlain];
    dTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, mUserView.frame.size.height, 320, self.mainView.bounds.size.height - mUserView.frame.size.height - 50) style:UITableViewStylePlain];
    dTableView.showsHorizontalScrollIndicator = NO;
    dTableView.showsVerticalScrollIndicator = NO;
	[dTableView setDelegate:self];
	[dTableView setDataSource:self];
    
    dTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:dTableView];
	[dTableView release];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weibozhengwenhanshu:) name:@"zhengwenhanshu" object:nil];
    
    [self.mainView insertSubview:mScrollView atIndex:0];
    
    if (!addCollectionBtn) {
		addCollectionBtn = [[Info CollectBtnInit:self imageNamed:@"collect.png" action:@selector(actionAddCollection)] retain];
		[addCollectionBtn setFrame:CGRectMake(195, 365, 60, 45)];
	}
	if (!cancelCollectionBtn) {
		cancelCollectionBtn = [[Info CollectBtnInit:self imageNamed:@"collectCancel.png" action:@selector(actionCancelCollection)] retain];
		[cancelCollectionBtn setFrame:CGRectMake(195, 365, 60, 45)];
	}
    
    
    if (mStatus) {
        if([mStatus.isCc isEqualToString:@"1"])
        {
            [self changeCollectBtn:cancelCollectionBtn];
        }
        else
        {
            [self changeCollectBtn:addCollectionBtn];
        }
    }
    
    if (mRefreshView == nil) {
//		mRefreshView = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -410, 320, 480)];
//		[mRefreshView setDelegate:self];
//        mRefreshView.hidden = YES;
//		[self.mainView addSubview:mRefreshView];
        mRefreshView = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -dTableView.frame.size.height, 320, dTableView.frame.size.height)];
		[mRefreshView setDelegate:self];
        mRefreshView.backgroundColor=[UIColor clearColor];
		[dTableView addSubview:mRefreshView];
    }
    NSLog(@"aa = %@", mStatus.count_pl);
    
    count_plstr = [mStatus.count_pl intValue];
    self.dTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    DetailedView *tmpDetailedView = [[DetailedView alloc] initWithMessage:mStatus homebol:homebool];
    if (homebool) {
        tmpDetailedView.homebool = YES;
    }else{
        tmpDetailedView.homebool = NO;
    }
    
    self.mDetailedView = tmpDetailedView;
	self.mDetailedView.detaildelegate = self;
    [self.dTableView setTableHeaderView:self.mDetailedView];
    [tmpDetailedView release];
    
    loadCell = [[LoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoComment"];
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    
    moreCell = [[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreLoadCell"];
    if (mCommentArray) {
		[dTableView reloadData];
	}
	else if(actionIndex == ActionOne){
        [self showSegmentOneAction];
    }
    else {
        [self showSegmentTwoAction];
    }
//    UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
    UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 22, 22)];
    shouchangImage.tag = 101;
    if ([mStatus.isCc intValue] == 0) {
        mCollectBtn.tag = 0;
//        shouchangImage.image = UIImageGetImageFromName(@"wb31.png");
        shouchangImage.image = UIImageGetImageFromName(@"weibo_shoucang.png");
    }else if([mStatus.isCc intValue] == 1){
//        shouchangImage.image = UIImageGetImageFromName(@"SC960.png");
        shouchangImage.image = UIImageGetImageFromName(@"weibo_shoucang1.png");
        mCollectBtn.tag = 1;
    }
    
    [mCollectBtn addSubview:shouchangImage];
    [shouchangImage release];
    
    
    
    
    
    //判断是否登录注册
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(doPushHomeView) ImageName:nil Size:CGSizeMake(70,30)];
        zhuanfabtn.enabled = YES;
        //评论不可点
        if(isAutoQuestion){
            UILabel * label1 = (UILabel *)[self.view viewWithTag:10];
            label1.textColor = [UIColor grayColor];
            pinglunbtn.enabled = NO;
            
        }
        else{
            pinglunbtn.enabled = YES;

        }
        fenxiangbtn.enabled = YES;
        mCollectBtn.enabled = YES;
        gengduobtn.enabled = YES;
        
//        UIImageView *pinglunImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        UIImageView *pinglunImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 22, 22)];
        if(isAutoQuestion){
            pinglunImage.image = UIImageGetImageFromName(@"pinglun_no.png");

        }
        else{
            pinglunImage.image = UIImageGetImageFromName(@"weibo_pinglun.png");

        }
        [pinglunbtn addSubview:pinglunImage];
        [pinglunImage release];
        //[pinglunbtn setImage:UIImageGetImageFromName(@"wb27.png") forState:UIControlStateNormal];
//        UIImageView *zhuanfaImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        UIImageView *zhuanfaImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 22, 22)];
//        zhuanfaImage.image = UIImageGetImageFromName(@"wb29.png");
        zhuanfaImage.image = UIImageGetImageFromName(@"weibo_zhuanfa.png");
        [zhuanfabtn addSubview:zhuanfaImage];
        [zhuanfaImage release];
        //[zhuanfabtn setImage:UIImageGetImageFromName(@"wb29.png") forState:UIControlStateNormal];
//        UIImageView *fenxiangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        UIImageView *fenxiangImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 22, 22)];
//        fenxiangImage.image = UIImageGetImageFromName(@"wb35.png");
        fenxiangImage.image = UIImageGetImageFromName(@"weibo_share.png");
        [fenxiangbtn addSubview:fenxiangImage];
        [fenxiangImage release];
        //[fenxiangbtn setImage:UIImageGetImageFromName(@"wb35.png") forState:UIControlStateNormal];
        //        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 5, 18, 18)];
        //        shouchangImage.image = UIImageGetImageFromName(@"wb31.png");
        //        [mCollectBtn addSubview:shouchangImage];
        //        [shouchangImage release];
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateNormal];
//        UIImageView *gengduoImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        UIImageView *gengduoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 22, 4)];
//        gengduoImage.image = UIImageGetImageFromName(@"wb33.png");
        gengduoImage.image = UIImageGetImageFromName(@"weibo_more.png");
        [gengduobtn addSubview:gengduoImage];
        [gengduoImage release];
        //[gengduobtn setImage:UIImageGetImageFromName(@"wb33.png") forState:UIControlStateNormal];
        
        
        
        
    }else{
        
        
        
        //        zhuanfabtn.enabled = NO;
        //        pinglunbtn.enabled = NO;
        //        fenxiangbtn.enabled = NO;
        //        mCollectBtn.enabled = NO;
        //        gengduobtn.enabled = NO;
        
//        zhucebutton = [[CP_PTButton alloc] initWithFrame:CGRectMake(230, 10, 80, 30)];
//        [zhucebutton loadButonImage:@"TYD960.png" LabelName:@"登录注册"];
//        zhucebutton.buttonImage.image = [zhucebutton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        [zhucebutton addTarget:self action:@selector(presszhuce:) forControlEvents:UIControlEventTouchUpInside];
//        zhucebutton.backgroundColor = [UIColor clearColor];
//        [self.mainView addSubview:zhucebutton];
        
        
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(presszhuce:) ImageName:nil Size:CGSizeMake(80,30)];
        
        UIImageView *pinglunImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        pinglunImage.image = UIImageGetImageFromName(@"wb28.png");
        [pinglunbtn addSubview:pinglunImage];
        [pinglunImage release];
        //[pinglunbtn setImage:UIImageGetImageFromName(@"wb27.png") forState:UIControlStateNormal];
        UIImageView *zhuanfaImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        zhuanfaImage.image = UIImageGetImageFromName(@"wb30.png");
        [zhuanfabtn addSubview:zhuanfaImage];
        [zhuanfaImage release];
        //[zhuanfabtn setImage:UIImageGetImageFromName(@"wb29.png") forState:UIControlStateNormal];
        UIImageView *fenxiangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        fenxiangImage.image = UIImageGetImageFromName(@"wb36.png");
        [fenxiangbtn addSubview:fenxiangImage];
        [fenxiangImage release];
        //[fenxiangbtn setImage:UIImageGetImageFromName(@"wb35.png") forState:UIControlStateNormal];
        //        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        //        shouchangImage.image = UIImageGetImageFromName(@"wb32.png");
        //        [mCollectBtn addSubview:shouchangImage];
        //        [shouchangImage release];
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateNormal];
        UIImageView *gengduoImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        gengduoImage.image = UIImageGetImageFromName(@"wb34.png");
        [gengduobtn addSubview:gengduoImage];
        [gengduoImage release];
        
        
    }

}

- (void)loadingIpad{
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y, 768, self.mainView.frame.size.height);

    self.CP_navigation.title = @"微博正文";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(actionBack:)];
    
    
//    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb61.png");
//    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
//    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
//    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
//    self.CP_navigation.rightBarButtonItem = rigthItemButton;
//    [rigthItemButton release];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
    //dTableView.backgroundView = backImage;
	[self.mainView addSubview:backImage];
    [backImage release];
    
    imagedown.image = UIImageGetImageFromName(@"wb19.png");//底部评论等按钮背景图片
    imagedown.frame = CGRectMake(imagedown.frame.origin.x, imagedown.frame.origin.y, 390, imagedown.frame.size.height);
    
	mUserView = [[UserCellView alloc] initWithUserInfo:mStatus homebool:homebool];
	mUserView.ishome = homebool;
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.frame = CGRectMake(0, 0, 0, 0);
	[imageView setImage: UIImageGetImageFromName(@"V.png")];
	imageView.backgroundColor = [UIColor clearColor];
	
	if ([mStatus.vip intValue] == 1) {
		imageView.frame = CGRectMake(42, 44, 14, 14);
	}
	else {
		imageView.frame = CGRectMake(0, 0, 0, 0);
	}
    self.mainView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:mUserView];
	[mUserView addSubview: imageView];
	[imageView release];
    
    
    dTableView = [[UITableView alloc]initWithFrame:CGRectMake(4,48 + imageView.frame.size.height, 370, self.mainView.bounds.size.height - 48 - imageView.frame.size.height-60) style:UITableViewStylePlain];
    dTableView.showsHorizontalScrollIndicator = NO;
    dTableView.showsVerticalScrollIndicator = NO;
	[dTableView setDelegate:self];
	[dTableView setDataSource:self];
    
    dTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:dTableView];
	[dTableView release];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weibozhengwenhanshu:) name:@"zhengwenhanshu" object:nil];
    
    [self.mainView insertSubview:mScrollView atIndex:0];
    
    if (!addCollectionBtn) {
		addCollectionBtn = [[Info CollectBtnInit:self imageNamed:@"collect.png" action:@selector(actionAddCollection)] retain];
		[addCollectionBtn setFrame:CGRectMake(195, 365, 60, 45)];
	}
	if (!cancelCollectionBtn) {
		cancelCollectionBtn = [[Info CollectBtnInit:self imageNamed:@"collectCancel.png" action:@selector(actionCancelCollection)] retain];
		[cancelCollectionBtn setFrame:CGRectMake(195, 365, 60, 45)];
	}
    
    
    if (mStatus) {
        if([mStatus.isCc isEqualToString:@"1"])
        {
            [self changeCollectBtn:cancelCollectionBtn];
        }
        else
        {
            [self changeCollectBtn:addCollectionBtn];
        }
    }
    
    if (mRefreshView == nil) {
		mRefreshView = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -480, 320, 480)];
		[mRefreshView setDelegate:self];
        mRefreshView.hidden = YES;
		[self.mainView addSubview:mRefreshView];
    }
    NSLog(@"aa = %@", mStatus.count_pl);
    
    count_plstr = [mStatus.count_pl intValue];
    self.dTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    DetailedView *tmpDetailedView = [[DetailedView alloc] initWithMessage:mStatus homebol:homebool];
    if (homebool) {
        tmpDetailedView.homebool = YES;
    }else{
        tmpDetailedView.homebool = NO;
    }
    
    self.mDetailedView = tmpDetailedView;
	self.mDetailedView.detaildelegate = self;
    [self.dTableView setTableHeaderView:self.mDetailedView];
   
    [tmpDetailedView release];
    
    loadCell = [[LoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoComment"];
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    loadCell.selectedBackgroundView=  UITableViewCellSelectionStyleNone ;
    
    moreCell = [[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreLoadCell"];
    if (mCommentArray) {
		[dTableView reloadData];
	}
	else if(actionIndex == ActionOne){
        [self showSegmentOneAction];
    }
    else {
        [self showSegmentTwoAction];
    }
    UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
    shouchangImage.tag = 101;
    if ([mStatus.isCc intValue] == 0) {
        mCollectBtn.tag = 0;
        shouchangImage.image = UIImageGetImageFromName(@"wb31.png");
    }else if([mStatus.isCc intValue] == 1){
        shouchangImage.image = UIImageGetImageFromName(@"SC960.png");
        mCollectBtn.tag = 1;
    }
    
    [mCollectBtn addSubview:shouchangImage];
    [shouchangImage release];
    
    
    
    
    
    //判断是否登录注册
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        zhuanfabtn.enabled = YES;
        pinglunbtn.enabled = YES;
        fenxiangbtn.enabled = YES;
        mCollectBtn.enabled = YES;
        gengduobtn.enabled = YES;
        
        UIImageView *pinglunImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        pinglunImage.image = UIImageGetImageFromName(@"wb27.png");
        [pinglunbtn addSubview:pinglunImage];
        [pinglunImage release];
        //[pinglunbtn setImage:UIImageGetImageFromName(@"wb27.png") forState:UIControlStateNormal];
        UIImageView *zhuanfaImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        zhuanfaImage.image = UIImageGetImageFromName(@"wb29.png");
        [zhuanfabtn addSubview:zhuanfaImage];
        [zhuanfaImage release];
        //[zhuanfabtn setImage:UIImageGetImageFromName(@"wb29.png") forState:UIControlStateNormal];
        UIImageView *fenxiangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        fenxiangImage.image = UIImageGetImageFromName(@"wb35.png");
        [fenxiangbtn addSubview:fenxiangImage];
        [fenxiangImage release];
        //[fenxiangbtn setImage:UIImageGetImageFromName(@"wb35.png") forState:UIControlStateNormal];
        //        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 5, 18, 18)];
        //        shouchangImage.image = UIImageGetImageFromName(@"wb31.png");
        //        [mCollectBtn addSubview:shouchangImage];
        //        [shouchangImage release];
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateNormal];
        UIImageView *gengduoImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        gengduoImage.image = UIImageGetImageFromName(@"wb33.png");
        [gengduobtn addSubview:gengduoImage];
        [gengduoImage release];
        //[gengduobtn setImage:UIImageGetImageFromName(@"wb33.png") forState:UIControlStateNormal];
        
        
        
        
    }else{
        
        
        
        //        zhuanfabtn.enabled = NO;
        //        pinglunbtn.enabled = NO;
        //        fenxiangbtn.enabled = NO;
        //        mCollectBtn.enabled = NO;
        //        gengduobtn.enabled = NO;
        
        zhucebutton = [[CP_PTButton alloc] initWithFrame:CGRectMake(230, 10, 80, 30)];
        [zhucebutton loadButonImage:@"TYD960.png" LabelName:@"登录注册"];
        zhucebutton.buttonImage.image = [zhucebutton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [zhucebutton addTarget:self action:@selector(presszhuce:) forControlEvents:UIControlEventTouchUpInside];
        zhucebutton.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:zhucebutton];
        
       
        UIImageView *pinglunImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        pinglunImage.image = UIImageGetImageFromName(@"wb28.png");
        [pinglunbtn addSubview:pinglunImage];
        [pinglunImage release];
        //[pinglunbtn setImage:UIImageGetImageFromName(@"wb27.png") forState:UIControlStateNormal];
        UIImageView *zhuanfaImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        zhuanfaImage.image = UIImageGetImageFromName(@"wb30.png");
        [zhuanfabtn addSubview:zhuanfaImage];
        [zhuanfaImage release];
        //[zhuanfabtn setImage:UIImageGetImageFromName(@"wb29.png") forState:UIControlStateNormal];
        UIImageView *fenxiangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        fenxiangImage.image = UIImageGetImageFromName(@"wb36.png");
        [fenxiangbtn addSubview:fenxiangImage];
        [fenxiangImage release];
        //[fenxiangbtn setImage:UIImageGetImageFromName(@"wb35.png") forState:UIControlStateNormal];
        //        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        //        shouchangImage.image = UIImageGetImageFromName(@"wb32.png");
        //        [mCollectBtn addSubview:shouchangImage];
        //        [shouchangImage release];
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateNormal];
        UIImageView *gengduoImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
        gengduoImage.image = UIImageGetImageFromName(@"wb34.png");
        [gengduobtn addSubview:gengduoImage];
        [gengduoImage release];
        
        
    }
    
    pinglunbtn.frame = CGRectMake(9+35, 410, 45, 30);
    zhuanfabtn.frame = CGRectMake(75+35, 410, 45, 30);
    fenxiangbtn.frame = CGRectMake(205+35, 410, 45, 30);
    gengduobtn.frame = CGRectMake(266+35, 410, 45, 30);
    mCollectBtn.frame = CGRectMake(138+35, 410, 45, 30);
    
    UILabel * label1 = (UILabel *)[self.view viewWithTag:10];
    UILabel * label2 = (UILabel *)[self.view viewWithTag:11];
    UILabel * label3 = (UILabel *)[self.view viewWithTag:12];
    UILabel * label4 = (UILabel *)[self.view viewWithTag:13];
    UILabel * label5 = (UILabel *)[self.view viewWithTag:14];
    
    label1.frame =  CGRectMake(12+35, 440, 42, 15);
    label2.frame =  CGRectMake(76+35, 440, 42, 15);
    label3.frame =  CGRectMake(139+35, 440, 42, 15);
    label4.frame =  CGRectMake(205+35, 440, 42, 15);
    label5.frame =  CGRectMake(266+35, 443, 42, 15);
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef isCaiPiaoForIPad
    [self loadingIpad];
    
#else
    [self loadingIphone];
#endif
   

}


- (void)returnYtTopic:(YtTopic *)sstatuss{

    NSLog(@"ssta = %@", sstatuss.count_pl);
    if (count_plstr != [sstatuss.count_pl intValue]) {
        
        count_plstr = [sstatuss.count_pl intValue];
        [dTableView reloadData];
    }
}

- (void)loginButtonHidden{
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(doPushHomeView) ImageName:nil Size:CGSizeMake(70,30)];
//        zhucebutton.hidden = YES;
        mUserView.userInteractionEnabled = YES;
    }else{
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(presszhuce:) ImageName:nil Size:CGSizeMake(80,30)];
//        zhucebutton.hidden = NO;
        //   zhucebutton.userInteractionEnabled = YES;
        mUserView.userInteractionEnabled = NO;
    }

}

// 视图即将可见时调用
- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self loginButtonHidden];
  
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeiBoLike" object:mStatus];
}

#pragma mark DetailedViewDelegate

- (void) showSegmentOneAction
{
    actionIndex = ActionOne;
    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
}
- (void) showSegmentTwoAction
{
    actionIndex = ActionTwo;
    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
}
- (void)reloadDataView:(UIView *)view1
{
    [self.dTableView setTableHeaderView:view1];

}
- (void)reloadDataViewAgain:(NSNotification *)aNotifiacion
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReloadDataViewAgain" object:nil];
//    [self.dTableView reloadData];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataViewAgain:) name:@"ReloadDataViewAgain" object:nil];

}
// 改变收藏按钮
- (void)changeCollectBtn:(UIButton*)button
{
//    if (mCollectBtn) 
//        {
//        [mCollectBtn removeFromSuperview];
//        }
//    self.mCollectBtn = button;
//    [self.mainView addSubview:mCollectBtn];
}

- (id) initWithMessage : (YtTopic *) status indexrow:(NSInteger)indexrow{
    if ((self = [super init])) {
        
        [self setMStatus:status];
        actionIndex = ActionOne;
        instance = self;
        index = 1;
        indexTwo = 1;
        topicLoadedEnd = NO;
        inrowcount = indexrow;
        NSLog(@"mStatus = %@", mStatus.isCc);
    }
    return self;

}

- (id) initWithMessage:(YtTopic *)status {
  
        if ((self = [super init])) {
            
            [self setMStatus:status];
			actionIndex = ActionOne;
			instance = self;
            index = 1;
			indexTwo = 1;
			topicLoadedEnd = NO;
            NSLog(@"mStatus = %@", mStatus.isCc);
        }
        return self;
}

// 跳到主页
- (void)doPushHomeView
{
    if (homebool) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hometozhuye" object:nil];
    }else{
        [[caiboAppDelegate getAppDelegate] switchToHomeView];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
     
    
}

// 刷新
- (IBAction) actionRefresh:(id)sender {
    if (mStatus && mStatus.topicid) {
        [mRequest clearDelegatesAndCancel];
        self.mRequest= [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.topicid]];
        [mRequest setUsername:@"refresh"];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        [self.mDetailedView actionRefresh:nil];
    }
}
- (void)autoRefresh
{
    if (mStatus && mStatus.topicid) {
        [amRequest clearDelegatesAndCancel];
        self.amRequest= [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.topicid]];
        [amRequest setUsername:@"refresh"];
        [amRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [amRequest setDelegate:self];
        [amRequest setTimeOutSeconds:20.0];
        [amRequest startAsynchronous];
        [self.mDetailedView actionRefresh:nil];
    }

}
// 评论或转发
- (IBAction) actionCommentOrForward:(UIButton *)sender {
#ifdef isCaiPiaoForIPad
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
    NewPostViewController *publishController = [[NewPostViewController alloc] init];
    [publishController setMStatus: mStatus];
    if (sender.tag == 0) {
        [MobClick event:@"event_weibohudong_guangchang_pinglun"];
        publishController.publishType = kCommentTopicController;// 评论
        //[[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentTopicController mStatus:mStatus];
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
    } else {
        [MobClick event:@"event_weibohudong_guangchang_zhuanfa"];
        publishController.publishType = kForwardTopicController;// 转发
//        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kForwardTopicController mStatus:mStatus];
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
    }
    
    [publishController release];
    

#else
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    [publishController setMStatus: mStatus];
//    if (sender.tag == 0) {
//        [MobClick event:@"event_weibohudong_guangchang_pinglun"];
//        publishController.publishType = kCommentTopicController;// 评论
//    } else {
//        [MobClick event:@"event_weibohudong_guangchang_zhuanfa"];
//        publishController.publishType = kForwardTopicController;// 转发
//    }
//    [self.navigationController pushViewController:publishController animated:YES];
//    [publishController release];
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    [publishController setMStatus: mStatus];
    if (sender.tag == 0) {
        [MobClick event:@"event_weibohudong_guangchang_pinglun"];
        publishController.microblogType = CommentTopicController;// 评论
    } else {
        [MobClick event:@"event_weibohudong_guangchang_zhuanfa"];
        publishController.microblogType = ForwardTopicController;// 转发
    }
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];

#endif
    
}

// 收藏
- (void)actionAddCollection
{
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
    [mRequest clearDelegatesAndCancel];
    [MobClick event:@"event_weibohudong_guangchang_shoucang"];
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveFavorite:mStatus.topicid userId:[[Info getInstance] userId]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest startAsynchronous];
    [[ProgressBar getProgressBar] show:@"正在收藏微博..." view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
}

// 取消收藏
- (void)actionCancelCollection
{
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
    [mRequest clearDelegatesAndCancel];
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBdeleteUserTopicById:[[Info getInstance] userId] topicId:mStatus.topicid]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setUsername:@"deleteUserTopicById"];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest startAsynchronous];
    [[ProgressBar getProgressBar] show:@"正在取消收藏..." view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
}

// 接收服务器返回JSON数据
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    NSLog(@"responseStr = %@", result);
	if ([[result JSONValue] isKindOfClass:[NSArray class]]) {
		NSArray *array = [result JSONValue];
		if ([array count]>0 &&[[[array objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"]) {
			isDeleted = YES;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此微博已经被删除" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			alert.tag = 112233;
			[alert show];
			[alert release];
		}
	}
	else if ([[result JSONValue] isKindOfClass:[NSDictionary class]]){
		if ([[[result JSONValue] objectForKey:@"status"] isEqualToString:@"1"]) {
			isDeleted = YES;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此微博已经被删除" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			alert.tag = 112233;
			[alert show];
			[alert release];
		}
	}
	
    // 刷新微博数据
    if ([[request username] isEqualToString:@"refresh"]) {
        
        NSArray * ytTopicArr = [result JSONValue];
        if (ytTopicArr.count) {
            NSDictionary * ytTopicDic = [ytTopicArr objectAtIndex:0];
            
            NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
            
            if ([ytTopicDic valueForKey:@"count_dz"]) {
                [weiBoLikeDic setObject:@[[ytTopicDic valueForKey:@"count_dz"],[ytTopicDic valueForKey:@"praisestate"]] forKey:[ytTopicDic valueForKey:@"topicid"]];
                [[NSUserDefaults standardUserDefaults] setValue:weiBoLikeDic forKey:@"weiBoLike"];
            }
        }
        
        NSIndexPath * selectIndexPath = mStatus.indexPath;
        
        [self setMStatus: [[[mStatus initWithParse:result] arrayList] objectAtIndex:0]];
        if (mStatus) {
            [self.mDetailedView actionRefresh:mStatus];
        }
        mStatus.indexPath = selectIndexPath;
        return;
    } else if ([[request username] isEqualToString:@"shareTopic"]) {
        // 分享
        if ([result isEqualToString:RESULT_SUCC] || [result isEqualToString:RESULT_EXIST]) {
            [[ProgressBar getProgressBar] setTitle:@"分享成功!"];
        } else if ([result isEqualToString:RESULT_FAIL]) {
            [[ProgressBar getProgressBar] setTitle:@"分享失败!"];
        } else {
            NSDictionary *resultDict = [result JSONValue];
            if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
                [[ProgressBar getProgressBar] setTitle:@"分享成功!"];
            } else {
                [[ProgressBar getProgressBar] setTitle:@"分享失败!"];
            }
        }
    } else if ([[request username] isEqualToString:@"deleteUserTopicById"]) {// 取消收藏
        NSDictionary *resultDict = [result JSONValue];
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"取消成功!"];
            [self changeCollectBtn:addCollectionBtn];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"取消失败!"];
        }
    } else if ([[request username] isEqualToString:@"deleteComment"]||[[request username] isEqualToString:@"delTopic"]) {
        if ([result isEqualToString:RESULT_SUCC] || [result isEqualToString:RESULT_EXIST]) {
            [[ProgressBar getProgressBar] setTitle:@"删除成功!"];
        } else if ([result isEqualToString:RESULT_FAIL]) {
            [[ProgressBar getProgressBar] setTitle:@"删除失败!"];
        } else {
            NSDictionary *resultDict = [result JSONValue];
            if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
                [[ProgressBar getProgressBar] setTitle:@"删除成功!"];
            } else {
                [[ProgressBar getProgressBar] setTitle:@"删除失败!"];
            }
        }
    }
    else {// 添加收藏
        if ([result isEqualToString:RESULT_SUCC] || [result isEqualToString:RESULT_EXIST]) {
            [[ProgressBar getProgressBar] setTitle:@"收藏成功!"];
            [self changeCollectBtn:cancelCollectionBtn];
        } else if ([result isEqualToString:RESULT_FAIL]) {
            [[ProgressBar getProgressBar] setTitle:@"收藏失败!"];
        } else {
            NSDictionary *resultDict = [result JSONValue];
            if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
                [[ProgressBar getProgressBar] setTitle:@"收藏成功!"];
                [self changeCollectBtn:cancelCollectionBtn];
            } else {
                [[ProgressBar getProgressBar] setTitle:@"收藏失败!"];
            }
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.7
                                     target:self
                                   selector:@selector(dismissDialog:)
                                   userInfo:[request username]
                                    repeats:NO];
}

- (void) requestFailed:(ASIHTTPRequest *)request {
    [self.mDetailedView actionRefresh:mStatus];
    [[ProgressBar getProgressBar] dismiss];
}

- (void)returnshifoushanchu:(NSInteger)shanchu{
    if ([delegate respondsToSelector:@selector(returnshifoushanchu:)]) {
        [delegate returnshifoushanchu:1];
        // NSLog(@"index = %d", index);
    }

}

- (void) dismissDialog : (id) sender {
    [[ProgressBar getProgressBar] dismiss];
    if ([[(NSTimer *)sender userInfo] isEqualToString:@"delTopic"]) {
        [[Info getInstance] setIsNeedRefreshHome:YES];
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self returnshifoushanchu:1];
        
        
    } else if ([[(NSTimer *)sender userInfo] isEqualToString:@"deleteUserTopicById"]) {
        [[Info getInstance] setIsNeedRefreshHome:YES];
    }
}
- (IBAction)actionbuttonshouchang:(UIButton *)sender{
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
    UIImageView * shouchangImage = (UIImageView *)[mCollectBtn viewWithTag:101];
    if (mCollectBtn.tag == 0) {
        //[mCollectBtn setImage:UIImageGetImageFromName(@"SC960.png") forState:UIControlStateNormal];
//        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
//        shouchangImage.image = UIImageGetImageFromName(@"SC960.png");
        shouchangImage.image = UIImageGetImageFromName(@"weibo_shoucang1.png");
//        [mCollectBtn addSubview:shouchangImage];
//        [shouchangImage release];
        mCollectBtn.tag = 1;
        [self actionAddCollection];
    }else{
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateNormal];
        //[mCollectBtn setImage:UIImageGetImageFromName(@"wb31.png") forState:UIControlStateHighlighted];
//        UIImageView *shouchangImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 18, 18)];
//        shouchangImage.image = UIImageGetImageFromName(@"wb31.png");
        shouchangImage.image = UIImageGetImageFromName(@"weibo_shoucang.png");
//        [mCollectBtn addSubview:shouchangImage];
//        [shouchangImage release];
        mCollectBtn.tag = 0;
        [self actionCancelCollection];
    }
    [self returnshifouguanzhu:[NSString stringWithFormat:@"%d", (int)mCollectBtn.tag] row:inrowcount];
}
// 更多
- (IBAction) actionMore:(id)sender {
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
	if (isDeleted) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此微博已经被删除" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		alert.tag = 112233;
		[alert show];
		[alert release];
		return;
	}
    [MobClick event:@"event_weibohudong_guangchang_gengduo"];
    //UIActionSheet *actionSheet = nil;
    CP_LieBiaoView *lb2;
    if ([mStatus.userid isEqualToString:[[Info getInstance] userId]]) {
//        actionSheet = [[UIActionSheet alloc]
//                       initWithTitle:@"请选择需要的操作"
//                       delegate:self
//                       cancelButtonTitle:@"取消"
//                       destructiveButtonTitle:nil
//                       otherButtonTitles:@"刷新", @"删除该微博", nil];//@"短信分享给好友", @"复制", @"删除该微博" ,nil];
        lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb2.delegate = self;
        lb2.tag = 102;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"刷新",@"删除该微博",nil]];
        [lb2 show];

    } else {
//        actionSheet = [[UIActionSheet alloc]
//                       initWithTitle:@"请选择需要的操作"
//                       delegate:self
//                       cancelButtonTitle:@"取消"
//                       destructiveButtonTitle:nil
//                       otherButtonTitles:@"刷新", nil];//@"短信分享给好友", @"复制", @"举报该微博" ,nil];
        lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb2.delegate = self;
        lb2.tag = 102;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"刷新",nil]];
        [lb2 show];
        

    }
    //[actionSheet showInView:self.mainView];
    //[actionSheet release];
    [lb2 release];
}

//分享
- (IBAction)actionShare:(id)sender {
    
    Info *info1 = [Info getInstance];
    if ([info1.userId intValue]) {
        
    }else{
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        
        return;
    }
    
    
    
    [MobClick event:@"event_weibohudong_guangchang_fenxiang"];
    CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
    lb2.delegate = self;
    lb2.tag = 103;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        lb2.weixinBool = YES;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到新浪微博",@"分享到腾讯微博",@"分享到微信朋友圈(未安装)",nil]];
    }else{
        lb2.weixinBool = NO;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到微信朋友圈",@"分享到新浪微博",@"分享到腾讯微博",nil]];
    }

    
    lb2.isSelcetType = YES;
//    [lb2 show];
    [lb2 showFenxiang];
    [lb2 release];
    

    
    
    
    return;
}

// 返回
- (void) actionBack:(id)sender 
{
    if(self.isFromFlashAd)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"删除该评论"]) {// 删除该评论
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBdeleteCommentById:[[Info getInstance] userId] commentId:[[mCommentArray objectAtIndex:mSection] ycid]]]];
        [mRequest setUsername:@"deleteComment"];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest startAsynchronous]; 
        [[ProgressBar getProgressBar] show:@"正在删除评论..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
    } else if ([title isEqualToString:@"他的资料"]) {// 他的资料
        [[Info getInstance] setHimId:[[mCommentArray objectAtIndex:mSection] userId]];
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:followeesController animated:YES];
		[followeesController release];
    } else if ([title isEqualToString:@"回复此评论"]) {// 回复此评论
#ifdef isCaiPiaoForIPad
        YtTopic *mRevert = [[YtTopic alloc] init];
        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentRevert mStatus:mRevert];
        [mRevert release];
        
#else
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        YtTopic *mRevert = [[YtTopic alloc] init];
//        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
//        publishController.mStatus = mRevert;
//        [mRevert release];
//        publishController.publishType = kCommentRevert;// 回复评论
//        [self.navigationController pushViewController:publishController animated:YES];
//        [publishController release];
        
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        YtTopic *mRevert = [[YtTopic alloc] init];
        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
        publishController.mStatus = mRevert;
        [mRevert release];
        publishController.microblogType= CommentRevert;// 回复评论

        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
#endif
    } else if ([title isEqualToString:@"复制此评论"]) {// 复制此评论
        UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
        [generalPasteBoard setString:[[mCommentArray objectAtIndex:mSection] content]];
        NSLog(@"%@",[[mCommentArray objectAtIndex:mSection] content]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"评论内容已复制!"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else if ([title isEqualToString:@"短信分享给好友"]) {// 短信分享给好友
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"短信分享"
                                                        message:@"微博内容已复制，请在短信页面粘贴发送。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    } else if ([title isEqualToString:@"复制"]) {// 复制
		UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
		NSMutableString *content = [[NSMutableString alloc] initWithCapacity:40];
		if (mStatus) {
			if (mStatus.mcontent) {
				[content appendFormat:@"%@",mStatus.content];
			}
			if (mStatus.orignalText) {	
				[content appendFormat:@"%@",@"\n微博原文："];
				[content appendFormat:@"%@",mStatus.orignalText];
			}
		}
		[generalPasteBoard setString:content];
		[content release];
//        UIAlertView *alert = [UIAlertView alloc];
//        [alert initWithTitle:nil
//                     message:@"评论内容已复制!"
//                    delegate:self
//           cancelButtonTitle:@"确定"
//           otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
    } else if ([title isEqualToString:@"举报该微博"]) {// 举报该微博
		ReportViewController *report = [[ReportViewController alloc] initWithYtTopic:mStatus];
		UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:report];
        
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
#endif
//            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        }
		[report release];
		[self.navigationController presentViewController:navController animated: YES completion:nil];
		[navController release];
    } else if ([title isEqualToString:@"删除该微博"]) {// 删除该微博
        [mRequest clearDelegatesAndCancel];
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBdelTopic:[[Info getInstance] userId] topicId:mStatus.topicid]];
        [mRequest setUsername:@"delTopic"];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        [[ProgressBar getProgressBar] show:@"正在删除微博..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
    }else if([title isEqualToString:@"刷新"]){//刷新
      
       [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
    }

}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 112233) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:nil];
		[self.navigationController popViewControllerAnimated:YES];
		return;
	}
	if (buttonIndex == alertView.cancelButtonIndex) {
//        Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
//        if ([messageClass canSendText]) {
//            [self openSMS]; 
//        } else {
//            UIDeviceHardware *hardware = [[UIDeviceHardware alloc]init];  
//            NSString *platform = [hardware platformString];
//            [hardware release];
//            if ([platform hasPrefix:@"iPhone"]) {
//                [self openSMS]; 
//            } else {
//                UIAlertView *alert = [UIAlertView alloc];
//                [alert initWithTitle:@"提醒"
//                             message:@"设备没有短信功能"
//                            delegate:self
//                   cancelButtonTitle:nil
//                   otherButtonTitles:@"取消", nil];
//                [alert show];
//                [alert release];
//            }
//        }
	}
}

-(void)openSMS{
	UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
	NSMutableString *content = [[NSMutableString alloc] initWithCapacity:40];
	if (mStatus) {
		[content appendFormat:@"%@",@"我在第一彩博iphone客户端中发现了这篇博文，想与你分享：\n"];
		if (mStatus.mcontent) {
			[content appendFormat:@"%@",mStatus.mcontent];
		}
		
		if (mStatus.orignalText) {
			[content appendFormat:@"%@",@"\n微博原文："];
			[content appendFormat:@"%@",mStatus.orignalText];
			
		}
		
		if (mStatus.attach) {
			[content appendFormat:@"%@",@"\n图片地址："];
			[content appendFormat:@"%@",mStatus.attach];
			
		}
		[content appendFormat:@"%@",@"\n第一彩博：t.diyicai.com"];
		
	}
	[generalPasteBoard setString:content];
	[content release];
	
	NSString *num = [[NSString alloc] initWithFormat:@"sms://%@",@" "];  
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; 
	
    [num release];
}


- (void)dealloc {
    
    [mDetailedView release];
    [mCommentArray release];
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    
    [mUserView release];
    
    [mScrollView release];
    
    [mCollectBtn release];
    [addCollectionBtn release];
    [cancelCollectionBtn release];
    
    [mStatus release];
    [amRequest clearDelegatesAndCancel];
    [amRequest release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

    [super viewDidUnload];
	self.mDetailedView = nil;
	loadCell= nil;
	moreCell = nil;
	
}

- (void)prograssBarBtnDeleate:(NSInteger) type{
    
    [mRequest clearDelegatesAndCancel];
    [[ProgressBar getProgressBar] dismiss];
}
#pragma mark requestDelegate
- (void)doneLoadingTableViewData:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    // 删除评论
    if ([request.username isEqualToString:@"deleteComment"]) {
        NSDictionary *resultDict = [responseString JSONValue];
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [mCommentArray removeObjectAtIndex:mSection];
            [self.dTableView reloadData];
            [[ProgressBar getProgressBar] setTitle:@"删除成功!"];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"删除失败!"];
        }
        [NSTimer scheduledTimerWithTimeInterval:0.7
                                         target:self
                                       selector:@selector(dismissDialog:)
                                       userInfo:nil
                                        repeats:NO];
        return;
    }
    
	if (responseString) {
        [mCommentArray removeAllObjects];
        TopicComment *list = [[TopicComment alloc] init];
        [self setMCommentArray: [list arrayWithParse:responseString]];
        [list release];
       // NSLog(@"ddd = %d", [mCommentArray count]);
	}
	
    index = 1;
    indexTwo = 1;
	[self.dTableView reloadData];
	self.navigationItem.rightBarButtonItem.enabled = YES;
    [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:0.2];
}
- (void)requestFailedWithDidLoadedTableViewData:(ASIHTTPRequest *)request
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
	mReloading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.dTableView];
    
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    [loadCell.spinner stopAnimating];
    [moreCell spinnerStopAnimating];

}

#pragma mark tableViewDelegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = (int)[mCommentArray count];
    return count == 0 ? 1 : count + 1;
}

- (CGSize) getTextSize : (NSString *) text {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(285, 1000);
    CGSize labelsize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setMStatus:mStatus];
    count_plstr = [mStatus.count_pl intValue];
    CGFloat cellHeigth;
	if ([mCommentArray count] == 0 || indexPath.row == [mCommentArray count]) {
		cellHeigth = 50;
	} else {
		TopicComment *comment = [mCommentArray objectAtIndex:indexPath.row];
		cellHeigth = [self getTextSize:comment.content].height + 50;
        
        if([comment.nickName isEqualToString:@"活动管理员"] && [comment.content rangeOfString:@"http://"].location != NSNotFound)
        {
            cellHeigth += 48;

        }

	}
  	return cellHeigth;
}

- (BOOL) isMe : (NSString *) nickName {
    if ([nickName isEqualToString:[[Info getInstance] nickName]]) {
        return YES;
    }
    return NO;
}
- (void)segmentedAction:(UIButton *)sender
{
    if (sender.tag == 100) {
        bentieLabel.textColor = [UIColor colorWithRed:22/255.0 green:136/255.0 blue:218/255.0 alpha:1];
        yuantieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        xian.frame=CGRectMake(140, bentieButton.frame.size.height+8, 80, 2);
        
        yuantie=NO;
        
        [self showSegmentOneAction];
    }else
    {
        yuantieLabel.textColor = [UIColor colorWithRed:22/255.0 green:136/255.0 blue:218/255.0 alpha:1];
        bentieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
        xian.frame=CGRectMake(220, bentieButton.frame.size.height+8, 80, 2);
        
        yuantie=YES;
        
        [self showSegmentTwoAction];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 暂无评论
    if (0 == [mCommentArray count]) {
        loadCell.backgroundColor = [UIColor clearColor];
        return loadCell;
    }
    // 更多
	if (indexPath.row == [mCommentArray count]) {
        if (indexPath.row % 2) {
            [moreCell setCellStyle:StyleOne];
        } else {
            [moreCell setCellStyle:StyleNormal];
        }
        moreCell.backgroundColor = [UIColor clearColor];
        return moreCell;
	} else {
        if (actionIndex == ActionOne)
            {
            static NSString *CellIdentifier = @"CommentCell";
            
            CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
            }
                

            
            TopicComment *mComment = [mCommentArray objectAtIndex:indexPath.row];
                

//                NSRange range1 = [mComment.content rangeOfString:@"充值"];
//                NSRange range2 = [mComment.content rangeOfString:@"提款"];
//                NSRange range3 = [mComment.content rangeOfString:@"测试"];
                if([mComment.nickName isEqualToString:@"活动管理员"] && [mComment.content rangeOfString:@"http://"].location != NSNotFound)
                {
                    cell.isAutoReport = YES;
                }
                else
                    cell.isAutoReport = NO;



            [cell setComment:mComment];
            
//            if (indexPath.row % 2) {
//                 [cell.contentView setBackgroundColor:[UIColor clearColor]];
//            } else {
//                 //[cell.contentView setBackgroundColor:[UIColor colorWithRed:232 / 255.0 green: 241 / 255.0 blue: 250 / 255.0 alpha:1.0]];
//                [cell.contentView setBackgroundColor:[UIColor clearColor]];
//            }
            
            return cell;
            }
        if (actionIndex == ActionTwo)
            {
            static NSString *CellIdentifier = @"CommentCell";
            
            CommentCell *cellTwo = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cellTwo == nil) {
                cellTwo = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cellTwo.backgroundColor = [UIColor clearColor];
            }
            
            TopicComment *mComment = [mCommentArray objectAtIndex:indexPath.row];
            [cellTwo setComment:mComment];
                
//                NSRange range1 = [mComment.content rangeOfString:@"充值"];
//                NSRange range2 = [mComment.content rangeOfString:@"提款"];
//                NSRange range3 = [mComment.content rangeOfString:@"测试"];
                if([mComment.nickName isEqualToString:@"活动管理员"]  && [mComment.content rangeOfString:@"http://"].location != NSNotFound)
                {
                    cellTwo.isAutoReport = YES;
                }
                else
                    cellTwo.isAutoReport = NO;
            
//            if (indexPath.row % 2) {
//                [cellTwo.contentView setBackgroundColor:[UIColor clearColor]];
//            } else {
//                //[cellTwo.contentView setBackgroundColor:[UIColor colorWithRed:232 / 255.0 green: 241 / 255.0 blue: 250 / 255.0 alpha:1.0]];
//                [cellTwo.contentView setBackgroundColor:[UIColor clearColor]];
//            }
            return cellTwo;
            }
        return nil;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[[UIView alloc]init]autorelease];
    headView.frame=CGRectMake(0, 0, 320,40);
    headView.backgroundColor=[UIColor whiteColor];
    
    UILabel *source=[[UILabel alloc]init];
    source.frame=CGRectMake(15, 5, 150, 30);
    source.backgroundColor=[UIColor clearColor];
    source.font=[UIFont systemFontOfSize:13];
    if (!mStatus.source) {
        mStatus.source = @"来自第一彩博";
    }
    source.text=mStatus.source;
    if(source.text.length>2)
    {
        source.text=[source.text substringFromIndex:2];
    }
    [headView addSubview:source];
    [source release];
    
//    if(!SegmentView)
//    {
        SegmentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 311, 37)] autorelease];
        SegmentView.userInteractionEnabled = YES;
//    }
    
    NSString *tmpStringOne = nil;
    NSString *tmpStringTwo = nil;
    
    //原帖
    if ([mStatus.orignal_id isEqualToString:@"0"])
    {
        if (mStatus.count_pl) {
            NSLog(@"qqq = %@", mStatus.count_pl);
            tmpStringOne = [NSString stringWithFormat:@"本帖评论 %@",mStatus.count_pl];
            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            bentieButton.frame = CGRectMake(40, 10, 100, 30);
            bentieButton.frame = CGRectMake(220, 5, 80, 30);
            
            //            bentieButton.backgroundColor = [UIColor blackColor];
            bentieButton.backgroundColor = [UIColor clearColor];
            bentieButton.userInteractionEnabled = YES;
            bentieButton.tag = 100;
            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [headView addSubview:bentieButton];
            
            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            
            bentieLabel.backgroundColor = [UIColor clearColor];
            bentieLabel.text = tmpStringOne;
            bentieLabel.textAlignment=NSTextAlignmentCenter;
            bentieLabel.font = [UIFont systemFontOfSize:13];
            [bentieButton addSubview:bentieLabel];
            [bentieLabel release];
            
        }else
        {
            tmpStringOne = [NSString stringWithFormat:@"本帖评论 0"];
            
            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            bentieButton.frame = CGRectMake(40, 10, 100, 30);
            bentieButton.frame = CGRectMake(220, 5, 80, 30);
            
            //            bentieButton.backgroundColor = [UIColor blackColor];
            //            bentieButton.backgroundColor = [UIColor yellowColor];
            bentieButton.userInteractionEnabled = YES;
            bentieButton.tag = 100;
            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [headView addSubview:bentieButton];
            
            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            
            bentieLabel.backgroundColor = [UIColor clearColor];
            bentieLabel.text = tmpStringOne;
            bentieLabel.textAlignment=NSTextAlignmentCenter;
            bentieLabel.font = [UIFont systemFontOfSize:13];
            [bentieButton addSubview:bentieLabel];
            [bentieLabel release];
            
        }
    }
    //转发帖
    else
    {
        if (mStatus.count_pl) {
            NSLog(@"qqq = %@", mStatus.count_pl);
            tmpStringOne = [NSString stringWithFormat:@"本帖评论 %@",mStatus.count_pl];
            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            bentieButton.frame = CGRectMake(40, 10, 100, 30);
            bentieButton.frame = CGRectMake(140, 5, 80, 30);
            
            //            bentieButton.backgroundColor = [UIColor blackColor];
            bentieButton.backgroundColor = [UIColor clearColor];
            bentieButton.userInteractionEnabled = YES;
            bentieButton.tag = 100;
            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [SegmentView addSubview:bentieButton];
            
            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            
            bentieLabel.backgroundColor = [UIColor clearColor];
            bentieLabel.text = tmpStringOne;
            bentieLabel.textAlignment=NSTextAlignmentCenter;
            bentieLabel.font = [UIFont systemFontOfSize:13];
            [bentieButton addSubview:bentieLabel];
            [bentieLabel release];
            
        }else
        {
            tmpStringOne = [NSString stringWithFormat:@"本帖评论 0"];
            
            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            bentieButton.frame = CGRectMake(40, 10, 100, 30);
            bentieButton.frame = CGRectMake(140, 5, 80, 30);
            
            //            bentieButton.backgroundColor = [UIColor blackColor];
            //            bentieButton.backgroundColor = [UIColor yellowColor];
            bentieButton.userInteractionEnabled = YES;
            bentieButton.tag = 100;
            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [SegmentView addSubview:bentieButton];
            
            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            
            bentieLabel.backgroundColor = [UIColor clearColor];
            bentieLabel.text = tmpStringOne;
            bentieLabel.textAlignment=NSTextAlignmentCenter;
            bentieLabel.font = [UIFont systemFontOfSize:13];
            [bentieButton addSubview:bentieLabel];
            [bentieLabel release];
            
        }
        if (mStatus.count_pl_ref) {
            tmpStringTwo =[NSString stringWithFormat:@"原帖评论 %@",mStatus.count_pl_ref];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(148, 22, 2, 15)];
            //            line.image = UIImageGetImageFromName(@"wb39.png");
            line.backgroundColor = [UIColor clearColor];
            [SegmentView addSubview:line];
            [line release];
            
            yuantieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            yuantieButton.frame = CGRectMake(170, 10, 100, 30);
            yuantieButton.frame = CGRectMake(220, 5, 80, 30);
            //            yuantieButton.backgroundColor = [UIColor blackColor];
            
            yuantieButton.backgroundColor = [UIColor clearColor];
            yuantieButton.userInteractionEnabled = YES;
            yuantieButton.tag = 101;
            [yuantieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [SegmentView addSubview:yuantieButton];
            
            yuantieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            yuantieLabel.backgroundColor = [UIColor clearColor];
            yuantieLabel.text = tmpStringTwo;
            yuantieLabel.textAlignment=NSTextAlignmentCenter;
            yuantieLabel.font = [UIFont systemFontOfSize:13];
//            yuantieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
            [yuantieButton addSubview:yuantieLabel];
            [yuantieLabel release];
            
        }
        else
        {
            tmpStringTwo =[NSString stringWithFormat:@"原帖评论 0"];
            
            yuantieButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            yuantieButton.frame = CGRectMake(170, 10, 100, 30);
            yuantieButton.frame = CGRectMake(220, 5, 80, 30);
            //            yuantieButton.backgroundColor = [UIColor blackColor];
            
            yuantieButton.backgroundColor = [UIColor clearColor];
            yuantieButton.userInteractionEnabled = YES;
            yuantieButton.tag = 101;
            [yuantieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
            [SegmentView addSubview:yuantieButton];
            
            yuantieLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
            yuantieLabel.backgroundColor = [UIColor clearColor];
            yuantieLabel.text = tmpStringTwo;
            yuantieLabel.textAlignment=NSTextAlignmentCenter;
            yuantieLabel.font = [UIFont systemFontOfSize:13];
            [yuantieButton addSubview:yuantieLabel];
            [yuantieLabel release];
            
        }
        xian=[[UIImageView alloc]init];
        xian.backgroundColor=[UIColor colorWithRed:22/255.0 green:136/255.0 blue:218/255.0 alpha:1];
//        xian.frame=CGRectMake(100, bentieButton.frame.size.height+5, 100, 5);
        if(yuantie)
        {
            xian.frame=CGRectMake(220, bentieButton.frame.size.height+8, 80, 2);
//            yuantieLabel.textColor = [UIColor blackColor];
            yuantieLabel.textColor = [UIColor colorWithRed:22/255.0 green:136/255.0 blue:218/255.0 alpha:1];
            bentieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
        }
        else
        {
            xian.frame=CGRectMake(140, bentieButton.frame.size.height+8, 80, 2);
            bentieLabel.textColor = [UIColor colorWithRed:22/255.0 green:136/255.0 blue:218/255.0 alpha:1];
            yuantieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        }
        [headView addSubview:xian];
        [xian release];
    }
    
    [headView addSubview:SegmentView];
    
    UIImageView *lineIma=[[UIImageView alloc]init];
    lineIma.frame=CGRectMake(0, headView.frame.size.height-1, 320, 1);
    lineIma.backgroundColor=[UIColor clearColor];
    lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
    [headView addSubview:lineIma];
    [lineIma release];
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
#endif
        return;
    }
    
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    // 暂无评论
    if (0 == [mCommentArray count]) {
        [loadCell.spinner startAnimating];
        if (actionIndex == ActionOne) {
            [mRequest clearDelegatesAndCancel];
            [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:[NSString stringWithFormat:@"1"] pageSize:@"20"]]];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
            [mRequest startAsynchronous];
        }
        if (actionIndex == ActionTwo) {
            ++indexTwo;
            [mRequest clearDelegatesAndCancel];
            [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.orignal_id pageNum:[NSString stringWithFormat:@"1"] pageSize:@"20"]]];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
            [mRequest startAsynchronous];
        }
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.leftBarButtonItem.enabled = NO;
        return;
    }
    
    // 更多
    if (indexPath.row == [mCommentArray count]) {
        if ([self respondsToSelector:@selector(getMoreComment)]) {
            if (!mReloading) {
                MoreLoadCell *cell = (MoreLoadCell *)[tableView cellForRowAtIndexPath:indexPath];
                [cell spinnerStartAnimating];
                [self performSelector:@selector(getMoreComment) withObject:nil afterDelay:0.5];
                mReloading = YES;
            }
        }
	} else {
		if (isDeleted) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此微博已经被删除" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			alert.tag = 112233;
			[alert show];
			[alert release];
			return;
		}
        mSection = (int)indexPath.row;
        
        //UIActionSheet *actionSheet = nil;
        CP_LieBiaoView *lb1;
        NSString *userId = [[mCommentArray objectAtIndex:mSection] userId];
        
        
        TopicComment *mComment = [mCommentArray objectAtIndex:indexPath.row];


        if([mComment.nickName isEqualToString:@"活动管理员"] && [mComment.content rangeOfString:@"http://"].location != NSNotFound)
        {
            NSArray *array = [mComment.content componentsSeparatedByString:@"详见"];
            NSString *urlString = nil;
            if(array.count >=2)
            {
                urlString = [array objectAtIndex:1];
                if([urlString componentsSeparatedByString:@","].count >= 1)
                {
                    //如果是回复的是多条链接的情况，默认走第一条链接
                    urlString = [[[array objectAtIndex:1] componentsSeparatedByString:@","] objectAtIndex:0];
                }
            }
            else{
                
                urlString = [array objectAtIndex:0];
            }
 
            urlString = [urlString urlParseWithString:urlString];

            [self clikeOrderIdURL:urlString];
        }
        else
        {
            if ([userId isEqualToString:[[Info getInstance] userId]]) {
                //            actionSheet = [[UIActionSheet alloc]
                //                           initWithTitle:@"请选择需要的操作"
                //                           delegate:self
                //                           cancelButtonTitle:@"取消"
                //                           destructiveButtonTitle:@"删除该评论"
                //                           otherButtonTitles:@"他的资料", @"回复此评论", @"复制此评论",nil];
                lb1 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                lb1.delegate = self;
                lb1.tag = 101;
                [lb1 LoadButtonName:[NSArray arrayWithObjects:@"他的资料",@"回复此评论",@"复制此评论",@"删除该评论",nil]];
                [lb1 show];
            } else {
                //            actionSheet = [[UIActionSheet alloc]
                //                           initWithTitle:@"请选择需要的操作"
                //                           delegate:self
                //                           cancelButtonTitle:@"取消"
                //                           destructiveButtonTitle:nil
                //                           otherButtonTitles:@"他的资料", @"回复此评论", @"复制此评论",nil];
                lb1 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                NSLog(@"%f,%f,%f,%f",[UIScreen mainScreen].bounds.origin.x,[UIScreen mainScreen].bounds.origin.y,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
                
                lb1.delegate = self;
                lb1.tag = 101;
                [lb1 LoadButtonName:[NSArray arrayWithObjects:@"他的资料",@"回复此评论",@"复制此评论",nil]];
//                [lb1 show];
                [lb1 showAgain];
            }
            //[actionSheet showInView:self.mainView.superview];
            //[actionSheet release];
            [lb1 release];
        }

        

    }
}


- (void)clikeOrderIdURL:(NSString *)request1 {
    NSString *url = [NSString stringWithFormat:@"%@",request1];
    if ([url hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",request1] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"]) {
            [autoRequest clearDelegatesAndCancel];
            [self setAutoRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [autoRequest setDelegate:self];
            [autoRequest setDidFinishSelector:@selector(requestWBXQFinished:)];
            [autoRequest setTimeOutSeconds:20.0];
            [autoRequest startAsynchronous];
            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];
            [self.navigationController pushViewController:info animated:YES];
            
            [info release];
            return;
        }
        
    }
    MyWebViewController *my = [[MyWebViewController alloc] init];
	
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
    [my LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:request1]]];
	[my release];
}

- (void)requestWBXQFinished:(ASIHTTPRequest *)request1{
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}

- (void)shareWeiXin{
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo imageWithScreenContents];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    [appcaibo sendImageContent:screenImage];
    
   
    
    [self.CP_navigation clearMarkLabel];
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (liebiaoView.tag == 101) {
        if (buttonIndex == 0)//他的资料
        {
            [[Info getInstance] setHimId:[[mCommentArray objectAtIndex:mSection] userId]];
            ProfileViewController *followeesController = [[ProfileViewController alloc] init];
            [self.navigationController pushViewController:followeesController animated:YES];
            [followeesController release];
            
        }
        else if (buttonIndex == 1)//回复此评论
        {
            
#ifdef isCaiPiaoForIPad
            YtTopic *mRevert = [[YtTopic alloc] init];
            mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
            [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentRevert mStatus:mRevert];
            [mRevert release];
            
#else
//            NewPostViewController *publishController = [[NewPostViewController alloc] init];
//            YtTopic *mRevert = [[YtTopic alloc] init];
//            mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
//            publishController.mStatus = mRevert;
//            [mRevert release];
//            publishController.publishType = kCommentRevert;// 回复评论
//
//            [self.navigationController pushViewController:publishController animated:YES];
//            [publishController release];
            
            
            SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
            YtTopic *mRevert = [[YtTopic alloc] init];
            mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
            publishController.mStatus = mRevert;
            [mRevert release];
            publishController.microblogType = CommentRevert;// 回复评论
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
            [self presentViewController:nav animated: YES completion:nil];
            [publishController release];
            [nav release];
#endif
        }
        else if (buttonIndex == 2)//复制此评论
        {
            
            UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
            [generalPasteBoard setString:[[mCommentArray objectAtIndex:mSection] content]];
            NSLog(@"%@",[[mCommentArray objectAtIndex:mSection] content]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"评论内容已复制!"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }

       else if (buttonIndex == 3){
    
           [mRequest clearDelegatesAndCancel];
    
           [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBdeleteCommentById:[[Info getInstance] userId] commentId:[[mCommentArray objectAtIndex:mSection] ycid]]]];
           [mRequest setUsername:@"deleteComment"];
           [mRequest setDelegate:self];
           [mRequest setTimeOutSeconds:20.0];
           [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
           [mRequest startAsynchronous];
           [[ProgressBar getProgressBar] show:@"正在删除评论..." view:self.mainView];
           [ProgressBar getProgressBar].mDelegate = self;

       }

    }
    else if (liebiaoView.tag == 102) {
        if (buttonIndex == 0)//刷新
        {
            [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
        }
        if (buttonIndex == 1)//删除该微博
        {
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBdelTopic:[[Info getInstance] userId] topicId:mStatus.topicid]];
            [mRequest setUsername:@"delTopic"];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest startAsynchronous];
            [[ProgressBar getProgressBar] show:@"正在删除微博..." view:self.mainView];
            [ProgressBar getProgressBar].mDelegate = self;
        }
    }
    else if (liebiaoView.tag == 103) {
        if (liebiaoView.weixinBool) {
            if (buttonIndex == 2) {   //分享微信
                
                
                [self.CP_navigation markNavigationViewUserName:mStatus.nick_name];
                
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 0) {   //分享新浪微博
                
//                NewPostViewController *publishController = [[NewPostViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.isShare = YES;
//                publishController.publishType = KShareController;
//                publishController.shareTo = @"1";
//                publishController.title = @"分享微博";
//                
//                
//#ifdef isCaiPiaoForIPad
//                [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//                [publishController release];
//#else
//                [self.navigationController pushViewController:publishController animated:YES];
//                [publishController release];
//#endif
//                
                
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];

                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
                [publishController setMStatus: mStatus];
                publishController.infoShare = YES;
                publishController.detailedBool = YES;
//                publishController.microblogType = ShareController;
                publishController.microblogType = ShareController;
                publishController.shareTo = @"1";
                publishController.title = @"分享微博";
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
                [self presentViewController:nav animated: YES completion:nil];
                [publishController release];
                [nav release];
                
                
            }
            else if(buttonIndex == 1){//分享腾讯微博
                
//                NewPostViewController *publishController = [[NewPostViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.isShare = YES;
//                publishController.publishType = KShareController;
//                publishController.shareTo = @"2";
//                publishController.title = @"分享微博";
//                [self.navigationController pushViewController:publishController animated:YES];
//                [publishController release];
                
                
                [self performSelector:@selector(tencentShareFunc) withObject:nil afterDelay:0.3];

                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
                [publishController setMStatus: mStatus];
//                publishController.isShare = YES;
//                publishController.microblogType = ShareController;
                publishController.microblogType = ShareController;
                publishController.detailedBool = YES;
                publishController.shareTo = @"2";
                publishController.title = @"分享微博";
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
                [self presentViewController:nav animated: YES completion:nil];
                [publishController release];
                [nav release];
            }
            
        }
        else {
            if (buttonIndex == 0) {   //分享微信
                
                
                [self.CP_navigation markNavigationViewUserName:mStatus.nick_name];
                
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 1) {   //分享新浪微博
                
//                NewPostViewController *publishController = [[NewPostViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.isShare = YES;
//                publishController.publishType = KShareController;
//                publishController.shareTo = @"1";
//                publishController.title = @"分享微博";
//                
//                
//#ifdef isCaiPiaoForIPad
//                [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//                [publishController release];
//#else
//                [self.navigationController pushViewController:publishController animated:YES];
//                [publishController release];
//#endif
//                
                
//                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.infoShare = YES;
////                publishController.isShare = YES;
////                publishController.microblogType = ShareController;
//                publishController.microblogType = KShareController;
//                
//                caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//                UIImage * screenImage =  [appcaibo imageWithScreenContents];
//                UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//                publishController.mSelectImage = screenImage;
//                publishController.weiBoContent = mStatus.content;
//                
//                publishController.shareTo = @"1";
//                publishController.title = @"分享微博";
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
//                [self presentViewController:nav animated: YES completion:nil];
//                [publishController release];
//                [nav release];
                
//                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];

                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
                [publishController setMStatus: mStatus];
                publishController.infoShare = YES;
//                publishController.isShare = YES;
                publishController.detailedBool = YES;
//                publishController.microblogType = ShareController;
                publishController.microblogType = ShareController;
                
//                caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//                UIImage * screenImage =  [appcaibo imageWithScreenContents];
//                UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//                publishController.mSelectImage = screenImage;
                publishController.weiBoContent = mStatus.content;
                
                publishController.shareTo = @"1";
                publishController.title = @"分享微博";
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
                [self presentViewController:nav animated: YES completion:nil];
                [publishController release];
                [nav release];
//                [self sinaShareFunc];

            }
            else if(buttonIndex == 2){//分享腾讯微博
                
//                NewPostViewController *publishController = [[NewPostViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.isShare = YES;
//                publishController.publishType = KShareController;
//                publishController.shareTo = @"2";
//                publishController.title = @"分享微博";
//                [self.navigationController pushViewController:publishController animated:YES];
//                [publishController release];
                
//                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
//                [publishController setMStatus: mStatus];
//                publishController.infoShare = YES;
////                publishController.isShare = YES;
////                publishController.microblogType = ShareController;
//                publishController.microblogType = KShareController;
//                
//                caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//                UIImage * screenImage =  [appcaibo imageWithScreenContents];
//                UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//                publishController.mSelectImage = screenImage;
//                publishController.weiBoContent = mStatus.content;
//                
//                publishController.shareTo = @"2";
//                publishController.title = @"分享微博";
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
//                [self presentViewController:nav animated: YES completion:nil];
//                [publishController release];
//                [nav release];
                
//                [self performSelector:@selector(tencentShareFunc) withObject:nil afterDelay:0.3];

                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
                [publishController setMStatus: mStatus];
                publishController.infoShare = YES;
                publishController.detailedBool = YES;
//                publishController.isShare = YES;
//                publishController.microblogType = ShareController;
                publishController.microblogType = ShareController;
                
//                caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//                UIImage * screenImage =  [appcaibo imageWithScreenContents];
//                UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//                publishController.mSelectImage = screenImage;
                publishController.weiBoContent = mStatus.content;
                
                publishController.shareTo = @"2";
                publishController.title = @"分享微博";
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
                [self presentViewController:nav animated: YES completion:nil];
                [publishController release];
                [nav release];

            }
        }
        
    }
    
}
- (void)sinaShareFunc{//新浪分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo imageWithScreenContents];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    
    WBMessageObject * messageObject = [WBMessageObject message];
    messageObject.text = [NSString stringWithFormat:@"#投注站#"];
    WBImageObject * imageObject = [WBImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(screenImage, 1);
    messageObject.imageObject = imageObject;
    
    WBSendMessageToWeiboRequest * request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject];
    
    [WeiboSDK sendRequest:request];
}
- (void)tencentShareFunc{//腾讯微博分享
    if ([[[Info getInstance] userId] intValue] == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }else{
        caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
        UIImage * screenImage =  [appcaibo imageWithScreenContents];
        UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.infoShare = YES;
        publishController.microblogType = ShareController;
//        publishController.microblogType = KShareController;
        publishController.shareTo = @"2";
        publishController.title = @"分享微博";
        [publishController setMStatus: mStatus];
        
        publishController.weiBoContent = [NSString stringWithFormat:@"#投注站#"];
        publishController.mSelectImage = screenImage;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        
    }
}

#pragma ----
/****** 顶部刷新条相关 *******/
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView *)view {
	// 设置顶部菜单栏左右两个按钮在更新时为不可用状态
	self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [mRefreshView setState:CBPullRefreshLoading];
    self.dTableView.contentInset = UIEdgeInsetsMake(0, 0.0f, 0.0f, 0.0f);
	
    // 发送获取微博评论接口
    if (actionIndex == ActionOne) {
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:@"1" pageSize:@"20"]]];
        NSLog(@"%@",[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:@"1" pageSize:@"20"]);
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDidFinishSelector:@selector(doneLoadingTableViewData:)];
        [mRequest setDidFailSelector:@selector(requestFailedWithDidLoadedTableViewData:)];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest startAsynchronous];//001
    }
    else{
    [mRequest clearDelegatesAndCancel];
    [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.orignal_id pageNum:@"1" pageSize:@"20"]]];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest setDidFinishSelector:@selector(doneLoadingTableViewData:)];
    [mRequest setDidFailSelector:@selector(requestFailedWithDidLoadedTableViewData:)];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest startAsynchronous];
    }
     // 正在更新数据
    mReloading = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.dTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!topicLoadedEnd){
			if (moreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
				[moreCell spinnerStartAnimating];
                // [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
				[self performSelector:@selector(getMoreComment) withObject:nil afterDelay:.5];
			}
		}
	}	

	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
//    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
}

-(void)doneLoadedTableViewData {
	mReloading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.dTableView];
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    [loadCell.spinner stopAnimating];
    [self autoRefresh];
}

- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view {
	return mReloading;
}

- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view {
	return [NSDate date];
}

- (void) getMoreComment {
    if (actionIndex == ActionOne) {
        
        
        count_plstr = [mStatus.count_pl intValue];
        
//        ++index;
        
        if ([mCommentArray count]%20 > 0 ) {
            index = (int)[mCommentArray count] / 20 + 2;
        }else{
            index = (int)[mCommentArray count] / 20 + 1;
        }
        
        
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:[NSString stringWithFormat:@"%ld", (long)index] pageSize:@"20"]]];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
        [mRequest startAsynchronous];
    }
    if (actionIndex == ActionTwo) {
        if ([mCommentArray count] % 20 > 0) {
            indexTwo = (int)[mCommentArray count] / 20 + 2;
        }else{
            indexTwo = (int)[mCommentArray count] / 20 + 1;
        }
        
        
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.orignal_id pageNum:[NSString stringWithFormat:@"%ld", (long)indexTwo] pageSize:@"20"]]];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
        [mRequest startAsynchronous];
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
}
- (void) moreDataFinished:(ASIHTTPRequest*)request {
    [loadCell.spinner stopAnimating];
    mReloading = NO;
    NSString *responseString = [request responseString];
    
    TopicComment *list = [[TopicComment alloc] init];
    if (mCommentArray) {
       
        if ([[list arrayWithParse:responseString] count] > 0) {
             [mCommentArray addObjectsFromArray:[list arrayWithParse:responseString]];
            if ([[list arrayWithParse:responseString] count] < 20) {
                [moreCell setType:MSG_TYPE_LOAD_NODATA];
                topicLoadedEnd = YES;
            }
        }else{
            [moreCell setType:MSG_TYPE_LOAD_NODATA];
            topicLoadedEnd = YES;
        }
    }else {
        [moreCell setType:MSG_TYPE_LOAD_NODATA];
        topicLoadedEnd = YES;
       
    }

    [list release];
    [self.dTableView reloadData];
    [moreCell spinnerStopAnimating];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
}

#pragma mark_
#pragma mark CP_lieBiaoDelegate

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
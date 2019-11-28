//
//  ProfileViewController.m
//  caibo
//
//  Created by Kiefer on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
//  yao
#import "ProfileViewController.h"
#import "Info.h"
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "SBJSON.h"
#import "ProfileTabBarController.h"
#import "NewPostViewController.h"
#import "YtTopic.h"
#import "ProgressBar.h"
#import "caiboAppDelegate.h"
#import "RedactPrivLetterController.h"
#import "JSON.h"
#import "YDDebugTool.h"
#import "MyLottoryViewController.h"
#import "CP_PTButton.h"
#import "MyProfileTableViewCell.h"
//#import "MyProfileWCTableViewCell.h"
#import "FlagRuleViewController.h"
#import "SendMicroblogViewController.h"


#define HEADER_HEIGHT 23

@implementation ProfileViewController

@synthesize mTableView;
@synthesize btnRefresh;
@synthesize btnAdd;
@synthesize btnSendMsg;
@synthesize btnAddressList;
@synthesize himNickName;

@synthesize cb_GetUserInfo;
@synthesize cb_AttUser;// 添加关注
@synthesize cb_CancelAtt;// 取消关注
@synthesize cb_AddBlackUser;// 添加黑名单
@synthesize cb_DelBlackUser;// 解除黑名单
@synthesize cb_GetBlackRelation;
@synthesize cb_GetRelation;
@synthesize relation;
@synthesize homebool;

@synthesize mUserInfo;

@synthesize all365AccountArray;

//@synthesize getFlagItemRequest;
//@synthesize winningList;
//@synthesize myRequest;
static BOOL isBlack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {

        [self parameterInit];
        [self.navigationItem setHidesBackButton:NO];
       // [self.navigationItem setTitle:(@"他的资料")];
        
        titleArray = [[NSArray alloc] initWithObjects:@[@"他的彩票",@"他的合买"],@[@"@他",@"发私信"], nil];
        iconNameArray = [[NSArray alloc] initWithObjects:@[@"wb_mycp.png",@"wb_myhm.png"],@[@"wb_atHim.png",@"wb_mesHim.png"], nil];
    }
    return self;
}

- (void)dealloc
{
    YD_FUNNAME;
    YD_LOGFUN;
    
    [mActivityIV stopAnimating];
    [mActivityIV release];
    
    [cb_GetUserInfo clearDelegatesAndCancel];
    self.cb_GetUserInfo = nil;
    
    [cb_AttUser clearDelegatesAndCancel];
    self.cb_AttUser = nil;
    
    [cb_CancelAtt clearDelegatesAndCancel];
    self.cb_CancelAtt = nil;
    
    [cb_AddBlackUser clearDelegatesAndCancel];
    self.cb_AddBlackUser = nil;
    
    [cb_DelBlackUser clearDelegatesAndCancel];
    self.cb_DelBlackUser = nil;
    
    [cb_GetBlackRelation clearDelegatesAndCancel];
    self.cb_GetBlackRelation = nil;
    
    [cb_GetRelation clearDelegatesAndCancel];
    self.cb_GetRelation = nil;
    
    [all365AccountArray release];
    [headView release];
    [lbNickName release];
	self.relation = nil;
    [mTableView release];
    [btnRefresh release];
    [btnAdd release];
    [btnSendMsg release];
    [btnAddressList release];
    
    [btnRelAtt release];
    [btnRelCancelAtt release];
    [btnRelDelBlack release];
    
    [btnAddBlackUser release];
    [btnDelBlackUser release];
    
    [cancelAttAS release];
    [addBlackUserAS release];
    [delBlackUserAS release];
    [himNickName release];
    
    [mUserInfo release];
    [[Info getInstance] setHimId:nil];
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:headImageUrl];
    [headImageUrl release];
    [receiver release];
    
    [mProgressBar release];
    
    [titleArray release];
    [iconNameArray release];
    
//    [getFlagItemRequest clearDelegatesAndCancel];
//    self.getFlagItemRequest = nil;
    
//    [flagsArray release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated{

    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
}


// 界面初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor blackColor];
    is365Account = NO;
    
    UIImageView * backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    backi.userInteractionEnabled = YES;
    [self.mainView addSubview:backi];
    [backi release];
    
#ifdef isCaiPiaoForIPad
    [self loadingIpadView];
    
#else
    [self loadingIphone];
#endif
}


#pragma mark - View lifecycle


- (void)loadingIphone{
    self.CP_navigation.title = @"TA的资料";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths objectAtIndex:0];
	NSString *txtPath = [path stringByAppendingPathComponent:@"all365Account.txt"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:txtPath])
    {
        NSData *txtData =[[NSFileManager defaultManager] contentsAtPath:txtPath];
        if(txtData && txtData.length)
        {
            NSString *txtString = [[NSString alloc] initWithData:txtData encoding:NSUTF8StringEncoding];
            self.all365AccountArray = [txtString componentsSeparatedByString:@","];
            [txtString release];
        }
        
    }
    
    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(doPushHomeView) ImageName:nil Size:CGSizeMake(70,30)];
    
    headBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
    headBG.backgroundColor = [UIColor whiteColor];
    headBG.hidden = NO;
    headBG.userInteractionEnabled = YES;
    [self.mainView addSubview:headBG];
    [headBG release];
    

    headView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"defaulUserImage.png")];
    [headView setFrame:CGRectMake(12, 12 ,40, 40)];
    [headView.layer setMasksToBounds:YES]; // 设置圆角边框
    [headView.layer setCornerRadius:5];
    [headBG addSubview:headView];
    
    lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(headView)+15, 20, 150, 25)];
    lbNickName.text = mUserInfo.nick_name;
    lbNickName.backgroundColor = [UIColor clearColor];
    lbNickName.textColor = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    lbNickName.font = [UIFont boldSystemFontOfSize:15];
    [headBG addSubview:lbNickName];
    
    btnRelAtt = [[UIButton alloc] initWithFrame:CGRectMake(230, 17, 77, 30)];
    [btnRelAtt setImage:UIImageGetImageFromName(@"wb_addgz.png") forState:UIControlStateNormal];
    [btnRelAtt setHidden:YES];
    [btnRelAtt addTarget:self action:@selector(doAttUser) forControlEvents:UIControlEventTouchUpInside];
    [headBG addSubview:btnRelAtt];

    
    btnRelCancelAtt = [[UIButton alloc] initWithFrame:CGRectMake(230, 17, 77, 30)];
    [btnRelCancelAtt setImage:UIImageGetImageFromName(@"wb_cancelgz.png") forState:UIControlStateNormal];
    [btnRelCancelAtt setHidden:YES];
    [btnRelCancelAtt addTarget:self action:@selector(doCancelAtt) forControlEvents:UIControlEventTouchUpInside];
    [headBG addSubview:btnRelCancelAtt];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(headBG), 320, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
    [self.mainView addSubview:line];
    [line release];
    
    
    
    [btnRefresh addTarget:self action:@selector(doRefresh) forControlEvents:(UIControlEventTouchUpInside)];
    [btnAdd addTarget:self action:@selector(doAdd) forControlEvents:(UIControlEventTouchUpInside)];
    btnSendMsg.enabled = NO;
    [btnSendMsg addTarget:self action:@selector(doSendMsg) forControlEvents:(UIControlEventTouchUpInside)];
    
    middleView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line), 320, 55)];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.hidden = YES;
    [self.mainView addSubview:middleView];
    [middleView release];
    
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(0, 0, 107, 55);
    [weiboBtn addTarget:self action:@selector(pushBlogView) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:weiboBtn];
    
    weiboCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 107, 18)];
    weiboCount.text = mUserInfo.topicsize;
    weiboCount.userInteractionEnabled = NO;
    weiboCount.backgroundColor = [UIColor clearColor];
    weiboCount.textAlignment = NSTextAlignmentCenter;
    weiboCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    weiboCount.font = [UIFont systemFontOfSize:18];
    [weiboBtn addSubview:weiboCount];
    [weiboCount release];
    
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(weiboCount)+5, 107, 12)];
    weiboLabel.text = @"微博";
    weiboLabel.userInteractionEnabled = NO;
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = [UIFont systemFontOfSize:12];
    weiboLabel.backgroundColor = [UIColor clearColor];
    weiboLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [weiboBtn addSubview:weiboLabel];
    [weiboLabel release];
    
    
    //关注
    UIButton *guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanzhuBtn.frame = CGRectMake(107, 0, 107, 55);
    [guanzhuBtn addTarget:self action:@selector(pushAttentionView) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:guanzhuBtn];
    
    guanzhuCount = [[UILabel alloc] initWithFrame:CGRectMake(0,10 , 107, 18)];
    guanzhuCount.text = mUserInfo.attention;
    guanzhuCount.textAlignment = NSTextAlignmentCenter;
    guanzhuCount.backgroundColor = [UIColor clearColor];
    guanzhuCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    guanzhuCount.font = [UIFont systemFontOfSize:18];
    [guanzhuBtn addSubview:guanzhuCount];
    [guanzhuCount release];
    
    
    UILabel *guanzhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(guanzhuCount)+5, 107, 12)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.textAlignment = NSTextAlignmentCenter;
    guanzhuLabel.font = [UIFont systemFontOfSize:12];
    guanzhuLabel.backgroundColor = [UIColor clearColor];
    guanzhuLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [guanzhuBtn addSubview:guanzhuLabel];
    [guanzhuLabel release];
    
    
    //粉丝
    UIButton *fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fansBtn.frame = CGRectMake(214, 0, 107, 55);
    [fansBtn addTarget:self action:@selector(pushFansView) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:fansBtn];
    
    
    fensiCount = [[UILabel alloc] initWithFrame:CGRectMake(0,10 , 107, 18)];
    fensiCount.text = mUserInfo.fans;
    fensiCount.textAlignment = NSTextAlignmentCenter;
    fensiCount.backgroundColor = [UIColor clearColor];
    fensiCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    fensiCount.font = [UIFont systemFontOfSize:18];
    [fansBtn addSubview:fensiCount];
    [fensiCount release];
    
    UILabel *fensiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(fensiCount)+5, 107, 12)];
    fensiLabel.text = @"粉丝";
    fensiLabel.textAlignment = NSTextAlignmentCenter;
    fensiLabel.font = [UIFont systemFontOfSize:12];
    fensiLabel.backgroundColor = [UIColor clearColor];
    fensiLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [fansBtn addSubview:fensiLabel];
    [fensiLabel release];

    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(middleView), 320, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
    [self.mainView addSubview:line1];
    [line1 release];
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line1)+10, 320, self.mainView.frame.size.height - 49) style:UITableViewStylePlain];
    [mTableView setHidden:YES];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.scrollEnabled = NO;
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:mTableView];
    
    isBlack = FALSE;
    mProgressBar = [[ProgressBar getProgressBar] retain];
    [mActivityIV setHidesWhenStopped:YES];
    [mActivityIV setHidden:YES];
    
    [self changeBlackBtn:btnAddBlackUser];
    if (!mUserInfo) {
		[self doSendRequest];
	}
	else {
		if (isBlack == YES) {
			[self changeRelBtn:btnRelDelBlack];
			[self changeBlackBtn:btnDelBlackUser];
		}
		
		if ([relation isEqualToString:@"0"]) // 未关注
		{
			if (!isBlack)
			{
				[self changeRelBtn:btnRelAtt];
			}
		}
		else if([relation isEqualToString:@"1"]) // 已关注
		{
			if (!isBlack)
			{
				[self changeRelBtn:btnRelCancelAtt];
			}
		}
		else if([relation isEqualToString:@"2"]) // 相互关注
		{
			if (!isBlack)
			{
				btnSendMsg.enabled = YES;
				[self changeRelBtn:btnRelCancelAtt];
			}
		}
		[btnRelation setHidden:NO];
		if (mUserInfo.big_image)
		{
			if (!receiver) {
				receiver = [[ImageStoreReceiver alloc] init];
			}
			receiver.imageContainer = self;
			[self fetchHeadImage:[Info strFormatWithUrl:mUserInfo.big_image]];
		}
		
		[mTableView reloadData];
		[mTableView setHidden:NO];
	}

}



- (void)loadingIpadView{
    self.CP_navigation.title = @"资料";
  
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, 44, 768, 1024);
    UIImageView *backImage1 = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage1.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage1.userInteractionEnabled = YES;
    backImage1.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:backImage1];
    [backImage1 release];
#ifndef isCaiPiaoForIPad
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb61.png");
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
#endif
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(35, 49, 320, self.mainView.frame.size.height) style:UITableViewStyleGrouped];
    //[mTableView setContentSize:CGSizeMake(320, 480)];
    [mTableView setHidden:YES];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.mainView addSubview:mTableView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	self.mTableView.backgroundView = backImage;
    [backImage release];
    
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(35, 0, 320, 50)];
    headV.backgroundColor = [UIColor clearColor];
    headV.userInteractionEnabled = YES;
    [self.mainView addSubview:headV];
    
    headBG = [[UIImageView alloc] initWithFrame:headV.bounds];
    headBG.backgroundColor = [UIColor whiteColor];
    headBG.userInteractionEnabled = YES;
    [headV addSubview:headBG];
    [headBG release];
    
    headView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"defaulUserImage.png")];
    [headView setBounds:CGRectMake(0, 0, 45, 45)];
    [headView setCenter:CGPointMake(40, 25)];
    [headView.layer setMasksToBounds:YES]; // 设置圆角边框
    [headView.layer setCornerRadius:2];
    [headView.layer setBorderWidth:1];
    [headView.layer setBorderColor:[UIColor grayColor].CGColor];
    [headBG addSubview:headView];
    
    lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 150, 30)];
    lbNickName.text = mUserInfo.nick_name;
    //[lbNickName setText:mUserInfo.nick_name];
    lbNickName.backgroundColor = [UIColor clearColor];
    lbNickName.font = [UIFont boldSystemFontOfSize:15];
    [headBG addSubview:lbNickName];
    
    btnRelAtt = [[CP_PTButton alloc] initWithFrame:CGRectMake(230, 10, 76, 30)];
    [btnRelAtt setImage:UIImageGetImageFromName(@"wb_addgz.png") forState:UIControlStateNormal];
    
    [btnRelAtt addTarget:self action:@selector(doAttUser) forControlEvents:UIControlEventTouchUpInside];
    // [headBG addSubview:btnRelAtt];
    //
    btnRelCancelAtt = [[CP_PTButton alloc] initWithFrame:CGRectMake(230, 10, 76, 30)];
    [btnRelCancelAtt setImage:UIImageGetImageFromName(@"wb_cancelgz.png") forState:UIControlStateNormal];
    [btnRelCancelAtt addTarget:self action:@selector(doCancelAtt) forControlEvents:UIControlEventTouchUpInside];
    // [headBG addSubview:btnRelCancelAtt];
    
    
    [btnRefresh addTarget:self action:@selector(doRefresh) forControlEvents:(UIControlEventTouchUpInside)];
    [btnAdd addTarget:self action:@selector(doAdd) forControlEvents:(UIControlEventTouchUpInside)];
    btnSendMsg.enabled = NO;
    [btnSendMsg addTarget:self action:@selector(doSendMsg) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    isBlack = FALSE;
    mProgressBar = [[ProgressBar getProgressBar] retain];
    [mActivityIV setHidesWhenStopped:YES];
    [mActivityIV setHidden:YES];
    
    [self changeBlackBtn:btnAddBlackUser];
    if (!mUserInfo) {
		[self doSendRequest];
	}
	else {
		if (isBlack == YES) {
			[self changeRelBtn:btnRelDelBlack];
			[self changeBlackBtn:btnDelBlackUser];
		}
		
		if ([relation isEqualToString:@"0"]) // 未关注
		{
			if (!isBlack)
			{
				[self changeRelBtn:btnRelAtt];
			}
		}
		else if([relation isEqualToString:@"1"]) // 已关注
		{
			if (!isBlack)
			{
				[self changeRelBtn:btnRelCancelAtt];
			}
		}
		else if([relation isEqualToString:@"2"]) // 相互关注
		{
			if (!isBlack)
			{
				btnSendMsg.enabled = YES;
				[self changeRelBtn:btnRelCancelAtt];
			}
		}
		[btnRelation setHidden:NO];
		if (mUserInfo.big_image)
		{
			if (!receiver) {
				receiver = [[ImageStoreReceiver alloc] init];
			}
			receiver.imageContainer = self;
			[self fetchHeadImage:[Info strFormatWithUrl:mUserInfo.big_image]];
		}
		
		[mTableView reloadData];
		[mTableView setHidden:NO];
	}
    
    [headV release];


}



- (void)viewDidUnload
{
    [super viewDidUnload];
    headView= nil;
	mTableView = nil;
	btnSendMsg= nil;
	btnRefresh= nil;
	btnRelAtt= nil;
	btnRelCancelAtt= nil;
	btnRelDelBlack= nil;
	btnAddBlackUser= nil;
	btnDelBlackUser= nil;
	btnBlackList= nil;
    [mProgressBar release]; mProgressBar = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// 参数初始化
- (void)parameterInit
{
    //headImage = [UIImage imageNamed:@"defaulUserImage.png"];
    userId = [[Info getInstance] userId];
    himId = [[Info getInstance] himId];

}

// 返回
- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
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

// 发送请求
- (void)doSendRequest
{
    [cb_GetUserInfo clearDelegatesAndCancel];
    [self setCb_GetUserInfo:[ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:himId]]];
    [cb_GetUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [cb_GetUserInfo setDelegate:self];
    [cb_GetUserInfo setTimeOutSeconds:10];
    [cb_GetUserInfo setDidFinishSelector:@selector(reqGetUserInfoFinished:)];
    [cb_GetUserInfo startAsynchronous];
    
    YD_LOG(@"himId = 1%@1", himId);
    NSLog(@"himid = %@", himId);
    YD_LOGFUN;
    
    [cb_GetUserInfo clearDelegatesAndCancel];
    NSLog(@"url = %@",[NetURL CBgetUserInfoWithUserId:(himId)]);
    if ([himId intValue]!=0)
    {printf("\n...himid\n");
        self.cb_GetUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:(himId)]];
        [cb_GetUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [cb_GetUserInfo setDelegate:self];
        [cb_GetUserInfo setDidFinishSelector:@selector(reqGetUserInfoFinished:)];
        [cb_GetUserInfo startAsynchronous];
        
        [mActivityIV setHidden:NO];
        [mActivityIV startAnimating];
    }
    else if (himNickName)
    {printf("\n...himNickName\n");
        self.cb_GetUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithNickName:(himNickName)]];
        [cb_GetUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [cb_GetUserInfo setDelegate:self];
        [cb_GetUserInfo setDidFinishSelector:@selector(reqGetUserInfoFinished:)];
        [cb_GetUserInfo startAsynchronous];
        
        [mActivityIV setHidden:NO];
        [mActivityIV startAnimating];
    }
}

- (void)pressWriteButton:(UIButton *)sender{
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];

}

#pragma mark -
#pragma mark 实现UITableViewDataSource接口


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(is365Account){
    
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1){
    
        UIView *headerview= [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
        headerview.backgroundColor = [UIColor clearColor];
        return headerview;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *CellIdentifier = @"Cell";
        
        MyProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[[MyProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        if (is365Account) {
            cell.titleLabel.text = [[titleArray objectAtIndex:1] objectAtIndex:indexPath.row];
            cell.iconImageView.image = UIImageGetImageFromName([[iconNameArray objectAtIndex:1] objectAtIndex:indexPath.row]);
            if (indexPath.row == 1) {
                cell.bottomLine.hidden = NO;
            }
        }else{
            cell.titleLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.iconImageView.image = UIImageGetImageFromName([[iconNameArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
            if (indexPath.row == [[iconNameArray objectAtIndex:indexPath.section] count] - 1) {
                cell.bottomLine.hidden = NO;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

}




#pragma mark -
#pragma mark 实现UITableViewDelegate接口

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(is365Account)
    {
        if(indexPath.row == 0)
            [self doAdd];
        else if(indexPath.row == 1)
            [self doSendMsg];
    }
    else
    {
        if(indexPath.section == 0){
            if (indexPath.row == 0) {
                [self Tadecaipiao];
            }
            if(indexPath.row == 1){
                [self Tadehemai];
            }
        }
        if(indexPath.section == 1){
            if (indexPath.row == 0) {
                [self doAdd];
            }
            if(indexPath.row == 1){
                [self doSendMsg];
            }
        }

    }
}

#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

- (void)reqGetUserInfoFinished:(ASIHTTPRequest *)request
{
    YD_LOGFUN;
	NSString *responseStr = [request responseString];
 //   NSString * uid = [di objectForKey:@"id"];
    NSLog(@"request = %@", [responseStr JSONValue]);
    NSDictionary * responseDic = [responseStr JSONValue];
    
    if (![responseStr isEqualToString:@"fail"]) 
    {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        self.mUserInfo = userInfo;
        
        userName = [[responseDic valueForKey:@"user_name"] copy];
        nickName = [[responseDic valueForKey:@"nick_name"] copy];
        
        NSString *mutableNickName = self.mUserInfo.nick_name;
        mutableNickName = [mutableNickName stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([all365AccountArray containsObject:mutableNickName])
        {
            NSLog(@"查看的账户为365官方账户");
            is365Account = YES;
            mTableView.frame = CGRectMake(0, ORIGIN_Y(headBG)+0.5+10, 320, self.mainView.frame.size.height-49);
        }
        else{
        
            middleView.hidden = NO;

        }
        
        
        [userInfo release];
        if (!userInfo) {
			[Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
			return;
		}
        himId = mUserInfo.userId;
   
        if(!is365Account)
        {
            
            weiboCount.text = mUserInfo.topicsize;
            guanzhuCount.text = mUserInfo.attention;
            fensiCount.text = mUserInfo.fans;

        }
        
        [cb_GetBlackRelation clearDelegatesAndCancel];
        self.cb_GetBlackRelation = [ASIHTTPRequest requestWithURL:[NetURL CBgetBlackRelation:userId himId:himId]];
        [cb_GetBlackRelation setDefaultResponseEncoding:NSUTF8StringEncoding];
        [cb_GetBlackRelation setDelegate:self];
        [cb_GetBlackRelation setDidFinishSelector:@selector(reqGetBlackRelFinished:)];
        [cb_GetBlackRelation startAsynchronous];
        
    }
}

//- (void)getFlagItemRequestFinished:(ASIHTTPRequest *)request
//{
//    NSString *responseStr = [request responseString];
//    if ([responseStr length] && ![responseStr isEqualToString:@"fail"]) {
//        NSDictionary * dic = [responseStr JSONValue];
//        if ([[dic valueForKey:@"code"] isEqualToString:@"0000"]) {
//            flagsArray = [[NSArray alloc] initWithArray:[[dic valueForKey:@"myFlag"] componentsSeparatedByString:@","]];
//            [mTableView reloadData];
//        }else{
//            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[dic valueForKey:@"msg"] delegate:self cancelButtonTitle:@"我知道了 T. T" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//        }
//    }
//}

- (void)reqGetBlackRelFinished:(ASIHTTPRequest *)request
{
	NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if(dic)
        {
            NSString *resultStr = [[dic valueForKey:@"result"] stringValue];
            if (![resultStr isEqualToString:@"fail"]) 
            {
                NSInteger resultInt = [[dic valueForKey:@"result"] intValue];
                if (resultInt == 1) 
                {
                    [self changeRelBtn:btnRelDelBlack];
                    [self changeBlackBtn:btnDelBlackUser];
                    isBlack = YES;
                }
            }
        }
        [jsonParse release];
        
        YD_LOGFUN;
        [cb_GetRelation clearDelegatesAndCancel];
        self.cb_GetRelation = [ASIHTTPRequest requestWithURL:[NetURL CBgetRelationByUserId:(userId) himId:(himId)]];
        [cb_GetRelation setDefaultResponseEncoding:NSUTF8StringEncoding];
        [cb_GetRelation setDelegate:self];
        [cb_GetRelation setDidFinishSelector:@selector(reqCbGetRelationFinished:)];
        [cb_GetRelation startAsynchronous];
    }
}

// 图片下载完成后回调更新图片
- (void)updateImage:(UIImage*)image {
    [headView setImage:image];
}

// 获取图片
- (void) fetchHeadImage:(NSString *) url {
    if (headImageUrl != url) {
        [headImageUrl release];
    }
    headImageUrl = [url copy];
    
    UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : url Delegate:receiver Big:NO];
    [headView setImage:image];
	
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.frame = CGRectMake(0, 0, 0, 0);
	[imageView setImage: UIImageGetImageFromName(@"V.png")];
	imageView.backgroundColor = [UIColor clearColor];
	
	if ([mUserInfo.vip intValue] == 1) {
		imageView.frame = CGRectMake(48, 47, 14, 14);
	}
	else if([mUserInfo.vip intValue] == 0){
		imageView.frame = CGRectMake(0, 0, 0, 0);
	}
	
	[self.mainView addSubview: imageView];
	[imageView release];
	
}

- (void)reqCbGetRelationFinished:(ASIHTTPRequest *)request
{
    [mActivityIV stopAnimating];
    
	NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if(dic)
        {
            self.relation = [dic valueForKey:@"relation"];
            YD_LOG(@"relation = %@", relation);
            if ([relation isEqualToString:@"0"]) // 未关注
            {
                if (!isBlack) 
                {
                    [self changeRelBtn:btnRelAtt];
                }
            }
            else if([relation isEqualToString:@"1"]) // 已关注
            {
                if (!isBlack) 
                {
                    [self changeRelBtn:btnRelCancelAtt];
                }
            }
            else if([relation isEqualToString:@"2"]) // 相互关注
            {
                if (!isBlack) 
                {
                    [btnRelAtt setHidden:YES];

                    [self changeRelBtn:btnRelCancelAtt];
                }
            }
            [btnRelation setHidden:NO];
        }
        [jsonParse release];
        
        if (mUserInfo) 
        {
            if (mUserInfo.big_image) 
            {
                receiver = [[ImageStoreReceiver alloc] init];
                receiver.imageContainer = self;
                [self fetchHeadImage:[Info strFormatWithUrl:mUserInfo.big_image]];
            }
            
            [lbNickName setText:mUserInfo.nick_name];
            
            [mTableView reloadData];
            [mTableView setHidden:NO];
        }
    }
}

- (void)reqAttUser:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(dismissProgressBar)
                                       userInfo:nil
                                        repeats:NO];
        
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                [self changeRelBtn:btnRelCancelAtt];
                
                [btnRelation setHidden:NO];

            }
        }
        [jsonParse release];
    }
}

- (void)reqCancelAttUser:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(dismissProgressBar)
                                       userInfo:nil
                                        repeats:NO];
        
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                [self changeRelBtn:btnRelAtt];
                
                [btnRelation setHidden:NO];

            }
        }
        [jsonParse release];
    }
}

- (void)reqAddBlackUser:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(dismissProgressBar)
                                       userInfo:nil
                                        repeats:NO];
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                [self changeRelBtn:btnRelDelBlack];
                [self changeBlackBtn:btnDelBlackUser];
                [mProgressBar setTitle:@"已添加黑名单"];
            }
        }
        [jsonParse release];
    }
}

- (void)reqDelBlackUser:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(dismissProgressBar)
                                       userInfo:nil
                                        repeats:NO];
        
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                [self changeBlackBtn:btnAddBlackUser];
                [self changeRelBtn:btnRelAtt];
                [mProgressBar setTitle:@"解除成功"];
            }
        }
        [jsonParse release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	YD_LOG(@"error is %@", error);
	if(error)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" 
                                                        message:@"网络有错误" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

#pragma mark -
#pragma mark 实现UIActionSheetDelegate接口

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    
    YD_LOGFUN;
    if ([cancelAttAS isEqual:actionSheet]) 
    {
        if (buttonIndex == actionSheet.firstOtherButtonIndex) 
        {
            
            [mProgressBar show:@"正在取消关注此人..." view:(self.mainView)];
            mProgressBar.mDelegate = self;
            
            [cb_CancelAtt clearDelegatesAndCancel];
            self.cb_CancelAtt = [ASIHTTPRequest requestWithURL:[NetURL CBcancelAttention:userId attUserId:himId]];
            [cb_CancelAtt setDefaultResponseEncoding:NSUTF8StringEncoding];
            [cb_CancelAtt setDelegate:self];
            [cb_CancelAtt setDidFinishSelector:@selector(reqCancelAttUser:)];
            [cb_CancelAtt startAsynchronous];
        } 
    }
    else if([addBlackUserAS isEqual:actionSheet])
    {
        if (buttonIndex == actionSheet.destructiveButtonIndex) 
        {
            [mProgressBar show:@"正在添加到黑名单..." view:(self.mainView)];
            mProgressBar.mDelegate = self;
            
            [cb_AddBlackUser clearDelegatesAndCancel];
            self.cb_AddBlackUser = [ASIHTTPRequest requestWithURL:[NetURL CBsaveBlackUser:userId taUserId:himId]];
            [cb_AddBlackUser setDefaultResponseEncoding:NSUTF8StringEncoding];
            [cb_AddBlackUser setDelegate:self];
            [cb_AddBlackUser setDidFinishSelector:@selector(reqAddBlackUser:)];
            [cb_AddBlackUser startAsynchronous];
        }
    }
    else if([delBlackUserAS isEqual:actionSheet])
    {
        if (buttonIndex == actionSheet.firstOtherButtonIndex)
        {
            [mProgressBar show:@"正在从黑名单移除..." view:(self.mainView)];
            mProgressBar.mDelegate = self;
            
            [cb_DelBlackUser clearDelegatesAndCancel];
            self.cb_DelBlackUser = [ASIHTTPRequest requestWithURL:[NetURL CBdeleteBlackUser:userId taUserId:himId]];
            [cb_DelBlackUser setDefaultResponseEncoding:NSUTF8StringEncoding];
            [cb_DelBlackUser setDelegate:self];
            [cb_DelBlackUser setDidFinishSelector:@selector(reqDelBlackUser:)];
            [cb_DelBlackUser startAsynchronous];
        }
    }
}

#pragma mark -
#pragma mark UITableView中间4个按钮
// 关注
- (void)pushAttentionView
{
//	ProfileTabBarController *controller = [[ProfileTabBarController alloc] initwithUerself:NO userID:himId];
	//[controller setSelectedIndex:3];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
        NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
        [dic setValue:@"0" forKey:@"gz"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
    }
    
   
    
    AttentionViewController *controller= [[AttentionViewController alloc] init];
    controller.ishome = homebool;
    controller.userID = himId;
	controller.title = @"他的关注";
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

// 微博
- (void)pushBlogView
{
	//ProfileTabBarController *controller = [[ProfileTabBarController alloc] initwithUerself:NO userID:himId];
	//[controller setSelectedIndex:0];
    TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
    controller.userID = himId;
	controller.title = @"他的动态";
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

// 粉丝
- (void)pushFansView
{
	//ProfileTabBarController *controller = [[ProfileTabBarController alloc] initwithUerself:NO userID:himId];
	//[controller setSelectedIndex:2];
    FansViewController *controller = [[FansViewController alloc] init];
    
	
    controller.userID = himId;

	controller.navigationItem.title = @"粉丝";
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

// 话题
- (void)pushTopicView
{
	ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:himId];
	[controller setSelectedIndex:1];
	controller.navigationItem.title = @"话题";
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

#pragma mark - 
#pragma mark 底部bar5个按钮
// 刷新
- (void)doRefresh
{
    [self doSendRequest];
}
- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = mUserInfo.user_name;
    my.nickName = mUserInfo.nick_name;
    my.userid = mUserInfo.userId;
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = mUserInfo.user_name;
    my2.nickName = mUserInfo.nick_name;
    my2.userid = mUserInfo.userId;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"他的彩票"];
    [labearr addObject:@"他的合买"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaihemaibai.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"tabbg_hemai.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
//    tabc.delegateCP = self;
    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my release];
}


//他的彩票
-(void)Tadecaipiao
{

    [self otherLottoryViewController:0];
}
//他的合买
-(void)Tadehemai
{

    [self otherLottoryViewController:1];
}

// @他
- (void)doAdd
{
    if (mUserInfo) 
    {
#ifdef isCaiPiaoForIPad
        YtTopic *topic = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:mUserInfo.nick_name];
        [mTempStr appendString:@" "];
        topic.nick_name = mTempStr;
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic];
        [topic release];
        
#else
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.publishType = kNewTopicController;// 自发彩博
//        YtTopic *topic = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:mUserInfo.nick_name];
//        [mTempStr appendString:@" "];
//        topic.nick_name = mTempStr;
//        publishController.mStatus = topic;
//        [self.navigationController pushViewController:publishController animated:YES];
////        [navController release];
//        [publishController release];
//        [self.navigationController setNavigationBarHidden:YES];
        
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;// 自发彩博
        YtTopic *topic = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:mUserInfo.nick_name];
        [mTempStr appendString:@" "];
        topic.nick_name = mTempStr;
        publishController.mStatus = topic;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        [topic release];
        [mTempStr release];

        
#endif
    }
}

// 发送私信
- (void)doSendMsg
{
    RedactPrivLetterController *view = [[RedactPrivLetterController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:view];
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }

    navController.navigationBarHidden = YES;
    if (navController) {
#ifdef isCaiPiaoForIPad
        [self.navigationController pushViewController:view animated:YES];
#else
        [self presentViewController:navController animated: YES completion:nil];
#endif
        
        if (lbNickName.text && himId) {
            if ([view respondsToSelector:@selector(friendsViewDidSelectFriend:)]) {
                NSMutableString *textBuffer = [[NSMutableString alloc] init];
                [textBuffer appendString:lbNickName.text];
                [textBuffer appendString:@":"];
                [textBuffer appendString:himId];
                [view performSelector:@selector(friendsViewDidSelectFriend:) withObject:textBuffer];
                [textBuffer release];
            }
        }
    }
    [navController release];
    [view release];
    [self.navigationController setNavigationBarHidden:YES];
}

// 通讯录 第一视频要求跳到资料页
- (void)doAddressList
{
    
}

#pragma mark -
#pragma mark 关注和取消关注
// 关注
- (void)doAttUser
{
    [mProgressBar show:@"正在关注此人..." view:self.mainView];
    mProgressBar.mDelegate = self;
    
    [cb_AttUser clearDelegatesAndCancel];
    self.cb_AttUser = [ASIHTTPRequest requestWithURL:[NetURL CBsaveAttention:userId attUserId:himId]];
    [cb_AttUser setDefaultResponseEncoding:NSUTF8StringEncoding];
    [cb_AttUser setDelegate:self];
    [cb_AttUser setDidFinishSelector:@selector(reqAttUser:)];
    [cb_AttUser startAsynchronous];
}

// 取消关注
- (void)doCancelAtt
{

    [mProgressBar show:@"正在取消关注此人..." view:(self.mainView)];
    mProgressBar.mDelegate = self;
    
    [cb_CancelAtt clearDelegatesAndCancel];
    self.cb_CancelAtt = [ASIHTTPRequest requestWithURL:[NetURL CBcancelAttention:userId attUserId:himId]];
    [cb_CancelAtt setDefaultResponseEncoding:NSUTF8StringEncoding];
    [cb_CancelAtt setDelegate:self];
    [cb_CancelAtt setDidFinishSelector:@selector(reqCancelAttUser:)];
    [cb_CancelAtt startAsynchronous];
    
}

// 关闭进度条
- (void) dismissProgressBar
{
    if (mProgressBar) 
    {
        [mProgressBar dismiss];
    }
}

// 添加黑名单
- (void)doAddBlackUser
{
    if (mUserInfo) 
    {
        NSMutableString *titleStr = [[NSMutableString alloc] init];
        [titleStr appendString:@"确定 “"];
        [titleStr appendString:mUserInfo.nick_name];
        [titleStr appendString:@"” 加入到黑名单吗？\n\n你和她将自动解除关注关系，并且她不能再关注你，她不能再给你发评论、私信、@通知" ];
        
        addBlackUserAS = [[UIActionSheet alloc] initWithTitle:titleStr
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:@"加入黑名单"
                                            otherButtonTitles:nil];
        [addBlackUserAS showInView:self.mainView];
        
        [titleStr release];
    }
}

// 解除黑名单
- (void)doDelBlackUser
{
    NSString *titleStr = @"确定将此用户从你的黑名单中解除吗？"; 
    
    delBlackUserAS = [[UIActionSheet alloc] initWithTitle:titleStr
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:@"解除黑名单", nil];
    [delBlackUserAS showInView:self.mainView];
}

// 改变关系按钮
- (void)changeRelBtn:(UIButton*)button
{
    if (btnRelation) 
    {
        [btnRelation removeFromSuperview];
    }
    NSLog(@"123123123123123123123123123123");
    btnRelation = button;
    [self.mainView addSubview:btnRelation];
}

// 改变黑名单按钮
- (void)changeBlackBtn:(UIButton*)button
{
    if (btnBlackList) 
    {
        [btnBlackList removeFromSuperview];
    }
    btnBlackList = button;
    [self.mainView addSubview:btnBlackList];
}
//如何收集国旗
-(void)showHow:(UIButton *)sender
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"如何收集国旗" message:nil delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    alert.tag = 123;
    alert.alertTpye = howGetFlag;
    [alert show];
    [alert release];
}


#pragma mark CP_UIAlertView Delegate

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    if(alertView.tag == 123)
    {
        //特定tag  世界杯活动规则->‘1111’
        if(buttonIndex == 1111)
        {
            FlagRuleViewController *flagrule = [[FlagRuleViewController alloc] init];
            [self presentViewController:flagrule animated: YES completion:nil];
            [flagrule release];
        }
    }
}
- (void)prograssBarBtnDeleate:(NSInteger) type
{
    
    [mProgressBar dismiss];
    
    [cb_GetUserInfo clearDelegatesAndCancel];
    [cb_AttUser clearDelegatesAndCancel];
    [cb_CancelAtt clearDelegatesAndCancel];
    [cb_AddBlackUser clearDelegatesAndCancel];
    [cb_DelBlackUser clearDelegatesAndCancel];
    [cb_GetBlackRelation clearDelegatesAndCancel];
    [cb_GetRelation clearDelegatesAndCancel];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
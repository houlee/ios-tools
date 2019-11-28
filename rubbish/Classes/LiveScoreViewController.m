
//  LiveScoreViewController.m
//  caibo
//
//  Created by user on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LiveScoreViewController.h"
#import "CBRefreshTableHeaderView.h"
#import "Info.h"
#import "CheckNetwork.h"
#import "NetURL.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "MatchDetailViewController.h"
#import "LiveScoreCell.h"
#import "TermSelectViewController.h"
#import "MatchInfo.h"
#import "SBJSON.h"
#import "MoreLoadCell.h"
#import "ResultString.h"
#import "ASIFormDataRequest.h"
#import "caiboAppDelegate.h"
#import "HomeViewController.h"
#import "LotteryPreferenceViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "ScoreLiveDetailViewController.h"
#import "BiFenZhiBoLanQiuData.h"
#import "BifenLanQiuCell.h"
#import "NetURL.h"

// Private
@interface LiveScoreViewController ()
@property (nonatomic, retain) ASIHTTPRequest *mRequest;
@property (nonatomic, retain) TermSelectViewController *termTableController;
@property (nonatomic, retain) CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, retain) NSMutableDictionary *mDataDic;
@property (nonatomic, retain) MoreLoadCell *moreLoadCell;
@property (nonatomic, assign) NSInteger requestIndex;
@property (nonatomic, retain) UIButton *curButton;
@property (nonatomic, retain) MatchInfo *tMatch;
@property (nonatomic, retain) NSString *mPageNum;
@property (nonatomic, retain) ASIHTTPRequest *autoRequest;

- (void)doBack;
- (void)doAllAttention;
- (void)getMatchListRequest;                            // 获取赛事列表
- (void)getMatchListByIssueRequest;                     // 获取赛事列表
- (void)getIssueListRequest;                            // 获取期号列表
- (void)showIssuePicker:(UIButton*)sender;
- (void)dismissRefreshTableHeaderView;
- (void)sendCancelAttention:(MatchInfo*)match;
- (void)sendAddAttention:(MatchInfo*)match;
- (NSString*)getLotteryId:(NSInteger)index;
- (NSString*)getMatchListKey:(NSInteger)index;
- (NSString*)getIssueListKey:(NSInteger)index;
- (NSString*)getCurIssueKey:(NSInteger)index;
- (NSString*)getCurPage:(NSInteger)index;
- (void) dismissProgressBar;
// 加载更多
- (void)doMoreLoading;
- (void)getAutoRefreshMyAttRequest;
- (void)getAutoRefreshLotteryRequest;
- (void)doAutoUpdate;

#define kTitle                 @"标题"
#define kMyAtt                 @"我的关注"
#define kZc                    @"足彩"
#define kJc                    @"竞彩"
#define kBd                    @"北单"
#define klq                    @"篮球"
#define kZcIssue               @"足彩彩期"
#define kJcIssue               @"竞彩彩期"
#define kBdIssue               @"北单彩期"
#define kLqIssue               @"篮球彩期"
#define kZcCurrentIssue        @"足彩当前彩期"
#define kJcCurrentIssue		   @"竞彩当前彩期"
#define kBdCurrentIssue        @"北单当前彩期"
#define kLQCurrentIssue        @"篮球当前彩期"
#define kMyAttCurPage          @"我的关注页码"

#define cellBgColor [UIColor colorWithRed:255/255.0 green:144/255.0 blue:36/255.0 alpha:1.0]
#define cellBgColor2 [UIColor colorWithRed:230/255.0 green:239/255.0 blue:220/255.0 alpha:1.0]

@end

@implementation LiveScoreViewController

@synthesize mTableView;
@synthesize headerView;
@synthesize lbLotteryName;
@synthesize btnIssue;
@synthesize mRequest;
@synthesize mRefreshView;
@synthesize currentIssue;
@synthesize termTableController;
@synthesize selectedSegmentIndex;
@synthesize mDataDic;
@synthesize moreLoadCell;
@synthesize requestIndex;
@synthesize curButton;
@synthesize mSegmentedControl;
@synthesize tMatch;
@synthesize mPageNum;
@synthesize autoRequest;
@synthesize liveType;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
    [MobClick event:@"event_bifenzhibo"];
	self.CP_navigation.title = @"比分直播";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
    }
    UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
	backImageV.frame = self.mainView.bounds;
	[self.mainView insertSubview:backImageV atIndex:0];
	[backImageV release];
#ifdef isCaiPiaoForIPad
    if ([self.navigationController.viewControllers count] <= 2) {
        self.CP_navigation.leftBarButtonItem = nil;
        [self.CP_navigation setHidesBackButton:YES];
    }

#endif
	//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    
    
	if ([[[Info getInstance] userId] intValue]==0||[[[Info getInstance] userId] isEqualToString:CBGuiteID]) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
		self.selectedSegmentIndex = 1;
		mSegmentedControl.selectedSegmentIndex = 1;

        UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];

		self.CP_navigation.rightBarButtonItem = rightItem;
		
        //		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //		self.selectedSegmentIndex = 1;
        //		[cai showMessage:@"登录后可用"];
	}
	else {
		UIBarButtonItem *rightItem;
        
        
		self.selectedSegmentIndex = liveType;
        
        mSegmentedControl.selectedSegmentIndex = liveType;
        
		if (mSegmentedControl.selectedSegmentIndex == 0){
#ifndef isCaiPiaoForIPad
            
            rightItem = [Info itemInitWithTitle:@"移除" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];

#else
            rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhuyichu.png" Size:CGSizeMake(40,40)];
#endif
			            
		}
		else {
#ifndef isCaiPiaoForIPad
            rightItem = [Info itemInitWithTitle:@"关注" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            
#else
           rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhu.png" Size:CGSizeMake(40,40)];
#endif
		}
		self.CP_navigation.rightBarButtonItem = rightItem;
	}
    [mSegmentedControl setWidth:70 forSegmentAtIndex:0];
    isAllAtt = NO;
    isLoading = NO;
    isMoreLoading = NO;
    isDataNone = NO;
    isFirstLoad = YES;
    
    [btnIssue addTarget:self action:@selector(showIssuePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!mRefreshView)
    {
		CBRefreshTableHeaderView *headerview =
		[[CBRefreshTableHeaderView alloc]
		 initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        self.mRefreshView = headerview;
		mRefreshView.delegate = self;
		[self.mTableView addSubview:mRefreshView];
		[headerview release];
	}
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView setFrame:CGRectMake(0, 55, 320, 40)];
    [headerView setHidden:YES];
    [self.mainView addSubview:headerView];
    
    
    if (!mDataDic)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        self.mDataDic = dic;
        [dic release];
    }
    
    [mRefreshView refreshLastUpdatedDate];
    self.mPageNum = @"1";
	[self segmentAction:mSegmentedControl];
    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];

}
static NSTimer *mAutoUpdateTimer;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    [self doAutoUpdate];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//        NSLog(@"h =%f,y =%f",caiboappdelegate.window.frame.size.height,caiboappdelegate.window.frame.origin.y);
//        caiboappdelegate.window.frame =  CGRectMake(0,20,caiboappdelegate.window.frame.size.width,caiboappdelegate.window.frame.size.height);
//    }
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (mAutoUpdateTimer)
    {
        [mAutoUpdateTimer invalidate];
        mAutoUpdateTimer = nil;
    }
    [UIApplication sharedApplication].idleTimerDisabled=NO;
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    self.mTableView = nil;
    self.headerView = nil;
    self.lbLotteryName = nil;
    self.btnIssue = nil;
    self.mSegmentedControl = nil;
    [super viewDidUnload];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat f = 100;
    if (mTableView.contentSize.height >= mTableView.frame.size.height)
    {
        f = mTableView.contentSize.height - mTableView.frame.size.height + 120;
    }
    if (scrollView.contentOffset.y >= f)
    {
        [self doMoreLoading];
    }
    if (!isMoreLoading)
    {
        [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
    }
}

// 下拉结束停在正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	isLoading = YES;
    isMoreLoading = NO;
    isDataNone = NO;
	[mRefreshView setState:CBPullRefreshLoading];
    mTableView.contentInset = UIEdgeInsetsMake(60.0, -60.0f, 0.0f, 0.0f);
    self.mPageNum = @"1";
    self.requestIndex = selectedSegmentIndex;
    if (requestIndex == 0)
    {
        [self getMatchListRequest];
    }
    else
    {
        [self getMatchListByIssueRequest];
    }
}

// 加载更多
- (void)doMoreLoading
{
    if (!isMoreLoading && moreLoadCell && !isDataNone)
    {
        isMoreLoading = YES;
        [moreLoadCell spinnerStartAnimating2];
        self.requestIndex = selectedSegmentIndex;
        if (requestIndex != 0)
        {
            self.mPageNum = [self getCurPage:requestIndex];
            [self performSelector:@selector(getMatchListByIssueRequest) withObject:nil afterDelay:.5];
        }
    }
    if(moreLoadCell && isDataNone && !isMoreLoading){
    
        [moreLoadCell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        moreLoadCell.textLabel.text = nil;
        [moreLoadCell spinnerStopAnimating];
        [moreLoadCell setInfoText:@"加载完毕"];
    }
}

// 判断是否正在刷新状态
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return isLoading; // should return if data source model is reloading
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}

#pragma mark 自定义

// 未登录状态更改为登录状态

- (void)hasLogin {
	UIBarButtonItem *rightItem;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
	if (mSegmentedControl.selectedSegmentIndex == 0){
#ifndef isCaiPiaoForIPad
        rightItem = [Info itemInitWithTitle:@"移除" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
        
#else
        rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhuyichu.png" Size:CGSizeMake(40,40)];
#endif
	}
	else {
#ifndef isCaiPiaoForIPad
        rightItem = [Info itemInitWithTitle:@"关注" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
        
#else
        rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhu.png" Size:CGSizeMake(40,40)];
#endif
	}
	self.CP_navigation.rightBarButtonItem = rightItem;
}

// 返回
- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
    /*
	 if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[HomeViewController class]]) {
	 [self.navigationController popViewControllerAnimated:YES];
	 }
	 else {
	 [self.navigationController popViewControllerAnimated:YES];
	 caiboAppDelegate* delegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
	 delegate.tabBarController.selectedIndex = 3;
	 }
	 */
	
}

// 全部关注
- (void)doAllAttention
{
	Info *info = [Info getInstance];
	if ([info.userId isEqualToString:CBGuiteID]||[info.userId intValue] == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请登录你的微博账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册",@"登录",nil];
		alert.tag = 10001;
		[alert show];
		[alert release];
		
		return;
	}
    if (isAllAtt)
    {
        isAllAtt = NO;
        if ([[[Info getInstance] userId] intValue]==0||[[[Info getInstance] userId] isEqualToString:CBGuiteID]) {

            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];

			self.CP_navigation.rightBarButtonItem = rightItem;
		}
		else {
			UIBarButtonItem *rightItem;
			
			if (mSegmentedControl.selectedSegmentIndex == 0){
#ifndef isCaiPiaoForIPad
                rightItem = [Info itemInitWithTitle:@"移除" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
                
#else
                rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhuyichu.png" Size:CGSizeMake(40,40)];
#endif
			}
			else {
#ifndef isCaiPiaoForIPad
                rightItem = [Info itemInitWithTitle:@"关注" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
                
#else
                rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhu.png" Size:CGSizeMake(40,40)];
#endif
			}
			self.CP_navigation.rightBarButtonItem = rightItem;
		}
    }
    else
    {
        isAllAtt = YES;
		if ([[[Info getInstance] userId] intValue]==0||[[[Info getInstance] userId] isEqualToString:CBGuiteID]) {
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
			self.CP_navigation.rightBarButtonItem = rightItem;
		}
		else {
			
#ifndef isCaiPiaoForIPad
            if (mSegmentedControl.selectedSegmentIndex == 4) {
                isAllAtt = NO;
                [[caiboAppDelegate getAppDelegate] showMessage:@"竞彩篮球暂不支持关注"];
            }
            else {
                UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
                self.CP_navigation.rightBarButtonItem = rightItem;
                if (mSegmentedControl.selectedSegmentIndex == 0) {
                    [MobClick event:@"event_bifenzhibo_wodeguanzhu_yichu"];
                }
                else if (mSegmentedControl.selectedSegmentIndex == 1) {
                    [MobClick event:@"event_bifenzhibo_zucai_guanzhu"];
                }
                else if (mSegmentedControl.selectedSegmentIndex == 2) {
                    [MobClick event:@"event_bifenzhibo_jingcai_guanzhu"];
                }
                else if (mSegmentedControl.selectedSegmentIndex == 3) {
                    [MobClick event:@"event_bifenzhibo_beidan_guanzhu"];
                }
                
            }
            
            
#else
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhuWanchen.png" Size:CGSizeMake(40,40)];
            self.CP_navigation.rightBarButtonItem = rightItem;
#endif
			
		}
        
    }
    [mTableView reloadData];
}

// 响应tab切换
- (IBAction)segmentAction:(id) sender
{
    
//    for (UIView *v in mSegmentedControl.subviews) {
//        for (UILabel *v2 in v.subviews) {
//            if ([v2 isKindOfClass:[UILabel class]]) {
//                v2.font = [UIFont systemFontOfSize:14];
//                v2.textAlignment = NSTextAlignmentCenter;
//            }
//        }
//    }
	Info *info = [Info getInstance];
	if (![info.userId isEqualToString:CBGuiteID]&&[info.userId intValue] != 0) {
		isAllAtt = YES;
		[self doAllAttention];
	}
    self.selectedSegmentIndex = [sender selectedSegmentIndex];
    [mTableView reloadData];
    [mRequest clearDelegatesAndCancel];
	if ([info.userId isEqualToString:CBGuiteID]||[info.userId intValue] == 0) {
		if (selectedSegmentIndex == 0) {
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai showMessage:@"登录后可用"];
		}
	}
	else {
		if (selectedSegmentIndex == 0) {
#ifndef isCaiPiaoForIPad
          UIBarButtonItem *  rightItem = [Info itemInitWithTitle:@"移除" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            
#else
          UIBarButtonItem * rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhuyichu.png" Size:CGSizeMake(40,40)];
#endif
			self.CP_navigation.rightBarButtonItem = rightItem;
		}
		else {
#ifndef isCaiPiaoForIPad
           UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"关注" Target:self action:@selector(doAllAttention) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            
#else
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(doAllAttention) ImageName:@"ipadguanzhu.png" Size:CGSizeMake(40,40)];
#endif
			self.CP_navigation.rightBarButtonItem = rightItem;
		}
	}
    //	if ([self mRequest])
    //	{
    //		[mRequest clearDelegatesAndCancel];
    //		[self dismissRefreshTableHeaderView];
    //	}
	[self doAutoUpdate];
	if (selectedSegmentIndex == 0)
	{
		[MobClick event:@"event_bifenzhibo_wodeguanzhu"];
		[headerView setHidden:YES];
#ifdef isHaoLeCai
        [mTableView setFrame:CGRectMake(0, 55, 320, self.mainView.bounds.size.height - 55)];
#else
		[mTableView setFrame:CGRectMake(0, 55, 320, self.mainView.bounds.size.height - 75)];
#endif

#ifdef isCaiPiaoForIPad
        self.mTableView.frame = CGRectMake(0, 55, 390, self.mainView.bounds.size.height - 75);
#endif
		isLoading = NO;
		isMoreLoading = NO;
		isDataNone = NO;
		self.mPageNum = @"1";
		self.requestIndex = selectedSegmentIndex;
		if ([info.userId isEqualToString:CBGuiteID]||[info.userId intValue] == 0) {
			if ([[mDataDic objectForKey:[self getMatchListKey:requestIndex]] count] == 0) {
				[self getMatchListRequest];
			}
		}
	}
	else
	{
        
		if (selectedSegmentIndex == 1) {
            [MobClick event:@"event_bifenzhibo_zucai"];
        }
        else if (selectedSegmentIndex == 2) {
            [MobClick event:@"event_bifenzhibo_jingcai"];
        }
        else if (selectedSegmentIndex == 3) {
            
            [MobClick event:@"event_bifenzhibo_beidan"];
        }
        else if (selectedSegmentIndex == 4) {
            if ([info.userId intValue] != 0) {
                self.CP_navigation.rightBarButtonItem = nil;
            }
            [MobClick event:@"event_bifenzhibo_lanqiu"];
        }
		[headerView setHidden:NO];
#ifdef isHaoLeCai
        [mTableView setFrame:CGRectMake(0, 55+40, 320, self.mainView.bounds.size.height - 75-20)];
#else
		[mTableView setFrame:CGRectMake(0, 55+40, 320, self.mainView.bounds.size.height - 75-40)];
#endif
        
#ifdef isCaiPiaoForIPad
        self.mTableView.frame = CGRectMake(0, 55 + 40, 390, self.mainView.bounds.size.height - 75 - 40);
#endif
		lbLotteryName.text = [self getMatchListKey:selectedSegmentIndex];
		NSString *curIssue = [mDataDic valueForKey:[self getCurIssueKey:selectedSegmentIndex]];
		[btnIssue setTitle:curIssue forState:(UIControlStateNormal)];
		NSArray *matchArr = [mDataDic objectForKey:[self getMatchListKey:selectedSegmentIndex]];
		if (!matchArr)
		{
			[mRefreshView refreshLastUpdatedDate];
			[self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
		}
		else if ([matchArr count] > 0)
		{
			self.requestIndex = selectedSegmentIndex;
			//[self getAutoRefreshLotteryRequest];
		}
	}
}

#pragma mark 2.82 发送数据和接收数据
// 胜负彩300 四场进球 302 六场半全场 303 竞彩201 北单400
- (void)getMatchListRequest
{
	if ([CheckNetwork isExistenceNetwork])
	{
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
        
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBgetAttentionMatchList]];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setDidFinishSelector:@selector(reqGetMatchListFinished:)];
        [mRequest setNumberOfTimesToRetryOnTimeout:2];
        [mRequest startAsynchronous];
	}
}

- (void)reqGetMatchListFinished:(ASIHTTPRequest*)request
{
#ifdef isCaiPiaoForIPad
    mTableView.frame = CGRectMake(mTableView.frame.origin.x, mTableView.frame.origin.y, 390, self.mainView.bounds.size.height - mTableView.frame.origin.y -20);
#endif
	NSString *responseString = [request responseString];
	if (responseString)
    {
        NSMutableArray *vec = [MatchInfo parserWithString:responseString];
        
        NSMutableArray *titleList = [MatchInfo getTitleVec:vec];
        [mDataDic setObject:titleList forKey:kTitle];
        
        NSMutableArray *arrList = [MatchInfo getMatchArrVec:vec];
        [mDataDic setObject:arrList forKey:[self getMatchListKey:requestIndex]];
        if (isFirstLoad && [arrList count] == 0)
        {
            self.mSegmentedControl.selectedSegmentIndex = 2;
            [self segmentAction:self.mSegmentedControl];
            isFirstLoad = NO;
        }
	}
	isLoading = NO;
    [mTableView reloadData];
    [self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:.5];
}

#pragma mark 2.88 发送数据和接收数据
- (void)getMatchListByIssueRequest
{
	if ([CheckNetwork isExistenceNetwork])
    {
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
        
        NSString *userId = [[Info getInstance] userId];
        NSString *lotteryId = [self getLotteryId:requestIndex];
        NSString *curIssue = [mDataDic valueForKey:[self getCurIssueKey:requestIndex]];
        if (!curIssue)
        {
            curIssue = @"";
        }
        NSString *pageSize = @"20";
        if ([userId intValue] == 0) {
			userId = @"0";
		}
        if (mSegmentedControl.selectedSegmentIndex == 4) {//篮球
            self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBgetLanQiuMatchListWithIssue:curIssue UserId:userId PageNum:mPageNum PageSize:pageSize Type:@"1"]];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setDidFinishSelector:@selector(reqGetLanQiuMatchListByIssueFinished:)];
            [mRequest setNumberOfTimesToRetryOnTimeout:2];
            [mRequest startAsynchronous];
        }
        else {//足球，我的关注
            self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBgetMatchList:lotteryId Issue:curIssue UserId:userId PageNum:mPageNum PageSize:pageSize]];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setDidFinishSelector:@selector(reqGetMatchListByIssueFinished:)];
            [mRequest setNumberOfTimesToRetryOnTimeout:2];
            [mRequest startAsynchronous];
        }
        
	}
}

- (void)reqGetLanQiuMatchListByIssueFinished:(ASIHTTPRequest*)request {
    NSString *responseString = [request responseString];
#ifdef isCaiPiaoForIPad
    mTableView.frame = CGRectMake(mTableView.frame.origin.x, mTableView.frame.origin.y, 390, self.mainView.bounds.size.height - mTableView.frame.origin.y -20);
#endif
    
	if (responseString && ![responseString isEqualToString:@"fail"])
    {
        BiFenZhiBoLanQiuData *info = [[BiFenZhiBoLanQiuData alloc] initParserWithString:responseString];
        if (!isMoreLoading)
        {
            if ([self getCurIssueKey:requestIndex] && info.curIssue) {
                [mDataDic setValue:info.curIssue forKey:[self getCurIssueKey:requestIndex]];
            }
            if ([self getMatchListKey:requestIndex] && info.matchList) {
                [mDataDic setObject:info.matchList forKey:[self getMatchListKey:requestIndex]];
            }
            
            [btnIssue setTitle:info.curIssue forState:(UIControlStateNormal)];
            
            NSUInteger remainder = [info.matchList count] % 20;
            if (remainder != 0)
            {
                isDataNone = YES;
            }
        }
        else
        {
            isMoreLoading = NO;
            if (!info.matchList || [info.matchList count] < 20)
            {
                isDataNone = YES;
            }
            if ([info.matchList count] > 0)
            {
                NSMutableArray *matchList = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
                NSUInteger remainder = [matchList count] % 20;
                if (remainder != 0)
                {
                    NSUInteger loc = [matchList count] - remainder;
                    [matchList removeObjectsInRange:NSMakeRange(loc, remainder)];
                }
                [matchList addObjectsFromArray: info.matchList];
            }
        }
        [info release];
	}
    
    [mTableView reloadData];
    [self getIssueListRequest];
    [self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:.5];
}

- (void)reqGetMatchListByIssueFinished:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
    NSLog(@"aaasdfsadfasdfsad = %@", responseString);
#ifdef isCaiPiaoForIPad
    mTableView.frame = CGRectMake(mTableView.frame.origin.x, mTableView.frame.origin.y, 390, self.mainView.bounds.size.height - mTableView.frame.origin.y -20);
#endif
    
	if (responseString && ![responseString isEqualToString:@"fail"])
    {
        MatchInfo *info = [[MatchInfo alloc] initParserWithString:responseString];
        if (!isMoreLoading)
        {
            if ([self getCurIssueKey:requestIndex] && info.curIssue) {
                [mDataDic setValue:info.curIssue forKey:[self getCurIssueKey:requestIndex]];
            }
            if ([self getMatchListKey:requestIndex] && info.matchList) {
                [mDataDic setObject:info.matchList forKey:[self getMatchListKey:requestIndex]];
            }
            
            [btnIssue setTitle:info.curIssue forState:(UIControlStateNormal)];
            [self getIssueListRequest];
            NSUInteger remainder = [info.matchList count] % 20;
            if (remainder != 0)
            {
                isDataNone = YES;
            }
        }
        else
        {
            isMoreLoading = NO;
            if (!info.matchList || [info.matchList count] < 20)
            {
                isDataNone = YES;
            }
            if ([info.matchList count] > 0)
            {
                NSMutableArray *matchList = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
                NSUInteger remainder = [matchList count] % 20;
                if (remainder != 0)
                {
                    NSUInteger loc = [matchList count] - remainder;
                    [matchList removeObjectsInRange:NSMakeRange(loc, remainder)];
                }
                [matchList addObjectsFromArray: info.matchList];
            }
        }
        [info release];
	}
    
    [mTableView reloadData];
    [self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:.5];
}

#pragma mark 2.89 发送数据和接收数据
- (void)getIssueListRequest
{
    if ([self mRequest])
    {
        [mRequest clearDelegatesAndCancel];
    }
    
    self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBgetIssueList:[self getLotteryId:requestIndex]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqGetIssueListFinished:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];
}

- (void)reqGetIssueListFinished:(ASIHTTPRequest*)request
{
	NSString *responseStr = [request responseString];
	if (responseStr)
    {
        NSMutableArray *vec = [[NSMutableArray alloc] init];
        
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSArray *arr = [jsonParse objectWithString:responseStr];
        for (NSDictionary *dict in arr)
        {
            NSString *issue = [dict valueForKey:@"issue"];
            [vec addObject:issue];
        }
        [jsonParse release];
        
        if ([self getIssueListKey:requestIndex]) {
             [mDataDic setObject:vec forKey:[self getIssueListKey:requestIndex]];
        }
       
        
        [vec release];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    isMoreLoading = NO;
    [mTableView reloadData];
    [self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:.5];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *titleVec = [mDataDic objectForKey:kTitle];
    NSInteger sectionsNum = [titleVec count];
    if (sectionsNum == 0)
    {
        sectionsNum = 1;
    }
    return selectedSegmentIndex == 0? sectionsNum:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *matchArr = [mDataDic objectForKey:[self getMatchListKey:selectedSegmentIndex]];
    if (selectedSegmentIndex == 0 && [matchArr count] > 0)
    {
        matchArr = [matchArr objectAtIndex:section];
        return [matchArr count];
    }
    return [matchArr count] + 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (mSegmentedControl.selectedSegmentIndex == 0 || mSegmentedControl.selectedSegmentIndex == 4) {
        return 26;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (mSegmentedControl.selectedSegmentIndex == 4) {
        UIImageView *upimageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)] autorelease];
//        upimageview.backgroundColor = [UIColor clearColor];
//        upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
         upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
        [self.mainView addSubview:upimageview];
        UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 26)];
        saishila.backgroundColor = [UIColor clearColor];
        saishila.font = [UIFont systemFontOfSize:13];
        saishila.textColor = [UIColor whiteColor];
        saishila.textAlignment = NSTextAlignmentCenter;
        saishila.text = @"赛事";
        [upimageview addSubview:saishila];
        [saishila release];
        
        
        UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 6, 1, 14)];
        shuimage.backgroundColor = [UIColor whiteColor];
        [upimageview addSubview:shuimage];
        [shuimage release];
        
        UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 124, 26)];
        shengla.backgroundColor = [UIColor clearColor];
        shengla.font = [UIFont systemFontOfSize:13];
        shengla.textColor = [UIColor whiteColor];
        shengla.textAlignment = NSTextAlignmentCenter;
        shengla.tag = 11118;
        shengla.text = @"客队";
        [upimageview addSubview:shengla];
        [shengla release];
        
        UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 6, 1, 15)];
        shuimage2.backgroundColor = [UIColor whiteColor];
        [upimageview addSubview:shuimage2];
        [shuimage2 release];
        
        UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 136, 26)];
        pingla.backgroundColor = [UIColor clearColor];
        pingla.font = [UIFont systemFontOfSize:13];
        pingla.textColor = [UIColor whiteColor];
        pingla.textAlignment = NSTextAlignmentCenter;
        pingla.tag = 11119;
        pingla.text = @"主队";
        [upimageview addSubview:pingla];
        [pingla release];
        return upimageview;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    if (selectedSegmentIndex == 0)
    {
        NSArray *titleArr = [mDataDic objectForKey:kTitle];
        if ([titleArr count] > 0)
        {
            title = [titleArr objectAtIndex:section];
        }
    }
	return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionIndex = [indexPath section];
    NSInteger rowIndex = [indexPath row];
    static NSString *CellIdentifier = @"Cell";
    NSArray *matchArr = [mDataDic objectForKey:[self getMatchListKey:selectedSegmentIndex]];
    if (selectedSegmentIndex == 0 && [matchArr count] > 0)
    {
        matchArr = [matchArr objectAtIndex:sectionIndex];
    }
    if (rowIndex == [matchArr count] || [matchArr count] == 0)
    {
        if (selectedSegmentIndex == 0)
        {
            CellIdentifier = @"Cell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            }
            cell.textLabel.text = @"您目前没有关注的比赛，请切换至“足彩、竞彩、北单”标签点击“关注”添加比赛！";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.numberOfLines = 2;
            return cell;
        }
        else
        {
            CellIdentifier = @"MoreLoadCell";
            MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleBlue)];
            }
            if (![self moreLoadCell])
            {
                self.moreLoadCell = cell;
            }
            if ([matchArr count] == 0)
            {
                [moreLoadCell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                moreLoadCell.textLabel.text = nil;
                [moreLoadCell setInfoText:@"暂无数据..."];
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"加载完毕"];
                [moreLoadCell spinnerStopAnimating];
                [moreLoadCell setInfoText:@"加载完毕"];
            }
            else
            {
                isDataNone = ([matchArr count] % 20 != 0);
                [moreLoadCell spinnerStopAnimating2:isDataNone];
            }
            return moreLoadCell;
        }
    }
    else
    {
        if (selectedSegmentIndex == 4) {
            CellIdentifier = @"LanqiuLiveScoreCell";
            BifenLanQiuCell *cell = (BifenLanQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[BifenLanQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            BiFenZhiBoLanQiuData *match = [matchArr objectAtIndex:rowIndex];
            [cell LoadData:match];
            if (match.isColorNeedChange) {
                [self performSelector:@selector(lancolorReset:) withObject:match afterDelay:2];
            }
            return cell;
        }
        else {
        CellIdentifier = @"LiveScoreCell";
        LiveScoreCell *cell = (LiveScoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LiveScoreCell" owner:self options:nil] objectAtIndex:0];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleBlue)];
        }
        MatchInfo *match = [matchArr objectAtIndex:rowIndex];
		
        if (match)
        {
#ifdef  isCaiPiao365AndPPTV
            //判断赛事在pptv是否存在，存在则添加pptvlogo
            if ([match.section_id length]) {
                cell.pptvlogoImage.image = UIImageGetImageFromName(@"JRGZLOGO960.png");
            }
            else {
                cell.pptvlogoImage.image = nil;
            }
#else
#endif

            
           
            
            NSLog(@"row = %ld",(long)rowIndex);
			NSLog(@"match.pos = %@",match.pos);
			cell.lsImageView.image = nil;
			if ([match.pos isEqualToString:@"2"]) {
				//cell.lsImageView.image = UIImageGetImageFromName(@"first.png");
                UIImage *firstImage = UIImageGetImageFromName(@"first.png");
                [cell.Btn setBackgroundImage:firstImage forState:UIControlStateNormal];
                cell.Btn.tag = 101;
                [cell.Btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.Btn.hidden = NO;
			}
			else if ([match.pos isEqualToString:@"1"]) {
				//cell.lsImageView.image = UIImageGetImageFromName(@"middle.png");
                UIImage *middleImage = UIImageGetImageFromName(@"middle.png");
                [cell.Btn setBackgroundImage:middleImage forState:UIControlStateNormal];
                cell.Btn.tag = 102;
                [cell.Btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.Btn.hidden = NO;
                
			}
			else if ([match.pos isEqualToString:@"0"]) {
				//cell.lsImageView.image = UIImageGetImageFromName(@"last.png");
                UIImage *lastImage = UIImageGetImageFromName(@"last.png");
                [cell.Btn setBackgroundImage:lastImage forState:UIControlStateNormal];
                cell.Btn.tag = 103;
                [cell.Btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.Btn.hidden = NO;
			}
			else 
            {
				//cell.lsImageView.image = nil;
                cell.Btn.hidden = YES;
            }
            if ([match.changci length] && ([match.lotteryId isEqualToString:@"201"]||[match.lotteryId isEqualToString:@"400"])) {
                cell.changciLable.text = match.changci;
            }
            else {
                cell.changciLable.text = nil;
            }
            [cell.lbStatus setText:match.status];
            [cell.lbLeagueName setText:match.leagueName];
            NSString *home = match.home;
            if (home && [home length] > 4)
            {
                home = [home substringWithRange:NSMakeRange(0, 4)];
            }
            if (match.rangqiu && ![match.rangqiu isEqualToString:@"0"] && ![match.rangqiu isEqualToString:@""])
            {
                home = [home stringByAppendingString:@"("];
                home = [home stringByAppendingString:match.rangqiu];
                home = [home stringByAppendingString:@")"];
            }
            cell.lbHome.text = home;
            cell.lbHome.adjustsFontSizeToFitWidth = NO;
            NSString *away = match.away;
            if (away && [away length] > 4)
            {
                away = [away substringWithRange:NSMakeRange(0, 4)];
            }
            cell.lbAway.text = away;
            cell.lbAway.adjustsFontSizeToFitWidth = NO;
            
            NSString *score = match.scoreHost;
            score = [score stringByAppendingString:@"-"];
            score = [score stringByAppendingString:match.awayHost];
            cell.lbHost.text = score;
            int stateInt = [match.start intValue];
            if (stateInt == 0) //未开始
            {
                cell.lbHost.textColor = [UIColor grayColor];
                cell.lbCaiguo.textColor = [UIColor grayColor];
                cell.lbStatus.textColor = [UIColor blackColor];
                cell.lbHost.text = @"一";
            }
            else if (stateInt == 1) //比赛中
            {
                cell.lbHost.textColor = [UIColor blueColor];
                cell.lbCaiguo.textColor = [UIColor blueColor];
                cell.lbStatus.textColor = [UIColor redColor];
            }
            else if (stateInt == 2) //已结束
            {
                cell.lbHost.textColor = [UIColor redColor];
                cell.lbCaiguo.textColor = [UIColor redColor];
                cell.lbStatus.textColor = [UIColor blackColor];
            }
            
            if (!match.caiguo||[match.caiguo isEqualToString:@""]||stateInt == 0)
            {
                match.caiguo = @"一";
            }
            //cell.lbCaiguo.text = match.caiguo;
			if ([match.lotteryNumber length]==3) {
				cell.lbCaiguo.text = [NSString stringWithFormat:@"%@(全)",match.caiguo];
			}
			else if( [match.lotteryNumber length] >0&&[match.lotteryNumber length] <3){
				cell.lbCaiguo.text = [NSString stringWithFormat:@"%@(%@)",match.caiguo,match.lotteryNumber];
			}
			else {
				cell.lbCaiguo.text = match.caiguo;
			}
			
            UIImage *image_unAtt = UIImageGetImageFromName(@"icon_att_+.png");
            UIImage *image_att = UIImageGetImageFromName(@"icon_att-_+.png");
            [cell.btnAtt setImage:image_unAtt forState:(UIControlStateNormal)];
            [cell.btnAtt setImage:image_att forState:(UIControlStateSelected)];
            cell.btnAtt.selected = [match.isAttention isEqualToString:@"1"];
			cell.btnAtt.userInteractionEnabled = NO;
        }
        if (isAllAtt)
        {
            [cell setAccessoryType:(UITableViewCellAccessoryNone)];
            [cell.btnAtt setHidden:NO];
        }
        else
        {
            [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
            [cell.btnAtt setHidden:YES];
        }
        if (match.isColorNeedChange)
        {
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
            backgroundView.backgroundColor = cellBgColor;
            cell.backgroundView = backgroundView;
            [backgroundView release];
            if (match.isScoreHostChange)
            {
                cell.lbHome.textColor = [UIColor redColor];
            }
            if (match.isAwayHostChange)
            {
                cell.lbAway.textColor = [UIColor redColor];
            }
            [self performSelector:@selector(colorReset:) withObject:match afterDelay:15];
        }
        else if(rowIndex % 2 != 0)
        {
            cell.lbHome.textColor = [UIColor blackColor];
            cell.lbAway.textColor = [UIColor blackColor];
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
            backgroundView.backgroundColor = cellBgColor2;
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        else
        {
            cell.lbHome.textColor = [UIColor blackColor];
            cell.lbAway.textColor = [UIColor blackColor];
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
            backgroundView.backgroundColor = [UIColor whiteColor];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
		if (selectedSegmentIndex == 0 &&match.isGoalNotice) {
			cell.tuisongBnt.hidden = NO;
		}
		else {
			cell.tuisongBnt.hidden = YES;
		}
		
        return cell;
        }
    }
    return nil;
}

- (void)lancolorReset:(BiFenZhiBoLanQiuData *)match {
    match.isColorNeedChange = NO;
    if (match.isScoreHostChange)
    {
        match.isScoreHostChange = NO;
    }
    if (match.isAwayHostChange)
    {
        match.isAwayHostChange = NO;
    }
    [mTableView reloadData];
}

- (void) colorReset:(MatchInfo*)match
{
    match.isColorNeedChange = NO;
    if (match.isScoreHostChange)
    {
        match.isScoreHostChange = NO;
    }
    if (match.isAwayHostChange)
    {
        match.isAwayHostChange = NO;
    }
    [mTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
    //	Info *info = [Info getInstance];
    //	if ([info.userId isEqualToString:CBGuiteID]||[info.userId intValue] == 0) {
    //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请登录你的微博账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册",@"登录",nil];
    //		alert.tag = 10001;
    //		[alert show];
    //		[alert release];
    //
    //		return;
    //	}
    NSInteger sectionIndex = [indexPath section];
    NSInteger rowIndex = [indexPath row];
    NSArray *matchArr = [mDataDic objectForKey:[self getMatchListKey:selectedSegmentIndex]];
    if (selectedSegmentIndex == 0 && [matchArr count] > 0)
    {
        matchArr = [matchArr objectAtIndex:sectionIndex];
    }
    if ([matchArr count] > 0)
    {
        if (rowIndex == [matchArr count])
        {
            [self doMoreLoading];
        }
        else
        {
            MatchInfo *match = [matchArr objectAtIndex:rowIndex];
            if (match)
            {
                if (isAllAtt)
                {
                    LiveScoreCell *cell = (LiveScoreCell*)[tableView cellForRowAtIndexPath:indexPath];
                    self.curButton = cell.btnAtt;
                    self.tMatch = match;
                    if (curButton.selected) //发送取消关注请求
                    {
                        [self sendCancelAttention:match];
                    }
                    else //发送添加关注请求
                    {
                        if ([match.start isEqualToString:@"2"])
                        {
                            [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"已结束的比赛无法关注！" :self];
                        }
                        else
                        {
                            [self sendAddAttention:match];
                        }
                    }
                }
                else //进入赛事详情
                {
                    if (selectedSegmentIndex == 4) {
                        ScoreLiveDetailViewController *info = [[ScoreLiveDetailViewController alloc] init];
                        liveTelecastData *infodata = [[liveTelecastData alloc] init];
                        info.isLanqiu = YES;
                        BiFenZhiBoLanQiuData *match2 = [matchArr objectAtIndex:rowIndex];
                        infodata.matchId = match2.playId;
                        infodata.issue = match2.curIssue;
                        info.scoreInfo = infodata;
                        
                        [infodata release];
                        [self.navigationController pushViewController:info animated:YES];
                        info.CP_navigation.title = match2.liansainame;
                        [info release];
                    }
                    else {
                        MatchDetailViewController *matchDetailVC = [[MatchDetailViewController alloc] initWithNibName: @"MatchDetailViewController" bundle: nil];
                        matchDetailVC.matchId = match.matchId;
                        matchDetailVC.lotteryId = match.lotteryId;
                        matchDetailVC.issue = match.issue;
                        matchDetailVC.shouldShowSwitch = NO;
                        matchDetailVC.start = match.start;
                        matchDetailVC.section_id = match.section_id;
                        NSLog(@"match.pos = %@",match.pos);
                        if (selectedSegmentIndex == 0 || selectedSegmentIndex == 1) {
                            matchDetailVC.matchType = MatchTypeNormal;
                            if (selectedSegmentIndex == 0) {
                                matchDetailVC.shouldShowSwitch = YES;
                            }
                        }else
                        {
                            matchDetailVC.matchType = MatchTypeOne;
                        }
#ifdef isCaiPiaoForIPad
                        [self.navigationController pushViewController:matchDetailVC animated:YES];
#else
                        [self.navigationController pushViewController:matchDetailVC animated:YES];
#endif
                        
                        [matchDetailVC release];
                    }
                }
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (mSegmentedControl.selectedSegmentIndex == 4) {
        return 64;
    }
	return 50;
}

#pragma mark ActionAddAndCancle

-(void)AddMacthtion:(NSString *)numStr {
	NSInteger num = [numStr intValue];
	UIImageView *image = (UIImageView *)[donghuaImageView viewWithTag:101];
	if (num >3) {
		donghuaImageView.hidden = YES;
		image.image = nil;
		return;
	}
	NSString *imagename = [NSString stringWithFormat:@"+%ld.png",(long)num];
	image.image = UIImageGetImageFromName(imagename);
	[self performSelector:@selector(AddMacthtion:) withObject:[NSString stringWithFormat:@"%ld",(long)num+1] afterDelay:0.2];
}

- (void)canMacthtion:(NSString *)numStr {
	NSInteger num = [numStr intValue];
	UIImageView *image = (UIImageView *)[donghuaImageView viewWithTag:101];
	if (num >3) {
		donghuaImageView.hidden = YES;
		image.image = nil;
		return;
	}
	NSString *imagename = [NSString stringWithFormat:@"_%ld.png",(long)num];
	image.image = UIImageGetImageFromName(imagename);
	[self performSelector:@selector(canMacthtion:) withObject:[NSString stringWithFormat:@"%ld",(long)num+1] afterDelay:0.2];
}

- (void)AttentionDonghua {
	if (!donghuaImageView) {
		donghuaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 70, 30)];

		donghuaImageView.image = UIImageGetImageFromName(@"btn_aattention.png");
		[self.mainView addSubview:donghuaImageView];
		UIImageView *imageView = [[UIImageView alloc] init];
		[donghuaImageView addSubview:imageView];
		imageView.tag = 101;
		[imageView release];
		[donghuaImageView release];
	}
#ifdef isCaiPiaoForIPad
    donghuaImageView.frame = CGRectMake(23, 22, 90, 30);
#endif
	UIImageView *imageV = (UIImageView *)[donghuaImageView viewWithTag:101];
	imageV.frame = CGRectMake(30, 15, 26, 29);
	donghuaImageView.hidden = NO;
	[self performSelector:@selector(AddMacthtion:) withObject:@"1" afterDelay:0.2];
}
- (void)CancelDonghua {
	if (!donghuaImageView) {
		donghuaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 70, 30)];
		donghuaImageView.image = UIImageGetImageFromName(@"btn_aattention.png");
		[self.mainView addSubview:donghuaImageView];
		UIImageView *imageView = [[UIImageView alloc] init];
		[donghuaImageView addSubview:imageView];
		imageView.tag =101;
		[imageView release];
		[donghuaImageView release];
	}
#ifdef isCaiPiaoForIPad
    donghuaImageView.frame = CGRectMake(23, 22, 90, 30);
#endif
	UIImageView *imageV = (UIImageView *)[donghuaImageView viewWithTag:101];
	imageV.frame = CGRectMake(30, -15, 26, 29);
	donghuaImageView.hidden = NO;
	[self performSelector:@selector(canMacthtion:) withObject:@"1" afterDelay:0.2];
}

//单击首，次，末显示提示信息
- (void)pressBtn:(UIButton *)sender{
    
    if (sender.tag == 101) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"即低赔，热门赔率"];
        
    }
    if (sender.tag == 102) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"即此场比赛的中间赔率"];
        
    }
    if (sender.tag == 103) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"即高赔，冷门赔率"];
        
    }
}

#pragma mark AttentionRequest
- (void)sendCancelAttention:(MatchInfo*)match
{
	if ([CheckNetwork isExistenceNetwork])
	{
		[[ProgressBar getProgressBar] show:@"正在取消关注..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
		
        NSString *userId = [[Info getInstance] userId];
        
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBcancelAttentionMatch:userId MatchId:match.matchId LotteryId:match.lotteryId Issue:match.issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didCancelAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

- (void)didCancelAttention:(ASIHTTPRequest*)request
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
	if ([result isEqualToString:@"succ"])
    {
        self.curButton.selected = NO;
        self.tMatch.isAttention = @"0";
        [[ProgressBar getProgressBar] setTitle:@"取消成功！"];
		[self CancelDonghua];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else
    {
        [[ProgressBar getProgressBar] setTitle:@"取消失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
}

- (void)prograssBarBtnDeleate:(NSInteger)type
{
    [[ProgressBar getProgressBar]  dismiss];
}

// 关闭进度条
- (void) dismissProgressBar
{
    [[ProgressBar getProgressBar]  dismiss];
}

- (void)sendAddAttention:(MatchInfo*)match
{
	if ([CheckNetwork isExistenceNetwork])
	{
        [[ProgressBar getProgressBar]  show:@"正在添加关注..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
		if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
        
        NSString *userId = [[Info getInstance] userId];
		
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBattentionMatch:userId MatchId:match.matchId LotteryId:match.lotteryId Issue:match.issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didAddAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

-(void)didAddAttention:(ASIHTTPRequest*)request
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
    if ([result isEqualToString:@"succ"])
    {
        self.curButton.selected = YES;
        self.tMatch.isAttention = @"1";
		[self AttentionDonghua];
        [[ProgressBar getProgressBar] setTitle:@"关注成功！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else
    {
        [[ProgressBar getProgressBar] setTitle:@"关注失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
}

#pragma mark IssuePicker
- (void)showIssuePicker:(UIButton*)sender
{
	TermSelectViewController *tempController = [[TermSelectViewController alloc] initWithSettingController:self];
	self.termTableController = tempController;
	self.termTableController.selectIssue = [mDataDic objectForKey:[self getCurIssueKey:selectedSegmentIndex]];
	tempController.issues = [mDataDic objectForKey:[self getIssueListKey:selectedSegmentIndex]];
	[self.mainView addSubview:tempController.view];
	[tempController release];
}

- (void)reloadTableData
{
    if (currentIssue)
    {
        [mDataDic setValue:currentIssue forKey:[self getCurIssueKey:selectedSegmentIndex]];
        [btnIssue setTitle:currentIssue forState:UIControlStateNormal];
        [mRefreshView refreshLastUpdatedDate];
        [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
    }
    [self doAutoUpdate];
}

- (NSString*)getLotteryId:(NSInteger)index
{
    if (index == 1) {
        return @"300";
    }
    else if (index == 2) {
        return @"201";
    }
    else if (index == 3) {
        return @"400";
    }
    else if (index == 4) {
        return @"200";
    }
    return @"";
}

- (NSString*)getMatchListKey:(NSInteger)index
{
    if (index == 1) {
        return kZc;
    }
    else if (index == 2) {
        return kJc;
    }
    else if (index == 3) {
        return kBd;
    }
    else if (index == 4) {
        return klq;
    }
    return kMyAtt;
}

- (NSString*)getIssueListKey:(NSInteger)index
{
    if (index == 1) {
        return kZcIssue;
    }
    else if (index == 2) {
        return kJcIssue;
    }
    else if (index == 3) {
        return kBdIssue;
    }
    else if (index == 4) {
        return kLqIssue;
    }
    return nil;
}

- (NSString*)getCurIssueKey:(NSInteger)index
{
    if (index == 1) {
        return kZcCurrentIssue;
    }
    else if (index == 2) {
        return kJcCurrentIssue;
    }
    else if (index == 3) {
        return kBdCurrentIssue;
    }
    else if (index == 4) {
        return kLQCurrentIssue;
    }
    return nil;
}

- (NSString*)getCurPage:(NSInteger)index
{
    NSArray *arrVec = [mDataDic objectForKey:[self getMatchListKey:index]];
    if (arrVec && [arrVec count] > 0)
    {
        NSUInteger p = 2;
        if ([arrVec count] > 20)
        {
            p = [arrVec count]/20 + 1;
        }
        NSNumber *pageNum = [[NSNumber alloc] initWithInteger:p];
        NSString *pageStr = [pageNum stringValue];
        [pageNum  release];
        return pageStr;
    }
    return @"1";
}

#pragma 自动更新任务定时器
- (void)doAutoUpdate
{
    [UIApplication sharedApplication].idleTimerDisabled=YES;
	if ([[[Info getInstance] userId] intValue] == 0) {
		return;
	}
    [self onTimer:nil];
    if (mAutoUpdateTimer)
    {
        [mAutoUpdateTimer invalidate];
        mAutoUpdateTimer = nil;
    }
    if (mSegmentedControl.selectedSegmentIndex == 4) {
        mAutoUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:15
                                                            target:self
                                                          selector:@selector(onTimer:) // 回调函数
                                                          userInfo:nil
                                                           repeats:YES];
    }
    else {
        mAutoUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:60
                                                            target:self
                                                          selector:@selector(onTimer:) // 回调函数
                                                          userInfo:nil
                                                           repeats:YES];
    }
    
}

- (void)onTimer:(id)sender
{
    self.requestIndex = selectedSegmentIndex;
    if (requestIndex == 0)
    {
        [self getAutoRefreshMyAttRequest];
    }
    else
    {
        [self getAutoRefreshLotteryRequest];
    }
}

#pragma mark 2.93 发送数据和接收数据
- (void)getAutoRefreshMyAttRequest
{
	//    if ([self mRequest])
	//    {
	//        [mRequest clearDelegatesAndCancel];
	//    }
	//
	//    NSArray *arrVec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
	//    NSMutableArray *vec = [[NSMutableArray alloc] init];
	//    for (NSArray *arr in arrVec)
	//    {
	//        [vec addObjectsFromArray:arr];
	//    }
	//    NSString *matchListParam = [MatchInfo getMatchListParam:vec];
	//    [vec release];
	//
	//    self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL getCBAutoRefreshMyAttUrl]];
	//    [mRequest addRequestHeader:@"Accept" value:@"text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
	//    [mRequest addRequestHeader:@"Connection" value:@"keep-alive"];
	//    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	//    NSMutableData *data = (NSMutableData*)[matchListParam dataUsingEncoding:NSUTF8StringEncoding];
	//    [mRequest setPostBody:data];
	//    [mRequest setRequestMethod:@"POST"];
	//    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	//    [mRequest setDelegate:self];
	//    [mRequest setDidFinishSelector:@selector(reqAutoRefreshMyAttFinished:)];
	//    [mRequest startAsynchronous];
    if ([self autoRequest])
	{
        [autoRequest clearDelegatesAndCancel];
	}
    
    NSArray *arrVec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
    NSMutableArray *vec = [[NSMutableArray alloc] init];
    for (NSArray *arr in arrVec)
	{
        [vec addObjectsFromArray:arr];
	}
    NSString *matchListParam = [MatchInfo getMatchListParam:vec];
    [vec release];
     NSMutableString * url = [NetURL getCBAutoRefreshMyAttUrl];
    [url appendFormat:@"&%@", matchListParam];
    self.autoRequest = [ASIHTTPRequest requestWithURL: [NSURL URLWithString:[NetURL returnPublicUse:url] ]];
    [self.autoRequest addRequestHeader:@"Accept" value:@"text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
    [self.autoRequest addRequestHeader:@"Connection" value:@"keep-alive"];
    [self.autoRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
//    NSMutableData *data = (NSMutableData*)[matchListParam dataUsingEncoding:NSUTF8StringEncoding];
//    [self.autoRequest setPostBody:data];
    [self.autoRequest setRequestMethod:@"POST"];
    [self.autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [self.autoRequest setDelegate:self];
    [self.autoRequest setDidFinishSelector:@selector(reqAutoRefreshMyAttFinished:)];
    [self.autoRequest startAsynchronous];
	
}

- (void)reqAutoRefreshMyAttFinished:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	
	if (responseString)
    {
        if (mSegmentedControl.selectedSegmentIndex == 4) {
            
         
        }
        else {
        MatchInfo *info = [[MatchInfo alloc] initParserWithString2:responseString];
        
        NSArray *arrVec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
        NSMutableArray *vec = [[NSMutableArray alloc] init];
        for (NSArray *arr in arrVec)
        {   if ([arr isKindOfClass:[NSArray class]])
            {
                [vec addObjectsFromArray:arr];
            }
        
        }
        
        NSArray *matchArr = [MatchInfo getNewVecByOrder:vec oldList:info.oldList aNewList:info.aNewList];
        [mDataDic setObject:matchArr forKey:[self getMatchListKey:requestIndex]];
        [vec release];
        [info release];
        
        [mTableView reloadData];
        }
	}
}

#pragma mark 2.94 发送数据和接收数据
- (void)getAutoRefreshLotteryRequest
{
	//    if ([self mRequest])
	//    {
	//        [mRequest clearDelegatesAndCancel];
	//    }
	//
	//    NSArray *vec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
	//    NSString *matchIds = [MatchInfo getMatchIds:vec];
	//    NSString *notStartMatchs = [MatchInfo getNotStartMatchs:vec];
	//    matchIds = [matchIds stringByAppendingString:@"&"];
	//    matchIds = [matchIds stringByAppendingString:notStartMatchs];
	//    NSString *lotteryId = [self getLotteryId:requestIndex];
	//    NSString *curIssue = [mDataDic valueForKey:[self getCurIssueKey:requestIndex]];
	//
	//    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBAutoRefreshLottery:lotteryId Issue:curIssue]];
	//    [mRequest addRequestHeader:@"Accept" value:@"text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
	//    [mRequest addRequestHeader:@"Connection" value:@"keep-alive"];
	//    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	//    NSMutableData *data = (NSMutableData*)[matchIds dataUsingEncoding:NSUTF8StringEncoding];
	//    [mRequest setPostBody:data];
	//    [mRequest setRequestMethod:@"POST"];
	//    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	//    [mRequest setDelegate:self];
	//    [mRequest setDidFinishSelector:@selector(reqAutoRefreshLotteryFinished:)];
	//    [mRequest startAsynchronous];
    if ([self autoRequest])
	{
        [autoRequest clearDelegatesAndCancel];
	}
    if (mSegmentedControl.selectedSegmentIndex == 4) {
        NSString *curIssue = [mDataDic valueForKey:[self getCurIssueKey:requestIndex]];

        NSMutableArray *array = [mDataDic valueForKey:[self getMatchListKey:requestIndex]];
        NSMutableArray *array2 = [NSMutableArray array];
        if ([array count]) {
            for (BiFenZhiBoLanQiuData *data in array) {
                if (data.playId && ![data.state isEqualToString:@"2"]) {
                    [array2 addObject:data.playId];
                }
            }
        }
        NSString *play = [array2 componentsJoinedByString:@","];
        if ([play length]) {
            self.autoRequest = [ASIHTTPRequest requestWithURL:[NetURL CBrefreshLanQiuMatchListWithIssue:curIssue PlayId:play]];
            [autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [autoRequest setDelegate:self];
            [autoRequest setDidFinishSelector:@selector(reqAutoRefreshLanqiuFinished:)];
            [autoRequest setNumberOfTimesToRetryOnTimeout:2];
            [autoRequest startAsynchronous];
        }

        
    }
    else {
        NSArray *vec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
        NSString *matchIds = [MatchInfo getMatchIds:vec];
        NSString *notStartMatchs = [MatchInfo getNotStartMatchs:vec];
        matchIds = [matchIds stringByAppendingString:@"&"];
        matchIds = [matchIds stringByAppendingString:notStartMatchs];
        NSString *lotteryId = [self getLotteryId:requestIndex];
        NSString *curIssue = [mDataDic valueForKey:[self getCurIssueKey:requestIndex]];
        NSMutableString * url = [NetURL CBAutoRefreshLottery:lotteryId Issue:curIssue];
        [url appendFormat:@"&%@", matchIds];
       
        self.autoRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NetURL returnPublicUse:url] ]];
        [self.autoRequest addRequestHeader:@"Accept" value:@"text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"];
        [self.autoRequest addRequestHeader:@"Connection" value:@"keep-alive"];
        [self.autoRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        NSLog(@"match = %@", matchIds);
//        NSMutableData *data = (NSMutableData*)[matchIds dataUsingEncoding:NSUTF8StringEncoding];
//        [self.autoRequest setPostBody:data];
        [self.autoRequest setRequestMethod:@"POST"];
        [self.autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self.autoRequest setDelegate:self];
        [self.autoRequest setDidFinishSelector:@selector(reqAutoRefreshLotteryFinished:)];
        [self.autoRequest startAsynchronous];
    }
}

- (void)reqAutoRefreshLanqiuFinished:(ASIHTTPRequest*)request {
    NSString *responseString = [request responseString];
	if (responseString)
    {
        BiFenZhiBoLanQiuData *info = [[BiFenZhiBoLanQiuData alloc] initParserWithString:responseString];
        NSArray *vec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
        BOOL isStauteChange = NO;
        for (int i = 0;i < [vec count]; i ++) {
            BiFenZhiBoLanQiuData *info1 = [vec objectAtIndex:i];

            for (BiFenZhiBoLanQiuData *info2 in info.matchList) {
                if ([info2.playId isEqualToString:info1.playId]) {
                    if ([info1.state isEqualToString:@"0"] && [info2.state isEqualToString:@"1"]) {
                        isStauteChange = YES;
                    }
                    [BiFenZhiBoLanQiuData replaceMatch:info1 NewMatch:info2];
                }
            }

        }
        [mDataDic setObject:vec forKey:[self getMatchListKey:requestIndex]];
        
        [mTableView reloadData];
        if (isStauteChange) {
            [self getMatchListByIssueRequest];
        }
        if ([info.refreshtime intValue]) {

            if (mSegmentedControl.selectedSegmentIndex == 4) {
                if (mAutoUpdateTimer)
                {
                    [mAutoUpdateTimer invalidate];
                    mAutoUpdateTimer = nil;
                }
                mAutoUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:[info.refreshtime intValue]
                                                                    target:self
                                                                  selector:@selector(onTimer:) // 回调函数
                                                                  userInfo:nil
                                                                   repeats:YES];
            }
        }
        [info release];
    }
}

- (void)reqAutoRefreshLotteryFinished:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	if (responseString)
    {
        if (mSegmentedControl.selectedSegmentIndex == 4) {
            
        }
        else {
            MatchInfo *info = [[MatchInfo alloc] initParserWithString2:responseString];
            NSArray *vec = [mDataDic objectForKey:[self getMatchListKey:requestIndex]];
            NSArray *matchArr = [MatchInfo getNewVecByOrder:vec oldList:info.oldList noStartList:info.noStartList aNewList:info.aNewList];
            [mDataDic setObject:matchArr forKey:[self getMatchListKey:requestIndex]];
            [info release];
        }
        
        
        [mTableView reloadData];
	}
}

- (void)dealloc
{
    if (mRequest)
    {
        [mRequest clearDelegatesAndCancel];
        [mRequest release];
    }
    if (autoRequest) {
        [autoRequest clearDelegatesAndCancel];
        [autoRequest release];
    }
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [mTableView release];
    [headerView release];
    [lbLotteryName release];
    [btnIssue release];
    [mRefreshView release];
    [currentIssue release];
    [termTableController release];
    [mDataDic release];
    [moreLoadCell release];
    [curButton release];
    [mSegmentedControl release];
    [tMatch release];
    [mPageNum release];
    
    [super dealloc];
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 10001) {
		switch (buttonIndex) {
			case 1:
			{
				[self doLogin];
			}
				break;
				
			default:
				break;
		}
	}
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
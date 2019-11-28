//
//  TopicThemeListViewController.m
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TopicThemeListViewController.h"
#import "CheckNetwork.h"
#import "DataUtils.h"
#import "NetURL.h"
#import "YtTopic.h"
#import "ColorUtils.h"
#import "HomeCell.h"
#import "DetailedViewController.h"
#import "NewPostViewController.h"
#import "NSStringExtra.h"
#import "YtTopic.h"
#import "DetailedViewController.h"
#import "MoreLoadCell.h"
#import "Info.h"
#import "YDDebugTool.h"
#import "caiboAppDelegate.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "SBJSON.h"
#import "SachetViewController.h"
#import "SendMicroblogViewController.h"
#import "MobClick.h"
#import "SharedDefine.h"
#import "SharedMethod.h"
#import "JSON.h"
#import "MobClick.h"

@implementation TopicThemeListViewController

@synthesize themeTopicVec;
@synthesize userId, themeName, themeId;
@synthesize tableView;
@synthesize mCollectBtn;
@synthesize mRequest;
@synthesize cpsanliu;
@synthesize three;
@synthesize jinnang;
@synthesize homebool;
@synthesize orignalRequest;
@synthesize likeRequest;

//@synthesize mNetworkQueue;
- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename homebol:(BOOL)hbol{
    if ((self = [super init])) 
    {
        homebool = hbol;
		self.userId = userid;
        self.themeId = themeid;
		self.themeName = themename;
        NSString * str = [themeName stringByReplacingOccurrencesOfString:@"#" withString:@"" ];
        self.title = themeName;
		self.CP_navigation.title = str;
        
		self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	}
	return self;
}
- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename
{
	if ((self = [super init])) 
    {
		self.userId = userid;
        self.themeId = themeid;
		self.themeName = themename;
    NSString * str = [themeName stringByReplacingOccurrencesOfString:@"#" withString:@"" ];
    self.title = themeName;
		self.CP_navigation.title = str;
    
		self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	}
	return self;
}
- (id)initWithUserId:(NSString*)userid themeId:(NSString*)themeid themeName:(NSString*)themename andTest:(NSString *)testName
{
    if ((self = [super init])) 
        {
		self.userId = userid;
        self.themeId = themeid;
		self.themeName = themename;
		self.CP_navigation.title = testName;
		self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
	return self;

}
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad 
{
    [super viewDidLoad];
//    NSLog(@"cpsanliuwu %d", self.cpsanliu);
//	if (self.cpsanliu == CpSanLiuWuyes) {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeiBoLike:) name:@"refreshWeiBoLike" object:nil];
   
//    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
//    [rigthItem addTarget:self action:@selector(gouToHome) forControlEvents:UIControlEventTouchUpInside];
//    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
//    self.CP_navigation.rightBarButtonItem = rigthItemButton;
//    [rigthItemButton release];
    
    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(gouToHome) ImageName:nil Size:CGSizeMake(70,30)];
    
    self.CP_navigation.titleLabel.frame = CGRectMake(50, 0, 320 -100, self.CP_navigation.titleLabel.frame.size.height);
    self.CP_navigation.titleLabel.font = [UIFont boldSystemFontOfSize:18];
#ifdef isCaiPiaoForIPad
    [self.mainView addSubview:self.tableView];
     self.mainView.frame = CGRectMake(0, 44, 390, 1024-31);
    self.view.frame = CGRectMake(0, 0, 390, 768);
    self.view.backgroundColor = [UIColor clearColor];
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 390, self.view.frame.size.height);
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    upImageView.frame = CGRectMake(upImageView.frame.origin.x, upImageView.frame.origin.y, 390, upImageView.frame.size.height);
   self.tableView.frame = CGRectMake(0, 0, 390, self.mainView.frame.size.height - 330);
    
    
    
    UIImageView * upbgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 330, 390, 44)];
    upbgView.backgroundColor = [UIColor clearColor];
    upbgView.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    upbgView.userInteractionEnabled = YES;
    [self.mainView addSubview:upbgView];
    [upbgView release];
    
    UIButton * huatiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    huatiButton.frame = CGRectMake((390-60)/2, self.mainView.frame.size.height - 330, 60, 44);
    [huatiButton setImage:UIImageGetImageFromName(@"wb_write_normal.png") forState:UIControlStateNormal];
    [huatiButton setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];

    [huatiButton addTarget:self action:@selector(doWriteTopic) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:huatiButton];
    
#else
//    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//     self.mainView.frame = CGRectMake(0, 44, 320, self.view.frame.size.height);
//    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    NSLog(@"h = %f", self.view.frame.size.height);
    
    [self.view insertSubview:self.tableView atIndex:10000];
    
    self.tableView.frame = CGRectMake(0, 44, 320, self.tableView.frame.size.height-44);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
#ifdef isHaoLeCai
        self.tableView.frame = CGRectMake(0, 44, 320, self.tableView.frame.size.height);
#else
        self.tableView.frame = CGRectMake(0, 44 + 20, 320, self.tableView.frame.size.height - 20);
#endif
    }

    
    
    
    UIImageView * upbgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 44, 320, 44)];
    upbgView.backgroundColor = [UIColor clearColor];
    upbgView.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    upbgView.userInteractionEnabled = YES;
    [self.mainView addSubview:upbgView];
    [upbgView release];
    
    UIButton * huatiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    huatiButton.frame = CGRectMake((320-60)/2, self.mainView.frame.size.height - 44, 60, 44);
    [huatiButton setImage:UIImageGetImageFromName(@"wb_write_normal.png") forState:UIControlStateNormal];
    [huatiButton setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];    [huatiButton addTarget:self action:@selector(doWriteTopic) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:huatiButton];
    
    
#endif
    
    
    
//    if (homebool) {
//        [self viewWillAppear:YES];
//    }
    
        
       

//    }else{
//        UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(goHome)];
//        [self.navigationItem setRightBarButtonItem:rightItem];
//        [rightItem release];
//    }
//    UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(goHome)];
//    [self.navigationItem setRightBarButtonItem:rightItem];
//    [rightItem release];
    
	fristLoading = YES;
	topicLoadedEnd = NO;
	
	if (_refreshHeaderView == nil) 
    {
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height)];
		headerview.delegate = self;
		[self.tableView addSubview:headerview];
		_refreshHeaderView = [headerview retain];
		[headerview release];
	}
	
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];
    
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.CP_navigation.leftBarButtonItem = leftItem;
	
	
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView *background = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"background.jpg")];
    [tableView addSubview:background];
    [background release];
    
    UIButton *collectBtn = [[UIButton buttonWithType:(UIButtonTypeCustom)] retain];
    [collectBtn setBackgroundColor:[UIColor clearColor]];
    [collectBtn setImage:UIImageGetImageFromName(@"collect.png") forState:(UIControlStateNormal)];
    [self changeCollectBtn:collectBtn];
    [collectBtn release];
   
  //  addCollectionBtn = [Info CollectBtnInit:self imageNamed:@"collect.png" action:@selector(doCollectTheme)];
   // cancelCollectionBtn = [Info CollectBtnInit:self imageNamed:@"collectCancel.png" action:@selector(doDelCollectionTheme)];
    
    mProgressBar = [[ProgressBar getProgressBar] retain];
	
	self.tableView.backgroundColor=[UIColor cellBackgroundColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)gouToHome{
    if (homebool) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hometozhuye" object:nil];
    }else{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    }
    
}

- (void)goHome{
    if (homebool) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hometozhuye" object:nil];
    }else{
     [[caiboAppDelegate getAppDelegate] switchToHomeView];
    }
   
}

- (void)doBack
{
    if (jinnang) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-3] animated:YES];
//        SachetViewController * sac = [[SachetViewController alloc] init];
//        [self.navigationController pushViewController:sac animated:YES];
//        [sac release];
    }else{
        [self.navigationController popViewControllerAnimated:YES];	
    }
	
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	[_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];	
}

// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (self.tableView.contentSize.height-scrollView.contentOffset.y<=360.0) 
    {
		if (!topicLoadedEnd)
        {
			if (moreCell) 
            {
				[moreCell spinnerStartAnimating];
				[self performSelector:@selector(sendMoreYtTopicRequest) withObject:nil afterDelay:.5];
			}
		}
	}	
	[_refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
}

// 在这边 发送  刷新 请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	fristLoading = YES;
	topicLoadedEnd = NO;
    [self reloadTableViewDataSource];
	[_refreshHeaderView setState:CBPullRefreshLoading];
	self.tableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
	[self sendThemeYtTopicrequet];
}

-(void)doneLoadedTableViewData
{
	_reloading = NO;
	[_refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)reloadTableViewDataSource
{
	_reloading = YES;
}

//  返回 判断  reload 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

// 话题下写微博
- (IBAction)doWriteTopic
{
    [MobClick event:@"event_huati_faweibo" label:self.CP_navigation.title];
    
#ifdef isCaiPiaoForIPad
    
    YtTopic *topic = [[YtTopic alloc] init];
	
	if (self.userId == nil||[self.userId isEqualToString:@""])
    {
		NSMutableString *str = [[NSMutableString alloc] init];
//		[str appendString:@"#"];
		[str appendFormat:@"%@", self.CP_navigation.title];
//		[str appendString:@"#"];
		topic.nick_name = str;
		[str release];
	}
    else
    {
        //topic.nick_name = self.navigationItem.title;
        NSMutableString *str = [[NSMutableString alloc] init];
//        [str appendString:@"#"];
        [str appendFormat:@"%@",    self.CP_navigation.title];
//        [str appendString:@"#"];
        topic.nick_name = str;
        [str release];
        
    }
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic three:three];
    [topic release];
   
    
#else
//    NewPostViewController *newYtThemeConntrller = [[NewPostViewController alloc] init];
//	newYtThemeConntrller.publishType = kNewTopicController;
//    if (three) {
//        newYtThemeConntrller.three = YES;
//    }else{
//        newYtThemeConntrller.three = NO;
//    }
//	
//	YtTopic *topic = [[YtTopic alloc] init];
//	
//	if (self.userId == nil||[self.userId isEqualToString:@""])
//    {
//		NSMutableString *str = [[NSMutableString alloc] init];
////		[str appendString:@"#"];
//		[str appendFormat:@"%@", self.CP_navigation.title];
////		[str appendString:@"#"];
//		topic.nick_name = str;
//		[str release];
//	}
//    else
//    {
//        //topic.nick_name = self.navigationItem.title;
//        NSMutableString *str = [[NSMutableString alloc] init];
////        [str appendString:@"#"];
//        [str appendFormat:@"%@", self.CP_navigation.title];
////        [str appendString:@"#"];
//        topic.nick_name = str;
//        [str release];
//        
//    }
//	
//	newYtThemeConntrller.mStatus = topic;

//    [self.navigationController pushViewController:newYtThemeConntrller animated:YES];
//     [newYtThemeConntrller release];
//	[topic release];
    
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;
    if (three) {
        publishController.three = YES;
    }else{
        publishController.three = NO;
    }
    
    YtTopic *topic = [[YtTopic alloc] init];
    
    if (self.userId == nil||[self.userId isEqualToString:@""])
    {
        NSMutableString *str = [[NSMutableString alloc] init];
        //		[str appendString:@"#"];
        [str appendFormat:@"%@", self.CP_navigation.title];
        //		[str appendString:@"#"];
        topic.nick_name = str;
        [str release];
    }
    else
    {
        //topic.nick_name = self.navigationItem.title;
        NSMutableString *str = [[NSMutableString alloc] init];
        //        [str appendString:@"#"];
        [str appendFormat:@"%@", self.CP_navigation.title];
        //        [str appendString:@"#"];
        topic.nick_name = str;
        [str release];
        
    }
    
    publishController.mStatus = topic;
    [topic release];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];

#endif
    
	}

// 收藏话题
-(void)doCollectTheme
{
    [mProgressBar show:@"处理中..." view:(self.view)];
    mProgressBar.mDelegate = self;
	[mRequest clearDelegatesAndCancel];
	[self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBcollectTheme:themeId Theme:themeName UserId:[[Info getInstance]userId]]]];
	[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqCollectThemeFinished:)];
    [mRequest startAsynchronous];
}

// 取消收藏话题
-(void)doDelCollectionTheme
{
    [mProgressBar show:@"处理中..." view:(self.view)];
     mProgressBar.mDelegate = self;
	[mRequest clearDelegatesAndCancel];
	[self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBdelCollectionTheme:themeId Theme:themeName UserId:[[Info getInstance]userId]]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqDelCollectionThemeFinished:)];
    [mRequest startAsynchronous];
}

// 改变收藏按钮
- (void)changeCollectBtn:(UIButton*)button
{
    if (mCollectBtn) 
    {
        [mCollectBtn removeFromSuperview];
    }
    self.mCollectBtn = button;
    [mCollectBtn setFrame:CGRectMake(180, self.view.bounds.size.height - 106, 60, 44)];
  //  [self.view addSubview:mCollectBtn];
}

// 关闭进度条
- (void) dismissProgressBar
{
    if (mProgressBar) 
    {
        [mProgressBar dismiss];
    }
}

- (void)prograssBarBtnDeleate:(NSInteger) type
{
    [mProgressBar dismiss];
}

- (void)reqCollectThemeFinished:(ASIHTTPRequest*)req
{
    NSString *responseStr =  [req responseString];
    if ([responseStr isEqualToString:@"fail"]) 
    {
        
    }
    else
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
            [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(dismissProgressBar)
                                           userInfo:nil
                                            repeats:NO];
            NSString *resultStr = [dic valueForKey:@"result"];
            if ([resultStr isEqualToString:@"succ"]) 
            {
                [mProgressBar setTitle:@"操作成功"];
                [self changeCollectBtn:cancelCollectionBtn];
            }
            else
            {
                [mProgressBar setTitle:@"操作失败"];
            }
        }
        [jsonParse release];
    }
}

- (void)reqDelCollectionThemeFinished:(ASIHTTPRequest*)req
{
    NSString *responseStr =  [req responseString];
    if ([responseStr isEqualToString:@"fail"]) 
    {
        
    }
    else
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
            NSString *resultStr = [dic valueForKey:@"result"];
            if ([resultStr isEqualToString:@"succ"]) 
            {
                [mProgressBar setTitle:@"操作成功"];
                [self changeCollectBtn:addCollectionBtn];
            }
            else
            {
                [mProgressBar setTitle:@"操作失败"];
            }
        }
        [jsonParse release];
    }
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	if (!themeTopicVec||[[Info getInstance] isNeedRefreshHome]) 
    {
        [self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
        [[Info getInstance] setIsNeedRefreshHome:NO];
	}
    
    [self.tableView reloadData];
}

- (void)sendThemeYtTopicrequet
{
	if ([CheckNetwork isExistenceNetwork]) 
    {
        if (!mNetworkQueue) 
        {
			mNetworkQueue = [[ASINetworkQueue alloc] init];
           [mNetworkQueue setMaxConcurrentOperationCount:1];
		}
        [mNetworkQueue reset];
        [mNetworkQueue setRequestDidFinishSelector:@selector(doneLoadingTableViewData:)];
        [mNetworkQueue setDelegate:self];

        ASIHTTPRequest *request;
        if (self.userId == nil||[self.userId isEqualToString:@""]) 
        { // 搜索 帖子	
        
//        request = [ASIHTTPRequest requestWithURL:[NetURL CBsearchTopicList:self.themeName pageNum:@"1" pageSize:@"20"]];
            self.userId = @"1111";
            request = [ASIHTTPRequest requestWithURL:[NetURL CBgetThemetYtTipic:self.userId themeName:self.themeName pageNum:@"1" pageSize:@"20"]];
		}
        else 
        { // 2.31 获取 关注下 发帖	
        request = [ASIHTTPRequest requestWithURL:[NetURL CBgetThemetYtTipic:self.userId themeName:self.themeName pageNum:@"1" pageSize:@"20"]];
           
		}
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
        
        [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];        
        [mNetworkQueue addOperation:request];
        
//        request = [ASIHTTPRequest requestWithURL:[NetURL CBgetThemeStatus:themeId Theme:themeName UserId:[[Info getInstance]userId]]];
//        [request setUserInfo:[NSDictionary dictionaryWithObject:@"request2" forKey:@"name"]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [mNetworkQueue addOperation:request];
        [mNetworkQueue go];
	}
}

// 请求接收
- (void)doneLoadingTableViewData:(ASIHTTPRequest*)mrequest
{	
    
    NSLog(@"sstrii = %@", [mrequest responseString]);
    
    NSDictionary *dic = (NSDictionary*)mrequest.userInfo;
    
    NSString *str = [dic objectForKey:@"name"];
    
     NSString *responseString = [mrequest responseString];	
    
    if (str&&[str isEqualToString:@"request1"]) {
        
        if (responseString) 
        {
            YtTopic *topic = [[YtTopic alloc]initWithParse:responseString];
            self.themeTopicVec = topic.arrayList;
            [topic release];
        }
        
        [self.tableView reloadData];
        
        if(moreCell)
        {
            [moreCell setType:MSG_TYPE_LOAD_MORE];
        }
        
        // 模拟 延迟  完成接收
        [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5]; 
        
    }else if(str&&[str isEqualToString:@"request2"]){
    
        if ([responseString isEqualToString:@"fail"]) 
        {
            
        }
        else
        {
            SBJSON *jsonParse = [[SBJSON alloc] init];
            NSDictionary *dic = [jsonParse objectWithString:responseString];
            if (dic) 
            {
                NSString *statusStr = [dic valueForKey:@"isCc"];
                if ([statusStr isEqualToString:@"0"]) 
                {
                    [self changeCollectBtn:addCollectionBtn];
                }
                else if([statusStr isEqualToString:@"1"])
                {
                    [self changeCollectBtn:cancelCollectionBtn];
                }
            }
            [jsonParse release];
        }

    
    }
    
    
		
}

// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request
{
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView 
{
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger count = [themeTopicVec count];
    return (!count) ? count:count+1;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat cellHeigth ;
	
	if (indexPath.row == [themeTopicVec count]) 
    {
		cellHeigth = 60.0;
	}
    else 
    {
		YtTopic *pic = [themeTopicVec objectAtIndex:indexPath.row];
		cellHeigth  = pic.cellHeight;
	}
	
	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) 
    {
        self.tableView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } 
    else 
    {
        self.tableView.backgroundColor = [UIColor cellBackgroundColor];
        _refreshHeaderView.backgroundColor = [UIColor cellBackgroundColor];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    static NSString *CellIdentifier;
    
	if (indexPath.row ==[themeTopicVec count]) 
    {
		CellIdentifier = @"MoewLoadCell";
        
		MoreLoadCell *cell = (MoreLoadCell*)[atableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if(cell == nil)
        {
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.backgroundColor = [UIColor clearColor];
		}
		
        if (!topicLoadedEnd)
        {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                [self performSelector:@selector(sendMoreYtTopicRequest) withObject:nil afterDelay:.5];
            }
			
		}
        
		if (moreCell == nil) 
        {
			moreCell = cell;
        
		}
		return cell;
	} 
    else 
    {
		CellIdentifier = @"TopicCell";
		
		HomeCell *cell =(HomeCell*) [atableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if(cell == nil) 
        {
			cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
             cell.backgroundColor = [UIColor clearColor];
		}
        
		YtTopic *status = [themeTopicVec objectAtIndex:indexPath.row];
		if (status) 
        {
            status.tableView = tableView;
            status.indexPath = indexPath;
            cell.status = status;
            [cell update:tableView];
		}
        cell.homeCellDelegate = self;
		return cell;
	}
	return nil;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	[tableView deselectRowAtIndexPath:[atableView indexPathForSelectedRow] animated:YES];
    
	if (indexPath.row == [themeTopicVec count]) 
    {
		MoreLoadCell *cell = (MoreLoadCell*)[atableView cellForRowAtIndexPath:indexPath];
		if (!topicLoadedEnd) 
        {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                [self performSelector:@selector(sendMoreYtTopicRequest) withObject:nil afterDelay:.5];
            }
						
		}
	}
    else 
    {
        NSLog(@"%@", themeTopicVec);
    
		YtTopic *topic = [themeTopicVec objectAtIndex:indexPath.row];
		DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:topic];
		[self.navigationController pushViewController:detailed animated:YES];
		[detailed release];
	}
}

- (void)sendMoreYtTopicRequest
{
	if ([CheckNetwork isExistenceNetwork]) 
    {
		[mRequest clearDelegatesAndCancel];
		
		if (self.userId == nil||[self.userId isEqualToString:@""]) 
        {
        NSLog(@"self.themename = %@", self.themeName);
            [self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsearchTopicList:self.themeName pageNum:[self loadedCount] pageSize:@"20"]]];
		}
        else 
        {
            [self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetThemetYtTipic:self.userId themeName:self.themeName pageNum:[self loadedCount] pageSize:@"20"]]];
		}
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(moreTopictableViewDataBack:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
        [mRequest startAsynchronous];
	}
}

- (void)moreTopictableViewDataBack:(ASIHTTPRequest*)mrequest
{	
	NSString *responseString = [mrequest responseString];	
	if (responseString) 
    {
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		if ([topic.arrayList count] > 0)
        {
			if (themeTopicVec) 
            {
				[themeTopicVec addObjectsFromArray:topic.arrayList];
                NSLog(@"topic = %@", topic.count_pl);
			}
            [self.tableView reloadData];
		}
        else 
        {
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
			topicLoadedEnd = YES;
           
		}
		[topic release];
//		[self.tableView reloadData];
	}
	[moreCell spinnerStopAnimating];
	fristLoading = NO;
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }

}

// 计算 点击 “更多 ”次数
- (NSString*)loadedCount
{
	NSString *count;
	if (fristLoading) 
    {
		topicLoadCount = 1;
	}
    
	topicLoadCount++;
	NSNumber *num = [[NSNumber alloc] initWithInteger:topicLoadCount];
	count = [num stringValue];
	[num release];
    
	return count;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidUnload];
	self.tableView = nil;
	self.mRequest=nil;
	self.themeTopicVec=nil;
	self.userId=nil;
	self.themeName =nil;
	self.themeId =nil;
	self.mCollectBtn=nil;
	
    [mProgressBar release]; mProgressBar = nil;
	
}

- (void)dealloc 
{
	[_refreshHeaderView release];
    [mNetworkQueue reset];
	[mNetworkQueue release];
	[mRequest clearDelegatesAndCancel];
	[mRequest  release];
	[themeTopicVec release];
	[tableView release];
	[userId release];
	[themeName release];
    [themeId release];
    [mCollectBtn release];
    [addCollectionBtn release];
    [cancelCollectionBtn release];
    [mProgressBar release];
    [orignalRequest clearDelegatesAndCancel];
    self.orignalRequest = nil;
    
    [likeRequest clearDelegatesAndCancel];
    self.likeRequest = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshWeiBoLike" object:nil];
    
    [super dealloc];
}

-(void)touchHomeCellBottomButton:(UIButton *)bottomButton homeCell:(HomeCell *)homeCell ytTopic:(YtTopic *)ytTopic
{
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
    }else{
        if (bottomButton.tag == 100) {

            SendMicroblogViewController * publishController = [[[SendMicroblogViewController alloc] init] autorelease];
            [publishController setMStatus: ytTopic];
            [MobClick event:@"event_weibohudong_guangchang_zhuanfa"];
            publishController.microblogType = ForwardTopicController;// 转发
            
            UINavigationController * nav = [[[UINavigationController alloc] initWithRootViewController:publishController] autorelease];
            [self presentViewController:nav animated: YES completion:nil];
            
        }
        else if (bottomButton.tag == 102) {
            
            //赞赞赞赞赞赞
            likeYtTopic = ytTopic;
            likeButton = bottomButton;
            
            [likeRequest clearDelegatesAndCancel];
            self.likeRequest = [ASIHTTPRequest requestWithURL:[NetURL weiBoLikeByTopicId:ytTopic.topicid praisestate:ytTopic.praisestate]];
            [likeRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [likeRequest setDelegate:self];
            [likeRequest setDidFinishSelector:@selector(likeRequestDidFinishSelector:)];
            [likeRequest setNumberOfTimesToRetryOnTimeout:2];
            [likeRequest setShouldContinueWhenAppEntersBackground:YES];
            [likeRequest startAsynchronous];
        }
    }
}

-(void)likeRequestDidFinishSelector:(ASIHTTPRequest *)request
{
    NSString * requestStr = [request responseString];
    if (requestStr && ![requestStr isEqualToString:@"fail"]) {
        NSDictionary * requestDic = [requestStr JSONValue];
        
        NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
        
        likeYtTopic.count_dz = [[weiBoLikeDic valueForKey:likeYtTopic.topicid] objectAtIndex:0];
        likeYtTopic.praisestate = [[requestDic valueForKey:@"praisestate"] description];
        if ([likeYtTopic.praisestate integerValue]) {
            likeYtTopic.count_dz = [NSString stringWithFormat:@"%d",(int)[likeYtTopic.count_dz integerValue] + 1];
        }else{
            likeYtTopic.count_dz = [NSString stringWithFormat:@"%d",(int)[likeYtTopic.count_dz integerValue] - 1];
        }
        
        [weiBoLikeDic setObject:@[likeYtTopic.count_dz,likeYtTopic.praisestate] forKey:likeYtTopic.topicid];
        [[NSUserDefaults standardUserDefaults] setValue:weiBoLikeDic forKey:@"weiBoLike"];
        
        UIImageView * likeImageView = (UIImageView *)[likeButton viewWithTag:200];
        UILabel * likeCountLabel = (UILabel *)[likeButton viewWithTag:201];
        
        float likeW = 0;
        
        if ([likeYtTopic.count_dz integerValue]) {
            
            likeW = [likeYtTopic.count_dz sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            likeCountLabel.text = likeYtTopic.count_dz;
        }else{
            likeW = [@"赞" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            likeCountLabel.text = @"赞";
        }
        likeCountLabel.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2 + 13 + 5, 0, likeW, WEIBO_BOTTOMBUTTON_HEIGHT);
        
        if ([likeYtTopic.praisestate integerValue]) {
            likeCountLabel.textColor = [SharedMethod getColorByHexString:@"f56a1d"];
            likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like_1.png");
        }else{
            likeCountLabel.textColor = [SharedMethod getColorByHexString:@"929292"];
            likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like.png");
        }
        likeImageView.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2, (WEIBO_BOTTOMBUTTON_HEIGHT - 11.5)/2, 13, 11.5);
    }
}


-(void)touchColorViewByYtTopic:(YtTopic *)ytTopic
{
    [orignalRequest clearDelegatesAndCancel];
    self.orignalRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:ytTopic.orignal_id]];
    [orignalRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [orignalRequest setDelegate:self];
    [orignalRequest setDidFinishSelector:@selector(orignalRequestDidFinishSelector:)];
    [orignalRequest setNumberOfTimesToRetryOnTimeout:2];
    [orignalRequest setShouldContinueWhenAppEntersBackground:YES];
    [orignalRequest startAsynchronous];
}

-(void)orignalRequestDidFinishSelector:(ASIHTTPRequest *)mrequest{
    
    NSString *result = [mrequest responseString];
    YtTopic * orignalYtTopic = [[[YtTopic alloc] initWithParse:result] autorelease];
    YtTopic * orignalYtTopic1 = [orignalYtTopic.arrayList objectAtIndex:0];
    
    DetailedViewController *detailed = [[[DetailedViewController alloc] initWithMessage:orignalYtTopic1] autorelease];
    [detailed setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailed animated:YES];
}

-(void)refreshWeiBoLike:(NSNotification *)notification
{
    YtTopic * ytTopic = notification.object;
    HomeCell * homeCell = (HomeCell *)[tableView cellForRowAtIndexPath:ytTopic.indexPath];
    
    //    UIButton * likeButton = (UIButton *)[homeCell viewWithTag:102];
    UIImageView * likeImageView = (UIImageView *)[homeCell viewWithTag:200];
    UILabel * likeCountLabel = (UILabel *)[homeCell viewWithTag:201];
    
    NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
    
    NSString * count_dz = [[weiBoLikeDic valueForKey:ytTopic.topicid] objectAtIndex:0];
    NSString * praisestate = [[weiBoLikeDic valueForKey:ytTopic.topicid] objectAtIndex:1];
    
    float likeW = 0;
    if ([count_dz integerValue]) {
        likeW = [count_dz sizeWithFont:WEIBO_ZHUANFA_FONT].width;
        likeCountLabel.text = count_dz;
    }else{
        likeW = [@"赞" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
        likeCountLabel.text = @"赞";
    }
    likeCountLabel.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2 + 13 + 5, 0, likeW, WEIBO_BOTTOMBUTTON_HEIGHT);
    
    if ([praisestate integerValue]) {
        likeCountLabel.textColor = [SharedMethod getColorByHexString:@"f56a1d"];
        likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like_1.png");
    }else{
        likeCountLabel.textColor = [SharedMethod getColorByHexString:@"929292"];
        likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like.png");
    }
    likeImageView.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2, (WEIBO_BOTTOMBUTTON_HEIGHT - 11.5)/2, 13, 11.5);
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
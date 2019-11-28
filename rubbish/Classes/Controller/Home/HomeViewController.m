//
//  HomeViewController.m
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "YtTopic.h"
#import "NewPostViewController.h"
#import "SendMicroblogViewController.h"
#import "DetailedViewController.h"
#import "datafile.h"
#import "ColorUtils.h"
#import "MoreLoadCell.h"
#import "DataUtils.h"
#import "Info.h"
#import "NSStringExtra.h"
#import "YDDebugTool.h"
#import "caiboAppDelegate.h"

#import "ProfileViewController.h"
#import "ASINetworkQueue.h"
#import "SBJSON.h"
#import "NewsPromptBar.h"
#import "CheckNewMsg.h"
#import "LastLotteryViewController.h"
#import "caiboAppDelegate.h"
#import "LotteryNewsCell.h"
#import "CustomHomeViewController.h"
#import "MoreNewsViewController.h"
#import "HotYtTopicandComment.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "LotteryPreferenceViewController.h"
#import "JSON.h"
#import "CPThreeMyDataViewController.h"
#import "FansViewController.h"

#import "BudgeButton.h"
#import "PreJiaoDianTabBarController.h"
#import "MyProfileViewController.h"
#import "CP_PTButton.h"
#import "MobClick.h"
#import "DownLoadImageView.h"
#import "LunBoView.h"
#import "NewsData.h"
#import "NewsViewController.h"

#import "GuangChangTopNewsCell.h"

#import "SharedDefine.h"
#import "SharedMethod.h"
#import "GCSearchViewController.h"
#import "MobClick.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
@implementation HomeViewController

@synthesize newstype,selectName,curRequest;

@synthesize chooseUserPicker,userPickerView,arryData;
@synthesize hongdongyt;
@synthesize topicDataArry;

@synthesize titleName;

@synthesize refreshHeaderView;

@synthesize mRequest;
@synthesize newimage;

@synthesize tableView;
@synthesize aNewVersion;
@synthesize advPicView,chaButton;
@synthesize dataDic;
@synthesize navView;
@synthesize username;
@synthesize pinglustr;
@synthesize guanzhustr;
@synthesize atmestr;
@synthesize sxstr;
@synthesize gzrftstr;
@synthesize chekrequest;
@synthesize dajiabool, xianshi;
@synthesize delegate;
@synthesize seachTextListarry, qingqiubool;
@synthesize topicidPict;
@synthesize orignalRequest;
@synthesize likeRequest;

#pragma mark -
#pragma mark View lifecycle

//YtTopic *status;

#pragma mark -
#pragma mark UISearchBarDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isQuxiao = NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isQuxiao = YES;
	[searchDC.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (PKsearchBar.superview && isQuxiao) {
        [PKsearchBar resignFirstResponder];
        [PKsearchBar removeFromSuperview];
    }
}

-(void)sendSeachRequest:(NSString*)keywords
{	
    isQuxiao = NO;
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords cpthree:YES];
	[seachPerson setHidesBottomBarWhenPushed:YES];
	seachPerson.cpthree = YES;
    
    seachPerson.titlestring = keywords;
    seachPerson.titlebool = YES;
	[self.navigationController pushViewController:seachPerson animated:NO];
	[seachPerson release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	if ([searchBar text]&&![searchBar.text  isEqualToString:@""]) {
		[self.seachTextListarry removeObject:searchBar.text];
		if ([self.seachTextListarry count]==10) {
			
			[seachTextListarry lastObject];
			
		}
		[self.seachTextListarry insertObject:searchBar.text atIndex:0]; 
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
		[self.seachTextListarry writeToFile:plistPath atomically:YES];
		[self.searchDisplayController.searchResultsTableView reloadData];
		
	}
	[self sendSeachRequest:searchBar.text];
	isQuxiao = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    isQuxiao = YES;
    [PKsearchBar resignFirstResponder];
	[PKsearchBar removeFromSuperview];
    
}
#pragma mark - 搜索按钮点击事件
- (void)pressSearch:(id)sender{
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		[self.view addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = YES;
	[self.view addSubview:PKsearchBar];
	[PKsearchBar becomeFirstResponder];
    
}

-(id)initWithBool:(BOOL)bol{
	
    
	if ((self=[super init])) {
        dajiabool = NO;
        
		if (bol) {
            self.title = @"广场";
            UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"广场" image:UIImageGetImageFromName(@"tabgc.png") tag:0];
            self.tabBarItem = messageItem;
            
            [messageItem release];
            
            
        }else{
            
            UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:2];
            
            self.tabBarItem = messageItem;
            
            [messageItem release];
            
        }
        homeViewControlerInstance = self;
	}
	return self;
    
}


- (void)hasLogin {
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_write_normal.png");
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    [rigthItem setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];
    [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
}


// 发送快讯类信息
- (void)SendNewsData:(NSDictionary *)dic {
	[self.curRequest clearDelegatesAndCancel];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" 
																				 pageSize:@"20" 
																					 para:[dic objectForKey:@"typeForSend"] 
																				   userId:[[Info getInstance]userId]]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(LoadYuCeData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
	self.curRequest = request;
}

// 发送预测类信息
- (void)SendYuCeData:(NSDictionary *)dic {
	[self.curRequest clearDelegatesAndCancel];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" 
																				 pageSize:@"20" 
																					 para:[dic objectForKey:@"typeForSend"] 
																				   userId:[[Info getInstance]userId]]];
	if ([[dic objectForKey:@"shortname"] isEqualToString:@"热转"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtTopic:[[Info getInstance]userId] 
																  pageNum:@"1" 
																 pageSize:@"20"]];
	}
	else if ([[dic objectForKey:@"shortname"] isEqualToString:@"热评"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtComment:[[Info getInstance]userId] 
                                                                    pageNum:@"1" 
                                                                   pageSize:@"20"]];
	}
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(LoadYuCeData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
	self.curRequest = request;
}

// 发送开奖类信息
- (void)SendKaiJiangData:(NSDictionary *)dic {
}

-(YtTopic*)changeData:(HotYtTopicandComment*)hotYtZfandComment{
	YtTopic *topic = [[[YtTopic alloc] init] autorelease];
    topic.userid = hotYtZfandComment.userId;
	topic.nick_name = hotYtZfandComment.nick_name;
	topic.vip = hotYtZfandComment.vip;
	topic.source = hotYtZfandComment.source;
	topic.timeformate = hotYtZfandComment.timeformate;
	topic.content = hotYtZfandComment.rec_content;
	topic.mcontent = hotYtZfandComment.mrec_content;
	topic.count_pl = hotYtZfandComment.count_pl;
	topic.count_zf = hotYtZfandComment.count_zt;
	topic.mid_image = hotYtZfandComment.mid_image;
	topic.attach_type = hotYtZfandComment.attach_type;
	topic.topicid = hotYtZfandComment.topicid;
	topic.orignal_id = hotYtZfandComment.orignal_id;
    topic.attach = hotYtZfandComment.attach;
    topic.attach_small = hotYtZfandComment.attach_small;
    topic.content_ref = hotYtZfandComment.content_ref;
    topic.nick_name_ref = hotYtZfandComment.nick_name_ref;
    topic.count_pl_ref = hotYtZfandComment.count_pl_ref;
    topic.count_zf_ref = hotYtZfandComment.count_zf_ref;
//    [topic calcTextBounds:topic];
	
	return topic;
}

- (void)LoadYuCeData:(ASIHTTPRequest*)mrequest{
//	NSString *responseString = [mrequest responseString];
//	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//	NSString *path=[paths    objectAtIndex:0];
//	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
//	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
//	NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
//	self.selectName = [[anArray objectAtIndex:selectBtn] objectForKey:@"shortname"];
//	if ([self.selectName isEqualToString:@"热评"]||[self.selectName isEqualToString:@"热转"]) {
//		HotYtTopicandComment *hot = [[HotYtTopicandComment alloc] initWithParse:responseString];
//		NSMutableArray *array1 = [[NSMutableArray alloc] init];
//        for (HotYtTopicandComment *data in hot.arryList) {
//            YtTopic *status = [self changeData:data];
//            [array1 addObject:status];
//        }
//		if ([array1 count]) {
//			[dataDic setValue:array1 forKey:selectName];
//			[topicMoreCell setType:MSG_TYPE_LOAD_MORE];
//		}else {
//			
//			[topicMoreCell setType:MSG_TYPE_LOAD_NODATA];
//		}
//		[array1 release];
//        [anArray release];
//		[hot release];
//	}
//	else {
//		
//		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
//		
//		if ([topic.arrayList count]>0) {
//			[dataDic setValue:topic.arrayList forKey:selectName];	
//			[topicMoreCell setType:MSG_TYPE_LOAD_MORE];
//			
//		}else {
//			
//			[topicMoreCell setType:MSG_TYPE_LOAD_NODATA];
//		}
//		[anArray release];
//		[dic release];
//		[topic release];
//	}
//	[self.tableView reloadData];
//	[topicMoreCell spinnerStopAnimating];
//	[tableView reloadData];
//	self.navigationItem.rightBarButtonItem.enabled = YES;
//	self.navigationItem.leftBarButtonItem.enabled = YES;
//	_reloading = NO;
//	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)LoadNewsData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths    objectAtIndex:0];
	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
	NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
	self.selectName = [[anArray objectAtIndex:selectBtn] objectForKey:@"shortname"];
	if ([topic.arrayList count]>0) {
		[dataDic setValue:topic.arrayList forKey:selectName];	
		[topicMoreCell setType:MSG_TYPE_LOAD_MORE];
		
	}else {
		
		[topicMoreCell setType:MSG_TYPE_LOAD_NODATA];
  
	}
	[anArray release];
	[dic release];
//	[self.tableView reloadData];
	[topicMoreCell spinnerStopAnimating];
	[tableView reloadData];
	self.navigationItem.rightBarButtonItem.enabled = YES;
	self.navigationItem.leftBarButtonItem.enabled = YES;
	_reloading = NO;
	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
   if ([topic.arrayList count] <= 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
//        [topicMoreCell spinnerStopAnimating];
        [topicMoreCell setInfoText:@"加载完毕"];
    }
    [topic release];
}

- (void)LoadMoreNewsData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths    objectAtIndex:0];
	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
	NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
	self.selectName = [[anArray objectAtIndex:selectBtn] objectForKey:@"shortname"];
	if ([topic.arrayList count]>0) {
		//[dataDic setValue:topic.arrayList forKey:selectName];	
		[[dataDic objectForKey:selectName] addObjectsFromArray:topic.arrayList];
		[topicMoreCell setType:MSG_TYPE_LOAD_MORE];
	}else {
		[dataDic setValue:topic.arrayList forKey:selectName];
		[topicMoreCell setType:MSG_TYPE_LOAD_NODATA];
    
	}
	[anArray release];
	[dic release];
//	[self.tableView reloadData];
	[topicMoreCell spinnerStopAnimating];
	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	[tableView reloadData];
    if ([topic.arrayList count] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
//        [topicMoreCell spinnerStopAnimating];
        [topicMoreCell setInfoText:@"加载完毕"];
    }
    [topic release];
}

- (void)LoadMoreYuCeData:(ASIHTTPRequest*)mrequest{

}

- (void)LoadKaijiangData:(ASIHTTPRequest*)mrequest{
	
}

- (void)newsChange:(UIButton *)sender {
	for (UIView *v in navView.subviews) {
		if (v.tag == 10001) {
			UIView *v = [self.view viewWithTag:10001];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.3];
			v.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width,sender.frame.size.height);
			[UIView commitAnimations];
		}
		else {
			UIButton *b = (UIButton *)v;
			b.selected = NO;
		}
        
	}
	selectBtn = sender.tag;
	sender.selected = YES;
	if (sender.tag == 5) {
		self.newstype = @"更多";
		[self.tableView reloadData];
	}
	else {
		if (sender.tag == 0) {
			self.newstype = @"首页";
			self.selectName = @"首页";
			[self SendHttpRequest];
		}
		else {
//			NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//			NSString *path=[paths    objectAtIndex:0];
//			NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
//			NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
//			if (!dic) {
//				plistPath = [[NSBundle mainBundle] pathForResource:@"persondata" ofType:@"plist"];
//				dic = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] retain];
//				[dic writeToFile:[path stringByAppendingPathComponent:@"persondata.plist"]  atomically:YES];
//			}
//			NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
//			SEL sel;
//			self.newstype = [[anArray objectAtIndex:sender.tag] objectForKey:@"type"];
//			self.selectName = [[anArray objectAtIndex:selectBtn] objectForKey:@"shortname"];
//			if ([[dataDic valueForKey:selectName] count]) {
//				[self.tableView reloadData];
//				[dic release];
//				return;
//			}
//			if ([self.newstype isEqualToString:@"快讯"]) {
//				sel = @selector(SendNewsData:);
//			}
//			else if ([self.newstype isEqualToString:@"预测"]) {
//				sel = @selector(SendYuCeData:);
//			}
//			else if ([self.newstype isEqualToString:@"开奖"]) {
//				sel = @selector(SendKaiJiangData:);
//			}
//			[self performSelector:sel withObject:[anArray objectAtIndex:sender.tag]];
//			[anArray release];
//			[dic release];
		}
	}
    
}
- (void)creatNav {
    //	if (!navView) {
    //		UIImageView *navView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    //		[self.view insertSubview:navView1 atIndex:0];
    //		navView1.userInteractionEnabled = YES;
    //		navView1.image = UIImageGetImageFromName(@"home_bg_00.png");
    //		self.navView = navView1;
    //		[navView1 release];
    //	}
    //	UIImageView *imageView = [[UIImageView alloc] init];
    //	imageView.frame = CGRectMake(5, 0, 45, 40);
    //	[navView addSubview:imageView];
    //	imageView.tag = 10001;
    //	imageView.image = UIImageGetImageFromName(@"bg_02.png");
    //	[imageView release];
    //	
    //	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //	NSString *path=[paths    objectAtIndex:0];
    //	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
    //	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
    //	if (!dic) {
    //		plistPath = [[NSBundle mainBundle] pathForResource:@"persondata" ofType:@"plist"];
    //		[dic release];
    //		dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //		[dic writeToFile:[path stringByAppendingPathComponent:@"persondata.plist"]  atomically:YES];
    //	}
    //	NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
    //	for (int i = 0 ; i <6 ;i ++) {
    //		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //		[btn setTitle:[[anArray objectAtIndex:i] objectForKey:@"shortname"] forState:UIControlStateNormal];
    //		if (i == 5) {
    //			[btn setTitle:@"更多" forState:UIControlStateNormal];
    //		}
    //		if (i == 0) {
    //			btn.selected = YES;
    //		}
    //		btn.tag = i;
    //		btn.backgroundColor = [UIColor clearColor];
    //		[btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    //		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    //		[btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    //		btn.frame = CGRectMake(5 + 53*i, 0, 45, 40);
    //		[btn addTarget:self action:@selector(newsChange:) forControlEvents:UIControlEventTouchUpInside];
    //		[navView addSubview:btn];
    //	}
    //	NSRange range;
    //	range.location = 0;
    //	range.length = 5;
    //	[anArray removeObjectsInRange:range];
    //	[anArray insertObject:[NSDictionary dictionaryWithObject:@"自定义导航栏" forKey:@"shortname"] atIndex:0];
    //	[self.dataDic setValue:anArray forKey:@"更多"];
    //	[dic release];
}

- (void)changNa:(NSNotification *)notification  {
	for (UIView *v in navView.subviews) {
		[v removeFromSuperview];
	}
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.frame = CGRectMake(270, 0, 45, 40);
	[navView addSubview:imageView];
	imageView.tag = 10001;
	imageView.image = UIImageGetImageFromName(@"bg_02.png");
	[imageView release];
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths    objectAtIndex:0];
	NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
	NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
	if (!dic) {
		plistPath = [[NSBundle mainBundle] pathForResource:@"persondata" ofType:@"plist"];
		dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
		[dic writeToFile:[path stringByAppendingPathComponent:@"persondata.plist"]  atomically:YES];
	}
	NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
	for (int i = 0 ; i <6 ;i ++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setTitle:[[anArray objectAtIndex:i] objectForKey:@"shortname"] forState:UIControlStateNormal];
		if (i == 5) {
			[btn setTitle:@"更多" forState:UIControlStateNormal];
			btn.selected = YES;
		}
		btn.tag = i;
		btn.backgroundColor = [UIColor clearColor];
		[btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
		btn.frame = CGRectMake(5 + 53*i, 0, 45, 40);
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(newsChange:) forControlEvents:UIControlEventTouchUpInside];
		[navView addSubview:btn];
	}
	NSRange range;
	range.location = 0;
	range.length = 5;
	[anArray removeObjectsInRange:range];
	[anArray insertObject:[NSDictionary dictionaryWithObject:@"自定义导航栏" forKey:@"shortname"] atIndex:0];
	[self.dataDic setValue:anArray forKey:@"更多"];
	[self.tableView reloadData];
	[dic release];
}

- (void)reCreatNav {
   	
}

-(void)topSearch
{
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        //添加搜索
        [MobClick event:@"event_weibo_sousuo"];
        GCSearchViewController * gcsear = [[GCSearchViewController alloc] init];
        [(UINavigationController *)caiboapp.window.rootViewController pushViewController:gcsear animated:YES];
        [gcsear searchbegin];
        [gcsear release];
    }
    else {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [(UINavigationController *)caiboapp.window.rootViewController pushViewController:loginVC animated:YES];
        [loginVC release];
    }
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
    
    [self requestChekNew];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeiBoLike:) name:@"refreshWeiBoLike" object:nil];
    
    self.CP_navigation.title = @"广场";
    
    if (dajiabool) {
        UIButton * searchButton = [[[UIButton alloc] initWithFrame:CGRectMake(215, 0, 44, 44)] autorelease];
        [searchButton addTarget:self action:@selector(topSearch) forControlEvents:UIControlEventTouchUpInside];
        searchButton.backgroundColor = [UIColor clearColor];
        [self.CP_navigation addSubview:searchButton];
        
        UIImageView * searchImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((searchButton.frame.size.width - 21)/2, (searchButton.frame.size.height - 21)/2, 21, 21)] autorelease];
        searchImageView.image = UIImageGetImageFromName(@"WeiBo_Search.png");
        [searchButton addSubview:searchImageView];
    }
    
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    self.view.frame = app.window.rootViewController.view.bounds;
    self.CP_navigation.leftBarButtonItem = nil;
    self.CP_navigation.backgroundColor = [UIColor clearColor];
#endif

    

#ifdef isHaoLeCai
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
#else
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
#endif
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	//tableView.backgroundView = backImage;
    [self.mainView addSubview:backImage];
    [backImage release];
    
        
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        self.CP_navigation.title = @"广场";
     
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];

         self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];

        
        [self CBRefreshTableHeaderDidTriggerRefresh:refreshHeaderView];
        titlev.hidden = YES;

	}
	else {
        
        
        UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_write_normal.png");
        rigthItem.bounds = CGRectMake(0, 0, 60, 44);
        [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
        [rigthItem setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];
        [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
        self.CP_navigation.rightBarButtonItem = rigthItemButton;
        [rigthItemButton release];
        
      
        
        [self CBRefreshTableHeaderDidTriggerRefresh:refreshHeaderView];
        
        
    }

    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height - 50) style:UITableViewStylePlain];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.mainView addSubview:tableView];
    tableView.backgroundColor = WEIBO_BG_COLOR;
    
    bannerArray = [[NSMutableArray alloc] initWithCapacity:0];
    topicidPict = [[NSMutableString alloc] init];

    
#ifdef isCaiPiaoForIPad
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y, 768, self.mainView.frame.size.height);
    tableView.frame = CGRectMake(0, 0, 390, self.mainView.frame.size.height-50);
#endif
    
    
    
    if (dajiabool) {
       
      
        self.CP_navigation.title = @"广场";
        seabut.hidden = NO;
        dajiabool = YES;
    }else{
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"gzrft"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
        }
        self.CP_navigation.title = @"好友";
        seabut.hidden = YES;
        dajiabool = NO;
        
    }
	newbool = NO;
    topDaJiaDouZaiShuo = 1;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changNa:) name:@"changeNa" object:nil];
    
    if(dajiabool){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressRefreshButton:) name:@"refreshWeibo" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressRefreshButton:) name:@"haoyourefreshWeibo" object:nil];
    }
        
    
 
    
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	self.dataDic = dic;
	[dic release];
	self.newstype = @"首页";
	self.selectName = @"首页";
	selectBtn= 0;
#ifdef isHaoLeCai
    self.mainView.backgroundColor = [UIColor clearColor];
#else
	self.mainView.backgroundColor = [UIColor lightGrayColor];
#endif
	[self creatNav];
    
	// 加载 下拉刷新控件
	if (refreshHeaderView==nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height)];
		headerview.backgroundColor = [UIColor clearColor];
		headerview.delegate = self;
		[tableView addSubview:headerview];
		self.refreshHeaderView = headerview;
		[headerview release];
		
	}
    // 初始化时间  如果失败，返回 “未更新”
	[refreshHeaderView refreshLastUpdatedDate];
	
    
	// 选择器 默认关闭
	ispickerOPen = YES;
	
	fristLoading = YES;
	
	topicLoadedEnd = NO;
    
	isGroup = NO;
	
	// 中间 放一个 控件 ，点击调出 用户分组选择器
	if (dajiabool) {
    }else{
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];//allocate titleView
        //导航上的两个按钮
        headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        headButton1.frame = CGRectMake(30, 7, 70, 30);
        headButton1.tag = 8040;
        [headButton1 setImage:UIImageGetImageFromName(@"wb_dt_0.png") forState:UIControlStateNormal];
      
        
        
        headButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        headButton2.frame = CGRectMake(100, 7, 70, 30);
        // [headButton2 setTitle:@"资料" forState:UIControlStateNormal];
        [headButton2 setImage:UIImageGetImageFromName(@"zl.png") forState:UIControlStateNormal];
      
        [headButton2 addTarget:self action:@selector(pressHeadButton2:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //    [self.navigationController.navigationBar addSubview:headButton1];
        //    [self.navigationController.navigationBar addSubview:headButton2];
        
        newimage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 20, 30, 15)];
        newimage.tag = 98;
        BudgeButton* budgeButton = [[BudgeButton alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
        budgeButton.budegeValue = @"new";
        [newimage addSubview:budgeButton];
        [budgeButton release];
        newimage.hidden = YES;

        [titleView release];
    }
    	
    mNewsPromptBar = [NewsPromptBar getInstance];
	
	isDeleted = YES;
	
//    tableView.backgroundColor = [UIColor clearColor];
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"hemai"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
    
    
    
    
}

- (void)requestChekNew{
    
    self.chekrequest = [ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]];
    //  [self setMrequest:[ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]]];
    [chekrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [chekrequest setDelegate:self];
    [chekrequest setDidFinishSelector:@selector(unReadPushNumData:)];
    //   [chekrequest setDidFailSelector:@selector(unReadPushNumDatafail:)];
    [chekrequest setNumberOfTimesToRetryOnTimeout:2];
    [chekrequest setShouldContinueWhenAppEntersBackground:YES];
    [chekrequest startAsynchronous];
    
}


- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{
    
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    pinglustr = [[dict objectForKey:@"pl"] intValue];
    sxstr = [[dict objectForKey:@"sx"] intValue];
    guanzhustr = [[dict objectForKey:@"gz"] intValue];
    atmestr = [[dict objectForKey:@"atme"] intValue];
    gzrftstr = [[dict objectForKey:@"gzrft"] intValue];
    NSInteger xttzint = [[dict objectForKey:@"xttz"] intValue];
    NSLog(@"gzrftstr = %ld", (long)gzrftstr);
    
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.tag = 200;
        prizeView.delegate = self;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    if (!dajiabool) {
        gzrftstr = 0;
    }
    
    if (pinglustr != 0||guanzhustr != 0|| atmestr != 0|| sxstr != 0 || gzrftstr != 0) {
        //        str11 = [check.gz intValue];
        //        str22 = [check.pl intValue];
        //        str33 = [check.atme intValue];
        //        str44 = [check.sx intValue];
       
        
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            CP_TabBarViewController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[CP_TabBarViewController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
               // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                NSString * zongshustr = [NSString stringWithFormat:@"%ld", (long)sxstr+(long)atmestr+(long)pinglustr+(long)xttzint ];
                 NSString * fensicout = [NSString stringWithFormat:@"%ld", (long)guanzhustr ];
                 NSString * couthaoyou = [NSString stringWithFormat:@"%ld", (long)gzrftstr ];
                
                NSMutableArray * zhuangtaiarr = [[NSMutableArray alloc] initWithCapacity:0];
                [zhuangtaiarr addObject:@"0"];
                [zhuangtaiarr addObject:@"0"];
                [zhuangtaiarr addObject:couthaoyou];
                [zhuangtaiarr addObject:zongshustr];
                [zhuangtaiarr addObject:fensicout];
                
                
                c.stateArray = zhuangtaiarr;
                [zhuangtaiarr release];
                
                
            }
        }
        
        
        newimage.hidden = NO;
        
    } else {
        
        
        [mNewsPromptBar remove];
        newimage.hidden = YES;
                
    }
    
    
}
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}

- (void)xinweibotixing{
    
    
    if (gzrftstr != 0) {
        if (!dajiabool) {
            NSMutableString *textStr = [[NSMutableString alloc] init];
            [textStr appendString:@"有新微博,下拉列表刷新"];
            NSLog(@"tesxt = %@", textStr);
            //NSString * textStr = @"有新微博,下拉列表刷新";
            [mNewsPromptBar showInView:tableView];
            [mNewsPromptBar.textLb setText:textStr];
            [textStr release];
            gzrftstr = 0;
        }
        
    }
    
}


- (void)pressheadButton1:(UIButton *)sender{
    
}

- (void)pressHeadButton2:(UIButton *)sender{
    
    MyProfileViewController * mypr = [[MyProfileViewController alloc] initWithType:1];
    mypr.delegate = self;
  
    mypr.str11 = guanzhustr;
    mypr.str22 = pinglustr;
    mypr.str33 = atmestr;
    mypr.str44 = sxstr;
   
    mypr.title = username;
    [self.navigationController pushViewController:mypr animated:NO];
    [mypr release];
}
- (void)returnstr1:(NSInteger)str1 str2:(NSInteger)str2 str3:(NSInteger)str3 str4:(NSInteger)str4{
    NSLog(@"home11111111111111111111111111111111 = %ld %ld %ld %ld", (long)str1, (long)str2, (long)str3, (long)str4);
    if (str1==0&&str2==0&&str3==0&&str4==0) {
        newimage.hidden = YES;
    }else{
        newimage.hidden = NO;
    }
    guanzhustr = str1;
    pinglustr = str2;
    atmestr = str3;
    sxstr = str4;
}
- (void)dobackyanchi{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
}

- (void)sleepDoBack{
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)doBack{

    
   
    if (onebool == NO) {
          onebool = YES;
        [mNetworkQueue reset];
        [self performSelector:@selector(dobackyanchi) withObject:nil afterDelay:0.3];
    }
    
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
}

- (void)presszhuce:(UIButton *)sender{
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

- (void)pressfanhui:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [sender removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)doRegister {
    
	LotteryPreferenceViewController *lot =[[LotteryPreferenceViewController alloc] init];
	[lot setHidesBottomBarWhenPushed:YES];
	lot.title =@"步骤1：偏好设置";
	[self.navigationController pushViewController:lot animated:YES];
	[lot release];
   
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

// 添加 广告位图片
- (void)addAdPicView{
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBADvertisementPic]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(addAdPicViewSuc:)];
	[request setDidFailSelector:@selector(addAdPicViewFail:)];
	[request startAsynchronous];
}

- (void)addAdPicViewSuc:(ASIHTTPRequest *)request{
	isDeleted = NO;
	NSString *responseString = [request responseString];
	SBJSON *jsonParse = [[SBJSON alloc]init];
	NSDictionary *dic = [jsonParse objectWithString:responseString];
	if (dic) {
		self.aNewVersion = [dic objectForKey:@"version"];
		NSString *url = [dic objectForKey:@"url"];
		NSString *isUpdate = [dic objectForKey:@"isUpdate"];
		//NSString *linkUrl = [dic objectForKey:@"linkUrl"];
		
		if ([isUpdate isEqualToString:@"1"]) {
			UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
			advPicView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 303, 39)];
			[advPicView setImage:image forState:UIControlStateNormal];
			advPicView.center = CGPointMake(160, 19.5);
			
			chaButton = [[UIButton alloc] initWithFrame:CGRectMake(320-37, 0, 37, 37)];
			[chaButton setImage:UIImageGetImageFromName(@"cha.png") forState:UIControlStateNormal];
			[chaButton addTarget:self action:@selector(dismissADV:) forControlEvents:UIControlEventTouchUpInside];
			[advPicView addTarget:self action:@selector(linkAndDismissADV:) forControlEvents:UIControlEventTouchUpInside];
			CGRect originFrame = tableView.frame;
			tableView.frame = CGRectMake(0, 74, originFrame.size.width, originFrame.size.height);
			navView.frame = CGRectMake(0, 39, 320, 40);
			//[advPicView addSubview:chaButton];
			[self.view addSubview:advPicView];
			[self.view addSubview:chaButton];
			
			
		}
	}
	[jsonParse release];
}
-(void)dismissADV:(id)sender{
	
	[advPicView removeFromSuperview];
	[chaButton removeFromSuperview];
	CGRect originFrame = self.view.frame;
	//tableView.frame = originFrame;
	tableView.frame = CGRectMake(0, 34, originFrame.size.width, originFrame.size.height-40);
	navView.frame = CGRectMake(0, 0, 320, 40);
}

-(void)linkAndDismissADV:(id)sender{
    
}


-(void)addAdPicViewFail:(ASIHTTPRequest *)request{
	// do nothing
}

// 调用  UIScrollViewDelegate 下拉过程中 调用  
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	// 下拉刷新
	
    NSLog(@"tableView.contentSize.height%f,      scrollView.contentOffset.y%f",tableView.contentSize.height,scrollView.contentOffset.y);
	[refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	CGPoint offset = scrollView.contentOffset;
	if (offset.y>0) {
		[lastLotteryBtn removeFromSuperview];
		lastLotteryBtn = nil;
		[liveScoreBtn removeFromSuperview];
		liveScoreBtn = nil;
		[forcastBtn removeFromSuperview];
		forcastBtn = nil;
	}
	
}
// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (tableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		if (!topicLoadedEnd){
			if (topicMoreCell) {
				[topicMoreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
				
			}
		}
	}
	[refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
    [mNewsPromptBar dimissInView];
}

// 调用 CBRefreshTableHeaderDelegate 方法  
// 在这里 发送请求 数据更新 请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
	self.navigationItem.rightBarButtonItem.enabled = NO;
	self.navigationItem.leftBarButtonItem.enabled = NO;
	
	fristLoading = YES;
	topicLoadCount = NO;
	
	//
	[self reloadTableViewDataSource];
	
	[refreshHeaderView setState:CBPullRefreshLoading];
    
	tableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    
	// 判断是否是 分组数据
	if (selectBtn == 5) {
		self.newstype = @"更多";
		_reloading = NO;
		self.navigationItem.rightBarButtonItem.enabled = YES;
		self.navigationItem.leftBarButtonItem.enabled = YES;
		[refreshHeaderView performSelector:@selector(CBRefreshScrollViewDataSourceDidFinishedLoading:) withObject:tableView afterDelay:0.5];
        
		[tableView reloadData];
	}
	else {
		if (selectBtn == 0) {
			self.newstype = @"首页";
			self.selectName = @"首页";
			if (isGroup) {
				
				NSInteger row = [chooseUserPicker selectedRowInComponent:0];		
				UserGroupList *glist = [arryData objectAtIndex:row];
				
				[self sendTopicListByGroupIdRequest:glist];
				
			}else {
				
				// 发送请求
				[self SendHttpRequest];
				
			}
		}
		else {
			NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
			NSString *path=[paths    objectAtIndex:0];
			NSString *plistPath = [path stringByAppendingPathComponent:@"persondata.plist"];
			NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
			if (!dic) {
				plistPath = [[NSBundle mainBundle] pathForResource:@"persondata" ofType:@"plist"];
				dic = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] retain];
				[dic writeToFile:[path stringByAppendingPathComponent:@"persondata.plist"]  atomically:YES];
			}
			NSMutableArray *anArray = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"data"]];
			SEL sel;
			self.newstype = [[anArray objectAtIndex:selectBtn] objectForKey:@"type"];
			if ([self.newstype isEqualToString:@"快讯"]) {
				sel = @selector(SendNewsData:);
			}
			else if ([self.newstype isEqualToString:@"预测"]) {
				sel = @selector(SendYuCeData:);
			}
			else  {
				sel = @selector(SendKaiJiangData:);
			}
			[self performSelector:sel withObject:[anArray objectAtIndex:selectBtn]];
			[anArray release];
			[dic release];
		}
	}
    
}

-(void)SendHttpRequest
{
	if([CheckNetwork isExistenceNetwork])
    {
		
		if (!mNetworkQueue) {
			mNetworkQueue = [[ASINetworkQueue alloc] init];
            [mNetworkQueue setMaxConcurrentOperationCount:1];
		}
		
        [mNetworkQueue reset];
        [mNetworkQueue setRequestDidFinishSelector:@selector(doneLoadingTableViewData:)];
        
        [mNetworkQueue setRequestDidFailSelector:@selector(requestFailedWithDidLoadedTableViewData:)];
        [mNetworkQueue setDelegate:self];
        
        ASIHTTPRequest *request;
        
        
        
        if (dajiabool) {//大家都在说
            
            
       
            
            Info *info = [Info getInstance];
            if ([info.userId intValue]) {
//                request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:@"1" pageSize:@"20" userId:[[Info getInstance]userId]]];
                 request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:@"1" pageSize:@"20" userId:[[Info getInstance]userId] istoppic:@"1"]];
            }else{
//                request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:@"1" pageSize:@"20" userId:@"0"]];//[[Info getInstance]userId]]];
                request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:@"1" pageSize:@"20" userId:@"0" istoppic:@"0"]];//[[Info getInstance]userId]]];
                
            }
            
        }else{//焦点互动的首页
            
            request = [ASIHTTPRequest requestWithURL:[NetURL CBpushMessageList:@"1" pageSize:ktopicNum userId:[[Info getInstance]userId] mode:@"1"]];
            
        }
        
		topDaJiaDouZaiShuo = 1;
		
        
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setUserInfo:[NSDictionary dictionaryWithObject:@"request2" forKey:@"key"]];
        
        [mNetworkQueue addOperation:request];
        
        [mNetworkQueue go];
    }
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

- (void)reloadTableViewDataSource{
	_reloading = YES;
}

// 完成 更新。调用 CBRefreshScrollViewDataSourceDidFinishedLoading 向上隐藏 刷新空间
// 可以在这里  放入更新的 数据 到 界面
- (void)doneLoadingTableViewData:(ASIHTTPRequest *)request
{	

    
    NSString *responseString = [request responseString];
    NSDictionary *dic = (NSDictionary*)request.userInfo;
    
    NSString *str = (NSString*)[dic objectForKey:@"key"];
    
    NSLog(@"responseString = %@", responseString);
    if (str&&[str isEqualToString:@"request1"]) {
        
        // 模拟时间
        [self performSelector:@selector(UndoneLoadedTableViewData) withObject:nil afterDelay:0.5];
        if (![responseString isEqualToString:@"fail"]) 
        {
            CheckNewMsg *checkmsg = [[CheckNewMsg alloc] initWithParse:responseString];
            NSLog(@"checknew = %@  si = %@", checkmsg.gzrft, checkmsg.sx);
            
            
            
            
            if (checkmsg) 
            {
                if (checkmsg.gzrft&&![checkmsg.gzrft isEqualToString:@"0"]) 
                {
                    
                    
                }
                [checkmsg release];
            }
        }
        
        
    }else if(str&&[str isEqualToString:@"request2"])
    {
        
        [self performSelector:@selector(UndoneLoadedTableViewData) withObject:nil afterDelay:0.5];
        if(responseString){
			NSMutableArray *topicArray = [[[NSMutableArray alloc] init] autorelease];
            if(bannerArray){
            
                [bannerArray removeAllObjects];
            }
            
            NSMutableArray *array;
            if (dajiabool) {
                
                
                 NSDictionary * newDict = [responseString JSONValue];
                 array = [newDict objectForKey:@"topicList"];
                              

                
                NSArray * toppicList = [newDict objectForKey:@"toppicList"];
                
                if(toppicList.count > 0){
                    for(int i = 0;i<[toppicList count];i++){
                        
                        NSDictionary *dic = [toppicList objectAtIndex:i];
                        
                        NewsData * newsdata = [[NewsData alloc] init];
                        newsdata.newsid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"topicid"]];
                        newsdata.attach_small = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]];
                        newsdata.type_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
                        newsdata.flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
                        
                        [self.topicidPict appendFormat:@"%@-",[dic objectForKey:@"topicid"]];
                        newsdata.lottery_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lotteryId"]];
                        newsdata.play_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"play"]];
                        newsdata.bet_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bet"]];
                        newsdata.staySecond = [NSString stringWithFormat:@"%@",[dic objectForKey:@"frequency"]];
                        [bannerArray addObject:newsdata];
                        
                        [newsdata release];
                    }
                }
                else{
                    
                    [tableView setTableHeaderView:nil];

                }

                
                headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
                [headerView setBackgroundColor:[UIColor clearColor]];
                bannerView = [[LunBoView alloc] initWithFrame:CGRectMake(0, 0, 320, 75) newsViewController:self];
                bannerView.isAnother = YES;
                bannerView.hiddenGrayTitleImage = YES;
                [headerView addSubview:bannerView];
                
                
                UIButton * topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
                topicButton.frame = CGRectMake(320-60, 0, 60, 60);
                [topicButton addTarget:self action:@selector(CloseBanner:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView * topicImage = [[UIImageView alloc] initWithFrame:CGRectMake(60-13-15, 15, 13, 13)];
                topicImage.backgroundColor = [UIColor clearColor];
                topicImage.image = UIImageGetImageFromName(@"huodongguanbi.png");
                [topicButton addSubview:topicImage];
                [topicImage release];
                
                [bannerView addSubview:topicButton];
                
                
                [tableView setTableHeaderView:headerView];
                
                
                if(bannerArray.count){
                    
                    [bannerView setImageWithArray:bannerArray];
                    
                }

                
                NSArray * allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"guanggaohuodong"];
                
                
                for (int i = 0; i < [allHuoDong count]; i++) {
                    NSString * savestr = [allHuoDong objectAtIndex:i];
                    NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
                    NSString * useridstr = @"";
                    if ([arrSave count] > 1) {
                        useridstr = [arrSave objectAtIndex:1];
                    }
                    
                    if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
                        NSString * topid = [arrSave objectAtIndex:0];
                        NSString * coloser = [arrSave objectAtIndex:2];
                        
                        if ([topid isEqualToString:self.topicidPict]&& [coloser isEqualToString:@"1"]) {
                            
                            [tableView setTableHeaderView:nil];
                        }else{
                            [tableView setTableHeaderView:headerView];
                        }
                        break;
                       
                        
                    }
                    
                }

            }else{
                
                [tableView setTableHeaderView:nil];
                array = [responseString JSONValue];
            }
           
            
			YtTopic *topic2 = [[YtTopic alloc] init];
			NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
			NSString *path=[paths    objectAtIndex:0];
			NSString *plistPath = [path stringByAppendingPathComponent:@"newcom.plist"];
			NSMutableDictionary* dic = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:plistPath ];
			if (!dic) {
				dic = [[NSMutableDictionary alloc] init];
			}
			NSMutableArray *array2 = [dic objectForKey:@"data"];
			if ([array2 count] == 0) {
				for (int i = 0; i < [array count]; i++) {
					YtTopic *topic1 = [topic2 paserWithDictionary:[array objectAtIndex:i]];
					topic1.isNewComond = YES;
					[topicArray addObject:topic1];
				}
			}
			else {
				for (int i = 0; i <[array count]; i++) {
					YtTopic *topic1 = [topic2 paserWithDictionary:[array objectAtIndex:i]];
					BOOL isSave = NO;
					for (int j =0; j<[array2 count]; j ++) {
						NSDictionary *savTopic = [array2 objectAtIndex:j];
						
						if ([[savTopic objectForKey:@"topicid"] isEqualToString:topic1.topicid]) {
							isSave = YES;
							if ([topic1.count_pl isEqualToString:[savTopic valueForKey:@"count_pl"]]&&[[savTopic valueForKey:@"isNewComond"] intValue]==0) {
								topic1.isNewComond = NO;
							}
							else {
								topic1.isNewComond = YES;
							}
							j = (int)[array2 count];
						}
					}
					if (isSave == NO) {
						topic1.isNewComond = YES;
					}
					[topicArray addObject:topic1];
				}
			}
			NSMutableArray *array3=[[NSMutableArray alloc] init];
			for (int i = 0 ; i <[topicArray count];i++) {
				YtTopic *topic1 = [topicArray objectAtIndex:i];
				NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
									 topic1.count_pl,@"count_pl",
									 topic1.topicid,@"topicid",
									 [NSString stringWithFormat:@"%d",topic1.isNewComond],@"isNewComond",nil];
				[array3 addObject:dic];
				[dic release];
			}
			[dic setValue:array3 forKey:@"data"];
			[array3 release];
			[dic writeToFile:plistPath  atomically:YES];
			[topic2 release];
			[dic release];
            
            [topicDataArry removeAllObjects];
            self.topicDataArry = topicArray;
}
//        [tableView reloadData];
        
       // self.navigationController.tabBarItem.badgeValue=nil;
        
    }
   
    NSLog(@"gzrft = %ld", (long)gzrftstr);
    if (dajiabool) {
        xianshi = NO;
        xianshistr = nil;
    }else{
        xianshi = YES;
        xianshistr = @"1";
    }
    [tableView reloadData];
    [self performSelector:@selector(xinweibotixing) withObject:self afterDelay:0];
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
}

- (void)pressTableViewHead:(UIButton *)sender{
    
    [mRequest clearDelegatesAndCancel];
    [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:hongdongyt.topicid]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest startAsynchronous];
    


}

- (void)CloseBanner:(UIButton *)sender{
    
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
    
    [tableView setTableHeaderView:nil];
    
    NSArray * allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"guanggaohuodong"];
    NSMutableArray * saveMutable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [allHuoDong count]; i++) {
        NSString * savestr = [allHuoDong objectAtIndex:i];
        NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
        NSString * useridstr = @"";
        if ([arrSave count] > 1) {
            useridstr = [arrSave objectAtIndex:1];
        }
        if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
            NSString * savestring = [NSString stringWithFormat:@"%@ %@ 1", self.topicidPict , [[Info getInstance] userId]];
            [saveMutable addObject:savestring];
            
        }else{
            
            [saveMutable addObject:savestr];
            
        }
    }
    if ([saveMutable count] == 0) {
        NSString * huodongid = [NSString stringWithFormat:@"%@ %@ 1", self.topicidPict, [[Info getInstance] userId]];
        [saveMutable addObject:huodongid];
    }
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
     [[NSUserDefaults standardUserDefaults] setValue:saveMutable forKey:@"guanggaohuodong"];//前面是帖子id 空格 用户id
    }
    [saveMutable release];
}

// 网络 失败 
-(void)requestFailedWithDidLoadedTableViewData:(ASIHTTPRequest*)request
{
	
    [self performSelector:@selector(UndoneLoadedTableViewData) withObject:nil afterDelay:0.5];
		
	NSLog(@"homeViewController  error is %@",[request error]);
}

//  隐藏 刷新控件
-(void)UndoneLoadedTableViewData
{
	self.navigationItem.rightBarButtonItem.enabled = YES;
	self.navigationItem.leftBarButtonItem.enabled = YES;
	_reloading = NO;
	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:tableView];
}

// 点击 用户名 ，弹出 或则 隐藏 用户选择 分组 选择器
-(void)pressUserName:(id)sender{
	
	if(ispickerOPen){
		ispickerOPen =NO;
		[imageButton setImage:UIImageGetImageFromName(@"up.png") forState:UIControlStateNormal];
		
		
        // 检测 网络
		if([CheckNetwork isExistenceNetwork] ){
			// 发送  2.54 查看 分组 请求
			ASIHTTPRequest  *request = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserGroupList:[[Info getInstance]userId] pageNum:@"1" pageSize:@"20"]];
			[request setDefaultResponseEncoding:NSUTF8StringEncoding];
			
			[request setDidFinishSelector:@selector(pickerRequestFinished:)];
			[request setDelegate:self];
			[request startAsynchronous];
			self.curRequest = request;
		}
	}else {
		ispickerOPen = YES;
		[imageButton setImage:UIImageGetImageFromName(@"home_down.png") forState:UIControlStateNormal];
		[self dissDatePick];
	}
}

// 选取器 请求 返回 接收
- (void)pickerRequestFinished:(ASIHTTPRequest *)request
{
	
	NSString *responseString = [request responseString];
	
	if(responseString)
    {
		
		UserGroupList *glist = [[UserGroupList alloc] initWithParse:responseString];
		
        
		NSMutableArray *arry = [[NSMutableArray alloc] init];
		
		UserGroupList *group = [[UserGroupList alloc] init];
		
		group.name = @"全部";
		
		[arry addObject:group];
		
		self.arryData = arry;
		
		[group release];
		
		[arry release];
		
		[self.arryData addObjectsFromArray:glist.arryList];
		
		[glist release];
    }
    
	[self.chooseUserPicker reloadAllComponents];	
	// 接收请求之后  伸出 选取器 界面
	[self showDatePick];
}

-(void)pressRefreshButton:(id)sende{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	tableView.contentOffset = CGPointMake(0, -60);
	[UIView commitAnimations];
	[YDUtil playSound:@"pull_pull"];
	[YDUtil playSound:@"pull_ok"];
	
	
	//调用 发送请求接口
	[self CBRefreshTableHeaderDidTriggerRefresh:refreshHeaderView];
    
   
    
}

// 点击写微博 按钮
-(void)pressWriteButton:(id)sender {
    [MobClick event:@"event_weibohudong_faxinweibo"];
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController shareTo:@"" isShare:NO];
#else
    
//    ForwardTopicController, //转发类型
//    CommentTopicController, //评论类型
//    CommentRevert,          //2.51评论回复
   
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
	publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
	[publishController release];
    [nav release];
	
    
#endif

}


// 发送 请求
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Info *info1 = [Info getInstance];
    if ([info1.userId intValue]) {
     
        
        
        
        UIButton * buttxie = (UIButton *)[self.navigationItem.titleView viewWithTag:99];
        buttxie.hidden = NO;
        
        
        
        //  if (dajiabool) {
        // [self CBRefreshTableHeaderDidTriggerRefresh:refreshHeaderView];
        //  }
        //  [self SendHttpRequest];
        
        UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthItem.tag = 99;
        UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_xie.png");
        
        rigthItem.frame = CGRectMake(200, 10, 23, 24);
        
        [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
        [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
        // [self.navigationController.navigationBar addSubview:rigthItem];

        
        UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
        
        self.navigationItem.rightBarButtonItem = rigthItemButton;
        [rigthItemButton release];
        
        
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
        self.CP_navigation.leftBarButtonItem = leftItem;
        
#ifdef isCaiPiaoForIPad
        self.CP_navigation.leftBarButtonItem = nil;
#endif
    }
    
    
    
   
}

- (void)returnguanzhu:(NSInteger)gz pinglun:(NSInteger)pl atme:(NSInteger)am sixin:(NSInteger)sx{
    if ([delegate respondsToSelector:@selector(returnguanzhu:pinglun:atme:sixin:)]) {
        [delegate returnguanzhu:gz pinglun:pl atme:am sixin:sx];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
   
	[super viewWillDisappear:animated];
    [mNewsPromptBar remove];
//    if (bannerView.lunBoRunLoopRef) {
//        CFRunLoopStop(bannerView.lunBoRunLoopRef);
//        bannerView.lunBoRunLoopRef = nil;
//    }
	
}


// 回调函数，自动 推送 新消息，将tab 图片显示 “new”
-(void)autoRefresh:(NSString*)responseString{
    
	if (responseString) {
		
		CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
        
        
        
        NSLog(@"aaaaacheckkkkkkkkkkkkkkkkkkkkk %@, %@, %@, %@", check.gzrft, check.atme, check.sx, check.pl);
        //        if ([check.gzrft intValue] != 0 || check.atme || [check.sx intValue] != 0) {
        
        
        
        if (![check.pl isEqualToString:@"0" ]||![check.gz isEqualToString:@"0" ]|| ![check.atme isEqualToString:@"0"]|| ![check.sx isEqualToString:@"0"]||![check.gzrft isEqualToString:@"0" ]) {
            gzrftstr = [check.gz intValue];
            pinglustr = [check.pl intValue];
            atmestr = [check.atme intValue];
            sxstr = [check.sx intValue];
            int xttzint = [check.xttz intValue];
            if (![check.pl isEqualToString:@"0" ]||![check.gz isEqualToString:@"0" ]|| ![check.atme isEqualToString:@"0"]|| ![check.sx isEqualToString:@"0"]) {
                caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
                
                UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
                NSArray * views = a.viewControllers;
                if ([views count] >= 2) {
                   
                        
                        
                        CP_TabBarViewController *c = [views objectAtIndex:1];
                        if ([c isKindOfClass:[CP_TabBarViewController class]]) {
                            //                NSArray * viewss = c.viewControllers;
                            
                            // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                            NSString * zongshustr = [NSString stringWithFormat:@"%ld", (long)sxstr+(long)atmestr+(long)pinglustr+(long)xttzint ];
                            NSString * fensicout = [NSString stringWithFormat:@"%ld", (long)guanzhustr ];
                            NSString * couthaoyou = [NSString stringWithFormat:@"%ld", (long)gzrftstr ];
                            
                            NSMutableArray * zhuangtaiarr = [[NSMutableArray alloc] initWithCapacity:0];
                            [zhuangtaiarr addObject:@"0"];
                            [zhuangtaiarr addObject:@"0"];
                            [zhuangtaiarr addObject:couthaoyou];
                            [zhuangtaiarr addObject:zongshustr];
                            [zhuangtaiarr addObject:fensicout];
                            
                            
                            c.stateArray = zhuangtaiarr;
                            [zhuangtaiarr release];
                        
                        
                       
                        
                    }
                }
            }
            
            if (![check.gzrft isEqualToString:@"0" ]) {
                if (xianshi) {
                    NSMutableString *textStr = [[NSMutableString alloc] init];
                    [textStr appendString:@"有新微博,下拉列表刷新"];
                    NSLog(@"tesxt = %@", textStr);
                    //NSString * textStr = @"有新微博,下拉列表刷新";
                    [mNewsPromptBar showInView:tableView];
                    [mNewsPromptBar.textLb setText:textStr];
                    [textStr release];
                }
                gzrftstr = [check.gzrft intValue];
                
                [self xinweibotixing];
                
            }else{
                newimage.hidden = NO;
            }
            
            
            
        } else {
            [mNewsPromptBar remove];
            newimage.hidden = YES;
        }
        
        
        
        
		[check release];
		
	}
    
}



-(void)setbadgeValue{	
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger count = 0;
    if (self.searchDisplayController.searchResultsTableView == _tableView) {
		return [self.seachTextListarry count];
	}else if ([self.newstype isEqualToString:@"首页"]) {
		count = [self.topicDataArry count];
	}
	else if ([self.newstype isEqualToString:@"更多"]) {
		count = [[self.dataDic objectForKey:@"更多"] count] - 1;
	}
    
	else {
		count = [[self.dataDic objectForKey:selectName] count];
	}
    
   
    
    return  (!count)?count:count+1;
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cellHeigth = 60.0;
    if (self.searchDisplayController.searchResultsTableView == _tableView) {
		return 44;
    }else if ([self.newstype isEqualToString:@"首页"]) {
		if (indexPath.row == [topicDataArry count]) {
			cellHeigth = 60.0;	
		} else {
			YtTopic *pic = [topicDataArry objectAtIndex:indexPath.row];
			if ([pic.type isEqualToString:@"0"]) {
				cellHeigth = WEIBO_GUANGCHANG_TOPNEWS_HEIGHT;
			} else {
				cellHeigth = pic.cellHeight; //[pic calcTextBounds:pic];
			}
		}
	}
	else if ([self.newstype isEqualToString:@"预测"]) {
		NSMutableArray *array = [self.dataDic objectForKey:selectName];
		if (indexPath.row == [array count]) {
			
			cellHeigth = 60.0;
            
			
		} else {
			
			YtTopic *status = [array objectAtIndex:indexPath.row];
			
			cellHeigth = status.cellHeight;
			
		}
	}
	else if ([self.newstype isEqualToString:@"快讯"]) {
		NSMutableArray *array = [self.dataDic objectForKey:selectName];
		if (indexPath.row == [array count]) {
			
			cellHeigth = 60.0;
			
		} else {
			cellHeigth = 70.0;
		}
	}
	else if ([self.newstype isEqualToString:@"开奖"]){
		
	}
	else {
		cellHeigth = 44.0;
	}
    
	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        
        NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row]; 
        
        cell.textLabel.text =text ;
        
        return cell;
        
        
    }else{
        
        if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
//            self.tableView.backgroundColor = [UIColor clearColor];
            refreshHeaderView.backgroundColor = [UIColor clearColor];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        } else {
            
//            self.tableView.backgroundColor = [UIColor clearColor];
            refreshHeaderView.backgroundColor = [UIColor clearColor];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        }
        
        static NSString *CellIdentifier;
        if ([self.newstype isEqualToString:@"首页"]) {
            if (indexPath.row ==[topicDataArry count]) {
                
                CellIdentifier = @"MoreLoadCell";
                
                MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if(cell==nil){
                    cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                
                if (topicMoreCell==nil) {
                    topicMoreCell = cell;
                }
                [cell spinnerStopAnimating2:NO];
                
                if (!topicLoadedEnd) {
					
                    if([tableView numberOfRowsInSection:indexPath.section] > 1)
                    {
                        [cell spinnerStartAnimating];
                        
                        [self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
                    }
					
				}
                
                return cell;
                
            } else {
                
                YtTopic *pic = [topicDataArry objectAtIndex:indexPath.row];
                
                if([pic.type isEqualToString:@"0"]){
                    
                    if (indexPath.row<6) {
                        CellIdentifier = @"newsCell";
                        
                        GuangChangTopNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell) {
                            cell = [[[GuangChangTopNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                        }
                        [cell setContentString:pic.mcontent];
                        
                        switch (indexPath.row) {
                            case 0:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:242/255.0 green:112/255.0 blue:34/255.0 alpha:1];
                            }
                                break;
                            case 1:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:147/255.0 blue:0/255.0 alpha:1];
                            }
                                break;
                            case 2:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:79/255.0 blue:83/255.0 alpha:1];
                            }
                                break;
                            case 3:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:208/255.0 blue:218/255.0 alpha:1];
                            }
                                break;
                            case 4:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:38/255.0 green:148/255.0 blue:237/255.0 alpha:1];
                            }
                                break;
                            case 5:
                            {
                                cell.titleLabel.textColor = [UIColor colorWithRed:242/255.0 green:112/255.0 blue:34/255.0 alpha:1];
                            }
                                break;
                            default:
                                break;
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                    else {
                        CellIdentifier = @"TopicCell";
                        
                        HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        
                        if(cell == nil) 
                        {
                            cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];	
                        }
                        if(pic) {
                            pic.tableView = tableView;
                            pic.indexPath = indexPath;
                            cell.status = pic;
                            [cell update:tableView];
                        }
                        if (dajiabool) {
                            cell.ishome = YES;
                        }else{
                            cell.ishome = NO;
                        }
                       // cell.xian.frame = CGRectMake(10, cell.frame.size.height - 2, 300, 2);
                        cell.backgroundColor = [UIColor clearColor];
                        cell.contentView.backgroundColor = [UIColor clearColor];
                        return cell;
                    }
                    
                    
                }else {
                    
                    CellIdentifier = @"TopicCell";
                    
                    HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if(cell == nil) 
                    {
                        cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];	
                    }
                    if (dajiabool) {
                        cell.ishome = YES;
                    }else{
                        cell.ishome = NO;
                    }
                    
                    if(pic) {
                        pic.indexPath = indexPath;
                        cell.status = pic;
                        pic.tableView = tableView;
                        cell.status.indexPath = indexPath;
                        [cell update:tableView];
                    }
                    
                    
                    cell.homeCellDelegate = self;
                    return cell;
                }
            }
        }
        else {
            NSMutableArray *array = [self.dataDic objectForKey:selectName];
            if ([self.newstype isEqualToString:@"预测"]) {
                if (indexPath.row ==[array count]) {
                    
                    CellIdentifier = @"MoreLoadCell";
                    
                    MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if (cell == nil) {
                        cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        cell.backgroundColor = [UIColor clearColor];
                    }
                    
                    if (topicMoreCell == nil) {
                        topicMoreCell = cell;
                    }
                    [cell spinnerStopAnimating2:NO];
                    
                    return cell;
                } else {
                    
                    CellIdentifier = @"TopicCell";
                    
                    HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if(cell == nil) {
                        
                        cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];		 
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    }
                    
                    YtTopic *status = [array objectAtIndex:indexPath.row];
                    
                    if (dajiabool) {
                        cell.ishome = YES;
                    }else{
                        cell.ishome = NO;
                    }
                    if (status) {
                        status.indexPath = indexPath;
                        status.tableView = tableView;
                        cell.status = status;
                        [cell update:tableView];
                    }
                    return cell;
                }
                
            }
            else if ([self.newstype isEqualToString:@"快讯"]) {
                if (indexPath.row ==[array count]) {
                    
                    CellIdentifier = @"MoreLoadCell";
                    
                    MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if (cell == nil) {
                        cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    }
                    
                    if (topicMoreCell == nil) {
                        topicMoreCell = cell;
                    }
                    [cell spinnerStopAnimating2:NO];
                    
                    return cell;
                } else {
                    
                    CellIdentifier = @"NewsCell";
                    
                    LotteryNewsCell *cell =(LotteryNewsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if(cell == nil) {
                        
                        cell = [[[LotteryNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];		 
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    }
                    YtTopic *status = [array objectAtIndex:indexPath.row];
                    [cell LoadData:status];
                    return cell;
                }
            }
            else if ([self.newstype isEqualToString:@"开奖"]) {
            }
            else {
                CellIdentifier = @"More";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[[[self.dataDic objectForKey:@"更多"] objectAtIndex:indexPath.row] objectForKey:@"name"],[[[self.dataDic objectForKey:@"更多"] objectAtIndex:indexPath.row] objectForKey:@"shortname"]];
                if (indexPath.row == 0) {
                    cell.textLabel.text = [[[self.dataDic objectForKey:@"更多"] objectAtIndex:indexPath.row] objectForKey:@"shortname"];
                    cell.textLabel.textColor = [UIColor redColor];
                }
                else {
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                return cell;
            }
        }
        
        
    }
    
    
    
	return nil;
}



- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchDisplayController.searchResultsTableView == _tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    
	[_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
	Info *info = [Info getInstance];
    
	if ([info.userId isEqualToString:CBGuiteID]) {
		NSInteger count;
		if ([self.newstype isEqualToString:@"首页"]) {
			count = [self.topicDataArry count];
		}
		else if ([self.newstype isEqualToString:@"更多"]) {
			count = [[self.dataDic objectForKey:@"更多"] count];
		}
		
		else {
			count = [[self.dataDic objectForKey:selectName] count];
		}
		if (indexPath.row == count) {
			MoreLoadCell *cell = (MoreLoadCell*)[_tableView cellForRowAtIndexPath:indexPath];
			[cell spinnerStartAnimating];
			
			[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
			return;
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请登录你的微博账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册",@"登录",nil];
		alert.tag = 10001;
		[alert show];
		[alert release];
	}
	else {
		NSMutableArray *array = [self.dataDic objectForKey:self.selectName];
		if ([self.newstype isEqualToString:@"首页"]) {
			if (indexPath.row == [topicDataArry count]) {
				
				MoreLoadCell *cell = (MoreLoadCell*)[_tableView cellForRowAtIndexPath:indexPath];
				
				if (!topicLoadedEnd) {
					
					[cell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
					
				}
				
				
			} else {
				
				YtTopic *mStatus = [topicDataArry objectAtIndex:indexPath.row];
				// 针对6条新闻推送先获取最新数据再跳转到微博正文页
				if (indexPath.row < 6 && [mStatus.type isEqualToString:@"0"]) {
                    [MobClick event:@"event_weibo_zixun"];
                    if ([mStatus.blogCount integerValue] > 1 && [mStatus.blogtype length]) {
                        NewsViewController * newsViewController = [[[NewsViewController alloc] initWithBlogtype:mStatus.blogtype] autorelease];
                        [self.navigationController pushViewController:newsViewController animated:YES];
                    }else if (mStatus.topicid) {
						[mRequest clearDelegatesAndCancel];
						[self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.topicid]]];
						[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
						[mRequest setDelegate:self];
						[mRequest setTimeOutSeconds:20.0];
						[mRequest startAsynchronous];
                    }
                    return;
				}
				if (indexPath.row>5&&indexPath.row <26) {
					mStatus.isNewComond = NO;
					NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
					NSString *path=[paths    objectAtIndex:0];
					NSString *plistPath = [path stringByAppendingPathComponent:@"newcom.plist"];
					NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
					NSMutableArray *array3=[[NSMutableArray alloc] init];
					for (int i = 0 ; i <[self.topicDataArry count];i++) {
						YtTopic *topic1 = [topicDataArry objectAtIndex:i];
						NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                              topic1.count_pl,@"count_pl",
                                              topic1.topicid,@"topicid",
                                              [NSString stringWithFormat:@"%d",topic1.isNewComond],@"isNewComond",nil];
						[array3 addObject:dic2];
						[dic2 release];
					}
					[dic setValue:array3 forKey:@"data"];
					[array3 release];
					[dic writeToFile:plistPath  atomically:YES];
					[dic release];
				}
             
				DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:mStatus indexrow:indexPath.row];
                if (dajiabool) {
                    detailed.homebool = YES;
                }else{
                    detailed.homebool = NO;
                }
                detailed.delegate = self;
				[detailed setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:detailed animated:YES];
				[detailed release];
                
			}
		}
		else if ([self.newstype isEqualToString:@"预测"]) {
			if (indexPath.row < [array count]) {
				
				DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[array objectAtIndex:indexPath.row]];
				[detailed setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:detailed animated:YES];
				[detailed release];
				
			}
			else {
				MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
				[cell spinnerStartAnimating];
				[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];			
			}
		}
		else if ([self.newstype isEqualToString:@"快讯"]) {
			if (indexPath.row < [array count]) {
				
				DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[array objectAtIndex:indexPath.row]];
				[detailed setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:detailed animated:YES];
				[detailed release];
				
			}
			else {
				MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
				[cell spinnerStartAnimating];
				[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];			
			}
		}
		else if ([self.newstype isEqualToString:@"开奖"]) {
		}
		else {
			if (indexPath.row == 0) {
				CustomHomeViewController *custom = [[CustomHomeViewController alloc] init];
				[custom setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:custom animated:YES];
				[custom release];
			}
			else {
				MoreNewsViewController *more = [[MoreNewsViewController alloc] init];
				more.title = [[[self.dataDic objectForKey:@"更多"] objectAtIndex:indexPath.row] objectForKey:@"name"];
				more.dicData = [[self.dataDic objectForKey:@"更多"] objectAtIndex:indexPath.row];
				[more setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:more animated:YES];
				[more release];
			}
			
		}		
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    if (dajiabool) {
        detailed.homebool = YES;
    }else{
        detailed.homebool = NO;
    }
    [detailed setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
}



// "更多" 发送请求
-(void)sendMoreTopicRequest{
	if ([newstype isEqualToString:@"首页"]) {
		if([CheckNetwork isExistenceNetwork]){
			
			ASIHTTPRequest  *request=nil;
			if (isGroup) {
				
			
                
				
			}else {
                
                if (dajiabool) {
                    Info *info = [Info getInstance];

                    NSString *topickID = nil;
                    if ([topicDataArry count]) {
                        YtTopic *status = [topicDataArry objectAtIndex:[topicDataArry count] -1];
                        topickID = status.topicid;
                    }
                    if ([info.userId intValue]) {
                        
                        request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:[self loadedCountDaJiaDouZaiShuo] pageSize:@"20" userId:[[Info getInstance]userId] topickID:topickID]];
                    }else{
                        request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:[self loadedCountDaJiaDouZaiShuo] pageSize:@"20" userId:@"0" topickID:topickID]];//[[Info getInstance]userId]]];
                    }
                    //                    request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:[self loadedCountDaJiaDouZaiShuo] pageSize:@"20" userId:[[Info getInstance]userId]]];
                }else{
                    
                    NSString *topickID = nil;
                    if ([topicDataArry count]) {
                        YtTopic *status = [topicDataArry objectAtIndex:[topicDataArry count] -1];
                        topickID = status.topicid;
                    }
                    NSLog(@"loaded count = %@", [self loadedCount]);
                    
                    request = [ASIHTTPRequest requestWithURL:[NetURL CBpushMessageList:[self loadedCount] pageSize:ktopicNum maxTopicId:topickID userId:[[Info getInstance]userId]]];
                }
                
				
				
			}
			
			[request setDefaultResponseEncoding:NSUTF8StringEncoding];
			
			[request setDelegate:self];
			
			[request setDidFinishSelector:@selector(moreTopictableViewDataBack:)];
			
			// 异步获取
			[request startAsynchronous];
			self.curRequest = request;
		}
	}
 
}

// "更多 "数据接收
-(void)moreTopictableViewDataBack:(ASIHTTPRequest*)request{

	NSString *responseString = [request responseString];
    
	NSLog(@"requ = %@", responseString);
    
	if (responseString) {
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (topicDataArry) {
				NSMutableArray *array2 = [NSMutableArray array];
				for (YtTopic *yt in topic.arrayList) {
					if ([yt.type isEqualToString:@"0"]) {
						[array2 addObject:yt];
					}
				}
				[topic.arrayList removeObjectsInArray:array2];
				[topicDataArry addObjectsFromArray:topic.arrayList];
			}
			
			
		}else {
			
			[topicMoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			topicLoadedEnd = YES;
           
            
			
		}
		
		[topic release];
        if (topicLoadedEnd == YES) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"加载完毕"];
//            [topicMoreCell spinnerStopAnimating];
            [topicMoreCell setInfoText:@"加载完毕"];
        }
		
		[self.tableView reloadData];
		
	}
	
	[topicMoreCell spinnerStopAnimating];
	
	fristLoading = NO;
	
    
}

- (NSString *)loadedCountDaJiaDouZaiShuo{
    NSString *count=@"0";
	if ([self.selectName isEqualToString:@"首页"]) {

		
		topDaJiaDouZaiShuo += 1;		
        
		NSNumber *num = [[NSNumber alloc] initWithInteger:topDaJiaDouZaiShuo];	
		count = [num stringValue];	
		[num release];
	}
    
    return count;
}

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount
{
	NSString *count=@"0";
	if ([self.selectName isEqualToString:@"首页"]) {
		if (_reloading) 
        {		
            topicLoadCount = 1;
        }
		
		topicLoadCount ++;		
		NSNumber *num = [[NSNumber alloc] initWithInteger:topicLoadCount];
		count = [num stringValue];	
		[num release];
	}
    
	
	return count;
}

#pragma mark -
#pragma mark picker method

// 响应 选取器 确定按钮 (在这里 发送 分组用户微博 请求)
-(IBAction) onClickOKPickerlButton:(id)sender
{
	ispickerOPen =YES;
	
	fristLoading = YES;
	topicLoadCount = NO;
	
	[imageButton setImage:UIImageGetImageFromName(@"home_down.png") forState:UIControlStateNormal];
	
	[self dissDatePick];
	
	if(arryData &&[arryData count]>0)
    {		
        NSInteger row = [chooseUserPicker selectedRowInComponent:0];		
        
        UserGroupList *glist = [arryData objectAtIndex:row];		
        
        if(glist&&row)
        {
            
            isGroup = YES;
            
            NSMutableString *str = [[NSMutableString alloc] init];
            
            [str appendString:@"("];
            
            [str appendString:@"组"];
            
            [str appendString:@")"];
            
            [str appendFormat:@"%@",glist.name];
            
            self.titleName.text =str;
            
            [self sendTopicListByGroupIdRequest:glist];
            
            [str release];
            
        }else {
            
            isGroup = NO;
            
            self.titleName.text = [[Info getInstance] nickName];
            
            [self SendHttpRequest];
            
        }
        
    }
}



// 分组帖子列表请求
-(void)sendTopicListByGroupIdRequest:(UserGroupList*)ulist;{
	
	if([CheckNetwork isExistenceNetwork]){
		
		
        ASIHTTPRequest  * request = [ASIHTTPRequest requestWithURL:[NetURL CBpushMessageList:[self loadedCount] pageSize:ktopicNum userId:[[Info getInstance]userId]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(doneLoadingTableViewData:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		// 异步获取
		[request startAsynchronous];
        self.curRequest = request;
	}
	
    
    
	
    
}

// 隐藏 选取器
-(void)dissDatePick
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    int centerX = userPickerView.bounds.size.width/2;
    int centerY = userPickerView.superview.frame.size.height + userPickerView.bounds.size.height/2;
    [userPickerView setCenter:CGPointMake(centerX, centerY)];
    [UIView commitAnimations];
	
    
}

// 动画 向上 显示 选取器
-(void)showDatePick
{
	
	
	//if(self.userPickerView.superview==nil)
    //    {
    //		
	self.userPickerView.frame = CGRectMake(0, 460, 320, 260);
	[self.tableView.window addSubview:self.userPickerView];	
    
	//}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.3];
    int centerX = userPickerView.bounds.size.width/2;
    int centerY = userPickerView.superview.frame.size.height - userPickerView.bounds.size.height/2;
    [userPickerView setCenter:CGPointMake(centerX, centerY)];
    [UIView commitAnimations];
}


// 实现选取器的  data source he  delete 方法
#pragma mark -
#pragma mark picker data source methods
// 返回 选取器的 组件 个数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	return 1;
}

// 选取器 设置 数据 条数 
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [arryData count];
}



#pragma mark -

#pragma mark picker Delete methods

// 选取器 放入 数据 
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	
	UserGroupList *uglist = [arryData objectAtIndex:row];
	
	return uglist.name;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    NSLog(@"receiveMemoryWaring");
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidUnload];
	[navView removeFromSuperview];
	self.navView = nil;
	self.chooseUserPicker = nil;
	self.userPickerView =nil;
	self.arryData =nil;
	self.topicDataArry =nil;
	self.titleName =nil;
	self.refreshHeaderView =nil;
	topicMoreCell =nil;
	
}

#pragma mark AlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 10001) {
		switch (buttonIndex) {
			case 1://注册
			{
                [self doRegister];
			}	
				break;
			case 2://登录
			{
                [self doLogin];
			}
				break;
                
			default:
				break;
		}
	}
}


- (void)dealloc {
//    [hongdongyt release];
    
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
    [bannerArray release];
    [bannerView release];
    [headerView release];
    [titlev release];
    [chekrequest clearDelegatesAndCancel];
    [chekrequest release];
    // [newimage release];
	self.dataDic = nil;
	self.selectName = nil;
	self.newstype = nil;
	self.navView = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[advPicView release];
	[aNewVersion release];
	[tableView release];
	[chaButton release];
	[refreshHeaderView release];    
	[mNetworkQueue reset];
	[mNetworkQueue release];		
	[chooseUserPicker release];
	[userPickerView release];
	[arryData release];
	[topicDataArry release];
	[titleName release];
    [mRequest clearDelegatesAndCancel];
    self.mRequest = nil;
	[curRequest clearDelegatesAndCancel];
    self.curRequest = nil;
    [orignalRequest clearDelegatesAndCancel];
    self.orignalRequest = nil;
    
	[mRequest release];
	[curRequest release];
	 
    [likeRequest clearDelegatesAndCancel];
    self.likeRequest = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshWeiBoLike" object:nil];
    
    [super dealloc];
}

static HomeViewController * homeViewControlerInstance;
+ (HomeViewController *) getShareHomeViewController {
    return homeViewControlerInstance;
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
            likeYtTopic.count_dz = [NSString stringWithFormat:@"%ld",(long)[likeYtTopic.count_dz integerValue] + 1];
        }else{
            likeYtTopic.count_dz = [NSString stringWithFormat:@"%ld",(long)[likeYtTopic.count_dz integerValue] - 1];
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
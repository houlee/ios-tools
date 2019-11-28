//
//  NewsViewController.m
//  caibo
//
//  Created by  on 12-7-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "NewsViewController.h"
#import "DetailedViewController.h"
#import "YtTopic.h"
#import "NetURL.h"
#import "JSON.h"
#import "NewsData.h"
#import "LotteryNewsCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Info.h"
#import "NewPostViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "LunBoView.h"
#import "EveryDayForecastCell.h"
#import "ForecastNumImageView.h"
#import "SendMicroblogViewController.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation NewsViewController
@synthesize mRefreshView;
@synthesize moreCell;
@synthesize httprequest;

-(id)init
{
	if ((self=[super init])) {
		
		UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"预测" image:UIImageGetImageFromName(@"tabxw.png") tag:1];
		
		self.tabBarItem = messageItem;
		[messageItem release];
	}
	return self;
}

-(id)initWithBlogtype:(NSString *)blogtype
{
	if ((self=[super init])) {
		blogType = blogtype;
	}
	return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

- (void)sleepDoBack{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)doBack{
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    if (lunBoView.lunBoRunLoopRef) {
        CFRunLoopStop(lunBoView.lunBoRunLoopRef);
        lunBoView.lunBoRunLoopRef = nil;
    }  
    if (onebool == NO) {
         [self performSelector:@selector(sleepDoBack) withObject:nil afterDelay:0.3];
        onebool = YES;
    }
}

- (void)presszhuce:(UIButton *)sender{
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil lunBoView:lunBoView];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
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

- (void)pressWriteButton:(UIButton *)sender{

    [MobClick event:@"event_weibohudong_faxinweibo"];
#ifdef isCaiPiaoForIPad

     [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController shareTo:@"" isShare:NO];

#else

    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];

#endif
   

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cellReadArray = [[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ForecastCellRead"]] retain];
    
    isAllRefresh = NO;
    pointsta = 0;
    dianx = 0;
    poinbool = YES;
    topicDataArry = [[NSMutableArray alloc] initWithCapacity:0];
    upArray = [[NSMutableArray alloc] initWithCapacity:0];
    dijige = 3;
    ddd = 1;
    tingtime = 0;
    wuting = 0;
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
//    bgview.image = UIImageGetImageFromName(@"login_bgn.png");
    bgview.backgroundColor = WEIBO_BG_COLOR;
    [self.mainView addSubview:bgview];
    [bgview release];
        
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        if ([blogType length]) {
            self.CP_navigation.title = @"广场";
        }else{
            self.CP_navigation.title = @"预测";
        }

        self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
#ifdef isCaiPiaoForIPad
        self.CP_navigation.leftBarButtonItem = nil;
#endif
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录" Target:self action:@selector(presszhuce:) ImageName:nil Size:CGSizeMake(70,30)];

	}
	else {
        
        if ([blogType length]) {
            self.CP_navigation.title = @"广场";
        }else{
            self.CP_navigation.title = @"预测";
        }
        self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
#ifdef isCaiPiaoForIPad
        self.CP_navigation.leftBarButtonItem = nil;
#endif
        
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

    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.mainView.bounds.size.height - 49.5) style:UITableViewStylePlain];
    if ([blogType length]) {
        myTableView.frame = CGRectMake(0, 0, 320,self.mainView.bounds.size.height);
    }
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(0, 160, 390, self.mainView.bounds.size.height - 200);
#endif
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.dataSource = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
        
    CBRefreshTableHeaderView *headerview =
	[[CBRefreshTableHeaderView alloc]
	 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.backgroundColor = [UIColor clearColor];
	mRefreshView.delegate = self;
	[myTableView addSubview:mRefreshView];
	[headerview release];
    
    [self requestHttpNews];

    
    lunBoView = [[LunBoView alloc] initWithFrame:CGRectMake(0, 0, 320, 176.5) newsViewController:self];
    [myTableView setTableHeaderView:lunBoView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [topicDataArry count]) {
		
		return  50.0;
		
	} else {
        NewsData *pic = [topicDataArry objectAtIndex:indexPath.row];

		if ([pic.type_news1 integerValue] == 3 || [pic.type_news1 integerValue] == 4 || [pic.type_news1 integerValue] == 5)
        {
            return WEIBO_YUCE_CELL_HEIGHT_1;
        }
		return  WEIBO_YUCE_CELL_HEIGHT;
		
	}
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topicDataArry count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [topicDataArry count]) {
        NSString * CellIdentifier = @"MoreLoadCell";
		MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell1 == nil) {
			cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
			//moreCell.backgroundColor = [UIColor clearColor];
		}
		if (moreCell == nil) {
			self.moreCell = cell1;
		}
        if([tableView numberOfRowsInSection:indexPath.section] > 1)
        {
            [moreCell spinnerStartAnimating];
            [self requestHttpNews];//网络链接
        }
        
        
        cell1.backgroundColor = [UIColor clearColor];
		return cell1;
	}
	else {
        NewsData *pic = [topicDataArry objectAtIndex:indexPath.row];
        if ([pic.type_news1 integerValue] == 3 || [pic.type_news1 integerValue] == 4 || [pic.type_news1 integerValue] == 5) {
            NSString * identifier = @"forecast";
            EveryDayForecastCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[EveryDayForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            }
            if ([pic.type_news1 integerValue] == 3) {
                cell.lotteryNameLabel.text = @"双色球";
            }else if ([pic.type_news1 integerValue] == 4){
                cell.lotteryNameLabel.text = @"大乐透";
            }else if ([pic.type_news1 integerValue] == 5){
                cell.lotteryNameLabel.text = @"3D";
            }

            cell.issueLabel.text = [NSString stringWithFormat:@"%@期",pic.issue];
            NSArray * numberArray = [pic.intro componentsSeparatedByString:@","];
            
            displayColor = 0;
            
//            numberArray = [@[@"红",@"1",@"2",@"3",@"胆",@"3",@"2",@"1",@"蓝",@"1",@"2",@"3",@"胆",@"3",@"2",@"1"] retain];
            
            for (int i = 0; i < 20; i++) {
                ForecastNumImageView * numberImageView = (ForecastNumImageView *)[cell.bgImageView viewWithTag:10 + i];
                if (i < 19 && i < numberArray.count) {
                     numberImageView.numLabel.text = [numberArray objectAtIndex:i];
                    if ([numberImageView.numLabel.text isEqualToString:@"红"] || [numberImageView.numLabel.text isEqualToString:@"百"] || [numberImageView.numLabel.text isEqualToString:@"十"] || [numberImageView.numLabel.text isEqualToString:@"个"] || [numberImageView.numLabel.text isEqualToString:@"合"]) {
                        displayColor = WhiteRed;
                        numberImageView.backgroundColor = [UIColor redColor];
                    }else if ([numberImageView.numLabel.text isEqualToString:@"蓝"]) {
                        displayColor = WhiteBlue;
                        numberImageView.backgroundColor = [SharedMethod getColorByHexString:@"1588da"];
                    }else if ([numberImageView.numLabel.text isEqualToString:@"胆"]){
                        if (displayColor == 1) {
                            numberImageView.backgroundColor = [UIColor redColor];
                            displayColor = WhiteRed;
                        }else{
                            numberImageView.backgroundColor = [SharedMethod getColorByHexString:@"1588da"];
                            displayColor = WhiteBlue;
                        }
                    }else{
                        numberImageView.backgroundColor = [SharedMethod getColorByHexString:@"b8edfe"];
                    }
                    
                    if (displayColor == WhiteRed) {
                        numberImageView.numLabel.textColor = [UIColor whiteColor];
                        displayColor = Red;
                    }else if (displayColor == Red) {
                        numberImageView.numLabel.textColor = [UIColor redColor];
                    }else if (displayColor == WhiteBlue) {
                        numberImageView.numLabel.textColor = [UIColor whiteColor];
                        displayColor = Blue;
                    }else{
                        numberImageView.numLabel.textColor = [SharedMethod getColorByHexString:@"1588da"];
                    }
                }else if (i == 19){
                    UIImageView * arrow = (UIImageView *)[numberImageView viewWithTag:1010];
                    if (!arrow) {
                        UIImageView * arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberImageView.bounds.origin.x + 5, numberImageView.bounds.origin.y + 2.5, 8.5, 13)];
                        arrowImageView.image = UIImageGetImageFromName(@"chongzhijian.png");
                        arrowImageView.tag = 1010;
                        [numberImageView addSubview:arrowImageView];
                        [arrowImageView release];
                    }
                    
                }else{
                    numberImageView.numLabel.text = @"";
                    numberImageView.backgroundColor = [SharedMethod getColorByHexString:@"b8edfe"];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];

            return cell;
        }else{
            NSString * CellIdentifier = @"TopicCell";
            LotteryNewsCell *cell =(LotteryNewsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil) {
                cell = [[[LotteryNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            YtTopic *status = [[YtTopic alloc] init];
            status.content = pic.content;
            status.timeformate = pic.timeformate;
            status.attach_small = pic.attach_small;
            status.count_pl = pic.count_pl;
            status.count_zf = pic.count_zf;
            status.newstitle = pic.newstitle;
            [cell LoadData:status];
            [status release];
            
            
            if ([cellReadArray containsObject:pic.newsid]) {
                cell.newsLabel.textColor = [SharedMethod getColorByHexString:@"9c9c9c"];
            }else{
                cell.newsLabel.textColor = [SharedMethod getColorByHexString:@"1a1a1a"];
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            return cell;
        }
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [topicDataArry count]) {
        [moreCell spinnerStartAnimating];
        [self requestHttpNews];//网络链接
    }else{
        
        NewsData *mStatus = [topicDataArry objectAtIndex:indexPath.row];
        // 针对6条新闻推送先获取最新数据再跳转到微博正文页
        
        
        if (![cellReadArray containsObject:mStatus.newsid] && [[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[LotteryNewsCell class]]) {
            [cellReadArray addObject:mStatus.newsid];
            [[NSUserDefaults standardUserDefaults] setObject:cellReadArray forKey:@"ForecastCellRead"];

            LotteryNewsCell * selectCell = (LotteryNewsCell *)[tableView cellForRowAtIndexPath:indexPath];
            selectCell.newsLabel.textColor = [SharedMethod getColorByHexString:@"9c9c9c"];
        }
        
        if (mStatus.newsid) {
            [httprequest clearDelegatesAndCancel];
            //                [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.topicid]]];
            self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.newsid]];
            [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httprequest setDelegate:self];
            [httprequest setDidFinishSelector:@selector(newsInfo:)];
            [httprequest setTimeOutSeconds:20.0];
            [httprequest startAsynchronous];
            return;
        }
        
        
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	//[self reloadSegmentData];
    isAllRefresh = YES;
    isLoading = YES;
    [self requestHttpNews];//网络请求
}

// 加载更多
- (void)doMoreLoading
{
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
    [moreCell spinnerStopAnimating];
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
        if (!isAllRefresh) {
			[self performSelector:@selector(requestHttpNews) withObject:nil afterDelay:0.5];//网络请求
            [moreCell spinnerStartAnimating];
        }
	}
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

//网络请求函数
- (void)requestHttpNews{
    
    page = page+1;//[topicDataArry count]/20 +1;
    
    if (isLoading) {
        page = 1;
        
    }else{
        //        if ([topicDataArry count] %20 != 0) {
        //
        //            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //            [cai showMessage:@"加载完毕"];
        //            [moreCell spinnerStopAnimating];
        //            return;
        //        }
        
    }
    NSString * pagesize;
    if (page ==1) {
        pagesize = @"20";
    }else{
        pagesize = @"20";
    }
    
    
    [httprequest clearDelegatesAndCancel];
//    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeNewsPageSize:pagesize pageNum:[NSString stringWithFormat:@"%d", page]]];
    if ([blogType length]) {
        self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL getYtTopicTypelistByByBlogtype:blogType pageNum:[NSString stringWithFormat:@"%d", page] pageSize:pagesize]];
    }else{
        self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL getForecastContentWithPageSize:pagesize pageNum:[NSString stringWithFormat:@"%d", page]]];
    }
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setDidFailSelector:@selector(dismissRefreshTableHeaderView)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSInteger dataNum = 0;

    NSLog(@"respon6 = %@", responseString);
    if (isLoading) {
        [topicDataArry removeAllObjects];
        [upArray removeAllObjects];
    }
    if(responseString){
        
        if ([blogType length]) {
            NSMutableArray *array = [[responseString JSONValue] valueForKey:@"topicList"];

            for (NSDictionary * dic in array) {
                NewsData * newsData = [[NewsData alloc] init];
                newsData.newstitle = [dic valueForKey:@"rec_title"];
                newsData.content = [dic valueForKey:@"rec_content"];
                newsData.attach_small = [dic valueForKey:@"attach_small"];
                newsData.newsid = [dic valueForKey:@"id"];
                [topicDataArry addObject:newsData];
                [newsData release];
            }
            
            NSArray * newsArray = [[responseString JSONValue] valueForKey:@"toppicList"];
            if (newsArray.count) {
                NSDictionary * newsDic = [newsArray objectAtIndex:0];
                NewsData * newsData = [[[NewsData alloc] init] autorelease];
                newsData.attach_small = [newsDic valueForKey:@"picurl"];
                newsData.newsid = [newsDic valueForKey:@"topicid"];
                newsData.type_news1 = @"1";

                [upArray removeAllObjects];
                [upArray addObject:newsData];
                
                [myTableView setTableHeaderView:lunBoView];
            }else{
                [myTableView setTableHeaderView:nil];
            }
            dataNum = array.count;
            
        }else{
            NSMutableArray *array = [responseString JSONValue];
            for (NSDictionary * dic in array) {
                NewsData * newsdata = [[NewsData alloc] init];
                newsdata.newstitle = [dic objectForKey:@"newstitle"];
                newsdata.newstime = [dic  objectForKey:@"date_created"];
                newsdata.newsid = [dic objectForKey:@"id"];
                newsdata.laizi = [dic objectForKey:@"date_created"];
                newsdata.intro = [dic valueForKey:@"intro"];
                newsdata.content = [dic valueForKey:@"rec_content"];
                NSLog(@"content = %@", newsdata.content);
                newsdata.timeformate = [dic valueForKey:@"timeformate"];
                newsdata.issue = [dic valueForKey:@"issue"];
                newsdata.type_news1 = [dic valueForKey:@"type_news1"];
                NSLog(@"%@" , newsdata.attach_small);
                
                
                newsdata.count_zf = [dic valueForKey:@"count_zf"];
                if (!newsdata.count_zf || [newsdata.count_zf length] <= 0) {
                    newsdata.count_zf = @"0";
                }
                
                newsdata.count_pl =  [dic valueForKey:@"count_pl"];
                if (!newsdata.count_pl || [newsdata.count_pl length] <= 0) {
                    newsdata.count_pl = @"0";
                }
                
                newsdata.type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"news_type"] ];
                
                if ([newsdata.type isEqualToString:@"3"]) {
                    newsdata.attach_small = [dic valueForKey:@"image_b"];//@"attach_small"];//
                    newsdata.attach_small = [NSString stringWithFormat:@"http://fimg.cmwb.com%@", newsdata.attach_small];
                    [upArray addObject:newsdata];
                }else{
                    newsdata.attach_small = [dic valueForKey:@"image_s"];//@"attach_small"];//
                    newsdata.attach_small = [NSString stringWithFormat:@"http://fimg.cmwb.com%@", newsdata.attach_small];
                    [topicDataArry addObject:newsdata];
                }
                [newsdata release];
                
            }
            dataNum = array.count;

        }
    }
    
    if (upArray.count != 0) {
        if ([blogType length]) {
            lunBoView.hiddenGrayTitleImage = YES;
        }
        [lunBoView setImageWithArray:upArray];
    }
    
    if(dataNum != 0)
    {
        [myTableView reloadData];
    }
    
//    [myTableView reloadData];
    [moreCell spinnerStopAnimating];
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    isAllRefresh = NO;
    isLoading = NO;
}

- (void)newsInfo:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    [detailed setHidesBottomBarWhenPushed:NO];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
}
-(void)viewWillDisappear:(BOOL)animated{

    
//    if (lunBoView.lunBoRunLoopRef) {
//        CFRunLoopStop(lunBoView.lunBoRunLoopRef);
//        lunBoView.lunBoRunLoopRef = nil;
//    }
    
    [super viewWillDisappear:animated];
}
- (void)dealloc{
//    [lunnewsla release];
    
    if (lunBoView.lunBoRunLoopRef) {
        CFRunLoopStop(lunBoView.lunBoRunLoopRef);
        lunBoView.lunBoRunLoopRef = nil;
    }
    [upArray release];
//    [lunview release];
    [httprequest clearDelegatesAndCancel];
    self.httprequest = nil; 
    [topicDataArry release];
    self.moreCell = nil;
    [mRefreshView release];
    [myTableView release];
    [lunBoView release];
    [blogType release];
    [cellReadArray release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
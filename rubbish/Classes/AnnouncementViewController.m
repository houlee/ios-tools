//
//  AnnouncementViewController.m
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import "AnnouncementViewController.h"
#import "LoginViewController.h"
#import "NewPostViewController.h"
#import "Info.h"
#import "NewsData.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "JSON.h"
#import "DetailedViewController.h"
#import "SysAnnCell.h"
#import "SendMicroblogViewController.h"

@implementation AnnouncementViewController
@synthesize mRefreshView;
@synthesize httprequest;

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presszhuce:(UIButton *)sender{
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
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
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isAllRefresh = NO;

    topicDataArry = [[NSMutableArray alloc] initWithCapacity:0];
    upArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bgview];
    [bgview release];
    
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        self.CP_navigation.title = @"系统公告";
        
        self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 70, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:9 topCapHeight:9];
        [btn addSubview:imagevi];
        [imagevi release];
        
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
        lilable.font = [UIFont boldSystemFontOfSize:11];
        lilable.shadowColor = [UIColor blackColor];//阴影
        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"登录注册";
        [btn addSubview:lilable];
        [lilable release];
        [btn addTarget:self action:@selector(presszhuce:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(presszhuce:) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
        [barBtnItem release];
	}
	else {
        
        self.CP_navigation.title = @"系统公告";
        self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
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
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.mainView.bounds.size.height) style:UITableViewStylePlain];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topicDataArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsData *pic = [topicDataArry objectAtIndex:indexPath.row];
    NSString * CellIdentifier = @"TopicCell";
    SysAnnCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[[SysAnnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.row != topicDataArry.count - 1) {
        cell.xian.image = [UIImage imageNamed:@"ForecastLine.png"] ;
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
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [myTableView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsData *mStatus = [topicDataArry objectAtIndex:indexPath.row];
    // 针对6条新闻推送先获取最新数据再跳转到微博正文页
    
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
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}

//网络请求函数
- (void)requestHttpNews{
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL getGonggao]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    NSString *responseString = [request responseString];
    NSLog(@"respon6 = %@", responseString);
    if (isLoading) {
        [topicDataArry removeAllObjects];
        [upArray removeAllObjects];
    }
    if(responseString){
        
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
        //        NewsData * newsdataa = [upArray objectAtIndex:0];
        //        lunnewsla.text = newsdataa.newstitle;
    }
    
    NSLog(@"uparray = %@", upArray);
    
    [myTableView reloadData];
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

- (void)dealloc{
    [upArray release];
    [httprequest clearDelegatesAndCancel];
    [topicDataArry release];
    [mRefreshView release];
    [myTableView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  JiangLiHuoDongViewController.m
//  caibo
//
//  Created by zhang on 11/1/12.
//
//

#import "JiangLiHuoDongViewController.h"
#import "Info.h"
#import "LotteryNewsCell.h"
#import "NewsData.h"
#import "NetURL.h"
#import "JSON.h"
#import "DownLoadImageView.h"
#import "DetailedViewController.h"
#import "FAQView.h"
#import "QuestionViewController.h"

@interface JiangLiHuoDongViewController ()

@end

@implementation JiangLiHuoDongViewController
@synthesize moreCell;
@synthesize httprequest;
@synthesize mRefreshView;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadiPhoneView {

    self.CP_navigation.title = @"奖励活动";
    
//    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
//	self.CP_navigation.leftBarButtonItem = left;
    
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    UIWebView *web = [[ UIWebView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://caipiao365.com/huodong/index.html"]]];
    [web release];
    
    
    web.delegate=self;
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
//    UIButton * exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
//    [exitLoginButton addTarget:self action:@selector(goFAQ) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(60-24, (40 - 24)/2, 24, 24)];
//    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = UIImageGetImageFromName(@"GC_icon8.png") ;
//    [exitLoginButton addSubview:imagevi];
//    [imagevi release];
//    
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:exitLoginButton];
//    self.CP_navigation.rightBarButtonItem = barBtnItem;
//    [barBtnItem release];
//    
////    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(goFAQ) ImageName:@"GC_icon8.png"Size:CGSizeMake(35, 35)];
//    
//    isAllRefresh = NO;
//    JLdataArray = [[NSMutableArray alloc] initWithCapacity:0];
//    upArray = [[NSMutableArray alloc] initWithCapacity:0];
//    
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height-64) style:UITableViewStylePlain];
////    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    myTableView.backgroundColor = [UIColor clearColor];
//    myTableView.delegate = self;
//    myTableView.dataSource = self;
//    [self.mainView addSubview:myTableView];
//    
//    [self requestHttpNews];//网络请求
//    
//    
//    CBRefreshTableHeaderView *headerview =
//	[[CBRefreshTableHeaderView alloc]
//	 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
//	self.mRefreshView = headerview;
//	mRefreshView.backgroundColor = [UIColor clearColor];
//	mRefreshView.delegate = self;
//	[myTableView addSubview:mRefreshView];
//	[headerview release];

}

-(void)goFAQ {
    
    QuestionViewController *ques = [[QuestionViewController alloc] init];
    ques.question = jiangLiHuoDong;
    [self.navigationController pushViewController:ques animated:YES];
    [ques release];
}

- (void)LoadiPadView {

    self.CP_navigation.title = @"奖励活动";
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
    
    UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];

    isAllRefresh = NO;
    JLdataArray = [[NSMutableArray alloc] initWithCapacity:0];
    upArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 390, self.mainView.bounds.size.height-20) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    
    [self requestHttpNews];//网络请求
    
    
    CBRefreshTableHeaderView *headerview =
	[[CBRefreshTableHeaderView alloc]
	 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.backgroundColor = [UIColor clearColor];
	mRefreshView.delegate = self;
	[myTableView addSubview:mRefreshView];
	[headerview release];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
#ifdef isCaiPiaoForIPad
    
    [self LoadiPadView];
#else
    
    [self LoadiPhoneView];
#endif
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark myTableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [JLdataArray count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [JLdataArray count]) {
        return 50.0;
    }else{
    
        return 59;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [JLdataArray count]) {
        NSString * CellIdentifier = @"MoreLoadCell";
    
		MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell1 == nil) {
			cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		
		if (moreCell == nil) {
			self.moreCell = cell1;
		}
        
		return cell1;

    }else{
    
        //*
        NewsData *pic = [JLdataArray objectAtIndex:indexPath.row];
        NSString * CellIdentifier = @"TopicCell";
        
        LotteryNewsCell *cell =(LotteryNewsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil) {
            
            cell = [[[LotteryNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell xianHidden];
        
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
    return nil;
}
//*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [JLdataArray count]) {
        [moreCell spinnerStartAnimating];
        [self requestHttpNews];//网络链接
    }else{
    
        NewsData *mStatus = [JLdataArray objectAtIndex:indexPath.row];
        // 针对6条新闻推送先获取最新数据再跳转到微博正文页
        
        if (mStatus.newsid) {
            [httprequest clearDelegatesAndCancel];
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

- (void)newsInfo:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];//微博
    [detailed setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
}


//网络请求函数
- (void)requestHttpNews{
    
    page = page+1;    
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
        pagesize = @"25";
    }else{
        pagesize = @"20";
    }
    
    
    [httprequest clearDelegatesAndCancel];
    //self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeNewsPageSize:pagesize pageNum:[NSString stringWithFormat:@"%d", page]]];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CPQueryActivtyListPageSize:pagesize pageNum:[NSString stringWithFormat:@"%ld", (long)page]]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}


- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    if (isLoading) {
        [JLdataArray removeAllObjects];
        [upArray removeAllObjects];
    }
     NSMutableArray *array = [responseString JSONValue];
    if(responseString){
        
       
        for (NSDictionary * dic in array) {
            NewsData * newsdata = [[NewsData alloc] init];
            newsdata.newstitle = [dic objectForKey:@"newstitle"];
            newsdata.newstime = [dic  objectForKey:@"date_created"];
            newsdata.newsid = [dic objectForKey:@"id"];
            newsdata.laizi = [dic objectForKey:@"date_created"];
            newsdata.content = [dic valueForKey:@"intro"];
            newsdata.timeformate = [dic valueForKey:@"timeformate"];
            
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
                [JLdataArray addObject:newsdata];
            }
            [newsdata release];
        }
        
    }
    
    
    
    [myTableView reloadData];
    [moreCell spinnerStopAnimating];
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    isAllRefresh = NO;
    isLoading = NO;
    if ([array count] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
   
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
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc
{

    [JLdataArray release];
    [upArray release];
    [myTableView release];
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    [mRefreshView release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
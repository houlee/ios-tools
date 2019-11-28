//
//  HisSchemeViewController.m
//  caibo
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "HisSchemeViewController.h"
#import "DetailsViewController.h"


@implementation HisSchemeViewController
@synthesize refreshHeaderView;
@synthesize request;
@synthesize userId;
@synthesize topicLoadCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isLoadMore = NO;
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    
    myTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.mainView addSubview:myTableView];
    myTableView.backgroundColor = [UIColor clearColor];
    restArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self requesthttp];
    
       //下拉刷新 
    if (refreshHeaderView==nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - myTableView.frame.size.height, myTableView.frame.size.width, myTableView.frame.size.height)];
		
		headerview.delegate = self;
		
		[myTableView addSubview:headerview];
		
		self.refreshHeaderView = headerview;
		
		[headerview release];
		
	}


    
    
    //假数据
//    statisticsData = [[StatisticsData alloc] init];
//    
//    statisticsData.use = @"用户名";
//    statisticsData.timeNum = @"zl12035";
//    statisticsData.money = @"9999";
//    statisticsData.number = @"512";
//    statisticsData.right = @"14";
//    statisticsData.rightField = @"3";
//    statisticsData.time = @"03-09 18:35";
//    statisticsData.allNum = @"3,3,31,3,31,3,3,3,3,1,1,1,1,1";
    NSLog(@"self userID = %@", self.userId);
}

- (void)requesthttp{
    if ([restArray count] == 0 || _reloading == YES || isLoadMore == YES) {
   
    
    self.request = [ASIHTTPRequest requestWithURL:[NetURL myPkBetRecordUseId:self.userId pageNum:[self pageNumBet]]]; 
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(RecordsDidFinishSelector:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
    }

}

// 调用  UIScrollViewDelegate 下拉过程中 调用  
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	// 下拉刷新
	
	[refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!isLoadMore){
			if (topicMoreCell) {
				[topicMoreCell spinnerStartAnimating];
				isLoadMore = YES;
				[self performSelector:@selector(requesthttp) withObject:nil afterDelay:.5];
				
			}
		}
	}
	[refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];

    
}


- (void)reloadTableViewDataSource{

	_reloading = YES;
}


- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
    //	self.navigationItem.rightBarButtonItem.enabled = NO;
    //	self.navigationItem.leftBarButtonItem.enabled = NO;
	_reloading = YES;
//	if (self.pkMatchType == PKMatchTypeRank) {
//        [self requestHttp];
//    }
//    else  if (self.pkMatchType == PKMatchTypeBettingRecords){
//        [self requestHttpRecords];
//    }
//    else if(self.pkMatchType == PKMatchTypeCross){
//        [self requestHttpCross];
//    }
    [self requesthttp];
	[self reloadTableViewDataSource];
	
	[refreshHeaderView setState:CBPullRefreshLoading];
    
//	self.PKtableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    
	
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


- (void)RecordsDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSArray * array = [dict objectForKey:@"data"];
    NSLog(@"dict = %@", dict);
    if (_reloading == YES ) {
        [restArray removeAllObjects];
    }
    
    for (NSDictionary * di in array) {
        StatisticsData * sta = [[StatisticsData alloc] initWithDuc:di];
        [restArray addObject:sta];
        [sta release];
    }
    [myTableView reloadData];

    isLoadMore = NO;
    _reloading = NO;
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    [topicMoreCell spinnerStopAnimating2:NO];
    if ([array count] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [topicMoreCell spinnerStopAnimating];
        [topicMoreCell setInfoText:@"加载完毕"];
    }
}


- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)pageNumBet{

    if (_reloading == YES || [restArray count] == 0) {
        NSString * str = @"1";
        return str;
    }
    NSInteger pag = [restArray count] % 20;
    if (pag != 0) {
        NSString * str = @"0";
        return str;
    }else{
    
    NSInteger page = ([restArray count] -1) / 20 +1;
    
    NSString * str = [NSString stringWithFormat:@"%d", (int)page+1];
   
    return str;
    }
    return @"1";
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [restArray count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==[restArray count]) {
        return 40;
    }
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    
    return 41;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)] autorelease];
    view.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 300, 30)];
    imageV.image = [UIImageGetImageFromName(@"PKTouBg.png") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    
    //期号
    UILabel * timeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 61, 20)];
    timeNum.backgroundColor = [UIColor clearColor];
    timeNum.text = @"用户";
    timeNum.textAlignment = NSTextAlignmentCenter;
    timeNum.font = [UIFont systemFontOfSize:10];
    timeNum.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //画竖线
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 0, 1, 30)];
    line1.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //奖金
    UILabel* money = [[UILabel alloc] initWithFrame:CGRectMake(61, 5, 47, 20)];
    money.textAlignment = NSTextAlignmentCenter;
    money.text = @"奖金";
    money.backgroundColor = [UIColor clearColor];
    money.font = [UIFont systemFontOfSize:10];
    money.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //画竖线
    UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(108, 0, 1, 30)];
    line2.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //注数
    UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(108, 5, 47, 20)];
    number.textAlignment = NSTextAlignmentCenter;
    number.text = @"注数";
    number.backgroundColor = [UIColor clearColor];
    number.font = [UIFont systemFontOfSize:10];
    number.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //画竖线
    UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 0, 1, 30)];
    line3.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //全对注数
    UILabel * allRight = [[UILabel  alloc] initWithFrame:CGRectMake(155, 5, 72, 20)];
    allRight.textAlignment = NSTextAlignmentCenter;
    allRight.text = @"全对注数";
    allRight.backgroundColor = [UIColor clearColor];
    allRight.font = [UIFont systemFontOfSize:10];
    allRight.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //画竖线
    UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(227, 0, 1, 30)];
    line4.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //正确场次
    UILabel * right = [[UILabel alloc] initWithFrame:CGRectMake(227, 5, 73, 20)];
    right.textAlignment = NSTextAlignmentCenter;
    right.text = @"正确场次";
    right.backgroundColor = [UIColor clearColor];
    right.font = [UIFont systemFontOfSize:10];
    right.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    
    [imageV addSubview:timeNum];
    [imageV addSubview:money];
    [imageV addSubview:number];
    [imageV addSubview:allRight];
    [imageV addSubview:right];
    
    [imageV addSubview:line1];
    [imageV addSubview:line2];
    [imageV addSubview:line3];
    [imageV addSubview:line4];
    [view addSubview:imageV];
    
    [timeNum release];
    [money release];
    [number release];
    [allRight release];
    [right release];
    [line1 release];
    [line2 release];
    [line3 release];
    [line4 release];
    [imageV release];
    
    return view;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [restArray count]) {
        NSString * CellIdentifier = @"load";
        MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell==nil){
            cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
 //       if (topicMoreCell==nil) {
            topicMoreCell = cell;
   //     }
        [cell spinnerStopAnimating2:NO];
        return cell;

    }else{
        
        static NSString * cellID = @"cellID1";
        MyCathecticCell * cell = (MyCathecticCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[[MyCathecticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.pkmatch = PKMatchTypeBettingMecell;
        cell.statisticsData = [restArray objectAtIndex:indexPath.row];
        return cell;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [restArray count]) {
        isLoadMore = YES;
        [topicMoreCell spinnerStartAnimating2];
        [self requesthttp];
        //[self performSelector:@selector(requesthttp) withObject:nil afterDelay:.5];
        
    }else{
    
        DetailsViewController * devc = [[DetailsViewController alloc] init];
        
        StatisticsData * statistics = [restArray objectAtIndex:indexPath.row];
        devc.orderId = statistics.orderId;
        NSLog(@"orderID =%@", statistics.orderId);
        [self.navigationController pushViewController:devc animated:YES];
        [devc release];
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

- (void)dealloc{
    [userId release];
    [restArray release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    [myTableView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
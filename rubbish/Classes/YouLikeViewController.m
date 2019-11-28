    //
//  YouLikeViewController.m
//  caibo
//
//  Created by yao on 11-12-2.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "YouLikeViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "JSON.h"
#import "FolloweeCell.h"
#import "Followee.h"
#import "ProfileViewController.h"
#import "YtTheme.h"
#import "AttenList.h"

@implementation YouLikeViewController
@synthesize mTableView;
@synthesize mRefreshView;
@synthesize request;
@synthesize mySegment;
@synthesize dataDic;

#pragma mark Action


- (void)segmentedcontrolEventValueChanged {
	[request cancel];
	//if (self.mySegment.selectedSegmentIndex == 0) {
		//1专家 2彩你喜欢 3红人
	//推荐，战绩，专家，红人，认证
	NSInteger type = 1;
	
	SEL sel= nil;

	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			sel = @selector(recData:);
			type = 2;
			if ([[self.dataDic objectForKey:@"recData"] count] != 0) {
				[self.mTableView reloadData];
				return;
			}
			break;
		case 1:
			sel = @selector(scoreData:);
			type = 4;
			if ([[self.dataDic objectForKey:@"scoreData"] count] != 0) {
				[self.mTableView reloadData];
				return;
			}
			break;
		case 2:
			sel = @selector(proData:);
			type = 1;
			if ([[self.dataDic objectForKey:@"proData"] count] !=0) {
				[self.mTableView reloadData];
				return;
			}
			break;
		case 3:
			sel = @selector(hotData:);
			type =3;
			if ([[self.dataDic objectForKey:@"hotData"] count] != 0) {
				[self.mTableView reloadData];
				return;
			}
			break;
		case 4:
			sel = @selector(realData:);
			type = 5;
			if ([[self.dataDic objectForKey:@"realData"] count] != 0) {
				[self.mTableView reloadData];
				return;
			}
			break;

		default:
			break;
	}
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetSpUsersList:[NSString stringWithFormat:@"%d",(int)type]
																	  pageNo:@"1" 
																	pageSize:@"20"
																	  userId:[[Info getInstance]userId]]]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:sel];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}

- (void)reloadSegmentData {
	[request cancel];
	//if (self.mySegment.selectedSegmentIndex == 0) {
	//1专家 2彩你喜欢 3红人
	//推荐，战绩，专家，红人，认证
	
	NSInteger type = 1;
	NSInteger num = 0;
	SEL sel= nil;
	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			sel = @selector(recData:);
			type = 2;
			num = [[self.dataDic objectForKey:@"recData"] count];
			break;
		case 1:
			sel = @selector(scoreData:);
			type = 4;
			num = [[self.dataDic objectForKey:@"scoreData"] count];
			break;
		case 2:
			sel = @selector(proData:);
			type = 1;
			num = [[self.dataDic objectForKey:@"proData"] count];
			break;
		case 3:
			sel = @selector(hotData:);
			type =3;
			num = [[self.dataDic objectForKey:@"hotData"] count];
			break;
		case 4:
			sel = @selector(realData:);
			type = 5;
			num = [[self.dataDic objectForKey:@"realData"] count];
			break;
			
		default:
			break;
	}
	num = (num -1)/20 +2;
	if (!isLoadingMore) {
		num = 1;
	}
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetSpUsersList:[NSString stringWithFormat:@"%d",(int)type]
																	  pageNo:[NSString stringWithFormat:@"%d",(int)num]
																	pageSize:@"20"
																	  userId:[[Info getInstance]userId]]]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:sel];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}

- (void)sendMoreFansRequest{
	isLoadingMore = YES;
	[self reloadSegmentData];
}


- (void)realData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	NSMutableArray *array = [responseString JSONValue];
	NSMutableArray *followeeArray = [NSMutableArray array];
	for(int i = 0; i <[array count];i++) {
		Followee *followee = [[Followee alloc] init];
		followee.mTag = 2;
		followee.userId = [[array objectAtIndex:i] objectForKey:@"id"];
		followee.name = [[array objectAtIndex:i] objectForKey:@"nick_name"];
		followee.vip = [[array objectAtIndex:i] objectForKey:@"vip"];
		followee.imageUrl = [[array objectAtIndex:i] objectForKey:@"mid_image"];
		followee.is_relation = [[array objectAtIndex:i] objectForKey:@"isAtt"];
		[followeeArray addObject:followee];
		[followee release];
	}
	if (isLoadingMore) {
		[[dataDic objectForKey:@"realData"] addObjectsFromArray:followeeArray];
	}
	else {
		[dataDic setValue:followeeArray forKey:@"realData"];	
	}
	isLoadingMore = NO;
//    NSLog(@"responseString = %@", responseString);
//	NSMutableArray *array = [responseString JSONValue];
//	[dataDic setValue:array forKey:@"realData"];
    if(followeeArray.count)
        [self.mTableView reloadData];
//	[self.mTableView reloadData];
	[fansMoreCell spinnerStopAnimating];
//	[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
}

- (void)scoreData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	NSMutableArray *array = [responseString JSONValue];
	NSMutableArray *followeeArray = [NSMutableArray array];
	for(int i = 0; i <[array count];i++) {
		Followee *followee = [[Followee alloc] init];
		followee.mTag = 2;
		followee.userId = [[array objectAtIndex:i] objectForKey:@"id"];
		followee.name = [[array objectAtIndex:i] objectForKey:@"nick_name"];
		followee.vip = [[array objectAtIndex:i] objectForKey:@"vip"];
		followee.imageUrl = [[array objectAtIndex:i] objectForKey:@"mid_image"];
		followee.is_relation = [[array objectAtIndex:i] objectForKey:@"isAtt"];
		[followeeArray addObject:followee];
		[followee release];
	}
	if (isLoadingMore) {
		[[dataDic objectForKey:@"scoreData"] addObjectsFromArray:followeeArray];
	}
	else {
		[dataDic setValue:followeeArray forKey:@"scoreData"];	
	}
	isLoadingMore = NO;
//    NSLog(@"responseString = %@", responseString);
//	NSMutableArray *array = [responseString JSONValue];
//	[dataDic setValue:array forKey:@"scoreData"];
    if(followeeArray.count)
        [self.mTableView reloadData];
//	[self.mTableView reloadData];
	//[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
	[fansMoreCell spinnerStopAnimating];
}

- (void)proData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	NSMutableArray *array = [responseString JSONValue];
	NSMutableArray *followeeArray = [NSMutableArray array];
	for(int i = 0; i <[array count];i++) {
		Followee *followee = [[Followee alloc] init];
		followee.mTag = 2;
		followee.userId = [[array objectAtIndex:i] objectForKey:@"id"];
		followee.name = [[array objectAtIndex:i] objectForKey:@"nick_name"];
		followee.vip = [[array objectAtIndex:i] objectForKey:@"vip"];
		followee.imageUrl = [[array objectAtIndex:i] objectForKey:@"mid_image"];
		followee.is_relation = [[array objectAtIndex:i] objectForKey:@"isAtt"];
		[followeeArray addObject:followee];
		[followee release];
	}
	if (isLoadingMore) {
		[[dataDic objectForKey:@"proData"] addObjectsFromArray:followeeArray];
	}
	else {
		[dataDic setValue:followeeArray forKey:@"proData"];	
	}
	isLoadingMore = NO;
//    NSLog(@"responseString = %@", responseString);
//	NSMutableArray *array = [responseString JSONValue];
//	[dataDic setValue:array forKey:@"proData"];
	[fansMoreCell spinnerStopAnimating];
    if(followeeArray.count)
        [self.mTableView reloadData];
//	[self.mTableView reloadData];
	//[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
}
- (void)recData:(ASIHTTPRequest*)mrequest{	
	NSString *responseString = [mrequest responseString];
//    id list = nil;
//    if ([[mrequest username] isEqualToString:@"theme"]) {
//        list = [[YtTheme alloc] init];
//    } else {
//        list = [[AttenList alloc] init];
//    }
//	NSArray *requestData = [list initWithParse:responseString];
	NSMutableArray *array = [responseString JSONValue];
	NSMutableArray *followeeArray = [NSMutableArray array];
	for(int i = 0; i <[array count];i++) {
		Followee *followee = [[Followee alloc] init];
		followee.mTag = 2;
		followee.userId = [[array objectAtIndex:i] objectForKey:@"id"];
		followee.name = [[array objectAtIndex:i] objectForKey:@"nick_name"];
		followee.vip = [[array objectAtIndex:i] objectForKey:@"vip"];
		followee.imageUrl = [[array objectAtIndex:i] objectForKey:@"mid_image"];
		followee.is_relation = [[array objectAtIndex:i] objectForKey:@"isAtt"];
		[followeeArray addObject:followee];
		[followee release];
	}
	if (isLoadingMore) {
		[[dataDic objectForKey:@"recData"] addObjectsFromArray:followeeArray];
	}
	else {
		[dataDic setValue:followeeArray forKey:@"recData"];	
	}
	isLoadingMore = NO;
//	FolloweesViewController
//	NSString *responseString = [mrequest responseString];
//    NSLog(@"responseString = %@", responseString);
//	NSMutableArray *array = [responseString JSONValue];
//	[dataDic setValue:array forKey:@"recData"];
    if(followeeArray.count)
        [self.mTableView reloadData];
//	[self.mTableView reloadData];
	//[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
	[fansMoreCell spinnerStopAnimating];
}

- (void)hotData:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	NSMutableArray *array = [responseString JSONValue];
	NSMutableArray *followeeArray = [NSMutableArray array];
	for(int i = 0; i <[array count];i++) {
		Followee *followee = [[Followee alloc] init];
		followee.mTag = 2;
		followee.userId = [[array objectAtIndex:i] objectForKey:@"id"];
		followee.name = [[array objectAtIndex:i] objectForKey:@"nick_name"];
		followee.vip = [[array objectAtIndex:i] objectForKey:@"vip"];
		followee.imageUrl = [[array objectAtIndex:i] objectForKey:@"mid_image"];
		followee.is_relation = [[array objectAtIndex:i] objectForKey:@"isAtt"];
		[followeeArray addObject:followee];
		[followee release];
	}
	if (isLoadingMore) {
		[[dataDic objectForKey:@"hotData"] addObjectsFromArray:followeeArray];
	}
	else {
		[dataDic setValue:followeeArray forKey:@"hotData"];	
	}
//	[dataDic setValue:followeeArray forKey:@"hotData"];
//    NSLog(@"responseString = %@", responseString);
//	NSMutableArray *array = [responseString JSONValue];
//	[dataDic setValue:array forKey:@"hotData"];
	isLoadingMore = NO;
    if(followeeArray.count)
        [self.mTableView reloadData];
//	[self.mTableView reloadData];
	//[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
}

- (void)addAttention:(UIButton *)btn {
	NSMutableArray *array = nil;
	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			array = [self.dataDic objectForKey:@"recData"];
			break;
		case 1:
			array = [self.dataDic objectForKey:@"scoreData"];
			break;
		case 2:
			array = [self.dataDic objectForKey:@"proData"];
			break;
		case 3:
			array = [self.dataDic objectForKey:@"hotData"];
			break;
		case 4:
			array = [self.dataDic objectForKey:@"realData"];
			break;
		default:
			break;
	}
	if (btn.tag < [array count]) {
		NSDictionary *dic = [array objectAtIndex:btn.tag];
		if ([[dic objectForKey:@"isAtt"] isEqualToString:@"0"]) {
			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsaveAttention:[[Info getInstance]userId]
																		  attUserId:[dic objectForKey:@"id"]]]];
			[btn setImage:UIImageGetImageFromName(@"btn_cancelattention.png") forState:UIControlStateNormal];
			[dic setValue:@"1" forKey:@"isAtt"];
			[request setDidFinishSelector:@selector(addFinish:)];
		}
		else {
			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBcancelAttention:[[Info getInstance]userId]
																			attUserId:[dic objectForKey:@"id"]]]];
			[btn setImage:UIImageGetImageFromName(@"btn_addattention.png") forState:UIControlStateNormal];
			[dic setValue:@"0" forKey:@"isAtt"];
			[request setDidFinishSelector:@selector(cancelFinish:)];
		}
		selectIndex= btn.tag;
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[request setNumberOfTimesToRetryOnTimeout:2];
		[request startAsynchronous];
	}
}

- (void)addFinish:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
    NSLog(@"responseString = %@", responseString);
	NSDictionary *dic = [responseString JSONValue];
	if ([[dic objectForKey:@"result"] isEqualToString:@"succ"]) {		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self reloadSegmentData];
	}

}
- (void)cancelFinish:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
    NSLog(@"responseString = %@", responseString);
	NSDictionary *dic = [responseString JSONValue];
	if ([[dic objectForKey:@"result"] isEqualToString:@"succ"]) {
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消关注失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self reloadSegmentData];
	}
}

#pragma mark System

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	isLoadingMore= NO;
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.navigationItem setLeftBarButtonItem:leftItem];	
    
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	self.dataDic = dic;
	[dic release];
	self.navigationItem.title = @"猜你喜欢";
	NSArray *arryList = [NSArray arrayWithObjects:@" 推荐 ",@" 战绩 ",@" 专家 ",@" 红人 ",@" 认证 ",nil];
	UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:arryList];
	
	
	[segmented addTarget:self action:@selector(segmentedcontrolEventValueChanged) forControlEvents:UIControlEventValueChanged];
	//segmented.backgroundColor = [UIColor blackColor];
	segmented.selectedSegmentIndex =0;
	self.view.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"profile_belowbar.png")];
	self.mySegment = segmented;
	self.mySegment.frame = CGRectMake(40, 5, 240, 30);
	[self.view addSubview:mySegment];
	[segmented release];
	
	
	mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 380) style:UITableViewStylePlain];
	mTableView.delegate = self;
	//mTableView.separatorStyle = NO;
	mTableView.dataSource = self;
	[self.view addSubview:mTableView];
	CBRefreshTableHeaderView *headerview = 
	[[CBRefreshTableHeaderView alloc] 
	 initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.delegate = self;
	[self.mTableView addSubview:mRefreshView];
	[headerview release];
	[self segmentedcontrolEventValueChanged];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mTableView release];
	[mRefreshView release];
	[request cancel];
	[request release];
	[mySegment release];
    [super dealloc];
}


#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	[self reloadSegmentData];
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
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.mTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
			[self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];
		
	}	
	
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier;
//	YouLikeCell *cell = (YouLikeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if (!cell) {
//		cell = [[[YouLikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//		[cell.conBtn addTarget:self action:@selector(addAttention:) forControlEvents:UIControlEventTouchUpInside];
//	}
	NSMutableArray *array = nil;
	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			array = [self.dataDic objectForKey:@"recData"];
			break;
		case 1:
			array = [self.dataDic objectForKey:@"scoreData"];
			break;
		case 2:
			array = [self.dataDic objectForKey:@"proData"];
			break;
		case 3:
			array = [self.dataDic objectForKey:@"hotData"];
			break;
		case 4:
			array = [self.dataDic objectForKey:@"realData"];
			break;
			
			
		default:
			break;
	}
	if (indexPath.row == [array count]) {
		
		CellIdentifier = @"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			
		}
        if([tableView numberOfRowsInSection:indexPath.section] > 1)
        {
            [cell spinnerStartAnimating];
            [self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];
        }
        
        
		if (fansMoreCell==nil) 
			
			fansMoreCell =cell;
		
		
		return cell;
		
	}
	else {
		CellIdentifier = @"Cell";
		FolloweeCell *cell = (FolloweeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (!cell) {
			cell = [[[FolloweeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		[cell setFollowee:[array objectAtIndex:indexPath.row]];
		return cell;
	}

//	cell.nameLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"nick_name"];
//	cell.infoLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"newtopic"];
//	[cell.infoImageView setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:indexPath.row] objectForKey:@"mid_image"]] 
//					   placeholderImage:nil];
//	if ([[[array objectAtIndex:indexPath.row] objectForKey:@"isAtt"] isEqualToString:@"0"]) {
//		[cell.conBtn setImage:[UIImage imageNamed:@"btn_addattention.png"] forState:UIControlStateNormal];
//	}
//	else {
//		[cell.conBtn setImage:[UIImage imageNamed:@"btn_cancelattention.png"] forState:UIControlStateNormal];
//	}
//	cell.conBtn.tag = indexPath.row;
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//推荐，战绩，专家，红人，认证
	NSInteger count = 0;
	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			count = [[self.dataDic objectForKey:@"recData"] count];
			break;
		case 1:
			count = [[self.dataDic objectForKey:@"scoreData"] count];
			break;
		case 2:
			count = [[self.dataDic objectForKey:@"proData"] count];
			break;
		case 3:
			count = [[self.dataDic objectForKey:@"hotData"] count];
			break;
		case 4:
			count = [[self.dataDic objectForKey:@"realData"] count];
			break;

			
		default:
			break;
	}
	if (count%20!=0) {
		return count;
	}
	return count == 0?count:count+1;
	//return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSMutableArray *array = nil;
	switch (self.mySegment.selectedSegmentIndex) {
		case 0:
			array = [self.dataDic objectForKey:@"recData"];
			break;
		case 1:
			array = [self.dataDic objectForKey:@"scoreData"];
			break;
		case 2:
			array = [self.dataDic objectForKey:@"proData"];
			break;
		case 3:
			array = [self.dataDic objectForKey:@"hotData"];
			break;
		case 4:
			array = [self.dataDic objectForKey:@"realData"];
			break;
			
			
		default:
			break;
	}
	if (indexPath.row < [array count]) {
		Followee *followee = [array objectAtIndex:indexPath.row];
		[[Info getInstance] setHimId:followee.userId];
		
		ProfileViewController *profileVC =[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil]; 
		[self.navigationController pushViewController:profileVC animated:YES];
		[profileVC release];
	}
	else {
		MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
			[cell spinnerStartAnimating];
			[self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];			
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
    //
//  MoreNewsViewController.m
//  caibo
//
//  Created by yao on 11-12-9.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "MoreNewsViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "JSON.h"
#import "LotteryNewsCell.h"
#import "ProfileViewController.h"
#import "YtTheme.h"
#import "AttenList.h"
#import "DetailedViewController.h"
#import "HotYtTopicandComment.h"

@implementation MoreNewsViewController
@synthesize mTableView;
@synthesize mRefreshView;
@synthesize dataDic;
@synthesize dicData;


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


- (void)LoadData {
	//[request cancel];
	ASIHTTPRequest *request= [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" 
																 pageSize:@"20" 
																	 para:[dicData objectForKey:@"typeForSend"] 
																   userId:[[Info getInstance]userId]]];
	if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热转"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtTopic:[[Info getInstance]userId] 
																  pageNum:@"1" 
																 pageSize:@"20"]];
	}
	else if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热评"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtComment:[[Info getInstance]userId] 
																	pageNum:@"1" 
																   pageSize:@"20"]];
	}
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(footBallData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}



- (void)LoadMoreData {
	//[request cancel];
	NSInteger num =1;
	num = ([[self.dataDic objectForKey:@"footBallData"] count]-1)/20+2;
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[NSString stringWithFormat:@"%d",(int)num]
																		pageSize:@"20" 
																			para:[dicData objectForKey:@"typeForSend"] 
																		  userId:[[Info getInstance]userId]]];
	if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热转"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtTopic:[[Info getInstance]userId] 
																  pageNum:[NSString stringWithFormat:@"%d",(int)num]
																 pageSize:@"20"]];
	}
	else if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热评"]) {
		request = [ASIHTTPRequest requestWithURL:[NetURL CBlistHotYtComment:[[Info getInstance]userId] 
																	pageNum:[NSString stringWithFormat:@"%d",(int)num]
																   pageSize:@"20"]];
	}
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(MorefootBallData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}

- (void)sendMoreFansRequest{
	isLoadingMore = YES;
	[self LoadMoreData];
}


- (void)MorefootBallData:(ASIHTTPRequest*)mrequest{	
	NSString *responseString = [mrequest responseString];
	if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热评"]||[[dicData objectForKey:@"shortname"] isEqualToString:@"热转"]) {
		HotYtTopicandComment *hot = [[HotYtTopicandComment alloc] initWithParse:responseString];
		NSMutableArray *array1 = [[NSMutableArray alloc] init];
        for (HotYtTopicandComment *data in hot.arryList) {
            YtTopic *status = [self changeData:data];
            [array1 addObject:status];
        }
		if ([array1 count]) {
			[[dataDic objectForKey:@"footBallData"] addObjectsFromArray:array1];
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
            		}
		[array1 release];
		[hot release];
	}
	else {
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			[[dataDic objectForKey:@"footBallData"] addObjectsFromArray:topic.arrayList];
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
            
			isLoading = YES;
		}
		[topic release];
	}
	isLoadingMore = NO;
	[self.mTableView reloadData];
	[moreCell spinnerStopAnimating];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
  
}
- (void)footBallData:(ASIHTTPRequest*)mrequest{	
	NSString *responseString = [mrequest responseString];
	YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
	
	if ([[dicData objectForKey:@"shortname"] isEqualToString:@"热评"]||[[dicData objectForKey:@"shortname"] isEqualToString:@"热转"]) {
		HotYtTopicandComment *hot = [[HotYtTopicandComment alloc] initWithParse:responseString];
		NSMutableArray *array1 = [[NSMutableArray alloc] init];
        for (HotYtTopicandComment *data in hot.arryList) {
            YtTopic *status = [self changeData:data];
            [array1 addObject:status];
        }
		if ([array1 count]) {
			[dataDic setValue:array1 forKey:@"footBallData"];	
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
            		}
		[array1 release];
		[hot release];
	}
	else {
		if ([topic.arrayList count]>0) {
			
			[dataDic setValue:topic.arrayList forKey:@"footBallData"];	
			
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
            
			isLoading = YES;
		}
	}
	[topic release];
	isLoadingMore = NO;
	[self.mTableView reloadData];
	[moreCell spinnerStopAnimating];
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
}

- (void)addAttention:(UIButton *)btn {
	NSMutableArray *array = nil;
	array = [self.dataDic objectForKey:@"footBallData"];

	if (btn.tag < [array count]) {
		NSDictionary *dic = [array objectAtIndex:btn.tag];
		ASIHTTPRequest *request = nil;
		if ([[dic objectForKey:@"isAtt"] isEqualToString:@"0"]) {
			request = [ASIHTTPRequest requestWithURL:[NetURL CBsaveAttention:[[Info getInstance]userId]
																		  attUserId:[dic objectForKey:@"id"]]];
			[btn setImage:UIImageGetImageFromName(@"btn_cancelattention.png") forState:UIControlStateNormal];
			[dic setValue:@"1" forKey:@"isAtt"];
			[request setDidFinishSelector:@selector(addFinish:)];
		}
		else {
			request = [ASIHTTPRequest requestWithURL:[NetURL CBcancelAttention:[[Info getInstance]userId]
																			attUserId:[dic objectForKey:@"id"]]];
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
	NSDictionary *dic = [responseString JSONValue];
	if ([[dic objectForKey:@"result"] isEqualToString:@"succ"]) {		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self LoadData];
	}
	
}
- (void)cancelFinish:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	NSDictionary *dic = [responseString JSONValue];
	if ([[dic objectForKey:@"result"] isEqualToString:@"succ"]) {
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消关注失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self LoadData];
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
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	self.dataDic = dic;
	[dic release];
	
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.navigationItem setLeftBarButtonItem:leftItem];
	
	
	mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain];
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
	[self LoadData];
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return NO;
 }
 */

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
	self.dataDic = nil;
	self.dicData = nil;
	[mTableView release];
	[mRefreshView release];
	//[request cancel];
	//[request release];
    [super dealloc];
}


#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	[self LoadData];
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
	NSMutableArray *array = nil;
	array = [self.dataDic objectForKey:@"footBallData"];
	
	if (indexPath.row ==[array count]) {
		
		CellIdentifier = @"MoreLoadCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		
		if (moreCell == nil) {
			moreCell = cell;
		}
		return cell;
	} else {
		
		NSMutableArray *array = [self.dataDic objectForKey:@"footBallData"];
		if ([[self.dicData objectForKey:@"type"] isEqualToString:@"预测"]) {
			if (indexPath.row ==[array count]) {
				
				CellIdentifier = @"MoreLoadCell";
				
				MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				
				if (cell == nil) {
					cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
					[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
				}
				
				if (moreCell == nil) {
					moreCell = cell;
				}
				
				return cell;
			} else {
				
				CellIdentifier = @"TopicCell";
				
				HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				
				if(cell == nil) {
					
					cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];		 
					[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
				}
				
				YtTopic *status = [array objectAtIndex:indexPath.row];
				
				if (status) {
                    status.tableView = tableView;
                    status.indexPath = indexPath;
					cell.status = status;
					[cell update:tableView];
				}
				return cell;
			}
			
		}
		else if ([[self.dicData objectForKey:@"type"] isEqualToString:@"快讯"]) {
			if (indexPath.row ==[array count]) {
				
				CellIdentifier = @"MoreLoadCell";
				
				MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				
				if (cell == nil) {
					cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
					[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
				}
				
				if (moreCell == nil) {
					moreCell = cell;
				}
				return cell;
			}else {
				
				CellIdentifier = @"NewsCell";
				
				LotteryNewsCell *cell =(LotteryNewsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				
				if(cell == nil) {
					
					cell = [[[LotteryNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];		 
					[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    YtTopic *status = [array objectAtIndex:indexPath.row];
                    [cell LoadData:status];
				}
				return cell;
			}
		}
	
	}
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//推荐，战绩，专家，红人，认证
	NSInteger count = 0;
	count = [[self.dataDic objectForKey:@"footBallData"] count];
	if (count == 0) {
		return 0;
	}
	return count == 0?count:count+1;
	//return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cellHeigth = 0;
	NSMutableArray *array = nil;
	array = [self.dataDic objectForKey:@"footBallData"];
	if (indexPath.row == [array count]) {
		
		cellHeigth = 60.0;
		
	} else {
		if ([[self.dicData objectForKey:@"type"] isEqualToString:@"预测"]) {
			YtTopic *status = [array objectAtIndex:indexPath.row];
			
			cellHeigth = status.cellHeight;
		}
		else {
			cellHeigth = 70.0;
		}

		
	}
	return cellHeigth;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSMutableArray *array = nil;
	array = [self.dataDic objectForKey:@"footBallData"];
	if (indexPath.row < [array count]) {
		DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[array objectAtIndex:indexPath.row]];
        [detailed setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailed animated:YES];
		[detailed release];
		
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
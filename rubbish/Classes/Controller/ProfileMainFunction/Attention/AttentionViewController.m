//
//  AttentionViewController.m
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttentionViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "CheckNetwork.h"
#import "AttenList.h"
#import "ProfileImageCell.h"
#import "ProfileViewController.h"
#import "Info.h"
#import "UserInfo.h"
#import "FolloweeCell.h"
#import "Followee.h"
#import "MyProfileViewController.h"
#import "YtTopic.h"
#import "NSStringExtra.h"
#import "HomeCell.h"


@implementation AttentionViewController

@synthesize mAttenList;
@synthesize userID;
@synthesize request;
@synthesize ishome;
-(id)init
{
    self = [super init];
	if (self) 
    {
		UITabBarItem *attoinItem = [[UITabBarItem alloc] initWithTitle:@"关注" image:UIImageGetImageFromName(@"home_icon_person_atten.png") tag:4];
		self.tabBarItem = attoinItem;
		[attoinItem release];
	}
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
    fristLoading = YES;
	topicLoadedEnd = NO;
    if (ishome) {
        [self viewWillAppear:YES];
    }
    self.CP_navigation.title = @"关注";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];

    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height) style:UITableViewStylePlain];
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y, 390, self.mainView.frame.size.height);
    mTableView.frame = CGRectMake(35, 0, 320, self.mainView.frame.size.height);
    UIImageView *backImage1 = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage1.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage1.userInteractionEnabled = YES;
    backImage1.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:backImage1];
    [backImage1 release];
#endif
    
    [mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    //[mTableView setContentSize:CGSizeMake(320, 480)];
    [self.mainView addSubview:mTableView];
    
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"guanzhu"] intValue]) {
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"guanzhu"];

        
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate showMessage:@"上拉可以加载更多..." HidenSelf:NO];
        
	}
	if (!_refreshHeaderView) 
    {
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, 320, self.mainView.frame.size.height)];
		headerview.delegate = self;
		[mTableView addSubview:headerview];
		_refreshHeaderView =[headerview retain] ;
		
		[headerview release];
		
	}
	
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	[_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (mTableView.contentSize.height-scrollView.contentOffset.y<=360.0)
    {		
		if (!topicLoadedEnd)
        {
			if (attenMoreCell) 
            {
				[attenMoreCell spinnerStartAnimating];
				[self performSelector:@selector(sendMoreattenRequest) withObject:nil afterDelay:0.5];
			}
		}
    }
	[_refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
}

// 在这边 发送  刷新 请求

- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
	fristLoading = YES;
	topicLoadedEnd = NO;
	
    [self reloadTableViewDataSource];
	
	[_refreshHeaderView setState:CBPullRefreshLoading];
    
	mTableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
	
	[self attenListRequest];
	
}


-(void)doneLoadedTableViewData
{
	_reloading = NO;
	[_refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{	
	//  should be calling your tableviews data source model to reload
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

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
	if (!mAttenList) 
    {
		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
	}
}

// 请求 我的关注 列表
-(void)attenListRequest
{
	if ([CheckNetwork isExistenceNetwork]) 
    {
		
		[request clearDelegatesAndCancel];
	
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMyAttenList:self.userID pageNum:@"1" pageSize:@"20" myUserId:[[Info getInstance] userId]]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(attenListDataLoadingBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		
        [request startAsynchronous];
		
		
	}
}

// 接收 关注列表
-(void)attenListDataLoadingBack:(ASIHTTPRequest*)mrequest
{
	NSString *responseString = [mrequest responseString];
	
	//NSLog(@"\n\n...attenList responseString = %@\n\n", responseString);
   
	if(responseString) {
		
	AttenList *list = [[AttenList alloc] initWithparse:responseString];
        if (list) 
        {
            self.mAttenList = list.arrayList;
		}
        [list release];
	}
	
	[mTableView reloadData];
	
	if(attenMoreCell)
		[attenMoreCell setType:MSG_TYPE_LOAD_MORE];
	
	// 模拟 延迟  完成接收
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];


}

// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request
{
	
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:0.5];
	
}




- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger count = [mAttenList count];
	return (!count) ? count:count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return indexPath.row == [mAttenList count] ? 60:65;
    return indexPath.row == [mAttenList count] ? 60:80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier;

	if (indexPath.row == [mAttenList count]) 
    {
		CellIdentifier = @"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (!cell) 
        {
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
        
		if (!attenMoreCell) 
        {
			attenMoreCell = cell;
		}
        
        if (!topicLoadedEnd)
        {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                [self performSelector:@selector(sendMoreattenRequest) withObject:nil afterDelay:.5];
            }
		}
        
		return cell;
	}
    else 
    {
		CellIdentifier = @"Cell";
		
		FolloweeCell *cell =(FolloweeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (!cell) 
        {
			cell = [[[FolloweeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		}

		AttenList *attenlist = [mAttenList objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击效果
		[cell setXianHiden];
		if (attenlist) 
        {
            Followee *followee = [[Followee alloc] init];
            followee.mTag = 7;
            followee.userId = attenlist.userId;
            followee.name = attenlist.nick_name;
			followee.vip = attenlist.vip;
            followee.fansCount = attenlist.mnewTopic;
            followee.imageUrl = attenlist.mid_image;
            followee.is_relation = attenlist.is_relation;
            [cell setFollowee:followee];
			[followee release];
		}
		

		return cell;
	}
	
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
	
	if (indexPath.row == [mAttenList count]) 
    {
        
		MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		if (!topicLoadedEnd) 
        {
			[cell spinnerStartAnimating];
			[self performSelector:@selector(sendMoreattenRequest) withObject:nil afterDelay:.5];			
		}
	}
    else 
    {
        
        AttenList *attenList = [mAttenList objectAtIndex:indexPath.row];
        if (attenList) 
        {
            NSString *himId = attenList.userId;
        NSLog(@"userid = %@", himId);
            if (himId) 
            {
                if ([himId isUserself]) 
                {
                    MyProfileViewController *myProfileVC = [[MyProfileViewController alloc] initWithType:1];
                    [self.navigationController pushViewController:myProfileVC animated:YES];
                    [myProfileVC release];
                }
                else
                {
                    [[Info getInstance] setHimId:himId];
                    
                    ProfileViewController *profileVC =[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil]; 
                    [self.navigationController pushViewController:profileVC animated:YES];
                    [profileVC release];
                }
            }
        }
	}
}

//  请求更多 关注列表 数据
-(void)sendMoreattenRequest
{
	if ([CheckNetwork isExistenceNetwork])
    {
		[request clearDelegatesAndCancel];
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMyAttenList:self.userID 
																		 pageNum:[self loadedCount] 
																		pageSize:@"20" 
																		myUserId:[[Info getInstance] userId]]]];
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(moreAttenListDataBack:)];
		[request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
	}
}

-(void)moreAttenListDataBack:(ASIHTTPRequest*)mrequest
{
	NSString *responseString = [mrequest responseString];
	if (responseString) 
    {
        AttenList *attenList = [[AttenList alloc] initWithparse:responseString];
		
		if ([attenList.arrayList count] >0) 
        {
			if (mAttenList) 
            {
				[self.mAttenList addObjectsFromArray:attenList.arrayList];
			}
		}
        else 
        {
			[attenMoreCell setType:MSG_TYPE_LOAD_NODATA];
			topicLoadedEnd = YES;
            
		}
		
        [attenList release];
		
		[mTableView reloadData];
	}
	
	[attenMoreCell spinnerStopAnimating];
	fristLoading = NO;
    if (attenMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [attenMoreCell spinnerStopAnimating];
        [attenMoreCell setInfoText:@"加载完毕"];
    }
     caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
}

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount
{
	NSString *count;
	
	if (fristLoading) 
    {
		topicLoadCount = 1;
	}
	
	topicLoadCount ++;
	
	NSNumber *num = [[NSNumber alloc] initWithInteger:topicLoadCount];
	
	count = [num stringValue];
	
	[num release];
	
	return count;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidUnload];
	self.userID = nil;
	self.mAttenList =nil;
	self.request =nil;
	
	_refreshHeaderView =nil;
	
	
}


- (void)dealloc 
{
	
	[_refreshHeaderView  release];
	
	[request clearDelegatesAndCancel];
	[request release];

    [mTableView release];
	[mAttenList release];
	[userID release];
    [super dealloc];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
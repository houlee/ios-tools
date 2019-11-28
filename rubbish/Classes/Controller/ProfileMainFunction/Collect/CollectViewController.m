//
//  CollectViewController.m
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectViewController.h"

#import "CheckNetwork.h"

#import "ASIHTTPRequest.h"

#import "NetURL.h"

#import "YtTopic.h"

#import "DataUtils.h"

#import "ColorUtils.h"

#import "Info.h"

#import "NSStringExtra.h"

#import "DetailedViewController.h"
#import "caiboAppDelegate.h"
#import "YtTopic.h"
#import "NSStringExtra.h"
#import "HomeCell.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "SharedMethod.h"
#import "SharedDefine.h"
#import "MobClick.h"
#import "JSON.h"

@implementation CollectViewController

@synthesize collectListarry;

@synthesize request;
@synthesize orignalRequest;
@synthesize likeRequest;

-(id)init{
	
	
	if ((self =[super init])) {
		
		UITabBarItem *collectItem = [[UITabBarItem alloc] initWithTitle:@"收藏" image:UIImageGetImageFromName(@"collect.png") tag:2];
		
		
		self.tabBarItem = collectItem;
		
		[collectItem release];
		
		
	}

	return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeiBoLike:) name:@"refreshWeiBoLike" object:nil];
    
    self.CP_navigation.title = @"我收藏的";
    
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y , 390, self.mainView.frame.size.height);
#else
    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(gotohome) ImageName:nil Size:CGSizeMake(70,30)];

#endif
    
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    [self.CP_navigation setLeftBarButtonItem:(leftItem)];

    
    
	
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = WEIBO_BG_COLOR;
	[self.mainView addSubview:backImage];
    [backImage release];

    mTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    [mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.mainView addSubview:mTableView];
    
    
	fristLoading = YES;
	topicLoadedEnd = NO;
	
	if (_refreshHeaderView == nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width,self.mainView.frame.size.height)];
		headerview.delegate =self;
		[mTableView addSubview:headerview];
		_refreshHeaderView = [headerview retain];
		
		[headerview release];
		
	}
	
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    mTableView.backgroundColor = [UIColor clearColor];
}

- (void)doBack{
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotohome{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
	[_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	
	if (mTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!topicLoadedEnd){
			if (collectmoreCell) {
				[collectmoreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreCollectTopicRequest) withObject:nil afterDelay:.5];
				
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
	
	[self sendCollectRequest];
	
		
	
	
}



-(void)doneLoadedTableViewData{
	
	_reloading = NO;
	[_refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
	
	
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
	
}



//  返回 判断  reload 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view{
	
	
	return _reloading; // should return if data source model is reloading
	
}


// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	if (!collectListarry||[[Info getInstance] isNeedRefreshHome]) 
    {
		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
        [[Info getInstance] setIsNeedRefreshHome:NO];
	}
    
    [mTableView reloadData];
}

// 发送 我的收藏 请求
-(void)sendCollectRequest{
	
	if ([CheckNetwork isExistenceNetwork]) {
		
		[request clearDelegatesAndCancel];
		
		[self setRequest: [ASIHTTPRequest requestWithURL:[NetURL CBlistFavoYtTopicByUserId:[[Info getInstance]userId] pageNum:@"1" pageSize:@"20"]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(collectListDataLoadingBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
		
	}
	

}

// 请求数据 返回
-(void)collectListDataLoadingBack:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];

	if (responseString) {
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if (topic) {
			
			if (collectListarry) 
				
				[collectListarry removeAllObjects];
			
		
			self.collectListarry  = topic.arrayList;
			
		}	
		
		[topic release];
		
	}
	
	[mTableView reloadData];
	
	if (collectmoreCell) 
		
		[collectmoreCell setType:MSG_TYPE_LOAD_MORE];
	
	// 模拟 延迟  完成接收
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
		

}

// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request
{
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:0.5];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	
	NSInteger count = [self.collectListarry count];  
	

	return (!count)?count:count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	
	CGFloat cellHeigth =44 ;
	
    if (indexPath.row ==[collectListarry count]) {
		
		cellHeigth = 60.0;
		
	}else {
		
		YtTopic *pic = [collectListarry objectAtIndex:indexPath.row];
		
		if (pic) {
			
			cellHeigth  = pic.cellHeight;
			
		}
	}
	
	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
        mTableView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        mTableView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
	static NSString *CellIdentifier;
	
	if (indexPath.row == [collectListarry count]) {
		
		CellIdentifier = @"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell==nil) {
			
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			
		}
		
		if (collectmoreCell==nil) {
			
			collectmoreCell = cell;
			
		}
        
        if (!topicLoadedEnd) {
			
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                
                [self performSelector:@selector(sendMoreCollectTopicRequest) withObject:nil afterDelay:.5];
            }
			
		}
		
		return cell;
		
	}else {
		
		CellIdentifier = @"tiwtterCell";
		
		HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			
			cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		YtTopic *topic = [collectListarry objectAtIndex:indexPath.row];
		
		if (topic) {
            topic.tableView = tableView;
            topic.indexPath = indexPath;
            cell.status = topic;
            [cell update:tableView];
		}
        cell.homeCellDelegate = self;
		return cell;
		
	}
	
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row ==[collectListarry count]) {
		
		MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		
		if (!topicLoadedEnd) {
			
			[cell spinnerStartAnimating];
			
			[self performSelector:@selector(sendMoreCollectTopicRequest) withObject:nil afterDelay:.5];			
		}
		
	}else {
		
		YtTopic *ytpic = [collectListarry objectAtIndex:indexPath.row];
		ytpic.isCc = @"1";
        DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:ytpic];
		
        [detailed setHidesBottomBarWhenPushed:YES];
		
        [self.navigationController pushViewController:detailed animated:YES];
		
		[detailed release];
		
	}
}


// 更多  我的 收藏 列表 请求 
-(void)sendMoreCollectTopicRequest{
	
	if ([CheckNetwork isExistenceNetwork]) {
		
		[request clearDelegatesAndCancel];
		
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistFavoYtTopicByUserId:[[Info getInstance]userId] pageNum:[self loadedCount] pageSize:@"20"]]] ;
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(moreCollectTopictableViewDataBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
		
		
		
	}

}

//  更多 数据 返回
-(void)moreCollectTopictableViewDataBack:(ASIHTTPRequest*)mrequest

{
	
	NSString *responseString = [mrequest responseString];
	
	if (responseString) {
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (collectListarry) {
				
				[collectListarry addObjectsFromArray:topic.arrayList];
				
			}
			
			
		}else {
			
			[collectmoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			topicLoadedEnd = YES;
          
			
		}
        
		
		[topic release];
		
		[mTableView reloadData];
		
	}
	
	[collectmoreCell spinnerStopAnimating];
	
	fristLoading = NO;
    if (collectmoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [collectmoreCell spinnerStopAnimating];
        [collectmoreCell setInfoText:@"加载完毕"];
    }

}


// 计算 点击 “更多 ”次数
-(NSString*)loadedCount{

	NSString *count;
	
	if (fristLoading) {
		
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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidUnload];
	self.collectListarry = nil;
	
	self.request =nil;
	
	_refreshHeaderView =nil;
}


- (void)dealloc {
	
	[_refreshHeaderView release];
	[request clearDelegatesAndCancel];
	[request release];
	[collectListarry release];
    [mTableView release];
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

-(void)likeRequestDidFinishSelector:(ASIHTTPRequest *)lRequest
{
    NSString * requestStr = [lRequest responseString];
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
    HomeCell * homeCell = (HomeCell *)[mTableView cellForRowAtIndexPath:ytTopic.indexPath];
    
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
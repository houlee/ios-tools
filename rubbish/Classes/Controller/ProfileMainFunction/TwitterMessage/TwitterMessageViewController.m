//
//  TwitterMessageViewController.m
//  caibo
//
//  Created by jacob on 11-6-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterMessageViewController.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "YtTopic.h"
#import "DataUtils.h"
#import "HomeCell.h"
#import "ColorUtils.h"
#import "DetailedViewController.h"
#import "NSStringExtra.h"
#import "ProfileViewController.h"
#import "Info.h"
#import "MyProfileViewController.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"
#import "SharedDefine.h"
#import "SharedMethod.h"
#import "JSON.h"

@implementation TwitterMessageViewController

@synthesize messageListArray;
@synthesize userID;
@synthesize xitongtz;
@synthesize request;
@synthesize orignalRequest;
@synthesize likeRequest;

-(id)init{
	
		
	if ((self=[super init])) {
		
		UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"微博" image:UIImageGetImageFromName(@"icon_person_blog.png") tag:0];
		
		self.tabBarItem = messageItem;
		
		[messageItem release];
		
			
	}

	return self;

}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self viewWillAppear:YES];
    //self.CP_navigation.title = @"我发表的";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeiBoLike:) name:@"refreshWeiBoLike" object:nil];
    
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y , 390, self.mainView.frame.size.height);
#endif
    self.CP_navigation.title = @"微博";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
#ifndef isCaiPiaoForIPad
    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(gotohome) ImageName:nil Size:CGSizeMake(70,30)];
#endif
	fristLoading = YES;
	topicLoadedEnd = NO;
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = WEIBO_BG_COLOR;
    //	mTableView.backgroundView = backImage;
    [self.mainView addSubview:backImage];
    [backImage release];

    mTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    [mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.delegate = self;
    mTableView.dataSource = self;
//    [mTableView setContentSize:CGSizeMake(320, 480)];
    [self.mainView addSubview:mTableView];
    
   
		
	if (_refreshHeaderView == nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        
		headerview.delegate =self;
		
		[mTableView addSubview:headerview];
		
		_refreshHeaderView =[headerview retain];
		
		[headerview release];
		
	}
	
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
    if (![[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] -1] isKindOfClass:[CPViewController class]]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
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
			if (messageMoreCell) {
				[messageMoreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
				
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
	
	[self listYtTopicByUserIdRequest];
	
		
	
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
	
	if (!messageListArray||[[Info getInstance] isNeedRefreshHome]) 
    {
		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
        [[Info getInstance] setIsNeedRefreshHome:NO];
	}
    
//    [mTableView reloadData];
}


// 发送 2。7 用户发帖 列表请求
-(void)listYtTopicByUserIdRequest{
	
	if ([CheckNetwork isExistenceNetwork]) {
		
		[request clearDelegatesAndCancel];
        
        
        NSString * sueridstr;
        if (xitongtz) {
            sueridstr = @"549675";
        }else{
            sueridstr = self.userID;
        }
		
	    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByUserId:sueridstr pageNum:@"1" pageSize:@"20"]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(messageListDataLoadingBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		
        [request startAsynchronous];
		
	}//atMeListArry

}

#pragma mark messageRequestBack
//  请求 “微博 ”数据 返回
-(void)messageListDataLoadingBack:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];	
	if (responseString) {
	
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if (topic) {
			
			if(messageListArray)
				
				[messageListArray removeAllObjects];
			
			self.messageListArray = topic.arrayList;
			
		}
		
		[topic release];
	}
	
	[mTableView reloadData];
	
	if(messageMoreCell)
		[messageMoreCell setType:MSG_TYPE_LOAD_MORE];
	
	// 模拟 延迟 三秒  完成接收
//	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
    [self doneLoadedTableViewData];

	
	
}


// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request
{
//	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
    [self doneLoadedTableViewData];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
	NSInteger count = [self.messageListArray count];
	
    return (!count)?count:count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cellHeigth = 0;
	
    if (indexPath.row ==[messageListArray count]) {
		cellHeigth = 60.0;	
	} else {
		
		YtTopic *pic = [messageListArray objectAtIndex:indexPath.row];
		
		if (pic) {
			cellHeigth  = pic.cellHeight;
		}
	}
	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
//        mTableView.backgroundColor = [UIColor clearColor];
//        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
//        mTableView.backgroundColor = [UIColor clearColor];
//        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
	
	 static NSString *CellIdentifier;
	
	if (indexPath.row == [messageListArray count]) {
		
		CellIdentifier = @"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell==nil) {
			
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			
		}
        
        if (!topicLoadedEnd) {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                [self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
            }
			
		}
		
		if (messageMoreCell==nil) {
			
			messageMoreCell = cell;
			
		}
		
		return cell;
		
	} else {
		
		CellIdentifier = @"tiwtterCell";
		
		HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		
		if (cell == nil) {
			
			cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.xian.frame = CGRectMake(50, cell.frame.size.height - 4, 300, 2);
		
		YtTopic *topic = [messageListArray objectAtIndex:indexPath.row];
		
		if (topic) {
            
            topic.indexPath = indexPath;
            cell.status = topic;
            topic.tableView = tableView;
            cell.status.indexPath = indexPath;
            [cell update:tableView];
			
		}
        cell.homeCellDelegate = self;
		return cell;
		
	}

	return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row ==[messageListArray count]) {
		MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		if (!topicLoadedEnd) {
			[cell spinnerStartAnimating];
			[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];			
		}
	}else {
		
		YtTopic *topic = [messageListArray objectAtIndex:indexPath.row];
		
		DetailedViewController *detailedVC = [[DetailedViewController alloc] initWithMessage:topic];
		[self.navigationController pushViewController:detailedVC animated:YES];
        [detailedVC release];
	}
}


#pragma mark MoreRequest

-(void)sendMoreTopicRequest
{
	if ([CheckNetwork isExistenceNetwork]) {
		
		[request clearDelegatesAndCancel];
        NSString * sueridstr;
        if (xitongtz) {
            sueridstr = @"549675";
        }else{
            sueridstr = self.userID;
        }
		
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByUserId:sueridstr pageNum:[self loadedCount] pageSize:@"20"]]] ;
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(moreTopictableViewDataBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
        
		[request startAsynchronous];
	}
}


// "更多 "数据接收
-(void)moreTopictableViewDataBack:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	
	if (responseString) {
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (messageListArray) {
				
				[messageListArray addObjectsFromArray:topic.arrayList];
				
			}
            
			[mTableView reloadData];
			
		}else {
			
			[messageMoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			topicLoadedEnd = YES;
           
		}
		
		[topic release];
		
//		[mTableView reloadData];
		
	}
	
	[messageMoreCell spinnerStopAnimating];
	
	fristLoading = NO;
    if (messageMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [messageMoreCell spinnerStopAnimating];
        [messageMoreCell setInfoText:@"加载完毕"];
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
	
	self.messageListArray = nil;
	
	self.request =nil;
	
	self.request =nil;
	
	self.userID =nil;
	
	_refreshHeaderView =nil;
}


- (void)dealloc {
	
	[_refreshHeaderView release];
	[request clearDelegatesAndCancel];
	[request release];
	[userID release];
	[messageListArray release];
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

-(void)likeRequestDidFinishSelector:(ASIHTTPRequest *)_request
{
    NSString * requestStr = [_request responseString];
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
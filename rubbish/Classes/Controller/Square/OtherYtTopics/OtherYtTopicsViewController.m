//
//  OtherYtTopicsViewController.m
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OtherYtTopicsViewController.h"
#import "ASIHTTPRequest.h"
#import "CheckNetwork.h"
#import "NetURL.h"
#import "DataUtils.h"
#import "ColorUtils.h"
#import "YtTopic.h"
#import "DetailedViewController.h"
#import "Info.h"
#import "NSStringExtra.h"
#import "RegisterViewController.h"
#import "LotteryPreferenceViewController.h"
#import "LoginViewController.h"
#import "HomeCell.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "MoreLoadCell.h"
#import "YDDebugTool.h"
#import "caiboAppDelegate.h"



@implementation OtherYtTopicsViewController

@synthesize topictype;

@synthesize otherTopicListarry;

@synthesize beforeLogin;

@synthesize request;


//YtTopic *status;

-(id)initWithTopicType:(NSString*)topicType{
	
	if ((self = [super init])) 
    {
		
		if([topicType isEqualToString:@"zxdt"]){
			
		self.navigationItem.title = @"最新动态";
		
		
		}else if ([topicType isEqualToString:@"zxkj"]) {
			
			self.navigationItem.title = @"最新开奖";
			
		}else if ([topicType isEqualToString:@"gfzz"]) {
			
			self.navigationItem.title = @"官方组织";
			
		}else if ([topicType isEqualToString:@"mrcb"]) {
			
			self.navigationItem.title = @"名人彩博";
			
		}else if ([topicType isEqualToString:@"zhuanjia"]) {
			
			self.navigationItem.title = @"猜你喜欢";
			
		}else if ([topicType isEqualToString:@"dlt"]) {
			
			self.navigationItem.title = @"大乐透预测";
			
		}else if ([topicType isEqualToString:@"ssq"]) {
			
			self.navigationItem.title = @"双色球预测";
			
		}else if ([topicType isEqualToString:@"3d"]) {
			
			self.navigationItem.title = @"3D预测";
			
		}else if ([topicType isEqualToString:@"p3"]) {
			
			self.navigationItem.title = @"排三预测";
			
		}else if ([topicType isEqualToString:@"jc"]) {
			
			self.navigationItem.title = @"竞彩预测";
			
		}else if ([topicType isEqualToString:@"zucai"]) {
			
			self.navigationItem.title = @"足彩预测";
			
		}else if ([topicType isEqualToString:@"casualLook"]) {
			
			self.navigationItem.title = @"随便看看";
		}else {
			
			self.navigationItem.title = topicType;
			
		}

		
		self.topictype = topicType;
		
		beforeLogin = NO;
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	fristLoading = YES;
	
	topicLoadedEnd = NO;
	
	if (_refreshHeaderView == nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
		headerview.delegate =self;
		
		[self.view addSubview:headerview];
		
 
		_refreshHeaderView = [headerview retain];
 
		
		
		[headerview release];
        
        //[[self.view subviews] 
		
	}
	
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];
	[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
	// 自定义 返回 按钮
	UIImage *image = UIImageGetImageFromName(@"btn_arrowL_bg.png");
	
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
	backButton.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	
	[backButton setBackgroundImage:image forState:UIControlStateNormal];
	
	[backButton setTitle:@"返 回" forState:UIControlStateNormal];
	
	backButton.titleLabel.font = [UIFont systemFontOfSize:14];
	
	backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 5);
	
	[backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];   
	
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];   
	temporaryBarButtonItem.style = UIBarButtonItemStylePlain;   
	self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
	
	[temporaryBarButtonItem release];
}


-(void)backAction{
    
    [request clearDelegatesAndCancel];
	
	[self.navigationController popViewControllerAnimated:YES];
		
}



#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
	[_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.tableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!topicLoadedEnd){
			if (moreCell) {
				[moreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
				
			}
		}
	}	
	
	[_refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

// 在这边 发送  刷新 请求

- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
	fristLoading = YES;
	topicLoadCount = NO;
	
	[_refreshHeaderView setState:CBPullRefreshLoading];
    
	self.tableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
	
	[self sendOtherYtRequest];
	
	_reloading = YES;
	
	// 模拟 延迟 三秒  完成接收
	//[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:1.0];	
}



-(void)doneLoadedTableViewData{
	
	_reloading = NO;
	[_refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
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




- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
	
	if (!otherTopicListarry||[[Info getInstance] isNeedRefreshHome]) 
    {
		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
        [[Info getInstance] setIsNeedRefreshHome:NO];
	}
    
    [self.tableView reloadData];
}


-(void)sendOtherYtRequest{
	
    YD_FUNNAME;
	//ASIHTTPRequest  *request;
	
//	if ([CheckNetwork isExistenceNetwork]) {
//		
//		[request clearDelegatesAndCancel];
//		
//		if ([self.topictype isEqualToString:KNEWDYNAMIC]) {// 最新动态
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KNEWDYNAMIC userId:[[Info getInstance]userId]]]] ;		
//            
//		}else if ([self.topictype isEqualToString:KNEWLOTTERYMESSAGE]) {// 最新开奖
//		     
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KNEWLOTTERYMESSAGE userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KOFFICIA]) {// 官方组织
//			
//		    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KOFFICIA userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KBLOG]) {// 名人彩博
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KBLOG userId:[[Info getInstance]userId]]]] ;
//
//		}else if ([self.topictype isEqualToString:KLOTCOM]) {// 大乐透推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KLOTCOM userId:[[Info getInstance]userId]]]] ;
//		
//		}else if ([self.topictype isEqualToString:KCOLBALL]) {// 双色球推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KCOLBALL userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KTHRCOM]) {// 3D推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KTHRCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KP3COM]) {// 排三推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KP3COM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KCOMCOM]) {// 竞彩推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KCOMCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KFOOTCOM]) {// 足彩推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:@"1" pageSize:@"20" para:KFOOTCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KEXPERTSSAY]) {// 猜你喜欢
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByZhuanjia:@"1" pageSize:@"20" userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KCASUALLOOK]) {
//			
//			// 需要  传入 userid
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:@"1" pageSize:@"20" userId:[[Info getInstance]userId] istoppic:@"0"] ]] ;
//			
//		}else {//  发送 话题下 发帖 请求
//			
//			
//			NSLog(@"***************************************");
//			// 需要  传入 userid
//			//request = [ASIHTTPRequest requestWithURL:[NetURL CBgetThemetYtTipic:@"103043" themeName:self.yttheme.name pageNum:@"1" pageSize:@"20"]];
//			
//		}
//
//		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
//		[request setDelegate:self];
//		[request setDidFinishSelector:@selector(doneLoadingTableViewData:)];
//		[request setNumberOfTimesToRetryOnTimeout:2];
//		
//        YD_FUNNAME;
//		// 异步获取
//		[request startAsynchronous];
//       
//	}
//
}



// 请求接收
-(void)doneLoadingTableViewData:(ASIHTTPRequest*)mrequest
{
 
	NSString *responseString = [mrequest responseString];
	if (responseString) 
    {
        YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		self.otherTopicListarry = topic.arrayList;
		[topic release];
	}
	[self.tableView reloadData];
	
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];	
}

// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request {
  [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:0.5];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	NSInteger count = [self.otherTopicListarry count];
	
    return (!count)?count:count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat cellHeigth ;
	
	if (indexPath.row == [self.otherTopicListarry count]) {
		
		cellHeigth = 60.0;
		
	} else {
		
		YtTopic *status = [self.otherTopicListarry objectAtIndex:indexPath.row];
		
		cellHeigth = status.cellHeight;
		
	}
	
	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
        self.tableView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.tableView.backgroundColor = [UIColor cellBackgroundColor];
        _refreshHeaderView.backgroundColor = [UIColor cellBackgroundColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
	static NSString *CellIdentifier;
	
	
	if (indexPath.row ==[otherTopicListarry count]) {
		
		CellIdentifier = @"MoewLoadCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
        
        if (!topicLoadedEnd) {
			
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                
                [self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
            }
			
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
		}
		YtTopic *status = [otherTopicListarry objectAtIndex:indexPath.row];
		if (status) {
            status.tableView = tableView;
            status.indexPath = indexPath;
            cell.status = status;
            [cell update:tableView];
		}
		return cell;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row == [otherTopicListarry count]) {
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		
		if (!topicLoadedEnd) {
			
			[cell spinnerStartAnimating];
			
			[self performSelector:@selector(sendMoreTopicRequest) withObject:nil afterDelay:.5];
			
		}
	} else {// 响应列表
		
		// 登录前 
		if(beforeLogin){
			
			UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"注册",@"登录",nil];
			
			[sheet showInView:self.view];
			
			[sheet release];
			
		
		} else {
			
			YtTopic *status = [self.otherTopicListarry objectAtIndex:indexPath.row];
			
			if (status) {
				DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:status];
				[detailed setHidesBottomBarWhenPushed:YES];
				[self.navigationController pushViewController:detailed animated:YES];
				[detailed release];
			}
		}
	}
}


-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	//  跳转到注册界面
	if (buttonIndex==0) {
		LotteryPreferenceViewController *lot =[[LotteryPreferenceViewController alloc] init];
		[lot setHidesBottomBarWhenPushed:YES];
		lot.title =@"步骤1：偏好设置";
		[self.navigationController pushViewController:lot animated:YES];
		[lot release];
//		RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//		[self.navigationController pushViewController:registerViewController animated:YES];
//		[registerViewController release];
	} else if (buttonIndex==1) {// 返回到 登录界面
		LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		[self.navigationController pushViewController:login animated:YES];
		[login release];	
	}
}

-(void)sendMoreTopicRequest{
	[request clearDelegatesAndCancel];
    
//	if ([CheckNetwork isExistenceNetwork]) {	
//		if ([self.topictype isEqualToString:KNEWDYNAMIC]) {// 最新动态
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KNEWDYNAMIC userId:[[Info getInstance]userId]]]] ;			
//			
//		} else if ([self.topictype isEqualToString:KNEWLOTTERYMESSAGE]) {// 最新开奖
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KNEWLOTTERYMESSAGE userId:[[Info getInstance]userId]]]] ;
//			
//		} else if ([self.topictype isEqualToString:KOFFICIA]) {// 官方组织
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KOFFICIA userId:[[Info getInstance]userId]]]] ;
//			
//		} else if ([self.topictype isEqualToString:KBLOG]) {// 名人彩博
//			
//			 [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KBLOG userId:[[Info getInstance]userId]]]];
//			
//		}else if ([self.topictype isEqualToString:KLOTCOM]) {// 大乐透推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KLOTCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KCOLBALL]) {// 双色球推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KCOLBALL userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KTHRCOM]) {// 3D推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KTHRCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KP3COM]) {// 排三推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KP3COM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KCOMCOM]) {// 竞彩推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KCOMCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KFOOTCOM]) {// 足彩推荐
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByOther:[self loadedCount] pageSize:@"20" para:KFOOTCOM userId:[[Info getInstance]userId]]]] ;
//			
//		}else if ([self.topictype isEqualToString:KEXPERTSSAY]) {// 专家说
//			
//			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByZhuanjia:[self loadedCount] pageSize:@"20" userId:[[Info getInstance]userId]]]] ;
//			
//		} else if ([self.topictype isEqualToString:KCASUALLOOK]) {
//			
//			[self  setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopic:[self loadedCount] pageSize:@"20" userId:[[Info getInstance]userId]istoppic:@"0"]]];
//			
//		} else {
//		}
//
//		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
//		[request setDelegate:self];
//		[request setDidFinishSelector:@selector(moreTopicDataBack:)];
//		[request setNumberOfTimesToRetryOnTimeout:2];
//		// 异步获取
//		[request startAsynchronous];
//	}
}


-(void)moreTopicDataBack:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	
	if (responseString) {
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (otherTopicListarry) {
				
				[otherTopicListarry addObjectsFromArray:topic.arrayList];
				
			}
			
			
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
           
			topicLoadedEnd = YES;
			
		}
		
		[topic release];
		
		[self.tableView reloadData];
		
	}
	
	[moreCell spinnerStopAnimating];
	
	fristLoading = NO;
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	_refreshHeaderView = nil;
	
}


- (void)dealloc {
	moreCell=nil;
	[_refreshHeaderView release];
	[request clearDelegatesAndCancel];
	[request release];
	[topictype release];
	[otherTopicListarry release];
    [super dealloc];
}


@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  FansViewController.m
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FansViewController.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "FansList.h"
#import "ProfileImageCell.h"
#import "ProfileViewController.h"
#import "Info.h"
#import "MyProfileViewController.h"
#import "FolloweeCell.h"
#import "Followee.h"
#import "YtTopic.h"
#import "NSStringExtra.h"
#import "JSON.h"
#import "HisSchemeViewController.h"
#import "ProfileTabBarController.h"
#import "NewPostViewController.h"
#import "MyLottoryViewController.h"
#import "TwitterMessageViewController.h"
#import "CP_TabBarViewController.h"
#import "SendMicroblogViewController.h"


@implementation FansViewController

@synthesize isPK;
@synthesize fansListArray;
@synthesize userID;
@synthesize keyWord;
@synthesize request;
@synthesize mController;
@synthesize cpthree;
@synthesize userid;
@synthesize userName;
@synthesize hemai;
@synthesize rightbut;
@synthesize titlebool;
@synthesize titlestring;
#pragma mark -
#pragma mark View lifecycle





-(id)init{
	
	if ((self=[super init])) 
    {
		UITabBarItem *fansItem = [[UITabBarItem alloc] initWithTitle:@"粉丝" image:UIImageGetImageFromName(@"icon_person_fans.png") tag:3];
		self.tabBarItem = fansItem;
		[fansItem release];
        isseachView =NO;
	}

	return self;
}

- (id)initWithKeywords:(NSString *)keywords cpthree:(BOOL)_cphtree{
    if ((self=[super init])) 
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
		isPK =NO;
        cpthree = _cphtree;
        hemai = NO;
		self.keyWord = keywords;
		self.CP_navigation.title = keywords;
        self.mainView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        
        isseachView = YES;
        
        [self reloadBackBtton];
	}
    
	return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

// 搜索 微博  详细 界面 初始化
-(id)initWithKeywords:(NSString*)keywords
{
	if ((self=[super init])) 
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
		isPK =NO;
    cpthree = NO;
    hemai = NO;
		self.keyWord = keywords;
		self.CP_navigation.title = keywords;
        //self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        isseachView = YES;
        
        [self reloadBackBtton];
	}

	return self;
}

-(void)reloadBackBtton
{    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(backAction)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
}

-(void)backAction
{	
    
	[self.navigationController popViewControllerAnimated:YES];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
    
}
// 跳会到首页
-(void)homeAction
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    if (titlebool) {
        self.CP_navigation.title = titlestring;
    }else{
        self.CP_navigation.title = @"粉丝";
    }
	
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];

    if (rightbut) {
//        UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(homeAction)];
//        [self.CP_navigation setRightBarButtonItem:rightItem];
#ifndef isCaiPiaoForIPad
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 60, 44)];
        [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
        //    [btn setImage:UIImageGetImageFromName(@"IZL-960-1.png") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
#endif
    }

	fristLoading = YES;
	topicLoadedEnd = NO;
	
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height) style:UITableViewStylePlain];
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, self.mainView.frame.origin.y, 768, self.mainView.frame.size.height);
    mTableView.frame = CGRectMake(35, 0, 320, self.mainView.frame.size.height);
    
    UIImageView *backImage1 = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage1.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage1.userInteractionEnabled = YES;
    backImage1.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:backImage1];
    [backImage1 release];
#endif
    [mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];

    //[mTableView setContentSize:CGSizeMake(320, 480)];
    [self.mainView addSubview:mTableView];


    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"fensi"] intValue]) {
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"fensi"];

        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate showMessage:@"上拉可以加载更多..." HidenSelf:NO];
        
	}

    
    
	if (!_refreshHeaderView)
    {
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, 320, self.mainView.frame.size.height)];
		headerview.delegate = self;
		[mTableView addSubview:headerview];
		_refreshHeaderView =[headerview retain];
		[headerview release];
		
	}
	// 初始化时间  如果失败，返回 “未更新”
	[_refreshHeaderView refreshLastUpdatedDate];
    
    [self fansListRequest];
//
//    if (!fansListArray) {
//		
//		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
//		
//	}
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];   
}
#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
	[_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (mTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!topicLoadedEnd){
			if (fansMoreCell) {
				[fansMoreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];
				
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
	
	[self fansListRequest];
	
	// 模拟 延迟 三秒  完成接收
	
	
	
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


- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
	
	if (!fansListArray) {
		
		[self CBRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
		
	}
	
	
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
}

// 发送 2.7 用户发帖 列表请求
-(void)fansListRequest{
	
	if ([CheckNetwork isExistenceNetwork]) {
		
		[request clearDelegatesAndCancel];
		
		if(self.keyWord&&isseachView)
        {
		if (isPK) {
            if ([self.keyWord isContainSign]) {
                [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
                [[caiboAppDelegate getAppDelegate] showMessage:@"搜索用户名包含特殊字符"];
                return;
            }
			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL pkSearchSearchKey:self.keyWord]]];
		} else if (cpthree){
            if ([self.keyWord isContainSign]) {
                [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
                [[caiboAppDelegate getAppDelegate] showMessage:@"搜索用户名包含特殊字符"];
                return;
            }
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL cpthreeSearchSearchKey:self.keyWord]]];
            
        }else if(hemai){
        
            //合买
            
        }else {
				[self  setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsearchUserList:self.keyWord pageNum:@"1" pageSize:@"20"]]];		
			}
		
		}else {
			if (isPK) {
                if ([self.keyWord isContainSign]) {
                    [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
                    [[caiboAppDelegate getAppDelegate] showMessage:@"搜索用户名包含特殊字符"];
                    return;
                }
				[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL pkSearchSearchKey:self.keyWord]]];
			}
            else if (cpthree){
                if ([self.keyWord isContainSign]) {
                    [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];	
                    [[caiboAppDelegate getAppDelegate] showMessage:@"搜索用户名包含特殊字符"];
                    return;
                }
                
                [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL cpthreeSearchSearchKey:self.keyWord]]];
                
                
                
            }else if(hemai){
            //合买
            }else{
					[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMyFansList:self.userID pageNum:@"1" pageSize:@"20" myUserId:[[Info getInstance] userId]]]];
			}
			
			
		}
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(fansListDataLoadingBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		
        [request startAsynchronous];
		
	}
	
}


-(void)fansListDataLoadingBack:(ASIHTTPRequest*)mrequest

{
	NSString *responseString = [mrequest responseString];
	NSLog(@"responseString = %@", responseString);
	if (responseString) {
		
		if (isPK) {
			NSDictionary *dic = [responseString JSONValue];
			if ([[dic objectForKey:@"data"] count]) {
				NSDictionary *dic2 = [[dic objectForKey:@"data"] objectAtIndex:0];
				FansList *fansList = [[[FansList alloc] init]autorelease];
				fansList.nick_name = [dic2 objectForKey:@"nickName"];
				fansList.userId = [dic2 objectForKey:@"userId"];
				fansList.user_name = [dic2 objectForKey:@"userName"];
				fansList.mid_image = [dic2 objectForKey:@"midImage"];
                //fansList.is_relation = [dic objectForKey:@"is_relation"];
				if (fansListArray) 
				{
					[fansListArray removeAllObjects];
				}
				self.fansListArray  = [NSMutableArray arrayWithObject:fansList];
                [self.request clearDelegatesAndCancel];
                [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithNickName:fansList.nick_name]]];
		
                [request setDefaultResponseEncoding:NSUTF8StringEncoding];
                [request setDelegate:self];
                
                [request setDidFinishSelector:@selector(UserinfoDataLoadingBack:)];
                
                [request setNumberOfTimesToRetryOnTimeout:2];
                
                [request startAsynchronous];
			}
            
		} else if (cpthree){
//            NSDictionary * dict = [responseString JSONValue];
//            NSLog(@"dict = %@", dict);
//       
                
//                NSDictionary * diction = [[dict objectForKey:@"data" ] objectAtIndex:0];
//                FansList * fansList = [[[FansList alloc] init] autorelease];
//                fansList.nick_name = [diction objectForKey:@"nickName"];
//				fansList.userId = [diction objectForKey:@"userId"];
//				//fansList.user_name = [diction objectForKey:@"userName"];
//				fansList.mid_image = [diction objectForKey:@"midImage"]; 
                
                NSDictionary *dic = [responseString JSONValue];
            NSLog(@"dic  = %@", dic);
                if ([[dic objectForKey:@"data"] count]) {
                    NSDictionary *dic2 = [[dic objectForKey:@"data"] objectAtIndex:0];
                    FansList *fansList = [[[FansList alloc] init]autorelease];
                    fansList.nick_name = [dic2 objectForKey:@"nickName"];
                    fansList.userId = [dic2 objectForKey:@"userId"];
                    
                    fansList.user_name = [dic2 objectForKey:@"userName"];
                    NSLog(@"username = %@", fansList.user_name);
                    fansList.mid_image = [dic2 objectForKey:@"midImage"];
                    userid  = fansList.userId;
                    userName = fansList.nick_name;
                    useruname = fansList.user_name;
                    fansList.is_relation = [dic objectForKey:@"is_relation"];
                    if (fansListArray) 
                        {
                        [fansListArray removeAllObjects];
                        }
                    self.fansListArray  = [NSMutableArray arrayWithObject:fansList];
                    
                   
                    [self.request clearDelegatesAndCancel];
                    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:fansList.userId]]];
                    
                    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [request setDelegate:self];
                    
                    [request setDidFinishSelector:@selector(UserinfoDataLoadingBack:)];
                    
                    [request setNumberOfTimesToRetryOnTimeout:2];
                    
                    [request startAsynchronous];
                        
                    
                }else{
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"无结果" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [aler show];
                    [aler release];
                }
        }else if(hemai){
        //合买
        
        
        }else{
			FansList  *fanslist = [[FansList alloc] initWithParse:responseString];
			
			if (fanslist) {
				
				if (fansListArray) 
					
					[fansListArray removeAllObjects];
				
				self.fansListArray = fanslist.arrayList;
				
				
			}
			
			[fanslist release];
		}
		
	}
	
	[mTableView reloadData];
	
	if(fansMoreCell)
		[fansMoreCell setType:MSG_TYPE_LOAD_MORE];
	
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];	
	

}

-(void)UserinfoDataLoadingBack:(ASIHTTPRequest*)mrequest {
    NSString *responseStr = [request responseString];
    NSDictionary * di = [responseStr JSONValue];
    //   NSString * uid = [di objectForKey:@"id"];
    NSLog(@"request = %@", di);
    
    if (![responseStr isEqualToString:@"fail"]) 
    {
        if ([fansListArray count]) {
            FansList *fanslist = [fansListArray objectAtIndex:0];
            fanslist.is_relation = [NSString stringWithFormat:@"%d",[[di objectForKey:@"isAtt"] intValue]];
            [mTableView reloadData];
        }
        
        
        
    }
}

// 请求失败 时候 延迟0.5 秒 隐藏刷新 控件
- (void)requestFailed:(ASIHTTPRequest *)request
{
	
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:.5];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
	NSInteger count = [self.fansListArray count];
	if (isPK) {
		return count == 0?0:1;
	}
    if (cpthree) {
        return count == 0?0:1;
    }
    if (hemai) {
        return count = 0?0:1;
    }
    if (count == 1) {
        return  1;
    }
    return count == 0?count:count+1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	
	CGFloat cellHeigth ;
	
    if (indexPath.row==[fansListArray count]) {
		
		cellHeigth = 60.0;
		
	}else {
		
//		cellHeigth = 65.0;
        cellHeigth = 80.0;
		
	}
	
	return cellHeigth;    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier;
	
	if (indexPath.row == [fansListArray count]) {
		
		CellIdentifier = @"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
		}
        
		if (!topicLoadedEnd)
        {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                [self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];
            }
			
		}
        
		if (fansMoreCell==nil) 
			
			fansMoreCell =cell;
			
	
		return cell;
		
	}else {
		
	  CellIdentifier= @"fansCell";
		
		FolloweeCell *cell = (FolloweeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			cell = [[[FolloweeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}

		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setXianHiden];
		FansList *fanslist = [fansListArray objectAtIndex:indexPath.row];
		
		if (fanslist) {
            Followee *followee = [[Followee alloc] init];
            followee.mTag = 7;
            followee.userId = fanslist.userId;
            followee.name = fanslist.nick_name;
			followee.vip = fanslist.vip;
            followee.fansCount = fanslist.mnewTopic;
            followee.imageUrl = fanslist.mid_image;
            followee.is_relation = fanslist.is_relation;
            NSLog(@"%@",followee.is_relation);
            [cell setFollowee:followee];
			[followee release];
		}
		
		return cell;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 

{
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row ==[fansListArray count]) 
    {
		MoreLoadCell *cell =(MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		if (!topicLoadedEnd) 
        {
			[cell spinnerStartAnimating];
			[self performSelector:@selector(sendMoreFansRequest) withObject:nil afterDelay:.5];			
		}
	}
    else 
    {
		FansList *fanslist = [fansListArray objectAtIndex:indexPath.row];
    
        if (cpthree) {
            
            
            UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"他的彩票", @"他的合买", nil];
            [actionSheet showInView:self.mainView];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
            }
            [actionSheet release];
            
            return;
        }
    
    if (hemai) {//合买
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"他的彩票", @"他的合买", nil];
        [actionSheet showInView:self.mainView];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
        }
        [actionSheet release];
        
        return;

    }
    
        if (isPK) {
			HisSchemeViewController * hsvc = [[HisSchemeViewController alloc] init];
			hsvc.userId = fanslist.userId;
			hsvc.title = [NSString stringWithFormat:@"%@的投注记录",fanslist.nick_name];
			[self.navigationController pushViewController:hsvc animated:YES];
			[hsvc release];
			return;
		}
        if (mController != nil && [mController respondsToSelector:@selector(friendsViewDidSelectFriend:)]) {
            NSMutableString *textBuffer = [[NSMutableString alloc] init];
            [textBuffer appendString:@"@"];
            [textBuffer appendString:fanslist.nick_name];
            [textBuffer appendString:@" "];
            [mController performSelector:@selector(friendsViewDidSelectFriend:) withObject:textBuffer];
            [textBuffer release];
            [[self parentViewController] dismissViewControllerAnimated: YES completion: nil];
        } else {
            if ([fanslist.userId isEqualToString:[[Info getInstance] userId]]) {
                MyProfileViewController *myProfileVC = [[MyProfileViewController alloc] initWithType:1];
                [self.navigationController pushViewController:myProfileVC animated:YES];
                myProfileVC.myziliao = YES;
                [myProfileVC release];
            } else {
                [[Info getInstance] setHimId:fanslist.userId];
                ProfileViewController *profileVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:profileVC animated:YES];
                [profileVC release];
            }
        }
	}
}

- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = useruname;
    my.nickName = userName;
    my.userid = userid;
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = useruname;
    my2.nickName = userName;
    my2.userid = userid;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"他的彩票"];
    [labearr addObject:@"他的合买"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaihemaibai.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"tabbg_hemai.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//他的方案
//        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//		my.userName = useruname;    
//		my.nickName = userName;
//        
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = userName;
//		[my release];
        [self otherLottoryViewController:0];
    }else if(buttonIndex == 1){
//        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//        my.myLottoryType = MyLottoryTypeOtherHe;
//		my.userName = useruname;
//		my.nickName = userName;
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = userName;
//		[my release];
        [self otherLottoryViewController:1];
    }
//    else if (buttonIndex == 2){ // @他
//        
//        
//#ifdef isCaiPiaoForIPad
//        YtTopic *topic1 = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:userName];//传用户名
//        [mTempStr appendString:@" "];
//        topic1.nick_name = mTempStr;
//        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
//        
//        [topic1 release];
//#else
//        
//        
////        NewPostViewController *publishController = [[NewPostViewController alloc] init];
////        publishController.publishType = kNewTopicController;// 自发彩博
////        YtTopic *topic1 = [[YtTopic alloc] init];
////        NSMutableString *mTempStr = [[NSMutableString alloc] init];
////        [mTempStr appendString:@"@"];
////        [mTempStr appendString:userName];//传用户名
////        [mTempStr appendString:@" "];
////        topic1.nick_name = mTempStr;
////        publishController.mStatus = topic1;
////        [self.navigationController pushViewController:publishController animated:YES];
////        [topic1 release];
////        [mTempStr release];
////        [publishController release];
//        
//        
//        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
//        publishController.microblogType = NewTopicController;// 自发彩博
//        YtTopic *topic1 = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:userName];//传用户名
//        [mTempStr appendString:@" "];
//        topic1.nick_name = mTempStr;
//        [mTempStr release];
//        publishController.mStatus = topic1;
//        [topic1 release];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
//        [self presentViewController:nav animated: YES completion:nil];
//        [publishController release];
//        [nav release];
//        
//        
//        
//#endif
//    }else if (buttonIndex == 3){ // 他的微博
////        ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:userid];//himID传用户的id
////        [controller setSelectedIndex:0];        controller.navigationItem.title = @"微博";
////        [self.navigationController pushViewController:controller animated:YES];
////		[controller release];
//        
//        TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
//        controller.userID = userid;
//        controller.title = @"他的微博";
//        [self.navigationController pushViewController:controller animated:YES];
//        [controller release];
//        
//    }else if (buttonIndex == 4){//他的资料
//        [[Info getInstance] setHimId:userid];
//        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
//        [self.navigationController pushViewController:followeesController animated:YES];
//        [followeesController release];
//    }
}

#pragma mark  MoreFansRequest
// 更多 “粉丝” 请求
-(void)sendMoreFansRequest
{
    if ([CheckNetwork isExistenceNetwork]) {
        
        [request clearDelegatesAndCancel];
        
        if(self.keyWord&&isseachView){
            
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsearchUserList:self.keyWord pageNum:[self loadedCount] pageSize:@"20"]]];		
            
        }else {
           [self  setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMyFansList:self.userID pageNum:[self loadedCount] pageSize:@"20" myUserId:[[Info getInstance] userId]]]];
            
        }
        
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(moreFansListDataLoadingBack:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		
        [request startAsynchronous];
        
    }
}


// " 更多“ 请求数据  返回

-(void)moreFansListDataLoadingBack:(ASIHTTPRequest*)mrequest
{
	
	NSString *responseString = [mrequest responseString];
	NSLog(@"resss = %@", responseString);
	if (responseString) {
		
		FansList *fanlist = [[FansList alloc] initWithParse:responseString];
		
		if ([fanlist.arrayList count]>0) {
			
			if (fansListArray) {
				
				[fansListArray addObjectsFromArray:fanlist.arrayList];
				
			}
			
            [mTableView reloadData];
			
		}else {
			
			[fansMoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			topicLoadedEnd = YES;
           
		}
		
		[fanlist release];
		
//		[mTableView reloadData];
		
	}
	
	[fansMoreCell spinnerStopAnimating];
	
	fristLoading = NO;
    if (fansMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [fansMoreCell spinnerStopAnimating];
        [fansMoreCell setInfoText:@"加载完毕"];
    }
    
	
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
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
	self.fansListArray =nil;
	self.userID =nil;
	self.request =nil;
	_refreshHeaderView =nil;
	

}


- (void)dealloc {
	
	[_refreshHeaderView release];
	[request clearDelegatesAndCancel];
	[request release];
	[fansListArray release];
	[userID release];
	
	[keyWord release];
    [mTableView release];
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
 //
//  MessageViewController.m
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//<a href='?wd=足彩开奖快车+' style='text-decoration:none'>足彩开奖快车：</a>

#import "MessageViewController.h"

#import "ASIHTTPRequest.h"

#import "NetURL.h"

#import "CheckNetwork.h"

#import "CommentList.h"
#import "DataUtils.h"
#import "ColorUtils.h"

#import "HomeCell.h"
#import "YtTopic.h"

#import "ProfileImageCell.h"

#import "MailList.h"

#import "ProfileTabBarController.h"

#import "DetailedViewController.h"

#import "NewPostViewController.h"

#import "Info.h"

#import "NSStringExtra.h"
#import "UserListMailController.h"
#import "RedactPrivLetterController.h"

#import "MyProfileViewController.h"

#import "ProfileViewController.h"

#import "CheckNewMsg.h"
#import "Followee.h"
#import "datafile.h"
#import "FolloweeCell.h"
#import "NoticeViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "LotteryPreferenceViewController.h"
#import "NSString+SBJSON.h"
#import "PreJiaoDianTabBarController.h"
//#import "CP_LieBiaoView.h"
#import "YtTopic.h"
#import "MobClick.h"
#import "NewPostViewController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MyWebViewController.h"
#import "SendMicroblogViewController.h"
#import "SharedMethod.h"
#import "SharedDefine.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"

@implementation MessageViewController

@synthesize _reloading;

@synthesize segmentedControl;

@synthesize remindListArry;

@synthesize noticeListArry;

@synthesize commentListArry;

@synthesize atMeListArry;

@synthesize privateMessageArry;

@synthesize commList;

@synthesize request;

@synthesize cpthree;
@synthesize httprequest;
@synthesize autoRequest;
@synthesize orignalRequest;
@synthesize likeRequest;

#pragma mark -
#pragma mark View lifecycle
-(id)init{
	
    
	if ((self=[super init])) {
		
		UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:UIImageGetImageFromName(@"xiaoxitab.png") tag:3];
		
		self.tabBarItem = messageItem;

		[messageItem release];
		
        
	}
    
	return self;
    
}

- (void)doRegister {
	LotteryPreferenceViewController *lot =[[LotteryPreferenceViewController alloc] init];
	[lot setHidesBottomBarWhenPushed:YES];
	lot.title =@"步骤1：偏好设置";
	[self.navigationController pushViewController:lot animated:YES];
	[lot release];
//	RegisterViewController *regist = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//	[regist setHidesBottomBarWhenPushed:YES];
//	[self.navigationController pushViewController:regist animated:YES];
//	[regist release];
//	caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//	[appDelegate switchToRegiseView];
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}

- (void)pressWriteButton:(UIButton *)sender{
    [MobClick event:@"event_weibohudong_faxinweibo"];
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController shareTo:@"" isShare:NO];
#else
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];

    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
#endif
}

- (void)biaoJiNewMsg:(NSNotification *)strarr{
    NSString *st = [strarr object];
    NSLog(@"stri = %@", st);

//    int atme;//atMe 提醒数量
//	
//	int pl;// 评论想 提醒数量
//	
//	int  sx;// 私信 提醒数量
//	
//	int tz;//系统通知
//	
//	int tx;//提醒数量
//    NSLog(@"arr = %@", arr);
    
 //   NSString * stri = [NSString stringWithFormat:@"%@", strarr];
    
   // NSLog(@"stri = %@", stri);
    NSArray * arr =  [st componentsSeparatedByString:@","];
    
    if ([arr count] >= 4) {
        atme = [[arr objectAtIndex:0] intValue];
        pl = [[arr objectAtIndex:1] intValue];
        sx = [[arr objectAtIndex:2] intValue];
        tz = [[arr objectAtIndex:3] intValue];

    }else{
        atme = 0;
        pl = 0;
        sx = 0;
        tz = 0;

    }
   
       // if ([arr count] == 4) {
                       // tx = [[arr objectAtIndex:4] intValue];
       // }

  //  }
    
    
    NSMutableArray * xxxxx = [[NSMutableArray alloc] initWithCapacity:0];
    [xxxxx addObject:@"0"];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", tz]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", atme]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", pl]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", sx]];
    second.markArray = xxxxx;
    [xxxxx release];
    
//    if (tz > 0) {
//        dianimage1.hidden= NO;
//        
//    }else{
//        dianimage1.hidden = YES;
//    }
//    if (atme > 0) {
//        dianimage2.hidden= NO;
//        
//        
//    }else{
//        dianimage2.hidden = YES;
//    }
//    if (pl > 0) {
//        dianimage3.hidden= NO;
//        
//        
//    }else{
//        dianimage3.hidden = YES;
//        
//    }
//    if (sx > 0) {
//        dianimage4.hidden= NO;
//        
//    }else{
//        dianimage4.hidden = YES;
//    }

    
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeiBoLike:) name:@"refreshWeiBoLike" object:nil];
    
    self.CP_navigation.title = @"消息";
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = WEIBO_BG_COLOR;
    backImage.tag=0310;
    //myTableView.backgroundView = backImage;
	[self.mainView addSubview:backImage];
    [backImage release];
    
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
#ifdef isCaiPiaoForIPad
    self.CP_navigation.leftBarButtonItem = nil;
#endif
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_write_normal.png");
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    [rigthItem setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];
    [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];

//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 46, 320, self.mainView.bounds.size.height - 80) style:UITableViewStylePlain];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.mainView.bounds.size.height - 80) style:UITableViewStylePlain];
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(0, 46, 390, self.mainView.bounds.size.height - 80);
#endif
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.tag = 2;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    
    [self setDefaultTitile];

    NSLog(@"%@",[[Info getInstance] userId] );
    
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(unReadPushNumData:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest setShouldContinueWhenAppEntersBackground:YES];
    [httprequest startAsynchronous];
        
    
	Info *info = [Info getInstance];
	if ([info.userId isEqualToString:CBGuiteID]) {
		[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		self.navigationItem.leftBarButtonItem = nil;
		self.navigationItem.rightBarButtonItem = nil;
		self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"noUserLogin.jpg")];
		
		UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn1 setBackgroundImage:UIImageGetImageFromName(@"btn_bg_green.png") forState:UIControlStateNormal];
		btn1.titleLabel.font = [UIFont systemFontOfSize:14];
		[btn1 setTitle:@"登录" forState:UIControlStateNormal];
		[btn1 addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
		btn1.frame = CGRectMake(80, 260, 70, 30);
		UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn2 setBackgroundImage:UIImageGetImageFromName(@"btn_bg_blue.png") forState:UIControlStateNormal];
		btn2.titleLabel.font = [UIFont systemFontOfSize:14];
		[btn2 setTitle:@"注册" forState:UIControlStateNormal];
		btn2.frame = CGRectMake(170, 260, 70, 30);
		[btn2 addTarget:self action:@selector(doRegister) forControlEvents:(UIControlEventTouchUpInside)];
		[self.mainView addSubview:btn1];
		[self.mainView addSubview:btn2];
		self.CP_navigation.title=@"消息";
		return;
	}
	
	fristLoadingMore = YES;
	commentLoadend = NO;
	
	fristLoadingAtme = YES;
	
	atmeEnd = NO;
	
	fristLoadingPrvivatalMail =YES;
	
	privatalMailLoadend = NO;
	fristremindMore = YES;
	fristnoticeMore =YES;
	remindEnd = NO;
	noticeEnd = NO;
	
	
	if (_refreshHeaderView == nil) {
		        
        CBRefreshTableHeaderView *headerview = 
        [[CBRefreshTableHeaderView alloc] 
         initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
        _refreshHeaderView = headerview;
        headerview.backgroundColor = [UIColor clearColor];
        headerview.delegate = self;
        [myTableView addSubview:headerview];
        [headerview release];
        
		
	}
    
}

- (void)doBack{
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotohome{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

// 设置默认的 titile
-(void)setDefaultTitile{

	NSArray *arryList = [NSArray arrayWithObjects:@"提醒",@" 通知 ",@" @我的 ",@" 评论箱 ",@" 私信 ",nil];
	
	UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:arryList];
	segmented.frame= CGRectMake(0, 0, 320, 40);
	
	[segmented addTarget:self action:@selector(segmentedcontrolEventValueChanged) forControlEvents:UIControlEventValueChanged];
	
	//segmented.selectedSegmentIndex =0;
	
	self.segmentedControl = segmented;
    segmented.selectedSegmentIndex = 0;
    
   // [self.view addSubview:segmentedControl];
	
	//self.navigationItem.titleView = segmentedControl;
    
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 5) {
        [self sendRemindRequest];
    }
    
	
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(biaoJiNewMsg:) name:@"leixingbiaoji" object:nil];
    
	[segmented release];
    
    
    NSArray * imageArray = @[@"WeiBo_Msg_SysMsg.png",@"WeiBo_Msg_ZhongJiang.png",@"WeiBo_Msg_At.png",@"WeiBo_Msg_TongZhi.png",@"WeiBo_Msg_SiXin.png"];
    
    NSArray * selectImageArray = @[@"WeiBo_Msg_SysMsg_1.png",@"WeiBo_Msg_ZhongJiang_1.png",@"WeiBo_Msg_At_1.png",@"WeiBo_Msg_TongZhi_1.png",@"WeiBo_Msg_SiXin_1.png"];

#ifdef isCaiPiaoForIPad
    second = [[CP_SecondNavigationView alloc] initWithFrame:CGRectMake(0, 0, 390, 44) buttonImageName:imageArray selectImageName:selectImageArray];
#else
    second = [[CP_SecondNavigationView alloc] initWithFrame:CGRectMake(0, 0, 320, 44) buttonImageName:imageArray selectImageName:selectImageArray];
#endif
    second.delegate = self;
    [self.mainView addSubview:second];
    
    
}
- (void)secondDelegateSelectedIndex:(NSInteger)index{
    NSLog(@"index = %ld", (long)index);
    segmentedControl.selectedSegmentIndex= index-1;
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 5) {
        
        [self segmentedcontrolEventValueChanged];
        
    }
    
}

//选择事件
- (void)pressButtonXuan:(UIButton *)sender{
    segmentedControl.selectedSegmentIndex= sender.tag-1;
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 5) {
        
            [self segmentedcontrolEventValueChanged];
        
    }
    
    
}



-(void)sendRemindRequest{//提醒
	[request clearDelegatesAndCancel];
	
    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByUserId:@"549675" pageNum:@"1" pageSize:@"20"]]];
    
//	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] 
//																	userId2:@"0" 
//																	pageNum:@"1"
//																   pageSize:@"20"
//																   mailType:@"1" 
//																	   mode:@"1"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(remindListDataBackData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}

// 通知 接口(私信一对一接口）userId2 传 "0"
-(void)sendNoticeRequest{//通知

	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] 
																	userId2:@"0" 
																	pageNum:@"1"
																   pageSize:@"20"
																   mailType:@"1" 
																	   mode:@"0"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(notieListDataBackData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取	
    

}



// 发送 atme 请求
-(void)sendatMeListRequest{
	
	[request clearDelegatesAndCancel];

	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetAtmeTopicList:[[Info getInstance]userId] pageNum:@"1" pageSize:@"20"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[request setDelegate:self];
	
	[request setDidFinishSelector:@selector(AtmeListLoadingTableviewData:)];
	
	[request setNumberOfTimesToRetryOnTimeout:2];
	
	// 异步获取
	
	[request startAsynchronous];

}


// 发送 评论箱请求
-(void)sendCommentListRequest:(NSString*)pageNum pageSize:(NSString*)pigeSize{
	
	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetCommentList:[[Info getInstance]userId] pageNum:pageNum pageSize:pigeSize]]] ;
    //request = [ASIHTTPRequest requestWithURL:[NetURL CBgetCommentList:[[Info getInstance]userId] pageNum:pageNum pageSize:pigeSize]];
	NSLog(@"neturl = %@",[NetURL CBgetCommentList:[[Info getInstance]userId] pageNum:pageNum pageSize:pigeSize] );
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(commentListLoadingTableViewData:)];
    [request setDidFailSelector:@selector(commentlisetaaaa:)];
	[request setNumberOfTimesToRetryOnTimeout:2];

	// 异步获取
	[request startAsynchronous];
    NSLog(@"request bbbbbbbbbbbb");
   // [self commentListLoadingTableViewData];
}


//发送 私信列表 请求
-(void)sendPrivatalMailListRequest{
	
	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMailList:[[Info getInstance]userId] pageNum:@"1" pageSize:@"20"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[request setDelegate:self];
	
	[request setDidFinishSelector:@selector(privatalMailLoadingTableViewData:)];
	
	[request setNumberOfTimesToRetryOnTimeout:2];
	
	[request startAsynchronous];
	
	
}



-(void)segmentedcontrolEventValueChanged{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    
    if (segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND) {
        lineimage.frame = CGRectMake(35, 37, 22, 3.5);
        self.CP_navigation.title = @"消息";
    }else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_NOTICE) {
        lineimage.frame = CGRectMake(82, 37, 22, 3.5);
        self.CP_navigation.title = @"通知";
    }else if(segmentedControl.selectedSegmentIndex==MSG_TYPE_ATME){
        lineimage.frame = CGRectMake(134, 37, 22, 3.5);
        self.CP_navigation.title = @"@我";
    }else if(segmentedControl.selectedSegmentIndex ==MSG_TYPE_COMMENT){
        lineimage.frame = CGRectMake(186, 37, 22, 3.5);
        self.CP_navigation.title = @"评论";
    }else{
        lineimage.frame = CGRectMake(240, 37, 22, 3.5);
        self.CP_navigation.title = @"私信";
    }
    
    [UIView commitAnimations];
    
	
	if (segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND) {
		privatalMailLoadend = NO;
        
   		
//		if(self.navigationItem.rightBarButtonItem)
			
		//	self.navigationItem.rightBarButtonItem =nil;
		
        for(UIImageView *imageView in myTableView.subviews){
            if (imageView.tag==0300) {
                [imageView removeFromSuperview];
            }
        }

        
		if (!remindListArry) {
			
			[self sendRemindRequest];
            
        
		}else {
            
            if (remindListArry.count==0) {
                
                _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
                _bigImage.tag=0300;
                
                imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
                imageMassage.frame=CGRectMake(80, 0, 100, 90);
                UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
                
                labelTishi.text=@"暂无消息噢";
                labelTishi.textColor=[UIColor blackColor];
                labelTishi.backgroundColor=[UIColor clearColor];
                [_bigImage addSubview:imageMassage];
                [_bigImage addSubview:labelTishi];
                
                [myTableView addSubview:_bigImage];
                [labelTishi release];
                [_bigImage release];
                [imageMassage release];
                

            }

		    [myTableView reloadData];
		}
	}
    	else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_NOTICE) {
		privatalMailLoadend = NO;
        
       
		//if(self.navigationItem.rightBarButtonItem)
			
		//	self.navigationItem.rightBarButtonItem =nil;
            
            for(UIImageView *imageView in myTableView.subviews){
                if (imageView.tag==0300) {
                    [imageView removeFromSuperview];
                }
            }
            

            
		if (!noticeListArry) {
			
			[self sendNoticeRequest];
			
		}
    
        else {
		
            if (noticeListArry.count==0) {
                
                _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
                _bigImage.tag=0300;
                
                imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
                imageMassage.frame=CGRectMake(80, 0, 100, 90);
                UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];

                
                labelTishi.text=@"暂无消息噢";
                labelTishi.textColor=[UIColor blackColor];
                labelTishi.backgroundColor=[UIColor clearColor];
                [_bigImage addSubview:imageMassage];
                [_bigImage addSubview:labelTishi];
                
                [myTableView addSubview:_bigImage];
                [labelTishi release];
                [_bigImage release];
                [imageMassage release];
                

            }


		    [myTableView reloadData];
    
        
        }

	}else if(segmentedControl.selectedSegmentIndex==MSG_TYPE_ATME){
		privatalMailLoadend = NO;
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"atme"];
            

            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
        }
        
	//	if(self.navigationItem.rightBarButtonItem)
			
		//	self.navigationItem.rightBarButtonItem =nil;
        for(UIImageView *imageView in myTableView.subviews){
            if (imageView.tag==0300) {
                [imageView removeFromSuperview];
            }
        }

		if (!atMeListArry) {
            
			[self sendatMeListRequest];
        }
        
        else
        {
            if (atMeListArry.count==0) {
                
                _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
                _bigImage.tag=0300;
                
                imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
                imageMassage.frame=CGRectMake(80, 0, 100, 90);
                UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];


                labelTishi.text=@"暂无消息噢";
                labelTishi.textColor=[UIColor blackColor];
                labelTishi.backgroundColor=[UIColor clearColor];
                [_bigImage addSubview:imageMassage];
                [_bigImage addSubview:labelTishi];
                
                [myTableView addSubview:_bigImage];
                [labelTishi release];
                [_bigImage release];
                [imageMassage release];

                
                
            }
        		[myTableView reloadData];
		}
	
	}else if(segmentedControl.selectedSegmentIndex ==MSG_TYPE_COMMENT){
		privatalMailLoadend = NO;
        
        for(UIImageView *imageView in myTableView.subviews){
            if (imageView.tag==0300) {
                [imageView removeFromSuperview];
            }
        }
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"pl"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
        }
       
        

        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"pinglunwo"] intValue]) {
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"pinglunwo"];
            
            
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"上拉可以加载更多..." HidenSelf:NO];
            
        }
        

		if (self.navigationItem.rightBarButtonItem) {
		//	 self.navigationItem.rightBarButtonItem = nil;
		}

        

        
		if([CheckNetwork isExistenceNetwork]&&!commentListArry){
			
			[self sendCommentListRequest:@"1" pageSize:@"20"];
            [myTableView reloadData];
        }else
            
            
            if (commentListArry.count==0) {
                
                _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
                _bigImage.tag=0300;
                
                imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
                imageMassage.frame=CGRectMake(80, 0, 100, 90);
                UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
                
                
                labelTishi.text=@"暂无消息噢";
                labelTishi.textColor=[UIColor blackColor];
                labelTishi.backgroundColor=[UIColor clearColor];
                [_bigImage addSubview:imageMassage];
                [_bigImage addSubview:labelTishi];
                
                [myTableView addSubview:_bigImage];
                [labelTishi release];
                [_bigImage release];
                [imageMassage release];
                
                
                
            }

            
		 [myTableView reloadData];
		
			
	}else {
        
		privatalMailLoadend = NO;
		UIBarButtonItem *write = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(actionWriteButton:)];
		
		//self.navigationItem.rightBarButtonItem = write;
		
		[write release];
        
    
        for(UIImageView *imageView in myTableView.subviews){
            if (imageView.tag==0300) {
                [imageView removeFromSuperview];
            }
        }

        //清空所有私信（包括客服私信与微博私信）
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"CheckNew_soundSet_kfsx"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"CheckNew_soundSet_allsx"];
        
		if ([CheckNetwork isExistenceNetwork]&&!privateMessageArry) {
			
			[self sendPrivatalMailListRequest];
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
                NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
                [dic setValue:@"0" forKey:@"sx"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
//                caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//                caiboappdelegate.keFuButton.markbool = NO;
//                caiboappdelegate.keFuButton.newkfbool = NO;
                

            }
           	
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"sixin"] intValue]) {
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"sixin"];
                
                
                caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
                [appDelegate showMessage:@"上拉可以加载更多..." HidenSelf:NO];
                

            }
            
            

            
		} else {
            
            if (privateMessageArry.count==0) {
                
                _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
                _bigImage.tag=0300;
                
                imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
                imageMassage.frame=CGRectMake(80, 0, 100, 90);
                UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
                
                
                labelTishi.text=@"暂无消息噢";
                labelTishi.textColor=[UIColor blackColor];
                labelTishi.backgroundColor=[UIColor clearColor];
                [_bigImage addSubview:imageMassage];
                [_bigImage addSubview:labelTishi];
                
                [myTableView addSubview:_bigImage];
                [labelTishi release];
                [_bigImage release];
                [imageMassage release];
                
                
                
            }

            
			[myTableView reloadData];
		}
	}
}


// 响应写私信
-(void)actionWriteButton:(id)sender{
    privatalMailLoadend = NO;
    RedactPrivLetterController *publishController = [[RedactPrivLetterController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:publishController];
	navController.navigationBarHidden = YES;
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }
	if (navController) {
        
        
        
		[self presentViewController:navController animated: YES completion:nil];
	}
	[navController release];
    [publishController release];
}



// 接收 提醒请求 数据
-(void)remindListDataBackData:(ASIHTTPRequest*)mrequest{
    
	NSString * responseString = [mrequest responseString];
	
	if(responseString){
        
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		self.remindListArry= topic.arrayList;
		
		[topic release];
		
		[myTableView reloadData];
        
	}
	
    if(remindListArry.count==0)
    {
        
        _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
        _bigImage.tag=0300;
        
        imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
        imageMassage.frame=CGRectMake(80, 0, 100, 90);
        UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
        
        
        labelTishi.text=@"暂无消息噢";
        labelTishi.textColor=[UIColor blackColor];
        labelTishi.backgroundColor=[UIColor clearColor];
        [_bigImage addSubview:imageMassage];
        [_bigImage addSubview:labelTishi];
        
        [myTableView addSubview:_bigImage];
        [labelTishi release];
        [_bigImage release];
        [imageMassage release];
    }
    
	[remindMoreCell setType:MSG_TYPE_LOAD_MORE];
	
	[self resetTitile];
    
}


//-(void)remindListDataBackData:(ASIHTTPRequest*)mrequest{
//	
//	NSString *responseString = [mrequest responseString];
//     NSLog(@"respon = %@", responseString);
//	if(responseString){
//		
//		MailList *maillist = [[MailList alloc]initWithParse:responseString];
//		if (maillist) {
//			self.remindListArry = maillist.arryList;
//			[myTableView reloadData];
//			
//		}
//		
//		[maillist release];
//		
//		[remindMoreCell setType:MSG_TYPE_LOAD_MORE];
//		
//		[self resetTitile];
//	}
//	
//}



// 接收 通知请求 数据
-(void)notieListDataBackData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
    NSLog(@"respon4 = %@", responseString);
	if(responseString){
		
		MailList *maillist = [[MailList alloc]initWithParse:responseString];
		if (maillist) {
			self.noticeListArry = maillist.arryList;
			
			[myTableView reloadData];
			
		}
		
		[maillist release];
		
		[noticeMoreCell setType:MSG_TYPE_LOAD_MORE];

		[self resetTitile];
	}
    if(noticeListArry.count==0)
    {
        
        _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
        _bigImage.tag=0300;
        
        imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
        imageMassage.frame=CGRectMake(80, 0, 100, 90);
        UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
        labelTishi.text=@"暂无消息噢";

        labelTishi.textColor=[UIColor blackColor];
        labelTishi.backgroundColor=[UIColor clearColor];
        [_bigImage addSubview:imageMassage];
        [_bigImage addSubview:labelTishi];
        
        [myTableView addSubview:_bigImage];
        [labelTishi release];
        [_bigImage release];
        [imageMassage release];
    }

	
}


// 接收 私信列表 请求 数据
-(void)privatalMailLoadingTableViewData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	NSLog(@"resaaaa = %@", responseString);
	if(responseString){
		MailList *mList = [[MailList alloc]initWithParse:responseString];
		if (mList) {
			[self setPrivateMessageArry: mList.arryList];
			[myTableView reloadData];
		}
        [mList release];
    
	}
    
    if(privateMessageArry.count==0)
    {
        
        _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
        _bigImage.tag=0300;
        
        imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
        imageMassage.frame=CGRectMake(80, 0, 100, 90);
        UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
        labelTishi.text=@"暂无消息噢";
        labelTishi.textColor=[UIColor blackColor];
        labelTishi.backgroundColor=[UIColor clearColor];
        [_bigImage addSubview:imageMassage];
        [_bigImage addSubview:labelTishi];
        
        [myTableView addSubview:_bigImage];
        [labelTishi release];
        [_bigImage release];
        [imageMassage release];
    }

    
    [moreCellOfPrivatalMail setType:MSG_TYPE_LOAD_MORE];
    [self resetTitile];
}

//  接收 “@me” 数据
-(void)AtmeListLoadingTableviewData:(ASIHTTPRequest*)mrequest{

	NSString * responseString = [mrequest responseString];
	
	if(responseString){
	 
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		self.atMeListArry= topic.arrayList;
		
		[topic release];
		
		[myTableView reloadData];
		
	
	
	}
    
    if(atMeListArry.count==0)
    {
      
        _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
        _bigImage.tag=0300;
        
        imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
        imageMassage.frame=CGRectMake(80, 0, 100, 90);
        UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
        labelTishi.text=@"暂无消息噢";
        labelTishi.textColor=[UIColor blackColor];
        labelTishi.backgroundColor=[UIColor clearColor];
        [_bigImage addSubview:imageMassage];
        [_bigImage addSubview:labelTishi];
        
        [myTableView addSubview:_bigImage];
        [labelTishi release];
        [_bigImage release];
        [imageMassage release];
    }
	
	[moreCellOfatme setType:MSG_TYPE_LOAD_MORE];
	
	[self resetTitile];

}
												
- (void)commentlisetaaaa:(ASIHTTPRequest *)mrequest{
    NSLog(@"aaaaaaaaaaaaaaaa");
}
// 接收 “评论 箱 数据”  数据
-(void)commentListLoadingTableViewData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	NSLog(@"respon5 = %@", responseString);
	
	if(responseString){
		
		CommentList *commentlist = [[CommentList alloc] initWithParse:responseString];


		self.commentListArry = commentlist.arrayList;
        
		[commentlist release];
		
		[myTableView reloadData];
		
	}
	
    if(commentListArry.count==0)
    {
        
        _bigImage=[[UIView alloc]initWithFrame:CGRectMake(30, 50, 200, 180)];
        _bigImage.tag=0300;
        
        imageMassage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nomassage.png"]];
        imageMassage.frame=CGRectMake(80, 0, 100, 90);
        UILabel *labelTishi=[[UILabel alloc]initWithFrame:CGRectMake(85, 100, 150, 30)];
        labelTishi.text=@"暂无消息噢";
        labelTishi.textColor=[UIColor blackColor];
        labelTishi.backgroundColor=[UIColor clearColor];
        [_bigImage addSubview:imageMassage];
        [_bigImage addSubview:labelTishi];
        
        [myTableView addSubview:_bigImage];
        [labelTishi release];
        [_bigImage release];
        [imageMassage release];
    }

    
    
	if(moreCell)
		[moreCell setType:MSG_TYPE_LOAD_MORE];
	
	
	[self resetTitile];

	
	
}	


#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	if (scrollView.tag == 2) {
        [_refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
    }else {
        scrollView.scrollEnabled = NO;
    }
	
	
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.tag != 2) {
        return;
    }
	if(myTableView.contentSize.height- scrollView.contentOffset.y <=360.0){
		
		
		if (segmentedControl.selectedSegmentIndex==MSG_TYPE_REMIND) {
			
			
			if(remindMoreCell){
				
				if (!remindEnd) {
					
					[remindMoreCell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreRemindListRequest) withObject:nil afterDelay:1.0];
					
				}
				
			}
			
			
		}else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_NOTICE) {
			
			
			if(noticeMoreCell){
				
				if (!noticeEnd) {
					
					[noticeMoreCell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreNoticeListRequest) withObject:nil afterDelay:1.0];
					
				}
                
              

			}
		
			
		}else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_ATME) {
			
			if(moreCellOfatme){
				
				if (!atmeEnd) {
					
					[moreCellOfatme spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreAtmeListRequest) withObject:nil afterDelay:1.0];
					
				}
			
			}
			
		}else  if (segmentedControl.selectedSegmentIndex==MSG_TYPE_COMMENT) {
			
			if (moreCell) {
				
				if (!commentLoadend) {
					[moreCell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreCommentListRequest) withObject:nil afterDelay:1.0];
					
				}
				
			}
		
		}else {// 私信
			
			if (moreCellOfPrivatalMail) {
				if (!privatalMailLoadend) {
					
					[moreCellOfPrivatalMail spinnerStartAnimating];
					
					[self performSelector:@selector(sendMorePrivatalMailRequest) withObject:nil afterDelay:1.0];
					
				}
				
				
				
			}
			
			
			
		}
		
	
	
	}
	
	
	[_refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

// 在这边 发送  刷新 请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
    [self reloadTableViewDataSource];
    [_refreshHeaderView setState:CBPullRefreshLoading];
	//myTableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
	
	if (segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND) {
		fristremindMore =YES;
		
		remindEnd = NO;
		
		[self sendRemindRequest];
	}
	
	else if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_NOTICE) {
		
		fristnoticeMore =YES;
		
		noticeEnd = NO;
		
		[self sendNoticeRequest];
		
		
	}else if(segmentedControl.selectedSegmentIndex == MSG_TYPE_ATME){
		
		atmeEnd = NO;
		fristLoadingAtme = YES;
	
		if([CheckNetwork isExistenceNetwork]){
			
			[self sendatMeListRequest];
		
		}
		
	
	}else if (segmentedControl.selectedSegmentIndex== MSG_TYPE_COMMENT) {
		
		 commentLoadend = NO;
		
		 fristLoadingMore= YES;
		
		if ([CheckNetwork isExistenceNetwork]) {
			
			[self sendCommentListRequest:@"1" pageSize:@"20"];	
			
		}
		
		
	}else {
		privatalMailLoadend = NO;
		
		fristLoadingPrvivatalMail = YES;
	
		if ([CheckNetwork isExistenceNetwork]) {
			
			[self sendPrivatalMailListRequest];
			
		}
	
	}

	// 模拟 延迟 三秒  完成接收
	[self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:1.0];	
	
	
}



-(void)doneLoadedTableViewData{

	_reloading = NO;
	[_refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];


}




//  返回 判断  reload 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view{
	
	
	return _reloading; // should return if data source model is reloading
	
}


// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)toUserInfo:(id)sender
{
    //UIButton *tmpButton = (UIButton *)sender;
    
}
- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
	
}

// 回调函数,自动清空 数据
- (void) automeassageRefresh {
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    if (appDelegate.changeAccount) {
		if (remindListArry){
			[remindListArry removeAllObjects];
			[remindListArry release];
			remindListArry =nil;
		}
		
		if (noticeListArry) {
			
			[noticeListArry removeAllObjects];
			[noticeListArry release];
             noticeListArry =nil;
			
		}
        
        if (atMeListArry) {
            [atMeListArry removeAllObjects];
            [atMeListArry release];
            atMeListArry = nil;
        }
        
        if (commentListArry) {
            [commentListArry removeAllObjects];
            [commentListArry release];
            commentListArry = nil;
        }
        
        if (privateMessageArry) {
            [privateMessageArry removeAllObjects];
            [privateMessageArry release];
            privateMessageArry = nil;
        }
        
		
		[myTableView reloadData];
		
		
        int index = (int)segmentedControl.selectedSegmentIndex;
        switch (index) {
				
			case MSG_TYPE_NOTICE:
				
				[self sendNoticeRequest];
				break;
            case MSG_TYPE_ATME:
                [self sendatMeListRequest];
                break;
            case MSG_TYPE_COMMENT:
                [self sendCommentListRequest:@"1" pageSize:@"20"];
                break;
            case MSG_TYPE_PRIVATE_MESSAGES:
                [self sendPrivatalMailListRequest];
                break;
            default:
                break;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hidenMessage];

}
- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{
    
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    
    
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.tag = 200;
        prizeView.delegate = self;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    pl = [[dict objectForKey:@"pl"] intValue];
    sx = [[dict objectForKey:@"sx"] intValue];
    tz = [[dict objectForKey:@"xttz"] intValue];
    atme = [[dict objectForKey:@"atme"] intValue];
//
//    NSLog(@"gzrftstr = %d", str33);
//    if (pl != 0 || sx != 0 || tz != 0 || atme != 0) {
//        self.tabBarItem.badgeValue = @"new";
//		
//		
//    }
    NSMutableArray * xxxxx = [[NSMutableArray alloc] initWithCapacity:0];
    [xxxxx addObject:@"0"];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", tz]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", atme]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", pl]];
    [xxxxx addObject:[NSString stringWithFormat:@"%d", sx]];
    second.markArray = xxxxx;
    [xxxxx release];


    
//    if (tz > 0) {
//        dianimage1.hidden= NO;
//       
//    }else{
//        dianimage1.hidden = YES;
//    }
//    if (atme > 0) {
//        dianimage2.hidden= NO;
//        
//
//    }else{
//        dianimage2.hidden = YES;
//    }
//    if (pl > 0) {
//        dianimage3.hidden= NO;
//        
//
//    }else{
//        dianimage3.hidden = YES;
//       
//    }
//    if (sx > 0) {
//        dianimage4.hidden= NO;
//       
//    }else{
//        dianimage4.hidden = YES;
//    }
    
    
//    if (tz > 0) {
//        self.segmentedControl.selectedSegmentIndex = 1;
//        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//        NSString * diyistr = [devicestr substringToIndex:1];
//        if ([diyistr intValue] >= 5) {
//            [self segmentedcontrolEventValueChanged];
//        }
//        return;
//    }else if(atme > 0){
//        self.segmentedControl.selectedSegmentIndex = 2;
//        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//        NSString * diyistr = [devicestr substringToIndex:1];
//        if ([diyistr intValue] >= 5) {
//            [self segmentedcontrolEventValueChanged];
//        }
//        return;
//    }else if(pl > 0){
//        self.segmentedControl.selectedSegmentIndex = 3;
//        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//        NSString * diyistr = [devicestr substringToIndex:1];
//        if ([diyistr intValue] >= 5) {
//            [self segmentedcontrolEventValueChanged];
//        }
//    }else if(sx > 0){
//        self.segmentedControl.selectedSegmentIndex = 4;
//        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//        NSString * diyistr = [devicestr substringToIndex:1];
//        if ([diyistr intValue] >= 5) {
//            [self segmentedcontrolEventValueChanged];
//        }
//
//    }
    
}
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
		
	//  删除通知之后 返回 自动刷新
	if (segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND) {
		
		if (remindListArry&&[remindListArry count]>0) {
			
			[self sendRemindRequest];
		}
	}else if (segmentedControl.selectedSegmentIndex == MSG_TYPE_NOTICE) {
		
		if (noticeListArry&&[noticeListArry count]>0) {
			
		  [self sendNoticeRequest];
		}
	}
	
	if (segmentedControl.selectedSegmentIndex== MSG_TYPE_PRIVATE_MESSAGES) 
    {
		if([CheckNetwork isExistenceNetwork])
        {
		 [self sendPrivatalMailListRequest];
		}
    }
    
    [myTableView reloadData];
}


-(void)autoRefresh:(NSString*)responseString{
	
	if (responseString) {
	
		CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
		
		if (![check.atme isEqualToString:@"0"]||![check.pl isEqualToString:@"0"]||![check.sx isEqualToString:@"0"]||![check.xttz isEqualToString:@"0"]) {
			
			
		if (segmentedControl==nil) {
				
				[self setDefaultTitile];
			}
			
			
			tz =[check.xttz intValue];
						
			if (tz>0) {
				
				[self resetTitile:tz text:@"通知" index:MSG_TYPE_NOTICE];

			}else {
			   tz = 0;
			}

			 atme = [check.atme intValue];
			
			// 判断 设置中 atme 开关 时候 打开
			
			NSString  *atmeOn=[datafile getDataByKey:KEY_MENTION];
			
			if (atme>0&&![atmeOn isEqualToString:OTHER_SWITCH_OFF]) {
				
				[self resetTitile:atme text:@"@我的" index:MSG_TYPE_ATME];
				
			}else {
				atme=0;
			}

			pl = [check.pl intValue];
			
			// 判断 设置中 评论箱 开关 时候 打开
			NSString *plbox = [datafile getDataByKey:KEY_COMMENT];
						
			if (pl>0&&![plbox isEqualToString:OTHER_SWITCH_OFF]) {
				
				[self resetTitile:pl text:@"评论箱" index:MSG_TYPE_COMMENT];
				
			}else{
				pl = 0;
			
			}
			
			sx = [check.sx intValue];
			// 判断 设置中 私信 开关 时候 打开
			NSString *sxOn = [datafile getDataByKey:KEY_PRIVATE_LETTER];
			
			if(sx>0&&![sxOn isEqualToString:OTHER_SWITCH_OFF]){
				
				[self resetTitile:sx text:@"私信" index:MSG_TYPE_PRIVATE_MESSAGES];
				
			}else {
				sx = 0;
			}

			int count = tz+atme+pl+sx;
			
			caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            
            UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
            NSArray * views = a.viewControllers;
            if ([views count] >= 2) {
                PreJiaoDianTabBarController *c = [views objectAtIndex:1];
                if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                    //                NSArray * viewss = c.viewControllers;
                    
                    // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                    
                    //     cnav.tabBarItem.badgeValue = nil;
                    
                    
                    if (count > 99) {
                        c.xiaoxibadge.hidden = NO;
                        c.xxbadgeValue.text = @"N";
                        
                    }else if(count <= 99 && count > 0){
                        c.xiaoxibadge.hidden = NO;
                        c.xxbadgeValue.text = [NSString stringWithFormat:@"%d",count];
                    }else{
                        c.xiaoxibadge.hidden = YES;
                        c.xxbadgeValue.text = @"";
                    }
                    
                }
            }
			
		}
		
		[check release];
		
	}
	

}


-(void)resetTitile{
	
//	if (segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND) {
//		[self.segmentedControl setTitle:@" 提醒 " forSegmentAtIndex:MSG_TYPE_REMIND];
//		
//		int count = pl +atme +sx +tz;
//		
//		if (count>0) {
//			
//			self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",count];
//			
//			
//		}
//		if (tx) {
//			tx = 0;
//		}
//	}
	
	if (segmentedControl.selectedSegmentIndex == MSG_TYPE_NOTICE) {
		
	 [self.segmentedControl setTitle:@" 通知 " forSegmentAtIndex:MSG_TYPE_NOTICE];
		
		int count = pl +atme +sx;
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
                // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                
                //     cnav.tabBarItem.badgeValue = nil;
                
                
                if (count > 99) {
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = @"N";
                    
                }else if(count <= 99 && count > 0){
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = [NSString stringWithFormat:@"%d",count];
                }else{
                    c.xiaoxibadge.hidden = YES;
                    c.xxbadgeValue.text = @"";
                }

            }
        }

		
		        
		if (tz) {
			tz = 0;
          //  dianimage1.hidden = YES;
		}
		
		
	}else if (segmentedControl.selectedSegmentIndex== MSG_TYPE_PRIVATE_MESSAGES) {
		
		[self.segmentedControl setTitle:@" 私信 " forSegmentAtIndex:MSG_TYPE_PRIVATE_MESSAGES];
		
		int count= pl +atme+tz;
		
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
                // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                
                //     cnav.tabBarItem.badgeValue = nil;
                
                
                if (count > 99) {
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = @"N";
                    
                }else if(count <= 99 && count > 0){
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = [NSString stringWithFormat:@"%d",count];
                }else{
                    c.xiaoxibadge.hidden = YES;
                    c.xxbadgeValue.text = @"";
                }
                
            }
        }

		if (sx) {
			sx=0;
          //  dianimage4.hidden = YES;
		}
		
	}else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_ATME) {
		
		[self.segmentedControl setTitle:@" @我的 " forSegmentAtIndex:MSG_TYPE_ATME];
		
		int count =pl+sx+tz;
		
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
                // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                
                //     cnav.tabBarItem.badgeValue = nil;
                
                
                if (count > 99) {
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = @"N";
                    
                }else if(count <= 99 && count > 0){
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = [NSString stringWithFormat:@"%d",count];
                }else{
                    c.xiaoxibadge.hidden = YES;
                    c.xxbadgeValue.text = @"";
                }
                
            }
        }

		
		if (atme) {
		atme =0;
//            dianimage2.hidden =YES;
		}
		
		
	}else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_COMMENT) {
		
		[self.segmentedControl setTitle:@" 评论箱 " forSegmentAtIndex:MSG_TYPE_COMMENT];
		
		int count =atme +sx+tz;
		
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
                // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                
                //     cnav.tabBarItem.badgeValue = nil;
                
                
                if (count > 99) {
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = @"N";
                    
                }else if(count <= 99 && count > 0){
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = [NSString stringWithFormat:@"%d",count];
                }else{
                    c.xiaoxibadge.hidden = YES;
                    c.xxbadgeValue.text = @"";
                }
                
            }
        }

		if (pl) {
			
			pl=0;
//            dianimage3.hidden= YES;
		}
	
	}
	
	if (!atme&&!pl&&!sx&&!tz) {
		
		//self.navigationController.tabBarItem.badgeValue=nil;
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
               // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                
               //     cnav.tabBarItem.badgeValue = nil;
                
                c.xiaoxibadge.hidden = YES;
                c.xxbadgeValue.text = @"";
            }
        }

		
	}else{
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
               // UIViewController * cnav = [c.viewControllers objectAtIndex:3];
                NSInteger zongcout = atme + pl  + sx + tz;
                               if (zongcout > 99) {
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = @"N";
                    
                }else if(zongcout <= 99 && zongcout > 0){
                    c.xiaoxibadge.hidden = NO;
                    c.xxbadgeValue.text = [NSString stringWithFormat:@"%ld",(long)zongcout];
                }else{
                    c.xiaoxibadge.hidden = YES;
                    c.xxbadgeValue.text = @"";
                }

                
                
            }
        }
    }
	
}


-(void)resetTitile:(int)value text:(NSString*)text index:(int)index{
	
	NSMutableString *app= [[NSMutableString alloc] init];
	
	[app appendFormat:@"%@",text];
	
	[app appendString:@"("];

	[app appendFormat:@"%d",value];
	
	[app appendString:@")"];
	
	[self.segmentedControl setTitle:app forSegmentAtIndex:index];
	
	[app release];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSInteger count;
	if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_REMIND) {
		count = [remindListArry count];
	}
	else if (segmentedControl.selectedSegmentIndex==MSG_TYPE_NOTICE) {
		
		count = [noticeListArry count];
		
	}else if(segmentedControl.selectedSegmentIndex ==MSG_TYPE_ATME){
		
		count = [atMeListArry count];
		
	}else if(segmentedControl.selectedSegmentIndex==MSG_TYPE_COMMENT){
		
		count = [commentListArry count];
			
	}else {
		count = [privateMessageArry count];
	}
  
	
	return (!count)?count:count+1;
}

// cell heigth
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	CGFloat cellHeigth = 0.0f;
	if (segmentedControl.selectedSegmentIndex== MSG_TYPE_REMIND) {
       
		
				
		if (indexPath.row == [remindListArry count]) {
			
			cellHeigth = 60.0;
			
		}else{
             YtTopic *pic = [remindListArry objectAtIndex:indexPath.row];
            if (pic) {
                cellHeigth  = pic.cellHeight;
            }

        }
			
			
		
	}
	else  if (segmentedControl.selectedSegmentIndex== MSG_TYPE_NOTICE) {
		
		if (indexPath.row == [noticeListArry count]) {
			
			cellHeigth = 60.0;
			
		}else
			
//			cellHeigth = 50.0;
            cellHeigth = 70.0;
			
	}else if(segmentedControl.selectedSegmentIndex == MSG_TYPE_ATME){
		
		if(indexPath.row == [atMeListArry count]){
			
			cellHeigth = 60.0;
		
		}else {
			
			YtTopic *topic = [atMeListArry objectAtIndex:indexPath.row];
			
			cellHeigth = topic.cellHeight;
			
						
		}

		
	}else if(segmentedControl.selectedSegmentIndex == MSG_TYPE_COMMENT){
		
		if (indexPath.row ==[commentListArry count]) {
			
			cellHeigth = 60.0;
			
		}else {
			YtTopic *topic = [commentListArry objectAtIndex:indexPath.row];
            
			cellHeigth = topic.cellHeight;
            
		}
		
	}else {
//		cellHeigth = 65.0;
        cellHeigth = 75.0;
	}

	return cellHeigth;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme && segmentedControl.selectedSegmentIndex != MSG_TYPE_REMIND && segmentedControl.selectedSegmentIndex != MSG_TYPE_NOTICE && segmentedControl.selectedSegmentIndex != MSG_TYPE_PRIVATE_MESSAGES) {
       
        myTableView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        //myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        //myTableView.backgroundColor = [UIColor cellBackgroundColor];
        myTableView.backgroundColor = [UIColor clearColor];
        //_refreshHeaderView.backgroundColor = [UIColor cellBackgroundColor];
        //myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
	static NSString *CellIdentifier;
	if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_REMIND) {
		
		if (indexPath.row == [remindListArry count]) {
			
			CellIdentifier = @"remindCellMore";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if(cell==nil){
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
            if (!remindEnd) {
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    [cell spinnerStartAnimating];
                    [self performSelector:@selector(sendMoreRemindListRequest) withObject:nil afterDelay:2.0];
                }
                
			}
            
			if (remindMoreCell==nil) {
				remindMoreCell =cell;	
			}
            
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		} else {

            CellIdentifier = @"tiwtterCell";
            
            HomeCell *cell =(HomeCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            
            if (cell == nil) {
                
                cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            
            //cell.xian.frame = CGRectMake(10, cell.frame.size.height, 300, 2);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            YtTopic *topic = [remindListArry objectAtIndex:indexPath.row];
            
            if (topic != nil) {
                topic.tableView = tableView;
                topic.indexPath = indexPath;
                cell.status = topic;
                [cell update:tableView];	
                
            }
            else {
            }
            cell.homeCellDelegate = self;

            return cell;

		}
	}
	
	else if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_NOTICE) {
		
		if (indexPath.row == [noticeListArry count]) {
			
			CellIdentifier = @"noticeCellMore";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if(cell==nil){
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
            if (!noticeEnd) {
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    [cell spinnerStartAnimating];
                    [self performSelector:@selector(sendMoreNoticeListRequest) withObject:nil afterDelay:2.0];
                }
                
			}
            
			if (noticeMoreCell==nil) {
				noticeMoreCell =cell;	
			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		} else {
			
			MailList *list = [noticeListArry objectAtIndex:indexPath.row];
			CellIdentifier = @"noticeCell";
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (!cell) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                
//				UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 17, 19.5, 19)];
                UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 52, 24)];
//                newImage.image = UIImageGetImageFromName(@"NEW960.png");
                
//                newImage.image = UIImageGetImageFromName(@"weibo_notice.png");
                newImage.tag=10101;
                newImage.backgroundColor = [UIColor clearColor];
                [cell addSubview:newImage];
                [newImage release];
				//cell.imageView.image = UIImageGetImageFromName(@"pushmessage_cion.png");
                
//                UILabel *timelabe = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 110, 10)];
                UILabel *timelabe = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 110, 10)];
                [timelabe setBackgroundColor:[UIColor clearColor]];
                timelabe.textAlignment = NSTextAlignmentRight;
                [timelabe setTag:111];
                timelabe.font = [UIFont systemFontOfSize:11];
                timelabe.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
                [cell.contentView addSubview:timelabe];
                [timelabe release];
                
//                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height + 5, 300, 2)];
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, 320, 1)];
                xian.backgroundColor  = [UIColor clearColor];
                xian.image = UIImageGetImageFromName(@"SZTG960.png");
                [cell.contentView addSubview:xian];
                [xian release];
                
//                UILabel *mcoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 250, 30)];
                UILabel *mcoLabel = [[UILabel alloc] initWithFrame:CGRectMake(79, 27, 220, 30)];
                mcoLabel.text = list.mcontent;
//                mcoLabel.font = [UIFont systemFontOfSize:14];
                mcoLabel.font = [UIFont systemFontOfSize:15];
                mcoLabel.tag = 102;
                mcoLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:mcoLabel];
                [mcoLabel release];
                
                
#ifdef isCaiPiaoForIPad
                newImage.frame = CGRectMake(13, 17, 19.5, 19);
                timelabe.frame = CGRectMake(260, 5, 110, 10);
                xian.frame = CGRectMake(10, cell.frame.size.height + 5, 370, 2);
                mcoLabel.frame = CGRectMake(35, 12, 330, 30);
#endif


			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.contentView.backgroundColor = [UIColor clearColor];
//			cell.textLabel.font = [UIFont systemFontOfSize:14];
//			cell.textLabel.backgroundColor = [UIColor clearColor];
//			cell.textLabel.text = list.mcontent;
//            cell.textLabel.frame = CGRectMake(150, 20, 150, 30);            
            UILabel *view = (UILabel*)[cell.contentView viewWithTag:111];
            UILabel *labe2 = (UILabel *)[cell.contentView viewWithTag:102];
            labe2.text = list.mcontent;
            if (view) {
                [view setText:list.createDate];
            }
            
            UIImageView *nIma = (UIImageView *)[cell viewWithTag:10101];
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if([defaults objectForKey:list.ytMailId])
            {
                nIma.image = nil;
            }
            else
            {
                nIma.image = UIImageGetImageFromName(@"weibo_notice.png");
            }
			return cell;
		}
	} else if(segmentedControl.selectedSegmentIndex==MSG_TYPE_ATME){
		
		if(indexPath.row == [atMeListArry count]){
			
			CellIdentifier = @"atMeCellMore";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if(cell==nil){
				
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			}
            
            if (!atmeEnd) {
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    [cell spinnerStartAnimating];
                    [self performSelector:@selector(sendMoreAtmeListRequest) withObject:nil afterDelay:2.0];
                }
                
			}
			
			if (moreCellOfatme==nil) 
				moreCellOfatme = cell;
            
            if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
                cell.contentView.backgroundColor = [UIColor clearColor];
            } else {
                cell.contentView.backgroundColor = [UIColor clearColor];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		}else{
			CellIdentifier = @"atmeCell";
			
			HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if(cell==nil){
				
				cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
			
			YtTopic *topic = [atMeListArry objectAtIndex:indexPath.row];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			if (topic != nil) {
                topic.indexPath = indexPath;
                cell.status = topic;
                [cell update:tableView];
				
			}
            else {
                
            }
            cell.homeCellDelegate = self;
			return cell;
			
		
		
		}
		 
	   	
	}else if (segmentedControl.selectedSegmentIndex == MSG_TYPE_COMMENT) {
		
		if(indexPath.row == [commentListArry count]){
			
			CellIdentifier = @"commentCellMore";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if(cell==nil){
				
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
			}
            
            if (!commentLoadend) {
                if([tableView numberOfRowsInSection:indexPath.section] > 1){
                    [cell spinnerStartAnimating];
                    [self performSelector:@selector(sendMoreCommentListRequest) withObject:nil afterDelay:2.0];
                }
                
            }
            
			if (moreCell==nil) {
				
				moreCell = cell;
			}
            
            if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
                cell.contentView.backgroundColor = [UIColor clearColor];
            } else {
                cell.contentView.backgroundColor = [UIColor clearColor];
            }
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		
		}else {
			
			CellIdentifier = @"commentCell";
            YtTopic * topic = [commentListArry objectAtIndex:indexPath.row];

			HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				
				cell = [[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
        
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (topic)
            {
                topic.indexPath = indexPath;
                topic.reRequest = YES;
                cell.status = topic;
                [cell update:tableView];
            }
            
            
			return cell;		
		}
	} else {
		
		if (indexPath.row == [privateMessageArry count]) {
			
			CellIdentifier = @"privateMailCell";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell==nil){
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
            
            if (!privatalMailLoadend) {
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    [cell spinnerStartAnimating];
                    
                    [self performSelector:@selector(sendMorePrivatalMailRequest) withObject:nil afterDelay:2.0];
                    
                }
            }
		
			if(moreCellOfPrivatalMail==nil)
				
			   moreCellOfPrivatalMail = cell;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		} else {
			
			CellIdentifier = @"privateMail";
			
			FolloweeCell *cell = (FolloweeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				cell = [[[FolloweeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            cell.attButton.hidden = YES;
//            [cell setBaHiden];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
			MailList *mlist = [privateMessageArry objectAtIndex:[indexPath row]];
			if (mlist) {                
                Followee *followee = [[Followee alloc] init];
                followee.mTag = 8;
                if ([mlist.senderId isUserself]) {
                    followee.userId = mlist.recieverId;
                } else {
                    followee.userId = mlist.senderId;
                }
                followee.name = mlist.nickName;
				followee.vip = mlist.vip;
                followee.fansCount = mlist.mcontent;
                followee.time = mlist.createDate;
                if ([mlist.senderId isUserself] ) {
                    followee.imageUrl = mlist.recieverHead;
				} else {
                    followee.imageUrl = mlist.senderHead;
				}
                [cell setFollowee:followee];
                [followee release];
			}
//            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height + 5, 300, 2)];
//            xian.backgroundColor  = [UIColor clearColor];
//            xian.image = UIImageGetImageFromName(@"SZTG960.png");
//            [cell.contentView addSubview:xian];
//            [xian release];

            
			return cell;
		}
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 点击 释放 ,蓝色逐渐 消失
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	NSInteger row = [indexPath row];
	if(segmentedControl.selectedSegmentIndex == MSG_TYPE_REMIND){
		
		if (row ==[remindListArry count]) {
			
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			
			if (!remindEnd) {
                if ([cell isKindOfClass:[MoreLoadCell class]]) {
                    [(MoreLoadCell*)cell spinnerStartAnimating];
                }
				[self performSelector:@selector(sendMoreRemindListRequest) withObject:nil afterDelay:2.0];
			}
			
			
			
		}else {
			
//			MailList *list = [remindListArry objectAtIndex:indexPath.row];
//
//			NoticeViewController *noticeView = [[NoticeViewController alloc] initWithNoticeMessage:list];
//			
//			[self.navigationController pushViewController:noticeView animated:YES];
//			noticeView.title = @"提醒";
//			[noticeView release];
            
            YtTopic *topic = [remindListArry objectAtIndex:indexPath.row];
            
            DetailedViewController *detailedVC = [[DetailedViewController alloc] initWithMessage:topic];
            [self.navigationController pushViewController:detailedVC animated:YES];
            [detailedVC release];

			
		}
		
		
	}else if(segmentedControl.selectedSegmentIndex == MSG_TYPE_NOTICE){
		
		if (row ==[noticeListArry count]) {
			
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			
			if (!noticeEnd) {
                if ([cell isKindOfClass:[MoreLoadCell class]]) {
                    [(MoreLoadCell*)cell spinnerStartAnimating];
                }
				[self performSelector:@selector(sendMoreNoticeListRequest) withObject:nil afterDelay:2.0];
			}
			
			
			
		}else {
			
			MailList *list = [noticeListArry objectAtIndex:indexPath.row];
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"YES" forKey:list.ytMailId];
            [defaults synchronize];

			NoticeViewController *noticeView = [[NoticeViewController alloc] initWithNoticeMessage:list];
			
			[self.navigationController pushViewController:noticeView animated:YES];
			noticeView.title = @"通知";
			[noticeView release];
			
		}

	
	}else if(segmentedControl.selectedSegmentIndex == MSG_TYPE_ATME){// “@我”
		
		
		
		if (row < [atMeListArry count]) {// 点击 @我  列表 跳转到 微博详情 界面
			
			YtTopic *topic = [atMeListArry objectAtIndex:indexPath.row];
			
			[request clearDelegatesAndCancel];
			
			[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:topic.topicid]]] ;
			
			[request setDefaultResponseEncoding:NSUTF8StringEncoding];
			
			[request setDelegate:self];
			[request setDidFinishSelector:@selector(topicListByIdDataBack:)];
			
			[request setNumberOfTimesToRetryOnTimeout:2];
			
			// 异步获取
			[request startAsynchronous];
			
//			DetailedViewController *detailedViewController = [[DetailedViewController alloc] initWithMessage:topic];
//			
//			[detailedViewController setHidesBottomBarWhenPushed:YES];
//			
//			[self.navigationController pushViewController:detailedViewController animated:YES];
//			
//			[detailedViewController release];

		} else {
			
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			
			if (!atmeEnd) {
                if ([cell isKindOfClass:[MoreLoadCell class]]) {
                    [(MoreLoadCell*)cell spinnerStartAnimating];
                }
				[self performSelector:@selector(sendMoreAtmeListRequest) withObject:nil afterDelay:2.0];
			}
		}
	} else if (segmentedControl.selectedSegmentIndex== MSG_TYPE_COMMENT) {// 评论箱
		
		//NSInteger row = [indexPath row];
		
		if(row < [commentListArry count]) {
            
            YtTopic * comment = [commentListArry objectAtIndex:indexPath.row];
            
            self.commList = comment;
            
            if([CheckNetwork isExistenceNetwork]){
                
                [request clearDelegatesAndCancel];
                
                [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:self.commList.topicid]]] ;
                
                [request setDefaultResponseEncoding:NSUTF8StringEncoding];
                
                [request setDelegate:self];
                [request setDidFinishSelector:@selector(topicListByIdDataBack:)];
                
                [request setNumberOfTimesToRetryOnTimeout:2];
                
                // 异步获取
                [request startAsynchronous];
                
            }
            
          
		} else {
			
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			
			if([cell isKindOfClass:[MoreLoadCell class]]) {
				if (!commentLoadend) {
					[(MoreLoadCell*)cell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMoreCommentListRequest) withObject:nil afterDelay:2.0];
				}	
			}
		}
	} else {// 私信 
		
		//NSInteger row = [indexPath row];
		
		if (row== [privateMessageArry count]) {
			
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			
			if (cell && [cell isKindOfClass:[MoreLoadCell class]]) {
				if (!privatalMailLoadend) {
					
					[(MoreLoadCell*)cell spinnerStartAnimating];
					
					[self performSelector:@selector(sendMorePrivatalMailRequest) withObject:nil afterDelay:2.0];	
				}
			}
		} else {// 私信 列表 点击 
			
			UserListMailController *usersMail = [[UserListMailController alloc] initWithNibName:@"UserListMailController" bundle:[NSBundle mainBundle]];
			
			privatalMailLoadend = NO;
			MailList *mlist = [privateMessageArry objectAtIndex:row];
			
			usersMail.mList = mlist;
			
			if ([mlist.recieverId isUserself]) {
				
			    usersMail.senderId = mlist.senderId;
				
			} else 
				usersMail.senderId = mlist.recieverId;

			[usersMail setHidesBottomBarWhenPushed:YES];
			
			[self.navigationController pushViewController:usersMail animated:YES];
			
			[usersMail release];	
		}
	}
}

- (void)clikeOrderIdURL:(NSString *)request1 {
    NSString *url = [NSString stringWithFormat:@"%@",request1];
    if ([url hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",request1] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"]) {
            [autoRequest clearDelegatesAndCancel];
            [self setAutoRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [autoRequest setDelegate:self];
            [autoRequest setDidFinishSelector:@selector(requestWBXQFinished:)];
            [autoRequest setTimeOutSeconds:20.0];
            [autoRequest startAsynchronous];
            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];

            [self.navigationController pushViewController:info animated:YES];
            
            [info release];
            return;
        }
        
    }
    MyWebViewController *my = [[MyWebViewController alloc] init];
	
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
    [my LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:request1]]];
	[my release];
}

- (void)requestWBXQFinished:(ASIHTTPRequest *)request1{
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];

    [self.navigationController pushViewController:detailed animated:YES];
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}
//#pragma mark CP_liebiao delegate
//- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//
//    if (liebiaoView.tag == 105) {
//        
//        if (buttonIndex == 0)//查看微博
//        {
//            if([CheckNetwork isExistenceNetwork]){
//                
//                [request clearDelegatesAndCancel];
//                
//                [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:self.commList.topicid]]] ;
//                
//                [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//                
//                [request setDelegate:self];
//                [request setDidFinishSelector:@selector(topicListByIdDataBack:)];
//                
//                [request setNumberOfTimesToRetryOnTimeout:2];
//                
//                // 异步获取
//                [request startAsynchronous];
//                
//            }
//        }
//        else if (buttonIndex == 1)//回复此评论
//            {
//#ifdef isCaiPiaoForIPad
//                YtTopic *mRevert = [[YtTopic alloc] init];
//                mRevert.topicid = commList.ycid;
//                [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentRevert mStatus:mRevert];
//                [mRevert release];
//                
//#else
////                NewPostViewController *newd = [[NewPostViewController alloc] init];
////                newd.publishType = kCommentRevert;
////                
////                YtTopic *mRevert = [[YtTopic alloc] init];
////                mRevert.topicid = commList.ycid;
////                newd.mStatus = mRevert;
////                [self.navigationController pushViewController:newd animated:YES];
////                [mRevert release];
////                [newd release];
////
//                
//                
//                SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
//                publishController.microblogType = CommentRevert;
//                
//                YtTopic *mRevert = [[YtTopic alloc] init];
//                mRevert.topicid = commList.ycid;
//                publishController.mStatus = mRevert;
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
//                [self presentViewController:nav animated: YES completion:nil];
//                [publishController release];
//                [nav release];
//#endif
//                
//            }
//            
//        }
//
//    
//}
#pragma mark  UIActionSheet delegate
// 响应 UIActionSheet(操作表） 按钮
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	

	//if(buttonIndex!=[actionSheet cancelButtonIndex]){
    
    
		// 查看微博
		if (buttonIndex == 0) {
			
			if([CheckNetwork isExistenceNetwork]){
				
				[request clearDelegatesAndCancel];
				
			    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:self.commList.topicid]]] ;
				
				[request setDefaultResponseEncoding:NSUTF8StringEncoding];
				
				[request setDelegate:self];
				[request setDidFinishSelector:@selector(topicListByIdDataBack:)];
				
				[request setNumberOfTimesToRetryOnTimeout:2];
			
				// 异步获取
				[request startAsynchronous];
				
			}
			
		
		
		}else if (buttonIndex == 1)  {// 回复评论、
#ifdef isCaiPiaoForIPad
            YtTopic *mRevert = [[YtTopic alloc] init];
            mRevert.topicid = commList.ycid;
            [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentRevert mStatus:mRevert];
            [mRevert release];
            
#else
			
//			NewPostViewController *newd = [[NewPostViewController alloc] init];
//			newd.publishType = kCommentRevert;
//        
//            YtTopic *mRevert = [[YtTopic alloc] init];
//            mRevert.topicid = commList.ycid;
//			newd.mStatus = mRevert;
//            [self.navigationController pushViewController:newd animated:YES];
//            [mRevert release];
//            [newd release];

            SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
            publishController.microblogType = CommentRevert;
            
            YtTopic *mRevert = [[YtTopic alloc] init];
//            publishController.topicid = commList.ycid;
            publishController.mStatus = mRevert;
            [mRevert release];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
            [self presentViewController:nav animated: YES completion:nil];
            [publishController release];
            [nav release];
#endif
		}else{
        
        }

	
//	}else  {
//		
//		[actionSheet canResignFirstResponder];
//		
//		
//    }
	
}


// “评论箱”获取 帖子详情 数据
-(void)topicListByIdDataBack:(ASIHTTPRequest*)mrequest{

	NSString *responseString= [mrequest responseString];
	
	if (responseString) {
		
		YtTopic *commentTopic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([commentTopic.arrayList count]>0) {
			
			YtTopic *topic = [commentTopic.arrayList objectAtIndex:0];
			
			DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:topic];
			
			[detailed setHidesBottomBarWhenPushed:YES];
			
			[self.navigationController pushViewController:detailed animated:YES];
			
			[detailed release];

		}
        
        [commentTopic release];

	}
	
	

}

// 请求 提醒 通知数据 
-(void)sendMoreRemindListRequest{
	
	[request clearDelegatesAndCancel];
	
//	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] 
//																	userId2:@"0" 
//																	pageNum:[self loadedCount]
//																   pageSize:@"20"
//																   mailType:@"1" 
//																	   mode:@"1"]]];
    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTopicByUserId:@"549675" pageNum:[self loadedCount] pageSize:@"20"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(moreremindListDataBackData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取	
	
}


// 请求 更多 通知数据 
-(void)sendMoreNoticeListRequest{

	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] 
																	userId2:@"0" 
																	pageNum:[self loadedCount]
																   pageSize:@"20"
																   mailType:@"1" 
																	   mode:@"0"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(morenotieListDataBackData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取	

}


//  “更多” 评论箱 请求 
-(void)sendMoreCommentListRequest {

	if([CheckNetwork isExistenceNetwork]){
		
		[request clearDelegatesAndCancel];
		
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetCommentList:[[Info getInstance]userId] pageNum:[self loadedCount] pageSize:@"20"]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(morecommentListLoadingTableViewData:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
		
		// 异步获取
		[request startAsynchronous];
		
		
	}
	


}


// 更多 "@ 我"  请求
-(void)sendMoreAtmeListRequest{
	
	if([CheckNetwork isExistenceNetwork]){
		
		[request clearDelegatesAndCancel];
		
	    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetAtmeTopicList:[[Info getInstance]userId] pageNum:[self loadedCount] pageSize:@"20"]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(atMeListDataOfMore:)];
		
		[request setNumberOfTimesToRetryOnTimeout:2];
	
		// 异步获取
		[request startAsynchronous];
		
	
	
	
	}

}


// 更多 “私信 ” 请求
-(void)sendMorePrivatalMailRequest{
	
	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMailList:[[Info getInstance]userId] pageNum:[self loadedCount] pageSize:@"20"]]] ;
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[request setDelegate:self];
	
	[request setDidFinishSelector:@selector(MorePrivatalMailLoadingTableViewData:)];
	
	[request setNumberOfTimesToRetryOnTimeout:2];
	
	[request startAsynchronous];
	


}

// 更多 提醒 返回 数据 接收
-(void)moreremindListDataBackData:(ASIHTTPRequest*)mrequest{
	
    NSString * responseString =[mrequest responseString];
	
	if(responseString){
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (remindListArry) {
				
				[remindListArry addObjectsFromArray:topic.arrayList];
				
			}
            [topic release];
            
            [myTableView reloadData];
			
		}else {
			
			[remindMoreCell setType:MSG_TYPE_LOAD_NODATA];
           			noticeEnd = YES;
		}
        
        
//		[topic release];
		
//		[myTableView reloadData];
		
        
	}
	
	[remindMoreCell spinnerStopAnimating];
	
	fristremindMore = NO;
	caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hidenMessage];

	if (remindMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [remindMoreCell spinnerStopAnimating];
        [remindMoreCell setInfoText:@"加载完毕"];

    }
	
}


//-(void)moreremindListDataBackData:(ASIHTTPRequest*)mrequest{
//	
//	NSString *responseString = [mrequest responseString];
//	if(responseString){
//		
//		MailList *maillist = [[MailList alloc]initWithParse:responseString];
//	
//		if ([maillist.arryList count]>0) {
//			
//			if (remindListArry) {				
//				[remindListArry addObjectsFromArray:maillist.arryList];
//			}
//			
//		}else{
//			[remindMoreCell setType:MSG_TYPE_LOAD_NODATA];
//			
//			noticeEnd = YES;
//			
//		}
//		
//		[maillist release];
//		
//		[myTableView reloadData];
//		
//		[remindMoreCell spinnerStopAnimating];
//		
//		fristremindMore = NO;
//        
//        
//	}
//    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appdelegate hidenMessage];
//}


// 更多 通知 返回 数据 接收
-(void)morenotieListDataBackData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	
	if(responseString){
		
		MailList *maillist = [[MailList alloc]initWithParse:responseString];
		
		if ([maillist.arryList count]>0) {
			
			if (noticeListArry) {				
				[noticeListArry addObjectsFromArray:maillist.arryList];
			
			}
            
            [myTableView reloadData];
		
		}else{
			[noticeMoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			noticeEnd = YES;
           
		}
		
		[maillist release];
		
//		[myTableView reloadData];
		
		[noticeMoreCell spinnerStopAnimating];
		
		fristnoticeMore = NO;
		
		
	
	}
	
    if (noticeMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [noticeMoreCell spinnerStopAnimating];
        [noticeMoreCell setInfoText:@"加载完毕"];
        
    }


}



// 更多 “@我” 请求数据 接收
-(void)atMeListDataOfMore:(ASIHTTPRequest*)mrequest{
	
   NSString * responseString =[mrequest responseString];
	
	if(responseString){
		
		YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
		
		if ([topic.arrayList count]>0) {
			
			if (atMeListArry) {
				
				[atMeListArry addObjectsFromArray:topic.arrayList];
				
			}
            [myTableView reloadData];
			
		}else {
			
			[moreCellOfatme setType:MSG_TYPE_LOAD_NODATA];
           
			atmeEnd = YES;
		}
	
	
		[topic release];
		
//		[myTableView reloadData];
		
	
	}
	
	[moreCellOfatme spinnerStopAnimating];
	
	fristLoadingAtme = NO;
	if (moreCellOfatme.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCellOfatme spinnerStopAnimating];
        [moreCellOfatme setInfoText:@"加载完毕"];
        
    }

	
	
}




//  “更多”－ 评论箱 数据 请求接收
-(void)morecommentListLoadingTableViewData:(ASIHTTPRequest*)mrequest{
	
	
	NSString * responseString =[mrequest responseString];
	
	if(responseString){
		
		CommentList *commentlist = [[CommentList alloc] initWithParse:responseString];
		
		
		if([commentlist.arrayList count] >0){
			
			if(commentListArry)
            {
                
				[commentListArry addObjectsFromArray:commentlist.arrayList];
            }
            
            [myTableView reloadData];
		
		}else {
			
		 [moreCell setType:MSG_TYPE_LOAD_NODATA];	
		 commentLoadend = YES;
           
		}

		[commentlist release];
		
//		[myTableView reloadData];
		
		
	
	}
	
	[moreCell spinnerStopAnimating];
	
	fristLoadingMore =NO;
    
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
        
    }


}



// 更多  “私信” 请求 数据 接收
-(void)MorePrivatalMailLoadingTableViewData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
	NSLog(@"res = %@", responseString);
	if(responseString){
		
		MailList *mList = [[MailList alloc]initWithParse:responseString];
		
		if ([mList.arryList count]>0) {
			
			if (privateMessageArry) {
				
				[privateMessageArry addObjectsFromArray:mList.arryList];
				
			}
            
            [myTableView reloadData];
			
		}else {
			
			[moreCellOfPrivatalMail setType:MSG_TYPE_LOAD_NODATA];
			privatalMailLoadend = YES;
            
		}

		[mList release];
		
//		[myTableView reloadData];
		
		
	}
	
	[moreCellOfPrivatalMail spinnerStopAnimating];
	fristLoadingPrvivatalMail = NO;
	
    if (moreCellOfPrivatalMail.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCellOfPrivatalMail spinnerStopAnimating];
        [moreCellOfPrivatalMail setInfoText:@"加载完毕"];
        
    }
}



// 得到 累加的  pageNum
-(NSString *)loadedCount{
	caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate hidenMessage];
	NSString *count;
	
	if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_REMIND) {
		
		if (fristremindMore) {
			
			remindCount =1;
			
		}
		remindCount++;
		
		NSNumber *num = [[NSNumber alloc] initWithInteger:remindCount];
		
		count = [num stringValue];
		
		[num release];
		
		
	}else if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_NOTICE) {
		
		if (fristnoticeMore) {
			
			noticeCount =1;
			
		}
		noticeCount++;
		
		NSNumber *num = [[NSNumber alloc] initWithInteger:noticeCount];
		
		count = [num stringValue];
		
		[num release];
		
		
	}else if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_ATME) {
		
		if (fristLoadingAtme) {
			
			atmeLoadCount = 1;
			
		}
		
		atmeLoadCount++;
		
		
		NSNumber *num = [[NSNumber alloc] initWithInteger:atmeLoadCount];
		
		count = [num stringValue];
		
		[num release];
		
		
	}else if (segmentedControl.selectedSegmentIndex ==MSG_TYPE_COMMENT) {
		
		if (fristLoadingMore) {
			
			commentLoadedCount = 1;
		}
		
		commentLoadedCount ++;
		
		NSNumber *num = [[NSNumber alloc] initWithInteger:commentLoadedCount];
		
		count = [num stringValue];
		
		[num release];
		
	}else {
		
		if (fristLoadingPrvivatalMail) {
			
			privatalMailCount =1;
		}
		privatalMailCount++;
		
		NSNumber *num = [[NSNumber alloc] initWithInteger:privatalMailCount];
		
		count = [num stringValue];
		
		[num release];
		
	}

		
	
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
	self.segmentedControl =nil;
	self.atMeListArry = nil;
	self.commentListArry = nil;
	self.privateMessageArry =nil;
	self.noticeListArry =nil;
	self.remindListArry = nil;
	_refreshHeaderView =nil;
	self.request =nil;
	self.commList=nil;
	moreCell= nil;
	moreCellOfatme = nil;
	moreCellOfPrivatalMail =nil;
	noticeMoreCell =nil;
	

}


- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leixingbiaoji" object:nil];
    [second release];
//    [dianimage1 release];
//    [dianimage2 release];
//    [dianimage3 release];
//    [dianimage4 release];
//    [dianimage5 release];
	[myTableView release];
//	[_refreshHeaderView release];
	_refreshHeaderView = nil;
	[request clearDelegatesAndCancel];
	[lineimage release];
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
	[request release];
	
	[commList release];
	
	[segmentedControl release];
	
	[noticeListArry release];
	[remindListArry release];
	
	[atMeListArry release];
	
	[commentListArry release];
	
	[privateMessageArry release];
    
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
            Info *info = [Info getInstance];
            if (![info.userId intValue]) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"登录后可用"];
                return;
            }
            
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
    HomeCell * homeCell = (HomeCell *)[myTableView cellForRowAtIndexPath:ytTopic.indexPath];
    
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
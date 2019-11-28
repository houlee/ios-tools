//
//  PreJiaoDianTabBarController.m
//  caibo
//
//  Created by  on 12-7-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "PreJiaoDianTabBarController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MyProfileViewController.h"
#import "Info.h"
#import "NewPostViewController.h"
#import "CheckNewMsg.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "LoginViewController.h"
#import "DetailedViewController.h"
#import "MessageViewController.h"
#import "SendMicroblogViewController.h"


@implementation PreJiaoDianTabBarController
@synthesize haoyoubadge, xiaoxibadge, ziliaobadge, hybadgeValue, zlbadgeValue, xxbadgeValue;

static PreJiaoDianTabBarController *instance;

+ (PreJiaoDianTabBarController *) getShareDetailedView {
    return instance;
}
-(id)initWithUerself:(BOOL)userself userID:(NSString*)userId{
	
	if ((self = [super init])) {
        
        
      //  [self.tabBar setBackgroundImage:UIImageGetImageFromName(@"xiamiantab.png")];
     //   self.tabBar.frame = CGRectMake(0, 442, 320, 38);
	//	self.tabBar.layer.contents = (id)UIImageGetImageFromName(@"xiamiantab.png").CGImage;
     //   self.tabBar.backgroundColor = [UIColor clearColor];
		//self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
		self.view.frame = [caiboAppDelegate getAppDelegate].window.bounds;
		self.delegate = self;
    
		HomeViewController * home = [[HomeViewController alloc] initWithBool:YES];
        home.dajiabool = YES;
        home.title = @"广场";
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:home];
        
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
            [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
            
#endif
//            [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        }

        NewsViewController * news = [[NewsViewController alloc] init];
        news.title = @"新闻";
        [news.navigationController setNavigationBarHidden:YES];
        
        HomeViewController * mygz = [[HomeViewController alloc] initWithBool:NO];
        mygz.dajiabool = NO;
        [mygz.navigationController setNavigationBarHidden:YES];
        mygz.title = @"好友";
        
        MessageViewController * mvc = [[MessageViewController alloc] init];
        mvc.title = @"消息";
        
        
        MyProfileViewController * mypro = [[MyProfileViewController alloc] init];
        mypro.title = @"资料";
        [mypro.navigationController setNavigationBarHidden:YES];
		NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:nav, news, mygz, mvc, mypro, nil];

		self.viewControllers = controllers;
        
        [nav release];
        [home release];
        [news release];
        [mygz release];
        [mvc release];
        [mypro release];
		[controllers release];
		self.hidesBottomBarWhenPushed = YES;	
		
		
	}	
	
    
	return self;
    
}




/***
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 
 
 }
 ***/




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    counhaoyou = 0;
    con = 6;
    Info *info1 = [Info getInstance];
    if ([info1.userId intValue]) {
        counttag = 0;
        self.navigationItem.title = @"广场";
    }else{
        
        counttag = 1;  
        self.navigationItem.title = @"新闻";
    }
    
    
	
	// 自定义 返回 按钮
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(backAction)];   
	self.navigationItem.leftBarButtonItem = leftItem;  
//    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"写微博" Target:self action:@selector(pressWriteButton:)];
//    [self.navigationItem setRightBarButtonItem:rightItem];
//    [rightItem release];
    
      
    haoyoubadge = [[UIImageView alloc] initWithFrame:CGRectMake(172, -2, 19, 18)];
    haoyoubadge.backgroundColor = [UIColor clearColor];
    haoyoubadge.image = UIImageGetImageFromName(@"wb_huizhang.png");
    
    xiaoxibadge = [[UIImageView alloc] initWithFrame:CGRectMake(236, -2, 19, 18)];
    xiaoxibadge.backgroundColor = [UIColor clearColor];
    xiaoxibadge.image = UIImageGetImageFromName(@"wb_huizhang.png");
    
    ziliaobadge = [[UIImageView alloc] initWithFrame:CGRectMake(300, -2, 19, 18)];
    ziliaobadge.backgroundColor = [UIColor clearColor];
    ziliaobadge.image = UIImageGetImageFromName(@"wb_huizhang.png");
    
    hybadgeValue = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 19, 13)];
    hybadgeValue.backgroundColor = [UIColor clearColor];
    hybadgeValue.font= [UIFont systemFontOfSize:11];
    hybadgeValue.textColor = [UIColor whiteColor];
    hybadgeValue.textAlignment = NSTextAlignmentCenter;
   // hybadgeValue.text = @"99";
    
    xxbadgeValue = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 19, 13)];
    xxbadgeValue.backgroundColor = [UIColor clearColor];
    xxbadgeValue.font= [UIFont systemFontOfSize:11];
    xxbadgeValue.textColor = [UIColor whiteColor];
    xxbadgeValue.textAlignment = NSTextAlignmentCenter;
   // xxbadgeValue.text = @"3";
    
    zlbadgeValue = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 19, 13)];
    zlbadgeValue.backgroundColor = [UIColor clearColor];
    zlbadgeValue.font= [UIFont systemFontOfSize:11];
    zlbadgeValue.textColor = [UIColor whiteColor];
    zlbadgeValue.textAlignment = NSTextAlignmentCenter;
   // zlbadgeValue.text = @"1";
    
    haoyoubadge.hidden = YES;
    xiaoxibadge.hidden = YES;
    ziliaobadge.hidden = YES;

    [haoyoubadge addSubview:hybadgeValue];
    [xiaoxibadge addSubview:xxbadgeValue];
    [ziliaobadge addSubview:zlbadgeValue];
    [self.tabBar addSubview:haoyoubadge];
    [self.tabBar addSubview:xiaoxibadge];
    [self.tabBar addSubview:ziliaobadge];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeAction) name:@"hometozhuye" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAction) name:@"backaction" object:nil];
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

//// 跳会到首页
-(void)homeAction
{	
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)backAction
{
    
	[self.navigationController popViewControllerAnimated:YES];
    
}

// 点击写微博 按钮
-(void)pressWriteButton:(id)sender { 
//	NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
}
#pragma mark UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        

        if (counttag == 0) {
            tabBarController.selectedIndex = 0;
        }else{
            tabBarController.selectedIndex = 1;
        }
    }else{
        if (tabBarController.selectedIndex != 3) {
            UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_xie.png");
            
            rigthItem.bounds = CGRectMake(150, 12, 23, 24);
            
            [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
            [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
            
            
            self.navigationItem.rightBarButtonItem = rigthItemButton;
            [rigthItemButton release];

        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
                
        
        if (tabBarController.selectedIndex == 0) {
           // tabBarController.selectedIndex = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinhan" object:nil];
            
        }
        else if(tabBarController.selectedIndex == 2){
          //  tabBarController.selectedIndex = 2;
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            
            UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
            NSArray * views = a.viewControllers;
            if ([views count] >= 2) {
                PreJiaoDianTabBarController *c = [views objectAtIndex:1];
                if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                    //                NSArray * viewss = c.viewControllers;
                    
                    //UIViewController * cnav = [c.viewControllers objectAtIndex:2];
                    //cnav.tabBarItem.badgeValue = nil;
                    c.haoyoubadge.hidden = YES;
                    c.hybadgeValue.text = @"";
                    
                    //NSInteger zongcout = atme + pl  + sx + tz;
                    //                if (zongcout > 99) {
                    //                    cnav.tabBarItem.badgeValue = @"99";
                    //                }else{
                    //                    cnav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", zongcout];
                    //                }
                    
                    
                    
                }
            }

                       
            if (counhaoyou != 0) {
             //   [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinhan" object:nil];
            }
            counhaoyou += 1;
             
        }
    
    }
    
    
    if (tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 2) {
        
        
        selectedTab = (int)tabBarController.selectedIndex;
        
        if (selectedTab == 0 ) {
            if (selectedTab == con) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:nil];
                
            }
        }
        if (selectedTab ==2) {
            if (selectedTab == con) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"haoyourefreshWeibo" object:nil];
                
            }
        }

        
      //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressRefreshButton:) name:@"haoyourefreshWeibo" object:nil];
        
        con = selectedTab;
    }
   
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
	if (item.tag == 0) 
        {
		self.navigationItem.title =@"广场";
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        }
    else if(item.tag == 1) 
        {
		self.navigationItem.title = @"新闻";
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        }
    else if (item.tag == 2)
        {
            
            Info *info1 = [Info getInstance];
            if ([info1.userId intValue]) {
                
                self.navigationItem.title = @"好友";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                if (counttag == 0) {
                    self.navigationItem.title = @"广场";
                     [self.navigationController setNavigationBarHidden:YES animated:NO];
                }else{
                    self.navigationItem.title = @"新闻";
                    [self.navigationController setNavigationBarHidden:NO animated:NO];
                }
                
                
           
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                cai.gaodian = YES;
                
                [cai showMessage:@"登录后可用"];
                cai.gaodian = NO;
            }
        }
    else if(item.tag == 3){
    
        Info *info1 = [Info getInstance];
        if ([info1.userId intValue]) {
            self.navigationItem.title = @"消息";
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }else{
            if (counttag == 0) {
                self.navigationItem.title = @"广场";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                self.navigationItem.title = @"新闻";
                [self.navigationController setNavigationBarHidden:NO animated:NO];
            }
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            cai.gaodian = YES;
            [cai showMessage:@"登录后可用"];
            cai.gaodian = NO;
            
        }

    
    }else if (item.tag == 4) 
        {
            Info *info1 = [Info getInstance];
            if ([info1.userId intValue]) {
                self.navigationItem.title = @"资料";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                if (counttag == 0) {
                    self.navigationItem.title = @"广场";
                     [self.navigationController setNavigationBarHidden:YES animated:NO];
                }else{
                    self.navigationItem.title = @"新闻";
                    [self.navigationController setNavigationBarHidden:NO animated:NO];
                }
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                cai.gaodian = YES;
                [cai showMessage:@"登录后可用"];
                cai.gaodian = NO;

            }
                       
        }
    
    if (item.tag < 2) {
         counttag = item.tag;
    }
   
    
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return NO;
 }
 */

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hidenMessage];
   // caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [appdelegate.keFuButton calloff];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Info *info2 = [Info getInstance];
    if (![info2.userId intValue]) {
        //		UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"注册" Target:self action:@selector(doRegister)];
        //		[self.navigationItem setLeftBarButtonItem:leftItem];
        //		[leftItem release];
        //        UIButton * buttxie = (UIButton *)[self.navigationItem.titleView viewWithTag:99];
        //        buttxie.hidden = YES;
        //        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
        //        self.navigationItem.leftBarButtonItem = leftItem;  
        //        [leftItem release];
		UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
        [self.navigationItem setRightBarButtonItem:rightItem];
	}
	else {
        if (self.selectedIndex != 3) {
            UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_xie.png");
            
            rigthItem.bounds = CGRectMake(150,12, 23, 24);
            
            [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
            [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
            
            self.navigationItem.rightBarButtonItem = rigthItemButton;
            [rigthItemButton release];
        }
        
        
    }
    
    if ( self.selectedIndex == 4) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    }
    
//       if (self.selectedIndex == 0 || self.selectedIndex == 2) {
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"shuantab" object:nil];
//    }

    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
    

}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
	//self.messageViewController = nil;
	
//	self.twitterMessageController =nil;
    
}


- (void)dealloc {
	[hybadgeValue release];
    [zlbadgeValue release];
    [xxbadgeValue release];
    [haoyoubadge release];
    [ziliaobadge release];
    [xiaoxibadge release];
//	[twitterMessageController release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
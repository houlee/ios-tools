    //
//  ProfileTabBarController.m
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileTabBarController.h"
#import "HomeViewController.h"
#import "caiboAppDelegate.h"
#import "Info.h"

#import "YtTopic.h"
#import "NSStringExtra.h"
#import "HomeCell.h"
#import "SachetViewController.h"

@implementation ProfileTabBarController

@synthesize twitterMessageController;

-(id)initWithUerself:(BOOL)userself userID:(NSString*)userId {
    self = [super init];
	if (self) {
		
		//self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
		self.view.frame = [caiboAppDelegate getAppDelegate].window.bounds;
		self.delegate = self;
		
		
		TwitterMessageViewController *messageController = [[TwitterMessageViewController alloc] init];
		
		messageController.userID = userId;
		
		
		TopicViewController *topController = [[TopicViewController alloc] init];
		
		topController.userID = userId;
		
		
		CollectViewController *collController = [[CollectViewController alloc] init];
		
		
		FansViewController *fansController = [[FansViewController alloc] init];
		fansController.rightbut = YES;
        
		fansController.userID = userId;
		
		
		AttentionViewController *attentController= [[AttentionViewController alloc] init];
		
		
		attentController.userID = userId;
		
        
		NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:messageController,topController,fansController,attentController,nil];
		
		if (userself) {
			
			[controllers insertObject:collController atIndex:2];
			
		}
		
		self.viewControllers = controllers;
		
        
		[messageController release];
		
		[topController release];
		
		[collController release];
		
		[fansController release];
		
		[attentController release];
		
		[controllers release];
		
		self.hidesBottomBarWhenPushed = YES;	
		
		
	}	
	
    
	return self;
}

-(id)initwithUerself:(BOOL)userself userID:(NSString*)userId{
    self = [super init];
	if (self) {
		
		//self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
		self.view.frame = [caiboAppDelegate getAppDelegate].window.bounds;
		self.delegate = self;
		
		
		TwitterMessageViewController *messageController = [[TwitterMessageViewController alloc] init];
		
		messageController.userID = userId;
		
		
		TopicViewController *topController = [[TopicViewController alloc] init];
		
		topController.userID = userId;
		
		
		CollectViewController *collController = [[CollectViewController alloc] init];
		
		
		FansViewController *fansController = [[FansViewController alloc] init];
		
        
		fansController.userID = userId;
		
		
		AttentionViewController *attentController= [[AttentionViewController alloc] init];
		
		
		attentController.userID = userId;
		
        
		NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:messageController,topController,fansController,attentController,nil];
		
		if (userself) {
			
			[controllers insertObject:collController atIndex:2];
			
		}
		
		self.viewControllers = controllers;
		
        
		[messageController release];
		
		[topController release];
		
		[collController release];
		
		[fansController release];
		
		[attentController release];
		
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
    
    self.navigationItem.title = @"微博";
	
	// 自定义 返回 按钮
    UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"取 消" Target:self action:@selector(backAction)];
	[self.navigationItem setLeftBarButtonItem:leftItem];
	
    UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(homeAction)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

-(void)backAction
{
    
	[self.navigationController popViewControllerAnimated:YES];

}

// 跳会到首页
-(void)homeAction
{	
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

#pragma mark UITabBarDelegate


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	if (item.tag == 0) 
    {
		self.navigationItem.title =@"微博";
	}
    else if(item.tag == 1) 
    {
		self.navigationItem.title = @"话题";
	}
    else if (item.tag == 2)
    {
		self.navigationItem.title = @"收藏";
	}
    else if (item.tag == 3) 
    {
		self.navigationItem.title = @"粉丝";
	}
    else if (item.tag == 4) 
    {
		self.navigationItem.title = @"关注";
	}
}



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
    
	//self.messageViewController = nil;
	
	self.twitterMessageController =nil;

}


- (void)dealloc {
	
	[twitterMessageController release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  TopicViewController.m
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TopicViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "ListYtThemeGz.h"
#import "CheckNetwork.h"
#import "TopicThemeListViewController.h"
#import "YtTopic.h"
#import "NSStringExtra.h"
#import "ProfileImageCell.h"
#import "Info.h"

@implementation TopicViewController

@synthesize themeVec;
@synthesize userID;
@synthesize request;

#pragma mark -
#pragma mark View lifecycle

- (id)init
{
	if ((self=[super init]))
    {
		UITabBarItem *topicItem = [[UITabBarItem alloc] initWithTitle:@"话题" image:UIImageGetImageFromName(@"icon_person_topic.png") tag:1];
		self.tabBarItem = topicItem;
		[topicItem release];
	}
	return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	result = NO;
    self.CP_navigation.title = @"话题";
    
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(backAction)];
    self.CP_navigation.leftBarButtonItem = leftItem;
//    UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(homeAction)];
//    [self.CP_navigation setRightBarButtonItem:rightItem];
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
    myTableview = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    myTableview.delegate = self;
    myTableview.dataSource = self;
    myTableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.mainView addSubview:myTableview];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	if ([CheckNetwork isExistenceNetwork]&&!themeVec)
    {
		[request clearDelegatesAndCancel];
        
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtThemeGz:self.userID]]];
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
	if (responseString)
    {
		ListYtThemeGz *ytThemegz = [[ListYtThemeGz alloc] initWithParse:responseString];
		if (ytThemegz.result)
        {
            result = YES;
		}
        else
        {
			result = NO;
			self.themeVec = ytThemegz.arryList;
		}
		[ytThemegz release];
	}
	[myTableview reloadData];
}



/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return NO;
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger count = [themeVec count];
    return (!count)?1:count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font =[UIFont systemFontOfSize:16];
    }
    
    if (result)
    {
        cell.textLabel.text = @"暂时没有收藏话题";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        ListYtThemeGz *list = [themeVec objectAtIndex:indexPath.row];
        cell.textLabel.text = list.name;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (!result)
    {
		ListYtThemeGz *list = [themeVec objectAtIndex:indexPath.row];
		TopicThemeListViewController *themeTopic = [[TopicThemeListViewController alloc] initWithUserId:self.userID themeId:list.themeId themeName:list.name];
		[self.navigationController pushViewController:themeTopic animated:YES];
		[themeTopic release];
	}
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
}


- (void)dealloc
{
	[request clearDelegatesAndCancel];
	[request release];
    [myTableview release];
	[userID release];
    [themeVec release];
    
    [super dealloc];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
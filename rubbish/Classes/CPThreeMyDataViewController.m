//
//  CPThreeMyDataViewController.m
//  caibo
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "CPThreeMyDataViewController.h"
#import "Info.h"
#import "NetURL.h"

@implementation CPThreeMyDataViewController
@synthesize request;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.navigationItem.leftBarButtonItem = leftItem; 
    
    UIBarButtonItem *rightItem = [Info homeItemTarget:self action:@selector(gouToHome)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    myTabelView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    myTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    [self.view addSubview:myTabelView];
    [self sendCommentListRequest:@"1" pageSize:@"20"];
}

-(void)sendCommentListRequest:(NSString*)pageNum pageSize:(NSString*)pigeSize{
	
	[request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetCommentList:[[Info getInstance]userId] pageNum:pageNum pageSize:pigeSize]]] ;
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(commentListLoadingTableViewData:)];
    
	[request setNumberOfTimesToRetryOnTimeout:2];
    
	// 异步获取
	[request startAsynchronous];
    
}


- (void)gouToHome{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    
    if (indexPath.section == 0) {
        NSInteger rowIndex = indexPath.row;
        if (rowIndex == 0) {
//            UIView *leftView = [Info getCellView:(rowIndex) :(leftPosition) :(nil)];
//            [cell.contentView addSubview:leftView];
//            [leftView release];
//            
//            btnAttention = [leftView.subviews objectAtIndex:0];
//            [btnAttention addTarget:self action:@selector(pushAttentionView) forControlEvents:(UIControlEventTouchUpInside)];
//            
//            lbAttentionNum = [leftView.subviews objectAtIndex:1];
//            [lbAttentionNum setText:(mUserInfo.attention)];
//            
//            UIView *rightView = [Info getCellView:(rowIndex) :(rightPosition) :(nil)];
//            [cell.contentView addSubview:rightView];
//            [rightView release];
//            
//            btnBlog = [rightView.subviews objectAtIndex:0];
//            [btnBlog addTarget:self action:@selector(pushBlogView) forControlEvents:(UIControlEventTouchUpInside)];
//            
//            lbBlogNum = [rightView.subviews objectAtIndex:1];
//            [lbBlogNum setText:(mUserInfo.topicsize)];
        }
        
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"我发表的";
            
        }else if (indexPath.row == 1){
        
            cell.textLabel.text = @"我收藏的";
            
        }else if (indexPath.row == 2){
        
            cell.textLabel.text = @"评论我的";
            
        }else if (indexPath.row == 3){
            
            cell.textLabel.text = @"@我的";
            
        }else if (indexPath.row == 4){
        
            cell.textLabel.text = @"私信";
        
        }
        
        
    }else if(indexPath.section == 2){
    
        if (indexPath.row == 0) {
             
            cell.textLabel.text = @"修改头像";
            
        }else if (indexPath.row == 1){
        
            cell.textLabel.text = @"退出登录";
            
        }
        
    }
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)dealloc{
    [request clearDelegatesAndCancel];
    [request release];
    [myTabelView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
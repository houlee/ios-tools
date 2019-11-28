//
//  HotYtThemeViewController.m
//  caibo
//
//  Created by jacob on 11-6-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotYtThemeViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "CheckNetwork.h"
#import "YtTheme.h"

#import "MoreLoadCell.h"
#import "OtherYtTopicsViewController.h"

#import "TopicThemeListViewController.h"
#import "Info.h"


@implementation HotYtThemeViewController

@synthesize hotYtThemeListarry;

@synthesize request;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	fristLoading = YES;
	topicLoadedEnd = NO;
	
	self.navigationItem.title = @"热门话题";
	
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
	
}

-(void)backAction{
	
	[self.navigationController popViewControllerAnimated:YES];
	


}



- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
	
	if ([CheckNetwork isExistenceNetwork]&&!hotYtThemeListarry) {
		
	    [request clearDelegatesAndCancel];
		
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTheme:@"1" pageSize:@"20"]]];;
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(doneLoadingTableViewData:)];
		
		[ request setNumberOfTimesToRetryOnTimeout:2 ];

		// 异步获取
		[request startAsynchronous];
		
	}
	
}


-(void)doneLoadingTableViewData:(ASIHTTPRequest*)mrequest{

	NSString *responseString= [mrequest responseString];

   if (responseString) {
	   
	  YtTheme *list = [[YtTheme alloc] init];
	   
	  NSMutableArray *listarry = [list arrayWithParse:responseString];
	   
	   if (!hotYtThemeListarry) {
		   
		   self.hotYtThemeListarry =listarry;
		   
	   }
	   
	   [list release];
	   
	   [self.tableView reloadData];
	
    }
	


}

#pragma mark scrollView delegate
// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.tableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!topicLoadedEnd){
			if (moreCell) {
				[moreCell spinnerStartAnimating];
				
				[self performSelector:@selector(sendMoreYtThemeRequest) withObject:nil afterDelay:.5];
				
			}
		}
	}	
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSInteger  count = [hotYtThemeListarry count];
	
	return (!count)? count:count+1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 50;    
}




// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier;
	
	if (indexPath.row == [hotYtThemeListarry count]) {
		
		CellIdentifier =@"moreCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell==nil) {
			
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
		}
		
		if (moreCell==nil) {
			
			moreCell = cell;
			
		}
        
        if (!topicLoadedEnd) {
			if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [moreCell spinnerStartAnimating];
                
                [self performSelector:@selector(sendMoreYtThemeRequest) withObject:nil afterDelay:.5];
            }
			
		}
		
		return cell;
		
	}else {
		
		
		CellIdentifier = @"YtCell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil) {
			
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		cell.textLabel.font = [UIFont systemFontOfSize:15];
		
		cell.textLabel.textAlignment = NSTextAlignmentLeft;
		
		YtTheme *ytTheme = [hotYtThemeListarry objectAtIndex:indexPath.row];
		
		if (ytTheme) 
        {
			cell.textLabel.text = ytTheme.ytname;
		}
		return cell;
	}
	return nil;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
	
	if (indexPath.row ==[hotYtThemeListarry count]) {
		
		if (!topicLoadedEnd) {
			
			[moreCell spinnerStartAnimating];
			
			[self performSelector:@selector(sendMoreYtThemeRequest) withObject:nil afterDelay:.5];			
			
			
		}
		
		
	}
    else 
    {//  热门话题列表跳转到获取发帖列表
		YtTheme *theme = [hotYtThemeListarry objectAtIndex:indexPath.row];
        TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:theme.ytThemeId themeName:theme.ytname];
		[self.navigationController pushViewController:topicThemeListVC animated:YES];
		[topicThemeListVC release];
	}
}

-(void)sendMoreYtThemeRequest{
	
	if ([CheckNetwork isExistenceNetwork]) 
    {
		
		[request clearDelegatesAndCancel];
		
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTheme:[self loadedCount] pageSize:@"20"]]] ;
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[ request setNumberOfTimesToRetryOnTimeout:2 ];
		[request setDidFinishSelector:@selector(moreYtThemeListDataLoadingBack:)];
		[request startAsynchronous];
		
	}

}


-(void)moreYtThemeListDataLoadingBack:(ASIHTTPRequest*)mrequest{
	
	
	NSString *responseString = [mrequest responseString];
	
	if (responseString) {
		
		YtTheme *list = [[YtTheme alloc] init];
		
		NSMutableArray *listarry = [list arrayWithParse:responseString];
		
		if ([listarry count]>0) {
			
			[self.hotYtThemeListarry addObjectsFromArray:listarry];
			
		}else {
			
			[moreCell setType:MSG_TYPE_LOAD_NODATA];
			
			topicLoadedEnd = YES;
            
		}

		[list release];
		
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
	self.request =nil;
	self.hotYtThemeListarry =nil;
	[moreCell release];
	 moreCell=nil;
	
}


- (void)dealloc {
	[request clearDelegatesAndCancel];
	[request release];
	[hotYtThemeListarry release];
    [super dealloc];
	
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
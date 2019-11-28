//
//  HeMaiRenListViewController.m
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-30.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "HeMaiRenListViewController.h"
#import "GC_HttpService.h"
#import "Info.h"
#import "HemaiRenCell.h"
#import "caiboAppDelegate.h"
#import "MoreLoadCell.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "JSON.h"
#import "NetURL.h"
#import "ProfileViewController.h"
#import "SendMicroblogViewController.h"


@interface HeMaiRenListViewController ()

@end

@implementation HeMaiRenListViewController

@synthesize myTableView;
@synthesize myHttpRequest;
@synthesize programNum;
@synthesize hemaiData;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
#ifndef isCaiPiaoForIPad
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 60, 44)];
//    [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
#endif
//    self.CP_navigation.rightBarButtonItem = [Info homeItemTarget:self action:@selector(goHome)];
    
	UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:249.0/255.0 blue:255.0/255.0 alpha:1];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    self.CP_navigation.title = @"参与合买";
    
    myTableView = [[UITableView alloc] init];
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(0 +35, 0, 320, self.mainView.bounds.size.height);
#else
    myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
#endif
    [self.mainView addSubview:myTableView];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (!self.hemaiData) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] getGenDanPersonWith:self.programNum PageNum:1 OnePage:20 other:@""];
        
        [myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myHttpRequest setRequestMethod:@"POST"];
        [myHttpRequest addCommHeaders];
        [myHttpRequest setPostBody:postData];
        [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myHttpRequest setDelegate:self];
        [myHttpRequest setDidFinishSelector:@selector(reqHeMairenInfoFinished:)];
        [myHttpRequest startAsynchronous];
    }

    
//    UIView *lineView = [[[UIView alloc] init] autorelease];
//    lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
//    lineView.frame = CGRectMake(0, 0, 320, 0.5);
//    [myTableView addSubview:lineView];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.hemaiData.canyurenArray count] +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.hemaiData.canyurenArray count]) {
        return 40;
    }
    return 71;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HemaiRenCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[HemaiRenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row < [self.hemaiData.canyurenArray count]) {
        [cell LoadData:[self.hemaiData.canyurenArray objectAtIndex:indexPath.row]];
    }
    else {
        static NSString *CellIdentifier2 = @"More";
        MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
		
		if (cell == nil) {
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		
		if (moreCell == nil) {
			moreCell = cell;
		}
		
		return cell;
        
    }
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if (indexPath.row == [self.hemaiData.canyurenArray count]) {
        if ([self.hemaiData.canyurenArray count] >= self.hemaiData.totleNum) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"加载完毕"];
            [moreCell spinnerStopAnimating];
            [moreCell setInfoText:@"加载完毕"];
        }
        else {
            [self getMore];
        }
        
    }
    else {
        return;
        select = indexPath.row;
       
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:@"他的彩票", @"他的合买", nil]];
        [lb show];
        [lb release];
        
    }
}

#pragma mark - Action 

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goHome {
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    
}

- (void)getMore {
    NSMutableData *postData = [[GC_HttpService sharedInstance] getGenDanPersonWith:self.programNum PageNum:self.hemaiData.curPage +1 OnePage:20 other:@""];
    if (!self.hemaiData) {
        postData = [[GC_HttpService sharedInstance] getGenDanPersonWith:self.programNum PageNum:0 OnePage:20 other:@""];
    }
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myHttpRequest setRequestMethod:@"POST"];
    [myHttpRequest addCommHeaders];
    [myHttpRequest setPostBody:postData];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest setDelegate:self];
    [myHttpRequest setDidFinishSelector:@selector(reqHeMairenInfoFinished:)];
    [myHttpRequest startAsynchronous];
    
}


#pragma mark -delloc 

-(void)dealloc {
    [myTableView release];
    [self.myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    self.programNum = nil;
    self.hemaiData = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate 

- (void)reqHeMairenInfoFinished:(ASIHTTPRequest*)request {
    isLoadingMore = NO;
    [moreCell spinnerStopAnimating];
    if ([request responseData]) {
        HeMaiCanYuJieXI *canyu = [[HeMaiCanYuJieXI alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (!self.hemaiData) {
            self.hemaiData = canyu;
        }
        else {
            self.hemaiData.curPage = canyu.curPage;
            self.hemaiData.curCount = canyu.curCount;
            [self.hemaiData.canyurenArray addObjectsFromArray:canyu.canyurenArray];
        }
        [canyu release];
        [myTableView reloadData];
    }
}

- (void)useridRequestDidFinishSelector:(ASIHTTPRequest *)mrequest{
    
    if (mrequest) {
        NSString * str = [mrequest responseString];
        
        NSDictionary * dict = [str JSONValue];
        NSString * codestr = [dict objectForKey:@"code"];
        if([codestr isEqualToString:@"1"]){
            NSString * useridst = [dict objectForKey:@"userid"];
            useridstring = useridst;
            TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
            controller.userID = useridstring;
            controller.title = @"他的微博";
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
//            ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:useridst];//himID传用户的id
//            [controller setSelectedIndex:0];
//            controller.navigationItem.title = @"微博";
//            [self.navigationController pushViewController:controller animated:YES];
//            [controller release];
            
        }
        else {
        
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"获取失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    }
}

#pragma mark -
#pragma mark ScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!isLoadingMore){
			if (moreCell) {
                isLoadingMore = YES;
				[moreCell spinnerStartAnimating];
				[self getMore];
				
			}
		}
	}
}
- (void)otherLottoryViewController:(NSInteger)indexd{
    CanYuRen *ren = [self.hemaiData.canyurenArray objectAtIndex:select];
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = ren.name;
    my.nickName = ren.nickName;
//    my.userid = useridstring;
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = ren.name;
    my2.nickName = ren.nickName;
//    my2.userid = useridstring;
    
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
//    tabc.delegateCP = self;
//     tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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


#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        return;
    }
    CanYuRen *ren = [self.hemaiData.canyurenArray objectAtIndex:select];
    
   
    
    if (buttonIndex == 0) {//他的方案
        
//		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//		my.userName = ren.name;
//		my.nickName = ren.nickName;
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = ren.nickName;
//		[my release];
        [self otherLottoryViewController:0];
    }else if(buttonIndex == 1){        
//        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//        my.myLottoryType = MyLottoryTypeOtherHe;
//		my.userName = ren.name;
//		my.nickName = ren.nickName;
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = ren.nickName;
//		[my release];
        [self otherLottoryViewController:1];
        
    }else if (buttonIndex == 2){ // @他
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }
        
        NSLog(@"1111111");
        
#ifdef isCaiPiaoForIPad
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:ren.nickName];//传用户名
        [mTempStr appendString:@" "];
        topic1.nick_name = mTempStr;
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
        
        [topic1 release];
#else
        
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.publishType = kNewTopicController;// 自发彩博
//        YtTopic *topic1 = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:ren.nickName];//传用户名
//        [mTempStr appendString:@" "];
//        topic1.nick_name = mTempStr;
//        publishController.mStatus = topic1;
//        [self.navigationController pushViewController:publishController animated:YES];
//        [topic1 release];
//        [mTempStr release];
//        [publishController release];
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;// 自发彩博
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:ren.nickName];//传用户名
        [mTempStr appendString:@" "];
        topic1.nick_name = mTempStr;
        [mTempStr release];
        publishController.mStatus = topic1;
        [topic1 release];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        
        
#endif
    }else if (buttonIndex == 3){ // 他的微博
        [myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL cpThreeUserName:ren.name]];
        [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myHttpRequest setDelegate:self];
        [myHttpRequest setDidFinishSelector:@selector(useridRequestDidFinishSelector:)];
        [myHttpRequest setNumberOfTimesToRetryOnTimeout:2];
        [myHttpRequest startAsynchronous];
       
        
    }else if (buttonIndex == 4){//他的资料
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        followeesController.himNickName = ren.nickName;
        [self.navigationController pushViewController:followeesController animated:YES];
        [followeesController release];
    }
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
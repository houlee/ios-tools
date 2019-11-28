//
//  MyForecastViewController.m
//  caibo
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "MyForecastViewController.h"
#import "ForecastCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "NewPostViewController.h"
#import "Info.h"
#import "GCPLBetViewController.h"
#import "GCSPLBettingViewController.h"
#import "GC_BetCell.h"
#import "SendMicroblogViewController.h"

@implementation MyForecastViewController
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
    
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimageview.image = UIImageGetImageFromName(@"login_bg.png");
    [self.view addSubview:bgimageview];
    [bgimageview release];
    
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.navigationItem.leftBarButtonItem = leftItem;  	
    
    self.title = @"彩种选择";
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.request = [ASIHTTPRequest requestWithURL:[NetURL caipiaolottery]]; 
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(RecordsDidFinishSelector:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
    
    
    myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];

    
    
    
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RecordsDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSArray * dict = [str JSONValue];
 //   NSLog(@"dict = %@", dict);
   // NSArray * array = [dict objectForKey:@"data"];
    for (NSDictionary * dictionary in dict) {
        ForecastData * fore = [[ForecastData alloc] init];
        fore.name = [dictionary objectForKey:@"lotteryName"];
        fore.num = [dictionary objectForKey:@"issue"];
        fore.code = [dictionary objectForKey:@"lotteryCode"];
        [dataArray addObject:fore];
    
        [fore release];
    }
    
  //  NSLog(@"dataArray = %@", dataArray);
    [myTableView reloadData];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 0;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        GCPLBetViewController * gcjc = [[GCPLBetViewController alloc] initWithLotteryID:1];
        
        ForecastCell *cell = (ForecastCell *) [tableView cellForRowAtIndexPath:indexPath];
        gcjc.issString = cell.numLabel.text;
        gcjc.systimestr = cell.numLabel.text;
        [self.navigationController pushViewController:gcjc animated:YES];
        [gcjc release];

    }
    if (indexPath.row == 1) {
        ForecastCell *cell = (ForecastCell *) [tableView cellForRowAtIndexPath:indexPath];
        GCSPLBettingViewController * spl = [[GCSPLBettingViewController alloc] init];
        spl.bettingstype = bettingStypeShisichang;
        NSString * str = [NSString stringWithFormat:@"%@",cell.numLabel.text];
        spl.issString = str;
        spl.issueFuWu = cell.numLabel.text;
        [self.navigationController pushViewController:spl animated:YES];
        [spl release];
    }
    
    if (indexPath.row >1) {
        NSLog(@">>>>>>>>>>>>>>>");
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.publishType = kNewTopicController;// 自发彩博
//      //  [publishController setHidesBottomBarWhenPushed:YES];
//        [self.navigationController presentModalViewController:publishController animated:YES];
//        [publishController release];
//        pupbool = YES;
//        NewPostViewController *newYtThemeConntrller = [[NewPostViewController alloc] init];
//        newYtThemeConntrller.publishType = kNewTopicController;
//        newYtThemeConntrller.three = YES;
//        
//        if (indexPath.row == 2) {
//            newYtThemeConntrller.caizhong = @"102";
//        }else if(indexPath.row == 3){
//            newYtThemeConntrller.caizhong = @"5";
//        }else if(indexPath.row == 4){
//            newYtThemeConntrller.caizhong = @"1";
//        }else if(indexPath.row == 5){
//            newYtThemeConntrller.caizhong = @"4";
//        }
//        
//        YtTopic *topic = [[YtTopic alloc] init];
//        ForecastData * forec = [dataArray objectAtIndex:indexPath.row];
//        NSString * userId = [[Info getInstance] userId];
//        if (userId == nil||[userId isEqualToString:@""])
//            {
//            NSMutableString *str = [[NSMutableString alloc] init];
//            [str appendString:@"#"];
//            
//            if ([forec.name isEqualToString:@"排列3"]) {
//                [str appendFormat:@"排列3_%@期预测",  forec.num];
//                [str appendString:@"#"];
//                
//                [str appendFormat:@" #排列3预测# #%@预测#", [[Info getInstance] nickName]];
//            }else{
//                [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
//                [str appendString:@"#"];
//                
//                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//            }
//            
//           
//            
//            
//            topic.nick_name = str;
//            newYtThemeConntrller.myyuce = str;
//            [str release];
//            }
//        else 
//            {
//            NSMutableString *str = [[NSMutableString alloc] init];
//            [str appendString:@"#"];
//            if ([forec.name isEqualToString:@"排列3"]) {
//                [str appendFormat:@"排列3_%@期预测",  forec.num];
//                [str appendString:@"#"];
//                
//                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//            }else{
//                [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
//                [str appendString:@"#"];
//                
//                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//            }
//
//            
//            topic.nick_name = str;
//            newYtThemeConntrller.myyuce = str;
//            [str release];
//            }
//        
//        newYtThemeConntrller.mStatus = topic;
//        
//        if (pupbool) {
//             [self.navigationController pushViewController:newYtThemeConntrller animated:YES];
//        }else{
//            [self.navigationController pushViewController:newYtThemeConntrller animated:YES];
//        
//        }
        
       
        
	
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;
        publishController.three = YES;
        
        if (indexPath.row == 2) {
            publishController.caizhong = @"102";
        }else if(indexPath.row == 3){
            publishController.caizhong = @"5";
        }else if(indexPath.row == 4){
            publishController.caizhong = @"1";
        }else if(indexPath.row == 5){
            publishController.caizhong = @"4";
        }
        
        YtTopic *topic = [[YtTopic alloc] init];
        ForecastData * forec = [dataArray objectAtIndex:indexPath.row];
        NSString * userId = [[Info getInstance] userId];
        if (userId == nil||[userId isEqualToString:@""])
        {
            NSMutableString *str = [[NSMutableString alloc] init];
            [str appendString:@"#"];
            
            if ([forec.name isEqualToString:@"排列3"]) {
                [str appendFormat:@"排列3_%@期预测",  forec.num];
                [str appendString:@"#"];
                
                [str appendFormat:@" #排列3预测# #%@预测#", [[Info getInstance] nickName]];
            }else{
                [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
                [str appendString:@"#"];
                
                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
            }
            
            
            
            
            topic.nick_name = str;
            publishController.myyuce = str;
            [str release];
        }
        else
        {
            NSMutableString *str = [[NSMutableString alloc] init];
            [str appendString:@"#"];
            if ([forec.name isEqualToString:@"排列3"]) {
                [str appendFormat:@"排列3_%@期预测",  forec.num];
                [str appendString:@"#"];
                
                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
            }else{
                [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
                [str appendString:@"#"];
                
                [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
            }
            
            
            topic.nick_name = str;
            publishController.myyuce = str;
            [str release];
        }
        
        publishController.mStatus = topic;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        
        [topic release];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellid";
    ForecastCell * cell = (ForecastCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[ForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    cell.data = [dataArray objectAtIndex:indexPath.row];
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
    [myTableView release];
    [dataArray release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
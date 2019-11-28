//
//  DetailsViewController.m
//  caibo
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "DetailsViewController.h"
#import "BettingViewController.h"
#import "MobClick.h"
#import "LoginViewController.h"

@implementation DetailsViewController

@synthesize detailsArray;
@synthesize request;
@synthesize orderId;
@synthesize detaDataArray;
@synthesize buyArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -Action

- (void)goBetting {
    
    if ([buyArray count]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"正在请求参赛期次,请稍后再点" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show ];
        [alert release];
        
    }else{
        [MobClick event:@"event_pksai_cansai"];
        BettingViewController *bet = [[BettingViewController alloc] init];
        
        bet.betArray = buyArray;
        
        NSLog(@"bet array = %@", bet.betArray);
        [self.navigationController pushViewController:bet animated:YES];
        [bet release];
    }
    
}

- (void)doLogin {
	LoginViewController *log = [[LoginViewController alloc] init];
	[log setIsShowDefultAccount:YES];
	[self.navigationController pushViewController:log animated:YES];
	[log release];
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

- (void)returnSelectIndex:(NSInteger)index{
    NSLog(@"returnSelectIndex");
    if (index == 0) {
        [self goBetting];
    }
    else if (index == 1) {
        PKGameExplainViewController *pk  = [[PKGameExplainViewController alloc] init];
        [self.navigationController pushViewController:pk animated:YES];
        [pk release];
    }
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
    
    detaDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.title = @"方案详情";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    
    myTabelView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    myTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTabelView.scrollEnabled = NO;
    
    myTabelView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTabelView];

   
    self.request = [ASIHTTPRequest requestWithURL:[NetURL pkorderDetailOrderId:orderId]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(dateDidFinishSelector:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];


   
    detailsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSArray * array = [dict objectForKey:@"data"];
    for (NSDictionary * dictionary in array) {
        DetailsData * details = [[DetailsData alloc] initWithDuc:dictionary];
  
        [detaDataArray addObject:details];
        [details release];
    }
    for (DetailsData * data in detaDataArray) {
        NSLog(@"guestName = %@, hostName = %@, event = %@, result = %@, sing = %@", data.guestName, data.hostName, data.event, data.result, data.sing);
    }
    [myTabelView reloadData];
    if ([buyArray count] == 0) {
        [self.request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL pkIssueList:@"3"]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(dateDidFinishSelector2:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    }


}

- (void)dateDidFinishSelector2:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"11111111111dict = %@", dict);
    NSMutableArray * array = [dict objectForKey:@"data"];
    // NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"我的投注",@"issue",@"0",@"status" ,nil];
    // [array insertObject:dic atIndex:1];
    
    // self.bettingTitleArray = array;
    if (!buyArray) {
        self.buyArray = [NSMutableArray array];
    }
    for (NSDictionary * da in array) {
        
        if ([[da objectForKey:@"status"] isEqualToString:@"0"]) {
            NSString * buy = [da objectForKey:@"issue"];
            [buyArray addObject:buy];
        }
        
    }
    
}


- (void)pressRightButton:(id)sender{
    PKGameExplainViewController * pkgvc = [[PKGameExplainViewController alloc] init];
    
    [self.navigationController pushViewController:pkgvc animated:YES];
    [pkgvc release];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([detaDataArray count]>14) {
        return  14;
    }
   // NSLog(@"detaDataArray = %d", [detaDataArray count]);
    return [detaDataArray count];
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 26;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //返回的view
    UIImageView * view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)] autorelease];
    view.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 300, 30)];
    imageV.image = [UIImageGetImageFromName(@"PKTouBg.png") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    
    //赛事
    UILabel * eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 61, 30)];
    eventLabel.text = @"赛事";
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    eventLabel.font = [UIFont systemFontOfSize:10];
    
    //画竖线
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 0, 1, 30)];
    line1.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //对阵
    UILabel * againstLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 0, 117, 30)];
    againstLabel.text = @"对阵";
    againstLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    againstLabel.backgroundColor = [UIColor clearColor];
    againstLabel.textAlignment = NSTextAlignmentCenter;
    againstLabel.font = [UIFont systemFontOfSize:10];
    
    //画竖线
    UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(178, 0, 1, 30)];
    line2.image = UIImageGetImageFromName(@"PKShuLine.png");

    //彩果
    UILabel * resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(178, 0, 43, 30)];
    resultLabel.text = @"彩果";
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    resultLabel.font = [UIFont systemFontOfSize:10];
    
    //画竖线
    UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(221, 0, 1, 30)];
    line3.image = UIImageGetImageFromName(@"PKShuLine.png");
    
    //投注
    UILabel * betLabel = [[UILabel alloc] initWithFrame:CGRectMake(221, 0, 79, 30)];
    betLabel.text = @"投注";
    betLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    betLabel.textAlignment = NSTextAlignmentCenter;
    betLabel.backgroundColor = [UIColor clearColor];
    betLabel.font = [UIFont systemFontOfSize:10];
    


    
    [view addSubview:imageV];
    [imageV addSubview:eventLabel];
    [imageV addSubview:againstLabel];
    [imageV addSubview:resultLabel];
    [imageV addSubview:betLabel];
    [imageV addSubview:line1];
    [imageV addSubview:line2];
    [imageV addSubview:line3];
    
	[imageV release];
	[eventLabel release];
	[againstLabel release];
	[resultLabel release];
	[betLabel release];
	[line1 release];
	[line2 release];
	[line3 release];
	
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString * cellID = @"cell";
    DetailsCell * cell = (DetailsCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    
    cell.detailsData = [detaDataArray objectAtIndex:indexPath.row];
    
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
    [detaDataArray release];
    [orderId release];
    self.buyArray = nil;
    self.request = nil;
    [detailsArray release];
    [myTabelView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
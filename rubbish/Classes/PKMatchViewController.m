//
//  PKMatchViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "PKMatchViewController.h"
#import "Info.h"
#import "BettingViewController.h"
#import "NetURL.h"
#import "JSON.h"
#import "FansViewController.h"
#import "caiboAppDelegate.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "MobClick.h"
#import "PKGameExplainViewController.h"
#import "CP_PTButton.h"
#import "SendMicroblogViewController.h"

@implementation PKMatchViewController

@synthesize rankTitleArray;
@synthesize bettingTitleArray;
@synthesize crossTitleArray;
@synthesize PKtableView;
@synthesize pkMatchType;
@synthesize refreshHeaderView;
@synthesize data;
@synthesize statisticsData;
@synthesize useName;
@synthesize seachTextListarry;
@synthesize request;
@synthesize name;
@synthesize dateRequest;
@synthesize buyArray;


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


- (id)init {
	self = [super init];
	if (self) {
		pkMatchType = PKMatchTypeRank;
		self.rankTitleArray = [NSMutableArray arrayWithObjects:@"最新中奖",@"周 榜",@"月 榜",@"总 榜",nil];
		//self.bettingTitleArray = [NSArray arrayWithObjects:@"ZC0003期",@"我的投注记录",@"ZC0002期",nil];
        self.bettingTitleArray  = [NSMutableArray array];
        self.crossTitleArray = [NSMutableArray array];
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"PKSearch"];
		NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
        
        
		if (array) {
			self.seachTextListarry = array;
		}
		else {
			self.seachTextListarry =[NSMutableArray array];
		}
		[array release];
		buyArray = [[NSMutableArray alloc] initWithCapacity:0];
		crossDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		newdict = [[NSDictionary alloc] init];
		
		newdataArray = [[NSMutableArray alloc] initWithCapacity:0];
		weekArray = [[NSMutableArray  alloc] initWithCapacity:0];
		monthArray = [[NSMutableArray alloc] initWithCapacity:0];
		totalArray = [[NSMutableArray alloc] initWithCapacity:0];
		
		myBetArray = [[NSMutableArray alloc] initWithCapacity:0];
		
		restdateDic = [[NSMutableDictionary  alloc] initWithCapacity:0];
	}
	return self;
}

#pragma mark -
#pragma mark Action

- (void)hasLogin {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(20, 0, 40, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    
    [rightItem release];
    
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
    if (pkMatchType == PKMatchTypeMyBet) {
        [self ChangepkMatchType:pkMatchType];
    }
}

- (void)removeImage:(UIButton *)sender {
    if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 70, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
        [btn addSubview:imagevi];
        [imagevi release];
        
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
        lilable.font = [UIFont boldSystemFontOfSize:11];
        lilable.shadowColor = [UIColor blackColor];//阴影
        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"登录注册";
        [btn addSubview:lilable];
        [lilable release];
        [btn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
	}
    else {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(20, 0, 40, 44);
        [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        
        [rightItem release];
    }
    
	UIView *view1 = [self.mainView viewWithTag:1101];
	[view1 removeFromSuperview];
	
}

- (void)doBack {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressMenu {
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"PKCanSai.png"];
    [allimage addObject:@"PKInfo.png"];
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"参赛"];
    [alltitle addObject:@"活动说明"];
    caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
    CP_ThreeLevelNavigationView    *tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
    tln.delegate = self;
    [self.view addSubview:tln];
    [tln show];
    [tln release];

//    [tln release];
    [allimage release];
    [alltitle release];
    
}

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


- (void)oneDidFinishSelector:(ASIHTTPRequest*)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"str11111 = %@", str);

    NSDictionary * dict = [str JSONValue];

    NSArray * array = [dict objectForKey:@"data"];

    if (_reloading == YES) {
        [newdataArray removeAllObjects];
    }
        for (NSDictionary * dictData in array) {
        
            AwardData * awrddata = [[AwardData alloc] init];
            awrddata.use = [dictData objectForKey:@"nickName"];
            awrddata.money = [dictData objectForKey:@"awardMoney"];
            awrddata.userId = [dictData objectForKey:@"userId"];
            awrddata.imageUrl = [dictData objectForKey:@"midImage"];

            NSLog(@"dawrddata %@  money=%@", awrddata.use, awrddata.money);
            [newdataArray addObject:awrddata];
            [awrddata release];
        }
        
   
   [self.PKtableView reloadData];
    _reloading = NO;
	[moreCell spinnerStopAnimating];
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];

//    for (AwardData * aw in newdataArray) {
//        NSLog(@"award dat name: %@  money: %@", aw.use, aw.money);
//    }
    
}

- (void)weekDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"222 = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSArray * array = [dict objectForKey:@"data"];
    if (_reloading == YES) {
        [weekArray removeAllObjects];
    }
    for (NSDictionary * dictData in array) {
        AwardData * awrdData = [[AwardData alloc] init];
        awrdData.use = [dictData objectForKey:@"nickName"];
        awrdData.money = [dictData objectForKey:@"awardMoney"];
        awrdData.userId = [dictData objectForKey:@"userId"];
        awrdData.imageUrl = [dictData objectForKey:@"midImage"];
        [weekArray addObject:awrdData];
        [awrdData release];
    }
   

    [self.PKtableView reloadData];
    _reloading = NO;
	[moreCell spinnerStopAnimating];
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];
}

- (void)monthDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"333 = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSArray * array = [dict objectForKey:@"data"];
    if (_reloading == YES) {
        [monthArray removeAllObjects];
    }
    for (NSDictionary * dictData in array) {
        AwardData * awrdData = [[AwardData alloc] init];
        awrdData.use = [dictData objectForKey:@"nickName"];
        awrdData.money = [dictData objectForKey:@"awardMoney"];
        awrdData.userId = [dictData objectForKey:@"userId"];
        awrdData.imageUrl = [dictData objectForKey:@"midImage"];

        [monthArray addObject:awrdData];
        [awrdData release];
    }
   

    [self.PKtableView reloadData];
    _reloading = NO;
	[moreCell spinnerStopAnimating];
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];

}

- (void)totalDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"444 = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSArray * array = [dict objectForKey:@"data"];
    if (_reloading == YES) {
        [totalArray removeAllObjects];
    }
    for (NSDictionary * dictData in array) {
        AwardData * awrdData = [[AwardData alloc] init];
        awrdData.use = [dictData objectForKey:@"nickName"];
        awrdData.money = [dictData objectForKey:@"awardMoney"];
        awrdData.userId = [dictData objectForKey:@"userId"];
        awrdData.imageUrl = [dictData objectForKey:@"midImage"];

        [totalArray addObject:awrdData];
        [awrdData release];
    }
   
    
    [self.PKtableView reloadData];
    _reloading = NO;
	[moreCell spinnerStopAnimating];
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];

}


- (void)ChangepkMatchType:(PKMatchType)type {
	pkMatchType = type;	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];			
	switch (pkMatchType) {
		case PKMatchTypeRank:
		{
            
       
            PKtableView.backgroundColor = [UIColor clearColor];
            [self requestHttp];//请求数据
                           
		}
			break;
		case PKMatchTypeBettingRecords:
		{
            [self requestHttpRecords];
               
		}
			break;
		case PKMatchTypeCross:
		{
            [self requestHttpCross];
        
		}
            break;
            case PKMatchTypeMyBet:
        {
            [self requestHttpRecords];
        }
			break;
		default:
			break;
	}
    
	[UIView commitAnimations];
	[self.PKtableView reloadData];
}

- (void)doLogin {
	LoginViewController *log = [[LoginViewController alloc] init];
	[log setIsShowDefultAccount:YES];
	[self.navigationController pushViewController:log animated:YES];
	[log release];
}

- (void)requestHttp{
    //数据请求 中奖排行
    int index = (int)rankSelet + 1;
    
    
    if ( ([newdataArray count] == 0 && rankSelet == 0) || (_reloading == YES&&rankSelet == 0)) {
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL PKMatchGrade:[NSString stringWithFormat:@"%d", index]]]; 
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(oneDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    
    }else if (([weekArray count] == 0 && rankSelet == 1) || (_reloading == YES&&rankSelet == 1)){
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL PKMatchGrade:[NSString stringWithFormat:@"%d", index]]]; 
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(weekDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];

    }else if(([monthArray count] == 0 && rankSelet == 2) || (_reloading == YES&&rankSelet == 2)){
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL PKMatchGrade:[NSString stringWithFormat:@"%d", index]]]; 
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(monthDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];

    }else if (([totalArray count] == 0 && rankSelet == 3)||( _reloading == YES&&rankSelet == 3)){
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL PKMatchGrade:[NSString stringWithFormat:@"%d", index]]]; 
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(totalDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    }


}

//过关统计
- (void)requestHttpCross{
    //过关统计数据
    NSString *key = @"";
	if ( [self.crossTitleArray count] ==0) {
		NSLog(@"1111111");
		[self performSelector:@selector(requestHttpCross) withObject:nil afterDelay:1];
		return;
	}
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }

    if ([crossDic objectForKey:key] == nil || _reloading == YES || isLoadingMore == YES ) {
        
        NSInteger index = crossSelet;
        NSString * issue = [self.crossTitleArray objectAtIndex:index];
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL pkguoGuanIssue:issue pageNum:[self pageNumcross:index]]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(crossDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
        
       
        
        
    }
}

- (void)crossDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString *key = @"";
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    NSArray * array = [dict objectForKey:@"data"];
    NSMutableArray * mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary * di in array) {
        StatisticsData * sta = [[StatisticsData alloc] initWithDuc:di];
        [mutableArray addObject:sta];
        
        [sta release];
    }
    if (_reloading || [crossDic objectForKey:key] == nil) {
        [crossDic setObject:mutableArray forKey:key];
    }else{
        [[crossDic objectForKey:key] addObjectsFromArray:mutableArray];
    }

    
   
    
    
    [mutableArray  release];
    [self.PKtableView reloadData];
    
    _reloading = NO;
    isLoadingMore = NO;
	[moreCell spinnerStopAnimating];
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];
    [moreCell spinnerStopAnimating2:NO];
}

    //数据请求 投注记录
- (void)requestHttpRecords{

    //数据请求 投注记录
    NSInteger index = bettingSelet;
    NSString *key = @"";
	if ( [self.bettingTitleArray count] ==0) {
		[self performSelector:@selector(requestHttpRecords) withObject:nil afterDelay:1];
		return;
	}
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
        
        [request clearDelegatesAndCancel];
        self.request = [ASIHTTPRequest requestWithURL:[NetURL myPkBetRecordUseId:[[Info getInstance]userId] pageNum:[self pageNumBet:index]]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(RecordsDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    }
    if ([restdateDic objectForKey:key] == nil || _reloading == YES || isLoadingMore == YES) {
        
        
        
        if (![key isEqualToString:@"我的投注"]) {//其他期的投注记录
            
            [request clearDelegatesAndCancel];
            NSString * issue = [self.bettingTitleArray objectAtIndex:index];
            self.request = [ASIHTTPRequest requestWithURL:[NetURL pkBetRecordIssue:issue pageNum:[self pageNumData:index]]]; 
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(RecordsDidFinishSelector:)];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];
            
        }else if([key isEqualToString:@"我的投注"]){//我的投注记录
            //NSLog(@"")
        }
     
        
    }
    
    
    
}
//投注记录请求完成函数
- (void)RecordsDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString *key = @"";
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    NSArray * array = [dict objectForKey:@"data"];
    NSMutableArray * mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary * di in array) {
        StatisticsData * sta = [[StatisticsData alloc] initWithDuc:di];
        [mutableArray addObject:sta];
        
        [sta release];
    }
    if (_reloading||[restdateDic objectForKey:key] == nil) {
        [restdateDic setObject:mutableArray forKey:key];
    }else{
        [[restdateDic objectForKey:key] addObjectsFromArray:mutableArray];
    }
    


    
    NSArray * a = [restdateDic objectForKey:@"我的投注"];
    if (a !=nil && [a count]==0 && pkMatchType == PKMatchTypeMyBet) {
        UIView *view1 = [self.mainView viewWithTag:9988];
        if (view1) {
            view1.hidden = NO;
        }
        else {
            
        }
        
    }else{
        UIView *view1 = [self.mainView viewWithTag:9988];
        view1.hidden = YES;
        //[view1 removeFromSuperview];
        
        
    }
    
    if(mutableArray.count != 0)
    {
        [self.PKtableView reloadData];
    }
//    [self.PKtableView reloadData];
    [moreCell spinnerStopAnimating];
    _reloading = NO;
    isLoadingMore = NO;
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:self.PKtableView];
    [moreCell spinnerStopAnimating2:NO];
    if ([array count] < 20) {
        [moreCell setInfoText:@"加载完毕"];
    }
    [mutableArray  release];
}

- (NSString *)pageNumData:(NSInteger)index{
    NSString *key = @"";
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    NSArray * array = [restdateDic objectForKey:key];
    
    if (_reloading == YES || [array count] == 0) {
        NSString * str = @"1";
        return str;
    }
    NSInteger pag = [array count] % 20;
    if (pag != 0) {
        NSString * str = @"0";
        return str;
    }else {
    
    NSInteger page = ([array count] - 1) / 20 + 1;
    
    NSString * str = [NSString stringWithFormat:@"%d", (int)page+1];
    NSLog(@"str = %@", str);
    return str;
    }
    return @"1";
}

- (NSString *)pageNumBet:(NSInteger)index{
    NSString *key = @"";
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    NSArray * array = [restdateDic objectForKey:key];
    
    if (_reloading == YES || [array count] == 0) {
        NSString * str = @"1";
        return str;
    }
    NSInteger pag = [array count] % 20;
    if (pag != 0) {
        NSString * str = @"0";
        return str;
    }else{
    
        NSInteger page = ([array count] - 1) / 20 + 1;
    
        NSString * str = [NSString stringWithFormat:@"%d", (int)page+1];
    
    return str;
    }
    return @"1";
}

- (NSString *)pageNumcross:(NSInteger)index{
    NSString *key = @"";
    if (pkMatchType == PKMatchTypeBettingRecords) {
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    NSArray * array = [crossDic objectForKey:key];
    if (_reloading == YES || [array count] == 0) {
        NSString * str = @"1";
        return str;
    }
    NSInteger pag = [array count] % 20;
    if (pag != 0) {
        NSString * str = @"0";
        return str;
    }else {
    
    NSInteger page = ([array count]-1) / 20 + 1;
    
    NSString * str = [NSString stringWithFormat:@"%d", (int)page+1];
    
    return str;
    }
    return @"1";
}

- (void) loadTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.tag = 789;
    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    JTLabel.tag = 567;
    titleLabel.frame = CGRectMake(65, 0, 220, 44);
//    JTLabel.frame = CGRectMake(150, 1, 20, 44);
//    [titleView addSubview:JTLabel];
//    [JTLabel release];

    UIImageView * sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.frame = CGRectMake(148, 14.5, 17, 17);
    [titleView addSubview:sanjiaoImageView];
    
    if (pkMatchType == PKMatchTypeBettingRecords) {
        titleLabel.text = [self.bettingTitleArray objectAtIndex:0];
    }
    else if (pkMatchType == PKMatchTypeCross) {
        titleLabel.text = [self.crossTitleArray objectAtIndex:0];
    }
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = titleView.bounds;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
}

- (void)RankChange:(UIButton *)btn {
    
    for (UIButton *btn2 in btn.superview.subviews) {
        btn2.selected = NO;
    }
    rankSelet = btn.tag;
    btn.selected = YES;
    [self ChangepkMatchType:PKMatchTypeRank];
}

- (void)pressTitleButton:(UIButton *)sender {
    NSArray *wanArray = nil;
    NSInteger type = 0;
    if (self.pkMatchType == PKMatchTypeBettingRecords) {
        wanArray = self.bettingTitleArray;
        type = bettingSelet;
    }
    else if (self.pkMatchType == PKMatchTypeCross) {
        wanArray = self.crossTitleArray;
        type = crossSelet;
    }
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" withChuanNameArray:wanArray andChuanArray:nil];
    alert2.duoXuanBool = NO;
    alert2.delegate = self;
    [alert2 show];
    

    for (CP_XZButton *btn in alert2.backScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && btn.tag == type) {
            btn.selected = YES;
        }
    }
    
    [alert2 release];
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


#pragma mark -
#pragma mark UISearchBarDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isQuxiao = NO;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isQuxiao = YES;
	[searchDC.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (PKsearchBar.superview && isQuxiao) {
        [PKsearchBar resignFirstResponder];
        [PKsearchBar removeFromSuperview];
    }

}

-(void)sendSeachRequest:(NSString*)keywords
{	
    isQuxiao = NO;
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords];
	[seachPerson setHidesBottomBarWhenPushed:YES];
	seachPerson.isPK = YES;
    seachPerson.titlestring = keywords;
    seachPerson.titlebool = YES;
	[self.navigationController pushViewController:seachPerson animated:NO];
	[seachPerson release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	if ([searchBar text]&&![searchBar.text  isEqualToString:@""]) {
		[self.seachTextListarry removeObject:searchBar.text];
		if ([self.seachTextListarry count]==10) {
			
			[seachTextListarry lastObject];
			
		}
		[self.seachTextListarry insertObject:searchBar.text atIndex:0]; 
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"PKSearch"];
		[self.seachTextListarry writeToFile:plistPath atomically:YES];
		[self.searchDisplayController.searchResultsTableView reloadData];
		
	}
	[self sendSeachRequest:searchBar.text];
	isQuxiao = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    isQuxiao = YES;
     [PKsearchBar resignFirstResponder];
	[PKsearchBar removeFromSuperview];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingMore = NO;
    if (self.pkMatchType == PKMatchTypeBettingRecords) {
        
        [MobClick event:@"event_pksai_touzhujilu"];
        
    }
    else if (self.pkMatchType == PKMatchTypeRank) {
        [MobClick event:@"event_pksai_zhongjiangpaihang"];
    }
    else if (self.pkMatchType == PKMatchTypeCross) {
        [MobClick event:@"event_pksai_guoguantongji"];
        
    }
	self.CP_navigation.title = @"猜猜猜PK赛";
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 70, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
        [btn addSubview:imagevi];
        [imagevi release];
        
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
        lilable.font = [UIFont boldSystemFontOfSize:11];
        lilable.shadowColor = [UIColor blackColor];//阴影
        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"登录注册";
        [btn addSubview:lilable];
        [lilable release];
        [btn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
	}
    else {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(20, 0, 40, 44);
        [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        
        [rightItem release];
        
    }
    
	if (self.PKtableView == nil) {
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 45) style:UITableViewStylePlain];
		self.PKtableView = tableView;
        if (pkMatchType == PKMatchTypeRank) {
            self.PKtableView.frame = CGRectMake(0, 45, 320, self.mainView.bounds.size.height-90);
            UIImageView * view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)] autorelease];
            view.image = [UIImageGetImageFromName(@"PKDaoHang.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
            view.userInteractionEnabled = YES;
            for (int i = 0; i < 4; i ++) {
                CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(70 * i + 30, 0, 65, 45);
                [btn loadButonImage:[NSString stringWithFormat:@"PKRank%d_2.png",i+1] LabelName:nil];
                NSString *selectName = [NSString stringWithFormat:@"PKRank%d_1.png",i+1];
                btn.selectImage = UIImageGetImageFromName(selectName);
                btn.buttonImage.frame = CGRectMake(0, 0, 30, 36);
                btn.buttonImage.center = CGPointMake(btn.bounds.size.width/2.0, btn.bounds.size.height/2.0);
                [view addSubview:btn];
                btn.tag = i;
                if (rankSelet == btn.tag) {
                    btn.selected = YES;
                }
                [btn addTarget:self action:@selector(RankChange:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            [self.PKtableView setTableHeaderView:view];
//            [self.mainView addSubview:view];
        }
        tableView.backgroundColor = [UIColor clearColor];
		[tableView release];
		PKtableView.delegate = self;
		PKtableView.dataSource = self;
        [PKtableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.mainView addSubview:PKtableView];
        
	}
    
    //下拉刷新
	if (refreshHeaderView==nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height)];
		headerview.backgroundColor = [UIColor whiteColor];
		headerview.delegate = self;
		
		[self.PKtableView addSubview:headerview];
		
		self.refreshHeaderView = headerview;
		
		[headerview release];
	}
    
    
    UIView * pkgameview = [[UIView alloc] initWithFrame:self.mainView.bounds];
    pkgameview.tag = 9988;
    pkgameview.backgroundColor = [UIColor clearColor];
    pkgameview.userInteractionEnabled = YES;
    [self.mainView insertSubview:pkgameview atIndex:10001];
    pkgameview.hidden = YES;
    [pkgameview release];
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    ImageView.image = UIImageGetImageFromName(@"login_bgn.png");
    [pkgameview addSubview:ImageView];
    [ImageView release];
     
    
    UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 250, 13)];
    kjTime.backgroundColor = [UIColor clearColor];
    kjTime.text = @"对应每期的足彩设立的模拟比赛。";
    kjTime.font = [UIFont boldSystemFontOfSize:13];
    [pkgameview addSubview:kjTime];
    [kjTime release];
    
    UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(20, 63, 150, 11)];
    jjfd.backgroundColor = [UIColor clearColor];
    jjfd.text = @"1.每个方案上限512注。";
    jjfd.font = [UIFont boldSystemFontOfSize:11];
    jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:jjfd];
    [jjfd release];
    UILabel *jjf2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 180, 11)];
    jjf2.backgroundColor = [UIColor clearColor];
    jjf2.text = @"2.每人每期只能投注一个方案。";
    jjf2.font = [UIFont boldSystemFontOfSize:11];
    jjf2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:jjf2];
    [jjf2 release];
    UILabel *jjf3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 106, 150, 11)];
    jjf3.backgroundColor = [UIColor clearColor];
    jjf3.text = @"3.奖级设置：";
    jjf3.font = [UIFont boldSystemFontOfSize:11];
    jjf3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:jjf3];
    [jjf3 release];
    
    UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 129, 300, 11)];
    kjTime2.backgroundColor = [UIColor clearColor];
    kjTime2.text = @"1)设一等奖奖池（中14场）为1000元，二等奖奖池（中";
    kjTime2.font = [UIFont systemFontOfSize:11];
    kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime2];
    [kjTime2 release];
    
    UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, 270, 11)];
    kjTime3.backgroundColor = [UIColor clearColor];
    kjTime3.text = @"13场）为1000元。同一奖级中奖者均分奖池。";
    kjTime3.font = [UIFont systemFontOfSize:11];
    kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime3];
    [kjTime3 release];
    
    UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(25, 173, 280, 11)];
    kjTime4.backgroundColor = [UIColor clearColor];
    kjTime4.text = @"2)若该期无人中出14场或13场者，则对应奖金滚存进入下期一";
    kjTime4.font = [UIFont systemFontOfSize:10];
    kjTime4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime4];
    [kjTime4 release];
    
    UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(25, 196, 270, 11)];
    kjTime5.backgroundColor = [UIColor clearColor];
    kjTime5.text = @"等奖池。";
    kjTime5.font = [UIFont systemFontOfSize:11];
    kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime5];
    [kjTime5 release];
    
    UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(25, 217, 280, 11)];
    kjTime6.backgroundColor = [UIColor clearColor];
    kjTime6.text = @"3)单人获奖上限为2000元，若奖池仍有盈余则继续滚入";
    kjTime6.font = [UIFont systemFontOfSize:11];
    kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime6];
    [kjTime6 release];
    
    UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(25, 240, 270, 11)];
    kjTime7.backgroundColor = [UIColor clearColor];
    kjTime7.text = @"下期奖池。";
    kjTime7.font = [UIFont systemFontOfSize:11];
    kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime7];
    [kjTime7 release];
    
    UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(25, 263, 270, 11)];
    kjTime8.backgroundColor = [UIColor clearColor];
    kjTime8.text = @"4)对于连续两期中得14场的用户加奖1000元奖金。";
    kjTime8.font = [UIFont systemFontOfSize:11];
    kjTime8.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime8];
    [kjTime8 release];
    
    UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(25, 286, 270, 11)];
    kjTime9.backgroundColor = [UIColor clearColor];
    kjTime9.text = @"5)奖金可在www.diyicai.com和www.zgzcw.com上使用";
    kjTime9.font = [UIFont systemFontOfSize:11];
    kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [pkgameview addSubview:kjTime9];
    [kjTime9 release];

    UIButton *dxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    dxbutton.frame = CGRectMake(30, 326, 260, 35);
    [dxbutton addTarget:self action:@selector(butremoveImage:) forControlEvents:UIControlEventTouchUpInside];
    dxbutton.userInteractionEnabled = YES;
    [pkgameview addSubview:dxbutton];
    
    UIImageView *dximage = [[UIImageView alloc] initWithFrame:dxbutton.bounds];
    dximage.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [dxbutton addSubview:dximage];
    [dximage release];
    
    UILabel *dxLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 80, 35)];
    dxLabel.text = @"参赛";
    dxLabel.textAlignment = NSTextAlignmentCenter;
    dxLabel.font = [UIFont boldSystemFontOfSize:16];
    dxLabel.textColor = [UIColor whiteColor];
    dxLabel.backgroundColor = [UIColor clearColor];
    [dxbutton addSubview:dxLabel];
    [dxLabel release];

	[self ChangepkMatchType:pkMatchType];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"PKgame"] intValue]) {
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"PKgame"];
		self.CP_navigation.rightBarButtonItem = nil;
		UIView *backView = [[UIView alloc] initWithFrame:self.mainView.bounds];
		backView.backgroundColor = [UIColor clearColor];
		backView.tag = 1101;
        backView.userInteractionEnabled = YES;
        
        UIImageView *ImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
        ImageView.image = UIImageGetImageFromName(@"login_bgn.png");
        [backView addSubview:ImageView];
        [ImageView release];
        
		[self.mainView insertSubview:backView atIndex:10000];
		[backView release];
        
        UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 250, 13)];
        kjTime.backgroundColor = [UIColor clearColor];
        kjTime.text = @"对应每期的足彩设立的模拟比赛。";
        kjTime.font = [UIFont boldSystemFontOfSize:13];
        [backView addSubview:kjTime];
        [kjTime release];
        
        UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(20, 63, 150, 11)];
        jjfd.backgroundColor = [UIColor clearColor];
        jjfd.text = @"1.每个方案上限512注。";
        jjfd.font = [UIFont boldSystemFontOfSize:11];
        jjfd.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backView addSubview:jjfd];
        [jjfd release];
        UILabel *jjf2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 180, 11)];
        jjf2.backgroundColor = [UIColor clearColor];
        jjf2.text = @"2.每人每期只能投注一个方案。";
        jjf2.font = [UIFont boldSystemFontOfSize:11];
        jjf2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backView addSubview:jjf2];
        [jjf2 release];
        UILabel *jjf3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 106, 150, 11)];
        jjf3.backgroundColor = [UIColor clearColor];
        jjf3.text = @"3.奖级设置：";
        jjf3.font = [UIFont boldSystemFontOfSize:11];
        jjf3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [backView addSubview:jjf3];
        [jjf3 release];
        
        UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 129, 300, 11)];
        kjTime2.backgroundColor = [UIColor clearColor];
        kjTime2.text = @"1)设一等奖奖池（中14场）为1000元，二等奖奖池（中";
        kjTime2.font = [UIFont systemFontOfSize:11];
        kjTime2.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime2];
        [kjTime2 release];
        
        UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, 270, 11)];
        kjTime3.backgroundColor = [UIColor clearColor];
        kjTime3.text = @"13场）为1000元。同一奖级中奖者均分奖池。";
        kjTime3.font = [UIFont systemFontOfSize:11];
        kjTime3.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];        [backView addSubview:kjTime3];
        [kjTime3 release];
        
        UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(25, 173, 280, 11)];
        kjTime4.backgroundColor = [UIColor clearColor];
        kjTime4.text = @"2)若该期无人中出14场或13场者，则对应奖金滚存进入下期一";
        kjTime4.font = [UIFont systemFontOfSize:10];
        kjTime4.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime4];
        [kjTime4 release];
        
        UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(25, 196, 270, 11)];
        kjTime5.backgroundColor = [UIColor clearColor];
        kjTime5.text = @"等奖池。";
        kjTime5.font = [UIFont systemFontOfSize:11];
        kjTime5.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime5];
        [kjTime5 release];
        
        UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(25, 217, 280, 11)];
        kjTime6.backgroundColor = [UIColor clearColor];
        kjTime6.text = @"3)单人获奖上限为2000元，若奖池仍有盈余则继续滚入";
        kjTime6.font = [UIFont systemFontOfSize:11];
        kjTime6.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime6];
        [kjTime6 release];
        
        UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(25, 240, 270, 11)];
        kjTime7.backgroundColor = [UIColor clearColor];
        kjTime7.text = @"下期奖池。";
        kjTime7.font = [UIFont systemFontOfSize:11];
        kjTime7.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime7];
        [kjTime7 release];
        
        UILabel *kjTime8 = [[UILabel alloc] initWithFrame:CGRectMake(25, 263, 270, 11)];
        kjTime8.backgroundColor = [UIColor clearColor];
        kjTime8.text = @"4)对于连续两期中得14场的用户加奖1000元奖金。";
        kjTime8.font = [UIFont systemFontOfSize:11];
        kjTime8.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime8];
        [kjTime8 release];
        
        UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(25, 286, 270, 11)];
        kjTime9.backgroundColor = [UIColor clearColor];
        kjTime9.text = @"5)奖金可在www.diyicai.com和www.zgzcw.com上使用";
        kjTime9.font = [UIFont systemFontOfSize:11];
        kjTime9.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        [backView addSubview:kjTime9];
        [kjTime9 release];
        
        UIButton *dxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        dxbutton.frame = CGRectMake(30, 326, 260, 35);
        [dxbutton addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
        dxbutton.userInteractionEnabled = YES;
        [backView addSubview:dxbutton];
        
        UIImageView *dximage = [[UIImageView alloc] initWithFrame:dxbutton.bounds];
        dximage.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [dxbutton addSubview:dximage];
        [dximage release];
        
        UILabel *dxLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 80, 35)];
        dxLabel.text = @"进入";
        dxLabel.textAlignment = NSTextAlignmentCenter;
        dxLabel.font = [UIFont boldSystemFontOfSize:16];
        dxLabel.textColor = [UIColor whiteColor];
        dxLabel.backgroundColor = [UIColor clearColor];
        [dxbutton addSubview:dxLabel];
        [dxLabel release];

	}
    if (self.pkMatchType == PKMatchTypeMyBet) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationBatching:) name:@"my" object:nil];
    }

    
   // [request clearDelegatesAndCancel];
    if (![self.bettingTitleArray count]||![self.crossTitleArray count]) {
        self.dateRequest = [ASIHTTPRequest requestWithURL:[NetURL pkIssueList:@"3"]]; 
        [dateRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [dateRequest setDelegate:self];
        [dateRequest setDidFinishSelector:@selector(dateDidFinishSelector:)];
        [dateRequest setNumberOfTimesToRetryOnTimeout:2];
        [dateRequest startAsynchronous];
    }
    long int a ,now;
    now = [[NSDate date] timeIntervalSince1970];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"guanggaotime"]) {
        NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
		[[NSUserDefaults standardUserDefaults]setValue:time forKey:@"guanggaotime"];
    }
    a = [[[NSUserDefaults standardUserDefaults] valueForKey:@"guanggaotime"] longLongValue];
    if (now - a < 60*60 *24 *10) {
        self.PKtableView.frame = CGRectMake(0, 53, 320, self.mainView.bounds.size.height - 53 -45);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 320, 53);
        [btn setBackgroundImage:UIImageGetImageFromName(@"news_1395050790837.jpg") forState:UIControlStateNormal];
        [self.mainView addSubview:btn];
        [btn addTarget:self action:@selector(goAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        self.PKtableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height  -45);
    }
}

- (void)goAd:(UIButton *)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://s.apphope.com/ios7wp/haolecai"]];
}

- (void)notificationBatching:(id)sender{
    bettingSelet = 1;
    [self ChangepkMatchType:PKMatchTypeMyBet];

}

- (void)butremoveImage:(UIButton *)button{
    if ([buyArray count]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"正在请求参赛期次,请稍后再点" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show ];
        [alert release];
        
    }else{
        if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
            return;
        }
        BettingViewController *bet = [[BettingViewController alloc] init];
        
        bet.betArray = buyArray;
        
        NSLog(@"bet array = %@", bet.betArray);
        [self.navigationController pushViewController:bet animated:YES];
        [bet release];
    }


}

- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"11111111111dict = %@", dict);
    NSMutableArray * array = [dict objectForKey:@"data"];
   // NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"我的投注",@"issue",@"0",@"status" ,nil];
  // [array insertObject:dic atIndex:1];
    
   // self.bettingTitleArray = array;
    [self.bettingTitleArray removeAllObjects];
   [self.crossTitleArray removeAllObjects];
    for (NSDictionary * da in array) {
        NSString * string = [da objectForKey:@"issue"];
        [self.bettingTitleArray addObject:string];
        
        
        if ([[da objectForKey:@"status"] isEqualToString:@"0"]) {
            NSString * buy = [da objectForKey:@"issue"];
            [buyArray addObject:buy];
        }else{
            [self.crossTitleArray addObject:string];
        }
        
    }
    if ([self.bettingTitleArray count] >1) {
	}
	else {
		self.bettingTitleArray = nil;
		
	}
	if ([crossTitleArray count] == 0) {
		self.crossTitleArray = nil;
	}
    if (self.pkMatchType == PKMatchTypeBettingRecords || self.pkMatchType == PKMatchTypeCross) {
        [self loadTitleView];
    }

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillDisappear:animated];
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];
//     [self.navigationController setNavigationBarHidden:NO animated:NO];
}

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
#pragma mark CBRefreshDelegat

// 调用  UIScrollViewDelegate 下拉过程中 调用  
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	// 下拉刷新
	
	[refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.PKtableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
        
		if (pkMatchType == PKMatchTypeBettingRecords || pkMatchType == PKMatchTypeMyBet ) {
            
            if (!isLoadingMore){
                if (moreCell) {
                    isLoadingMore = YES;
                    [moreCell spinnerStartAnimating];
                    
                    [self performSelector:@selector(requestHttpRecords) withObject:nil afterDelay:.5];
                    
                }
            }

        }else if (pkMatchType == PKMatchTypeCross){
            if (!isLoadingMore){
                if (moreCell) {
                    isLoadingMore = YES;
                    [moreCell spinnerStartAnimating];
                    
                    [self performSelector:@selector(requestHttpCross) withObject:nil afterDelay:.5];
                    
                }
            }

        }
		
	}
	[refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
   
}


- (void)reloadTableViewDataSource{
	_reloading = YES;
    
}


- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
//	self.navigationItem.rightBarButtonItem.enabled = NO;
//	self.navigationItem.leftBarButtonItem.enabled = NO;
	_reloading = YES;
    
	if (self.pkMatchType == PKMatchTypeRank) {
        [self requestHttp];
    }
    else  if (self.pkMatchType == PKMatchTypeBettingRecords || self.pkMatchType == PKMatchTypeMyBet){
        [self requestHttpRecords];
    }
    else if(self.pkMatchType == PKMatchTypeCross){
        [self requestHttpCross];
    }
	[self reloadTableViewDataSource];
	
	[refreshHeaderView setState:CBPullRefreshLoading];
    
	self.PKtableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    
	
}


//  返回 判断  reload 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading	
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}
*/



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
	}
    NSString *key;
    if (pkMatchType == PKMatchTypeBettingRecords) {
		if ([self.bettingTitleArray count] ==0) {
			return 0;
		}
        key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    }
    else if(pkMatchType == PKMatchTypeCross) {
		if ([self.crossTitleArray count] ==0) {
			return 0;
		}
        key = [self.crossTitleArray objectAtIndex:crossSelet];
    }
    else if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    if(pkMatchType == PKMatchTypeRank){
        if (rankSelet == 0) {
//            if ([newdataArray count] > 7) {
//                return 7;
//            }
            return [newdataArray count];
        }else if(rankSelet == 1){
//            if ([weekArray count] > 7) {
//                return 7;
//            }
            return [weekArray count];
        }else if (rankSelet == 2){
//            if ([monthArray count] > 7) {
//                return 7;
//            }
            return [monthArray count];
        }else if (rankSelet == 3){
//            if ([totalArray count]>7) {
//                return 7;
//            }
            return [totalArray count];
        }else{
            return 7;
        }
    }
    else if(pkMatchType == PKMatchTypeBettingRecords || pkMatchType == PKMatchTypeMyBet) {
        NSMutableArray * array = [restdateDic objectForKey:key];
        return (![array count])?[array count]:[array count]+1;
    }else if(pkMatchType == PKMatchTypeCross){
        NSMutableArray * ar = [crossDic objectForKey:key];
        return (![ar count])?[ar count]:[ar count]+1;
    
    }
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
	}
    if (pkMatchType == PKMatchTypeRank) {
        return 55;
    }
    
    return 53;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (PKMatchTypeRank == pkMatchType) {
        return nil;
    }
    else if (pkMatchType == PKMatchTypeBettingRecords || pkMatchType == PKMatchTypeCross ||pkMatchType == PKMatchTypeMyBet){
        UIImageView * view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)] autorelease];
        view.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 300, 30)];
        imageV.image = [UIImageGetImageFromName(@"PKTouBg.png") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        
        //期号
        UILabel * timeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 61, 20)];
        timeNum.backgroundColor = [UIColor clearColor];
        timeNum.text = @"用户";
        timeNum.textAlignment = NSTextAlignmentCenter;
        timeNum.font = [UIFont systemFontOfSize:10];
        timeNum.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        
        //画竖线
        UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 0, 1, 30)];
        line1.image = UIImageGetImageFromName(@"PKShuLine.png");
        
        //奖金
        UILabel* money = [[UILabel alloc] initWithFrame:CGRectMake(61, 5, 47, 20)];
        money.textAlignment = NSTextAlignmentCenter;
        money.text = @"奖金";
        money.backgroundColor = [UIColor clearColor];
        money.font = [UIFont systemFontOfSize:10];
        money.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        
        //画竖线
        UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(108, 0, 1, 30)];
        line2.image = UIImageGetImageFromName(@"PKShuLine.png");
        
        //注数
        UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(108, 5, 47, 20)];
        number.textAlignment = NSTextAlignmentCenter;
        number.text = @"注数";
        number.backgroundColor = [UIColor clearColor];
        number.font = [UIFont systemFontOfSize:10];
        number.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        
        //画竖线
        UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 0, 1, 30)];
        line3.image = UIImageGetImageFromName(@"PKShuLine.png");
        
        //全对注数
        UILabel * allRight = [[UILabel  alloc] initWithFrame:CGRectMake(155, 5, 72, 20)];
        allRight.textAlignment = NSTextAlignmentCenter;
        allRight.text = @"全对注数";
        allRight.backgroundColor = [UIColor clearColor];
        allRight.font = [UIFont systemFontOfSize:10];
        allRight.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        
        //画竖线
        UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(227, 0, 1, 30)];
        line4.image = UIImageGetImageFromName(@"PKShuLine.png");
        
        //正确场次
        UILabel * right = [[UILabel alloc] initWithFrame:CGRectMake(227, 5, 73, 20)];
        right.textAlignment = NSTextAlignmentCenter;
        right.text = @"正确场次";
        right.backgroundColor = [UIColor clearColor];
        right.font = [UIFont systemFontOfSize:10];
        right.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        

        [imageV addSubview:timeNum];
        [imageV addSubview:money];
        [imageV addSubview:number];
        [imageV addSubview:allRight];
        [imageV addSubview:right];
      
        [imageV addSubview:line1];
        [imageV addSubview:line2];
        [imageV addSubview:line3];
        [imageV addSubview:line4];
        [view addSubview:imageV];
        
        [timeNum release];
        [money release];
        [number release];
        [allRight release];
        [right release];
        [line1 release];
        [line2 release];
        [line3 release];
        [line4 release];
        [imageV release];
        
        return view;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 0;
	}
    if (pkMatchType  == PKMatchTypeRank){
        return 0;
    }
    
    return 41;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        
        NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row]; 
        
        cell.textLabel.text =text ;
        
        return cell;
        
        
    }
    if (pkMatchType == PKMatchTypeRank) {
		NSMutableArray *array=nil;
        if (rankSelet == 0) {
			array = newdataArray;
        }else if (rankSelet == 1){
			array = weekArray;
        }else if (rankSelet == 2){
            array = monthArray;
			
        }else if(rankSelet == 3){
            array= totalArray;
        }else{
			array = newdataArray;
        }
		if (indexPath.row ==[array count]) {
			static NSString *CellIdentifier = @"MoreLoadCell";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			
			if (moreCell == nil) {
				moreCell = cell;
			}
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStopAnimating2:NO];
            }
			
			return cell;
		}
		else {
			static NSString *CellIdentifier = @"Cell";
			
			AwardCell *cell = (AwardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[AwardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			
			
			cell.row = indexPath.row;
			
			cell.awardData = [array objectAtIndex:indexPath.row];
			return cell;
		}
        
        
    } else if(pkMatchType == PKMatchTypeBettingRecords || pkMatchType == PKMatchTypeMyBet){
		NSString *key;
        if (pkMatchType == PKMatchTypeBettingRecords) {
            key = [self.bettingTitleArray objectAtIndex:bettingSelet];
        }
        else if(pkMatchType == PKMatchTypeCross) {
            key = [self.crossTitleArray objectAtIndex:crossSelet];
        }
        else if (pkMatchType == PKMatchTypeMyBet) {
            key = @"我的投注";
        }
		
		NSMutableArray * arr = [restdateDic objectForKey:key];
		if (indexPath.row ==[arr count]) {
			static NSString *CellIdentifier = @"MoreLoadCell";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			moreCell = cell;
            
            if (!isLoadingMore){
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    isLoadingMore = YES;
                    [moreCell spinnerStartAnimating];
                    
                    [self performSelector:@selector(requestHttpRecords) withObject:nil afterDelay:.5];
                }
                
            }
            
			return cell;
		}
		else {
			static NSString * cellID = @"cellID1";
			MyCathecticCell * cell = (MyCathecticCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
			if (cell == nil) {
				cell = [[[MyCathecticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			if (pkMatchType == PKMatchTypeMyBet) {
				cell.pkmatch = PKMatchTypeBettingMecell;
			}
			else {
				cell.pkmatch = PKMatchTypeCrosscell;
			}
    
			StatisticsData * st = [arr objectAtIndex:indexPath.row];
            if (![key isEqualToString: @"我的投注"]) {
                st.timeNum = @"";
              
            }
            
          //  cell.statisticsData = [arr  objectAtIndex:indexPath.row];
			cell.statisticsData = st;
			
			
			return cell;
		}

    }else if(pkMatchType == PKMatchTypeCross){
        
        NSString * key1 = [self.crossTitleArray objectAtIndex:crossSelet];
    
        NSMutableArray * arr1 = [crossDic objectForKey:key1];
        if (indexPath.row ==[arr1 count]) {
			static NSString *CellIdentifier = @"MoreLoadCell";
			
			MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			moreCell = cell;
			[cell spinnerStopAnimating2:NO];
            
            if (!isLoadingMore){
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    isLoadingMore = YES;
                    [moreCell spinnerStartAnimating];
                    
                    [self performSelector:@selector(requestHttpCross) withObject:nil afterDelay:.5];
                }
                
            }
            
			return cell;
		}else {
//
        
        static NSString * cellID = @"cellID1";
        MyCathecticCell * cell = (MyCathecticCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[[MyCathecticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.pkmatch = PKMatchTypeCrosscell;
        //cell.statisticsData = statisticsData;
        NSString *key = @"";
        if (pkMatchType == PKMatchTypeBettingRecords) {
            key = [self.bettingTitleArray objectAtIndex:bettingSelet];
        }
        else if(pkMatchType == PKMatchTypeCross) {
            key = [self.crossTitleArray objectAtIndex:crossSelet];
        }
        else if (pkMatchType == PKMatchTypeMyBet) {
            key = @"我的投注";
        }
        
       
            NSMutableArray * arr = [crossDic objectForKey:key];
            cell.statisticsData = [arr  objectAtIndex:indexPath.row];
            
        return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    NSString * key1 = [self.crossTitleArray objectAtIndex:crossSelet];
    
    NSArray * arr1 = [crossDic objectForKey:key1];

    if (pkMatchType == PKMatchTypeCross && indexPath.row != [arr1 count]) {
        
//        NSString * key = [self.crossTitleArray objectAtIndex:crossSelet];
//        
//        NSArray * arr = [crossDic objectForKey:key];
//		if (indexPath.row == [arr count]) {
//            [moreCell spinnerStartAnimating2];
//            [self requestHttpCross];
//
//		}
        
        StatisticsData * statistics = [arr1  objectAtIndex:indexPath.row];
               
        DetailsViewController * dvc = [[DetailsViewController alloc] init];
        dvc.orderId = statistics.orderId;
        
        [self.navigationController pushViewController:dvc animated:YES];
        [dvc release];
        
   
        
    }
    else if (pkMatchType == PKMatchTypeRank) {
        if (rankSelet == 0) {
            AwardData * awar = [newdataArray objectAtIndex:indexPath.row];
            useName = awar.userId;
            name = awar.use;
        }else if (rankSelet == 1){
            AwardData * awar = [weekArray objectAtIndex:indexPath.row];
            useName = awar.userId;
            name = awar.use;
        }else if (rankSelet == 2){
            AwardData * awar = [monthArray objectAtIndex:indexPath.row];
            useName = awar.userId;
            name = awar.use;
        }else if (rankSelet == 3){
            AwardData * awar = [totalArray objectAtIndex:indexPath.row];
            useName = awar.userId;
            name = awar.use;
        }else {
            AwardData * awar = [newdataArray objectAtIndex:indexPath.row];
            useName = awar.userId;
            name = awar.use;
        }
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"他的PK赛方案", @"@他", @"他的微博", @"他的资料",nil];
        [actionSheet showInView:self.mainView];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
        }
        [actionSheet release];

    }
    NSString * key = [self.bettingTitleArray objectAtIndex:bettingSelet];
    
    if (pkMatchType == PKMatchTypeMyBet) {
        key = @"我的投注";
    }
    
    NSArray * arr = [restdateDic objectForKey:key];
    

    if ((pkMatchType == PKMatchTypeBettingRecords || pkMatchType == PKMatchTypeMyBet)&& indexPath.row != [arr count]) {
        
        StatisticsData * statistics = [arr  objectAtIndex:indexPath.row];

        
        
        DetailsViewController * devc = [[DetailsViewController alloc] init];
        devc.orderId = statistics.orderId;
        devc.buyArray = self.buyArray;
        NSLog(@"orderID =%@", statistics.orderId);
        [self.navigationController pushViewController:devc animated:YES];
        [devc release];
    }
    
    
    if (pkMatchType == PKMatchTypeBettingRecords) {
        NSString * key = [self.bettingTitleArray objectAtIndex:bettingSelet];
        isLoadingMore = YES;
        NSArray * arr = [restdateDic objectForKey:key];
        if (indexPath.row == [arr count]) {
            [moreCell spinnerStartAnimating2];
            [self requestHttpRecords];
            
		}

    }else if (pkMatchType == PKMatchTypeCross){
        NSString * key = [self.crossTitleArray objectAtIndex:crossSelet];
        isLoadingMore = YES;
        NSArray * arr = [crossDic objectForKey:key];
        		if ([arr count] == indexPath.row) {
                        [moreCell spinnerStartAnimating2];
                        [self requestHttpCross];
                    
                }
    }


}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if (buttonIndex<=3&&([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0)) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"登录后可用"];
		return;
	}
    if (buttonIndex == 0) {//他的方案
        HisSchemeViewController * hsvc = [[HisSchemeViewController alloc] init];
        hsvc.userId = useName;
        hsvc.title = [NSString stringWithFormat:@"%@的投注记录",name];
        [self.navigationController pushViewController:hsvc animated:YES];
        [hsvc release];
        
    }else if (buttonIndex == 1){ // @他
#ifdef isCaiPiaoForIPad
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:name];//传用户名
        [mTempStr appendString:@" "];
        topic1.nick_name = mTempStr;
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
        
        [topic1 release];
#else
        
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.publishType = kNewTopicController;// 自发彩博
//        YtTopic *topic = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:name];//传用户名
//        [mTempStr appendString:@" "];
//        topic.nick_name = mTempStr;
//        publishController.mStatus = topic;
//        [self.navigationController pushViewController:publishController animated:YES];
//        [topic release];
//        [mTempStr release];
//
//        [publishController release];
        
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;// 自发彩博
        YtTopic *topic = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:name];//传用户名
        [mTempStr appendString:@" "];
        topic.nick_name = mTempStr;
        publishController.mStatus = topic;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        [topic release];
        [mTempStr release];
#endif
        
    }else if (buttonIndex == 2){ // 他的微博
        TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
        controller.userID = useName;
        controller.title = @"他的微博";
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
//        ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:useName];//himID传用户的id
//        [controller setSelectedIndex:0];
//        controller.navigationItem.title = @"微博";
//        [self.navigationController pushViewController:controller animated:YES];
//		[controller release];
    }else if (buttonIndex == 3){
      //他的资料
            ProfileViewController *followeesController = [[ProfileViewController alloc] init];
            followeesController.himNickName = name;
            [self.navigationController pushViewController:followeesController animated:YES];
            [followeesController release];
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    if (buttonIndex == 1) {


            titleLabel.text = [returnarry objectAtIndex:0];
        if (pkMatchType == PKMatchTypeCross) {
            crossSelet = [crossTitleArray indexOfObject:titleLabel.text];
        }
        else if (pkMatchType == PKMatchTypeBettingRecords) {
            bettingSelet = [bettingTitleArray indexOfObject:titleLabel.text];
        }
        [self ChangepkMatchType:self.pkMatchType];
    }

}


#pragma mark -
#pragma mark Table view delegate




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
	
}


- (void)dealloc {
    [buyArray release];
    [crossDic release];
    [name release];
    [weekArray release];
    [monthArray release];
    [totalArray release];
    [request clearDelegatesAndCancel];
    [dateRequest clearDelegatesAndCancel];
    self.dateRequest = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
    self.request = nil;
    [useName release];
	self.rankTitleArray = nil;
	self.bettingTitleArray = nil;
	self.crossTitleArray = nil;
	[PKsearchBar release];
	[searchDC release];
	self.PKtableView = nil;
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
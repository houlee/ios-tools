//
//  SachetViewController.m
//  caibo
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "SachetViewController.h"
#import "Info.h"
#import "User.h"
#import "caiboAppDelegate.h"
#import "LotteryPreferenceViewController.h"
#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "YtTheme.h"
#import "TopicThemeListViewController.h"
#import "JSON.h"
#import "MyForecastViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "YtTopic.h"
#import "MyLottoryViewController.h"
#import "newHomeViewController.h"
#import "ForecastCell.h"
#import "GCSPLBettingViewController.h"
#import "GCPLBetViewController.h"
#import "GC_HttpService.h"
#import "ProfileViewController.h"
#import "HaoShengYinData.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MobClick.h"
#import "HongRenBangCell.h"
#import "SendMicroblogViewController.h"


@implementation SachetViewController
@synthesize sachettype;
@synthesize request;
@synthesize redRequest;
@synthesize seachTextListarry;
@synthesize username;
@synthesize Nickname;
@synthesize userid;
@synthesize yuceRequest;



- (void)returnDidSetSelecteInTheRow:(NSInteger)selecteRow{
//    好声音删除
//    NSLog(@"return row = %d", selecteRow);
//    HaoShengYinData * data = [haoShengYinArr objectAtIndex:selecteRow];
//    VoicePlayerView *v = [[VoicePlayerView alloc] init];
//    v.delegate = self;
//    v.selectRow = selecteRow;
//    if([data.iszan intValue] == 0){
//        v.iszan = NO;
//    }else if([data.iszan intValue] == 1){
//        v.iszan = YES;
//    }
//    v.voiceID = data.voiceid;
//    [v loadOderID:data.ordered Zan:data.zan Editime:data.changeTime ];
//    [v show];
//    [v release];
}

- (void)returnVoicePlayerZanCount:(NSInteger)zancount selectRow:(NSInteger)row{
    
    HaoShengYinData * data = [haoShengYinArr objectAtIndex:row];
    data.zan = [NSString stringWithFormat:@"%d", (int)zancount];
    data.iszan = @"1";
    [haoShengYinArr replaceObjectAtIndex:row withObject:data];
    [haoTableView reloadData];
    
}


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
- (void)LoadiPhoneView {

    [MobClick event:@"event_gonglue"];
    self.CP_navigation.title = @"攻略";
    yudataArray = [[NSMutableArray alloc] initWithCapacity:0];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    arrdict = [[NSMutableArray alloc] initWithCapacity:0];
    redDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    haoShengYinArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [yuceRequest clearDelegatesAndCancel];
    self.yuceRequest = [ASIHTTPRequest requestWithURL:[NetURL cpQueryVoice]];
    [yuceRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yuceRequest setDelegate:self];
    [yuceRequest setDidFinishSelector:@selector(haoShengYinFinish:)];
    [yuceRequest setNumberOfTimesToRetryOnTimeout:2];
    [yuceRequest startAsynchronous];
    
    UIImageView * imaba = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    imaba.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:imaba];
    [imaba release];
    
    
    
    
    //    topic = [UIButton buttonWithType:UIButtonTypeCustom];
    //   // [topic setTitle:@"话题" forState:UIControlStateNormal];
    //    [topic setImage:[UIImage imageNamed:@"topic.png"] forState:UIControlStateNormal];
    //
    //    topic.frame = CGRectMake(90, 7, 71, 26);
    //    [topic addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:topic];
    //
    //
    UIBarButtonItem *rightitem = [Info homeItemTarget:self action:@selector(doBack)];
    [self.CP_navigation setRightBarButtonItem:rightitem];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    //
    //    redbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [redbutton setImage:[UIImage imageNamed:@"sachet_4.png"] forState:UIControlStateNormal];
    //    //[redbutton setTitle:@"红人榜" forState:UIControlStateNormal];
    //    redbutton.frame = CGRectMake(160, 7, 71, 26);
    //    [self.navigationController.navigationBar addSubview:redbutton];
    //    [redbutton addTarget:self action:@selector(pressRedbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    haoshengyinbut = [UIButton buttonWithType:UIButtonTypeCustom];
    haoshengyinbut.hidden = YES;
    haoshengyinbut.selected = NO;
	haoshengyinbut.frame = CGRectMake(14, 10, 73, 32);
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4_0.png") forState:UIControlStateSelected];
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4_1.png") forState:UIControlStateHighlighted];
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4.png") forState:UIControlStateNormal];
	haoshengyinbut.tag = 4;
	UILabel *label111 = [[UILabel alloc] init];
	label111.frame = haoshengyinbut.bounds;
	[haoshengyinbut addSubview:label111];
	label111.tag = 101;
	label111.font = [UIFont systemFontOfSize:13];
	label111.backgroundColor = [UIColor clearColor];
	label111.text = @"好声音";
	label111.textColor = [UIColor whiteColor];
	label111.textAlignment = NSTextAlignmentCenter;
	[label111 release];
	//zucaiBtn.selected = YES;
	[haoshengyinbut addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:haoshengyinbut];
    
    
    huatibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    huatibtn.selected = YES;
    huatibtn.hidden= YES;
    huatibtn.selected = NO;
	huatibtn.frame = CGRectMake(87, 10, 73, 32);
	[huatibtn setImage:UIImageGetImageFromName(@"GouCaibtn5_0.png") forState:UIControlStateSelected];
	[huatibtn setImage:UIImageGetImageFromName(@"GouCaibtn5_1.png") forState:UIControlStateHighlighted];
	[huatibtn setImage:UIImageGetImageFromName(@"GouCaibtn5.png") forState:UIControlStateNormal];
	huatibtn.tag = 1;
	UILabel *label11 = [[UILabel alloc] init];
	label11.frame = huatibtn.bounds;
	[huatibtn addSubview:label11];
	label11.tag = 101;
	label11.font = [UIFont systemFontOfSize:13];
	label11.backgroundColor = [UIColor clearColor];
	label11.text = @"话题";
	label11.textColor = [UIColor whiteColor];
	label11.textAlignment = NSTextAlignmentCenter;
	[label11 release];
	//zucaiBtn.selected = YES;
	[huatibtn addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:huatibtn];
	
	hongrenbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	hongrenbtn.frame = CGRectMake(160, 10, 73, 32);
    hongrenbtn.hidden = YES;
    hongrenbtn.selected = NO;
	UILabel *label22 = [[UILabel alloc] init];
	label22.frame = hongrenbtn.bounds;
	[hongrenbtn addSubview:label22];
	label22.tag = 101;
	label22.font = [UIFont systemFontOfSize:13];
	label22.backgroundColor = [UIColor clearColor];
	label22.text = @"红人榜";
	label22.textColor = [UIColor whiteColor];
	label22.textAlignment = NSTextAlignmentCenter;
	[label22 release];
	[hongrenbtn setImage:UIImageGetImageFromName(@"GouCaibtn5_0.png") forState:UIControlStateSelected];
	[hongrenbtn setImage:UIImageGetImageFromName(@"GouCaibtn5.png") forState:UIControlStateNormal];
	[hongrenbtn setImage:UIImageGetImageFromName(@"GouCaibtn5_1.png") forState:UIControlStateHighlighted];
	hongrenbtn.tag = 2;
	[hongrenbtn addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:hongrenbtn];
    
    
    
    yucebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yucebtn.frame = CGRectMake(233, 10, 73, 32);
    yucebtn.hidden = YES;
    yucebtn.selected = NO;
    UILabel * label44 = [[UILabel alloc] init];
    label44.frame = yucebtn.bounds;
    [yucebtn addSubview:label44];
    label44.font = [UIFont systemFontOfSize:13];
	label44.tag = 101;
	label44.textColor = [UIColor whiteColor];
	label44.backgroundColor = [UIColor clearColor];
	label44.text = @"我来预测";
	label44.textAlignment = NSTextAlignmentCenter;
	[label44 release];
    [yucebtn setImage:UIImageGetImageFromName(@"GouCaibtn6_0.png") forState:UIControlStateSelected];
	[yucebtn setImage:UIImageGetImageFromName(@"GouCaibtn6.png") forState:UIControlStateNormal];
	[yucebtn setImage:UIImageGetImageFromName(@"GouCaibtn6_1.png") forState:UIControlStateHighlighted];
	yucebtn.tag = 3;
	[yucebtn addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:yucebtn];
    
    
    
    //    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    UIImage *imagerigthItem = UIImageGetImageFromName(@"sachet_2.png");
    //
    //    rigthItem.bounds = CGRectMake(0, 12, 41, 19);
    //
    //    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    //    [rigthItem addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    //
    //    self.navigationItem.rightBarButtonItem = rigthItemButton;
    //
    //    [rigthItemButton release];
    
    
    //    UIBarButtonItem * rigthItem = [Info itemInitWithTitle:@"搜用户" Target:self action:@selector(pressSearch:)];
    //    self.navigationItem.rightBarButtonItem = rigthItem;
    
    colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],[UIColor colorWithRed:245/255.0 green:255/255.0 blue:145/255.0 alpha:1], nil];
    
    sizeArray = [NSArray arrayWithObjects:@"12",@"14", @"17", nil];
    buttonArray = [NSArray arrayWithObjects:@"足彩预测", @"竞彩预测", @"大乐透预测", @"3D预测", @"双色球预测", @"排列3预测", nil];
    
    [self TopicViewAddview];
    //    topicView.hidden = NO;
    
    
    //假数据
    //    [dataArray addObject:@"#双色球20012017#"];
    //    [dataArray addObject:@"#3D 20012017#"];
    //    [dataArray addObject:@"#排列320012017#"];
    //    [dataArray addObject:@"#福彩新闻#"];
    //    [dataArray addObject:@"#欧洲杯#"];
    //    [dataArray addObject:@"#体育新闻#"];
    //
    
    
    
    //假数据
//    annuoun = [[AnnouncementData alloc] init];
//    annuoun.user = @"用户名123";
//    annuoun.money = @"999999元";
//    annuoun.level1 = @"1";
//    annuoun.level2 = @"2";
//    annuoun.level3 = @"3";
    //
    
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
    
    
    haoTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, 3, 296,  self.mainView.bounds.size.height -54) style:UITableViewStylePlain];
    haoTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    haoTableView.delegate = self;
    haoTableView.dataSource = self;
    haoTableView.backgroundColor = [UIColor clearColor];
    [haoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:haoTableView];
    
    
    
    NSLog(@"reddictionary = %@", redDictionary);
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,  self.mainView.bounds.size.height -51) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    //[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    myTableView.hidden = YES;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView * headimag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 304, 17)];
    headimag.image = [UIImageGetImageFromName(@"red_texBg_t.png") stretchableImageWithLeftCapWidth:60 topCapHeight:6];
    //  [myTableView setTableHeaderView:headimag];
    [headimag release];
    
    yuceView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 320, 420)];
    yuceView.backgroundColor = [UIColor clearColor];
    yuceView.hidden = YES;
    
    yuCeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height -51) style:UITableViewStylePlain];
    yuCeTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    yuCeTableView.tag = 111;
    yuCeTableView.dataSource = self;
    yuCeTableView.delegate = self;
    yuCeTableView.backgroundColor = [UIColor clearColor];
    yuCeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [yuceView addSubview:yuCeTableView];
    
    
    
    [self.mainView addSubview:yuceView];
    
    
    UIButton * slectbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    if (sachettype == haoshengyintype) {
        haoshengyinbut.selected = YES;
        slectbutton.tag = 4;
    }else if(sachettype == huatitype){
        huatibtn.selected = YES;
         slectbutton.tag = 1;
    }else if(sachettype == hongrenbangtype){
        hongrenbtn.selected = YES;
         slectbutton.tag = 2;
    }else if(sachettype == wolaiyucetype){
        yucebtn.selected = YES;
         slectbutton.tag = 3;
    }
    [self pressTopic:slectbutton];

}

- (void)LoadiPadView {

    [MobClick event:@"event_gonglue"];
    self.CP_navigation.title = @"好声音";
    [self.CP_navigation setHidesBackButton:YES];
    
    yudataArray = [[NSMutableArray alloc] initWithCapacity:0];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    arrdict = [[NSMutableArray alloc] initWithCapacity:0];
    redDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    haoShengYinArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [yuceRequest clearDelegatesAndCancel];
    self.yuceRequest = [ASIHTTPRequest requestWithURL:[NetURL cpQueryVoice]];
    [yuceRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yuceRequest setDelegate:self];
    [yuceRequest setDidFinishSelector:@selector(haoShengYinFinish:)];
    [yuceRequest setNumberOfTimesToRetryOnTimeout:2];
    [yuceRequest startAsynchronous];
    
    UIImageView * imaba = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imaba.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:imaba];
    [imaba release];
    
    
    haoshengyinbut = [UIButton buttonWithType:UIButtonTypeCustom];
//    haoshengyinbut.selected = YES;
    haoshengyinbut.hidden = YES;
	haoshengyinbut.frame = CGRectMake(14, 10, 73, 32);
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4_0.png") forState:UIControlStateSelected];
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4_1.png") forState:UIControlStateHighlighted];
	[haoshengyinbut setImage:UIImageGetImageFromName(@"GouCaibtn4.png") forState:UIControlStateNormal];
	haoshengyinbut.tag = 4;
	UILabel *label111 = [[UILabel alloc] init];
	label111.frame = haoshengyinbut.bounds;
	[haoshengyinbut addSubview:label111];
	label111.tag = 101;
	label111.font = [UIFont systemFontOfSize:13];
	label111.backgroundColor = [UIColor clearColor];
	label111.text = @"好声音";
	label111.textColor = [UIColor whiteColor];
	label111.textAlignment = NSTextAlignmentCenter;
	[label111 release];
	//zucaiBtn.selected = YES;
	[haoshengyinbut addTarget:self action:@selector(pressTopic:) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:haoshengyinbut];
    

    
    //假数据
//    annuoun = [[AnnouncementData alloc] init];
//    annuoun.user = @"用户名123";
//    annuoun.money = @"999999元";
//    annuoun.level1 = @"1";
//    annuoun.level2 = @"2";
//    annuoun.level3 = @"3";
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
    
    
    haoTableView = [[UITableView alloc] initWithFrame:CGRectMake(47, 20, 748,  self.view.bounds.size.height -24) style:UITableViewStylePlain];
    haoTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    haoTableView.delegate = self;
    haoTableView.dataSource = self;
    haoTableView.backgroundColor = [UIColor clearColor];
    [haoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:haoTableView];
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    buf[0] = 1;
    buf[1] = 1;
    buf[2] = 1;
    buf[3] = 1;
    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif

}

- (void)haoShengYinFinish:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"hao sheng yin = %@", str);
    NSArray * arr = [str JSONValue];
    for (NSDictionary * dict  in arr) {
        HaoShengYinData * data = [[HaoShengYinData alloc] init];
        data.nickName = [dict objectForKey:@"nick_name"];
        data.userName = [dict objectForKey:@"user_name"];
        data.time = [dict objectForKey:@"time"];
        data.changeTime = [dict objectForKey:@"update_time"];
        data.zan = [dict objectForKey:@"zan"];
        data.ordered = [dict objectForKey:@"ordered"];
        data.headImage =  [dict objectForKey:@"head_img"];
        data.zhanji = [dict objectForKey:@"zhanji"];
        data.bonus = [dict objectForKey:@"bonus"];
        data.time = [NSString stringWithFormat:@"%d", [data.time intValue]];
        data.zan = [NSString stringWithFormat:@"%d", [data.zan intValue]];
        data.bonus = [NSString stringWithFormat:@"%d", [data.bonus intValue]];
        data.issue = [dict objectForKey:@"issue"];
        data.lotteryid = [dict objectForKey:@"lotteryid"];
        data.iszan = [dict objectForKey:@"iszan"];
        data.voiceid = [dict objectForKey:@"voiceid"];
        
        
        [haoShengYinArr addObject:data];
      
        [data release];
    }
    [haoTableView reloadData];

}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    
    NSDictionary * dict = [str JSONValue];
    NSLog(@"str = %@", dict);
   // arrdict = [dict allKeys];
    NSArray * arrkey = [dict allKeys];
    for (NSString * s in arrkey) {
        NSLog(@"s = %@", s);
        if (![s isEqualToString:@"code"]) {
            [arrdict addObject:s];
        }
        
    }
    
    
 //   NSArray * arraybd = [dict objectForKey:@"bd"];
  //  NSLog(@"arraybd = %@", arraybd);
//    NSArray * arrayjc = [dict objectForKey:@"jingcai"];
//    NSArray * arrayrx9 = [dict objectForKey:@"rx9"];
//    NSArray * arraysfc = [dict objectForKey:@"sfc"];
    for (int i = 0; i < [arrdict count]; i++) {
    //    NSLog(@"i = %d", i);
        NSString * st = [arrdict objectAtIndex:i];
     //   NSLog(@"st = %@", st);
        NSArray * arr = [dict objectForKey:st];
    //    NSLog(@"爱让人= %@", arr);
        NSMutableArray * dataarr = [[NSMutableArray alloc] initWithCapacity:0];
        
       
        for (NSDictionary * str in arr) {
            
            AnnouncementData * ann = [[AnnouncementData alloc] init];
            ann.money = [str objectForKey:@"awardMoney"];
			ann.userName = [str objectForKey:@"userName"];
            NSLog(@"anndata = %@",[str objectForKey:@"awardMoney"]);
            ann.level1 = [str objectForKey:@"level1"];
            ann.level2 = [str objectForKey:@"level2"];
            ann.level3 = [str objectForKey:@"level3"];
            ann.level4 = [str objectForKey:@"level4"];
            ann.level5 = [str objectForKey:@"level5"];
            ann.level6 = [str objectForKey:@"level6"];
            ann.imagestr = [str objectForKey:@"midImage"];
            NSLog(@"imagestr = %@", [str objectForKey:@"midImage"]);
            ann.user = [str objectForKey:@"nickName"];
            ann.userID = [str objectForKey:@"userId"];
            [dataarr addObject:ann];
            [ann release];
        }
        [redDictionary setObject:dataarr forKey:st];
        [dataarr release];
        
    }
        
    
    [myTableView reloadData];
    
}

- (void)pressSearch:(id)sender{
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		[self.mainView addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
        isQuxiao = NO;
	[self.mainView addSubview:PKsearchBar];
	[PKsearchBar becomeFirstResponder];

}




- (void)RecordsDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSArray * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
 //   NSArray * array = [dict objectForKey:@"data"];
    for (NSDictionary * dictionary in dict) {
        NSString * str = [NSString stringWithFormat:@"#%@#",[dictionary objectForKey:@"NAME"]];
  //      NSLog(@"str = %@", str);
        [dataArray addObject:str];
    }
    
//    arrayLabel = [NSArray arrayWithObjects:doubleLabel, threeDLabel, arrangeLabel, blessingLabel, europeLabel, sportsLabel, nil];
    
//    for (int i = 0; i < [dataArray count]; i++) {
//        UILabel * lab = [arrayLabel objectAtIndex:i];
//        lab.text = [dataArray objectAtIndex:i];
//    }
    
    
    
    
    
    if ([dataArray count] >= 6) {
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = [dataArray objectAtIndex:1];
        arrangeLabel.text = [dataArray objectAtIndex:2];
        blessingLabel.text = [dataArray objectAtIndex:3];
        europeLabel.text = [dataArray objectAtIndex:4];
        sportsLabel.text = [dataArray objectAtIndex:5];
        
    }else if ([dataArray count] == 5){
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = [dataArray objectAtIndex:1];
        arrangeLabel.text = [dataArray objectAtIndex:2];
        blessingLabel.text = [dataArray objectAtIndex:3];
        europeLabel.text = [dataArray objectAtIndex:4];
        sportsLabel.text = @"";

    }else if([dataArray count] == 4){
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = [dataArray objectAtIndex:1];
        arrangeLabel.text = [dataArray objectAtIndex:2];
        blessingLabel.text = [dataArray objectAtIndex:3];
        europeLabel.text = @"";
        sportsLabel.text = @"";
    }else if([dataArray count] == 3){
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = [dataArray objectAtIndex:1];
        arrangeLabel.text = [dataArray objectAtIndex:2];
        blessingLabel.text = @"";
        europeLabel.text = @"";
        sportsLabel.text = @"";
    }else if([dataArray count] == 2){
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = [dataArray objectAtIndex:1];
        arrangeLabel.text = @"";
        blessingLabel.text = @"";
        europeLabel.text = @"";
        sportsLabel.text = @"";
    }else if([dataArray count] == 1){
        doubleLabel.text = [dataArray objectAtIndex:0];
        threeDLabel.text = @"";
        arrangeLabel.text = @"";
        blessingLabel.text = @"";
        europeLabel.text = @"";
        sportsLabel.text = @"";
    }else if([dataArray count] == 0){
        doubleLabel.text = @"";
        threeDLabel.text = @"";
        arrangeLabel.text = @"";
        blessingLabel.text = @"";
        europeLabel.text = @"";
        sportsLabel.text = @"";
    }
    

//    for (NSString * na in dataArray) {
//        NSLog(@"name = %@", na);
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
	}
    
    if ([tableView isEqual:haoTableView]) {
        return [haoShengYinArr count];
    }
    
    if (tableView.tag == 111) {
        return [yudataArray count];
    }else{
        
        if (buf[section] == 0) {
            return 0;
        }else{
            NSString * string = [arrdict objectAtIndex:section];
            NSArray * array = [redDictionary objectForKey:string];
            if ([string isEqualToString:@"sfc"]) {
                return [array count];
            }else if ([string isEqualToString:@"rx9"]){
                return [array count];
            }else if ([string isEqualToString:@"bd"]){
                return [array count];
            }else if ([string isEqualToString:@"jingcai"]){
                return [array count];
            }
        }
        

    }
        
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 1;
	}
    if ([tableView isEqual:haoTableView]) {
        return 1;
    }
    
    if (tableView.tag == 111) {
        return 1;
    }
    if (arrdict == nil) {
        return 1;
    }
    NSLog(@"arrdict = %@", arrdict);
    return [arrdict count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
	}
    if ([tableView isEqual:haoTableView]) {
        return 55;
    }
    if (tableView.tag == 111) {
        return 55;
    }
   // if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            return 56;
//        }
    //}

    
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 111 || [tableView isEqual:haoTableView]) {
        return nil;

    }else{
//        UIView * bgviewim = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
//        bgviewim.backgroundColor = [UIColor blueColor];
//        return bgviewim;
        
        
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = section;
        titleButton.frame = CGRectMake(0, 0, 320, 20);
        [titleButton addTarget:self action:@selector(pressTableviewTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
        titleImage.backgroundColor = [UIColor clearColor];
        titleImage.tag = section+10;
        [titleButton addSubview:titleImage];
        [titleImage release];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, 100, 29)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [titleImage addSubview:titleLabel];
        [titleLabel release];
        
//        UIImageView * titleJiantou = [[UIImageView alloc] initWithFrame:CGRectMake(300-30, (29-18)/2, 18, 18)];
//        titleJiantou.backgroundColor = [UIColor clearColor];
//        titleJiantou.tag = section+20;
//        titleJiantou.image = UIImageGetImageFromName(@"hongrenjiantou.png");
//        [titleImage addSubview:titleJiantou];
//        [titleJiantou release];
        
        
        NSString * string = [arrdict objectAtIndex:section];
        
        if ([string isEqualToString:@"sfc"]) {
            titleLabel.text = @"胜负彩";
            
        }else if ([string isEqualToString:@"rx9"]){
            titleLabel.text = @"任选九";
        }else if ([string isEqualToString:@"bd"]){
            titleLabel.text = @"单场";
        }else if ([string isEqualToString:@"jingcai"]){
            titleLabel.text = @"竞彩足球";
        }


        
        if (buf[section] == 0) {
            titleImage.image = [UIImageGetImageFromName(@"DHTY960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
             titleLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//            titleJiantou.image = UIImageGetImageFromName(@"hongrenjiantou.png");
            
        }else{
            titleImage.image = [UIImageGetImageFromName(@"DHTX960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//            titleJiantou.image = UIImageGetImageFromName(@"hongrenjiantou_1.png");
            
            
           
            
             titleLabel.textColor = [UIColor whiteColor];
        }
        
        return titleButton;
    }
    return nil;
}

- (void)pressTableviewTitle:(UIButton *)sender{
    
    if (buf[sender.tag] == 0) {
        buf[sender.tag] = 1;
        UIImageView * titleImage = (UIImageView *)[sender viewWithTag:sender.tag+10];
//        UIImageView * titleJiantou = (UIImageView *)[sender viewWithTag:sender.tag + 20];
        
        titleImage.image =[UIImageGetImageFromName(@"DHTY960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//        titleJiantou.image = UIImageGetImageFromName(@"hongrenjiantou_1.png");
        
        
       
        
    }else{
        buf[sender.tag] = 0;
        UIImageView * titleImage = (UIImageView *)[sender viewWithTag:sender.tag+10];
//        UIImageView * titleJiantou = (UIImageView *)[sender viewWithTag:sender.tag + 20];
        titleImage.image = [UIImageGetImageFromName(@"DHTX960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//        titleJiantou.image = UIImageGetImageFromName(@"hongrenjiantou.png");
    }
    [myTableView reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:haoTableView]) {
        return 0;
    }
    if (tableView.tag == 111) {
        return 0;
        
    }
    return 29;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (self.searchDisplayController.searchResultsTableView == tableView) {
//		return nil;
//	}
//    NSString * string = [arrdict objectAtIndex:section];
//    if ([string isEqualToString:@"sfc"]) {
//        return @"胜负彩";
//    }else if ([string isEqualToString:@"rx9"]){
//        return @"任选九";
//    }else if ([string isEqualToString:@"bd"]){
//        return @"单场";
//    }else if ([string isEqualToString:@"jingcai"]){
//        return @"竞彩足球";
//    }
//    return nil;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIImageView * headima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 304, 33)];
//    headima.image = UIImageGetImageFromName(@"red_titBg3.png");
//    UILabel * helabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 304, 33)];
//    helabel.backgroundColor = [UIColor clearColor];
//    helabel.textAlignment = NSTextAlignmentCenter;
//    helabel.textColor = [UIColor whiteColor];
//    [headima addSubview:helabel];
//    NSString * string = [arrdict objectAtIndex:section];
//    if ([string isEqualToString:@"sfc"]) {
//        helabel.text = @"胜负彩";
//    }else if ([string isEqualToString:@"rx9"]){
//        helabel.text = @"任选九";
//    }else if ([string isEqualToString:@"bd"]){
//        helabel.text = @"单场";
//    }else if ([string isEqualToString:@"jingcai"]){
//        helabel.text = @"竞彩足球";
//    }
//
//    
//    
//    return headima;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    
   

    if (tableView.tag == 111) {
        if (indexPath.row == 0) {
            [MobClick event:@"event_gonglue_wolaiyuce_jingcaizuqiu"];
            GCPLBetViewController * gcjc = [[GCPLBetViewController alloc] initWithLotteryID:1];
            ForecastCell *cell = (ForecastCell *) [tableView cellForRowAtIndexPath:indexPath];
            gcjc.systimestr = cell.numLabel.text;
            gcjc.issString = cell.numLabel.text;
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
            
        }
        if (indexPath.row == 1) {
            [MobClick event:@"event_gonglue_wolaiyuce_shengfucai"];
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
//            pupbool = YES;
//            NewPostViewController *newYtThemeConntrller = [[NewPostViewController alloc] init];
//            newYtThemeConntrller.publishType = kNewTopicController;
//            newYtThemeConntrller.three = YES;
//            
//            if (indexPath.row == 2) {
//                [MobClick event:@"event_gonglue_wolaiyuce_3d"];
//                newYtThemeConntrller.caizhong = @"102";
//            }else if(indexPath.row == 3){
//                [MobClick event:@"event_gonglue_wolaiyuce_pailie3"];
//                newYtThemeConntrller.caizhong = @"5";
//            }else if(indexPath.row == 4){
//                [MobClick event:@"event_gonglue_wolaiyuce_shuangseqiu"];
//                newYtThemeConntrller.caizhong = @"1";
//            }else if(indexPath.row == 5){
//                [MobClick event:@"event_gonglue_wolaiyuce_daletou"];
//                newYtThemeConntrller.caizhong = @"4";
//            }
//            
//            YtTopic *topic1 = [[YtTopic alloc] init];
//            ForecastData * forec = [yudataArray objectAtIndex:indexPath.row];
//            NSString * userId = [[Info getInstance] userId];
//            if (userId == nil||[userId isEqualToString:@""])
//            {
//                NSMutableString *str = [[NSMutableString alloc] init];
//                [str appendString:@"#"];
//                
//                if ([forec.name isEqualToString:@"排列3"]) {
//                    [str appendFormat:@"排列3_%@期预测",  forec.num];
//                    [str appendString:@"#"];
//                    
//                    [str appendFormat:@" #排列3预测# #%@预测#", [[Info getInstance] nickName]];
//                }else{
//                    [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
//                    [str appendString:@"#"];
//                    
//                    [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//                }
//                
//                
//                
//                
//                topic1.nick_name = str;
//                newYtThemeConntrller.myyuce = str;
//                [str release];
//            }
//            else 
//            {
//                NSMutableString *str = [[NSMutableString alloc] init];
//                [str appendString:@"#"];
//                if ([forec.name isEqualToString:@"排列3"]) {
//                    [str appendFormat:@"排列3_%@期预测",  forec.num];
//                    [str appendString:@"#"];
//                    
//                    [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//                }else{
//                    [str appendFormat:@"%@_%@期预测", forec.name, forec.num];
//                    [str appendString:@"#"];
//                    
//                    [str appendFormat:@" #%@预测# #%@预测#", forec.name, [[Info getInstance] nickName]];
//                }
//                
//                
//                topic1.nick_name = str;
//                newYtThemeConntrller.myyuce = str;
//                [str release];
//            }
//            
//            newYtThemeConntrller.mStatus = topic1;
//            
//            if (pupbool) {
//                [self.navigationController pushViewController:newYtThemeConntrller animated:YES];
//            }else{
//
//                
//                [self.navigationController pushViewController:newYtThemeConntrller animated:YES];
//            }
//            
//            
//            [newYtThemeConntrller release];
//            [topic1 release];
            
            
            
            SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
            publishController.microblogType = NewTopicController;
            publishController.three = YES;
            
            if (indexPath.row == 2) {
                [MobClick event:@"event_gonglue_wolaiyuce_3d"];
                publishController.caizhong = @"102";
            }else if(indexPath.row == 3){
                [MobClick event:@"event_gonglue_wolaiyuce_pailie3"];
                publishController.caizhong = @"5";
            }else if(indexPath.row == 4){
                [MobClick event:@"event_gonglue_wolaiyuce_shuangseqiu"];
                publishController.caizhong = @"1";
            }else if(indexPath.row == 5){
                [MobClick event:@"event_gonglue_wolaiyuce_daletou"];
                publishController.caizhong = @"4";
            }
            
            YtTopic *topic1 = [[YtTopic alloc] init];
            ForecastData * forec = [yudataArray objectAtIndex:indexPath.row];
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
                
                
                
                
                topic1.nick_name = str;
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
                
                
                topic1.nick_name = str;
                publishController.myyuce = str;
                [str release];
            }
            
            publishController.mStatus = topic1;
            [topic1 release];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
            [self presentViewController:nav animated: YES completion:nil];
            [publishController release];
            [nav release];
            
        }
        

    }else if ([tableView isEqual:haoTableView]) {
        
        HaoShengYinData * haodata = [haoShengYinArr objectAtIndex:indexPath.row];
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
         info.nikeName = haodata.nickName;
        info.title = @"投注详情";
        info.isHongrenBang = YES;
        info.issure = haodata.issue;
        info.orderId = haodata.ordered;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
        
    }else{
        NSString * string = [arrdict objectAtIndex:indexPath.section];
        NSArray * array = [redDictionary objectForKey:string];
        AnnouncementData * annou = [array objectAtIndex:indexPath.row];
        self.Nickname = annou.user;
        userid = annou.userID;
        
        self.username= annou.userName;
        
//        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"他的彩票", @"他的合买", @"@他", @"他的微博", @"他的资料",nil];
//        [actionSheet showInView:self.mainView];
//        [actionSheet release];
        
        
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        
        [lb LoadButtonName:[NSArray arrayWithObjects:@"他的彩票", @"他的合买", @"@他", @"他的微博",@"他的资料", nil]];
        [lb show];
        [lb release];
    }
   

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
                
        NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row]; 
        
        cell.textLabel.text =text ;
        
        return cell;
        
        
    }else  if ([tableView isEqual:haoTableView]) {
        
        static NSString *CellIdentifier = @"123123";
        
        HaoShengYinCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[HaoShengYinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.delegate = self;
        cell.row = indexPath.row;
        cell.haoData = [haoShengYinArr objectAtIndex:indexPath.row];
        
        return cell;
        
        
    }else if(tableView.tag == 111){
        NSString * cellID = @"cellid";
        ForecastCell * cell = (ForecastCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[[ForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }
        NSLog(@"1111111111");
        cell.data = [yudataArray objectAtIndex:indexPath.row];
        return cell;
    } else{
        

        NSString * cellID = @"cellid";
        HongRenBangCell * cell = (HongRenBangCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[[HongRenBangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] autorelease];
            
        }
            
        
            NSString * strname = [arrdict objectAtIndex:indexPath.section];
            
            NSArray * arraystr = [redDictionary objectForKey:strname];
        
            AnnouncementData * annou = [arraystr objectAtIndex:indexPath.row];
        NSString * string = [arrdict objectAtIndex:indexPath.section];

        if ([string isEqualToString:@"sfc"]) {
            annou.headna = @"胜负彩";
            
        }else if ([string isEqualToString:@"rx9"]){
            annou.headna = @"任选九";
        }else if ([string isEqualToString:@"bd"]){
            annou.headna = @"单场";
        }else if ([string isEqualToString:@"jingcai"]){
            annou.headna = @"竞彩足球";
        }
        if (indexPath.row == [arraystr count]-1) {
            cell.imagebool = YES;
            
        }else{
            cell.imagebool = NO;
        }
       
        if ([arraystr count] == 1) {
            cell.headbool = YES;
        }else{
            cell.headbool = NO;
        }
        
            annou.num = indexPath.row;
            cell.annou = annou;

        
                 
      

        return cell;
        
    }
}

- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = username;
    my.nickName = Nickname;
    my.userid = userid;
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = username;
    my2.nickName = Nickname;
    my2.userid = userid;
    
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
    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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

#pragma mark - actionSheet delegate
- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//他的方案
        NSLog(@"0000000000");
        //		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
        //		my.userName = username;
        //		my.nickName = Nickname;
        //		[self.navigationController pushViewController:my animated:YES];
        //		my.title = Nickname;
        //		[my release];
        [self otherLottoryViewController:0];
    }else if(buttonIndex == 1){
        //        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
        //        my.myLottoryType = MyLottoryTypeOtherHe;
        //		my.userName = username;
        //		my.nickName = Nickname;
        //		[self.navigationController pushViewController:my animated:YES];
        //		my.title = Nickname;
        //		[my release];
        [self otherLottoryViewController:1];
    }else if (buttonIndex == 2){ // @他
        NSLog(@"1111111");
#ifdef isCaiPiaoForIPad
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:Nickname];//传用户名
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
//        [mTempStr appendString:Nickname];//传用户名
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
        [mTempStr appendString:Nickname];//传用户名
        [mTempStr appendString:@" "];
        topic1.nick_name = mTempStr;
        publishController.mStatus = topic1;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        [topic1 release];
        [mTempStr release];
#endif
    }else if (buttonIndex == 3){ // 他的微博
        //        ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:userid];//himID传用户的id
        //        [controller setSelectedIndex:0];
        //        controller.navigationItem.title = @"微博";
        //        [self.navigationController pushViewController:controller animated:YES];
        //		[controller release];
        
        TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
        controller.userID = userid;
        controller.title = @"他的微博";
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        
        
    }else if (buttonIndex == 4){//他的资料
        [[Info getInstance] setHimId:userid];
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:followeesController animated:YES];
        [followeesController release];
    }
}





- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isQuxiao = NO;
}
#pragma mark -
#pragma mark UISearchBarDelegate

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords cpthree:YES];
	[seachPerson setHidesBottomBarWhenPushed:YES];
    seachPerson.titlebool = YES;
    NSLog(@"111111111111111111111111111111111 = %@", keywords);
    seachPerson.titlestring = keywords;
	seachPerson.cpthree = YES;
    
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
		NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
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



#pragma mark - 话题界面
- (void)TopicViewAddview{
    topicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    topicView.backgroundColor = [UIColor clearColor];
    topicView.hidden = YES;
    imageview12 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    //imageview12.image = [UIImageGetImageFromName(@"sachet_9.png")stretchableImageWithLeftCapWidth:0 topCapHeight:200];
   // imageview12.image  = UIImageGetImageFromName(@"sachet_9.png");
    [self.mainView addSubview:imageview12];
  //  [imageview12 release];
    
    //上面的6个按钮 和 我来预测
     label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"#足彩预测#";
    label1.backgroundColor = [UIColor clearColor];
    //label1.font = [UIFont systemFontOfSize:12];
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    label1.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    label1.tag = 1;
    

    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button1 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
    //[button1 setTitle:@"#足彩预测#" forState:UIControlStateNormal];
    button1.frame = CGRectMake(10, 9, 98, 26);
    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
 //   [button1 addTarget:self action:@selector(pressButton11:) forControlEvents:UIControlEventTouchDown];
    button1.tag = 0;
    [button1 addSubview:label1];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"#竞彩预测#";
    label2.backgroundColor = [UIColor clearColor];
   // label2.font = [UIFont systemFontOfSize:12];
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
   label2.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button2 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
   // [button2 setTitle:@"#竞猜预测#" forState:UIControlStateNormal];
    button2.frame = CGRectMake(111, 9, 98, 26);
    [button2 addTarget:self action:@selector(pressButton2:) forControlEvents:UIControlEventTouchUpInside];
  //  [button2 addTarget:self action:@selector(pressButton22:) forControlEvents:UIControlEventTouchDown];
    button2.tag = 1;
    [button2 addSubview:label2];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"#大乐透预测#";
    label3.backgroundColor = [UIColor clearColor];
    //label3.font = [UIFont systemFontOfSize:12];
    label3.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    label3.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button3 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
    //[button3 setTitle:@"#大乐透预测#" forState:UIControlStateNormal];
    button3.frame = CGRectMake(212, 9, 98, 26);
    [button3 addTarget:self action:@selector(pressButton3:) forControlEvents:UIControlEventTouchUpInside];
  //  [button3 addTarget:self action:@selector(pressButton33:) forControlEvents:UIControlEventTouchDown];
    button3.tag = 2;
    [button3 addSubview:label3];
    
    label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"#3D预测#";
    label4.backgroundColor = [UIColor clearColor];
    //label4.font = [UIFont systemFontOfSize:12];
    label4.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    label4.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button4 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
    //[button4 setTitle:@"#3D预测#" forState:UIControlStateNormal];
    button4.frame = CGRectMake(10, 38, 98, 26);
    [button4 addTarget:self action:@selector(pressButton4:) forControlEvents:UIControlEventTouchUpInside];
 //   [button4 addTarget:self action:@selector(pressButton44:) forControlEvents:UIControlEventTouchDown];
    button4.tag = 3;
    [button4 addSubview:label4];
    
    label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = @"#双色球预测#";
    label5.backgroundColor = [UIColor clearColor];
    //label5.font = [UIFont systemFontOfSize:12];
    label5.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    label5.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    UIButton * button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button5 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
   // [button5 setTitle:@"#双色球预测#" forState:UIControlStateNormal];
    button5.frame = CGRectMake(111, 38, 98, 27);
    [button5 addTarget:self action:@selector(pressButton5:) forControlEvents:UIControlEventTouchUpInside];
  //  [button5 addTarget:self action:@selector(pressButton55:) forControlEvents:UIControlEventTouchDown];
    button5.tag = 4;
    [button5 addSubview:label5];
    
    label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 26)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.text = @"#排列3预测#";
    label6.backgroundColor = [UIColor clearColor];
    //label6.font = [UIFont systemFontOfSize:12];
    label6.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    label6.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    UIButton * button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button6 setImage:UIImageGetImageFromName(@"cpthree_an.png") forState:UIControlStateNormal];
    [button6 setImage:UIImageGetImageFromName(@"cpthree_an_0.png") forState:UIControlStateHighlighted];
    //[button6 setTitle:@"" forState:UIControlStateNormal];
    button6.frame = CGRectMake(212, 38, 98, 26);
    [button6 addTarget:self action:@selector(pressButton6:) forControlEvents:UIControlEventTouchUpInside];
  //  [button6 addTarget:self action:@selector(pressButton66:) forControlEvents:UIControlEventTouchDown];
    button6.tag = 5;
    [button6 addSubview:label6];
    
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[myButton setTitle:@"我来预测" forState:UIControlStateNormal];
    myButton.frame = CGRectMake(209, 361, 91, 31);
    [myButton setImage:UIImageGetImageFromName(@"sachet_8.png") forState:UIControlStateNormal];
    [myButton setImage:UIImageGetImageFromName(@"sachet_8_0.png") forState:UIControlStateHighlighted];

    [myButton addTarget:self action:@selector(pressmyButton:) forControlEvents:UIControlEventTouchUpInside];
    //button1.tag = 0;
    
    
    
    //双色球
    int x1 = (arc4random()%95)+15;
//    int index1 = arc4random()%2;
//    int size1 = arc4random()%3;
    UIButton * labelButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton1.frame = CGRectMake(x1, 74, 200, 35);
    [labelButton1 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton1.tag = 0;
    doubleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    doubleLabel.backgroundColor = [UIColor clearColor];
    doubleLabel.textAlignment = NSTextAlignmentLeft;
    doubleLabel.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    doubleLabel.font = [UIFont systemFontOfSize:17];
   // doubleLabel.font = [UIFont systemFontOfSize:17];
   // doubleLabel.text = @"#双色球20012017#";
    [labelButton1 addSubview:doubleLabel];
    
    //3D
    int x2 = (arc4random()%95)+15;
//    int index2 = arc4random()%2;
//    int size2 = arc4random()%3; 
    UIButton * labelButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton2.frame = CGRectMake(x2, 115, 200, 35);
    [labelButton2 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton2.tag = 1;
    threeDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    threeDLabel.backgroundColor = [UIColor clearColor];
    threeDLabel.textAlignment = NSTextAlignmentCenter;
    threeDLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    threeDLabel.font = [UIFont systemFontOfSize:16];
    //threeDLabel.text = @"#3D 20012017#";
    [labelButton2 addSubview:threeDLabel];
    
    
    //排列3
    int x3 = (arc4random()%95)+15;
//    int index3 = arc4random()%2;
//    int size3 = arc4random()%3;
    UIButton * labelButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton3.frame = CGRectMake(x3, 170, 200, 35);
    [labelButton3 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton3.tag = 2;
    arrangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    arrangeLabel.backgroundColor = [UIColor clearColor];
    arrangeLabel.textAlignment = NSTextAlignmentRight;
    arrangeLabel.textColor = [UIColor colorWithRed:248/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    arrangeLabel.font = [UIFont systemFontOfSize:25];
   // arrangeLabel.text = @"#排列320012017#";
    [labelButton3 addSubview:arrangeLabel];
    
    
    //福彩新闻
    int x4 = (arc4random()%95)+15;
//    int index4 = arc4random()%2;
//    int size4 = arc4random()%3;
    UIButton * labelButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton4.frame = CGRectMake(x4, 225, 200, 35);
    [labelButton4 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton4.tag = 3;
    blessingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    blessingLabel.backgroundColor = [UIColor clearColor];
    blessingLabel.textAlignment = NSTextAlignmentLeft;
    blessingLabel.textColor = [UIColor colorWithRed:31/255.0 green:147/255.0 blue:0/255.0 alpha:1];
    blessingLabel.font = [UIFont systemFontOfSize:15];
  //  blessingLabel.text = @"#福彩新闻#";
    [labelButton4 addSubview:blessingLabel];
    
    
    //欧洲杯
    int x5 = (arc4random()%95)+15;
//    int index5 = arc4random()%2;
//    int size5 = arc4random()%3;
    UIButton * labelButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton5.frame = CGRectMake(x5, 280, 200, 35);
    [labelButton5 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton5.tag = 4;
    europeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    europeLabel.backgroundColor = [UIColor clearColor];
    europeLabel.textAlignment = NSTextAlignmentCenter;
    europeLabel.textColor = [UIColor colorWithRed:0/255.0 green:143/255.0 blue:217/255.0 alpha:1];
    europeLabel.font = [UIFont systemFontOfSize:12];
    //europeLabel.text = @"#欧洲杯#";
    [labelButton5 addSubview:europeLabel];
    
    
    //体育新闻
    int x6 = (arc4random()%95)+15;
//    int index6 = arc4random()%2;
//    int size6 = arc4random()%3;
    UIButton * labelButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    labelButton6.frame = CGRectMake(x6, 335, 200, 35);
    [labelButton6 addTarget:self action:@selector(pressLabelButton1:) forControlEvents:UIControlEventTouchUpInside];
    labelButton6.tag = 5;
    sportsLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 200, 35)];
    sportsLabel.backgroundColor = [UIColor clearColor];
    sportsLabel.textAlignment = NSTextAlignmentRight;
    sportsLabel.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    sportsLabel.font = [UIFont systemFontOfSize:20];
   // sportsLabel. text = @"#体育新闻#";
    [labelButton6 addSubview:sportsLabel];
    
    [topicView addSubview:button1];
    [topicView addSubview:button2];
    [topicView addSubview:button3];
    [topicView addSubview:button4];
    [topicView addSubview:button5];
    [topicView addSubview:button6];
  //  [topicView addSubview:myButton];//我来预测
    [topicView addSubview:labelButton1];
    [topicView addSubview:labelButton2];
    [topicView addSubview:labelButton3];
    [topicView addSubview:labelButton4];
    [topicView addSubview:labelButton5];
    [topicView addSubview:labelButton6];
    
    [self.mainView addSubview:topicView];
    //topicView.hidden = NO;
}

- (void)pressButton11:(UIButton *)sender{
    //label1.textColor = [UIColor whiteColor];
}
- (void)pressButton22:(UIButton *)sender{
   // label2.textColor = [UIColor whiteColor];
}
- (void)pressButton33:(UIButton *)sender{
   // label3.textColor = [UIColor whiteColor];
}
- (void)pressButton44:(UIButton *)sender{
    //label4.textColor = [UIColor whiteColor];
}
- (void)pressButton55:(UIButton *)sender{
   // label5.textColor = [UIColor whiteColor];
}
- (void)pressButton66:(UIButton *)sender{
   // label6.textColor = [UIColor whiteColor];
}

- (void)pressmyButton{
   
//    MyForecastViewController * myforecast = [[MyForecastViewController alloc] init];
//    [self.navigationController pushViewController:myforecast animated:YES];
//    [myforecast release];
    
    
}

- (void)yuCeFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSArray * dict = [str JSONValue];
       NSLog(@"dict = %@", dict);
    // NSArray * array = [dict objectForKey:@"data"];
    for (NSDictionary * dictionary in dict) {
        ForecastData * fore = [[ForecastData alloc] init];
        fore.name = [dictionary objectForKey:@"lotteryName"];
        fore.num = [dictionary objectForKey:@"issue"];
        fore.code = [dictionary objectForKey:@"lotteryCode"];
        [yudataArray addObject:fore];
        
        [fore release];
    }
    
    //  NSLog(@"dataArray = %@", dataArray);
    [yuCeTableView reloadData];
}

#pragma mark - 话题下边6个label 的触发函数
- (void)pressLabelButton1:(UIButton *)sender{
    
    
    if (sender.tag < [dataArray count]) {
        
    
        NSString * str = [dataArray objectAtIndex:sender.tag];
    
        [MobClick event:@"event_huati" label:str];
    
    
        TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:str];
        
        topicThemeListVC.cpsanliu = CpSanLiuWuyes;
        [self.navigationController pushViewController:topicThemeListVC animated:YES];
        [topicThemeListVC release];
    
    } 

    
}



#pragma mark - 话题上边的六个按钮 的触发函数

- (void)pressButton1:(UIButton *)sender{
    //label1.textColor = [UIColor blackColor];
  //  YtTheme *theme = [buttonArray objectAtIndex:sender.tag];
   // NSLog(@"%@",theme.ytThemeId);
    [MobClick event:@"event_gonglue_huati_zucai"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#足彩预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
//    redbutton.hidden = YES;
//    topic.hidden = YES;
}
- (void)pressButton2:(UIButton *)sender{
   // label2.textColor = [UIColor blackColor];
    
    [MobClick event:@"event_gonglue_huati_jingcai"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#竞彩预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
   
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}

- (void)pressButton3:(UIButton *)sender{
   // label3.textColor = [UIColor blackColor];

    [MobClick event:@"event_gonglue_huati_daletou"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#大乐透预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
 
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
}

- (void)pressButton4:(UIButton *)sender{
    
   // label4.textColor = [UIColor blackColor];
    [MobClick event:@"event_gonglue_huati_3d"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#3D预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
}

- (void)pressButton5:(UIButton *)sender{
    
  //  label5.textColor = [UIColor blackColor];
    [MobClick event:@"event_gonglue_huati_shuangseqiu"]; 
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#双色球预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
}

- (void)pressButton6:(UIButton *)sender{
   // label6.textColor = [UIColor blackColor];

    [MobClick event:@"event_gonglue_huati_pailie3"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:@"#排列3预测#"];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
}

#pragma mark - 红人榜和话题的触发函数
//1111话题点击函数
- (void)pressTopic:(UIButton *)sender{
    
    huatibtn.selected = NO;
    hongrenbtn.selected = NO;
    yucebtn.selected = NO;
    haoshengyinbut.selected = NO;
    sender.selected = YES;
    if (sender.tag == 1) {
        topicView.hidden = NO;
        myTableView.hidden = YES;
        yuceView.hidden = YES;
        haoTableView.hidden = YES;
        if ([dataArray count] == 0) {
            [request clearDelegatesAndCancel];
            self.request = [ASIHTTPRequest requestWithURL:[NetURL cpSanLiuWu]];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(RecordsDidFinishSelector:)];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];
        }
        
    }else if(sender.tag == 2){
        [MobClick event:@"event_gonglue_huati"];
        if ([redDictionary count]==0) {
            [redRequest clearDelegatesAndCancel];
            self.redRequest = [ASIHTTPRequest requestWithURL:[NetURL caipiaoRedRequest]];
            [redRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [redRequest setDelegate:self];
            [redRequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
            [redRequest setNumberOfTimesToRetryOnTimeout:2];
            [redRequest startAsynchronous];
        }
        topicView.hidden = YES;
        myTableView.hidden = NO;
        yuceView.hidden = YES;
        haoTableView.hidden = YES;
        
    }else if(sender.tag == 3){
        [MobClick event:@"event_gonglue_hongrenbang"];
        if ([yudataArray count] == 0) {
            [yuceRequest clearDelegatesAndCancel];
            self.yuceRequest = [ASIHTTPRequest requestWithURL:[NetURL caipiaolottery]];
            [yuceRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [yuceRequest setDelegate:self];
            [yuceRequest setDidFinishSelector:@selector(yuCeFinishSelector:)];
            [yuceRequest setNumberOfTimesToRetryOnTimeout:2];
            [yuceRequest startAsynchronous];
        }
        topicView.hidden = YES;
        myTableView.hidden = YES;
        haoTableView.hidden = YES;
        yuceView.hidden = NO;
    }else if(sender.tag == 4){
        [MobClick event:@"event_gonglue_wolaiyuce"];
        haoTableView.hidden = NO;
        topicView.hidden = YES;
        myTableView.hidden = YES;
        yuceView.hidden = YES;
        
    }
    
    
    
//    topicView.hidden = NO;
//    myTableView.hidden = YES;
//     [topic setImage:[UIImage imageNamed:@"topic.png"] forState:UIControlStateNormal];
//    [redbutton setImage:[UIImage imageNamed:@"sachet_4.png"] forState:UIControlStateNormal];
}

//红人榜点击函数
//- (void)pressRedbutton:(UIButton *)sender{
//    
//    topicView.hidden = YES;
//    myTableView.hidden = NO;
//    [topic setImage:[UIImage imageNamed:@"topic_0.png"] forState:UIControlStateNormal];
//    [redbutton setImage:[UIImage imageNamed:@"sachet_6.png"] forState:UIControlStateNormal];
//}
	
#pragma mark -
- (void)doBack
{
        topicView.frame = self.view.bounds;
        imageview12.image = [UIImageGetImageFromName(@"login_bg.png")stretchableImageWithLeftCapWidth:0 topCapHeight:200];
        imageview12.frame = self.view.bounds;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] switchToHomeView];
#else
     [self.navigationController popToRootViewControllerAnimated:YES];
#endif
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    redbutton.hidden = NO;
    topic.hidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
         caiboappdelegate.keFuButton.show = YES;
    }else{
         caiboappdelegate.keFuButton.show = NO;
    }
   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    redbutton.hidden = YES;
    topic.hidden = YES;
    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];

    [appdelegate.keFuButton calloff];
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
    [haoShengYinArr release];
    [haoTableView release];
    [yudataArray release];
    [yuceView release];
    [yuCeTableView release];
    [yuceRequest clearDelegatesAndCancel];
    [yuceRequest release];
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
    [label5 release];
    [label6 release];
    [arrdict release];
    [redDictionary release];
    [annuoun release];
    [dataArray release];
    [searchDC release];
    [PKsearchBar release];
    [request clearDelegatesAndCancel];
    [redRequest clearDelegatesAndCancel];
    self.request = nil;
    self.redRequest = nil;
    [myTableView release];
    NSLog(@"1111111111111");
    [doubleLabel release];
    [threeDLabel release];
    [arrangeLabel release];
    [blessingLabel release];
    [europeLabel release];
    [sportsLabel release];
    [topicView release];
	[Nickname release];
	[username release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
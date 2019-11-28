//
//  GouCaiViewController.m
//  caibo
//
//  Created by yao on 12-5-14.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GouCaiViewController.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "ASIHTTPRequest.h"
#import "Info.h"
#import "GCBettingViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "GCJCBetViewController.h"
#import "GC_UserInfo.h"
#import "GouCaiHomeViewController.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "HighFreqViewController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "User.h"
#import "GCHeMaiViewController.h"
#import "UINavigationController+Category.h"
#import "GC_BJDanChangViewController.h"
#import "DaLeTouViewController.h"
#import "FuCai3DViewController.h"
#import "GCGuoGuanInfo.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "FansViewController.h"
#import "ProfileTabBarController.h"
#import "PaiWuOrQiXingViewController.h"
#import "22Xuan5ViewController.h"
#import "QIleCaiViewController.h"
#import "ProfileViewController.h"
#import "ShiShiCaiViewController.h"
#import "NSDate-Helper.h"
#import "Pai3ViewController.h"
#import "MobClick.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "GuoGuanViewController.h"
#import "CP_TabBarViewController.h"
#import "HappyTenViewController.h"
#import "KuaiSanViewController.h"
#import "HomeViewController.h"
#import "KuaiLePuKeViewController.h"
#import "CQShiShiCaiViewController.h"
#import "ChampionViewController.h"
#import "LunBoView.h"
#import "NewsData.h"
#import "LuckyChoseViewController.h"
#import "SharedDefine.h"
#import "GouCaiViewCollectionViewCell.h"
#import "YuJiJinE.h"
#import "GC_ShengfuInfoViewController.h"

@implementation GouCaiViewController
@synthesize mRequest;
@synthesize dataDic;
@synthesize httpRequest;
@synthesize accountManage;
@synthesize fistPage;
@synthesize myTimer;
@synthesize topicidPict;
@synthesize caizhongArray;
@synthesize ggRequest;
@synthesize getMatchRequest;
@synthesize yujirequest;

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

//- (UIButton *)guanggaoView:(NSString *)imageUrl{
//    UIButton * tabHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    tabHeadButton.frame = CGRectMake(0, 0, 320, 50);
//    [tabHeadButton addTarget:self action:@selector(pressTableViewHead:) forControlEvents:UIControlEventTouchUpInside];
//    
//    DownLoadImageView * tabImageView = [[DownLoadImageView alloc] initWithFrame:tabHeadButton.bounds];
//    tabImageView.backgroundColor = [UIColor clearColor];
//    
//    [tabHeadButton addSubview:tabImageView];
//    [tabImageView release];
//    
//    UIButton * topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    topicButton.frame = CGRectMake(320-40, 0, 40, 50);
//    [topicButton addTarget:self action:@selector(pressTopicButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIImageView * topicImage = [[UIImageView alloc] initWithFrame:CGRectMake(40-13-15, 19, 13, 13)];
//    topicImage.backgroundColor = [UIColor clearColor];
//    topicImage.image = UIImageGetImageFromName(@"huodongguanbi.png");
//    [topicButton addSubview:topicImage];
//    [topicImage release];
//    
//    [tabHeadButton addSubview:topicButton];
//    return tabHeadButton;
//}
//
//- (void)guanggaofunc:(NSString *)topicidPict{
//
//    NSArray * allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"shuzicaiguanggao"];
//    
//    
//    for (int i = 0; i < [allHuoDong count]; i++) {
//        NSString * savestr = [allHuoDong objectAtIndex:i];
//        NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
//        NSString * useridstr = [arrSave objectAtIndex:1];
//        if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
//            NSString * topid = [arrSave objectAtIndex:0];
//            NSString * coloser = [arrSave objectAtIndex:2];
//            
//            if ([topid isEqualToString:topicidPict]&& [coloser isEqualToString:@"1"]) {
//                
//                [myTableView setTableHeaderView:nil];
//            }else{
//                [myTableView setTableHeaderView:tabHeadButton];
//            }
//            break;
//            
//            
//        }
//        
//        
//    }
//}

- (id) init {
   
	self = [super init];
	if (self) {
        fistPage = 0;
		ShuziImages = [[NSArray alloc] initWithObjects:@"11xuan5-960.png",@"guangdong11xuan5.png",@"puke-960.png",@"kuaisan-960.png",@"jskuaisan.png",@"kaileishifenimage.png",@"shishi-960.png",@"shuangseqiu-960.png",@"fucai3d-960.png",@"daleitou-960.png",@"7leicai-960.png",@"paiwu-960.png",@"qixing-960.png",@"paisan-960.png",@"CQshishicai.png",@"HBKuaiSan.png",nil];
		ZucaiImages = [[NSArray alloc] initWithObjects:@"logo_01.png",@"logo_04.png",@"logo_14.png",@"logo_03.png",@"logo_02.png",@"goucaiguan.png",@"goucaiguanya.png",nil];
	}
	return self;
}

#pragma mark -
#pragma mark Action 
- (void)sendRequest:(UInt8)type {
	NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetIssueInfo:type];
    SEL sel =  @selector(requestAllFinished:);
//	switch (type) {
//		case shuzicai:
//			sel = @selector(requestShuZiFinished:);
//			break;
//		case zucai:
//			sel = @selector(requestZuCaiFinished:);
//            break;
//		default:
//			break;
//	}
    [mRequest clearDelegatesAndCancel];
    self.mRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [mRequest setRequestMethod:@"POST"];
    [mRequest addCommHeaders];
    [mRequest setPostBody:postData];
	[mRequest setDidFinishSelector:sel];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDidFailSelector:@selector(issueRequestfail:)];
    [mRequest setDelegate:self];
	[mRequest startAsynchronous];
    NSLog(@"%@",[mRequest responseCookies]);
}

- (void)hiddenWWBGimage{
    UIImageView * bgimage = (UIImageView *)[self.mainView viewWithTag:199];
    if (self.caizhongArray == nil || [self.caizhongArray count] == 0) {
       
        bgimage.hidden = NO;
        [myTableView setTableHeaderView:nil];
        
    }else{
        bgimage.hidden = YES;
    }
}

- (void)issueRequestfail:(ASIHTTPRequest *)request{
    
    [self hiddenWWBGimage];
}


- (void)doBack {
    
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
    
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)myInfo {  //合买模式
    GCHeMaiViewController * hemai = [[GCHeMaiViewController alloc] init];
    NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
    if ([arr count] > 0) {
        hemai.systimestr = [arr objectAtIndex:0];
    }else{
        hemai.systimestr = @"";
    }
    
    [self.navigationController pushViewController:hemai animatedWithTransition:(UIViewAnimationTransitionFlipFromRight)];
    [hemai release];
}
    
- (void)typeChange:(UIButton *)sender {
    
    if (!myTableView) {
//        myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.mainView.bounds.size.height-49) style:UITableViewStylePlain];
        myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.mainView.bounds.size.height) style:UITableViewStylePlain];
#ifdef isCaiPiaoForIPad
        myTableView.frame = CGRectMake(45, 15, 300,self.mainView.bounds.size.height-70);
#endif
        [self.mainView addSubview:myTableView];
        
        UIView *tabFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
        tabFootView.backgroundColor=[UIColor clearColor];
        myTableView.tableFooterView=tabFootView;
        [tabFootView release];
        
        myTableView.backgroundColor = [UIColor clearColor];
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        myTableView.delegate = self;
//        myTableView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
//        myTableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
        myTableView.dataSource = self;
        [myTableView release];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 86)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
        imageV.backgroundColor = [UIColor clearColor];
        if (fistPage) {
            imageV.image = UIImageGetImageFromName(@"shuzidi.png");
        }
        else {
            imageV.image = UIImageGetImageFromName(@"zulandi.png");
        }
        [footView addSubview:imageV];
        [imageV release];
//        myTableView.tableFooterView = footView;
        [footView release];
    }
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

- (void)hasLogin {
	[self performSelector:@selector(getAccountInfoRequest) withObject:nil afterDelay:3];
}

- (void)titleViewSearch{
    UIView * titlev = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    titlev.hidden = NO;
    titlev.backgroundColor = [UIColor clearColor];
    
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    titleLabel.text = @"同城彩票";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    [titlev addSubview:titleLabel];
    [titleLabel release];
    
    UIButton * seabut = [UIButton buttonWithType:UIButtonTypeCustom];
    seabut.frame = CGRectMake(160, 12, 41, 19);
    [seabut setImage:UIImageGetImageFromName(@"sachet_2.png") forState:UIControlStateNormal];
    [seabut addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [titlev addSubview:seabut];
    // [titlev addSubview:seabut];
    self.CP_navigation.titleView = titlev;
    
    [titlev release];

}

- (void)becomeActive {
    NSInteger type = aoyuncai;
//    if (fistPage == 0) {
//        type = shuzicai;
//    }
    [self sendRequest:type];
}

#pragma mark -
#pragma mark View lifecycle

    //    默认支持的彩种
- (void)resetCaizhong {
    
    self.caizhongArray = [NSMutableArray arrayWithCapacity:0];
    NSArray * array = [[NSUserDefaults standardUserDefaults] valueForKey:@"serverCaiZhongZhiChi"];
    if (array && [array isKindOfClass:[NSArray class]] && [array count]) {
        [self.caizhongArray addObjectsFromArray:array];
    }
    else {
        [[caiboAppDelegate getAppDelegate] getCaizhongInfo];
    }
}

- (NSString *)picForLottroyid:(NSString *)picLottroyid {
    NSArray *IDarray =[NSArray arrayWithObjects:@"119",@"121",@"122",@"012",@"013",@"011",@"006",@"001",@"002",@"113",@"003",@"109",@"110",@"108",@"014",@"019", LOTTERY_ID_JILIN, LOTTERY_ID_JIANGXI_11, LOTTERY_ID_ANHUI,nil];
    if ([IDarray indexOfObject:picLottroyid] < [ShuziImages count]) {
        return [ShuziImages objectAtIndex:[IDarray indexOfObject:picLottroyid]];
    }
    NSArray *lotroyidarry = [NSArray arrayWithObjects:@"201",@"300",@"301",@"400",@"200",@"20106",@"20107",nil];
    if ([lotroyidarry indexOfObject:picLottroyid] < [ZucaiImages count]) {
        return [ZucaiImages objectAtIndex:[lotroyidarry indexOfObject:picLottroyid]];
    }
    return nil;
}

- (NSString *)nameForLottroyid:(NSString *)lottroyid{
    NSArray *array1 = [NSArray arrayWithObjects:@"<11选5> 山东",@"<11选5> 广东",@"<快乐扑克>",@"<快3> 新",@"<快3> 江苏",@"<快乐十分>",@"<时时彩> 黑龙江",@"<双色球>",@"<福彩3D>",@"<大乐透>",@"<七乐彩>",@"<排列5>",@"<七星彩>",@"<排列3>",@"<时时彩> 老",@"<快3> 湖北",@"<快3> 吉林" ,@"<11选5> 江西" ,@"<快3> 新",nil];
    NSArray *IDarray =[NSArray arrayWithObjects:@"119",@"121",@"122",@"012",@"013",@"011",@"006",@"001",@"002",@"113",@"003",@"109",@"110",@"108",@"014",@"019",LOTTERY_ID_JILIN,LOTTERY_ID_JIANGXI_11, LOTTERY_ID_ANHUI,nil];
    if ([IDarray indexOfObject:lottroyid] < [array1 count]) {
        return [array1 objectAtIndex:[IDarray indexOfObject:lottroyid]];
    }
    
    NSArray *array2 = [NSArray arrayWithObjects:@"<竞彩足球>",@"<胜负彩>",@"<任选九>",@"<单场>",@"<竞彩篮球>",@"<世界杯> 冠军",@"<世界杯> 冠亚军",nil];
    NSArray *lotroyidarry = [NSArray arrayWithObjects:@"201",@"300",@"301",@"400",@"200",@"20106",@"20107",nil];
    if ([lotroyidarry indexOfObject:lottroyid] < [array2 count]) {
        return [array2 objectAtIndex:[lotroyidarry indexOfObject:lottroyid]];
    }
    
    return nil;
}

- (void)activityRequestFunc{

    [self.ggRequest clearDelegatesAndCancel];
   // self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL activityInfoType:@"3"]];//1.表示投注站活动 2.表示高频版365的活动 默认为2  3表示购彩大厅数字彩 4表示购彩大厅足篮彩
    
//    NSString * pagesize = @"20";
//    int page = 1;
    
//    if (fistPage==0) {
//#ifdef isHaoLeCai
//        self.ggRequest = [ASIHTTPRequest requestWithURL:[NetURL activityInfoType:@"6"]];
//#else
//        self.ggRequest = [ASIHTTPRequest requestWithURL:[NetURL activityInfoType:@"3"]];
//
//#endif
//    }
//    else
//    {
//#ifdef isHaoLeCai
//        self.ggRequest = [ASIHTTPRequest requestWithURL:[NetURL activityInfoType:@"7"]];
//#else
        self.ggRequest = [ASIHTTPRequest requestWithURL:[NetURL activityInfoType:@"4"]];
//#endif
//    }
    
    [ggRequest setTimeOutSeconds:20.0];
    [ggRequest setDidFinishSelector:@selector(activityFinish:)];
    [ggRequest setDidFailSelector:@selector(activityFail:)];
    [ggRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [ggRequest setDelegate:self];
    [ggRequest startAsynchronous];
}

- (void)activityShowHidderImageUrl:(NSString *)url{
   
}
- (void)activityFinish:(ASIHTTPRequest *)mrequest{
    
    
    NSString * returnRequestStr = [mrequest responseString];
    NSLog(@"returnRequestStr = %@", returnRequestStr);
    if (returnRequestStr) {
        
        NSArray * allArray = [returnRequestStr JSONValue];
        if ([allArray count] == 0) {
//            if (fistPage == 0) {
//                [self setLuckyView];
//            }else{
//                [myTableView setTableHeaderView:nil];
//            }
            return;
        }
        
        if(bannerArray){
        
            [bannerArray removeAllObjects];
        }
        
//        //数字彩添加的特殊的数据类(魔法球的banner图)
//        if(self.fistPage == 0){
//            NewsData * newsdata = [[NewsData alloc] init];
//            newsdata.newsid =@"100001";
//            [bannerArray addObject:newsdata];
//            [newsdata release];
//        }
        
        for (NSDictionary * dic in allArray) {
            
            NewsData * newsdata = [[NewsData alloc] init];
            newsdata.newsid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"topicid"]];
            [self.topicidPict appendFormat:@"%@-",[dic objectForKey:@"topicid"]];
            newsdata.attach_small = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]];
            newsdata.type_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
            newsdata.flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            newsdata.lottery_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lotteryId"]];
            newsdata.play_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"play"]];
            newsdata.bet_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bet"]];
            newsdata.staySecond = [NSString stringWithFormat:@"%@",[dic objectForKey:@"frequency"]];
            [bannerArray addObject:newsdata];
            [newsdata release];
            
        }
        
        
        if(bannerArray.count){
        
            [bannerView setImageWithArray:bannerArray];
        
        }
        
        
        
        NSArray * allHuoDong = nil;
//        if (fistPage == 0) {
//            allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"shuzihuodong"];
//        }else{
            allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"zucaihuodong"];
            
//        }
        
        for (int i = 0; i < [allHuoDong count]; i++) {
            NSString * savestr = [allHuoDong objectAtIndex:i];
            NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
            NSString * useridstr = @"";
            if ([arrSave count] > 1) {
                useridstr = [arrSave objectAtIndex:1];
            }
            
            if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
                NSString * topid = [arrSave objectAtIndex:0];
                NSString * coloser = [arrSave objectAtIndex:2];
                
                if ([topid isEqualToString:self.topicidPict]&& [coloser isEqualToString:@"1"]) {
                    
//                    [myTableView setTableHeaderView:nil];
                    headerView.frame = CGRectZero;
//                    if (fistPage == 0) {
//                        [self setLuckyView];
//                    }
                    
                }else{
                    [self.mainView addSubview:headerView];
//                    [myTableView setTableHeaderView:headerView];
                }
                break;
                
                
            }
            
            
        }
    
    }
    
}
-(void)setLuckyView
{
    NSLog(@"setLuckyView");
    
//    UIView *headerview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
//    headerview.backgroundColor = [UIColor clearColor];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:UIImageGetImageFromName(@"luckyrukou.png") forState:UIControlStateNormal];
//    [btn setFrame:CGRectMake(0, 0, 320, 75)];
//    [btn addTarget:self action:@selector(PressLucky:) forControlEvents:UIControlEventTouchUpInside];
//    [headerview addSubview:btn];
//    
//    [myTableView setTableHeaderView:headerview];
//    
//    [headerview release];
    
}
-(void)PressLucky:(UIButton *)sender
{
    LuckyChoseViewController *luck = [[LuckyChoseViewController alloc] init];
    [self.navigationController pushViewController:luck animated:YES];
    [luck release];
}
- (void)activityFail:(ASIHTTPRequest *)mrequest{
    
    if (fistPage == 0) {
         [self setLuckyView];
    }else{
        [myTableView setTableHeaderView:nil];
    }
}

-(void)CloseBanner:(UIButton *)sender
{
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
    
    
    [myTableView setTableHeaderView:nil];
    if (fistPage == 0) {
        [self setLuckyView];
    }
    
    NSArray * allHuoDong = nil;
    if (fistPage == 0) {
        allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"shuzihuodong"];
    }else{
        allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"zucaihuodong"];
        
    }
    
    NSMutableArray * saveMutable = [[NSMutableArray alloc] initWithCapacity:0];
    BOOL saveBool = NO;
    for (int i = 0; i < [allHuoDong count]; i++) {
        NSString * savestr = [allHuoDong objectAtIndex:i];
        NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
        NSString * useridstr = @"";
        if ([arrSave count] > 1) {
            useridstr = [arrSave objectAtIndex:1];
        }
        if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
            NSString * savestring = [NSString stringWithFormat:@"%@ %@ 1", self.topicidPict , [[Info getInstance] userId]];
            [saveMutable addObject:savestring];
            saveBool = YES;
            
        }else{
            
            [saveMutable addObject:savestr];
            
        }
        
        
    }
    if ([saveMutable count] == 0 || saveBool == NO) {
        NSString * huodongid = [NSString stringWithFormat:@"%@ %@ 1", self.topicidPict, [[Info getInstance] userId]];
        [saveMutable addObject:huodongid];
    }
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        if (fistPage == 0) {
            
            [[NSUserDefaults standardUserDefaults] setValue:saveMutable forKey:@"shuzihuodong"];//前面是帖子id 空格 用户id
        }else{
            
            [[NSUserDefaults standardUserDefaults] setValue:saveMutable forKey:@"zucaihuodong"];//前面是帖子id 空格 用户id
            
        }
        
        
    }
    [saveMutable release];

}

- (void)pressTableViewHead:(UIButton *)sender{
    
#ifdef isHaoLeCai
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.titleLabel.text]];
#else
    [mRequest clearDelegatesAndCancel];
    [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:self.topicidPict]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDidFinishSelector:@selector(headRequestFinish:)];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest startAsynchronous];
#endif
 
}

- (void)headRequestFinish:(ASIHTTPRequest *)mrequest{


    NSString *result = [mrequest responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    [detailed setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];

}

- (void)goMy {
    GouCaiHomeViewController *home = [[GouCaiHomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
    [home release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//	if (!loadview) {
//        loadview = [[UpLoadView alloc] init];
//    }
   
//    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate.window addSubview:loadview];
//    [loadview release];
    
	self.dataDic = [NSMutableDictionary dictionary];
//	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
//	self.CP_navigation.leftBarButtonItem = left;
    
    
    //--------------------------------扁平化 by sichuanlin
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
	comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)fromDate:date];
    weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSLog(@"%ld",(long)weekday);
    
	
//	UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView *backImageV = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImageV.backgroundColor=[UIColor colorWithRed:247/255.0 green:240/255.0 blue:223/255.0 alpha:1];
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    UIImageView * failBgImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    failBgImage.tag = 199;
    failBgImage.hidden = YES;
    failBgImage.backgroundColor = [UIColor clearColor];
    failBgImage.image = UIImageGetImageFromName(@"wwlgybg.png");
    [self.mainView addSubview:failBgImage];
    [failBgImage release];
    
    UIImageView * renImage = [[UIImageView alloc] init];
    if (IS_IPHONE_5) {
        renImage.frame = CGRectMake((self.mainView.frame.size.width - 227)/2, 166, 227, 214);
    }else{
        renImage.frame = CGRectMake((self.mainView.frame.size.width - 227)/2, 126, 227, 214);
    }
    
    renImage.backgroundColor = [UIColor clearColor];
    renImage.image = UIImageGetImageFromName(@"gcdtwx.png");
    [failBgImage addSubview:renImage];
    [renImage release];
    
    
    NSLog(@"%f",self.mainView.frame.origin.y);
    NSLog(@"%f",self.mainView.frame.size.height);
    self.caizhongArray = [NSMutableArray arrayWithCapacity:0];
//    [self resetCaizhong];
//	[self performSelector:@selector(typeChange:) withObject:nil];
    

#ifdef isCaiPiaoForIPad 
    [self.CP_navigation setLeftBarButtonItem:nil];
#endif
    
     [self activityRequestFunc];
    
    
    bannerArray = [[NSMutableArray alloc] initWithCapacity:0];
    topicidPict = [[NSMutableString alloc] init];

    
    mainHeaderView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 165)];
    [mainHeaderView setBackgroundColor:[UIColor clearColor]];
    
    bannerView = [[LunBoView alloc] initWithFrame:CGRectMake(0, 0, 320, 120) newsViewController:self];
    bannerView.isAnother = YES;
    bannerView.hiddenGrayTitleImage = YES;
    //        if(self.fistPage == 0){
    //            bannerView.isShuZiInfo = YES;
    //        }else{
    bannerView.isShuZiInfo = NO;
    
    //        }
    [mainHeaderView addSubview:bannerView];
    
    
    
    UIButton * topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topicButton.frame = CGRectMake(320-60, 0, 60, 60);
    topicButton.tag = 9000;
    [topicButton addTarget:self action:@selector(CloseBanner:) forControlEvents:UIControlEventTouchUpInside];
    topicButton.hidden = YES;
    
    UIImageView * topicImage = [[UIImageView alloc] initWithFrame:CGRectMake(60-13-15, 15, 13, 13)];
    topicImage.backgroundColor = [UIColor clearColor];
    topicImage.image = UIImageGetImageFromName(@"huodongguanbi.png");
    [topicButton addSubview:topicImage];
    [topicImage release];
    
    [bannerView addSubview:topicButton];
    
    eventsView = [[FocusEventsView alloc] init];
    eventsView.hidden = YES;
    eventsView.delegate = self;
    [mainHeaderView addSubview:eventsView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //cell间距
    layout.minimumInteritemSpacing = 0;
    //cell行距
    layout.minimumLineSpacing = 0;
    
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height - 49) collectionViewLayout:layout];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [self.mainView addSubview:myCollectionView];
    myCollectionView.backgroundColor = [SharedMethod getColorByHexString:@"ecedf1"];
    
    [myCollectionView registerClass:[GouCaiViewCollectionViewCell class] forCellWithReuseIdentifier:@"lotteryCell"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mainHeader"];

    
    matchDataArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self getMatch];
}

- (void)goExper {
    NSDate *now =[NSDate date];
    if ([[now getFormatYearMonthDayHour] doubleValue] < 2017042912) {
        return;
    }
    UITabBarController *tabar = [[caiboAppDelegate getAppDelegate] createExpert];
    [self.navigationController pushViewController:tabar animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backaction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAction) name:@"backaction" object:nil];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getMatch{
    
    NSMutableData *postData;
    
    [getMatchRequest clearDelegatesAndCancel];
    postData = [[GC_HttpService sharedInstance] getFocusMatch];
    self.getMatchRequest = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [getMatchRequest addCommHeaders];
    [getMatchRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [getMatchRequest appendPostData:postData];
    [getMatchRequest setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [getMatchRequest setDelegate:self];
    [getMatchRequest setDidFinishSelector:@selector(getMatchRequestFinished:)];
    [getMatchRequest startAsynchronous];
    
    
}

-(void)getMatchRequestFinished:(ASIHTTPRequest*)mrequest {
    NSDictionary *dic = [mrequest userInfo];
    
    NSString *obj;
    obj = [dic objectForKey:@"key"];
    NSLog(@"obj = %@", obj);
    NSData *responseData = [mrequest responseData];
    
    if (responseData) {
        if(obj&&[obj isEqualToString:@"duizhen"]){// 对阵列表
  
            GC_JingCaiDuizhenChaXun *duizhen = [[GC_JingCaiDuizhenChaXun alloc] initWithResponseData:responseData WithRequest:mrequest];
            
            [matchDataArray removeAllObjects];
            
            [matchDataArray addObjectsFromArray:duizhen.listData];
            
            if (matchDataArray && matchDataArray.count) {
//                if (matchDataArray.count == 1) {
//                    eventsView.bgImageView.frame = CGRectMake(eventsView.bgImageView.frame.origin.x, eventsView.bgImageView.frame.origin.y, eventsView.bgImageView.frame.size.width, 135);
//                }else{
                    eventsView.bgImageView.frame = CGRectMake(eventsView.bgImageView.frame.origin.x, eventsView.bgImageView.frame.origin.y, eventsView.bgImageView.frame.size.width, 145);

//                }
                eventsView.frame = CGRectMake(0, ORIGIN_Y(bannerView) + 10, MyWidth, eventsView.bgImageView.frame.size.height + 10);

                eventsView.hidden = NO;
            }else{
                eventsView.frame = CGRectMake(0, ORIGIN_Y(bannerView) + 10, MyWidth, 0);
                eventsView.hidden = YES;
            }
            eventsView.dataArray = matchDataArray;
            if (!_goExperBtn) {
                _goExperBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                
                [_goExperBtn setImage:[UIImage imageNamed:@"zhuanjiatuijianrukou.png"] forState:UIControlStateNormal];
                [_goExperBtn addTarget:self action:@selector(goExper) forControlEvents:UIControlEventTouchUpInside];
                [mainHeaderView addSubview:_goExperBtn];
            }
            _goExperBtn.frame = CGRectMake(7.5, ORIGIN_Y(eventsView), 305, 60);
            
            mainHeaderView.frame = CGRectMake(0, 0, MyWidth, ORIGIN_Y(eventsView) + 70);
            [myCollectionView reloadData];
        }
    }
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == 0) {
            UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mainHeader" forIndexPath:indexPath];
            [header addSubview:mainHeaderView];
            reusableview = header;
        }
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MyWidth, mainHeaderView.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * dataArray = [dataDic valueForKey:@"all"];
    NSInteger lotteryCount = dataArray.count;
    if (lotteryCount%2) {
        lotteryCount = dataArray.count + 1;
    }
    return lotteryCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.mainView.frame.size.width/2.0, 75);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"lotteryCell";
    GouCaiViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSArray * dataArray = [dataDic valueForKey:@"all"];

    if (indexPath.row < dataArray.count) {
        IssueRecord *record = [dataArray objectAtIndex:indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:record.iconUrl] placeholderImage:UIImageGetImageFromName(@"wwlicon.png")];
        
        cell.nameLabel.text = record.lotteryName;
        cell.contentLabel.text = record.content;
    }else{
        cell.iconImageView.image = nil;
        cell.nameLabel.text = @"";
        cell.contentLabel.text = @"";
    }

    
    if (indexPath.row%2) {
        cell.bgView.frame = CGRectMake(0, cell.bgView.frame.origin.y, cell.bgView.frame.size.width, cell.bgView.frame.size.height);
    }else{
        cell.bgView.frame = CGRectMake(7, cell.bgView.frame.origin.y, cell.bgView.frame.size.width, cell.bgView.frame.size.height);
    }
    UIBezierPath *maskPath = nil;
    if (dataArray.count == 1) {
        if (indexPath.row == 0) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(6, 0)];
        }else if (indexPath.row == 1) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 0)];
        }
    }else{
        if (indexPath.row == 0) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(6, 0)];
        }else if (indexPath.row == 1) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(6, 0)];
        }
        else if (indexPath.row == dataArray.count - 1) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(6, 0)];
        }
        else if (indexPath.row == dataArray.count) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 0)];
        }
    }
    
    if (maskPath) {
        CAShapeLayer * maskLayer = [[[CAShapeLayer alloc] init] autorelease];
        maskLayer.frame = cell.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.bgView.layer.mask = maskLayer;
        
    }
    else{
        CAShapeLayer * maskLayer = [[[CAShapeLayer alloc] init] autorelease];
        maskLayer.frame = cell.bgView.bounds;
        maskLayer.path = [UIBezierPath bezierPathWithRect:maskLayer.frame].CGPath;
        cell.bgView.layer.mask = maskLayer;
    }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * dataArray = [dataDic valueForKey:@"all"];

    if (indexPath.row < dataArray.count) {
        [self touchLotteryIndexPath:indexPath];
    }
}


- (void)getAccountInfoRequest
{
    NSString *_username = [NSString stringWithFormat:@"%@",[[Info getInstance] userName]];
    if ([_username length] > 4 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:_username];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpRequest setDidFailSelector:@selector(reqAccountInfoFailed:)];
        [httpRequest startAsynchronous];
    }
    
    
//    
//    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"]&&[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"]) {
//        GouCaiHomeViewController *gc = [[[GouCaiHomeViewController alloc] init] autorelease];
//        gc.isNotPerfect = NO;
//    }
    
    
}

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{

    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            self.accountManage = aManage;
            [GC_UserInfo sharedInstance].accountManage = aManage;
        }
		[aManage release];

    }
}

- (void)timechange {
    seconds ++;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.myTimer invalidate];
    self.myTimer = nil;
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    
//    if (bannerView.lunBoRunLoopRef) {
//        CFRunLoopStop(bannerView.lunBoRunLoopRef);
//        bannerView.lunBoRunLoopRef = nil;
//    }
}

- (void)showTableViewHead{

    NSArray * allHuoDong = nil;
    if (fistPage == 0) {
        allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"shuzihuodong"];
    }else{
        allHuoDong = [[NSUserDefaults standardUserDefaults] objectForKey:@"zucaihuodong"];
        
    }
    
    for (int i = 0; i < [allHuoDong count]; i++) {
        NSString * savestr = [allHuoDong objectAtIndex:i];
        NSArray * arrSave = [savestr componentsSeparatedByString:@" "];
        NSString * useridstr = @"";
        if ([arrSave count] > 1) {
            useridstr = [arrSave objectAtIndex:1];
        }
        if ([useridstr isEqualToString:[[Info getInstance] userId]]) {
            NSString * topid = @"";
            if ([arrSave count] > 0) {
                topid = [arrSave objectAtIndex:0];
            }
            NSString * coloser = @"";
            if ([arrSave count] > 2) {
                coloser = [arrSave objectAtIndex:2];
            }
            
            if ([topid isEqualToString:self.topicidPict]&& [coloser isEqualToString:@"1"]) {
                
                [myTableView setTableHeaderView:nil];
                if (fistPage == 0) {
                    [self setLuckyView];
                }
                
            }else{
//                [myTableView setTableHeaderView:tabHeadButton];
            }
            break;
            
            
        }
        
        
    }
}

 - (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     [UIApplication sharedApplication];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:@"BecomeActive" object:nil];
     [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(becomeActive) object:nil];
     [self becomeActive];
     caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
     caiboappdelegate.keFuButton.hidden = NO;
     [caiboappdelegate.keFuButton chulaitiao];
     if (caiboappdelegate.keFuButton.markbool)
     {
         caiboappdelegate.keFuButton.show = YES;
     }else
     {
         caiboappdelegate.keFuButton.show = NO;
     }
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
//        //--------------------------------------bianpinghua by sichuanlin
//        //		UIBarButtonItem *right = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
//        UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
//        
//        self.CP_navigation.rightBarButtonItem = right;
//    }
//    else {
//        UIBarButtonItem *right = [Info itemInitWithTitle:@"我的彩票" Target:self action:@selector(goMy) ImageName:nil Size:CGSizeMake(90,30)];
//        
//        self.CP_navigation.rightBarButtonItem = right;
//    }
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)fistPage] forKey:@"defaultBuy"];
     
     [self getAccountInfoRequest];
//     [self showTableViewHead];
    
    [self getMatch];
    [self activityRequestFunc];
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







#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.caizhongArray count];
//	if (fistPage) {
//		return [ZucaiImages count];
//	}
//	else {
//		return [ShuziImages count];
//	}
//    
//    
//    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (setion[indexPath.row] == 1) {
        return 60+78;
    }
//	return 78.0;
    return 90;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    GouCaiCell *cell = (GouCaiCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GouCaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.btnTitleColor = [UIColor colorWithRed:72/255.0 green:105/255.0 blue:131/255.0 alpha:1];
        cell.btnFontSize = 10;
        cell.normalHight = 76;
        cell.selectHight = 60+76;
        cell.backgroundColor=[UIColor clearColor];
    }


    cell.tag = indexPath.row;
    cell.cp_canopencelldelegate = self;
    cell.gouCaiCellDelegate = self;
    cell.isEnable = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    cell.selectedBackgroundView = [[[UIView alloc] init] autorelease];
//    cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:254/255.0 green:253/255.0 blue:249/255.0 alpha:0.4];
    

    cell.pianyitime = seconds;
        if ([tableView isEqual:myTableView]) {
            if (fistPage == 1) {
                NSArray *array = [dataDic objectForKey:@"zucai"];
                [cell LoadData:nil];
//                cell.nameLabel.text = [self nameForLottroyid:[self.caizhongArray objectAtIndex:indexPath.row]];
                    if (indexPath.row <5) {
                        cell.isEnable = YES;
                    }
                    else {
                        cell.isEnable = NO;
                    }

                    BOOL cunzai = NO;
                    int b =0;
                    
                    if ( [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]) {
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"GChemaidating.png",@"GCfanqihemai.png",@"GCguoguantongji.png",@"GC_daigou.png", nil] TitileArray:[NSArray arrayWithObjects:@"合买大厅",@"发起合买", @"中奖排行",@"代购",nil]];
                    
                    }
                    else {
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"GChemaidating.png",@"GCfanqihemai.png",@"GC_daigou.png", nil] TitileArray:[NSArray arrayWithObjects:@"合买大厅",@"发起合买",@"代购",nil]];
                    
                    }
                    for (int i = 0; i <[array count]; i++) {
                        IssueRecord *a =[array objectAtIndex:i];                        
                        if (indexPath.row < [self.caizhongArray count] &&[a.lotteryId isEqualToString:[caizhongArray objectAtIndex:indexPath.row]]) {
                            cunzai = YES;
                            b = i;
                            i = (int)[array count];
                        }
                    }
                    
                    if (cunzai) {
                        cell.isEnable = YES;
                        [cell LoadData:[array objectAtIndex:b] Type:zucai];
                    }
//                cell.iconImageView.image = UIImageGetImageFromName([self picForLottroyid:[self.caizhongArray objectAtIndex:indexPath.row]]);
            }
            else {
                if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"011"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"012"] ||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"006"]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"122"] ||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"121"] ||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"013"]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"014"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"019"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JILIN] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_ANHUI]) {
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"GC_daigou.png",nil] TitileArray:[NSArray arrayWithObjects:@"代购",nil]];
                }
                else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"119"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"123"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_SHANXI_11]){
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"GC_daigou.png",nil] TitileArray:[NSArray arrayWithObjects:@"代购",nil]];
                }
                
                else {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"GChemaidating.png",@"GCfanqihemai.png",@"GC_daigou.png", nil] TitileArray:[NSArray arrayWithObjects:@"合买大厅",@"发起合买",@"代购",nil]];

                }
                
                
//                cell.nameLabel.text = [self nameForLottroyid:[self.caizhongArray objectAtIndex:indexPath.row]];
                cell.isEnable = YES;
                if (indexPath.row <= 11) {
                    
                    cell.isEnable = YES;
                }
                else {
                    cell.isEnable = NO;
                }
                
                NSArray *array = [dataDic objectForKey:@"shuzicai"];
                int b =0;
                BOOL qixingbool = NO;
                for (int i = 0; i <[array count]; i++) {
                    
                    IssueRecord *a =[array objectAtIndex:i];
                    NSLog(@"lotteryName%@,lotteryId%@",a.lotteryName,a.lotteryId);
                    if ([a.lotteryId isEqualToString:[self.caizhongArray objectAtIndex:indexPath.row]]) {
                        b = i;
                        i = (int)[array count];
                        qixingbool = YES;
                    }
                }
                
                
                if (qixingbool == NO) {
                    cell.isEnable = NO;
                    [cell LoadData:nil Type:shuzicai];
                }else{
                    cell.isEnable = YES;
                    [cell LoadData:[array objectAtIndex:b]Type:shuzicai];
                    
                }
//                cell.iconImageView.image = UIImageGetImageFromName([self picForLottroyid:[self.caizhongArray objectAtIndex:indexPath.row]]);
                
                
                //快三骰子图
                if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"013"]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"012"]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"019"]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JILIN]||[[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_ANHUI]){
                
                    [cell.shaiziIma1 setImage:[UIImage imageNamed:@"shaizi11.png"]];
                    [cell.shaiziIma2 setImage:[UIImage imageNamed:@"shaizi22.png"]];
                    [cell.shaiziIma3 setImage:[UIImage imageNamed:@"shaizi33.png"]];

                }else{
                
                    [cell.shaiziIma1 setImage:nil];
                    [cell.shaiziIma2 setImage:nil];
                    [cell.shaiziIma3 setImage:nil];
                }
                //双色球、大乐透金币图
//                if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"001"] || [[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"113"]){
//                    
//                    for (int i = 0; i <[array count]; i++) {
//                        
//                        IssueRecord *a =[array objectAtIndex:i];
//                        NSLog(@"lotteryName%@,lotteryId%@",a.lotteryName,a.lotteryId);
//                        if ([a.lotteryId isEqualToString:[self.caizhongArray objectAtIndex:indexPath.row]]) {
//                            NSLog(@"%@",a.content);
//                            if([a.content hasPrefix:@"奖池滚存:"]){
//                                
//                                NSString *money = [a.content substringFromIndex:5];
//                                
//                                money = [money stringByReplacingOccurrencesOfString:@"," withString:@""];
//                                if([money integerValue] > 200000000 && [money integerValue] < 500000000){
//                                
//                                    [cell.jinbiIma setImage:[UIImage imageNamed:@"money_2.png"]];
//                                }
//                                if([money integerValue] > 500000000){
//                                
//                                    [cell.jinbiIma setImage:[UIImage imageNamed:@"money_5.png"]];
//                                }
//                                
//                            }
//                        }
//                    }
//                }
//                else{
//                    [cell.jinbiIma setImage:nil];
//                }
            }

        }
    if (setion[indexPath.row] == 1) {
        [cell showButonScollWithAnime:NO];
    }
    else {
        [cell hidenButonScollWithAnime:NO];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (fistPage == 0) {
        
    }
    return nil;
}



#pragma mark -
#pragma mark Table view delegate

- (void)pushHtml5OpenUrl:(NSString *)url cell:(GouCaiCell *)cell{

    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:h5url]];
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        
        NSString * userNameString = @"";
        Info * userInfo = [Info getInstance];
        if ([userInfo.userName length] > 0) {//判断用户名是否为nil
            userNameString = userInfo.userName;
        }
        NSString * sessionid = @"";
        if ([GC_HttpService sharedInstance].sessionId) {
            sessionid = [GC_HttpService sharedInstance].sessionId;
        }
        NSString * flag = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@", sessionid, userNameString]];
        NSString * h5url = [NSString stringWithFormat:@"http://%@?sessionID=%@&sid=%@&newVersion=%@&lotteryId=%@&play=&bet=&flag=%@&client=ios", url,sessionid,[infoDict objectForKey:@"SID"], newVersionKey, cell.myrecord.lotteryId, flag];
        myWeb=[[MyWebViewController alloc]init];
        myWeb.delegate = self;
        myWeb.hiddenNav = YES;
        [myWeb LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
        [self.navigationController pushViewController:myWeb animated:YES];
        [myWeb release];
    }
    else {

        [self doLogin];

        
    }
   

}

- (void)myWebView:(UIWebView *)webView Request:(NSURLRequest *)request{
    
    [myWeb.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
            // 体彩
            if (fistPage == 1) {
                GouCaiCell *h5cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                if ([h5cell.myrecord.h5Url length] > 0) {
                   
                    [self pushHtml5OpenUrl:h5cell.myrecord.h5Url cell:h5cell];
                }else{
                    NSString *caizhongID = [self.caizhongArray objectAtIndex:indexPath.row];
                    if ([caizhongID length] > 3) {
                        caizhongID = [caizhongID substringToIndex:3];
                    }
                    
                    if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201dg"]) {//
                        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                        gcjc.gcdgBool = YES;
                        NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                        
                        if ([arr count] > 0) {
                            gcjc.systimestr = [arr objectAtIndex:0];
                        }else{
                            gcjc.systimestr = @"";
                        }
                        [MobClick event:@"event_goucai_caizhong" label:@"竞彩足球单关"];
                        [MobClick event:@"event_goumai_zulancai_jingcaidg"];
                        NSLog(@"gcjc = %@", gcjc.systimestr);
                        [self.navigationController pushViewController:gcjc animated:YES];
                        [gcjc release];
                    }
                    
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"400sf"]) {
                        [MobClick event:@"event_goucai_caizhong" label:@"胜负过关"];
                        GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:10919];
                        [self.navigationController pushViewController:bjdanchang animated:YES];
                        [bjdanchang release];

                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201bf"]) {
                        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                        gcjc.dgType = dgMatchBifen;
                        [MobClick event:@"event_goucai_caizhong" label:@"竞彩比分"];
                        NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                        
                        if ([arr count] > 0) {
                            gcjc.systimestr = [arr objectAtIndex:0];
                        }else{
                            gcjc.systimestr = @"";
                        }
                        [MobClick event:@"event_goumai_zulancai_jingcaibifen"];
                        NSLog(@"gcjc = %@", gcjc.systimestr);
                        [self.navigationController pushViewController:gcjc animated:YES];
                        [gcjc release];
                    }
                    
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201"]) {
                        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                        //                    gcjc.gcdgBool = YES;
                        NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                        
                        if ([arr count] > 0) {
                            gcjc.systimestr = [arr objectAtIndex:0];
                        }else{
                            gcjc.systimestr = @"";
                        }
                        [MobClick event:@"event_goucai_caizhong" label:@"竞彩足球"];
                        [MobClick event:@"event_goumai_zulancai_jingcai"];
                        NSLog(@"gcjc = %@", gcjc.systimestr);
                        [self.navigationController pushViewController:gcjc animated:YES];
                        [gcjc release];
                    }
                    else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"]) {
                        [MobClick event:@"event_goucai_caizhong" label:@"胜负彩"];
                        [MobClick event:@"event_goumai_zulancai_shengfucai"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        NSLog(@"label = %@", cell.jieqidate);
                        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                        bet.jiezhistring = cell.jieqidate;
                        bet.bettingstype = bettingStypeShisichang;
                        NSLog(@"iss = %@", cell.myrecord.curIssue);
                        NSString * str = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                        bet.issString = str;
                        [self.navigationController pushViewController:bet animated:YES];
                        [bet release];
                    }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]){
                        [MobClick event:@"event_goucai_caizhong" label:@"任选9"];
                        [MobClick event:@"event_goumai_zulancai_renxuan9"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        NSLog(@"label = %@", cell.jieqidate);
                        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                        bet.jiezhistring = cell.jieqidate;
                        bet.bettingstype = bettingStypeRenjiu;
                        NSString * strr = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                        bet.issString = strr;
                        [self.navigationController pushViewController:bet animated:YES];
                        [bet release];
                    }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"400"]){
                        [MobClick event:@"event_goucai_caizhong" label:@"北京单场"];
                        [MobClick event:@"event_goumai_zulancai_beijingdanchang"];
                        GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
                        [self.navigationController pushViewController:bjdanchang animated:YES];
                        [bjdanchang release];
                        
                    }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"200"]){
                        [MobClick event:@"event_goucai_caizhong" label:@"竞彩篮球"];
                        [MobClick event:@"event_goumai_zulancai_jingcailanqiu"];
                        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
                        NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                        
                        if ([arr count] > 0) {
                            gcjc.systimestr = [arr objectAtIndex:0];
                        }else{
                            gcjc.systimestr = @"";
                        }
                        gcjc.lanqiubool = YES;
                        [self.navigationController pushViewController:gcjc animated:YES];
                        [gcjc release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"20106"]) {//43
                        //世界杯冠军
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        if (cell.myrecord == nil) {
                            [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
                            return;
                        }
                        ChampionViewController * chapionController = [[ChampionViewController alloc] init];
                        chapionController.title = @"世界杯冠军";
                        chapionController.lotteryId = [self.caizhongArray objectAtIndex:indexPath.row];
                        chapionController.championType = championTypeShow;
                        NSArray *array = [cell.myrecord.lotteryName componentsSeparatedByString:@"|"];
                        if ([array count] >= 3) {
                            chapionController.sessionNum = [array objectAtIndex:2];
                        }
                        chapionController.endTime = cell.jieqidate;
                        NSString * str = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                        chapionController.curIssue = str;
                        [self.navigationController pushViewController:chapionController animated:YES];
                        [chapionController release];
                        
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"20107"]) {//44
                        //世界杯冠亚军
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        if (cell.myrecord == nil) {
                            [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
                            return;
                        }
                        ChampionViewController * chapionController = [[ChampionViewController alloc] init];
                        chapionController.title = @"世界杯冠亚军";
                        
                        chapionController.lotteryId = [self.caizhongArray objectAtIndex:indexPath.row];
                        
                        NSArray *array = [cell.myrecord.lotteryName componentsSeparatedByString:@"|"];
                        if ([array count] >= 3) {
                            chapionController.sessionNum = [array objectAtIndex:2];
                        }
                        
                        chapionController.championType = championSecondPlaceShow;
                        chapionController.endTime = cell.jieqidate;
                        NSString * str = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                        chapionController.curIssue = str;
                        [self.navigationController pushViewController:chapionController animated:YES];
                        [chapionController release];
                    }

                
                }
                
            }
            // 数字彩
            else {
//                    @"119",@"012",@"011",@"006",@"001",@"002",@"113",@"003",@"109",@"110",@"108",
                
                GouCaiCell *h5cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                if ([h5cell.myrecord.h5Url length] > 0) {
                    
                    [self pushHtml5OpenUrl:h5cell.myrecord.h5Url cell:h5cell];
                }else{
                    NSString *caizhongID = [self.caizhongArray objectAtIndex:indexPath.row];
                    if ([caizhongID length] > 3) {
                        caizhongID = [caizhongID substringToIndex:3];
                    }
                    NSString *caizhongName = [GC_LotteryType lotteryNameWithLotteryID:caizhongID];
                    [MobClick event:@"event_goucai_caizhong" label:caizhongName];
                    if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"119"]) {
                        [MobClick event:@"event_goumai_shuzicai_11xuan5"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"123"]) {
//                        [MobClick event:@"event_goumai_shuzicai_11xuan5"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:HeBei11];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_SHANXI_11]) {
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanXi11];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"121"]) {
                        [MobClick event:@"event_goumai_shuzicai_guangdong11xuan5"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JIANGXI_11]) {
                        [MobClick event:@"event_goumai_shuzicai_jiangxi11xuan5"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"012"]) {
                        [MobClick event:@"event_goumai_shuzicai_kuai3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"013"]) {
                        [MobClick event:@"event_goumai_shuzicai_jiangsukuai3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"019"]) {
                        [MobClick event:@"event_goumai_shuzicai_hubeikuai3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JILIN]) {
                        [MobClick event:@"event_goumai_shuzicai_jilinkuai3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_ANHUI]) {
                        [MobClick event:@"event_goumai_shuzicai_anhuikuai3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
                        highview.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:highview animated:YES];
                        [highview release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"011"]) {
                        [MobClick event:@"event_goumai_shuzicai_kuaile10fen"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        HappyTenViewController *happy = [[HappyTenViewController alloc] init];
                        happy.issue = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:happy animated:YES];
                        [happy release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"006"]) {
                        [MobClick event:@"event_goumai_shuzicai_shishicai"];
                        ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
                        [self.navigationController pushViewController:shishi animated:YES];
                        [shishi release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"014"]) {
                        [MobClick event:@"event_goumai_shuzicai_chongqingshishicai"];
                        CQShiShiCaiViewController *shishi = [[CQShiShiCaiViewController alloc] init];
                        [self.navigationController pushViewController:shishi animated:YES];
                        [shishi release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"001"]) {
                        [MobClick event:@"event_goumai_shuzicai_shuangseqiu"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        
                        GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
                        shuang.item = cell.myrecord.curIssue;
                        [self.navigationController pushViewController:shuang animated:YES];
                        //shuang.title = [NSString stringWithFormat:@"双色球%@期",cell.myrecord.curIssue];
                        [shuang release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"002"]) {
                        [MobClick event:@"event_goumai_shuzicai_fucai3d"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
                        fucai.myissueRecord = cell.myrecord;
                        [self.navigationController pushViewController:fucai animated:YES];
                        [fucai release];
                    }
                    else  if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"113"]) {
                        [MobClick event:@"event_goumai_shuzicai_daletou"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
                        dale.myissueRecord = cell.myrecord;
                        [self.navigationController pushViewController:dale animated:YES];
                        [dale release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"003"]) {
                        [MobClick event:@"event_goumai_shuzicai_qilecai"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
                        con.myissueRecord = cell.myrecord;
                        [self.navigationController pushViewController:con animated:YES];
                        [con release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"109"]) {
                        [MobClick event:@"event_goumai_shuzicai_pailie5"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                        paiwuqixing.myissueRecord = cell.myrecord;
                        paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;
                        //                        NSArray *array = [dataDic objectForKey:@"shuzicai"];
                        //                        for (int i = 0; i <[array count]; i++)
                        //                        {
                        //                            IssueRecord *a =[array objectAtIndex:i];
                        //                            if ([a.lotteryId isEqualToString:[self.caizhongArray objectAtIndex:indexPath.row]])
                        //                            {
                        //                                NSLog(@"%@",a.content);
                        //                            }
                        //                        }
                        [self.navigationController pushViewController:paiwuqixing animated:YES];
                        [paiwuqixing release];
                    }
                    else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"110"]){
                        [MobClick event:@"event_goumai_shuzicai_qixingcai"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                        paiwuqixing.myissueRecord = cell.myrecord;
                        paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
                        NSArray *array = [dataDic objectForKey:@"shuzicai"];
                        for (int i = 0; i <[array count]; i++)
                        {
                            IssueRecord *a =[array objectAtIndex:i];
                            if ([a.lotteryId isEqualToString:[self.caizhongArray objectAtIndex:indexPath.row]])
                            {
                                NSLog(@"%@",a.content);
                                paiwuqixing.jiangchi=a.content;
                            }
                        }
                        [self.navigationController pushViewController:paiwuqixing animated:YES];
                        [paiwuqixing release];
                    }
                    
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"108"]) {
                        //排列3
                        [MobClick event:@"event_goumai_shuzicai_pailie3"];
                        GouCaiCell *cell = (GouCaiCell *) [tableView cellForRowAtIndexPath:indexPath];
                        Pai3ViewController *pai = [[Pai3ViewController alloc] init];
                        pai.myissueRecord = cell.myrecord;
                        [self.navigationController pushViewController:pai animated:YES];
                        [pai release];
                    }
                    else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"122"]) {
                        [MobClick event:@"event_goumai_shuzicai_kuailepuke"];
                        KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
                        //                        puke.myIssrecord = cell.myrecord;
                        [self.navigationController pushViewController:puke animated:YES];
                        [puke release];
                        
                    }
                }
               

            }
        
    
        [tableView deselectRowAtIndexPath: indexPath animated: YES];

}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [self.dataDic removeAllObjects];
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    
    if (bannerView.lunBoRunLoopRef) {
        CFRunLoopStop(bannerView.lunBoRunLoopRef);
        bannerView.lunBoRunLoopRef = nil;
    }
    [bannerView release];
    [bannerArray release];
    [headerView release];
    
    
    [ggRequest clearDelegatesAndCancel];
    self.ggRequest = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GouCaiBack" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[ZucaiImages release];
	[ShuziImages release];
	[GaopinImages release];
	[self.mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = nil;
	self.dataDic = nil;
//	[accountManage release];
    self.accountManage = nil;
    
    [myCollectionView release];
    
    [getMatchRequest clearDelegatesAndCancel];
    self.getMatchRequest = nil;
    
    [eventsView release];
    
    [yujirequest clearDelegatesAndCancel];
    self.yujirequest = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark CP_CanOpenCellDelegate

- (void)otherLottoryViewController:(NSInteger)indexd title:(NSString *)titleStr lotteryType:(NSInteger)lotype lotteryId:(NSString *)loid{
    
    GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfo.title = titleStr;
    hemaiinfo.lotteryType = lotype;
    hemaiinfo.lotteryId = loid;
    hemaiinfo.paixustr = @"DD";
    
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.title = titleStr;
    hemaiinfotwo.lotteryType = lotype;
    hemaiinfotwo.lotteryId = loid;
    hemaiinfotwo.paixustr = @"AD";
    
    GCHeMaiInfoViewController * hongren = [[GCHeMaiInfoViewController alloc] init];
    hongren.title = titleStr;
    hongren.lotteryType = lotype;
    hongren.lotteryId = loid;
    hongren.paixustr = @"HR";
    
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:hemaiinfo, hemaiinfotwo,hongren, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"最新"];
    [labearr addObject:@"人气"];
    [labearr addObject:@"红人榜"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggzx.png"];
    [imagestring addObject:@"ggrq.png"];
    [imagestring addObject:@"gghrb.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggzx_1.png"];
    [imageg addObject:@"ggrq_1.png"];
    [imageg addObject:@"gghrb_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [hemaiinfo release];
    [hemaiinfotwo release];
    [hongren release];
}

- (void)ggOtherLottoryViewController:(NSInteger)indexd renjiuOrshengfu:(renJiuOrShengFu)rensheng{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    GuoGuanViewController *my = [[GuoGuanViewController alloc] init];
    my.ggType = shengFuCaiType;
    
    GuoGuanViewController *my2 = [[GuoGuanViewController alloc] init];
    my2.ggType = renXuanJiuType;
    
    GuoGuanViewController * my3 = [[GuoGuanViewController alloc] init];
    my3.ggType = WoDeGuoGuanType;
    my3.renorsheng = rensheng;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, my3, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"胜负彩"];
    [labearr addObject:@"任选9"];
    [labearr addObject:@"我的中奖"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggssc_1.png"];
    [imagestring addObject:@"ggrxq_1.png"];
    [imagestring addObject:@"ggwdcp_1.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggssc.png"];
    [imageg addObject:@"ggrxq.png"];
    [imageg addObject:@"ggwdcp.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    UIImageView *image = [[[UIImageView alloc] init] autorelease];
    image.backgroundColor = [UIColor blackColor];
    image.frame = CGRectMake(0, 0, 320, 49);
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    tabc.backgroundImage = image;
    
    
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my release];
    [my3 release];
}


- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell1 WithSelectButonIndex:(NSInteger)Index {
    GouCaiCell *cell = (GouCaiCell *) cell1;
    NSIndexPath *indexPath = [myTableView indexPathForCell:cell];
    if (fistPage == 0) {

         if (Index == 0){
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"119"]) {
                [MobClick event:@"event_goumai_shuzicai_11xuan5"];
                HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"121"]) {
                [MobClick event:@"event_goumai_shuzicai_guangdong11xuan5_cpdaigou"];
                HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JIANGXI_11]) {
                [MobClick event:@"event_goumai_shuzicai_jiangxi11xuan5_cpdaigou"];
                HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"012"]) {
                [MobClick event:@"event_goumai_shuzicai_kuai3_cpdaigou"];
                KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"013"]) {
                [MobClick event:@"event_goumai_shuzicai_kuai3_cpdaigou"];
                KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"019"]) {
                [MobClick event:@"event_goumai_shuzicai_kuai3_cpdaigou"];
                KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_JILIN]) {
                [MobClick event:@"event_goumai_shuzicai_kuai3_cpdaigou"];
                KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:LOTTERY_ID_ANHUI]) {
                [MobClick event:@"event_goumai_shuzicai_kuai3_cpdaigou"];
                KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"011"]) {
                [MobClick event:@"event_goumai_shuzicai_kuaile10fen_cpdaigou"];
                HappyTenViewController *happy = [[HappyTenViewController alloc] init];
                [self.navigationController pushViewController:happy animated:YES];
                [happy release];
                return;
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"006"]) {
                [MobClick event:@"event_goumai_shuzicai_shishicai"];
                ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
                [self.navigationController pushViewController:shishi animated:YES];
                [shishi release];
                return;
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"122"]) {
                [MobClick event:@"event_goumai_shuzicai_kuailepuke"];
                KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
                [self.navigationController pushViewController:puke animated:YES];
                [puke release];
                return;
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"014"]) {
                [MobClick event:@"event_goumai_shuzicai_shishicai"];
                CQShiShiCaiViewController *shishi = [[CQShiShiCaiViewController alloc] init];
                [self.navigationController pushViewController:shishi animated:YES];
                [shishi release];
                return;
            }
            else if ([[[Info getInstance] userId] integerValue] == 0) {
                 [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
#ifdef isCaiPiaoForIPad
                 [[caiboAppDelegate getAppDelegate] LoginForIpad];
#endif
                 return;
             }

            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"001"]){
                [MobClick event:@"event_goumai_shuzicai_shuangseqiu_hmdt"];
                [self otherLottoryViewController:0 title:@"双色球合买" lotteryType:1 lotteryId:@"001"];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"002"]){
                [MobClick event:@"event_goumai_shuzicai_fucai3d_hmdt"];
                [self otherLottoryViewController:0 title:@"福彩3D合买" lotteryType:2 lotteryId:@"002"];
                
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"113"]){
                [MobClick event:@"event_goumai_shuzicai_daletou_hmdt"];
                [self otherLottoryViewController:0 title:@"超级大乐透合买" lotteryType:4 lotteryId:@"113"];
                
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"003"]){
                [MobClick event:@"event_goumai_shuzicai_qilecai_hmdt"];
                [self otherLottoryViewController:0 title:@"七乐彩合买" lotteryType:TYPE_7LECAI lotteryId:@"003"];
                
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"109"]){
                [MobClick event:@"event_goumai_shuzicai_pailie5_hmdt"];
                [self otherLottoryViewController:0 title:@"排列5合买" lotteryType:TYPE_PAILIE5 lotteryId:@"109"];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"110"]){
                [MobClick event:@"event_goumai_shuzicai_qixingcai_hmdt"];
                [self otherLottoryViewController:0 title:@"七星彩合买" lotteryType:TYPE_QIXINGCAI lotteryId:@"110"];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"108"]){
                [MobClick event:@"event_goumai_shuzicai_pailie3_hmdt"];
                [self otherLottoryViewController:0 title:@"排列三合买" lotteryType:5 lotteryId:@"108"];
            }
        }
        else if (Index == 1) {
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"119"]) {
                [MobClick event:@"event_goumai_shuzicai_11xuan5"];
                HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
                highview.issue = cell.myrecord.curIssue;
                [self.navigationController pushViewController:highview animated:YES];
                [highview release];
                return;
            }
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"001"]) {
                    GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
                    shuang.item = cell.myrecord.curIssue;
                    shuang.isHeMai = YES;
                    [MobClick event:@"event_goumai_shuzicai_shuangseqiu"];
                    [self.navigationController pushViewController:shuang animated:YES];
                    //shuang.title = [NSString stringWithFormat:@"双色球%@期",cell.myrecord.curIssue];
                    [shuang release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"002"]) {
                FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
                fucai.myissueRecord = cell.myrecord;
                fucai.isHemai = YES;
                [MobClick event:@"event_goumai_shuzicai_fucai3d"];
                [self.navigationController pushViewController:fucai animated:YES];
                [fucai release];
            }
            else  if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"113"]) {
                
                DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
                dale.myissueRecord = cell.myrecord;
                dale.isHemai = YES;
                [MobClick event:@"event_goumai_shuzicai_daletou"];
                [self.navigationController pushViewController:dale animated:YES];
                [dale release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"003"]) {
                
                QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
                con.myissueRecord = cell.myrecord;
                con.isHemai = YES;
                [MobClick event:@"event_goumai_shuzicai_qilecai"];
                [self.navigationController pushViewController:con animated:YES];
                [con release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"109"]) {
                
                PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                paiwuqixing.myissueRecord = cell.myrecord;
                paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;
                paiwuqixing.isHemai = YES;
                [MobClick event:@"event_goumai_shuzicai_pailie5"];
                [self.navigationController pushViewController:paiwuqixing animated:YES];
                [paiwuqixing release];
            }
            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"110"]){
                
                
                PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                paiwuqixing.myissueRecord = cell.myrecord;
                paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
                paiwuqixing.isHemai = YES;
                [MobClick event:@"event_goumai_shuzicai_qixingcai"];
                [self.navigationController pushViewController:paiwuqixing animated:YES];
                [paiwuqixing release];
            }
            
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"108"]) {
                //排列3
                [MobClick event:@"event_goumai_shuzicai_pailie3"];
                Pai3ViewController *pai = [[Pai3ViewController alloc] init];
                pai.myissueRecord = cell.myrecord;
                pai.isHeMai = YES;
                [self.navigationController pushViewController:pai animated:YES];
                [pai release];
            }
            
        }
        else if (Index == 2) {
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"001"]) {
                    GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
                    shuang.item = cell.myrecord.curIssue;
                    shuang.isHeMai = NO;
                    [MobClick event:@"event_goumai_shuzicai_shuangseqiu"];
                    [self.navigationController pushViewController:shuang animated:YES];
                    //shuang.title = [NSString stringWithFormat:@"双色球%@期",cell.myrecord.curIssue];
                    [shuang release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"002"]) {
                FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
                fucai.myissueRecord = cell.myrecord;
                fucai.isHemai = NO;
                [MobClick event:@"event_goumai_shuzicai_fucai3d"];
                [self.navigationController pushViewController:fucai animated:YES];
                [fucai release];
            }
            else  if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"113"]) {
                
                DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
                dale.myissueRecord = cell.myrecord;
                dale.isHemai = NO;
                [MobClick event:@"event_goumai_shuzicai_daletou"];
                [self.navigationController pushViewController:dale animated:YES];
                [dale release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"003"]) {
                
                QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
                con.myissueRecord = cell.myrecord;
                con.isHemai = NO;
                [MobClick event:@"event_goumai_shuzicai_qilecai"];
                [self.navigationController pushViewController:con animated:YES];
                [con release];
            }
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"109"]) {
                
                PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                paiwuqixing.myissueRecord = cell.myrecord;
                paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;
                paiwuqixing.isHemai = NO;
                [MobClick event:@"event_goumai_shuzicai_pailie5"];
                [self.navigationController pushViewController:paiwuqixing animated:YES];
                [paiwuqixing release];
            }
            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"110"]){
                
                
                PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
                paiwuqixing.myissueRecord = cell.myrecord;
                paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
                paiwuqixing.isHemai = NO;
                [MobClick event:@"event_goumai_shuzicai_qixingcai"];
                [self.navigationController pushViewController:paiwuqixing animated:YES];
                [paiwuqixing release];
            }
            
            
            else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"108"]) {
                //排列3
                
                [MobClick event:@"event_goumai_shuzicai_pailie3_fqhm"];
                Pai3ViewController *pai = [[Pai3ViewController alloc] init];
                pai.myissueRecord = cell.myrecord;
                pai.isHeMai = NO;
                [self.navigationController pushViewController:pai animated:YES];
                [pai release];
            }
        }
        
        
    }
    else {
//        if ([[[Info getInstance] userId] integerValue] == 0) {
//            [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//            [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//            return;
//        }

        if (Index == 0) {
            if ([[[Info getInstance] userId] integerValue] == 0) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
#ifdef isCaiPiaoForIPad
                [[caiboAppDelegate getAppDelegate] LoginForIpad];
#endif
                return;
            }

                if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201"]) {
                    [MobClick event:@"event_goumai_zulancai_jingcai_hmdt"];
                    [self otherLottoryViewController:0 title:@"竞彩足球合买" lotteryType:106 lotteryId:@"201"];
                }
                else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"]) {
                    [MobClick event:@"event_goumai_zulancai_shengfucai_hmdt"];
                    [self otherLottoryViewController:0 title:@"胜负彩合买" lotteryType:13 lotteryId:@"300"];
                }
                else if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]) {
                    [MobClick event:@"event_goumai_zulancai_renxuan9_hmdt"];
                    [self otherLottoryViewController:0 title:@"任选九合买" lotteryType:14 lotteryId:@"301"];
                }
            
                else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"400"]){
                    [MobClick event:@"event_goumai_zulancai_beijing_hmdt"];
                    [self otherLottoryViewController:0 title:@"北单合买" lotteryType:200 lotteryId:@"400"];
                    
                }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"200"]){
                    [MobClick event:@"event_goumai_zulancai_jingcailanqiu_fmdt"];
                    
                    [self otherLottoryViewController:0 title:@"竞彩篮球合买" lotteryType:105 lotteryId:@"200"];
                    
                }
//            }
        }
        else if (Index == 1){
//            if ([[[Info getInstance] userId] integerValue] == 0) {
//                [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//                [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//                return;
//            }
//            if (!cell.myrecord) {
//                [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
//                return;
//            }

            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201"]) {
                [MobClick event:@"event_goumai_zulancai_jingcai_fqhm"];
                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                gcjc.isHeMai = YES;
                NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                
                if ([arr count] > 0) {
                    gcjc.systimestr = [arr objectAtIndex:0];
                }else{
                    gcjc.systimestr = @"";
                }
                
                NSLog(@"gcjc = %@", gcjc.systimestr);
                [self.navigationController pushViewController:gcjc animated:YES];
                [gcjc release];
            }
            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"]) {
                GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                bet.jiezhistring = cell.jieqidate;
                bet.isHemai = YES;
                bet.bettingstype = bettingStypeShisichang;
                [MobClick event:@"event_goumai_zulancai_shengfucai_fqhm"];
                NSLog(@"iss = %@", cell.myrecord.curIssue);
                NSString * str = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                bet.issString = str;
                [self.navigationController pushViewController:bet animated:YES];
                [bet release];
            }
            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]){
                [MobClick event:@"event_goumai_zulancai_renxuan9_fqhm"];
                GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                bet.jiezhistring = cell.jieqidate;
                bet.isHemai = YES;
                bet.bettingstype = bettingStypeRenjiu;
                NSString * strr = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                bet.issString = strr;
                [self.navigationController pushViewController:bet animated:YES];
                [bet release];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"400"]){
                GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
                bjdanchang.isHeMai=  YES;
                [self.navigationController pushViewController:bjdanchang animated:YES];
                [bjdanchang release];
                
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"200"]){
                [MobClick event:@"event_goumai_zulancai_jingcailanqiu_fqhm"];
                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
                gcjc.isHeMai = YES;
                NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                
                if ([arr count] > 0) {
                    gcjc.systimestr = [arr objectAtIndex:0];
                }else{
                    gcjc.systimestr = @"";
                }
                gcjc.lanqiubool = YES;
                [self.navigationController pushViewController:gcjc animated:YES];
                [gcjc release];
                
            }
        }
        else if (Index == 2) {
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"201"]) {
                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                if ([arr count] > 0) {
                    gcjc.systimestr = [arr objectAtIndex:0];
                }else{
                    gcjc.systimestr = @"";
                }
                
                [MobClick event:@"event_goumai_zulancai_jingcai"];
                NSLog(@"gcjc = %@", gcjc.systimestr);
                [self.navigationController pushViewController:gcjc animated:YES];
                [gcjc release];
            }
            else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"]) {
                [MobClick event:@"event_goumai_zulancai_shengfucai_ggtj"];
                [self ggOtherLottoryViewController:0 renjiuOrshengfu:shengfu];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]){
                [MobClick event:@"event_goumai_zulancai_renxuan9_ggtj"];
                [self ggOtherLottoryViewController:1 renjiuOrshengfu:renjiu];
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"400"]){
                [MobClick event:@"event_goumai_zulancai_beijingdanchang"];
                GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
                [self.navigationController pushViewController:bjdanchang animated:YES];
                [bjdanchang release];
                
            }else if([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"200"]){
                [MobClick event:@"event_goumai_zulancai_jingcailanqiu"];
                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
                NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
                if ([arr count] > 0) {
                    gcjc.systimestr = [arr objectAtIndex:0];
                }else{
                    gcjc.systimestr = @"";
                }
                
                
                gcjc.lanqiubool = YES;
                [self.navigationController pushViewController:gcjc animated:YES];
                [gcjc release];

            }
            
        }
        else if (Index ==3){
//            if ([[[Info getInstance] userId] intValue] == 0) {
//                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//                [cai showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//                [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//                return;
//            }
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"300"]) {
                [MobClick event:@"event_goumai_zulancai_shengfucai"];
                GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                bet.jiezhistring = cell.jieqidate;
                bet.bettingstype = bettingStypeShisichang;
                NSLog(@"iss = %@", cell.myrecord.curIssue);
                
                NSString * str = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                bet.issString = str;
                [self.navigationController pushViewController:bet animated:YES];
                [bet release];            }
            if ([[self.caizhongArray objectAtIndex:indexPath.row] isEqualToString:@"301"]) {
                [MobClick event:@"event_goumai_zulancai_renxuan9"];
                GCBettingViewController* bet = [[GCBettingViewController alloc] init];
                bet.jiezhistring = cell.jieqidate;
                bet.bettingstype = bettingStypeRenjiu;
                NSString * strr = [NSString stringWithFormat:@"%@",cell.myrecord.curIssue];
                bet.issString = strr;
                [self.navigationController pushViewController:bet animated:YES];
                [bet release];
            }
            
        }
    }
}

#pragma mark -
#pragma mark GouCaiCellDelegate

- (void)lotteryInfo:(NSString *)type{
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:type];
    
    [mRequest clearDelegatesAndCancel];
    self.mRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [mRequest setRequestMethod:@"POST"];
    [mRequest addCommHeaders];
    [mRequest setPostBody:postData];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
    [mRequest startAsynchronous];
}



- (void)isTimeEnd:(NSInteger)type lottery:(NSString *)lotteryString {
	NSLog(@"isTimeEnd");
    
    switch (type) {
		case shuzicai:
			if ([lotteryString isEqualToString:@"012"] || [lotteryString isEqualToString:@"011"] || [lotteryString isEqualToString:@"006"] ||[lotteryString isEqualToString:@"013"] || [lotteryString isEqualToString:@"019"] || [lotteryString isEqualToString:LOTTERY_ID_JILIN] || [lotteryString isEqualToString:LOTTERY_ID_ANHUI]) {//@"012",@"011",@"006"
                
                [self lotteryInfo:lotteryString];
            }else{
                [self sendRequest:type];
            }

			break;
		case zucai:
			[self sendRequest:type];
            break;
		default:
			break;
    }
    
	
}

- (void)openCell:(GouCaiCell *)cell {
    NSInteger tag = cell.tag;
    if ([cell.myrecord.lotteryId isEqualToString:@"20106"] || [cell.myrecord.lotteryId isEqualToString:@"20107"]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
        [self tableView:myTableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    if (cell.myrecord == nil && [cell.nameLabel.text rangeOfString:@"世界杯"].location != NSNotFound) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
        return;
    }
    for (int i = 0; i < [caizhongArray count]; i ++) {
        if (setion[i] == 1 && tag != i) {
            setion[i] = 0;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            GouCaiCell *cell2 = (GouCaiCell *)[myTableView cellForRowAtIndexPath:indexPath];
            cell2.hidden = YES;
            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            cell2 = (GouCaiCell *)[myTableView cellForRowAtIndexPath:indexPath];
            cell2.hidden = NO;
            [cell2 showButonScollWithAnime:NO];
            [cell2 hidenButonScollWithAnime:YES];
            cell2.openImage.image = UIImageGetImageFromName(@"GCShangXiaTou.png");
//--------------------------------------bianpinghua by sichuanlin
//            cell2.backImageView.image = [UIImageGetImageFromName(@"GCbaikuang.png") stretchableImageWithLeftCapWidth:5 topCapHeight:10];
        }
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    cell = (GouCaiCell *)[myTableView cellForRowAtIndexPath:indexPath];
    if (cell.butonScrollView.hidden == NO) {
        setion[indexPath.row] = 0;
        [cell showButonScollWithAnime:NO];
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (GouCaiCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [cell showButonScollWithAnime:NO];
        [cell hidenButonScollWithAnime:YES];
        cell.openImage.image = UIImageGetImageFromName(@"GCShangXiaTou.png");
//--------------------------------------bianpinghua by sichuanlin
//        cell.backImageView.image = [UIImageGetImageFromName(@"GCbaikuang.png") stretchableImageWithLeftCapWidth:5 topCapHeight:10];

    }
    else {
        setion[indexPath.row] = 1;
        
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (GouCaiCell *)[myTableView cellForRowAtIndexPath:indexPath];
         [cell hidenButonScollWithAnime:NO];
        [cell showButonScollWithAnime:YES];
        cell.openImage.image = UIImageGetImageFromName(@"GCShangJianTou.png");
//--------------------------------------bianpinghua by sichuanlin
//        cell.backImageView.image = [UIImageGetImageFromName(@"GCbaikuangZhankai.png") stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    }
    
    
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		
		IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        
        NSMutableArray * mutableArr = [dataDic objectForKey:@"shuzicai"];
        
        NSInteger indexCount = 0;
        
        for (IssueRecord *old in mutableArr) {
            if ([old.lotteryId isEqualToString:issrecord.lotteryId]) {
                
                [IssueRecord changeOld:old Tonew:issrecord];
                NSInteger newSeconds = 0;
                NSArray *array = [old.remainingTime componentsSeparatedByString:@":"];
                for (int i = 0; i < [array count]; i++) {
                    newSeconds = newSeconds * 60 +[[array objectAtIndex:i] intValue];
                }
                newSeconds += seconds;
                
                old.remainingTime = [NSString stringWithFormat:@"%d:%d:%d", (int)newSeconds/3600,(int)(newSeconds%3600)/60, (int)(newSeconds%3600)%60];
                NSLog(@"old.remainingTime = %@", old.remainingTime);
            }
            indexCount++;
        }
        
        
        NSArray *IDarray = self.caizhongArray;
        
        
        for (int i = 0; i < [IDarray count]; i++) {
            if ([[IDarray objectAtIndex:i] isEqualToString:issrecord.lotteryId]) {
                indexCount = i;
            }
        }
        
        
        
        //        [mutableArr replaceObjectAtIndex:b withObject:dataInfo];
        
        //        [dataDic setValue:mutableArr forKey:@"shuzicai"];
        
        
        
        [dataDic setValue:issrecord.systemTime forKey:@"sysTime"];
        
        [issrecord release];
        //        seconds = 0;
        NSIndexPath * indexPhat = [NSIndexPath indexPathForRow:indexCount inSection:0];
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPhat] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void) requestZuCaiFinished:(ASIHTTPRequest *)request {
//    if (loadview) {
//        [loadview stopRemoveFromSuperview];
//        loadview = nil;
//    }

	if ([request responseData]) {
		GC_IssueInfo *issueInfo = [[GC_IssueInfo alloc] initWithResponseData:[request responseData]WithRequest:request];
                [self resetCaizhong];
//        删除默认支持的彩种中没有返回的彩种
        
        //假数据。。。。
//         NSArray *lotroyidarry2 = [NSArray arrayWithObjects:@"201",@"300",@"301",@"400",@"200",@"20106",@"20107",@"201dg",@"201bf", @"201sf",nil];
//        self.caizhongArray = [NSMutableArray arrayWithArray:lotroyidarry2];
        /////////
        
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        for (IssueRecord *record in issueInfo.issueRecordList) {
            if (record.lotteryId) {
                [array1 addObject:record.lotteryId];
            }
        }
        
        
        for (NSString *lotteryid in caizhongArray) {
            if ([array1 indexOfObject:lotteryid] <[ array1 count]) {
                [array addObject:lotteryid];
            }
        }
        
        NSMutableArray *array2 = [NSMutableArray array];
        NSArray *lotroyidarry = [NSArray arrayWithObjects:@"201",@"300",@"301",@"400",@"200",@"20106",@"20107",@"201dg",@"201bf", @"400sf",nil];
        for (int i = 0; i < [array count]; i++) {
            
            for (IssueRecord *record in issueInfo.issueRecordList) {
                NSString * lottreyStr = [array objectAtIndex:i];
                NSLog(@"ddd = %@", record.lotteryId);
                if ([lottreyStr isEqualToString:record.lotteryId]) {
                    
                    if ([record.h5Url length] > 0) {
                        [array2 addObject:lottreyStr];
                    }else{
                        
                        if ([lotroyidarry indexOfObject:lottreyStr] < [lotroyidarry count]) {
                            [array2 addObject:lottreyStr];
                        }
                    }
                }
            }
            
            
            
        }
        
        
        
        
        self.caizhongArray = array2;
        
		[dataDic setValue:issueInfo.issueRecordList forKey:@"zucai"];
        [dataDic setValue:issueInfo.systemTime forKey:@"sysTime"];
        seconds = 0;
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(timechange) // 回调函数
                                                      userInfo:nil
                                                       repeats:YES];
		[myTableView reloadData];
        [issueInfo release];
	}
    
    
    [self hiddenWWBGimage];
}


-(void)requestAllFinished:(ASIHTTPRequest *)request {
    if ([request responseData]) {
        GC_IssueInfo *issueInfo = [[[GC_IssueInfo alloc] initWithResponseData:[request responseData]WithRequest:request] autorelease];
        
        [self resetCaizhong];
        //        删除默认支持的彩种中没有返回的彩种
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        for (IssueRecord *record in issueInfo.issueRecordList) {
            if (record.lotteryId) {
                [array1 addObject:record.lotteryId];
            }
        }
        for (NSString *lotteryid in caizhongArray) {
            if ([array1 indexOfObject:lotteryid] <[ array1 count]) {
                [array addObject:lotteryid];
            }
        }
        
        NSMutableArray *array2 = [NSMutableArray array];
        NSMutableArray *lotroyidarry = [[NSMutableArray alloc] initWithCapacity:10];
        NSArray * shuziLotroyIdArray =[NSArray arrayWithObjects:@"119",@"121",@"122",@"012",@"013",@"011",@"006",@"001",@"002",@"113",@"003",@"109",@"110",@"108",@"014",@"019", LOTTERY_ID_JILIN, LOTTERY_ID_JIANGXI_11, @"123", LOTTERY_ID_SHANXI_11, LOTTERY_ID_ANHUI,nil];
        NSArray * jingCaiLotroyIdArray = [NSArray arrayWithObjects:@"201",@"300",@"301",@"400",@"200",@"20106",@"20107",@"201dg",@"201bf", @"400sf",nil];
        [lotroyidarry addObjectsFromArray:shuziLotroyIdArray];
        [lotroyidarry addObjectsFromArray:jingCaiLotroyIdArray];
        
        NSMutableArray *array3 = [NSMutableArray array];
        
        for (int i = 0; i < [array count]; i++) {
            
            for (IssueRecord *record in issueInfo.issueRecordList) {
                NSString * lottreyStr = [array objectAtIndex:i];
                if ([lottreyStr isEqualToString:record.lotteryId]) {
                    
                    if ([record.h5Url length] > 0) {
                        [array2 addObject:lottreyStr];
                        [array3 addObject:record];
                    }else{
                        
                        if ([lotroyidarry indexOfObject:lottreyStr] < [lotroyidarry count]) {
                            [array2 addObject:lottreyStr];
                            [array3 addObject:record];
                        }
                    }
                }
            }
            
            
            
        }
        self.caizhongArray = array2;
        [dataDic setValue:array3 forKey:@"all"];
        [dataDic setValue:issueInfo.systemTime forKey:@"sysTime"];
//        seconds = 0;
//        [self.myTimer invalidate];
//        self.myTimer = nil;
//        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                        target:self
//                                                      selector:@selector(timechange) // 回调函数
//                                                      userInfo:nil
//                                                       repeats:YES];
        [myCollectionView reloadData];
    }
    
    [self hiddenWWBGimage];
}

- (void) requestShuZiFinished:(ASIHTTPRequest *)request {
    
	if ([request responseData]) {
		GC_IssueInfo *issueInfo = [[GC_IssueInfo alloc] initWithResponseData:[request responseData]WithRequest:request];
        
        [self resetCaizhong];
        //        删除默认支持的彩种中没有返回的彩种
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        for (IssueRecord *record in issueInfo.issueRecordList) {
            if (record.lotteryId) {
                [array1 addObject:record.lotteryId];
            }
        }
        for (NSString *lotteryid in caizhongArray) {
            if ([array1 indexOfObject:lotteryid] <[ array1 count]) {
                [array addObject:lotteryid];
            }
        }
        
        NSMutableArray *array2 = [NSMutableArray array];
        NSArray *lotroyidarry =[NSArray arrayWithObjects:@"119",@"121",@"122",@"012",@"013",@"011",@"006",@"001",@"002",@"113",@"003",@"109",@"110",@"108",@"014",@"019", LOTTERY_ID_JILIN, LOTTERY_ID_JIANGXI_11, @"123", LOTTERY_ID_SHANXI_11, LOTTERY_ID_ANHUI,nil];
        for (int i = 0; i < [array count]; i++) {
            
            for (IssueRecord *record in issueInfo.issueRecordList) {
                NSString * lottreyStr = [array objectAtIndex:i];
                if ([lottreyStr isEqualToString:record.lotteryId]) {
                    
                    if ([record.h5Url length] > 0) {
                        [array2 addObject:lottreyStr];
                    }else{
                        
                        if ([lotroyidarry indexOfObject:lottreyStr] < [lotroyidarry count]) {
                            [array2 addObject:lottreyStr];
                        }
                    }
                }
            }
            
            
            
        }
        
        self.caizhongArray = array2;
		[dataDic setValue:issueInfo.issueRecordList forKey:@"shuzicai"];
        [dataDic setValue:issueInfo.systemTime forKey:@"sysTime"];
        [issueInfo release];
        seconds = 0;
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(timechange) // 回调函数
                                                      userInfo:nil
                                                       repeats:YES];
		[myTableView reloadData];
	}
//    if (loadview) {
//        [loadview stopRemoveFromSuperview];
//        loadview = nil;
//    }
    
    [self hiddenWWBGimage];
}

- (void) requestFinished:(ASIHTTPRequest *)request {
//	if (loadview) {
//        [loadview stopRemoveFromSuperview];
//        loadview = nil;
//    }
    if ([request responseData]) {
		GC_IssueInfo *issueInfo = [[GC_IssueInfo alloc] initWithResponseData:[request responseData] WithRequest:request];
        [myTableView reloadData];
        [dataDic setValue:issueInfo.systemTime forKey:@"sysTime"];
        [issueInfo release];
    }
    
}


-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef  isCaiPiaoForIPad
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
#else
    return NO;
#endif
}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
//    //49
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationDelegate:self];
//    self.tabBarController.tabBar.frame=CGRectMake(0, aapp.window.frame.size.height, 320, 49);
//    [UIView commitAnimations];
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//        CGFloat currentPostion = scrollView.contentOffset.y;
//        
//        if (currentPostion < 0) {
//            NSLog(@"<0%f",currentPostion);
//        }else if (currentPostion > 5)
//        {
//            NSLog(@">0%f",currentPostion);
//        }
//    
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int currentPostion = scrollView.contentOffset.y;
//    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {
//        _lastPosition = currentPostion;
//        NSLog(@"ScrollUp now");
//        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
//        //49
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:.5];
//        [UIView setAnimationDelegate:self];
//        self.tabBarController.tabBar.frame=CGRectMake(0, aapp.window.frame.size.height, 320, 49);
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
//            UIView *view1 = [[self.tabBarController.view subviews] objectAtIndex:0];
////            view1.window.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height);
//            view1.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height);
//            self.mainView.frame = CGRectMake(0, 44, 320, aapp.window.frame.size.height - 44);
////            myTableView.frame = CGRectMake(0, 0, 320,self.mainView.bounds.size.height);
//        }
//        [UIView commitAnimations];
//
//    }
////    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20))
////    else if (_lastPosition - currentPostion > 0)
//    else if ((_lastPosition - currentPostion > 0) || currentPostion > scrollView.contentSize.height - scrollView.bounds.size.height-49)
//    {
//        _lastPosition = currentPostion;
////        NSLog(@"ScrollDown now");
//        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
//        
//        [UIView animateWithDuration:.5 animations:^{
//            self.tabBarController.tabBar.frame=CGRectMake(0, aapp.window.frame.size.height-49, 320, 49);
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
//                UIView *view1 = [[self.tabBarController.view subviews] objectAtIndex:0];
////                view1.window.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49);
//                view1.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height -49);
//                self.mainView.frame = CGRectMake(0, 44, 320, aapp.window.frame.size.height - 44 -49);
////                myTableView.frame = CGRectMake(0, 0, 320,self.mainView.bounds.size.height);
//            }
//        } completion:^(BOOL finished) {
//            
//        }];
//
//    }
//}

-(void)touchLotteryIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [dataDic objectForKey:@"all"];
    IssueRecord * lotteryData =[array objectAtIndex:indexPath.row];
    
    long selectedTag = indexPath.row;
    
    if ([lotteryData.h5Url length] > 0) {
        
        Info *info = [Info getInstance];
        if ([info.userId intValue]) {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            
            NSString * userNameString = @"";
            Info * userInfo = [Info getInstance];
            if ([userInfo.userName length] > 0) {//判断用户名是否为nil
                userNameString = userInfo.userName;
            }
            NSString * sessionid = @"";
            if ([GC_HttpService sharedInstance].sessionId) {
                sessionid = [GC_HttpService sharedInstance].sessionId;
            }
            NSString * flag = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@", sessionid, userNameString]];
            NSString * h5url = [NSString stringWithFormat:@"http://%@?sessionID=%@&sid=%@&newVersion=%@&lotteryId=%@&play=&bet=&flag=%@&client=ios", lotteryData.h5Url,sessionid,[infoDict objectForKey:@"SID"], newVersionKey, lotteryData.lotteryId, flag];
            myWeb=[[MyWebViewController alloc]init];
            myWeb.delegate = self;
            myWeb.hiddenNav = YES;
            [myWeb LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
            [self.navigationController pushViewController:myWeb animated:YES];
            [myWeb release];
        }
        else {
            [self doLogin];
        }
        
    }else{
        NSString *caizhongID = [self.caizhongArray objectAtIndex:selectedTag];
        if ([caizhongID length] > 3) {
            caizhongID = [caizhongID substringToIndex:3];
        }
        
        if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"201dg"]) {//
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            gcjc.gcdgBool = YES;
            NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
            
            if ([arr count] > 0) {
                gcjc.systimestr = [arr objectAtIndex:0];
            }else{
                gcjc.systimestr = @"";
            }
            [MobClick event:@"event_goucai_caizhong" label:@"竞彩足球单关"];
            [MobClick event:@"event_goumai_zulancai_jingcaidg"];
            NSLog(@"gcjc = %@", gcjc.systimestr);
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
        }
        
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"400sf"]) {
            [MobClick event:@"event_goucai_caizhong" label:@"胜负过关"];
            GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:10919];
            [self.navigationController pushViewController:bjdanchang animated:YES];
            [bjdanchang release];
            
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"201bf"]) {
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            gcjc.dgType = dgMatchBifen;
            [MobClick event:@"event_goucai_caizhong" label:@"竞彩比分"];
            NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
            
            if ([arr count] > 0) {
                gcjc.systimestr = [arr objectAtIndex:0];
            }else{
                gcjc.systimestr = @"";
            }
            [MobClick event:@"event_goumai_zulancai_jingcaibifen"];
            NSLog(@"gcjc = %@", gcjc.systimestr);
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
        }
        
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"201"]) {
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            //                    gcjc.gcdgBool = YES;
            NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
            
            if ([arr count] > 0) {
                gcjc.systimestr = [arr objectAtIndex:0];
            }else{
                gcjc.systimestr = @"";
            }
            [MobClick event:@"event_goucai_caizhong" label:@"竞彩足球"];
            [MobClick event:@"event_goumai_zulancai_jingcai"];
            NSLog(@"gcjc = %@", gcjc.systimestr);
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
        }
        else if([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"300"]) {
            [MobClick event:@"event_goucai_caizhong" label:@"胜负彩"];
            [MobClick event:@"event_goumai_zulancai_shengfucai"];

            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            bet.jiezhistring = lotteryData.content;
            bet.bettingstype = bettingStypeShisichang;
            NSString * str = [NSString stringWithFormat:@"%@",lotteryData.curIssue];
            bet.issString = str;
            [self.navigationController pushViewController:bet animated:YES];
            [bet release];
        }else if([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"301"]){
            [MobClick event:@"event_goucai_caizhong" label:@"任选9"];
            [MobClick event:@"event_goumai_zulancai_renxuan9"];

            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            bet.jiezhistring = lotteryData.content;
            bet.bettingstype = bettingStypeRenjiu;
            NSString * strr = [NSString stringWithFormat:@"%@",lotteryData.curIssue];
            bet.issString = strr;
            [self.navigationController pushViewController:bet animated:YES];
            [bet release];
        }else if([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"400"]){
            [MobClick event:@"event_goucai_caizhong" label:@"北京单场"];
            [MobClick event:@"event_goumai_zulancai_beijingdanchang"];
            GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
            [self.navigationController pushViewController:bjdanchang animated:YES];
            [bjdanchang release];
            
        }else if([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"200"]){
            [MobClick event:@"event_goucai_caizhong" label:@"竞彩篮球"];
            [MobClick event:@"event_goumai_zulancai_jingcailanqiu"];
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
            NSArray * arr = [[dataDic objectForKey:@"sysTime"] componentsSeparatedByString:@" "];
            
            if ([arr count] > 0) {
                gcjc.systimestr = [arr objectAtIndex:0];
            }else{
                gcjc.systimestr = @"";
            }
            gcjc.lanqiubool = YES;
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"20106"]) {//43
            //世界杯冠军
            if (lotteryData == nil) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
                return;
            }
            ChampionViewController * chapionController = [[ChampionViewController alloc] init];
            chapionController.title = @"世界杯冠军";
            chapionController.lotteryId = [self.caizhongArray objectAtIndex:selectedTag];
            chapionController.championType = championTypeShow;
            NSArray *array = [lotteryData.lotteryName componentsSeparatedByString:@"|"];
            if ([array count] >= 3) {
                chapionController.sessionNum = [array objectAtIndex:2];
            }
            chapionController.endTime = lotteryData.content;
            NSString * str = [NSString stringWithFormat:@"%@",lotteryData.curIssue];
            chapionController.curIssue = str;
            [self.navigationController pushViewController:chapionController animated:YES];
            [chapionController release];
            
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"20107"]) {//44
            //世界杯冠亚军
            if (lotteryData == nil) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"暂无数据"];
                return;
            }
            ChampionViewController * chapionController = [[ChampionViewController alloc] init];
            chapionController.title = @"世界杯冠亚军";
            
            chapionController.lotteryId = [self.caizhongArray objectAtIndex:selectedTag];
            
            NSArray *array = [lotteryData.lotteryName componentsSeparatedByString:@"|"];
            if ([array count] >= 3) {
                chapionController.sessionNum = [array objectAtIndex:2];
            }
            
            chapionController.championType = championSecondPlaceShow;
            chapionController.endTime = lotteryData.content;
            NSString * str = [NSString stringWithFormat:@"%@",lotteryData.curIssue];
            chapionController.curIssue = str;
            [self.navigationController pushViewController:chapionController animated:YES];
            [chapionController release];
        }

//////////数字彩
        NSString *caizhongName = [GC_LotteryType lotteryNameWithLotteryID:caizhongID];
        [MobClick event:@"event_goucai_caizhong" label:caizhongName];
        if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"119"]) {
            [MobClick event:@"event_goumai_shuzicai_11xuan5"];

            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"123"]) {

            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:HeBei11];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:LOTTERY_ID_SHANXI_11]) {
            
            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanXi11];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"121"]) {
            [MobClick event:@"event_goumai_shuzicai_guangdong11xuan5"];

            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:LOTTERY_ID_JIANGXI_11]) {
            [MobClick event:@"event_goumai_shuzicai_jiangxi11xuan5"];

            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"012"]) {
            [MobClick event:@"event_goumai_shuzicai_kuai3"];

            KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"013"]) {
            [MobClick event:@"event_goumai_shuzicai_jiangsukuai3"];

            KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"019"]) {
            [MobClick event:@"event_goumai_shuzicai_hubeikuai3"];

            KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:LOTTERY_ID_JILIN]) {
            [MobClick event:@"event_goumai_shuzicai_jilinkuai3"];

            KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:LOTTERY_ID_ANHUI]) {
            [MobClick event:@"event_goumai_shuzicai_anhuikuai3"];
            
            KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
            highview.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"011"]) {
            [MobClick event:@"event_goumai_shuzicai_kuaile10fen"];

            HappyTenViewController *happy = [[HappyTenViewController alloc] init];
            happy.issue = lotteryData.curIssue;
            [self.navigationController pushViewController:happy animated:YES];
            [happy release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"006"]) {
            [MobClick event:@"event_goumai_shuzicai_shishicai"];
            ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
            [self.navigationController pushViewController:shishi animated:YES];
            [shishi release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"014"]) {
            [MobClick event:@"event_goumai_shuzicai_chongqingshishicai"];
            CQShiShiCaiViewController *shishi = [[CQShiShiCaiViewController alloc] init];
            [self.navigationController pushViewController:shishi animated:YES];
            [shishi release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"001"]) {
            [MobClick event:@"event_goumai_shuzicai_shuangseqiu"];
            
            GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
            shuang.item = lotteryData.curIssue;
            [self.navigationController pushViewController:shuang animated:YES];
            [shuang release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"002"]) {
            [MobClick event:@"event_goumai_shuzicai_fucai3d"];

            FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
            fucai.myissueRecord = lotteryData;
            [self.navigationController pushViewController:fucai animated:YES];
            [fucai release];
        }
        else  if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"113"]) {
            [MobClick event:@"event_goumai_shuzicai_daletou"];

            DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
            dale.myissueRecord = lotteryData;
            [self.navigationController pushViewController:dale animated:YES];
            [dale release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"003"]) {
            [MobClick event:@"event_goumai_shuzicai_qilecai"];

            QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
            con.myissueRecord = lotteryData;
            [self.navigationController pushViewController:con animated:YES];
            [con release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"109"]) {
            [MobClick event:@"event_goumai_shuzicai_pailie5"];

            PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
            paiwuqixing.myissueRecord = lotteryData;
            paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;

            [self.navigationController pushViewController:paiwuqixing animated:YES];
            [paiwuqixing release];
        }
        else if([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"110"]){
            [MobClick event:@"event_goumai_shuzicai_qixingcai"];

            PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
            paiwuqixing.myissueRecord = lotteryData;
            paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
            NSArray *array = [dataDic objectForKey:@"shuzicai"];
            for (int i = 0; i <[array count]; i++)
            {
                IssueRecord *a =[array objectAtIndex:i];
                if ([a.lotteryId isEqualToString:[self.caizhongArray objectAtIndex:selectedTag]])
                {
                    NSLog(@"%@",a.content);
                    paiwuqixing.jiangchi=a.content;
                }
            }
            [self.navigationController pushViewController:paiwuqixing animated:YES];
            [paiwuqixing release];
        }
        
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"108"]) {
            //排列3
            [MobClick event:@"event_goumai_shuzicai_pailie3"];

            Pai3ViewController *pai = [[Pai3ViewController alloc] init];
            pai.myissueRecord = lotteryData;
            [self.navigationController pushViewController:pai animated:YES];
            [pai release];
        }
        else if ([[self.caizhongArray objectAtIndex:selectedTag] isEqualToString:@"122"]) {
            [MobClick event:@"event_goumai_shuzicai_kuailepuke"];
            KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
            [self.navigationController pushViewController:puke animated:YES];
            [puke release];
            
        }
    }
}

-(void)focusEventsView:(FocusEventsView *)focusEventsView
{
    [self requestYujiJangjin];
}

- (void)requestYujiJangjin
{

    GC_JingCaiDuizhenResult *result = [matchDataArray objectAtIndex:eventsView.curEventView.tag - 10000];

    NSString * issue = [NSString stringWithFormat:@"%@:1",result.matchId];
    NSString * odds = [NSString stringWithFormat:@"%@:%@",result.matchId,eventsView.curSelectedOdds];
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] reqGetIssueInfo:issue cishu:1 fangshi:@"单关@iphone" shedan:0 beishu:1 touzhuxuanxiang:odds lottrey:@"201" play:@"10"];

    [yujirequest clearDelegatesAndCancel];
    
    self.yujirequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [yujirequest setRequestMethod:@"POST"];
    [yujirequest addCommHeaders];
    [yujirequest setPostBody:postData];
    [yujirequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yujirequest setDelegate:self];
    [yujirequest setDidFinishSelector:@selector(yujiJiangjinRequest:)];
    [yujirequest setDidFailSelector:@selector(yujiJiangjinFailRequest:)];
    [yujirequest startAsynchronous];
}

- (void)yujiJiangjinFailRequest:(ASIHTTPRequest *)mrequest
{
    [[caiboAppDelegate getAppDelegate] showMessage:@"确认购买失败"];
}

- (void)yujiJiangjinRequest:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        //投注界面
        
        GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
        sheng.chaodanbool = NO;
        sheng.saveKey = @"2011gg";
        sheng.title = @"竞彩足球胜平负";

        sheng.danfushi = 1;
        
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"";
        }
        
        GC_JingCaiDuizhenResult *result = [matchDataArray objectAtIndex:eventsView.curEventView.tag - 10000];

        GC_BetData * betData = [[[GC_BetData alloc] init] autorelease];
        
        if (eventsView.curSelectedTag == 0) {
            betData.selection1 = YES;
        }
        else if (eventsView.curSelectedTag == 1) {
            betData.selection2 = YES;
        }
        else if (eventsView.curSelectedTag == 2) {
            betData.selection3 = YES;
        }
        betData.team = [NSString stringWithFormat:@"%@,%@,0",result.homeTeam,result.vistorTeam];
        betData.changhao = result.matchId;
        betData.event = result.match;
        betData.dandan = NO;
        betData.numzhou = result.num;
        
        NSArray * bettingArray = [[[NSArray alloc] initWithObjects:betData, nil] autorelease];
        
        sheng.bettingArray = bettingArray;

        sheng.fenzhong = jingcaipiao;

        sheng.isxianshiyouhuaBtn = YES;

        
        sheng.moneynum = @"2";
        sheng.zhushu = @"1";
        sheng.jingcai = YES;
        sheng.zhushudict = @{@"单关":@"1"};

        sheng.maxmoneystr = yuji.maxmoney;
        sheng.minmoneystr = yuji.minmoney;
        
        sheng.isHeMai = NO;
        //  NSLog(@"zhushu = %@", zhushuDic);
        
        sheng.hemaibool = NO;
        
        sheng.beitouNumber = [eventsView.payMoney intValue]/2;
        
        [self.navigationController pushViewController:sheng animated:YES];
        [sheng release];
        [yuji release];
        
    }
    
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
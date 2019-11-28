//
//  GCHeMaiInfoViewController.m
//  caibo
//
//  Created by  on 12-6-26.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCHeMaiInfoViewController.h"
#import "Info.h"
#import "GCHemaiCell.h"
#import "GC_HttpService.h"
#import "GC_LotteryType.h"
#import "GC_UserInfo.h"
#import "BuyTogetherInfo.h"
#import "SchemeInfo.h"
#import "caiboAppDelegate.h"
#import "FansViewController.h"
#import "NetURL.h"
#import "JSON.h"
#import "AnnouncementData.h"
#import "HongRenBangCell.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "GC_BetInfo.h"
#import "ProfileViewController.h"
#import "TwitterMessageViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "DaLeTouViewController.h"
#import "FuCai3DViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "Pai3ViewController.h"
#import "QIleCaiViewController.h"
#import "GCJCBetViewController.h"
#import "GC_BJDanChangViewController.h"
#import "GCBettingViewController.h"
#import "GCSearchViewController.h"
#import "SendMicroblogViewController.h"
#import "MobClick.h"
#import "LoginViewController.h"

@implementation GCHeMaiInfoViewController
@synthesize httpRequest;
@synthesize caizhongstr;
@synthesize lotteryType;
@synthesize moreCell;
@synthesize seachTextListarry;
@synthesize lotteryId;
@synthesize mRefreshView;
@synthesize paixustr;
@synthesize goucaibool;
@synthesize sysTime;
@synthesize hmdtBool;
@synthesize isNeedPopToRoot;
//static int butTag;//这个变量 为了判断 连续按的按钮是否是一个按钮

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)buySuccess:(NSString *)success
{
    if ([success isEqualToString:@"success"]) {
        heMaiType = 4;
        [self systimeRequest];
    }
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

- (void)systimeRequest{
    
    if (lotteryType == 106 || lotteryType == 270) {
        [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
    } else {
        // 发送《4.28开奖时间查询》接口获取对应彩种的最近期号
        [self.httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [self.httpRequest setPostBody:[[GC_HttpService sharedInstance] reqLotteryTime:lotteryType]];
        [self.httpRequest setDidFinishSelector:@selector(requestLotteryTimeFinished:)];
        [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self.httpRequest setRequestMethod:@"POST"];
        [self.httpRequest setDelegate:self];
        [self.httpRequest addCommHeaders];
        [self.httpRequest startAsynchronous];
    }
    
}

- (void)goLogin {
    LoginViewController *log = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
    [log release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"event_goucai_hemaidating"];
    if(!loadview){
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
    }
    
    
    wanArray = [[NSArray alloc] initWithObjects:@"双色球", @"大乐透", @"福彩3D", @"七乐彩", @"排列三", @"排列五", @"七星彩", @"竞彩足球", @"北京单场", @"胜负彩", @"任选9", @"竞彩篮球", nil];
    modetype = 0;
    
    schemeArray = [[NSMutableArray alloc] initWithCapacity:0];
    manyuan = 0;
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
    }
	   
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    // bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    

    if (goucaibool) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
        
        
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(10, 5, 180, 34);
        [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        // titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
        // titleLabel.shadowOffset = CGSizeMake(0, 1.0);
        
        titleLabel.text = @"双色球合买大厅";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        [titleButton addSubview:titleLabel];
        [titleLabel release];
        
        [titleView addSubview:titleButton];
        
        sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
        [titleButton addSubview:sanjiaoImageView];
        
       
        
        UIFont * font = titleLabel.font;
        CGSize  size = CGSizeMake(180, 34);
        CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 9.5, 17, 17);
       

        self.CP_navigation.titleView = titleView;
        [titleView release];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(20, 0, 40, 44);
        
    
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        [rightItem release];
    }

    
    
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, self.mainView.bounds.size.height-49)];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, self.mainView.bounds.size.height-49+49)];
    
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height-49);
#endif
    
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myTableView];
    if (goucaibool) {
        self.paixustr = @"AD";
//        myTableView.frame = CGRectMake(0, 45, 320, self.mainView.bounds.size.height - 94);
        myTableView.frame = CGRectMake(0, 45, 320, self.mainView.bounds.size.height - 94+49);
        UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self.mainView addSubview:topImage];
        //topImage.image = UIImageGetImageFromName(@"hemaitou.png");
        topImage.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:81.0/255.0 blue:141.0/255.0 alpha:1];
        [topImage release];
        
        NSArray *array1 = [NSMutableArray arrayWithObjects:@"按进度",@"按战绩",@"按金额",@"搜索用户",nil];
        for (int i = 0; i < [array1 count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*80, 0, 80, 45);

            if (i == 1 ) {
                btn.frame = CGRectMake(i*80-4, 0, 80, 45);
            } else if (i == 2){
                btn.frame = CGRectMake(i*80-8, 0, 80, 45);
            }
            btn.tag = 100 + i;
            [self.mainView addSubview:btn];
            [btn addTarget:self action:@selector(scrollBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i != 3) {
                UIImageView *jiantouView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 15, 6, 12)];
                [btn addSubview:jiantouView];
                [jiantouView release];
                jiantouView.image = UIImageGetImageFromName(@"hemaixia.png");
                jiantouView.tag = 222;
                if (i == 0) {
                    jiantouView.hidden = NO;
                }
                else {
                    jiantouView.hidden = YES;
                }
                

            }
            else {
                UIImageView *jiantouView = [[UIImageView alloc] initWithFrame:CGRectMake(-4, 17, 13, 13)];
                [btn addSubview:jiantouView];
                jiantouView.image = UIImageGetImageFromName(@"hemaisearch.png");
                jiantouView.tag = 222;
                [jiantouView release];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 80, 23)];
            [btn addSubview:label];
            label.backgroundColor = [UIColor clearColor];
            label.text = [array1 objectAtIndex:i];
            label.tag = 333;
            label.font = [UIFont systemFontOfSize:15];
            if (i == 0) {
                label.textColor = [UIColor whiteColor];

            }
            else {
                label.textColor = [UIColor colorWithRed:121/255.0 green:183/255.0 blue:212/255.0 alpha:1.0];

            }
            
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
            
        }
        // 换成图
//        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(15, 42, 64, 3)];
//        imageView.tag = 1101;
//        imageView.backgroundColor = [UIColor redColor];
//        [self.mainView addSubview:imageView];
//        [imageView release];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, 63, 4)];
        imageView.tag = 1101;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"hemaihengtiao_1.png"];
        [self.mainView addSubview:imageView];
        [imageView release];
        
    }
    if (!mRefreshView) 
    {
		UITableView *mTableView = myTableView;
		CBRefreshTableHeaderView *headerview = 
		[[CBRefreshTableHeaderView alloc] 
		 initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        headerview.backgroundColor = [UIColor clearColor];
        self.mRefreshView = headerview;
		mRefreshView.delegate = self;
		[myTableView addSubview:mRefreshView];
		[headerview release];
	}

    if (![paixustr isEqualToString:@"HR"]){
        
        if (goucaibool) {
            if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"hemaidating"]) {
                [self lotteryIdAndLotteryTypeFunc:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hemaidating"] intValue]];
                modetype = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hemaidating"] intValue];
            }else{
                
                [self lotteryIdAndLotteryTypeFunc:0];
            }
        }
       
            [self systimeRequest];
        

    }else{
        
        [self requestRed];
    }

    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"hemai"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
}
#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
   	isLoading = YES;
    
	[mRefreshView setState:CBPullRefreshLoading];
    myTableView.contentInset = UIEdgeInsetsMake(60.0, 0.0f, 0.0f, 0.0f);

        
  //      [self sendContentRequest]; //网络请求
    if (hmdtBool) {
        if ([paixustr isEqualToString:@"ADC"] ) {
            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
        }else if([paixustr isEqualToString:@"DD"]){
            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
        }else if([paixustr isEqualToString:@"HR"]){//hongrenBut
            [self requestRed];
        }
        else {
            [self requestLotteryTimeFinished:nil];
        }
        
    }else{
        if ([paixustr isEqualToString:@"AD"] ) {
            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
        }else if([paixustr isEqualToString:@"DD"]){
            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
        }else if([paixustr isEqualToString:@"HR"]){//hongrenBut
            [self requestRed];
        }

        
    }
    
   
    
	
    
}

- (NSString *)changeModetypeToString:(NSInteger)mode {
    if (mode == 0) {
        return @"双色球";
    }
    else if (mode == 1){
        return @"大乐透";
    }
    else if (mode == 2){
        return @"福彩3D";
    }
    else if (mode == 3){
        return @"七乐彩";
    }
    else if (mode == 4){
        return @"排列三";
    }
    else if (mode == 5){
        return @"排列五";
    }
    else if (mode == 6){
        return @"七星彩";
    }
    else if (mode == 7){
        return @"竞彩足球";
    }
    else if (mode == 8){
        return @"北京单场";
    }
    else if (mode == 9){
        return @"胜负彩";
    }
    else if (mode == 10){
        return @"任选9";
    }
    else if (mode == 11){
        return @"竞彩篮球";
    }
    
    return nil;
}

- (void)lotteryIdAndLotteryTypeFunc:(NSInteger)mode {
    if (mode == 0) {
        lotteryId = @"001";
        lotteryType = 1;
        titleLabel.text = @"双色球合买大厅";
        [MobClick event:@"event_goumai_hmdt_shuangseqiu"];
    }
    else if (mode == 1){
        lotteryId = @"113";
        lotteryType = 4;
        titleLabel.text = @"大乐透合买大厅";
        [MobClick event:@"event_goumai_hmdt_daletou"];
        
    }
    else if (mode == 2){
        lotteryId = @"002";
        lotteryType = 2;
        titleLabel.text = @"福彩3D合买大厅";
      
    }
    else if (mode == 3){
        lotteryId = @"003";
        lotteryType = 3;
        titleLabel.text = @"七乐彩合买大厅";
   
    }
    else if (mode == 4){
        lotteryId = @"108";
        lotteryType = 5;
        titleLabel.text = @"排列三合买大厅";
       
    }
    else if (mode == 5){
        lotteryId = @"109";
        lotteryType = 6;
        titleLabel.text = @"排列五合买大厅";
      
    }
    else if (mode == 6){
        lotteryId = @"110";
        lotteryType = 7;
        titleLabel.text = @"七星彩合买大厅";
      
    }
    else if (mode == 7){
        lotteryId = @"201";
        lotteryType = 106;
        titleLabel.text = @"竞彩足球合买大厅";
        [MobClick event:@"event_goumai_hmdt_jingcaizuqiu"];
      
    }
    else if (mode == 8){
        lotteryId = @"400";
        lotteryType = 200;
        titleLabel.text = @"北京单场合买大厅";
      
    }
    else if (mode == 9){
        lotteryId = @"300";
        lotteryType = 13;
        titleLabel.text = @"胜负彩合买大厅";

    }
    else if (mode == 10){
        lotteryId = @"301";
        lotteryType = 14;
        titleLabel.text = @"任选9合买大厅";
       
    }
    else if (mode == 11){
        lotteryId = @"200";
        lotteryType = 105;
        titleLabel.text = @"竞彩篮球合买大厅";
       
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 9.5, 17, 17);
    
    [self systimeRequest];
    
    
}

- (void)menuView{
    
    

    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"彩种选择" withChuanNameArray:wanArray andChuanArray:nil];
;
    alert2.duoXuanBool = NO;
    alert2.delegate = self;
    [alert2 show];
    NSInteger type = [wanArray indexOfObject:[self changeModetypeToString:modetype]];
    
   
    for (CP_XZButton *btn in alert2.backScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && btn.tag == type) {
            btn.selected = YES;
        }
    }
    
    [alert2 release];

}
#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    if (buttonIndex == 1) {
        
        if ([returnarry count] == 1) {
            NSString *wanfaname = [returnarry objectAtIndex:0];
            NSInteger tag = [wanArray indexOfObject:wanfaname];
            if (tag >= 0 && tag < 100) {
                
                modetype = tag;
                lotteryTime = nil;
                
                [schemeArray removeAllObjects];
                [self lotteryIdAndLotteryTypeFunc:tag];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", (int)tag] forKey:@"hemaidating"];
            }
            
        }
        
    }
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender {
}

- (void)pressTitleButton:(UIButton *)sender{//titleLabel点击菜单

    [self menuView];
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"caidanqhxz.png"];
    [allimage addObject:@"faqihemai.png"];
    
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"彩种选择"];
    [alltitle addObject:@"发起合买"];
    
    
    caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//    }
    tln.delegate = self;
    [self.view addSubview:tln];
    [tln show];
    [tln release];

    [allimage release];
    [alltitle release];
}

- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        [self menuView];
    }
    else if (index == 1) {
        [self goHemai];
    }
}

//点击头部排序按钮
- (void)scrollBtn:(UIButton *)sender {
    if (sender.tag == 103) {
        if ([[[Info getInstance] userId] intValue] == 0) {
            [self goLogin];
            return;
        }
            GCSearchViewController * gcsear = [[GCSearchViewController alloc] init];
        [self.navigationController pushViewController:gcsear animated:YES];
            [gcsear searchbegin];
            [gcsear release];
    }
    else {
        UIView *v = [self.mainView viewWithTag:1101];
        v.frame = CGRectMake(sender.frame.origin.x + 10, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
        UIImageView *jiantou = (UIImageView *)[sender viewWithTag:222];
        if (jiantou.hidden == NO) {
            sender.selected = !sender.selected;
        }
        if (!sender.selected) {
            jiantou.image = UIImageGetImageFromName(@"hemaixia.png");
        }
        else {
            jiantou.image = UIImageGetImageFromName(@"hemaishang.png");
        }
        for (int i = 100; i < 103; i++) {
            UIView *btn = [self.mainView viewWithTag:i];
            UIView *viewjian = [btn viewWithTag:222];
            UILabel *label = (UILabel *)[btn viewWithTag:333];
            if (btn == sender) {
                label.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
                label.textColor = [UIColor whiteColor];
            }
            else {
                label.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                label.textColor = [UIColor colorWithRed:121/255.0 green:183/255.0 blue:212/255.0 alpha:1.0];

            }
            viewjian.hidden = YES;
        }
        jiantou.hidden = NO;
        
        if (sender.tag == 100) {
            if (sender.selected) {
                paixustr = @"AA";
            }
            else {
                paixustr = @"AD";
            }
            
        }
        else if (sender.tag == 101) {
            if (sender.selected) {
                paixustr = @"ZJA";
            }
            else {
                paixustr = @"ZJD";
            }
        }
        else if (sender.tag == 102) {
            if (sender.selected) {
                paixustr = @"MA";
            }
            else {
                paixustr = @"MD";
            }
        }
        isLoading = YES;
        [self requestLotteryTimeFinished:nil];
    }
}

- (void)goHemai {
    [MobClick event:@"event_goucai_hemaidating_faqi" label:[GC_LotteryType lotteryNameWithLotteryID:lotteryId]];
    if ([lotteryId isEqualToString:@"001"]) {
        GouCaiShuangSeQiuViewController * info = [[GouCaiShuangSeQiuViewController alloc] init];
        info.isHeMai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"113"]){
        DaLeTouViewController *info = [[DaLeTouViewController alloc] init];
        info.isHemai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"002"]){
        FuCai3DViewController * info = [[FuCai3DViewController alloc] init];
        info.isHemai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"003"]){
        QIleCaiViewController *info = [[QIleCaiViewController alloc] init];
        info.isHemai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"108"]){
        Pai3ViewController  *info = [[Pai3ViewController alloc] init];
        info.isHeMai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"109"]){
        PaiWuOrQiXingViewController *info = [[PaiWuOrQiXingViewController alloc] init];
        info.qixingorpaiwu = shuZiCaiPaiWu;
        info.isHemai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"110"]){
        PaiWuOrQiXingViewController *info = [[PaiWuOrQiXingViewController alloc] init];
        info.qixingorpaiwu = shuZiCaiQiXing;
        info.isHemai = YES;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if ([lotteryId isEqualToString:@"201"]){
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
        NSArray * timeArray = [self.sysTime componentsSeparatedByString:@" "];
        if ([timeArray count] >= 2 ) {
             gcjc.systimestr = [timeArray objectAtIndex:0];
        }else{
             gcjc.systimestr = self.sysTime;
        }
       
        gcjc.isHeMai = YES;
        [self.navigationController pushViewController:gcjc animated:YES];
        [gcjc release];

        
    }
    else if ([lotteryId isEqualToString:@"400"]){
        GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
        bjdanchang.isHeMai = YES;
        [self.navigationController pushViewController:bjdanchang animated:YES];
        [bjdanchang release];

        
    }
    else if ([lotteryId isEqualToString:@"300"]){
        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
        bet.isHemai = YES;
        bet.bettingstype = bettingStypeShisichang;
        [self.navigationController pushViewController:bet animated:YES];
        [bet release];
        
    }
    else if ([lotteryId isEqualToString:@"301"]){
        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
        bet.isHemai = YES;
        bet.bettingstype = bettingStypeRenjiu;
        [self.navigationController pushViewController:bet animated:YES];
        [bet release];
        
    }
    else if ([lotteryId isEqualToString:@"200"]){
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
        gcjc.isHeMai = YES;
        NSArray * timeArray = [self.sysTime componentsSeparatedByString:@" "];
        if ([timeArray count] >= 2 ) {
            gcjc.systimestr = [timeArray objectAtIndex:0];
        }else{
            gcjc.systimestr = self.sysTime;
        }
        gcjc.lanqiubool = YES;
        [self.navigationController pushViewController:gcjc animated:YES];
        [gcjc release];
        
    }
}


// 判断是否正在刷新状态
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return isLoading; // should return if data source model is reloading	
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
	UITableView *mTableView = myTableView;
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
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
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords];
	[seachPerson setHidesBottomBarWhenPushed:YES];
	seachPerson.cpthree = YES;
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

#pragma mark - 搜索按钮点击事件
- (void)pressSearch:(id)sender{
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		[self.view addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = YES;
	[self.view addSubview:PKsearchBar];
	[PKsearchBar becomeFirstResponder];
    
}

#pragma mark - 合买列表的请求 和 红人榜的请求
- (void)requestLotteryTimeFinished:(ASIHTTPRequest *)request {
    manyuan = 2;
    
//    if (zuixinBut.selected == YES) {
//        paixustr = @"DD";
//        manyuan = 2;
//    }
//    if (renqiBut.selected == YES) {
//        paixustr = @"AD";
//        manyuan = 2;
//    }
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    NSInteger page;
    if (heMaiType) {
        [schemeArray removeAllObjects];
        page = 1;
    }else{
        page = [schemeArray count]/20 +1;
    }
    if (isLoading) {
       
        page = 1;
    }else if ([schemeArray count]%20 != 0) {
        
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
        
        return;
	}
    
    
    if ((!request && lotteryType == 106) || lotteryType == 105 || lotteryType == 2222 || lotteryType == 2223 || lotteryType == 270) {
        NSString *lottery = [GC_LotteryType lotteryIDWithLotteryType:(int)lotteryType];
//        if (lotteryType == 270) {
//            lottery = @"270";
//        }
        currentIssue = [GC_UserInfo sharedInstance].curLocalDate;
        if (lotteryType == 270) {
            currentIssue = @"";
        }
//        if(!loadview){
//            loadview = [[UpLoadView alloc] init];
//            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//            [appDelegate.window addSubview:loadview];
//            [loadview release];
//        }
        
       
        NSMutableData *postData = [[GC_HttpService sharedInstance] HMreqBuyTogetherData:lottery issue:currentIssue amountType:0 baodi:0 eachMoney:0 isFull:manyuan speed:0 recordCount:20 page:(int)page schemeType:heMaiType sortWay:paixustr];
        heMaiType = 0;
        [self.httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [self.httpRequest setDidFinishSelector:@selector(requestBuyTogetherFinished:)];
        [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self.httpRequest setRequestMethod:@"POST"];
        [self.httpRequest setPostBody:postData];
        [self.httpRequest setDelegate:self];
        [self.httpRequest addCommHeaders];
        [self.httpRequest startAsynchronous];
       
    } else {
        if (!lotteryTime) {
            lotteryTime = [[GC_LotteryTime alloc] initWithResponseData:[request responseData] WithRequest:request] ;
        }
        
        if (lotteryTime && lotteryTime.currentIssue && lotteryTime.currentIssue.length) {
//            if(!loadview){
//                loadview = [[UpLoadView alloc] init];
//                caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//                [appDelegate.window addSubview:loadview];
//                [loadview release];
//            }
            
            
            NSString *lottery = [GC_LotteryType lotteryIDWithLotteryType:(int)lotteryType];
            NSMutableData *postData = [[GC_HttpService sharedInstance] HMreqBuyTogetherData:lottery issue:lotteryTime.currentIssue amountType:0 baodi:0 eachMoney:0 isFull:manyuan speed:0 recordCount:20 page:(int)page schemeType:heMaiType sortWay:paixustr];
            heMaiType = 0;
            [self.httpRequest clearDelegatesAndCancel];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [self.httpRequest setDidFinishSelector:@selector(requestBuyTogetherFinished:)];
            [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [self.httpRequest setRequestMethod:@"POST"];
            [self.httpRequest setPostBody:postData];
            [self.httpRequest setDelegate:self];
            [self.httpRequest addCommHeaders];
            [self.httpRequest startAsynchronous];
           
        }else{
            [myTableView reloadData];
            [moreCell spinnerStopAnimating];
        }
        
    }
}

- (void)requestBuyTogetherFinished:(ASIHTTPRequest *)request {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    if (isLoading) {
        [schemeArray removeAllObjects];
    }
    
    BuyTogetherInfo *buyTogetherInfo = [[BuyTogetherInfo alloc] initWithResponseData:[request responseData] WithRequest:request];
    self.sysTime = buyTogetherInfo.systemTime;
    if (buyTogetherInfo && buyTogetherInfo.schemeArray && [buyTogetherInfo.schemeArray count] && buyTogetherInfo.returnID != 3000) {
     
        [schemeArray addObjectsFromArray:buyTogetherInfo.schemeArray];
        NSLog(@"%@", schemeArray);
    }
    [buyTogetherInfo release];
    [myTableView reloadData];
    [moreCell spinnerStopAnimating];
    isLoading = NO;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    if (goucaibool) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onehemaidating"] intValue] != 1) {
            
            [self menuView];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"onehemaidating"];
            
        }
    }
    
}


- (void)requestRed{
    NSInteger page = [schemeArray count]/20 +1;
//    if (!loadview) {
//        loadview = [[UpLoadView alloc] init];
//        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//        [appDelegate.window addSubview:loadview];
//        [loadview release];
//    }
    
    if (isLoading) {
        page = 1;
        
    }else if ([schemeArray count]%20 != 0) {
        
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        
        return;
	}
    
    
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL hemaihongrenbangLotteryId:lotteryId page:[NSString stringWithFormat:@"%d", (int)page]]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httpRequest setNumberOfTimesToRetryOnTimeout:2];
    [httpRequest startAsynchronous];

}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    NSString * str = [mrequest responseString];
    
    if (isLoading) {
        [schemeArray removeAllObjects];
    }
    
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    
    NSArray * allarr = [dict objectForKey:@"HotStar"];
    for (NSDictionary * str in allarr) {
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
        
        
        [schemeArray addObject:ann];
        [ann release];
    }
   [moreCell spinnerStopAnimating];
    [myTableView reloadData];
    isLoading = NO;
 [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
   
    
}

-(void)requestFailed:(ASIHTTPRequest*)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    isLoading = NO;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    [[caiboAppDelegate getAppDelegate] showMessage:@"网络超时"];
}

#pragma mark - 最新 人气 红人榜的点击事件
//- (void)pressButton:(UIButton *)sender{
//    zuixinBut.selected = NO;
//    renqiBut.selected = NO;
//    hongrenBut.selected = NO;
//    sender.selected = YES;
//    if (butTag != sender.tag) {
//        [schemeArray removeAllObjects];
//        butTag = sender.tag;
//        
//        
//        
//        if (sender.tag == 100 || sender.tag == 101) {
//            myTableView.frame = CGRectMake(12, 47, 296, self.view.bounds.size.height - 50);
//            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];
//        }
//        if (sender.tag == 102) {
//            myTableView.frame = CGRectMake(17, 47, 305, self.view.bounds.size.height - 50);
//            [self requestRed];
//        }
//        
//        
//        [myTableView reloadData];
//    }
//}


- (void)doBack{
    if(isNeedPopToRoot){
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    else{
        [self.navigationController popViewControllerAnimated:YES];

        
    }
}


#pragma mark - tableview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {
        _lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
        //49
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationDelegate:self];
        self.tabBarController.tabBar.frame=CGRectMake(0, aapp.window.frame.size.height, 320, 49);
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
            UIView *view1 = [[self.tabBarController.view subviews] objectAtIndex:0];
            //            view1.window.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height);
            view1.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height);
            self.mainView.frame = CGRectMake(0, 44, 320, aapp.window.frame.size.height - 44);
            //            myTableView.frame = CGRectMake(0, 0, 320,self.mainView.bounds.size.height);
        }
        [UIView commitAnimations];
        
    }
//    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20))
    else if (_lastPosition - currentPostion > 0)
//    else if ((_lastPosition - currentPostion > 0) || currentPostion > scrollView.contentSize.height - scrollView.bounds.size.height-49)
    {
        _lastPosition = currentPostion;
        //        NSLog(@"ScrollDown now");
        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
        
        [UIView animateWithDuration:.5 animations:^{
            self.tabBarController.tabBar.frame=CGRectMake(0, aapp.window.frame.size.height-49, 320, 49);
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
                UIView *view1 = [[self.tabBarController.view subviews] objectAtIndex:0];
                //                view1.window.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49);
                view1.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height -49);
                self.mainView.frame = CGRectMake(0, 44, 320, aapp.window.frame.size.height - 44 -49);
                //                myTableView.frame = CGRectMake(0, 0, 320,self.mainView.bounds.size.height);
            }
        } completion:^(BOOL finished) {
            
        }];
        
    }
    

    
    
//	UITableView *mTableView = myTableView;
//    CGFloat f = 100;
//    if (mTableView.contentSize.height >= mTableView.frame.size.height) 
//    {
//        f = mTableView.contentSize.height - mTableView.frame.size.height + 120;
//    }
//    if (scrollView.contentOffset.y >= f) 
//    {
        [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
    //}
    
    
}
// 下拉结束停在正在更新状态

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    NSLog(@"%f  %f",myTableView.contentSize.height,scrollView.contentOffset.y);
    
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
        if ([paixustr isEqualToString:@"HR"]) {
            if (!isLoading) {
                 [self requestRed];//网络请求
            }
           
        }else{
            if (!isLoading) {
                [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil afterDelay:0.5];//网络请求
                
            }
        }
        [moreCell spinnerStartAnimating];

        
	}
    	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
    
	
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
	}else if([paixustr isEqualToString:@"HR"]){
        return 60;
    }
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
	}
    return [schemeArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if ([self.seachTextListarry count] > indexPath.row) {
            NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row];
            
            cell.textLabel.text =text ;
        }
        
        return cell;
        
        
    }else{
        
        
        
        if (indexPath.row == [schemeArray count]) {
            static NSString *CellIdentifier = @"Cell";
            CellIdentifier = @"MoreLoadCell";
            
            MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell1 == nil) {
                cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                
                [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
                //moreCell.backgroundColor = [UIColor clearColor];
            }
            
            if (moreCell == nil) {
                self.moreCell = cell1;
            }
            
            if(schemeArray.count != 0)
            {
                if([tableView numberOfRowsInSection:indexPath.section] > 1)
                {
                    [moreCell spinnerStartAnimating];
                    if ([paixustr isEqualToString:@"HR"]) {
                        [self requestRed];
                    }else{
                        [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];//网络请求函数
                    }
                }
            }
            
            
            return cell1;
        }else{
            if ([paixustr isEqualToString:@"HR"]) {
                
                
                NSString * cellid = @"celleeid";
                HongRenBangCell * cell = (HongRenBangCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[HongRenBangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                }
                if ([schemeArray count] > indexPath.row) {
                    AnnouncementData * sche = [schemeArray objectAtIndex:indexPath.row];
                    NSLog(@"sche user = %@", sche.userName);
                    sche.num = 1;
                    cell.ishemai = YES;
                    if (indexPath.row == 0) {
                        cell.isdiyi = YES;
                    }else{
                        cell.isdiyi = NO;
                    }
                    if (indexPath.row == [schemeArray count]-1) {
                        cell.imagebool = YES;
                    }else{
                        cell.imagebool = NO;
                    }
                    
                    cell.annou = sche;
                }
                else {
                    cell.annou = nil;
                }
                cell.backgroundColor = [UIColor clearColor];
                return  cell;
                
            }else{
                NSString * cellid = @"cellid";
                GCHemaiCell * cell = (GCHemaiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[GCHemaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                }
                if (schemeArray.count > indexPath.row) {
                    SchemeInfo * sche = [schemeArray objectAtIndex:indexPath.row];
                    cell.schem = sche;
                }
                else {
                    cell.schem = nil;
                }

                cell.backgroundColor = [UIColor clearColor];
                return  cell;
            
            }
            
           
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [self goLogin];
        return;
    }
    
    
    
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    if (indexPath.row == [schemeArray count]) {
        [moreCell spinnerStartAnimating];
        if ([paixustr isEqualToString:@"HR"]) {
            [self requestRed];
        }else{
            [self performSelector:@selector(requestLotteryTimeFinished:) withObject:nil];//网络请求函数
        }
    }else{
    
        if ([paixustr isEqualToString:@"HR"]) {//红人榜
        
            AnnouncementData * annou = [schemeArray objectAtIndex:indexPath.row];
            Nickname = annou.user;
            userid = annou.userID;
            
            username= annou.userName;
         
            CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            lb.delegate = self;
           
            [lb LoadButtonName:[NSArray arrayWithObjects:@"他的彩票", @"他的合买", @"@他", @"他的微博",@"他的资料", nil]];
            [lb show];
            [lb release];
            
        }else{//人气 最新
            [MobClick event:@"event_goucai_hemaidating_xiangqing" label:titleLabel.text];
            SchemeInfo * scheminfo = [schemeArray objectAtIndex:indexPath.row];
            
            //方案编号:scheminfo.schemeNumber  彩种:scheminfo.lotteryType   期号scheminfo.issue
            
			ShuangSeQiuInfoViewController *he = [[ShuangSeQiuInfoViewController alloc] init];
            he.delegate = self;
			BetRecordInfor *betinfo = [[BetRecordInfor alloc] init];
            he.hemaibool = YES;
			if ([scheminfo.initiator isEqualToString:[[Info getInstance] nickName]]) {
				betinfo.betStyle = @"0";
			}
			else {
				betinfo.betStyle = @"1";
			}
			betinfo.programNumber = [NSString stringWithFormat:@"%d",(int)scheminfo.schemeNumber];
			betinfo.issue = scheminfo.issue;
                if ([self.title length]>2) {
                    betinfo.lotteryName = [self.title substringToIndex:[self.title length] -2];
                }
            
			
			betinfo.lotteryNum = scheminfo.lotteryType;
			he.BetInfo = betinfo;
			[betinfo release];
            [self.navigationController setNavigationBarHidden:YES animated:NO];
			[self.navigationController pushViewController:he animated:YES];
			[he release];
        
        }
    
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
    tabc.delegateCP = self;
    
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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
//
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
        [mTempStr release];
        publishController.mStatus = topic1;
        [topic1 release];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
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

- (void)dealloc{
    [lotteryId release];
    [seachTextListarry release];
    [searchDC release];
    [PKsearchBar release];
    [schemeArray release];
    [caizhongstr release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [myTableView release];
    [sanjiaoImageView release];
    self.sysTime = nil;
    [super dealloc];
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

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
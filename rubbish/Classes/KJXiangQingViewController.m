//
//  KJXiangQingViewController.m
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "KJXiangQingViewController.h"
#import "Info.h"
#import "XiangQingCell.h"
#import "ReYiCell.h"
#import "TopicThemeListViewController.h"
#import "DetailedViewController.h"
#import "NetURL.h"
#import "MyWebViewController.h"
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "LastLottery.h"
#import "NSStringExtra.h"
#import "CP_LieBiaoView.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "ProfileViewController.h"
#import "JSON.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MobClick.h"
#import "footballLotteryInfoViewController.h"
#import "moneyViewController.h"
#import "LastLotteryViewController.h"
#import "HighFreqViewController.h"
#import "ShiShiCaiViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "FuCai3DViewController.h"
#import "DaLeTouViewController.h"
#import "QIleCaiViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "Pai3ViewController.h"
#import "GCBettingViewController.h"
#import "GCJCBetViewController.h"
#import "GC_BJDanChangViewController.h"
#import "KuaiSanViewController.h"
#import "HappyTenViewController.h"
#import "KuaiLePuKeViewController.h"
#import "CQShiShiCaiViewController.h"
#import "GuoGuanViewController.h"
#import "SendMicroblogViewController.h"
#import "SharedDefine.h"
#import "HorseRaceViewController.h"
#import "GC_PKRankingList.h"
#import "JSON.h"

@implementation KJXiangQingViewController

@synthesize  issuesting;//期号
@synthesize datestring;//时间
@synthesize qiustring;//开奖号码 球
@synthesize benstring;//本期销售
@synthesize chistring;//奖池
@synthesize zhongarray;//中奖信息
@synthesize reyiArray;
@synthesize shisi;
@synthesize renjiu;
@synthesize cainame;
@synthesize mRequest;
@synthesize huatistring;
@synthesize lotteries;
@synthesize sectionnum;
@synthesize rownum;
@synthesize lotteryName;
@synthesize paihangarr;
@synthesize matchdict;
@synthesize myHttpRequest;
@synthesize lotteryNumber;
@synthesize isDangQianQi, Luck_blueNumber;
#pragma mark 历史开奖

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

static KJXiangQingViewController *kjxqcontroller;
+ (KJXiangQingViewController *) getShareDetailedView {
    return kjxqcontroller;
}
- (id)initWithEnumeration:(CP_LotteryType)lotteryt{
    lotteryType = lotteryt;
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)pressKaiJiangTuiSong:(UIButton *)sender{
    
    NSDictionary *dic = [self.lotteries objectAtIndex:sectionnum];//真正的
    NSArray *arr = [dic objectForKey:@"list"];
    LastLottery *lottery = [arr objectAtIndex:rownum];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId = self.cainame;
    controller.lotteryName = lottery.lotteryName;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    [MobClick event:@"event_kaijiangdating_lishikaijiang" label:[GC_LotteryType lotteryNameWithLotteryID:self.cainame]];


}
#pragma mark 是否有历史开奖按钮 set get方法
- (BOOL)wangqibool{
    return wangqibool;
}
- (void)setWangqibool:(BOOL)_wangqibool{
    wangqibool = _wangqibool;
//    if (wangqibool) {
//        
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBounds:CGRectMake(0, 0, 58, 23)];
//        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 23)];
//        imagevi.backgroundColor = [UIColor clearColor];
//        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
//        [btn addSubview:imagevi];
//        [imagevi release];
//        
//        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 23)];
//        lilable.textColor = [UIColor whiteColor];
//        lilable.backgroundColor = [UIColor clearColor];
//        lilable.textAlignment = NSTextAlignmentCenter;
//        lilable.font = [UIFont systemFontOfSize:11];
//        lilable.shadowColor = [UIColor whiteColor];//阴影
//        lilable.shadowOffset = CGSizeMake(0, 1.0);
//        lilable.text = @"历史开奖";
//        [btn addSubview:lilable];
//        [lilable release];
//        [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        self.CP_navigation.rightBarButtonItem = barBtnItem;
//        [barBtnItem release];
//        
//        
//    }else{
//        self.CP_navigation.rightBarButtonItem = nil;
//    }

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

- (void)moreTopictableViewDataBack:(ASIHTTPRequest *)arequest{
    NSLog(@"11111111111111");
    NSString *responseString = [arequest responseString];
    NSLog(@"respon3 = %@", responseString);
    
        YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
       
  //  YtTopic *topic = [[YtTopic alloc] initWithParse:responseString];
    if ([topic.arrayList count] > 0)
        {
        if (toyarray) 
            {
            [toyarray addObjectsFromArray:topic.arrayList];
			}
		}
    [topic release];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    kjxqcontroller = self;
    NSLog(@"huati = %@", [NetURL CBgetThemetYtTipic:[[Info getInstance] userId] themeName:huatistring pageNum:@"1" pageSize:@"20"]);
    //背景
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgImageView.backgroundColor = [UIColor clearColor];
//    bgImageView.image = UIImageGetImageFromName(@"login_bgn.png") ;
    bgImageView.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    [self.mainView addSubview:bgImageView];
    [bgImageView release];
    if (wangqibool) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBounds:CGRectMake(0, 0, 70, 40)];
        [btn setBounds:CGRectMake(0, 0, 90, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
//        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
        
        [btn addSubview:imagevi];
        [imagevi release];
        
//        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 80, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
//        lilable.font = [UIFont boldSystemFontOfSize:11];
        lilable.font = [UIFont boldSystemFontOfSize:17];
//        lilable.shadowColor = [UIColor blackColor];//阴影
//        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"历史开奖";
        [btn addSubview:lilable];
        [lilable release];
        [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
        
        
    }else{
        self.CP_navigation.rightBarButtonItem = nil;
    }
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetThemetYtTipic:[[Info getInstance] userId] themeName:huatistring pageNum:@"1" pageSize:@"20"]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(moreTopictableViewDataBack:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];
    
    
//    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    bgImageView.backgroundColor = [UIColor clearColor];
//    bgImageView.image = UIImageGetImageFromName(@"login_bg.png");
//    [self.view addSubview:bgImageView];
    toyarray =  [[NSMutableArray alloc] initWithCapacity:0];
    self.CP_navigation.title = @"开奖详情";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    
//    NSDictionary *dic = [self.lotteries objectAtIndex:sectionnum];
//    NSArray *arr = [dic objectForKey:@"list"];
//    LastLottery *lottery = [arr objectAtIndex:rownum];
    [MobClick event:@"event_kaijiang_detail_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:self.cainame]];
    if ([self.cainame isEqualToString:@"119"]) {
        [MobClick event:@"event_kaijiang_11xuan5_detail"];
    }
    else if ([self.cainame isEqualToString:@"006"]){
        [MobClick event:@"event_kaijiang_shishicai_detail"];
    }
    else if ([self.cainame isEqualToString:@"001"]){
        [MobClick event:@"event_kaijiang_shuangseqiu_detail"];
    }
    else if ([self.cainame isEqualToString:@"002"]){
        [MobClick event:@"event_kaijiang_fucai3d_detail"];
    }
    else if ([self.cainame isEqualToString:@"113"]){
        [MobClick event:@"event_kaijiang_chaojiletou_detail"];
    }
    else if ([self.cainame isEqualToString:@"003"]){
        [MobClick event:@"event_kaijiang_7lecai_detail"];
    }
    else if ([self.cainame isEqualToString:@"109"]){
        [MobClick event:@"event_kaijiang_pailie5_detail"];
    }
    else if ([self.cainame isEqualToString:@"110"]){
        [MobClick event:@"event_kaijiang_qixingcai_detail"];
    }
    else if ([self.cainame isEqualToString:@"111"]){
        [MobClick event:@"event_kaijiang_22xuan5_detail"];
    }
    else if ([self.cainame isEqualToString:@"108"]){
        [MobClick event:@"event_kaijiang_pailie3_detail"];
    }
    else if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]){
        [MobClick event:@"event_kaijiang_shengfu9_detail"];
    }
    else if ([self.cainame isEqualToString:@"302"]){
        [MobClick event:@"event_kaijiang_banquanchang_detail"];
    }
    else if ([self.cainame isEqualToString:@"303"]){
        [MobClick event:@"event_kaijiang_jinqiucai_detail"];
    }else if([self.cainame isEqualToString:@"011"]){
    
    }
    [self shangMianNieRong];
    
    
    
    
    qiuscrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
        
    qiuscrollView.backgroundColor  = [UIColor clearColor];
    [qiuscrollView setDelegate:self];
    qiuscrollView.scrollsToTop = YES;
    [qiuscrollView setPagingEnabled:NO];
    [qiuscrollView setShowsVerticalScrollIndicator:YES];
    [qiuscrollView setShowsHorizontalScrollIndicator:NO];
    qiuscrollView.tag = 1;
    qiuscrollView.contentSize = CGSizeMake(qiuscrollView.frame.size.width, bgViewController.frame.size.height);
    
    [self.mainView addSubview:qiuscrollView];
    
    pagecon = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, 320, 30)];
    [pagecon setNumberOfPages:6];
    pagecon.hidden = YES;
    [pagecon setCurrentPage:0];
    [pagecon addTarget:self action:@selector(qiuchangePage:) forControlEvents:(UIControlEventValueChanged)];
    
    [self.mainView addSubview:pagecon];
    
    [qiuscrollView addSubview:bgViewController];
    
    
    
//    UIImageView * reyiImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 350, 70, 40)];
//    reyiImage.image = UIImageGetImageFromName(@"gc_wbBtn.png");
//    reyiImage.backgroundColor = [UIColor clearColor];
//    [bgViewController addSubview:reyiImage];
//    [reyiImage release];
    
    //下面微博热议
    [self xiaMianNieRong];

    
    
    if ([self.cainame isEqualToString:@"303"] ||[self.cainame isEqualToString:@"302"] ||[self.cainame isEqualToString:@"111"]||[self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"200"]||[self.cainame isEqualToString:@"201"]||[self.cainame isEqualToString:@"400"]||[self.cainame isEqualToString:@"012"]||[self.cainame isEqualToString:@"013"]||[self.cainame isEqualToString:@"019"]||[self.cainame isEqualToString:@"018"]||[self.cainame isEqualToString:@"107"]||[self.cainame isEqualToString:@"119"]||[self.cainame isEqualToString:@"121"]||[self.cainame isEqualToString:@"122"]||[self.cainame isEqualToString:@"014"]||[self.cainame isEqualToString:@"011"]||[self.cainame isEqualToString:LOTTERY_ID_ANHUI]) {
        return;
    }
    
    qiuscrollView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - 44);
    

    UIImageView * gcImageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 44, 320, 44)];//下面投注按钮背景
//     gcImageBg.image = UIImageGetImageFromName(@"daigoubgimage.png");
    gcImageBg.backgroundColor = [UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
    
    gcImageBg.userInteractionEnabled = YES;
    [self.mainView addSubview:gcImageBg];
    [gcImageBg release];
    
    NSString *str = [NSString stringWithFormat:@"%@投注", lotteryName];
    CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:18]];
    
    UIButton * gcButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    gcButton.frame = CGRectMake((gcImageBg.frame.size.width - 270)/2, (gcImageBg.frame.size.height - 33)/2, 270, 33);
    gcButton.frame = CGRectMake((gcImageBg.frame.size.width - size.width-20)/2, (gcImageBg.frame.size.height - 33)/2, size.width+20, 33);
    [gcButton addTarget:self action:@selector(pressGcButton:) forControlEvents:UIControlEventTouchUpInside];
//    [gcButton setImage:UIImageGetImageFromName(@"daigouanniu.png") forState:UIControlStateNormal];
//    [gcButton setImage:UIImageGetImageFromName(@"daigouanniu_1.png") forState:UIControlStateHighlighted];
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [gcImageBg addSubview:gcButton];
    
    UILabel * buttonLabel = [[UILabel alloc] initWithFrame:gcButton.bounds];
    buttonLabel.backgroundColor = [UIColor clearColor];
//    buttonLabel.textColor = [UIColor colorWithRed:0/255.0 green:89/255.0 blue:126/255.0 alpha:1];
//    buttonLabel.textColor = [UIColor colorWithRed:209/255.0 green:201/255.0 blue:170/255.0 alpha:1];
    buttonLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel.text = [NSString stringWithFormat:@"%@投注", lotteryName];
    buttonLabel.font = [UIFont systemFontOfSize:18];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    [gcButton addSubview:buttonLabel];
    [buttonLabel release];
    
    
}

- (void)pressGcButton:(UIButton *)sender{


    if ([self.cainame isEqualToString:@"119"]) {

        if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
            HorseRaceViewController * high = [[[HorseRaceViewController alloc] init] autorelease];
            [self.navigationController pushViewController:high animated:YES];
        }else{
            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
    }
    else if ([self.cainame isEqualToString:@"121"]) {
        
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if ([self.cainame isEqualToString:LOTTERY_ID_JIANGXI_11]) {
        
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if ([self.cainame isEqualToString:@"123"]) {
        
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:HeBei11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if ([self.cainame isEqualToString:LOTTERY_ID_SHANXI_11]) {
        
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanXi11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if ([self.cainame isEqualToString:@"006"]){
       
        ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
        [self.navigationController pushViewController:shishi animated:YES];
        [shishi release];
    }
    else if ([self.cainame isEqualToString:@"001"]){
        GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
//        shuang.item = cell.myrecord.curIssue;
        [self.navigationController pushViewController:shuang animated:YES];
        //shuang.title = [NSString stringWithFormat:@"双色球%@期",cell.myrecord.curIssue];
        [shuang release];
    }
    else if ([self.cainame isEqualToString:@"002"]){
//        [MobClick event:@"event_kaijiang_fucai3d_detail"];
        FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
//        fucai.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:fucai animated:YES];
        [fucai release];
    }
    else if ([self.cainame isEqualToString:@"113"]){
//        [MobClick event:@"event_kaijiang_chaojiletou_detail"];
        DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
//        dale.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:dale animated:YES];
        [dale release];
    }
    else if ([self.cainame isEqualToString:@"003"]){
//        [MobClick event:@"event_kaijiang_7lecai_detail"];
        QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
//        con.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:con animated:YES];
        [con release];
    }
    else if ([self.cainame isEqualToString:@"109"]){
//        [MobClick event:@"event_kaijiang_pailie5_detail"];
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
//        paiwuqixing.myissueRecord = cell.myrecord;
        paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;
        [self.navigationController pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    else if ([self.cainame isEqualToString:@"110"]){
//        [MobClick event:@"event_kaijiang_qixingcai_detail"];
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
//        paiwuqixing.myissueRecord = cell.myrecord;
        paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
        [self.navigationController pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    else if ([self.cainame isEqualToString:@"108"]){
//        [MobClick event:@"event_kaijiang_pailie3_detail"];
        Pai3ViewController *pai = [[Pai3ViewController alloc] init];
//        pai.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:pai animated:YES];
        [pai release];
    }

    
    else if([self.cainame isEqualToString:@"012"]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
//        highview.issue = cell.myrecord.curIssue;
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    
    }
    else if([self.cainame isEqualToString:@"013"]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if([self.cainame isEqualToString:@"019"]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if([self.cainame isEqualToString:LOTTERY_ID_JILIN]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if([self.cainame isEqualToString:LOTTERY_ID_ANHUI]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if([self.cainame isEqualToString:@"011"]){
        
        HappyTenViewController *happy = [[HappyTenViewController alloc] init];
        [self.navigationController pushViewController:happy animated:YES];
        [happy release];

    }
    else if([self.cainame isEqualToString:@"122"]){
        KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
//        puke.myIssrecord = cell.myrecord;
        [self.navigationController pushViewController:puke animated:YES];
        [puke release];
    }else if([self.cainame isEqualToString:@"014"]){
    
        CQShiShiCaiViewController * cqshishi = [[CQShiShiCaiViewController alloc] init];
        [self.navigationController pushViewController:cqshishi animated:YES];
        [cqshishi release];
    }
    
}


- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
        my.userName = horseRankList.userName;
        my.nickName = horseRankList.userNicheng;
        my.userid = @"";
    }else{
        my.userName = [zhongjiedict objectForKey:@"username"];
        my.nickName = [zhongjiedict objectForKey:@"nickname"];
        my.userid = [zhongjiedict objectForKey:@"userid"];
    }
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
        my2.myLottoryType = MyLottoryTypeOtherHe;
        my2.userName = horseRankList.userName;
        my2.nickName = horseRankList.userNicheng;
        my2.userid = @"";
    }else{
        my2.myLottoryType = MyLottoryTypeOtherHe;
        my2.userName = [zhongjiedict objectForKey:@"username"];
        my2.nickName = [zhongjiedict objectForKey:@"nickname"];
        my2.userid = [zhongjiedict objectForKey:@"userid"];
    }
    
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
//    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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

#pragma mark 微博热议
- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (liebiaoView.tag == 103) {
        
        if (liebiaoView.weixinBool) {
            if (buttonIndex == 1) {//微信
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 0) {//新浪微博
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 2) {//腾讯微博
                [self performSelector:@selector(tencentShareFunc) withObject:nil afterDelay:0.3];
            }
        }
        else {
            if (buttonIndex == 0) {//微信
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 1) {//新浪微博
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
            }
            else if (buttonIndex == 2) {//腾讯微博
                [self performSelector:@selector(tencentShareFunc) withObject:nil afterDelay:0.3];
            }
        }
    }else{
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }
        
        
        if (buttonIndex == 0) {//他的方案
            
            //		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
            //		my.userName = [zhongjiedict objectForKey:@"username"];
            //		my.nickName = [zhongjiedict objectForKey:@"nickname"];
            //		[self.navigationController pushViewController:my animated:YES];
            //		my.title = [zhongjiedict objectForKey:@"nickname"];
            //		[my release];
            [self otherLottoryViewController:0];
        }else if(buttonIndex == 1){
            //        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
            //        my.myLottoryType = MyLottoryTypeOtherHe;
            //		my.userName = [zhongjiedict objectForKey:@"username"];
            //		my.nickName = [zhongjiedict objectForKey:@"nickname"];
            //		[self.navigationController pushViewController:my animated:YES];
            //		my.title = [zhongjiedict objectForKey:@"nickname"];
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
            [mTempStr appendString:[zhongjiedict objectForKey:@"nickname"]];//传用户名
            [mTempStr appendString:@" "];
            topic1.nick_name = mTempStr;
            [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
            
            [topic1 release];
#else
            
//            NewPostViewController *publishController = [[NewPostViewController alloc] init];
//            publishController.publishType = kNewTopicController;// 自发彩博
//            YtTopic *topic1 = [[YtTopic alloc] init];
//            NSMutableString *mTempStr = [[NSMutableString alloc] init];
//            [mTempStr appendString:@"@"];
//            [mTempStr appendString:[zhongjiedict objectForKey:@"nickname"]];//传用户名
//            [mTempStr appendString:@" "];
//            topic1.nick_name = mTempStr;
//            publishController.mStatus = topic1;
//            [self.navigationController pushViewController:publishController animated:YES];
//            [topic1 release];
//            [mTempStr release];
//            //        [navController release];
//            [publishController release];
            
            
            SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
            publishController.microblogType = NewTopicController;// 自发彩博
            YtTopic *topic1 = [[YtTopic alloc] init];
            NSMutableString *mTempStr = [[NSMutableString alloc] init];
            [mTempStr appendString:@"@"];
            if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
                [mTempStr appendString:horseRankList.userNicheng];//传用户名
            }else{
                [mTempStr appendString:[zhongjiedict objectForKey:@"nickname"]];//传用户名
            }
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
            
            //        ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:[zhongjiedict objectForKey:@"userid"]];//himID传用户的id
            //        [controller setSelectedIndex:0];
            //        controller.navigationItem.title = @"微博";
            //        [self.navigationController setNavigationBarHidden:YES animated:NO];
            //        [self.navigationController pushViewController:controller animated:YES];
            //        [controller release];
            
            if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
                [myHttpRequest clearDelegatesAndCancel];
                self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL cpThreeUserName:horseRankList.userName]];
                [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [myHttpRequest setDelegate:self];
                [myHttpRequest setDidFinishSelector:@selector(useridRequestDidFinishSelector:)];
                [myHttpRequest setNumberOfTimesToRetryOnTimeout:2];
                [myHttpRequest startAsynchronous];

            }else{
                TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
                controller.userID = [zhongjiedict objectForKey:@"userid"];
                controller.title = @"他的微博";
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
            }
        }else if (buttonIndex == 4){//他的资料
            [[Info getInstance] setHimId:[[zhongjiedict valueForKey:@"userid"] copy]];

            ProfileViewController *followeesController = [[ProfileViewController alloc] init];
            if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
                followeesController.himNickName = horseRankList.userNicheng;
            }else{
                followeesController.himNickName = [zhongjiedict objectForKey:@"nickname"];
            }
            [self.navigationController pushViewController:followeesController animated:YES];
            [followeesController release];
        }
        
    }
    
}

-(void)useridRequestDidFinishSelector:(ASIHTTPRequest *)request
{
    if (request) {
        NSString * str = [request responseString];
        
        NSDictionary * dict = [str JSONValue];
        NSString * codestr = [dict objectForKey:@"code"];
        if([codestr isEqualToString:@"1"]){
            NSString * useridst = [dict objectForKey:@"userid"];
//            self.PKUserId = useridst;
            TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
            controller.userID = useridst;
            controller.title = @"他的微博";
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            
        }
        else {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"获取失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    }
}

//- (void)useridRequestDidFinishSelector:(ASIHTTPRequest *)mrequest{
//    
//    if (mrequest) {
//        NSString * str = [mrequest responseString];
//        
//        NSDictionary * dict = [str JSONValue];
//        NSString * codestr = [dict objectForKey:@"code"];
//        if([codestr isEqualToString:@"1"]){
//            NSString * useridst = [dict objectForKey:@"userid"];
//            ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:useridst];//himID传用户的id
//            [controller setSelectedIndex:0];
//            controller.navigationItem.title = @"微博";
//            [self.navigationController pushViewController:controller animated:YES];
//            [controller release];
//            
//        }
//        else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//            
//        }
//    }
//}
- (void)pressNameButton:(UIButton *)sender{
    if (sender.tag == 2101) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"方案隐身"];
        return;
    }
    if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
        horseRankList = [paihangarr objectAtIndex:sender.tag];
    }else{
        zhongjiedict = [paihangarr objectAtIndex:sender.tag];
    }
    CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lb.delegate = self;
    lb.tag = 101;
    [lb LoadButtonName:[NSArray arrayWithObjects:@"他的彩票", @"他的合买", @"@他", @"他的微博",@"他的资料", nil]];
    [lb show];
    [lb release];
}

- (void)pressbuttonben:(UIButton *)sender{
    if (sender.tag == 2101) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"方案隐身"];
        return;
    }
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        return;
    }
    
    ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
    //info.canBack = self.canBack;
    info.nikeName = @"";
    info.title = @"投注详情";
    if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
        if (paihangarr.count > sender.tag) {
            BetRecordInfor * BetInfo = [[[BetRecordInfor alloc] init] autorelease];
            NSDictionary * bianHao = [[[paihangarr objectAtIndex:sender.tag] moreData] JSONValue];
            BetInfo.programNumber = [bianHao valueForKey:@"agintOrderId"];
            BetInfo.lotteryName = Lottery_Name_Horse;
            info.BetInfo = BetInfo;
            info.canBuyAgain = NO;
        }
    }else{
        info.orderId = [[paihangarr objectAtIndex:sender.tag] objectForKey:@"ordered"];
    }
    [self.navigationController pushViewController:info animated:YES];
    [info release];
}

- (void)ggOtherLottoryViewController:(NSInteger)indexd{
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
    if (indexd == 0) {
        my3.renorsheng = shengfu;
    }else if(indexd == 1){
        my3.renorsheng = renjiu;
    }
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, my3, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"胜负彩"];
    [labearr addObject:@"任选9"];
    [labearr addObject:@"我的中奖"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    
    [imagestring addObject:@"ggssc.png"];
    [imagestring addObject:@"ggrxq.png"];
    [imagestring addObject:@"ggwdcp.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggssc_1.png"];
    [imageg addObject:@"ggrxq_1.png"];
    [imageg addObject:@"ggwdcp_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    ggtabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    ggtabc.selectedIndex = indexd;
//    ggtabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    ggtabc.backgroundImage = nil;
    
    
    
    [self.navigationController pushViewController:ggtabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [ggtabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my3 release];
    [my release];
}


- (void)pressPassABarrierButton:(UIButton *)sender{

     [self ggOtherLottoryViewController:0];

}

- (void)xiaMianNieRong{
    
    BOOL jiangjin=NO;
    if (([cainame isEqualToString:@"001"] || [cainame isEqualToString:@"113"]) && ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] isKindOfClass:[LastLotteryViewController class]] || isDangQianQi))
    {
        jiangjin=YES;
    }
    
    UILabel * benzhanLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 0, 0)];
    benzhanLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    benzhanLabel.backgroundColor = [UIColor clearColor];
    benzhanLabel.font = [UIFont boldSystemFontOfSize:13];
    benzhanLabel.textAlignment= NSTextAlignmentLeft;
    benzhanLabel.text = @"本站中奖";
    [bgViewController addSubview:benzhanLabel];
    [benzhanLabel release];
    
    
    UILabel * kuohaolabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 0, 0)];
    kuohaolabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    kuohaolabel.backgroundColor = [UIColor clearColor];
    kuohaolabel.font = [UIFont boldSystemFontOfSize:13];
    kuohaolabel.textAlignment = NSTextAlignmentLeft;
    kuohaolabel.text = @"（仅随机显示前5）";
    [bgViewController addSubview:kuohaolabel];
    [kuohaolabel release];
    
    NSInteger zhongc = 0;
    if ([zhongarray count] == 0) {
        zhongc = 1;
    }else{
        zhongc = [zhongarray count];//(15, 115 + zhongc*35+24+35+15, 55, 30)
    }
    
    NSLog(@"%@",self.cainame);
    
    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"302"]||[self.cainame isEqualToString:@"303"]) {
        benzhanLabel.frame = CGRectMake(20, 338+zhongc*25+24, 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
        
    }else{
        
        benzhanLabel.frame = CGRectMake(20, 115 + zhongc*25+24, 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
        
    }
    

    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]) {
        
        
        benzhanLabel.frame = CGRectMake(20, 380 + zhongc*35+24+(jiangjin?40:0), 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
    }else  if ([self.cainame isEqualToString:@"302"]){
        
        benzhanLabel.frame = CGRectMake(20, 280 + zhongc*35+24+(jiangjin?40:0), 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
    }else if([self.cainame isEqualToString:@"303"]){
       
        benzhanLabel.frame = CGRectMake(20, 320 + zhongc*35+24+(jiangjin?40:0), 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
    }else {
       

        benzhanLabel.frame = CGRectMake(15, 115 + zhongc*35+24+35+15+(jiangjin?40:0), 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);

    }
    if ([paihangarr count] == 0) {
        benzhanLabel.hidden = YES;
        kuohaolabel.hidden = YES;
    }
    
    if([self.cainame isEqualToString:@"119"]||[self.cainame isEqualToString:@"006"]||[self.cainame isEqualToString:@"011"]||[self.cainame isEqualToString:@"012"]||[self.cainame isEqualToString:@"122"] || [self.cainame isEqualToString:@"121"]||[self.cainame isEqualToString:@"013"]||[self.cainame isEqualToString:@"014"]||[self.cainame isEqualToString:@"019"]||[self.cainame isEqualToString:LOTTERY_ID_JILIN]||[self.cainame isEqualToString:LOTTERY_ID_JIANGXI_11]||[self.cainame isEqualToString:@"123"]||[self.cainame isEqualToString:LOTTERY_ID_SHANXI_11]||[self.cainame isEqualToString:LOTTERY_ID_ANHUI]){
    
        benzhanLabel.frame = CGRectMake(15, 155+(jiangjin?40:0), 55, 30);
        kuohaolabel.frame = CGRectMake(10+benzhanLabel.frame.size.width, benzhanLabel.frame.origin.y, 150, 30);
    }
    
    
    for (int i = 0; i < [paihangarr count]; i++) {
        
        UIImageView * benimage = [[UIImageView alloc] initWithFrame:CGRectMake( 13,benzhanLabel.frame.origin.y+benzhanLabel.frame.size.height+i*44,  294, 44)];
        benimage.backgroundColor = [UIColor whiteColor];
        benimage.userInteractionEnabled = YES;
        
        UIImageView * shuxianIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 44)];
        shuxianIma.backgroundColor=[UIColor colorWithRed:220/255.0 green:217/255.0 blue:210/255.0 alpha:1];
        [benimage addSubview:shuxianIma];
        [shuxianIma release];
        UIImageView * shuxianIma2 = [[UIImageView alloc] initWithFrame:CGRectMake(benimage.frame.size.width-0.5, 0, 0.5, 44)];
        shuxianIma2.backgroundColor=[UIColor colorWithRed:220/255.0 green:217/255.0 blue:210/255.0 alpha:1];
        [benimage addSubview:shuxianIma2];
        [shuxianIma2 release];
        
        UIButton * buttonben = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonben.frame = benimage.bounds;
        buttonben.tag = i;
        [buttonben addTarget:self action:@selector(pressbuttonben:) forControlEvents:UIControlEventTouchUpInside];
        [benimage addSubview:buttonben];
        
        UIButton * namebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        namebutton.tag = i;
        namebutton.frame = CGRectMake(8, 6, 120, 30);
        [namebutton addTarget:self action:@selector(pressNameButton:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * buttonbgimage = [[UIImageView alloc] initWithFrame:namebutton.bounds];
        buttonbgimage.backgroundColor = [UIColor clearColor];
//        buttonbgimage.image = [UIImageGetImageFromName(@"kjyhan.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        buttonbgimage.image = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [namebutton addSubview:buttonbgimage];
        [buttonbgimage release];
        
        UILabel * buttonlabel = [[UILabel alloc] initWithFrame:namebutton.bounds];
        buttonlabel.backgroundColor = [UIColor clearColor];
        buttonlabel.textAlignment = NSTextAlignmentCenter;
//        buttonlabel.textColor = [UIColor whiteColor];
        buttonlabel.textColor = [UIColor whiteColor];
        buttonlabel.font = [UIFont boldSystemFontOfSize:12];
        if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
            buttonlabel.text = [[paihangarr objectAtIndex:i] userNicheng];
        }else{
            buttonlabel.text = [[paihangarr objectAtIndex:i] objectForKey:@"nickname"];
        }
        [namebutton addSubview:buttonlabel];
        [buttonlabel release];

        [benimage addSubview:namebutton];
        
        
//        UILabel * qianlabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 118, 44)];
        UILabel * qianlabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 0, 118, 44)];
        qianlabel.textColor = [UIColor colorWithRed:251/255.0 green:47/255.0 blue:47/255.0 alpha:1];
        qianlabel.backgroundColor = [UIColor clearColor];
        qianlabel.textAlignment = NSTextAlignmentRight;
        qianlabel.font = [UIFont boldSystemFontOfSize:12];
        
        if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
            qianlabel.text = [[paihangarr objectAtIndex:i] getScore];
        }else{
            qianlabel.text = [NSString stringWithFormat:@"%@",[[paihangarr objectAtIndex:i] objectForKey:@"fee"] ];
        }
//        qianlabel.text = [self moneyFormat:qianlabel.text];
        [benimage addSubview:qianlabel];
        [qianlabel release];
        
//        UILabel * yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(248, 0, 10, 44)];
        UILabel * yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 10, 44)];
        yuanlabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
        yuanlabel.backgroundColor = [UIColor clearColor];
        yuanlabel.textAlignment = NSTextAlignmentRight;
        yuanlabel.font = [UIFont boldSystemFontOfSize:10];
        yuanlabel.text = @"元";
        if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
            yuanlabel.text = @"积分";
            yuanlabel.frame = CGRectMake(225, 0, 20, 44);
        }
        [benimage addSubview:yuanlabel];
        [yuanlabel release];
        
        NSString *privacy = @"";//保密类型
        if (![lotteryName isEqualToString:Lottery_Name_Horse]) {
            privacy = [NSString stringWithFormat:@"%@",[[paihangarr objectAtIndex:i] objectForKey:@"privacy"]];
        }
        //锁 箭头
        UIImageView * jiantouorsuo = [[UIImageView alloc] initWithFrame:CGRectMake(268, 15, 8, 13)];
        jiantouorsuo.backgroundColor = [UIColor clearColor];
        if ([privacy intValue] == 1) {
            jiantouorsuo.frame = CGRectMake(270, 14, 14, 15);
            jiantouorsuo.image = UIImageGetImageFromName(@"suo.png");
        }
        else if ([privacy intValue] == 4) {
            buttonben.tag = 2101;
            namebutton.tag = 2101;
            buttonlabel.textColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
            buttonbgimage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:3 topCapHeight:3];
//            jiantouorsuo.frame = CGRectMake(272, 15, 8, 13);
//            jiantouorsuo.image = UIImageGetImageFromName(@"jiantou.png");
            jiantouorsuo.frame = CGRectMake(270, 14, 14, 15);
            jiantouorsuo.image = UIImageGetImageFromName(@"suo.png");
        }
        else {
            jiantouorsuo.frame = CGRectMake(272, 15, 8, 13);
            jiantouorsuo.image = UIImageGetImageFromName(@"jiantou.png");
            
        }
        [benimage addSubview:jiantouorsuo];
        [jiantouorsuo release];
//        UIImageView * lineimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 42, 292, 2)];
        UIImageView * lineimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, 294, 0.5)];
        lineimage2.image = [UIImage imageNamed:@"SZTG960.png"];
        lineimage2.backgroundColor = [UIColor clearColor];
        [benimage addSubview:lineimage2];
        [lineimage2 release];
        UIImageView * lineimage22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5, 294, 0.5)];
        lineimage22.image = [UIImage imageNamed:@"SZTG960.png"];
        lineimage22.backgroundColor = [UIColor clearColor];
        [benimage addSubview:lineimage22];
        [lineimage22 release];
        
        
        if ([paihangarr count] == 1) {
//            lineimage2.image = nil;
//            lineimage22.image=nil;
//            xian.image=nil;
//            benimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
        }else{
            if (i == 0) {
//                benimage.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
            }else if(i == [paihangarr count]-1){
//                lineimage2.image = nil;
//                benimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            }else{
//                benimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            }
            benimage.backgroundColor=[UIColor whiteColor];
        }
        
        
        [bgViewController addSubview:benimage];
        [benimage release];
    }
    
    
    if ([self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"300"]) {
        passABarrierButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        passABarrierButton.frame = CGRectMake(225, 0, 85, 30);
        [passABarrierButton setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [passABarrierButton setTitle:@"总排行" forState:UIControlStateNormal];
        [passABarrierButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        passABarrierButton.titleLabel.font=[UIFont systemFontOfSize:15];
        passABarrierButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        [passABarrierButton addTarget:self action:@selector(pressPassABarrierButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgViewController addSubview:passABarrierButton];
    }
   
    
    
    
    
//    weibolabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 0, 0)];
//    weibolabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    weibolabel.backgroundColor = [UIColor clearColor];
//    weibolabel.font = [UIFont boldSystemFontOfSize:13];
//    weibolabel.text = @"微博热议";
//    [bgViewController addSubview:weibolabel];
//    
//    //微博热议的图片
//    UIButton * reyibutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    reyibutton.frame = CGRectMake(13, 350, 294, 43);
//   // [reyibutton  setImage:UIImageGetImageFromName(@"TCKJXQXDAN960.png") forState:UIControlStateNormal];
//    [reyibutton addTarget:self action:@selector(pressHuatiButton:) forControlEvents:UIControlEventTouchUpInside];
//    [bgViewController addSubview:reyibutton];
//    
//    UIImageView * reyibg = [[UIImageView alloc] initWithFrame:reyibutton.bounds];
////    reyibg.backgroundColor = [UIColor clearColor];
//    reyibg.backgroundColor = [UIColor whiteColor];
//    reyibg.layer.masksToBounds=YES;
//    reyibg.layer.cornerRadius=3.0;
////    reyibg.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
//    reyibg.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [reyibutton addSubview:reyibg];
//    [reyibg release];
//    
//    UILabel * reyilabel = [[UILabel alloc] initWithFrame:reyibutton.bounds];
//    reyilabel.backgroundColor = [UIColor clearColor];
//    reyilabel.textAlignment = NSTextAlignmentCenter;
////    reyilabel.textColor = [UIColor whiteColor];
//    reyilabel.textColor = [UIColor colorWithRed:29/255.0 green:163/255.0 blue:255/255.0 alpha:1];
////    reyilabel.font = [UIFont boldSystemFontOfSize:12];
//    reyilabel.font = [UIFont boldSystemFontOfSize:16];
//    reyilabel.text = huatistring;
//    [reyibutton addSubview:reyilabel];
//    [reyilabel release];
//
//    
//    
//    
////
////    
////    if ([reyiArray count] == 0 || reyiArray == nil) {
////        UILabel * shuomingl = [[UILabel alloc] initWithFrame:CGRectMake(0, 390, 320, 30)];
////        shuomingl.text = @"参与微博讨论让大家认识一下";
////        shuomingl.textAlignment = NSTextAlignmentCenter;
////        shuomingl.textColor = [UIColor whiteColor];
////        shuomingl.backgroundColor = [UIColor clearColor];
////        shuomingl.font = [UIFont systemFontOfSize:14];
////        [bgViewController addSubview:shuomingl];
////        [shuomingl release];
////    }else{
////
    float widthfloat = 0;
//    for (int i = 0; i < [reyiArray count]; i++) {
//        if (i < 5) {
//            NSDictionary * diction = [reyiArray objectAtIndex:i];
//            NSString * ss33 = [diction objectForKey:@"content"];
//            UIFont * font33 = [UIFont systemFontOfSize:14];
//            CGSize  size33 = CGSizeMake(274, 1000);
//            ss33 = [ss33 flattenPartHTML:ss33];
////            ss33 = [ss33 stringByReplacingOccurrencesOfString:huatistring withString:@""];
////             ss33 = [NSString stringWithFormat:@"%@:%@", [diction objectForKey:@"nick_name"], ss33];
//            CGSize labelSize33 = [ss33 sizeWithFont:font33 constrainedToSize:size33 lineBreakMode:UILineBreakModeWordWrap];
//            if (labelSize33.height < 44) {
//                widthfloat += 44+3;
//            }else{
//                widthfloat += labelSize33.height+5;
//            }
//            
//        }
//    }
    
        
            
//            headimag = [[UIImageView alloc] initWithFrame:CGRectMake(8, 389, 304, reyiTabelView.frame.size.height+10)];
//            headimag.backgroundColor = [UIColor clearColor];
//            headimag.image = [UIImageGetImageFromName(@"red_texBg_t.png") stretchableImageWithLeftCapWidth:60 topCapHeight:70];
          //  [bgViewController addSubview:headimag];
    
//    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"303"]||[self.cainame isEqualToString:@"302"]) {
//         reyiTabelView = [[UITableView alloc] initWithFrame:CGRectMake(13, 333+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat)];
//       
//    }else{
//         reyiTabelView = [[UITableView alloc] initWithFrame:CGRectMake(13, 125+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat)];
//       
//    }

//       //reyiTabelView = [[UITableView alloc] initWithFrame:CGRectMake(20, 400, 280, widthfloat+20)];
//        [reyiTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//       // reyiTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        reyiTabelView.delegate = self;
//        reyiTabelView.dataSource = self;
//        reyiTabelView.tag = 2;
//        reyiTabelView.userInteractionEnabled = YES;
//    reyiTabelView.scrollEnabled = NO;
//        reyiTabelView.backgroundColor = [UIColor clearColor];
//        [bgViewController addSubview:reyiTabelView];
//
//    }
    
    
    
#ifdef isCaiPiaoForIPad
    if ([lotteryName isEqualToString:@"胜负任九"]) {
        
        
        bgViewController.frame = CGRectMake(0+35, 0, 320, 338+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat);
        passABarrierButton.frame = CGRectMake(225, 338+zhongc*25+24+30+[paihangarr count]*44+20, 85, 30);
        weibolabel.frame = CGRectMake(20, 338+zhongc*25+24+30+[paihangarr count]*44+60, 100, 30);
        reyibutton.frame = CGRectMake(13, 338+zhongc*25+24+30+[paihangarr count]*44+30+60, 294, 43);
        reyiTabelView.frame = CGRectMake(13, 348+zhongc*25+24+30+[paihangarr count]*44+44+30+60, 294, widthfloat);
    }else  if ([lotteryName isEqualToString:@"半全场"]){
        
        bgViewController.frame = CGRectMake(0+35, 0, 320, 280+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat);
        weibolabel.frame = CGRectMake(20, 280+zhongc*25+24+30+[paihangarr count]*44, 100, 30);
        reyibutton.frame = CGRectMake(13, 280+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
        reyiTabelView.frame = CGRectMake(13, 290+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }else if([lotteryName isEqualToString:@"进球彩"]){
        
        bgViewController.frame = CGRectMake(0+35, 0, 320, 301+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat);
        weibolabel.frame = CGRectMake(20, 301+zhongc*25+24+30+[paihangarr count]*44, 100, 30);
        reyibutton.frame = CGRectMake(13, 301+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
        reyiTabelView.frame = CGRectMake(13, 311+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }else {
        
        bgViewController.frame = CGRectMake(0+35, 0, 320, 115+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat);
        weibolabel.frame = CGRectMake(20, 115+zhongc*25+24+30+[paihangarr count]*44, 100, 30);
        reyibutton.frame = CGRectMake(13, 115+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
        reyiTabelView.frame = CGRectMake(13, 125+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }
    
    if([lotteryName isEqualToString:@"时时彩"]||[lotteryName isEqualToString:@"快乐十分"]||[lotteryName isEqualToString:@"内蒙古快3"]||[lotteryName isEqualToString:@"快乐扑克"]){
        
        
        myTabelView.hidden = YES;
        
        bgViewController.frame = CGRectMake(0+35, 0, 320, 115+[paihangarr count]*44+44+30+43+widthfloat);
        
        if ([paihangarr count] == 0) {
            weibolabel.frame = CGRectMake(20, 115+[paihangarr count]*44, 100, 30);
            reyibutton.frame = CGRectMake(13, 115+[paihangarr count]*44+30, 294, 43);
            reyiTabelView.frame = CGRectMake(13, 125+[paihangarr count]*44+44+30, 294, widthfloat);
        }else{
            weibolabel.frame = CGRectMake(20, 115+[paihangarr count]*44+30, 100, 30);
            reyibutton.frame = CGRectMake(13, 115+[paihangarr count]*44+30+30, 294, 43);
            reyiTabelView.frame = CGRectMake(13, 125+[paihangarr count]*44+44+30+30, 294, widthfloat);
        }
        
        
    }else{
        myTabelView.hidden = NO;
    }
#else
    
   
    
    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]) {
       
        


        bgViewController.frame = CGRectMake(0, 0, 320, 380+zhongc*35+24+30+[paihangarr count]*44+44+30+43+widthfloat+(jiangjin?40:0)+60);
        if ([paihangarr count] == 0) {
            passABarrierButton.frame = CGRectMake(225, 338+zhongc*35+24+30+[paihangarr count]*44+12, 85, 30);
        }else{
            passABarrierButton.frame = CGRectMake(225, 338+zhongc*35+24+30+[paihangarr count]*44+20+35, 85, 30);
        }
        
        weibolabel.frame = CGRectMake(20, 380+zhongc*35+24+30+[paihangarr count]*44+(jiangjin?40:0)+60, 100, 30);
        
//        reyibutton.frame = CGRectMake(13, 338+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
//        reyibutton.frame = CGRectMake(13, 380+zhongc*35+24+30+[paihangarr count]*44+30+(jiangjin?40:0)+60, 294, 43);
        
        reyiTabelView.frame = CGRectMake(13, 348+zhongc*25+24+30+[paihangarr count]*44+44+30+60, 294, widthfloat);
    }else  if ([self.cainame isEqualToString:@"302"]){
        
        bgViewController.frame = CGRectMake(0, 0, 320, 280+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat+(jiangjin?40:0));

        weibolabel.frame = CGRectMake(20, 280+zhongc*35+24+30+[paihangarr count]*44+(jiangjin?40:0), 100, 30);
        
//        reyibutton.frame = CGRectMake(13, 280+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
//        reyiTabelView.frame = CGRectMake(13, 290+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
//        reyibutton.frame = CGRectMake(13, 280+zhongc*35+24+30+[paihangarr count]*44+30+(jiangjin?40:0), 294, 43);
//        reyiTabelView.frame = CGRectMake(13, 290+zhongc*35+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }else if([self.cainame isEqualToString:@"303"]){
        
        bgViewController.frame = CGRectMake(0, 0, 320, 301+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat+(jiangjin?40:0));

        weibolabel.frame = CGRectMake(20, 320+zhongc*35+24+30+[paihangarr count]*44+(jiangjin?40:0), 100, 30);
        
//        reyibutton.frame = CGRectMake(13, 301+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
//        reyiTabelView.frame = CGRectMake(13, 311+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
//        reyibutton.frame = CGRectMake(13, 320+zhongc*35+24+30+[paihangarr count]*44+30+(jiangjin?40:0), 294, 43);
//        reyiTabelView.frame = CGRectMake(13, 311+zhongc*35+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }else {
        
//        bgViewController.frame = CGRectMake(0, 0, 320, 115+zhongc*25+24+30+[paihangarr count]*44+44+30+43+widthfloat);
        bgViewController.frame = CGRectMake(0, 0, 320, 115+zhongc*35+24+30+[paihangarr count]*44+44+30+43+widthfloat+35+(jiangjin?40:0));
        

        weibolabel.frame = CGRectMake(15, 115+zhongc*35+24+30+[paihangarr count]*44+35+15+(jiangjin?40:0), 100, 30);
        
//        reyibutton.frame = CGRectMake(13, 115+zhongc*25+24+30+[paihangarr count]*44+30, 294, 43);
//        reyibutton.frame = CGRectMake(13, 115+zhongc*35+24+30+[paihangarr count]*44+30+35+([chistring length]>0?15:0), 294, 43);
//        reyibutton.frame = CGRectMake(13, 115+zhongc*35+24+30+[paihangarr count]*44+30+35+15+(jiangjin?40:0), 294, 43);
        
        reyiTabelView.frame = CGRectMake(13, 125+zhongc*25+24+30+[paihangarr count]*44+44+30, 294, widthfloat);
    }
    
    
    
    if([self.cainame isEqualToString:@"119"]||[self.cainame isEqualToString:@"006"]||[self.cainame isEqualToString:@"011"]||[self.cainame isEqualToString:@"012"]||[self.cainame isEqualToString:@"122"] || [self.cainame isEqualToString:@"121"]||[self.cainame isEqualToString:@"013"]||[self.cainame isEqualToString:@"014"]||[self.cainame isEqualToString:@"019"]||[self.cainame isEqualToString:LOTTERY_ID_JILIN]||[self.cainame isEqualToString:LOTTERY_ID_JIANGXI_11]||[self.cainame isEqualToString:@"123"]||[self.cainame isEqualToString:LOTTERY_ID_SHANXI_11]||[self.cainame isEqualToString:LOTTERY_ID_ANHUI]){
    
        
        myTabelView.hidden = YES;
        
//        bgViewController.frame = CGRectMake(0, 0, 320, 115+[paihangarr count]*44+44+30+43+widthfloat);
        bgViewController.frame = CGRectMake(0, 0, 320, 115+[paihangarr count]*44+44+30+43+widthfloat+40+(jiangjin?40:0));
        
        if ([paihangarr count] == 0) {

            weibolabel.frame = CGRectMake(20, 115+[paihangarr count]*44+40+(jiangjin?40:0), 100, 30);
//            reyibutton.frame = CGRectMake(13, 115+[paihangarr count]*44+30+40+(jiangjin?40:0), 294, 43);
            reyiTabelView.frame = CGRectMake(13, 125+[paihangarr count]*44+44+30, 294, widthfloat);
        }else{

            weibolabel.frame = CGRectMake(20, 115+[paihangarr count]*44+30+40+(jiangjin?40:0), 100, 30);
//            reyibutton.frame = CGRectMake(13, 115+[paihangarr count]*44+30+30+40+(jiangjin?40:0), 294, 43);
//            reyiTabelView.frame = CGRectMake(13, 125+[paihangarr count]*44+44+30+30, 294, widthfloat);
        }
        
       
    }else{
        myTabelView.hidden = NO;
    }
    UIImageView * lineimage222 = [[UIImageView alloc] initWithFrame:CGRectMake(-20, -0.5, 400, 0.5)];
    lineimage222.image = [UIImage imageNamed:@"SZTG960.png"];
    lineimage222.backgroundColor = [UIColor clearColor];
//    [weibolabel addSubview:lineimage222];
    [lineimage222 release];
    
    
#endif
    
    

    qiuscrollView.contentSize = CGSizeMake(qiuscrollView.frame.size.width, bgViewController.frame.size.height);
    
}

#pragma mark 登陆
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

#pragma mark 奖金计算
- (void)goJiangjinJiSuandown:(UIButton *)sender {
    
    jiangjinIma.image = UIImageGetImageFromName(@"jiangjinjisuan_down.png");
    jiangjinLab.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:0.4];

}
- (void)goJiangjinJiSuancancel:(UIButton *)sender {
    jiangjinIma.image = UIImageGetImageFromName(@"jiangjinjisuan.png");
    jiangjinLab.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];

}
- (void)goJiangjinJiSuan:(UIButton *)sender {

    jiangJinJiSuanButton.userInteractionEnabled = NO;
    
    moneyViewController *info = [[[moneyViewController alloc] init] autorelease];
    if ([zhongarray count] == 0) {
        if ([cainame isEqualToString:@"001"]) {
            info.isShuangSeQiuKaichu = NO;
        }
        else if ([cainame isEqualToString:@"113"]){
            info.isDaleTouKaiChu = NO;
        }
    }
    info.lottoryID = cainame;
    [self performSelector:@selector(delayPush:) withObject:info afterDelay:0.1];
}

-(void)delayPush:(id)controller
{
    jiangjinLab.textColor= [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    jiangjinIma.image = UIImageGetImageFromName(@"jiangjinjisuan.png");
    [self performSelector:@selector(delayPush1:) withObject:controller afterDelay:0.01];
}

-(void)delayPush1:(id)controller
{
    [self.navigationController pushViewController:controller animated:YES];
    jiangJinJiSuanButton.userInteractionEnabled = YES;
}


#pragma mark 话题按钮触发
- (void)pressHuatiButton:(UIButton *)sender{
    Info *info2 = [Info getInstance];
    if (![info2.userId intValue]) {;
        [self doLogin];
        return;
    }

    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:huatistring];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
}

#pragma mark 最上面的一块
//- (NSArray *)getShaiZiViewBy:(NSArray *)numArray{
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    image1.backgroundColor = [UIColor clearColor];
//    image2.backgroundColor = [UIColor clearColor];
//    image3.backgroundColor = [UIColor clearColor];
//    NSString * str1 = [NSString stringWithFormat:@"shaizi%d.png",[[numArray objectAtIndex:0] intValue]];
//    NSString * str2 = [NSString stringWithFormat:@"shaizi%d.png",[[numArray objectAtIndex:1] intValue]];
//    NSString * str3 = [NSString stringWithFormat:@"shaizi%d.png",[[numArray objectAtIndex:2] intValue]];
//    image1.image = UIImageGetImageFromName(str1);
//    image2.image = UIImageGetImageFromName(str2);
//    image3.image = UIImageGetImageFromName(str3);
//    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,nil];
//    [image1 release];
//    [image2 release];
//    [image3 release];
//    return retunArray;
//    
//}
- (NSArray *)getPukeViewBy:(NSArray *)numArray {//
    if ([numArray count] < 3) {
        NSArray *retunArray = [NSArray arrayWithObjects:nil];
        return retunArray;
    }
    NSArray *name = [NSArray arrayWithObjects:@"",@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
    NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
    NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
    int a,b,c,a1,b1,c1;
    a = (int)[[array1 objectAtIndex:0] integerValue];
    b = (int)[[array2 objectAtIndex:0] integerValue];
    c = (int)[[array3 objectAtIndex:0] integerValue];
    a1 = (int)[[array1 objectAtIndex:1] integerValue];
    b1 = (int)[[array2 objectAtIndex:1] integerValue];
    c1 = (int)[[array3 objectAtIndex:1] integerValue];
    NSString *leixing = @"";
    int smal = 100,mid = 0,big = 0;
    if (smal > a) {
        smal = a;
    }
    if (smal > b) {
        smal = b;
    }
    if (smal > c) {
        smal = c;
    }
    if (big < a) {
        big = a;
    }
    if (big < b) {
        big = b;
    }
    if (big < c) {
        big = c;
    }
    mid = a + b + c - smal - big;
    if (a == b && b == c) {
        leixing = @"豹子";
    }
    else if (a == b || b == c || a == c) {
        leixing = @"对子";
    }
    else if (a1 == b1 && b1 == c1) {
        leixing = @"同花";
        if (smal + 1 == mid && mid + 1 ==big) {
            leixing = @"同花顺";
        }
    }
    else if (smal + 1 == mid && mid + 1 ==big) {
        leixing = @"顺子";
    }
    NSString *pic1 = [NSString stringWithFormat:@"puke_%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke_%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke_%d.png",c1];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UILabel *lab1 = [[UILabel alloc] init];
//    lab1.frame = CGRectMake(1, 1, 9, 9);
//    lab1.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab1.frame = CGRectMake(5, 4, 16, 16);
    lab1.font = [UIFont fontWithName:@"TRENDS" size:16];
    lab1.backgroundColor = [UIColor clearColor];
    lab1.tag = 101;
    lab1.text = [name objectAtIndex:a];
    lab1.autoresizingMask = 111111;
    [image1 addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
//    lab2.frame = CGRectMake(1, 1, 9, 9);
//    lab2.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab2.frame = CGRectMake(5, 4, 16, 16);
    lab2.font = [UIFont fontWithName:@"TRENDS" size:16];
    lab2.backgroundColor = [UIColor clearColor];
    lab2.tag = 101;
    lab2.text = [name objectAtIndex:b];
    lab2.autoresizingMask = 111111;
    [image2 addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] init];
//    lab3.frame = CGRectMake(1, 1, 9, 9);
//    lab3.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab3.frame = CGRectMake(5, 4, 16, 16);
    lab3.font = [UIFont fontWithName:@"TRENDS" size:16];
    lab3.backgroundColor = [UIColor clearColor];
    lab3.tag = 101;
    lab3.text = [name objectAtIndex:c];
    lab3.autoresizingMask = 111111;
    [image3 addSubview:lab3];
    [lab3 release];
    
    image1.image = UIImageGetImageFromName(pic1);
    image2.image = UIImageGetImageFromName(pic2);
    image3.image = UIImageGetImageFromName(pic3);
    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,leixing,nil];
    [image1 release];
    [image2 release];
    [image3 release];
    return retunArray;
    
}
- (void)shangMianNieRong{
    //ui
//    NSDictionary *dic = [self.lotteries objectAtIndex:sectionnum];
//    NSArray *arr = [dic objectForKey:@"list"];
//    LastLottery *lottery = [arr objectAtIndex:rownum];
    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"302"]||[self.cainame isEqualToString:@"303"]) {
         bgViewController = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    }else{
        bgViewController = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
    }
    bgViewController.backgroundColor=[UIColor clearColor];
    
    UIView *kaijiangView=[[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 65)];
    kaijiangView.backgroundColor=[UIColor whiteColor];
    [bgViewController addSubview:kaijiangView];
    [kaijiangView release];
    UIImageView *l1=[[UIImageView alloc]init];
    l1.frame=CGRectMake(0, 0, 320, 0.5);
    l1.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [kaijiangView addSubview:l1];
    [l1 release];
    UIImageView *l2=[[UIImageView alloc]init];
    l2.frame=CGRectMake(0, kaijiangView.frame.size.height-0.5, 320, 0.5);
    l2.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [kaijiangView addSubview:l2];
    [l2 release];
    
    UILabel * haomalabel = [[UILabel alloc] init];
    haomalabel.backgroundColor = [UIColor clearColor];
    haomalabel.textAlignment = NSTextAlignmentLeft;
    haomalabel.font = [UIFont boldSystemFontOfSize:18];
    haomalabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    haomalabel.text = [NSString stringWithFormat:@"%@开奖号码", lotteryName];
    haomalabel.text = [NSString stringWithFormat:@"%@", lotteryName];
    [bgViewController addSubview:haomalabel];
    
    CGSize haomalabelSize = [haomalabel.text sizeWithFont:haomalabel.font constrainedToSize:CGSizeMake(300, 30) lineBreakMode:NSLineBreakByWordWrapping];
//    haomalabel.frame = CGRectMake(15, 2, haomalabelSize.width, 30);
    haomalabel.frame = CGRectMake(10, 10, haomalabelSize.width, 30);
    [haomalabel release];
    
    //胜负任九。
#ifndef isHaoLeCai
    NSLog(@"%@",self.cainame);
//    if (![self.cainame isEqualToString:@"302"] && ![self.cainame isEqualToString:@"303"]) {
//        shareButton = [[UIButton alloc] initWithFrame:CGRectMake(haomalabelSize.width+10, haomalabel.frame.origin.y + 1, 52, haomalabel.frame.size.height - 1)];
//        [shareButton setTitle:@"  分享" forState:UIControlStateNormal];
//        [shareButton setTitleColor:[UIColor colorWithRed:29/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
//        shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [bgViewController addSubview:shareButton];
//        [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//        [shareButton addTarget:self action:@selector(sharedown) forControlEvents:UIControlEventTouchDown];
//        [shareButton addTarget:self action:@selector(sharecancel) forControlEvents:UIControlEventTouchCancel];
//
//        shareImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(1, 8, 12, 12)] autorelease];
//        shareImageView.image = UIImageGetImageFromName(@"fenxiang.png");
//        [shareButton addSubview:shareImageView];
//    }
#endif
    
     if ([self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"302"]||[self.cainame isEqualToString:@"303"]) {
         
         UILabel *haoma=[[UILabel alloc]initWithFrame:CGRectMake(haomalabel.frame.size.width+17, 10, 80, 30)];
         haoma.text=@"开奖号码";
         haoma.font = [UIFont boldSystemFontOfSize:14];
         haoma.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//         [bgViewController addSubview:haoma];
         [haoma release];
        
         if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]){
             kaijiangView.frame=CGRectMake(0, 0, 320, 190);
             l1.backgroundColor=[UIColor clearColor];
             l2.backgroundColor=[UIColor clearColor];
             
//             UIImageView * kuangimage = [[UIImageView alloc] initWithFrame:CGRectMake(167, 8, 145, 20)];
             UIImageView * kuangimage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 8, 145, 20)];
             kuangimage.backgroundColor = [UIColor clearColor];
//             kuangimage.image = [UIImageGetImageFromName(@"GMCPSZBG960.png") stretchableImageWithLeftCapWidth:14 topCapHeight:10];
             
//             UIImageView * redimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 10, 10)];
             UIImageView * redimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 15, 15)];
             redimage.backgroundColor = [UIColor colorWithRed:251/255.0 green:47/255.0 blue:47/255.0 alpha:1];
             [kuangimage addSubview:redimage];
             [redimage release];
             
//             UILabel * shouLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 4, 20, 12)];
             UILabel * shouLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 20, 15)];
             shouLabel.backgroundColor = [UIColor clearColor];
             shouLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             shouLabel.textAlignment = NSTextAlignmentLeft;
//             shouLabel.font = [UIFont systemFontOfSize:12];
             shouLabel.font = [UIFont systemFontOfSize:15];
             shouLabel.text = @"首";
             [kuangimage addSubview:shouLabel];
             [shouLabel release];
             
//             UIImageView * yeimage = [[UIImageView alloc] initWithFrame:CGRectMake(63, 5, 10, 10)];
             UIImageView * yeimage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 10, 15, 15)];
             yeimage.backgroundColor = [UIColor colorWithRed:1 green:198/255.0 blue:0 alpha:1];
             [kuangimage addSubview:yeimage];
             [yeimage release];
             
//             UILabel * ciLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 4, 20, 12)];
             UILabel * ciLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 20, 15)];
             ciLabel.backgroundColor = [UIColor clearColor];
             ciLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             ciLabel.textAlignment = NSTextAlignmentLeft;
//             ciLabel.font = [UIFont systemFontOfSize:12];
             ciLabel.font = [UIFont systemFontOfSize:15];
             ciLabel.text = @"次";
             [kuangimage addSubview:ciLabel];
             [ciLabel release];
             
//             UIImageView * blueimage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 5, 10, 10)];
             UIImageView * blueimage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 15, 15)];
             blueimage.backgroundColor = [UIColor colorWithRed:30/255.0 green:165/255.0 blue:255/255.0 alpha:1];
             [kuangimage addSubview:blueimage];
             [blueimage release];
             
//             UILabel * moLabel = [[UILabel alloc] initWithFrame:CGRectMake(117, 4, 20, 12)];
             UILabel * moLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 20, 15)];
             moLabel.backgroundColor = [UIColor clearColor];
             moLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             moLabel.textAlignment = NSTextAlignmentLeft;
//             moLabel.font = [UIFont systemFontOfSize:12];
             moLabel.font = [UIFont systemFontOfSize:15];
             moLabel.text = @"末";
             [kuangimage addSubview:moLabel];
             [moLabel release];
             
             [bgViewController addSubview:kuangimage];
             [kuangimage release];
         }
         
         
//         UIImageView * shangimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 37, 294, 65)];
         UIImageView * shangimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 50, 294, 65)];
         shangimageview.backgroundColor = [UIColor clearColor];
//         shangimageview.image = [UIImageGetImageFromName(@"TCKJXQL960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:7];
         shangimageview.backgroundColor=[UIColor colorWithRed:50/255.0 green:126/255.0 blue:184/255.0 alpha:1];
         
//         UIImageView * xiaimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 102, 294, 61)];
         UIImageView * xiaimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 115, 294, 61)];
         xiaimageview.backgroundColor = [UIColor clearColor];
//         xiaimageview.image = [UIImageGetImageFromName(@"TCKJXQH960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:2];
         xiaimageview.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
         
         if ([self.cainame isEqualToString:@"302"]) {
             kaijiangView.frame=CGRectMake(0, 0, 320, 210);
             l1.backgroundColor=[UIColor clearColor];
             l2.backgroundColor=[UIColor clearColor];
             
//             shangimageview.frame = CGRectMake(13, 37, 294, 67);  //= [[UIImageView alloc] initWithFrame:CGRectMake(13, 37, 294, 65)];
             shangimageview.frame = CGRectMake(13, 50, 294, 67);
             
             xiaimageview.frame = CGRectMake(13, 125, 294, 61);
             for (int i = 0; i < 14; i++) {
//                 UIImageView * banquanimage = [[UIImageView alloc] initWithFrame:CGRectMake(13+i*21, 104, 21, 23)];
                 UIImageView * banquanimage = [[UIImageView alloc] initWithFrame:CGRectMake(13+i*21, 117, 21, 23)];
                 banquanimage.backgroundColor =[UIColor clearColor];
//                 banquanimage.image = UIImageGetImageFromName(@"LCQBCF960.png");
                 banquanimage.backgroundColor=[UIColor colorWithRed:39/255.0 green:110/255.0 blue:164/255.0 alpha:1];
                 UILabel * labelban = [[UILabel alloc] initWithFrame:banquanimage.bounds];
                 labelban.textAlignment = NSTextAlignmentCenter;
                 labelban.textColor = [UIColor whiteColor];
                 labelban.textColor=[UIColor colorWithRed:70/255.0 green:165/255.0 blue:237/255.0 alpha:1];
                 labelban.font = [UIFont boldSystemFontOfSize:12];
                 labelban.backgroundColor = [UIColor clearColor];
                 if (i%2 == 0) {
                    labelban.text = @"半";
                 }else{
                     labelban.text = @"全";
                 }
                 if (i > 11) {
                     labelban.text = @"";
                 }
                 [banquanimage addSubview:labelban];
                 [labelban release];
                 [bgViewController addSubview:banquanimage];
                 [banquanimage release];
                 if (i != 0 && i != 14) {
                     UIImageView * linexian = [[UIImageView alloc] initWithFrame:CGRectMake(13+i*21, 107, 1, 65)];
                     linexian.image = [UIImageGetImageFromName(@"TCKJXQFGX.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:2];
                     linexian.backgroundColor = [UIColor clearColor];
                     [bgViewController addSubview:linexian];
                     [linexian release];
                 }
                 
                 
                 
             }
         }
         
         
         NSString * code_des;
         NSArray * code_desarr;
         if ([[matchdict objectForKey:@"code_des"] length]>0 || [matchdict objectForKey:@"code_des"] == nil) {
             code_des = [[matchdict objectForKey:@"code_des"] substringToIndex:[[matchdict objectForKey:@"code_des"] length]-1];
             code_desarr = [code_des componentsSeparatedByString:@","];
         }
        
         
//         NSArray * code_desarr = [NSArray arrayWithObjects:@"sssss", @"胜负擦才",@"cvea声波vfd",@"胜负擦才",@"cvea声波vfd", @"sssss", @"胜负擦才",@"cvea声波vfd",@"胜负擦才",@"cvea声波vfd",@"sssss", @"胜负擦才",@"cvea声波vfd",@"胜负擦才",nil];
         
         
         int huanshu = 0;
         if ([self.cainame isEqualToString:@"301"]||[self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"303"]) {
             huanshu = 14;
         }else if([self.cainame isEqualToString:@"302"]){
             huanshu = 8;
         }
         NSInteger cheng2 = 0;
         for (int i = 0; i < huanshu; i++) {
             NSString * str = @"";
            
                 str = @"   一";
                 if ([[matchdict objectForKey:@"code_des"] length]>0 || [matchdict objectForKey:@"code_des"] == nil) {
                     if (i < [code_desarr count]) {
                         str = [code_desarr objectAtIndex:i];
                     }
                     
                 }
             if([self.cainame isEqualToString:@"302"]){
                 if (i > 5) {
                    str = @"   一";
                 }else{
                     str = [code_desarr objectAtIndex:cheng2];
                 }
             }
             cheng2 += 2;
             if([self.cainame isEqualToString:@"303"]){
                 kaijiangView.frame=CGRectMake(0, 0, 320, 230);
                 l1.backgroundColor=[UIColor clearColor];
                 l2.backgroundColor=[UIColor clearColor];
                 
                 if(i == 3 || i == 2 || i == 6 || i == 7){
                     UIImageView * animage = [[UIImageView alloc] initWithFrame:CGRectMake(i*21, 0, 21, 65)];
//                     animage.image = [UIImageGetImageFromName(@"banquandui.png") stretchableImageWithLeftCapWidth:5 topCapHeight:7];
                     animage.backgroundColor = [UIColor clearColor];
                     [shangimageview addSubview:animage];
                     [animage release];
                 }
                 
             }
             
             if ([str length]>4) {
                 str = [str substringToIndex:4];
             }
             UIFont * font = [UIFont boldSystemFontOfSize:12];
             CGSize  size = CGSizeMake(12, 60);
             CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
             UILabel * issLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+(i*21), 3, 12, labelSize.height)];
             
             if([self.cainame isEqualToString:@"302"]){
                 issLabel.frame = CGRectMake(15+i*42, 3, 12, labelSize.height);
                 if (i > 5) {
                     issLabel.frame = CGRectMake(5+6*42+((i-6)*21), 3, 12, labelSize.height);
                 }
             }
             
             issLabel.backgroundColor = [UIColor clearColor];
             issLabel.font = font;
             issLabel.text = str;
             issLabel.numberOfLines = 0;
             issLabel.textAlignment = NSTextAlignmentCenter;
             issLabel.textColor = [UIColor whiteColor];
             [shangimageview addSubview:issLabel];
             [issLabel release];
             
             
             
             if (i != 0 && i != 14) {
                 UIImageView * lineimageview = [[UIImageView alloc] initWithFrame:CGRectMake(i*21, 0, 1, 65)];
                 if([self.cainame isEqualToString:@"302"]){
                     if (i< 7) {
                         lineimageview.frame = CGRectMake(i*42, 0, 1, 67);
                     }
                     if (i == 7) {
                         lineimageview.frame = CGRectMake((i-1)*42+21, 0, 1, 67);
                     }
                    
                     
                 }
             if(!([self.cainame isEqualToString:@"302"]&&i>7)){
                 lineimageview.image = [UIImageGetImageFromName(@"TCKJXQFGX.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:2];
                 lineimageview.backgroundColor = [UIColor clearColor];
                 [shangimageview addSubview:lineimageview];
                 [lineimageview release];

             }
             }
            
             
         }
         NSInteger tagcount = 1;
         
         NSInteger waicount = 0;
         if ([self.cainame isEqualToString:@"303"]) {
             waicount = 5;
//             xiaimageview.frame =CGRectMake(13, 102, 294, 101);
             xiaimageview.frame =CGRectMake(13, 115, 294, 101);
         }else  if ([self.cainame isEqualToString:@"302"]) {
             waicount = 3;
//             xiaimageview.frame =CGRectMake(13, 125, 294, 61);
             xiaimageview.frame =CGRectMake(13, 138, 294, 61);
         }else if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]) {
             waicount = 3;
//             xiaimageview.frame =CGRectMake(13, 102, 294, 61);
             xiaimageview.frame =CGRectMake(13, 115, 294, 61);
         }
         
         for (int i = 0; i < waicount; i++) {
             for (int j = 0; j < 14; j++) {
//                 UIImageView * labelbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(j*21 + 1, 1+i*19, 19, 19)];
                 UIImageView * labelbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(j*21+0.5, 0.5+i*20, 20.5, 19.5)];
//                 if (j == 0) {
//                     labelbgimage.frame = CGRectMake(1, 1+i*19, 19, 19);
//                 }
                 if (j == 13)
                 {
                     labelbgimage.frame = CGRectMake(j*21+0.5, 0.5+i*20, 20, 19.5);
                 }
//                 labelbgimage.image = UIImageGetImageFromName(@"TCKJXQFKB960.png");
                 labelbgimage.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
                 labelbgimage.tag = tagcount;
                 [xiaimageview addSubview:labelbgimage];
                 [labelbgimage release];
                 
                 
                 
                 
                 UILabel * imagelabel = [[UILabel alloc] initWithFrame:labelbgimage.bounds];
                 imagelabel.backgroundColor = [UIColor clearColor];
                 imagelabel.textColor = [UIColor colorWithRed:184/255.0 green:196/255.0 blue:205/255.0 alpha:1];
                 imagelabel.font = [UIFont systemFontOfSize:12];
                 imagelabel.textAlignment = NSTextAlignmentCenter;
//                 imagelabel.text = @"一";
                 imagelabel.tag = tagcount*100;
                 [labelbgimage addSubview:imagelabel];
                 [imagelabel release];
                 tagcount += 1;
             }
         }
         
         [bgViewController addSubview:shangimageview];
         [shangimageview release];
         [bgViewController addSubview:xiaimageview];
         [xiaimageview release];
         NSString * caiguo ;
         NSString * zcm ;
          NSArray * caiguoarr = nil;
         NSArray * zcmarr = nil;
         if ([lotteryNumber length]>0 ) {
//             if ([lotteryName isEqualToString:@"胜负任九"]) {
//                 caiguo = [[matchdict objectForKey:@"caiguo"] substringToIndex:[[matchdict objectForKey:@"caiguo"] length]-1];
//             }
             caiguo = lotteryNumber;
             caiguoarr = [caiguo componentsSeparatedByString:@","];
         }
         if ([[matchdict objectForKey:@"zcm"] length]>0||[matchdict objectForKey:@"zcm"] == nil) {
             zcm  = [[matchdict objectForKey:@"zcm"] substringToIndex:[[matchdict objectForKey:@"zcm"] length]-1];
             zcmarr = [zcm componentsSeparatedByString:@","];
         }
        
        
        
        
         if ([lotteryNumber length]>0) {
             for (int i = 0; i < [caiguoarr count]; i++) {
                 UIImageView * iamgebgi;
                 UILabel * labeli;
                 if ([lotteryNumber length]>0) {
                     if ([caiguoarr count]>i) {
                         if ([self.cainame isEqualToString:@"303"]) {
                             if ([[caiguoarr objectAtIndex:i] isEqualToString:@"2"]) {
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*2+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14*2+(i+1))*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                 iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"1"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*1+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14+(i+1))*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                 iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"0"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*0+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(i+1)*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                 iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"3"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*3+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14*3+(i+1))*100];
                                 labeli.text = @"3";//[caiguoarr objectAtIndex:i];
                                 
//                                 iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                 iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                 labeli.textColor = [UIColor whiteColor];
                                 
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"3+"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*4+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14*4+(i+1))*100];
                                 labeli.text = @"3+";
                                 
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                 iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 
                             }
                         
                         
                         }else{
                             if ([[caiguoarr objectAtIndex:i] isEqualToString:@"0"]) {
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*2+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14*2+(i+1))*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 if ([self.cainame isEqualToString:@"302"]) {
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                     iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 }
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"1"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*1+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(14+(i+1))*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 if ([self.cainame isEqualToString:@"302"]) {
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                     iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 }
                             }else if ([[caiguoarr objectAtIndex:i] isEqualToString:@"3"]){
                                 iamgebgi = (UIImageView *)[xiaimageview viewWithTag:14*0+(i+1)];
                                 labeli = (UILabel *)[iamgebgi viewWithTag:(i+1)*100];
                                 labeli.text = [caiguoarr objectAtIndex:i];
                                 if ([self.cainame isEqualToString:@"302"]) {
//                                     iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                                     iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                                     labeli.textColor = [UIColor whiteColor];
                                 }
                             }
                         }
                         
                     }
                 }
                 
                 
                 if ([[matchdict objectForKey:@"zcm"] length]>0||[matchdict objectForKey:@"zcm"] == nil) {
                     if ([zcmarr count] > i) {
                         if ([[zcmarr objectAtIndex:i] isEqualToString:@"2"]) {
                             labeli.textColor = [UIColor whiteColor];
//                             iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKH960.png");
                             iamgebgi.backgroundColor=[UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
                             
                         }else  if ([[zcmarr objectAtIndex:i] isEqualToString:@"1"]){
//                             iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKHH960.png");
                             iamgebgi.backgroundColor=[UIColor colorWithRed:253/255.0 green:200/255.0 blue:50/255.0 alpha:1];
                             labeli.textColor = [UIColor whiteColor];
                             
                         }else  if ([[zcmarr objectAtIndex:i] isEqualToString:@"0"]){
//                             iamgebgi.image =  UIImageGetImageFromName(@"TCKJXQFKL960.png");
                             iamgebgi.backgroundColor=[UIColor colorWithRed:29/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                             labeli.textColor = [UIColor whiteColor];
                             
                         }
                     }
                 }
                 
                 
                 
                 
             }
         }
         
         
         
//         UIImageView * upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 171, 294, 40)];
         UIImageView * upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(13, 190, 294, 40)];
//         upimageview.image = [[UIImage imageNamed:@"SZT-S-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
         upimageview.backgroundColor = [UIColor clearColor];
         
         UIImageView *xian=[[UIImageView alloc]initWithFrame:CGRectMake(0, 190, 320, 0.5)];
         xian.image=[UIImage imageNamed:@"SZTG960.png"];
         [bgViewController addSubview:xian];
         [xian release];
         
         
//         UIImageView * lineimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 209, 292, 2)];
         UIImageView * lineimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 230, 320, 0.5)];
         lineimage1.image = [UIImage imageNamed:@"SZTG960.png"] ;
         lineimage1.backgroundColor = [UIColor clearColor];
         
//         UILabel * dilabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 13, 40)];
         UILabel * dilabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 13, 40)];
         dilabel.backgroundColor = [UIColor clearColor];
         dilabel.textAlignment = NSTextAlignmentLeft;
         dilabel.font = [UIFont boldSystemFontOfSize:13];
         dilabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         dilabel.text = @"第 ";
         [upimageview addSubview:dilabel];
         [dilabel release];
         
         NSString * str2 = issuesting;
         UIFont * font2 = [UIFont boldSystemFontOfSize:13];
         CGSize  size2 = CGSizeMake(95, 60);
         CGSize labelSize2 = [str2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:UILineBreakModeWordWrap];
         
//         UILabel * issueLables= [[UILabel alloc] initWithFrame:CGRectMake(30, 0, labelSize2.width, 40)];
         UILabel * issueLables= [[UILabel alloc] initWithFrame:CGRectMake(15, 0, labelSize2.width, 40)];
         issueLables.backgroundColor = [UIColor clearColor];
         issueLables.textAlignment = NSTextAlignmentCenter;
         issueLables.font = [UIFont boldSystemFontOfSize:13];
//         issueLables.textColor = [UIColor colorWithRed:30/255.0 green:165/255.0 blue:255/255.0 alpha:1];
         issueLables.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         issueLables.text = issuesting;
         [upimageview addSubview:issueLables];
         [issueLables release];
         
//         UILabel * qilabel= [[UILabel alloc] initWithFrame:CGRectMake(30+labelSize2.width, 0, 20, 40)];
         UILabel * qilabel= [[UILabel alloc] initWithFrame:CGRectMake(15+labelSize2.width, 0, 20, 40)];
         qilabel.backgroundColor = [UIColor clearColor];
         qilabel.textAlignment = NSTextAlignmentLeft;
         qilabel.font = [UIFont boldSystemFontOfSize:13];
         qilabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         qilabel.text = @" 期";
         [upimageview addSubview:qilabel];
         [qilabel release];
         
         UILabel * datalabels = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 150, 40)];
         datalabels.backgroundColor = [UIColor clearColor];
         datalabels.font = [UIFont boldSystemFontOfSize:13];
         datalabels.textAlignment = NSTextAlignmentRight;
         datalabels.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0  blue:132/255.0  alpha:1];
         datalabels.text = datestring;
         [upimageview addSubview:datalabels];
         [datalabels release];
         
         
        
         if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]){
//             UIImageView * imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 211, 294, 40)];
             UIImageView * imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 230, 294, 40)];
//             imageview1.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
             imageview1.backgroundColor = [UIColor clearColor];
//             UIImageView * lineimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 249, 292, 2)];
             UIImageView * lineimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 270, 320, 0.5)];
             lineimage2.image = [UIImage imageNamed:@"SZTG960.png"];
             lineimage2.backgroundColor = [UIColor clearColor];
//             UILabel * shengfulabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 80, 40)];
             UILabel * shengfulabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 80, 40)];
             shengfulabel.backgroundColor = [UIColor clearColor];
             shengfulabel.textAlignment = NSTextAlignmentLeft;
             shengfulabel.font = [UIFont boldSystemFontOfSize:13];
             shengfulabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             shengfulabel.text = @"胜负彩销售 ";
             [imageview1 addSubview:shengfulabel];
             [shengfulabel release];
             
//             UILabel * yanglable = [[UILabel alloc] initWithFrame:CGRectMake(97, 0, 15, 40)];
             UILabel * yanglable = [[UILabel alloc] initWithFrame:CGRectMake(82, 0, 15, 40)];
             yanglable.backgroundColor = [UIColor clearColor];
             yanglable.textAlignment = NSTextAlignmentLeft;
             yanglable.font = [UIFont boldSystemFontOfSize:13];
             yanglable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             yanglable.text = @"￥";
             [imageview1 addSubview:yanglable];
             [yanglable release];
             
             NSArray * shiarr = [shisi componentsSeparatedByString:@","];
             
             NSString * str11 = @"";
             if ([shiarr count]> 0) {
                 str11 = [shiarr objectAtIndex:0];
             }
             UIFont * font11 = [UIFont boldSystemFontOfSize:13];
             CGSize  size11 = CGSizeMake(95, 60);
             CGSize labelSize11 = [str11 sizeWithFont:font11 constrainedToSize:size11 lineBreakMode:UILineBreakModeWordWrap];
             
//             UILabel * jine1 = [[UILabel alloc] initWithFrame:CGRectMake(112, 0, labelSize11.width, 40)];
             UILabel * jine1 = [[UILabel alloc] initWithFrame:CGRectMake(97, 0, labelSize11.width, 40)];
             jine1.backgroundColor = [UIColor clearColor];
             jine1.textColor = [UIColor colorWithRed:251/255.0 green:47/255.0 blue:47/255.0 alpha:1];
             jine1.textAlignment = NSTextAlignmentLeft;
             jine1.text = str11;
             jine1.font = font11;
             [imageview1 addSubview:jine1];
             [jine1 release];
             
//             UILabel * yuanlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(112+labelSize11.width, 0, 20, 40)];
             UILabel * yuanlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(97+labelSize11.width, 0, 20, 40)];
             yuanlabel1.backgroundColor = [UIColor clearColor];
             yuanlabel1.textAlignment = NSTextAlignmentLeft;
             yuanlabel1.font = [UIFont boldSystemFontOfSize:13];
             yuanlabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             yuanlabel1.text = @" 元";
             [imageview1 addSubview:yuanlabel1];
             [yuanlabel1 release];
             
//             UIImageView * imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 251, 294, 40)];
             UIImageView * imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 270, 294, 40)];
//             imageview2.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
             imageview2.backgroundColor = [UIColor clearColor];
//             UIImageView * lineimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 289, 292, 2)];
             UIImageView * lineimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 310, 320, 0.5)];
             lineimage3.image = [UIImage imageNamed:@"SZTG960.png"] ;
             lineimage3.backgroundColor = [UIColor clearColor];
             
//             UILabel * rejiulabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 80, 40)];
             UILabel * rejiulabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 80, 40)];
             rejiulabel.backgroundColor = [UIColor clearColor];
             rejiulabel.textAlignment = NSTextAlignmentLeft;
             rejiulabel.font = [UIFont boldSystemFontOfSize:13];
             rejiulabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             rejiulabel.text = @"任九   销售 ";
             [imageview2 addSubview:rejiulabel];
             [rejiulabel release];
             
//             UILabel * yanglable2 = [[UILabel alloc] initWithFrame:CGRectMake(97, 0, 15, 40)];
             UILabel * yanglable2 = [[UILabel alloc] initWithFrame:CGRectMake(82, 0, 15, 40)];
             yanglable2.backgroundColor = [UIColor clearColor];
             yanglable2.textAlignment = NSTextAlignmentLeft;
             yanglable2.font = [UIFont boldSystemFontOfSize:13];
             yanglable2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             yanglable2.text = @"￥";
             [imageview2 addSubview:yanglable2];
             [yanglable2 release];
             
             
             NSString * str12 = [shiarr objectAtIndex:1];
             UIFont * font12 = [UIFont boldSystemFontOfSize:13];
             CGSize  size12 = CGSizeMake(95, 60);
             CGSize labelSize12 = [str12 sizeWithFont:font12 constrainedToSize:size12 lineBreakMode:UILineBreakModeWordWrap];
             
//             UILabel * jine2 = [[UILabel alloc] initWithFrame:CGRectMake(112, 0, labelSize12.width, 40)];
             UILabel * jine2 = [[UILabel alloc] initWithFrame:CGRectMake(97, 0, labelSize12.width, 40)];
             jine2.backgroundColor = [UIColor clearColor];
             jine2.textColor = [UIColor colorWithRed:251/255.0 green:47/255.0 blue:47/255.0 alpha:1];
             jine2.textAlignment = NSTextAlignmentLeft;
             jine2.text = str12;
             jine2.font = font12;
             [imageview2 addSubview:jine2];
             [jine2 release];
             
             
             
//             UILabel * yuanlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(112+labelSize12.width, 0, 20, 40)];
             UILabel * yuanlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(97+labelSize12.width, 0, 20, 40)];
             yuanlabel2.backgroundColor = [UIColor clearColor];
             yuanlabel2.textAlignment = NSTextAlignmentLeft;
             yuanlabel2.font = [UIFont boldSystemFontOfSize:13];
             yuanlabel2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
             yuanlabel2.text = @" 元";
             [imageview2 addSubview:yuanlabel2];
             [yuanlabel2 release];
             [bgViewController addSubview:imageview1];
             [bgViewController addSubview:lineimage2];
             [bgViewController addSubview:imageview2];
             [bgViewController addSubview:lineimage3];
             [lineimage3 release];
             [imageview2 release];
             [imageview1 release];
             [lineimage2 release];
         }
         
         
//         UIImageView * imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 291, 294, 40)];
         UIImageView * imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 310, 294, 40)];
         
         UIImageView * lineimage4 = [[UIImageView alloc] initWithFrame:CGRectMake(-13, 40, 320, 0.5)];
         lineimage4.image = [UIImage imageNamed:@"SZTG960.png"] ;
         lineimage4.backgroundColor = [UIColor clearColor];
         [imageview3 addSubview:lineimage4];
         [lineimage4 release];
         
         if ([self.cainame isEqualToString:@"302"]) {

//             upimageview.frame = CGRectMake(13, 194, 294, 40);
             upimageview.frame = CGRectMake(13, 210, 294, 40);
             
//             imageview3.frame = CGRectMake(13, 234, 294, 40);
             imageview3.frame = CGRectMake(13, 245, 294, 40);
          
//             lineimage1.frame = CGRectMake(14, 232, 292, 2);
             lineimage1.frame = CGRectMake(15, 250, 320, 0.5);
             
             xian.frame = CGRectMake(0, 210, 320, 0.5);
         }
         if ([self.cainame isEqualToString:@"303"]) {
             
//             upimageview.frame = CGRectMake(13, 213, 294, 40);
             upimageview.frame = CGRectMake(13, 230, 294, 40);
             
//             imageview3.frame = CGRectMake(13, 253, 294, 40);
             imageview3.frame = CGRectMake(13, 265, 294, 40);
             
//             lineimage1.frame = CGRectMake(14, 251, 292, 2);
             lineimage1.frame = CGRectMake(15, 270, 292, 0.5);
             
             xian.frame = CGRectMake(0, 230, 320, 0.5);
         }
//         imageview3.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
         imageview3.backgroundColor = [UIColor clearColor];
         
//         UILabel * jiangchilable = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 80, 40)];
         UILabel * jiangchilable = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 80, 40)];
         jiangchilable.backgroundColor = [UIColor clearColor];
         jiangchilable.textAlignment = NSTextAlignmentLeft;
         jiangchilable.font = [UIFont boldSystemFontOfSize:13];
         jiangchilable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         jiangchilable.text = @"奖池滚存 ";
         [imageview3 addSubview:jiangchilable];
         [jiangchilable release];
         
//         UILabel * yanglable3 = [[UILabel alloc] initWithFrame:CGRectMake(87, 0, 15, 40)];
         UILabel * yanglable3 = [[UILabel alloc] initWithFrame:CGRectMake(72, 0, 15, 40)];
         yanglable3.backgroundColor = [UIColor clearColor];
         yanglable3.textAlignment = NSTextAlignmentLeft;
         yanglable3.font = [UIFont boldSystemFontOfSize:13];
         yanglable3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         yanglable3.text = @"￥";
         [imageview3 addSubview:yanglable3];
         [yanglable3 release];
         
         
         
         NSString * str13 = chistring;
         UIFont * font13 = [UIFont boldSystemFontOfSize:13];
         CGSize  size13 = CGSizeMake(95, 60);
         CGSize labelSize13 = [str13 sizeWithFont:font13 constrainedToSize:size13 lineBreakMode:UILineBreakModeWordWrap];
         
//         UILabel * jine3 = [[UILabel alloc] initWithFrame:CGRectMake(102, 0, labelSize13.width, 40)];
         UILabel * jine3 = [[UILabel alloc] initWithFrame:CGRectMake(87, 0, labelSize13.width, 40)];
         jine3.backgroundColor = [UIColor clearColor];
         jine3.textColor = [UIColor colorWithRed:251/255.0 green:47/255.0 blue:47/255.0 alpha:1];
         jine3.textAlignment = NSTextAlignmentLeft;
         jine3.text = str13;
         jine3.font = font13;
         [imageview3 addSubview:jine3];
         [jine3 release];
         
//         UILabel * yuanlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(102+labelSize13.width, 0, 20, 40)];
         UILabel * yuanlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(87+labelSize13.width, 0, 20, 40)];
         yuanlabel3.backgroundColor = [UIColor clearColor];
         yuanlabel3.textAlignment = NSTextAlignmentLeft;
         yuanlabel3.font = [UIFont boldSystemFontOfSize:13];
         yuanlabel3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
         yuanlabel3.text = @" 元";
         [imageview3 addSubview:yuanlabel3];
         [yuanlabel3 release];
         [bgViewController addSubview:upimageview];
         [bgViewController addSubview:imageview3];
         [bgViewController addSubview:lineimage1];
         [upimageview release];
         [imageview3 release];
         [lineimage1 release];
         
         
         
    }else{
        
        if ([chistring length] > 0){
            
            NSString * str = chistring;
            
            //            UIFont * font = [UIFont boldSystemFontOfSize:12];
            UIFont * font = [UIFont boldSystemFontOfSize:17];
            CGSize  size = CGSizeMake(150, 30);
            CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
//            UILabel * jianglabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 3, 50, 30)];
//            UILabel * jianglabel = [[UILabel alloc] initWithFrame:CGRectMake(290-labelSize.width-80, 120, 80, 30)];
            UILabel * jianglabel = [[UILabel alloc] initWithFrame:CGRectMake(295-labelSize.width-80, haomalabel.frame.origin.y + 1, 80, 30)];
            jianglabel.backgroundColor = [UIColor clearColor];
            jianglabel.textAlignment = NSTextAlignmentRight;
//            jianglabel.font = [UIFont boldSystemFontOfSize:10];
            jianglabel.font = [UIFont boldSystemFontOfSize:13];
            jianglabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            jianglabel.text = @"奖池滚存";
            [bgViewController addSubview:jianglabel];
            [jianglabel release];
            
//            NSString * str = chistring;
//            
////            UIFont * font = [UIFont boldSystemFontOfSize:12];
//            UIFont * font = [UIFont boldSystemFontOfSize:15];
//            CGSize  size = CGSizeMake(95, 30);
//            CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            
//            UILabel * moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 2, labelSize.width, 30)];
//            UILabel * moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(290-labelSize.width, 119, labelSize.width, 30)];
            UILabel * moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(295-labelSize.width, haomalabel.frame.origin.y + 1, labelSize.width, 30)];
            moneylabel.backgroundColor = [UIColor clearColor];
            moneylabel.textAlignment = NSTextAlignmentRight;
//            moneylabel.font = [UIFont boldSystemFontOfSize:12];
            moneylabel.font = [UIFont boldSystemFontOfSize:17];
            moneylabel.textColor = [UIColor redColor];
            moneylabel.text = chistring;
            [bgViewController addSubview:moneylabel];
            [moneylabel release];
            
//            UILabel * yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(245+labelSize.width, 3, 15, 30)];
//            UILabel * yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 120, 15, 30)];
            UILabel * yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(295, haomalabel.frame.origin.y + 1, 15, 30)];
            yuanlabel.backgroundColor = [UIColor clearColor];
            yuanlabel.textAlignment = NSTextAlignmentLeft;
//            yuanlabel.font = [UIFont boldSystemFontOfSize:10];
            yuanlabel.font = [UIFont boldSystemFontOfSize:13];
            yuanlabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            yuanlabel.text = @"元";
            [bgViewController addSubview:yuanlabel];
            [yuanlabel release];

        }
        
                
        
        UIImageView * qiubgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 300, 50)];
//        qiubgimage.image = UIImageGetImageFromName(@"TCKJXQSZC960.png");
        qiubgimage.backgroundColor = [UIColor clearColor];
        
        NSArray * allnuber = [qiustring componentsSeparatedByString:@","];
        NSArray * testqian1 = [qiustring componentsSeparatedByString:@"+"];
        NSArray * testqian2;
        NSArray * testqian3;
        
        if ([self.cainame isEqualToString:@"011"]) {
            for (int i = 0; i < [allnuber count]; i++) {
                UIImageView *qiuview = [[UIImageView alloc] init];
//                qiuview.frame = CGRectMake(0, 0, 24, 24);
                qiuview.frame = CGRectMake(0, 0, 35, 35);
//                UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
                UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 22, 22)];
//                nLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
                nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                nLabel.textAlignment = NSTextAlignmentCenter;
                nLabel.highlightedTextColor = [UIColor whiteColor];
                nLabel.highlighted = YES;
                nLabel.backgroundColor = [UIColor clearColor];
                [qiuview addSubview:nLabel];
                [nLabel release];
                
                nLabel.text = [allnuber objectAtIndex:i];
                if ([nLabel.text isEqualToString:@"19"] || [nLabel.text isEqualToString:@"20"]) {
//                    qiuview.image = UIImageGetImageFromName(@"ball_red.png");
                    qiuview.image = UIImageGetImageFromName(@"kaijianghongqiu.png");
                }else{
//                    qiuview.image = UIImageGetImageFromName(@"ball_blue.png");
                    qiuview.image = UIImageGetImageFromName(@"kaijianglanqiu.png");
                }
//                qiuview.center = CGPointMake(25+i*25, 24/2+11);
                qiuview.center = CGPointMake(25+i*37, 35/2+11+15);
                
                [qiubgimage addSubview:qiuview];
                [qiuview release];
                
            }
        }else if([self.cainame isEqualToString:@"122"]){
            kaijiangView.frame=CGRectMake(0, 50, 320, 65);
            l1.frame=CGRectMake(0, 0, 320, 0.5);
            l2.frame=CGRectMake(0, kaijiangView.frame.size.height-0.5, 320, 0.5);
            
            NSArray * openArray = [lotteryNumber componentsSeparatedByString:@","];
            if ([openArray count] >= 3) {
                
                
                NSArray * pukeImageArray =  [self getPukeViewBy:openArray];
                
                for (int i = 0; i < [pukeImageArray count] - 1; i++) {
                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake(10+ (pukeImage.frame.size.width+3)*i  , 10, pukeImage.frame.size.width, pukeImage.frame.size.height);
                    pukeImage.frame = CGRectMake(10+ (25+5)*i  , 30, 25, 35);
                    
                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
                    [qiubgimage addSubview:pukeImage];
                }
//                UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(232- 100 +20, 14, 100, 20)];
                UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(250- 100 +20, 30, 100, 20)];
                nameLabel.backgroundColor= [UIColor clearColor];
                nameLabel.textAlignment = NSTextAlignmentRight;
//                nameLabel.font = [UIFont boldSystemFontOfSize:12];
                nameLabel.font = [UIFont boldSystemFontOfSize:15];
                nameLabel.text = [pukeImageArray objectAtIndex:3];
                [qiubgimage addSubview:nameLabel];
                [nameLabel release];
            }
        
        }else if([self.cainame isEqualToString:@"012"] || [self.cainame isEqualToString:@"013"] || [self.cainame isEqualToString:@"019"] || [self.cainame isEqualToString:LOTTERY_ID_JILIN] || [self.cainame isEqualToString:LOTTERY_ID_ANHUI]){
            
            kaijiangView.frame=CGRectMake(0, 50, 320, 65);
            l1.frame=CGRectMake(0, 0, 320, 0.5);
            l2.frame=CGRectMake(0, kaijiangView.frame.size.height-0.5, 320, 0.5);
        
//            NSArray * openArray = [lotteryNumber componentsSeparatedByString:@","];
//            if ([openArray count] >= 3) {
//                
//                
//                NSArray * pukeImageArray =  [self getShaiZiViewBy:openArray];
//                
//                for (int i = 0; i < [pukeImageArray count]; i++) {
//                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake(10+ (pukeImage.frame.size.width+3)*i  , 12, pukeImage.frame.size.width, pukeImage.frame.size.height);
//                    
//                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
//                    [qiubgimage addSubview:pukeImage];
//                }
//               
//            }
            int heZhi = 0;
            NSString * num = [qiustring stringByReplacingOccurrencesOfString:@"0" withString:@""];
            NSArray * numArr = [num componentsSeparatedByString:@","];
            
            for (int i = 0; i < numArr.count; i++) {
//                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + i * 23, 11.5, 19.5, 21)];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * 40, 30, 35, 35)];
//                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"shaizi%@.png",[numArr objectAtIndex:i]]];
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"kaijiangshaizi%@.png",[numArr objectAtIndex:i]]];
                [qiubgimage addSubview:imageView];
                [imageView release];
                heZhi += [[numArr objectAtIndex:i] integerValue];
            }
            
//            UILabel * heLabel = [[[UILabel alloc] initWithFrame:CGRectMake(155, 8, 100, 25)] autorelease];
            UILabel * heLabel = [[[UILabel alloc] initWithFrame:CGRectMake(180, 30, 100, 25)] autorelease];
            heLabel.backgroundColor = [UIColor clearColor];
            heLabel.font = [UIFont systemFontOfSize:13];
            heLabel.textAlignment=NSTextAlignmentRight;
            heLabel.text = [NSString stringWithFormat:@"和值 %d",heZhi];
            [qiubgimage addSubview:heLabel];
        
        }else{
            if ([testqian1 count] > 1) {
                testqian2 = [[testqian1 objectAtIndex:0] componentsSeparatedByString:@","];
                testqian3 = [[testqian1 objectAtIndex:1] componentsSeparatedByString:@","];
                
                NSInteger countBall = 0;
                if ([self.cainame isEqualToString:@"001"] && [self.Luck_blueNumber integerValue] != 0 && [self.Luck_blueNumber length] > 0) {
                    countBall = 1;
                }
                
                for (int  i = 0;  i < [testqian2 count]+[testqian3 count]+countBall; i++) {
                    
                    UIImageView *qiuview = [[UIImageView alloc] init];
//                    qiuview.frame = CGRectMake(0, 0, 24, 24);
                    qiuview.frame = CGRectMake(0, 0, 36, 36);
//                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 22, 22)];
                    
//                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                    nLabel.textAlignment = NSTextAlignmentCenter;
                    nLabel.highlightedTextColor = [UIColor whiteColor];
                    nLabel.highlighted = YES;
                    nLabel.backgroundColor = [UIColor clearColor];
                    [qiuview addSubview:nLabel];
                    [nLabel release];
                    
                    if (i < [testqian2 count]) {
//                        qiuview.image = UIImageGetImageFromName(@"ball_red.png");
                        qiuview.image = UIImageGetImageFromName(@"kaijianghongqiu.png");
                        nLabel.text = [testqian2 objectAtIndex:i];
//                        qiuview.center = CGPointMake(25+i*25, 24/2+11);
                        if (countBall) {
                             qiuview.center = CGPointMake(18+i*38, 36/2+25);
                        }else{
                             qiuview.center = CGPointMake(15+i*38, 36/2+25);
                        }
                       
                    }else{
//                        qiuview.image = UIImageGetImageFromName(@"ball_blue.png");
                       
                        
                        if ([self.cainame isEqualToString:@"001"] && [self.Luck_blueNumber integerValue] != 0 && [self.Luck_blueNumber length] > 0 && i == 7) {
                        
                            
                            qiuview.image = UIImageGetImageFromName(@"luckyblue.png");
                            nLabel.text = self.Luck_blueNumber;
                            //                        qiuview.frame =CGRectMake(210 -  ([testqian2 count]+[testqian3 count] - i)*24, 11, 24, 24);
                            qiuview.center = CGPointMake(18+i*38, 36/2+25);
                            
                            
                        }else{
                            qiuview.image = UIImageGetImageFromName(@"kaijianglanqiu.png");
                            nLabel.text = [testqian3 objectAtIndex:i - [testqian2 count]];
                            //                        qiuview.frame =CGRectMake(210 -  ([testqian2 count]+[testqian3 count] - i)*24, 11, 24, 24);
                            if (countBall == 1) {
                                qiuview.center = CGPointMake(18+i*38, 36/2+25);
                            }else{
                                qiuview.frame =CGRectMake(300 -  ([testqian2 count]+[testqian3 count] - i)*38, 25, 36, 36);
                            }
                            
                        }
                        
                    }
                    
                    [qiubgimage addSubview:qiuview];
                    [qiuview release];
                    
                }
                if (([cainame isEqualToString:@"001"] || [cainame isEqualToString:@"113"]) && ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] isKindOfClass:[LastLotteryViewController class]] || isDangQianQi)) {
//                    //双色球大乐透添加奖金计算按钮
//                    CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
////                    btn.frame = CGRectMake(220, 7, 70, 30);
//                    btn.frame = CGRectMake(220, 117, 70, 30);
////                    [btn loadButonImage:@"TYD960.png" LabelName:@"奖金计算"];
//                    [btn loadButonImage:@"TYD960.png" LabelName:@"奖金计算"];
//                    
//                    [btn addTarget:self action:@selector(goJiangjinJiSuan:) forControlEvents:UIControlEventTouchUpInside];
//                    [bgViewController addSubview:btn];
//                    qiubgimage.userInteractionEnabled = YES;
                    
                    jiangJinJiSuanButton = [[UIButton alloc] init];
                    jiangJinJiSuanButton.frame=CGRectMake(220, 117, 85, 30);
                    [jiangJinJiSuanButton addTarget:self action:@selector(goJiangjinJiSuan:) forControlEvents:UIControlEventTouchUpInside];
                    [jiangJinJiSuanButton addTarget:self action:@selector(goJiangjinJiSuandown:) forControlEvents:UIControlEventTouchDown];
                    [jiangJinJiSuanButton addTarget:self action:@selector(goJiangjinJiSuancancel:) forControlEvents:UIControlEventTouchCancel];

                    [bgViewController addSubview:jiangJinJiSuanButton];
                    jiangjinIma=[[UIImageView alloc]init];
                    jiangjinIma.frame=CGRectMake(220, 124, 16, 16);
                    jiangjinIma.image=[UIImage imageNamed:@"jiangjinjisuan.png"];
                    jiangjinIma.backgroundColor=[UIColor clearColor];
                    jiangjinIma.userInteractionEnabled=YES;
                    [bgViewController addSubview:jiangjinIma];
                    [jiangjinIma release];
                    
                    jiangjinLab = [[UILabel alloc] init];
                    jiangjinLab.frame=CGRectMake(245, 117, 60, 30);
                    jiangjinLab.backgroundColor=[UIColor clearColor];
                    jiangjinLab.text=@"奖金计算";
                    jiangjinLab.font=[UIFont systemFontOfSize:15];
                    jiangjinLab.textColor= [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                    [bgViewController addSubview:jiangjinLab];
                    
                    UIImageView *xianIma=[[UIImageView alloc]init];
                    xianIma.frame=CGRectMake(0, 155, 320, 0.5);
                    xianIma.backgroundColor=[UIColor clearColor];
                    xianIma.image=[UIImage imageNamed:@"SZTG960.png"];
                    [bgViewController addSubview:xianIma];
                    [xianIma release];
                }
            }else{
                for (int i = 0; i < [allnuber count]; i++) {
                    UIImageView *qiuview = [[UIImageView alloc] init];
//                    qiuview.frame = CGRectMake(0, 0, 24, 24);
                    qiuview.frame = CGRectMake(0, 0, 35, 35);
//                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 22, 22)];
//                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                    nLabel.textAlignment = NSTextAlignmentCenter;
                    nLabel.highlightedTextColor = [UIColor whiteColor];
                    nLabel.highlighted = YES;
                    nLabel.backgroundColor = [UIColor clearColor];
                    [qiuview addSubview:nLabel];
                    [nLabel release];
//                    qiuview.image = UIImageGetImageFromName(@"ball_red.png");
                    qiuview.image = UIImageGetImageFromName(@"kaijianghongqiu.png");
                    nLabel.text = [allnuber objectAtIndex:i];
//                    qiuview.center = CGPointMake(25+i*25, 24/2+11);
                    qiuview.center = CGPointMake(25+i*40, 35/2+11+15);
                    
                    [qiubgimage addSubview:qiuview];
                    [qiuview release];
                    
                }
                
            }
        }
        
        [bgViewController addSubview:qiubgimage];
        [qiubgimage release];
        
        UILabel * dilabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 82, 17, 30)];
        dilabel.backgroundColor = [UIColor clearColor];
        dilabel.textAlignment = NSTextAlignmentCenter;
        dilabel.font = [UIFont boldSystemFontOfSize:10];
        dilabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        dilabel.text = @"第 ";
//        [bgViewController addSubview:dilabel];
        [dilabel release];
        
        NSString * str2 = issuesting;
        UIFont * font2 = [UIFont boldSystemFontOfSize:13];
        CGSize  size2 = CGSizeMake(95, 60);
        CGSize labelSize2 = [str2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:UILineBreakModeWordWrap];
        
//        CGSize size;
//        size=[haomalabel.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(200, 30)];
        
//        UILabel * issueLables= [[UILabel alloc] initWithFrame:CGRectMake(32, 82, labelSize2.width, 30)];
//        UILabel * issueLables= [[UILabel alloc] initWithFrame:CGRectMake(size.width+20, 10, labelSize2.width, 30)];
        BOOL jiangjin=NO;
        if (([cainame isEqualToString:@"001"] || [cainame isEqualToString:@"113"]) && ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] isKindOfClass:[LastLotteryViewController class]] || isDangQianQi))
        {
            jiangjin=YES;
        }
        UILabel * issueLables= [[UILabel alloc] initWithFrame:CGRectMake(15, 120+(jiangjin?40:0), labelSize2.width, 30)];
        issueLables.backgroundColor = [UIColor clearColor];
        issueLables.textAlignment = NSTextAlignmentCenter;
        issueLables.font = [UIFont boldSystemFontOfSize:13];
//        issueLables.textColor = [UIColor colorWithRed:30/255.0 green:165/255.0 blue:255/255.0 alpha:1];
        issueLables.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        issueLables.text = issuesting;
        [bgViewController addSubview:issueLables];
        [issueLables release];
        
        
//        UILabel * qilabel= [[UILabel alloc] initWithFrame:CGRectMake(32+labelSize2.width, 82, 17, 30)];
//        UILabel * qilabel= [[UILabel alloc] initWithFrame:CGRectMake(size.width+17+issueLables.frame.size.width, 10, 17, 30)];
        UILabel * qilabel= [[UILabel alloc] initWithFrame:CGRectMake(issueLables.frame.size.width+15, 120+(jiangjin?40:0), 17, 30)];
        qilabel.backgroundColor = [UIColor clearColor];
        qilabel.textAlignment = NSTextAlignmentCenter;
//        qilabel.font = [UIFont boldSystemFontOfSize:10];
        qilabel.font = [UIFont boldSystemFontOfSize:13];
        qilabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        qilabel.text = @" 期";
        if ([lotteryName isEqualToString:Lottery_Name_Horse]) {
            qilabel.text = @" 场";
        }
        [bgViewController addSubview:qilabel];
        [qilabel release];
        
       
//        UILabel * kaijiangriqi = [[UILabel alloc] initWithFrame:CGRectMake(192, 82, 52, 30)];
        UILabel * kaijiangriqi = [[UILabel alloc] initWithFrame:CGRectMake(110, 120+(jiangjin?40:0), 60, 30)];
        kaijiangriqi.backgroundColor = [UIColor clearColor];
        kaijiangriqi.textAlignment = NSTextAlignmentCenter;
//        kaijiangriqi.font = [UIFont boldSystemFontOfSize:10];
        kaijiangriqi.font = [UIFont boldSystemFontOfSize:13];
        kaijiangriqi.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        kaijiangriqi.text = @"开奖日期";
        [bgViewController addSubview:kaijiangriqi];
        [kaijiangriqi release];

//        UILabel * riqilabel = [[UILabel alloc] initWithFrame:CGRectMake(244, 82, 100, 30)];
//        UILabel * riqilabel = [[UILabel alloc] initWithFrame:CGRectMake(qilabel.frame.origin.x+20, 10, 100, 30)];
        UILabel * riqilabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 120+(jiangjin?40:0), 100, 30)];
        riqilabel.backgroundColor = [UIColor clearColor];
        riqilabel.textAlignment = NSTextAlignmentLeft;
//        riqilabel.font = [UIFont boldSystemFontOfSize:10];
        riqilabel.font = [UIFont boldSystemFontOfSize:13];
        riqilabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//        if(datestring.length>10)
//        {
//            datestring=[datestring substringToIndex:10];
//        }
        riqilabel.text = datestring;
        [bgViewController addSubview:riqilabel];
        [riqilabel release];
        
        if([self.cainame isEqualToString:@"119"]||[self.cainame isEqualToString:@"006"]||[self.cainame isEqualToString:@"011"]||[self.cainame isEqualToString:@"012"]||[self.cainame hasSuffix:@"122"] || [self.cainame isEqualToString:@"013"] ||[self.cainame isEqualToString:@"121"]||[self.cainame isEqualToString:@"014"]||[self.cainame isEqualToString:@"019"]||[self.cainame isEqualToString:LOTTERY_ID_JILIN]||[self.cainame isEqualToString:LOTTERY_ID_JIANGXI_11]||[self.cainame isEqualToString:@"123"]||[self.cainame isEqualToString:LOTTERY_ID_SHANXI_11]||[self.cainame isEqualToString:LOTTERY_ID_ANHUI]){
            kaijiangriqi.frame = CGRectMake(120, 120, 60, 30);
            riqilabel.frame = CGRectMake(180, 120, 130, 30);
        }
    }

    


    myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(20, 270, 280, 160)];
    
    
   
    myTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.tag = 1;
    myTabelView.backgroundColor = [UIColor  whiteColor];
    [myTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTabelView.userInteractionEnabled = NO;
    [bgViewController addSubview:myTabelView];
    NSInteger zhongc = 0;
    if ([zhongarray count] == 0) {
        zhongc = 1;
    }else{
        zhongc = [zhongarray count];
    }
        
    
#ifdef isCaiPiaoForIPad
    if ([lotteryName isEqualToString:@"胜负任九"]) {
        
        
        myTabelView.frame = CGRectMake(13+35, 338, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 338+zhongc*25+24);
    }else  if ([lotteryName isEqualToString:@"半全场"]){
        // myTabelView.frame = CGRectMake(13, 265, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13+35, 280, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 280+zhongc*25+24);
    }else if([lotteryName isEqualToString:@"进球彩"]){
        
        myTabelView.frame = CGRectMake(13+35, 301, 309, zhongc*25+24);
        bgViewController.frame = CGRectMake(0+35, 0, 320, 301+zhongc*25+24);
    }else {
        myTabelView.frame = CGRectMake(13, 115, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0+35, 0, 320, 115+zhongc*25+24);
    }

#else
    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]) {
        
        
        myTabelView.frame = CGRectMake(13, 338, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 338+zhongc*25+24);
    }else  if ([self.cainame isEqualToString:@"302"]){
        // myTabelView.frame = CGRectMake(13, 265, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13, 280, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 280+zhongc*25+24);
    }else if([self.cainame isEqualToString:@"303"]){
        
        myTabelView.frame = CGRectMake(13, 301, 309, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 301+zhongc*25+24);
    }else {
//        myTabelView.frame = CGRectMake(13, 115, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13, 115+35, 294, zhongc*25+24);
        bgViewController.frame = CGRectMake(0, 0, 320, 115+zhongc*25+24);
    }

#endif
    
    
//    if ([lotteryName isEqualToString:@"胜负任九"]||[lotteryName isEqualToString:@"半全场"]||[lotteryName isEqualToString:@"进球彩"]) {
//        bgViewController.frame = CGRectMake(0, 0, 320, 323+[zhongarray count]*25+24);
//    }else{
//        bgViewController.frame = CGRectMake(0, 0, 320, 115+[zhongarray count]*25+24);
//    }
//    qiuscrollView.contentSize = CGSizeMake(qiuscrollView.frame.size.width, bgViewController.frame.size.height);

    UIView * headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 294, 24)];
    headerview.backgroundColor = [UIColor clearColor];
    
    UIImageView * heagb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 24)];
    
//    heagb.image = [UIImageGetImageFromName(@"kjtablehead.png") stretchableImageWithLeftCapWidth:10 topCapHeight:7];
//    heagb.backgroundColor = [UIColor colorWithRed:231/255.0 green:229/255.0 blue:219/255.0 alpha:1];
    heagb.backgroundColor = [UIColor colorWithRed:57/255.0 green:169/255.0 blue:234/255.0 alpha:1];
    
    UILabel * jiangx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 24)];
    jiangx.text = @"奖项";
    jiangx.font = [UIFont systemFontOfSize:13];
    jiangx.textAlignment = NSTextAlignmentCenter;
    jiangx.backgroundColor = [UIColor clearColor];
    jiangx.textColor = [UIColor whiteColor];
//    jiangx.textColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    
    UIImageView * line1image = [[UIImageView alloc] initWithFrame:CGRectMake(74, 6, 1, 12)];
    line1image.backgroundColor = [UIColor whiteColor];//229
    
    
    UILabel * zhushu = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 92, 24)];
    zhushu.text = @"中奖注数";
    zhushu.font = [UIFont systemFontOfSize:13];
    zhushu.textAlignment = NSTextAlignmentCenter;
    zhushu.backgroundColor = [UIColor clearColor];
    zhushu.textColor = [UIColor whiteColor];
//    zhushu.textColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    
    UIImageView * line2image = [[UIImageView alloc] initWithFrame:CGRectMake(166, 6, 1, 12)];
    line2image.backgroundColor = [UIColor whiteColor];
    
    UILabel * jiangjin = [[UILabel alloc] initWithFrame:CGRectMake(167, 0, 127, 24)];
    jiangjin.text = @"单注奖金(元)";
    jiangjin.font = [UIFont systemFontOfSize:13];
    jiangjin.textAlignment = NSTextAlignmentCenter;
    jiangjin.backgroundColor = [UIColor clearColor];
    jiangjin.textColor = [UIColor whiteColor];
//    jiangjin.textColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
  
    
    [heagb addSubview:jiangx];
    [heagb addSubview:zhushu];
    [heagb addSubview:jiangjin];
    [jiangx release];
    [jiangjin release];
    [zhushu release];
//    [heagb addSubview:line1image];
//    [heagb addSubview:line2image];
    [line1image release];
    [line2image release];
    [headerview addSubview:heagb];
    [heagb release];
    myTabelView.tableHeaderView = headerview;
    [headerview release];
    
    
    
}

#pragma mark 分享
-(void)sharedown{
    shareImageView.image = UIImageGetImageFromName(@"fenxiang_down.png");
}
-(void)sharecancel{
    
    shareImageView.image = UIImageGetImageFromName(@"fenxiang.png");

}
-(void)share
{
    [MobClick event:@"event_kaijiangdating_fenxiang" label:[GC_LotteryType lotteryNameWithLotteryID:cainame]];
    shareImageView.image = UIImageGetImageFromName(@"fenxiang.png");

    CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    lb2.delegate = self;
    lb2.tag = 103;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        lb2.weixinBool = YES;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到新浪微博",@"分享到腾讯微博",@"分享到微信朋友圈(未安装)",nil]];
    }else{
        lb2.weixinBool = NO;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到微信朋友圈",@"分享到新浪微博",@"分享到腾讯微博",nil]];
    }
    
    
    lb2.isSelcetType = YES;
    [lb2 show];
    [lb2 release];
}

- (void)shareWeiXin{//微信分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    shareButton.hidden = YES;
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:qiuscrollView bottomY:weibolabel.frame.origin.y + 5 titleBool:NO];
    [MobClick event:@"event_wodecaipiao_weixinfenxiang"];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    shareButton.hidden = NO;
    [appcaibo sendImageContent:screenImage];
    [self.CP_navigation clearMarkLabel];	
}

- (void)tencentShareFunc{//腾讯微博分享
    if ([[[Info getInstance] userId] intValue] == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }else{
        caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
        shareButton.hidden = YES;
        UIImage * screenImage =  [appcaibo screenshotWithScrollView:qiuscrollView bottomY:weibolabel.frame.origin.y + 5 titleBool:NO];
        UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
        shareButton.hidden = NO;

//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.isShare = YES;
//        publishController.publishType = KShareController;
//        publishController.shareTo = @"2";
//        publishController.title = @"分享微博";
//
//        NSString * finalNumber = @"";
//        if ([lotteryName isEqualToString:@"快乐扑克"]) {
//            NSArray * AllArray = [qiustring componentsSeparatedByString:@","];
//            for (int i = 0; i < AllArray.count; i++) {
//                NSArray * numberArray = [[AllArray objectAtIndex:i] componentsSeparatedByString:@":"];
//                if ([[numberArray objectAtIndex:1] integerValue] == 1) {
//                    finalNumber = [finalNumber stringByAppendingString:@"黑桃"];
//                }
//                else if ([[numberArray objectAtIndex:1] integerValue] == 2) {
//                    finalNumber = [finalNumber stringByAppendingString:@"红桃"];
//                }
//                else if ([[numberArray objectAtIndex:1] integerValue] == 3) {
//                    finalNumber = [finalNumber stringByAppendingString:@"梅花"];
//                }
//                else if ([[numberArray objectAtIndex:1] integerValue] == 4) {
//                    finalNumber = [finalNumber stringByAppendingString:@"方片"];
//                }
//                if ([[numberArray objectAtIndex:0] integerValue] == 1) {
//                    finalNumber = [finalNumber stringByAppendingString:@"A"];
//                }
//                else if ([[numberArray objectAtIndex:0] integerValue] == 11) {
//                    finalNumber = [finalNumber stringByAppendingString:@"J"];
//                }
//                else if ([[numberArray objectAtIndex:0] integerValue] == 12) {
//                    finalNumber = [finalNumber stringByAppendingString:@"Q"];
//                }
//                else if ([[numberArray objectAtIndex:0] integerValue] == 13) {
//                    finalNumber = [finalNumber stringByAppendingString:@"K"];
//                }
//                else{
//                    finalNumber = [finalNumber stringByAppendingString:[numberArray objectAtIndex:0]];
//                }
//                if (i != AllArray.count - 1) {
//                    finalNumber = [finalNumber stringByAppendingString:@","];
//                }
//            }
//        }else{
//            finalNumber = qiustring;
//        }
//        publishController.weiBoContent = [NSString stringWithFormat:@"%@开奖-第%@期开奖号码：【%@】 @投注站",lotteryName,issuesting,finalNumber];
//        publishController.shareImage = screenImage;
//        [self.navigationController pushViewController:publishController animated:YES];
//        [publishController release];
        
        
        
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.infoShare = YES;
        publishController.microblogType = NewTopicController;
        publishController.shareTo = @"2";
        publishController.title = @"分享微博";
        
        NSString * finalNumber = @"";
        if ([lotteryName isEqualToString:@"快乐扑克"]) {
            NSArray * AllArray = [qiustring componentsSeparatedByString:@","];
            for (int i = 0; i < AllArray.count; i++) {
                NSArray * numberArray = [[AllArray objectAtIndex:i] componentsSeparatedByString:@":"];
                if ([numberArray count] > 1) {
                    if ([[numberArray objectAtIndex:1] integerValue] == 1) {
                        finalNumber = [finalNumber stringByAppendingString:@"黑桃"];
                    }
                    else if ([[numberArray objectAtIndex:1] integerValue] == 2) {
                        finalNumber = [finalNumber stringByAppendingString:@"红桃"];
                    }
                    else if ([[numberArray objectAtIndex:1] integerValue] == 3) {
                        finalNumber = [finalNumber stringByAppendingString:@"梅花"];
                    }
                    else if ([[numberArray objectAtIndex:1] integerValue] == 4) {
                        finalNumber = [finalNumber stringByAppendingString:@"方片"];
                    }
                    
                    if ([[numberArray objectAtIndex:0] integerValue] == 1) {
                        finalNumber = [finalNumber stringByAppendingString:@"A"];
                    }
                    else if ([[numberArray objectAtIndex:0] integerValue] == 11) {
                        finalNumber = [finalNumber stringByAppendingString:@"J"];
                    }
                    else if ([[numberArray objectAtIndex:0] integerValue] == 12) {
                        finalNumber = [finalNumber stringByAppendingString:@"Q"];
                    }
                    else if ([[numberArray objectAtIndex:0] integerValue] == 13) {
                        finalNumber = [finalNumber stringByAppendingString:@"K"];
                    }
                    else{
                        finalNumber = [finalNumber stringByAppendingString:[numberArray objectAtIndex:0]];
                    }
                }
                
                if (i != AllArray.count - 1) {
                    finalNumber = [finalNumber stringByAppendingString:@","];
                }
            }
        }else{
            finalNumber = qiustring;
        }
        publishController.weiBoContent = [NSString stringWithFormat:@"%@开奖-第%@期开奖号码：【%@】 @投注站",lotteryName,issuesting,finalNumber];
        publishController.mSelectImage = screenImage;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        
    }
}

- (void)sinaShareFunc{//新浪分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    shareButton.hidden = YES;
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:qiuscrollView bottomY:weibolabel.frame.origin.y + 5 titleBool:NO];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    shareButton.hidden = NO;
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    
    WBMessageObject * messageObject = [WBMessageObject message];
    messageObject.text = [NSString stringWithFormat:@"%@开奖-第%@期开奖号码：【%@】 @投注站",lotteryName,issuesting,qiustring];
    WBImageObject * imageObject = [WBImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(screenImage, 1);
    messageObject.imageObject = imageObject;
    
    WBSendMessageToWeiboRequest * request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject];
    
    [WeiboSDK sendRequest:request];
}

#pragma mark -

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString * message = @"";
    switch (response.statusCode) {
        case 0:
        {
            message = @"分享成功";
        }
            break;
        case -1:
        {
            message = @"用户取消发送";
        }
            break;
        case -2:
        {
            message = @"发送失败";
        }
            break;
        case -3:
        {
            message = @"授权失败";
        }
            break;
        case -4:
        {
            message = @"用户取消安装微博客户端";
        }
            break;
        case -99:
        {
            message = @"不支持的请求";
        }
            break;
            
        default:
        {
            message = @"未知问题";
        }
            break;
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate showMessage:message];
}

#pragma mark -

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//        return headerview;
//}

#pragma mark tableview delegate dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger zhongc = 0;
    if ([zhongarray count] == 0) {
        zhongc = 1;
    }else{
        zhongc = [zhongarray count];
    }
//    NSDictionary *dic = [self.lotteries objectAtIndex:sectionnum];
//    NSArray *arr = [dic objectForKey:@"list"];
//    LastLottery *lottery = [arr objectAtIndex:rownum];
    BOOL jiangjin=NO;
    if (([cainame isEqualToString:@"001"] || [cainame isEqualToString:@"113"]) && ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] isKindOfClass:[LastLotteryViewController class]] || isDangQianQi))
    {
        jiangjin=YES;
    }
    if ([self.cainame isEqualToString:@"300"]||[self.cainame isEqualToString:@"301"]) {
        
//        myTabelView.frame = CGRectMake(13, 338, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13, 365+(jiangjin?40:0), 294, zhongc*35+24);
    }else  if ([self.cainame isEqualToString:@"302"]){
//        myTabelView.frame = CGRectMake(13, 280, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13, 300+(jiangjin?40:0), 294, zhongc*35+24);
    }else if([self.cainame isEqualToString:@"303"]){
//        myTabelView.frame = CGRectMake(13, 301, 294, zhongc*25+24);
        myTabelView.frame = CGRectMake(13, 320+(jiangjin?40:0), 294, zhongc*35+24);
    }else {
//        myTabelView.frame = CGRectMake(13, 115, 294, zhongc*25+24);
//        myTabelView.frame = CGRectMake(13, 115+([chistring length]>0?35:15), 294, zhongc*35+24);
        myTabelView.frame = CGRectMake(13, 115+35+(jiangjin?40:0), 294, zhongc*35+24);
    }
    if (tableView.tag == 1) {
//        return 25;
        return 35;
    }
    if (tableView.tag == 2) {
       // if ([reyiArray count]> indexPath.row) {
            NSDictionary * diction = [reyiArray objectAtIndex:indexPath.row];
            NSString * ss = [diction objectForKey:@"content"];
            UIFont * font = [UIFont systemFontOfSize:14];
            CGSize  size = CGSizeMake(274, 1000);
            ss = [ss flattenPartHTML:ss];
           // ss = [ss stringByReplacingOccurrencesOfString:huatistring withString:@""];
           // ss = [NSString stringWithFormat:@"%@:%@", [diction objectForKey:@"nick_name"], ss];
            CGSize labelSize = [ss sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        
//        UIFont * font = [UIFont systemFontOfSize: 14];
//        CGSize  size = CGSizeMake(274, 1000);
//        ss = [ss flattenPartHTML:ss];
//        
//        
//        CGSize labelSize = [ss sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

        
        
            if (labelSize.height < 44) {
                return 44+3;
            }else{
                return labelSize.height+5;
            }
            
       // }
       
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
//        if ([zhongarray count] >6) {
//            return 6;
//        }
        if ([zhongarray count] == 0) {
            return 1;
        }
        return [zhongarray count];
    }
    if (tableView.tag == 2) {
        if ([reyiArray count] > 5) {
            return 5;
        }else{
            return [reyiArray count];
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        NSString * cellid = @"cellid";
        XiangQingCell * cell = (XiangQingCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
       
        if (cell == nil) {
            cell = [[[XiangQingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }
        if ([zhongarray count] == 0) {
            cell.dengLabel.text = @"——";
            cell.zhushuLabel.text = @"——";
            cell.jiangjinLabel.text = @"——";
//            cell.cellbgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            cell.lineimage.image = nil;
        }else{
            NSDictionary * dict = [zhongarray objectAtIndex:indexPath.row];
            cell.dengLabel.text = [dict objectForKey:@"awards"];
            cell.zhushuLabel.text = [dict objectForKey:@"winningNote"];
            cell.jiangjinLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"single_Note_Bonus"] ];
            
            if (indexPath.row == [zhongarray count]-1) {
//                cell.cellbgimage.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
//                cell.lineimage.image = nil;
                cell.lineimage.image = [UIImage imageNamed:@"SZTG960.png"];
            }else{
                cell.lineimage.image = [UIImage imageNamed:@"SZTG960.png"];
//                cell.cellbgimage.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            }

        }
        return cell;
    }else if(tableView.tag == 2){
    
        NSString * cellid = @"cellid";
//        ReYiCell * cell = (ReYiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        NSDictionary * diction = [reyiArray objectAtIndex:indexPath.row];
        NSString * ss = [diction objectForKey:@"content"];
//
//        if (cell == nil) {
//                       NSLog(@"ss = %@", ss);
//            cell = [[[ReYiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid str:ss huati:huatistring name:[diction objectForKey:@"nick_name"]] autorelease];
//            
//        }
//       
//        if(indexPath.row == [reyiArray count]-1){
//            cell.xian.image = nil;
//            cell.hidden = YES;
//        }else{
//            cell.xian.image = [UIImage imageNamed:@"SZTG960.png"] ;
//            cell.hidden = NO;
//        }
//        cell.namelabel.text = [diction objectForKey:@"nick_name"];
//        cell.datelabel.text = [diction objectForKey:@"timeformate"];
//        NSLog(@"%@",[reyiArray objectAtIndex:indexPath.row] );
        
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIFont * font = [UIFont systemFontOfSize: 14];
        CGSize  size = CGSizeMake(274, 1000);
        ss = [ss flattenPartHTML:ss];
        
        
        CGSize labelSize = [ss sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        ss = [ss stringByReplacingOccurrencesOfString:huatistring withString:@""];
        ss = [NSString stringWithFormat:@"%@:%@", [diction objectForKey:@"nick_name"], ss];
         CGSize labelSize2 = [ss sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        ChatView * chat = [[ChatView alloc] initWithFrame:CGRectMake(10, 3, 274, labelSize2.height)];
        chat.text = ss;//[ss flattenPartHTML:ss];
        chat.kaijbool = YES;
       // chat.text = [chat.text stringByReplacingOccurrencesOfString:huatistring withString:@""];
        chat.backgroundColor = [UIColor clearColor];
        
        
        [cell.contentView addSubview:chat];
        [chat release];
        if (indexPath.row < 4) {
            float widthcell = 0;
            if (labelSize.height < 44) {
                widthcell = 44+1;
            }else{
                widthcell = labelSize.height+3;
            }
            
            UIImageView * xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, widthcell, cell.frame.size.width, 2)];
            xian.backgroundColor  = [UIColor clearColor];
            xian.image = [UIImage imageNamed:@"SZTG960.png"] ;
            [cell.contentView addSubview:xian];
            [xian release];
            if (indexPath.row == [reyiArray count]-1) {
                xian.image = nil;
            }
        }
        
 
        return cell;
    
    }
    return nil;
}

- (void)xqrequestFinished:(ASIHTTPRequest *)mrequest{
    NSString *result = [mrequest responseString];
    YtTopic *topic = [[YtTopic alloc] initWithParse:result];
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[topic.arrayList objectAtIndex:0]];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    [topic release];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2) {
        
        Info *info2 = [Info getInstance];
        if (![info2.userId intValue]) {;
            [self doLogin];
            return;
        }
        
        NSDictionary * diction = [reyiArray objectAtIndex:indexPath.row];
        NSString * ss = [diction objectForKey:@"topicid"];
     
        [mRequest clearDelegatesAndCancel];
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:ss]];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setDidFinishSelector:@selector(xqrequestFinished:)];
        [mRequest setNumberOfTimesToRetryOnTimeout:2];
        [mRequest startAsynchronous];
        
//        YtTopic *topic = [toyarray objectAtIndex:indexPath.row];
//        YtTopic *topic = [[YtTopic alloc] init];
//        NSDictionary * diction = [reyiArray objectAtIndex:indexPath.row];
//        NSString * ss = [diction objectForKey:@"topicid"];
//        topic.topicid = ss;
//        DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:topic];
//        detailed.kjxqBool = YES;
//
//        [self.navigationController pushViewController:detailed animated:YES];
//        [detailed release];
    }
    

}
#pragma mark 返回按钮
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)qiuchangePage:(id)sender{
    int pagee = (int)pagecon.currentPage;
    //  NSLog(@"page = %d", page);
    CGRect frame = qiuscrollView.frame;
    frame.origin.x = frame.size.height * pagee;
    frame.origin.y = 0;
    //  huaDongImage.frame = CGRectMake(2+49*page, 0, 49, 10);
    [qiuscrollView scrollRectToVisible:frame animated:YES];
}


- (void)dealloc{
    [paihangarr release];
    [matchdict release];
    [mRequest clearDelegatesAndCancel];
    self.mRequest = nil;
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    [weibolabel release];
#ifndef isHaoLeCai
    [shareButton release];
#endif
    [jiangjinLab release];

    [jiangJinJiSuanButton release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
//货币显示格式
- (NSString*)moneyFormat:(NSString *)money {
    if (!money || money.length == 0) {
        return @"";
    }
    
    NSString *mewMoney = [NSString stringWithFormat:@"%.2f",money.doubleValue];
    
    NSMutableString *formatString = [NSMutableString string];
    NSArray *companentsArray = [mewMoney componentsSeparatedByString:@"."];
    
    NSString *intString = @"";
    NSString *dotString = nil;
    if ([companentsArray count] > 0) {
        intString = companentsArray[0];
    }
    if (companentsArray.count > 1) {
        dotString = companentsArray[1];
    } else {
        dotString = @"00";
    }
    
    NSInteger dotSum = intString.length /3 - ((intString.length%3 == 0) ? 1:0);
    NSRange commonRange = NSMakeRange(0, intString.length - dotSum *3);
    if ([intString substringWithRange:commonRange]) {
        [formatString appendString:[intString substringWithRange:commonRange]];
    }
    
    for(NSInteger i = 0; i < dotSum; i++){
        [formatString appendString:[NSString stringWithFormat:@",%@",[intString substringWithRange:NSMakeRange(commonRange.length + 3*i, 3)]]];
    }
    
    [formatString appendString:@"."];
    [formatString appendString:dotString];
    return formatString;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
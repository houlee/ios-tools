//
//  HorseRaceViewController.m
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "HorseRaceViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "MyPointViewController.h"
#import "GifView.h"
#import "SharedDefine.h"
#import "SharedMethod.h"
#import "GC_HttpService.h"
#import "GC_IssueInfo.h"
#import "YiLouUnderGCBallView.h"
#import "CP_UIAlertView.h"
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "GC_LotteryUtil.h"
#import "Xieyi365ViewController.h"
#import "JiFenBuyLotteryData.h"
#import "LotteryNum.h"
#import "JiFenBetInfo.h"
#import "GouCaiViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "StatePopupView.h"

#define TITLEBLACK_ALPHA 0.5
#define RANKBLACK_ALPHA 0.7

#define BETS_CELL_HEIGHT_0 47
#define BETS_CELL_HEIGHT 36.5

#define SHOW_LOTTER_NUM 0.3

//#define TrackLength 312

#define GuideKey @"HorseGuide"

#define PinLv 0.02
@interface HorseRaceViewController ()

@end

@implementation HorseRaceViewController
@synthesize getIssueRequest;
@synthesize yilouDic;
@synthesize myIssrecord;
@synthesize yilouRequest;
@synthesize issue;
@synthesize betRequest;
@synthesize getJiFenRequest;
@synthesize countdownTimer;
@synthesize yiLouTimer;
@synthesize raceTimer;

- (id)init
{
    self = [super init];
    if (self) {
        betsTitleArray = [[NSArray alloc] initWithObjects:@"独赢",@"连赢",@"单T", nil];
        betsContentArray = [[NSArray alloc] initWithObjects:@"猜中第一名马匹，1赔6.5",@"猜中前两名马匹，毋需顺序，1赔32.5",@"猜中前三名马匹，毋需顺序，1赔97.5", nil];
        
        aloneWinArray = [[NSMutableArray alloc] initWithCapacity:10];
        consecutiveWinArray = [[NSMutableArray alloc] initWithCapacity:10];
        aloneTArray = [[NSMutableArray alloc] initWithCapacity:10];
        selectedBetsArray = [[NSMutableArray alloc] initWithCapacity:10];
        
        aloneWinBets = 0;
        consecutiveWinBets = 0;
        aloneTBets = 0;
        
        playMethodTypeArr = [[NSMutableArray alloc] initWithCapacity:10];

        selectedString = @"";
        
        yanchiTime = 90;

        canRefreshYiLou = YES;
        
        betInfo = [[JiFenBetInfo alloc] init];
        
        totalBets = 0;
        
        canStopRunLoop = YES;
        
        racecourseShowing = NO;
        
        speedArray = [[NSMutableArray alloc] initWithCapacity:10];
        markArray = [[NSMutableArray alloc] initWithCapacity:10];
        accelerationArr = [[NSMutableArray alloc] initWithCapacity:10];
        
        lotteryDic = [[NSMutableDictionary alloc] init];
        
        finishGameArray = [[NSMutableArray alloc] initWithCapacity:11];
        
        paoDaoMoveX = 1.8;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            paoDaoMoveX = 1.4;
        }
        
        gifImageArray = [[NSArray alloc] initWithObjects:@"HorseRunning.png",@"HorseRunning1.png",@"HorseRunning2.png",@"HorseRunning3.png",@"HorseRunning4.png",@"HorseRunning5.png", nil];
    }
    return self;
}

- (void)dealloc
{
    [topImageScrollView release];
    [topViewScrollView release];
    [blackView release];
    [mainScrollView release];
    
    [topIssueLabel release];
    [topNextIssueLabel release];
    [countdownLabel release];
    
    [betsTableView release];
    [betsTitleArray release];
    [betsContentArray release];
    
    [racecourseImageView release];
    [sideLineImageView release];
    [sideLineImageView1 release];
    [watchGameButton release];
    [shuZiBetsView release];
//    [firstLine release];
    [speedArray release];
    [markArray release];
    
    [horseTrackImageView release];
    [finishGameArray release];
    
    [aloneWinArray release];
    [consecutiveWinArray release];
    [aloneTArray release];
    [lotteryNumberView release];
    [playMethodButton release];
    
    [betsBGView release];
    [addButton release];
    
    [playMethodTypeArr release];
    [topView release];
    
    [getIssueRequest clearDelegatesAndCancel];
    self.getIssueRequest = nil;
    [yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    [betRequest clearDelegatesAndCancel];
    self.betRequest = nil;
    [getJiFenRequest clearDelegatesAndCancel];
    self.getJiFenRequest = nil;
    
    [betInfo release];
    [betAlert release];
    
    [lotteryDic release];
    
    [windowButton release];
    [betListBGView release];
    
    [gifImageArray release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CP_navigation.title = Lottery_Name_Horse;
    self.CP_navigation.backgroundColor = [UIColor clearColor];
    
    trackLength = self.view.frame.size.width - 32 + 24;
    
    windowButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    windowButton.backgroundColor = [UIColor clearColor];
    windowButton.userInteractionEnabled = NO;
    [windowButton addTarget:self action:@selector(windowButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:windowButton];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:GuideKey] isEqualToString:@"1"]) {
        caiboAppDelegate * app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;

        guideY = 960;
        if (IS_IPHONE_5) {
            guideY = 1136;
        }
        UIButton * guideButton = [[[UIButton alloc] initWithFrame:app.window.bounds] autorelease];
        [guideButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorseGuide%d_1.jpg",guideY]] forState:UIControlStateNormal];
        [app.window addSubview:guideButton];
        guideButton.adjustsImageWhenHighlighted = NO;
        [guideButton addTarget:self action:@selector(guideButton:) forControlEvents:UIControlEventTouchUpInside];
        
        guideButton.tag = 2;
    }
    
    UIImageView * navigationImageView = [self.CP_navigation.subviews objectAtIndex:1];
    navigationImageView.backgroundColor = [UIColor clearColor];
    
    self.mainView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor= [SharedMethod getColorByHexString:@"f4f4f4"];
    
    topImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 268.5)];
    topImageScrollView.backgroundColor = [UIColor clearColor];
    topImageScrollView.bounces = NO;
    topImageScrollView.showsVerticalScrollIndicator = NO;
    topImageScrollView.delegate = self;
    topImageScrollView.tag = 1000;
    topImageScrollView.contentSize = CGSizeMake(topImageScrollView.frame.size.width, 1000);
    [self.view addSubview:topImageScrollView];
    
    UIImageView * topHorseImageView = [[[UIImageView alloc] initWithFrame:topImageScrollView.bounds] autorelease];
    topHorseImageView.image = UIImageGetImageFromName(@"HorseNoGame.png");
    [topImageScrollView addSubview:topHorseImageView];

    topViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 268.5)];
    topViewScrollView.backgroundColor = [UIColor clearColor];
    topViewScrollView.bounces = NO;
    topViewScrollView.showsVerticalScrollIndicator = NO;
    topViewScrollView.delegate = self;
    topViewScrollView.layer.masksToBounds = YES;
    topViewScrollView.tag = 2000;
    topViewScrollView.contentSize = CGSizeMake(topViewScrollView.frame.size.width, 1000);
    [self.view addSubview:topViewScrollView];
    
    [self.view sendSubviewToBack:topViewScrollView];
    [self.view sendSubviewToBack:topImageScrollView];

    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, topHorseImageView.frame.size.height - 50, self.mainView.frame.size.width, 50)];
    topView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:TITLEBLACK_ALPHA];
    [topViewScrollView addSubview:topView];
    topView.layer.masksToBounds = YES;
    
    blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, topViewScrollView.frame.size.width, topViewScrollView.frame.size.height - topView.frame.size.height)];
    blackView.backgroundColor = [UIColor blackColor];
    [topViewScrollView addSubview:blackView];
    blackView.alpha = 0;
    
    topIssueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, topView.frame.size.height)];
    [topView addSubview:topIssueLabel];
    topIssueLabel.font = [UIFont systemFontOfSize:13];
    topIssueLabel.backgroundColor = [UIColor clearColor];
    topIssueLabel.textColor = [UIColor whiteColor];
    
    topPlayTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(topIssueLabel) + 10, topView.frame.size.height, 70, topView.frame.size.height)];
    [topView addSubview:topPlayTypeLabel];
    topPlayTypeLabel.font = [UIFont systemFontOfSize:13];
    topPlayTypeLabel.backgroundColor = [UIColor clearColor];
    topPlayTypeLabel.textColor = [UIColor whiteColor];
    topPlayTypeLabel.text = @"等待开赛...";
    topPlayTypeLabel.layer.masksToBounds = NO;
    
    lotteryNumberView = [[UIView alloc] initWithFrame:CGRectMake(topPlayTypeLabel.frame.origin.x, 0, 190, topView.frame.size.height)];
    [topView addSubview:lotteryNumberView];
    lotteryNumberView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < 5; i++) {
        UIImageView * horseHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 37.5, (lotteryNumberView.frame.size.height - 32.5)/2, 32.5, 32.5)];
        horseHeadImageView.image = [UIImage imageNamed:@"HorseHead.png"];
        [lotteryNumberView addSubview:horseHeadImageView];
        [horseHeadImageView release];
        
        UILabel * horseHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.5, 18, 17, 12)];
        horseHeadLabel.textColor = [UIColor whiteColor];
        horseHeadLabel.textAlignment = 1;
        horseHeadLabel.font = [UIFont systemFontOfSize:12];
        [horseHeadImageView addSubview:horseHeadLabel];
        horseHeadLabel.backgroundColor = [UIColor clearColor];
        horseHeadLabel.tag = i + 10;
        [horseHeadLabel release];
    }
    
    topNextIssueLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 5, self.view.frame.size.width - 260, 17)];//下期期号
    [topView addSubview:topNextIssueLabel];
    topNextIssueLabel.textColor = [UIColor whiteColor];
    topNextIssueLabel.backgroundColor = [UIColor clearColor];
    topNextIssueLabel.font = [UIFont systemFontOfSize:8];
    topNextIssueLabel.text = @"距53场截止";
    
    countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(topNextIssueLabel.frame.origin.x, ORIGIN_Y(topNextIssueLabel), topNextIssueLabel.frame.size.width, 20)];
    [topView addSubview:countdownLabel];
    countdownLabel.textColor = [UIColor whiteColor];
    countdownLabel.backgroundColor = [UIColor clearColor];
    countdownLabel.font = [UIFont fontWithName:@"Quartz" size:20];
    
    sideLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  self.CP_navigation.frame.size.height + topView.frame.size.height + 10.5, 960, 25.5)];
    sideLineImageView.image = UIImageGetImageFromName(@"HorseSideline.png");
    sideLineImageView.hidden = YES;
    sideLineImageView.layer.masksToBounds = YES;
    sideLineImageView.userInteractionEnabled = YES;
    [windowButton addSubview:sideLineImageView];
    
    sideLineImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,  self.CP_navigation.frame.size.height + topView.frame.size.height + 10.5, 960, 25.5)];
    sideLineImageView1.image = UIImageGetImageFromName(@"HorseSideline_1.png");
    sideLineImageView1.hidden = YES;
    sideLineImageView1.layer.masksToBounds = YES;
    sideLineImageView1.userInteractionEnabled = YES;
    [self.view addSubview:sideLineImageView1];
    
    watchGameButton = [[UIButton alloc] initWithFrame:CGRectMake((windowButton.frame.size.width - 97.5)/2, 1.5, 97.5, 22.5)];
    [watchGameButton setBackgroundImage:UIImageGetImageFromName(@"WatchTheGame.png") forState:UIControlStateNormal];
    [watchGameButton setBackgroundImage:UIImageGetImageFromName(@"WatchTheGame_1.png") forState:UIControlStateHighlighted];
    [watchGameButton addTarget:self action:@selector(showRacecourse) forControlEvents:UIControlEventTouchUpInside];
    [sideLineImageView1 addSubview:watchGameButton];
    
    racecourseBlackButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  ORIGIN_Y(sideLineImageView), windowButton.frame.size.width, 0)];
    racecourseBlackButton.hidden = YES;
    racecourseBlackButton.layer.masksToBounds = YES;
    racecourseBlackButton.userInteractionEnabled = YES;
    racecourseBlackButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:TITLEBLACK_ALPHA];
    [windowButton addSubview:racecourseBlackButton];
    [racecourseBlackButton addTarget:self action:@selector(closeRacecourse) forControlEvents:UIControlEventTouchUpInside];
    
    racecourseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 400, self.view.frame.size.width, 226.5)];
    [racecourseBlackButton addSubview:racecourseImageView];
    
    horseTrackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 960, 226.5)];
    [racecourseImageView addSubview:horseTrackImageView];
    horseTrackImageView.image = UIImageGetImageFromName(@"HorseTrack.png");
    
    [self createHorse];
    
//    firstLine = [[UIView alloc] initWithFrame:CGRectMake(59.5, 0, 1, racecourseImageView.frame.size.height)];
//    firstLine.backgroundColor = [UIColor greenColor];
//    [racecourseImageView addSubview:firstLine];
    
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(back)];
    self.CP_navigation.leftBarButtonItem = left;
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
        
        self.CP_navigation.rightBarButtonItem = right;
    }
    else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        
        btn.frame = CGRectMake(20, 0, 40, 44);
        [btn addTarget:self action:@selector(pressMenu:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        [rightItem release];
    }
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40.5  + (20 - isIOS7Pianyi), self.mainView.frame.size.width, self.mainView.frame.size.height - topView.frame.size.height + 9.5)];
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.delegate = self;
    mainScrollView.tag = 3000;
    [self.mainView addSubview:mainScrollView];
    
    betListBGView = [[UIView alloc] init];
    betListBGView.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:betListBGView];
    
    UIView * betTitleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, 37)] autorelease];
    betTitleView.backgroundColor = [UIColor whiteColor];
    [betListBGView addSubview:betTitleView];
    
    UILabel * betTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, betTitleView.frame.size.height)] autorelease];
    betTitleLabel.text = @"投注单";
    betTitleLabel.font = [UIFont systemFontOfSize:15];
    betTitleLabel.backgroundColor = [UIColor clearColor];
    betTitleLabel.textColor = [SharedMethod getColorByHexString:@"838383"];
    [betTitleView addSubview:betTitleLabel];
    
    UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(betTitleView), mainScrollView.frame.size.width, 0.5)] autorelease];
    line.backgroundColor = [SharedMethod getColorByHexString:@"c7c7c7"];
    [betListBGView addSubview:line];

    betsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line), betTitleView.frame.size.width, BETS_CELL_HEIGHT_0 * 3)];
    betsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    betsTableView.delegate = self;
    betsTableView.dataSource = self;
    betsTableView.scrollEnabled = NO;
    [betListBGView addSubview:betsTableView];
    betsTableView.backgroundColor = [UIColor clearColor];
    
    betButton = [[UIButton alloc] initWithFrame:CGRectMake((mainScrollView.frame.size.width - 290)/2, ORIGIN_Y(betsTableView) + 15, 290, 45)];
    [betListBGView addSubview:betButton];
    [betButton setTitle:@"立即下注" forState:UIControlStateNormal];
    betButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [betButton setBackgroundImage:[UIImageGetImageFromName(@"HorsePlayMethod.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [betButton setBackgroundImage:[UIImageGetImageFromName(@"HorsePlayMethod_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [betButton setBackgroundImage:[UIImageGetImageFromName(@"HorseDisabled_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
    betButton.enabled = NO;
    [betButton addTarget:self action:@selector(showBettingConfirmAlert) forControlEvents:UIControlEventTouchUpInside];
    
    betsBGView = [[UIView alloc] initWithFrame:CGRectZero];
    betsBGView.backgroundColor = [SharedMethod getColorByHexString:@"f4f4f4"];
    [mainScrollView addSubview:betsBGView];
    
    UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, 0.5)] autorelease];
    line1.backgroundColor = [SharedMethod getColorByHexString:@"c7c7c7"];
    [betsBGView addSubview:line1];
    
    UIView * addTitleView = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line1), mainScrollView.frame.size.width, 37)] autorelease];
    addTitleView.backgroundColor = [UIColor whiteColor];
    [betsBGView addSubview:addTitleView];
    
    UILabel * addTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, addTitleView.frame.size.height)] autorelease];
    addTitleLabel.text = @"赶快下注";
    addTitleLabel.font = [UIFont systemFontOfSize:15];
    addTitleLabel.backgroundColor = [UIColor clearColor];
    addTitleLabel.textColor = [SharedMethod getColorByHexString:@"838383"];
    [addTitleView addSubview:addTitleLabel];
    
    UIView * line2 = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(addTitleView), mainScrollView.frame.size.width, 0.5)] autorelease];
    line2.backgroundColor = [SharedMethod getColorByHexString:@"c7c7c7"];
    [betsBGView addSubview:line2];

    shuZiBetsView = [[ShuZiBetsView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line2), self.view.frame.size.width, 275) controller:self numberOfBalls:11 numberOfColumns:3 title:nil description:nil showYiLouImage:NO firstNumber:1 hasZero:YES lineSpace:9 ballType:GCBallViewHorseRace ballFrame:CGRectMake(15, 15, 91, 51)];
    shuZiBetsView.tag = 9999;
    shuZiBetsView.delegate = self;
    [betsBGView addSubview:shuZiBetsView];

    playMethodButton = [[UIButton alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(shuZiBetsView), 73, 30)];
    [betsBGView addSubview:playMethodButton];
    [playMethodButton setBackgroundImage:[UIImageGetImageFromName(@"HorsePlayMethod.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [playMethodButton setBackgroundImage:[UIImageGetImageFromName(@"HorsePlayMethod_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [playMethodButton setBackgroundImage:[UIImageGetImageFromName(@"HorseDisabled.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];

    [playMethodButton setTitle:@"玩法" forState:UIControlStateNormal];
    playMethodButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [playMethodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playMethodButton addTarget:self action:@selector(showPlayMethodAlert) forControlEvents:UIControlEventTouchUpInside];
    playMethodButton.enabled = NO;
    
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(ORIGIN_X(playMethodButton) + 13, playMethodButton.frame.origin.y, 204, 30)];
    [betsBGView addSubview:addButton];
    [addButton setBackgroundImage:[UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImageGetImageFromName(@"HorseDisabled_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
    addButton.enabled = NO;
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addBetNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    betsBGView.frame = CGRectMake(0, topHorseImageView.frame.size.height - ORIGIN_Y(self.CP_navigation) - topView.frame.size.height + 9.5 - (20 - isIOS7Pianyi), mainScrollView.frame.size.width, ORIGIN_Y(addButton) + 30);
    
    betListBGView.frame = CGRectMake(0, ORIGIN_Y(betsBGView), mainScrollView.frame.size.width, ORIGIN_Y(betButton) + 15);
    
    mainScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(betListBGView) + (20 - isIOS7Pianyi));
    
    isAppear = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssue) name:@"BecomeActive" object:nil];

}

-(void)createHorse
{
    [finishGameArray removeAllObjects];
    
    racecourseImageView.frame = CGRectMake(racecourseImageView.frame.origin.x, - 400, racecourseImageView.frame.size.width, racecourseImageView.frame.size.height);
    horseTrackImageView.frame = CGRectMake(0, horseTrackImageView.frame.origin.y, horseTrackImageView.frame.size.width, horseTrackImageView.frame.size.height);
    sideLineImageView.frame = CGRectMake(0,  sideLineImageView.frame.origin.y, sideLineImageView.frame.size.width, sideLineImageView.frame.size.height);
    
    for (int i = 0; i < 11; i++) {
        GifView * horseView = (GifView *)[racecourseImageView viewWithTag:10 + i];
        if (!horseView) {
            horseView = [[[GifView alloc] initWithFrame:CGRectMake(-24 , i * 20.5 - 25, 72, 50) defaultImage:@"HorseRunningD.png" ImageArray:gifImageArray fps:10] autorelease];
            horseView.tag = 10 + i;
            [racecourseImageView addSubview:horseView];
        }else{
            horseView.frame = CGRectMake(-24 , i * 20.5 - 25, 72, 50);
        }
        
        UIImageView * numberImageView = (UIImageView *)[horseTrackImageView viewWithTag:100 + i];
        if (!numberImageView) {
            numberImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(horseTrackImageView.frame.size.width - 23, 1 + i * 20.5, 19.5, 19.5)] autorelease];
            numberImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HorseTrackNumber%d.png", 11 - i]];
            numberImageView.tag = 100 + i;
            [horseTrackImageView addSubview:numberImageView];
        }
        numberImageView.hidden = YES;
        
        
        UIImageView * finishMarkLine = (UIImageView *)[horseTrackImageView viewWithTag:10000 + i];
        if (!finishMarkLine) {
            finishMarkLine = [[[UIImageView alloc] initWithFrame:CGRectMake(horseTrackImageView.frame.size.width - 239, 1 + i * 20.5, 239, 19.5)] autorelease];
            [horseTrackImageView addSubview:finishMarkLine];
            finishMarkLine.image = UIImageGetImageFromName(@"HorseFirstFinish.png");
            finishMarkLine.tag = 10000 + i;
        }
        finishMarkLine.alpha = 0;

        finishMarkLine.frame = CGRectMake(horseTrackImageView.frame.size.width - 239, 1 + i * 20.5, 239, 19.5);
    }

}

-(void)guideButton:(UIButton *)button
{
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"HorseGuide%d_%@.jpg",guideY,[NSNumber numberWithInteger:button.tag]]] forState:UIControlStateNormal];
    if (button.tag == 4) {
        [button removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:GuideKey];
    }
    button.tag += 1;
    
}

-(void)clearFinished
{
    
}

- (void)ballSelectChange:(UIButton *)imageView
{
    GCBallView * ballView = (GCBallView *)imageView;
    
    if (ballView.selected) {
        [selectedBetsArray addObject:ballView.numLabel.text];
    }else{
        [selectedBetsArray removeObject:ballView.numLabel.text];
    }
//    if ([selectedBetsArray containsObject:ballView.numLabel.text]) {
//        [selectedBetsArray removeObject:ballView.numLabel.text];
//    }else{
//        [selectedBetsArray addObject:ballView.numLabel.text];
//    }
    [playMethodTypeArr removeAllObjects];
    if (selectedBetsArray.count == 1) {
        [playMethodButton setTitle:@"独赢" forState:UIControlStateNormal];
        [playMethodTypeArr addObject:@"独赢"];
    }
    else if (selectedBetsArray.count == 2) {
        [playMethodButton setTitle:@"连赢" forState:UIControlStateNormal];
        [playMethodTypeArr addObject:@"连赢"];
    }
    else if (selectedBetsArray.count == 3) {
        [playMethodButton setTitle:@"单T" forState:UIControlStateNormal];
        [playMethodTypeArr addObject:@"单T"];
    }
    else{
        [playMethodButton setTitle:@"玩法" forState:UIControlStateNormal];
    }
    if (selectedBetsArray.count > 0) {
        playMethodButton.enabled = YES;
        addButton.enabled = YES;
    }else{
        playMethodButton.enabled = NO;
        addButton.enabled = NO;
    }
    
}


-(void)createTimer
{
    self.countdownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
}

-(void)createYiLouTimer
{
    self.yiLouTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(yiLouChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.yiLouTimer forMode:NSRunLoopCommonModes];
}

-(void)yiLouChange
{
    for (GCBallView *ball in shuZiBetsView.subviews) {
        if ([ball isKindOfClass:[GCBallView class]] && ball.tag < 100) {
            
            for (int i = 100000; i <= 300000; i += 100000) {
                ColorView * yilouColorView = (ColorView *)[ball.ylLable viewWithTag:i];
                if (yilouColorView.frame.origin.y != -ball.ylLable.frame.size.height) {
                    [UIView animateWithDuration:0.5 animations:^{
                        yilouColorView.frame = CGRectMake(yilouColorView.frame.origin.x, yilouColorView.frame.origin.y - ball.ylLable.frame.size.height, yilouColorView.frame.size.width, yilouColorView.frame.size.height);
                    }];
                }else{
                    yilouColorView.frame = CGRectMake(yilouColorView.frame.origin.x, ball.ylLable.frame.size.height, yilouColorView.frame.size.width, yilouColorView.frame.size.height);
                }
            }
        }
    }
}

-(void)timeChange
{
    seconds -= 1;
    
    if (seconds < 0) {

        [countdownTimer invalidate];
        self.countdownTimer = nil;
        seconds = 0;

        [self getIssue];

        return;
    }
    
    if (!isKaiJiang && (seconds <= 600 - yanchiTime && seconds % 5 == 0)) {
        canRefreshYiLou = NO;
        [self getIssue];
    }
    
    countdownLabel.text = [NSString stringWithFormat:@"%02d:%02d",seconds/60,seconds%60];
    if (seconds <= 3) {
        countdownLabel.textColor = [UIColor redColor];
    }else{
        countdownLabel.textColor = [UIColor whiteColor];
    }
    
    if (isKaiJiang) {
        if (kaijianging == YES) {
            kaijianging = NO;
            [self performSelectorOnMainThread:@selector(gameStart) withObject:nil waitUntilDone:NO];
        }
    }
    else{
        if (!kaijianging) {
            kaijianging = YES;

            NSString * str = [SharedMethod getLastTwoStr:[NSString stringWithFormat:@"%lld",[self.issue longLongValue] - 1]];
            if ([str intValue] != 1) {
                topIssueLabel.text = [NSString stringWithFormat:@"%@场",str];
            }
            
            topPlayTypeLabel.frame = CGRectMake(topPlayTypeLabel.frame.origin.x, topView.frame.size.height, topPlayTypeLabel.frame.size.width, topPlayTypeLabel.frame.size.height);

            [UIView animateWithDuration:SHOW_LOTTER_NUM animations:^{
                lotteryNumberView.frame = CGRectMake(lotteryNumberView.frame.origin.x, -topView.frame.size.height, lotteryNumberView.frame.size.width, lotteryNumberView.frame.size.height);
                topPlayTypeLabel.frame = CGRectMake(topPlayTypeLabel.frame.origin.x, 0, topPlayTypeLabel.frame.size.width, topPlayTypeLabel.frame.size.height);
            } completion:^(BOOL finished) {

            }];
        }
    }
}

-(void)gameStart
{

    [self createHorse];
    
    if (mainScrollView.contentOffset.y <= 164) {
        mainScrollView.contentOffset = CGPointMake(0, 164);
    }
    
    mainScrollView.frame = CGRectMake(mainScrollView.frame.origin.x, mainScrollView.frame.origin.y + sideLineImageView.frame.size.height, mainScrollView.frame.size.width, mainScrollView.frame.size.height - sideLineImageView.frame.size.height);
    gameShowing = YES;
    topPlayTypeLabel.text = @"开赛中";
    sideLineImageView.hidden = NO;

    [speedArray removeAllObjects];
    [speedArray addObjectsFromArray:@[@"20",@"20",@"20",@"20",@"20",@"20",@"20",@"20",@"20",@"20",@"20"]];
    
    [markArray removeAllObjects];
    [markArray addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
    
    [accelerationArr removeAllObjects];
    [accelerationArr addObjectsFromArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    
    horseMoveS = 0;//距离
    
    NSMutableArray * t1 = [[[NSMutableArray alloc] initWithObjects:@"1.8",@"5",@"3",@"2",@"2", nil] autorelease];//11.5
    NSMutableArray * t2 = [[[NSMutableArray alloc] initWithObjects:@"2",@"2.5",@"2.2",@"2.2",@"2", nil] autorelease];//11
    NSMutableArray * t3 = [[[NSMutableArray alloc] initWithObjects:@"2",@"2.2",@"2.5",@"2.2",@"2.2", nil] autorelease];//10.5
    NSMutableArray * t4 = [[[NSMutableArray alloc] initWithObjects:@"2.5",@"2",@"2.5",@"2",@"1", nil] autorelease];//10
    NSMutableArray * t5 = [[[NSMutableArray alloc] initWithObjects:@"2.5",@"3",@"2",@"1.8",@"2.8", nil] autorelease];//11
    NSMutableArray * t6 = [[[NSMutableArray alloc] initWithObjects:@"2",@"2.5",@"2.5",@"2.5",@"1.5", nil] autorelease];//12
    NSMutableArray * t7 = [[[NSMutableArray alloc] initWithObjects:@"2",@"3",@"2.5",@"3",@"2", nil] autorelease];//12.8
    NSMutableArray * t8 = [[[NSMutableArray alloc] initWithObjects:@"3",@"3",@"2.5",@"2.5",@"2", nil] autorelease];//12.5
    NSMutableArray * t9 = [[[NSMutableArray alloc] initWithObjects:@"1.8",@"4.5",@"3",@"3.5",@"3", nil] autorelease];//11.8
    NSMutableArray * t10 = [[[NSMutableArray alloc] initWithObjects:@"3.5",@"3",@"2.5",@"2",@"1.5", nil] autorelease];//11.9
    NSMutableArray * t11 = [[[NSMutableArray alloc] initWithObjects:@"3",@"2.5",@"2.5",@"2.5",@"2", nil] autorelease];//13
    
    NSArray * noRankArray = @[t6,t7,t8,t9,t10,t11];

//    newLotteryNumber = @"123#11,7,4,1,5";
    NSArray * issueArray = [newLotteryNumber componentsSeparatedByString:@"#"];
    if (issueArray.count > 1) {
        NSArray * lotteryNumberArray = [[issueArray objectAtIndex:1] componentsSeparatedByString:@","];
        
        if (lotteryNumberArray.count >= 5) {
            int count = 0;
            for (int i = 0; i < 11; i++) {
                if (i + 1 == [[lotteryNumberArray objectAtIndex:0] intValue]) {
                    [lotteryDic setValue:t1 forKey:[NSString stringWithFormat:@"%d",i + 1]];
                }
                else if (i + 1 == [[lotteryNumberArray objectAtIndex:1] intValue]) {
                    [lotteryDic setValue:t2 forKey:[NSString stringWithFormat:@"%d",i + 1]];
                }
                else if (i + 1 == [[lotteryNumberArray objectAtIndex:2] intValue]) {
                    [lotteryDic setValue:t3 forKey:[NSString stringWithFormat:@"%d",i + 1]];
                }
                else if (i + 1 == [[lotteryNumberArray objectAtIndex:3] intValue]) {
                    [lotteryDic setValue:t4 forKey:[NSString stringWithFormat:@"%d",i + 1]];
                }
                else if (i + 1 == [[lotteryNumberArray objectAtIndex:4] intValue]) {
                    [lotteryDic setValue:t5 forKey:[NSString stringWithFormat:@"%d",i + 1]];
                }
                else{
                    [lotteryDic setValue:[noRankArray objectAtIndex:count] forKey:[NSString stringWithFormat:@"%d",i + 1]];
                    count++;
                }
            }
            [self horseStartRun];
        }
    }
}

-(void)horseRace
{
   
    
//    float firstX = 0;//第一名
    float acceleration = 1;
    
    for (int i = 0; i < 11; i++) {

        GifView * horseImageView = (GifView *)[racecourseImageView viewWithTag:20 - i];
        
        if (horseImageView.frame.origin.x <= racecourseImageView.frame.size.width + 10) {
            if (!horseImageView.running && horseImageView.frame.origin.x < self.view.frame.size.width) {
                [horseImageView gifRun];
            }
            if (horseImageView.frame.origin.x  >= trackLength - 24) {
                [accelerationArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",1.0]];
            }
            NSMutableArray * timeArray = [lotteryDic valueForKey:[NSString stringWithFormat:@"%d",i + 1]];
            float t = PinLv;
            for (int j = 0; j < timeArray.count; j++) {
                
                if (horseImageView.frame.origin.x >= (float)trackLength/timeArray.count * j - 24 && horseImageView.frame.origin.x < (float)trackLength/timeArray.count * (j + 1) - 24 /*&& [[markArray objectAtIndex:10 - i] isEqualToString:[NSString stringWithFormat:@"%d",1 - j%2]]*/) {
                    //acceleration = (((float)trackLength/timeArray.count - [[speedArray objectAtIndex:i] floatValue] * [[timeArray objectAtIndex:j] floatValue]) * 2)/(pow([[timeArray objectAtIndex:j] floatValue], 2))
                    t  = [[timeArray objectAtIndex:j] floatValue];
                    acceleration =(((((float)trackLength)/ timeArray.count * (j + 1)  - horseImageView.frame.origin.x) -  [[speedArray objectAtIndex:i] floatValue] *t) * 2)/(pow(t, 2));
                    [markArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",j%2]];
                    [accelerationArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",acceleration]];
                    t = t - PinLv;
                    [timeArray replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%f",t]];
                }
            }

            horseMoveS = [[speedArray objectAtIndex:i] floatValue] * PinLv + ([[accelerationArr objectAtIndex:i] floatValue] * PinLv * PinLv)/2;
            [self performSelectorOnMainThread:@selector(moveHorseImageView:) withObject:horseImageView waitUntilDone:YES];
           
            [speedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",[[speedArray objectAtIndex:i] floatValue] + [[accelerationArr objectAtIndex:i] floatValue] * PinLv]];
           
            
//            if (ORIGIN_X(horseImageView) > firstX) {
//                firstX = ORIGIN_X(horseImageView);
//            }
            
            if (horseImageView.frame.origin.x >= (trackLength - 24) - horseImageView.frame.size.width + 20) {
                if (![finishGameArray containsObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:horseImageView.tag]]]) {
                    [finishGameArray addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:horseImageView.tag]]];
                    if (finishGameArray.count < 6) {
                        UIImageView * numberImageView = (UIImageView *)[horseTrackImageView viewWithTag:100 + horseImageView.tag - 10];
                        numberImageView.hidden = NO;
                        
                        UIImageView * finishMarkLine = (UIImageView *)[horseTrackImageView viewWithTag:10000 + horseImageView.tag - 10];
                        [self performSelectorOnMainThread:@selector(moveFinishMarkLine:) withObject:finishMarkLine waitUntilDone:YES];
                    }
                }
            }
            
            if (horseImageView.frame.origin.x > self.view.frame.size.width && horseImageView.running) {
                [horseImageView gifStop];
            }

            if (finishGameArray.count == 11 && horseImageView.tag == [[finishGameArray lastObject] integerValue] && horseImageView.frame.origin.x >= (trackLength - 24) - 10 && ![windowButton viewWithTag:99]) {
                if (racecourseShowing) {
                    [self performSelectorOnMainThread:@selector(showHorseRaceRank) withObject:nil waitUntilDone:YES];
                }else{
                    [self performSelectorOnMainThread:@selector(raceFinish) withObject:nil waitUntilDone:YES];
                }
            }
        }
    }

//    if (finishGameArray.count != 11) {
//        firstLine.frame = CGRectMake(firstX - 4, firstLine.frame.origin.y, firstLine.frame.size.width, firstLine.frame.size.height);
//    }

//    if (ORIGIN_X(horseTrackImageView) > racecourseImageView.frame.size.width) {
//        //跑道
//        [self performSelectorOnMainThread:@selector(moveHorseTrack) withObject:nil waitUntilDone:YES];
//    }
}

-(void)moveFinishMarkLine:(UIImageView *)finishMarkLine
{
    [UIView animateWithDuration:0.3 animations:^{
        finishMarkLine.alpha = 1;
        finishMarkLine.frame = CGRectMake(finishMarkLine.frame.origin.x - 32, finishMarkLine.frame.origin.y, finishMarkLine.frame.size.width, finishMarkLine.frame.size.height);
    }];
}

-(void)moveHorseTrack
{

    [UIView animateWithDuration:7 animations:^{
        horseTrackImageView.frame = CGRectMake(-horseTrackImageView.frame.size.width + self.view.frame.size.width, horseTrackImageView.frame.origin.y, horseTrackImageView.frame.size.width, horseTrackImageView.frame.size.height);
        sideLineImageView.frame = CGRectMake(horseTrackImageView.frame.origin.x, sideLineImageView.frame.origin.y, sideLineImageView.frame.size.width, sideLineImageView.frame.size.height);
    }];
}

-(void)moveHorseImageView:(UIImageView *)horseImageView
{
    horseImageView.frame = CGRectMake(horseImageView.frame.origin.x + horseMoveS, horseImageView.frame.origin.y, horseImageView.frame.size.width, horseImageView.frame.size.height);
}

-(void)showHorseRaceRank
{

    UIView * rankBGView = [[[UIView alloc] initWithFrame:CGRectMake(0, sideLineImageView.frame.origin.y, sideLineImageView.frame.size.width, 0)] autorelease];
    [windowButton addSubview:rankBGView];
    rankBGView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:RANKBLACK_ALPHA];
    rankBGView.tag = 99;
    
    [UIView animateWithDuration:1 animations:^{
        rankBGView.frame = CGRectMake(0, sideLineImageView.frame.origin.y, sideLineImageView.frame.size.width, sideLineImageView.frame.size.height + horseTrackImageView.frame.size.height);
    } completion:^(BOOL finished) {
        NSArray * titleArray = @[@"第一名",@"第二名",@"第三名",@"第四名",@"第五名"];
        
        for (int i = 0; i < 5; i++) {
            UIView * rankView = [[UIView alloc] initWithFrame:CGRectMake(120, 11 + i * 46.5, 120, 35)];
            rankView.backgroundColor = [UIColor clearColor];
            [rankBGView addSubview:rankView];
            rankView.alpha = 0;
            [rankView release];
            
            UIImageView * rankTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 120, 28)];
            rankTitleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HorseRank%d.png",i + 1]];
            [rankView addSubview:rankTitleImageView];
            [rankTitleImageView release];
            
            UILabel * rankTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 28)];
            rankTitleLabel.text = [titleArray objectAtIndex:i];
            rankTitleLabel.textColor = [UIColor whiteColor];
            [rankTitleImageView addSubview:rankTitleLabel];
            rankTitleLabel.backgroundColor = [UIColor clearColor];
            rankTitleLabel.textAlignment = 1;
            [rankTitleLabel release];
            
            UIImageView * horseHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(rankTitleImageView) - 32.5, 0, 32.5, 32.5)];
            horseHeadImageView.image = [UIImage imageNamed:@"HorseHead.png"];
            [rankView addSubview:horseHeadImageView];
            [horseHeadImageView release];
            
            NSInteger headNumber = 20 - [[finishGameArray objectAtIndex:i] integerValue] + 1;
            
            UILabel * horseHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.5, 18, 17, 12)];
            horseHeadLabel.textColor = [UIColor whiteColor];
            horseHeadLabel.textAlignment = 1;
            horseHeadLabel.font = [UIFont systemFontOfSize:12];
            horseHeadLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:headNumber]];
            if (headNumber < 10) {
                horseHeadLabel.text = [NSString stringWithFormat:@"0%@",[NSNumber numberWithInteger:headNumber]];
            }
            [horseHeadImageView addSubview:horseHeadLabel];
            horseHeadLabel.backgroundColor = [UIColor clearColor];
            [horseHeadLabel release];
            
            [UIView animateWithDuration:0.8 delay:0.1 * i options:nil animations:^{
                rankView.frame = CGRectMake(35, rankView.frame.origin.y, rankView.frame.size.width, rankView.frame.size.height);
                rankView.alpha = 1;
            } completion:^(BOOL finished) {
                if (i == 4) {
                    [self performSelector:@selector(raceFinish) withObject:nil afterDelay:2.5];
                    [UIView animateWithDuration:0.01 delay:2.5 options:nil animations:^{
                        rankView.frame = CGRectMake(35.01, rankView.frame.origin.y, rankView.frame.size.width, rankView.frame.size.height);
                    } completion:^(BOOL finished) {
                        [rankBGView removeFromSuperview];
                    }];
                }
            }];
        }
    }];
}

-(void)raceFinish
{
    if (raceTimer) {
        [raceTimer invalidate];
        self.raceTimer = nil;
    }

    [self closeRacecourse];
    
    sideLineImageView.hidden = YES;
    sideLineImageView1.hidden = YES;
    
    mainScrollView.frame = CGRectMake(0, 40.5  + (20 - isIOS7Pianyi), self.mainView.frame.size.width, self.mainView.frame.size.height - topView.frame.size.height + 9.5);
    
    gameShowing = NO;
    
    lotteryNumberView.frame = CGRectMake(lotteryNumberView.frame.origin.x, topView.frame.size.height, lotteryNumberView.frame.size.width, lotteryNumberView.frame.size.height);
    [UIView animateWithDuration:SHOW_LOTTER_NUM animations:^{
        lotteryNumberView.frame = CGRectMake(lotteryNumberView.frame.origin.x, 0, lotteryNumberView.frame.size.width, lotteryNumberView.frame.size.height);
        topPlayTypeLabel.frame = CGRectMake(topPlayTypeLabel.frame.origin.x, -topView.frame.size.height, topPlayTypeLabel.frame.size.width, topPlayTypeLabel.frame.size.height);
    } completion:^(BOOL finished) {
        topPlayTypeLabel.text = @"等待开奖";
    }];
    
    racecourseBlackButton.layer.masksToBounds = YES;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (gameShowing) {
        topImageScrollView.contentOffset = CGPointMake(0, 82);
        topViewScrollView.contentOffset = CGPointMake(0, 164);
        blackView.alpha = TITLEBLACK_ALPHA;
        if (mainScrollView.contentOffset.y <= 164) {
            mainScrollView.contentOffset = CGPointMake(0, 164);
        }
    }else if (mainScrollView.contentOffset.y >= 0) {
        if (mainScrollView.contentOffset.y <= 164) {
            topImageScrollView.contentOffset = CGPointMake(0, mainScrollView.contentOffset.y/2);
            topViewScrollView.contentOffset = CGPointMake(0, mainScrollView.contentOffset.y);
        }else{
            //        topImageScrollView.contentOffset = CGPointMake(0, 109.5);
            topImageScrollView.contentOffset = CGPointMake(0, 82);
            topViewScrollView.contentOffset = CGPointMake(0, 164);
        }
        if (mainScrollView.contentOffset.y <= TITLEBLACK_ALPHA * 100) {
            blackView.alpha = mainScrollView.contentOffset.y/100;
        }else{
            blackView.alpha = TITLEBLACK_ALPHA;
        }
    }else{
        topImageScrollView.contentOffset = CGPointZero;
        topViewScrollView.contentOffset = CGPointZero;
        blackView.alpha = 0;
    }
}

-(void)horseStartRun
{
    [self showRacecourse];
    
    UIImageView * readyShineImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(windowButton.frame.size.width, 200, 141.5, 45)] autorelease];
    [windowButton addSubview:readyShineImageView];
    
    UIImageView * readyImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((readyShineImageView.frame.size.width - 134.5)/2, (readyShineImageView.frame.size.height - 36.5)/2, 134.5, 36.5)] autorelease];
    readyImageView.image = UIImageGetImageFromName(@"HorseReady.png");
    [readyShineImageView addSubview:readyImageView];
    
    UIImageView * goShineImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((windowButton.frame.size.width - 119)/2, 200, 119, 49.5)] autorelease];
    goShineImageView.hidden = YES;
    goShineImageView.image = UIImageGetImageFromName(@"HorseGoShine1.png");
    [windowButton addSubview:goShineImageView];
    
    UIImageView * goImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((goShineImageView.frame.size.width - 119)/2, (goShineImageView.frame.size.height - 48.5)/2, 119, 48.5)] autorelease];
    goImageView.image = UIImageGetImageFromName(@"HorseGo.png");
    [goShineImageView addSubview:goImageView];
    
    goShineImageView.transform = CGAffineTransformMake(0.9, 0, 0, 0.9, 0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        readyShineImageView.frame = CGRectMake((windowButton.frame.size.width - readyShineImageView.frame.size.width)/2, readyShineImageView.frame.origin.y, readyShineImageView.frame.size.width, readyShineImageView.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0 delay:0.32 options:nil animations:^{
            readyShineImageView.image = UIImageGetImageFromName(@"HorseReadyShine1.png");
            readyShineImageView.frame = CGRectMake((windowButton.frame.size.width - readyShineImageView.frame.size.width)/2 - 0.01, readyShineImageView.frame.origin.y, readyShineImageView.frame.size.width, readyShineImageView.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0 delay:0.16 options:nil animations:^{
                readyShineImageView.frame = CGRectMake((windowButton.frame.size.width - readyShineImageView.frame.size.width)/2 - 0.01, readyShineImageView.frame.origin.y, readyShineImageView.frame.size.width, readyShineImageView.frame.size.height);
//                readyShineImageView.image = UIImageGetImageFromName(@"HorseReadyShine2.png");
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0 delay:0.2 options:nil animations:^{
                    readyShineImageView.frame = CGRectMake((windowButton.frame.size.width - readyShineImageView.frame.size.width)/2 - 0.01, readyShineImageView.frame.origin.y, readyShineImageView.frame.size.width, readyShineImageView.frame.size.height);
//                    readyShineImageView.hidden = YES;
                    [readyShineImageView removeFromSuperview];
                } completion:^(BOOL finished) {
                    goShineImageView.hidden = NO;
                    [UIView animateWithDuration:0.16 animations:^{
                        goShineImageView.frame = CGRectMake(goShineImageView.frame.origin.x + 0.01, goShineImageView.frame.origin.y, goShineImageView.frame.size.width, goShineImageView.frame.size.height);
                        goShineImageView.transform = CGAffineTransformMake(1.1, 0, 0, 1.1, 0, 0);
                        
                    } completion:^(BOOL finished) {
                        goShineImageView.image = UIImageGetImageFromName(@"HorseGoShine2.png");
                        [UIView animateWithDuration:0.12 animations:^{
                            goShineImageView.frame = CGRectMake(goShineImageView.frame.origin.x + 0.01, goShineImageView.frame.origin.y, goShineImageView.frame.size.width, goShineImageView.frame.size.height);
                            
                            goShineImageView.transform = CGAffineTransformIdentity;
                            
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.28 delay:0.24 options:nil animations:^{
                                goShineImageView.image = nil;
                                
                                goShineImageView.frame = CGRectMake(goShineImageView.frame.origin.x + 10, goShineImageView.frame.origin.y, goShineImageView.frame.size.width, goShineImageView.frame.size.height);
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.08 animations:^{
                                    goShineImageView.frame = CGRectMake(-goShineImageView.frame.size.width, goShineImageView.frame.origin.y, goShineImageView.frame.size.width, goShineImageView.frame.size.height);
                                } completion:^(BOOL finished) {
                                    [goShineImageView removeFromSuperview];
                                    [self horseRace1];
                                    [self performSelectorOnMainThread:@selector(moveHorseTrack) withObject:nil waitUntilDone:YES];

                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

-(void)horseRace1
{
    self.raceTimer = [NSTimer timerWithTimeInterval:PinLv target:self selector:@selector(horseRace) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.raceTimer forMode:NSRunLoopCommonModes];
}

-(void)showRacecourse
{
    racecourseShowing = YES;
    
    sideLineImageView1.hidden = YES;
    racecourseBlackButton.hidden = NO;
    racecourseImageView.hidden = NO;
    
    racecourseBlackButton.frame = CGRectMake(racecourseBlackButton.frame.origin.x, racecourseBlackButton.frame.origin.y, racecourseBlackButton.frame.size.width, windowButton.frame.size.height - ORIGIN_Y(sideLineImageView));
    
    [UIView animateWithDuration:1 animations:^{
        racecourseImageView.frame = CGRectMake(0, 0, racecourseImageView.frame.size.width, racecourseImageView.frame.size.height);
    } completion:^(BOOL finished) {
        racecourseBlackButton.layer.masksToBounds = NO;
    }];
    
    windowButton.userInteractionEnabled = YES;
}

-(void)closeRacecourse
{
    sideLineImageView1.hidden = NO;
    racecourseImageView.hidden = YES;
    racecourseBlackButton.hidden = YES;
    racecourseBlackButton.layer.masksToBounds = YES;

    windowButton.userInteractionEnabled = NO;

    racecourseShowing = NO;
}

-(void)windowButton
{
    if (racecourseShowing == YES) {
        [self closeRacecourse];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pressMenu:(UIButton *)menuButton
{
    NSMutableArray * allimage = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [allimage addObject:@"GC_sanjiJiFen.png"];
    [allimage addObject:@"GC_sanjiMyTouZhu.png"];
    [allimage addObject:@"GC_sanjilishi.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    
    NSMutableArray * alltitle = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [alltitle addObject:@"我的积分"];
    [alltitle addObject:@"我的投注"];
    [alltitle addObject:@"历史开奖"];
    [alltitle addObject:@"玩法说明"];
    
    caiboAppDelegate * app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
    CP_ThreeLevelNavigationView * menuView = [[[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle] autorelease];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    [menuView show];
}

- (void)returnSelectIndex:(NSInteger)index{
    
    if (index == 0) {
        canStopRunLoop = NO;
        MyPointViewController * myPointViewController = [[[MyPointViewController alloc] init] autorelease];
        [self.navigationController pushViewController:myPointViewController animated:YES];
    }
    else if (index == 1) {
        canStopRunLoop = NO;
        MyLottoryViewController * my = [[[MyLottoryViewController alloc] init] autorelease];
        my.userName = [[Info getInstance] userName];
        my.myLottoryType = MyLottoryTypeHorse;
        my.jiekou = HorseHistory;
        my.title = @"我的投注";
        [self.navigationController pushViewController:my animated:YES];
    }
    else if (index == 2) {
         [self toHistory];
    }
    else if (index == 3) {
        [self wanfaInfo];
    }
}

-(void)toHistory
{
    canStopRunLoop = NO;
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId = LOTTERY_ID_SHANDONG_11;
    controller.lotteryName = Lottery_Name_Horse;

    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)wanfaInfo {
    canStopRunLoop = NO;
    Xieyi365ViewController *xie= [[[Xieyi365ViewController alloc] init] autorelease];
    xie.ALLWANFA = Horse;
    [self.navigationController pushViewController:xie animated:YES];
}

-(NSInteger)getBetsByBetsNumber:(NSString *)betsNumber lotteryType:(LotteryTYPE)lotteryType
{
    if (lotteryType == TYPE_11XUAN5_1) {
        return [[betsNumber componentsSeparatedByString:@","] count];
    }
    return [GC_LotteryUtil getBets:betsNumber LotteryType:lotteryType ModeType:M11XUAN5fushi];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && aloneWinArray.count) {
        return aloneWinArray.count;
    }
    else if (section == 1 && consecutiveWinArray.count) {
        return consecutiveWinArray.count;
    }
    else if (section == 2 && aloneTArray.count) {
        return aloneTArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cell";
    HorseRaceTableViewCell * cell = (HorseRaceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[HorseRaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    float cellHeight = 0;

    if (indexPath.row == 0) {
        cell.titleLabel.text = [betsTitleArray objectAtIndex:indexPath.section];
        cell.descriptionLabel.text = [betsContentArray objectAtIndex:indexPath.section];
        
        cellHeight = BETS_CELL_HEIGHT_0;
        
        if ((indexPath.section == 0 && aloneWinArray.count) || (indexPath.section == 1 && consecutiveWinArray.count) || (indexPath.section == 2 && aloneTArray.count)) {
            cell.descriptionLabel.frame = CGRectMake(cell.descriptionLabel.frame.origin.x, 7, cell.descriptionLabel.frame.size.width, 11);
            cell.descriptionLabel.font = [UIFont systemFontOfSize:9];
        }else{
            cell.descriptionLabel.frame = CGRectMake(cell.descriptionLabel.frame.origin.x, 0, cell.descriptionLabel.frame.size.width, cellHeight);
            cell.descriptionLabel.font = [UIFont systemFontOfSize:12];
        }

        cell.lotteryNumView.frame = CGRectMake(cell.lotteryNumView.frame.origin.x, ORIGIN_Y(cell.descriptionLabel) + 5, cell.lotteryNumView.frame.size.width, cell.lotteryNumView.frame.size.height);
        
        cell.titleLabel.superview.hidden = NO;
        cell.descriptionLabel.hidden = NO;
        cell.lotteryNumView.hidden = YES;
    }else{
        
        cell.titleLabel.superview.hidden = YES;
        cell.descriptionLabel.hidden = YES;
        cell.lotteryNumView.hidden = NO;
        
        cellHeight = BETS_CELL_HEIGHT;
        
        cell.lotteryNumView.frame = CGRectMake(cell.lotteryNumView.frame.origin.x, 10, cell.lotteryNumView.frame.size.width, cell.lotteryNumView.frame.size.height);
    }

    if ((indexPath.section == 0 && (!aloneWinArray.count || indexPath.row == aloneWinArray.count - 1)) || (indexPath.section == 1 && (!consecutiveWinArray.count || indexPath.row == consecutiveWinArray.count - 1)) || (indexPath.section == 2 && (!aloneTArray.count || indexPath.row == aloneTArray.count - 1))) {
        cell.line.frame = CGRectMake(cell.line.frame.origin.x, cellHeight - cell.line.frame.size.height, cell.line.frame.size.width, cell.line.frame.size.height);
    }else{
        cell.line.frame = CGRectMake(cell.descriptionLabel.frame.origin.x, cellHeight - cell.line.frame.size.height, cell.contentView.frame.size.width - cell.descriptionLabel.frame.origin.x, cell.line.frame.size.height);
    }
    
    if (indexPath.section == 0 && aloneWinArray.count) {
        [cell setLotteryNumberByString:[aloneWinArray objectAtIndex:indexPath.row]];
        cell.fenLabel.text = [NSString stringWithFormat:@"%@积分",[NSNumber numberWithInteger:[self getBetsByBetsNumber:[aloneWinArray objectAtIndex:indexPath.row] lotteryType:TYPE_11XUAN5_1] * 2]];
    }
    else if (indexPath.section == 1 && consecutiveWinArray.count) {
        [cell setLotteryNumberByString:[consecutiveWinArray objectAtIndex:indexPath.row]];
        cell.fenLabel.text = [NSString stringWithFormat:@"%@积分",[NSNumber numberWithInteger:[self getBetsByBetsNumber:[consecutiveWinArray objectAtIndex:indexPath.row] lotteryType:TYPE_11XUAN5_Q2ZU] * 2]];
    }
    else if (indexPath.section == 2 && aloneTArray.count) {
        [cell setLotteryNumberByString:[aloneTArray objectAtIndex:indexPath.row]];
        cell.fenLabel.text = [NSString stringWithFormat:@"%@积分",[NSNumber numberWithInteger:[self getBetsByBetsNumber:[aloneTArray objectAtIndex:indexPath.row] lotteryType:TYPE_11XUAN5_Q3ZU] * 2]];
    }
    cell.myIndexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = 0;
    
    return cell;
}

-(void)deleteLotteryNumberWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [aloneWinArray removeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        [consecutiveWinArray removeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 2) {
        [aloneTArray removeObjectAtIndex:indexPath.row];
    }
    if (aloneWinArray.count || consecutiveWinArray.count || aloneTArray.count) {
        betButton.enabled = YES;
    }else{
        betButton.enabled = NO;
    }
    [betsTableView reloadData];
    [self resetBetsTableViewFrameWithType:0];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return BETS_CELL_HEIGHT_0;
    }
    return BETS_CELL_HEIGHT;
}

- (void)hasLogin {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    [btn addTarget:self action:@selector(pressMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
}

-(void)addBetNumber:(UIButton *)button
{
    if ([playMethodButton.titleLabel.text isEqualToString:@"玩法"]) {
        [self showPlayMethodAlert];
    }else{
        if (aloneWinArray.count + consecutiveWinArray.count + aloneTArray.count + playMethodTypeArr.count > 10) {
            caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
            [app showMessage:@"最多只能添加10组号码"];
            return;
        }
        
        NSMutableArray * oldSelectedBetsArray = [[[NSMutableArray alloc] initWithArray:selectedBetsArray] autorelease];
        
        [self getSelectedNumber];
        
        if ([playMethodButton.titleLabel.text isEqualToString:@"多玩法"]) {
            for (int i = 0; i < playMethodTypeArr.count; i++) {
                NSString * typeStr = [playMethodTypeArr objectAtIndex:i];
                [self addSelectedStringByString:typeStr];
            }
        }else {
            [self addSelectedStringByString:playMethodButton.titleLabel.text];
        }
        
        [self resetBetsTableViewFrameWithType:1];
        [betsTableView reloadData];
        
//        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
//        [app showMessage:@"添加成功"];
        
        UIView * finishBGView = [[[UIView alloc] initWithFrame:CGRectMake(0, shuZiBetsView.frame.origin.y, betsBGView.frame.size.width, betsBGView.frame.size.height - shuZiBetsView.frame.origin.y)] autorelease];
        finishBGView.backgroundColor = [UIColor clearColor];
        [betsBGView addSubview:finishBGView];
        
        for (int i = 0; i < oldSelectedBetsArray.count; i++) {
            GCBallView * horseBallView = (GCBallView *)[shuZiBetsView viewWithTag:[[oldSelectedBetsArray objectAtIndex:i] intValue] - 1];
            horseBallView.selected = NO;

            UIImageView * fakeHorse = [[UIImageView alloc] initWithFrame:horseBallView.frame];
            fakeHorse.image = UIImageGetImageFromName(@"HorseBetButton_1.png");
            [finishBGView addSubview:fakeHorse];
            [fakeHorse release];
            [finishBGView sendSubviewToBack:fakeHorse];
            
            UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(fakeHorse.frame.size.width - 55, fakeHorse.frame.size.height - 34, 50, 25)];
            numLabel.backgroundColor = [UIColor clearColor];
            numLabel.font = [UIFont systemFontOfSize:28];
            numLabel.textColor = [SharedMethod getColorByHexString:@"f2ff60"];
            numLabel.text = horseBallView.numLabel.text;
            [fakeHorse addSubview:numLabel];
            [numLabel release];
            
            [UIView animateWithDuration:0.7 delay:0.08 * i options:nil animations:^{
                fakeHorse.frame = CGRectMake(i * fakeHorse.frame.size.width * 0.2 - 15, shuZiBetsView.frame.size.height + playMethodButton.frame.size.height + 15, fakeHorse.frame.size.width, fakeHorse.frame.size.height);
                fakeHorse.transform = CGAffineTransformMake(0.3, 0, 0, 0.3, 0, 0);
                fakeHorse.alpha = 0;
            } completion:^(BOOL finished) {
                if (i == oldSelectedBetsArray.count - 1) {
                    [finishBGView removeFromSuperview];
//                    [shuZiBetsView clearSelectedBallView];
                    [selectedBetsArray removeAllObjects];
                    [playMethodButton setTitle:@"玩法" forState:UIControlStateNormal];
                    [playMethodTypeArr removeAllObjects];
                    
                    addButton.enabled = NO;
                    playMethodButton.enabled = NO;
                    
                    if (aloneWinArray.count || consecutiveWinArray.count || aloneTArray.count) {
                        betButton.enabled = YES;
                    }else{
                        betButton.enabled = NO;
                    }
                }
            }];
        }
    }
}


-(void)addSelectedStringByString:(NSString *)str
{
    if ([str isEqualToString:@"独赢"]) {
        [aloneWinArray addObject:selectedString];
    }
    else if ([str isEqualToString:@"连赢"]) {
        [consecutiveWinArray addObject:selectedString];
    }
    else if ([str isEqualToString:@"单T"]) {
        [aloneTArray addObject:selectedString];
    }
}

-(void)resetBetsTableViewFrameWithType:(int)type
{
    float betsTableViewHeight = 0;
    if (aloneWinArray.count) {
        betsTableViewHeight += BETS_CELL_HEIGHT_0 + (aloneWinArray.count - 1) * BETS_CELL_HEIGHT;
    }else{
        betsTableViewHeight += BETS_CELL_HEIGHT_0;
    }
    if (consecutiveWinArray.count) {
        betsTableViewHeight += BETS_CELL_HEIGHT_0 + (consecutiveWinArray.count - 1) * BETS_CELL_HEIGHT;
    }else{
        betsTableViewHeight += BETS_CELL_HEIGHT_0;
    }
    if (aloneTArray.count) {
        betsTableViewHeight += BETS_CELL_HEIGHT_0 + (aloneTArray.count - 1) * BETS_CELL_HEIGHT;
    }else{
        betsTableViewHeight += BETS_CELL_HEIGHT_0;
    }
    
    betsTableView.frame = CGRectMake(betsTableView.frame.origin.x, betsTableView.frame.origin.y, betsTableView.frame.size.width, betsTableViewHeight);
    betButton.frame = CGRectMake(betButton.frame.origin.x, ORIGIN_Y(betsTableView) + 15, betButton.frame.size.width, betButton.frame.size.height);
    betListBGView.frame = CGRectMake(betListBGView.frame.origin.x, betListBGView.frame.origin.y, betListBGView.frame.size.width, ORIGIN_Y(betButton) + 15);
//    betsBGView.frame = CGRectMake(betsBGView.frame.origin.x, ORIGIN_Y(betsTableView), betsBGView.frame.size.width, betsBGView.frame.size.height);
    mainScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(betListBGView) + (20 - isIOS7Pianyi));
//    if (type != 0) {
//        mainScrollView.contentOffset = CGPointMake(0, mainScrollView.contentSize.height - mainScrollView.frame.size.height);
//    }
}

-(void)getPointInfo
{
    NSMutableData *postData2 = [[GC_HttpService sharedInstance] chouCiShuWithUserId:[[Info getInstance] userName]];
    [self.getJiFenRequest clearDelegatesAndCancel];
    self.getJiFenRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [getJiFenRequest setRequestMethod:@"POST"];
    [getJiFenRequest addCommHeaders];
    [getJiFenRequest setPostBody:postData2];
    [getJiFenRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [getJiFenRequest setDelegate:self];
    [getJiFenRequest setDidFinishSelector:@selector(reqGetJiFenFinished:)];
    [getJiFenRequest startAsynchronous];
}

- (void)reqGetJiFenFinished:(ASIHTTPRequest*)request {
    
    if(![request.responseString isEqualToString:@"fail"])
    {
        LotteryNum *jiexi = [[[LotteryNum alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
        if (jiexi.returnId != 3000) {
            [[Info getInstance] setJifen:jiexi.jifen];
            [[Info getInstance] setChoujiangXiaohao:jiexi.xiaohao_once];
            
            if (betAlert) {
                UILabel * jiFen = (UILabel *)[betAlert viewWithTag:10];
                ColorView * yuE = (ColorView *)[betAlert viewWithTag:50];
                
                NSString * yuEString = [[Info getInstance] jifen];
                NSString * newString = @"";
                if ([yuEString length] < 4) {
                    for (int i = 0; i < (4 - (long long)[yuEString length]); i++) {
                        newString = [newString stringByAppendingString:@"  "];
                    }
                    yuEString = [NSString stringWithFormat:@"%@%@",newString,yuEString];
                }
                
                if (![[Info getInstance] jifen]) {
                    yuEString = @"        ";
                }
                yuEString = [NSString stringWithFormat:@"余额：<%@>积分",yuEString];
                CGSize yuESize = [yuEString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
                
                yuE.frame = CGRectMake(296 - yuESize.width - 0.5, ORIGIN_Y(jiFen) + 5, yuESize.width, 16);
                yuE.text = yuEString;
            }
        }
    }
}

- (void)getIssue{
    if (isAppear) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:LOTTERY_ID_SHANDONG_11];
        
        [getIssueRequest clearDelegatesAndCancel];
        self.getIssueRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [getIssueRequest setRequestMethod:@"POST"];
        [getIssueRequest addCommHeaders];
        [getIssueRequest setPostBody:postData];
        [getIssueRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [getIssueRequest setDelegate:self];
        [getIssueRequest setDidFinishSelector:@selector(getIssueFinished:)];
        [getIssueRequest setDidFailSelector:@selector(getIssueFailed:)];
        [getIssueRequest startAsynchronous];
    }
}

- (void)getIssueFailed:(ASIHTTPRequest*)request {
    
}

- (void)getIssueFinished:(ASIHTTPRequest*)request {
    if ([request responseData]) {
        
        IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        
        if ([issrecord.curIssue intValue] == 0) {
            [countdownTimer invalidate];
            self.countdownTimer = nil;
            topIssueLabel.text = @"当日截期";
            [issrecord release];
            return;
        }
        else {
//            image1BackView.hidden = NO;
        }
        yanchiTime = [issrecord.lotteryStatus intValue];
        if ([self.issue length] && ![self.issue isEqualToString:issrecord.curIssue] && isAppear == YES) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@场已截止>\n当前场是%@场，投注时请注意场次",[SharedMethod getLastTwoStr:self.issue],[SharedMethod getLastTwoStr:issrecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.alertTpye = jieQiType;
            [alert show];
            [alert release];
        }
        
        self.issue = issrecord.curIssue;
        if ([[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
            if ([issrecord.curIssue longLongValue] - [[[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0] longLongValue] >= 2 && [[SharedMethod getLastTwoStr:[[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0]] intValue] != 78) {
                isKaiJiang = NO;

                if (canRefreshYiLou) {
//                    [self changeTitle];
                    [self clearYiLou];

                    hasYiLou = NO;
                }
            }
            else {
                isKaiJiang = YES;
                
                if (![myIssrecord isEqualToString:issrecord.curIssue]) {

                    [self getYilou];
                }else if (!hasYiLou && canRefreshYiLou) {
                    [self getYilou];
                }
                canRefreshYiLou = YES;
                
                self.myIssrecord = issrecord.curIssue;
            }
        }
        
        newLotteryNumber = [issrecord.lastLotteryNumber copy];

        NSArray * issueArray = [issrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if (issueArray.count && !topIssueLabel.text) {
            topIssueLabel.text = [NSString stringWithFormat:@"%@场",[SharedMethod getLastTwoStr:[issueArray objectAtIndex:0]]];
        }
        
//        topIssueLabel.text = [NSString stringWithFormat:@"%@场",[SharedMethod getLastTwoStr:issrecord.curIssue]];
        
        if (issueArray.count > 1) {
            NSArray * lotteryNumberArray = [[issueArray objectAtIndex:1] componentsSeparatedByString:@","];
            for (int i = 0; i < lotteryNumberArray.count; i++) {
                UILabel * horseNumLabel = (UILabel *)[lotteryNumberView viewWithTag:i + 10];
                horseNumLabel.text = [lotteryNumberArray objectAtIndex:i];
            }
        }
        
        topNextIssueLabel.text = [NSString stringWithFormat:@"距%@场截止",[SharedMethod getLastTwoStr:issrecord.curIssue]];
        countdownLabel.text = [NSString stringWithFormat:@"%02d:%02d",seconds/60,seconds%60];
        NSArray *array = [issrecord.remainingTime componentsSeparatedByString:@":"];
        if ([array count] == 3) {
            seconds = 60*[[array objectAtIndex:1]intValue]+[[array objectAtIndex:2] intValue];
            if (seconds%2 == 1) {
                seconds = seconds + 1;
            }
            [countdownTimer invalidate];
            self.countdownTimer = nil;
            [self createTimer];
        }
        
        [issrecord release];
    }else{
        [self clearYiLou];
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
}

-(void)clearYiLou
{
    self.yilouDic = nil;
    [self addYiLouByDicKey:nil typeStr:nil horseType:horse_q1];
    [self addYiLouByDicKey:nil typeStr:nil horseType:horse_q2];
    [self addYiLouByDicKey:nil typeStr:nil horseType:horse_q3];
    
    if (yiLouTimer) {
        [yiLouTimer invalidate];
        self.yiLouTimer = nil;
    }

}

- (void)getYilou {
    [self clearYiLou];
    
//    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID_SHANDONG_11];
    
//    if([yilou_Dic objectForKey:self.issue]){
//        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
//        return;
//    }
    
    [self.yilouRequest clearDelegatesAndCancel];
    if (!myIssrecord) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID_SHANDONG_11 itemNum:@"1" issue:nil]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID_SHANDONG_11 itemNum:@"1" issue:nil cacheable:YES]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(rebuyFail:)];
    [yilouRequest startAsynchronous];
}

- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    
    NSString *responseStr = [request responseString];
    if (responseStr && ![responseStr isEqualToString:@"fail"] && [responseStr length]) {
        
        NSDictionary * responseDic = [responseStr JSONValue];
        
        NSArray * resultArray = [responseDic objectForKey:@"list"];
        
        if (resultArray.count) {
            self.yilouDic = [resultArray objectAtIndex:0];
            if ([[yilouDic objectForKey:@"rt"] count]) {
                
                //删除旧的遗漏值
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID_SHANDONG_11];
//                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
//                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID_SHANDONG_11];
                
                hasYiLou = YES;
//                if (showYiLou) {
//                    [self upDateYiLou];
//                }
                [self addYiLouByDicKey:@"qet" typeStr:@"一" horseType:horse_q1];
                [self addYiLouByDicKey:@"qet" typeStr:@"zs" horseType:horse_q2];
                [self addYiLouByDicKey:@"qst" typeStr:@"zs" horseType:horse_q3];

                [yiLouTimer invalidate];
                self.yiLouTimer = nil;
                [self createYiLouTimer];
                
            }else{
                hasYiLou = NO;
                [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
                [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
            }
        }else{
            hasYiLou = NO;
            [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
            [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
        }
        
    }else{
        [self clearYiLou];
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
}

- (void)rebuyFail:(ASIHTTPRequest *)mrequest{
    
    self.showYiLou = NO;
//    if (loadview) {
//        [loadview stopRemoveFromSuperview];
//        loadview = nil;
//    }
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}

- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    if ([[yilouDic objectForKey:@"rt"] count]) {
        
        hasYiLou = YES;
        
//        if (showYiLou) {
//            [self upDateYiLou];
//        }
    }else{
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    
//    [self changeTitle];
    
}


-(void)addYiLouByDicKey:(NSString *)dicKey typeStr:(NSString *)typeStr horseType:(HorseType)horseType
{
    NSMutableArray * sortArr;
    int arrayCount = 0;
    NSMutableDictionary * numberDic = nil;
    numberDic = [[[NSMutableDictionary alloc] initWithDictionary:[[self.yilouDic objectForKey:dicKey] objectForKey:typeStr]] autorelease];
    arrayCount = (int)numberDic.count;
    
    sortArr = [NSMutableArray array];
    for (int i = 0; i < numberDic.count; i++) {
        NSString * key = @"";
        if (i + 1 < 10) {
            key = [NSString stringWithFormat:@"0%d",i + 1];
        }else{
            key = [NSString stringWithFormat:@"%d",i + 1];
        }
        [sortArr addObject:[[numberDic objectForKey:key] valueForKey:@"yl"]];
    }
    NSString * maxNum = [NSString stringWithFormat:@"%@",[[SharedMethod getSortedArrayByArray:sortArr] lastObject]];
    for (GCBallView *ball in shuZiBetsView.subviews) {
        if ([ball isKindOfClass:[GCBallView class]] && ball.tag < 100) {
            if (!dicKey) {
                ball.maxYiLouTag = @"";
            }
            
            ColorView * yilouColorView = (ColorView *)[ball.ylLable viewWithTag:horseType];
            yilouColorView.changeColor = [SharedMethod getColorByHexString:@"5da335"];
            yilouColorView.textColor = [SharedMethod getColorByHexString:@"5da335"];
            yilouColorView.text = @"  <->";
            
            NSString * titleStr = @"";
            if (horseType == horse_q1) {
                titleStr = @"力";
            }else if (horseType == horse_q2) {
                titleStr = @"速";
            }else if (horseType == horse_q3) {
                titleStr = @"耐";
            }
            
            if (arrayCount != 0) {
                if (ball.tag < arrayCount) {
                    NSString * textStr = @"";
                    if (ball.tag + 1 < 10) {
                        textStr = [[numberDic objectForKey:[NSString stringWithFormat:@"0%d",(int)ball.tag + 1]] valueForKey:@"yl"];
                    }else{
                        textStr = [[numberDic objectForKey:[NSString stringWithFormat:@"%d",(int)ball.tag + 1]] valueForKey:@"yl"];
                    }
                    if ([maxNum intValue] == [textStr intValue]) {
                        yilouColorView.changeColor = [SharedMethod getColorByHexString:@"ffb129"];
                        yilouColorView.textColor = [SharedMethod getColorByHexString:@"ffb129"];
                        if (ball.maxYiLouTag) {
                            ball.maxYiLouTag = [ball.maxYiLouTag stringByAppendingString:@";"];
                        }
                        ball.maxYiLouTag = [ball.maxYiLouTag stringByAppendingString:[NSString stringWithFormat:@"%d",horseType]];
                    }
                    yilouColorView.text = [NSString stringWithFormat:@"%@ <%@>",titleStr,textStr];
                }
            }
        }
    }
}

-(void)getSelectedNumber
{
    [selectedBetsArray removeAllObjects];
    selectedString = @"";
    
    for (int i = 0; i < 11; i++) {
        GCBallView * horseBtn = (GCBallView *)[shuZiBetsView viewWithTag:i];
        if (horseBtn.selected) {
            [selectedBetsArray addObject:horseBtn.numLabel.text];
            if ([selectedString length]) {
                selectedString = [selectedString stringByAppendingString:@","];
            }
            selectedString = [selectedString stringByAppendingString:horseBtn.numLabel.text];
        }
    }

}

-(void)showPlayMethodAlert
{
//    [self getSelectedNumber];
    
    NSString * msg = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:selectedBetsArray.count]];
    if (playMethodTypeArr.count) {
        for (int i = 0; i < playMethodTypeArr.count; i++) {
            if (i == 0) {
                msg = [msg stringByAppendingString:@";"];
            }else{
                msg = [msg stringByAppendingString:@","];
            }
            msg = [msg stringByAppendingString:[playMethodTypeArr objectAtIndex:i]];
        }
    }
    
    CP_UIAlertView * pMAlert = [[[CP_UIAlertView alloc] initWithTitle:@"玩法选择" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil] autorelease];
    pMAlert.delegate = self;
    pMAlert.alertTpye = horseRaceType;
    pMAlert.tag = 10;
    [pMAlert show];
}

-(void)showBettingConfirmAlert
{
    if ([[[Info getInstance] userId] intValue] == 0) {
        canStopRunLoop = NO;
        LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        if (![[Info getInstance] jifen]) {
            [self getPointInfo];
        }
        
        [self getTotalBets];

        NSString * msg = @"";
        if (aloneWinArray.count) {
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"独赢    %@注  %@积分",[NSNumber numberWithInteger:aloneWinBets],[NSNumber numberWithInteger:aloneWinBets * 2]]];
            betInfo.wanFa = @"01";
        }
        if (consecutiveWinArray.count) {
            betInfo.wanFa = @"11";
            if (aloneWinArray.count) {
                msg = [msg stringByAppendingString:@","];
                betInfo.wanFa = @"0";
            }
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"连赢    %@注  %@积分",[NSNumber numberWithInteger:consecutiveWinBets],[NSNumber numberWithInteger:consecutiveWinBets * 2]]];
        }
        if (aloneTArray.count) {
            betInfo.wanFa = @"12";
            if (aloneWinArray.count || consecutiveWinArray.count) {
                msg = [msg stringByAppendingString:@","];
                betInfo.wanFa = @"0";
            }
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"单T     %@注  %@积分",[NSNumber numberWithInteger:aloneTBets],[NSNumber numberWithInteger:aloneTBets * 2]]];
        }
        
        msg = [msg stringByAppendingString:[NSString stringWithFormat:@";%d",totalBets]];
        
        betInfo.issue = issue;
        
        betAlert = [[CP_UIAlertView alloc] initWithTitle:@"投注信息确认" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        betAlert.delegate = self;
        betAlert.alertTpye = horseRaceType;
        betAlert.tag = 11;
        [betAlert show];
        [betAlert.alertBgButton addTarget:self action:@selector(touchBetAlert) forControlEvents:UIControlEventTouchUpInside];
        
        CP_PTButton * betAddButton = (CP_PTButton *)[[betAlert viewWithTag:333] viewWithTag:20];
        [betAddButton addTarget:self action:@selector(changeBei:) forControlEvents:UIControlEventTouchUpInside];
        
        CP_PTButton * betJianButton = (CP_PTButton *)[[betAlert viewWithTag:333] viewWithTag:30];
        [betJianButton addTarget:self action:@selector(changeBei:) forControlEvents:UIControlEventTouchUpInside];
       
        keyCount = 0;
        betAlert.gckeyView.delegate = self;

    }
}

-(void)touchBetAlert
{
    if (betAlert.isShowingKeyboard == YES) {
        UIButton * keyButton = (UIButton *)[betAlert viewWithTag:40];
        [betAlert showKeyboard:keyButton];
    }
}

-(void)getTotalBets
{
    aloneWinBets = 0;
    if (aloneWinArray.count) {
        for (NSString * aloneWinNumber in aloneWinArray) {
            aloneWinBets += [self getBetsByBetsNumber:aloneWinNumber lotteryType:TYPE_11XUAN5_1];
        }
    }
    
    consecutiveWinBets = 0;
    if (consecutiveWinArray.count) {
        for (NSString * consecutiveWinNum in consecutiveWinArray) {
            consecutiveWinBets += [self getBetsByBetsNumber:consecutiveWinNum lotteryType:TYPE_11XUAN5_Q2ZU];
        }
    }
    
    aloneTBets = 0;
    if (aloneTArray.count) {
        for (NSString * aloneTNumber in aloneTArray) {
            aloneTBets += [self getBetsByBetsNumber:aloneTNumber lotteryType:TYPE_11XUAN5_Q3ZU];
        }
    }
    totalBets = aloneWinBets + consecutiveWinBets + aloneTBets;
}

- (void)pressbgbutton:(UIButton *)sender{
    [betAlert.myTextField resignFirstResponder];
}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    
}


- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{
    
    if (sender == 11) {
        betAlert.isShowingKeyboard = NO;
        [betAlert.gckeyView dissKeyFunc];
        if([betAlert.myTextField.text isEqualToString:@"0"]||[betAlert.myTextField.text isEqualToString:@""]){
            betAlert.myTextField.text = @"1";
        }
    }
    else if (sender == 10) {
        betAlert.myTextField.text = [NSString stringWithFormat:@"%d",[betAlert.myTextField.text intValue]/10];
        if ([betAlert.myTextField.text isEqualToString:@"0"]||[betAlert.myTextField.text isEqualToString:@""]) {
            betAlert.myTextField.text = @"1";
            keyCount = 0;
        }
    }else{
        if ([betAlert.myTextField.text isEqualToString:@"1"] && sender) {
            if (keyCount) {
                betAlert.myTextField.text = [NSString stringWithFormat:@"%d",[betAlert.myTextField.text intValue] * 10 + (int)sender];
            }else{
                betAlert.myTextField.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:sender]];
                keyCount = 1;
            }
        }else{
            betAlert.myTextField.text = [NSString stringWithFormat:@"%d",[betAlert.myTextField.text intValue] * 10 + (int)sender];
        }
    }
    if ([betAlert.myTextField.text intValue] > 99) {
        betAlert.myTextField.text = @"99";
    }
    
    UILabel * jiFenLabel = (UILabel *)[[betAlert viewWithTag:333] viewWithTag:10];
    
    NSString * jiFenString = [NSString stringWithFormat:@"%d",totalBets * 2 * [betAlert.myTextField.text intValue]];
    NSString * newString = @"";
    if ([jiFenString length] < 4) {
        for (int i = 0; i < (4 - (long long)[jiFenString length]); i++) {
            newString = [newString stringByAppendingString:@"  "];
        }
        jiFenString = [NSString stringWithFormat:@"%@%@",newString,jiFenString];
    }
    jiFenLabel.text = [NSString stringWithFormat:@"应付：%@积分",jiFenString];
}

-(void)changeBei:(CP_PTButton *)button
{
    if (button.tag == 20) {
        betAlert.myTextField.text = [NSString stringWithFormat:@"%d",[betAlert.myTextField.text intValue] + 1];
    }else{
        betAlert.myTextField.text = [NSString stringWithFormat:@"%d",[betAlert.myTextField.text intValue] - 1];
        if ([betAlert.myTextField.text isEqualToString:@"1"]) {
            keyCount = 0;
        }
    }
    if ([betAlert.myTextField.text intValue] <= 0) {
        betAlert.myTextField.text = @"1";
        keyCount = 0;
    }else if ([betAlert.myTextField.text intValue] > 99) {
        betAlert.myTextField.text = @"99";
    }
    
    UILabel * jiFenLabel = (UILabel *)[[betAlert viewWithTag:333] viewWithTag:10];
    
    NSString * jiFenString = [NSString stringWithFormat:@"%d",totalBets * 2 * [betAlert.myTextField.text intValue]];
    NSString * newString = @"";
    if ([jiFenString length] < 4) {
        for (int i = 0; i < (4 - (long long)[jiFenString length]); i++) {
            newString = [newString stringByAppendingString:@"  "];
        }
        jiFenString = [NSString stringWithFormat:@"%@%@",newString,jiFenString];
    }
    jiFenLabel.text = [NSString stringWithFormat:@"应付：%@积分",jiFenString];
}



- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 && buttonIndex == 1) {
        [playMethodTypeArr removeAllObjects];
        for (UIButton * button in [[alertView viewWithTag:333] subviews]) {
            if ([button isKindOfClass:[UIButton class]] && button.selected) {
                [playMethodTypeArr addObject:button.titleLabel.text];
            }
        }
        if (playMethodTypeArr.count == 0) {
            [playMethodButton setTitle:@"玩法" forState:UIControlStateNormal];
        }
        else if (playMethodTypeArr.count == 1) {
            [playMethodButton setTitle:[playMethodTypeArr objectAtIndex:0] forState:UIControlStateNormal];
        }else {
            [playMethodButton setTitle:@"多玩法" forState:UIControlStateNormal];
        }
    }
    else if (alertView.tag == 13) {
        [aloneWinArray removeAllObjects];
        [consecutiveWinArray removeAllObjects];
        [aloneTArray removeAllObjects];
        
        
        [betsTableView reloadData];
        betButton.enabled = NO;
        [self resetBetsTableViewFrameWithType:0];
        
        [[Info getInstance] setJifen:nil];
        [self getPointInfo];
    }
    else if (alertView.tag == 11) {
        if (betAlert.isShowingKeyboard == YES) {
            [betAlert.gckeyView dissKeyFunc];
        }
        if (buttonIndex == 1) {
            
            NSString * jifen = [[Info getInstance] jifen];
            
            betInfo.caiZhong = LOTTERY_ID_SHANDONG_11;
            betInfo.beiShu = betAlert.myTextField.text;
            
            int payJifen = totalBets * 2 * [betInfo.beiShu intValue];
            betInfo.payJiFen = [NSString stringWithFormat:@"%d",payJifen];
            
            if ([jifen intValue] < payJifen) {
                CP_UIAlertView * pMAlert = [[[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起，您的积分不足，无法支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"赚取积分",nil] autorelease];
                pMAlert.delegate = self;
                pMAlert.alertTpye = horseRaceType;
                pMAlert.tag = 12;
                [pMAlert show];
                
            }
            else{
                [self toBet];
            }
        }
    }else if (alertView.tag == 12 && buttonIndex == 1) {
        [self goBuy];
    }else if (alertView.tag == 15 && buttonIndex == 1) {
        [self toBet];
    }
}

-(void)toBet
{
    if (![betInfo.issue isEqualToString:issue]) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@场已截止，当前只能投注%@场，是否继续投注？",betInfo.issue,issue] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        betInfo.issue = issue;
        alert.tag = 15;
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString * lotteryNumber = @"";
    BOOL isDuo = YES;
    
    NSInteger betsNumLength = 0;
    
    for (int i = 0; i < aloneWinArray.count; i++) {
        NSString * betsNumber = [[aloneWinArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        if (!betsNumLength) {
            betsNumLength = [betsNumber length];
        }
        if (betsNumLength != [betsNumber length] || isDuo == NO || [betInfo.wanFa isEqualToString:@"0"]) {
            if (i && isDuo == YES) {
                i = 0;
                lotteryNumber = @"";
                betsNumber = [[aloneWinArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            isDuo = NO;
            
            betsNumber = [betsNumber stringByAppendingString:@"-01"];
            if ([betsNumber length] > 5) {
                betsNumber = [betsNumber stringByAppendingString:@":02"];
            }else{
                betsNumber = [betsNumber stringByAppendingString:@":01"];
            }
            if ([lotteryNumber length]) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@";"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            betInfo.touZhu = @"0";
        }else{
            if (lotteryNumber.length) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@"^"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            if ([betsNumber length] > 2) {
                betInfo.touZhu = @"02";
            }else{
                betInfo.touZhu = @"01";
            }
        }
    }
    
    isDuo = YES;
    betsNumLength = 0;
    
    for (int i = 0; i < consecutiveWinArray.count; i++) {
        NSString * betsNumber = [[consecutiveWinArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        if (!betsNumLength) {
            betsNumLength = [betsNumber length];
        }
        if (betsNumLength != [betsNumber length] || isDuo == NO || [betInfo.wanFa isEqualToString:@"0"]) {
            if (i && isDuo == YES) {
                i = 0;
                lotteryNumber = @"";
                betsNumber = [[consecutiveWinArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            isDuo = NO;
            
            betsNumber = [betsNumber stringByAppendingString:@"-11"];
            if ([betsNumber length] > 7) {
                betsNumber = [betsNumber stringByAppendingString:@":02"];
            }else{
                betsNumber = [betsNumber stringByAppendingString:@":01"];
            }
            if ([lotteryNumber length]) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@";"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            betInfo.touZhu = @"0";
        }else{
            if (lotteryNumber.length) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@"^"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            if ([betsNumber length] > 4) {
                betInfo.touZhu = @"02";
            }else{
                betInfo.touZhu = @"01";
            }
        }
    }
    
    isDuo = YES;
    betsNumLength = 0;
    
    for (int i = 0; i < aloneTArray.count; i++) {
        NSString * betsNumber = [[aloneTArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        if (!betsNumLength) {
            betsNumLength = [betsNumber length];
        }
        if (betsNumLength != [betsNumber length] || isDuo == NO || [betInfo.wanFa isEqualToString:@"0"]) {
            if (i && isDuo == YES) {
                i = 0;
                lotteryNumber = @"";
                betsNumber = [[aloneTArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            isDuo = NO;
            
            betsNumber = [betsNumber stringByAppendingString:@"-12"];
            if ([betsNumber length] > 9) {
                betsNumber = [betsNumber stringByAppendingString:@":02"];
            }else{
                betsNumber = [betsNumber stringByAppendingString:@":01"];
            }
            if ([lotteryNumber length]) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@";"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            betInfo.touZhu = @"0";
        }else{
            if (lotteryNumber.length) {
                lotteryNumber = [lotteryNumber stringByAppendingString:@"^"];
            }
            lotteryNumber = [lotteryNumber stringByAppendingString:betsNumber];
            if ([betsNumber length] > 6) {
                betInfo.touZhu = @"02";
            }else{
                betInfo.touZhu = @"01";
            }
        }
    }
    
    if ([lotteryNumber rangeOfString:@";"].location !=NSNotFound) {
        lotteryNumber = [lotteryNumber stringByAppendingString:@";"];
    }
    betInfo.betNumber = lotteryNumber;
    betInfo.guoGuan = @"";
    betInfo.peiLv = @"";
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqJiFenBuyJiFenInfo:betInfo];
    [betRequest clearDelegatesAndCancel];
    self.betRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [betRequest setRequestMethod:@"POST"];
    [betRequest addCommHeaders];
    [betRequest setPostBody:postData];
    [betRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [betRequest setDelegate:self];
    [betRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
    [betRequest setDidFailSelector:@selector(reqBuyLotteryFail:)];
    [betRequest startAsynchronous];
    
}

- (void)goBuy
{
    
    if (1||[[GC_HttpService sharedInstance].sessionId length] || [[[Info getInstance] userId] intValue] == 0) {
        
        GouCaiViewController *gou = [[GouCaiViewController alloc] init];
        gou.title = @"购买彩票";
        GouCaiViewController *gou2 = [[GouCaiViewController alloc] init];
        gou2.title = @"购买彩票";
        gou2.fistPage = 1;
        
        GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
        hemaiinfotwo.hmdtBool = YES;
        hemaiinfotwo.paixustr = @"ADC";
        hemaiinfotwo.goucaibool = YES;
        
        NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:gou, gou2, hemaiinfotwo, nil];
        NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
        [labearr addObject:@"数字彩"];
        [labearr addObject:@"足篮彩"];
        [labearr addObject:@"合买大厅"];
        
        NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
        [imagestring addObject:@"goucaishuzibai.png"];
        [imagestring addObject:@"goucaizubai.png"];
        [imagestring addObject:@"goucaihemaibai.png"];
        
        NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
        [imageg addObject:@"tabbg_shuzi.png"];
        [imageg addObject:@"tabbg_zulan.png"];
        [imageg addObject:@"tabbg_hemai.png"];
        
        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
        
        CP_TabBarViewController * tabarvc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
        tabarvc.goucaibool = YES;
        tabarvc.showXuanZheZhao = YES;
        tabarvc.selectedIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultBuy"] intValue];
        tabarvc.delegateCP = self;
        
        tabarvc.navigationController.navigationBarHidden = YES;
        tabarvc.backgroundImage.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
        [self.navigationController pushViewController:tabarvc animated:YES];
        
        [tabarvc release];
        [imagestring release];
        [labearr release];
        [imageg release];
        [controllers release];
        [gou release];
        [gou2 release];
        [hemaiinfotwo release];
    }else{
        
        [self activityIndicatorViewshow];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(maicaipiaotongzhi) name:@"hasGetsession_id" object:nil];
    }
}

- (void)activityIndicatorViewshow{
    
    statepop = [StatePopupView getInstance];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [statepop showInView:appDelegate.window Text:@"请稍等..."];
    appDelegate.isloginIng = NO;
    appDelegate.loginselfcount = 0;
    [appDelegate LogInBySelf];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissstatepop) name:@"dissmisspop" object:nil];
    //if ([[GC_HttpService sharedInstance].sessionId length]) {
    //[statepop dismiss];//去掉转圈
}

- (void)dissmissstatepop{
    [statepop dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
}

- (void)maicaipiaotongzhi{
    [statepop dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)reqBuyLotteryFail:(ASIHTTPRequest*)request
{
    CP_UIAlertView * pMAlert = [[[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"投注失败，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道啦",nil] autorelease];
    pMAlert.delegate = self;
    pMAlert.alertTpye = horseRaceType;
    pMAlert.tag = 14;
    [pMAlert show];
}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        
        JiFenBuyLotteryData * buyResult = [[[JiFenBuyLotteryData alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
        
        if ([buyResult.returnValue isEqualToString:@"0000"]) {
            CP_UIAlertView * pMAlert = [[[CP_UIAlertView alloc] initWithTitle:@"恭喜您" message:@"购买成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道啦",nil] autorelease];
            pMAlert.delegate = self;
            pMAlert.alertTpye = horseRaceType;
            pMAlert.tag = 13;
            [pMAlert show];
        }else{
            CP_UIAlertView * pMAlert = [[[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"投注失败，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道啦",nil] autorelease];
            pMAlert.delegate = self;
            pMAlert.alertTpye = horseRaceType;
            pMAlert.tag = 14;
            [pMAlert show];
        }
//        if (buyResult.returnValue == resalut) {
//            [multipleTF resignFirstResponder];
//            if (resalut == 1) {
//                if ([[UIApplication sharedApplication] canOpenURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]]) {
//                    isGoBuy = YES;
//                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
//                    [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
//                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];
//                    [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
//                }
//                
//            }
//            else {
//                [MobClick event:@"event_goumai_chenggong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
//                
//                CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
//                alert.buyResult = buyResult;
//                alert.delegate = self;
//                [alert show];
//                [alert release];
//                
//            }
//            
//            
//        } else if (buyResult.returnValue == 4) {
//            self.sysIssure = buyResult.curIssure;
//            if ([betInfo.betlist count] > 1) {
//                
//                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"当期期号过期提示" message:@"请重新设置追号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                alert.shouldRemoveWhenOtherAppear = YES;
//                alert.tag = 103;
//                [alert show];
//                [alert release];
//            }
//            else {
//                if ([self.sysIssure length] == 0) {
//                    
//                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"此彩种已经截期" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    alert.shouldRemoveWhenOtherAppear = YES;
//                    alert.tag = 0;
//                    [alert show];
//                    [alert release];
//                }
//                else {
//                    
//                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@期已截止，当前只能投注%@期，是否继续投注？",self.betInfo.issue,self.sysIssure] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//                    alert.shouldRemoveWhenOtherAppear = YES;
//                    alert.tag = 104;
//                    [alert show];
//                    [alert release];
//                }
//                
//            }
//            
//            
//        }
//#ifdef isYueYuBan
//        else  if(buyResult.returnValue == 2){
//            
//            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//            alert.shouldRemoveWhenOtherAppear = YES;
//            alert.tag = 109;
//            [alert show];
//            [alert release];
//            
//        }
//        else if (buyResult.returnValue == 10) {
//            
//            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//            alert.shouldRemoveWhenOtherAppear = YES;
//            alert.tag = 105;
//            [alert show];
//            [alert release];
//        }
//#else
//#endif
//        else{
//            [[caiboAppDelegate getAppDelegate] showMessage:@"投注失败"];
//        }
//        
    }
    
}


- (void)doLogin {
    canStopRunLoop = NO;
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isAppear = YES;
    canStopRunLoop = YES;
    
    if ([[[Info getInstance] userId] intValue] && ![[Info getInstance] jifen]) {
        [self getPointInfo];
    }
    
    [self performSelector:@selector(getIssue)];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    isAppear = NO;

    if (canStopRunLoop) {
        if (countdownTimer) {
            [countdownTimer invalidate];
            self.countdownTimer = nil;
        }
        
        if (yiLouTimer) {
            [yiLouTimer invalidate];
            self.yiLouTimer = nil;
        }
        
        if (raceTimer) {
            [raceTimer invalidate];
            self.raceTimer = nil;
        }
        
        if (gameShowing) {
            [self raceFinish];
        }
    }
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getIssue) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
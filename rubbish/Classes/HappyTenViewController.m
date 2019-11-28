//
//  HappyTenViewController.m
//  caibo
//
//  Created by yaofuyu on 13-4-9.
//
//

#import "HappyTenViewController.h"

#import "caiboAppDelegate.h"
#import "Info.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GC_LotteryUtil.h"
#import "ShakeView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_LotteryUtil.h"
#import "GC_IssueInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "MobClick.h"
#import "ssqyiloutuViewController.h"
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"
#import "SharedMethod.h"
#import "UpLoadView.h"
#import "ChartDefine.h"
#import "YiLouChartData.h"
#import "ChartFormatData.h"
#import "ChartTitleScrollView.h"
#import "ChartYiLouScrollView.h"

#define LOTTERY_ID @"011"

#define COLORLABEL_HIGHT 20

@interface HappyTenViewController ()

@end

@implementation HappyTenViewController
@synthesize lotterytype;
@synthesize modetype;
@synthesize myRequest;
@synthesize qihaoReQuest;
@synthesize issue;
//@synthesize wangQi;
@synthesize myTimer;
@synthesize zhongJiang;
@synthesize runTimer;
@synthesize yilouRequest;
@synthesize yilouDic;
@synthesize myIssrecord;
@synthesize yiLouDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        wanArray = [[NSArray alloc] initWithObjects:@"选一数投",@"选一红投",@"任选二",@"选二连直",@"选二连组",@"任选三",@"选三前直",@"选三前组",@"任选四",@"任选五",@"猜大数",@"猜单数",@"猜全数",@"任选二胆拖",@"任选三胆拖",@"任选四胆拖",@"任选五胆拖",@"选二连组胆拖",@"选三前组胆拖",nil];
        modetype = HappyTenRen3;
        lotterytype = TYPE_HappyTen;
        NSInteger type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"HappyTenDefaultModetype"] integerValue];
        if (HappyTen1Shu <= type && HappyTenRen3ZuDanTuo >= type) {
            modetype = (int)type;
        }
        isVerticalBackScrollView = YES;
        self.cpLotteryName = kuaileshifenType;
        yanchiTime = 90;
        self.headHight = DEFAULT_ISSUE_HEIGHT + 1;
        
        hasYiLou = NO;
        canRefreshYiLou = YES;
    }
    return  self;
}

- (void)dealloc {
    [editeView removeFromSuperview];
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    self.myIssrecord = nil;
//    self.wangQi = nil;
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.zhongJiang = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [descriptionLabel release];
    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    [loadview release];
    [yiLouDataArray release];
    
    [titleYiLou release];
    [redraw release];

    [seepLabel release];
    [super dealloc];
}

- (NSString *)changeModetypeToString:(ModeTYPE)mode {
//    int a = 0,b = 0;

    if (SWITCH_ON) {
//        a = 50;
//        b = 10;
    }
    descriptionLabel.frame = CGRectMake(60, 85, 250, 20);

    if (mode == HappyTen1Shu) {
        descriptionLabel.text = @"至少选1个号";
        return @"选一数投";
    }
    else if (mode == HappyTen1Hong){
        descriptionLabel.text = @"选一个红号（19和20为红号）";
        return @"选一红投";
    }
    else if (mode == HappyTenRen2){
        descriptionLabel.text = @"至少选2个号";
        return @"任选二";
    }
    else if (mode == HappyTenRen2Zhi){
        descriptionLabel.text = @"至少选1个号";
        descriptionLabel.frame = CGRectMake(60, 85 + COLORLABEL_HIGHT, 250, 20);
        return @"选二连直";
    }
    else if (mode == HappyTenRen2Zu){
        descriptionLabel.text = @"至少选2个号";
        return @"选二连组";
    }
    else if (mode == HappyTenRen3){
        descriptionLabel.text = @"至少选3个号";
        return @"任选三";
    }
    else if (mode == HappyTenRen3Zhi){
        descriptionLabel.text = @"至少选1个号";
        return @"选三前直";
    }
    else if (mode == HappyTenRen3Zu){
        descriptionLabel.text = @"至少选3个号";
        descriptionLabel.frame = CGRectMake(60, 85 + COLORLABEL_HIGHT, 250, 20);
        return @"选三前组";
    }
    else if (mode == HappyTenRen4){
        descriptionLabel.text = @"至少选4个号";
        return @"任选四";
    }
    else if (mode == HappyTenRen5){
        descriptionLabel.text = @"至少选5个号";
        return @"任选五";
    }
    else if (mode == HappyTenDa){
        descriptionLabel.text = @"";
        return @"猜大数";
    }
    else if (mode == HappyTenDan){
        descriptionLabel.text = @"";
        return @"猜单数";
    }
    else if (mode == HappyTenQuan){
        descriptionLabel.text = @"";
        return @"猜全数";
    }
    else if (mode == HappyTenRen2DanTuo){
        descriptionLabel.text = @"我认为必出的号码选1个";
        return @"任选二胆拖";
    }
    else if (mode == HappyTenRen3DanTuo){
        descriptionLabel.text = @"我认为必出的号码至少选1个,最多2个";
        return @"任选三胆拖";
    }
    else if (mode == HappyTenRen4DanTuo){
        descriptionLabel.text = @"我认为必出的号码至少选1个,最多3个";
        return @"任选四胆拖";
    }
    else if (mode == HappyTenRen5DanTuo){
        descriptionLabel.text = @"我认为必出的号码至少选1个,最多4个";
        return @"任选五胆拖";
    }
    else if (mode == HappyTenRen2ZuDanTuo){
        descriptionLabel.text = @"我认为必出的号码选1个";
        return @"选二连组胆拖";
    }
    else if (mode == HappyTenRen3ZuDanTuo){
        descriptionLabel.text = @"我认为必出的号码至少选1个,最多2个";
        return @"选三前组胆拖";
    }
    
    return nil;
}

-(ModeTYPE)changeStringToMode:(NSString *)str {
    if ([str isEqualToString:@"选一红投"]) {
        return HappyTen1Hong;
    }
    else if ([str isEqualToString:@"任选二"]){
        return HappyTenRen2;
    }
    else if ([str isEqualToString:@"选二连直"]){
        return HappyTenRen2Zhi;
    }
    else if ([str isEqualToString:@"选二连组"]){
        return HappyTenRen2Zu;
    }
    else if ([str isEqualToString:@"任选三"]){
        return HappyTenRen3;
    }
    else if ([str isEqualToString:@"选三前直"]){
        return HappyTenRen3Zhi;
    }
    else if ([str isEqualToString:@"选三前组"]){
        return HappyTenRen3Zu;
    }
    else if ([str isEqualToString:@"任选四"]){
        return HappyTenRen4;
    }
    else if ([str isEqualToString:@"任选五"]){
        return HappyTenRen5;
    }
    else if ([str isEqualToString:@"猜大数"]){
        return HappyTenDa;
    }
    else if ([str isEqualToString:@"猜单数"]){
        return HappyTenDan;
    }
    else if ([str isEqualToString:@"猜全数"]){
        return HappyTenQuan;
    }
    else if ([str isEqualToString:@"任选二胆拖"]){
        return HappyTenRen2DanTuo;
    }
    else if ([str isEqualToString:@"选二连组胆拖"]){
        return HappyTenRen2ZuDanTuo;
    }
    else if ([str isEqualToString:@"任选三胆拖"]){
        return HappyTenRen3DanTuo;
    }
    else if ([str isEqualToString:@"选三前组胆拖"]){
        return HappyTenRen3ZuDanTuo;
    }
    else if ([str isEqualToString:@"任选四胆拖"]){
        return HappyTenRen4DanTuo;
    }
    else if ([str isEqualToString:@"任选五胆拖"]){
        return HappyTenRen5DanTuo;
    }
    return HappyTen1Shu;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    isAppear = NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
    [self.runTimer invalidate];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
	self.runTimer = nil;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getIssueInfo) object:nil];
    if (entRunLoopRef) {
        CFRunLoopStop(entRunLoopRef);
        entRunLoopRef = nil;
    }
    if(isShowing)
    {
        [alert2 removeFromSuperview];
        [self addNavAgain];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
    isAppear = YES;
    [self performSelector:@selector(getIssueInfo)];
    [self.runTimer invalidate];
    self.runTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showranLabel) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssueInfo) name:@"BecomeActive" object:nil];
    
}

- (void)LoadIpadView {
    
    backScrollView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height-50);
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 35, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.tag = 789;
    
    UILabel *JTLabel = [[UILabel alloc] init];
    JTLabel.backgroundColor = [UIColor clearColor];
    JTLabel.textAlignment = NSTextAlignmentCenter;
    JTLabel.font = [UIFont systemFontOfSize:12];
    JTLabel.text = @"▼";
    JTLabel.textColor = [UIColor whiteColor];
    JTLabel.shadowColor = [UIColor blackColor];
    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    JTLabel.tag = 567;
    if ([[[Info getInstance] userId] intValue] == 0) {
        titleLabel.frame = CGRectMake(15, 0, 220, 44);
        JTLabel.frame = CGRectMake(169, 1, 20, 44);
    }else {
        
        titleLabel.frame = CGRectMake(32, 0, 220, 44);
        JTLabel.frame = CGRectMake(187, 1, 20, 44);
    }
    [titleView addSubview:JTLabel];
    [JTLabel release];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = titleView.bounds;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(10, 40, 15, 15);
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
	colorLabel = [[ColorView alloc] init];
	colorLabel.frame = CGRectMake(27, 40, 290, 15);
	colorLabel.textColor = [UIColor blackColor];
	colorLabel.font = [UIFont systemFontOfSize:14];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:11];
	colorLabel.backgroundColor = [UIColor clearColor];
	colorLabel.changeColor = [UIColor redColor];
	[backScrollView addSubview:colorLabel];
	colorLabel.text = @"单注奖金<24>元";
    colorLabel.wordWith = 10;
	[colorLabel release];
    
    
    // UIImageView *
    image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115, 13, 195, 60)];
	[backScrollView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
	[image1BackView release];
    
//    UIImageView *sanjiao = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_sanjiao.png")];
//    sanjiao.frame = CGRectMake(172, 14, 11.5, 10);
//    [image1BackView addSubview:sanjiao];
//    [sanjiao release];
    
//    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(135, 20, 165, 24)];
//    [backScrollView addSubview:sqkaijiang];
//    sqkaijiang.changeColor = [UIColor redColor];
//    sqkaijiang.font = [UIFont systemFontOfSize:10];
//    sqkaijiang.backgroundColor = [UIColor clearColor];
//    sqkaijiang.textColor = [UIColor blackColor];
//    sqkaijiang.huanString = @"~";
//    [sqkaijiang release];
    
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 53, 55, 12)];
	[backScrollView addSubview:timeLabel];
    timeLabel.text = self.issue;
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:10];
	[timeLabel release];
	
	
    mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 53, 60, 12)];
	[backScrollView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止还有";
	mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:10];
	[mytimeLabel2 release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 53, 33, 12)];
	[backScrollView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	// mytimeLabel3.font = [UIFont systemFontOfSize:10];
    mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:20];
	[mytimeLabel3 release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 195, 2)];
    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
    [image1BackView addSubview:imageV];
    [imageV release];
	
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
//	btn.frame = CGRectMake(130, 6, 180, 30);
//	[backScrollView addSubview:btn];
    
	NSArray *nameArray = [NSArray arrayWithObjects:@"选一<①>",@"选一<①>",@"一位<①>",@"二位<①>",@"三位<①>",nil];
	for (int i = 0; i<5; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        if ([[nameArray objectAtIndex:i] length]) {
            ColorView *label = [[ColorView alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.text = [nameArray objectAtIndex:i];
            [firstView addSubview:label];
            label.tag = 100;
            label.textColor = [UIColor whiteColor];
            if (i == 1) {
                label.frame = CGRectMake(7, 15+2, 20, 60);
            }
            else {
                label.frame = CGRectMake(7, 25+2, 20, 60);
            }
            
            label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
            label.colorfont = [UIFont boldSystemFontOfSize:14];
            label.jianjuHeight = 3;
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
            firstView.backgroundColor = [UIColor clearColor];
            firstView.frame = CGRectMake(0, 73 + i*90, 320, 130);
            if (i == 0) {
                for (int j = 0; j<18; j++) {
                    int a= j/7,b = j%7;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j+1];
                    if (j< 9) {
                        num = [NSString stringWithFormat:@"0%d",j+1];
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37+35, a*37+7, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                }
            }
            else if (i == 1) {
                for (int j = 0; j<2; j++) {
                    int a= j/7,b = j%7;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 19];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*65+105, a*37+25, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+19;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    firstView.frame = CGRectMake(10, 73 + i*90, 300, 90);
                    [im release];
                }
            }
            else {
                for (int j = 0; j<20; j++) {
                    int a= j/7,b = j%7;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j+1];
                    if (j< 9) {
                        num = [NSString stringWithFormat:@"0%d",j+1];
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37+35, a*37+7, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                }
            }
            
            firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
            firstView.userInteractionEnabled = YES;
            
        }
        else {
            
        }
		[backScrollView addSubview:firstView];
		[firstView release];
	}
    
    zaixianLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 346, 150, 30)];
	zaixianLabel.text = nil;
	zaixianLabel.changeColor = [UIColor redColor];
    zaixianLabel.font = [UIFont systemFontOfSize:10];
    zaixianLabel.colorfont = [UIFont systemFontOfSize:9];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[backScrollView addSubview:zaixianLabel];
	[zaixianLabel release];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 addTarget:self action:@selector(gofenxi) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(340, 0, 50, 50);
    xiimageview = [[UIImageView alloc] initWithFrame:CGRectMake(350, 10, 30, 30)];
    xiimageview.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
    [self.mainView addSubview:xiimageview];
    [self.mainView addSubview:btn2];
    [xiimageview release];
    
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	
	
    //清按钮
    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12 + 35, 10, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52 + 35, 10, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:9];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
	[zhushuLabel release];
	
	UILabel *zhu = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 11)];
	zhu.text = @"注";
	zhu.backgroundColor = [UIColor clearColor];
	zhu.font = [UIFont systemFontOfSize:9];
	zhu.textColor = [UIColor blackColor];
	[zhubg addSubview:zhu];
    [zhu release];
	
	jineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 19, 40, 11)];
	[zhubg addSubview:jineLabel];
	jineLabel.text = @"0";
	jineLabel.font = [UIFont boldSystemFontOfSize:9];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 19, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:9];
	jin.textColor = [UIColor blackColor];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(230 + 35, 7, 80, 33);
	[im addSubview:senBtn];
    
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    senImage.tag = 1108;
    [senBtn addSubview:senImage];
    [senImage release];
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
    senLabel.tag = 1101;
    senLabel.font = [UIFont systemFontOfSize:22];
    [senBtn addSubview:senLabel];
    [senLabel release];
}





- (void)LoadIphoneView {
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:self.CP_navigation.bounds];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.tag = 789;
    
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.tag = 567;
    [titleView addSubview:sanjiaoImageView];
    
    
    
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        titleLabel.frame = CGRectMake(45+10, 0, 20, 44);
//        sanjiaoImageView.frame = CGRectMake(174-50-30, 14, 17, 17);
//    }else {
//        
//        titleLabel.frame = CGRectMake(62+10, 0, 20, 44);
//        sanjiaoImageView.frame = CGRectMake(125-50-30, 14, 17, 17);
//    }
  
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = titleView.bounds;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    
    
    yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame =CGRectMake(15, 53-3, 21, 19);
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
	colorLabel = [[ColorView alloc] init];
//	colorLabel.frame = CGRectMake(27, 60, 100, 15);
    colorLabel.frame = CGRectMake(40, 53, 280, 40);
	colorLabel.font = [UIFont systemFontOfSize:14];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:14];
	colorLabel.backgroundColor = [UIColor clearColor];
    colorLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    colorLabel.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
	[backScrollView addSubview:colorLabel];
	colorLabel.text = @"单注奖金<24>元";
//    colorLabel.wordWith = 10;
	[colorLabel release];
    
    
    //    image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115, 13, 195, 47)];
    image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, TOPVIEW_HEIGHT)];
	[backScrollView addSubview:image1BackView];
    //    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    //    image1BackView.backgroundColor = [UIColor clearColor];
    image1BackView.backgroundColor=[UIColor whiteColor];
    
	image1BackView.layer.masksToBounds = YES;
	[image1BackView release];
 
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(15, 11, 240+5, 15)];
    
    [backScrollView addSubview:sqkaijiang];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];
    
   // timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 36, 55, 23)];//下期期号
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(210+20-3, 0, 55, 17)];//下期期号
	[backScrollView addSubview:timeLabel];
    timeLabel.text = self.issue;
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:7];
	[timeLabel release];
	
   
    
    mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(245+20, 0, 60-20, 17)];
    mytimeLabel2.textAlignment=NSTextAlignmentRight;
	[backScrollView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止";
    mytimeLabel2.textColor = [UIColor blackColor];
	// mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:7];
	[mytimeLabel2 release];
	
    
    mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(225, 17, 80, 20)];
    mytimeLabel3.textAlignment=NSTextAlignmentRight;
    
	[backScrollView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	mytimeLabel3.font = [UIFont systemFontOfSize:18];
    mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:20];

	[mytimeLabel3 release];
	
    
    
    
    
    
    
    
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
//	btn.frame = CGRectMake(130, 6, 180, 30);
//	[backScrollView addSubview:btn];
 
   	NSArray *nameArray = [NSArray arrayWithObjects:@"选一",@"选一",@"一位",@"二位",@"三位",nil];
    CGRect ballRect;

    
    for (int i = 0; i < 7; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        
        ColorView *label;
        UIImageView *seep = nil;
        firstView.userInteractionEnabled = YES;
        if (i < 5) {
            if ([[nameArray objectAtIndex:i] length]) {
                label = [[ColorView alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.changeColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:14];
                label.text = [nameArray objectAtIndex:i];
                [firstView addSubview:label];
                
                label.tag = 100;
                label.textColor = [UIColor whiteColor];
                if (i == 1) {
                    label.frame = CGRectMake(7, 15+5+2, 20, 60);
                }
                else {
                    label.frame = CGRectMake(7, 25+5+2, 20, 60);
                }
                
                //  label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
                label.colorfont = [UIFont boldSystemFontOfSize:14];
                label.jianjuHeight = 1;
                label.textAlignment = NSTextAlignmentCenter;
                [label release];
                firstView.backgroundColor = [UIColor clearColor];
                //   firstView.frame = CGRectMake(10, 93 + i*90, 300, 130);
                
                // 左侧图
                UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
                imaHong.backgroundColor=[UIColor clearColor];
                imaHong.tag=10010;
                imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
                [firstView addSubview:imaHong];
                [imaHong release];
                [firstView addSubview:label];
                label.tag = 100;
                label.textAlignment = NSTextAlignmentCenter;
                label.frame = CGRectMake(11, 0+2, 54, 22);
                
                
                UILabel *describeLabel1 = [[[UILabel alloc] init] autorelease];
                describeLabel1.textColor = [UIColor darkGrayColor];
                describeLabel1.font = [UIFont systemFontOfSize:12];
                describeLabel1.frame = CGRectMake(ORIGIN_X(imaHong) + 5, label.frame.origin.y - 2, 250, 22);
                describeLabel1.backgroundColor = [UIColor clearColor];
                describeLabel1.tag = 888666;
                [firstView addSubview:describeLabel1];
                
                // 漏  Frame: CGRectMake(0, 10+ballRect.size.height+3, 35, 22)
                seep = [[[UIImageView alloc] init] autorelease];
                seep.tag = 88888;
                seep.frame = CGRectMake(0, 75, 20, 17);
                seep.backgroundColor = [UIColor clearColor];
                seep.image = [UIImage imageNamed:@"LeftTitleYilou.png"];
                [firstView addSubview:seep];
                
                seepLabel = [[UILabel alloc] init] ;
                seepLabel.backgroundColor = [UIColor clearColor];
                seepLabel.text = @"漏";
                seepLabel.textAlignment = NSTextAlignmentCenter;
                seepLabel.textColor = [UIColor whiteColor];
                seepLabel.font = [UIFont systemFontOfSize:10];
                seepLabel.frame = seep.bounds;
                [seep addSubview:seepLabel];
                
        }

        }
        if (SWITCH_ON) {
            firstView.frame = CGRectMake(0, 93 + i*150, 320, 180+40);
            //                seep.frame = CGRectMake(0, 75,20 , 17);
            //                seepLabel.frame = CGRectMake(0, 0, 20, 17);
            seep.hidden = NO;
        }else{
            firstView.frame = CGRectMake(0, 93 + i*120, 320, 120+40+60);
            seep.hidden = YES;
            [seep removeFromSuperview];
        }
            if (i == 0) {
                GCBallView *lastBallView1;
                // 球的位置
                for (int j = 0; j<18; j++) {
                    int a= j/6,b = j%6;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j+1];
                    if (j< 9) {
                        num = [NSString stringWithFormat:@"0%d",j+1];
                    }
                    if (SWITCH_ON) {
                        ballRect = CGRectMake(b*51+15, a*52+30+11.5, 35, 35);
                        seep.hidden = NO;
                    }else{
                        ballRect = CGRectMake(b*51+15, a*37+30+11.5, 35, 35);
                        seep.hidden = YES;
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                        seep.hidden = YES;
                    }
                    else
                    {
                        seep.hidden = NO;
                    }
                    im.gcballDelegate = self;
                    lastBallView1 = im;
                    [im release];
                }
               
                if (SWITCH_ON)
                {
                    GifButton * redTrashButton1 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(15, lastBallView1.frame.origin.y+52, 0, 0)] autorelease];
                    redTrashButton1.tag = 333;
                    redTrashButton1.delegate = self;
                    [firstView addSubview:redTrashButton1];
                    seep.hidden = NO;
                }
                else
                {
                    GifButton * redTrashButton1 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(15, lastBallView1.frame.origin.y+40, 0, 0)] autorelease];
                    redTrashButton1.tag = 333;
                    redTrashButton1.delegate = self;
                    [firstView addSubview:redTrashButton1];
                    seep.hidden = YES;
                    
                }
                
                
 
            }
            else if (i == 1) {
                GCBallView *lastBallView2;
                for (int j = 0; j<2; j++) {
                    //                    missingValues.frame = CGRectMake(98.5, 58, 12.5, 12.5);
                    int a= j/7,b = j%7;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 19];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*65+105, a*37+25+13.5, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+19;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                        seep.hidden = YES;
                        [seep removeFromSuperview];
                        
                    }else
                    {
                    
                        seep.hidden = NO;
                    }
                    firstView.frame = CGRectMake(0, 93 + i*90, 320, 90+40);
                    seep.frame = CGRectMake(90, 75, 20, 15);

                    if (SWITCH_ON) {
                       // seepLabel.frame = CGRectMake(0, 0, 20, 17);
                    }
                    else
                    {
                    }
                   

                    lastBallView2 = im;
                    [im release];
                }
                GifButton * redTrashButton2 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView2  ) + 15, lastBallView2.frame.origin.y, 0, 0)] autorelease];
                redTrashButton2.tag = 444;
                redTrashButton2.delegate = self;
                [firstView addSubview:redTrashButton2];
                // firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.userInteractionEnabled = YES;

            }
            else if (i == 5) {
                firstView.frame = CGRectMake(0, 0, 320, 245);
                NSArray *jiangArray = [NSArray arrayWithObjects:@"3200",@"120",@"15",@"5",@"3",@"5",@"15",@"120",@"3200", nil];
//                int Y = 0;
                if (!SWITCH_ON) {
//                    Y = 5;
                }
                
                GCBallView * lastBallView;
                for (int j = 0; j < 9; j++) {
                    int a= j/4,b = j%4;
                    NSString *num = [NSString stringWithFormat:@"%d", 8 - j];
                    CGRect ballRect;
                    if (SWITCH_ON) {
                        ballRect = CGRectMake(15 + b * 74, a * 80, 67, 50);
                    }else{
                        ballRect = CGRectMake(15 + b * 74, a * 55, 67, 50);
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewHappyTenQuan];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.gcballDelegate = self;
                    [im release];
                    
                    im.numLabel2.text =[NSString stringWithFormat:@"￥%@",[jiangArray objectAtIndex:j]];
                    
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastBallView = im;
                }
                GifButton * trashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView) + 22, lastBallView.frame.origin.y + 6, 0, 0)] autorelease];
                trashButton.tag = 333;
                trashButton.delegate = self;
                [firstView addSubview:trashButton];
            }
            else if (i == 6) {
//                int Y = 0;
                if (!SWITCH_ON) {
//                    Y = 5;
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake((320 - 104)/2, 0, 104, 84) Num:[SharedMethod changeFontWithString:@"全数"] ColorType:GCBallViewHappyTenQuan];
                [firstView addSubview:im];
                im.gcballDelegate = self;
                [im release];
                
                im.numLabel.frame = CGRectMake(0, im.numLabel.frame.origin.y, im.frame.size.width, im.numLabel.frame.size.height);
                im.numLabel.textAlignment = 1;
                im.numLabel2.text = @"￥3";
                im.numLabel3.hidden = YES;
                
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
            }
            else {
                
                GCBallView *lastBallView2;
                if (SWITCH_ON) {
                    firstView.frame = CGRectMake(0, 70 + i*120, 320, 230+40);
                    seep.hidden = NO;
                   
                }else{
                    firstView.frame = CGRectMake(0, 70 + i*90, 320, 168+40);
                    seep.hidden = YES;
                }
                // 球的位置
                for (int j = 0; j<20; j++) {
                    int a= j/6,b = j%6;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j+1];
                    if (j< 9) {
                        num = [NSString stringWithFormat:@"0%d",j+1];
                    }
                    if (SWITCH_ON) {
                        ballRect = CGRectMake(b*51+15, a*52+30+11.5, 35, 35);
                    }else{
                        ballRect = CGRectMake(b*51+15, a*37+30+11.5, 35, 35);
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    
                    
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                        seep.hidden = YES;
                  
                    }
                    im.gcballDelegate = self;
                    lastBallView2 = im;
                    [im release];
                }
                GifButton * redTrashButton2 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView2  ) + 15, lastBallView2.frame.origin.y, 0, 0)] autorelease];
                redTrashButton2.tag = 444;
                redTrashButton2.delegate = self;
                [firstView addSubview:redTrashButton2];
                // firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.userInteractionEnabled = YES;
            }
		[backScrollView addSubview:firstView];
        
		[firstView release];
        
        
        // 至少选几个号
        descriptionLabel = [[UILabel alloc] init];
        [backScrollView addSubview:descriptionLabel];
        descriptionLabel.textColor = [UIColor darkGrayColor];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.font = [UIFont systemFontOfSize:12];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.lineBreakMode = 0;
        
    }
 
 
   
    
    zaixianLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 346, 150, 30)];
	zaixianLabel.text = nil;
	zaixianLabel.changeColor = [UIColor redColor];
    zaixianLabel.font = [UIFont systemFontOfSize:10];
    zaixianLabel.colorfont = [UIFont systemFontOfSize:12];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[backScrollView addSubview:zaixianLabel];
	[zaixianLabel release];
    
    
  
    
    
    
    
    
    
    
    // 底部背景
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
	im.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:19/255.0 alpha:1];
    im.userInteractionEnabled = YES;
    [self.view addSubview:im];
	
    
    
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
	[zhushuLabel release];
	
	UILabel *zhu = [[UILabel alloc] initWithFrame:CGRectMake(40, 2.5, 20, 11)];
	zhu.text = @"注";
	zhu.backgroundColor = [UIColor clearColor];
	zhu.font = [UIFont systemFontOfSize:12];
	zhu.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
	[zhubg addSubview:zhu];
    [zhu release];
	
	jineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 17.5, 40, 11)];
	[zhubg addSubview:jineLabel];
	jineLabel.text = @"0";
    jineLabel.textColor = [UIColor whiteColor];
	jineLabel.font = [UIFont boldSystemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor whiteColor];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(235, 7, 80, 30);
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    [senBtn setTitle:@"选好了" forState:UIControlStateDisabled];
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];
    
	[im addSubview:senBtn];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.yiLouViewHight = self.view.frame.size.height - 44 - 44 - isIOS7Pianyi - self.headHight - TOPVIEW_HEIGHT;

    [MobClick event:@"event_goumai_gaopincai_kuaileshifen"];
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimageview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimageview];
    [bgimageview release];
    
    
    
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height-46)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.scrollEnabled = YES;
    [self.mainView addSubview:backScrollView];
    [backScrollView release];
    
    
    seepScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 93 + 85, 35, 22)];
    seepScrollView.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        // @"anniubgimage.png"
        UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
        self.CP_navigation.rightBarButtonItem = right;
    }
    else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //  [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

        btn.frame = CGRectMake(0, 0, 60, 44);
        [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        [rightItem release];
        }
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
    
#else
    [self LoadIphoneView];
#endif
    
    titleBtnIsCanPress = YES;
    
    
    [self changeTitle];
    [self getWangqi];
    [self ballSelectChange:nil];

	// Do any additional setup after loading the view.
}

- (void)changeFrame
{
    if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, _mainView.frame.size.height);
    }else{
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);

        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView));
}


#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

-(void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId =LOTTERY_ID;
    controller.lotteryName = @"快乐十分";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        [MobClick event:@"event_goucai_zoushitu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        self.showYiLou = YES;
        [self changeFrame];
        if ([self.yiLouDataArray count] > 0) {
            [redraw reduction];
            [self createChart];
        }else{
            [self getHappyYilouWithType:2];
        }
    }
    else if (index == 1) {
        [self toHistory];
    }
    else if (index == 2) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self pressTitleButton:nil];
        
    }
    else if (index == 3) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        [self changeTitle];

        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        tln.titleArr = alltitle;
        [alltitle release];
    }
    else if (index == 4) {
        [self wanfaInfo];
    }
}




#pragma mark -switchChange

-(void)switchChange
{
    // [self LoadIphoneView];
    float heght =85;
    int count = 0;
    
    for (int i = 1000;i<1007;i++)
    {
        UIView *v = [backScrollView viewWithTag:i];
        UIImageView *seep = (UIImageView *)[v viewWithTag:88888];
        GifButton *trashButton1 = (GifButton *)[v viewWithTag:333];
        GifButton *trashButton2 = (GifButton *)[v viewWithTag:444];
        v.userInteractionEnabled = YES;
        if (i == 1000)
        {
            if (SWITCH_ON)
                
            {
                v.frame = CGRectMake(0, heght+5, 320, 180);
                seep.hidden = NO;

            }
            else
            {
                v.frame = CGRectMake(0, heght, 320, 130);
                seep.hidden = YES;
            }
            count = 18;
            GCBallView *lastBallView;
            for (int j = 0; j < count; j++)
            {
                int a= j/6,b = j%6;
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j+1 ];
                
                if (SWITCH_ON)
                {
                    ballView.frame = CGRectMake(b*51+15, a*52+28+13.5, 35, 35);
                    ballView.ylLable.hidden = NO;
                    seep.hidden = NO;
                }
                else
                    
                {
                    ballView.frame = CGRectMake(b*51+15, a*37+28+13.5, 35, 35);
                    ballView.ylLable.hidden = YES;
                    seep.hidden = YES;
                }
                
                lastBallView = ballView;
            }

            if (SWITCH_ON) {
                
                trashButton1.frame = CGRectMake(15, lastBallView.frame.origin.y - 8+52, 36, 45);
                seep.hidden = NO;
               
            }else{
                trashButton1.frame = CGRectMake(15, lastBallView.frame.origin.y - 8+37, 36, 45);
                seep.hidden = YES;
                
            }
            
        }
        else if (i == 1001)
        {
            GCBallView *lastBallView;
            for (int j = 18; j < 20; j++)
            {
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j + 1];
                if (SWITCH_ON)
                {
                    ballView.ylLable.hidden = NO;
                    seep.frame = CGRectMake(90, 75, 20, 17);
                    seep.hidden = NO;
                }else
                {
                    ballView.ylLable.hidden = YES;
                    seep.hidden = YES;
                }
               lastBallView = ballView;
           }
            trashButton2.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
        }
        else if (i == 1005)
        {
            GCBallView *lastBallView;
            for (int j = 0; j < 9; j++)
            {
                int a= j/4,b = j%4;
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                
                if (SWITCH_ON)
                {
                    ballView.frame = CGRectMake(15 + b * 74, a * 80, 67, 50);
                    ballView.ylLable.hidden = NO;
                }
                else
                {
                    ballView.frame = CGRectMake(15 + b * 74, a * 55, 67, 50);
                    ballView.ylLable.hidden = YES;
                }
                lastBallView = ballView;
            }
            trashButton1.frame = CGRectMake(ORIGIN_X(lastBallView) + 22, lastBallView.frame.origin.y - 2, 36, 45);
        }
        else if (i == 1006)
        {
            
            GCBallView * ballView = (GCBallView *)[v viewWithTag:0];
            if (SWITCH_ON)
            {
                ballView.ylLable.hidden = NO;
            }
            else
            {
                ballView.ylLable.hidden = YES;
            }

        }
        else
        {
                if (SWITCH_ON)
                {
                    v.frame = CGRectMake(0, heght, 320, 230+40);
                    seep.hidden = NO;
    //                [v viewWithTag:99].hidden = NO;
                }else
                {
                    v.frame = CGRectMake(0, heght, 320, 168+40);
    //                [v viewWithTag:99].hidden = YES;
                    seep.hidden = YES;
                }
                count = 20;
            GCBallView *lastBallView;
            for (int j = 0; j < count; j++)
            {
                int a= j/6,b = j%6;
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j + 1];
                if (SWITCH_ON)
                {
                    ballView.frame = CGRectMake(b*51+15, a*52+28+13.5, 35, 35);
                    ballView.ylLable.hidden = NO;
                    seep.hidden = NO;
                }
                else
                    
                {
                    ballView.frame = CGRectMake(b*51+15, a*37+28+13.5, 35, 35);
                    ballView.ylLable.hidden = YES;
                    seep.hidden = YES;
                }
                
                lastBallView = ballView;
            }
            trashButton2.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
        }
        heght = heght + v.bounds.size.height-1;
    }
}

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
//    if (buttonIndex == 1) {
        self.showYiLou = NO;

    if ([returnarry count] == 1) {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];
        
        NSString *wanfaname = [returnarry objectAtIndex:0];
        NSInteger tag = [wanArray indexOfObject:wanfaname];
        if (tag >= 0 && tag < 100) {
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            sender.tag =tag;
            [self pressBgButton:sender];
        }
        
    }
        
//    }
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender {
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    [SharedMethod sanJiaoGuan:sanjiao];
    
    isShowing = NO;
    [alert2 release];
    [self addNavAgain];
//    self.showYiLou = NO;
}
-(void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView
{
    titleBtnIsCanPress = YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    if(isShowing)
    {
        scrollView.scrollEnabled = NO;
        
        if([alert2 isDescendantOfView:self.mainView])
        {
            
            [alert2 disMissWithPressOtherFrame];
            
            scrollView.scrollEnabled = YES;
            
            
        }
    }
}
-(void)addNavAgain
{
    if (IS_IOS7) {
        self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
    }else{
        self.CP_navigation.frame = CGRectMake(0, 0, 320, 44);
    }
    [self.view addSubview:self.CP_navigation];
    
    titleBtnIsCanPress = YES;

}
#pragma mark -
#pragma mark Action

- (void)gofenxi {
    ssqyiloutuViewController *shiyi = [[ssqyiloutuViewController alloc] init];
    shiyi.yiloutu = kuaiLeShiFenYiLouType;//快乐十分
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:shiyi.view ViewControllor:shiyi];
#else
    [self.navigationController pushViewController:shiyi animated:YES];
    
    
#endif
    [shiyi release];
//    self.showYiLou = YES;
}

- (void)donghuaxizi{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.52f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:xiimageview cache:YES];
    [UIView commitAnimations];
}

- (void)pressMenu {
    if(isShowing)
    {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];
        
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjizoushi.png"];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        
        caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//        if (!tln) {
            tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//        }
        
        tln.delegate = self;
        [self.view addSubview:tln];
        [tln show];
        [tln release];

        
        [allimage release];
        [alltitle release];
    }

}

- (void)timeChange {
    seconds --;
    if (seconds < 0) {
        [self getIssueInfo];
		[self.myTimer invalidate];
		self.myTimer = nil;
        return;
    }
    if (seconds >=0) {
        mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(int)seconds/60,(int)seconds%60];
    }
    
    if(seconds/60 == 0)
    {
        mytimeLabel3.textColor=[UIColor colorWithRed:250.0/255.0 green:108.0/255.0 blue:5.0/255.0 alpha:1];
    }
    else
    {
        mytimeLabel3.textColor=[UIColor blackColor];
    }
    
    
    
    if (!isKaiJiang) {
        colorLabel.text = @"上期等待开奖...";
        if ((seconds <= 600 - yanchiTime && seconds % 5 == 0)) {
            canRefreshYiLou = NO;
            [self getIssueInfo];
        }
    }
}

- (void)showranLabel {
    [self donghuaxizi];
	if ([self.zhongJiang.brInforArray count] != 0) {
        imageruan.alpha = 1;
		runCount = runCount%[self.zhongJiang.brInforArray count];
		ranLabel.alpha = 1;
        ranNameLabel.alpha = 1;
        NSArray *array = [[self.zhongJiang.brInforArray objectAtIndex:runCount] componentsSeparatedByString:@"@"];
        if ([array count] == 2) {
            ranNameLabel.text = [array objectAtIndex:0];
            NSString *info = [array objectAtIndex:1];
            info = [info stringByReplacingOccurrencesOfString:@"奖金共计" withString:@"奖金共计<"];
            info = [info substringToIndex:[info length] -1];
            ranLabel.text = [NSString stringWithFormat:@"%@>元",info];
            
            ranNameLabel.frame = CGRectMake(205, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            ranLabel.frame = CGRectMake(ranNameLabel.frame.origin.x+ranNameLabel.frame.size.width, 5, 260, 16);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            if ([ranNameLabel.text sizeWithFont:ranNameLabel.font].width + 5 + [ranLabel.text sizeWithFont:ranLabel.font].width > 205) {
                ranNameLabel.frame = CGRectMake(200 - [ranNameLabel.text sizeWithFont:ranNameLabel.font].width -[ranLabel.text sizeWithFont:ranLabel.font].width, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            }
            else {
                ranNameLabel.frame = CGRectMake(5, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            }
            ranLabel.frame = CGRectMake(ranNameLabel.frame.origin.x+ranNameLabel.frame.size.width, 5, 260, 16);
            [UIView commitAnimations];
            [self performSelector:@selector(hidenranLabel) withObject:nil afterDelay:2];
            runCount ++;
        }
        
	}
	else {
		ranLabel.frame = CGRectMake(205, 5, 260, 16);
        ranNameLabel.frame = CGRectZero;
	}
    
}

- (void)hidenranLabel {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
	ranNameLabel.alpha = 0;
	ranLabel.alpha = 0;
	[UIView commitAnimations];
}

- (void)quxiaoWanqi {
    editeView.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    editeView.alpha = 0;
    [UIView commitAnimations];
    
}

- (void)getWangqi {
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:LOTTERY_ID countOfPage:5];
    [qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [qihaoReQuest setRequestMethod:@"POST"];
    [qihaoReQuest addCommHeaders];
    [qihaoReQuest setPostBody:postData];
    [qihaoReQuest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [qihaoReQuest setDelegate:self];
    [qihaoReQuest setDidFinishSelector:@selector(reqWangQiKaiJiang:)];
    [qihaoReQuest startAsynchronous];
}

//- (void)showPicker {
//    NSInteger height = 320;
//    if (![self.wangQi.brInforArray count]) {
//        [self getWangqi];
//    }
//    else {
//        KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:0];
//        if ([info.issue intValue] != [self.issue intValue]-1 &&[info.issue intValue] != [self.issue intValue]) {
//            [self getWangqi];
//        }
//        
//    }
//    if (editeView) {
//        editeView.alpha = 1;
//        return;
//    }
//    
//    editeView = [[UIView alloc] initWithFrame:[caiboAppDelegate getAppDelegate].window.bounds];
//    editeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//    UIImageView *backImageV = [[UIImageView alloc] init];
//    backImageV.image = UIImageGetImageFromName(@"TSBG960.png");
//    backImageV.frame = CGRectMake(10, 80, 300, 320);
//    backImageV.center = editeView.center;
//    backImageV.userInteractionEnabled = YES;
//    [editeView addSubview:backImageV];
//    
//    UIImageView *titleImage2 = [[UIImageView alloc] init];
//    titleImage2.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    titleImage2.frame = CGRectMake(22, 38, 256, 143);
//    titleImage2.userInteractionEnabled = YES;
//    [backImageV addSubview:titleImage2];
//    [titleImage2 release];
//    
//    UIImageView *titleImage = [[UIImageView alloc] init];
//    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
//    titleImage.frame = CGRectMake(87.5, 2, 125, 30);
//    //        titleImage.center = CGPointMake(150, 13);
//    [backImageV addSubview:titleImage];
//    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
//    lable.text = @"往期开奖";
//    [titleImage addSubview:lable];
//    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    lable.font = [UIFont boldSystemFontOfSize:12];
//    lable.shadowColor = [UIColor whiteColor];//阴影
//    lable.shadowOffset = CGSizeMake(0, 1.0);
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.backgroundColor = [UIColor clearColor];
//    [lable release];
//    [titleImage release];
//    
//    CP_PTButton *btn1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    [backImageV addSubview:btn1];
//    [btn1 loadButonImage:@"TYD960.png" LabelName:@"取消"];
//    [btn1 addTarget:self action:@selector(quxiaoWanqi) forControlEvents:UIControlEventTouchUpInside];
//    btn1.frame = CGRectMake(30, height - 55, 240, 35);
//    
//    backImageV.frame = CGRectMake(10, 80, 300, height);
//    titleImage2.frame = CGRectMake(22, 38, 256, height - 110);
//    [backImageV release];
//    
//    mytableView = [[UITableView alloc] initWithFrame:titleImage2.frame];
//    [backImageV addSubview:mytableView];
//    mytableView.backgroundColor = [UIColor clearColor];
//    mytableView.dataSource = self;
//    mytableView.delegate = self;
//    [mytableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [mytableView release];
//    
//#ifdef isCaiPiaoForIPad
//    editeView.frame = CGRectMake(0, 0, 390, 748);
//    backImageV.frame = CGRectMake(10 + 35, 180, 300, 320);
//    [self.view addSubview:editeView];
//#else
//    [[caiboAppDelegate getAppDelegate].window addSubview:editeView];
//#endif
//    
//    [editeView release];
//}

- (void)getIssueInfo {
    // 高频：0 数字彩：1 足彩：2 全部：3
    if (isAppear) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:LOTTERY_ID];
        
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myRequest setRequestMethod:@"POST"];
        [myRequest addCommHeaders];
        [myRequest setPostBody:postData];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
        [myRequest setDidFailSelector:@selector(reqLotteryInfoFailed:)];
        [myRequest performSelector:@selector(startAsynchronous) withObject:nil afterDelay:0.1];
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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)clearBalls {
	for (int i = 0; i < 9; i++) {
		UIView *ballView = [backScrollView viewWithTag:1000+i];
		for (GCBallView *ball in ballView.subviews) {
			if ([ball isKindOfClass:[GCBallView class]]) {
				ball.selected = NO;
                [ball chanetoNomore];
			}
		}
	}
	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
	[self ballSelectChange:nil];
}

- (NSString *)seletNumber {
    
	NSString *st = @",", *sr = @"|",* daDan = @";";
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
    for (int i = 0; i < 7; i++) {
        UIView *ballView = [backScrollView viewWithTag:1000+i];
        GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
        GifButton * trashButton2 = (GifButton *)[ballView viewWithTag:444];
        
        if (ballView.hidden == NO) {
            if ([mStr length] > 0) {
                [mStr appendString:sr];
            }
            //NSArray *array = [mSectionArray objectAtIndex:i];
            NSInteger selNum = 0;
            NSMutableString *num = [NSMutableString string];
            for (GCBallView *ball in ballView.subviews) {
                
                if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
                    if (i > 4) {
                        if ([num length]) {
                            [num appendString:daDan];
                        }
                        [num appendString:[SharedMethod changeFontWithString:[NSString stringWithFormat:@"0%@",ball.numLabel.text]]];
                    }else{
                        [num appendString:ball.numLabel.text];
                        [num appendString:st];
                    }
                    selNum += 1;
                
                }
                
            }
            if ([num length]!=0) {
                [mStr appendString:num];
                trashButton.hidden = NO;
                trashButton2.hidden = NO;
            }
            else {
                [mStr appendString:@"e"];
                trashButton.hidden = YES;
                trashButton2.hidden = YES;
            }
            
            
            if (selNum > 0) {
                if (modetype != HappyTenDa && modetype != HappyTenDan && modetype != HappyTenQuan)
                {
                    [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                }
//                trashButton.hidden = NO;
//                trashButton2.hidden = NO;
            }
//            else
//            {
//                trashButton.hidden = YES;
//                trashButton2.hidden = YES;
//            }
            
        }
    }
	return (NSString *)mStr;
}

- (void)send {
    
    
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//        return;
//    }
    
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    
    if ([zhushuLabel.text intValue] < 2 && modetype >= HappyTenRen2DanTuo) {
        int b = 0;
        int d = 0;
        UIView *Rview = [backScrollView viewWithTag:1002];
        UIView *Dview = [backScrollView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                }
            }
            
        }
        if (b < 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择胆码"];
            return;
        }
        if (d< 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择拖码"];
            return;
        }
        int a = 3;
        if (modetype == HappyTenRen2DanTuo || modetype == HappyTenRen2ZuDanTuo) {
            a = 3;
        }
        else if (modetype == HappyTenRen3DanTuo || modetype == HappyTenRen3ZuDanTuo) {
            a = 4;
        }
        else if (modetype == HappyTenRen4DanTuo) {
            a = 5;
        }
        else if (modetype == HappyTenRen5DanTuo) {
            a = 6;
        }
        if (b + d < a) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"胆码+拖码个数不少于%d个。",a]];
            return;
        }
    }
    
    if ([zhushuLabel.text intValue] < 1) {
        NSString *selectNum = [self seletNumber];
        if (modetype == HappyTenRen4) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择4个号码。"];
            return;
        }
        else if (modetype == HappyTenRen5) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择5个号码。"];
            return;
        }else if (modetype == HappyTenRen3 || modetype == HappyTenRen3Zu) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择3个号码。"];
            return;
        }
        else if (modetype == HappyTenRen2 || modetype == HappyTenRen2Zu) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择2个号码。"];
            return;
        }
        else if (modetype == HappyTen1Shu || modetype == HappyTen1Hong) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择1个号码。"];
            return;
        }
        else if (modetype == HappyTenRen2Zhi) {
            NSArray *array = [selectNum componentsSeparatedByString:@"|"];
            if ([array count] >= 2) {
                if ([[array objectAtIndex:0] isEqualToString:@"e"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"前位至少选择1个号码。"];
                }
                else {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"后位至少选择1个号码。"];
                }
            }
            return;
        }
        else if (modetype == HappyTenRen3Zhi) {
            NSArray *array = [selectNum componentsSeparatedByString:@"|"];
            if ([array count] >= 3) {
                if ([[array objectAtIndex:0] isEqualToString:@"e"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"第一位至少选择1个号码。"];
                }
                else if ([[array objectAtIndex:1] isEqualToString:@"e"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"第二位至少选择1个号码。"];
                }
                else {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"第三位至少选择1个号码。"];
                }
            }
            return;
        }
        return;
    }
    
    
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        NSString *selet = [self seletNumber];
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        
        if (modetype >= HappyTenRen2DanTuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            if (modetype == HappyTenDa || modetype == HappyTenDan) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }else{
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
        }
        
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoV.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            [infoV.dataArray addObject:selet];
            
        }
        infoV.lotteryType = lotterytype;
        infoV.modeType = modetype;
        infoV.betInfo.issue = issue;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeHappyTen;
        }
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;

        NSString *selet = [self seletNumber];
        if (modetype >= HappyTenRen2DanTuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            if (modetype == HappyTenDa || modetype == HappyTenDan) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }else{
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
        }
        
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoViewController.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            [infoViewController.dataArray addObject:selet];
        }
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
    
	[self clearBalls];
}


- (void)randBalls {
    if (modetype == HappyTen1Shu ) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:18];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%ld",(long)ball.tag];
                if (ball.tag < 10) {
                    num = [NSString stringWithFormat:@"0%ld",(long)ball.tag];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
            
        }
    }
    
    else if (modetype == HappyTen1Hong) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:19 maxnum:20];
        UIView *v = [backScrollView viewWithTag:1001];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([randArray containsObject:[NSString stringWithFormat:@"%ld",(long)ball.tag]]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
    }
    else if (modetype == HappyTenRen2Zhi) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:20 IsRanged:NO];
        for (int i = 1002; i < 1004; i++) {
            UIView *v = [backScrollView viewWithTag:i];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    
                    if (ball.tag == [[randArray objectAtIndex:i - 1002] intValue]) {
                        ball.selected = YES;
                    }
                    else{
                        ball.selected = NO;
                    }
                }
            }
        }
    }
    else if (modetype == HappyTenRen3Zhi) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:20 IsRanged:NO];
        for (int i = 1002; i < 1005; i++) {
            UIView *v = [backScrollView viewWithTag:i];
            for (GCBallView *ball in v.subviews) {
                
                if ([ball isKindOfClass:[GCBallView class]]) {
                    if (ball.tag == [[randArray objectAtIndex:i - 1002] intValue]) {
                        ball.selected = YES;
                    }
                    else {
                        ball.selected = NO;
                    }
                    
                }
            }
        }
    }
    else {
        NSInteger base = 1;
        if (modetype == HappyTenRen2 || modetype == HappyTenRen2Zu) {
            base = 2;
        }
        else if (modetype == HappyTenRen3 || modetype == HappyTenRen3Zu) {
            base = 3;
        }
        else if (modetype == HappyTenRen4 ) {
            base = 4;
        }
        else if (modetype == HappyTenRen5 ) {
            base = 5;
        }
        NSMutableArray *randArray;
        UIView *v;
        if (modetype == HappyTenDa || modetype == HappyTenDan) {
            randArray = [GC_LotteryUtil getRandBalls:base start:0 maxnum:8];
            v = [backScrollView viewWithTag:1005];
        }else{
            randArray = [GC_LotteryUtil getRandBalls:base start:1 maxnum:20];
            v = [backScrollView viewWithTag:1002];
        }
        for (GCBallView *ball in v.subviews) {
            
            if ([ball isKindOfClass:[GCBallView class]]){
                NSString *num = [NSString stringWithFormat:@"%ld",(long)ball.tag];
                if (modetype != HappyTenDa && modetype != HappyTenDan) {
                    if (ball.tag < 10) {
                        num = [NSString stringWithFormat:@"0%ld",(long)ball.tag];
                    }
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        
    }
	[self ballSelectChange:nil];
}

//- (void)getResqult {
//}
- (void)pressTitleButton1:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao_selected.png");
}
- (void)pressTitleButton2:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");

}
- (void)pressTitleButton:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");

    if(titleBtnIsCanPress)
    {
        if ([infoViewController.dataArray count] != 0) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"不支持多玩法同时投注" message:@"您需要删除已选号码才可切换" delegate:self cancelButtonTitle:@"删除已选" otherButtonTitles:@"知道了",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 1109;
            [alert show];
            [alert release];
            return;
        }
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"不支持多玩法同时投注" message:@"您需要删除已选号码才可切换" delegate:self cancelButtonTitle:@"删除已选" otherButtonTitles:@"知道了",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 1109;
            [alert show];
            [alert release];
            return;
        }
        titleBtnIsCanPress = NO;
        if(!isShowing)
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoKai:sanjiao];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameArray:wanArray shuziArray:nil];
            
            alert2.duoXuanBool = NO;
            alert2.delegate = self;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [self.view addSubview:self.CP_navigation];
            [alert2 show];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];

            NSInteger type = [wanArray indexOfObject:[self changeModetypeToString:modetype]];
            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if ([btn isKindOfClass:[UIButton class]] &&btn.tag == type) {
                    btn.selected = YES;
                    btn.buttonName.textColor = [UIColor whiteColor];
                }
            }
            
        }
        else
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoGuan:sanjiao];
            
            [alert2 disMissWithPressOtherFrame];
        }
        

    }
    
    
}

//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    // if (buf[sender.tag] == 0) {
	UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
	image.hidden = NO;
	UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
	imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
    //    buf[sender.tag] = 1;
    NSString *issue2 = [[wanArray objectAtIndex:sender.tag-1] substringFromIndex:3];
    // [wanArray objectAtIndex:sender.tag - 1]
	titleLabel.text = [NSString  stringWithFormat:@"快乐十分%@", issue2];
    
	//    for (int i = 1; i < 13; i++) {
	//        if (i != sender.tag) {
	//            UIImageView * image = (UIImageView *)[sender viewWithTag:i * 10];
	//            image.hidden = YES;
	//            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:i * 100];
	//            imagebg.image = nil;
	//        }
	//    }
    
	[self performSelector:@selector(pressBgButton:) withObject:sender afterDelay:.1];
	
    
}

- (void)changeTitle {
    for (int i = 1000;i<1007;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        v.hidden = YES;
    }
    yaoImage.hidden = NO;
    yaolabel.hidden = NO;
    randBtn.hidden = NO;
    if ([self.issue length] > 4) {
    
        NSString *lastIssue = [self.issue substringFromIndex:4];
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",[self changeModetypeToString:modetype],lastIssue];
        
    }
    else {
        
        titleLabel.text = [NSString stringWithFormat:@"快乐十分%@",[self changeModetypeToString:modetype]];
    }
    
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
    titleLabel.frame = CGRectMake((self.CP_navigation.frame.size.width - titleSize.width - 17 - 2)/2, 0, titleSize.width, self.CP_navigation.frame.size.height);

    UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    la.frame = CGRectMake(ORIGIN_X(titleLabel) + 2, 14, 17, 17);
    
    yaoImage.hidden = NO;
    colorLabel.frame = CGRectMake(40, 53, 280, 40);
    switch (modetype) {
        case HappyTen1Shu:
        {
            colorLabel.text = @"猜中开奖号第1位即奖<24>元";
            
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"一" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTen1Hong:
        {
            
            colorLabel.text = @"开奖号第一位为红号即奖<8>元";
            UIView *v = [backScrollView viewWithTag:1001];
            v.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"一" firstAtIndex:18 firstTag:19 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen2:
        {
            
            colorLabel.text = @"猜中开奖号任意2个即奖<8>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"任选";
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen2Zhi:
        {

            colorLabel.text = @"与开奖号任意连续2位相同（顺序一致）即奖<62>元";
            for (int i = 1002;i<1004;i++)   {
                UIView *v = [backScrollView viewWithTag:i];
                UIImageView *seep =(UIImageView *) [v viewWithTag:88888];
                v.hidden = NO;
                ColorView *label = (ColorView *)[v viewWithTag:100];
                UILabel * label1 = (UILabel *)[v viewWithTag:888666];
                
                if (i == 1002) {
                    label.text = @"前";
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
                }
                else {
                    label.text = @"后";
                    label1.text = @"至少选1个号";

                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
                    seep.hidden = YES;
                    seepLabel.hidden = YES;
                }
                
            }
        }
            break;
        case HappyTenRen2Zu:
        {
            colorLabel.text = @"与开奖号连续2位相同（顺序不限）即奖<31>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"选二";
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen3:
        {
            
            colorLabel.text = @"猜中开奖号任意3个即奖<24>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"任选";
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen3Zhi:
        {

            // 单注奖金<8000>元
            colorLabel.text = @"按位猜中前3个开奖号即奖<8000>元";
            for (int i = 1002;i<1005;i++)   {
                UIView *v = [backScrollView viewWithTag:i];
                UIImageView *seep = (UIImageView *)[v viewWithTag:88888];
                v.hidden = NO;
            
                ColorView *label = (ColorView *)[v viewWithTag:100];
                UILabel * label1 = (UILabel *)[v viewWithTag:888666];

                if (i == 1002) {
                    label.text = @"一位";
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"一" firstTag:1 keyType:HasZero yiLouTag:1];

                }
                else if (i == 1003) {
                    label.text = @"二位";
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"二" firstTag:1 keyType:HasZero yiLouTag:1];
                    seep.hidden = YES;
                    seepLabel.hidden = YES;
                    
                    label1.text = @"至少选1个号";
                }
                else {
                    label.text = @"三位";
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"三" firstTag:1 keyType:HasZero yiLouTag:1];
                    seepLabel.hidden = YES;
                    seep.hidden = YES;
                    
                    label1.text = @"至少选1个号";
                }
            }
        }
            break;
            
        case HappyTenRen3Zu:
        {
            colorLabel.text = @"猜中与开奖号前3位（顺序不限）即奖<1300>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"选三";

            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen4:
        {
            colorLabel.text = @"猜中开奖号任意4个即奖<80>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"任选";
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;
        case HappyTenRen5:
        {
            colorLabel.text = @"猜中开奖号任意5个即奖<320>元";
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            ColorView *label = (ColorView *)[v viewWithTag:100];
            label.text = @"任选";
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
        }
            break;

        case HappyTenDa:
        {
            colorLabel.text = @"猜开奖号中出现的大数的个数(11-20为大数)";

            UIView *v = [backScrollView viewWithTag:1005];
            v.hidden = NO;
         
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"dsyl" firstTag:0 reverse:YES];
        }
            break;

        case HappyTenDan:
        {
            colorLabel.text = @"猜开奖号中出现的单数号的个数";
            
            UIView *v = [backScrollView viewWithTag:1005];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"ssyl" firstTag:0 reverse:YES];
        }
            break;

        case HappyTenQuan:
        {
            yaoImage.hidden = YES;
            colorLabel.frame = CGRectMake(19, 53, 280, 40);

            colorLabel.text = @"开奖号为01至18(不含19、20)即奖<3>元";
            
            UIView *v = [backScrollView viewWithTag:1006];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"qsyl" firstAtIndex:1 firstTag:0];
        }
            break;
        default:
        {
            yaoImage.hidden = YES;
            colorLabel.frame = CGRectMake(19, 53, 280, 40);

            NSArray * array = @[@"猜中开奖号任意2个即奖<8>元",@"猜中开奖号任意3个即奖<24>元",@"猜中开奖号任意4个即奖<80>元", @"猜中开奖号任意5个即奖<320>元",@"与开奖号连续2位相同(顺序不限)即奖<31>元",@"猜中与开奖号前3位(顺序不限)即奖<1300>元"];
//            if (modetype >= HappyTenRen2DanTuo && modetype - HappyTenRen2DanTuo < [array count]) {
                colorLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:modetype - HappyTenRen2DanTuo]];
//            }
            
            for (int i = 1002;i<1004;i++)   {
                UIView *v = [backScrollView viewWithTag:i];
                UIImageView *seep =(UIImageView *) [v viewWithTag:88888];
                UILabel * label1 = (UILabel *)[v viewWithTag:888666];

                v.hidden = NO;
                ColorView *label = (ColorView *)[v viewWithTag:100];
                if (i == 1002) {
                    label.text = @"胆码";
                    if (modetype == HappyTenRen3ZuDanTuo) {
                        [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" firstTag:1 keyType:HasZero yiLouTag:1];
                    }else{
                        [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
                    }
                }
                else {
                    label.text = @"拖码";
                    label1.text = @"我认为可能出的号码";
                    
                    if (modetype == HappyTenRen3ZuDanTuo) {
                        [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" firstTag:1 keyType:HasZero yiLouTag:1];
                    }else{
                        [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt" firstTag:1 keyType:HasZero yiLouTag:1];
                    }
                    seep.hidden = YES;
                    seepLabel.hidden = YES;
                }
                
            }
            
//            UIView *v = [backScrollView viewWithTag:1005];
//            v.hidden = NO;
//            ColorView *colorL  = (ColorView *)[v viewWithTag:100];
//            
//            if (modetype == HappyTenRen2DanTuo || modetype == HappyTenRen2ZuDanTuo) {
////                colorL.colorPianYi = 3;
//                colorL.text = @"胆码 <1>";
//            }
//            else if (modetype <= HappyTenRen5DanTuo) {
////                colorL.colorPianYi = -3;
//                colorL.text = [NSString stringWithFormat:@"胆码 <1-%d>",modetype -HappyTenRen2DanTuo + 1];
//            }
//            else {
////                colorL.colorPianYi = -3;
//                colorL.text = [NSString stringWithFormat:@"胆码 <1-%d>",modetype -HappyTenRen2ZuDanTuo + 1];
//            }
//            UIView *v2 = [backScrollView viewWithTag:1006];
//            v2.hidden = NO;
//            
//            if (modetype <= HappyTenRen5DanTuo && modetype >= HappyTenRen2DanTuo) {
//                [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"arrNumber" firstAtIndex:1 firstTag:1];
//                
//                [YiLouUnderGCBallView addYiLouTextOnView:v2 dictionary:self.yilouDic typeStr:@"arrNumber" firstAtIndex:1 firstTag:1];
//                
//            }
//            else {
//                
//                for (GCBallView *ball in v.subviews) {
//                    if ([ball isKindOfClass:[GCBallView class]] ) {
//                        
//                        [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"arrNumber" firstAtIndex:1 firstTag:1];
//                        
//                    }
//                }
//                for (GCBallView *ball in v2.subviews) {
//                    if ([ball isKindOfClass:[GCBallView class]] ) {
//                        
//                        [YiLouUnderGCBallView addYiLouTextOnView:v2 dictionary:self.yilouDic typeStr:@"arrNumber" firstAtIndex:1 firstTag:1];
//                    }
//                }
//            }
            
            
        }
            break;
    }
    
    float heght =85;
    if (modetype == HappyTenRen2Zhi || modetype == HappyTenRen3Zu) {
        heght = 85 + COLORLABEL_HIGHT;
    }
    for (int i = 1000; i < 1007;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        
        // ***
        if (v.hidden == NO) {
            v.frame = CGRectMake(v.frame.origin.x,heght , v.bounds.size.width, v.bounds.size.height);
            heght = heght + v.bounds.size.height - 1;
        }
    }
//    if (backScrollView.frame.size.height > heght + 25) {
//        heght = backScrollView.frame.size.height - 25;
//    }
    backScrollView.contentSize = CGSizeMake(320,heght +25);
    
    if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    }

    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + 44 + isIOS7Pianyi);
    
    zaixianLabel.frame = CGRectMake(zaixianLabel.frame.origin.x, heght + 2, zaixianLabel.bounds.size.width, zaixianLabel.bounds.size.height);
    imageruan.frame = CGRectMake(imageruan.frame.origin.x, heght, imageruan.bounds.size.width, imageruan.bounds.size.height);
    if (self.showYiLou) {
        self.showYiLou = YES;
    }
    
}

- (void)pressBgButton:(UIButton *)sender{
    if (sender.tag <= [wanArray count]) {
        
        
        NSString *str = [wanArray objectAtIndex:sender.tag];
        modetype = [self changeStringToMode:str];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"HappyTenDefaultModetype"];
    }
    
	[self changeTitle];
	[self clearBalls];
	//[self ballSelectChange:nil];
    
    
    
    
}


- (void)doBack {
    [self.runTimer invalidate];
	self.runTimer = nil;
	[self.navigationController popViewControllerAnimated:YES];
}

//玩法介绍
- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = KuaiLeShiFen;
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
	
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        if (modetype == HappyTenQuan) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"猜全数不支持随机选号"];
        }
        else if (modetype >= HappyTenRen2DanTuo) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆拖玩法不支持随机选号"];
        }else{

            [self randBalls];
        }
    }
	[super motionEnded:motion withEvent:event];
}

-(void)createTimer
{
    @autoreleasepool {
        if (!myTimer) {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
            entRunLoopRef = CFRunLoopGetCurrent();
            CFRunLoopRun();
        }
    }
}



#pragma mark -
#pragma mark GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
    if (imageView) {
        for (int i = 1000; i < 1007; i++) {
            if (imageView.superview.tag != i) {
                UIView *v = [backScrollView viewWithTag:i];
                GCBallView *ball = (GCBallView *)[v viewWithTag:imageView.tag];
                if ([ball isKindOfClass:[GCBallView class]] &&ball.selected == YES) {
                    imageView.selected = NO;
                    if (modetype >= HappyTenRen2DanTuo) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码和拖码不能重复"];
                    }else{
                        [[caiboAppDelegate getAppDelegate] showMessage:@"每一位不能重复"];
                    }
                    return;
                }
            }
            
        }
        if (imageView.superview.tag == 1002 && modetype >= HappyTenRen2DanTuo) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if ([btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
                    i++;
                }
            }
            int a = 1;
            if (modetype == HappyTenRen3DanTuo || modetype == HappyTenRen3ZuDanTuo) {
                a = 2;
                
            }
            if (modetype == HappyTenRen4DanTuo) {
                a = 3;
            }
            if (modetype == HappyTenRen5DanTuo) {
                a = 4;
            }
            if (imageView.selected && i>a) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:[NSString stringWithFormat:@"胆码最多选择%d个球",a]];
                imageView.selected = NO;
                [self ballSelectChange:nil];
                return;
            }
        }
        
    }
    if (modetype == HappyTen1Hong && imageView) {
        UIView *v = [backScrollView viewWithTag:1001];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]] && ball.selected && ball != imageView) {
                imageView.selected = NO;
                [[caiboAppDelegate getAppDelegate] showMessage:@"红码只能选择一个号码"];
                return;
            }
        }
    }
    if (modetype >= HappyTenRen2DanTuo)
    {
        UIView * v1 = nil;
        UIView * v2 = nil;
        if(imageView.superview.tag == 1002)
        {
            v1 = [backScrollView viewWithTag:1003];
            v2 = [backScrollView viewWithTag:1002];
        }
        else if(imageView.superview.tag==1003)
        {
            v1 = [backScrollView viewWithTag:1002];
            v2 = [backScrollView viewWithTag:1003];
        }
        GCBallView *btn2 = (GCBallView *)[v1 viewWithTag:imageView.tag];
        GCBallView *btn3 = (GCBallView *)[v2 viewWithTag:imageView.tag];
        if (!btn2.selected && btn3.selected) {
            [btn2 changetolight];
        }
        else {
            [btn2 chanetoNomore];
        }
    }
	NSUInteger bets = 0;
    bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:modetype];
	
    zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)2*bets];

    NSString *str =[[[[self seletNumber] stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"|" withString:@""];
    
    // 判断两种状态*****
    senBtn.enabled = YES;
    if ([str length] == 0) {
        if (modetype < HappyTenRen2DanTuo) {
            if (modetype == HappyTenQuan) {
                senBtn.enabled = NO;
            }else{
                [senBtn setTitle:@"机选" forState:UIControlStateNormal];
            }
        }
        else{
            [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
            senBtn.enabled = NO;
        }
    }
    else {
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
        if (buttonIndex == 1) {
            if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [self clearBalls];
                
                [self.navigationController pushViewController:infoViewController animated:YES];
            }
            
        }
    }
    else if (alertView.tag == 1109) {
        if (buttonIndex == 0) {
            if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
                [infoV.dataArray removeAllObjects];
            }
            else{
                [infoViewController.dataArray removeAllObjects];
            }
            [self performSelector:@selector(pressTitleButton:)];
        }
        
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqZhongJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangQiZhongJiang *wang = [[WangQiZhongJiang alloc] initWithResponseData:[request responseData] WithRequest:request];
		self.zhongJiang = wang;
		[self.runTimer invalidate];
		self.runTimer = nil;
		zaixianLabel.text = [NSString stringWithFormat:@"在线<%ld>人",(long)wang.AllNum];
		[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidenranLabel) object:nil];
		self.runTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showranLabel) userInfo:nil repeats:YES];
        [wang release];
        //		[myPicker reloadAllComponents];
	}
}

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];

        
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号"]];
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastThreeStr:info.issue]]];
            NSArray * numberArray = [info.num componentsSeparatedByString:@","];
            NSString * numberString = @"";
            
            for (int j = 0; j < numberArray.count; j++) {
                numberString =  [numberString stringByAppendingString:[numberArray objectAtIndex:j]];
                if (j != numberArray.count - 1) {
                    numberString =  [numberString stringByAppendingString:@"  "];
                }
            }
            [dataArray addObject:numberString];
            [historyArr addObject:dataArray];
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];
	}
}


- (void)reqLotteryInfoFailed:(ASIHTTPRequest*)request {
    [self.myTimer invalidate];
    self.myTimer = nil;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.yilouDic = nil;
    [self changeTitle];
    hasYiLou = NO;
}

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        
        IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        if (issrecord) {
            
            NSArray *timearray = [issrecord.remainingTime componentsSeparatedByString:@":"];
            if ([timearray count] == 3) {
                seconds = 60*[[timearray objectAtIndex:1]intValue]+[[timearray objectAtIndex:2] intValue];
                if (seconds%2 == 1) {
                    seconds = seconds + 1;
                }
                
                
                // ****
                if ([issrecord.curIssue length] >4) {
                    NSString *str = [issrecord.curIssue substringFromIndex:4];
                    // issrecord.curIssue
                    timeLabel.text = [NSString stringWithFormat:@" 距 %@",str];
                }

                mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(int)seconds/60,(int)seconds%60];
            }
            yanchiTime = [issrecord.lotteryStatus intValue];
        
            if ([self.issue length] && ![self.issue isEqualToString:issrecord.curIssue] && isAppear) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@期已截止>\n当前期是%@期，投注时请注意期次",[SharedMethod getLastThreeStr:self.issue],[SharedMethod getLastThreeStr:issrecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.alertTpye = jieQiType;
                [alert show];
                [alert release];
            }
            self.issue = issrecord.curIssue;
            
            // 截取期号
            NSString *str = [NSString stringWithFormat:@"%@>",[issrecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"#" withString:@"期开奖 <"]] ;
            if ([str length] > 4) {
                NSString *str1 = [str substringFromIndex:4];
                // [NSString stringWithFormat:@"%@>",[issrecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"#" withString:@"期 <"]];
                sqkaijiang.text = str1;
            }

            sqkaijiang.text = [sqkaijiang.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
            if ([[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
                if ([issrecord.curIssue longLongValue] - [[[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0] longLongValue] >= 2) {
                    isKaiJiang = NO;
                    
                    if (canRefreshYiLou) {
                        self.yilouDic = nil;
                        [self changeTitle];
                        hasYiLou = NO;
                    }
                }
                else {
                    isKaiJiang = YES;
                    
                    if (![myIssrecord isEqualToString:issrecord.curIssue]) {
                        if ([colorLabel.text isEqualToString:@"上期等待开奖..."]) {
                            [self performSelector:@selector(getWangqi) withObject:nil afterDelay:60];
                        }
                        [self getHappyYilouWithType:1];
                    }else if (!hasYiLou && canRefreshYiLou) {
                        [self getHappyYilouWithType:1];
                    }
                    canRefreshYiLou = YES;
                    
                    self.myIssrecord = issrecord.curIssue;
                }

            }
            
            [self.myTimer invalidate];
            self.myTimer = nil;
            [self performSelectorInBackground:@selector(createTimer) withObject:nil];
        }
        [issrecord release];
    }else{
        self.yilouDic = nil;
        [self changeTitle];
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
}

-(void)upDateYiLou
{
    [redraw removeFromSuperview];
    redraw = nil;
    [titleYiLou removeFromSuperview];
    titleYiLou = nil;
    
    [self getHappyYilouWithType:2];
}

-(void)getYilou
{
    self.yilouDic = nil;
    [self changeTitle];
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID];
    
    if([yilou_Dic objectForKey:self.issue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
        return;
    }
    [self.yilouRequest clearDelegatesAndCancel];
    if (!myIssrecord) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:nil]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:nil cacheable:YES]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(reqYilouFailed:)];
    [yilouRequest startAsynchronous];
}

- (void)getHappyYilouWithType:(int)type {
    if (type == 1) {
        [self getYilou];
    }else{
        if (!loadview) {
            loadview = [[UpLoadView alloc] init];
        }
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        
        [self.yilouRequest clearDelegatesAndCancel];
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:YiLOU_COUNT issue:nil]];
        [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [yilouRequest setDelegate:self];
        [yilouRequest setDidFinishSelector:@selector(allYiLouRequestFinish:)];
        [yilouRequest setDidFailSelector:@selector(allYiLouRequestFail:)];
        [yilouRequest startAsynchronous];

    }
}

- (void)reqYilouFailed:(ASIHTTPRequest *)request
{
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}

- (void)allYiLouRequestFail:(ASIHTTPRequest *)request
{
    self.showYiLou = NO;
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}

- (void)allYiLouRequestFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
	NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * responseArray = [[responseStr JSONValue] objectForKey:@"list"];
        NSMutableArray * chartDataArray = [[[NSMutableArray alloc] init] autorelease];
        for (int i = (int)responseArray.count - 1; i >= 0; i--) {
            YiLouChartData * chartData = [[YiLouChartData alloc] initWithHappyDictionary:[responseArray objectAtIndex:i]];
            [chartDataArray addObject:chartData];
            [chartData release];
        }
        if ([responseArray count] == 0) {
            self.showYiLou = NO;
        }else{
            self.yiLouDataArray = chartDataArray;
            if (yiLouView) {
                [self createChart];
            };
        }
        
    }else{
        self.showYiLou = NO;
    }
}

- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    if ([[yilouDic objectForKey:@"rt"] count]) {
        
        hasYiLou = YES;
        
        if (showYiLou) {
            [self upDateYiLou];
        }
    }else{
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    
    [self changeTitle];
    
}
- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    if (responseStr && ![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [[responseStr JSONValue] objectForKey:@"list"];
        if ([array count] >= 1) {
            self.yilouDic = [array objectAtIndex:0];
            if ([[yilouDic objectForKey:@"rt"] count]) {
                
                //删除旧的遗漏值
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID];
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID];
                
                hasYiLou = YES;
                if (showYiLou) {
                    [self upDateYiLou];
                }
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
        self.yilouDic = nil;
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    [self changeTitle];
}

- (void)createChart
{
    ChartFormatData * chartFormatData = [[[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:HappyTen lottoryDisplayType:DisplayRight] autorelease];
    chartFormatData.lottoryWidth = 150;
    chartFormatData.numberOfLines = 20;
    chartFormatData.linesWidth = 23;
    chartFormatData.differentColorTypeArray = @[@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(BlueCircle),@(RedCircle),@(RedCircle)];
    
    if (!redraw) {
        titleYiLou = [[UITitleYiLouView alloc] initWithFrame:CGRectMake(0, 0, 320, DEFAULT_ISSUE_HEIGHT) chartFormatData:chartFormatData];
        [headYiLouView addSubview:titleYiLou];
        titleYiLou.delegate = self;
        
        redraw = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
        [yiLouView addSubview:redraw];
        redraw.delegate = self;
    }
}

- (void)returnScrollViewContOffSet:(CGPoint)point
{
    ChartTitleScrollView * titleScrollview = (ChartTitleScrollView *)[titleYiLou viewWithTag:1101];
    titleScrollview.contentOffset = CGPointMake(point.x, titleScrollview.contentOffset.y);
}

- (void)returnTitleScrollViewContOffSet:(CGPoint)point
{
    ChartYiLouScrollView * redrawScrollview = (ChartYiLouScrollView *)[redraw viewWithTag:1103];
    redrawScrollview.contentOffset = CGPointMake(point.x, redrawScrollview.contentOffset.y);
}


-(void)animationCompleted:(GifButton *)gifButton
{
    UIView *v1 = nil;
    if(gifButton.superview.tag == 1002)
    {
        v1 = [backScrollView viewWithTag:1003];
    }
    else if(gifButton.superview.tag == 1003)
    {
        v1 = [backScrollView viewWithTag:1002];
    }
    for (GCBallView *ball in v1.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            [ball chanetoNomore];
        }
    }
    [self ballSelectChange:nil];
}







//#pragma mark -
//#pragma mark UITableViewDataSource
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (tableView == _cpTableView) {
//        UIView *v = [[[UIView alloc] init] autorelease];
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
//        label1.text = @"期号";
//        label1.font = [UIFont boldSystemFontOfSize:14];
//        label1.textColor = [UIColor whiteColor];
//        label1.backgroundColor = [UIColor clearColor];
//        label1.textAlignment = NSTextAlignmentCenter;
//        [v addSubview:label1];
//        [label1 release];
//        
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 180, 20)];
//        label2.text = @"历史开奖";
//        label2.textColor = [UIColor whiteColor];
//        label2.font = [UIFont boldSystemFontOfSize:14];
//        label2.backgroundColor = [UIColor clearColor];
//        label2.textAlignment = NSTextAlignmentCenter;
//        [v addSubview:label2];
//        [label2 release];
//        v.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
//        [v addSubview:line];
//        line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//        [line release];
//        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 34 , 260, 1)];
//        [v addSubview:line2];
//        line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//        [line2 release];
//        return v;
//    }
//    return nil;
//}
//
//- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (tableView == _cpTableView) {
//        return 35;
//    }
//    return 0;
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.wangQi.brInforArray count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 35;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView == _cpTableView) {
//        static NSString *CellIdentifier = @"Cell1";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
//            label1.tag = 101;
//            label1.textAlignment = NSTextAlignmentCenter;
//            label1.textColor = [UIColor whiteColor];
//            [cell.contentView addSubview:label1];
//            [label1 release];
//            
//            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 35)];
//            label2.font = [UIFont systemFontOfSize:13];
//            label2.textColor = [UIColor whiteColor];
//            label2.tag = 102;
//            label2.backgroundColor = [UIColor colorWithRed:67/255.0 green:144/255.0 blue:186/255.0 alpha:1.0];
//            [cell.contentView addSubview:label2];
//            label2.textAlignment = NSTextAlignmentCenter;
//            [label2 release];
//            
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
//            [cell.contentView addSubview:line];
//            line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//            [line release];
//            
//            UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 260, 1)];
//            [cell.contentView addSubview:line2];
//            line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//            [line2 release];
//            cell.contentView.backgroundColor = [UIColor clearColor];
//            
//        }
//        
//        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
//        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
//        KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
//        l1.text = info.issue;
//        l2.text = info.num;
//        return  cell;
//        
//    }
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if (!cell) {
//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
//		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 33)];
//        label1.font = [UIFont systemFontOfSize:12];
//        label1.backgroundColor = [UIColor clearColor];
//        label1.tag = 101;
//        [cell.contentView addSubview:label1];
//        [label1 release];
//        
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 33)];
//        label2.font = [UIFont systemFontOfSize:12];
//        label2.textColor = [UIColor redColor];
//        label2.tag = 102;
//        label2.backgroundColor = [UIColor clearColor];
//        label2.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label2];
//        [label2 release];
//        
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 160, 33)];
//        label3.font = [UIFont systemFontOfSize:12];
//        label3.textColor = [UIColor blueColor];
//        label3.tag = 103;
//        label3.backgroundColor = [UIColor clearColor];
//        label3.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label3];
//        [label3 release];
//        
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(1, 33, 254, 2)];
//        imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//        [cell.contentView addSubview:imageV];
//        cell.backgroundColor = [UIColor clearColor];
//        [imageV release];
//        
//	}
//    UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
//    UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
//    UILabel *l3 = (UILabel *)[cell.contentView viewWithTag:103];
//    KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
//    l1.text = info.issue;
//    if ([[info.kaijiangTime componentsSeparatedByString:@" "] count] > 1) {
//        l2.text = [[info.kaijiangTime componentsSeparatedByString:@" "] objectAtIndex:1];
//    }
//    l3.text = [info.num stringByReplacingOccurrencesOfString:@"," withString:@" "];
//    return  cell;
//}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
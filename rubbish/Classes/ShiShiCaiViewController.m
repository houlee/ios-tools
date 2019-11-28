//
//  ShiShiCaiViewController.m
//  caibo
//
//  Created by yaofuyu on 12-10-17.
//
//

#import "ShiShiCaiViewController.h"
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
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"
#import "SharedMethod.h"

#define LOTTERY_ID @"006"

@interface ShiShiCaiViewController ()

@end

@implementation ShiShiCaiViewController
@synthesize lotterytype;
@synthesize modetype;
@synthesize myRequest;
@synthesize qihaoReQuest;
@synthesize issue;
@synthesize myIssrecord;
//@synthesize wangQi;
@synthesize myTimer;
@synthesize zhongJiang;
@synthesize runTimer;
@synthesize yilouRequest;
@synthesize yilouDic;

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
        wanArray = [[NSArray alloc] initWithObjects:@"大小单双",@"一星复式",@"二星复式",@"二星组选",@"二星组选胆拖",@"三星复式",@"四星复式",@"五星复式",@"五星通选",@"任选一",@"任选二",@"任选三", nil];
        modetype = SSCsanxingfushi;
        lotterytype = TYPE_SHISHICAI;
        int type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ShiShiCaiDefaultModetype"] intValue];
        if (SSCyixingdanshi <= type && SSCrenxuansan >= type) {
            modetype = type;
        }
        isVerticalBackScrollView = YES;
        yanchiTime = 90;
        yiLouTypeArr = [[NSArray alloc] initWithObjects:@"一",@"二", @"三", @"四", @"五",@"一",@"二", nil];
        hasYiLou = NO;
        canRefreshYiLou = YES;
    }
    return  self;
}

- (void)dealloc {
    self.myIssrecord = nil;
    [editeView removeFromSuperview];
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
//    self.wangQi = nil;
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.zhongJiang = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [descriptionLabel release];
    [yiLouTypeArr release];
    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    [super dealloc];
}

- (NSString *)changeModetypeToString:(ModeTYPE)mode {
    int a = 0;
    if (SWITCH_ON) {
        a = 25;
    }
    if (mode == SSCsanxingfushi) {
        descriptionLabel.frame = CGRectMake(20, 340 + a*3.3, 360, 20);
        descriptionLabel.text = @"猜开奖号码最后3位，需顺序一致";
        return @"三星复式";
    }
    else if (mode == SSCdaxiaodanshuang){
        descriptionLabel.frame = CGRectMake(20, 228, 360, 20);
        descriptionLabel.text = @"猜开奖号最后2位的属性";
        return @"大小单双";
    }
    else if (mode == SSCyixingfushi){
        descriptionLabel.frame = CGRectMake(20, 160 + a, 360, 20);
        descriptionLabel.text = @"猜开奖号的最后1位";
        return @"一星复式";
    }
    else if (mode == SSCerxingfushi){
        descriptionLabel.frame = CGRectMake(20, 253 + a*2, 360, 20);
        descriptionLabel.text = @"猜开奖号码最后2位，需顺序一致";
        return @"二星复式";
    }
    else if (mode == SSCerxingzuxuan){
        descriptionLabel.frame = CGRectMake(20, 253 + a*2, 360, 20);
        descriptionLabel.text = @"猜开奖号码最后2位，顺序不限";
        return @"二星组选";
    }
    else if (mode == SSCerxingzuxuandantuo){
        descriptionLabel.frame = CGRectMake(20, 253 + a*2, 360, 20);
        descriptionLabel.text = @"猜开奖号码最后2位，顺序不限";
        return @"二星组选胆拖";
    }
    else if (mode == SSCsixingfushi){
        descriptionLabel.frame = CGRectMake(20, 430 + a*4.3, 360, 20);
        descriptionLabel.text = @"猜开奖号码最后4位，需顺序一致";
        return @"四星复式";
    }
    else if (mode == SSCwuxingfushi){
        descriptionLabel.frame = CGRectMake(20, 520 + a*5.4, 360, 20);
        descriptionLabel.text = @"每位至少选1个号码，与开奖号码相同（且顺序一致）";
        return @"五星复式";
    }
    else if (mode == SSCwuxingtongxuan){
        descriptionLabel.frame = CGRectMake(20, 520 + a*5.4, 360, 20);
        descriptionLabel.text = @"每位至少选1个号";
        return @"五星通选";
    }
    else if (mode == SSCrenxuanyi){
        descriptionLabel.frame = CGRectMake(20, 520 + a*5.4, 360, 20);
        descriptionLabel.text = @"猜开奖号的任意1位";
        return @"任选一";
    }
    else if (mode == SSCrenxuaner){
        descriptionLabel.frame = CGRectMake(20, 520 + a*5.4, 360, 20);
        descriptionLabel.text = @"猜开奖号的任意2位";
        return @"任选二";
    }
    else if (mode == SSCrenxuansan){
        descriptionLabel.frame = CGRectMake(20, 520 + a*5.4, 360, 20);
        descriptionLabel.text = @"猜开奖号的任意3位";
        return @"任选三";
    }
    
    return nil;
}

-(ModeTYPE)changeStringToMode:(NSString *)str {
    if ([str isEqualToString:@"大小单双"]) {
        return SSCdaxiaodanshuang;
    }
    else if ([str isEqualToString:@"一星复式"]){
        return SSCyixingfushi;
    }
    else if ([str isEqualToString:@"二星复式"]){
        return SSCerxingfushi;
    }
    else if ([str isEqualToString:@"二星组选"]){
        return SSCerxingzuxuan;
    }
    else if ([str isEqualToString:@"二星组选胆拖"]){
        return SSCerxingzuxuandantuo;
    }
    else if ([str isEqualToString:@"三星复式"]){
        return SSCsanxingfushi;
    }
    else if ([str isEqualToString:@"四星复式"]){
        return SSCsixingfushi;
    }
    else if ([str isEqualToString:@"五星复式"]){
        return SSCwuxingfushi;
    }
    else if ([str isEqualToString:@"五星通选"]){
        return SSCwuxingtongxuan;
    }
    else if ([str isEqualToString:@"任选一"]){
        return SSCrenxuanyi;
    }
    else if ([str isEqualToString:@"任选二"]){
        return SSCrenxuaner;
    }
    else if ([str isEqualToString:@"任选三"]){
        return SSCrenxuansan;
    }
    return SSCdaxiaodanshuang;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    isAppear = NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
    [self.runTimer invalidate];
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
	
}

- (void)LoadIpadView {
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
    
    backScrollView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height-50);
    yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(10, 40, 15, 15);
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
	colorLabel = [[ColorView alloc] init];
	colorLabel.frame = CGRectMake(27, 40, 100, 15);
	colorLabel.textColor = [UIColor blackColor];
	colorLabel.font = [UIFont systemFontOfSize:11];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:11];
	colorLabel.backgroundColor = [UIColor clearColor];
	colorLabel.changeColor = [UIColor redColor];
	[backScrollView addSubview:colorLabel];
	colorLabel.text = @"单注奖金<1170>元";
    colorLabel.wordWith = 10;
	[colorLabel release];
    
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115, 13, 195, 47)];
	[backScrollView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
	[image1BackView release];
    
//    UIImageView *sanjiao = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_sanjiao.png")];
//    sanjiao.frame = CGRectMake(165, 8, 11.5, 10);
//    [image1BackView addSubview:sanjiao];
//    [sanjiao release];
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(120, 20, 150, 23)];
    [backScrollView addSubview:sqkaijiang];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.font = [UIFont systemFontOfSize:10];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];
    
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 36, 55, 23)];
	[backScrollView addSubview:timeLabel];
    timeLabel.text = self.issue;
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:10];
	[timeLabel release];
	
	mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 36, 60, 23)];
	[backScrollView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止还有";
	mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:10];
	[mytimeLabel2 release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 36, 33, 23)];
	[backScrollView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	mytimeLabel3.font = [UIFont systemFontOfSize:10];
	[mytimeLabel3 release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
    [image1BackView addSubview:imageV];
    [imageV release];
	
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //	[btn setImage:UIImageGetImageFromName(@"gc_xh_12.png") forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
//	btn.frame = CGRectMake(130, 6, 180, 30);
//	[backScrollView addSubview:btn];
    
	NSArray *nameArray = [NSArray arrayWithObjects:@"十<①>",@"个<①>",@"万<①>",@"千<①>",@"百<①>",@"十<①>",@"个<①>",@"胆码<①>",@"拖码<①>",nil];
	for (int i = 0; i<9; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        if ([[nameArray objectAtIndex:i] length]) {
            ColorView *label = [[ColorView alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.text = [nameArray objectAtIndex:i];
            [firstView addSubview:label];
            label.tag = 100;
            label.textColor = [UIColor whiteColor];
            label.frame = CGRectMake(7, 15, 20, 60);
            if (i < 7) {
                label.frame = CGRectMake(7, 23, 20, 60);
            }
            label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
            label.colorfont = [UIFont boldSystemFontOfSize:14];
            label.jianjuHeight = 3;
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
            firstView.backgroundColor = [UIColor clearColor];
            firstView.frame = CGRectMake(10, 73 + i*90, 300, 91);
            if (i < 2) {
                NSArray *array = [NSArray arrayWithObjects:@"大",@"小",@"单",@"双", nil];
                for (int j = 0; j<4; j++) {
                    int b = j%4;
                    NSString *num = [NSString stringWithFormat:@"%@",[array objectAtIndex:j]];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*56+62, 24, 40, 40) Num:num ColorType:GCBallViewColorBig];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                }
            }
            else if (i>6){
                for (int j = 0; j<10; j++) {
                    int a= j/5,b = j%5;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+55, a*37+7, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                }
            }
            else {
                for (int j = 0; j<10; j++) {
                    int a= j/5,b = j%5;
                    NSString *num = [NSString stringWithFormat:@"%d",j];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+55, a*37+7, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j;
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
    zaixianLabel.colorfont = [UIFont systemFontOfSize:12];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[backScrollView addSubview:zaixianLabel];
	[zaixianLabel release];
	
	imageruan = [[UIImageView alloc] initWithFrame:CGRectMake(103, 343, 205, 25)];
	[backScrollView addSubview:imageruan];
    imageruan.image = [UIImageGetImageFromName(@"GC_sqkjback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    imageruan.layer.masksToBounds = YES;
	
	ranLabel = [[ColorView alloc] initWithFrame:CGRectMake(0, 5, 260, 16)];
	ranLabel.text = @"";
    ranLabel.textAlignment = NSTextAlignmentCenter;
	ranLabel.font = [UIFont systemFontOfSize:10];
	ranLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	ranLabel.changeColor = [UIColor redColor];
	ranLabel.backgroundColor = [UIColor clearColor];
	[imageruan addSubview:ranLabel];
    
    ranNameLabel = [[ UILabel alloc] initWithFrame:CGRectMake(0, 3, 30, 16)];
    ranNameLabel.text = @"";
    ranNameLabel.textAlignment = NSTextAlignmentCenter;
	ranNameLabel.font = [UIFont systemFontOfSize:10];
    ranNameLabel.backgroundColor = [UIColor clearColor];
	ranNameLabel.textColor = [UIColor blackColor];
	[imageruan addSubview:ranNameLabel];
    [ranNameLabel release];
    
	[ranLabel release];
	[imageruan release];
    
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	
	
    //清按钮
    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12 + 35, 10, 30, 30);
    //[qingbutton setImage:UIImageGetImageFromName(@"gc_fb_14.png") forState:UIControlStateNormal];
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52+ 35, 10, 62, 30)];
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
    senLabel.font = [UIFont systemFontOfSize:15];
    [senBtn addSubview:senLabel];
    [senLabel release];
}

- (void)LoadIphoneView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50+10, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.tag = 789;
    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowColor = [UIColor blackColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    JTLabel.tag = 567;
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        titleLabel.frame = CGRectMake(15, 0, 220, 44);
//        JTLabel.frame = CGRectMake(169, 1, 20, 44);
//    }else {
//        
//        titleLabel.frame = CGRectMake(32, 0, 220, 44);
//        JTLabel.frame = CGRectMake(187, 1, 20, 44);
//    }
//    [titleView addSubview:JTLabel];
//    [JTLabel release];
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.tag = 567;
    [titleView addSubview:sanjiaoImageView];
    
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
//---------------------------------------------bianpinghua by sichuanlin
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
//    yaoImage.frame =CGRectMake(10, 40, 15, 15);
    yaoImage.frame =CGRectMake(15, 53, 21, 19);
    
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
	colorLabel = [[ColorView alloc] init];
    colorLabel.frame = CGRectMake(40, 53, 265, 19);
	colorLabel.font = [UIFont systemFontOfSize:14];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:14];
	colorLabel.backgroundColor = [UIColor clearColor];
    colorLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    colorLabel.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
	[backScrollView addSubview:colorLabel];
    colorLabel.text = @"按位猜中前3个开奖号即奖<1170>元";
	[colorLabel release];
    
//    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115, 13, 195, 47)];
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
    
	[backScrollView addSubview:image1BackView];
//---------------------------------------------bianpinghua by sichuanlin
//    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//    image1BackView.backgroundColor = [UIColor clearColor];
    image1BackView.backgroundColor=[UIColor whiteColor];
    image1BackView.layer.masksToBounds=YES;
    
	[image1BackView release];
    
//    UIImageView *sanjiao = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_sanjiao.png")];
//    sanjiao.frame = CGRectMake(165, 8, 11.5, 10);
//    [image1BackView addSubview:sanjiao];
//    [sanjiao release];
    
//    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(150, 20, 150, 23)];
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(15, 11, 250, 15)];
    
    [backScrollView addSubview:sqkaijiang];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];
    
//	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 36, 55, 23)];
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(226, 0, 55, 17)];
    
	[backScrollView addSubview:timeLabel];
//    timeLabel.text = self.issue;
//    timeLabel.text = [SharedMethod getLastThreeStr:self.issue];
    timeLabel.text = [NSString stringWithFormat:@"距%@",[SharedMethod getLastThreeStr:self.issue]];
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:8];
	[timeLabel release];
	
//	mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 36, 60, 23)];
    mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(245, 0, 60, 17)];
    mytimeLabel2.textAlignment=NSTextAlignmentRight;
    
	[backScrollView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止";
//	mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
    mytimeLabel2.textColor=[UIColor blackColor];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:8];
	[mytimeLabel2 release];
	
//	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 36, 33, 23)];
    mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(225, 17, 80, 20)];
    mytimeLabel3.textAlignment=NSTextAlignmentRight;
    
	[backScrollView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
//	mytimeLabel3.font = [UIFont systemFontOfSize:18];
    mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:20];
	[mytimeLabel3 release];
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
//    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//    [image1BackView addSubview:imageV];
//    [imageV release];
	
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //	[btn setImage:UIImageGetImageFromName(@"gc_xh_12.png") forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
//	btn.frame = CGRectMake(130, 6, 180, 30);
//	[backScrollView addSubview:btn];
    
	NSArray *nameArray = [NSArray arrayWithObjects:@"十位",@"个位",@"万位",@"千位",@"百位",@"十位",@"个位",@"胆码",@"拖码",nil];
    CGRect ballRect;
	for (int i = 0; i<9; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
//-----------------------------------------------bianpinghua by sichuanlin
        ColorView *desLabel = [[ColorView alloc] init];
        desLabel.backgroundColor=[UIColor clearColor];
        desLabel.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        desLabel.frame=CGRectMake(60, 2, 200, 22);
        desLabel.tag=2000+i;
        desLabel.font=[UIFont systemFontOfSize:12];
        [firstView addSubview:desLabel];
        desLabel.text=@"至少选1个号";

        if (i == 0 || i == 1)
        {
            desLabel.text=@"至少选一个属性";
        }
        if (i == 7)
        {
            desLabel.text=@"我认为必出的号，选1个";
        }
        if (i == 8)
        {
            desLabel.text=@"我认为可能出的号，至少选1个";
        }
        [desLabel release];
        
        
        UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
        imaHong.backgroundColor=[UIColor clearColor];
        imaHong.tag=10010;
        imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
        [firstView addSubview:imaHong];
        [imaHong release];
        
        if ([[nameArray objectAtIndex:i] length]) {
            ColorView *label = [[ColorView alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.text = [nameArray objectAtIndex:i];
            [firstView addSubview:label];
            label.tag = 100;
            label.textColor = [UIColor whiteColor];
            label.frame = CGRectMake(5, 1, 54, 22);

            label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
            firstView.backgroundColor = [UIColor clearColor];

            if (SWITCH_ON) {
                firstView.frame = CGRectMake(0, 85 + i*150, 320, 150);
            }else{
                firstView.frame = CGRectMake(0, 85 + i*120, 320, 120);
            }
            GCBallView *lastRedBallView;
            if (i < 2) {
                
                NSArray *array = [NSArray arrayWithObjects:@"大",@"小",@"单",@"双", nil];
                for (int j = 0; j<4; j++) {
                    int b = j%4;
                    NSString *num = [NSString stringWithFormat:@"%@",[array objectAtIndex:j]];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*70+15, 35, 40, 40) Num:num ColorType:GCBallViewColorBig];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastRedBallView=im;
                    [im release];
                }
                
                if (!i) {
                    UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 70+7, 18, 13)] autorelease];
                    louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
                    louImageView.tag = 111;
                    [firstView addSubview:louImageView];
                    if (!SWITCH_ON) {
                        louImageView.hidden = YES;
                    }
                    
                    UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
                    louLabel.backgroundColor = [UIColor clearColor];
                    louLabel.font = [UIFont systemFontOfSize:11];
                    louLabel.textAlignment = 1;
                    louLabel.tag = 112;
                    louLabel.textColor = [UIColor whiteColor];
                    [louImageView addSubview:louLabel];
                    louLabel.text = @"漏";

                }
            }
            else if (i>6){
                if(i==7)
                {
                    UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 70+2, 18, 13)] autorelease];
                    louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
                    louImageView.tag = 111;
                    [firstView addSubview:louImageView];
                    if (!SWITCH_ON) {
                        louImageView.hidden = YES;
                    }
                    
                    UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
                    louLabel.backgroundColor = [UIColor clearColor];
                    louLabel.font = [UIFont systemFontOfSize:11];
                    louLabel.textAlignment = 1;
                    louLabel.tag = 112;
                    louLabel.textColor = [UIColor whiteColor];
                    [louImageView addSubview:louLabel];
                    louLabel.text = @"漏";
                }
                for (int j = 0; j<10; j++) {
//                    int a= j/5,b = j%5;
                    int a= j/6,b = j%6;
                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j];
//                    if (SWITCH_ON) {
//                        ballRect = CGRectMake(b*50+55, a*52+7, 35, 35);
//                    }else{
//                        ballRect = CGRectMake(b*50+55, a*37+7, 35, 35);
//                    }
                    if (SWITCH_ON) {
                        ballRect = CGRectMake(b*51+14, a*52+35, 35, 35);
                    }else{
                        ballRect = CGRectMake(b*51+14, a*40+35, 35, 35);
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastRedBallView=im;
                    [im release];
                }
//                if (SWITCH_ON)
//                {
//                    clearBtn.frame=CGRectMake(4*51+14+3, 52+35+4, 30, 28);
//                    lajitonggaiIma.frame=CGRectMake(4*51+14+9, 52+35+4+2, 18, 5);
//                    lajitongIma.frame=CGRectMake(4*51+14+9, 52+35+4+2+6, 18, 18);
//                }
//                else
//                {
//                    clearBtn.frame=CGRectMake(4*51+14+3, 40+35+4, 30, 28);
//                    lajitonggaiIma.frame=CGRectMake(4*51+14+9, 40+35+4+2, 18, 5);
//                    lajitongIma.frame=CGRectMake(4*51+14+9, 40+35+4+2+6, 18, 18);
//                }
            }
            else {//2~6
//                if(i==2)
//                {
                    UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 70+2, 18, 13)] autorelease];
                    louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
                    louImageView.tag = 111;
                    [firstView addSubview:louImageView];
                    if (!SWITCH_ON) {
                        louImageView.hidden = YES;
                    }
                    
                    UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
                    louLabel.backgroundColor = [UIColor clearColor];
                    louLabel.font = [UIFont systemFontOfSize:11];
                    louLabel.textAlignment = 1;
                    louLabel.tag = 112;
                    louLabel.textColor = [UIColor whiteColor];
                    [louImageView addSubview:louLabel];
                    louLabel.text = @"漏";
//                }
                for (int j = 0; j<10; j++) {
//                    int a= j/5,b = j%5;
                    int a= j/6,b = j%6;
                    NSString *num = [NSString stringWithFormat:@"%d",j];
//                    if (SWITCH_ON) {
//                        ballRect = CGRectMake(b*50+55, a*52+7, 35, 35);
//                    }else{
//                        ballRect = CGRectMake(b*50+55, a*37+7, 35, 35);
//                    }
                    if (SWITCH_ON) {
                        ballRect = CGRectMake(b*51+14, a*52+35, 35, 35);
                    }else{
                        ballRect = CGRectMake(b*51+14, a*40+35, 35, 35);
                    }
                    
                    GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastRedBallView=im;
                    [im release];
                }
//                if (SWITCH_ON)
//                {
//                    clearBtn.frame=CGRectMake(4*51+14+3, 52+35+4, 30, 28);
//                    lajitonggaiIma.frame=CGRectMake(4*51+14+9, 52+35+4+2, 18, 5);
//                    lajitongIma.frame=CGRectMake(4*51+14+9, 52+35+4+2+6, 18, 18);
//                }
//                else
//                {
//                    clearBtn.frame=CGRectMake(4*51+14+3, 40+35+4, 30, 28);
//                    lajitonggaiIma.frame=CGRectMake(4*51+14+9, 40+35+4+2, 18, 5);
//                    lajitongIma.frame=CGRectMake(4*51+14+9, 40+35+4+2+6, 18, 18);
//                }
            }
            GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 15, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
            redTrashButton.tag = 333;
            redTrashButton.delegate=self;
            [firstView addSubview:redTrashButton];
            
            firstView.userInteractionEnabled = YES;
            
        }
        else {
            
        }
        
		[backScrollView addSubview:firstView];

//        UIImageView * missingValues = [[UIImageView alloc] initWithFrame:CGRectMake(44, 40, 12.5, 12.5)];
//        missingValues.image = UIImageGetImageFromName(@"MissingValues.png");
//        [firstView addSubview:missingValues];
//        if (!SWITCH_ON) {
//            missingValues.hidden = YES;
//        }
//        missingValues.tag = 99;
//        [missingValues release];
        
		[firstView release];
	}
    
    descriptionLabel = [[UILabel alloc] init];
//    [backScrollView addSubview:descriptionLabel];
    descriptionLabel.textColor = [UIColor darkGrayColor];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    
    zaixianLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 346, 150, 30)];
	zaixianLabel.text = nil;
	zaixianLabel.changeColor = [UIColor redColor];
    zaixianLabel.font = [UIFont systemFontOfSize:10];
    zaixianLabel.colorfont = [UIFont systemFontOfSize:12];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[backScrollView addSubview:zaixianLabel];
	[zaixianLabel release];
	
	imageruan = [[UIImageView alloc] initWithFrame:CGRectMake(103, 343, 205, 25)];
	[backScrollView addSubview:imageruan];
//---------------------------------------------bianpinghua by sichuanlin
//    imageruan.image = [UIImageGetImageFromName(@"GC_sqkjback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    imageruan.backgroundColor=[UIColor clearColor];
    imageruan.layer.cornerRadius=4.0;
    
    imageruan.layer.masksToBounds = YES;
	
	ranLabel = [[ColorView alloc] initWithFrame:CGRectMake(0, 5, 260, 16)];
	ranLabel.text = @"";
    ranLabel.textAlignment = NSTextAlignmentCenter;
	ranLabel.font = [UIFont systemFontOfSize:10];
	ranLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	ranLabel.changeColor = [UIColor redColor];
	ranLabel.backgroundColor = [UIColor clearColor];
	[imageruan addSubview:ranLabel];
    
    ranNameLabel = [[ UILabel alloc] initWithFrame:CGRectMake(0, 3, 30, 16)];
    ranNameLabel.text = @"";
    ranNameLabel.textAlignment = NSTextAlignmentCenter;
	ranNameLabel.font = [UIFont systemFontOfSize:10];
    ranNameLabel.backgroundColor = [UIColor clearColor];
	ranNameLabel.textColor = [UIColor blackColor];
	[imageruan addSubview:ranNameLabel];
    [ranNameLabel release];
    
	[ranLabel release];
	[imageruan release];
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
//---------------------------------------------bianpinghua by sichuanlin
//	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    im.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
	
//    //清按钮
//    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qingbutton.frame = CGRectMake(12, 10, 30, 30);
//    //[qingbutton setImage:UIImageGetImageFromName(@"gc_fb_14.png") forState:UIControlStateNormal];
//    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.backgroundColor=[UIColor clearColor];
    zhubg.layer.masksToBounds=YES;
    zhubg.layer.cornerRadius=4.0;
    
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.textColor=[UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
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
	jineLabel.font = [UIFont boldSystemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor blackColor];
	jin.backgroundColor = [UIColor clearColor];
    jin.textColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(230, 7, 80, 33);
	[im addSubview:senBtn];
    
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
//---------------------------------------------bianpinghua by sichuanlin
//    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    senImage.tag = 1108;
    [senBtn addSubview:senImage];
    [senImage release];
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    senLabel.tag = 1101;
    senLabel.font = [UIFont systemFontOfSize:18];
    [senBtn addSubview:senLabel];
    [senLabel release];
}
//-(void)clearAllTap: (UIButton *)sender
//{
//    NSLog(@"%d",sender.tag);
//    UIView *ballView = [self.mainView viewWithTag:1000+sender.tag-2050];
//    for (GCBallView *ball in ballView.subviews) {
//        if ([ball isKindOfClass:[GCBallView class]]) {
//            ball.selected = NO;
//        }
//    }
//    [self ballSelectChange:nil];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"event_goumai_gaopincai_shishicai"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssueInfo) name:@"BecomeActive" object:nil];
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
    
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
	
//    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
//    [self.mainView addSubview:bgimageview];
//    [bgimageview release];
    
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height-50)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.scrollEnabled = YES;
    [self.mainView addSubview:backScrollView];
    [backScrollView release];
    
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
//---------------------------------------------bianpinghua by sichuanlin
//            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
            
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
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
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

-(void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId =LOTTERY_ID;
    controller.lotteryName = @"时时彩";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        [self toHistory];
    }
    else if (index == 1) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self pressTitleButton:nil];
        
    }
    else if (index == 2) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        [self changeTitle];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
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
    else if (index == 3) {
        [self wanfaInfo];
    }
}

#pragma mark - switchChange

-(void)switchChange
{
    float heght =85;
    int count = 4;
    for (int i = 1000;i<1009;i++) {
        UIView *v = [backScrollView viewWithTag:i];

        GifButton * trashButton = (GifButton *)[v viewWithTag:333];
        GCBallView * lastBallView;
        if (i >= 1002) {
            if (SWITCH_ON) {
                v.frame = CGRectMake(0, 85 + i*150, 320, 150);
            }else{
                v.frame = CGRectMake(0, 85 + i*120, 320, 120);

            }
            count = 10;
        }
        for (int j = 0; j < count; j++) {
            int a= j/6,b = j%6;
            GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
            if (SWITCH_ON) {
                if (i > 1001) {
                    ballView.frame = CGRectMake(b*51+14, a*52+35, 35, 35);
                }
                ballView.ylLable.hidden = NO;
            }else{
                if (i > 1001) {
                    ballView.frame = CGRectMake(b*51+14, a*40+35, 35, 35);
                }
                ballView.ylLable.hidden = YES;
            }
            lastBallView=ballView;
        }
        if(count != 0)
            trashButton.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
        heght = heght + v.bounds.size.height-1;
    }
}


#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
//    if (buttonIndex == 1) {


    if ([returnarry count] == 1) {
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

-(void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView
{
    titleBtnIsCanPress = YES;
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    [self guanbidonghua];
    isShowing = NO;
    [alert2 release];
    [self addNavAgain];
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
#pragma mark -
#pragma mark Action


- (void)pressMenu {
    if(isShowing)
    {
        [self guanbidonghua];
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
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
        if(seconds/60 == 0)
        {
            mytimeLabel3.textColor=[UIColor colorWithRed:250/255.0 green:208/255.0 blue:5/255.0 alpha:1];
        }
        else
        {
            mytimeLabel3.textColor=[UIColor blackColor];
        }
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
	if ([self.zhongJiang.brInforArray count] != 0) {
        imageruan.alpha = 1;
		runCount = runCount%[self.zhongJiang.brInforArray count];
		ranLabel.alpha = 1;
        ranNameLabel.alpha = 1;
        NSArray *array = [[self.zhongJiang.brInforArray objectAtIndex:runCount] componentsSeparatedByString:@"@"];
        if ([array count] == 2) {

            
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

- (void)getWangqi{
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
	NSString *st = @"^", *sr = @",";
	
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
    if (modetype == SSCdaxiaodanshuang) {
        for (int i = 0; i < 2; i++) {
            UIView *ballView = [backScrollView viewWithTag:1000+i];
//            UIView *laji=[ballView viewWithTag:2060+i];
            GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
            if (ballView.hidden == NO) {
                if ([mStr length] > 0) {
                    [mStr appendString:sr];
                }
                //NSArray *array = [mSectionArray objectAtIndex:i];
                NSInteger selNum = 0;
                NSMutableString *num = [NSMutableString string];
                for (int k = 0; k < 10; k++) {
                    GCBallView *ball = (GCBallView *)[ballView viewWithTag:k];
                    
                    if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
                        if (k== 0) {
                            [num appendString:[NSString stringWithFormat:@"%d",9]];
                        }
                        else {
                            [num appendString:[NSString stringWithFormat:@"%d",(int)ball.tag-1]];
                        }
                        
                        [num appendString:st];
                        selNum += 1;
                    }
                    
                }
                if ([num length]!=0) {
                    [mStr appendString:num];
                }
                else {
                    [mStr appendString:@"e"];
                }
                
                if (selNum > 0) {
                    [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                }
                if(selNum!=0)
                {
//                    laji.hidden=NO;
                    trashButton.hidden=NO;
                }
                else
                {
//                    laji.hidden=YES;
                    trashButton.hidden=YES;
                }
                
            }
        }
    }
    else if (modetype == SSCerxingzuxuandantuo) {
        for (int i = 7; i < 9; i++) {
            UIView *ballView = [backScrollView viewWithTag:1000+i];
//            UIView *laji=[ballView viewWithTag:2060+i];
            GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
            if (ballView.hidden == NO) {
                if ([mStr length] > 0) {
                    [mStr appendString:sr];
                }
                //NSArray *array = [mSectionArray objectAtIndex:i];
                NSInteger selNum = 0;
                NSMutableString *num = [NSMutableString string];
                for (int k = 0; k < 10; k++) {
                    GCBallView *ball = (GCBallView *)[ballView viewWithTag:k];
                    
                    if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
                        [num appendString:[NSString stringWithFormat:@"%ld",(long)ball.tag]];
                        [num appendString:st];
                        selNum += 1;
                    }
                    
                }
                if ([num length]!=0) {
                    [mStr appendString:num];
                }
                else {
                    [mStr appendString:@"e"];
                }
                
                if (selNum > 0) {
                    [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                }
                if(selNum!=0)
                {
                    trashButton.hidden=NO;
//                    laji.hidden=NO;
                }
                else
                {
                    trashButton.hidden=YES;
//                    laji.hidden=YES;
                }
                
            }
        }
    }
    else if (modetype>= SSCrenxuanyi && modetype <= SSCrenxuansan){
        for (int i = 2; i < 7; i++) {
            UIView *ballView = [backScrollView viewWithTag:1000+i];
//            UIView *laji=[ballView viewWithTag:2060+i];
            GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
            if (ballView.hidden == NO) {
                if ([mStr length] > 0) {
                    [mStr appendString:sr];
                }
                //NSArray *array = [mSectionArray objectAtIndex:i];
                NSInteger selNum = 0;
                NSMutableString *num = [NSMutableString string];
                for (int k = 0; k < 10; k++) {
                    GCBallView *ball = (GCBallView *)[ballView viewWithTag:k];
                    
                    if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
                        [num appendString:[NSString stringWithFormat:@"%ld",(long)ball.tag]];
                        [num appendString:st];
                        selNum += 1;
                    }
                    
                }
                if ([num length]!=0) {
                    [mStr appendString:num];
                }
                else {
                    [mStr appendString:@"_"];
                }
                
                if (selNum > 0) {
                    [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                }
                if(selNum!=0)
                {
                    trashButton.hidden=NO;
//                    laji.hidden=NO;
                }
                else
                {
                    trashButton.hidden=YES;
//                    laji.hidden=YES;
                }
            }
        }
    }
    else {
        for (int i = 2; i < 7; i++) {
            UIView *ballView = [backScrollView viewWithTag:1000+i];
//            UIView *laji=[ballView viewWithTag:2060+i];
            GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
            if (ballView.hidden == NO) {
                if ([mStr length] > 0) {
                    [mStr appendString:sr];
                }
                //NSArray *array = [mSectionArray objectAtIndex:i];
                NSInteger selNum = 0;
                NSMutableString *num = [NSMutableString string];
                for (int k = 0; k < 10; k++) {
                    GCBallView *ball = (GCBallView *)[ballView viewWithTag:k];
                    
                    if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
                        [num appendString:[NSString stringWithFormat:@"%ld",(long)ball.tag]];
                        [num appendString:st];
                        selNum += 1;
                    }
                    
                }
                if ([num length]!=0) {
                    [mStr appendString:num];
                }
                else {
                    [mStr appendString:@"e"];
                }
                
                if (selNum > 0) {
                    [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                }
                if(selNum!=0)
                {
                    trashButton.hidden=NO;
//                    laji.hidden=NO;
                }
                else
                {
                    trashButton.hidden=YES;
//                    laji.hidden=YES;
                }
                
            }
        }
    }
	
	
	return (NSString *)mStr;
}

- (void)send {
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([labe.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
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
    
    if ([zhushuLabel.text intValue] == 1 && modetype == SSCerxingzuxuandantuo) {
        
        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码与拖码个数不少于3个号码"];
        return;
    }
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    if (modetype == SSCdaxiaodanshuang) {
        int b = 0;
        int d = 0;
        UIView *Rview = [backScrollView viewWithTag:1000];
        UIView *Dview = [backScrollView viewWithTag:1001];
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
        if (b < 1 || d < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1种性质"];
            return;
        }

    }
    if (modetype == SSCerxingfushi) {
        int b = 0;
        int d = 0;
        UIView *Rview = [backScrollView viewWithTag:1005];
        UIView *Dview = [backScrollView viewWithTag:1006];
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
        if (b < 1 || d < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCerxingzuxuan) {
        int b = 0;
        int d = 0;
        UIView *Rview = [backScrollView viewWithTag:1005];
        UIView *Dview = [backScrollView viewWithTag:1006];
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
        if (b < 1 || d < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCerxingzuxuandantuo) {
        int b = 0;
        int d = 0;
        UIView *Rview = [backScrollView viewWithTag:1007];
        UIView *Dview = [backScrollView viewWithTag:1008];
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
        if (b < 1 || d < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码拖码各选1个"];
            return;
        }
        
    }
    if (modetype == SSCsanxingfushi) {
        int b = 0;
        int d = 0;
        int f = 0;
        UIView *Rview = [backScrollView viewWithTag:1004];
        UIView *Dview = [backScrollView viewWithTag:1005];
        UIView *Fview = [backScrollView viewWithTag:1006];
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
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                }
            }
            
        }
        if (b < 1 || d < 1 || f < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCsixingfushi) {
        int b = 0;
        int d = 0;
        int f = 0;
        int e = 0;
        UIView *Rview = [backScrollView viewWithTag:1003];
        UIView *Dview = [backScrollView viewWithTag:1004];
        UIView *Fview = [backScrollView viewWithTag:1005];
        UIView *Eview = [backScrollView viewWithTag:1006];
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
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                }
            }
            
        }
        for (GCBallView *bt4 in Eview.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    e++;
                }
            }
            
        }
        if (b < 1 || d < 1 || f < 1 || e < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCwuxingfushi) {
        int b = 0;
        int d = 0;
        int f = 0;
        int e = 0;
        int g = 0;
        UIView *Rview = [backScrollView viewWithTag:1002];
        UIView *Dview = [backScrollView viewWithTag:1003];
        UIView *Fview = [backScrollView viewWithTag:1004];
        UIView *Eview = [backScrollView viewWithTag:1005];
        UIView *Gview = [backScrollView viewWithTag:1006];
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
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                }
            }
            
        }
        for (GCBallView *bt4 in Eview.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    e++;
                }
            }
            
        }
        for (GCBallView *bt5 in Gview.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    g++;
                }
            }
            
        }
        if (b < 1 || d < 1 || f < 1 || e < 1 || g < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCwuxingtongxuan) {
        int b = 0;
        int d = 0;
        int f = 0;
        int e = 0;
        int g = 0;
        UIView *Rview = [backScrollView viewWithTag:1002];
        UIView *Dview = [backScrollView viewWithTag:1003];
        UIView *Fview = [backScrollView viewWithTag:1004];
        UIView *Eview = [backScrollView viewWithTag:1005];
        UIView *Gview = [backScrollView viewWithTag:1006];
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
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                }
            }
            
        }
        for (GCBallView *bt4 in Eview.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    e++;
                }
            }
            
        }
        for (GCBallView *bt5 in Gview.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    g++;
                }
            }
            
        }
        if (b < 1 || d < 1 || f < 1 || e < 1 || g < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (modetype == SSCrenxuaner) {
        int b = 0;
        int d = 0;
        int f = 0;
        int e = 0;
        int g = 0;
        UIView *Rview = [backScrollView viewWithTag:1002];
        UIView *Dview = [backScrollView viewWithTag:1003];
        UIView *Fview = [backScrollView viewWithTag:1004];
        UIView *Eview = [backScrollView viewWithTag:1005];
        UIView *Gview = [backScrollView viewWithTag:1006];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt4 in Eview.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    e++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt5 in Gview.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    g++;
                    break;
                }
            }
            
        }
        if ((b + d + f + e + g) < 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择2个号码,定位选择"];
            return;
        }
        
    }
    if (modetype == SSCrenxuansan) {
        int b = 0;
        int d = 0;
        int f = 0;
        int e = 0;
        int g = 0;
        UIView *Rview = [backScrollView viewWithTag:1002];
        UIView *Dview = [backScrollView viewWithTag:1003];
        UIView *Fview = [backScrollView viewWithTag:1004];
        UIView *Eview = [backScrollView viewWithTag:1005];
        UIView *Gview = [backScrollView viewWithTag:1006];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt4 in Eview.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    e++;
                    break;
                }
            }
            
        }
        for (GCBallView *bt5 in Gview.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    g++;
                    break;
                }
            }
            
        }
        if ((b + d + f + e + g) < 3) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择3个号码,定位选择"];
            return;
        }
        
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        NSString *selet = [self seletNumber];
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        
        if (modetype == SSCerxingzuxuandantuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiShiCai;
        }
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;
        NSString *selet = [self seletNumber];
        
        if (modetype == SSCerxingzuxuandantuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
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
	if (modetype == SSCerxingzuxuandantuo) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"胆拖模式不支持"];
        return;
    }
    else if (modetype >= SSCrenxuanyi && modetype <= SSCrenxuansan){
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:modetype - SSCrenxuanyi +1 start:0 maxnum:4];
        for (int i = 2;i<7;i++) {
            UIView *v = [backScrollView viewWithTag:1000+i];
            if (v.hidden == NO) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                for (int a = 0; a < 10; a++) {
                    if ([randArray indexOfObject:[NSString stringWithFormat:@"%d",i-2]]<=3) {
                        GCBallView *ball = (GCBallView *)[v viewWithTag:a];
                        if ([ball isKindOfClass:[GCBallView class]]) {
                            if (ball.tag == [[redBalls objectAtIndex:0] intValue]) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                        }
                    }
                    else {
                        GCBallView *ball = (GCBallView *)[v viewWithTag:a];
                        if ([ball isKindOfClass:[GCBallView class]]) {
                            ball.selected = NO;
                        }
                    }
                }
                
            }
        }
        
    }
    else if (modetype == SSCdaxiaodanshuang){
        for (int i = 0;i<2;i++) {
            UIView *v = [backScrollView viewWithTag:1000+i];
            if (v.hidden == NO) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:3];
                for (int a = 0; a < 10; a++) {
                    GCBallView *ball = (GCBallView *)[v viewWithTag:a];
                    if ([ball isKindOfClass:[GCBallView class]]) {
                        if (ball.tag == [[redBalls objectAtIndex:0] intValue]) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                }
                
            }
        }
    }
    else if (modetype == SSCerxingzuxuan){
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
        for (int i = 2;i<7;i++) {
            UIView *v = [backScrollView viewWithTag:1000+i];
            
            if (v.hidden == NO) {
                for (int a = 0; a < 10; a++) {
                    GCBallView *ball = (GCBallView *)[v viewWithTag:a];
                    NSInteger t = 0;
                    if (i == 6) {
                        t = 1;
                    }
                    if ([ball isKindOfClass:[GCBallView class]]) {
                        if (t < [redBalls count]) {
                            if (ball.tag == [[redBalls objectAtIndex:t] intValue]) {
                                ball.selected = YES;
                                
                            }
                            else {
                                ball.selected = NO;
                            }
                        }
                        
                    }
                    
                }
            }
        }
        
    }
    else {
        for (int i = 2;i<7;i++) {
            UIView *v = [backScrollView viewWithTag:1000+i];
            if (v.hidden == NO) {
                NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                for (int a = 0; a < 10; a++) {
                    GCBallView *ball = (GCBallView *)[v viewWithTag:a];
                    if ([ball isKindOfClass:[GCBallView class]]) {
                        if (ball.tag == [[redBalls objectAtIndex:0] intValue]) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
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
            [self zhankaidonghua];
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
            [self guanbidonghua];
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
	titleLabel.text = [NSString  stringWithFormat:@"时时彩-%@", [wanArray objectAtIndex:sender.tag - 1]];
    
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
    float heght1 = 0;
    
    [self guanbidonghua];
    
    for (int i = 1000;i<1009;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        v.hidden = YES;
        UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
        louIma.hidden=YES;
        UILabel *louLab=(UILabel *)[v viewWithTag:112];
        louLab.hidden=YES;
    }
    yaoImage.hidden = NO;
    yaolabel.hidden = NO;
    randBtn.hidden = NO;
    if (self.issue) {
//        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",[self changeModetypeToString:modetype],self.issue];
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",[self changeModetypeToString:modetype],[SharedMethod getLastThreeStr:self.issue]];
    }
    else {
        titleLabel.text = [NSString stringWithFormat:@"时时彩-%@",[self changeModetypeToString:modetype]];
    }
    
    yaoImage.hidden = NO;
    colorLabel.frame = CGRectMake(40, 53, 265, 19);
        switch (modetype) {
            case SSCdaxiaodanshuang:
            {
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }
                
                colorLabel.text = @"猜中开奖号最后2位的属性即中<4>元";
                infoLable.text = @"至少选一个属性";

                for (int i = 1000;i<1002;i++) {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(SWITCH_ON)
                    {
                        UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                        louIma.hidden=NO;
                        UILabel *louLab=(UILabel *)[v viewWithTag:112];
                        louLab.hidden=NO;
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"dxdsst"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCyixingfushi:
            {
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }


                colorLabel.text = @"猜中开奖号最后1位即奖<10>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1006;i<1007;i++) {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(SWITCH_ON)
                    {
                        UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                        louIma.hidden=NO;
                        UILabel *louLab=(UILabel *)[v viewWithTag:112];
                        louLab.hidden=NO;
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCerxingfushi:
            {
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"按位猜中开奖号后2位即奖<100>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1005;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1005)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCerxingzuxuan:
            {
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"猜中开奖号后2位(顺序不限)即奖<50>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1005;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1005)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCerxingzuxuandantuo:
            {
                yaoImage.hidden = YES;
                yaolabel.hidden = NO;
                colorLabel.frame = CGRectMake(19, 53, 265, 19);
                randBtn.hidden = NO;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:15];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(5+15, 0, 220, 44);
//                    la.frame = CGRectMake(176, 14, 17, 17);
                    la.frame = CGRectMake(155, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(25, 0, 220, 44);
//                    la.frame = CGRectMake(195, 14.5, 17, 17);
                    la.frame = CGRectMake(155, 14.5, 17, 17);
                }


                colorLabel.text = @"猜中开奖号后2位(顺序不限)即奖<50>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1007;i<1009;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(SWITCH_ON)
                    {
                        UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                        louIma.hidden=NO;
                        UILabel *louLab=(UILabel *)[v viewWithTag:112];
                        louLab.hidden=NO;
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:self.yilouDic typeStr:@"rt"];
                }
            }
                break;
            case SSCsanxingfushi:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"按位猜中开奖号后3位即奖<1000>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1004;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1004)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCsixingfushi:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"按位猜中开奖号后4位即奖<10000>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1003;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1003)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
                
            case SSCwuxingfushi:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"按位猜中全部5个号即奖<100000>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1002;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1002)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCwuxingtongxuan:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(15+15, 0, 220, 44);
//                    la.frame = CGRectMake(175, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(32, 0, 220, 44);
//                    la.frame = CGRectMake(191, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"按位猜中全部5个号 最高奖<20220>元";
                infoLable.text = @"至少选1个号";
                for (int i = 1002;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1002)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCrenxuanyi:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(27+15, 0, 220, 44);
//                    la.frame = CGRectMake(172, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(40, 0, 220, 44);
//                    la.frame = CGRectMake(185, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }
                
                colorLabel.text = @"猜中开奖号对应的1位即奖<10>元";
                infoLable.text = @"至少选择1位数字";
                for (int i = 1002;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1002)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCrenxuaner:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(27+15, 0, 220, 44);
//                    la.frame = CGRectMake(172, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(40, 0, 220, 44);
//                    la.frame = CGRectMake(185, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }

                colorLabel.text = @"猜中开奖号对应的2位即奖<100>元";
                infoLable.text = @"至少选择2位数字";
                for (int i = 1002;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1002)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
            case SSCrenxuansan:
            {
                heght1 = 25;
                UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
                tl.font = [UIFont boldSystemFontOfSize:17];
                UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
                if ([[[Info getInstance] userId] intValue] == 0) {
                    tl.frame = CGRectMake(27+15, 0, 220, 44);
//                    la.frame = CGRectMake(172, 14, 17, 17);
                    la.frame = CGRectMake(150, 14, 17, 17);
                }else {
                    
                    tl.frame = CGRectMake(40, 0, 220, 44);
//                    la.frame = CGRectMake(185, 14.5, 17, 17);
                    la.frame = CGRectMake(150, 14.5, 17, 17);
                }
                colorLabel.text = @"猜中开奖号对应的3位即奖<1000>元";
                infoLable.text = @"至少选择3位数字";
                for (int i = 1002;i<1007;i++)   {
                    UIView *v = [backScrollView viewWithTag:i];
                    v.hidden = NO;
                    if(i == 1002)
                    {
                        if(SWITCH_ON)
                        {
                            UIImageView *louIma=(UIImageView *)[v viewWithTag:111];
                            louIma.hidden=NO;
                            UILabel *louLab=(UILabel *)[v viewWithTag:112];
                            louLab.hidden=NO;
                        }
                    }
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:[self.yilouDic valueForKey:@"wxt"] typeStr:[yiLouTypeArr objectAtIndex:1007 - i - 1]];
                }
            }
                break;
                
            default:
                break;
        }
    float heght =85;
    for (int i = 1000;i<1009;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        if (v.hidden == NO) {
                v.frame = CGRectMake(v.frame.origin.x,heght , v.bounds.size.width, v.bounds.size.height);
                heght = heght + v.frame.size.height-1;
        }
    }
//    if (backScrollView.frame.size.height > heght + 25) {
//        heght = backScrollView.frame.size.height - 25;
//    }dd
    backScrollView.contentSize = CGSizeMake(320,heght +25 + heght1);
    
    if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + 44 + isIOS7Pianyi);
    
    zaixianLabel.frame = CGRectMake(zaixianLabel.frame.origin.x, _mainView.frame.size.height - 30, zaixianLabel.bounds.size.width, zaixianLabel.bounds.size.height);
    imageruan.frame = CGRectMake(imageruan.frame.origin.x, zaixianLabel.frame.origin.y - 2.5, imageruan.bounds.size.width, imageruan.bounds.size.height);
    
}


- (void)pressBgButton:(UIButton *)sender{
    if (sender.tag <= [wanArray count]) {
        
        
        NSString *str = [wanArray objectAtIndex:sender.tag];
        modetype = [self changeStringToMode:str];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"ShiShiCaiDefaultModetype"];
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
    xie.ALLWANFA = ShiShiCai;
	[self.navigationController pushViewController:xie animated:YES];
//    xie.infoText.text = @"大小单双 \n0—4为小号,5—9为大号, 1、3、5、7、9为单号,0、2、4、6、8为双号, 每位各选1个或多个数字投注,所选数字与开奖的前2位数 字性质按位置相符即中奖,奖金4元。\n一星复式 \n至少选择1个数字投注,命中开奖数字的个位即中奖,奖 金10元。\n二星复式 \n个、十位各选1个或多个数字投注,按位置分别命中开奖 数字的个、十位即中奖,奖金100元。\n二星组选 \n个、十位各选1个或多个数字投注,命中开奖数字的个、 十位数字即中奖,奖金50元。\n二星组选胆拖 \n胆码只能选择1个数字,拖码至少选择1个数字进行投注, 命中开奖数字的个、十位数字即中奖,奖金50元。\n三星复式 \n个、十、百位各选1个或多个数字投注,按位置分别命中 开奖数字的个、十、百位即中奖,奖金1000元。\n四星复式 \n个、十、百、千位各选1个或多个数字投注,按位置分别 命中开奖数字的个、十、百、千位即中奖,奖金10000元。\n五星复式 \n每位各选1个或多个数字投注,按位置全部命中即中奖, 奖金100000元。\n五星通选 \n每位各选1个或多个数字投注: 1.与开奖数字完全相同,奖金20000元。 2.首或尾连续三位数数字与开奖数字按位相同,奖金200 元。 3.首或尾连续二位数数字与开奖数字按位相同,奖金20元。\n任选一 从5位中定位选择1个或多个数字,数字和位置与开奖数字 相符即中奖,奖金10元。\n任选二 从5位中定位选择2个或多个数字,数字和位置与开奖数字 相符即中奖,奖金100元。\n任选三 从5位中定位选择3个或多个数字,数字和位置与开奖数字 相符即中奖,奖金1000元。";
//	xie.infoText.font = [UIFont systemFontOfSize:11];
//	xie.title = @"时时彩玩法介绍";
	[xie release];
	
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        if (modetype != SSCerxingzuxuandantuo) {

            [self randBalls];
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
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
    if (modetype == SSCerxingzuxuandantuo && imageView) {
        int tag = 1008;
        
        if (imageView.superview.tag == 1008) {
            tag = 1007;
        }
        else if(imageView.superview.tag == 1008) {
            tag = 1008;
        }
        UIView *v = [backScrollView viewWithTag:tag];
        GCBallView *ball = (GCBallView *)[v viewWithTag:imageView.tag];
        if (ball.selected == YES) {
            imageView.selected = NO;
            [[caiboAppDelegate getAppDelegate] showMessage:@"胆码和拖码不能相同"];
            return;
        }
        if (imageView.superview.tag == 1007) {
            for (GCBallView *ball in imageView.superview.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&&ball.selected == YES && ball != imageView) {
                    imageView.selected = NO;
                    [[caiboAppDelegate getAppDelegate] showMessage:@"胆码只能选一个"];
                    return;
                }
            }
        }
        
        UIView * v1 = nil;
        UIView * v2 = nil;
        if(imageView.superview.tag == 1007)
        {
            v1 = [backScrollView viewWithTag:1008];
            v2 = [backScrollView viewWithTag:1007];
        }
        else if(imageView.superview.tag==1008)
        {
            v1 = [backScrollView viewWithTag:1007];
            v2 = [backScrollView viewWithTag:1008];
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
    if (modetype == SSCerxingzuxuan && imageView) {
        int tag = 1005;
        
        if (imageView.superview.tag == 1005) {
            tag = 1006;
        }
        else if(imageView.superview.tag == 1006) {
            tag = 1005;
        }
        UIView *v = [backScrollView viewWithTag:tag];
        GCBallView *ball = (GCBallView *)[v viewWithTag:imageView.tag];
        if (ball.selected == YES) {
            imageView.selected = NO;
            [[caiboAppDelegate getAppDelegate] showMessage:@"两个号码不能相同"];
            return;
        }        
    }
	NSUInteger bets = 0;
    bets = [GC_LotteryUtil getBets:[[[self seletNumber] stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@""] LotteryType:lotterytype ModeType:modetype];
	
    zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",2*(unsigned long)bets];
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    UIImageView *ima = (UIImageView *)[senBtn viewWithTag:1108];
    NSString *str =[[[[[self seletNumber] stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (!(modetype == SSCerxingzuxuandantuo)) {
        if ([str length] == 0) {
            ima.alpha = 1;
            labe.text = @"机选";
            labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
            senBtn.enabled = YES;
        }
        else {
            ima.alpha = 1;
            labe.text = @"选好了";
            labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
            senBtn.enabled = YES;
        }
    }else {
    
        if (!([str length] == 0)) {
            
            ima.alpha = 1;
            labe.text = @"选好了";
            labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
            
        }else if ([str length] == 0) {
            
            ima.alpha = 0.5;
            labe.text = @"选好了";
            labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
            
        }

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
//		zaixianLabel.text = [NSString stringWithFormat:@"在线<%d>人",wang.AllNum];
		[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidenranLabel) object:nil];
		self.runTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showranLabel) userInfo:nil repeats:YES];
        [wang release];
        //		[myPicker reloadAllComponents];
	}
}

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
//		self.wangQi = wang;
//		[mytableView reloadData];
//        [_cpTableView reloadData];
        
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
//                timeLabel.text = [NSString stringWithFormat:@"%@",issrecord.curIssue];
//                 timeLabel.text = [NSString stringWithFormat:@"%@",[SharedMethod getLastThreeStr:issrecord.curIssue]];
                timeLabel.text = [NSString stringWithFormat:@"距%@",[SharedMethod getLastThreeStr:issrecord.curIssue]];
                mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(int)seconds/60,(int)seconds%60];
                if(seconds/60 == 0)
                {
                    mytimeLabel3.textColor=[UIColor colorWithRed:250/255.0 green:208/255.0 blue:5/255.0 alpha:1];
                }
                else
                {
                    mytimeLabel3.textColor=[UIColor blackColor];
                }
            }
            yanchiTime = [issrecord.lotteryStatus intValue];
            sqkaijiang.text = [NSString stringWithFormat:@"%@>",[issrecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"#0" withString:@"期开奖 <"]];
            sqkaijiang.text = [sqkaijiang.text stringByReplacingOccurrencesOfString:@",0" withString:@" "];
            if(sqkaijiang.text.length >= 16)
            {
                sqkaijiang.text = [sqkaijiang.text substringFromIndex:sqkaijiang.text.length-18];
            }
            if ([self.issue length] && ![self.issue isEqualToString:issrecord.curIssue] && isAppear) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@期已截止>\n当前期是%@期，投注时请注意期次",[SharedMethod getLastThreeStr:self.issue],[SharedMethod getLastThreeStr:issrecord.curIssue]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.alertTpye = jieQiType;
                [alert show];
                [alert release];
            }
            self.issue = issrecord.curIssue;

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
                    [self getYilou];
                }else if (!hasYiLou && canRefreshYiLou) {
                    [self getYilou];
                }
                canRefreshYiLou = YES;
                
                self.myIssrecord = issrecord.curIssue;
            }
            if (![self.issue isEqualToString:issrecord.curIssue] || !self.zhongJiang) {
                NSMutableData *postData = [[GC_HttpService sharedInstance] reZhongjiangWithLottery:LOTTERY_ID iss:[NSString stringWithFormat:@"%d",[self.issue intValue] - 1] countOfPage:50];
                
                [myRequest clearDelegatesAndCancel];
                self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                [myRequest setRequestMethod:@"POST"];
                [myRequest addCommHeaders];
                [myRequest setPostBody:postData];
                [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [myRequest setDelegate:self];
                [myRequest setDidFinishSelector:@selector(reqZhongJiang:)];
//                [myRequest startAsynchronous];
            }
            [self.myTimer invalidate];
            self.myTimer = nil;
            [self performSelectorInBackground:@selector(createTimer) withObject:nil];
            
//            [self changeTitle];
            

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

- (void)getYilou {
    self.yilouDic = nil;
    [self changeTitle];
    
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID];
    
    if([yilou_Dic objectForKey:self.issue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
        return;
    }
    
    [self.yilouRequest clearDelegatesAndCancel];
    if (!myIssrecord) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:@""]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:@"" cacheable:YES]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(rebuyFail:)];
    [yilouRequest startAsynchronous];
}

- (void)rebuyFail:(ASIHTTPRequest*)request
{
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}


- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    if ([[yilouDic objectForKey:@"wxt"] count]) {
        
        hasYiLou = YES;

    }else{
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    
    [self changeTitle];
    
}

- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"] && [responseStr length]) {
        NSArray * array = [[responseStr JSONValue] valueForKey:@"list"];
        if ([array count]) {
            self.yilouDic = [self addDaXiaoDanShuang:[array objectAtIndex:0]];
            if ([[yilouDic objectForKey:@"wxt"] count]) {
                
                //删除旧的遗漏值
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID];
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID];
                
                hasYiLou = YES;
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

- (NSDictionary *)addDaXiaoDanShuang:(NSDictionary *)dic {
    NSDictionary *dic4 = [[dic objectForKey:@"dxdsst"] objectForKey:@"dx"];
    NSDictionary *dic5 = [[dic objectForKey:@"dxdsst"] objectForKey:@"ds"];
    NSArray *array5 = [NSArray arrayWithObjects:@"大",@"小",@"单",@"双", nil];
    
    for (int i =0; i < 2 ; i ++) {
        NSMutableArray *lyarray = [NSMutableArray array];
        
        for (int a = 0; a < 2; a ++) {
            NSString *yl = [[[dic4 objectForKey:[yiLouTypeArr objectAtIndex:i]] objectForKey:[array5 objectAtIndex:a]] objectForKey:@"yl"];
            [lyarray addObject:yl];
        }
        for (int a = 2; a < 4; a ++) {
            NSString *yl = [[[dic5 objectForKey:[yiLouTypeArr objectAtIndex:i]] objectForKey:[array5 objectAtIndex:a]] objectForKey:@"yl"];
            [lyarray addObject:yl];
        }
        [[dic valueForKey:@"dxdsst"] setValue:lyarray forKey:[yiLouTypeArr objectAtIndex:i + 5]];
    }
    
    return dic;
}

-(void)animationCompleted:(GifButton *)gifButton
{
    UIView *v1 = nil;
    if(gifButton.superview.tag == 1007)
    {
        v1 = [backScrollView viewWithTag:1008];
    }
    else if(gifButton.superview.tag == 1008)
    {
        v1 = [backScrollView viewWithTag:1007];
    }
    for (GCBallView *ball in v1.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            [ball chanetoNomore];
        }
    }
    [self ballSelectChange:nil];
}
-(void)zhankaidonghua
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(M_PI*1);
        sanjiao.transform = transForm;
    }];
}
-(void)guanbidonghua
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(0);
        sanjiao.transform = transForm;
    }];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
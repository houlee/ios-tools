//
//  KuaiSanViewController.m
//  caibo
//
//  Created by yaofuyu on 13-4-9.
//
//

#import "KuaiSanViewController.h"

#import "caiboAppDelegate.h"
#import "Info.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GC_LotteryUtil.h"
#import "ShakeView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_LotteryUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "MobClick.h"
#import "n115yilouViewController.h"
#import "CP_PTButton.h"
#import "MyLottoryViewController.h"
#import "GC_AccountManage.h"
#import "GC_UserInfo.h"
#import "NetURL.h"
#import "JSON.h"
//#import "CPBangDanView.h"
#import "HomeViewController.h"
#import "KuaiSanTuiJianViewCotroller.h"
//#import "kuaisanShuoming.h"
#import "YiLouChartData.h"
#import "ChartTitleScrollView.h"
#import "ChartYiLouScrollView.h"
#import "ChartDefine.h"
#import "ChartLeftScrollView.h"
#import "ChartYiLouScrollView.h"
#import "SharedMethod.h"
#import "YiLouUnderGCBallView.h"
#import "SharedDefine.h"

#define ANIMATE_TIME 0.3

#define FRAME CGRectMake(15 + b * 49, originY + a * 40, 45.5, 34.5)
#define FRAME_TONGHAO CGRectMake(15 + b * 101, originY + a * 57.5, 90, 51)

#define YILOU_COLOR [UIColor colorWithRed:132/255.0 green:204/255.0 blue:186/255.0 alpha:1]
#define YILOU_COLOR_MAX [UIColor yellowColor]

@interface KuaiSanViewController ()

@end

@implementation KuaiSanViewController
@synthesize lotterytype;
@synthesize modetype;
@synthesize myRequest;
@synthesize qihaoReQuest;
@synthesize yilouRequest;
@synthesize issue;
//@synthesize wangQi;
@synthesize myTimer;
@synthesize yilouDic;
@synthesize zhongJiang;
@synthesize myIssrecord;
@synthesize httpRequest;
@synthesize yiLouDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(KuaiSanType)type
{
    self = [super init];
    if (self) {
        
        myKuaiSanType = type;
        if (myKuaiSanType == NeiMengKuaiSan) {
            myLotteryID = LOTTERY_ID_NEIMENG;
        }else if (myKuaiSanType == JiangSuKuaiSan) {
            myLotteryID = LOTTERY_ID_JIANGSU;
        }else if (myKuaiSanType == HuBeiKuaiSan) {
            myLotteryID = LOTTERY_ID_HUBEI;
        }else if (myKuaiSanType == JiLinKuaiSan) {
            myLotteryID = LOTTERY_ID_JILIN;
        }
        else if (myKuaiSanType == AnHuiKuaiSan) {
            myLotteryID = LOTTERY_ID_ANHUI;
        }
        wanDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
@[@"普通",@"胆拖"],@"title",
@[@"和值",@"三同号单选",@"三同号通选",@"二同号单选",@"二同号复选",@"三连号通选",@"三不同号",@"二不同号",@"三不同号胆拖",@"二不同号胆拖"],@"wanArray",
@[@"奖金9-240元", @"奖金240元",@"奖金40元",@"奖金80元",@"奖金15元",@"奖金10元",@"奖金40元",@"奖金8元"],@"wanMoneyArray",
        @[@[@"1,2,3"],@[@"3,3,3"], @[@"6,6,6"], @[@"1,1,3"], @[@"3,3"], @[@"1,2,3"], @[@"3,6,5"], @[@"3,6"]],@"diceArray" ,nil];
        
        wanArray = [wanDictionary objectForKey:@"wanArray"];
        modetype = KuaiSanHezhi;
        NSInteger type = 0;
        if (myKuaiSanType == NeiMengKuaiSan) {
            lotterytype = TYPE_KuaiSan;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"KuaiSanDefaultModetype"] integerValue];
        }
        else if (myKuaiSanType == JiangSuKuaiSan) {
            lotterytype = TYPE_JSKuaiSan;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"JSKuaiSanDefaultModetype"] integerValue];
        }
        else if (myKuaiSanType == HuBeiKuaiSan) {
            lotterytype = TYPE_HBKuaiSan;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"HBKuaiSanDefaultModetype"] integerValue];
        }
        else if (myKuaiSanType == JiLinKuaiSan) {
            lotterytype = TYPE_JLKuaiSan;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"JLKuaiSanDefaultModetype"] integerValue];
        }
        else if (myKuaiSanType == AnHuiKuaiSan) {
            lotterytype = TYPE_AHKuaiSan;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"AHKuaiSanDefaultModetype"] integerValue];
        }
        if (KuaiSanHezhi <= type && KuaiSanErBuTongDanTuo >= type) {
            modetype = (int)type;
        }
//        isBackScrollView = YES;
        isKuaiSan = YES;
        isVerticalBackScrollView = YES;
        yanchiTime = 90;
        showing = NO;
        cpLotteryName = kuaisanType;
//        self.excursionHight = 50;
         self.headHight = 24;
       
#ifdef isHaoLeCai
        changeWinOrigin = 0;
#else
        changeWinOrigin = 20;
#endif
        
        hasYiLou = NO;
        canRefreshYiLou = YES;
    }
    return  self;
}

- (void)dealloc {
    [yiLouDataArray release];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [editeView removeFromSuperview];
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.zhongJiang = nil;
    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    self.myIssrecord = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [shakeImageView release];
    [blackButton release];
    [selectImageView release];
    [sqkaijiang release];

    [expectationView release];
    [topImageView release];
    
    [zhushuLabel release];
    [jineLabel release];
    
    [qingbutton release];
    [topNumberLabel release];
    [tuiJianBtn release];
    
    [senBtn release];
    
    [super dealloc];
}

- (NSString *)changeModetypeToString:(ModeTYPE)mode {
    if (mode == KuaiSanHezhi) {
        return @"和值";
    }
    else if (mode == KuaiSanSantongTong){
        return @"三同号通选";
    }
    else if (mode == KuaiSanSantongDan){
        return @"三同号单选";
    }
    else if (mode == KuaiSanErtongDan){
        return @"二同号单选";
    }
    else if (mode == KuaiSanErTongFu){
        return @"二同号复选";
    }
    else if (mode == KuaiSanSanBuTong){
        return @"三不同号";
    }
    else if (mode == KuaiSanErButong){
        return @"二不同号";
    }
    else if (mode == KuaiSanSanLianTong){
        return @"三连号通选";
    }
    else if (mode == KuaiSanSanBuTongDanTuo) {
        return @"三不同号胆拖";
    }
    else if (mode == KuaiSanErBuTongDanTuo) {
        return @"二不同号胆拖";
    }
    
    return nil;
}

-(ModeTYPE)changeStringToMode:(NSString *)str {
    if ([str isEqualToString:@"三同号通选"]) {
        return KuaiSanSantongTong;
    }
    else if ([str isEqualToString:@"三同号单选"]){
        return KuaiSanSantongDan;
    }
    else if ([str isEqualToString:@"二同号单选"]){
        return KuaiSanErtongDan;
    }
    else if ([str isEqualToString:@"二同号复选"]){
        return KuaiSanErTongFu;
    }
    else if ([str isEqualToString:@"三不同号"]){
        return KuaiSanSanBuTong;
    }
    else if ([str isEqualToString:@"二不同号"]){
        return KuaiSanErButong;
    }
    else if ([str isEqualToString:@"三连号通选"]){
        return KuaiSanSanLianTong;
    }
    else if ([str isEqualToString:@"三不同号胆拖"]){
        return KuaiSanSanBuTongDanTuo;
    }
    else if ([str isEqualToString:@"二不同号胆拖"]){
        return KuaiSanErBuTongDanTuo;
    }
    
    return KuaiSanHezhi;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    isAppear = NO;
    if (entRunLoopRef) {
        CFRunLoopStop(entRunLoopRef);
        entRunLoopRef = nil;
    }
    [self.myTimer invalidate];
    self.myTimer = nil;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getIssueInfo) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
//    [self refreshAccunt];
    isAppear = YES;
    changePage = NO;
    [self changeShuoMing];
    [self performSelector:@selector(getIssueInfo)];
    [self ballSelectChange:nil];
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
    backScrollView.frame = CGRectMake(0, 0, 390, backScrollView.bounds.size.height);
    titleLabel.textColor = [UIColor whiteColor];
    
//	colorLabel = [[ColorView alloc] init];
//	colorLabel.frame = CGRectMake(27 + 35, 40, 100, 15);
////	colorLabel.textColor = [UIColor blackColor];
//	colorLabel.font = [UIFont systemFontOfSize:11];
//	colorLabel.colorfont = [UIFont boldSystemFontOfSize:11];
//	colorLabel.backgroundColor = [UIColor clearColor];
////	colorLabel.changeColor = [UIColor redColor];
//	[backScrollView addSubview:colorLabel];
//	colorLabel.text = @"单注奖金<24>元";
//    colorLabel.wordWith = 10;
//	[colorLabel release];
    
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115 + 35, 13, 195, 47)];
	[backScrollView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
	[image1BackView release];
    
//    UIImageView *sanjiao = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_sanjiao.png")];
//    sanjiao.frame = CGRectMake(172 +35, 8, 11.5, 10);
//    [image1BackView addSubview:sanjiao];
//    [sanjiao release];
    
    sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(120 + 35, 20, 165, 23)];
    [backScrollView addSubview:sqkaijiang];
    sqkaijiang.font = [UIFont systemFontOfSize:10];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];
    
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + 35, 36, 55, 23)];
	[backScrollView addSubview:timeLabel];
    timeLabel.text = self.issue;
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:10];
	[timeLabel release];
    
	mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180 + 35, 36, 60, 23)];
	[backScrollView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止还有";
	mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:10];
	[mytimeLabel2 release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240 + 35, 36, 33, 23)];
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
//    [btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
//	btn.frame = CGRectMake(130 + 35, 6, 180, 30);
//	[backScrollView addSubview:btn];
    
	NSArray *nameArray = [NSArray arrayWithObjects:@"和值<①>",@"三同<①>",@"同号<①>",@"不同号<①>",@"三连号<①>",nil];
	for (int i = 0; i<5; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        if ([[nameArray objectAtIndex:i] length]) {
//            ColorView *label = [[ColorView alloc] init];
//            label.backgroundColor = [UIColor clearColor];
//            label.text = [nameArray objectAtIndex:i];
//            [firstView addSubview:label];
//            label.tag = 100;
//            label.textColor = [UIColor whiteColor];
//            if (i == 0) {
//                label.frame = CGRectMake(7, 12, 20, 60);
//            }
//            else {
//                label.frame = CGRectMake(7, 25, 20, 60);
//            }
//            
//            label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//            label.colorfont = [UIFont boldSystemFontOfSize:14];
//            label.jianjuHeight = 3;
//            label.textAlignment = NSTextAlignmentCenter;
//            [label release];
            firstView.backgroundColor = [UIColor clearColor];
            firstView.frame = CGRectMake(10 + 35, 73 + i*90, 300, 130);
            if (i == 0) {
                firstView.image = UIImageGetImageFromName(@"TZAHDSSQBG960.png");
                NSArray *jiangArray = [NSArray arrayWithObjects:@"80",@"40",@"25",@"16",@"12",@"10",@"9",@"9",@"10",@"12",@"16",@"25",@"40",@"80", nil];
                for (int j = 4; j<18; j++) {
                    int a= (j -4)/5,b = (j-4)%5;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j];
                    if (j< 10) {
                        num = [NSString stringWithFormat:@"0%d",j];
                    }
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*50+45, a*57+15, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                    UILabel *jiangLable = [[UILabel alloc] init];
                    jiangLable.text = [NSString stringWithFormat:@"奖金%@元",[jiangArray objectAtIndex:j-4]];
                    [firstView addSubview:jiangLable];
                    jiangLable.frame = CGRectMake(b*50+38, a*57+53, 50, 11);
                    jiangLable.font = [UIFont systemFontOfSize:9];
                    jiangLable.backgroundColor = [UIColor clearColor];
                    jiangLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
                    jiangLable.textAlignment = NSTextAlignmentCenter;
                    [jiangLable release];
                }
                firstView.frame = CGRectMake(10+ 35, 73 + i*90, 300, 190);
            }
            else if (i == 1) {
//                label.frame = CGRectMake(7, 15, 20, 60);
                firstView.image = UIImageGetImageFromName(@"TZAHKuaiSanBG960.png");
                firstView.frame = CGRectMake(10 + 35, 73 + 90, 300, 140);
                for (int j = 0; j<6; j++) {
                    int a= j/7,b = j%7;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+42, a*37+14, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.selected = YES;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    
                    [im release];
                    
                    CP_PTButton *btn1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                    btn1.userInteractionEnabled = NO;
                    [btn1 loadButonImage:@"kuai3Ball.png" LabelName:num];
                    [firstView addSubview:btn1];
                    btn1.buttonName.shadowColor = [UIColor clearColor];
                    btn1.selectImage = UIImageGetImageFromName(@"kuai3Ball2.png");
                    btn1.nomorImage =UIImageGetImageFromName(@"kuai3Ball.png");
                    btn1.frame = CGRectMake(b*42+44, 56, 30, 30);
                    btn1.tag = im.tag + 100;
                    btn1.buttonName.font = [UIFont boldSystemFontOfSize:7];
                    btn1.nomorTextColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    btn1.selectTextColor = [UIColor whiteColor];
                    btn1.buttonName.textColor = btn1.nomorTextColor;
                    
                    CP_PTButton *btn2 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                    btn2.userInteractionEnabled = NO;
                    [btn2 loadButonImage:@"kuai3Ball.png" LabelName:num];
                    [firstView addSubview:btn2];
                    btn2.buttonName.shadowColor = [UIColor clearColor];
                    btn2.selectImage = UIImageGetImageFromName(@"kuai3Ball2.png");
                    btn2.nomorImage =UIImageGetImageFromName(@"kuai3Ball.png");
                    btn2.frame = CGRectMake(b*42+44, 95, 30, 30);
                    btn2.tag = im.tag + 200;
                    btn2.buttonName.font = [UIFont boldSystemFontOfSize:7];
                    btn2.nomorTextColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    btn2.selectTextColor = [UIColor whiteColor];
                    btn2.buttonName.textColor = btn2.nomorTextColor;
                    
                    
                }
            }
            else if (i == 2) {
//                label.frame = CGRectMake(7, 15, 20, 60);
                firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.frame = CGRectMake(10 + 35, 73 + 90, 300, 100);
                for (int j = 0; j<6; j++) {
                    int a= j/7,b = j%7;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+42, a*37+13, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                    
                    CP_PTButton *btn1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                    btn1.userInteractionEnabled = NO;
                    [btn1 loadButonImage:@"kuai3Ball.png" LabelName:num];
                    [firstView addSubview:btn1];
                    btn1.buttonName.shadowColor = [UIColor clearColor];
                    btn1.selectImage = UIImageGetImageFromName(@"kuai3Ball2.png");
                    btn1.nomorImage =UIImageGetImageFromName(@"kuai3Ball.png");
                    btn1.frame = CGRectMake(b*42+44, 56, 30, 30);
                    btn1.tag = im.tag + 100;
                    btn1.buttonName.font = [UIFont boldSystemFontOfSize:7];
                    btn1.nomorTextColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    btn1.selectTextColor = [UIColor whiteColor];
                    btn1.buttonName.textColor = btn1.nomorTextColor;
                    
                }
            }
            else if (i == 3) {
//                label.frame = CGRectMake(7, 12, 20, 70);
//                label.jianjuHeight = 0;
                firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.frame = CGRectMake(10 + 35, 73 + 90, 300, 100);
                for (int j = 0; j<6; j++) {
                    int a= j/7,b = j%7;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+42, a*37+28, 35, 35) Num:num ColorType:GCBallViewColorKuaiSan];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                    
                }
            }
            else {
                firstView.image = UIImageGetImageFromName(@"TZAHDSSQBG960.png");
                firstView.frame = CGRectMake(10 + 35, 73 + 90, 300, 190);
//                label.frame = CGRectMake(7, 10, 20, 60);
                for (int j = 0; j<12; j++) {
                    int a= j/3,b = j%3;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",a +b + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*50+80, a*45+8, 35, 35) Num:num ColorType:GCBallViewColorRed];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.selected = YES;
                    im.userInteractionEnabled = NO;
                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    [im release];
                }
            }
            
            firstView.userInteractionEnabled = YES;
            
        }
        else {
            
        }
		[backScrollView addSubview:firstView];
		[firstView release];
	}
    
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
    if (IS_IPHONE_5) {
        im.frame = CGRectMake(0, 460, 320, 44);
    }
    im.userInteractionEnabled = YES;
	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	
	
    //清按钮
//    qingbutton = [[CP_PTButton alloc] init];
//    qingbutton.frame = CGRectMake(12 + 35, 10, 30, 30);
//    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
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
    senLabel.font = [UIFont systemFontOfSize:15];
    [senBtn addSubview:senLabel];
    [senLabel release];

}

- (void)LoadIphoneView {
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tag = 999;
    titleView.userInteractionEnabled = YES;
    self.CP_navigation.titleView = titleView;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.tag = 789;
    titleLabel.textColor = [UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:1];


    sanjiaoImageView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"WanFaQieHuan.png")] autorelease];
    [titleView addSubview:sanjiaoImageView];
    sanjiaoImageView.tag = 567;
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.tag = 998;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    [titleView release];
    
    
//    CP_PTButton *bangbtn  = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    [cpTopImageView addSubview:bangbtn];
//    [bangbtn loadButonImage:@"GCbang.png" LabelName:nil];
//    bangbtn.frame = CGRectMake(273.5, -2, 35, 44);
//    bangbtn.backgroundColor = [UIColor orangeColor];
//    [bangbtn addTarget:self action:@selector(showBang:) forControlEvents:UIControlEventTouchUpInside];
    
    tuiJianBtn = [[UIButton alloc] init];
    [backScrollView addSubview:tuiJianBtn];
    [tuiJianBtn setTitle:@"预设方案" forState:UIControlStateNormal];
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:0.4] forState:UIControlStateHighlighted];

    tuiJianBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    tuiJianBtn.backgroundColor = [UIColor clearColor];
    [tuiJianBtn addTarget:self action:@selector(goTuiJian) forControlEvents:UIControlEventTouchUpInside];
    [tuiJianBtn addTarget:self action:@selector(goTuiJian1) forControlEvents:UIControlEventTouchDown];
    [tuiJianBtn addTarget:self action:@selector(goTuiJian2) forControlEvents:UIControlEventTouchCancel];

    
    yuSheImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(58.5 + 15, 3.5 + 0.5, 15.5, 9.5)] autorelease];
    yuSheImageView.tag = 111;
    yuSheImageView.image = UIImageGetImageFromName(@"kuaisanYuShe.png");
    [tuiJianBtn addSubview:yuSheImageView];
    
    topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
//    topImageView.image = UIImageGetImageFromName(@"kuaisanTitleBG.png");
    topImageView.backgroundColor = [UIColor colorWithRed:78/255.0 green:181/255.0 blue:159/255.0 alpha:1];
    topImageView.layer.masksToBounds = YES;
    [backScrollView addSubview:topImageView];
    
    UIView * topLine = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(topImageView), 320, 0.5)] autorelease];
    [backScrollView addSubview:topLine];
    topLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:112/255.0 blue:89/255.0 alpha:1];

//    timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(62, 8.5, 37, 17)];
//    [self.mainView addSubview:timeImage];
//    timeImage.hidden = YES;
//    timeImage.image = UIImageGetImageFromName(@"TimeBack.png");
//    [timeImage release];
    
    sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 240, topImageView.frame.size.height)];
    [topImageView addSubview:sqkaijiang];
    sqkaijiang.font = [UIFont systemFontOfSize:13];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor colorWithRed:10/255.0 green:94/255.0 blue:71/255.0 alpha:1];
    
    shakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, ORIGIN_Y(topImageView) + 16, 21, 19)];
    [backScrollView addSubview:shakeImageView];
    shakeImageView.backgroundColor = [UIColor clearColor];
    shakeImageView.image = UIImageGetImageFromName(@"kuaisanShake.png");
    
    shuomingLabel = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_Y(shakeImageView) + 5, shakeImageView.frame.origin.y + 3, 300, shakeImageView.frame.size.height)];
    [backScrollView addSubview:shuomingLabel];
    shuomingLabel.backgroundColor = [UIColor clearColor];
    shuomingLabel.font = [UIFont systemFontOfSize:12];
    shuomingLabel.colorfont = [UIFont systemFontOfSize:12];
    shuomingLabel.textColor = [UIColor colorWithRed:131/255.0 green:222/255.0 blue:199/255.0 alpha:1];
    shuomingLabel.changeColor = [UIColor yellowColor];
    [shuomingLabel release];
    
	NSArray *nameArray = [NSArray arrayWithObjects:@"和值",@"三同号",@"二同号",@"不同号",@"三连号",@"胆码",@"拖码",@"二同号",@"三同号",nil];
    int Y = 0;
    if (!SWITCH_ON) {
        Y = 5;
    }
	for (int i = 0; i<9; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        if ([[nameArray objectAtIndex:i] length]) {
            UIImageView * nameImageView = [[UIImageView alloc] init];
            nameImageView.image = UIImageGetImageFromName(@"kuaisanContentTitle.png");
            [firstView addSubview:nameImageView];
            nameImageView.tag = 456;
            
            UILabel * nameLabel = [[UILabel alloc] init];
            nameLabel.text = [nameArray objectAtIndex:i];
            nameLabel.textColor = [UIColor colorWithRed:131/255.0 green:222/255.0 blue:199/255.0 alpha:1];
            nameLabel.backgroundColor = [UIColor clearColor];
            [nameImageView addSubview:nameLabel];
            nameLabel.tag = 457;
            nameLabel.font = [UIFont systemFontOfSize:14];
            [nameLabel release];
            
            nameImageView.frame = CGRectMake(0, 0, nameLabel.frame.size.width + 20, 27);

            float originY = 0;
            if (i == 0) {
                nameImageView.hidden = YES;
            }else{
                nameImageView.hidden = NO;
                originY = ORIGIN_Y(nameImageView) + 16;
            }
            
            UILabel * nameLabel1 = [[UILabel alloc] init];
//            nameLabel1.text = [nameArray1 objectAtIndex:i];
            nameLabel1.font = [UIFont systemFontOfSize:12];
            nameLabel1.textColor = [UIColor colorWithRed:80/255.0 green:192/255.0 blue:164/255.0 alpha:1];
            nameLabel1.backgroundColor = [UIColor clearColor];
            [nameImageView addSubview:nameLabel1];
            nameLabel1.tag = 458;
            [nameLabel1 release];

            
//            ColorView *label = [[ColorView alloc] init];
//            label.backgroundColor = [UIColor blueColor];
//            label.text = [nameArray objectAtIndex:i];
//            [firstView addSubview:label];
//            label.tag = 100;
//            label.textColor = [UIColor whiteColor];
//            if (i == 0) {
//                label.hidden = YES;
//            }
//            else {
//                label.frame = CGRectMake(7, 25, 20, 60);
//            }
//            
//            label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//            label.colorfont = [UIFont boldSystemFontOfSize:14];
//            label.jianjuHeight = 3;
//            label.textAlignment = NSTextAlignmentCenter;
//            [label release];
            firstView.backgroundColor = [UIColor clearColor];
//            firstView.frame = CGRectMake(0, ORIGIN_Y(shakeImageView) + 16 + i*90, 320, 130);
            
            GCBallView * lastBallView;
            
            if (i == 0) {
                firstView.image = nil;
//                label.text = @"快速选号";
//                label.frame = CGRectMake(0, 170, 120, 30);
                NSArray *jiangArray = [NSArray arrayWithObjects:@"240",@"80",@"40",@"25",@"16",@"12",@"10",@"9",@"9",@"10",@"12",@"16",@"25",@"40",@"80",@"240", nil];
                for (int j = 3; j<19; j++) {
                    int a= (j - 3)/4,b = (j - 3)%4;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(15 + b * 74, originY + a * 57.5, 68, 51) Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSanHezhi];
                    [firstView addSubview:im];
                    im.tag = j;
                    im.gcballDelegate = self;
                    if (j == 3) {
                        [self createLouOnBallView:im y:im.frame.size.height - 15.5];
                    }
                    [im release];
                    im.numLabel.font = [UIFont fontWithName:@"TRENDS" size:21];
                    im.numLabel.frame = CGRectMake(0, 0 + Y, im.frame.size.width, 25);

                    im.numLabel2.text =[NSString stringWithFormat:@"￥%@",[jiangArray objectAtIndex:j-3]];
                    im.numLabel2.font = [UIFont systemFontOfSize:12];
                    im.numLabel2.frame = CGRectMake(0, 25 + Y, im.frame.size.width, 12);
                    
                    im.ylLable.frame = CGRectMake(0, 37, im.frame.size.width, 10);
                    im.ylLable.font = [UIFont systemFontOfSize:10];
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    
                    if (a == 3 && b == 0) {
                        lastBallView = im;
                    }
                }
                
                daBall = [[GCBallView alloc] initWithFrame:CGRectMake(lastBallView.frame.origin.x, ORIGIN_Y(lastBallView) + 17.5, lastBallView.frame.size.width, 36) Num:@"大" ColorType:GCBallViewColorKuaiSanHezhiDX];
                [firstView addSubview:daBall];
                daBall.tag = 100;
                daBall.gcballDelegate = self;
                [daBall release];

                daBall.numLabel2.text =@"11-18";
                
                xiaoBall = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(daBall) + 6, daBall.frame.origin.y, lastBallView.frame.size.width, daBall.frame.size.height) Num:@"小" ColorType:GCBallViewColorKuaiSanHezhiDX];
                [firstView addSubview:xiaoBall];
                xiaoBall.tag = 101;
                xiaoBall.gcballDelegate = self;
                [xiaoBall release];

                xiaoBall.numLabel2.text =@"3-10";
                
                danBall = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(xiaoBall) + 6, daBall.frame.origin.y, lastBallView.frame.size.width, daBall.frame.size.height) Num:@"单" ColorType:GCBallViewColorKuaiSanHezhiDX];
                [firstView addSubview:danBall];
                danBall.tag = 102;
                danBall.gcballDelegate = self;
                [danBall release];
                
                danBall.numLabel2.text =@"奇数";

                shuangBall = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(danBall) + 6, daBall.frame.origin.y, lastBallView.frame.size.width, daBall.frame.size.height) Num:@"双" ColorType:GCBallViewColorKuaiSanHezhiDX];
                [firstView addSubview:shuangBall];
                shuangBall.tag = 103;
                shuangBall.gcballDelegate = self;
                [shuangBall release];

                shuangBall.numLabel2.text =@"偶数";
                firstView.frame = CGRectMake(0, i*90, 320, 290);
            }
            else if (i == 1) {

                firstView.frame = CGRectMake(0, 73 + 90, 320, 140);
                for (int j = 0; j<6; j++) {
                    int a= j/3,b = j%3;
                    NSString *num = [NSString stringWithFormat:@"%d",(j + 1) * 111];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME_TONGHAO Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSanSanTong];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.selected = YES;
//                    im.isBlack = YES;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    im.gcballDelegate = self;
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    [im release];
                    
                    if (j == 0) {
                        [self createLouOnBallView:im y:im.frame.size.height - 15.5];
                    }
                }
            }
            else if (i == 2) {

                GCBallView * lastBallView;
                for (int j = 0; j<6; j++) {
                    int a= j/7,b = j%7;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",(j + 1) * 11];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSan2];
                    [firstView addSubview:im];
                    im.tag = j+1;
//                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    [im release];
                    
                    if (j == 0) {
                        [self createLouOnBallView:im y:im.frame.size.height - 14.5];
                    }
                    lastBallView = im;
                }
                firstView.frame = CGRectMake(0, 73 + 90, 320, ORIGIN_Y(lastBallView) + 10);
            }
            else if (i == 3) {

                GCBallView * lastBallView;
                for (int j = 0; j<6; j++) {
                    int a= j/7,b = j%7;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSan];
                    [firstView addSubview:im];
                    im.tag = j+1;
//                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    [im release];
                    if (j == 0) {
                        [self createLouOnBallView:im y:im.frame.size.height - 14.5];
                    }
                    lastBallView = im;
                }
                
                firstView.frame = CGRectMake(0, 73 + 90, 320, ORIGIN_Y(lastBallView) + 10);
            }
            else if (i == 5) {

                GCBallView * lastBallView;

                for (int j = 0; j<6; j++) {
                    int a= j/6,b = j%6;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSan];
                    [firstView addSubview:im];
                    im.tag = j+1;
//                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastBallView = im;

                    [im release];
                    
                    if (j == 0) {
                        [self createLouOnBallView:im y:im.frame.size.height - 14.5];
                    }
                }
                firstView.frame = CGRectMake(0, 73 + 90, 320, ORIGIN_Y(lastBallView) + 10);
            }
            else if (i == 6) {

                GCBallView * lastBallView;
                for (int j = 0; j<6; j++) {
                    int a= j/6,b = j%6;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d",j + 1];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSan];
                    [firstView addSubview:im];
                    im.tag = j+1;
//                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    lastBallView = im;
                    [im release];
                    
                    if (j == 0) {
                        [self createLouOnBallView:im y:im.frame.size.height - 14.5];
                    }
                }
                firstView.frame = CGRectMake(0, 73 + 90, 320, ORIGIN_Y(lastBallView) + 10);
            }
            else if (i == 7) {//二同号复选

//                label.frame = CGRectMake(7, 25, 20, 60);
//                firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.frame = CGRectMake(0, 73 + 90, 320, 140);
                for (int j = 0; j<6; j++) {
                    int a= j/3,b = j%3;
//                    label.font = [UIFont systemFontOfSize:13];
                    NSString *num = [NSString stringWithFormat:@"%d*",(j + 1) * 11];
                    GCBallView *im = [[GCBallView alloc] initWithFrame:FRAME_TONGHAO Num:[SharedMethod changeFontWithString:num] ColorType:GCBallViewColorKuaiSanErTong];
                    [firstView addSubview:im];
                    im.tag = j+1;
                    im.selected = YES;
//                    im.isBlack = YES;
                    im.gcballDelegate = self;
                    im.numLabel.frame = CGRectMake(im.numLabel.frame.origin.x, im.numLabel.frame.origin.y + Y, im.numLabel.frame.size.width, im.numLabel.frame.size.height);
                    if (!SWITCH_ON) {
                        im.ylLable.hidden = YES;
                    }
                    [im release];
                    
                    if (j == 0) {
                        if (IS_IOS7) {
                            [self createLouOnBallView:im y:im.frame.size.height - 15.5];
                        }else{
                            [self createLouOnBallView:im y:im.frame.size.height - 15];
                        }
                    }
                }
            }
            else if (i == 8) {//三同号通选

//                firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.frame = CGRectMake(0, 73 + 90, 320, 200);
//                label.frame = CGRectMake(7, 22, 20, 60);
//                firstView.backgroundColor = [UIColor orangeColor];
                GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake((320 - 130)/2, originY, 130, 141.5) Num:@"" ColorType:GCBallViewColorKuaiSanSanTongTong];
                im.backgroundColor = [UIColor clearColor];
                [firstView addSubview:im];
                im.tag = 1;
//                im.selected = YES;
//                im.userInteractionEnabled = YES;
//                im.isBlack = YES;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                [im release];
                
                if (IS_IOS7) {
                    [self createLouOnBallView:im.numLabel y:4];
                }else{
                    [self createLouOnBallView:im.numLabel y:4.5];
                }
            }
            else {
                //三连号
//                firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
                firstView.frame = CGRectMake(0, 73 + 90, 320, 155);
//                label.frame = CGRectMake(7, 14, 20, 60);
                GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(96, originY, 128, 102) Num:@"" ColorType:GCBallViewColorKuaiSanSanLian];
                [firstView addSubview:im];
                im.tag = 1;
//                im.selected = YES;
//                im.userInteractionEnabled = NO;
//                im.isBlack = YES;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                [im release];
                
                if (IS_IOS7) {
                    [self createLouOnBallView:im.numLabel y:3];
                }else{
                    [self createLouOnBallView:im.numLabel y:4];
                }
            }
            
            firstView.userInteractionEnabled = YES;
            
        }
        else {
            
        }
		[backScrollView addSubview:firstView];
		[firstView release];
	}
    
    expectationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 25)];
    [self.view addSubview:expectationView];
    expectationView.backgroundColor = [UIColor colorWithRed:78/255.0 green:181/255.0 blue:159/255.0 alpha:1];
    
    UILabel * expectationLabel = [[[UILabel alloc] initWithFrame:expectationView.bounds] autorelease];
    expectationLabel.backgroundColor = [UIColor clearColor];
    expectationLabel.textColor = [UIColor colorWithRed:10/255.0 green:102/255.0 blue:84/255.0 alpha:1];
    expectationLabel.textAlignment = 1;
    expectationLabel.font = [UIFont systemFontOfSize:12];
    expectationLabel.tag = 10;
    [expectationView addSubview:expectationLabel];
    
//	UIImageView *foot1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 28)];
//    [self.cpBottomImageView addSubview:foot1];
//    foot1.tag = 2112;
//    foot1.image = UIImageGetImageFromName(@"kuaisanBottomBG.png");
//    foot1.userInteractionEnabled = YES;
//    [foot1 release];
    
//    colorLabel = [[ColorView alloc] init];
//	colorLabel.textColor = [UIColor colorWithRed:212/255.0 green:231/255.0 blue:211/255.0 alpha:1];
//	colorLabel.font = [UIFont systemFontOfSize:12];
//	colorLabel.colorfont = [UIFont boldSystemFontOfSize:12];
//	colorLabel.backgroundColor = [UIColor clearColor];
//	colorLabel.changeColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:95/255.0 alpha:1];
//	[foot1 addSubview:colorLabel];
    
//    accuntLabel = [[ColorView alloc] init];
//	accuntLabel.textColor = [UIColor colorWithRed:212/255.0 green:231/255.0 blue:211/255.0 alpha:1];
//	accuntLabel.font = [UIFont systemFontOfSize:12];
//	accuntLabel.colorfont = [UIFont boldSystemFontOfSize:12];
//	accuntLabel.backgroundColor = [UIColor clearColor];
//	accuntLabel.changeColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:95/255.0 alpha:1];
////    colorLabel.text = @"单注奖金<1170>元";
//	[foot1 addSubview:accuntLabel];
//    [accuntLabel release];
//    [self refreshAccunt];
	
//    colorLabel.wordWith = 10;
//	[colorLabel release];
    
//    zhuShuAndJinE = [[ColorView alloc] init];
//	zhuShuAndJinE.textColor = [UIColor colorWithRed:212/255.0 green:231/255.0 blue:211/255.0 alpha:1];
//	zhuShuAndJinE.font = [UIFont systemFontOfSize:12];
//	zhuShuAndJinE.colorfont = [UIFont boldSystemFontOfSize:11];
//	zhuShuAndJinE.backgroundColor = [UIColor clearColor];
//	zhuShuAndJinE.changeColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:95/255.0 alpha:1];
//	[foot1 addSubview:zhuShuAndJinE];
//    [zhuShuAndJinE release];
    
//    //玩法说明
//    wanInfo = [[CP_PTButton alloc] init];
//    wanInfo.frame = CGRectMake(285, 0, 30, 28);
//    [wanInfo loadButonImage:@"kuaisanWanInfo.png" LabelName:nil];
//    wanInfo.hightImage = UIImageGetImageFromName(@"kuaisanWanInfo_1.png");
//    wanInfo.buttonImage.frame = CGRectMake(7.5, 5.5, 16.5, 19);
//    wanInfo.backgroundColor = [UIColor clearColor];
//    [wanInfo addTarget:self action:@selector(wanfaInfo) forControlEvents:UIControlEventTouchUpInside];
//    [foot1 addSubview:wanInfo];
    
    //新手指南
//    CP_PTButton * guideButton = [[[CP_PTButton alloc] initWithFrame:CGRectMake(251, 0, 30, 28)] autorelease];
//    [guideButton loadButonImage:@"kuisanGuide.png" LabelName:nil];
//    guideButton.backgroundColor = [UIColor clearColor];
//    guideButton.hightImage = UIImageGetImageFromName(@"kuisanGuide_1.png");
//    guideButton.buttonImage.frame = CGRectMake(5, 6, 19, 18.5);
//    [guideButton addTarget:self action:@selector(toGuide) forControlEvents:UIControlEventTouchUpInside];
//    [foot1 addSubview:guideButton];
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
    im.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:19/255.0 alpha:1];
//	im.image = UIImageGetImageFromName(@"kuaisanBottomBG1.png");
	
    //清按钮
    qingbutton = [[UIButton alloc] initWithFrame:CGRectMake(12, 7, 30, 30)];
    [qingbutton setImage:UIImageGetImageFromName(@"KuaiSanTrash.png") forState:UIControlStateNormal];
    [qingbutton setImage:UIImageGetImageFromName(@"KuaiSanTrash_1.png") forState:UIControlStateDisabled];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    
//    qingbutton = [[CP_PTButton alloc] init];
//    qingbutton.frame = CGRectMake(8, 0, 30, 28);
//    [qingbutton loadButonImage:@"kuaisanQing.png" LabelName:nil];
//    qingbutton.hightImage = UIImageGetImageFromName(@"kuaisanQing_1.png");
//    qingbutton.buttonImage.frame = CGRectMake(7.5, 5.5, 18.5, 17.5);
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(qingbutton) + 10, 7, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
//    zhubg.hidden = YES;
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont systemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
	
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
	jineLabel.font = [UIFont systemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [[UIButton alloc] init];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(235, 7, 80, 30);
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    senBtn.titleLabel.textAlignment = 1;
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];

	[im addSubview:senBtn];
    
//    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
//    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [senBtn addSubview:senImage];
//    [senImage release];
    
//    UILabel *senLabel = [[UILabel alloc] initWithFrame:senBtn.bounds];
//    senLabel.backgroundColor = [UIColor clearColor];
//    senLabel.textAlignment = NSTextAlignmentCenter;
//    senLabel.text = @"机选";
//    senLabel.textColor = [UIColor whiteColor];
//    senLabel.tag = 1101;
//    senLabel.font = [UIFont systemFontOfSize:15];
//    [senBtn addSubview:senLabel];
//    [senLabel release];
    
//    UIButton * weiBoButton = [[[UIButton alloc] initWithFrame:CGRectMake(276, 12, 25, 22)] autorelease];
//    [im addSubview:weiBoButton];
//    [weiBoButton addTarget:self action:@selector(toWeiBo) forControlEvents:UIControlEventTouchUpInside];
//    [weiBoButton setBackgroundImage:UIImageGetImageFromName(@"toWeiBo.png") forState:UIControlStateNormal];
//    [weiBoButton setBackgroundImage:UIImageGetImageFromName(@"toWeiBo_1.png") forState:UIControlStateHighlighted];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 - 60, 4, 60, 10)];
	[self.mainView addSubview:timeLabel];
//    if ([self.issue length]) {
//        timeLabel.text = [NSString stringWithFormat:@"距%@期截止",self.issue];
//    }
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = [UIColor colorWithRed:10/255.0 green:94/255.0 blue:71/255.0 alpha:1];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:8];
	[timeLabel release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(320 - 60, ORIGIN_Y(timeLabel) - 2, 60, 24)];
	[self.mainView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor colorWithRed:10/255.0 green:94/255.0 blue:71/255.0 alpha:1];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:18];
	[mytimeLabel3 release];
    
//    UIImageView *naoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(65, 24, 11, 13)];
//    naoImageV.image = UIImageGetImageFromName(@"naoling.png");
//    [im addSubview:naoImageV];
//    naoImageV.backgroundColor = [UIColor clearColor];
//    [naoImageV release];
//    [self ballSelectChange:nil];
}

-(void)createLouOnBallView:(UIView *)ballView y:(float)y
{
    UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(4, y, 13, 12)] autorelease];
    louLabel.text = @"漏";
    louLabel.font = [UIFont systemFontOfSize:10];
    louLabel.backgroundColor = [UIColor clearColor];
    louLabel.tag = 888;
    louLabel.textColor = YILOU_COLOR;
    if (SWITCH_ON) {
        louLabel.hidden = NO;
    }else{
        louLabel.hidden = YES;
    }
    [ballView addSubview:louLabel];
}

-(void)createLabel:(UILabel *)label i:(int)i x:(float)x width:(float)width
{
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithRed:118/255.0 green:154/255.0 blue:111/255.0 alpha:1];
//    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000,30) lineBreakMode:NSLineBreakByWordWrapping];
    //28  29  45  34  52
    label.frame = CGRectMake(x, i*30, width, 30);
    [cpHistoryBGImageView addSubview:label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.yiLouViewHight = self.view.frame.size.height - 44 - 44 - isIOS7Pianyi -self.headHight - 35;

    [MobClick event:@"event_goumai_gaopincai_kuaisan"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssueInfo) name:@"BecomeActive" object:nil];
    
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(goHistory) forControlEvents:UIControlEventTouchUpInside];
    
//    self.CP_navigation.image = UIImageGetImageFromName(@"kuaisanNav.png");
    
    self.CP_navigation.backgroundColor = [UIColor colorWithRed:52/255.0 green:73/255.0 blue:94/255.0 alpha:1];

    UIView * barView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0 - isIOS7Pianyi, 320, isIOS7Pianyi)] autorelease];
    [self.CP_navigation addSubview:barView];
    barView.backgroundColor = [UIColor colorWithRed:52/255.0 green:73/255.0 blue:94/255.0 alpha:1];

    
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	
//    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"kuaisanback.jpg");
//    bgimageview.tag = 267;
//    [self.mainView addSubview:bgimageview];
//    [bgimageview release];
    
    backScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.scrollEnabled = YES;
    [self.mainView addSubview:backScrollView];
    [backScrollView release];
    
    

        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack) normalImage:@"kuaiSanBackArrow.png" highlightedImage:nil];

        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30) titleColor:[UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:1]];
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
            [btn setImage:UIImageGetImageFromName(@"kuaisan_navBtn_normal.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"kuaisan_navBtn_selected.png") forState:UIControlStateHighlighted];

            btn.frame = CGRectMake(0, 0, 60, 44);
            btn.adjustsImageWhenHighlighted = NO;
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
    
    
    
    
    [self changeTitle];
    [self clearBalls];
    [self getWangqi];
	// Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

- (void)returnSelectIndex:(NSInteger)index{
    NSLog(@"returnSelectIndex");
    
    if (index == 0) {
        [self gofenxi];
        
    }else if (index == 1) {
        [self goHistory];
    }
    else if (index == 2) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
        [self pressTitleButton:nil];
    }
    else if (index == 3) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        
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

#pragma mark - switchChange

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            [infoViewController.dataArray removeAllObjects];
            [self changeShuoMing];
        }
    }else if (alertView.tag == 201) {
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

-(void)switchChange
{
    for (int i = 1000;i<1009;i++) {
        int first = 1,count = 7;
        UIView *v = [backScrollView viewWithTag:i];
        if (i == 1000) {
            first = 3;
            count = 19;
        }
        for (int j = first; j < count; j++) {
            if ([[v viewWithTag:j] isKindOfClass:[GCBallView class]]) {
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                UILabel * louLabel = (UILabel *)[ballView viewWithTag:888];
                if (SWITCH_ON) {
                    ballView.ylLable.hidden = NO;
                    if (i != 1004 && i != 1008) {
                    ballView.numLabel.frame = CGRectMake(ballView.numLabel.frame.origin.x, ballView.numLabel.frame.origin.y - 5, ballView.numLabel.frame.size.width, ballView.numLabel.frame.size.height);
                    ballView.numLabel2.frame = CGRectMake(ballView.numLabel2.frame.origin.x, ballView.numLabel2.frame.origin.y - 5, ballView.numLabel2.frame.size.width, ballView.numLabel2.frame.size.height);
                    }
                    louLabel.hidden = NO;
                }else{
                    ballView.ylLable.hidden = YES;
                    if (i != 1004 && i != 1008) {
                        ballView.numLabel.frame = CGRectMake(ballView.numLabel.frame.origin.x, ballView.numLabel.frame.origin.y + 5, ballView.numLabel.frame.size.width, ballView.numLabel.frame.size.height);
                        ballView.numLabel2.frame = CGRectMake(ballView.numLabel2.frame.origin.x, ballView.numLabel2.frame.origin.y + 5, ballView.numLabel2.frame.size.width, ballView.numLabel2.frame.size.height);
                    }
                    louLabel.hidden = YES;
                }
            }
        }
    }
}


#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    if (buttonIndex == 1) {
        
        if ([returnarry count] == 2) {
            for (int i = 0; i < [returnarry count]; i++) {
                NSArray *wanfaname = [returnarry objectAtIndex:i];
                if ([wanfaname count]) {
                    NSInteger tag = [wanArray indexOfObject:[wanfaname objectAtIndex:0]];
                    if (tag >= 0 && tag < 100) {
                        UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
                        sender.tag =tag;
                        [self pressBgButton:sender];
                        [self clearBalls];
                    }
                }
                
            }
        }
        
    }
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender {
}

#pragma mark -
#pragma mark Action
- (void)goTuiJian1 {
    
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:0.4] forState:UIControlStateNormal];
    yuSheImageView.image =  UIImageGetImageFromName(@"kuaisanYuShe_1.png");

}
- (void)goTuiJian2 {
    
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    yuSheImageView.image =  UIImageGetImageFromName(@"kuaisanYuShe.png");

}

-(void)delayPush:(id)controller
{
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    yuSheImageView.image =  UIImageGetImageFromName(@"kuaisanYuShe.png");
    [self performSelector:@selector(delayPush1:) withObject:controller afterDelay:0.01];
}

-(void)delayPush1:(id)controller
{
    [self.navigationController pushViewController:controller animated:YES];
    tuiJianBtn.userInteractionEnabled = YES;
}

- (void)goTuiJian {
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    [MobClick event:@"event_goucai_yushefangan_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

    tuiJianBtn.userInteractionEnabled = NO;
    if ([infoViewController.dataArray count] == 0) {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeKuaiSan;
        }
//        infoViewController.danzhuJiangjin = colorLabel.text;
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;
        KuaiSanTuiJianViewCotroller *tuiJianViewController = [[[KuaiSanTuiJianViewCotroller alloc] initWithLotteryID:myLotteryID] autorelease];
//        tuiJianViewController.dataDic = self.yilouDic;
        infoViewController.betInfo.betlist = nil;
        tuiJianViewController.myBentInfo = infoViewController.betInfo;
        if (modetype == KuaiSanHezhi) {
            tuiJianViewController.viewType = KuaiSanTuiJianTypeHeZhi;
        }
        else if (modetype == KuaiSanErButong) {
            tuiJianViewController.viewType = KuaiSanTuiJianTypeErBuTong;
        }
        else if (modetype == KuaiSanSanBuTong) {
            tuiJianViewController.viewType = KuaiSanTuiJianTypeSanBuTong;
        }
        tuiJianViewController.infoViewController = infoViewController;
        tuiJianViewController.title = [(UILabel *)[self.CP_navigation.titleView viewWithTag:789] text];
        
        [self performSelector:@selector(delayPush:) withObject:tuiJianViewController afterDelay:0.1];

    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您确定要清除已选方案?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 101;
        [alert release];
    }
}

- (void)changeNumToShaiZi:(NSArray *)numArray {
    if ([numArray count] < 3) {
        return;
    }
    NSString *num1 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:0] integerValue]];
    NSString *num2 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:1] integerValue]];
    NSString *num3 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:2] integerValue]];
    shaizi1View.frame = CGRectMake(65, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
    shaizi2View.frame = CGRectMake(90, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
    shaizi3View.frame = CGRectMake(115, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
    shaizi1View.image = UIImageGetImageFromName(num1);
    shaizi2View.image = UIImageGetImageFromName(num2);
    shaizi3View.image = UIImageGetImageFromName(num3);
    
    topNumberLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[SharedMethod changeFontWithString:[NSString stringWithFormat:@"%d",(int)[[numArray objectAtIndex:0] integerValue]]],[SharedMethod changeFontWithString:[NSString stringWithFormat:@"%d",(int)[[numArray objectAtIndex:1] integerValue]]],[SharedMethod changeFontWithString:[NSString stringWithFormat:@"%d",(int)[[numArray objectAtIndex:2] integerValue]]]];
    topNumberLabel.frame = CGRectMake(ORIGIN_X(shaizi3View) + 10, 0, 100, sqkaijiang.frame.size.height);
    topNumberLabel.hidden = NO;
}

- (void)changeShuoMing {
    //不同玩法的说明修改
    UIImageView *image1 = (UIImageView *)[backScrollView viewWithTag:2111];
    UIImageView *image2 = (UIImageView *)[self.mainView viewWithTag:2112];
    image1.image = UIImageGetImageFromName(@"goucatouback.png");
    image2.image = [UIImageGetImageFromName(@"TouzhuDiBack.png") stretchableImageWithLeftCapWidth:3 topCapHeight:0];

    tuiJianBtn.hidden = YES;

    if ([infoViewController.dataArray count] == 0) {
        [tuiJianBtn setTitle:@"预设方案" forState:UIControlStateNormal];
    }
    else {
        [tuiJianBtn setTitle:@"清除已选" forState:UIControlStateNormal];
//        tuiJianBtn.buttonName.backgroundColor = [UIColor clearColor];
    }
    [tuiJianBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];

    switch (modetype) {
        case KuaiSanHezhi:
            tuiJianBtn.hidden = NO;

            shakeImageView.hidden = NO;
            shuomingLabel.text = @"猜开奖号码之和";
            image1.image = UIImageGetImageFromName(@"kuaisankaiback.png");
            image2.image = UIImageGetImageFromName(@"kuaisanjiaback.png");
            break;
        case KuaiSanSantongTong:
            shakeImageView.hidden = YES;
            shuomingLabel.text = @"任意一个豹子号(3个号相同) 奖金<40>元";
            break;
        case KuaiSanSantongDan:
            shakeImageView.hidden = NO;
            shuomingLabel.text = @"猜豹子号(3个号相同) 奖金<240>元";
            break;
        case KuaiSanErtongDan:
            shakeImageView.hidden = NO;
            shuomingLabel.text = @"选择同号和不同号的组合 奖金<80>元";
            break;
        case KuaiSanErTongFu:
            shakeImageView.hidden = NO;
            shuomingLabel.text = @"猜对子号(2个号相同) 奖金<15>元";
            break;
        case KuaiSanSanBuTong:
            shakeImageView.hidden = NO;
            shuomingLabel.text = @"猜开奖的3个不同号码 奖金<40>元";
            tuiJianBtn.hidden = NO;

            break;
        case KuaiSanErButong:
            shakeImageView.hidden = NO;
            shuomingLabel.text = @"猜开奖的2个不同号码 奖金<8>元";
            tuiJianBtn.hidden = NO;

            break;
        case KuaiSanSanLianTong:
            shakeImageView.hidden = YES;
            shuomingLabel.text = @"123、234、345、456任意开出即中 奖金<10>元";
            break;
        case KuaiSanSanBuTongDanTuo:
            shakeImageView.hidden = YES;
            shuomingLabel.text = @"猜开奖的3个不同号码 奖金<40>元";
            break;
        case KuaiSanErBuTongDanTuo:
            shakeImageView.hidden = YES;
            shuomingLabel.text = @"猜开奖的2个不同号码";
            break;
        default:
            break;
    }
    if ([myLotteryID isEqualToString:LOTTERY_ID_JILIN] || [myLotteryID isEqualToString:LOTTERY_ID_ANHUI]) {
        tuiJianBtn.hidden = YES;
    }
    
    CGSize shuoMingSize = [shuomingLabel.text sizeWithFont:shuomingLabel.font constrainedToSize:CGSizeMake(320, shuomingLabel.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    float shakeX = 8;
    if (shakeImageView.hidden == NO) {
        shakeX = ORIGIN_X(shakeImageView) + 5;
    }
    shuomingLabel.frame = CGRectMake(shakeX, shakeImageView.frame.origin.y + 3, shuoMingSize.width + 15, shakeImageView.frame.size.height);
    tuiJianBtn.frame = CGRectMake(305 - 75 - 5, shuomingLabel.frame.origin.y - 2, 75 + 15, shuomingLabel.frame.size.height);
//    tuiJianBtn.buttonName.frame = tuiJianBtn.bounds;
} 

- (void)gofenxi
{
    [MobClick event:@"event_goucai_zoushitu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

    self.showYiLou = YES;
    if ([self.yiLouDataArray count] > 0) {
        [self allView:self.yiLouDataArray];
        
    }else{
        [self runCharRequest];
    }
}

- (void)donghuaxizi{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.52f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:xiimageview cache:YES];
    [UIView commitAnimations];
}

- (void)pressMenu {
    [self cancelSelectView];
    
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
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -isIOS7Pianyi, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle type:KuaiSanMenu];
//    }
    
    tln.delegate = self;
    [app.window addSubview:tln];
//    [tln release];
    [tln show];
    [tln release];

    [allimage release];
    [alltitle release];
}

- (void)shaiziShan:(NSString *)num {
    NSArray *array = [self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
    NSArray *numArray = nil;
    if ([array count] > 0) {
        numArray = [[array objectAtIndex:1] componentsSeparatedByString:@","];
    }
    if ([num intValue] < 5) {
        if ([num intValue] %2 == 0) {
            NSString *num1 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:0] integerValue]];
            NSString *num2 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:1] integerValue]];
            NSString *num3 = [NSString stringWithFormat:@"shaizi%d.png",(int)[[numArray objectAtIndex:2] integerValue]];
            shaizi1View.image = UIImageGetImageFromName(num1);
            shaizi2View.image = UIImageGetImageFromName(num2);
            shaizi3View.image = UIImageGetImageFromName(num3);
        }
        else {
            NSString *num1 = [NSString stringWithFormat:@"shaizi0%d.png",(int)[[numArray objectAtIndex:0] integerValue]];
            NSString *num2 = [NSString stringWithFormat:@"shaizi0%d.png",(int)[[numArray objectAtIndex:1] integerValue]];
            NSString *num3 = [NSString stringWithFormat:@"shaizi0%d.png",(int)[[numArray objectAtIndex:2] integerValue]];
            shaizi1View.image = UIImageGetImageFromName(num1);
            shaizi2View.image = UIImageGetImageFromName(num2);
            shaizi3View.image = UIImageGetImageFromName(num3);
        }
        num = [NSString stringWithFormat:@"%d",[num intValue] + 1];
        [self performSelector:@selector(shaiziShan:) withObject:num afterDelay:.5];
    }
    else {

    }
    
}

- (void)shaiziZhuan:(NSString *) num {
    num = [NSString stringWithFormat:@"%d",[num intValue] + 1];
    if ([num intValue] > 30) {
        NSArray *array = [self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        topNumberLabel.frame = CGRectMake(ORIGIN_X(shaizi3View) + 10, 0, 60, sqkaijiang.frame.size.height);

        if ([array count] > 0) {
            NSArray *array2 = [[array objectAtIndex:1] componentsSeparatedByString:@","];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [self changeNumToShaiZi:array2];
            [UIView commitAnimations];
            [self shaiziShan:@"0"];
            if ([[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
                NSString *last = [[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0];
                last = [self getLastTwoStr:last];//
                sqkaijiang.text = [NSString stringWithFormat:@"%@期开奖",last];
            }
            
        }
        else {
            
        }
        
        return;
    }
    else {
        NSString *imageName = [NSString stringWithFormat:@"shuaizidonghua%d.png",[num intValue]%3];
        shaizi1View.image = UIImageGetImageFromName(imageName);
        shaizi2View.image = UIImageGetImageFromName(imageName);
        shaizi3View.image = UIImageGetImageFromName(imageName);
        [self performSelector:@selector(shaiziZhuan:) withObject:num afterDelay:0.1];
    }
}

- (void)kaiJiangDonghua {
    
    if ([[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
        NSString *last = [[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0];
        last = [self getLastTwoStr:last];//
        shaizi1View.frame = CGRectMake(82, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        shaizi2View.frame = CGRectMake(107, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        shaizi3View.frame = CGRectMake(132, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        shaizi1View.hidden = NO;
        shaizi2View.hidden = NO;
        shaizi3View.hidden = NO;
        if ([self.myIssrecord.lastLotteryNumber length]) {
            sqkaijiang.text = [NSString stringWithFormat:@"%@期正在开奖",last];
            [self shaiziZhuan:@"0"];
        }

    }
    
}

- (void)upDataYilou{
    if (redrawHZ) {
        [redrawHZ removeFromSuperview];
        [redrawTitleHZ removeFromSuperview];
        redrawHZ = nil;
        redrawTitleHZ = nil;
    }
    if (redrawSTH) {
        [redrawSTH removeFromSuperview];
        [redrawTitleSTH removeFromSuperview];
        redrawSTH = nil;
        redrawTitleSTH = nil;
    }
    
    if (redrawETH) {
        [redrawETH removeFromSuperview];
        [redrawTitleETH removeFromSuperview];
        redrawETH = nil;
        redrawTitleETH = nil;
    }
    if (redrawSLH) {
        [redrawSLH removeFromSuperview];
        [redrawTitleSLH removeFromSuperview];
        redrawSLH = nil;
        redrawTitleSLH = nil;
    }
    if (redrawSBT) {
        [redrawSBT removeFromSuperview];
        [redrawTitleSBT removeFromSuperview];
        redrawSBT = nil;
        redrawTitleSBT = nil;
    }
    if (redrawEBT) {
        [redrawEBT removeFromSuperview];
        [redrawTitleEBT removeFromSuperview];
        redrawEBT = nil;
        redrawTitleEBT = nil;
    }
    
    
    [self.yiLouDataArray removeAllObjects];
    if (self.showYiLou) {
        [self runCharRequest];
        
    }
}

- (void)timeChange {
	seconds = seconds - 1;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [[NSRunLoop currentRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//    timeImage.hidden = YES;
    if (seconds < 0) {
        [self getIssueInfo];
		[self.myTimer invalidate];
		self.myTimer = nil;
        return;
    }
    if (!isKaiJiang && (seconds <= 600 - yanchiTime && seconds % 5 == 0)) {
        canRefreshYiLou = NO;
        [self getIssueInfo];
    }

    mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",seconds/60,seconds%60];
    if (seconds <= 60) {
        mytimeLabel3.textColor = [UIColor yellowColor];
    }else{
        mytimeLabel3.textColor = [UIColor colorWithRed:10/255.0 green:94/255.0 blue:71/255.0 alpha:1];
    }
    
    if (isKaiJiang) {
//        timeLabel.text = [NSString stringWithFormat:@"距%@期开奖",self.issue];
        NSString * str = [self getLastTwoStr:self.issue];
        timeLabel.text = [NSString stringWithFormat:@"距%@期截止",str];

//        if ([mytimeLabel3.text isEqualToString:@"正在开奖"]) {
        if (kaijianging == YES) {
            [self kaiJiangDonghua];
            kaijianging = NO;
            [self performSelector:@selector(getWangqi) withObject:nil afterDelay:60];

        }
//        }
//        mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(seconds + yanchiTime)/60,(seconds + yanchiTime)%60];
    }
    else {
//        if (seconds > 600 - yanchiTime) {
//            mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",((seconds + yanchiTime) % 600)/60,((seconds + yanchiTime) % 600)%60];
//        }
//        else {
//            mytimeLabel3.text = @"正在开奖";
//        }

//        sqkaijiang.text = [NSString stringWithFormat:@"%lld期等待开奖",[self.myIssrecord.curIssue longLongValue] - 1];

        if (!kaijianging) {
            kaijianging = YES;

            ColorView * kaijiangLabel = [[ColorView alloc] initWithFrame:sqkaijiang.frame];
            [topImageView addSubview:kaijiangLabel];
            kaijiangLabel.text = sqkaijiang.text;
            kaijiangLabel.textColor = sqkaijiang.textColor;
            kaijiangLabel.font = sqkaijiang.font;
            kaijiangLabel.backgroundColor = [UIColor clearColor];
            [kaijiangLabel release];
            
            UIImageView * shaiziView1 = [[UIImageView alloc] initWithFrame:shaizi1View.frame];
            shaiziView1.image = shaizi1View.image;
            [kaijiangLabel addSubview:shaiziView1];
            [shaiziView1 release];
            
            UIImageView * shaiziView2 = [[UIImageView alloc] initWithFrame:shaizi2View.frame];
            shaiziView2.image = shaizi2View.image;
            [kaijiangLabel addSubview:shaiziView2];
            [shaiziView2 release];
            
            UIImageView * shaiziView3 = [[UIImageView alloc] initWithFrame:shaizi3View.frame];
            shaiziView3.image = shaizi3View.image;
            [kaijiangLabel addSubview:shaiziView3];
            [shaiziView3 release];
            
            sqkaijiang.frame = CGRectMake(sqkaijiang.frame.origin.x, topImageView.frame.size.height, sqkaijiang.frame.size.width, sqkaijiang.frame.size.height);
            
            [UIView animateWithDuration:ANIMATE_TIME animations:^{
                kaijiangLabel.frame = CGRectMake(kaijiangLabel.frame.origin.x, -kaijiangLabel.frame.size.height, kaijiangLabel.frame.size.width, kaijiangLabel.frame.size.height);
                sqkaijiang.frame = CGRectMake(sqkaijiang.frame.origin.x, 0, sqkaijiang.frame.size.width, sqkaijiang.frame.size.height);
            } completion:^(BOOL finished) {
                [kaijiangLabel removeFromSuperview];
            }];
        }

        NSString * str = [self getLastTwoStr:[NSString stringWithFormat:@"%lld",[self.issue longLongValue] - 1]];

        sqkaijiang.text = [NSString stringWithFormat:@"%@期等待开奖",str];
        shaizi1View.image = UIImageGetImageFromName(@"shaiziwenhao.png");
        shaizi2View.image = UIImageGetImageFromName(@"shaiziwenhao.png");
        shaizi3View.image = UIImageGetImageFromName(@"shaiziwenhao.png");
        shaizi1View.frame = CGRectMake(82, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        shaizi2View.frame = CGRectMake(107, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        shaizi3View.frame = CGRectMake(132, sqkaijiang.frame.size.height/2 - 21/2, 20, 21);
        
        topNumberLabel.hidden = YES;
    }
    
//    if (seconds < 120) {
////        sqkaijiang.text = [NSString stringWithFormat:@"%@期截期 %02d:%02d",self.issue,seconds/60,seconds%60];
//        NSString * str = [self getLastTwoStr:self.issue];
//        sqkaijiang.text = [NSString stringWithFormat:@"%@期截期 %02d:%02d",str,seconds/60,seconds%60];
//        shaizi1View.hidden = YES;
//        shaizi2View.hidden = YES;
//        shaizi3View.hidden = YES;
//        if (seconds <= 10) {
//            if (seconds %2 == 0) {
//                timeImage.hidden = YES;
//            }
//            else {
//                timeImage.hidden = NO;
//            }
//        }
//    }
//    else {
//        shaizi1View.hidden = NO;
//        shaizi2View.hidden = NO;
//        shaizi3View.hidden = NO;
//    }
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
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:myLotteryID countOfPage:5];
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
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:myLotteryID];
        
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
    changePage = YES;
    [self cancelSelectView];
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}
- (void)hasLogin {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//     [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"kuaisan_navBtn_normal.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"kuaisan_navBtn_selected.png") forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 60, 44);
     [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
     rightItem.enabled = YES;
     [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)clearBalls {
//    if (self.modetype == KuaiSanSantongTong || self.modetype == KuaiSanSanLianTong) {
//        return;
//    }
	for (int i = 0; i < 9; i++) {
//        if (i != 4) {
            UIView *ballView = [backScrollView viewWithTag:1000+i];
            for (GCBallView *ball in ballView.subviews) {
                if ([ball isKindOfClass:[UIButton class]]) {
                    ball.selected = NO;
                }
//            }
        }
        
	}
	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
	[self ballSelectChange:nil];
}

- (NSString *)seletNumber {
//    if (self.modetype == KuaiSanSanLianTong) {
//        return @"123,234,345,456";
//    }
//    else if (self.modetype == KuaiSanSantongTong){
//        return @"123,234,345,456";
//    }
	NSString *st = @",", *sr = @"|";
	
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
    for (int i = 0; i < 9; i++) {
        UIView *ballView = [backScrollView viewWithTag:1000+i];
        if (ballView.hidden == NO) {
            if ([mStr length] > 0) {
                [mStr appendString:sr];
            }
            NSInteger selNum = 0;
            NSString * numStr = @"";
            NSMutableString *num = [NSMutableString string];
            NSMutableString * num1 = [NSMutableString string];
            for (GCBallView *ball in ballView.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]){
                    numStr = [SharedMethod changeFontWithString:ball.numLabel.text];
                    if (self.modetype == KuaiSanHezhi) {
                        if (ball.tag < 10) {
                            numStr = [SharedMethod changeFontWithString:[NSString stringWithFormat:@"⑽%@",ball.numLabel.text]];
                        }
//                        NSLog(@"%@",expectationStr);
                        if ([ball.numLabel2.text hasPrefix:@"￥"]) {
                            expectationStr = [NSMutableString stringWithString:[ball.numLabel2.text substringFromIndex:1]];
                        }
                    }else if (self.modetype == KuaiSanSantongTong && ball.selected == YES) {
                        return @"111,222,333,444,555,666";
                    }else if (self.modetype == KuaiSanSanLianTong && ball.selected == YES) {
                        return @"123,234,345,456";
                    }
                }
                if ([ball isKindOfClass:[GCBallView class]]&& ball.isSelected) {
                    if (ball.tag >= 100) {
                        
                    }
                    else if (self.modetype == KuaiSanSantongDan) {
                        NSString * number = [NSString stringWithFormat:@"%d",(int)[numStr integerValue]/100];
                        [num appendString:number];
                        [num appendString:st];
                        [num appendString:number];
                        [num appendString:st];
                        [num appendString:number];
                        [num appendString:@";"];
                    }
                    else if (self.modetype == KuaiSanErtongDan){
                        if ([numStr integerValue] > 10) {
                            numStr = [NSString stringWithFormat:@"%d",(int)[numStr integerValue]/10];
                        }
                        [num appendString:numStr];
                        if (i == 2) {
                            [num appendString:numStr];
                        }
                        
                        [num appendString:st];
                    }
                    else if (self.modetype == KuaiSanErTongFu){
                        numStr = [NSString stringWithFormat:@"%d",(int)[numStr integerValue]/10];
                        [num appendString:numStr];
                        [num appendString:numStr];
                        [num appendString:st];                      }
                    else {
                        [num appendString:numStr];
                        [num appendString:st];
                        if (self.modetype == KuaiSanHezhi && expectationStr) {
                            [num1 appendString:expectationStr];
                            [num1 appendString:st];
                        }
                    }
                    selNum += 1;
                }
                
            }
            if ([num length]!=0) {
                [mStr appendString:num];
                if (self.modetype == KuaiSanHezhi && expectationStr) {
                    expectationStr = num1;
                }
            }
            else {
                [mStr appendString:@"e"];
            }
            
            if (selNum > 0) {
                [mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
                if (self.modetype == KuaiSanHezhi && expectationStr) {
                    [expectationStr deleteCharactersInRange:NSMakeRange([expectationStr length]-1, 1)];
                }
            }
            
        }
    }
	return (NSString *)mStr;
}

- (void)send {
    
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//        return;
//    }
//    if ([infoViewController.dataArray count] != 0 && ([[self seletNumber] isEqualToString:@"e"]||[[self seletNumber] isEqualToString:@"e|e"])) {
//        [self.navigationController pushViewController:infoViewController animated:YES];
//        return;
//    }
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    if ([zhushuLabel.text intValue] < 2 && modetype >= KuaiSanSanBuTongDanTuo) {
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
        if (b < 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择胆码"];
            return;
        }
        if (d< 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择拖码"];
            return;
        }
        int a = 3;
        if (modetype == KuaiSanSanBuTongDanTuo ) {
            a = 4;
        }
        if (b + d < a) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"胆码+拖码个数不少于%d个",a]];
            return;
        }
        return;
    }
    
    if ([zhushuLabel.text intValue] < 1) {
        NSString *selectNum = [self seletNumber];
        if (modetype == KuaiSanSanBuTong) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择3个号码。"];
            return;
        }
        else if (modetype == KuaiSanErButong) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请至少选择2个号码。"];
            return;
        }
        else if (modetype == KuaiSanErtongDan) {
            NSArray *array = [selectNum componentsSeparatedByString:@"|"];
            if ([array count] >= 2) {
                if ([[array objectAtIndex:0] isEqualToString:@"e"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"同号至少选择1个号码。"];
                }
                else {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"不同号至少选择1个号码。"];
                }
            }
            return;
        }
        return;
    }
    
    
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        NSString *selet = [self seletNumber];
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        infoV.lotteryType = lotterytype;
        infoV.modeType = modetype;
        infoV.betInfo.issue = issue;
        
        if ([zhushuLabel.text intValue] == 1 || self.modetype == KuaiSanSantongDan) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else if (self.modetype >= KuaiSanSanBuTongDanTuo){
            selet = [NSString stringWithFormat:@"03#%@",selet];
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeKuaiSan;
        }
//        infoViewController.danzhuJiangjin = colorLabel.text;
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;
        NSString *selet = [self seletNumber];
        
        if ([zhushuLabel.text intValue] == 1 || self.modetype == KuaiSanSantongDan) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else if (self.modetype >= KuaiSanSanBuTongDanTuo){
            selet = [NSString stringWithFormat:@"03#%@",selet];
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
    if (modetype == KuaiSanHezhi ) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:4 maxnum:17];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag];
                if (ball.tag < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag];
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
    else if (modetype == KuaiSanSantongDan) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:6];
        UIView *v = [backScrollView viewWithTag:1001];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([ball isKindOfClass:[CP_PTButton class]]) {
                    ball.selected = NO;
                }
                else if (ball.tag == [[randArray objectAtIndex:0] intValue]) {
                    ball.selected = YES;
                }
                else{
                    ball.selected = NO;
                    
                }
                UIButton *btn1 = (UIButton *)[ball.superview viewWithTag:ball.tag + 100];
                UIButton *btn2 = (UIButton *)[ball.superview viewWithTag:ball.tag + 200];
                btn1.selected = ball.selected;
                btn2.selected = ball.selected;
            }
        }
        
    }
    else if (modetype == KuaiSanErtongDan) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:6 IsRanged:NO];
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
                    UIButton *btn1 = (UIButton *)[ball.superview viewWithTag:ball.tag + 100];
                    btn1.selected = ball.selected;
                    
                }
                
            }
        }
    }
    else if (modetype == KuaiSanErTongFu) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:6 IsRanged:NO];
        UIView *v = [backScrollView viewWithTag:1007];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                
                if (ball.tag == [[randArray objectAtIndex:0] intValue]) {
                    ball.selected = YES;
                }
                else{
                    ball.selected = NO;
                }
                UIButton *btn1 = (UIButton *)[ball.superview viewWithTag:ball.tag + 100];
                btn1.selected = ball.selected;
            }
        }
    }
    else if (modetype == KuaiSanSanBuTong) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:6 IsRanged:YES];
        UIView *v = [backScrollView viewWithTag:1003];
        for (GCBallView *ball in v.subviews) {
            
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([randArray containsObject:[NSString stringWithFormat:@"%d",(int)ball.tag]]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
                
            }
        }
    }
    else if (modetype == KuaiSanErButong) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:6 IsRanged:YES];
        UIView *v = [backScrollView viewWithTag:1003];
        for (GCBallView *ball in v.subviews) {
            
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([randArray containsObject:[NSString stringWithFormat:@"%d",(int)ball.tag]]) {
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
-(void)pressTitleButton1:(UIButton *)sender{

    titleLabel.textColor = [UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:0.4];
    sanjiaoImageView.image = UIImageGetImageFromName(@"WanFaQieHuan_selected.png");

}
-(void)pressTitleButton2:(UIButton *)sender{

    titleLabel.textColor = [UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"WanFaQieHuan.png");

}
- (void)pressTitleButton:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:1];
    
    sanjiaoImageView.image = UIImageGetImageFromName(@"WanFaQieHuan.png");
    
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
    
//    self.CP_navigation.image = [UIImage imageNamed:@"kuaisanNav_1.png"];
    wanFaType = [wanArray indexOfObject:[self changeModetypeToString:modetype]];
    [self showWanFa];
//    NSLog(@"pressTitleButton");
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"普通",@"title",[NSArray arrayWithObjects:@"和值",@"三同号通选",@"三同号单选",@"二同号单选",@"二同号复选",@"三不同号",@"二不同号",@"三连号通选", nil],@"choose", nil];
//    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"胆拖",@"title",[NSArray arrayWithObjects:@"三不同号胆拖",@"二不同号胆拖",nil],@"choose", nil];
//    NSMutableArray *array2 = [NSMutableArray array];
//    [array2 addObject:dic];
//    [array2 addObject:dic2];
//    
//    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ChangCiTitle:@"" DataInfo:array2 cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
//    alert2.dantuoDuoXuan = NO;
//    alert2.delegate = self;
//    alert2.tag = 20;
//    [alert2 show];
//    NSInteger type = [wanArray indexOfObject:[self changeModetypeToString:modetype]];
//    if (type < 8) {
//        for (CP_XZButton *btn in [alert2.backScrollView viewWithTag:1000].subviews) {
//            if ([btn isKindOfClass:[CP_XZButton class]] &&btn.tag == type + 8) {
//                btn.selected = YES;
//            }
//        }
//    }
//    else {
//        for (CP_XZButton *btn in [alert2.backScrollView viewWithTag:1001].subviews) {
//            if ([btn isKindOfClass:[CP_XZButton class]] && btn.tag == type - 6) {
//                btn.selected = YES;
//            }
//        }
//    }
//    [alert2 release];
//    
}

-(void)showWanFa
{

    if (showing) {
        [self cancelSelectView];
    }else{
        UIImageView *sanjiao = (UIImageView *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoKai:sanjiao];
        
        showing = YES;
        [self.view addSubview:self.CP_navigation];
        self.CP_navigation.frame = CGRectMake(0, 0, 320, 44);
        
        blackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(self.CP_navigation) + changeWinOrigin, 320, self.view.frame.size.height - ORIGIN_Y(self.CP_navigation))];
        blackButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.CP_navigation.window addSubview:blackButton];
        [blackButton addTarget:self action:@selector(cancelSelectView) forControlEvents:UIControlEventTouchUpInside];
        
        selectImageView = [[UIImageView alloc] init];
//        selectImageView.image = UIImageGetImageFromName(@"kuaisanPushBG.jpg");
        selectImageView.backgroundColor = [UIColor colorWithRed:10/255.0 green:153/255.0 blue:122/255.0 alpha:1];
        [self.CP_navigation.window addSubview:selectImageView];
        selectImageView.userInteractionEnabled = YES;
        
        [self.CP_navigation.window addSubview:self.CP_navigation];
        self.CP_navigation.frame = CGRectMake(0, changeWinOrigin, 320, 44);
        
        NSArray * titleArray = [wanDictionary objectForKey:@"title"];
        NSArray * wanMoneyArray = [wanDictionary objectForKey:@"wanMoneyArray"];
        
        UIImageView * pushTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 9, 320, 25.5)] autorelease];
        pushTitleImageView.image = UIImageGetImageFromName(@"kuaisanPushTitle.png");
        [selectImageView addSubview:pushTitleImageView];
        
        UILabel * pushTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(pushTitleImageView.frame.size.width/2 - 15, 0, 34, pushTitleImageView.frame.size.height)] autorelease];
        pushTitleLabel.text = [titleArray objectAtIndex:0];
        pushTitleLabel.backgroundColor = [UIColor clearColor];
        pushTitleLabel.textColor = [UIColor whiteColor];
        pushTitleLabel.font = [UIFont systemFontOfSize:15];
        [pushTitleImageView addSubview:pushTitleLabel];
        
        float height = 0;
        for (int i = 0; i < wanArray.count; i++) {
            if (i < wanMoneyArray.count) {
                int a= i%3, b = i/3;
                GCBallView * selectButton = [[GCBallView alloc] initWithFrame:CGRectMake(8 + a * 103, ORIGIN_Y(pushTitleImageView) + 6 + b * 72, 98, 67) Num:[wanArray objectAtIndex:i] ColorType:GCBallViewColorKuaiSanWanFa];
                if (i == wanFaType) {
                    selectButton.selected = YES;
                }
                selectButton.tag = 10 + i;
                [selectImageView addSubview:selectButton];
                selectButton.numLabel.text = [wanArray objectAtIndex:i];
                
                selectButton.numLabel2.text = [wanMoneyArray objectAtIndex:i];
                
                [self diceViewByView:selectButton.ylLable i:i];
                [selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
                [selectButton addTarget:self action:@selector(selectButtonHL:) forControlEvents:UIControlEventTouchDown];
                [selectButton release];
            }else{
                int a= (int)(i - wanMoneyArray.count)%3, b = (int)(i - wanMoneyArray.count)/3;
                if (i == wanMoneyArray.count) {
                    GCBallView * ptLastBallView = (GCBallView *)[selectImageView viewWithTag:wanMoneyArray.count - 1 + 10];
                    UIImageView * pushTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(ptLastBallView) + 15, 320, 25.5)] autorelease];
                    pushTitleImageView.image = UIImageGetImageFromName(@"kuaisanPushTitle.png");
                    [selectImageView addSubview:pushTitleImageView];
                    
                    UILabel * pushTitleLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(pushTitleImageView.frame.size.width/2 - 15, 0, 34, pushTitleImageView.frame.size.height)] autorelease];
                    pushTitleLabel1.text = [titleArray objectAtIndex:1];
                    pushTitleLabel1.backgroundColor = [UIColor clearColor];
                    pushTitleLabel1.textColor = [UIColor whiteColor];
                    pushTitleLabel1.font = [UIFont systemFontOfSize:15];
                    [pushTitleImageView addSubview:pushTitleLabel1];
                    
                    height = ORIGIN_Y(pushTitleImageView);
                }
                GCBallView * selectButton = [[GCBallView alloc] initWithFrame:CGRectMake(8 + a * 103, height + 6 + b * 72, 98, 30) Num:[wanArray objectAtIndex:i] ColorType:GCBallViewColorKuaiSanWanFa];
                selectButton.tag = 10 + i;
                if (i == wanFaType) {
                    selectButton.selected = YES;
                }
                [selectImageView addSubview:selectButton];
                NSString * danTuoName = [[wanArray objectAtIndex:i] substringToIndex:[[wanArray objectAtIndex:i] length] - 2];
                selectButton.numLabel.text = danTuoName;
                selectButton.numLabel.frame = CGRectMake(0, 5, 98, 19);
                
                [selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
                [selectButton addTarget:self action:@selector(selectButtonHL:) forControlEvents:UIControlEventTouchDown];
                [selectButton release];
            }
        }
        GCBallView * lastBallView = (GCBallView *)[selectImageView viewWithTag:wanArray.count - 1 + 10];
        selectImageViewHeight = ORIGIN_Y(lastBallView) + 20;
        selectImageView.frame = CGRectMake(0, ORIGIN_Y(self.CP_navigation) - selectImageViewHeight, 320, selectImageViewHeight);
        [UIView animateWithDuration:ANIMATE_TIME animations:^{
            selectImageView.frame = CGRectMake(0, ORIGIN_Y(self.CP_navigation), 320, selectImageViewHeight);
        }];
    }
}

-(void)diceViewByView:(UIView *)superView i:(int)i
{
    NSArray * diceArray = [wanDictionary objectForKey:@"diceArray"];
    
    NSArray * diceNumArray = [[[diceArray objectAtIndex:i] objectAtIndex:0] componentsSeparatedByString:@","];
    for (int j = 0; j < diceNumArray.count; j++) {
        UIImageView * diceImageView = [[UIImageView alloc] initWithFrame:CGRectMake((superView.frame.size.width - diceNumArray.count * 20 + 3)/2 +  j * 20, 0, 17, 17)];
        diceImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"kuaisanDice_%d.png",(int)[[diceNumArray objectAtIndex:j] integerValue] - 1]];
        [superView addSubview:diceImageView];
        [diceImageView release];
        
        if (i == 0) {
            if (j < diceNumArray.count -1) {
                UIImageView * plusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32.5 + j * 25.5, 5, 7, 7)];
                plusImageView.image = UIImageGetImageFromName(@"kuaisanPlus.png");
                [superView addSubview:plusImageView];
                [plusImageView release];
            }
            diceImageView.frame = CGRectMake(15 + 25.5 * j, 0, 17, 17);
        }
    }
}

-(void)selectButtonHL:(id)sender
{
    self.showYiLou = NO;
    GCBallView * selectedBallView = (GCBallView *)[selectImageView viewWithTag:wanFaType + 10];
    selectedBallView.selected = NO;
    
    UIImageView *sanjiao = (UIImageView *)[self.CP_navigation.titleView viewWithTag:567];
    [SharedMethod sanJiaoGuan:sanjiao];
}

-(void)selectButton:(id)sender
{
    
    [self pressBgButton:sender];
    [self cancelSelectView];
}

-(void)cancelSelectView
{
    UIImageView *sanjiao = (UIImageView *)[self.CP_navigation.titleView viewWithTag:567];
    [SharedMethod sanJiaoGuan:sanjiao];
    
    [UIView animateWithDuration:ANIMATE_TIME animations:^{
        if (changePage == NO) {
            selectImageView.frame = CGRectMake(0, ORIGIN_Y(self.CP_navigation) - 409.5, 320, selectImageViewHeight);
        }
    } completion:^(BOOL finished) {
        [selectImageView removeFromSuperview];
        [blackButton removeFromSuperview];
//        [bang removeFromSuperview];
        
        [self.view addSubview:self.CP_navigation];
        if (IS_IOS7) {
            self.CP_navigation.frame = CGRectMake(0, changeWinOrigin, 320, 44);
        }else{
            self.CP_navigation.frame = CGRectMake(0, 0, 320, 44);
        }
//        self.CP_navigation.image = UIImageGetImageFromName(@"kuaisanNav.png");
        showing = NO;
    }];
}

//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    // if (buf[sender.tag] == 0) {
	UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
	image.hidden = NO;
	UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
	imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
    //    buf[sender.tag] = 1;
	titleLabel.text = [NSString  stringWithFormat:@"快3 %@", [wanArray objectAtIndex:sender.tag - 1]];
    
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
    for (int i = 1000;i<1009;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        v.hidden = YES;
    }
    yaolabel.hidden = NO;
    randBtn.hidden = NO;
    if (self.issue) {
//        titleLabel.text = [NSString stringWithFormat:@"%@ %@期",[self changeModetypeToString:modetype],self.issue];
        NSString * str = [self getLastTwoStr:self.issue];
        titleLabel.text = [NSString stringWithFormat:@"%@ %@期",[self changeModetypeToString:modetype],str];
    }
else {
        titleLabel.text = [NSString stringWithFormat:@"快3 %@",[self changeModetypeToString:modetype]];
    }
    //⓪ ① ② ③ ④ ⑤ ⑥ ⑦ ⑧
    UIView * bg = (UIView *)[self.CP_navigation.titleView viewWithTag:999];
    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UIImageView *la = (UIImageView *)[self.CP_navigation.titleView viewWithTag:567];

    CGSize tlSize = [tl.text sizeWithFont:tl.font constrainedToSize:CGSizeMake(1000,44) lineBreakMode:NSLineBreakByWordWrapping];
    tl.frame = CGRectMake(0, 0, tlSize.width, 44);
    la.frame = CGRectMake(ORIGIN_X(tl) + 2, 14, 17, 17);
    bg.frame = CGRectMake((320 - ORIGIN_X(la))/2, 0, ORIGIN_X(la) + 2, 44);
    
    switch (modetype) {
        case KuaiSanHezhi:
        {
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"hzhyl" firstTag:3 yiLouTag:3 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            
            [self setNameLabelFrameWithView:v nameText:@"" name1Text:@""];
        }
            break;
        case KuaiSanSantongTong:
        {
            UIView *v = [backScrollView viewWithTag:1008];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"forma" firstTag:1 keyArray:@[@"st"] normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            ///要调
            [self setNameLabelFrameWithView:v nameText:@"三同号" name1Text:@""];
        }
            break;
        case KuaiSanSantongDan:
        {
            UIView *v = [backScrollView viewWithTag:1001];
            v.hidden = NO;
            v.userInteractionEnabled = YES;

            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"styl" normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            ///要调
            [self setNameLabelFrameWithView:v nameText:@"三同号" name1Text:@"至少选1个"];
        }
            break;
        case KuaiSanErtongDan:
        {
            for (int i = 1002;i<1004;i++)   {
                UIView *v = [backScrollView viewWithTag:i];
                v.hidden = NO;

                if (i == 1002) {
                    [self setNameLabelFrameWithView:v nameText:@"二同号" name1Text:@"至少选1组"];
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"etfsyl" firstTag:1 keyArray:@[@"11",@"22",@"33",@"44",@"55",@"66"] normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];

                }
                else {
                    [self setNameLabelFrameWithView:v nameText:@"不同号" name1Text:@"至少选1个"];
                    [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"etbtyl" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
                    
                }
                
            }
        }
            break;
        case KuaiSanErTongFu:
        {
            UIView *v = [backScrollView viewWithTag:1007];
            v.hidden = NO;

            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"etfsyl" firstTag:1 keyArray:@[@"11",@"22",@"33",@"44",@"55",@"66"] normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v nameText:@"二同号" name1Text:@"至少选1组"];

        }
            break;
        case KuaiSanSanBuTong:
        {
            UIView *v = [backScrollView viewWithTag:1003];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
     
            [self setNameLabelFrameWithView:v nameText:@"三不同" name1Text:@"至少选3个"];
  
        }
            break;
        case KuaiSanErButong:
        {
            UIView *v = [backScrollView viewWithTag:1003];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            
            [self setNameLabelFrameWithView:v nameText:@"二不同" name1Text:@"至少选2个"];

        }
            break;
            
        case KuaiSanSanLianTong:
        {
            UIView *v = [backScrollView viewWithTag:1004];
            v.hidden = NO;

            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"forma" firstTag:1 keyArray:@[@"sl"] normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v nameText:@"三连号" name1Text:@""];
        }
            break;
        case KuaiSanSanBuTongDanTuo:
        {
            UIView *v = [backScrollView viewWithTag:1005];
            v.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v nameText:@"胆码" name1Text:@"我认为必出的号 选2个"];

            UIView *v2 = [backScrollView viewWithTag:1006];
            v2.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v2 dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v2 nameText:@"拖码" name1Text:@"我认为可能出的号 至少选2个"];

        }
            break;
        case KuaiSanErBuTongDanTuo:
        {
            UIView *v = [backScrollView viewWithTag:1005];
            v.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v nameText:@"胆码" name1Text:@"我认为必出的号 选1个"];

            UIView *v2 = [backScrollView viewWithTag:1006];
            v2.hidden = NO;
            [YiLouUnderGCBallView addYiLouTextOnView:v2 dictionary:yilouDic typeStr:@"rt" firstTag:1 yiLouTag:1 normalColor:YILOU_COLOR maxColor:YILOU_COLOR_MAX];
            [self setNameLabelFrameWithView:v2 nameText:@"拖码" name1Text:@"我认为可能出的号 至少选2个"];
        }
            break;
        default:
            break;
    }
    UIView * btn = (UIView *)[self.CP_navigation.titleView viewWithTag:998];
    btn.frame = bg.bounds;
    
    float heght = ORIGIN_Y(shakeImageView) + 16;
    for (int i = 1000;i<1009;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        if (v.hidden == NO) {
            if (i == 1000) {
                heght = ORIGIN_Y(shakeImageView) + 7;
            }
            v.frame = CGRectMake(v.frame.origin.x,heght , v.bounds.size.width, v.bounds.size.height);
//            heght = heght + v.bounds.size.height-1;
            heght = ORIGIN_Y(v) + 9;
        }
    }
//    if (backScrollView.frame.size.height > heght + 25) {
//        heght = backScrollView.frame.size.height - 25;
//    }
    [self changeShuoMing];
    
    backScrollView.contentSize = CGSizeMake(320,heght +25);
//    if (modetype == KuaiSanHezhi) {
//        backScrollView.contentSize = CGSizeZero;
//    }
    
    NSLog(@"~~%f~~%f~~",backScrollView.contentSize.height,self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + 44 + isIOS7Pianyi);
    
//    if (self.showYiLou) {
//        self.showYiLou = YES;
//    }
    
}

-(void)setNameLabelFrameWithView:(UIView *)imageView nameText:(NSString *)nameText name1Text:(NSString *)name1Text
{
    UIImageView * nameImageView = (UIImageView *)[imageView viewWithTag:456];
    UILabel * nameLabel = (UILabel *)[nameImageView viewWithTag:457];
    UILabel * nameLabel1 = (UILabel *)[nameImageView viewWithTag:458];
    
    nameLabel.text = nameText;
    CGSize titleLabelSize = [nameText sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(100, 25.5)];
    nameLabel.frame = CGRectMake(14, 0, titleLabelSize.width, 27);
    
    nameImageView.frame = CGRectMake(0, 0, nameLabel.frame.size.width + 20, 27);
    
    nameLabel1.text = name1Text;
    CGSize nameLabelSize1 = [name1Text sizeWithFont:nameLabel1.font constrainedToSize:CGSizeMake(200, 25.5)];
    nameLabel1.frame = CGRectMake(ORIGIN_X(nameImageView) + 5, nameLabel.frame.origin.y, nameLabelSize1.width, nameLabel.frame.size.height);
}

- (void)pressBgButton:(UIButton *)sender{
    if (sender.tag <= [wanArray count] + 10) {
        NSString *str = [wanArray objectAtIndex:sender.tag - 10];
        modetype = [self changeStringToMode:str];
        if (myKuaiSanType == NeiMengKuaiSan) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"KuaiSanDefaultModetype"];
        }
        else if (myKuaiSanType == JiangSuKuaiSan) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"JSKuaiSanDefaultModetype"];
        }
        else if (myKuaiSanType == HuBeiKuaiSan) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"HBKuaiSanDefaultModetype"];
        }
        else if (myKuaiSanType == JiLinKuaiSan) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"JLKuaiSanDefaultModetype"];
        }
        else if (myKuaiSanType == AnHuiKuaiSan) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"AHKuaiSanDefaultModetype"];
        }
    }
    [self clearBalls];
	[self changeTitle];
	[self ballSelectChange:nil];
	//[self ballSelectChange:nil];
}


- (void)doBack {
    changePage = YES;
    [self cancelSelectView];
    [self.navigationController popViewControllerAnimated:YES];
}

//新手指南
//- (void)toGuide
//{
//    NSLog(@"新手指南~~");
//    
//    kuaisanShuoming *kuaishuo=[[kuaisanShuoming alloc]init];
//    kuaishuo.title=@"快3新手入门";
//    [self.navigationController pushViewController:kuaishuo animated:YES];
//    [kuaishuo release];
//    
//}

//玩法介绍
- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    
	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    if (myKuaiSanType == NeiMengKuaiSan) {
        xie.ALLWANFA = Kuai3;
    }
    else if (myKuaiSanType == JiangSuKuaiSan) {
        xie.ALLWANFA = JSKuai3;
    }
    else if (myKuaiSanType == HuBeiKuaiSan) {
        xie.ALLWANFA = HBKuai3;
    }
    else if (myKuaiSanType == JiLinKuaiSan) {
        xie.ALLWANFA = JLKuai3;
    }
    else if (myKuaiSanType == AnHuiKuaiSan) {
        xie.ALLWANFA = AHKuai3;
    }
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

        if (self.modetype != KuaiSanSantongTong && self.modetype < KuaiSanSanLianTong) {

            [self randBalls];
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
        
    }
	[super motionEnded:motion withEvent:event];
}

- (void)getYilou {
    self.yilouDic = nil;
    [self changeTitle];
    
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:myLotteryID];
    
    if([yilou_Dic objectForKey:self.issue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
        return;
    }
    
    [self.yilouRequest clearDelegatesAndCancel];
    if (!myIssrecord) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:@"1" issue:@""]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:@"1" issue:@"" cacheable:YES]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(reqYilouFail:)];
    [yilouRequest startAsynchronous];
}

- (void)reqYilouFail:(ASIHTTPRequest*)request
{
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}


- (void)goHistory {
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId = myLotteryID;
    if (myKuaiSanType == NeiMengKuaiSan) {
        controller.lotteryName = @"内蒙古快3";
    }
    else if (myKuaiSanType == JiangSuKuaiSan) {
        controller.lotteryName = @"江苏快3";
    }
    else if (myKuaiSanType == HuBeiKuaiSan) {
        controller.lotteryName = @"湖北快3";
    }
    else if (myKuaiSanType == JiLinKuaiSan) {
        controller.lotteryName = @"吉林快3";
    }
    else if (myKuaiSanType == AnHuiKuaiSan) {
        controller.lotteryName = @"新快3";
    }

    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
}

- (void)daxiaodanshuangChange:(UIButton *)sender {
    if (sender == daBall) {
        xiaoBall.selected = NO;
    }
    else if (sender == xiaoBall) {
        daBall.selected = NO;
    }
    else if (sender == danBall) {
        shuangBall.selected = NO;
    }
    else if (sender == shuangBall) {
        danBall.selected = NO;
    }
    UIView *ballView = [backScrollView viewWithTag:1000];
    for (GCBallView *ball in ballView.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            if (ball.tag >= 3 && ball.tag <= 18) {
                if (daBall.selected) {
                    if (danBall.selected) {
                        if (ball.tag >= 11) {
                            if (ball.tag %2 == 1) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag >= 11) {
                            if (ball.tag %2 == 0) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        if (ball.tag >= 11) {
                            ball.selected = YES;
                        }
                        else
                        {
                            ball.selected = NO;
                        }
                    }
                }
                else if (xiaoBall.selected){
                    if (danBall.selected) {
                        if (ball.tag < 11) {
                            if (ball.tag %2 == 1) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag < 11) {
                            if (ball.tag %2 == 0) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        if (ball.tag < 11) {
                            ball.selected = YES;
                        }
                        else
                        {
                            ball.selected = NO;
                        }
                    }
                }
                else {
                    if (danBall.selected) {
                        if (ball.tag %2 == 1) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag %2 == 0) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        ball.selected = NO;
                    }
                }
            }
            
            
        }
    }
    [self ballSelectChange:nil];
}



#pragma mark -
#pragma mark GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
    if (imageView.tag >= 100) {//大小单双
        [self daxiaodanshuangChange:imageView];
        return;
    }
    if (imageView) {
        daBall.selected = NO;
        xiaoBall.selected = NO;
        danBall.selected = NO;
        shuangBall.selected = NO;
    }
	NSUInteger bets = 0;
    if (self.modetype == KuaiSanErtongDan && imageView) {
        UIView *v = [backScrollView viewWithTag:1002];
        if (v == imageView.superview) {
            v = [backScrollView viewWithTag:1003];
        }
        GCBallView *v2 = (GCBallView *)[v viewWithTag:imageView.tag];
        if (v2.selected) {
            imageView.selected = NO;
            [[caiboAppDelegate getAppDelegate] showMessage:@"同号和不同号不能相同"];
            return;
        }
    }
    if (self.modetype >= KuaiSanSanBuTongDanTuo && imageView) {
        UIView *v = [backScrollView viewWithTag:1005];
        if (v == imageView.superview) {
            v = [backScrollView viewWithTag:1006];
        }
        GCBallView *v2 = (GCBallView *)[v viewWithTag:imageView.tag];
        if (v2.selected) {
            imageView.selected = NO;
            [[caiboAppDelegate getAppDelegate] showMessage:@"胆码和拖码不能重复"];
            return;
        }
        if (imageView.superview.tag == 1005) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if ([btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
                    i++;
                }
            }
            int a = 1;
            if (modetype == KuaiSanSanBuTongDanTuo ) {
                a = 2;
                
            }
            if (imageView.selected && modetype >= KuaiSanSanBuTongDanTuo && i>a) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:[NSString stringWithFormat:@"胆码最多选择%d个",a]];
                imageView.selected = NO;
                [self ballSelectChange:nil];
                return;
            }
        }
        
    }
//    UIButton *btn1 = (UIButton *)[imageView.superview viewWithTag:imageView.tag + 100];
//    UIButton *btn2 = (UIButton *)[imageView.superview viewWithTag:imageView.tag + 200];
//    NSLog(@"%@",btn1);
//    btn1.selected = imageView.selected;
//    btn2.selected = imageView.selected;
    
    UILabel * expectationLabel = (UILabel *)[expectationView viewWithTag:10];

    bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:modetype];

    if (bets > 0) {
//        zhuShuAndJinE.hidden = NO;
//        colorLabel.hidden = YES;
//        zhuShuAndJinE.text = [NSString stringWithFormat:@"<%d> 注  <%d> 元",bets ,bets *2];
        
        if (modetype == KuaiSanHezhi) {
            NSArray * numberArray  = [expectationStr componentsSeparatedByString:@","];
            NSArray * sortArray = [numberArray sortedArrayUsingFunction:sortTypeK context:nil];

            int max = (int)[[sortArray lastObject] integerValue];
            int min = (int)[[sortArray objectAtIndex:0] integerValue];
            if (numberArray.count == 1 || max == min) {
                expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%d元，盈利%d元",max,max - (int)bets * 2];
            }else{
                expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%d至%d元，盈利%d至%d元",min,max,min - (int)bets * 2,max - (int)bets * 2];
            }
        }else{
            NSString * bonus = @"";
//            NSLog(@"~~%d~~",modetype);
            if (modetype == KuaiSanSantongTong) {
                bonus = @"40";
            }
            else if (modetype == KuaiSanErBuTongDanTuo) {
                bonus = @"8";
            }
            else{
                NSArray * bonusArray = [shuomingLabel.text componentsSeparatedByString:@"<"];
                if ([bonusArray count] > 1) {
                    bonus = [[[bonusArray objectAtIndex:1] componentsSeparatedByString:@">"] objectAtIndex:0];
                }
                
            }
            NSString * profit = [NSString stringWithFormat:@"%ld",(long)[bonus integerValue] - (long)bets * 2];
            expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%@元，盈利%@元",bonus,profit];
        }
        
        [UIView animateWithDuration:ANIMATE_TIME animations:^{
            expectationView.frame = CGRectMake(0, self.view.frame.size.height - 44 -25, 320, 25);
        } completion:^(BOOL finished) {
            
        }];
        
//        CGSize  accuntSize = [accuntLabel.text sizeWithFont:accuntLabel.font constrainedToSize:CGSizeMake(158,28) lineBreakMode:NSLineBreakByWordWrapping];
//        accuntLabel.frame = CGRectMake((320 - accuntSize.width)/2 + 55, 7, accuntSize.width, 15);

    }
    else {
//        zhuShuAndJinE.hidden = YES;
//        colorLabel.hidden = NO;
        [UIView animateWithDuration:ANIMATE_TIME animations:^{
            expectationView.frame = CGRectMake(0, self.view.frame.size.height - 44, 320, 25);
        } completion:^(BOOL finished) {
            expectationLabel.text = @"";
        }];

//        CGSize  accuntSize = [accuntLabel.text sizeWithFont:accuntLabel.font constrainedToSize:CGSizeMake(158,28) lineBreakMode:NSLineBreakByWordWrapping];
//        accuntLabel.frame = CGRectMake((320 - accuntSize.width)/2, 7, accuntSize.width, 15);
    }

    zhushuLabel.text = [NSString stringWithFormat:@"%ld",(long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%ld",(long)2*bets];
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
//    UIImageView *ima = (UIImageView *)[senBtn viewWithTag:1108];
    senBtn.enabled = YES;
    NSString *str =[[[[self seletNumber] stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"|" withString:@""];
    if ([str length] == 0 /*&& [infoViewController.dataArray count] == 0*/) {
        if (modetype < KuaiSanSanBuTongDanTuo && modetype != KuaiSanSantongTong && modetype != KuaiSanSanLianTong) {
//            ima.alpha = 1;
//            labe.text = @"机选";
//            labe.textColor = [UIColor whiteColor];
            
            [senBtn setTitle:@"机选" forState:UIControlStateNormal];
            
            qingbutton.enabled = NO;
        }
        else {
//            ima.alpha = 1;
//            labe.text = @"选好了";
            [senBtn setTitle:@" 选好了" forState:UIControlStateNormal];

            senBtn.enabled = NO;
//            labe.textColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
            qingbutton.enabled = NO;

        }
    }
    else {
//        ima.alpha = 1;
//        labe.text = @"选好了";
        [senBtn setTitle:@" 选好了" forState:UIControlStateNormal];
        qingbutton.enabled = YES;
//        labe.textColor = [UIColor whiteColor];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate


- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号",@"和值",@"类型"]];

//		self.wangQi = wang;
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            NSLog(@"~~~~~~~~~%@~~~~~~~",info.issue);
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[self getLastTwoStr:info.issue]]];
            
            NSArray * numberArray = [info.num componentsSeparatedByString:@","];
            NSString * numberString = @"";
            int heZhi = 0;
            for (int j = 0; j < numberArray.count; j++) {
                NSString * numbers = [NSString stringWithFormat:@"%ld",(long)[[numberArray objectAtIndex:j] integerValue]];
                numberString =  [numberString stringByAppendingString:numbers];
                if (j != numberArray.count - 1) {
                    numberString =  [numberString stringByAppendingString:@"  "];
                }
                heZhi += [numbers integerValue];
            }
            [dataArray addObject:numberString];
            
            NSString *daxiao = @"";
            NSString *danshuang = @"";
            int a= (int)[[numberArray objectAtIndex:0] integerValue];
            int b= (int)[[numberArray objectAtIndex:1] integerValue];
            int c= (int)[[numberArray objectAtIndex:2] integerValue];
            if (a + b + c > 10) {
                daxiao = @"大";
            }
            else {
                daxiao = @"小";
            }
            if ((a + b + c) % 2 == 0) {
                danshuang = @"双";
            }
            else {
                danshuang = @"单";
            }
            [dataArray addObject:[NSString stringWithFormat:@"%d  %@  %@",heZhi,daxiao,danshuang]];
            
            NSString * typeStr = @"";
            sameCount = 0;
            NSArray * sortArray = [numberArray sortedArrayUsingFunction:sortTypeK context:nil];
            if (sameCount == 2) {
                typeStr = @"三同号";
            }else if (sameCount == 1){
                typeStr = @"二同号";
            }else{
                if ([[sortArray objectAtIndex:2] integerValue] - [[sortArray objectAtIndex:0] integerValue] == 2) {
                    typeStr = @"三连号";
                }else{
                    typeStr = @"三不同号";
                }
            }
            [dataArray addObject:typeStr];
            [historyArr addObject:dataArray];
            [dataArray release];
            
//            UILabel * periodLabel = (UILabel *)[self.cpHistoryBGImageView viewWithTag:10 + i];
//            NSString * periodStr = [NSString stringWithFormat:@"%@期",[self getLastTwoStr:info.issue]];
//            periodLabel.text = periodStr;
//            
//            UILabel * numberLabel = (UILabel *)[self.cpHistoryBGImageView viewWithTag:20 + i];
//            NSArray * numberArray = [info.num componentsSeparatedByString:@","];
//            NSString * numberString = @"";
//            int heZhi = 0;
//            for (int j = 0; j < numberArray.count; j++) {
//                NSString * numbers = [NSString stringWithFormat:@"%d",[[numberArray objectAtIndex:j] integerValue]];
//                numberString =  [numberString stringByAppendingString:numbers];
//                if (j != numberArray.count - 1) {
//                    numberString =  [numberString stringByAppendingString:@" "];
//                }
//                heZhi += [numbers integerValue];
//            }
//            numberLabel.text = numberString;
//            
//            UILabel * heZhiLabel = (UILabel *)[self.cpHistoryBGImageView viewWithTag:30 + i];
//            heZhiLabel.text = [NSString stringWithFormat:@"和值 %d",heZhi];
//            
//            UILabel * daXiaoLabel = (UILabel *)[self.cpHistoryBGImageView viewWithTag:40 + i];
//                NSString *daxiao = @"";
//                NSString *danshuang = @"";
//                int a= [[numberArray objectAtIndex:0] integerValue];
//                int b= [[numberArray objectAtIndex:1] integerValue];
//                int c= [[numberArray objectAtIndex:2] integerValue];
//                if (a + b + c > 11) {
//                    daxiao = @"大";
//                }
//                else {
//                    daxiao = @"小";
//                }
//                if ((a + b + c) % 2 == 0) {
//                    danshuang = @"双";
//                }
//                else {
//                    danshuang = @"单";
//                }
//                daXiaoLabel.text = [NSString stringWithFormat:@"%@  %@",daxiao,danshuang];
//            
//            UILabel * typeLabel = (UILabel *)[self.cpHistoryBGImageView viewWithTag:50 + i];
//            sameCount = 0;
//            NSArray * sortArray = [numberArray sortedArrayUsingFunction:sortTypeK context:nil];
//            if (sameCount == 2) {
//                typeLabel.text = @"同号";
//            }else if (sameCount == 1){
//                typeLabel.text = @"二同号";
//            }else{
//                if ([[sortArray objectAtIndex:2] integerValue] - [[sortArray objectAtIndex:0] integerValue] == 2) {
//                    typeLabel.text = @"三连号";
//                }else{
//                    typeLabel.text = @"三不同号";
//                }
//            }
        }
        [self addHistoryWithArray:historyArr];
//		[mytableView reloadData];
//        [_cpTableView reloadData];
//        [wang release];
	}
}

static int sameCount;//同号数量
NSInteger sortTypeK(id s1,id s2,void *cha)
{
    if([s1 integerValue] < [s2 integerValue]){
        return NSOrderedAscending;
    }else if([s1 integerValue] > [s2 integerValue]){
        return NSOrderedDescending;
    }
    sameCount++;
    return NSOrderedSame;
}
- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    if ([[yilouDic objectForKey:@"hzhyl"] count]) {
        
        hasYiLou = YES;
        
        if (showYiLou) {
            [self upDataYilou];
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
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [[responseStr JSONValue] valueForKey:@"list"];
        if ([array count] >= 1) {
            self.yilouDic = [array objectAtIndex:0];
            
            if ([[yilouDic valueForKey:@"hzhyl"] count]) {
                
                //删除旧的遗漏值
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLotteryID];
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:myLotteryID];
                
                hasYiLou = YES;
                if (showYiLou) {
                    [self upDataYilou];
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
                timeLabel.text = [NSString stringWithFormat:@"%@",[self getLastTwoStr:issrecord.curIssue]];
            }
            if (!shaizi1View) {
                shaizi1View = [[UIImageView alloc] initWithFrame:CGRectMake(80, sqkaijiang.frame.size.height/2 - 21/2, 20, 21)];
                [sqkaijiang addSubview:shaizi1View];
                [shaizi1View release];
                
                shaizi2View = [[UIImageView alloc] initWithFrame:CGRectMake(105, sqkaijiang.frame.size.height/2 - 21/2, 20, 21)];
                [sqkaijiang addSubview:shaizi2View];
                [shaizi2View release];
                
                shaizi3View = [[UIImageView alloc] initWithFrame:CGRectMake(130, sqkaijiang.frame.size.height/2 - 21/2, 20, 21)];
                [sqkaijiang addSubview:shaizi3View];
                [shaizi3View release];
                
                topNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(shaizi3View) + 10, 0, 60, sqkaijiang.frame.size.height)];
                topNumberLabel.backgroundColor = [UIColor clearColor];
                topNumberLabel.textColor = [UIColor whiteColor];
                topNumberLabel.font = [UIFont fontWithName:@"TRENDS" size:17];

                [sqkaijiang addSubview:topNumberLabel];
            }

            
            NSArray *array1 = [issrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
            if (!sqkaijiang.text) {
                if ([array1 count] > 0) {
//                    sqkaijiang.text = [NSString stringWithFormat:@"%@期",[array1 objectAtIndex:0]];
                    NSString * str = [self getLastTwoStr:[array1 objectAtIndex:0]];
                    sqkaijiang.text = [NSString stringWithFormat:@"%@期开奖",str];
                }
                if ([array1 count] > 1) {
                    NSArray *numArray = [[array1 objectAtIndex:1] componentsSeparatedByString:@","];
                    if ([numArray count] >= 3) {
                        [self changeNumToShaiZi:numArray];
                    }
                }

            }
            else {
            }
            yanchiTime = [issrecord.lotteryStatus intValue];
//            NSLog(@"%lld",[[array1 objectAtIndex:0] longLongValue]);
            
            if ([issrecord.curIssue longLongValue] - [[array1 objectAtIndex:0] longLongValue] >= 2 && [issrecord.curIssue longLongValue] - [[array1 objectAtIndex:0] longLongValue] <= 10) {
                isKaiJiang = NO;
//                timeLabel.text = [NSString stringWithFormat:@"距%lld期开奖",[issrecord.curIssue longLongValue] - 1];
                NSString * str = [self getLastTwoStr:[NSString stringWithFormat:@"%lld",[issrecord.curIssue longLongValue]]];
                timeLabel.text = [NSString stringWithFormat:@"距%@期截止",str];
                
                if (canRefreshYiLou) {
                    self.yilouDic = nil;
                    [self changeTitle];
                    hasYiLou = NO;
                }
            }
            else {
                isKaiJiang = YES;
//                timeLabel.text = [NSString stringWithFormat:@"距%@期开奖",issrecord.curIssue];
                NSString * str = [self getLastTwoStr:issrecord.curIssue];
                timeLabel.text = [NSString stringWithFormat:@"距%@期截止",str];
                
                if (![self.myIssrecord.curIssue isEqualToString:issrecord.curIssue]) {
                    [self getYilou];
                }else if (!hasYiLou && canRefreshYiLou) {
                    [self getYilou];
                }
                canRefreshYiLou = YES;
                
                self.myIssrecord = issrecord;
            }
            
            if ([self.issue length] && ![self.issue isEqualToString:issrecord.curIssue] && isAppear) {
                NSString * shortIssue = [self.issue substringFromIndex:self.issue.length - 2];
                NSString * shortCurIssue = [issrecord.curIssue substringFromIndex:issrecord.curIssue.length - 2];
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@期已截止>\n当前期是%@期，投注时请注意期次",shortIssue,shortCurIssue] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.alertTpye = jieQiType;
                [alert show];
                
                [alert release];
                
            }
            //            self.issue = [issrecord.curIssue substringFromIndex:issrecord.curIssue.length - 2];
            self.issue = issrecord.curIssue;
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

-(NSString *)getLastTwoStr:(NSString *)str
{
    if (str.length > 2) {
        return [str substringFromIndex:str.length - 2];
    }
    return str;
}

//-(void)addYiLouTextOnView:(UIView *)view typeStr:(NSString *)typeStr
//{
//    NSArray * numberArr =[self.yilouDic objectForKey:typeStr];
//    NSString * maxNum = [NSString stringWithFormat:@"%@",[[numberArr sortedArrayUsingFunction:sortTypeK context:nil] lastObject]];
//    for (GCBallView *ball in view.subviews) {
//        if ([ball isKindOfClass:[GCBallView class]]) {
//            ball.ylLable.text = @"-";
//            ball.ylLable.textColor = [UIColor colorWithRed:132/255.0 green:204/255.0 blue:186/255.0 alpha:1];
//            if (numberArr.count != 0) {
//                ball.ylLable.text = [NSString stringWithFormat:@"%@",[numberArr objectAtIndex:ball.tag - 1]];
//                if ([maxNum isEqualToString:ball.ylLable.text]) {
//                    ball.ylLable.textColor = [UIColor yellowColor];
//                }
//            }
//        }
//    }
//}

- (void)renXuanYiLouFunc:(NSMutableArray *)allArray type:(int)cztype{

    if (redrawHZ) {
        redrawHZ.hidden = YES;
    }
    if (redrawSTH) {
        redrawSTH.hidden = YES;
    }
    if (redrawETH) {
        redrawETH.hidden = YES;
    }
    if (redrawSLH) {
        redrawSLH.hidden = YES;
    }
    if (redrawSBT) {
        redrawSBT.hidden = YES;
    }
    if (redrawEBT) {
        redrawEBT.hidden = YES;
    }

    if (redrawTitleHZ) {
        redrawTitleHZ.hidden = YES;
    }
    if (redrawTitleSTH) {
        redrawTitleSTH.hidden = YES;
    }
    if (redrawTitleETH) {
        redrawTitleETH.hidden = YES;
    }
    if (redrawTitleSLH) {
        redrawTitleSLH.hidden = YES;
    }
    if (redrawTitleSBT) {
        redrawTitleSBT.hidden = YES;
    }
    if (redrawTitleEBT) {
        redrawTitleEBT.hidden = YES;
    }
    
    

    if (cztype == 1) {//和值
        if (!redrawTitleHZ) {
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanHeZhi kuaiSanType:1];
            chartFormatData.numberOfLines = 16;
            chartFormatData.linesWidth = 24;
            chartFormatData.lottoryColor = ThreeColor;
            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);
            
            redrawTitleHZ = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            redrawTitleHZ.delegate = self;
            [headYiLouView addSubview:redrawTitleHZ];
            [redrawTitleHZ release];
            
            redrawHZ = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            redrawHZ.delegate = self;
            [yiLouView addSubview:redrawHZ];
            [redrawHZ release];

            [chartFormatData release];
        }
        
        redrawTitleHZ.hidden = NO;
        redrawHZ.hidden = NO;
        [redrawHZ reduction];

    }else if (cztype == 2){//三同号
        if (!redrawTitleSTH) {
            
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanSanTong kuaiSanType:0];
            chartFormatData.linesTitleArray = @[@"三同号",@"三不同号",@"二同号",@"二不同号"];
            chartFormatData.drawType = FourColorSquare;
            
            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);

            redrawTitleSTH = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            [headYiLouView addSubview:redrawTitleSTH];
            [redrawTitleSTH release];
            
            redrawSTH = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            [yiLouView addSubview:redrawSTH];
            [redrawSTH release];
            
            [chartFormatData release];
        }
        redrawTitleSTH.hidden = NO;
        redrawSTH.hidden = NO;
        [redrawSTH reduction];
    
    }else if (cztype == 3){//二同号
        if (!redrawTitleETH) {
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanErTong kuaiSanType:0];
            chartFormatData.linesTitleArray = @[@"11",@"22",@"33",@"44",@"55",@"66"];
            chartFormatData.drawType = YellowSquare;

            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);
            redrawTitleETH = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            [headYiLouView addSubview:redrawTitleETH];
            [redrawTitleETH release];
            
            redrawETH = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            [yiLouView addSubview:redrawETH];
            [redrawETH release];
            
            [chartFormatData release];
        }
        redrawTitleETH.hidden = NO;
        redrawETH.hidden =  NO;
        [redrawETH reduction];

    
    }else if (cztype == 4){//二不同号
        if (!redrawTitleEBT) {
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanErBu kuaiSanType:0];
            chartFormatData.linesTitleArray = @[@"12",@"13",@"14",@"15",@"16",@"23",@"24",@"25",@"26",@"34",@"35",@"36",@"45",@"46",@"56"];
            chartFormatData.drawType = BlueKSquare;
            chartFormatData.linesWidth = 23;

            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);
            redrawTitleEBT = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            redrawTitleEBT.delegate = self;
            [headYiLouView addSubview:redrawTitleEBT];
            [redrawTitleEBT release];
            
            redrawEBT = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            redrawEBT.delegate = self;
            [yiLouView addSubview:redrawEBT];
            [redrawEBT release];
            
            [chartFormatData release];
        }
        redrawTitleEBT.hidden = NO;
        redrawEBT.hidden = NO;
        [redrawEBT reduction];
        
    }else if (cztype == 5){
        if (!redrawTitleSBT) {
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanSanBu kuaiSanType:1];
            chartFormatData.numberOfLines = 6;
            chartFormatData.lineColor = NoLine;
            chartFormatData.drawType = ThreeColorCircle;
            chartFormatData.lottoryColor = ThreeColor;
            
            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);
            redrawTitleSBT  = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            [headYiLouView addSubview:redrawTitleSBT];
            [redrawTitleSBT release];
            
            redrawSBT = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            [yiLouView addSubview:redrawSBT];
            [redrawSBT release];
            
            [chartFormatData release];
        }
        redrawTitleSBT.hidden = NO;
        redrawSBT.hidden = NO;
        [redrawSBT reduction];
        
    }else if (cztype == 6){
        if (!redrawTitleSLH) {
            ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:allArray lottoryType:KuaiSanSanLian kuaiSanType:1];
            chartFormatData.linesTitleArray = @[@"123",@"234",@"345",@"456"];
            chartFormatData.drawType = PurpleKSquare;
            chartFormatData.lineColor = NoLine;
            
            CGRect redrawFrame1 = CGRectMake(0, 0, 320, chartFormatData.issueHeight + 1);
            redrawTitleSLH = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
            [headYiLouView addSubview:redrawTitleSLH];
            [redrawTitleSLH release];
            
            redrawSLH = [[redrawView alloc] initWithFrame:yiLouView.bounds chartFormatData:chartFormatData];//和值
            [yiLouView addSubview:redrawSLH];
            [redrawSLH release];
            
            [chartFormatData release];
        }
        redrawTitleSLH.hidden = NO;
        redrawSLH.hidden = NO;
        [redrawSLH reduction];
    }
}

- (void)returnScrollViewContOffSet:(CGPoint)point{
    
    if (redrawEBT) {
        if (redrawEBT.hidden == NO) {
            ChartTitleScrollView * titleScrollview = (ChartTitleScrollView *)[redrawTitleEBT viewWithTag:1101];
            titleScrollview.contentOffset = CGPointMake(point.x, titleScrollview.contentOffset.y);
        }
    }
    
    if (redrawHZ) {
        if (redrawHZ.hidden == NO) {
            ChartTitleScrollView * titleScrollview = (ChartTitleScrollView *)[redrawTitleHZ viewWithTag:1101];
            titleScrollview.contentOffset = CGPointMake(point.x, titleScrollview.contentOffset.y);
        }
    }
    
    
    
}

- (void)returnTitleScrollViewContOffSet:(CGPoint)point{
    if (redrawEBT) {
        if (redrawEBT.hidden == NO) {
            ChartYiLouScrollView * redrawScrollview = (ChartYiLouScrollView *)[redrawEBT viewWithTag:1103];
            redrawScrollview.contentOffset = CGPointMake(point.x, redrawScrollview.contentOffset.y);
        }
    }
    
    if (redrawHZ) {
        if (redrawHZ.hidden == NO) {
            ChartYiLouScrollView * redrawScrollview = (ChartYiLouScrollView *)[redrawHZ viewWithTag:1103];
            redrawScrollview.contentOffset = CGPointMake(point.x, redrawScrollview.contentOffset.y);
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [super scrollViewDidScroll:scrollView];
    
    
}



- (void)runCharRequest{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    
    [httpRequest clearDelegatesAndCancel];

    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:YiLOU_COUNT issue:nil]];

    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
    [httpRequest setDidFailSelector:@selector(rebuyFail:)];
    [httpRequest startAsynchronous];
    
}

- (void)rebuyFail:(ASIHTTPRequest *)mrequest{
    
    self.showYiLou = NO;
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}


- (void)allView:(NSMutableArray *)chartDataArray{
    if (yiLouView) {
        //        redrawView * redraw = [[redrawView alloc] initWithFrame:yiLouView.bounds type:ElevenBasic allArray:chartDataArray];
        //        [yiLouView addSubview:redraw];
        //        [redraw release];
        if ([titleLabel.text length] > 0) {
            NSArray * titleArray = [titleLabel.text componentsSeparatedByString:@" "];
            if ([titleArray count] > 0) {
                if ([[titleArray objectAtIndex:0] isEqualToString:@"和值"]) {//
                    
                    [self renXuanYiLouFunc:chartDataArray type:1];
                    
                }else if ([[titleArray objectAtIndex:0] isEqualToString:@"三同号单选"] || [[titleArray objectAtIndex:0] isEqualToString:@"三同号通选"]){//
                    
                    [self renXuanYiLouFunc:chartDataArray type:2];
                    
                }else if ([[titleArray objectAtIndex:0] isEqualToString:@"二同号单选"] || [[titleArray objectAtIndex:0] isEqualToString:@"二同号复选"]){//
                    [self renXuanYiLouFunc:chartDataArray type:3];
                    
                }else if ([[titleArray objectAtIndex:0] isEqualToString:@"二不同号"] || [[titleArray objectAtIndex:0] isEqualToString:@"二不同号胆拖"]){//
                    
                    [self renXuanYiLouFunc:chartDataArray type:4];
                    
                }else if ([[titleArray objectAtIndex:0] isEqualToString:@"三不同号"] || [[titleArray objectAtIndex:0] isEqualToString:@"三不同号胆拖"]){//
                    
                    [self renXuanYiLouFunc:chartDataArray type:5];
                    
                }else if ([[titleArray objectAtIndex:0] isEqualToString:@"三连号通选"]){//
                    
                    [self renXuanYiLouFunc:chartDataArray type:6];
                    
                }
            }
           

        }
        
        
        
    }
    
    
}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest *)request {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
	NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [[responseStr JSONValue] valueForKey:@"list"];
        NSMutableArray * chartDataArray = [[[NSMutableArray alloc] init] autorelease];
        for (int i = (int)array.count - 1; i >= 0; i--) {
            YiLouChartData * chartData = [[YiLouChartData alloc] initWithKuaiSanDictionary:[array objectAtIndex:i]];
            [chartDataArray addObject:chartData];
            [chartData release];
        }
        if ([array count] == 0){
            self.showYiLou = NO;
        }else{
            self.yiLouDataArray = chartDataArray;
            [self allView:chartDataArray];
        }
        
    }else{
        self.showYiLou = NO;
    }
    //[issuestring substringWithRange:NSMakeRange([issuestring length]-4, 4)];
    
    
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
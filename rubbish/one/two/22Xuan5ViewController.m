//
//  22Xuan5ViewController.m
//  caibo
//
//  Created by yaofuyu on 12-9-18.
//
//

#import "22Xuan5ViewController.h"
#import "Info.h"
#import "GCBallView.h"
#import "ShakeView.h"
#import "GC_LotteryUtil.h"
#import "Xieyi365ViewController.h"
#import "caiboAppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GC_IssueInfo.h"
#import "ColorView.h"
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "MobClick.h"

@interface _22Xuan5ViewController ()

@end

@implementation _22Xuan5ViewController

@synthesize selectNumber,item;
@synthesize isHeMai;
@synthesize myHttpRequest;
@synthesize myissueRecord;
@synthesize wangQi;
@synthesize qihaoReQuest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isBackScrollView = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
}

- (void)LoadIphoneView {
    //摇一注
    UIImageView *yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame =CGRectMake(20, 40, 15, 15);
    [self.mainView addSubview:yaoImage];
    [yaoImage release];
    
    //单注奖金提示
    UILabel *sqkaijiang21 = [[UILabel alloc] initWithFrame:CGRectMake(42, 45, 48, 11)];
    sqkaijiang21.textAlignment = NSTextAlignmentLeft;
    sqkaijiang21.backgroundColor = [UIColor clearColor];
    sqkaijiang21.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang21.text = @"单注奖金";
    sqkaijiang21.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang21];
    [sqkaijiang21 release];
    UILabel *sqkaijiang211 = [[UILabel alloc] initWithFrame:CGRectMake(83, 43, 48, 13)];
    sqkaijiang211.textAlignment = NSTextAlignmentLeft;
    sqkaijiang211.backgroundColor = [UIColor clearColor];
    sqkaijiang211.font = [UIFont boldSystemFontOfSize:12];
    sqkaijiang211.text = @"500万";
    sqkaijiang211.textColor = [UIColor redColor];
    [self.mainView addSubview:sqkaijiang211];
    [sqkaijiang211 release];
    UILabel *sqkaijiang2111 = [[UILabel alloc] initWithFrame:CGRectMake(119, 45, 48, 11)];
    sqkaijiang2111.textAlignment = NSTextAlignmentLeft;
    sqkaijiang2111.backgroundColor = [UIColor clearColor];
    sqkaijiang2111.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang2111.text = @"元";
    sqkaijiang2111.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang2111];
    [sqkaijiang2111 release];
    
    
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 10, 170, 47)];
	[self.mainView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
	[image1BackView release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
    [image1BackView addSubview:imageV];
    [imageV release];
    
    //上期开奖
    UILabel *sqkaijiang2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 19, 48, 11)];
    sqkaijiang2.textAlignment = NSTextAlignmentLeft;
    sqkaijiang2.backgroundColor = [UIColor clearColor];
    sqkaijiang2.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang2.text = @"上期开奖";
    sqkaijiang2.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang2];
    [sqkaijiang2 release];
    
    sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(200, 18, 135, 12)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont boldSystemFontOfSize:11];
    sqkaijiang.textColor = [UIColor redColor];
    if (self.myissueRecord) {
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if ([array count] > 1) {
            sqkaijiang.text = [[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
    }
    [self.mainView addSubview:sqkaijiang];
    [sqkaijiang release];
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    [image1BackView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont boldSystemFontOfSize:9];
    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 <%@>",self.myissueRecord.curEndTime];
    }
    [endTimelable release];
    
    //红球背景
    UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
    backImageV2.frame = CGRectMake(10, 37 + 30, 300.5, 202.5);
    backImageV2.userInteractionEnabled = YES;
    [self.mainView addSubview:backImageV2];
    [backImageV2 release];
    UILabel *hqlabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 20, 20, 16)];
    hqlabel.backgroundColor = [UIColor clearColor];
    hqlabel.text = @"红";
    hqlabel.textColor = [UIColor whiteColor];
    hqlabel.font = [UIFont boldSystemFontOfSize:15];
    hqlabel.shadowColor = [UIColor blackColor];
    hqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [backImageV2 addSubview:hqlabel];
    [hqlabel release];
    UILabel *hqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
    hqlabel2.backgroundColor = [UIColor clearColor];
    hqlabel2.text = @"球";
    hqlabel2.textColor = [UIColor whiteColor];
    hqlabel2.font = [UIFont boldSystemFontOfSize:15];
    hqlabel2.shadowColor = [UIColor blackColor];
    hqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [backImageV2 addSubview:hqlabel2];
    [hqlabel2 release];
    UILabel *hqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
    hqlabel3.backgroundColor = [UIColor clearColor];
    hqlabel3.text = @"⑤";
    hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
    hqlabel3.font = [UIFont boldSystemFontOfSize:16];
    [backImageV2 addSubview:hqlabel3];
    [hqlabel3 release];
    
	UIView *redView = [[UIView alloc] init];
	redView.tag = 1010;
	redView.backgroundColor = [UIColor clearColor];
	redView.frame = CGRectMake(36, 10, 265, 190);
	for (int i = 0; i<22; i++) {
		int a= i/7,b = i%7;
		NSString *num = [NSString stringWithFormat:@"%d",i+1];
		if (i+1<10) {
			num = [NSString stringWithFormat:@"0%d",i+1];
		}
		
		GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37, a*37, 35, 36) Num:num ColorType:GCBallViewColorRed];
		[redView addSubview:im];
        im.isBlack = YES;
		im.tag = i;
		im.gcballDelegate = self;
		[im release];
	}
	[backImageV2 addSubview:redView];
	[redView release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -44, 320, 44)];
	[self.mainView addSubview:im];
    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	im.userInteractionEnabled = YES;
    
    //清按钮
    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 10, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 10, 62, 30)];
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
	senBtn.frame = CGRectMake(230, 7, 80, 33);
    [im addSubview:senBtn];
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [senBtn addSubview:senImage];
    [senImage release];
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.font = [UIFont systemFontOfSize:15];
    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
    senLabel.tag = 1101;
    [senBtn addSubview:senLabel];
    [senLabel release];
    [im release];
}

- (void)LoadIpadView {
    //摇一注
    UIImageView *yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame =CGRectMake(20 + 35, 42, 15, 15);
    [self.mainView addSubview:yaoImage];
    [yaoImage release];
    
    //单注奖金提示
    UILabel *sqkaijiang21 = [[UILabel alloc] initWithFrame:CGRectMake(42 + 35, 45, 48, 11)];
    sqkaijiang21.textAlignment = NSTextAlignmentLeft;
    sqkaijiang21.backgroundColor = [UIColor clearColor];
    sqkaijiang21.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang21.text = @"单注奖金";
    sqkaijiang21.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang21];
    [sqkaijiang21 release];
    UILabel *sqkaijiang211 = [[UILabel alloc] initWithFrame:CGRectMake(83 + 35, 43, 48, 13)];
    sqkaijiang211.textAlignment = NSTextAlignmentLeft;
    sqkaijiang211.backgroundColor = [UIColor clearColor];
    sqkaijiang211.font = [UIFont boldSystemFontOfSize:12];
    sqkaijiang211.text = @"500万";
    sqkaijiang211.textColor = [UIColor redColor];
    [self.mainView addSubview:sqkaijiang211];
    [sqkaijiang211 release];
    UILabel *sqkaijiang2111 = [[UILabel alloc] initWithFrame:CGRectMake(119 + 35, 45, 48, 11)];
    sqkaijiang2111.textAlignment = NSTextAlignmentLeft;
    sqkaijiang2111.backgroundColor = [UIColor clearColor];
    sqkaijiang2111.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang2111.text = @"元";
    sqkaijiang2111.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang2111];
    [sqkaijiang2111 release];
    
    
    
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(140 + 35, 10, 170, 47)];
	[self.mainView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
	[image1BackView release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
    [image1BackView addSubview:imageV];
    [imageV release];
    
    //上期开奖
    UILabel *sqkaijiang2 = [[UILabel alloc] initWithFrame:CGRectMake(160 + 35, 19, 48, 11)];
    sqkaijiang2.textAlignment = NSTextAlignmentLeft;
    sqkaijiang2.backgroundColor = [UIColor clearColor];
    sqkaijiang2.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang2.text = @"上期开奖";
    sqkaijiang2.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang2];
    [sqkaijiang2 release];
    
    sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(200 +35, 18, 135, 12)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont boldSystemFontOfSize:11];
    sqkaijiang.textColor = [UIColor redColor];
    if (self.myissueRecord) {
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if ([array count] > 1) {
            sqkaijiang.text = [[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
    }
    [self.mainView addSubview:sqkaijiang];
    [sqkaijiang release];
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    [image1BackView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont boldSystemFontOfSize:9];
    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 <%@>",self.myissueRecord.curEndTime];
    }
    [endTimelable release];
    
    //红球背景
    UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
    backImageV2.frame = CGRectMake(10 + 35, 37 + 30, 300.5, 202.5);
    backImageV2.userInteractionEnabled = YES;
    [self.mainView addSubview:backImageV2];
    [backImageV2 release];
    UILabel *hqlabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 20, 20, 16)];
    hqlabel.backgroundColor = [UIColor clearColor];
    hqlabel.text = @"红";
    hqlabel.textColor = [UIColor whiteColor];
    hqlabel.font = [UIFont boldSystemFontOfSize:15];
    hqlabel.shadowColor = [UIColor blackColor];
    hqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [backImageV2 addSubview:hqlabel];
    [hqlabel release];
    UILabel *hqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
    hqlabel2.backgroundColor = [UIColor clearColor];
    hqlabel2.text = @"球";
    hqlabel2.textColor = [UIColor whiteColor];
    hqlabel2.font = [UIFont boldSystemFontOfSize:15];
    hqlabel2.shadowColor = [UIColor blackColor];
    hqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [backImageV2 addSubview:hqlabel2];
    [hqlabel2 release];
    UILabel *hqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
    hqlabel3.backgroundColor = [UIColor clearColor];
    hqlabel3.text = @"⑤";
    hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
    hqlabel3.font = [UIFont boldSystemFontOfSize:16];
    [backImageV2 addSubview:hqlabel3];
    [hqlabel3 release];
    
	UIView *redView = [[UIView alloc] init];
	redView.tag = 1010;
	redView.backgroundColor = [UIColor clearColor];
	redView.frame = CGRectMake(36, 10, 265, 190);
	for (int i = 0; i<22; i++) {
		int a= i/7,b = i%7;
		NSString *num = [NSString stringWithFormat:@"%d",i+1];
		if (i+1<10) {
			num = [NSString stringWithFormat:@"0%d",i+1];
		}
		
		GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37, a*37, 35, 36) Num:num ColorType:GCBallViewColorRed];
		[redView addSubview:im];
        im.isBlack = YES;
		im.tag = i;
		im.gcballDelegate = self;
		[im release];
	}
	[backImageV2 addSubview:redView];
	[redView release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
	
    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	im.userInteractionEnabled = YES;
    
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
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [senBtn addSubview:senImage];
    [senImage release];
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.font = [UIFont systemFontOfSize:15];
    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
    senLabel.tag = 1101;
    [senBtn addSubview:senLabel];
    [senLabel release];
    [im release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	
    UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    if (self.myissueRecord) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 270, 44)];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.userInteractionEnabled = YES;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 180, 34)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"22选5-%@期",self.myissueRecord.curIssue];
        [titleView addSubview:titleLabel];
        [titleLabel release];
        self.CP_navigation.titleView = titleView;
        [titleView release];
        
    }
    else {
        self.CP_navigation.title = @"22选5";
    }


        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, 60, 44);
            [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
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

	if (!self.myissueRecord) {
		NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:@"111"];
		[myHttpRequest clearDelegatesAndCancel];
		self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
		[myHttpRequest setRequestMethod:@"POST"];
		[myHttpRequest addCommHeaders];
		[myHttpRequest setPostBody:postData];
		[myHttpRequest setDidFinishSelector:@selector(requestShuZiFinished:)];
		[myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[myHttpRequest setDelegate:self];
		[myHttpRequest startAsynchronous];
	}
    [self getWanqi];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    self.selectNumber = nil;
    self.myissueRecord = nil;
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    self.item = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.wangQi = nil;
    NSLog(@"dealloc");
    [super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
		isHeMai = NO;
	}
	return self;
}

#pragma mark -
#pragma mark View action

- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)clearBalls {
	UIView *redView = [self.mainView viewWithTag:1010];
	for (GCBallView *ball in redView.subviews) {
		if ([ball isKindOfClass:[GCBallView class]]) {
			ball.selected = NO;
		}
	}
    [self ballSelectChange:nil];
}

- (void)randBalls {
	NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:22];
	UIView *redView = [self.mainView viewWithTag:1010];
	for (GCBallView *ball in redView.subviews) {
		if ([ball isKindOfClass:[GCBallView class]]) {
			if ([redBalls containsObject:ball.numLabel.text]) {
				ball.selected = YES;
			}
			else {
				ball.selected = NO;
			}
		}
	}
	[self ballSelectChange:nil];
}

- (void)upLoadZhuShu {
	//NSUInteger bets = [GC_LotteryUtil getBets:self.selectNumber LotteryType:lotteryType ModeType:modeType];
}

- (NSString *)seletNumber {
    NSString *number_s = @"*";
    
    NSMutableString *_selectNumber = [NSMutableString string];
    for (int i = 0; i < 1; i++) {
        UIView *ballsCon = [self.mainView viewWithTag:1010+i];
        NSMutableString *num = [NSMutableString string];
        for (GCBallView *ballV in ballsCon.subviews) {
            if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                [num appendString:ballV.numLabel.text];
                [num appendString:number_s];
            }
        }
        if ([num length] == 0) {
            [num appendString:@"e"];
        }
        else {
            NSRange rang;
            rang.length = 1;
            rang.location = [num length] -1;
            [num deleteCharactersInRange:rang];
        }
        
        [_selectNumber appendString:num];
    }
    
    return [_selectNumber length] > 0 ? _selectNumber : nil;
}


//玩法介绍
- (void)wanfaInfo {
	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = ErErXuan5;
    [self.navigationController pushViewController:xie animated:YES];
	[xie release];
//	xie.infoText.text = @"1. 购买“22选5”时,由购买者从01—22共22个号 码中选取5个号码为一注进行投注的彩票为单式票。\n2. 选取6个以上号码(含6个),组合成多注彩票 为复式票。\n3. “22选5”设3个奖级,其中一等奖为浮动奖, 为当期奖金额减去固定奖总额后的100%,及奖 池和调节基金转入部分,中奖奖金最高限额500 万元。其余为固定奖。二等奖单注固定奖金为 50元。三等奖单注固定奖金为5元。";
	
	
    //	GC_ExplainViewController *ex = [[GC_ExplainViewController alloc] init];
    //	ex.title = @"双色球玩法介绍";
    //	[self.navigationController pushViewController:ex animated:YES];
    //	[ex release];
}


// 投注
- (void)send {
    
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([labe.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
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
    UIView *Rview = [self.mainView viewWithTag:1010];
    int c0 = 0;
    for (GCBallView *bt in Rview.subviews) {
        if ([bt isKindOfClass:[GCBallView class]]) {
            if (bt.selected == YES) {
                c0++;
            }
        }
        
    }
    if (c0 < 5) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"至少选择5个号码"];
        return;
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        NSString *selet = [self seletNumber];
        if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoV.dataArray count] >=50) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                [alert show];
                alert.tag = 201;
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
            infoViewController.isHeMai = self.isHeMai;
            infoViewController.betInfo.issue = self.myissueRecord.curIssue;
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoType22Xuan5;
            infoViewController.lotteryType = TYPE_22XUAN5;
            infoViewController.modeType = fushi;
        }
        NSString *selet = [self seletNumber];
        if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoViewController.dataArray count] >=50) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                [alert show];
                alert.tag = 201;
                [alert release];
                return;
            }
            [infoViewController.dataArray addObject:selet];
        }
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
	
	[self clearBalls];
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [self randBalls];
    }
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
	[super motionEnded:motion withEvent:event];
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
    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"GC_sanjilishi.png"];
//    [allimage addObject:@"menuhmdt.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"历史开奖"];
//    [alltitle addObject:@"合买大厅"];
    [alltitle addObject:@"玩法说明"];
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, self.view.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
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
        [self performSelector:@selector(pressKaiJiangTuiSong:)];
    }
//    else if (index == 1) {
//        [MobClick event:@"event_goumai_shuzicai_22xuan5_hmdt"];
//        [self otherLottoryViewController:0 title:@"22选5合买" lotteryType:TYPE_22XUAN5 lotteryId:@"111"];
//    }
    else if (index == 1) {
        [self wanfaInfo];
    }
    
    
}

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
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
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

//历史开奖
- (void)pressKaiJiangTuiSong:(UIButton *)sender{
    
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    controller.lotteryId = @"111";
    controller.lotteryName = @"22选5";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)getWanqi {    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:@"111" countOfPage:20];
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

#pragma mark -
#pragma mark GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
	int bets = (int)[GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_22XUAN5 ModeType:fushi];
	NSLog(@"%@,%d",[self seletNumber],bets);
	if (bets < 1) {
		senBtn.enabled = NO;
	}
	else {
		senBtn.enabled = YES;
	}
    
	zhushuLabel.text = [NSString stringWithFormat:@"%d",bets];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*bets];
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    NSString *str = [[[self seletNumber] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"*" withString:@""];
    if ([str length] == 0) {
        labe.text = @"机选";
        labe.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
        senBtn.enabled = YES;
    }
    else {
        labe.text = @"选好了";
        labe.textColor = [UIColor blackColor];
        senBtn.enabled = YES;
    }

}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request];
		self.wangQi = wang;
        [_cpTableView reloadData];
        [wang release];
	}
}

- (void) requestShuZiFinished:(ASIHTTPRequest *)request {
	if ([request responseData]) {
		IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        self.item = issrecord.curIssue;
        self.myissueRecord = issrecord;
        self.myissueRecord = issrecord;
        
        self.CP_navigation.title = [NSString stringWithFormat:@"22选5-%@期",issrecord.curIssue];
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if ([array count] > 1) {
            sqkaijiang.text = [[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        else {
            sqkaijiang.text = [self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        endTimelable.text = [NSString stringWithFormat:@"截止时间 <%@>",self.myissueRecord.curEndTime];
        [issrecord release];
	}
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _cpTableView) {
        UIView *v = [[[UIView alloc] init] autorelease];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
        label1.text = @"期号";
        label1.font = [UIFont boldSystemFontOfSize:14];
        label1.textColor = [UIColor whiteColor];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [v addSubview:label1];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 180, 20)];
        label2.text = @"历史开奖";
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont boldSystemFontOfSize:14];
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentCenter;
        [v addSubview:label2];
        [label2 release];
        v.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
        [v addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
        [line release];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 34 , 260, 1)];
        [v addSubview:line2];
        line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
        [line2 release];
        return v;
    }
    return nil;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _cpTableView) {
        return 35;
    }
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.wangQi.brInforArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _cpTableView) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
            label1.font = [UIFont systemFontOfSize:13];
            label1.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
            label1.tag = 101;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label1];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 35)];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = [UIColor whiteColor];
            label2.tag = 102;
            label2.backgroundColor = [UIColor colorWithRed:67/255.0 green:144/255.0 blue:186/255.0 alpha:1.0];
            [cell.contentView addSubview:label2];
            label2.textAlignment = NSTextAlignmentCenter;
            [label2 release];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
            [cell.contentView addSubview:line];
            line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
            [line release];
            
            UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 260, 1)];
            [cell.contentView addSubview:line2];
            line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
            [line2 release];
            cell.contentView.backgroundColor = [UIColor clearColor];
            
        }
        
        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
        KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
        l1.text = info.issue;
        l2.text = info.num;
        return  cell;
        
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 33)];
        label1.font = [UIFont systemFontOfSize:13];
        label1.backgroundColor = [UIColor clearColor];
        label1.tag = 101;
        [cell.contentView addSubview:label1];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 100, 33)];
        label2.font = [UIFont systemFontOfSize:13];
        label2.textColor = [UIColor redColor];
        label2.tag = 102;
        label2.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label2];
        label2.textAlignment = NSTextAlignmentCenter;
        [label2 release];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(1, 33, 254, 2)];
        imageV.image = UIImageGetImageFromName(@"SZTG960.png");
        [cell.contentView addSubview:imageV];
        cell.backgroundColor = [UIColor clearColor];
        [imageV release];
        
	}
    UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
    KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
    l1.text = info.issue;
    l2.text = info.num;
    return  cell;
}

@end

//hello world

//hello world

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;


int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;


int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

 X8
int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

 X8
int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

 X:
int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

 X=
int abcd,defege;
int aaff,aiefe=0;
Mod
int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
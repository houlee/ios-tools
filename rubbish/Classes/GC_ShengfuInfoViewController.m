//
//  GC_ShengfuInfoViewController.m
//  caibo
//
//  Created by  on 12-5-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_ShengfuInfoViewController.h"
#import "GC_BetData.h"
#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "Info.h"
#import "GC_BetData.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "GCHeMaiSendViewController.h"
#import "AoyunJiexi.h"
#import "GCJCBetViewController.h"
#import "GCBettingViewController.h"
#import "GC_BJDanChangViewController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "ChongZhiData.h"
#import "JiangJinYouhuaViewController.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "PassWordView.h"
#import "LoginViewController.h"
#import "CP_TouZhuAlert.h"
#import "GC_JingCaiCell.h"
#import "SharedMethod.h"
#import "GC_FangChenMiParse.h"
#import "MobClick.h"


@implementation GC_ShengfuInfoViewController
@synthesize bettingArray, matchId, onePlayingBool, oneDoubleBool, oneSPFCount;
@synthesize moneynum;
@synthesize zhushu;
@synthesize httpRequest;
@synthesize betInfo;
@synthesize httpReq;
@synthesize accountManage;
@synthesize jingcai;
@synthesize dataRequest;
@synthesize urlstring;
@synthesize zhushudict;
@synthesize fenzhong;
@synthesize danfushi;
@synthesize maxmoneystr;
@synthesize minmoneystr;
@synthesize isHeMai;
@synthesize hemaibool, chaodanbool;
@synthesize beidanbool;
@synthesize issString, saveKey;
@synthesize BetDetailInfo, qihaostring, bianjibool, systimestr,youhuaBool, youhuaZhichi,passWord,isxianshiyouhuaBtn;//danguanbool;
@synthesize championData;
@synthesize buyResult;
@synthesize beitouNumber;

- (void)lastMatchId{
    //    NSInteger lastObjectCount = 0;
    if ([dataAr count] > 0) {
        //        lastObjectCount = [dataAr count] - 1;
        GC_shengfudata * be =[dataAr objectAtIndex:[dataAr count]-1];
        betInfo.lastMatch = be.changci;
    }else{
        betInfo.lastMatch = @"";
    }
}

- (void)resetPassWord{
    
    BOOL pwInfoBool = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    
                    pwInfoBool = YES;
                    
                    break;
                }
                
            }
            
        }
        
    }
    
    if (pwInfoBool) {
        TestViewController * test = [[TestViewController alloc] init];
        
        //                UIViewController * con = [viewController.navigationController.viewControllers objectAtIndex:[viewController.navigationController.viewControllers cou]];
        //
        [self.navigationController pushViewController:test animated:YES];
        [test release];
    }else{
        PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
        [self.navigationController pushViewController:pwinfo animated:YES];
        [pwinfo release];
        
    }
}
- (void)sleepPassWordViewShow{
    caiboAppDelegate * cai = [caiboAppDelegate getAppDelegate];
    PassWordView * pwv = [[PassWordView alloc] init];
    pwv.alpha = 0;
    //    pwv.viewController = self;
    [cai.window addSubview:pwv];
    [pwv release];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    pwv.alpha = 1;
    [UIView commitAnimations];
}

- (void)youHuaFrameSizeFunc{
    
    if (isxianshiyouhuaBtn) {
        tvbg.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height-180-15);
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-180-15-30);
        downbgImageView.frame = CGRectMake(0, self.mainView.frame.size.height-180, 320, 180);
        yhButton.frame = CGRectMake(10,95, 300, 27);
        xieyiView.frame = CGRectMake(0, self.mainView.frame.size.height-180-30, 320, 30);
        
    }
    else
    {
        tvbg.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height-140-15);
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-140-15-30);
        downbgImageView.frame = CGRectMake(0, self.mainView.frame.size.height-140, 320, 140);
        xieyiView.frame = CGRectMake(0, self.mainView.frame.size.height-140-30, 320, 30);
    }
    
}

- (void)pressYouHuaButton:(UIButton *)sender{//奖金优化
    [self passTypeSetAndchosedGameSet];
    if (fenzhong == jingcaihuntouerxuanyi) {
        if (rightBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"投注异常,请重新投注"]];
            return;
        }
    }
    if (self.betInfo.payMoney > 1500000) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过150万"];
        return;
    }
    if (!youhuaZhichi) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"赛果选择不能超过12个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    [MobClick event:@"event_goucai_touzhu_jiangliyouhua" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
    JiangJinYouhuaViewController *yh = [[JiangJinYouhuaViewController alloc] init];
    yh.isCanBack = !chaodanbool;
    yh.caizhong = fenzhong;
    if ([beitou.text intValue] < 1) {
        betInfo.prices = betInfo.price * 1;
        betInfo.payMoney = betInfo.prices * 1;
        betInfo.beishu = 1;
    }
    else
    {
        if([beitou.text intValue] > 29999){
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多一次只能投29999倍"];
            betInfo.prices = betInfo.price * 29999;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 29999;
            [yh release];
            return;
        }
        else {
            betInfo.prices = betInfo.price * [beitou.text intValue];
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = [beitou.text intValue];
        }
    }
    yh.minMoney = betInfo.price;
    yh.mybetInfo = betInfo;
    [self.navigationController pushViewController:yh animated:YES];
    [yh release];
    
}


- (id)initWithLotteryID:(Caifenzhong)caizhong {
    self = [super init];
    if (self) {
        fenzhong = caizhong;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBetInfo:(GC_BetInfo *)_betInfo
{
    if (self = [super init]) {
        self.betInfo = _betInfo;
        isHeMai = NO;
        NSLog(@"%@", _betInfo.betNumber);
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
- (void)gotohome{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)xieyi
{
    Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Xieyi;
    xie.title = @"同城用户服务协议";
    [self.navigationController pushViewController:xie animated:YES];
    [xie release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    baomileixing = 0;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountInfoRequest) name:@"BecomeActive" object:nil];
    
    NSString *caizhong = @"";
    
    
    if (fenzhong == shisichangpiao) {
        caizhong = @"胜负彩";
    }else if(fenzhong == renjiupiao){
        caizhong = @"任选九";
    }else if(fenzhong == beijingdanchang || fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang || fenzhong == beidanshengfuguoguan ){
        caizhong = @"单场";
        betInfo.issue = issString;
    }else if(fenzhong == jingcailanqiushengfu||fenzhong == jingcailanqiudaxiaofen || fenzhong ==jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha || fenzhong == lanqiuhuntou){
        caizhong = @"竞彩篮球";
    }else if (fenzhong == guanjunwanfa){
        caizhong = @"世界杯冠军";
    }else if (fenzhong == guanyajunwanfa){
        caizhong = @"世界杯冠亚军";
    } else{
        caizhong = @"竞彩足球";
    }
    
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
#ifdef isCaiPiaoForIPad
    titleV.frame = CGRectMake(95, 0, 260, 44);
#endif
    self.CP_navigation.titleView = titleV;
    titleV.backgroundColor = [UIColor clearColor];
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.backgroundColor = [UIColor clearColor];
    nameLable.text = caizhong;
    nameLable.textColor = [UIColor whiteColor];
    
    nameLable.font = [UIFont systemFontOfSize:20];
    [titleV addSubview:nameLable];
    nameLable.frame = CGRectMake(0, 11, 130, 22);
    nameLable.textAlignment = NSTextAlignmentRight;
    
    UILabel *issLabel = [[UILabel alloc] init];
    issLabel.backgroundColor = [UIColor clearColor];
    // if(fenzhong == beijingdanchang){
    issLabel.text = [NSString stringWithFormat:@"%@期",issString];
    issLabel.textColor = [UIColor whiteColor];
    
    
    issLabel.font = [UIFont systemFontOfSize:13];
    issLabel.frame = CGRectMake(132, 18, 100, 15);
    [titleV addSubview:issLabel];
    [issLabel release];
    [nameLable release];
    [titleV release];
    
    if (fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa){
        titleV.frame = CGRectMake(80, 0, 260, 40);
        issLabel.text = @"";
    }
    
    if (chaodanbool) {
        
        UIButton * btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
        [btnwan addSubview:imagevi];
        [imagevi release];
        
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
        lilable.font = [UIFont boldSystemFontOfSize:14];
        //        lilable.shadowColor = [UIColor blackColor];//阴影
        //        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"编辑";
        lilable.tag = 10;
        [btnwan addSubview:lilable];
        [lilable release];
        [btnwan addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnwan];
        self.CP_navigation.leftBarButtonItem = barBtnItem;
        [barBtnItem release];
        
        
        UIBarButtonItem * rightItem = [Info homeItemTarget:self action:@selector(gotohome)];
        [self.CP_navigation setRightBarButtonItem:(rightItem)];
        
        if (fenzhong == shisichangpiao) {
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-30, 11, 130, 22);
            issLabel.frame = CGRectMake(102, 18, 100, 15);
        }else if(fenzhong == renjiupiao){
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-30, 11, 130, 22);
            issLabel.frame = CGRectMake(102, 18, 100, 15);
        }else if(fenzhong == beijingdanchang || fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang || fenzhong == beidanshengfuguoguan){
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-30, 11, 130, 22);
            issLabel.frame = CGRectMake(102, 18, 100, 15);
        }else if(fenzhong == jingcailanqiushengfu||fenzhong == jingcailanqiudaxiaofen || fenzhong ==jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha){
            issLabel.hidden = YES;
            nameLable.frame = CGRectMake(0, 11, 130, 22);
        }else{
            issLabel.hidden = YES;
            nameLable.frame = CGRectMake(0, 11, 130, 22);
        }
        
        
    }else{
        
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
        
        if (fenzhong == shisichangpiao) {
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-40, 11, 130, 22);
            issLabel.frame = CGRectMake(92, 18, 100, 15);
        }else if(fenzhong == renjiupiao){
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-40, 11, 130, 22);
            issLabel.frame = CGRectMake(92, 18, 100, 15);
        }else if(fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan){
            issLabel.hidden = NO;
            nameLable.frame = CGRectMake(-40, 11, 130, 22);
            issLabel.frame = CGRectMake(92, 18, 100, 15);
        }else if(fenzhong == jingcailanqiushengfu||fenzhong == jingcailanqiudaxiaofen || fenzhong ==jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha || fenzhong == lanqiuhuntou){
            issLabel.hidden = YES;
            nameLable.frame = CGRectMake(0, 11, 130, 22);
        }else{
            issLabel.hidden = YES;
            nameLable.frame = CGRectMake(0, 11, 130, 22);
        }
        
    }
    
    
    
    betInfo.baomiType = BaoMiTypeGongKai;
    
    
    
    
    NSLog(@"%@", bettingArray);
    
    dataAr = [[NSMutableArray alloc] initWithCapacity:0];
    
    tvbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, self.mainView.frame.size.height-180-10)];
    tvbg.backgroundColor = [UIColor clearColor];
    tvbg.userInteractionEnabled = YES;
    [tvbg.layer setMasksToBounds:YES];
    [self.mainView addSubview:tvbg];
    [tvbg release];
    
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height-180-10-30)];
    // myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.bounces = NO;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tvbg addSubview:myTableView];
    
    xieyiView = [[UIView alloc]init];
    xieyiView.frame = CGRectMake(0, self.mainView.frame.size.height-180-30, 320, 30);
    xieyiView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:xieyiView];
    [xieyiView release];
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 30)] ;
    agreeLabel.text = @"    《同城用户服务协议》";
    agreeLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    agreeLabel.backgroundColor = [UIColor clearColor];
    //    agreeLabel.textAlignment = NSTextAlignmentRight;
    agreeLabel.font = [UIFont systemFontOfSize:18];
    agreeLabel.userInteractionEnabled = YES;
    [xieyiView addSubview:agreeLabel];
    [agreeLabel release];
    
    UIButton *agreeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn1.frame = CGRectMake(0, 0, 200, 30);
    [agreeBtn1 addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn1.backgroundColor = [UIColor clearColor];
    [agreeLabel addSubview:agreeBtn1];
    
    UIImageView *agreeIma = [[UIImageView alloc]init];
    agreeIma.frame = CGRectMake(0, 7, 16, 16);
    agreeIma.backgroundColor = [UIColor clearColor];
    agreeIma.image = [UIImage imageNamed:@"zhuce-tongyixiyikuang_1.png"];
    [agreeLabel addSubview:agreeIma];
    [agreeIma release];
    
    UIImageView *rightIma = [[UIImageView alloc]init];
    rightIma.frame = agreeIma.bounds;
    rightIma.backgroundColor = [UIColor clearColor];
    rightIma.image = [UIImage imageNamed:@"zhuce-tongyixieyi_1.png"];
    [agreeIma addSubview:rightIma];
    [rightIma release];
    
    
    
    //    middleView.frame = CGRectMake(0, ORIGIN_Y(myTableView), 320, 100);
    
    downbgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height-180, 320, 180)];
    downbgImageView.backgroundColor = [UIColor whiteColor];
    downbgImageView.userInteractionEnabled = YES;
    [self.mainView addSubview:downbgImageView];
    [downbgImageView release];
    
    UIImageView *upupXian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upupXian.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [downbgImageView addSubview:upupXian];
    [upupXian release];
    
    upimagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
    upimagebg.userInteractionEnabled = YES;
    upimagebg.backgroundColor = [UIColor clearColor];
    [downbgImageView addSubview:upimagebg];
    [upimagebg release];
    
    
    UILabel * textlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 225, 70, 30)];
    textlabel.text = @"方案保密";
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.font = [UIFont systemFontOfSize:12];
    textlabel.backgroundColor = [UIColor clearColor];
    //    [self.mainView addSubview:textlabel];
    
    leftimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 18, 17)];
    // leftimage.image = UIImageGetImageFromName(@"login_right_0.png");
    leftimage.image = UIImageGetImageFromName(@"login_right.png");
    
    cuimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 18, 17)];
    cuimage.image = UIImageGetImageFromName(@"login_right_0.png");
    
    rigimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 18, 17)];
    rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    
    yinshenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 18, 17)];
    yinshenImage.image = UIImageGetImageFromName(@"login_right_0.png");
    
    buttonleft = [UIButton  buttonWithType:UIButtonTypeCustom];
    buttonleft.frame = CGRectMake(70, 225, 55, 30);
    [buttonleft addTarget:self action:@selector(pressgongkai:) forControlEvents:UIControlEventTouchUpInside];
    [buttonleft addSubview:leftimage];
    
    
    UILabel * gongkai = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 42, 30)];
    gongkai.text = @"公开";
    gongkai.textAlignment = NSTextAlignmentLeft;
    gongkai.backgroundColor = [UIColor clearColor];
    gongkai.font = [UIFont systemFontOfSize:12];
    //    [self.view addSubview:gongkai];
    //    [buttonleft addSubview:gongkai];
    [gongkai release];
    
    buttoncuston = [UIButton buttonWithType:UIButtonTypeCustom];
    buttoncuston.frame = CGRectMake(120, 225, 55, 30);
    [buttoncuston addTarget:self action:@selector(pressbomi:) forControlEvents:UIControlEventTouchUpInside];
    [buttoncuston addSubview:cuimage];
    
    UILabel * baomi = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 52, 30)];
    baomi.text = @"保密";
    baomi.textAlignment = NSTextAlignmentLeft;
    baomi.backgroundColor = [UIColor clearColor];
    baomi.font = [UIFont systemFontOfSize:12];
    //  [self.view addSubview:baomi];
    //    [buttoncuston addSubview:baomi];
    [baomi release];
    
    buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake(170, 225, 105, 30);
    [buttonright addTarget:self action:@selector(pressjiezhi:) forControlEvents:UIControlEventTouchUpInside];
    [buttonright addSubview:rigimage];
    
    UILabel * jiezhi = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 92, 30)];
    jiezhi.text = @"截止后公开";
    jiezhi.textAlignment = NSTextAlignmentLeft;
    jiezhi.backgroundColor = [UIColor clearColor];
    jiezhi.font = [UIFont systemFontOfSize:12];
    //  [self.view addSubview:jiezhi];
    //    [buttonright addSubview:jiezhi];
    [jiezhi release];
    
    buttonYinShen = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonYinShen.frame = CGRectMake(255, 225, 55, 30);
    [buttonYinShen addTarget:self action:@selector(pressinshen:) forControlEvents:UIControlEventTouchUpInside];
    [buttonYinShen addSubview:yinshenImage];
    
    UILabel * yinshen = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 92, 30)];
    yinshen.text = @"隐藏";
    yinshen.textAlignment = NSTextAlignmentLeft;
    yinshen.backgroundColor = [UIColor clearColor];
    yinshen.font = [UIFont systemFontOfSize:12];
    [yinshen release];
    
    
    [textlabel release];
    
    
    UIImageView * downimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -42, 320, 44)];
    downimage.backgroundColor = [UIColor blackColor];
    //    downimage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];//
    [self.mainView addSubview:downimage];
    // [customiamge release];
    [downimage release];
    
    
    
    
    
    //显示多少注
    mathname = [[UILabel alloc] initWithFrame:CGRectMake(20, 266, 250, 20)];
    mathname.textAlignment = NSTextAlignmentLeft;
    mathname.backgroundColor = [UIColor clearColor];
    mathname.font = [UIFont systemFontOfSize:12];
    mathname.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    //    [self.mainView addSubview:mathname];
    if (fenzhong == shisichangpiao) {
        mathname.text = [NSString stringWithFormat:@"%@注",zhushu];
        matchNameString = @"胜负彩十四场";
    }
    if (fenzhong == renjiupiao) {
        mathname.text = [NSString stringWithFormat:@"%@注",zhushu];
        matchNameString = @"任选九";
    }
    if (fenzhong == jingcaihuntouerxuanyi||fenzhong == jingcaihuntou||fenzhong == jingcairangfenshengfu||fenzhong == jingcaipiao || fenzhong == jingcaibifen || fenzhong == zongjinqiushu || fenzhong == banquanchangshengpingfu || fenzhong == jingcailanqiushengfu || fenzhong == jingcailanqiudaxiaofen || fenzhong == jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha ||fenzhong == shisichangpiao || fenzhong == renjiupiao || fenzhong == lanqiuhuntou|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa || fenzhong == jingcaidahuntou) {
        NSString * chuanstr = @"";
        if(fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
            chuanstr = @"单关";
        }else{
            NSArray * arr = [zhushudict allKeys];
            
            for (int i = 0; i < [arr count]; i++) {
                chuanstr = [NSString stringWithFormat:@"%@%@、", chuanstr, [arr objectAtIndex:i]];
            }
            if (fenzhong == shisichangpiao || fenzhong == renjiupiao) {
                
            }else{
                chuanstr = [chuanstr substringToIndex:[chuanstr length] - 1];
            }
            
        }
        
        
        if (fenzhong == jingcaihuntouerxuanyi||fenzhong == jingcaihuntou||fenzhong == jingcairangfenshengfu||fenzhong == jingcaipiao||fenzhong == jingcailanqiushengfu || fenzhong == jingcailanqiudaxiaofen || fenzhong == jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha || fenzhong == lanqiuhuntou|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa||fenzhong == jingcaidahuntou) {
            if (fenzhong == jingcailanqiushengfu || fenzhong == jingcailanqiudaxiaofen || fenzhong == jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha || fenzhong == shisichangpiao || fenzhong == renjiupiao || fenzhong == lanqiuhuntou ) {
                mathname.text = @"竞彩篮球 ";
                matchNameString = @"竞彩篮球 ";
            }else if(fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
                
                
                if (fenzhong == guanyajunwanfa) {
                    mathname.text = @"世界杯冠亚军";
                    matchNameString = @"世界杯冠亚军";
                }else if (fenzhong == guanjunwanfa){
                    mathname.text = @"世界杯冠军";
                    matchNameString = @"世界杯冠军";
                }
                
                
            }else{
                mathname.text = @"竞彩足球 ";
                matchNameString = @"竞彩足球 ";
            }
            
            CGSize maxsize = CGSizeMake(60, 20);
            CGSize expectedsize = [mathname.text sizeWithFont:mathname.font constrainedToSize:maxsize lineBreakMode:UILineBreakModeTailTruncation];
            mathname.frame = CGRectMake(20, 266, expectedsize.width, 20);
            
            //  mathname.text = [NSString stringWithFormat:@"竞彩足球胜平负, %@注. %@方案",zhushu, chuanstr];
            NSString * shengpingfustr = @"";
            
            if (fenzhong == jingcailanqiushengfu) {
                shengpingfustr = @"胜负, ";
            }else if(fenzhong == jingcailanqiurangfenshengfu){
                shengpingfustr = @"让分胜负, ";
            }else if(fenzhong == jingcailanqiushengfencha){
                shengpingfustr = @"胜分差, ";
            }else if(fenzhong == jingcailanqiudaxiaofen){
                shengpingfustr = @"大小分, ";
            }else if(fenzhong == lanqiuhuntou){
                
                shengpingfustr = @"混合过关, ";
            }else if (fenzhong == guanyajunwanfa) {
                shengpingfustr = @"世界杯冠亚军";
                
            }else if (fenzhong == guanjunwanfa){
                shengpingfustr = @"世界杯冠军";
                
            }else if(fenzhong == jingcaidahuntou){
                shengpingfustr = @"混合过关,";
            }else{
                shengpingfustr = @"胜平负, ";
            }
            
            
            
            
            
            UIFont * font2 = [UIFont systemFontOfSize:9];
            CGSize maxsize2 = CGSizeMake(60, 20);
            CGSize expectedsize2 = [shengpingfustr sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * shengpingla = [[UILabel alloc] initWithFrame:CGRectMake(20+mathname.frame.size.width, 268, expectedsize2.width, 20)];
            shengpingla.font = font2;
            shengpingla.backgroundColor = [UIColor clearColor];
            shengpingla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            shengpingla.textAlignment = NSTextAlignmentLeft;
            shengpingla.text = shengpingfustr;
            //            [self.mainView addSubview:shengpingla];
            [shengpingla release];
            
            
            //注数
            CGSize maxsize4 = CGSizeMake(200, 20);
            UIFont * font4 = [UIFont systemFontOfSize:18];
            CGSize expectedsize4 = [zhushu sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
            
            UILabel *zhuCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, expectedsize4.width, 20)];
            zhuCount.backgroundColor = [UIColor clearColor];
            zhuCount.font =font4;
            zhuCount.text = zhushu;
            zhuCount.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
            zhuCount.textAlignment = NSTextAlignmentLeft;
            [upimagebg addSubview:zhuCount];
            [zhuCount release];
            
            NSString * zhufangan = [NSString stringWithFormat:@"注 %@", chuanstr];
            //            CGSize maxsize3 = CGSizeMake(200, 20);
            UIFont * font3 = [UIFont systemFontOfSize:9];
            //            CGSize expectedsize3 = [zhufangan sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * zhufangla = [[UILabel  alloc] initWithFrame:CGRectMake(ORIGIN_X(zhuCount), 9, 190-ORIGIN_X(zhuCount), 20)];
            
            zhufangla.font = font3;
            zhufangla.backgroundColor = [UIColor clearColor];
            zhufangla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            zhufangla.textAlignment = NSTextAlignmentLeft;
            zhufangla.text = zhufangan;
            [upimagebg addSubview:zhufangla];
            [zhufangla release];
            
            
            
        }else if(fenzhong == jingcaibifen){
            mathname.text = @"竞彩足球 ";
            matchNameString = @"竞彩足球 ";
            CGSize maxsize = CGSizeMake(60, 20);
            CGSize expectedsize = [mathname.text sizeWithFont:mathname.font constrainedToSize:maxsize lineBreakMode:UILineBreakModeTailTruncation];
            mathname.frame = CGRectMake(20, 266, expectedsize.width, 20);
            
            //  mathname.text = [NSString stringWithFormat:@"竞彩足球胜平负, %@注. %@方案",zhushu, chuanstr];
            NSString * shengpingfustr = @"比分, ";
            UIFont * font2 = [UIFont systemFontOfSize:9];
            CGSize maxsize2 = CGSizeMake(60, 20);
            CGSize expectedsize2 = [shengpingfustr sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * shengpingla = [[UILabel alloc] initWithFrame:CGRectMake(20+mathname.frame.size.width, 268, expectedsize2.width, 20)];
            shengpingla.font = font2;
            shengpingla.backgroundColor = [UIColor clearColor];
            shengpingla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            shengpingla.textAlignment = NSTextAlignmentLeft;
            shengpingla.text = shengpingfustr;
            //            [self.mainView addSubview:shengpingla];
            [shengpingla release];
            
            
            //注数
            CGSize maxsize4 = CGSizeMake(200, 20);
            UIFont * font4 = [UIFont systemFontOfSize:18];
            CGSize expectedsize4 = [zhushu sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
            
            UILabel *zhuCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, expectedsize4.width, 20)];
            zhuCount.backgroundColor = [UIColor clearColor];
            zhuCount.font =font4;
            zhuCount.text = zhushu;
            zhuCount.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
            zhuCount.textAlignment = NSTextAlignmentLeft;
            [upimagebg addSubview:zhuCount];
            [zhuCount release];
            
            NSString * zhufangan = [NSString stringWithFormat:@"注 %@", chuanstr];
            //            CGSize maxsize3 = CGSizeMake(200, 20);
            UIFont * font3 = [UIFont systemFontOfSize:9];
            //            CGSize expectedsize3 = [zhufangan sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * zhufangla = [[UILabel  alloc] initWithFrame:CGRectMake(ORIGIN_X(zhuCount), 9, 190-ORIGIN_X(zhuCount), 20)];
            
            zhufangla.font = font3;
            zhufangla.backgroundColor = [UIColor clearColor];
            zhufangla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            zhufangla.textAlignment = NSTextAlignmentLeft;
            zhufangla.text = zhufangan;
            [upimagebg addSubview:zhufangla];
            [zhufangla release];
            
            // mathname.text = [NSString stringWithFormat:@"竞彩足球比分, %@注. %@方案",zhushu, chuanstr];
        }else if(fenzhong == banquanchangshengpingfu || fenzhong == shisichangpiao || fenzhong == renjiupiao){
            mathname.text = @"竞彩足球 ";
            matchNameString = @"竞彩足球 ";
            CGSize maxsize = CGSizeMake(60, 20);
            CGSize expectedsize = [mathname.text sizeWithFont:mathname.font constrainedToSize:maxsize lineBreakMode:UILineBreakModeTailTruncation];
            mathname.frame = CGRectMake(20, 266, expectedsize.width, 20);
            
            //  mathname.text = [NSString stringWithFormat:@"竞彩足球胜平负, %@注. %@方案",zhushu, chuanstr];
            NSString * shengpingfustr = @"半全场胜平负, ";
            UIFont * font2 = [UIFont systemFontOfSize:9];
            CGSize maxsize2 = CGSizeMake(60, 20);
            CGSize expectedsize2 = [shengpingfustr sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * shengpingla = [[UILabel alloc] initWithFrame:CGRectMake(20+mathname.frame.size.width, 268, expectedsize2.width, 20)];
            shengpingla.font = font2;
            shengpingla.backgroundColor = [UIColor clearColor];
            shengpingla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            shengpingla.textAlignment = NSTextAlignmentLeft;
            shengpingla.text = shengpingfustr;
            //            [self.mainView addSubview:shengpingla];
            [shengpingla release];
            NSString * zhufangan = @"";
            if (fenzhong == shisichangpiao) {
                matchNameString = @"胜负彩十四场";
                zhufangan = [NSString stringWithFormat:@"注"];
            }else if(fenzhong == renjiupiao){
                matchNameString = @"任选九";
                zhufangan = [NSString stringWithFormat:@"注"];
            }else{
                zhufangan = [NSString stringWithFormat:@"注 %@", chuanstr];
            }
            
            
            //注数
            CGSize maxsize4 = CGSizeMake(200, 20);
            UIFont * font4 = [UIFont systemFontOfSize:18];
            CGSize expectedsize4 = [zhushu sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
            
            UILabel *zhuCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, expectedsize4.width, 20)];
            zhuCount.backgroundColor = [UIColor clearColor];
            zhuCount.font =font4;
            zhuCount.text = zhushu;
            zhuCount.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
            zhuCount.textAlignment = NSTextAlignmentLeft;
            [upimagebg addSubview:zhuCount];
            [zhuCount release];
            
            //            CGSize maxsize3 = CGSizeMake(200, 20);
            UIFont * font3 = [UIFont systemFontOfSize:9];
            //            CGSize expectedsize3 = [zhufangan sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * zhufangla = [[UILabel  alloc] initWithFrame:CGRectMake(ORIGIN_X(zhuCount), 9, 190-ORIGIN_X(zhuCount), 20)];
            
            zhufangla.font = font3;
            zhufangla.backgroundColor = [UIColor clearColor];
            zhufangla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            zhufangla.textAlignment = NSTextAlignmentLeft;
            zhufangla.text = zhufangan;
            [upimagebg addSubview:zhufangla];
            [zhufangla release];
            // mathname.text = [NSString stringWithFormat:@"竞彩足球半全场胜平负, %@注. %@方案",zhushu, chuanstr];
        }else if(fenzhong == zongjinqiushu){
            mathname.text = @"竞彩足球 ";
            matchNameString = @"竞彩足球 ";
            CGSize maxsize = CGSizeMake(60, 20);
            CGSize expectedsize = [mathname.text sizeWithFont:mathname.font constrainedToSize:maxsize lineBreakMode:UILineBreakModeTailTruncation];
            mathname.frame = CGRectMake(20, 266, expectedsize.width, 20);
            
            //  mathname.text = [NSString stringWithFormat:@"竞彩足球胜平负, %@注. %@方案",zhushu, chuanstr];
            NSString * shengpingfustr = @"总进球数, ";
            UIFont * font2 = [UIFont systemFontOfSize:9];
            CGSize maxsize2 = CGSizeMake(60, 20);
            CGSize expectedsize2 = [shengpingfustr sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * shengpingla = [[UILabel alloc] initWithFrame:CGRectMake(20+mathname.frame.size.width, 268, expectedsize2.width, 20)];
            shengpingla.font = font2;
            shengpingla.backgroundColor = [UIColor clearColor];
            shengpingla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            shengpingla.textAlignment = NSTextAlignmentLeft;
            shengpingla.text = shengpingfustr;
            //            [self.mainView addSubview:shengpingla];
            [shengpingla release];
            
            
            //注数
            CGSize maxsize4 = CGSizeMake(200, 20);
            UIFont * font4 = [UIFont systemFontOfSize:18];
            CGSize expectedsize4 = [zhushu sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
            
            UILabel *zhuCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, expectedsize4.width, 20)];
            zhuCount.backgroundColor = [UIColor clearColor];
            zhuCount.font =font4;
            zhuCount.text = zhushu;
            zhuCount.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
            zhuCount.textAlignment = NSTextAlignmentLeft;
            [upimagebg addSubview:zhuCount];
            [zhuCount release];
            
            
            
            NSString * zhufangan = [NSString stringWithFormat:@"注 %@", chuanstr];
            //            CGSize maxsize3 = CGSizeMake(200, 20);
            UIFont * font3 = [UIFont systemFontOfSize:9];
            //            CGSize expectedsize3 = [zhufangan sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
            UILabel * zhufangla = [[UILabel  alloc] initWithFrame:CGRectMake(ORIGIN_X(zhuCount), 9, 190-ORIGIN_X(zhuCount), 20)];
            zhufangla.font = font3;
            zhufangla.backgroundColor = [UIColor clearColor];
            zhufangla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            zhufangla.textAlignment = NSTextAlignmentLeft;
            zhufangla.text = zhufangan;
            [upimagebg addSubview:zhufangla];
            [zhufangla release];
            // mathname.text = [NSString stringWithFormat:@"竞彩足球总进球数, %@注. %@方案",zhushu, chuanstr];
        }
        
    }
    if (fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan) {
        NSArray * arr = [zhushudict allKeys];
        NSString * chuanstr = @"";
        for (int i = 0; i < [arr count]; i++) {
            chuanstr = [NSString stringWithFormat:@"%@%@、", chuanstr, [arr objectAtIndex:i]];
        }
        chuanstr = [chuanstr substringToIndex:[chuanstr length] - 1];
        mathname.text = @"北京单场 ";
        matchNameString = @"北京单场 ";
        CGSize maxsize = CGSizeMake(60, 20);
        CGSize expectedsize = [mathname.text sizeWithFont:mathname.font constrainedToSize:maxsize lineBreakMode:UILineBreakModeTailTruncation];
        mathname.frame = CGRectMake(20, 266, expectedsize.width, 20);
        
        //  mathname.text = [NSString stringWithFormat:@"竞彩足球胜平负, %@注. %@方案",zhushu, chuanstr];
        NSString * shengpingfustr = @"";
        
        if (fenzhong == beidanbanquanchang) {
            shengpingfustr = @"半全场, ";
        }else if (fenzhong == beijingdanchang){
            shengpingfustr = @"让球胜平负, ";
        }else if (fenzhong == beidanbifen ){
            shengpingfustr = @"比分, ";
        }else if (fenzhong == beidanjinqiushu){
            shengpingfustr = @"总进球, ";
        }else if (fenzhong == beidanshangxiadanshuang){
            shengpingfustr = @"上下单双, ";
        }else if (fenzhong == beidanshengfuguoguan){
            shengpingfustr = @"胜负过关, ";
        }
        
        UIFont * font2 = [UIFont systemFontOfSize:9];
        CGSize maxsize2 = CGSizeMake(60, 20);
        CGSize expectedsize2 = [shengpingfustr sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
        UILabel * shengpingla = [[UILabel alloc] initWithFrame:CGRectMake(20+mathname.frame.size.width, 268, expectedsize2.width, 20)];
        shengpingla.font = font2;
        shengpingla.backgroundColor = [UIColor clearColor];
        shengpingla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        shengpingla.textAlignment = NSTextAlignmentLeft;
        shengpingla.text = shengpingfustr;
        //        [self.mainView addSubview:shengpingla];
        [shengpingla release];
        
        NSString * zhufangan = [NSString stringWithFormat:@"注 %@", chuanstr];
        //        CGSize maxsize3 = CGSizeMake(200, 20);
        UIFont * font3 = [UIFont systemFontOfSize:9];
        //        CGSize expectedsize3 = [zhufangan sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
        
        
        //注数
        CGSize maxsize4 = CGSizeMake(200, 20);
        UIFont * font4 = [UIFont systemFontOfSize:18];
        CGSize expectedsize4 = [zhushu sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
        
        UILabel *zhuCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, expectedsize4.width, 20)];
        zhuCount.backgroundColor = [UIColor clearColor];
        zhuCount.font =font4;
        zhuCount.text = zhushu;
        zhuCount.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
        zhuCount.textAlignment = NSTextAlignmentLeft;
        [upimagebg addSubview:zhuCount];
        [zhuCount release];
        
        
        
        //注 + 串法
        UILabel * zhufangla = [[UILabel  alloc] initWithFrame:CGRectMake(ORIGIN_X(zhuCount), 9, 190-ORIGIN_X(zhuCount), 20)];
        zhufangla.font = font3;
        zhufangla.backgroundColor = [UIColor clearColor];
        zhufangla.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        zhufangla.textAlignment = NSTextAlignmentLeft;
        zhufangla.text = zhufangan;
        [upimagebg addSubview:zhufangla];
        [zhufangla release];
        
        
        //mathname.text = [NSString stringWithFormat:@"北京单场 %@注", zhushu];
    }
    if (fenzhong == ayshengfuguogan) {
        mathname.text = [NSString stringWithFormat:@"胜负过关 %@ 注", zhushu];
    }
    if (fenzhong == aydiyiming) {
        mathname.text = [NSString stringWithFormat:@"第一名过关 %@ 注", zhushu];
    }
    if (fenzhong == guanyajunwanfa) {
        mathname.text = @"世界杯冠亚军";
        matchNameString = @"世界杯冠亚军";
    }else if (fenzhong == guanjunwanfa){
        mathname.text = @"世界杯冠军";
        matchNameString = @"世界杯冠军";
    }
    
    
    //显示方案多少钱
    NSString * fanganstr11 = @"应付";
    CGSize maxsize11 = CGSizeMake(300, 20);
    UIFont * font11 = [UIFont systemFontOfSize:16];
    CGSize expectedsize11 = [fanganstr11 sizeWithFont:font11 constrainedToSize:maxsize11 lineBreakMode:UILineBreakModeTailTruncation];
    balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
    moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 9, expectedsize11.width, 20)];
    moneylabel.text = fanganstr11;
    // moneylabel.font = font11;
    // moneylabel.text =[NSString stringWithFormat:@"方案金额:%@元 账户余额:%.2f元", moneynum, balance];
    moneylabel.textAlignment = NSTextAlignmentLeft;
    moneylabel.font = font11;//[UIFont systemFontOfSize:12];
    moneylabel.backgroundColor = [UIColor clearColor];
    moneylabel.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
    [upimagebg addSubview:moneylabel];
    [mathname release];
    [moneylabel release];
    
    
    NSString * fanganstr2 = [NSString stringWithFormat:@" %@ ", moneynum];
    CGSize maxsize2 = CGSizeMake(80, 20);
    UIFont * font2 = [UIFont systemFontOfSize:14];
    CGSize expectedsize2 = [fanganstr2 sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
    
    qianla = [[UILabel alloc] initWithFrame:CGRectMake(190+moneylabel.frame.size.width, 8, expectedsize2.width, 20)];
    qianla.text = fanganstr2;
    qianla.font = font2;
    qianla.textAlignment = NSTextAlignmentLeft;
    qianla.textColor = [UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1];
    qianla.backgroundColor = [UIColor clearColor];
    [upimagebg addSubview:qianla];
    [qianla release];
    
    NSString * fanganstr3 = @"元 ";
    CGSize maxsize3 = CGSizeMake(60, 20);
    UIFont * font3 = [UIFont systemFontOfSize:9];
    CGSize expectedsize3 = [fanganstr3 sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
    yuanla = [[UILabel alloc] initWithFrame:CGRectMake(190+moneylabel.frame.size.width+qianla.frame.size.width, 293, expectedsize3.width, 20)];
    yuanla.font = font3;
    yuanla.backgroundColor= [UIColor clearColor];
    yuanla.textAlignment = NSTextAlignmentLeft;
    yuanla.textColor =  [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    yuanla.text = fanganstr3;
    [upimagebg addSubview:yuanla];
    [yuanla release];
    
    NSString * fanganstr4 = @"余额  ";
    CGSize maxsize4 = CGSizeMake(300, 20);
    UIFont * font4 = [UIFont systemFontOfSize:12];
    CGSize expectedsize4 = [fanganstr4 sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
    yuela = [[UILabel alloc] initWithFrame:CGRectMake(190+moneylabel.frame.size.width+qianla.frame.size.width+yuanla.frame.size.width, 306, expectedsize4.width, 20)];
    yuela.font = font4;
    yuela.backgroundColor= [UIColor clearColor];
    yuela.textAlignment = NSTextAlignmentLeft;
    yuela.textColor =  [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
    yuela.text = fanganstr4;
    [upimagebg addSubview:yuela];
    [yuela release];
    
    NSString * fanganstr5 = [NSString stringWithFormat:@"%.2f ", balance];
    CGSize maxsize5 = CGSizeMake(70, 20);
    UIFont * font5 = [UIFont systemFontOfSize:14];
    CGSize expectedsize5 = [fanganstr5 sizeWithFont:font5 constrainedToSize:maxsize5 lineBreakMode:UILineBreakModeTailTruncation];
    gerenyuela = [[UILabel alloc] initWithFrame:CGRectMake(190+moneylabel.frame.size.width+qianla.frame.size.width+yuanla.frame.size.width+yuela.frame.size.width, 306, expectedsize5.width, 20)];
    gerenyuela.font = font5;
    gerenyuela.backgroundColor= [UIColor clearColor];
    gerenyuela.textAlignment = NSTextAlignmentLeft;
    gerenyuela.textColor =  [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
    gerenyuela.text = fanganstr5;
    [upimagebg addSubview:gerenyuela];
    [gerenyuela release];
    
    NSString * fanganstr6 = @"元";
    CGSize maxsize6 = CGSizeMake(60, 20);
    UIFont * font6 = [UIFont systemFontOfSize:8];
    CGSize expectedsize6 = [fanganstr6 sizeWithFont:font6 constrainedToSize:maxsize6 lineBreakMode:UILineBreakModeTailTruncation];
    yuanyla = [[UILabel alloc] initWithFrame:CGRectMake(190+moneylabel.frame.size.width+qianla.frame.size.width+yuela.frame.size.width+yuanla.frame.size.width+gerenyuela.frame.size.width, 306, expectedsize6.width, 20)];
    yuanyla.font = font6;
    yuanyla.backgroundColor= [UIColor clearColor];
    gerenyuela.textAlignment = NSTextAlignmentLeft;
    yuanyla.textColor =  [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    yuanyla.text = fanganstr6;
    [upimagebg addSubview:yuanyla];
    [yuanyla release];
    if ([[[Info getInstance] userId] intValue] == 0) {
        gerenyuela.hidden = YES;
        yuanyla.hidden = YES;
        yuela.hidden = YES;
    }
    
    
    
    if (fenzhong == jingcaihuntouerxuanyi||fenzhong == jingcaihuntou||fenzhong == jingcairangfenshengfu||fenzhong == jingcaipiao || fenzhong == beijingdanchang || fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == jingcaibifen || fenzhong == zongjinqiushu || fenzhong == banquanchangshengpingfu || fenzhong == jingcailanqiushengfu|| fenzhong == jingcailanqiurangfenshengfu || fenzhong == jingcailanqiushengfencha || fenzhong == jingcailanqiudaxiaofen||fenzhong == lanqiuhuntou|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan || fenzhong == guanjunwanfa||fenzhong == guanyajunwanfa || fenzhong == jingcaidahuntou) {
        //预计奖金
        //   if (danguanbool == NO) {
        NSString * fanganstr66 = @"预计奖金 ";
        CGSize maxsize66 = CGSizeMake(90, 20);
        UIFont * font66 = [UIFont systemFontOfSize:10];
        CGSize expectedsize66 = [fanganstr66 sizeWithFont:font66 constrainedToSize:maxsize66 lineBreakMode:UILineBreakModeTailTruncation];
        
        yujimoney = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, expectedsize66.width, 20)];
        yujimoney.textAlignment = NSTextAlignmentLeft;
        yujimoney.font = font66;//[UIFont systemFontOfSize:12];
        yujimoney.backgroundColor = [UIColor clearColor];
        yujimoney.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        yujimoney.text =fanganstr66;// [NSString stringWithFormat:@"预计奖金:%@元 - %@元", minmoneystr, maxmoneystr  ];
        [upimagebg addSubview:yujimoney];
        
        NSString * fanganstr55 =@"";
        
        if ([minmoneystr isEqualToString:maxmoneystr]) {
            fanganstr55 = [NSString stringWithFormat:@"<%@> 元",maxmoneystr];
            
        }else{
            fanganstr55 = [NSString stringWithFormat:@"<%@ - %@> 元", minmoneystr, maxmoneystr];
        }
        
        //        CGSize maxsize55 = CGSizeMake(300, 20);
        //        UIFont * font55 = [UIFont systemFontOfSize:9];
        //        CGSize expectedsize55 = [fanganstr55 sizeWithFont:font55 constrainedToSize:maxsize55 lineBreakMode:UILineBreakModeTailTruncation];
        
        fanweila = [[ColorView alloc] initWithFrame:CGRectMake(10+yujimoney.frame.size.width, 310, 200, 20)];
        fanweila.font = [UIFont systemFontOfSize:10];
        
        fanweila.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        fanweila.changeColor = [UIColor redColor];
        fanweila.backgroundColor = [UIColor clearColor];
        fanweila.text = fanganstr55;
        fanweila.textAlignment = NSTextAlignmentLeft;
        [upimagebg addSubview:fanweila];
        [fanweila release];
        //    }
        if ([maxmoneystr floatValue] == 0.0 && [minmoneystr floatValue] == 0.0) {
            yujimoney.hidden = YES;
            fanweila.hidden = YES;
        }
        
        
    }
    
    UIButton * textfliedbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    textfliedbutton.frame = CGRectMake(10, 55, 95, 30);
    [textfliedbutton addTarget:self action:@selector(pressTextFliedButton:) forControlEvents:UIControlEventTouchUpInside];
    [upimagebg addSubview:textfliedbutton];
    
    UIImageView * textbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 30)];
    textbgimage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:9];
    [textfliedbutton addSubview:textbgimage];
    [textbgimage release];
    
    UILabel * beitoula = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 30, 30)];
    beitoula.text = @"倍投";
    beitoula.textAlignment = NSTextAlignmentCenter;
    beitoula.backgroundColor = [UIColor clearColor];
    beitoula.font = [UIFont systemFontOfSize:12];
    beitoula.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    [textbgimage addSubview:beitoula];
    [beitoula release];
    
    
    beitou = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 95-32, 30)];
    beitou.text = @"1";
    if (beitouNumber) {
        beitou.text = [NSString stringWithFormat:@"%d",beitouNumber];
    }
    beitou.textAlignment = NSTextAlignmentCenter;
    beitou.backgroundColor = [UIColor clearColor];
    beitou.font = [UIFont systemFontOfSize:15];
    beitou.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [textbgimage addSubview:beitou];
    [beitou release];
    
    
    
    numtextfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 331, 40, 20)];
    numtextfield.delegate = self;
    numtextfield.text = @"1";
    numtextfield.font= [UIFont systemFontOfSize:13];
    numtextfield.backgroundColor = [UIColor whiteColor];
    [numtextfield setReturnKeyType:UIReturnKeyDone];
    [numtextfield setKeyboardType:UIKeyboardTypeNumberPad];
    //    [self.mainView addSubview:numtextfield];
    
    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame = CGRectMake(118.5, 55, 44.5, 30);
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    [addbutton setBackgroundImage:UIImageGetImageFromName(@"zhuihaojia_normal.png") forState:UIControlStateNormal];
    [addbutton setBackgroundImage:UIImageGetImageFromName(@"zhuihaojia_selected.png") forState:UIControlStateHighlighted];
    
    
    
    UIButton * jianbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    jianbutton.frame = CGRectMake(164, 55, 44.5, 30);
    [jianbutton setBackgroundImage:UIImageGetImageFromName(@"zhuihaojian_normal.png") forState:UIControlStateNormal];
    [jianbutton setBackgroundImage:UIImageGetImageFromName(@"zhuihaojian_selected.png") forState:UIControlStateHighlighted];
    
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * baomibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    baomibutton.frame = CGRectMake(220, 55, 74, 30);
    baomibutton.tag = 1010;
    [baomibutton setBackgroundImage:[UIImageGetImageFromName(@"btn_yellow_normal.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [baomibutton setBackgroundImage:[UIImageGetImageFromName(@"btn_yellow_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [baomibutton addTarget:self action:@selector(pressBaoMiButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * baomilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 74, 30)];
    baomilabel.backgroundColor = [UIColor clearColor];
    baomilabel.textAlignment = NSTextAlignmentCenter;
    baomilabel.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1];
    baomilabel.font = [UIFont boldSystemFontOfSize:13];
    baomilabel.text = @"公开";
    baomilabel.tag = 1011;
    [baomibutton addSubview:baomilabel];
    [baomilabel release];
    
    
    
    [upimagebg addSubview:addbutton];
    [upimagebg addSubview:jianbutton];
    [upimagebg addSubview:baomibutton];
    
    
    
    touzhubut = [UIButton buttonWithType:UIButtonTypeCustom];
    touzhubut.frame = CGRectMake(110, self.mainView.bounds.size.height - 35, 79, 29);
    [touzhubut setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [touzhubut setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [touzhubut addTarget:self action:@selector(presstouzhubut) forControlEvents:UIControlEventTouchUpInside];
    
    buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    if (hemaibool) {
        buttonLabel1.text = @"发起";
    }else{
        buttonLabel1.text = @"投注";
    }
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];//[UIColor colorWithRed:25/255.0 green:114/255.0 blue:176/255.0 alpha:1];
    //  buttonLabel1.textColor = [UIColor whiteColor];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:15];
    
    [touzhubut addSubview:buttonLabel1];
    [buttonLabel1 release];
    
    [self.mainView addSubview:touzhubut];
    
    
    
    if (fenzhong != ayshengfuguogan && fenzhong != ayjinyintong && fenzhong != aydiyiming && fenzhong != guanyajunwanfa &&fenzhong!= guanjunwanfa) {
        
        
//        
        CP_SWButton * switchyn = [[CP_SWButton alloc] initWithFrame:CGRectMake(240, self.mainView.bounds.size.height  - 34, 69.5, 31)];
        switchyn.onImageName = @"switch_hemai_on.png";
        switchyn.offImageName = @"switch_hemai_off.png";
        switchyn.on = self.isHeMai;
        [switchyn addTarget:self action:@selector(hemaiSetting:) forControlEvents:UIControlEventValueChanged];
        [self performSelector:@selector(hemaiSetting:) withObject:switchyn];
        [self.mainView addSubview:switchyn];
        [switchyn release];
        
#ifdef isCaiPiaoForIPad
        lable.frame=  CGRectMake(197+35,  self.mainView.bounds.size.height  - 35, 35, 30);
        switchyn.frame = CGRectMake(232+35, self.mainView.bounds.size.height  - 34, 77, 27);
#endif
        
    }
    if (fenzhong == jingcaihuntou||fenzhong == jingcaibifen || fenzhong == zongjinqiushu || fenzhong == banquanchangshengpingfu || fenzhong == jingcailanqiushengfencha||fenzhong == lanqiuhuntou || fenzhong == beidanjinqiushu || fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanshangxiadanshuang || fenzhong == jingcaidahuntou) {
        NSMutableArray * bifenarr;
        
        if (fenzhong == jingcaibifen) {
            bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
        }else if(fenzhong == zongjinqiushu){
            bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
        }else if(fenzhong == banquanchangshengpingfu){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
        }else if(fenzhong == jingcailanqiushengfencha){
            bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
        }else if(fenzhong == jingcaihuntou){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜", @"平", @"负", @"让球胜", @"让球平", @"让球负", nil];
        }else if(fenzhong == lanqiuhuntou){
            bifenarr = [NSMutableArray arrayWithObjects: @"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
            
        }else if(fenzhong == beidanjinqiushu){
            bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
        }else if(fenzhong == beidanshangxiadanshuang){
            bifenarr = [NSMutableArray arrayWithObjects:@"上单", @"上双", @"下单", @"下双", nil];
        }else if(fenzhong == beidanbifen){
            bifenarr = [NSMutableArray arrayWithObjects:@"1:0", @"2:0", @"2:1", @"3:0", @"3:1", @"3:2", @"4:0", @"4:1", @"4:2", @"胜其他", @"0:0", @"1:1", @"2:2", @"3:3", @"平其他", @"0:1", @"0:2", @"1:2", @"0:3", @"1:3", @"2:3", @"0:4", @"1:4", @"2:4",  @"负其他", nil];;
        }else if (fenzhong == beidanbanquanchang){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜-胜", @"胜-平", @"胜-负", @"平-胜",@"平-平", @"平-负", @"负-胜", @"负-平", @"负-负", nil];
            
        }else if(fenzhong == jingcaidahuntou){
            
            bifenarr = [NSMutableArray arrayWithObjects:@"胜", @"平", @"负", @"让球胜", @"让球平", @"让球负",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负",  nil];
        }
        
        for (GC_BetData * be in bettingArray) {
            BOOL zhongjiebool = NO;
            for (int i = 0; i < [be.bufshuarr count]; i++) {
                if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    zhongjiebool = YES;
                    break;
                }
            }
            
            if (zhongjiebool) {
                GC_shengfudata * da = [GC_shengfudata alloc];
                da.leftStr = be.team;
                da.changci = be.changhao;
                da.dandan = be.dandan;
                da.jiancheng = be.event;
                NSString * strpin = @"";
                for (int i = 0; i < [be.bufshuarr count]; i++) {
                    
                    if (fenzhong == lanqiuhuntou) {
                        if (i == 18) {
                            break;
                        }
                        NSInteger bagcount = 0;
                        //                        bagcount= i;
                        //                        if (i > 5 && i < 12) {
                        //                            bagcount = i + 6;
                        //                        }else if(i >= 12){
                        //                            bagcount = i  - 6;
                        //                        }else{
                        bagcount = i;
                        //                        }
                        
                        if ([[be.bufshuarr objectAtIndex:bagcount] isEqualToString:@"1"]) {
                            
                            strpin = [NSString stringWithFormat:@"%@%@,", strpin, [bifenarr objectAtIndex:bagcount]];
                            
                            
                        }
                    }else{
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            strpin = [NSString stringWithFormat:@"%@%@,", strpin, [bifenarr objectAtIndex:i]];
                        }
                    }
                    
                    
                }
                
                if ([strpin length] > 0) {
                    strpin = [strpin substringToIndex:[strpin length]-1];
                }
                da.cuStr = strpin;
                NSLog(@"strping = %@", strpin);
                if (be.dandan) {
                    da.rightImage = UIImageGetImageFromName(@"gc_dot60.png");
                }else{
                    da.rightImage = UIImageGetImageFromName(@"TZFAXQZCQQ-960.png");
                }
                [dataAr addObject:da];
                [da release];
                
            }
            
        }
        
        
    }else if ((fenzhong != aydiyiming && fenzhong != ayjinyintong) || fenzhong == jingcailanqiushengfu || fenzhong == jingcailanqiurangfenshengfu ||fenzhong == jingcailanqiudaxiaofen || fenzhong == jingcaihuntouerxuanyi||fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa) {
        
        if (fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
            
            for (int i = 0; i < [self.championData.typeArray count];i++) {
                if ([[self.championData.typeArray objectAtIndex:i] isEqualToString:@"1"]) {
                    NSArray * teamArray = [self.championData.teamInfo componentsSeparatedByString:@","];
                    NSArray * numArray = [self.championData.teamNum componentsSeparatedByString:@","];
                    GC_shengfudata * da = [GC_shengfudata alloc];
                    if ([teamArray count] > i) {
                        da.leftStr = [teamArray objectAtIndex:i];
                    }else{
                        da.leftStr = @"";
                    }
                    if ([numArray count] > i) {
                        da.jiancheng = [numArray objectAtIndex:i];
                    }else{
                        da.jiancheng = @"";
                    }
                    if (fenzhong == guanjunwanfa) {
                        da.cuStr = @"冠军";
                    }else if (fenzhong == guanyajunwanfa){
                        da.cuStr = @"冠亚军";
                    }
                    
                    [dataAr addObject:da];
                    [da release];
                }
                
            }
            
            
            
        }else{
            for (GC_BetData * be in bettingArray) {
                NSString * strings;
                NSString * stri1;
                NSString * stri2;
                NSString * stri3;
                if (be.selection1 || be.selection2 || be.selection3) {
                    GC_shengfudata * da = [GC_shengfudata alloc];
                    da.leftStr = be.team;
                    da.changci = be.changhao;
                    da.jiancheng = be.event;
                    da.dandan = be.dandan;
                    
                    
                    
                    if (fenzhong == ayshengfuguogan || fenzhong == jingcailanqiushengfu || fenzhong == jingcailanqiurangfenshengfu ) {
                        if (be.selection1) {
                            stri1 = @"主负,";
                        }else{
                            stri1 = @"";
                        }
                        
                        if (be.selection2) {
                            stri2 = @"主胜,";
                        }else{
                            stri2 = @"";
                        }
                        
                        strings = [NSString stringWithFormat:@"%@%@", stri1, stri2];
                        strings = [strings substringToIndex:[strings length] - 1];
                    }else if(fenzhong == jingcailanqiudaxiaofen){
                        if (be.selection1) {
                            stri1 = @"大,";
                        }else{
                            stri1 = @"";
                        }
                        
                        if (be.selection2) {
                            stri2 = @"小,";
                        }else{
                            stri2 = @"";
                        }
                        
                        strings = [NSString stringWithFormat:@"%@%@", stri1, stri2];
                        strings = [strings substringToIndex:[strings length] - 1];
                    }else if(fenzhong == jingcaihuntouerxuanyi){
                        
                        NSArray * teamarray = [be.team componentsSeparatedByString:@","];
                        NSString * rangQiuString = [teamarray objectAtIndex:2];
                        
                        if ([rangQiuString intValue] > 0) {
                            if (be.selection1) {
                                stri1 = @"主不败";
                            }else{
                                stri1 = @"";
                            }
                            
                            if (be.selection2) {
                                stri2 = @"客胜";
                            }else{
                                stri2 = @"";
                            }
                            
                            
                        }else{
                            if (be.selection1) {
                                stri1 = @"主胜";
                            }else{
                                stri1 = @"";
                            }
                            
                            if (be.selection2) {
                                stri2 = @"客不败";
                            }else{
                                stri2 = @"";
                            }
                            
                        }
                        if ([stri1 isEqualToString:@""]||[stri2 isEqualToString:@""]) {
                            strings = [NSString stringWithFormat:@"%@%@", stri1, stri2];
                        }else{
                            strings = [NSString stringWithFormat:@"%@,%@", stri1, stri2];
                        }
                        
                        
                    }else if(fenzhong == beidanshengfuguoguan){
                        
                        if (be.selection1) {
                            stri1 = @"胜,";
                        }else{
                            stri1 = @"";
                        }
                        
                        if (be.selection2) {
                            stri2 = @"负,";
                        }else{
                            stri2 = @"";
                        }
                        
                        strings = [NSString stringWithFormat:@"%@%@", stri1, stri2];
                        strings = [strings substringToIndex:[strings length] - 1];
                        
                    }else{
                        if (be.selection1) {
                            stri1 = @"胜,";
                        }else{
                            stri1 = @"";
                        }
                        
                        if (be.selection2) {
                            stri2 = @"平,";
                        }else{
                            stri2 = @"";
                        }
                        if (be.selection3) {
                            stri3 = @"负,";
                        }else {
                            stri3 = @"";
                        }
                        strings = [NSString stringWithFormat:@"%@%@%@", stri1, stri2, stri3];
                        strings = [strings substringToIndex:[strings length] - 1];
                        
                    }
                    
                    da.cuStr = strings;
                    NSLog(@"custr = %@", strings);
                    if (be.dandan) {
                        da.rightImage = UIImageGetImageFromName(@"gc_dot60.png");
                        
                    }
                    
                    [dataAr addObject:da];
                    [da release];
                }
            }
        }
        
        
    }else{
        
        for (AoyunMatchInfo * aoyunm in bettingArray) {
            
            // for (AoyunMatchInfo * aypl in aoyunm.MatchInfoArray) {
            
            GC_shengfudata * da = [[GC_shengfudata alloc] init];
            NSString * strstr = @"";
            //    NSString * strstr1 = @"";
            NSString * strstr2 = @"";
            NSString * strstr3 = @"";
            //            NSInteger countjin = 0;
            //            NSInteger countyin = 0;
            //            NSInteger counttong = 0;
            
            for (AoyunPlayer *player in aoyunm.playerArray) {
                if (player.isJin == YES) {
                    
                    
                    da.changci = [NSString stringWithFormat:@"%d", (int)aoyunm.matchNum];
                    da.jiancheng = aoyunm.matchName;
                    strstr = [NSString stringWithFormat:@"%@%d,", strstr, (int)player.playerId];
                    
                    
                }
                if (player.isYin == YES) {
                    strstr2 = [NSString stringWithFormat:@"%@%d,", strstr2, (int)player.playerId];
                    
                }
                if (player.isTong == YES) {
                    strstr3 = [NSString stringWithFormat:@"%@%d,", strstr3, (int)player.playerId];
                }
                
            }
            if ([strstr length] > 1) {
                strstr = [strstr substringToIndex:[strstr length]-1];
                
                da.cuStr = strstr;
                if (fenzhong == ayjinyintong) {
                    strstr2 = [strstr2 substringToIndex:[strstr2 length]-1];
                    strstr3 = [strstr3 substringToIndex:[strstr3 length]-1];
                    
                    da.jinstr =  strstr;
                    da.yinstr = strstr2;
                    da.tongstr = strstr3;
                }
                [dataAr addObject:da];
            }
            [da release];
            
        }
        //  }
        
        
    }
    //    [myTableView reloadData];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWithMoney) userInfo:nil repeats:YES];
    [timer fire];
    
    //    if (![GC_UserInfo sharedInstance].personalData.userName) {
    //        [self getPersonalInfoRequest];
    //    } else {
    
    
    if (isxianshiyouhuaBtn) {
        yhButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        yhButton.frame = CGRectMake(10,95, 300, 27);
        
        [yhButton addTarget:self action:@selector(pressYouHuaButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //        BOOL dfsBool = NO;
        //        if (oneDoubleBool) {
        //            NSArray * arr = [zhushudict allKeys];
        //            for (int i = 0; i < [arr count]; i++) {
        //                NSString * cfStr = [arr objectAtIndex:i];
        //                if ([cfStr isEqualToString:@"单关"]) {
        //                    dfsBool = YES;
        //                }
        //            }
        //        }
        
        
        
        if (youhuaBool) {
            [yhButton loadButonImage:@"btn_blue_selected.png" LabelName:@"奖金优化"];
            yhButton.buttonName.font = [UIFont boldSystemFontOfSize:16];
            
        }
        else {
            [yhButton loadButonImage:@"btn_lightblue_normal.png" LabelName:@"奖金优化 支持最多5场 2串1-5串1的单串方案"];
            yhButton.buttonName.font = [UIFont boldSystemFontOfSize:14];
            
            yhButton.enabled = NO;
        }
        yhButton.buttonName.textColor = [UIColor whiteColor];
        //        yhButton.buttonName.shadowOffset = CGSizeMake(0, 0);
        //        yhButton.buttonName.shadowColor = [UIColor clearColor];
        //        [yhButton setHightImage:[UIImageGetImageFromName(@"ZHBANBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        //        yhButton.selectImage = [UIImageGetImageFromName(@"ZHBANBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [downbgImageView addSubview:yhButton];
        
    }
    
    [self youHuaFrameSizeFunc];
    
#ifdef isCaiPiaoForIPad
    tvbg.frame = CGRectMake(10+35, 10, 300, 540);
    upimagebg.frame = CGRectMake(10+35, 284+540-264, 300, 85);
    downimage.frame = CGRectMake(0, self.view.bounds.size.height - 400+36, 390, 44);
    myTableView.frame = CGRectMake(0, 0, 320, 540);
    touzhubut.frame = CGRectMake(110+35, self.mainView.bounds.size.height - 35, 79, 29);
#else
#endif
    
    
    
    
    isShowingKeyboard = NO;
    
    //    }
    
    
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView.hightFloat = 95;
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];
    
}

- (void)pressBaoMiButton:(UIButton *)sender{
    
    UIButton * buttonbaomi = (UIButton *)[upimagebg viewWithTag:1010];
    UILabel * labelbaomi = (UILabel *)[buttonbaomi viewWithTag:1011];
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"方案设置" message:labelbaomi.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.shouldRemoveWhenOtherAppear = YES;
    alert.alertTpye = segementType;
    alert.tag = 999;
    [alert show];
    [alert release];
}

- (void)showkey{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
#ifdef isCaiPiaoForIPad
    imageViewkey.frame = CGRectMake(35, self.mainView.frame.size.height - 110 - 51, 320, 113);
    tvbg.frame = CGRectMake(10+35, 10, 300, 540-113);
    upimagebg.frame = CGRectMake(10+35, 284+540-264 - 104, 300, 85);
    myTableView.frame = CGRectMake(0, 0, 320, 540 - 113);
#else
    imageViewkey.frame = CGRectMake(0, self.mainView.frame.size.height - 154.5 - 41, 320, 154.5);
    
    if (isxianshiyouhuaBtn) {
        tvbg.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height-180-5-113);
        //        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-180-5-113);
        
        yhButton.frame = CGRectMake(10,95, 300, 27);
    }else{
        //        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-140-5-154.5);
        tvbg.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height-180-5-113);
        
        
    }
    downbgImageView.frame = CGRectMake(0, self.mainView.frame.size.height- 95 - 54*4, 320, 180);
#endif
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}
- (void)hidenJianPan {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
#ifdef isCaiPiaoForIPad
    imageViewkey.frame = CGRectMake(35, self.mainView.frame.size.height - 51, 320, 0);
    tvbg.frame = CGRectMake(10+35, 10, 300, 540);
    upimagebg.frame = CGRectMake(10+35, 284+540-264, 300, 85);
    myTableView.frame = CGRectMake(0, 0, 320, 540);
#else
    imageViewkey.frame = CGRectMake(0, self.mainView.frame.size.height - 41, 320, 0);
    
    
    if (isxianshiyouhuaBtn) {
        [self youHuaFrameSizeFunc];
    }else{
        
        tvbg.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height-140-15);
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-140-15-30);
        downbgImageView.frame = CGRectMake(0, self.mainView.frame.size.height-140, 320, 140);
    }
    
    
#endif
    
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}


- (void)pressTextFliedButton:(UIButton*)sender{
    
    
    
    
    
    if(!isShowingKeyboard){
        isShowingKeyboard = YES;
        if([beitou.text isEqualToString:@"0"]||[beitou.text isEqualToString:@""]){
            textcount =  1;
            
        }else{
            textcount =  [beitou.text intValue];
            
        }
        
        
        //        beitou.text = @"";
        [gckeyView showKeyFunc];
        beitou.textColor = [UIColor grayColor];
        [self showkey];
        
    }else{
        isShowingKeyboard = NO;
        if([beitou.text isEqualToString:@"0"]||[beitou.text isEqualToString:@""]){
            beitou.text = [NSString stringWithFormat:@"%d", (int)textcount];
        }
        [self hidenJianPan];
        beitou.textColor = [UIColor blackColor];
        [gckeyView dissKeyFunc];
        [self dataBetTouText];
    }
    
    
    
}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    [self hidenJianPan];
    [gckeyView dissKeyFunc];
    [self dataBetTouText];
    beitou.textColor = [UIColor blackColor];
    isShowingKeyboard = NO;
}

- (void)dataBetTouText{
    
    if ([beitou.text intValue] <= 0) {
        beitou.text = @"1";
    }
}

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{
    
    if (sender == 11) {
        isShowingKeyboard = NO;
        [self hidenJianPan];
        [gckeyView dissKeyFunc];
        beitou.textColor = [UIColor blackColor];
        if([beitou.text isEqualToString:@"0"]||[beitou.text isEqualToString:@""]){
            beitou.text = @"1";
            beitou.textColor = [UIColor grayColor];
        }
    }
    else if (sender == 10) {
        beitou.text = [NSString stringWithFormat:@"%d",[beitou.text intValue]/10];
        if ([beitou.text isEqualToString:@"0"]||[beitou.text isEqualToString:@""]) {
            beitou.text = @"1";
            beitou.textColor = [UIColor grayColor];
        }else{
            beitou.textColor = [UIColor blackColor];
        }
    }
    else {
        if ([beitou.textColor isEqual:[UIColor grayColor]]) {
            beitou.text = [NSString stringWithFormat:@"%d", (int)sender];
            
        }else{
            beitou.text = [NSString stringWithFormat:@"%d",[beitou.text intValue] * 10 + (int)sender];
        }
        beitou.textColor = [UIColor blackColor];
        
    }
    //    [self textFieldDidEndEditing:rengouText];
    
    
    if (jingcai) {
        
        if ([beitou.text length] == 4) {
            
            if ([beitou.text intValue] >= 29999) {
                beitou.text = @"29999";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            //            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([beitou.text length] > 5){
                
                beitou.text = @"29999";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
        
        
    }else if(fenzhong == beijingdanchang||fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == ayjinyintong||fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
        
        if ([beitou.text length] == 4) {
            //            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if ([beitou.text intValue] >= 10000) {
                beitou.text = @"10000";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            //            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([beitou.text length] >= 5){
                
                beitou.text = @"10000";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
    }else {
        
        if ([beitou.text length] == 1) {
            //            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if ([beitou.text intValue] >= 99) {
                beitou.text = @"99";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            //            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([beitou.text length] > 2){
                
                beitou.text = @"99";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
        
    }
    
    
    
}


//查询个人信息
- (void)getPersonalInfoRequest
{
    //    废弃
    //    NSMutableData *postData = [[GC_HttpService sharedInstance] personalData];
    //
    //    [httpReq clearDelegatesAndCancel];
    //    self.httpReq = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    //    [httpReq setRequestMethod:@"POST"];
    //    [httpReq addCommHeaders];
    //    [httpReq setPostBody:postData];
    //    [httpReq setDefaultResponseEncoding:NSUTF8StringEncoding];
    //    [httpReq setDelegate:self];
    //    [httpReq setDidFinishSelector:@selector(rePersonalInfoFinished:)];
    //    [httpReq startSynchronous];
}

- (void)rePersonalInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[request responseData]WithRequest:request];
        [GC_UserInfo sharedInstance].personalData = personalData;
        [personalData release];
        [self getAccountInfoRequest];
    }
}


- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
        
        [httpReq clearDelegatesAndCancel];
        self.httpReq = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpReq setRequestMethod:@"POST"];
        [httpReq addCommHeaders];
        [httpReq setPostBody:postData];
        [httpReq setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpReq setDelegate:self];
        [httpReq setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpReq startAsynchronous];
    }
    
}

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            self.accountManage = aManage;
            [GC_UserInfo sharedInstance].accountManage = aManage;
            NSLog(@"%@", [GC_UserInfo sharedInstance].accountManage.accountBalance);
            balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
            NSString * fanganstr5 = [NSString stringWithFormat:@"%.2f ", balance];
            gerenyuela.text = fanganstr5;
            gerenyuela.hidden = NO;
        }
        [aManage release];
        
        
    }
    
}


- (void)timerWithMoney{
    if (maxmoney) {
        maxmoney = NO;
        if (jingcai) {
            
            beitou.text = @"29999";
            
            
        }else if(fenzhong == beijingdanchang||fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == ayjinyintong|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
            
            beitou.text = @"10000";
        }else {
            beitou.text = @"99";
        }
        
        
    }
    //    if ([beitou.text intValue] <= 1) {
    // moneylabel.text =[NSString stringWithFormat:@"方案金额:%@元 账户余额:%.2f元", moneynum, balance];
    NSString * fanganstr2 = [NSString stringWithFormat:@" %d", [moneynum intValue]* [beitou.text intValue]];
    //        NSString * fanganstr2 = [NSString stringWithFormat:@" %@ ", moneynum];
    CGSize maxsize2 = CGSizeMake(80, 20);
    UIFont * font2 = [UIFont systemFontOfSize:14];
    CGSize expectedsize2 = [fanganstr2 sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
    qianla.text = fanganstr2;
    qianla.frame = CGRectMake(190+moneylabel.frame.size.width, 8, expectedsize2.width,  20);
    NSString * fanganstr3 = @"元 ";
    CGSize maxsize3 = CGSizeMake(60, 20);
    UIFont * font3 = [UIFont systemFontOfSize:9];
    CGSize expectedsize3 = [fanganstr3 sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
    yuanla.text = fanganstr3;
    yuanla.frame = CGRectMake(190+moneylabel.frame.size.width+expectedsize2.width, 9, expectedsize3.width, 20);
    
    NSString * fanganstr4 = @"余额  ";
    CGSize maxsize4 = CGSizeMake(300, 20);
    UIFont * font4 = [UIFont systemFontOfSize:12];
    CGSize expectedsize4 = [fanganstr4 sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
    yuela.frame = CGRectMake(190, 26, expectedsize4.width, 20);
    
    NSString * fanganstr5 = [NSString stringWithFormat:@"%.2f ", balance];
    CGSize maxsize5 = CGSizeMake(70, 20);
    UIFont * font5 = [UIFont systemFontOfSize:14];
    CGSize expectedsize5 = [fanganstr5 sizeWithFont:font5 constrainedToSize:maxsize5 lineBreakMode:UILineBreakModeTailTruncation];
    gerenyuela.frame = CGRectMake(190+yuela.frame.size.width, 26, expectedsize5.width, 20);
    
    
    NSString * fanganstr6 = @"元";
    CGSize maxsize6 = CGSizeMake(60, 20);
    UIFont * font6 = [UIFont systemFontOfSize:8];
    CGSize expectedsize6 = [fanganstr6 sizeWithFont:font6 constrainedToSize:maxsize6 lineBreakMode:UILineBreakModeTailTruncation];
    yuanyla.frame = CGRectMake(190+yuela.frame.size.width+gerenyuela.frame.size.width, 26, expectedsize6.width, 20);
    
    //    }else{
    //        // moneylabel.text =[NSString stringWithFormat:@"方案金额:%d元 账户余额:%.2f元", [moneynum intValue]* [numtextfield.text intValue], balance];
    //        NSString * fanganstr2 = [NSString stringWithFormat:@" %d", [moneynum intValue]* [beitou.text intValue]];
    //        CGSize maxsize2 = CGSizeMake(80, 20);
    //        UIFont * font2 = [UIFont systemFontOfSize:14];
    //        CGSize expectedsize2 = [fanganstr2 sizeWithFont:font2 constrainedToSize:maxsize2 lineBreakMode:UILineBreakModeTailTruncation];
    //        qianla.text = fanganstr2;
    //        qianla.frame = CGRectMake(190+moneylabel.frame.size.width, 8, expectedsize2.width,  20);
    //
    //        NSString * fanganstr3 = @" 元 ";
    //        CGSize maxsize3 = CGSizeMake(60, 20);
    //        UIFont * font3 = [UIFont systemFontOfSize:9];
    //        CGSize expectedsize3 = [fanganstr3 sizeWithFont:font3 constrainedToSize:maxsize3 lineBreakMode:UILineBreakModeTailTruncation];
    //        yuanla.text = fanganstr3;
    //        yuanla.frame = CGRectMake(190+moneylabel.frame.size.width+expectedsize2.width, 293, expectedsize3.width, 20);
    ////        yuanla.backgroundColor = [UIColor blackColor];
    //        NSLog(@"qianla.frame.x = %f,qianla.frame.w = %f , yuan.frame.x = %f,yuan.frame.w = %f", qianla.frame.origin.x,qianla.frame.size.width,yuanla.frame.origin.x,yuanla.frame.size.width);
    //
    //        NSString * fanganstr4 = @"余额  ";
    //        CGSize maxsize4 = CGSizeMake(300, 20);
    //        UIFont * font4 = [UIFont systemFontOfSize:12];
    //        CGSize expectedsize4 = [fanganstr4 sizeWithFont:font4 constrainedToSize:maxsize4 lineBreakMode:UILineBreakModeTailTruncation];
    //        yuela.frame = CGRectMake(190, 21, expectedsize4.width, 20);
    //
    //        NSString * fanganstr5 = [NSString stringWithFormat:@"%.2f ", balance];
    //        CGSize maxsize5 = CGSizeMake(60, 20);
    //        UIFont * font5 = [UIFont systemFontOfSize:14];
    //        CGSize expectedsize5 = [fanganstr5 sizeWithFont:font5 constrainedToSize:maxsize5 lineBreakMode:UILineBreakModeTailTruncation];
    //        gerenyuela.frame = CGRectMake(190+yuela.frame.size.width, 21, expectedsize5.width, 20);
    //
    //
    //        NSString * fanganstr6 = @"元";
    //        CGSize maxsize6 = CGSizeMake(60, 20);
    //        UIFont * font6 = [UIFont systemFontOfSize:8];
    //        CGSize expectedsize6 = [fanganstr6 sizeWithFont:font6 constrainedToSize:maxsize6 lineBreakMode:UILineBreakModeTailTruncation];
    //        yuanyla.frame = CGRectMake(190+yuela.frame.size.width+gerenyuela.frame.size.width, 21, expectedsize6.width, 20);
    //    }
    
    
    // yujimoney.text = [NSString stringWithFormat:@"预计奖金:%.2f元 - %.2f元", [minmoneystr floatValue]*[numtextfield.text floatValue], [maxmoneystr floatValue]*[numtextfield.text floatValue] ];
    NSString * fanganstr66 = @"预计奖金: ";
    CGSize maxsize66 = CGSizeMake(90, 20);
    UIFont * font66 = [UIFont systemFontOfSize:10];
    CGSize expectedsize66 = [fanganstr66 sizeWithFont:font66 constrainedToSize:maxsize66 lineBreakMode:UILineBreakModeTailTruncation];
    
    yujimoney.frame = CGRectMake(10, 26, expectedsize66.width, 20);
    yujimoney.font = font66;
    
    NSString * fanganstr55 =@"";
    if ([minmoneystr isEqualToString:maxmoneystr]) {
        fanganstr55 = [NSString stringWithFormat:@"<%.2f> 元",  [maxmoneystr floatValue]*[beitou.text floatValue]];
    }else{
        fanganstr55 = [NSString stringWithFormat:@"<%.2f - %.2f> 元",  [minmoneystr floatValue]*[beitou.text floatValue], [maxmoneystr floatValue]*[beitou.text floatValue]];
    }
    
    
    //    CGSize maxsize55 = CGSizeMake(300, 20);
    //    UIFont * font55 = [UIFont systemFontOfSize:9];
    //    CGSize expectedsize55 = [fanganstr55 sizeWithFont:font55 constrainedToSize:maxsize55 lineBreakMode:UILineBreakModeTailTruncation];
    
    fanweila.frame = CGRectMake(10+yujimoney.frame.size.width, 30, 135, 25);
    fanweila.text = fanganstr55;
    
}

- (void)doBack{
    if (bianjibool) {
        
        if([BetDetailInfo.lotteryId isEqualToString:@"201"]||[BetDetailInfo.lotteryId isEqualToString:@"200"]){//竞彩
            
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            gcjc.systimestr = systimestr;
            gcjc.chaodanbool = YES;
            gcjc.betrecorinfo = BetDetailInfo;
            if ([BetDetailInfo.wanfaId isEqualToString:@"04"]) {
                gcjc.lanqiubool = NO;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumBanQuanChangDanGuan;
                }else{
                    gcjc.matchenum = matchenumBanQuanChang;
                }
                
                
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"03"]) {
                gcjc.lanqiubool = NO;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumZongJinQiuShuDanGuan;
                }else{
                    gcjc.matchenum = matchenumZongJinQiuShu;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"05"]) {
                gcjc.lanqiubool = NO;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumBiFenDanGuan;
                }else{
                    gcjc.matchenum = matchEnumBiFenGuoguan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"06"]) {
                gcjc.lanqiubool = YES;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumShengFuDanGuan;
                }else{
                    gcjc.matchenum = matchEnumShengFuGuoguan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"07"]) {
                gcjc.lanqiubool = YES;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumRangFenShengFuDanGuan;
                }else{
                    gcjc.matchenum = matchEnumRangFenShengFuGuoguan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"08"]) {
                gcjc.lanqiubool = YES;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumShengFenChaDanGuan;
                }else{
                    gcjc.matchenum = matchEnumShengFenChaGuoguan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"09"]) {
                gcjc.lanqiubool = YES;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumDaXiaoFenDanGuan;
                }else{
                    gcjc.matchenum = matchEnumDaXiaFenGuoguan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"10"]) {
                gcjc.lanqiubool = NO;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumShengPingFuDanGuan;
                }else{
                    
                    gcjc.matchenum = matchEnumShengPingFuGuoGuan;
                }
            }else if ([BetDetailInfo.wanfaId isEqualToString:@"01"]) {
                gcjc.lanqiubool = NO;
                if ([BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                    gcjc.matchenum = matchEnumRangQiuShengPingFuDanGuan;
                }else{
                    
                    gcjc.matchenum = matchEnumRangQiuShengPingFuGuoGuan;
                }
            }
            
            NSLog(@"xxx = %@", BetDetailInfo.wanfaId);
            
            
            [self.navigationController pushViewController:gcjc animated:YES];
            [gcjc release];
            //bianjibool = NO;
            
        }else if([BetDetailInfo.lotteryId isEqualToString:@"400"]){
            GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
            bjdanchang.chaodanbool = YES;
            bjdanchang.issString = qihaostring;
            NSLog(@"qihao = %@", qihaostring);
            bjdanchang.betrecorinfo = BetDetailInfo;
            
            [self.navigationController pushViewController:bjdanchang animated:YES];
            [bjdanchang release];
            
            
        }else  if ([BetDetailInfo.lotteryId isEqualToString:@"300"]){
            
            
            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            bet.betrecorinfo = BetDetailInfo;
            bet.issString = qihaostring;
            bet.bettingstype = bettingStypeShisichang;
            bet.chaodanbool = YES;
            
            // NSString * str = [NSString stringWithFormat:@"20%@",cell.myrecord.curIssue];
            //  bet.issString = str;//期号
            [self.navigationController pushViewController:bet animated:YES];
            [bet release];
            
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){//任九
            NSLog(@"bbbbbbb");
            
            NSLog(@"bbbb = %@", self.BetDetailInfo.betContentArray);
            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            bet.betrecorinfo = BetDetailInfo;
            bet.bettingstype = bettingStypeRenjiu;
            bet.issString = qihaostring;
            bet.chaodanbool = YES;
            //            NSString * strr = [NSString stringWithFormat:@"20%@",cell.myrecord.curIssue];
            //            bet.issString = strr;//期号
            [self.navigationController pushViewController:bet animated:YES];
            [bet release];
            
            
        }
        
        
        
        
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //    if ([textField.text intValue] >= 99999) {
    //        numtextfield.text = @"99999";
    //    }
    NSLog(@"a = %@", string);
    
    if (jingcai) {
        
        if ([beitou.text length] == 4) {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if ([jianp intValue] >= 29999) {
                beitou.text = @"29999";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([jianp length] > 5){
                
                beitou.text = @"29999";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
        
        
    }else if(fenzhong == beijingdanchang||fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == ayjinyintong|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
        
        if ([beitou.text length] == 4) {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if ([jianp intValue] >= 10000) {
                beitou.text = @"10000";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([jianp length] > 5){
                
                beitou.text = @"10000";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
    }else {
        
        if ([beitou.text length] == 1) {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if ([jianp intValue] >= 99) {
                beitou.text = @"99";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
        }else {
            NSString * jianp = [NSString stringWithFormat:@"%@%@", beitou.text , string];
            if([jianp length] > 2){
                
                beitou.text = @"99";
                maxmoney = YES;
            }else{
                maxmoney = NO;
            }
            
            
        }
        
        
    }
    
    
    
    
    return YES;
}

- (void)pressgongkai:(UIButton *)sender{
    //    if (sender.tag == 0) {
    //        sender.tag = 1;
    //        buttoncuston.enabled = NO;
    //        buttonright.enabled = NO;
    betInfo.baomiType = BaoMiTypeGongKai;
    baomileixing = 0;
    leftimage.image = UIImageGetImageFromName(@"login_right.png");
    cuimage.image = UIImageGetImageFromName(@"login_right_0.png");
    rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //}
    //    else{
    //        sender.tag = 0;
    //        buttoncuston.enabled = YES;
    //        buttonright.enabled = YES;
    //
    //        leftimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //    }
}

- (void)pressbomi:(UIButton *)sender{
    //    if (sender.tag == 0) {
    //        sender.tag = 1;
    //        buttonright.enabled = NO;
    //        buttonleft.enabled = NO;
    betInfo.baomiType = BaoMiTypeBaoMi;
    baomileixing = 1;
    cuimage.image = UIImageGetImageFromName(@"login_right.png");
    leftimage.image = UIImageGetImageFromName(@"login_right_0.png");
    rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //    }
    //    else{
    //        buttonright.enabled = YES;
    //        buttonleft.enabled = YES;
    //        sender.tag = 0;
    //
    //        cuimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //    }
    
}

- (void)pressinshen:(UIButton *)sender {
    betInfo.baomiType = BaoMiTypeYinShen;
    baomileixing = 4;
    yinshenImage.image = UIImageGetImageFromName(@"login_right.png");
    rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    
    leftimage.image = UIImageGetImageFromName(@"login_right_0.png");
    cuimage.image = UIImageGetImageFromName(@"login_right_0.png");
}

- (void)pressjiezhi:(UIButton *)sender{
    //    if (sender.tag == 0) {
    //        sender.tag = 1;
    //        buttonleft.enabled = NO;
    //        buttoncuston.enabled = NO;
    betInfo.baomiType = BaoMiTypeJieZhi;
    baomileixing = 2;
    rigimage.image = UIImageGetImageFromName(@"login_right.png");
    
    leftimage.image = UIImageGetImageFromName(@"login_right_0.png");
    cuimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //  rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //    }
    //    else{
    //        buttonleft.enabled = YES;
    //        buttoncuston.enabled = YES;
    //        sender.tag = 0;
    //
    //        rigimage.image = UIImageGetImageFromName(@"login_right_0.png");
    //    }
    
}

- (void)getBettingInfo
{
    int zhuihaoCount = 1;
    if (betInfo.betlist) {
        [betInfo.betlist removeAllObjects];
    } else {
        betInfo.betlist = [NSMutableArray arrayWithCapacity:zhuihaoCount];
    }
    for (int i = 0; i < zhuihaoCount; i++) {
        NSNumber *mul = [NSNumber numberWithUnsignedInteger:[beitou.text intValue]];
        [betInfo.betlist addObject:mul];
    }
    betInfo.payMoney = betInfo.prices * zhuihaoCount;
    NSLog(@"money = %i", betInfo.payMoney);
    betInfo.zhuihaoType = 0;
}

- (NSString *)hunheItemFunc:(GC_BetData *)be array:(NSMutableArray *)bifenarr {
    NSString * oneStr = @"";
    NSString * strpin = @"";
    for (int i = 0; i < 3; i++) {//胜平负
        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            oneStr = [NSString stringWithFormat:@"%@%@,", oneStr, [bifenarr objectAtIndex:i]];
        }
        
    }
    
    NSString * twoStr = @"";
    for (int i = 3; i < 6; i++) {//让球胜平负
        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            twoStr = [NSString stringWithFormat:@"%@%@,", twoStr, [bifenarr objectAtIndex:i]];
        }
        
    }
    
    if ([oneStr length] > 0) {
        oneStr = [oneStr substringToIndex:[oneStr length]-1];
        if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
            
            
            //            if (oneDoubleBool) {
            strpin = [NSString stringWithFormat:@"%@:%@:[", be.changhao, be.numzhou];
            //            }else{
            //                strpin = [NSString stringWithFormat:@"%@:%@|10:[", be.changhao, be.numzhou];
            //            }
            
            
        }else{
            strpin = [NSString stringWithFormat:@"%@:%@|10:[", be.changhao, be.numzhou];
        }
        
        strpin = [NSString stringWithFormat:@"%@%@", strpin, oneStr];
        strpin = [NSString stringWithFormat:@"%@]/", strpin];
        NSLog(@"strping = %@", strpin);
        
    }
    if([twoStr length] > 0){
        twoStr = [twoStr substringToIndex:[twoStr length]-1];
        if ([oneStr length]) {
            strpin = [strpin substringToIndex:[strpin length]-1];
            strpin = [NSString stringWithFormat:@"%@-01:[",strpin];
        }
        else {
            if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
                //                if (oneDoubleBool) {
                strpin = [NSString stringWithFormat:@"%@:%@:[", be.changhao, be.numzhou];
                //                }else{
                //                    strpin = [NSString stringWithFormat:@"%@:%@|01:[", be.changhao, be.numzhou];
                //                }
                
            }else{
                strpin = [NSString stringWithFormat:@"%@:%@|01:[", be.changhao, be.numzhou];
            }
            
        }
        
        strpin = [NSString stringWithFormat:@"%@%@", strpin, twoStr];
        strpin = [NSString stringWithFormat:@"%@]/", strpin];
        NSLog(@"strping = %@", strpin);
        
    }
    return strpin;
}

// 已选项目集合
-(NSString*)chosedGameSet{
    
    if (fenzhong == jingcaihuntou||fenzhong == jingcaibifen || fenzhong == zongjinqiushu || fenzhong == banquanchangshengpingfu||fenzhong == jingcailanqiushengfencha || fenzhong == lanqiuhuntou || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang || fenzhong == beidanbifen || fenzhong == beidanbanquanchang||fenzhong == jingcaidahuntou) {
        
        NSMutableArray * bifenarr;
        if (fenzhong == jingcaibifen) {
            bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
        }else if(fenzhong == zongjinqiushu){
            bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
        }else if(fenzhong == banquanchangshengpingfu){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
        }else if(fenzhong == jingcailanqiushengfencha){
            bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
        }else if(fenzhong == jingcaihuntou){
            
            bifenarr = [NSMutableArray arrayWithObjects:@"胜",@"平", @"负", @"胜", @"平", @"负", nil];
        }else if(fenzhong == lanqiuhuntou){
            bifenarr = [NSMutableArray arrayWithObjects:@"主负", @"主胜", @"让分主负", @"让分主胜",@"大", @"小",@"主胜1#5", @"主胜6#10", @"主胜11#15", @"主胜16#20", @"主胜21#25", @"主胜26+",@"客胜1#5", @"客胜6#10", @"客胜11#15", @"客胜16#20", @"客胜21#25", @"客胜26+", nil];
            
        }else if (fenzhong == beidanjinqiushu){
            
            bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
            
        }else if (fenzhong == beidanshangxiadanshuang){
            
            bifenarr = [NSMutableArray arrayWithObjects:@"上单", @"上双", @"下单", @"下双", nil];
        }else if (fenzhong == beidanbifen){
            bifenarr = [NSMutableArray arrayWithObjects:@"1:0", @"2:0", @"2:1", @"3:0", @"3:1", @"3:2", @"4:0", @"4:1", @"4:2", @"胜其他", @"0:0", @"1:1", @"2:2", @"3:3", @"平其他", @"0:1", @"0:2", @"1:2", @"0:3", @"1:3", @"2:3", @"0:4", @"1:4", @"2:4",  @"负其他", nil];
        }else if(fenzhong == beidanbanquanchang){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜*胜", @"胜*平", @"胜*负", @"平*胜",@"平*平", @"平*负", @"负*胜", @"负*平", @"负*负", nil];
        }else if (fenzhong == jingcaidahuntou){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜", @"平", @"负", @"让胜", @"让平", @"让负",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负",  nil];
        }
        
        NSString * pinchuan = @"";
        for (GC_BetData * be in bettingArray) {
            BOOL zhongjiebool = NO;
            NSString * strpin = @"";
            for (int i = 0; i < [be.bufshuarr count]; i++) {
                if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    zhongjiebool = YES;
                    break;
                }
            }
            
            
            if (zhongjiebool) {
                
                
                
                if (fenzhong == jingcaidahuntou) {
                    
                    NSString * oneStr = @"";
                    for (int i = 0; i < 3; i++) {//胜平负
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            oneStr = [NSString stringWithFormat:@"%@%@,", oneStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * twoStr = @"";
                    for (int i = 3; i < 6; i++) {//让球胜平负
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            twoStr = [NSString stringWithFormat:@"%@%@,", twoStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * threeStr = @"";
                    for (int i = 6; i < 14; i++) {//总进球
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            threeStr = [NSString stringWithFormat:@"%@%@,", threeStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * fourStr = @"";
                    for (int i = 14; i < 45; i++) {//比分
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            fourStr = [NSString stringWithFormat:@"%@%@,", fourStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * fiveStr = @"";
                    for (int i = 45; i < 54; i++) {//半全场
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            fiveStr = [NSString stringWithFormat:@"%@%@,", fiveStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    if ([oneStr length] > 0) {
                        oneStr = [oneStr substringToIndex:[oneStr length]-1];
                        strpin = [NSString stringWithFormat:@"%@:%@|10:[", be.changhao, be.numzhou];
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, oneStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([twoStr length] > 0){
                        twoStr = [twoStr substringToIndex:[twoStr length]-1];
                        if ([oneStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-01:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|01:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, twoStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([threeStr length] > 0){
                        threeStr = [threeStr substringToIndex:[threeStr length]-1];
                        if ([twoStr length]||[oneStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-03:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|03:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, threeStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([fourStr length] > 0){
                        fourStr = [fourStr substringToIndex:[fourStr length]-1];
                        if ([threeStr length] || [oneStr length] || [twoStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-05:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|05:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, fourStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    
                    if([fiveStr length] > 0){
                        fiveStr = [fiveStr substringToIndex:[fiveStr length]-1];
                        if ([threeStr length] || [oneStr length] || [twoStr length] || [fourStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-04:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|04:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, fiveStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                }else if (fenzhong == jingcaihuntou) {//混投拼串
                    
                    strpin = [NSString stringWithFormat:@"%@", [self hunheItemFunc:be array:bifenarr ]] ;
                    
                    
                    
                }else if(fenzhong == lanqiuhuntou){
                    
                    NSString * oneStr = @"";
                    for (int i = 0; i < 2; i++) {//胜负
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            oneStr = [NSString stringWithFormat:@"%@%@,", oneStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * twoStr = @"";
                    for (int i = 2; i < 4; i++) {//让分胜负
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            twoStr = [NSString stringWithFormat:@"%@%@,", twoStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * threeStr = @"";
                    for (int i = 4; i < 6; i++) {//大小分
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            threeStr = [NSString stringWithFormat:@"%@%@,", threeStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    NSString * fourStr = @"";
                    for (int i = 6; i < 18; i++) {//胜分差
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            fourStr = [NSString stringWithFormat:@"%@%@,", fourStr, [bifenarr objectAtIndex:i]];
                        }
                        
                    }
                    
                    if ([oneStr length] > 0) {
                        oneStr = [oneStr substringToIndex:[oneStr length]-1];
                        strpin = [NSString stringWithFormat:@"%@:%@|06:[", be.changhao, be.numzhou];
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, oneStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([twoStr length] > 0){
                        twoStr = [twoStr substringToIndex:[twoStr length]-1];
                        if ([oneStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-07:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|07:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, twoStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([threeStr length] > 0){
                        threeStr = [threeStr substringToIndex:[threeStr length]-1];
                        if ([twoStr length]||[oneStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-09:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|09:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, threeStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    if([fourStr length] > 0){
                        fourStr = [fourStr substringToIndex:[fourStr length]-1];
                        if ([threeStr length] || [oneStr length] || [twoStr length]) {
                            strpin = [strpin substringToIndex:[strpin length]-1];
                            strpin = [NSString stringWithFormat:@"%@-08:[",strpin];
                        }
                        else {
                            strpin = [NSString stringWithFormat:@"%@:%@|08:[", be.changhao, be.numzhou];
                        }
                        
                        strpin = [NSString stringWithFormat:@"%@%@", strpin, fourStr];
                        strpin = [NSString stringWithFormat:@"%@]/", strpin];
                        NSLog(@"strping = %@", strpin);
                        
                    }
                    
                    
                }else{
                    if (fenzhong != beijingdanchang && fenzhong != beidanbifen && fenzhong != beidanjinqiushu && fenzhong != beidanbanquanchang && fenzhong != beidanshangxiadanshuang&&fenzhong != beidanshengfuguoguan) {
                        
                        strpin = [NSString stringWithFormat:@"%@:%@:[", be.changhao, be.numzhou];
                    }else{
                        strpin = [NSString stringWithFormat:@"%@:[", be.changhao];
                    }
                    
                    
                    for (int i = 0; i < [be.bufshuarr count]; i++) {
                        if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            strpin = [NSString stringWithFormat:@"%@%@,", strpin, [bifenarr objectAtIndex:i]];
                        }
                    }
                    
                    if ([strpin length] > 0) {
                        strpin = [strpin substringToIndex:[strpin length]-1];
                    }
                    strpin = [NSString stringWithFormat:@"%@]/", strpin];
                    NSLog(@"strping = %@", strpin);
                    
                }
                
                
                
                
            }
            pinchuan = [NSString stringWithFormat:@"%@%@", pinchuan, strpin];
            
            
        }
        pinchuan = [pinchuan substringToIndex:[pinchuan length] - 1];
        NSLog(@"strpin = %@", pinchuan);
        return pinchuan;
        
        
    }else if(fenzhong == jingcaihuntouerxuanyi){
        rightBool = NO;
        NSString * pinchuan = @"";
        
        for (GC_BetData * be in bettingArray) {
            
            NSString *strpin = @"";
            
            NSArray * teamArray = [be.team componentsSeparatedByString:@","];
            
            if ([teamArray count] < 3) {
                rightBool = YES;
                return @"";
            }
            
            
            if ((![[teamArray objectAtIndex:2] isEqualToString:@"+1"]) && (![[teamArray objectAtIndex:2] isEqualToString:@"-1"])) {
                rightBool = YES;
                return @"";
            }
            
            
            
            if ([[teamArray objectAtIndex:2] intValue] > 0) {
                
                if (be.selection1 && be.selection2 == NO) {
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|01:[胜]/", be.changhao, be.numzhou];
                    //                    pinchuan = [NSString stringWithFormat:@"%@:%@|10:[]/", be.changhao, be.numzhou];//非让球
                    //[NSString stringWithFormat:@"%@:%@|01:[", be.changhao, be.numzhou];//让球
                    
                }else if (be.selection1 == NO && be.selection2){
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|10:[负]/", be.changhao, be.numzhou];
                    
                }else if (be.selection1 && be.selection2){
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|01:[胜]-10:[负]/", be.changhao, be.numzhou];
                    
                }
                
            }else{
                
                
                if (be.selection1 && be.selection2 == NO) {
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|10:[胜]/", be.changhao, be.numzhou];
                    
                }else if (be.selection1 == NO && be.selection2){
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|01:[负]/", be.changhao, be.numzhou];
                    
                }else if (be.selection1 && be.selection2){
                    
                    strpin = [NSString stringWithFormat:@"%@:%@|10:[胜]-01:[负]/", be.changhao, be.numzhou];
                    
                }
                
            }
            pinchuan = [NSString stringWithFormat:@"%@%@", pinchuan, strpin];
        }
        
        
        pinchuan = [pinchuan substringToIndex:[pinchuan length] - 1];
        NSLog(@"strpin = %@", pinchuan);
        return pinchuan;
        
        
    }else{
        if (bettingArray&&bettingArray.count) {
            NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
            for (int i = 0; i < [bettingArray count]; i++) {
                if (fenzhong == aydiyiming) {
                    
                }
                else if (fenzhong == ayjinyintong) {
                    
                }
                else {
                    GC_BetData * da = [bettingArray objectAtIndex:i];
                    NSLog(@"da.sele = %d  %d  %d", da.selection1, da.selection2, da.selection3);
                    
                    if (da.selection1 || da.selection2 || da.selection3) {
                        [str appendString:da.changhao];
                        [str appendString:@":"];
                        
                        if (fenzhong == ayshengfuguogan) {
                            
                        }else{
                            if (fenzhong != beijingdanchang && fenzhong != beidanbifen && fenzhong != beidanjinqiushu && fenzhong != beidanbanquanchang && fenzhong != beidanshangxiadanshuang&& fenzhong != beidanshengfuguoguan) {
                                [str appendString:da.numzhou];
                                [str appendString:@":"];
                            }
                            
                        }
                        
                        
                        
                        [str appendString:@"["];
                        if (fenzhong == ayshengfuguogan || fenzhong == jingcailanqiushengfu) {
                            if (da.selection1 && da.selection2 == NO) {
                                [str appendString:@"主负"];
                            }
                            if (da.selection2 && da.selection1 == NO) {
                                [str appendString:@"主胜"];
                            }
                            
                            if (da.selection1 && da.selection2) {
                                [str appendString:@"主负,主胜"];
                            }
                            
                            
                        }else if(fenzhong == jingcailanqiudaxiaofen){
                            
                            if (da.selection1 && da.selection2 == NO) {
                                [str appendString:@"大"];
                            }
                            if (da.selection2 && da.selection1 == NO) {
                                [str appendString:@"小"];
                            }
                            
                            if (da.selection1 && da.selection2) {
                                [str appendString:@"大,小"];
                            }
                            
                        }else if(fenzhong == jingcailanqiurangfenshengfu){
                            if (da.selection1 && da.selection2 == NO) {
                                [str appendString:@"让分主负"];
                            }
                            if (da.selection2 && da.selection1 == NO) {
                                [str appendString:@"让分主胜"];
                            }
                            
                            if (da.selection1 && da.selection2) {
                                [str appendString:@"让分主负,让分主胜"];
                            }
                            
                        }else if(fenzhong == beidanshengfuguoguan){
                            
                            if (da.selection1 && da.selection2 == NO) {
                                [str appendString:@"胜"];
                            }
                            if (da.selection2 && da.selection1 == NO) {
                                [str appendString:@"负"];
                            }
                            
                            if (da.selection1 && da.selection2) {
                                [str appendString:@"胜,负"];
                            }
                            
                        }else{
                            if (da.selection1 && da.selection2 == NO && da.selection3 == NO) {
                                [str appendString:@"胜"];
                            }
                            if (da.selection2 && da.selection1 == NO && da.selection3 == NO) {
                                [str appendString:@"平"];
                            }
                            if (da.selection3 && da.selection2 == NO && da.selection1 == NO) {
                                [str appendString:@"负"];
                            }
                            if (da.selection1 && da.selection2 && da.selection3 == NO) {
                                [str appendString:@"胜,平"];
                            }
                            if (da.selection1==NO && da.selection2 && da.selection3 ) {
                                [str appendString:@"平,负"];
                            }
                            if (da.selection1 && da.selection2==NO && da.selection3) {
                                [str appendString:@"胜,负"];
                            }
                            if (da.selection1 && da.selection2 && da.selection3) {
                                [str appendString:@"胜,平,负"];
                            }
                            
                        }
                        
                        
                        [str appendString:@"]"];
                        
                        [str appendString:@"/"];
                        
                    }
                }
                
            }
            [str setString:[str substringToIndex:[str length] - 1]];
            NSLog(@"str = %@", str);
            return str;
        }
        
        
    }
    
    
    
    return nil;
    
}
-(int)maxGameID{
    
    NSMutableArray * arraymu = [[NSMutableArray alloc] initWithCapacity:0];
    if (fenzhong == jingcaibifen || fenzhong == jingcailanqiushengfencha||fenzhong == jingcaihuntou || fenzhong == lanqiuhuntou || fenzhong == jingcaidahuntou) {
        
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * da = [bettingArray objectAtIndex:i];
            
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    
                    [arraymu addObject:da];
                    break;
                }
            }
            
            
        }
        
        
        
    }else{
        
        for (GC_BetData * bee in bettingArray) {
            if (bee.selection1 || bee.selection2 || bee.selection3) {
                [arraymu addObject:bee];
            }
        }
        
        
        
    }
    
    
    
    
    
    
    if (arraymu&&arraymu.count) {
        int max = 0;
        for (int i= 0; i<arraymu.count; i++) {
            GC_BetData * da = [arraymu objectAtIndex:i];
            
            if ([da.changhao intValue] > max) {
                max = [da.changhao intValue];
            }
        }
        [arraymu release];
        return max;
    }
    
    [arraymu release];
    return 0;
    
}


-(int)minGameID{
    NSMutableArray * arraymu = [[NSMutableArray alloc] initWithCapacity:0];
    if (fenzhong == jingcaibifen || fenzhong == jingcailanqiushengfencha || fenzhong == jingcaihuntou || fenzhong == lanqiuhuntou || fenzhong == jingcaidahuntou) {
        
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * da = [bettingArray objectAtIndex:i];
            
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    
                    [arraymu addObject:da];
                    break;
                }
            }
            
            
        }
        
        
        
    }else{
        
        for (GC_BetData * bee in bettingArray) {
            if (bee.selection1 || bee.selection2 || bee.selection3) {
                [arraymu addObject:bee];
            }
        }
        
        
        
    }
    if (arraymu&&arraymu.count) {
        int min = 99999999;
        for (int i= 0; i<arraymu.count; i++) {
            GC_BetData * da = [arraymu objectAtIndex:i];
            
            if ([da.changhao intValue] < min) {
                min = [da.changhao intValue];
            }
        }
        [arraymu release];
        return min;
    }
    [arraymu release];
    return 0;
}

// 彩种+过关方式+竞猜消息+注数+.....

- (NSString *)passTypeSetAndchosedGameSetGuanYaJun{
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    NSInteger zong = 1;
    int zongchang = 0;
    int lotterType = 0;
    NSString *passTypeSet = @"单关";
    NSString * gyjStr = @"";
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    if(fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa){
        
        //        zong = [dataAr count];
        zongchang = (int)[dataAr count];
        
    }
    if (fenzhong == guanjunwanfa){
        lotterType = 43;
        gyjStr = [NSString stringWithFormat:@"冠军%@", matchId];
    }else if (fenzhong == guanyajunwanfa){
        lotterType = 44;
        gyjStr = [NSString stringWithFormat:@"冠亚%@", matchId];
    }
    int beishu = [beitou.text intValue];
    [str appendFormat:@"%d", (int)lotterType];
    [str appendString:@"^"];
    [str appendString:passTypeSet];
    [str appendString:@"^"];
    [str appendString:championData.matchId];
    [str appendString:@":"];
    [str appendString:gyjStr];
    [str appendString:@":"];
    [str appendString:@"["];
    NSArray * teamNumArray = [championData.teamNum componentsSeparatedByString:@","];
    NSString * caiguoString = @"";
    for (int i = 0; i < [championData.typeArray count]; i++) {
        if ([[championData.typeArray objectAtIndex:i] isEqualToString:@"1"]) {
            if ([teamNumArray count] > i) {
                caiguoString = [NSString stringWithFormat:@"%@%@,", caiguoString,[teamNumArray objectAtIndex:i]];
            }
        }
    }
    if ([caiguoString length] > 0) {
        caiguoString = [caiguoString substringToIndex:[caiguoString length] - 1];
    }
    [str appendString:caiguoString];
    [str appendString:@"]"];
    [str appendString:@"^"];
    
    [str appendString:zhushu];
    betInfo.bets = [zhushu intValue];
    [str appendString:@"^"];
    [str appendFormat:@"%d",beishu];
    betInfo.multiple = beishu;
    [str appendString:@"^"];
    NSString * app = [NSString stringWithFormat: @"%d", [beitou.text intValue]*[zhushu intValue]*2];
    [str appendString:app];
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)zong];
    [str appendFormat:@"^"];
    [str appendFormat:@"%d",zongchang];// 为何是0
    [str appendString:@"^"];
    //    [str appendFormat:@"%d",min]; ddd0000//为空
    [str appendString:@"^"];
    //    [str appendFormat:@"%d",max];dddd000//为空
    [str appendString:@"^"];
    [str appendFormat:@"%d",0];
    
    NSLog(@"xxxguanyajun = %@", str);
    return str;
    
}

- (NSString*)passTypeSetAndchosedGameSet
{
    NSInteger zong = 0;
    int zongchang = 0;
    
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    
    if (fenzhong == jingcaihuntou||fenzhong == jingcaibifen || fenzhong == jingcailanqiushengfencha || fenzhong == jingcaidahuntou) {
        
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * da = [bettingArray objectAtIndex:i];
            BOOL zhongjiebool = NO;
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    zhongjiebool = YES;
                    break;
                }
            }
            if (zhongjiebool) {
                zongchang++;
            }
            
        }
        
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * da = [bettingArray objectAtIndex:i];
            
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    zong++;
                    
                }
            }
            
        }
        
        
    }else{
        
        for (GC_BetData * bee in bettingArray) {
            if (bee.selection1 || bee.selection2 || bee.selection3) {
                zong++;
            }
        }
        
        for (GC_BetData * bie in bettingArray) {
            if (bie.selection1) {
                zongchang++;
            }
            if (bie.selection2) {
                zongchang++;
            }
            if (bie.selection3) {
                zongchang++;
            }
        }
        
        
    }
    NSLog(@"%d", zongchang);
    
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    NSInteger lotterType = TYPE_JINGCAI_ZQ_2;
    if (fenzhong == jingcaibifen) {
        lotterType = TYPE_JINGCAI_ZQ_2;
    }else if(fenzhong == jingcaipiao){
        lotterType = 49;
    }else if(fenzhong == banquanchangshengpingfu){
        lotterType = TYPE_JINGCAI_ZQ_4;
    }else if(fenzhong == zongjinqiushu){
        lotterType = TYPE_JINGCAI_ZQ_3;
    }else if(fenzhong == jingcailanqiushengfu){
        lotterType = TYPE_JINGCAI_LQ_1;
    }else if(fenzhong == jingcailanqiurangfenshengfu){
        lotterType = TYPE_JINGCAI_LQ_2;
    }else if(fenzhong == jingcailanqiushengfencha){
        lotterType = TYPE_JINGCAI_LQ_3;
    }else if(fenzhong == jingcailanqiudaxiaofen){
        lotterType = TYPE_JINGCAI_LQ_4;
    }else if(fenzhong == jingcairangfenshengfu){
        lotterType = 49;
    }else if(fenzhong == jingcaihuntou || fenzhong == jingcaihuntouerxuanyi || fenzhong == jingcaidahuntou){
        
        lotterType = 47;
        
        if (fenzhong == jingcaihuntou) {
            
            if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
                if (oneSPFCount == 1) {
                    lotterType = 49;
                }else if (oneSPFCount == 2){
                    lotterType = 22;
                }
                //                if (oneDoubleBool) { // 如果为单关
                //
                //
                //
                //                }
                
            }
        }
        
    }else if(fenzhong == lanqiuhuntou){
        
        lotterType = 48;
    }
    NSString *passTypeSet = @"";
    
    NSArray * arr = [zhushudict allKeys];
    
    for (int i = 0; i < [arr count]; i++) {
        NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        
        if (i!=arr.count-1){
            NSString * com = [arr objectAtIndex:i];
            //            if ([com isEqualToString:@"单关"]) {
            //
            //    }else{
            if ([com isEqualToString:@"单关"]) {
                //                    passTypeSet = @"单关^";
                passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            }else{
                
                NSArray * nsar = [com componentsSeparatedByString:@"串"];
                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            }
            
            
        }else{
            
            NSString * com = [arr objectAtIndex:i];
            
            if ([com isEqualToString:@"单关"]) {
                passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            }else{
                NSArray * nsar = [com componentsSeparatedByString:@"串"];
                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            }
            
            
            
        }
    }
    
    
    
    
    
    
    
    NSString *items = [self chosedGameSet];
    
    
    
    int min = [self minGameID];
    NSLog(@"min = %d", min);
    
    int max = [self maxGameID];
    int beishu = [beitou.text intValue];
    [str appendFormat:@"%d", (int)lotterType];
    betInfo.lotteryType = (int)lotterType;
    
    if (fenzhong == jingcailanqiudaxiaofen || fenzhong == jingcailanqiushengfencha || fenzhong == jingcailanqiurangfenshengfu||fenzhong == jingcailanqiushengfu ) {
        betInfo.caizhong = @"200";
        betInfo.lotteryId = @"200";
    }else if(fenzhong == jingcaihuntou || fenzhong == jingcaihuntouerxuanyi || fenzhong == jingcaidahuntou){
        betInfo.caizhong = @"202";
        betInfo.lotteryId = @"202";
        
        if (fenzhong == jingcaihuntou) {
            
            if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
                
                //                if (oneDoubleBool) { // 如果为单关
                
                if (oneSPFCount == 1) {
                    betInfo.caizhong = @"201";
                    betInfo.lotteryId = @"201";
                }else if (oneSPFCount == 2){
                    betInfo.caizhong = @"201";
                    betInfo.lotteryId = @"201";
                }
                
                //                }
                
            }
        }
    }else if(fenzhong == lanqiuhuntou){
        betInfo.caizhong = @"203";
        betInfo.lotteryId = @"203";
    }else{
        betInfo.caizhong = @"201";
        betInfo.lotteryId = @"201";
    }
    
    if (fenzhong == jingcaibifen) {
        betInfo.wanfa = @"05";
    }else if(fenzhong == jingcaipiao){
        betInfo.wanfa = @"10";
    }else if(fenzhong == zongjinqiushu){
        betInfo.wanfa = @"03";
    }else if(fenzhong == banquanchangshengpingfu){
        betInfo.wanfa = @"04";
    }else if(fenzhong == jingcailanqiushengfu){
        betInfo.wanfa = @"06";
    }else if(fenzhong == jingcailanqiurangfenshengfu){
        betInfo.wanfa = @"07";
    }else if(fenzhong == jingcailanqiushengfencha){
        betInfo.wanfa = @"08";
    }else if(fenzhong == jingcailanqiudaxiaofen){
        betInfo.wanfa = @"09";
    }else if(fenzhong == jingcairangfenshengfu){
        betInfo.wanfa = @"10";
    }else if(fenzhong == jingcaihuntou || fenzhong == jingcaihuntouerxuanyi || fenzhong == jingcaidahuntou){
        betInfo.wanfa = @"01";
        if (fenzhong == jingcaihuntou) {
            
            if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
                
                //                if (oneDoubleBool) { // 如果为单关
                
                if (oneSPFCount == 1) {
                    betInfo.wanfa = @"10";
                }else if (oneSPFCount == 2){
                    betInfo.wanfa = @"01";
                }
                
                //                }
                
            }
        }
    }else if(fenzhong == lanqiuhuntou){
        //    ddddd
        betInfo.wanfa = @"01";
        
    }
    
    [str appendString:@"^"];
    //    //[str appendFormat:@"%d",0];
    //    //[str appendString:@"^"];
    [str appendString:passTypeSet];
    [str appendString:items];
    [str appendString:@"^"];
    [str appendString:zhushu];
    betInfo.bets = [zhushu intValue];
    [str appendString:@"^"];
    [str appendFormat:@"%d",beishu];
    betInfo.multiple = beishu;
    [str appendString:@"^"];
    NSString * app = [NSString stringWithFormat: @"%d", [beitou.text intValue]*[zhushu intValue]*2];
    [str appendString:app];
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)zong];
    [str appendFormat:@"^"];
    [str appendFormat:@"%d",zongchang];
    [str appendString:@"^"];
    [str appendFormat:@"%d",min];
    [str appendString:@"^"];
    [str appendFormat:@"%d",max];
    [str appendString:@"^"];
    //    if (dan)
    //        [str appendString:[self danGameIdSet]];
    //    else
    NSString * danstrss = @"";
    for (GC_BetData * bata in bettingArray) {
        if (bata.dandan) {
            //[str appendFormat:@"%@^",bata.changhao];
            danstrss = [NSString stringWithFormat:@"%@%@,", danstrss, bata.changhao];
        }
    }
    if ([danstrss length] > 0) {
        danstrss =  [danstrss substringToIndex:[danstrss length] -1];
        [str appendFormat:@"%@^", danstrss];
    }
    
    //    [str setString:[str substringToIndex:[str length] - 1]];
    [str appendFormat:@"%d",0];
    [str appendString:@"^"];
    [str appendFormat:@"%d",0];
    NSLog(@"str = %@", str);
    
    NSLog(@"str ==== %@", str);
    
    if (fenzhong == jingcaihuntouerxuanyi) {
        [str appendString:@"^jc2x1"];
    }
    
    betInfo.betNumber = str;
    
    [self lastMatchId];
    
    return str;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.text = @"";
    return YES;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if ([textField.text intValue] > 99) {
//        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//        [cai showMessage:@"最多只能投注99"];
//        numtextfield.text = @"99";
//    }
//}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"string = %@", string);
//    NSLog(@"str = %d",[string intValue]);
//    if ([string length] > 3) {
//        NSString * sss = [string substringWithRange:NSMakeRange(0, 3)];
//        NSLog(@"sss = %@", sss);
//    }
//
//    NSLog(@"text = %@", numtextfield.text);
//    if ([numtextfield.text intValue] > 99) {
//        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//        [cai showMessage:@"最多只能投注99"];
//        numtextfield.text = @"99";
//    }
//    return YES;
//}

- (void)aoyunJinYinTong {
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    
    //    NSInteger lotterType = TYPE_JINGCAI_ZQ_1;
    
    
    
    
    NSString *items = @"";
    for (AoyunMatchInfo *mach in bettingArray) {
        if ([mach.selectNum length]) {
            NSString *select = mach.selectNum;
            select = [select stringByReplacingOccurrencesOfString:@"," withString:@"@"];
            select = [select stringByReplacingOccurrencesOfString:@"|" withString:@","];
            items = [NSString stringWithFormat:@"%@%d:[%@]/",items,(int)mach.matchNum,select];
        }
    }
    if ([items length] >0) {
        items = [items substringToIndex:[items length] - 1];
    }
    int beishu = [beitou.text intValue];
    
    if ([zhushu intValue] > 1) {
        [str appendString:@"02#"];
    }else{
        [str appendString:@"01#"];
    }
    
    
    [str appendFormat:@"%@^", items];
    [str appendString:@"单关"];
    [str appendString:@"400^"];
    betInfo.multiple = beishu;
    [str appendFormat:@"%d", beishu];
    
    
    
    NSLog(@"str = %@", issString);
    betInfo.issue = issString;
    betInfo.betNumber = str;
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    NSLog(@"isss = %@", issString);
    betInfo.issue = issString;
    betInfo.caizhong = @"400";
    betInfo.lotteryId = @"400";
    betInfo.wanfa = @"08";
    betInfo.stopMoney = @"0";
    
}

- (void)aoyunDiyiMing {
    NSInteger danshifu = 1;
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    
    //    NSInteger lotterType = TYPE_JINGCAI_ZQ_1;
    NSArray * arr = [zhushudict allKeys];
    NSString *passTypeSet = @"";
    for (int i = 0; i < [arr count]; i++) {
        NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        
        if (i!=arr.count-1){
            NSString * com = [arr objectAtIndex:i];
            passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            
            
            
        }else{
            NSString * com = [arr objectAtIndex:i];
            
            passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            
        }
    }
    
    
    
    
    
    NSString *items = @"";
    for (AoyunMatchInfo *mach in bettingArray) {
        NSInteger choseCount = 0;
        NSString *gameInfo = [NSString stringWithFormat:@"%d:[",(int)mach.matchNum];
        for (int i = 0; i< [mach.playerArray count];i ++){
            AoyunPlayer *player = [mach.playerArray objectAtIndex:i];
            if (player.isJin) {
                gameInfo = [NSString stringWithFormat:@"%@%d,",gameInfo,(int)player.playerId];
                choseCount = choseCount +1;
            }
        }
        
        gameInfo = [NSString stringWithFormat:@"%@]",[gameInfo substringToIndex:[gameInfo length] -1]];
        if (choseCount != 0) {
            items = [NSString stringWithFormat:@"%@%@/",items,gameInfo];
            danshifu = danshifu * choseCount;
        }
    }
    if ([items length] >0) {
        items = [items substringToIndex:[items length] - 1];
    }
    int beishu = [beitou.text intValue];
    
    if (danshifu > 1) {
        [str appendString:@"02#"];
    }else{
        [str appendString:@"01#"];
    }
    
    
    [str appendFormat:@"%@^", items];
    [str appendString:passTypeSet];
    [str appendString:@"400^"];
    betInfo.multiple = beishu;
    [str appendFormat:@"%d", beishu];
    
    
    
    NSLog(@"str = %@", issString);
    betInfo.issue = issString;
    betInfo.betNumber = str;
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    NSLog(@"isss = %@", issString);
    betInfo.issue = issString;
    betInfo.caizhong = @"400";
    betInfo.lotteryId = @"400";
    betInfo.wanfa = @"07";
    
    betInfo.stopMoney = @"0";
}

- (void)aoyunshengfutouzhu{
    NSInteger danshifu = 1;
    NSInteger zong = 0;
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    for (GC_BetData * bee in bettingArray) {
        if (bee.selection1 || bee.selection2 ) {
            zong++;
            danshifu = danshifu *(bee.selection1+bee.selection2);
        }
    }
    int zongchang = 0;
    for (GC_BetData * bie in bettingArray) {
        if (bie.selection1) {
            zongchang++;
        }
        if (bie.selection2) {
            zongchang++;
        }
        
    }
    NSLog(@"%d", zongchang);
    
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    
    //    NSInteger lotterType = TYPE_JINGCAI_ZQ_1;
    NSArray * arr = [zhushudict allKeys];
    NSString *passTypeSet = @"";
    for (int i = 0; i < [arr count]; i++) {
        NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        
        if (i!=arr.count-1){
            NSString * com = [arr objectAtIndex:i];
            //            if ([com isEqualToString:@"单关"]) {
            //
            //    }else{
            // NSArray * nsar = [com componentsSeparatedByString:@"串"];
            //  com = [NSString  stringWithFormat:@"%@串%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
            passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            
            
            
        }else{
            NSString * com = [arr objectAtIndex:i];
            //  NSArray * nsar = [com componentsSeparatedByString:@"串"];
            //  com = [NSString  stringWithFormat:@"%@串%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
            passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            
        }
    }
    
    
    
    
    
    NSString *items = [self chosedGameSet];
    //    int min = [self minGameID];
    //    NSLog(@"min = %d", min);
    
    //  int max = [self maxGameID];
    int beishu = [beitou.text intValue];
    
    if (danshifu > 1) {
        [str appendString:@"02#"];
    }else{
        [str appendString:@"01#"];
    }
    
    
    [str appendFormat:@"%@^", items];
    [str appendString:passTypeSet];
    [str appendString:@"311^"];
    betInfo.multiple = beishu;
    [str appendFormat:@"%d", beishu];
    
    
    //[str setString:[str substringToIndex:[str length] - 1]];
    
    
    
    //
    //   [str appendFormat:@"-%@", zhushu];
    NSLog(@"str = %@", issString);
    betInfo.issue = issString;
    betInfo.betNumber = str;
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    NSLog(@"isss = %@", issString);
    betInfo.issue = issString;
    betInfo.caizhong = @"400";
    betInfo.lotteryId = @"400";
    betInfo.wanfa = @"06";
    
    betInfo.stopMoney = @"0";
    
}


- (void)saveClearFunc{
    if (saveKey && [saveKey length] > 0) {
        NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
        [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:saveKey];
        [saveArray release];
    }
    
}


- (void)presstouzhubut{
    [MobClick event:@"event_goucai_touzhu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];

    if ([[[Info getInstance] userId] intValue] == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        return;
    }
    
    
    [self saveClearFunc];//只要点投注就清除数据
    
#ifdef isYueYuBan
    if(isHeMai){
        
    }else{
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否确定投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.tag = 119;
        [alert show];
        [alert release];
        return;
    }
    
    
#else
#endif
    [self querenpresstouzhubut];
    
    
    
    
}

- (void)beiDanTouZhu{
    
    NSInteger danshifu = 1;
    //    NSInteger zong = 0;
    if (!self.betInfo) {
        betInfo = [[GC_BetInfo alloc] init];
    }
    if (fenzhong == beijingdanchang||fenzhong == beidanshengfuguoguan) {
        for (GC_BetData * bee in bettingArray) {
            if (bee.selection1 || bee.selection2 || bee.selection3) {
                //                /zong++;
                danshifu = danshifu *(bee.selection1+bee.selection2+bee.selection3);
            }
        }
    }else{
        
        for (GC_BetData * bee in bettingArray) {
            danshifu = 0;
            for (int i = 0; i < [bee.bufshuarr count]; i++) {
                if ([[bee.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    danshifu += 1;
                }
            }
            if (danshifu > 1) {
                break;
            }
            
        }
    }
    
    //    int zongchang = 0;
    //    for (GC_BetData * bie in bettingArray) {
    //        if (bie.selection1) {
    //            zongchang++;
    //        }
    //        if (bie.selection2) {
    //            zongchang++;
    //        }
    //        if (bie.selection3) {
    //            zongchang++;
    //        }
    //    }
    
    
    
    //    NSLog(@"%d", zongchang);
    
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    
    NSArray * arr = [zhushudict allKeys];
    NSString *passTypeSet = @"";
    for (int i = 0; i < [arr count]; i++) {
        NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        
        if (i!=arr.count-1){
            NSString * com = [arr objectAtIndex:i];
            passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            
            
            
        }else{
            NSString * com = [arr objectAtIndex:i];
            passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            
        }
    }
    
    
    
    
    
    NSString *items = [self chosedGameSet];
    //    int min = [self minGameID];
    //    NSLog(@"min = %d", min);
    
    //  int max = [self maxGameID];
    int beishu = [beitou.text intValue];
    
    if (danshifu > 1) {
        [str appendString:@"02#"];
    }else{
        [str appendString:@"01#"];
    }
    
    
    [str appendFormat:@"%@^", items];
    [str appendString:passTypeSet];
    
    if (fenzhong == beijingdanchang) {
        [str appendString:@"200^"];
    }else if (fenzhong == beidanjinqiushu){
        [str appendString:@"230^"];
    }else if (fenzhong == beidanshangxiadanshuang){
        [str appendString:@"210^"];
    }else if (fenzhong == beidanbifen){
        [str appendString:@"250^"];
    }else if (fenzhong == beidanbanquanchang){
        [str appendString:@"240^"];
    }else if (fenzhong == beidanshengfuguoguan){
        [str appendString:@"270^"];
    }
    
    betInfo.multiple = beishu;
    [str appendFormat:@"%d@", beishu];
    //   BOOL danshifou = NO;
    for (GC_BetData * bata in bettingArray) {
        if (bata.dandan) {
            //         danshifou = YES;
            [str appendFormat:@"%@,",bata.changhao];
        }
    }
    
    
    [str setString:[str substringToIndex:[str length] - 1]];
    
    
    
    //
    //   [str appendFormat:@"-%@", zhushu];
    NSLog(@"str = %@", str);
    betInfo.betNumber = str;
    betInfo.price = [zhushu intValue]*2;
    betInfo.prices = [beitou.text intValue]*[zhushu intValue]*2;
    betInfo.payMoney = [beitou.text intValue]*[zhushu intValue]*2;
    NSLog(@"isss = %@", issString);
    betInfo.issue = issString;
    betInfo.caizhong = @"400";
    betInfo.lotteryId = @"400";
    if (fenzhong == beijingdanchang) {
        betInfo.wanfa = @"01";
    }else if (fenzhong == beidanjinqiushu){
        betInfo.wanfa = @"03";
    }else if (fenzhong == beidanshangxiadanshuang){
        betInfo.wanfa = @"02";
    }else if (fenzhong == beidanbifen){
        betInfo.wanfa = @"05";
    }else if (fenzhong == beidanbanquanchang){
        betInfo.wanfa = @"04";
    }else if (fenzhong == beidanshengfuguoguan){
        betInfo.wanfa = @"06";
    }
    
    
    
    
    betInfo.stopMoney = @"0";
    [self lastMatchId];
    
    
    
    
    
    
}


- (BOOL)typeFunc{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    NSString * typestr = [userArr objectAtIndex:2];
                    if ([typestr isEqualToString:@"1"]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            }
            
        }
        
    }
    return NO;
}
- (void)querenpresstouzhubut{
    
    //    [beitou resignFirstResponder];
    NSLog(@"isHeMai : %d",isHeMai);
    
    
    if ([beitou.text length]==0)
    {
        beitou.text = @"1";
    }
    NSLog(@"~~~%d",self.betInfo.baomiType);
    
    
    
    if (jingcai || fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa)
    {
        
        if (fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa) {
            [self passTypeSetAndchosedGameSetGuanYaJun];
        }else{
            [self passTypeSetAndchosedGameSet];
            if (fenzhong == jingcaihuntouerxuanyi) {
                if (rightBool) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:[NSString stringWithFormat:@"投注异常,请重新投注"]];
                    return;
                }
            }
        }
        
        if ([beitou.text intValue] < 1) {
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }else{
            
            NSInteger beishucount = 0;
            if (fenzhong == jingcaihuntou || fenzhong == jingcaihuntouerxuanyi|| fenzhong == lanqiuhuntou) {
                beishucount = 99999;
            }else if(fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa){
                beishucount = 10000;
            }else{
                beishucount = 29999;
            }
            
            if([beitou.text intValue] > beishucount){
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:[NSString stringWithFormat:@"最多一次只能投%d倍", (int)beishucount]];//@"最多一次只能投29999倍"];
                betInfo.prices = betInfo.price * (int)beishucount;
                betInfo.payMoney = betInfo.prices * 1;
                betInfo.beishu = beishucount;
                return;
            }
            else {
                betInfo.prices = betInfo.price * [beitou.text intValue];
                betInfo.payMoney = betInfo.prices * 1;
                betInfo.beishu = [beitou.text intValue];
            }
        }
        if (fenzhong == jingcaihuntou|| fenzhong == jingcaihuntouerxuanyi|| fenzhong == lanqiuhuntou ) {
            if ([beitou.text intValue] == 1 && betInfo.prices > 20000) {
                
                [[caiboAppDelegate getAppDelegate] showMessage:@"单倍最高投注金额不能超过2万元"];
                return;
                
                
            }
        }
        
        
        if (betInfo.prices > 100000&&(fenzhong == jingcailanqiushengfu||fenzhong == jingcailanqiurangfenshengfu||fenzhong == jingcailanqiushengfencha||fenzhong == jingcailanqiudaxiaofen||fenzhong == jingcaihuntou||fenzhong == jingcaihuntouerxuanyi|| fenzhong == lanqiuhuntou||fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa)) {
            
            [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过10万"];
            return;
        }
        if (betInfo.prices > 1500000) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过150万"];
            return;
        }
        
        
        
        
        //        if (betInfo.price >= 20000 && fenzhong == jingcaihuntou) {
        //            [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过2万"];
        //            return;
        //        }
        
        if (isHeMai) {
            NSLog(@"danfushi = %d", (int)danfushi);
            NSLog(@"issue = %@", betInfo.issue);
            betInfo.modeType = (int)danfushi;
            GCHeMaiSendViewController *send = [[GCHeMaiSendViewController alloc] init];
            NSLog(@"%d",betInfo.payMoney);
            send.betInfo = betInfo;
            send.saveKey = saveKey;
            send.isPutong = !chaodanbool;
            [self.navigationController pushViewController:send animated:YES];
            [send release];
            return;
        }
        
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            
            if ([self typeFunc]) {
                
                [self sleepPassWordViewShow];
                
            }else{
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 101;
                [alert show];
                [alert release];
                
            }
            
            
            
            return;
        }
        
        [self saveClearFunc];//只要点投注就清除数据
        
        [dataRequest clearDelegatesAndCancel];
        NSLog(@"baomitype = %d", (int)baomileixing);
        //   NSMutableData *postData = [[GC_HttpService sharedInstance] reqJingcaiBetting:[self passTypeSetAndchosedGameSet] baomi:baomileixing danfushi:danfushi];
        
        
        
        
        
#ifdef isYueYuBan
        NSString * keyString = [NSString stringWithFormat:@"%@@%d", [self passTypeSetAndchosedGameSet], [[Info getInstance] caipaocount] ];
        
#else
        NSString * keyString = @"";
        
        if (fenzhong == guanyajunwanfa || fenzhong == guanjunwanfa) {
            keyString = [self passTypeSetAndchosedGameSetGuanYaJun];
        }else{
            keyString = [self passTypeSetAndchosedGameSet];
            if (fenzhong == jingcaihuntouerxuanyi) {
                if (rightBool) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:[NSString stringWithFormat:@"投注异常,请重新投注"]];
                    return;
                }
            }
        }
#endif
        
        
#ifdef isYueYuBan
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] ==0) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
#else
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
            
            if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney||[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] ==0) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 109;
                [alert show];
                [alert release];
                return;
            }
            
            
        }else{
            
            if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 109;
                [alert show];
                [alert release];
                return;
            }
            
        }
        
#endif
        
        
        NSMutableData * postData = [[GC_HttpService sharedInstance] reqJingcaiBetting:keyString baomi:baomileixing danfushi:danfushi betData:betInfo];
        
        
        self.dataRequest = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [dataRequest addCommHeaders];
        [dataRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [dataRequest appendPostData:postData];
        [dataRequest setDelegate:self];
        [dataRequest startAsynchronous];
        
        
    }else if(fenzhong == beijingdanchang||fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == ayjinyintong|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan){
        
        
        
        if ([beitou.text intValue] < 1) {
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }else if([beitou.text intValue] > 10000){
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多一次只能投10000倍"];
            betInfo.prices = betInfo.price * 10000;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 10000;
            
        }  else{
            
        }
        
        betInfo.prices = betInfo.price * [beitou.text intValue];
        betInfo.payMoney = betInfo.prices * 1;
        betInfo.beishu = [beitou.text intValue];
        if (fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan) {
            if (betInfo.prices > 200000) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过20万"];
                return;
            }
            [self beiDanTouZhu];
            
        }else if(fenzhong == ayshengfuguogan){
            
            [self aoyunshengfutouzhu];
        }
        else if(fenzhong == aydiyiming) {
            [self aoyunDiyiMing];
        }
        else if (fenzhong == ayjinyintong){
            [self aoyunJinYinTong];
        }
        
        [self getBettingInfo];
        NSLog(@"betinfo baomi = %d", betInfo.baomiType);
        NSLog(@"issue = %@", betInfo.issue);
        if (isHeMai) {
            NSLog(@"issue = %@", betInfo.issue);
            GCHeMaiSendViewController *send = [[GCHeMaiSendViewController alloc] init];
            send.betInfo = betInfo;
            send.saveKey = saveKey;
            betInfo.modeType = (int)danfushi;
            send.isPutong = !chaodanbool;
            [self.navigationController pushViewController:send animated:YES];
            [send release];
            return;
        }
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            
            if ([self typeFunc]) {
                
                [self sleepPassWordViewShow];
                
                
            }else{
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 101;
                [alert show];
                [alert release];
            }
            
            
            return;
        }
        [self saveClearFunc];
        //#ifdef isYueYuBan
        //                NSRange atfu = [betInfo.issue rangeOfString:@"@"];
        //                if (atfu.location == NSNotFound) {
        //                    NSString * keyString = [NSString stringWithFormat:@"%@@%d", betInfo.issue, countdata ];
        //                    betInfo.issue = keyString;
        //        }else{
        //                    NSArray * comArray = [betInfo.issue componentsSeparatedByString:@"@"];
        //                    NSString * keyString = [NSString stringWithFormat:@"%@@%d", [comArray objectAtIndex:0], countdata ];
        //                    betInfo.issue = keyString;
        //
        //        }
        //
        //
        //#else
        //               // NSString * keyString = [self passTypeSetAndchosedGameSet];
        //#endif
        
        
        
        
#ifdef isYueYuBan
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney||[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]==0) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
#else
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
            if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney||[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]==0) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 109;
                [alert show];
                [alert release];
                return;
            }
        }else{
            if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 109;
                [alert show];
                [alert release];
                return;
            }
        }
        
#endif
        
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqBuyLotteryData:betInfo reSend:[[Info getInstance] caipaocount]];
        [httpRequest clearDelegatesAndCancel];
        NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(reqBuyLotteryFaild:)];
        [httpRequest startAsynchronous];
        
        
        
        
        
    }else {
        
        if ([beitou.text intValue] < 1) {
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }else
            if([beitou.text intValue] > 99){
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"最多一次只能投99倍"];
                betInfo.prices = betInfo.price * 99;
                betInfo.payMoney = betInfo.prices * 1;
                betInfo.beishu = 99;
                
            }  else{
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
                    //                    alertext = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
                    //                    alertext.placeholder = @"请重新输入密码";
                    //                    alertext.tag = 1102;
                    //                    alertext.autocorrectionType = UITextAutocorrectionTypeYes;
                    //                    alertext.secureTextEntry = YES;
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"为了您账户资金安全" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    //                    [alert show];
                    //                    alert.tag = 101;
                    //                    [alert addSubview:alertext];
                    //                    [alert release];
                    //                    alertext.backgroundColor = [UIColor whiteColor];
                    //                    [alertext release];
                    
                    if ([self typeFunc]) {
                        
                        [self sleepPassWordViewShow];
                        
                    }else{
                        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        alert.alertTpye = passWordType;
                        alert.tag = 101;
                        [alert show];
                        [alert release];
                    }
                    
                    return;
                }
                
                betInfo.prices = betInfo.price * [beitou.text intValue];
                
                betInfo.payMoney = betInfo.prices * 1;
                betInfo.beishu = [beitou.text intValue];
                if (fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang|| fenzhong == beidanshengfuguoguan) {
                    if (betInfo.prices > 200000) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过20万"];
                        return;
                    }
                    [self beiDanTouZhu];
                    
                }
                if (betInfo.prices > 1500000) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过150万"];
                    return;
                }
                [self getBettingInfo];
                NSLog(@"betinfo baomi = %d", betInfo.baomiType);
                NSLog(@"issue = %@", betInfo.issue);
                if (isHeMai) {
                    if (fenzhong == renjiupiao) {
                        betInfo.lotteryId = @"301";
                    }else if(fenzhong == ShengFuCai){
                        betInfo.lotteryId = @"300";
                    }
                    GCHeMaiSendViewController *send = [[GCHeMaiSendViewController alloc] init];
                    send.betInfo = betInfo;
                    send.saveKey = saveKey;
                    send.isPutong = !chaodanbool;
                    [self.navigationController pushViewController:send animated:YES];
                    [send release];
                    return;
                }
                [self saveClearFunc];
                
                //#ifdef isYueYuBan
                //                NSRange atfu = [betInfo.issue rangeOfString:@"@"];
                //                if (atfu.location == NSNotFound) {
                //                    NSString * keyString = [NSString stringWithFormat:@"%@@%d", betInfo.issue, countdata ];
                //                    betInfo.issue = keyString;
                //        }else{
                //                    NSArray * comArray = [betInfo.issue componentsSeparatedByString:@"@"];
                //                    NSString * keyString = [NSString stringWithFormat:@"%@@%d", [comArray objectAtIndex:0], countdata ];
                //                    betInfo.issue = keyString;
                //
                //        }
                //
                //#else
                //              //  NSString * keyString = [self passTypeSetAndchosedGameSet];
                //#endif
                //  betInfo.issue = keyString;
                
                
#ifdef isYueYuBan
                if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 109;
                    [alert show];
                    [alert release];
                    
                    return;
                }
#else
                
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
                    if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney||[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]==0) {
                        
                        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                        alert.shouldRemoveWhenOtherAppear = YES;
                        alert.tag = 109;
                        [alert show];
                        [alert release];
                        return;
                    }
                }else{
                    if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney) {
                        
                        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                        alert.shouldRemoveWhenOtherAppear = YES;
                        alert.tag = 109;
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                }
                
#endif
                
                NSMutableData *postData = [[GC_HttpService sharedInstance] reqBuyLotteryData:betInfo reSend:[[Info getInstance] caipaocount]];
                
                //  NSMutableData *postData = [[HttpService sharedInstance] reqBuyLotteryData:betInfo];
                
                [httpRequest clearDelegatesAndCancel];
                NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
                self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                [httpRequest setRequestMethod:@"POST"];
                [httpRequest addCommHeaders];
                [httpRequest setPostBody:postData];
                [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [httpRequest setDelegate:self];
                [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
                [httpRequest setDidFailSelector:@selector(reqBuyLotteryFaild:)];
                [httpRequest startAsynchronous];
                
                
            }
        
        
    }
    
    
    
}

#pragma mark CP_TouZhuAlertdelegate
//投注成功回调
- (void)CP_TouZhuAlert:(CP_TouZhuAlert *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ( buttonIndex == 1) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.nikeName = [[[Info getInstance] mUserInfo] user_name] ;
        if (fenzhong == shisichangpiao || fenzhong == renjiupiao ) {
            
            info.title = matchNameString;
        }else{
            NSString * titlestr = [matchNameString substringToIndex:[matchNameString length]-1];
            info.title = titlestr;
        }
        
        info.orderId = chooseView.buyResult.number;
        info.issure = issString;
        info.canBack = !chaodanbool;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    
    [self requestFangChenMi];
    
}

//防沉迷弹窗
-(void)showFangChenMiText:(NSString *)_text andImageNum:(int)_imgNum
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"投注站提示您" message:_text delegate:self cancelButtonTitle:@"休息一下" otherButtonTitles:nil,nil];
    alert.alertTpye = textAndImage;
    alert.tag = 1234;
    if(_imgNum%9 == 1 || _imgNum%9 == 2 || _imgNum%9 == 3){
        alert.imageName = @"anti-addiction_1.png";
        
    }
    if(_imgNum%9 == 4 || _imgNum%9 == 5 || _imgNum%9 == 6){
        alert.imageName = @"anti-addiction_2.png";
        
    }
    
    if(_imgNum%9 == 7 || _imgNum%9 == 8 || _imgNum%9 == 0){
        alert.imageName = @"anti-addiction_3.png";
        
    }
    
    [alert show];
    [alert release];
}

#pragma mark -CP_UIAlertViewdelegate

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            
            [self.httpRequest clearDelegatesAndCancel];
            NSString *name = [[Info getInstance] login_name];
            NSString *password = self.passWord;
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }
    }
    
    else if (alertView.tag == 109) {
        if (buttonIndex == 1) {
            GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
            [self.navigationController pushViewController:toUp animated:YES];
            [toUp release];
            //            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
            //
            //            [httpRequest clearDelegatesAndCancel];
            //            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            //            [httpRequest setRequestMethod:@"POST"];
            //            [httpRequest addCommHeaders];
            //            [httpRequest setPostBody:postData];
            //            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            //            [httpRequest setDelegate:self];
            //            [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
            //            [httpRequest startAsynchronous];
            //
            
            
        }
    }
    else if (alertView.tag == 105) {
        
        if (buttonIndex == 1) {
            Info * cc = [Info getInstance];
            cc.caipaocount += 1;
            [self querenpresstouzhubut];
        }
        
        // [self presstouzhubut];
    }
    else if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            
            
            [self querenpresstouzhubut];
        }
    }
    else if(alertView.tag == 1234)
    {
        
        
    }
    
    else if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            [MobClick event:@"event_goumai_chenggong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.nikeName = [[[Info getInstance] mUserInfo] user_name] ;
            if (fenzhong == shisichangpiao || fenzhong == renjiupiao ) {
                //                NSArray * arrstr = [mathname.text componentsSeparatedByString:@" "];
                //                info.title = [arrstr objectAtIndex:0];
                info.title = matchNameString;
            }else{
                NSString * titlestr = [matchNameString substringToIndex:[ matchNameString length]-1];
                info.title = titlestr;
            }
            info.issure = issString;
            info.canBack = !chaodanbool;
            [self.navigationController pushViewController:info animated:YES];
            [info release];
        }
        
        [self requestFangChenMi];
    }
    
    else if (alertView.tag == 998) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
            
            BOOL pwInfoBool = NO;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                
                
                for (int i = 0; i < [allUserArr count]; i++) {
                    //        NSArray * userArr = [];
                    NSString * userString = [allUserArr objectAtIndex:i];
                    NSArray * userArr = [userString componentsSeparatedByString:@" "];
                    if ([userArr count] == 3) {
                        
                        if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                            
                            pwInfoBool = YES;
                            
                            break;
                        }
                        
                    }
                    
                }
                
            }
            
            if (pwInfoBool) {
                TestViewController * test = [[TestViewController alloc] init];
                [self.navigationController pushViewController:test animated:YES];
                [test release];
            }else{
                PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                [self.navigationController pushViewController:pwinfo animated:YES];
                [pwinfo release];
                
            }
        }else{
            
            [self presstouzhubut];
        }
        
    }
    
    else if (alertView.tag == 999) {
        if (buttonIndex == 1) {
            UIButton * buttonbaomi = (UIButton *)[upimagebg viewWithTag:1010];
            UILabel * labelbaomi = (UILabel *)[buttonbaomi viewWithTag:1011];
            if (!betInfo) {
                betInfo = [[GC_BetInfo alloc] init];
            }
            labelbaomi.text = alertView.alertSegement.selectBtn.buttonName.text;
            betInfo.baomiType = [SharedMethod changeBaoMiTypeByTitle:alertView.alertSegement.selectBtn.buttonName.text];
            baomileixing = [SharedMethod changeBaoMiTypeByTitle:alertView.alertSegement.selectBtn.buttonName.text];
        }
    }
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            self.passWord = message;
            [self.httpRequest clearDelegatesAndCancel];
            NSString *name = [[Info getInstance] login_name];
            NSString *password = self.passWord;
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }
    }
    
}

//充值请求
- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
}

//跳转其他浏览器
- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)passWordOpenUrl{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
    [self presstouzhubut];
}


- (void)recivedFail:(ASIHTTPRequest*)request {
    [[caiboAppDelegate getAppDelegate] showMessage:@"网络请求超时"];
}


- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    
    if ([responseStr isEqualToString:@"fail"])
    {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"密码不正确"];
    }
    else {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (!userInfo) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"密码不正确"];
            return;
        }
        [userInfo release];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneAlertView"] intValue] == 0) {
            CP_UIAlertView * alear = [[CP_UIAlertView alloc] initWithTitle:@"设置手势密码" message:@"" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"马上设置",nil];
            alear.delegate = self;
            alear.tag = 998;
            alear.alertTpye = twoTextType;
            [alear show];
        }else{
            [self presstouzhubut];
        }
        
        
        
        
        //        [self presstouzhubut];
    }
}

-(void)requestFangChenMi
{
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"FangChenMiSwitch"] integerValue] == 1){
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] getUSerFangChenMiMessage];
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(requestFangChenMiFinished:)];
        [httpRequest startAsynchronous];
        
    }
    
    
}
- (void)requestFangChenMiFinished:(ASIHTTPRequest*)request{
    
    if([request responseData]){
        
        GC_FangChenMiParse *fangchenmi = [[GC_FangChenMiParse alloc] initWithResponseData:request.responseData WithRequest:request];
        
        if(fangchenmi.returnID != 3000){
            
            if([fangchenmi.code integerValue] == 1){
                
                [self showFangChenMiText:fangchenmi.alertText andImageNum:(int)fangchenmi.alertNum];
                
            }
        }
        
        [fangchenmi release];
        
    }
}

- (void)reqBuyLotteryFaild:(ASIHTTPRequest*)request{
    if (request.responseStatusCode >= 400){
        CP_UIAlertView * failAlertView = [[CP_UIAlertView alloc] initWithTitle:nil message:@"服务器忙于兑奖" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        failAlertView.tag = 112345678;
        [failAlertView show];
        [failAlertView release];
    }

}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest*)request
{
    //   DD_LOG(@"responseData = %@", [request responseData]);
    if ([request responseData]) {
        
#ifdef isYueYuBan
        self.buyResult = [[GC_BuyLottery alloc] initWithResponseData:[request responseData] isYueyu:YES WithRequest:request];
#else
        self.buyResult = [[GC_BuyLottery alloc] initWithResponseData:[request responseData] WithRequest:request];
#endif
        
        buyResult.lotteryId = self.BetDetailInfo.lotteryId;
        
#ifdef isYueYuBan
        
        if (buyResult.returnValue == 0) {
            
            CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
            alert.buyResult = buyResult;
            alert.delegate = self;
            [alert show];
            [alert release];
            
            
        }else if(buyResult.returnValue == 2){
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            
        } else if (buyResult.returnValue == 10) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 105;
            [alert show];
            [alert release];
        }else if (buyResult.returnValue == 9){
            
            NSString * h5url = @"http://h5123.cmwb.com/lottery/nearStation/toMap.jsp";
            
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
            webview.delegate= self;
            webview.hiddenNav = NO;
            [self.navigationController pushViewController:webview animated:YES];
            [webview release];
            
        }
        
        
        
#else
        
        if (buyResult.returnValue == 1) {
            
            isGoBuy = YES;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
            [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
            
            [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
        }
        
#endif
        
        
        
        
        else if (buyResult.returnValue == 4) {
            
            if([buyResult.curIssure length] == 0){
                if (fenzhong == shisichangpiao) {
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else if(fenzhong == renjiupiao){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else if(fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang || fenzhong == beidanshengfuguoguan){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期部分比赛已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }
                
            }else {
                if (fenzhong == shisichangpiao) {
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else if(fenzhong == renjiupiao){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else if(fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang|| fenzhong == beidanshengfuguoguan){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期部分比赛已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止,请重新投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }
                
                
            }
            
            
            
            
        }
        else {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"投注失败"];
        }
    }
}

- (void)buyBack {
    
    if (isGoBuy) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"购买成功？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 102;
        [alert release];
    }
    isGoBuy = NO;
}


- (void)requestFinished:( ASIHTTPRequest *)mrequest{
    NSData  *data = [mrequest responseData];
    if (data) {
        
        self.buyResult = [[GC_BuyLottery alloc] initWithResponseData:[dataRequest responseData]WithRequest:mrequest];
        buyResult.lotteryId = self.BetDetailInfo.lotteryId;
        
#ifdef isYueYuBan
        
        if (buyResult.returnValue == 0) {
            
            CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
            alert.buyResult = buyResult;
            alert.delegate = self;
            [alert show];
            [alert release];
            
            
        }else if(buyResult.returnValue == 2){
            // NSString * msgstr = [NSString stringWithFormat:@"",betInfo.issue];
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            
        } else if (buyResult.returnValue == 10) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 105;
            [alert show];
            [alert release];
        }else if (buyResult.returnValue == 9){
        
            NSString * h5url = @"http://h5123.cmwb.com/lottery/nearStation/toMap.jsp";
           
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
            webview.delegate= self;
            webview.hiddenNav = NO;
            [self.navigationController pushViewController:webview animated:YES];
            [webview release];
        
        }
        //  [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:buyResult.systemTime]];
        
#else
        if (buyResult.returnValue == 1) {
            isGoBuy = YES;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
            [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];
            [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
        }
        
#endif
        
        
        
        else if (buyResult.returnValue == 4) {
            
            if([buyResult.curIssure length] == 0){
                if (fenzhong == shisichangpiao) {
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                    
                }else if(fenzhong == renjiupiao){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                    
                }else if(fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang|| fenzhong == beidanshengfuguoguan){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期部分比赛已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                    
                }else {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }
                
            }else {
                if (fenzhong == shisichangpiao) {
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                    
                }else if(fenzhong == renjiupiao){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                    
                }else if(fenzhong == beijingdanchang|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang|| fenzhong == beidanshengfuguoguan){
                    NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期部分比赛已截止,请重新投注",betInfo.issue];
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }else {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止,请重新投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 108;
                    [alert show];
                    [alert release];
                }
                
                
            }
            
            
            
            
        } else {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"投注失败"];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [numtextfield resignFirstResponder];
    if ([[[Info getInstance] userId] intValue] == 0) {
        gerenyuela.hidden = NO;
        yuanyla.hidden = NO;
        yuela.hidden = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passWordOpenUrl) name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPassWord) name:@"resetPassWord" object:nil];
    
    if ([[[Info getInstance] userId] intValue] != 0) {
        if (![GC_UserInfo sharedInstance].accountManage) {
            if (![GC_HttpService sharedInstance].sessionId) {
                [self performSelector:@selector(getAccountInfoRequest) withObject:nil afterDelay:2];
            }
            else {
                [self getAccountInfoRequest];
            }
        }
    }
    
    if (betInfo && betInfo.baomiType != 3) {
        UIButton * buttonbaomi = (UIButton *)[upimagebg viewWithTag:1010];
        UILabel * labelbaomi = (UILabel *)[buttonbaomi viewWithTag:1011];
        if (self.betInfo.baomiType == 1) {
            labelbaomi.text = @"保密";
        }
        else if (self.betInfo.baomiType == 2) {
            labelbaomi.text = @"截止后公开";
        }
        else if (self.betInfo.baomiType == 4) {
            labelbaomi.text = @"隐藏";
        }
        else {
            labelbaomi.text = @"公开";
        }

        betInfo.baomiType = [SharedMethod changeBaoMiTypeByTitle:labelbaomi.text];
        baomileixing = [SharedMethod changeBaoMiTypeByTitle:labelbaomi.text];
    }

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [numtextfield resignFirstResponder];
    //    [timer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resetPassWord" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"passWordOpenUrl" object:nil];
    
    [gckeyView dissKeyFunc];
    beitou.textColor = [UIColor blackColor];
    [self dataBetTouText];
}

- (void)pressjianbutton:(UIButton *)sender{
    
    if ([beitou.text intValue] <= 1) {
        beitou.text = @"1";
        betInfo.prices = betInfo.price * [beitou.text intValue];
        sender.enabled = NO;
    }else if([beitou.text length] == 0){
        beitou.text = @"1";
        betInfo.prices = betInfo.price * [beitou.text intValue];
        sender.enabled = NO;
    }else{
        sender.enabled = YES;
        NSString * str = [NSString stringWithFormat:@"%d",[beitou.text intValue] - 1];
        beitou.text = str;
        betInfo.prices = betInfo.price * [str intValue];
    }
    sender.enabled = YES;
    //    [beitou resignFirstResponder];
}

- (void)hemaiSetting:(CP_SWButton *)sender {
    NSLog(@"sender = %d", sender.on);
    
    
    
    isHeMai = sender.on;
    if (isHeMai) {
        [MobClick event:@"event_goucai_touzhu_hemai_caizhong " label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
        buttonLabel1.text = @"发起";
        
        
        
        
        
        
    }else{
        buttonLabel1.text = @"投注";
        
    }
    
}

- (void)pressaddbutton:(UIButton *)sender{
    if (jingcai) {
        
        if ([beitou.text intValue] >= 29999) {
            beitou.text = [NSString stringWithFormat:@"%d",29999];
            betInfo.price = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d倍", 29999]];
        }else if([beitou.text length] == 0){
            beitou.text = @"1";
            betInfo.prices = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
        }else{
            NSString * str = [NSString stringWithFormat:@"%d",[beitou.text intValue] + 1];
            beitou.text = str;
            betInfo.prices = betInfo.price * [str intValue];
            sender.enabled = YES;
        }
        
        
        
        
        sender.enabled = YES;
        //        [beitou resignFirstResponder];
        
    }else  if(fenzhong == beijingdanchang || fenzhong == ayshengfuguogan || fenzhong == aydiyiming|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang||fenzhong == beidanshengfuguoguan|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
        
        if ([beitou.text intValue] >= 10000) {
            beitou.text = [NSString stringWithFormat:@"%d",10000];
            betInfo.price = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d倍", 10000]];
        }else if([beitou.text length] == 0){
            beitou.text = @"1";
            betInfo.prices = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
        }else{
            NSString * str = [NSString stringWithFormat:@"%d",[beitou.text intValue] + 1];
            beitou.text = str;
            betInfo.prices = betInfo.price * [str intValue];
            sender.enabled = YES;
        }
        sender.enabled = YES;
        //        [beitou resignFirstResponder];
        
        
    }else{
        if ([beitou.text intValue] >= 99) {
            beitou.text = [NSString stringWithFormat:@"%d",99];
            betInfo.price = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d倍", 99]];
        }else if([beitou.text length] == 0){
            beitou.text = @"1";
            betInfo.prices = betInfo.price * [beitou.text intValue];
            sender.enabled = NO;
        }else{
            NSString * str = [NSString stringWithFormat:@"%d",[beitou.text intValue] + 1];
            beitou.text = str;
            betInfo.prices = betInfo.price * [str intValue];
            sender.enabled = YES;
        }
        sender.enabled = YES;
        //        [beitou resignFirstResponder];
        
        
    }
}


- (void)queding:(UIButton *)sender{
    
    if ([beitou.text intValue] == 0) {
        beitou.text = @"1";
    }
    
    //    [beitou resignFirstResponder];
    
    
    if (jingcai) {
        
        if ([beitou.text intValue] > 29999) {
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d", 29999]];
            beitou.text = [NSString stringWithFormat:@"%d", 29999];
            betInfo.prices = betInfo.price * 29999;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 29999;
        }
        
        
        if ([beitou.text isEqualToString:@""]||beitou.text == nil) {
            beitou.text = @"1";
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }
        
    }else if(fenzhong == beijingdanchang || fenzhong == ayshengfuguogan || fenzhong == aydiyiming || fenzhong == ayjinyintong|| fenzhong == beidanbanquanchang || fenzhong == beidanbifen || fenzhong == beidanjinqiushu || fenzhong == beidanshangxiadanshuang|| fenzhong == beidanshengfuguoguan|| fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa){
        
        if ([beitou.text intValue] > 10000) {
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d", 10000]];
            beitou.text = [NSString stringWithFormat:@"%d", 10000];
            betInfo.prices = betInfo.price * 10000;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 10000;
        }
        if ([beitou.text isEqualToString:@""]||beitou.text == nil) {
            beitou.text = @"1";
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }
        
    }else{
        
        if ([beitou.text intValue] > 99) {
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"当前方案最多只能投注%d", 99]];
            beitou.text = [NSString stringWithFormat:@"%d", 99];
            betInfo.prices = betInfo.price * 99;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 99;
        }
        if ([beitou.text isEqualToString:@""]||beitou.text == nil) {
            beitou.text = @"1";
            betInfo.prices = betInfo.price * 1;
            betInfo.payMoney = betInfo.prices * 1;
            betInfo.beishu = 1;
        }
        
    }
    
}


- (void)pressbgbutton:(UIButton *)sender{
    [numtextfield resignFirstResponder];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataAr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (fenzhong == ayjinyintong) {
        return 34;
    }
    if (fenzhong == guanjunwanfa || fenzhong == guanyajunwanfa) {
        return 32;
    }
    
    if (indexPath.row != [dataAr count]) {
        GC_shengfudata * bet = [dataAr objectAtIndex:indexPath.row];
        NSString * str = bet.cuStr;
        NSLog(@"str = %@", str);
        UIFont * font = [UIFont boldSystemFontOfSize:12];//[UIFont fontWithName:@"Arial" size:12];
        CGSize  size = CGSizeMake(70, 300);
        CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        int height = 12 * labelSize.height/12.0;
        
        //        if (labelSize.height < 32) {
        //            labelSize.height = 32;
        //        }else {
        //            labelSize.height += 2;
        //        }
        NSLog(@"height = %f", labelSize.height);
        
        
        return height+23;
        
    }
    
    return 32;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellid = @"cellid";
    GC_JingCaiCell * cell = (GC_JingCaiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[GC_JingCaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (fenzhong == jingcaihuntou || fenzhong == jingcaihuntouerxuanyi) {
        cell.huntouBool  = YES;
    }else{
        cell.huntouBool  = NO;
    }
    if (fenzhong == guanjunwanfa) {
        cell.cellType = guanjuncelltype;
    }else if (fenzhong == guanyajunwanfa){
        cell.cellType = guanyajuncelltype;
    }else{
        cell.cellType = qitacelltype;
    }
    
    cell.row = indexPath.row;
    
    GC_shengfudata * be =[dataAr objectAtIndex:indexPath.row];
    //            NSLog(@"dataar = %@", be.cuStr);
    //            cell.zuihoubool = NO;
    
    if (indexPath.row == [dataAr count]-1) {
        be.zuihou = YES;
        cell.data = be;
        cell.zuihoubool = YES;
    }else{
        be.zuihou = NO;
        cell.zuihoubool = NO;
        cell.data = be;
    }
    
    
    return cell;
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
    
    [buyResult release];
    
    [matchId release];
    [championData release];
    [betInfo release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    [qihaostring release];
    [BetDetailInfo release];
    [yujimoney release];
    //    [alertext release];
    [dataRequest clearDelegatesAndCancel];
    [dataRequest release];
    [moneylabel release];
    [dataAr release];
    [leftimage release];
    [cuimage release];
    [rigimage release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [bettingArray release];
    [numtextfield release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
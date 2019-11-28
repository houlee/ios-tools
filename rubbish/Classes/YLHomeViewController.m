//
//  YLHomeViewController.m
//  caibo
//
//  Created by houchenguang on 15/3/9.
//
//

#import "YLHomeViewController.h"
#import "GC_HttpService.h"
#import "LastLotteryViewController.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "LiveScoreViewController.h"
#import "MobClick.h"
#import "HRSliderViewController.h"
#import "GC_BaFangShiPingViewController.h"
#import "LoginViewController.h"
#import "YLAlertView.h"
#import "GCHeMaiInfoViewController.h"
#import "GouCaiViewController.h"

#import "ProvingViewCotroller.h"
#import "RegisterViewController.h"
#import "User.h"
#import "UserInfo.h"
#import "CheckNewMsg.h"
#import "RankingListViewController.h"
#import "EveryDayViewController.h"
#import "SachetViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MyProfileViewController.h"
#import "NewsViewController.h"
@interface YLHomeViewController ()

@end

@implementation YLHomeViewController
@synthesize passWord, requestUserInfo;

- (void)dealloc{
    [requestUserInfo clearDelegatesAndCancel];
    [requestUserInfo release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[caiboAppDelegate getAppDelegate] oneLoginFunc];
     [self performSelector:@selector(yanchidiao) withObject:nil];
    
}


- (void)yanchidiao{

    if ([[[Info getInstance] userId] intValue] == 0) {
        zcButton.hidden = NO;
        zcButton.frame = CGRectMake(105, 525, 75, 16);
        [zcButton setBackgroundImage:UIImageGetImageFromName(@"ylzcwsxx.png") forState:UIControlStateNormal];
    }else{
        
        if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 || [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            zcButton.hidden = NO;
            zcButton.frame = CGRectMake(130, 525, 50, 16);
            [zcButton setBackgroundImage:UIImageGetImageFromName(@"ylwsxx.png") forState:UIControlStateNormal];
        }else{
            zcButton.hidden = YES;
        }
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
- (void)SachetViewFunc{
    
    
    RankingListViewController * ranking = [[RankingListViewController alloc] init];
    EveryDayViewController * everyDay = [[[EveryDayViewController alloc] initWithIssue:@""] autorelease];
    SachetViewController * sachet2 = [[SachetViewController alloc] init];
    sachet2.sachettype = huatitype;
    
    //    SachetViewController * sachet4 = [[SachetViewController alloc] init];
    //    sachet4.sachettype = wolaiyucetype;
    
    //    JCClassroomViewController * classroomController = [[JCClassroomViewController alloc] init];
    
    MyWebViewController *classroomController=[[MyWebViewController alloc]init];
    classroomController.webTitle=@"竞彩课堂";
    classroomController.isHaveTab = YES;
    [classroomController LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.caipiao365.com/help/jckt.html"]]];
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects: classroomController,ranking, everyDay,sachet2,nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    [labearr addObject:@"竞彩课堂"];
    
    [labearr addObject:@"红人榜"];
    [labearr addObject:@"天天竞彩"];
    [labearr addObject:@"话题"];
    //    [labearr addObject:@"我来预测"];
    
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"jcclassroomimage.png"];
    
    [imagestring addObject:@"glhongrenimage.png"];
    [imagestring addObject:@"tiantianjingcaiimage.png"];
    [imagestring addObject:@"glhautiimage.png"];
    //    [imagestring addObject:@"glwolaiyuce.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    
    [imageg addObject:@"jcclassroomimage_1.png"];
    
    [imageg addObject:@"glhongrenimage_1.png"];
    [imageg addObject:@"tiantianjingcaiimage_1.png"];
    [imageg addObject:@"glhautiimage_1.png"];
    //    [imageg addObject:@"glwolaiyuce_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = 0;
    tabc.backgroundImage.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [ranking release];
    [sachet2 release];
    //    [sachet4 release];
    [classroomController release];
    
    
}

- (void)weiBoHome:(BOOL)homeOrNew{
    con = 6;
    [MobClick event:@"event_weibohudong"];
    HomeViewController * home = [[HomeViewController alloc] initWithBool:YES];
    home.dajiabool = YES;
    home.title = @"广场";
    
    NewsViewController * news = [[NewsViewController alloc] init];
    news.title = @"预测";
    //    [news.navigationController setNavigationBarHidden:YES];
    
    HomeViewController * mygz = [[HomeViewController alloc] initWithBool:NO];
    mygz.dajiabool = NO;
    //    [mygz.navigationController setNavigationBarHidden:YES];
    mygz.title = @"好友";
    
    MessageViewController * mvc = [[MessageViewController alloc] init];
    mvc.title = @"消息";
    //    [mvc.navigationController setNavigationBarHidden:YES];
    
    MyProfileViewController * mypro = [[MyProfileViewController alloc] init];
    mypro.title = @"我";
    //    [mypro.navigationController setNavigationBarHidden:YES];
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:home, news, mygz, mvc, mypro, nil];
    
    //    self.viewControllers = controllers;
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"广场"];
    [labearr addObject:@"预测"];
    [labearr addObject:@"好友"];
    [labearr addObject:@"消息"];
    [labearr addObject:@"我"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"wbTab_gc_normal.png"];
    [imagestring addObject:@"wbTab_yc_normal.png"];
    [imagestring addObject:@"wbTab_hy_normal.png"];
    [imagestring addObject:@"wbTab_xx_normal.png"];
    [imagestring addObject:@"wbTab_wo_normal.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"wbTab_gc_selected.png"];
    [imageg addObject:@"wbTab_yc_selected.png"];
    [imageg addObject:@"wbTab_hy_selected.png"];
    [imageg addObject:@"wbTab_xx_selected.png"];
    [imageg addObject:@"wbTab_wo_selected.png"];
    counhaoyou = 0;
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    //    home.view.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height-49);
    
    tab = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg];
    
    tab.delegateCP = self;
    tab.backgroundImage.backgroundColor = [UIColor blackColor];
    if (homeOrNew) {
        tab.selectedIndex = 0;
    }else{
        tab.selectedIndex = 1;
    }
    
    [self.navigationController pushViewController:tab animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [imagestring release];
    [labearr release];
    [imageg release];
    
    //    [nav release];
    [home release];
    [news release];
    [mygz release];
    [mvc release];
    [mypro release];
    [controllers release];
    [tab release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hometozhuye" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backaction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeAction) name:@"hometozhuye" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAction) name:@"backaction" object:nil];
    
}
-(void)homeAction
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dissmissstatepop{
    [statepop dismiss];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    
    if (alertView.tag == 111) {
        self.passWord = message;
        if (buttonIndex == 1) {
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.requestUserInfo clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    //                    NSString *password = textF.text;
                    self.requestUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
                    [requestUserInfo setTimeOutSeconds:20.0];
                    [requestUserInfo setDidFinishSelector:@selector(recivedLoginFinish:)];
                    [requestUserInfo setDidFailSelector:@selector(recivedFail:)];
                    [requestUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [requestUserInfo setDelegate:self];
                    [requestUserInfo startAsynchronous];
                    
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }
}

-(void)autoRefresh:(NSString*)responseString{
    
    
    if (responseString) {
        NSDictionary * dict = [responseString JSONValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cheknewpush"];
        
        CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
        
        NSLog(@"checkkkkkkkkkkkkkkkkkkkkk %@, %@, %@, %@,中奖%@", check.gzrft, check.atme, check.sx, check.pl,check.zj);
        
        if (![check.pl isEqualToString:@"0" ]||![check.gz isEqualToString:@"0" ]|| ![check.atme isEqualToString:@"0"]|| ![check.sx isEqualToString:@"0"]||![check.gzrft isEqualToString:@"0" ]) {
            
        //有新微薄
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HasNewWeibo" object:nil];
            
        }else{
        //没有新微薄
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HasNotNewWeibo" object:nil];

        }
        
        
        
        
        
        NSString * leixingarr = [NSString stringWithFormat:@"%@,%@,%@,%@", check.atme, check.pl,check.sx,check.xttz];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leixingbiaoji" object:leixingarr];
        

        
        [check release];
        
    }
    
}

- (void)recivedFail:(ASIHTTPRequest *)request{

    
}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    
    if ([responseStr isEqualToString:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        [alert release];
    }
    else {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (!userInfo) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            [alert release];
            return;
        }
        
        else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
        
    }
}


- (void)pressZCButton:(UIButton *)sender{
    
    //    NSInteger ziliaowan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue];
    NSInteger denlu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue];
    
    //    NSLog(@"%d",denlu);
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        if (denlu == 0) {
            if ([[GC_HttpService sharedInstance].sessionId length] ||[[[Info getInstance] userId] intValue] == 0) {
               
                
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 111;
                [alert show];
                [alert release];
            }
            else{
                [self activityIndicatorViewshow];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wanshanxinxi) name:@"hasGetsession_id" object:nil];
            }
            
        }else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
        }
        
    }else{
        RegisterViewController *registerVC = [[RegisterViewController alloc] init];
        [registerVC.navigationController setNavigationBarHidden:NO];
        [self.navigationController pushViewController:registerVC animated:YES];
        [registerVC release];
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setIsRealNavigationBarHidden:YES];
    
    con = 6;
    counhaoyou = 0;
    
    UIScrollView * myScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.bounces = NO;
    myScrollView.delegate = self;
    if (IS_IPHONE_5) {
        myScrollView.scrollEnabled = NO;
    }else{
        myScrollView.scrollEnabled = YES;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        myScrollView.frame = CGRectMake(0, -20, self.mainView.frame.size.width, self.mainView.frame.size.height+20);
    }
    
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 568);
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    bigView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.mainView.frame.size.width-20, 278-20)];
    bigView.alpha = 0.1;
    [bigView.layer setMasksToBounds:YES]; // 设置圆角边框
    [bigView.layer setCornerRadius:130];//40
    [myScrollView addSubview:bigView];
    [bigView release];

    UIImageView * bigImageView = [[UIImageView alloc] initWithFrame:bigView.bounds];
    bigImageView.tag = 101;
    bigImageView.backgroundColor = [UIColor clearColor];
    bigImageView.image = UIImageGetImageFromName(@"bighomeImage.png");
    [bigView addSubview:bigImageView];
    [bigImageView release];
    
    
    upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 278, self.mainView.frame.size.width, myScrollView.contentSize.height-278)];
    upImageView.userInteractionEnabled = YES;
    upImageView.backgroundColor = [UIColor colorWithRed:38/255.0 green:45/255.0 blue:58/255.0 alpha:1];
    [myScrollView addSubview:upImageView];
    [upImageView release];
    
    for (int i = 0; i < 6; i++) {
        
        UIButton * iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < 3) {
            iconButton.frame = CGRectMake(8 + i * 5 + i * 98 + 49, 11+48.5, 0, 0);
        }else{
            iconButton.frame = CGRectMake(8 + (i - 3) * 5 + (i- 3) * 98 + 49, 113+48.5, 0, 0);
        }
        [iconButton.layer setMasksToBounds:YES];
        iconButton.alpha = 0.3;
        iconButton.tag = i+1;
        NSString * contNum = [NSString stringWithFormat:@"ylbutton%d.png",i+1];
        [iconButton setBackgroundImage:UIImageGetImageFromName(contNum) forState:UIControlStateNormal];
        [iconButton setBackgroundImage:UIImageGetImageFromName(contNum) forState:UIControlStateHighlighted];
        [iconButton addTarget:self action:@selector(pressIconButton:) forControlEvents:UIControlEventTouchUpInside];
        [iconButton addTarget:self action:@selector(TouchDown:) forControlEvents:UIControlEventTouchDown];
        [iconButton addTarget:self action:@selector(TouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [iconButton addTarget:self action:@selector(TouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        
        [upImageView addSubview:iconButton];
        
        
    }
    
    
    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(14+25, 503+25, 0, 0);
    goButton.alpha = 0.3;
    [goButton setBackgroundImage:UIImageGetImageFromName(@"ylgoimage.png") forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(pressGoButton:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:goButton];
    
    
    zcButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zcButton.frame = CGRectMake(105, 525, 75, 16);
    [zcButton addTarget:self action:@selector(pressZCButton:) forControlEvents:UIControlEventTouchUpInside];
    [zcButton setBackgroundImage:UIImageGetImageFromName(@"ylzcwsxx.png") forState:UIControlStateNormal];
    [myScrollView addSubview:zcButton];
    
//    UILabel * wsLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 518, 90, 20)];
//    wsLabel.backgroundColor = [UIColor clearColor];
//    wsLabel.font = [UIFont systemFontOfSize:13];
//    wsLabel.textColor = [UIColor colorWithRed:164/255.0 green:165/255.0 blue:167/255.0 alpha:1];
//    wsLabel.textAlignment = NSTextAlignmentLeft;
//    wsLabel.text = @"注册完善信息";
//    [myScrollView addSubview:wsLabel];
//    [wsLabel release];
//    
//    UIImageView * wsimage = [[UIImageView alloc] initWithFrame:CGRectMake(121, 538, 76, 1)];
//    wsimage.backgroundColor = [UIColor colorWithRed:164/255.0 green:165/255.0 blue:167/255.0 alpha:1];
//    [myScrollView addSubview:wsimage];
//    [wsimage release];
    
    
    
    
    UIImageView * moneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 182, 503, 172, 60)];
    moneyImage.backgroundColor = [UIColor clearColor];
    moneyImage.image = UIImageGetImageFromName(@"ylmoneyimage.png");
    [myScrollView addSubview:moneyImage];
    [moneyImage release];
    
    
//    [self homeAnimationFunc];
    
}



- (void)pressGoButton:(UIButton *)sender{//GO按钮
    
    YLAlertView *ylAlert = [[YLAlertView alloc] initYLAlertView];
    [ylAlert show];
    [ylAlert release];

}

- (void)iconButtonTounchAnimationFunc:(UIButton *)sender{
    
    [UIView beginAnimations:@"301" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    int i = (int)sender.tag - 1;
    if (i < 3) {
        sender.frame = CGRectMake(8 + i * 5 + i * 98 , 11, 98, 97);
    }else{
        sender.frame = CGRectMake(8 + (i - 3) * 5 + (i- 3) * 98 , 113, 98, 97);
    }
    
    [UIView commitAnimations];


}

- (void)iconButtonDownAnimationFunc:(UIButton *)sender{
    
    [UIView beginAnimations:@"301" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    int i = (int)sender.tag - 1;
    if (i < 3) {
        sender.frame = CGRectMake(8 + i * 5 + i * 98 +3 , 11 +3, 98 - 6, 97- 6);
    }else{
        sender.frame = CGRectMake(8 + (i - 3) * 5 + (i- 3) * 98 +3 , 113 +3, 98- 6, 97- 6);
    }
    
    [UIView commitAnimations];
}

- (void)LastLotteryFunc{
    if ([[GC_HttpService sharedInstance].sessionId length] ||[[[Info getInstance] userId] intValue] == 0) {
        LastLotteryViewController * as = [[[LastLotteryViewController  alloc] init] autorelease];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.navigationController pushViewController:as animated:YES];
    }else{
        [self activityIndicatorViewshow];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kaijiangtongzhi) name:@"hasGetsession_id" object:nil];
    }
}

- (void)kaijiangtongzhi{
    [statepop dismiss];
    LastLotteryViewController * as = [[[LastLotteryViewController  alloc] init] autorelease];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:as animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}


- (void)scoreLiveFunc{
    LiveScoreViewController *lsViewController = [[[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil] autorelease];
    [self.navigationController pushViewController:lsViewController animated:YES];
    return;
}

//八方视频
- (void)pressbfsp{
    [MobClick event:@"ecetn_saishizhibo"];
    GC_BaFangShiPingViewController * shipin = [[[GC_BaFangShiPingViewController alloc] init] autorelease];
    [self.navigationController pushViewController:shipin animated:YES];
}
//购彩
- (void)goBuy{
    
    if ([[GC_HttpService sharedInstance].sessionId length] || [[[Info getInstance] userId] intValue] == 0) {
        
        [MobClick event:@"event_goumai"];
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
        if (tabarvc.selectedIndex == 0) {
            [MobClick event:@"event_goumai_shuzicai"];
        }
        else {
            [MobClick event:@"event_goumai_zucai"];
        }
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
//微博互动
-(void)goWeibo{
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        if ([[GC_HttpService sharedInstance].sessionId length]|| [[[Info getInstance] userId] intValue] == 0) {
            [self weiBoHome:YES];
            tab.loginyn = YES;
            
        }else{
            [self activityIndicatorViewshow];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weibotongzhi) name:@"hasGetsession_id" object:nil];
        }
    }
    else {
        [self weiBoHome:NO];
        tab.loginyn = YES;
    }
    
    Info *info1 = [Info getInstance];
    if ([info1.userId intValue]) {
        counttag = 0;
    }else{
        
        counttag = 1;
    }

}
//攻略
-(void)goGonglue{
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        
        if ([[GC_HttpService sharedInstance].sessionId length] ||[[[Info getInstance] userId] intValue] == 0) {
            [self SachetViewFunc];
            
        }else{
            [self activityIndicatorViewshow];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jinnangtongzhi) name:@"hasGetsession_id" object:nil];
        }
        
        
    }
    else {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        
#endif
        
    }

}
//娱乐
-(void)goYule{

    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
    
        [MobClick event:@"event_huodong"];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * sessionid = @"";
        if ([GC_HttpService sharedInstance].sessionId) {
            sessionid = [GC_HttpService sharedInstance].sessionId;
        }
        NSString * userNameString = @"";
        Info * userInfo = [Info getInstance];
        if ([userInfo.userName length] > 0) {//判断用户名是否为nil
            userNameString = userInfo.userName;
        }
        NSString * flag = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@", sessionid, userNameString]];
        
        NSString * h5url = [NSString stringWithFormat:@"%@huoDong/app/appTuiJian/365huodong.jsp?newRequest=1&sessionId=%@&flag=%@&client=ios&sid=%@&date=%d", happyH5_URL,sessionid,flag,[infoDict objectForKey:@"SID"],(int)[[NSDate date] timeIntervalSince1970]];
        MyWebViewController *webview = [[MyWebViewController alloc] init];
        [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
        webview.delegate= self;
        webview.webTitle = @"娱乐";
//        webview.hiddenNav = YES;
        [self.navigationController pushViewController:webview animated:YES];
        [webview release];
        
    }
    else {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        
#endif
        
    }

}
#pragma mark MyWebViewDelegate
-(void)myWebView:(UIWebView *)webView needReloadRequest:(NSURLRequest *)request{

    [webView reload];

}
#pragma mark 消息通知

- (void)maicaipiaotongzhi{
    
    [statepop dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}


- (void)jinnangtongzhi{
    
    [statepop dismiss];
    
    [self SachetViewFunc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}
- (void)weibotongzhi{
    [statepop dismiss];

    [self weiBoHome:YES];
    tab.loginyn = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}
#pragma mark tabbarcontroller delegate
- (void)cpTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if ([tabBarController.selectedViewController isKindOfClass:[GouCaiViewController class]] || [tabBarController.selectedViewController isKindOfClass:[GCHeMaiInfoViewController class]]) {
        if (tabBarController.selectedIndex == 0) {
            [MobClick event:@"event_goumai_shuzicai"];
        }
        else if (tabBarController.selectedIndex == 1) {
            [MobClick event:@"event_goumai_zulancai"];
        }
        return;
    }
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        
        
        if (counttag == 0) {
            tabBarController.selectedIndex = 0;
            [MobClick event:@"event_weibohudong_guangchang"];
        }else{
            [MobClick event:@"event_weibohudong_xinwen"];
            tabBarController.selectedIndex = 1;
        }
    }else{
        if (tabBarController.selectedIndex == 0) {
            [MobClick event:@"event_weibohudong_guangchang"];
        }
        else if (tabBarController.selectedIndex == 1) {
            [MobClick event:@"event_weibohudong_xinwen"];
        }
        else if (tabBarController.selectedIndex == 2) {
            [MobClick event:@"event_weibohudong_haoyou"];
        }
        else if (tabBarController.selectedIndex == 3) {
            [MobClick event:@"event_weibohudong_xiaoxi"];
        }
        else if (tabBarController.selectedIndex == 4) {
            [MobClick event:@"event_weibohudong_ziliao"];
        }
        if (tabBarController.selectedIndex != 3) {
            UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_xie.png");
            //            UIImage *imagerigthItem = UIImageGetImageFromName(nil);
            
            rigthItem.bounds = CGRectMake(150, 12, 23, 24);
            
            [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
            [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
            
            
            tab.navigationItem.rightBarButtonItem = rigthItemButton;
            [rigthItemButton release];
            
        }else{
            tab.navigationItem.rightBarButtonItem = nil;
        }
        
        
        if (tabBarController.selectedIndex == 0) {
            // tabBarController.selectedIndex = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinhan" object:nil];
            
        }
        else if(tabBarController.selectedIndex == 2){
            //  tabBarController.selectedIndex = 2;
            //            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            //
            //            UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
            //            NSArray * views = a.viewControllers;
            //            if ([views count] >= 2) {
            //                CP_TabBarViewController *c = [views objectAtIndex:1];
            //                if ([c isKindOfClass:[CP_TabBarViewController class]]) {
            //                    //                NSArray * viewss = c.viewControllers;
            //
            //
            //                    c.haoyoubadge.hidden = YES;
            //                    c.hybadgeValue.text = @"";
            //
            //
            //                }
            //            }
            
            
            if (counhaoyou != 0) {
                //   [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinhan" object:nil];
            }
            counhaoyou += 1;
            
        }
        
    }
    
    
    if (tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 2) {
        
        
        selectedTab = (int)tabBarController.selectedIndex;
        
        if (selectedTab == 0 ) {
            if (selectedTab == con) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:nil];
                
            }
        }
        if (selectedTab ==2) {
            if (selectedTab == con) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"haoyourefreshWeibo" object:nil];
                
            }
        }
        
        
        //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressRefreshButton:) name:@"haoyourefreshWeibo" object:nil];
        
        con = selectedTab;
    }
    
    
}//回调
-(void)cpTabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    UINavigationController *nav = (UINavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController;
    if ([nav.viewControllers count]>=2) {
        CP_TabBarViewController *tabV = [nav.viewControllers objectAtIndex:1];
        if ([tabV.selectedViewController isKindOfClass:[GouCaiViewController class]] ||[tabV.selectedViewController isKindOfClass:[GCHeMaiInfoViewController class]]) {
            
            //            Info *info1 = [Info getInstance];
            //            if (![info1.userId intValue]) {
            //                if (item.tag == 2) {
            //                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //                    cai.gaodian = YES;
            //                    [cai showMessage:@"登录后可用"];
            //                    cai.gaodian = NO;
            ////                    CP_TabBarViewController * tabbarview = (CP_TabBarViewController *)tabBar;
            //                    tabarvc.selectedIndex = goucaicount;
            //                    return;
            //                }else{
            //                    goucaicount = item.tag;
            //                }
            //
            //            }else{
            //                goucaicount = item.tag;
            //            }
            
            return;
        }
        
    }
    if (item.tag == 0)
    {
        self.navigationItem.title =@"广场";
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else if(item.tag == 1)
    {
        self.navigationItem.title = @"预测";
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else if (item.tag == 2)
    {
        
        Info *info1 = [Info getInstance];
        if ([info1.userId intValue]) {
            
            self.navigationItem.title = @"好友";
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            if (counttag == 0) {
                self.navigationItem.title = @"广场";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                self.navigationItem.title = @"预测";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }
            
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            cai.gaodian = YES;
            
            [cai showMessage:@"登录后可用"];
            cai.gaodian = NO;
        }
    }
    else if(item.tag == 3){
        
        Info *info1 = [Info getInstance];
        if ([info1.userId intValue]) {
            self.navigationItem.title = @"消息";
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            if (counttag == 0) {
                self.navigationItem.title = @"广场";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                self.navigationItem.title = @"预测";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            cai.gaodian = YES;
            [cai showMessage:@"登录后可用"];
            cai.gaodian = NO;
            
        }
        
        
    }else if (item.tag == 4)
    {
        Info *info1 = [Info getInstance];
        if ([info1.userId intValue]) {
            self.navigationItem.title = @"资料";
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            if (counttag == 0) {
                self.navigationItem.title = @"广场";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }else{
                self.navigationItem.title = @"预测";
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            cai.gaodian = YES;
            [cai showMessage:@"登录后可用"];
            cai.gaodian = NO;
            
        }
        
    }
    
    if (item.tag < 2) {
        counttag = item.tag;
    }
    
    
    
}//回调

- (void)cpViewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hidenMessage];
    // caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [appdelegate.keFuButton calloff];
    
}//即将消失


- (void)cpViewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
#ifndef isHaoLeCai
    [UIApplication sharedApplication].statusBarHidden = NO;
#endif
    UINavigationController *nav = (UINavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController;
    if ([nav.viewControllers count]>=2) {
        CP_TabBarViewController *tabV = [nav.viewControllers objectAtIndex:1];
        if ([tabV.selectedViewController isKindOfClass:[GouCaiViewController class]]||[tabV.selectedViewController isKindOfClass:[GCHeMaiInfoViewController class]]) {
            caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
            caiboappdelegate.keFuButton.hidden = NO;
            [caiboappdelegate.keFuButton chulaitiao];
            if (caiboappdelegate.keFuButton.markbool) {
                caiboappdelegate.keFuButton.show = YES;
            }else{
                caiboappdelegate.keFuButton.show = NO;
            }
            return;
        }
    }
    Info *info2 = [Info getInstance];
    if (![info2.userId intValue]) {
        //		UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"注册" Target:self action:@selector(doRegister)];
        //		[self.navigationItem setLeftBarButtonItem:leftItem];
        //		[leftItem release];
        //        UIButton * buttxie = (UIButton *)[self.navigationItem.titleView viewWithTag:99];
        //        buttxie.hidden = YES;
        //        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        //        self.navigationItem.leftBarButtonItem = leftItem;
        //        [leftItem release];
        UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
        [tab.navigationItem setRightBarButtonItem:rightItem];
    }
    else {
        if (tab.selectedIndex != 3) {
            UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_xie.png");
            
            rigthItem.bounds = CGRectMake(150,12, 23, 24);
            
            [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
            [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
            
            tab.navigationItem.rightBarButtonItem = rigthItemButton;
            [rigthItemButton release];
        }
        
        
    }
    
    if ( tab.selectedIndex == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    }
    
    //       if (self.selectedIndex == 0 || self.selectedIndex == 2) {
    //         [[NSNotificationCenter defaultCenter] postNotificationName:@"shuantab" object:nil];
    //    }
    
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
    
    
    
    
    
}//即将出现
- (void)myLotteryFunc{
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        
        if ([[GC_HttpService sharedInstance].sessionId length] ||[[[Info getInstance] userId] intValue] == 0) {
            HRSliderViewController *my = [[[HRSliderViewController alloc] init] autorelease];
            [self.navigationController pushViewController:my animated:YES];
        }else{
            [self activityIndicatorViewshow];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wodecaipiaotongzhi) name:@"hasGetsession_id" object:nil];
        }
        
    }
    else {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
#endif
    }
}

- (void)wodecaipiaotongzhi{
    [statepop dismiss];
    HRSliderViewController *my = [[[HRSliderViewController alloc] init] autorelease];
    [self.navigationController pushViewController:my animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)pressIconButton:(UIButton *)sender{
    
    [self iconButtonTounchAnimationFunc:sender];

    if (sender.tag == 1) {//开奖榜单
        [self LastLotteryFunc];
    }else if (sender.tag == 2) {//赛事直播
        [self pressbfsp];
        
    }else if (sender.tag == 3) {//pk赛
        
    }else if (sender.tag == 4) {//比分直播
        [self scoreLiveFunc];
    }else if (sender.tag == 5) {//11选5赛马场
        
    }else if (sender.tag == 6) {//我的彩票
        [self myLotteryFunc];
    }
}

- (void)TouchDown:(UIButton *)sender{

    [self iconButtonDownAnimationFunc:sender];
}

- (void)TouchCancel:(UIButton *)sender{

    [self iconButtonTounchAnimationFunc:sender];
}

- (void)TouchDragExit:(UIButton *)sender{
    [self iconButtonTounchAnimationFunc:sender];
}

- (void)bigImageAnimationFunc{

    [UIView beginAnimations:@"200" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [bigView.layer setCornerRadius:0];
    bigView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 278);
    bigView.alpha = 1;
    UIImageView * bigImageView = (UIImageView *)[bigView viewWithTag:101];
    bigImageView.frame = bigView.bounds;
    [UIView commitAnimations];
    
}

- (void)oneButtonAnimationFunc{
    
    UIButton * iconButton1 = (UIButton *)[upImageView viewWithTag:1];
    [UIView beginAnimations:@"201" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopOneButtonAnimation)];
    iconButton1.frame = CGRectMake(6 , 9, 98+4, 97+4);
    iconButton1.alpha = 1;
    
    [UIView commitAnimations];

}
- (void)stopOneButtonAnimation{
    UIButton * iconButton1 = (UIButton *)[upImageView viewWithTag:1];
    [UIView beginAnimations:@"202" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton1.frame = CGRectMake(8 , 11, 98, 97);
    [UIView commitAnimations];

}

- (void)twoButtonAnimationFunc{
    
    UIButton * iconButton2 = (UIButton *)[upImageView viewWithTag:2];
    [UIView beginAnimations:@"203" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopTwoButtonAnimation)];
    iconButton2.frame = CGRectMake(109 , 9, 98+4, 97+4);
    iconButton2.alpha = 1;
    
    [UIView commitAnimations];
    
}

- (void)stopTwoButtonAnimation{
    UIButton * iconButton2 = (UIButton *)[upImageView viewWithTag:2];
    [UIView beginAnimations:@"204" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton2.frame = CGRectMake(111 , 11, 98, 97);
    [UIView commitAnimations];
    
}

- (void)threeButtonAnimationFunc{
    
    UIButton * iconButton3 = (UIButton *)[upImageView viewWithTag:3];
    [UIView beginAnimations:@"205" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopThreeButtonAnimation)];
    iconButton3.frame = CGRectMake(211 , 9, 98+4, 97+4);
    iconButton3.alpha = 1;
    
    [UIView commitAnimations];
    
}

- (void)stopThreeButtonAnimation{
    UIButton * iconButton3 = (UIButton *)[upImageView viewWithTag:3];
    [UIView beginAnimations:@"206" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton3.frame = CGRectMake(213 , 11, 98, 97);
    [UIView commitAnimations];
    
}

- (void)fourButtonAnimationFunc{
    
    UIButton * iconButton4 = (UIButton *)[upImageView viewWithTag:4];
    [UIView beginAnimations:@"207" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopFourButtonAnimation)];
    iconButton4.frame = CGRectMake(6 , 113, 98+4, 97+4);
    iconButton4.alpha = 1;
    
    [UIView commitAnimations];
    
}

- (void)stopFourButtonAnimation{
    UIButton * iconButton4 = (UIButton *)[upImageView viewWithTag:4];
    [UIView beginAnimations:@"208" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton4.frame = CGRectMake(8 , 113, 98, 97);
    [UIView commitAnimations];
    
}

- (void)fiveButtonAnimationFunc{
    
    UIButton * iconButton5 = (UIButton *)[upImageView viewWithTag:5];
    [UIView beginAnimations:@"207" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopFiveButtonAnimation)];
    iconButton5.frame = CGRectMake(109 , 113, 98+4, 97+4);
    iconButton5.alpha = 1;
    
    [UIView commitAnimations];
    
}

- (void)stopFiveButtonAnimation{
    UIButton * iconButton5 = (UIButton *)[upImageView viewWithTag:5];
    [UIView beginAnimations:@"208" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton5.frame = CGRectMake(111 , 113, 98, 97);
    [UIView commitAnimations];
    
}

- (void)sixButtonAnimationFunc{
    
    UIButton * iconButton6 = (UIButton *)[upImageView viewWithTag:6];
    [UIView beginAnimations:@"209" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopSixButtonAnimation)];
    iconButton6.frame = CGRectMake(211 , 113, 98+4, 97+4);
    iconButton6.alpha = 1;
    
    [UIView commitAnimations];
    
}

- (void)stopSixButtonAnimation{
    UIButton * iconButton6 = (UIButton *)[upImageView viewWithTag:6];
    [UIView beginAnimations:@"211" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iconButton6.frame = CGRectMake(213 , 113, 98, 97);
    [UIView commitAnimations];
    
}

- (void)goButtonAnimatonFunc{
    
    
    [UIView beginAnimations:@"212" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopgoButtonAnimation)];
    
    
    goButton.frame = CGRectMake(12, 501, 50+4, 50+4);
    goButton.alpha = 1;
    
    [UIView commitAnimations];

    
}

- (void)stopgoButtonAnimation{
    [UIView beginAnimations:@"213" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    goButton.frame = CGRectMake(14, 503, 50, 50);
    [UIView commitAnimations];
}



- (void)iconButtonAnimationFunc{

    [self performSelector:@selector(oneButtonAnimationFunc) withObject:self afterDelay:0];
    [self performSelector:@selector(twoButtonAnimationFunc) withObject:self afterDelay:0.15];
    [self performSelector:@selector(threeButtonAnimationFunc) withObject:self afterDelay:0.3];
    [self performSelector:@selector(fourButtonAnimationFunc) withObject:self afterDelay:0.45];
    [self performSelector:@selector(fiveButtonAnimationFunc) withObject:self afterDelay:0.6];
    [self performSelector:@selector(sixButtonAnimationFunc) withObject:self afterDelay:0.75];
    [self performSelector:@selector(goButtonAnimatonFunc) withObject:self afterDelay:0.9];

}


- (void)homeAnimationFunc{
    
    [self performSelector:@selector(bigImageAnimationFunc) withObject:self afterDelay:0];
    [self performSelector:@selector(iconButtonAnimationFunc) withObject:self afterDelay:0];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
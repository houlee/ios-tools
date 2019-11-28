 //
//  IpadRootViewController.m
//  caibo
//
//  Created by houchenguang on 13-4-23.
//
//

#import "IpadRootViewController.h"
#import "GouCaiViewController.h"
#import "UDIDFromMac.h"
#import "MobClick.h"
#import "caiboAppDelegate.h"
#import "LiveScoreViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GouCaiHomeViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "NewsViewController.h"
#import "Info.h"
#import "GC_HttpService.h"
#import "SachetViewController.h"
#import "CPSetViewController.h"
#import "LoginViewController.h"
#import "GC_BaFangShiPingViewController.h"
#import "GCSearchViewController.h"
#import "KFButton.h"
#import "JSON.h"
#import "NetURL.h"
#import "CheckNewMsg.h"
#import "KFMessageBoxView.h"
#import "scoreLiveTelecastViewController.h"
#import "LiveScoreViewController.h"
#import "singletonData.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
@interface IpadRootViewController ()

@end

@implementation IpadRootViewController
@synthesize chekrequest;

- (void)scoreLiveFunc{
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    LiveScoreViewController *lsViewController = [[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil];
	[self.navigationController pushViewController:lsViewController animated:YES];
    [lsViewController release];
    return;
    
    singletonData * singleton = [singletonData getInstance];//全清一下
    singleton.selectTile = 0;
    singleton.myTitle = 0;
    singleton.liveTitle = 0;
    singleton.endTitle = 0;
    singleton.liveIssue = @"";
    singleton.myIssue = @"";
    singleton.endIssue = @"";
  //  [singleton.allDataArray removeAllObjects];
  //  [singleton.endAllDataArray removeAllObjects];
  //  [singleton.myAllDataArray removeAllObjects];
    
    
    scoreLiveTelecastViewController * liveController = [[scoreLiveTelecastViewController alloc] init];
    liveController.allType = liveType;
    
    scoreLiveTelecastViewController * myController = [[scoreLiveTelecastViewController alloc] init];
    myController.allType = myAttentionType;
    
    scoreLiveTelecastViewController * endController = [[scoreLiveTelecastViewController alloc] init];
    endController.allType = endType;
    
    
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:liveController, myController,endController, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"直播中"];
    [labearr addObject:@"我的关注"];
    [labearr addObject:@"已结束"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"zhibobisai.png"];
    [imagestring addObject:@"wodeguanzhu.png"];
    [imagestring addObject:@"jieshubisai.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"zhibobisai_1.png"];
    [imageg addObject:@"wodeguanzhu_1.png"];
    [imageg addObject:@"jieshubisai_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        tabc.selectedIndex = 1;
    }else{
        tabc.selectedIndex = 0;
    }
    
    
    
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [liveController release];
    [myController release];
    [endController release];
    
}

- (void)requestChekNew{
    
    self.chekrequest = [ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]];
    //  [self setMrequest:[ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]]];
    [chekrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [chekrequest setDelegate:self];
    [chekrequest setDidFinishSelector:@selector(unReadPushNumData:)];
    //   [chekrequest setDidFailSelector:@selector(unReadPushNumDatafail:)];
    [chekrequest setNumberOfTimesToRetryOnTimeout:2];
    [chekrequest setShouldContinueWhenAppEntersBackground:YES];
    [chekrequest startAsynchronous];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    
//    self.view.frame = CGRectMake(0, 100, 768, 400);
    con = 6;
    counhaoyou = 0;
        
    self.view.layer.masksToBounds = YES;
    menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 63)];
    menuView.backgroundColor = [UIColor clearColor];
//    menuView.alpha = 0.5;
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    //    [appcaibo.window insertSubview:menuView belowSubview:self.view];
    [appcaibo.window insertSubview:menuView atIndex:0];
    [menuView release];
    
    UIImageView * zuoimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63-29, 1536/2, 59/2)];
    zuoimage.backgroundColor = [UIColor clearColor];
    zuoimage.image = UIImageGetImageFromName(@"leftyin.png");
    [appcaibo.window insertSubview:zuoimage atIndex:1];
    
    UIImageView * youimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63+390, 1536/2, 57/2)];
    youimage.backgroundColor = [UIColor clearColor];
    youimage.image = UIImageGetImageFromName(@"rightyin.png");
    [appcaibo.window insertSubview:youimage atIndex:2];
    
    //客服按钮
    UIButton *kfbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    kfbtn.frame = CGRectMake(670, 950, 36, 35);
    [kfbtn setImage:UIImageGetImageFromName(@"XKF960foripad.png") forState:UIControlStateNormal];
    [kfbtn addTarget:self action:@selector(pressKeFuButton) forControlEvents:UIControlEventTouchUpInside];
    [appcaibo.window insertSubview:kfbtn atIndex:2];
    
    selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(48+(58*7)+105+(7*10), 0, 44, 63)];
    selectImage.image = UIImageGetImageFromName(@"selectiamgepad.png");
//    selectImage.backgroundColor = [UIColor yellowColor];
    [menuView addSubview:selectImage];
    [selectImage release];
    
    
    
    for (int i = 0; i < 8; i++) {//导航的8个按钮
        
        UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setShowsTouchWhenHighlighted:YES];
        NSString * iamgename = [NSString stringWithFormat:@"ipadmenu%d.png", 8-i ];
        [menuButton setImage:UIImageGetImageFromName(iamgename) forState:UIControlStateNormal];
        menuButton.tag = 8-i;
        [menuButton addTarget:self action:@selector(pressMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i < 2) {
            menuButton.frame = CGRectMake(48+(58*i)+(i*10), 0, 44, 63);
        }else{
            menuButton.frame = CGRectMake(48+(58*i)+105+(i*10), 0, 44, 63);
        }
        [menuView addSubview:menuButton];
        
//        UILabel * menuName = [[UILabel alloc] init];
//        menuName.backgroundColor = [UIColor clearColor];
//        menuName.textColor = [UIColor blackColor];
//        menuName.textAlignment = NSTextAlignmentCenter;
//        menuName.font = [UIFont boldSystemFontOfSize:14];
//        
//        if (i < 2) {
//             menuName.frame =CGRectMake(3+(i*58)+(10*i), 37, 94, 20);
//        }else{
//             menuName.frame = CGRectMake(3+(58*i)+105+(i*10), 37, 94, 20);
//        }
//        if (i == 0) {
//           menuName.text = @"设置";
//        }else if(i == 1){
//            menuName.text = @"搜索";
//        }else if(i == 2){
//            menuName.text = @"好声音";
//        }else if(i == 3){
//            menuName.text = @"我的彩票";
//        }else if(i == 4){
//            menuName.text = @"赛事直播";
//        }else if(i == 5){
//            menuName.text = @"比分直播";
//        }else if(i == 6){
//            menuName.text = @"微博";
//        }else if(i == 7){
//            menuName.text = @"购彩";
//        }
//        
//        [menuView addSubview:menuName];
//        
//        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
//        rotationAnimation.duration = 0.0f;
//        
//        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        [menuName.layer addAnimation:rotationAnimation forKey:@"run"];
//        menuName.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
//        [menuName release];
        
        
    }
    
    for (int i = 2; i < 8; i++) {//图片按钮下面的文字
        UIImageView * weiZi = [[UIImageView alloc] initWithFrame:CGRectMake(48+(58*i)+105+(i*10)-10, 0, 16, 63)];
         NSString * weiziName= [NSString stringWithFormat:@"weizitext%d.png", 8-i+10 ];
        weiZi.image = UIImageGetImageFromName(weiziName);
        weiZi.tag = 8-i+10;
        weiZi.backgroundColor = [UIColor clearColor];
        [menuView addSubview:weiZi];
        [weiZi release];
    }
    
    
    
    weiboNew = [[UIImageView alloc] initWithFrame:CGRectMake(48+(58*6)+105+(6*10)+44-20, 63-32, 20, 26)];
    weiboNew.image = UIImageGetImageFromName(@"ipadweibonew.png");
    weiboNew.backgroundColor = [UIColor clearColor];
    weiboNew.hidden = YES;
    [menuView addSubview:weiboNew];
    [weiboNew release];
      
    [self goBuy];

    UIButton * selectButton = (UIButton *)[menuView viewWithTag:1];
    NSString * iamgename = [NSString stringWithFormat:@"ipadmenu%d_1.png", 1 ];
    [selectButton setImage:UIImageGetImageFromName(iamgename) forState:UIControlStateNormal];
    UIImageView * weiziImage = (UIImageView *)[menuView viewWithTag:11];
    weiziImage.hidden = YES;
    
    
    [self requestChekNew];
}

- (void)weiBoHome:(BOOL)homeOrNew{
    con = 6;
    [MobClick event:@"event_weibohudong"];
    HomeViewController * home = [[HomeViewController alloc] initWithBool:YES];
    home.dajiabool = YES;
    home.title = @"广场";
    [home.navigationController setNavigationBarHidden:YES];
    //    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:home];
    //    [nav setNavigationBarHidden:YES];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 6) {
    //        [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    
    NewsViewController * news = [[NewsViewController alloc] init];
    news.title = @"新闻";
    [news.navigationController setNavigationBarHidden:YES];
    
    HomeViewController * mygz = [[HomeViewController alloc] initWithBool:NO];
    mygz.dajiabool = NO;
    [mygz.navigationController setNavigationBarHidden:YES];
    mygz.title = @"好友";
    
    MessageViewController * mvc = [[MessageViewController alloc] init];
    mvc.title = @"消息";
    [mvc.navigationController setNavigationBarHidden:YES];
    
    MyProfileViewController * mypro = [[MyProfileViewController alloc] init];
    mypro.title = @"资料";
    [mypro.navigationController setNavigationBarHidden:YES];
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:home, news, mygz, mvc, mypro, nil];
    
    //    self.viewControllers = controllers;
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"广场"];
    [labearr addObject:@"新闻"];
    [labearr addObject:@"好友"];
    [labearr addObject:@"消息"];
    [labearr addObject:@"资料"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"gc47.png"];
    [imagestring addObject:@"xw48.png"];
    [imagestring addObject:@"hy50.png"];
    [imagestring addObject:@"xx52.png"];
    [imagestring addObject:@"zl54.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"gc46.png"];
    [imageg addObject:@"xw49.png"];
    [imageg addObject:@"hy51.png"];
    [imageg addObject:@"xx53.png"];
    [imageg addObject:@"zl55.png"];
    counhaoyou = 0;
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    //    home.view.frame = CGRectMake(0, 0, 320, aapp.window.frame.size.height-49);
    tab = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    
    tab.delegateCP = self;
    tab.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    if (homeOrNew) {
        tab.selectedIndex = 0;
    }else{
        tab.selectedIndex = 1;
    }
    
    [self.navigationController pushViewController:tab animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tab release];
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hometozhuye" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backaction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeAction) name:@"hometozhuye" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAction) name:@"backaction" object:nil];
    
}

- (void)menuButtonUpData:(UIButton *)sender{
    selectImage.frame = sender.frame;
    for (int  i = 0; i < 8; i++) {
        UIButton * selectButton = (UIButton *)[menuView viewWithTag:8-i];
        if (sender.tag == 8-i) {
            
            NSString * iamgename = [NSString stringWithFormat:@"ipadmenu%d_1.png", 8-i ];
            [selectButton setImage:UIImageGetImageFromName(iamgename) forState:UIControlStateNormal];
            if (sender.tag < 7) {
                UIImageView * weizi = (UIImageView *)[menuView viewWithTag:8-i+10];
                weizi.hidden = YES;
            }
            
        }else{
            
            NSString * iamgename = [NSString stringWithFormat:@"ipadmenu%d.png", 8-i ];
            [selectButton setImage:UIImageGetImageFromName(iamgename) forState:UIControlStateNormal];
            if (sender.tag < 7) {
                UIImageView * weizi = (UIImageView *)[menuView viewWithTag:8-i+10];
                weizi.hidden = NO;
            }
            
        }
        
        
    }

    if (sender.tag == 7||sender.tag == 8){
        
        for(int i = 1; i < 7; i++){
        
            UIImageView * weizi = (UIImageView *)[menuView viewWithTag:i+10];
            weizi.hidden = NO;
        }
    
    }

}


- (void)pressMenuButton:(UIButton *)sender{
    
    if (sender.tag == 8) {
        
    }else{
        
        if (sender.tag == 5 || sender.tag == 6 ||sender.tag == 7 ||sender.tag == 8) {
            Info *info1 = [Info getInstance];
            if ([info1.userId intValue]) {
                [self menuButtonUpData:sender];
            }
        }else{
             [self menuButtonUpData:sender];
        }
       
    }
    
    
    
    
    if (sender.tag == 1) {//购彩
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self goBuy];
        
    }else if (sender.tag == 2){//微博
      
        Info *info = [Info getInstance];
        if ([info.userId intValue]) {
            
            
            
            
            if ([[GC_HttpService sharedInstance].sessionId length]|| [[[Info getInstance] userId] intValue] == 0) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                [self weiBoHome:YES];
                tab.loginyn = YES;
                
            }else{
                [self activityIndicatorViewshow];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weibotongzhi) name:@"hasGetsession_id" object:nil];
            }
            
            
            
        }
        else {
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self weiBoHome:NO];
            tab.loginyn = YES;
        }
          weiboNew.hidden = YES;
        Info *info1 = [Info getInstance];
        if ([info1.userId intValue]) {
            counttag = 0;
            //        tab.navigationItem.title = @"广场";
        }else{
            
            counttag = 1;
            //        tab.navigationItem.title = @"新闻";
        }

        
    }else if(sender.tag == 3){//比分直播
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        LiveScoreViewController *lsViewController = [[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil];
//        [self.navigationController pushViewController:lsViewController animated:NO];
//        [lsViewController release];
        
        
        [self scoreLiveFunc];
    
    }else if(sender.tag == 4){//赛事直播
        [self.navigationController popToRootViewControllerAnimated:NO];
        GC_BaFangShiPingViewController * shipin = [[GC_BaFangShiPingViewController alloc] init];
        [self.navigationController pushViewController:shipin animated:NO];
        [shipin release];
        
    }else if(sender.tag == 5){//我的彩票
        
        Info *info = [Info getInstance];
        if ([info.userId intValue]) {
            
            if ([[GC_HttpService sharedInstance].sessionId length] ||[[[Info getInstance] userId] intValue] == 0) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                
                GouCaiHomeViewController *my = [[GouCaiHomeViewController alloc] init];
                my.title = @"我的彩票";
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                [self.navigationController pushViewController:my animated:NO];
                [my release];
                
            }else{
                [self activityIndicatorViewshow];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wodecaipiaotongzhi) name:@"hasGetsession_id" object:nil];
            }
            
        }
        else {
            [[caiboAppDelegate getAppDelegate] LoginForIpad];            
            
        }

        
    }else if(sender.tag == 6){//好声音
        
        if ([[[Info getInstance] userId] intValue] == 0) {
            
            [[caiboAppDelegate getAppDelegate] LoginForIpad];
            
        }else {
        
            [self.navigationController popToRootViewControllerAnimated:NO];
            SachetViewController *sac = [[SachetViewController alloc] init];
            [self.navigationController pushViewController:sac animated:NO];
            [sac release];

        }
                
    }else if(sender.tag == 7){//搜索
        
        if ([[[Info getInstance] userId] intValue] == 0) {
            
            [[caiboAppDelegate getAppDelegate] LoginForIpad];
        
        }else {
        
//            caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
            GCSearchViewController * gcsear = [[GCSearchViewController alloc] init];
//            [(UINavigationController *)caiboapp.window.rootViewController pushViewController:gcsear animated:YES];
            [self.navigationController pushViewController:gcsear animated:NO];
            [gcsear searchbegin];
            [gcsear release];
        }
                
    }else if(sender.tag == 8){//设置
        
          [[caiboAppDelegate getAppDelegate] SettingForiPad];
    }
    
}

- (void)wodecaipiaotongzhi{
//    [statepop dismiss];
    [loadview stopRemoveFromSuperview];
    loadview ＝ nil;
    GouCaiHomeViewController *my = [[GouCaiHomeViewController alloc] init];
    my.title = @"我的彩票";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:my animated:YES];
    [my release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)activityIndicatorViewshow{
    

    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
//    statepop = [StatePopupView getInstance];
//    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//    [statepop showInView:appDelegate.window Text:@"请稍等..."];
    
    [appDelegate LogInBySelf];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissstatepop) name:@"dissmisspop" object:nil];
    //if ([[GC_HttpService sharedInstance].sessionId length]) {
    //[statepop dismiss];//去掉转圈
}
- (void)dissmissstatepop{
//    [statepop dismiss];
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
}

- (void)weibotongzhi{
//    [statepop dismiss];
    [loadview stopRemoveFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:NO];
   
    [self weiBoHome:YES];
    tab.loginyn = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)pressKeFuButton {
    
    KFButton * kfb = [[KFButton alloc] init];
    [kfb kfbuttonbig];
    [kfb release];
}

- (void)goBuy {
    
    
    [MobClick event:@"event_goumai"];
    GouCaiViewController *gou = [[GouCaiViewController alloc] init];
    gou.title = @"购买彩票";
    GouCaiViewController *gou2 = [[GouCaiViewController alloc] init];
    gou2.title = @"购买彩票";
    gou2.fistPage = 1;
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:gou, gou2, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"数字彩"];
    [labearr addObject:@"足篮彩"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"I8Y-960.png"];
    [imagestring addObject:@"ILY-960.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"I8-960.png"];
    [imageg addObject:@"IL-960.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"ipadFist"] integerValue]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"ipadFist"];
        tabc.selectedIndex = 0;
    }
    else {
        tabc.selectedIndex = 1;
    }
    if (tabc.selectedIndex == 0) {
        [MobClick event:@"event_goumai_shuzicai"];
    }
    else {
        [MobClick event:@"event_goumai_zucai"];
    }
    tabc.delegateCP = self;
    
    tabc.navigationController.navigationBarHidden = YES;
    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];

    
    
    [self.navigationController pushViewController:tabc animated:NO];
//    tabc.view.frame = CGRectMake(100, 0, 400, 700);
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [gou release];
    [gou2 release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
//    [loadview release];
    [chekrequest clearDelegatesAndCancel];
    [chekrequest release];
   [super dealloc];
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


#pragma mark tabbarcontroller delegate
- (void)cpTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if ([tabBarController.selectedViewController isKindOfClass:[GouCaiViewController class]]) {
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
        
        
        selectedTab = tabBarController.selectedIndex;
        
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
        if ([tabV.selectedViewController isKindOfClass:[GouCaiViewController class]]) {
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
		self.navigationItem.title = @"新闻";
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
                self.navigationItem.title = @"新闻";
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
                self.navigationItem.title = @"新闻";
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
                self.navigationItem.title = @"新闻";
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



- (void)cpViewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationController *nav = (UINavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController;
    if ([nav.viewControllers count]>=2) {
        CP_TabBarViewController *tabV = [nav.viewControllers objectAtIndex:1];
        if ([tabV.selectedViewController isKindOfClass:[GouCaiViewController class]]) {
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
    
    
    
   
    
}//即将出现


- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{
    
    
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = [hongbao.showType integerValue]-1;
        prizeView.tag = 200;
        prizeView.delegate = self;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
 
    
    if ([[dict objectForKey:@"pl"] intValue] != 0||[[dict objectForKey:@"gz"] intValue] != 0|| [[dict objectForKey:@"atme"] intValue] != 0|| [[dict objectForKey:@"sx"] intValue] != 0) {
        
        
//        [interaction setImage:UIImageGetImageFromName(@"GC_NEW.png") forState:UIControlStateNormal];
//        [interaction setImage:UIImageGetImageFromName(@"GC_NEW_0.png") forState:UIControlStateHighlighted];
        weiboNew.hidden = NO;
        
        
    } else {
//        [interaction setImage:UIImageGetImageFromName(@"cpthree_jd.png") forState:UIControlStateNormal];
//        [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateHighlighted];
        weiboNew.hidden = YES;
//        
    }
//    if ([[dict objectForKey:@"zj"] intValue] == 0) {
//		[set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
//		[set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
//	}
//	else {
//		[set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_1.png") forState:UIControlStateNormal];
//		[set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_0.png") forState:UIControlStateHighlighted];
//	}
    
    
    
}

-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}
-(void)autoRefresh:(NSString*)responseString{
    
    
	if (responseString) {
		
		CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
        
        NSLog(@"checkkkkkkkkkkkkkkkkkkkkk %@, %@, %@, %@,中奖%@", check.gzrft, check.atme, check.sx, check.pl,check.zj);
        
        if (![check.pl isEqualToString:@"0" ]||![check.gz isEqualToString:@"0" ]|| ![check.atme isEqualToString:@"0"]|| ![check.sx isEqualToString:@"0"]||![check.gzrft isEqualToString:@"0" ]) {
            
            
            weiboNew.hidden = NO;
            
        }else{
            weiboNew.hidden = YES;
        }
		
//		if ([check.zj isEqualToString:@"0"]) {
//			[set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
//			[set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
//		}
//		else {
//			[set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_1.png") forState:UIControlStateNormal];
//			[set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_0.png") forState:UIControlStateHighlighted];
//		}
       
        
        
        NSString * leixingarr = [NSString stringWithFormat:@"%@,%@,%@,%@", check.atme, check.pl,check.sx,check.xttz];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leixingbiaoji" object:leixingarr];
        
        
               
		[check release];
		
	}
    
}




@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  caiboAppDelegate.m
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  yao


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import "caiboAppDelegate.h"
#import "DataBase.h"
#import "YDDebugTool.h"
#import "LoginViewController.h"
#import "datafile.h"
#import "ASIHTTPRequest.h"
#import "Info.h"
#import "NetURL.h"
#import "CheckNewMsg.h"
#import "SBJSON.h"
#import "User.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "NSDate-Helper.h"
#import "JSON.h"
#import "RegisterViewController.h"
#import "LotteryPreferenceViewController.h"
#import "UserInfo.h"
#import "YDUtil.h"
#import "MyProfileViewController.h"
#import "GC_HttpService.h"
#import "NSDate-Helper.h"
#import "PreJiaoDianTabBarController.h"
#import "GC_HeartInfo.h"
#import "PPTVLoginViewController.h"
#import "GouCaiViewController.h"
#import "LoginViewController.h"
#import "GoodVoiceJieXie.h"
#import "MobClick.h"
#import "UDIDFromMac.h"
#import <QuartzCore/QuartzCore.h>
#import "CPSetViewController.h"
#import "PhotographViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShuangSeQiuInfoViewController.h"
#import "GC_UserInfo.h"
#import "CP_APPAlertFlashAdView.h"
#import "DetailedViewController.h"
#import "MyWebViewController.h"
#import "MLNavigationController.h"
#import "StartPageView.h"
#import "GC_UPMPViewController.h"
//#import "DataVerifier.h"
#import "ZipArchive.h"
#import "HongBaoInfo.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "SendMicroblogViewController.h"
#import "KJXiangQingViewController.h"
#import <AVFoundation/AVFoundation.h>
#ifdef isCaiPiaoForIPad
#import "IpadRootViewController.h"
#endif

#ifdef isHaoLeCai
#import "AWAppStatusReport.h"
#endif

#define  kwelcomePicName   @"Default.png"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
#import "GC_TopUpViewController.h"
#import "ProvingViewCotroller.h"
#import "GouCaiHomeViewController.h"
#import "HighFreqViewController.h"
#import "SharedDefine.h"
#import "KuaiSanViewController.h"
#import "HappyTenViewController.h"
#import "ShiShiCaiViewController.h"
#import "CQShiShiCaiViewController.h"
#import "FuCai3DViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "QIleCaiViewController.h"
#import "Pai3ViewController.h"
#import "DaLeTouViewController.h"
#import "GCJCBetViewController.h"
#import "KuaiLePuKeViewController.h"
#import "GCBettingViewController.h"
#import "GC_BJDanChangViewController.h"
#import "HRSliderViewController.h"
#import "LastLotteryViewController.h"
#import "LiveScoreViewController.h"

//#import "JPEngine.h"
#import "GCHeMaiInfoViewController.h"

#import "RequestEntity.h"
#import "ExpertHomeViewController.h"
#import "MatchViewController.h"
#import "ShenDanMyViewController.h"
#import "ExpertViewController.h"
#import "MyViewController.h"
#import "RankListVc.h"
#import "SuperiorViewController.h"
#import "ExpertNewMainViewController.h"
#import "Expert365Bridge.h"
#import "SMGDetailViewController.h"
#import "MatchDetailVC.h"

@implementation caiboAppDelegate

@synthesize window;
@synthesize changeAccount, urlDefault;
@synthesize timer;
@synthesize delegate;
@synthesize mrequest,loginselfRequest;
@synthesize homeItem;
@synthesize focusItem;
@synthesize lastAccount;
@synthesize imageDownloader;
@synthesize isBubbleTheme;
@synthesize readingMode;
@synthesize selectedTab;
@synthesize isNeedRefresh;
@synthesize gaodian;
@synthesize jiangetime;
@synthesize hylistcont;
@synthesize hylistarray;
@synthesize keFuButton;
@synthesize loginselfcount;
@synthesize urlVersion;
@synthesize isloginIng;
@synthesize upDataCheck;
@synthesize alertImage;
@synthesize linkUrl;
@synthesize autoRequest;
@synthesize uploadTime;
@synthesize jihuoHongbaoMsg;


- (void)zipUncompressFunc{//解压缩

    ZipArchive* zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSString* l_zipfile = [documentpath stringByAppendingString:@"/defaultZIP.zip"] ;
    NSString* unzipto = [documentpath stringByAppendingString:@"/defaultTest"] ;
    if( [zip UnzipOpenFile:l_zipfile] )
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
        }
        [zip UnzipCloseFile];
    }  
    [zip release];

}

- (void)requestLoadDefault:(NSString *)version{//请求default压缩文件
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL getStartPicInfoWithVersion:version]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getStartPicInfoFinished:)];
    [request setDidFailSelector:@selector(getStartPicInfoFailed:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
}

- (void)openFileFunc{//读解压缩后的文件

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"openDefault"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"openDefault"] intValue] == 1) {
            [self addWelcomePage];
            [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
            return;
        }
    }
   
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"openDefault"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *plistPath = [path stringByAppendingPathComponent:@"defaultTest"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:plistPath]) {//判断这个defaultTest路径是否存在
        
//        defaultButton
        
        plistPath = [plistPath stringByAppendingPathComponent:@"StartAd.conf"];
        if ([fileManager fileExistsAtPath:plistPath]) {//判断配置文件路径是否存在
            NSData *fileData = [fileManager contentsAtPath:plistPath];
            if (fileData) {//成功的话
                
                NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
                
                
                NSDictionary * dict = [str JSONValue];
                
                NSString * startDate =  [dict objectForKey:@"startDate"] ;
                NSString * endDate =  [dict objectForKey:@"endDate"] ;
                
                NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
                
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                
                NSString * date = [formatter stringFromDate:[NSDate date]];
                
                
                NSTimeInterval _oneDate = [[NSDate dateFromString:startDate] timeIntervalSince1970]*1;
                NSTimeInterval _twoDate = [[NSDate dateFromString:endDate] timeIntervalSince1970]*1;
                NSTimeInterval _threeDate = [[NSDate dateFromString:date] timeIntervalSince1970]*1;

                if (_oneDate <= _threeDate && _threeDate <= _twoDate) {
                    
                    NSString * imagePath = [path stringByAppendingPathComponent:@"defaultTest"];
                    NSArray * imageArray = [dict objectForKey:@"adPic"];
                    if ([imageArray count] > 0) {
                        imagePath = [imagePath stringByAppendingPathComponent:[imageArray objectAtIndex:0]];
                        if ([fileManager fileExistsAtPath:imagePath]) {//如果图片存在的话
                            self.urlDefault = [dict objectForKey:@"clickUrl"];
                            self.window.userInteractionEnabled = YES;
                            defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            defaultButton.userInteractionEnabled = YES;
                            defaultButton.frame = self.window.bounds;
//                            NSLog(@"x = %f, y = %f, w = %f, h = %f", self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height);
                            [defaultButton addTarget:self action:@selector(pressDefaultButton:) forControlEvents:UIControlEventTouchUpInside];
                            
                            UIImageView * dimage = [[UIImageView alloc] initWithFrame:defaultButton.bounds];
//                            dimage.userInteractionEnabled = YES;
                            dimage.backgroundColor = [UIColor clearColor];
                            dimage.image = [UIImage imageWithContentsOfFile:imagePath];
                            [defaultButton addSubview:dimage];
                            [self.window addSubview:defaultButton];
                            [self.window bringSubviewToFront:defaultButton];
                            [dimage release];
                            [self DologinSave];
                            [self performSelector:@selector(dismissDefaultButton) withObject:nil afterDelay:3];
                            [self performSelector:@selector(requestLoadDefault:) withObject:[dict objectForKey:@"version"] afterDelay:3];
                            
                        }else{//如果图片不存在的话
                            
                            [self addWelcomePage];
                            [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
//                            [self requestLoadDefault:@"0"];
                            
                            
                        }

                    }else{
                        [self addWelcomePage];
                        [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
//                        [self requestLoadDefault:@"0"];
                    }
                    
                    
                    
                }else{
                    [self addWelcomePage];
                    [self performSelector:@selector(requestLoadDefault:) withObject:[dict objectForKey:@"version"] afterDelay:3];
//                    [self requestLoadDefault:[dict objectForKey:@"version"]];
                }
                
                
                
                
                
                [str release];
            }else{//失败的话
                [self addWelcomePage];
                [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
//                [self requestLoadDefault:@"0"];
            }

        }else{
            [self addWelcomePage];
            [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
//            [self requestLoadDefault:@"0"];
        }
        
        
        
        
    }else {//如果不存在
        [self addWelcomePage];
        [self performSelector:@selector(requestLoadDefault:) withObject:@"0" afterDelay:3];
//        [self requestLoadDefault:@"0"];
    }
    
    
}

- (void)pressDefaultButton:(UIButton *)sender{
    
    if ([self.urlDefault length] > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlDefault]];
    }

}

- (void)dismissDefaultButton{

     [defaultButton removeFromSuperview];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openDefault"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}



- (void)reachabilityChanged:(NSNotification *)note
{
    YD_FUNNAME;
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable)
    {
		UIAlertView *myalert = [[[UIAlertView alloc] initWithTitle:@"哎呀！" message:@"你的网络好像有问题，请重试！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil] autorelease];
		[myalert show];
		isloginIng = NO;
		[self performSelector:@selector(disAlert:) withObject:myalert afterDelay:3.0f];
    }
	
    YD_FUNNAME;
}


-(void)disAlert:(id)sender
{
	
	UIAlertView *myalert = (UIAlertView*)sender;
	[myalert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)cheackJihuo:(ASIHTTPRequest*)mrequest1 {
	NSDictionary *dic = [[mrequest1 responseString] JSONValue];
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        //红包提醒信息

        jihuoHongbaoMsg = [dic objectForKey:@"hongbaoMsg"];
        
        NSLog(@"激活接口红包信息 :%@",jihuoHongbaoMsg);
        
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"oneLogin"] integerValue] == 1){
            
            [self showJiHuoHongbao];
        }
    }
    
    
	if ([[dic objectForKey:@"result"] isEqualToString:@"0"]) {
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isJihuo"];
	}
}
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}
- (void)JihuoFail:(ASIHTTPRequest*)mrequest1 {
}

-(void)getBaseInfo
{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    [DEFAULTS removeObjectForKey:@"resultDic"];
    [DEFAULTS setObject:[NSDictionary dictionary] forKey:@"resultDic"];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":nameSty}];
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getExpertBaseInfo",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id JSON ) {
        NSDictionary * resultDic  = [NSDictionary dictionary];
        if (![JSON[@"result"] isEqual:[NSNull null]]) {
            resultDic = JSON[@"result"];
        }
        [DEFAULTS setObject:resultDic forKey:@"resultDic"];
    } failure:^(NSError *error) {
        
    }];
}


-(UITabBarController *)createExpert
{
    [MobClick event:@"Zj_home_20161014"];
    [self getBaseInfo];
    
#ifdef DONGGEQIU
    ExpertHomeViewController * ExpertC = [[ExpertHomeViewController alloc] init];
    MyWebViewController * informationViewController = [[MyWebViewController alloc] init];
    informationViewController.webTitle = @"资讯";
    [informationViewController LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.zgzcw.com/h5/c/zqfx16.html"]]];
    ShenDanMyViewController * MyC = [[ShenDanMyViewController alloc] init];
#else
    ExpertViewController * ExpertC = [[ExpertViewController alloc] init];
    MyViewController * MyC = [[MyViewController alloc] init];
#endif
    
    MatchViewController * MatchC = [[MatchViewController alloc] init];
    RankListVc *rankListVc = [[RankListVc alloc] init];
    SuperiorViewController * SuperC = [[SuperiorViewController alloc] init];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSString *zjSelected=@"";
        NSString *zjNormal=@"";
        NSString *gsSelected=@"";
        NSString *gsNormal=@"";
        NSString *phbSelected=@"";
        NSString *phbNormal=@"";
        NSString *ssSelected=@"";
        NSString *ssNormal=@"";
        NSString *wdSelected=@"";
        NSString *wdNormal=@"";
        NSString *infoSelected=@"";
        NSString *infoNormal=@"";
#if defined DONGGEQIU
        zjSelected=@"dgq_zj_selected";
        zjNormal=@"dgq_zj_normal";
        gsSelected=@"dgq_super_selected";
        gsNormal=@"dgq_super_normal";
        phbSelected=@"dgq_phb_selected";
        phbNormal=@"dgq_phb_normal";
        ssSelected=@"dgq_event_selected";
        ssNormal=@"dgq_event_normal";
        wdSelected=@"dgq_my_selected";
        wdNormal=@"dgq_my_normal";
        infoSelected=@"底部导航-资讯-点击";
        infoNormal=@"底部导航-资讯";
#else
        zjSelected=@"底部导航-专家-点击";
        zjNormal=@"底部导航-专家";
        gsSelected=@"底部导航-高手-点击";
        gsNormal=@"底部导航-高手";
        phbSelected=@"底部导航-排行榜-点击";
        phbNormal=@"底部导航-排行榜";
        ssSelected=@"底部导航-赛事-点击";
        ssNormal=@"底部导航-赛事";
        wdSelected=@"底部导航-我的-点击";
        wdNormal=@"底部导航-我的";
        infoSelected=@"底部导航-资讯-点击";
        infoNormal=@"底部导航-资讯";
#endif
        
        ExpertC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"专家" image:[[UIImage imageNamed:zjNormal]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:zjSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        SuperC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"高手" image:[[UIImage imageNamed:gsNormal]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:gsSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        rankListVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"排行榜" image:[[UIImage imageNamed:phbNormal]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:phbSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        MatchC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[[UIImage imageNamed:ssNormal]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:ssSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
#ifdef DONGGEQIU
        informationViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"资讯" image:[[UIImage imageNamed:infoNormal]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:infoSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
#endif
        MyC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"底部导航-我的"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:wdSelected]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    } else {
#ifdef DONGGEQIU
        ExpertC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"专家" image:[UIImage imageNamed:@"底部导航-专家"] tag:0];
        
        MatchC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"底部导航-赛事"] tag:1];
        
        informationViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"底部导航-资讯"] tag:2];
        
        MyC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"底部导航-我的"] tag:3];
#else
        ExpertC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"专家" image:[UIImage imageNamed:@"底部导航-专家"] tag:0];
        
        SuperC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"高手" image:[UIImage imageNamed:@"底部导航-高手"] tag:1];
        
        rankListVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"排行榜" image:[UIImage imageNamed:@"底部导航-排行榜"] tag:2];
        MatchC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"赛程" image:[UIImage imageNamed:@"底部导航-赛事"] tag:3];
        
        MyC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"底部导航-我的"] tag:4];
#endif
    }
    
    UITabBarController * tab2 = [[UITabBarController alloc]init];
    tab2.delegate = self;
#if defined YUCEDI
    if ([[caiboAppDelegate getAppDelegate] isShenhe]) {
        tab2.viewControllers = @[ExpertC,SuperC,rankListVc,MatchC];
    }
    else {
        tab2.viewControllers = @[ExpertC,SuperC,rankListVc,MatchC,MyC];
    }
#elif defined DONGGEQIU
    if ([[caiboAppDelegate getAppDelegate] isShenhe]) {
        tab2.viewControllers = @[ExpertC,MatchC,informationViewController];
    }
    else {
        tab2.viewControllers = @[ExpertC,MatchC,informationViewController,MyC];
    }
#else
    tab2.viewControllers = @[ExpertC,SuperC,rankListVc,MatchC,MyC];
#endif
    
    
    tab2.tabBar.opaque=YES;
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.87];
    [tab2.tabBar insertSubview:v atIndex:0];
    
    tab2.tabBar.backgroundImage = [UIImage imageNamed:@"ZJTabBarLine.png"];
    tab2.tabBar.shadowImage = [UIImage imageNamed:@"ZJTabBarLine.png"];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -5.0)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:9.0F], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#5f646e"]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:9.0F], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#1588da"]} forState:UIControlStateSelected];
#if defined YUCEDI || defined DONGGEQIU
    MLNavigationController * nvc = [[MLNavigationController alloc] initWithRootViewController:tab2];
    nvc.canDragBack=NO;
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
        [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
#else
        //***NavBackImage.png
        [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
#endif
    }
    [nvc setNavigationBarHidden:YES animated:NO];
    [caiboAppDelegate getAppDelegate].window.rootViewController = nvc;
    return nil;
#else
    return tab2;
#endif
}


- (void)goNewHomeView{
    

    GouCaiViewController *gou = [[GouCaiViewController alloc] init];
    gou.title = @"同城彩票";
//    GouCaiViewController *gou2 = [[GouCaiViewController alloc] init];
//    gou2.title = @"购买彩票";
//    gou2.fistPage = 1;
    
    //            GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    //            hemaiinfotwo.hmdtBool = YES;
    //            hemaiinfotwo.paixustr = @"ADC";
    //            hemaiinfotwo.goucaibool = YES;
    LastLotteryViewController * as = [[[LastLotteryViewController  alloc] init] autorelease];
    as.title = @"开奖大厅";
    GCHeMaiInfoViewController * hemaiinfotwo = [[[GCHeMaiInfoViewController alloc] init] autorelease];
    hemaiinfotwo.hmdtBool = YES;
    hemaiinfotwo.paixustr = @"ADC";
    hemaiinfotwo.goucaibool = YES;
    hemaiinfotwo.isNeedPopToRoot = YES;
    LiveScoreViewController *lsViewController = [[[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil] autorelease];
//    GouCaiHomeViewController *goucai = [[[GouCaiHomeViewController alloc] init] autorelease];
    HRSliderViewController *goucai = [[[HRSliderViewController alloc] init] autorelease];
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:gou,hemaiinfotwo, lsViewController,as,goucai, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [labearr addObject:@"购彩"];
    [labearr addObject:@"合买"];
    [labearr addObject:@"比分"];
    [labearr addObject:@"开奖"];
    [labearr addObject:@"我的"];
    //            [labearr addObject:@"合买大厅"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaishuzibai.png"];
    [imagestring addObject:@"tabarHemai_1.png"];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaikaijiang.png"];
    [imagestring addObject:@"goucaiwode.png"];
    //            [imagestring addObject:@"goucaihemaibai.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_shuzi.png"];
    [imageg addObject:@"tabarHemai.png"];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"goucaikaijiang_1.png"];
    [imageg addObject:@"goucaiwode_1.png"];
    //            [imageg addObject:@"tabbg_hemai.png"];
    
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
    tabarvc.backgroundImage.backgroundColor=[UIColor whiteColor];
    tabarvc.tabBar.backgroundImage = [UIImage imageNamed:@"CPTabBarLine.png"];
    tabarvc.tabBar.shadowImage = [UIImage imageNamed:@"CPTabBarLine.png"];
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:tabarvc];
    self.window.rootViewController = nac;
    
    [tabarvc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [gou release];
    [nac release];
    
    
    NSLog(@"StartGuideViewStartGuideViewStartGuideView 111");
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@qidong",[[Info getInstance] cbVersion]]] intValue]) {
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:[NSString stringWithFormat:@"%@qidong",[[Info getInstance] cbVersion]]];
//        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = [UIScreen mainScreen].bounds;
//        [btn loadButonImage:@"1.png" LabelName:@""];
//        btn.buttonImage.image = UIImageGetImageFromName(@"yindao.png");
//        [self.window addSubview:btn];
//        [btn addTarget:self action:@selector(dismissBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
}

- (UIImage *)screenshotWithScrollView:(UIScrollView *)scrollView bottomY:(float)bottomY titleBool:(BOOL)yesOrNo Moreheight:(CGFloat)moreheight//bottomY截到位置的y
{
    
    [scrollView setContentOffset:CGPointZero];
    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGImageRef imageRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    CGFloat yfloat = 0;
    CGFloat hightFloat = 0;
    if (yesOrNo) {
        yfloat = 20 *2;
        hightFloat = (44 + moreheight) *2;
        
    }else{
        yfloat =64 * 2;
    }
    CGRect rect = CGRectMake(0, yfloat, self.window.frame.size.width * 2, scrollView.frame.size.height * 2+hightFloat);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIGraphicsEndImageContext();
    UIImage *sendImage = [[[UIImage alloc] initWithCGImage:imageRefRect] autorelease];
    CFRelease(imageRefRect);
    [scrollView setContentOffset:CGPointMake(0, scrollView.frame.size.height) animated:NO];
    
    
    
    
    
    if (yesOrNo == NO) {
        UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
        [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
        
        NSLog(@"one = %f, two = %f , three = %f, four = %f", scrollView.frame.size.height * 2+hightFloat, (bottomY - scrollView.frame.size.height) * 2, bottomY ,scrollView.frame.size.height);
        CGRect rect1 = CGRectMake(0, 64 * 2, self.window.frame.size.width * 2, (bottomY - scrollView.frame.size.height) * 2);
        CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
        UIImage *sendImage1 = [[[UIImage alloc] initWithCGImage:imageRefRect1] autorelease];
        CFRelease(imageRefRect1);
        CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
        UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
        UIImage * topImage = UIImageGetImageFromName(@"daigoubgimage.png");
        [topImage drawInRect:CGRectMake(0, 0, self.window.bounds.size.width * 2, 44 * 2)];
        //        UIImage * screenshotLogoImage = UIImageGetImageFromName(@"ScreenshotLOGO.png");
        //        [screenshotLogoImage drawInRect:CGRectMake(10 * 2, 44 - 22.5 - 2, 140, 45)];
        [[UIColor whiteColor] setFill];
        [[[Info getInstance] nickName] drawInRect:CGRectMake(20 + 140 + 20, 5, 400, 25) withFont:[UIFont boldSystemFontOfSize:20]];
        [@"365 yuecai365.com" drawInRect:CGRectMake(20 + 140 + 20, 30, 400, 25) withFont:[UIFont boldSystemFontOfSize:20]];
        [sendImage drawInRect:CGRectMake(0, 44 * 2, rect.size.width, rect.size.height)];
        [sendImage1 drawInRect:CGRectMake(0, (44 + scrollView.frame.size.height) * 2, rect1.size.width, rect1.size.height)];
        
        
    }else{
        
        
        
        
        
        
        int count = bottomY/scrollView.frame.size.height;
        
        if (count * scrollView.frame.size.height < bottomY) {
            count = count+1;
        }
        if (count > 1) {
            
            
            
            
            
            NSMutableArray * imageArray = [NSMutableArray array];
            CGFloat offy = scrollView.frame.size.height;
            for (int i = 0; i < count - 1; i++) {
                
                [scrollView setContentOffset:CGPointMake(0, offy) animated:NO];
                
                UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
                [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
                
                CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
                UIGraphicsEndImageContext();
                CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44 + moreheight) * 2);
                UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
                
                CGFloat rectHight = scrollView.frame.size.height * 2;
                if (i == count - 2) {
                    rectHight = (bottomY - (count-1) * scrollView.frame.size.height)*2;
                }
                CGRect rect1 = CGRectMake(0, (64 + moreheight) * 2, self.window.frame.size.width * 2, rectHight );
                
                
                
                CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
                UIImage *sendImage1 = [[[UIImage alloc] initWithCGImage:imageRefRect1] autorelease];
                CFRelease(imageRefRect1);
                [imageArray addObject:sendImage1];
                offy = offy +  scrollView.frame.size.height ;
                
                
            }
            
            
            
            UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
            [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIGraphicsEndImageContext();
            CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + moreheight) * 2);
            UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
            
            [sendImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            CGFloat hight = rect.size.height;
            for (int i = 0; i < [imageArray count]; i++) {
                UIImage * sendImage1 = [imageArray objectAtIndex:i];
                CGFloat rectHight = scrollView.frame.size.height *2;
                
                if (i == [imageArray count] - 1) {
                    rectHight = (bottomY - (count-1) * scrollView.frame.size.height)*2;
                }
                
                //                if ([imageArray count] == 1) {
                //                    [sendImage1 drawInRect:CGRectMake(0,  hight- 9, self.window.frame.size.width * 2, rectHight)];
                //                }else{
                [sendImage1 drawInRect:CGRectMake(0,  hight, self.window.frame.size.width * 2, rectHight)];
                //                }
                
                NSLog(@"hight = hight + rectHight; = %f", hight/2.0);
                hight = hight + rectHight ;
            }
            
            
        }else{
            
            
            UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
            [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            //            CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
            UIGraphicsEndImageContext();
            
            //            CGRect rect1 = CGRectMake(0, 64 * 2, self.window.frame.size.width * 2, (bottomY - scrollView.frame.size.height) * 2 );
            //            CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
            //            UIImage *sendImage1 = [[UIImage alloc] initWithCGImage:imageRefRect1];
            
            CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
            UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
            
            [sendImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            //            [sendImage1 drawInRect:CGRectMake(0,  rect.size.width, rect1.size.width, rect1.size.height)];
        }
        
        
        
    }
    
    
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [scrollView setContentOffset:CGPointZero];
    if (IS_IPHONE_5) {
        
        CGSize Newsize = CGSizeMake(640, resultingImage.size.height);
        
        UIGraphicsBeginImageContext(Newsize);
        // 绘制改变大小的图片
        [resultingImage drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return TransformedImg;
        
    }
    return resultingImage;
}

-(void) RespLinkContentUrl:(NSString *)url title:(NSString *)titles image:(UIImage *)images content:(NSString *)content
{
    [self RespLinkContentUrl:url title:titles image:images content:content wxScene:WXSceneTimeline];
}

-(void) RespLinkContentUrl:(NSString *)url title:(NSString *)titles image:(UIImage *)images content:(NSString *)content wxScene:(int)wxScene
{
    
    if (![WXApi isWXAppInstalled]) {
        [self showMessage:@"您没有安装微信客户端！"];
        return;
    }
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = titles;
    message.description = content;
    [message setThumbImage:images];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = wxScene;
    [WXApi sendReq:req];
    
}

- (void)dismissBtn:(UIButton *)sender {
    [sender removeFromSuperview];
}

#ifdef isYueYuBan
//短信监听
id CTTelephonyCenterGetDefault(void);
void CTTelephonyCenterAddObserver(void*,id,CFNotificationCallback,NSString*,void*,int);

static void callback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSString * nameStr = (NSString *)name;
    if ([nameStr isEqualToString:@"kCTMessageReceivedNotification"]) {
        if (!userInfo) return;
        NSDictionary *info = (NSDictionary *)userInfo;
        
        CFNumberRef msgID = (CFNumberRef)[info objectForKey:@"kCTMessageIdKey"];
        int result;
        CFNumberGetValue((CFNumberRef)msgID, kCFNumberSInt32Type, &result);
        
        id incMsg;
        Class CTMessageCenter = NSClassFromString(@"CTMessageCenter");
        id mc = [CTMessageCenter sharedMessageCenter];
        incMsg = [mc incomingMessageWithId: result];
        int mType = (int)[incMsg messageType];
//        NSString *sender;
        NSString *smsText = @"";
        if (mType == 1)
        {
//            id phonenumber = [incMsg sender];
//            sender = [phonenumber canonicalFormat];
            id incMsgPart = [[incMsg items] objectAtIndex:0];
            NSData *smsData = [incMsgPart data];
            smsText = [[NSString alloc] initWithData:smsData encoding:NSUTF8StringEncoding];
        }
        
        if ([smsText isEqualToString:@""]) {
            NSLog(@"~~~短信截取失败~~~");
        }else{
            if ([[smsText componentsSeparatedByString:@"【投注站】"] count] > 1) {
                NSArray * aArr = [smsText componentsSeparatedByString:@"，"];
                if (aArr.count > 1) {
                    NSArray * bArr = [[aArr objectAtIndex:0] componentsSeparatedByString:@"："];
                    if (bArr.count > 1) {
                        NSString * captcha = [bArr objectAtIndex:1];
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"CaptchaType"] isEqualToString:@"Register"]) {
                            [[NSUserDefaults standardUserDefaults] setValue:captcha forKey:@"Captcha"];
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"GotCaptcha" object:captcha];
                        NSLog(@"~~~短信获取成功");
                    }else{
                        NSLog(@"~~~短信解析失败~~~");
                    }
                }else{
                    NSLog(@"~~~短信解析失败~~~");
                }
            }
        }
        
//        NSLog(@"Sender: %@", sender);
        //send to me when get new message
//        [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"123" serviceCenter:nil toAddress:@"你的电话号码"];
        
    }
}
#endif


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef isHaoLeCai
    [[AWAppStatusReport sharedStatusReport] report];
#endif

//    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isWC"];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"WCStyle"];

    loginselfcount = 0;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(guide:) name:@"Guide" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuisong:) name:@"Tuisong" object:nil];

	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CaiBoUsername"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CaiBoUserpassword"];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey: @"undoLongtime"];  //取消记录的时间；
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shuzihuodong"]; //取消轮播图关闭状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zucaihuodong"];
    
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
	[[Info getInstance] setCbVersion:[infoDict objectForKey:@"CFBundleVersion"]];
    NSString *filePath2 = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents/GoodVoice"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath2])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath2
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    [self cleanDisk];
    [[Info getInstance] setCbSID:[infoDict objectForKey:@"SID"]];
    [[Info getInstance] setBundleId:[infoDict objectForKey:@"CFBundleIdentifier"]];
    [self umengTrack];//打开友盟
    [self umengtrack2];
	if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ADVPicVersion"]) {
		[[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"ADVPicVersion"];
	}
	if (![[NSUserDefaults standardUserDefaults] objectForKey:@"welcomePicVersion"]) {
		[[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"welcomePicVersion"];
	}
	// 传说中的推送通知 也不知道灵不灵
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//    NSLog(@"deviceToken =%@",deviceToken);
//    if (!deviceToken||[deviceToken isEqualToString:@""])
//    {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"] isEqualToString:@"1"] || ![[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                                 settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                                 categories:nil]];

            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else  {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];

        }
        
    }
    else {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                                 settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                                 categories:nil]];

            
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
        }
        
        
    }
    
    
//    }
    
    hylistcont = 0;
    hylistarray = [[NSMutableArray alloc] initWithCapacity:0];
    YD_FUNNAME;
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    hostReach = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
    [hostReach startNotifier];
    YD_FUNNAME;
    
	isLongTime = NO;
    // 打开数据库
    [DataBase getDatabase];
    [DataBase deleteImageCacheFormeData:1000];//多余1000张图片删除
    
    // 初始化图片下载器
    imageDownloader = [[ImageDownloader alloc] init];
	
	
    /*
	 // 添加背景图
	 UIImageView *background = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"Guidebg.png")];
	 [window addSubview:background];
	 [background release];
     */
    // 获得当前主题模式
    if ([[datafile getDataByKey:KEY_THEME] isEqualToString:BUBBLE_THEME])
    {
        isBubbleTheme = YES;
    }
    else
    {
        isBubbleTheme = NO;
    }
    
    // 获得当前阅读模式
    self.readingMode = [datafile getDataByKey:KEY_READING_MODEL];
    if (!readingMode || [readingMode length] <= 0)
    {
        [datafile setdata: PREVIEW_MODEL forkey: KEY_READING_MODEL];
        self.readingMode = PREVIEW_MODEL;
    }
	
	if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isJihuo"] intValue]) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue]) {
           [self performSelector:@selector(jihuo365) withObject:nil afterDelay:[[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue]];
        }
        else {
            [self performSelector:@selector(jihuo365) withObject:nil afterDelay:60 *3];
            NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            [[NSUserDefaults standardUserDefaults]setValue:time forKey:@"jihuobegin"];
        }
        
        NSLog(@"1111111");
	}
    [self downLoadAll365Account];



    
	NSString *key = [NSString stringWithFormat:@"shouldGude%@",[[Info getInstance] cbVersion]];
	if ([[[NSUserDefaults standardUserDefaults] valueForKey:key] intValue]) {
		shouldGude = NO;
	}
	else {
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:key];
		shouldGude = YES;
	}
    [self loadSelfInfo];//加载本地信息
	/*
	 //检查欢迎图片更新的请求
	 [mrequest clearDelegatesAndCancel];
	 [self setMrequest:[ASIHTTPRequest requestWithURL:[NetURL CBUpdateWelcomePage]]];
	 [mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	 [mrequest setDelegate:self];
	 [mrequest setDidFinishSelector:@selector(updateWelcomPage:)];
	 [mrequest setDidFailSelector:@selector(updateWelcomPageFail:)];
	 
	 [mrequest startAsynchronous];
	 
	 
	 */
    
    
#ifdef isCaiPiaoForIPad
    IpadRootViewController * nhome = [[IpadRootViewController alloc] init];
    MLNavigationController * nvc = [[[MLNavigationController alloc] initWithRootViewController:nhome] autorelease];
    
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
        [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
#else
         [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
#endif
       // [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }
    
    
    // [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    [nvc setNavigationBarHidden:YES animated:NO];
    
    self.window.rootViewController = nvc;
    self.window.rootViewController.view.layer.masksToBounds = YES;
	[nhome release];
    self.window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
    
    self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
    
    
    [self DologinSave];
    
    
//    getStartPicInfoWithVersion
#else
    [self goNewHomeView];
#ifdef isHaoLeCai
    [self oneLoginFunc];
#else
    
    [self openFileFunc];
    
#endif
#endif
    
    [self openTimer];
    //    if (launchOptions) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",launchOptions] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    //    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        //        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        //                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
	[self.window makeKeyAndVisible];
    
    [WXApi registerApp:@"wx0cfdf60c4c082b3b"];
    [self performSelectorInBackground:@selector(getCaizhongInfo) withObject:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Captcha"];
#ifdef isYueYuBan
    //短信监听
    CTTelephonyCenterAddObserver(CTTelephonyCenterGetDefault(), NULL, callback, NULL, NULL, CFNotificationSuspensionBehaviorDrop);
#endif
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"YiLouSwitch"];
    }
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"pushSound"];
    }
    
    NSMutableArray * forecastCellReadArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ForecastCellRead"];
    
    if (!forecastCellReadArray) {
        forecastCellReadArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [[NSUserDefaults standardUserDefaults] setValue:forecastCellReadArray forKey:@"ForecastCellRead"];
    }else if ([forecastCellReadArray count] > 200) {
        for (int i = 0; i < forecastCellReadArray.count - 200; i++) {
            [forecastCellReadArray removeObjectAtIndex:i];
        }
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"weiBoLike"];
    if (GC_testModle_1) {
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"test_netModel"]) {
            [[NSUserDefaults standardUserDefaults] setValue:@"正式" forKey:@"test_netModel"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
        }
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"切换测试环境" message:[NSString stringWithFormat:@"选择测试环境重启后生效，当前环境\n%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"test_netModel"]] delegate:self cancelButtonTitle:@"正式" otherButtonTitles:@"23",@"56",@"57",nil];
        alert.tag = 77421;
        [alert show];
        [alert release];
    }
    if (launchOptions) {
        [self application:application didReceiveRemoteNotification:launchOptions];
    }
    
//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];

    return YES;
	
}

//检查是否有启动图更新
- (void)getStartPicInfoFinished:(ASIHTTPRequest *)request{
    
    NSString * requestString = [request responseString];
    NSDictionary * dict = [requestString JSONValue];
    if ([[dict objectForKey:@"status"] intValue] == 1) {//说明有更新
        
        
        if ([[dict objectForKey:@"downLoad_url"] length] > 0) {
            NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *pathstring= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
            NSString *plistPath = [pathstring stringByAppendingPathComponent:@"defaultZIP.zip"];
            NSURL *url = [ NSURL URLWithString : [dict objectForKey:@"downLoad_url"]];
            
            ASIHTTPRequest *request2 = [ ASIHTTPRequest requestWithURL :url];
            [request2 setDownloadDestinationPath :plistPath];
            [request2 setDelegate:self];
            [request2 setDownloadProgressDelegate : self ];
            [request2 setDidFailSelector:@selector(loadRequestFail:)];
            [request2 setDidFinishSelector:@selector(loadRequestFinished:)];
            [request2 startSynchronous ];
        }
        
    }else{//显示默认的启动图
    
        
    }
    
    
}
- (void)getStartPicInfoFailed:(ASIHTTPRequest *)request{
    
}
- (void)loadRequestFail:(ASIHTTPRequest *)request{


}

//启动图下载成功
- (void)loadRequestFinished:(ASIHTTPRequest *)request{

    [self zipUncompressFunc];

}


//激活
- (void)jihuo365{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isJihuo"] intValue] != 1){
    
        NSDate *now =[NSDate date];
        //NSString *Date = [NSString stringWithFormat:@"%d-%d %d:%d",[now getMonth],[now getDay],[now getHour],[now getMinute]];
        NSString *time = [NSString stringWithFormat:@"%4d-%02d-%02d %02d:%02d:%@",(int)[now getYear],(int)[now getMonth],(int)[now getDay],(int)[now getHour],(int)[now getMinute],@"00"];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL initMacCode:[UDIDFromMac uniqueGlobalDeviceIdentifier] Sid:[[Info getInstance] cbSID] Time:time]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(cheackJihuo:)];
        [request setDidFailSelector:@selector(JihuoFail:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
        
    }

}

//应用内弹窗
-(void)getActiveWindowMessage
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL getAppActiveWindowWithUserid:[[Info getInstance] userId]]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getActiveWindowMessageFinished:)];
    [request setDidFailSelector:@selector(getActiveWindowMessageFailed:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
}
-(void)downActiveWindowImage:(NSString *)imageUrl
{
    ASIHTTPRequest *imageReq = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [imageReq setDelegate:self];
    [imageReq setTimeOutSeconds:20];
    [imageReq setDidFinishSelector:@selector(imageDownloaderFinished:)];
    [imageReq setDidFailSelector:@selector(imageDownloaderFailed:)];
    [imageReq startAsynchronous];
}
-(void)downLoadAll365Account
{
    ASIHTTPRequest *fileRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://download.caipiao365.com/cp365/config/caibo_master.txt"]];
    [fileRequest setDelegate:self];
    [fileRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [fileRequest setDidReceiveResponseHeadersSelector:@selector(requestReceivedResponseHeaders:)];
    [fileRequest setDidFinishSelector:@selector(all365AccountDownloaderFinished:)];
    [fileRequest setDidFailSelector:@selector(all365AccountDownloaderFailed:)];
    [fileRequest setTimeOutSeconds:20];
    [fileRequest startAsynchronous];
}
//添加广告
#pragma mark 添加弹窗广告
-(void)addFlashAd
{
    CP_APPAlertFlashAdView *flashView = [[CP_APPAlertFlashAdView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height) andFlashAdImage:self.alertImage];
    flashView.delegate = self;
    [self.window addSubview:flashView];
    [flashView release];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"0" forKey:@"needShowAPPFlashAd"];
    [userDefaults synchronize];

}
#pragma mark - 点击广告后不同的跳转方式
-(void)clickAppAlertFlashAdViewDelegate
{
    NSLog(@"点击广告 ，关闭广告");
    
    if(linkType == 0)//@"点击广告链接到AppStore"
    {
        [self clikeOrderIdURL:linkUrl];
    }
    if(linkType == 1)//@"点击广告进入微博详情"
    {
        //需传微博详情ID
        [self clikeOrderIdURL:linkUrl];
    }
    if(linkType == 2) //@"广告点击后进入方案详情"
    {
        //未登录
        if ([[[Info getInstance] userId] intValue] == 0) {
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [loginVC setHidesBottomBarWhenPushed:YES];
            [loginVC setIsShowDefultAccount:YES];
            [loginVC setIsFromFlashAd:YES];
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav pushViewController:loginVC animated:YES];
            [loginVC release];
        }
        //已登录
        else
        {
            NSLog(@"进入方案详情"); //需传方案详情id
            [self clikeOrderIdURL:linkUrl];
        }
    }
}
- (void)clikeOrderIdURL:(NSString *)request1 {
    NSString *url = [NSString stringWithFormat:@"%@",request1];
    if ([url hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",request1] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"] || [dic objectForKey:@"wbzw"]) {
            [autoRequest clearDelegatesAndCancel];
            
            NSString *wbID = nil;
            if([dic objectForKey:@"wbxq"]){
            
                wbID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wbxq"]];
            }
            if([dic objectForKey:@"wbzw"]){
            
                wbID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wbzw"]];
            }
            
            [self goWBDetailMsgWithID:wbID];

            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];
            info.isFromFlashAdAndLogin = YES;
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav setNavigationBarHidden:YES animated:YES];
            [nav pushViewController:info animated:YES];
            
            [info release];
            return;
        }
        
    }
    MyWebViewController *my = [[MyWebViewController alloc] init];
	
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
    [my LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:request1]]];
	[my release];
}
-(void)goWBDetailMsgWithID:(NSString *)_wbID{

    [self setAutoRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:_wbID]]];
    [autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [autoRequest setDelegate:self];
    [autoRequest setDidFinishSelector:@selector(requestWBXQFinished:)];
    [autoRequest setTimeOutSeconds:20.0];
    [autoRequest startAsynchronous];
}
- (void)requestWBXQFinished:(ASIHTTPRequest *)request1{
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    [nav setNavigationBarHidden:YES animated:YES];
    [nav pushViewController:detailed animated:YES];
    detailed.isFromFlashAd = YES;
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}

- (void)reqCheckFinished:(ASIHTTPRequest *)request {
    NSString *responseStr = [request responseString];
    
    
    NSLog(@"responsestr = %@", responseStr);
    NSDictionary * dict = [responseStr JSONValue];
    NSString * versionstr = [dict objectForKey:@"version"];
    NSString * upDatastr = [dict objectForKey:@"isUpdate"];
    self.upDataCheck = [upDatastr intValue];
    NSArray * infoArray = [dict objectForKey:@"info"];
    self.urlVersion = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add"] ];
    
    NSString * update_type = [dict objectForKey:@"update_type"];//服务器返回的提醒状态 1无线 2 2g 3 3g
    
    NSLog(@"ulversion = %@", self.urlVersion);
    NSMutableString * msgString = [[NSMutableString alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkUpDateVersion" object:nil];
    
    
    
    
    Reachability *curentReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];//检查当地网络状态
    NSString * networkType = @"";
    
    if ([curentReachability currentReachabilityStatus] == NotReachable) {// 没有网络连接
        NSLog(@"1111");
        networkType = @"0";
    }else if ([curentReachability currentReachabilityStatus] == ReachableViaWiFi) {// 使用WiFi网络
        NSLog(@"222");
        networkType = @"1";
    }else if ([curentReachability currentReachabilityStatus] == ReachableViaWWAN) {// 使用3G网络
        NSLog(@"333");
        networkType = @"2";
    }
    
    NSArray * tpyeArray;
    if ([update_type rangeOfString:@","].location != NSNotFound) {//分解服务器返回的状态
        tpyeArray = [update_type componentsSeparatedByString:@","];
    }else{
        tpyeArray = [NSArray arrayWithObjects:update_type, nil];
    }
    
    BOOL prompting = NO;
    for (int i = 0; i < [tpyeArray count]; i++) { //循环比较是否与当前网络状态一致
        NSString * tpyeString = [tpyeArray objectAtIndex:i];
        if ([tpyeString isEqualToString:@"3"]) {//因为 iphone只有三个状态 2g和3g是一个状态
            tpyeString = @"2";
        }
        if ([tpyeString isEqualToString:networkType]) {
            prompting = YES;
        }
    }
    
    if (prompting) {//如果一致则提示是否更新
        if ([infoArray count] > 0) {
            for (int i = 0; i < [infoArray count]; i++) {
                NSDictionary * dictmsg = [infoArray objectAtIndex:i];
                [msgString appendFormat:@"%@\n", [dictmsg objectForKey:@"line"]];
            }
        }
        
        if([upDatastr isEqualToString:@"1"]){
            NSString * msg = @"";
            if ([msgString length] > 0) {
                msg = [NSString stringWithFormat:@"%@",msgString];
            }else{
                msg = [NSString stringWithFormat:@"发现新版本 %@\n是否更新", versionstr];
            }
            [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
            if ([dict objectForKey:@"popup"] && [[dict objectForKey:@"popup"] intValue] == 0) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                                      message:msg
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                            otherButtonTitles:@"更新", nil];
                alert.tag = 2;
                alert.delegate = self;
                [alert show];
                [alert release];
            }
            
            
            
        }else if([upDatastr isEqualToString:@"2"]){
            NSString * msg = @"";
            if ([msgString length] > 0) {
                msg = [NSString stringWithFormat:@"%@", msgString];
            }else{
                msg = [NSString stringWithFormat:@"发现新版本 %@\n请更新", versionstr];
            }
            [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
            if ([dict objectForKey:@"popup"] && [[dict objectForKey:@"popup"] intValue] == 0) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                                      message:msg
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                            otherButtonTitles:@"更新", nil];
                alert.tag = 3;
                alert.delegate = self;
                [alert show];
                [alert release];
            }
            
        }
    }
    
    if (starGuidan) {
        [self.window bringSubviewToFront:starGuidan];
        
    }
    
    
    [msgString release];
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
        NSLog(@"url = %@", self.urlVersion);
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
        
        
    }
    else if (alertView.tag == 77421) {
        if (buttonIndex == 0) {
            [[NSUserDefaults standardUserDefaults] setValue:@"正式" forKey:@"test_netModel"];
        }
        else if (buttonIndex == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:@"23" forKey:@"test_netModel"];
        }
        else if (buttonIndex == 2) {
            [[NSUserDefaults standardUserDefaults] setValue:@"56" forKey:@"test_netModel"];
        }
        else if (buttonIndex == 3) {
            [[NSUserDefaults standardUserDefaults] setValue:@"57" forKey:@"test_netModel"];
        }
        [[NSUserDefaults standardUserDefaults]  synchronize];
    }
}

//欢迎画面
- (void)addWelcomePage{
    
#ifndef isJinShanIphone
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kaijidonghua.gif"];
    
    //    UIImageView * image91 = [[UIImageView alloc] initWithFrame:CGRectMake(320-83, 10, 50, 50)];//91助手图片
    //    image91.backgroundColor = [UIColor clearColor];
    //    image91.image = UIImageGetImageFromName(@"91zhushoulogo.png");
    
    
//    if (IS_IPHONE_5) {
//        welcomePage = [[GifView alloc] initWithFrame:self.window.bounds filePath:path stop:1.0];
//        welcomePage.frame = CGRectMake(0, 88, 320, 480);
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -88, 320, 88)];
//        [welcomePage addSubview:backView];
//        [backView release];
//        backView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
//        //        image91.frame = CGRectMake(320-83, - 58, 50, 50);
//    }
//    else {
//        
//        welcomePage = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) filePath:path stop:1.0];
//        welcomePage.frame = CGRectMake(0, 20, 320, 460);
//        
//    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        if (IS_IPHONE_5) {
            
        }
        else {
            welcomePage.frame = CGRectMake(0, 0, 320, 480);
        }
    }
    //    [welcomePage addSubview:image91];
    //    [image91 release];
    //    UILabel * label91 = [[UILabel alloc] initWithFrame:CGRectMake(320-109, image91.frame.size.height+image91.frame.origin.y, 96, 20)];
    //    label91.textAlignment = NSTextAlignmentCenter;
    //    label91.backgroundColor = [UIColor clearColor];
    //    //    label91.textColor = [UIColor blueColor];
    //    label91.font = [UIFont boldSystemFontOfSize:16];
    //    label91.text = @"91助手首发";
    //    [welcomePage addSubview:label91];
    //    [label91 release];
    
    
#endif
    
	[self.window addSubview:welcomePage];
    [self DologinSave];
    [self performSelector:@selector(dismissWelcomePage) withObject:nil afterDelay:3.5];
}
//- (void)addWelcomePage{
//    
//    
//#ifndef isJinShanIphone
//
//    if (IS_IPHONE_5) {
//        
//        welcomePage = [[StartPageView alloc] initWithFrame:self.window.bounds];
//    }
//    else {
//        welcomePage = [[StartPageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    }
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
////        welcomePage.frame =  CGRectMake(0,welcomePage.frame.origin.y-20,welcomePage.frame.size.width,welcomePage.frame.size.height+20);
//        
//    }
//    
//    
//#endif
//    
//	[self.window addSubview:welcomePage];
//    [welcomePage show];
//    [self DologinSave];
//    
//    
//    [self performSelector:@selector(dismissWelcomePage) withObject:nil afterDelay:3.5];
//    
//    [self performSelector:@selector(goNewHomeView) withObject:nil afterDelay:3.4];
//
//}

- (void)DologinSave {
//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];

    
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    NSLog(@"info = %@", infosave);
    
	if ([infosave length] ) {
        
        
        NSArray * infoarr = [infosave componentsSeparatedByString:@";"];
        if ([infoarr count] > 3) {
            NSLog(@"99999999999999 = %@", [infoarr objectAtIndex:3]);
            ASIHTTPRequest *reqLogin = [ASIHTTPRequest requestWithURL:[NetURL cpLoginSaveUserName:[infoarr objectAtIndex:3]]];
            [reqLogin setTimeOutSeconds:20.0];
            [reqLogin setDidFinishSelector:@selector(bcrecivedFinish:)];
            //[reqLogin setDidFailSelector:@selector(recivedFail:)];
            [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
            [reqLogin setDelegate:self];
            [reqLogin startAsynchronous];
        }
        
	}
}

//ipad额外界面添加view
- (void)showInSencondView:(UIView *)showView ViewControllor:(UIViewController *)theControl {
#ifndef isCaiPiaoForIPad
    return;
#endif
    
    if (!sendView) {
        sendView = [[UIView alloc] initWithFrame:CGRectMake(214, 239, 320, 748)];
        [window addSubview:sendView];
        sendViewControllerArray = [[NSMutableArray alloc] init];
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        rotationAnimation.duration = 0.0f;
        
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [sendView.layer addAnimation:rotationAnimation forKey:@"run"];
        sendView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    }
    for (UIView *v in sendView.subviews) {
        [v removeFromSuperview];
    }
    [sendViewControllerArray removeAllObjects];
    if (theControl) {
        [sendViewControllerArray addObject:theControl];
    }
    if (showView) {
        sendView.hidden = NO;
    }
    else {
        sendView.hidden = YES;
    }
    [sendView addSubview:showView];
    
}


//更新启动页面请求回调
- (void)updateWelcomPage:(ASIHTTPRequest*)request{
	NSString *responseString = [request responseString];
    if (responseString)
    {
        SBJSON *jsonParse = [SBJSON new];
        NSDictionary *dic = [jsonParse objectWithString:responseString];
        NSString *isUpdate = [dic objectForKey:@"isUpdate"];
		NSString *aNewVersion = [dic objectForKey:@"version"];
		NSString *url = [dic objectForKey:@"url"];
		NSString *version = [[Info getInstance] cbVersion];
		if ([isUpdate isEqualToString:@"1"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																 NSUserDomainMask, YES);
			NSString *uniquePath=[[paths objectAtIndex:0]
								  stringByAppendingPathComponent:kwelcomePicName];
			[[NSFileManager defaultManager] removeItemAtPath:uniquePath error:nil];
			
			[[NSFileManager defaultManager] createFileAtPath:uniquePath
													contents:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]
												  attributes:nil];
			if (![version isEqualToString:aNewVersion]) {
                [[NSUserDefaults standardUserDefaults] setValue:aNewVersion forKey:@"welcomePicVersion"];
			}
		}
        [jsonParse release];
    }
	
	
}


- (void)tabBarController:(UITabBarController *)tabBar didSelectViewController:(UIViewController *)viewController
{
    static int con;
    selectedTab = (int)tabBar.selectedIndex;
    NSLog(@"aaaaaaaaaaaaaaaaa  selectedTab = %d", selectedTab);
	
    if (selectedTab == 0) {
        if (selectedTab == con) {
            // [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:self];
			
        }
    }
    
	con = selectedTab;
    
}

// 跳到主页
- (void)switchToHomeView
{
	//    NSLog(@"switchToHomeView");
	
#ifdef isCaiPiaoForIPad
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    if ([[nav viewControllers] count] > 1) {
        [nav popToViewController:[nav.viewControllers objectAtIndex:1] animated:YES];
        
    }
    UIView * backview = (UIView *)[self.window viewWithTag:10212];
    [backview removeFromSuperview];
#else
    [(UINavigationController *)self.window.rootViewController popToRootViewControllerAnimated:NO];
    UINavigationController *con = (UINavigationController *)self.window.rootViewController;
    if ([con isKindOfClass:[UINavigationController class]]) {
        UITabBarController *bar = [con.viewControllers objectAtIndex:0];
        if ([bar isKindOfClass:[UITabBarController class]]) {
            bar.selectedIndex = 0;
        }
    }
#endif
	return;
	[welcomePage removeFromSuperview];
	// 如果是 切换最后账号 重新 登录，调用 回调函数，清除 消息界面 数据
	if (lastAccount)
    {
		[self autoreleaseMessage];
		lastAccount = NO;
	}
	// 启动定时器，定期接收推送数据
	[self openTimer];
}

- (void)switchToRegiseView {
	
}

// 跳到登录
- (void)switchToLoginView
{
    [self.window.rootViewController.navigationController popToRootViewControllerAnimated:YES];
    
}

// 消息提醒
- (void)changeItemValue:(NSString*)value
{
    NSLog(@"changeItemValue");
    [homeItem setBadgeValue:value];
    [focusItem setBadgeValue:value];
}

// 切换账号之后 回调函数，自动清除 消息 界面数据
- (void)autoreleaseMessage
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	//NSLog(@"isunDoLongTime",[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"]);
	if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]) {
        
		NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
		[[NSUserDefaults standardUserDefaults]setValue:time forKey:@"undoLongtime"];
	}
    YD_LOG( @"applicationWillResignActive");
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isJihuo"] intValue]) {
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(jihuo365) object:nil];
        long int now ,a;
        now = [[NSDate date] timeIntervalSince1970];
        a = [[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuobegin"] longLongValue];
        int shengyu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue];
        if (now - a > 0 && now - a  < shengyu) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",shengyu - (now - a)] forKey:@"jihuoshengyu"];
            
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:@"180" forKey:@"jihuoshengyu"];
            [self performSelector:@selector(jihuo365) withObject:nil afterDelay:180];
        }
        
    }
    
}

- (void)clearLoginSession {
#ifndef __OPTIMIZE__
    [GC_HttpService sharedInstance].sessionId = nil;
    [ASIHTTPRequest clearSession];
#endif
    
}

//注册登录
- (void)LoginForIpad {
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    
    LoginViewController *log = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    log.isShowDefultAccount = YES;
    [log.navigationController setNavigationBarHidden:NO];
    
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:log];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 5) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    nac.view.frame = CGRectMake(80, 180, 540, 680);
    [vi addSubview:nac.view];
    
    //旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    [app.window addSubview:vi];
    [log release];
    [vi release];
    [nac release];

}

//设置
- (void)SettingForiPad {
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    CPSetViewController *se = [[CPSetViewController alloc] init];
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 5) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    nac.view.frame = CGRectMake(80, 180, 540, 680);
    [vi addSubview:nac.view];
    
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    //        [nac release];
    [se release];
    [vi release];
    
}

//话题
- (void)WriteWeiBoForiPad:(PublishType)publishtype mStatus:(YtTopic *)topic three:(BOOL)yesoron{
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    
    
    NewPostViewController *se = [[NewPostViewController alloc] init];
    se.publishType = publishtype;// 自发彩博
    se.three = yesoron;
    se.mStatus = topic;
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 6) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    //        [nac release];
    [se release];
    [vi release];
    
}


//@他
- (void)WriteWeiBoForiPad:(PublishType)publishtype mStatus:(YtTopic *)topic{
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    NewPostViewController *se = [[NewPostViewController alloc] init];
    se.publishType = publishtype;// 自发彩博
    se.mStatus = topic;
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 6) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    //        [nac release];
    [se release];
    [vi release];
    
}

- (void)WriteWeiBoForiPad:(NewPostViewController *)se {
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    NSLog(@"%@",app.window);
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    NSLog(@"%@",nac.view);
    
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    [vi release];
}

//发表新微博
- (void)WriteWeiBoForiPad:(PublishType)publishtype shareTo:(NSString *)shar isShare:(BOOL)yesOrNo{
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    NSLog(@"%@",app.window);
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    NewPostViewController *se = [[NewPostViewController alloc] init];
    se.publishType = publishtype;// 自发彩博
    if (yesOrNo) {
        se.title = @"分享微博";
        se.shareTo = shar;
        se.isShare = yesOrNo;
    }
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    NSLog(@"%@",nac.view);
    
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    [se release];
    [vi release];
    
}

- (void)XiuGaiTouXiangForiPad:(BOOL)yesorno Save:(BOOL)ye {
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    
    PhotographViewController *ph = [[PhotographViewController alloc] init];
    ph.padDoBack = yesorno;
    ph.finish = ye;
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:ph];
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    
    [ph release];
    [vi release];
    
}
//评论微博
- (void)PingLunWeiBoForiPad {
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    NewPostViewController *se = [[NewPostViewController alloc] init];
    se.publishType = kCommentTopicController;// 评论微博
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 6) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    //        [nac release];
    [se release];
    [vi release];
    
}

//转发微博
- (void)ZhuanFaWeiBoForiPad {
    
    caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
    
    UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
    vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    vi.tag = 10212;
    NewPostViewController *se = [[NewPostViewController alloc] init];
    se.publishType = kForwardTopicController;// 转发微博
    MLNavigationController *nac = [[MLNavigationController alloc] initWithRootViewController:se];
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr intValue] == 6) {
    //        [nac.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangtiao.png") forBarMetrics:UIBarMetricsDefault];
    //    }
    nac.view.frame = CGRectMake(80, 200, 540, 620);
    [vi addSubview:nac.view];
    //旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
    nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    [nac release];

    [app.window addSubview:vi];
    //        [nac release];
    [se release];
    [vi release];
    
}

- (void)upLoadGoodVoiceWithOrderID:(NSString *)orderid Path:(NSString *)_path Type:(NSInteger)type Time:(NSInteger )time {
    uploadDelegatel= nil;
    uploadFinish = nil;
    if (time < 0) {
        time = 0;
        type = 3;
    }
    if (_path == nil &&orderid) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] SaveGoodVoiceWithOrderId:orderid Type:type Data:nil Time:time UserName:[[Info getInstance] userName] Other:@""];
        ASIHTTPRequest *uploadReauest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [uploadReauest setRequestMethod:@"POST"];
        [uploadReauest addCommHeaders];
        
        [uploadReauest setPostBody:postData];
        [uploadReauest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [uploadReauest setDelegate:self];
        [uploadReauest setDidFinishSelector:@selector(reqGoogVoice:)];
        [uploadReauest startAsynchronous];
        return;
    }
    NSData *amrData = [NSData dataWithContentsOfFile:_path];
    if (amrData) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] SaveGoodVoiceWithOrderId:orderid Type:type Data:amrData Time:time UserName:[[Info getInstance] userName] Other:@""];
        ASIHTTPRequest *uploadReauest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [uploadReauest setRequestMethod:@"POST"];
        [uploadReauest addCommHeaders];
        
        [uploadReauest setPostBody:postData];
        [uploadReauest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [uploadReauest setDelegate:self];
        [uploadReauest setDidFinishSelector:@selector(reqGoogVoice:)];
        [uploadReauest startAsynchronous];
    }
    
}

- (void)upLoadGoodVoiceWithOrderID:(NSString *)orderid Path:(NSString *)path Type:(NSInteger)type Time:(NSInteger)time Delegate:(id)_delegate Finish:(SEL)finish {
    [self upLoadGoodVoiceWithOrderID:orderid Path:path Type:type Time:time];
    uploadDelegatel = _delegate;
    uploadFinish = finish;
    
}

- (void)clearuploadDelegate {
    uploadDelegatel = nil;
    uploadFinish = nil;
}

- (void)LogInBySelfWithIncreace {
    [self LogInBySelf];
    loginselfcount ++;
}

- (void)LogInBySelf {
    if (isloginIng) {
        return;
    }
    isloginIng = YES;
    if (loginselfcount>4) {
        Info *info = [Info getInstance];
        info.requestArray = nil;
        isloginIng = NO;
        loginselfcount = 0;
        return;
    }
	if ([[Info getInstance]userName]) {
        
        NSMutableData  *postData  = [[GC_HttpService sharedInstance] getSessionByUserName:[[Info getInstance]userName]];
        [ASIHTTPRequest clearSession];
        [GC_HttpService sharedInstance].sessionId = nil;
        [self.loginselfRequest clearDelegatesAndCancel];
        self.loginselfRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        
        [self.loginselfRequest setRequestMethod:@"POST"];
        [self.loginselfRequest addCommHeaders];
        [self.loginselfRequest setPostBody:postData];
        [self.loginselfRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self.loginselfRequest setDelegate:self];
        [self.loginselfRequest setDidFinishSelector:@selector(recivedLoginByselfFinish:)];
        [self.loginselfRequest setDidFailSelector:@selector(recivedLoginByselfFail:)];
        [[self.loginselfRequest responseHeaders] setValue:[UDIDFromMac uniqueGlobalDeviceIdentifier] forKey:@"macCode"];
        [[self.loginselfRequest responseHeaders] setValue:[[Info getInstance] cbVersion] forKey:@"versinoNum"];
        NSDictionary *properties =  [NSDictionary dictionaryWithObjectsAndKeys:
                                     [UDIDFromMac uniqueGlobalDeviceIdentifier],NSHTTPCookieValue,
                                     @"macCode",NSHTTPCookieName,
                                     @"/" , NSHTTPCookiePath,
                                     [NSString stringWithFormat:@"%@",[[self.loginselfRequest url] baseURL]] , NSHTTPCookieDomain, nil];
        NSHTTPCookie *cookie_PD1 = [NSHTTPCookie cookieWithProperties:properties];
        [self.loginselfRequest setRequestCookies:[NSMutableArray arrayWithObject:cookie_PD1]];
        [ASIHTTPRequest addSessionCookie:cookie_PD1];
        [self.loginselfRequest startAsynchronous];
        //       // kkkk
        //		ASIHTTPRequest *reqLogin = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
        //		[reqLogin setTimeOutSeconds:20.0];
        //		[reqLogin setDidFinishSelector:@selector(recivedLoginByselfFinish:)];
        //		[reqLogin setDidFailSelector:@selector(recivedFail:)];
        //		[reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        //		[reqLogin setDelegate:self];
        //		[reqLogin startAsynchronous];
	}
	else {
		//[[[Info getInstance] mUserInfo]user_name]
        //		ASIHTTPRequest *reqLogin = [ASIHTTPRequest requestWithURL:[NetURL CBgetSessionIdbyUL:[[[Info getInstance] mUserInfo] unionId] UserName:[[Info getInstance] nickName] Partnerid:[[Info getInstance] mUserInfo].partnerid]];
        //		[reqLogin setTimeOutSeconds:20.0];
        //		[reqLogin setDidFinishSelector:@selector(recivedLoginByselfFinish:)];
        //		[reqLogin setDidFailSelector:@selector(recivedFail:)];
        //		[reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        //		[reqLogin setDelegate:self];
        //		[reqLogin startAsynchronous];
	}
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    YD_LOG( @"applicationDidEnterBackground");
	self.timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnterBackground" object:nil];
	if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]) {
		
		NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
		NSLog(@"%@",time);
		[[NSUserDefaults standardUserDefaults]setValue:time forKey:@"undoLongtime"];
	}
	//    [tabBarController setSelectedIndex:0];
	//    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:self];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#ifdef isHaoLeCai
    [[AWAppStatusReport sharedStatusReport] report];
#endif
    YD_LOG( @"applicationWillEnterForeground");
}

- (void)goPageBy:(NSMutableDictionary *) dic {
    return;
    NSInteger cid = [[dic objectForKey:@"CID"] intValue];
    NSInteger pageid = [[dic objectForKey:@"JumpToPage"] intValue];
    switch (cid) {
        case 1001:{
#ifdef  isCaiPiao365AndPPTV
            
            NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"LogInname"];
            NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
            if ([name length]||[infosave length]) {
                if (pageid == 1) {
                    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
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
                    [imagestring addObject:@"ILY-960.png"];
                    [imagestring addObject:@"IHMY-960.png"];
                    
                    
                    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
                    [imageg addObject:@"IL-960.png"];
                    [imageg addObject:@"IHM-960.png"];
                    
                    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
                    
                    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
                    tabc.selectedIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultBuy"] intValue];
                    
                    
                    tabc.navigationController.navigationBarHidden = YES;
                    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
                    [nav pushViewController:tabc animated:YES];
                    [tabc release];
                    [imagestring release];
                    [labearr release];
                    [imageg release];
                    [controllers release];
                    [gou release];
                    [gou2 release];
                    
                    return;
                }
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否使用PPTV账号登录" message:nil delegate:self
                                                      cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1001;
                [alert show];
                [alert release];
                return;
                
            }
            
#else
#endif
        }
            
            break;
            
        default:
            break;
    }
    if (pageid == 1) {
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        
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
        [imagestring addObject:@"ILY-960.png"];
        [imagestring addObject:@"IHMY-960.png"];
        
        
        NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
        [imageg addObject:@"IL-960.png"];
        [imageg addObject:@"IHM-960.png"];
        
        caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
        
        CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
        tabc.selectedIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultBuy"] intValue];
        
        tabc.navigationController.navigationBarHidden = YES;
        tabc.showXuanZheZhao = NO;
        tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];;
        [nav pushViewController:tabc animated:YES];
        [tabc release];
        [imagestring release];
        [labearr release];
        [imageg release];
        [controllers release];
        [gou release];
        [gou2 release];
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if (url) {
        NSString *str = [NSString stringWithFormat:@"%@",url];
        if ([str hasPrefix:@"wx048b3ef97edc87b1"]||[str hasPrefix:@"wx0cfdf60c4c082b3b"]) {
            return [WXApi handleOpenURL:url delegate:self];
        }
        //        else if ([str hasPrefix:caipiao365BackURLForAlipay]) {
        //            [self parseAlipayURL:url application:application];
        //        }
        else     if ([url.host isEqualToString:@"safepay"]) {
            if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[GC_UPMPViewController class]]) {
                GC_UPMPViewController *log = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
                [log NewZhiFuBao:str];
            }
            else if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[LoginViewController class]]) {
                LoginViewController *log = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
                [log alipayLogin:url];
            }
            else if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[RegisterViewController class]]) {
                RegisterViewController *Reg = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
                [Reg alipayLogin:url];
            }
        }
        else if ([str hasPrefix:@"caipiao365://"]) {
            [self application:application handleOpenURL:url];
        }
        else if ([str hasPrefix:[NSString stringWithFormat:@"wb%@",kSinaAppKey]]){
            //            id otherdelegate =
            //            if (otherdelegate && ([otherdelegate isKindOfClass:[LoginViewController class]] || ([otherdelegate isKindOfClass:[RegisterViewController class]]))) {
            //
            //            }
            if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[LoginViewController class]]) {
                return [WeiboSDK handleOpenURL:url delegate:[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject]];
            }
            else if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[RegisterViewController class]]) {
                return [WeiboSDK handleOpenURL:url delegate:[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject]];
            }
            else if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[KJXiangQingViewController class]]) {
                return [WeiboSDK handleOpenURL:url delegate:[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject]];
            }
            return [WeiboSDK handleOpenURL:url delegate:self];
            
        }
        else if( [sourceApplication isEqualToString:@"com.tencent.mqq"]) {
            NSString* hostString = [url host];
            NSString* queryString = [url query];
            
            NSMutableDictionary* queryDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            NSArray* queryArray = [queryString componentsSeparatedByString:@"&" ];
            for( NSString* paramItem in queryArray)
            {
                NSArray* pairArray = [paramItem componentsSeparatedByString:@"=" ];
                if( [pairArray count] == 2 )
                {
                    [queryDict setObject:pairArray[1] forKey:pairArray[0]];
                }
            }
            
            if( [hostString isEqualToString:@"response_from_qq"] &&
               [[queryDict objectForKey:@"version"] isEqualToString:@"1"]&&
               [[queryDict objectForKey:@"source"] isEqualToString:@"qq"] &&
               [[queryDict objectForKey:@"source_scheme"] isEqualToString:@"mqqapi"]
               )
            {
                NSString* errorNo = [queryDict objectForKey:@"error"];
                if([errorNo isEqualToString:@"0"] )
                {
                    NSLog(@"支付成功");
                    //下面执行支付成功后的用户提示与动作
                    if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[GC_UPMPViewController class]]) {
                        GC_UPMPViewController *log = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
                        [log QQpay:str];
                    }
                    //do something
                }
                else{
                    //支付出错处理
                    
                    NSString* errorInfo = [queryDict objectForKey:@"error_description"]; //错误信息
                    NSLog(@"支付出错:%@",errorInfo);//具体内容需要base64解码，demo不展示该部分内容
//                    NSData *nsdataFromBase64String = [[[NSData alloc]
//                                                      initWithBase64EncodedString:errorInfo options:0] autorelease];
//                    
//                    // Decoded NSString from the NSData
//                    NSString *base64Decoded = [[[NSString alloc]
//                                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding]autorelease];
//                    NSLog(@"支付出错:%@",base64Decoded);
                    
                    if([errorNo isEqualToString:@"1"])
                    {
                        //用户取消支付或因为传送tokenId错误造成支付无法进行
                        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"充值失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                    else
                    {
                        //其他错误值参考接口文档SDK
                        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"充值失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                }
            }
            else{
                //返回的基本参数不匹配，这种有可能是版本不匹配或冒充的QQ,建议记录下来或者提示用户反馈处理
                NSLog(@"错误格式的手机QQ支付通知返回");
            }
        }
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //caipiao365://?orderId=123
    if (url) {
        NSString *str = [NSString stringWithFormat:@"%@",url];
        if ([str hasPrefix:@"caipiao365://"]){
            
            //拆分订单号
            NSString *orderString =[str substringFromIndex:14];
            if([orderString hasPrefix:@"orderId"]){
            
                NSArray *array = [orderString componentsSeparatedByString:@"="];
                if(array && array.count>1){
                
                    orderString = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderIsScuu" object:orderString];

                }
            }
            
            
            str = [str substringFromIndex:13];
            NSArray *array = [str componentsSeparatedByString:@"&"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for(int i=0;i<[array count];i++){
                NSString *st2 = [array objectAtIndex:i];
                NSArray *arr = [st2 componentsSeparatedByString:@"="];
                if ([arr count] == 2){
                    [dic setValue:[arr objectAtIndex:1] forKey:[arr objectAtIndex:0]];
                }
                
            }
//            if([dic objectForKey:@"orderid"]&&[dic objectForKey:@"voicid"]){
//                NSString *detailPath = [dic objectForKey:@"voicid"];
//                NSString *orderID = [[dic objectForKey:@"orderid"] stringByReplacingOccurrencesOfString:@"%20" withString:@""];
//                NSArray *detaiArray = [detailPath componentsSeparatedByString:@"qq"];
//                NSString *timeS = [detaiArray lastObject];
//                NSInteger time = [[[timeS componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
//                NSString *filePath2 = [NSHomeDirectory() stringByAppendingPathComponent: [NSString stringWithFormat:@"Documents/GoodVoice/%@",detailPath]];
//                NSData *amrData = [NSData dataWithContentsOfFile:filePath2];
//                if (amrData) {
//                    [self upLoadGoodVoiceWithOrderID:orderID Path:filePath2 Type:1 Time:time];
//                }
//            }
            if ([dic count]&&[dic objectForKey:@"JumpToPage"]) {
                if ([[(UINavigationController *)self.window.rootViewController viewControllers] count] != 1 ){
                    newHomeViewController * nhome = [[newHomeViewController alloc] init];
                    MLNavigationController * nvc = [[[MLNavigationController alloc] initWithRootViewController:nhome] autorelease];
                    
                    
                    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
                    NSString * diyistr = [devicestr substringToIndex:1];
                    if ([diyistr floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
                        [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
#else
                    [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
#endif
                        //                        [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
                    }
                    
                    
                 //   [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
                    [nvc setNavigationBarHidden:YES animated:NO];
                    
                    self.window.rootViewController = nvc;
                    [nhome release];
                }
                
                [self performSelector:@selector(goPageBy:) withObject:dic afterDelay:0.1];
            }
            
            NSLog(@"str=%@",str);
        }
        
        if ([str hasPrefix:@"weixin"]) {
            return [WXApi handleOpenURL:url delegate:self];
        }
        
    }
    
    return  YES;
    
}



- (void)changeIpadBack {
    NSInteger hour = [[NSDate date] getHour];
    if (hour < 8) {
        IpadBackImageV.image = UIImageGetImageFromName(@"IpadBack01.jpg");
    }
    else if (hour < 12) {
        IpadBackImageV.image = UIImageGetImageFromName(@"IpadBack02.jpg");
    }
    else if (hour < 16) {
        IpadBackImageV.image = UIImageGetImageFromName(@"IpadBack03.jpg");
    }
    else if (hour  < 20) {
        IpadBackImageV.image = UIImageGetImageFromName(@"IpadBack04.jpg");
    }
    else {
        IpadBackImageV.image = UIImageGetImageFromName(@"IpadBack05.jpg");
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //    #ifndef __OPTIMIZE__
    //    UIDevice *device =[UIDevice currentDevice];
    //
    //    if (![[device model] hasSuffix:@"Simulator"]) {
    //        [self redirectNSLogToDocumentFolder];
    //    }
    //    #endif
    //NSLog(@"%@",[application UIApplicationLaunchOptionsURLKey]);
#ifdef isCaiPiaoForIPad
    if (!IpadBackImageV) {
        IpadBackImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [self.window insertSubview:IpadBackImageV atIndex:0];
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        rotationAnimation.duration = 0.0f;
        
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [IpadBackImageV.layer addAnimation:rotationAnimation forKey:@"run"];
        IpadBackImageV.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
        IpadBackImageV.center = self.window.center;
        
        [self changeIpadBack];
        [IpadBackImageV release];
    }
#endif
	if ([[NSUserDefaults standardUserDefaults] valueForKey:@"undoLongtime"]) {
		long int a ,now;
		now = [[NSDate date] timeIntervalSince1970];
		a = [[[NSUserDefaults standardUserDefaults] valueForKey:@"undoLongtime"] longLongValue];
		if (now - a > 3600) {//3600
			[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isunDoLongTime"];
            [self performSelectorInBackground:@selector(getCaizhongInfo) withObject:nil];
		}
        if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isJihuo"] intValue]) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"now"] forKey:@"jihuobegin"];
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue]) {
                NSLog(@"jihuoshengyu = %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue]);
                [self performSelector:@selector(jihuo365) withObject:nil afterDelay:[[[NSUserDefaults standardUserDefaults] valueForKey:@"jihuoshengyu"] intValue]];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setValue:@"180" forKey:@"jihuoshengyu"];
                [self performSelector:@selector(jihuo365) withObject:nil afterDelay:180];
            }
        }
        
	}
	
	loginselfcount = 0;
    isloginIng = NO;
	if ([[[Info getInstance] userId] intValue]) {
        
		[[GC_HttpService sharedInstance] performSelector:@selector(startHeartInfoTimer) withObject:nil afterDelay:1 ];
	}
    [self getRepair];

    YD_LOG( @"applicationDidBecomeActive");
	if ([[UIApplication sharedApplication] applicationIconBadgeNumber]>5) {
		NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
        
		if ([deviceToken length] >10) {
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBdelAppMsg:deviceToken]];
			[request setDefaultResponseEncoding:NSUTF8StringEncoding];
			[request setDelegate:self];
			[request setNumberOfTimesToRetryOnTimeout:2];
			[request performSelector:@selector(startAsynchronous) withObject:nil afterDelay:1];
            //			[request startAsynchronous];
            

		}
	}

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderIsScuu" object:@"14195851497019013"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"BecomeActive" object:nil];

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [DataBase closeDatabase];
    YD_LOG(@"applicationWillTerminate");
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    YD_LOG(@"applicationDidReceiveMemoryWarning");
}

// 打开定时器
- (void) openTimer
{
    

    NSInteger  secondInt = 600;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
   
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    NSString * date = [formatter stringFromDate:[NSDate date]];
    
    NSArray * dateArray = [date componentsSeparatedByString:@" "];
    if ([dateArray count] >= 2) {
        NSArray * timeArray = [[dateArray objectAtIndex:1] componentsSeparatedByString:@":"];
        
        if ([timeArray count] >= 3) {
            
            NSString * timeStr = [timeArray objectAtIndex:0];
            if ([timeStr intValue] >= 21 && [timeStr intValue] <= 23) {
                secondInt = 1200;
            }
            
        }
    }
    
    [formatter release];
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval: secondInt
                                                    target: self
                                                  selector: @selector(handleTimer:)
                                                  userInfo: nil
                                                   repeats: NO]];

}

- (void) handleTimer:(NSTimer*)timers
{
    loginselfcount = 0;
    isloginIng = NO;
    [self changeIpadBack];
    if ([[[Info getInstance] userId] intValue]) {
        timeCount = timeCount%20 +1;
        if (timeCount == 20) {
            [[GC_HttpService sharedInstance] startHeartInfoTimer];
            [self getCaizhongInfo];
        }
		[mrequest clearDelegatesAndCancel];
		
        
		[self setMrequest:[ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]]];
		[mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mrequest setDelegate:self];
		[mrequest setDidFinishSelector:@selector(unReadPushNumData:)];
		[mrequest setDidFailSelector:@selector(unReadPushNumDatafail:)];
		[mrequest setNumberOfTimesToRetryOnTimeout:2];
		[mrequest setShouldContinueWhenAppEntersBackground:YES];
		[mrequest startAsynchronous];
    }else{
        [self openTimer];
    }
}

// 接收 未读 消息 返回，设置  badgeValue
-(void)unReadPushNumData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	if (responseString)
    {
		
		//    NSArray * views = self.window.rootViewController.navigationController.viewControllers;
		//    if ([views objectAtIndex:1] == [HomeViewController class]) {
		//        UIViewController * c = [views objectAtIndex:1];
		//        if ([c respondsToSelector:@selector(autoRefresh:)]) {
		//            delegate = c;
		//            [delegate autoRefresh:responseString];
		//        }
		//    }
		
		NSDictionary *dic = [responseString JSONValue];
        NSString *kfsx = [NSString stringWithFormat:@"%@",[dic objectForKey:@"kfsx"]];
        NSString *allsx = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"sx"] intValue] + [[dic objectForKey:@"kfsx"] intValue]];

        
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"SoundSetPage_setSound"] integerValue] == 1){
        
            NSLog(@"声音已开，有新消息则提示");
            
            //本地存的私信数
            int kfsx_text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckNew_soundSet_kfsx"] intValue];
            int sx_text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckNew_soundSet_allsx"] intValue];

            if(([kfsx intValue] > 0 && [kfsx intValue] !=  kfsx_text)|| ([allsx intValue] > 0&&[allsx intValue] != sx_text)){
            
                if(audioPlayer){
                    
                    [audioPlayer stop];
                    [audioPlayer release];
                    audioPlayer = nil;

                }
                audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"mes_sound" ofType:@"mp3" inDirectory:@"/"]] error:nil];
                [audioPlayer play];
            }
            

        }

        [[NSUserDefaults standardUserDefaults] setValue:kfsx forKey:@"CheckNew_soundSet_kfsx"];//客服私信
        [[NSUserDefaults standardUserDefaults] setValue:allsx forKey:@"CheckNew_soundSet_allsx"];//所有私信
        
        NSString *hongBaoMes = [dic objectForKey:@"hongbaoMsg"];
        if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
            
            HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
            
            CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
            prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
            prizeView.tag = 201;
            prizeView.delegate = self;
            [prizeView show];
            [prizeView release];
            [hongbao release];
        }
        
        
		UINavigationController *a = (UINavigationController *)self.window.rootViewController;
		NSArray * views = a.viewControllers;
        UIViewController * newhome = [views objectAtIndex:0];
        
#ifdef isCaiPiaoForIPad
        
        if ([newhome isKindOfClass:[IpadRootViewController class]]) {
            delegate = newhome;
            [delegate autoRefresh:responseString];
        }
        
#else
        if ([newhome isKindOfClass:[newHomeViewController class]]) {
            delegate = newhome;
            [delegate autoRefresh:responseString];
        }
        
#endif
        
        
        
		if ([views count] >= 2) {
			PreJiaoDianTabBarController *c = [views objectAtIndex:1];
			if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                //                NSArray * viewss = c.viewControllers;
                
                UIViewController * cc = [c.viewControllers objectAtIndex:2];
				delegate = cc;
				[delegate autoRefresh:responseString];
			}
		}
		
        //    if ([views count] >= 2) {
        //        PreJiaoDianTabBarController *c = [views objectAtIndex:1];
        //        if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
        //            //                NSArray * viewss = c.viewControllers;
        //
        //            UINavigationController * cnav = [c.viewControllers objectAtIndex:0];
        //            UIViewController * homeview = [cnav.viewControllers objectAtIndex:0];
        //            delegate = homeview;
        //            [delegate autoRefresh:responseString];
        //        }
        //    }
		
		//    NSArray *views = tabBarController.viewControllers;
		//
		//		for (int i = 0; i < [views count];i++)
		//        {
		//            UINavigationController *nav = (UINavigationController*)[views objectAtIndex:i];
		//            UIViewController *c = [nav.viewControllers objectAtIndex:0];
		//            if ([c respondsToSelector:@selector(autoRefresh:)])
		//            {
		//                delegate = c;
		//                [delegate autoRefresh:responseString];
		//            }
		//        }
	}
    //注释
    if (needReLog ||[[[NSUserDefaults standardUserDefaults] objectForKey:@"needRelogin"] intValue] == 1) {
        // dddd
        [self LogInBySelf];
    }
	[self openTimer];
}

// 推送时 网络 出错 后 重新 请求 开启 定时器
-(void)unReadPushNumDatafail:(ASIHTTPRequest*)request
{
	[self openTimer];
}

// 计算 推送 消息数，用来 logo 中 提醒
- (int) unReadPushNum:(NSString*)responseString
{
	int counts = 0;
    
	if (responseString)
    {
        CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
		if (check)
        {
			int atme =[check.atme intValue];
			int pl = [check.pl intValue];
			int sx = [check.sx intValue];
			counts = atme + pl + sx;
		}
        [check release];
	}
	return counts;
}

+ (caiboAppDelegate *)getAppDelegate
{
    return (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
}

// 引导页面
- (void)guide:(NSNotification *)notification{
    //	NSInteger page = [[notification object] intValue];
    //	if(shouldGude || page == 4){
    //		shouldGude = NO;
    //		GuideView *guideV = [[GuideView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    //		[guideV LoadPageCount:page];
    //		[window addSubview:guideV];
    //		[guideV release];
    //	}
}
// 图片下载完成后回调更新图片




- (void)tuisong:(NSNotification *)notification{
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NetURL CBgetPushStatus:[[Info getInstance] userId]]];
	
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(parseSwitchStatu:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}

- (void)parseSwitchStatu:(ASIHTTPRequest *)request
{
	
    NSString *responseString = [request responseString];
	SBJSON *jsonParse = [[SBJSON alloc]init];
	NSDictionary *dic = [jsonParse objectWithString:responseString];
	if ([[dic objectForKey:@"zj"] boolValue]&&
		[[dic objectForKey:@"ssqkj"] intValue]&&
		[[dic objectForKey:@"sdkj"] intValue]&&
		[[dic objectForKey:@"qlckj"] intValue]&&
		[[dic objectForKey:@"dltkj"] intValue]&&
		[[dic objectForKey:@"pskj"] intValue]&&
		[[dic objectForKey:@"qxckj"] intValue]&&
		[[dic objectForKey:@"eekj"] intValue]&&
		[[dic objectForKey:@"zckj"] intValue]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您可以在更多->系统设置->推送通知中设置“开奖通知”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    [jsonParse release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag ==1001) {
        if (buttonIndex == 0) {
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav setNavigationBarHidden:NO animated:NO];
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            loginVC.isShowDefultAccount = YES;
            
            [loginVC.navigationController setNavigationBarHidden:NO];
            [nav pushViewController:loginVC animated:YES];
            [loginVC release];
#endif
            
        }
        else {
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav setNavigationBarHidden:YES animated:YES];
            PPTVLoginViewController *gou = [[PPTVLoginViewController alloc] init];
            [nav pushViewController:gou animated:YES];
            [gou release];
        }
    }
    else {
    }
    
}
- (void)showjianpanMessage:(NSString *)msg view:(UIWindow *)subview {
    if (!sumsgView) {
        
        
	    sumsgView = [[UILabel alloc] init];
		[sumsgView.layer setCornerRadius:10.0];
		sumsgView.layer.masksToBounds = YES;
		sumsgView.textColor = [UIColor whiteColor];
		sumsgView.font = [UIFont systemFontOfSize:13];
		sumsgView.textAlignment = NSTextAlignmentCenter;
        [subview insertSubview:sumsgView atIndex:10000];
        //		[subview addSubview:msgView];
        
		sumsgView.userInteractionEnabled = NO;
        sumsgView.numberOfLines = 0;
		sumsgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        sumsgView.tag = 156;
        
        
        
#ifdef isCaiPiaoForIPad
        CGSize max = CGSizeMake(200, 100);
        CGSize expectedSize = [msg sizeWithFont:sumsgView.font constrainedToSize:max lineBreakMode:UILineBreakModeWordWrap];
        sumsgView.frame = CGRectMake(60, self.window.rootViewController.view.frame.size.height - 65, 200, expectedSize.height+5);
        
        //        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        //        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        //        rotationAnimation.duration = 0.0f;
        //
        //        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //        [sumsgView.layer addAnimation:rotationAnimation forKey:@"run"];
        //        sumsgView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
#endif
        
	}
	if (![sumsgView superview]) {
		[window addSubview:sumsgView];
	}
	[window bringSubviewToFront:sumsgView];
    CGSize max = CGSizeMake(200, 100);
    CGSize expectedSize = [msg sizeWithFont:sumsgView.font constrainedToSize:max lineBreakMode:UILineBreakModeWordWrap];
    
	
    
#ifdef isCaiPiaoForIPad
    
    sumsgView.frame = CGRectMake(400, 700, 200, expectedSize.height+5);
    
    
#else
    if (gaodian) {
        sumsgView.frame = CGRectMake(60, 400, 200, expectedSize.height+5);
    }else{
        sumsgView.frame = CGRectMake(60, 430, 200, expectedSize.height+5);
    }
#endif
    
    
	sumsgView.text = msg;
	sumsgView.alpha = 0.7;
	sumsgView.tag = 156;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
	sumsgView.alpha = 1;
	[UIView commitAnimations];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(suhidenMessage) object:nil];
    
	
    [self performSelector:@selector(suhidenMessage) withObject:nil afterDelay:1.5];
	
    //    else{
    //        [self performSelector:@selector(hidenMessage) withObject:nil afterDelay:25];
    //    }
}

- (void)suhidenMessage{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	sumsgView.alpha = 0;
	[UIView commitAnimations];
}

- (void)showMessage:(NSString *)msg HidenSelf:(BOOL) hiden; {
	if (!msgView) {
		msgView = [[UILabel alloc] init];
		[msgView.layer setCornerRadius:10.0];
		msgView.layer.masksToBounds = YES;
		msgView.textColor = [UIColor whiteColor];
		msgView.font = [UIFont systemFontOfSize:13];
		msgView.textAlignment = NSTextAlignmentCenter;
		[window addSubview:msgView];
		msgView.userInteractionEnabled = NO;
        msgView.numberOfLines = 0;
		msgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        msgView.tag = 156;
        
#ifdef isCaiPiaoForIPad
        CGSize max = CGSizeMake(200, 100);
        CGSize expectedSize = [msg sizeWithFont:msgView.font constrainedToSize:max lineBreakMode:UILineBreakModeWordWrap];
        msgView.frame = CGRectMake(60, self.window.rootViewController.view.frame.size.height - 65, 200, expectedSize.height+5);
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        rotationAnimation.duration = 0.0f;
        
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [msgView.layer addAnimation:rotationAnimation forKey:@"run"];
        msgView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
#endif
	}
	if (![msgView superview]) {
		[window addSubview:msgView];
	}
	[window bringSubviewToFront:msgView];
    CGSize max = CGSizeMake(200, 100);
    CGSize expectedSize = [msg sizeWithFont:msgView.font constrainedToSize:max lineBreakMode:UILineBreakModeWordWrap];
#ifdef isCaiPiaoForIPad
    UIView *v = [self.window viewWithTag:10212];
    if (v) {
        msgView.frame = CGRectMake(60 , 63+95 + 250, expectedSize.height+5, 200);
    }
    else {
        msgView.frame = CGRectMake(60, 63+95, expectedSize.height+5, 200);
    }
    
    
#else
    if (gaodian) {
        msgView.frame = CGRectMake(60, self.window.bounds.size.height - 65, 200, expectedSize.height+5);
    }else{
        msgView.frame = CGRectMake(60, self.window.bounds.size.height - expectedSize.height/2 - 45, 200, expectedSize.height+5);
    }
#endif
    
	
	msgView.text = msg;
	msgView.alpha = 0.7;
	msgView.tag = 156;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
	msgView.alpha = 1;
	[UIView commitAnimations];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidenMessage) object:nil];
    if ([msg isEqualToString:@"建议在wifi环境中播放视频"]) {
        [self performSelector:@selector(hidenMessage) withObject:nil afterDelay:25];
    }
	if (hiden) {
		[self performSelector:@selector(hidenMessage) withObject:nil afterDelay:1.5];
	}
    //    else{
    //        [self performSelector:@selector(hidenMessage) withObject:nil afterDelay:25];
    //    }
}
- (void)showMessage:(NSString *)msg {
	[self showMessage:msg HidenSelf:YES];
}

- (void)showMessagetishi:(NSString *)msg{
    [self showMessage:msg HidenSelf:NO];
}

- (void)hidenMessage {
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5];
	msgView.alpha = 0;
	[UIView commitAnimations];
}


#pragma mark 传说中的推送通知 也不知道灵不灵

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    // <a1d6a951 3fea861c 23d8292a da2bf89a 43b5f636 8448905c 302b5597 8549b5ae>
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@", deviceToken];
    if ([deviceTokenStr hasPrefix:@"<"])
    {
        deviceTokenStr = [deviceTokenStr substringFromIndex:1];
    }
    if ([deviceTokenStr hasSuffix:@">"])
    {
        deviceTokenStr = [deviceTokenStr substringToIndex:([deviceTokenStr length] - 1)];
    }
    if ([deviceTokenStr length] > 10 && [[[Info getInstance] userId] length] == 0) {
        ASIHTTPRequest *reqLogin = [ASIHTTPRequest requestWithURL:[NetURL unLoginDevicenToken:deviceTokenStr]];
        [reqLogin setTimeOutSeconds:20.0];
		[reqLogin setDidFinishSelector:@selector(unLoginDevicenTokenFinish:)];
        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqLogin setDelegate:self];
        [reqLogin startAsynchronous];
    }
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"deviceToken"];
    NSLog(@"deviceTokenStr = %@", deviceTokenStr);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //    NSLog(@"获取失败%@",error);
    //	UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"11" message:[NSString stringWithFormat:@"%@",error] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //	[alert show];
    //	[alert release];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        [alert release];
        if ([[userInfo objectForKey:@"aps"] objectForKey:@"sound"]) {
            NSString *sound = [NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"sound"]];
            if ([sound isEqualToString:@"goal.wav"]) {
                [YDUtil playSound:@"goal"];
            }
        }
    }
    
//    CP_UIAlertView *alert2 = [[CP_UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@",userInfo] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    [alert2 show];
//    [alert2 release];
    
    


    
    NSLog(@"红包推送消息 : %@",userInfo);
    
    NSString *hongBaoMes = [userInfo objectForKey:@"hongbaoMsg"];
    
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = [hongbao.showType intValue]-1;
        prizeView.delegate = self;
        prizeView.tag = 202;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    
	//[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
}

#pragma mark 打印日志
- (void)redirectNSLogToDocumentFolder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log",[NSDate date]];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

#pragma mark 清除声音7天
- (void)cleanDisk
{
    
    NSString *filePath2 = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents/GoodVoice"];
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*7];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:filePath2];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [filePath2 stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[[attrs fileModificationDate] laterDate:expirationDate] isEqualToDate:expirationDate])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

#pragma mark 友盟
- (void)umengTrack {
#ifndef __OPTIMIZE__
    return
#endif
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:[[Info getInstance] cbVersion]]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) SEND_INTERVAL channelId:[[Info getInstance] cbSID]];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (UIImage *)JiePing
{
    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, self.window.opaque, 0.0);
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark 微信

- (void)saveImageFunc{
}

- (UIImage *)screenshotWithScrollView:(UIScrollView *)scrollView bottomY:(float)bottomY titleBool:(BOOL)yesOrNo //bottomY截到位置的y
{
    [scrollView setContentOffset:CGPointZero];
    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGImageRef imageRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    CGFloat yfloat = 0;
    CGFloat hightFloat = 0;
    if (yesOrNo) {
        yfloat = 20 *2;
         hightFloat = 44 *2;
       
    }else{
        yfloat =64 * 2;
    }
    CGRect rect = CGRectMake(0, yfloat, self.window.frame.size.width * 2, scrollView.frame.size.height * 2+hightFloat);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIGraphicsEndImageContext();
    UIImage *sendImage = [[[UIImage alloc] initWithCGImage:imageRefRect] autorelease];
    CFRelease(imageRefRect);
    [scrollView setContentOffset:CGPointMake(0, scrollView.frame.size.height) animated:NO];
    
   
    
   
    
    if (yesOrNo == NO) {
        UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
        [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
        
        NSLog(@"one = %f, two = %f , three = %f, four = %f", scrollView.frame.size.height * 2+hightFloat, (bottomY - scrollView.frame.size.height) * 2, bottomY ,scrollView.frame.size.height);
        CGRect rect1 = CGRectMake(0, 64 * 2, self.window.frame.size.width * 2, (bottomY - scrollView.frame.size.height) * 2);
        CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
        UIImage *sendImage1 = [[[UIImage alloc] initWithCGImage:imageRefRect1] autorelease];
        CFRelease(imageRefRect1);
        CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
        UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
        UIImage * topImage = UIImageGetImageFromName(@"daigoubgimage.png");
        [topImage drawInRect:CGRectMake(0, 0, self.window.bounds.size.width * 2, 44 * 2)];
        UIImage * screenshotLogoImage = UIImageGetImageFromName(@"ScreenshotLOGO.png");
        [screenshotLogoImage drawInRect:CGRectMake(10 * 2, 44 - 22.5 - 2, 140, 45)];
        [[UIColor whiteColor] setFill];
        [@"应用商店搜索 投注站" drawInRect:CGRectMake(20 + 140 + 20, 30, 400, 60) withFont:[UIFont boldSystemFontOfSize:26]];
        [sendImage drawInRect:CGRectMake(0, 44 * 2, rect.size.width, rect.size.height)];
        [sendImage1 drawInRect:CGRectMake(0, (44 + scrollView.frame.size.height) * 2, rect1.size.width, rect1.size.height)];
        
    }else{
        
        

        
        
        
        int count = bottomY/scrollView.frame.size.height;
        
        if (count * scrollView.frame.size.height < bottomY) {
            count = count+1;
        }
        if (count > 1) {
           
            
            
          
            
            NSMutableArray * imageArray = [NSMutableArray array];
            CGFloat offy = scrollView.frame.size.height;
            for (int i = 0; i < count - 1; i++) {
               
                [scrollView setContentOffset:CGPointMake(0, offy) animated:NO];
                
                UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
                [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
                
                CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
                UIGraphicsEndImageContext();
                CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
                UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
                
                CGFloat rectHight = scrollView.frame.size.height * 2;
                if (i == count - 2) {
                    rectHight = (bottomY - (count-1) * scrollView.frame.size.height)*2;
                }
                CGRect rect1 = CGRectMake(0, 64 * 2, self.window.frame.size.width * 2, rectHight );
                
                
                
                CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
                UIImage *sendImage1 = [[[UIImage alloc] initWithCGImage:imageRefRect1] autorelease];
                CFRelease(imageRefRect1);
                [imageArray addObject:sendImage1];
                offy = offy +  scrollView.frame.size.height ;
                
                
            }
            
            
            
            UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
            [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIGraphicsEndImageContext();
            CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
            UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
            
            [sendImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            CGFloat hight = rect.size.height;
            for (int i = 0; i < [imageArray count]; i++) {
                UIImage * sendImage1 = [imageArray objectAtIndex:i];
                CGFloat rectHight = scrollView.frame.size.height *2;
                
                if (i == [imageArray count] - 1) {
                    rectHight = (bottomY - (count-1) * scrollView.frame.size.height)*2;
                }
                
//                if ([imageArray count] == 1) {
//                    [sendImage1 drawInRect:CGRectMake(0,  hight- 9, self.window.frame.size.width * 2, rectHight)];
//                }else{
                    [sendImage1 drawInRect:CGRectMake(0,  hight, self.window.frame.size.width * 2, rectHight)];
//                }
                
                NSLog(@"hight = hight + rectHight; = %f", hight/2.0);
                hight = hight + rectHight ;
            }
            
            
        }else{
        
            
            UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 2); //currentView 当前的view
            [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            
//            CGImageRef imageRef1 = UIGraphicsGetImageFromCurrentImageContext().CGImage;
            UIGraphicsEndImageContext();
            
//            CGRect rect1 = CGRectMake(0, 64 * 2, self.window.frame.size.width * 2, (bottomY - scrollView.frame.size.height) * 2 );
//            CGImageRef imageRefRect1 =CGImageCreateWithImageInRect(imageRef1, rect1);
//            UIImage *sendImage1 = [[UIImage alloc] initWithCGImage:imageRefRect1];
            
            CGSize size = CGSizeMake(self.window.bounds.size.width * 2, (bottomY + 44) * 2);
            UIGraphicsBeginImageContextWithOptions(size, NO, 2); //currentView 当前的view
            
            [sendImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
//            [sendImage1 drawInRect:CGRectMake(0,  rect.size.width, rect1.size.width, rect1.size.height)];
        }
       
        
        
    }
    

    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [scrollView setContentOffset:CGPointZero];
    if (IS_IPHONE_5) {
        
        CGSize Newsize = CGSizeMake(640, resultingImage.size.height);
        UIGraphicsBeginImageContext(Newsize);
        // 绘制改变大小的图片
        [resultingImage drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return TransformedImg;
        
    }
    return resultingImage;
}

- (UIImage *)imageWithScreenContents{//
    
    UIGraphicsBeginImageContext(self.window.bounds.size); //currentView 当前的view
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.window.bounds.size.width, self.window.bounds.size.height-20)];
    bgimage.backgroundColor = [UIColor clearColor];
    [bgimage.layer setMasksToBounds:YES];
    UIImageView * samImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, self.window.bounds.size.width, self.window.bounds.size.height)];
#ifdef isCaiPiaoForIPad
    samImage.frame = bgimage.bounds;
#endif
    samImage.backgroundColor = [UIColor clearColor];
    samImage.image = viewImage;
    [bgimage addSubview:samImage];
    [samImage release];
    
    UIGraphicsBeginImageContext(bgimage.bounds.size); //currentView 当前的view
    [bgimage.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [bgimage release];
    
    if (IS_IPHONE_5) {
        
        CGSize Newsize = CGSizeMake(320, viewImage.size.height);
        UIGraphicsBeginImageContext(Newsize);
        // 绘制改变大小的图片
        [viewImage drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return TransformedImg;
        
    }
    return viewImage;
    
    
    
}

- (void) viewContent:(WXMediaMessage *) msg
{
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"消息来自微信"];
    NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, (int)msg.thumbData.length];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (void)doAuth
{
    //    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
    //    req.scope = @"post_timeline";
    //    req.state = @"xxx";
    //
    //    [WXApi sendReq:req];
}



-(void) onSentTextMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送文本消息结果:%u", bSent];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void) onSentMediaMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%u", bSent];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

-(void) onSentAuthRequest:(NSString *) userName accessToken:(NSString *) token expireDate:(NSDate *) expireDate errorMsg:(NSString *) errMsg
{
    
}

-(void) onShowMediaMessage:(WXMediaMessage *) message
{
    // 微信启动， 有消息内容。
    [self viewContent:message];
}

- (void)statisticsInfo:(NSString *)blog{//统计方案详情分享
    
    ASIHTTPRequest * httpRequest = [ASIHTTPRequest requestWithURL:[NetURL shareBlogActivityRequest:blog]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqShareBlogFinsh:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
    
}
- (void)reqShareBlogFinsh:(ASIHTTPRequest *)request{
    
    //    NSString * str = [request responseString];
    //    NSDictionary * dict = [str JSONValue];
    //    NSLog(@"reqShareBlogFinsh = %@", [dict objectForKey:@"code"]);
    
}


-(void) onResp:(BaseResp*)resp
{
    //    return;
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
//        NSString *strTitle = [NSString stringWithFormat:@"提示"];
        //        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        NSString * codeString = @"";
        if (resp.errCode == 0) {
            codeString = @"分享成功";
            UINavigationController *a = (UINavigationController *)self.window.rootViewController;
            NSArray * views = a.viewControllers;
            if ([[views lastObject] isKindOfClass:[ShuangSeQiuInfoViewController class]]) {
                ShuangSeQiuInfoViewController * shuang = [views lastObject];
                NSLog(@"BetDetailInfo.programNumber = %@", shuang.BetDetailInfo.programNumber);
                [self statisticsInfo:shuang.BetDetailInfo.programNumber];
            }
            
        }else{
            codeString = @"分享失败";
        }
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:codeString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[LoginViewController class]]) {
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            LoginViewController *log = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
            [log WXLogin:resp2.code];
        }
        else if ([[[(UINavigationController *)self.window.rootViewController viewControllers] lastObject] isKindOfClass:[RegisterViewController class]]) {
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            RegisterViewController *Reg = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
            [Reg WXLogin:resp2.code];
        }
        
    }
    else if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                UIViewController *contolor = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
                if ([contolor respondsToSelector:@selector(getAccountInfoRequest)]) {
                    [contolor performSelector:@selector(getAccountInfoRequest)];
                }
                [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"微信支付"];
                [[caiboAppDelegate getAppDelegate] showMessage:@"支付成功"];
            }
                break;
            default: {
                [[caiboAppDelegate getAppDelegate] showMessage:@"支付失败"];
            }
            break; }
    }
    //    else if([resp isKindOfClass:[SendAuthResp class]])
    //    {
    //        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    //        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    //    }
}
- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        UIGraphicsBeginImageContext(asize);
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}

- (void) sendImageContent:(UIImage *)imageName
{
    //发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    
    UIImage *  sltImage = [self thumbnailWithImage:imageName size:CGSizeMake( 100, 150)];
    
    
    [message setThumbImage:sltImage];//[UIImage imageNamed:@"ceshitupian.png"]];
    
    
    
    
    WXImageObject *ext = [WXImageObject object];
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ceshitupian" ofType:@"png"];
    ext.imageData = UIImagePNGRepresentation(imageName);//[NSData dataWithContentsOfFile:filePath] ;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    
    [WXApi sendReq:req];
}

-(void) onReq:(BaseReq*)req{
    
}

#pragma mark 网络请求回调
-(void)getActiveWindowMessageFinished:(ASIHTTPRequest *)request
{
    NSString *result = [request responseString];
    NSLog(@"应用内弹窗请求成功 : %@",request.responseString);

    if(result && ![result isEqualToString:@"fail"])
    {
        NSDictionary *dic = [result JSONValue];
        if([[dic objectForKey:@"code"] integerValue] == 1)
        {
            linkType = (int)[[dic objectForKey:@"linkType"] integerValue];
            self.linkUrl = [dic objectForKey:@"linkUrl"];
            NSString *imageUrl = [dic objectForKey:@"imageUrl"];
            self.uploadTime  = [dic objectForKey:@"uploadTime"];
            NSString *upload_time = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUploadTime"];
            if(![uploadTime isEqualToString:upload_time])
            {
                //需要显示弹窗
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"needShowAPPFlashAd"];
                [self downActiveWindowImage:imageUrl];

            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"needShowAPPFlashAd"];

            }

            NSString *systime  = [dic objectForKey:@"Systime"];
            
            NSLog(@"\n应用内弹窗-链接类型%d\n链接地址%@\n图片地址%@\n链接添加时间%@\n上一次链接添加时间%@\n系统时间%@",linkType,linkUrl,imageUrl,uploadTime,upload_time,systime);
        }
    }
}
-(void)getActiveWindowMessageFailed:(ASIHTTPRequest *)request
{
    NSLog(@"应用内弹窗请求失败 : %@",request.responseString);
}

- (void)caizhongBack:(ASIHTTPRequest *)request {
    NSString *responseStr = [request responseString];
//    responseStr = @"1:108,119,121,011,013,012,019,001,113,002,006,014,122,110,003,109@2:201,300,301,400,200@3:001,113,002,122,119,013,012,019,300,201,200,400,011,006,014,110,108,109,003,302,303";//假数据
    NSDictionary * dic = [responseStr JSONValue];
    if (dic) {
        NSString * supportStr = [dic valueForKey:@"showIos_tc_4"];
        if (supportStr && supportStr.length) {
            NSArray * array = [supportStr componentsSeparatedByString:@","];
            if (array && array.count) {
                [[NSUserDefaults standardUserDefaults] setValue:array forKey:@"serverCaiZhongZhiChi"];
            }
        }
    }
}

- (void)unLoginDevicenTokenFinish:(ASIHTTPRequest *)request {
    NSString *responseStr = [request responseString];
    NSDictionary * dict = [responseStr JSONValue];
    if ([[dict objectForKey:@"code"] intValue] == 1) {
        
    }
}

//加载本地信息
- (void)loadSelfInfo {
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    NSLog(@"info = %@", infosave);
    if ([infosave length] ) {
        
        NSArray * infoarr = [infosave componentsSeparatedByString:@";"];
        
        // unionstatus
        
        if ([infoarr count] > 7) {
            Info *info = [Info getInstance];
            info.login_name = [infoarr objectAtIndex:0];
            info.userId = [infoarr objectAtIndex:1];
            info.nickName = [infoarr objectAtIndex:2];
            // info.password = [infoarr objectAtIndex:7];
            
            info.userName = [infoarr objectAtIndex:3];
            info.isbindmobile = [infoarr objectAtIndex:5];
            info.authentication = [infoarr objectAtIndex:6];
            
            UserInfo *userInfo = [[UserInfo alloc] init];
            
            userInfo.userId = [infoarr objectAtIndex:1];
            userInfo.nick_name = [infoarr objectAtIndex:2];
            userInfo.user_name = [infoarr objectAtIndex:3];
            
            userInfo.isbindmobile = [NSString stringWithFormat:@"%d",[[infoarr objectAtIndex:5] intValue]];//
            userInfo.authentication = [infoarr objectAtIndex:6];//换网络
            userInfo.unionStatus = [infoarr objectAtIndex:7];//
            info.mUserInfo = userInfo;
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.isbindmobile forKey:@"isbindmobile"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.authentication forKey:@"authentication"];
            [userInfo release];
        }
    }
    
}

- (void)bcrecivedFinish:(ASIHTTPRequest *)ssrequest {
	NSString *responseStr = [ssrequest responseString];
    NSDictionary * dict = [responseStr JSONValue];
    NSLog(@"dict = %@", dict);
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    NSLog(@"info = %@", infosave);
    NSArray * infoarr = [infosave componentsSeparatedByString:@";"];
    
    // unionstatus
    if ([[dict objectForKey:@"user_status"] isEqualToString:@"0"]) {
        //        退出登录
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
        [[caiboAppDelegate getAppDelegate] showMessage:@"您的帐号已被锁定，请联系客服"];
        Info *info = [Info getInstance];
        info.login_name = @"";
        info.userId = @"";
        info.nickName = @"";
        info.userName = @"";
        info.isbindmobile = @"";
        info.authentication = @"";
        info.userName = @"";
        info.requestArray = nil;
        info.mUserInfo = nil;
        [ASIHTTPRequest setSessionCookies:nil];
        //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
        [[Info getInstance] setMUserInfo:nil];
        [ASIHTTPRequest clearSession];
        [GC_UserInfo sharedInstance].personalData = nil;
        [GC_HttpService sharedInstance].sessionId = nil;
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
        return;
    }
    
    Info *info = [Info getInstance];
    info.login_name = [infoarr objectAtIndex:0];
    info.userId = [infoarr objectAtIndex:1];
    info.nickName = [infoarr objectAtIndex:2];
    // info.password = [infoarr objectAtIndex:7];
    if ([[dict objectForKey:@"mid_image"] length] && ![[dict objectForKey:@"mid_image"] hasPrefix:@"http"]) {
        info.headImageURL = [NSString stringWithFormat:@"http://t.diyicai.com/%@",[dict objectForKey:@"mid_image"]];
    }
    info.userName = [infoarr objectAtIndex:3];
    info.isbindmobile = [infoarr objectAtIndex:5];
    info.authentication = [infoarr objectAtIndex:6];
    
    UserInfo *userInfo = [[UserInfo alloc] init];
    
    userInfo.userId = [infoarr objectAtIndex:1];
    userInfo.nick_name = [infoarr objectAtIndex:2];
    userInfo.user_name = [infoarr objectAtIndex:3];
    
    userInfo.isbindmobile = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"isbindmobile"] intValue]];//
    userInfo.authentication = [dict objectForKey:@"authentication"];//换网络
    userInfo.unionStatus = [dict objectForKey:@"untion_status"];//
    userInfo.accesstoken = [dict objectForKey:@"accesstoken"];
    info.mUserInfo = userInfo;
    info.accesstoken = [dict objectForKey:@"accesstoken"];
    
    [[NSUserDefaults standardUserDefaults] setValue:userInfo.isbindmobile forKey:@"isbindmobile"];
    [[NSUserDefaults standardUserDefaults] setValue:userInfo.authentication forKey:@"authentication"];
    
    
    //防沉迷总开关
    NSString *addictSwitch = [NSString stringWithFormat:@"%@",[dict objectForKey:@"addictSwitch"]];
    [[NSUserDefaults standardUserDefaults] setValue:addictSwitch forKey:@"FangChenMiSwitch"];
    
    //是否绑定银行卡
    NSString *isBind = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isbind_Bank"]];
    [[NSUserDefaults standardUserDefaults] setValue:isBind forKey:@"isBindBankCard"];
    
    //红包提醒信息
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.delegate = self;
        prizeView.tag = 200;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    [User insertDB:(info)];
    
    [userInfo release];
    
    Statement *stmt = [DataBase statementWithQuery:"SELECT * FROM users"];
    static short count;
    while ([stmt step] == SQLITE_ROW)
    {
        User *user = [User userWithStatement:stmt];
        if (user)
        {
            count ++;
        }
    }
    [stmt reset];
    
    //保存新的loginsave信息
    NSMutableArray * infoarr2 = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    [infoarr2 addObject:info.login_name];
    [infoarr2 addObject:info.userId];
    [infoarr2 addObject:info.nickName];
    [infoarr2 addObject:info.userName];
    [infoarr2 addObject:info.mUserInfo];
    [infoarr2 addObject:[NSString stringWithFormat:@"%d",[[dict objectForKey:@"isbindmobile"] intValue]]];//info.isbindmobile];
    [infoarr2 addObject:info.authentication];
    [infoarr2 addObject:@""];//info.password];
    if (userInfo.unionStatus) {
        [infoarr2 addObject:userInfo.unionStatus];//userInfo.unionStatus];
    }
    else {
        [infoarr2 addObject:@""];//userInfo.unionStatus];
    }
    
    if (userInfo.partnerid) {
        [infoarr2 addObject:userInfo.partnerid];
    }
    else {
        [infoarr2 addObject:@""];
    }
    
    if (userInfo.unionId) {
        [infoarr2 addObject:userInfo.unionId];
    }
    else {
        [infoarr2 addObject:@""];
    }
    if (userInfo.accesstoken) {
        [infoarr2 addObject:info.accesstoken];
    }else{
        [infoarr2 addObject:@""];
    }
    
    //获取应用内弹窗信息
    [self getActiveWindowMessage];

    
    NSString *st = [infoarr2 componentsJoinedByString:@";"];
    
    [[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
    UINavigationController *a = (UINavigationController *)self.window.rootViewController;
    NSArray * views = a.viewControllers;
    UIViewController * newhome = [views objectAtIndex:0];
    if ([newhome isKindOfClass:[newHomeViewController class]]) {
        [(newHomeViewController *)newhome  performSelector:@selector(yanchidiao) withObject:nil];
    }
    
    
    
    [self LogInBySelf];
}

- (void)sleepStarGuiDanViewHidden{
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(sleepstarGuidanRemoveFromSuperview)];
	starGuidan.frame = CGRectMake(-starGuidan.frame.size.width, starGuidan.frame.origin.y, starGuidan.frame.size.width, starGuidan.frame.size.height);
	[UIView commitAnimations];
    
}

- (void)sleepstarGuidanRemoveFromSuperview{
    
    if (starGuidan) {
        [starGuidan removeFromSuperview];
        starGuidan = nil;
    }
    
}

- (void)oneLoginFunc{

//    return;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"oneLogin"] integerValue] == 0) {
    
        
        NSLog(@"StartGuideViewStartGuideViewStartGuideViewStartGuideView 333");
        
//        guideView = [[StartGuideView alloc] initWithFrame:self.window.bounds];
//        guideView.delegate = self;
//        [self.window addSubview:guideView];
//        [guideView release];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"oneLogin"] integerValue] == 0) {
//    
//        StartYindaoView *yindaoView = [[StartYindaoView alloc]initWithFrame:self.window.bounds];
//        yindaoView.delegate = self;
//        [self.window addSubview:yindaoView];
//        [yindaoView release];
//        
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneLogin"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
}
-(void)disMissFromSuperView:(StartYindaoView *)yidaoView withBtnIndex:(NSInteger)index{

    if(index == 555){
    
        [self showJiHuoHongbao];
    }
}
-(void)showJiHuoHongbao{

    if(jihuoHongbaoMsg && jihuoHongbaoMsg.length && ![jihuoHongbaoMsg isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:jihuoHongbaoMsg];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.delegate = self;
        prizeView.tag = 203;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
}
#pragma mark 弹窗图片广告 下载 回调
-(void)imageDownloaderFinished:(ASIHTTPRequest *)request
{
    NSLog(@"弹窗图片广告下载完成");
    UIImage *downImage = [UIImage imageWithData:request.responseData];
    self.alertImage = downImage;
    downImage = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:uploadTime forKey:@"lastUploadTime"];
    
    if(self.alertImage)
    {
        NSString *isNeedShow = [[NSUserDefaults standardUserDefaults] valueForKey:@"needShowAPPFlashAd"];
        if([isNeedShow integerValue] == 1  && welcomePageOver)
        {
            [self performSelector:@selector(addFlashAd) withObject:nil afterDelay:0.2];
        }
    }
    
}
-(void)imageDownloaderFailed:(ASIHTTPRequest *)request
{

    NSLog(@"弹窗图片广告下载失败: %@",request.responseString);
}
#pragma mark 所有官方账号下载
-(void)requestReceivedResponseHeaders:(ASIHTTPRequest *)request
{
    all365AccountTxtLength = [[NSUserDefaults standardUserDefaults] valueForKey:@"all365AccountTxtLength"];
    
    if([[request.responseHeaders objectForKey:@"Content-Length"] intValue] == [all365AccountTxtLength intValue])
    {
        [request clearDelegatesAndCancel];
    }
    else
    {
        all365AccountTxtLength=[request.responseHeaders objectForKey:@"Content-Length"];
        [[NSUserDefaults standardUserDefaults] setValue:all365AccountTxtLength forKey:@"all365AccountTxtLength"];
    }
    
}

-(void)all365AccountDownloaderFinished:(ASIHTTPRequest *)request
{
    NSData *resultData = [request responseData];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths objectAtIndex:0];
	NSString *txtPath = [path stringByAppendingPathComponent:@"all365Account.txt"];
    if(resultData && resultData.length)
        [resultData writeToFile:txtPath atomically:YES];
    NSLog(@"官方账号文件下载完成 :%@ %@",resultData,txtPath);
}
-(void)all365AccountDownloaderFailed:(ASIHTTPRequest *)request
{
    NSLog(@"官方账号文件下载失败 : %@",request.responseString);
}
#pragma mark 引导页 StartGuideView Delegate

- (void)homeAnimation{
    
    UINavigationController *a = (UINavigationController *)self.window.rootViewController;
    NSArray * views = a.viewControllers;
    UIViewController * newhome = [views objectAtIndex:0];
    if ([newhome isKindOfClass:[newHomeViewController class]]) {
        [(newHomeViewController *)newhome  performSelector:@selector(homeAnimationFunc) withObject:nil];
    }

    
}

-(void)disMissGuideViewFromSuperView
{
//    guidePageOver = YES;
    NSLog(@"引导页结束，显示弹窗广告");
//
//    if(self.alertImage)
//    {
//        NSString *isNeedShow = [[NSUserDefaults standardUserDefaults] valueForKey:@"needShowAPPFlashAd"];
//
//        if([isNeedShow integerValue] == 1)
//        {
//            [self performSelector:@selector(addFlashAd) withObject:nil afterDelay:0.2];
//        }
//    }
    
    
//    [self performSelector:@selector(homeAnimation) withObject:self afterDelay:0.3];


}

- (void)showNetErrore {
    
}
#pragma mark 欢迎页结束
- (void)dismissWelcomePage{

    NSLog(@"StartGuideViewStartGuideViewStartGuideViewStartGuideView 222");
    
    [welcomePage removeFromSuperview];
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"oneLogin"] integerValue] != 0) {
//        [self performSelector:@selector(homeAnimation) withObject:self afterDelay:0.3];
//    }
    

    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"startAnimated"] integerValue] == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startAnimated" object:self];
    }

    
//    [self oneLoginFunc];
    
    ASIHTTPRequest * httpRequest = [ASIHTTPRequest requestWithURL:[NetURL checkUpDateFunc]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
    welcomePageOver = YES;
    
    

    if(self.alertImage)
    {
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"oneLogin"] integerValue] == 1)
        {
            NSString *isNeedShow = [[NSUserDefaults standardUserDefaults] valueForKey:@"needShowAPPFlashAd"];

            if([isNeedShow integerValue]==1)
            {
                [self performSelector:@selector(addFlashAd) withObject:nil afterDelay:0.2];
            }
        }
    }
    
    self.jiangetime = [NSDate date];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"openDefault"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
	return;
}

- (void)recivedFail:(ASIHTTPRequest *)request {
    needReLog = YES;
	//[self performSelector:@selector(dismissWelcomePage) withObject:nil afterDelay:2.0];
}

- (void)recivedLoginByselfFail:(ASIHTTPRequest *)request {
    isloginIng = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmisspop" object:self];
    
}

- (void)recivedLoginByselfFinish:(ASIHTTPRequest *)request {
    NSLog(@"%@\n%@",[request responseCookies],[ASIHTTPRequest sessionCookies]);
    needReLog = NO;
    isloginIng = NO;
    if ([request responseData]) {
        GC_HeartInfo *heartInfo = [[GC_HeartInfo alloc] initWithResponseData:[request responseData] WithRequest:request];
        if ([heartInfo.systemTime length]) {
          [[NSUserDefaults standardUserDefaults] setValue:heartInfo.systemTime forKey:@"sysTime"];
        }
        
        if (heartInfo.returnId == 3000) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmisspop" object:self];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"needRelogin"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hasGetsession_id" object:self];
            NSMutableArray *requestArray = [[Info getInstance] requestArray];
            if ([requestArray count]) {
                for (int i = 0; i < [requestArray count]; i ++) {
                    ASIHTTPRequest *request2 = [requestArray objectAtIndex:i];
                    if (request.delegate) {
                        ASIHTTPRequest *request3 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                        request2.url = [request3 url];
                        [request2 startAsynchronous];
                    }
                }
            }
            [requestArray removeAllObjects];
        }
        [heartInfo release];
        
        
    }
    
}

- (void)reqGoogVoice:(ASIHTTPRequest*)request {
    NSLog(@"1111");
    if ([request responseData]) {
        GoodVoiceJieXie *jiexi = [[GoodVoiceJieXie alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (jiexi.returnId == 3000) {
            [jiexi release];
            return;
        }
        if ([jiexi.code intValue] > 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:jiexi.msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
        }
        else {
            if (uploadDelegatel && [uploadDelegatel respondsToSelector:uploadFinish]) {
                [uploadDelegatel performSelector:uploadFinish];
            }
        }
        [jiexi release];
    }
}

- (void)dealloc
{
    [audioPlayer release];
    receiver.imageContainer = nil;
    [receiver release];
    alertImage = nil;
    [sendViewControllerArray release];
    [sendView release];
    [keFuButton release];
    [hylistarray release];
    [jiangetime release];
	delegate = nil;
    [imageDownloader release];
	;
	[mrequest clearDelegatesAndCancel];
	self.mrequest = nil;
    
    [hostReach startNotifier];
    [hostReach release];
	
	[timer invalidate];
	[timer release];
    
    [readingMode release];
    
    [homeItem release];
    [focusItem release];
    [window release];
	[msgView release];
    [sumsgView release];
    
    [super dealloc];
}
#pragma mark 请求支持彩种
- (void)getCaizhongInfo {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:buyLotteryHall]];
    [request setDefaultResponseEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(caizhongBack:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
}

#pragma mark WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    id weibodegate =  [response.requestUserInfo objectForKey:@"delegate"];
    if (weibodegate && [weibodegate respondsToSelector:@selector(didReceiveWeiboResponse:)]) {
        [weibodegate didReceiveWeiboResponse:response];
    }
}

#pragma mark Umeng2

- (void)umengtrack2 {
    NSString * appKey = @"546c630afd98c52d32001294";
    NSString * deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * mac = [self macString];
    NSString * idfa = [self idfaString];
    NSString * idfv = [self idfvString];
    NSString * urlString = [NSString stringWithFormat:@"http://log.umtrack.com/ping/%@/?devicename=%@&mac=%@&idfa=%@&idfv=%@", appKey, deviceName, mac, idfa, idfv];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] delegate:nil];

}

- (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

- (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

- (void)hongBaoFunction:(NSString *)_functionType topicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    //跳转充值
    if([@"1" isEqualToString:_functionType]){
    
        GC_TopUpViewController *topup = [[GC_TopUpViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:topup animated:YES];
        [topup release];
    }
    //跳转完善信息
    if([@"2" isEqualToString:_functionType]){
        
        ProvingViewCotroller *topup = [[ProvingViewCotroller alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:topup animated:YES];
        [topup release];
    }
    //跳转我的彩票
    if([@"3" isEqualToString:_functionType]){
        
//        GouCaiHomeViewController *topup = [[GouCaiHomeViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
//        [nav pushViewController:topup animated:YES];
//        [topup release];
        
        HRSliderViewController *my = [[[HRSliderViewController alloc] init] autorelease];
        [nav pushViewController:my animated:YES];
    }
    //跳转购彩
    if([@"4" isEqualToString:_functionType]){
        
        [self goGCPageWithlotteryID:_lotteryid andWanfa:nil];
    }
    //跳转活动
    if([@"5" isEqualToString:_functionType]){
        
        MyWebViewController * jl = [[MyWebViewController alloc] init];
        jl.webTitle = @"奖励活动";
        [jl LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://caipiao365.com/huodong/index.html"]]];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:jl animated:YES];
        [jl release];
    }
    //跳转微博
    if([@"6" isEqualToString:_functionType]){
        
        [self goWBDetailMsgWithID:_lotteryid];
    }
    //跳转注册
    if([@"7" isEqualToString:_functionType]){
    
        RegisterViewController * registerCon = [[RegisterViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:registerCon animated:YES];
        [registerCon release];
    }
}
-(void)goGCPageWithlotteryID:(NSString *)lotteryid andWanfa:(NSString *)wanfa{

    NSLog(@"跳转到客户端购彩页");
        
    modetype = [GC_LotteryType changeWanfaToModeTYPE:lotteryid Wanfa:wanfa];
    lotteryType = [GC_LotteryType shiyixuanwuChangeWanfaToLotteryType:lotteryid Wanfa:wanfa];

    
    if ([lotteryid isEqualToString:@"119"]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
        highview.lotterytype = lotteryType;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"121"]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
        highview.lotterytype = lotteryType;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:LOTTERY_ID_JIANGXI_11]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
        highview.lotterytype = lotteryType;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"123"]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:HeBei11];
        highview.lotterytype = lotteryType;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:LOTTERY_ID_SHANXI_11]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanXi11];
        highview.lotterytype = lotteryType;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"012"]) {
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
        highview.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"013"]) {
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
        highview.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"019"]) {
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
        highview.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"018"]) {
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
        highview.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:LOTTERY_ID_ANHUI]) {
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
        highview.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryid isEqualToString:@"011"]) {
        HappyTenViewController *happy = [[HappyTenViewController alloc] init];
        happy.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:happy animated:YES];
        [happy release];
    }
    else if ([lotteryid isEqualToString:@"006"]) {
        ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
        shishi.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:shishi animated:YES];
        [shishi release];
    }
    else if ([lotteryid isEqualToString:@"014"]) {
        CQShiShiCaiViewController *shishi = [[CQShiShiCaiViewController alloc] init];
        shishi.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:shishi animated:YES];
        [shishi release];
    }
    else if ([lotteryid isEqualToString:@"001"]) {
        GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:shuang animated:YES];
        [shuang release];
    }
    else if ([lotteryid isEqualToString:@"002"]) {
        FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
        fucai.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:fucai animated:YES];
        [fucai release];
    }
    else  if ([lotteryid isEqualToString:@"113"]) {
        DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:dale animated:YES];
        [dale release];
    }
    else if ([lotteryid isEqualToString:@"003"]) {
        QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:con animated:YES];
        [con release];
    }
    else if ([lotteryid isEqualToString:@"109"]) {
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    else if([lotteryid isEqualToString:@"110"]){
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    
    else if ([lotteryid isEqualToString:@"108"]) {
        //排列3
        Pai3ViewController *pai = [[Pai3ViewController alloc] init];
        pai.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:pai animated:YES];
        [pai release];
    }
    else if ([lotteryid isEqualToString:@"122"]) {
        KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
        puke.modetype = modetype;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:puke animated:YES];
        [puke release];
        
    }
    else if ([lotteryid isEqualToString:@"201"]) {
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
        gcjc.lunboBool = YES;

        if([wanfa isEqualToString:@"01"]){
            
            gcjc.matchenum = matchEnumShengPingFuGuoGuan;
        }
        else if([wanfa isEqualToString:@"10"]){
            
            gcjc.matchenum = matchEnumHunHeGuoGuan;
        }
        else if([wanfa isEqualToString:@"05"]){
            
            gcjc.matchenum = matchEnumBiFenGuoguan;
        }
        else if([wanfa isEqualToString:@"03"]){
            
            gcjc.matchenum = matchenumZongJinQiuShu;
        }
        else if([wanfa isEqualToString:@"04"]){
            
            gcjc.matchenum = matchenumBanQuanChang;
        }
        else if([wanfa isEqualToString:@"04"]){
            
            gcjc.matchenum = matchenumBanQuanChang;
        }
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:gcjc animated:YES];
        [gcjc release];
    }
    else if ([lotteryid isEqualToString:@"202"]) {
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
        if([wanfa isEqualToString:@"01"]){
            
            gcjc.matchenum = matchEnumBigHunHeGuoGan;
        }
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:gcjc animated:YES];
        [gcjc release];
    }
    else if([lotteryid isEqualToString:@"300"]) {
        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
        bet.bettingstype = bettingStypeShisichang;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:bet animated:YES];
        [bet release];
    }else if([lotteryid isEqualToString:@"301"]){
        GCBettingViewController* bet = [[GCBettingViewController alloc] init];
        bet.bettingstype = bettingStypeRenjiu;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:bet animated:YES];
        [bet release];
    }else if([lotteryid isEqualToString:@"400"]){
        GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];

        if([wanfa isEqualToString:@"01"]){
            
            bjdanchang.matchType = MatchRangQiuShengPingFu;
        }
        else if([wanfa isEqualToString:@"02"]){
            
            bjdanchang.matchType = MatchShangXiaDanShuang;
        }
        else if([wanfa isEqualToString:@"03"]){
            bjdanchang.matchType = MatchJinQiuShu;
            
        }
        else if ([wanfa isEqualToString:@"04"]){
            
            bjdanchang.matchType = matchBanQuanChang;
        }
        else if ([wanfa isEqualToString:@"05"]){
            bjdanchang.matchType = MatchBiFen;
            
        }
        else if ([wanfa isEqualToString:@"06"]){
            bjdanchang.matchType = MatchShengFuGuoGan;
            
        }
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:bjdanchang animated:YES];
        [bjdanchang release];
        
    }else if([lotteryid isEqualToString:@"200"]){
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
        gcjc.lanqiubool = YES;

        if([wanfa isEqualToString:@"06"]){
            
            gcjc.matchenum =matchEnumShengFuGuoguan;
        }
        else if([wanfa isEqualToString:@"07"]){
            gcjc.matchenum =matchEnumRangFenShengFuGuoguan;
            
        }
        else if([wanfa isEqualToString:@"08"]){
            gcjc.matchenum =matchEnumShengFenChaGuoguan;
            
        }
        else if([wanfa isEqualToString:@"09"]){
            gcjc.matchenum =matchEnumDaXiaFenGuoguan;
            
        }
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:gcjc animated:YES];
        [gcjc release];
    }
    else if([lotteryid isEqualToString:@"203"]){
        GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
        gcjc.lanqiubool = YES;
        gcjc.matchenum =MatchEnumLanqiuHunTou;

        if([wanfa isEqualToString:@"01"]){
            
            gcjc.matchenum =MatchEnumLanqiuHunTou;
        }
        
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav pushViewController:gcjc animated:YES];
        [gcjc release];
    }

}

- (void)getRepair{
    return;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"iosRepair"];
    if (![[dic valueForKey:@"keyVersion"] isEqualToString:newVersionKey]) {
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSString *plistPath = [path stringByAppendingPathComponent:@"Repair.zip"];
        NSString *sourcePath = [path stringByAppendingPathComponent:@"Repair"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
            [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:sourcePath]){
            [[NSFileManager defaultManager] removeItemAtPath:sourcePath error:nil];
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"iosRepair"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    ASIHTTPRequest *request2 = [ ASIHTTPRequest requestWithURL:[NetURL getrepairPatch]];
    [request2 setTimeOutSeconds:20.0];
    [request2 setDidFinishSelector:@selector(reqRepairFinished:)];
    [request2 setDidFailSelector:@selector(reqRepairFail:)];
    [request2 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request2 setDelegate:self];
    [request2 startAsynchronous];
}

- (void)reqRepairFail:(ASIHTTPRequest *)request{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"iosRepair"];
    if ([[dic valueForKey:@"isDownLoad"] isEqualToString:@"1"] && [[dic valueForKey:@"keyVersion"] isEqualToString:newVersionKey]) {//本地已经下载，且版本号和本地版本号相同；
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSString *sourcePath = [path stringByAppendingPathComponent:@"Repair/demo.js"];
        [self JPEngineevaluteByPath:sourcePath];
    }
}

- (void)reqRepairFinished:(ASIHTTPRequest *)request{
    NSDictionary *dic2 = [request.responseString JSONValue];
    if ([dic2 count] == 0) {
        return;
    }
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"iosRepair"];
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *plistPath = [path stringByAppendingPathComponent:@"Repair.zip"];
    if (dic) {
        if ([[dic valueForKey:@"isDownLoad"] isEqualToString:@"1"] && [[dic valueForKey:@"RepairVertion"] floatValue] == [[dic2 valueForKey:@"version"] floatValue]) {//本地已经下载，且版本号和本地版本号相同；
            NSString *sourcePath = [path stringByAppendingPathComponent:@"Repair/demo.js"];
            [self JPEngineevaluteByPath:sourcePath];
        }
        else {
            if ([[dic2 valueForKey:@"downLoad_url"] length]) {
                NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [newDic setValue:@"0" forKey:@"isDownLoad"];
                [newDic setValue:[dic2 valueForKey:@"version"] forKey:@"RepairVertion"];
                [newDic setValue:newVersionKey forKey:@"keyVersion"];
                [[NSUserDefaults standardUserDefaults] setValue:newDic forKey:@"iosRepair"];
                ASIHTTPRequest *request2 = [ ASIHTTPRequest requestWithURL :[NSURL URLWithString:[dic2 valueForKey:@"downLoad_url"]]];
                [request2 setDownloadDestinationPath :plistPath];
                [request2 setDelegate:self];
                [request2 setDownloadProgressDelegate : self ];
                [request2 setDidFinishSelector:@selector(reqRepairZipFinished:)];
                [request2 startSynchronous ];
            }
        }
    }
    else {
        if ([[dic2 valueForKey:@"downLoad_url"] length]) {
            NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [newDic setValue:@"0" forKey:@"isDownLoad"];
            [newDic setValue:[dic2 valueForKey:@"version"] forKey:@"RepairVertion"];
            [newDic setValue:newVersionKey forKey:@"keyVersion"];
            [[NSUserDefaults standardUserDefaults] setValue:newDic forKey:@"iosRepair"];
            ASIHTTPRequest *request2 = [ ASIHTTPRequest requestWithURL :[NSURL URLWithString:[dic2 valueForKey:@"downLoad_url"]]];
            [request2 setDownloadDestinationPath :plistPath];
            [request2 setDelegate:self];
            [request2 setDownloadProgressDelegate : self ];
            [request2 setDidFinishSelector:@selector(reqRepairZipFinished:)];
            [request2 startSynchronous ];
        }
    }
}

- (void)JPEngineevaluteByPath:(NSString *)sourcePath{
    
//    [JPEngine startEngine];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    if (script && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [JPEngine evaluateScript:script];
//    }
    [self dosometh];
}

- (void)dosometh {
    
}

- (void)reqRepairZipFinished:(ASIHTTPRequest *)request{//下载下代码修复
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"iosRepair"]];
    [newDic setValue:@"1" forKey:@"isDownLoad"];
    [[NSUserDefaults standardUserDefaults] setValue:newDic forKey:@"iosRepair"];
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path= ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *plistPath = [path stringByAppendingPathComponent:@"Repair.zip"];
    NSString *sourcePath = [path stringByAppendingPathComponent:@"Repair"];
    [self zipUncompressFuncFrom:plistPath ToPath:sourcePath];
    sourcePath = [sourcePath stringByAppendingString:@"/demo.js"];
    [self JPEngineevaluteByPath:sourcePath];
}

- (void)zipUncompressFuncFrom:(NSString *)l_zipfile ToPath:(NSString *)unzipto{//解压缩
    
    ZipArchive* zip = [[ZipArchive alloc] init];

    if( [zip UnzipOpenFile:l_zipfile] )
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
        }
        [zip UnzipCloseFile];
    }
    [zip release];
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
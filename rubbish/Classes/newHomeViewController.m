//
//  newHomeViewController.m
//  caibo
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "newHomeViewController.h"
#import "PKMatchViewController.h"
#import "HomeViewController.h"
#import "SachetViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "UserInfo.h"
#import "Statement.h"
#import "DataBase.h"
#import "NewAroundViewController.h"
#import "CPSetViewController.h"
#import "TouZhuShowView.h"

#import "AboutOurViewController.h"
#import "GouCaiViewController.h"
#import "GC_HttpService.h"
#import "LastLotteryViewController.h"
#import "CustomMoviePlayerViewController.h"
#import "CheckNewMsg.h"
#import "GC_BaFangShiPingViewController.h"
#import "GC_HttpService.h"
#import "GC_VersionCheck.h"
#import "GouCaiHomeViewController.h"
#import "PreJiaoDianTabBarController.h"
#import "RegisterViewController.h"
#import "ProvingViewCotroller.h"
#import "huoYueInfoCell.h"
#import "huoYueZuiHouCell.h"
#import "houYueInfoData.h"
#import "NewsViewController.h"
#import "MessageViewController.h"
#import "MyProfileViewController.h"
#import "MobClick.h"
#import "scoreLiveTelecastViewController.h"
#import "LiveScoreViewController.h"
#import "singletonData.h"
#import "n115yilouViewController.h"//假
#import "GCHeMaiInfoViewController.h"
#import "RankingListViewController.h"
#import "EveryDayViewController.h"
#import "CPselfServiceViewController.h"
#import "CPSlefHelpData.h"
#import "HRSliderViewController.h"
#import "MLNavigationController.h"
#import "JCClassroomViewController.h"
#import "JiangLiHuoDongViewController.h"
#import "GCJCBetViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "MyWebViewController.h"
#import "SendMicroblogViewController.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
#import "YLAlertView.h"
#import "HorseRaceViewController.h"

#define JIANJU 5

#define BUTTON_WIDTH_BIG 147.5
#define BUTTON_HEIGHT_BIG 143.5

#define BUTTON_WIDTH_SMALL 71.5
#define BUTTON_HEIGHT_SMALL 73.5

#define ZHUCE_HEIGHT 0

#define ZOOM 1

#define BGBUTTON_FRAME_YIWANSHAN CGRectMake(0, 0,mainScrollView.frame.size.width, ORIGIN_Y(lunxianview) + 10)
#define BGBUTTON_FRAME_YIWANSHAN_IP5 CGRectMake(0, 0,mainScrollView.frame.size.width, ORIGIN_Y(lunxianview) + 10)
#define BGBUTTON_FRAME_WEIZHUCE CGRectMake(0, 0,mainScrollView.frame.size.width, ORIGIN_Y(lunxianview) + 10)

#define CONTENTSIZE_YIWANSHAN CGSizeMake(0, lunxianview.frame.origin.y - ZHUCE_HEIGHT + isIOS7Pianyi)
#define CONTENTSIZE_WEIZHUCE CGSizeMake(0, ORIGIN_Y(lunxianview) + 10 + isIOS7Pianyi)
#define CONTENTSIZE_WEIWANSHAN CGSizeMake(0, lunxianview.frame.origin.y + isIOS7Pianyi)

@implementation newHomeViewController
//@synthesize delegate;
@synthesize httpRequest;
@synthesize chekrequest;
@synthesize versionCheck;
@synthesize huoyuerequest;
@synthesize oneBool;
@synthesize urlVersion;
@synthesize requestUserInfo;
@synthesize passWord;

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//#if !defined isFuTiKuai && !defined isHaoLeCai
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWCDate) name:@"BecomeActive" object:nil];
//#endif
        
        if (IS_IPHONE_5) {
            zoom = 1;
        }else{
            zoom = ZOOM;
        }
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

#pragma mark - 背景点击方法
- (void)pressButtonBack:(UIButton *)sender{
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
    
        sender.tag = 1;
    }
    
    if (sender.tag == 0) {
         shishiview.hidden = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationDelegate:self];
        
        eventsButton.alpha = 0;
//        soccerButton.alpha = 0;
//        shuangSeButton.alpha = 0;
        interaction.alpha = 0;
        set.alpha = 0;
//        zhucezlBtn.alpha = 0;
        lottery.alpha = 0;
        frutti.alpha = 0;
        buy.alpha = 0;
        seed.alpha = 0;
//        bfsp.alpha = 0;
        pkbut.alpha = 0;
//        about.alpha = 0;
        lunxianview.alpha = 0;
        [UIView commitAnimations];
        sender.tag = 1;
    }else{
        eventsButton.alpha = 1;
//        soccerButton.alpha = 1;
//        shuangSeButton.alpha = 1;
        shishiview.hidden = YES;
        interaction.alpha = 1;
        set.alpha = 1;
//        zhucezlBtn.alpha = 1;
        lottery.alpha = 1;
        frutti.alpha = 1;
        buy.alpha = 1;
        seed.alpha = 1;
//        bfsp.alpha = 1;
        pkbut.alpha = 1;
//        about.alpha = 1;
        lunxianview.alpha = 1;
        sender.tag = 0;
    }
    
    
    
}
#pragma mark - 轮显
- (void)lunXianLabel{
         caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
   
    if (appDelegate.hylistcont < [appDelegate.hylistarray count]) {
        if (huoYueLabelOne.alpha == 1) {
            
            huoYueLabelTwo.alpha = 1;
            
            if([appDelegate.hylistarray count] - 1 >= appDelegate.hylistcont){
                houYueInfoDataResult * result = [appDelegate.hylistarray objectAtIndex:appDelegate.hylistcont];
                huoYueLabelTwo.text = [NSString stringWithFormat:@"%@   %@   %@   %@", result.jiaoyitime,result.username, result.jiaoyitype,result.shejimoney];
            }else{
                huoYueLabelTwo.text = @"";
            
            }
            
            
            
            
            
            huoYueLabelTwo.frame = CGRectMake(0, 18, 320, 0);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            [UIView setAnimationDelegate:self];
            huoYueLabelOne.alpha = 0;
            huoYueLabelOne.frame = CGRectMake(0, -5, 320, 18);
            huoYueLabelTwo.frame = CGRectMake(0, 0, 320, 18);
            [UIView commitAnimations];
            
        }else{
            
            huoYueLabelOne.alpha = 1;
            houYueInfoDataResult * result = [appDelegate.hylistarray objectAtIndex:appDelegate.hylistcont];
            
            
            
            huoYueLabelOne.text = [NSString stringWithFormat:@"%@   %@   %@   %@", result.jiaoyitime,result.username, result.jiaoyitype,result.shejimoney];
            
            huoYueLabelOne.frame = CGRectMake(0, 18, 320, 0);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            [UIView setAnimationDelegate:self];
            huoYueLabelTwo.alpha = 0;
            huoYueLabelTwo.frame = CGRectMake(0, -5, 320, 18);
            huoYueLabelOne.frame = CGRectMake(0, 0, 320, 18);
            [UIView commitAnimations];
            
        }
        [mytableviw reloadData];
        appDelegate.hylistcont += 1;
        
        //暂时放这 
        if (appDelegate.hylistcont > 16) {
            mytableviw.contentOffset = CGPointMake(mytableviw.contentOffset.x, mytableviw.contentOffset.y+15);//改变tableview的位置
        } 

    }else{
        if (luntime) {
             [luntime invalidate];
            luntime = nil;
        }
       
        huoYueLabelOne.text = @"";
        huoYueLabelTwo.text = @"";
    }
       
}

//轮显的函数
- (void)lunXianViewFunction{

    lunxianview = [[UIView alloc] init];

//    float a = ((self.mainView.frame.size.height - isIOS7Pianyi - BUTTON_HEIGHT_BIG * zoom * 3  - JIANJU * zoom * 2)/2 - 18)/2;
//    if (a < 0) {
//        a = 0;
//    }
    lunxianview.backgroundColor = [UIColor clearColor];
    UIImageView * lunimage = [[UIImageView alloc] initWithFrame:CGRectMake(22, 0, 274, 18)];
//    lunimage.image = UIImageGetImageFromName(@"huoyuetiao.png");
    [lunxianview addSubview:lunimage];
    [lunimage release];
    
    huoYueLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 18)];
    huoYueLabelOne.backgroundColor = [UIColor clearColor];
    huoYueLabelOne.textAlignment = NSTextAlignmentCenter;
    huoYueLabelOne.font = [UIFont systemFontOfSize:12];
    huoYueLabelOne.textColor = [UIColor whiteColor];
    
    huoYueLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, 320, 18)];
    huoYueLabelTwo.backgroundColor = [UIColor clearColor];
    huoYueLabelTwo.textAlignment = NSTextAlignmentCenter;
    huoYueLabelTwo.font = [UIFont systemFontOfSize:12];
    huoYueLabelTwo.textColor = [UIColor whiteColor];
    
    
    [lunxianview addSubview:huoYueLabelOne];
    [lunxianview addSubview:huoYueLabelTwo];
    
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        lunxianview.hidden = YES;
    }else{
            lunxianview.hidden = NO;
    }
    
   
}

//间隔时间的判断
- (void)jiangetimehanshu{//2012-08-13 03:19:40 +0000
   caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.jiangetime){
        NSTimeInterval timeint = [appDelegate.jiangetime timeIntervalSinceNow];
        NSLog(@"jiange  = %d", (int)timeint);
        NSInteger timeingt = (int)timeint;
        if (timeingt <= -1800) { //在这调间隔的时间
            
            Info *info = [Info getInstance];
            if (![info.userId intValue]) {
                [self huoYueHttp];
            }
            
            NSLog(@"从新获取  qing qiu ========= ");
        }
        
        
    }else{
        appDelegate.jiangetime = [NSDate date];
    }
   
    
}

//单击方法
-(void)handelSingleTap:(UIButton*)sender{

    eventsButton.alpha = 1;
//    soccerButton.alpha = 1;
//    shuangSeButton.alpha = 1;
    shishiview.hidden = YES;
    interaction.alpha = 1;
    set.alpha = 1;
//    zhucezlBtn.alpha = 1;
    lottery.alpha = 1;
    frutti.alpha = 1;
    buy.alpha = 1;
    seed.alpha = 1;
//    bfsp.alpha = 1;
    pkbut.alpha = 1;
//    about.alpha = 1;
    lunxianview.alpha = 1;
    bgbutton.tag = 0;
//    bgbutton.hidden = NO;
}
#pragma mark - 点击开始 获取按钮
- (void)pressHuoQuORTingZhi:(UIButton *)sender{
    if (sender.tag == 0) {
        sender.tag = 1;
        lunxianview.hidden = YES;
        if (luntime) {
            [luntime invalidate];
            luntime = nil;
        }
        
     
        [sender setImage:UIImageGetImageFromName(@"huoqubutton.png") forState:UIControlStateNormal];
        
        
       
       
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"huoyuebutton"];
        
    }else{
            lunxianview.hidden = NO;
        [self jiangetimehanshu];
       
        
        sender.tag = 0;
        [sender setImage:UIImageGetImageFromName(@"tingzhibutton.png") forState:UIControlStateNormal];
         caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
      
        if ([appDelegate.hylistarray count] == 0) {
            Info *info = [Info getInstance];
            if (![info.userId intValue]) {
                [self huoYueHttp];
            }
        }
        
        
         luntime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(lunXianLabel) userInfo:nil repeats:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huoyuebutton"];
        
        
    }
}

- (void)huoyueFinished:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
		houYueInfoData * huoyuedata = [[houYueInfoData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.hylistarray removeAllObjects];
        appDelegate.hylistarray = huoyuedata.listData;
//        //ceshi
//        [appDelegate.hylistarray removeAllObjects];
//        for (int i = 0; i < 10; i++) {
//            houYueInfoDataResult * result = [[houYueInfoDataResult alloc] init];
//            result.jiaoyitype = @"1";
//            result.username = @"2";
//            result.shejimoney = @"3";
//            result.jiaoyitime = @"4 5";
//            [appDelegate.hylistarray addObject:result];
//            [result release];
//        }
        
        
        
        //   在网络请求完了之后写
//         caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//        huoYueLabelOne.text = [NSString stringWithFormat:@"%d", appDelegate.hylistcont];
//        huoYueLabelTwo.text = [NSString stringWithFormat:@"%d", appDelegate.hylistcont+1];
//        appDelegate.hylistcont = appDelegate.hylistcont+1;
        appDelegate.hylistcont = 0;
        appDelegate.jiangetime = [NSDate date];
        [self lunXianLabel];
        
        [huoyuedata release];
    }
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
         [self performSelector:@selector(huoYueHttp) withObject:nil afterDelay:1800];//调时间
    }

  
}
//活跃http的请求
- (void)huoYueHttp{
    NSMutableData *postData = [[GC_HttpService sharedInstance] huoYueJieMianInfo];
    
    [huoyuerequest clearDelegatesAndCancel];
    self.huoyuerequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    
    [huoyuerequest setRequestMethod:@"POST"];
    [huoyuerequest addCommHeaders];
    [huoyuerequest setPostBody:postData];
    [huoyuerequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [huoyuerequest setDelegate:self];
    [huoyuerequest setDidFinishSelector:@selector(huoyueFinished:)];
    [huoyuerequest startAsynchronous];
}

//实时信息界面
- (void)shiShiXinXi{
   
  //  [self huoYueHttp];
    
    shishiview = [[UIView alloc] initWithFrame:self.mainView.bounds];
    shishiview.backgroundColor = [UIColor clearColor];
    shishiview.hidden = YES;
    
    UIButton * shibut = [UIButton buttonWithType:UIButtonTypeCustom];
    shibut.frame = self.mainView.bounds;
    [shibut addTarget:self action:@selector(handelSingleTap:) forControlEvents:UIControlEventTouchUpInside];
    [shishiview addSubview:shibut];
    
    UILabel * titlexian = [[UILabel alloc] initWithFrame:CGRectMake(46, 50, 170, 20)];
    titlexian.textColor = [UIColor whiteColor];
    titlexian.font = [UIFont systemFontOfSize:14];
    titlexian.textAlignment = NSTextAlignmentCenter;
    titlexian.backgroundColor = [UIColor clearColor];
    titlexian.text = @"实时信息会耗费一定流量";
    [shishiview addSubview:titlexian];
    [titlexian release];
    
    UIImageView * bgshishi = [[UIImageView alloc] initWithFrame:CGRectMake(5, ORIGIN_Y(titlexian) + 15, 310, 268.5)];
    bgshishi.backgroundColor = [UIColor clearColor];
    bgshishi.image = [UIImageGetImageFromName(@"bgshishiimage.png") stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [shishiview addSubview:bgshishi];
    [bgshishi release];
    
    mytableviw = [[UITableView alloc] initWithFrame:CGRectMake(bgshishi.frame.origin.x + 10, bgshishi.frame.origin.y + 11, bgshishi.frame.size.width - 20, bgshishi.frame.size.height - 20) style:UITableViewStylePlain];
    mytableviw.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    mytableviw.backgroundColor = [UIColor clearColor];
    [mytableviw setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mytableviw.delegate = self;
    mytableviw.dataSource = self;
    [shishiview addSubview:mytableviw];
    
    huoqu = [[UIButton alloc] init];
    huoqu.userInteractionEnabled = YES;
    huoqu.frame = CGRectMake(ORIGIN_X(titlexian), titlexian.frame.origin.y, 58.5, 20);
    [huoqu setImage:UIImageGetImageFromName(@"tingzhibutton.png") forState:UIControlStateNormal];
    [huoqu addTarget:self action:@selector(pressHuoQuORTingZhi:) forControlEvents:UIControlEventTouchUpInside];
    [shishiview addSubview:huoqu];
    
    [self.mainView addSubview:shishiview];
}
#pragma mark - tableview
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 15;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel * tabla = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 10)];
//    tabla.backgroundColor = [UIColor clearColor];
//    tabla.font = [UIFont systemFontOfSize:11];
//    tabla.textAlignment = NSTextAlignmentCenter;
//    tabla.textColor = [UIColor whiteColor];
//    tabla.text = @"____日期__时间__用户名_____操作____________钱数__ ";
//    return [tabla autorelease];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"aaa = %ld", (long)appDelegate.hylistcont);
   
    if ([appDelegate.hylistarray count] > appDelegate.hylistcont) {
        return  appDelegate.hylistcont + 2;
    }
    NSLog(@"app = %d", (int)appDelegate.hylistcont +1);
    if ([appDelegate.hylistarray count] == 0) {
        return appDelegate.hylistcont+1;

    }
    return 0;
}

int ccccc= 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"li = %ld, ind = %ld", (long)appDelegate.hylistcont, (long)indexPath.row);
    if (indexPath.row  == appDelegate.hylistcont) {
        NSString * cellid = @"cellidd";
        huoYueZuiHouCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[huoYueZuiHouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        }
       
        return cell;
    }else{
        NSString * cellid = @"cellid";
        huoYueInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[huoYueInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        }
         caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([appDelegate.hylistarray count] > indexPath.row) {
             cell.infodata = [appDelegate.hylistarray objectAtIndex:indexPath.row];
        }
       
        return cell;
    }
    return nil;
}

- (void)baocunxinxi{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"huoyuebutton"] intValue] == 0) {
 
        if ([[[Info getInstance] userId] intValue]) {
            lunxianview.hidden = YES;
        }else{
                lunxianview.hidden = NO;
        }
        
       
        //  [self jiangetimehanshu];
        if(luntime){
            [luntime invalidate];
            luntime = nil;
        }
        luntime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(lunXianLabel) userInfo:nil repeats:YES];
        
        huoqu.tag = 0;
        [huoqu setImage:UIImageGetImageFromName(@"tingzhibutton.png") forState:UIControlStateNormal];
        
    }else{
        if(luntime){
            [luntime invalidate];
            luntime = nil;
        }
              
        lunxianview.hidden = YES;
        huoqu.tag = 1;
       // [luntime invalidate];
        
        [huoqu setImage:UIImageGetImageFromName(@"huoqubutton.png") forState:UIControlStateNormal];
        
        
    }

}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//   
//    mytableviw.contentOffset =  CGPointMake(mytableviw.contentOffset.x, mytableviw.contentOffset.y+15);
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)yanShiFunc{
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (kfcount > 0) {
         caiboappdelegate.keFuButton.show = YES;
        caiboappdelegate.keFuButton.markbool = YES;
        caiboappdelegate.keFuButton.newkfbool = YES;
    }else{
         caiboappdelegate.keFuButton.show = NO;
        caiboappdelegate.keFuButton.markbool = NO;
        caiboappdelegate.keFuButton.newkfbool = NO;
    }
   
    
    //[caiboappdelegate.keFuButton beginShow];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        lunxianview.hidden = YES;
    }else{
            lunxianview.hidden = NO;
    }
    
}

- (void)checkUpDateVersion{

    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    if(app.upDataCheck == 1 || app.upDataCheck == 2){
//            [about setImage:UIImageGetImageFromName(@"about1.png") forState:UIControlStateNormal];
//            [about setImage:UIImageGetImageFromName(@"about2.png") forState:UIControlStateHighlighted];
    }else{
//            [about setImage:UIImageGetImageFromName(@"about4.png") forState:UIControlStateNormal];
//            [about setImage:UIImageGetImageFromName(@"about3.png") forState:UIControlStateHighlighted];
    }
}

#pragma mark - viewdidload
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUpDateVersion) name:@"checkUpDateVersion" object:nil];
    
    [MobClick event:@"event_main"];
    [self setIsRealNavigationBarHidden:YES];
    con = 6;
    counhaoyou = 0;
//    self.mainView.frame = CGRectMake(0, 0, 1024, 748);
#if defined isHaoLeCai || defined isFuTiKuai
    self.mainView.backgroundColor = [UIColor colorWithRed:8/255.0 green:54/255.0 blue:85/255.0 alpha:1];
#else
    imageviewbg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    imageviewbg.image = UIImageGetImageFromName(@"NewhomeBG.jpg");
    [self.mainView addSubview:imageviewbg];
    [imageviewbg release];
    self.view.backgroundColor = [UIColor colorWithPatternImage:imageviewbg.image];
#endif

    
    //[self baocunxinxi];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"huoyuebutton"] intValue] == 0) {
        
        Info *info = [Info getInstance];
        if (![info.userId intValue]) {
            [self huoYueHttp];
        }
    }
    
    //
    ///////////////////////////////////////////////////////
    
    eventsButton = [[UIButton alloc] init];
    [eventsButton setImage:UIImageGetImageFromName(@"NewHome_Events.png") forState:UIControlStateNormal];
    [eventsButton setImage:UIImageGetImageFromName(@"NewHome_Events_1.png") forState:UIControlStateHighlighted];
    [eventsButton setImage:UIImageGetImageFromName(@"NewHome_Events_1.png") forState:UIControlStateSelected];

    [eventsButton addTarget:self action:@selector(pressEventsButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    soccerButton = [[UIButton alloc] init];
//    [soccerButton setImage:UIImageGetImageFromName(@"NewHome_Soccer.png") forState:UIControlStateNormal];
//    [soccerButton setImage:UIImageGetImageFromName(@"NewHome_Soccer_1.png") forState:UIControlStateHighlighted];
//    [soccerButton setImage:UIImageGetImageFromName(@"NewHome_Soccer_1.png") forState:UIControlStateSelected];
//
//    [soccerButton addTarget:self action:@selector(pressSoccerButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    shuangSeButton = [[UIButton alloc] init];
//    [shuangSeButton setImage:UIImageGetImageFromName(@"NewHome_ShuangSe.png") forState:UIControlStateNormal];
//    [shuangSeButton setImage:UIImageGetImageFromName(@"NewHome_ShuangSe_1.png") forState:UIControlStateHighlighted];
//    [shuangSeButton setImage:UIImageGetImageFromName(@"NewHome_ShuangSe_1.png") forState:UIControlStateSelected];
//
//    [shuangSeButton addTarget:self action:@selector(pressShuangSeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //开奖按钮
    lottery = [[UIButton alloc] init];
    [lottery setImage:UIImageGetImageFromName(@"cpthree_kj.png") forState:UIControlStateNormal];
    [lottery setImage:UIImageGetImageFromName(@"cpthree_kj_0.png") forState: UIControlStateSelected];
    [lottery setImage:UIImageGetImageFromName(@"cpthree_kj_0.png") forState: UIControlStateHighlighted];
    [lottery addTarget:self action:@selector(pressLottery:) forControlEvents:UIControlEventTouchUpInside];
    
    //攻略按钮
    frutti = [[UIButton alloc] init];
    [frutti setImage:UIImageGetImageFromName(@"cpthree_jn.png") forState:UIControlStateNormal];
    [frutti setImage:UIImageGetImageFromName(@"cpthree_jn_0.png") forState:UIControlStateHighlighted];
    [frutti setImage:UIImageGetImageFromName(@"cpthree_jn_0.png") forState:UIControlStateSelected];

    [frutti addTarget:self action:@selector(pressfrutti:) forControlEvents:UIControlEventTouchUpInside];
    
    //购买彩票按钮
    buy = [[UIButton alloc] init];
    [buy setImage:UIImageGetImageFromName(@"cpthree_gc.png") forState:UIControlStateNormal];
    [buy setImage:UIImageGetImageFromName(@"cpthree_gc_0.png") forState:UIControlStateHighlighted];
    [buy setImage:UIImageGetImageFromName(@"cpthree_gc_0.png") forState:UIControlStateSelected];

	[buy addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
    
    //微博互动按钮
    interaction = [[UIButton alloc] init];
    
    
    //  [interaction setTitle:@"焦点互动" forState:UIControlStateNormal];
    [interaction setImage:UIImageGetImageFromName(@"cpthree_jd.png") forState:UIControlStateNormal];
    [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateHighlighted];
    [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateSelected];

    [interaction addTarget:self action:@selector(pressInteraction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //焦点互动上的new
    //    jdnewImage = [[UIImageView alloc] initWithFrame:CGRectMake(79, 0, 49, 49)];
    //    jdnewImage.image = UIImageGetImageFromName(@"GC_NEW.png");
    //    jdnewImage.backgroundColor = [UIColor clearColor];
    //    jdnewImage.hidden = YES;
    //    [interaction addSubview:jdnewImage];
    
    //比分直播按钮
    seed = [[UIButton alloc] init];
    
    //[seed setTitle:@"比分直播" forState:UIControlStateNormal];
    [seed setImage:UIImageGetImageFromName(@"cpthree_zb.png") forState:UIControlStateNormal];
    [seed setImage:UIImageGetImageFromName(@"cpthree_zb_0.png") forState:UIControlStateHighlighted];
    [seed setImage:UIImageGetImageFromName(@"cpthree_zb_0.png") forState:UIControlStateSelected];

    [seed addTarget:self action:@selector(pressSeedButton:) forControlEvents:UIControlEventTouchUpInside];
    //pk赛按钮
    //    UIButton * pkbut = [UIButton buttonWithType:UIButtonTypeCustom];
    //    pkbut.frame = CGRectMake(161, 299, 128, 60);
    //   // [pkbut setTitle:@"pk赛" forState:UIControlStateNormal];
    //    [pkbut setImage:UIImageGetImageFromName(@"cpthree_pk.png") forState:UIControlStateNormal];
    //    [pkbut setImage:UIImageGetImageFromName(@"cpthree_pk_0.png") forState:UIControlStateHighlighted];
    //
    //    [pkbut addTarget:self action:@selector(presspkbut:) forControlEvents:UIControlEventTouchUpInside];
    
    //八方视频
    
//    bfsp = [[UIButton alloc] init];
    //pk赛按钮
    pkbut = [[UIButton alloc] init];
    
//#ifdef isCaiPiao365ForIphone5
//    [bfsp setImage:UIImageGetImageFromName(@"shipinzhibo.png") forState:UIControlStateNormal];
//    [bfsp setImage:UIImageGetImageFromName(@"shipinzhibo_1.png") forState:UIControlStateHighlighted];
//    [bfsp addTarget:self action:@selector(pressbfsp:) forControlEvents:UIControlEventTouchUpInside];
//#else
//    [bfsp setImage:UIImageGetImageFromName(@"cpthree_bfsp.png") forState:UIControlStateNormal];
//    [bfsp setImage:UIImageGetImageFromName(@"cpthree_bfsp_0.png") forState:UIControlStateHighlighted];
//    [bfsp setImage:UIImageGetImageFromName(@"cpthree_bfsp_0.png") forState:UIControlStateSelected];
//
//    [bfsp addTarget:self action:@selector(pressbfsp:) forControlEvents:UIControlEventTouchUpInside];
    
    [pkbut setImage:UIImageGetImageFromName(@"cpthree_pk.png") forState:UIControlStateNormal];
    [pkbut setImage:UIImageGetImageFromName(@"cpthree_pk_0.png") forState:UIControlStateHighlighted];
    [pkbut setImage:UIImageGetImageFromName(@"cpthree_pk_0.png") forState:UIControlStateSelected];

    [pkbut addTarget:self action:@selector(presspkbut:) forControlEvents:UIControlEventTouchUpInside];
//#endif
    
    
    
    
    
    
    
    //我的彩票
    set = [[UIButton alloc] init];
    
    //[set setTitle:@"设置" forState:UIControlStateNormal];
    [set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
    [set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
    [set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateSelected];

    [set addTarget:self action:@selector(pressSetButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置
//    about = [[UIButton alloc] init];
//    
//	[about addTarget:self action:@selector(goAbout:) forControlEvents:UIControlEventTouchUpInside];
//    //  [about setTitle:@"关于我们" forState:UIControlStateNormal];
//    [about setImage:UIImageGetImageFromName(@"about4.png") forState:UIControlStateNormal];
//    [about setImage:UIImageGetImageFromName(@"about3.png") forState:UIControlStateHighlighted];
//    [about setImage:UIImageGetImageFromName(@"about3.png") forState:UIControlStateSelected];

    
    
    //    User *lastUser = [User getLastUser];
    //	if ([lastUser.login_name length] && [lastUser.password length]) {
    //		ASIHTTPRequest *reqLogin = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:lastUser.login_name passWord:lastUser.password]];
    //        [reqLogin setTimeOutSeconds:20.0];
    //		[reqLogin setDidFinishSelector:@selector(recivedFinish:)];
    //		[reqLogin setDidFailSelector:@selector(recivedFail:)];
    //        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
    //        [reqLogin setDelegate:self];
    //        [reqLogin startAsynchronous];
    //	}
    
    if (IS_IPHONE_5) {
#ifdef isHaoLeCai
        lottery.frame = CGRectMake(5.5, 50, 151.5, 146);
        frutti.frame = CGRectMake(162.5, lottery.frame.origin.y, 151.5, 146);
        buy.frame = CGRectMake(5.5, ORIGIN_Y(lottery) + 5.5, 151.5, 146);
        interaction.frame = CGRectMake(162.5, buy.frame.origin.y, 151.5, 146);
        seed.frame = CGRectMake(5.5, ORIGIN_Y(buy) + 5.5, 151.5, 146);
        bfsp.frame = CGRectMake(162.5, ORIGIN_Y(interaction) + 5.5, 86, 70);
        pkbut.frame = CGRectMake(254, bfsp.frame.origin.y, 60, 70);
        set.frame = CGRectMake(162.5, ORIGIN_Y(bfsp) + 5.5, 86, 70);
        about.frame = CGRectMake(254, set.frame.origin.y, 60, 70);
#elif defined isFuTiKuai
        lottery.frame = CGRectMake(5.5,45, 151.5, 146);
        frutti.frame = CGRectMake(162.5, lottery.frame.origin.y, 151.5, 146);
        buy.frame = CGRectMake(5.5, ORIGIN_Y(lottery) + 5.5, 151.5, 146);
        interaction.frame = CGRectMake(162.5, buy.frame.origin.y, 151.5, 146);
        seed.frame = CGRectMake(5.5, ORIGIN_Y(buy) + 5.5, 151.5, 146);
        bfsp.frame = CGRectMake(162.5, ORIGIN_Y(interaction) + 5.5, 86, 70);
        pkbut.frame = CGRectMake(254, bfsp.frame.origin.y, 60, 70);
        set.frame = CGRectMake(162.5, ORIGIN_Y(bfsp) + 5.5, 86, 70);
        about.frame = CGRectMake(254, set.frame.origin.y, 60, 70);
#else
        
        
#endif
    }
    else {
#ifdef isHaoLeCai
        lottery.frame = CGRectMake(5.5,15.5, 151.5, 146);
        frutti.frame = CGRectMake(162.5, lottery.frame.origin.y, 151.5, 146);
        buy.frame = CGRectMake(5.5, ORIGIN_Y(lottery) + 5.5, 151.5, 146);
        interaction.frame = CGRectMake(162.5, buy.frame.origin.y, 151.5, 146);
        seed.frame = CGRectMake(5.5, ORIGIN_Y(buy) + 5.5, 151.5, 146);
        bfsp.frame = CGRectMake(162.5, ORIGIN_Y(interaction) + 5.5, 86, 70);
        pkbut.frame = CGRectMake(254, bfsp.frame.origin.y, 60, 70);
        set.frame = CGRectMake(162.5, ORIGIN_Y(bfsp) + 5.5, 86, 70);
        about.frame = CGRectMake(254, set.frame.origin.y, 60, 70);
#elif defined isFuTiKuai
        lottery.frame = CGRectMake(5.5,6, 151.5, 146);
        frutti.frame = CGRectMake(162.5, lottery.frame.origin.y, 151.5, 146);
        buy.frame = CGRectMake(5.5, ORIGIN_Y(lottery) + 5.5, 151.5, 146);
        interaction.frame = CGRectMake(162.5, buy.frame.origin.y, 151.5, 146);
        seed.frame = CGRectMake(5.5, ORIGIN_Y(buy) + 5.5, 151.5, 146);
        bfsp.frame = CGRectMake(162.5, ORIGIN_Y(interaction) + 5.5, 86, 70);
        pkbut.frame = CGRectMake(254, bfsp.frame.origin.y, 60, 70);
        set.frame = CGRectMake(162.5, ORIGIN_Y(bfsp) + 5.5, 86, 70);
        about.frame = CGRectMake(254, set.frame.origin.y, 60, 70);
#else
        
#endif
    }

    mainScrollView = [[GCScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:mainScrollView];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.bounces = YES;
    mainScrollView.delegatea = self;
    mainScrollView.delaysContentTouches = NO;
    ///////////////////////////////set////////////////////////
    //活跃
    //
//#ifndef isHaoLeCai
    
#ifdef isFuTiKuai
    if (IS_IPHONE_5) {
        [self shiShiXinXi];//实时信息
        
        [self lunXianViewFunction];//下面轮显的控件
        
        // 点击背景消失
        bgbutton = [[UIButton alloc] init];
        bgbutton.frame = self.mainView.bounds;
        [bgbutton addTarget:self action:@selector(pressButtonBack:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:bgbutton];
    }
#else
    [self shiShiXinXi];//实时信息
    
    [self lunXianViewFunction];//下面轮显的控件
    
    // 点击背景消失
    bgbutton = [[UIButton alloc] init];
    [bgbutton addTarget:self action:@selector(pressButtonBack:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:bgbutton];
//    bgbutton.backgroundColor = [UIColor cyanColor];
#endif
    
//#endif
    
    //活动
    eventsButton.frame = CGRectMake((self.mainView.frame.size.width - (BUTTON_WIDTH_BIG * zoom * 2 + JIANJU * zoom))/2, ZHUCE_HEIGHT + 15, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_SMALL * zoom);
    
    //攻略
    frutti.frame = CGRectMake(ORIGIN_X(eventsButton) + JIANJU * zoom, eventsButton.frame.origin.y, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_SMALL * zoom);
    
    //开奖榜单
    lottery.frame = CGRectMake(eventsButton.frame.origin.x,ORIGIN_Y(eventsButton) + JIANJU * zoom, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_BIG * zoom);
    
    //微博互动
    interaction.frame = CGRectMake(ORIGIN_X(lottery) + JIANJU * zoom, lottery.frame.origin.y, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_BIG * zoom);
    
    //购买彩票
    buy.frame = CGRectMake(eventsButton.frame.origin.x, ORIGIN_Y(lottery) + JIANJU * zoom, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_BIG * zoom);
    
    //pk赛
    pkbut.frame = CGRectMake(ORIGIN_X(buy) + JIANJU * zoom, buy.frame.origin.y, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_SMALL * zoom);
    
    //比分直播
    seed.frame = CGRectMake(eventsButton.frame.origin.x, ORIGIN_Y(buy) + JIANJU * zoom, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_SMALL * zoom);
    
    //我的彩票
    set.frame = CGRectMake(ORIGIN_X(buy) + JIANJU * zoom, ORIGIN_Y(pkbut) + JIANJU * zoom, BUTTON_WIDTH_BIG * zoom, BUTTON_HEIGHT_BIG * zoom);
    
    
    UIImageView *  downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(seed) + JIANJU * zoom, self.mainView.frame.size.width, BUTTON_HEIGHT_SMALL * zoom)];
    downImageView.backgroundColor = [UIColor clearColor];
    downImageView.userInteractionEnabled = YES;
    
    UIButton * goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(15, (downImageView.frame.size.height - 50)/2+ 6, 50, 50);
    [goButton setBackgroundImage:UIImageGetImageFromName(@"ylgoimage.png") forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(pressGoButton:) forControlEvents:UIControlEventTouchUpInside];
    [downImageView addSubview:goButton];
    
    UIImageView * jiaImage = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 17.5, 15, 15)];
    jiaImage.backgroundColor = [UIColor clearColor];
    jiaImage.image = UIImageGetImageFromName(@"newhomegojia.png");
    [goButton addSubview:jiaImage];
    [jiaImage release];
    
    
    
    UIImageView * moneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(downImageView.frame.size.width - 128, goButton.frame.origin.y, 116, 55)];
    moneyImage.backgroundColor = [UIColor clearColor];
    moneyImage.image = UIImageGetImageFromName(@"ylmoneyimage.png");
    [downImageView addSubview:moneyImage];
    [moneyImage release];
    
    
    lcButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lcButton.frame = CGRectMake(goButton.frame.origin.x + goButton.frame.size.width + 21, goButton.frame.origin.y + 6, 103, 38);
    [lcButton setBackgroundImage:UIImageGetImageFromName(@"lc365button.png") forState:UIControlStateNormal];
    lcButton.hidden = YES;
    [lcButton addTarget:self action:@selector(pressLCButton:) forControlEvents:UIControlEventTouchUpInside];
    [downImageView addSubview:lcButton];
    
    
    wsxxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wsxxButton.frame = CGRectMake(goButton.frame.origin.x + goButton.frame.size.width + 42, goButton.frame.origin.y, 80, goButton.frame.size.height);
    [wsxxButton addTarget:self action:@selector(pressZhuCeButton:) forControlEvents:UIControlEventTouchUpInside];
    [downImageView addSubview:wsxxButton];
    
    UILabel * wsOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 80, 20)];
    wsOneLabel.textAlignment = NSTextAlignmentLeft;
    wsOneLabel.backgroundColor = [UIColor clearColor];
    wsOneLabel.tag  = 1101;
    wsOneLabel.textColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1];
    wsOneLabel.font = [UIFont systemFontOfSize:11];
    wsOneLabel.text = @"注册完善信息";
    [wsxxButton addSubview:wsOneLabel];
    [wsOneLabel release];
    
    UILabel * wsTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, 80, 30)];
    wsTwoLabel.textAlignment = NSTextAlignmentLeft;
    wsTwoLabel.tag = 1102;
    wsTwoLabel.backgroundColor = [UIColor clearColor];
    wsTwoLabel.textColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1];
    wsTwoLabel.font = [UIFont systemFontOfSize:18];
    wsTwoLabel.text = @"送3元";
    [wsxxButton addSubview:wsTwoLabel];
    [wsTwoLabel release];
    
    //关于
//    about.frame = CGRectMake(eventsButton.frame.origin.x, ORIGIN_Y(seed) + JIANJU * zoom, BUTTON_WIDTH_SMALL * zoom, BUTTON_HEIGHT_SMALL * zoom);
//    
//    //赛事直播
//    bfsp.frame = CGRectMake(ORIGIN_X(about) + JIANJU * zoom, about.frame.origin.y, BUTTON_WIDTH_SMALL * zoom, BUTTON_HEIGHT_SMALL * zoom);
//    
//    //竞彩足球
//    soccerButton.frame = CGRectMake(ORIGIN_X(bfsp) + JIANJU * zoom, about.frame.origin.y, BUTTON_WIDTH_SMALL * zoom, BUTTON_HEIGHT_SMALL * zoom);
    
    //双色球
//    shuangSeButton.frame = CGRectMake(ORIGIN_X(soccerButton) + JIANJU * zoom, about.frame.origin.y, BUTTON_WIDTH_SMALL * zoom, BUTTON_HEIGHT_SMALL * zoom);

    [bgbutton addSubview:eventsButton];
    [bgbutton addSubview:lottery];
    [bgbutton addSubview:frutti];
    [bgbutton addSubview:buy];
    [bgbutton addSubview:interaction];
    [bgbutton addSubview:seed ];
    [bgbutton addSubview:pkbut];
//    [bgbutton addSubview:bfsp];
    [bgbutton addSubview:set];
//    [bgbutton addSubview:about];
//    [bgbutton addSubview:soccerButton];
//    [bgbutton addSubview:shuangSeButton];
    [bgbutton addSubview:downImageView];
    [downImageView release];
    
    

    lunxianview.frame = CGRectMake(10, ORIGIN_Y(downImageView) + 20, bgbutton.frame.size.width - 10, 20);
    [bgbutton addSubview:lunxianview];

    bgbutton.frame = BGBUTTON_FRAME_WEIZHUCE;
    NSLog(@"%f  %f", lunxianview.frame.origin.y , lunxianview.frame.origin.y+lunxianview.frame.size.height);
    mainScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(lunxianview) + 10 + isIOS7Pianyi);
    
    if ((![[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] != 0) &&!self.versionCheck){
        //        NSMutableData *postData = [[GC_HttpService sharedInstance] reqVersionCheck];
        //
        //        [httpRequest clearDelegatesAndCancel];
        //         self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        //
        //        [httpRequest setRequestMethod:@"POST"];
        //        [httpRequest addCommHeaders];
        //        [httpRequest setPostBody:postData];
        //        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        //        [httpRequest setDelegate:self];
        //        [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
        //        [httpRequest startAsynchronous];
        
        
//        [self.httpRequest clearDelegatesAndCancel];
//        
//        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL checkUpDateFunc]];
//        [httpRequest setTimeOutSeconds:20.0];
//        [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
//        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [httpRequest setDelegate:self];
//        [httpRequest startAsynchronous];
        
    }
    
    [self requestChekNew];
    
}
-(void)myWebView:(UIWebView *)webView Request:(NSURLRequest *)request{
    
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController popViewControllerAnimated:YES];
}

- (void)pressLCButton:(UIButton *)sender{//365理财

    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"caijinbaomake"];
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
    
    NSString * h5url = [NSString stringWithFormat:@"%@lottery/financial/financialIndex.jsp?newRequest=1&sessionId=%@&flag=%@&client=ios&sid=%@&date=%d", licai365H5URL,sessionid,flag,[infoDict objectForKey:@"SID"],(int)[[NSDate date] timeIntervalSince1970]];
    [MobClick event:@"event_wodecaipiao_licai"];
    MyWebViewController *webview = [[MyWebViewController alloc] init];
    [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
    webview.delegate= self;
    webview.hiddenNav = YES;
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:webview animated:YES];
    
    [webview release];
}

- (void)pressGoButton:(UIButton *)sender{// go 按钮

    YLAlertView *ylAlert = [[YLAlertView alloc] initYLAlertView];
    [ylAlert show];
    [ylAlert release];

}


#pragma GCScrollView Delegate
-(void)btnTouchesCancel{
    
    mainScrollView.delaysContentTouches = YES;

}
-(void)btnTouchesBegan{
    mainScrollView.delaysContentTouches = NO;

}
- (void)wanshanxinxi{
    [statepop dismiss];
//    ProvingViewCotroller * prov = [[ProvingViewCotroller alloc] init];
//    prov.canTiaoguo = YES;
//    prov.canBack = NO;
//    [self.navigationController pushViewController:prov animated:YES];
//    [prov release];
    ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
    [self.navigationController pushViewController:proving animated:YES];
    [proving release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)pressZhuCeButton:(UIButton *)sender{
    
    NSInteger denlu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue];
    
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
    if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 111;
            [alert show];
            [alert release];
        }
        
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 111) {
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
        else if (isTixian) {
            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
            
            [requestUserInfo clearDelegatesAndCancel];
            self.requestUserInfo = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [requestUserInfo setRequestMethod:@"POST"];
            [requestUserInfo addCommHeaders];
            [requestUserInfo setPostBody:postData];
            [requestUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
            [requestUserInfo setDelegate:self];
            [requestUserInfo setDidFinishSelector:@selector(returnTiXianSysTime:)];
            [requestUserInfo startAsynchronous];
            
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



//- (void)reqCheckFinished:(ASIHTTPRequest *)request {
//    GC_VersionCheck *vc = [[GC_VersionCheck alloc] initWithResponseData:[request responseData]WithRequest:request];
//    
//    NSLog(@"aaa = %d", vc.reVer);
//    
//    
//    self.versionCheck = vc;
//    NSLog(@"aaa = %d", versionCheck.reVer);
//    if (versionCheck.reVer == 2) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
//                                                        message:[NSString stringWithFormat:@"发现新版本 %.2f\n是否更新",(float)versionCheck.lastVerNum/100] 
//                                                       delegate:self 
//                                              cancelButtonTitle:@"取消" 
//                                              otherButtonTitles:@"更新", nil];
//        alert.tag = 2;
//        [alert show];
//        [alert release];
//    }
//    else if (versionCheck.reVer == 3) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
//                                                        message:[NSString stringWithFormat:@"发现新版本 %.2f\n请更新",(float)versionCheck.lastVerNum/100] 
//                                                       delegate:self 
//                                              cancelButtonTitle:nil 
//                                              otherButtonTitles:@"更新", nil];
//        alert.tag = 3;
//        [alert show];
//        [alert release];
//    }
//    
//    [vc release];
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionCheck.updateAddr]];
//    }
//}
//- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    //    NSLog(@"text = %@ , %@", text.text, [[User getLastUser] password]);
//    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
//        NSLog(@"url = %@", self.urlVersion);
//#ifdef  isCaiPiao365ForIphone5
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlVersion]];
//#else
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
//#endif
//        
//    }
//}


#pragma mark - 通知 event

//- (void)returnview:(UIView *)view{
//    if ([delegate respondsToSelector:@selector(returnview:)]) {
//        [delegate returnview:view];
//        // NSLog(@"index = %d", index);
//    }
//}

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

- (void)weibotongzhi{
    [statepop dismiss];
    
//    PreJiaoDianTabBarController * home = [[PreJiaoDianTabBarController alloc] initWithUerself:NO userID:nil];
//    
//    //  home.tabBar.backgroundImage = UIImageGetImageFromName(@"tabbar.png");
//     
//
//    
//    [self.navigationController pushViewController:home animated:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [home release];
    [self weiBoHome:YES];
    tab.loginyn = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)kaijiangtongzhi{
    [statepop dismiss];
    LastLotteryViewController * as = [[[LastLotteryViewController  alloc] init] autorelease];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:as animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)wodecaipiaotongzhi{
    [statepop dismiss];
    HRSliderViewController *my = [[[HRSliderViewController alloc] init] autorelease];
    [self.navigationController pushViewController:my animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}

- (void)jinnangtongzhi{
    [statepop dismiss];
    
    [self SachetViewFunc];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:nil];
}


#pragma mark - button event

//八方视频
- (void)pressbfsp:(UIButton *)sender{
    [MobClick event:@"ecetn_saishizhibo"];
    GC_BaFangShiPingViewController * shipin = [[[GC_BaFangShiPingViewController alloc] init] autorelease];
    [self.navigationController pushViewController:shipin animated:YES];
}

- (void)recivedFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    
	if ([responseStr isEqualToString:@"fail"]) 
        {
//		[self dismissWelcomePage];
        }
	else {
		User *lastUser = [User getLastUser];
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			[Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
			return;
		}
		Info *info = [Info getInstance];
		info.login_name = lastUser.login_name;
		info.userId = userInfo.userId;
		info.nickName = userInfo.nick_name;
		//info.password = lastUser.password;
		info.userName = userInfo.user_name;
		info.mUserInfo = userInfo;
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
		//[[GC_HttpService sharedInstance] startHeartInfoTimer];
	}

}
//(关于) 设置
- (void)goAbout:(UIButton *)sender{
    [MobClick event:@"event_about"];
    AboutOurViewController *aboutUS=[[[AboutOurViewController alloc] init] autorelease];
    [self.navigationController pushViewController:aboutUS animated:YES];
}
//娱乐
-(void)goYule:(UIButton *)sender{
    
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
//购彩
//购彩
- (void)goBuy :(UIButton *)sender{
    
    
    
    
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        
        if (1||[[GC_HttpService sharedInstance].sessionId length] || [[[Info getInstance] userId] intValue] == 0) {
            
            if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] != 0 || [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"为了更好的保护您的购彩信息，请先完善您的个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.delegate = self;
                alert.tag = 119;
                [alert show];
                [alert release];
                
                return;
            }
            
            
            
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

//赛马
- (void)pressfrutti:(UIButton *)sender{
    HorseRaceViewController * high = [[[HorseRaceViewController alloc] init] autorelease];
    [self.navigationController pushViewController:high animated:YES];
}

//// 跳会到首页
-(void)homeAction
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)backAction
{
    
	[self.navigationController popViewControllerAnimated:YES];
    
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

// 点击写微博 按钮
-(void)pressWriteButton:(id)sender {
//	NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];

    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
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

- (void)chekNewPush{
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
    pinglustr = [[dict objectForKey:@"pl"] intValue];
    sxstr = [[dict objectForKey:@"sx"] intValue];
    guanzhustr = [[dict objectForKey:@"gz"] intValue];
    atmestr = [[dict objectForKey:@"atme"] intValue];
    gzrftstr = [[dict objectForKey:@"gzrft"] intValue];
    kfcount = [[dict objectForKey:@"kfsx"] intValue];
    NSLog(@"kfcount = %ld", (long)kfcount);
    NSLog(@"kfcount2 = %@",[dict objectForKey:@"kfsx"]);
    
    if (pinglustr != 0||guanzhustr != 0|| atmestr != 0|| sxstr != 0) {

            [interaction setImage:UIImageGetImageFromName(@"GC_NEW.png") forState:UIControlStateNormal];
            [interaction setImage:UIImageGetImageFromName(@"GC_NEW_0.png") forState:UIControlStateHighlighted];
    } else {
    
            [interaction setImage:UIImageGetImageFromName(@"cpthree_jd.png") forState:UIControlStateNormal];
            [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateHighlighted];
    }
    if ([[dict objectForKey:@"zj"] intValue] == 0) {
            [set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
            [set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
	}
	else {
            [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_1.png") forState:UIControlStateNormal];
            [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_0.png") forState:UIControlStateHighlighted];
	}
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    if (kfcount > 0) {
        // [caiboapp.keFuButton chulaitiao];
        //        caiboapp.keFuButton.show = YES;
        //        caiboapp.keFuButton.newkfbool = YES;
        //  caiboapp.keFuButton.show = YES;
        caiboapp.keFuButton.markbool = YES;
        caiboapp.keFuButton.newkfbool = YES;
    }else{
        caiboapp.keFuButton.markbool = NO;
        caiboapp.keFuButton.newkfbool = NO;
    }
}

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
#pragma mark tabbarcontroller 初始化

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

//微博首页
- (void)pressInteraction:(UIButton *)sender{
    
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

//开奖
- (void)pressLottery:(UIButton *)sender{
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

- (void)scoreLiveFunc{
    LiveScoreViewController *lsViewController = [[[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil] autorelease];
    [self.navigationController pushViewController:lsViewController animated:YES];
    return;
    singletonData * singleton = [singletonData getInstance];//全清一下
    singleton.selectTile = 0;
    singleton.myTitle = 0;
    singleton.liveTitle = 0;
    singleton.endTitle = 0;
    singleton.liveIssue = @"";
    singleton.myIssue = @"";
    singleton.endIssue = @"";
    [singleton.allDataArray removeAllObjects];
    [singleton.endAllDataArray removeAllObjects];
    [singleton.myAllDataArray removeAllObjects];
    [singleton.allIussueArray removeAllObjects];
    [singleton.endIussueArray removeAllObjects];
    
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
    tabc.delegateCP = self;
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        tabc.selectedIndex = 1;
    }else{
        tabc.selectedIndex = 0;
    }
   
    
    
    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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

//比分直播
- (void)pressSeedButton:(UIButton *)sender{
    [self scoreLiveFunc];
}
//攻略
-(void)pressGonglue:(UIButton *)sender{

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
//老PK赛
-(void)pressOldPkbut:(UIButton *)sender{

    [MobClick event:@"event_pksai"];
    PKMatchViewController * pkm1 = [[PKMatchViewController alloc] init];
    pkm1.pkMatchType = PKMatchTypeRank;
    
    PKMatchViewController * pkm2 = [[PKMatchViewController alloc] init];
    pkm2.pkMatchType = PKMatchTypeBettingRecords;
    
    PKMatchViewController * pkm3 = [[PKMatchViewController alloc] init];
    pkm3.pkMatchType = PKMatchTypeCross;
    
    PKMatchViewController * pkm4 = [[PKMatchViewController alloc] init];
    pkm4.pkMatchType = PKMatchTypeMyBet;
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:pkm1, pkm2,pkm3, pkm4,nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"中奖排行"];
    [labearr addObject:@"投注记录"];
    [labearr addObject:@"过关统计"];
    [labearr addObject:@"我的投注"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"PKzhongjiangicon1.png"];
    [imagestring addObject:@"PKtouzhuicon1.png"];
    [imagestring addObject:@"PKguoguanicon1.png"];
    [imagestring addObject:@"PKwodeicon1.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"PKzhongjiangicon2.png"];
    [imageg addObject:@"PKtouzhuicon2.png"];
    [imageg addObject:@"PKguoguanicon2.png"];
    [imageg addObject:@"PKwodeicon2.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    //    tabc.selectedIndex = indexd;
    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [pkm1 release];
    [pkm2 release];
    [pkm3 release];
    [pkm4 release];

}
//pk猜猜猜
- (void)presspkbut:(UIButton *)sender{
    
    
    PKRaceViewController *pvc = [[PKRaceViewController alloc]init];
    
    [self.navigationController pushViewController:pvc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [pvc release];

}

//(设置)   我的彩票
- (void)pressSetButton:(UIButton *)sender{
    
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



-(void)autoRefresh:(NSString*)responseString{

    
	if (responseString) {
        NSDictionary * dict = [responseString JSONValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cheknewpush"];
		
		CheckNewMsg *check = [[CheckNewMsg alloc] initWithParse:responseString];
     
        NSLog(@"checkkkkkkkkkkkkkkkkkkkkk %@, %@, %@, %@,中奖%@", check.gzrft, check.atme, check.sx, check.pl,check.zj);
        
        if (![check.pl isEqualToString:@"0" ]||![check.gz isEqualToString:@"0" ]|| ![check.atme isEqualToString:@"0"]|| ![check.sx isEqualToString:@"0"]||![check.gzrft isEqualToString:@"0" ]) {
  
            
            guanzhustr = [check.gz intValue];
            pinglustr = [check.pl intValue];
            atmestr = [check.atme intValue];
            sxstr  = [check.sx intValue];
            gzrftstr =[check.gzrft intValue];
            kfcount = [check.kefucountstr intValue];
//            jdnewImage.hidden = NO;
            
                [interaction setImage:UIImageGetImageFromName(@"GC_NEW.png") forState:UIControlStateNormal];
                [interaction setImage:UIImageGetImageFromName(@"GC_NEW_0.png") forState:UIControlStateHighlighted];
            
        }else{
//            jdnewImage.hidden = YES;

                [interaction setImage:UIImageGetImageFromName(@"cpthree_jd.png") forState:UIControlStateNormal];
                [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateHighlighted];
        }
		
		if ([check.zj isEqualToString:@"0"]) {
                [set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
                [set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
		}
		else {
                [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_1.png") forState:UIControlStateNormal];
                [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_0.png") forState:UIControlStateHighlighted];
        }
       
        
        
        NSString * leixingarr = [NSString stringWithFormat:@"%@,%@,%@,%@", check.atme, check.pl,check.sx,check.xttz];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leixingbiaoji" object:leixingarr];
        
     
        UINavigationController *a = self.navigationController;
		NSArray * views = a.viewControllers;
       
        caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
        if ([check.kefucountstr isEqualToString:@"0"]){
            caiboappdelegate.keFuButton.markbool = NO;
            caiboappdelegate.keFuButton.newkfbool = NO;
            // [self returnSiXinData:sxstr];
        }
		if ([views count] >= 2) {
			
                      
            
			if ([[views objectAtIndex:1] isKindOfClass:[CPSetViewController class]] || [[views objectAtIndex:1] isKindOfClass:[GC_BaFangShiPingViewController class]]||[[views objectAtIndex:1] isKindOfClass:[GouCaiHomeViewController class]]||[[views objectAtIndex:1] isKindOfClass:[GouCaiViewController class]]||[[views objectAtIndex:1] isKindOfClass:[LastLotteryViewController class]]||[[views objectAtIndex:1] isKindOfClass:[scoreLiveTelecastViewController class]]||[[views objectAtIndex:1] isKindOfClass:[CP_TabBarViewController class]] ||[[views objectAtIndex:1] isKindOfClass:[PKMatchViewController class]]||[[views objectAtIndex:1] isKindOfClass:[SachetViewController class]] ) {
               
                
                
                caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
                if (![check.kefucountstr isEqualToString:@"0"]) {
                    [caiboappdelegate.keFuButton chulaitiao];
                    caiboappdelegate.keFuButton.show = YES;
                    caiboappdelegate.keFuButton.markbool = YES;
                    caiboappdelegate.keFuButton.newkfbool = YES;
                    //  [[NSNotificationCenter defaultCenter] postNotificationName:@"kefusixin" object:nil];
                }else{
                    caiboappdelegate.keFuButton.markbool = NO;
                    caiboappdelegate.keFuButton.newkfbool = NO;
                    // [self returnSiXinData:sxstr];
                }

                if ([[views objectAtIndex:1] isKindOfClass:[GouCaiHomeViewController class]]) {//我的彩票里 自助服务的标记
                     GouCaiHomeViewController * gou = [views objectAtIndex:1];
                    if ([check.kefucountstr integerValue] > 0) {
                       
                        gou.selfHelpImageView.hidden = NO;
                    }else{
                        gou.selfHelpImageView.hidden = YES;
                    }
                }
                
                
                
            }
            if([views count] >= 3){
                if ([[views objectAtIndex:2] isKindOfClass:[CPselfServiceViewController class]]) {//我的彩票里 自助服务的标记
                    CPselfServiceViewController * gou = [views objectAtIndex:2];
                    if ([gou.dataArray count] >= 2) {
                        NSMutableArray * nmArray = [gou.dataArray objectAtIndex:2];
                        CPSlefHelpData * data = [nmArray objectAtIndex:0];
                        data.imageHidder = NO;
                        [nmArray replaceObjectAtIndex:0 withObject:data];
                        [gou.dataArray replaceObjectAtIndex:2 withObject:nmArray];
                        if (gou.myTableView) {
                          [gou.myTableView reloadData];  
                        }
                        
                    }
                    
                    
                }
            }
            [check release];
            return;
		}
        if ([views count]==1) {
            if ([[views objectAtIndex:0] isKindOfClass:[newHomeViewController class]]) {
                caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
                if (![check.kefucountstr isEqualToString:@"0"]) {
                    [caiboappdelegate.keFuButton chulaitiao];
                    caiboappdelegate.keFuButton.show = YES;
                    caiboappdelegate.keFuButton.markbool = YES;
                    caiboappdelegate.keFuButton.newkfbool = YES;
                    //  [[NSNotificationCenter defaultCenter] postNotificationName:@"kefusixin" object:nil];
                }else{
                    caiboappdelegate.keFuButton.markbool = NO;
                    caiboappdelegate.keFuButton.newkfbool = NO;
                    // [self returnSiXinData:sxstr];
                }
            }
        }
        
        

    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnSiXinCount:) name:@"kefusixin" object:nil];
       

		[check release];
		
	}
    
}

 
- (void)dealloc{
    [huoyuerequest clearDelegatesAndCancel];
    [huoyuerequest release];
    [mytableviw release];
    [shishiview release];
    [huoYueLabelOne release];
    [huoYueLabelTwo release];
    [lunxianview release];
    [chekrequest clearDelegatesAndCancel];
    [chekrequest release];
    [versionCheck release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [requestUserInfo clearDelegatesAndCancel];
    [requestUserInfo release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    
    [eventsButton release];
//    [soccerButton release];
//    [shuangSeButton release];
    [lottery release];
    [frutti release];
    [buy release];
    [interaction release];
    [seed release];
//    [bfsp release];
    [pkbut release];
    [set release];
//    [about release];
    
    [huoqu release];
    [bgbutton release];
    
    [mainScrollView release];
//    [newMainView release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{

     
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"cheknewpush"];
    
    
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.tag = 200;
        prizeView.delegate = self;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    pinglustr = [[dict objectForKey:@"pl"] intValue];
    sxstr = [[dict objectForKey:@"sx"] intValue];
    guanzhustr = [[dict objectForKey:@"gz"] intValue];
    atmestr = [[dict objectForKey:@"atme"] intValue];
    gzrftstr = [[dict objectForKey:@"gzrft"] intValue];
    kfcount = [[dict objectForKey:@"kfsx"] intValue];
    NSLog(@"kfcount = %ld", (long)kfcount);
    NSLog(@"kfcount2 = %@",[dict objectForKey:@"kfsx"]);
    
    if (pinglustr != 0||guanzhustr != 0|| atmestr != 0|| sxstr != 0) {

            [interaction setImage:UIImageGetImageFromName(@"GC_NEW.png") forState:UIControlStateNormal];
            [interaction setImage:UIImageGetImageFromName(@"GC_NEW_0.png") forState:UIControlStateHighlighted];
        
    } else {
            [interaction setImage:UIImageGetImageFromName(@"cpthree_jd.png") forState:UIControlStateNormal];
            [interaction setImage:UIImageGetImageFromName(@"cpthree_jd_0.png") forState:UIControlStateHighlighted];
    }
    if ([[dict objectForKey:@"zj"] intValue] == 0) {
            [set setImage:UIImageGetImageFromName(@"cpthree_sz.png") forState:UIControlStateNormal];
            [set setImage:UIImageGetImageFromName(@"cpthree_sz_0.png") forState:UIControlStateHighlighted];
	}
	else {
            [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_1.png") forState:UIControlStateNormal];
            [set setImage:UIImageGetImageFromName(@"newHomeZhongjiang_0.png") forState:UIControlStateHighlighted];
	}
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    if (kfcount > 0) {
       // [caiboapp.keFuButton chulaitiao];
        //        caiboapp.keFuButton.show = YES;
        //        caiboapp.keFuButton.newkfbool = YES;
      //  caiboapp.keFuButton.show = YES;
        caiboapp.keFuButton.markbool = YES;
        caiboapp.keFuButton.newkfbool = YES;
    }else{
        caiboapp.keFuButton.markbool = NO;
        caiboapp.keFuButton.newkfbool = NO;
    }

   
}
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}
- (BOOL)prefersStatusBarHidden
{
    return NO;//隐藏为YES，显示为NO
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    [super viewWillDisappear:animated];
//    zhucezlBtn.hidden = YES;
    if (luntime) {
        [luntime invalidate];//活跃
        luntime = nil;
    }
    caiboAppDelegate * appdelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hidenMessage];
    // caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [appdelegate.keFuButton calloff];

   // [luntime invalidate];//活跃
}


- (void)yanchidiao{
    //活跃   //////////////
    [self jiangetimehanshu];
    // luntime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(lunXianLabel) userInfo:nil repeats:YES];
    [self baocunxinxi];
    ////////////////////////////////////////////////////////////
    Info *info = [Info getInstance];


    NSInteger ziliaowan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue];
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    NSLog(@"info = %@", infosave);
    
    
	if ([infosave length] ) {
    
        NSLog(@"cccc = %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"]);
//        NSInteger ziliaowan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue];
        if (ziliaowan == 1 ) {
//                [zhucezlBtn setImage:UIImageGetImageFromName(@"gc_wanshan.png") forState:UIControlStateNormal];
//                [zhucezlBtn setImage:UIImageGetImageFromName(@"gc_wanshan_0.png") forState:UIControlStateHighlighted];
            lcButton.hidden = YES;
            wsxxButton.hidden = NO;
            UILabel * onelabel =  (UILabel *)[wsxxButton viewWithTag:1101];
            UILabel * twolabel =  (UILabel *)[wsxxButton viewWithTag:1102];
            onelabel.text = @"完善信息";
            twolabel.text = @"";
            if ([[[Info getInstance] caijin] floatValue] > 0) {
                twolabel.text = [NSString stringWithFormat:@"送%@元", [[Info getInstance] caijin]];
            }
        }
    } else{
        lcButton.hidden = YES;
        wsxxButton.hidden = NO;
        UILabel * onelabel =  (UILabel *)[wsxxButton viewWithTag:1101];
        UILabel * twolabel =  (UILabel *)[wsxxButton viewWithTag:1102];
        onelabel.text = @"注册完善信息";
        twolabel.text = @"";
        if ([[[Info getInstance] caijin] floatValue] > 0) {
            twolabel.text = [NSString stringWithFormat:@"送%@元", [[Info getInstance] caijin]];
        }
        

    }
    
    

    if ([info.userId intValue]) {//未登陆注册领取3元按钮
//        zhucezlBtn.hidden = YES;
        bgbutton.frame = BGBUTTON_FRAME_YIWANSHAN;
        mainScrollView.contentSize = CONTENTSIZE_YIWANSHAN;

//        imageviewbg.image = UIImageGetImageFromName(@"cpthree_loginBg.png");//login_bg.png
        //    }
        //    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] isEqualToString:@"1"]){
        //
        //        zhucezlBtn.hidden = YES;
        
        if (ziliaowan == 1 ) {
            lcButton.hidden = YES;
            wsxxButton.hidden = NO;
     
            bgbutton.frame = BGBUTTON_FRAME_WEIZHUCE;
            mainScrollView.contentSize = CONTENTSIZE_WEIWANSHAN;

//            imageviewbg.image = UIImageGetImageFromName(@"login_bg.png");//login_bg.png
#ifdef  isCaiPiao365ForIphone5
//            imageviewbg.image = UIImageGetImageFromName(@"cpthree_loginBg.png");
#else
//            imageviewbg.image = UIImageGetImageFromName(@"login_bg.png");//login_bg.png
#endif
        }else{
            lcButton.hidden = NO;
            wsxxButton.hidden = YES;
            if (IS_IPHONE_5) {
                bgbutton.frame = BGBUTTON_FRAME_YIWANSHAN_IP5;
                mainScrollView.contentSize = CGSizeZero;
            }else{
                bgbutton.frame = BGBUTTON_FRAME_YIWANSHAN;
                mainScrollView.contentSize = CONTENTSIZE_YIWANSHAN;
            }

        }
        
    }else{
        if ([info.caijin intValue] > 0) {
//            zhucezlBtn.hidden = YES;
            bgbutton.frame = BGBUTTON_FRAME_WEIZHUCE;
            mainScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(lunxianview) + 10 + isIOS7Pianyi);
            
            

        }
        bgbutton.frame = BGBUTTON_FRAME_WEIZHUCE;
        mainScrollView.contentSize = CONTENTSIZE_WEIZHUCE;
        lcButton.hidden = YES;
        wsxxButton.hidden = NO;

        
    }


    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#ifdef isHaoLeCai
    [UIApplication sharedApplication].statusBarHidden = NO;
#endif
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
//    [self setNeedsStatusBarAppearanceUpdate];
    [[caiboAppDelegate getAppDelegate] oneLoginFunc];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"newestversion"] floatValue] > [[[Info getInstance] cbVersion] floatValue]) {
//            [about setImage:UIImageGetImageFromName(@"about1.png") forState:UIControlStateNormal];
//            [about setImage:UIImageGetImageFromName(@"about2.png") forState:UIControlStateHighlighted];
    }
    else {
//            [about setImage:UIImageGetImageFromName(@"about4.png") forState:UIControlStateNormal];
//            [about setImage:UIImageGetImageFromName(@"about3.png") forState:UIControlStateHighlighted];
    }
    
    caiboAppDelegate * caoboapp = [caiboAppDelegate getAppDelegate];
    if (!caoboapp.keFuButton) {
        KFButton * kfb = [[KFButton alloc] initWithFrame:CGRectMake(-127, 303, 173, 48)];//(0, 303, 46, 48)
        kfb.hidden = YES;
        caoboapp.keFuButton = kfb;//[[KFButton alloc] initWithFrame:CGRectMake(0, 303, 46, 48)];
       // caoboapp.keFuButton.hidden = YES;
        [caoboapp.window addSubview:kfb];//caoboapp.keFuButton];
        [kfb release];
        
    }
     [self chekNewPush];
    caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    if (kfcount > 0) {
        [caiboapp.keFuButton chulaitiao];
        //        caiboapp.keFuButton.show = YES;
        //        caiboapp.keFuButton.newkfbool = YES;
        caiboapp.keFuButton.show = YES;
        caiboapp.keFuButton.markbool = YES;
        caiboapp.keFuButton.newkfbool = YES;
        //   [self returnSiXinData:sxstr];
        //   [[NSNotificationCenter defaultCenter] postNotificationName:@"kefusixin" object:nil];
    }else{
        
        if (oneBool == NO) {
            [self performSelector:@selector(yanShiFunc) withObject:self afterDelay:3];
            
        }else{
            
            [self yanShiFunc];
        }
        oneBool = YES;
        
    }
//#ifndef isHaoLeCai
//#ifndef isFuTiKuai
////    [self getWCDate];
//#else
//    [self performSelector:@selector(yanchidiao) withObject:nil];
//#endif
//#endif
////    [self changeStyle];
    [self performSelector:@selector(yanchidiao) withObject:nil];
    if ([[[Info getInstance] userId] length] == 0 && [[[Info getInstance] caijin] length] == 0) {
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL sendCaiJinBySid]];
        [httpRequest setTimeOutSeconds:20.0];
        [httpRequest setDidFinishSelector:@selector(reqCaiJinFinished:)];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest startAsynchronous];

    }
}


- (void)reqCaiJinFinished:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    if ([dict valueForKey:@"fee"]) {
        [[Info getInstance] setCaijin:[dict valueForKey:@"fee"]];
        if ([[[Info getInstance] caijin] intValue] == 0) {
//            zhucezlBtn.hidden = YES;
        }
    }
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    if ([infosave length] ) {
        
        //  if ([info.userId intValue]) {
        NSLog(@"cccc = %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"]);
        NSInteger ziliaowan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue];
        //        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] isEqualToString:@"1"]){
        if (ziliaowan == 1 ) {
//            [zhucezlBtn setTitle:[NSString stringWithFormat:@"完善信息 送%@元",[[Info getInstance] caijin]] forState:UIControlStateNormal];
            lcButton.hidden = YES;
            wsxxButton.hidden = NO;
            UILabel * onelabel =  (UILabel *)[wsxxButton viewWithTag:1101];
            UILabel * twolabel =  (UILabel *)[wsxxButton viewWithTag:1102];
            onelabel.text = @"完善信息";
            twolabel.text = @"";
            if ([[[Info getInstance] caijin] floatValue] > 0) {
                twolabel.text = [NSString stringWithFormat:@"送%@元", [[Info getInstance] caijin]];
            }
        }
    } else{
        lcButton.hidden = YES;
        wsxxButton.hidden = NO;
        UILabel * onelabel =  (UILabel *)[wsxxButton viewWithTag:1101];
        UILabel * twolabel =  (UILabel *)[wsxxButton viewWithTag:1102];
        onelabel.text = @"注册完善信息";
        twolabel.text = @"";
        if ([[[Info getInstance] caijin] floatValue] > 0) {
            twolabel.text = [NSString stringWithFormat:@"送%@元", [[Info getInstance] caijin]];
        }
//        [zhucezlBtn setTitle:[NSString stringWithFormat:@"注册完善信息 送%@元",[[Info getInstance] caijin]] forState:UIControlStateNormal];
        
    }
    [self yanchidiao];
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

- (void)pressEventsButton:(UIButton *)sender
{
    [self goYule:sender];
    
    
}

- (void)pressSoccerButton:(UIButton *)sender
{
    GCJCBetViewController * gcjc = [[[GCJCBetViewController alloc] initWithLotteryID:1] autorelease];
    [MobClick event:@"event_jiangcaizuqiu"];
    [self.navigationController pushViewController:gcjc animated:YES];
}

- (void)pressShuangSeButton:(UIButton *)sender
{
    [MobClick event:@"event_shuangseqiu"];
    
    GouCaiShuangSeQiuViewController *shuang = [[[GouCaiShuangSeQiuViewController alloc] init] autorelease];
    [self.navigationController pushViewController:shuang animated:YES];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
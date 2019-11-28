//
//  LunBoView.m
//  caibo
//
//  Created by GongHe on 13-12-26.
//
//

#import "LunBoView.h"
#import "YH_PageControl.h"
#import "DownLoadImageView.h"
#import "NewsData.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "DetailedViewController.h"
#import "NewsViewController.h"
#import "EveryDayViewController.h"
#import "AnnouncementViewController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MLNavigationController.h"
#import "caiboAppDelegate.h"
#import "MyWebViewController.h"
#import "PreJiaoDianTabBarController.h"
#import "LuckyChoseViewController.h"

#import "KuaiSanViewController.h"
#import "HighFreqViewController.h"
#import "Pai3ViewController.h"
#import "HappyTenViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "DaLeTouViewController.h"
#import "FuCai3DViewController.h"
#import "ShiShiCaiViewController.h"
#import "CQShiShiCaiViewController.h"
#import "KuaiLePuKeViewController.h"
#import "QIleCaiViewController.h"
#import "PaiWuOrQiXingViewController.h"

#import "GC_BJDanChangViewController.h"
#import "GCBettingViewController.h"
#import "GCJCBetViewController.h"
#import "SharedDefine.h"
#import "MobClick.h"
#import "MyWebViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "GouCaiViewController.h"
#import "HomeViewController.h"

#define MAIN_WIDTH mainScrollView.frame.size.width
#define MAIN_HEIGHT mainScrollView.frame.size.height

@implementation LunBoView
@synthesize lunBoRunLoopRef;
@synthesize weiBoRequest;
@synthesize isAnother,isShuZiInfo,hiddenGrayTitleImage;
- (void)dealloc
{
    [betidArray release];
    [lotteryidArray release];
    [playidArray release];
    [flagArray release];
    [typeArray release];
    [titleBGImageView release];
    [myControllter release];
    [mainScrollView release];
    mainScrollView = nil;
    [pageControl release];
    [titleLabel release];
    [lunBoArray release];
    [lunBoImageArray release];
    [lastImageView release];
    [firstImageView release];
    [titleArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame newsViewController:(UIViewController *)newsViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        
        myControllter = [newsViewController retain];
        
        lunBoArray = [[NSMutableArray alloc] init];
        titleArray = [[NSMutableArray alloc] init];
        lunBoImageArray = [[NSMutableArray alloc] init];
        flagArray = [[NSMutableArray alloc] init];
        typeArray = [[NSMutableArray alloc] init];
        lotteryidArray = [[NSMutableArray alloc] init];
        playidArray = [[NSMutableArray alloc] init];
        betidArray = [[NSMutableArray alloc] init];
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        mainScrollView.pagingEnabled = YES;
        mainScrollView.scrollEnabled = NO;
        [self addSubview:mainScrollView];
        mainScrollView.delegate = self;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.scrollsToTop = NO;
        
        UIImageView * noImageBG = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        noImageBG.image = UIImageGetImageFromName(@"wb42.png");
        [mainScrollView addSubview:noImageBG];
        
        titleBGImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 25)] autorelease];
        titleBGImageView.image = UIImageGetImageFromName(@"LunBoTitleBG.png");
        [self addSubview:titleBGImageView];
        
        pageControl = [[YH_PageControl alloc] init];
        pageControl.hidden = YES;
        [self addSubview:pageControl];
        pageControl.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = 0;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.shadowColor = [UIColor blackColor];
        //        titleLabel.shadowOffset = CGSizeMake(2, 2);
        [self addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        isFirst = YES;
        
        // 取数组最后一张图片 放在第0页

        lastImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
        // 添加最后1页在首页 循环
        [mainScrollView addSubview:lastImageView];

        // 取数组第一张图片 放在最后1页
        firstImageView = [[DownLoadImageView alloc] init];
        [mainScrollView addSubview:firstImageView];
        
        second = 0;
    }
    return self;
}

-(void)createTimer
{
    if(lunBoArray.count > 1){
    
        @autoreleasepool {
            if (!myTimer) {
                myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
                self.lunBoRunLoopRef = CFRunLoopGetCurrent();
                CFRunLoopRun();
                
            }
        }
    }

}

-(void)createTimer1
{
    @autoreleasepool {
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        self.lunBoRunLoopRef = CFRunLoopGetCurrent();
        CFRunLoopRun();
    }
}

- (void)turnPage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    [mainScrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,460) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

- (void)changeByMain {
    [mainScrollView setContentOffset:CGPointMake(320 + 320 * (pageControl.currentPage + 1), 0) animated:YES];
    pageControl.currentPage++;
    second = 0;
}

-(void)timeChange
{
    second++;
    
    int requestSecond = 6;
    
    NewsData *data = nil;
    if(lunBoArray.count > pageControl.currentPage){
    
        data = [lunBoArray objectAtIndex:pageControl.currentPage];
    }
    
    if(data.staySecond.length && [data.staySecond intValue] > 0){
        requestSecond = [data.staySecond intValue];
    }
    
    if (second == requestSecond || (second > requestSecond && (second - requestSecond)%requestSecond == 0)) {
        if(mainScrollView){
        
            [self performSelectorOnMainThread:@selector(changeByMain) withObject:nil waitUntilDone:NO];
        }

    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    static float newX = 0;
    static float oldX = 0;
    newX= scrollView.contentOffset.x ;
    if (newX != oldX ) {
        if (newX > oldX) {
            scrollLeft = YES;
        }else if(newX < oldX){
            scrollLeft = NO;
        }
        oldX = newX;
    }
    
    //魔法球隐藏关闭按钮
    if(self.isShuZiInfo){
        if(newX == 320){
            UIView *view1 = [self viewWithTag:9000];
            view1.hidden = YES;
        }
        else {
            UIView *view1 = [self viewWithTag:9000];
            view1.hidden = NO;
        }
    }
    
    if ((scrollView.contentOffset.x + scrollView.frame.size.width/2) < MAIN_WIDTH) {
        pageControl.currentPage = lunBoArray.count;
        
    }else if((scrollView.contentOffset.x + scrollView.frame.size.width/2) > MAIN_WIDTH * (lunBoArray.count + 1)){
        pageControl.currentPage = 0;
    }
    else{
        NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
        page--;
        if (page > pageControl.currentPage && scrollLeft == YES) {
            pageControl.currentPage = page;
        }else if (page < pageControl.currentPage && scrollLeft == NO){
            pageControl.currentPage = page;
        }
    }
    if(titleArray && titleArray.count){
        titleLabel.text = [titleArray objectAtIndex:pageControl.currentPage];
        
    }


    
    float currentPage = scrollView.contentOffset.x/MAIN_WIDTH;

    if (currentPage < 0.001){
        [scrollView scrollRectToVisible:CGRectMake(MAIN_WIDTH * [lunBoArray count],0,MAIN_WIDTH,MAIN_HEIGHT) animated:NO]; // 序号0 最后1页
    }else if (currentPage > ([lunBoArray count] + 0.999)){
        [scrollView scrollRectToVisible:CGRectMake(MAIN_WIDTH,0,MAIN_WIDTH,MAIN_HEIGHT) animated:NO]; // 最后+1,循环第1页
    }
}

-(void)setImageWithArray:(NSArray *)imageArray
{
    [lunBoArray removeAllObjects];
    [titleArray removeAllObjects];
    for (int i = 0; i < lunBoImageArray.count; i++) {
        [[lunBoImageArray objectAtIndex:i] removeFromSuperview];
    }
    
    
    if(hiddenGrayTitleImage){
        titleBGImageView.hidden = YES;

    }else{
        titleBGImageView.hidden = NO;

    }

    pageControl.frame = CGRectMake(10.5, self.frame.size.height - 12, imageArray.count * 12, 8);

    
    if(imageArray.count >1){
        pageControl.hidden = NO;
        mainScrollView.scrollEnabled = YES;
    }

    pageControl.numberOfPages = imageArray.count;
    
    titleLabel.frame = CGRectMake(pageControl.frame.origin.x + pageControl.frame.size.width + 9, self.frame.size.height - 23, self.frame.size.width - pageControl.frame.origin.x - pageControl.frame.size.width - 12, 20);
    
//    int lunBoArrayCount = lunBoArray.count;
////    int imageArrayCount = imageArray.count;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        NewsData * imageData = [imageArray objectAtIndex:i];

        DownLoadImageView * imageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(MAIN_WIDTH + MAIN_WIDTH * i, 0, MAIN_WIDTH, MAIN_HEIGHT)];

        
        if(isAnother){
            imageView.image = UIImageGetImageFromName(@"LunBoLoading_small.png");

        }else{
            imageView.image = UIImageGetImageFromName(@"LunBoLoading.png");

        }
        
        
        if(self.isShuZiInfo && [imageData.newsid isEqualToString:@"100001"]){
            imageView.image = UIImageGetImageFromName(@"luckyrukou.png");

        }else{
            [imageView setImageWithURL:imageData.attach_small];

        }
        imageView.tag = 10 + i;
        [mainScrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        [lunBoImageArray addObject:imageView];
        [imageView release];
        
        [lunBoArray addObject:imageData];
        
        if(imageData.newstitle){
            [titleArray addObject:imageData.newstitle];
        }
        
        if(imageData.flag && imageData.type_id){
        
            [typeArray addObject:imageData.type_id];
            [flagArray addObject:imageData.flag];

        }
        if(imageData.lottery_id && imageData.play_id && imageData.bet_id){
            [lotteryidArray addObject:imageData.lottery_id];
            [playidArray addObject:imageData.play_id];
            [betidArray addObject:imageData.bet_id];
        }
        
        UIButton * imageButton = [[UIButton alloc] initWithFrame:imageView.bounds];
        [imageView addSubview:imageButton];
        [imageButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        
        if(isAnother){
            [imageButton setTitle:imageData.newsid forState:UIControlStateNormal];
            if(isShuZiInfo && i == 0){
                [imageButton addTarget:self action:@selector(PressLucky:) forControlEvents:UIControlEventTouchUpInside];
            }else{
            
                [imageButton addTarget:self action:@selector(toUrl:) forControlEvents:UIControlEventTouchUpInside];

            }

        }
        else
        {
            if ([imageData.type_news1 integerValue] == 1) {
                imageButton.tag = 1;
                [imageButton setTitle:[NSString stringWithFormat:@"%@",imageData.newsid] forState:UIControlStateNormal];
            }else if ([imageData.type_news1 integerValue] == 10){
                imageButton.tag = 10;
                [imageButton setTitle:[NSString stringWithFormat:@"%@",imageData.issue] forState:UIControlStateNormal];
            }else if ([imageData.type_news1 integerValue] == 2){
                imageButton.tag = 2;
            }
            else{
                imageButton.tag = 0;
            }
            
            [imageButton addTarget:self action:@selector(toWeiBo:) forControlEvents:UIControlEventTouchUpInside];

        }

        [imageButton release];

    }



    NewsData * lastImageData = [lunBoArray lastObject];
    if(isAnother){
    
        lastImageView.image = UIImageGetImageFromName(@"LunBoLoading_small.png");

    }else{
        lastImageView.image = UIImageGetImageFromName(@"LunBoLoading.png");

    }
    [lastImageView setImageWithURL:lastImageData.attach_small];
    
    NewsData * firstImageData = [lunBoArray objectAtIndex:0];
    if(isAnother){
        firstImageView.image = UIImageGetImageFromName(@"LunBoLoading_small.png");

    }else{
        firstImageView.image = UIImageGetImageFromName(@"LunBoLoading.png");

    }
    if(isShuZiInfo){
        [firstImageView setImage:UIImageGetImageFromName(@"luckyrukou.png")];
    }
    else{
        [firstImageView setImageWithURL:firstImageData.attach_small];

    }
    
    
    firstImageView.frame = CGRectMake((MAIN_WIDTH * ([lunBoArray count] + 1)) , 0, MAIN_WIDTH, MAIN_HEIGHT); // 添加第1页在最后 循环
    
    [mainScrollView setContentSize:CGSizeMake(MAIN_WIDTH * ([lunBoArray count] + 2), MAIN_HEIGHT)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [mainScrollView scrollRectToVisible:CGRectMake(MAIN_WIDTH,0,MAIN_WIDTH,MAIN_HEIGHT) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    [mainScrollView setContentOffset:CGPointMake(320, 0)];
    
    [self performSelectorInBackground:@selector(createTimer) withObject:nil];
}


-(void)PressLucky:(UIButton *)sender
{
    [MobClick event:@"event_goucai_mofashike"];
    LuckyChoseViewController *luck = [[LuckyChoseViewController alloc] init];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:luck animated:YES];
    [luck release];
}



-(void)toUrl:(UIButton *)sender
{
    NSLog(@"微博广场  购彩大厅 广告点击 %@",sender.titleLabel.text);
    
    int index = (int)pageControl.currentPage;
    NSString *type = nil;
    if(isShuZiInfo){
    
        index = (int)pageControl.currentPage-1;
    }
    if (index >= [typeArray count]) {
        return;
    }
    else{
        
        type = [NSString stringWithFormat:@"%@",[typeArray objectAtIndex:index]];
        
    }
    if ([myControllter isKindOfClass:[GouCaiViewController class]] && [(GouCaiViewController *)myControllter fistPage] == 0) {
        [MobClick event:@"event_goucai_shuzi_banner" label:[NSString stringWithFormat:@"page%d",index + 1]];
    }
    else if ([myControllter isKindOfClass:[GouCaiViewController class]] && [(GouCaiViewController *)myControllter fistPage] == 1) {
        [MobClick event:@"event_goucai_zulancai_banner" label:[NSString stringWithFormat:@"page%d",index + 1]];
    }
    else if ([myControllter isKindOfClass:[HomeViewController class]]) {
        [MobClick event:@"event_weibohuodong_guangchang_banner" label:[NSString stringWithFormat:@"page%d",index + 1]];
    }
    else if ([myControllter isKindOfClass:[NewsViewController class]]) {
        [MobClick event:@"event_weibohuodong_yuce_banner" label:[NSString stringWithFormat:@"page%d",index + 1]];
    }
    NSString *lotteryid = nil;
    NSString *wanfa = nil;
    NSString *betid = nil;
    if(lotteryidArray.count && lotteryidArray.count > index){
        lotteryid = [NSString stringWithFormat:@"%@",[lotteryidArray objectAtIndex:index]];
        wanfa = [NSString stringWithFormat:@"%@",[playidArray objectAtIndex:index]];
        betid = [NSString stringWithFormat:@"%@",[betidArray objectAtIndex:index]];
    }

    
    //微博
    if([type isEqualToString:@"1"]){
    
        [weiBoRequest clearDelegatesAndCancel];
        self.weiBoRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[flagArray objectAtIndex:index]]];
        [weiBoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [weiBoRequest setDelegate:self];
        [weiBoRequest setDidFinishSelector:@selector(weiBoRequestFinish:)];
        [weiBoRequest setTimeOutSeconds:20.0];
        [weiBoRequest startAsynchronous];
    }
    //方案
    else if([type isEqualToString:@"2"]){
    
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.orderId = [typeArray objectAtIndex:index];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:info animated:YES];
        [info release];
        
    }
    //wap地址
    else if([type isEqualToString:@"3"]){
        if ([[flagArray objectAtIndex:index] hasPrefix:@"https://itunes.apple.com"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[flagArray objectAtIndex:index]]];
        }
        MyWebViewController *my = [[MyWebViewController alloc] init];
        
        [my setHidesBottomBarWhenPushed:YES];
        UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
            PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
            
            [VC.selectedViewController.navigationController pushViewController:my animated:YES];
            if (VC.selectedIndex == 0) {
                [my.navigationController setNavigationBarHidden:NO];
            }
        }
        else {
            [NV pushViewController:my animated:YES];
        }
        [my LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:[flagArray objectAtIndex:index]]]];
        [my release];
    
    }
    else if ([type isEqualToString:@"4"]){
    
        [[caiboAppDelegate getAppDelegate] goGCPageWithlotteryID:lotteryid andWanfa:wanfa];
    }
    else if ([type isEqualToString:@"5"]){
    
        NSLog(@"跳转到H5购彩页");
        
        [self pushHtml5OpenUrlWithlotteryid:lotteryid playid:wanfa betid:betid];

    }
}

- (void)pushHtml5OpenUrlWithlotteryid:(NSString *)_lotteryid playid:(NSString *)_playid betid:(NSString *)_betid{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *url = @"http://t.dingdingcai.com/";
    NSString * userNameString = @"";
    Info * userInfo = [Info getInstance];
    if ([userInfo.userName length] > 0) {//判断用户名是否为nil
        userNameString = userInfo.userName;
    }
    NSString * sessionid = @"";
    if ([GC_HttpService sharedInstance].sessionId) {
        sessionid = [GC_HttpService sharedInstance].sessionId;
    }
    NSString * flag = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@", sessionid, userNameString]];
    NSString * h5url = [NSString stringWithFormat:@"%@lottery/callback/lunBo.jsp?sessionID=%@&newVersion=%@&sid=%@&lotteryId=%@&play=%@&bet=%@&flag=%@&client=ios&newRequest=1", licai365H5URL,sessionid,newVersionKey,[infoDict objectForKey:@"SID"], _lotteryid, _playid,_betid,flag];
    
    if([userInfo.userId intValue]){
    
        MyWebViewController *myweb = [[MyWebViewController alloc] init];
        myweb.delegate = self;
        myweb.hiddenNav = YES;
        [myweb LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:myweb animated:YES];
        [myweb release];
    }
    else{
    
        [self doLogin];
    }
    

    
}
-(void)myWebView:(UIWebView *)webView Request:(NSURLRequest *)request{

    
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController popViewControllerAnimated:YES];
}
- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}
-(void)toWeiBo:(UIButton *)button
{
    if (button.tag != 0) {
        if (button.tag == 1) {
            [weiBoRequest clearDelegatesAndCancel];
            self.weiBoRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:button.titleLabel.text]];
            [weiBoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [weiBoRequest setDelegate:self];
            [weiBoRequest setDidFinishSelector:@selector(weiBoRequestFinish:)];
            [weiBoRequest setTimeOutSeconds:20.0];
            [weiBoRequest startAsynchronous];
        }else if (button.tag == 10){
            EveryDayViewController * everyDay = [[[EveryDayViewController alloc] initWithIssue:button.titleLabel.text] autorelease];
            [myControllter.navigationController pushViewController:everyDay animated:YES];
        }else if (button.tag == 2)
        {
            AnnouncementViewController * ann = [[[AnnouncementViewController alloc] init] autorelease];
            [myControllter.navigationController pushViewController:ann animated:YES];
        }
    }
}

-(void)weiBoRequestFinish:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    if ([[mStatus arrayList] count] > 0) {
        DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
        [detailed setHidesBottomBarWhenPushed:NO];
        [myControllter.navigationController pushViewController:detailed animated:YES];
        [detailed release];
    }
   
    
    [mStatus release];
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
////    int currentPage = ((scrollView.contentOffset.x - MAIN_WIDTH/ ([myLunBoArray count]+2)) / MAIN_WIDTH) + 1;
//    float currentPage = scrollView.contentOffset.x/MAIN_WIDTH; // 和上面两行效果一样
//    //    NSLog(@"currentPage_==%d",currentPage_);
//    
////    NSLog(@"pageControl.currentPage = %d,currentPage = %d",pageControl.currentPage,currentPage);
//    if (currentPage < 0.5)
//    {
//        [scrollView scrollRectToVisible:CGRectMake(MAIN_WIDTH * [myLunBoArray count],0,MAIN_WIDTH,MAIN_HEIGHT) animated:NO]; // 序号0 最后1页
//    }
//    else if (currentPage > ([myLunBoArray count] + 0.5))
//    {
//        [scrollView scrollRectToVisible:CGRectMake(MAIN_WIDTH,0,MAIN_WIDTH,MAIN_HEIGHT) animated:NO]; // 最后+1,循环第1页
//    }
//}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
    //
//  MyWebViewController.m
//  caibo
//
//  Created by yao on 11-12-14.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "MyWebViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "SendMicroblogViewController.h"
#import "GC_TopUpViewController.h"

@implementation MyWebViewController
@synthesize isHaveTab, delegate;
@synthesize hiddenNav;
@synthesize islicai;
@synthesize webTitle;
@synthesize isTMC;
@synthesize needPopSupController;
@synthesize requestUrl, directReturn,urlWap,titleString,contentString;
@synthesize showExit;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)init {
    self = [super init];
    if (self) {
        mywebView = [[UIWebView alloc] init];
        ylReturn = YES;
        self.canShareToWX = NO;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(cancelLoadView) withObject:nil afterDelay:2];
}

- (void)LoadRequst:(NSURLRequest *)request {
    self.requestUrl = request.URL;
    NSURLRequest *request1 =[NSURLRequest requestWithURL:request.URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSLog(@"x = %@", request);
	[mywebView loadRequest:request1];
    [self performSelector:@selector(cancelLoadView) withObject:nil afterDelay:3];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
#ifdef CRAZYSPORTS
    [super changeOYTitle];
#endif
    if(hiddenNav){
        
        self.CP_navigation.hidden = YES;
//        NSLog(@"cpnavigation = %f", self.mainView.frame.origin.y);
        if (self.mainView.frame.origin.y > 20) {
            self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y-self.CP_navigation.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height+self.CP_navigation.frame.size.height);

        }
        
        mywebView.frame = self.mainView.bounds;
//        NSLog(@"cpnavigation = %f", self.mainView.frame.origin.y);

    }


}
- (void)doBack{
    if ([self.navigationController.viewControllers count] <= 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (directReturn == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (mywebView && mywebView.canGoBack && ylReturn) {
        
        if(needPopSupController){

            [self LoadRequst:[NSURLRequest requestWithURL:requestUrl]];
            
            ylReturn = NO;
            
            return;

        }
        else{
            
            [mywebView goBack];
            return;
        
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
        
    

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.mainView.backgroundColor = [UIColor clearColor];
    if (hiddenNav) {
        UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.mainView.frame.size.width, 20)];
        navView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
        [self.mainView addSubview:navView];
        [navView release];
    }
    
    if(self.webTitle){
        self.CP_navigation.title = webTitle;

    }
    else{
#ifdef CRAZYSPORTS
        self.CP_navigation.title = @"疯狂体育";
#else
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * nameDict = [infoDict objectForKey:@"CFBundleDisplayName"];
        self.CP_navigation.title = nameDict;
#endif
        
    }
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
    
    if (showExit) {
        UIBarButtonItem * rightItem = [Info itemInitWithTitle:@"关闭" Target:self action:@selector(doExit) ImageName:nil Size:CGSizeMake(70,30)];
        self.CP_navigation.rightBarButtonItem = rightItem;
    }
    
    if (self.canShareToWX) {
        UIBarButtonItem * rightItem = [Info itemInitWithTitle:@"···" Target:self action:@selector(share) ImageName:nil Size:CGSizeMake(70,30) titleColor:[UIColor blackColor]];
        self.CP_navigation.rightBarButtonItem = rightItem;
    }
    
    mywebView.frame = self.mainView.bounds;
    if(isHaveTab){
        
        mywebView.frame = CGRectMake(0, -20, 320, self.mainView.frame.size.height-29);

    }
    mywebView.delegate = self;
    [self.mainView addSubview:mywebView];
    mywebView.scalesPageToFit = YES;
    
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-mywebView.scrollView.bounds.size.height, mywebView.scrollView.frame.size.width, mywebView.scrollView.bounds.size.height)];
    refreshHeaderView.delegate = self;
    mywebView.scrollView.delegate = self;
    [mywebView.scrollView addSubview:refreshHeaderView];
    [refreshHeaderView refreshLastUpdatedDate];
    [refreshHeaderView release];
    
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSString *tmcFirst = [[NSUserDefaults standardUserDefaults] valueForKey:@"isTmcFirst"];
    if(isTMC && ![tmcFirst isEqualToString:@"1"]){
    
        [self addTMCBgView];
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isTmcFirst"];
    }
	
}

-(void)addTMCBgView{

    bgview = [[UIImageView alloc] initWithFrame:self.view.frame];
    if(IS_IPHONE_5){
    
        bgview.image =UIImageGetImageFromName(@"tmcbgView_ip5.png");

    }
    else{
    
        bgview.image =UIImageGetImageFromName(@"tmcbgView.png");

    }
    bgview.userInteractionEnabled = YES;
    bgview.backgroundColor = [UIColor clearColor];
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:bgview];

    
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTMCView)];
    [bgview addGestureRecognizer:tapGestureRec];
    [tapGestureRec release];
    
    [self performSelector:@selector(removeTMCView) withObject:nil afterDelay:3];
}

- (void)share {
    CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    lb2.delegate = self;
    lb2.tag = 103;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        lb2.weixinBool = YES;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到新浪微博", @"彩民微博",@"分享到微信朋友圈(未安装)",nil]];
    }else{
        lb2.weixinBool = NO;
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到微信朋友圈",@"分享到新浪微博", @"彩民微博",@"分享给微信好友",nil]];
    }
    
    
    lb2.isSelcetType = YES;
    [lb2 showFenxiangWithoutSina];
    
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (liebiaoView.tag == 103) {
        if (buttonIndex == 0) {//微信朋友圈
            [self shareWeiXin];
            
        }
        else if(buttonIndex == 1){//微信好友
            [self shareWiXinFriends];
            
        }
        return;
    }
}

- (void)shareWeiXin{
    if (!self.shareUrl) {
        self.shareUrl = [NSString stringWithFormat:@"%@",self.requestUrl];
    }
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];

    [appcaibo RespLinkContentUrl:self.shareUrl title:self.shareTitle image:[UIImage imageNamed:@"Icon.png"] content:nil];
}

- (void)shareWiXinFriends{
    if (!self.shareUrl) {
        self.shareUrl = [NSString stringWithFormat:@"%@",self.requestUrl];
    }
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    
    [appcaibo RespLinkContentUrl:self.shareUrl title:self.shareTitle image:[UIImage imageNamed:@"Icon.png"] content:nil wxScene:WXSceneSession];
}

-(void)removeTMCView{

    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    if([bgview isDescendantOfView:window]){
    
        [UIView animateWithDuration:0.5 animations:^{
            
            [bgview removeFromSuperview];
            bgview.alpha = 0;
        }];
    }
    
}



- (void)shareWeiXin:(NSString *)url content:(NSString *)content title:(NSString *)title{
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo imageWithScreenContents];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    [appcaibo RespLinkContentUrl:[NSString stringWithFormat:@"%@&shareFrom=weixin", url] title:title image:screenImage content:content];
    [self.CP_navigation clearMarkLabel];
}

- (void)sleepWeiXin{

    [self shareWeiXin:self.urlWap content:self.contentString title:self.titleString];

}

- (NSString *)urlFaxqFunc{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString * nameDict = [infoDict objectForKey:@"CFBundleDisplayName"];
//    mMessage.text = [NSString stringWithFormat:@"分享自#%@# iPhone版", nameDict];
    NSString * urlString = [NSString stringWithFormat:@"分享自#%@# iPhone版 %@~ %@&shareFrom=cmwb ", nameDict,self.titleString, self.urlWap];
    return urlString;
}

- (void)cmwbShareFunc{
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo imageWithScreenContents];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
//    publishController.lotteryID = self.BetDetailInfo.programNumber;
    publishController.infoShare = YES;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.faxqUlr = [self urlFaxqFunc];
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated:YES completion:^{}];
    [publishController release];
    [nav release];
    
    [self.CP_navigation clearMarkLabel];
}




- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *result = [[[request URL] query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"resultxxxxxxxxxxxxxxxxxxxxxx = %@", [request URL]);
    NSString * strRequest = [NSString stringWithFormat:@"%@", [request URL] ];

    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        ylReturn = YES;
    }
    if ([strRequest rangeOfString:@"caipiao365index.com"].location != NSNotFound) {
        if (delegate && [delegate respondsToSelector:@selector(myWebView:Request:)]) {
            [delegate myWebView:webView Request:request];
        }

    }
    if([strRequest rangeOfString:@"caipiao365login.com"].location != NSNotFound){
        
        NSString *parameter = nil;
        NSArray *arr = [strRequest componentsSeparatedByString:@"?"];
        if(arr.count >= 2){
        
            parameter = [NSString stringWithFormat:@"%@",[arr objectAtIndex:1]];
        }
        
    
        if(delegate && [delegate respondsToSelector:@selector(myWebView:needReloadRequest:withParameter:)]){
        
            [delegate myWebView:webView needReloadRequest:request withParameter:parameter];
        }
    }
    if ([strRequest hasPrefix:@"itms-app"]) {
        strRequest = [strRequest stringByReplacingOccurrencesOfString:@"itms-appss://" withString:@"itms-apps://" ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strRequest]];
        return NO;
    }
    
    if([strRequest hasPrefix:@"http://share.weixin.caipiao365.com"]){//微信分享 h5
        
//        http://share.weixin.caipiao365.com/?backUrl=http://h5.zcw.com/sale/productDetails.jsp?id=198&title=%E5%BF%97%E5%BC%BA%E5%86%85%E8%A1%A3%E4%B8%80%E7%BA%A7%E6%A3%92~%EF%BC%81%20%E5%BF%97%E5%BC%BA%E5%86%85%E8%A1%A3&content=
        
        
        strRequest = [strRequest stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * urlString = [strRequest stringByReplacingOccurrencesOfString:@"http://share.weixin.caipiao365.com/?" withString:@""];
        NSArray * urlArray = [urlString componentsSeparatedByString:@"&"];
        
        self.urlWap = @"";
        self.titleString = @"";
        self.contentString = @"";
        for (int i = 0; i < [urlArray count]; i++) {
            if ([[urlArray objectAtIndex:i] hasPrefix:@"backUrl="]) {
                self.urlWap = [urlArray objectAtIndex:i];
                self.urlWap = [self.urlWap stringByReplacingOccurrencesOfString:@"backUrl=" withString:@""];
            }
            if ([[urlArray objectAtIndex:i] hasPrefix:@"title="]) {
                self.titleString = [urlArray objectAtIndex:i];
                self.titleString = [self.titleString stringByReplacingOccurrencesOfString:@"title=" withString:@""];
//                self.titleString = [self.titleString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            if ([[urlArray objectAtIndex:i] hasPrefix:@"content="]) {
                self.contentString = [urlArray objectAtIndex:i];
                self.contentString = [self.contentString stringByReplacingOccurrencesOfString:@"content=" withString:@""];
//                self.contentString = [self.contentString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                self.contentString = [self.contentString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }
        
        [self performSelector:@selector(sleepWeiXin) withObject:nil afterDelay:0.5];

        
        return NO;
    }
    
    if([strRequest hasPrefix:@"http://share.cpwb.caipiao365.com"]){//彩民微博分享 h5
        
//        http://share.cpwb.caipiao365.com/?backUrl=http://h5123.cmwb.com/sale/productDetails.jsp?id=42&title=%E4%B8%83%E5%8C%B9%E7%8B%BC%202015%E5%A4%8F%E5%AD%A3%E7%BF%BB%E9%A2%86T%E6%81%A4%E7%94%B7%E8%A3%85&content=
        strRequest = [strRequest stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * urlString = [strRequest stringByReplacingOccurrencesOfString:@"http://share.cpwb.caipiao365.com/?" withString:@""];
        NSArray * urlArray = [urlString componentsSeparatedByString:@"&"];
        
        self.urlWap = @"";
        self.titleString = @"";
        self.contentString = @"";
        
        for (int i = 0; i < [urlArray count]; i++) {
            if ([[urlArray objectAtIndex:i] hasPrefix:@"backUrl="]) {
                self.urlWap = [urlArray objectAtIndex:i];
                self.urlWap = [self.urlWap stringByReplacingOccurrencesOfString:@"backUrl=" withString:@""];
            }
            if ([[urlArray objectAtIndex:i] hasPrefix:@"title="]) {
                self.titleString = [urlArray objectAtIndex:i];
                self.titleString = [self.titleString stringByReplacingOccurrencesOfString:@"title=" withString:@""];
            }
            if ([[urlArray objectAtIndex:i] hasPrefix:@"content="]) {
                self.contentString = [urlArray objectAtIndex:i];
                self.contentString = [self.contentString stringByReplacingOccurrencesOfString:@"content=" withString:@""];
            }
        }
        [self performSelector:@selector(cmwbShareFunc) withObject:nil afterDelay:0.5];
        return NO;

    }
    if([strRequest rangeOfString:@"http://cp.recharge.com/czlb"].location != NSNotFound){//彩民微博分享 h5
        GC_TopUpViewController *info = [[GC_TopUpViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        return NO;
    }
    
    
    return YES;
}
-(void)cancelLoadView
{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _reloading = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _reloading = NO;
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelLoadView) object:nil];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mywebView.scrollView];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    _reloading = NO;
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelLoadView) object:nil];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mywebView.scrollView];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    NSURLRequest *request1 =[NSURLRequest requestWithURL:mywebView.request.URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [mywebView loadRequest:request1];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}

-(void)doExit
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [bgview release];
    [mywebView release];
    [super dealloc];

}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  CommonProblemViewController.m
//  Experts
//
//  Created by V1pin on 15/11/12.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "CommonProblemViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"

@interface CommonProblemViewController ()

@end

@implementation CommonProblemViewController

@synthesize commonRequest;

- (void)dealloc
{
    [self.commonRequest clearDelegatesAndCancel];
    self.commonRequest = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavView];
    
    _webView = [[UIWebView alloc] init];
    if ([_sourceFrom isEqualToString:@"experCon"]) {
        [_webView setFrame:CGRectMake(0, 4, MyWidth, MyHight - 4)];
    }else if ([_sourceFrom isEqualToString:@"purchasePlanDeal"]||[_sourceFrom isEqualToString:@"commonProblem"]){
        [_webView setFrame:CGRectMake(0, 0, MyWidth, MyHight)];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
            [_webView setFrame:CGRectMake(0, -10, MyWidth, MyHight)];
        }
    }
#if defined DONGGEQIU
    else if([_sourceFrom isEqualToString:@"shouye"]){
        [_webView setFrame:CGRectMake(0, 4, MyWidth, MyHight - 4)];
    }
#endif
    else
        [_webView setFrame:CGRectMake(0, 40, MyWidth, MyHight - 40)];
    [self.view addSubview:_webView];
    
    [self.view bringSubviewToFront:self.navView];
    
    NSURL *url=nil;
    if ([_sourceFrom isEqualToString:@"expertCategory"]) {
        self.title_nav = @"服务协议";
#ifdef YUCEDI
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjfw.html",WEBURLHOST]];
#elif defined DONGGEQIU
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjfw.html",WEBURLHOST]];
#elif defined CRAZYSPORTS
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjxy.shtml",WEBURLHOST]];
#else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/module/zjtj/zjxy.shtml",PUBLICURL]];
#endif
        
//#if !defined YUCEDI && !defined DONGGEQIU
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/module/zjtj/zjxy.shtml",PUBLICURL]];
//#else
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjfw.html",WEBURLHOST]];
//#endif

    }else if([_sourceFrom isEqualToString:@"commonProblem"]){
        self.title_nav = @"常见问题";
#ifdef YUCEDI
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cjwt.html",WEBURLHOST]];
#elif defined DONGGEQIU
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cjwt.html",WEBURLHOST]];
#elif defined CRAZYSPORTS
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjtjcjwt.shtml",WEBURLHOST]];
#else
    url = [NSURL URLWithString:@"http://cpapi.diyicai.com/api/help.html"];
//        [self.commonRequest clearDelegatesAndCancel];
//        self.commonRequest = [ASIHTTPRequest requestWithURL:[NetURL expertCommonProblem]];
//        [commonRequest setTimeOutSeconds:20.0];
//        [commonRequest setDidFinishSelector:@selector(commonRequestFinish:)];
//        [commonRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [commonRequest setDelegate:self];
//        [commonRequest startAsynchronous];
#endif
//#if !defined YUCEDI && !defined DONGGEQIU
//        [self.commonRequest clearDelegatesAndCancel];
//        self.commonRequest = [ASIHTTPRequest requestWithURL:[NetURL expertCommonProblem]];
//        [commonRequest setTimeOutSeconds:20.0];
//        [commonRequest setDidFinishSelector:@selector(commonRequestFinish:)];
//        [commonRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [commonRequest setDelegate:self];
//        [commonRequest startAsynchronous];
//#else
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cjwt.html",WEBURLHOST]];
//#endif
    }
    else if([_sourceFrom isEqualToString:@"sd_commonProblem"]){
        self.title_nav = @"常见问题";
#ifdef YUCEDI
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cjwt.html",WEBURLHOST]];
#elif defined DONGGEQIU
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cjwt.html",WEBURLHOST]];
#elif defined CRAZYSPORTS
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/sdcjwt.shtml",WEBURLHOST]];
#else
        [self.commonRequest clearDelegatesAndCancel];
        self.commonRequest = [ASIHTTPRequest requestWithURL:[NetURL expertCommonProblem]];
        [commonRequest setTimeOutSeconds:20.0];
        [commonRequest setDidFinishSelector:@selector(commonRequestFinish:)];
        [commonRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [commonRequest setDelegate:self];
        [commonRequest startAsynchronous];
#endif
    }
    else if ([_sourceFrom isEqualToString:@"experCon"]){
        self.title_nav = @"活动";
        url = [NSURL URLWithString:_nsUrl];
    }
    else if([_sourceFrom isEqualToString:@"purchasePlanDeal"]){
        self.title_nav = @"购买协议";
#ifdef YUCEDI
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cpzj.html",WEBURLHOST]];
#elif defined DONGGEQIU
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cpzj.html",WEBURLHOST]];
#elif defined CRAZYSPORTS
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjgmxy.shtml",WEBURLHOST]];
#else
        url=[NSURL URLWithString:@"http://www.yuecai365.com/goumaixy.shtml"];
#endif
//#if !defined YUCEDI && !defined DONGGEQIU
//        url=[NSURL URLWithString:@"http://www.yuecai365.com/goumaixy.shtml"];
//#elif defined CRAZYSPORTS
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/zjgmxy.shtml",WEBURLHOST]];
//#else
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cpzj.html",WEBURLHOST]];
//#endif
    }
    else if([_sourceFrom isEqualToString:@"sd_purchasePlanDeal"]){
        self.title_nav = @"购买协议";
#ifdef YUCEDI
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cpzj.html",WEBURLHOST]];
#elif defined DONGGEQIU
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/cpzj.html",WEBURLHOST]];
#elif defined CRAZYSPORTS
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xieyi/sdgmxy.shtml",WEBURLHOST]];
#else
        url=[NSURL URLWithString:@"http://www.yuecai365.com/goumaixy.shtml"];
#endif
    }
#if defined DONGGEQIU
    else if([_sourceFrom isEqualToString:@"shouye"]){
        url = [NSURL URLWithString:_nsUrl];
    }
#endif
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        //锁子把web锁住
        [[[_webView subviews] objectAtIndex:0]setBounces:NO];
    }
}

- (void)commonRequestFinish:(ASIHTTPRequest *)ssrequest {
    if (ssrequest.responseString && ssrequest.responseString.length) {
        NSURL * url = [NSURL URLWithString:ssrequest.responseString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        //锁子把web锁住
        [[[_webView subviews] objectAtIndex:0]setBounces:NO];
    }
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
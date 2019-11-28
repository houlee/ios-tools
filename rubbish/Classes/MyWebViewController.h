//
//  MyWebViewController.h
//  caibo
//
//  Created by yao on 11-12-14.
//  Copyright 2011 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "UpLoadView.h"
#import "EGORefreshTableHeaderView.h"

@interface MyWebViewController : CPViewController <UIWebViewDelegate,EGORefreshTableHeaderDelegate>{
	UIWebView *mywebView;
    UpLoadView *loadview;
    id delegate;
    BOOL isHaveTab;
    BOOL hiddenNav;
    NSString *webTitle;
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL islicai;
    
    BOOL isTMC;//365特卖场
    UIImageView *bgview;
    
    BOOL needPopSupController;//点击返回直接回H5主页
    BOOL ylReturn;//娱乐点击返回直接回H5主页后，再返回客户端
    
    BOOL directReturn;//直接返回上一页
    NSURL *requestUrl;
    NSString * urlWap ;
    NSString * titleString;
    NSString * contentString;
    BOOL _reloading;
    BOOL showExit;
}
@property (nonatomic, assign)id delegate;
@property (nonatomic) BOOL isHaveTab,hiddenNav,islicai,isTMC,needPopSupController, directReturn, showExit;
@property (nonatomic, copy) NSString *webTitle, *urlWap,*titleString,*contentString;
@property (nonatomic, copy) NSURL *requestUrl;
@property (nonatomic) BOOL canShareToWX;//支付微信分享
@property (nonatomic, copy) NSString *shareUrl;//分享链接
@property (nonatomic, copy) NSString *shareTitle;//分享标题

- (void)LoadRequst:(NSURLRequest *)request;

@end

@protocol MyWebViewDelegate <NSObject>
@optional

- (void)myWebView:(UIWebView *)webView Request:(NSURLRequest *)request;

- (void)myWebView:(UIWebView *)webView needReloadRequest:(NSURLRequest *)request withParameter:(NSString *)_string;

@end



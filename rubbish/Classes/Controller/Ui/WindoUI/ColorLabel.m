//
//  ColorLabel.m
//  caibo
//
//  Created by jeff.pluto on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ColorLabel.h"
#import "StringUtil.h"
#import "ColorUtils.h"
#import "Info.h"
#import "ProfileViewController.h"
#import "RegexKitLite.h"
#import "NSStringExtra.h"
#import "DetailedViewController.h"
#import "TopicThemeListViewController.h"
#import "MyProfileViewController.h"
#import "caiboAppDelegate.h"
#import "LoginViewController.h"
#import "KJXiangQingViewController.h"
#import "HomeViewController.h"
#import "YtTopic.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "SharedDefine.h"

@implementation ColorLabel

@synthesize mText;
@synthesize colorLabeldelegate;
@synthesize homebool, reyibool;
@synthesize mRequest;

//static NSString *LinkMan = @"@.*?\\s";
//static NSString *Topic = @"#.*?#";
//static NSString *Http = @"http://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";

- (void) onMeasure {
    if (!mText || [mText isEqualToString:@""]) {
        return;
    }
    
    finalStr = [mText flattenPartHTML:mText];
    NSLog(@"finalstr = %@", finalStr);
    CGSize constraint = CGSizeMake(mMaxWidth, 580.0);
    CGSize size = [finalStr sizeWithFont:[UIFont systemFontOfSize:20.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(0, 0, mMaxWidth, size.height);
    
}

- (void) onMeasuretwo {
    if (!mText || [mText isEqualToString:@""]) {
        return;
    }
    
    finalStr = [mText flattenPartHTML:mText];
    NSLog(@"finalstr = %@", finalStr);
    CGSize constraint = CGSizeMake(mMaxWidth, 480.0);
    CGSize size = [finalStr sizeWithFont:[UIFont systemFontOfSize:10.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(0, 0, mMaxWidth, size.height);
}

- (id)initWithText:(NSString *)txt ytTopic:(YtTopic *)topic
{
    if ((self = [super init])) {
        myYtTopic = topic;
        [self initWithText:txt];
    }
    return self;
}

-(id)initWithText:(NSString *)txt hombol:(BOOL)hobl ytTopic:(YtTopic *)topic
{
    if ((self = [super init])) {
        myYtTopic = topic;
        [self initWithText:txt hombol:hobl];
    }
    return self;
}

-(void)setText:(NSString *)txt hombol:(BOOL)hobl ytTopic:(YtTopic *)topic
{
    myYtTopic = topic;
    self.colorLabeldelegate = topic;
    [self setText:txt hombol:hobl];
}


- (id) initWithText : (NSString *) txt{
    if ((self = [super init])) {
        [self setOpaque:NO];
        [self setDelegate:self];
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor: [UIColor clearColor]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
            self.scrollView.scrollEnabled = NO;
        }
        [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
        
        [self setMText:txt];
//        [self onMeasure];
        [self loadHTMLString:mText baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    return self;

}

- (id) initWithTextReyi: (NSString *) txt tihuanhuati:(NSString *)huati name:(NSString *)namestr{
    if ((self = [super init])) {
        [self setOpaque:NO];
        [self setDelegate:self];
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor: [UIColor clearColor]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
            self.scrollView.scrollEnabled = NO;
        }
        [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
        
        [self setMText:txt];
        [self onMeasuretwo];
        mText = [mText stringByReplacingOccurrencesOfString:huati withString:@""];
        mText = [NSString stringWithFormat:@"%@:%@", namestr, mText];
     
        
        [self loadHTMLString:mText baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
    }
    return self;
    
}

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    [[UIColor redColor] set];
//}


- (id) initWithText:(NSString *)txt hombol:(BOOL)hobl{
    if ((self = [super init])) {
        [self setText:txt hombol:hobl];
    }
    return self;
}

- (float)getHtmlHeight
{
    NSString *ret  = [self stringByEvaluatingJavaScriptFromString:@"getHeight();"];
    return [ret floatValue];
}

-(void)setText:(NSString *)txt hombol:(BOOL)hobl
{
    homebool = hobl;
    [self setOpaque:NO];
    [self setDelegate:self];
    [self setUserInteractionEnabled:YES];
//    [self setBackgroundColor: [UIColor yellowColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
        self.scrollView.scrollEnabled = NO;
    }
    [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
    
    [self setMText:txt];
//    [self onMeasure];
//    NSString *webviewText = @"<style>body{margin:5;word-wrap:break-word;word-break:break-all;-webkit-tap-highlight-color:rgba(0,0,0,0);}a{text-decoration:none}</style>";
//    webviewText = [webviewText stringByAppendingString:[NSString stringWithFormat:@"<div onclick=\"window.location='native://gotoDetail?id=%d'\">",self.tag]];
//    NSString *htmlString = [webviewText stringByAppendingFormat:@"%@</div>", mText];
    
    NSString *webviewText = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html><head><meta charset=\"utf-8\" /><style>body{margin:5;word-wrap:break-word;word-break:break-all;-webkit-tap-highlight-color:rgba(0,0,0,0);}a{text-decoration:none}</style><script>function getHeight(){return document.documentElement.offsetHeight;}</script></head><body>";

    
//    NSString *webviewText = @"<style>body{margin:5;word-wrap:break-word;word-break:break-all;-webkit-tap-highlight-color:rgba(0,0,0,0);}a{text-decoration:none}</style><script>function getHeight(){return document.documentElement.offsetHeight;}</script><body>";
    webviewText = [webviewText stringByAppendingString:[NSString stringWithFormat:@"<div onclick=\"window.location='native://gotoDetail?id=%d'\">",(int)self.tag]];
    NSString *htmlString = [webviewText stringByAppendingFormat:@"%@</div></body></html>", mText];
    
    [self loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [self setHidden:YES];

}

// 设置最大宽度
- (void) setMaxWidth:(int)maxWidth {
    mMaxWidth = maxWidth;
    [self onMeasure];
    
}

- (void)webViewDidFinishLoad:(UIWebView *) webView {
//    [webView reload];
    
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];

//    if (self.mText && [self.mText length]) {
//        CGSize actualSize = [webView sizeThatFits:CGSizeZero];
//        CGRect newFrame = webView.frame;
//        newFrame.size.height = actualSize.height;
//        webView.frame = newFrame;
//    }
//    

    UIView *mParent = (UIView *) (self.superview);
    if ([mParent respondsToSelector:@selector(onMeasure)]) {
        [mParent performSelector:@selector(onMeasure)];
    }

    [self setHidden:NO];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        canPush = YES;

        NSString *result = [[[request URL] query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"result = %@", [request URL]);
        NSString * strrequ = [NSString stringWithFormat:@"%@", [request URL] ];
        if([strrequ hasPrefix:@"tel:"]){
            return YES;
        }
        Info *info = [Info getInstance];
        if (![info.userId intValue]) {
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
            LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
            [loginVC setHidesBottomBarWhenPushed:YES];
            [loginVC setIsShowDefultAccount:YES];
            
            if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                [[HomeViewController getShareHomeViewController].navigationController pushViewController:loginVC animated:YES];
            }else{
                [[DetailedViewController getShareDetailedView].navigationController pushViewController:loginVC animated:YES];
            }
#endif
            if ([mText rangeOfString:@">链接<"].location != NSNotFound) {
                canPush = NO;
                return NO;
            }
            return YES;
        }
        
        if ([result hasPrefix:@"wd="]) {
            NSString *name = [result substringFromIndex:3];
            NSLog(@"colorLabel:name:%@",name);
         //   name = [NSString stringWithFormat:@"%@+", name];
            // @功能
            NSString * ccc = [NSString stringWithFormat:@"%@", [request URL]];
            NSString * sss = @"gotoMention";
            if ([name hasSuffix:@"+"]) {
                name = [name substringToIndex:[name length] - 1];

                    if ([name isEqualToString:[[Info getInstance] nickName]]) {
                        MyProfileViewController *myProfileVC = [[[MyProfileViewController alloc] initWithType:1] autorelease];
                        myProfileVC.homebool = homebool;
                        myProfileVC.title = @"资料";
                        if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                            [[HomeViewController getShareHomeViewController].navigationController pushViewController:myProfileVC animated:YES];
                        }else{
                            [[DetailedViewController getShareDetailedView].navigationController pushViewController:myProfileVC animated:YES];
                        }
                        
                    } else {
                        [[Info getInstance] setHimId:nil];
                        Info *info = [Info getInstance];
                        if ([info.userId intValue]) {
                            ProfileViewController *followeesController = [[[ProfileViewController alloc] init] autorelease];
                            followeesController.homebool = homebool;
                            followeesController.title = [NSString stringWithFormat:@"%@", name];
                            if([name hasPrefix:@"@"]){
                            
                                name = [name substringFromIndex:1];
                            }
                            [followeesController setHimNickName:name];
                            
                            if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                                [[HomeViewController getShareHomeViewController].navigationController pushViewController:followeesController animated:YES];
                            }else{
                                [[DetailedViewController getShareDetailedView].navigationController pushViewController:followeesController animated:YES];
                            }
                        }
                    }

                
            }else
            
            
            if ([ccc rangeOfString:sss].location != NSNotFound) {
          //  if ([name hasSuffix:@"+"]) {
          //      name = [name substringToIndex:[name length] - 1];
                if ([name isEqualToString:[[Info getInstance] nickName]]) {
                    MyProfileViewController *myProfileVC = [[[MyProfileViewController alloc] initWithType:1] autorelease];
                    myProfileVC.homebool = homebool;
                    myProfileVC.title = @"资料";
                    if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                        [[HomeViewController getShareHomeViewController].navigationController pushViewController:myProfileVC animated:YES];
                    }else{
                        [[DetailedViewController getShareDetailedView].navigationController pushViewController:myProfileVC animated:YES];
                    }
                } else {
                    [[Info getInstance] setHimId:nil];
                    Info *info = [Info getInstance];
                    
                    NSLog(@"result = %@",result);
                    if ([info.userId intValue]) {
                    ProfileViewController *followeesController = [[[ProfileViewController alloc] init] autorelease];
                        followeesController.homebool = homebool;
                    NSLog(@"%@", name);
                    followeesController.title = [NSString stringWithFormat:@"%@", name];
                    [followeesController setHimNickName:name];
                        if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                            [[HomeViewController getShareHomeViewController].navigationController pushViewController:followeesController animated:YES];
                        }else{
                            [[DetailedViewController getShareDetailedView].navigationController pushViewController:followeesController animated:YES];
                        }
                        
                    }else{
#ifdef isCaiPiaoForIPad
                        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
                        LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
                        [loginVC setHidesBottomBarWhenPushed:YES];
                        [loginVC setIsShowDefultAccount:YES];
                        
                        if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                            [[HomeViewController getShareHomeViewController].navigationController pushViewController:loginVC animated:YES];
                        }else{
                            [[DetailedViewController getShareDetailedView].navigationController pushViewController:loginVC animated:YES];
                        }
#endif

                    
                    }
                }
            } else {
                // 话题功能

                name = [NSString stringWithFormat:@"#%@#", name];
                TopicThemeListViewController *topicThemeListVC = [[[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance]userId] themeId:nil themeName:name homebol:homebool] autorelease];
                topicThemeListVC.homebool = homebool;
                topicThemeListVC.navigationItem.title = name;
                if (reyibool) {
                    
                    [[KJXiangQingViewController getShareDetailedView].navigationController pushViewController:topicThemeListVC animated:YES];

                }else{
                    if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                        [[HomeViewController getShareHomeViewController].navigationController pushViewController:topicThemeListVC animated:YES];
                    }else{
                        [[DetailedViewController getShareDetailedView].navigationController pushViewController:topicThemeListVC animated:YES];
                    }
                }
            }
        }
		else if ([result hasPrefix:@"themeName="]) {
			// 话题功能
			 NSString *name = [result substringFromIndex:10];
             name = [NSString stringWithFormat:@"#%@#", name];
			TopicThemeListViewController *topicThemeListVC = [[[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance]userId] themeId:nil themeName:name homebol:homebool] autorelease];
            topicThemeListVC.homebool = homebool;
			topicThemeListVC.navigationItem.title = name;
            
            if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                [[HomeViewController getShareHomeViewController].navigationController pushViewController:topicThemeListVC animated:YES];
            }else{
                [[DetailedViewController getShareDetailedView].navigationController pushViewController:topicThemeListVC animated:YES];
            }
		}
		else if ([result hasPrefix:@"userid="]) {
            NSString *userId = [result substringFromIndex:7];
            [[Info getInstance] setHimId:userId];
            
            ProfileViewController *followeesController = [[[ProfileViewController alloc] init] autorelease];
            followeesController.homebool = homebool;
            [followeesController setHimNickName:nil];
            
            if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                [[HomeViewController getShareHomeViewController].navigationController pushViewController:followeesController animated:YES];
            }else{
                [[DetailedViewController getShareDetailedView].navigationController pushViewController:followeesController animated:YES];
            }
        }
        else if ([[[request URL] description] hasPrefix:@"http://caipiao365.com/faxq="]) {
            NSString * prefixStr = @"http://caipiao365.com/faxq=";
            
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [[[request URL] description] substringFromIndex:[prefixStr length]];
            UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
            [info.navigationController setNavigationBarHidden:NO];
            
            [NV pushViewController:info animated:YES];
            [info release];
        }
		else {
			if (colorLabeldelegate) {
				[colorLabeldelegate clikeOrderIdURL:request];
			}
		}
        canPush = NO;

//        [self performSelector:@selector(changeCanPush) withObject:nil afterDelay:1];
        return NO;
    }
    else if ([[[request URL] description] hasPrefix:@"native://gotoDetail?id="])
    {
        NSString * idString = [[[request URL] query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        if (canPush) {
            if ([[idString substringFromIndex:3] integerValue] == weiBo_GuangChang_YuanTieTag) {
                [mRequest clearDelegatesAndCancel];
                if ([myYtTopic.orignalText rangeOfString:@"抱歉，此微博已被删除。如需帮助，请联系客服。"].location != NSNotFound) {
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:myYtTopic.topicid]];
                }else{
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:myYtTopic.orignal_id]];
                }
                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [mRequest setDelegate:self];
                [mRequest setDidFinishSelector:@selector(requestDidFinishSelector:)];
                [mRequest setNumberOfTimesToRetryOnTimeout:2];
                [mRequest setShouldContinueWhenAppEntersBackground:YES];
                [mRequest startAsynchronous];
            }else{
                if ([webView.superview isKindOfClass:[HomeDetailedView class]]) {
                    if (myYtTopic.reRequest) {
                        [mRequest clearDelegatesAndCancel];
                        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:myYtTopic.topicid]];
                        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                        [mRequest setDelegate:self];
                        [mRequest setDidFinishSelector:@selector(requestDidFinishSelector:)];
                        [mRequest setNumberOfTimesToRetryOnTimeout:2];
                        [mRequest setShouldContinueWhenAppEntersBackground:YES];
                        [mRequest startAsynchronous];
                    }else{
                        
                        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
                        
                        DetailedViewController *detailed = [[[DetailedViewController alloc] initWithMessage:myYtTopic] autorelease];
                        [detailed setHidesBottomBarWhenPushed:YES];
                        [(UINavigationController *)app.window.rootViewController pushViewController:detailed animated:YES];
                        
//                        [[HomeViewController getShareHomeViewController].navigationController pushViewController:detailed animated:YES];

                    }
                }
            }
        }
    }
    canPush = YES;

    return YES;
}


-(void)requestDidFinishSelector:(ASIHTTPRequest *)mrequest{
    
    NSString *result = [mrequest responseString];
    YtTopic * orignalYtTopic = [[[YtTopic alloc] initWithParse:result] autorelease];
    YtTopic * orignalYtTopic1 = [orignalYtTopic.arrayList objectAtIndex:0];

    DetailedViewController *detailed = [[[DetailedViewController alloc] initWithMessage:orignalYtTopic1] autorelease];
    if (homebool) {
        detailed.homebool = YES;
    }else{
        detailed.homebool = NO;
    }
    [detailed setHidesBottomBarWhenPushed:YES];
    [[HomeViewController getShareHomeViewController].navigationController pushViewController:detailed animated:YES];
}

- (void)dealloc {
    [mText release];
    [mRequest clearDelegatesAndCancel];
    self.mRequest = nil;
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
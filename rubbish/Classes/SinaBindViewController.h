//
//  SinaBindViewController.h
//  caibo
//
//  Created by yao on 12-3-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNick_NameViewController.h"
#import "CPViewController.h"

@interface SinaBindViewController : CPViewController<UIWebViewDelegate> {
	UIWebView *myWebView;
	NSURL *sinaURL;
	BOOL isBangDing;//是绑定还是第三方登录
    UnNitionLoginType unNitionLoginType;
}

@property (nonatomic,copy)NSURL *sinaURL;
@property (nonatomic,assign)BOOL isBangDing;//是绑定还是第三方登录
@property (nonatomic)UnNitionLoginType unNitionLoginType;
+(NSString *)EncryptWithMD5:(NSString*)str;
@end

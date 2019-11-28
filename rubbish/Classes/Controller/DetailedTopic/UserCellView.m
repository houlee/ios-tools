//
//  UserCellView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserCellView.h"
#import "UIImageExtra.h"
#import "ImageDownloader.h"
#import "ProfileViewController.h"
#import "Info.h"
#import "MyProfileViewController.h"
#import "DetailedViewController.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "JSON.h"

@interface UserCellView ()
+ (UIImage*)defaultBackgroundImage;
+ (UIImage*)getPointImage;
@end

@implementation UserCellView

@synthesize mUserInfo;
@synthesize mUserFace;
@synthesize ishome;
@synthesize myRequest;
@synthesize passWord;

static UIImage *background = nil, *pointR;

- (id) initWithUserInfo:(YtTopic *)userInfo homebool:(BOOL)homeb {
//    if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 51)])) {
    if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 64)])) {
        self.backgroundColor = [UIColor clearColor];

//        userID = userInfo.userid;
//        hisNickName = userInfo.nick_name;
        
#ifdef isCaiPiaoForIPad
        self.frame = CGRectMake(35, 0, 320, 51);
#endif
        [self setMUserInfo:userInfo];
        ishome = homeb;
        receiver = [[ImageStoreReceiver alloc] init];
        
        receiver.imageContainer = self;// 保存该接收器回调更新图片
        
        if (userInfo.mid_image) {
            if (imageUrl != userInfo.mid_image) {
                [imageUrl release];
            }
            imageUrl = [userInfo.mid_image copy];
            
            self.mUserFace = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver Big:NO];
#ifdef isGuanliyuanBanben
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(160, 10, 60, 30);
            [self addSubview:btn1];
            btn1.backgroundColor = [UIColor whiteColor];
            [btn1 setTitle:@"用户信息" forState:UIControlStateNormal];
            btn1.titleLabel.font = [UIFont systemFontOfSize:11];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(getUserInfo) forControlEvents:UIControlEventTouchUpInside];
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame = CGRectMake(230, 10, 60, 30);
            [self addSubview:btn2];
            btn2.backgroundColor = [UIColor whiteColor];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 setTitle:@"删除用户" forState:UIControlStateNormal];
            btn2.titleLabel.font = [UIFont systemFontOfSize:11];
            [btn2 addTarget:self action:@selector(deleteUser) forControlEvents:UIControlEventTouchUpInside];
#endif
        }
    }
    return self;
}

// 用户信息
- (void)getUserInfo {
//    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
//    textF.placeholder = @"请输入管理员密码";
//    textF.tag = 201;
//    textF.autocorrectionType = UITextAutocorrectionTypeYes;
//    textF.secureTextEntry = YES;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"要查看用户身份信息,请输入密码" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//    alert.tag = 111;
//    [alert show];
//    [alert addSubview:textF];
//    textF.backgroundColor = [UIColor whiteColor];
//    [alert release];
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请输入管理员密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 111;
    [alert show];
    [alert release];
}

//删除用户
- (void)deleteUser {
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请输入管理员密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 112;
    [alert show];
    [alert release];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (buttonIndex == 1) {
        self.passWord = message;
//        UITextField *text = (UITextField *)[alertView viewWithTag:201];
        if ([self.passWord length] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入密码"];
            return;
        }
        if (alertView.tag == 111) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL getUserInfo:self.mUserInfo.userid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recieveUserInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
        if (alertView.tag == 112) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteUserUserid:self.mUserInfo.userid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recieveDeleteInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
    }
}

// alete代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
//        UITextField *text = (UITextField *)[alertView viewWithTag:201];
        if ([self.passWord length] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入密码"];
            return;
        }
        if (alertView.tag == 111) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL getUserInfo:self.mUserInfo.userid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recieveUserInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
        if (alertView.tag == 112) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteUserUserid:self.mUserInfo.userid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recieveDeleteInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
    }
}

#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

- (void)recieveUserInfo:(ASIHTTPRequest *)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    if ([[dic objectForKey:@"code"] isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"用户名:%@ \n id:%@\n注册时间：%@\n余额:%@\n注册来源：%@",[dic objectForKey:@"user_name"],[dic objectForKey:@"nick_name"],[dic objectForKey:@"date_created"],[dic objectForKey:@"fee"],[dic objectForKey:@"Register_source"]] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else {
        [[caiboAppDelegate getAppDelegate] showMessage:[dic objectForKey:@"获取失败"]];
    }
    
}

- (void)recieveDeleteInfo:(ASIHTTPRequest *)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    [[caiboAppDelegate getAppDelegate] showMessage:[dic objectForKey:@"msg"]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[caiboAppDelegate getAppDelegate] showMessage:@"请求失败"];
}

// 图片下载完成后回调更新图片
- (void)updateImage:(UIImage*)image {
    self.mUserFace = image;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {
    [[UserCellView defaultBackgroundImage] drawInRect:rect];
    
    if (mUserFace) {
		
		self.mUserFace = [mUserFace imageByScalingAndCroppingForSize:CGSizeMake(40, 40)];
//        [mUserFace drawAtPoint:CGPointMake(10, (50 - 43) / 2)];
        [mUserFace drawAtPoint:CGPointMake(12, 12)];
    }
    
    if (mUserInfo.nick_name) {
        UIFont *font = [UIFont boldSystemFontOfSize:17];
//        int strH = [mUserInfo.nick_name sizeWithFont:font].height;
        if ([mUserInfo.vip isEqualToString:@"2"]) {
            [[UIColor redColor] set];
        }else{
        
            [[UIColor blackColor] set];
        }
        
//        [mUserInfo.nick_name drawAtPoint:CGPointMake(60, (50 - strH) / 2) withFont:font];
        [mUserInfo.nick_name drawAtPoint:CGPointMake(67, 10) withFont:font];
//        [mUserInfo.timeformate drawAtPoint:CGPointMake(67, 37) withFont:[UIFont systemFontOfSize:9]];
    }
    
    int imgH = [UserCellView getPointImage].size.height;
    [[UserCellView getPointImage] drawAtPoint:CGPointMake(290, (64 - imgH) / 2)];
}

// 点击跳转到用户信息界面
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (mUserInfo.nick_name) {
        if ([mUserInfo.nick_name isEqualToString:[[Info getInstance] nickName]] || [mUserInfo.nick_name isEqualToString:@"我"]) {
            MyProfileViewController *myProfileVC = [[MyProfileViewController alloc] initWithType:1];
            myProfileVC.homebool = ishome;
            myProfileVC.myziliao = YES;//判断是不是点自己的
            [[DetailedViewController getShareDetailedView].navigationController pushViewController:myProfileVC animated:YES];
            [myProfileVC release];
        } else {
            [[Info getInstance] setHimId:nil];
            ProfileViewController *profileVC = [[ProfileViewController alloc] init];
            profileVC.homebool = ishome;
            [profileVC setHimNickName:mUserInfo.nick_name];
            profileVC.navigationItem.title = mUserInfo.nick_name;
            [[DetailedViewController getShareDetailedView].navigationController pushViewController:profileVC animated:YES];
            [profileVC release];
        }
    }
}

+ (UIImage *) defaultBackgroundImage {
    if (background == nil) {
        //background = [UIImageGetImageFromName(@"userinfo_bg.png") retain];
//        background = [UIImageGetImageFromName(@"wb22.png") retain];
    
    }
    return background;
}

+ (UIImage *) getPointImage {
    if (pointR == nil) {
        pointR = [UIImageGetImageFromName(@"point.png") retain];
    }
    return pointR;
}

- (void)dealloc {
    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    self.mUserFace = nil;
    [mUserInfo release];
    
    [background release];
    [pointR release];
    background = nil;
    pointR = nil;
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
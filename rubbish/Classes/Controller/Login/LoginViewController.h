//
//  LoginViewController.h
//  caibo
//
//  Created by Kiefer on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "AddNick_NameViewController.h"

@class StatePopupView;
@class ASIHTTPRequest;
@class LunBoView;

@interface LoginViewController : CPViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate>
{ 
    UITextField *tfNickName;
    UITextField *tfPassword;
//    UISwitch *selRmbpsd;
    UIButton *btnRegister;
    UIButton *btnLogin;
    UIScrollView *imageScr;
	NSTimer *imageTimer;
	
    UIBarButtonItem *leftItem;
    StatePopupView *mStatePV;
    
    NSString *login_name;
    NSString *password;
    BOOL isRememberPsd;
    BOOL isShowDefultAccount;
    
    ASIHTTPRequest *reqLogin;
	UIAlertView *myAlert;
    int tabbool;
    
    UIImageView *backImageforiPad;
    UIImageView *textfiledbackImageforiPad;
    UIImageView *textfiledbackImageforiPad2;
    
    // 三方登陆的四个按钮
    UIButton *apliyImageView2;
    UIButton *qqImageView2;
    UIButton *sinaImageView2;
    UIButton *tXWBImageView2;
    UIButton *WxImageView2;
    
    IBOutlet UITableView *tableviewforiPad;
    UIImageView *tfNickNameBackgroundImageView;
    UIImageView *tfPasswordBackgroundImageView;
    UIImageView *FPButtonImageView;
    UIImageView *FPButtonImageView1;
    
    UIButton * userNameButton;
    UIButton * passwordButton;
    UIButton *xiaLaBtn;
    

    
    UnNitionLoginType unNitionLoginType;
    
    LunBoView * myLunBoView;
    
    BOOL isFromFlashAd;  //点击广告进入登录
    BOOL moveCount;
    UIImageView *_imageView;
    // 用户名
    
    
    
    UIImageView *imaV2;//高斯背景
    UIView *gausbackView;//高斯背景supview


}

@property(nonatomic, retain)  UITextField *tfNickName;
@property(nonatomic, retain)  UITextField *tfPassword;



//@property(nonatomic, retain) IBOutlet UITextField *tfPassword;
//@property(nonatomic, retain) IBOutlet UISwitch *selRmbpsd;
@property(nonatomic, retain) IBOutlet UIButton *btnRegister;
@property(nonatomic, retain) IBOutlet UIButton *btnLogin;
@property(nonatomic, assign) BOOL isShowDefultAccount;
@property(nonatomic, retain) ASIHTTPRequest *reqLogin;
@property (nonatomic)int tabbool;
@property(nonatomic, retain) IBOutlet UIImageView *backImageforiPad;
@property(nonatomic, retain) IBOutlet UIImageView *textfiledbackImageforiPad;
@property(nonatomic, retain) IBOutlet UIImageView *textfiledbackImageforiPad2;
@property(nonatomic, retain)NSString *login_name;

// - (IBAction)xieyiBtton:(UIButton *)sender;

@property (assign, nonatomic) IBOutlet UIImageView *tfNickNameBackgroundImageView;
@property (assign, nonatomic) IBOutlet UIImageView *tfPasswordBackgroundImageView;
// @property (retain, nonatomic) IBOutlet UIImageView *imageView;
//@property (retain, nonatomic) IBOutlet UIImageView *alipayImage;
//@property (retain, nonatomic) IBOutlet UIImageView *weiboImage;
//@property (retain, nonatomic) IBOutlet UIImageView *qqImage;
//@property (retain, nonatomic) IBOutlet UIImageView *tenImage;

//@property (assign, nonatomic) IBOutlet UIImageView *FPButtonImageView;
//@property (assign, nonatomic) IBOutlet UIImageView *FPButtonImageView1;

@property (retain, nonatomic) IBOutlet UIButton *userNameButton;
@property (retain, nonatomic) IBOutlet UIButton *passwordButton;



@property (nonatomic, assign) BOOL isFromFlashAd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil lunBoView:(LunBoView *)lunBoView;


// 注册
- (void)doRegister;
// 登录
- (void)doLogin;
// 校验输入框输入的内容
- (BOOL)doCheck;
// 默认显示最后一次登录的帐户
- (void)doShowLastAccount;

// 新浪微博登录
- (IBAction)loginBySina;
- (void)alipayLogin:(NSURL *)url;
- (void)WXLogin:(NSString *)code;

@end

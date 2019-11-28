//
//  LoginViewController.m
//  caibo
//
//  Created by Kiefer on 11-5-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "Info.h"
#import "RegisterViewController.h"
#import "LotteryPreferenceViewController.h"
#import "UserInfo.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "User.h"
#import "DataBase.h"
#import "caiboAppDelegate.h"
#import "OtherYtTopicsViewController.h"
#import "StatePopupView.h"
#import "YDDebugTool.h"
#import "SinaBindViewController.h"
#import "caiboAppDelegate.h"
#import "TextFieldUtils.h"
#import "FindPasswordViewController.h"
#import "MobClick.h"
#import "Xieyi365ViewController.h"
#import "NSStringExtra.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "WeiboSDK.h"
#import "LunBoView.h"
#import "ShuangSeQiuInfoViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ImageUtils.h"
#import "NSDate-Helper.h"
@implementation LoginViewController
{
   
    UIImageView *_alipayImage;
    UIImageView *_weiboImage;
    UIImageView *_qqImage;
    UIImageView *_tenImage;
    UIImageView *_wximage;
    UIImageView *xialaBtnImage;
}

@synthesize tfNickName;
@synthesize tfPassword;
//@synthesize selRmbpsd;
@synthesize btnRegister;
@synthesize btnLogin;
@synthesize isShowDefultAccount;
@synthesize reqLogin;
@synthesize tabbool;
@synthesize login_name;
@synthesize backImageforiPad,textfiledbackImageforiPad,textfiledbackImageforiPad2;

// @synthesize  tfPasswordBackgroundImageView;//,FPButtonImageView, FPButtonImageView1;
@synthesize userNameButton,passwordButton,tfNickNameBackgroundImageView,tfPasswordBackgroundImageView;
@synthesize isFromFlashAd;


#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 7

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        moveCount = YES;
        [self.CP_navigation setHidesBackButton:YES];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil lunBoView:(LunBoView *)lunBoView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.CP_navigation setHidesBackButton:YES];
        myLunBoView = lunBoView;
        if (myLunBoView.lunBoRunLoopRef) {
            CFRunLoopStop(myLunBoView.lunBoRunLoopRef);
            myLunBoView.lunBoRunLoopRef = nil;
        }
    }
    return self;
}

- (void)dealloc
{
    [reqLogin clearDelegatesAndCancel];
    [reqLogin release];
    [imageTimer invalidate];
	[imageTimer release];
    [tfNickName release];
    [tfPassword release];
    self.login_name = nil;
    [btnRegister release];
    [btnLogin release];
    [backImageforiPad release];
    
    [textfiledbackImageforiPad release];
    [textfiledbackImageforiPad2 release];
    [userNameButton release];
    [passwordButton release];
    [_qqImage release];
    [_alipayImage release];
    [_weiboImage release];
    [_tenImage release];
    [leftItem release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)goBackTo {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PrivateLetterBack" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    if (myLunBoView) {
        [myLunBoView performSelectorInBackground:@selector(createTimer1) withObject:nil];
    }
}

- (void)goBackToforiPad
{
	
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}


- (void)LoadiPhoneView {
    
    [self.CP_navigation setTitle:(@"登录")];
    if ([self.navigationController.viewControllers count]<=1) {
		[self.CP_navigation setLeftBarButtonItem:nil];
	}
    
		
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        leftItem = [Info backItemTarget:self action:@selector(goBackTo)];
    
        UIImageView *btnImage = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 13, 13)] autorelease];
        btnImage.image = UIImageGetImageFromName(@"backImage.png");
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 0, 80, 64);
        [btn addSubview:btnImage];
        [btn addTarget:self action:@selector(goBackTo) forControlEvents:UIControlEventTouchUpInside];
        leftItem= [[UIBarButtonItem alloc] initWithCustomView:(btn)] ;
        btn.adjustsImageWhenHighlighted = NO;
        [self.CP_navigation setLeftBarButtonItem:leftItem];
		
    
    

        self.mainView.userInteractionEnabled = YES;
        UIImageView *backImageV;
        backImageV = [[UIImageView alloc] init];
        backImageV.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243.0/255.0 alpha:1];
        backImageV.frame = self.mainView.bounds;
        backImageV.userInteractionEnabled = YES;
        backImageV.tag = 1132;
        [self.mainView addSubview:backImageV];
        backImageV.userInteractionEnabled = YES;
        [backImageV release];
        
       
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, backImageV.bounds.size.height-88, 320, 88);
        _imageView.backgroundColor = [UIColor clearColor];
        // _imageView.image = [[UIImage imageNamed:@"gp-zhucedenglu-budaijiantou_02.png"] stretchableImageWithLeftCapWidth:160 topCapHeight:117/2+25];
//        [backImageV addSubview:_imageView];
    
        
        
        [userNameButton addTarget:self action:@selector(toTfNickName) forControlEvents:UIControlEventTouchUpInside];
        [passwordButton addTarget:self action:@selector(toTfPassword) forControlEvents:UIControlEventTouchUpInside];
        
		
        
        tfNickName.frame = CGRectMake(0, 30, 320, 45);
        [tfNickName setPlaceholder:(@"绑定手机/邮箱/用户名")];
		[tfNickName setDelegate:self];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(21, 0, 54, 45)];
        UIImageView *tfNickNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 12, 20, 20)];
        tfNickNameImageView.image = [UIImage imageNamed:@"yonghuming_1.png"];
        [backView addSubview:tfNickNameImageView];
    [tfNickNameImageView release];
        tfNickName.font = [UIFont systemFontOfSize:15];
        tfNickName.leftView = backView;
    [backView release];
        tfNickName.leftViewMode = UITextFieldViewModeAlways;
        [backImageV addSubview:tfNickName];
        
        
        tfPassword.frame = CGRectMake(0, 75, 320, 45);
		[tfPassword setPlaceholder:(@"请输入您的密码")];
		[tfPassword setDelegate:self];
		[tfPassword setSecureTextEntry:YES];
        tfPassword.font = [UIFont systemFontOfSize:15];
        UIView *resBackView = [[UIView alloc] initWithFrame:CGRectMake(21, 0, 54, 45)];
        UIImageView *tfPasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 12, 20, 20)];
        [resBackView addSubview:tfPasswordImageView];
    [tfPasswordImageView release];
        tfPasswordImageView.image = [UIImage imageNamed:@"mima_1.png"];
        tfPassword.leftView = resBackView;
    [resBackView release];
        tfPassword.leftViewMode = UITextFieldViewModeAlways;
        [backImageV addSubview:tfPassword];
        
        
        UIView *line1 = [[[UIView alloc] init] autorelease];
        line1.frame = CGRectMake(0, 30, 320, 0.5);
        line1.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [backImageV addSubview:line1];
        
        UIView *line2 = [[[UIView alloc] init] autorelease];
        line2.frame = CGRectMake(15, 30+45, 305, 0.5);
        line2.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [backImageV addSubview:line2];
        UIView *line3 = [[[UIView alloc] init] autorelease];
        line3.frame = CGRectMake(0, 30+45+45, 320, 0.5);
        line3.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [backImageV addSubview:line3];
        
        
        
        
        self.btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRegister.frame = CGRectMake(15, 240, 290 , 45);
        [self.mainView addSubview:btnRegister];
        [self.btnRegister setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu_1.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10] forState:UIControlStateNormal];
        [self.btnRegister setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10] forState:UIControlStateHighlighted];
        [btnRegister setTitle:@"注 册" forState:UIControlStateNormal];
        [btnRegister addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];

        btnRegister.titleLabel.font = [UIFont systemFontOfSize:18];
       
        
        
        
        self.btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogin.frame = CGRectMake(15, 175, 290, 45);
        [btnLogin addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btnLogin];
        self.btnLogin.enabled = NO;
        [self.btnLogin setBackgroundImage:[[UIImage imageNamed:@"dengluanniu_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateNormal];
        [self.btnLogin setBackgroundImage:[[UIImage imageNamed:@"dengluanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateHighlighted];
        [btnLogin setTitle:@"登 录" forState:UIControlStateNormal];
        btnLogin.titleLabel.font = [UIFont systemFontOfSize:18];
        [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        
        
        UIButton *FPButton = [UIButton buttonWithType:UIButtonTypeCustom];
        FPButton.frame = CGRectMake(220, 138, 190, 22);
        [FPButton addTarget:self action:@selector(FindPassword) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:FPButton];
        
        UILabel *FPLabel = [[[UILabel alloc] initWithFrame:CGRectMake(12, 12, 100, 15)] autorelease];
        FPLabel.backgroundColor = [UIColor clearColor];
        FPLabel.text = @"忘记密码?";
        FPLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        FPLabel.font = [UIFont boldSystemFontOfSize:15];
        [FPButton addSubview:FPLabel];
        
        
        
        
//        UILabel *biaoZhuLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 305, 320, 22)] autorelease];
//        biaoZhuLabel.backgroundColor = [UIColor clearColor];
//        biaoZhuLabel.text = @"登陆后畅想你的彩票生活";
//        biaoZhuLabel.textAlignment = NSTextAlignmentCenter;
//        biaoZhuLabel.textColor = [UIColor colorWithRed:213/255.0 green:208/255.0 blue:197/255.0 alpha:1];
//        biaoZhuLabel.font = [UIFont systemFontOfSize:15];
//        [self.mainView addSubview:biaoZhuLabel];
    NSDate *now =[NSDate date];
    if ([[now getFormatYearMonthDayHour] doubleValue] < 2016121911) {
        return;
    }
    
        
        
        UILabel *loginWays = [[[UILabel alloc] init] autorelease];
        loginWays.frame = CGRectMake(0, self.mainView.frame.origin.y-85-8, 320, 22);
        loginWays.text = @"使用以下方式登录";
        loginWays.textAlignment = NSTextAlignmentCenter;
        loginWays.font = [UIFont systemFontOfSize:15];
        loginWays.textColor = [UIColor colorWithRed:213.0/255.0 green:208.0/255.0 blue:197.0/255.0 alpha:1];
        loginWays.backgroundColor = [UIColor clearColor];
        loginWays.userInteractionEnabled = YES;
        [self.mainView addSubview:loginWays];
    

        _imageView.backgroundColor = [UIColor whiteColor];
    
//        _imageView.image = [[UIImage imageNamed:@"gp-zhucedenglu-budaijiantou_02.png"] stretchableImageWithLeftCapWidth:160 topCapHeight:45];
    
        

        
        xiaLaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        xiaLaBtn.frame = CGRectMake(120, 0, 80, 80);
        [xiaLaBtn addTarget:self action:@selector(xiaLaBtnClick1) forControlEvents:UIControlEventTouchUpInside];
        xiaLaBtn.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        xiaLaBtn.userInteractionEnabled = NO;
        [_imageView addSubview:xiaLaBtn];
        
        xialaBtnImage = [[[UIImageView alloc] init] autorelease];
        xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-shanglajiantou_03.png"];
        xialaBtnImage.frame = CGRectMake(30.75, 9, 18.5, 13);
        [xiaLaBtn addSubview:xialaBtnImage];
    
        
        [self.mainView addSubview:_imageView];
    
//        _alipayImage = [[UIImageView alloc] init];
//        _alipayImage.image = UIImageGetImageFromName(@"alipylogsmall.png");
//        _alipayImage.frame = CGRectMake(57.5, 40, 30, 30);
    
//        _qqImage = [[UIImageView alloc] init];
//        _qqImage.frame = CGRectMake(123.5, 40, 30, 30);
//        _qqImage.image = UIImageGetImageFromName(@"qqlogsmall.png");
    
//        _weiboImage = [[UIImageView alloc] init];
//        _weiboImage.frame = CGRectMake(100.5, 40, 30, 30);
//        _weiboImage.image = UIImageGetImageFromName(@"weibologsmall.png");
    
//        _tenImage = [[UIImageView alloc] init];
//        _tenImage.image = UIImageGetImageFromName(@"tenlogsmall.png");
//        _tenImage.frame = CGRectMake(229.5, 40, 30, 30);
    
        
        _wximage = [[UIImageView alloc] initWithFrame:CGRectMake(145, 40, 30, 30)];
        _wximage.image = UIImageGetImageFromName(@"wxlogsmall.png");
        [_imageView addSubview:_wximage];
        [_wximage release];
        

        
        [_imageView addSubview:_alipayImage];
        [_imageView addSubview:_qqImage];
        [_imageView addSubview:_weiboImage];
        [_imageView addSubview:_tenImage];
        
        
        
        
//        sinaImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
        sinaImageView2.frame = CGRectMake(50, 480+180, 90, 90);
        [sinaImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-xinlangweibozhengchang_1.png"] forState:UIControlStateNormal];
        [sinaImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-xinlangweibodianji_1.png"] forState:UIControlStateHighlighted];
        [sinaImageView2 addTarget:self action:@selector(snBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        sinaImageView2.alpha = 1;
        [_imageView addSubview:sinaImageView2];
        
        
        
        WxImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        WxImageView2.frame = CGRectMake(115, 480 + 180 *3, 90, 90);
        WxImageView2.frame = CGRectMake(115, 480+180, 90, 90);
        [WxImageView2 setImage:[UIImage imageNamed:@"wxlogin.png"] forState:UIControlStateNormal];
        [WxImageView2 setImage:[UIImage imageNamed:@"wxlogin1.png"] forState:UIControlStateHighlighted];
        [WxImageView2 addTarget:self action:@selector(wxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:WxImageView2];    
        
//        tXWBImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        tXWBImageView2.frame = CGRectMake(180, 480+180, 90, 30);
        tXWBImageView2.frame = CGRectMake(100, 480 + 180 *3 + 10, 120, 22);
//        [tXWBImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxunweibozhengchang_1.png"] forState:UIControlStateNormal];
//        [tXWBImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxunweibodianji_1.png"] forState:UIControlStateNormal];
//        [tXWBImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxunweibo.png"] forState:UIControlStateNormal];
//        [tXWBImageView2 setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 1, 105)];
        [tXWBImageView2 setTitle:@"腾讯微博登录" forState:UIControlStateNormal];
        tXWBImageView2.titleLabel.textAlignment = NSTextAlignmentLeft;
        tXWBImageView2.titleLabel.font = [UIFont systemFontOfSize:17];
        [tXWBImageView2 setTitleColor:[UIColor colorWithRed:19.0/255.0 green:197.0/255 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
        [tXWBImageView2 addTarget:self action:@selector(tXWBBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:tXWBImageView2];
        
        UIImageView *txWBP = [[[UIImageView alloc] init] autorelease];
        txWBP.frame = CGRectMake(0, 1, 20, 20);
        txWBP.image = [UIImage imageNamed:@"zhucedenglu-tengxunweibo.png"];
        txWBP.backgroundColor = [UIColor clearColor];
        [tXWBImageView2 addSubview:txWBP];
        
        
        
        
//        qqImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
        qqImageView2.frame = CGRectMake(50, 480+180*2, 90 , 90);
        [qqImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxun_1.png"] forState:UIControlStateNormal];
        [qqImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxundianji_1.png"] forState:UIControlStateHighlighted];
        [qqImageView2 addTarget:self action:@selector(qqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:qqImageView2];
        
        
        
//        apliyImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        apliyImageView2.frame = CGRectMake(180, 480 + 180*2, 90, 90);
//        [apliyImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-zhifubao_1.png"] forState:UIControlStateNormal];
//        [apliyImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-zhifubodianji_1.png"] forState:UIControlStateHighlighted];
//        [apliyImageView2 addTarget:self action:@selector(apBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_imageView addSubview:apliyImageView2];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.delegate = self;
    [tapGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    
        
        if (IS_IPHONE_5) {
           // loginWays.frame = CGRectMake(0, 395-8, 320, 22);
           // biaoZhuLabel.frame = CGRectMake(0, 305, 320, 22);
            
        }else{
        
           // loginWays.frame = CGRectMake(0, self.mainView.frame.size.height -88-20, 320, 22);
           // biaoZhuLabel.frame = CGRectMake(0, self.mainView.frame.size.height-127, 320, 22);
        }
        
    
       
		[self doShowLastAccount];
       
    
}

#pragma mark -   其他方式登陆点击事件 QQ
- (void)apBtnClick:(UIButton *)btn
{
    [MobClick event:@"event_disanfangdenglu" label:@"支付宝"];
    NSLog(@" Apliay 被点了");
#ifdef isYueYuBan
    if (0 &&![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"safepay://"]] &&[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]]) {
//        [reqLogin clearDelegatesAndCancel];
//        self.reqLogin = [ASIHTTPRequest requestWithURL:[NetURL alipayCanshu]];
//        [reqLogin setTimeOutSeconds:20.0];
//        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [reqLogin setDidFinishSelector:@selector(AliPayRequestFinisher:)];
//        [reqLogin setDelegate:self];
//        [reqLogin startAsynchronous];
    }
    else {
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        
        sina.sinaURL =[NetURL CBUnitonLogin:@"4"];
        sina.title = @"支付宝登录";
        sina.unNitionLoginType = UnNitionLoginTypeAlipay;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        
    }
#else
    
    SinaBindViewController *sina = [[SinaBindViewController alloc] init];
    sina.sinaURL =[NetURL CBUnitonLogin:@"4"];
    sina.title = @"支付宝登录";
    sina.unNitionLoginType = UnNitionLoginTypeAlipay;
    [self.navigationController pushViewController:sina animated:YES];
    [sina release];
#endif
    
}

- (void)qqBtnClick:(UIButton *)btn
{
    NSLog(@" QQ 被点了！");
    [MobClick event:@"event_disanfangdenglu" label:@"QQ"];
    SinaBindViewController *sina = [[SinaBindViewController alloc] init];
    
    sina.sinaURL =[NetURL CBUnitonLogin:@"3"];
    sina.title = @"腾讯QQ登录";
    sina.unNitionLoginType = UnNitionLoginTypeQQ;
    [self.navigationController pushViewController:sina animated:YES];
    [sina release];
}

- (void)snBtnClick:(UIButton *)btn
{

    NSLog(@" SN 被点击了");
    [MobClick event:@"event_disanfangdenglu" label:@"新浪"];
    if ([WeiboSDK isWeiboAppInstalled] && [[[Info getInstance] BundleId] isEqualToString:@"com.v1.cai"]) {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kSinaAppKey];
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kSinaRedirectURI;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
        
    }
    else {
        
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBUnitonLogin:@"1"];
        sina.title = @"新浪微博登录";
        sina.unNitionLoginType = UnNitionLoginTypeSina;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
    }

}

- (void)tXWBBtnClick:(UIButton *)btn
{
    NSLog(@" WB 被点击了");
    [MobClick event:@"event_disanfangdenglu" label:@"腾讯微博"];
    SinaBindViewController *sina = [[[SinaBindViewController alloc] init] autorelease];
    sina.sinaURL =[NetURL CBUnitonLogin:@"2"];
    sina.unNitionLoginType = UnNitionLoginTypeTeng;
    sina.title = @"腾讯微博登录";
    [self.navigationController pushViewController:sina animated:YES];
    
}

- (void)wxBtnClick:(UIButton *)btn
{
    [MobClick event:@"event_disanfangdenglu" label:@"微信"];
    //构造SendAuthReq结构体
    SendAuthReq* req =[[[SendAuthReq alloc ] init ] autorelease ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    if (![WXApi isWXAppInstalled]) {
        [WXApi sendAuthReq:req
            viewController:self
                  delegate:[caiboAppDelegate getAppDelegate]];
    }
    else {
        [WXApi sendReq:req];
    }
}

#pragma mark - 使用其他方式登录事件
-(void) onReq:(BaseReq*)req{
    
}
- (void)xiaLaBtnClick1
{
    
    
    if (moveCount == YES)
    {
        
        gausbackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height-68, 320, 68)];
        [self.mainView insertSubview:gausbackView belowSubview:_imageView];
        gausbackView.backgroundColor = [UIColor clearColor];
        gausbackView.layer.masksToBounds = YES;
        [gausbackView release];
        
        CGRect rect = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
        imaV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, - self.mainView.bounds.size.height + 68, 320, self.mainView.bounds.size.height-20)];
        [gausbackView addSubview:imaV2];

        
        UIImage *image1 = [[[caiboAppDelegate getAppDelegate] JiePing] gaussianBlur];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6) {
            imaV2.image = [image1 imageFromImage:image1  inRect:CGRectMake(0, 65, rect.size.width/2, _imageView.bounds.size.height/2)];
        }
        else {
            imaV2.image = [image1 imageFromImage:image1 inRect:CGRectMake(0, 65 *2, rect.size.width, rect.size.height)];
        }
        imaV2.alpha = 1.0;
        [imaV2 release];
        [_alipayImage setHidden:YES];
        [_qqImage setHidden:YES];
        [_wximage setHidden:YES];
        [_weiboImage setHidden:YES];
        [_tenImage setHidden:YES];
        
        [ UIImageView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            _imageView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            gausbackView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            imaV2.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            _imageView.alpha = 0.80;
            sinaImageView2.alpha = 1;
        } completion:^(BOOL finished) {
            
           
        xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-xialajiantou_03.png"];
           
            
        // 新浪微博登录
        [UIImageView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            sinaImageView2.frame = CGRectMake(50, 115, 90, 90);
            
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                sinaImageView2.frame = CGRectMake(50, 113, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    sinaImageView2.frame = CGRectMake(50, 115, 90, 90);
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
        

        
        
        [UIImageView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            WxImageView2.frame = CGRectMake(115, 115, 90, 90);
            
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                WxImageView2.frame = CGRectMake(115, 113, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    WxImageView2.frame = CGRectMake(115, 115, 90, 90);
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
        
    }];
    
        
        [UIImageView animateWithDuration:0.3 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            qqImageView2.frame = CGRectMake(50, 115, 90, 90);
            
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                qqImageView2.frame = CGRectMake(50, 113, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    qqImageView2.frame = CGRectMake(50, 115, 90, 90);
                    
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
        
        
        [UIImageView animateWithDuration:0.3 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            apliyImageView2.frame = CGRectMake(180, 245, 90, 90);
           
        } completion:^(BOOL finished) {
            
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                apliyImageView2.frame = CGRectMake(180, 243, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    apliyImageView2.frame = CGRectMake(180, 245, 90, 90);
                    
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
      
        
        [UIImageView animateWithDuration:0.15 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            tXWBImageView2.frame = CGRectMake(100, 380-25, 150, 22);
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.5 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
                tXWBImageView2.frame = CGRectMake(100, 380-25, 150, 22);
            } completion:^(BOOL finished) {
                
//                [UIImageView animateWithDuration:0.2 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    tXWBImageView2.frame = CGRectMake(100, 325, 900, 20);
//                    
//                } completion:^(BOOL finished) {
//                }];
                
            }];
        }];
            
     
        moveCount = NO;
    }
    else
    {
        
        [UIImageView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (IS_IPHONE_5) {
                _imageView.frame = CGRectMake(0, self.mainView.bounds.size.height-88, 320, 88);
                gausbackView.frame = CGRectMake(0, self.mainView.bounds.size.height-88, 320, 88);
                imaV2.frame = CGRectMake(0, - self.mainView.bounds.size.height + 88, 320, self.mainView.bounds.size.height);
            }else{
                _imageView.frame = CGRectMake(0, 480-88-53, 320, 88);
            }
            
            
        } completion:^(BOOL finished) {
            [_qqImage setHidden:NO];
            [_tenImage setHidden:NO];
            [_wximage setHidden:NO];
            [_weiboImage setHidden:NO];
            [_alipayImage setHidden:NO];
            
           
            xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-shanglajiantou_03.png"];
            [UIImageView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                apliyImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                qqImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                sinaImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                tXWBImageView2.frame = CGRectMake(115, 480+180*3, 90, 90);
                WxImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
            } completion:^(BOOL finished) {
                
            }];
            [gausbackView removeFromSuperview];


        }];
        
        
        moveCount = YES;


    }
    
    
}


- (void)gestureRecognizerHandle:(UITapGestureRecognizer *)tap
{

    if (moveCount == YES)
    {
        
        gausbackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height-68, 320, 68)];
        [self.mainView insertSubview:gausbackView belowSubview:_imageView];
        gausbackView.backgroundColor = [UIColor clearColor];
        gausbackView.layer.masksToBounds = YES;
        [gausbackView release];
        
        CGRect rect = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
        imaV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, - self.mainView.bounds.size.height + 68, 320, self.mainView.bounds.size.height-20)];
        [gausbackView addSubview:imaV2];
        
        
        UIImage *image1 = [[[caiboAppDelegate getAppDelegate] JiePing] gaussianBlur];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6) {
            imaV2.image = [image1 imageFromImage:image1  inRect:CGRectMake(0, 65, rect.size.width/2, _imageView.bounds.size.height/2)];
        }
        else {
            imaV2.image = [image1 imageFromImage:image1 inRect:CGRectMake(0, 65 *2, rect.size.width, rect.size.height)];
        }
        imaV2.alpha = 1.0;
        [imaV2 release];

        [_alipayImage setHidden:YES];
        [_qqImage setHidden:YES];
        [_wximage setHidden:YES];
        [_weiboImage setHidden:YES];
        [_tenImage setHidden:YES];
        
        [ UIImageView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            _imageView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            _imageView.alpha = 0.80;
            gausbackView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            imaV2.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
            sinaImageView2.alpha = 1;
        } completion:^(BOOL finished) {
            
            
            xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-xialajiantou_03.png"];
            
            
            // 新浪微博登录
            [UIImageView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                sinaImageView2.frame = CGRectMake(50, 115, 90, 90);
                
            } completion:^(BOOL finished) {
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    sinaImageView2.frame = CGRectMake(50, 113, 90, 90);
                } completion:^(BOOL finished) {
                    
                    [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        sinaImageView2.frame = CGRectMake(50, 115, 90, 90);
                    } completion:^(BOOL finished) {
                    }];
                    
                }];
            }];
            
            
            
            
            [UIImageView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                WxImageView2.frame = CGRectMake(115, 115, 90, 90);
                
            } completion:^(BOOL finished) {
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    WxImageView2.frame = CGRectMake(115, 113, 90, 90);
                } completion:^(BOOL finished) {
                    
                    [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        WxImageView2.frame = CGRectMake(115, 115, 90, 90);
                    } completion:^(BOOL finished) {
                    }];
                    
                }];
            }];
            
        }];
        
        
        [UIImageView animateWithDuration:0.3 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            qqImageView2.frame = CGRectMake(50, 115, 90, 90);
            
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                qqImageView2.frame = CGRectMake(50, 113, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    qqImageView2.frame = CGRectMake(50, 115, 90, 90);
                    
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
        
        
        [UIImageView animateWithDuration:0.3 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            apliyImageView2.frame = CGRectMake(180, 245, 90, 90);
            
        } completion:^(BOOL finished) {
            
            [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
                apliyImageView2.frame = CGRectMake(180, 243, 90, 90);
            } completion:^(BOOL finished) {
                
                [UIImageView animateWithDuration:0.05 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    apliyImageView2.frame = CGRectMake(180, 245, 90, 90);
                    
                } completion:^(BOOL finished) {
                }];
                
            }];
        }];
        
        
        [UIImageView animateWithDuration:0.15 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            tXWBImageView2.frame = CGRectMake(100, 380-25, 150, 22);
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.5 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
                tXWBImageView2.frame = CGRectMake(100, 380-25, 150, 22);
            } completion:^(BOOL finished) {
                
                //                [UIImageView animateWithDuration:0.2 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //                    tXWBImageView2.frame = CGRectMake(100, 325, 900, 20);
                //
                //                } completion:^(BOOL finished) {
                //                }];
                
            }];
        }];
        
        
        moveCount = NO;
    }
    else
    {
        
        [UIImageView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (IS_IPHONE_5) {
                _imageView.frame = CGRectMake(0, self.mainView.bounds.size.height-88, 320, 88);
                gausbackView.frame = CGRectMake(0, self.mainView.bounds.size.height-88, 320, 88);
                imaV2.frame = CGRectMake(0, - self.mainView.bounds.size.height + 88, 320, self.mainView.bounds.size.height);
                
            }else{
                _imageView.frame = CGRectMake(0, 480-88-53, 320, 88);
            }
            
            
        } completion:^(BOOL finished) {
            [_qqImage setHidden:NO];
            [_tenImage setHidden:NO];
            [_wximage setHidden:NO];
            [_weiboImage setHidden:NO];
            [_alipayImage setHidden:NO];
            
            
            xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-shanglajiantou_03.png"];
            [UIImageView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                apliyImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                qqImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                sinaImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
                tXWBImageView2.frame = CGRectMake(115, 480+180*3, 90, 90);
                WxImageView2.frame = CGRectMake(115, 480+180*2, 90, 90);
            } completion:^(BOOL finished) {
                
            }];
            
            [gausbackView removeFromSuperview];

        }];
        
        
        moveCount = YES;
    }
    
}

#pragma mark tapGestureRecgnizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
    
        return YES;
    }
}


-(void)toTfNickName{
    [tfNickName becomeFirstResponder];
}

-(void)toTfPassword{
    [tfPassword becomeFirstResponder];
}

- (void)LoadiPadView {
    
    self.backImageforiPad.image = nil;
    self.mainView.backgroundColor = [UIColor clearColor];
    
    self.CP_navigation.title = @"登录";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 540, 570)];
    backi.image = UIImageGetImageFromName(@"bejing.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    
    if ([self.navigationController.viewControllers count]<=1) {
		[self.CP_navigation setLeftBarButtonItem:nil];
	}
		//
        textfiledbackImageforiPad.image = nil;
        textfiledbackImageforiPad.userInteractionEnabled = YES;
        textfiledbackImageforiPad.frame = CGRectMake(30, 35, 477, 45.5);
        textfiledbackImageforiPad.image = UIImageGetImageFromName(@"set-input2.png");
        [self.mainView insertSubview:textfiledbackImageforiPad atIndex:1000];
        
        textfiledbackImageforiPad2.image = nil;
        textfiledbackImageforiPad2.userInteractionEnabled = YES;
        textfiledbackImageforiPad2.frame = CGRectMake(30, 80.5, 477, 45.5);
        textfiledbackImageforiPad2.image = UIImageGetImageFromName(@"set-input3.png");
        [self.mainView insertSubview:textfiledbackImageforiPad2 atIndex:1000];
        
        UILabel *usname = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 40)];
        usname.backgroundColor = [UIColor clearColor];
        usname.text = @"用 户 名 :";
        usname.font = [UIFont systemFontOfSize:15];
        [textfiledbackImageforiPad addSubview:usname];
        [usname release];
        
        tfNickName.backgroundColor = [UIColor clearColor];
        tfNickName.frame = CGRectMake(90, 5, 350, 40);
		[tfNickName setPlaceholder:(@"手机号/电子邮箱/昵称")];
		[tfNickName setDelegate:self];
        [textfiledbackImageforiPad addSubview:tfNickName];
		
        UILabel *pas = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 80, 40)];
        pas.backgroundColor = [UIColor clearColor];
        pas.text = @"密      码 :";
        pas.font = [UIFont systemFontOfSize:14];
        [textfiledbackImageforiPad2 addSubview:pas];
        [pas release];
        
        tfPassword.backgroundColor = [UIColor clearColor];
        tfPassword.frame = CGRectMake(90, 2, 350, 40);
		[tfPassword setPlaceholder:(@"6-16位数字和字母组合")];
		[tfPassword setDelegate:self];
		[tfPassword setSecureTextEntry:YES];
        [textfiledbackImageforiPad2 addSubview:tfPassword];
		
        
        
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(goBackToforiPad) ImageName:@"kf-quxiao2.png"];
        
        self.btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRegister.frame = CGRectMake(15 , 215, 290, 45);
        [btnRegister addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btnRegister];
        [self.btnRegister setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu_1.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10] forState:UIControlStateNormal];
        [self.btnRegister setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10] forState:UIControlStateSelected];
        [btnRegister setTitle:@"注 册" forState:UIControlStateNormal];
        btnRegister.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogin.frame = CGRectMake(15, 150, 290, 45);
        [btnLogin addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btnLogin];
        self.btnLogin.enabled = NO;
        [self.btnLogin setBackgroundImage:[[UIImage imageNamed:@"dengluanniu_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateNormal];
        [self.btnLogin setBackgroundImage:[[UIImage imageNamed:@"dengluanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateHighlighted];
        [btnLogin setTitle:@"登 录" forState:UIControlStateNormal];
        btnLogin.titleLabel.font = [UIFont systemFontOfSize:18];
        [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
       
        
        UIButton *FPButton = [UIButton buttonWithType:UIButtonTypeCustom];
        FPButton.frame = CGRectMake(30, 190, 477, 45.5);
        [FPButton setImage:UIImageGetImageFromName(@"set-input.png") forState:UIControlStateNormal];
        [FPButton addTarget:self action:@selector(FindPassword) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:FPButton];
        UILabel *FPLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 100, 20)];
        FPLabel.backgroundColor = [UIColor clearColor];
        FPLabel.text = @"忘记密码?";
        FPLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        FPLabel.font = [UIFont boldSystemFontOfSize:15];
        [FPButton addSubview:FPLabel];
        [FPLabel release];
       
       
        
        tableviewforiPad.frame = CGRectMake(30, 255, 477, 140);
        [self.mainView insertSubview:tableviewforiPad atIndex:1000];
        
		[self doShowLastAccount];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
}

//找回密码
- (void)FindPassword {
    [MobClick event:@"event_wodecaipiao_wangjimima"];
    FindPasswordViewController *fp = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:fp animated:YES];
    [fp release];
}


#if 0
- (IBAction)xieyiBtton:(UIButton *)sender{
	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Xieyi;
	[self.navigationController pushViewController:xie animated:YES];
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365xieyi.txt"];
//	NSData *fileData = [fileManager contentsAtPath:path];
//    if (fileData) {
//		NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//#ifdef  isJinShanIphone
//#ifdef  isJinShanIphoneNew
//        xie.infoText.text = [str stringByReplacingOccurrencesOfString:@"投注站" withString:@"彩票专家"];
//#else
//        xie.infoText.text = [str stringByReplacingOccurrencesOfString:@"投注站" withString:@"金山投注站"];
//#endif
//        
//#else
//        xie.infoText.text = str;
//#endif
//		
//		[str release];
//	}
#ifdef isHaoLeCai
    xie.title = @"好乐彩服务协议";
#else
	xie.title = @"投注站服务协议";
#endif
	[xie release];
}


#endif

- (void)lookWithoutLogin {
	Info *info = [Info getInstance];
	info.login_name = CBGuiteName;
	info.userId = CBGuiteID;
	info.nickName = CBGuiteNiceName;
	//info.password = CBGuitePassWord;
	[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
	caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
	appDelegate.changeAccount = YES;
	[appDelegate switchToHomeView];
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    self.mainView.frame = CGRectMake(0, 44 + isIOS7Pianyi, 320, [UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi);
	User *lastUser = [User getLastUser];
    if (isShowDefultAccount || lastUser) {
		
	}
	else {
	}
    if (IS_IPHONE_5) {
    }
    else {
        self.mainView.frame = CGRectMake(0, 44 + isIOS7Pianyi, 320, [UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi + 70);
    }
}

- (void)goLogin {
	LoginViewController *log = [[LoginViewController alloc] init];
	[log setIsShowDefultAccount:YES];
	[self.navigationController pushViewController:log animated:YES];
	[log release];
}

- (void)alipayLogin:(NSURL *)url {
    [leftItem setEnabled:YES];
}

- (void)WXCodeFinished:(ASIHTTPRequest *)request {
    NSDictionary *dic = [request.responseString JSONValue];
    if ([dic valueForKey:@"access_token"]) {
        [reqLogin clearDelegatesAndCancel];
        self.reqLogin = [ASIHTTPRequest requestWithURL:[NetURL loginUnionWithloginSource:@"10" unionId:[dic valueForKey:@"openid"] token:[dic valueForKey:@"access_token"] tokenSecret:@"" openid:@"" userId:@""]];
        [reqLogin setTimeOutSeconds:20.0];
        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqLogin setDidFinishSelector:@selector(unitionRequestFinisher:)];
        [reqLogin setDelegate:self];
        [reqLogin startAsynchronous];
    }
    else {
        [mStatePV dismiss];
        [leftItem setEnabled:YES];
    }
}

- (void)WXLogin:(NSString *)code {
    if ([code length] == 0) {
        
        return;
    }
    unNitionLoginType = UnNitionLoginTypeWX;
    mStatePV = [StatePopupView getInstance];
    [mStatePV showInView:self.mainView Text:@"登录中..."];
    [leftItem setEnabled:NO];
    [reqLogin clearDelegatesAndCancel];
    self.reqLogin = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx0cfdf60c4c082b3b&secret=35f941b12366a80ea1188ae1ce82cb78&code=%@&grant_type=authorization_code",code]]];
    [reqLogin setTimeOutSeconds:20.0];
    [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqLogin setDidFinishSelector:@selector(WXCodeFinished:)];
    [reqLogin setDelegate:self];
    [reqLogin startAsynchronous];
}

- (IBAction)loginBySina {
    if ([WeiboSDK isWeiboAppInstalled] && [[[Info getInstance] BundleId] isEqualToString:@"com.v1.cai"]) {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kSinaAppKey];
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kSinaRedirectURI;
        request.scope = @"all";
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:self,@"delegate", nil]];
        [WeiboSDK sendRequest:request];
    }
    else {
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        
        sina.sinaURL =[NetURL CBUnitonLogin:@"1"];
        sina.title = @"新浪微博登录";
        sina.unNitionLoginType = UnNitionLoginTypeSina;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
    }
}

- (void)imageScrMove {
	int page = imageScr.contentOffset.x/320;
	page = (page+1)%5;
	[imageScr scrollRectToVisible:CGRectMake(320*page, 0, 320, 260) animated:YES];
}

- (void)viewDidUnload
{
    self.tfNickName = nil;
    self.tfPassword = nil;
    //    self.selRmbpsd = nil;
    self.btnRegister = nil;
    self.btnLogin = nil;
    
    // 原先的textField背景图
//    [self setTfNickNameBackgroundImageView:nil];
//    [self setTfPasswordBackgroundImageView:nil];
//    [self setFPButtonImageView:nil];
//    [self setFPButtonImageView1:nil];
    [self setUserNameButton:nil];
    [self setPasswordButton:nil];
//    [self setImageView:nil];
//    [self setAlipayImage:nil];
//    [self setWeiboImage:nil];
//    [self setQqImage:nil];
//    [self setTenImage:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// 注册
- (void)doRegister
{
    //	LotteryPreferenceViewController *lot =[[LotteryPreferenceViewController alloc] init];
    //	[self.navigationController setNavigationBarHidden:NO animated:NO];
    //	lot.title =@"步骤1：偏好设置";
    //	[self.navigationController pushViewController:lot animated:YES];
    //	[lot release];
    
    [MobClick event:@"event_zhuce" label:nil];
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
//    [self.navigationController setNavigationBarHidden:YES];
    [registerVC release];
    
    
    
}

// 登录
- (void)doLogin
{
    [MobClick event:@"event_denglu" label:nil];
    [tfNickName resignFirstResponder];
    [tfPassword resignFirstResponder];
    
    if([tfNickName.text rangeOfString:@" "].location != NSNotFound){
        tfNickName.text = [tfNickName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if([tfPassword.text rangeOfString:@" "].location != NSNotFound){
        tfPassword.text = [tfPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([self doCheck])
    {
        mStatePV = [StatePopupView getInstance];
        [mStatePV showInView:self.mainView Text:@"登录中..."];
        [leftItem setEnabled:NO];
        
        //        isRememberPsd = selRmbpsd.on;
        self.login_name = tfNickName.text;
        password = tfPassword.text;
        
        [reqLogin clearDelegatesAndCancel];
        self.reqLogin = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:login_name passWord:password]];
        [reqLogin setTimeOutSeconds:20.0];
        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqLogin setDelegate:self];
        [reqLogin startAsynchronous];
    }
    
    if (tfNickName.text && ![tfPassword.text isEqualToString:@""]) {
        [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    NSLog(@"date: %@", [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]);   //2011-01-18 03:55:49 +0000
#ifdef isCaiPiaoForIPad
    
    [self goBackToforiPad];
    
#endif
    
}




// 校验输入框输入的内容
- (BOOL) doCheck
{
    NSString *message;
    BOOL isPass = YES;
    
    if ([tfNickName.text length] == 0)
    {
        message = @"用户名不能为空";
        [tfNickName becomeFirstResponder];
		[tfNickName Shake];
        isPass = NO;
    }
    else if ([tfPassword.text length] == 0)
    {
        message = @"密码不能为空";
        [tfPassword becomeFirstResponder];
		[tfPassword Shake];
        isPass = NO;
    }
    else if([tfPassword.text length] < 6)
    {
        message = @"用户名或密码不正确";
        [tfPassword becomeFirstResponder];
		[tfPassword Shake];
        isPass = NO;
    }
    
    if (!isPass)
    {
        [Info showCancelDialog:(@"提示") :(message) :(self)];
    }
    
    return isPass;
}

// 默认显示最后一次登录的帐户
- (void)doShowLastAccount
{
    if (isShowDefultAccount)
    {
        User *lastUser = [User getLastUser];
        if (lastUser)
        {
			tfNickName.text= nil;
			tfPassword.text = nil;
            if (lastUser.login_name)
            {
                [tfNickName setText:lastUser.login_name];
            }
            //            if (lastUser.password)
            //            {
            //                [tfPassword setText:lastUser.password];
            //            }
        }
		else {
			[tfNickName setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"LogInname"]];
		}
        
        //[lastUser release];
    }
	if ([tfNickName.text length] && [tfPassword.text length]) {
		[self doLogin];
		btnLogin.enabled = YES;
	}
	else {
        //		[tfNickName setText:nil];
        //		[tfPassword setText:nil];
	}
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [tfNickName resignFirstResponder];
    [tfPassword resignFirstResponder];
}

#pragma mark -
#pragma mark 重写UITextFieldDelegate接口

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == tfNickName)
    {
		[tfPassword becomeFirstResponder];
    }
    else if (textField == tfPassword)
    {
        [textField resignFirstResponder];
	}
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == tfNickName)
    {
        NSString *nickName = tfNickName.text;
        if (nickName)
        {
            //            Statement *stmt = [DataBase statementWithQuery:"SELECT password FROM users WHERE nick_name = ?;VACUUM;"];
            //            [stmt bindString:nickName forIndex:1];
            //            if ([stmt step] == SQLITE_ROW)
            //            {
            //                NSString *psd = [stmt getString:0];
            //                [tfPassword setText:psd];
            //            }
            //            [stmt reset];
        }
    }
	if ([tfNickName.text length]&&[tfPassword.text length]) {
		btnLogin.enabled = YES;
	}
	else {
		btnLogin.enabled = NO;
	}
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	btnLogin.enabled = NO;
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == tfNickName)
    {
        if ([tfNickName.text length] == 1)
        {
            [tfPassword setText:@""];
        }
    }
	if (textField == tfNickName) {
		if ([tfPassword.text length]&&([textField.text length]>1||[string length])) {
			btnLogin.enabled = YES;
		}
		else {
			btnLogin.enabled = NO;
		}
	}
	else {
		if ([tfNickName.text length]>0&&([textField.text length]>1||[string length])) {
			btnLogin.enabled = YES;
		}
		else {
			btnLogin.enabled = NO;
		}
	}
    
	
    return YES;
}


#pragma mark - textField开始编辑

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField == tfNickName)
    {
        
    }
     else
     {
    
     }

    
}


#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

- (void)AliPayRequestFinisher:(ASIHTTPRequest *)request {
    [mStatePV dismiss];
    [[AlipaySDK defaultService] payOrder:[request responseString] fromScheme:caipiao365BackURLForAlipay callback:^(NSDictionary *dic) {
        
    }];
}

- (void)unitionRequestFinisher:(ASIHTTPRequest *)request {
    [mStatePV dismiss];
    NSDictionary *dic = [[request responseString] JSONValue];
    NSString *code = [dic objectForKey:@"code"];
    NSString *type = [dic objectForKey:@"type"];
	NSString *unionId = [dic objectForKey:@"unionId"];
	NSString *userId= [dic objectForKey:@"userId"];
	NSString* nick_name = [[dic objectForKey:@"nick_name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * accesstoken = [dic objectForKey:@"accesstoken"];
	if ([type isEqualToString:@"0"]) {
		
        Info *info = [Info getInstance];
        info.userId = userId;
        info.nickName = nick_name;
        info.userName = [dic objectForKey:@"user_name"];
        NSLog(@"99999999999999 = %@", info.userName);
        info.accesstoken = accesstoken;
        if (info.mUserInfo) {
            info.mUserInfo.unionStatus = @"1";
        }
        else {
            UserInfo *user = [[UserInfo alloc] init];
            user.userId = userId;
            user.nick_name = nick_name;
            user.accesstoken = accesstoken;
            user.unionStatus = @"1";//
            user.user_name = [dic objectForKey:@"user_name"];
            user.partnerid = [dic objectForKey:@"partnerid"];//
            user.unionId = unionId;//
            user.isbindmobile = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"isbindmobile"] intValue]];
            user.authentication = @"";//[dic objectForKey:@"authentication"];
            info.password = @"";
            info.mUserInfo = user;
            info.isbindmobile = user.isbindmobile;
            info.authentication = user.authentication;
            info.accesstoken = user.accesstoken;
            
            NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
            [infoarr addObject:info.login_name];
            [infoarr addObject:info.userId];
            [infoarr addObject:info.nickName];
            [infoarr addObject:info.userName];
            NSLog(@"99999999999999 = %@", info.userName);
            [infoarr addObject:info.mUserInfo];
            [infoarr addObject:@""];//info.isbindmobile];
            [infoarr addObject:info.authentication];
            [infoarr addObject:@""];//info.password];
            [infoarr addObject:@""];//userInfo.unionStatus];
            [infoarr addObject:@""];//userInfo.partnerid];
            [infoarr addObject:@""];//userInfo.unionId];
            //                [infoarr addObject:info.];
            if (info.accesstoken) {
                [infoarr addObject:info.accesstoken];
            }else{
                [infoarr addObject:@""];
            }
            NSString *st = [infoarr componentsJoinedByString:@";"];
            
            [[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            
            NSString *newst = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
            if (![newst isEqualToString:st]) {
                [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
                [infoarr release];
                [user release];
                return;
            }
            
            [infoarr release];
            
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
            [[NSUserDefaults standardUserDefaults] setValue:user.isbindmobile forKey:@"isbindmobile"];
            [[NSUserDefaults standardUserDefaults] setValue:user.authentication forKey:@"authentication"];
            [user release];
        }
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnion"];
        
        if (unNitionLoginType == UnNitionLoginTypeAlipay) {
            [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"isAlipay"];
        }else if (unNitionLoginType == UnNitionLoginTypeSina) {
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"isUnionType"];
        }
        
        
        //[GC_HttpService sharedInstance].sessionId = [dic objectForKey:@"session_id"];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.lastAccount = YES;
        [appDelegate DologinSave];
        [appDelegate LogInBySelf];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelPrivateLetter" object:nil];
        [appDelegate switchToHomeView];
	}
	else if([type isEqualToString:@"1"] || [type isEqualToString:@""]) {
        AddNick_NameViewController *add = [[AddNick_NameViewController alloc] init];
        add.unionId = unionId;
        add.unNitionLoginType = unNitionLoginType;
        [self.navigationController pushViewController:add animated:YES];
        [add release];
	}
	else {
		if ([code isEqualToString:@"0"]) {
			Info *info = [Info getInstance];
			UserInfo *user = info.mUserInfo;
			user.unionStatus = @"1";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"绑定成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
		else if ([code isEqualToString:@"1"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"参数传递错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
		
		else if ([code isEqualToString:@"2"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接服务异常" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
			
		}
		
		else if ([code isEqualToString:@"3"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户不存在" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
		else if ([code isEqualToString:@"4"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户已经绑定" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
		else if ([code isEqualToString:@"5"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"异常" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"授权失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}
        
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    int code = [request responseStatusCode];
    NSLog(@"code: %d" ,code);
    
    [mStatePV dismiss];
    [leftItem setEnabled:YES];
    
    if (code == 200)
    {
        NSString *responseStr = [request responseString];
        if ([responseStr isEqualToString:@"fail"])
        {
            [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
        }
        else
        {
            UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
            isRememberPsd = YES;
            
            if (!userInfo) {
                if ([[responseStr JSONValue] valueForKey:@"msg"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:[[responseStr JSONValue] valueForKey:@"msg"]];
                    return;
                }
				[Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
				return;
			}
            Info *info = [Info getInstance];
            info.login_name = login_name;
            info.userId = userInfo.userId;
            info.nickName = userInfo.nick_name;
			info.userName = userInfo.user_name;
            info.accesstoken = userInfo.accesstoken;
			info.mUserInfo = userInfo;
            info.isbindmobile = userInfo.isbindmobile;
            info.authentication = userInfo.authentication;
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.true_name forKey:@"true_name"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.id_number forKey:@"id_number"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.isbindmobile forKey:@"isbindmobile"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo.authentication forKey:@"authentication"];
            NSLog(@"info = %@", info.authentication);
            NSLog(@"xxx = %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] );
            if (isRememberPsd)
            {
                //info.password = password;
            }
            [User insertDB:(info)];
            if ([info.nickName length] ==0) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"您的帐号需要完善昵称后才能使用，请登录 www.zgzcw.com 完善。"];
                
            }
            [caiboAppDelegate getAppDelegate].loginselfcount = 0;
            NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
            [infoarr addObject:info.login_name];
            [infoarr addObject:info.userId];
            [infoarr addObject:info.nickName];
            [infoarr addObject:info.userName];
            [infoarr addObject:info.mUserInfo];
            [infoarr addObject:@""];//info.isbindmobile];
            [infoarr addObject:info.authentication];
            [infoarr addObject:@""];//info.password];
            [infoarr addObject:@""];//userInfo.unionStatus];
            [infoarr addObject:@""];//userInfo.partnerid];
            [infoarr addObject:@""];//userInfo.unionId];
            //            [infoarr addObject:info.accesstoken];
            if (info.accesstoken) {
                [infoarr addObject:info.accesstoken];
            }else{
                [infoarr addObject:@""];
            }
            NSString *st = [infoarr componentsJoinedByString:@";"];
            
            [[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            NSString *newst = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
            if (![newst isEqualToString:st]) {
                [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
                [infoarr release];
                [userInfo release];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
                return;
            }
            [infoarr release];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"]);
            // [[NSUserDefaults standardUserDefaults] setValue:info forKey:@"logincp"];
            [userInfo release];
            //  [[NSUserDefaults standardUserDefaults] setValue:userInfo.nick_name forKey:@"LogInname"];
            
            [[NSUserDefaults standardUserDefaults] setValue:tfNickName.text forKey:@"LogInname"];
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
            NSLog(@"name = %@", tfNickName.text);
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
            // 跳到主页
            //caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            // [cai LogInBySelf];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
			[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnionType"];
            [[caiboAppDelegate getAppDelegate] LogInBySelf];
            [[caiboAppDelegate getAppDelegate] DologinSave];
            if (tabbool == 10) {
                [[caiboAppDelegate getAppDelegate] switchToHomeView];
                
                return;
            } else if(tabbool == 11){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
                return;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PrivateLetterBack" object:nil];
            
            if(isFromFlashAd)
            {
                ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                shuang.isFromFlashAdAndLogin = YES;
                [self.navigationController pushViewController:shuang animated:YES];
                [shuang release];
            }
            else{
                [self.navigationController popViewControllerAnimated:YES];
                if (myLunBoView) {
                    [myLunBoView performSelectorInBackground:@selector(createTimer1) withObject:nil];
                }
            }
            
            //弱密码判断
            if ([tfPassword.text isAllNumber] || [tfPassword.text isEqualToString:login_name]) {
                caiboAppDelegate *pas = [caiboAppDelegate getAppDelegate];
                [pas showMessage:@"需要修改密码"];
            }
        }
    }
#ifdef  isCaiPiaoForIPad
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginButton" object:self];
#endif
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [mStatePV dismiss];
    [leftItem setEnabled:YES];
    
    //    int code = [request responseStatusCode];
 	NSError *error = [request error];
    //	NSLog(@"error is %@  code= %d", error, code);
	if(error )
    {
        
		myAlert = [[UIAlertView alloc] initWithTitle:@"警告"
                                             message:@"网络有错误"
                                            delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:nil];
		[myAlert show];
		[myAlert release];
	}
	
	[self performSelector:@selector(disAlert) withObject:nil afterDelay:3.0f];
}

-(void)disAlert
{
	if (myAlert) {
		[myAlert dismissWithClickedButtonIndex:0 animated:YES];
	}
}


#pragma mark WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    WBAuthorizeResponse *response2 = (WBAuthorizeResponse *)response;
    if (response2.accessToken
        && 0 != [response2.accessToken length]) {
        unNitionLoginType = UnNitionLoginTypeSina;
        mStatePV = [StatePopupView getInstance];
        [mStatePV showInView:self.mainView Text:@"登录中..."];
        [leftItem setEnabled:NO];
        [reqLogin clearDelegatesAndCancel];
        self.reqLogin = [ASIHTTPRequest requestWithURL:[NetURL loginUnionWithloginSource:@"1" unionId:response2.userID token:response2.accessToken tokenSecret:@"" openid:@"" userId:@""]];
        [reqLogin setTimeOutSeconds:20.0];
        [reqLogin setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqLogin setDidFinishSelector:@selector(unitionRequestFinisher:)];
        [reqLogin setDelegate:self];
        [reqLogin startAsynchronous];
    }
}



@end


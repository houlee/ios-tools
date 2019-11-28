//
//  RegisterViewController.m
//  caibo
//
//  Created by Kiefer on 11-5-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "Info.h"
#import "ProvingViewCotroller.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "SBJSON.h"
#import "RegexKitLite.h"
#import "User.h"
#import "SinaBindViewController.h"
#import "TextFieldUtils.h"
#import "Xieyi365ViewController.h"
#import "UserInfo.h"
#import "Statement.h"
#import "DataBase.h"
#import "GC_ZhuCeChengGongViewCotroller.h"
#import "CP_PTButton.h"
#import "caiboAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "MobClick.h"
#import "HongBaoInfo.h"
#import "NSDate-Helper.h"

@interface RegisterViewController ()
@property(nonatomic, retain) NSString *password;
@end

@implementation RegisterViewController
{

    UIImageView *_rightImage;
    
    
    
    BOOL *_isNickNamePass;
    BOOL *_isPassWordPass;
    BOOL *_isRePassWordPass;
    int  _index;
    int  _count;
    
    UIImageView *_alipayImage;
    UIImageView *_qqImage;
    UIImageView *_weiboImage;
    UIImageView *_tenImage;
    UIImageView *_wximage;
    UIImageView *xialaBtnImage;
    

}

@synthesize tfNickName;
@synthesize tfPassword;
@synthesize tfRePassword;
@synthesize reqRegister;
@synthesize password;
@synthesize registerProgressHud;
@synthesize xieyiBtn;
@synthesize sugestArray;
@synthesize hongbaoMes;
// @synthesize zhuceBtn;
//@synthesize tfNickNameBackgroundImageView, tfRePasswordBackgroundImageView, tfPasswordBackgroundImageView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) 
//    {
//        
//
//    }
//    return self;
//}

- (void)dealloc
{
    if (reqRegister) 
    {
        [reqRegister clearDelegatesAndCancel];
        [reqRegister release];
    }
    [registerProgressHud release];
    [tfNickName release];
    [tfPassword release];
    [tfRePassword release];
    [password release];
    [agreeLabel release];
    [aidBtn release];
    
    [_imageView release];
    [_alipayImage release];
    [_qqImage release];
    [_weiboImage release];
    [_tenImage release];
    [userNameRepeteView release];
    [line3 release];
    [line4 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)LoadiPhoneView {

    if ([self.navigationController.viewControllers count] == 1) {
		self.CP_navigation.leftBarButtonItem = nil;
	}
	self.CP_navigation.rightBarButtonItem.enabled = NO;
    moveCount = YES;
    
    self.mainView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];

    
    
   
    
    
    //  用户名和密码
    tfNickName = [[UITextField alloc] init];
    tfNickName.delegate = self;
    tfNickName.frame = CGRectMake(0, 30, 320, 45);
    tfNickName.font = [UIFont systemFontOfSize:15];
    [tfNickName setPlaceholder:(@"用户名请输入6-16位字符")];
    tfNickName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfNickName.backgroundColor = [UIColor whiteColor];
    tfNickName.delegate = self;
    tfNickName.clearButtonMode = UITextFieldViewModeAlways;
    

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(21,0, 54, 45)];
    UIImageView *tfNickNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 12, 20, 20)];
    tfNickNameImageView.image = [UIImage imageNamed:@"yonghuming_1.png"];
    [backView addSubview:tfNickNameImageView];
    [tfNickNameImageView release];
    tfNickName.leftView = backView;
    [backView release];
    tfNickName.leftViewMode = UITextFieldViewModeAlways;
    tfNickName.rightViewMode = UITextFieldViewModeAlways;
    [self.mainView addSubview:tfNickName];
    
    
    
    tfPassword = [[UITextField alloc] init];
    tfPassword.backgroundColor = [UIColor whiteColor];
    tfPassword.font = [UIFont systemFontOfSize:15];
    [tfPassword setPlaceholder:@"6-16位小写字母/数字/下划线"];
    tfPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfPassword.frame = CGRectMake(0, 30+45, 320, 45);
    [tfPassword setSecureTextEntry:(YES)];
    [tfPassword setDelegate:(self)];
    tfPassword.clearButtonMode = UITextFieldViewModeAlways;

    
    UIView *resBackView = [[UIView alloc] initWithFrame:CGRectMake(21, 0, 54, 45)];
    UIImageView *tfPasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 12, 20, 20)];
    tfPasswordImageView.image = [UIImage imageNamed:@"mima_1.png"];
    [resBackView addSubview:tfPasswordImageView];
    [tfPasswordImageView release];
    tfPassword.leftView = resBackView;
    [resBackView release];
    tfPassword.leftViewMode = UITextFieldViewModeAlways;
    [self.mainView addSubview:tfPassword];
   
    
    tfRePassword = [[UITextField alloc] init];
    tfRePassword.backgroundColor = [UIColor whiteColor];
    tfRePassword.placeholder = @"请再次输入密码";
    tfRePassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfRePassword.font = [UIFont systemFontOfSize:15];
    tfRePassword.frame = CGRectMake(0, 30+45*2, 320, 45);
    [tfRePassword setSecureTextEntry:(YES)];
    tfRePassword.clearButtonMode = UITextFieldViewModeAlways;
    [tfRePassword setDelegate:(self)];
    
    
    UIView *reBackView = [[UIView alloc] initWithFrame:CGRectMake(21, 0, 54, 45)];
    UIImageView *tfrePasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 12, 20, 20)];
    tfrePasswordImageView.image = [UIImage imageNamed:@"mima_1.png"];
    [reBackView addSubview:tfrePasswordImageView];
    [tfrePasswordImageView release];
    tfRePassword.leftView = reBackView;
    [reBackView release];
    tfRePassword.leftViewMode = UITextFieldViewModeAlways;
    [self.mainView addSubview:tfRePassword];
    
  
    
    UIView *line1 = [[[UIView alloc] init] autorelease];
    line1.frame = CGRectMake(0, 30, 320, 0.5);
    line1.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [self.mainView addSubview:line1];
    
    UIView *line2 = [[[UIView alloc] init] autorelease];
    line2.frame = CGRectMake(15, 30+45, 305, 0.5);
    line2.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [self.mainView addSubview:line2];
    line3 = [[UIView alloc] init];
    line3.frame = CGRectMake(15, 30+45+45, 305, 0.5);
    line3.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [self.mainView addSubview:line3];
    line4 = [[UIView alloc] init] ;
    line4.frame = CGRectMake(0, 30+45*3, 320, 0.5);
    line4.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [self.mainView addSubview:line4];
    
    
    zhuceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuceBtn.frame = CGRectMake(15, 190+30, 290, 45);
    [zhuceBtn setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateDisabled];
    [zhuceBtn setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5]forState:UIControlStateNormal];
    [zhuceBtn setBackgroundImage:[[UIImage imageNamed:@"zhuceanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateHighlighted];
    [zhuceBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [zhuceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuceBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    zhuceBtn.enabled = NO;
    [zhuceBtn addTarget:self action:@selector(pressZhuCe:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:zhuceBtn];
    
    aidBtn = [[UIButton alloc] initWithFrame:zhuceBtn.frame];
    [self.mainView addSubview:aidBtn];
    [aidBtn addTarget:self action:@selector(aidBtn) forControlEvents:UIControlEventTouchUpInside];
    
//    UILabel *loginWays = [[[UILabel alloc] init] autorelease];
//    loginWays.text = @"使用以下方式登录";
//    loginWays.textAlignment = NSTextAlignmentCenter;
//    loginWays.font = [UIFont systemFontOfSize:15];
//    loginWays.backgroundColor = [UIColor clearColor];
//    loginWays.textColor = [UIColor colorWithRed:213.0/255.0 green:208.0/255.0 blue:197.0/255.0 alpha:1];
//    loginWays.userInteractionEnabled = YES;
//    [self.mainView addSubview:loginWays];
    
    
   
    
    

    // ****
    agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 242-15+20+30, 310, 40)] ;
    agreeLabel.text = @"《同城用户服务协议》";
    agreeLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    agreeLabel.backgroundColor = [UIColor clearColor];
    agreeLabel.textAlignment = NSTextAlignmentRight;
    agreeLabel.font = [UIFont systemFontOfSize:18];
    agreeLabel.userInteractionEnabled = YES;
    [self.mainView addSubview:agreeLabel];
    
    UIButton *agreeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn1.frame = CGRectMake(14+70+18, 0, 290-88, 40);
    [agreeBtn1 addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn1.backgroundColor = [UIColor clearColor];
    [agreeLabel addSubview:agreeBtn1];
    
    
    agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(92, 9.5, 50, 50);
    [agreeBtn setImage:[UIImage imageNamed:@"zhuce-tongyixiyikuang_1.png"] forState:UIControlStateNormal];
    [agreeBtn setImageEdgeInsets:UIEdgeInsetsMake(1, 18, 29, 12)];
    [agreeBtn addTarget: self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn.backgroundColor = [UIColor clearColor];
    [agreeLabel addSubview:agreeBtn];
    _index = 0;
  
    
    _rightImage = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 2.5, 17, 16)] autorelease];
    _rightImage.image = [UIImage imageNamed:@"zhuce-tongyixieyi_1.png"];
    [agreeBtn addSubview:_rightImage];
    
    NSDate *now =[NSDate date];
    if ([[now getFormatYearMonthDayHour] doubleValue] < 2016121911) {
        return;
    }
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, self.mainView.bounds.size.height-88+5, 320, 88);
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.userInteractionEnabled = YES;
    [self.mainView addSubview:_imageView];
    _imageView.image = [[UIImage imageNamed:@"gp-zhucedenglu-budaijiantou_02.png"] stretchableImageWithLeftCapWidth:160 topCapHeight:45];
    
    
    
    xiaLaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiaLaBtn.frame = CGRectMake(130, 0, 60, 60);
    [xiaLaBtn addTarget:self action:@selector(xiaLaBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    xiaLaBtn.backgroundColor = [UIColor clearColor];
    xiaLaBtn.userInteractionEnabled = YES;
    [_imageView addSubview:xiaLaBtn];
    
   
    

    
    
    
    xialaBtnImage = [[[UIImageView alloc] init] autorelease];
    xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-shanglajiantou_03.png"];
    xialaBtnImage.frame = CGRectMake(20.75, 9, 18.5, 13);
    [xiaLaBtn addSubview:xialaBtnImage];
    
    
//    _alipayImage = [[UIImageView alloc] init];
//    _alipayImage.image = UIImageGetImageFromName(@"alipylogsmall.png");
//    _alipayImage.frame = CGRectMake(57.5, 40, 30, 30);
    
//    _qqImage = [[UIImageView alloc] init];
//    _qqImage.frame = CGRectMake(123.5, 40, 30, 30);
//    _qqImage.image = UIImageGetImageFromName(@"qqlogsmall.png");
    
//    _weiboImage = [[UIImageView alloc] init];
//    _weiboImage.frame = CGRectMake(100.5, 40, 30, 30);
//    _weiboImage.image = UIImageGetImageFromName(@"weibologsmall.png");
//    
//    _tenImage = [[UIImageView alloc] init];
//    _tenImage.image = UIImageGetImageFromName(@"tenlogsmall.png");
//    _tenImage.frame = CGRectMake(229.5, 40, 30, 30);
    
    _wximage = [[UIImageView alloc] initWithFrame:CGRectMake(145,40, 30, 30)];
    _wximage.image = UIImageGetImageFromName(@"wxlogsmall.png");
    [_imageView addSubview:_wximage];
    [_wximage release];
    [_imageView addSubview:_alipayImage];
    [_imageView addSubview:_qqImage];
    [_imageView addSubview:_weiboImage];
    [_imageView addSubview:_tenImage];
    
    
    
//    sinaImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    sinaImageView2.frame = CGRectMake(50, 480+180, 90, 90);
//    [sinaImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-xinlangweibozhengchang_1.png"] forState:UIControlStateNormal];
//    [sinaImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-xinlangweibodianji_1"] forState:UIControlStateHighlighted];
//    [sinaImageView2 addTarget:self action:@selector(snBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    sinaImageView2.userInteractionEnabled = YES;
//    [_imageView addSubview:sinaImageView2];
    
    
//    tXWBImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
    tXWBImageView2.frame = CGRectMake(100, 480 + 180 *3, 120, 22);
    //        tXWBImageView2.frame = CGRectMake(180, 480+180, 90, 30);
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
    
    
   
    
    
//    qqImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
    qqImageView2.frame = CGRectMake(50, 480+180*2, 90 , 90);
    [qqImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxun_1.png"] forState:UIControlStateNormal];
    [qqImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-tengxundianji_1.png"] forState:UIControlStateHighlighted];
    [qqImageView2 addTarget:self action:@selector(qqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:qqImageView2];
    
    
    
    
//    apliyImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    apliyImageView2.frame = CGRectMake(180, 480 + 180*2, 90, 90);
//    [apliyImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-zhifubao_1.png"] forState:UIControlStateNormal];
//    [apliyImageView2 setImage:[UIImage imageNamed:@"zhucedenglu-zhifubodianji_1.png"] forState:UIControlStateHighlighted];
//    [apliyImageView2 addTarget:self action:@selector(apBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_imageView addSubview:apliyImageView2];
    
    
    
    WxImageView2 = [UIButton buttonWithType:UIButtonTypeCustom];
    WxImageView2.frame = CGRectMake(115, 480+180, 90, 90);
    [WxImageView2 setImage:[UIImage imageNamed:@"wxlogin.png"] forState:UIControlStateNormal];
    [WxImageView2 setImage:[UIImage imageNamed:@"wxlogin1.png"] forState:UIControlStateHighlighted];
    [WxImageView2 addTarget:self action:@selector(wxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:WxImageView2];
//    if (![WXApi isWXAppInstalled]) {
//        WxImageView2.hidden = YES;
//    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [tapGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.delegate = self;
    
    if (IS_IPHONE_5) {
        // loginWays.frame = CGRectMake(0, 395-8, 320, 22);
        tXWBImageView2.frame = CGRectMake(100, 480 + 180 *3 + 20, 120, 22);
        
    }else{
        tXWBImageView2.frame = CGRectMake(100, 480 + 180 *3 + 10, 120, 22);
        // loginWays.frame = CGRectMake(0, self.mainView.frame.size.height -85-30, 320, 22);
        }
    
//    self.mainView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];

    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{

    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
    
        return YES;
    }
}


- (void)gestureRecognizerHandle:(UITapGestureRecognizer *)tap
{

    if (moveCount == YES)
    {
        [_alipayImage setHidden:YES];
        [_qqImage setHidden:YES];
        [_wximage setHidden:YES];
        [_weiboImage setHidden:YES];
        [_tenImage setHidden:YES];
        
        userNameRepeteView.hidden = YES;
        [self closeUserName];
        
        [ UIImageView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            if (IS_IPHONE_5) {
                
                _imageView.frame = CGRectMake(0, 5, 320, self.mainView.frame.size.height);
                
            }else
            {
                
                _imageView.frame = CGRectMake(0, 5, 320, self.mainView.frame.size.height);
                
            }
            _imageView.alpha = 0.80;
            sinaImageView2.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            
            xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-xialajiantou_03.png"];
            
            
            // 新浪微博登录
            [UIImageView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
            
            
            
            
            
            [UIImageView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
        
        
        
        [UIImageView animateWithDuration:0.2 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
        
        
        
        [UIImageView animateWithDuration:0.2 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
                
                
                
            }];
        }];
        
        
        moveCount = NO;
    }
    else
    {
        
        [UIImageView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (IS_IPHONE_5) {
//                _imageView.frame = CGRectMake(0, self.mainView.frame.size.height-88-53-10, 320, 88);
                _imageView.frame = CGRectMake(0, self.mainView.frame.size.height-88, 320, 88);

                
            }else
            {
                _imageView.frame = CGRectMake(0,480-88-53, 320, 88);
                
            }
            
            
        } completion:^(BOOL finished) {
            [_qqImage setHidden:NO];
            [_wximage setHidden:NO];
            [_tenImage setHidden:NO];
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
        }];
        
        
        moveCount = YES;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mainView.frame = CGRectMake(0, 44 + isIOS7Pianyi, 320, [UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi);
}


- (void)agreeBtnClick:(UIButton *)btn
{

    _index++;
    if (_index % 2) {
        _rightImage.hidden = YES;
    }else
    {
        _rightImage.hidden = NO;
    }
    
}

#pragma mark - 三方登录点击事件

- (void)apBtnClick:(UIButton *)btn
{

    NSLog(@" apl 被点了");
    [MobClick event:@"event_disanfangdenglu" label:@"支付宝"];
#ifdef isYueYuBan
    if (0 && ![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"safepay://"]] &&[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]]) {
        [reqRegister clearDelegatesAndCancel];
        self.reqRegister = [ASIHTTPRequest requestWithURL:[NetURL alipayCanshu]];
        [reqRegister setTimeOutSeconds:20.0];
        [reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqRegister setDidFinishSelector:@selector(AliPayRequestFinisher:)];
        [reqRegister setDelegate:self];
        [reqRegister startAsynchronous];
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


- (void)qqBtnClick:(UIButton *)btn

{
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

    NSLog(@" tx 被点了");
    [MobClick event:@"event_disanfangdenglu" label:@"腾讯微博"];
    SinaBindViewController *sina = [[SinaBindViewController alloc] init];
    
    sina.sinaURL =[NetURL CBUnitonLogin:@"2"];
    sina.unNitionLoginType = UnNitionLoginTypeTeng;
    sina.title = @"腾讯微博登录";
    [self.navigationController pushViewController:sina animated:YES];
    [sina release];

}



-(void)aidBtn
{
    NSLog(@"%@+_%@+_%@",tfNickName.text,tfPassword.text,tfRePassword.text);
    if ([tfNickName.text isEqualToString:@""] || !tfNickName.text) {
        [self toNickName:nil];
    }else if ([tfPassword.text isEqualToString:@""] || !tfPassword.text){
        [self toPassword:nil];
    }else{
        [self toRePassword:nil];
    }
}

- (void)LoadiPadView {

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    if ([self.navigationController.viewControllers count] == 1) {
		self.CP_navigation.leftBarButtonItem = nil;
	}
	
    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(goBackToforiPad) ImageName:@"kf-quxiao2.png"];
    
    backforipad.image = nil;
    backforipad = [[UIImageView alloc] init] ;
    self.mainView.backgroundColor = [UIColor clearColor];
    backforipad.backgroundColor = [UIColor clearColor];
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 540, 570)];
    // backi.image = UIImageGetImageFromName(@"bejing.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    textfiledbackforipad.image = nil;
    textfiledbackforipad.frame = CGRectMake(30, 30, 477, 45.5);
    textfiledbackforipad.image = UIImageGetImageFromName(@"set-input2.png");
    textfiledbackforipad.userInteractionEnabled = YES;
    [self.mainView insertSubview:textfiledbackforipad atIndex:1000];
    
    textfiledbackforipad2.image = nil;
    textfiledbackforipad2.frame = CGRectMake(30, 75.5, 477, 45.5);
    textfiledbackforipad2.image = UIImageGetImageFromName(@"set-input4.png");
    textfiledbackforipad2.userInteractionEnabled = YES;
    [self.mainView insertSubview:textfiledbackforipad2 atIndex:1000];
    
    textfiledbackforipad3.image = nil;
    textfiledbackforipad3.frame = CGRectMake(30, 120.5, 477, 45.5);
    textfiledbackforipad3.image = UIImageGetImageFromName(@"set-input3.png");
    textfiledbackforipad3.userInteractionEnabled = YES;
    [self.mainView insertSubview:textfiledbackforipad3 atIndex:1000];
    
    UILabel *usname = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 40)];
    usname.backgroundColor = [UIColor clearColor];
    usname.text = @"用 户 名 :";
    usname.font = [UIFont systemFontOfSize:14];
    [textfiledbackforipad addSubview:usname];
    [usname release];

    tfNickName.backgroundColor = [UIColor clearColor];
    tfNickName.frame = CGRectMake(90, 10, 350, 30);
    [tfNickName setDelegate:(self)];
    [textfiledbackforipad addSubview:tfNickName];
    
    UILabel *pas = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 80, 40)];
    pas.backgroundColor = [UIColor clearColor];
    pas.text = @"密      码 :";
    pas.font = [UIFont systemFontOfSize:14];
    [textfiledbackforipad2 addSubview:pas];
    [pas release];

    tfPassword.backgroundColor = [UIColor clearColor];
    tfPassword.frame = CGRectMake(90, 7, 350, 30);
    [tfPassword setSecureTextEntry:(YES)];
    [tfPassword setDelegate:(self)];
    [textfiledbackforipad2 addSubview:tfPassword];
    
    UILabel *QRpas = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 80, 40)];
    QRpas.backgroundColor = [UIColor clearColor];
    QRpas.text = @"确认密码 :";
    QRpas.font = [UIFont systemFontOfSize:14];
    [textfiledbackforipad3 addSubview:QRpas];
    [QRpas release];

    tfRePassword.backgroundColor = [UIColor clearColor];
    tfRePassword.frame = CGRectMake(90, 7, 350, 30);
    [tfRePassword setSecureTextEntry:(YES)];
    [tfRePassword setDelegate:(self)];
    [textfiledbackforipad3 addSubview:tfRePassword];
    
    //注册按钮
    zhuceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuceBtn.frame = CGRectMake(30, 185, 477, 30);
    [self.mainView insertSubview:zhuceBtn atIndex:1000];
    
    [zhuceBtn setBackgroundImage:[UIImageGetImageFromName(@"zhuce.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    UILabel *reglabel = [[UILabel alloc] initWithFrame:zhuceBtn.bounds];
    reglabel.backgroundColor = [UIColor clearColor];
    reglabel.text = @"注册";
    reglabel.textAlignment = NSTextAlignmentCenter;
    reglabel.font = [UIFont systemFontOfSize:18];
    reglabel.textColor = [UIColor whiteColor];
    reglabel.shadowColor = [UIColor blackColor];
    reglabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [zhuceBtn addSubview:reglabel];
    [reglabel release];
    zhuceBtn.enabled = NO;
    
    tableviewforiPad.frame = CGRectMake(30, 230, 477, 150);
    [self.mainView insertSubview:tableviewforiPad atIndex:1000];
    
    UIButton *xyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xyBtn.frame = CGRectMake(30, 390, 150, 30);
    [xyBtn addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView insertSubview:xyBtn atIndex:1000];
    
    UILabel *tslabel = [[UILabel alloc] initWithFrame:xyBtn.bounds];
    tslabel.backgroundColor = [UIColor clearColor];
    tslabel.text = @"《投注站使用协议》";
    tslabel.font = [UIFont boldSystemFontOfSize:13];
    tslabel.textColor = [UIColor colorWithRed:0/255.0 green:120/255.0 blue:232/255.0 alpha:1];
    [xyBtn addSubview:tslabel];
    [tslabel release];


}



#pragma mark - 使用其他方式登录事件


- (void)xiaLaBtnClick1
{
    

    if (moveCount == YES)
    {
        [_alipayImage setHidden:YES];
        [_qqImage setHidden:YES];
        [_weiboImage setHidden:YES];
        [_tenImage setHidden:YES];
        [_wximage setHidden:YES];
        userNameRepeteView.hidden = YES;
        [self closeUserName];
        
        
        [ UIImageView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            if (IS_IPHONE_5) {
                
                _imageView.frame = CGRectMake(0, 5, 320, self.mainView.frame.size.height);

            }else
            {
            
                _imageView.frame = CGRectMake(0, 5, 320, self.mainView.frame.size.height);
 
            }
            _imageView.alpha = 0.80;
            sinaImageView2.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            
            xialaBtnImage.image = [UIImage imageNamed:@"gp-zhucedenglu-xialajiantou_03.png"];
            
            
            // 新浪微博登录
            [UIImageView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
            
            
            
            
            
            
            [UIImageView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
        
        
        
        [UIImageView animateWithDuration:0.2 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
        
        
        
        [UIImageView animateWithDuration:0.2 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
                
               
                
            }];
        }];
        
        
        moveCount = NO;
    }
    else
    {
        
        [UIImageView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (IS_IPHONE_5) {
                // _imageView.frame = CGRectMake(0, self.mainView.frame.size.height-88-53-10, 320, 88);
                _imageView.frame = CGRectMake(0, self.mainView.frame.size.height-88, 320, 88);

                
            }else
            {
                _imageView.frame = CGRectMake(0,480-88-53, 320, 88);
                
            }
            
            
        } completion:^(BOOL finished) {
            [_qqImage setHidden:NO];
            [_wximage setHidden:NO];
            [_tenImage setHidden:NO];
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
        }];
        
        
        moveCount = YES;
    }
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.CP_navigation setTitle:(@"注册")];
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doCanCel)];
    [self.CP_navigation setLeftBarButtonItem:leftItem];

#ifdef  isCaiPiaoForIPad
   // [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
    
    sugestArray = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithObjects:@"小小鸟",@"熊爸爸",@"熊爸爸",@"熊宝宝",@"熊妈妈",@"熊哥哥",@"熊弟弟", nil];
    [sugestArray addObjectsFromArray:array];
    _count = 0;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.delegate = self;
    [self.mainView addGestureRecognizer: tapGR];
    [tapGR release];
    
}

- (void)goBackToforiPad
{
	
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}

- (void)viewDidUnload
{
    self.registerProgressHud = nil;
//    self.tfNickName = nil;
//    self.tfPassword = nil;
//    self.tfRePassword = nil;
    
//    [self setTfNickNameBackgroundImageView:nil];
//    [self setTfPasswordBackgroundImageView:nil];
//    [self setTfRePasswordBackgroundImageView:nil];
    
//    [self setImageView:nil];
//    [self setAlipayImage:nil];
//    [self setQqImage:nil];
//    [self setWeiboImage:nil];
//    [self setTenImage:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)doCanCel
{
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)doFinish
{
    [self.tfNickName resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    [self.tfRePassword resignFirstResponder];
   
    
    if ([self doCheck]) 
    {
    MBProgressHUD *tmpProgressHud = [[MBProgressHUD alloc]initWithView:self.mainView];
        
    self.registerProgressHud = tmpProgressHud;
    [tmpProgressHud release];
        self.registerProgressHud.hidden = NO;
        self.registerProgressHud.removeFromSuperViewOnHide = YES;
        self.registerProgressHud.mode = MBProgressHUDModeIndeterminate;
        self.registerProgressHud.labelText = @"注册处理中...";
#ifdef isCaiPiaoForIPad
        [self.mainView addSubview:self.registerProgressHud];
#else
        UIWindow* _window = [[UIApplication sharedApplication] keyWindow];
        [_window addSubview:self.registerProgressHud];
#endif



    [self.registerProgressHud show:YES];

        NSString *nickname = tfNickName.text;
        self.password = tfPassword.text;        
        [reqRegister clearDelegatesAndCancel];
        self.reqRegister = [ASIHTTPRequest requestWithURL:[NetURL CBregister:(nickname) passWord:(password)]];
        [reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqRegister setDelegate:self];
        [reqRegister startAsynchronous];
    }
}


- (void)checkNickName
{

    NSString *nickNameStr = tfNickName.text;
    NSStringEncoding gb2312 = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    unsigned short nickNameStrLen = [nickNameStr lengthOfBytesUsingEncoding:(gb2312)];

    if ([nickNameStr length] == 0)
    {
        _isNickNamePass = NO;
    }
    else if([nickNameStr isAllNumber])
    {
        _isNickNamePass = NO;
    }
    else if ([nickNameStr isContainSign])
    {
        _isNickNamePass = NO;
    }
    else if (nickNameStrLen < 6||nickNameStrLen > 16)
    {
        _isNickNamePass = NO;
    }
    else
    {
        
        _isNickNamePass = YES;
    }

}

- (void)checkPassWord
{
    NSString *psdStr = tfPassword.text;
//    if ([psdStr isContainCapital])
//    {
//        _isPassWordPass = NO;
//    }
//    else if (![psdStr isConform])
//    {
//        _isPassWordPass = NO;
//    }
//    else if([psdStr length] < 6||[psdStr length] > 16)
//    {
//        _isPassWordPass = NO;
//    }else if([psdStr isAllNumber])
//    {
//        if ([psdStr isAllNumber]) {
//            _isPassWordPass = NO;
//        }
//        
//        NSInteger len = [psdStr length];
//        const char* data = [psdStr UTF8String];
//        int tmp1 = 0;
//        int a = 1;
//        int b = 1;
//        int c = 1;
//        int t1 = 0;
//        
//        tmp1 = data[0];
//        for( int i = 1 ; i< len ;i++)
//        {
//            t1 =  data[i]  - tmp1;
//            if( t1 == 0)
//            {
//                a+=1;
//            }
//            else if(t1 == 1)
//            {
//                b+=1;
//            }
//            else if(t1 == -1)
//            {
//                c+=1;
//            }
//            tmp1 = data[i];
//        }
//        
//        if(a == len && b == 1 && c == 1)
//        {
//            _isPassWordPass = NO;
//        }
//        else if(a == 1 &&  b == len && c == 1)
//        {
//            _isPassWordPass = NO;
//        }
//        else if(a == 1 && b == 1 && c == len)
//        {
//           
//            _isPassWordPass = NO;
//        }
//    }
    
    if ([psdStr length] > 5 &&[psdStr length] < 17) {
        _isPassWordPass = YES;
        _isRePassWordPass = YES;
    }
    else{
        _isPassWordPass = NO;
        _isRePassWordPass = NO;
    }
   

    
}

- (void)checkRePassWord
{
    
    
    
    NSString *psdStr = tfPassword.text;
    NSString *rePsdStr = tfRePassword.text;
    
//    if(![psdStr isEqualToString:rePsdStr]) {
//        _isRePassWordPass = NO;
//	}
//    else if ([psdStr isEqualToString:nickNameStr]) {
//        
//        _isRePassWordPass = NO;
//    }else if (![rePsdStr isEqualToString:psdStr])
//    {
//        _isRePassWordPass = NO;
//    }
    
    if (![psdStr isEqualToString:rePsdStr]) {
        _isRePassWordPass = NO;
    }else {
        if (rePsdStr) {
            _isRePassWordPass = YES;
        }else {
        
            _isRePassWordPass = NO;
        }
    
    }
    
    
    
}



- (BOOL)doCheck
{
    
    NSString *message;
    BOOL isPass = YES;
    NSString *nickNameStr = tfNickName.text;
    NSString *psdStr = tfPassword.text;
    NSString *rePsdStr = tfRePassword.text;
    
    NSStringEncoding gb2312 = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    unsigned short nickNameStrLen = [nickNameStr lengthOfBytesUsingEncoding:(gb2312)];
    NSLog(@"-------%d", nickNameStrLen);
    
    if ([nickNameStr length] == 0) 
    {
        message = @"用户名不能为空";
		[tfNickName Shake];
        [tfNickName becomeFirstResponder];
        isPass = NO;
        _isNickNamePass = NO;
    }
    else if([nickNameStr isAllNumber])
    {        
        message = @"用户名不能全为数字";
		[tfNickName Shake];
        [tfNickName becomeFirstResponder];
        isPass = NO;
        _isNickNamePass = NO;
    }
    else if ([nickNameStr isContainSign])
    {
        message = @"用户名不符合要求";
		[tfNickName Shake];
        [tfNickName becomeFirstResponder];
        isPass = NO;
        _isNickNamePass = NO;
    }
    else if (nickNameStrLen < 6||nickNameStrLen > 16)
    {
        message = @"用户名请输入6-16位字符";
		[tfNickName Shake];
        [tfNickName becomeFirstResponder];
        isPass = NO;
        _isNickNamePass = NO;
    }
    else
    {
    
        _isNickNamePass = YES;
    }
    
    if ([psdStr length] == 0)
    {
        message = @"密码不能为空";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
    }
    else if ([psdStr isContainCapital])
    {
        message = @"密码不能为大写字母";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
    }
    else if (![psdStr isConform])
    {
        message = @"密码不符合要求";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
    }
    else if([psdStr length] < 6||[psdStr length] > 16)
    {
        message = @"密码请输入6-16位字符";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
    }
	else if(![psdStr isEqualToString:rePsdStr]) {
		message = @"密码和确认密码不一致";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
	}
    else if ([psdStr isEqualToString:nickNameStr]) {
    
        message = @"用户名和密码不能相同";
		[tfPassword Shake];
        [tfPassword becomeFirstResponder];
        isPass = NO;
    }

    else if([psdStr isAllNumber])
    {                
        if ([psdStr isAllNumber]) {
            message = @"密码不能由纯数字构成";
            isPass = NO;
        }
        
        NSInteger len = [psdStr length];
        const char* data = [psdStr UTF8String];
        int tmp1 = 0;
        int a = 1;
        int b = 1;
        int c = 1;
        int t1 = 0;
        
        tmp1 = data[0];
        for( int i = 1 ; i< len ;i++)
        {
            t1 =  data[i]  - tmp1;
            if( t1 == 0)
            {
                a+=1;
            }
            else if(t1 == 1)
            {
                b+=1;
            }
            else if(t1 == -1)
            {
                c+=1;
            }
            tmp1 = data[i];
        }
        
        if(a == len && b == 1 && c == 1)
        {
            message = @"密码不能为相同数字";
            isPass = NO;
        }
        else if(a == 1 &&  b == len && c == 1)
        {
            message = @"密码不能为连续数字";
            isPass = NO;
        }
        else if(a == 1 && b == 1 && c == len)
        {
            message = @"密码不能为连续数字";
            isPass = NO;
        }
    }
    else{
    }
    if (![rePsdStr isEqualToString:psdStr])
    {
        message = @"您两次输入密码不一致，请重新填写";
		[tfRePassword Shake];
        [tfRePassword becomeFirstResponder];
        isPass = NO;
        _isRePassWordPass = NO;
    }else{
        _isRePassWordPass = YES;
    }
        
    if (!isPass) 
    {
        [tfPassword Shake];
        [tfPassword becomeFirstResponder];
        
        UIImageView *tiShiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -100, 320, 100)];
        tiShiImageView.image = [UIImage imageNamed:@"OPPS.png"];
        tiShiImageView.alpha = 0;
        UILabel *tiShiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20,320, 20)];
        tiShiLabel.text = message;
        tiShiLabel.font = [UIFont systemFontOfSize:15];
        tiShiLabel.textColor = [UIColor whiteColor];
        tiShiLabel.backgroundColor = [UIColor clearColor];
        tiShiLabel.textAlignment = NSTextAlignmentCenter;
        [tiShiImageView addSubview:tiShiLabel];
        [tiShiLabel release];
        
        [self.mainView addSubview:tiShiImageView];
        [UIImageView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tiShiImageView.frame = CGRectMake(0, 0, 320, 100);
            tiShiImageView.alpha = 1;
        } completion:^(BOOL finished) {
    
            [UIImageView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                tiShiImageView.frame = CGRectMake(0, -100, 320, 100);
            } completion:^(BOOL finished) {
            
                
            }];
            
        }];
        
        
        
    }
    if (isPass) {
        [tfRePassword setSecureTextEntry:YES];
    }
    return isPass;
}




//- (IBAction)pressZhuCe:(id)sender{
//    
//    if (_index%2 == 0) {
//        [self doFinish];
//    }
//}

- (void)pressZhuCe:(id)sender{
    
    if (_index%2 == 0) {
        [self doFinish];
    }
    else {
        [[caiboAppDelegate getAppDelegate] showMessage:@"请同意委托投注协议"];
    }
}

- (void)alipayLogin:(NSURL *)url {
}

- (void)WXCodeFinished:(ASIHTTPRequest *)request {
    NSDictionary *dic = [request.responseString JSONValue];
    if ([dic valueForKey:@"access_token"]) {
        [reqRegister clearDelegatesAndCancel];
        self.reqRegister = [ASIHTTPRequest requestWithURL:[NetURL loginUnionWithloginSource:@"10" unionId:[dic valueForKey:@"openid"] token:[dic valueForKey:@"access_token"] tokenSecret:@"" openid:@"" userId:@""]];
        [reqRegister setTimeOutSeconds:20.0];
        [reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqRegister setDidFinishSelector:@selector(unitionRequestFinisher:)];
        [reqRegister setDelegate:self];
        [reqRegister startAsynchronous];
    }
    else {
        [mStatePV dismiss];
    }
}

- (void)WXLogin:(NSString *)code {
    if ([code length] == 0) {
        
        return;
    }
    unNitionLoginType = UnNitionLoginTypeWX;
    mStatePV = [StatePopupView getInstance];
    [mStatePV showInView:self.mainView Text:@"登录中..."];
    [reqRegister clearDelegatesAndCancel];
    self.reqRegister = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx0cfdf60c4c082b3b&secret=35f941b12366a80ea1188ae1ce82cb78&code=%@&grant_type=authorization_code",code]]];
    [reqRegister setTimeOutSeconds:20.0];
    [reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqRegister setDidFinishSelector:@selector(WXCodeFinished:)];
    [reqRegister setDelegate:self];
    [reqRegister startAsynchronous];
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



- (IBAction)xieyi{
    
#ifdef isCaiPiaoForIPad
    
    Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Xieyi;
	[self.navigationController pushViewController:xie animated:YES];
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365xieyi.txt"];
	NSData *fileData = [fileManager contentsAtPath:path];
    if (fileData) {
		NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        xie.infoText.text = str;
		
		[str release];
	}
	xie.title = @"同城用户服务协议";
	[xie release];

#else
   
    

    
    Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Xieyi;
	[self.navigationController pushViewController:xie animated:YES];

    
    
#ifdef isHaoLeCai
    xie.title = @"好乐彩服务协议";
#else
	xie.title = @"同城用户服务协议";
    
    

    
#endif
	[xie release];

#endif
	
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    [tfNickName resignFirstResponder];
    [tfPassword resignFirstResponder];
    [tfRePassword resignFirstResponder];
}

#pragma mark -
#pragma mark 重写UITextFieldDelegate接口

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
	if (textField == tfNickName) 
    {
		[tfPassword becomeFirstResponder];
	}
	else if (textField == tfPassword)
    {
        [tfRePassword becomeFirstResponder];
       
	}
    else if (textField == tfRePassword)
    {
        [textField resignFirstResponder];
      
    }
	 
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	self.CP_navigation.rightBarButtonItem.enabled = NO;
    zhuceBtn.enabled = NO;
    aidBtn.hidden = NO;
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField ==tfNickName) {
		if ([tfPassword.text length]&&[tfRePassword.text length]&&([textField.text length]>1||[string length])) {
			self.CP_navigation.rightBarButtonItem.enabled = YES;
            zhuceBtn.enabled= YES;
            aidBtn.hidden = YES;
		}
		else {
			self.CP_navigation.rightBarButtonItem.enabled = NO;
            zhuceBtn.enabled= NO;
            aidBtn.hidden = NO;
		}
	}
	else if(textField ==tfPassword) {
		if ([tfNickName.text length]&&[tfRePassword.text length]&&([textField.text length]>1||[string length])) {
			self.CP_navigation.rightBarButtonItem.enabled = YES;
            zhuceBtn.enabled= YES;
            aidBtn.hidden = YES;
           
            
           
		}
		else {
			self.CP_navigation.rightBarButtonItem.enabled = NO;
            zhuceBtn.enabled= NO;
            aidBtn.hidden = NO;
		}
	}
	else {
		if ([tfNickName.text length]&&[tfPassword.text length]&&([textField.text length]>1||[string length])) {
			self.CP_navigation.rightBarButtonItem.enabled = YES;
            zhuceBtn.enabled= YES;
            aidBtn.hidden = YES;
            
        }
		else {
			self.CP_navigation.rightBarButtonItem.enabled = NO;
            zhuceBtn.enabled= NO;
            aidBtn.hidden = NO;
		}
	}

	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == tfNickName) {
        tfNickName.rightView = nil;
        tfNickName.textColor = [UIColor blackColor];
        userNameRepeteView.hidden = YES;
        [self closeUserName];
    }else if (textField == tfRePassword) {
        tfRePassword.textColor = [UIColor blackColor];
        tfRePassword.rightView = nil;
    }else if(textField == tfPassword){
    
        tfPassword.textColor = [UIColor blackColor];
        tfPassword.rightView = nil;
    }

}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
    if (textField == tfNickName) {
        [self checkNickName];
        if (_isNickNamePass) {
            
            UIImageView *rightMG = [[[UIImageView alloc] init] autorelease];
            rightMG.image = [UIImage imageNamed:@"zhuce-tishiright.png"];
            rightMG.frame = CGRectMake(0, 0, 9, 9);
            rightMG.backgroundColor = [UIColor clearColor];
            rightMG.backgroundColor = [UIColor clearColor];
            UIView *rightView = [[[UIView alloc] init] autorelease];
            rightView.frame = CGRectMake(0, 0, 9+10, 9);
            rightView.backgroundColor = [UIColor clearColor];
            [rightView addSubview:rightMG];
            
            
            tfNickName.rightView = rightView;
            tfNickName.rightViewMode = UITextFieldViewModeAlways;
        }else{
            
            UIImageView *wrongMG = [[[UIImageView alloc] init] autorelease];
            wrongMG.backgroundColor = [UIColor clearColor];
            wrongMG.image = [UIImage imageNamed:@"zhuce-tishicuo.png"];
            wrongMG.frame = CGRectMake(0, 0, 9, 9);
            wrongMG.backgroundColor = [UIColor clearColor];
            
            UIView *wrongView = [[[UIView alloc] init] autorelease];
            wrongView.frame = CGRectMake(0, 0, 9+10, 9);
            wrongView.backgroundColor = [UIColor clearColor];
            [wrongView addSubview:wrongMG];
            
            tfNickName.rightView = wrongView;
            tfNickName.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    
  else  if (textField == tfPassword) {
         [self checkPassWord];
        if (_isPassWordPass) {
            
            UIImageView *rightMG = [[[UIImageView alloc] init] autorelease];
            rightMG.image = [UIImage imageNamed:@"zhuce-tishiright.png"];
            rightMG.frame = CGRectMake(0, 0, 9, 9);
            rightMG.backgroundColor = [UIColor clearColor];
            rightMG.backgroundColor = [UIColor clearColor];
            UIView *rightView = [[[UIView alloc] init] autorelease];
            rightView.frame = CGRectMake(0, 0, 9+10, 9);
            rightView.backgroundColor = [UIColor clearColor];
            [rightView addSubview:rightMG];
            
            tfPassword.rightView = rightView;
            tfPassword.rightViewMode = UITextFieldViewModeAlways;
            tfPassword.textColor = [UIColor blackColor];
        }else{
            
            UIImageView *wrongMG = [[[UIImageView alloc] init] autorelease];
            wrongMG.backgroundColor = [UIColor clearColor];
            wrongMG.image = [UIImage imageNamed:@"zhuce-tishicuo.png"];
            wrongMG.frame = CGRectMake(0, 0, 9, 9);
            wrongMG.backgroundColor = [UIColor clearColor];
            
            UIView *wrongView = [[[UIView alloc] init] autorelease];
            wrongView.frame = CGRectMake(0, 0, 9+10, 9);
            wrongView.backgroundColor = [UIColor clearColor];
            [wrongView addSubview:wrongMG];
            
            tfPassword.rightView = wrongView;
            tfPassword.rightViewMode = UITextFieldViewModeAlways;
            tfPassword.textColor = [UIColor redColor];
        }
      if ([tfPassword.text length]== 0) {
          tfPassword.rightView = nil;
      }
      
      
      
      
    }
  else  if (textField == tfRePassword) {
        
         [self checkRePassWord];
      
        if (_isRePassWordPass) {
            
            UIImageView *rightMG = [[[UIImageView alloc] init] autorelease];
            rightMG.image = [UIImage imageNamed:@"zhuce-tishiright.png"];
            rightMG.frame = CGRectMake(0, 0, 9, 9);
            rightMG.backgroundColor = [UIColor clearColor];
            rightMG.backgroundColor = [UIColor clearColor];
            UIView *rightView = [[[UIView alloc] init] autorelease];
            rightView.frame = CGRectMake(0, 0, 9+10, 9);
            rightView.backgroundColor = [UIColor clearColor];
            [rightView addSubview:rightMG];
            
            tfRePassword.rightView = rightView;
            tfRePassword.rightViewMode = UITextFieldViewModeAlways;
            tfRePassword.textColor = [UIColor blackColor];
        }else{
            UIImageView *wrongMG = [[[UIImageView alloc] init] autorelease];
            wrongMG.backgroundColor = [UIColor clearColor];
            wrongMG.image = [UIImage imageNamed:@"zhuce-tishicuo.png"];
            wrongMG.frame = CGRectMake(0, 0, 9, 9);
            wrongMG.backgroundColor = [UIColor clearColor];
            
            UIView *wrongView = [[[UIView alloc] init] autorelease];
            wrongView.frame = CGRectMake(0, 0, 9+10, 9);
            wrongView.backgroundColor = [UIColor clearColor];
            [wrongView addSubview:wrongMG];
            
            tfRePassword.rightView = wrongView;
            tfRePassword.rightViewMode = UITextFieldViewModeAlways;
            tfRePassword.textColor = [UIColor redColor];
        }
      if ([tfRePassword.text length] == 0) {
          tfRePassword.rightView = nil;
      }
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    return  YES;
}

#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

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
        
        if (unNitionLoginType== UnNitionLoginTypeAlipay) {
            [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"isAlipay"];
        }else if (unNitionLoginType == UnNitionLoginTypeSina) {
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"isUnionType"];
        }
        
        
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.lastAccount = YES;
        [appDelegate DologinSave];
        [appDelegate LogInBySelf];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
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
    [caiboAppDelegate getAppDelegate].loginselfcount = 0;
	NSString *responseStr = [request responseString];
    if (responseStr == nil||[responseStr isEqualToString:@"fail"]) 
    {
    [self.registerProgressHud removeFromSuperview];
        [Info showCancelDialog:@"提示" :@"注册失败" :self];
    }
    else
    {
    [self.registerProgressHud removeFromSuperview];
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        
        if (dic)
        {

            self.hongbaoMes = [NSString stringWithFormat:@"%@",[dic objectForKey:@"hongbaoMsg"]];
            
            NSString *resultStr = [dic valueForKey:@"result"];
            if (resultStr && [resultStr length] > 0) {
                if ([resultStr isEqualToString:@"0"]) 
                {
                    Info *mInfo = [Info getInstance];
                    mInfo.userId = [[dic valueForKey:@"id"] stringValue];
                    mInfo.nickName = [dic valueForKey:@"nickname"];
					mInfo.login_name = tfNickName.text;
                    mInfo.password = @"";
                    NSLog(@"password = %@", mInfo.password);
                    
                    NSString *headUrl = [Info strFormatWithUrl:[dic valueForKey:@"head_url"]];
                    if (headUrl) 
                    {
                        NSURL *imageUrl = [NSURL URLWithString:headUrl];
                        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                        mInfo.headImage = [UIImage imageWithData:imageData];
                    } 
					[User insertDB:mInfo];
					
					[reqRegister clearDelegatesAndCancel];
					self.reqRegister = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:tfNickName.text passWord:password]];
					[reqRegister setTimeOutSeconds:20.0];
					[reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
					[reqRegister setDelegate:self];
					[reqRegister setDidFinishSelector:@selector(requestLoginFinished:)];
					[reqRegister startAsynchronous];
                }
                else if ([resultStr isEqualToString:@"1"]) 
                {
                    [Info showCancelDialog:@"提示" :@"注册失败" :self];
					[tfNickName becomeFirstResponder];
					[tfNickName Shake];
                }
                else if ([resultStr isEqualToString:@"3"])
                {
                    


                    NSDictionary *dic = [responseStr JSONValue];
                    sugestArray = [dic objectForKey:@"reNickName"];
                  
                

                    if (!userNameRepeteView)
                    {
                        userNameRepeteView = [[UIImageView alloc] init];
                        userNameRepeteView.frame = CGRectMake(15,75.5,290 ,121);
                        userNameRepeteView.backgroundColor = [UIColor clearColor];
                        userNameRepeteView.image = [UIImage imageNamed:@"zucefuxuan.png"];
                        
                        
                    }else
                    {
                         userNameRepeteView.hidden = NO;
                         userNameRepeteView.frame = CGRectMake(15,75.5,290 ,121);
                    }
                    for (UIView *v in userNameRepeteView.subviews) {
                        [v removeFromSuperview];
                    }
                    
                    
                    UIImageView *yuanView = [[[UIImageView alloc] init] autorelease];
                    yuanView.backgroundColor = [UIColor clearColor];
                    yuanView.image = [UIImage imageNamed:@"yonghumingfuxuanyuan.png"];
                    yuanView.frame = CGRectMake(15, 50, 62.5, 62.5);
                    [userNameRepeteView addSubview:yuanView];
                    
                    
                    
                    // 提示语
                    UILabel *reminderLabel = [[[UILabel alloc] init] autorelease];
                    reminderLabel.frame = CGRectMake(0, 10, 290, 32);
                    reminderLabel.text = @"主人 此用户名已被注册 建议选择推荐用户名";
                    reminderLabel.textAlignment = NSTextAlignmentCenter;
                    reminderLabel.textColor = [UIColor whiteColor];
                    reminderLabel.font = [UIFont systemFontOfSize:12];
                    reminderLabel.backgroundColor = [UIColor clearColor];
                    [userNameRepeteView addSubview:reminderLabel];
                    
                    
                    userNameRepeteView.userInteractionEnabled = YES;
                    [self.mainView addSubview:userNameRepeteView];
                    userNameRepeteView.hidden = NO;
                    
                    NSString * nameString = @"";
                    if (sugestArray.count) {
                        nameString = [sugestArray objectAtIndex:0];
                    }
                    CGSize userName = [nameString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(320, 100) lineBreakMode:NSLineBreakByWordWrapping] ;
                    
                        
                    if (sugestArray.count>3) {
                        
                        if (userName.width < 80) {
                            for (int i = 0; i<2; i++) {
                                for (int j = 0; j<2; j++) {
                                    UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                                    suggestUserN.frame = CGRectMake(97+j*96.5, 32+i*38.5+20 , 95, 52);
                                    suggestUserN.backgroundColor = [UIColor clearColor];
                                    [suggestUserN setTitle:[sugestArray objectAtIndex:j+i*2] forState:UIControlStateNormal];
                                    [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                    [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                    suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                                    suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                                    [userNameRepeteView addSubview:suggestUserN];
                                
                                    
                                    CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                                    [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth.width)];
                                    UIImageView *repeatLine = [[UIImageView alloc] init];
                                    repeatLine.frame = CGRectMake(97+j*96.5, 32+i*38.5+20+18, repeatLineWidth.width, 1.5);
                                    repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                                    [userNameRepeteView addSubview:repeatLine];
                                    [repeatLine release];
                                    
                                    
                                }
                            }
                        }else{
                        
                            for (int i = 0; i <2; i++) {
                                
                                UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                                suggestUserN.frame = CGRectMake(97+25, 32+i*38.5+20 ,290-97 , 52);
                                suggestUserN.backgroundColor = [UIColor clearColor];
                                [suggestUserN setTitle:[sugestArray objectAtIndex:i] forState:UIControlStateNormal];
                                [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                                suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                                [userNameRepeteView addSubview:suggestUserN];

                                CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                                [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth.width)];

                                UIImageView *repeatLine = [[UIImageView alloc] init];
                                repeatLine.frame = CGRectMake(97+25, 32+i*38.5+20+18, repeatLineWidth.width, 1.5);
                                repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                                [userNameRepeteView addSubview:repeatLine];
                                [repeatLine release];
                                
                            }
                        }
                    }else if (sugestArray.count > 2) {
                        if (userName.width < 80) {
                            UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN.frame = CGRectMake(97, 32+20 , 95, 52);
                            suggestUserN.backgroundColor = [UIColor clearColor];
                            [suggestUserN setTitle:[sugestArray objectAtIndex:0] forState:UIControlStateNormal];
                            [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                            [userNameRepeteView addSubview:suggestUserN];
                            
                            CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth.width)];
                            UIImageView *repeatLine = [[UIImageView alloc] init];
                            repeatLine.frame = CGRectMake(97, 32+20+18, repeatLineWidth.width, 1.5);
                            repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine];
                            [repeatLine release];
                            
                            
                            UIButton *suggestUserN1 = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN1.frame = CGRectMake(97+96.5, 32+20 , 95, 52);
                            suggestUserN1.backgroundColor = [UIColor clearColor];
                            [suggestUserN1 setTitle:[sugestArray objectAtIndex:1] forState:UIControlStateNormal];
                            [suggestUserN1 addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN1.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN1.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN1];
                            
                            CGSize repeatLineWidth1 = [suggestUserN1.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth1.width)];

                            UIImageView *repeatLine1 = [[UIImageView alloc] init];
                            repeatLine1.frame = CGRectMake(97+96.5, 32+20+18, repeatLineWidth1.width, 1.5);
                            repeatLine1.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine1];
                            [repeatLine1 release];
                            
                            
                            UIButton *suggestUserN2 = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN2.frame = CGRectMake(97, 32+38.5+20 , 95, 52);
                            suggestUserN2.backgroundColor = [UIColor clearColor];
                            [suggestUserN2 setTitle:[sugestArray objectAtIndex:2] forState:UIControlStateNormal];
                            [suggestUserN2 addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN2.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN2.titleLabel.textAlignment = NSTextAlignmentLeft;
                            suggestUserN2.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN2];
                            
                            CGSize repeatLineWidth2 = [suggestUserN2.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth2.width)];
                            UIImageView *repeatLine2 = [[UIImageView alloc] init];
                            repeatLine2.frame = CGRectMake(97, 32+20+38.5+18, repeatLineWidth2.width, 1.5);
                            repeatLine2.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine2];
                            [repeatLine2 release];
                            
                        }else{
                            
                            UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN.frame = CGRectMake(97+25, 32+20 , 290-97, 52);
                            suggestUserN.backgroundColor = [UIColor clearColor];
                            [suggestUserN setTitle:[sugestArray objectAtIndex:0] forState:UIControlStateNormal];
                            [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN];
                            
                            CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth.width)];

                            UIImageView *repeatLine = [[UIImageView alloc] init];
                            repeatLine.frame = CGRectMake(97+25, 32+20+18, repeatLineWidth.width, 1.5);
                            repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine];
                            [repeatLine release];
                            
                            
                            
                            UIButton *suggestUserN2 = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN2.frame = CGRectMake(97+25, 32+38.5+20 , 193, 52);
                            suggestUserN2.backgroundColor = [UIColor clearColor];
                            [suggestUserN2 setTitle:[sugestArray objectAtIndex:1] forState:UIControlStateNormal];
                            [suggestUserN2 addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN2.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN2.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN2];
                            
                            
                            CGSize repeatLineWidth2 = [suggestUserN2.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth2.width)];

                            UIImageView *repeatLine2 = [[UIImageView alloc] init];
                            repeatLine2.frame = CGRectMake(97+25, 32+38.5+20+18, repeatLineWidth2.width, 1.5);
                            repeatLine2.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine2];
                            [repeatLine2 release];
                            
                            
                            
                        }
                        
                        
                    }else if (sugestArray.count > 1){
                        
                        if (userName.width < 80) {
                            UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN.frame = CGRectMake(97, 32+20+15 , 95, 52);
                            suggestUserN.backgroundColor = [UIColor clearColor];
                            [suggestUserN setTitle:[sugestArray objectAtIndex:0] forState:UIControlStateNormal];
                            [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN];
                            
                            CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth.width)];

                            UIImageView *repeatLine = [[UIImageView alloc] init];
                            repeatLine.frame = CGRectMake(97, 32+20+18+15, repeatLineWidth.width, 1.5);
                            repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine];
                            [repeatLine release];
                            
                            
                            
                            
                            UIButton *suggestUserN1 = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN1.frame = CGRectMake(97+96.5, 32+20+15 , 95, 52);
                            suggestUserN1.backgroundColor = [UIColor clearColor];
                            [suggestUserN1 setTitle:[sugestArray objectAtIndex:1] forState:UIControlStateNormal];
                            [suggestUserN1 addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN1.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN1.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN1];
                            
                            CGSize repeatLineWidth1 = [suggestUserN1.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 95-repeatLineWidth1.width)];

                            UIImageView *repeatLine1 = [[UIImageView alloc] init];
                            repeatLine1.frame = CGRectMake(97+96.5, 32+20+18+15, repeatLineWidth1.width, 1.5);
                            repeatLine1.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine1];
                            [repeatLine1 release];
                            
                            
                            
                        }else{
                            
                            UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN.frame = CGRectMake(97+25, 32+20 , 290-97, 52);
                            suggestUserN.backgroundColor = [UIColor clearColor];
                            [suggestUserN setTitle:[sugestArray objectAtIndex:0] forState:UIControlStateNormal];
                            suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                            [userNameRepeteView addSubview:suggestUserN];
                            
                            CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth.width)];

                            UIImageView *repeatLine = [[UIImageView alloc] init];
                            repeatLine.frame = CGRectMake(97+25, 32+20+18, repeatLineWidth.width, 1.5);
                            repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine];
                            [repeatLine release];
                            
                            
                            
                            UIButton *suggestUserN2 = [UIButton buttonWithType:UIButtonTypeCustom];
                            suggestUserN2.frame = CGRectMake(97+25, 32+38.5+20 , 193, 52);
                            suggestUserN2.backgroundColor = [UIColor clearColor];
                            [suggestUserN2 setTitle:[sugestArray objectAtIndex:1] forState:UIControlStateNormal];
                            [suggestUserN2 addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            [suggestUserN2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            suggestUserN2.titleLabel.font = [UIFont systemFontOfSize:12];
                            suggestUserN2.titleLabel.textAlignment = NSTextAlignmentLeft;
                            [userNameRepeteView addSubview:suggestUserN2];
                            
                            CGSize repeatLineWidth2 = [suggestUserN2.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                            [suggestUserN2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth2.width)];

                            UIImageView *repeatLine2 = [[UIImageView alloc] init];
                            repeatLine2.frame = CGRectMake(97+25, 32+38.5+20+18, repeatLineWidth2.width, 1.5);
                            repeatLine2.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                            [userNameRepeteView addSubview:repeatLine2];
                            [repeatLine2 release];
                            
                            
                        }
                        
                        
                    }else if (sugestArray.count > 0) {
                        
                        UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                        suggestUserN.frame = CGRectMake(97+25, 32+20+15 , 290-97, 52);
                        suggestUserN.backgroundColor = [UIColor clearColor];
                        [suggestUserN setTitle:[sugestArray objectAtIndex:0] forState:UIControlStateNormal];
                        [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                        suggestUserN.titleLabel.textAlignment = NSTextAlignmentLeft;
                        [userNameRepeteView addSubview:suggestUserN];
                        
                        CGSize repeatLineWidth = [suggestUserN.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByCharWrapping];
                        [suggestUserN setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 193-repeatLineWidth.width)];

                        UIImageView *repeatLine = [[UIImageView alloc] init];
                        repeatLine.frame = CGRectMake(97+25, 32+20+18+15, repeatLineWidth.width, 1.5);
                        repeatLine.image = [UIImage imageNamed:@"yonghumingfuxuanxian.png"];
                        [userNameRepeteView addSubview:repeatLine];
                        [repeatLine release];
                        
                        
                    }else{
                    
                                        // *****
//                                        [Info showCancelDialog:@"提示" :@"昵称已存在" :self];
                        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"昵称已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];

                        [tfNickName Shake];
                        userNameRepeteView.hidden = YES;
                        
                    }
                    
                    
                    
                    
                    
                    
                    

                    
                    
#if 0
                    if ([sugestArray count]>2) {
                        
                            for (int i = 0; i < sugestArray.count/3; i ++)
                            {
                                
                                for (int j = 0 ; j< 3; j++)
                                {
                                    
                                    
                                    UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                                    suggestUserN.frame = CGRectMake(j*107, 32+i*40 , 106, 40);
                                    suggestUserN.backgroundColor = [UIColor clearColor];
                                    [suggestUserN setTitle:[sugestArray objectAtIndex:j+i*3] forState:UIControlStateNormal];
                                    [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                    [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                    suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                                    [userNameRepeteView addSubview:suggestUserN];
                                    NSLog(@"sugestArray ========= %d",sugestArray.count);
                                    
                                }
                                
                            }
                        
                        
                        
                            
                            for (int i = 0; i < sugestArray.count%3; i++) {
                                
                                UIButton *suggestUserN = [UIButton buttonWithType:UIButtonTypeCustom];
                                suggestUserN.frame = CGRectMake(i*107,32+40*sugestArray.count/3-13 , 106, 40);
                                suggestUserN.backgroundColor = [UIColor clearColor];
                                [suggestUserN setTitle:[sugestArray objectAtIndex:i+sugestArray.count/3*3] forState:UIControlStateNormal];
                                [suggestUserN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                suggestUserN.titleLabel.font = [UIFont systemFontOfSize:12];
                                [suggestUserN addTarget:self action:@selector(sugestUserNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                                [userNameRepeteView addSubview:suggestUserN];
                                
                                
                                
                                
                            }
                            
                            // 提示语
                            UILabel *reminderLabel = [[[UILabel alloc] init] autorelease];
                            reminderLabel.frame = CGRectMake(0, 10, 290, 32);
                            reminderLabel.text = @"主人 此用户名已被注册 建议选择推荐用户名";
                            reminderLabel.textAlignment = NSTextAlignmentCenter;
                            reminderLabel.textColor = [UIColor whiteColor];
                            reminderLabel.font = [UIFont systemFontOfSize:12];
                            reminderLabel.backgroundColor = [UIColor clearColor];
                            [userNameRepeteView addSubview:reminderLabel];
                            
                        
                        
                       // [self OpenUserName];
                        
                        userNameRepeteView.userInteractionEnabled = YES;
                        [self.mainView addSubview:userNameRepeteView];
                        
                        
                        
//                        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
//                        [self.mainView addGestureRecognizer: tapGR];

                    }
#endif
                    
  
                    
                }
                else if ([resultStr isEqualToString:@"4"])
                {
                    [Info showCancelDialog:@"提示" :@"昵称不合法" :self];
					[tfNickName becomeFirstResponder];
					[tfNickName Shake];
                }
                else if ([resultStr isEqualToString:@"5"])
                {
                    [Info showCancelDialog:@"提示" :@"密码不合法" :self];
					[tfPassword becomeFirstResponder];
					[tfPassword Shake];
                }
                else if ([resultStr isEqualToString:@"fail"])
                {
                    [Info showCancelDialog:@"提示" :@"注册失败" :self];
					[tfNickName becomeFirstResponder];
					[tfNickName Shake];
                }
            }
        }
        [jsonParse release];
    }
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [tfNickName becomeFirstResponder];
}

#if 0
#pragma mark - 展开用户名动画
- (void)OpenUserName
{
    // 加普通的展开动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    userNameRepeteView.frame = CGRectMake(15, 75.5, 290, 32+40*((sugestArray.count - 1)/3 + 1));
    
    
    
    
    
    
    
    line4.frame = CGRectMake(0, 30+45*3+userNameRepeteView.frame.size.height, 320, 0.5);
    line3.frame = CGRectMake(15, 30+45+45+userNameRepeteView.frame.size.height, 305, 0.5);
    [UIView commitAnimations];
    
    
    [UITextField beginAnimations:nil context:nil];
    [UITextField setAnimationDuration:0.5];
    tfPassword.frame = CGRectMake(0, 30+45+userNameRepeteView.frame.size.height, 320, 45);
    tfRePassword.frame = CGRectMake(0, 30+45*2+userNameRepeteView.frame.size.height, 320, 45);
    [UITextField commitAnimations];
    
    
    [UIButton beginAnimations:nil context:nil];
    [UIButton setAnimationDuration:0.5];
    zhuceBtn.frame = CGRectMake(15, 190+userNameRepeteView.frame.size.height, 290, 45);
    [UIButton commitAnimations];
    
    
    
    [UILabel beginAnimations:nil context:nil ];
    [UILabel setAnimationDuration:0.5];
    agreeLabel.frame = CGRectMake(15, 242-15+20+userNameRepeteView.frame.size.height, 290, 40);
    [UILabel commitAnimations];
    
    
    
}
#endif

#pragma mark - 用户名重复后收起手势
- (void)tapRecognizer:(UITapGestureRecognizer *)tap
{

    userNameRepeteView.hidden = YES;
    [self closeUserName];
}

- (void)sugestUserNameBtnClick:(UIButton *)btn
{
    tfNickName.text = btn.titleLabel.text;
    userNameRepeteView.hidden = YES;
    [self closeUserName];
    

}

#pragma mark - 用户名闭合动画
- (void)closeUserName
{

    userNameRepeteView.hidden = YES;

//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    line4.frame = CGRectMake(0, 30+45*3, 320, 0.5);
//    line3.frame = CGRectMake(15, 30+45+45, 305, 0.5);
//    [UIView commitAnimations];
//    
//    [UITextField beginAnimations:nil context:nil];
//    [UITextField setAnimationDuration:0.5];
//    tfPassword.frame = CGRectMake(0, 30+45, 320, 45);
//    tfRePassword.frame = CGRectMake(0, 30+45*2, 320, 45);
//    [UITextField commitAnimations];
//    
//    [UIButton beginAnimations:nil context:nil];
//    [UIButton setAnimationDuration:0.5];
//    zhuceBtn.frame = CGRectMake(15, 190+30, 290, 45);
//    [UIButton commitAnimations];
//    
//    [UILabel beginAnimations:nil context:nil ];
//    [UILabel setAnimationDuration:0.5];
//    agreeLabel.frame = CGRectMake(15, 242-15+20, 290, 40);
//    [UILabel commitAnimations];
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.registerProgressHud removeFromSuperview];
	NSError *error = [request error];
	if(error)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"网络有错误" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}  

- (void)requestLoginFinished:(ASIHTTPRequest *)request 
{
	NSString *responseStr = [request responseString];
	if ([responseStr isEqualToString:@"fail"]) 
	{
		[Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
	}
	else
	{
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			[Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
			return;
		}
		Info *info = [Info getInstance];
		info.userId = userInfo.userId;
		info.nickName = userInfo.nick_name;
		info.userName = userInfo.user_name;
		info.mUserInfo = userInfo;
        info.isbindmobile = userInfo.isbindmobile;
        info.authentication = userInfo.authentication;
        info.accesstoken = userInfo.accesstoken;
        [[NSUserDefaults standardUserDefaults] setValue:userInfo.isbindmobile forKey:@"isbindmobile"];
        [[NSUserDefaults standardUserDefaults] setValue:userInfo.authentication forKey:@"authentication"];
        NSLog(@"aut = %@", userInfo.authentication);
		[User insertDB:(info)];
        NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
        [infoarr addObject:info.login_name];
        [infoarr addObject:info.userId];
        [infoarr addObject:info.nickName];
        [infoarr addObject:info.userName];
        [infoarr addObject:info.mUserInfo];
        [infoarr addObject:info.isbindmobile];
        [infoarr addObject:info.authentication];
        [infoarr addObject:@"1"];
        [infoarr addObject:@""];
        [infoarr addObject:@""];
        [infoarr addObject:@""];
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
            [infoarr release];
            [userInfo release];
            [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            return;
        }
        
        [infoarr release];

		
		[userInfo release];
        
        [[NSUserDefaults standardUserDefaults] setValue:tfNickName.text forKey:@"LogInname"];
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
        GC_ZhuCeChengGongViewCotroller * zhuce = [[GC_ZhuCeChengGongViewCotroller alloc] init];
        zhuce.passWord =tfPassword.text;
        zhuce.hongbaoMes = self.hongbaoMes;
        [self.navigationController pushViewController:zhuce animated:YES];
        [zhuce release];
        
        //    ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
        //    proving.canTiaoguo = YES;
        //    proving.canBack = NO;
        //    [self.navigationController pushViewController:proving animated:YES];
        //    [proving release];
		// 跳到主页
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        
        [cai LogInBySelf];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnionType"];
        //[self.navigationController popViewControllerAnimated:YES];
	}
}



- (IBAction)toNickName:(id)sender {
    [tfNickName becomeFirstResponder];
}

- (IBAction)toPassword:(id)sender {
    [tfPassword becomeFirstResponder];
}

- (IBAction)toRePassword:(id)sender {
    [tfRePassword becomeFirstResponder];
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
        [reqRegister clearDelegatesAndCancel];
        self.reqRegister = [ASIHTTPRequest requestWithURL:[NetURL loginUnionWithloginSource:@"1" unionId:response2.userID token:response2.accessToken tokenSecret:@"" openid:@"" userId:@""]];
        [reqRegister setTimeOutSeconds:20.0];
        [reqRegister setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqRegister setDidFinishSelector:@selector(unitionRequestFinisher:)];
        [reqRegister setDelegate:self];
        [reqRegister startAsynchronous];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
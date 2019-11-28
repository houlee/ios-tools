//
//  RegisterViewController.h
//  caibo
//
//  Created by Kiefer on 11-5-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSStringExtra.h"
#import "MBProgressHUD.h"
#import "CPViewController.h"
#import "StatePopupView.h"
#import "AddNick_NameViewController.h"

@class ASIHTTPRequest;

@interface RegisterViewController : CPViewController <UITextFieldDelegate,UIGestureRecognizerDelegate,CP_UIAlertViewDelegate
>
{
    UITextField *tfNickName;
    UITextField *tfPassword;
    UITextField *tfRePassword;
	UIButton *xieyiBtn;
    NSString *password;
    UIButton * zhuceBtn;
    UIButton *xiaLaBtn;
    
    ASIHTTPRequest* reqRegister;
    MBProgressHUD* registerProgressHud;
    
    IBOutlet UIImageView *backforipad;
    IBOutlet UIImageView *textfiledbackforipad;
    IBOutlet UIImageView *textfiledbackforipad2;
    IBOutlet UIImageView *textfiledbackforipad3;
    IBOutlet UITableView *tableviewforiPad;
    
    
//    
//    UIImageView *tfNickNameBackgroundImageView;
//    UIImageView *tfPasswordBackgroundImageView;
//    UIImageView *tfRePasswordBackgroundImageView;
    
    UIButton *apliyImageView2;
    UIButton *qqImageView2;
    UIButton *sinaImageView2;
    UIButton *tXWBImageView2;
    UIButton *WxImageView2;
    UIButton *agreeBtn;
    
    UILabel *agreeLabel;
    
    BOOL moveCount;
    UIImageView *_imageView;
    UIView *line4;
    UIView *line3;
    
    UIButton * aidBtn;//注册按钮辅助功能
    StatePopupView *mStatePV;
    UnNitionLoginType unNitionLoginType;
    UIImageView *userNameRepeteView;
    NSMutableArray *suggestArray;
    
    NSString *hongbaoMes;
    
    // 修改后
    
}
@property (nonatomic,copy) NSString *hongbaoMes;

@property(nonatomic, retain) UITextField *tfNickName;
@property(nonatomic, retain) UITextField *tfPassword;
@property(nonatomic, retain) UITextField *tfRePassword;



@property(nonatomic, retain) IBOutlet UIButton *xieyiBtn;
@property(nonatomic, retain) ASIHTTPRequest *reqRegister;
@property(nonatomic, retain) MBProgressHUD* registerProgressHud;
@property(nonatomic, retain) NSMutableArray *sugestArray;

@property (retain, nonatomic) IBOutlet UIImageView *tfNickNameBackgroundImageView;
@property (retain, nonatomic) IBOutlet UIImageView *tfPasswordBackgroundImageView;
@property (retain, nonatomic) IBOutlet UIImageView *tfRePasswordBackgroundImageView;
//@property (retain, nonatomic) IBOutlet UIImageView *imageView;
//@property (retain, nonatomic) IBOutlet UIImageView *alipayImage;
//@property (retain, nonatomic) IBOutlet UIImageView *qqImage;
//@property (retain, nonatomic) IBOutlet UIImageView *weiboImage;
//@property (retain, nonatomic) IBOutlet UIImageView *tenImage;


- (IBAction)toNickName:(id)sender;
- (IBAction)toPassword:(id)sender;
- (IBAction)toRePassword:(id)sender;

// 取消
- (void)doCanCel;
// 完成
- (void)doFinish;
// 校验输入框输入的内容
- (BOOL)doCheck;

- (void)alipayLogin:(NSURL *)url;
- (void)WXLogin:(NSString *)code;

- (IBAction)xieyi;

@end

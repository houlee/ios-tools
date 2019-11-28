//
//  ProvingViewCotroller.h
//  caibo
//
//  Created by  on 12-5-12.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "StatePopupView.h"
#import "CPViewController.h"
#import "DownLoadImageView.h"

@interface ProvingViewCotroller : CPViewController<UITextFieldDelegate, UIAlertViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>{
    UITextField * textfield1;
    UITextField * textfield2;
    UITextField * textfield3;
    UITextField * textfield4;
    UITextField * textfield5;
    ASIHTTPRequest * reqUserInfo;
    NSString * true_name;
    NSString * id_number;
    NSString * mobile;
    ASIHTTPRequest * requst;
    ASIHTTPRequest * imageRequest;
	BOOL mustWrite;
	BOOL canTiaoguo;
	BOOL canBack;
//    UILabel * yanzhengLab;
    NSTimer * timer;
    UIButton * huoqubut;
    BOOL panduanzil;
    NSString * bangchengg;
    UIView * allView;
    NSString *passWord;
    BOOL duanxinbool;
     StatePopupView * statepop;
    
    BOOL disanfang;
    UIImageView * textimage4;
//    UILabel * namela4;
    UIButton * doneButton;//完成按钮
    UIButton * zbyzButton;//暂不验证
    UIButton * zbyzwcButton;//暂不验证完成
    UILabel * yzOneLabel;//短信验证下的三个label
    UILabel * yzTwoLabel;//短信验证下的三个label
    UILabel * yzThreeLabel;//短信验证下的三个label
    BOOL newBool;//是否为新用户
    
    UIImageView * mutableBG;
    UIView * bottomLine;
    UIImageView *iconImageView;
    int timem;
}
@property (nonatomic, retain)ASIHTTPRequest * reqUserInfo;
@property (nonatomic, retain)ASIHTTPRequest * requst, * imageRequest;
@property (nonatomic,copy)NSString *passWord;
@property (nonatomic)BOOL mustWrite;
@property (nonatomic)BOOL canTiaoguo;
@property (nonatomic)BOOL canBack, duanxinbool;
@property (nonatomic, assign)BOOL disanfang;
@property (nonatomic, retain)NSString * true_name;
@property (nonatomic,retain)NSTimer * timer;

@property(nonatomic, retain)NSString * id_number;
int checkID( int IDNumber[], char ID[] );
// 获取验证码
- (void)sendGetPassCodeRequest;
// 发送验证码
- (void)sendBindPhoneRequest;
- (void)geRenZiLiao;
@end

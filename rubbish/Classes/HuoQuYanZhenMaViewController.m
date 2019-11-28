//
//  HuoQuYanZhenMaViewController.m
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import "HuoQuYanZhenMaViewController.h"
#import "Info.h"
#import "SettingNewPasswordViewController.h"
#import "NetURL.h"
#import "JSON.h"
#import "LoginViewController.h"
#import "MobClick.h"

@interface HuoQuYanZhenMaViewController ()

@end

@implementation HuoQuYanZhenMaViewController
@synthesize httprequest,httprequest2;
@synthesize telstring;
@synthesize Nickname;
@synthesize idstr,codestr,msgstr2,codestr2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadiPhoneView {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCaptcha:) name:@"GotCaptcha" object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"CaptchaType"];


    self.CP_navigation.title = @"找回密码";
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    //    backi.image = UIImageGetImageFromName(@"login_bgn.png");
    backi.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    backi.userInteractionEnabled = YES;
    [self.mainView addSubview:backi];
    [backi release];
    self.mainView.userInteractionEnabled = YES;
  
    
    
    
    //白色大背景图片
    CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 320, 202)];
    //    CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.backgroundColor = [UIColor whiteColor];
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    
  
    
    
    UIView *haoMaXian = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
    haoMaXian.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [CPBGima addSubview:haoMaXian];
    
    UIView *haoMaXian1 = [[[UIView alloc] initWithFrame:CGRectMake(15, 45, 320, 0.5)] autorelease];
    haoMaXian1.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [CPBGima addSubview:haoMaXian1];
    
    UIView *haoMaXian2 = [[[UIView alloc] initWithFrame:CGRectMake(15, 157, 320, 0.5)] autorelease];
    haoMaXian2.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [CPBGima addSubview:haoMaXian2];
    
    UIView *haoMaXian3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 157+45, 320, 0.5)] autorelease];
    haoMaXian3.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [CPBGima addSubview:haoMaXian3];
    
    
    
    
    
    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120 , 45)];
    YPTitle.text = @"您绑定的手机号码";
    YPTitle.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    YPTitle.font = [UIFont systemFontOfSize:15];
    YPTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle];
    [YPTitle release];

    telLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 290, 45)];
    telLabel.backgroundColor = [UIColor clearColor];
    if ([telstring length] >= 7) {
        telLabel.text = [telstring stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@" — * * * * — "];
    }else{
        telLabel.text = telstring;
    }
    telLabel.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    telLabel.font = [UIFont systemFontOfSize:18];
    [CPBGima addSubview:telLabel];
    [telLabel release];
   
        
    //获取验证码按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(15, 70, 290, 45);
    QDButton.userInteractionEnabled = YES;
    QDButton.tag = 1000;
    [QDButton addTarget:self action:@selector(pressHuoQuYanZhenMa) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [QDButton setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [QDButton setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [CPBGima addSubview:QDButton];
    
    
    
//    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
//    QDImage.image = UIImageGetImageFromName(@"tongyonganniulanse.png");
//    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:8 topCapHeight:7];
//    QDImage.tag = 1001;
//    [QDButton addSubview:QDImage];
//    [QDImage release];
    
    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.text = @"获 取 验 证 码";
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    QDLabel.textAlignment = NSTextAlignmentCenter;
    QDLabel.tag = 1002;
    [QDButton addSubview:QDLabel];
    [QDLabel release];
    
    
    
    
    UILabel *zsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 125, 290, 22)];
    zsLabel.backgroundColor = [UIColor clearColor];
    zsLabel.text = @"注：验证码一分钟以后可重新获取。";
    zsLabel.font = [UIFont systemFontOfSize:10];
    zsLabel.textColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1];
    zsLabel.tag = 1003;
    [CPBGima addSubview:zsLabel];
    [zsLabel release];
    
    // 倒计时
    UILabel *zsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(58-18, 157-30, 25, 16)];
    zsLabel2.backgroundColor = [UIColor clearColor];
    zsLabel2.text = @"60";
    zsLabel2.font = [UIFont systemFontOfSize:15];
    zsLabel2.textAlignment = NSTextAlignmentCenter;
    zsLabel2.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    zsLabel2.tag = 1004;
    zsLabel2.hidden = YES;
    [CPBGima addSubview:zsLabel2];
    [zsLabel2 release];
    
    
    
//    //
//    UILabel *yzTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 190, 250, 13)];
//    yzTitle.text = @"请填写获取的手机验证码";
//    yzTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
//    yzTitle.font = [UIFont systemFontOfSize:12];
//    yzTitle.backgroundColor = [UIColor clearColor];
//    [CPBGima addSubview:yzTitle];
//    [yzTitle release];
    
//    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 207, 171, 32)];
//    YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
//    YPbgimage.userInteractionEnabled = YES;
//    [CPBGima addSubview:YPbgimage];
//    [YPbgimage release];
    
    
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 157, 170, 45)];
    YPTextField.font = [UIFont systemFontOfSize:13];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.textAlignment = NSTextAlignmentCenter;
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    YPTextField.placeholder = @"输入手机收到的验证码";
    // YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.keyboardType = UIKeyboardTypeNumberPad;
    YPTextField.delegate = self;
    [CPBGima addSubview:YPTextField];
    [YPTextField release];
    
    
    // 确定按钮
    UIButton *yzqdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yzqdButton.frame = CGRectMake(225, 164, 65, 33);
    yzqdButton.userInteractionEnabled = YES;
    yzqdButton.tag= 1005;
    [yzqdButton setImage:UIImageGetImageFromName(@"zhaohuimimaquedinganniu_1.png") forState:UIControlStateNormal];
    //[yzqdButton setImage:UIImageGetImageFromName(@"QDHBGAX960.png") forState:UIControlStateHighlighted];
   
    [yzqdButton addTarget:self action:@selector(pressNewPas) forControlEvents:UIControlEventTouchUpInside];
    [CPBGima addSubview:yzqdButton];
    
   
    UILabel *yzQDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    yzQDLabel.backgroundColor = [UIColor clearColor];
    yzQDLabel.text = @"确 定";
    yzQDLabel.font = [UIFont boldSystemFontOfSize:17];
    yzQDLabel.textColor = [UIColor whiteColor];
    yzQDLabel.textAlignment = NSTextAlignmentCenter;
    [yzqdButton addSubview:yzQDLabel];
    [yzQDLabel release];
    
    UILabel *YPTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 460, 200, 13)];
    YPTitle2.text = @"如需帮助请拨打：";
    YPTitle2.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
    YPTitle2.font = [UIFont systemFontOfSize:12];
    YPTitle2.backgroundColor = [UIColor clearColor];
    YPTitle2.userInteractionEnabled = YES;
    [backi addSubview:YPTitle2];
    [YPTitle2 release];
    
    //客服按钮
    UIButton *KFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    KFButton.frame = CGRectMake(140, 450, 240, 35);
    KFButton.userInteractionEnabled = YES;
    [KFButton addTarget:self action:@selector(pressbuttonkefu:) forControlEvents:UIControlEventTouchUpInside];
    [backi addSubview:KFButton];
    
    
    
//    UIImageView *KFImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 35)];
//    KFImage.image = UIImageGetImageFromName(@"KFBG960.png");
//    [KFButton addSubview:KFImage];
//    [KFImage release];
//    UIImageView *KFtelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 26, 15)];
//    KFtelImage.image = UIImageGetImageFromName(@"KFTel.png");
//    [KFButton addSubview:KFtelImage];
//    [KFtelImage release];
    
    
    
    UILabel *KFLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    KFLabel.backgroundColor = [UIColor clearColor];
    KFLabel.text = @"QQ：3254056760";
    KFLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255.0/255.0 alpha:1];
    KFLabel.font = [UIFont systemFontOfSize:15];
    [KFButton addSubview:KFLabel];
    [KFLabel release];
    
    
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)LoadiPadView {

    self.CP_navigation.title = @"找回密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.image = UIImageGetImageFromName(@"login_bg.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    //白色大背景图片
    CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 320, 400)];
    CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //
    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 250, 13)];
    YPTitle.text = @"您绑定的手机号码 :";
    YPTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    YPTitle.font = [UIFont systemFontOfSize:12];
    YPTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle];
    [YPTitle release];
    
    telLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 65, 240, 32)];
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.text = [telstring stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@" — Ｘ Ｘ Ｘ Ｘ — "];
    telLabel.font = [UIFont systemFontOfSize:19];
    [CPBGima addSubview:telLabel];
    [telLabel release];
    
    //获取验证码按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(40, 112, 240, 41);
    QDButton.userInteractionEnabled = YES;
    QDButton.tag = 1000;
    [QDButton addTarget:self action:@selector(pressHuoQuYanZhenMa) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [CPBGima addSubview:QDButton];
    
    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 41)];
    QDImage.image = UIImageGetImageFromName(@"ANBG960.png");
    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    QDImage.tag = 1001;
    [QDButton addSubview:QDImage];
    [QDImage release];
    
    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 41)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.text = @"获 取 验 证 码";
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor whiteColor];
    QDLabel.textAlignment = NSTextAlignmentCenter;
    QDLabel.tag = 1002;
    [QDButton addSubview:QDLabel];
    [QDLabel release];
    
    UILabel *zsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 160, 240, 11)];
    zsLabel.backgroundColor = [UIColor clearColor];
    zsLabel.text = @"注：验证码一分钟以后可重新获取。";
    zsLabel.font = [UIFont systemFontOfSize:10];
    zsLabel.textColor = [UIColor colorWithRed:136.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
    zsLabel.tag = 1003;
    [CPBGima addSubview:zsLabel];
    [zsLabel release];
    UILabel *zsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(58, 157, 25, 16)];
    zsLabel2.backgroundColor = [UIColor clearColor];
    zsLabel2.text = @"60";
    zsLabel2.font = [UIFont systemFontOfSize:15];
    zsLabel2.textAlignment = NSTextAlignmentCenter;
    zsLabel2.textColor = [UIColor colorWithRed:11.0/255.0 green:165.0/255.0 blue:203.0/255.0 alpha:1];
    zsLabel2.tag = 1004;
    zsLabel2.hidden = YES;
    [CPBGima addSubview:zsLabel2];
    [zsLabel2 release];
    
    //
    UILabel *yzTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 190, 250, 13)];
    yzTitle.text = @"请填写获取的手机验证码 :";
    yzTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    yzTitle.font = [UIFont systemFontOfSize:12];
    yzTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:yzTitle];
    [yzTitle release];
    
    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 207, 171, 32)];
    YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    YPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:YPbgimage];
    [YPbgimage release];
    
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 170, 32)];
    YPTextField.font = [UIFont systemFontOfSize:13];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    YPTextField.placeholder = @"验证码";
    YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.keyboardType = UIKeyboardTypeNumberPad;
    YPTextField.delegate = self;
    [YPbgimage addSubview:YPTextField];
    [YPTextField release];
    
    UIButton *yzqdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yzqdButton.frame = CGRectMake(214, 207, 65, 32);
    yzqdButton.userInteractionEnabled = YES;
    yzqdButton.tag= 1005;
    [yzqdButton setImage:UIImageGetImageFromName(@"QDHBG960.png") forState:UIControlStateNormal];
    [yzqdButton setImage:UIImageGetImageFromName(@"QDHBGAX960.png") forState:UIControlStateHighlighted];
   
    [yzqdButton addTarget:self action:@selector(pressNewPas) forControlEvents:UIControlEventTouchUpInside];
    [CPBGima addSubview:yzqdButton];
    
    //    UIImageView *yzqdimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    //    yzqdimage.image = UIImageGetImageFromName(@"QDHBGA960.png");
    //    [yzqdButton addSubview:yzqdimage];
    //    [yzqdimage release];
    UILabel *yzQDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    yzQDLabel.backgroundColor = [UIColor clearColor];
    yzQDLabel.text = @"确 定";
    yzQDLabel.font = [UIFont boldSystemFontOfSize:17];
    yzQDLabel.textColor = [UIColor whiteColor];
    yzQDLabel.textAlignment = NSTextAlignmentCenter;
    [yzqdButton addSubview:yzQDLabel];
    [yzQDLabel release];
    
    UILabel *YPTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 272, 245, 13)];
    YPTitle2.text = @"如有疑问，请联系客服 :";
    YPTitle2.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    YPTitle2.font = [UIFont systemFontOfSize:12];
    YPTitle2.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle2];
    [YPTitle2 release];
    
    //客服按钮
    UIButton *KFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    KFButton.frame = CGRectMake(40, 290, 240, 35);
    KFButton.userInteractionEnabled = YES;
    KFButton.enabled = NO;
    [KFButton addTarget:self action:@selector(pressbuttonkefu:) forControlEvents:UIControlEventTouchUpInside];
    [CPBGima addSubview:KFButton];
    
    UIImageView *KFImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 35)];
    KFImage.image = UIImageGetImageFromName(@"KFBG960.png");
    [KFButton addSubview:KFImage];
    [KFImage release];
    
    UIImageView *KFtelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 26, 15)];
    KFtelImage.image = UIImageGetImageFromName(@"KFTel.png");
    [KFButton addSubview:KFtelImage];
    [KFtelImage release];
    
    UILabel *KFLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 35)];
    KFLabel.backgroundColor = [UIColor clearColor];
    KFLabel.text = @"QQ：3254056760";
    KFLabel.font = [UIFont systemFontOfSize:14];
    [KFButton addSubview:KFLabel];
    [KFLabel release];
    
    
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)addCaptcha:(NSNotification *)notification
{
    YPTextField.text = notification.object;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
#ifdef isCaiPiaoForIPad
    
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
}

- (void)doBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)pressNewPas {

    [YPTextField resignFirstResponder];
    
    if ([YPTextField.text length] == 0) {
        
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请输入验证码。"];
        return;
        
    }else if ([YPTextField.text length] > 0) {
    
        [self requestInputYanZhenMa];
    }
    
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[YPTextField resignFirstResponder];
    
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [YPTextField resignFirstResponder];
}

- (void)pressbuttonkefu:(UIButton *)sender{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.mainView];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
//    }
//    [actionSheet release];
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}

//更改获取验证码按钮样式
- (void)changeButtonColor {

    UIButton *btn = (UIButton *)[self.mainView viewWithTag:1000];
    btn.enabled = NO;
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    // ima.image = UIImageGetImageFromName(@"ANBGA960.png");
    ima.image = [UIImageGetImageFromName(@"tongyonganniulanse_2.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];

    
}

//获取验证码按钮恢复原样
- (void)BackButtonColor {

    UILabel *lab = (UILabel *)[self.mainView viewWithTag:1004];
    lab.hidden = YES;
    lab.text = @"60";
    
    UILabel *la = (UILabel *)[self.mainView viewWithTag:1003];
    la.text = @"注：验证码一分钟以后可重新获取。";


    UIButton *btn = (UIButton *)[self.mainView viewWithTag:1000];
    btn.enabled = YES;
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    // ima.image = [UIImageGetImageFromName(@"ANBG960.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    ima.image = [UIImageGetImageFromName(@"zhaohuimimaquedinganniu_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
}

- (void)ChangeTime {
   
    UILabel *lab = (UILabel *)[self.mainView viewWithTag:1004];
    lab.hidden = NO;
    lab.text =  [NSString stringWithFormat:@"%d",[lab.text intValue] - 1];
    if ([lab.text isEqualToString:@"0"]) {
        [self BackButtonColor];
        return;
    }else{
        [self performSelector:@selector(ChangeTime) withObject:nil afterDelay:1];
    }
    
}
//获取验证码
- (void)pressHuoQuYanZhenMa {
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    
    ima.image = [UIImageGetImageFromName(@"tongyonganniulanse_2.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];
    [YPTextField resignFirstResponder];
    [self requestYanZhenMa];
    
    UIButton * yangZhengButton = (UIButton *)[CPBGima viewWithTag:1000];
    yangZhengButton.enabled = NO;
    
}

//获取验证码网络请求
- (void)requestYanZhenMa{
    
    NSLog(@"MOBILE=%@",telstring);
    [MobClick event:@"event_wodecaipiao_wangjimima_findpass_getcode"];
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL FindpasswordGetJiaoyanma:Nickname mobile:telstring]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setDidFailSelector:@selector(redRequesDidFailSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}

- (void)redRequesDidFailSelector:(ASIHTTPRequest *)request
{
    UIButton * yangZhengButton = (UIButton *)[CPBGima viewWithTag:1000];
    yangZhengButton.enabled = YES;
}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    if(responseString){
        
        NSDictionary *dict = [responseString JSONValue];
        
        self.codestr = [dict objectForKey:@"code"];
        msgstr = [dict objectForKey:@"msg"];
        self.idstr = [dict objectForKey:@"id"];
        [self TiShiInfo];//短信发送提示信息
        
        [self HuoQuChiShu];//验证码获取次数判断
    }
    
}

- (void)TiShiInfo {

    if ([codestr intValue] == 1) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"短信发送成功,请查收。如一分钟内,没有收到任何短信内容,请重新获取验证码。"];
    }
}

- (void)HuoQuChiShu {

    if (![msgstr isEqualToString:@"您24小时内已经尝试3次找回密码了，请改天再试！"]) {
        
        [self changeButtonColor];
        
        //更改时间
        UILabel *la = (UILabel *)[self.mainView viewWithTag:1003];
        la.text = @"距离           秒后,可重新获取验证码。";
        [self performSelector:@selector(ChangeTime) withObject:nil afterDelay:1];
        
        
    }else if ([msgstr isEqualToString:@"您24小时内已经尝试3次找回密码了，请改天再试！"]) {
        
        caiboAppDelegate *ca = [caiboAppDelegate getAppDelegate];
        [ca showMessage:@"您24小时内已经尝试3次找回密码了，请改天再试！"];
        
        return;
    }

}

//按钮点击效果图片
- (void)TouchDragExit{
    // ANBG960
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    ima.image = [UIImageGetImageFromName(@"zhaohuimimaquedinganniu_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
}
- (void)touchxibutton{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    // ima.image = [UIImageGetImageFromName(@"ANBGAX960.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    // ANBGAX960
    ima.image = [UIImageGetImageFromName(@"tongyonganniulanse_2.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];

}
-(void)TouchCancel{
    // ANBG960
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:1001];
    ima.image = [UIImageGetImageFromName(@"tongyonganniulanse_2.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];
}

//输入验证码网络请求
- (void)requestInputYanZhenMa{
    NSLog(@"yptext=%@",YPTextField.text);
    [httprequest2 clearDelegatesAndCancel];
    [MobClick event:@"event_wodecaipiao_wangjimima_findpass_checkcode"];
    self.httprequest2 = [ASIHTTPRequest requestWithURL:[NetURL FindpasswordInputJiaoyanma:Nickname Id:idstr Code:YPTextField.text]];
    [httprequest2 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest2 setDelegate:self];
    [httprequest2 setDidFinishSelector:@selector(redRequesDidFinishSelector2:)];
    [httprequest2 setNumberOfTimesToRetryOnTimeout:2];
    [httprequest2 startAsynchronous];
    
}
- (void)redRequesDidFinishSelector2:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    if(responseString){
        
        NSDictionary *dict2 = [responseString JSONValue];
        
        self.codestr2 = [dict2 objectForKey:@"code"];
        self.msgstr2 = [dict2 objectForKey:@"msg"];
        uuidstr = [dict2 objectForKey:@"uuid"];
        
        [self PanDuanInfo];//判断是否找回
    }
    
}

- (void)PanDuanInfo {

    //UILabel *la = (UILabel *)[self.view viewWithTag:1003];
    //NSLog(@"la.text=%@",la.text);
    NSLog(@"codestr2=%@",codestr2);
    if ([codestr2 intValue] == 1) {
        
        SettingNewPasswordViewController *sp = [[SettingNewPasswordViewController alloc] init];
        sp.Nicknamestr = Nickname;
        sp.Uuidstr = uuidstr;
        [self.navigationController pushViewController:sp animated:YES];
        [sp release];
        
        caiboAppDelegate *ca = [caiboAppDelegate getAppDelegate];
        [ca showMessage:@"十分钟之内必须修改密码。"];
        
        
    }else if ([codestr2 intValue] == 0){
        
        caiboAppDelegate *ca = [caiboAppDelegate getAppDelegate];
        [ca showMessage:msgstr2];
        return;
    }

}

- (void)keyboardWillShow:(id)sender {
    
#ifdef isCaiPiaoForIPad
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    CPBGima.frame = CGRectMake(110, -45, 320, 400);

#else
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    CPBGima.frame = CGRectMake(0, -45, 320, 400);

#endif
    
}

- (void)keyboardWillDisapper:(id)sender {
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillShowNotification object:nil];
#ifdef isCaiPiaoForIPad
    
    CPBGima.frame = CGRectMake(110, 15, 320, 400);
#else
    
    CPBGima.frame = CGRectMake(0, 15, 320, 400);
#endif
    
}

- (void)dealloc {

    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    
    [httprequest2 clearDelegatesAndCancel];
    [httprequest2 release];

    
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  SettingNewPasswordViewController.m
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import "SettingNewPasswordViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"
#import "NSStringExtra.h"
#import "NetURL.h"
#import "JSON.h"
#import "LoginViewController.h"

@interface SettingNewPasswordViewController ()

@end

@implementation SettingNewPasswordViewController
@synthesize Nicknamestr,Uuidstr;
@synthesize httprequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadiPhoneView {

    self.title = @"找回密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:backi];
    [backi release];
    
    //新密码等的背景图片
    UIImageView *CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 320, 90)];
    // CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.backgroundColor = [UIColor whiteColor];
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //新密码
    UILabel *NewPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 45)];
    NewPasswordTitle.text = @"新  密  码";
    NewPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    NewPasswordTitle.font = [UIFont systemFontOfSize:16];
    NewPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:NewPasswordTitle];
    [NewPasswordTitle release];
    
//    UIImageView *NPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 63, 240.5, 32)];
//    NPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
//    NPbgimage.userInteractionEnabled = YES;
//    [CPBGima addSubview:NPbgimage];
//    [NPbgimage release];
    
    NewPTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, 240, 45)];
    NewPTextField.placeholder = @" 6-16位字符/小写字母/数字/下划线";
    NewPTextField.font = [UIFont systemFontOfSize:14];
    NewPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NewPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    NewPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    NewPTextField.secureTextEntry = YES;//密码
    // NewPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    NewPTextField.returnKeyType = UIReturnKeyDone;
    NewPTextField.delegate = self;
    [CPBGima addSubview:NewPTextField];
    [NewPTextField release];
    
    
    //确认密码
    UILabel *QRPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 45+5, 100, 20)];
    QRPasswordTitle.text = @"确认密码";
    QRPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    QRPasswordTitle.font = [UIFont systemFontOfSize:16];
    QRPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:QRPasswordTitle];
    [QRPasswordTitle release];
    

    // 分割线
    UIView *line1 = [[[UIView alloc] init] autorelease];
    line1.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    line1.frame = CGRectMake(0, 0, 320, 0.5);
    [CPBGima addSubview:line1];
    
    UIView *line2 = [[[UIView alloc] init] autorelease];
    line2.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    line2.frame = CGRectMake(15, 45, 305, 0.5);
    [CPBGima addSubview:line2];
    
    UIView *line3 = [[[UIView alloc] init] autorelease];
    line3.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    line3.frame = CGRectMake(0, 45*2, 320, 0.5);
    [CPBGima addSubview:line3];
    
    
    
    QRPTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 45, 240, 32)];
    QRPTextField.placeholder = @" 6-16位字符/小写字母/数字/下划线";
    QRPTextField.font = [UIFont systemFontOfSize:14];
    QRPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    QRPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    QRPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    QRPTextField.secureTextEntry = YES;//密码
    // QRPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    QRPTextField.returnKeyType = UIReturnKeyDone;
    QRPTextField.delegate = self;
    [CPBGima addSubview:QRPTextField];
    [QRPTextField release];
    
//    //密码安全级别
//    Low = [[UIImageView alloc] initWithFrame:CGRectMake(40, 102, 78, 7)];
//    Low.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Low];
//    [Low release];
//    
//    Mid = [[UIImageView alloc] initWithFrame:CGRectMake(120, 102, 78, 7)];
//    Mid.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Mid];
//    [Mid release];
//    
//    Hig = [[UIImageView alloc] initWithFrame:CGRectMake(200, 102, 78, 7)];
//    Hig.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Hig];
//    [Hig release];
    
    
    //确定按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.backgroundColor = [UIColor clearColor];
    QDButton.frame = CGRectMake(15, 145, 290, 45);
    // ****
//    QDButton.userInteractionEnabled = YES;
    [QDButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
    [QDButton setBackgroundImage:[[UIImage imageNamed:@"dengluanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateHighlighted];

    [QDButton addTarget:self action:@selector(pressEnter) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [self.mainView addSubview:QDButton];
    
//    // zhaohuimimaquedinganniu_1
//    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
//    QDImage.image = UIImageGetImageFromName(@"dengluanniu_1.png");
//    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:46 topCapHeight:12];
//    QDImage.tag = 101;
//    [QDButton addSubview:QDImage];
//    [QDImage release];

    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.textAlignment = NSTextAlignmentCenter;
    QDLabel.text = @"确  定";
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor whiteColor];
    [QDButton addSubview:QDLabel];
    [QDLabel release];
    
    
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
    [self.mainView  addSubview:backi];
    [backi release];
    
    //新密码等的背景图片
    UIImageView *CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 320, 400)];
    CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //新密码
    UILabel *NewPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 43, 70, 20)];
    NewPasswordTitle.text = @"新密码 :";
    NewPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    NewPasswordTitle.font = [UIFont systemFontOfSize:12];
    NewPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:NewPasswordTitle];
    [NewPasswordTitle release];
    
    UIImageView *NPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 63, 240.5, 32)];
    NPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    NPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:NPbgimage];
    [NPbgimage release];
    
    NewPTextField = [[UITextField alloc] initWithFrame:CGRectMake(3, 0, 240, 32)];
    NewPTextField.placeholder = @"6-16位字符，小写字母/数字/下划线";
    NewPTextField.font = [UIFont systemFontOfSize:13];
    NewPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NewPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    NewPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    NewPTextField.secureTextEntry = YES;//密码
    NewPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    NewPTextField.returnKeyType = UIReturnKeyDone;
    NewPTextField.delegate = self;
    [NPbgimage addSubview:NewPTextField];
    [NewPTextField release];
    
    
    //确认密码
    UILabel *QRPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 115, 100, 20)];
    QRPasswordTitle.text = @"确认密码 :";
    QRPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    QRPasswordTitle.font = [UIFont systemFontOfSize:12];
    QRPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:QRPasswordTitle];
    [QRPasswordTitle release];
    
    UIImageView *QRPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 135, 240.5, 32)];
    QRPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    QRPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:QRPbgimage];
    [QRPbgimage release];
    
    QRPTextField = [[UITextField alloc] initWithFrame:CGRectMake(3, 0, 240, 32)];
    QRPTextField.placeholder = @" 6-16位字符，小写字母/数字/下划线";
    QRPTextField.font = [UIFont systemFontOfSize:13];
    QRPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    QRPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    QRPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    QRPTextField.secureTextEntry = YES;//密码
    QRPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    QRPTextField.returnKeyType = UIReturnKeyDone;
    QRPTextField.delegate = self;
    [QRPbgimage addSubview:QRPTextField];
    [QRPTextField release];
    
    //密码安全级别
    Low = [[UIImageView alloc] initWithFrame:CGRectMake(40, 102, 78, 7)];
    Low.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Low];
    [Low release];
    
    Mid = [[UIImageView alloc] initWithFrame:CGRectMake(120, 102, 78, 7)];
    Mid.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Mid];
    [Mid release];
    
    Hig = [[UIImageView alloc] initWithFrame:CGRectMake(200, 102, 78, 7)];
    Hig.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Hig];
    [Hig release];
    
    
    //确定按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(40, 187, 240, 41);
    QDButton.userInteractionEnabled = YES;
    [QDButton addTarget:self action:@selector(pressEnter) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [CPBGima addSubview:QDButton];
    
    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 41)];
    QDImage.image = UIImageGetImageFromName(@"ANBG960.png");
    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    QDImage.tag = 101;
    [QDButton addSubview:QDImage];
    [QDImage release];
    
    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 70, 41)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.text = @"确  定";
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor whiteColor];
    [QDButton addSubview:QDLabel];
    [QDLabel release];
    
    
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

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

- (void)pressEnter {

    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:46 topCapHeight:12];
    
    BOOL password = NO;
    NSString *message = @"";
    
    NSString *nickNa = [[Info getInstance] nickName];
    
    if (([NewPTextField.text length] == 0) || ([QRPTextField.text length] == 0))
    {
        
        password = YES;
        message = @"请输入完整的密码信息。";
        
        
    }else if ((![NewPTextField.text isEqualToString:QRPTextField.text]))
    {
        
        password = YES;
        message = @"两次输入密码不一致。";
        
    }else if ([NewPTextField.text isAllNumber])
    {
        password = YES;
        message = @"密码不能由纯数字构成。";
        
        
    }else if ([NewPTextField.text isEqualToString:Nicknamestr])
    {
        
        password = YES;
        message = @"密码不能与用户名相同。";
        
    }else if ([NewPTextField.text isEqualToString:nickNa]) {
        
        password = YES;
        message = @"密码不能与用户名相同。";
        
        
    }else if ([NewPTextField.text length] > 16 || [QRPTextField.text length] > 16 || [NewPTextField.text length] < 6 || [QRPTextField.text length] < 6) {
        
        
        password = YES;
        message = @"请输入6-16位字符。";
        NewPTextField.text = @"";
        QRPTextField.text = @"";
        Low.image = nil;
        Mid.image = nil;
        Hig.image = nil;

    }else {
        [MobClick event:@"event_login_newPassworld_queren"];
        [self requestChangepassword];
        [NewPTextField resignFirstResponder];
        [QRPTextField resignFirstResponder];
        
    }
#ifdef isCaiPiaoForIPad
    
    if (password) {
        
        caiboAppDelegate *tsinfo = [caiboAppDelegate getAppDelegate];
        if ([message isEqualToString:@"您的输入有误,请重新输入。"]) {
            
            //[tsinfo showjianpanMessage:message view:tempWindow];
            [tsinfo showMessage:message];
            NewPTextField.text = @"";
            QRPTextField.text = @"";
            Low.image = nil;
            Mid.image = nil;
            Hig.image = nil;
            [NewPTextField becomeFirstResponder];
        }
        [tsinfo showMessage:message];
        //[tsinfo showjianpanMessage:message view:tempWindow];

#else
    if (password) {
        
        caiboAppDelegate *tsinfo = [caiboAppDelegate getAppDelegate];
        if ([message isEqualToString:@"您的输入有误,请重新输入。"]) {
            
            [tsinfo showjianpanMessage:message view:tempWindow];
            NewPTextField.text = @"";
            QRPTextField.text = @"";
            Low.image = nil;
            Mid.image = nil;
            Hig.image = nil;
            [NewPTextField becomeFirstResponder];
        }
        //[tsinfo showMessage:message];
        [tsinfo showjianpanMessage:message view:tempWindow];

#endif
            
    }

}

- (void)TouchDragExit{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:46 topCapHeight:12];
}
- (void)touchxibutton{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
     ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:46 topCapHeight:12];
}
-(void)TouchCancel{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:46 topCapHeight:12];
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[NewPTextField resignFirstResponder];
    [QRPTextField resignFirstResponder];
    
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [NewPTextField resignFirstResponder];
    [QRPTextField resignFirstResponder];
}

//输入密码时自动设置密码级别
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSLog(@"aaa=%@",string);
    if (!([string isEqualToString:@""])) {
        [self performSelector:@selector(textFieldFunc:) withObject:textField afterDelay:0.1];//
    }
    
    
    if (textField == NewPTextField) {
        
        if ([NewPTextField.text length] == 1 && ![string length]) {
            Low.image = nil;
            Mid.image = nil;
            Hig.image = nil;
        }
        else {
            Low.image = UIImageGetImageFromName(@"QDTD960.png");
        }
        if ([NewPTextField.text length] >=6 && [string length]) {
            
            Mid.image = UIImageGetImageFromName(@"QDTZ960.png");
        }
        else if ([NewPTextField.text length] == 7 && ![string length]) {
            Mid.image = nil;
        }
        if ([NewPTextField.text length] >=13 && [string length]) {
            
            Hig.image = UIImageGetImageFromName(@"QDTG960.png");
        }
        else if ([NewPTextField.text length] == 14 && ![string length]) {
            Hig.image = nil;
        }
    }
    
    
    return YES;
}

//密码清空时调用
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (textField == NewPTextField) {
        
        Low.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
        Low.image = nil;
        Mid.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
        Mid.image = nil;
        Hig.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
        Hig.image = nil;
        
    }
    return YES;
}

//自动删除非法字符
- (void)textFieldFunc:(UITextField *)textField {
    
        
    if (textField == NewPTextField) {
        if ([NewPTextField.text isContainCapital]) {
            
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"不可使用大写字母" view:tempWindow];
            if ([NewPTextField.text length] > 0) {
                NewPTextField.text = [NewPTextField.text substringToIndex:[NewPTextField.text length]-1];//
                
                if ([NewPTextField.text length] == 0) {
                    Low.image = nil;
                    Mid.image = nil;
                    Hig.image = nil;
                }
                if (([NewPTextField.text length] >0) && ([NewPTextField.text length] <=6)) {
                    Mid.image = nil;
                    Hig.image = nil;
                }
                if (([NewPTextField.text length] >6) && ([NewPTextField.text length] <=13)) {
                    Hig.image = nil;
                }
            }
            
        }
        if (![NewPTextField.text isConform] && ![NewPTextField.text isContainCapital] && [NewPTextField.text length] > 0) {
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"您输入了非法字符" view:tempWindow];
            if ([NewPTextField.text length] > 0) {
                NewPTextField.text = [NewPTextField.text substringToIndex:[NewPTextField.text length]-1];//
                if ([NewPTextField.text length] == 0) {
                    Low.image = nil;
                    Mid.image = nil;
                    Hig.image = nil;
                }
                if (([NewPTextField.text length] >0) && ([NewPTextField.text length] <=6)) {
                    Mid.image = nil;
                    Hig.image = nil;
                }
                if (([NewPTextField.text length] >6) && ([NewPTextField.text length] <=13)) {
                    Hig.image = nil;
                }
                
            }
            
        }
        
    }
    
    if (textField == QRPTextField) {
        if ([QRPTextField.text isContainCapital]) {
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"不可使用大写字母" view:tempWindow];
            if ([QRPTextField.text length] > 0) {
                QRPTextField.text = [QRPTextField.text substringToIndex:[QRPTextField.text length]-1];//
            }
        }
        if (![QRPTextField.text isConform] && ![QRPTextField.text isContainCapital] && [QRPTextField.text length] > 0) {
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"您输入了非法字符" view:tempWindow];
            if ([QRPTextField.text length] > 0) {
                QRPTextField.text = [QRPTextField.text substringToIndex:[QRPTextField.text length]-1];//自动删除输入的大写字母
            }
            
        }
        
    }
    
}

- (void)keyboardWillShow:(id)sender {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    
    if ([[[UIApplication sharedApplication] windows] count] <3) {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:[[[UIApplication sharedApplication] windows] count]-1];
    }else{
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillDisapper:(id)sender {
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillShowNotification object:nil];
}

//修改密码网络请求
- (void)requestChangepassword{
    
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL FindpasswordChangePassword:Nicknamestr Uuid:Uuidstr Password:NewPTextField.text]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:30];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}
- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    if(responseString){
        
        NSDictionary *dict = [responseString JSONValue];
        
        codestr = [dict objectForKey:@"code"];
        
        [self PanDuanInfo];//判断密码是否修改成功
    }
    
}

- (void)PanDuanInfo {

    if ([codestr intValue] == 1) {
        
        if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-4] isKindOfClass:[LoginViewController class]]) {
            
            LoginViewController * logi = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 4];
            [self.navigationController popToViewController:logi animated:YES];
            
        }
        
        caiboAppDelegate *pa = [caiboAppDelegate getAppDelegate];
        [pa showMessage:@"修改密码成功"];
        
    }else if ([codestr intValue] == 0) {
        
        NewPTextField.text = @"";
        QRPTextField.text = @"";
        Low.image = nil;
        Mid.image = nil;
        Hig.image = nil;

        caiboAppDelegate *pa = [caiboAppDelegate getAppDelegate];
        [pa showMessage:@"找回密码失败"];
        return;
        
    }
}

- (void)dealloc {

    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    
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
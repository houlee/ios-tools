//
//  ChangPasswordViewController.m
//  caibo
//
//  Created by zhang on 1/17/13.
//
//

#import "ChangPasswordViewController.h"
#import "Info.h"
#import "CP_PTButton.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"
#import "QuartzCore/QuartzCore.h"

@interface ChangPasswordViewController ()

@end

@implementation ChangPasswordViewController
@synthesize myHttpRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadiPhoneView {
    
    [MobClick event:@"event_shezhi_xiugaimima"];
    self.CP_navigation.title = @"修改密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    // 大背景图
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // backi.image = UIImageGetImageFromName(@"login_bgn.png");
    backi.backgroundColor  = [UIColor colorWithRed:250/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:backi];
    [backi release];
    
    
    
    
    
    
    //原密码等的背景图片
    CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 320, 400)];
    // CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.backgroundColor = [UIColor clearColor];
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //原密码
    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
    YPTitle.text = @"   原  密  码";
    YPTitle.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    YPTitle.font = [UIFont systemFontOfSize:16];
    YPTitle.backgroundColor = [UIColor whiteColor];
    // [backi addSubview:YPTitle];
   
    
    // 原密码原先的背景图，---》去掉了
    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 320 , 45)];
    // YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    YPbgimage.backgroundColor = [UIColor clearColor];
    YPbgimage.userInteractionEnabled = YES;
    [backi addSubview:YPbgimage];
    [YPbgimage release];
    
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, 320, 45)];
    //YPTextField.background = [UIImage imageNamed:@"DTC960.png"];//设置背景图片
    YPTextField.placeholder = @" 6-16位字符/小写字母/数字/下划线";
    YPTextField.textColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    YPTextField.font = [UIFont systemFontOfSize:14];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    YPTextField.secureTextEntry = YES;//密码
    YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.delegate = self;
    YPTextField.backgroundColor = [UIColor whiteColor];
    // 汉字原密码显示
    YPTextField.leftView = YPTitle;
    YPTextField.leftViewMode = UITextFieldViewModeAlways;
    [CPBGima addSubview:YPTextField];
    [YPTextField release];
    [YPTitle release];

    
    
    
    
    
    
    //新密码
    UILabel *NewPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 80, 45)];
    NewPasswordTitle.text = @"   新  密  码";
    NewPasswordTitle.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    NewPasswordTitle.font = [UIFont systemFontOfSize:16];
    NewPasswordTitle.backgroundColor = [UIColor whiteColor];
   // [CPBGima addSubview:NewPasswordTitle];
//
//    // 新密码原先的背景图
//    UIImageView *NPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 45)];
//    // NPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
//    NPbgimage.backgroundColor = [UIColor clearColor];
//    NPbgimage.userInteractionEnabled = YES;
//    [CPBGima addSubview:NPbgimage];
//    [NPbgimage release];
    
    NewPTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 320, 45)];
    NewPTextField.placeholder = @" 6-16位字符/小写字母/数字/下划线";
    NewPTextField.textColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    NewPTextField.font = [UIFont systemFontOfSize:14];
    NewPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NewPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    NewPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    NewPTextField.secureTextEntry = YES;//密码
    NewPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    NewPTextField.returnKeyType = UIReturnKeyDone;
    NewPTextField.delegate = self;
    
    NewPTextField.leftView = NewPasswordTitle;
    NewPTextField.leftViewMode = UITextFieldViewModeAlways;
    NewPTextField.backgroundColor = [UIColor whiteColor];
    [CPBGima addSubview:NewPTextField];
    [NewPTextField release];
    [NewPasswordTitle release];

    
    
    
    
    
    //确认密码
    UILabel *QRPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
    QRPasswordTitle.text = @"   确认密码";
    QRPasswordTitle.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    QRPasswordTitle.font = [UIFont systemFontOfSize:16];
    QRPasswordTitle.backgroundColor = [UIColor whiteColor];
 //   [CPBGima addSubview:QRPasswordTitle];
//    // 确认密码背景图
//    UIImageView *QRPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 198, 240.5, 32)];
//    // QRPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
//    QRPbgimage.backgroundColor = [UIColor clearColor];
//    QRPbgimage.userInteractionEnabled = YES;
//    [CPBGima addSubview:QRPbgimage];
//    [QRPbgimage release];
    
    QRPTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 105, 320, 45)];
    QRPTextField.placeholder = @" 6-16位字符/小写字母/数字/下划线";
    QRPTextField.font = [UIFont systemFontOfSize:14];
    QRPTextField.textColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    QRPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    QRPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    QRPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    QRPTextField.secureTextEntry = YES;//密码
    QRPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    QRPTextField.returnKeyType = UIReturnKeyDone;
    QRPTextField.delegate = self;
    QRPTextField.leftView = QRPasswordTitle;
    QRPTextField.leftViewMode = UITextFieldViewModeAlways;
    QRPTextField.backgroundColor = [UIColor whiteColor];
    [CPBGima addSubview:QRPTextField];
    [QRPTextField release];
    [QRPasswordTitle release];

    
//    //密码安全级别   -----》去掉了
//    Low = [[UIImageView alloc] initWithFrame:CGRectMake(40, 163, 78, 7)];
//    Low.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Low];
//    [Low release];
//    
//    Mid = [[UIImageView alloc] initWithFrame:CGRectMake(120, 163, 78, 7)];
//    Mid.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Mid];
//    [Mid release];
//    
//    Hig = [[UIImageView alloc] initWithFrame:CGRectMake(200, 163, 78, 7)];
//    Hig.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
//    [CPBGima addSubview:Hig];
//    [Hig release];
    
    
    // 加横线
    UIView *yuanMiMaXian = [[[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 0.5)] autorelease];
    yuanMiMaXian.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [CPBGima addSubview:yuanMiMaXian];
    
    
    UIView *xinMiMaXian = [[[UIView alloc] initWithFrame:CGRectMake(15, 60, 320, 0.5)] autorelease];
    xinMiMaXian.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [CPBGima addSubview:xinMiMaXian];
    
    UIView *queRenMiMaXian = [[[UIView alloc] initWithFrame:CGRectMake(15, 105, 320, 0.5)] autorelease];
    queRenMiMaXian.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [CPBGima addSubview:queRenMiMaXian];
    UIView *queRenMiMaXian2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, 0.5)] autorelease];
    queRenMiMaXian2.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [CPBGima addSubview:queRenMiMaXian2];
    
    
    //确定按钮
    QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(15, 190, 290, 45);
    QDButton.userInteractionEnabled = YES;
    [QDButton addTarget:self action:@selector(pressEnter) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [CPBGima addSubview:QDButton];

    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    QDImage.image = UIImageGetImageFromName(@"dengluanniu_1.png");
    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    QDImage.tag = 101;
    [QDButton addSubview:QDImage];
    [QDImage release];
    
    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.text = @"确  定";
    QDLabel.textAlignment = NSTextAlignmentCenter;
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor whiteColor];
    [QDButton addSubview:QDLabel];
    [QDLabel release];
    
    //键盘监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)LoadiPadView {
    self.mainView.layer.masksToBounds = YES;
    [MobClick event:@"event_shezhi_xiugaimima"];
    self.CP_navigation.title = @"修改密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.image = UIImageGetImageFromName(@"login_bg.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    //原密码等的背景图片
    CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(35, 50, 320, 400)];
    CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //原密码
    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 70, 20)];
    YPTitle.text = @"原密码:";
    YPTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    YPTitle.font = [UIFont systemFontOfSize:14];
    YPTitle.backgroundColor = [UIColor clearColor];
    //[CPBGima addSubview:YPTitle];
    [YPTitle release];
    
    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 63, 240.5, 32)];
    YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    YPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:YPbgimage];
    [YPbgimage release];
    
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, 320, 45)];
    //YPTextField.background = [UIImage imageNamed:@"DTC960.png"];//设置背景图片
    YPTextField.placeholder = @"6-16位字符/小写字母/数字/下划线";
    YPTextField.font = [UIFont systemFontOfSize:13];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    YPTextField.secureTextEntry = YES;//密码
    YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.delegate = self;
    [YPbgimage addSubview:YPTextField];
    [YPTextField release];
    
    //新密码
    UILabel *NewPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 100, 70, 20)];
    NewPasswordTitle.text = @"新密码:";
    NewPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    NewPasswordTitle.font = [UIFont systemFontOfSize:14];
    NewPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:NewPasswordTitle];
    [NewPasswordTitle release];
    
    UIImageView *NPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 123, 240.5, 32)];
    NPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    NPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:NPbgimage];
    [NPbgimage release];
    
    NewPTextField = [[UITextField alloc] initWithFrame:CGRectMake(3, 0, 240, 32)];
    NewPTextField.placeholder = @"6-16位字符/小写字母/数字/下划线";
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
    UILabel *QRPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 175, 100, 20)];
    QRPasswordTitle.text = @"确认密码:";
    QRPasswordTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    QRPasswordTitle.font = [UIFont systemFontOfSize:14];
    QRPasswordTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:QRPasswordTitle];
    [QRPasswordTitle release];
    
    UIImageView *QRPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 198, 240.5, 32)];
    QRPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    QRPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:QRPbgimage];
    [QRPbgimage release];
    
    QRPTextField = [[UITextField alloc] initWithFrame:CGRectMake(3, 0, 240, 32)];
    QRPTextField.placeholder = @"6-16位字符/小写字母/数字/下划线";
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
    Low = [[UIImageView alloc] initWithFrame:CGRectMake(40, 163, 78, 7)];
    Low.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Low];
    [Low release];
    
    Mid = [[UIImageView alloc] initWithFrame:CGRectMake(120, 163, 78, 7)];
    Mid.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Mid];
    [Mid release];
    
    Hig = [[UIImageView alloc] initWithFrame:CGRectMake(200, 163, 78, 7)];
    Hig.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    [CPBGima addSubview:Hig];
    [Hig release];
    
    //确定按钮
    QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(40, 270, 240, 41);
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
#ifdef  isCaiPiaoForIPad
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
    // ANBG960
    UIImageView *ima2 = (UIImageView *)[QDButton viewWithTag:101];
    ima2.image = UIImageGetImageFromName(@"dengluanniu_1.png");
    ima2.image = [ima2.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
    BOOL password = NO;
    NSString *message = @"";
    NSString *userNa = [[Info getInstance] userName];
    NSString *nickNa = [[Info getInstance] nickName];
    NSLog(@"%@",userNa);
    NSLog(@"%@",nickNa);
    
    if (([NewPTextField.text length] == 0) || ([YPTextField.text length] == 0) || ([QRPTextField.text length] == 0)){
        
        
        password = YES;
        message = @"请输入完整的修改密码信息.";
        
        
    }else if ((![NewPTextField.text isEqualToString:QRPTextField.text]))
    {

        password = YES;
        message = @"您的输入有误,请重新输入.";
        
    }else if ([NewPTextField.text isAllNumber])
    {
        password = YES;
        message = @"密码不能由纯数字构成.";
        
        if (([NewPTextField.text length] > 16 && [QRPTextField.text length] > 16) || ([NewPTextField.text length] < 6 && [QRPTextField.text length] < 6)) {
           
            password = YES;
            message = @"密码不能由纯数字构成,请输入6-16位字符.";
            NewPTextField.text = @"";
            QRPTextField.text = @"";
            [NewPTextField becomeFirstResponder];

        }
                
        
    }else if ([YPTextField.text isEqualToString:NewPTextField.text])
    {
        password = YES;
        message = @"新密码不能与原密码相同";
        
    }
    else if ([NewPTextField.text isEqualToString:userNa])
    {
    
        password = YES;
        message = @"密码不能与用户名相同";
        
    }else if ([NewPTextField.text isEqualToString:nickNa]) {
    
        password = YES;
        message = @"密码不能与用户名相同";
        
        
    }else if ([NewPTextField.text length] < 6 || [NewPTextField.text length] > 16) {
        password = YES;
        message = @"请输入6-16位字符,小写字母/数字/下划线";
    }
    else {
    
        [self HttpRequesPasswordServer];
    }
    
    if (password) {
        
        caiboAppDelegate *tsinfo = [caiboAppDelegate getAppDelegate];
        if ([message isEqualToString:@"您的输入有误,请重新输入."]) {
            
            [tsinfo showjianpanMessage:message view:tempWindow];
            YPTextField.text = @"";
            NewPTextField.text = @"";
            QRPTextField.text = @"";
            Low.image = nil;
            Mid.image = nil;
            Hig.image = nil;
            [YPTextField becomeFirstResponder];
        }
        [tsinfo showMessage:message];
        
    }
    
    
}

// ANBG960
- (void)TouchDragExit{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
}
- (void)touchxibutton{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
}
-(void)TouchCancel{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:15];
}

- (void)HttpRequesPasswordServer {

    NSMutableData *passwordData = [[GC_HttpService sharedInstance] reSetPassword:YPTextField.text newPassword:NewPTextField.text];
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myHttpRequest setRequestMethod:@"POST"];
    [myHttpRequest addCommHeaders];
    [myHttpRequest setPostBody:passwordData];
    [myHttpRequest setDidFinishSelector:@selector(requestPasswordFinished:)];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest setDelegate:self];
    [myHttpRequest startAsynchronous];

}

- (void)requestPasswordFinished:(ASIHTTPRequest *)HRequest {

    if ([HRequest responseData]) {
        
        ChangePasswordJieXi *CPassword = [[ChangePasswordJieXi alloc] initWithResponseData:[HRequest responseData] WithRequest:HRequest];
        
        //如果修改成功返回到我的彩票界面
        NSLog(@"密码返回值: %li",(long)CPassword.returnPasswordValue);
        if (CPassword.returnPasswordValue == 1) {
            [self.navigationController popViewControllerAnimated:YES];
            caiboAppDelegate *pa = [caiboAppDelegate getAppDelegate];
            [pa showMessage:@"修改密码成功"];
            
        }
        
        BOOL cw = NO;
        NSString *message2 = @"";
        if (CPassword.returnPasswordValue == 2) {
            
            if ([NewPTextField.text isEqualToString:QRPTextField.text] || (![NewPTextField.text isEqualToString:QRPTextField.text])) {
                cw = YES;
                message2 = @"您的输入有误,请重新输入.";
                
            }
            
        }
        
        if (cw) {
            caiboAppDelegate *tsinfo2 = [caiboAppDelegate getAppDelegate];
            [tsinfo2 showjianpanMessage:message2 view:tempWindow];
            YPTextField.text = @"";
            NewPTextField.text = @"";
            QRPTextField.text = @"";
            Low.image = nil;
            Mid.image = nil;
            Hig.image = nil;
            [YPTextField becomeFirstResponder];

        }
    
        [CPassword release];
    }
    
    
}


- (void)keyboardWillShow:(id)sender {
#ifdef isCaiPiaoForIPad
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    
    CPBGima.frame = CGRectMake(35, -40, 320, 400);
    
    if ([[[UIApplication sharedApplication] windows] count] <3) {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:[[[UIApplication sharedApplication] windows] count]-1];
    }else{
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

#else
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    
   // CPBGima.frame = CGRectMake(0, -40, 320, 400);
    
    if ([[[UIApplication sharedApplication] windows] count] <3) {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:[[[UIApplication sharedApplication] windows] count]-1];
    }else{
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

#endif
    
}

- (void)keyboardWillDisapper:(id)sender {
#ifdef isCaiPiaoForIPad
    
    CPBGima.frame = CGRectMake(35, 50, 320, 400);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillShowNotification object:nil];

#else
    
   // CPBGima.frame = CGRectMake(0, 10, 320, 400);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillShowNotification object:nil];

#endif
    
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[YPTextField resignFirstResponder];
    [NewPTextField resignFirstResponder];
    [QRPTextField resignFirstResponder];
    
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [YPTextField resignFirstResponder];
    [NewPTextField resignFirstResponder];
    [QRPTextField resignFirstResponder];
}
//自动删除非法字符
- (void)textFieldFunc:(UITextField *)textField {
    
    if (textField == YPTextField) {
        
        if ([YPTextField.text isContainCapital]) {
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"不可使用大写字母" view:tempWindow];//气泡提示显示在键盘之上
            if ([YPTextField.text length] > 0) {
                YPTextField.text = [YPTextField.text substringToIndex:[YPTextField.text length]-1];//自动删除输入的大写字母
            }
        }
        if (![YPTextField.text isConform] && ![YPTextField.text isContainCapital] && [YPTextField.text length] > 0) {
            
            caiboAppDelegate *ts = [caiboAppDelegate getAppDelegate];
            [ts showjianpanMessage:@"您输入了非法字符" view:tempWindow];
            if ([YPTextField.text length] > 0) {
                YPTextField.text = [YPTextField.text substringToIndex:[YPTextField.text length]-1];//自动删除输入的大写字母
            }
            
        }

    }
    
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

- (void)dealloc {

    [myHttpRequest clearDelegatesAndCancel];
    myHttpRequest = nil;

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
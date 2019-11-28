//
//  FindPasswordViewController.m
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import "FindPasswordViewController.h"
#import "Info.h"
#import "HuoQuYanZhenMaViewController.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "JSON.h"
#import "MobClick.h"

@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController
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

    self.CP_navigation.title = @"找回密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    // 整个背景图
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // backi.image = UIImageGetImageFromName(@"login_bgn.png");
    backi.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    backi.userInteractionEnabled = YES;
    [self.mainView addSubview:backi];
    [backi release];
    
    
    
    
    //白色大背景图片
    UIImageView *CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 320, 480)];
    // CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.backgroundColor = [UIColor clearColor];
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
//    //
//    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 250, 13)];
//    YPTitle.text = @"请输入用户名或绑定手机号码";
//    YPTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
//    YPTitle.font = [UIFont systemFontOfSize:12];
//    YPTitle.backgroundColor = [UIColor clearColor];
//    [CPBGima addSubview:YPTitle];
//    [YPTitle release];
    
//    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 58, 240.5, 32)];
//    YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
//    YPbgimage.userInteractionEnabled = YES;
//    [CPBGima addSubview:YPbgimage];
//    [YPbgimage release];
 
    
    
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
     view.backgroundColor = [UIColor clearColor];
    //  输入框
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 15, 320, 45)];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.placeholder = @"请输入用户名或绑定手机号码";
    // YPTextField.placeholder = @"请输入用户名或绑定手机号码";
    YPTextField.backgroundColor = [UIColor whiteColor];
    YPTextField.font = [UIFont systemFontOfSize:15];
    YPTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //YPTextField.secureTextEntry = YES;//密码
    YPTextField.textAlignment = NSTextAlignmentCenter;
    YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.leftView = view;
    YPTextField.delegate = self;
    [CPBGima addSubview:YPTextField];
    [YPTextField release];
    [view release];
    
    
    
    // 分割线
    UIView *line1 = [[[UIView alloc] init] autorelease];
    line1.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    line1.frame = CGRectMake(0, 15, 320, 0.5);
    [CPBGima addSubview:line1];
    
    UIView *line2 = [[[UIView alloc] init] autorelease];
    line2.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    line2.frame = CGRectMake(0, 15+45, 320, 0.5);
    [CPBGima addSubview:line2];
    

    
    
    //确定按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(15, 130, 290, 45);
    QDButton.userInteractionEnabled = YES;
    [QDButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
// ***
    [QDButton setBackgroundImage:[[UIImage imageNamed:@"dengluanniu-dianjihou_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateHighlighted];

    [QDButton addTarget:self action:@selector(pressEnter) forControlEvents:UIControlEventTouchUpInside];
    [QDButton addTarget:self action:@selector(touchxibutton) forControlEvents:UIControlEventTouchDown];
    [QDButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [QDButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [CPBGima addSubview:QDButton];
    
//    UIImageView *QDImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 41)];
//    QDImage.image = UIImageGetImageFromName(@"ANBG960.png");
//    QDImage.image = [QDImage.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
//    QDImage.tag = 101;
//    [QDButton addSubview:QDImage];
//    [QDImage release];
    
    
    
    
    
    
    // 确定按钮
    UILabel *QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    QDLabel.backgroundColor = [UIColor clearColor];
    QDLabel.text = @"确  定";
    QDLabel.textAlignment = NSTextAlignmentCenter;
    QDLabel.font = [UIFont boldSystemFontOfSize:18];
    QDLabel.textColor = [UIColor whiteColor];
    [QDButton addSubview:QDLabel];
    [QDLabel release];

    
    
    
    // 如需帮助请拨打:
    UILabel *YPTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 420, 100, 20)];
    YPTitle2.text = @"如需帮助请拨打:";
    YPTitle2.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
    YPTitle2.font = [UIFont systemFontOfSize:12];
    YPTitle2.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle2];
    [YPTitle2 release];
    
    
    
    
    //客服按钮
    UIButton *KFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    KFButton.frame = CGRectMake(138, 405, 160, 50);
    KFButton.userInteractionEnabled = YES;
    [KFButton addTarget:self action:@selector(pressbuttonkefu:) forControlEvents:UIControlEventTouchUpInside];
    [KFButton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
    [KFButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [CPBGima addSubview:KFButton];
    
    
    
//    UIImageView *KFImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 35)];
//    KFImage.image = UIImageGetImageFromName(@"KFBG960.png");
//    [KFButton addSubview:KFImage];
//    [KFImage release];
//    UIImageView *KFtelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 26, 15)];
//    KFtelImage.image = UIImageGetImageFromName(@"KFTel.png");
//    [KFButton addSubview:KFtelImage];
//    [KFtelImage release];
    
    
//    // 客服电话
//    UILabel *KFLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 160, 20)];
//    KFLabel.backgroundColor = [UIColor clearColor];
//    KFLabel.text = @"QQ：3254056760";
//    KFLabel.userInteractionEnabled = YES;
//    KFLabel.font = [UIFont systemFontOfSize:15];
//    KFLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
//    KFLabel.userInteractionEnabled = YES;
//    [KFButton addSubview:KFLabel];
//    [KFLabel release];

}

- (void)LoadiPadView {
    
    self.title = @"找回密码";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    //白色大背景图片
    UIImageView *CPBGima = [[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 320, 480)];
    CPBGima.image = UIImageGetImageFromName(@"CPDBG960.png");
    CPBGima.userInteractionEnabled = YES;
    [self.mainView addSubview:CPBGima];
    [CPBGima release];
    
    //
    UILabel *YPTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 250, 13)];
    YPTitle.text = @"请您输入需要找回密码的用户名:";
    YPTitle.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    YPTitle.font = [UIFont systemFontOfSize:12];
    YPTitle.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle];
    [YPTitle release];
    
    UIImageView *YPbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 58, 240.5, 32)];
    YPbgimage.image = UIImageGetImageFromName(@"DTC960.png");
    YPbgimage.userInteractionEnabled = YES;
    [CPBGima addSubview:YPbgimage];
    [YPbgimage release];
    
    YPTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 240, 32)];
    YPTextField.placeholder = @"绑定手机号码或用户名";
    YPTextField.font = [UIFont systemFontOfSize:13];
    YPTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//文字对齐
    YPTextField.autocorrectionType = UITextAutocorrectionTypeNo;//设置是否启动自动提醒更正功能
    YPTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //YPTextField.secureTextEntry = YES;//密码
    YPTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时会出现个修改X
    YPTextField.returnKeyType = UIReturnKeyDone;
    YPTextField.delegate = self;
    [YPbgimage addSubview:YPTextField];
    [YPTextField release];
    
    //确定按钮
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(40, 110, 240, 41);
    QDButton.userInteractionEnabled = YES;
    //    [QDButton setImage:UIImageGetImageFromName(@"ANBG960.png") forState:UIControlStateNormal];
    //    [QDButton setImage:UIImageGetImageFromName(@"ANBGAX960.png") forState:UIControlStateHighlighted];
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
    
    UILabel *YPTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 272, 245, 13)];
    YPTitle2.text = @"如有疑问，请联系客服";
    YPTitle2.textColor = [UIColor colorWithRed:4.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1];
    YPTitle2.font = [UIFont systemFontOfSize:12];
    YPTitle2.backgroundColor = [UIColor clearColor];
    [CPBGima addSubview:YPTitle2];
    [YPTitle2 release];
    
    //客服按钮
//    UIButton *KFButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    KFButton.frame = CGRectMake(40, 290, 240, 35);
//    KFButton.userInteractionEnabled = YES;
//    [KFButton addTarget:self action:@selector(pressbuttonkefu:) forControlEvents:UIControlEventTouchUpInside];
//    [CPBGima addSubview:KFButton];
//    
//    UIImageView *KFImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 35)];
//    KFImage.image = UIImageGetImageFromName(@"KFBG960.png");
//    [KFButton addSubview:KFImage];
//    [KFImage release];
//    
//    UIImageView *KFtelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 26, 15)];
//    KFtelImage.image = UIImageGetImageFromName(@"KFTel.png");
//    [KFButton addSubview:KFtelImage];
//    [KFtelImage release];
    
//    UILabel *KFLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 35)];
//    KFLabel.backgroundColor = [UIColor clearColor];
//    KFLabel.text = @"客服电话：QQ：3254056760";
//    KFLabel.font = [UIFont systemFontOfSize:14];
//    [KFButton addSubview:KFLabel];
//    [KFLabel release];

    
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

    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:42 topCapHeight:12];
    [YPTextField resignFirstResponder];
    
    if ([YPTextField.text length] == 0) {
        
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请输入用户名。"];
        
    }else if ([YPTextField.text length] > 0) {
    
        [self requestUserInfo];//请求用户信息
    }
    
}

- (void)TouchDragExit{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    // ANBG960
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:42 topCapHeight:12];
}
- (void)touchxibutton{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:42 topCapHeight:12];
}
-(void)TouchCancel{
    UIImageView *ima = (UIImageView *)[self.mainView viewWithTag:101];
    ima.image = [UIImageGetImageFromName(@"dengluanniu-dianjihou_1.png") stretchableImageWithLeftCapWidth:42 topCapHeight:12];
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

//网络请求函数
- (void)requestUserInfo{
    NSLog(@"%@",YPTextField.text);
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL FindpasswordUserInfo:YPTextField.text]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}

- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    if(responseString){
        
        NSDictionary *dict = [responseString JSONValue];
        
        codestr = [dict objectForKey:@"code"];
        mobilestr = [dict objectForKey:@"mobile"];
        msgstr = [dict objectForKey:@"msg"];
        
        [self PanDuanUserInfo];//判断用户信息
    }
    
}

- (void)PanDuanUserInfo {

    
    if ([codestr intValue] == 1) {
        if (mobilestr && [mobilestr length] > 0) {
            
            HuoQuYanZhenMaViewController *yz = [[HuoQuYanZhenMaViewController alloc] init];
            yz.telstring = mobilestr;
            yz.Nickname = YPTextField.text;
            [MobClick event:@"event_wodecaipiao_wangjimima_findpass"];
            [self.navigationController pushViewController:yz animated:YES];
            [yz release];
            
        }else if ([mobilestr length] == 0) {
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"没有绑定手机,无法找回密码,请联系客服"];
        }
        
    }else if ([codestr intValue] == 0) {
        
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"您填写的用户名错误。"];
        
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
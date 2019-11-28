//
//  UntionAddNickViewController.m
//  caibo
//
//  Created by yaofuyu on 12-10-25.
//
//

#import "UntionAddNickViewController.h"
#import "NSStringExtra.h"
#import "Info.h"
#import "TextFieldUtils.h"
#import "JSON.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "GC_HttpService.h"
#import "ProvingViewCotroller.h"

@interface UntionAddNickViewController ()

@end

@implementation UntionAddNickViewController

@synthesize name;
@synthesize myHttpRequest;
@synthesize dataDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadIpadView {
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setBackgroundImage:UIImageGetImageFromName(@"btn_login_normal.png") forState:UIControlStateNormal];
	[btn setBackgroundImage:UIImageGetImageFromName(@"btn_login_press.png") forState:UIControlStateHighlighted];
	[btn setTitle:@"确定" forState:UIControlStateNormal];
	[btn setTitle:@"确定" forState:UIControlStateHighlighted];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	btn.frame = CGRectMake(64 + 110, 145, 190, 44);
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(20 + 110, 12, 280, 40);
    imageView1.image = UIImageGetImageFromName(@"login_tab2_t.png");
    [self.view addSubview:imageView1];
    UILabel *labe1 = [[UILabel alloc] init];
    labe1.frame = CGRectMake(26, 25, 70, 22);
    [self.view addSubview:labe1];
    labe1.text = @"昵   称:";
    labe1.backgroundColor = [UIColor clearColor];
    [labe1 release];
    [imageView1 release];
    
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 160, 20)];
    nameText.backgroundColor = [UIColor clearColor];
    nameText.delegate = self;
    imageView1.userInteractionEnabled = YES;
    [imageView1 addSubview:nameText];
    nameText.text = [self.dataDic objectForKey:@"ncik_name"];
    [nameText release];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(20 + 110, 52, 280, 40);
    imageView2.image = UIImageGetImageFromName(@"login_tab2_m.png");
    [self.view addSubview:imageView2];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.frame = CGRectMake(26 , 65, 80, 22);
    [self.view addSubview:labe2];
    labe2.text = @"购彩密码:";
    labe2.backgroundColor = [UIColor clearColor];
    imageView2.userInteractionEnabled = YES;
    [labe2 release];
    [imageView2 release];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(110 + 110, 10, 160, 20)];
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.delegate = self;
    passWordText.secureTextEntry = YES;
    [imageView2 addSubview:passWordText];
    [passWordText release];
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(20 + 110, 92, 280, 40);
    imageView3.image = UIImageGetImageFromName(@"login_tab2_b.png");
    [self.view addSubview:imageView3];
    UILabel *labe3 = [[UILabel alloc] init];
    labe3.frame = CGRectMake(26, 105, 80, 22);
    [self.view addSubview:labe3];
    labe3.text = @"确认密码:";
    imageView3.userInteractionEnabled = YES;
    labe3.backgroundColor = [UIColor clearColor];
    [labe3 release];
    [imageView3 release];
    
    passWordAgainText = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 160, 20)];
    passWordAgainText.backgroundColor = [UIColor clearColor];
    passWordAgainText.delegate = self;
    passWordAgainText.secureTextEntry = YES;
    [imageView3 addSubview:passWordAgainText];
    [passWordAgainText release];
    
    UILabel *labe4 = [[UILabel alloc] init];
    labe4.frame = CGRectMake(26 + 110, 200, 266, 50);
    labe4.numberOfLines = 0;
    labe4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:labe4];
    labe4.text = @"购彩涉及现金流动,为确保您的账号安全请输入并牢记您的购彩密码。";
    [labe4 release];
}

- (void)LoadIphoneView {
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setBackgroundImage:UIImageGetImageFromName(@"btn_login_normal.png") forState:UIControlStateNormal];
	[btn setBackgroundImage:UIImageGetImageFromName(@"btn_login_press.png") forState:UIControlStateHighlighted];
	[btn setTitle:@"确定" forState:UIControlStateNormal];
	[btn setTitle:@"确定" forState:UIControlStateHighlighted];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	btn.frame = CGRectMake(64, 145, 190, 44);
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(20, 12, 280, 40);
    imageView1.image = UIImageGetImageFromName(@"login_tab2_t.png");
    [self.view addSubview:imageView1];
    UILabel *labe1 = [[UILabel alloc] init];
    labe1.frame = CGRectMake(26, 25, 70, 22);
    [self.view addSubview:labe1];
    labe1.text = @"昵   称:";
    labe1.backgroundColor = [UIColor clearColor];
    [labe1 release];
    [imageView1 release];
    
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 160, 20)];
    nameText.backgroundColor = [UIColor clearColor];
    nameText.delegate = self;
    imageView1.userInteractionEnabled = YES;
    [imageView1 addSubview:nameText];
    nameText.text = [self.dataDic objectForKey:@"ncik_name"];
    [nameText release];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(20, 52, 280, 40);
    imageView2.image = UIImageGetImageFromName(@"login_tab2_m.png");
    [self.view addSubview:imageView2];
    UILabel *labe2 = [[UILabel alloc] init];
    labe2.frame = CGRectMake(26, 65, 80, 22);
    [self.view addSubview:labe2];
    labe2.text = @"购彩密码:";
    labe2.backgroundColor = [UIColor clearColor];
    imageView2.userInteractionEnabled = YES;
    [labe2 release];
    [imageView2 release];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 160, 20)];
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.delegate = self;
    passWordText.secureTextEntry = YES;
    [imageView2 addSubview:passWordText];
    [passWordText release];
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(20, 92, 280, 40);
    imageView3.image = UIImageGetImageFromName(@"login_tab2_b.png");
    [self.view addSubview:imageView3];
    UILabel *labe3 = [[UILabel alloc] init];
    labe3.frame = CGRectMake(26, 105, 80, 22);
    [self.view addSubview:labe3];
    labe3.text = @"确认密码:";
    imageView3.userInteractionEnabled = YES;
    labe3.backgroundColor = [UIColor clearColor];
    [labe3 release];
    [imageView3 release];
    
    passWordAgainText = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 160, 20)];
    passWordAgainText.backgroundColor = [UIColor clearColor];
    passWordAgainText.delegate = self;
    passWordAgainText.secureTextEntry = YES;
    [imageView3 addSubview:passWordAgainText];
    [passWordAgainText release];
    
    UILabel *labe4 = [[UILabel alloc] init];
    labe4.frame = CGRectMake(26, 200, 266, 50);
    labe4.numberOfLines = 0;
    labe4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:labe4];
    labe4.text = @"购彩涉及现金流动,为确保您的账号安全请输入并牢记您的购彩密码。";
    [labe4 release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.title = @"完善昵称";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bg.png")];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView release];
    
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.name = nil;
    self.dataDic = nil;
    [super dealloc];
}

#pragma mark _
#pragma mark Action

// 校验输入框输入的内容
- (BOOL)doCheck
{
    
    NSString *message;
    BOOL isPass = YES;
    NSString *nickNameStr = nameText.text;
    NSString *psdStr = passWordText.text;
    NSString *rePsdStr = passWordAgainText.text;
    
    NSStringEncoding gb2312 = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    unsigned short nickNameStrLen = [nickNameStr lengthOfBytesUsingEncoding:(gb2312)];
    NSLog(@"-------%d", nickNameStrLen);
    
    if ([nickNameStr length] == 0)
    {
        message = @"用户名不能为空";
		[nameText Shake];
        [nameText becomeFirstResponder];
        isPass = NO;
    }
    else if([nickNameStr isAllNumber])
    {
        message = @"用户名不能全为数字";
		[nameText Shake];
        [nameText becomeFirstResponder];
        isPass = NO;
    }
    else if ([nickNameStr isContainSign])
    {
        message = @"用户名不符合要求";
		[nameText Shake];
        [nameText becomeFirstResponder];
        isPass = NO;
    }
    else if (nickNameStrLen < 4||nickNameStrLen > 16)
    {
        message = @"用户名请输入4-16位字符";
		[nameText Shake];
        [nameText becomeFirstResponder];
        isPass = NO;
    }
    else if ([psdStr length] == 0)
    {
        message = @"密码不能为空";
		[passWordText Shake];
        [passWordText becomeFirstResponder];
        isPass = NO;
    }
    else if ([psdStr isContainCapital])
    {
        message = @"密码不能为大写字母";
		[passWordText Shake];
        [passWordText becomeFirstResponder];
        isPass = NO;
    }
    else if (![psdStr isConform])
    {
        message = @"密码不符合要求";
		[passWordText Shake];
        [passWordText becomeFirstResponder];
        isPass = NO;
    }
    else if([psdStr length] < 6||[psdStr length] > 16)
    {
        message = @"密码请输入6-16位字符";
		[passWordText Shake];
        [passWordText becomeFirstResponder];
        isPass = NO;
    }
	else if(![psdStr isEqualToString:rePsdStr]) {
		message = @"密码和确认密码不一致";
		[passWordText Shake];
        [passWordText becomeFirstResponder];
        isPass = NO;
	}
    else if ([psdStr isAllNumber]) {
        message = @"密码不能由纯数字构成";
        isPass = NO;
    }
    
    else if([psdStr isAllNumber])
    {
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
    else if (![rePsdStr isEqualToString:psdStr])
    {
        message = @"您两次输入密码不一致，请重新填写";
		[passWordAgainText Shake];
        [passWordAgainText becomeFirstResponder];
        isPass = NO;
    }
    
    if (!isPass)
    {
        [passWordText Shake];
        [passWordText becomeFirstResponder];
        [Info showOkDialog:(@"提示") :(message) :(self)];
    }
    return isPass;
}

- (void)doNext {
    if ([self doCheck]) {
        btn.userInteractionEnabled = NO;
        [myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetNickNameForPPTVUnionUser:[dataDic objectForKey:@"unionId"] NickName:nameText.text UserName:[dataDic objectForKey:@"user_name"] Partnerid:[dataDic objectForKey:@"partnerid"]Password:passWordText.text]];
        [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myHttpRequest setDelegate:self];
        [myHttpRequest startAsynchronous];
    }
    
}

#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

- (void)requestFinished:(ASIHTTPRequest *)request
{
    btn.userInteractionEnabled = YES;
	NSString *responseStr = [request responseString];
    if (responseStr == nil||[responseStr isEqualToString:@"fail"])
    {
        [Info showCancelDialog:@"提示" :@"注册失败" :self];
    }
    else
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic)
        {
            if ([[dic objectForKey:@"code"] intValue] == 1){
                Info *info = [Info getInstance];
                info.userId = [dic objectForKey:@"userId"];
                info.nickName = [dic objectForKey:@"nick_name"];
                info.userName = [dic objectForKey:@"user_name"];
                info.accesstoken = [dic objectForKey:@"accesstoken"];
                UserInfo *user = [[UserInfo alloc] init];
                user.userId = [dic objectForKey:@"userId"];
                user.nick_name = [dic objectForKey:@"nick_name"];
                user.unionStatus = @"1";//
                user.user_name = [dic objectForKey:@"user_name"];
                user.partnerid = [dic objectForKey:@"partnerid"];//
                user.unionId = [dic objectForKey:@"unionId"];//
                user.accesstoken = [dic objectForKey:@"accesstoken"];
                user.isbindmobile = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"isbindmobile"] intValue]];
                user.authentication = @"1";//[dic objectForKey:@"authentication"];
                info.password = @"";
                info.mUserInfo = user;
                info.isbindmobile = user.isbindmobile;
                info.authentication = user.authentication;
                
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
//                [infoarr addObject:info.accesstoken];
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
                    [jsonParse release];
                    return;
                }
                
                [infoarr release];
                
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
                [[NSUserDefaults standardUserDefaults] setValue:[dic objectForKey:@"nick_name"] forKey:@"LogInname"];
                [[NSUserDefaults standardUserDefaults] setValue:user.isbindmobile forKey:@"isbindmobile"];
                [[NSUserDefaults standardUserDefaults] setValue:user.authentication forKey:@"authentication"];
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnionType"];
//                [GC_HttpService sharedInstance].sessionId = [dic objectForKey:@"session_id"];
                [[caiboAppDelegate getAppDelegate] LogInBySelf];
                [user release];
                ProvingViewCotroller * pro = [[ProvingViewCotroller alloc] init];
                pro.passWord = passWordText.text;
                pro.canTiaoguo = YES;
                [self.navigationController pushViewController:pro animated:YES];
                pro.navigationItem.leftBarButtonItem = nil;
                [pro.navigationItem setHidesBackButton:YES];
                [pro release];
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [alert release];
                
            }
        }
        [jsonParse release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    btn.userInteractionEnabled = YES;
	NSError *error = [request error];
    NSLog(@"%@",error);
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


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
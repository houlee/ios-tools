//
//  PPTVLoginViewController.m
//  caibo
//
//  Created by yaofuyu on 12-10-24.
//
//

#import "PPTVLoginViewController.h"
#import "NetURL.h"
#import "UntionAddNickViewController.h"
#import "JSON.h"
#import "UserInfo.h"
#import "Info.h"
#import "GC_HttpService.h"

@interface PPTVLoginViewController ()

@end

@implementation PPTVLoginViewController
@synthesize myHttpRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"PPTVloginBG960.png")];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView release];
    
    UIImageView *navImage = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"PPTVloginSBG960.png")];
    navImage.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:navImage];
    navImage.userInteractionEnabled = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [navImage addSubview:backBtn];
    backBtn.frame = CGRectMake(3, 5, 36, 34.5);
    [backBtn setImage:UIImageGetImageFromName(@"PPTVloginFH960.png") forState:UIControlStateNormal];
    
    UIButton *zhuCeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhuCeBtn addTarget:self action:@selector(goPPtv) forControlEvents:UIControlEventTouchUpInside];
    [zhuCeBtn setTitle:@"注册" forState:UIControlStateNormal];
    zhuCeBtn.frame = CGRectMake(40, 0, 45, 44);
    [navImage addSubview:zhuCeBtn];
    [navImage release];
    
    UIButton *dengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dengBtn.frame = CGRectMake(250, 5, 64, 34.5);
    [navImage addSubview:dengBtn];
    [dengBtn setImage:UIImageGetImageFromName(@"PPTVloginDL960.png") forState:UIControlStateNormal];
    [dengBtn addTarget:self action:@selector(dologin) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *inputBack = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"PPTVloginWZBG960.png")];
    inputBack.frame = CGRectMake(5, 60, 310, 102);
    [self.view addSubview:inputBack];
    inputBack.userInteractionEnabled = YES;
    
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 300, 31)];
    nameText.placeholder = @"请输入用户名";
    nameText.backgroundColor = [UIColor clearColor];
    nameText.textColor = [UIColor whiteColor];
    nameText.delegate = self;
    [inputBack addSubview:nameText];
    [nameText release];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(10, 71, 300, 31)];
    passWordText.secureTextEntry = YES;
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.placeholder = @"请输入密码";
    passWordText.delegate = self;
    [inputBack addSubview:passWordText];
    [passWordText release];
    
    [inputBack release];
    
    UIButton *dengluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dengluBtn.frame = CGRectMake(24, 180, 272, 47);
    [self.view addSubview:dengluBtn];
    [dengluBtn setImage:UIImageGetImageFromName(@"PPTVloginDLL960.png") forState:UIControlStateNormal];
    [dengluBtn addTarget:self action:@selector(dologin) forControlEvents:UIControlEventTouchUpInside];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [self.myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    [super dealloc];
}

#pragma arguments _
#pragma arguments Action

- (void)goBack {
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)goPPtv {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"pptvsports://from=caipiao365"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"pptvsports://from=caipiao365"]];
    }
    else {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv/id627781309?mt=8"]];
    }

}

- (void)dologin {
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBPPTVLoginWithUserName:nameText.text Password:passWordText.text]];
    [myHttpRequest setTimeOutSeconds:20.0];
    [self.myHttpRequest setDidFinishSelector:@selector(requestPPTVLoginFinished:)];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest setDelegate:self];
    [myHttpRequest startAsynchronous];
}

#pragma mark _
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return  YES;
}

#pragma mark _
#pragma mark ASIHTTPRequestDelegate

- (void)requestPPTVLoginFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [request responseString];
    NSLog(@"%@",responseStr);
    NSDictionary *dic  = [responseStr JSONValue];
    if ([[dic objectForKey:@"code"] intValue] == 3) {
        UIAlertView *alet = [[UIAlertView alloc] initWithTitle:[dic objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alet show];
        [alet release];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 2) {
        UntionAddNickViewController *addNick  = [[UntionAddNickViewController alloc] init];
        addNick.name = [dic objectForKey:@"nick_name"];
        addNick.dataDic = dic;
        [self.navigationController pushViewController:addNick animated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [addNick release];
    }
    else if ([[dic objectForKey:@"code"] intValue] == 1||[dic objectForKey:@"session_id"]) {
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
//        [infoarr addObject:info.accesstoken];
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
                [[NSUserDefaults standardUserDefaults] setValue:[dic objectForKey:@"nick_name"] forKey:@"LogInname"];
        [[NSUserDefaults standardUserDefaults] setValue:user.isbindmobile forKey:@"isbindmobile"];
        [[NSUserDefaults standardUserDefaults] setValue:user.authentication forKey:@"authentication"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnionType"];
        //[GC_HttpService sharedInstance].sessionId = [dic objectForKey:@"session_id"];
        [user release];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
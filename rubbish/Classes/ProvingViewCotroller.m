//
//  ProvingViewCotroller.m
//  caibo
//
//  Created by  on 12-5-12.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "ProvingViewCotroller.h"
#import "Info.h"
#import "Statement.h"
#import "User.h"
#import "UserInfo.h"
#import "DataBase.h"
#import "NetURL.h"
#import "JSON.h"
#import "NSStringExtra.h"
#import "RegexKitLite.h"
#include <string.h>/*包含字符串处理头文件*/
#import "DuanXinViewController.h"
#import "GC_HttpService.h"
#import "SongCaiJin.h"
#import "UntionAddNickViewController.h"
#import "MobClick.h"
#import "GC_ZhuCeChengGongViewCotroller.h"

#import "GC_NSString+AESCrypt.h"

@implementation ProvingViewCotroller
@synthesize reqUserInfo;
@synthesize requst;
@synthesize mustWrite;
@synthesize canTiaoguo;
@synthesize canBack;
@synthesize passWord;
@synthesize duanxinbool;
@synthesize disanfang;
@synthesize id_number,true_name, imageRequest;

@synthesize timer;


//int ID15to18(char str[])/*15位转换为18位算法*/
//{
//    int s=0,pos,i;
//    int w[]={7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};/*权重表数组*/
//    char code[]={'1','0','X','9','8','7','6','5','4','3','2'};/*校验码查找表*/
//    if (strlen(str)==15)
//    {
//        for(i=16;i>7;i--)
//            str[i]=str[i-2];/*插入数字19*/
//        str[6]='1';
//        str[7]='9';
//        for(i=0;i<17;i++)/*求17位数字本体码加权和*/
//            s+=(str[i]-'0')*w[i];
//        pos=s%11;/*求模*/
//        str[17]=code[pos];/*插入校验位*/
//        str[18]= ' ';
//        return 1;
//    }
//    else
//        return 0;
//}
//
//- (void)ID15main{
//
//    int i;
//    char ID15[19];
//    /*char ID15[19]={'4','3','0','7','2','1','8','6','0','6','1','9','1','9','1'};这是我的15位ID号码*/
//   // cout<<"please input your 15bit ID number:"<<endl;
//   // cin>>ID15;
//    ID15to18(ID15);
// //   cout<<"you 18bit ID number is:";
//    for(i=0;i<19;i++)
//        printf("%c", ID15[i]);
//   //     cout<<ID15[i];
//
//}
//


const int factor[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };//加权因子
const int checktable[] = { 1, 0, 'x', 9, 8, 7, 6, 5, 4, 3, 2 };//校验值对应表

int checkIDfromchar( char *ID )
{
    if (strlen(ID)!=18) {//验证18位
        return 0;
    }
    int IDNumber[ 19 ];
    for ( int i = 0; i < 18; i ++ )//相当于类型转换
        IDNumber[ i ] = ID[ i ] - 48;
    return checkID( IDNumber, ID );
}


int checkID( int IDNumber[], char ID[] )
{
    int i = 0;//i为计数
    int checksum = 0;
    for ( ; i < 17; i ++ )
        checksum += IDNumber[ i ] * factor[ i ];
    printf("aaa = %c, bbb = %d\n", ID[17], checktable[ checksum % 11 ]);
    if ( IDNumber[ 17 ] == checktable[ checksum % 11 ] || ( ID[ 17 ] == 'x' && checktable[ checksum % 11 ] == 'x' )||( ID[ 17 ] == 'X' && checktable[ checksum % 11 ] == 'x' ))
        return 1;
    else
        return 0;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		mustWrite = NO;
		canBack = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCaptcha) name:@"GotCaptcha" object:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"Register" forKey:@"CaptchaType"];
        
        timem = 60;
    }
    return self;
}

-(void)addCaptcha
{
    textfield4.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Captcha"];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */
- (void)LoadiPadView {

    
        [self.navigationController setNavigationBarHidden:YES];
        self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");
        self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
        self.mainView.frame = CGRectMake(0, 0, 540, 620);
        
        if (self.CP_navigation.title == nil) {
            self.CP_navigation.title = @"我的身份信息";
        }
        if (canTiaoguo) {
            self.CP_navigation.title = @"完善领奖资料";
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
        
        
        
        
        if (canBack) {
            UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
            [self.CP_navigation setLeftBarButtonItem:(leftItem)];
        }
        else {
            [self.CP_navigation setHidesBackButton:YES];
        };
        
        if ([self.navigationController.viewControllers count] == 1) {
            self.CP_navigation.title = @"完善领奖资料";
        }
        if (canTiaoguo) {
            
            
            if (duanxinbool) {
                UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
                [self.CP_navigation setLeftBarButtonItem:(leftItem)];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBounds:CGRectMake(0, 0, 70, 40)];
                UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
                imagevi.backgroundColor = [UIColor clearColor];
                imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
                [btn addSubview:imagevi];
                [imagevi release];
                
                UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
                lilable.textColor = [UIColor whiteColor];
                lilable.backgroundColor = [UIColor clearColor];
                lilable.textAlignment = NSTextAlignmentCenter;
                lilable.font = [UIFont boldSystemFontOfSize:14];
                lilable.shadowColor = [UIColor blackColor];//阴影
                lilable.shadowOffset = CGSizeMake(0, 1.0);
                lilable.text = @"完成";
                [btn addSubview:lilable];
                [lilable release];
                [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
                self.CP_navigation.rightBarButtonItem = barBtnItem;
                [barBtnItem release];
                
            }else{
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBounds:CGRectMake(0, 0, 70, 40)];
                UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
                imagevi.backgroundColor = [UIColor clearColor];
                imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
                [btn addSubview:imagevi];
                [imagevi release];
                
                UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
                lilable.textColor = [UIColor whiteColor];
                lilable.backgroundColor = [UIColor clearColor];
                lilable.textAlignment = NSTextAlignmentCenter;
                lilable.font = [UIFont boldSystemFontOfSize:14];
                lilable.shadowColor = [UIColor blackColor];//阴影
                lilable.shadowOffset = CGSizeMake(0, 1.0);
                lilable.text = @"跳过";
                [btn addSubview:lilable];
                [lilable release];
                [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
                self.CP_navigation.rightBarButtonItem = barBtnItem;
                [barBtnItem release];
            }
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBounds:CGRectMake(0, 0, 70, 40)];
            UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
            imagevi.backgroundColor = [UIColor clearColor];
            imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
            [btn addSubview:imagevi];
            [imagevi release];
            
            UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
            lilable.textColor = [UIColor whiteColor];
            lilable.backgroundColor = [UIColor clearColor];
            lilable.textAlignment = NSTextAlignmentCenter;
            lilable.font = [UIFont boldSystemFontOfSize:14];
            lilable.shadowColor = [UIColor blackColor];//阴影
            lilable.shadowOffset = CGSizeMake(0, 1.0);
            lilable.text = @"完成";
            [btn addSubview:lilable];
            [lilable release];
            [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.CP_navigation.rightBarButtonItem = barBtnItem;
            [barBtnItem release];
        }
        
    
        allView = [[UIView alloc] initWithFrame:self.mainView.bounds];
        allView.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:allView];
        //背景
        UIImageView *backimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
        backimage.image = UIImageGetImageFromName(@"bejing.png");
        [allView addSubview:backimage];
        [backimage release];
        
        //用户信息背景
        UIImageView *UserBack = [[UIImageView alloc] initWithFrame:CGRectMake(135, 70, 300, 135)];
        UserBack.image = UIImageGetImageFromName(@"set-shenfenback.png");
        UserBack.userInteractionEnabled = YES;
        [allView addSubview:UserBack];
        [UserBack release];
        
        //用户名
        UILabel *userl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 70, 20)];
        userl.text = @"用 户 名  :";
        userl.backgroundColor = [UIColor clearColor];
        userl.font = [UIFont systemFontOfSize:13];
        userl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        
        UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 180, 20)];
        username.text = [[Info getInstance] nickName];
        username.backgroundColor = [UIColor clearColor];
        username.font = [UIFont systemFontOfSize:13];
        username.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        [UserBack addSubview:userl];
        [UserBack addSubview:username];
        [userl release];
        [username release];
        
        UILabel *namela1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 70, 20)];
        namela1.text = @"真实姓名 :";
        namela1.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        namela1.font = [UIFont systemFontOfSize:13];
        namela1.backgroundColor = [UIColor clearColor];
        [UserBack addSubview:namela1];
        
        UILabel *namela2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 70, 20)];
        namela2.text = @"身份证号 :";
        namela2.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        namela2.font = [UIFont systemFontOfSize:13];
        namela2.backgroundColor = [UIColor clearColor];
        [UserBack addSubview:namela2];
        
        UILabel *namela3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 70, 20)];
        namela3.text = @"手 机 号  :";
        namela3.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        namela3.font = [UIFont systemFontOfSize:13];
        namela3.backgroundColor = [UIColor clearColor];
        [UserBack addSubview:namela3];
        
        [namela1 release];
        [namela2 release];
        [namela3 release];
        
        //手机验证
        NSLog(@"isbingmobile = %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"]);
        if (canBack) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                
                
                textimage4 = [[UIImageView alloc] initWithFrame:CGRectMake(135, 233, 220, 31)];
                textimage4.backgroundColor = [UIColor clearColor];
                textimage4.image = UIImageGetImageFromName(@"wodeshenfenxinxi-1.png");
//                namela4 = [[UILabel alloc] initWithFrame:CGRectMake(0, -3, 87, 35)];
//                namela4.text = @"验证码:";
//                namela4.textAlignment = NSTextAlignmentCenter;
//                namela4.textColor = [UIColor whiteColor];
//                namela4.font = [UIFont systemFontOfSize:13];
//                namela4.backgroundColor = [UIColor clearColor];
//                [textimage4 addSubview:namela4];
                [allView addSubview:textimage4];
                [textimage4 release];
//                [namela4 release];
                
                textfield4 = [[UITextField alloc] initWithFrame:CGRectMake(235, 240, 115, 25)];
                textfield4.autocorrectionType = UITextAutocorrectionTypeYes;
                textfield4.returnKeyType = UIReturnKeyDone;
                [textfield4 setClearButtonMode:UITextFieldViewModeWhileEditing];
                textfield4.delegate = self;
                textfield4.enabled = NO;
                [self addCaptcha];
                textfield4.font = [UIFont systemFontOfSize:14];
                textfield4.backgroundColor = [UIColor clearColor];
                [allView addSubview:textfield4];
                
                
                huoqubut = [UIButton buttonWithType:UIButtonTypeCustom];
                huoqubut.frame = CGRectMake(365, 233, 70, 28);
                [huoqubut setImage:UIImageGetImageFromName(@"wodeshenfenxinxi-2.png")  forState:UIControlStateNormal];

                [huoqubut addTarget:self action:@selector(pressYanZhengButton:) forControlEvents:UIControlEventTouchUpInside];

                
            }
            
        }
        
        textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(90, 40, 180, 20)];
        textfield1.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        textfield1.font = [UIFont systemFontOfSize:12];
        textfield1.autocorrectionType = UITextAutocorrectionTypeYes;
        textfield1.backgroundColor = [UIColor clearColor];
        textfield1.returnKeyType = UIReturnKeyDone;
        [textfield1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        textfield1.delegate = self;
        textfield1.enabled = NO;
        
        
        textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(90, 65, 180, 20)];
        textfield2.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        textfield2.font = [UIFont systemFontOfSize:12];
        textfield2.autocorrectionType = UITextAutocorrectionTypeYes;
        textfield2.returnKeyType = UIReturnKeyDone;
        [textfield2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        textfield2.delegate = self;
        textfield2.enabled = NO;
        
        textfield3 = [[UITextField alloc] initWithFrame:CGRectMake(90, 90, 180, 20)];
        textfield3.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
        textfield3.font = [UIFont systemFontOfSize:12];
        textfield3.autocorrectionType = UITextAutocorrectionTypeYes;
        textfield3.returnKeyType = UIReturnKeyDone;
        [textfield3 setClearButtonMode:UITextFieldViewModeWhileEditing];
        textfield3.delegate = self;
        textfield3.enabled = NO;
        
        [UserBack addSubview:textfield1];
        [UserBack addSubview:textfield2];
        [UserBack addSubview:textfield3];
        
        
        // self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
        //+ (NSURL *)CPThreeGetAuthentication:(NSString *)username userpassword:(NSString *)password
        NSLog(@"name = %@, pass = %@", [[User getLastUser] nick_name], [[User getLastUser] password]);
        //  NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[User getLastUser] nick_name] userpassword:[[User getLastUser] password]]);
        NSString * type;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            type = @"0";
        }else{
            type = @"1";
        }
        //    [[Info getInstance] nick_name];
        //    [[Info getInstance] password];
        
        NSString * passwstr = @"";
        if(self.passWord){
            passwstr = self.passWord;
            
        }
        NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]);
        self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
        [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished2:)];
        [reqUserInfo setDelegate:self];
        [reqUserInfo startAsynchronous];
        
        
        if (canTiaoguo) {
            NSTimer * timeropen = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(openTimerFire) userInfo:nil repeats:YES];
            [timeropen fire];
        }

    //}
    
    
    
    
    
}
- (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    // Encode all the reserved characters, per RFC 3986
    
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    NSString *outputStr = (NSString *)
    
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            
                                            (CFStringRef)input,
                                            
                                            NULL,
                                            
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            
                                            kCFStringEncodingUTF8);
    
    return [outputStr autorelease];
    
}

- (void)imageAsiRequest{
    
    [imageRequest clearDelegatesAndCancel];
    
    NSString *userId = @"";
    if ([[Info getInstance] userId]) {
        
        userId = [[Info getInstance] userId];
        userId = [userId AES256EncryptWithKey:AllparaSecretKey];
        userId = [self encodeToPercentEscapeString:userId];
    }
    
    NSString * verifyString = [NSString stringWithFormat:@"%@&userId=%@", verifyCode, userId];
     NSURL *url=[NSURL URLWithString:verifyString];
    self.imageRequest = [ASIHTTPRequest requestWithURL:url];
    [imageRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [imageRequest setDidFinishSelector:@selector(reqImageUrlFinished:)];
    [imageRequest setDelegate:self];
    [imageRequest startAsynchronous];

}

- (void)reqImageUrlFinished:(ASIHTTPRequest *)requestm{/// 图片验证码请求

    NSError *error=[requestm error];
    if (error) {
        return;
    }
    
    iconImageView.image = [UIImage imageWithData:[requestm responseData]];
    
}

- (void)LoadiPhoneView {

    if (self.title == nil) {
		self.title = @"完善领奖资料";
	}
    if (canTiaoguo) {
        self.title = @"完善领奖资料";
    }
    

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.mainView.layer setMasksToBounds:YES];
    
    
	if (canBack) {
		UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
		[self.CP_navigation setLeftBarButtonItem:(leftItem)];
	}
	else {
		[self.CP_navigation setHidesBackButton:YES];
	};
    
    if ([self.navigationController.viewControllers count] == 1) {
		self.title = @"完善领奖资料";
	}
	if (canTiaoguo) {
		
        
        if (duanxinbool) {
            UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
            [self.CP_navigation setLeftBarButtonItem:(leftItem)];
            
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBounds:CGRectMake(0, 0, 70, 40)];
            UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
            imagevi.backgroundColor = [UIColor clearColor];
            imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
            [btn addSubview:imagevi];
            [imagevi release];
            
            UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
            lilable.textColor = [UIColor whiteColor];
            lilable.backgroundColor = [UIColor clearColor];
            lilable.textAlignment = NSTextAlignmentCenter;
            lilable.font = [UIFont boldSystemFontOfSize:14];
            lilable.shadowColor = [UIColor blackColor];//阴影
            lilable.shadowOffset = CGSizeMake(0, 1.0);
            lilable.text = @"完成";
            [btn addSubview:lilable];
            [lilable release];
            [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.CP_navigation.rightBarButtonItem = barBtnItem;
            [barBtnItem release];
            
            

        }else{
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"跳过" Target:self action:@selector(doBack)];
            [self.CP_navigation setRightBarButtonItem:rightItem];
        }
	}
	else {
        

	}
    
    
    UIImageView * backimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    //    backimage.image = UIImageGetImageFromName(@"login_bgn.png");
    //  [self.mainView addSubview:backimage];
    backimage.backgroundColor = [UIColor colorWithRed:249/255.0 green:248/255.0 blue:241/255.0 alpha:1];
    
    [self.mainView addSubview:backimage];
    [backimage release];
    
    allView = [[UIView alloc] initWithFrame:self.mainView.bounds];
    allView.backgroundColor = [UIColor clearColor];
    
    
    
    if (IS_IPHONE_5) {
        
       
        [self.mainView addSubview:allView];
        
    }else{
        
        UIScrollView * myScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, self.mainView.frame.size.height + 60);
        myScrollView.backgroundColor = [UIColor clearColor];
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        [myScrollView addSubview:allView];
        [self.mainView addSubview:myScrollView];
        [myScrollView release];
        
    }
    
    
    //背景
    
    
    mutableBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10.5, 320, 180)];
//    mutableBG.image = [UIImageGetImageFromName(@"SZT960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    mutableBG.backgroundColor = [UIColor whiteColor];
    mutableBG.userInteractionEnabled = YES;
    [allView addSubview:mutableBG];
    
    UIView * topLine = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, mutableBG.frame.size.width, 0.5)] autorelease];
    topLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [mutableBG addSubview:topLine];
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, mutableBG.frame.size.height, mutableBG.frame.size.width, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [mutableBG addSubview:bottomLine];
    
    //用户名
    UILabel * userl = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 45)] autorelease];
    userl.text = @"用户名";
    userl.font = [UIFont systemFontOfSize:16];
    userl.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    userl.backgroundColor = [UIColor clearColor];
    [mutableBG addSubview:userl];
    
    UILabel * username = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(userl) + 15, userl.frame.origin.y, 160, userl.frame.size.height)];
    username.text = [[Info getInstance] nickName];
    username.font = [UIFont systemFontOfSize:16];
    username.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    username.backgroundColor = [UIColor clearColor];
    username.textAlignment = NSTextAlignmentLeft;
    [mutableBG addSubview:username];
    [username release];
    
    
    UILabel * ljlabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(username), username.frame.origin.y, mutableBG.frame.size.width - ORIGIN_X(username), username.frame.size.height)];
    ljlabel.text = @"请牢记";
    ljlabel.textAlignment = NSTextAlignmentLeft;
    ljlabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    ljlabel.font = [UIFont systemFontOfSize:12];
    ljlabel.backgroundColor = [UIColor clearColor];
    [mutableBG addSubview:ljlabel];
    [ljlabel release];
    
    
    
    UILabel * namela1 = [[[UILabel alloc] initWithFrame:CGRectMake(userl.frame.origin.x, ORIGIN_Y(userl), userl.frame.size.width, userl.frame.size.height)] autorelease];
    namela1.text = @"真实姓名";
    namela1.font = [UIFont systemFontOfSize:16];
    namela1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    namela1.backgroundColor = [UIColor clearColor];
    [mutableBG addSubview:namela1];
    
    UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(namela1.frame.origin.x, namela1.frame.origin.y, mutableBG.frame.size.width - namela1.frame.origin.x, 0.5)] autorelease];
    line.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [mutableBG addSubview:line];
    
    UILabel * namela2 = [[[UILabel alloc] initWithFrame:CGRectMake(namela1.frame.origin.x, ORIGIN_Y(namela1), namela1.frame.size.width, namela1.frame.size.height)] autorelease];
    
    namela2.text = @"身份证号";
    namela2.font = [UIFont systemFontOfSize:16];
    namela2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    namela2.backgroundColor = [UIColor clearColor];
    [mutableBG addSubview:namela2];
    
    UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(namela2.frame.origin.x, namela2.frame.origin.y, mutableBG.frame.size.width - namela2.frame.origin.x, 0.5)] autorelease];
    line1.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [mutableBG addSubview:line1];
    
    UILabel * namela3 = [[[UILabel alloc] initWithFrame:CGRectMake(namela2.frame.origin.x, ORIGIN_Y(namela2), namela2.frame.size.width, namela2.frame.size.height)] autorelease];
    namela3.text = @"手机号码";
    namela3.font = [UIFont systemFontOfSize:16];
    namela3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    namela3.backgroundColor = [UIColor clearColor];
    [mutableBG addSubview:namela3];
    
    UIView * line2 = [[[UIView alloc] initWithFrame:CGRectMake(namela3.frame.origin.x, namela3.frame.origin.y, mutableBG.frame.size.width - namela3.frame.origin.x, 0.5)] autorelease];
    line2.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [mutableBG addSubview:line2];
    
    //手机验证
    NSLog(@"isbingmobile = %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"]);
    if (canBack) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            
            mutableBG.frame = CGRectMake(0, 10.5, 320, 225+45);
            bottomLine.frame = CGRectMake(0, mutableBG.frame.size.height, mutableBG.frame.size.width, 0.5);


            
            textfield4 = [[UITextField alloc] initWithFrame:CGRectMake(namela3.frame.origin.x, ORIGIN_Y(namela3), 193, namela3.frame.size.height)];
            textfield4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield4.autocorrectionType = UITextAutocorrectionTypeYes;
            textfield4.returnKeyType = UIReturnKeyDone;
            [textfield4 setClearButtonMode:UITextFieldViewModeWhileEditing];
            textfield4.backgroundColor = [UIColor clearColor];
            textfield4.delegate = self;
            textfield4.enabled = NO;
            textfield4.placeholder = @"输入手机收到的验证码";
            textfield4.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [self addCaptcha];
            textfield4.font = [UIFont systemFontOfSize:16];
            //        [self.mainView addSubview:textfield4];
            [mutableBG addSubview:textfield4];
            
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(textfield4.frame.origin.x, textfield4.frame.origin.y, mutableBG.frame.size.width - textfield4.frame.origin.x, 0.5)] autorelease];
            line.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [mutableBG addSubview:line];
            
            huoqubut = [UIButton buttonWithType:UIButtonTypeCustom];
            huoqubut.frame = CGRectMake(ORIGIN_X(textfield4) + 7, textfield4.frame.origin.y + 7, 90, 30);
            [huoqubut setBackgroundImage:UIImageGetImageFromName(@"gc_yanz.png")  forState:UIControlStateNormal];
            [huoqubut setBackgroundImage:UIImageGetImageFromName(@"gc_yanz_0.png") forState:UIControlStateDisabled];
            [huoqubut addTarget:self action:@selector(pressYanZhengButton:) forControlEvents:UIControlEventTouchUpInside];
            [huoqubut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [huoqubut setTitleColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1] forState:UIControlStateDisabled];
            [huoqubut setTitle:@"获取验证码" forState:UIControlStateNormal];
            huoqubut.titleLabel.font = [UIFont systemFontOfSize:15];
            huoqubut.titleLabel.textAlignment = NSTextAlignmentCenter;
            [mutableBG addSubview:huoqubut];
            
            
            
            
            textfield5 = [[UITextField alloc] initWithFrame:CGRectMake(namela3.frame.origin.x, ORIGIN_Y(textfield4), 193, textfield4.frame.size.height)];
            textfield5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield5.autocorrectionType = UITextAutocorrectionTypeYes;
            textfield5.returnKeyType = UIReturnKeyDone;
            [textfield5 setClearButtonMode:UITextFieldViewModeWhileEditing];
            textfield5.backgroundColor = [UIColor clearColor];
            textfield5.delegate = self;
            textfield5.placeholder = @"输入验证码";
            textfield5.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            textfield5.font = [UIFont systemFontOfSize:16];
            //        [self.mainView addSubview:textfield4];
            [mutableBG addSubview:textfield5];
            
            
            iconImageView = [[UIImageView alloc] init];
            iconImageView.userInteractionEnabled = YES;
            iconImageView.frame = CGRectMake(ORIGIN_X(textfield5) + 7, textfield5.frame.origin.y + 7, 90, 30);
            [mutableBG addSubview:iconImageView];
            [iconImageView release];
            
            UIButton * verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            verifyButton.frame = iconImageView.bounds;
            [iconImageView addSubview:verifyButton];
            [verifyButton addTarget:self action:@selector(pressVerifyButton:) forControlEvents:UIControlEventTouchUpInside];
        
            iconImageView.image = UIImageGetImageFromName(@"updataImagepro.png");
            
            [self imageAsiRequest];
            
            
            
            UIView * line6 = [[[UIView alloc] initWithFrame:CGRectMake(textfield5.frame.origin.x, textfield5.frame.origin.y, mutableBG.frame.size.width - textfield5.frame.origin.x, 0.5)] autorelease];
            line6.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [mutableBG addSubview:line6];
            
            


        }
        
    }
    

    
    textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(namela1) + 15, namela1.frame.origin.y, mutableBG.frame.size.width - ORIGIN_X(namela1) + 15 - 40, namela1.frame.size.height)];
    textfield1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield1.autocorrectionType = UITextAutocorrectionTypeYes;
    textfield1.backgroundColor = [UIColor clearColor];
    textfield1.font = [UIFont systemFontOfSize:16];
    textfield1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    textfield1.returnKeyType = UIReturnKeyDone;
    [textfield1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    textfield1.delegate = self;
    textfield1.enabled = NO;
    [mutableBG addSubview:textfield1];
    

    
    textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(namela2) + 15, namela2.frame.origin.y, mutableBG.frame.size.width - ORIGIN_X(namela2) + 15 - 40, namela2.frame.size.height)];
    textfield2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield2.autocorrectionType = UITextAutocorrectionTypeYes;
    textfield2.returnKeyType = UIReturnKeyDone;
    textfield2.backgroundColor = [UIColor clearColor];
    textfield2.font = [UIFont systemFontOfSize:16];
    textfield2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [textfield2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    textfield2.delegate = self;
    textfield2.enabled = NO;
    [mutableBG addSubview:textfield2];
    

    
    textfield3 = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(namela3) + 15, namela3.frame.origin.y, mutableBG.frame.size.width - ORIGIN_X(namela3) + 15 - 40, namela3.frame.size.height)];
    textfield3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield3.autocorrectionType = UITextAutocorrectionTypeYes;
    textfield3.returnKeyType = UIReturnKeyDone;
    textfield3.backgroundColor = [UIColor clearColor];
    textfield3.font = [UIFont systemFontOfSize:16];
    textfield3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [textfield3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    textfield3.delegate = self;
    textfield3.enabled = NO;
    [mutableBG addSubview:textfield3];
    
    
    // self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
    //+ (NSURL *)CPThreeGetAuthentication:(NSString *)username userpassword:(NSString *)password
    NSLog(@"name = %@, pass = %@", [[User getLastUser] nick_name], [[User getLastUser] password]);
    //  NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[User getLastUser] nick_name] userpassword:[[User getLastUser] password]]);
    NSString * type;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        type = @"0";
    }else{
        type = @"1";
    }
    //    [[Info getInstance] nick_name];
    //    [[Info getInstance] password];
    
    NSString * passwstr = @"";
    if(self.passWord){
        passwstr = self.passWord;
        
    }
    NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]);
    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [reqUserInfo setDelegate:self];
    [reqUserInfo startAsynchronous];
    
    
    if (canTiaoguo) {
        NSTimer * timeropen = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(openTimerFire) userInfo:nil repeats:YES];
        [timeropen fire];
    }
    
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
        
        
        self.CP_navigation.rightBarButtonItem = nil;
        textfield4.hidden = YES;
        textfield5.hidden = YES;
        iconImageView.hidden = YES;
        huoqubut.hidden = YES;
//        yanzhengLab.hidden = YES;
        textimage4.hidden = YES;
        mutableBG.frame = CGRectMake(0, 10.5, 320, 180);
        bottomLine.frame = CGRectMake(0, mutableBG.frame.size.height, mutableBG.frame.size.width, 0.5);

//        namela4.hidden = YES;
        textfield1.placeholder = @"领取大奖凭证";
        textfield2.placeholder = @"领取大奖凭证";
        textfield3.placeholder = @"用于中奖通知及找回密码";
        newBool = YES;
        
        doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        doneButton.backgroundColor = [UIColor whiteColor];
        doneButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 290, 45);
        [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImageGetImageFromName(@"WanShanDisabled.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [allView addSubview:doneButton];
        [doneButton setTitle:@"完   成" forState:UIControlStateNormal];
        doneButton.enabled = NO;
        

        
    }
    
}

- (void)pressVerifyButton:(UIButton *)sender{
    iconImageView.image = UIImageGetImageFromName(@"updataImagepro.png");
    [self imageAsiRequest];
}

- (void)keFuTel:(UIButton *)sender {
    if ([sender.superview isKindOfClass:[CP_UIAlertView class]]) {
        [sender.superview removeFromSuperview];
    }
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
}

- (BOOL)verifyFunc{

    BOOL ID15bool = NO;
    NSString * str = @"";
	int bol = 0;
	if ([textfield2.text length] == 0) {
		bol = 0;
	}
	else {
        if ([textfield2.text length] == 15) {
            ID15bool = [textfield2.text shenfenzheng15];
            if (ID15bool) {
                bol = 1;
                NSString *year = [[textfield2.text substringFromIndex:6] substringToIndex:6];
                NSLog(@"year=%@",year);
                year = [NSString stringWithFormat:@"19%@",year];
                NSString *sysTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"sysTime"];
                if ([sysTime length] > 10) {
                    sysTime = [[[sysTime componentsSeparatedByString:@" "] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"-" withString:@""] ;
                }
                else {
                    NSDate *  senddate=[NSDate date];
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYYMMdd"];
                    sysTime=[dateformatter stringFromDate:senddate];
                    [dateformatter release];
                }
                if ([sysTime doubleValue] - [year doubleValue] <= 180000) {
                    CP_UIAlertView *alertBGView = [[CP_UIAlertView alloc] initWithTitle:nil message:@"\n未满18周岁的青少年禁止购买彩票!" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                    [alertBGView show];
                    [alertBGView release];
                    UIButton * keFuButton = [[[UIButton alloc] initWithFrame:CGRectMake(40, alertBGView.bounds.size.height/2 -5, 240, 40)] autorelease];
                    [alertBGView addSubview:keFuButton];
                    [keFuButton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
                    keFuButton.titleLabel.font = [UIFont systemFontOfSize:16];
                    [keFuButton setTitleColor:[UIColor colorWithRed:0 green:132/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
                    [keFuButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
                    [keFuButton addTarget:self action:@selector(keFuTel:) forControlEvents:UIControlEventTouchUpInside];
                    
                    return NO;
                }
            }
            
        }else{
            if ([textfield2.text length] == 18) {
                NSString *year = [[textfield2.text substringFromIndex:6] substringToIndex:8];
                NSLog(@"year=%@",year);
                NSString *sysTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"sysTime"];
                if ([sysTime length] > 10) {
                    sysTime = [[[sysTime componentsSeparatedByString:@" "] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
                else {
                    NSDate *  senddate=[NSDate date];
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYYMMdd"];
                    sysTime=[dateformatter stringFromDate:senddate];
                    [dateformatter release];
                }
                if ([sysTime doubleValue] - [year doubleValue] <= 180000) {
                    CP_UIAlertView *alertBGView = [[CP_UIAlertView alloc] initWithTitle:nil message:@"\n未满18周岁的青少年禁止购买彩票! " delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                    [alertBGView show];
                    [alertBGView release];
                    UIButton * keFuButton = [[[UIButton alloc] initWithFrame:CGRectMake(40, alertBGView.bounds.size.height/2 -5, 240, 40)] autorelease];
                    [alertBGView addSubview:keFuButton];
                    [keFuButton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
                    keFuButton.titleLabel.font = [UIFont systemFontOfSize:16];
                    [keFuButton setTitleColor:[UIColor colorWithRed:0 green:132/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
                    [keFuButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
                    [keFuButton addTarget:self action:@selector(keFuTel:) forControlEvents:UIControlEventTouchUpInside];

                    return NO;
                }
            }
            bol = checkIDfromchar((char *)[textfield2.text UTF8String]);
        }
		
	}
    
    
    if ([textfield1.text length] < 2 || [textfield1.text length] > 10 || ![textfield1.text isMatchWithRegexString:@"^[\\u4E00-\\u9FA5·•]+$"]) {
        
        str = @"真实姓名不合法,请输入2-10个汉字.";
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
        
        return NO;
    }else if(bol == 0 || (ID15bool == NO&&[textfield2.text length]==15)){
        
        str = @"身份证号格式不合法.";
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
        return NO;
    }else if(![textfield3.text isAllNumber] || [textfield3.text length] != 11||![textfield3.text isPhoneNumber]){
        str = @"手机号格式不合法.";
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
        return NO;
    }
    return YES;
}

- (void)pressDoneButton:(UIButton *)sender{
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    
    if([textfield1.text rangeOfString:@" "].location != NSNotFound){
    
        textfield1.text = [textfield1.text stringByReplacingOccurrencesOfRegex:@" " withString:@""];
    }
    if([textfield2.text rangeOfString:@" "].location != NSNotFound){
        
        textfield2.text = [textfield2.text stringByReplacingOccurrencesOfRegex:@" " withString:@""];
    }
    if([textfield3.text rangeOfString:@" "].location != NSNotFound){
        
        textfield3.text = [textfield3.text stringByReplacingOccurrencesOfRegex:@" " withString:@""];
    }

    
    if ([self verifyFunc] == NO) {
        return;
    }
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {
        [MobClick event:@"event_disanfang denglu_wanshanlingjiang_wancheng"];
    }
    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"请确认以下信息:" message:[NSString stringWithFormat:@"用户名:%@\n真实姓名:%@\n身份证号:%@\n手机号码:%@", [[Info getInstance] nickName], textfield1.text, textfield2.text, textfield3.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 209;
    [aler show];
    [aler release];
    
    
    
    
}

- (void)reqUserwsFinished:(ASIHTTPRequest *)mrequset{


    NSString *responseStr = [mrequset responseString];
    NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
    NSDictionary * dict = [responseStr JSONValue];
    NSLog(@"resp = %@", dict);
    NSString * codestr = [dict objectForKey:@"code"];
    NSString * msgstr = @"";
    msgstr = [dict objectForKey:@"msg"];
    
    if ([codestr isEqualToString:@"0"]) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] intValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"authentication"];
            
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"完善资料成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            aler.tag = 333;
            [aler show];
            [aler release];

        }else{
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"authentication"];
          
            
            //显示验证码
            textfield4.hidden = NO;
            textfield5.hidden = NO;
            iconImageView.hidden = NO;
            huoqubut.hidden = NO;
            mutableBG.frame = CGRectMake(0, 10.5, 320, 225+45);
            bottomLine.frame = CGRectMake(0, mutableBG.frame.size.height, mutableBG.frame.size.width, 0.5);
            //        yanzhengLab.hidden = NO;
            textimage4.hidden = NO;
            //        namela4.hidden = NO;
            textfield1.enabled = NO;
            textfield2.enabled = NO;
            
            self.CP_navigation.leftBarButtonItem = nil;
            self.CP_navigation.title = @"验证手机号码";
            textfield4.frame = CGRectMake(textfield4.frame.origin.x-2, textfield4.frame.origin.y, textfield4.frame.size.width, textfield4.frame.size.height);
            
            doneButton.hidden = YES;
            UIButton * telButton = (UIButton *)[allView viewWithTag:1019];
            telButton.hidden = YES;
            UITextView * textview = (UITextView *)[allView viewWithTag:1199];
            textview.hidden = YES;
            
            if (!zbyzButton) {
                zbyzButton = [UIButton buttonWithType:UIButtonTypeCustom];
                zbyzButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 135, 45);
                [zbyzButton addTarget:self action:@selector(presszbyzButton:) forControlEvents:UIControlEventTouchUpInside];
                [zbyzButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [allView addSubview:zbyzButton];
                [zbyzButton setTitle:@"暂不验证" forState:UIControlStateNormal];
                [zbyzButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                zbyzButton.titleLabel.font = [UIFont systemFontOfSize:18];
            }
            
            if (!zbyzwcButton) {
                zbyzwcButton = [UIButton buttonWithType:UIButtonTypeCustom];
                zbyzwcButton.frame = CGRectMake(ORIGIN_X(zbyzButton) + 20, zbyzButton.frame.origin.y, zbyzButton.frame.size.width, zbyzButton.frame.size.height);
                [zbyzwcButton addTarget:self action:@selector(presszbyzwcButton:) forControlEvents:UIControlEventTouchUpInside];
                [zbyzwcButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [allView addSubview:zbyzwcButton];
                [zbyzwcButton setTitle:@"完   成" forState:UIControlStateNormal];
                [zbyzwcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                zbyzwcButton.titleLabel.font = [UIFont systemFontOfSize:18];
            }
            
            if (!yzOneLabel) {
                yzOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(zbyzButton.frame.origin.x, ORIGIN_Y(zbyzButton) + 25, 294, 20)];
                yzOneLabel.backgroundColor = [UIColor clearColor];
                yzOneLabel.textAlignment = NSTextAlignmentLeft;
                yzOneLabel.font = [UIFont systemFontOfSize:14];
                yzOneLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                yzOneLabel.text = @"如果暂时不想验证手机号码,可随时在";
                [allView addSubview:yzOneLabel];
                [yzOneLabel release];
            }
            if (!yzTwoLabel) {
                yzTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzOneLabel.frame.origin.x, ORIGIN_Y(yzOneLabel) + 10, yzOneLabel.frame.size.width, yzOneLabel.frame.size.height)];
                yzTwoLabel.backgroundColor = [UIColor clearColor];
                yzTwoLabel.textAlignment = NSTextAlignmentLeft;
                yzTwoLabel.font = yzOneLabel.font;
                yzTwoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                yzTwoLabel.text = @"主界面->我的彩票->个人信息";
                [allView addSubview:yzTwoLabel];
                [yzTwoLabel release];
            }
            if (!yzThreeLabel) {
                yzThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzTwoLabel.frame.origin.x, ORIGIN_Y(yzTwoLabel) + 10, yzTwoLabel.frame.size.width, yzTwoLabel.frame.size.height)];
                yzThreeLabel.backgroundColor = [UIColor clearColor];
                yzThreeLabel.textAlignment = NSTextAlignmentLeft;
                yzThreeLabel.font = yzTwoLabel.font;
                yzThreeLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                yzThreeLabel.text = @"中验证,验证后可获取3元彩金。";
                [allView addSubview:yzThreeLabel];
                [yzThreeLabel release];
            }
        }
    }else{
        
        if ([msgstr isEqualToString:@""] || msgstr == nil || [msgstr length] == 0) {
            
        }else{
            CP_UIAlertView * alertview = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
            [alertview release];
        }
        
       
        
    }

}

- (void)presszbyzButton:(UIButton *)sender{//暂不验证
    [MobClick event:@"event_wanshanxinxi_zanbuyanzheng"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)presszbyzwcButton:(UIButton *)sender{//暂不验证 完整
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    panduanzil = YES;
    [self sendBindPhoneRequest];
}

- (void)ysFucn
{
    if ([textfield1.text length] && [textfield2.text length] && [textfield3.text length]) {
        doneButton.enabled = YES;
    }else{
        doneButton.enabled = NO;
    }
}

//- (void)ysFucn1
//{
//    if ([textfield1.text length] && [textfield2.text length] && [textfield3.text length]) {
//        doneButton.enabled = YES;
//    }else{
//        doneButton.enabled = NO;
//    }
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
        [self   performSelector:@selector(ysFucn) withObject:nil afterDelay:0.1];
//    }
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
//        [self performSelector:@selector(ysFucn1) withObject:nil afterDelay:0.1];
//    }
    
    return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
}

- (void)openTimerFire{
    if ([textfield1.text length] == 0 && [textfield2.text length] == 0 && [textfield3.text length] == 0) {
        
        if (duanxinbool) {
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBounds:CGRectMake(0, 0, 70, 40)];
            UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
            imagevi.backgroundColor = [UIColor clearColor];
            imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
            [btn addSubview:imagevi];
            [imagevi release];
            
            UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
            lilable.textColor = [UIColor whiteColor];
            lilable.backgroundColor = [UIColor clearColor];
            lilable.textAlignment = NSTextAlignmentCenter;
            lilable.font = [UIFont boldSystemFontOfSize:14];
            lilable.shadowColor = [UIColor blackColor];//阴影
            lilable.shadowOffset = CGSizeMake(0, 1.0);
            lilable.text = @"完成";
            [btn addSubview:lilable];
            [lilable release];
            [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.CP_navigation.rightBarButtonItem = barBtnItem;
            [barBtnItem release];
            
            
//            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(actionSave:)];
//            [self.CP_navigation setRightBarButtonItem:rightItem];
        }else{
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"跳过" Target:self action:@selector(doBack)];
            [self.CP_navigation setRightBarButtonItem:rightItem];
            
        }
    }
}

- (void) keyboardWillShow:(id)sender
{
    
    if (allView.frame.origin.y == 0) {
        //[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        CGRect keybordFrame;
        [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
        //   CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
        CGRect frame = allView.frame;
        frame.origin.y -=60;
        frame.size.height +=60;
        //  self.mainView.frame = frame;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        allView.frame = frame;
        [UIView commitAnimations];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
    }
    
    
}

- (void)pressYanZhengButton:(UIButton *)sender{
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [MobClick event:@"event_wanshanxinxi_huoquyanzhengma"];
    [self sendGetPassCodeRequest];
    
    
}
- (void) keyboardWillDisapper:(id)sender
{
    if (allView.frame.origin.y != 0) {
        //[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        
        
        
        CGRect frame =allView.frame;
        frame.origin.y +=60;  //216
        frame.size. height -=60;
        // self.mainView.frame = frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        allView.frame = frame;
        [UIView commitAnimations];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    
    
}


- (void)timerWithTime{
    timem -= 1;
    NSLog(@"~~~%d~~~",timem);

    [huoqubut setTitle:[NSString stringWithFormat:@"重新获取%d’", timem] forState:UIControlStateNormal];
    [huoqubut setTitle:[NSString stringWithFormat:@"重新获取%d’", timem] forState:UIControlStateDisabled];

    
    if (timem == 0) {
        timem = 60;
        [timer invalidate];

        [huoqubut setTitle:@"获取验证码" forState:UIControlStateNormal];
        huoqubut.enabled = YES;
    }
    
}

- (void)doBack{
	if ([self.navigationController.viewControllers count]>1) {
		if (!canBack||[[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2] isKindOfClass:[UntionAddNickViewController class]]) {
			[[caiboAppDelegate getAppDelegate] switchToHomeView];
		}
		else {
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
	else {
#ifdef  isCaiPiaoForIPad
        [self doBackforiPad];
#else
        
        [self dismissViewControllerAnimated: YES completion: nil];
#endif
		
	}
}

- (void)doBackforiPad
{
	
    //    [self.navigationController popViewControllerAnimated:YES];
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}


- (void)reqUserInfoFinished:(ASIHTTPRequest *)mrequest{
    NSString *responseStr = [mrequest responseString];
    NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
    NSDictionary * dict = [responseStr JSONValue];
    NSLog(@"resp = %@", dict);
    mobile = [dict objectForKey:@"mobile"];
    self.true_name = [dict objectForKey:@"true_name"];
    self.id_number = [dict objectForKey:@"user_id_card"];
    
    if ([mobile isEqualToString:@"(null)"] || mobile == nil || [mobile length] == 0) {
        mobile = @"";
    }
    if ([true_name isEqualToString:@"(null)"] || true_name == nil || [true_name length] == 0) {
        true_name = @"";
    }
    if ([id_number isEqualToString:@"(null)"] || id_number == nil || [id_number length] == 0) {
        id_number = @"";
    }
    
    if ([true_name length]) {
        [[NSUserDefaults standardUserDefaults] setValue:true_name forKey:@"true_name"];
        
    }
    if ([id_number length]) {
        [[NSUserDefaults standardUserDefaults] setValue:id_number forKey:@"id_number"];
    }
    
/////////第三方登录
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {

        if ([true_name isEqualToString:@""] || [id_number isEqualToString:@""] || [mobile isEqualToString:@""]) {
            textfield1.enabled = YES;
            textfield2.enabled = YES;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
                textfield3.enabled = NO;
                if ([mobile length] >= 11) {
                    NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                    NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                    textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                }
               

            }else{
                textfield3.enabled =YES;
                textfield3.text = mobile;
            }
            
            textfield1.text = true_name;
            textfield2.text = id_number;
           
            panduanzil  = YES;
            
//            doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            doneButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 290, 45);
//            [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
//            [doneButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//            [doneButton setBackgroundImage:[UIImageGetImageFromName(@"WanShanDisabled.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
//            [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//            [allView addSubview:doneButton];
//            [doneButton setTitle:@"完   成" forState:UIControlStateNormal];
//            doneButton.enabled = NO;
            
            UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(doneButton) + 20, 300, 70)];
            textview.tag = 1199;
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield4.enabled = YES;
//                textview.frame = CGRectMake(10, ORIGIN_Y(doneButton) + 20, 300, 70);
                if ([self.navigationController.viewControllers count] == 1) {
                    textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                }
                else {
                    textview.text = @"        请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
                }
                
                
            }else{
//                textview.frame = CGRectMake(10, 198, 300, 70);
                if ([self.navigationController.viewControllers count] == 1) {
                    textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                }
                else {
                    textview.text = @"请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
                }
                
            }
            
            if (canTiaoguo) {
                textview.text = @"请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
            }
            
            
            
            textview.textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
            textview.backgroundColor = [UIColor clearColor];
            textview.font = [UIFont systemFontOfSize:14];
            textview.userInteractionEnabled = NO;
            //        [self.mainView addSubview:textview];
            [allView addSubview:textview];
            [textview release];
            
        }else{
            panduanzil = NO;
            self.CP_navigation.rightBarButtonItem.enabled = NO;
            textfield1.enabled = NO;
            textfield2.enabled = NO;
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield3.enabled = YES;
            }else{
                textfield3.enabled = NO;
            }
            
            NSString * xing = [true_name substringWithRange:NSMakeRange(0, 1)];
            //    NSString * ming = [true_name substringWithRange:NSMakeRange(1, [true_name length]-1)];
            textfield1.text = [NSString stringWithFormat:@"%@**", xing];
            NSString * shenfenqian2 = [id_number substringWithRange:NSMakeRange(0, 2)];
            NSString * shenhou4 = [id_number substringWithRange:NSMakeRange([id_number length] -4, 4)];
            textfield2.text = [NSString stringWithFormat:@"%@************%@", shenfenqian2, shenhou4];
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
               
                if ([mobile length] >= 11) {
                    NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                    NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                    textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                }
                
                
            }else{
                
                textfield3.text = mobile;
            }
            
            UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(40, 198, 280, 70)];
            textview.tag = 1199;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield4.enabled = YES;
                self.CP_navigation.rightBarButtonItem.enabled = YES;

                if (!zbyzButton) {
                    zbyzButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    zbyzButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 135, 45);
                    [zbyzButton addTarget:self action:@selector(presszbyzButton:) forControlEvents:UIControlEventTouchUpInside];
                    [zbyzButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                    [allView addSubview:zbyzButton];
                    [zbyzButton setTitle:@"暂不验证" forState:UIControlStateNormal];
                    [zbyzButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    zbyzButton.titleLabel.font = [UIFont systemFontOfSize:18];
                }
                
                if (!zbyzwcButton) {
                    zbyzwcButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    zbyzwcButton.frame = CGRectMake(ORIGIN_X(zbyzButton) + 20, zbyzButton.frame.origin.y, zbyzButton.frame.size.width, zbyzButton.frame.size.height);
                    [zbyzwcButton addTarget:self action:@selector(presszbyzwcButton:) forControlEvents:UIControlEventTouchUpInside];
                    [zbyzwcButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                    [allView addSubview:zbyzwcButton];
                    [zbyzwcButton setTitle:@"完   成" forState:UIControlStateNormal];
                    [zbyzwcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    zbyzwcButton.titleLabel.font = [UIFont systemFontOfSize:18];
                }
                
                if (!yzOneLabel) {
                    yzOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(zbyzButton.frame.origin.x, ORIGIN_Y(zbyzButton) + 25, 294, 20)];
                    yzOneLabel.backgroundColor = [UIColor clearColor];
                    yzOneLabel.textAlignment = NSTextAlignmentLeft;
                    yzOneLabel.font = [UIFont systemFontOfSize:14];
                    yzOneLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                    yzOneLabel.text = @"如果暂时不想验证手机号码,可随时在";
                    [allView addSubview:yzOneLabel];
                    [yzOneLabel release];
                }
                if (!yzTwoLabel) {
                    yzTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzOneLabel.frame.origin.x, ORIGIN_Y(yzOneLabel) + 10, yzOneLabel.frame.size.width, yzOneLabel.frame.size.height)];
                    yzTwoLabel.backgroundColor = [UIColor clearColor];
                    yzTwoLabel.textAlignment = NSTextAlignmentLeft;
                    yzTwoLabel.font = yzOneLabel.font;
                    yzTwoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    yzTwoLabel.text = @"主界面->我的彩票->个人信息";
                    [allView addSubview:yzTwoLabel];
                    [yzTwoLabel release];
                }
                if (!yzThreeLabel) {
                    yzThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzTwoLabel.frame.origin.x, ORIGIN_Y(yzTwoLabel) + 10, yzTwoLabel.frame.size.width, yzTwoLabel.frame.size.height)];
                    yzThreeLabel.backgroundColor = [UIColor clearColor];
                    yzThreeLabel.textAlignment = NSTextAlignmentLeft;
                    yzThreeLabel.font = yzTwoLabel.font;
                    yzThreeLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                    yzThreeLabel.text = @"中验证,验证后可获取3元彩金。";
                    [allView addSubview:yzThreeLabel];
                    [yzThreeLabel release];
                }
            }
            else{
////第三方已完善
//                textview.frame = CGRectMake(10, ORIGIN_Y(mutableBG) + 20, 300, 24.5);
//                textview.text = @"如要更改此页信息请联系客服";
//                textview.textColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:197/255.0 alpha:1];
//                textview.backgroundColor = [UIColor clearColor];
//                textview.font = [UIFont systemFontOfSize:12];
//                textview.userInteractionEnabled = NO;
//                //        [self.mainView addSubview:textview];
//                [allView addSubview:textview];
//                
//                UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                telButton.tag = 1019;
//                telButton.frame = CGRectMake(15, ORIGIN_Y(textview) + 3, 290, 45);
//                [telButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//                [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
//                [telButton setTitle:@"            QQ：3254056760" forState:UIControlStateNormal];
//                [telButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
//                telButton.titleLabel.font = [UIFont systemFontOfSize:16];
//                telButton.adjustsImageWhenHighlighted = NO;
//                [allView addSubview:telButton];
//                
//                UIImageView * telephone = [[UIImageView alloc] initWithFrame:CGRectMake(75, 12.5, 20, 20)];
//                telephone.image = UIImageGetImageFromName(@"AboutUs_tel.png");
//                telephone.backgroundColor = [UIColor clearColor];
//                [telButton addSubview:telephone];
//                [telephone release];
                
                self.title = @"我的身份信息";
            }
            [textview release];

        }
        return;
    }
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1) {
        textfield1.enabled = YES;
        textfield2.enabled = YES;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
            textfield3.enabled = NO;
            if ([mobile length] >= 11) {
                NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
            }
            
            
        }else{
            textfield3.enabled =YES;
            textfield3.text = mobile;
        }
        
        textfield1.text = true_name;
        textfield2.text = id_number;
     
        panduanzil  = YES;

        if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
            doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            doneButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 290, 45);
            [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
            [doneButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [doneButton setBackgroundImage:[UIImageGetImageFromName(@"WanShanDisabled.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
            [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            [allView addSubview:doneButton];
            [doneButton setTitle:@"完   成" forState:UIControlStateNormal];
            doneButton.enabled = NO;
        }
        
        UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(doneButton) + 20, 300, 70)];
        textview.tag = 1199;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            textfield4.enabled = YES;
            if ([self.navigationController.viewControllers count] == 1) {
                textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
            }
            else {
/////365注册未绑定
                textview.text = @"        请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
            }
            
            
        }else{
            if ([self.navigationController.viewControllers count] == 1) {
                textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
            }
            else {
                textview.text = @"        请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
            }
        }
        
        if (canTiaoguo) {
            textview.text = @"请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
        }
        
        
        
        textview.textColor =  [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
        textview.backgroundColor = [UIColor clearColor];
        textview.font = [UIFont systemFontOfSize:14];
        textview.userInteractionEnabled = NO;
        //        [self.mainView addSubview:textview];
        [allView addSubview:textview];
        [textview release];
        
        UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
        telButton.tag = 1019;
        telButton.frame = CGRectMake(15, ORIGIN_Y(textview) + 5, 290, 45);
        [telButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
        [telButton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
        [telButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        telButton.titleLabel.font = [UIFont systemFontOfSize:16];
        telButton.adjustsImageWhenHighlighted = NO;
        [allView addSubview:telButton];

        
        if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            telButton.hidden = YES;
        }
        
    }else{
        panduanzil = NO;
        self.CP_navigation.rightBarButtonItem.enabled = NO;
        textfield1.enabled = NO;
        textfield2.enabled = NO;
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            textfield3.enabled = YES;
        }else{
            textfield3.enabled = NO;
        }
        
        
         NSString * xing = @"";
        if ([true_name length] > 1) {
           xing = [true_name substringWithRange:NSMakeRange(0, 1)];
        }
       
        //    NSString * ming = [true_name substringWithRange:NSMakeRange(1, [true_name length]-1)];
        textfield1.text = [NSString stringWithFormat:@"%@**", xing];
         NSString * shenfenqian2 = @"";
        NSString * shenhou4 = @"";
        if ([id_number length] > 4) {
            shenfenqian2 = [id_number substringWithRange:NSMakeRange(0, 2)];
            shenhou4 = [id_number substringWithRange:NSMakeRange([id_number length] -4, 4)];
        }
       
        textfield2.text = [NSString stringWithFormat:@"%@************%@", shenfenqian2, shenhou4];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
           
            if ([mobile length] >= 11) {
                NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
            }
            
            
        }else{
           
            textfield3.text = mobile;
        }
        
        UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(40, 198, 280, 70)];
        textview.tag = 1199;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            textfield4.enabled = YES;

            self.CP_navigation.rightBarButtonItem.enabled = YES;
            textview.frame = CGRectMake(10, ORIGIN_Y(mutableBG) + 20, 300, 70);
            textview.text = @"如要更改此页信息,请联系客服.\n验证码会在1分钟左右短信发送到您的手机请耐心等待.";
            
            textfield4.enabled = YES;
            
/////365个人信息
            if (!zbyzButton) {
                zbyzButton = [UIButton buttonWithType:UIButtonTypeCustom];
                zbyzButton.frame = CGRectMake(15, ORIGIN_Y(mutableBG) + 25, 135, 45);
                [zbyzButton addTarget:self action:@selector(presszbyzButton:) forControlEvents:UIControlEventTouchUpInside];
                [zbyzButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [allView addSubview:zbyzButton];
                [zbyzButton setTitle:@"暂不验证" forState:UIControlStateNormal];
                [zbyzButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                zbyzButton.titleLabel.font = [UIFont systemFontOfSize:18];
            }
            
            if (!zbyzwcButton) {
                zbyzwcButton = [UIButton buttonWithType:UIButtonTypeCustom];
                zbyzwcButton.frame = CGRectMake(ORIGIN_X(zbyzButton) + 20, zbyzButton.frame.origin.y, zbyzButton.frame.size.width, zbyzButton.frame.size.height);
                [zbyzwcButton addTarget:self action:@selector(presszbyzwcButton:) forControlEvents:UIControlEventTouchUpInside];
                [zbyzwcButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [allView addSubview:zbyzwcButton];
                [zbyzwcButton setTitle:@"完   成" forState:UIControlStateNormal];
                [zbyzwcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                zbyzwcButton.titleLabel.font = [UIFont systemFontOfSize:18];
            }

            
            if (!yzOneLabel) {
                yzOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(zbyzButton.frame.origin.x, ORIGIN_Y(zbyzButton) + 25, 294, 20)];
                yzOneLabel.backgroundColor = [UIColor clearColor];
                yzOneLabel.textAlignment = NSTextAlignmentLeft;
                yzOneLabel.font = [UIFont systemFontOfSize:14];
                yzOneLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                yzOneLabel.text = @"如果暂时不想验证手机号码,可随时在";
                [allView addSubview:yzOneLabel];
                [yzOneLabel release];
            }
            if (!yzTwoLabel) {
                yzTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzOneLabel.frame.origin.x, ORIGIN_Y(yzOneLabel) + 10, yzOneLabel.frame.size.width, yzOneLabel.frame.size.height)];
                yzTwoLabel.backgroundColor = [UIColor clearColor];
                yzTwoLabel.textAlignment = NSTextAlignmentLeft;
                yzTwoLabel.font = yzOneLabel.font;
                yzTwoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                yzTwoLabel.text = @"主界面->我的彩票->个人信息";
                [allView addSubview:yzTwoLabel];
                [yzTwoLabel release];
            }
            if (!yzThreeLabel) {
                yzThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(yzTwoLabel.frame.origin.x, ORIGIN_Y(yzTwoLabel) + 10, yzTwoLabel.frame.size.width, yzTwoLabel.frame.size.height)];
                yzThreeLabel.backgroundColor = [UIColor clearColor];
                yzThreeLabel.textAlignment = NSTextAlignmentLeft;
                yzThreeLabel.font = yzTwoLabel.font;
                yzThreeLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                yzThreeLabel.text = @"中验证,验证后可获取3元彩金。";
                if ([[[Info getInstance] caijin] intValue] == 0) {
                    yzThreeLabel.text = @"中验证。";
                }
                else {
                    yzThreeLabel.text = [NSString stringWithFormat:@"中验证,验证后可获取%@元彩金。",[[Info getInstance] caijin]];
                }
                [allView addSubview:yzThreeLabel];
                [yzThreeLabel release];
            }


        }else{
 //////365已完善
            textview.frame = CGRectMake(10, ORIGIN_Y(mutableBG) + 20, 300, 24.5);
            textview.text = @"如要更改此页信息请联系客服";
            textview.textColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:197/255.0 alpha:1];
            textview.backgroundColor = [UIColor clearColor];
            textview.font = [UIFont systemFontOfSize:12];
            textview.userInteractionEnabled = NO;
            //        [self.mainView addSubview:textview];
            [allView addSubview:textview];
            
            UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
            telButton.tag = 1019;
            telButton.frame = CGRectMake(15, ORIGIN_Y(textview) + 3, 290, 45);
            [telButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
            [telButton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
            [telButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            telButton.titleLabel.font = [UIFont systemFontOfSize:16];
            telButton.adjustsImageWhenHighlighted = NO;
            [allView addSubview:telButton];

            
            self.title = @"我的身份信息";
        }
        [textview release];

        

                NSLog(@"~%@~%@~",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"],[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"]);
//        if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
//            telButton.hidden = YES;
//            
//            
//        }

    }
    
    

}

- (void)reqUserInfoFinished2:(ASIHTTPRequest *)mrequest{

        NSString *responseStr = [mrequest responseString];
        NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
        NSDictionary * dict = [responseStr JSONValue];
        NSLog(@"resp = %@", dict);
        mobile = [dict objectForKey:@"mobile"];
        true_name = [dict objectForKey:@"true_name"];
        id_number = [dict objectForKey:@"user_id_card"];
        
        if ([mobile isEqualToString:@"(null)"] || mobile == nil || [mobile length] == 0) {
            mobile = @"";
        }
        if ([true_name isEqualToString:@"(null)"] || true_name == nil || [true_name length] == 0) {
            true_name = @"";
        }
        if ([id_number isEqualToString:@"(null)"] || id_number == nil || [id_number length] == 0) {
            id_number = @"";
        }
        
        if ([true_name length]) {
            [[NSUserDefaults standardUserDefaults] setValue:true_name forKey:@"true_name"];
            
        }
        if ([id_number length]) {
            [[NSUserDefaults standardUserDefaults] setValue:id_number forKey:@"id_number"];
        }
        
        if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {
            if ([true_name isEqualToString:@""] || [id_number isEqualToString:@""] || [mobile isEqualToString:@""]) {
                NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
                textfield1.enabled = YES;
                textfield2.enabled = YES;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
                    textfield3.enabled = NO;
                }else{
                    textfield3.enabled =YES;
                }
                
                textfield1.text = true_name;
                textfield2.text = id_number;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
                    
                    if ([mobile length] >= 11) {
                        NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                        NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                        textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                    }
                    
                    
                }else{
                    
                    textfield3.text = mobile;
                }
                panduanzil  = YES;
                UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(135, 233, 280, 90)];
                textview.tag = 1199;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                    textfield4.enabled = YES;
                    textview.frame = CGRectMake(135, 277, 280, 90);
                    if ([self.navigationController.viewControllers count] == 1) {
                        textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                    }
                    else {
                        textview.text = @"请您认真填写此页全部内容,提交成功后,不可更改.如果想更改请联系客服.";
                    }
                    
                    
                }else{
                    textview.frame = CGRectMake(135, 233, 280, 90);
                    if ([self.navigationController.viewControllers count] == 1) {
                        textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                    }
                    else {
                        textview.text = @"请您认真填写此页全部内容,提交成功后,不可更改.如果想更改请联系客服.";
                    }
                    
                }
                
                if (canTiaoguo) {
                    textview.text = @"请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
                }
                
                
                
                textview.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
                textview.backgroundColor = [UIColor clearColor];
                textview.font = [UIFont systemFontOfSize:12];
                textview.userInteractionEnabled = NO;
                //        [self.mainView addSubview:textview];
                [allView addSubview:textview];
                [textview release];
                
                UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
                telButton.tag = 1019;
                telButton.frame = CGRectMake(135, textview.frame.origin.y+ textview.frame.size.height+25, 294, 36);
                [telButton setImage:UIImageGetImageFromName(@"set-shenfenbutton.png") forState:UIControlStateNormal];
                [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
                
//                UIImageView * telephone = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 26, 15)];
//                telephone.image = UIImageGetImageFromName(@"about-tel.png");
//                telephone.backgroundColor = [UIColor clearColor];
//                [telButton addSubview:telephone];
//                [telephone release];
                
                
                UILabel * phonenumeber = [[UILabel alloc] initWithFrame:CGRectMake(31, 11, 200, 15)];
                phonenumeber.backgroundColor = [UIColor clearColor];
                phonenumeber.textAlignment = NSTextAlignmentCenter;
                phonenumeber.text = @"QQ：3254056760";
                phonenumeber.font = [UIFont systemFontOfSize:13];
                [telButton addSubview:phonenumeber];
                [phonenumeber release];
                
                [allView addSubview:telButton];
                
            }else{
                panduanzil = NO;
                self.CP_navigation.rightBarButtonItem.enabled = NO;
                textfield1.enabled = NO;
                textfield2.enabled = NO;
                
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                    textfield3.enabled = YES;
                }else{
                    textfield3.enabled = NO;
                }
                
                NSString * xing = [true_name substringWithRange:NSMakeRange(0, 1)];
                //    NSString * ming = [true_name substringWithRange:NSMakeRange(1, [true_name length]-1)];
                textfield1.text = [NSString stringWithFormat:@"%@**", xing];
                NSString * shenfenqian2 = [id_number substringWithRange:NSMakeRange(0, 2)];
                NSString * shenhou4 = [id_number substringWithRange:NSMakeRange([id_number length] -4, 4)];
                textfield2.text = [NSString stringWithFormat:@"%@************%@", shenfenqian2, shenhou4];
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
                   
                    if ([mobile length] >= 11) {
                        NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                        NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                        textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                    }
                    
                    
                }else{
                   
                    textfield3.text = mobile;
                }
                
                UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(135, 233, 280, 90)];
                textview.tag = 1199;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                    textfield4.enabled = YES;
                    self.CP_navigation.rightBarButtonItem.enabled = YES;
                    textview.frame = CGRectMake(135, 277, 280, 90);
                    textview.text = @"如要更改此页信息,请联系客服.\n验证码会在1分钟左右短信发送到您的手机请耐心等待.";
                }else{
                    textview.frame = CGRectMake(135, 233, 280, 90);
                    textview.text = @"如要更改此页信息,请联系客服.";
                }
                
                
                textview.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
                textview.backgroundColor = [UIColor clearColor];
                textview.font = [UIFont systemFontOfSize:12];
                textview.userInteractionEnabled = NO;
                //        [self.mainView addSubview:textview];
                [allView addSubview:textview];
                [textview release];
                UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
                telButton.tag = 1019;
                telButton.frame = CGRectMake(135, textview.frame.origin.y+ textview.frame.size.height+5, 294, 36);
                [telButton setImage:UIImageGetImageFromName(@"set-shenfenbutton.png") forState:UIControlStateNormal];
                [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
                
//                UIImageView * telephone = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 26, 15)];
//                telephone.image = UIImageGetImageFromName(@"about-tel.png");
//                telephone.backgroundColor = [UIColor clearColor];
//                [telButton addSubview:telephone];
//                [telephone release];
                
                
                UILabel * phonenumeber = [[UILabel alloc] initWithFrame:CGRectMake(31, 11, 200, 15)];
                phonenumeber.backgroundColor = [UIColor clearColor];
                phonenumeber.textAlignment = NSTextAlignmentCenter;
                phonenumeber.text = @"QQ：3254056760";
                phonenumeber.font = [UIFont systemFontOfSize:13];
                [telButton addSubview:phonenumeber];
                [phonenumeber release];
                
                [allView addSubview:telButton];
            }
            return;
        }
        
        
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1) {
            NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
            textfield1.enabled = YES;
            textfield2.enabled = YES;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
                textfield3.enabled = NO;
                if ([mobile length] >= 11) {
                    NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                    NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                    textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                }
                
                
            }else{
                textfield3.enabled =YES;
                textfield3.text = mobile;
            }
            
            textfield1.text = true_name;
            textfield2.text = id_number;
           
            panduanzil  = YES;
            UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(135, 273, 280, 70)];
            textview.tag = 1199;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield4.enabled = YES;
                textview.frame = CGRectMake(135, 273, 280, 70);
                if ([self.navigationController.viewControllers count] == 1) {
                    textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                }
                else {
                    textview.text = @"请您认真填写此页全部内容,提交成功后,不可更改.如果想更改请联系客服.";
                }
                
                
            }else{
                textview.frame = CGRectMake(135, 273, 280, 70);
                if ([self.navigationController.viewControllers count] == 1) {
                    textview.text = @"提示:为了保障您中奖后的利益，请您完善领奖资料.";
                }
                else {
                    textview.text = @"请您认真填写此页全部内容,提交成功后,不可更改.如果想更改请联系客服.";
                }
                
            }
            
            if (canTiaoguo) {
                textview.text = @"请您认真填写此页全部内容,提交成功后,真实姓名、身份证号码不可更改。更改请联系客服。";
            }
            
            
            
            textview.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
            textview.backgroundColor = [UIColor clearColor];
            textview.font = [UIFont systemFontOfSize:12];
            textview.userInteractionEnabled = NO;
            //        [self.mainView addSubview:textview];
            [allView addSubview:textview];
            [textview release];
            UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
            telButton.tag = 1019;
            telButton.frame = CGRectMake(135, textview.frame.origin.y+ textview.frame.size.height+5, 297, 34);
            
            UIImageView *telephone31 = [[UIImageView alloc] initWithFrame:telButton.bounds];
            telephone31.image = UIImageGetImageFromName(@"set-shenfenbutton.png");
            telephone31.backgroundColor = [UIColor clearColor];
            [telButton addSubview:telephone31];
            [telephone31 release];
            //        [telButton setImage:UIImageGetImageFromName(@"set-shenfenbutton.png") forState:UIControlStateNormal];
            //        [telButton setImage:UIImageGetImageFromName(@"set-shenfenbutton-01") forState:UIControlStateHighlighted];
            [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIImageView *telephone = [[UIImageView alloc] initWithFrame:CGRectMake(17, 5, 22, 22)];
//            telephone.image = UIImageGetImageFromName(@"about-tel.png");
//            telephone.backgroundColor = [UIColor clearColor];
//            [telButton addSubview:telephone];
//            [telephone release];
            
            
            UILabel *phonenumeber = [[UILabel alloc] initWithFrame:CGRectMake(31, 11, 200, 15)];
            phonenumeber.backgroundColor = [UIColor clearColor];
            phonenumeber.textAlignment = NSTextAlignmentCenter;
            phonenumeber.text = @"QQ：3254056760";
            phonenumeber.font = [UIFont systemFontOfSize:13];
            [telButton addSubview:phonenumeber];
            [phonenumeber release];
            
            [allView addSubview:telButton];
            telButton.enabled = NO;
            
            
        }
        else{
            panduanzil = NO;
            self.CP_navigation.rightBarButtonItem.enabled = NO;
            textfield1.enabled = NO;
            textfield2.enabled = NO;
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield3.enabled = YES;
            }else{
                textfield3.enabled = NO;
            }
            
            //用＊号替换真实姓名等信息
            NSString * xing = @"";
            if ([true_name length] > 1) {
                xing = [true_name substringWithRange:NSMakeRange(0, 1)];
            }
            
            //    NSString * ming = [true_name substringWithRange:NSMakeRange(1, [true_name length]-1)];
            textfield1.text = [NSString stringWithFormat:@"%@**", xing];
            NSString * shenfenqian2 = @"";
            NSString * shenhou4 = @"";
            if ([id_number length] > 4) {
                shenfenqian2 = [id_number substringWithRange:NSMakeRange(0, 2)];
                shenhou4 = [id_number substringWithRange:NSMakeRange([id_number length] -4, 4)];
            }
            
            textfield2.text = [NSString stringWithFormat:@"%@************%@", shenfenqian2, shenhou4];
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"1"]) {
               
                if ([mobile length] >= 11) {
                    NSString * str1 = [mobile substringWithRange:NSMakeRange(0, 3)];
                    NSString * str2 = [mobile substringWithRange:NSMakeRange([mobile length] -4, 4)];
                    textfield3.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
                }
                
                
            }else{
               
                textfield3.text = mobile;
            }
            
            UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(135, 275, 280, 70)];
            textview.tag = 1199;
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
                textfield4.enabled = YES;
                self.CP_navigation.rightBarButtonItem.enabled = YES;
                textview.frame = CGRectMake(135, 275, 280, 70);
                textview.text = @"如要更改此页信息,请联系客服.\n验证码会在1分钟左右短信发送到您的手机请耐心等待.";
            }else{
                textview.frame = CGRectMake(135, 275, 280, 70);
                textview.text = @"如要更改此页信息,请联系客服.";
            }
            
            
            textview.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
            textview.backgroundColor = [UIColor clearColor];
            textview.font = [UIFont systemFontOfSize:12];
            textview.userInteractionEnabled = NO;
            //        [self.mainView addSubview:textview];
            [allView addSubview:textview];
            [textview release];
            
            UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
            telButton.frame = CGRectMake(135, textview.frame.origin.y+ textview.frame.size.height+5, 294, 36);
            telButton.enabled = NO;
            
            UIImageView *telephone3 = [[UIImageView alloc] initWithFrame:telButton.bounds];
            telephone3.image = UIImageGetImageFromName(@"set-shenfenbutton.png");
            telephone3.backgroundColor = [UIColor clearColor];
            [telButton addSubview:telephone3];
            [telephone3 release];
            
            [telButton addTarget:self action:@selector(pressTelButton:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIImageView *telephone = [[UIImageView alloc] initWithFrame:CGRectMake(17, 5, 22, 22)];
//            telephone.image = UIImageGetImageFromName(@"about-tel.png");
//            telephone.backgroundColor = [UIColor clearColor];
//            [telButton addSubview:telephone];
//            [telephone release];
            
            
            UILabel *phonenumeber = [[UILabel alloc] initWithFrame:CGRectMake(31, 11, 200, 15)];
            phonenumeber.backgroundColor = [UIColor clearColor];
            phonenumeber.textAlignment = NSTextAlignmentCenter;
            phonenumeber.text = @"QQ：3254056760";
            phonenumeber.font = [UIFont systemFontOfSize:13];
            [telButton addSubview:phonenumeber];
            [phonenumeber release];
            //        UIImageView *hou1 = [[UIImageView alloc] initWithFrame:CGRectMake(274, 10, 9, 14)];
            //        hou1.image = UIImageGetImageFromName(@"login_arr.png");
            //        [telButton addSubview:hou1];
            //        [hou1 release];
            [allView addSubview:telButton];
        }
        
    
}

- (void)pressTelButton:(UIButton *)sender{
    
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.mainView];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
//    }
//    [actionSheet release];
}
#pragma mark actionSheet 回调函数
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
    }
}
- (void)userInfoRequestFunc{
    NSLog(@"url = %@",[[Info getInstance] userId]);
    //5.1 设定用户实名信息
    NSLog(@"asdfsadfsadfasdfsafasdf = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
    
    
    self.CP_navigation.rightBarButtonItem.enabled = NO;
    
    [requst clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] wanShanUseridcard:textfield2.text userid:[[Info getInstance] userId]  trueName:textfield1.text mobile:textfield3.text];
    self.requst = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [requst setRequestMethod:@"POST"];
    [requst addCommHeaders];
    [requst setPostBody:postData];
    [requst setDefaultResponseEncoding:NSUTF8StringEncoding];
    [requst setDelegate:self];
    [requst setDidFinishSelector:@selector(UserInfoFinished:)];
    [requst setDidFailSelector:@selector(requestFailed:)];
    [requst startAsynchronous];
}

- (void)geRenZiLiao{
    
    NSLog(@"bool = %d  bangding = %d", newBool, [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 0);
    
    
    if([textfield2.text rangeOfString:@" "].location != NSNotFound){
        
        textfield2.text = [textfield2.text stringByReplacingOccurrencesOfRegex:@" " withString:@""];
        
    }
    if([textfield3.text rangeOfString:@" "].location != NSNotFound){
        
        textfield3.text = [textfield3.text stringByReplacingOccurrencesOfRegex:@" " withString:@""];
        
    }
    
    if (newBool|| [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 0) {
        NSString * str = @"";
        if(![textfield3.text isAllNumber] || [textfield3.text length] != 11||![textfield3.text isPhoneNumber]){
            str = @"手机号格式不合法.";
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
            [aler release];
            return;
        }
        
        
        [self userInfoRequestFunc];
        
    }else{
//        if ([self verifyFunc] == NO) {
//            return;
//        }
        NSString * str = @"";
        if(![textfield3.text isAllNumber] || [textfield3.text length] != 11||![textfield3.text isPhoneNumber]){
            str = @"手机号格式不合法.";
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
            [aler release];
            return;
        }
        
//        textfield1.text = true_name;
//        textfield2.text = id_number;
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"请确认以下信息:" message:[NSString stringWithFormat:@"用户名:%@\n真实姓名:%@\n身份证号:%@\n手机号码:%@", [[Info getInstance] nickName], true_name, id_number, textfield3.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aler.tag = 119;
        [aler show];
        [aler release];
    }
    
    
    
    
}
#pragma mark - 完成方法
//完成方法
- (void)actionSave:(UIButton *)sender{
    if (self.CP_navigation.rightBarButtonItem.enabled == NO) {
        return;
    }

    
    if (canBack) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
            
            [self sendBindPhoneRequest];//发送
            
            
        }else{
            
            [self geRenZiLiao];
            
        }
    }else{
        [self geRenZiLiao];
    }
    
    
    
    
    
}



#pragma mark - alertViewdelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            NSLog(@"a1111111111111");//[[User getLastUser] user_id]
            
            [self userInfoRequestFunc];
        }
        
    }
    if (alertView.tag == 209) {
        if (buttonIndex == 1) {
            self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL getUserInfoCard:textfield2.text userId:[[Info getInstance] userId] trueName:textfield1.text mobile:textfield3.text]];
            [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
            [reqUserInfo setDidFinishSelector:@selector(reqUserwsFinished:)];
            [reqUserInfo setDelegate:self];
            [reqUserInfo startAsynchronous];
        }
    }
    if (alertView.tag == 10) {
        if (duanxinbool) {
            DuanXinViewController *dx = [[DuanXinViewController alloc] init];
            [self.navigationController pushViewController:dx animated:YES];
            [dx release];
            return;
        }
        
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] switchToHomeView];
#else
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] -2] isKindOfClass:[GC_ZhuCeChengGongViewCotroller class]]) {
            [[caiboAppDelegate getAppDelegate] switchToHomeView];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
#endif
        
        
        
    }
    if (alertView.tag == 104) {
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] -2] isKindOfClass:[GC_ZhuCeChengGongViewCotroller class]]) {
            [[caiboAppDelegate getAppDelegate] switchToHomeView];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag == 117) {
        if ([bangchengg isEqualToString:@"0"]) {
            if (panduanzil) {

                [self geRenZiLiao];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }

    }
    if (alertView.tag == 118) {
        if ([bangchengg isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    }
    if (alertView.tag == 333) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - 奖金请求返回函数
- (void)UserInfoFinished:(ASIHTTPRequest *)mrequest{
    self.CP_navigation.rightBarButtonItem.enabled = YES;
    
    
    if ([mrequest responseData]) {
        
        //        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        SongCaiJin * song = [[SongCaiJin alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        
        if (song.sysid == 3000) {
            [song release];
            return;
        }
        

       
        NSString * msg = song.msg;
        
        if ([song.succeed intValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"authentication"];
            UserInfo *user = [[Info getInstance] mUserInfo];
            user.authentication = @"0";
            if ([textfield1.text length]) {
                [[NSUserDefaults standardUserDefaults] setValue:textfield1.text forKey:@"true_name"];
                
            }
            if ([textfield2.text length]) {
                [[NSUserDefaults standardUserDefaults] setValue:textfield2.text forKey:@"id_number"];
            }
            msg = @"资料已完善";
        }
        
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        aler.tag = 10;
        [aler show];
        [aler release];
        [song release];
    }
}



-(void)textFieldDidEndEditing:(UITextField *)textField{
	if (canTiaoguo) {
		if ([textfield1.text length] ||[textfield2.text length] ||[textfield3.text length]) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBounds:CGRectMake(0, 0, 70, 40)];
            UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
            imagevi.backgroundColor = [UIColor clearColor];
            imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
            [btn addSubview:imagevi];
            [imagevi release];
            
            UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
            lilable.textColor = [UIColor whiteColor];
            lilable.backgroundColor = [UIColor clearColor];
            lilable.textAlignment = NSTextAlignmentCenter;
            lilable.font = [UIFont boldSystemFontOfSize:14];
            lilable.shadowColor = [UIColor blackColor];//阴影
            lilable.shadowOffset = CGSizeMake(0, 1.0);
            lilable.text = @"完成";
            [btn addSubview:lilable];
            [lilable release];
            [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.CP_navigation.rightBarButtonItem = barBtnItem;
            [barBtnItem release];
//			UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(actionSave:)];
//			[self.CP_navigation setRightBarButtonItem:rightItem];
		}
		else {
			UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"跳过" Target:self action:@selector(doBack)];
			[self.CP_navigation setRightBarButtonItem:rightItem];
		}
        
	}
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
        [self   performSelector:@selector(ysFucn) withObject:nil afterDelay:0.1];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
#pragma mark - 获取验证码

// 获取验证码
- (void)sendGetPassCodeRequest
{
    
    
    
    NSString *nickName = [[Info getInstance] nickName];
    NSLog(@"nick name = %@", nickName);
    NSString *phoneNum = textfield3.text;
    
    // 校验输入的手机号码
    BOOL isPass = YES;
    NSString *message;
    if ([phoneNum length] == 0)
    {
        isPass = NO;
        message = @"手机号码不能为空";
    }
    else if([phoneNum length] == 11)
    {
        NSString *regexPhoneNum = @"^[0-9]*$";
        isPass = [phoneNum isMatchedByRegex:regexPhoneNum] ? YES : NO;
        message = @"手机号码格式不正确";
    }
    else
    {
        isPass = NO;
        message = @"手机号码长度不正确";
    }
    
    if (!isPass)
    {
        [Info showCancelDialog:(@"提示") :(message) :(self)];
    }
    else
    {
        
        huoqubut.enabled = NO;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWithTime) userInfo:nil repeats:YES];
        [timer fire];
        
        [reqUserInfo clearDelegatesAndCancel];
        NSLog(@"textfield3 = %@", textfield3.text);
        self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CbgetPassCode:(phoneNum) NickName:(nickName)]];
        [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqUserInfo setDidFinishSelector:@selector(reqGetPassCode:)];
        [reqUserInfo setDelegate:self];
        [reqUserInfo startAsynchronous];
    }
}
#pragma mark - 发送验证码
// 发送验证码
- (void)sendBindPhoneRequest
{
    NSString *nickName = [[Info getInstance] nickName];
    NSString *passCode = textfield4.text;
    
    if([passCode rangeOfString:@" "].location != NSNotFound){
    
        passCode = [passCode stringByReplacingOccurrencesOfRegex:@" " withString:@""];
    }
    
    
    // 校验输入的验证码
    BOOL isPass = YES;
    NSString *message;
    if ([passCode length] == 0)
    {
        isPass = NO;
        message = @"验证码不能为空";
    }
    else if([passCode length] >=4 )
    {
        NSString *regexPassCode = @"^[0-9]*$";
        isPass = [passCode isMatchedByRegex:regexPassCode];
        message = @"验证码格式不正确";
    }
    else
    {
        isPass = NO;
        message = @"验证码长度不正确";
    }
    
    
    if ([textfield5.text length] == 0) {
        isPass = NO;
        message = @"验证码不能为空";
    }
    
    if ([textfield5.text length] > 0 && [textfield5.text length] != 4) {
        isPass = NO;
        message = @"验证码格式不正确";
    }
    
    if (!isPass)
    {
        [Info showCancelDialog:(@"提示") :(message) :(self)];
    }
    else
    {
        
        
        self.CP_navigation.rightBarButtonItem.enabled = NO;
        
        [reqUserInfo clearDelegatesAndCancel];
        self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CbbindPhone:(nickName) PassCode:(passCode) verify:textfield5.text]];
        [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqUserInfo setDidFinishSelector:@selector(requestFinished:)];
        [reqUserInfo setDidFailSelector:@selector(requestFailed:)];
        [reqUserInfo setDelegate:self];
        [reqUserInfo startAsynchronous];
        
    }
}
- (void)requestFailed:(ASIHTTPRequest *)mrequest{
    self.CP_navigation.rightBarButtonItem.enabled = YES;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    self.CP_navigation.rightBarButtonItem.enabled = YES;
    NSString *responseStr = [request responseString];
    //NSLog(@"responseStr = %@", responseStr);
    if ([responseStr isEqualToString:@"fail"])
    {
        [Info showCancelDialog:(@"提示") :(@"网络有问题，请重试") :(self)];
    }
    else
    {
        SBJSON *jsonParse = [[SBJSON alloc]init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if(dic)
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"0"])
            {
                
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isbindmobile"];
                bangchengg = @"0";
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Captcha"];
            }
            NSString *msg = [dic valueForKey:@"msg"];
            if (msg)
            {
                int nsuer = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] intValue];
                if (nsuer == 0) {
                    //  if ([result isEqualToString:@"0"]) {
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    aler.tag = 118;
                    [aler show];
                    [aler release];
                    //                    }else{
                    //
                    //                        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    //                        aler.tag = 117;
                    //                        [aler show];
                    //                        [aler release];
                    //                    }
                    
                }else{
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    aler.tag = 117;
                    [aler show];
                    [aler release];
                    panduanzil = YES;
                    
                }
                
                //                if ([result isEqualToString:@"0"]) {
                //                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                //                    aler.tag = 118;
                //                    [aler show];
                //                    [aler release];
                //                }else{
                //
                //
                //                }
                
                
            }
            
            
        }
        [jsonParse release];
    }
}


- (void)reqGetPassCode:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    NSLog(@"responsestr = %@", responseStr);
    
    
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒" message:@"注意接听电话" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
    //    NSLog(@"2.62 获取手机验证码 %@", responseStr);
    if ([responseStr isEqualToString:@"fail"])
    {
        [Info showCancelDialog:(@"提示") :(responseStr) :(self)];
    }
    else
    {
        SBJSON *jsonParse = [[SBJSON alloc]init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if ([[dic valueForKey:@"result"] isEqualToString:@"0"]) {
            huoqubut.enabled = NO;
            //  [huoqubut setImage:UIImageGetImageFromName(@"gc_yanz_0.png") forState:UIControlStateNormal];

        }else{
            huoqubut.enabled = YES;
            
            [timer invalidate];
            
            [huoqubut setTitle:@"获取验证码" forState:UIControlStateNormal];

        }
        if(dic)
        {
            
            
            NSString *msg = [dic valueForKey:@"msg"];
            if (msg)
            {
                [Info showDialogWithTitle:@"提示" BtnTitle:@"确定" Msg:msg :self];
            }
        }
        [jsonParse release];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [timer invalidate];
    self.timer = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}
- (void)dealloc{
    [allView release];
    [imageRequest clearDelegatesAndCancel];
    [imageRequest release];
//    [yanzhengLab release];
    [requst clearDelegatesAndCancel];
    [requst release];
    [reqUserInfo clearDelegatesAndCancel];
    [reqUserInfo release];
    [textfield1 release];
    [textfield2 release];
    [textfield3 release];
    [textfield4 release];
    [mutableBG release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GotCaptcha" object:nil];
    [bottomLine release];
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
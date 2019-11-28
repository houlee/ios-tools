    //
//  SinaBindViewController.m
//  caibo
//
//  Created by yao on 12-3-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "SinaBindViewController.h"
#import "Info.h"
#import "AddNick_NameViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "caiboAppDelegate.h"
#import "UserInfo.h"
#import "GC_HttpService.h"
#import "NetURL.h"
#import "IpadRootViewController.h"

#define CFkeyWord @"dsaw3czgu2ljkdm128cd"

@implementation SinaBindViewController


@synthesize sinaURL;
@synthesize isBangDing;
@synthesize unNitionLoginType;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (id)init {
	self = [super init];
	if (self) {
		isBangDing = NO;
	}
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)LoadiPhoneView {

    myWebView = [[UIWebView alloc] initWithFrame:self.mainView.bounds];
	[self.mainView addSubview:myWebView];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doCanCel)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
	myWebView.delegate = self;
	[myWebView loadRequest:[NSURLRequest requestWithURL:self.sinaURL]];
	UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	loading.center = myWebView.center;
	[myWebView addSubview:loading];
	loading.tag = 1001;
	[loading startAnimating];
	[loading release];
	[myWebView release];
    
}

- (void)LoadiPadView {

    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 540, 620)];
	[self.mainView addSubview:myWebView];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doCanCel)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
	myWebView.delegate = self;
	[myWebView loadRequest:[NSURLRequest requestWithURL:self.sinaURL]];
	UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	loading.center = myWebView.center;
	[myWebView addSubview:loading];
	loading.tag = 1001;
	[loading startAnimating];
	[loading release];
	[myWebView release];
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif

    
}

- (void)doCanCel {
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
	UIActivityIndicatorView *loading = (UIActivityIndicatorView *)[webView viewWithTag:1001];
	[loading startAnimating];
}

//md5加密
+(NSString *)EncryptWithMD5:(NSString*)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	str =[NSString stringWithFormat:
		  @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
		  result[0], result[1], result[2], result[3], 
		  result[4], result[5], result[6], result[7],
		  result[8], result[9], result[10], result[11],
		  result[12], result[13], result[14], result[15]
		  ]; 
	str = [str lowercaseString];
    return str;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSString *myulr = [NSString stringWithFormat:@"%@",[webView.request URL]];
	if ([myulr hasPrefix:IP_URL]||[myulr hasPrefix:@"http://cpapi.diyicai.com/"]) {
		NSRange rang= [myulr rangeOfString:@"?"];
		NSLog(@"myulr= %@",myulr);
		myulr = [myulr substringFromIndex:rang.location + rang.length];
		myulr = [myulr stringByReplacingOccurrencesOfString:@"&" withString:@"="];
		NSArray *array = [myulr componentsSeparatedByString:@"="];
		NSMutableDictionary *dic= [NSMutableDictionary dictionary];
		if ([array count]%2 == 0) {
			for (int i =0; i<[array count]-1; i = i+2) {
				[dic setValue:[array objectAtIndex:i+1] forKey:[array objectAtIndex:i]];
			}
		}
		[self performSelector:@selector(goNext:) withObject:dic afterDelay:0.5];
	}
	
	UIActivityIndicatorView *loading = (UIActivityIndicatorView *)[webView viewWithTag:1001];
	[loading stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	NSLog(@"%@,%@",[webView.request URL],error);
	UIActivityIndicatorView *loading = (UIActivityIndicatorView *)[webView viewWithTag:1001];
	[loading stopAnimating];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 1101) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}


- (void)goNext:(NSMutableDictionary *)dic {
    NSLog(@"dic = %@", dic);
    NSString *code = [dic objectForKey:@"code"];
    if (isBangDing) {
        if ([code isEqualToString:@"0"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingStatus" object:self];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"绑定成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            alert.tag = 1101;
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[dic objectForKey:@"errinfo"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            alert.tag = 1101;
            [alert release];
        }
        return;
    }
	
	NSString *type = [dic objectForKey:@"type"];
	NSString *digest = [dic objectForKey:@"digest"];
	NSString *unionId = [dic objectForKey:@"unionId"];
	NSString *ran = [dic objectForKey:@"ran"];
	NSString *userId= [dic objectForKey:@"userId"];
	NSString* nick_name = [[dic objectForKey:@"nick_name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * accesstoken = [dic objectForKey:@"accesstoken"];
	if ([type isEqualToString:@"0"]) {
		
		if ([digest isEqualToString:[SinaBindViewController EncryptWithMD5:[NSString stringWithFormat:@"%@%@%@%@",CFkeyWord,ran,type,userId]]] || [digest isEqualToString:@""]) {
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
            
            if (self.unNitionLoginType == UnNitionLoginTypeAlipay) {
                [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"isAlipay"];
            }else if (self.unNitionLoginType == UnNitionLoginTypeSina) {
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"isUnionType"];
            }
            
            
			//[GC_HttpService sharedInstance].sessionId = [dic objectForKey:@"session_id"];
			caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
			appDelegate.lastAccount = YES;
            [appDelegate DologinSave];
			[appDelegate LogInBySelf];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogin" object:nil];
			[appDelegate switchToHomeView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelPrivateLetter" object:nil];
   
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加密信息有错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}

	}
	else if([type isEqualToString:@"1"]) {
		if ([digest isEqualToString:[SinaBindViewController EncryptWithMD5:[NSString stringWithFormat:@"%@%@%@%@",CFkeyWord,ran,type,unionId]]] || [digest isEqualToString:@""]) {
			AddNick_NameViewController *add = [[AddNick_NameViewController alloc] init];
			add.unionId = unionId;
            add.unNitionLoginType = unNitionLoginType;
			[self.navigationController pushViewController:add animated:YES];
			[add release];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加密信息有错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1101;
			[alert release];
		}

	}
	else {
		if ([code isEqualToString:@"0"]) {
			Info *info = [Info getInstance];
			UserInfo *user = info.mUserInfo;
			user.unionStatus = @"1";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingStatus" object:self];

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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {
	self.sinaURL = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
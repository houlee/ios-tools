//
//  YaoQingViewController.m
//  caibo
//
//  Created by zhang on 9/14/12.
//
//

#import "YaoQingViewController.h"
#import "Info.h"
#import "DuanXinViewController.h"
#import "NetURL.h"
#import "JSON.h"
#import "ProvingViewCotroller.h"
#import "User.h"
#import "UserInfo.h"
#import "GC_HttpService.h"
#import "CP_PTButton.h"
#import "MobClick.h"


@interface YaoQingViewController ()

@end

@implementation YaoQingViewController
@synthesize httpRequest;
@synthesize passWord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)dealloc {
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.CP_navigation.title = @"邀请好友";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // [bgImage setImage:UIImageGetImageFromName(@"login_bgn.png")];
    bgImage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgImage];
    [bgImage release];
    
    UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 125, 15)];
    kjTime.backgroundColor = [UIColor clearColor];
    kjTime.text = @"邀请说明";
    kjTime.font = [UIFont boldSystemFontOfSize:15];
    [self.mainView addSubview:kjTime];
    [kjTime release];
    

    
    UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(45, 77, 250, 12)];
    kjTime3.backgroundColor = [UIColor clearColor];
    kjTime3.text = @"“投注站” 会在活动期间持续感谢您的支持！";
    kjTime3.font = [UIFont systemFontOfSize:12];
    kjTime3.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime3];
    [kjTime3 release];
    


    UIButton *dxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    dxbutton.frame = CGRectMake(15, 158, 290, 45);
    [dxbutton addTarget:self action:@selector(pressdYaoQing:) forControlEvents:UIControlEventTouchUpInside];
    [dxbutton setTitle:@"短信邀请" forState:UIControlStateNormal];
    [dxbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dxbutton setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [dxbutton setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi-anxia480.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];

    dxbutton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    dxbutton.userInteractionEnabled = YES;
    [self.mainView addSubview:dxbutton];
    
//    UIImageView *dximage = [[UIImageView alloc] initWithFrame:dxbutton.bounds];
//    dximage.image = [UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    dximage.image = [UIImageGetImageFromName(@"anniu-shangchuanyangshi-anxia480.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [dxbutton addSubview:dximage];
//    [dximage release];
    
    
    
    
//    UILabel *dxLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 80, 35)];
//    dxLabel.text = @"短信邀请";
//    dxLabel.textAlignment = NSTextAlignmentCenter;
//    dxLabel.font = [UIFont boldSystemFontOfSize:16];
//    dxLabel.textColor = [UIColor whiteColor];
//    dxLabel.backgroundColor = [UIColor clearColor];
//    [dxbutton addSubview:dxLabel];
//    [dxLabel release];
    

    
}


- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}




-(void)pressdYaoQing:(UIButton *)sender
{
    NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue]);
    NSLog(@"aaa = %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] intValue]);
    [MobClick event:@"event_wodecaipiao_yaoqinghaoyou_duanxin"];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 || [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] intValue] == 0) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            
            
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 111;
            [alert show];
            [alert release];
            
        }else {
            
            
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
                 }

    }else{
        
        DuanXinViewController *dx = [[DuanXinViewController alloc] init];
        [self.navigationController pushViewController:dx animated:YES];
        [dx release];
    }
    
        
        
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            self.passWord = message;
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
//                    NSString *password = textF.text;
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                    [httpRequest setDidFailSelector:@selector(recivedFail:)];
                    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [httpRequest setDelegate:self];
                    [httpRequest startAsynchronous];
                    
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    NSString *password = self.passWord;
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                    [httpRequest setDidFailSelector:@selector(recivedFail:)];
                    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [httpRequest setDelegate:self];
                    [httpRequest startAsynchronous];
                    
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }    
    
    
}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
	
	if ([responseStr isEqualToString:@"fail"])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        [alert release];
	}
	else {
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            [alert release];
			return;
		}
        else if (isTixian) {
            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
            
            [httpRequest clearDelegatesAndCancel];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [httpRequest setRequestMethod:@"POST"];
            [httpRequest addCommHeaders];
            [httpRequest setPostBody:postData];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest setDidFinishSelector:@selector(returnTiXianSysTime:)];
            [httpRequest startAsynchronous];
            
        }
        else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
		
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
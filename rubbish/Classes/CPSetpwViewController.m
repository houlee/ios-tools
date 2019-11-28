//
//  CPSetpwViewController.m
//  caibo
//
//  Created by houchenguang on 14-2-28.
//
//

#import "CPSetpwViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"

@interface CPSetpwViewController ()

@end

@implementation CPSetpwViewController
@synthesize httpRequest, passWord;

- (void)dealloc{
    [passWord release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)typeFunc{

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    NSString * typestr = [userArr objectAtIndex:2];
                    if ([typestr isEqualToString:@"1"]) {
                        switchyn.on = YES;
                        switchynBool = YES;
                        break;
                    }else{
                        switchyn.on = NO;
                        switchynBool = NO;
                        break;
                    }
                }
                
            }
            
        }
        
    }
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self typeFunc];
    UIImageView * twoImage = (UIImageView *)[self.mainView viewWithTag:123];
    if (switchynBool) {
        twoImage.hidden = NO;
    }else{
        twoImage.hidden = YES;
    }
   
}
- (void)passWordOpenUrl{


}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.CP_navigation.title = @"设置";
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    // bgview.image = [UIImage imageNamed:@"login_bgn.png"];
    bgview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgview];
    [bgview release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17, 320, 44)];
    bgimage.backgroundColor = [UIColor whiteColor];
    bgimage.userInteractionEnabled = YES;
    // bgimage.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
    
    
    // 线
    UIView *line1 = [[[UIView alloc] init] autorelease];
    line1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    line1.frame = CGRectMake(0, 16.5, 320, 0.5);
    [self.mainView  addSubview:line1];
   
    UIView *line2 = [[[UIView alloc] init] autorelease];
    line2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    line2.frame = CGRectMake(0, bgimage.frame.size.height, 320, 0.5);
    [bgimage  addSubview:line2];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 200, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"开启手势密码";
    [bgimage addSubview:titleLabel];
    [titleLabel release];
   
    
    switchyn = [[CP_SWButton alloc] initWithFrame:CGRectMake(230, 8, 70, 31)];
    switchyn.onImageName = @"heji2-640_10.png";
    switchyn.offImageName = @"heji2-640_11.png";
//    switchyn.on = NO;
    [switchyn addTarget:self action:@selector(pressSwitchYN:) forControlEvents:UIControlEventValueChanged];
    [bgimage addSubview:switchyn];
    [switchyn release];
    
    
    
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
//    if (switchynBool) {
        UIImageView * bgimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17+44.5, 320, self.mainView.frame.size.height - 17-44)];
        bgimage2.backgroundColor = [UIColor whiteColor];
        bgimage2.tag = 123;
        bgimage2.userInteractionEnabled = YES;
        // bgimage2.image = [[UIImage imageNamed:@"SZT960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:23];
        UIView *line3 = [[[UIView alloc] init] autorelease];
        line3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        line3.frame = CGRectMake(0, 44, 320, 0.5);
        line3.userInteractionEnabled = YES;
        [bgimage2  addSubview:line3];
       bgimage2.userInteractionEnabled = YES;
        
        UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 200, 20)];
        titleLabel2.backgroundColor = [UIColor clearColor];
        titleLabel2.font = [UIFont boldSystemFontOfSize:14];
        titleLabel2.textAlignment = NSTextAlignmentLeft;
        titleLabel2.textColor = [UIColor blackColor];
        titleLabel2.text = @"重新设置手势密码";
        [bgimage2 addSubview:titleLabel2];
    [titleLabel2 release];
        [self.mainView addSubview:bgimage2];
   [bgimage2 release];
        UIImageView * hou1 = [[UIImageView alloc] initWithFrame:CGRectMake(274, (44-14)/2-1, 9, 14)];
        // login_arr
        hou1.image = UIImageGetImageFromName(@"jiantou_1.png");
        [bgimage2 addSubview:hou1];
        [hou1 release];
        
        UIButton * bgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgbutton.frame = bgimage2.bounds;
       // bgbutton.frame = CGRectMake(0, 17+44, 320, 44);
        [bgbutton addTarget:self action:@selector(resetPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgimage2 addSubview:bgbutton];

//    }
//    if (switchynBool) {
//        bgimage2.hidden = YES;
//    }else{
//        bgimage2.hidden = NO;
//    }
    

}
- (void)resetPassWordButton:(UIButton *)sender{
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.delegate = self;
    alert.tag = 112;
    [alert show];
    [alert release];
}

- (void)pressSwitchYN:(CP_SWButton *)sender{

    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.delegate = self;
    alert.tag = 111;
    [alert show];
    [alert release];
    

}

- (void)loginFunc:(NSInteger)count{

    [self.httpRequest clearDelegatesAndCancel];
    NSString *name = [[Info getInstance] login_name];
    //        NSString *password = self.passWord;
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
    [httpRequest setTimeOutSeconds:20.0];
    if (count == 1) {
        [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
    }else{
        [httpRequest setDidFinishSelector:@selector(recivedLoginFinishTwo:)];
    }
//    [httpRequest setDidFailSelector:@selector(recivedFail:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    
    switchyn.on = switchynBool;
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            self.passWord = message;
            [self loginFunc:1];
        }

    }else{
        if (buttonIndex == 1) {
            self.passWord = message;
            [self loginFunc:2];
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
		}else{ //登录成功
            
            
            
            
            if (switchynBool) {
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
//                    NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                    NSMutableArray * allUserArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]];
                    
                    for (int i = 0; i < [allUserArr count]; i++) {
                        //        NSArray * userArr = [];
                        NSString * userString = [allUserArr objectAtIndex:i];
                        NSArray * userArr = [userString componentsSeparatedByString:@" "];
                        if ([userArr count] == 3) {
                           
                            if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
//                                NSString * typestr = [userArr objectAtIndex:2];
                                NSString * userall = [NSString stringWithFormat:@"%@ %@ %@", [userArr objectAtIndex:0], [userArr objectAtIndex:1], @"0"];
                                [allUserArr replaceObjectAtIndex:i withObject:userall];
                                [[NSUserDefaults standardUserDefaults] setObject:allUserArr forKey:@"testPassWord"];
                                
                                break;
                            }
                            
                        }
                        
                    }
                    [allUserArr release];
                    
                }
                
                
                switchyn.on = NO;
                switchynBool = NO;
                UIImageView * twoImage = (UIImageView *)[self.mainView viewWithTag:123];
                twoImage.hidden = YES;
            }else{
                
                BOOL pwInfoBool = NO;
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                    NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                    
                    
                    for (int i = 0; i < [allUserArr count]; i++) {
                        //        NSArray * userArr = [];
                        NSString * userString = [allUserArr objectAtIndex:i];
                        NSArray * userArr = [userString componentsSeparatedByString:@" "];
                        if ([userArr count] == 3) {
                            
                            if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                              
                                pwInfoBool = YES;
                                
                                break;
                            }
                            
                        }
                        
                    }
                    
                }
                
                if (pwInfoBool) {
                    TestViewController * test = [[TestViewController alloc] init];
                    [self.navigationController pushViewController:test animated:YES];
                    [test release];
                }else{
                    PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                    [self.navigationController pushViewController:pwinfo animated:YES];
                    [pwinfo release];
                
                }
                
                
                
            }
            
            
            
            
            
        }
        [userInfo release];
		
	}
}
- (void)recivedLoginFinishTwo:(ASIHTTPRequest*)request {
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
		}else{ //登录成功
            
            
                       
            TestViewController * test = [[TestViewController alloc] init];
            [self.navigationController pushViewController:test animated:YES];
            [test release];
            
            
            
            
        }
        [userInfo release];
		
	}
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
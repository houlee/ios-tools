//
//  Expert365Bridge.m
//  caibo
//
//  Created by GongHe on 15/11/25.
//
//

#import "Expert365Bridge.h"
#import "GC_TopUpViewController.h"
#import "AccountDrawalViewController.h"
#import "NetURL.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "FuCai3DViewController.h"
#import "DaLeTouViewController.h"
#import "Pai3ViewController.h"
#import "GCJCBetViewController.h"
#import "LoginViewController.h"

@interface Expert365Bridge ()<CP_UIAlertViewDelegate>

@property (nonatomic, assign)UIViewController * superController;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, copy) NSString * password;

@end

@implementation Expert365Bridge

@synthesize password;
@synthesize httpRequest;
@synthesize superController;

-(void)toRechargeFromController:(UIViewController *)controller
{
    GC_TopUpViewController * toUp = [[[GC_TopUpViewController alloc] init] autorelease];
    [controller.navigationController pushViewController:toUp animated:YES];
}

-(void)toWithdrawalFromController:(UIViewController *)controller
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0){
        CP_UIAlertView * alert = [[[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
        alert.alertTpye = passWordType;
        alert.tag = 105;
        [alert show];
        
        self.superController = controller;
    }
    else {
        AccountDrawalViewController *drawal = [[[AccountDrawalViewController alloc] init] autorelease];
        drawal.password = nil;
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
        {
            drawal.isNotPer = NO;
        }
        else
        {
            drawal.isNotPer = YES;
        }
        [controller.navigationController pushViewController:drawal animated:YES];
    }
}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    if ([responseStr isEqualToString:@"fail"])
    {
        CP_UIAlertView *alert = [[[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil] autorelease];
        [alert show];
        alert.tag = 100;
        
    }
    else {
        UserInfo *userInfo = [[[UserInfo alloc] initWithParse:responseStr DIC:nil] autorelease];
        if (!userInfo) {
            CP_UIAlertView *alert = [[[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil] autorelease];
            [alert show];
            alert.tag = 100;
            return;
        }
        
        AccountDrawalViewController *drawal = [[[AccountDrawalViewController alloc] init] autorelease];
        drawal.password = self.password;
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
        {
            drawal.isNotPer = NO;
            
        }
        else
        {
            drawal.isNotPer = YES;
            
        }
        [drawal setHidesBottomBarWhenPushed:YES];
        [superController.navigationController pushViewController:drawal animated:YES];
        
    }
}

-(void)betShuZiFromController:(UIViewController *)controller lotteryID:(NSString *)lotteryID
{
    if ([lotteryID isEqualToString:@"001"]) {//双色球
        GouCaiShuangSeQiuViewController *shuang = [[[GouCaiShuangSeQiuViewController alloc] init] autorelease];
        [controller.navigationController pushViewController:shuang animated:YES];
    }else if ([lotteryID isEqualToString:@"002"]) {//3D
        FuCai3DViewController *fucai = [[[FuCai3DViewController alloc] init] autorelease];
        [controller.navigationController pushViewController:fucai animated:YES];
    }else if ([lotteryID isEqualToString:@"113"]) {//大乐透
        DaLeTouViewController *dale = [[[DaLeTouViewController alloc] init] autorelease];
        [controller.navigationController pushViewController:dale animated:YES];
    }else if ([lotteryID isEqualToString:@"108"]) {//排三
        Pai3ViewController *pai = [[[Pai3ViewController alloc] init] autorelease];
        [controller.navigationController pushViewController:pai animated:YES];
    }
}

-(void)betJingCaiFromController:(UIViewController *)controller competeGoBetDic:(NSDictionary *)competeGoBetDic
{
    GCJCBetViewController * gcjc = [[[GCJCBetViewController alloc] initWithLotteryID:1] autorelease];
    NSDictionary * planInfoDic = [competeGoBetDic valueForKey:@"planInfo"];
    NSString * systemTime = [planInfoDic valueForKey:@"systemtime"];
    NSArray * systemTimeArray = [systemTime componentsSeparatedByString:@" "];
    if (systemTimeArray.count > 1) {
        gcjc.systimestr = [systemTimeArray objectAtIndex:0];
    }else{
        gcjc.systimestr = @"";
    }
    gcjc.zhuanjiaDic = planInfoDic;
    [controller.navigationController pushViewController:gcjc animated:YES];
}

- (BOOL)goWanshanXinxi:(UIViewController *)controller {
    self.superController = controller;
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 111;
    [alert show];
    return NO;
}

-(BOOL)validateRealNameFormController:(UIViewController *)controller
{
    self.superController = controller;
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] != 0 || [[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] isEqualToString:@"0"]) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"为了更好的保护您的信息安全,申请专家前请先完善您的个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.delegate = self;
        alert.tag = 222;
        [alert show];
        [alert release];
        
        return NO;
    }
    return YES;
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            self.password = message;
            [self.httpRequest clearDelegatesAndCancel];
            
            NSString *name = [[Info getInstance] login_name];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.password]];
            [self.httpRequest setTimeOutSeconds:20.0];
            [self.httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [self.httpRequest setDelegate:self];
            [self.httpRequest startAsynchronous];
        }
    }
    else if (alertView.tag == 222) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            if (buttonIndex == 1) {
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 111;
                [alert show];
                [alert release];
            }
        }else{
            if (buttonIndex == 1) {
                ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
                [superController.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
        }
    }
    else if (alertView.tag == 111) {
        self.password = message;
        if (buttonIndex == 1) {
            if (![self.password isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.password]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(getUserInfoFinish:)];
                    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [httpRequest setDelegate:self];
                    [httpRequest startAsynchronous];
                    
                }
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [superController.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }
}

- (void)getUserInfoFinish:(ASIHTTPRequest*)request {
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
        else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.password;
            [superController.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
        
    }
}

-(void)toLoginFormController:(UIViewController *)controller
{
    LoginViewController *loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [controller.navigationController pushViewController:loginVC animated:YES];
}

-(void)dealloc
{
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    
    [super dealloc];
}

-(void)showMessage:(NSString *)message
{
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai showMessage:message];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
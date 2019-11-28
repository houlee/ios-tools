//
//  PassWordView.m
//  caibo
//
//  Created by houchenguang on 14-2-27.
//
//

#import "PassWordView.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "CPSetpwViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GouCaiHomeViewController.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GCHeMaiSendViewController.h"
#import "JiangJinYouhuaViewController.h"
@implementation PassWordView
@synthesize httpRequest;
//@synthesize viewController;

- (void)dealloc{
    
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
//    [viewController release];
    [super dealloc];

}

- (void)sleepRemoveSelf{
    [self removeFromSuperview];
}

- (void)removeSelfView{

    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(sleepRemoveSelf) withObject:nil afterDelay:0.3];
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        markCount = 4;
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        alertBool = NO;
        
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            self.frame = CGRectMake(app.window.frame.origin.x, app.window.frame.origin.y + 20, app.window.frame.size.width, app.window.frame.size.height - 20);
//        }else{
//            self.frame = app.window.bounds;
//        }
        
        
       
        
        
        UIImageView * backi = [[UIImageView alloc] initWithFrame:self.bounds];
        backi.frame = CGRectMake(0, 0, 320, self.frame.size.height- 44);
        // backi.image = UIImageGetImageFromName(@"login_bgn.png");
        backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
        backi.userInteractionEnabled = YES;
        [self addSubview:backi];
        [backi release];
        
        UIView *daoHangView = [[[UIView alloc] init] autorelease];
        daoHangView.backgroundColor = [UIColor colorWithRed:21/255.0   green:136/255.0  blue:218/255.0 alpha:1];
        daoHangView.frame = CGRectMake(0, 0, 320, 44);
        daoHangView.userInteractionEnabled = YES;
        [backi addSubview:daoHangView];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 66, 44);
        backBtn.userInteractionEnabled = YES;
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        [daoHangView addSubview:backBtn];
        
        
        UIImageView *backBtnImage = [[[UIImageView alloc] init] autorelease];
        backBtnImage.frame = CGRectMake(8, 0, 60, 44);
        backBtnImage.image = [UIImage imageNamed:@"wb58.png"];
        backBtnImage.backgroundColor = [UIColor clearColor];
        [backBtn addSubview:backBtnImage];
        
        
        
        // 4 5
        UIImageView * lockBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width , self.frame.size.height )];
        lockBgImage.backgroundColor = [UIColor clearColor];
        lockBgImage.userInteractionEnabled = YES;
        // ***lockbgimage
        lockBgImage.image = [UIImageGetImageFromName(@"shouShiJieSuo-bg_1.png") stretchableImageWithLeftCapWidth:95 topCapHeight:95];
        [self addSubview:lockBgImage];
        [lockBgImage release];
        
        
        UIImageView * lockimage = [[UIImageView alloc] initWithFrame:CGRectMake(6-6, 60, lockBgImage.frame.size.width , 303)];
        lockimage.backgroundColor= [UIColor clearColor];
        lockimage.userInteractionEnabled = YES;
        [lockBgImage addSubview:lockimage];
        [lockimage release];
        
        
        SPLockScreen *lockScreenView = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, lockimage.frame.size.width, lockimage.frame.size.height)];
        //	self.lockScreenView.center = self.mainView.center;
        lockScreenView.delegate = self;
        lockScreenView.backgroundColor = [UIColor clearColor];
        [lockimage addSubview:lockScreenView];
        
        UILabel * infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(6-6, 38-14, lockBgImage.frame.size.width , 20)];
        
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.font = [UIFont systemFontOfSize:14];
//        infoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        infoLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        
        infoLabel.text = @"请输入手势密码";
        [lockBgImage addSubview:infoLabel];
        [infoLabel release];
        
        //	[self updateOutlook];
        
        
        UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearButton.frame = CGRectMake((312-120)/2, 374+20, 120, 30);
       
        [clearButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [clearButton setTitle:@"忘记手势密码？" forState:UIControlStateNormal];
        clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [clearButton addTarget:self action:@selector(pressClearButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearButton];
        
        if (IS_IPHONE_5) {
            clearButton.frame = CGRectMake((320-120)/2, 374+50+20, 120, 30);
            // ***-44
            infoLabel.frame = CGRectMake(0, 38+50-48, lockBgImage.frame.size.width , 20);
            lockimage.frame =CGRectMake(0, 60+50-16, lockBgImage.frame.size.width , 303);
        }
        
        
        
    }
    return self;
}

- (void)doBack:(UIButton *)btn
{

    [self removeSelfView];

}



- (void)pressClearButton{
    

    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alertBool= YES;
    alert.tag = 11;
    [alert show];
    [alert release];
    
    
    
    
    
    NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    
}






#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
    //	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@"no.%@", [patternNumber stringValue]);
    
    NSString * number = [patternNumber stringValue];
    
    
    NSMutableArray * userArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
    
    BOOL sameBool = NO;
    for (int i = 0; i < [userArray count]; i++) { // 遍历所存的用户
        
        NSString * userps = [userArray objectAtIndex:i];
        NSArray * userarr = [userps componentsSeparatedByString:@" "];
        if ([userarr count] == 3) {
            NSString * userid = [userarr objectAtIndex:0];
            if ([userid isEqualToString:[[Info getInstance] userId]]) { //如果有的话 替换
                
               
                if ([[userarr objectAtIndex:1] isEqualToString:number]) {
                    sameBool = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"passWordOpenUrl" object:nil];
                    
                    [self removeSelfView];
                    break;
                    
                }
                
            }
        }
    }
    
    if (sameBool == NO) {
        NSLog(@"SSSSSSSSSSSSSSSSSSSSSSSSS");
        if (markCount > 0) {
            markCount = markCount - 1;
        }
        
        if (markCount == 0) {
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alertBool = NO;
            alert.tag = 10;
            [alert show];
            [alert release];
        }else{
            if (markCount <= 0) {
                markCount = 0;
            }
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:[NSString stringWithFormat:@"密码错误,还可以再输入%d次", (int)markCount]];
        }
        
        
    }
    
    
    
    
}

- (void)popViewShow{
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UINavigationController *a = (UINavigationController *)app.window.rootViewController;
    NSArray * views = a.viewControllers;
    for (int i = 0; i < [views count]; i++) {
        UIViewController * con = [views objectAtIndex:[views count] - (i+1)];
        if ([con isKindOfClass:[CPSetpwViewController class]] || [con isKindOfClass:[GC_ShengfuInfoViewController class]] || [con isKindOfClass:[GouCaiShuZiInfoViewController class]] || [con isKindOfClass:[GouCaiHomeViewController class]] || [con isKindOfClass:[GCHeMaiSendViewController class]] || [con isKindOfClass:[JiangJinYouhuaViewController class]]) {
            
            
//            [app.window.rootViewController.navigationController popToViewController:con animated:NO];
            [con performSelector:@selector(passWordOpenUrl)];
            
            //            if ([con isKindOfClass:[CPSetpwViewController class]] ||  [con isKindOfClass:[GouCaiHomeViewController class]]) {
            //                <#statements#>
            //            }
            //
            break;
        }
    }
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    
    
    if (alertView.tag == 100) {
        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertTpye = passWordType;
        alertBool = NO;
        alert.tag = 10;
        [alert show];
        [alert release];
    }
    
    if (alertView.tag == 11) {
        if (buttonIndex == 1) {
            
            [self.httpRequest clearDelegatesAndCancel];
            NSString *name = [[Info getInstance] login_name];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:message]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }else{
            [self removeSelfView];
        }
    }
    
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            
            [self.httpRequest clearDelegatesAndCancel];
            NSString *name = [[Info getInstance] login_name];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:message]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }else{
            
            
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                //                    NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                NSMutableArray * allUserArr = [[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]] autorelease];
                
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
                
            }
            
            [self removeSelfView];
        }
    }
    
    if (alertView.tag == 997) {
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
//             [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPassWord" object:nil];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPassWord" object:nil];
           
        }else{
           
            [self popViewShow];
        }
       
        
        
            
        
        
        
        
    }
    

}
- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    
    
        NSString *responseStr = [request responseString];
        
        if ([responseStr isEqualToString:@"fail"])
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 100;
            [alert release];
        }
        else {
            UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
            if (!userInfo) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                [alert show];
                alert.tag = 100;
                [alert release];
                return;
            }
            else {
                if (alertBool == NO) {
                    CP_UIAlertView * alear = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否重设手势密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alear.delegate = self;
                    alear.tag = 997;
//                    alear.alertTpye = twoTextType;
                    [alear show];
                }else{
                    
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPassWord" object:nil];
                
                }
               
                
                    //            resetPassWord
                
                    
                    
                    [self removeSelfView];
//                }else{
//                    
//                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"passWordOpenUrl" object:nil];
//                    [self removeSelfView];
//                    
//                }

            
            }
            [userInfo release];
            
            
        }
        
        
    }
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
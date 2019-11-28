//
//  GouCaiHomeViewController.m
//  caibo
//
//  Created by yao on 12-5-23.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GouCaiHomeViewController.h"
#import "Info.h"
#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "GC_BetRecord.h"
#import "MyLottoryViewController.h"
#import "GCXianJinLiuShuiController.h"
#import "ChongZhiData.h"
#import "User.h"
#import "ProvingViewCotroller.h"
#import "PhotographViewController.h"
#import "DataBase.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "NetURL.h"
#import "PKMatchViewController.h"
#import "DuanXinViewController.h"
#import "YaoQingViewController.h"
#import "JiangLiHuoDongViewController.h"
#import "NSDate-Helper.h"
#import "GuideView.h"
#import "ChangPasswordViewController.h"
#import "MobClick.h"
#import "GouCaiViewController.h"
#import "IpadRootViewController.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "PassWordView.h"
#import "CJBNoActivateViewController.h"
#import "CJBActivateViewController.h"
#import "CPselfServiceViewController.h"
#import "PointViewController.h"
#import "CPSetViewController.h"
#import "HRSliderViewController.h"
#import "FAQView.h"
#import "DrawalViewController.h"
#import "AccountDrawalViewController.h"
#import "MLNavigationController.h"
#import "QuestionViewController.h"

#import "ImageUtils.h"

#import "AboutOurViewController.h"

@implementation GouCaiHomeViewController
{

    NSMutableArray *_topTitleArray;
    int _index;
    
}



@synthesize photoBackGroundView;
@synthesize httpRequest,SevenDayRequest,reqUserInfo;
@synthesize passWord, caijinbao, selfHelpImageView,caijinType;
@synthesize leftBarBtnItem;
@synthesize rightBarBtnItem;
@synthesize drawal_jiangliMoney;

@synthesize reqEditPerInfo;
//@synthesize reqEditPerInfo;
//@synthesize padDoBack,finish;
//@synthesize xiugaitouxiangtype;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)sleepPassWordViewShow{
    caiboAppDelegate * cai = [caiboAppDelegate getAppDelegate];
    PassWordView * pwv = [[PassWordView alloc] init];
    pwv.alpha = 0;
//    pwv.viewController = self;
    [cai.window addSubview:pwv];
    [pwv release];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    pwv.alpha = 1;
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Action

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManager:[[Info getInstance] userName]];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
		[httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpRequest setDidFailSelector:@selector(reqAccountInfoFail:)];
        [httpRequest startAsynchronous];
    }
}

//查看是否能领取彩金
- (void)getSevenDayInfo {
    if (![[[Info getInstance] userId] intValue]) {
        return;
    }
    [self.SevenDayRequest clearDelegatesAndCancel];
    self.SevenDayRequest = [ASIHTTPRequest requestWithURL:[NetURL CheckAchieveActivMon]];
    [SevenDayRequest setTimeOutSeconds:20.0];
    [SevenDayRequest setDidFinishSelector:@selector(recivedSevenDayInfo:)];
    [SevenDayRequest setDidFailSelector:@selector(recivedFail:)];
    [SevenDayRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [SevenDayRequest setDelegate:self];
    [SevenDayRequest startAsynchronous];
    
}

//领取彩金
- (void)getSevenDayCaiJin {
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 0 ) {
        UIView *view2 = [self.mainView viewWithTag:1133];
        view2.userInteractionEnabled = NO;
        [self.SevenDayRequest clearDelegatesAndCancel];
        self.SevenDayRequest = [ASIHTTPRequest requestWithURL:[NetURL achieveActivMon:self.caijinType]];
        [SevenDayRequest setTimeOutSeconds:20.0];
        [SevenDayRequest setDidFinishSelector:@selector(recivedSevenDayCaiJin:)];
        [SevenDayRequest setDidFailSelector:@selector(recivedFail:)];
        [SevenDayRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [SevenDayRequest setDelegate:self];
        [SevenDayRequest startAsynchronous];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"请先完善用户信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 106;
        [alert release];
    }

}

- (void)getPersonalInfoRequest
{
    if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0){
        NSLog(@"1111");
        
    }else{
            [self getAccountInfoRequest];
    }
	
   
}


//- (void)refresh {
//    [self JLhidden];
//    refreshbtn.hidden = YES;
//    [activityView startAnimating];
//    [self getPersonalInfoRequest];
//}

- (void)refresh
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate =self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_1_PI,0, 0,1.0)];
    animation.duration =0.05;
    animation.cumulative =YES;//累积的
    animation.repeatCount = INT_MAX;
    [refreshImageView.layer addAnimation:animation forKey:@"animation"];
    [self getAccountInfoRequest];
    
//    [self dismissRefreshTableHeaderView];
    isAllRefresh = NO;
    isLoading = NO;

}



- (void)pressChongZhi{
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
    [httpRequest startAsynchronous];
   // NSLog(@"url = %@", [[GC_HttpService sharedInstance] reChangeUrl]);
	//[[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:<#(NSString *)#>]];
}


- (void)doBack {
	
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];

}

//- (void)tixianInfo {
//    [MobClick event:@"event_wodecaipiao_tikuanjiaocheng"];
//    GuideView *guideView = [[GuideView alloc] initWithFrame:[caiboAppDelegate getAppDelegate].window.bounds];
//    [guideView LoadImageArray:[NSArray arrayWithObjects:@"YDYMCZ960.png",@"YDYMCZ1960.png", nil]];
//    [[[caiboAppDelegate getAppDelegate] window] addSubview:guideView];
//    [guideView release];
//}

- (void)chongzhiInfo {
    
//    GuideView *guideView = [[GuideView alloc] initWithFrame:[caiboAppDelegate getAppDelegate].window.bounds];
//    [guideView LoadImageArray:[NSArray arrayWithObjects:@"YDTK960.png",@"YDTK1960.png",@"YDTK2960.png", nil]];
//    [[[caiboAppDelegate getAppDelegate] window] addSubview:guideView];
//    [guideView release];
    
}

- (void)Presschangepassword {

    ChangPasswordViewController *passwordViewController = [[ChangPasswordViewController alloc] init];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:passwordViewController animated:YES];
    [passwordViewController release];
}


- (BOOL)typeFunc{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    if ([userArr count] > 2) {
                        NSString * typestr = [userArr objectAtIndex:2];
                        if ([typestr isEqualToString:@"1"]) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                }
                
            }
            
        }
        
    }
    return NO;
}

-(void)btnTouchesCancel{

    myScrollView.delaysContentTouches = YES;

}
-(void)btnTouchesBegan{
    myScrollView.delaysContentTouches = NO;

}
- (void)functionClike:(UIButton *)btn {
    

#ifdef isCaiPiaoForIPad
    
    [self JLhidden];
    isTixian = NO;
    isLiuShui = NO;
    isZiZhu = NO;
	if (btn.tag == 0) {
        [MobClick event:@"event_wodecaipiao_quanbucaipiao"];
		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"全部彩票";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
	}
	else if (btn.tag == 1) {
        [MobClick event:@"event_wodecaipiao_zhongjiangcaipiao"];
		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMe;
		my.caiLottoryType = CaiLottoryTypeJiang;
		my.title = @"中奖彩票";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
    }
	else if (btn.tag == 11) {
        
        
        
        
//        GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
//        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:toUp animated:YES];
//        [toUp release];
        
        [self pressChongZhi];
        
        
        //    [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrl]];
    }else if(btn.tag == 101){
//#ifdef isYueYuBan
//
        [MobClick event:@"event_wodecaipiao_chongzhi"];
        GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:toUp animated:YES];
        [toUp release];
//#else
//        [self pressChongZhi];
//#endif

    
    }
    else if (btn.tag == 10) {
        isLiuShui = YES;
        GCXianJinLiuShuiController * xianj = [[GCXianJinLiuShuiController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:xianj animated:YES];
        [xianj release];
    }
    

    else if (btn.tag == 20) {//修改个人信息
		if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            [text release];
			text = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
			text.placeholder = @"请输入登录密码";
			
			text.autocorrectionType = UITextAutocorrectionTypeYes;
			text.secureTextEntry = YES;
			CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"要查看身份信息,请输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 111;
			[alert show];
			[alert addSubview:text];
			text.backgroundColor = [UIColor whiteColor];
			[alert release];
		}
		else {
			caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
            
            UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
            vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            vi.tag = 10212;
            ProvingViewCotroller *pro = [[ProvingViewCotroller alloc] init];
            pro.disanfang = YES;
            UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:pro];
            nac.view.frame = CGRectMake(80, 180, 540, 680);
            [vi addSubview:nac.view];
            
            //旋转
            CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
            rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
            rotationAnimation.duration = 0.0f;
            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
            nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
            
            [app.window addSubview:vi];
            [pro release];
            [vi release];
            
		}
        
    }
    else  if (btn.tag == 21) {//修改头像
        
        [[caiboAppDelegate getAppDelegate] XiuGaiTouXiangForiPad:YES Save:YES];
        
    }
    
	else if (btn.tag == 12) {
        // 提款
        [MobClick event:@"event_wodecaipiao_tikuan"];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0){
            isTixian = YES;
            [text release];
            text = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
            text.placeholder = @"请输入登录密码";
            
          //  text.autocorrectionType = UITextAutocorrectionTypeYes;
           // text.secureTextEntry = YES;
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"要账户提现,请输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 105;
            [alert show];
          //  [alert addSubview:text];
           // text.backgroundColor = [UIColor whiteColor];
            [alert release];
        }
        else {
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
        //		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //		[cai showMessage:@"请登录www.zgzcw.com提现"];
	}
    else if (btn.tag == 3) {
    
        [MobClick event:@"event_wodecaipiao_hemaicaipiao"];
        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMeHe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"我的合买";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
    }
    
    else {
        if (btn.tag == 2) {
            [MobClick event:@"event_wodecaipiao_wodezhuihao"];
            
        }
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"稍后上线敬请期待"];
    }

#else
    
    [self JLhidden];
    isTixian = NO;
    isLiuShui = NO;
    isZiZhu = NO;
	if (btn.tag == 0) {
        [MobClick event:@"event_wodecaipiao_quanbucaipiao"];
		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"全部彩票";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
	}
	else if (btn.tag == 1) {
        [MobClick event:@"event_wodecaipiao_zhongjiangcaipiao"];
        
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"zj"];
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
        }
        
		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMe;
		my.caiLottoryType = CaiLottoryTypeJiang;
		my.title = @"中奖彩票";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
    }
	else if (btn.tag == 11) {
        
        [MobClick event:@"event_wodecaipiao_chongzhi"];
        
        [self pressChongZhi];
        
        
    }else if(btn.tag == 101){
//        #ifdef isYueYuBan
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
            GC_UPMPViewController *um = [[GC_UPMPViewController alloc] init];
            um.chongZhiType = ChongZhiTypeZhiFuBao;
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:um animated:YES];
            
            [um release];
        }
        else {
            [MobClick event:@"event_wodecaipiao_chongzhi"];
            GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:toUp animated:YES];
            [toUp release];
        }
        
//        }
//#else
//        [self pressChongZhi];
//#endif
    }
    else if (btn.tag == 10) {
        
        
        
        // 现金流水
        [MobClick event:@"event_wodecaipiao_xianjinliushui"];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
             isLiuShui = YES;
            if ([self typeFunc]) {
                markCount = 2;
                [self sleepPassWordViewShow];

            }else{
            
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 10;
                [alert show];
                [alert release];
            }
           
           
        }else{
            GCXianJinLiuShuiController * xianj = [[GCXianJinLiuShuiController alloc] init];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:xianj animated:YES];
            [xianj release];
        }
    }
    
    
    
    
    
    // ***积分
    else if (btn.tag == 111)
    {
        if([[[Info getInstance] userId] intValue] == 0)
        {
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [loginVC setHidesBottomBarWhenPushed:YES];
            [loginVC setIsShowDefultAccount:YES];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:loginVC animated:YES];
            [loginVC release];
            return;
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 1 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"isbindmobile"] intValue] == 0)
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"真遗憾\n\n您还没有完善个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完善信息",nil];
            alert.delegate = self;
            [alert show];
            alert.tag = 200;
            [alert release];
            return;
        }
    
        

        
        PointViewController *points = [[PointViewController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:points animated:YES];
        [points release];
    }






    else if (btn.tag == 20) {//修改个人信息
        [MobClick event:@"event_wodecaipiao_gerenxinxi"];
		if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 111;
            [alert show];
            [alert release];
            
		}
		else {
            
			ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
            [proving release];
            
		}
        
    }
    else if (btn.tag == 29)
    {
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
//            
//            isZiZhu = YES;
//            
//            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alert.alertTpye = passWordType;
//            alert.tag = 111;
//            [alert show];
//            [alert release];
//            
//		}
//		else {
        
            
            // 自助服务
        [MobClick event:@"event_wodecaipiao_zizhufuwu"];
            CPselfServiceViewController * service = [[CPselfServiceViewController alloc] init];
            service.password = self.passWord;
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:service animated:YES];
            [service release];
            
//		}
    }
    else  if (btn.tag == 21) {
        
        
        //修改头像
        PhotographViewController * pho = [[PhotographViewController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:pho animated:YES];
        [pho release];
        
//        [self xiugaiTouxiang];
        



    }
	else if (btn.tag == 12) {
        
        // 提款
        [MobClick event:@"event_wodecaipiao_tikuan"];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0){
            isTixian = YES;
  
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 105;
            [alert show];
            [alert release];
           
        }
        else {
            
            AccountDrawalViewController *drawal = [[AccountDrawalViewController alloc] init];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue] == 0 &&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
            {
                drawal.isNotPer = NO;
            }
            else
            {
                drawal.isNotPer = YES;
            }
            drawal.password = self.passWord;
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:drawal animated:YES];
            [drawal release];

        }
	}
    else if (btn.tag == 3) {
        [MobClick event:@"event_wodecaipiao_hemaicaipiao"];
        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMeHe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"我的合买";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
    }
    
    else if (btn.tag == 2) {
        [MobClick event:@"event_wodecaipiao_wodezhuihao"];
        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
        my.myLottoryType = MyLottoryTypeZhuiHao;
        my.caiLottoryType = CaiLottoryTypeAll;
        my.title = @"我的追号";
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
        [my release];
        
        
        
    }
    else if (btn.tag == 30){
    
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"caijinbaomake"];
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * sessionid = @"";
        if ([GC_HttpService sharedInstance].sessionId) {
            sessionid = [GC_HttpService sharedInstance].sessionId;
        }
        NSString * userNameString = @"";
        Info * userInfo = [Info getInstance];
        if ([userInfo.userName length] > 0) {//判断用户名是否为nil
            userNameString = userInfo.userName;
        }
        NSString * flag = [NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@", sessionid, userNameString]];
        
        NSString * h5url = [NSString stringWithFormat:@"%@lottery/financial/financialIndex.jsp?newRequest=1&sessionId=%@&flag=%@&client=ios&sid=%@&date=%d", licai365H5URL,sessionid,flag,[infoDict objectForKey:@"SID"],(int)[[NSDate date] timeIntervalSince1970]];
        [MobClick event:@"event_wodecaipiao_licai"];
        MyWebViewController *webview = [[MyWebViewController alloc] init];
        [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
        webview.delegate= self;
        webview.hiddenNav = YES;
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:webview animated:YES];
        
        [webview release];
    }
    
    else if (btn.tag == 50)
    {
//        KFMessageViewController *kvc=[KFMessageViewController alloc];
//        [self.navigationController pushViewController:kvc animated:YES];
//        [kvc release];
        
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        
        Info *info = [Info getInstance];
        if ([info.userId intValue]) {
            
//            if(!kfmBox)
//            {
//                kfmBox=[[KFMessageViewController alloc]init];
//            }
            KFMessageViewController *kfmBox=[KFMessageViewController alloc];
            
            kfmBox.showBool = YES;
            
            [kfmBox tsInfo];//调用提示信息
            
            [kfmBox returnSiXinCount];
            
            [(UINavigationController *)app.window.rootViewController pushViewController:kfmBox animated:YES];
            
            [kfmBox release];
            
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
                NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
                [dic setValue:@"0" forKey:@"kfsx"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
                caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
                caiboappdelegate.keFuButton.markbool = NO;
                caiboappdelegate.keFuButton.newkfbool = NO;
                
            }
        }
        else {
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [loginVC setHidesBottomBarWhenPushed:YES];
            [loginVC setIsShowDefultAccount:YES];
            [(UINavigationController *)app.window.rootViewController pushViewController:loginVC animated:YES];
            [loginVC release];
#endif
            
        }

    }
    
    
    else{
    
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"稍后上线敬请期待"];
    }

#endif
    
}
#pragma mark - MyWeViewDelegate
-(void)myWebView:(UIWebView *)webView Request:(NSURLRequest *)request{
    
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController popViewControllerAnimated:YES];
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    
    NSLog(@"text = %@ , %@", self.passWord, [[User getLastUser] password]);
    
    if (buttonIndex == 0) {
        if (alertView.tag == 1)
        {// 直接注销此账号，跳转到登录界面
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAlipay"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuisongshezhi"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cheknewpush"];
            
            //[[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM users"];
            int count = 0;
            while ([stmt step] == SQLITE_ROW) {
                count++;
            }
            [stmt reset];
            for (int i = 0; i < count; i++) {
                User *user = [User getLastUser];
                [User deleteFromDB:user.user_id];
                
            }
            NSLog(@"%@",[[[Info getInstance]mUserInfo] nick_name]);
            Info *info = [Info getInstance];
            info.login_name = @"";
            info.userId = @"";
            info.nickName = @"";
            info.userName = @"";
            info.isbindmobile = @"";
            info.authentication = @"";
            info.userName = @"";
            info.requestArray = nil;
            info.mUserInfo = nil;
            [ASIHTTPRequest setSessionCookies:nil];
            //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
            [[Info getInstance] setMUserInfo:nil];
            [ASIHTTPRequest clearSession];
            [GC_UserInfo sharedInstance].personalData = nil;
            [GC_HttpService sharedInstance].sessionId = nil;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
            [GC_UserInfo sharedInstance].accountManage = nil;
            
#ifdef isCaiPiaoForIPad
            
            
            caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
            UINavigationController *a = (UINavigationController *)appcaibo.window.rootViewController;
            NSArray * views = a.viewControllers;
            UIViewController * newhome = [views objectAtIndex:0];
            if ([newhome isKindOfClass:[IpadRootViewController class]]) {
                UIButton * hobutton = [UIButton buttonWithType:UIButtonTypeCustom];
                hobutton.tag = 1;
                [(IpadRootViewController *)newhome pressMenuButton:hobutton];
            }
            
            
            //            GouCaiViewController *gou = [[GouCaiViewController alloc] init];
            //            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:gou animated:NO];
            //            [gou release];
            
#else
            
//            [self.navigationController popViewControllerAnimated:YES];
            
            [[caiboAppDelegate getAppDelegate] goNewHomeView];
#endif
            
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if (alertView.tag == 997) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
            
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
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:test animated:YES];
                [test release];
            }else{
                PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:pwinfo animated:YES];
                [pwinfo release];
                
            }
        }else{
            
//            [self presstouzhubut];
//            [self tixianFunc];
            AccountDrawalViewController *drawal = [[AccountDrawalViewController alloc] init];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue] == 0 &&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
            {
                drawal.isNotPer = NO;
            }
            else
            {
                drawal.isNotPer = YES;
            }
            drawal.password = self.passWord;
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:drawal animated:YES];
            [drawal release];
        }
        
    }
    if (alertView.tag == 998) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
            
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
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:test animated:YES];
                [test release];
            }else{
                PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:pwinfo animated:YES];
                [pwinfo release];
                
            }
        }else{
            
            // 现金流水
            GCXianJinLiuShuiController * xianj = [[GCXianJinLiuShuiController alloc] init];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:xianj animated:YES];
            [xianj release];
            
        }
        
    }
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            self.passWord = message;
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
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                    //                    [alert show];
                    //                    [alert release];
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }
    
    if(alertView.tag == 1231){
    
        if(buttonIndex == 0){

            [self pingfen];
        }
    
    }
    if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            self.passWord = message;
            [self.httpRequest clearDelegatesAndCancel];
            
            NSString *name = [[Info getInstance] login_name];
//            NSString *password = self.passWord;
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }
    }
    if (alertView.tag == 10) {
        
        if (buttonIndex == 1) {
            self.passWord = message;
            [self.httpRequest clearDelegatesAndCancel];
            NSString *name = [[Info getInstance] login_name];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
            [httpRequest setTimeOutSeconds:20.0];
            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
            [httpRequest setDidFailSelector:@selector(recivedFail:)];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest startAsynchronous];
            
        }

    }
    if(alertView.tag == 200)//完善信息
    {
        if (buttonIndex == 1) {
            BOOL selbol;
            if ([[Info getInstance] userId] == nil || [[[Info getInstance] userId] isEqualToString:@""]) {
                selbol = NO;
            }else{
                selbol = YES;
            }
            if (selbol && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {//
                
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 111;
                [alert show];
                [alert release];
            }
            else {
                ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
                [proving release];
            }
        }
        
    }
    if (alertView.tag == 106) {//参加活动
        if (buttonIndex == 1) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 111;
                [alert show];
                [alert release];
                
            }
            else {
                
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
                [proving release];
                
            }
//            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alert.alertTpye = passWordType;
//            alert.tag = 111;
//            [alert show];
//            [alert release];
        }
    }
    
    if (alertView.tag == 99) {
        
        if (buttonIndex == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"appstoreurl"];
            
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        
        
        
    }

}


#pragma mark -
#pragma mark View lifecycle
- (void)LoadiPhoneView {

    [MobClick event:@"event_wodecaipiao"];

    

    
	backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243.0/255.0 alpha:1];
	backImageV.frame = self.mainView.bounds;
    backImageV.userInteractionEnabled = YES;
    backImageV.tag = 1132;
	[self.mainView addSubview:backImageV];
	[backImageV release];
   
    // 背景图
    _index = 0;
    btnbackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -85, 320, 197)];
    btnbackImage.userInteractionEnabled = YES;
    btnbackImage.image = UIImageGetImageFromName(@"mycp_gb.png");
    [backImageV addSubview:btnbackImage];
    [btnbackImage release];
    
    
    //  +*****积分+45
    myScrollView = [[GCScrollView alloc] initWithFrame:self.mainView.bounds];
    myScrollView.delegate = self;
    myScrollView.delegatea = self;
    myScrollView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 680-45);
    myScrollView.delaysContentTouches = NO;
//    myScrollView.canCancelContentTouches = NO;
    myScrollView.bounces = YES;
    
    
    // 初始化时间  如果失败，返回 “未更新”
    [refreshHeaderView refreshLastUpdatedDate];
    
    Presshidden = [UIButton buttonWithType:UIButtonTypeCustom];
    Presshidden.frame = myScrollView.bounds;
    [Presshidden addTarget:self action:@selector(JLhidden) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:Presshidden];
    
    

    
    // 刷新
    CBRefreshTableHeaderView *headerview =
    [[CBRefreshTableHeaderView alloc]
     initWithFrame:CGRectMake(0, -(myScrollView.frame.size.height), myScrollView.frame.size.width, myScrollView.frame.size.height) andIsChangeRefresh:YES];
    self->mRefreshView = headerview;
    mRefreshView.backgroundColor = [UIColor clearColor];
    mRefreshView.delegate = self;
    [myScrollView addSubview:mRefreshView];
    [headerview release];
    
    
    
    // 加余额奖励等三个按钮
    btnbackImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0  , 0, 320, 112)];
    btnbackImage2.backgroundColor = [UIColor clearColor];
    btnbackImage2.userInteractionEnabled = YES;
    [myScrollView addSubview:btnbackImage2];
	[btnbackImage2 release];
	
	
    UIImageView *headerimage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 17.5, 17.5)];
    headerimage.backgroundColor = [UIColor clearColor];
    headerimage.image = UIImageGetImageFromName(@"mycp_headerimage.png");
    [btnbackImage2 addSubview:headerimage];
    [headerimage release];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(headerimage)+7, 20, 200, 17.5)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = [[Info getInstance] nickName];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font= [UIFont boldSystemFontOfSize:12];
    [btnbackImage2 addSubview:nameLabel];
    [nameLabel release];
    
    
    // 余额
    zhangLabel = [[UILabel alloc] init];
    zhangLabel.backgroundColor = [UIColor clearColor];
	zhangLabel.font = [UIFont boldSystemFontOfSize:15];
	zhangLabel.frame = CGRectMake(15, ORIGIN_Y(headerimage)+16.5, 35, 15);
	zhangLabel.textColor = [UIColor whiteColor];
	zhangLabel.textAlignment = NSTextAlignmentLeft;
    zhangLabel.text = @"余额";
    zhangLabel.hidden = NO;
    [btnbackImage2 addSubview:zhangLabel];
	[zhangLabel release];
    
    
    zhanghuLabel = [[UILabel alloc] init];
	zhanghuLabel.backgroundColor = [UIColor clearColor];
    zhanghuLabel.font = [UIFont systemFontOfSize:21];
	zhanghuLabel.frame = CGRectMake(ORIGIN_X(zhangLabel)+7, ORIGIN_Y(headerimage)+10.5, 0, 21);
	zhanghuLabel.textAlignment = NSTextAlignmentLeft;
    zhanghuLabel.textColor = [UIColor whiteColor];
    [btnbackImage2 addSubview:zhanghuLabel];
    [zhanghuLabel release];
    
    yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(zhanghuLabel)+7, zhangLabel.frame.origin.y, 15, 15)];
    yuanLabel.backgroundColor = [UIColor clearColor];
    yuanLabel.font = [UIFont boldSystemFontOfSize:15];
    yuanLabel.textColor = [UIColor whiteColor];
    yuanLabel.text = @"元";
    [btnbackImage2 addSubview:yuanLabel];
    [yuanLabel release];
    



    //奖励
	jiangLabel = [[[UILabel alloc] init] autorelease];
	jiangLabel.backgroundColor = [UIColor clearColor];
	jiangLabel.font = [UIFont boldSystemFontOfSize:15];
	jiangLabel.frame = CGRectMake(15, ORIGIN_Y(zhangLabel)+16.5, 35, 15);
    jiangLabel.textColor = [UIColor whiteColor];
	jiangLabel.textAlignment = NSTextAlignmentLeft;
	jiangLabel.text = @"奖励";
    jiangLabel.hidden  = YES;
    [btnbackImage2 addSubview:jiangLabel];
    
    
    
	jiangliLabel = [[UILabel alloc] init];
	jiangliLabel.backgroundColor = [UIColor clearColor];
	jiangliLabel.font = [UIFont systemFontOfSize:15];
	jiangliLabel.frame = CGRectMake(ORIGIN_X(jiangLabel)+7, ORIGIN_Y(zhangLabel)+16.5, 45, 15);
	jiangliLabel.textColor = [UIColor whiteColor];
    jiangliLabel.hidden = YES;
	jiangliLabel.textAlignment = NSTextAlignmentCenter;
    jiangliLabel.userInteractionEnabled = YES;
    [btnbackImage2 addSubview:jiangliLabel];
    
    
    
    //冻结
    dongLabelN= [[UILabel alloc] init];
    dongLabelN.backgroundColor = [UIColor clearColor];
	dongLabelN.font = [UIFont boldSystemFontOfSize:15];
	dongLabelN.frame = CGRectMake(130, ORIGIN_Y(zhangLabel)+16.5 , 35, 15);
	dongLabelN.text = @"冻结";
    dongLabelN.hidden = YES;
	dongLabelN.textColor = [UIColor whiteColor];
	dongLabelN.textAlignment = NSTextAlignmentLeft;
    [btnbackImage2 addSubview:dongLabelN];
	
	dongjieLabel = [[UILabel alloc] init];
	dongjieLabel.backgroundColor = [UIColor clearColor];
	dongjieLabel.font = [UIFont systemFontOfSize:15];
    dongjieLabel.hidden = YES;
	dongjieLabel.frame = CGRectMake(ORIGIN_X(dongLabelN)+7, ORIGIN_Y(zhangLabel)+16.5, 60, 15);
	dongjieLabel.textAlignment = NSTextAlignmentCenter;
    dongjieLabel.textColor = [UIColor whiteColor];
	[self performSelector:@selector(getPersonalInfoRequest) withObject:nil afterDelay:0.1];
    [btnbackImage2 addSubview:dongjieLabel];
    [dongjieLabel release];
    
    
    btnbackImage2.userInteractionEnabled = YES;
    helpDJBtn = [[UIButton alloc] init];
    helpDJBtn.hidden = YES;
    helpDJBtn.frame = CGRectMake(ORIGIN_X(dongjieLabel) - 9, ORIGIN_Y(zhangLabel) + 2, 40, 40);
    [helpDJBtn addTarget:self action:@selector(helpDJBtnClick) forControlEvents:UIControlEventTouchUpInside];
    helpDJBtn.backgroundColor = [UIColor clearColor];
    [btnbackImage2 addSubview:helpDJBtn];
    
    UIImageView * helpImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((40 - 12)/2, (40 - 12)/2 + 2, 12.5, 12.5)] autorelease];
    helpImageView.image = UIImageGetImageFromName(@"gp-wodecaipiaowenhao_1.png");
    [helpDJBtn addSubview:helpImageView];
    
    // 我的彩票
    bgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(btnbackImage2), 320, 780-45)];
    bgView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249/255.0 blue:243.0/255.0 alpha:1];
    bgView.userInteractionEnabled = YES;
    [myScrollView addSubview:bgView];
    
    UIImageView *szImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 78)];
    szImage.backgroundColor = [UIColor whiteColor];
    szImage.userInteractionEnabled = YES;
    [bgView addSubview:szImage];
    [szImage release];

    
    UIView *quanBuCaiPiaoXian0 = [[UIView alloc] initWithFrame:CGRectMake(0, 78, 320, 0.5)];
    quanBuCaiPiaoXian0.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [szImage addSubview:quanBuCaiPiaoXian0];
    [quanBuCaiPiaoXian0 release];

    
    //全部彩票
    aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutBtn.frame = CGRectMake(0, 0, 80, 78);
    aboutBtn.tag = 0;
    [aboutBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [aboutBtn setBackgroundImage:UIImageGetImageFromName(@"mycp_btnSelected.png") forState:UIControlStateHighlighted];
    [szImage addSubview:aboutBtn];
    
    quanBuCaiPiaoImageView = [[[DownLoadImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)] autorelease];
    quanBuCaiPiaoImageView.image = UIImageGetImageFromName(@"mycp_allcp.png");
    [aboutBtn addSubview:quanBuCaiPiaoImageView];
    quanBuCaiPiaoImageView.backgroundColor = [UIColor clearColor];
    
    UILabel *gylab = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(quanBuCaiPiaoImageView)+6, 80, 12)];
    gylab.textAlignment = NSTextAlignmentCenter;
    gylab.text = @"全部彩票";
    gylab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1];
    gylab.font = [UIFont systemFontOfSize:12];
    gylab.backgroundColor = [UIColor clearColor];
    [aboutBtn addSubview:gylab];
    [gylab release];
    
    //中奖彩票
    UIButton *zjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zjBtn.frame = CGRectMake(80, 0, 80, 78);
    zjBtn.tag = 1;
    [zjBtn setBackgroundImage:UIImageGetImageFromName(@"mycp_btnSelected.png") forState:UIControlStateHighlighted];
    [zjBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [szImage addSubview:zjBtn];
    
    zhongJiangCaiPiaoImage = [[[DownLoadImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)] autorelease];
    zhongJiangCaiPiaoImage.backgroundColor = [UIColor clearColor];
    zhongJiangCaiPiaoImage.image = UIImageGetImageFromName(@"mycp_zjcp.png");
    [zjBtn addSubview:zhongJiangCaiPiaoImage];
    
    
    UILabel *zjlab = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(zhongJiangCaiPiaoImage)+6, 80, 12)];
    zjlab.text = @"中奖彩票";
    zjlab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1];
    zjlab.textAlignment = NSTextAlignmentCenter;
    zjlab.font = [UIFont systemFontOfSize:12];
    zjlab.backgroundColor = [UIColor clearColor];
    [zjBtn addSubview:zjlab];
    [zjlab release];
    
    //合买彩票
//    UIButton *hmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    hmBtn.frame = CGRectMake(160, 0, 80, 78);;
//    hmBtn.tag = 3;
//    [hmBtn setBackgroundImage:UIImageGetImageFromName(@"mycp_btnSelected.png") forState:UIControlStateHighlighted];
//
//    [hmBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [szImage addSubview:hmBtn];
//    
//    heMaiCaiPiaoImage = [[[DownLoadImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)] autorelease];
//    heMaiCaiPiaoImage.backgroundColor = [UIColor clearColor];
//    heMaiCaiPiaoImage.image = UIImageGetImageFromName(@"mycp_hecp.png");
//    [hmBtn addSubview:heMaiCaiPiaoImage];
//    
//    
//    UILabel *hmlab = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(heMaiCaiPiaoImage)+6, 80, 12)];
//    hmlab.text = @"合买彩票";
//    hmlab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1];
//    hmlab.textAlignment = NSTextAlignmentCenter;
//    hmlab.font = [UIFont systemFontOfSize:12];
//    hmlab.backgroundColor = [UIColor clearColor];
//    [hmBtn addSubview:hmlab];
//    [hmlab release];
//    
//    //我的追号
//    UIButton *zhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    zhBtn.frame = CGRectMake(240, 0, 80, 78);
//    zhBtn.tag = 2;
//    [zhBtn setBackgroundImage:UIImageGetImageFromName(@"mycp_btnSelected.png") forState:UIControlStateHighlighted];
//    [zhBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [szImage addSubview:zhBtn];
//    
//    zhuihaoCaiPiaoImage = [[[DownLoadImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)] autorelease];
//    zhuihaoCaiPiaoImage.backgroundColor = [UIColor clearColor];
//    zhuihaoCaiPiaoImage.image = UIImageGetImageFromName(@"mycp_myzh.png");
//    [zhBtn addSubview:zhuihaoCaiPiaoImage];
//    
//    
//    UILabel *zhlab = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(zhuihaoCaiPiaoImage)+6, 80, 12)];
//    zhlab.text = @"我的追号";
//    zhlab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1];
//    zhlab.textAlignment = NSTextAlignmentCenter;
//    zhlab.font = [UIFont systemFontOfSize:12];
//    zhlab.backgroundColor = [UIColor clearColor];
//    [zhBtn addSubview:zhlab];
//    [zhlab release];
    
    

    
//    UIImageView *jianTouImage = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
//    jianTouImage.image  = [UIImage imageNamed:@"chongzhijian.png"];
//    [zhBtn addSubview:jianTouImage];
    
    UIImageView *jianTouImage1 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage1.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage2 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage2.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    
    UIImageView *jianTouImage3 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage3.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage4 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage4.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage5 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage5.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage6 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage6.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    
    UIImageView *jianTouImage7 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage7.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage8 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage8.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage9 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage9.image  = [UIImage imageNamed:@"chongzhijian.png"];
    
    UIImageView *jianTouImage10 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage10.image  = [UIImage imageNamed:@"chongzhijian.png"];
   
    UIImageView *jianTouImage11 = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 15, 8, 12)] autorelease];
    jianTouImage11.image  = [UIImage imageNamed:@"chongzhijian.png"];
    

    
    

    
    // 充值背景
    UIView *czView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(quanBuCaiPiaoXian0)+10, 320, 45*3)];
    czView.backgroundColor = [UIColor whiteColor];
    czView.userInteractionEnabled = YES;
    [bgView addSubview:czView];
    czView.userInteractionEnabled = YES;
    [czView release];

    
    UIView *czXian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    czXian.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [czView addSubview:czXian];
    [czXian release];
    
    UIView *czXian1 = [[UIView alloc] initWithFrame:CGRectMake(15, 45, 305, 0.5)];
    czXian1.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [czView addSubview:czXian1];
    [czXian1 release];
    
    UIView *czXian2 = [[UIView alloc] initWithFrame:CGRectMake(15, 45*2, 305, 0.5)];
    czXian2.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [czView addSubview:czXian2];
    [czXian2 release];
    
    UIView *czXian3 = [[UIView alloc] initWithFrame:CGRectMake(0, 45*3, 320, 0.5)];
    czXian3.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [czView addSubview:czXian3];
    [czXian3 release];
    
    
   
    
    UIButton *czNewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    czNewBtn.frame = CGRectMake(0, 0, 320, 45);
    czNewBtn.tag = 101;
    [czNewBtn setImage:UIImageGetImageFromName(@"mycp_chongzhi.png") forState:UIControlStateNormal];
    [czNewBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    [czNewBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [czView addSubview:czNewBtn];
    
    UILabel *czNewlab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 45)];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
        czNewlab.text = @"支付宝充值";
    }else{
        czNewlab.text = @"充       值";
    }
    czNewlab.font = [UIFont systemFontOfSize:15];
    czNewlab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    czNewlab.backgroundColor = [UIColor clearColor];
    [czView addSubview:czNewlab];
    [czNewlab release];
    [czNewBtn addSubview:jianTouImage10];
    
    
    
    UIButton *tkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tkBtn.frame = CGRectMake(0, 45, 320, 45);
    tkBtn.tag = 12;
    [tkBtn setImage:UIImageGetImageFromName(@"mycp_tixian.png") forState:UIControlStateNormal];
    [tkBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    [tkBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [czView addSubview:tkBtn];
    UILabel *tklab = [[UILabel alloc] initWithFrame:CGRectMake(45, 45, 100, 45)];
    tklab.text = @"提       现";
    tklab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    tklab.font = [UIFont systemFontOfSize:15];
    tklab.backgroundColor = [UIColor clearColor];
    [czView addSubview:tklab];
    [tklab release];
    [tkBtn addSubview:jianTouImage11];

    UIButton *xjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xjBtn.frame = CGRectMake(0, 45*2, 320, 45);
    xjBtn.tag = 10;
    [xjBtn setImage:UIImageGetImageFromName(@"mycp_xianjin.png") forState:UIControlStateNormal];
    [xjBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    [xjBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [czView addSubview:xjBtn];
    UILabel *xjlab = [[UILabel alloc] initWithFrame:CGRectMake(45, 45*2, 100, 45)];
    xjlab.text = @"现金流水";
    xjlab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    xjlab.font = [UIFont systemFontOfSize:15];
    xjlab.backgroundColor = [UIColor clearColor];
    [czView addSubview:xjlab];
    [xjlab release];
    [xjBtn addSubview:jianTouImage1];
    
    
//
//    selfHelpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(268, 11, 22, 22)];
//    selfHelpImageView.backgroundColor = [UIColor clearColor];
//    selfHelpImageView.image = UIImageGetImageFromName(@"wodecaipiao-xinxitishi_1.png");
//    selfHelpImageView.hidden = YES;
//    [zlImage addSubview:selfHelpImageView];
//    [selfHelpImageView release];
//    
//    UILabel *selfHelpNo = [[UILabel alloc] initWithFrame:selfHelpImageView.bounds];
//    selfHelpNo.text = @"1";
//    selfHelpNo.font = [UIFont boldSystemFontOfSize:15];
//    selfHelpNo.backgroundColor = [UIColor clearColor];
//    selfHelpNo.textAlignment = NSTextAlignmentCenter;
//    selfHelpNo.textColor = [UIColor whiteColor];
//    [selfHelpImageView addSubview:selfHelpNo];
//    [selfHelpNo release];
//    
//
//    UIButton *selfHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [selfHelpButton addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [zlImage addSubview:selfHelpButton];
//    selfHelpButton.tag = 29;
//    [selfHelpButton setImage:UIImageGetImageFromName(@"wodecaipiao-zizhufuwu_1.png") forState:UIControlStateNormal];
//    [selfHelpButton setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    selfHelpButton.frame = CGRectMake(0, 45, 320, 45);
//    [selfHelpButton addSubview:jianTouImage6];
//    
//    
//    UILabel *selfHelpLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 45, 100, 45)];
//    selfHelpLabel.text = @"自助服务";
//    selfHelpLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    selfHelpLabel.font = [UIFont systemFontOfSize:15];
//    selfHelpLabel.backgroundColor = [UIColor clearColor];
//    [zlImage addSubview:selfHelpLabel];
//    [selfHelpLabel release];
//    
//    
//    // ***积分Btn
//    UIButton *jfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    jfBtn.frame = CGRectMake(0, 45*2, 320, 45);
//    jfBtn.tag = 111;
//    [jfBtn setImage:UIImageGetImageFromName(@"wodecaipiao-jifen.png") forState:UIControlStateNormal];
//    [jfBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    [jfBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [zlImage addSubview:jfBtn];
//    [jfBtn addSubview:jianTouImage3];
//    
//    UILabel *jfLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 45)];
//    jfLabel.text = @"积       分";
//    jfLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    jfLabel.font = [UIFont systemFontOfSize:15];
//    jfLabel.backgroundColor = [UIColor clearColor];
//    [jfBtn addSubview:jfLabel];
//    [jfLabel release];
//    
//    
//    
//    jlButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    jlButton.frame = CGRectMake(0, 45*3, 320, 45);
//    [jlButton setImage:UIImageGetImageFromName(@"wodecaipiao-jianglihuodong_1.png") forState:UIControlStateNormal];
//    [jlButton setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    [jlButton setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12.5, 285)];
//    [jlButton addTarget:self action:@selector(pressJiangLiHuoDong) forControlEvents:UIControlEventTouchUpInside];
//    [zlImage addSubview:jlButton];
//    UILabel *jllab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 45)];
//    jllab.text = @"奖励活动";
//    jllab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    jllab.font = [UIFont systemFontOfSize:15];
//    // jllab.font = [UIFont fontWithName:@"Microsoft YaHei" size:14];
//    jllab.backgroundColor = [UIColor clearColor];
//    [jlButton addSubview:jllab];
//    [jllab release];
//    [jlButton addSubview:jianTouImage7];
//    
//    
//    
//    
//    
//    UIButton *cjbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    cjbBtn.frame = CGRectMake(0, 45*4, 320, 45);
//    cjbBtn.tag = 30;
//    [cjbBtn setImage:UIImageGetImageFromName(@"wodecaipiao-365licai_1.png") forState:UIControlStateNormal];
//    [cjbBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    [cjbBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [zlImage addSubview:cjbBtn];
//    UILabel *cjblab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 45)];
//    cjblab.text = @"365 理财";
//    cjblab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    cjblab.font = [UIFont systemFontOfSize:15];
//    cjblab.backgroundColor = [UIColor clearColor];
//    [cjbBtn addSubview:cjblab];
//    [cjblab release];
//    [cjbBtn addSubview:jianTouImage8];

    
   
    
    // 个人信息
    UIImageView *lcImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(czView)+10, 320, 45 * 2)];
    lcImage.backgroundColor = [UIColor whiteColor];
    lcImage.userInteractionEnabled = YES;
    [bgView addSubview:lcImage];
    [lcImage release];
    
    
    UIView *lcXian0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lcXian0.backgroundColor  = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [lcImage addSubview:lcXian0];
    [lcXian0 release];
    UIView *lcXian1 = [[ UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 0.5)];
    lcXian1.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [lcImage addSubview:lcXian1];
    [lcXian1 release];
    
//    UIView *lcXian2 = [[ UIView alloc] initWithFrame:CGRectMake(15, 45*2, 305, 0.5)];
//    lcXian2.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
//    [lcImage addSubview:lcXian2];
//    [lcXian2 release];
   
    // 去修改头像
//    UIView *lcXian3 = [[ UIView alloc] initWithFrame:CGRectMake(15, 45*3, 320, 0.5)];
//    lcXian3.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
//    [lcImage addSubview:lcXian3];
//    [lcXian3 release];
    
//    UIView *lcXian4 = [[UIView alloc] initWithFrame:CGRectMake(0, 45*3, 320, 0.5)];
//    lcXian4.backgroundColor  = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
//    [lcImage addSubview:lcXian4];
//    [lcXian4 release];
    
  
    notPerImage = [[UIImageView alloc] initWithFrame:CGRectMake(230, 13, 52, 18.5)];
    notPerImage.image = UIImageGetImageFromName(@"mycp_notPerfectbg.png");
    notPerImage.backgroundColor = [UIColor clearColor];
    [lcImage addSubview:notPerImage];
    [notPerImage release];
    

    UILabel *notPerfect = [[[UILabel alloc] init] autorelease];
    notPerfect.backgroundColor = [UIColor clearColor];
    notPerfect.frame = CGRectMake(3, 0, 45, 18.5);
    notPerfect.text = @"未完善";
    notPerfect.textAlignment = NSTextAlignmentCenter;
    notPerfect.textColor = [UIColor whiteColor];
    notPerfect.font = [UIFont systemFontOfSize:14];
    [notPerImage addSubview:notPerfect];
    
    
    
    
    UIButton *xxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xxBtn.frame = CGRectMake(0, 0, 320, 45);
    xxBtn.tag = 20;
    [xxBtn setImage:UIImageGetImageFromName(@"gerenxinxi_1.png") forState:UIControlStateNormal];
    [xxBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    [xxBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [lcImage addSubview:xxBtn];
    UILabel *grlab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 100, 45)];
    grlab.text = @"个人信息";
    grlab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    grlab.font = [UIFont systemFontOfSize:15];
    grlab.backgroundColor = [UIColor clearColor];
    [lcImage addSubview:grlab];
    [grlab release];
    [xxBtn addSubview:jianTouImage2];
    
//    yqButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    yqButton.frame = CGRectMake(0, 45, 320, 45);
//    [yqButton setImage:UIImageGetImageFromName(@"wodecaipiao-yaoqing_1.png") forState:UIControlStateNormal];
//    [yqButton setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    [yqButton addTarget:self action:@selector(pressYaoQing) forControlEvents:UIControlEventTouchUpInside];
//    [lcImage addSubview:yqButton];
//    UILabel *jllab3 = [[UILabel alloc] initWithFrame:CGRectMake(45, 45, 100, 45)];
//    jllab3.text = @"邀请好友";
//    jllab3.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    jllab3.font = [UIFont systemFontOfSize:15];
//    jllab3.backgroundColor = [UIColor clearColor];
//    [lcImage addSubview:jllab3];
//    [jllab3 release];
//    [yqButton addSubview:jianTouImage5];
    
//    UIButton *touxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    touxBtn.frame = CGRectMake(0, 45*2, 320, 45);
//    touxBtn.tag = 21;
//    [touxBtn setImage:UIImageGetImageFromName(@"wodecaipiao-xiugaitouxiang_1.png") forState:UIControlStateNormal];
//    [touxBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
//    [touxBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
//    [lcImage addSubview:touxBtn];
//    UILabel *touxlab = [[UILabel alloc] initWithFrame:CGRectMake(45, 45*2, 100, 45)];
//    touxlab.text = @"修改头像";
//    touxlab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
//    touxlab.font = [UIFont systemFontOfSize:15];
//    touxlab.backgroundColor = [UIColor clearColor];
//    [lcImage addSubview:touxlab];
//    [touxlab release];
//    [touxBtn addSubview:jianTouImage3];
    
    
    
    
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordButton addTarget:self action:@selector(Presschangepassword) forControlEvents:UIControlEventTouchUpInside];
    [lcImage addSubview:passwordButton];
    [passwordButton setImage:UIImageGetImageFromName(@"xiugaimima_1.png") forState:UIControlStateNormal];
    [passwordButton setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    passwordButton.frame = CGRectMake(0, 45, 320, 45);
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 45, 100, 45)];
    passwordLabel.text = @"修改密码";
    passwordLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    passwordLabel.font = [UIFont systemFontOfSize:15];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [lcImage addSubview:passwordLabel];
    [passwordLabel release];
    [passwordButton addSubview: jianTouImage4];
    
    // +客服背景
    UIImageView *zlImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(lcImage)+10, 320, 45)];
    zlImage.backgroundColor = [UIColor whiteColor];
    zlImage.userInteractionEnabled = YES;
    [bgView addSubview:zlImage];
    [zlImage release];
    
    UIView *xianJinLiuShuiXian0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    xianJinLiuShuiXian0.backgroundColor  = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [zlImage addSubview:xianJinLiuShuiXian0];
    [xianJinLiuShuiXian0 release];
    
    UIView *xianJinLiuShuiXian1 = [[ UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 0.5)];
    xianJinLiuShuiXian1.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    [zlImage addSubview:xianJinLiuShuiXian1];
    [xianJinLiuShuiXian1 release];
    
    
    UIButton *kfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    kfBtn.frame = CGRectMake(0, 0, 320, 45);
    kfBtn.tag = 50;
    kfBtn.enabled = NO;
    [kfBtn setImage:UIImageGetImageFromName(@"mycp_kf.png") forState:UIControlStateNormal];
    [kfBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 13, 285)];
    [kfBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zlImage addSubview:kfBtn];
    UILabel *kflab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 45)];
    kflab.text = @"客服QQ:3254056760";
    kflab.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
    kflab.font = [UIFont systemFontOfSize:15];
    kflab.backgroundColor = [UIColor clearColor];
    [kfBtn addSubview:kflab];
    [kflab release];
    
    exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setFrame:CGRectMake(60, ORIGIN_Y(zlImage) + 10, 200, 45)];
    [exitLoginButton addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    [exitLoginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    exitLoginButton.titleLabel.font = [UIFont systemFontOfSize:18];
    exitLoginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [exitLoginButton setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
    [exitLoginButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    
    
    [bgView addSubview:exitLoginButton];

    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {
        
        passwordButton.hidden = YES;
        passwordLabel.hidden = YES;
        lcImage.frame = CGRectMake(0, lcImage.frame.origin.y, 320, 90-45);
//        lcXian4.frame  = CGRectMake(0, 45*2, 320, 0.5);
        zlImage.frame = CGRectMake(0, ORIGIN_Y(lcImage)+10, 320, 45);
        [exitLoginButton setFrame:CGRectMake(60, ORIGIN_Y(zlImage) + 10, 200, 45)];
        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 680-45*2);
        
    }
    

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"caijinbaomake"] == 0 ) {
        dianCjbImage.hidden = NO;
    }else{
        dianCjbImage.hidden = YES;
    }

    
    
    // 刷新 refresh
    // 加载 下拉刷新控件
//	if (refreshHeaderView==nil) {
//		
//		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, self.mainView.frame.size.width, self.mainView.frame.size.height)];
//		headerview.backgroundColor = [UIColor clearColor];
//		headerview.delegate = self;
//		[myScrollView addSubview:headerview];
//		refreshHeaderView = headerview;
//		[headerview release];
//		
//	}
    

    [bgView release];
    //获取是否是7天活动
    [self getSevenDayInfo];
    
}


- (void)helpDJBtnClick
{

//    FAQView *faq = [[[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
//    faq.faqdingwei = dongJie;
//    [faq Show];
    QuestionViewController *quest = [[[QuestionViewController alloc] init] autorelease];
    quest.question = dongJieType;
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:quest animated:YES];

    
    
    
}


//评分
-(void)pingfen
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    

    
}

//奖励活动
- (void)pressJiangLiHuoDong{
    [MobClick event:@"event_wodecaipiao_jianglihuodong"];

    NSString *version =[NSString stringWithFormat:@"%@_pingfen",[[Info getInstance] cbVersion]];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:version]);
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:version] integerValue] == 0){
    
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒" message:@"亲,赏个评价我们会更努力!" delegate:self cancelButtonTitle:@"赞一个" otherButtonTitles:@"残忍的拒绝",nil];
        alert.tag = 1231;
        [alert show];
        [alert release];
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:version];

        
    }
    else{
    
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        JiangLiHuoDongViewController *jl = [[[JiangLiHuoDongViewController alloc] init] autorelease];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:jl animated:YES];
    }
    

}
- (void)appStoreButton:(UIButton *)sender{

    
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"appstoreurl"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"appstoreurl"] intValue] != 1) {
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"投注站" message:@"请赐个5星评价吧,小主\n回来有奖励哦~" delegate:self cancelButtonTitle:@"小主很忙" otherButtonTitles:@"赐个5星", nil];
//        alert.tag = 99;
//        [alert show];
//        [alert release];
//    }else{
    
//        [self pressJiangLiHuoDong];
    
    
//    }
    
   
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}




#pragma mark - 设置按钮的点击事件




- (void)LoadiPadView {

    self.title = [NSString stringWithFormat:@"%@",[[Info getInstance] nickName]];
    [self.navigationItem setHidesBackButton:YES];
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    //更换导航栏
    //    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 390, 44)];
    //    imageV.image = UIImageGetImageFromName(@"daohang.png");
    //    imageV.tag = 101;
    //    [self.navigationController.navigationBar addSubview:imageV];
    //    [imageV release];
    
    //[self.navigationController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohang.png") forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:backImage];
    [backImage release];
    
    
    exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
    [exitLoginButton addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [exitLoginButton addSubview:imagevi];
    [imagevi release];
    
    UILabel *beginLabel = [[UILabel alloc] initWithFrame:exitLoginButton.bounds];
    beginLabel.backgroundColor = [UIColor clearColor];
    beginLabel.textColor = [UIColor whiteColor];
    beginLabel.text = @"退出登录";
    beginLabel.font = [UIFont systemFontOfSize:12];
    beginLabel.textAlignment = NSTextAlignmentCenter;
    [exitLoginButton addSubview:beginLabel];
    [beginLabel release];
    

    
    
	UIImageView *btnbackImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 30, 300, 60)];
	btnbackImage3.image = UIImageGetImageFromName(@"wodecaipiao02.png");
    btnbackImage3.userInteractionEnabled = YES;
    [self.mainView addSubview:btnbackImage3];
	[btnbackImage3 release];
    
    btnbackImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 228.5, 45)];
	btnbackImage2.image = UIImageGetImageFromName(@"wodecaipiao03.png");
    btnbackImage2.userInteractionEnabled = YES;
    [btnbackImage addSubview:btnbackImage2];
	[btnbackImage2 release];
    
	zhangLabel = [[UILabel alloc] init];
    zhangLabel.backgroundColor = [UIColor clearColor];
	zhangLabel.font = [UIFont systemFontOfSize:14];
	zhangLabel.frame = CGRectMake(0, 3, 77, 18);
	zhangLabel.textColor = [UIColor whiteColor];
	zhangLabel.textAlignment = NSTextAlignmentCenter;
    zhangLabel.text = @"账户余额";
    zhangLabel.hidden = NO;
    [btnbackImage2 addSubview:zhangLabel];
	[zhangLabel release];
	
	zhanghuLabel = [[UILabel alloc] init];
	zhanghuLabel.backgroundColor = [UIColor clearColor];
	zhanghuLabel.font = [UIFont systemFontOfSize:14];
	zhanghuLabel.frame = CGRectMake(0, 25, 77, 18);
	zhanghuLabel.textAlignment = NSTextAlignmentCenter;
    [btnbackImage2 addSubview:zhanghuLabel];
    
	UILabel *jiangLabel1 = [[UILabel alloc] init];
	jiangLabel1.backgroundColor = [UIColor clearColor];
	jiangLabel1.font = [UIFont systemFontOfSize:14];
	jiangLabel1.frame = CGRectMake(80, 3, 77, 18);
	jiangLabel1.text = @"奖励";
	jiangLabel1.textColor = [UIColor whiteColor];
	jiangLabel1.textAlignment = NSTextAlignmentCenter;
    [btnbackImage2 addSubview:jiangLabel1];
	[jiangLabel1 release];
    
	jiangliLabel = [[UILabel alloc] init];
	jiangliLabel.backgroundColor = [UIColor clearColor];
	jiangliLabel.font = [UIFont systemFontOfSize:14];
	jiangliLabel.frame = CGRectMake(83, 22, 77, 18);
	jiangliLabel.textColor = [UIColor redColor];
	jiangliLabel.textAlignment = NSTextAlignmentCenter;
    jiangliLabel.userInteractionEnabled = YES;
    [btnbackImage2 addSubview:jiangliLabel];
    
	UILabel *dongLabel = [[UILabel alloc] init];
    dongLabel.backgroundColor = [UIColor clearColor];
	dongLabel.font = [UIFont systemFontOfSize:14];
	dongLabel.frame = CGRectMake(160, 3, 77, 18);
	dongLabel.text = @"冻结";
	dongLabel.textColor = [UIColor whiteColor];
	dongLabel.textAlignment = NSTextAlignmentCenter;
    [btnbackImage2 addSubview:dongLabel];
	[dongLabel release];
	
	dongjieLabel = [[UILabel alloc] init];
	dongjieLabel.backgroundColor = [UIColor clearColor];
	dongjieLabel.font = [UIFont systemFontOfSize:14];
	dongjieLabel.frame = CGRectMake(160, 25, 77, 18);
	dongjieLabel.textAlignment = NSTextAlignmentCenter;
	[self performSelector:@selector(getPersonalInfoRequest) withObject:nil afterDelay:0.1];
    [btnbackImage2 addSubview:dongjieLabel];
	
	
    
    UIButton * refreshbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshbtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [refreshbtn setImage:UIImageGetImageFromName(@"shuaxin.png") forState:UIControlStateNormal];
    [refreshbtn setImage:UIImageGetImageFromName(@"shuaxin-1.png") forState:UIControlStateHighlighted];
    refreshbtn.frame = CGRectMake(245, 5, 40.5, 43);
    [btnbackImage addSubview:refreshbtn];
    
    jlMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jlMoneyButton.frame = CGRectMake(4, 1, 72.5, 22.5);
    [jlMoneyButton setImage:UIImageGetImageFromName(@"lqjl960.png") forState:UIControlStateNormal];
    jlMoneyButton.userInteractionEnabled = YES;
    [jlMoneyButton addTarget:self action:@selector(pressjlMoney) forControlEvents:UIControlEventTouchUpInside];
    jlMoneyButton.hidden = YES;
    [btnbackImage2 addSubview:jlMoneyButton];
	
    jlMoneyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 60, 14)];
    jlMoneyLabel2.backgroundColor = [UIColor clearColor];
    jlMoneyLabel2.textColor = [UIColor whiteColor];
    jlMoneyLabel2.font = [UIFont boldSystemFontOfSize:13];
    jlMoneyLabel2.textAlignment = NSTextAlignmentCenter;
    jlMoneyLabel2.text = @"领取奖励";
    [jlMoneyButton addSubview:jlMoneyLabel2];
    jlMoneyLabel2.hidden = YES;
    [jlMoneyLabel2 release];
    
    jlMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 2, 15, 13)];
    jlMoneyLabel.backgroundColor = [UIColor clearColor];
    jlMoneyLabel.textColor = [UIColor redColor];
    jlMoneyLabel.font = [UIFont systemFontOfSize:11];
    jlMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [jlMoneyButton addSubview:jlMoneyLabel];
    jlMoneyLabel.hidden = YES;
    [jlMoneyLabel release];
    
    UIImageView *jlBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(45, 115, 300, 87)];
    jlBgImage.image = UIImageGetImageFromName(@"wodecaipiao07.png");
    jlBgImage.userInteractionEnabled = YES;
    [self.mainView addSubview:jlBgImage];
    [jlBgImage release];
    
    
    UIImageView *jlBgImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, 6, 257, 75)];
    jlBgImage2.image = UIImageGetImageFromName(@"wodecaipiao08.png");
    jlBgImage2.userInteractionEnabled = YES;
    [jlBgImage addSubview:jlBgImage2];
    [jlBgImage2 release];
    
    UIButton *jlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jlBtn.frame = CGRectMake(63, 10, 39, 39);
    [jlBtn setImage:UIImageGetImageFromName(@"jianglihuodong.png") forState:UIControlStateNormal];
    [jlBtn setImage:UIImageGetImageFromName(@"jianglihuodong-1.png") forState:UIControlStateHighlighted];
    [jlBtn addTarget:self action:@selector(pressJiangLiHuoDong) forControlEvents:UIControlEventTouchUpInside];
    [jlBgImage2 addSubview:jlBtn];
    UILabel *jllab = [[UILabel alloc] initWithFrame:CGRectMake(62, 47, 40+5, 15)];
    jllab.text = @"奖励活动";
    jllab.font = [UIFont systemFontOfSize:10];
    jllab.backgroundColor = [UIColor clearColor];
    [jlBgImage2 addSubview:jllab];
    [jllab release];
    
    //    UIButton *dzpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    dzpBtn.frame = CGRectMake(160, 10, 39, 39);
    //    [dzpBtn setImage:UIImageGetImageFromName(@"dazhuanpan.png") forState:UIControlStateNormal];
    //    [dzpBtn setImage:UIImageGetImageFromName(@"dazhuanpan-1.png") forState:UIControlStateHighlighted];
    //    [dzpBtn addTarget:self action:@selector(pressDZP) forControlEvents:UIControlEventTouchUpInside];
    //    [jlBgImage2 addSubview:dzpBtn];
    //    UILabel *zplab = [[UILabel alloc] initWithFrame:CGRectMake(165, 47, 40, 15)];
    //    zplab.text = @"大转盘";
    //    zplab.font = [UIFont systemFontOfSize:10];
    //    zplab.backgroundColor = [UIColor clearColor];
    //    [jlBgImage2 addSubview:zplab];
    //    [zplab release];
    
    
    
    
    //我的彩票
    UIImageView *szImage = [[UIImageView alloc] initWithFrame:CGRectMake(45, 212, 300, 87)];
    szImage.image = UIImageGetImageFromName(@"wodecaipiao07.png");
    szImage.userInteractionEnabled = YES;
    [self.mainView addSubview:szImage];
    [szImage release];
    UIImageView *szImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, 6, 257, 75)];
    szImage2.image = UIImageGetImageFromName(@"wodecaipiao08.png");
    szImage2.userInteractionEnabled = YES;
    [szImage addSubview:szImage2];
    [szImage2 release];
    
    UILabel *naLable3 = [[UILabel alloc] init];
    naLable3.numberOfLines = 0;
    naLable3.font = [UIFont boldSystemFontOfSize:12];
    naLable3.frame = CGRectMake(2, 7, 20, 72);
    naLable3.textAlignment = NSTextAlignmentCenter;
    naLable3.backgroundColor = [UIColor clearColor];
    naLable3.text = @"投注管理";
    naLable3.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    [szImage addSubview:naLable3];
    [naLable3 release];
    
    UIButton *aboutBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutBtn1.frame = CGRectMake(20, 10, 39, 39);
    aboutBtn1.tag = 0;
    [aboutBtn1 setImage:UIImageGetImageFromName(@"quanbucaipiao.png") forState:UIControlStateNormal];
    [aboutBtn1 setImage:UIImageGetImageFromName(@"quanbucaipiao-1.png") forState:UIControlStateHighlighted];
    [aboutBtn1 addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [szImage2 addSubview:aboutBtn1];
    UILabel *gylab = [[UILabel alloc] initWithFrame:CGRectMake(20, 47, 40, 15)];
    gylab.text = @"全部彩票";
    gylab.font = [UIFont systemFontOfSize:10];
    gylab.backgroundColor = [UIColor clearColor];
    [szImage2 addSubview:gylab];
    [gylab release];
    
    UIButton *zjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zjBtn.frame = CGRectMake(79, 10, 39, 39);
    zjBtn.tag = 1;
    [zjBtn setImage:UIImageGetImageFromName(@"zhongjiangcaipiao.png") forState:UIControlStateNormal];
    [zjBtn setImage:UIImageGetImageFromName(@"zhongjiangcaipiao-1.png") forState:UIControlStateHighlighted];
    [zjBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [szImage2 addSubview:zjBtn];
    UILabel *zjlab = [[UILabel alloc] initWithFrame:CGRectMake(79, 47, 40, 15)];
    zjlab.text = @"中奖彩票";
    zjlab.font = [UIFont systemFontOfSize:10];
    zjlab.backgroundColor = [UIColor clearColor];
    [szImage2 addSubview:zjlab];
    [zjlab release];
    
    UIButton *zhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhBtn.frame = CGRectMake(138, 10, 39, 39);
    zhBtn.tag = 2;
    [zhBtn setImage:UIImageGetImageFromName(@"zhuhao.png") forState:UIControlStateNormal];
    [zhBtn setImage:UIImageGetImageFromName(@"zhuhao-1.png") forState:UIControlStateHighlighted];
    [zhBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [szImage2 addSubview:zhBtn];
    UILabel *zhlab = [[UILabel alloc] initWithFrame:CGRectMake(138, 47, 40, 15)];
    zhlab.text = @"我的追号";
    zhlab.font = [UIFont systemFontOfSize:10];
    zhlab.backgroundColor = [UIColor clearColor];
    [szImage2 addSubview:zhlab];
    [zhlab release];
    
    UIButton *hmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hmBtn.frame = CGRectMake(197, 10, 39, 39);
    hmBtn.tag = 3;
    [hmBtn setImage:UIImageGetImageFromName(@"hemai.png") forState:UIControlStateNormal];
    [hmBtn setImage:UIImageGetImageFromName(@"hemai-1.png") forState:UIControlStateHighlighted];
    [hmBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [szImage2 addSubview:hmBtn];
    UILabel *hmlab = [[UILabel alloc] initWithFrame:CGRectMake(197, 47, 40, 15)];
    hmlab.text = @"合买彩票";
    hmlab.font = [UIFont systemFontOfSize:10];
    hmlab.backgroundColor = [UIColor clearColor];
    [szImage2 addSubview:hmlab];
    [hmlab release];
    
    //帐户管理背景图片
    UIImageView *zhImage = [[UIImageView alloc] initWithFrame:CGRectMake(45, 309, 300, 87)];
    zhImage.image = UIImageGetImageFromName(@"wodecaipiao07.png");
    zhImage.userInteractionEnabled = YES;
    [self.mainView addSubview:zhImage];
    [zhImage release];
    
    UIImageView *zhImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, 6, 257, 75)];
    zhImage2.image = UIImageGetImageFromName(@"wodecaipiao08.png");
    zhImage2.userInteractionEnabled = YES;
    [zhImage addSubview:zhImage2];
    [zhImage2 release];
    
    UILabel *naLable = [[UILabel alloc] init];
    naLable.numberOfLines = 0;
    naLable.font = [UIFont boldSystemFontOfSize:12];
    naLable.frame = CGRectMake(2, 7, 20, 72);
    naLable.textAlignment = NSTextAlignmentCenter;
    naLable.backgroundColor = [UIColor clearColor];
    naLable.text = @"帐户管理";
    naLable.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    [zhImage addSubview:naLable];
    [naLable release];
    
    UIButton *xjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xjBtn.frame = CGRectMake(20, 10, 39, 39);
    xjBtn.tag = 10;
    [xjBtn setImage:UIImageGetImageFromName(@"xianjinliushui.png") forState:UIControlStateNormal];
    [xjBtn setImage:UIImageGetImageFromName(@"xianjinliushui-1.png") forState:UIControlStateHighlighted];
    [xjBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zhImage2 addSubview:xjBtn];
    UILabel *xjlab = [[UILabel alloc] initWithFrame:CGRectMake(20, 47, 40, 15)];
    xjlab.text = @"现金流水";
    xjlab.font = [UIFont systemFontOfSize:10];
    xjlab.backgroundColor = [UIColor clearColor];
    [zhImage2 addSubview:xjlab];
    [xjlab release];
    
    UIButton *czBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    czBtn.frame = CGRectMake(79, 10, 39, 39);
    czBtn.tag = 11;
    [czBtn setImage:UIImageGetImageFromName(@"congzhi.png") forState:UIControlStateNormal];
    [czBtn setImage:UIImageGetImageFromName(@"congzhi-1.png") forState:UIControlStateHighlighted];
    [czBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zhImage2 addSubview:czBtn];
    UILabel *czlab = [[UILabel alloc] initWithFrame:CGRectMake(89, 47, 40, 15)];
    czlab.text = @"充值";
    czlab.font = [UIFont systemFontOfSize:15];
    czlab.backgroundColor = [UIColor clearColor];
    [zhImage2 addSubview:czlab];
    [czlab release];
    
    UIButton *tkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tkBtn.frame = CGRectMake(138, 10, 39, 39);
    tkBtn.tag = 12;
    [tkBtn setImage:UIImageGetImageFromName(@"tikuan.png") forState:UIControlStateNormal];
    [tkBtn setImage:UIImageGetImageFromName(@"tikuan-1.png") forState:UIControlStateHighlighted];
    [tkBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zhImage2 addSubview:tkBtn];
    UILabel *tklab = [[UILabel alloc] initWithFrame:CGRectMake(148, 47, 40, 15)];
    tklab.text = @"提款";
    tklab.font = [UIFont systemFontOfSize:15];
    tklab.backgroundColor = [UIColor clearColor];
    [zhImage2 addSubview:tklab];
    [tklab release];
    
    //    UIButton *tkBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    tkBtn2.frame = CGRectMake(197, 10, 25.5, 25.5);
    //    [tkBtn2 setImage:UIImageGetImageFromName(@"tikuanyindao.png") forState:UIControlStateNormal];
    //    [tkBtn2 setImage:UIImageGetImageFromName(@"tikuanyindao-1.png") forState:UIControlStateHighlighted];
    //    [tkBtn2 addTarget:self action:@selector(tixianInfo) forControlEvents:UIControlEventTouchUpInside];
    //    [zhImage2 addSubview:tkBtn2];
    
    //个人资料
    UIImageView *zlImage = [[UIImageView alloc] initWithFrame:CGRectMake(45, 406, 300, 87)];
    zlImage.image = UIImageGetImageFromName(@"wodecaipiao07.png");
    zlImage.userInteractionEnabled = YES;
    [self.mainView addSubview:zlImage];
    [zlImage release];
    UIImageView *zlImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, 6, 257, 75)];
    zlImage2.image = UIImageGetImageFromName(@"wodecaipiao08.png");
    zlImage2.userInteractionEnabled = YES;
    [zlImage addSubview:zlImage2];
    [zlImage2 release];
    
    
    UILabel *naLable2 = [[UILabel alloc] init];
    naLable2.numberOfLines = 0;
    naLable2.font = [UIFont boldSystemFontOfSize:12];
    naLable2.frame = CGRectMake(2, 7, 20, 72);
    naLable2.textAlignment = NSTextAlignmentCenter;
    naLable2.backgroundColor = [UIColor clearColor];
    naLable2.text = @"个人管理";
    naLable2.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    [zlImage addSubview:naLable2];
    [naLable2 release];
    
    UIButton *xxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xxBtn.frame = CGRectMake(20, 10, 39, 39);
    xxBtn.tag = 20;
    [xxBtn setImage:UIImageGetImageFromName(@"gerenxinxi.png") forState:UIControlStateNormal];
    [xxBtn setImage:UIImageGetImageFromName(@"gerenxinxi-1.png") forState:UIControlStateHighlighted];
    [xxBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zlImage2 addSubview:xxBtn];
    UILabel *grlab = [[UILabel alloc] initWithFrame:CGRectMake(20, 47, 40, 15)];
    grlab.text = @"个人信息";
    grlab.font = [UIFont systemFontOfSize:10];
    grlab.backgroundColor = [UIColor clearColor];
    [zlImage2 addSubview:grlab];
    [grlab release];
    
    UIButton *touxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    touxBtn.frame = CGRectMake(79, 10, 39, 39);
    touxBtn.tag = 21;
    [touxBtn setImage:UIImageGetImageFromName(@"xiugaitouxiang.png") forState:UIControlStateNormal];
    [touxBtn setImage:UIImageGetImageFromName(@"xiugaitouxiang-1.png") forState:UIControlStateHighlighted];
    [touxBtn addTarget:self action:@selector(functionClike:) forControlEvents:UIControlEventTouchUpInside];
    [zlImage2 addSubview:touxBtn];
    UILabel *touxlab = [[UILabel alloc] initWithFrame:CGRectMake(79, 47, 40, 15)];
    touxlab.text = @"修改头像";
    touxlab.font = [UIFont systemFontOfSize:10];
    touxlab.backgroundColor = [UIColor clearColor];
    [zlImage2 addSubview:touxlab];
    [touxlab release];
    
    
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordButton addTarget:self action:@selector(Presschangepassword) forControlEvents:UIControlEventTouchUpInside];
    [zlImage2 addSubview:passwordButton];
    [passwordButton setImage:UIImageGetImageFromName(@"xiugaimima.png") forState:UIControlStateNormal];
    [passwordButton setImage:UIImageGetImageFromName(@"xiugaimima-1.png") forState:UIControlStateHighlighted];
    passwordButton.frame = CGRectMake(138, 10, 39, 39);
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(138, 47, 40, 15)];
    passwordLabel.text = @"修改密码";
    passwordLabel.font = [UIFont systemFontOfSize:10];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [zlImage2 addSubview:passwordLabel];
    [passwordLabel release];
    //判断是否是第三方登录
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {
        passwordButton.hidden = YES;
        passwordLabel.hidden = YES;
    }

}
- (void)sleepPassWordOpen{
    if (markCount == 1) {
        AccountDrawalViewController *drawal = [[AccountDrawalViewController alloc] init];
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue] == 0 &&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
        {
            drawal.isNotPer = NO;
        }
        else
        {
            drawal.isNotPer = YES;
        }
        drawal.password = self.passWord;
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:drawal animated:YES];
        [drawal release];
    }else if (markCount == 2){
        GCXianJinLiuShuiController * xianj = [[GCXianJinLiuShuiController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:xianj animated:NO];
        [xianj release];
    }
}
- (void)passWordOpenUrl{

    [self performSelector:@selector(sleepPassWordOpen) withObject:nil afterDelay:0];
    
    
    
}



- (void)resetPassWord{

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
        
       
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:test animated:YES];
        [test release];
    }else{
        PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
        [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:pwinfo animated:YES];
        [pwinfo release];
        
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountInfoRequest) name:@"BecomeActive" object:nil];
    
    
    [self downMycaipiaoImage];

#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
//    [self loadXiugaiTouxiangView];
#endif
    
    [self.CP_navigation setHidesBackButton:NO];
    self.CP_navigation.title = @"我的彩票";
    
    if ([self.navigationController.viewControllers count] > 1) {
        self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    }
    
    self.CP_navigation.rightBarButtonItem = self.rightBarBtnItem;
    

}
-(void)downMycaipiaoImage{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL getMycaipiaoImage]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getMycaipiaoImgFinished:)];
    [request setDidFailSelector:@selector(getMycaipiaoImgFailed:)];
    [request startAsynchronous];
}
-(void)getMycaipiaoImgFinished:(ASIHTTPRequest *)requests{
    
    
    NSDictionary *dic = [requests.responseString JSONValue];
    
    NSLog(@"%@ %@ %@ %@",[dic objectForKey:@"wo"],[dic objectForKey:@"de"],[dic objectForKey:@"cai"],[dic objectForKey:@"piao"]);
//    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"wo"] forKey:@"MyCaipiaoImage_wo"];
//    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"de"] forKey:@"MyCaipiaoImage_de"];
//    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"cai"] forKey:@"MyCaipiaoImage_cai"];
//    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"piao"] forKey:@"MyCaipiaoImage_piao"];
    
    
    if([dic objectForKey:@"wo"]){
        
        if ([[dic objectForKey:@"wo"] length] > 5) {
            [quanBuCaiPiaoImageView setImageWithURL:[dic objectForKey:@"wo"]];
        }
        
        
    }
    if([dic objectForKey:@"de"]){
        if ([[dic objectForKey:@"de"] length] > 5) {
            [zhongJiangCaiPiaoImage setImageWithURL:[dic objectForKey:@"de"]];
        }
    }

    if([dic objectForKey:@"cai"]){
        if ([[dic objectForKey:@"cai"] length] > 5) {
            [heMaiCaiPiaoImage setImageWithURL:[dic objectForKey:@"cai"]];
        }
    }

    
    if([dic objectForKey:@"piao"]){
        if ([[dic objectForKey:@"piao"] length] > 5) {
            [zhuihaoCaiPiaoImage setImageWithURL:[dic objectForKey:@"piao"]];
        }
    }

    
}
-(void)getMycaipiaoImgFailed:(ASIHTTPRequest *)requests{
    
    NSLog(@"%@",requests.responseString);
    
}

//领取奖励
- (void)pressjlMoney {
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.myLottoryType = MyLottoryTypeMe;
    my.caiLottoryType = CaiLottoryTypeAll;
    my.jiekou = LingQuJiangLi;
    my.title = @"奖励彩票";
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
    [my release];
}
//奖励按钮
- (void)pressjiangliButton:(UIButton *)sender{

//    if (jiangliButton.tag == 0) {
//      
//        //动画效果
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        
//        
//        //上移
////        bgView.frame = CGRectMake(0, 0, 320, bgView.bounds.size.height);
//        bgView.frame = CGRectMake(0, 185, 320, self.mainView.frame.size.height - 90);
//        jlmage.image = UIImageGetImageFromName(@"JS960_2.png");
//        [jiangliButton addSubview:jlmage];
//    
//        [UIView commitAnimations];
//        sender.tag = 1;
//        
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isShouQi"];
//        
//    }else{
//        //动画效果
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        
//        //下移
////        bgView.frame = CGRectMake(0, 65, 320, bgView.bounds.size.height);
//        bgView.frame = CGRectMake(0, 90-16 + 65, 320, self.mainView.frame.size.height - 90 -65);
//        jlmage.image = UIImageGetImageFromName(@"JS960.png");
//        [jiangliButton addSubview:jlmage];
//        
//        [UIView commitAnimations];
//        sender.tag = 0;
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"isShouQi"];
//    }
    
}

//单击任何地方收起
- (void)JLhidden{
    //动画效果
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//    
//    //上移
//    bgView.frame = CGRectMake(0, 185 , 320, self.mainView.frame.size.height - 90);
////    bgView.frame = CGRectMake(0, 0, 320, bgView.bounds.size.height);
//    jlmage.image = UIImageGetImageFromName(@"JS960_2.png");
//    [jiangliButton addSubview:jlmage];
//
//    
//    [UIView commitAnimations];

   
}



//pk
- (void)presspk{
    [MobClick event:@"event_pksai"];
    PKMatchViewController * pkm1 = [[PKMatchViewController alloc] init];
    pkm1.pkMatchType = PKMatchTypeRank;
    
    PKMatchViewController * pkm2 = [[PKMatchViewController alloc] init];
    pkm2.pkMatchType = PKMatchTypeBettingRecords;
    
    PKMatchViewController * pkm3 = [[PKMatchViewController alloc] init];
    pkm3.pkMatchType = PKMatchTypeCross;
    
    PKMatchViewController * pkm4 = [[PKMatchViewController alloc] init];
    pkm4.pkMatchType = PKMatchTypeMyBet;
    
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:pkm1, pkm2,pkm3, pkm4,nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"中奖排行"];
    [labearr addObject:@"投注记录"];
    [labearr addObject:@"过关统计"];
    [labearr addObject:@"我的投注"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"PKzhongjiangicon1.png"];
    [imagestring addObject:@"PKtouzhuicon1.png"];
    [imagestring addObject:@"PKguoguanicon1.png"];
    [imagestring addObject:@"PKwodeicon1.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"PKzhongjiangicon2.png"];
    [imageg addObject:@"PKtouzhuicon2.png"];
    [imageg addObject:@"PKguoguanicon2.png"];
    [imageg addObject:@"PKwodeicon2.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    //    tabc.selectedIndex = indexd;
     tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [pkm1 release];
    [pkm2 release];
    [pkm3 release];
    [pkm4 release];
//    [self.navigationController  setNavigationBarHidden:NO animated:NO];
//    PKMatchViewController * pkm = [[PKMatchViewController alloc] init];
//    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:pkm animated:YES];
//    [pkm release];
    
}

//邀请好友
-(void)pressYaoQing
{
    [MobClick event:@"event_wodecaipiao_yaoqinghaoyou"];
    [self.navigationController  setNavigationBarHidden:NO animated:NO];
    YaoQingViewController *yq = [[YaoQingViewController alloc] init];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:yq animated:YES];
    [yq release];

}



//大转盘
- (void)pressDZP {
}

- (void)hasLogin {

	
	if (![[Info getInstance] userName]) {
		[self getPersonalInfoRequest];
	} else {
		[self getAccountInfoRequest];
	}
	UserInfo *user = [[Info getInstance] mUserInfo];
	if ([user.authentication intValue] == 0) {
		
	}
	else {
		ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:proving];
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
             [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
             [nav.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];

#endif
           
        }
		[self presentViewController:nav animated: YES completion:nil];
		[proving release];
		[nav release];
	}
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}

- (void)exitLogin{
    //您是否退出登录
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您是否退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 1;
    [alert show];
    [alert release];

}





- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
#ifdef isCaiPiaoForIPad
    
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        if (alertView.tag == 0)
        {// 多账号，切换到最近一次登录的账号
            [User deleteFromDB:[[Info getInstance] userId]];
            // 配置当前账户
            Info *info = [Info getInstance];
            User *user = [User getLastUser];
            info.userId = user.user_id;
            info.nickName = user.nick_name;
            // info.password = user.password;
            info.headImage = nil;
            [GC_UserInfo sharedInstance].personalData = nil;
            [[caiboAppDelegate getAppDelegate] switchToHomeView];
        }
        else if (alertView.tag == 1)
        {// 直接注销此账号，跳转到登录界面
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            //[[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM users"];
            int count = 0;
            while ([stmt step] == SQLITE_ROW) {
                count++;
            }
            [stmt reset];
            for (int i = 0; i < count; i++) {
                User *user = [User getLastUser];
                [User deleteFromDB:user.user_id];
                
            }
            NSLog(@"%@",[[[Info getInstance]mUserInfo] nick_name]);
            Info *info = [Info getInstance];
            info.login_name = @"";
            info.userId = @"";
            info.nickName = @"";
            info.userName = @"";
            info.isbindmobile = @"";
            info.authentication = @"";
            info.userName = @"";
            info.requestArray = nil;
            info.mUserInfo = nil;
            [ASIHTTPRequest setSessionCookies:nil];
            //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
            [[Info getInstance] setMUserInfo:nil];
            [ASIHTTPRequest clearSession];
            [GC_UserInfo sharedInstance].personalData = nil;
            [GC_HttpService sharedInstance].sessionId = nil;
            [GC_UserInfo sharedInstance].accountManage = nil;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
#ifdef isCaiPiaoForIPad
            
            
            caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
            UINavigationController *a = (UINavigationController *)appcaibo.window.rootViewController;
            NSArray * views = a.viewControllers;
            UIViewController * newhome = [views objectAtIndex:0];
            if ([newhome isKindOfClass:[IpadRootViewController class]]) {
                UIButton * hobutton = [UIButton buttonWithType:UIButtonTypeCustom];
                hobutton.tag = 1;
                [(IpadRootViewController *)newhome pressMenuButton:hobutton];
            }
            
            
//            GouCaiViewController *gou = [[GouCaiViewController alloc] init];
//            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:gou animated:NO];
//            [gou release];

#else
            
            [self.navigationController popViewControllerAnimated:YES];
#endif
            
            
        }
    }

#else
    
    
    
    
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        if (alertView.tag == 0)
        {// 多账号，切换到最近一次登录的账号
            [User deleteFromDB:[[Info getInstance] userId]];
            // 配置当前账户
            Info *info = [Info getInstance];
            User *user = [User getLastUser];
            info.userId = user.user_id;
            info.nickName = user.nick_name;
            // info.password = user.password;
            info.headImage = nil;
            [GC_UserInfo sharedInstance].personalData = nil;
            [[caiboAppDelegate getAppDelegate] switchToHomeView];
        }
        else if (alertView.tag == 1)
        {// 直接注销此账号，跳转到登录界面
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAlipay"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuisongshezhi"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cheknewpush"];
            Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM users"];
            int count = 0;
            while ([stmt step] == SQLITE_ROW) {
                count++;
            }
            [stmt reset];
            for (int i = 0; i < count; i++) {
                User *user = [User getLastUser];
                [User deleteFromDB:user.user_id];
                
            }
            NSLog(@"%@",[[[Info getInstance]mUserInfo] nick_name]);
            Info *info = [Info getInstance];
            info.login_name = @"";
            info.userId = @"";
            info.nickName = @"";
            info.userName = @"";
            info.isbindmobile = @"";
            info.authentication = @"";
            info.userName = @"";
            info.requestArray = nil;
            info.mUserInfo = nil;
            [ASIHTTPRequest setSessionCookies:nil];
            //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
            [[Info getInstance] setMUserInfo:nil];
            [ASIHTTPRequest clearSession];
            [GC_UserInfo sharedInstance].personalData = nil;
            [GC_HttpService sharedInstance].sessionId = nil;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

#endif
    
}

- (void)goBackToforiPad
{
	
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resetPassWord" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"passWordOpenUrl" object:nil];
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CannotPanGestureRecognizer" object:nil];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


    [[NSNotificationCenter defaultCenter] postNotificationName:@"CanPanGestureRecognizer" object:nil];

    
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
    {
        notPerImage.hidden = YES;
        
    }
    else
    {
        notPerImage.hidden = NO;
        
    }
    
    
    


    
//    // 获取当地时间函数
//    NSDate *date = [NSDate date];
//    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    //    NSInteger interval = [zone secondsFromGMTForDate:date];
//    //    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
//    // 实例化一个NSDateFormatter对象并设置时间格式
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:date];
//    NSString *dateStr = [dateString substringFromIndex:11];
//    NSLog(@"时间***************************%@",dateStr);
//    
//    _index = 0;
//    if ([dateStr compare:@"13:00:00"]==NSOrderedDescending&& [dateStr compare:@"18:00:00"] == NSOrderedAscending) {
//        _index++;
//    }else if ([dateStr compare:@"18:00:00"]==NSOrderedDescending&&[dateStr compare:@"23:59:59"]==NSOrderedAscending) {
//        _index++;
//    }else
//    {
//        _index = 0;
//    }
//    if (_index > 2) {
//        _index = 0;
//    }
//    if (_index == 0) {
//        btnbackImage.image = UIImageGetImageFromName(@"wodecaipiao_0.png");
//    }else if(_index == 1){
//        btnbackImage.image = UIImageGetImageFromName(@"wodecaipiao_1.png");
//    }else{
//        btnbackImage.image = UIImageGetImageFromName(@"wodecaipiao_2.png");
//    }

    
    
  
   
    
    
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passWordOpenUrl) name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPassWord) name:@"resetPassWord" object:nil];
    
    
    
    
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
   
    
    
//    
//    [reqUserInfo clearDelegatesAndCancel];
//    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
//    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
//    [reqUserInfo setDelegate:self];
//    [reqUserInfo startAsynchronous];
    
    
    
    
    if ([[Info getInstance] headImage]) {
        touXiangImageView.image = [[Info getInstance] headImage];
    }
    else {
        if ([[Info getInstance] headImageURL]) {
            [touXiangImageView setImageWithURL:[[Info getInstance] headImageURL]];
        }
//        [touXiangImageView setImageWithURL:[[Info getInstance] hea] DefautImage:nil];
    }
    
    
    
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"caijinbaomake"] == 0 ) {
        dianCjbImage.hidden = NO;
    }else{
        dianCjbImage.hidden = YES;
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
        NSDictionary * chekdict = (NSDictionary *)[[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
        
        if ([[chekdict objectForKey:@"kfsx"] intValue] == 1 ) {
            selfHelpImageView.hidden = NO;
        }else{
            selfHelpImageView.hidden = YES;
        }
        
        
    }
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)touchesBeganFunc{
    [self JLhidden];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    [super scrollViewDidScroll:scrollView];
    
//     [self JLhidden];
//    if (myScrollView.contentOffset.y <= 0) {
//        myScrollView.contentOffset = CGPointMake(myScrollView.contentOffset.x, 0);
//    }
    
    NSLog(@"%f",scrollView.contentOffset.y);
    
    if(scrollView.contentOffset.y < -85){
    
        [scrollView setContentOffset:CGPointMake(0, -85)];
    }
    if (scrollView == myScrollView) {
        
        float y = scrollView.contentOffset.y;
        if(y<0){
            btnbackImage.frame = CGRectMake(0, -(85+y), 320, 197);

        }
        else{
            btnbackImage.frame = CGRectMake(0, -85, 320, 197);

        }
//        float y = scrollView.contentOffset.y;
//        if (y < 0) {
//            float beishu = (-y + 185.0)/185.0;
//            if (btnbackImage2.frame.origin.y > 0) {
//                btnbackImage.frame = CGRectMake(-(320 * beishu -320)/2.0,y + 53,320 * beishu,112.5 * beishu - y);
//            }
//            else {
//                btnbackImage.frame = CGRectMake(-(320 * beishu -320)/2.0,y,320 * beishu,112.5 * beishu - y);
//            }
//            
//        }else{
//            if (btnbackImage2.frame.origin.y > 0) {
//                btnbackImage.frame = CGRectMake(0, 53, 320, 112.5);
//            }
//            else {
//                btnbackImage.frame = CGRectMake(0, 0, 320, 112.50);
//            }
//            
//        }
        
        [mRefreshView CBRefreshScrollViewDidScroll:myScrollView];
    }
    
    
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self JLhidden];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    
    
    [jiangliLabel release];
    self.caijinType = nil;
    [self.SevenDayRequest clearDelegatesAndCancel];
    self.SevenDayRequest = nil;
	[httpRequest clearDelegatesAndCancel];
	self.httpRequest = nil;
    [caijinbao release];
    [helpDJBtn release];
    [dongLabelN release];

    [super dealloc];

}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)recivedFail:(ASIHTTPRequest *)mrequest{
    UIView *view2 = [self.mainView viewWithTag:1133];
    view2.userInteractionEnabled = YES;
}


- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest] ;
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
}

//跳转其他浏览器
- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}


- (void)recivedSevenDayInfo:(ASIHTTPRequest*)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    if ([[dic valueForKey:@"code"] integerValue] == 1) {//能参加活动
        UIView *view = [self.mainView viewWithTag:1132];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 320, 53);
        btn.tag = 1133;
        if ([[dic valueForKey:@"button_img"] length]) {
            DownLoadImageView *imageV = [[DownLoadImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 53)];
            [view addSubview:imageV];
            [imageV setImageWithURL:[dic valueForKey:@"button_img"]];
            [imageV release];
        }
        self.caijinType = [dic valueForKey:@"type"];
//        [btn setImage:UIImageGetImageFromName(@"SevenDay.png") forState:UIControlStateNormal];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(getSevenDayCaiJin) forControlEvents:UIControlEventTouchUpInside];
//        btnbackImage.frame = CGRectMake(0, 53, 320, 112.5);
        btnbackImage2.frame = CGRectMake(0  , 53, 320, 90);
        bgView.frame = CGRectMake(0, 53 + 90, 320, 780-45);
        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 780-45 + 53);
    
        // +*****积分+45 高度 (0, 90-45, 320, 740+45*2)
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(10, 32, 300, 20);
        [btn addSubview:lable];
        lable.font = [UIFont boldSystemFontOfSize:10];
        lable.backgroundColor = [UIColor clearColor];
        lable.text = [dic valueForKey:@"msg"];
        lable.numberOfLines = 0;
        lable.textAlignment = NSTextAlignmentCenter;
        [lable release];
    }
    else if ([[dic valueForKey:@"code"] integerValue] == 2) {//已经参加
        UIView *view = [self.mainView viewWithTag:1132];
        DownLoadImageView *imageV = [[DownLoadImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 57)];
        [view addSubview:imageV];
//        btnbackImage.frame = CGRectMake(0, 57, 320, 112.5);
        btnbackImage2.frame = CGRectMake(0  , 0, 320, 90);
        bgView.frame = CGRectMake(0, 57 + 90, 320, 780-45);
        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 780-45 + 57);
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(10, 0, 300, 50);
        [imageV addSubview:lable];
        lable.font = [UIFont boldSystemFontOfSize:14];
        lable.backgroundColor = [UIColor clearColor];
        lable.text = [dic valueForKey:@"msg"];
        lable.numberOfLines = 0;
        lable.textColor = [UIColor redColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable release];
        [imageV setImageWithURL:[dic valueForKey:@"button_img"]];
        [imageV release];
    }
    else if ([[dic valueForKey:@"code"] integerValue] == 3) {//表示不能参加
    }
}
- (void)tixianFunc{
    
}

- (void)recivedSevenDayCaiJin:(ASIHTTPRequest*)request {
    
    NSDictionary *dic = [[request responseString] JSONValue];
    if ([[dic valueForKey:@"code"] integerValue] == 1) {//成功
        UIView *view2 = [self.mainView viewWithTag:1133];
        [view2 removeFromSuperview];
        UIView *view = [self.mainView viewWithTag:1132];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 57)];
        [view addSubview:imageV];
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(10, 0, 300, 50);
        [imageV addSubview:lable];
        lable.font = [UIFont boldSystemFontOfSize:14];
        lable.backgroundColor = [UIColor clearColor];
        lable.text = [dic valueForKey:@"msg"];
        lable.numberOfLines = 0;
        lable.textColor = [UIColor redColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable release];
        imageV.image = UIImageGetImageFromName(@"SevenDayBack.png");
        [imageV release];
    }
    else if ([[dic valueForKey:@"code"] integerValue] == 6){
        if ([dic valueForKey:@"msg"]) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[dic valueForKey:@"msg"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 106;
            [alert release];
        }
    }
    else {
        if ([dic valueForKey:@"msg"]) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[dic valueForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
}
#pragma mark -photo
//拍照未完待续
-(void)loadXiugaiTouxiangView
{
    UIView *xiugaiView=[[UIView alloc]init];
    xiugaiView.tag=010;
    //    xiugaiView.userInteractionEnabled=YES;
    xiugaiView.frame=CGRectMake(0, self.mainView.bounds.size.height, 320, 210);
    xiugaiView.backgroundColor=[UIColor cyanColor];
    [self.mainView addSubview:xiugaiView];
    [xiugaiView release];
    
    CP_PTButton *phoButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(15, 20, 290, 45)];
    // [phoButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"拍 照"];
    [phoButton loadButonImage:@"dengluanniu_1.png" LabelName:@"拍   照"];
    phoButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
    phoButton.buttonImage.frame = phoButton.bounds;
    phoButton.buttonName.textColor=[UIColor grayColor];
    // phoButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    phoButton.buttonImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    [phoButton addTarget:self action:@selector(pressPotButton:) forControlEvents:UIControlEventTouchUpInside];
    [xiugaiView addSubview:phoButton];
    [phoButton release];

    CP_PTButton *xcButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(15, 75, 290, 45)];
    //[xcButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
    [xcButton loadButonImage:@"dengluanniu_1.png" LabelName:@"从手机相册选择"];
    
    xcButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
    xcButton.buttonImage.frame = xcButton.bounds;
    xcButton.buttonName.textColor=[UIColor grayColor];
    // xcButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    xcButton.buttonImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    [xcButton addTarget:self action:@selector(pressPotButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    [xiugaiView addSubview:xcButton];
    [xcButton release];
    
    CP_PTButton *qxButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(15, 145, 290, 45)];
    //[xcButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
    [qxButton loadButonImage:@"dengluanniu_1.png" LabelName:@"取   消"];
    
    qxButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
    qxButton.buttonImage.frame = qxButton.bounds;
    // xcButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    qxButton.buttonImage.image = [UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    
    [qxButton addTarget:self action:@selector(pressQxButton) forControlEvents:UIControlEventTouchUpInside];
    [xiugaiView addSubview:qxButton];
    [qxButton release];
    
    UIView *huiseView=[[UIView alloc]initWithFrame:self.view.bounds];
    //    [self.view addSubview:huiseView];
    huiseView.alpha=.6;
    [self.view bringSubviewToFront:huiseView];
    huiseView.backgroundColor=[UIColor lightGrayColor];
    [huiseView release];
}
//-(void)xiugaiTouxiang
//{
//    UIView *xiugaiView = [self.mainView viewWithTag:010];
//    [UIView animateWithDuration:0.5 animations:^{
//        xiugaiView.frame=CGRectMake(0, self.mainView.bounds.size.height-210, 320, 210);
//    }];
//}
//-(void)pressQxButton
//{
//    UIView *xiugaiView = [self.mainView viewWithTag:010];
//    [UIView animateWithDuration:0.5 animations:^{
//        xiugaiView.frame=CGRectMake(0, self.mainView.bounds.size.height, 320, 210);
//    }];
//}
////拍照
//-(void)pressPotButton:(UIButton *)sender
//{
//    NSLog(@"牌照");
//    //拍照
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing=YES;
//        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
//        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated: YES completion:nil];
//        [picker release];
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
//                                                       message:NSLocalizedString(@"have no camera",nil)
//                                                      delegate:self
//                                             cancelButtonTitle:@"确定"
//                                             otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//    }
//}
////相册
//-(void)pressPotButtonTwo:(UIButton *)sender
//{
//    NSLog(@"相册");
//    //选择已存的照片
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
//        
//#ifdef isCaiPiaoForIPad
//        
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
//        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
//        popoverController.delegate=self;
//        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//#else
//        
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing=YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
//        [self presentViewController:picker animated: YES completion:nil];
//        [picker release];
//        
//#endif
//        
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
//                                                        message:NSLocalizedString(@"have no camera",nil)
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//    }
//}
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated: YES completion: nil];
//    NSLog(@"info = %@",info);
//	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//	if ([mediaType isEqualToString:@"public.image"]) {
//		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//		if (image) {
//			if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
//				NSLog(@"111111");
//			} else {
//				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
//                NSLog(@"222222");
//			}
//            
//            
//            // UIImage * imagev = [UIImage createRoundedRectImage:image size:size];
//            
//            // myImageView.image = imagev;
//            mHeadImage = image;
////            myImageView.image = image;
//            
//            
//            
//            
//		} else {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
//														   message:@"无法读取图片，请重试"
//														  delegate:self
//												 cancelButtonTitle:@"确定"
//												 otherButtonTitles:nil, nil];
//			[alert show];
//            [alert release];
//		}
//	}
//}
//- (void)actionSave:(UIButton *)sender
//{
//#ifdef isCaiPiaoForIPad
//    
//    [mProgressBar show:@"正在发送个人信息..." view:self.mainView];
//    mProgressBar.mDelegate = self;
//    [mAddressView dimiss];
//    
//    // 如果本地头像图片不为空,先上传此头像
//    if (mHeadImage)
//    {
//        float width  = mHeadImage.size.width;
//        float height = mHeadImage.size.height;
//        float scale;
//        
//        if (width > height)
//        {
//            scale = 640.0 / width;
//        }
//        else
//        {
//            scale = 480.0 / height;
//        }
//        
//        if (scale >= 1.0)
//        {
//            [self uploadHeadImage:UIImageJPEGRepresentation(mHeadImage, 1.0)];
//        }
//        else if (scale < 1.0)
//        {
//            [self uploadHeadImage:UIImageJPEGRepresentation([mHeadImage scaleAndRotateImage:640], 1.0)];
//        }
//    }
//    else
//    {
//        // 没有修改头像，直接保存
//        [self sendRequest];
//    }
//    if (finish) {
//        [self gotohome];
//    }else {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//#else
//    
//    [mProgressBar show:@"正在发送个人信息..." view:self.mainView];
//    mProgressBar.mDelegate = self;
//    [mAddressView dimiss];
//    
//    // 如果本地头像图片不为空,先上传此头像
//    if (mHeadImage)
//    {
//        float width  = mHeadImage.size.width;
//        float height = mHeadImage.size.height;
//        float scale;
//        
//        if (width > height)
//        {
//            scale = 640.0 / width;
//        }
//        else
//        {
//            scale = 480.0 / height;
//        }
//        
//        if (scale >= 1.0)
//        {
//            [self uploadHeadImage:UIImageJPEGRepresentation(mHeadImage, 1.0)];
//        }
//        else if (scale < 1.0)
//        {
//            [self uploadHeadImage:UIImageJPEGRepresentation([mHeadImage scaleAndRotateImage:640], 1.0)];
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        // 没有修改头像，直接保存
//        [self sendRequest];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    
//#endif
//}
//- (void) sendRequest
//{
//    Info *mInfo = [Info getInstance];
//    NSInteger userId = [mInfo.userId intValue];
//    NSInteger provinceId = mInfo.provinceId;
//    NSInteger cityId = mInfo.cityId;
//    NSInteger sex = 0;
//    //    if (checkboxM.selected)
//    //        {
//    //        sex = 1;
//    //        }
//    //    else if (checkboxF.selected)
//    //        {
//    //        sex = 2;
//    //        }
//    //    NSString *signatures = mLbIntro.text;
//    //    if (!signatures)
//    //        {
//    //        signatures = @"";
//    //        }
//    if (!imageUrl)
//    {
//        imageUrl = @"";
//    }
//    
//    [reqEditPerInfo clearDelegatesAndCancel];
//    self.reqEditPerInfo = [ASIHTTPRequest requestWithURL:[NetURL CbEditPerInfo:(userId) Province:(provinceId) City:(cityId) Sex:(sex) Signatures:(@"") ImageUrl:(imageUrl)]];
//    [reqEditPerInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [reqEditPerInfo setDelegate:self];
//    [reqEditPerInfo setDidFinishSelector:@selector(reqEditPerInfoFinished:)];
//    [reqEditPerInfo startAsynchronous];
//}
//
//- (void)uploadHeadImage:(NSData*)imageData
//{
//    NSString *urlString = @"http://t.diyicai.com/servlet/UploadGroupPic";
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    
//    //
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    //
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:body];
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    if (returnStr)
//    {
//        imageUrl = returnStr;
//    }
//    
//    [self sendRequest];
//    [[Info getInstance] setHeadImage:[UIImage imageWithData:imageData]];
//    [request release];
//    [returnStr release];
//}
//+ (UIImage *)autoFitFormatImage:(UIImage *)image
//{
//	CGSize size = image.size;
//	CGFloat edge = MIN(size.width,size.height);
//	CGFloat scale = 612.0f/edge;
//	UIGraphicsBeginImageContext(CGSizeMake(612, 612));
//	
//	float dwidth = 0;
//	float dheight = 0;
//	CGRect rect = CGRectMake(0, 0, 0, 0);
//	switch (image.imageOrientation) {
//		case UIImageOrientationUp:  //正常 left
//			dwidth = (edge - size.width +48.0f)*scale;
//			dheight = (edge - size.height -21.0f)*scale;
//			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
//			break;
//		case UIImageOrientationDown: //正常 right
//			dwidth = -80;//-(edge - size.width);
//			dheight = (edge - size.height -21.0f)*scale;
//			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
//			break;
//		case UIImageOrientationLeft: //正常 updown
//			dwidth = (edge - size.width -21.0f)*scale;
//			dheight = 0;//-(edge - size.height);
//			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
//			break;
//		case UIImageOrientationRight: //正常  up
//			dwidth = (edge - size.width-21.0f)*scale;
//			dheight = (edge - size.height+48.0f)*scale;
//			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
//			break;
//		default:
//			break;
//	}
//	
//	NSLog(@"%f,%f",size.width*scale,size.height*scale);
//	[image drawInRect:rect];
//    
//	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	return newimg;
//}

//static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
//                                 float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}
//+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
//{
//    // the size of CGContextRef
//    int w = size.width;
//    int h = size.height;
//    
//    UIImage *img = image;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, rect, 10, 10);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    UIImage *image2 = [UIImage imageWithCGImage:imageMasked];
//    CFRelease(imageMasked);
//    return image2;
//}
//- (void)gotohome{
//    [[caiboAppDelegate getAppDelegate] switchToHomeView];
//}


- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    
#ifdef  isCaiPiaoForIPad
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
            alert.tag = 100;
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
            caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
            
            UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
            vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            vi.tag = 10212;
            ProvingViewCotroller *pro = [[ProvingViewCotroller alloc] init];
            pro.passWord = text.text;
            UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:pro];
            nac.view.frame = CGRectMake(80, 180, 540, 680);
            [vi addSubview:nac.view];
            
            //旋转
            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
            rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
            rotationAnimation.duration = 0.0f;
            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
            nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
            
            [app.window addSubview:vi];
            [pro release];
            [vi release];
            
            
        }
        [userInfo release];

#else
        
        
    
        
        
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
            else if (isTixian) {

                AccountDrawalViewController *drawal = [[AccountDrawalViewController alloc] init];
                drawal.password = self.passWord;
                if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
                {
                    drawal.isNotPer = NO;

                    
                }
                else
                {
                    drawal.isNotPer = YES;

                }
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:drawal animated:YES];
                [drawal release];
                
                
               
                
            }else if(isLiuShui == YES){
                
                markCount = 2;
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneAlertView"] intValue] == 0) {
                    CP_UIAlertView * alear = [[CP_UIAlertView alloc] initWithTitle:@"设置手势密码" message:@"" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"马上设置",nil];
                    alear.delegate = self;
                    alear.tag = 998;
                    alear.alertTpye = twoTextType;
                    [alear show];
                }else{
                    GCXianJinLiuShuiController * xianj = [[GCXianJinLiuShuiController alloc] init];
                    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:xianj animated:YES];
                    [xianj release];
                }
                
               
            }
            else if(isZiZhu)
            {
                CPselfServiceViewController * service = [[CPselfServiceViewController alloc] init];
                service.password = self.passWord;
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:service animated:YES];
                [service release];
            }
            else{
                NSDictionary * responseDic = [responseStr JSONValue];
                
                [[NSUserDefaults standardUserDefaults] setValue:[[responseDic valueForKey:@"userInfo"] valueForKey:@"isbindmobile"] forKey:@"isbindmobile"];
                [[NSUserDefaults standardUserDefaults] setValue:[[responseDic valueForKey:@"userInfo"] valueForKey:@"authentication"] forKey:@"authentication"];
                
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                proving.passWord = self.passWord;
                [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
                [proving release];
                
            }
            [userInfo release];
            
          
            

#endif

	
        }
        
        
       

    
}

- (void)rePersonalInfoFinished:(ASIHTTPRequest*)request
{
//   废弃
//    if ([request responseData]) {
//		GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[request responseData]];
//        [GC_UserInfo sharedInstance].personalData = personalData;
//        [personalData release];
//		nameLabel.text = [NSString stringWithFormat:@"%@,您好",[[Info getInstance] nickName]];
//		zhanghuLabel.text = [GC_UserInfo sharedInstance].personalData.accountBalance;
//		jiangliLabel.text = [GC_UserInfo sharedInstance].personalData.rewardAccount;
//        [self getAccountInfoRequest];
//    }
    
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"])
    {
        UserInfo *mUserInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (mUserInfo)
        {
            [[Info getInstance] setMUserInfo:mUserInfo];
            NSLog(@"image = %@", mUserInfo.big_image);
            if (mUserInfo.big_image)
            {
                NSString *urlStr = [Info strFormatWithUrl:mUserInfo.big_image];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                // NSLog(@"ssassss = %d", imageData);
                UIImage *headImage = [UIImage imageWithData:imageData];
                touXiangImageView.image = headImage;
                [[Info getInstance] setHeadImage:headImage];
            }
            
            NSInteger pId = [mUserInfo.province intValue];
            NSInteger cId = [mUserInfo.city intValue];
            [[Info getInstance] setProvinceId:pId];
            [[Info getInstance] setCityId:cId];
            [[AddressView getInstance] getAddressWithId:pId :cId];
            
            
            
            
        }
        [mUserInfo release];
    }
    
    
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"%@",[request error]);

}

-(void)reqAccountInfoFail:(ASIHTTPRequest*)request
{
    [refreshImageView.layer removeAllAnimations];
    [self dismissRefreshTableHeaderView];
}

    
// 改变字体
- (NSString *)yuEchangeFont:(NSString *)yuEtext{
    
    NSString *yuEtextChanged = @"" ;
    
    //  [GC_UserInfo sharedInstance].accountManage.accountBalance
    
    for (int i = 0; i<[yuEtext length]; i++) {
        NSRange range;
        range.length = 1;
        range.location = i;
        NSString *yuEtextS = [yuEtext substringWithRange:range];
        NSLog(@"========>%@",yuEtextS);
        NSString *str = @"";
//        for (int i=0 ; i<9; i++) {
//            if ([yuEtextS isEqualToString:@"0"]) {
//                str = @"20.";
//            }else if([yuEtextS isEqualToString:[NSString stringWithFormat:@"%d",i+1]]) {
//                
//                str = [NSString stringWithFormat:@"%d.",[yuEtextS intValue]+10];
//            }
//        }
        
        if ([yuEtextS isEqualToString:@"0"]) {
            str = @"⒛";
        }else if( [yuEtextS isEqualToString:@"1"]){
        
            str = @"⒒";
        }else if ([yuEtextS isEqualToString:@"2"]){
        
            str = @"⒓";
        }else if ([yuEtextS isEqualToString:@"3"]){
        
            str = @"⒔";
        }else if ([yuEtextS isEqualToString:@"4"]){
        
            str = @"⒕";
        }else if ([yuEtextS isEqualToString:@"5"]){
        
            str = @"⒖";
        }else if ([yuEtextS isEqualToString:@"6"]){
        
            str = @"⒗";
        }else if ([yuEtextS isEqualToString:@"7"]){
        
            str = @"⒘";
        }else if ([yuEtextS isEqualToString:@"8"]){
        
            str = @"⒙";
        }else// if ([yuEtextS isEqualToString:@"9"])
        {
            str = @"⒚";
        }
        
       
        
        yuEtextChanged = [NSString stringWithFormat:@"%@%@",yuEtextChanged,str];

        
    }
    NSLog(@"yuEtextChanged = %@", yuEtextChanged);
    return yuEtextChanged;
}
    

    
- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    [refreshImageView.layer removeAllAnimations];
    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData] WithRequest:request];
        self.caijinbao = aManage.caijinbao;
//        if (aManage.accountBalance != nil){
//            
//        }
        [GC_UserInfo sharedInstance].accountManage = aManage;
		[aManage release];
        if ([[GC_UserInfo sharedInstance].accountManage.ktxAward floatValue] != 0) {
            
            zhangLabel.hidden = YES;
            jlMoneyButton.hidden = NO;
            jlMoneyLabel.hidden = NO;
            jlMoneyLabel.text = [NSString stringWithFormat:@"%@",[GC_UserInfo sharedInstance].accountManage.ktxAward];
        }
		if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
            zhanghuLabel.text = @"0.00";

            CGSize maxSize8 = CGSizeMake(200, 20);
            CGSize expectedSize8 = [zhanghuLabel.text sizeWithFont:zhanghuLabel.font constrainedToSize:maxSize8 lineBreakMode:UILineBreakModeWordWrap];
            zhanghuLabel.frame = CGRectMake(ORIGIN_X(zhangLabel)+7, 48, expectedSize8.width, 21);
            yuanLabel.frame = CGRectMake(ORIGIN_X(zhanghuLabel)+7, zhangLabel.frame.origin.y, 15, 15);

		}
		else {
			zhanghuLabel.text = [NSString stringWithFormat:@"%@",[GC_UserInfo sharedInstance].accountManage.accountBalance];
            CGSize maxSize8 = CGSizeMake(200, 20);
            CGSize expectedSize8 = [zhanghuLabel.text sizeWithFont:zhanghuLabel.font constrainedToSize:maxSize8 lineBreakMode:UILineBreakModeWordWrap];
            zhanghuLabel.frame = CGRectMake(ORIGIN_X(zhangLabel)+7, 48, expectedSize8.width, 21);
            yuanLabel.frame = CGRectMake(ORIGIN_X(zhanghuLabel)+7, zhangLabel.frame.origin.y, 15, 15);

		}
		
        
		if ([[GC_UserInfo sharedInstance].accountManage.awardAccountBalance floatValue] == 0) {
			jiangliLabel.text = @"- -  元";
            
            jiangLabel.hidden = YES;
            jiangliLabel.hidden = YES;
            jiangliBOOL = NO;
		}
		else {
			jiangliLabel.text = [NSString stringWithFormat:@"%.2f  元",[[GC_UserInfo sharedInstance].accountManage.awardAccountBalance floatValue]];
            
            self.drawal_jiangliMoney = jiangliLabel.text;
            
            jiangLabel.hidden = NO;
            jiangliLabel.hidden = NO;
            jiangliBOOL = YES;
            
            CGSize jlsize = [jiangliLabel.text sizeWithFont:[UIFont systemFontOfSize:15]];
            jiangliLabel.frame = CGRectMake(jiangliLabel.frame.origin.x, jiangliLabel.frame.origin.y, jlsize.width, jiangliLabel.frame.size.height);

		}
        

        
		if ([[GC_UserInfo sharedInstance].accountManage.freezedAward floatValue] == 0) {
            
            dongjieLabel.text = @"- -  元";
            dongLabelN.hidden = YES;
            dongjieLabel.hidden = YES;
            helpDJBtn.hidden = YES;
            
            
		}
		else {
            dongLabelN.hidden = NO;
            dongjieLabel.hidden = NO;
            helpDJBtn.hidden = NO;

            
			dongjieLabel.text = [NSString stringWithFormat:@"%.2f  元",[[GC_UserInfo sharedInstance].accountManage.freezedAward floatValue]];
            CGSize size = [dongjieLabel.text sizeWithFont:[UIFont systemFontOfSize:15]];
            if(jiangliBOOL){
                dongLabelN.frame = CGRectMake(ORIGIN_X(jiangliLabel)+7, dongLabelN.frame.origin.y, dongLabelN.frame.size.width, dongLabelN.frame.size.height);
            }
            else{
                dongLabelN.frame = CGRectMake(15, dongLabelN.frame.origin.y, dongLabelN.frame.size.width, dongLabelN.frame.size.height);
                
            }
            dongjieLabel.frame = CGRectMake(ORIGIN_X(dongLabelN)+7, ORIGIN_Y(zhangLabel)+16.5, size.width, 15);
            helpDJBtn.frame = CGRectMake(ORIGIN_X(dongjieLabel) - 9, ORIGIN_Y(zhangLabel) + 2, 40, 40);


		}
//		[refreshbtn performSelector:@selector(setHidden:) withObject:NO afterDelay:1];
//      [activityView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }
	
    [self dismissRefreshTableHeaderView];
}
    
#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
    isAllRefresh = YES;
    isLoading = YES;
    [self refresh];


}

// 判断是否正在刷新状态
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
    return isLoading; // should return if data source model is reloading
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myScrollView];
}
  
    
#pragma mark SvrollView




// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (myScrollView.contentSize.height-scrollView.contentOffset.y<=610.0) {
        if (!isAllRefresh) {
            
            [self performSelector:@selector(refresh) withObject:nil afterDelay:0.5];
        }
    }
    
    [mRefreshView CBRefreshScrollViewDidEndDragging:myScrollView];

    

}
@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
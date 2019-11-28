//
//  TestViewController.m
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "TestViewController.h"
#import "NormalCircle.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "PassWordView.h"
#import "CPSetpwViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "GouCaiHomeViewController.h"
#import "JiangJinYouhuaViewController.h"
#import "GCHeMaiSendViewController.h"
#import "HRSliderViewController.h"



@interface TestViewController ()<LockScreenDelegate>

@property (nonatomic) NSInteger wrongGuessCount;
@end

@implementation TestViewController
@synthesize infoLabelStatus,wrongGuessCount;
@synthesize twoBool, passWordString;

- (void)dealloc{
    [passWordString release];
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
    
    
    if (!twoBool) {
        [self pressClearButton];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
    }
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //	self.mainView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    if (twoBool) {
        self.title = @"重复手势密码";
    }else{
        self.title = @"手势密码";
    }
    
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView * backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // backi.image = UIImageGetImageFromName(@"login_bgn.png");
    backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:backi];
    [backi release];
    
    
    
    // 密码背景
    UIImageView * lockBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width , self.mainView.frame.size.height )];
    lockBgImage.backgroundColor = [UIColor clearColor];
    lockBgImage.userInteractionEnabled = YES;
    // lockbgimage.png
    lockBgImage.image = [UIImageGetImageFromName(@"shouShiJieSuo-bg_1.png") stretchableImageWithLeftCapWidth:95 topCapHeight:95];
    [self.mainView addSubview:lockBgImage];
    [lockBgImage release];
	
    
    UIImageView * lockimage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 60, lockBgImage.frame.size.width - 12, 303)];
    if (IS_IPHONE_5) {
        lockimage.frame =CGRectMake(0, 60+44, lockBgImage.frame.size.width , 303);
    }
    lockimage.backgroundColor= [UIColor clearColor];
    lockimage.userInteractionEnabled = YES;
    [lockBgImage addSubview:lockimage];
    [lockimage release];
    
    
    
    
	self.lockScreenView = [[[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, lockimage.frame.size.width, lockimage.frame.size.height)] autorelease];
    //	self.lockScreenView.center = self.mainView.center;
	self.lockScreenView.delegate = self;
	self.lockScreenView.backgroundColor = [UIColor clearColor];
	[lockimage addSubview:self.lockScreenView];
	
    // ****
	self.infoLabel = [[[UILabel alloc]initWithFrame:CGRectMake(6, 38-14, lockBgImage.frame.size.width - 12, 20)] autorelease];
    if (IS_IPHONE_5) {
        // +44
        self.infoLabel.frame = CGRectMake(6, 38, lockBgImage.frame.size.width - 12, 20);
    }
	self.infoLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.font = [UIFont systemFontOfSize:14];
	self.infoLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
	self.infoLabel.textAlignment = NSTextAlignmentCenter;
    if (twoBool) {
        self.infoLabel.text = @"再次绘制图案进行确认";
    }else{
        self.infoLabel.text = @"绘制解锁图案,请至少连接4个点";
    }
    
	[lockBgImage addSubview:self.infoLabel];
	
    //	[self updateOutlook];
    
    
    if (twoBool) {
        UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearButton.frame = CGRectMake((312-120)/2, 374, 120, 30);
        if (IS_IPHONE_5) {
            clearButton.frame = CGRectMake((320-120)/2, 374+44, 120, 30);
        }
        [clearButton setTitleColor:[UIColor colorWithRed:0 green:168/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [clearButton setTitle:@"放弃设置" forState:UIControlStateNormal];
        [clearButton setTitleColor:[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:109.0/255.0 alpha:1] forState:UIControlStateNormal];
        clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [clearButton addTarget:self action:@selector(pressClearButton) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:clearButton];
    }
    
    
    
}
//- (BOOL)resetPassWord{
//
//    BOOL pwInfoBool = NO;
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
//        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
//
//
//        for (int i = 0; i < [allUserArr count]; i++) {
//            //        NSArray * userArr = [];
//            NSString * userString = [allUserArr objectAtIndex:i];
//            NSArray * userArr = [userString componentsSeparatedByString:@" "];
//            if ([userArr count] == 3) {
//
//                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
//
//                    pwInfoBool = YES;
//
//                    break;
//                }
//
//            }
//
//        }
//
//    }
//
//    if (pwInfoBool) {
//        return YES;
////        TestViewController * test = [[TestViewController alloc] init];
////
////        //                UIViewController * con = [viewController.navigationController.viewControllers objectAtIndex:[viewController.navigationController.viewControllers cou]];
////        //
////        [self.navigationController pushViewController:test animated:YES];
////        [test release];
//    }else{
//        return NO;
////        PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
////        [self.navigationController pushViewController:pwinfo animated:YES];
////        [pwinfo release];
//
//    }
//}

- (void)pressClearButton{
    
    
    //    if ([self.navigationController.viewControllers count] > 2) {
    //        UIViewController *con2 = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3];
    //
    //        if ([con2 isKindOfClass:[CPSetpwViewController class]]) {
    //            [self.navigationController popToViewController:con2 animated:YES];
    //        }
    //
    //    }passWordOpenUrlxianjin
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"passWordOpenUrlxianjin" object:self];
    
    //    BOOL count = [self resetPassWord];
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        UIViewController * con = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - (i+1)];
        if ([con isKindOfClass:[CPSetpwViewController class]] || [con isKindOfClass:[GC_ShengfuInfoViewController class]] || [con isKindOfClass:[GouCaiShuZiInfoViewController class]] || [con isKindOfClass:[GouCaiHomeViewController class]] || [con isKindOfClass:[GCHeMaiSendViewController class]] || [con isKindOfClass:[JiangJinYouhuaViewController class]] || [con isKindOfClass:[HRSliderViewController class]]) {
            
            
            [self.navigationController popToViewController:con animated:NO];
            [con performSelector:@selector(passWordOpenUrl)];
            
            //            if ([con isKindOfClass:[CPSetpwViewController class]] ||  [con isKindOfClass:[GouCaiHomeViewController class]]) {
            //                <#statements#>
            //            }
            //
            break;
        }
    }
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"passWordOpenUrl" object:nil];
    
    
    NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
    
    
	
	// Test with Circular Progress
}




#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
    //	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@"status: %d,no.%@",self.infoLabelStatus, [patternNumber stringValue]);
    
    NSString * number = [patternNumber stringValue];
    
    if (twoBool) {//二次输入密码
        
        if ([number isEqualToString:self.passWordString]) {//如果一样的话
            
            NSString * userPassWord = [NSString stringWithFormat:@"%@ %@ %@", [[Info getInstance] userId], number, @"1"];
            
            // 用户名+ +密码+ + 状态（开关）
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                
                NSMutableArray * userArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]];
                
                BOOL sameBool = NO;
                for (int i = 0; i < [userArray count]; i++) { // 遍历所存的用户
                    
                    NSString * userps = [userArray objectAtIndex:i];
                    NSArray * userarr = [userps componentsSeparatedByString:@" "];
                    if ([userarr count] == 3) {
                        NSString * userid = [userarr objectAtIndex:0];
                        if ([userid isEqualToString:[[Info getInstance] userId]]) { //如果有的话 替换
                            sameBool = YES;
                            [userArray replaceObjectAtIndex:i withObject:userPassWord ];
                            break;
                        }
                    }
                }
                
                if (sameBool == NO) {//没有的话 添加
                    [userArray addObject:userPassWord];
                }
                [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"testPassWord"];
                [userArray release];
            }else{
                
                NSMutableArray * userArray = [[NSMutableArray alloc] initWithCapacity:0]; //如果没有 创建
                [userArray addObject:userPassWord];
                [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:@"testPassWord"];
                [userArray release];
                
            }
            
            
            
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"设置成功"];
            
            
            //            [self pressClearButton];
            for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
                UIViewController * con = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - (i+1)];
                if ([con isKindOfClass:[CPSetpwViewController class]] || [con isKindOfClass:[GC_ShengfuInfoViewController class]] || [con isKindOfClass:[GouCaiShuZiInfoViewController class]] || [con isKindOfClass:[GouCaiHomeViewController class]] || [con isKindOfClass:[GCHeMaiSendViewController class]] || [con isKindOfClass:[JiangJinYouhuaViewController class]]) {
                    
                    
                    [self.navigationController popToViewController:con animated:NO];
                    [con performSelector:@selector(passWordOpenUrl)];
                    
                    //            if ([con isKindOfClass:[CPSetpwViewController class]] ||  [con isKindOfClass:[GouCaiHomeViewController class]]) {
                    //                <#statements#>
                    //            }
                    //
                    break;
                }
                if ([con isKindOfClass:[CP_TabBarViewController class]]) {
                    [self.navigationController popToViewController:con animated:NO];
                    if ([[(CP_TabBarViewController *)con selectedViewController] isKindOfClass:[GouCaiHomeViewController class]]) {
                        [[(CP_TabBarViewController *)con selectedViewController] performSelector:@selector(passWordOpenUrl)];
                    }
                    break;
                }
            }
            //             [[NSNotificationCenter defaultCenter] postNotificationName:@"passWordOpenUrl" object:nil];
            
            //            PassWordView * pwv = [[PassWordView alloc] init];
            //            [cai.window addSubview:pwv];
            //            [pwv release];
            
        }else{
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"与上次输入不一致,请重新输入"];
            
        }
        
    }else{
        if ([number length] < 4) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少连接4个点,请重新输入"];
            
        }else{
            
            TestViewController * twoTestController = [[TestViewController alloc] init];
            twoTestController.twoBool = YES;
            twoTestController.passWordString = number;
            [self.navigationController pushViewController:twoTestController animated:YES];
            [twoTestController release];
        }
    }
    
    
    
    
    
    
}

- (void)viewDidUnload {
	[self setInfoLabel:nil];
	[self setLockScreenView:nil];
	[super viewDidUnload];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
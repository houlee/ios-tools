//
//  UserInfo.m
//  Lottery
//
//  Created by Teng Kiefer on 12-2-26.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "LoginViewController.h"
#import "caiboAppDelegate.h"

@implementation GC_UserInfo

@synthesize is3000_1, personalData, isNeedUpdateData, accountManage;

- (void)dealloc {
    [personalData release];
    [accountManage release];
    [super dealloc];
}

static GC_UserInfo *mInstance;
+ (GC_UserInfo *)sharedInstance {  
    @synchronized(mInstance) {  
        if (mInstance == nil) {  
            mInstance = [[GC_UserInfo alloc] init];  
        }
    }  
    return mInstance; 
}

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

// 获取当前本地日期
- (NSString *)curLocalDate 
{
	NSDate *date = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *time = [formatter stringFromDate:date];
	[formatter release];
	return time;
}

- (NSString *)get_system_today_time
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:kCFDateFormatterMediumStyle];
    [formatter setTimeStyle:kCFDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter setDateFormat:@"EEEE"];
    NSString *weekday = [formatter stringFromDate:date];
    [formatter release];
    
    if ([weekday isEqualToString:@"Monday"]) {
        weekday = @"星期一";
    } else if ([weekday isEqualToString:@"Tuesday"]) {
        weekday = @"星期二";
    } else if ([weekday isEqualToString:@"Wednesday"]) {
        weekday = @"星期三";
    } else if ([weekday isEqualToString:@"Thursday"]) {
        weekday = @"星期四";
    } else if ([weekday isEqualToString:@"Friday"]) {
        weekday = @"星期五";
    } else if ([weekday isEqualToString:@"Saturday"]) {
        weekday = @"星期六";
    } else if ([weekday isEqualToString:@"Sunday"]) {
        weekday = @"星期日";
    }
    dateString = [NSString stringWithFormat:@"%@ %@", dateString, weekday];
    return dateString;
}

- (void)showNotloginAlertView {
    if (![GC_UserInfo sharedInstance].is3000_1) {
        [GC_UserInfo sharedInstance].is3000_1 = YES;
        UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"用户未登录！\n请重新登录！" 
                                                            delegate:self 
                                                   cancelButtonTitle:@"确定" 
                                                   otherButtonTitles:nil];
        [_alertView show];        
        [_alertView release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [GC_UserInfo sharedInstance].is3000_1 = NO;
        [[GC_HttpService sharedInstance] stopHeartInfoTimer];

#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
		LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
        loginVC.isShowDefultAccount = YES;
        
        [loginVC.navigationController setNavigationBarHidden:NO];
		UINavigationController *nav = (UINavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController;
		[nav pushViewController:loginVC animated:YES];
		[loginVC release];
#endif
		
        //[[LotteryAppDelegate shareAppDelegate].tabBarController.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionFlipFromLeft];
    }
}

- (CGFloat)accountBalance
{
    if ([GC_UserInfo sharedInstance].accountManage && [GC_UserInfo sharedInstance].personalData.accountBalance.floatValue > [GC_UserInfo sharedInstance].accountManage.accountBalance.floatValue) {
        return [GC_UserInfo sharedInstance].accountManage.accountBalance.floatValue;
    }
    NSLog(@"%f",[GC_UserInfo sharedInstance].personalData.accountBalance.floatValue);
    return [GC_UserInfo sharedInstance].personalData.accountBalance.floatValue;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
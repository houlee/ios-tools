
//  UINavigationController+Category.m
//  Lottery
//
//  Created by Joy Chiang on 12-02-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationController+Category.h"
#import "CustomMoviePlayerViewController.h"
#import "newHomeViewController.h"
#ifdef isCaiPiaoForIPad
#import "IpadRootViewController.h"
#endif

@implementation UINavigationController (Category)

- (id) init{
    self = [super init];
    if (self) {
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] >= 5) {
#ifdef isCaiPiaoForIPad
            [self.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [self.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
            
#endif
//            [self.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
            
            
            if ([diyistr intValue] >= 7) {
                self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
            }
            
        }
    }
    return self;
}



- (void)pushViewController:(UIViewController *)controller animatedWithTransition:(UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.52f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController *)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController *poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.52f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}


@end

@implementation UINavigationController (iOS6OrientationFix)

-(NSUInteger) supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
#ifdef isCaiPiaoForIPad
    if ([[self.viewControllers lastObject] isKindOfClass:[CustomMoviePlayerViewController class]]||[[self.viewControllers lastObject] isKindOfClass:[IpadRootViewController class]]) {
        return YES;
    }
#else
    if ([[self.viewControllers lastObject] isKindOfClass:[CustomMoviePlayerViewController class]]||[[self.viewControllers lastObject] isKindOfClass:[newHomeViewController class]]) {
        return YES;
    }
#endif
   

   
    return NO;
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
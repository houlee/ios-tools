//
//  UINavigationController+Category.h
//  Lottery
//
//  Created by Joy Chiang on 12-02-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController (Category)

- (UIViewController *)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;
- (void)pushViewController:(UIViewController *)controller animatedWithTransition:(UIViewAnimationTransition)transition;

@end

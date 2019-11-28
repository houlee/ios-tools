//
//  ProfileTabBarController.h
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 *
 * 个人资料 内部 “粉丝”，“微博”，“关注”等 功能  总控制器
 *
 *
 *
 **************/

#import <UIKit/UIKit.h>
#import "TwitterMessageViewController.h"
#import "TopicViewController.h"
#import "CollectViewController.h"
#import "FansViewController.h"
#import "AttentionViewController.h"


@interface ProfileTabBarController : UITabBarController<UITabBarControllerDelegate> {
	
			
}

@property(nonatomic,retain)TwitterMessageViewController *twitterMessageController;

// 初始 化，判断是 否 是 用户本人
-(id)initwithUerself:(BOOL)userself userID:(NSString*)userId;
-(id)initWithUerself:(BOOL)userself userID:(NSString*)userId;

@end

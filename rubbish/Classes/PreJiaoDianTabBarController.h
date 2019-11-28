//
//  PreJiaoDianTabBarController.h
//  caibo
//
//  Created by  on 12-7-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface PreJiaoDianTabBarController : UITabBarController<UITabBarControllerDelegate> {
    NSInteger counttag;
    NSInteger counhaoyou;
     int  selectedTab;
        int con;
    UIImageView * haoyoubadge;
    UIImageView * xiaoxibadge;
    UIImageView * ziliaobadge;
    UILabel * hybadgeValue;
    UILabel * xxbadgeValue;
    UILabel * zlbadgeValue;
    
}
@property(nonatomic, retain)UIImageView * haoyoubadge;
@property (nonatomic, retain)UIImageView * xiaoxibadge;
@property (nonatomic, retain)UIImageView * ziliaobadge;
@property (nonatomic, retain)UILabel * hybadgeValue;
@property (nonatomic, retain)UILabel * xxbadgeValue;
@property (nonatomic, retain)UILabel * zlbadgeValue;

// 初始 化，判断是 否 是 用户本人
-(id)initWithUerself:(BOOL)userself userID:(NSString*)userId;

@end
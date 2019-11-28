//
//  V1PinBaseViewContrllor.h
//
//  Created by v1 on 15/4/21.
//  Copyright (c) 2015年 v1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "MJRefresh.h"
#import "RequestEntity.h"
#import "caiboAppDelegate.h"

@interface V1PinBaseViewContrllor : UIViewController{
    float HEIGHTBELOESYSSEVER;
}

#if defined DONGGEQIU
@property (nonatomic, strong) UIImageView *navView;//懂个球时为UIImageView类型
#else
@property (nonatomic, strong) UIView *navView;//其他情况下为UIView类型
#endif

@property (nonatomic, strong) UIButton *popBackBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) NSString *title_nav;
@property (nonatomic, assign) BOOL isCrazySport;

- (void)creatNavView;

- (void)rightImgAndAction:(UIImage *)img target:(id)target action:(SEL)action;

- (void)rightImgAndAction:(UIImage *)img btnText:(NSString *)btnText target:(id)target action:(SEL)action;

-(void)changeCSTitileColor;

@end

//圈子发帖Btn
@interface UIButton(CS_CircleRightBtn)

- (void)rightImgAndAction:(UIImage *)img btnText:(NSString *)btnText target:(id)target action:(SEL)action;

@end


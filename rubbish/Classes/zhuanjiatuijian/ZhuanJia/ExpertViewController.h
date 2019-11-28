//
//  ExpertViewController.h
//  Experts
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"

@interface ExpertViewController : V1PinBaseViewContrllor

@property(nonatomic,strong) NSString *lotteryType;//001(竞彩),002(数字彩)
@property(nonatomic,strong) NSString *expLoType;//-201(竞彩),202(亚盘)
@property(nonatomic,assign) BOOL isfromYiGou;//是否来自已购方案
@property(nonatomic,strong) NSString *popfrom;

@end

//
//  BuyPlanViewController.h
//  Experts
//
//  Created by V1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"

@interface BuyPlanViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) BOOL isSdOrNo;

@end
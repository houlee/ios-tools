//
//  BallDetailViewController.h
//  Experts
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"

@interface BallDetailViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *countDataArr;

@property(nonatomic,strong)NSArray *ballCodeArr;//码球名称
@property(nonatomic,strong)NSString *bonusNumber;//中奖号码

@property(nonatomic,strong)NSMutableArray *rowCountArr;//码数
@property(nonatomic,strong)NSMutableArray *rowCountAtrArr;//注红的数组

//传参
@property(nonatomic,strong)NSString *caiZhongType;//彩种类型
@property(nonatomic,strong)NSString *planId;//方案id
@property(nonatomic,strong)NSString *qiHao;//期号

@end

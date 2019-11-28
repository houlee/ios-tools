//
//  ProjectDetailViewController.h
//  Experts
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"

@interface ProjectDetailViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property(nonatomic,strong)NSString *sign;//标记来源

@property(nonatomic,strong)NSString *erAgintOrderId; //方案ID
@property(nonatomic,strong)NSDictionary *competeGoBetDic;//去投注要传的字典
@property(nonatomic,strong)NSString *pdLotryType;//彩种
@property(nonatomic,assign)BOOL isSdOrNo;//来自神单还是专家推荐

@end

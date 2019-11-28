//
//  SZCViewController.h
//  Experts
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"

@interface SZCViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property(nonatomic,assign)NSInteger szcType;//0、双色球；1、大乐透；2、3D；3、排列三

@property(nonatomic,strong)NSDictionary * resDic1;
@property(nonatomic,strong)NSDictionary * resDic2;
@property(nonatomic,strong)NSDictionary * resDic3;
@property(nonatomic,strong)NSDictionary * resDic4;

@property(nonatomic,strong)NSDictionary * todayPubNumDic;


@end

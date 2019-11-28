//
//  SZCSbViewController.h
//  Experts
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "V1PickerView.h"
@interface SZCSbViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,V1PickerViewDelegate>

@property(nonatomic,strong)NSArray *countBigArr;//所有的数据
@property(nonatomic,strong)NSString *disLotteryStr;//区分不同彩种字符串
@property(nonatomic,strong)NSDictionary *dataDic;//区分不同彩种字符串

@end

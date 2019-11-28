//
//  MySalesViewController.h
//  Experts
//
//  Created by V1pin on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "V1PickerView.h"

@interface MySalesViewController : V1PinBaseViewContrllor<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,V1PickerViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _topImageView;//方案销量背景图片
    
    UIView * _headTopView;// tableheader view
    
    UILabel * _yearsData;// 多少年
    UILabel * _monthLabel; //几月  几月
    UILabel * _salesNum; // 售出多少单
    UILabel * _salesMoney; //销售多少钱
    
    NSArray * _selectYear; // 年份
    NSArray * _selectMonth; // 月份
    
    NSString * _dataNow; // 系统年份
    NSString * _yearData; // 系统月份
}
@end

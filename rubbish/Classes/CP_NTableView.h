//
//  CP_NTableView.h
//  iphone_control
//
//  Created by houchenguang on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchCell.h"


@protocol CP_NTableDelegate <NSObject>

@optional
- (void)tableReturnIndexPathSection:(NSInteger)section indexPathRow:(NSInteger)row;//选中返回第几段 第几行
- (void)tableSwitchArray:(NSMutableArray *)array;//返回整个开关按钮的状态  数组包数组形式返回 和传入的方式一样

@end

typedef enum {
    
    CP_TableViewMenuStyle,//菜单风格
	CP_TableViewSwitchStyle//推送通知 开关 风格
    
}CP_AllTableViewStyle;

@interface CP_NTableView : UIView<UITableViewDataSource, UITableViewDelegate, CPSwitchDelegate>{

    CP_AllTableViewStyle CP_TableViewStyle;
    UITableView * myTabelView;
    NSMutableArray * titleArray;
    NSMutableArray * imageArray;
    NSMutableArray * switchArray;
    id<CP_NTableDelegate>delegate;
}

@property (nonatomic, assign)CP_AllTableViewStyle CP_TableViewStyle;//分组列表的风格
//以下三个数组 要数组包数组的方式往里传 例如3段4行  就传一个数组包含三个数组 三个数组其中每一个数组包含4个对象  如果是菜单风格 传入的图片数和标题数要一样 如果是开关风格的话 传入的状态 要和标题数一样 具体几段几行 根据标题数量来定
@property (nonatomic, retain) NSMutableArray * titleArray;//所有标题文字
@property (nonatomic, retain)NSMutableArray * imageArray;//所有标题前面的图片
@property (nonatomic, retain)NSMutableArray * switchArray;//所有开关的状态
@property (nonatomic, assign)id<CP_NTableDelegate>delegate;
////////////////////////////////////////////////////////////////////////////////////////
- (void)tableReturnIndexPathSection:(NSInteger)section indexPathRow:(NSInteger)row;
- (void)tableSwitchArray:(NSMutableArray *)array;
@end
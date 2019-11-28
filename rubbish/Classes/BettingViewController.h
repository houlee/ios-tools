//
//  BettingViewController.h
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//参赛

#import <UIKit/UIKit.h>
#import "Info.h"
#import "PKGameExplainViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "JSON.h"
#import "Info.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "PK_TableCell.h"
#import "CP_ThreeLevelNavigationView.h"

@interface BettingViewController : CPViewController <PK_TableCellDelegate, UITableViewDelegate, UITableViewDataSource,CP_ThreeLevelNavDelegate,CP_UIAlertViewDelegate>{
    NSMutableArray * pkArray;//保存数据
    CP_CanOpenTableView * myTableView;
    ASIHTTPRequest * request;
    UILabel * oneLabel;
    UILabel * twoLabel;
    NSMutableArray * betArray;//可买期的数组
    NSMutableArray * dataArray;//保存数据的数组
    int one;
    int two;
    UIView * tabView;
    int zhankai[14];//展开的状态
    CP_ThreeLevelNavigationView    *tln;
}
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic,retain)NSMutableArray * betArray;
- (void)tabBarView;

@end

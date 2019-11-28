//
//  HeMaiRenListViewController.h
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-30.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HeMaiCanYuJieXI.h"
#import "MoreLoadCell.h"
#import "CP_TabBarViewController.h"
#import "CPViewController.h"
#import "CP_LieBiaoView.h"

@interface HeMaiRenListViewController : CPViewController<CP_lieBiaoDelegate,CP_TabBarConDelegate,UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,UIActionSheetDelegate> {
    UITableView *myTableView;       //
    BOOL isLoadingMore;             //加载更多中
    ASIHTTPRequest *myHttpRequest;  //网络请求
    NSString *programNum;           //方案号；
    HeMaiCanYuJieXI *hemaiData;     //数据源
    MoreLoadCell *moreCell;
    NSInteger select;              //选中的
    CP_TabBarViewController * tabc;
    NSString * useridstring;
}

@property (nonatomic,retain)UITableView *myTableView;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;
@property (nonatomic,copy)NSString *programNum;
@property (nonatomic,retain)HeMaiCanYuJieXI *hemaiData;
- (void)getMore;
@end

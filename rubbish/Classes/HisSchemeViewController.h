//
//  HisSchemeViewController.h
//  caibo
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 vodone. All rights reserved.
//他的投注

#import <UIKit/UIKit.h>
#import "MyCathecticCell.h"
#import "StatisticsData.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NetURL.h"
#import "Info.h"
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "CPViewController.h"

@interface HisSchemeViewController : CPViewController<UITableViewDelegate, UITableViewDataSource,CBRefreshTableHeaderDelegate>{
    UITableView * myTableView;
    StatisticsData * statisticsData;
    ASIHTTPRequest * request;
    NSMutableArray * restArray;
    NSString * userId;
    BOOL _reloading;
    CBRefreshTableHeaderView * refreshHeaderView;
    MoreLoadCell * topicMoreCell;
    NSInteger topicLoadCount;
    BOOL isLoadMore;
   
}
- (NSString *)pageNumBet;
- (void)requesthttp;

@property (nonatomic, retain)CBRefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain)NSString * userId;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic, assign)NSInteger topicLoadCount;
@end

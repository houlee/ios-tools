//
//  PKMatchViewController.h
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//
//pk界面
#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
#import "AwardCell.h"
#import "AwardData.h"
#import "StatisticeCell.h"
#import "StatisticsData.h"
#import "MyCathecticCell.h"
#import "DetailsCell.h"
#import "DetailsData.h"
#import "DetailsViewController.h"
#import "HisSchemeViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "MoreLoadCell.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"

typedef enum {
	PKMatchTypeRank,//中奖排行
	PKMatchTypeBettingRecords,//投注记录
	PKMatchTypeCross,//过关统计
    PKMatchTypeMyBet,//我的投注
}PKMatchType;

@interface PKMatchViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,CBRefreshTableHeaderDelegate,UISearchBarDelegate, UIActionSheetDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate> {
	PKMatchType pkMatchType;
	UITableView *PKtableView;
	CBRefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
	
	NSMutableArray *seachTextListarry;
    
    AwardData * data;//最新中奖的cell数据接口 (暂时假数据)
    StatisticsData * statisticsData;//投注记录的cell数据接口 (暂时假数据)
	
	NSInteger rankSelet;//子按钮选中位置
	NSMutableArray *rankTitleArray;
	
	UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
	
	NSInteger bettingSelet;//子按钮选中位置
	NSMutableArray *bettingTitleArray;
	
	NSInteger crossSelet;//子按钮选中位置
	NSMutableArray *crossTitleArray;
    
    NSString * name;//用户的名字
    NSString * useName;//用户的id
    NSMutableDictionary * dictionary;
    ASIHTTPRequest * request;
    ASIHTTPRequest * dateRequest;
    

    NSMutableArray * myBetArray;//我的投注记录
    NSMutableArray * crossArray;//过关统计
    
    NSMutableDictionary * restdateDic;//投注记录的字典
    NSMutableDictionary * myBetDic;
    NSMutableDictionary * crossDic;//过关统计记录的字典
    
    NSDictionary * newdict;
    NSMutableArray * newdataArray;//最新中奖
    NSMutableArray * weekArray;//周榜
    NSMutableArray * monthArray;//月榜
    NSMutableArray * totalArray;//总榜
    NSMutableArray * buyArray;//可买的期数
	MoreLoadCell *moreCell;
	BOOL isLoadingMore;
    BOOL isQuxiao;
    
    UILabel *titleLabel;
}

@property (nonatomic, retain)NSMutableArray * buyArray;
@property (nonatomic,retain)NSMutableArray *seachTextListarry;
@property (nonatomic, retain)ASIHTTPRequest * dateRequest;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic, retain)NSString * useName;
@property (nonatomic,retain)NSMutableArray *rankTitleArray;
@property (nonatomic,retain)NSMutableArray *bettingTitleArray;
@property (nonatomic,retain)NSMutableArray *crossTitleArray;
@property (nonatomic)PKMatchType pkMatchType;
@property (nonatomic,retain)UITableView *PKtableView;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain)AwardData * data;
@property (nonatomic, retain)StatisticsData * statisticsData;
- (NSString *)pageNumData:(NSInteger)index;
- (NSString *)pageNumBet:(NSInteger)index;
- (NSString *)pageNumcross:(NSInteger)index;

- (void)requestHttp;
- (void)requestHttpRecords;
- (void)requestHttpCross;
@end

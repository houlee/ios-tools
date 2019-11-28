//
//  GCHeMaiInfoViewController.h
//  caibo
//
//  Created by  on 12-6-26.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_LotteryTime.h"
#import "MoreLoadCell.h"
#import "CBRefreshTableHeaderView.h"
#import "CP_TabBarViewController.h"
#import "CPViewController.h"
#import "CP_LieBiaoView.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "UpLoadView.h"
#import "ShuangSeQiuInfoViewController.h"

//typedef enum {
//    zucaiinfo,
//    shuziinfo
//}ZuCaiHuoShuZi;

@interface GCHeMaiInfoViewController : CPViewController<CP_KindsOfChooseDelegate,CP_ThreeLevelNavDelegate,CP_lieBiaoDelegate,CP_TabBarConDelegate,CBRefreshTableHeaderDelegate,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIActionSheetDelegate,ShuangSeQiuInfoDelegate>{

//    ZuCaiHuoShuZi * zuhuoshu;//足篮彩或数字彩 传参
    
    // 刷新控件
    CBRefreshTableHeaderView *mRefreshView;
 
    UIButton * zuixinBut;
    UIButton * renqiBut;
    UIButton * hongrenBut;
    UITableView * myTableView;
    ASIHTTPRequest * httpRequest;
    NSString * caizhongstr;//彩种的传递
    NSInteger lotteryType;//传参
    NSString * currentIssue;
    GC_LotteryTime *lotteryTime;
    NSMutableArray * schemeArray;
    MoreLoadCell *moreCell;
    NSInteger manyuan;
    UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
    NSMutableArray * seachTextListarry;//搜索数组
    NSString * lotteryId;
    NSString * Nickname;
    NSString * userid;
    NSString * username;
    BOOL isQuxiao;
    BOOL isLoading;
    CP_TabBarViewController * tabc;
    NSString * paixustr;
    BOOL goucaibool;//从购彩大厅过来
    UILabel  * titleLabel;
    UIImageView * sanjiaoImageView;
    CP_ThreeLevelNavigationView * tln;
    NSArray * wanArray;
    NSInteger modetype;
    NSString *sysTime;
    BOOL hmdtBool;//合买大厅的标示
     UpLoadView * loadview;
   
    int heMaiType;//4 实时
    
    int _lastPosition;
    
    BOOL isNeedPopToRoot;//由积分push进来后  需要pop回首页
}
@property(nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic, assign)NSInteger lotteryType;
@property (nonatomic, retain)NSString * caizhongstr;//彩种的传递
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSString * lotteryId,  * paixustr ,*sysTime;
@property (nonatomic, assign)BOOL goucaibool, hmdtBool,isNeedPopToRoot;;
//- (void)actionRefresh;
- (void)requestRed;
@end

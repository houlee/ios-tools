//
//  BettingViewController.h
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//参赛

#import <UIKit/UIKit.h>
#import "GC_BetCell.h"
#import "GC_BetData.h"
#import "Info.h"
#import "PKGameExplainViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "Info.h"
#import "GC_BetInfo.h"
#import "GC_IssueInfo.h"
#import "GC_IssueList.h"
#import "ProgressBar.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "CP_CanOpenCell.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "UpLoadView.h"
#import "CP_TabBarViewController.h"
#import "NeutralityMatchView.h"
#import "FootballForecastViewController.h"
typedef enum {
    bettingStypeShisichang,
    bettingStypeRenjiu
   
}BettingStype;

@interface GCSPLBettingViewController : CPViewController <CP_TabBarConDelegate,CP_KindsOfChooseDelegate,CP_ThreeLevelNavDelegate, CP_CanOpenCellDelegate,PrograssBarBtnDelegate,PKBetCellDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,FootballForecastDelegate, NeutralityMatchViewDelegate>{
    UpLoadView * loadview;
    NSMutableArray * pkArray;//保存数据
    GC_BetData * pkbetdata;//数据接口
    CP_CanOpenTableView * myTableView;
    ASIHTTPRequest * request;
    UILabel * oneLabel;
    UILabel * twoLabel;
     NSMutableArray * staArray;
     NSMutableDictionary * ContentOffDict;//保存滑动开的cell
    NSMutableArray * betArray;//可买期的数组
    NSMutableArray * dataArray;//保存数据的数组
    int one;
    int two;
    UIView * tabView;
    ASIHTTPRequest *httpRequest;
    GC_BetInfo *betInfo;
    NSMutableArray *matchList, *issueDetails;
    UIView * bgview;
    int but[13];
    UIView * imgev;
    NSMutableArray * issueArray;
    NSMutableArray * bettingArray;
    UILabel * titleLabel ;
    NSString * issString;
    BettingStype bettingstype;
    UIImageView * dotimage;
    UITextField * fbTextView;
    NSString * issueFuWu;
      UIImageView * txtImage;
    UIButton * castButton;//发表按钮
    NSInteger countjishuqi;
    NSInteger showButnIndex;
    NSInteger oldshowButnIndex;
    CP_ThreeLevelNavigationView * tln;
    NSMutableArray * kongzhiType;
    int zhankai[14];//展开的状态
    UIImageView * sanjiaoImageView;
     CP_TabBarViewController * tabc;
    UIView * titleJieqi;
    UILabel * jiezhilabel;
    NSMutableArray  *issueTypeArray;
    NSString * jiezhistring;
}
@property (nonatomic, retain)NSString * issueFuWu, *jiezhistring;
@property (nonatomic, retain)NSString * issString;
@property (nonatomic)BettingStype bettingstype;
@property (nonatomic, retain)NSMutableArray *matchList, *issueDetails;
@property(nonatomic, retain) ASIHTTPRequest *httpRequest;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic,retain)NSMutableArray * betArray;
- (void)tabBarView;
- (void)getIssueListRequest;
- (void)getFootballMatchRequest:(NSString *)_issue;
- (void)dismissSelf:(BOOL)animated;
@end

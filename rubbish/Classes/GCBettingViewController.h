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
#import "GC_BetRecordDetail.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "CP_CanOpenCell.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CPViewController.h"
#import "UpLoadView.h"
#import "CP_TabBarViewController.h"
#import "CP_UIAlertView.h"
#import "FootballForecastViewController.h"
#import "NeutralityMatchView.h"

typedef enum {
    bettingStypeShisichang,
    bettingStypeRenjiu
}BettingStype;

@interface GCBettingViewController : CPViewController <CP_UIAlertViewDelegate,CP_TabBarConDelegate,CP_ThreeLevelNavDelegate,CP_CanOpenCellDelegate,PKBetCellDelegate, UITableViewDelegate, UITableViewDataSource,FootballForecastDelegate, NeutralityMatchViewDelegate>{
    UpLoadView * loadview;
    NSMutableArray * pkArray;//保存数据
    GC_BetData * pkbetdata;//数据接口
    CP_CanOpenTableView * myTableView;
    ASIHTTPRequest * request;
    UILabel * oneLabel;
    UILabel * twoLabel;
    NSMutableArray * betArray;//可买期的数组
    NSMutableArray * dataArray;//保存数据的数组
    int one;
    int two;
     NSMutableDictionary * ContentOffDict;//保存滑动开的cell
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
    UIButton * castButton;//投注按钮
	BOOL isHemai;
    NSMutableArray * staArray;
    BOOL chaodanbool;
    GC_BetRecordDetail * betrecorinfo;
    NSInteger countchao;
    NSInteger chaocount;
     BOOL panduanbool;
     BOOL panduanzhongjie;
    NSInteger zhongjiecount;
    NSInteger countchang;
    NSInteger jilujiu;
    UILabel * fieldLable;
    
    BOOL shedan;
    NSMutableArray * shedanArr;//设胆数组
    NSMutableArray * m_shedanArr;//设胆后每选中一场几个
    NSMutableDictionary * zhushuDic;
    NSInteger countjishuqi;
    NSInteger butcount;
    NSInteger showButnIndex;
    NSInteger oldshowButnIndex;
    CP_ThreeLevelNavigationView * tln;
    NSMutableArray * kongzhiType;
    BOOL diyici;
    int zhankai[14];//展开的状态
    UIImageView * sanjiaoImageView;
    NSString * jiezhistring;
    UIView * titleJieqi;
    NSString * saveDangQianIssue;
     CP_TabBarViewController * tabc;
    NSString * sysTimeSave;//保存存入数据的时间
    BOOL sendBool;//切换点击判断
    NSMutableArray * retArray;//保存返回的数组；
    NSMutableArray * kongArray;//保存所有控件的数组
    NSString * sysTime;//保存系统时间
    NSMutableArray * issueTypeArray;//期号状态所有保存
    BOOL judgeBool;
    UILabel * jiezhilabel;
    //    NSMutableDictionary *selectedItemsDic;// 归纳后的 选项
}
//@property(nonatomic, retain) NSMutableDictionary *selectedItemsDic;
@property (nonatomic, retain)NSMutableArray * retArray, *kongArray;
@property (nonatomic, retain)GC_BetRecordDetail * betrecorinfo;
@property (nonatomic, retain)NSString * issString, * saveDangQianIssue;
@property (nonatomic)BettingStype bettingstype;
@property (nonatomic, retain)NSMutableArray *matchList, *issueDetails;
@property(nonatomic, retain) ASIHTTPRequest *httpRequest;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic,retain)NSMutableArray * betArray;
@property (nonatomic, assign)BOOL isHemai, chaodanbool;
@property (nonatomic, retain)NSString *jiezhistring, * sysTimeSave, *sysTime;
- (void)pressQingButton:(UIButton *)sender;
- (void)tabBarView;
- (void)getIssueListRequest;
- (void)getFootballMatchRequest:(NSString *)_issue;
- (void)chaodanshuzu;
- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
@end

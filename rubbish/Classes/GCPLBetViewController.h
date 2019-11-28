//
//  BettingViewController.h
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//参赛

#import <UIKit/UIKit.h>
#import "GC_JCBetCell.h"
#import "GC_BetData.h"
#import "Info.h"
#import "PKGameExplainViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "JSON.h"
#import "Info.h"
#import "ASIFormDataRequest.h"
#import "ProgressBar.h"
#import "GC_BiFenCell.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "CP_CanOpenCell.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "UpLoadView.h"
#import "CP_TabBarViewController.h"
#import "UISortView.h"
#import "FootballForecastViewController.h"
#import "NeutralityMatchView.h"
#import "GoalsForCell.h"
#import "GC_BJdcCell.h"
#import "BDHalfCell.h"
#import "BDScoreCell.h"
typedef enum {
	matchEnumShengPingFuGuoGuan,
    matchEnumBiFenGuoguan,
    matchenumZongJinQiuShu,
    matchenumBanQuanChang,
    matchEnumShengPingFuDanGuan,
    matchEnumZongJinQiuShuDanGuan,
    matchEnumBanQuanChangDanGuan,
    matchEnumBiFenDanGuan,
    matchEnumRangQiuShengPingFuGuoGuan,
    matchEnumRangQiuShengPingFuDanGuan
}MatchEnum;
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface GCPLBetViewController : CPViewController <CP_TabBarConDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate ,GC_BiFenCellDelegate,PrograssBarBtnDelegate,GCJCCellDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UISortViewDelegate,FootballForecastDelegate, NeutralityMatchViewDelegate,GoalsForCellDelegate,GC_BJdcCellDelegate, BDHalfCellDelegate, BDScoreCellDelegate>{
    UpLoadView * loadview;
    CP_TabBarViewController * tabc;
    NSMutableArray * pkArray;//保存数据
    GC_BetData * pkbetdata;//数据接口
    CP_CanOpenTableView * myTableView;
 //   ASIHTTPRequest * request;
    UILabel * oneLabel;
    UILabel * twoLabel;
    NSMutableArray * betArray;//可买期的数组
    NSMutableArray * dataArray;//保存数据的数组
    int one;
    int two;
    UIView * tabView;
     BOOL zhuanjiaBool;
    UIView * tabhead;
    UILabel * titleLabel ;
    NSMutableDictionary * ContentOffDict;//保存滑动开的cell
    UIView * bgview;
    UIView * imgev;
    NSMutableArray * issueArray;
    int but[13];
    int butt[17];
    NSString * issString;
    UIView * bgviewdown;
    UIView * imagevv;
    UIImageView * bgimagedown;
    UIView * cbgview;
    UIView * cimgev;
    int buf[160];
    ASINetworkQueue *networkQueue;
    NSInteger lotteryID;
    ASIHTTPRequest *httprequest;
    NSMutableArray *resultList;
    NSMutableArray * qihaoArray;
    NSMutableArray * saishiArray;
    NSArray * wanArray;
    NSMutableArray * cellarray;
    NSMutableArray * allcellarr;
    UIButton * chuanButton1;
    NSInteger cout;
    NSInteger nengcout;
    BOOL shedan;
    NSMutableDictionary *selectedItemsDic;// 归纳后的 选项
    NSMutableDictionary *danDic;// 放置 “设胆”选项
    NSMutableDictionary * zhushuDic;
    NSMutableDictionary * chuanfadic;
    
    UITextField * fbTextView;//输入框
    
    ASIHTTPRequest * requestt;
    NSDictionary * zhushudict;
    UIButton * castButton;
    UILabel * labelch;
    int onecont;
    UILabel * textlabel;
    UIImageView * txtImage;
    NSMutableArray * shedanArr;
    NSMutableArray * m_shedanArr;
    int twocount;
     NSInteger butcount;
    NSInteger allbutcount;
    NSInteger addchuan;
    NSMutableArray * kebianzidian;
     MatchEnum matchenum;
     NSInteger tagbao;
    int buffer[100];
    NSString * issuestr;
    NSString * systimestr;
    BOOL chaobool;
    NSInteger countjishuqi;
    BOOL panduanbool;
    BOOL panduanzhongjie;
    UIImageView * upimageview;
    CP_ThreeLevelNavigationView * tln;
    NSMutableArray * chuantype;
    NSMutableArray * kongzhiType;
    NSMutableArray * duoXuanArr;
    NSInteger showButnIndex;
    NSInteger oldshowButnIndex;
    UILabel * pourLable ;
    UILabel * fieldLable;
        NSMutableDictionary * wangqiArray;//往期
    NSString * timezhongjie;
    NSInteger  biaoshi;
    int zhankai[50][200];//展开的状态
    UIImageView * sanjiaoImageView;
    NSInteger sortCount;//记录当前的排序是哪一个
     UISortView * headView;
    BOOL worldCupBool;
    UIButton * worldCupButton;
    UIView *titleView;
    UIButton * qingbutton;
}
@property(nonatomic, retain) NSMutableDictionary *danDic;
@property(nonatomic, retain) NSMutableDictionary *selectedItemsDic;
@property(nonatomic,retain)  NSMutableArray *resultList;
@property(nonatomic,retain) ASIHTTPRequest *httprequest;
@property(nonatomic, assign) NSInteger lotteryID; 
@property (nonatomic, retain)NSString * issString, * systimestr;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * requestt;
@property (nonatomic,retain)NSMutableArray * betArray;
@property (nonatomic, assign)BOOL worldCupBool;
- (void)tabBarView;
- (id)initWithLotteryID:(NSInteger)lotteryId;
- (NSString *)getSystemTodayTime;
-(NSString*)chosedGameSet;
-(int)minGameID;
-(int)maxGameID;
- (NSString*)passTypeSetAndchosedGameSet;
- (void)dismissSelf:(BOOL)animated;
- (void)requestHttpQingqiu;
- (void)chuanwuzhihou:(UIButton *)sender;
- (void)dayushiwuchang;
- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
- (void)returnBoolDanbifen:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
@end

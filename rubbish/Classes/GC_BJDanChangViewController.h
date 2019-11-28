//
//  GC_BJDanChangViewController.h
//  caibo
//
//  Created by houchenguang on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//
//#import <UIKit/UIKit.h>
//
//@interface GC_BJDanChangViewController : UIViewController
//
//@end



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
#import "ASIHTTPRequest.h"
#import "GC_BJdcCell.h"
#import "GC_BetInfo.h"
#import "GC_BetRecordDetail.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "CP_CanOpenCell.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "UpLoadView.h"
#import "CP_TabBarViewController.h"
#import "CP_UIAlertView.h"
#import "GoalsForCell.h"
#import "OneDoubleCell.h"
#import "BDHalfCell.h"
#import "BDScoreCell.h"
#import "VictoryOrDefeatTableViewCell.h"
#import "FootballForecastViewController.h"
#import "NeutralityMatchView.h"
typedef enum {
	
    MatchRangQiuShengPingFu,
    MatchJinQiuShu,
    MatchShangXiaDanShuang,
    MatchBiFen,
    matchBanQuanChang,
    MatchShengFuGuoGan,
    
}BJMatchType;




@interface GC_BJDanChangViewController : CPViewController <CP_UIAlertViewDelegate, CP_TabBarConDelegate,CP_KindsOfChooseDelegate,CP_ThreeLevelNavDelegate,CP_CanOpenCellDelegate,GC_BJdcCellDelegate, UITableViewDelegate, UITableViewDataSource, GoalsForCellDelegate, OneDoubleCellDelegate, BDHalfCellDelegate,BDScoreCellDelegate, VictoryOrDefeatDelegate, FootballForecastDelegate, NeutralityMatchViewDelegate>{
    
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
    UILabel * titleLabel ;
    UIView * bgview;
    UIView * imgev;
    //    NSMutableArray * issueArray;
//    int but[13];
    int butt[150];
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
    UIButton * castButton;
    NSMutableDictionary * chuanfadic;
    UILabel * labelch;
    int onecont;
    int twocount;
    UILabel * textlabel;
    NSMutableArray * shedanArr;//设胆数组
    NSMutableArray * m_shedanArr;//设胆后每选中一场几个
    NSMutableArray * selebutarr;//选中哪几场
    NSMutableDictionary * danbutDic;//那一行 胆为0 1
    NSInteger butcount;//hang
    NSInteger allbutcount;//所有button
    ASIHTTPRequest * yujirequest;
    NSInteger addchuan;
	BOOL isHeMai;
    GC_BetInfo *betInfo;
    int buffer[100];
    NSInteger tagbao;
    UIView * imagissue;
    //    NSMutableArray * staArray;
    NSTimer * timeopen;
    BOOL timebool;
    BOOL benqiboo;
    BOOL chaodanbool;
    BOOL panduanbool;
    BOOL panduanzhongjie;
    NSMutableArray * kebianzidian;
    
    GC_BetRecordDetail * betrecorinfo;
    NSInteger countchao;
    NSInteger chaocount;
    NSInteger countjishuqi;
    NSInteger showButnIndex;
    NSInteger oldshowButnIndex;
    CP_ThreeLevelNavigationView * tln;
    NSMutableArray * chuantype;
    NSMutableArray * kongzhiType;
    NSMutableArray * duoXuanArr;
    UILabel * fieldLable;
    UILabel * pourLable;
    BOOL diyici;
    //    int zhankai[50][200];//展开的状态
    UIImageView * sanjiaoImageView;
    NSString * sysTimeSave;//保存存入数据的时间
    ASIHTTPRequest * httpRequest;
    BOOL sendBool;//切换点击判断
    NSMutableArray * retArray;//保存返回的数组；
    NSMutableArray * kongArray;//保存所有控件的数组
    CP_KindsOfChoose * kindChoose;//保存控件
    BOOL judgeBool;//判断是否比暂存的少
    NSMutableArray * issueTypeArray;//期号状态所有保存
    BJMatchType matchType;//枚举类型 是那种玩法
    NSMutableDictionary * ContentOffDict;//保存滑动开的cell
    UIImageView * recordImage;
    UILabel * recordLabel;
    //    UIImageView * upimageview;
    BOOL hasDanBool;
    BOOL request150Bool;
    ASIHTTPRequest * httprequest150;
    
    NSMutableArray * sfMatchArray;
    
    NSMutableArray * sfIssueArray;
    
    NSString * sfissueString;
    NSString * qtissueString;
    BOOL bdwfBool;
    BOOL kongzhiBool;
    NSMutableArray * sfKongzhiType;
    NSString * wfNameString;
    NSMutableArray * shengfuTypeArray;
    UIImageView * sxImageView;
    BOOL allButtonBool;//赛事筛选全部的按钮
    BOOL fiveButtonBool;//仅五大联赛按钮
}
@property (nonatomic, assign)BJMatchType matchType;
@property (nonatomic, retain)CP_KindsOfChoose * kindChoose;
@property (nonatomic, retain)NSMutableArray * retArray, *kongArray;
@property (nonatomic, retain)ASIHTTPRequest * yujirequest, * httpRequest;
@property(nonatomic, retain) NSMutableDictionary *danDic;
@property(nonatomic, retain) NSMutableDictionary *selectedItemsDic;
@property(nonatomic,retain)  NSMutableArray *resultList;
@property(nonatomic,retain) ASIHTTPRequest *httprequest, * httprequest150;
@property(nonatomic, assign) NSInteger lotteryID;
@property (nonatomic, retain)NSString * issString,*sysTimeSave;
@property (nonatomic, retain)NSMutableArray * dataArray;
//@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic,retain)NSMutableArray * betArray;
@property (nonatomic, assign)BOOL isHeMai, chaodanbool;
@property (nonatomic, retain)GC_BetRecordDetail * betrecorinfo;
@property (nonatomic, retain)NSString * sfissueString, * qtissueString, * wfNameString;
- (void)tabBarView;
- (id)initWithLotteryID:(NSInteger)lotteryId;
- (NSString *)getSystemTodayTime;
- (void)requestHttpQingqiu;
- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
//预计奖金请求
- (void)requestYujiJangjin;
//场次信息
- (NSString *)issueInfoReturn;
//投注欧赔
- (NSString *)touzhuOpeiReturn;
- (void)chuanwuzhihou:(UIButton *)sender;

//北单对阵
- (void)requestBeiJingDanChangDuiZhen;
//北单赛事
//- (void)requestBeiDanSaiShi;
//北单期号
- (void)getIssueListRequest;
//北单投注
- (void)beiDanTouZhu;
//- (void)dayushiwuchang:(NSString *)index;
- (void)pressChuanJiuGongGe:(UIButton *)sender;
- (void)chaodanshuzu;
- (void)pressQingButton;

@end

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
#import "GC_BiFenCell.h"
#import "GC_BetRecordDetail.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "CP_CanOpenCell.h"
#import "CP_ThreeLevelNavigationView.h"
#import "UpLoadView.h"
#import "CP_TabBarViewController.h"
#import "CP_UIAlertView.h"
#import "HunTouCell.h"

#import "UISortView.h"
#import "FootballForecastViewController.h"
#import "NeutralityMatchView.h"
#import "GoalsForCell.h"
#import "GC_BJdcCell.h"
#import "BDHalfCell.h"
#import "BDScoreCell.h"
#import "HunHeErXuanYiTableViewCell.h"
#import "BasketballTwoButtonCell.h"
#import "BigHunTouCell.h"

typedef enum {
    matchEnumShengPingFuGuoGuan,
    matchEnumBiFenGuoguan,
    matchenumZongJinQiuShu,
    matchenumBanQuanChang,
    matchEnumShengPingFuDanGuan,
    matchEnumZongJinQiuShuDanGuan,
    matchEnumBanQuanChangDanGuan,
    matchEnumBiFenDanGuan,
    matchEnumShengFuGuoguan,
    matchEnumRangFenShengFuGuoguan,
    matchEnumShengFenChaGuoguan,
    matchEnumDaXiaFenGuoguan,
    matchEnumShengFuDanGuan,
    matchEnumRangFenShengFuDanGuan,
    matchEnumShengFenChaDanGuan,
    matchEnumDaXiaoFenDanGuan,
    matchEnumRangQiuShengPingFuGuoGuan,
    matchEnumRangQiuShengPingFuDanGuan,
    matchEnumHunHeGuoGuan,
    matchEnumHunHeErXuanYi,
    MatchEnumLanqiuHunTou,//18
    matchEnumBigHunHeGuoGan,
}MatchEnum;

typedef enum {
    
    dgMatchShengfu = 333,
    dgMatchBifen = 444,
    
} DGMatchType;

@interface GCJCBetViewController : CPViewController <UISortViewDelegate,CP_UIAlertViewDelegate,CP_TabBarConDelegate,CP_ThreeLevelNavDelegate,CP_CanOpenCellDelegate,GCJCCellDelegate, GC_BiFenCellDelegate, UITableViewDelegate, UITableViewDataSource, HunTouCellDelegate,FootballForecastDelegate,NeutralityMatchViewDelegate, GoalsForCellDelegate,GC_BJdcCellDelegate, BDHalfCellDelegate, BDScoreCellDelegate,HunHeErXuanYiDelegate, BasketballTwoButtonDelegate, BigHunTouDelegate>{
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
    NSMutableArray * issueArray;
    int but[1300];
    int butt[160];
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
    NSMutableArray * kebianzidian;
    int buffer[160];
    NSInteger tagbao;
    MatchEnum matchenum;
    BOOL panduanbool;
    BOOL panduanzhongjie;
    BOOL chaodanbool;//是否抄单
    GC_BetRecordDetail * betrecorinfo;
    NSInteger countchao;
    NSInteger chaocount;//抄单计数器 防止第二次抄单
    NSString * systimestr;
    
    BOOL lanqiubool;
    NSInteger countjishuqi;
    BOOL chaobool;//判断抄单 是否是单关
    NSInteger showButnIndex;
    NSInteger oldshowButnIndex;
    UIImageView * upimageview;
    CP_ThreeLevelNavigationView * tln;
    CP_TabBarViewController * tabc;
    NSMutableArray * chuantype;
    NSMutableArray * kongzhiType;
    NSMutableArray * duoXuanArr;
    BOOL celldanbool;
    UILabel * pourLable;
    UILabel * fieldLable;
    NSMutableDictionary * wangqiArray;//往期
    //    NSInteger zhushucount;
    //    NSInteger qianshucount;
    //    int bufjishu[100];
    //    NSMutableDictionary * chuanfadict;
    NSString * timezhongjie;
    NSInteger  biaoshi;//标示第一段 1 和 第二段 2
    //    BOOL diyici;
    //    NSMutableArray * zhanKaiArray;
    int zhankai[50][200];//展开的状态
    UIImageView * sanjiaoImageView;
    UpLoadView * loadview;
    UIView * yindaoview;
    BOOL oneHead;//标记第一段在数据删除完 做的标记 下次不用再请求
    BOOL twoHead;//标记第二段在数据删除完 做的标记 下次不用再请求
    ASIHTTPRequest * httpRequest;
    NSString * sysTimeSave;//保存数据时间
    NSMutableArray * retArray;//保存返回的数组；
    NSMutableArray * kongArray;//保存所有控件的数组
    BOOL sendBool;
    BOOL judgeBool;
    UILabel * wanfaLabel;
    BOOL sfcBool;//是否选择胜分差
    NSInteger sfcDanCount;//篮球混合过关设胆的个数
    NSMutableDictionary * ContentOffDict;//保存滑动开的cell
    BOOL buttonBool;//是否是按钮点击的
    BOOL preDanBool;
    
    UIImageView * recordImage;//无记录图片
    UILabel * recordLabel;//暂无无记录文字
    NSInteger sortCount;//记录当前的排序是哪一个
    UISortView * headView;
    BOOL zhuanjiaBool;
    BOOL onlyDG;//只单关
    NSMutableDictionary * duckDictionary;
    BOOL worldCupBool;
    UIButton * worldCupButton;
    UIView *titleView;
    BOOL tableViewCellBool;
    UIButton * qingbutton;
    NSInteger markBigHunTou; //1为只包含胜平负、让球胜平负玩法 2投注中包含总进球数玩法 3投注中包含包含半全场胜平负、比分玩法
    UIView * tabhead;
    BOOL onePlayingBool;
    BOOL oneDoubleBool;
    NSInteger oneSPFCount;
    BOOL gcdgBool;//从购彩大厅过来的 单关
    BOOL lunboBool; //是否由轮播图跳转
    UIImageView * sxImageView;
    NSString * beginTime;//beginTime点选好的提示 在时间范围内的话
    NSString * beginInfo;//提示内容
    DGMatchType dgType;
    
    BOOL canShow;//是否调用弹窗方法
    
    BOOL allButtonBool;//赛事筛选全部的按钮
    BOOL fiveButtonBool;//仅五大联赛按钮
}
@property (nonatomic, retain)NSMutableArray * retArray, *kongArray;
@property (nonatomic, retain)NSString * sysTimeSave, * beginTime, * beginInfo;
@property (nonatomic, assign)MatchEnum matchenum;
@property (nonatomic, retain)GC_BetRecordDetail * betrecorinfo;
@property (nonatomic, retain)ASIHTTPRequest * yujirequest, * httpRequest;
@property(nonatomic, retain) NSMutableDictionary *danDic;
@property(nonatomic, retain) NSMutableDictionary *selectedItemsDic;
@property(nonatomic,retain)  NSMutableArray *resultList;
@property(nonatomic,retain) ASIHTTPRequest *httprequest;
@property(nonatomic, assign) NSInteger lotteryID;
@property (nonatomic, retain)NSString * issString, * systimestr, * timezhongjie;
@property (nonatomic, retain)NSMutableArray * dataArray;
//@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic,retain)NSMutableArray * betArray;
@property (nonatomic, assign)BOOL isHeMai, chaodanbool, lanqiubool, worldCupBool, gcdgBool,lunboBool;
@property (nonatomic, assign)DGMatchType dgType;
@property (nonatomic,retain)NSDictionary *zhuanjiaDic;
@property(nonatomic,copy)NSString *cc_id;
- (void)tabBarView;
- (id)initWithLotteryID:(NSInteger)lotteryId;
- (NSString *)getSystemTodayTime;
- (void)requestHttpQingqiu;
- (void)pressChuanJiuGongGe:(UIButton *)sender;

- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
- (void)returnBoolDanbifen:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;
//预计奖金请求
- (void)requestYujiJangjin;
//场次信息
- (NSString *)issueInfoReturn;
//投注欧赔
- (NSString *)touzhuOpeiReturn;
- (void)chuanwuzhihou:(UIButton *)sender;
- (void)dayushiwuchang;
- (void)chaodanshuzu;
- (void)pressQingButton:(UIButton *)sender;
@end

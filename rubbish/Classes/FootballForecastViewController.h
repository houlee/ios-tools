//
//  FootballForecastViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-20.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "MatchBetView.h"
#import "OddsTableViewCell.h"
#import "ListViewScrollView.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "GC_BetData.h"
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"
#import "IntegralAlertView.h"
#import "UIProportionView.h"
#import "UIynopsisView.h"
#import "UIIntegralView.h"
typedef enum{
    
    fjcHunheguoguanType,
    fjcShengpingfuType,
    fjcZongjinqiuType,
    fjcBanchangshengpingfuType,
    fjcBifenType,
    fjcHunheerxuanyiType,
    fsfcshengpingfuType,
    
    fbdRangqiushengpingfuType,
    fbdJinqiushuType,
    fbdShangxiadanshuangType,
    fbdBifenType,
    fbdBanquanchangType,
    fbdShengfuguoguanType,
    
    fzhonglichangType,
    fjiaohuanType,
    fjieqiType,
    
} ForecastMatchType;

typedef enum{
    jingcaitype,
    beidantype,
    shengfucaitype,
}FootballLotteryTYPE;

typedef enum{
    
    commonType,
    halfType,
    allType,
    
}TrendType;

@interface FootballForecastViewController : CPViewController<MatchBetViewDelegate, UITableViewDataSource, UITableViewDelegate, OddsTableViewCellDelegate, ListViewDelegate, UIScrollViewDelegate,CP_ThreeLevelNavDelegate, CP_KindsOfChooseDelegate, UIynopsisViewDelegate>{

    ForecastMatchType matchShowType;
    MatchBetView * macthView;
    UIScrollView * myScrollView;
    float allHight; // 分析中心全局的高度
    float oddsHight;//欧赔中心的高度
    UIView * analyzeView;
    UIView * oddsView;
    BOOL oddsViewBool;//标记赔率中心是否创建
    BOOL analyzeBool;//标记分析中心是否创建
    UITableView * oddsTabelView;
    int buf[100];
    BOOL analyzeOrOdds;
    CP_ThreeLevelNavigationView * tln;
    GC_BetData * betData;
    NSIndexPath * gcIndexPath;
    id delegate;
    NSInteger typeBack;
    ASIHTTPRequest * httpRequest;
    
    NSMutableDictionary * analyzeDictionary;//分析中心数据
    NSMutableDictionary * oddsDictionary;//赔率中心数据
    UILabel * combatLabel;
    UILabel * combatTwoLabel;
    UILabel * oneCombatLabel;
    UILabel * twoCombatLabel;
    NSString * numString;
    UIScrollView * combatScrollView;
    NSString * integralString;
    NSInteger oddsInteger;
    UpLoadView * loadview;
    UIView * teamTitleView;
    UILabel *titleLabel;
    FootballLotteryTYPE lotteryType;
    UIView * segmentView;
    TrendType trendType;
    UIView * infoView;
    UIView * combatView;
    
    UITableView * rankingTabelView;//排名
    UITableView * bulletinTabelView;//简报
    UIView * rankingBulletinViewHead;
    
    NSMutableDictionary * rankingDictionary;//排名数据
    NSMutableDictionary * bulletinDictionary;//简报数据
    BOOL rankingOneBool;
    BOOL rankingTwoBool;
    BOOL bulletinOneBool;
    BOOL bulletinTwoBool;
    IntegralAlertView * oneIntegral;
    IntegralAlertView * twoIntegral;
    UIProportionView * proportionView;
    UIynopsisView * ynopsisView;
    UIIntegralView * IntegralView;
}

@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, retain) NSIndexPath * gcIndexPath;
@property (nonatomic, assign)ForecastMatchType matchShowType;
@property (nonatomic, assign)id delegate;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain) NSMutableDictionary * analyzeDictionary, * oddsDictionary;
@property (nonatomic, retain)NSString * numString;
@property (nonatomic, retain)NSString * integralString;
@property (nonatomic, assign)FootballLotteryTYPE lotteryType;
@end

@protocol FootballForecastDelegate <NSObject>
@optional
- (void)footballForecastBetData:(GC_BetData *)_betData withType:(NSInteger)type indexPath:(NSIndexPath *)fIndexPatch;//上面选择彩果的回调 type 1 是按钮胜平负的那种 2是弹框数字的那种
@end

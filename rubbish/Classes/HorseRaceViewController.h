//
//  HorseRaceViewController.h
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
#import "ShuZiBetsView.h"
#import "HorseRaceTableViewCell.h"
#import "GC_UIkeyView.h"
#import "CP_TabBarViewController.h"

@class ShuZiBetsView;
@class JiFenBetInfo;
@class StatePopupView;

typedef enum {
    horse_q1 = 100000,
    horse_q2 = 200000,
    horse_q3 = 300000,
}HorseType;

@interface HorseRaceViewController : CPViewController <CP_ThreeLevelNavDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CP_UIAlertViewDelegate,ShuZiBetsViewDelegate,ASIHTTPRequestDelegate,HorseRaceTableViewCellDelegate,GC_UIkeyViewDelegate,CP_TabBarConDelegate>
{
    UIScrollView * topImageScrollView;//头部好多马的图在的scrollview
    UIScrollView * topViewScrollView;//头部倒计时在的scrollview
    UIView * blackView;//马图的遮挡
    UIScrollView * mainScrollView;//下边的scrollview
    
    UIView * topView;//放着期号之类的
    UILabel * topIssueLabel;//topView左侧的期号
    UILabel * topPlayTypeLabel;//等待开赛... ，开赛中
    UILabel * topNextIssueLabel;//topView右侧下期的期号
    UILabel * countdownLabel;//倒计时
    
    UITableView * betsTableView;//投注单
    NSArray * betsTitleArray;//投注单每行的标题
    NSArray * betsContentArray;//投注单每行提示
    
    NSTimer * countdownTimer;//倒计时
    NSTimer * yiLouTimer;//倒计时
    NSTimer * raceTimer;

    int seconds;//倒计时 秒

    UIImageView * racecourseImageView;//赛马场
    UIButton * racecourseBlackButton;//赛马场背景黑色
    
    BOOL gameShowing;//是否在比赛
    
    UIImageView * sideLineImageView;//赛马场边线
    UIImageView * sideLineImageView1;//收起时边线
    UIButton * watchGameButton;//赛马场观看比赛按钮
    
    ShuZiBetsView * shuZiBetsView;//投注区
//    UIView * firstLine;//第一名前边的线
    
    NSMutableArray * speedArray;//速度
    NSMutableArray * markArray;//是否计算过加速度
    NSMutableArray * accelerationArr;//加速度

    UIImageView * horseTrackImageView;//跑道
    NSMutableArray * finishGameArray;//已完成比赛的马
    
    NSMutableArray * aloneWinArray;//独赢数组
    NSMutableArray * consecutiveWinArray;//连赢数组
    NSMutableArray * aloneTArray;//单t数组
    NSMutableArray * selectedBetsArray;//投注区选择的
    NSString * selectedString;//选择的号码
    
    ASIHTTPRequest * getIssueRequest;
    ASIHTTPRequest * getJiFenRequest;

    BOOL isKaiJiang;//是否开奖
    BOOL canRefreshYiLou;
    BOOL hasYiLou;
    NSInteger yanchiTime;
    BOOL kaijianging;

    NSDictionary * yilouDic;
    NSString * myIssrecord;//存的期数

    UIView * lotteryNumberView;

    UIButton * playMethodButton;//玩法按钮
    UIView * betsBGView;//投注单下边
    
    UIButton * addButton;//添加
    
    NSMutableArray * playMethodTypeArr;
    
    UIButton * betButton;//立即下注
    
    int aloneWinBets;
    int consecutiveWinBets;
    int aloneTBets;
    int totalBets;
    
    ASIHTTPRequest * yilouRequest;
    
    NSString *issue;
    
    ASIHTTPRequest * betRequest;//投注
    
    JiFenBetInfo * betInfo;//投注信息
    
    CP_UIAlertView * betAlert;
    
    NSMutableDictionary * lotteryDic;
    
    NSString * newLotteryNumber;
    
    UIButton * windowButton;
    
    StatePopupView * statepop;

    int guideY;
    
    int keyCount;
    
    BOOL isAppear;
    
    BOOL canStopRunLoop;
    
    BOOL racecourseShowing;
    
    UIView * betListBGView;
    
    float horseMoveS;

    int trackLength;
    
    float paoDaoMoveX;
    
    NSArray * gifImageArray;
    
}

@property (nonatomic,retain)ASIHTTPRequest * getIssueRequest;
@property (nonatomic,retain)ASIHTTPRequest * getJiFenRequest;
@property (nonatomic,retain)ASIHTTPRequest * yilouRequest;
@property (nonatomic,retain)ASIHTTPRequest * betRequest;

@property (nonatomic,retain)NSDictionary * yilouDic;
@property (nonatomic,retain)NSString *myIssrecord;

@property (nonatomic,retain)NSTimer * countdownTimer;
@property (nonatomic,retain)NSTimer * yiLouTimer;
@property (nonatomic,retain)NSTimer * raceTimer;

@property (nonatomic,copy)NSString *issue;


@end

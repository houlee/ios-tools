//
//  ShuangSeQiuInfoViewController.h
//  caibo
//
//  Created by yao on 12-5-22.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_BetRecordDetail.h"
#import "GC_BetRecord.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "CPViewController.h"
#import "CPZhanKaiView.h"
#import "CP_PTButton.h"
#import "CP_UISegement.h"
#import "CP_LieBiaoView.h"
#import "CP_ThreeLevelNavigationView.h"
#import "MatchInfo.h"
#import "CBRefreshTableHeaderView.h"

@protocol ShuangSeQiuInfoDelegate <NSObject>

@optional
- (void)returnTypeAnswer:(NSInteger)answer;
-(void)buySuccess:(NSString *)success;
@end
typedef enum
{
    ShengFuCai,//胜负彩
    JingCaiZuqiu,//竞彩
    BeiDan,//北单
    AoYun1,//奥运的废弃
    AoYun2,//奥运的废弃
    AoYun3,//奥运的废弃
    LanQiufencha,//篮球胜分差
    LanQiuRangfen,//篮球让分
    LanQiuShengfu,//篮球胜负
    LanQiuDaxiafen,//篮球大小分
    LanQiuHunTou,//篮球混合
    ZuQiuDahunTou,//足球大混投
    Unsuort = 999,// 未知彩种
}TiCaiType;

@interface ShuangSeQiuInfoViewController : CPViewController<CP_lieBiaoDelegate,CP_ThreeLevelNavDelegate,ASIHTTPRequestDelegate,
UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CPZhanKaiViewDelegate,CBRefreshTableHeaderDelegate> {
	GC_BetRecordDetail *BetDetailInfo;//彩票详细信息
	BetRecordInfor *BetInfo;//彩票基本信息
	UITableView *myTableView;
	ASIHTTPRequest *httpRequest;
	BOOL isShuZi;//是否是数字彩
	BOOL isDanShi;//是否是单式上传
    BOOL isJJYH;//是否是奖金优化
	BOOL isMine;//是否是自己发起的
	TiCaiType ticaiType;//体彩类型
	NSArray *redArray;//红球数组
	NSArray *blueArray;//篮球数组
    BOOL guoguanme;
	
    CBRefreshTableHeaderView *refreshHeaderView;
    
	UIView *hemaiView;//合买view
	
	UIButton *sendBtn;//参与合买
	UITextField *rengouText;//认购输入框
	ColorView *yingfuLable;//应付金额lable
	ColorView *zhanghuLable;//账户余额
    BOOL hemaibool;//是否是合买
    UIImageView *tanchuView;
    NSString *issure;//，从微博来的时候传递
    NSString *orderId;//方案号；
    NSString *lottoryName;//方案名称；
    BOOL canBack;
    BOOL isBaomi;
    UIControl *con;
    NSString * maxmoney;
    NSString * minmoney;
    NSMutableArray * cellarray;
    NSMutableDictionary * zhushuDic;
    NSMutableArray *fengeArray;
    NSString *bendaZhongJiangJinE;
    UIScrollView *backScrollView;
    UIView *tableheadView;
    UIView *tableFootView;
    UIView *editeView;
    NSInteger recorderTime;
//    NSTimer *myTimer;
    NSTimer *shishiTimer;
    

    CP_PTButton *lingJiangBtn;
    UITextField *xuanyanText;
    CP_UISegement *mySegment;
    UIImageView *footImageV;
    CPZhanKaiView *footZhankaiV;
    UIView *zhedanView;
    CP_ThreeLevelNavigationView * tln;
    BOOL isJIangli;
    NSString * chuanzhuihao;//从投注传进来的几/几追期
    BOOL waibubool;//是否是从外面传入期号
    NSString * nikeName;//外面传进来的用户名 截图的时候用
    BOOL cheDanBool; //如果撤单成功 为yes 右上角按钮不能用
    CP_PTButton *shishiBtn;
    BOOL isShishi;// 时时比分是否开启
    MatchInfo *myMatchInfo;
    id<ShuangSeQiuInfoDelegate>delegate;
    NSInteger typeAnswer;//状态 撤单是否成功
    NSInteger requstFaildCount;//请求失败次数
    UIButton *BuyAgain;//再次购买
    
    NSString * yuE;
    
    BOOL isShowFangChenMi;
    
    BOOL isFromFlashAdAndLogin;
    BOOL isLoading;
    
    UILabel * placeholderLabel;
    BOOL  isHongrenBang;
    
    NSMutableArray * wanFaTitleArr;
    NSMutableArray * modeArray;

    BOOL canBuyAgain;
}
@property (nonatomic,assign)BOOL canBuyAgain;

@property (nonatomic, retain)NSString * nikeName;
@property (nonatomic,retain)GC_BetRecordDetail *BetDetailInfo;
@property (nonatomic,retain)BetRecordInfor *BetInfo;
@property (nonatomic,retain)ASIHTTPRequest *httpRequest;
@property (nonatomic,copy)NSString *bendaZhongJiangJinE;
@property (nonatomic,retain)NSArray *redArray;
@property (nonatomic,retain)NSArray *blueArray;
@property (nonatomic,assign)BOOL isMine, guoguanme, hemaibool;
@property (nonatomic,copy)NSString *issure,*orderId,*lottoryName;
@property (nonatomic)BOOL canBack;
@property (nonatomic,retain)NSTimer /**myTimer,*/*shishiTimer;
@property (nonatomic)BOOL isJiangli;
@property (nonatomic)BOOL waibubool;
@property (nonatomic, retain)NSString *chuanzhuihao;
@property (nonatomic, retain)MatchInfo *myMatchInfo;
@property (nonatomic, assign)id<ShuangSeQiuInfoDelegate>delegate;
@property (nonatomic, retain)NSString * yuE;
@property (nonatomic, assign) BOOL isFromFlashAdAndLogin,isHongrenBang;
@end

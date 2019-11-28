//
//  GC_ShengfuInfoViewController.h
//  caibo
//
//  Created by  on 12-5-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_BetInfo.h"
#import "GC_shengfucell.h"
#import "GC_AccountManage.h"
#import "GC_shengfudata.h"
#import "ASIFormDataRequest.h"
#import "GC_BetRecordDetail.h"
#import "CPViewController.h"
#import "CP_UISegement.h"
#import "ColorView.h"
#import "CP_SWButton.h"
#import "CP_UIAlertView.h"
#import "CP_PTButton.h"
#import "ChampionData.h"
#import "GC_UIkeyView.h"
#import "GC_BuyLottery.h"
#import "Xieyi365ViewController.h"
typedef enum{
    shisichangpiao,
    renjiupiao,
    jingcaipiao,
    beijingdanchang,
    ayshengfuguogan,
    aydiyiming,
    ayjinyintong,
    jingcaibifen,
    banquanchangshengpingfu,
    zongjinqiushu,
    jingcailanqiushengfu,
    jingcailanqiurangfenshengfu,
    jingcailanqiushengfencha,
    jingcailanqiudaxiaofen,
    jingcairangfenshengfu,
    jingcaihuntou,
    jingcaihuntouerxuanyi,
    lanqiuhuntou,
    beidanjinqiushu,
    beidanshangxiadanshuang,
    beidanbifen,
    beidanbanquanchang,
    beidanshengfuguoguan,
    guanjunwanfa,
    guanyajunwanfa,
    jingcaidahuntou,
    
} Caifenzhong;


@interface GC_ShengfuInfoViewController : CPViewController<GC_UIkeyViewDelegate,CP_UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>{
    UITableView * myTableView;
    UITextField * numtextfield;
    NSArray * bettingArray;
    NSString * moneynum;
    NSString * zhushu;
    ASIHTTPRequest * httpRequest;
    GC_BetInfo * betInfo;
    CGFloat balance;
    UIImageView * leftimage;
    UIImageView * cuimage;
    UIImageView * rigimage;
    UIImageView * yinshenImage;
    
    UIButton * buttonleft;
    UIButton * buttoncuston;
    UIButton * buttonright;
    UIButton * buttonYinShen;
    NSMutableArray * dataAr;
    UILabel * moneylabel;
    ASIHTTPRequest *httpReq;
    GC_AccountManage *accountManage;
    BOOL jingcai;
    ASIFormDataRequest * dataRequest;
    NSString * urlstring;
    NSDictionary * zhushudict;
    Caifenzhong fenzhong;
    NSInteger baomileixing;
    NSInteger danfushi;
//    UITextField *alertext;
    NSString * passWord;
    NSString * maxmoneystr;//最大金额
    NSString * minmoneystr;//最小金额
    UILabel * yujimoney;
	
	UISwitch *hemaiSwitch;
	BOOL isHeMai;
    BOOL hemaibool;
    BOOL beidanbool;//是否是北单
    UILabel * buttonLabel1;
    UIButton * touzhubut;
    NSString * issString;
    BOOL chaodanbool;
    GC_BetRecordDetail *BetDetailInfo;
    NSString * qihaostring;
    BOOL bianjibool;
    BOOL isGoBuy;
    BOOL maxmoney;
    UILabel * qianla;
    UILabel * yuanla;
    UILabel * yuela;
    UILabel * gerenyuela;
    UILabel * yuanyla;
    ColorView * fanweila;
    UILabel * mathname;
    NSString * systimestr;
    UILabel * beitou;
    UIImageView * upimagebg;
    UIImageView * tvbg;
    UIImageView *imageViewkey;
//    BOOL danguanbool;//标记是否是单关
   // int countdata;
//    UIView * editeView;
//    CP_UISegement * mySegment;
    NSString * matchNameString;
    NSInteger textcount;//键盘中间记录
    NSString * saveKey;//传入保存的key 投注成功后 会根据这个key来清除保存的数据
    BOOL isxianshiyouhuaBtn;//是否显示奖金优化按钮，多串的时候不显示
    BOOL youhuaBool;//奖金优化 显示 5场以下显示可点击，5场以上有提示
    BOOL youhuaZhichi;//是否支持奖金优化 12个彩果以下可点击
    CP_PTButton * yhButton;
    ChampionData * championData;
    NSString * matchId;
//    NSTimer * timer ;
    UIImageView *downbgImageView; //下view
    
    
    BOOL isShowFangChenMi; //当前次投注是否显示过防沉迷
    
    BOOL isShowingKeyboard;//倍投键盘
    BOOL rightBool;//混合二选一投注赔率是否正确
    GC_UIkeyView * gckeyView;
    
    GC_BuyLottery *buyResult;
    BOOL onePlayingBool;//是否是单一的玩法 混合过关
    BOOL oneDoubleBool;//是否是单关 混合过关
    NSInteger oneSPFCount;// 1是胜平负 2是让球胜平负
    
    UIView *xieyiView;
    int beitouNumber;
}
@property (nonatomic, retain) GC_BuyLottery *buyResult;
@property (nonatomic, retain)ChampionData * championData;
@property (nonatomic,retain)GC_BetRecordDetail *BetDetailInfo;
@property (nonatomic, retain)NSString * maxmoneystr, * minmoneystr, * issString, * systimestr , * matchId;
@property (nonatomic, assign)NSInteger danfushi;
@property (nonatomic)Caifenzhong fenzhong;
@property (nonatomic, retain)NSDictionary * zhushudict;
@property (nonatomic, retain)NSString * urlstring;
@property (nonatomic, retain)ASIFormDataRequest * dataRequest;
@property (nonatomic)BOOL jingcai, beidanbool;

@property (nonatomic, retain) GC_AccountManage *accountManage;
@property (nonatomic, retain)ASIHTTPRequest * httpReq;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSString * zhushu, * qihaostring, *saveKey, * passWord;
@property (nonatomic, retain)NSString * moneynum;
@property (nonatomic, retain)NSArray * bettingArray;
@property(nonatomic, retain) GC_BetInfo *betInfo;
@property (nonatomic, assign)NSInteger oneSPFCount;
@property (nonatomic,assign)BOOL isHeMai, hemaibool, chaodanbool,bianjibool, youhuaBool,youhuaZhichi,isxianshiyouhuaBtn, onePlayingBool, oneDoubleBool;//danguanbool;

@property (nonatomic, assign) int beitouNumber;

- (void)getAccountInfoRequest;
- (void)getPersonalInfoRequest;
- (id)initWithBetInfo:(GC_BetInfo *)_betInfo;
- (NSString*)passTypeSetAndchosedGameSet;
-(NSString*)chosedGameSet;
-(int)maxGameID;
-(int)minGameID;
- (void)beiDanTouZhu;

- (id)initWithLotteryID:(Caifenzhong)caizhong;
- (void)passWordOpenUrl;
@end

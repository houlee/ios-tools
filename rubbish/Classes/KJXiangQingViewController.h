//
//  KJXiangQingViewController.h
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_TabBarViewController.h"
#import "WeiboSDK.h"

typedef enum {
    
    CP_LotteryZuCai,//足彩
    CP_LotteryShuZiCai,//数字
    
}CP_LotteryType;

@class PKMyRankingList;

@interface KJXiangQingViewController : CPViewController<CP_TabBarConDelegate,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate,WeiboSDKDelegate>{
    UIScrollView * qiuscrollView;
    UIPageControl * pagecon;
    UIView * bgViewController;
    UITableView * myTabelView;
    UITableView * reyiTabelView;
    NSString * Luck_blueNumber;//幸运蓝球
    NSString * issuesting;//期号
    NSString * datestring;//时间
    NSString * qiustring;//开奖号码 球
    NSString * benstring;//本期销售
    NSString * chistring;//奖池
    NSArray * zhongarray;//中奖信息
    NSArray * reyiArray;//热议话题
    UIImageView * headimag;
    NSString * shisi;//十四金额
    NSString * renjiu;//任九金额
   
    UILabel * huatiLabel;
    NSString * huatistring;//话题
    NSString * cainame;
    NSMutableArray * toyarray;
    ASIHTTPRequest *mRequest;
    BOOL wangqibool;
    NSArray * lotteries;
    NSInteger sectionnum;
    NSInteger rownum;
    CP_LotteryType lotteryType;
    NSString * lotteryName;
    NSDictionary * matchdict;
    NSArray * paihangarr;
    ASIHTTPRequest * myHttpRequest;
    NSDictionary * zhongjiedict;
    NSString * lotteryNumber;
    CP_TabBarViewController * tabc;
    CP_TabBarViewController * ggtabc;
    BOOL isDangQianQi;      //是否是当前期，用于选择的时候显示奖金计算
    
    UILabel * weibolabel;//"微博热议"
    UIButton * passABarrierButton;
    UIButton * shareButton;//分享按钮
    UIImageView * shareImageView;
    UIImageView *jiangjinIma;
    
    UILabel * jiangjinLab;
    
    UIButton * jiangJinJiSuanButton;
    
    PKMyRankingList * horseRankList;
}
@property (nonatomic, retain)NSString * lotteryNumber;
@property (nonatomic, retain)ASIHTTPRequest*myHttpRequest;
@property (nonatomic, retain)NSDictionary * matchdict;
@property (nonatomic, retain)NSArray * paihangarr;
@property (nonatomic, assign)NSInteger sectionnum, rownum;
@property(nonatomic, retain)NSArray *lotteries;
@property (nonatomic, retain)NSString * issuesting,*lotteryName, * datestring, * qiustring, * benstring, * chistring, * shisi, * renjiu,  * huatistring, * cainame, * Luck_blueNumber;
@property (nonatomic, retain)NSArray * zhongarray, *reyiArray;
@property (nonatomic, retain)ASIHTTPRequest * mRequest;
@property (nonatomic, assign)BOOL wangqibool,isDangQianQi;
- (void)shangMianNieRong;
- (void)xiaMianNieRong;
- (id)initWithEnumeration:(CP_LotteryType)lotteryt;//初始化函数
+ (KJXiangQingViewController *) getShareDetailedView;
@end

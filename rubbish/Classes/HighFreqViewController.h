//
//  HighFreqViewController.h
//  caibo
//
//  Created by  on 12-6-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBallView.h"
#import "GC_LotteryType.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "WangqiKaJiangList.h"
#import "WangQiZhongJiang.h"
#import "CPViewController.h"
#import "CP_KindsOfChoose.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_UIAlertView.h"
#import "UpLoadView.h"
#import "New_PageControl.h"
#import "GifButton.h"
//#import "UIYiLouScrollView.h"

typedef enum {
    JiangXi11,//江西11选5
    ShanDong11,//山东11选5
    GuangDong11,//广东11选5
    HeBei11,//河北11选5
    ShanXi11,//陕西11选5
}ElevenType;

#define BOTTOM_HEIGHT 29
@class GouCaiShuZiInfoViewController;

@interface HighFreqViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,CP_KindsOfChooseDelegate,CP_ThreeLevelNavDelegate,UITableViewDataSource,UITableViewDelegate,CP_UIAlertViewDelegate,GifButtonDelegate>{

    UILabel * titleLabel;//tilte的文字标题
    NSArray * wanArray;
    int buf[13];
	
	UILabel *zhushuLabel;
	UILabel *jineLabel;
	NSString *issue;
	UIButton *senBtn;
	UIImageView *image1BackView;
	ModeTYPE modetype;
	
	ColorView *sqkaijiang;
	LotteryTYPE lotterytype;
	GouCaiShuZiInfoViewController *infoViewController;
	ASIHTTPRequest *myRequest;
	ASIHTTPRequest *qihaoReQuest;
	BOOL showXiaoxi;
	
	int seconds;
	NSTimer *myTimer;
    UIImageView * xiimageview;
	
	UILabel *timeLabel;	
	UILabel *mytimeLabel2;
	UILabel *mytimeLabel3;
	ColorView *colorLabel;
	ColorView *zaixianLabel;
	ColorView *ranLabel;
    UILabel *ranNameLabel;
	UIImageView *imageruan;
	
	UIToolbar *pickerTool;
//	WangqiKaJiangList *wangQi;
	WangQiZhongJiang *zhongJiang;
	NSTimer *runTimer;
	NSInteger runCount;
    BOOL isAppear;
//    UIView *editeView;
//    UITableView *mytableView;//往期开奖
    
    BOOL isKaiJiang;//是否开奖
    NSInteger yanchiTime;//截至和开奖便宜秒数
    
    UIScrollView * mainScrollVIew;//
    UILabel * descriptionLabel;//玩法说明
    
    ASIHTTPRequest *yilouRequest;//遗漏请求
    NSString * myIssrecord;//存的期数
    NSDictionary *yilouDic;
    ASIHTTPRequest * httpRequest;
    UpLoadView * loadview;
    UIScrollView * titleScrollView;
    UIScrollView * elevenScrollView;
    
    UIScrollView * twoTitleScrollView;
    UIScrollView * twoElevenScrollView;
    NSMutableArray * yiLouDataArray;
    
    New_PageControl * myPageControl;
    New_PageControl * twomyPageControl;
    CP_ThreeLevelNavigationView    *tln;
    
    CFRunLoopRef entRunLoopRef;//倒计时用的runloop
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击
    
    BOOL hasYiLou;
    BOOL canRefreshYiLou;
    
    UIImageView * yaoImage;//摇一摇
    
    UIImageView * sanjiaoImageView;
    
    ElevenType myElevenType;
    NSString * myLotteryID;
    
//    int firstLotteryType;//lotterytype的第一个
//    int lastLotteryType;//lotterytype的最后一个
//    int qian2ZhiLotteryType;//前二直选
//    int qian3ZhiLotteryType;//前三直选
//    int firstDanRenLotteryType;//任选胆拖的第一个--任二胆拖
//    int firstDanQianLotteryType;//组选胆拖的第一个--前二组选胆拖
    
    int eleven5_1;
    int eleven5_2;
    int eleven5_3;
    int eleven5_4;
    int eleven5_5;
    int eleven5_6;
    int eleven5_7;
    int eleven5_8;
    int eleven5_Q2Zhi;
    int eleven5_Q3Zhi;
    int eleven5_Q2Zu;
    int eleven5_Q3Zu;
    int eleven5_R2DanTuo;
    int eleven5_R3DanTuo;
    int eleven5_R4DanTuo;
    int eleven5_R5DanTuo;
    int eleven5_Q2DanTuo;
    int eleven5_Q3DanTuo;
}

@property (nonatomic,copy)NSString *issue;
@property (nonatomic,retain)ASIHTTPRequest *myRequest,*qihaoReQuest;
@property (nonatomic,retain)NSTimer *myTimer,*runTimer;
//@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)WangQiZhongJiang *zhongJiang;
@property (nonatomic)LotteryTYPE lotterytype;

@property (nonatomic,retain)ASIHTTPRequest *yilouRequest, * httpRequest;
@property (nonatomic,retain)NSDictionary *yilouDic;
@property (nonatomic, retain)NSMutableArray * yiLouDataArray;
@property (nonatomic,retain)NSString *myIssrecord;
@property (nonatomic) ModeTYPE modetype;

- (void)changeTitle;

- (id)initWithElevenType:(ElevenType)elevenType;


@end

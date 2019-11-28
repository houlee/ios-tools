//
//  FuCai3DViewController.h
//  caibo
//
//  Created by 姚福玉 on 12-7-13.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBallView.h"
#import "GC_LotteryType.h"
#import "ASIHTTPRequest.h"
#import "GC_IssueInfo.h"
#import "GouCaiShuZiInfoViewController.h"
#import "ColorView.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "WangqiKaJiangList.h"
#import "UITitleYiLouView.h"
#import "redrawView.h"
#import "GifButton.h"

@class UpLoadView;
@class New_PageControl;

typedef enum
{
    zixuan,
    zixuanhezhi,
    zusan,
    zuliu
}FuCai3dType;

@interface FuCai3DViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,redrawViewDelegate, UITitleYiLouViewDelegate,UIScrollViewDelegate,GifButtonDelegate,CP_UIAlertViewDelegate> {
    NSMutableArray *wanArray;
    UILabel *titleLabel;
    LotteryTYPE lotterytype;
    ModeTYPE modetype;
    UILabel *infoLable;
    ColorView *jiangjinLable;
    ColorView *sqkaijiang;
    UILabel *zhushuLabel;
    UILabel *jineLabel;
    UIButton *senBtn;
    ColorView *shijiHao;
    UIImageView *yaoImage;
    UIButton *randBtn;
    
    IssueRecord *myissueRecord;
    UIView *bgview;
    BOOL isHemai;
    GouCaiShuZiInfoViewController *infoViewController;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *qihaoReQuest;
    CP_ThreeLevelNavigationView *tln;
    UIImageView *hzbackImage;//和值背景
    ColorView *sqkaijiang211;//上期开奖金额
    UILabel *hqlabel;
    UILabel *twolabel;
    UILabel *hqlabel3;
    UIButton *titleButton;
    
    FuCai3dType fucaiedtype;
    WangqiKaJiangList *wangQi;
    ColorView *endTimelable;
    
    ASIHTTPRequest *yilouRequest;//遗漏值请求
    NSDictionary *yilouDic;//遗漏值
    NSString * myIssrecord;//存的期数
    
    UIScrollView * normalScrollView;
    
    UpLoadView * loadview;
    ASIHTTPRequest * allYiLouRequest;
    NSMutableArray * yiLouDataArray;
    UITitleYiLouView * titleYiLou1;
    UITitleYiLouView * titleYiLou2;
    UITitleYiLouView * titleYiLou3;
    redrawView * redraw3;
    redrawView * redraw2;
    redrawView * redraw1;
    UIImageView * headbgImage;
    
    UIScrollView * titleScrollView;
    UIScrollView * threeDScrollView;
    
    UIScrollView * titleScrollView1;
    UIScrollView * threeDScrollView1;
    
    New_PageControl * myPageControl;
    New_PageControl * myPageControl1;
    
    NSMutableArray * controlArray;
    
    UIView * sqkaijiangView;

    
    float sqkaijiangY;
    float firstViewY;
    
    NSArray * redTitleArray;
    NSArray * redDescArray;
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击

//    ASIHTTPRequest * upgradeRequest;
    UIImageView * sanjiaoImageView;
}

@property (nonatomic)BOOL isHemai;
@property (nonatomic,retain) IssueRecord *myissueRecord;
@property (nonatomic,retain)ASIHTTPRequest *myRequest,*qihaoReQuest,* allYiLouRequest;
@property (nonatomic)ModeTYPE modetype;
@property (nonatomic)FuCai3dType fucaiedtype;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;

@property (nonatomic,retain)ASIHTTPRequest *yilouRequest;
@property (nonatomic,retain)NSDictionary *yilouDic;

@property (nonatomic, retain)NSMutableArray * yiLouDataArray;

- (id)initWithModeType:(ModeTYPE)modeType;


@end

//
//  DaLeTouViewController.h
//  caibo
//
//  Created by 姚福玉 on 12-7-12.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GouCaiShuZiInfoViewController.h"
#import "GC_IssueInfo.h"
#import "GCBallView.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "ColorView.h"
#import "JiangChiJieXi.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "WangqiKaJiangList.h"
#import "UpLoadView.h"
#import "UITitleYiLouView.h"
#import "redrawView.h"
#import "GifButton.h"

typedef enum 
{
    DaleTouTypePuTong,
	DaleTouTypeDantuo
}DaleTouType;

@interface DaLeTouViewController : CPViewController <GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,redrawViewDelegate, UITitleYiLouViewDelegate,GifButtonDelegate,CP_UIAlertViewDelegate> {
    UIScrollView *backScrollView;
    UIScrollView *normalScrollView;
    DaleTouType daleTouType;
    NSArray *wanArray;
    UILabel *titleLabel;
    GouCaiShuZiInfoViewController *infoViewController;
    IssueRecord *myissueRecord;    
    UILabel *zhushuLabel;
    UILabel *jineLabel;
    UIButton *senBtn;
//    UILabel *jiangchiLabel;
    ColorView *jiangchiMoney;
    ColorView *jiangchiMoney1;

    JiangChiJieXi *jiangchi;
    
    
    CP_ThreeLevelNavigationView *tln;

    
    BOOL isHemai;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *myHttpRequest;
    NSInteger redNum;
    NSInteger blueNum;
    ASIHTTPRequest *qihaoReQuest;
    WangqiKaJiangList *wangQi;
    ColorView *endTimelable;
    ColorView *endTimelable1;
    
    ASIHTTPRequest *yiLouRequest;//遗漏
//    UILabel *yuanLabel;
    NSMutableArray * yiLouDataArray;
    
    UpLoadView * loadview;
    UIImageView * headbgImage;
    UITitleYiLouView * titleYiLou1;
    UITitleYiLouView * titleYiLou2;
    UITitleYiLouView * titleYiLou3;
    redrawView * redraw3;
    redrawView * redraw2;
    redrawView * redraw1;
    ASIHTTPRequest * allYiLouRequest;
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击

    UIImageView * sanjiaoImageView;
}

@property (nonatomic,retain)IssueRecord *myissueRecord;
@property (nonatomic,assign)BOOL isHemai;
@property (nonatomic,retain)ASIHTTPRequest *myRequest;
@property (nonatomic)DaleTouType daleTouType;
@property (nonatomic,retain)JiangChiJieXi *jiangchi;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)ASIHTTPRequest *qihaoReQuest;
@property (nonatomic, retain)NSMutableArray * yiLouDataArray;
@property (nonatomic,retain)ASIHTTPRequest *yiLouRequest, *allYiLouRequest;

- (NSString *)seletNumber;
@end

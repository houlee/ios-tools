//
//  GouCaiShuangSeQiuViewController.h
//  caibo
//
//  Created by yao on 12-5-16.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GouCaiShuZiInfoViewController.h"
#import "GCBallView.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GC_IssueInfo.h"
#import "JiangChiJieXi.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "WangqiKaJiangList.h"
#import "UpLoadView.h"
#import "UITitleYiLouView.h"
#import "redrawView.h"
#import "GifButton.h"

typedef enum
{
    ShuangSheQiuTypePuTong,
	ShuangSheQiuTypeDantuo
}ShuangSheQiuType;

@interface GouCaiShuangSeQiuViewController : CPViewController<UITableViewDataSource,
UITableViewDelegate,GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate, redrawViewDelegate, UITitleYiLouViewDelegate,GifButtonDelegate> {
	GouCaiShuZiInfoViewController *infoViewController;
	NSString *selectNumber;	
	UILabel *zhushuLabel;
	UILabel *jineLabel;
	
	UIButton *senBtn;
	NSString *item;
	BOOL isHeMai;
	ASIHTTPRequest *myHttpRequest;
    
//    UILabel *jiangchiLabel;
    ColorView *jiangchiMoney;
    ColorView * jiangchiMoney1;
//    UIButton *xiBtn;
    UIImageView * xiimageview;
    
//    UILabel *jiangchiLabel2;
//    ColorView *jiangchiMoney2;
//    UIButton *xiBtn2;
//    UIImageView * xiimageview2;
    
    NSTimer * xizitimer;
    
    NSArray *wanArray;
    UILabel *titleLabel;
    ShuangSheQiuType shuangsheqiuType;
    UIView *bgview;
    UIScrollView *backScrollView;
    UIScrollView *normalScrollView;
    IssueRecord *myissueRecord;
    JiangChiJieXi *jiangchi;
    
    CP_ThreeLevelNavigationView *tln;
    NSArray *lotteries;
    NSInteger sectionnum;
    NSInteger rownum;
    NSInteger redNum;
    NSInteger blueNum;
    WangqiKaJiangList *wangQi;
    ASIHTTPRequest *qihaoReQuest;
    ColorView *endTimelable;
    ColorView *endTimelable1;
    
    ASIHTTPRequest *yiLouRequest;//遗漏
    ASIHTTPRequest * allYiLouRequest;
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
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击
    
    UIImageView * sanjiaoImageView;

}

@property (nonatomic,copy)NSString *selectNumber;
@property (nonatomic,copy)NSString *item;
@property (nonatomic,assign)BOOL isHeMai;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest,*qihaoReQuest, * allYiLouRequest;
@property (nonatomic)ShuangSheQiuType shuangsheqiuType;
@property (nonatomic,retain)IssueRecord *myissueRecord;
@property (nonatomic,retain)JiangChiJieXi *jiangchi;
@property (nonatomic, assign)NSInteger sectionnum, rownum;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic, retain)NSMutableArray * yiLouDataArray;
@property (nonatomic,retain)ASIHTTPRequest *yiLouRequest;

@end

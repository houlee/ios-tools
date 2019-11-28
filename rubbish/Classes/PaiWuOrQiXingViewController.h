//
//  PaiWuOrQiXingViewController.h
//  caibo
//
//  Created by houchenguang on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_IssueInfo.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GCBallView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "WangqiKaJiangList.h"
#import "SharedMethod.h"
#import "GifButton.h"

typedef enum{
    shuZiCaiPaiWu,
    shuZiCaiQiXing
    
}QiXingOrPaiWu;

@interface PaiWuOrQiXingViewController : CPViewController<GCBallViewDelegate, UIAlertViewDelegate,CP_ThreeLevelNavDelegate,GifButtonDelegate>{
    
    QiXingOrPaiWu qixingorpaiwu;
    ColorView * sqkaijiang;
    IssueRecord *myissueRecord;
    ASIHTTPRequest * myRequest;
    UILabel * infoLable;
    ColorView * jiangjinLable;
    UILabel * zhushuLabel;
    UILabel * jineLabel;
    UIButton * senBtn;
    UIScrollView * backScrollView;
    GouCaiShuZiInfoViewController *infoViewController;
    BOOL  isHemai;
    ColorView *jiangchiLable;
    ASIHTTPRequest *qihaoReQuest;
    WangqiKaJiangList *wangQi;
    ColorView *endTimelable;
    
    int countci;
    CP_ThreeLevelNavigationView *tln;
    
    NSString * myLotteryID;
}
@property (nonatomic, retain)ASIHTTPRequest * myRequest,*jiangChiRequest;
@property (nonatomic, assign)QiXingOrPaiWu qixingorpaiwu;
@property (nonatomic,retain) IssueRecord *myissueRecord;
@property (nonatomic, assign)BOOL isHemai;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)ASIHTTPRequest *qihaoReQuest;
@property (nonatomic, copy) NSString *jiangchi;
@end

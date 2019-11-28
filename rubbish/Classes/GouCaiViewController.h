//
//  GouCaiViewController.h
//  caibo
//
//  Created by yao on 12-5-14.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GouCaiCell.h"
#import "GC_AccountManage.h"
#import "MoreLoadCell.h"
#import "ColorView.h"
#import "GCGuoGuanCell.h"
#import "CP_TabBarViewController.h"
#import "CPViewController.h"
#import "CP_CanOpenTableView.h"
#import "UpLoadView.h"
#import "GC_IssueInfo.h"
#import "LunBoView.h"
#import "MyWebViewController.h"
#import "FocusEventsView.h"

enum 
{
    gaopincai = 0,
    shuzicai = 1,
    zucai = 2,
    all = 3,
    aoyuncai = 4
};

@interface GouCaiViewController : CPViewController <CP_TabBarConDelegate,ASIHTTPRequestDelegate,UITableViewDelegate,
UITableViewDataSource,GouCaiCellDelegate, UIActionSheetDelegate,CP_CanOpenCellDelegate, MyWebViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, FocusEventsViewDelegate> {
	ASIHTTPRequest *mRequest;
	NSMutableDictionary *dataDic;
	CP_CanOpenTableView *myTableView;
    ASIHTTPRequest *httpRequest;
    GC_AccountManage *accountManage;
	NSArray *ZucaiImages;
	NSArray *GaopinImages;
	NSArray *ShuziImages;
    
    NSInteger fistPage;
    NSInteger LuckyType;
    CP_TabBarViewController * tabc;
    NSInteger seconds;
    NSTimer *myTimer;
    int setion[100];
//    UpLoadView *loadview;

    NSMutableString * topicidPict;
    NSMutableArray *caizhongArray;//彩种数组
    ASIHTTPRequest * ggRequest;
    
    //--------------------------------扁平化 by sichuanlin
    NSDateComponents *comps;
    NSInteger weekday;
    int _lastPosition;
    
    
    LunBoView *bannerView; //顶部轮播图
    NSMutableArray *bannerArray;
    UIView *headerView;
    MyWebViewController *myWeb;

    UICollectionView * myCollectionView;
    UIView * mainHeaderView;
    
    ASIHTTPRequest *getMatchRequest;
    NSMutableArray * matchDataArray;
    FocusEventsView * eventsView;
    ASIHTTPRequest *yujirequest;
    UIButton *_goExperBtn;

}
@property (nonatomic, retain)NSMutableString * topicidPict;
@property (nonatomic, retain) GC_AccountManage *accountManage;
@property (nonatomic,retain)ASIHTTPRequest *mRequest,*httpRequest, *ggRequest;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,retain)NSTimer *myTimer;
@property (nonatomic)NSInteger fistPage;
@property (nonatomic,retain)NSMutableArray *caizhongArray;//彩种数组


@property (nonatomic,retain)ASIHTTPRequest *getMatchRequest;

@property (nonatomic,retain)ASIHTTPRequest *yujirequest;

- (void)getAccountInfoRequest;
@end

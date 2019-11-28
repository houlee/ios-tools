//
//  MyLottoryViewController.h
//  caibo
//  我的彩票
//  Created by yao on 12-5-21.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_AccountManage.h"
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "CPViewController.h"
#import "GC_BetRecord.h"
#import "MyHeMaiList.h"
#import "zhuiHaoData.h"
#import "ZhuiHaoInfoViewController.h"
typedef enum {
	MyLottoryTypeOther,
	MyLottoryTypeMe,
	MyLottoryTypeMeHe,//自己合买
	MyLottoryTypeOtherHe,//他人合买
    MyLottoryTypeZhuiHao,//我的追号
    MyLottoryTypeHorse,//赛马
}MyLottoryType;

typedef enum {
	CaiLottoryTypeAll,
	CaiLottoryTypeJiang
}CaiLottoryType;

typedef enum {

    LingQuJiangLi = 1,
    HorseHistory = 2,
}JieKouQuFen;

@interface MyLottoryViewController : CPViewController<ZhuiHaoInfoViewDelegate,UITableViewDelegate,
UITableViewDataSource,ASIHTTPRequestDelegate,CBRefreshTableHeaderDelegate> {
	ASIHTTPRequest *httpRequest;
	GC_AccountManage *accountManage;
	
	MyLottoryType myLottoryType;
	CaiLottoryType caiLottoryType;
    JieKouQuFen jiekou;
	UITableView *myTableView;
	GC_BetRecord *allRecord;
	MyHeMaiList *allHemaiList;
    zhuiHaoData * zhuihaodata;
	BOOL isAllRefresh;
	BOOL isLoading;
	CBRefreshTableHeaderView *mRefreshView;
	MoreLoadCell *moreCell;
	BetRecordInfor *infoBet;
    NSString *userName;
	NSString *nickName;
	UIButton *hemaiBtn;
	UIButton *tadeBtn;
    NSString * userid;
    NSMutableArray * dateArray;
    NSMutableArray * zongArray;
    int buf[10000];
    BOOL microblogBool;//发微博界面过来的
    id delegate;
    
    UpLoadView *loadview;
   
}
@property (nonatomic, retain)NSString * userid;
@property (nonatomic, retain) GC_AccountManage *accountManage;
@property (nonatomic, retain) ASIHTTPRequest *httpRequest;
@property(nonatomic, retain) GC_BetRecord *allRecord;
@property(nonatomic, retain) MyHeMaiList *allHemaiList;
@property (nonatomic, assign) MyLottoryType myLottoryType;
@property (nonatomic, assign) CaiLottoryType caiLottoryType;
@property (nonatomic, assign) JieKouQuFen jiekou;
@property (nonatomic,retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic,retain)BetRecordInfor *infoBet;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic, retain)zhuiHaoData * zhuihaodata;
@property (nonatomic, assign)BOOL microblogBool;
@property (nonatomic, assign)id delegate;


@end


@protocol MyLotteryDelegate

- (void)myLottoryReturn:(MyLottoryViewController *)myLottory url:(NSString *)url infoName:(NSString *)name;

- (void)returnDoBack;


@end

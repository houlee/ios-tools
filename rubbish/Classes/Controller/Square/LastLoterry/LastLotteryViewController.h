//
//  LastLotteryViewController.h
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
@class ASIHTTPRequest;
#import "LastLotteryCell.h"
#import "CPViewController.h"
#import "StatePopupView.h"
#import "CP_TabBarViewController.h"


@interface LastLotteryViewController : CPViewController<CP_TabBarConDelegate,CBRefreshTableHeaderDelegate, UITableViewDataSource, UITableViewDelegate, LastLotteryCellDelegate, UIActionSheetDelegate, UISearchBarDelegate> {
	StatePopupView * statepop;
	// 刷新控件
    CBRefreshTableHeaderView *mRefreshView;
	CP_TabBarViewController * tabc;
	BOOL isLoading;
	BOOL tuisongb;
	NSMutableArray *lotteries;
	ASIHTTPRequest *aRequest;
    UITableView * myTabelView;
    UITableView * redTabelView;
    UIView * downview;
    NSMutableArray * statusData;//请求回来的推送值
    NSMutableArray * alldatabool;//所有的bool值
    NSMutableArray * baocunArray;
    UIButton * kaijiangbtn;
    UIButton * bangdanbtn;
    UIView * bangdanview;
    ASIHTTPRequest * redRequest;
    NSMutableArray * arrdict;//红人榜数据字典钥匙
     NSMutableDictionary * redDictionary;//数据
    NSString * Nickname;
    NSString * userid;
    NSString * username;
    UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
     BOOL isQuxiao;
    NSMutableArray * seachTextListarry;//搜索数组
    NSInteger countshan;
    NSMutableArray * swicthArray;
    NSString * lotteryName;
    NSString * lotteryId;
    NSInteger sectionnum;
    NSInteger rownum;
}
@property (nonatomic, retain)NSString * lotteryName;
@property(nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;
@property(nonatomic, retain)ASIHTTPRequest *aRequest, *redRequest;
@property(nonatomic, retain)NSMutableArray *lotteries;
@property (nonatomic, assign)BOOL tuisongb;
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
-(void)sendContentRequest;
- (void)tuisongRequest;
@end






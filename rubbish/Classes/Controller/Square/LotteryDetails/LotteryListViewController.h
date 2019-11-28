//
//  LotteryListViewController.h
//  caibo
//
//  Created by sulele on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "StatePopupView.h"
#import "UpLoadView.h"

@class LotteryList;
@class ASIHTTPRequest;
@class MoreLoadCell;
@class LotteryDetail;

@interface LotteryListViewController : CPViewController<UITableViewDelegate, UITableViewDataSource> {
	NSString *lotteryId;
	NSString *lotteryName;
	NSString *issue;
	NSString *PageNo;
	NSString *PageSize;
	StatePopupView * statepop;
	// 计算 点击 更多的 次数
	NSInteger listLoadCount;
	
	BOOL fristLoading;
	BOOL listLoadedEnd;
	NSMutableArray *lotteryListArray;
	
	//更多单元格
	MoreLoadCell *listMoreCell;
	
	LotteryList *lotteryList;
	
	LotteryDetail *lotDetail;
    UITableView * myTableView;
   UpLoadView * loadview;
   
    NSInteger index;
		
    ASIHTTPRequest * rankRequest;
    
    LotteryList * selectedList;
}
@property (nonatomic, retain) NSString *lotteryId, *lotteryName, *issue;
@property (nonatomic, retain) NSString *PageNo;
@property (nonatomic, retain) NSString *PageSize;
@property (nonatomic, retain) NSMutableArray *lotteryListArray;
@property (nonatomic, retain) LotteryList *lotteryList;
@property (nonatomic, retain) LotteryDetail *lotDetail;
@property (nonatomic, retain) ASIHTTPRequest * rankRequest;

//发送开奖列表请求
- (void)sendLotteryListRequest;

//开奖列表请求成功 回调
-(void)LoadingTableViewData:(ASIHTTPRequest*)request;

-(NSString*)loadedCount;

//发送开奖详情请求
- (void)sendMatchDetailRequest:(NSString *)lotteryId issue:(NSString *)issue status:(NSString *)status userId:(NSString *)userId;

@end

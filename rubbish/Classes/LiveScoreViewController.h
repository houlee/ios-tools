//
//  LiveScoreViewController.h
//  caibo
//
//  Created by user on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"
#import "ProgressBar.h"
#import "ShiPinData.h"
#import "CPViewController.h"

@class ASIHTTPRequest;
@class ASINetworkQueue;
@class MatchInfo;
@class LiveScoreCell;
@class TermSelectViewController;
@class MoreLoadCell;
@class MatchInfo;


@interface LiveScoreViewController : CPViewController <UITableViewDelegate, UITableViewDataSource, CBRefreshTableHeaderDelegate, PrograssBarBtnDelegate>
{
	UITableView *mTableView;
	ASIHTTPRequest *mRequest;
    BOOL isAllAtt;
	NSString *currentIssue;
    // 刷新控件
    CBRefreshTableHeaderView *mRefreshView;
    BOOL isLoading;
    // 
    TermSelectViewController *termTableController;
    NSInteger selectedSegmentIndex;
    UIView *headerView;
    UILabel *lbLotteryName;
    UIButton *btnIssue;
    NSMutableDictionary *mDataDic;
    MoreLoadCell *moreLoadCell;
    
    BOOL isMoreLoading;
    BOOL isDataNone; 
    NSInteger requestIndex; 
    UIButton *curButton;
    UISegmentedControl *mSegmentedControl;
    BOOL isFirstLoad;
    MatchInfo *tMatch;
    NSString *mPageNum;
    UIImageView *donghuaImageView;
    ASIHTTPRequest *autoRequest;
    NSInteger liveType;//默认为0
    
}

@property (nonatomic, retain) NSString *currentIssue;
@property (nonatomic, retain) IBOutlet UITableView *mTableView;
@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet UILabel *lbLotteryName;
@property (nonatomic, retain) IBOutlet UIButton *btnIssue;
@property (nonatomic, retain) IBOutlet UISegmentedControl *mSegmentedControl;
@property (nonatomic, assign)NSInteger liveType;

- (IBAction)segmentAction:(id) sender;
- (void)reloadTableData;

@end

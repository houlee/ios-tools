//
//  MatchDetailViewController.h
//  caibo
//
//  Created by user on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressBar.h"
#import "ShiPinData.h"
#import "LiveScoreCell.h"
#import "CPViewController.h"

@class MatchDetailCell;
@class MatchDetail;
@class ASIHTTPRequest;
@class GoalNotice;
@class MatchInfo;
typedef enum
{
    MatchTypeNormal,
    MatchTypeOne
}MatchType;
@interface MatchDetailViewController : CPViewController <UITableViewDelegate, UITableViewDataSource,PrograssBarBtnDelegate>
{	
	UITableView *mTableView;
	ASIHTTPRequest *mRequest;
	UIButton *mNoticeButton;
	
    UIImageView *pptvImage;
	NSString *userId;               //用户ID
	NSString *matchId;              //比赛id
	NSString *lotteryId;            //彩种（300,302,303,400,201）
	NSString *issue;                //彩期
	
	NSMutableArray *mMatchDetailArray;
	
	MatchDetail *matchDetail;
	
	NSString *strGoalNotice;
	
	GoalNotice *goalNotice;
	
	NSString *start;
	
	BOOL shouldShowSwitch;
    
    MatchType matchType;
    NSString *section_id;
}
@property (nonatomic, assign) MatchType matchType;
@property (nonatomic, retain) ASIHTTPRequest *mRequest;

@property (nonatomic, retain) UITableView *mTableView;

@property (nonatomic, retain) UIButton *mNoticeButton;

@property (nonatomic, retain) NSString *userId, *matchId, *lotteryId, *issue;

@property (nonatomic, retain) NSMutableArray *mMatchDetailArray;

@property (nonatomic, retain) MatchDetail *matchDetail;

@property (nonatomic, retain) NSString *strGoalNotice;

@property (nonatomic, retain) NSString *start;
@property (nonatomic)BOOL shouldShowSwitch;
@property (nonatomic,retain)NSString *section_id;

- (IBAction)back: (id)sender;

- (IBAction)noticeChanged: (id)sender;

//发送增加进球通知
- (void)sendAddGoalNotice;

//取消进球通知
- (void)sendCancelGoalNotice;

- (void)sendAddAttention;
- (void)sendCancelAttention;
//发送赛事详情请求
- (void)sendMatchDetailRequest;

//根基type设置图像
- (UIImage *)returnImageByType: (NSInteger)type;

//根据比赛事件个数计算UIScrollView视图高度
- (NSInteger)heightByMsgListCount: (NSInteger)count;


@end

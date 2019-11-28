//
//  MessageViewController.h
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBRefreshTableHeaderView.h"

#import "MoreLoadCell.h"

#import "CommentList.h"

#import "caiboAppDelegate.h"
#import "CPViewController.h"
#import "CP_SecondNavigationView.h"
#import "CP_PrizeView.h"
@class ASIHTTPRequest;

typedef enum {
	MSG_TYPE_REMIND,
	MSG_TYPE_NOTICE,
    MSG_TYPE_ATME,
    MSG_TYPE_COMMENT,
    MSG_TYPE_PRIVATE_MESSAGES,
   
} messageSegmentedType;



@interface MessageViewController : CPViewController<CP_SecondDelegate, CBRefreshTableHeaderDelegate,UIActionSheetDelegate,CBautoPushDelegate, UITableViewDelegate, UITableViewDataSource,HomeCellDelegate,CP_PrizeViewDelegate> {
	
    
	ASIHTTPRequest *request;
	
	CBRefreshTableHeaderView *_refreshHeaderView;
	
	BOOL _reloading;
    
	messageSegmentedType segmetetype;
	UISegmentedControl *segmentedControl;
	
	// 存放 提醒 array
	NSMutableArray *remindListArry;
	
	// 存放 通知  arry
	NSMutableArray *noticeListArry;
	
	// 存放 评论箱 arry
	NSMutableArray *commentListArry;
	
	// 存放 @我 arry
	NSMutableArray *atMeListArry;

	//存放 私信 arry
	NSMutableArray *privateMessageArry;
	
	MoreLoadCell *remindMoreCell;
	
	MoreLoadCell *noticeMoreCell;
	
	MoreLoadCell *moreCell;
	
	MoreLoadCell *moreCellOfatme;
	
	MoreLoadCell *moreCellOfPrivatalMail;
	
    UITableView * myTableView;
    
   // UIView *bigImage;
	
	// 判断 通知是否是第一次翻页
	BOOL fristnoticeMore;
	// 判断 通知 翻页结束
	BOOL noticeEnd;
	
	//判断 提醒是否是第一次翻页
	BOOL fristremindMore;
	// 判断 提醒 翻页结束
	BOOL remindEnd;
	
	// 判断 评论箱 是否是 第一次 翻页
	BOOL fristLoadingMore;
	
	// 判断 评论箱  翻页 结束
	BOOL commentLoadend;
	
	// 判断是 atme 否是 第一次 翻页
	BOOL fristLoadingAtme;
	
	// 判断是否翻页结束
	BOOL atmeEnd;
	
	//判断 私信 是否 第一次 翻页
	BOOL fristLoadingPrvivatalMail;
	
	// 判断 私信 是否 翻页 结束
	BOOL privatalMailLoadend;
	

	//点击 评论箱  更多 次数
	NSInteger commentLoadedCount;
	
	//   点击 atMe  更多 次数
	NSInteger atmeLoadCount;
	
	// 点击 私信 更多 次数
	NSInteger privatalMailCount;
	
	// 点击 通知 更多次数
	NSInteger noticeCount;
	
	// 点击 提醒 更多次数
	NSInteger remindCount;
	

	YtTopic *commList;
	
	
	int atme;//atMe 提醒数量
	
	int pl;// 评论想 提醒数量
	
	int  sx;// 私信 提醒数量
	
	int tz;//系统通知
	
	int tx;//提醒数量
    
    BOOL cpthree;
    UIImageView * lineimage;
    ASIHTTPRequest * httprequest;
    UIImageView * dianimage1;
    UIImageView * dianimage2;
    UIImageView * dianimage3;
    UIImageView * dianimage4;
    UIImageView * dianimage5;
    UIImageView *imageMassage;
    CP_SecondNavigationView * second;
    
    ASIHTTPRequest *autoRequest;
    
    ASIHTTPRequest * orignalRequest;
    
    ASIHTTPRequest * likeRequest;
    
    YtTopic * likeYtTopic;
    UIButton * likeButton;
}


 
- (void)reloadTableViewDataSource;

// 发送 通知 请求
-(void)sendNoticeRequest;

//发送 评论箱 请求
-(void)sendCommentListRequest:(NSString*)pageNum pageSize:(NSString*)pigeSize;

// 发送 私信列表 请求
-(void)sendPrivatalMailListRequest;

// 发送 atme 列表请求
-(void)sendatMeListRequest;

- (void)sendRemindRequest;
@property (nonatomic)BOOL cpthree;


@property (nonatomic)BOOL _reloading;;
@property(nonatomic,retain)UISegmentedControl *segmentedControl;

@property(nonatomic,retain)NSMutableArray *noticeListArry,*remindListArry;

@property(nonatomic,retain)NSMutableArray *commentListArry,*atMeListArry;

@property (nonatomic,retain)NSMutableArray *privateMessageArry;


@property(nonatomic,retain)YtTopic *commList;


@property (nonatomic,retain)ASIHTTPRequest *request, * httprequest ,*autoRequest, * orignalRequest;

@property (nonatomic,retain)ASIHTTPRequest * likeRequest;

@property(nonatomic,retain)UIView *bigImage;
-(NSString *)loadedCount;

//-(void)autoRefresh;

-(void)autoRefresh:(NSString*)responseString;

-(void)resetTitile:(int)value text:(NSString*)text index:(int)index;
-(void)resetTitile;

-(void)setDefaultTitile;

-(void)automeassageRefresh;
- (void)segmentedcontrolEventValueChanged;
//- (void)commentListLoadingTableViewData;

@end

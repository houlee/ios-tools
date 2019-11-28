//
//  HomeViewController.h
//  caibo
//
//  Created by jacob on 11-5-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



#define ktopicNum @"20"// 首页请求 关注列表条数

#import "CBRefreshTableHeaderView.h"
#import "DetailedViewController.h"

#import "MoreLoadCell.h"
#import "UserGroupList.h"
#import "caiboAppDelegate.h"
#import "MyProfileViewController.h"
#import "CPViewController.h"
#import "LunBoView.h"
#import "HomeCell.h"
#import "CP_PrizeView.h"
@class NewsPromptBar;

@class ASINetworkQueue;
@class ASIHTTPRequest;


@protocol HomeViewConDelegate <NSObject>

- (void)returnguanzhu:(NSInteger)gz pinglun:(NSInteger)pl atme:(NSInteger)am sixin:(NSInteger)sx;

@end

@interface HomeViewController : CPViewController<CBRefreshTableHeaderDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CBautoPushDelegate, MyProfileDelegate, UISearchBarDelegate, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, DetailedDelegate, HomeCellDelegate,CP_PrizeViewDelegate>
{
	//快捷按钮
	UIButton *liveScoreBtn;
	UIButton *lastLotteryBtn;
	UIButton *forcastBtn;
	
	NSString *newstype;// 类型
	NSString *selectName;
	ASIHTTPRequest *curRequest;
	NSInteger selectBtn;
	NSMutableDictionary *dataDic;
	
	//ASIHTTPRequest *request;
	
    UITableView* tableView;
    //UITableView *mTableView;
	
	UIButton *advPicView;//广告位图片
	UIButton *chaButton;
	NSString *aNewVersion;//新的广告位版本，被点击后更改
	BOOL isDeleted;
	
	ASINetworkQueue *mNetworkQueue;
	
	CBRefreshTableHeaderView *refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
	
	UIPickerView *chooseUserPicker;
	
	UIView *userPickerView;
	UIImageView *navView;
	
	
	MoreLoadCell *topicMoreCell;
	
	//选取器 数据
	NSMutableArray *arryData;
	
	// 关注人 发帖 数据
	NSMutableArray *topicDataArry;
	
	UIButton *imageButton;
	
	// 判断 选择器 是否 打开 
	BOOL ispickerOPen;
	
	
	UIImage *userHeadImage;
	
	
	// 计算 点击 更多的 次数
	NSInteger topicLoadCount;
	NSInteger topDaJiaDouZaiShuo;
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;
	
	// 是否 分组 数据
	BOOL isGroup;
	UIView * titlev;
	
	UILabel *titleName;
    
    NewsPromptBar *mNewsPromptBar;
    ASIHTTPRequest *mRequest;
	UIButton * headButton1;
    UIButton * headButton2;
    NSString * username;
    UIImageView * newimage;
    BOOL newbool;
    UIButton * newimageButton;
    NSInteger str11;
    NSInteger str22;
    NSInteger str33;
    NSInteger str44;
    
    NSInteger guanzhustr;
    NSInteger pinglustr;
    NSInteger atmestr;
    NSInteger sxstr;
    NSInteger gzrftstr;
    ASIHTTPRequest * chekrequest;
    BOOL dajiabool;//用来分辨 是大家都在说的页面 还是我关注的 bool
    id<HomeViewConDelegate>delegate;
    UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
    NSMutableArray * seachTextListarry;//搜索数组
    UIButton * seabut;
    BOOL xianshi;
    NSString * xianshistr;
    BOOL isQuxiao;
    BOOL qingqiubool;
    NSMutableString * topicidPict;
    YtTopic * hongdongyt;//活动的信息
    
    BOOL onebool;//防止返回按钮多次点击导致nav=null无法返回
    
    
    LunBoView *bannerView;
    NSMutableArray *bannerArray;
    UIView *headerView;

    ASIHTTPRequest * orignalRequest;
    
    ASIHTTPRequest * likeRequest;
    
    YtTopic * likeYtTopic;
    UIButton * likeButton;
}
@property (nonatomic, retain)YtTopic * hongdongyt;
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
@property (nonatomic, assign)id<HomeViewConDelegate>delegate;
@property (nonatomic, assign)BOOL dajiabool, xianshi,qingqiubool ;
@property (nonatomic, assign)NSInteger guanzhustr, pinglustr,  atmestr,  sxstr, gzrftstr;
@property (nonatomic, retain)ASIHTTPRequest * chekrequest;
@property (nonatomic, retain)UIImageView* newimage;
@property (nonatomic, retain)NSString * username;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,retain)UIImageView *navView;
@property (nonatomic,retain)ASIHTTPRequest *curRequest;
@property (nonatomic,copy)NSString *newstype;
@property (nonatomic,copy)NSString *selectName;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView;

@property (nonatomic ,retain)IBOutlet 	UIPickerView *chooseUserPicker;
@property (nonatomic ,retain)IBOutlet   UIView *userPickerView;

@property (nonatomic,retain)NSMutableArray *arryData;

@property (nonatomic,retain)NSMutableArray *topicDataArry;

@property (nonatomic,retain)UILabel *titleName;

@property (nonatomic,retain) ASIHTTPRequest *mRequest;

@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) NSString *aNewVersion;
@property (nonatomic, copy) NSMutableString *topicidPict;
@property (nonatomic,retain)UIButton *advPicView;//广告位图片
@property (nonatomic,retain)UIButton *chaButton;

@property (nonatomic,retain)ASIHTTPRequest * orignalRequest;

@property (nonatomic,retain)ASIHTTPRequest * likeRequest;

//初始化函数
- (id)initWithBool:(BOOL)bol;

//响应 写微博 按钮 
-(void)pressWriteButton:(id)sender;

// 响应 刷新 按钮
-(void)pressRefreshButton:(id)sender;

// 点击 用户名，弹出 选取 用户 分组 控件
-(void)pressUserName:(id)sender;


- (void)reloadTableViewDataSource;
// 没有 收到 刷新数据
-(void)UndoneLoadedTableViewData;

// 发送 关注列表 请求（刷新时）
-(void)SendHttpRequest;

// 发送 分组帖子列表
-(void)sendTopicListByGroupIdRequest:(UserGroupList*)ulist;

// 响应 选取器 确定按钮
-(IBAction) onClickOKPickerlButton:(id)sender;

-(void)dissDatePick;// 隐藏 选取器
-(void)showDatePick;// 显示 选取器


-(void)addAdPicView;// 添加 广告位图片


// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;
- (NSString *)loadedCountDaJiaDouZaiShuo;

// 自动接收 推送消息
//-(void)autoRefresh;

-(void)autoRefresh:(NSString*)responseString;

// 设置 
-(void)setbadgeValue;
//未读消息请求
- (void)requestChekNew;
- (void)xinweibotixing;
- (void)returnguanzhu:(NSInteger)gz pinglun:(NSInteger)pl atme:(NSInteger)am sixin:(NSInteger)sx;

+ (HomeViewController *) getShareHomeViewController;

@end

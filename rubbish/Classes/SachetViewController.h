//
//  SachetViewController.h
//  caibo
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "AnnouncementData.h"
#import "AnnouncementCell.h"
#import "CP_TabBarViewController.h"
#import "HaoShengYinCell.h"
#import "CPViewController.h"

typedef enum{
    
    haoshengyintype,
    huatitype,
    hongrenbangtype,
    wolaiyucetype,
    
    
} SachetType;

@interface SachetViewController : CPViewController<haoShengYinDelegate,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIActionSheetDelegate, CP_TabBarConDelegate>{
    UIView * topicView;//话题的view
    UILabel * doubleLabel;//双色球
    UILabel * threeDLabel;//3d
    UILabel * arrangeLabel;//排列3
    UILabel * blessingLabel;//福彩新闻
    UILabel * europeLabel;//欧洲杯
    UILabel * sportsLabel;//体彩新闻
    NSArray * sizeArray;//字号
    NSArray * colorArray;//颜色
    NSArray * buttonArray;
    UIButton * redbutton;//红人榜
    UIButton * topic;//话题
    UITableView * myTableView;
    ASIHTTPRequest  * request;//话题网络请求
    ASIHTTPRequest * redRequest;//红人榜网络请求
    ASIHTTPRequest * yuceRequest;
    UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
    NSArray * arrayLabel;
    NSMutableArray * dataArray;//话题数组
    UIImageView * imageview12;
    AnnouncementData * annuoun;
    
    NSMutableArray * seachTextListarry;//搜索数组
    NSMutableArray * arrdict;//红人榜数据字典钥匙
    NSMutableDictionary * redDictionary;//数据
    NSString * Nickname;
	NSString * username;
    NSString * userid;
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
    UILabel * label4;
    UILabel * label5;
    UILabel * label6;
    BOOL huatibool;
    BOOL isQuxiao;
    UIButton * huatibtn;
    UIButton * hongrenbtn;
    UIButton * yucebtn;
    UIView * yuceView;
    UITableView * yuCeTableView;
    NSMutableArray * yudataArray;
    CP_TabBarViewController * tabc;
    UIButton * haoshengyinbut;
    UITableView * haoTableView;
    UIView * haoview;
    NSMutableArray * haoShengYinArr;
    SachetType sachettype;
    int buf[4];
}
@property (nonatomic, assign)SachetType sachettype;
@property (nonatomic, retain)NSString * userid;
@property (nonatomic, retain)NSString * Nickname;
@property (nonatomic, retain)NSString * username;
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
@property (nonatomic, retain)ASIHTTPRequest * redRequest;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic, retain) ASIHTTPRequest * yuceRequest;
- (void)TopicViewAddview;//话题view的函数
-(void)sendSeachRequest:(NSString*)keywords;
@end

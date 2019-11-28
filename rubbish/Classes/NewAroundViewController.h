//
//  NewAroundViewController.h
//  caibo
//
//  Created by yao on 12-5-2.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadImageView.h"
#import "ASIHTTPRequest.h"
#import "CBRefreshTableHeaderView.h"
#import "CPViewController.h"

@interface NewAroundViewController : CPViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CBRefreshTableHeaderDelegate,
ASIHTTPRequestDelegate>{
	UITableView *tableView1;
	UITableView *tableView2;
	UITableView *tableView3;
	UITableView *tableView4;
    CBRefreshTableHeaderView *refreshHeaderView2;
    CBRefreshTableHeaderView *refreshHeaderView3;
	NSMutableArray *lists;
	UIScrollView *rootScroll;
	UILabel *homeLabel;//主队名称；
	UILabel *visitLabel;// 客队；
	DownLoadImageView *homeImageView;
	DownLoadImageView *visitImageView;
	DownLoadImageView *gameImageView;
	NSMutableDictionary *dataDic;
	UILabel *timeLabel;//比赛时间；
	UILabel *nameLabe;//联赛名称；
	NSInteger HostTeamId;
	NSInteger GuestTeamId;
	ASIHTTPRequest *mrequest;
	NSString *playID;
    BOOL isLoading;
    UILabel *zhongliLable;
    int buffer[6];
}

@property (nonatomic,retain)ASIHTTPRequest *mrequest;
@property (nonatomic,retain)UITableView *tableView1;
@property (nonatomic,retain)UITableView *tableView2;
@property (nonatomic,retain)UITableView *tableView3;
@property (nonatomic,retain)UITableView *tableView4;
@property (nonatomic,retain)UIScrollView *rootScroll;
@property (nonatomic,retain)UILabel *homeLabel;//主队名称；
@property (nonatomic,retain)UILabel *visitLabel;// 客队；
//@property (nonatomic,retain)DownLoadImageView *homeImageView;
//@property (nonatomic,retain)DownLoadImageView *visitImageView;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView2;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView3;
@property (nonatomic,retain)UILabel *timeLabel;//主队名称；
@property (nonatomic,retain)UILabel *nameLabe;//主队名称；
@property (nonatomic,copy)NSString *playID;
@end

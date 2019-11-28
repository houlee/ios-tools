//
//  LanQiuAroundViewController.h
//  caibo
//
//  Created by yaofuyu on 13-12-12.
//
//

#import <UIKit/UIKit.h>
#import "DownLoadImageView.h"
#import "ASIHTTPRequest.h"
#import "CBRefreshTableHeaderView.h"
#import "CPViewController.h"

@interface LanQiuAroundViewController : CPViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CBRefreshTableHeaderDelegate,
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
//@property (nonatomic,retain)DownLoadImageView *homeImageView;
//@property (nonatomic,retain)DownLoadImageView *visitImageView;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView2;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView3;
@property (nonatomic,copy)NSString *playID;
@end

//
//  LanQiuBianhuaAroundViewController.h
//  caibo
//
//  Created by yaofuyu on 13-12-15.
//
//

#import "CPViewController.h"
#import "DownLoadImageView.h"
#import "ASIHTTPRequest.h"

@interface LanQiuBianhuaAroundViewController : CPViewController {
    UILabel *homeLabel;//主队名称；
	UILabel *visitLabel;// 客队；
	DownLoadImageView *homeImageView;
	DownLoadImageView *visitImageView;
	DownLoadImageView *gameImageView;
	NSMutableDictionary *dataDic;
	UILabel *timeLabel;//比赛时间；
	UILabel *nameLabe;//联赛名称；
    BOOL isOuPei;
    NSString *cid;//公司编号
    NSArray *dataArray;
    UITableView *tableView1;
}
@property (nonatomic) BOOL isOuPei;
@property (nonatomic,retain)NSString *cid;
@property (nonatomic,retain)NSArray *dataArray;
@property (nonatomic,retain)NSMutableDictionary *dataDic;

@end

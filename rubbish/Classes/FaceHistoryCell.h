//
//  FaceHistoryCell.h
//  caibo//历史交锋
//
//  Created by yao on 12-5-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"

typedef enum {
	FaceHistoryCellTypeFace,//历史交锋
	FaceHistoryCellTypeNear,//近期战绩
    FaceHistoryCellTypeFuture//未来战绩
	
}FaceHistoryCellType;
@interface FaceHistoryCell : UITableViewCell {
	UILabel *nameLabel;//队伍名称用于最近战绩,篮球中用于赛事
	UILabel *timeLabel;//时间；
	UILabel *HnameLabel;//主队名称
	UILabel *GnameLabel;//客队名称；
	UILabel *scLabel;//比分；篮球未来vs
    UILabel *rangLabel;//让分 篮球未来间隔
    BOOL isLanqiu;//篮球还是足球
    BOOL isZongjie;//总结战绩
    ColorView *zongjieLabel;
    NSString *hostName;
}
@property (nonatomic)BOOL isLanqiu,isZongjie;
@property (nonatomic,copy)NSString *hostName;

- (void)LoadData:(NSDictionary *)dic withName:(NSString *)name withType:(FaceHistoryCellType)type;

@end

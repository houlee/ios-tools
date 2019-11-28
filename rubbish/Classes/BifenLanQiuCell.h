//
//  BifenLanQiuCell.h
//  caibo
//
//  Created by yaofuyu on 13-10-24.
//
//

#import <UIKit/UIKit.h>
#import "BiFenZhiBoLanQiuData.h"

@interface BifenLanQiuCell : UITableViewCell {
    UIImageView *cellbgImage;
    UIImageView *bifenBack;//比分背景图
    UILabel *matchNoLabel;//比赛号
    UILabel *liansainameLabel;//联赛名
    UILabel *matchStartTimeLabel;//比赛开始时间
    UILabel *statusLabel;//比赛状态
    UILabel *guestNameLabel;//客队名
    UILabel *hostNameLabel;//主队名
    UILabel *ScoreLabel;//比分
    UILabel *bcbfLabel;//半场比分
}

- (void)LoadData:(BiFenZhiBoLanQiuData *)data;

@end

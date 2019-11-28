//
//  NearRankCell.h
//  caibo 积分排名
//
//  Created by yao on 12-5-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearRankCell : UITableViewCell {
	UILabel *nameLabel;//队伍名称；
	UILabel *saiLabel;//赛label
	UILabel *shengLabel;//足、篮胜
	UILabel *pingLabel;//足平、篮球失分
	UILabel *fuLabel;//足负
	UILabel *shengPerLabel;// 胜率
	UILabel *rankLabel;//排名
	UILabel *scoreLabel;//得分
    UILabel *jingLabel;//篮球净胜分
    BOOL isLanQiu;//篮球的近期战绩
}

@property (nonatomic)BOOL isLanQiu;

- (void)LoadData:(NSDictionary *)dic WithName:(NSString *)name isTitle:(BOOL)istitle;

@end

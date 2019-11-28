//
//  MatchTableViewCell.h
//  Experts
//
//  Created by hudong yule on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchVCModel.h"

@interface MatchTableViewCell : UITableViewCell

@property(nonatomic,weak)UILabel * number;//001编号
@property(nonatomic,weak)UIImageView * noImageView;
@property(nonatomic,weak)UILabel * name;//赛名
@property(nonatomic,weak)UILabel * time;//时间
@property(nonatomic,weak)UILabel * dueOfTwoSides;//谁VS谁
@property(nonatomic,weak)UILabel * recommandCount;//推荐数
@property(nonatomic,weak)UIImageView * recommandCountImageView;

+(id)matchTableViewCellWithTableView:(UITableView *)tableView;

-(void)setDataWithMatchMdl:(MatchVCModel *)matchModel;

@end

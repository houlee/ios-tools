//
//  ExpertDetailCell.h
//  Experts
//
//  Created by v1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFLineLabel.h"

@interface ExpertDetailCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headImgView;//头像
@property(nonatomic,strong)UIImageView * markImgView;//VIP
@property(nonatomic,strong)UILabel * nickNamelab;//昵称
@property(nonatomic,strong)UIImageView *rankImgView;//会员等级
@property(nonatomic,strong)UILabel *rankLab;//会员等级
@property(nonatomic,strong)UILabel * statLab;//5中5
@property(nonatomic,strong)UIImageView *zhongView;//5中5背景
@property(nonatomic,strong)UILabel * twoSideLab;//对决双方
@property(nonatomic,strong)UIImageView *ypImgView;//亚盘标志
@property(nonatomic,strong)UIImageView *refundImgView;//不中退款标志
@property(nonatomic,strong)UILabel * timeLab;//时间
@property(nonatomic,strong)UILabel * leagueTypeLab;//联赛类型
@property(nonatomic,strong)UILabel * priceLab;//价格
@property(nonatomic,weak)QFLineLabel * disCountLab;//折扣价格

@property(nonatomic,strong)UILabel * name2;//
@property(nonatomic,strong)UILabel * time2;//
@property(nonatomic,strong)UILabel * league2;//
@property(nonatomic,strong)UIView * line;//

+(id)ExpertDetailCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)expertHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo lotype:(NSString *)lotype;
- (void)expertHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo lotype:(NSString *)lotype name2:(NSString *)name2 time2:(NSString *)time2 league2:(NSString *)league2;//二串一

@end

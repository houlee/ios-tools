//
//  SechExpIntroCell.h
//  Experts
//
//  Created by v1pin on 15/11/12.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SechExpIntroCell : UITableViewCell

@property(nonatomic,strong)UIImageView * schHeadView;//头像
@property(nonatomic,strong)UIImageView * markView;//头像上的V
@property(nonatomic,strong)UILabel * nicNmlab;//昵称
@property(nonatomic,strong)UILabel * exTypeLab;//对决双方
@property(nonatomic,strong)UILabel * exIntroLab;//时间
@property(nonatomic,strong) UIImageView *djImgV;
@property(nonatomic,strong) UILabel *djLab;

+(id)SechExpCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)expertHead:(NSString *)head name:(NSString *)name exRank:(NSInteger)exRank starNo:(NSInteger)starNo exType:(NSString *)exType exIntro:(NSString *)exIntro;

@end

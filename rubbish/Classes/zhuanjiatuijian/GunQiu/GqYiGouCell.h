//
//  GqYiGouCell.h
//  caibo
//
//  Created by zhoujunwang on 16/5/28.
//
//

#import <UIKit/UIKit.h>

@interface GqYiGouCell : UITableViewCell

@property(nonatomic,weak)UIImageView *headImgView;//头像
@property(nonatomic,weak)UILabel *nikNamelab;//昵称
@property(nonatomic,weak)UIImageView *rkImgView;//会员等级
@property(nonatomic,weak)UILabel *rankLab;//会员等级
@property(nonatomic,weak)UILabel *legTypeLab;//联赛类型
@property(nonatomic,weak)UIImageView *legTypeImgV;//联赛类型
@property(nonatomic,weak)UILabel *gameBothLab;//对决双方
@property(nonatomic,weak)UILabel *priceLab;//价格
@property(nonatomic,weak)UILabel *timeLab;//时间
@property(nonatomic,weak)UILabel *nowStateLab;//状态标志
@property(nonatomic,weak)UIView *sepView;//分割线

-(void)setPortView:(NSString *)portImgView nickName:(NSString *)nickName levels:(NSInteger)level legName:(NSString *)legName bothSide:(NSString *)bothSide price:(NSInteger)price time:(NSString *)time npTag:(NSString *)npTag;

@end

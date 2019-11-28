//
//  ExpertSuperiorBaseCell.h
//  Experts
//
//  Created by hudong yule on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFLineLabel.h"
#import "SuperiorMdl.h"

@interface ExpertSuperiorBaseCell : UITableViewCell

@property(nonatomic,weak)UIImageView *headImgView;//头像
@property(nonatomic,weak)UIImageView *markImgView;//VIP
@property(nonatomic,weak)UILabel *nickNamelab;//昵称
@property(nonatomic,weak)UIImageView *rankImgView;//会员等级
@property(nonatomic,strong)UILabel *rankLab;//会员等级
@property(nonatomic,weak)UIImageView *zhongView;//5中5背景
@property(nonatomic,weak)UILabel *statLab;//5中5
@property(nonatomic,weak)UILabel *twoSideLab;//对决双方
@property(nonatomic,weak)UIImageView *ypImgView;//亚盘标志
@property(nonatomic,weak)UIImageView *refundImgView;//不中退款标志
@property(nonatomic,weak)UILabel *timeLab;//时间
@property(nonatomic,weak)UILabel *leagueTypeLab;//联赛类型
@property(nonatomic,weak)UILabel *priceLab;//价格
@property(nonatomic,weak)QFLineLabel *disCountLab;//折扣价格
//@property(nonatomic,strong)UIImageView *staImgV;//推荐中未中的图标

@property(nonatomic,weak)UILabel *resultLab;//方案状态

@property(nonatomic,strong)UILabel * name2;//
@property(nonatomic,strong)UILabel * time2;//
@property(nonatomic,strong)UILabel * league2;//
@property(nonatomic,strong)UIView * line;//


+(id)ExpertSuperiorBaseCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)setCellSuperHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo flag:(BOOL)flag lotryTp:(NSString *)lotryTp;

-(void)HeadImageView:(NSString * )HeadImageView vImageView:(NSString *)vImageView nickName:(NSString *)nickName levels:(NSString *)levels statics:(NSString *)statics dueOfTwoSides:(NSString *)dueOfTwoSides time:(NSString *)time price:(NSString *)price flag:(NSString *)flag refundOrNo:(NSInteger)refundOrNo lotryTp:(NSString *)lotryTp;

-(void)setCellSuperHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo flag:(BOOL)flag lotryTp:(NSString *)lotryTp name2:(NSString *)name2 time2:(NSString *)time2 league2:(NSString *)league2;//二串一

@end

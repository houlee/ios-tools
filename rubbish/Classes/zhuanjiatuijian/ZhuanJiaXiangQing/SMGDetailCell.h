//
//  SMGDetailCell.h
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMGDetailCell;

@protocol SMGDetailCellPlanDetailDelegate <NSObject>

-(void)SMGDetailCellPlanDetail:(UIButton *)btn SMGDetailCell:(SMGDetailCell *)cell;

@end


@interface SMGDetailCell : UITableViewCell
//场次
@property(nonatomic,weak)UILabel *timeLabel;
//联赛名称
@property(nonatomic,weak)UIImageView *matchTypeImageView;
@property(nonatomic,weak)UILabel *matchType;
//不中退款
@property(nonatomic,weak)UIImageView * refundImageView;
@property(nonatomic,weak)UILabel * refundLabel;
//对决双方
@property(nonatomic,weak)UILabel *sidesOne;
@property(nonatomic,weak)UILabel *VS;
@property(nonatomic,weak)UILabel *sidesTwo;
//时间
@property(nonatomic,weak)UILabel *time;
//方案标题
@property(nonatomic,weak)UILabel *recNameLab;
//查看方案详情按钮
@property(nonatomic,weak)UIButton * planDetailBtn;


@property(nonatomic,weak)id<SMGDetailCellPlanDetailDelegate> delegateSMG;

-(void)setCellMatchTime:(NSString *)matchTime homeTeam:(NSString *)homeTeam visiTeam:(NSString *)visiTeam starTime:(NSString *)starTime price:(NSString *)price matchType:(NSString *)matchType exsource:(NSInteger)source titName:(NSString *)titName isSd:(BOOL)isSd;

+(id)SMGDetailCellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

@end

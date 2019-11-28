//
//  DigitalDetailCell.h
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DigitalDetailCellDelegate <NSObject>

-(void)digitalDetailCellPlanDetail:(UIButton *)btn;

@end

@interface DigitalDetailCell : UITableViewCell

@property(nonatomic,weak)UILabel * digitalType;//种类，双色球
@property(nonatomic,weak)UILabel * qiOfNumber;//2015期
@property(nonatomic,weak)UIButton * planDetailBtn;//查看方案详情按钮

@property(nonatomic,strong)UIImageView * refundImageView;//不中退款
@property(nonatomic,strong)UILabel * refundLabel;

+(instancetype)digitalDetailCellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;
-(void)setCellLotteryType:(NSString *)lotryTepy erIsu:(NSString *)erIsu pricePlan:(NSString *)pricePlan source:(NSInteger)source;

@property(nonatomic,weak)id<DigitalDetailCellDelegate> delegate;

@end

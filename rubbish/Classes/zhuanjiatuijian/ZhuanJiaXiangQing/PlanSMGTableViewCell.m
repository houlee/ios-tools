//
//  PlanSMGTableViewCell.m
//  234567
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 晗晗哥. All rights reserved.
//

#import "PlanSMGTableViewCell.h"

@implementation PlanSMGTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //星期
        _dataWeek = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 15)];
        _dataWeek.textColor = BLACK_EIGHTYSEVER;
        _dataWeek.backgroundColor = [UIColor clearColor];
        _dataWeek.font = FONTTWENTY_FOUR;
        [self.contentView addSubview:_dataWeek];
        
        UIImage * imsg = [UIImage imageNamed:@"已发方案-英超-描边标签"];
        _contestType = [UIButton buttonWithType:UIButtonTypeCustom];
        _contestType.titleLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        [_contestType setBackgroundImage:imsg forState:normal];
        [_contestType setTitleColor:[UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1] forState:normal];
        _contestType.titleLabel.font = [UIFont systemFontOfSize:14];
        _contestType.frame = CGRectMake(15, ORIGIN_Y(_dataWeek)+15, imsg.size.width, imsg.size.height);
        _contestType.titleLabel.font=FONTTWENTY_FOUR;
        [self.contentView addSubview:_contestType];
        
        //时间
        _contestTime = [[UILabel alloc]initWithFrame:CGRectMake(_dataWeek.frame.origin.x, ORIGIN_Y(_contestType)+15, 300, 15)];
        _contestTime.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        _contestTime.textColor = BLACK_FIFITYFOUR;
        _contestTime.font = FONTTWENTY_FOUR;
        [self.contentView addSubview:_contestTime];
        
        //队名
        _contestName = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_contestType)+15, _contestType.frame.origin.y-2, 300, 20)];
        _contestName.textColor = BLACK_EIGHTYSEVER;
        _contestName.font = FONTTHIRTY;
        [self.contentView addSubview:_contestName];
        
        //销售状态
        _contestStatus = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 70, _dataWeek.frame.origin.y, 60, 20)];
        _contestStatus.textAlignment = NSTextAlignmentRight;
        _contestStatus.font = FONTTHIRTY;
        _contestStatus.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_contestStatus];
        
        //销售价格
        _contestPrice = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 100, _contestTime.frame.origin.y, 90, 15)];
        _contestPrice.textAlignment = NSTextAlignmentRight;
        _contestPrice.textColor = [UIColor redColor];
        _contestPrice.font = FONTTWENTY_FOUR;
        _contestPrice.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_contestPrice];
        
        _statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(MyWidth - 60, 0, 60, 100)];
        _statusImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_statusImg];
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}
//已发方案（历史战绩）
-(void)dataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName statusImg:(NSString *)statusImg
{
    _dataWeek.text = dataWeek;
    
    NSString *leagueSty=[contestType substringToIndex:2];
    [_contestType setTitle:leagueSty forState:normal];
    
//    CGSize contestSize=[PublicMethod setNameFontSize:contestType andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    CGRect rect=_contestType.frame;
//    rect.size.width=contestSize.width+20;
//    [_contestType setFrame:rect];
//    _contestType.titleLabel.textAlignment=NSTextAlignmentCenter;
//    [_contestType setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 10)];

    _contestTime.text = contestTime;
    _contestName.text = contestName;
    _contestStatus.hidden = YES;
    _statusImg.hidden = NO;
    if([statusImg isEqualToString:@"1"]){
        _statusImg.image = [UIImage imageNamed:@"荐中"];
    } else if([statusImg isEqualToString:@"2"]){
        _statusImg.image = [UIImage imageNamed:@"未中"];
    } else if([statusImg isEqualToString:@"4"]){
        _statusImg.image = [UIImage imageNamed:@"走盘"];
    }
}

//已发方案（最新推荐）
-(void)dataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName contestStatus:(NSString *)contestStatus contestPrice:(NSString *)contestPrice
{
    _dataWeek.text = dataWeek;
    [_contestType setTitle:contestType forState:normal];
    
    _contestTime.text = contestTime;
    _contestName.text = contestName;
    _contestStatus.text = contestStatus;
    if ([contestStatus isEqualToString:@"21"]) {
        _contestStatus.text = @"在售中";
    } if ([contestStatus isEqualToString:@"22"]){
        _contestStatus.text = @"已停售";
    } if ([[contestStatus substringToIndex:1] isEqualToString:@"1"]){
        _contestStatus.text = @"审核中";
    } if ([[contestStatus substringToIndex:1] isEqualToString:@"3"]){
        _contestStatus.text = @"未通过";
    }
    if([contestPrice floatValue]!=0.00){
        _contestPrice.text=[NSString stringWithFormat:@"%@元",contestPrice];
    }else
        _contestPrice.text=@"免费";
    
    _statusImg.hidden = YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
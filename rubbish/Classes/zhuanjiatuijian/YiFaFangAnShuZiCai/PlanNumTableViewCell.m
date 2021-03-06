//
//  PlanNumTableViewCell.m
//  Experts
//
//  Created by V1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PlanNumTableViewCell.h"

@implementation PlanNumTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _typeOf = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 50, 15)];
        _typeOf.textColor = BLACK_EIGHTYSEVER;
        _typeOf.font = FONTTHIRTY;
        [self.contentView addSubview:_typeOf];
        
        _numData = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_typeOf)+15, _typeOf.frame.origin.y, 120, 15)];
        _numData.font = FONTTWENTY_FOUR;
        _numData.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_numData];
        
        _timeOfRelease = [[UILabel alloc]initWithFrame:CGRectMake(_typeOf.frame.origin.x, ORIGIN_Y(_typeOf)+15, 250, 13)];
        _timeOfRelease.font = FONTTWENTY_FOUR;
        _timeOfRelease.textColor = BLACK_FIFITYFOUR;
        [self.contentView addSubview:_timeOfRelease];
        
        _seleStatus = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 80, _typeOf.frame.origin.y, 65, 15)];
        _seleStatus.font = FONTTHIRTY;
        _seleStatus.textColor = BLACK_EIGHTYSEVER;
        _seleStatus.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_seleStatus];
        
        _numPrice = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 100, _timeOfRelease.frame.origin.y, 85, 15)];
        _numPrice.textAlignment = NSTextAlignmentRight;
        _numPrice.font = FONTTWENTY_FOUR;
        _numPrice.textColor = RGB(255, 59, 48);
        [self.contentView addSubview:_numPrice];
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 85, _typeOf.frame.origin.y,70, 15)];
        _price.textAlignment = NSTextAlignmentRight;
        _price.font = FONTTWENTY_FOUR;
        _price.textColor = RGB(255, 59, 48);
        [self.contentView addSubview:_price];
        
        _newStatus = [[UIImageView alloc]initWithFrame:CGRectMake(MyWidth - 38, 0, 38, 70)];
        
        [self.contentView addSubview:_newStatus];
        
    }
    return self;
    
}




#pragma mark - 历史战绩 的结构

-(void)TypeOf:(NSString *)TypeOf NumData:(NSString *)NumData TimeOfRelease:(NSString *)TimeOfRelease Price:(NSString *)Price NewStatus:(NSString *)NewStatus
{
    _typeOf.text = TypeOf;
    
    if ([TypeOf isEqualToString:@"-201"]) {
        _typeOf.text = @"单关";
    }if ([TypeOf isEqualToString:@"201"]) {
        _typeOf.text = @"过关";
    }if ([TypeOf isEqualToString:@"002"]) {
        _typeOf.text = @"3D";
    }if ([TypeOf isEqualToString:@"108"]) {
        _typeOf.text = @"排列三";
    }if ([TypeOf isEqualToString:@"001"]) {
        _typeOf.text = @"双色球";
    }if ([TypeOf isEqualToString:@"113"]) {
        _typeOf.text = @"大乐透";
    }
    
    _numData.text = NumData;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:NumData];
    [str addAttribute:NSForegroundColorAttributeName value:ALERT_BLUE range:NSMakeRange(0,[str length]-1)];
    [str addAttribute:NSForegroundColorAttributeName value:BLACK_FIFITYFOUR range:NSMakeRange([str length]-1,1)];
    _numData.attributedText = str;
    
    _timeOfRelease.text = TimeOfRelease;
    _price.text = Price;
    
    if ([NewStatus isEqualToString:@"1"]) {
        _newStatus.image = [UIImage imageNamed:@"荐中"];
    }else{
        _newStatus.image = [UIImage imageNamed:@"未中"];
    }
}

#pragma mark - 最新推荐 的结构

-(void)TypeOf:(NSString *)TypeOf NumData:(NSString *)NumData TimeOfRelease:(NSString *)TimeOfRelease SeleStatus:(NSString *)SeleStatus NumPrice:(NSString *)NumPrice
{
    _typeOf.text = TypeOf;
    if ([TypeOf isEqualToString:@"-201"]) {
        _typeOf.text = @"单关";
    }if ([TypeOf isEqualToString:@"201"]) {
        _typeOf.text = @"过关";
    }if ([TypeOf isEqualToString:@"002"]) {
        _typeOf.text = @"3D";
    }if ([TypeOf isEqualToString:@"108"]) {
        _typeOf.text = @"排列三";
    }if ([TypeOf isEqualToString:@"001"]) {
        _typeOf.text = @"双色球";
    }if ([TypeOf isEqualToString:@"113"]) {
        _typeOf.text = @"大乐透";
    }
    
    
    _numData.text = NumData;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:NumData];
    [str addAttribute:NSForegroundColorAttributeName value:ALERT_BLUE range:NSMakeRange(0,[str length]-1)];
    [str addAttribute:NSForegroundColorAttributeName value:BLACK_FIFITYFOUR range:NSMakeRange([str length]-1,1)];
    
    _numData.attributedText = str;
    _timeOfRelease.text = TimeOfRelease;
    _seleStatus.text = SeleStatus;
    
    
    if ([SeleStatus isEqualToString:@"21"]) {
        _seleStatus.text = @"在售中";
    } if ([SeleStatus isEqualToString:@"22"]){
        _seleStatus.text = @"已停售";
    } if ([[SeleStatus substringToIndex:1] isEqualToString:@"1"]){
        _seleStatus.text = @"审核中";
    } if ([[SeleStatus substringToIndex:1] isEqualToString:@"3"]){
        _seleStatus.text = @"未通过";
    }
    
    _numPrice.text = NumPrice;
    _newStatus.hidden = YES;
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
//
//  MySaleTableCell.m
//  Experts
//
//  Created by V1pin on 15/11/3.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MySaleTableCell.h"
#import "SharedMethod.h"

@implementation MySaleTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _group = [[UILabel alloc]initWithFrame:CGRectMake(15,0,MyWidth-150,20)];
        _group.font = FONTTWENTY_SIX;
        _group.textColor = BLACK_EIGHTYSEVER;
        _group.textAlignment = NSTextAlignmentLeft;
        _group.backgroundColor = [UIColor clearColor];
        [self addSubview:_group];
        
        _group2 = [[UILabel alloc]initWithFrame:CGRectMake(15,0,MyWidth-150,20)];
        _group2.font = FONTTWENTY_SIX;
        _group2.hidden = YES;
        _group2.textColor = BLACK_EIGHTYSEVER;
        _group2.textAlignment = NSTextAlignmentLeft;
        _group2.backgroundColor = [UIColor clearColor];
        [self addSubview:_group2];
        
        UIImageView *ypImgVw=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_group.frame)+5,CGRectGetMinY(_group.frame)+2.5,15,15)];
        ypImgVw.image=[UIImage imageNamed:@"yapan"];
        ypImgVw.hidden=YES;
        [self addSubview:ypImgVw];
        _ypImgView=ypImgVw;
        
        UIImageView *sdImgVw=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_ypImgView.frame)+5,CGRectGetMinY(ypImgVw.frame)+2.5,15,15)];
        sdImgVw.hidden=YES;
        [self addSubview:sdImgVw];
        _sdImgView=sdImgVw;
        
        _prices = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth-130,_group.frame.origin.y,55,20)];
        _prices.font = FONTTWENTY_SIX;
        _prices.textColor = BLACK_EIGHTYSEVER;
        _prices.textAlignment=NSTextAlignmentCenter;
        _prices.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_prices];
        
        _sales = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth-75, _group.frame.origin.y,55,20)];
        _sales.font = FONTTWENTY_SIX;
        _sales.textColor = BLACK_EIGHTYSEVER;
        _sales.textAlignment = NSTextAlignmentCenter;
        _sales.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_sales];
        
        erchuanyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        erchuanyiBtn.frame = CGRectMake(0, 0, 36, 12);
        erchuanyiBtn.hidden = YES;
        erchuanyiBtn.backgroundColor = [UIColor clearColor];
        [erchuanyiBtn setTitle:@"二串一" forState:UIControlStateNormal];
        erchuanyiBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [erchuanyiBtn setTitleColor:[SharedMethod getColorByHexString:@"ed3f30"] forState:UIControlStateNormal];//
        erchuanyiBtn.enabled = NO;
        erchuanyiBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"ed3f30"] CGColor];
        erchuanyiBtn.layer.borderWidth = 0.5f;
        erchuanyiBtn.layer.cornerRadius = 3;
        erchuanyiBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:erchuanyiBtn];
        jingcaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jingcaiBtn.frame = CGRectMake(0, 0, 27, 12);
        jingcaiBtn.hidden = YES;
        jingcaiBtn.backgroundColor = [UIColor clearColor];
        [jingcaiBtn setTitle:@"竞足" forState:UIControlStateNormal];
        jingcaiBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [jingcaiBtn setTitleColor:[SharedMethod getColorByHexString:@"ed3f30"] forState:UIControlStateNormal];
        jingcaiBtn.enabled = NO;
        jingcaiBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"ed3f30"] CGColor];
        jingcaiBtn.layer.borderWidth = 0.5f;
        jingcaiBtn.layer.cornerRadius = 3;
        jingcaiBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:jingcaiBtn];
        
        lineIma = [[UIImageView alloc]init];
        lineIma.frame = CGRectMake(15, 32.5, self.frame.size.width-30, 0.5);
        lineIma.backgroundColor = [UIColor blackColor];
        lineIma.alpha = 0.1;
        lineIma.hidden = YES;
        [self.contentView addSubview:lineIma];
    }
    return self;
}

-(void)group:(NSString *)group price:(NSString *)price sales:(NSString *)sales lotryTpye:(NSString *)lotryTpye sdType:(NSString *)sdType
{
    _group2.hidden = YES;
    erchuanyiBtn.hidden = YES;
    jingcaiBtn.hidden = YES;
    lineIma.hidden = YES;
    
    lineIma.frame = CGRectMake(15, 27.5, self.frame.size.width-30, 0.5);
    _group.frame = CGRectMake(15,4,MyWidth-150,20);
    _prices.frame = CGRectMake(MyWidth-130,_group.frame.origin.y,55,20);
    _sales.frame = CGRectMake(MyWidth-75, _group.frame.origin.y,55,20);
    
    _group.text=group;
    CGSize reSize=[PublicMethod setNameFontSize:group andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_group.frame;
    rect.size.width=reSize.width;
    [_group setBackgroundColor:[UIColor clearColor]];
    [_group setFrame:rect];
    
    [_ypImgView setFrame:CGRectMake(CGRectGetMaxX(_group.frame)+5,CGRectGetMinY(_group.frame)+2.5,15,15)];
    if ([lotryTpye isEqualToString:@"202"]) {
        _ypImgView.hidden=NO;
    }else
        _ypImgView.hidden=YES;
    
    [_sdImgView setFrame:CGRectMake(CGRectGetMaxX(_ypImgView.frame)+5,CGRectGetMinY(_ypImgView.frame),15,15)];
    if ([sdType isEqualToString:@"4"]) {
        _sdImgView.image=[UIImage imageNamed:@"sd_xl_V2"];
    }else if ([sdType isEqualToString:@"3"]) {
        _sdImgView.image=[UIImage imageNamed:@"sd_xl_V1"];
    }else if ([sdType isEqualToString:@"1"]) {
        _sdImgView.image=[UIImage imageNamed:@"sd_xl_dx"];
    }else if ([sdType isEqualToString:@"2"]) {
        _sdImgView.image=[UIImage imageNamed:@"sd_xl_bc"];
    }
    if ([sdType isEqualToString:@"0"]) {
        _sdImgView.hidden=YES;
    }else{
        _sdImgView.hidden=NO;
    }
    
    _prices.text=price;
    _sales.text=sales;
}
-(void)loadAppointInfo:(NSDictionary *)dict{//竞足
    _ypImgView.hidden = YES;
    _sdImgView.hidden = YES;
    lineIma.hidden = NO;
    lineIma.frame = CGRectMake(15, 32.5, self.frame.size.width-30, 0.5);
    erchuanyiBtn.hidden = YES;
    jingcaiBtn.hidden = NO;
    _group2.hidden = YES;
    
    NSString * oddsString = @"";

    if ([dict[@"LOTTERY_CLASS_CODE"] isEqualToString:@"204"]) {
        [jingcaiBtn setTitle:@"篮彩" forState:UIControlStateNormal];
        
        oddsString = [NSString stringWithFormat:@"(%@)",dict[@"HOSTRQ"]];
    }else{
        [jingcaiBtn setTitle:@"竞足" forState:UIControlStateNormal];
        
        oddsString = @"";
    }
    
    NSString * groupString = [NSString stringWithFormat:@"%@ VS %@%@",dict[@"HOME_NAME"],dict[@"AWAY_NAME"],oddsString];
    if([dict[@"LOTTERY_CLASS_CODE"] isEqualToString:@"204"]){
        groupString = [NSString stringWithFormat:@"%@ VS %@%@",dict[@"AWAY_NAME"],dict[@"HOME_NAME"],oddsString];
    }
    NSMutableAttributedString * groupAString = [[NSMutableAttributedString alloc] initWithString:groupString];
    [groupAString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:FONTTWENTY_SIX} range:NSMakeRange(0, groupString.length)];
    
    [groupAString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.54],NSFontAttributeName:[UIFont systemFontOfSize:11]} range:[groupString rangeOfString:oddsString]];
    
    _group.attributedText = groupAString;

    CGSize reSize=[PublicMethod setNameFontSize:_group.text andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _group.frame = CGRectMake(15, 0, reSize.width+10, 33);
    _group.backgroundColor = [UIColor clearColor];
    jingcaiBtn.frame = CGRectMake(reSize.width+20, 10.5, 27, 12);
    
    _prices.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"AMOUNT"]];
    _sales.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ALL_AMOUNT"]];
    _prices.frame = CGRectMake(MyWidth-130,0,55,33);
    _sales.frame = CGRectMake(MyWidth-75, 0,55,33);
}
-(void)loadErchuanyiAppointInfo:(NSDictionary *)dict{//二串一
    _ypImgView.hidden = YES;
    _sdImgView.hidden = YES;
    lineIma.hidden = NO;
    lineIma.frame = CGRectMake(15, 54.5, self.frame.size.width-30, 0.5);
    erchuanyiBtn.hidden = NO;
    jingcaiBtn.hidden = YES;
    
    _group.text = [NSString stringWithFormat:@"%@ VS %@",dict[@"HOME_NAME"],dict[@"AWAY_NAME"]];;
    CGSize reSize=[PublicMethod setNameFontSize:_group.text andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _group.frame = CGRectMake(15, 7, reSize.width+10, 20);
    _group.backgroundColor = [UIColor clearColor];
    
    _group2.hidden = NO;
    _group2.text = [NSString stringWithFormat:@"%@ VS %@",dict[@"HOME_NAME2"],dict[@"AWAY_NAME2"]];;
    CGSize reSize2=[PublicMethod setNameFontSize:_group2.text andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _group2.frame = CGRectMake(15, 27, reSize2.width+10, 20);
    _group2.backgroundColor = [UIColor clearColor];
    
    if(reSize.width > reSize2.width){
        erchuanyiBtn.frame = CGRectMake(reSize.width+20, 21.5, 36, 12);
    }else{
        erchuanyiBtn.frame = CGRectMake(reSize2.width+20, 21.5, 36, 12);
    }
    
    _prices.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"AMOUNT"]];
    _sales.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ALL_AMOUNT"]];
    
    _prices.frame = CGRectMake(MyWidth-130,0,55,55);
    _sales.frame = CGRectMake(MyWidth-75, 0,55,55);
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
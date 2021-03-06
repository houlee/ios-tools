//
//  SZCCell.m
//  Experts
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SZCCell.h"

@implementation SZCCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    self.bigView=[[UIView alloc] initWithFrame:CGRectMake(15,0,290,40)];
    self.bigView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bigView];
    
    self.leftLine=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
    self.leftLine.backgroundColor = SEPARATORCOLOR;
    [self.bigView addSubview:self.leftLine];
    
    self.rightLine=[[UIView alloc] initWithFrame:CGRectMake(self.bigView.frame.size.width-1, 0, 1, 40)];
    self.rightLine.backgroundColor = SEPARATORCOLOR;
    [self.bigView addSubview:self.rightLine];
    
    self.topLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 1)];
    self.topLine.backgroundColor = SEPARATORCOLOR;
    [self.bigView addSubview:self.topLine];
    
    self.lowLine=[[UIView alloc] initWithFrame:CGRectMake(0, 39, 290, 1)];
    self.lowLine.backgroundColor = SEPARATORCOLOR;
    
    self.midLine=[[UIView alloc] initWithFrame:CGRectMake(56, 0, 1, 40)];
    self.midLine.backgroundColor = SEPARATORCOLOR;
    [self.bigView addSubview: self.midLine];
    
    self.ballNameLab=[[UILabel alloc] initWithFrame:CGRectMake(1, 0, 56, 40)];
    self.ballNameLab.userInteractionEnabled=YES;
    self.ballNameLab.textAlignment = NSTextAlignmentCenter;
    self.ballNameLab.textColor = BLACK_EIGHTYSEVER;
    self.ballNameLab.font = [UIFont systemFontOfSize:10.0];
    self.ballNameLab.backgroundColor=[UIColor clearColor];
    self.ballNameLab.numberOfLines = 0;
    [self.bigView addSubview: self.ballNameLab];
    
    self.countNameLab=[[UITextView alloc] initWithFrame:CGRectMake(59, 0, 218, 40)];
    self.countNameLab.textColor = BLACK_TWENTYSIX;
    self.countNameLab.font = [UIFont systemFontOfSize:10.0];
    self.countNameLab.userInteractionEnabled=YES;
    self.countNameLab.backgroundColor = [UIColor clearColor];
    [self.bigView addSubview:self.countNameLab];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
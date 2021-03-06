//
//  StatisticeData.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "StatisticeCell.h"

@implementation StatisticeCell
@synthesize useLabel;
@synthesize moneyLabel;
@synthesize numberLabel;
@synthesize rightLabel;
@synthesize fieldNumLabel;
@synthesize allNumLabel;
@synthesize cellView;
@synthesize imageView;
@synthesize statisticeData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self tabelCellView]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)tabelCellView{
    CGRect rect = CGRectMake(0, 0, 320, 70);
    //cell的view
    cellView = [[UIView alloc] initWithFrame:rect];
    //图片
    imageView = [[UIImageView alloc] initWithFrame:rect];
   // imageView.backgroundColor  = [UIColor groupTableViewBackgroundColor];
    
    //用户名
    useLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 60, 30)];
    useLabel.textAlignment = NSTextAlignmentCenter;
    useLabel.backgroundColor = [UIColor clearColor];
  
    
    
    //奖金
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 60, 15)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.backgroundColor = [UIColor clearColor];
    
    
    //注数
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 55, 15)];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.backgroundColor = [UIColor clearColor];
    
    //全对注数
    rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 10, 70, 15)];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.backgroundColor = [UIColor clearColor];
    
    //场次
    fieldNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 10, 75, 15)];
    fieldNumLabel.textAlignment = NSTextAlignmentCenter;
    fieldNumLabel.backgroundColor = [UIColor clearColor];
    
    //全部的数字
    allNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 260, 30)];
    allNumLabel.textAlignment = NSTextAlignmentCenter;
    allNumLabel.backgroundColor = [UIColor clearColor];
    
    [cellView addSubview:imageView];
    [cellView addSubview:moneyLabel];
    [cellView  addSubview:useLabel];
    [cellView addSubview:numberLabel];
    [cellView addSubview:rightLabel];
    [cellView addSubview:fieldNumLabel];
    [cellView addSubview:allNumLabel];
    
    return cellView;
}
//get
- (StatisticsData *)statisticeData{
    return statisticeData;
}
//set
-(void)setStatisticeData:(StatisticsData *)_statisticeData{
    if (statisticeData != _statisticeData) {
        [statisticeData release];
        statisticeData = [_statisticeData retain];
    }
    useLabel.text = _statisticeData.use;
    moneyLabel.text = _statisticeData.money;
    numberLabel.text = _statisticeData.number;
    rightLabel.text = _statisticeData.right;
    fieldNumLabel.text = _statisticeData.fieldNum;
    allNumLabel.text = _statisticeData.allNum;
    imageView.image = _statisticeData.image;
    
}


- (void)dealloc{
    [statisticeData release];
    [useLabel release];
    [moneyLabel release];
    [numberLabel release];
    [rightLabel release];
    [fieldNumLabel  release];
    [allNumLabel release];
    [cellView release];
    [imageView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
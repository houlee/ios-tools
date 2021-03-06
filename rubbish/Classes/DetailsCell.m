//
//  DetailsCell.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "DetailsCell.h"

@implementation DetailsCell
@synthesize eventLabel;
@synthesize againstLabel;
@synthesize resultLabel;
@synthesize betLabel1;
@synthesize betLabel2;
@synthesize betLabel3;
@synthesize view;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self tableCellView]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
//定制cell
- (UIView *)tableCellView{
    //返回的view
    CGRect rect = CGRectMake(0, 0, 320, 28);
    view = [[UIView alloc] initWithFrame:rect];
    
    //赛事
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 61, 26)];
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont systemFontOfSize:13];
    eventLabel.backgroundColor = [UIColor colorWithRed:224/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    
    //赛事后竖线
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(71, 0, 1, 26)];
    line1.image = [UIImageGetImageFromName(@"PKShuLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    //对阵后竖线
    UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(188, 0, 1, 26)];
    line2.image = [UIImageGetImageFromName(@"PKShuLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    //彩果后竖线
    UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(231, 0, 1, 26)];
    line3.image = [UIImageGetImageFromName(@"PKShuLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    //投注1后竖线
    UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(257, 0, 1, 26)];
    line4.image = [UIImageGetImageFromName(@"PKShuLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    //投注2后竖线
    UIImageView * line5 = [[UIImageView alloc] initWithFrame:CGRectMake(283, 0, 1, 26)];
    line5.image = [UIImageGetImageFromName(@"PKShuLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    UIImageView * line6 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 300, 1)];
    line6.image = [UIImageGetImageFromName(@"PKXiangHengLine.png") stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    
    
    //对阵
    againstLabel = [[UILabel alloc] initWithFrame:CGRectMake(71, 0, 130, 26)];
    againstLabel.textAlignment = NSTextAlignmentCenter;
    againstLabel.font = [UIFont systemFontOfSize:13];
    againstLabel.backgroundColor = [UIColor whiteColor];
    
    //彩果
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(188, 0, 43, 26)];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.font = [UIFont systemFontOfSize:13];
    resultLabel.backgroundColor = [UIColor colorWithRed:249/255.0 green:234/255.0 blue:152/255.0 alpha:1];
    
    //投注1
    betLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(231, 0, 26, 26)];
    betLabel1.textAlignment = NSTextAlignmentCenter;
    betLabel1.font = [UIFont systemFontOfSize:13];
    betLabel1.backgroundColor = [UIColor whiteColor];
    
    //投注2
    betLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(257, 0, 26, 26)];
    betLabel2.textAlignment = NSTextAlignmentCenter;
    betLabel2.font = [UIFont systemFontOfSize:13];
    betLabel2.backgroundColor = [UIColor whiteColor];
    
    //投注3
    betLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(283, 0, 26, 26)];
    betLabel3.textAlignment = NSTextAlignmentCenter;
    betLabel3.font = [UIFont systemFontOfSize:13];
    betLabel3.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:eventLabel];
    [view addSubview:againstLabel];
    [view addSubview:resultLabel];
    [view addSubview:betLabel1];
    [view addSubview:betLabel2];
    [view addSubview:betLabel3];
    [view addSubview:line1];
    [view addSubview:line2];
    [view addSubview:line3];
    [view addSubview:line4];
    [view addSubview:line5];
    [view addSubview:line6];
    
    [line1 release];
    [line2 release];
    [line3 release];
    [line4 release];
    [line5 release];
    [line6 release];
    return view;

}

//数据接口get
- (DetailsData *)detailsData{
    return detailsData;
}

//数据接口set
- (void)setDetailsData:(DetailsData *)_detailsData{
    if (detailsData != _detailsData) {
        [detailsData  release];
        detailsData = [_detailsData retain];
    }
    eventLabel.text = _detailsData.event;
    againstLabel.text = _detailsData.against;
    resultLabel.text = _detailsData.result;
    betLabel1.text = _detailsData.bet1;
    betLabel2.text = _detailsData.bet2;
    betLabel3.text = _detailsData.bet3;
    
    if ([betLabel1.text isEqualToString:resultLabel.text]) {
        betLabel1.backgroundColor = [UIColor colorWithRed:253/255.0 green:18/255.0 blue:18/255.0 alpha:1];
    }
    if ([betLabel2.text isEqualToString:resultLabel.text]) {
        betLabel2.backgroundColor = [UIColor colorWithRed:253/255.0 green:18/255.0 blue:18/255.0 alpha:1];
    }
    if ([betLabel3.text isEqualToString:resultLabel.text]) {
        betLabel3.backgroundColor = [UIColor colorWithRed:253/255.0 green:18/255.0 blue:18/255.0 alpha:1];
    }

    
}

- (void)dealloc{
    [eventLabel release];
    [againstLabel release];
    [resultLabel release];
    [betLabel1 release];
    [betLabel2 release];
    [betLabel3 release];
    [view release];
    [detailsData release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
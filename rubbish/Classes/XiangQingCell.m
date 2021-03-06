//
//  XiangQingCell.m
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "XiangQingCell.h"

@implementation XiangQingCell
@synthesize cellview;
@synthesize cellbgimage;
@synthesize dengLabel;
@synthesize zhushuLabel;
@synthesize jiangjinLabel;
@synthesize lineimage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returnTableViewCellView]];
    }
    return self;
}

- (UIView *)returnTableViewCellView{
//    cellview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 294, 25)] autorelease];
    cellview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 294, 35)] autorelease];
    cellview.backgroundColor = [UIColor clearColor];
    
    UILabel *shuxianLab=[[UILabel alloc]init];
    shuxianLab.frame=CGRectMake(0, 0, 0.5, cellview.frame.size.width-0.5);
    shuxianLab.backgroundColor=[UIColor colorWithRed:220/255.0 green:217/255.0 blue:210/255.0 alpha:1];
    [cellview addSubview:shuxianLab];
    [shuxianLab release];
    UILabel *shuxianLab2=[[UILabel alloc]init];
    shuxianLab2.frame=CGRectMake(cellview.frame.size.width-0.5, 0, 0.5, cellview.frame.size.height);
    shuxianLab2.backgroundColor=[UIColor colorWithRed:220/255.0 green:217/255.0 blue:210/255.0 alpha:1];
    [cellview addSubview:shuxianLab2];
    [shuxianLab2 release];
    
    cellbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 25)];
    cellbgimage.backgroundColor = [UIColor clearColor];
//    cellbgimage.image = UIImageGetImageFromName(@"gc_xc_05");
//    cellbgimage.backgroundColor=[UIColor whiteColor];

//    dengLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 25)];
    dengLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 35)];
    dengLabel.backgroundColor = [UIColor clearColor];
    dengLabel.textAlignment = NSTextAlignmentCenter;
    dengLabel.font = [UIFont systemFontOfSize:12];
//    dengLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    dengLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    
//    zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 92, 25)];
    zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 92, 35)];
    zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.backgroundColor = [UIColor clearColor];
    zhushuLabel.font = [UIFont systemFontOfSize:12];
//    zhushuLabel.textColor = [UIColor colorWithRed:163/255.0 green:116/255.0 blue:13/255.0 alpha:1];
    zhushuLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    
//    jiangjinLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 0, 127, 25)];
    jiangjinLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 0, 127, 35)];
    jiangjinLabel.textAlignment = NSTextAlignmentCenter;
    jiangjinLabel.backgroundColor = [UIColor clearColor];
    jiangjinLabel.font = [UIFont systemFontOfSize:12];
//    jiangjinLabel.textColor = [UIColor colorWithRed:163/255.0 green:116/255.0 blue:13/255.0 alpha:1];
    jiangjinLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    
//    lineimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 23, 292, 2)];
    lineimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 34.5, 292, 0.5)];
    lineimage.backgroundColor = [UIColor clearColor];
    
    UIImageView * line1image = [[UIImageView alloc] initWithFrame:CGRectMake(80, 11, 1, 13)];
    UIImageView * line2image = [[UIImageView alloc] initWithFrame:CGRectMake(170, 11, 1, 13)];
    line1image.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    line2image.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.contentView addSubview:line1image];
    [self.contentView addSubview:line2image];
    [line1image release];
    [line2image release];
    
    [cellview addSubview:cellbgimage];
    [cellview addSubview:dengLabel];
    [cellview addSubview:zhushuLabel];
    [cellview addSubview:jiangjinLabel];
    [cellview addSubview:lineimage];
    return cellview;
}

- (void)dealloc{
    [lineimage release];
    [cellview release];
    [cellbgimage release];
    [jiangjinLabel release];
    [dengLabel release];
    [zhushuLabel release];
	[super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  ShiPinCell.m
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "ShiPinCell.h"

@implementation ShiPinCell
@synthesize timeLabel;
@synthesize infoLabel;
@synthesize zhiboImagle;
@synthesize shipindata;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returnTableViewCellView]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithRed:108/255.0 green:154/255.0 blue:186/255.0 alpha:1.0];
    }
    return self;
}


- (ShiPinData *)shipindata{
    return shipindata;
}

- (void)setShipindata:(ShiPinData *)_shipindata{
    if (shipindata != _shipindata) {
        [shipindata release];
        shipindata = [_shipindata retain];
    }
    
    timeLabel.text = _shipindata.time;
    NSString * str = _shipindata.islive;
    NSLog(@"str ==== %@", str);
    if ([str intValue] == 1) {
        zhiboImagle.hidden = NO;
    }else{
        zhiboImagle.hidden = YES;
    }
    
   
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.text = shipindata.content;
}

- (UIView *)returnTableViewCellView{
    
    //返回的view;
    UIImageView* viewret = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 300, 44)] autorelease];
    viewret.image = UIImageGetImageFromName(@"ZhiBoNeiRongBG.png");
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 61, 20)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:9];
    timeLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
    
    //直播的图标
    zhiboImagle = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 45, 44)];
    zhiboImagle.backgroundColor = [UIColor clearColor];
    zhiboImagle.image = UIImageGetImageFromName(@"ZBA960.png");
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 14)];
    [zhiboImagle addSubview:label1];
    label1.text  = @"直播";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:9];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor clearColor];
    [label1 release];
        
    //直播详情
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 0, 0)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
    infoLabel.numberOfLines = 0;
    infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    infoLabel.frame = CGRectMake(77, 7, 210, 30);
    
    
    [viewret addSubview:timeLabel];
    [viewret addSubview:zhiboImagle];
    [viewret addSubview:infoLabel];
    
    
    return viewret;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc{
    
    [shipindata release];
    [timeLabel release];
    [infoLabel release];
    [zhiboImagle release];
    
    [super dealloc];

}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
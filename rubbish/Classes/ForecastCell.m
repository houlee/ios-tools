//
//  ForecastCell.m
//  caibo
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "ForecastCell.h"

@implementation ForecastCell
@synthesize numLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returnviewcell]];
         [self setSelectionStyle:UITableViewCellSelectionStyleNone];
      //  [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)returnviewcell{
    viewcell = [[UIView alloc] initWithFrame:CGRectMake(12, 3, 296, 52)];
    viewcell.backgroundColor = [UIColor clearColor];
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 296, 52)];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.userInteractionEnabled = YES;
    bgview.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];//UIImageGetImageFromName(@"GoucaiCellbtn7.png");
    [viewcell addSubview:bgview];
    [bgview release];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 100, 20)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    numLabel.textColor = [UIColor colorWithRed:3/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    nameLabel.font =[UIFont boldSystemFontOfSize:15];
    
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(296-8-13-15-20-120, (52-20)/2, 120, 20)];
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = [UIFont systemFontOfSize:11];
    numLabel.textColor = [UIColor colorWithRed:0/255.0 green:120/255.0 blue:232/255.0 alpha:1];
    
    UILabel * qilabel = [[UILabel alloc] initWithFrame:CGRectMake(296-8-13-15-20, (52-20)/2, 20, 20)];
    qilabel.text = @"期";
    qilabel.textAlignment = NSTextAlignmentLeft;
    qilabel.backgroundColor = [UIColor clearColor];
    qilabel.font = [UIFont systemFontOfSize:13];
    qilabel.textColor =[UIColor colorWithRed:0/255.0 green:120/255.0 blue:232/255.0 alpha:1];
    
   
    UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(296-8-13, (52-3-13)/2, 8, 13)];
    
    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"JTD960.png");
    [bgview addSubview:jiantou];
    [jiantou release];

//    UIImageView * jiantouimage = [[UIImageView alloc] initWithFrame:CGRectMake(300, 13, 8, 14)];
//    jiantouimage.backgroundColor = [UIColor  clearColor];
//    jiantouimage.image = UIImageGetImageFromName(@"gcgarr_0.png");
//    [viewcell addSubview:jiantouimage];
//    [jiantouimage release];
    
    
    [bgview addSubview:nameLabel];
    [bgview addSubview:numLabel];
    [bgview addSubview:qilabel];
//    [bgview addSubview:line];
  
    [qilabel release];
    
    return viewcell;
}

- (ForecastData *)data{
    return data;
}

- (void)setData:(ForecastData *)_data{
    if (data != _data) {
        [data release];
        data = [_data retain];
    }
    nameLabel.text = _data.name;
    numLabel.text = _data.num;
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
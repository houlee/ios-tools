//
//  NewsCell.m
//  caibo
//
//  Created by  on 12-7-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returnTabelviewCell]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)returnTabelviewCell{
    UIView * viewcell = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 8, 8)];
    imageview.image = UIImageGetImageFromName(@"pushmessage_cion.png");
    imageview.backgroundColor = [UIColor clearColor];
    [viewcell addSubview:imageview];
    [imageview release];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 292, 20)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    
    laiziLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 20, 100, 20)];
    laiziLabel.backgroundColor = [UIColor clearColor];
    laiziLabel.font = [UIFont systemFontOfSize:12];
    laiziLabel.textAlignment = NSTextAlignmentLeft;
    
    timeLable = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 20)];
    timeLable.backgroundColor = [UIColor clearColor];
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.textAlignment = NSTextAlignmentLeft;
    
    [viewcell addSubview:titleLable];
    [viewcell addSubview:laiziLabel];
    
    return  viewcell;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
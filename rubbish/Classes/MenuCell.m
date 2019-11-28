
//
//  MenuCell.m
//  iphone_control
//
//  Created by houchenguang on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize headImage;
@synthesize titleLabel;
@synthesize bgimage;
@synthesize line;

- (void)dealloc{
    
    [bgimage release];
    [headImage release];
    [line release];
    [titleLabel release];
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        bgimage.backgroundColor = [UIColor clearColor];
        
       
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 11, 22, 22)];
        headImage.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:headImage];
        
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 12, 200, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        [bgimage addSubview:titleLabel];
        
        UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(275, 15, 8, 13)];
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.image = [UIImage imageNamed:@"JTD960.png"];
        [bgimage addSubview:jiantou];
        [jiantou release];
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 320, 0.5)];
        line.backgroundColor = [UIColor clearColor];
        //line.image = [UIImage imageNamed:@""];
        [bgimage addSubview:line];
        
        
        
        [self.contentView addSubview:bgimage];
        //[bgimage release];
        
    }
    return self;
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
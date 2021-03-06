//
//  LotteryTypeCell.m
//  caibo
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "LotteryTypeCell.h"

@implementation LotteryTypeCell
@synthesize typeName,customSelectButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initTypeLabel];
        [self initSelectButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initTypeLabel
{
    UILabel *tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 15, 40, 15)];
    [tmpLabel setBackgroundColor:[UIColor clearColor]];
    [tmpLabel setFont:[UIFont systemFontOfSize:14]];
    [tmpLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpLabel setTextColor:[UIColor blackColor]];
    self.typeName = tmpLabel;
    [self.contentView addSubview:self.typeName];
    [tmpLabel release];
    
}
- (void)initSelectButton
{
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpButton setFrame:CGRectMake(275, 15, 15, 15)];
    [tmpButton setBackgroundImage:UIImageGetImageFromName(@"unmarkPreference.png") forState:UIControlStateNormal];
    [tmpButton setBackgroundImage:UIImageGetImageFromName(@"markPreference.png") forState:UIControlStateHighlighted];
    [tmpButton setShowsTouchWhenHighlighted:YES];
    [tmpButton setSelected:YES];
    self.customSelectButton = tmpButton;
    [self.contentView addSubview:self.customSelectButton];
}

- (void)dealloc
{
    [typeName release];
    [customSelectButton release];
    
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
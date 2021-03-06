//
//  LotteryPreferenceCell.m
//  caibo
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "LotteryPreferenceCell.h"

@implementation LotteryPreferenceCell
@synthesize customStyle,preferenceOneView,preferenceTwoView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self.customStyle == CustomStyleOne) {
            [self initWithCustomOne];
        }else if (self.customStyle == CustomStyleTwo)
            {
            [self initWithCustomTwo];
            }
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(CustomStyle)custom
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.customStyle = custom;
    }
    return self;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithCustomOne
{
    LotteryPreferenceView *oneView = [[LotteryPreferenceView alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
    self.preferenceOneView = oneView;
    [self.contentView addSubview:oneView];
    [oneView release];
}
- (void)initWithCustomTwo
{
    LotteryPreferenceView *oneView = [[LotteryPreferenceView alloc]initWithFrame:CGRectMake(10, 5, 145, 30)];
    self.preferenceOneView = oneView;
    [self.contentView addSubview:oneView];
    [oneView release];
    
    LotteryPreferenceView *twoView = [[LotteryPreferenceView alloc]initWithFrame:CGRectMake(165, 5, 145, 30)];
    self.preferenceTwoView = twoView;
    [self.contentView addSubview:twoView];
    [twoView release];
}

- (void)dealloc

{
    [preferenceOneView release];
    [preferenceTwoView release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
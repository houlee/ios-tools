//
//  LiveScoreCell.m
//  caibo
//
//  Created by Kiefer on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LiveScoreCell.h"


@implementation LiveScoreCell

@synthesize lbStatus;
@synthesize lbHome;
@synthesize lbLeagueName;
@synthesize lbHost;
@synthesize lbAway;
@synthesize lbCaiguo;
@synthesize btnAtt;
@synthesize lsImageView;
@synthesize tuisongBnt;
@synthesize Btn;
@synthesize pptvlogoImage;
@synthesize changciLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    [lsImageView release];
    [lbStatus release];
    [lbHome release];
    [lbLeagueName release];
    [lbHost release];
    [lbAway release];
    [lbCaiguo release];
    [btnAtt release];
    [Btn release];
    [pptvlogoImage release];
    self.changciLable = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
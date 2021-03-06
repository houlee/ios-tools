//
//  LoadCell.m
//  caibo
//
//  Created by jeff.pluto on 11-7-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoadCell.h"

static NSString *sLabels[] = {
    @"暂无评论",
    @"获取中...",
    @"无此用户",
    @"Loading...",
};

@implementation LoadCell

@synthesize spinner;
@synthesize type;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // name label
    label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;    
    label.frame = CGRectMake(0, 0, 320, 47);
    [self.contentView addSubview:label];
    
    spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    [self.contentView addSubview:spinner];
    
	return self;
}

- (void)setType:(cellType)aType {
    type = aType;
    label.text = sLabels[type];
    
//    UIFont * font = label.font;
//    CGSize  size = CGSizeMake(300, 34);
//    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    
//    label.frame = CGRectMake((self.frame.size.height-labelSize.width)/2, 0, labelSize.width, 47);
    [spinner stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#ifdef isCaiPiaoForIPad
    CGRect bounds = [label textRectForBounds:CGRectMake(0, 0, 390, 48) limitedToNumberOfLines:1];
    spinner.frame = CGRectMake(bounds.origin.x + bounds.size.width + 4, (self.frame.size.height / 2) - 8, 16, 16);
    label.frame = CGRectMake(0, 0, 390, self.frame.size.height - 1);
#else
    CGRect bounds = [label textRectForBounds:CGRectMake(0, 0, 320, 48) limitedToNumberOfLines:1];
    spinner.frame = CGRectMake(bounds.origin.x + bounds.size.width + 4, (self.frame.size.height / 2) - 8, 16, 16);
    label.frame = CGRectMake(0, 0, 320, self.frame.size.height - 1);
#endif
   
}

- (void)dealloc {
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
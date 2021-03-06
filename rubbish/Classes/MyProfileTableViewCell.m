//
//  MyProfileTableViewCell.m
//  caibo
//
//  Created by GongHe on 14-5-29.
//
//

#import "MyProfileTableViewCell.h"

@implementation MyProfileTableViewCell
@synthesize iconImageView;
@synthesize titleLabel;
@synthesize bottomLine;

- (void)dealloc
{
    [iconImageView release];
    [titleLabel release];
    [bottomLine release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 18, 18)];
        iconImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:iconImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 160, 45)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        lineView.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
        [self.contentView addSubview:lineView];
        
        bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5, 320, 0.5)];
        bottomLine.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
        bottomLine.hidden = YES;
        [self.contentView addSubview:bottomLine];
        
        UIImageView *jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(297, 16, 8, 12)];
        jiantou.image = UIImageGetImageFromName(@"chongzhijian.png");
        jiantou.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:jiantou];
        [jiantou release];
        
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
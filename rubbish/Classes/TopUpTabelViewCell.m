//
//  TopUpTabelViewCell.m
//  caibo
//
//  Created by GongHe on 13-10-25.
//
//

#import "TopUpTabelViewCell.h"

@implementation TopUpTabelViewCell
@synthesize BGImageView,logoImgeView;
@synthesize arr;
@synthesize titleLabel,titleLabel1,detailLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
//        BGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
//        BGImageView.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:BGImageView];
        
        logoImgeView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(15, 8, 30, 30)];
        [self.contentView addSubview:logoImgeView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 3, 130, 20)];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(140,2.5, 90+60, 20)];
        titleLabel1.textColor = [UIColor redColor];
        titleLabel1.backgroundColor = [UIColor clearColor];
        titleLabel1.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:titleLabel1];
        
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 23, 200, 20)];
        [self.contentView addSubview:detailLabel];
        detailLabel.font = [UIFont boldSystemFontOfSize:12];
        detailLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        detailLabel.backgroundColor = [UIColor clearColor];
        
        UIImageView * arrowImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(320 - 13 - 15, (46-13)/2, 17/2, 13)] autorelease];
        arrowImageView.image = UIImageGetImageFromName(@"jiantou_1.png");
        [self.contentView addSubview:arrowImageView];
    }
    return self;
}

- (void)dealloc
{
    [BGImageView release];
    [logoImgeView release];
    [titleLabel release];
    [titleLabel1 release];
    [detailLabel release];
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
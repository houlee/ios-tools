//
//  PKRankingListTableViewCell.m
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "PKRankingListTableViewCell.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation PKRankingListTableViewCell
@synthesize medalImageView;
@synthesize userImageView;
@synthesize userNameLabel;
@synthesize earningsLabel;
@synthesize winningsLabel;
@synthesize mingciLab;

- (void)dealloc
{
    [mingciLab release];
    [medalImageView release];
    [userImageView release];
    [userNameLabel release];
    [earningsLabel release];
    [winningsLabel release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [SharedMethod getColorByHexString:@"faf9f3"];
        
        medalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 24, 24)];
        medalImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:medalImageView];
        
        mingciLab = [[UILabel alloc]init];
        mingciLab.frame = CGRectMake(0, 0, 24, 24);
        mingciLab.backgroundColor = [UIColor clearColor];
        mingciLab.font = [UIFont systemFontOfSize:15];
        mingciLab.textAlignment = NSTextAlignmentCenter;
        mingciLab.textColor = [UIColor whiteColor];
        [medalImageView addSubview:mingciLab];
        
        userImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(medalImageView) + 11, 10, 35, 35)];
        userImageView.backgroundColor = [UIColor clearColor];
        userImageView.layer.masksToBounds = YES;
        userImageView.layer.cornerRadius = 5;
        [self.contentView addSubview:userImageView];
        
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(userImageView) + 11, 19, 120, 20)];
        userNameLabel.font = [UIFont systemFontOfSize:14];
        userNameLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
        userNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:userNameLabel];
        
        earningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 12, 80, 14)];
        earningsLabel.font = [UIFont systemFontOfSize:12];
        earningsLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
        earningsLabel.textAlignment = 2;
        earningsLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:earningsLabel];
        
        winningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(earningsLabel.frame.origin.x, ORIGIN_Y(earningsLabel) + 8, earningsLabel.frame.size.width, earningsLabel.frame.size.height)];
        winningsLabel.font = [UIFont systemFontOfSize:12];
        winningsLabel.textColor = [SharedMethod getColorByHexString:@"ff4337"];
        winningsLabel.textAlignment = 2;
        winningsLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:winningsLabel];
        
        UIImageView * arrowImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 15 - 12.5, 23.5, 8, 12.5)] autorelease];
        arrowImageView.image = UIImageGetImageFromName(@"chongzhijian.png");
        [self.contentView addSubview:arrowImageView];
        
        UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(15, 54.5, 320, 0.5)] autorelease];
        line.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
        [self.contentView addSubview:line];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
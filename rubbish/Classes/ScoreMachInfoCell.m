//
//  ScoreMachInfoCell.m
//  caibo
//
//  Created by yaofuyu on 13-7-4.
//
//

#import "ScoreMachInfoCell.h"

@implementation ScoreMachInfoCell
@synthesize Myevent;
@synthesize isLanqiu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 33)];
        [self.contentView addSubview:backImageV];
        [backImageV release];
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 32, 296, 1)];
        [self.contentView addSubview:lineV];
        lineV.image = UIImageGetImageFromName(@"SZTG960.png");
        lineV.backgroundColor = [UIColor clearColor];
        [lineV release];
        
        leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(116, 10, 14, 14)];
        [self.contentView addSubview:leftImageV];
        leftImageV.backgroundColor = [UIColor clearColor];
        [leftImageV release];
        
        rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(186, 10, 14, 14)];
        [self.contentView addSubview:rightImageV];
        rightImageV.backgroundColor = [UIColor clearColor];
        [rightImageV release];
        
        midImageV = [[UIImageView alloc] initWithFrame:CGRectMake(138, 0, 45, 33)];
        [self.contentView addSubview:midImageV];
        midImageV.backgroundColor = [UIColor clearColor];
        [midImageV release];
        
        leftLabel = [[UILabel alloc] init];
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:leftLabel];
        leftLabel.frame = CGRectMake(10, 10, 120, 13);
        [leftLabel release];
        
        rightLabel = [[UILabel alloc] init];
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:rightLabel];
        rightLabel.frame = CGRectMake(190, 10, 120, 13);
        [rightLabel release];
        
        midLabel = [[UILabel alloc] init];
        midLabel.backgroundColor = [UIColor clearColor];
        midLabel.textAlignment = NSTextAlignmentCenter;
        midLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:midLabel];
        midLabel.frame = CGRectMake(130, 10, 60, 13);
        [midLabel release];
        isLanqiu = NO;
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(UIImage *)returnImageByType: (NSInteger)type {
    NSString *strImageName = @"";
	
	switch (type) {
		case 0:
			strImageName = @"icon_jinqiu.png";
			break;
		case 1:
			strImageName = @"icon_dianqiu.png";
			break;
		case 2:
			strImageName = @"icon_wulong.png";
			break;
		case 3:
			strImageName = @"icon_huangpai.png";
			break;
		case 4:
			strImageName = @"icon_hongpai.png";
			break;
		default:
			break;
	}
    if ([strImageName length]) {
        return UIImageGetImageFromName(strImageName);
    }
    return nil;
}
//SZT-S-960

- (void)LoadMacthInfo:(MacthEvent *)event Row:(NSInteger) row {
    self.Myevent = event;
    leftLabel.text = nil;
    rightLabel.text = nil;
    midLabel.text = nil;
    leftImageV.image = nil;
    rightImageV.image = nil;
    if (row == 0) {
        backImageV.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
        midImageV.image = UIImageGetImageFromName(@"bifenFangkuai1.png");
        midImageV.frame = CGRectMake(138, 1, 45, 32);
    }
    else {
        backImageV.image = [UIImageGetImageFromName(@"SZT-Z-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
        midImageV.image = UIImageGetImageFromName(@"bifenFangkuai2.png");
        midImageV.frame = CGRectMake(138, 0, 45, 33);
    }
    if (isLanqiu) {
        midLabel.text = event.name;
        leftLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.textAlignment = NSTextAlignmentCenter;
        NSArray *array = [event.scroe componentsSeparatedByString:@":"];
        if ([array count] == 2) {
            leftLabel.text = [array objectAtIndex:0];
            rightLabel.text = [array objectAtIndex:1];
        }
        
    }
    else {
        if (event.teamType == 1) {
            rightImageV.image = [ScoreMachInfoCell returnImageByType:event.eventType];
            rightLabel.text = event.name;
        }
        else {
            leftImageV.image = [ScoreMachInfoCell returnImageByType:event.eventType];
            leftLabel.text = event.name;
        }
        midLabel.text = event.mins;
    }

}

- (void)dealloc {
    self.Myevent = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
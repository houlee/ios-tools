//
//  EveryDayForecastCell.m
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import "EveryDayForecastCell.h"
#import "ForecastNumImageView.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation EveryDayForecastCell
@synthesize lotteryNameLabel,issueLabel,bgImageView;

- (void)dealloc
{
    [lotteryNameLabel release];
    [issueLabel release];
    [bgImageView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (WEIBO_YUCE_CELL_HEIGHT_1 - 51)/2, self.contentView.frame.size.width - 24, 51)];
//        bgImageView.image = [[UIImage imageNamed:@"ForecastBG.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        bgImageView.backgroundColor = [SharedMethod getColorByHexString:@"b8edfe"];
        [self.contentView addSubview:bgImageView];
        
        lotteryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 61, 20)];
        lotteryNameLabel.backgroundColor = [UIColor clearColor];
        lotteryNameLabel.textAlignment = 1;
        lotteryNameLabel.textColor = [SharedMethod getColorByHexString:@"1a1a1a"];
        lotteryNameLabel.font = [UIFont systemFontOfSize:12];
        [bgImageView addSubview:lotteryNameLabel];
        
        issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(lotteryNameLabel.frame.origin.x, ORIGIN_Y(lotteryNameLabel), lotteryNameLabel.frame.size.width, lotteryNameLabel.frame.size.height)];
        issueLabel.backgroundColor = [UIColor clearColor];
        issueLabel.textAlignment = 1;
        issueLabel.textColor = [SharedMethod getColorByHexString:@"1588da"];
        issueLabel.font = [UIFont systemFontOfSize:12];
        [bgImageView addSubview:issueLabel];
        
        UIView * wBGView = [[UIView alloc] initWithFrame:CGRectMake(ORIGIN_X(issueLabel), 0.5, bgImageView.frame.size.width -ORIGIN_X(issueLabel) - 0.5, bgImageView.frame.size.height - 0.5 * 2)];
        wBGView.backgroundColor = [UIColor whiteColor];
        [bgImageView addSubview:wBGView];
        [bgImageView sendSubviewToBack:wBGView];
        [wBGView release];
        
        UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, WEIBO_YUCE_CELL_HEIGHT_1 - 0.5, 320, 0.5)] autorelease];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
        
        for (int i = 0; i < 20; i++) {
            CGRect imageViewFrame;
            if (i < 10) {
                imageViewFrame = CGRectMake(ORIGIN_X(issueLabel) + 5 + i * (18 + 5), 5, 18, 18);
            }else{
                imageViewFrame = CGRectMake(ORIGIN_X(issueLabel) + 5 + (i - 10) * (18 + 5), 5 + 18 + 5, 18, 18);
            }
            ForecastNumImageView * numberImageView = [[ForecastNumImageView alloc] initWithFrame:imageViewFrame];
            numberImageView.backgroundColor = [SharedMethod getColorByHexString:@"b8edfe"];
            [bgImageView addSubview:numberImageView];
            numberImageView.tag = 10 + i;
            [numberImageView release];
        }
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
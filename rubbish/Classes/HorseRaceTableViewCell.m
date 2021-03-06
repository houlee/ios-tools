//
//  HorseRaceTableViewCell.m
//  caibo
//
//  Created by GongHe on 15-1-21.
//
//

#import "HorseRaceTableViewCell.h"
#import "SharedDefine.h"
#import "SharedMethod.h"

@implementation HorseRaceTableViewCell
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize line;
@synthesize lotteryNumView;
@synthesize fenLabel;
@synthesize delegate;
@synthesize myIndexPath;

- (void)dealloc
{
    [titleLabel release];
    [descriptionLabel release];
    [line release];
    [lotteryNumView release];
    [fenLabel release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [SharedMethod getColorByHexString:@"f4f4f4"];
        
        UIView * titleView = [[[UIView alloc] initWithFrame:CGRectMake(15, 7, 23, 33)] autorelease];
        [self.contentView addSubview:titleView];
        titleView.backgroundColor = [SharedMethod getColorByHexString:@"b38144"];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 15, 33)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = 0;
        titleLabel.textAlignment = 1;
        [titleView addSubview:titleLabel];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(titleView) + 13, 6, 320 - ORIGIN_X(titleLabel) - (ORIGIN_X(titleLabel) + 13), 21)];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.textColor = [SharedMethod getColorByHexString:@"929292"];
        descriptionLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:descriptionLabel];
        
        lotteryNumView = [[UIView alloc] initWithFrame:CGRectMake(descriptionLabel.frame.origin.x, ORIGIN_Y(descriptionLabel) - 3, self.frame.size.width - descriptionLabel.frame.origin.x, 17)];
        lotteryNumView.backgroundColor = [UIColor clearColor];
        lotteryNumView.hidden = YES;
        [self.contentView addSubview:lotteryNumView];
        
        for (int i = 0; i < 11; i++) {
            UIImageView * redBallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 17.5 , 0.5, 15, 15)];
            redBallImageView.image = UIImageGetImageFromName(@"HorseRadBall.png");
            [lotteryNumView addSubview:redBallImageView];
            [redBallImageView release];
            redBallImageView.hidden = YES;
            redBallImageView.tag = 100 + i;
            
            UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            numLabel.textColor = [UIColor whiteColor];
            [redBallImageView addSubview:numLabel];
            numLabel.textAlignment = 1;
            numLabel.backgroundColor = [UIColor clearColor];
            numLabel.font = [UIFont systemFontOfSize:10];
            numLabel.tag = 200 + i;
            [numLabel release];
        }
        
        UIButton * deleteButton = [[[UIButton alloc] initWithFrame:CGRectMake(lotteryNumView.frame.size.width - 13 - 30, -15, 36, 36)] autorelease];
        [lotteryNumView addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteLotteryNumber:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.backgroundColor = [UIColor clearColor];
        
        UIImageView * deleteImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(9.5, 14, 17, 17)] autorelease];
        deleteImageView.image = UIImageGetImageFromName(@"HorseDelete.png");
        [deleteButton addSubview:deleteImageView];
        
        fenLabel = [[UILabel alloc] initWithFrame:CGRectMake(deleteButton.frame.origin.x - 40 + 5, 1, 40, 15)];
        fenLabel.backgroundColor = [UIColor clearColor];
        fenLabel.textColor = [SharedMethod getColorByHexString:@"505050"];
        fenLabel.font = [UIFont systemFontOfSize:9];
        fenLabel.textAlignment = 2;
        [lotteryNumView addSubview:fenLabel];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        line.backgroundColor = [SharedMethod getColorByHexString:@"c7c7c7"];
        [self.contentView addSubview:line];
    }
    return self;
}

-(void)setLotteryNumberByString:(NSString *)lotteryNum
{
    NSArray * numberArray = [lotteryNum componentsSeparatedByString:@","];
    for (int i = 0; i < 11; i++) {
        UIImageView * ballImageView = (UIImageView *)[lotteryNumView viewWithTag:100 + i];
        UILabel * numLabel = (UILabel *)[ballImageView viewWithTag:200 + i];

        if (i < numberArray.count) {
            ballImageView.hidden = NO;
            numLabel.text = [numberArray objectAtIndex:i];
        }else{
            ballImageView.hidden = YES;
        }
    }
    lotteryNumView.hidden = NO;
}

-(void)deleteLotteryNumber:(UIButton *)deleteButton
{
    if (delegate && [delegate respondsToSelector:@selector(deleteLotteryNumberWithIndexPath:)]) {
        [delegate deleteLotteryNumberWithIndexPath:myIndexPath];
    }
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
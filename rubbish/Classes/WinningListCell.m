//
//  WinningListCell.m
//  caibo
//
//  Created by cp365dev on 14-5-13.
//
//

#import "WinningListCell.h"

@implementation WinningListCell
@synthesize mDay;
@synthesize mMouth;
@synthesize mYear;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)addCellWithTime:(NSString *)time andName:(NSString *)name andPrize:(NSString *)prize andType:(NSString *)type
{
    
    NSString *year = [time substringWithRange:NSMakeRange(0, 4)];
    NSString *mouth = [time substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [time substringWithRange:NSMakeRange(8, 2)];
    
    
    //若时间(年月日)相同，则只显示一列时间,并且线的位置要后移
    if([self.mYear isEqualToString:year] &&[self.mMouth isEqualToString:mouth]&&[self.mDay isEqualToString:day])
    {
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 51, 320-90,1)];
        [xian2 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self.contentView addSubview:xian2];
        [xian2 release];

    }
    else
    {
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 320,1)];
        [xian2 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self.contentView addSubview:xian2];
        [xian2 release];
        
        //时间
        UILabel *mouthLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 90, 10)];
        mouthLabel.text = [NSString stringWithFormat:@"%@月",mouth];
        mouthLabel.textColor = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1];
        mouthLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:mouthLabel];
        [mouthLabel release];
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24.5, 90, 17.5)];
        dayLabel.text = day;
        dayLabel.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
        dayLabel.font = [UIFont systemFontOfSize:24];
        [self.contentView addSubview:dayLabel];
        [dayLabel release];
    }
    
    self.mYear = [NSString stringWithString:year];
    self.mMouth = [NSString stringWithString:mouth];
    self.mDay = [NSString stringWithString:day];

    
    //列线
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(89, 0, 1, 52)];
    [xian1 setImage:UIImageGetImageFromName(@"wf_xian.png")];
    [self.contentView addSubview:xian1];
    [xian1 release];
    
    
    //name
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 100, 52)];
    nameLabel.text = name;
    nameLabel.textColor = [UIColor colorWithRed:96.0/255.0 green:96.0/255.0 blue:96.0/255.0 alpha:1];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel release];
    
    //奖品
    UILabel *prizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 50, 52)];
    prizeLabel.text = prize;
    prizeLabel.textColor = [UIColor redColor];
    prizeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:prizeLabel];
    [prizeLabel release];
    
    //类型
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 50, 52)];
    typeLabel.text = type;
    typeLabel.textColor = [UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1];
    typeLabel.font = [UIFont systemFontOfSize:15];
    typeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:typeLabel];
    [typeLabel release];
    
    
}
- (void)awakeFromNib
{
    // Initialization code
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
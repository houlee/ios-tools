//
//  PointCell.m
//  caibo
//
//  Created by cp365dev on 14-5-13.
//
//

#import "PointCell.h"

@implementation PointCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)addCellWithTime:(NSString *)time andType:(NSString *)type andGet:(NSString *)get andpost:(NSString *)post
{

    //纵线
    for(int i = 0;i<5;i++)
    {
        UIImageView *xianImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 100)];
        if(i==1)
            xianImage.frame = CGRectMake(86, 0, 1, 50);
        if(i == 2)
            xianImage.frame = CGRectMake(159, 0, 1, 50);
        if(i == 3)
            xianImage.frame = CGRectMake(229, 0, 1, 50);
        if(i == 4)
            xianImage.frame = CGRectMake(297, 0, 1, 50);
        [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
        [self.contentView addSubview:xianImage];
        [xianImage release];
    }
    
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 86, 50)];
    timeLabel.numberOfLines = 0;
    timeLabel.text = time;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.contentView addSubview:timeLabel];
    [timeLabel release];
    //类型
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(86, 0, 73, 50)];
    typeLabel.numberOfLines = 0;
    typeLabel.text = type;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.font = [UIFont systemFontOfSize:14];
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.contentView addSubview:typeLabel];
    [typeLabel release];
    
    //获得积分
    if(![get isEqualToString:@""])
    {
        UILabel *getLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 70, 50)];
        getLabel.text = get;
        getLabel.backgroundColor = [UIColor clearColor];
        getLabel.tag = 102;
        getLabel.textAlignment = NSTextAlignmentCenter;
        getLabel.textColor = [UIColor redColor];
        getLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:getLabel];
        [getLabel release];
    }
    //消耗积分
    if(![post isEqualToString:@""])
    {
        UILabel *postLabel = [[UILabel alloc] initWithFrame:CGRectMake(229, 0, 70, 50)];
        postLabel.text = post;
        postLabel.textColor = [UIColor blueColor];
        postLabel.backgroundColor = [UIColor clearColor];
        postLabel.tag = 103;
        postLabel.textAlignment = NSTextAlignmentCenter;
        postLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:postLabel];
        [postLabel release];
        
    }
    //横线
    UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
    [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
    [self.contentView addSubview:xian];
    [xian release];

    
    

    
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
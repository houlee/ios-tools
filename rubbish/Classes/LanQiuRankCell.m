//
//  LanQiuRankCell.m
//  caibo
//
//  Created by yaofuyu on 13-12-13.
//
//

#import "LanQiuRankCell.h"

@implementation LanQiuRankCell
@synthesize hostID,guestID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 30)];
        [self.contentView addSubview:backImageV];
        [backImageV release];
        lab1 = [[UILabel alloc] init];
        lab1.frame = CGRectMake(0, 0, 60, 30);
        lab1.text = @"排名";
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.backgroundColor = [UIColor clearColor];
        lab1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab1];
        [lab1 release];
        
        lab2 = [[UILabel alloc] init];
        lab2.frame = CGRectMake(60, 0, 80, 30);
        lab2.text = @"球队";
        lab2.textAlignment = NSTextAlignmentLeft;
        lab2.backgroundColor = [UIColor clearColor];
        lab2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab2];
        [lab2 release];
        
        
        lab3 = [[UILabel alloc] init];
        lab3.frame = CGRectMake(140, 0, 30, 30);
        lab3.text = @"胜";
        lab3.textAlignment = NSTextAlignmentCenter;
        lab3.backgroundColor = [UIColor clearColor];
        lab3.font = [UIFont systemFontOfSize:12];
        lab3.textColor = [UIColor grayColor];
        [self.contentView addSubview:lab3];
        [lab3 release];
        
        lab4 = [[UILabel alloc] init];
        lab4.frame = CGRectMake(170, 0, 30, 30);
        lab4.text = @"负";
        lab4.textAlignment = NSTextAlignmentCenter;
        lab4.backgroundColor = [UIColor clearColor];
        lab4.font = [UIFont systemFontOfSize:12];
        lab4.textColor = [UIColor grayColor];
        [self.contentView addSubview:lab4];
        [lab4 release];
        
        lab5 = [[UILabel alloc] init];
        lab5.frame = CGRectMake(200, 0, 45, 30);
        lab5.text = @"胜率";
        lab5.textAlignment = NSTextAlignmentCenter;
        lab5.backgroundColor = [UIColor clearColor];
        lab5.font = [UIFont systemFontOfSize:12];
        lab5.textColor = [UIColor grayColor];
        [self.contentView addSubview:lab5];
        [lab5 release];
        
        lab6 = [[UILabel alloc] init];
        lab6.frame = CGRectMake(245, 0, 45, 30);
        lab6.text = @"胜差";
        lab6.textColor = [UIColor grayColor];
        lab6.textAlignment = NSTextAlignmentCenter;
        lab6.backgroundColor = [UIColor clearColor];
        lab6.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:lab6];
        [lab6 release];
        
        imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, 320, 1)];
		[self.contentView addSubview:imageV];
        imageV.tag = 111;
        imageV.backgroundColor = [UIColor clearColor];
        imageV.image = UIImageGetImageFromName(@"yucexuxian.png");
        [imageV release];
    }
    return self;
}

- (void)LoadData:(NSDictionary *)dic {
    backImageV.image = UIImageGetImageFromName(@"yucebifen.png");
    if ([[dic valueForKey:@"team_id"] isEqualToString:self.hostID]||[[dic valueForKey:@"team_id"] isEqualToString:self.guestID]) {
        
        backImageV.image = [UIImageGetImageFromName(@"yucezhuke.png") stretchableImageWithLeftCapWidth:6 topCapHeight:0];
        
    }
    lab1.text = [dic objectForKey:@"order"];
    if ([lab1.text intValue] <= 3) {
        lab1.textColor = [ UIColor redColor];
    }
    else {
        lab1.textColor = [UIColor blackColor];
    }
    lab2.text = [dic objectForKey:@"team_name"];
    lab3.text = [dic objectForKey:@"win_count"];
    lab4.text = [dic objectForKey:@"lost_count"];
    lab5.text = [NSString stringWithFormat:@"%.1f%%",[[dic objectForKey:@"win_rate"] floatValue] * 100];
    lab6.text = [dic objectForKey:@"win_poor"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    self.hostID = nil;
    self.guestID = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
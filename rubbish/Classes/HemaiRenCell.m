//
//  HemaiRenCell.m
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-30.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "HemaiRenCell.h"

@implementation HemaiRenCell

@synthesize InfoData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1.0];
        
        UIView *image = [[UIView alloc] init];
        [self.contentView addSubview:image];
        image.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:237/255.0 alpha:1.0];
        image.frame = CGRectMake(0, 0, 102, 71);
        [image release];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(102, 0, 0.5, 71)];
        line1.backgroundColor = [UIColor colorWithRed:224/255.0 green:218/255.0 blue:203/255.0 alpha:1.0];
        [self.contentView addSubview:line1];
        [line1 release];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 70.5, 320, 0.5)];
        line2.backgroundColor = [UIColor colorWithRed:224/255.0 green:218/255.0 blue:203/255.0 alpha:1.0];
        [self.contentView addSubview:line2];
        [line2 release];
        
        // Initialization code
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 15, 80, 18)];
        nameLabel.font = [UIFont boldSystemFontOfSize:16];
        nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        nameLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 87, 14)];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0];
        [self.contentView addSubview:timeLabel];
        [timeLabel release];
        
        PaiJiangHouLabel = [[UILabel alloc] initWithFrame:CGRectMake(277, 80, 17, 20)];
        PaiJiangHouLabel.backgroundColor = [UIColor clearColor];
        PaiJiangHouLabel.font = [UIFont systemFontOfSize:13];
        PaiJiangHouLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [self.contentView addSubview:PaiJiangHouLabel];
        PaiJiangHouLabel.text = @"元";
        [PaiJiangHouLabel release];
        
        PaiJiangLabel = [[UILabel alloc] init];
        PaiJiangLabel.backgroundColor = [UIColor clearColor];
        PaiJiangLabel.font = [UIFont systemFontOfSize:15];
        PaiJiangLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
        [self.contentView addSubview:PaiJiangLabel];
        [PaiJiangLabel release];
        
        PaiJiangQianLabel = [[UILabel alloc] init];
        PaiJiangQianLabel.backgroundColor = [UIColor clearColor];
        PaiJiangQianLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        PaiJiangQianLabel.frame = CGRectMake(115, 40, 35, 18);
        [self.contentView addSubview:PaiJiangQianLabel];
        PaiJiangQianLabel.font = [UIFont systemFontOfSize:15];
        PaiJiangQianLabel.text = @"派奖";
        [PaiJiangQianLabel release];
        
        fenLabel = [[UILabel alloc] init];
        fenLabel.backgroundColor = [UIColor clearColor];
        fenLabel.font = [UIFont systemFontOfSize:13];
        fenLabel.frame = CGRectMake(71, 18, 15, 15);
        [self.contentView addSubview:fenLabel];
        fenLabel.text = @"份";
        fenLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [fenLabel release];
        
        fenshuLabel = [[UILabel alloc] init];
        fenshuLabel.backgroundColor = [UIColor clearColor];
        fenshuLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255.0/255.0 alpha:1.0];
        fenshuLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:fenshuLabel];
        fenshuLabel.frame = CGRectMake(5, 12, 65, 24);
        fenshuLabel.font = [UIFont systemFontOfSize:22];
        [fenshuLabel release];
        UIImageView *jiantou = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"jiantou_1.png")];
        jiantou.frame = CGRectMake(300, 30, 6, 10);
        [self.contentView addSubview:jiantou];
        [jiantou release];
        //        heardImageView = [[DownLoadImageView alloc] init];
//        [self.contentView addSubview:heardImageView];
//        heardImageView.frame = CGRectMake(50, 5, 40, 40);
//        [heardImageView release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)LoadData:(CanYuRen *)_InfoData {
    self.InfoData = _InfoData;
    nameLabel.text = self.InfoData.nickName;
    timeLabel.text = self.InfoData.time;
    fenshuLabel.text = self.InfoData.buyFen;
    
    
    if ([self.InfoData.money floatValue] == 0) {
        PaiJiangLabel.hidden = YES;
        PaiJiangQianLabel.hidden = YES;
        PaiJiangHouLabel.hidden = YES;
    }
    else {
        PaiJiangLabel.hidden = NO;
        PaiJiangQianLabel.hidden = NO;
        PaiJiangHouLabel.hidden = NO;
        PaiJiangLabel.text = [NSString stringWithFormat:@"¥%@",self.InfoData.money];
        
        PaiJiangLabel.frame = CGRectMake(152,39 , [PaiJiangLabel.text sizeWithFont:PaiJiangLabel.font].width+5, 20);
        PaiJiangHouLabel.frame = CGRectMake(PaiJiangLabel.frame.origin.x  + [PaiJiangLabel.text sizeWithFont:PaiJiangLabel.font].width+5, 40, 40, 20);
    }
    
}

- (void)dealloc {
    self.InfoData = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  ShiYiXuanWuCell.m
//  caibo
//
//  Created by yao on 12-6-18.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ShiYiXuanWuCell.h"
#import "GC_LotteryType.h"

@implementation ShiYiXuanWuCell

@synthesize shiyixuanwuCellDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor=[UIColor whiteColor];

        backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        
        backImage.backgroundColor=[UIColor clearColor];
        
        lineIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5)];
        lineIma.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        
        [self.contentView addSubview:backImage];
        [self.contentView addSubview:lineIma];
        
        
        [backImage release];
        [lineIma release];

		numLabel = [[UILabel alloc] init];
		numLabel.numberOfLines = 0;
		numLabel.font = [UIFont systemFontOfSize:16];
		numLabel.textColor = [UIColor redColor];
		numLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:numLabel];
		[numLabel release];
		
		zhuLabel = [[UILabel alloc] init];
		zhuLabel.numberOfLines = 0;
		zhuLabel.font = [UIFont systemFontOfSize:12];
		zhuLabel.textAlignment = NSTextAlignmentRight;
		zhuLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:zhuLabel];
		[zhuLabel release];
		
        
        UIButton *shanchu=[UIButton buttonWithType:UIButtonTypeCustom];
//        shanchu.frame=CGRectMake(10, 5, 28, 28);
        shanchu.frame=CGRectMake(4, 2, 40, 40);
        shanchu.backgroundColor=[UIColor clearColor];
        [shanchu addTarget:self action:@selector(ShanChu) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:shanchu];
        
        UIImageView *shanchuIma=[[UIImageView alloc]init];
//        shanchuIma.frame=CGRectMake(5, 5, 18, 18);
        shanchuIma.frame=CGRectMake(11, 11, 18, 18);
        shanchuIma.backgroundColor=[UIColor clearColor];
        shanchuIma.image=[UIImage imageNamed:@"touzhushanchu.png"];
        [shanchu addSubview:shanchuIma];
        [shanchuIma release];
        
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (NSString *)nameForLottery:(LotteryTYPE)lotterytype {
    if (lotterytype==TYPE_GD11XUAN5_1) {
		return @"前一直选";
	}
	if (lotterytype==TYPE_GD11XUAN5_2) {
		return @"任选二";
	}
	if (lotterytype==TYPE_GD11XUAN5_3) {
		return @"任选三";
	}
	if (lotterytype==TYPE_GD11XUAN5_4) {
		return @"任选四";
	}
	if (lotterytype==TYPE_GD11XUAN5_5) {
		return @"任选五";
	}
	if (lotterytype==TYPE_GD11XUAN5_6) {
		return @"任选六";
	}
	if (lotterytype==TYPE_GD11XUAN5_7) {
		return @"任选七";
	}
	if (lotterytype==TYPE_GD11XUAN5_8) {
		return @"任选八";
	}
	if (lotterytype==TYPE_GD11XUAN5_Q2ZHI) {
		return @"前二直选";
	}
	if (lotterytype==TYPE_GD11XUAN5_Q3ZHI) {
		return @"前三直选";
	}
    if (lotterytype==TYPE_GD11XUAN5_Q2ZU) {
        return @"前二组选";
    }
    if (lotterytype==TYPE_GD11XUAN5_Q3ZU) {
        return @"前三组选";
    }
    if (lotterytype==TYPE_GD11XUAN5_R2DaTuo) {
		return @"任选二胆拖";
	}
    if (lotterytype==TYPE_GD11XUAN5_R3DaTuo) {
		return @"任选三胆拖";
	}
    if (lotterytype==TYPE_GD11XUAN5_R4DaTuo) {
		return @"任选四胆拖";
	}
    if (lotterytype==TYPE_GD11XUAN5_R5DaTuo) {
		return @"任选五胆拖";
	}
    if (lotterytype==TYPE_GD11XUAN5_Q2DaTuo) {
		return @"前二组选胆拖";
	}
    if (lotterytype==TYPE_GD11XUAN5_Q3DaTuo) {
		return @"前三组选胆拖";
	}
    
	if (lotterytype==TYPE_11XUAN5_1) {
		return @"前一直选";
	}
	if (lotterytype==TYPE_11XUAN5_2) {
		return @"任选二";
	}
	if (lotterytype==TYPE_11XUAN5_3) {
		return @"任选三";
	}
	if (lotterytype==TYPE_11XUAN5_4) {
		return @"任选四";
	}
	if (lotterytype==TYPE_11XUAN5_5) {
		return @"任选五";
	}
	if (lotterytype==TYPE_11XUAN5_6) {
		return @"任选六";
	}
	if (lotterytype==TYPE_11XUAN5_7) {
		return @"任选七";
	}
	if (lotterytype==TYPE_11XUAN5_8) {
		return @"任选八";
	}
	if (lotterytype==TYPE_11XUAN5_Q2ZHI) {
		return @"前二直选";
	}
	if (lotterytype==TYPE_11XUAN5_Q3ZHI) {
		return @"前三直选";
	}
    if (lotterytype==TYPE_11XUAN5_Q2ZU) {
        return @"前二组选";
    }
    if (lotterytype==TYPE_11XUAN5_Q3ZU) {
        return @"前三组选";
    }
    if (lotterytype==TYPE_11XUAN5_R2DaTuo) {
		return @"任选二胆拖";
	}
    if (lotterytype==TYPE_11XUAN5_R3DaTuo) {
		return @"任选三胆拖";
	}
    if (lotterytype==TYPE_11XUAN5_R4DaTuo) {
		return @"任选四胆拖";
	}
    if (lotterytype==TYPE_11XUAN5_R5DaTuo) {
		return @"任选五胆拖";
	}
    if (lotterytype==TYPE_11XUAN5_Q2DaTuo) {
		return @"前二组选胆拖";
	}
    if (lotterytype==TYPE_11XUAN5_Q3DaTuo) {
		return @"前三组选胆拖";
	}
    
    if (lotterytype==TYPE_JX11XUAN5_1) {
        return @"前一直选";
    }
    if (lotterytype==TYPE_JX11XUAN5_2) {
        return @"任选二";
    }
    if (lotterytype==TYPE_JX11XUAN5_3) {
        return @"任选三";
    }
    if (lotterytype==TYPE_JX11XUAN5_4) {
        return @"任选四";
    }
    if (lotterytype==TYPE_JX11XUAN5_5) {
        return @"任选五";
    }
    if (lotterytype==TYPE_JX11XUAN5_6) {
        return @"任选六";
    }
    if (lotterytype==TYPE_JX11XUAN5_7) {
        return @"任选七";
    }
    if (lotterytype==TYPE_JX11XUAN5_8) {
        return @"任选八";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q2ZHI) {
        return @"前二直选";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q3ZHI) {
        return @"前三直选";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q2ZU) {
        return @"前二组选";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q3ZU) {
        return @"前三组选";
    }
    if (lotterytype==TYPE_JX11XUAN5_R2DaTuo) {
        return @"任选二胆拖";
    }
    if (lotterytype==TYPE_JX11XUAN5_R3DaTuo) {
        return @"任选三胆拖";
    }
    if (lotterytype==TYPE_JX11XUAN5_R4DaTuo) {
        return @"任选四胆拖";
    }
    if (lotterytype==TYPE_JX11XUAN5_R5DaTuo) {
        return @"任选五胆拖";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q2DaTuo) {
        return @"前二组选胆拖";
    }
    if (lotterytype==TYPE_JX11XUAN5_Q3DaTuo) {
        return @"前三组选胆拖";
    }
    
    if (lotterytype==TYPE_HB11XUAN5_1) {
        return @"前一直选";
    }
    if (lotterytype==TYPE_HB11XUAN5_2) {
        return @"任选二";
    }
    if (lotterytype==TYPE_HB11XUAN5_3) {
        return @"任选三";
    }
    if (lotterytype==TYPE_HB11XUAN5_4) {
        return @"任选四";
    }
    if (lotterytype==TYPE_HB11XUAN5_5) {
        return @"任选五";
    }
    if (lotterytype==TYPE_HB11XUAN5_6) {
        return @"任选六";
    }
    if (lotterytype==TYPE_HB11XUAN5_7) {
        return @"任选七";
    }
    if (lotterytype==TYPE_HB11XUAN5_8) {
        return @"任选八";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q2ZHI) {
        return @"前二直选";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q3ZHI) {
        return @"前三直选";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q2ZU) {
        return @"前二组选";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q3ZU) {
        return @"前三组选";
    }
    if (lotterytype==TYPE_HB11XUAN5_R2DaTuo) {
        return @"任选二胆拖";
    }
    if (lotterytype==TYPE_HB11XUAN5_R3DaTuo) {
        return @"任选三胆拖";
    }
    if (lotterytype==TYPE_HB11XUAN5_R4DaTuo) {
        return @"任选四胆拖";
    }
    if (lotterytype==TYPE_HB11XUAN5_R5DaTuo) {
        return @"任选五胆拖";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q2DaTuo) {
        return @"前二组选胆拖";
    }
    if (lotterytype==TYPE_HB11XUAN5_Q3DaTuo) {
        return @"前三组选胆拖";
    }
    
    if (lotterytype==TYPE_ShanXi11XUAN5_1) {
        return @"前一直选";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_2) {
        return @"任选二";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_3) {
        return @"任选三";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_4) {
        return @"任选四";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_5) {
        return @"任选五";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_6) {
        return @"任选六";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_7) {
        return @"任选七";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_8) {
        return @"任选八";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q2ZHI) {
        return @"前二直选";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q3ZHI) {
        return @"前三直选";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q2ZU) {
        return @"前二组选";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q3ZU) {
        return @"前三组选";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_R2DaTuo) {
        return @"任选二胆拖";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_R3DaTuo) {
        return @"任选三胆拖";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_R4DaTuo) {
        return @"任选四胆拖";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_R5DaTuo) {
        return @"任选五胆拖";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q2DaTuo) {
        return @"前二组选胆拖";
    }
    if (lotterytype==TYPE_ShanXi11XUAN5_Q3DaTuo) {
        return @"前三组选胆拖";
    }
	return nil;
}

- (void)LoadData:(NSDictionary *)dic {
	CGSize maxSize = CGSizeMake(140, 1000);
	NSString *Num = [dic objectForKey:@"Num"];
	Num = [Num substringFromIndex:3];
    NSString *asdNum=Num;
    NSRange asd=[Num rangeOfString:@","];
    LotteryTYPE lotterytype = [[dic objectForKey:@"lotterytype"] intValue];
    
    if ((lotterytype >= TYPE_11XUAN5_R2DaTuo && lotterytype <= TYPE_11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_GD11XUAN5_R2DaTuo && lotterytype <= TYPE_GD11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_JX11XUAN5_R2DaTuo && lotterytype <= TYPE_JX11XUAN5_Q3DaTuo)|| (lotterytype >= TYPE_HB11XUAN5_R2DaTuo && lotterytype <= TYPE_HB11XUAN5_Q3DaTuo)|| (lotterytype >= TYPE_ShanXi11XUAN5_R2DaTuo && lotterytype <= TYPE_ShanXi11XUAN5_Q3DaTuo)) {
        Num = [Num stringByReplacingOccurrencesOfString:@"|" withString:@"] "];
        Num = [NSString stringWithFormat:@"[%@",Num];
        Num = [Num stringByReplacingOccurrencesOfString:@"," withString:@" "];
    }
    else if(asd.length)
    {
        Num = [Num stringByReplacingOccurrencesOfString:@"," withString:@" "];
        Num = [Num stringByReplacingOccurrencesOfString:@"|" withString:@" | "];
    }
    else
    {
        Num = [Num stringByReplacingOccurrencesOfString:@"|" withString:@" "];
    }
	numLabel.text = Num;

    CGSize expectedSize = [asdNum sizeWithFont:numLabel.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];

    if (expectedSize.height <33) {
        expectedSize.height = 33+6;
    }

    numLabel.frame = CGRectMake(50, 2, 140, expectedSize.height);
	
    backImage.frame  = CGRectMake(0, 0, 320, expectedSize.height+2+4);
    lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
    zhuLabel.frame = CGRectMake(160+20, 8, 120, 28);
    zhuLabel.hidden=NO;
    
	NSString *zhu = [dic objectForKey:@"ZhuShu"];
    if ([zhu intValue] == 1) {
        zhuLabel.text = [NSString stringWithFormat:@"单式%@注",zhu];
    }
    else {
        zhuLabel.text = [NSString stringWithFormat:@"复式%@注",zhu];
    }
	
	wanfaLabel.frame = CGRectMake(40, expectedSize.height, 100, 16);
	NSString *wanfa = [self nameForLottery:lotterytype];
    if (![dic objectForKey:@"lotterytype"]) {
        wanfa = [dic objectForKey:@"lottery"];
    }
    if ((lotterytype >= TYPE_11XUAN5_R2DaTuo && lotterytype <= TYPE_11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_GD11XUAN5_R2DaTuo && lotterytype <= TYPE_GD11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_JX11XUAN5_R2DaTuo && lotterytype <= TYPE_JX11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_HB11XUAN5_R2DaTuo && lotterytype <= TYPE_HB11XUAN5_Q3DaTuo) || (lotterytype >= TYPE_ShanXi11XUAN5_R2DaTuo && lotterytype <= TYPE_ShanXi11XUAN5_Q3DaTuo)) {
        zhuLabel.text = [NSString stringWithFormat:@"%@ %@注",wanfa,zhu];
    }
    else if (wanfa) {
        
        if ([zhu intValue] == 1) {
            zhuLabel.text = [NSString stringWithFormat:@"%@ 单式%@注",wanfa,zhu];
        }
        else {
            zhuLabel.text = [NSString stringWithFormat:@"%@ 复式%@注",wanfa,zhu];
        }
    }
    else {
        if ([zhu intValue] == 1) {
            zhuLabel.text = [NSString stringWithFormat:@"%@ 单式%@注",wanfa,zhu];
        }
        else {
            zhuLabel.text = [NSString stringWithFormat:@"%@ 复式%@注",wanfa,zhu];
        }
        
    }
//    zhuLabel.hidden = !shanchuBtn.hidden;

}

- (void)ShanChu{
	[shiyixuanwuCellDelegate deleteCell:self];
}


//- (void)changeShanChu:(UIButton *)send {
//	send.selected = !send.selected;
//	shanchuBtn.hidden = !send.selected;
//    zhuLabel.hidden = !shanchuBtn.hidden;
//    
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.2];
//    [UIView setAnimationDelegate:self];
//    if(shanchuButton.frame.origin.x == 320)
//    {
//        shanchuButton.frame=CGRectMake(320-65, 0, 65, backImage.frame.size.height);
//    }
//    else
//    {
//        shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
//    }
//    [UIView commitAnimations];
//    
//}

- (void)dealloc {
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
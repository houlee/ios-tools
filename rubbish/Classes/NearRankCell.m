//
//  NearRankCell.m
//  caibo
//
//  Created by yao on 12-5-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "NearRankCell.h"


@implementation NearRankCell
@synthesize isLanQiu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		
		nameLabel = [[UILabel alloc] init];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.font = [UIFont systemFontOfSize:15];
		nameLabel.textAlignment = NSTextAlignmentCenter;
		nameLabel.frame = CGRectMake(0, 0, 60, 30);
		[self.contentView addSubview:nameLabel];
		
		saiLabel = [[UILabel alloc] init];
        saiLabel.backgroundColor = [UIColor clearColor];
		saiLabel.font = [UIFont systemFontOfSize:15];
		saiLabel.textAlignment = NSTextAlignmentCenter;
		saiLabel.frame = CGRectMake(60, 0, 30, 30);
		[self.contentView addSubview:saiLabel];
		
		shengLabel = [[UILabel alloc] init];
		shengLabel.backgroundColor = [UIColor clearColor];
		shengLabel.font = [UIFont systemFontOfSize:15];
		shengLabel.textAlignment = NSTextAlignmentCenter;
		shengLabel.frame = CGRectMake(90, 0, 30, 30);
		[self.contentView addSubview:shengLabel];
		
		pingLabel = [[UILabel alloc] init];
        pingLabel.backgroundColor = [UIColor clearColor];
		pingLabel.font = [UIFont systemFontOfSize:15];
		pingLabel.textAlignment = NSTextAlignmentCenter;
		pingLabel.frame = CGRectMake(120, 0, 30, 30);
		[self.contentView addSubview:pingLabel];
		
		fuLabel	= [[UILabel alloc] init];
		fuLabel.backgroundColor = [UIColor clearColor];
		fuLabel.font = [UIFont systemFontOfSize:15];
		fuLabel.textAlignment = NSTextAlignmentCenter;
		fuLabel.frame = CGRectMake(150, 0, 30, 30);
		[self.contentView addSubview:fuLabel];
		
		shengPerLabel = [[UILabel alloc] init];
        shengPerLabel.backgroundColor = [UIColor clearColor];
		shengPerLabel.font = [UIFont systemFontOfSize:15];
		shengPerLabel.textAlignment = NSTextAlignmentCenter;
		shengPerLabel.frame = CGRectMake(180, 0, 47, 30);
		[self.contentView addSubview:shengPerLabel];
		
		rankLabel = [[UILabel alloc] init];
		rankLabel.backgroundColor = [UIColor clearColor];
		rankLabel.font = [UIFont systemFontOfSize:15];
		rankLabel.textAlignment = NSTextAlignmentCenter;
		rankLabel.frame = CGRectMake(227, 0, 47, 30);
		[self.contentView addSubview:rankLabel];
		
		scoreLabel = [[UILabel alloc] init];
        scoreLabel.backgroundColor = [UIColor clearColor];
		scoreLabel.font = [UIFont systemFontOfSize:15];
		scoreLabel.textAlignment = NSTextAlignmentCenter;
		scoreLabel.frame = CGRectMake(274, 0, 47, 30);
		[self.contentView addSubview:scoreLabel];
		
		UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, 320, 1)];
		[self.contentView addSubview:imageV];
        imageV.tag = 111;
		imageV.backgroundColor = [UIColor lightGrayColor];
		[imageV release];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
        isLanQiu = NO;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)LoadData:(NSDictionary *)dic WithName:(NSString *)name isTitle:(BOOL)istitle {
    if (isLanQiu) {
        UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag:111];
        imageV.hidden = YES;
        imageV.backgroundColor = [UIColor clearColor];
        imageV.image = UIImageGetImageFromName(@"yucexuxian.png");
        nameLabel.text = nil;
        saiLabel.text = nil;
        shengLabel.text = nil;
        pingLabel.text = nil;
        fuLabel.text = nil;
        shengPerLabel.text = nil;
        rankLabel.text = nil;
        scoreLabel.text = nil;
        if (!jingLabel) {
            jingLabel = [[UILabel alloc] init];
            jingLabel.backgroundColor = [UIColor clearColor];
            jingLabel.font = [UIFont systemFontOfSize:15];
            jingLabel.textAlignment = NSTextAlignmentCenter;
            jingLabel.frame = CGRectMake(227, 0, 47, 30);
            [self.contentView addSubview:jingLabel];
            [jingLabel release];
        }
        nameLabel.frame = CGRectMake(0, 0, 48, 30);
        saiLabel.frame = CGRectMake(48, 0, 30, 30);
        shengLabel.frame = CGRectMake(78, 0, 30, 30);
        fuLabel.frame = CGRectMake(108, 0, 30, 30);
        scoreLabel.frame = CGRectMake(138, 0, 38, 30);
        pingLabel.frame = CGRectMake(176, 0, 38, 30);
        jingLabel.frame = CGRectMake(214, 0, 38, 30);
        rankLabel.frame = CGRectMake(252, 0, 30, 30);
        shengPerLabel.frame = CGRectMake(282, 0, 38, 30);
        
        nameLabel.font = [UIFont systemFontOfSize:12];
        saiLabel.font = [UIFont systemFontOfSize:12];
        shengLabel.font = [UIFont systemFontOfSize:12];
        fuLabel.font = [UIFont systemFontOfSize:12];
        shengPerLabel.font = [UIFont systemFontOfSize:12];
        scoreLabel.font = [UIFont systemFontOfSize:12];
        pingLabel.font = [UIFont systemFontOfSize:12];
        jingLabel.font = [UIFont systemFontOfSize:12];
        rankLabel.font = [UIFont systemFontOfSize:12];
        
        nameLabel.text = name;
        saiLabel.text = [dic objectForKey:@"total_count"];
        shengLabel.text = [dic objectForKey:@"win_count"];
        fuLabel.text = [dic objectForKey:@"lost_count"];
        scoreLabel.text = [dic objectForKey:@"avg_get"];
        pingLabel.text = [dic objectForKey:@"avg_lose"];
        jingLabel.text = [dic objectForKey:@"net_points"];
        rankLabel.text = [dic objectForKey:@"order"];
        if ([[dic objectForKey:@"win_rate"] length]) {
            shengPerLabel.text = [NSString stringWithFormat:@"%.0f%%",[[dic objectForKey:@"win_rate"] floatValue] * 100];
        }

        if (name && istitle) {
            nameLabel.frame = CGRectMake(0, 0, 100, 30);
            nameLabel.font = [UIFont boldSystemFontOfSize:16];
            self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceqiudui.png")];
        }
        else if (istitle) {
            self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceriqi.png")];
            saiLabel.text = @"赛";
            shengLabel.text = @"胜";
            fuLabel.text = @"负";
            scoreLabel.text = @"得";
            pingLabel.text = @"失";
            jingLabel.text = @"净";
            rankLabel.text = @"排名";
            shengPerLabel.text = @"胜率";
        }
        else {
            if (![name isEqualToString:@"近10"]) {
                imageV.hidden = NO;
            }
            self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucebifen.png")];
            
        }
    }
    else {
        if (istitle) {
            self.contentView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
            nameLabel.text = name;
            nameLabel.textColor = [UIColor colorWithRed:113/255.0 green:42/255.0 blue:0 alpha:1.0];
            
            saiLabel.text = @"赛";
            saiLabel.backgroundColor = [UIColor colorWithRed:149/255.0 green:192/255.0 blue:195/255.0 alpha:1.0];
            saiLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            shengLabel.text = @"胜";
            shengLabel.textColor =[UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            pingLabel.text = @"平";
            pingLabel.backgroundColor = [UIColor colorWithRed:149/255.0 green:192/255.0 blue:195/255.0 alpha:1.0];
            pingLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            fuLabel.text = @"负";
            fuLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            shengPerLabel.text = @"胜率";
            shengPerLabel.backgroundColor = [UIColor colorWithRed:149/255.0 green:192/255.0 blue:195/255.0 alpha:1.0];
            shengPerLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            rankLabel.text = @"排名";
            rankLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
            
            scoreLabel.text = @"得分";
            scoreLabel.backgroundColor = [UIColor colorWithRed:149/255.0 green:192/255.0 blue:195/255.0 alpha:1.0];
            scoreLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
        }
        else {
            self.contentView.backgroundColor = [UIColor whiteColor];
            nameLabel.text = name;
            nameLabel.textColor = [UIColor blackColor];
            if ([dic count]) {
                saiLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"all"]];
                shengLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sheng"]];
                pingLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ping"]];
                fuLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fu"]];
                shengPerLabel.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"win_per"]];
                rankLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"i"]];
                scoreLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jifen"]];
            }
            else {
                saiLabel.text = nil;
                shengLabel.text = nil;
                pingLabel.text = nil;
                fuLabel.text = nil;
                shengPerLabel.text = nil;
                rankLabel.text = nil;
                scoreLabel.text = nil;
            }
            
            
            saiLabel.textColor = [UIColor blackColor];
            saiLabel.backgroundColor = [UIColor colorWithRed:225/255.0 green:237/255.0 blue:243/255.0 alpha:1.0];
            
            
            shengLabel.textColor =[UIColor blackColor];
            
            
            pingLabel.textColor = [UIColor blackColor];
            pingLabel.backgroundColor = [UIColor colorWithRed:225/255.0 green:237/255.0 blue:243/255.0 alpha:1.0];
            
            
            fuLabel.textColor = [UIColor blackColor];
            
            
            shengPerLabel.textColor = [UIColor blackColor];
            shengPerLabel.backgroundColor = [UIColor colorWithRed:225/255.0 green:237/255.0 blue:243/255.0 alpha:1.0];
            
            
            rankLabel.textColor = [UIColor blackColor];
            
            
            scoreLabel.textColor = [UIColor blackColor];
            scoreLabel.backgroundColor = [UIColor colorWithRed:225/255.0 green:237/255.0 blue:243/255.0 alpha:1.0];
        }
    }

}


- (void)dealloc {
	[nameLabel release];
	[saiLabel release];
	[shengLabel release];
	[pingLabel release];
	[fuLabel release];
	[shengPerLabel release];
	[rankLabel release];
	[scoreLabel release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
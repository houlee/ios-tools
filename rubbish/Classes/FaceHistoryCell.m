//
//  FaceHistoryCell.m
//  caibo
//
//  Created by yao on 12-5-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "FaceHistoryCell.h"


@implementation FaceHistoryCell
@synthesize isLanqiu,isZongjie;
@synthesize hostName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
		timeLabel.backgroundColor = [UIColor clearColor];
		
		timeLabel.textAlignment = NSTextAlignmentRight;
		timeLabel.font = [UIFont systemFontOfSize:12];
		
		HnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 5, 70, 20)];
		HnameLabel.backgroundColor = [UIColor clearColor];
		
		HnameLabel.textAlignment = NSTextAlignmentCenter;
		HnameLabel.font = [UIFont systemFontOfSize:12];
		
		scLabel = [[UILabel alloc] initWithFrame:CGRectMake(185, 5, 50, 20)];
		scLabel.backgroundColor = [UIColor clearColor];
		scLabel.textAlignment = NSTextAlignmentCenter;
		scLabel.font = [UIFont systemFontOfSize:12];
		
		GnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 5, 75, 20)];
		GnameLabel.backgroundColor = [UIColor clearColor];
		
		GnameLabel.textAlignment = NSTextAlignmentCenter;
		GnameLabel.font = [UIFont systemFontOfSize:12];
		
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 20)];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.textColor = [UIColor colorWithRed:113/255.0 green:42/255.0 blue:0 alpha:1.0];
		nameLabel.textAlignment = NSTextAlignmentLeft;
		nameLabel.font = [UIFont systemFontOfSize:12];
		nameLabel.hidden = YES;
		[self.contentView addSubview:timeLabel];
		[self.contentView addSubview:HnameLabel];
		[self.contentView addSubview:scLabel];
		[self.contentView addSubview:GnameLabel];
		[self.contentView addSubview:nameLabel];
		[timeLabel release];
		[HnameLabel release];
		[scLabel release];
		[GnameLabel release];
		[nameLabel release];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)LoadData:(NSDictionary *)dic withName:(NSString *)name withType:(FaceHistoryCellType)type {
    if (isLanqiu) {
        if (!rangLabel) {
            rangLabel = [[UILabel alloc] init];
            rangLabel.backgroundColor = [UIColor clearColor];
            rangLabel.textColor = [UIColor blackColor];
            rangLabel.textAlignment = NSTextAlignmentCenter;
            rangLabel.font = [UIFont systemFontOfSize:12];
            [self.contentView addSubview:rangLabel];
            [rangLabel release];
        }
        nameLabel.hidden = NO;
        zongjieLabel.hidden = YES;
        nameLabel.text = nil;
        timeLabel.text = nil;
        HnameLabel.text = nil;//主队名称
        GnameLabel.text = nil;//客队名称；
        scLabel.text = nil;//比分；
        rangLabel.text = nil;//让分
        nameLabel.textColor = [UIColor blackColor];
        GnameLabel.textColor = [UIColor blackColor];
        HnameLabel.textColor = [UIColor blackColor];
        scLabel.textColor = [UIColor blackColor];
        timeLabel.textColor = [UIColor blackColor];
        rangLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        GnameLabel.textAlignment = NSTextAlignmentCenter;
        HnameLabel.textAlignment = NSTextAlignmentCenter;
        scLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        rangLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.frame = CGRectMake(5, 0, 55, 30);
        nameLabel.frame = CGRectMake(55, 0, 53, 30);
        HnameLabel.frame = CGRectMake(108, 0, 53, 30);
        scLabel.frame = CGRectMake(161, 0, 53, 30);
        GnameLabel.frame = CGRectMake(214, 0, 53, 30);
        rangLabel.frame = CGRectMake(267, 0, 53, 30);
        nameLabel.font = [UIFont systemFontOfSize:12];
        HnameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        GnameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        UIView *shuxian = (UIView *)[self.contentView viewWithTag:211];
        if (shuxian) {
            for (int i = 0; i < 5; i ++) {
                UIView *shuxian1 = (UIView *)[self.contentView viewWithTag:211+i];
                shuxian1.hidden = YES;
            }
        }
        else {
            if (type == FaceHistoryCellTypeFuture) {
                for (int i = 0; i < 5; i ++) {
                    UIView *v1 = [[UIView alloc] init];
                    [self.contentView addSubview:v1];
                    v1.tag = 211 + i;
                    v1.frame = CGRectMake(55 + 53*i, 10, 1, 10);
                    v1.backgroundColor = [UIColor blackColor];
                    v1.hidden = YES;
                    [v1 release];
                }
            }
            else {
                for (int i = 0; i < 3; i ++) {
                    UIView *v1 = [[UIView alloc] init];
                    [self.contentView addSubview:v1];
                    v1.tag = 211 + i;
                    v1.frame = CGRectMake(55 + 53*i, 10, 1, 10);
                    if (i == 3) {
                        v1.frame = CGRectMake( 228, 10, 1, 10);
                    }
                    v1.backgroundColor = [UIColor blackColor];
                    v1.hidden = YES;
                    [v1 release];
                }
            }
            
        }
        switch (type) {
            case FaceHistoryCellTypeNear://近期战绩
            {
                if (dic) {
                    self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucebifen.png")];
                    if (isZongjie) {
                        if (!zongjieLabel) {
                            zongjieLabel = [[ColorView alloc] initWithFrame:CGRectMake(35, 8, 250, 14)];
                            zongjieLabel.backgroundColor = [UIColor clearColor];
                            zongjieLabel.font = [UIFont systemFontOfSize:12];
                            [self.contentView addSubview:zongjieLabel];
                            [zongjieLabel release];
                        }
                        int a = (int)[[dic objectForKey:@"win"] integerValue];
                        int b = (int)[[dic objectForKey:@"lost"] integerValue];
                        float c = [[dic objectForKey:@"rate"] floatValue];
                        if (a + b > 0) {
                            zongjieLabel.hidden = NO;
                            zongjieLabel.text = [NSString stringWithFormat:@"共%d场 %@胜<%d>场 负%d场 胜率<%.0f>%%",a + b, name,a, b , c * 100];
                        }
                        else {
                            zongjieLabel.hidden = YES;
                        }

                    }
                    else {
                        HnameLabel.text = [dic objectForKey:@"host_name"];
                        GnameLabel.text = [dic objectForKey:@"guest_name"];
                        scLabel.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"host_score"],[dic objectForKey:@"guest_score"]];
                        rangLabel.text = [dic objectForKey:@"handicap"];
                        nameLabel.text = [dic objectForKey:@"league_name"];
                        NSArray *array = [[dic objectForKey:@"match_time"] componentsSeparatedByString:@" "];
                        if ([array count]>0) {
                            timeLabel.text = [array objectAtIndex:0];
                            if ([timeLabel.text length] > 2) {
                                timeLabel.text = [timeLabel.text substringFromIndex:2];
                            }
                        }
                        else {
                            timeLabel.text = nil;
                        }
                        
                        if ([[dic objectForKey:@"result"] intValue] == 3) {
                            if ([self.hostName isEqualToString:[dic objectForKey:@"host_name"]]) {
                                HnameLabel.textColor = [UIColor redColor];
                            }
                            else {
                                GnameLabel.textColor = [UIColor redColor];
                            }
                            
                        }
                        else {
                            if ([self.hostName isEqualToString:[dic objectForKey:@"host_name"]]) {
                                HnameLabel.textColor = [UIColor greenColor];
                            }
                            else {
                                GnameLabel.textColor = [UIColor greenColor];
                            }
                            
                        }
                        if ([rangLabel.text floatValue] > 0) {
                            rangLabel.textColor = [UIColor redColor];
                        }
                        else {
                            rangLabel.textColor = [UIColor greenColor];
                        }
                        if ([HnameLabel.text length] >4) {
                            HnameLabel.text = [HnameLabel.text substringToIndex:4];
                        }
                        if ([GnameLabel.text length] >4) {
                            GnameLabel.text = [GnameLabel.text substringToIndex:4];
                        }
                        if ([nameLabel.text length] >4) {
                            nameLabel.text = [nameLabel.text substringToIndex:4];
                        }
                    }
                }
                else {
                    if (name) {
                        self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceqiudui.png")];
                        nameLabel.text = name;
                        nameLabel.font = [UIFont systemFontOfSize:15];
                        nameLabel.frame = CGRectMake(17, 0, 100, 30);
                        nameLabel.textAlignment = NSTextAlignmentLeft;
                    }
                    else {
                        self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceriqi.png")];
                        timeLabel.text = @"日期";
                        HnameLabel.text = @"主队";
                        GnameLabel.text = @"客队";
                        scLabel.text = @"比分";
                        nameLabel.text = @"赛事";
                        rangLabel.text = @"让分";
                        for (int i = 0; i < 5; i ++) {
                            UIView *shuxian1 = (UIView *)[self.contentView viewWithTag:211+i];
                            shuxian1.hidden = YES;
                        }
                    }

                }
                
            }
                break;
            case FaceHistoryCellTypeFace:
            {
                
                if (dic) {
                    self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucebifen.png")];
                    if (isZongjie) {
                        if (!zongjieLabel) {
                            zongjieLabel = [[ColorView alloc] initWithFrame:CGRectMake(35, 8, 250, 14)];
                            zongjieLabel.backgroundColor = [UIColor clearColor];
                            zongjieLabel.font = [UIFont systemFontOfSize:12];
                            [self.contentView addSubview:zongjieLabel];
                            [zongjieLabel release];
                        }
                        int a = (int)[[dic objectForKey:@"win"] integerValue];
                        int b = (int)[[dic objectForKey:@"lost"] integerValue];
                        float c = [[dic objectForKey:@"rate"] floatValue];
                        if (a + b > 0) {
                            zongjieLabel.hidden = NO;
                            zongjieLabel.text = [NSString stringWithFormat:@"共%d场 %@胜<%d>场 负%d场 胜率<%.0f>%%",a + b, name,a, b , c * 100];
                        }
                        else {
                            zongjieLabel.hidden = YES;
                        }
                        
                    }
                    else {
                        HnameLabel.text = [dic objectForKey:@"host_name"];
                        GnameLabel.text = [dic objectForKey:@"guest_name"];
                        scLabel.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"host_score"],[dic objectForKey:@"guest_score"]];
                        rangLabel.text = [dic objectForKey:@"handicap"];
                        nameLabel.text = [dic objectForKey:@"league_name"];
                        NSArray *array = [[dic objectForKey:@"match_time"] componentsSeparatedByString:@" "];
                        if ([array count]>0) {
                            timeLabel.text = [array objectAtIndex:0];
                            if ([timeLabel.text length] > 2) {
                                timeLabel.text = [timeLabel.text substringFromIndex:2];
                            }
                        }
                        else {
                            timeLabel.text = nil;
                        }
                        
                        if ([[dic objectForKey:@"result"] intValue] == 3) {
                            if ([self.hostName isEqualToString:[dic objectForKey:@"host_name"]]) {
                                HnameLabel.textColor = [UIColor redColor];
                            }
                            else {
                                GnameLabel.textColor = [UIColor redColor];
                            }
                            
                        }
                        else {
                            if ([self.hostName isEqualToString:[dic objectForKey:@"host_name"]]) {
                                HnameLabel.textColor = [UIColor greenColor];
                            }
                            else {
                                GnameLabel.textColor = [UIColor greenColor];
                            }
                            
                        }
                        if ([rangLabel.text floatValue] > 0) {
                            rangLabel.textColor = [UIColor redColor];
                        }
                        else {
                            rangLabel.textColor = [UIColor greenColor];
                        }
                        if ([HnameLabel.text length] >4) {
                            HnameLabel.text = [HnameLabel.text substringToIndex:4];
                        }
                        if ([GnameLabel.text length] >4) {
                            GnameLabel.text = [GnameLabel.text substringToIndex:4];
                        }
                        if ([nameLabel.text length] >4) {
                            nameLabel.text = [nameLabel.text substringToIndex:4];
                        }
                    }
                }
                else {
                        self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceriqi.png")];
                        timeLabel.text = @"日期";
                        HnameLabel.text = @"主队";
                        GnameLabel.text = @"客队";
                        scLabel.text = @"比分";
                        nameLabel.text = @"赛事";
                        rangLabel.text = @"让分";
                        for (int i = 0; i < 5; i ++) {
                            UIView *shuxian1 = (UIView *)[self.contentView viewWithTag:211+i];
                            shuxian1.hidden = YES;
                        }
                    }
            }
                break;
            case FaceHistoryCellTypeFuture: {
                HnameLabel.textAlignment = NSTextAlignmentRight;
                GnameLabel.textAlignment = NSTextAlignmentLeft;
                HnameLabel.frame = CGRectMake(108, 0, 50, 30);
                scLabel.frame = CGRectMake(158, 0, 20, 30);
                scLabel.text = @"VS";
                GnameLabel.frame = CGRectMake(178, 0, 50, 30);
                rangLabel.frame = CGRectMake(220, 0, 100, 30);
                if (dic) {
                    self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucebifen.png")];
                   rangLabel.text = [dic objectForKey:@"jiange"];
                    nameLabel.text = [dic objectForKey:@"league_name"];
                    NSString *host = [dic objectForKey:@"host_name"];
                    NSString *guet = [dic objectForKey:@"guest_name"];
                    if ([host length] > 4) {
                        host = [host substringToIndex:4];
                    }
                    if ([guet length] > 4) {
                        guet = [guet substringToIndex:4];
                    }
                    HnameLabel.text = host;
                    GnameLabel.text = guet;
                    if ([host isEqualToString:name]) {
                        HnameLabel.textColor = [UIColor redColor];
                    }
                    else {
                        HnameLabel.textColor = [UIColor blackColor];
                    }
                    if ([guet isEqualToString:name]) {
                        GnameLabel.textColor = [UIColor redColor];
                    }
                    else {
                        GnameLabel.textColor = [UIColor blackColor];
                    }
                    
                    NSArray *array = [[dic objectForKey:@"match_time"] componentsSeparatedByString:@" "];
                    if ([array count]>0) {
                        timeLabel.text = [array objectAtIndex:0];
                        if ([timeLabel.text length] > 2) {
                            timeLabel.text = [timeLabel.text substringFromIndex:2];
                        }
                    }
                    else {
                        timeLabel.text = nil;
                    }
                }
                else {
                    scLabel.text = nil;
                    HnameLabel.textAlignment = NSTextAlignmentCenter;
                    GnameLabel.textAlignment = NSTextAlignmentCenter;
                    HnameLabel.textColor = [UIColor blackColor];
                    GnameLabel.textColor = [UIColor blackColor];
                    if (name) {
                        self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceqiudui.png")];
                        nameLabel.text = name;
                        nameLabel.font = [UIFont systemFontOfSize:15];
                        nameLabel.frame = CGRectMake(17, 0, 100, 30);
                        nameLabel.textAlignment = NSTextAlignmentLeft;
                    }
                    else {
                        HnameLabel.frame = CGRectMake(108, 0, 120, 30);
                        GnameLabel.frame = CGRectMake(228, 0, 92, 30);
                        self.contentView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceriqi.png")];
                        timeLabel.text = @"日期";
                        HnameLabel.text = @"对阵";
                        GnameLabel.text = @"相隔";
                        nameLabel.text = @"赛事";
                        for (int i = 0; i < 5; i ++) {
                            UIView *shuxian1 = (UIView *)[self.contentView viewWithTag:211+i];
                            shuxian1.hidden = YES;
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
        
    }
    else {
        switch (type) {
            case FaceHistoryCellTypeFace:
            {
                
                
                if (dic) {
                    HnameLabel.text = [dic objectForKey:@"hostname"];
                    GnameLabel.text = [dic objectForKey:@"guestname"];
                    scLabel.text = [dic objectForKey:@"score"];
                    NSArray *array = [[dic objectForKey:@"playtime"] componentsSeparatedByString:@" "];
                    if ([array count]>0) {
                        timeLabel.text = [array objectAtIndex:0];
                    }
                    else {
                        timeLabel.text = nil;
                    }
                    GnameLabel.textColor = [UIColor blackColor];
                    HnameLabel.textColor = [UIColor blackColor];
                    scLabel.textColor = [UIColor redColor];
                    timeLabel.textColor = [UIColor blackColor];
                    timeLabel.frame = CGRectMake(0, 0, 100, 20);
                    if ([[dic objectForKey:@"result"] isEqualToString:@"胜"]) {
                        self.contentView.backgroundColor = [UIColor colorWithRed:248/255.0 green:218/255.0 blue:220/255.0 alpha:1];
                    }
                    else if([[dic objectForKey:@"result"] isEqualToString:@"负"]) {
                        self.contentView.backgroundColor = [UIColor colorWithRed:217/255.0 green:238/255.0 blue:205/255.0 alpha:1];
                    }
                    else {
                        self.contentView.backgroundColor = [UIColor whiteColor];
                    }
                    
                    
                }
                else {
                    timeLabel.text = @"时间";
                    timeLabel.textAlignment = NSTextAlignmentCenter;
                    HnameLabel.text = @"主队";
                    GnameLabel.text = @"客队";
                    scLabel.text = @"比分";
                    timeLabel.frame = CGRectMake(20, 5, 60, 20);
                    scLabel.textColor = [UIColor redColor];
                    GnameLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    HnameLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    scLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    timeLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                }
                timeLabel.textAlignment = NSTextAlignmentCenter;
                nameLabel.hidden = YES;
                
            }
                break;
            case FaceHistoryCellTypeNear:
            {
                
                if (dic) {
                    HnameLabel.text = [dic objectForKey:@"hostname"];
                    GnameLabel.text = [dic objectForKey:@"guestname"];
                    scLabel.text = [dic objectForKey:@"score"];
                    NSArray *array = [[dic objectForKey:@"playtime"] componentsSeparatedByString:@" "];
                    if ([array count]>0) {
                        timeLabel.text = [array objectAtIndex:0];
                    }
                    else {
                        timeLabel.text = nil;
                    }
                    if ([[dic objectForKey:@"result"] isEqualToString:@"胜"]) {
                        self.contentView.backgroundColor = [UIColor colorWithRed:248/255.0 green:218/255.0 blue:220/255.0 alpha:1];
                    }
                    else if([[dic objectForKey:@"result"] isEqualToString:@"负"]) {
                        self.contentView.backgroundColor = [UIColor colorWithRed:217/255.0 green:238/255.0 blue:205/255.0 alpha:1];
                    }
                    else {
                        self.contentView.backgroundColor = [UIColor whiteColor];
                    }
                    timeLabel.frame = CGRectMake(35, 5, 80, 20);
                    
                    GnameLabel.textColor = [UIColor blackColor];
                    HnameLabel.textColor = [UIColor blackColor];
                    scLabel.textColor = [UIColor redColor];
                    timeLabel.textColor = [UIColor blackColor];
                    nameLabel.hidden = YES;
                    timeLabel.textAlignment = NSTextAlignmentCenter;
                }
                else {
                    timeLabel.text = @"时间";
                    HnameLabel.text = @"主队";
                    GnameLabel.text = @"客队";
                    scLabel.text = @"比分";
                    nameLabel.text = name;
                    nameLabel.hidden = NO;
                    timeLabel.frame = CGRectMake(0, 5, 100, 20);
                    timeLabel.textAlignment = NSTextAlignmentRight;
                    GnameLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    HnameLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    scLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                    timeLabel.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
                }
                
                
            }
                break;
            default:
                break;
        }
    }
	
}


- (void)dealloc {
    self.hostName = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
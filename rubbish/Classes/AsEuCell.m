//
//  AsEuCell.m
//  caibo
//
//  Created by yao on 12-5-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "AsEuCell.h"


@implementation AsEuCell
@synthesize isLanQiu,isOuPei,isBafangYuceLanqiu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        isLanQiu = NO;
        isOuPei = NO;
        backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 33)];
        [self.contentView addSubview:backImageV];
        backImageV.hidden = YES;
        [backImageV release];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
		nameLabel = [[UILabel alloc] init];
		nameLabel.frame = CGRectMake(5, 0, 70, 33);
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.font = [UIFont systemFontOfSize:12];
		nameLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:nameLabel];
		
		nowWinLabel = [[UILabel alloc] init];
		nowWinLabel.frame = CGRectMake(70, 0, 40, 0);
		nowWinLabel.backgroundColor = [UIColor clearColor];
		nowWinLabel.font = [UIFont systemFontOfSize:12];
		nowWinLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:nowWinLabel];
		
		nowPingLabel = [[UILabel alloc] init];
		nowPingLabel.frame = CGRectMake(110, 0, 45, 33);
		nowPingLabel.backgroundColor = [UIColor clearColor];
		nowPingLabel.font = [UIFont systemFontOfSize:12];
		nowPingLabel.numberOfLines = 0;
		nowPingLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		nowPingLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:nowPingLabel];
		
		nowLostLabel = [[UILabel alloc] init];
		nowLostLabel.frame = CGRectMake(155, 0, 40, 33);
		nowLostLabel.backgroundColor = [UIColor clearColor];
		nowLostLabel.font = [UIFont systemFontOfSize:12];
		nowLostLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:nowLostLabel];
		
		beginWinLabel = [[UILabel alloc] init];
		beginWinLabel.frame = CGRectMake(195, 0, 40, 33);
		beginWinLabel.backgroundColor = [UIColor clearColor];
		beginWinLabel.font = [UIFont systemFontOfSize:12];
		beginWinLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:beginWinLabel];
		
		beginPingLabel = [[UILabel alloc] init];
		
		beginPingLabel.backgroundColor = [UIColor clearColor];
		beginPingLabel.font = [UIFont systemFontOfSize:12];
		beginPingLabel.frame = CGRectMake(235, 0, 45, 33);
		beginPingLabel.numberOfLines = 0;
		beginPingLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		beginPingLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:beginPingLabel];
		
		beginLostLabel = [[UILabel alloc] init];
		beginLostLabel.frame = CGRectMake(280, 0, 40, 33);
		beginLostLabel.backgroundColor = [UIColor clearColor];
		beginLostLabel.font = [UIFont systemFontOfSize:12];
		beginLostLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:beginLostLabel];
		
		imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, 1, 33)];
		imageV1.backgroundColor = [UIColor lightGrayColor];
		[self.contentView addSubview:imageV1];
		
		imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(195, 0, 1, 33)];
		imageV2.backgroundColor = [UIColor lightGrayColor];
		[self.contentView addSubview:imageV2];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (NSString *)changeCIdToName:(NSString *)cid {
    if ([cid isEqualToString:@"0"]) {
        return @"平均";
        
    }
    else if ([cid isEqualToString:@"214"]) {
        return @"bet365";
    }
    else if ([cid isEqualToString:@"265"]) {
        return @"澳门";
    }
    else if ([cid isEqualToString:@"212"]) {
        return @"Fonbet";
    }
    else if ([cid isEqualToString:@"222"]) {
        return @"Miseojeu";
    }
    else if ([cid isEqualToString:@"82"]) {
        return @"韦德";
    }
    else if ([cid isEqualToString:@"8"]) {
        return @"bet365";
    }
    else if ([cid isEqualToString:@"2"]) {
        return @"易胜博";
    }
    else if ([cid isEqualToString:@"9"]) {
        return @"韦德";
    }
    else if ([cid isEqualToString:@"1"]) {
        return @"澳门";
    }
    else if ([cid isEqualToString:@"3"]) {
        return @"皇冠";
    }
    else if ([cid isEqualToString:@"8_change"]) {
        return @"bet365变盘";
    }
    else if ([cid isEqualToString:@"2_change"]) {
        return @"易胜博变盘";
    }
    else if ([cid isEqualToString:@"9_change"]) {
        return @"韦德变盘";
    }
    else if ([cid isEqualToString:@"1_change"]) {
        return @"澳门变盘";
    }
    else if ([cid isEqualToString:@"3_change"]) {
        return @"皇冠变盘";
    }
    return @"";
}

- (void)LoadBianHuaData:(NSArray *)array isTitle:(BOOL)istitile CId:(NSString *)cid isFoot:(BOOL)isFoot {
    nameLabel.text = @"";
    nowWinLabel.text = @"";
    nowPingLabel.text = @"";
    nowLostLabel.text = @"";
    beginWinLabel.text = @"";
    beginPingLabel.text = @"";
    beginLostLabel.text = @"";
    imageV1.hidden = NO;
    imageV2.hidden = NO;
    
    if (!imageV4) {
        imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 300, 1)];
        imageV4.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:imageV4];
    }
    if (isLanQiu) {
        backImageV.hidden = NO;
        imageV1.hidden = YES;
        imageV2.hidden = YES;
        imageV3.hidden = YES;
        imageV4.backgroundColor = [UIColor clearColor];
        imageV4.image = UIImageGetImageFromName(@"yucexuxian.png");
        imageV1.image = nil;
        imageV1.backgroundColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        backImageV.frame = CGRectMake(0, 0, 320, 50);
        backImageV.image = UIImageGetImageFromName(@"yucebifen.png");
        if (istitile) {
            imageV4.hidden = YES;
            backImageV.frame = CGRectMake(0, 0, 320, 33);
            backImageV.image = UIImageGetImageFromName(@"yuceriqi.png");
            imageV2.hidden = YES;
            nameLabel.frame = CGRectMake(0, 1, 80, 33);
            nowWinLabel.frame = CGRectMake(80, 1, 240, 33);
            imageV1.frame = CGRectMake(75, 0, 1, 33);
            nowPingLabel.hidden = YES;
            nowLostLabel.hidden = YES;
            beginLostLabel.hidden = YES;
            
            nameLabel.text = @"公司";
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nowWinLabel.text = @"赔率变化";
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            
        }
        else {
            imageV4.hidden = NO;
            nowPingLabel.hidden = NO;
            nowLostLabel.hidden = NO;
            beginLostLabel.hidden = NO;
                imageV4.frame = CGRectMake(0, 49, 320, 1);
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nameLabel.text = [self changeCIdToName:cid];
            nameLabel.frame = CGRectMake(0, 0, 80, 50);
            nowWinLabel.frame = CGRectMake(80, 0, 50, 50);
            nowPingLabel.frame = CGRectMake(130, 0, 50, 50);
            beginWinLabel.frame = CGRectMake(180, 0, 50, 50);
            beginPingLabel.frame = CGRectMake(230, 0, 90, 50);
            
            if ([array count] >= 3) {
                nowWinLabel.text = [array objectAtIndex:0];
                nowPingLabel.text = [array objectAtIndex:1];
                if (isOuPei) {
                    nowWinLabel.frame = CGRectMake(75, 0, 72, 50);
                    nowPingLabel.frame = CGRectMake(147, 0, 73, 50);
                    nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                }
                else {
                    nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                }
                
                if ([array count] >= 4) {
                    beginWinLabel.text = [array objectAtIndex:2];
                    beginPingLabel.text = [array objectAtIndex:3];
                }
                else {
                    beginPingLabel.text = [array objectAtIndex:2];
                    
                }
                
                nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                if (isOuPei) {
                    nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                }
                else {
                    nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                }
                
                beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            }
            
        }
    }
    else {
        if (istitile) {
            imageV2.hidden = YES;
            imageV4.frame = CGRectMake(10, 32, 300, 1);
            nameLabel.frame = CGRectMake(10, 1, 65, 33);
            nowWinLabel.frame = CGRectMake(75, 1, 235, 33);
            imageV1.frame = CGRectMake(75, 0, 1, 33);
            backImageV.hidden = NO;
            backImageV.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
            nowPingLabel.hidden = YES;
            nowLostLabel.hidden = YES;
            beginLostLabel.hidden = YES;
            
            nameLabel.text = @"公司";
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nowWinLabel.text = @"赔率变化";
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            
        }
        else {
            
            backImageV.hidden = NO;
            nowPingLabel.hidden = NO;
            nowLostLabel.hidden = NO;
            beginLostLabel.hidden = NO;
            if ([cid length]) {
                imageV4.frame = CGRectMake(10, 32, 300, 1);
            }
            else {
                imageV4.frame = CGRectMake(75, 32, 235, 1);
            }
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nameLabel.text = [self changeCIdToName:cid];
            nameLabel.frame = CGRectMake(10, 0, 65, 33);
            nowWinLabel.frame = CGRectMake(75, 0, 48, 33);
            nowPingLabel.frame = CGRectMake(123, 0, 49, 33);
            beginWinLabel.frame = CGRectMake(172, 0, 48, 33);
            beginPingLabel.frame = CGRectMake(220, 0, 90, 33);
            
            imageV1.frame = CGRectMake(75, 0, 1, 33);
            imageV2.frame = CGRectMake(220, 0, 1, 33);
            if ([array count] >= 3) {
                nowWinLabel.text = [array objectAtIndex:0];
                nowPingLabel.text = [array objectAtIndex:1];
                if (isOuPei) {
                    nowWinLabel.frame = CGRectMake(75, 0, 72, 33);
                    nowPingLabel.frame = CGRectMake(147, 0, 73, 33);
                    nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                }
                else {
                    nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                }
                
                if ([array count] >= 4) {
                    beginWinLabel.text = [array objectAtIndex:2];
                    beginPingLabel.text = [array objectAtIndex:3];
                }
                else {
                    beginPingLabel.text = [array objectAtIndex:2];
                    
                }
                
                nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                if (isOuPei) {
                    nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                }
                else {
                    nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                }
                
                beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            }
            if (isFoot) {
                imageV4.hidden = YES;
                backImageV.image = [UIImageGetImageFromName(@"SZT-X-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                imageV1.frame = CGRectMake(imageV1.frame.origin.x, 0, 1, 31);
                imageV2.frame = CGRectMake(imageV2.frame.origin.x, 0, 1, 31);
            }
            else {
                imageV4.hidden = NO;
                backImageV.image = [UIImageGetImageFromName(@"SZT-Z-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
            }
            
        }
    }
    
}


- (void)LoadData:(NSArray *)array isTitle:(BOOL)istitile CId:(NSString *)cid isFoot:(BOOL) isFoot isBianHua:(BOOL )isbianhua {
    nameLabel.text = @"";
    nowWinLabel.text = @"";
    nowPingLabel.text = @"";
    nowLostLabel.text = @"";
    beginWinLabel.text = @"";
    beginPingLabel.text = @"";
    beginLostLabel.text = @"";
    if (isBafangYuceLanqiu) {
        imageV1.image = nil;
        imageV1.backgroundColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        backImageV.frame = CGRectMake(0, 0, 320, 50);
        backImageV.image = UIImageGetImageFromName(@"yucebifen.png");
        if (!imageV4) {
            imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
            imageV4.backgroundColor = [UIColor clearColor];
            imageV4.image = UIImageGetImageFromName(@"yucexuxian.png");
            [self.contentView addSubview:imageV4];
        }
        if (!imageV3) {
            imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
            imageV3.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:imageV3];
        }
        if (istitile) {
            imageV4.hidden = YES;
            backImageV.frame = CGRectMake(0, 0, 320, 33);
            backImageV.image = UIImageGetImageFromName(@"yuceriqi.png");
            if (isOuPei) {
                
//                nameLabel.frame = CGRectMake(0, 1, 70, 30);
//                nowWinLabel.frame = CGRectMake(70, 1, 108, 30);
//                beginWinLabel.frame = CGRectMake(178, 1,108, 30);
//                beginPingLabel.frame = CGRectMake(286, 1, 34, 30);
//                imageV1.frame = CGRectMake(75, 0, 1, 12);
//                imageV2.frame = CGRectMake(160, 0, 1, 12);
//                imageV3.frame = CGRectMake(245, 0, 1, 12);
                nameLabel.frame = CGRectMake(0, 1, 70, 30);
                nowWinLabel.frame = CGRectMake(70, 1, 108, 30);
                beginWinLabel.frame = CGRectMake(178, 1, 108, 30);
                beginPingLabel.frame = CGRectMake(286, 1, 34, 30);
                imageV1.frame = CGRectMake(70, 10, 1, 12);
                imageV1.backgroundColor = [UIColor blackColor];
                imageV2.frame = CGRectMake(177, 10, 1, 12);
                imageV2.backgroundColor = [UIColor blackColor];
                imageV3.frame = CGRectMake(286, 10, 1, 12);
                imageV3.backgroundColor = [UIColor blackColor];
            }
            else {
                nameLabel.frame = CGRectMake(0, 1, 70, 30);
                nowWinLabel.frame = CGRectMake(70, 1, 108, 30);
                beginWinLabel.frame = CGRectMake(178, 1, 108, 30);
                beginPingLabel.frame = CGRectMake(286, 1, 34, 30);
                imageV1.frame = CGRectMake(70, 10, 1, 12);
                imageV1.backgroundColor = [UIColor blackColor];
                imageV2.frame = CGRectMake(177, 10, 1, 12);
                imageV2.backgroundColor = [UIColor blackColor];
                imageV3.frame = CGRectMake(286, 10, 1, 12);
                imageV3.backgroundColor = [UIColor blackColor];
                
            }
            nameLabel.font = [UIFont systemFontOfSize:12];
            backImageV.hidden = NO;
            nowPingLabel.hidden = YES;
            nowLostLabel.hidden = YES;
            beginLostLabel.hidden = YES;
            
            nameLabel.text = @"公司";
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nowWinLabel.text = @"即时";
            beginWinLabel.text = @"初盘";
            beginPingLabel.text = @"变化";
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            
        }
        else {
            
            backImageV.hidden = NO;
            nowPingLabel.hidden = NO;
            nowLostLabel.hidden = NO;
            beginLostLabel.hidden = NO;
            nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            nameLabel.text = [self changeCIdToName:cid];
            imageV1.hidden = YES;
            imageV2.hidden = YES;
            imageV3.hidden = YES;
            imageV4.hidden = YES;
            if (isOuPei) {
                nameLabel.frame = CGRectMake(0, 1, 70, 50);
                nowWinLabel.frame = CGRectMake(70, 1, 108, 50);
                beginWinLabel.frame = CGRectMake(178, 1,108, 50);
                beginPingLabel.frame = CGRectMake(286, 1, 65, 50);
                nameLabel.frame = CGRectMake(0, 0, 70, 50);
                nowWinLabel.frame = CGRectMake(70, 0, 54, 50);
                nowPingLabel.frame = CGRectMake(124, 0, 54, 50);
                beginWinLabel.frame = CGRectMake(178, 0, 54, 50);
                beginPingLabel.frame = CGRectMake(232, 0, 54, 50);
                bianhuaLable.frame = CGRectMake(286, 0, 34, 50);
                if (isbianhua) {
                    imageV1.hidden = NO;
                    imageV1.frame = CGRectMake(290, 14, 22, 22);
                    imageV1.backgroundColor = [UIColor clearColor];
                    imageV1.image = UIImageGetImageFromName(@"yuceyou.png");
                }
                else {
                }
                
                if ([array count] >= 4) {
                    nowWinLabel.text = [array objectAtIndex:0];
                    nowPingLabel.text = [array objectAtIndex:1];
                    if ([[array objectAtIndex:0] floatValue] > [[array objectAtIndex:2] floatValue]) {
                        nowWinLabel.textColor = [UIColor redColor];
                    }
                    else if ([[array objectAtIndex:0] floatValue] < [[array objectAtIndex:2] floatValue]) {
                        nowWinLabel.textColor = [UIColor greenColor];
                    }
                    else {
                        nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    }
                    if ([[array objectAtIndex:1] floatValue] > [[array objectAtIndex:3] floatValue]) {
                        nowPingLabel.textColor = [UIColor redColor];
                    }
                    else if ([[array objectAtIndex:1] floatValue] < [[array objectAtIndex:3] floatValue]) {
                        nowPingLabel.textColor = [UIColor greenColor];
                    }
                    else {
                        nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    }
                    beginWinLabel.text = [array objectAtIndex:2];
                    beginPingLabel.text = [array objectAtIndex:3];
                    beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                }
                
                
                
            }
            else {
                imageV1.frame = CGRectMake(75, 0, 1, 33);
                imageV2.frame = CGRectMake(175, 0, 1, 33);
                imageV3.frame = CGRectMake(275, 0, 1, 33);
                nameLabel.frame = CGRectMake(0, 0, 70, 50);
                nowWinLabel.frame = CGRectMake(70, 0, 33, 50);
                nowPingLabel.frame = CGRectMake(103, 0, 42, 50);
                nowLostLabel.frame = CGRectMake(145, 0, 33, 50);
                beginWinLabel.frame = CGRectMake(178, 0, 33, 50);
                beginPingLabel.frame = CGRectMake(211, 0, 42, 50);
                beginLostLabel.frame = CGRectMake(253, 0, 33, 50);
                bianhuaLable.frame =CGRectMake(286, 0, 35, 50);
                if (isbianhua) {
                    imageV1.hidden = NO;
                    imageV1.frame = CGRectMake(290, 14, 22, 22);
                    imageV1.backgroundColor = [UIColor clearColor];
                    imageV1.image = UIImageGetImageFromName(@"yuceyou.png");
                }
                else {
                }
                
                if ([array count] >= 6) {
                    nowWinLabel.text = [array objectAtIndex:0];
                    nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    nowPingLabel.text = [array objectAtIndex:1];
                    nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                    nowLostLabel.text = [array objectAtIndex:2];
                    nowLostLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    beginWinLabel.text = [array objectAtIndex:3];
                    beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    beginPingLabel.text = [array objectAtIndex:4];
                    beginPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                    beginLostLabel.text = [array objectAtIndex:5];
                    beginLostLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
//                    if ([[array objectAtIndex:0] floatValue] > [[array objectAtIndex:3] floatValue]) {
//                        nowWinLabel.textColor = [UIColor redColor];
//                    }
//                    else if ([[array objectAtIndex:0] floatValue] < [[array objectAtIndex:3] floatValue]) {
//                        nowWinLabel.textColor = [UIColor greenColor];
//                    }
//                    else {
//                        nowWinLabel.textColor = [UIColor blackColor];
//                    }
//                    if ([[array objectAtIndex:2] floatValue] > [[array objectAtIndex:5] floatValue]) {
//                        nowLostLabel.textColor = [UIColor redColor];
//                    }
//                    else if ([[array objectAtIndex:2] floatValue] < [[array objectAtIndex:5] floatValue]) {
//                        nowLostLabel.textColor = [UIColor greenColor];
//                    }
//                    else {
//                        nowLostLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
//                    }
                }
            }
        }
    }
    else {
        if (isLanQiu) {
            imageV1.hidden = NO;
            imageV2.hidden = NO;
            if (!imageV3) {
                imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, 1, 33)];
                imageV3.backgroundColor = [UIColor lightGrayColor];
                [self.contentView addSubview:imageV3];
            }
            if (!imageV4) {
                imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 300, 1)];
                imageV4.backgroundColor = [UIColor lightGrayColor];
                [self.contentView addSubview:imageV4];
            }
            if (istitile) {
                if (isOuPei) {
                    nameLabel.frame = CGRectMake(10, 1, 65, 33);
                    nowWinLabel.frame = CGRectMake(75, 1, 85, 33);
                    beginWinLabel.frame = CGRectMake(160, 1, 85, 33);
                    beginPingLabel.frame = CGRectMake(245, 1, 65, 33);
                    imageV1.frame = CGRectMake(75, 0, 1, 33);
                    imageV2.frame = CGRectMake(160, 0, 1, 33);
                    imageV3.frame = CGRectMake(245, 0, 1, 33);
                }
                else {
                    nameLabel.frame = CGRectMake(10, 1, 65, 33);
                    nowWinLabel.frame = CGRectMake(75, 1, 100, 33);
                    beginWinLabel.frame = CGRectMake(175, 1, 100, 33);
                    beginPingLabel.frame = CGRectMake(275, 1, 35, 33);
                    imageV1.frame = CGRectMake(75, 0, 1, 33);
                    imageV2.frame = CGRectMake(175, 0, 1, 33);
                    imageV3.frame = CGRectMake(275, 0, 1, 33);
                    
                }
                backImageV.hidden = NO;
                backImageV.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
                nowPingLabel.hidden = YES;
                nowLostLabel.hidden = YES;
                beginLostLabel.hidden = YES;
                
                nameLabel.text = @"公司";
                nameLabel.textAlignment = NSTextAlignmentCenter;
                nowWinLabel.text = @"即时";
                beginWinLabel.text = @"初盘";
                beginPingLabel.text = @"变化";
                nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                
            }
            else {
                backImageV.hidden = NO;
                nowPingLabel.hidden = NO;
                nowLostLabel.hidden = NO;
                beginLostLabel.hidden = NO;
                nameLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                nameLabel.text = [self changeCIdToName:cid];
                if (isOuPei) {
                    if (!bianhuaLable) {
                        bianhuaLable = [[UILabel alloc] init];
                        
                        bianhuaLable.backgroundColor = [UIColor clearColor];
                        bianhuaLable.font = [UIFont boldSystemFontOfSize:12];
                        bianhuaLable.frame = CGRectMake(235, 0, 45, 33);
                        bianhuaLable.numberOfLines = 0;
                        bianhuaLable.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        bianhuaLable.textAlignment = NSTextAlignmentCenter;
                        [self.contentView addSubview:bianhuaLable];
                        [bianhuaLable release];
                    }
                    nameLabel.frame = CGRectMake(10, 0, 65, 33);
                    nowWinLabel.frame = CGRectMake(75, 0, 42.5, 33);
                    nowPingLabel.frame = CGRectMake(117.5, 0, 42.5, 33);
                    beginWinLabel.frame = CGRectMake(160, 0, 42.5, 33);
                    beginPingLabel.frame = CGRectMake(202.5, 0, 42.5, 33);
                    bianhuaLable.frame = CGRectMake(245, 0, 65, 33);
                    if (isbianhua) {
                        bianhuaLable.text = @">";
                    }
                    else {
                        bianhuaLable.text = @"";
                    }
                    
                    imageV1.frame = CGRectMake(75, 0, 1, 33);
                    imageV2.frame = CGRectMake(160, 0, 1, 33);
                    imageV3.frame = CGRectMake(245, 0, 1, 33);
                    if ([array count] >= 4) {
                        nowWinLabel.text = [array objectAtIndex:0];
                        nowPingLabel.text = [array objectAtIndex:1];
                        if ([[array objectAtIndex:0] floatValue] > [[array objectAtIndex:2] floatValue]) {
                            nowWinLabel.textColor = [UIColor redColor];
                        }
                        else if ([[array objectAtIndex:0] floatValue] < [[array objectAtIndex:2] floatValue]) {
                            nowWinLabel.textColor = [UIColor greenColor];
                        }
                        else {
                            nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        }
                        if ([[array objectAtIndex:1] floatValue] > [[array objectAtIndex:3] floatValue]) {
                            nowPingLabel.textColor = [UIColor redColor];
                        }
                        else if ([[array objectAtIndex:1] floatValue] < [[array objectAtIndex:3] floatValue]) {
                            nowPingLabel.textColor = [UIColor greenColor];
                        }
                        else {
                            nowPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        }
                        beginWinLabel.text = [array objectAtIndex:2];
                        beginPingLabel.text = [array objectAtIndex:3];
                        beginPingLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    }
                    
                    
                    
                }
                else {
                    if (!bianhuaLable) {
                        bianhuaLable = [[UILabel alloc] init];
                        
                        bianhuaLable.backgroundColor = [UIColor clearColor];
                        bianhuaLable.font = [UIFont boldSystemFontOfSize:12];
                        bianhuaLable.frame = CGRectMake(235, 0, 45, 33);
                        bianhuaLable.numberOfLines = 0;
                        bianhuaLable.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        bianhuaLable.textAlignment = NSTextAlignmentCenter;
                        [self.contentView addSubview:bianhuaLable];
                        [bianhuaLable release];
                    }
                    imageV1.frame = CGRectMake(75, 0, 1, 33);
                    imageV2.frame = CGRectMake(175, 0, 1, 33);
                    imageV3.frame = CGRectMake(275, 0, 1, 33);
                    nameLabel.frame = CGRectMake(10, 0, 65, 33);
                    nowWinLabel.frame = CGRectMake(75, 0, 33, 33);
                    nowPingLabel.frame = CGRectMake(105, 0, 40, 33);
                    nowLostLabel.frame = CGRectMake(142, 0, 33, 33);
                    beginWinLabel.frame = CGRectMake(175, 0, 33, 33);
                    beginPingLabel.frame = CGRectMake(205, 0, 40, 33);
                    beginLostLabel.frame = CGRectMake(242, 0, 33, 33);
                    bianhuaLable.frame =CGRectMake(275, 0, 35, 33);
                    if (isbianhua) {
                        bianhuaLable.text = @">";
                    }
                    else {
                        bianhuaLable.text = @"";
                    }
                    
                    if ([array count] >= 6) {
                        nowWinLabel.text = [array objectAtIndex:0];
                        nowWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        nowPingLabel.text = [array objectAtIndex:1];
                        nowPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                        nowLostLabel.text = [array objectAtIndex:2];
                        nowLostLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        beginWinLabel.text = [array objectAtIndex:3];
                        beginWinLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                        beginPingLabel.text = [array objectAtIndex:4];
                        beginPingLabel.textColor = [UIColor colorWithRed:5/255.0 green:0 blue:205/255.0 alpha:1.0];
                        beginLostLabel.text = [array objectAtIndex:5];
                        beginLostLabel.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
                    }
                }
                if (isFoot) {
                    imageV4.hidden = YES;
                    backImageV.image = [UIImageGetImageFromName(@"SZT-X-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
                    imageV1.frame = CGRectMake(imageV1.frame.origin.x, 0, 1, 31);
                    imageV2.frame = CGRectMake(imageV2.frame.origin.x, 0, 1, 31);
                    imageV3.frame = CGRectMake(imageV3.frame.origin.x, 0, 1, 31);
                }
                else {
                    backImageV.image = [UIImageGetImageFromName(@"SZT-Z-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:12];
                }
                
            }
        }
    }
    
}

-(void)LoadData:(NSDictionary *)dic isTitle:(BOOL)istitile {
        if (istitile) {
            self.contentView.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:181/255.0 alpha:1];
            nowPingLabel.hidden = YES;
            nowLostLabel.hidden = YES;
            beginPingLabel.hidden = YES;
            beginLostLabel.hidden = YES;
            
            nameLabel.text = @"公司";
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nowWinLabel.text = @"即时";
            beginWinLabel.text = @"初盘";
            nowWinLabel.frame = CGRectMake(70, 0, 125, 30);
            beginWinLabel.frame = CGRectMake(195, 0, 125, 30);
            
            imageV1.hidden = YES;
            imageV2.hidden = YES;
        }
        else {
            imageV1.hidden = NO;
            imageV2.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
            nowWinLabel.frame = CGRectMake(70, 0, 42, 30);
            beginWinLabel.frame = CGRectMake(195, 0, 42, 30);
            nowPingLabel.hidden = NO;
            nowLostLabel.hidden = NO;
            beginPingLabel.hidden = NO;
            beginLostLabel.hidden = NO;
            nameLabel.textAlignment = NSTextAlignmentLeft;
            if ([[dic objectForKey:@"name"] length]) {
                nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            }
            else {
                NSArray *array = [NSArray arrayWithObjects:@"澳门",@"立博",@"新球",@"皇冠",@"易胜博",@"印尼",@"直博",@"新加坡",@"宝赢",@"三星",nil];
                NSInteger a = [[dic objectForKey:@"cid"] intValue];
                if (a<[array count]) {
                    nameLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:a]];
                }
                else {
                    nameLabel.text = @"-";
                }
            }
            
            nowWinLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"win"]];
            nowPingLabel.text = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"same"]] stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
            nowLostLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lost"]];
            beginWinLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstwin"]];
            beginPingLabel.text = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"firstsame"]] stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
            beginLostLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstlost"]];
        }
}



- (void)dealloc {
	[imageV1 release];
	[imageV2 release];
    [imageV3 release];
    [imageV4 release];
	[nameLabel release];
	[nowWinLabel release];
	[nowPingLabel release];
	[nowLostLabel release];
	[beginWinLabel release];
	[beginPingLabel release];
	[beginLostLabel release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
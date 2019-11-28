//
//  JingCaiZuQiuCell.m
//  caibo
//
//  Created by yao on 12-5-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "JingCaiZuQiuCell.h"
#import "QuartzCore/QuartzCore.h"


@implementation JingCaiZuQiuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		numLabel = [[UILabel alloc] init];
		numLabel.backgroundColor = [UIColor clearColor];
		numLabel.font = [UIFont systemFontOfSize:11];
		numLabel.textAlignment = NSTextAlignmentCenter;
		numLabel.numberOfLines = 0;

        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 2.0;
        numLabel.textColor =[UIColor blackColor];
		[self.contentView addSubview:numLabel];
		
		saishiLabel = [[UILabel alloc] init];
		saishiLabel.backgroundColor = [UIColor clearColor];
		saishiLabel.font = [UIFont systemFontOfSize:11];
		saishiLabel.textAlignment = NSTextAlignmentCenter;
        saishiLabel.layer.masksToBounds = YES;
        saishiLabel.layer.cornerRadius = 2.0;
        saishiLabel.textColor =[UIColor blackColor];
		[self.contentView addSubview:saishiLabel];
		
		duizhenLabel = [[UILabel alloc] init];
		duizhenLabel.backgroundColor = [UIColor clearColor];
		duizhenLabel.font = [UIFont systemFontOfSize:11];
		duizhenLabel.textAlignment = NSTextAlignmentCenter;
        duizhenLabel.layer.masksToBounds = YES;
        duizhenLabel.layer.cornerRadius = 2.0;
        duizhenLabel.textColor =[UIColor blackColor];
		[self.contentView addSubview:duizhenLabel];
		
		touzhuLabel = [[UILabel alloc] init];
		touzhuLabel.backgroundColor = [UIColor clearColor];
		touzhuLabel.font = [UIFont systemFontOfSize:11];
		touzhuLabel.numberOfLines = 0;
        touzhuLabel.textColor =[UIColor blackColor];
		touzhuLabel.textAlignment = NSTextAlignmentCenter;
        touzhuLabel.layer.masksToBounds = YES;
        touzhuLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:touzhuLabel];
		
		rangLabel = [[UILabel alloc] init];
		rangLabel.backgroundColor = [UIColor clearColor];
		rangLabel.font = [UIFont systemFontOfSize:11];
        rangLabel.textColor =[UIColor blackColor];
		rangLabel.textAlignment = NSTextAlignmentCenter;
        rangLabel.layer.masksToBounds = YES;
        rangLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:rangLabel];
		
		danLabel = [[UILabel alloc] init];
		danLabel.backgroundColor = [UIColor clearColor];
		danLabel.font = [UIFont systemFontOfSize:11];
        danLabel.textColor =[UIColor blackColor];
		danLabel.textAlignment = NSTextAlignmentCenter;
        danLabel.layer.masksToBounds = YES;
        danLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:danLabel];
		
		beginLabel = [[UILabel alloc] init];
		beginLabel.backgroundColor = [UIColor clearColor];
		beginLabel.font = [UIFont systemFontOfSize:11];
		beginLabel.textAlignment = NSTextAlignmentCenter;
		beginLabel.textColor = [UIColor blackColor];
        beginLabel.layer.masksToBounds = YES;
        beginLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:beginLabel];
		
		endLabel = [[UILabel alloc] init];
		endLabel.backgroundColor = [UIColor clearColor];
		endLabel.font = [UIFont systemFontOfSize:11];
		endLabel.textAlignment = NSTextAlignmentCenter;
		endLabel.textColor = [UIColor blackColor];
        endLabel.layer.masksToBounds = YES;
        endLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:endLabel];
		
		beginInfoLabel = [[UILabel alloc] init];
		beginInfoLabel.backgroundColor = [UIColor clearColor];
		beginInfoLabel.font = [UIFont systemFontOfSize:10];
		beginInfoLabel.textAlignment = NSTextAlignmentCenter;
		beginInfoLabel.textColor = [UIColor colorWithRed:22/255.0 green:109/255.0 blue:191/255.0 alpha:1];
        beginInfoLabel.layer.masksToBounds = YES;
        beginInfoLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:beginInfoLabel];
		
		endInfoLabel = [[UILabel alloc] init];
		endInfoLabel.backgroundColor = [UIColor clearColor];
		endInfoLabel.font = [UIFont systemFontOfSize:10];
		endInfoLabel.textAlignment = NSTextAlignmentCenter;
		endInfoLabel.textColor = [UIColor colorWithRed:22/255.0 green:109/255.0 blue:191/255.0 alpha:1];
        endInfoLabel.layer.masksToBounds = YES;
        endInfoLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:endInfoLabel];
		
//		shuxianView1 = [[UIView alloc] init];
//		shuxianView1.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:shuxianView1];
//		
//		shuxianView2 = [[UIView alloc] init];
//		shuxianView2.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:shuxianView2];
//		
//		shuxianView3 = [[UIView alloc] init];
//		shuxianView3.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:shuxianView3];
//		
//		shuxianView4 = [[UIView alloc] init];
//		shuxianView4.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:shuxianView4];
//		
//		shuxianView5 = [[UIView alloc] init];
//		shuxianView5.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:shuxianView5];
//		
//		hengxianView1 = [[UIView alloc] init];
//		hengxianView1.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
//		[self.contentView addSubview:hengxianView1];
//
//		hengxianView2 = [[UIView alloc] init];
//		hengxianView2.backgroundColor = [UIColor blackColor];
//		[self.contentView addSubview:hengxianView2];
		self.contentView.backgroundColor = [UIColor whiteColor];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)setLabelColor:(UIColor *)_color {
    numLabel.backgroundColor = _color;
    saishiLabel.backgroundColor = _color;
    duizhenLabel.backgroundColor = _color;
    touzhuLabel.backgroundColor = _color;
    rangLabel.backgroundColor = _color;
    danLabel.backgroundColor = _color;
    beginLabel.backgroundColor = _color;
    endLabel.backgroundColor = _color;
    beginInfoLabel.backgroundColor = _color;
    endInfoLabel.backgroundColor = _color;
}

- (void) LoadData:(NSDictionary *)dic IsFirst:(BOOL)isfirst LotteryId:(NSString *)lotteryId  {
	NSString *numKey=@"no",*duizhenKey=@"changCi",*touzhuKey=@"touZhu",
	*saishiKey=@"leagueName",*beginInfoKey=@"matchStartTime",*endInfoKey=@"endTime",
	*danKey = @"dan",*rangKey = @"letBall";
	
	if ([lotteryId isEqualToString:@"210"]||[lotteryId isEqualToString:@"200"]||[lotteryId isEqualToString:@"22"]||[lotteryId isEqualToString:@"49"]||
		[lotteryId isEqualToString:@"240"]||[lotteryId isEqualToString:@"250"]||[lotteryId isEqualToString:@"25"]||
		[lotteryId isEqualToString:@"24"]||[lotteryId isEqualToString:@"23"]||[lotteryId isEqualToString:@"26"]||[lotteryId isEqualToString:@"27"]||[lotteryId isEqualToString:@"28"]||[lotteryId isEqualToString:@"29"]||[lotteryId isEqualToString:@"230"]) {
		numKey = @"matchNumber";
	}
	NSInteger touzhuWith = 0;
	if ([lotteryId isEqualToString:@"200"]||[lotteryId isEqualToString:@"22"]||[lotteryId isEqualToString:@"49"]||[lotteryId isEqualToString:@"27"]||[lotteryId isEqualToString:@"29"]) {
		shuxianView5.hidden = NO;
		touzhuWith = 60;
	}
	else {
		shuxianView5.hidden = YES;
		touzhuWith = 80;
	}
	rangLabel.text = [dic objectForKey:rangKey];
	NSInteger heght = 30;
	if (isfirst) {
		heght = 44;
	}
	CGSize maxSize = CGSizeMake(touzhuWith, 1000);
    CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	if (heght<expectedSize.height) {
		heght = expectedSize.height;
	}
	if ([dic objectForKey:numKey]) {
		numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:numKey]];
	}
	else {
		numLabel.text = nil;
	}

	duizhenLabel.text = [dic objectForKey:duizhenKey];
	touzhuLabel.text = [dic objectForKey:touzhuKey];
	saishiLabel.text = [dic objectForKey:saishiKey];
	if ([[dic objectForKey:danKey] intValue]) {
		danLabel.text = @"√";
	}
	else {
		danLabel.text = @"-";
	}
	
	if ([[dic objectForKey:beginInfoKey] length]>5) {
		beginInfoLabel.text = [[dic objectForKey:beginInfoKey] substringFromIndex:5];
	}
	else {
		beginInfoLabel.text = nil;
	}
	if ([[dic objectForKey:endInfoKey] length]>5) {
		endInfoLabel.text = [[dic objectForKey:endInfoKey] substringFromIndex:5];
	}
	else {
		endInfoLabel.text = nil;
	}
	
	beginLabel.text = @"开赛时间";
	endLabel.text = @"停售时间";
	if (isfirst) {
		numLabel.frame = CGRectMake(3, 1, 40, heght);
		saishiLabel.frame = CGRectMake(44, 1, 40, 16);
		duizhenLabel.frame = CGRectMake(85, 1, 120, 16);
		rangLabel.frame = CGRectMake(206, 1, 80-touzhuWith, heght);
        if (touzhuWith != 80) {
            touzhuLabel.frame = CGRectMake(rangLabel.frame.origin.x + rangLabel.bounds.size.width+1, 1, touzhuWith, heght);
        }
        else {
            touzhuLabel.frame = CGRectMake(206, 1, touzhuWith, heght);
        }
        
		
		danLabel.frame = CGRectMake(touzhuLabel.frame.origin.x + touzhuLabel.bounds.size.width +1, 1, 20, 44);
		beginLabel.frame = CGRectMake(44, 18, 80, 14);
		endLabel.frame = CGRectMake(125, 18, 80, 14);
		beginInfoLabel.frame = CGRectMake(44, 33, 80, 12);
		endInfoLabel.frame = CGRectMake(125, 33, 80, 12);
		
		shuxianView1.frame = CGRectMake(40, 0, 1, heght);
		shuxianView2.frame = CGRectMake(80, 0, 1, 16);
		shuxianView3.frame = CGRectMake(200, 0, 1, heght);
		shuxianView4.frame = CGRectMake(280, 0, 1, heght);
		shuxianView5.frame = CGRectMake(280-touzhuWith, 0, 1, heght);
		hengxianView1.frame = CGRectMake(40, 16, 160, 1);
		hengxianView2.frame = CGRectMake(0, heght -1, 300, 1);
        if ([lotteryId isEqualToString:@"27"]) {
            rangLabel.frame = CGRectMake(206, 1, 30, heght);
            touzhuLabel.frame = CGRectMake(237, 1, 50, heght);
        }
        else if ([lotteryId isEqualToString:@"29"]) {
            duizhenLabel.frame = CGRectMake(duizhenLabel.frame.origin.x, duizhenLabel.frame.origin.y, 115, duizhenLabel.frame.size.height);
            rangLabel.frame = CGRectMake(duizhenLabel.frame.origin.x+duizhenLabel.frame.size.width + 1, 1, 55, heght);
            touzhuLabel.frame = CGRectMake(rangLabel.frame.origin.x+rangLabel.frame.size.width + 1, 1, 30, heght);
            danLabel.frame = CGRectMake(touzhuLabel.frame.origin.x + touzhuLabel.frame.size.width + 1,danLabel.frame.origin.y ,danLabel.frame.size.width, danLabel.frame.size.height);
            beginLabel.frame = CGRectMake(beginLabel.frame.origin.x, beginLabel.frame.origin.y, 77, beginLabel.frame.size.height);
            endLabel.frame = CGRectMake(beginLabel.frame.origin.x + beginLabel.frame.size.width + 1, endLabel.frame.origin.y, 78, endLabel.frame.size.height);
            beginInfoLabel.frame = CGRectMake(44, beginInfoLabel.frame.origin.y, beginLabel.frame.size.width, beginInfoLabel.frame.size.height);
            endInfoLabel.frame = CGRectMake(endLabel.frame.origin.x, endInfoLabel.frame.origin.y, endLabel.frame.size.width, endInfoLabel.frame.size.height);
        }
        
	}
	else {
		numLabel.frame = CGRectMake(3, 1, 40, heght);
		saishiLabel.frame = CGRectMake(44, 1, 40, 16);
		duizhenLabel.frame = CGRectMake(85, 1, 120, 16);
		rangLabel.frame = CGRectMake(206, 1, 80-touzhuWith, heght);
		
        if (touzhuWith != 80) {
            touzhuLabel.frame = CGRectMake(rangLabel.frame.origin.x + rangLabel.bounds.size.width+1, 1, touzhuWith, heght);
        }
        else {
            touzhuLabel.frame = CGRectMake(206, 1, touzhuWith, heght);
        }
		danLabel.frame = CGRectMake(touzhuLabel.frame.origin.x + touzhuLabel.bounds.size.width+1, 1, 20, heght);
		beginLabel.frame = CGRectMake(3, 0, 0, 0);
		endLabel.frame = CGRectMake(3, 0, 0, 0);
		beginInfoLabel.frame = CGRectMake(44, 18, 80, 13);
		endInfoLabel.frame = CGRectMake(125, 18, 80, 13);
		
		shuxianView1.frame = CGRectMake(40, 1, 1, heght);
		shuxianView2.frame = CGRectMake(80, 1, 1, 16);
		shuxianView3.frame = CGRectMake(200, 1, 1, heght);
		shuxianView4.frame = CGRectMake(280, 1, 1, heght);
		shuxianView5.frame = CGRectMake(280-touzhuWith, 1, 1, heght);
		hengxianView1.frame = CGRectMake(40, 16, 160, 1);
		hengxianView2.frame = CGRectMake(0, heght -1, 300, 1);
        if ([lotteryId isEqualToString:@"27"]) {
            rangLabel.frame = CGRectMake(206, 1, 30, heght);
            touzhuLabel.frame = CGRectMake(237, 1, 50, heght);
        }
        else if ([lotteryId isEqualToString:@"29"]) {
            duizhenLabel.frame = CGRectMake(duizhenLabel.frame.origin.x, duizhenLabel.frame.origin.y, 115, duizhenLabel.frame.size.height);
            rangLabel.frame = CGRectMake(duizhenLabel.frame.origin.x+duizhenLabel.frame.size.width + 1, 1, 55, heght);
            touzhuLabel.frame = CGRectMake(rangLabel.frame.origin.x+rangLabel.frame.size.width + 1, 1, 30, heght);
            danLabel.frame = CGRectMake(touzhuLabel.frame.origin.x + touzhuLabel.frame.size.width + 1,danLabel.frame.origin.y ,danLabel.frame.size.width, danLabel.frame.size.height);
            beginInfoLabel.frame = CGRectMake(beginInfoLabel.frame.origin.x, beginInfoLabel.frame.origin.y, 77, beginInfoLabel.frame.size.height);
            endInfoLabel.frame = CGRectMake(beginInfoLabel.frame.origin.x+ beginInfoLabel.frame.size.width + 1, endInfoLabel.frame.origin.y, 78, endInfoLabel.frame.size.height);

        }
	}
    
    if (heght >40 && !isfirst) {
        saishiLabel.frame = CGRectMake(saishiLabel.frame.origin.x, saishiLabel.frame.origin.y, saishiLabel.frame.size.width, heght/2);
        duizhenLabel.frame = CGRectMake(duizhenLabel.frame.origin.x, duizhenLabel.frame.origin.y, duizhenLabel.frame.size.width, heght/2);
        beginInfoLabel.frame = CGRectMake(beginInfoLabel.frame.origin.x, saishiLabel.frame.origin.y + saishiLabel.frame.size.height + 1, beginInfoLabel.frame.size.width, heght - saishiLabel.frame.size.height-1);
        endInfoLabel.frame = CGRectMake(endInfoLabel.frame.origin.x, beginInfoLabel.frame.origin.y, endInfoLabel.frame.size.width, heght - beginInfoLabel.frame.size.height);
    }
    else if (isfirst && heght >50) {
    }
	
}


- (void)dealloc {
	[numLabel release];
	[saishiLabel release];
	[duizhenLabel release];
	[touzhuLabel release];
	[rangLabel release];
	[beginLabel release];
	[endLabel release];
	[beginInfoLabel release];
	[endInfoLabel release];
	
	[shuxianView1 release];
	[shuxianView2 release];
	[shuxianView3 release];
	[shuxianView4 release];
	
	[hengxianView1 release];
	[hengxianView2 release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
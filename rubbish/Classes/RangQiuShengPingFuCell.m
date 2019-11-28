//
//  RangQiuShengPingFuCell.m
//  caibo
//
//  Created by yao on 12-5-8.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "RangQiuShengPingFuCell.h"


@implementation RangQiuShengPingFuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		numLabel = [[UILabel alloc] init];
		numLabel.backgroundColor = [UIColor clearColor];
		numLabel.font = [UIFont systemFontOfSize:13];
		numLabel.textAlignment = NSTextAlignmentCenter;
		numLabel.numberOfLines = 0;
		[self.contentView addSubview:numLabel];
		
		saishiLabel = [[UILabel alloc] init];
		saishiLabel.backgroundColor = [UIColor clearColor];
		saishiLabel.font = [UIFont systemFontOfSize:13];
		saishiLabel.textAlignment = NSTextAlignmentLeft;
		[self.contentView addSubview:saishiLabel];
		
		duizhenLabel = [[UILabel alloc] init];
		duizhenLabel.backgroundColor = [UIColor clearColor];
		duizhenLabel.font = [UIFont systemFontOfSize:13];
		duizhenLabel.textAlignment = NSTextAlignmentLeft;
		[self.contentView addSubview:duizhenLabel];
		
		rangLabel = [[UILabel alloc] init];
		rangLabel.backgroundColor = [UIColor clearColor];
		rangLabel.font = [UIFont systemFontOfSize:13];
		rangLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:rangLabel];
		
		shengLabel = [[UILabel alloc] init];
		shengLabel.backgroundColor = [UIColor clearColor];
		shengLabel.font = [UIFont boldSystemFontOfSize:13];
		shengLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:shengLabel];
		
		pingLabel = [[UILabel alloc] init];
		pingLabel.backgroundColor = [UIColor clearColor];
		pingLabel.font = [UIFont boldSystemFontOfSize:13];
		pingLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:pingLabel];
		
		fuLabel = [[UILabel alloc] init];
		fuLabel.backgroundColor = [UIColor clearColor];
		fuLabel.font = [UIFont boldSystemFontOfSize:13];
		fuLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:fuLabel];
		
		danLabel = [[UILabel alloc] init];
		danLabel.backgroundColor = [UIColor clearColor];
		danLabel.font = [UIFont systemFontOfSize:13];
		danLabel.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:danLabel];
		
		beginLabel = [[UILabel alloc] init];
		beginLabel.backgroundColor = [UIColor clearColor];
		beginLabel.font = [UIFont systemFontOfSize:13];
		beginLabel.textAlignment = NSTextAlignmentCenter;
		beginLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		[self.contentView addSubview:beginLabel];
		
		endLabel = [[UILabel alloc] init];
		endLabel.backgroundColor = [UIColor clearColor];
		endLabel.font = [UIFont systemFontOfSize:13];
		endLabel.textAlignment = NSTextAlignmentCenter;
		endLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		[self.contentView addSubview:endLabel];
		
		beginInfoLabel = [[UILabel alloc] init];
		beginInfoLabel.backgroundColor = [UIColor clearColor];
		beginInfoLabel.font = [UIFont systemFontOfSize:10];
		beginInfoLabel.textAlignment = NSTextAlignmentCenter;
		beginInfoLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		[self.contentView addSubview:beginInfoLabel];
		
		endInfoLabel = [[UILabel alloc] init];
		endInfoLabel.backgroundColor = [UIColor clearColor];
		endInfoLabel.font = [UIFont systemFontOfSize:10];
		endInfoLabel.textAlignment = NSTextAlignmentCenter;
		endInfoLabel.textColor = [UIColor colorWithRed:26/255.0 green:83/255.0 blue:165/255.0 alpha:1];
		[self.contentView addSubview:endInfoLabel];
		
		shuxianView1 = [[UIView alloc] init];
		shuxianView1.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
		[self.contentView addSubview:shuxianView1];
		
		shuxianView2 = [[UIView alloc] init];
		shuxianView2.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
		[self.contentView addSubview:shuxianView2];
		
		shuxianView3 = [[UIView alloc] init];
		shuxianView3.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
		[self.contentView addSubview:shuxianView3];
		
		shuxianView4 = [[UIView alloc] init];
		shuxianView4.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
		[self.contentView addSubview:shuxianView4];
		
		hengxianView1 = [[UIView alloc] init];
		hengxianView1.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
		[self.contentView addSubview:hengxianView1];
//		
//		hengxianView2 = [[UIView alloc] init];
//		hengxianView2.backgroundColor = [UIColor colorWithRed:115/255.0 green:185/255.0 blue:215/255.0 alpha:1];
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

- (void) LoadData:(NSDictionary *)dic IsFirst:(BOOL)isfirst LotteryId:(NSString *)lotteryId  {
	NSString *numKey=@"no",*duizhenKey=@"changCi",*touzhuKey=@"touZhu",
	*saishiKey=@"saishi",*beginInfoKey=@"matchStartTime",*endInfoKey=@"endTime",
	*danKey = @"dan",*rangKey = @"letBall";
	
	if ([dic objectForKey:numKey]) {
		numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"no"]];
	}
	else {
		numLabel.text = nil;
	}
	rangLabel.text = [dic objectForKey:rangKey];
	duizhenLabel.text = [dic objectForKey:duizhenKey];
	if ( [[dic objectForKey:touzhuKey] rangeOfString:@"3"].location != NSNotFound) {
		shengLabel.text = @"3";
		//shengLabel.backgroundColor = [UIColor redColor];
	}
	else {
		shengLabel.text = nil;
		shengLabel.backgroundColor = [UIColor clearColor];
	}
	
	if ( [[dic objectForKey:touzhuKey] rangeOfString:@"1"].location != NSNotFound) {
		pingLabel.text = @"1";
		//pingLabel.backgroundColor = [UIColor redColor];
	}
	else {
		pingLabel.text = nil;
		pingLabel.backgroundColor = [UIColor clearColor];
	}
	
	if ( [[dic objectForKey:touzhuKey] rangeOfString:@"0"].location != NSNotFound) {
		fuLabel.text = @"0";
		//fuLabel.backgroundColor = [UIColor redColor];
	}
	else {
		fuLabel.text = nil;
		fuLabel.backgroundColor = [UIColor clearColor];
	}
	saishiLabel.text = [dic objectForKey:saishiKey];
	if ([[dic objectForKey:danKey] intValue]) {
		danLabel.text = @"√";
	}
	else {
		danLabel.text = @"-";
	}
	
	beginInfoLabel.text = [dic objectForKey:beginInfoKey];
	endInfoLabel.text = [dic objectForKey:endInfoKey];
	beginLabel.text = @"开赛时间";
	endLabel.text = @"停售时间";
	if (isfirst) {
		numLabel.frame = CGRectMake(0, 0, 40, 44);
		saishiLabel.frame = CGRectMake(42, 0, 40, 16);
		duizhenLabel.frame = CGRectMake(82, 0, 120, 16);
		rangLabel.frame = CGRectMake(200, 0, 20, 44);
		shengLabel.frame = CGRectMake(220, 0, 20, 44);
		pingLabel.frame = CGRectMake(240, 0, 20, 44);
		fuLabel.frame = CGRectMake(260, 0, 20, 44);
		danLabel.frame = CGRectMake(280, 0, 20, 44);
		beginLabel.frame = CGRectMake(40, 17, 70, 15);
		endLabel.frame = CGRectMake(110, 17, 70, 15);
		beginInfoLabel.frame = CGRectMake(40, 32, 70, 12);
		endInfoLabel.frame = CGRectMake(110, 32, 70, 12);
		
		shuxianView1.frame = CGRectMake(40, 0, 1, 44);
		shuxianView2.frame = CGRectMake(80, 0, 1, 16);
		shuxianView3.frame = CGRectMake(200, 0, 1, 44);
		shuxianView4.frame = CGRectMake(280, 0, 1, 44);
		hengxianView1.frame = CGRectMake(40, 16, 160, 1);
		hengxianView2.frame = CGRectMake(0, 43, 300, 1);
	}
	else {
		numLabel.frame = CGRectMake(0, 0, 40, 30);
		saishiLabel.frame = CGRectMake(42, 0, 40, 16);
		duizhenLabel.frame = CGRectMake(82, 0, 120, 16);
		rangLabel.frame = CGRectMake(200, 0, 20, 30);;
		shengLabel.frame = CGRectMake(220, 0, 20, 30);
		pingLabel.frame = CGRectMake(240, 0, 20, 30);
		fuLabel.frame = CGRectMake(260, 0, 20, 30);
		danLabel.frame = CGRectMake(280, 0, 20, 30);
		beginLabel.frame = CGRectMake(0, 0, 0, 0);
		endLabel.frame = CGRectMake(0, 0, 0, 0);
		beginInfoLabel.frame = CGRectMake(40, 17, 70, 12);
		endInfoLabel.frame = CGRectMake(110, 17, 70, 12);
		
		shuxianView1.frame = CGRectMake(40, 0, 1, 30);
		shuxianView2.frame = CGRectMake(80, 0, 1, 16);
		shuxianView3.frame = CGRectMake(200, 0, 1, 30);
		shuxianView4.frame = CGRectMake(280, 0, 1, 30);
		hengxianView1.frame = CGRectMake(40, 16, 160, 1);
		hengxianView2.frame = CGRectMake(0, 29, 300, 1);
	}
	
	
}


- (void)dealloc {
	[numLabel release];
	[saishiLabel release];
	[duizhenLabel release];
	[rangLabel release];
	[shengLabel release];
	[pingLabel release];
	[fuLabel release];
	[beginLabel release];
	[endLabel release];
	[beginInfoLabel release];
	[endInfoLabel release];
	
	[shuxianView1 release];
	[shuxianView2 release];
	[shuxianView3 release];
	[shuxianView4 release];
	[shuxianView5 release];
	[shuxianView6 release];
	
	[hengxianView1 release];
	[hengxianView2 release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
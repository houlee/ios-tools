//
//  tzPerCell.m
//  caibo
//
//  Created by yao on 12-5-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "tzPerCell.h"


@implementation tzPerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		name1Label = [[UILabel alloc] init];
		name1Label.backgroundColor = [UIColor clearColor];
		name1Label.frame = CGRectMake(10, 0, 40, 30);
		name1Label.font = [UIFont systemFontOfSize:13];
		[self.contentView addSubview:name1Label];
		
		name2Label = [[UILabel alloc] init];
		name2Label.backgroundColor = [UIColor clearColor];
		name2Label.frame = CGRectMake(50, 0, 65, 30);
		name2Label.font = [UIFont systemFontOfSize:13];
		[self.contentView addSubview:name2Label];
		
		name3Label = [[UILabel alloc] init];
		name3Label.backgroundColor = [UIColor clearColor];
		name3Label.frame = CGRectMake(115, 0, 65, 30);
		name3Label.font = [UIFont systemFontOfSize:13];
		[self.contentView addSubview:name3Label];
		
		name4Label = [[UILabel alloc] init];
		name4Label.backgroundColor = [UIColor clearColor];
		name4Label.frame = CGRectMake(180, 0, 70, 30);
		name4Label.font = [UIFont systemFontOfSize:13];
		[self.contentView addSubview:name4Label];
		
		name5Label = [[UILabel alloc] init];
		name5Label.backgroundColor = [UIColor clearColor];
		name5Label.frame = CGRectMake(250, 0, 70, 30);
		name5Label.font = [UIFont systemFontOfSize:13];
		[self.contentView addSubview:name5Label];
		
		imageV = [[UIImageView alloc] init];
		imageV.frame = CGRectMake(0, 29, 320, 1);
		imageV.backgroundColor = [UIColor lightGrayColor];
		[self.contentView addSubview:imageV];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
    return self;
}


- (void)LoadDataName1:(NSString *)name1
				Name2:(NSString *)name2
				Name3:(NSString *)name3
				Name4:(NSString *)name4
				Name5:(NSString *)name5
			  isTitle:(BOOL)isTitle{
	name1Label.text = name1;
	name2Label.text = name2;
	name3Label.text = name3;
	name4Label.text = name4;
	name5Label.text = name5;
	if (isTitle) {
//		name1Label.textAlignment = NSTextAlignmentCenter;
//		name2Label.textAlignment = NSTextAlignmentCenter;
//		name3Label.textAlignment = NSTextAlignmentCenter;
//		name4Label.textAlignment = NSTextAlignmentCenter;
//		name5Label.textAlignment = NSTextAlignmentCenter;
		
		name1Label.textColor = [UIColor colorWithRed:113/255.0 green:42/255.0 blue:0 alpha:1.0];
		name2Label.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
		name3Label.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
		name4Label.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
		name5Label.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1.0];
		self.contentView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
	}
	else {
		name1Label.textAlignment = NSTextAlignmentLeft;
		name2Label.textAlignment = NSTextAlignmentLeft;
		name3Label.textAlignment = NSTextAlignmentLeft;
		name4Label.textAlignment = NSTextAlignmentLeft;
		name5Label.textAlignment = NSTextAlignmentLeft;
		
		name1Label.textColor = [UIColor blackColor];
		name2Label.textColor = [UIColor blackColor];
		name3Label.textColor = [UIColor blackColor];
		name4Label.textColor = [UIColor blackColor];
		name5Label.textColor = [UIColor blackColor];
		self.contentView.backgroundColor = [UIColor whiteColor];
	}
}

- (void)LoadDataDic1:(NSDictionary *)dic1
				Dic2:(NSDictionary *)dic2
				Dic3:(NSDictionary *)dic3
				Dic4:(NSDictionary *)dic4
				Dic5:(NSDictionary *)dic5
			 isTitle:(BOOL)isTitle {
	NSString *name1 =nil,*name2 =@"无",*name3= @"无",*name4 =@"无",*name5 =@"无";
	if (dic1) {
		name1 = [NSString stringWithFormat:@"%@:%@%%",[dic1 objectForKey:@"key"],[dic1 objectForKey:@"value"]];
	}
	if (dic2) {
		name2 = [NSString stringWithFormat:@"%@:%@%%",[dic2 objectForKey:@"key"],[dic2 objectForKey:@"value"]];
	}
	if (dic3) {
		name3 = [NSString stringWithFormat:@"%@:%@%%",[dic3 objectForKey:@"key"],[dic3 objectForKey:@"value"]];
	}
	if (dic4) {
		name4 = [NSString stringWithFormat:@"%@:%@%%",[dic4 objectForKey:@"key"],[dic4 objectForKey:@"value"]];
	}
	if (dic5) {
		name5 = [NSString stringWithFormat:@"%@:%@%%",[[dic5 objectForKey:@"key"] stringByReplacingOccurrencesOfString:@":" withString:@"-"],[dic5 objectForKey:@"value"]];
	}
	[self LoadDataName1:name1
				  Name2:name2 
				  Name3:name3
				  Name4:name4
				  Name5:name5 isTitle:isTitle];
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[name1Label release];
	[name2Label release];
	[name3Label release];
	[name4Label release];
	[name5Label release];
	[imageV release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
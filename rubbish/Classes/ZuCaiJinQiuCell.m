//
//  ZuCaiJinQiuCell.m
//  caibo
//
//  Created by yao on 12-5-9.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ZuCaiJinQiuCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation ZuCaiJinQiuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		numLabel1 = [[UILabel alloc] init];
		numLabel1.backgroundColor = [UIColor clearColor];
		numLabel1.font = [UIFont systemFontOfSize:13];
		numLabel1.textAlignment = NSTextAlignmentCenter;
		numLabel1.numberOfLines = 0;
		numLabel1.frame = CGRectMake(2, 0, 40, 20);
        numLabel1.layer.masksToBounds = YES;
        numLabel1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:numLabel1];
		
		saishiLabel1 = [[UILabel alloc] init];
		saishiLabel1.backgroundColor = [UIColor clearColor];
		saishiLabel1.font = [UIFont systemFontOfSize:13];
		saishiLabel1.textAlignment = NSTextAlignmentCenter;
		saishiLabel1.frame = CGRectMake(43, 0, 40, 41);
        saishiLabel1.layer.masksToBounds = YES;
        saishiLabel1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:saishiLabel1];
		
		duizhenLabel1 = [[UILabel alloc] init];
		duizhenLabel1.backgroundColor = [UIColor clearColor];
		duizhenLabel1.font = [UIFont systemFontOfSize:13];
		duizhenLabel1.textAlignment = NSTextAlignmentCenter;
		duizhenLabel1.frame = CGRectMake(84, 0, 100, 20);
        duizhenLabel1.layer.masksToBounds = YES;
        duizhenLabel1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:duizhenLabel1];
		
		jinqiu0Label1 = [[UILabel alloc] init];
		jinqiu0Label1.backgroundColor = [UIColor clearColor];
		jinqiu0Label1.font = [UIFont boldSystemFontOfSize:13];
		jinqiu0Label1.textAlignment = NSTextAlignmentCenter;
		jinqiu0Label1.frame = CGRectMake(185, 0, 40, 20);
        jinqiu0Label1.layer.masksToBounds = YES;
        jinqiu0Label1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu0Label1];
		
		jinqiu1Label1 = [[UILabel alloc] init];
		jinqiu1Label1.backgroundColor = [UIColor clearColor];
		jinqiu1Label1.font = [UIFont boldSystemFontOfSize:13];
		jinqiu1Label1.textAlignment = NSTextAlignmentCenter;
		jinqiu1Label1.frame = CGRectMake(226, 0, 40, 20);
        jinqiu1Label1.layer.masksToBounds = YES;
        jinqiu1Label1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu1Label1];
		
		jinqiu2Label1 = [[UILabel alloc] init];
		jinqiu2Label1.backgroundColor = [UIColor clearColor];
		jinqiu2Label1.font = [UIFont boldSystemFontOfSize:13];
		jinqiu2Label1.textAlignment = NSTextAlignmentCenter;
		jinqiu2Label1.frame = CGRectMake(267, 0, 40, 20);
        jinqiu2Label1.layer.masksToBounds = YES;
        jinqiu2Label1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu2Label1];
		
		jinqiu3Label1 = [[UILabel alloc] init];
		jinqiu3Label1.backgroundColor = [UIColor clearColor];
		jinqiu3Label1.font = [UIFont boldSystemFontOfSize:13];
		jinqiu3Label1.textAlignment = NSTextAlignmentCenter;
		jinqiu3Label1.frame = CGRectMake(288, 0, 40, 20);
        jinqiu3Label1.layer.masksToBounds = YES;
        jinqiu3Label1.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu3Label1];
		
		
		numLabel2 = [[UILabel alloc] init];
		numLabel2.backgroundColor = [UIColor clearColor];
		numLabel2.font = [UIFont systemFontOfSize:13];
		numLabel2.textAlignment = NSTextAlignmentCenter;
		numLabel2.numberOfLines = 0;
		numLabel2.frame = CGRectMake(2, 21, 40, 20);
        numLabel2.layer.masksToBounds = YES;
        numLabel2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:numLabel2];
				
		duizhenLabel2 = [[UILabel alloc] init];
		duizhenLabel2.backgroundColor = [UIColor clearColor];
		duizhenLabel2.font = [UIFont systemFontOfSize:13];
		duizhenLabel2.textAlignment = NSTextAlignmentCenter;
		duizhenLabel2.frame = CGRectMake(84, 21, 100, 20);
        duizhenLabel2.layer.masksToBounds = YES;
        duizhenLabel2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:duizhenLabel2];
		
		jinqiu0Label2 = [[UILabel alloc] init];
		jinqiu0Label2.backgroundColor = [UIColor clearColor];
		jinqiu0Label2.font = [UIFont systemFontOfSize:13];
		jinqiu0Label2.textAlignment = NSTextAlignmentCenter;
		jinqiu0Label2.frame = CGRectMake(185, 21, 40, 20);
        jinqiu0Label2.layer.masksToBounds = YES;
        jinqiu0Label2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu0Label2];
		
		jinqiu1Label2 = [[UILabel alloc] init];
		jinqiu1Label2.backgroundColor = [UIColor clearColor];
		jinqiu1Label2.font = [UIFont boldSystemFontOfSize:13];
		jinqiu1Label2.textAlignment = NSTextAlignmentCenter;
		jinqiu1Label2.frame = CGRectMake(226, 21, 40, 20);
        jinqiu1Label2.layer.masksToBounds = YES;
        jinqiu1Label2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu1Label2];
		
		jinqiu2Label2 = [[UILabel alloc] init];
		jinqiu2Label2.backgroundColor = [UIColor clearColor];
		jinqiu2Label2.font = [UIFont boldSystemFontOfSize:13];
		jinqiu2Label2.textAlignment = NSTextAlignmentCenter;
		jinqiu2Label2.frame = CGRectMake(267, 21, 40, 20);
        jinqiu2Label2.layer.masksToBounds = YES;
        jinqiu2Label2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu2Label2];
		
		jinqiu3Label2 = [[UILabel alloc] init];
		jinqiu3Label2.backgroundColor = [UIColor clearColor];
		jinqiu3Label2.font = [UIFont boldSystemFontOfSize:13];
		jinqiu3Label2.textAlignment = NSTextAlignmentCenter;
		jinqiu3Label2.frame = CGRectMake(288, 21, 40, 20);
        jinqiu3Label2.layer.masksToBounds = YES;
        jinqiu3Label2.layer.cornerRadius = 2.0;
		[self.contentView addSubview:jinqiu3Label2];
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
    numLabel1.backgroundColor = _color;
    saishiLabel1.backgroundColor = _color;
    duizhenLabel1.backgroundColor = _color;
    jinqiu0Label1.backgroundColor = _color;
    jinqiu1Label1.backgroundColor = _color;
    jinqiu2Label1.backgroundColor = _color;
    jinqiu3Label1.backgroundColor = _color;
    
    numLabel2.backgroundColor = _color;
    duizhenLabel2.backgroundColor = _color;
    jinqiu0Label2.backgroundColor = _color;
    jinqiu1Label2.backgroundColor = _color;
    jinqiu2Label2.backgroundColor = _color;
    jinqiu3Label2.backgroundColor = _color;
}

- (void)LoadData:(NSDictionary *)dic Is4:(BOOL)is4 {
	NSString *numKey=@"no",*duizhenKey=@"changCi",*touzhuKey=@"touZhu",
	*saishiKey=@"leagueName";//*beginInfoKey=@"gameTime",*endInfoKey=@"endTime",
	saishiLabel1.text = [dic objectForKey:saishiKey];
	numLabel1.text = [NSString stringWithFormat:@"%d",2*[[dic objectForKey:numKey] intValue]-1];
	numLabel2.text = [NSString stringWithFormat:@"%d",2*[[dic objectForKey:numKey] intValue]];
	if (!is4) {
		numLabel1.frame = CGRectMake(2, 0, 40, 20);
		numLabel2.frame = CGRectMake(2, 21, 40, 20);
		
		saishiLabel1.frame = CGRectMake(43, 0, 40, 41);
		
		duizhenLabel1.frame = CGRectMake(84, 0, 110, 41);
		duizhenLabel1.text = [dic objectForKey:duizhenKey];
		duizhenLabel2.frame = CGRectZero;
		
		NSArray *array = [[dic objectForKey:touzhuKey] componentsSeparatedByString:@":"];
        NSString *jinqiu1 = @"";
        NSString *jinqiu2 = @"";
        if ([array count] >= 2) {
           jinqiu1 = [array objectAtIndex:0];
            jinqiu2 = [array objectAtIndex:1];
        }
		jinqiu0Label1.text = @"半";
		jinqiu0Label2.text = @"全";
		
		if ([jinqiu1 rangeOfString:@"3"].location !=NSNotFound) {
			jinqiu1Label1.text = @"3";
			//jinqiu1Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu1Label1.text = nil;
			jinqiu1Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu1 rangeOfString:@"1"].location !=NSNotFound) {
			jinqiu2Label1.text = @"1";
			//jinqiu2Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu2Label1.text = nil;
			jinqiu2Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu1 rangeOfString:@"0"].location !=NSNotFound) {
			jinqiu3Label1.text = @"0";
			//jinqiu3Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu3Label1.text = nil;
			jinqiu3Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"3"].location !=NSNotFound) {
			jinqiu1Label2.text = @"3";
			//jinqiu1Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu1Label2.text = nil;
			jinqiu1Label2.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"1"].location !=NSNotFound) {
			jinqiu2Label2.text = @"1";
			//jinqiu2Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu2Label2.text = nil;
			jinqiu2Label2.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"0"].location !=NSNotFound) {
			jinqiu3Label2.text = @"0";
			//jinqiu3Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu3Label2.text = nil;
			jinqiu3Label2.backgroundColor = [UIColor clearColor];
 		}
		
		jinqiu0Label1.frame = CGRectMake(195, 0, 20, 20);
		jinqiu0Label2.frame = CGRectMake(195, 21, 20, 20);
		
		jinqiu1Label1.frame = CGRectMake(216, 0, 30, 20);
		jinqiu1Label2.frame = CGRectMake(216, 21, 30, 20);
		
		jinqiu2Label1.frame = CGRectMake(247, 0, 30, 20);
		jinqiu2Label2.frame = CGRectMake(247, 21, 30, 20);
		
		jinqiu3Label1.frame = CGRectMake(278, 0, 30, 20);
		jinqiu3Label2.frame = CGRectMake(278, 21, 30, 20);
    }
	else {
		NSArray *array = [[dic objectForKey:touzhuKey] componentsSeparatedByString:@":"];
        NSString *jinqiu1 = @"";
        NSString *jinqiu2 = @"";
        if ([array count] >= 2) {
            jinqiu1 = [array objectAtIndex:0];
            jinqiu2 = [array objectAtIndex:1];
        }
		
		
		if ([jinqiu1 rangeOfString:@"0"].location !=NSNotFound) {
			jinqiu0Label1.text = @"0";
			//jinqiu0Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu0Label1.text = nil;
			//jinqiu0Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu1 rangeOfString:@"1"].location !=NSNotFound) {
			jinqiu1Label1.text = @"1";
			//jinqiu1Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu1Label1.text = nil;
			//jinqiu1Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu1 rangeOfString:@"2"].location !=NSNotFound) {
			jinqiu2Label1.text = @"2";
			//jinqiu2Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu2Label1.text = nil;
			//jinqiu2Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu1 rangeOfString:@"3"].location !=NSNotFound) {
			jinqiu3Label1.text = @"3+";
			//jinqiu3Label1.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu3Label1.text = nil;
			//jinqiu3Label1.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"0"].location !=NSNotFound) {
			jinqiu0Label2.text = @"0";
			//jinqiu0Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu0Label2.text = nil;
			//jinqiu0Label2.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"1"].location !=NSNotFound) {
			jinqiu1Label2.text = @"1";
			//jinqiu1Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu1Label2.text = nil;
			//jinqiu1Label2.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"2"].location !=NSNotFound) {
			jinqiu2Label2.text = @"2";
			//jinqiu2Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu2Label2.text = nil;
			//jinqiu2Label2.backgroundColor = [UIColor clearColor];
 		}
		
		if ([jinqiu2 rangeOfString:@"3"].location !=NSNotFound) {
			jinqiu3Label2.text = @"3+";
			//jinqiu3Label2.backgroundColor = [UIColor redColor];
		}
		else {
			jinqiu3Label2.text = nil;
			//jinqiu3Label2.backgroundColor = [UIColor clearColor];
 		}
		
		NSArray *duizhen = [[dic objectForKey:duizhenKey] componentsSeparatedByString:@"VS"];
        if ([duizhen count] >= 2) {
            duizhenLabel1.text = [duizhen objectAtIndex:0];
            duizhenLabel2.text = [duizhen objectAtIndex:1];
        }else{
            duizhenLabel1.text = @"";
            duizhenLabel2.text = @"";
        }
		
		numLabel1.frame = CGRectMake(2, 0, 40, 20);
		numLabel2.frame = CGRectMake(2, 21, 40, 20);
		
		saishiLabel1.frame = CGRectMake(43, 0, 60, 40);
		
		duizhenLabel1.frame = CGRectMake(104, 0, 80, 20);
		duizhenLabel2.frame = CGRectMake(104, 21, 80, 20);
		
		jinqiu0Label1.frame = CGRectMake(185, 0, 30, 20);
		jinqiu0Label2.frame = CGRectMake(185, 21, 30, 20);
		
		jinqiu1Label1.frame = CGRectMake(216, 0, 30, 20);
		jinqiu1Label2.frame = CGRectMake(216, 21, 30, 20);
		
		jinqiu2Label1.frame = CGRectMake(247, 0, 30, 20);
		jinqiu2Label2.frame = CGRectMake(247, 21, 30, 20);
		
		jinqiu3Label1.frame = CGRectMake(278, 0, 30, 20);
		jinqiu3Label2.frame = CGRectMake(278, 21, 30, 20);
		
	}

}

- (void)dealloc {
	[numLabel1 release];
	[saishiLabel1 release];
	[duizhenLabel1 release];
	[jinqiu0Label1 release];
	[jinqiu1Label1 release];
	[jinqiu2Label1 release];
	[jinqiu3Label1 release];
	
	[numLabel2 release];
	[duizhenLabel2 release];
	[jinqiu0Label2 release];
	[jinqiu1Label2 release];
	[jinqiu2Label2 release];
	[jinqiu3Label2 release];
	
	[shuxianView1 release];
	[shuxianView2 release];
	[shuxianView3 release];
	[shuxianView4 release];
	[shuxianView5 release];
	[shuxianView6 release];
	
	[hengxianView1 release];
	[hengxianView2 release];
	[hengxianView3 release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
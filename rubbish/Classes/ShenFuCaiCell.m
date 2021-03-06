//
//  ShenFuCaiCell.m
//  caibo
//
//  Created by yao on 12-5-8.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ShenFuCaiCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation ShenFuCaiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		numLabel = [[UILabel alloc] init];
		numLabel.backgroundColor = [UIColor clearColor];
		numLabel.font = [UIFont systemFontOfSize:13];
		numLabel.textAlignment = NSTextAlignmentCenter;
		numLabel.numberOfLines = 0;
        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 2.0;
        numLabel.textColor =[UIColor blackColor];
		numLabel.frame = CGRectMake(3, 0, 40, 20);
		[self.contentView addSubview:numLabel];
		
		saishiLabel = [[UILabel alloc] init];
		saishiLabel.backgroundColor = [UIColor clearColor];
		saishiLabel.font = [UIFont systemFontOfSize:13];
		saishiLabel.textAlignment = NSTextAlignmentCenter;
        saishiLabel.layer.masksToBounds = YES;
        saishiLabel.layer.cornerRadius = 2.0;
		saishiLabel.frame = CGRectMake(44, 0, 50, 20);
		[self.contentView addSubview:saishiLabel];
		
		duizhenLabel = [[UILabel alloc] init];
		duizhenLabel.backgroundColor = [UIColor clearColor];
		duizhenLabel.font = [UIFont systemFontOfSize:13];
		duizhenLabel.textAlignment = NSTextAlignmentCenter;
		duizhenLabel.frame = CGRectMake(95, 0, 135, 20);
        duizhenLabel.layer.masksToBounds = YES;
        duizhenLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:duizhenLabel];
		
		shengLabel = [[UILabel alloc] init];
		shengLabel.backgroundColor = [UIColor clearColor];
		shengLabel.font = [UIFont boldSystemFontOfSize:13];
		shengLabel.textAlignment = NSTextAlignmentCenter;
		shengLabel.frame = CGRectMake(231, 0, 24, 20);
        shengLabel.layer.masksToBounds = YES;
        shengLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:shengLabel];
		
		pingLabel = [[UILabel alloc] init];
		pingLabel.backgroundColor = [UIColor clearColor];
		pingLabel.font = [UIFont boldSystemFontOfSize:13];
		pingLabel.textAlignment = NSTextAlignmentCenter;
		pingLabel.frame = CGRectMake(256, 0, 24, 20);
        pingLabel.layer.masksToBounds = YES;
        pingLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:pingLabel];
		
		fuLabel = [[UILabel alloc] init];
		fuLabel.backgroundColor = [UIColor clearColor];
		fuLabel.font = [UIFont boldSystemFontOfSize:13];
		fuLabel.textAlignment = NSTextAlignmentCenter;
		fuLabel.frame = CGRectMake(281, 0, 24, 20);
        fuLabel.layer.masksToBounds = YES;
        fuLabel.layer.cornerRadius = 2.0;
		[self.contentView addSubview:fuLabel];
		
		self.contentView.backgroundColor = [UIColor whiteColor];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setLabelColor:(UIColor *)_color {
    numLabel.backgroundColor = _color;
    saishiLabel.backgroundColor = _color;
    duizhenLabel.backgroundColor = _color;
    shengLabel.backgroundColor = _color;
    pingLabel.backgroundColor = _color;
    fuLabel.backgroundColor = _color;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}
- (void)LoadData:(NSDictionary *)dic{
	numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"no"]];
	saishiLabel.text = [dic objectForKey:@"leagueName"];
	duizhenLabel.text = [dic objectForKey:@"changCi"];
	if ( [[dic objectForKey:@"touZhu"] rangeOfString:@"3"].location != NSNotFound) {
		shengLabel.text = @"3";
		//shengLabel.backgroundColor = [UIColor redColor];
	}
	else {
		shengLabel.text = nil;
		shengLabel.backgroundColor = [UIColor clearColor];
	}
	
	if ( [[dic objectForKey:@"touZhu"] rangeOfString:@"1"].location != NSNotFound) {
		pingLabel.text = @"1";
		//pingLabel.backgroundColor = [UIColor redColor];
	}
	else {
		pingLabel.text = nil;
		pingLabel.backgroundColor = [UIColor clearColor];
	}
	
	if ( [[dic objectForKey:@"touZhu"] rangeOfString:@"0"].location != NSNotFound) {
		fuLabel.text = @"0";
		//fuLabel.backgroundColor = [UIColor redColor];
	}
	else {
		fuLabel.text = nil;
		fuLabel.backgroundColor = [UIColor clearColor];
	}
	if ([[dic objectForKey:@"touZhu"] intValue] == 4) {
		self.contentView.backgroundColor = [UIColor lightGrayColor];
		shengLabel.text = @"-";
		pingLabel.text = @"-";
		fuLabel.text = @"-";
	}
	else {
		self.contentView.backgroundColor = [UIColor whiteColor];
	}

	
}


- (void)dealloc {
	[shuxianView1 release];
	[shuxianView2 release];
	[shuxianView3 release];
	[shuxianView4 release];
	[shuxianView5 release];
	[hengxianView release];
	[numLabel release];
	[saishiLabel release];
	[duizhenLabel release];
	[shengLabel release];
	[pingLabel release];
	[fuLabel release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
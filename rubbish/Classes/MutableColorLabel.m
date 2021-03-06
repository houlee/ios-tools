//
//  MutableColorLable.m
//  Walker
//
//  Created by yao on 11-5-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MutableColorLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation MutableColorLabel

@synthesize type;
@synthesize delegate;
@synthesize myColor;
- (id)init {
	self = [super init];
	if (self) {
		//self.userInteractionEnabled = YES;
	}
	return self;
}

- (void)setSubColor:(UIColor *)color{
	self.backgroundColor = [UIColor clearColor];//add 2010.05.20
	if (self.text == nil||[self.text isEqualToString:@""]) {
		return;
	}
	NSInteger tagused = self.type;
	// 将所有的 */ 都换成 /*
	NSString *stringForSelf = [self.text stringByReplacingOccurrencesOfString:@"*/" withString:@"/*"];
	self.text = stringForSelf;
	NSMutableString *stringForTextInOne = [NSMutableString stringWithString:stringForSelf];
	NSArray *detailTradItems = [self.text componentsSeparatedByString:@"/*"];
	if ([detailTradItems count] <= 1)	{
		
		return;
	}
	NSMutableString *textForCardName =[NSMutableString stringWithString:@""];
	NSMutableArray *arrayForString = [[NSMutableArray alloc] init];
	for (int i = 0; i < [detailTradItems count];i++) {
		// 去掉/*后赋值给textForCardName
		[textForCardName appendString:[detailTradItems objectAtIndex:i]];
	}
	NSMutableString *stringForText = [NSMutableString stringWithString:textForCardName];
	self.text = stringForText;
	// 行数默认未1
	NSInteger lines = 1;
	for (int i = 0;i < [stringForText length];i++) {
		NSString *stringForTemp = [stringForText substringToIndex:i];
		float lengthForString = [stringForTemp sizeWithFont:self.font].width;
		if (lengthForString > self.frame.size.width) {
			// 计算行数及换行位置
			lines ++ ;
			[arrayForString addObject:[NSMutableString stringWithString:[stringForText substringToIndex:i-1]]];
			stringForText = [NSMutableString stringWithString:[stringForText substringFromIndex:i-1]];
		}
	}	
	// 将所有行拆开 并 存入数组
	[arrayForString addObject:stringForText];
	for (int i = 0,j=0;i<[arrayForString count];i++) {
		NSMutableString *string = [arrayForString objectAtIndex:i];
		for (int i = 0;i<[string length];i++) {
			if ([string characterAtIndex:i]!=[stringForTextInOne characterAtIndex:j]) {
				// 将/* 插会它的原位置，以便分行变色
				[string insertString:@"/*" atIndex:i];
			}
			j++;
		}
		
	}
	if (lines != 1) {
		// 多行变色
		NSInteger tagForLine = 3;
		for (int i = 0;i < [arrayForString count];i++) {
			float xForCard = 0;
			float widthForCard = self.frame.size.width;
			float heightForLabel;
			if (self.frame.size.height < [@"YFY" sizeWithFont:self.font].height) {
				heightForLabel = self.frame.size.height;
			}
			else {
				heightForLabel = [@"YFY" sizeWithFont:self.font].height;
			}
			MutableColorLabel *labelForLine = [[MutableColorLabel alloc] 
									 initWithFrame:CGRectMake(xForCard, 
															  (self.frame.size.height - heightForLabel*lines ) / 2 + heightForLabel * i,
															  widthForCard,
															  heightForLabel)];
			labelForLine.textColor = self.textColor;
			labelForLine.font = self.font;
			labelForLine.text = [arrayForString objectAtIndex:i];
			if (i == 0) {
				labelForLine.type = 0;
			}
			if (tagForLine == 0) {
				// 有/* 没有处理
				labelForLine.type = 0;
			}
			else {
				labelForLine.type = 1;
			}
			[labelForLine setSubColor:color];
			tagForLine =labelForLine.tag;
			[self addSubview:labelForLine];
            [labelForLine release];
		}
		self.type = tagused;
	}
	else{
		// 当行变色，两种状态切换 一种是，开始就变色，以 /*为间隔恢复颜色，变色循环
//		if (self.type != 0 && self.type != 1) {
//			self.type = 0;
//		}
		for (int i =self.type;i<[detailTradItems count];i = i+2) {
			
			MutableColorLabel *card = [[MutableColorLabel alloc]init];
			card.font = self.font;
			card.backgroundColor = self.backgroundColor;
			
			self.text = textForCardName;
			NSString *details = (NSString *)[detailTradItems objectAtIndex:i];
			card.text = details;
			float xForCard = 0;
			if (self.type == 1 || i != 0) {
				NSMutableString *string = [NSMutableString stringWithString:@""];
				for (int k = 0;k < i;k ++) {
					[string appendString:[detailTradItems objectAtIndex:k]];
				}
				xForCard = [string sizeWithFont:self.font].width;
			}
			float widthForCard = [details sizeWithFont:self.font].width;
			float heightForLabel;
			
			if (self.frame.size.height < [@"YFY" sizeWithFont:self.font].height) {
				heightForLabel = self.frame.size.height;
			}
			else {
				heightForLabel = [@"YFY" sizeWithFont:self.font].height;
			}
			card.frame = CGRectMake(xForCard, 
									(self.frame.size.height - heightForLabel*lines ) / 2, 
									widthForCard,
									heightForLabel);
			card.textColor = color;
			[self addSubview:card];
			[card release];
			
		}
		if ([detailTradItems count]%2 == 0) {
			//余有“/*”未处理
		}
		else {
			//之前的／*都处理了
			if (!self.type) {
				self.type = YES;
			}
			else {
				self.type = NO;
			}
		}
	}
	[arrayForString release];
	if (lines > 1) {
		self.textColor = [UIColor clearColor];
	}
	self.text = [self.text stringByReplacingOccurrencesOfString:@"/*" withString:@""];
	// 将基础的label去掉//
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UIColor *clor = [UIColor colorWithCGColor:self.textColor.CGColor];
	self.myColor = clor;
	self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.5];
	self.textColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	self.textColor = self.myColor;
	self.backgroundColor = [UIColor clearColor];
	if (delegate) {
		[delegate touchLabel:self];
	}
}

- (void)setText:(NSString *)string {
	[super setText:string];
	if (delegate) {
		int a = [string sizeWithFont:self.font].width;
		if ( a>233 && self.tag ==21112) {
			a = 233;
		}
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, a, self.frame.size.height);
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	self.backgroundColor = [UIColor clearColor];
	self.textColor = self.myColor;
}

- (void)dealloc {
	[myColor release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
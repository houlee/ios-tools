//
//  BudgeButton.m
//  caibo
//
//  Created by jacob on 11-8-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BudgeButton.h"
#import "DataUtils.h"

static UIImage* budgeIcon = nil;


@interface BudgeButton(Private)
+ (UIImage*)budgeImage;
@end



@implementation BudgeButton

@synthesize budegeValue;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
    }
    return self;
}


-(CGRect)budegeBounds{
	
	CGRect budebounds;

	if (self.frame.size.width<=23) {
		
		budebounds.size.width =23;
		
	}else  if (self.frame.size.width>23) {
		
		budebounds.size.width =self.frame.size.width;
		
	}

	return budebounds;

}


// 传入 budegeValue 值
-(void)setBudegeValue:(NSString *)value{
	
	if (value) {
		
		[budegeValue release];
	
		budegeValue = [value retain];
		
		textWith = [DataUtils textWidth:value Fontsize:10.0];
		
	}else {
	    [budegeValue release];
		budegeValue =nil;
		textWith =0;
	}
	
    [super setNeedsDisplay];
}






// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	UIColor *budeTextColor = [UIColor whiteColor];
	
	UIImage *budge = [BudgeButton budgeImage];
	
	CGRect budgeBounds = [self budegeBounds];
	
	[budge drawInRect:CGRectMake(0, 0, budgeBounds.size.width, budge.size.height)];
	
	if (budegeValue) {
		
		[budeTextColor set];
		
		[budegeValue drawAtPoint:CGPointMake(budgeBounds.size.width/2-textWith/2, budge.size.height/2-8) withFont:[UIFont systemFontOfSize:10]];
		
	}
	
}


+ (UIImage*)budgeImage
{           
    if (budgeIcon ==nil) {
		
        UIImage *i = UIImageGetImageFromName(@"budgevalue.png");
		
        budgeIcon = [[i stretchableImageWithLeftCapWidth:12 topCapHeight:5] retain];
    }
    return budgeIcon;
}



- (void)dealloc {
	
	[budegeValue release];
	budegeValue =nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
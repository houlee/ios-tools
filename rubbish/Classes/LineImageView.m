//
//  LineImageView.m
//  caibo
//
//  Created by yao on 12-6-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "LineImageView.h"


@implementation LineImageView

@synthesize dataArray;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
        // Initialization code.
		self.dataArray = [NSMutableArray array];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//[super drawRect:rect];
	[[UIImageGetImageFromName(@"zoushibiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0] drawInRect:self.bounds];
	for (int i = 0; i<[dataArray count]-1; i++) {
	//	if ([dataArray count]) {
			CGPoint point1,point2;
        if ([[[dataArray objectAtIndex:i] componentsSeparatedByString:@","] count] > 1) {
            point1.x = [[[[dataArray objectAtIndex:i] componentsSeparatedByString:@","] objectAtIndex:0] floatValue];
            point1.y = [[[[dataArray objectAtIndex:i] componentsSeparatedByString:@","] objectAtIndex:1] floatValue];
        }
			
        if ([[[dataArray objectAtIndex:i+1] componentsSeparatedByString:@","] count] > 1) {
            point2.x = [[[[dataArray objectAtIndex:i+1] componentsSeparatedByString:@","] objectAtIndex:0] floatValue];
            point2.y = [[[[dataArray objectAtIndex:i + 1] componentsSeparatedByString:@","] objectAtIndex:1] floatValue];
        }
			
			CGContextRef context = UIGraphicsGetCurrentContext();
			CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
			CGContextSetLineWidth(context, 0.5);
			CGContextSetAllowsAntialiasing(context, false);
			
			CGContextMoveToPoint(context, point1.x, point1.y);
			CGContextAddLineToPoint(context, point2.x, point2.y);
			CGContextStrokePath(context);
	//	}
	}
}

- (void)myScrolChange:(NSArray *)array IsHome:(BOOL)ishome TeamID:(NSInteger)ID {
	if (ishome) {
		for (int i = 0; i <[array count]; i++) {
			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];
			
			UILabel *v3 = (UILabel *)[self viewWithTag:i +3000];
			if (!v3) {
				v3 = [[UILabel alloc] init];
				v3.tag = i+3000;
				
				v3.textAlignment = NSTextAlignmentCenter;
				[self addSubview:v3];
				v3.font = [UIFont systemFontOfSize:15];
				v3.backgroundColor = [UIColor whiteColor];
				[v3 release];
			}
			
			UIImageView *imageV1 = (UIImageView *)[self viewWithTag:i+4000];
			if (!imageV1) {
				imageV1 = [[UIImageView alloc] init];
				[self addSubview:imageV1];
				imageV1.tag = i+4000;
				[imageV1 release];
			}
			imageV1 = (UIImageView *)[self viewWithTag:i+4000];
			int b ;
			int c;
			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
				b = 0;
			}
			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
				b=1;
			}
			else {
				b =2;
			}
			if ([[dataDic objectForKey:@"hostid"] intValue] == ID) {
				c = 0;
			}
			else {
				c = 1;
			}
			imageV1.frame = CGRectMake(-4+40*i, -4+b*30, 8, 8);
			NSString *point = [NSString stringWithFormat:@"%f,%f",imageV1.center.x ,imageV1.center.y];
			[self.dataArray addObject:point];
			NSString *imageName = nil;
			switch (b) {
				case 0:
					imageName = @"red";
					break;
				case 1:
					imageName = @"black";
					break;
				case 2:
					imageName = @"bule";
					break;
				default:
					break;
			}
			switch (c) {
				case 0:
					imageName = [NSString stringWithFormat:@"%@Three.png",imageName];
					break;
				case 1:
					imageName = [NSString stringWithFormat:@"%@Point.png",imageName];
					break;
					
				default:
					break;
			}
			imageV1.image = UIImageGetImageFromName(imageName);
			UIView *v4 = [self viewWithTag:5000+i];
			if (!v4) {
				v4 = [[UIView alloc] init];
				v4.tag = 5000+i;
				[self addSubview:v4];
				v4.backgroundColor = [UIColor lightGrayColor];
				[v4 release];
			}
			v4 = [self viewWithTag:5000+i];
			v4.frame = CGRectMake(40*i,0 , 1, 22);
		}
	}	
	else {		
		for (int i = 0; i <[array count]; i++) {
			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];			
			UIImageView *imageV1 = (UIImageView *)[self viewWithTag:i+4000];
			if (!imageV1) {
				imageV1 = [[UIImageView alloc] init];
				[self addSubview:imageV1];
				imageV1.tag = i+4000;
				[imageV1 release];
			}
			imageV1 = (UIImageView *)[self viewWithTag:i+4000];
			NSString *point = [NSString stringWithFormat:@"%f,%f",imageV1.center.x ,imageV1.center.y];
			[self.dataArray addObject:point];
			int b ;
			int c;
			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
				b = 0;
			}
			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
				b=1;
			}
			else {
				b =2;
			}
			if ([[dataDic objectForKey:@"hostid"] intValue] == ID) {
				c = 0;
			}
			else {
				c = 1;
			}
			
			imageV1.frame = CGRectMake(-4+40*i, -4+b*30, 8, 8);
			
			
			NSString *imageName = nil;
			switch (b) {
				case 0:
					imageName = @"red";
					break;
				case 1:
					imageName = @"black";
					break;
				case 2:
					imageName = @"bule";
					break;
				default:
					break;
			}
			switch (c) {
				case 0:
					imageName = [NSString stringWithFormat:@"%@Three.png",imageName];
					break;
				case 1:
					imageName = [NSString stringWithFormat:@"%@Point.png",imageName];
					break;
					
				default:
					break;
			}
			imageV1.image = UIImageGetImageFromName(imageName);
			
			UIView *v4 = [self viewWithTag:5000+i];
			if (!v4) {
				v4 = [[UIView alloc] init];
				v4.tag = 5000+i;
				[self addSubview:v4];
				v4.backgroundColor = [UIColor lightGrayColor];
				[v4 release];
			}
			v4 = [self viewWithTag:5000+i];
			v4.frame = CGRectMake(40*i,72 , 1, 22);
		}
	}
	
	//[self drawRect:self.bounds];
}


- (void)dealloc {
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
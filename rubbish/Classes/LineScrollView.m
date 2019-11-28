//
//  LineScrollView.m
//  caibo
//
//  Created by yao on 12-6-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "LineScrollView.h"

@implementation LineScrollView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		imageV = [[LineImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:imageV];
		//imageV.image = [UIImageGetImageFromName(@"zoushibiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
		imageV.tag =3999; 
		[imageV release];
        // Initialization code.
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
	//v1比分。v2对手，v3轮次
	//[super drawRect:rect];
//	[imageV.image drawInRect:imageV.frame];
//	if (ishome) {		
//		for (int i = 0; i <[array count]; i++) {
//			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];
//	
//			int b ;
//			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
//				b = 0;
//			}
//			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
//				b=1;
//			}
//			else {
//				b =2;
//			}
//			if (i+1<[array count]) {
//				NSDictionary *dataDic2 = [array objectAtIndex:([array count]-(i + 1)-1)];
//				int d ;
//				if ([[dataDic2 objectForKey:@"result"] isEqualToString:@"胜"]) {
//					d = 0;
//				}
//				else if ([[dataDic2 objectForKey:@"result"] isEqualToString:@"平"]) {
//					d=1;
//				}
//				else {
//					d =2;
//				}
//				CGContextRef context = UIGraphicsGetCurrentContext();
//				CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
//				CGContextSetLineWidth(context, 0.5);
//				CGContextSetAllowsAntialiasing(context, false);
//				
//				// Draw a single line from left to right
//				CGContextMoveToPoint(context, 17 +40*i, 32 +30*b);
//				CGContextAddLineToPoint(context, 17 +40*(i +1), 32 +30*d);
//				CGContextStrokePath(context);
//			}
//		}
//	}	
//	else {
//		for (int i = 0; i <[array count]; i++) {
//			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];
//			int b ;
//			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
//				b = 0;
//			}
//			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
//				b=1;
//			}
//			else {
//				b =2;
//			}			
//			if (i+1<[array count]) {
//				NSDictionary *dataDic2 = [array objectAtIndex:([array count]-(i + 1)-1)];
//				int d ;
//				if ([[dataDic2 objectForKey:@"result"] isEqualToString:@"胜"]) {
//					d = 0;
//				}
//				else if ([[dataDic2 objectForKey:@"result"] isEqualToString:@"平"]) {
//					d=1;
//				}
//				else {
//					d =2;
//				}
//				CGContextRef context = UIGraphicsGetCurrentContext();
//				CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
//				CGContextSetLineWidth(context, 0.5);
//				CGContextSetAllowsAntialiasing(context, false);
//				
//				// Draw a single line from left to right
//				CGContextMoveToPoint(context, 17 +40*i, 5 +30*b);
//				CGContextAddLineToPoint(context, 17 +40*(i +1), 5 +30*d);
//				CGContextStrokePath(context);
//			}
//			
//		}
//	}
//}

- (void)myScrolChange:(NSArray *)dataarray IsHome:(BOOL)dataishome TeamID:(NSInteger)dataID {
	array = [dataarray retain];
	ishome = dataishome;
	ID = dataID;
	if (ishome) {
		imageV.frame = CGRectMake(17, 32, self.contentSize.width - 38, 60);
		
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
			
			v3 = (UILabel *)[self viewWithTag:3000+i];
			v3.frame = CGRectMake(0+40*i, 2, 40, 20);
			
			if ([[dataDic objectForKey:@"liansailc"] length]>2) {
				v3.text =[[dataDic objectForKey:@"liansailc"] substringFromIndex:[[dataDic objectForKey:@"liansailc"] length] -2];
			}
			else {
				v3.text =[dataDic objectForKey:@"liansailc"];
			}
			
			
			UIImageView *imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
			if (!imageV1) {
				imageV1 = [[UIImageView alloc] init];
				[imageV addSubview:imageV1];
				imageV1.tag = i+4000;
				[imageV1 release];
			}
			imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
			int b ;
			int c;
			int d;
			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
				b = 0;
				d = 1;
			}
			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
				b=1;
				d = 0;
			}
			else {
				b =2;
				d = -1;
			}
			if ([[dataDic objectForKey:@"hostid"] intValue] == ID) {
				c = 0;
			}
			else {
				c = 1;
			}
			imageV1.frame = CGRectMake(-4+40*i, -4+b*30, 8, 8);
			NSString *ponti = [NSString stringWithFormat:@"%f,%f",imageV1.center.x,imageV1.center.y +d];
			[imageV.dataArray addObject:ponti];
			
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

		imageV.frame = CGRectMake(17, 5, self.contentSize.width - 38, 60);
		
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
			
			
			v3 = (UILabel *)[self viewWithTag:3000+i];
			v3.frame = CGRectMake(0+40*i, 75, 40, 20);
			if ([[dataDic objectForKey:@"liansailc"] length]>2) {
				v3.text =[[dataDic objectForKey:@"liansailc"] substringFromIndex:[[dataDic objectForKey:@"liansailc"] length] -2];
			}
			else {
				v3.text =[dataDic objectForKey:@"liansailc"];
			}
			
			UIImageView *imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
			if (!imageV1) {
				imageV1 = [[UIImageView alloc] init];
				[imageV addSubview:imageV1];
				imageV1.tag = i+4000;
				[imageV1 release];
			}
			imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
			int b ;
			int c;
			int d;
			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
				b = 0;
				d = 1;
			}
			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
				b=1;
				d = 0;
			}
			else {
				b =2;
				d = -1;
			}
			if ([[dataDic objectForKey:@"hostid"] intValue] == ID) {
				c = 0;
			}
			else {
				c = 1;
			}
			
			imageV1.frame = CGRectMake(-4+40*i, -4+b*30, 8, 8);
			
			NSString *ponti = [NSString stringWithFormat:@"%f,%f",imageV1.center.x,imageV1.center.y +d];
			[imageV.dataArray addObject:ponti];
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
//	[imageV drawRect:imageV.bounds];
//	[self sendSubviewToBack:imageV];
	//[self drawRect:self.bounds];	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[array release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  ZhanjiCell.m
//  caibo
//
//  Created by yao on 12-5-3.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ZhanjiCell.h"

@implementation ZhanjiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		titileBackView = [[UIView alloc] init];
		[self.contentView addSubview:titileBackView];
		titileBackView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
		
		myScrol = [[LineScrollView alloc] init];
		myScrol.backgroundColor = [UIColor whiteColor];
		myScrol.delegate = self;
		[myScrol setShowsHorizontalScrollIndicator:NO];
		[myScrol setBounces:NO];
		[self.contentView addSubview:myScrol];
		nameLabel = [[UILabel alloc] init];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.textColor = [UIColor colorWithRed:113/255.0 green:42/255.0 blue:0 alpha:1.0];
		[self.contentView addSubview:nameLabel];
//		scoreLabel = [[UILabel alloc] init];
//		scoreLabel.text = @"比分";
//		scoreLabel.font = [UIFont systemFontOfSize:15];
//		scoreLabel.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:scoreLabel];
		rowLabel = [[UILabel alloc] init];
		rowLabel.text = @"场次";
		rowLabel.font = [UIFont systemFontOfSize:15];
		rowLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:rowLabel];
		resultLabel = [[UILabel alloc] init];
		resultLabel.text = @"胜平负";
		resultLabel.font = [UIFont systemFontOfSize:15];
		resultLabel.backgroundColor = [UIColor clearColor];
		resultLabel.numberOfLines = 0;
		[self.contentView addSubview:resultLabel];
		
		titlLabel = [[UILabel alloc] init];
		titlLabel.text = @"战绩走势图";
		titlLabel.font = [UIFont systemFontOfSize:16];
		titlLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:titlLabel];
		
//		OpponentLabel = [[UILabel alloc] init];
//		OpponentLabel.text = @"对手";
//		OpponentLabel.font = [UIFont systemFontOfSize:15];
//		OpponentLabel.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:OpponentLabel];
		self.contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:243/255.0 blue:181/255.0 alpha:1];
		
		titileBackView2 = [[UIView alloc] init];
		[self.contentView addSubview:titileBackView2];
		titileBackView2.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
		
		footBackView2 = [[UIView alloc] init];
		[self.contentView addSubview:footBackView2];
		footBackView2.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
		
		myScrol2 = [[LineScrollView alloc] init];
		myScrol2.backgroundColor = [UIColor whiteColor];
		myScrol2.delegate = self;
		[myScrol2 setShowsHorizontalScrollIndicator:NO];
		[myScrol2 setBounces:NO];
		[self.contentView addSubview:myScrol2];
		nameLabel2 = [[UILabel alloc] init];
		nameLabel2.backgroundColor = [UIColor clearColor];
		nameLabel2.textColor = [UIColor colorWithRed:113/255.0 green:42/255.0 blue:0 alpha:1.0];
		[self.contentView addSubview:nameLabel2];
//		scoreLabel2 = [[UILabel alloc] init];
//		scoreLabel2.text = @"比分";
//		scoreLabel2.font = [UIFont systemFontOfSize:15];
//		scoreLabel2.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:scoreLabel2];
		rowLabel2 = [[UILabel alloc] init];
		rowLabel2.text = @"场次";
		rowLabel2.font = [UIFont systemFontOfSize:15];
		rowLabel2.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:rowLabel2];
		resultLabel2 = [[UILabel alloc] init];
		resultLabel2.text = @"胜平负";
		resultLabel2.font = [UIFont systemFontOfSize:15];
		resultLabel2.backgroundColor = [UIColor clearColor];
		resultLabel2.numberOfLines = 0;
		[self.contentView addSubview:resultLabel2];
		
		titlLabel2 = [[UILabel alloc] init];
		titlLabel2.text = @"战绩走势图";
		titlLabel2.font = [UIFont systemFontOfSize:16];
		titlLabel2.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:titlLabel2];
		
//		OpponentLabel2 = [[UILabel alloc] init];
//		OpponentLabel2.text = @"对手";
//		OpponentLabel2.font = [UIFont systemFontOfSize:15];
//		OpponentLabel2.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:OpponentLabel2];
		self.contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:243/255.0 blue:181/255.0 alpha:1];
        // Initialization code.
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		footBackView = [[UIView alloc] init];
		[self.contentView addSubview:footBackView];
		footBackView.userInteractionEnabled = NO;
		footBackView2.userInteractionEnabled = NO;
		footBackView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (scrollView == myScrol) {
		[myScrol2 scrollRectToVisible:CGRectMake(scrollView.contentOffset.x, 0, myScrol2.frame.size.width, myScrol2.frame.size.height) animated:NO];
	}
	else {
		[myScrol scrollRectToVisible:CGRectMake(scrollView.contentOffset.x, 0, myScrol.frame.size.width, myScrol.frame.size.height) animated:NO];
	}

}


- (void)myScrolChange:(NSArray *)array IsHome:(BOOL)ishome {
	
	//v1比分。v2对手，v3轮次
	if (ishome) {
		UIImageView *imageV = (UIImageView *)[myScrol viewWithTag:3999];
		if (!imageV) {
			imageV = [[UIImageView alloc] init];
			imageV.frame = CGRectMake(17, 32, myScrol.contentSize.width - 20, 60);
			imageV.image = [UIImageGetImageFromName(@"zoushibiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
			[myScrol addSubview:imageV];
			imageV.tag = 3999;
			[imageV release];
		}
		imageV = (UIImageView *)[myScrol viewWithTag:3999];
		imageV.frame = CGRectMake(17, 32, myScrol.contentSize.width - 38, 60);
		
		for (int i = 0; i <[array count]; i++) {
			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];
//			UILabel *v1 = (UILabel *)[myScrol viewWithTag:i+1000 ];
//			if (!v1) {
//				v1 = [[UILabel alloc] init];
//				v1.tag = i+1000;
//				
//				v1.backgroundColor = [UIColor whiteColor];
//				v1.font = [UIFont systemFontOfSize:15];
//				v1.textAlignment = NSTextAlignmentCenter;
//				[myScrol addSubview:v1];
//				[v1 release];
//			}
//			v1 = (UILabel *)[myScrol viewWithTag:i+1000];
//			v1.frame = CGRectMake(0+40*i, 2, 40, 20);
//			v1.text =[dataDic objectForKey:@"score"];
//			UILabel *v2 = (UILabel *)[myScrol viewWithTag:i +2000];
//			if (!v2) {
//				v2 = [[UILabel alloc] init];
//				v2.tag = i+2000;
//				
//				v2.font = [UIFont systemFontOfSize:14];
//				v2.numberOfLines = 0;
//				[myScrol addSubview:v2];
//				v2.backgroundColor = [UIColor whiteColor];
//				v2.textAlignment = NSTextAlignmentCenter;
//				[v2 release];
//			}
//			
//			v2 = (UILabel *)[myScrol viewWithTag:i+2000];
//			v2.frame = CGRectMake(10+40*i, 25, 20, 70);
//			if ([[dataDic objectForKey:@"guestid"] intValue]== ID) {
//				v2.text =[dataDic objectForKey:@"hostname"];
//			}
//			else {
//				v2.text =[dataDic objectForKey:@"guestname"];
//			}
			
			UILabel *v3 = (UILabel *)[myScrol viewWithTag:i +3000];
			if (!v3) {
				v3 = [[UILabel alloc] init];
				v3.tag = i+3000;
				
				v3.textAlignment = NSTextAlignmentCenter;
				[myScrol addSubview:v3];
				v3.font = [UIFont systemFontOfSize:15];
				v3.backgroundColor = [UIColor whiteColor];
				[v3 release];
			}
			
			v3 = (UILabel *)[myScrol viewWithTag:3000+i];
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
			
			UIView *v4 = [myScrol viewWithTag:5000+i];
			if (!v4) {
				v4 = [[UIView alloc] init];
				v4.tag = 5000+i;
				[myScrol addSubview:v4];
				v4.backgroundColor = [UIColor lightGrayColor];
				[v4 release];
			}
			v4 = [myScrol viewWithTag:5000+i];
			v4.frame = CGRectMake(40*i,0 , 1, 22);
		}
	}	
	else {
		UIImageView *imageV = (UIImageView *)[myScrol2 viewWithTag:3999];
		
		if (!imageV) {
			imageV = [[UIImageView alloc] init];
			imageV.image = [UIImageGetImageFromName(@"zoushibiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
			[myScrol2 addSubview:imageV];
			imageV.tag = 3999;
			[imageV release];
		}
		imageV = (UIImageView *)[myScrol2 viewWithTag:3999];
		imageV.frame = CGRectMake(17, 5, myScrol2.contentSize.width - 38, 60);
		
		for (int i = 0; i <[array count]; i++) {
			NSDictionary *dataDic = [array objectAtIndex:([array count]-i-1)];
//			UILabel *v1 = (UILabel *)[myScrol2 viewWithTag:i+1000 ];
//			if (!v1) {
//				v1 = [[UILabel alloc] init];
//				v1.tag = i+1000;
//				
//				v1.backgroundColor = [UIColor whiteColor];
//				v1.font = [UIFont systemFontOfSize:15];
//				v1.textAlignment = NSTextAlignmentCenter;
//				[myScrol2 addSubview:v1];
//				[v1 release];
//			}
//			v1 = (UILabel *)[myScrol2 viewWithTag:i+1000];
//			v1.frame = CGRectMake(0+40*i, 75, 40, 20);
//			v1.text =[dataDic objectForKey:@"score"];
//			UILabel *v2 = (UILabel *)[myScrol2 viewWithTag:i +2000];
//			if (!v2) {
//				v2 = [[UILabel alloc] init];
//				v2.tag = i+2000;
//				
//				v2.font = [UIFont systemFontOfSize:14];
//				v2.numberOfLines = 0;
//				[myScrol2 addSubview:v2];
//				v2.backgroundColor = [UIColor whiteColor];
//				v2.textAlignment = NSTextAlignmentCenter;
//				[v2 release];
//			}
//			
//			v2 = (UILabel *)[myScrol2 viewWithTag:i+2000];
//			v2.frame = CGRectMake(10+40*i, 100, 20, 70);
//			if ([[dataDic objectForKey:@"guestid"] intValue]== ID) {
//				v2.text =[dataDic objectForKey:@"hostname"];
//			}
//			else {
//				v2.text =[dataDic objectForKey:@"guestname"];
//			}
			UILabel *v3 = (UILabel *)[myScrol2 viewWithTag:i +3000];
			if (!v3) {
				v3 = [[UILabel alloc] init];
				v3.tag = i+3000;
				
				v3.textAlignment = NSTextAlignmentCenter;
				[myScrol2 addSubview:v3];
				v3.font = [UIFont systemFontOfSize:15];
				v3.backgroundColor = [UIColor whiteColor];
				[v3 release];
			}
			
			v3 = (UILabel *)[myScrol2 viewWithTag:3000+i];
			v3.frame = CGRectMake(0+40*i, 75, 40, 20);
			if ([[dataDic objectForKey:@"liansailc"] length]>2) {
				v3.text =[[dataDic objectForKey:@"liansailc"] substringFromIndex:[[dataDic objectForKey:@"liansailc"] length] -2];
			}
			else {
				v3.text =[dataDic objectForKey:@"liansailc"];
			}
			
//			UIImageView *imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
//			if (!imageV1) {
//				imageV1 = [[UIImageView alloc] init];
//				[imageV addSubview:imageV1];
//				imageV1.tag = i+4000;
//				[imageV1 release];
//			}
//			imageV1 = (UIImageView *)[imageV viewWithTag:i+4000];
//			int b ;
//			int c;
//			if ([[dataDic objectForKey:@"result"] isEqualToString:@"胜"]) {
//				b = 0;
//			}
//			else if ([[dataDic objectForKey:@"result"] isEqualToString:@"平"]) {
//				b=1;
//			}
//			else {
//				b =2;
//			}
//			if ([[dataDic objectForKey:@"hostid"] intValue] == ID2) {
//				c = 0;
//			}
//			else {
//				c = 1;
//			}
//			imageV1.frame = CGRectMake(-4+40*i, -4+b*30, 8, 8);
//			NSString *point = [NSString stringWithFormat:@"%f,%f",imageV1.center.x ,imageV1.center.y];
//			[imageV.dataArray addObject:point];
//			NSString *imageName = nil;
//			switch (b) {
//				case 0:
//					imageName = @"red";
//					break;
//				case 1:
//					imageName = @"black";
//					break;
//				case 2:
//					imageName = @"bule";
//					break;
//				default:
//					break;
//			}
//			switch (c) {
//				case 0:
//					imageName = [NSString stringWithFormat:@"%@Three.png",imageName];
//					break;
//				case 1:
//					imageName = [NSString stringWithFormat:@"%@Point.png",imageName];
//					break;
//					
//				default:
//					break;
//			}
//			imageV1.image = UIImageGetImageFromName(imageName);
			
			UIView *v4 = [myScrol2 viewWithTag:5000+i];
			if (!v4) {
				v4 = [[UIView alloc] init];
				v4.tag = 5000+i;
				[myScrol2 addSubview:v4];
				v4.backgroundColor = [UIColor lightGrayColor];
				[v4 release];
			}
			v4 = [myScrol2 viewWithTag:5000+i];
			v4.frame = CGRectMake(40*i,72 , 1, 22);
		}
	}

}

//-(void)drawRect:(CGRect)rect {
//	//[super drawRect:rect];
//	
//	// Drawing lines with a white stroke color
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
//	CGContextSetLineWidth(context, 0.5);
//	CGContextSetAllowsAntialiasing(context, false);
//	
//	// Draw a single line from left to right
//	CGContextMoveToPoint(context, 100.0, 300.0);
//	CGContextAddLineToPoint(context, 310.0, 30.0);
//	CGContextStrokePath(context);
//	
//}

- (void)LoadData:(NSArray *)array IsHome:(BOOL) ishome WithID:(NSInteger)Id With:(NSString *)name{
	ID = Id;
	if (ishome) {
		titileBackView.frame = CGRectMake(0, 0, 320, 30);
		footBackView.frame = CGRectMake(0, 225, 320, 5);
		nameLabel.frame = CGRectMake(10, 5, 100, 20);
		nameLabel.text = name;
		titlLabel.frame = CGRectMake(15+[nameLabel.text sizeWithFont:nameLabel.font].width, 5, 100, 20);
		scoreLabel.frame = CGRectMake(5, 30, 40, 25);
		OpponentLabel.frame = CGRectMake(5, 80, 40, 25);
		rowLabel.frame = CGRectMake(5, 128, 40, 25);
		resultLabel.frame = CGRectMake(15, 160, 20, 60);
		myScrol .frame = CGRectMake(40, 30, 280, 195);
		myScrol.contentSize = CGSizeMake([array count]*40, 195);
		[self myScrolChange:array IsHome:ishome];
		UIView *v1 = [self.contentView viewWithTag:6001];
		if (!v1) {
			v1 = [[UIView alloc] init];
			v1.tag = 6001;
			[self.contentView addSubview:v1];
			v1.backgroundColor = [UIColor lightGrayColor];
			[v1 release];
		}
		v1 = [self.contentView viewWithTag:6001];
		v1.frame = CGRectMake(0,53 , 320, 1);
		
		UIView *v2 = [self.contentView viewWithTag:6002];
		if (!v2) {
			v2 = [[UIView alloc] init];
			v2.tag = 6002;
			[self.contentView addSubview:v2];
			v2.backgroundColor = [UIColor lightGrayColor];
			[v2 release];
		}
		v2 = [self.contentView viewWithTag:6002];
		v2.frame = CGRectMake(0,130 , 320, 1);
		
		UIView *v3 = [self.contentView viewWithTag:6003];
		if (!v3) {
			v3 = [[UIView alloc] init];
			v3.tag = 6003;
			[self.contentView addSubview:v3];
			v3.backgroundColor = [UIColor lightGrayColor];
			[v3 release];
		}
		v3 = [self.contentView viewWithTag:6003];
		v3.frame = CGRectMake(0,152 , 320, 1);
		
	}
	else {
		
		titileBackView.frame = CGRectMake(0, 200, 320, 30);
		footBackView.frame = CGRectMake(0, 0, 320, 5);
		nameLabel.frame = CGRectMake(5, 205, 100, 20);
		nameLabel.text = name;
		titlLabel.frame = CGRectMake(15+[nameLabel.text sizeWithFont:nameLabel.font].width, 205, 100, 20);
		rowLabel.frame = CGRectMake(5, 175, 40, 25);
		OpponentLabel.frame = CGRectMake(5, 125, 40, 25);
		scoreLabel.frame = CGRectMake(5, 77, 40, 25);
		resultLabel.frame = CGRectMake(15, 10, 20, 60);
		myScrol .frame = CGRectMake(40, 5, 280, 195);
		myScrol.contentSize = CGSizeMake([array count]*40, 195);
		[self myScrolChange:array IsHome:ishome];
		UIView *v1 = [self.contentView viewWithTag:6001];
		if (!v1) {
			v1 = [[UIView alloc] init];
			v1.tag = 6001;
			[self.contentView addSubview:v1];
			v1.backgroundColor = [UIColor lightGrayColor];
			[v1 release];
		}
		v1 = [self.contentView viewWithTag:6001];
		v1.frame = CGRectMake(0,176 , 320, 1);
		
		UIView *v2 = [self.contentView viewWithTag:6002];
		if (!v2) {
			v2 = [[UIView alloc] init];
			v2.tag = 6002;
			[self.contentView addSubview:v2];
			v2.backgroundColor = [UIColor lightGrayColor];
			[v2 release];
		}
		v2 = [self.contentView viewWithTag:6002];
		v2.frame = CGRectMake(0,99 , 320, 1);
		
		UIView *v3 = [self.contentView viewWithTag:6003];
		if (!v3) {
			v3 = [[UIView alloc] init];
			v3.tag = 6003;
			[self.contentView addSubview:v3];
			v3.backgroundColor = [UIColor lightGrayColor];
			[v3 release];
		}
		v3 = [self.contentView viewWithTag:6003];
		v3.frame = CGRectMake(0,77 , 320, 1);
	}
}

- (void)LoadData:(NSArray *)array 
		   Array:(NSArray *)array2 
		  IsHome:(BOOL) ishome 
		  WithID:(NSInteger)Id 
		 WithID2:(NSInteger)Id2 
		WithName:(NSString *)name
	   WithName2:(NSString *)name2 {
	
	ID = Id;
	ID2 = Id2;
	if ([array count]) {
		titileBackView.frame = CGRectMake(0, 0, 320, 30);
		footBackView.frame = CGRectMake(0, 130, 320, 5);
		nameLabel.frame = CGRectMake(10, 5, 100, 20);
		nameLabel.text = name;
		titlLabel.frame = CGRectMake(15+[nameLabel.text sizeWithFont:nameLabel.font].width, 5, 100, 20);
		scoreLabel.frame = CGRectMake(5, 30, 40, 25);
		OpponentLabel.frame = CGRectMake(5, 80, 40, 25);
		rowLabel.frame = CGRectMake(5, 30, 40, 25);
		resultLabel.frame = CGRectMake(15, 62, 20, 60);
		myScrol .frame = CGRectMake(40, 30, 280, 100);
		myScrol.contentSize = CGSizeMake([array count]*40, 100);
		[myScrol myScrolChange:array IsHome:ishome TeamID:ID];
        [myScrol scrollRectToVisible:CGRectMake([array count]*40 - 280, 0, 280, 95) animated:NO];
//		[self myScrolChange:array IsHome:ishome];
		UIView *v1 = [self.contentView viewWithTag:6001];
		if (!v1) {
			v1 = [[UIView alloc] init];
			v1.tag = 6001;
			[self.contentView addSubview:v1];
			v1.backgroundColor = [UIColor lightGrayColor];
			[v1 release];
		}
		v1 = [self.contentView viewWithTag:6001];
		v1.frame = CGRectMake(0,53 , 320, 1);
		
//		UIView *v2 = [self.contentView viewWithTag:6002];
//		if (!v2) {
//			v2 = [[UIView alloc] init];
//			v2.tag = 6002;
//			[self.contentView addSubview:v2];
//			v2.backgroundColor = [UIColor lightGrayColor];
//			[v2 release];
//		}
//		v2 = [self.contentView viewWithTag:6002];
//		v2.frame = CGRectMake(0,130 , 320, 1);
//		
//		UIView *v3 = [self.contentView viewWithTag:6003];
//		if (!v3) {
//			v3 = [[UIView alloc] init];
//			v3.tag = 6003;
//			[self.contentView addSubview:v3];
//			v3.backgroundColor = [UIColor lightGrayColor];
//			[v3 release];
//		}
//		v3 = [self.contentView viewWithTag:6003];
//		v3.frame = CGRectMake(0,152 , 320, 1);
		
	}
	if ([array2 count]) {
		
		titileBackView2.frame = CGRectMake(0, 100 +135, 320, 30);
		footBackView2.frame = CGRectMake(0, 0+135, 320, 5);
		nameLabel2.frame = CGRectMake(5, 105+135, 100, 20);
		nameLabel2.text = name2;
		titlLabel2.frame = CGRectMake(15+[nameLabel2.text sizeWithFont:nameLabel2.font].width, 105+135, 100, 20);
		rowLabel2.frame = CGRectMake(5, 77+135, 40, 25);
		OpponentLabel2.frame = CGRectMake(5, 125+135, 40, 25);
		scoreLabel2.frame = CGRectMake(5, 77+135, 40, 25);
		resultLabel2.frame = CGRectMake(15, 10+135, 20, 60);
		myScrol2.frame = CGRectMake(40, 5+135, 280, 95);
		myScrol2.contentSize = CGSizeMake([array2 count]*40, 95);
		[myScrol2 myScrolChange:array2 IsHome:!ishome TeamID:ID2];
        [myScrol2 scrollRectToVisible:CGRectMake([array2 count]*40 - 280, 0, 280, 95) animated:NO];
//		[self myScrolChange:array2 IsHome:!ishome];
//		UIView *v1 = [self.contentView viewWithTag:6101];
//		if (!v1) {
//			v1 = [[UIView alloc] init];
//			v1.tag = 6101;
//			[self.contentView addSubview:v1];
//			v1.backgroundColor = [UIColor lightGrayColor];
//			[v1 release];
//		}
//		v1 = [self.contentView viewWithTag:6101];
//		v1.frame = CGRectMake(0,176+135 , 320, 1);
		
		UIView *v2 = [self.contentView viewWithTag:6102];
		if (!v2) {
			v2 = [[UIView alloc] init];
			v2.tag = 6102;
			[self.contentView addSubview:v2];
			v2.backgroundColor = [UIColor lightGrayColor];
			[v2 release];
		}
		v2 = [self.contentView viewWithTag:6102];
		v2.frame = CGRectMake(0,99+135 , 320, 1);
		
		UIView *v3 = [self.contentView viewWithTag:6103];
		if (!v3) {
			v3 = [[UIView alloc] init];
			v3.tag = 6103;
			[self.contentView addSubview:v3];
			v3.backgroundColor = [UIColor lightGrayColor];
			[v3 release];
		}
		v3 = [self.contentView viewWithTag:6103];
		v3.frame = CGRectMake(0,77+135 , 320, 1);
	}
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[myScrol release];
	[nameLabel release];
	[titileBackView release];
	[rowLabel release];
	[resultLabel release];
	[scoreLabel release];
	[OpponentLabel release];
	
	[myScrol2 release];
	[nameLabel2 release];
	[titileBackView2 release];
	[rowLabel2 release];
	[resultLabel2 release];
	[scoreLabel2 release];
	[OpponentLabel2 release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
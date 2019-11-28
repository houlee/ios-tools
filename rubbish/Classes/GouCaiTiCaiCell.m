//
//  GouCaiTiCaiCell.m
//  caibo
//
//  Created by yao on 12-5-25.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GouCaiTiCaiCell.h"
#import "ShuangSeQiuInfoViewController.h"
#import "SharedMethod.h"
#import "SharedMethod.h"

@implementation GouCaiTiCaiCell
@synthesize wanfa;
@synthesize chuanfa;
@synthesize isJJYH;
@synthesize myMatchInfo;
@synthesize playId;
@synthesize shishiBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		isReload = NO;
//        backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 42)];
//		backImage.image = [UIImageGetImageFromName(@"zhuce-tongyixiyikuang_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//        self.backgroundColor = [UIColor clearColor];
//		[self.contentView insertSubview:backImage atIndex:0];
//		[backImage release];
        
        backImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 310, 70)];
		backImage1.image = [UIImageGetImageFromName(@"zhuce-tongyixiyikuang_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
		[self.contentView addSubview:backImage1];
		[backImage1 release];
        
//        rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(230, 0, 50, 36)];
//        rightImage.hidden = YES;
//        [backImage1 addSubview:rightImage];
//        [rightImage release];
        

        
        
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		label1 = [[UILabel alloc] init];
		label1.backgroundColor = [UIColor clearColor];
		label1.numberOfLines=0;
		label1.textAlignment = NSTextAlignmentCenter;
		label1.font = [UIFont systemFontOfSize:12];
		[backImage1 addSubview:label1];
		
		label2 = [[UILabel alloc] init];
		label2.backgroundColor = [UIColor clearColor];
		label2.numberOfLines=0;
		label2.textAlignment = NSTextAlignmentRight;
		label2.font = [UIFont systemFontOfSize:12];
		[backImage1 addSubview:label2];
		
		label3 = [[UILabel alloc] init];
		label3.backgroundColor = [UIColor clearColor];
		label3.numberOfLines=1;
        label3.lineBreakMode = NSLineBreakByWordWrapping;
		label3.textAlignment = NSTextAlignmentCenter;
		label3.font = [UIFont systemFontOfSize:14];
		[backImage1 addSubview:label3];
		
		label4 = [[UILabel alloc] init];
		label4.backgroundColor = [UIColor clearColor];
		label4.numberOfLines=0;
		label4.textAlignment = NSTextAlignmentCenter;
		label4.font = [UIFont systemFontOfSize:12];
		[backImage1 addSubview:label4];
		
		label5 = [[UILabel alloc] init];
		label5.backgroundColor = [UIColor clearColor];
		label5.numberOfLines=1;
		label5.textAlignment = NSTextAlignmentCenter;
        label5.lineBreakMode = NSLineBreakByWordWrapping;
		label5.font = [UIFont systemFontOfSize:14];
		[backImage1 addSubview:label5];
		
		label6 = [[UILabel alloc] init];
		label6.backgroundColor = [UIColor clearColor];
		label6.numberOfLines=0;
		label6.textAlignment = NSTextAlignmentCenter;
		label6.font = [UIFont systemFontOfSize:12];
		[backImage1 addSubview:label6];
		
		label7 = [[UILabel alloc] init];
		label7.backgroundColor = [UIColor clearColor];
		label7.textAlignment = NSTextAlignmentCenter;
		label7.font = [UIFont systemFontOfSize:14];
        label7.lineBreakMode = NSLineBreakByWordWrapping;
		label7.numberOfLines=1;
		[backImage1 addSubview:label7];
        
		label8 = [[UILabel alloc] init];
		label8.backgroundColor = [UIColor clearColor];
		label8.textAlignment = NSTextAlignmentCenter;
		label8.font = [UIFont systemFontOfSize:12];
		label8.numberOfLines=0;
		[backImage1 addSubview:label8];
        
        label9 = [[UILabel alloc] init];
		label9.backgroundColor = [UIColor clearColor];
		label9.textAlignment = NSTextAlignmentCenter;
		label9.font = [UIFont systemFontOfSize:14];
		label9.numberOfLines=0;
		[backImage1 addSubview:label9];
        
        label10 = [[UILabel alloc] init];
		label10.backgroundColor = [UIColor clearColor];
		label10.textAlignment = NSTextAlignmentCenter;
		label10.font = [UIFont systemFontOfSize:12];
		label10.numberOfLines=0;
		[backImage1 addSubview:label10];
        
        label11 = [[UILabel alloc] init];
		label11.backgroundColor = [UIColor clearColor];
		label11.textAlignment = NSTextAlignmentCenter;
		label11.font = [UIFont systemFontOfSize:12];
		label11.numberOfLines=0;
		[backImage1 addSubview:label11];
        
        label12 = [[UILabel alloc] init];
		label12.backgroundColor = [UIColor clearColor];
		label12.textAlignment = NSTextAlignmentCenter;
		label12.font = [UIFont systemFontOfSize:12];
		label12.numberOfLines=0;
		[backImage1 addSubview:label12];
        
		label13 = [[UILabel alloc] init];
		label13.backgroundColor = [UIColor clearColor];
		label13.numberOfLines=0;
		label13.textAlignment = NSTextAlignmentCenter;
		label13.font = [UIFont systemFontOfSize:15];
		[backImage1 addSubview:label13];
        
        label14 = [[UILabel alloc] init];
        label14.numberOfLines=0;
        label14.layer.cornerRadius = 3;
        label14.layer.masksToBounds = YES;
        label14.textAlignment = NSTextAlignmentCenter;
        label14.font = [UIFont systemFontOfSize:9];
        label14.textColor = [SharedMethod getColorByHexString:@"90a92a"];
        label14.backgroundColor = [SharedMethod getColorByHexString:@"def3d0"];
        label14.hidden = YES;
        [backImage1 addSubview:label14];
        
		
        //		UIImageView *xian = [[UIImageView alloc] init];
        //		xian.backgroundColor = [UIColor clearColor];
        //		xian.image = UIImageGetImageFromName(@"GC_hengxc_07.png");
        //		xian.frame = CGRectMake(2, 0, 301, 2);
        //		[backImage1 addSubview:xian];
        //		[xian release];
        
        danImage = [[UIImageView alloc] initWithFrame:CGRectMake(296, 0, 14, 14)];
        danImage.image = UIImageGetImageFromName(@"dan_info.png");
        [backImage1 addSubview:danImage];
        danImage.hidden = YES;
        [danImage release];
        
		
		[label1 release];
		[label2 release];
		[label3 release];
		[label4 release];
		[label5 release];
		[label6 release];
		[label7 release];
		[label8 release];
        [label9 release];
		[label10 release];
		[label11 release];
		[label12 release];
        [label13 release];
        
        line1= [[UIView alloc] init];
        line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [backImage1 addSubview:line1];
        [line1 release];
        
//        line2= [[UIView alloc] init];
//        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [backImage1 addSubview:line2];
//        [line2 release];
//
//        line3= [[UIView alloc] init];
//        line3.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [backImage1 addSubview:line3];
//        [line3 release];
//        
//        line3= [[UIView alloc] init];
//        line3.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [backImage1 addSubview:line3];
//        [line3 release];
//        
//        line4= [[UIView alloc] init];
//        line4.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [backImage1 addSubview:line4];
//        [line4 release];
//        
//        line5= [[UIView alloc] init];
//        line5.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [backImage1 addSubview:line5];
//        [line5 release];
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)LoadData:(NSString *)info Info:(NSString *)info2 LottoryType:(TiCaiType)type {
    label1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    label4.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    label6.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label7.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    label8.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label9.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    label11.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label12.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    label13.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
	isReload = YES;
    label14.hidden = YES;
    label9.backgroundColor = [UIColor clearColor];
    label11.backgroundColor = [UIColor clearColor];
    label10.backgroundColor = [UIColor clearColor];
	NSArray *infoArray = [info componentsSeparatedByString:@";"];
    danImage.hidden = YES;
	NSInteger height = 70;
	switch (type) {
		case ShengFuCai:
		{
            height = 70;
//            场次；对阵；投注；比分；彩果;比赛时间；胆码;是否猜中;主队；客队；即时赔率;赛事名称
            if ([infoArray count] > 12) {
                self.playId = [infoArray objectAtIndex:12];
            }
            if (infoArray.count > 11) {
                if ([self.wanfa isEqualToString:@"03"] && info2) {
                    height = 45;
                    NSArray *infoArray2 = [info2 componentsSeparatedByString:@";"];
                    if (infoArray.count > 2) {
                        label10.text = [infoArray objectAtIndex:2] ;
                    }
                    height = 2*height;
                    if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                        label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                        label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                        if ([infoArray count] > 10) {
                            NSArray *array2 = [[infoArray objectAtIndex:10] componentsSeparatedByString:@" "];
                            if ([array2 count] > 1) {
                                label2.text = [NSString stringWithFormat:@"%@\n%@",label2.text,[array2 objectAtIndex:1]];
                                if ([[array2 objectAtIndex:1] isEqualToString:@"null"]) {
                                    label2.text = @"截期";
                                }
                            }
                            
                        }
                    }
                    else {
                        label1.text = [infoArray objectAtIndex:0];
                        label2.text = [[infoArray objectAtIndex:5] stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
                    }
                    if ([label2.text length]) {
                        label1.frame = CGRectMake(0, 0, 50, height/4);
                    }
                    else {
                        label1.frame = CGRectMake(0, 0, 50, height/2);
                    }
                    label14.text = [infoArray objectAtIndex:11];
                    label14.frame = CGRectMake(0, 0, 30, 13);
                    label14.center = CGPointMake(60, label1.center.y);
                    if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                    
                    
                    label2.frame = CGRectMake(35, height/4 -2, 130, height / 3);
                    
                    
                    label3.frame = CGRectMake(50, 3, 65, height/2);
                    label3.text = [infoArray objectAtIndex:8];
                    if ([label3.text length] > 4) {
                        label3.text = [label3.text substringToIndex:4];
                    }
                    
                    
                    label4.frame = CGRectMake(50, height/2 - 1, 32, height / 2);
                    label4.font = label3.font;
                    label4.textColor = label3.textColor;
                    
                    label5.frame = CGRectMake(115, 3, 20, height/2);
                    label5.text = @"半";
                    label5.font = [UIFont systemFontOfSize:12];
                    
                    label6.frame = CGRectMake(115, height/2 - 1, 20, height/2);
                    label6.font = label5.font;
                    label6.textColor = label5.textColor;
                    label6.text = @"全";
                    label6.font = [UIFont systemFontOfSize:12];
                    
                    label7.frame = CGRectMake(135, 3, 65, height/2);
                    label7.text = [infoArray objectAtIndex:9];
                    if ([label7.text length] > 4) {
                        label7.text = [label7.text substringToIndex:4];
                    }
                    
                    label8.frame = CGRectMake(135, height/2, 65, height/2);
                    
                    label9.frame = CGRectMake(200, 3, 40, height/2);
                    label9.text = [infoArray objectAtIndex:4];//彩果2
                    
                    label11.frame = CGRectMake(200, height/2, 40, height/2);
                    label11.text = [infoArray2 objectAtIndex:4];
                    //彩果2
                    label11.textColor = label9.textColor;
                    label11.font = label9.font;
                    
                    label12.text = [infoArray2 objectAtIndex:0];
                    label12.frame = CGRectMake(0, height/2, 50, height/2);
                    label12.font = label1.font;
                    label12.textColor = label1.textColor;
                    
                    if (infoArray2.count > 2) {
                        label13.text = [infoArray2 objectAtIndex:2];
                    }
                    label13.font = label10.font;
                    label13.textColor = label10.textColor;
                    label13.frame = CGRectMake(240, height/2, 70, height/2);
                    
                    label10.frame = CGRectMake(240, 0, 70, height/2);
                    rightImage.frame = label10.frame;
                    if (([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"true"])||[label11.text isEqualToString:@"取消"]) {
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                        label10.textColor = [UIColor whiteColor];
                    }
                    else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"false"])){
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                        label10.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                    }
                    else {
                        label10.backgroundColor = [UIColor clearColor];
                        label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    
                    if (([infoArray2 count] > 7 && [[infoArray2 objectAtIndex:7] isEqualToString:@"true"])||[label11.text isEqualToString:@"取消"]) {
                        label13.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                        label13.textColor = [UIColor whiteColor];
                        
                    }
                    else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"false"])){
                        label13.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                        label13.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                    }
                    else {
                        label13.backgroundColor = [UIColor clearColor];
                        label13.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    
                    if ([[infoArray objectAtIndex:6] isEqualToString:@"1"]) {
                        danImage.hidden = NO;
                    }
                    else {
                        danImage.hidden = YES;
                    }
                    
                    if ([[infoArray2 objectAtIndex:6] isEqualToString:@"1"]) {
                        if (!danImage2) {
                            danImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(230, 0, 14, 14)];
                            danImage2.image = UIImageGetImageFromName(@"dan_info.png");
                            [backImage1 addSubview:danImage2];
                            [danImage2 release];
                        }
                        danImage2.frame = CGRectMake(200, height/2, 14, 14);
                    }
                    else {
                        danImage2.hidden = YES;
                    }
                    
                    if (!line2) {
                        line2= [[UIView alloc] init];
                        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line2];
                        [line2 release];
                        
                    }
                    line2.frame = CGRectMake(200, 0, 0.5, height);
                    backImage.frame = CGRectMake(5, 5, 310, height +5);
                    backImage1.frame = CGRectMake(5, 5, 310, height);
                    
                }
                else if ([self.wanfa isEqualToString:@"04"]) {
                    if (infoArray.count > 2) {
                        label10.text = [infoArray objectAtIndex:2];
                    }
                    CGSize maxSize = CGSizeMake(50, 1000);
                    CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                    if (height <expectedSize.height + 4) {
                        height = expectedSize.height +4;
                    }
                    if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                        label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                        label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                        if ([infoArray count] > 10) {
                            NSArray *array2 = [[infoArray objectAtIndex:10] componentsSeparatedByString:@" "];
                            if ([array2 count] > 1) {
                                label2.text = [NSString stringWithFormat:@"%@\n%@",label2.text,[array2 objectAtIndex:1]];
                                if ([[array2 objectAtIndex:1] isEqualToString:@"null"]) {
                                    label2.text = @"截期";
                                }
                            }
                            
                        }
                    }
                    else {
                        label1.text = [infoArray objectAtIndex:0];
                        label2.text = [[infoArray objectAtIndex:5] stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
                    }
                    if ([label2.text length]) {
                        label1.frame = CGRectMake(0, 0, 50, height/2);
                    }
                    else {
                        label1.frame = CGRectMake(0, 0, 50, height);
                    }
                    
                    label14.text = [infoArray objectAtIndex:11];
                    label14.frame = CGRectMake(0, 0, 30, 13);
                    label14.center = CGPointMake(60, label1.center.y);
                    if ([label14.text length] > 1 ) {
                        if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                    }
                    
                    
                    label2.frame = CGRectMake(0, height/2, 50, height / 2);
                    label2.textAlignment = NSTextAlignmentCenter;
                    label3.frame = CGRectMake(50, 0, 100, height);
                    if (infoArray.count > 1) {
                        label3.text = [infoArray objectAtIndex:1];
                    }
                    if ([label3.text length] > 4) {
                        label3.text = [label3.text substringToIndex:4];
                    }
                    
                    
                    label9.frame = CGRectMake(160, 0, 80, height);
                    label9.textAlignment = NSTextAlignmentCenter;
                    label9.text = [infoArray objectAtIndex:4];
                    
                    label10.frame = CGRectMake(240, 0, 70, height);
                    rightImage.frame = label10.frame;
                    if (([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"true"])||[label9.text isEqualToString:@"取消"]) {
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                        label10.textColor = [UIColor whiteColor];
                    }
                    else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"false"])){
                        rightImage.hidden = NO;
                        rightImage.image = [UIImageGetImageFromName(@"GC_FAXQY.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
                    }
                    else {
                        rightImage.hidden = YES;
                    }
                    
                    if ([[infoArray objectAtIndex:6] isEqualToString:@"1"]) {
                        danImage.hidden = NO;
                    }
                    else {
                        danImage.hidden = YES;
                    }
                    
                    backImage.frame = CGRectMake(10, 0, 300, height +5);
                    backImage1.frame = CGRectMake(5, 5, 310, height);
//                    line1.frame = CGRectMake(50, 0, 0.5, height -1);
                    if (!line2) {
                        line2= [[UIView alloc] init];
                        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line2];
                        [line2 release];
                        
                    }
                    if (!line3) {
                        line3= [[UIView alloc] init];
                        line3.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line3];
                        [line3 release];
                        
                    }
                    line2.frame = CGRectMake(160, 0, 0.5, height -1);
                    line3.frame = CGRectMake(240, 0, 0.5, height -1);
                    return;
                }
                else {
                    if (infoArray.count > 2) {
                        label10.text = [[infoArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                    }
                    CGSize maxSize = CGSizeMake(70, 1000);
                    CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                    if (height <expectedSize.height + 4) {
                        height = expectedSize.height +4;
                    }
                    if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                        label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                        label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                        if ([infoArray count] > 10) {
                            NSArray *array2 = [[infoArray objectAtIndex:10] componentsSeparatedByString:@" "];
                            if ([array2 count] > 1) {
                                label2.text = [NSString stringWithFormat:@"%@ %@",label2.text,[array2 objectAtIndex:1]];
                            }
                        }
                    }
                    else {
                        label1.text = [infoArray objectAtIndex:0];
                        label2.text = [infoArray objectAtIndex:5];
                    }
                    NSInteger pianyiHeght = (height - 70)/2;//大于70的高度的时候居中
                    label1.frame = CGRectMake(5, 5 + pianyiHeght, 30, 20);
                    label2.frame = CGRectMake(5, 5 + pianyiHeght, 160, 20);
                    
                    label14.text = [infoArray objectAtIndex:11];
                    label14.frame = CGRectMake(0, 0, 30, 13);
                    label14.center = CGPointMake(50, label1.center.y);
                    if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                    label3.frame = CGRectMake(0, 25 + pianyiHeght, 70, 20);
                    label3.text = [infoArray objectAtIndex:8];
                    if ([label3.text length] > 4) {
                        label3.text = [label3.text substringToIndex:4];
                    }
                    
                    label4.frame = CGRectMake(0, 45 + pianyiHeght, 70, 20);
                    
                    label5.frame = CGRectMake(70, 25 + pianyiHeght, 30, 20);
                    
                    label6.frame = CGRectMake(70, 45 + pianyiHeght, 30, 20);
                    
                    label7.frame = CGRectMake(100, 25 + pianyiHeght, 70, 20);
                    label7.text = [infoArray objectAtIndex:9];
                    if ([label7.text length] > 4) {
                        label7.text = [label7.text substringToIndex:4];
                    }
                    
                    label8.frame = CGRectMake(100, 45 + pianyiHeght, 70, 20);
                    
                    label9.frame = CGRectMake(175, 25 + pianyiHeght, 65, 20);
                    if (infoArray.count > 3) {
                        label9.text = [infoArray objectAtIndex:3];
                    }
                    
                    label11.frame = CGRectMake(175, 45 + pianyiHeght, 65, 20);
                    label11.text = [infoArray objectAtIndex:4];
                    
                    label10.frame = CGRectMake(240, 0, 70, height);
                    rightImage.frame = label10.frame;
                    rightImage.hidden = YES;
                    
                    if (([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"true"])||[label9.text isEqualToString:@"取消"]) {
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                        label10.textColor = [UIColor whiteColor];
                    }
                    else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 7 && [[infoArray objectAtIndex:7] isEqualToString:@"false"])){
                        
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                        label10.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                    }
                    else {
                        label10.backgroundColor = [UIColor clearColor];
                        label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    
                    if ([[infoArray objectAtIndex:6] isEqualToString:@"1"]) {
                        danImage.hidden = NO;
                    }
                    else {
                        danImage.hidden = YES;
                    }
                    
                    backImage.frame = CGRectMake(10, 0, 300, height +5);
                    backImage1.frame = CGRectMake(5, 5, 310, height);
                    if (!line2) {
                        line2= [[UIView alloc] init];
                        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line2];
                        [line2 release];
                        
                    }
                    line2.frame = CGRectMake(170, 0, 0.5, height -1);
                }

            }
        }
			break;
			
		case JingCaiZuqiu:
		{
            //03,04,05
            //            场次；主队；让球；胆码；比分;彩果;最终赔率;赛事Id；投注；对阵；比赛时间；胜平负玩法即时赔率;是否猜中;客队；赛事名称；playid；单关
            
            if ([infoArray count] > 15) {
                self.playId = [infoArray objectAtIndex:15];
            }
            if ([infoArray count] > 14) {
                if (infoArray.count > 8) {
                    label10.text = [[infoArray objectAtIndex:8] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                }
                CGSize maxSize = CGSizeMake(70, 1000);
                CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                if (height <expectedSize.height + 4) {
                    height = expectedSize.height +4;
                }
                if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                    label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                    label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                    if ([infoArray count] > 10) {
                        NSString *str = [infoArray objectAtIndex:10];
                        if ([str rangeOfString:@"截期"].location != NSNotFound ||[str rangeOfString:@"null"].location != NSNotFound) {
                            label2.text = @"截期";
                        }
                        else {
                            NSArray *array2 = [str componentsSeparatedByString:@" "];
                            if ([array2 count] > 1) {
                                label2.text = [infoArray objectAtIndex:10];
                            }
                            else {
                                label2.text = [NSString stringWithFormat:@"%@ %@",label2.text,str];
                            }
                        }
                        
                    }
                }
                else {
                    label1.text = [infoArray objectAtIndex:0];
                    
                    
                    
                    if ([self.wanfa isEqualToString:@"06"]||[self.wanfa isEqualToString:@"07"]) {
                        NSArray *array = [[infoArray objectAtIndex:8] componentsSeparatedByString:@" "];
                        NSString * idString = @"";
                        if ([array count] >= 1) {
                            NSArray * idArray = [[array objectAtIndex:0] componentsSeparatedByString:@"_"];
                            if ([idArray count] >=1) {
                                idString = [idArray objectAtIndex:0];
                            }
                        }
                        label1.text = idString;
                    }
                    
                    
                    label2.text = nil;
                    if ([infoArray count] > 10) {
                        NSString *str = [infoArray objectAtIndex:10];
                        if ([str rangeOfString:@"截期"].location != NSNotFound) {
                            label2.text = @"截期";
                        }
                        else {
                            label2.text = str;
                        }
                        
                    }
                }
                NSInteger pianyiHeght = (height - 70)/2;//大于70的高度的时候居中
                label1.frame = CGRectMake(5, 5 + pianyiHeght, 30, 20);
                label2.frame = CGRectMake(35, 5 + pianyiHeght, 130, 20);
                label14.text = [infoArray objectAtIndex:14];
                label14.frame = CGRectMake(0, 0, 30, 13);
                label14.center = CGPointMake(50, label1.center.y);
                if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                if (!danguanView) {
                    danguanView = [[UIView alloc] init];
                    [backImage1 addSubview:danguanView];
                    danguanView.backgroundColor = [SharedMethod getColorByHexString:@"7ac0d3"];
                    [danguanView release];
                }
                danguanView.frame = CGRectMake(160, 2 + pianyiHeght, 4, 4);
                if ([infoArray count] > 16 && [[infoArray objectAtIndex:16] isEqualToString:@"dg"]) {
                    danguanView.hidden = NO;
                }
                else {
                    danguanView.hidden = YES;
                     }
                label3.frame = CGRectMake(5, 25 + pianyiHeght, 65, 20);
                if (infoArray.count > 1) {
                    label3.text = [infoArray objectAtIndex:1];
                }
                if ([label3.text length] > 4) {
                    label3.text = [label3.text substringToIndex:4];
                }
                
                label4.frame = CGRectMake(5, 45 + pianyiHeght, 65, 20);
                
                label5.frame = CGRectMake(65, 25 + pianyiHeght, 35, 20);
                if (infoArray.count > 2) {
                    label5.text = [infoArray objectAtIndex:2];
                }
                if ([label5.text intValue] == 0) {
                    label5.text = @"-";
                }
                
                label6.frame = CGRectMake(65, 45 + pianyiHeght, 35, 20);
                
                label7.frame = CGRectMake(100, 25 + pianyiHeght, 65, 20);
                if ([infoArray count] > 13) {
                    label7.text = [infoArray objectAtIndex:13];
                }
                if ([label7.text length] > 4) {
                    label7.text = [label7.text substringToIndex:4];
                }
                
                label8.frame = CGRectMake(100, 45 + pianyiHeght, 65, 20);
                
                label9.frame = CGRectMake(170, 15 + pianyiHeght, 70, 40);
                if (infoArray.count > 3) {
                    label9.text = [infoArray objectAtIndex:3];
                }
                
                label11.frame = CGRectMake(170, 45 + pianyiHeght, 70, 20);
                if (infoArray.count > 5) {
                    label11.text = [infoArray objectAtIndex:5];
                }
                
                label10.frame = CGRectMake(240, 0, 70, height);
                
                if ([infoArray count] > 13) {
                    label7.text = [infoArray objectAtIndex:13];
                }
                if ([label7.text length] > 4) {
                    label7.text = [label7.text substringToIndex:4];
                }
                
                if ([infoArray count] > 11 && ([self.wanfa isEqualToString:@"01"] || [self.wanfa isEqualToString:@"10"])) {
                    NSArray *array2 = [[infoArray objectAtIndex:11] componentsSeparatedByString:@" "];
                    if ([array2 count]>2) {
                        label4.text = [array2 objectAtIndex:0];
                        label6.text = [array2 objectAtIndex:1];
                        label8.text = [array2 objectAtIndex:2];
                    }
                    else {
                        label4.text = @"";
                        label6.text = @"";
                        label8.text = @"";
                    }
                }
                else {
                    label4.text = @"";
                    label6.text = @"";
                    label8.text = @"";
                }
                if (infoArray.count > 4) {
                    label9.text = [[infoArray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                }
                if ([self.chuanfa isEqualToString:@"单关"]) {
                    if ([[infoArray objectAtIndex:5] length] > 0 && ![[infoArray objectAtIndex:5] isEqualToString:@"-"]) {
                        if (![self.wanfa isEqualToString:@"05"]) {
                            if ([[infoArray objectAtIndex:6] length] > 0 && ![[infoArray objectAtIndex:6] isEqualToString:@"-"]) {
                                label9.frame = CGRectMake(170, 0 + pianyiHeght, 70, 40);
                                label11.frame = CGRectMake(170, 30 + pianyiHeght, 70, 40);
                                label11.font = [UIFont systemFontOfSize:12];
                                if ([[infoArray objectAtIndex:5] isEqualToString:[infoArray objectAtIndex:4]] && [[infoArray objectAtIndex:12] isEqualToString:@"true"]) {
                                    label11.text = [NSString stringWithFormat:@"奖金 %@",[infoArray objectAtIndex:6]];
                                }
                                else {
                                    NSString *sp = [infoArray objectAtIndex:6];
                                    if ([sp rangeOfString:@"."].location != NSNotFound) {
                                        if ([sp length] > [sp rangeOfString:@"."].location + 3) {
                                            sp = [sp substringToIndex:[sp rangeOfString:@"."].location + 3];
                                        }
                                    }
                                    if ([[infoArray objectAtIndex:12] isEqualToString:@"true"]) {
                                        label11.text = [NSString stringWithFormat:@"%@\n奖金 %@",[infoArray objectAtIndex:5],sp];
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
                label10.frame = CGRectMake(240, 0, 70, height);
                rightImage.frame = label10.frame;
                
                if ([self.wanfa isEqualToString:@"06"] || [self.wanfa isEqualToString:@"07"]) {
                    //世界杯玩法改变frame
                    if (infoArray.count > 1) {
                        label3.text = [infoArray objectAtIndex:1];
                    }
                    label11.frame = CGRectMake(190, 0, 50, height);
                    label9.frame = CGRectZero;
                    label3.frame = CGRectMake(50, 3, 140, height / 2);
                    label4.frame = CGRectMake(50, height/2 - 1, 140, height / 2);
                    label5.frame = CGRectZero;
                    label6.frame = CGRectZero;
                    label7.frame =CGRectZero;
                    label8.frame =CGRectZero;
                    [line2 removeFromSuperview];
                    [line3 removeFromSuperview];
                    line2 = nil;
                    line3 = nil;
                    NSArray *array = [[infoArray objectAtIndex:8] componentsSeparatedByString:@" "];
                    if ([array count] >= 1) {
                        NSArray * idArray = [[array objectAtIndex:0] componentsSeparatedByString:@"_"];
                        if ([idArray count] > 1) {
                            label3.text = [idArray objectAtIndex:1];
                        }else{
                            label3.text = @"";
                        }
                        if ([array count] >= 2) {
                            label4.text = [array objectAtIndex:1];
                        }else{
                            label4.text = @"一";
                        }
                        
                    }
                    if ([self.wanfa isEqualToString:@"06"]) {
                        label10.text = @"冠军";
                    }
                    else if ([self.wanfa isEqualToString:@"07"]) {
                        label10.text = @"冠亚军";
                    }
                }
                else {
                    
                    label3.textAlignment = NSTextAlignmentLeft;
                    label4.textAlignment = NSTextAlignmentLeft;
                    label7.textAlignment = NSTextAlignmentRight;
                    label8.textAlignment = NSTextAlignmentRight;
                    
                    if (!line2) {
                        line2= [[UIView alloc] init];
                        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line2];
                        [line2 release];
                        
                    }
                    line2.frame = CGRectMake(170, 0, 0.5, height - 1);
                }
                if (([infoArray count] > 12 && [[infoArray objectAtIndex:12] isEqualToString:@"true"])||[label9.text isEqualToString:@"取消"]) {
                    label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                    label10.textColor = [UIColor whiteColor];
                }
                else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 12 && [[infoArray objectAtIndex:12] isEqualToString:@"false"])){
                    label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                    label10.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                }
                else {
                    label10.backgroundColor = [UIColor clearColor];
                    label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                }
                if ([label11.text isEqualToString:label9.text]) {
                    label11.text = nil;
                }
                
                if ([[infoArray objectAtIndex:3] isEqualToString:@"1"]) {
                    danImage.hidden = NO;
                }
                else {
                    danImage.hidden = YES;
                }
                
                backImage.frame = CGRectMake(10, 0, 300, height +5);
                backImage1.frame = CGRectMake(5, 5, 310, height);
            }
		}
			break;
			
		case BeiDan:
		{
            
//            对阵;赛事编号;让球;胆码；比分;彩果;最终赔率;投注;是否猜中;主队;客队;比赛时间;即时赔率;赛事名称(单场胜负玩法 该字段后添加“|体育类型”);playid
            if ([infoArray count] > 14) {
                self.playId = [infoArray objectAtIndex:14];
            }
            if (infoArray.count > 13) {
                label10.text = [[infoArray objectAtIndex:7] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                CGSize maxSize = CGSizeMake(70, 1000);
                CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                if (height <expectedSize.height + 4) {
                    height = expectedSize.height +4;
                }
                if (infoArray.count > 1) {
                    if ([(NSString *)[infoArray objectAtIndex:1] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                        label1.text = [[infoArray objectAtIndex:1] substringFromIndex:2];
                        label2.text = [[infoArray objectAtIndex:1] substringToIndex:2];
                        if ([infoArray count] > 11) {
                            NSString *str = [infoArray objectAtIndex:11];
                            if ([str rangeOfString:@"截期"].location != NSNotFound ||[str rangeOfString:@"null"].location != NSNotFound) {
                                label2.text = @"截期";
                            }
                            else {
                                NSArray *array2 = [str componentsSeparatedByString:@" "];
                                if ([array2 count] > 1) {
                                    label2.text = [[infoArray objectAtIndex:11] stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
                                }
                                else {
                                    label2.text = [NSString stringWithFormat:@"%@ %@",label2.text,str];
                                }
                            }
                        }
                    }
                    else {
                        label1.text = [infoArray objectAtIndex:1];
                        label2.text = nil;
                        if ([infoArray count] > 11) {
                            NSString *str = [infoArray objectAtIndex:11];
                            if ([str rangeOfString:@"截期"].location != NSNotFound) {
                                label2.text = @"截期";
                            }
                            else {
                                label2.text = [infoArray objectAtIndex:11];
                            }
                        }
                    }
                }
                
                NSInteger pianyiHeght = (height - 70)/2;//大于70的高度的时候居中
                label1.frame = CGRectMake(5, 5 + pianyiHeght, 30, 20);
                label2.frame = CGRectMake(35, 5 + pianyiHeght, 130, 20);
                
                NSString *name = [infoArray objectAtIndex:13];
                NSArray *nameArray = [name componentsSeparatedByString:@"|"];
                if ([nameArray count] > 0) {
                    label14.text = [nameArray objectAtIndex:0];
                    label14.frame = CGRectMake(0, 0, 30, 13);
                    label14.center = CGPointMake(50, label1.center.y);
                    if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                }

                
                label3.textAlignment = NSTextAlignmentLeft;
                label4.textAlignment = NSTextAlignmentLeft;
                label7.textAlignment = NSTextAlignmentRight;
                label8.textAlignment = NSTextAlignmentRight;
                
                label3.frame = CGRectMake(5, 25 + pianyiHeght, 65, 20);
                if ([infoArray count] > 9) {
                    label3.text = [infoArray objectAtIndex:9];
                }
                if ([label3.text length] > 4) {
                    label3.text = [label3.text substringToIndex:4];
                }
                
                label4.frame = CGRectMake(5, 45 + pianyiHeght, 65, 20);
                
                label5.frame = CGRectMake(70, 25 + pianyiHeght, 35, 20);
                if (infoArray.count > 2) {
                    label5.text = [infoArray objectAtIndex:2];
                }
                label5.font = [UIFont systemFontOfSize:12];
                label6.frame = CGRectMake(70, 45 + pianyiHeght, 35, 20);
                label7.frame = CGRectMake(100, 25 + pianyiHeght, 65, 20);
                if ([infoArray count] > 10) {
                    label7.text = [infoArray objectAtIndex:10] ;
                }
                if ([label7.text length] > 4) {
                    label7.text = [label7.text substringToIndex:4];
                }
                label8.frame = CGRectMake(100, 45 + pianyiHeght, 65, 20);
                label9.frame = CGRectMake(170, 15 + pianyiHeght, 70, 40);
                //            label9.text = [infoArray objectAtIndex:4];
                label9.text = [[infoArray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                
                label11.frame = CGRectMake(170, 45 + pianyiHeght, 70, 20);
                label11.text = [infoArray objectAtIndex:5];
                
                label10.frame = CGRectMake(240, 0, 70, height);
                
                if ([infoArray count] > 12) {
                    NSArray *array2 = [[infoArray objectAtIndex:12] componentsSeparatedByString:@" "];
                    if ([array2 count]>2) {
                        label4.text = [array2 objectAtIndex:0];
                        label6.text = [array2 objectAtIndex:1];
                        label8.text = [array2 objectAtIndex:2];
                    }
                    else {
                        label4.text = @"";
                        label6.text = @"";
                        label8.text = @"";
                    }
                    
                }
                else {
                    label4.text = @"";
                    label6.text = @"";
                    label8.text = @"";
                }
                
                
                if ([wanfa isEqualToString:@"06"]) {
                    label7.text = [label7.text stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
                    if ([label7.text length] > 4) {
                        label7.text = [label7.text substringToIndex:4];
                    }
                    label3.text = [label3.text stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
                    if ([label3.text length] > 4) {
                        label3.text = [label3.text substringToIndex:4];
                    }
                    label7.numberOfLines = 0;
                    label3.numberOfLines = 0;
                    if (!playImage) {
                        playImage = [[UIImageView alloc] init];
                        playImage.frame = CGRectMake(60, 1, 33,30 );
                        [backImage1 addSubview:playImage];
                        [playImage release];
                    }
                    NSString *logoName = [infoArray objectAtIndex:13];
                    NSArray *array2 =  [logoName componentsSeparatedByString:@"|"];
                    if ([array2 count] >= 2) {
                        logoName = [array2 objectAtIndex:1];
                    }
                    if ([logoName isEqualToString:@"足球"]) {
                        playImage.image = UIImageGetImageFromName(@"zuqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"篮球"]){
                        playImage.image = UIImageGetImageFromName(@"lanqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"网球"]){
                        playImage.image = UIImageGetImageFromName(@"wangqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"橄榄球"]){
                        playImage.image = UIImageGetImageFromName(@"ganlanqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"排球"]){
                        playImage.image = UIImageGetImageFromName(@"paiqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"羽毛球"]){
                        playImage.image = UIImageGetImageFromName(@"ymqlogoimage.png");
                    }else if ([logoName isEqualToString:@"乒乓球"]){
                        playImage.image = UIImageGetImageFromName(@"ppqlogoimage.png");
                    }else if ([logoName isEqualToString:@"沙滩排球"]){
                        playImage.image = UIImageGetImageFromName(@"stpqlogoimage.png");
                    }else if ([logoName isEqualToString:@"冰球"]){
                        playImage.image = UIImageGetImageFromName(@"bingqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"曲棍球"]){
                        playImage.image = UIImageGetImageFromName(@"qgqlogoimage.png");
                    }else if ([logoName isEqualToString:@"手球"]){
                        playImage.image = UIImageGetImageFromName(@"shouqiulogoimage.png");
                    }else if ([logoName isEqualToString:@"水球"]){
                        playImage.image = UIImageGetImageFromName(@"shuiqiulogoimage.png");
                    }else {
                        playImage.image = nil;
                    }
                }
                
                rightImage.frame = label10.frame;
                if (([infoArray count] > 8 && [[infoArray objectAtIndex:8] isEqualToString:@"true"])||[label9.text isEqualToString:@"取消"]) {
                    label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                    label10.textColor = [UIColor whiteColor];
                }
                else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] &&([infoArray count] > 8 && [[infoArray objectAtIndex:8] isEqualToString:@"false"])){
                    label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                    label10.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                    
                }
                else {
                    label10.backgroundColor = [UIColor clearColor];
                    label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                }
                
                if ([[infoArray objectAtIndex:3] isEqualToString:@"1"]) {
                    danImage.hidden = NO;
                }
                else {
                    danImage.hidden = YES;
                }
                
                if ([[infoArray objectAtIndex:5] length] > 0 && ![[infoArray objectAtIndex:5] isEqualToString:@"-"]) {
                    if ([[infoArray objectAtIndex:6] length] > 0 && ![[infoArray objectAtIndex:6] isEqualToString:@"-"]) {
                        
                        if ([label9.text rangeOfString:@"\n"].location != NSNotFound) {
                            label9.frame = CGRectMake(170, 0 + pianyiHeght, 70, 40);
                        }
                        else {
                            label9.frame = CGRectMake(170, 10 + pianyiHeght, 70, 30);
                        }
                        label11.frame = CGRectMake(170, 35 + pianyiHeght, 70, 40);
                        label9.font = [UIFont systemFontOfSize:15];
                        label11.font = [UIFont systemFontOfSize:12];
                        if ([[infoArray objectAtIndex:5] isEqualToString:[infoArray objectAtIndex:4]]) {
                            NSString *sp = [infoArray objectAtIndex:6];
                            if ([sp rangeOfString:@"."].location != NSNotFound) {
                                if ([sp length] > [sp rangeOfString:@"."].location + 3) {
                                    sp = [sp substringToIndex:[sp rangeOfString:@"."].location + 3];
                                }
                            }
                            label11.text = [NSString stringWithFormat:@"SP %@",sp];
                        }
                        else {
                            NSString *sp = [infoArray objectAtIndex:6];
                            if ([sp rangeOfString:@"."].location != NSNotFound) {
                                if ([sp length] > [sp rangeOfString:@"."].location + 3) {
                                    sp = [sp substringToIndex:[sp rangeOfString:@"."].location + 3];
                                }
                            }
                            label11.text = [NSString stringWithFormat:@"%@\nSP %@",[infoArray objectAtIndex:5],sp];
                        }
                        
                    }
                }
                
                
                if (!line2) {
                    line2= [[UIView alloc] init];
                    line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                    [backImage1 addSubview:line2];
                    [line2 release];
                    
                }
                if ([label11.text isEqualToString:label9.text]) {
                    label11.text = nil;
                }
                line2.frame = CGRectMake(170, 0, 0.5, height - 1);
                backImage.frame = CGRectMake(10, 0, 300, height +5);
                backImage1.frame = CGRectMake(5, 5, 310, height);

            }
        }
			break;
        case AoYun1: {
        }
            break;
        case AoYun2: {
        }
            break;
        case AoYun3: {
        }
            break;
        case ZuQiuDahunTou: {
            //足球大混投
            // 场次;赛事名称;对阵;比分;胆;赛事Id;让球;主队;客队;比赛时间;即时赔率(如果同时包含胜平负和让球胜平负则显示两玩法即时赔率 用*分隔);playid;预留字段;投注|彩果|是否猜中（猜中为true 其他为false）^投注|彩果|是否猜中^...
            if ([infoArray count] >= 14) {
                self.playId = [infoArray objectAtIndex:11];
                NSArray *touzhuArray = [[infoArray objectAtIndex:13] componentsSeparatedByString:@"^"];
                NSMutableArray *arrayTouZhu = [NSMutableArray array];
                NSMutableArray *caiguoArray = [NSMutableArray array];
                NSMutableArray *tureOrWrong = [NSMutableArray array];
                for (int i = 0; i < [touzhuArray count]; i ++ ) {
                    NSArray *arrayT = [[touzhuArray objectAtIndex:i] componentsSeparatedByString:@"|"];
                    if ([arrayT count] >=3) {
                        [arrayTouZhu addObject:[[arrayT objectAtIndex:0] stringByReplacingOccurrencesOfString:@")" withString:@")\n"]];
                        [caiguoArray addObject:[arrayT objectAtIndex:1]];
                        [tureOrWrong addObject:[arrayT objectAtIndex:2]];
                    }
                }
                
                NSArray *pelv1 = [[infoArray objectAtIndex:10] componentsSeparatedByString:@"*"];
                label3.textAlignment = NSTextAlignmentLeft;
                label4.textAlignment = NSTextAlignmentLeft;
                label7.textAlignment = NSTextAlignmentRight;
                label8.textAlignment = NSTextAlignmentRight;
                
                label5.text = @"VS";
                
                label4.text = @"";
                label4.numberOfLines = 0;
                label6.numberOfLines = 0;
                label8.numberOfLines = 0;
                label6.text = @"";
                label8.text = @"";
                label4.numberOfLines = 0;
                label6.numberOfLines = 0;
                label8.numberOfLines = 0;
                for (int i = 0; i < [pelv1 count] && i < 2; i ++) {
                    NSArray *pelv2 = [[pelv1 objectAtIndex:i] componentsSeparatedByString:@" "];
                    if ([pelv2 count] >= 3) {
                        NSString *sheng = [pelv2 objectAtIndex:0];
                        NSString *ping = [pelv2 objectAtIndex:1];
                        NSString *fu = [pelv2 objectAtIndex:2];
                        if ([[sheng componentsSeparatedByString:@")"] count] >= 2) {
                            sheng = [NSString stringWithFormat:@"%@%@)",[[sheng componentsSeparatedByString:@")"] objectAtIndex:1],[[sheng componentsSeparatedByString:@")"] objectAtIndex:0]];
                        }
                        if (i == 0) {
                            label4.text = [NSString stringWithFormat:@"%@",sheng];
                            label6.text = [NSString stringWithFormat:@"%@",[pelv2 objectAtIndex:1]];
                            label8.text = [NSString stringWithFormat:@"%@",[pelv2 objectAtIndex:2]];
                            
                        }
                        else  {
                            label4.text = [NSString stringWithFormat:@"%@\n%@",sheng,label4.text];
                            label6.text = [NSString stringWithFormat:@"%@\n%@",ping,label6.text];
                            label8.text = [NSString stringWithFormat:@"%@\n%@",fu,label8.text];
                            
                        }
                        
                    }
                }
                for (UIView *v in label10.subviews) {
                    v.hidden = YES;
                }
                NSInteger touzhuHeight = 0;
                label10.frame = CGRectMake(240, 0, 70, height);
                for (int i = 0; i < [touzhuArray count] && i < [caiguoArray count]; i ++) {
                    UILabel *touZhuLabel = (UILabel *)[label10 viewWithTag:2000+i];
                    if (!touZhuLabel) {
                        touZhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, touzhuHeight, 70, height)];
                        touZhuLabel.font = label10.font;
                        touZhuLabel.tag = 2000+i;
                        touZhuLabel.numberOfLines = 0;
                        touZhuLabel.textAlignment = NSTextAlignmentCenter;
                        touZhuLabel.textColor = label10.textColor;
                        [label10 addSubview:touZhuLabel];
                        [touZhuLabel release];
                    }
                    touZhuLabel.hidden = NO;
                    touZhuLabel.text = [arrayTouZhu objectAtIndex:i];
                    if ([[caiguoArray objectAtIndex:i] length] > 0 && ![[caiguoArray objectAtIndex:i] isEqualToString:@"-"]) {
                        if ([[tureOrWrong objectAtIndex:i] isEqualToString:@"true"] || [[infoArray objectAtIndex:3] isEqualToString:@"取消"]) {
                            touZhuLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                            touZhuLabel.textColor = [UIColor whiteColor];

                        }
                        else if ([[tureOrWrong objectAtIndex:i] isEqualToString:@"false"]) {
                            touZhuLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                            touZhuLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                        }
                        else {
                            touZhuLabel.backgroundColor = [UIColor clearColor];
                            touZhuLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                        }
                    }
                    else {
                        touZhuLabel.backgroundColor = [UIColor clearColor];
                        touZhuLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    
                    CGSize maxSize = CGSizeMake(70, 1000);
                    CGSize expectedSize = [touZhuLabel.text sizeWithFont:touZhuLabel.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];

                    if ([touzhuArray count] == 1) {
                        if (touzhuHeight <expectedSize.height + 4) {
                            touzhuHeight = expectedSize.height +4;
                        }
                        if (touzhuHeight < height) {
                            touzhuHeight = height;
                        }
                        touZhuLabel.frame = CGRectMake(0, 0, 70, touzhuHeight);
                    }
                    else {
                        if (i != 0) {
                            UIView *line = [label10 viewWithTag:3000 + i];
                            if (!line) {
                                line = [[UIView alloc] init];
                                line.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                                [label10 addSubview:line];
                                line.tag = 3000 + i;
                                [line release];
                            }
                            line.hidden = NO;
                            line.frame = CGRectMake(0, touzhuHeight, 70, 0.5);
                            [label10 bringSubviewToFront:line];
                        }
                        
                        if (expectedSize.height < 40) {
                            expectedSize.height = 40;
                        }
                        touZhuLabel.frame = CGRectMake(0, touzhuHeight, 70, expectedSize.height +5);
                        touzhuHeight = touzhuHeight + expectedSize.height + 5;
                    }
                }
                
                height = touzhuHeight;
//                label10.text = [[infoArray objectAtIndex:12] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
//                CGSize maxSize = CGSizeMake(70, 1000);
//                CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
//                if (height <expectedSize.height + 4) {
//                    height = expectedSize.height +4;
//                }
                if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                    label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                    if ([[infoArray objectAtIndex:9] length] > 4) {
                        label2.text = [infoArray objectAtIndex:9];
                    }
                    else {
                        label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                    }
                    
                }
                else {
                    label1.text = [infoArray objectAtIndex:0];
                    label2.text = [infoArray objectAtIndex:9];
                }
                NSInteger pianyiHeght = 0;//大于70的高度的时候居中
                label1.frame = CGRectMake(5, 5 + pianyiHeght, 30, 20);
                label2.frame = CGRectMake(40, 5 + pianyiHeght, 130, 20);
                
                
                label14.text = [infoArray objectAtIndex:1];
                label14.frame = CGRectMake(0, 0, 30, 13);
                label14.center = CGPointMake(50, label1.center.y);
                if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                
                label3.frame = CGRectMake(5, 25 + pianyiHeght, 70, 20);
                label3.text = [infoArray objectAtIndex:7];
                if ([label3.text length] > 4) {
                    label3.text = [label3.text substringToIndex:4];
                }
                
                label4.frame = CGRectMake(5, 45 + pianyiHeght, 70, 40);
                
                label5.frame = CGRectMake(70, 25 + pianyiHeght, 35, 20);
                
                label6.frame = CGRectMake(70, 45 + pianyiHeght, 35, 40);
                
                label7.frame = CGRectMake(100, 25 + pianyiHeght, 70, 20);
                label7.text = [infoArray objectAtIndex:8];
                if ([label7.text length] > 4) {
                    label7.text = [label7.text substringToIndex:4];
                }
                
                label8.frame = CGRectMake(100, 45 + pianyiHeght, 70, 40);
                
                if ([pelv1 count] == 1) {
                    label4.frame = CGRectMake(5, 45 + pianyiHeght, 70, 20);
                    label6.frame = CGRectMake(70, 45 + pianyiHeght, 35, 20);
                    label8.frame = CGRectMake(100, 45 + pianyiHeght, 70, 20);
                }
                
                label9.frame = CGRectMake(175, 25 + pianyiHeght, 65, 20);
                label9.text = [[infoArray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                
                label11.frame = CGRectMake(175, 45 + pianyiHeght, 65, 20 );
                label11.text = @"";
                label11.numberOfLines = 0;
                    for (int i = 0; i < [caiguoArray count]; i ++) {
                        NSString *caiguo = [caiguoArray objectAtIndex:i];
                        if ([caiguo length] == 2 && ([caiguo isEqualToString:@"胜胜"] || [caiguo isEqualToString:@"胜平"] ||[caiguo isEqualToString:@"胜负"] || [caiguo isEqualToString:@"平胜"] || [caiguo isEqualToString:@"平平"] || [caiguo isEqualToString:@"平负"]|| [caiguo isEqualToString:@"负胜"]|| [caiguo isEqualToString:@"负平"]|| [caiguo isEqualToString:@"负负"])) {
                            label11.text = caiguo;
                            break;
                        }
                    }
                if ([label11.text isEqualToString:label9.text]) {
                    label11.text = nil;
                }
//                label11.text = [infoArray objectAtIndex:4];
                
                label10.frame = CGRectMake(240, 0, 70, height);
                rightImage.frame = label10.frame;
                rightImage.hidden = YES;
                
                if ([[infoArray objectAtIndex:4] isEqualToString:@"1"]) {
                    danImage.hidden = NO;
                }
                else {
                    danImage.hidden = YES;
                }
                if (!danguanView) {
                    danguanView = [[UIView alloc] init];
                    [backImage1 addSubview:danguanView];
                    danguanView.backgroundColor = [SharedMethod getColorByHexString:@"7ac0d3"];
                    [danguanView release];
                }
                danguanView.frame = CGRectMake(165, 2 + pianyiHeght, 4, 4);
                if ([[infoArray objectAtIndex:13] rangeOfString:@"dg"].location != NSNotFound) {
                    danguanView.hidden = NO;
                }
                else {
                    danguanView.hidden = YES;
                }
                backImage.frame = CGRectMake(10, 0, 300, height +5);
                backImage1.frame = CGRectMake(5, 5, 310, height);
                if (!line2) {
                    line2= [[UIView alloc] init];
                    line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                    [backImage1 addSubview:line2];
                    [line2 release];
                    
                }
                line2.frame = CGRectMake(175, 0, 0.5, height - 1);
            }
            
            
        }
            break;
		default:
            
            // 场次;对阵;比分;彩果；投注;胆;出票赔率;赛事Id;让球;是否猜中（猜中为true 其他为false）;主队;客队;比赛时间;即时赔率;赛事名称；是否单关
            if (type > LanQiuHunTou) {
                return;
            }
            if (!infoArray) {
                height = 25;
                label1.text = nil;
                label2.text = nil;
                label3.text = @"客队";
                label3.frame = CGRectMake(10, 0, 60, height);
                label4.text = nil;
                label5.text = nil;
                label6.text = nil;
                label7.text = @"主队";
                label7.frame = CGRectMake(100, 0, 60, height);
                label8.text = nil;
                label9.text = nil;
                label10.text = nil;
                label11.text = nil;
                danguanView.hidden = YES;
                backImage.frame = CGRectMake(10, 0, 300, height +5);
                backImage1.frame = CGRectMake(5, 5, 310, height);
            }
            else {
                if (infoArray.count > 15) {
                    label10.text = [[infoArray objectAtIndex:4] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                    label11.text = [[infoArray objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
                    CGSize maxSize = CGSizeMake(70, 1000);
                    CGSize expectedSize = [label10.text sizeWithFont:label10.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                    if (height <expectedSize.height + 30) {
                        height = expectedSize.height +30;
                    }
                    CGSize expectedSize2 = [label11.text sizeWithFont:label11.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                    if (height <expectedSize.height + 30) {
                        height = expectedSize.height +30;
                    }
                    if (height <2 *expectedSize2.height + 30) {
                        height = 2 *expectedSize2.height +30;
                    }
                    if ([(NSString *)[infoArray objectAtIndex:0] hasPrefix:@"周"]&& [(NSString *)[infoArray objectAtIndex:0] length]>=2) {
                        label1.text = [[infoArray objectAtIndex:0] substringFromIndex:2];
                        label2.text = [[infoArray objectAtIndex:0] substringToIndex:2];
                        if ([infoArray count] > 12) {
                            NSString *str = [infoArray objectAtIndex:12];
                            if ([str rangeOfString:@"截期"].location != NSNotFound ||[str rangeOfString:@"null"].location != NSNotFound) {
                                label2.text = @"截期";
                            }
                            else {
                                NSArray *array2 = [str componentsSeparatedByString:@" "];
                                if ([array2 count] > 1) {
                                    label2.text = [infoArray objectAtIndex:12];
                                }
                                else {
                                    label2.text = [NSString stringWithFormat:@"%@ %@",label2.text,str];
                                }
                            }
                        }
                    }
                    else {
                        label1.text = [infoArray objectAtIndex:0];
                        label2.text = nil;
                        
                        
                    }
                    
                    if ([label2.text length]) {
                        label1.frame = CGRectMake(0, 3, 50, 15);
                    }
                    else {
                        label1.frame = CGRectMake(0, 3, 50, 15);
                    }
                    
                    label14.text = [infoArray objectAtIndex:14];
                    label14.frame = CGRectMake(0, 0, 30, 13);
                    label14.center = CGPointMake(60, label1.center.y);
                    if ([label14.text length] > 1 ) {
                        label14.hidden = NO;
                    }
                    
                    label2.frame = CGRectMake(35, 3, 120, 15);
                    
                    if (!danguanView) {
                        danguanView = [[UIView alloc] init];
                        [backImage1 addSubview:danguanView];
                        danguanView.backgroundColor = [SharedMethod getColorByHexString:@"7ac0d3"];
                        [danguanView release];
                    }
                    danguanView.frame = CGRectMake(160, 2 + 3, 4, 4);
                    if ([infoArray count] > 15 && [[infoArray objectAtIndex:15] isEqualToString:@"dg"]) {
                        danguanView.hidden = NO;
                    }
                    else {
                        danguanView.hidden = YES;
                    }
                    
                    
                    label3.frame = CGRectMake(10, 20, 60, 20);
                    if ([infoArray count] > 11) {
                        label3.text = [infoArray objectAtIndex:11];
                    }
                    if ([label3.text length] > 4) {
                        label3.text = [label3.text substringToIndex:4];
                    }
                    
                    label4.frame = CGRectMake(10, 35, 60, 20);
                    
                    label5.frame = CGRectMake(70, 20, 30, 20);
                    label5.text = [infoArray objectAtIndex:8];
                    label5.font = [UIFont systemFontOfSize:12];
                    
                    label6.frame = CGRectMake(70, 35, 30, 20);
                    
                    label7.frame = CGRectMake(100, 20, 60, 20);
                    if ([infoArray count] > 10) {
                        label7.text = [infoArray objectAtIndex:10];
                    }
                    if ([label7.text length] > 4) {
                        label7.text = [label7.text substringToIndex:4];
                    }
                    label8.frame = CGRectMake(100, 35, 60, 20);
                    if ([infoArray count] > 13 && type != LanQiuDaxiafen && type != LanQiufencha) {
                        NSArray *array2 = [[infoArray objectAtIndex:13] componentsSeparatedByString:@" "];
                        if ([array2 count]>2) {
                            label4.text = [array2 objectAtIndex:0];
                            label6.text = [array2 objectAtIndex:1];
                            label8.text = [array2 objectAtIndex:2];
                        }
                        else if ([array2 count] > 1) {
                            label4.text = [array2 objectAtIndex:0];
                            label8.text = [array2 objectAtIndex:1];
                        }
                        else {
                            label4.text = @"";
                            label6.text = @"";
                            label8.text = @"";
                        }
                        
                    }
                    else {
                        label4.text = @"";
                        label6.text = @"";
                        label8.text = @"";
                    }
                    
                    if (![label4.text length] &&![label6.text length] && ![label8.text length]) {
                        label3.frame = CGRectMake(10, 0, 60, height);
                        label5.frame = CGRectMake(70, 0, 30, height);
                        label7.frame = CGRectMake(100, 0, 60, height);
                    }
                    if (type == LanQiuDaxiafen || type == LanQiuHunTou) {
                        label5.font = [UIFont boldSystemFontOfSize:10];
                    }
                    
                    label9.frame = CGRectMake(180, 3, 50, height/2);
                    if (infoArray.count > 2) {
                        label9.text = [infoArray objectAtIndex:2];
                    }
                    
                    label11.frame = CGRectMake(180, height/2 - 1, 50, height/2);
                    
                    
                    label10.frame = CGRectMake(240, 0, 70, height);
                    rightImage.frame = label10.frame;
                    if (([infoArray count] > 9 && [[infoArray objectAtIndex:9] isEqualToString:@"true"])||[label9.text isEqualToString:@"取消"]) {
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
                        label10.textColor = [UIColor whiteColor];
                    }
                    else if ([label11.text length]&& ![label11.text isEqualToString:@"-"] && ([infoArray count] > 9 && [[infoArray objectAtIndex:9] isEqualToString:@"false"])){
                        label10.backgroundColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
                        label10.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                    }
                    else {
                        label10.backgroundColor = [UIColor clearColor];
                        label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    
                    if ([[infoArray objectAtIndex:5] isEqualToString:@"1"]) {
                        danImage.hidden = NO;
                    }
                    else {
                        danImage.hidden = YES;
                    }
                    if (!line2) {
                        line2= [[UIView alloc] init];
                        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
                        [backImage1 addSubview:line2];
                        [line2 release];
                        
                    }
                    line2.frame = CGRectMake(170, 0, 0.5, height - 1);
                    backImage.frame = CGRectMake(10, 0, 300, height +5);
                    backImage1.frame = CGRectMake(5, 5, 310, height);
                }
            }
            
			break;
	}
    line1.frame = CGRectMake(240, 0, 0.5, height -1);
//    line2.frame = CGRectMake(100, 0, 1, height -1);
//    line3.frame = CGRectMake(130, 0, 1, height -1);
//    line4.frame = CGRectMake(180, 0, 1, height -1);
//    line5.frame = CGRectMake(230, 0, 1, height -1);
//    if (isHeigher) {
//        line2.frame = CGRectZero;
//        line3.frame = CGRectZero;
//    }
    if (isJJYH) {
        label10.backgroundColor = [UIColor clearColor];
        label10.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        
        label13.backgroundColor = [UIColor clearColor];
        label13.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    }
    
}

- (void)LoadMatchInfo:(MatchInfo *)matchInfo {
    self.myMatchInfo = nil;
    for (MatchInfo *info in matchInfo.matchList) {
        NSLog(@"%@  %@", info.matchId, self.playId);
        if ([info.matchId isEqualToString:self.playId]) {
            self.myMatchInfo = info;
            break;
        }
    }
    if (self.myMatchInfo && ([label11.text isEqualToString:@"-"] || ![label11.text length])) {
        if ([self.myMatchInfo.isstart isEqual:@"0"]) {
            self.shishiBtn.hidden = YES;
            return;
        }
        if (!shishiBtn) {
            shishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [backImage1 addSubview:shishiBtn];
            backImage1.userInteractionEnabled = YES;
        }
        self.shishiBtn.hidden = NO;
        label9.text = [NSString stringWithFormat:@"%@:%@",self.myMatchInfo.scoreHost,self.myMatchInfo.awayHost];
        shishiBtn.frame = CGRectMake(180, 0, label11.bounds.size.width, backImage1.bounds.size.height);
        if ([self.myMatchInfo.start isEqualToString:@"2"]) {
            label11.text = self.myMatchInfo.status;
            label9.textColor = [UIColor colorWithRed:125/255.0 green:0 blue:0 alpha:1.0];
        }
        else if ([self.myMatchInfo.start isEqualToString:@"1"]){
            
            label11.text = self.myMatchInfo.status;
            label9.textColor = [UIColor redColor];
            
            
            if ([self.myMatchInfo.status isEqualToString:@"中场"] ||[self.myMatchInfo.status isEqualToString:@"中"]) {
                label9.textColor = [UIColor colorWithRed:1.0 green:124.0/255.0 blue:0 alpha:1.0];
                
            }
            else {
                label11.textColor = [UIColor redColor];
            }
            
        }
        else if ([self.myMatchInfo.start isEqualToString:@"0"]){
            //即将开赛
            if ([self.myMatchInfo.isstart isEqual:@"1"]) {
                label11.frame = CGRectMake(170, 0, label11.bounds.size.width, backImage1.bounds.size.height);
                label11.text = @"即将\n开赛";
                label9.text =nil;
            }
        }
        if (self.myMatchInfo.isScoreHostChange) {
            label3.textColor = [UIColor redColor];
        }
        if (self.myMatchInfo.isAwayHostChange) {
            label7.textColor = [UIColor redColor];
        }
        if ((self.myMatchInfo.isColorNeedChange && [self.myMatchInfo.start isEqualToString:@"2"]) || self.myMatchInfo.isScoreHostChange || self.myMatchInfo.isAwayHostChange) {
            label9.backgroundColor = [UIColor colorWithRed:1 green:239/255.0 blue:152.0/255.0 alpha:1.0];
            label9.frame = CGRectMake(label9.frame.origin.x, 0, label9.frame.size.width, backImage1.bounds.size.height);
            label11.backgroundColor = [UIColor colorWithRed:1 green:239/255.0 blue:152.0/255.0 alpha:1.0];
        }
        
    }
}


- (void)dealloc {
    self.wanfa = nil;
    self.chuanfa = nil;
    self.myMatchInfo = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
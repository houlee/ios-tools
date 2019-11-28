//
//  GCHemaiCell.m
//  caibo
//
//  Created by  on 12-6-26.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCHemaiCell.h"

@implementation GCHemaiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self returnTableViewCell]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (SchemeInfo *)schem{
    return schem;
}

- (void)setSchem:(SchemeInfo *)_schem{
    if (schem != _schem) {
        [schem release];
        schem = [_schem retain];
    }
    
    // 置顶图片
    if ([schem.initiatorID rangeOfString:@"zhiding"].location != NSNotFound) {
        zhidingImage.hidden = NO;
    }
    else {
        zhidingImage.hidden = YES;
    }
    
   
    // 保
    NSInteger julicount = 18;
//    baoCount.text = [NSString stringWithFormat:@"%d%@",[_schem.baodi intValue]*100,@"%"];

    if ([_schem.baodi isEqualToString:@"1"]) {
        baoimage.hidden = NO;
        baoimage.frame = CGRectMake(0, 0, 15, 15);
//        [baoLabel addSubview:baoimage];
        baoCount.text = [NSString stringWithFormat:@"%@%@",_schem.yuliustring,@"%"];
        
        
    }else{
        
        baoimage.frame = CGRectMake(0, 0, 15, 15);
//        [baoView addSubview:baoimage];
        baoimage.hidden = NO;
        baoCount.text = [NSString stringWithFormat:@"%@%@",_schem.yuliustring,@"%"];
        baiFenHaoLabel.frame = CGRectMake(32+2+expectedSize1.width, 35+2, 55, 20);

    }
    

    
    // 声音
    if (_schem.shengyin > 0) {
        haoshengyinimage.hidden = NO;
        
        haoshengyinimage.frame = CGRectMake(66+julicount, 10, 15, 16);
        julicount += 18;
    }else{
        haoshengyinimage.hidden = YES;
    }
    
    userName.text = _schem.initiator;
    NSLog(@"username = %@", _schem.initiator);
   
    CGSize maxSize91 = CGSizeMake(200, 20);
    CGSize expectedSize91 = [userName.text sizeWithFont:userName.font constrainedToSize:maxSize91 lineBreakMode:UILineBreakModeCharacterWrap];
    NSLog(@"username wiht = %f", expectedSize91.width);
    // userName
    userName.frame = CGRectMake(85, 15, expectedSize91.width, 20);
    
   
     progressView.progress = [_schem.speed floatValue]/100;
    
    // 百分比
//    if ([_schem.speed intValue] > 90) {
//        baifenLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:78.0/255.0  blue:0/255.0 alpha:1];
//    }else if ([_schem.speed intValue]>69&&[_schem.speed intValue]<91){
//        baifenLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:150.0/255.0  blue: 0/255.0 alpha:1];
//    }else
//    {
//
//        baifenLabel.textColor = [UIColor colorWithRed:14.0/255.0 green:150.0/255.0  blue: 237.0/255.0 alpha:1];
//    }
    baifenLabel.textColor = [UIColor colorWithRed:14.0/255.0 green:150.0/255.0  blue: 237.0/255.0 alpha:1];
   
    baifenLabel.text = [NSString stringWithFormat:@"%d", [_schem.speed intValue]];
    
    CGSize maxSize11 = CGSizeMake(55, 20);
    expectedSize1 = [baifenLabel.text sizeWithFont:baifenLabel.font constrainedToSize:maxSize11 lineBreakMode:UILineBreakModeCharacterWrap];
    
    moneyLabel.text = [NSString stringWithFormat:@"%@ ", _schem.amount];
    numLabel.text = [NSString stringWithFormat:@"%d", (int)_schem.surplusAmount];
    
    

    
    CGSize maxSize8 = CGSizeMake(70, 20);
    CGSize expectedSize8 = [moneyLabel.text sizeWithFont:moneyLabel.font constrainedToSize:maxSize8 lineBreakMode:UILineBreakModeWordWrap];
    //93+5 55
    moneyLabel.frame = CGRectMake(85, 35, expectedSize8.width, expectedSize8.height);
    
    CGSize maxSize9 = CGSizeMake(20, 20);
    CGSize expectedSize9 = [yuanLabel.text sizeWithFont:yuanLabel.font constrainedToSize:maxSize9 lineBreakMode:UILineBreakModeWordWrap];
    yuanLabel.frame = CGRectMake(84+moneyLabel.frame.size.width, 38, expectedSize9.width, expectedSize9.height);
    
   

    CGSize maxSize2 = CGSizeMake(70, 20);
    CGSize expectedSize2 = [numLabel.text sizeWithFont:numLabel.font constrainedToSize:maxSize2 lineBreakMode:UILineBreakModeWordWrap];
    numLabel.frame = CGRectMake(176, 35, expectedSize2.width, expectedSize2.height);
    
    CGSize maxSize = CGSizeMake(20, 20);
    CGSize expectedSize = [fenlabel.text sizeWithFont:fenlabel.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    fenlabel.frame = CGRectMake(178 + expectedSize2.width, 38, expectedSize.width, expectedSize.height);
    
    CGSize maxSize3 = CGSizeMake(20, 20);
    CGSize expectedSize3 = [shenglabel.text sizeWithFont:shenglabel.font constrainedToSize:maxSize3 lineBreakMode:UILineBreakModeWordWrap];
    // 268-expectedSize3.width - expectedSize2.width
    shenglabel.frame = CGRectMake(176, 55
, expectedSize3.width, expectedSize3.height);
    
    
    //是否保底
    if ((![_schem.baodi isEqualToString:@"1"])) {
        baiFenHaoLabel.frame = CGRectMake(28+2+expectedSize1.width, 35+2, 55, 20);
    }else{
        baiFenHaoLabel.frame = CGRectMake(27+2+expectedSize1.width, 35+2, 55, 20);
    }
    if ([_schem.speed intValue]< 10) {
        baiFenHaoLabel.frame = CGRectMake(33+2+expectedSize1.width, 35+2, 55, 20);
    }
    
    
    
    //等级
    if (![_schem.zhanji isEqualToString:@"无战绩"]) {
        NSArray * dengjiarr = [_schem.zhanji componentsSeparatedByString:@"#"];
        if (dengjiarr.count > 5) {
            levLabel1.text = [dengjiarr objectAtIndex:0];
            levLabel2.text = [dengjiarr objectAtIndex:1];
            levLabel3.text = [dengjiarr objectAtIndex:2];
            levLabel4.text = [dengjiarr objectAtIndex:3]; //正式的
            levLabel5.text = [dengjiarr objectAtIndex:4];
            levLabel6.text = [dengjiarr objectAtIndex:5];
        }
        
//        levLabel4.text = @"0";//暂时的
//        levLabel5.text = @"0";
//        levLabel6.text = @"0";

        
        NSArray * levalarr = [NSArray arrayWithObjects:levLabel1, levLabel2, levLabel3, levLabel4, levLabel5, levLabel6, nil];
        NSArray * levaimage  = [NSArray arrayWithObjects:level1, level2, level3, level4, level5, level6, nil];
        //  NSInteger count = 0;
        NSMutableArray * counarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 6; i++) {
            UILabel * le = [levalarr objectAtIndex:i];
            UIImageView * ima = [levaimage objectAtIndex:i];
            
            if ([le.text isEqualToString:@"0"]) {
                ima.hidden = YES;
            }else{
                //            ima.frame = CGRectMake(246 - (count * 18), 29, 11, 11);
                //        //    ima.frame = CGRectMake(29 + (count*18), 29, 11, 11);
                //            ima.hidden = NO;
                //            count++;
                [counarray addObject:ima];
            }
            
        }
        float changdu = expectedSize91.width+90+julicount;
        
        if ([counarray count] == 6) {
            level1.frame = CGRectMake(changdu, 19, 11, 11);//171
            level2.frame = CGRectMake(changdu+15, 19, 11, 11);//186
            level3.frame = CGRectMake(changdu+30, 19, 11, 11);//201
            level4.frame = CGRectMake(changdu+45, 19, 11, 11);//216
            level5.frame = CGRectMake(changdu+60, 19, 11, 11);//231
            level6.frame = CGRectMake(changdu+75, 19, 11, 11);//246
            level1.hidden = NO;
            level2.hidden = NO;
            level3.hidden = NO;
            level4.hidden = NO;
            level5.hidden = NO;
            level6.hidden = NO;
        }else if([counarray count] == 5){
            for (int i = 0; i < 5; i++) {
                UIImageView * imagedj = [counarray objectAtIndex:i];
                imagedj.frame = CGRectMake(changdu+i*15, 19, 11, 11);
                imagedj.hidden = NO;
            }
            
        }else if([counarray count] == 4){
            for (int i = 0; i < 4; i++) {
                UIImageView * imagedj = [counarray objectAtIndex:i];
                imagedj.frame = CGRectMake(changdu+i*15, 19, 11, 11);
                imagedj.hidden = NO;
            }
        }else if([counarray count] == 3){
            for (int i = 0; i < 3; i++) {
                UIImageView * imagedj = [counarray objectAtIndex:i];
                imagedj.frame = CGRectMake(changdu+i*15, 19, 11, 11);
                imagedj.hidden = NO;
            }
        }else if([counarray count] == 2){
            for (int i = 0; i < 2; i++) {
                UIImageView * imagedj = [counarray objectAtIndex:i];
                imagedj.frame = CGRectMake(changdu+i*15, 19, 11, 11);
                imagedj.hidden = NO;
            }
        }else if([counarray count] == 1){
            
           
                UIImageView * imagedj = [counarray objectAtIndex:0];
                imagedj.frame = CGRectMake(changdu, 19, 11, 11);
                imagedj.hidden = NO;
                
            
        }else if([counarray count] == 0){
            level1.hidden = YES;
            level2.hidden = YES;
            level3.hidden = YES;
            level4.hidden = YES;
            level5.hidden = YES;
            level6.hidden = YES;
            
        }
        
        [counarray release];
        
    }else{
    
        level1.hidden = YES;
        level2.hidden = YES;
        level3.hidden = YES;
        level4.hidden = YES;
        level5.hidden = YES;
        level6.hidden = YES;
    }
    
}

- (UIView *)returnTableViewCell{
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
    
    UIImageView * cellbgimage = [[UIImageView alloc] initWithFrame:cellView.bounds];
    cellbgimage.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:251.0/255.0 blue:243.0/255.0 alpha:1];
    [cellView addSubview:cellbgimage];
    [cellbgimage release];
    
    
    UIView *cellLine = [[UIView alloc] init];
    cellLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:218.0/255.0 blue:203.0/255.0 alpha:1];
    cellLine.frame = CGRectMake(0, 84.5, 320, 0.5);
    [cellView addSubview:cellLine];
    [cellLine release];

    UIImageView *quanBg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 55, 55)];
    quanBg.image = [UIImage imageNamed:@"quanBghui.png"];
    [cellView addSubview:quanBg];
    [quanBg release];
    
    // progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(10.5f, 6.7f, 41.0f, 41.0f)];
    progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 55.0f, 55.0f)];
    [cellView addSubview:progressView];
    [progressView release];
    
    
    // 百分数
    baifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 33, 55, 20)];
    baifenLabel.textAlignment = NSTextAlignmentCenter;
    baifenLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:164.0/255.0  blue: 238.0/255.0 alpha:1];
    baifenLabel.backgroundColor = [UIColor clearColor];
    baifenLabel.font = [UIFont systemFontOfSize:22];
    [cellView addSubview:baifenLabel];
    
    // 百分号
//    CGSize maxSize1 = CGSizeMake(60, 60);
//    CGSize expectedSize1 = [baiFenHaoLabel.text sizeWithFont:baifenLabel.font constrainedToSize:maxSize1 lineBreakMode:UILineBreakModeCharacterWrap];
   // baiFenHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(68+8, 40, 15, 15)];
    baiFenHaoLabel = [[UILabel alloc] init];
    // baiFenHaoLabel.frame =CGRectMake(27+expectedSize1.width, 35, 55, 20);
    baiFenHaoLabel.frame =CGRectMake(36+2, 35+2, 55, 20);
    baiFenHaoLabel.text = @"%";
    baiFenHaoLabel.font = [UIFont systemFontOfSize:9];
    baiFenHaoLabel.backgroundColor = [UIColor clearColor];
    baiFenHaoLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:164.0/255.0  blue: 238.0/255.0 alpha:1];

    [cellView addSubview:baiFenHaoLabel];
    
    
    // 保底蓝条
//    baoView = [[[UIView alloc] init] autorelease];
//    baoView.frame = CGRectMake(15, 56, 66+10, 15);
//    baoView.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
//    baoView.layer.masksToBounds = YES;
//    baoView.layer.cornerRadius = 2;
//    [cellView addSubview:baoView];
    
    baoLabel = [[UILabel alloc] init];
    baoLabel.frame = CGRectMake(240, 55, 60, 15);
    baoLabel.backgroundColor = [UIColor clearColor];
    baoLabel.text = @"保底";
    baoLabel.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    baoLabel.font = [UIFont systemFontOfSize:10];
    [cellView addSubview:baoLabel];
    
    
    
//    baoimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
//    baoimage.backgroundColor = [UIColor clearColor];
//    baoimage.image = UIImageGetImageFromName(@"ILB-960.png");
//    [baoView addSubview:baoimage];
    // [cellView addSubview:baoimage];

    
    
    baoCount = [[UILabel alloc] init];
    baoCount.frame = CGRectMake(22, 0, 50, 15);
    baoCount.backgroundColor = [UIColor clearColor];
    baoCount.text = @"100%";
    baoCount.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    baoCount.textAlignment = NSTextAlignmentLeft;
    baoCount.font = [UIFont systemFontOfSize:10];
    [baoLabel addSubview:baoCount];
    
    
    
//    haoshengyinimage = [[UIImageView alloc] initWithFrame:CGRectMake(66, 10, 15, 16)];
//    haoshengyinimage.image = UIImageGetImageFromName(@"syimagexxx.png");
//    haoshengyinimage.backgroundColor = [UIColor clearColor];
//    haoshengyinimage.hidden = YES;
//    [cellView addSubview:haoshengyinimage];
//    [haoshengyinimage release];
    
    
    moneyLabel = [[UILabel alloc] init];
    moneyLabel.numberOfLines = 0;
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.font = [UIFont systemFontOfSize:15];
    moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    CGSize maxSize8 = CGSizeMake(70, 20);
    CGSize expectedSize8 = [moneyLabel.text sizeWithFont:moneyLabel.font constrainedToSize:maxSize8 lineBreakMode:UILineBreakModeWordWrap];
    moneyLabel.frame = CGRectMake(85, 33, expectedSize8.width, expectedSize8.height);
    allMoney = [[UILabel alloc] init] ;
    allMoney.text = @"总金额";
    allMoney.frame = CGRectMake(85, 55, 35, 15);
    allMoney.backgroundColor = [UIColor clearColor];
    allMoney.font = [UIFont systemFontOfSize:10];
    allMoney.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    
    yuanLabel = [[UILabel alloc] init];
    yuanLabel.numberOfLines = 0;
    yuanLabel.textAlignment = NSTextAlignmentLeft;
    yuanLabel.backgroundColor = [UIColor clearColor];
    yuanLabel.font = [UIFont systemFontOfSize:12];
    yuanLabel.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    yuanLabel.text = @"元";
    CGSize maxSize9 = CGSizeMake(20, 20);
    CGSize expectedSize9 = [yuanLabel.text sizeWithFont:yuanLabel.font constrainedToSize:maxSize9 lineBreakMode:UILineBreakModeWordWrap];
    yuanLabel.frame = CGRectMake(84+moneyLabel.frame.size.width, 55, expectedSize9.width, expectedSize9.height);
    
    
    
//    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 70, 20)];
//    moneyLabel.textAlignment = NSTextAlignmentLeft;
//    moneyLabel.textColor = [UIColor whiteColor];
//    moneyLabel.backgroundColor = [UIColor clearColor];
//   // moneyLabel.text = @"1000元";
//    moneyLabel.font = [UIFont boldSystemFontOfSize:12];
    
    
    userName = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 100, 20)];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.textColor = [UIColor colorWithRed:3.0/255.0 green:3.0/255.0 blue:3.0/255.0 alpha:1];
    userName.backgroundColor = [UIColor clearColor];
   // userName.text = @"用户名asdfasdf";
    userName.font = [UIFont boldSystemFontOfSize:15];
   
    
    //等级
    level1 = [[UIImageView alloc] initWithFrame:CGRectMake(171+3, 19, 11, 11)];
    level1.backgroundColor = [UIColor clearColor];
    level1.image = UIImageGetImageFromName(@"gc_jg.png");
    
    
    level2 = [[UIImageView alloc] initWithFrame:CGRectMake(186+3, 19, 11, 11)];
    level2.backgroundColor = [UIColor clearColor];
    level2.image = UIImageGetImageFromName(@"gc_zs.png");
    
    level3 = [[UIImageView alloc] initWithFrame:CGRectMake(201+3, 19, 11, 11)];
    level3.backgroundColor = [UIColor clearColor];
    level3.image = UIImageGetImageFromName(@"gc_jx.png");
    
    
    level4 = [[UIImageView alloc] initWithFrame:CGRectMake(216+3, 19, 11, 11)];
    level4.backgroundColor = [UIColor clearColor];
    level4.image = UIImageGetImageFromName(@"gc_lg.png");
    
    level5 = [[UIImageView alloc] initWithFrame:CGRectMake(231+3, 19, 11, 11)];
    level5.backgroundColor = [UIColor clearColor];
    level5.image = UIImageGetImageFromName(@"gc_ls.png");
    
    level6 = [[UIImageView alloc] initWithFrame:CGRectMake(246+3, 19, 11, 11)];
    level6.backgroundColor = [UIColor clearColor];
    level6.image = UIImageGetImageFromName(@"gc_lx.png");
    
    //等级数
    levLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel1.textAlignment = NSTextAlignmentRight;
    levLabel1.backgroundColor = [UIColor clearColor];
    levLabel1.font = [UIFont boldSystemFontOfSize:6];
    levLabel1.textColor = [UIColor colorWithRed:229/255.0 green:91/255.0 blue:0/255.0 alpha:1];
    //levLabel1.text = @"1";//假
    
    levLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel2.textAlignment = NSTextAlignmentRight;
    levLabel2.backgroundColor = [UIColor clearColor];
    levLabel2.font = [UIFont boldSystemFontOfSize:6];
    levLabel2.textColor = [UIColor colorWithRed:229/255.0 green:91/255.0 blue:0/255.0 alpha:1];
   // levLabel2.text = @"1";//假
    
    levLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel3.textAlignment = NSTextAlignmentRight;
    levLabel3.backgroundColor = [UIColor clearColor];
    levLabel3.font = [UIFont boldSystemFontOfSize:6];
    levLabel3.textColor = [UIColor colorWithRed:229/255.0 green:91/255.0 blue:0/255.0 alpha:1];
   // levLabel3.text = @"1";//假
    
    levLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel4.textAlignment = NSTextAlignmentRight;
    levLabel4.backgroundColor = [UIColor clearColor];
    levLabel4.font = [UIFont boldSystemFontOfSize:6];
    levLabel4.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
   // levLabel4.text = @"1";//假
    
    levLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel5.textAlignment = NSTextAlignmentRight;
    levLabel5.backgroundColor = [UIColor clearColor];
    levLabel5.font = [UIFont boldSystemFontOfSize:6];
    levLabel5.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
   // levLabel5.text = @"1";//假
    
    levLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel6.textAlignment = NSTextAlignmentRight;
    levLabel6.backgroundColor = [UIColor clearColor];
    levLabel6.font = [UIFont boldSystemFontOfSize:6];
    levLabel6.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
    //levLabel6.text = @"1";
    
//    colorView = [[ColorView alloc] initWithFrame:CGRectMake(200, 5, 170, 20)];
//    colorView.backgroundColor = [UIColor clearColor];
//    colorView.font = [UIFont boldSystemFontOfSize:12];
//    colorView.textColor = [UIColor whiteColor];
//    colorView.changeColor = [UIColor redColor];
//    colorView.textAlignment = NSTextAlignmentRight;
//    colorView.text = @"剩<19>份";
    
   
    // 剩余份数
    numLabel = [[UILabel alloc] init];
    numLabel.numberOfLines = 0;
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = [UIFont systemFontOfSize:15];
    numLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    //numLabel.text = @"1999";
    CGSize maxSize2 = CGSizeMake(70, 20);
    CGSize expectedSize2 = [numLabel.text sizeWithFont:numLabel.font constrainedToSize:maxSize2 lineBreakMode:UILineBreakModeWordWrap];
    numLabel.frame = CGRectMake(176, 35, expectedSize2.width, expectedSize2.height);
    [cellView addSubview:numLabel];
    
    fenlabel = [[UILabel alloc] init];
    fenlabel.numberOfLines = 0;
    fenlabel.textAlignment = NSTextAlignmentRight;
    fenlabel.backgroundColor = [UIColor clearColor];
    fenlabel.font = [UIFont systemFontOfSize:12];
    fenlabel.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    fenlabel.text = @"份";
    CGSize maxSize = CGSizeMake(20, 20);
    CGSize expectedSize = [fenlabel.text sizeWithFont:fenlabel.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    fenlabel.frame = CGRectMake(178 + expectedSize2.width, 38, expectedSize.width, expectedSize.height);
    [cellView addSubview:fenlabel];
    
    
    shenglabel = [[UILabel alloc] init];
    shenglabel.numberOfLines = 0;
    shenglabel.textAlignment = NSTextAlignmentRight;
    shenglabel.backgroundColor = [UIColor clearColor];
    shenglabel.font = [UIFont systemFontOfSize:10];
    shenglabel.textColor = [UIColor colorWithRed:132.0/255.0 green:132.0/255.0 blue:132.0/255.0 alpha:1];
    shenglabel.text = @"剩余";
    CGSize maxSize3 = CGSizeMake(20, 20);
    CGSize expectedSize3 = [shenglabel.text sizeWithFont:shenglabel.font constrainedToSize:maxSize3 lineBreakMode:UILineBreakModeWordWrap];
    //shenglabel.frame = CGRectMake(268-expectedSize3.width - expectedSize2.width, 58, expectedSize3.width, expectedSize3.height);
    shenglabel.frame = CGRectMake(176, 55, 30, expectedSize3.height);

    
    [cellView addSubview:shenglabel];
    [level1 addSubview:levLabel1];
    [level2 addSubview:levLabel2];
    [level3 addSubview:levLabel3];
    [level4 addSubview:levLabel4];
    [level5 addSubview:levLabel5];
    [level6 addSubview:levLabel6];
    
    [cellView addSubview:allMoney];
    [cellView addSubview:moneyLabel];
    [cellView addSubview:yuanLabel];
    [cellView addSubview:userName];
    [cellView addSubview:level1];
    [cellView addSubview:level2];
    [cellView addSubview:level3];
    [cellView addSubview:level4];
    [cellView addSubview:level5];
    [cellView addSubview:level6];
   // [cellView addSubview:colorView];
    
    
    zhidingImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 20, 20)];
    zhidingImage.image = UIImageGetImageFromName(@"zhiding.png");
    [cellView addSubview:zhidingImage];
    zhidingImage.backgroundColor = [UIColor clearColor];
    [zhidingImage release];
    
    UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(295, 36, 8, 13)];
    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"jiantou_1.png");
    [cellView addSubview:jiantou];
    [jiantou release];
    
    return [cellView autorelease];
}

- (void)dealloc{
    [baoimage release];
    [baoCount release];
    [shenglabel release];
    [numLabel release];
    [fenlabel release];
    
    [level1 release];
    [level2 release];
    [level3 release];
    [level4 release];
    [level5 release];
    [level6 release];
    [levLabel1 release];
    [levLabel2 release];
    [levLabel3 release];
    [levLabel4 release];
    [levLabel5 release];
    [levLabel6 release];
    [moneyLabel release];
    [yuanLabel release];
    [allMoney release];
    [userName release];
    [baifenLabel release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
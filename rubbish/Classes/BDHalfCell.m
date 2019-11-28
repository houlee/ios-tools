//
//  BDHalfCell.m
//  caibo
//
//  Created by houchenguang on 14-3-6.
//
//

#import "BDHalfCell.h"

@implementation BDHalfCell
@synthesize wangqibool, panduan;
@synthesize butTitle;
@synthesize delegate;
@synthesize row, XIDANImageView,typeButtonArray, jcbool, danguanbool;
- (void)dealloc{
    [typeButtonArray release];
    [betData release];
    [super dealloc];
}

- (GC_BetData *)betData{
    return betData;
}
- (void)buttonShowType:(BOOL)ynbool button:(UIButton *)sender{
//    if ([self.typeButtonArray count] < sender.tag-1 ||[betData.jiantouArray count] < sender.tag -1  ) {
//        return;
//    }
    
    UILabel * imageItem = (UILabel *)[sender viewWithTag:sender.tag*10];
    UILabel * labelItem = (UILabel *)[sender viewWithTag:sender.tag*100];
    UIImageView * bgimage = (UIImageView *)[sender viewWithTag:sender.tag*12];
    UIImageView * bgimage2 = (UIImageView *)[sender viewWithTag:sender.tag*13];
    UIImageView  * jianImage = (UIImageView *)[sender viewWithTag:sender.tag*1000];
    UIImageView  * jianImage2 = (UIImageView *)[sender viewWithTag:sender.tag*1001];
    UIImageView  * jianImage3 = (UIImageView *)[sender viewWithTag:sender.tag*1002];
    UIImageView  * jianImage4 = (UIImageView *)[sender viewWithTag:sender.tag*1003];
    
    if (ynbool) {
        [self.typeButtonArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
        if (betData.dandan) {
            
            bgimage.hidden = YES;
            bgimage2.hidden = NO;
        }else{
            bgimage.hidden = NO;
            bgimage2.hidden = YES;
        }
        imageItem.textColor  = [UIColor whiteColor];
        labelItem.textColor = [UIColor whiteColor];
//        if (betData.jiantouArray) {
//            if ([betData.jiantouArray count]< 9) {
//                return;
//            }
//        }
        if ([betData.jiantouArray count]-1 >= sender.tag - 1) {
            if ([[betData.jiantouArray objectAtIndex:sender.tag - 1] isEqualToString:@"1"]) {
                jianImage.hidden = YES;
                jianImage2.hidden = YES;
                jianImage3.hidden = NO;
                jianImage4.hidden = YES;
            }else if ([[betData.jiantouArray objectAtIndex:sender.tag - 1] isEqualToString:@"2"]){
                jianImage.hidden = YES;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = NO;
            }else{
                jianImage.hidden = YES;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
            }
        
        }else{
            jianImage.hidden = YES;
            jianImage2.hidden = YES;
            jianImage3.hidden = YES;
            jianImage4.hidden = YES;
        }
        
        
        
    }else{
        
        bgimage.hidden = YES;
        bgimage2.hidden = YES;
        
        [self.typeButtonArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
        imageItem.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
//        if (betData.jiantouArray) {
//            if ([betData.jiantouArray count]< 9) {
//                return;
//            }
//        }
        
        if ([betData.jiantouArray count]-1 >= sender.tag - 1) {
            if ([[betData.jiantouArray objectAtIndex:sender.tag - 1] isEqualToString:@"1"]) {
                jianImage.hidden = NO;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
                
            }else if ([[betData.jiantouArray objectAtIndex:sender.tag - 1] isEqualToString:@"2"]){
                jianImage.hidden = YES;
                jianImage2.hidden = NO;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
            }else{
                jianImage.hidden = YES;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
            }
        }else{
            jianImage.hidden = YES;
            jianImage2.hidden = YES;
            jianImage3.hidden = YES;
            jianImage4.hidden = YES;
        
        }
        
        
    }
    
    
    
}
- (void)headShowType{
    
    if (boldan) {
//        changhaola.textColor  = [UIColor whiteColor];
        //        changhaoImage.image = UIImageGetImageFromName(@"changhaodan.png");
        seletChanghaoImage.hidden = NO;
        changhaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

    }else{
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        seletChanghaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        changhaoImage.hidden = NO;
        
        //        changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
        
    }
}
- (void)playVsTypeFunc{
    
    if ([betData.macthType isEqualToString:@"overtime"]) {
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(156, 18, 34, 12);
        vsImage.image = UIImageGetImageFromName(@"spfyijiezhi.png");
        vsImage.hidden = NO;
        
        NSArray * timedata = [betData.macthTime componentsSeparatedByString:@" "];
        if ([timedata count] >= 2) {
            timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
            //            timeLabel.font = [UIFont systemFontOfSize:11];
            //            timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        }else{
            timeLabel.text = @"-";
        }
        
        
    }else  if ([betData.macthType isEqualToString:@"onLive"]) {
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(153, 18, 41, 12);
        vsImage.image = UIImageGetImageFromName(@"spfzhibozhong.png");
        vsImage.hidden = NO;
        NSArray * timedata = [betData.macthTime componentsSeparatedByString:@" "];
        if ([timedata count] >= 2) {
            timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
        }else{
            timeLabel.text = @"-";
        }
        
    }else  if ([betData.macthType isEqualToString:@"gameover"]) {
        bifenLabel.hidden = NO;
        timeLabel.text = @"完";
        //        timeLabel.font = [UIFont systemFontOfSize:11];
        //        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        
        
        
    }else if ([betData.macthType isEqualToString:@"delay"]){
        
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(161, 18, 23, 12);
        vsImage.image = UIImageGetImageFromName(@"yanqiimagespf.png");
        vsImage.hidden = NO;
        timeLabel.text = @"延期";
        
        
    }else if([betData.macthType isEqualToString:@"playvs"]){
        //        timeLabel.text = @"-";
        //        timeLabel.font = [UIFont systemFontOfSize:11];
        //        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        vsImage.frame = CGRectMake(164, 16, 18, 15);
        vsImage.image = UIImageGetImageFromName(@"vsimage.png");
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", betData.time ];
        bifenLabel.hidden = YES;
        
    }
}
- (void)setBetData:(GC_BetData *)_betData{
    if (betData != _betData) {
        [betData release];
        betData = [_betData retain];
    }
    if ([betData.bufshuarr count] < 9) {
        betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }
    self.typeButtonArray = [NSMutableArray arrayWithArray:betData.bufshuarr] ;
    boldan = _betData.dandan;
    eventLabel.text = _betData.event;
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
    [self headShowType];
    if ([_betData.onePlural rangeOfString:@" 0,"].location == NSNotFound && [_betData.onePlural rangeOfString:@" 4,"].location == NSNotFound &&  jcbool ) {//判断 是否是单复式
        if (danguanbool) {
            onePluralImage.hidden = YES;
        }else{
            onePluralImage.hidden = NO;
        }

        
    }else {
        
        onePluralImage.hidden = YES;
    }
    if (jcbool) {
        if ([_betData.numzhou length] >= 5) {
            changhaola.text = [_betData.numzhou substringWithRange:NSMakeRange(2, 3)];
        }else{
            changhaola.text = @"";
        }
    }else{
        changhaola.text = _betData.bdnum;
    }
    self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
//    XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew1.png");
    timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _betData.time ];
    
    NSArray * teamarray = [_betData.team componentsSeparatedByString:@","];
    if ([teamarray count] > 1) {
        homeduiLabel.text = [teamarray objectAtIndex:0];
        keduiLabel.text = [teamarray objectAtIndex:1];
    }
    //    rangqiulabel.text = [NSString stringWithFormat:@"%d", [[teamarray objectAtIndex:2] intValue] ];
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
    //    NSInteger count = 1;
    
    NSArray * caiguo = [NSArray arrayWithObjects:@"胜-胜", @"胜-平", @"胜-负", @"平-胜",@"平-平", @"平-负", @"负-胜", @"负-平", @"负-负", nil];
//    if ([_betData.oupeiarr count] < 9) {
//        return;
//    }
    if (wangqibool && jcbool) {
       _betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }

    for (int i = 0; i < 9; i++) {
        if ([_betData.bufshuarr count]-1 < i) {
            return;
        }
        
//        if ([_betData.oupeiarr count]-1 < i || [_betData.jiantouArray count]-1 <i || [_betData.bufshuarr count]-1 < i) {
//            return;
//        }

        UIButton * itemButton = (UIButton *)[view viewWithTag:i+1];
       UILabel * imageItem = (UILabel *)[itemButton viewWithTag:(i+1)*10];
        NSLog(@"x = %f", itemButton.frame.origin.x);
        UILabel * labelItem = (UILabel *)[itemButton viewWithTag:(i+1)*100];
        UIImageView * winImage = (UIImageView *)[itemButton viewWithTag:(i+1)*11];
        UIImageView * jianImage = (UIImageView *)[itemButton viewWithTag:(i+1)*1000];
        UIImageView  * jianImage2 = (UIImageView *)[itemButton viewWithTag:(i+1)*1001];
        UIImageView  * jianImage3 = (UIImageView *)[itemButton viewWithTag:(i+1)*1002];
        UIImageView  * jianImage4 = (UIImageView *)[itemButton viewWithTag:(i+1)*1003];
        if ([_betData.oupeiarr count]-1 >= i) {
            if ([_betData.oupeiarr objectAtIndex:i]) {
                labelItem.text = [NSString stringWithFormat:@"%@", [_betData.oupeiarr objectAtIndex:i]];
            }else{
                labelItem.text =  @"";
            }
            
        }else{
            labelItem.text =  @"";
        }
        
//        if (betData.jiantouArray) {
//            if ([betData.jiantouArray count]< 9) {
//                return;
//            }
//        }
        if ([_betData.jiantouArray count]-1 >= i) {
            if ([[_betData.jiantouArray objectAtIndex:i] isEqualToString:@"1"]) {
                jianImage.hidden = NO;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
                
            }else if ([[_betData.jiantouArray objectAtIndex:i] isEqualToString:@"2"]){
                jianImage.hidden = YES;
                jianImage2.hidden = NO;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
            }else{
                jianImage.hidden = YES;
                jianImage2.hidden = YES;
                jianImage3.hidden = YES;
                jianImage4.hidden = YES;
            }
        }else{
            jianImage.hidden = YES;
            jianImage2.hidden = YES;
            jianImage3.hidden = YES;
            jianImage4.hidden = YES;
        
        }
        
        
        if (wangqibool && [_betData.caiguo isEqualToString:[caiguo objectAtIndex:i]]) {
            if (jcbool && ![betData.macthType isEqualToString:@"playvs"]) {
                
                [self buttonShowType:NO button:itemButton];
                imageItem.textColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
                winImage.hidden = YES;
                labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
                
                
            }else{
                [self buttonShowType:NO button:itemButton];
            }
            
            labelItem.textColor = [UIColor redColor];
            winImage.hidden = NO;
            imageItem.textColor = [UIColor redColor];
            
            
        }else{
            winImage.hidden = YES;
            if (jcbool && ![betData.macthType isEqualToString:@"playvs"]) {
               
                    [self buttonShowType:NO button:itemButton];
                    imageItem.textColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
                    winImage.hidden = YES;
                    labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
                    
                
            }else{
                if ([[_betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    
                    [self buttonShowType:YES button:itemButton];
                }else{
                    
                    [self buttonShowType:NO button:itemButton];
                }
            }
            
            if(wangqibool&& ![_betData.caiguo isEqualToString:[caiguo objectAtIndex:i]]){
                imageItem.textColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
                winImage.hidden = YES;
                labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
            }
            
        }
        
    }
    
    if (wangqibool) {
        zhegaiview.hidden = NO;
        if (![_betData.caiguo isEqualToString:@"取消"]) {
            if (_betData.bifen&&![_betData.bifen isEqualToString:@"-"]) {
                NSArray *scores = [_betData.bifen componentsSeparatedByString:@","];
                if ([scores count] > 3) {
                    bifenLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
                    timeLabel.text = @"完";
                }else{
                    bifenLabel.text = @"";
                    timeLabel.text = @"";
                    
                }
            }else{
                bifenLabel.text = @"-";
                timeLabel.text = @"...";
                
            }
            
        }else{
            
            bifenLabel.text = @"取消";
            timeLabel.text = @"";
        }
        
        bifenLabel.hidden = NO;
        vsImage.hidden = YES;
        
    }else{
        if (jcbool) {
            if ( ![betData.macthType isEqualToString:@"playvs"]) {
                zhegaiview.hidden = NO;
            }else{
                zhegaiview.hidden = YES;
            }
        }else{
            zhegaiview.hidden = YES;
        }
    
        bifenLabel.hidden = YES;
        vsImage.hidden = NO;
    }
    
    if (jcbool) {
        [self playVsTypeFunc];
    }

    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIView *)tableViewCell{
    self.backImageView.image = nil;
    self.butonScrollView.backgroundColor = [UIColor clearColor];
    //返回给cell的view
    view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 309, 98.5)] autorelease];
    //    view.backgroundColor = [UIColor redColor];
    view.tag = 1101;
    
    headimage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 309, 43)];
    headimage.backgroundColor = [UIColor whiteColor];
//    headimage.image = UIImageGetImageFromName(@"bjbeidan.png");
    headimage.userInteractionEnabled = YES;
    [self.contentView addSubview:headimage];
    [headimage release];
    
    UIView * oneHeadImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 309, 0.5)];
    oneHeadImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [headimage addSubview:oneHeadImage];
    [oneHeadImage release];
    
    UIView * twoHeadImage = [[UIView alloc] initWithFrame:CGRectMake(0, 42.5, 309, 0.5)];
    twoHeadImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [headimage addSubview:twoHeadImage];
    [twoHeadImage release];
    
    changhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaoImage.backgroundColor = [UIColor clearColor];
    changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
    [headimage addSubview:changhaoImage];
    [changhaoImage release];
    
    seletChanghaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    seletChanghaoImage.backgroundColor = [UIColor clearColor];
    seletChanghaoImage.image = UIImageGetImageFromName(@"changhaodan.png");
    [headimage addSubview:seletChanghaoImage];
    [seletChanghaoImage release];
    
    changhaola = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaola.backgroundColor = [UIColor clearColor];
    changhaola.textAlignment = NSTextAlignmentCenter;
    changhaola.font = [UIFont systemFontOfSize:9];
    //    changhaola.text = @"233";
    changhaola.textColor  = [UIColor whiteColor];
    [headimage addSubview:changhaola];
    [changhaola release];
    
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 49, 13)];
    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    //    eventLabel.text = @"单负式";
    eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];
    eventLabel.textAlignment = NSTextAlignmentLeft;
    
    [headimage addSubview:eventLabel];
    [eventLabel release];
    
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 26, 59, 14)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.backgroundColor = [UIColor clearColor];
    //    timeLabel.text = @"时间2232";
    timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:11];
    
    [headimage addSubview:timeLabel];
    [timeLabel release];
    
    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 16, 83, 14)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    //    homeduiLabel.text = @"的发酵劳动";
    [headimage addSubview:homeduiLabel];
    [homeduiLabel release];
    
    //让球
    rangqiulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 69, 14)];
    rangqiulabel.textAlignment = NSTextAlignmentCenter;
    rangqiulabel.font = [UIFont boldSystemFontOfSize:14];
    rangqiulabel.backgroundColor = [UIColor clearColor];
    rangqiulabel.textColor = [UIColor redColor];
    [headimage addSubview:rangqiulabel];
    [rangqiulabel release];
    
    
    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(164, 16, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    //    vsImage.hidden = YES;
    [headimage addSubview:vsImage];
    [vsImage release];
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(195,16, 83, 14)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    //    keduiLabel.text = @"地方撒的的";
    [headimage addSubview:keduiLabel];
    [keduiLabel release];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20, 14)];
    bifenLabel.textAlignment = NSTextAlignmentCenter;
    bifenLabel.font = [UIFont boldSystemFontOfSize:14];
    bifenLabel.backgroundColor = [UIColor clearColor];
    bifenLabel.textColor = [UIColor blackColor];
    bifenLabel.hidden = YES;
    //    bifenLabel.text = @"234:234";
    [headimage addSubview:bifenLabel];
    [bifenLabel release];
    
    NSInteger tagInt = 1;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.tag = tagInt;
            itemButton.frame = CGRectMake(j*84+(j* 0.5), i*32 + (i*0.5), 84, 32);
//            [itemButton setImage:UIImageGetImageFromName(@"bdzjq.png") forState:UIControlStateNormal];
//            [itemButton setImage:UIImageGetImageFromName(@"bdzjq.png") forState:UIControlStateDisabled];
            itemButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];

            [itemButton addTarget:self action:@selector(pressItemButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView * bgimage = [[UIImageView alloc] initWithFrame:itemButton.bounds];
            bgimage.tag = tagInt * 12;
            bgimage.hidden = YES;
            bgimage.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
//            bgimage.image = UIImageGetImageFromName(@"yibanxuanzhong.png");
            [itemButton addSubview:bgimage];
            [bgimage release];
            
            UIImageView * bgimage2 = [[UIImageView alloc] initWithFrame:itemButton.bounds];
            bgimage2.tag = tagInt * 13;
            bgimage2.hidden = YES;
            bgimage2.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
//            bgimage2.image=  UIImageGetImageFromName(@"shedanxuanzhogn.png");
            [itemButton addSubview:bgimage2];
            [bgimage2 release];
//            UIImageView * noImage = [[UIImageView alloc] initWithFrame:CGRectMake(9.5, (32- 9)/2, 21, 9)];
//            noImage.backgroundColor = [UIColor clearColor];
//            noImage.tag = tagInt*10;
//            NSString * str = [NSString stringWithFormat:@"banquanchang%d.png", tagInt];
//            noImage.image = UIImageGetImageFromName(str);
//            [itemButton addSubview:noImage];
//            [noImage release];
            
            UILabel * noLable = [[UILabel alloc] initWithFrame:CGRectMake(6.5, (32- 16)/2- 1, 30, 16)];
            noLable.textColor = [UIColor colorWithRed:34/255.0 green:80/255.0 blue:97/255.0 alpha:1];
            noLable.backgroundColor = [UIColor clearColor];
            noLable.tag = tagInt*10;
            noLable.font = [UIFont fontWithName:@"TRENDS" size:12];//@"时尚中黑简体" Academy Engraved LET
            [itemButton addSubview:noLable];
            [noLable release];
            
            if (tagInt == 1) {
               noLable.text = @"{{";
            }else if (tagInt == 2){
                noLable.text = @"{|";
            }else if (tagInt == 3){
                noLable.text = @"{}";
            }else if (tagInt == 4){
                noLable.text = @"|{";
            }else if (tagInt == 5){
                noLable.text = @"||";
            }else if (tagInt == 6){
                noLable.text = @"|}";
            }else if (tagInt == 7){
                noLable.text = @"}{";
            }else if (tagInt == 8){
                noLable.text = @"}|";
            }else if (tagInt == 9){
                noLable.text = @"}}";
            }

            
                       
            UILabel * labelItem = [[UILabel alloc] initWithFrame:CGRectMake(6.5+25, 0, 39, 32)];
            labelItem.backgroundColor = [UIColor clearColor];
            labelItem.tag = tagInt * 100;
            labelItem.textAlignment = NSTextAlignmentRight;
            labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
            labelItem.font = [UIFont systemFontOfSize:12];
//            labelItem.text = @"12.22";
            [itemButton addSubview:labelItem];
            [labelItem release];
            
      
            
            UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(82.5 - 3 - 7, (32 - 7)/2+1, 7, 7)];
            jiantou.backgroundColor = [UIColor clearColor];
            jiantou.tag = tagInt * 1000;

            jiantou.hidden = YES;
            jiantou.image = UIImageGetImageFromName(@"gc_shang.png");
            [itemButton addSubview:jiantou];
            [jiantou release];
            UIImageView * jiantou2 = [[UIImageView alloc] initWithFrame:CGRectMake(82.5 - 3 - 7, (32 - 7)/2+1, 7, 7)];
            jiantou2.backgroundColor = [UIColor clearColor];
            jiantou2.tag = tagInt * 1001;
            jiantou2.image = UIImageGetImageFromName(@"gc_xiangxia.png");
            [itemButton addSubview:jiantou2];
            jiantou2.hidden = YES;
            [jiantou2 release];
            UIImageView * jiantou3 = [[UIImageView alloc] initWithFrame:CGRectMake(82.5 - 3 - 7, (32 - 7)/2+1, 7, 7)];
            jiantou3.backgroundColor = [UIColor clearColor];
            jiantou3.tag = tagInt * 1002;
            jiantou3.hidden = YES;
            jiantou3.image = UIImageGetImageFromName(@"baijiantous.png");
            [itemButton addSubview:jiantou3];
            [jiantou3 release];
            UIImageView * jiantou4 = [[UIImageView alloc] initWithFrame:CGRectMake(82.5 - 3 - 7, (32 - 7)/2+1, 7, 7)];
            jiantou4.backgroundColor = [UIColor clearColor];
            jiantou4.tag = tagInt * 1003;
            jiantou4.hidden = YES;
            jiantou4.image = UIImageGetImageFromName(@"baijiantoux.png");
            [itemButton addSubview:jiantou4];
            [jiantou4 release];

            UIImageView * winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 8, 8)];
            winImage1.backgroundColor = [UIColor clearColor];
            winImage1.tag = tagInt * 11;
            winImage1.hidden = YES;
            winImage1.image=  UIImageGetImageFromName(@"winImagenew.png");
            [itemButton addSubview:winImage1];
            [winImage1 release];
            
            
            
            [view addSubview:itemButton];
            
            tagInt++;
            
        }
        
        
    }
    
    XIDANImageView = [[UIImageView alloc] initWithFrame:CGRectMake(253.5, 0, 55.5, 97)];
    XIDANImageView.backgroundColor = [UIColor clearColor];
    //    XIDANImageView.hidden = YES;
    XIDANImageView.userInteractionEnabled = YES;
    XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
    
    UIButton * xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xidanButton.frame = XIDANImageView.bounds;
    [xidanButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [XIDANImageView addSubview:xidanButton];
    //    xidanButton.hidden = YES;
    
    
    butTitle = [[UILabel alloc] init];
    butTitle.frame = CGRectMake(0, 52, 55.5, 20);
    butTitle.font = [UIFont systemFontOfSize:11];
    butTitle.textAlignment = NSTextAlignmentCenter;
    butTitle.textColor = [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
    butTitle.backgroundColor = [UIColor clearColor];
    [XIDANImageView addSubview:butTitle];
    [butTitle release];
    
    [view addSubview:XIDANImageView];
    [XIDANImageView release];
    
    UIView * linebutton = [[UIView alloc] initWithFrame:CGRectMake(0, 32, 253.5, 0.5)];
    linebutton.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [view addSubview:linebutton];
    [linebutton release];
    
    UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 253.5, 0.5)];
    linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [view addSubview:linebutton2];
    [linebutton2 release];
    
    UIView * linebutton3 = [[UIView alloc] initWithFrame:CGRectMake(84, 0, 0.5, 97)];
    linebutton3.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [view addSubview:linebutton3];
    [linebutton3 release];
    
    UIView * linebutton4 = [[UIView alloc] initWithFrame:CGRectMake(168.5, 0, 0.5, 97)];
    linebutton4.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [view addSubview:linebutton4];
    [linebutton4 release];
    
    UIView * linebutton5 = [[UIView alloc] initWithFrame:CGRectMake(253, 0, 0.5, 97)];
    linebutton5.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [view addSubview:linebutton5];
    [linebutton5 release];

    
    UIImageView * shuImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 0.5, 140.5)];
    shuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    shuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:shuImage];
    [shuImage release];
    
    UIImageView * hengImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 140+3, 309, 1.5)];
    hengImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    hengImage.image = UIImageGetImageFromName(@"rqspfheng.png");
    [self.contentView addSubview:hengImage];
    [hengImage release];
    
    UIImageView * houshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(308.5+5.5, 3, 0.5, 140.5)];
    houshuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    houshuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:houshuImage];
    [houshuImage release];
    
     zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame= CGRectMake(0, 0, 309-55.5, view.frame.size.height);
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
    
    onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 4, 4)];
    onePluralImage.hidden = YES;
    onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
    [view addSubview:onePluralImage];
    [onePluralImage release];
    
    
    return view;
}

- (void)presszhegaiviewButton:(UIButton *)sender{
    
}

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        
        [delegate returnbifenCellInfo:index shuzu:bufshuzu dan:booldan];
    }
    
}
- (void)sleepfunc{
    
    [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:boldan];
}


- (void)pressItemButton:(UIButton *)sender{
    
    if ([[self.typeButtonArray objectAtIndex:sender.tag - 1] isEqualToString:@"1"]) {
        [self buttonShowType:NO button:sender];
    }else{
        [self buttonShowType:YES button:sender];
        
    }
    BOOL yesOrNO = NO;
    for (int i = 0; i < [self.typeButtonArray count]; i++) {
        if ([[self.typeButtonArray objectAtIndex:i] isEqualToString:@"1"]) {
            yesOrNO = YES;
            break;
        }
    }
    
    if (yesOrNO == NO) {
        betData.dandan = NO;
        boldan = NO;
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        seletChanghaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        changhaoImage.hidden = NO;
    }else{
        
        [self headShowType];
    }

    [self performSelector:@selector(sleepfunc) withObject:nil afterDelay:0.1];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:type];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.butonScrollView.delegate = self;
        [self.butonScrollView addSubview:[self tableViewCell]];
        
        UIImageView * scrollViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(309, 3, 240, 64)];
        scrollViewBack.tag = 1102;
        scrollViewBack.backgroundColor = [UIColor clearColor];
        scrollViewBack.userInteractionEnabled = YES;
        [self.butonScrollView addSubview:scrollViewBack];
        [scrollViewBack release];
        view.frame = CGRectMake(0, view.frame.origin.y+20, view.frame.size.width, view.frame.size.height);
        
        self.butonScrollView.pagingEnabled = YES;
        self.butonScrollView.showsHorizontalScrollIndicator = NO;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        panduan = NO;
        
        
        self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23+3, self.butonScrollView.frame.size.width, 117);
        
        self.butonScrollView.backgroundColor = [UIColor clearColor];
        view.backgroundColor = [UIColor clearColor];
        
        //        xibutton.frame = CGRectMake(xibutton.frame.origin.x, xibutton.frame.origin.y, xibutton.frame.size.width, 43);
        //        [self.contentView insertSubview:xibutton atIndex:10001];
        
        
        
        
    }
    return self;
}

- (void)pressHeadButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(openCell:)]) {
        [delegate openCell:self];
    }
}
- (void)contenOffSetXYFunc{
    NSInteger xcount = 0;
    
    xcount = [self.allTitleArray count]*70;
    
    if (self.butonScrollView.contentOffset.x >= xcount) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            
            
            NSIndexPath * path = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            [delegate returnCellContentOffsetString:path remove:NO];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    }else if (self.butonScrollView.contentOffset.x <= 0) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            NSIndexPath * path = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            [delegate returnCellContentOffsetString:path remove:YES];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    NSInteger xcount = 0;
    
    xcount = [self.allTitleArray count]*70;
    
    
    if (self.butonScrollView.contentOffset.x >= xcount || self.butonScrollView.contentOffset.x <= 0) {
        [self contenOffSetXYFunc];
    }
    
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
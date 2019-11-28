//
//  MatchBetView.m
//  caibo
//
//  Created by houchenguang on 14-5-20.
//
//

#import "MatchBetView.h"
#import "caiboAppDelegate.h"

@implementation MatchBetView
@synthesize homeLabel, guestLabel, delegate;
@synthesize betData, typeButtonArray;
@synthesize  competitionLabel, timeLabel, homeNumber, guestNumber;

- (void)dealloc{
    [typeButtonArray release];
    [selectArray release];
    [super dealloc];
}

- (void)setButtonType:(MatchButtonType)_buttonType{
   buttonType = _buttonType;
    NSLog(@"asfasdf = %@", self.betData.bufshuarr);
    if (buttonType == jcHunheguoguanType ) {
        if (self.betData.bufshuarr) {
            
            self.typeButtonArray = [NSMutableArray arrayWithArray:self.betData.bufshuarr];
        }else{
            self.typeButtonArray = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < 6; i++) {
                [self.typeButtonArray addObject:@"0"];
            }
        }
    }else{
        self.typeButtonArray = [NSMutableArray arrayWithArray:self.betData.bufshuarr];
    }

    
    
    
    
    [self showButtonFunc];
}

- (MatchButtonType)buttonType{
    return buttonType;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        
    }
    return self;
}

- (void)pressTeamButton:(UIButton *)sender{//胜平负一类的点击
    
    if (self.buttonType == jcShengpingfuType || self.buttonType == bdRangqiushengpingfuType) {
        
        UILabel * text1 = (UILabel *)[sender viewWithTag:10];
        UILabel * text2 = (UILabel *)[sender viewWithTag:11];
        UILabel * text3 = (UILabel *)[sender viewWithTag:12];
        UILabel * text4 = (UILabel *)[sender viewWithTag:13];
        
        if (sender.selected == NO) {
            sender.selected = YES;
            text1.textColor = [UIColor whiteColor];
            text2.textColor = [UIColor whiteColor];
            text3.textColor = [UIColor whiteColor];
            text4.textColor = [UIColor whiteColor];
            if (self.buttonType == bdRangqiushengpingfuType) {
                UILabel * ranglabel = (UILabel *)[sender viewWithTag:14];
                ranglabel.textColor = [UIColor whiteColor];
            }
            
        }else{
            sender.selected = NO;
            text1.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            text2.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            text3.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            text4.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            if (self.buttonType == bdRangqiushengpingfuType) {
                UILabel * ranglabel = (UILabel *)[sender viewWithTag:14];
                ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
        }
        
        
    }else{// if (self.buttonType == jcHunheguoguanType || self.buttonType == jcHunheerxuanyiType || self.buttonType == bdJinqiushuType)
    
        UILabel * text1 = (UILabel *)[sender viewWithTag:10];
        UILabel * text2 = (UILabel *)[sender viewWithTag:11];

        if (self.buttonType == jcHunheguoguanType || self.buttonType == bdShengfuguoguanType) {
            
            UILabel * rangLabel = (UILabel *)[sender viewWithTag:14];
            if (sender.selected == NO) {
                rangLabel.textColor = [UIColor whiteColor];
                
            }else{
                rangLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
        }
        
        if (sender.selected == NO) {
            sender.selected = YES;
            text1.textColor = [UIColor whiteColor];
            text2.textColor = [UIColor whiteColor];
            
        }else{
            sender.selected = NO;
            text1.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            text2.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            
        }
        
        
        
        
    }
    
    if (self.buttonType == jcShengpingfuType || self.buttonType == bdRangqiushengpingfuType || self.buttonType == jcHunheerxuanyiType || self.buttonType == bdShengfuguoguanType||self.buttonType == sfcshengpingfuType) {
        
        if (sender.tag == 1) {
            if (sender.selected) {
                self.betData.selection1 = YES;
            }else{
                self.betData.selection1 = NO;
            }
        }
        if (sender.tag == 2) {
            if (sender.selected) {
                self.betData.selection2 = YES;
            }else{
                self.betData.selection2 = NO;
            }
        }
        
        if (sender.tag == 3) {
            if (sender.selected) {
                self.betData.selection3 = YES;
            }else{
                self.betData.selection3 = NO;
            }
        }
        
    }else{
        if ([self.typeButtonArray count] > sender.tag-1) {
            if ([[self.typeButtonArray objectAtIndex:sender.tag-1] isEqualToString:@"1"]) {
                
                [self.typeButtonArray replaceObjectAtIndex:sender.tag-1 withObject:@"0"];
                
            }else{
                [self.typeButtonArray replaceObjectAtIndex:sender.tag-1 withObject:@"1"];
            }
        }
       
        
    }
    
    if (delegate && [delegate respondsToSelector:@selector(matchBetViewWithBetData:withType:)]) {
        if (self.buttonType == jcShengpingfuType || self.buttonType == bdRangqiushengpingfuType || self.buttonType == jcHunheerxuanyiType || self.buttonType == bdShengfuguoguanType||self.buttonType == sfcshengpingfuType) {
            [delegate matchBetViewWithBetData:self.betData withType:1];
        }else{
            betData.bufshuarr = self.typeButtonArray;
            [delegate matchBetViewWithBetData:self.betData withType:2];
        }
        
    }
    
}

- (void)pressTouchButton:(UIButton *)sender{//比分类型的点击

    BFYCBoxView * boxView = [[BFYCBoxView alloc] init];
    boxView.betData = self.betData;
    boxView.delegate = self;
    if (buttonType == jcBanchangshengpingfuType){
        boxView.boxType = jcbanquanchangboxtype;
    }else if (buttonType == jcZongjinqiuType){
        boxView.boxType = jczongjinqiuboxtype;
    }else if (buttonType == bdBifenType){
        boxView.boxType = bdbifenboxtype;
    }else if (buttonType == jcBifenType){
        boxView.boxType = jcbifenboxtype;
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:boxView];
    [boxView release];
    
   
    
}

- (void)showCellLabelString:(GC_BetData *)_betData{
    
    NSMutableArray * bifenarr = nil;

    if (buttonType == jcZongjinqiuType) {
        bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
    }else if (buttonType == jcBanchangshengpingfuType){
        bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
    }else if (buttonType == jcBifenType){
        bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
    }else if (buttonType == bdBifenType){
        bifenarr = [NSMutableArray arrayWithObjects:@"1:0", @"2:0", @"2:1", @"3:0", @"3:1", @"3:2", @"4:0", @"4:1", @"4:2", @"胜其他", @"0:0", @"1:1", @"2:2", @"3:3", @"平其他", @"0:1", @"0:2", @"1:2", @"0:3", @"1:3", @"2:3", @"0:4", @"1:4", @"2:4", @"负其他", nil];
    }
    NSString * stringCell = @"";
    for (int i = 0; i < [bifenarr count]; i++) {
        if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            stringCell = [NSString stringWithFormat:@"%@%@,", stringCell, [bifenarr objectAtIndex:i]];
        }
    }
 
    if ([stringCell length] > 0) {
        stringCell =  [stringCell substringToIndex:[stringCell length] -1];
        _betData.cellstring = stringCell;
        
    }else{
        _betData.cellstring= @"点击选择投注选项";
    }
    
    if (_betData.cellstring && [_betData.cellstring length] > 0)  {
        touLabel.text = self.betData.cellstring;
    }else{
        touLabel.text = @"点击选择投注选项";
    }
}

- (void)bfycBoxView:(BFYCBoxView *)boxView whithBetData:(GC_BetData *)_betData{
    
    [self showCellLabelString:_betData];
    
    
    if (delegate && [delegate respondsToSelector:@selector(matchBetViewWithBetData:withType:)]) {
        [delegate matchBetViewWithBetData:_betData withType:2];
    }
    
}

- (void)showButtonFunc{
    
    [selectArray removeAllObjects];
    
    
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 103, 302, 0)];
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.image = [UIImageGetImageFromName(@"touzhukuangbf.png") stretchableImageWithLeftCapWidth:11 topCapHeight:10];
    [self addSubview:bgImageView];
    [bgImageView release];
    
    UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 103, 0, 0)];
    lineView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self addSubview:lineView];
    [lineView release];
    
    if (self.buttonType == jcHunheguoguanType) {
        
        float width = 302.0/3.0;
        float height = 63.0/2.0;
        for (int i = 0; i < 6; i++) {
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            if (i < 3) {
                teamButton.frame = CGRectMake(i * width, 0, width, height);
            }else{
                teamButton.frame = CGRectMake((i - 3) * width, height, width, height);
            }
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
//            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
            if (i == 0 || i == 3) {
                textLabel.text = @"胜";
            }else if (i == 1 || i == 4){
                textLabel.text = @"平";
            }else if (i == 2 || i == 5){
                textLabel.text = @"负";
            }
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, width - 21, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            peiLabel.text = [self.betData.oupeiarr objectAtIndex:i];
//             peiLabel.text = @"232.04";//ceshi
//            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            if (i < 3) {
                UIImageView * hengline = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 0.5, width, 0.5)];
                hengline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:hengline];
                [hengline release];
            }
            
            if (i == 0 || i == 1 || i == 3 || i == 4)  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            
            if (i == 0) {
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoshang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 1 || i == 4){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczhong.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 2){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyoushang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 3){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 5){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyouxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            
            
            if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
            
            if ([[self.betData.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                teamButton.enabled = NO;
            }else{
                teamButton.enabled = YES;
            }
            
            
            
            if ( i == 3) {
                UILabel * ranglabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 13,0, 13, height)];
                ranglabel.backgroundColor = [UIColor clearColor];
                ranglabel.textAlignment = NSTextAlignmentLeft;
                ranglabel.font = [UIFont systemFontOfSize:8];
                ranglabel.tag = 14;
                NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
                if ([teamarray count] >= 3) {
                    if ([[teamarray objectAtIndex:2] floatValue] == 0.00) {
                        ranglabel.text = @"";
                    }else{
//                        if (fabs([[teamarray objectAtIndex:2] floatValue]) > abs([[teamarray objectAtIndex:2] intValue])) {
                            ranglabel.text = [teamarray objectAtIndex:2];
//                        }else{
//                            ranglabel.text = [NSString stringWithFormat:@"%d", [[teamarray objectAtIndex:2] intValue]];
//                        }
                        
                    }
                    
                }
                if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    ranglabel.textColor = [UIColor whiteColor];
                }else{
                    ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                }
                
                [teamButton addSubview:ranglabel];
                [ranglabel release];
            }
        }
        
        
        
        
        
        bgImageView.frame = CGRectMake(10, 103, 302, 63);
//         peilvButton.frame = CGRectMake(320 - 48, 103, 38, 63);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 175, 320, 1);
        
        self.frame = CGRectMake(0, 0, 320, 176);
        
    }else if(self.buttonType == sfcshengpingfuType){
    
        float width = 302.0/3.0;
        float height = 31;
        for (int i = 0; i < 3; i++) {
            //            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            
            teamButton.frame = CGRectMake(i * width, 0, width, height);
            
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
            //            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
            
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, width - 21, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            //            peiLabel.text = [betData.oupeiarr objectAtIndex:i];
            //            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            

            
            if (i == 0 ) {
                textLabel.text = @"胜";
                peiLabel.text = self.betData.but1;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuo.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 1 ){
                textLabel.text = @"平";
                peiLabel.text = self.betData.but2;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczhong.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 2 ){
                textLabel.text = @"负";
                peiLabel.text = self.betData.but3;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyou.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            
            
            
            
            
            if (i == 0 || i == 1 )  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            if ((self.betData.selection1&&i==0) || (self.betData.selection2&&i==1) || (self.betData.selection3&&i==2)) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
               
                if (self.buttonType == bdRangqiushengpingfuType) {
                    UILabel * ranglabel = (UILabel *)[teamButton viewWithTag:14];
                    ranglabel.textColor = [UIColor whiteColor];
                }
            }else{
                teamButton.selected = NO;
                
                textLabel.textColor =[ UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
               
                if (self.buttonType == bdRangqiushengpingfuType) {
                    UILabel * ranglabel = (UILabel *)[teamButton viewWithTag:14];
                    ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                }
            }
            
        }
        bgImageView.frame = CGRectMake(10, 103, 302, 31);
        //        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 31);
        //        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
        //        peilvLabel.font = [UIFont systemFontOfSize:12];
        //        peilvLabel.frame = CGRectMake(2, 0, 34, 31);
        lineView.frame = CGRectMake(0, 143, 320, 1);
        
        self.frame = CGRectMake(0, 0, 320, 144);
    }else if (self.buttonType == jcShengpingfuType||self.buttonType == bdRangqiushengpingfuType){
        
        float width = 302.0/3.0;
        float height = 31;
        for (int i = 0; i < 3; i++) {
//            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            
            teamButton.frame = CGRectMake(i * width, 0, width, height);
           
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, height/2.0)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
//            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
           
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, width - 21, height/2.0)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
//            peiLabel.text = [betData.oupeiarr objectAtIndex:i];
//            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            
            UILabel * ouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/2.0, 21, height/2.0)];
            ouLabel.backgroundColor = [UIColor clearColor];
            ouLabel.textAlignment = NSTextAlignmentRight;
            ouLabel.font = [UIFont systemFontOfSize:12];
            ouLabel.tag = 12;
            ouLabel.text = @"欧";
            ouLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            [teamButton addSubview:ouLabel];
            [ouLabel release];
            
            UILabel * oupeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, height/2.0, width - 21, height/2.0)];
            oupeiLabel.backgroundColor = [UIColor clearColor];
            oupeiLabel.textAlignment = NSTextAlignmentCenter;
            oupeiLabel.font = [UIFont systemFontOfSize:12];
            oupeiLabel.tag = 13;
            NSArray * oupeiPeilv = [self.betData.oupeiPeilv componentsSeparatedByString:@" "];
            if ([oupeiPeilv count] > i) {
                oupeiLabel.text = [oupeiPeilv objectAtIndex:i];
            }else{
                oupeiLabel.text = @"";
            }
            
            oupeiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            [teamButton addSubview:oupeiLabel];
            [oupeiLabel release];
            
            if (i == 0 ) {
                textLabel.text = @"胜";
                peiLabel.text = self.betData.but1;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuo.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 1 ){
                textLabel.text = @"平";
                peiLabel.text = self.betData.but2;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczhong.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 2 ){
                textLabel.text = @"负";
                peiLabel.text = self.betData.but3;
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyou.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            
            if (self.buttonType == bdRangqiushengpingfuType && i == 0) {
                UILabel * ranglabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 14,0, 14, height/2.0)];
                ranglabel.backgroundColor = [UIColor clearColor];
                ranglabel.textAlignment = NSTextAlignmentLeft;
                ranglabel.font = [UIFont systemFontOfSize:8];
                ranglabel.tag = 14;
                 NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
                if ([teamarray count] >= 3) {
                    if ([[teamarray objectAtIndex:2] floatValue] == 0.00) {
                        ranglabel.text = @"";
                    }else{
                         if (fabs([[teamarray objectAtIndex:2] floatValue]) > abs([[teamarray objectAtIndex:2] intValue])) {
                            ranglabel.text = [teamarray objectAtIndex:2];
                        }else{
                            ranglabel.text = [NSString stringWithFormat:@"%d", [[teamarray objectAtIndex:2] intValue]];
                        }
                        
                    }
                   
                }
                
                ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:ranglabel];
                [ranglabel release];
            }
           
            
            
            
            if (i == 0 || i == 1 )  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            if ((self.betData.selection1&&i==0) || (self.betData.selection2&&i==1) || (self.betData.selection3&&i==2)) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
                ouLabel.textColor = [UIColor whiteColor];
                oupeiLabel.textColor = [UIColor whiteColor];
                if (self.buttonType == bdRangqiushengpingfuType) {
                    UILabel * ranglabel = (UILabel *)[teamButton viewWithTag:14];
                    ranglabel.textColor = [UIColor whiteColor];
                }
            }else{
                 teamButton.selected = NO;
                textLabel.textColor =[ UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                ouLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                oupeiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                if (self.buttonType == bdRangqiushengpingfuType) {
                    UILabel * ranglabel = (UILabel *)[teamButton viewWithTag:14];
                    ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                }
            }
            
        }
        bgImageView.frame = CGRectMake(10, 103, 302, 31);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 31);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:12];
//        peilvLabel.frame = CGRectMake(2, 0, 34, 31);
        lineView.frame = CGRectMake(0, 143, 320, 1);
        
         self.frame = CGRectMake(0, 0, 320, 144);
        
    }else if (self.buttonType == jcBifenType||self.buttonType == bdBifenType){
        
        bgImageView.frame = CGRectMake(10, 103, 302, 31);
        
        UIButton * touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touchButton.frame = bgImageView.bounds;
        [touchButton addTarget:self action:@selector(pressTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:touchButton];
        
        touLabel = [[UILabel alloc] initWithFrame:bgImageView.bounds];
        touLabel.backgroundColor = [UIColor clearColor];
        touLabel.textAlignment = NSTextAlignmentCenter;
        touLabel.font = [UIFont systemFontOfSize:12];
        [self showCellLabelString:self.betData];
//        if (buttonType == bdBifenType) {
//            [self showCellLabelString:self.betData];
//        }else{
//            if (self.betData.cellstring && [self.betData.cellstring length] > 0)  {
//                touLabel.text = self.betData.cellstring;
//            }else{
//                touLabel.text = @"点击选择投注选项";
//            }
//        }
        
       
        touLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
        [bgImageView addSubview:touLabel];
        [touLabel release];
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 31);
//         peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:12];
//        peilvLabel.frame = CGRectMake(2, 0, 34, 31);
        lineView.frame = CGRectMake(0, 143, 320, 1);
         self.frame = CGRectMake(0, 0, 320, 144);
        
    }else if (self.buttonType == jcHunheerxuanyiType){
        
        
        float width = 302.0/2.0;
        float height = 31;
        for (int i = 0; i < 2; i++) {
//            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            
            teamButton.frame = CGRectMake(i * width, 0, width, height);
            
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
            textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            textLabel.tag = 10;
        
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, width - 21, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            
//            peiLabel.text = [betData.oupeiarr objectAtIndex:i];
            peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            
            
            
            
            if (i == 0 ) {
                textLabel.text = @"胜";
                peiLabel.text = self.betData.but1;
            }else if (i == 1 ){
                textLabel.text = @"不败";
                peiLabel.text = self.betData.but2;
            }
            
            if (i == 0 )  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuo.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else{
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyou.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            if ((self.betData.selection1&&i==0) || (self.betData.selection2&&i==1) ) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];

            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];

            }
            
            
            
        }
        
        
        NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
        NSString * rangqiuString = @"";
        if ([teamarray count] > 2) {
            rangqiuString = [teamarray objectAtIndex:2];
        }
        
        UIButton * oneButton = (UIButton *)[bgImageView viewWithTag:1];
        UIButton * twoButton = (UIButton *)[bgImageView viewWithTag:2];
        UILabel * onenamela = (UILabel *)[oneButton viewWithTag:10];
        UILabel * onepei = (UILabel *)[oneButton viewWithTag:11];
        UILabel * twonamela = (UILabel *)[twoButton viewWithTag:10];
        UILabel * twopei = (UILabel *)[twoButton viewWithTag:11];
        
        if ([rangqiuString intValue] > 0) {
            
            if ([self.betData.oupeiarr count] > 3) {
                onepei.text = [self.betData.oupeiarr objectAtIndex:3];
            }
            if ([self.betData.oupeiarr count] > 2) {
                twopei.text = [self.betData.oupeiarr objectAtIndex:2];
            }
            onenamela.text = @"不败";
            twonamela.text = @"胜";
            
            
        }else{
            
            if ([self.betData.oupeiarr count] > 0) {
                onepei.text = [self.betData.oupeiarr objectAtIndex:0];
            }
            if ([self.betData.oupeiarr count] > 5) {
                twopei.text = [self.betData.oupeiarr objectAtIndex:5];
            }
            onenamela.text = @"胜";
            twonamela.text = @"不败";
            
        }
        
        
        bgImageView.frame = CGRectMake(10, 103, 302, 31);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 31);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:12];
//        peilvLabel.frame = CGRectMake(2, 0, 34, 31);
        lineView.frame = CGRectMake(0, 143, 320, 1);
         self.frame = CGRectMake(0, 0, 320, 144);
        
    }else if (self.buttonType == bdJinqiushuType || self.buttonType == jcZongjinqiuType){
        
        float width = 302.0/4.0;
        float height = 63.0/2.0;
        for (int i = 0; i < 8; i++) {
            //            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            if (i < 4) {
                teamButton.frame = CGRectMake(i * width, 0, width, height);
            }else{
                teamButton.frame = CGRectMake((i - 4) * width, height, width, height);
            }
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 20, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont fontWithName:@"04b" size:15];
//            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
            if (i <7) {
                textLabel.text = [NSString stringWithFormat:@"%d", i];
            }else{
                textLabel.text = @"7+";
            }
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 39, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentRight;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            peiLabel.text = [self.betData.oupeiarr objectAtIndex:i];
//            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            if (i < 4) {
                UIImageView * hengline = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 0.5, width, 0.5)];
                hengline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:hengline];
                [hengline release];
            }
            
            if (i == 0 || i == 1 || i == 2 || i == 4 || i == 5 || i == 6)  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            
            if (i == 0) {
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoshang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 1 || i == 2 || i == 5 || i == 6){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczhong.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 3){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyoushang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 4){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 7){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyouxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            
            if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
            if ([[self.betData.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                teamButton.enabled = NO;
            }else{
                teamButton.enabled = YES;
            }
        }
        
        
        
        bgImageView.frame = CGRectMake(10, 103, 302, 63);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 63);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 175, 320, 1);
        
        self.frame = CGRectMake(0, 0, 320, 176);
    }else if (self.buttonType == bdShangxiadanshuangType){
        
        float width = 302.0/2.0;
        float height = 63.0/2.0;
        for (int i = 0; i < 4; i++) {
            //            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            if (i < 2) {
                teamButton.frame = CGRectMake(i * width, 0, width, height);
            }else{
                teamButton.frame = CGRectMake((i - 2) * width, height, width, height);
            }
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
//            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
            if (i == 0) {
                textLabel.text = @"上+单";
            }else if (i == 1){
                textLabel.text = @"上+双";
            }else if (i == 2){
                textLabel.text = @"下+单";
            }else if (i == 3){
                textLabel.text = @"下+双";
            }
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 0, width - 56, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            peiLabel.text = [self.betData.oupeiarr objectAtIndex:i];
//            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            if (i < 2) {
                UIImageView * hengline = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 0.5, width, 0.5)];
                hengline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:hengline];
                [hengline release];
            }
            
            if (i == 0 || i == 2 )  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            
            if (i == 0) {
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoshang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 1){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyoushang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 2){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 3){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyouxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
            if ([[self.betData.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                teamButton.enabled = NO;
            }else{
                teamButton.enabled = YES;
            }
        }
        
        
        
        bgImageView.frame = CGRectMake(10, 103, 302, 63);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 63);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 175, 320, 1);
        
        self.frame = CGRectMake(0, 0, 320, 176);
        
    }else if (self.buttonType == bdBanquanchangType || self.buttonType == jcBanchangshengpingfuType){
        
        float width = 302.0/3.0;
        float height = 93.0/3.0;
        for (int i = 0; i < 9; i++) {
            //            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            if (i < 3) {
                teamButton.frame = CGRectMake(i * width, 0, width, height);
            }else if(i < 6){
                teamButton.frame = CGRectMake((i - 3) * width, height, width, height);
            }else{
                teamButton.frame = CGRectMake((i - 6) * width, height*2, width, height);
            }
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
//            textLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            textLabel.tag = 10;
            if (i == 0) {
                textLabel.text = @"胜胜";
            }else if (i == 1){
                textLabel.text = @"胜平";
            }else if (i == 2){
                textLabel.text = @"胜负";
            }else if (i == 3){
                textLabel.text = @"平胜";
            }else if (i == 4){
                textLabel.text = @"平平";
            }else if (i == 5){
                textLabel.text = @"平负";
            }else if (i == 6){
                textLabel.text = @"负胜";
            }else if (i == 7){
                textLabel.text = @"负平";
            }else if (i == 8){
                textLabel.text = @"负负";
            }
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, width - 33, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
            peiLabel.text = [self.betData.oupeiarr objectAtIndex:i];
//            peiLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            if (i < 6) {
                UIImageView * hengline = [[UIImageView alloc] initWithFrame:CGRectMake(0, height - 0.5, width, 0.5)];
                hengline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:hengline];
                [hengline release];
            }
            
            if (i == 0 || i == 1 || i == 3 || i == 4 || i == 6 || i == 7)  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
            }
            
            if (i == 0) {
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoshang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 2){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyoushang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 6){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuoxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else if (i == 8){
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyouxia.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else {
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczhong.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            if ([[self.betData.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
            if ([[self.betData.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                teamButton.enabled = NO;
            }else{
                teamButton.enabled = YES;
            }
        }
        
        
        
        bgImageView.frame = CGRectMake(10, 103, 302, 93);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 93);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 205, 320, 1);
        
        self.frame = CGRectMake(0, 0, 320, 206);
        
    }else if (self.buttonType == bdShengfuguoguanType){
        
        float width = 302.0/2.0;
        float height = 31;
        for (int i = 0; i < 2; i++) {
            //            [selectArray addObject:@"0"];
            UIButton * teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
            teamButton.tag = i+1;
            
            teamButton.frame = CGRectMake(i * width, 0, width, height);
            
            [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:teamButton];
            
            UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, height)];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textAlignment = NSTextAlignmentRight;
            textLabel.font = [UIFont systemFontOfSize:12];
            textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            textLabel.tag = 10;
            
            [teamButton addSubview:textLabel];
            [textLabel release];
            
            UILabel * peiLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, width - 21, height)];
            peiLabel.backgroundColor = [UIColor clearColor];
            peiLabel.textAlignment = NSTextAlignmentCenter;
            peiLabel.font = [UIFont systemFontOfSize:12];
            peiLabel.tag = 11;
//            peiLabel.text = [betData.oupeiarr objectAtIndex:i];
            peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            [teamButton addSubview:peiLabel];
            [peiLabel release];
            
            if (i == 0 ) {
                textLabel.text = @"胜";
                peiLabel.text = self.betData.but1;
//                peiLabel.text = @"232.04";//ceshi
            }else if (i == 1 ){
                textLabel.text = @"负";
                peiLabel.text = self.betData.but2;
//                 peiLabel.text = @"232.04";//ceshi
            }
            
            if (i == 0 )  {
                UIImageView * shuline = [[UIImageView alloc] initWithFrame:CGRectMake(width - 0.5, 0, 0.5, height)];
                shuline.backgroundColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                [teamButton addSubview:shuline];
                [shuline release];
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfyczuo.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }else{
                [teamButton setBackgroundImage:[UIImageGetImageFromName(@"bfycyou.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
            }
            
            if ((self.betData.selection1&&i==0) || (self.betData.selection2&&i==1) ) {
                teamButton.selected = YES;
                textLabel.textColor = [UIColor whiteColor];
                peiLabel.textColor = [UIColor whiteColor];
            }else{
                teamButton.selected = NO;
                textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                peiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
            }
            if ( i == 0) {
                UILabel * ranglabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 18,0, 18, height)];
                ranglabel.backgroundColor = [UIColor clearColor];
                ranglabel.textAlignment = NSTextAlignmentLeft;
                ranglabel.font = [UIFont systemFontOfSize:8];
                ranglabel.tag = 14;
                NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
                if ([teamarray count] >= 3) {
                    if ([[teamarray objectAtIndex:2] floatValue] == 0.00) {
                        ranglabel.text = @"";
                    }else{
//                         if (fabs([[teamarray objectAtIndex:2] floatValue]) > abs([[teamarray objectAtIndex:2] intValue])) {
                            ranglabel.text = [teamarray objectAtIndex:2];
//                        }else{
//                            ranglabel.text = [NSString stringWithFormat:@"%d", [[teamarray objectAtIndex:2] intValue]];
//                        }
                        
                    }
                    
                }
                
                if (self.betData.selection1&&i==0 ) {
                    ranglabel.textColor = [UIColor whiteColor];
                }else{
                    
                    ranglabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
                   
                }
               
                [teamButton addSubview:ranglabel];
                [ranglabel release];
            }
            
        }
        bgImageView.frame = CGRectMake(10, 103, 302, 31);
//        peilvButton.frame = CGRectMake(320 - 48, 103, 38, 31);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:12];
//        peilvLabel.frame = CGRectMake(2, 0, 34, 31);
        lineView.frame = CGRectMake(0, 143, 320, 1);
        self.frame = CGRectMake(0, 0, 320, 144);
        
    }else if (self.buttonType == zhonglichangType || self.buttonType == jiaohuanType){
        
        UIImageView * zhongliImage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 162)/2, 103, 162, 55)];
        zhongliImage.backgroundColor = [UIColor clearColor];
        zhongliImage.image = UIImageGetImageFromName(@"bfyczlc.png");
        [self addSubview:zhongliImage];
        [zhongliImage release];
        if (self.buttonType == zhonglichangType) {
            UILabel * liLabel = [[UILabel alloc] initWithFrame:CGRectMake((320 - 162)/2, 99, 162, 20)];
            liLabel.backgroundColor = [UIColor clearColor];
            liLabel.textAlignment = NSTextAlignmentCenter;
            liLabel.text = @"中立场";
            liLabel.textColor = [UIColor colorWithRed:239/255.0 green:60/255.0 blue:12/255.0 alpha:1];
            liLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:liLabel];
            [liLabel release];
        }
       
        
        UILabel * juLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, 320, 14)];
        juLabel.backgroundColor = [UIColor clearColor];
        juLabel.textAlignment = NSTextAlignmentCenter;
        juLabel.text = @"请注意主客场与投注的不同";
        juLabel.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
        juLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:juLabel];
        [juLabel release];
        
        bgImageView.frame = CGRectMake(0, 0, 0, 0);
//        peilvButton.frame = CGRectMake(320 - 48, 121, 38, 61);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 194, 320, 1);
        self.frame = CGRectMake(0, 0, 320, 195);
        
    }else if (self.buttonType == jieqiType){
        
        bgImageView.frame = CGRectMake(0, 0, 0, 0);
//        peilvButton.frame = CGRectMake(10, 103, 0, 0);
//        UILabel * peilvLabel = (UILabel *)[peilvButton viewWithTag:100];
//        peilvLabel.font = [UIFont systemFontOfSize:0];
//        peilvLabel.frame = peilvButton.bounds;
        lineView.frame = CGRectMake(0, 103, 320, 1);
        self.frame = CGRectMake(0, 0, 320, 104);
    }

}

- (id)init{
    self = [super init];
    if (self) {
        
        selectArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        homeLabel.backgroundColor = [UIColor clearColor];
        homeLabel.textAlignment = NSTextAlignmentCenter;
        homeLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        homeLabel.font = [UIFont systemFontOfSize:15];
//        homeLabel.text = @"曼联";
        [self addSubview:homeLabel];
        [homeLabel release];
        
        homeNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        homeNumber.backgroundColor = [UIColor clearColor];
        homeNumber.textAlignment = NSTextAlignmentCenter;
        homeNumber.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        homeNumber.font = [UIFont systemFontOfSize:10];
//        homeNumber.text = @"12";
        [self addSubview:homeNumber];
        [homeNumber release];
        
        
        CGSize homeSize = [homeLabel.text sizeWithFont:homeLabel.font constrainedToSize:CGSizeMake(117, 30) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize homeNumberSize = [homeNumber.text sizeWithFont:homeNumber.font constrainedToSize:CGSizeMake(117, 13) lineBreakMode:NSLineBreakByWordWrapping];
        
        homeLabel.frame = CGRectMake((117 - homeSize.width - homeNumberSize.width - 3)/2, 23, homeSize.width, 30);
        homeNumber.frame = CGRectMake(homeLabel.frame.origin.x + homeLabel.frame.size.width + 3, 37, homeNumberSize.width, 13);
        
        UIImageView * homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, 117, 6)];
        homeImage.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        [self addSubview:homeImage];
        [homeImage release];
        
        
        

        competitionLabel = [[UILabel alloc] initWithFrame:CGRectMake((320 - 100)/2, 23, 100, 30)];
        competitionLabel.backgroundColor = [UIColor clearColor];
        competitionLabel.textAlignment = NSTextAlignmentCenter;
        competitionLabel.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1];
        competitionLabel.font = [UIFont systemFontOfSize:18];
//        competitionLabel.text = @"英超";
        [self addSubview:competitionLabel];
        [competitionLabel release];
        
        
        
        guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        guestLabel.backgroundColor = [UIColor clearColor];
        guestLabel.textAlignment = NSTextAlignmentCenter;
        guestLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
        guestLabel.font = [UIFont systemFontOfSize:15];
//        guestLabel.text = @"切尔西";
        [self addSubview:guestLabel];
        [guestLabel release];
        
        guestNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        guestNumber.backgroundColor = [UIColor clearColor];
        guestNumber.textAlignment = NSTextAlignmentCenter;
        guestNumber.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
        guestNumber.font = [UIFont systemFontOfSize:10];
//        guestNumber.text = @"3";
        [self addSubview:guestNumber];
        [guestNumber release];
        
        
        CGSize guestSize = [guestLabel.text sizeWithFont:guestLabel.font constrainedToSize:CGSizeMake(117, 30) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize guestNumberSize = [guestNumber.text sizeWithFont:guestNumber.font constrainedToSize:CGSizeMake(117, 13) lineBreakMode:NSLineBreakByWordWrapping];
        
        guestNumber.frame = CGRectMake(203 + (117 - guestSize.width - guestNumberSize.width - 3)/2, 37, guestNumberSize.width, 13);
        guestLabel.frame = CGRectMake(guestNumber.frame.origin.x + guestNumber.frame.size.width + 3, 23, guestSize.width, 30);
        
        
        
        UIImageView * guestImage = [[UIImageView alloc] initWithFrame:CGRectMake(203, 53, 117, 6)];
        guestImage.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
        [self addSubview:guestImage];
        [guestImage release];
        
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 68, 320, 15)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor colorWithRed:174/255.0 green:167/255.0 blue:128/255.0 alpha:1];
        timeLabel.font = [UIFont systemFontOfSize:12];
//        timeLabel.text = @"01月09日  08:14开赛  晴";
        [self addSubview:timeLabel];
        [timeLabel release];
        
//        peilvButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        peilvButton.frame = CGRectMake(10, 103, 300, 31);
//        [peilvButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukuangbf.png") stretchableImageWithLeftCapWidth:11 topCapHeight:10]
// forState:UIControlStateNormal];
//        [peilvButton addTarget:self action:@selector(pressPeiLvButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:peilvButton];
//        peilvLabel = [[UILabel alloc] initWithFrame:peilvButton.bounds];
//        peilvLabel.backgroundColor = [UIColor clearColor];
//        peilvLabel.textAlignment = NSTextAlignmentCenter;
//        peilvLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//        peilvLabel.font = [UIFont systemFontOfSize:13];
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"bfycCustomization"] intValue] == 1) {
//            peilvLabel.text = @"分析中心";
//            peilvButton.tag = 2;
//        }else{
//            peilvLabel.text = @"赔率中心";
//            peilvButton.tag = 1;
//        }
//        
//        peilvLabel.numberOfLines = 0;
//        peilvLabel.tag = 100;
//        peilvLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [peilvButton addSubview:peilvLabel];
//        [peilvLabel release];
        
        
        self.frame = CGRectMake(0, 0, 320, 88);
        
    }
    return self;
}

- (void)pressPeiLvButton:(UIButton *)sender{//赔率中心按钮


//    if (sender.tag == 1) {
//        sender.tag = 2;
//        peilvLabel.text = @"分析中心";
//    }else{
//        sender.tag = 1;
//        peilvLabel.text = @"赔率中心";
//    }
    
    if (delegate&&[delegate respondsToSelector:@selector(matchBetViewButtonTag:)]) {
        [delegate matchBetViewButtonTag:sender.tag];
    }

}

- (void)pressComPetionButton:(UIButton *)sender{//点击顶端联赛名称
    
    if (delegate&&[delegate respondsToSelector:@selector(matchAlertButton)]) {
        [delegate matchAlertButton];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
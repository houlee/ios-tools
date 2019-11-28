//
//  ScoreBallView.m
//  caibo
//
//  Created by houchenguang on 14-7-12.
//
//

#import "ScoreBallView.h"
#import "CP_PTButton.h"

@implementation ScoreBallView
@synthesize typeButtonArray;
@synthesize delegate, betData;
@synthesize wangqiBool, bfycBool, bigHunTou;
- (void)dealloc{
    [betData release];
    [typeButtonArray release];
    [super dealloc];
}

- (GC_BetData *)betData{
    return betData;
}



- (void)showButtonType:(NSInteger)tagbut{
    NSArray * bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
    
    NSArray * bifenarr1 = [NSArray arrayWithObjects:@"①;⑩", @"②;⑩", @"②;①", @"③;⑩", @"③;①", @"③;②", @"④;⑩", @"④;①", @"④;②",@"⑤;⑩",@"⑤;①",@"⑤;②", @"胜其他", @"⑩;⑩", @"①;①", @"②;②", @"③;③", @"平其他", @"⑩;①", @"⑩;②", @"①;②", @"⑩;③", @"①;③", @"②;③", @"⑩;④", @"①;④", @"②;④", @"⑩;⑤",@"①;⑤",@"②;⑤",@"负其他", nil];
    
    UIButton * shangbut = (UIButton *)[myScrtollView viewWithTag:tagbut];
    UILabel * labbifen = (UILabel *)[shangbut viewWithTag:90];
    UILabel * peilula = (UILabel *)[shangbut viewWithTag:100];
    UIImageView * winImage1 = (UIImageView *)[shangbut viewWithTag:111];
    labbifen.text = [bifenarr1 objectAtIndex:tagbut-1];
    
    NSInteger bighuntouCount = tagbut;
    
    if (bigHunTou) {
        bighuntouCount = tagbut+14;
    }
    
    if ([betData.oupeiarr count] > bighuntouCount-1) {
        peilula.text = [betData.oupeiarr objectAtIndex:bighuntouCount-1];
        
    }else{
        peilula.text = @"";
    }
    
    if ([peilula.text isEqualToString:@"-"]) {
        shangbut.enabled = NO;
    }else{
        shangbut.enabled = YES;
    }
    
    if ([[betData.bufshuarr objectAtIndex:bighuntouCount-1] isEqualToString:@"1"]) {
        if (shangbut.tag < 14) {
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdzshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else if(shangbut.tag > 13 && shangbut.tag <= 18){
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdpingjuimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else {
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor whiteColor];
        peilula.textColor = [UIColor whiteColor];
    }else{
        
        if (shangbut.tag < 14) {
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdzshengimage.png") forState:UIControlStateNormal];
        }else if(shangbut.tag > 13 && shangbut.tag <= 18){
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateNormal];
            
        }else {
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor lightGrayColor];
        
    }
    
    if (wangqiBool) {
        shangbut.enabled = NO;
        
//        NSArray * equalArray = [NSArray arrayWithObjects:@"主负", @"主胜",@"主负", @"主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];// 因为彩果问题 所以只能修改成包含于 例如 让分主负 改成呢过 主负
        [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg.png") forState:UIControlStateDisabled];
        winImage1.hidden = YES;
        peilula.textColor = [UIColor lightGrayColor];
        labbifen.textColor = [UIColor lightGrayColor];
        
        if (![betData.caiguo isEqualToString:@"取消"] && ![betData.caiguo isEqualToString:@"-"]) {
            
           
            
            if ([betData.caiguo rangeOfString:[bifenarr objectAtIndex:tagbut-1]].location != NSNotFound) {
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg_1.png") forState:UIControlStateDisabled];
                winImage1.hidden = NO;
                peilula.textColor = [UIColor redColor];
                labbifen.textColor = [UIColor redColor];
            }
            
            
        }
        
        
        
        
        
        
    }else{
        
        winImage1.hidden = YES;
        if ([peilula.text isEqualToString:@"-"]) {
            shangbut.enabled = NO;
            labbifen.textColor = [UIColor lightGrayColor];
            peilula.textColor = [UIColor lightGrayColor];
        }else{
            shangbut.enabled = YES;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        }
        
    }
    
}

- (void)setBetData:(GC_BetData *)_betData{
    if (betData != _betData) {
        [betData release];
        betData = [_betData retain];
    }
    if (bigHunTou == NO) {
        if ([betData.bufshuarr count] < 31) {
            betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",nil];
        }
    }else{
    
        if ([betData.bufshuarr count] < 54) {
            betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",
                                 @"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",
                                 @"0", @"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",
                                 @"0",@"0",@"0", @"0",@"0",@"0",@"0", @"0",@"0",@"0",
                                 @"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",
                                 @"0",@"0",@"0",@"0",nil];
        }
    }
   
    self.typeButtonArray = [NSMutableArray arrayWithArray:betData.bufshuarr];
    UILabel * zhuLable = (UILabel *)[bgimage viewWithTag:9991];
    UILabel * keLable = (UILabel *)[bgimage viewWithTag:9992];
    UILabel * opeiLable1 = (UILabel *)[bgimage viewWithTag:9993];
    UILabel * opeiLable2 = (UILabel *)[bgimage viewWithTag:9994];
    UILabel * opeiLable3 = (UILabel *)[bgimage viewWithTag:9995];
    
   
    
    
    NSArray * teamarray = [betData.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", @"", nil];
    }
    zhuLable.text = [teamarray objectAtIndex:0];
    keLable.text = [teamarray objectAtIndex:1];
    
    

    
    NSArray * oupeiarr  = [betData.oupeiPeilv componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 3) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
    opeiLable1.text = [oupeiarr objectAtIndex:0];
    opeiLable2.text = [oupeiarr objectAtIndex:1];
    opeiLable3.text = [oupeiarr objectAtIndex:2];
    
    int tagbut = 1;
    //第一个
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 4 && j == 1){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;
            
        }
    }
    //第二个
    for (int i = 0; i < 2; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            if (i == 1 && j == 2){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;
        }
    }
    //第三个
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 4 && j == 1){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;
            
        }
        
    }
    
    
    
    
    
    
}

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"wangcc = %d", wangqi);
        self.betData = pkbetdata;
        self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr];
        wangqiBool = wangqi;
        
        
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 291)/2.0, 35, 291, 440)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        bgimage.image = [UIImageGetImageFromName(@"huntoukuangnew.png") stretchableImageWithLeftCapWidth:150 topCapHeight:30];//
        
        myScrtollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 74, 292, 440 - 45 - 74)];
        myScrtollView.backgroundColor = [UIColor clearColor];
        myScrtollView.contentSize = CGSizeMake(291, 800);
        [bgimage addSubview:myScrtollView];
        [myScrtollView release];
        
        
        
        
        UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(16 + 55, 13, 85, 30)];
        //            zhuLable.text = [teamarray objectAtIndex:0];
        if ([zhuLable.text length] > 5) {
            zhuLable.text = [zhuLable.text substringToIndex:5];
        }
        
        zhuLable.textAlignment = NSTextAlignmentLeft;
        zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        zhuLable.font = [UIFont boldSystemFontOfSize:11];
        zhuLable.tag = 9991;
        zhuLable.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:zhuLable];
        [zhuLable release];
        
        UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(16 +140, 13, 30, 30)];
        VSLable.textAlignment = NSTextAlignmentCenter;
        VSLable.text = @"vs";
        VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        VSLable.font = [UIFont boldSystemFontOfSize:11];
        VSLable.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:VSLable];
        [VSLable release];
        
        
        UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(16 +170, 13, 85, 30)];
        
        if ([keLable.text length] > 5) {
            keLable.text = [keLable.text substringToIndex:5];
        }
        keLable.textAlignment = NSTextAlignmentRight;
        keLable.tag = 9992;
        keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        keLable.font = [UIFont boldSystemFontOfSize:11];
        keLable.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:keLable];
        [keLable release];
        
        UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(291 - 221, 10+(66 - 0.5)/2, 221, 0.5)];
        hengla2.backgroundColor = [UIColor clearColor];
        hengla2.image = UIImageGetImageFromName(@"bdxuxian.png");
        [bgimage addSubview:hengla2];
        [hengla2 release];
        
        UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(13, 49, 50, 20)];
        opeiLable.textAlignment = NSTextAlignmentLeft;
        opeiLable.text = @"欧赔";
        opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        opeiLable.font = [UIFont boldSystemFontOfSize:11];
        opeiLable.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:opeiLable];
        [opeiLable release];
        
        
        UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(16 +45, 50, 50, 20)];
        opeiLable1.textAlignment = NSTextAlignmentCenter;
        
        opeiLable1.textColor = [UIColor  lightGrayColor];
        opeiLable1.tag = 9993;
        opeiLable1.font = [UIFont boldSystemFontOfSize:11];
        opeiLable1.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:opeiLable1];
        [opeiLable1 release];
        
        UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(16 +130, 50, 50, 20)];
        opeiLable2.textAlignment = NSTextAlignmentCenter;
        //            opeiLable2.text = [oupeiarr objectAtIndex:1];
        opeiLable2.textColor = [UIColor  lightGrayColor];
        opeiLable2.font = [UIFont boldSystemFontOfSize:11];
        opeiLable2.backgroundColor = [UIColor clearColor];
        opeiLable2.tag = 9994;
        [bgimage addSubview:opeiLable2];
        [opeiLable2 release];
        
        UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(16 +218, 50, 50, 20)];
        opeiLable3.textAlignment = NSTextAlignmentCenter;
        //            opeiLable3.text = [oupeiarr objectAtIndex:2];
        opeiLable3.textColor = [UIColor  lightGrayColor];
        opeiLable3.font = [UIFont boldSystemFontOfSize:11];
        opeiLable3.backgroundColor = [UIColor clearColor];
        opeiLable3.tag = 9995;
        [bgimage addSubview:opeiLable3];
        [opeiLable3 release];
        
        UIImageView * hengla30 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 73.5, 291, 0.5)];
        hengla30.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [bgimage addSubview:hengla30];
        [hengla30 release];
        
        
        
        
        
        
        
        int width = 84;
        int hight = 38.5;
        int tagbut = 1;
        //第一个
        
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 4 && j == 1){
                    break;
                }
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.tag = tagbut;
                
                shangbut.frame = CGRectMake(j*width+8+(j*7), i*hight+49+(i*16.5), width, hight);
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdzshengimage.png") forState:UIControlStateDisabled];
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34.5, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentLeft;
                labbifen.textColor = [UIColor whiteColor];
               labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
//                labbifen.font = [UIFont systemFontOfSize:11];
                NSLog(@"tag = %d", tagbut);
                labbifen.tag = 90;
                
                
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(40.5, 0, 34.5, hight)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:9];
                peilula.tag = 100;
                peilula.textColor = [UIColor whiteColor];
                
                labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                
                
                UIImageView * winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 8, 8)];
                winImage1.backgroundColor = [UIColor clearColor];
                winImage1.hidden = YES;
                winImage1.tag = 111;
                winImage1.image=  UIImageGetImageFromName(@"winImagenew.png");
                [shangbut addSubview:winImage1];
                [winImage1 release];
                
                
                [shangbut addSubview:labbifen];
                [shangbut addSubview:peilula];
                [peilula release];
                [labbifen release];
                [myScrtollView addSubview:shangbut];
                
                tagbut += 1;
            }
        }
        
       
        
        
        
        NSLog(@"tag = %d", tagbut);
        //第二个
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 1 && j == 2){
                    break;
                }
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.tag = tagbut;
                
                shangbut.frame = CGRectMake(j*width+8+(j*7), i*hight+366+(i*16.5), width, hight);
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateDisabled];
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34.5, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentLeft;
                labbifen.textColor = [UIColor whiteColor];
//                 labbifen.font = [UIFont systemFontOfSize:11];
                labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
                NSLog(@"tag = %d", tagbut);
                labbifen.tag = 90;
                
                
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(40.5, 0, 34.5, hight)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:9];
                peilula.tag = 100;
                peilula.textColor = [UIColor whiteColor];
                
                labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                
                
                UIImageView * winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 8, 8)];
                winImage1.backgroundColor = [UIColor clearColor];
                winImage1.hidden = YES;
                winImage1.tag = 111;
                winImage1.image=  UIImageGetImageFromName(@"winImagenew.png");
                [shangbut addSubview:winImage1];
                [winImage1 release];
                
                
                [shangbut addSubview:labbifen];
                [shangbut addSubview:peilula];
                [peilula release];
                [labbifen release];
                [myScrtollView addSubview:shangbut];
                
                tagbut += 1;
                
            }
        }
       
        
        
        
        
        
        
        NSLog(@"tag = %d", tagbut);
        //第三个
        
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 4 && j == 1){
                    break;
                }
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.tag = tagbut;
                
                shangbut.frame = CGRectMake(j*width+8+(j*7), i*hight+520+(i*16.5), width, hight);
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateDisabled];
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34.5, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentLeft;
                labbifen.textColor = [UIColor whiteColor];
//                 labbifen.font = [UIFont systemFontOfSize:11];
                labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
                NSLog(@"tag = %d", tagbut);
                labbifen.tag = 90;
                
                
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(40.5, 0, 34.5, hight)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:9];
                peilula.tag = 100;
                peilula.textColor = [UIColor whiteColor];
                
                labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                
                
                UIImageView * winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 8, 8)];
                winImage1.backgroundColor = [UIColor clearColor];
                winImage1.hidden = YES;
                winImage1.tag = 111;
                winImage1.image=  UIImageGetImageFromName(@"winImagenew.png");
                [shangbut addSubview:winImage1];
                [winImage1 release];
                
                
                [shangbut addSubview:labbifen];
                [shangbut addSubview:peilula];
                [peilula release];
                [labbifen release];
                [myScrtollView addSubview:shangbut];
                
                tagbut += 1;
            }
        }
        
       
      
        
        NSLog(@"tag = %d", tagbut);
  
        
        
        UIImageView *titleChoseImage = [[UIImageView alloc] init];
        titleChoseImage.frame = CGRectMake(7, 12, 67, 20.5);
        [myScrtollView addSubview:titleChoseImage];
        titleChoseImage.image = UIImageGetImageFromName(@"bdtcktitle.png");
        [titleChoseImage release];
        UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
        [titleChoseImage addSubview:choseTitle];
        //        choseTitle.shadowColor = [UIColor whiteColor];//阴影
        //        choseTitle.shadowOffset = CGSizeMake(0, 1.0);
        choseTitle.font = [UIFont systemFontOfSize:11];
        choseTitle.textAlignment = NSTextAlignmentCenter;
        choseTitle.backgroundColor = [UIColor clearColor];
        choseTitle.text = @"主胜";
        [choseTitle release];
        UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 32, 292, 0.5)];
        hengla.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [myScrtollView addSubview:hengla];
        [hengla release];
        
        
        UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
        titleChoseImage2.frame = CGRectMake(7, 331, 67, 20.5);
        [myScrtollView addSubview:titleChoseImage2];
        titleChoseImage2.image = UIImageGetImageFromName(@"bdtcktitle.png");
        [titleChoseImage2 release];
        UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage2.bounds];
        [titleChoseImage2 addSubview:choseTitle2];
        //        choseTitle2.shadowColor = [UIColor whiteColor];//阴影
        //        choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
        choseTitle2.font = [UIFont systemFontOfSize:11];
        choseTitle2.textAlignment = NSTextAlignmentCenter;
        choseTitle2.backgroundColor = [UIColor clearColor];
        choseTitle2.text = @"平局";
        [choseTitle2 release];
        UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 331+20, 292, 0.5)];
        hengla21.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [myScrtollView addSubview:hengla21];
        [hengla21 release];
        
        
        UIImageView *titleChoseImage3 = [[UIImageView alloc] init];
        titleChoseImage3.frame = CGRectMake(7, 485, 67, 20.5);
        [myScrtollView addSubview:titleChoseImage3];
        titleChoseImage3.image = UIImageGetImageFromName(@"bdtcktitle.png");
        [titleChoseImage3 release];
        UILabel *choseTitle3 = [[UILabel alloc] initWithFrame:titleChoseImage3.bounds];
        [titleChoseImage3 addSubview:choseTitle3];
        //        choseTitle3.shadowColor = [UIColor whiteColor];//阴影
        //        choseTitle3.shadowOffset = CGSizeMake(0, 1.0);
        choseTitle3.font = [UIFont systemFontOfSize:11];
        choseTitle3.textAlignment = NSTextAlignmentCenter;
        choseTitle3.backgroundColor = [UIColor clearColor];
        choseTitle3.text = @"主负";
        [choseTitle3 release];
        UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 485+20, 292, 0.5)];
        hengla3.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [myScrtollView addSubview:hengla3];
        [hengla3 release];
        
        
        NSLog(@"tag = %d", tagbut);
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, bgimage.frame.size.height - 44, 291/2.0-2, 44)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [cancelButton setTitleColor:[UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setBackgroundImage:UIImageGetImageFromName(@"zulan_alertcancel_highlight.png") forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
        [bgimage addSubview:cancelButton];
        [cancelButton release];
        

        
        UIButton *quedingbut = [[UIButton alloc] initWithFrame:CGRectMake(291/2.0, bgimage.frame.size.height - 44, 291/2.0, 44)];
        [quedingbut setTitle:@"确定" forState:UIControlStateNormal];
        quedingbut.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [quedingbut setTitleColor:[UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
        quedingbut.backgroundColor = [UIColor clearColor];
        [quedingbut setBackgroundImage:UIImageGetImageFromName(@"zulan_alertsure_highlight.png") forState:UIControlStateHighlighted];
        [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
        [bgimage addSubview:quedingbut];
        [quedingbut release];
        
        [self addSubview:bgimage];
        [bgimage release];
        
        
        
    }
    return self;
}

- (void)pressquxiaobutton:(UIButton *)sender{
    if (bfycBool == NO) {
        [self removeFromSuperview];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(ballBoxDelegateRemove)]) {
        [delegate ballBoxDelegateRemove];
    }
}


- (void)ballBoxDelegateReturnData:(GC_BetData *)bd{
    if (delegate && [delegate respondsToSelector:@selector(ballBoxDelegateReturnData:)]) {
        [delegate ballBoxDelegateReturnData:bd];
    }
    
}

- (void)pressbifenqueding:(UIButton *)sender{
    
    betData.bufshuarr = self.typeButtonArray;
    BOOL dan = NO;
    NSInteger bighontouCount = 0;
    if (bigHunTou) {
        bighontouCount = 14;
    }
    for (int i = (int)bighontouCount; i < (int)[self.typeButtonArray count]; i++) {
        if ([[self.typeButtonArray objectAtIndex:i] isEqualToString:@"1"]) {
            dan = YES;
            break;
        }
    }
    if (dan == NO) {
        betData.dandan = NO;
    }
    [self ballBoxDelegateReturnData:betData];
    if (bfycBool == NO) {
        [self removeFromSuperview];
    }else{
        if (delegate && [delegate respondsToSelector:@selector(bfycballBoxDelegateReturnData:)]) {
            [delegate bfycballBoxDelegateReturnData:betData];
        }
    }
    
    
}


- (void)pressShangButton:(UIButton *)sender{
    
    UILabel * labbifen = (UILabel *)[sender viewWithTag:90];
    UILabel * peilula = (UILabel *)[sender viewWithTag:100];
    
    NSInteger bighuntouCount = sender.tag;
    if (bigHunTou) {
        bighuntouCount = sender.tag + 14;
    }
    
    if ([[self.typeButtonArray objectAtIndex:bighuntouCount-1] isEqualToString:@"1"]) {
        
        [self.typeButtonArray replaceObjectAtIndex:bighuntouCount-1 withObject:@"0"];
        
        if (sender.tag < 14) {
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdzshengimage.png") forState:UIControlStateNormal];
        }else if(sender.tag > 13 && sender.tag <= 18){
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateNormal];
            
        }else {
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateNormal];
        }
        
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        
        
    }else{
        [self.typeButtonArray replaceObjectAtIndex:bighuntouCount-1 withObject:@"1"];
        if (sender.tag < 14) {
            [sender setBackgroundImage:[UIImageGetImageFromName(@"bdzshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else if(sender.tag > 13 && sender.tag <= 18){
            [sender setBackgroundImage:[UIImageGetImageFromName(@"bdpingjuimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else {
            [sender setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor whiteColor];
        peilula.textColor = [UIColor whiteColor];
        
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
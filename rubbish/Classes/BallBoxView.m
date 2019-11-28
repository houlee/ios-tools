//
//  BallBoxView.m
//  caibo
//
//  Created by houchenguang on 14-3-10.
//
//

#import "BallBoxView.h"
#import "UIImageExtra.h"
#import "CP_PTButton.h"
#import "caiboAppDelegate.h"

@implementation BallBoxView
@synthesize typeButtonArray;
@synthesize delegate, betData;
@synthesize wangqiBool, bfycBool;
- (void)dealloc{
    [betData release];
    [typeButtonArray release];
    [super dealloc];
}

- (GC_BetData *)betData{
    return betData;
}



- (void)showButtonType:(NSInteger)tagbut{
    NSArray * bifenarr = [NSArray arrayWithObjects:@"1:0", @"2:0", @"2:1", @"3:0", @"3:1", @"3:2", @"4:0", @"4:1", @"4:2", @"胜其他", @"0:0", @"1:1", @"2:2", @"3:3", @"平其他", @"0:1", @"0:2", @"1:2", @"0:3", @"1:3", @"2:3", @"0:4", @"1:4", @"2:4", @"负其他", nil];
     NSArray * bifenarr1 = [NSArray arrayWithObjects:@"①;⑩", @"②;⑩", @"②;①", @"③;⑩", @"③;①", @"③;②", @"④;⑩", @"④;①", @"④;②", @"胜其他", @"⑩;⑩", @"①;①", @"②;②", @"③;③", @"平其他", @"⑩;①", @"⑩;②", @"①;②", @"⑩;③", @"①;③", @"②;③", @"⑩;④", @"①;④", @"②;④",  @"负其他", nil];

    
    UIButton * shangbut = (UIButton *)[myScrtollView viewWithTag:tagbut];
    UILabel * labbifen = (UILabel *)[shangbut viewWithTag:90];
    UILabel * peilula = (UILabel *)[shangbut viewWithTag:100];
    UIImageView * winImage1 = (UIImageView *)[shangbut viewWithTag:111];
    labbifen.text = [bifenarr1 objectAtIndex:tagbut-1];

    
    if ([betData.oupeiarr count] > tagbut-1) {
        peilula.text = [betData.oupeiarr objectAtIndex:tagbut-1];
    }
    if ([[betData.bufshuarr objectAtIndex:tagbut-1] isEqualToString:@"1"]) {
        if (shangbut.tag <= 10) {
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdzshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else if(shangbut.tag >10 && shangbut.tag <= 15){
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdpingjuimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else{
            [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor whiteColor];
        peilula.textColor = [UIColor whiteColor];
    }else{
        
        if (shangbut.tag <= 10) {
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdzshengimage.png") forState:UIControlStateNormal];
        }else if(shangbut.tag >10 && shangbut.tag <= 15){
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateNormal];
            
        }else{
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor lightGrayColor];
        
    }
    
    if (wangqiBool) {
        shangbut.enabled = NO;
        
        if ([betData.caiguo isEqualToString:[bifenarr objectAtIndex:tagbut-1]]) {
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg_1.png") forState:UIControlStateDisabled];
            winImage1.hidden = NO;
            peilula.textColor = [UIColor redColor];
            labbifen.textColor = [UIColor redColor];
        }else{
            
            [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg.png") forState:UIControlStateDisabled];
            winImage1.hidden = YES;
            peilula.textColor = [UIColor lightGrayColor];
            labbifen.textColor = [UIColor lightGrayColor];
        }
        
        
        
    }else{
        
        winImage1.hidden = YES;
        shangbut.enabled = YES;
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
//        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
//        peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
    }

}

- (void)setBetData:(GC_BetData *)_betData{
    if (betData != _betData) {
        [betData release];
        betData = [_betData retain];
    }
    self.typeButtonArray = [NSMutableArray arrayWithArray:betData.bufshuarr];
    UILabel * zhuLable = (UILabel *)[iteamImage viewWithTag:9991];
    UILabel * keLable = (UILabel *)[iteamImage viewWithTag:9992];
    UILabel * opeiLable1 = (UILabel *)[iteamImage viewWithTag:9993];
    UILabel * opeiLable2 = (UILabel *)[iteamImage viewWithTag:9994];
    UILabel * opeiLable3 = (UILabel *)[iteamImage viewWithTag:9995];
   
    NSArray * teamarray = [betData.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"", nil];
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
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 3 && j == 1){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;

        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            if (i == 1 && j == 2){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;
        }
    }
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 3 && j == 1){
                break;
            }
            [self showButtonType:tagbut];
            tagbut += 1;

        }
    
    }

    if (wangqiBool) {
        iteamImage.hidden = YES;
//        myScrtollView.frame = infoImage.bounds;
        myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 785-55);
     
        allButtonView.frame= CGRectMake(allButtonView.frame.origin.x, 0, allButtonView.frame.size.width, allButtonView.frame.size.height);
    }else{
    
//        myScrtollView.frame  = CGRectMake(0, 66+11, 292, 252);
        iteamImage.hidden = NO;
        
         myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 785-55+76);
         allButtonView.frame= CGRectMake(allButtonView.frame.origin.x, 66+15, allButtonView.frame.size.width, allButtonView.frame.size.height);
    }
     myScrtollView.frame = infoImage.bounds;

}

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        for (int i = 0; i < 31; i++) {
//            buffer[i] = 0;
//        }
//        for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
//            buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
//        }
 NSLog(@"wangcc = %d", wangqi);
        self.betData = pkbetdata;
        self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr];
        wangqiBool = wangqi;
        
        
       
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 35, 310, 440)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        bgimage.image = UIImageGetImageFromName(@"bdtankuangimage.png");//
        bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
        
        
        
        UIImageView * titleImage = [[UIImageView alloc] init];
        titleImage.image = UIImageGetImageFromName(@"bdkuangtitleimage.png");
        titleImage.frame = CGRectMake((310 - 149)/2, -10, 149, 34.5);
        [bgimage addSubview:titleImage];
        UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
        lable.text = @"投注选择";
        [titleImage addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        
        lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        lable.font = [UIFont boldSystemFontOfSize:12];
//        lable.shadowColor = [UIColor whiteColor];//阴影
//        lable.shadowOffset = CGSizeMake(0, 1.0);
        lable.backgroundColor = [UIColor clearColor];
        [lable release];
        [titleImage release];
        
        
        
        
        infoImage = [[UIImageView alloc] init];
        infoImage.image = UIImageGetImageFromName(@"bdbenjingshang.png") ;
        infoImage.frame = CGRectMake(9, 36, 292, 331);
        infoImage.userInteractionEnabled = YES;
        [bgimage addSubview:infoImage];
        [infoImage release];
        
        myScrtollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 66+11, 292, 252)];
        myScrtollView.backgroundColor = [UIColor clearColor];
        if (wangqiBool) {
            myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 785-55);
        }else{
            myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 785-55+76);
        }
        
        [infoImage addSubview:myScrtollView];
        [myScrtollView release];
        
//        if (wangqi == NO) {
            iteamImage = [[UIImageView alloc] init];
            iteamImage.image = [UIImageGetImageFromName(@"peilvkuangbg.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            iteamImage.frame = CGRectMake(8, 10, 275, 66);
            iteamImage.userInteractionEnabled = YES;
            [myScrtollView addSubview:iteamImage];
            [iteamImage release];
            
            
            
            UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 3, 85, 30)];
//            zhuLable.text = [teamarray objectAtIndex:0];
            if ([zhuLable.text length] > 5) {
                zhuLable.text = [zhuLable.text substringToIndex:5];
            }
            
            zhuLable.textAlignment = NSTextAlignmentLeft;
            zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            zhuLable.font = [UIFont boldSystemFontOfSize:11];
            zhuLable.tag = 9991;
            zhuLable.backgroundColor = [UIColor clearColor];
            [iteamImage addSubview:zhuLable];
            [zhuLable release];
            
            UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 3, 30, 30)];
            VSLable.textAlignment = NSTextAlignmentCenter;
            VSLable.text = @"vs";
            VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            VSLable.font = [UIFont boldSystemFontOfSize:11];
            VSLable.backgroundColor = [UIColor clearColor];
            [iteamImage addSubview:VSLable];
            [VSLable release];
            
            
            UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(170, 3, 85, 30)];
            
            if ([keLable.text length] > 5) {
                keLable.text = [keLable.text substringToIndex:5];
            }
            keLable.textAlignment = NSTextAlignmentRight;
            keLable.tag = 9992;
            keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            keLable.font = [UIFont boldSystemFontOfSize:11];
            keLable.backgroundColor = [UIColor clearColor];
            [iteamImage addSubview:keLable];
            [keLable release];
            
            UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 39, 50, 20)];
            opeiLable.textAlignment = NSTextAlignmentLeft;
            opeiLable.text = @"欧赔";
            opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            opeiLable.font = [UIFont boldSystemFontOfSize:11];
            opeiLable.backgroundColor = [UIColor clearColor];
            [iteamImage addSubview:opeiLable];
            [opeiLable release];
            
            
            UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 40, 50, 20)];
            opeiLable1.textAlignment = NSTextAlignmentCenter;
            
            opeiLable1.textColor = [UIColor  lightGrayColor];
            opeiLable1.tag = 9993;
            opeiLable1.font = [UIFont boldSystemFontOfSize:11];
            opeiLable1.backgroundColor = [UIColor clearColor];
            [iteamImage addSubview:opeiLable1];
            [opeiLable1 release];
            
            UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 50, 20)];
            opeiLable2.textAlignment = NSTextAlignmentCenter;
//            opeiLable2.text = [oupeiarr objectAtIndex:1];
            opeiLable2.textColor = [UIColor  lightGrayColor];
            opeiLable2.font = [UIFont boldSystemFontOfSize:11];
            opeiLable2.backgroundColor = [UIColor clearColor];
            opeiLable2.tag = 9994;
            [iteamImage addSubview:opeiLable2];
            [opeiLable2 release];
            
            UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(218, 40, 50, 20)];
            opeiLable3.textAlignment = NSTextAlignmentCenter;
//            opeiLable3.text = [oupeiarr objectAtIndex:2];
            opeiLable3.textColor = [UIColor  lightGrayColor];
            opeiLable3.font = [UIFont boldSystemFontOfSize:11];
            opeiLable3.backgroundColor = [UIColor clearColor];
            opeiLable3.tag = 9995;
            [iteamImage addSubview:opeiLable3];
            [opeiLable3 release];
            
            
            UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(275 - 221, (66 - 0.5)/2, 221, 0.5)];
            hengla2.backgroundColor = [UIColor clearColor];
            hengla2.image = UIImageGetImageFromName(@"bdxuxian.png");
            [iteamImage addSubview:hengla2];
            [hengla2 release];

//        }else{
//        
//            myScrtollView.frame = infoImage.bounds;
//        }
        
        
        
       
        
        int hightOupei = 0;
        if (wangqiBool) {
            hightOupei = 0;
        }else{
            hightOupei = 66+15;
        }
        
        allButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, hightOupei, myScrtollView.frame.size.width, 785-55)];
        allButtonView.backgroundColor = [UIColor clearColor];
        [myScrtollView addSubview:allButtonView];
        [allButtonView release];
        
        int width = 87;
        int hight = 38.5;
        int tagbut = 1;
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 3 && j == 1){
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
                [allButtonView addSubview:shangbut];
                
                 tagbut += 1;
                
            }
            
        }
        
        NSLog(@"tag = %d", tagbut);
        for (int i = 0; i < 2; i++) {
            
            for (int j = 0; j < 3; j++) {
                
                if (i == 1 && j == 2){
                    break;
                }
                
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.frame = CGRectMake(0, 0, 0, 0);
                shangbut.tag = tagbut;
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateDisabled];
                shangbut.frame = CGRectMake(j*width+8+(j*7), i*hight+304+(i*16.5), width, hight);
                
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34.5, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentCenter;
//                 labbifen.font = [UIFont systemFontOfSize:11];
                labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
                labbifen.textColor = [UIColor whiteColor];
                
                labbifen.tag = 90;
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 34.5, hight)];
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
                
                [allButtonView addSubview:shangbut];
               
                tagbut += 1;
            }
            
            
            
            
        }
        
        
        NSLog(@"tag = %d", tagbut);
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 3 && j == 1){
                    break;
                }
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.tag = tagbut;
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateDisabled];
                shangbut.frame = CGRectMake(j*width+8+(j*7), i*hight+451+(i*16.5), width, hight);
                
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34.5, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentCenter;
//                 labbifen.font = [UIFont systemFontOfSize:11];
                labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
                
                labbifen.textColor = [UIColor whiteColor];
                labbifen.tag = 90;
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 34.5, hight)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textColor = [UIColor whiteColor];
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:9];
                peilula.tag = 100;
                labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
               
                UIImageView * winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 8, 8)];
                winImage1.backgroundColor = [UIColor clearColor];
                winImage1.hidden = YES;
                winImage1.tag = 111;
                winImage1.image=  UIImageGetImageFromName(@"winImagenew.png");
                [shangbut addSubview:winImage1];
                [winImage1 release];

                
                NSLog(@"tag = %d", tagbut);
                
                [shangbut addSubview:labbifen];
                [shangbut addSubview:peilula];
                [peilula release];
                [labbifen release];
                
                [allButtonView addSubview:shangbut];
                
                tagbut += 1;
            }
            
        }
        
        
        UIImageView *titleChoseImage = [[UIImageView alloc] init];
        titleChoseImage.frame = CGRectMake(7, 12, 67, 20.5);
        [allButtonView addSubview:titleChoseImage];
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
        UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 12+20, 292, 0.5)];
        hengla.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [allButtonView addSubview:hengla];
        [hengla release];
        
        
        UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
        titleChoseImage2.frame = CGRectMake(7, 327-60, 67, 20.5);
        [allButtonView addSubview:titleChoseImage2];
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
        UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 327+20-60, 292, 0.5)];
        hengla21.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [allButtonView addSubview:hengla21];
        [hengla21 release];
        
        
        UIImageView *titleChoseImage3 = [[UIImageView alloc] init];
        titleChoseImage3.frame = CGRectMake(7, 474-60, 67, 20.5);
        [allButtonView addSubview:titleChoseImage3];
        titleChoseImage3.image = UIImageGetImageFromName(@"bdtcktitle.png");
        [titleChoseImage3 release];
        UILabel *choseTitle3 = [[UILabel alloc] initWithFrame:titleChoseImage3.bounds];
        [titleChoseImage3 addSubview:choseTitle3];
//        choseTitle3.shadowColor = [UIColor whiteColor];//阴影
//        choseTitle3.shadowOffset = CGSizeMake(0, 1.0);
        choseTitle3.font = [UIFont systemFontOfSize:11];
        choseTitle3.textAlignment = NSTextAlignmentCenter;
        choseTitle3.backgroundColor = [UIColor clearColor];
        choseTitle3.text = @"客胜";
        [choseTitle3 release];
        UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 474+20-60, 292, 0.5)];
        hengla3.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [allButtonView addSubview:hengla3];
        [hengla3 release];
        
        
        NSLog(@"tag = %d", tagbut);
        CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(27, 380, 118, 38)];
        cancelButton.showShadow = YES;
        [cancelButton loadButonImage:@"bdquedingzhegnc.png" LabelName:@"取消"];
        [cancelButton setHightImage:UIImageGetImageFromName(@"bdqudinganxia.png")];
        cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
        cancelButton.buttonName.textColor = [UIColor whiteColor];
//        cancelButton.buttonName.shadowColor = [UIColor blackColor];
//        cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
        
        cancelButton.buttonName.frame = cancelButton.bounds;
        cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
        [bgimage addSubview:cancelButton];
        [cancelButton release];
        
        
        CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(27+118+20, 380, 118, 38)];
        quedingbut.showShadow = YES;
        [quedingbut loadButonImage:@"bdquedingzhegnc.png" LabelName:@"确定"];
        [quedingbut setHightImage:UIImageGetImageFromName(@"bdqudinganxia.png")];
        quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
        quedingbut.buttonName.textColor = [UIColor whiteColor];
//        quedingbut.buttonName.shadowColor = [UIColor blackColor];
//        quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
        
        quedingbut.buttonName.frame = cancelButton.bounds;
        quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
    for (int i = 0; i < [self.typeButtonArray count]; i++) {
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
    

    if ([[self.typeButtonArray objectAtIndex:sender.tag-1] isEqualToString:@"1"]) {
        
        [self.typeButtonArray replaceObjectAtIndex:sender.tag-1 withObject:@"0"];
        
        if (sender.tag <= 10) {
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdzshengimage.png") forState:UIControlStateNormal];
        }else if(sender.tag >10 && sender.tag <= 15){
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdpingjuimage.png") forState:UIControlStateNormal];

        }else{
            [sender setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateNormal];
        }
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];

        
    }else{
        [self.typeButtonArray replaceObjectAtIndex:sender.tag-1 withObject:@"1"];
        if (sender.tag <= 10) {
            [sender setBackgroundImage:[UIImageGetImageFromName(@"bdzshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else if(sender.tag >10 && sender.tag <= 15){
             [sender setBackgroundImage:[UIImageGetImageFromName(@"bdpingjuimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }else{
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
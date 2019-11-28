//
//  SFCBoxView.m
//  caibo
//
//  Created by houchenguang on 14-7-11.
//
//


#import "SFCBoxView.h"

#import "CP_PTButton.h"

@implementation SFCBoxView
@synthesize typeButtonArray;
@synthesize delegate, betData;
@synthesize wangqiBool, bfycBool, viewType;
- (void)dealloc{
    
    [betData release];
    [typeButtonArray release];
    [super dealloc];
}

- (GC_BetData *)betData{
    return betData;
}



- (void)showButtonType:(NSInteger)tagbut{
    NSArray * bifenarr = [NSArray arrayWithObjects:@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",  nil];
    
    
    
    UIButton * shangbut = (UIButton *)[bgimage viewWithTag:tagbut];
    UILabel * labbifen = (UILabel *)[shangbut viewWithTag:90];
    UILabel * peilula = (UILabel *)[shangbut viewWithTag:100];
    UIImageView * winImage1 = (UIImageView *)[shangbut viewWithTag:111];
    labbifen.text = [bifenarr objectAtIndex:tagbut-1];
    
    NSInteger number = 0;
    if (viewType == 1) {
        number = tagbut-1;
    }else if (viewType  == 2){
        number = tagbut-1 + 6;
    }
    
    if ([betData.oupeiarr count] > number) {
        peilula.text = [betData.oupeiarr objectAtIndex:number];
        
    }else{
        peilula.text = @"";
    }
    
    if ([peilula.text isEqualToString:@"-"]) {
        shangbut.enabled = NO;
    }else{
        shangbut.enabled = YES;
    }
    
    if ([[betData.bufshuarr objectAtIndex:number] isEqualToString:@"1"]) {

        [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        labbifen.textColor = [UIColor whiteColor];
        peilula.textColor = [UIColor whiteColor];
    }else{
         [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdbfwqbg.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];

        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor lightGrayColor];
        
    }
    
    if (wangqiBool) {
        shangbut.enabled = NO;
        
        NSArray * equalArray = [NSArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  nil];// 因为彩果问题 所以只能修改成包含于 例如 让分主负 改成呢过 主负
        
//        NSArray * equalArray = [NSArray arrayWithObjects:@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",  nil];
        [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg.png") forState:UIControlStateDisabled];
        winImage1.hidden = YES;
        peilula.textColor = [UIColor lightGrayColor];
        labbifen.textColor = [UIColor lightGrayColor];
        
        if (![betData.caiguo isEqualToString:@"取消"] && ![betData.caiguo isEqualToString:@"-"]) {
            
           
            
            if ([betData.caiguo rangeOfString:[equalArray objectAtIndex:number]].location != NSNotFound) {
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg_1.png") forState:UIControlStateDisabled];
                winImage1.hidden = NO;
                peilula.textColor = [UIColor redColor];
                labbifen.textColor = [UIColor redColor];
            }
            
            
        }
        
        
        
        
        
        
    }else{
        
        winImage1.hidden = YES;
        shangbut.enabled = YES;
        if ([[betData.bufshuarr objectAtIndex:number] isEqualToString:@"1"]) {
            
            
            labbifen.textColor = [UIColor whiteColor];
            peilula.textColor = [UIColor whiteColor];
        }else{
            
            
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor lightGrayColor];
            
        }
                
    }
    
}

- (void)setBetData:(GC_BetData *)_betData{
    if (betData != _betData) {
        [betData release];
        betData = [_betData retain];
    }
    if ([betData.bufshuarr count] < 12) {
        betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",nil];
    }
    self.typeButtonArray = [NSMutableArray arrayWithArray:betData.bufshuarr];
    UILabel * zhuLable = (UILabel *)[bgimage viewWithTag:9991];
    UILabel * keLable = (UILabel *)[bgimage viewWithTag:9992];
    UILabel * opeiLable1 = (UILabel *)[bgimage viewWithTag:9993];
    UILabel * opeiLable2 = (UILabel *)[bgimage viewWithTag:9994];
    UILabel * opeiLable3 = (UILabel *)[bgimage viewWithTag:9995];
    
    UILabel * rangqiuOne = (UILabel *)[bgimage viewWithTag:666];
    UILabel * rangqiuTwo = (UILabel *)[bgimage viewWithTag:777];
    
    UILabel * choseTitle = (UILabel *)[bgimage viewWithTag:7565];
    if (viewType == 1) {
        choseTitle.text = @"客胜";
    }else if (viewType == 2){
        choseTitle.text = @"主胜";
    }
   
    rangqiuOne.text = @"";
    rangqiuTwo.text = @"";
    
    
    NSArray * teamarray = [betData.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", @"", nil];
    }
    zhuLable.text = [teamarray objectAtIndex:0];
    keLable.text = [teamarray objectAtIndex:1];
    
    if ([teamarray count] > 2) {
        if ([teamarray objectAtIndex:2] || ![[teamarray objectAtIndex:2] isEqualToString:@""]) {
            rangqiuOne.text = [teamarray objectAtIndex:2];
        }else{
            rangqiuOne.text = @"-";
        }
        if ([rangqiuOne.text isEqualToString:@"null"]) {
            rangqiuOne.text = @"-";
        }
        
    }
    if ([teamarray count] > 3) {
        if ([teamarray objectAtIndex:3] || ![[teamarray objectAtIndex:3] isEqualToString:@""]) {
            rangqiuTwo.text = [teamarray objectAtIndex:3];
        }else{
            rangqiuTwo.text = @"-";
        }
        
        if ([rangqiuTwo.text isEqualToString:@"null"]) {
            rangqiuTwo.text = @"-";
        }
        
    }
    
    
    
    
    NSArray * oupeiarr  = [betData.aomenoupei componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 2) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"", nil];
    }
    

    opeiLable1.text = [oupeiarr objectAtIndex:0];
    opeiLable2.text = @"";
    opeiLable3.text = [oupeiarr objectAtIndex:1];
    
    int tagbut = 1;
       //第一行
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            
            [self showButtonType:tagbut];
            tagbut += 1;
            
        }
    }
    
    
    
    
    
}

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi celltype:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"wangcc = %d", wangqi);
        self.viewType = type;
        self.betData = pkbetdata;
        self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr];
        wangqiBool = wangqi;
        
        
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 291)/2.0, 35, 291, 275)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        bgimage.image = [UIImageGetImageFromName(@"huntoukuangnew.png") stretchableImageWithLeftCapWidth:150 topCapHeight:30];//
        
        
        bgimage.center = self.center;
        
        
        
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
        opeiLable.text = @"澳门让分";
        opeiLable.hidden = YES;
        opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        opeiLable.font = [UIFont boldSystemFontOfSize:11];
        opeiLable.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:opeiLable];
        [opeiLable release];
        
        
        UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(16 +45, 50, 50, 20)];
        opeiLable1.textAlignment = NSTextAlignmentCenter;
        opeiLable1.hidden = YES;
        opeiLable1.textColor = [UIColor  lightGrayColor];
        opeiLable1.tag = 9993;
        opeiLable1.font = [UIFont boldSystemFontOfSize:11];
        opeiLable1.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:opeiLable1];
        [opeiLable1 release];
        
        UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(16 +130, 50, 50, 20)];
        opeiLable2.textAlignment = NSTextAlignmentCenter;
        opeiLable2.hidden = YES;
        //            opeiLable2.text = [oupeiarr objectAtIndex:1];
        opeiLable2.textColor = [UIColor  lightGrayColor];
        opeiLable2.font = [UIFont boldSystemFontOfSize:11];
        opeiLable2.backgroundColor = [UIColor clearColor];
        opeiLable2.tag = 9994;
        [bgimage addSubview:opeiLable2];
        [opeiLable2 release];
        
        UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(16 +218, 50, 50, 20)];
        opeiLable3.textAlignment = NSTextAlignmentCenter;
        opeiLable3.hidden = YES;
        //            opeiLable3.text = [oupeiarr objectAtIndex:2];
        opeiLable3.textColor = [UIColor  lightGrayColor];
        opeiLable3.font = [UIFont boldSystemFontOfSize:11];
        opeiLable3.backgroundColor = [UIColor clearColor];
        opeiLable3.tag = 9995;
        [bgimage addSubview:opeiLable3];
        [opeiLable3 release];
        
//        UIImageView * hengla30 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 73.5, 291, 0.5)];
//        hengla30.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
//        [bgimage addSubview:hengla30];
//        [hengla30 release];
        
        
        
        
        
        
        
        int width = 84;
        int hight = 38.5;
        int tagbut = 1;

        
        NSLog(@"tag = %d", tagbut);
        //第一个
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.tag = tagbut;
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdkeshengimage.png") forState:UIControlStateDisabled];
                shangbut.frame = CGRectMake(j*width+10+(j*9), i*hight+101+(i*9), width, hight);
                
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34, hight)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentLeft;
                labbifen.font = [UIFont systemFontOfSize:11];
                
                labbifen.textColor = [UIColor whiteColor];
                labbifen.tag = 90;
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(46, 0, 35, hight)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textColor = [UIColor whiteColor];
                peilula.textAlignment = NSTextAlignmentLeft;
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
                
                [bgimage addSubview:shangbut];
                
                tagbut += 1;
            }
            
        }
        
        
        UIImageView *titleChoseImage = [[UIImageView alloc] init];
        titleChoseImage.frame = CGRectMake(7, 65, 67, 20.5);
        [bgimage addSubview:titleChoseImage];
        titleChoseImage.image = UIImageGetImageFromName(@"bdtcktitle.png");
        [titleChoseImage release];
        UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
        [titleChoseImage addSubview:choseTitle];
        choseTitle.tag = 7565;
        //        choseTitle.shadowColor = [UIColor whiteColor];//阴影
        //        choseTitle.shadowOffset = CGSizeMake(0, 1.0);
        choseTitle.font = [UIFont systemFontOfSize:11];
        choseTitle.textAlignment = NSTextAlignmentCenter;
        choseTitle.backgroundColor = [UIColor clearColor];
        choseTitle.text = @"客胜";
        [choseTitle release];
        UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 85, 292, 0.5)];
        hengla.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
        [bgimage addSubview:hengla];
        [hengla release];
        
        
        
        
        NSLog(@"tag = %d", tagbut);
        CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(0, bgimage.frame.size.height - 44, 291/2.0-1, 44)];
        cancelButton.showShadow = YES;
        [cancelButton loadButonImage:nil LabelName:@"取消"];
        //        [cancelButton setHightImage:UIImageGetImageFromName(@"bdqudinganxia.png")];
        cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
        cancelButton.buttonName.textColor = [UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1];
        //        cancelButton.buttonName.shadowColor = [UIColor blackColor];
        //        cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
        [cancelButton setBackgroundImage:UIImageGetImageFromName(@"zulan_alertcancel_highlight.png") forState:UIControlStateHighlighted];

        cancelButton.buttonName.frame = cancelButton.bounds;
        cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
        [bgimage addSubview:cancelButton];
        [cancelButton release];
        
        
        CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(291/2.0+1, bgimage.frame.size.height - 44, 291/2.0, 44)];
        quedingbut.showShadow = YES;
        [quedingbut loadButonImage:nil LabelName:@"确定"];
        //        [quedingbut setHightImage:UIImageGetImageFromName(@"bdqudinganxia.png")];
        quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
        quedingbut.buttonName.textColor = [UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1];
        //        quedingbut.buttonName.shadowColor = [UIColor blackColor];
        //        quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
        [quedingbut setBackgroundImage:UIImageGetImageFromName(@"zulan_alertsure_highlight.png") forState:UIControlStateHighlighted];

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
    NSInteger number = 0;
    if (viewType == 1) {
        number = sender.tag-1;
    }else if (viewType  == 2){
        number = sender.tag - 1 + 6;
    }

    
    if ([[self.typeButtonArray objectAtIndex:number] isEqualToString:@"1"]) {
        
        [self.typeButtonArray replaceObjectAtIndex:number withObject:@"0"];
        

        
        [sender setBackgroundImage:[UIImageGetImageFromName(@"bdbfwqbg.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        
        
    }else{
        [self.typeButtonArray replaceObjectAtIndex:number withObject:@"1"];

        [sender setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
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
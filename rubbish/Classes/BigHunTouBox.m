//
//  BigHunTouBox.m
//  caibo
//
//  Created by houchenguang on 14-7-30.
//
//

#import "BigHunTouBox.h"
#import "caiboAppDelegate.h"


@implementation BigHunTouBox
@synthesize showTye;
@synthesize wangqibool;
@synthesize delegate;
@synthesize typeButtonArray;
- (void)dealloc{
    [typeButtonArray release];
    [betData release];
    [super dealloc];
}

- (GC_BetData *)betData{

    return betData;
}

- (void)showButtonType:(NSInteger)tagbut{
    
    NSArray * bifenarr = nil;
    NSArray * caiArray = nil;
    if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {
    
        bifenarr = [NSArray arrayWithObjects:@"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
        caiArray = [NSArray arrayWithObjects:@"主负", @"主胜",@"主负", @"主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
        
    }else{
        bifenarr = [NSArray arrayWithObjects:@"{", @"|", @"}", @"{", @"|", @"}",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"{{", @"{|", @"{}", @"|{", @"||", @"|}", @"}{", @"}|", @"}}",  nil];
        caiArray = [NSArray arrayWithObjects:@"胜", @"平", @"负", @"让胜", @"让平", @"让负",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负",  nil];
    }
   
    
    UIButton * shangbut = (UIButton *)[bgimage viewWithTag:tagbut];
    UILabel * labbifen = (UILabel *)[shangbut viewWithTag:90];
    UILabel * peilula = (UILabel *)[shangbut viewWithTag:100];
    UIImageView * winImage1 = (UIImageView *)[shangbut viewWithTag:111];
    
    
    NSInteger number = 0;
    if (showTye == shengpingfuType) {
        number = tagbut - 1;
    }else if (showTye == rangqiushengpingfuType){
        number = tagbut - 1 + 3;
    }else if (showTye == zongjinqiuType){
        number = tagbut - 1 + 6;
    }else if (showTye == banquanchangType){
        number = tagbut - 1 + 45;
    }else if (showTye == shengfuType){
        number = tagbut - 1;
    }else if (showTye == rangfenshengfuType){
        number = tagbut - 1 + 2;
    }else if (showTye == daxiaofenType){
        number = tagbut - 1 + 4;
    }else if (showTye == shengfenchaType){
        number = tagbut - 1 + 6;
    }
    
    labbifen.text = [bifenarr objectAtIndex:number];
    
    if (showTye == zongjinqiuType) {
        labbifen.font = [UIFont fontWithName:@"04b" size:17];
    }else if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {
        labbifen.font = [UIFont systemFontOfSize:12];
    }else{
        labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
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
        
        labbifen.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        
    }
    
    if (wangqibool) {///篮球大混投的往期没做
        shangbut.enabled = NO;
        
       
        [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg.png") forState:UIControlStateDisabled];
        winImage1.hidden = YES;
        peilula.textColor = [UIColor lightGrayColor];
        labbifen.textColor = [UIColor lightGrayColor];
        
        if (![betData.caiguo isEqualToString:@"取消"] && ![betData.caiguo isEqualToString:@"-"]) {
            
            NSArray * caiguoArray = nil;
            
            NSString * caiguoString = @"";
            
            if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {//篮球往期彩果的分割
                caiguoArray =[betData.caiguo componentsSeparatedByString:@","];
                
                if (number < 2) {
                    if ([caiguoArray count] > 0) {
                        caiguoString = [caiguoArray objectAtIndex:0];
                    }
                }else if (number > 1 && number < 4){
                    if ([caiguoArray count] > 1) {
                        caiguoString = [caiguoArray objectAtIndex:1];
                    }
                }else if (number > 3 && number < 6){
                    if ([caiguoArray count] > 2) {
                        caiguoString = [caiguoArray objectAtIndex:2];
                    }
                }else if (number > 5){
                    if ([caiguoArray count] > 3) {
                        caiguoString = [caiguoArray objectAtIndex:3];
                    }
                }
                
            }else{//足球往期彩果的分割
                caiguoArray =[betData.caiguo componentsSeparatedByString:@"]-"];
                if (number < 3) {
                    if ([caiguoArray count] > 0) {
                        caiguoString = [caiguoArray objectAtIndex:0];
                    }
                    
                }else if (number > 2 && number < 6){
                    if ([caiguoArray count] > 1) {
                        caiguoString = [caiguoArray objectAtIndex:1];
                    }
                    
                    
                }else if (number > 5 && number < 14){
                    if ([caiguoArray count] > 2) {
                        caiguoString = [caiguoArray objectAtIndex:2];
                    }
                }else if (number > 13 && number < 45){
                    
                    if ([caiguoArray count] > 3) {
                        caiguoString = [caiguoArray objectAtIndex:3];
                    }
                    
                }else if (number > 44){
                    
                    if ([caiguoArray count] > 4) {
                        caiguoString = [caiguoArray objectAtIndex:4];
                        caiguoString = [caiguoString stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    }
                    
                }
            }
            
            
            
            if ([caiguoString rangeOfString:[caiArray objectAtIndex:number]].location != NSNotFound) {
                [shangbut setBackgroundImage:UIImageGetImageFromName(@"bdbfwqbg_1.png") forState:UIControlStateDisabled];
                winImage1.hidden = NO;
                peilula.textColor = [UIColor redColor];
                labbifen.textColor = [UIColor redColor];
            }
            
            
        }
        
        
        
        
        
        
    }else{
        
        winImage1.hidden = YES;
//        shangbut.enabled = YES;
        if ([peilula.text isEqualToString:@"-"]) {
            shangbut.enabled = NO;
            labbifen.textColor = [UIColor lightGrayColor];
            peilula.textColor = [UIColor lightGrayColor];
        }else{
            shangbut.enabled = YES;
            labbifen.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        }
        
        if ([[betData.bufshuarr objectAtIndex:number] isEqualToString:@"1"]) {
            
            
            labbifen.textColor = [UIColor whiteColor];
            peilula.textColor = [UIColor whiteColor];
        }else{
            
            
            labbifen.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
            
        }
        

    }
    
}

- (void)setBetData:(GC_BetData *)_betData{

    if (betData != _betData) {
        [betData release];
        betData = [_betData retain];
    }
    if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {
        if ([betData.bufshuarr count] < 18) {
            betData.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",nil];
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
    NSArray * teamarray = [betData.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", @"", nil];
    }
    zhuLable.text = [teamarray objectAtIndex:0];
    keLable.text = [teamarray objectAtIndex:1];
    

    
    if (showTye == zongjinqiuType || showTye == banquanchangType) {
        
        UILabel * opeiLable1 = (UILabel *)[bgimage viewWithTag:9993];
        UILabel * opeiLable2 = (UILabel *)[bgimage viewWithTag:9994];
        UILabel * opeiLable3 = (UILabel *)[bgimage viewWithTag:9995];
        
        NSArray * oupeiarr  = [betData.oupeiPeilv componentsSeparatedByString:@" "];
        if ([oupeiarr count] < 3) {
            oupeiarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        opeiLable1.text = [oupeiarr objectAtIndex:0];
        opeiLable2.text = [oupeiarr objectAtIndex:1];
        opeiLable3.text = [oupeiarr objectAtIndex:2];
    }
    

    
    int tagbut = 1;
    int hang = 0;
    int lie = 0;
//    float countHight;
    if (showTye == shengpingfuType) {
        hang = 1;
        lie = 3;
//        countHight= 70;
    }else if (showTye == rangqiushengpingfuType){
        hang = 1;
        lie = 3;
//        countHight= 77;
        
        CGSize labelSize = [zhuLable.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(85, 30)];
        
        NSString * rangstr = @"";
        if ([teamarray count] >= 3) {
            rangstr = [NSString stringWithFormat:@"(%@)", [teamarray objectAtIndex:2]];
        }else{
            rangstr = @"";
        }
        
        CGSize rangSize = [rangstr sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(85, 30)];
        
        zhuLable.frame = CGRectMake( 55 - 25.5 + (85 - labelSize.width)/2 - 5, 13, labelSize.width, 30);
        rangLabel.text = rangstr;
        rangLabel.frame = CGRectMake(zhuLable.frame.origin.x + zhuLable.frame.size.width+5, 13, rangSize.width, 30);
        
        
        if ([teamarray count] >= 3) {
            if ([[teamarray objectAtIndex:2] floatValue] > 0) {
                teamLabel.text = [NSString stringWithFormat:@"%@受让%d球", [teamarray objectAtIndex:0], abs([[teamarray objectAtIndex:2] intValue]) ];
            }else if ([[teamarray objectAtIndex:2] floatValue] < 0){
                 teamLabel.text = [NSString stringWithFormat:@"%@让%d球", [teamarray objectAtIndex:0], abs([[teamarray objectAtIndex:2] intValue]) ];
            }else{
                teamLabel.text = @"";
            }
        }else{
            teamLabel.text = @"";
        }
        
    }else if (showTye == zongjinqiuType){
        hang = 3;
        lie = 3;
//        countHight= 100;
    }else if (showTye == banquanchangType){
        hang = 3;
        lie = 3;
//        countHight= 100;
    }else if (showTye == shengfenchaType){
        hang = 4;
        lie = 3;
    }else if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == daxiaofenType ) {
        hang = 1;
        lie = 2;
    }
    //第一行
    for (int i = 0; i < hang; i++) {
        for (int j = 0; j < lie; j++) {
            
            [self showButtonType:tagbut];
            tagbut += 1;
            
        }
    }
    
    if (showTye == daxiaofenType || showTye == rangfenshengfuType) {//大小分 让分胜负 的让球显示
        UILabel * rangfenLabel = (UILabel *)[bgimage viewWithTag:912];
        
        NSInteger countint = 0;
        if (showTye == daxiaofenType) {
            countint = 3;
            rangfenLabel.textColor = [UIColor colorWithRed:59/255.0 green:155/255.0 blue:7/255.0 alpha:1];
        }else if (showTye == rangfenshengfuType){
            countint = 2;
            rangfenLabel.textColor = [UIColor redColor];
        }
        if ([teamarray count] > countint) {
            rangfenLabel.text =  [teamarray objectAtIndex:countint];
        }else{
        
            rangfenLabel.text = @"";
        }
        
        
        
    }
}

- (void)cancelAndConfirm{

    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, bgimage.frame.size.height - 44, 291/2.0, 44)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [cancelButton setTitleColor:[UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"zulan_alertcancel_highlight.png") forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
    
    UIButton *quedingbut = [[UIButton alloc] initWithFrame:CGRectMake(291/2.0, bgimage.frame.size.height - 44, 291/2.0, 44)];
    [quedingbut setTitle:@"确定" forState:UIControlStateNormal];

    quedingbut.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [quedingbut setTitleColor:[UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1] forState:UIControlStateNormal];
    [quedingbut setBackgroundImage:UIImageGetImageFromName(@"zulan_alertsure_highlight.png") forState:UIControlStateHighlighted];
    [quedingbut setBackgroundColor:[UIColor clearColor]];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
   
    
    if (showTye == shengpingfuType) {
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 195);
    }else if (showTye == rangqiushengpingfuType){
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 277);
    }else if (showTye == zongjinqiuType){
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 306);
    }else if (showTye == banquanchangType){
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 306);
    }else if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == daxiaofenType){
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 234);
    }else if (showTye == shengfenchaType){
        bgimage.frame = CGRectMake((320 - 291)/2.0, 35, 291, 359);
    }
    cancelButton.frame = CGRectMake(0, bgimage.frame.size.height - 44, 291/2.0-2, 44);
    quedingbut.frame = CGRectMake(291/2.0, bgimage.frame.size.height - 44, 291/2.0, 44);
    
    bgimage.center = self.center;
}

- (void)pressquxiaobutton:(UIButton *)sender{
//    if (bfycBool == NO) {
        [self removeFromSuperview];
//    }
//    
//    if (delegate && [delegate respondsToSelector:@selector(ballBoxDelegateRemove)]) {
//        [delegate ballBoxDelegateRemove];
//    }
}

- (void)ballBoxDelegateReturnData:(GC_BetData *)bd{
    if (delegate && [delegate respondsToSelector:@selector(ballBoxDelegateReturnData:)]) {
        [delegate ballBoxDelegateReturnData:bd];
    }
    
}

- (void)pressbifenqueding:(UIButton *)sender{
    
    
    if (wangqibool) {
        [self removeFromSuperview];
        return;
    }
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
//    if (bfycBool == NO) {
        [self removeFromSuperview];
//    }else{
//        if (delegate && [delegate respondsToSelector:@selector(bfycballBoxDelegateReturnData:)]) {
//            [delegate bfycballBoxDelegateReturnData:betData];
//        }
//    }
    
    
}

- (void)teamTitleLabelFunc{//哪个队对哪个队

    UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(16 + 55, 13, 85, 30)];
    //            zhuLable.text = [teamarray objectAtIndex:0];
    if ([zhuLable.text length] > 5) {
        zhuLable.text = [zhuLable.text substringToIndex:5];
    }
    
    zhuLable.textAlignment = NSTextAlignmentLeft;
    zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhuLable.font = [UIFont systemFontOfSize:12];
    zhuLable.tag = 9991;
    zhuLable.backgroundColor = [UIColor clearColor];
   
    [bgimage addSubview:zhuLable];
    [zhuLable release];
    
    UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(16 +140, 13, 30, 30)];
    VSLable.textAlignment = NSTextAlignmentCenter;
    VSLable.text = @"VS";
    VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLable.font = [UIFont systemFontOfSize:12];
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
    keLable.font = [UIFont systemFontOfSize:12];
    keLable.backgroundColor = [UIColor clearColor];
    
    [bgimage addSubview:keLable];
    [keLable release];
    
    
    if (showTye == shengpingfuType|| showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {
        VSLable.font = [UIFont systemFontOfSize:14];
        zhuLable.font = [UIFont systemFontOfSize:14];
        keLable.font = [UIFont systemFontOfSize:14];
        
        zhuLable.frame = CGRectMake(16 + 55 - 25.5, 13, 85, 30);
        VSLable.frame = CGRectMake(130.5, 13, 30, 30);
        keLable.frame = CGRectMake(16 +170 - 25.5, 13, 85, 30);
        
        return;
    }
    
//    shengfuType,
//    rangfenshengfuType,
//    shengfenchaType,
//    daxiaofenType,
//    lanqiudahuntouType,
    if (showTye == rangqiushengpingfuType  ){
        
        zhuLable.frame = CGRectMake(16 + 55 - 25.5, 13, 85, 30);
        VSLable.frame = CGRectMake(130.5, 13, 30, 30);
        keLable.frame = CGRectMake(16 +170 - 25.5, 13, 85, 30);
        
        UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10+(66 - 0.5)/2, 291 - 18, 0.5)];
        hengla3.backgroundColor = [UIColor clearColor];
        hengla3.image = UIImageGetImageFromName(@"bdxuxian.png");
        [bgimage addSubview:hengla3];
        [hengla3 release];
         return;
    }
    
    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(291 - 221, 10+(66 - 0.5)/2, 221, 0.5)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"bdxuxian.png");
    [bgimage addSubview:hengla2];
    [hengla2 release];
    
    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(13, 49, 50, 20)];
    opeiLable.textAlignment = NSTextAlignmentLeft;
    opeiLable.text = @"欧赔";
    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    opeiLable.font = [UIFont systemFontOfSize:11];
    opeiLable.backgroundColor = [UIColor clearColor];
    [bgimage addSubview:opeiLable];
    [opeiLable release];
    
    
    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(16 +45, 50, 50, 20)];
    opeiLable1.textAlignment = NSTextAlignmentCenter;
    
    opeiLable1.textColor = [UIColor  lightGrayColor];
    opeiLable1.tag = 9993;
    opeiLable1.font = [UIFont systemFontOfSize:11];
    opeiLable1.backgroundColor = [UIColor clearColor];
    
    [bgimage addSubview:opeiLable1];
    [opeiLable1 release];
    
    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(16 +130, 50, 50, 20)];
    opeiLable2.textAlignment = NSTextAlignmentCenter;
    //            opeiLable2.text = [oupeiarr objectAtIndex:1];
    opeiLable2.textColor = [UIColor  lightGrayColor];
    opeiLable2.font = [UIFont systemFontOfSize:11];
    opeiLable2.backgroundColor = [UIColor clearColor];
    opeiLable2.tag = 9994;
    
    [bgimage addSubview:opeiLable2];
    [opeiLable2 release];
    
    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(16 +218, 50, 50, 20)];
    opeiLable3.textAlignment = NSTextAlignmentCenter;
    //            opeiLable3.text = [oupeiarr objectAtIndex:2];
    opeiLable3.textColor = [UIColor  lightGrayColor];
    opeiLable3.font = [UIFont systemFontOfSize:11];
    opeiLable3.backgroundColor = [UIColor clearColor];
    opeiLable3.tag = 9995;
    
    [bgimage addSubview:opeiLable3];
    [opeiLable3 release];
    
}


- (void)allButtonFunc{//创建按钮

    
    int width = 84;
    int hight = 38.5;
    int tagbut = 1;
    int hang = 0;
    int lie = 0;
    float countHight;
    if (showTye == shengpingfuType) {
        hang = 1;
        lie = 3;
        countHight= 70;
    }else if (showTye == rangqiushengpingfuType){
        hang = 1;
        lie = 3;
        countHight= 77;
    }else if (showTye == zongjinqiuType){
        hang = 3;
        lie = 3;
        countHight= 100;
    }else if (showTye == banquanchangType){
        hang = 3;
        lie = 3;
        countHight= 100;
    }else if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == daxiaofenType){
        width = 115;
        hight = 32.5;
        hang = 1;
        lie = 2;
        countHight= 102;
    }else if (showTye == shengfenchaType){
        hight = 32.5;
        width = 84;
        hang = 4;
        lie = 3;
        countHight= 102;
    }
    
    NSLog(@"tag = %d", tagbut);
    //第一个
    for (int i = 0; i < hang; i++) {
        for (int j = 0; j < lie; j++) {
            
            
            if (showTye == zongjinqiuType) {
                if (i == 2 && j == 2){
                    break;
                }
            }
            
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            
            
            
             [shangbut setBackgroundImage:[UIImageGetImageFromName(@"bdbfwqbg.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 34, hight)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentLeft;
//            labbifen.font = [UIFont systemFontOfSize:11];
            labbifen.font = [UIFont fontWithName:@"TRENDS" size:11];
            labbifen.textColor = [UIColor whiteColor];
            labbifen.tag = 90;
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(46, 0, 35, hight)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textColor = [UIColor whiteColor];
            peilula.textAlignment = NSTextAlignmentLeft;
            peilula.font = [UIFont systemFontOfSize:9];
            peilula.tag = 100;
         
            labbifen.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
            
            if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == daxiaofenType){
                
                shangbut.frame = CGRectMake(j*width+12+(j*37), i*hight+countHight+(i*9), width, hight);
                labbifen.frame = CGRectMake(0, 0, width/2, hight);
                peilula.frame = CGRectMake(width/2, 0, width/2, hight);
                peilula.font = [UIFont systemFontOfSize:14];
                labbifen.font = [UIFont systemFontOfSize:14];
                labbifen.textAlignment = NSTextAlignmentCenter;
                peilula.textAlignment = NSTextAlignmentCenter;
                labbifen.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
            }else if (showTye == shengfenchaType){
                shangbut.frame = CGRectMake(j*width+12+(j*9), i*hight+countHight+(i*9), width, hight);
                labbifen.frame = CGRectMake(0, 1, width, hight/2);
                peilula.frame = CGRectMake(0, hight/2-1, width, hight/2);
                labbifen.textAlignment = NSTextAlignmentCenter;
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:12];
                labbifen.font = [UIFont systemFontOfSize:12];
                labbifen.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
            }else{
                shangbut.frame = CGRectMake(j*width+10+(j*9), i*hight+countHight+(i*9), width, hight);
            }
            
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
    
    
    
    if (showTye == daxiaofenType || showTye == rangfenshengfuType) {
        UILabel * rangfenLabel = [[UILabel alloc] initWithFrame:CGRectMake(12+width, countHight, 37, hight)];
        rangfenLabel.tag = 912;
        rangfenLabel.backgroundColor = [UIColor clearColor];
        rangfenLabel.textAlignment = NSTextAlignmentCenter;
        rangfenLabel.font = [UIFont systemFontOfSize:11];
        rangfenLabel.textColor = [UIColor redColor];
        [bgimage addSubview:rangfenLabel];
        [rangfenLabel release];
    }

}

- (void)pressShangButton:(UIButton *)sender{
    
    UILabel * labbifen = (UILabel *)[sender viewWithTag:90];
    UILabel * peilula = (UILabel *)[sender viewWithTag:100];
    NSInteger number = 0;

    if (showTye == shengpingfuType) {
        number = sender.tag - 1;
    }else if (showTye == rangqiushengpingfuType){
       number = sender.tag - 1 + 3;
    }else if (showTye == zongjinqiuType){
       number = sender.tag - 1 + 6;
    }else if (showTye == banquanchangType){
         number = sender.tag - 1 + 45;
    }else if (showTye == shengfuType){
        number = sender.tag - 1;
    }else if (showTye == rangfenshengfuType){
        number = sender.tag - 1 + 2;
    }else if (showTye == daxiaofenType){
        number = sender.tag - 1 + 4;
    }else if (showTye == shengfenchaType){
        number = sender.tag - 1 + 6;
    }
    

    
    if ([[self.typeButtonArray objectAtIndex:number] isEqualToString:@"1"]) {
        
        [self.typeButtonArray replaceObjectAtIndex:number withObject:@"0"];
        
        
        
        [sender setBackgroundImage:[UIImageGetImageFromName(@"bdbfwqbg.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        labbifen.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        peilula.textColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
        
        
    }else{
        [self.typeButtonArray replaceObjectAtIndex:number withObject:@"1"];
        
        [sender setBackgroundImage:[UIImageGetImageFromName(@"bdkeshengimage_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        labbifen.textColor = [UIColor whiteColor];
        peilula.textColor = [UIColor whiteColor];
        
    }
    
    
    
}


- (id)initWithType:(BigHunTouBoxType)type wangqin:(BOOL)wangqi{
    self = [super init];
    if (self) {
        
        self.showTye = type;
        
    
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        self.frame = app.window.bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.wangqibool = wangqi;
        
        
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        bgimage.image = [UIImageGetImageFromName(@"huntoukuangnew.png") stretchableImageWithLeftCapWidth:150 topCapHeight:30];//
        
        [self addSubview:bgimage];
        [bgimage release];
        
        
        [self teamTitleLabelFunc];//标题 主队客队
        
       
        
        [self allButtonFunc];//所有按钮
        
        
        if (showTye == rangqiushengpingfuType) {
            
            
            rangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            rangLabel.font = [UIFont systemFontOfSize:11];
            rangLabel.textColor = [UIColor  redColor];
            rangLabel.backgroundColor = [UIColor clearColor];
            [bgimage addSubview:rangLabel];
            [rangLabel release];
            
            teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 57, 200, 15)];
            teamLabel.font = [UIFont systemFontOfSize:11];
            teamLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            teamLabel.backgroundColor = [UIColor clearColor];
            [bgimage addSubview:teamLabel];
            [teamLabel release];
            
            UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 150, 271, 60)];
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont systemFontOfSize:11];
            textView.textColor = [UIColor lightGrayColor];
            textView.text = @"若主队让1球(-1),则主队的进球数减去1,再与客队的进球数相比的结果就是本场比赛的彩果。同理,若主队受让1球(+1),则主队的进球数加1。";
            textView.userInteractionEnabled = NO;
            [bgimage addSubview:textView];
            [textView release];
            
        }
        
        [self cancelAndConfirm];//取消确定按钮
        
        if (showTye == shengfuType || showTye == rangfenshengfuType || showTye == shengfenchaType || showTye == daxiaofenType ) {
            
            UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
            titleChoseImage2.frame = CGRectMake(7, 69, 67, 20.5);
            [bgimage addSubview:titleChoseImage2];
            titleChoseImage2.image = UIImageGetImageFromName(@"bdtcktitle.png");
            [titleChoseImage2 release];
            UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage2.bounds];
            [titleChoseImage2 addSubview:choseTitle2];
            //        choseTitle2.shadowColor = [UIColor whiteColor];//阴影
            //        choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
            choseTitle2.font = [UIFont systemFontOfSize:11];
            choseTitle2.textAlignment = NSTextAlignmentCenter;
            choseTitle2.backgroundColor = [UIColor clearColor];
            if (showTye == shengfuType) {
                choseTitle2.text = @"胜负";
            }else if (showTye == rangfenshengfuType) {
                choseTitle2.text = @"让分胜负";
            }else if (showTye == daxiaofenType) {
                choseTitle2.text = @"大小分";
            }else if (showTye == shengfenchaType) {
                choseTitle2.text = @"胜分差";
            }
            
            choseTitle2.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
            [choseTitle2 release];
            UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 69+20, bgimage.frame.size.width - 2, 0.5)];
            hengla21.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:207/255.0 alpha:1];
            [bgimage addSubview:hengla21];
            [hengla21 release];
            
        }
        
    }
    return self;
}





@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
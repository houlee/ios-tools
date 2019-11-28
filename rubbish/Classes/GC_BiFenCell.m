//
//  PKBetCell.m
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_BiFenCell.h"
#import "NewAroundViewController.h"
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"
#import "CP_PTButton.h"

@implementation GC_BiFenCell
@synthesize eventLabel;

@synthesize timeLabel;
@synthesize teamLabel;
@synthesize butLabel1;
@synthesize butLabel2;
@synthesize butLabel3;
@synthesize view;
@synthesize count;
@synthesize selection1;
@synthesize selection2;
@synthesize selection3;
@synthesize row;
@synthesize wangqibool;
@synthesize delegate;
@synthesize playid;
@synthesize matcinfo;
@synthesize boldan;
@synthesize cout;
@synthesize nengyong;
@synthesize dandan;
@synthesize homeduiLabel;
@synthesize keduiLabel;
@synthesize rangqiulabel;
@synthesize xibutton;
@synthesize panduan, donghua, chaodanbool, matchenumcell;

#pragma mark CP_UIAlertViewDelegate
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
    
        NSLog(@"xxxxxxxxxxxxxxx");
        
        for (int i = 0; i < 6; i++) {
            CP_XZButton * xzbutton = (CP_XZButton *)[infoImageView viewWithTag:i+10];
            if (saveButtonTag == xzbutton.tag) {
                xzbutton.selected = YES;
                buffer[i] = 1;
            }else {
                xzbutton.selected = NO;
                buffer[i] = 0;
            }
            
        }
    
    }else {
    
        CP_XZButton * xzbutton = (CP_XZButton *)[infoImageView viewWithTag:saveButtonTag];
        xzbutton.selected = NO;
        buffer[saveButtonTag-10] = 0;
    }

}

- (void)selectCickeChuan:(CP_XZButton *)sender{
    
    
    
    
//    BOOL qiansan = NO;
//    for (int i = 0; i < 3; i++) {
//        CP_XZButton * xzbutton = (CP_XZButton *)[infoImageView viewWithTag:i+10];
//        if (xzbutton.selected == YES) {
//            qiansan = YES;
//        }
//    }
    
//    BOOL housan = NO;
//    for (int i = 0; i < 3; i++) {
//        CP_XZButton * xzbutton2 = (CP_XZButton *)[infoImageView viewWithTag:i+10+3];
//        if (xzbutton2.selected == YES) {
//            housan = YES;
//        }
//    }
    
//    if ((qiansan == YES && housan == NO)||(qiansan == NO && housan == YES)||(qiansan == NO && housan == NO)) {
        if (sender.selected == YES) {
            
            buffer[sender.tag-10] = 1;
        }else {
            
            buffer[sender.tag-10] = 0;
        }
    
//    }else if(((sender.tag-10 < 3) && housan == YES) || ((sender.tag >= 3 && qiansan == YES))){
//        
//        saveButtonTag = sender.tag;
//        
//        
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"该场比赛已选择了其他玩法选项,如果继续将清空已选选项,是否继续?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
//        [alert show];
//        [alert release];
//        
//        
//    }
}

- (void)pressHunTouButton:(UIButton *)sender{

    NSLog(@"cell");
    NSLog(@"buf = %@", pkbetdata.bufshuarr);
    for (int i = 0; i < 31; i++) {
        buffer[i] = 0;
    }
    for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds]; //整个view
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 300, 205+47+41)];//背景图
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.userInteractionEnabled = YES;
    bgimage.image = UIImageGetImageFromName(@"TYHBG960-1.png");//
    bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
    
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
    titleImage.frame = CGRectMake(87.5, -1, 125, 30);
    [bgimage addSubview:titleImage];
    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
    lable.text = @"投注内容";
    [titleImage addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.shadowColor = [UIColor whiteColor];//阴影
    lable.shadowOffset = CGSizeMake(0, 1.0);
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    [titleImage release];
    
    
    
    
    
    UIImageView * teamNameImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 230, 31)];//队名的图片
    teamNameImage.backgroundColor = [UIColor clearColor];
    teamNameImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20];
    [bgimage addSubview:teamNameImage];
    [teamNameImage release];
    NSArray * teamarray = [pkbetdata.team componentsSeparatedByString:@","];//0是主队 1是客队 2是让球
    if (teamarray.count < 3) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
    UILabel * homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 31)];//主队
    homeLabel.font = [UIFont boldSystemFontOfSize:13];
    homeLabel.backgroundColor = [UIColor clearColor];
    homeLabel.textAlignment = NSTextAlignmentRight;
    homeLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    homeLabel.text = [teamarray objectAtIndex:0];

    if ( [homeLabel.text length] > 5) {
         homeLabel.text = [homeLabel.text substringToIndex:5];
    }
//    homeLabel.backgroundColor = [UIColor yellowColor];
    [teamNameImage addSubview:homeLabel];
    [homeLabel release];
    
    UILabel * guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(230-80, 0, 80, 31)];//客队
    guestLabel.font = [UIFont boldSystemFontOfSize:13];
    guestLabel.backgroundColor = [UIColor clearColor];
    guestLabel.textAlignment = NSTextAlignmentLeft;
    guestLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    guestLabel.text = [teamarray objectAtIndex:1];
//     guestLabel.backgroundColor = [UIColor yellowColor];
    if ( [guestLabel.text length] > 5) {
        guestLabel.text = [guestLabel.text substringToIndex:5];
    }
    [teamNameImage addSubview:guestLabel];
    [guestLabel release];
    
    
    UILabel * ranglabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 0, 30, 31)];//让球
    ranglabel.font = [UIFont boldSystemFontOfSize:13];
    ranglabel.backgroundColor = [UIColor clearColor];
    ranglabel.textAlignment = NSTextAlignmentLeft;
    ranglabel.textColor = [UIColor  redColor];
    ranglabel.text = [teamarray objectAtIndex:2];
//    ranglabel.backgroundColor = [UIColor yellowColor];
    [teamNameImage addSubview:ranglabel];
    [ranglabel release];
    
    
    UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 30, 31)];
    vsLabel.font = [UIFont boldSystemFontOfSize:13];
    vsLabel.backgroundColor = [UIColor clearColor];
    vsLabel.textAlignment = NSTextAlignmentCenter;
    vsLabel.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    vsLabel.text = @"vs";
    [teamNameImage addSubview:vsLabel];
    [vsLabel release];
    
   infoImageView = [[UIImageView alloc] init];
    infoImageView.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    infoImageView.frame = CGRectMake(15, 32+41, 270, 113+47);
    infoImageView.userInteractionEnabled = YES;
    [bgimage addSubview:infoImageView];
    [infoImageView release];
    
    
    
    
    UIImageView *titleChoseImage = [[UIImageView alloc] init];
    titleChoseImage.frame = CGRectMake(10, 5, 70.5, 21.5);
    [infoImageView addSubview:titleChoseImage];
    titleChoseImage.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage release];
    
    UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage addSubview:choseTitle];
    choseTitle.shadowColor = [UIColor whiteColor];//阴影
    choseTitle.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle.font = [UIFont systemFontOfSize:11];
    choseTitle.textAlignment = NSTextAlignmentCenter;
    choseTitle.backgroundColor = [UIColor clearColor];
    choseTitle.text = @"胜平负";
    [choseTitle release];

    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 26.5, 270, 2)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImageView addSubview:hengla2];
    [hengla2 release];
    
    
    
    
    for (int i = 0; i < 3; i++) {//上三个按钮
        CP_XZButton *testBtn = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        testBtn.frame = CGRectMake(10+i*5+(i*80), 7 + 35, 80, 29);
        testBtn.tag = i+10;
        
        
//        if ([testBtn.buttonName.text length] >5) {
            testBtn.buttonName.textAlignment = NSTextAlignmentCenter;
            testBtn.buttonName.frame = CGRectMake(0, 0, 103, 29);
        
        if (i == 0) {
            [testBtn loadButtonName:[NSString stringWithFormat:@" 胜 %@", [pkbetdata.oupeiarr objectAtIndex:i]]];
        }else if(i == 1){
            [testBtn loadButtonName:[NSString stringWithFormat:@" 平 %@", [pkbetdata.oupeiarr objectAtIndex:i]]];
        }else if(i == 2){
            [testBtn loadButtonName:[NSString stringWithFormat:@" 负 %@", [pkbetdata.oupeiarr objectAtIndex:i]]];
        }
        
        
//        }
        [testBtn addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (buffer[i] == 1) {
            testBtn.selected = YES;
        }else {
            testBtn.selected = NO;
        }
        
        if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]){
        
            testBtn.enabled = NO;
            testBtn.selected = NO;
            testBtn.buttonName.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        }else{
            testBtn.enabled = YES;
            testBtn.buttonName.textColor = [UIColor whiteColor];
        }
        
//        if ([chuanstring isEqualToString:@"1"]) {
//            testBtn.selected = YES;
//        }else{
//            testBtn.selected = NO;
//        }
        [infoImageView addSubview:testBtn];
    }
    
    
   
    
    
    
    UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
    titleChoseImage2.frame = CGRectMake(10, 42+29+12, 70.5, 21.5);
    [infoImageView addSubview:titleChoseImage2];
    titleChoseImage2.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage2 release];
    
    UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage2.bounds];
    [titleChoseImage2 addSubview:choseTitle2];
    choseTitle2.shadowColor = [UIColor whiteColor];//阴影
    choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle2.font = [UIFont systemFontOfSize:11];
    choseTitle2.textAlignment = NSTextAlignmentCenter;
    choseTitle2.backgroundColor = [UIColor clearColor];
    choseTitle2.text = @"让球胜平负";
    [choseTitle2 release];
    
    UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42+29+12+21.5, 270, 2)];
    hengla3.backgroundColor = [UIColor clearColor];
    hengla3.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImageView addSubview:hengla3];
    [hengla3 release];
    
    
    for (int i = 0; i < 3; i++) {//下面三个按钮
        CP_XZButton *testBtn2 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
        testBtn2.frame = CGRectMake(10+i*5+(i*80), 118.5, 80, 29);
        testBtn2.tag = i+10+3;
        
//        [testBtn2 loadButtonName:@"xxx"];
//        if ([testBtn2.buttonName.text length] >5) {
            testBtn2.buttonName.textAlignment = NSTextAlignmentCenter;
            testBtn2.buttonName.frame = CGRectMake(0, 0, 103, 29);
        if (i == 0) {
            [testBtn2 loadButtonName:[NSString stringWithFormat:@" 胜 %@", [pkbetdata.oupeiarr objectAtIndex:i+3]]];
        }else if(i == 1){
            [testBtn2 loadButtonName:[NSString stringWithFormat:@" 平 %@", [pkbetdata.oupeiarr objectAtIndex:i+3]]];
        }else if(i == 2){
            [testBtn2 loadButtonName:[NSString stringWithFormat:@" 负 %@", [pkbetdata.oupeiarr objectAtIndex:i+3]]];
        }//        }
        [testBtn2 addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];
        
        if (buffer[i+3] == 1) {
            testBtn2.selected = YES;
        }else {
            testBtn2.selected = NO;
        }
        
        if ([[pkbetdata.oupeiarr objectAtIndex:i+3] isEqualToString:@"-"]){
            
            testBtn2.enabled = NO;
            testBtn2.selected = NO;
             testBtn2.buttonName.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        }else{
            testBtn2.enabled = YES;
             testBtn2.buttonName.textColor = [UIColor whiteColor];
        }
        
        //        if ([chuanstring isEqualToString:@"1"]) {
        //            testBtn.selected = YES;
        //        }else{
        //            testBtn.selected = NO;
        //        }
        [infoImageView addSubview:testBtn2];
    }
    
    
    
    
    
    CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(10, 158+47+41, 135, 35)];//取消按钮
    [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
    cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.buttonName.textColor = [UIColor whiteColor];
    cancelButton.buttonName.shadowColor = [UIColor blackColor];
    cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    cancelButton.buttonName.frame = cancelButton.bounds;
    cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
    
    CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(150, 158+47+41, 135, 35)];//确定按钮
    [quedingbut loadButonImage:@"TYD960.png" LabelName:@"确定"];
    quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
    quedingbut.buttonName.textColor = [UIColor whiteColor];
    quedingbut.buttonName.shadowColor = [UIColor blackColor];
    quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    quedingbut.buttonName.frame = cancelButton.bounds;
    quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
    
    
    [bgview addSubview:bgimage];
    [bgimage release];
    
    
    
#ifdef isCaiPiaoForIPad
    //    bgimage
    
    bgimage.frame = CGRectMake((768-300)/2, (1024-205)/2, 300, 205);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [bgimage.layer addAnimation:rotationAnimation forKey:@"run"];
    bgimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#endif
    [appDelegate.window addSubview:bgview];
    
    

}

- (void)pressZongJinQiuButton:(UIButton *)sender{
    for (int i = 0; i < 31; i++) {
        buffer[i] = 0;
    }
    for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
    }
    NSMutableArray * bifenarr;
    if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        
        bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
        
    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
    
        bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
        
    }
   
    // NSArray * oupeiarr = [pkbetdata.oupeistr componentsSeparatedByString:@" "];
    
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 300, 251)];
    if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        
        bgimage.frame =  CGRectMake(10, 80, 300, 297);
        
    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
        
        bgimage.frame =  CGRectMake(10, 80, 300, 251);
        
    }
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.userInteractionEnabled = YES;
    bgimage.image = UIImageGetImageFromName(@"TYHBG960-1.png");//
    bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
    
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
    titleImage.frame = CGRectMake(87.5, -1, 125, 30);
    [bgimage addSubview:titleImage];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
    lable.text = @"投注选择";
    [titleImage addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.shadowColor = [UIColor whiteColor];//阴影
    lable.shadowOffset = CGSizeMake(0, 1.0);
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    [titleImage release];
    
    UIImageView *infoImage = [[UIImageView alloc] init];
    infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    infoImage.frame = CGRectMake(15, 43, 270, 140);
    infoImage.userInteractionEnabled = YES;
    [bgimage addSubview:infoImage];
    [infoImage release];
    
    
    
     NSArray * teamarray = [pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 4, 70, 20)];
    zhuLable.text = [teamarray objectAtIndex:0];
    if ([zhuLable.text length] > 5) {
        zhuLable.text = [zhuLable.text substringToIndex:5];
    }

    zhuLable.textAlignment = NSTextAlignmentLeft;
    zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhuLable.font = [UIFont boldSystemFontOfSize:11];
    zhuLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:zhuLable];
    [zhuLable release];
    
    UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(125, 4, 20, 20)];
    VSLable.textAlignment = NSTextAlignmentCenter;
    VSLable.text = @"vs";
    VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLable.font = [UIFont boldSystemFontOfSize:11];
    VSLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:VSLable];
    [VSLable release];
    
    
    UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 4, 70, 20)];
    keLable.text = [teamarray objectAtIndex:1];
    if ([keLable.text length] > 5) {
        keLable.text = [keLable.text substringToIndex:5];
    }
    keLable.textAlignment = NSTextAlignmentRight;
    keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    keLable.font = [UIFont boldSystemFontOfSize:11];
    keLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:keLable];
    [keLable release];
    
    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 50, 20)];
    opeiLable.textAlignment = NSTextAlignmentLeft;
    opeiLable.text = @"欧赔";
    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    opeiLable.font = [UIFont boldSystemFontOfSize:11];
    opeiLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable];
    [opeiLable release];
    
    NSArray * oupeiarr  = [pkbetdata.oupeiPeilv componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 3) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(83, 20, 50, 20)];
    opeiLable1.textAlignment = NSTextAlignmentCenter;
    opeiLable1.text = [oupeiarr objectAtIndex:0];
    opeiLable1.textColor = [UIColor  lightGrayColor];
    opeiLable1.font = [UIFont boldSystemFontOfSize:11];
    opeiLable1.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable1];
    [opeiLable1 release];
    
    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(138, 20, 50, 20)];
    opeiLable2.textAlignment = NSTextAlignmentCenter;
    opeiLable2.text = [oupeiarr objectAtIndex:1];
    opeiLable2.textColor = [UIColor  lightGrayColor];
    opeiLable2.font = [UIFont boldSystemFontOfSize:11];
    opeiLable2.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable2];
    [opeiLable2 release];
    
    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(193, 20, 50, 20)];
    opeiLable3.textAlignment = NSTextAlignmentCenter;
    opeiLable3.text = [oupeiarr objectAtIndex:2];
    opeiLable3.textColor = [UIColor  lightGrayColor];
    opeiLable3.font = [UIFont boldSystemFontOfSize:11];
    opeiLable3.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable3];
    [opeiLable3 release];
    
    
    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 39, 268, 2)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla2];
    [hengla2 release];
    
    int line = 0;
    int list = 0;
    int jiange = 0;
    int xzhou = 0;
    if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        
        line = 3;
        list = 3;
        jiange = 25;
        xzhou = 30;
        infoImage.frame = CGRectMake(15, 43, 270, 191);
    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
        
        line = 2;
        list = 4;
        jiange = 11;
        xzhou = 10;
        infoImage.frame = CGRectMake(15, 43, 270, 140);
    }
    
    
    int width = 53;
    int hight = 33;
    int tagbut = 0;
    for (int i = 0; i < line; i++) {
        for (int j = 0; j < list; j++) {
//            if (matchenumcell == matchEnumBanQuanChangCell|| matchenumcell == matchEnumBanQuanChangDanGuanCell) {
//                if (i == 1 && j == 2){
//                    break;
//                }
//            }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
//                if (i == 1 && j == 1){
//                    break;
//                }
//            }
            
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+xzhou+(j*jiange), i*hight+53+(i*12), width, hight);
            
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.font = [UIFont systemFontOfSize:9];
            labbifen.textColor = [UIColor whiteColor];
            NSLog(@"tag = %d", tagbut);
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            labbifen.tag = 9;
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
            peilula.textColor = [UIColor whiteColor];
            peilula.tag = 10;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
            }
            
            if (buffer[tagbut] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
                
            }else{
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
                
            }
            
            tagbut += 1;
            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];
            [infoImage addSubview:shangbut];
        }
        
    }

    
    CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(24, 200, 120, 34)];
    [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
    cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.buttonName.textColor = [UIColor whiteColor];
    cancelButton.buttonName.shadowColor = [UIColor blackColor];
    cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    cancelButton.buttonName.frame = cancelButton.bounds;
    cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
    
    CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(156, 200, 120, 34)];
    [quedingbut loadButonImage:@"TYD960.png" LabelName:@"确定"];
    quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
    quedingbut.buttonName.textColor = [UIColor whiteColor];
    quedingbut.buttonName.shadowColor = [UIColor blackColor];
    quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    quedingbut.buttonName.frame = cancelButton.bounds;
    quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
    
    
    [bgview addSubview:bgimage];
    [bgimage release];
    
    if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        
        cancelButton.frame = CGRectMake(24, 247, 120, 34);
        quedingbut.frame = CGRectMake(156, 247, 120, 34);
        
    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
        
        cancelButton.frame = CGRectMake(24, 200, 120, 34);
        quedingbut.frame = CGRectMake(156, 200, 120, 34);
    }
#ifdef isCaiPiaoForIPad
//    bgimage
    
    bgimage.frame = CGRectMake((768-300)/2, (1024-205)/2, 300, 205);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [bgimage.layer addAnimation:rotationAnimation forKey:@"run"];
    bgimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#endif
    [appDelegate.window addSubview:bgview];
    
    
}




- (void)pressShangButton:(UIButton *)sender{
    
    if (matchenumcell == matchEnumLanqiuHunTouCell) {
        
        
        NSInteger tagCount = 0;
        if (sender.tag < 12 && sender.tag > 5) {
            tagCount = sender.tag + 6;
        }else if(sender.tag >= 12){
            tagCount = sender.tag - 6;
        }else{
            tagCount = sender.tag;
        }
        
        if (buffer[tagCount] == 0) {
            buffer[tagCount] = 1;
            
            if (sender.tag <= 5) {
                [sender setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen_1.png") forState:UIControlStateNormal];
            }else{
                [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
            }
            
        }else{
             buffer[tagCount] = 0;

            
            if (sender.tag <= 5) {
                [sender setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen.png") forState:UIControlStateNormal];
            }else{
                [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
            }
        
        }
        
    }else{
        if (buffer[sender.tag] == 0) {
            buffer[sender.tag] = 1;
            if (matchenumcell == matchEnumBiFenGuoguanCell || matchenumcell == matchEnumBiFenDanGuanCell) {
                //            if (sender.tag < 13) {
                //                [sender setImage:UIImageGetImageFromName(@"bifenlv.png") forState:UIControlStateNormal];
                //            }else if(sender.tag < 18){
                //                [sender setImage:UIImageGetImageFromName(@"bifenhuang.png") forState:UIControlStateNormal];
                //            }else{
                //                [sender setImage:UIImageGetImageFromName(@"bifenhong.png") forState:UIControlStateNormal];
                //            }
                [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
            }else if(matchenumcell == matchEnumZongJinQiuCell ||matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumZongJinQiuDanGuanCell || matchenumcell == matchEnumBanQuanChangDanGuanCell || matchenumcell == matchEnumShengFenChaDanDuanCell || matchenumcell == matchEnumShengFenChaGuoGuanCell || matchenumcell == matchEnumLanqiuHunTouCell || matchenumcell == matchEnumLanqiuHunTouCell){
                [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
            }
            
            
        }else{
            buffer[sender.tag] = 0;
            
            [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
        }
    
    }
    
   
}

- (void)pressLanQiuHunTouButton:(UIButton *)sender{

    for (int i = 0; i < 18; i++) {
        buffer[i] = 0;
    }
    for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
    }
    
    NSMutableArray * bifenarr = [NSMutableArray arrayWithObjects:@"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
    // NSArray * oupeiarr = [pkbetdata.oupeistr componentsSeparatedByString:@" "];
    
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 300, 449)];
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.userInteractionEnabled = YES;
    bgimage.image = UIImageGetImageFromName(@"TYHBG960-1.png");//
    bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
    
    
    
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
    titleImage.frame = CGRectMake(87.5, 2, 125, 30);
    [bgimage addSubview:titleImage];
    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
    lable.text = @"投注选择";
    [titleImage addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.shadowColor = [UIColor whiteColor];//阴影
    lable.shadowOffset = CGSizeMake(0, 1.0);
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    [titleImage release];
    
    UIImageView *infoImage = [[UIImageView alloc] init];
    infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    infoImage.frame = CGRectMake(17, 40, 266, 358);
    infoImage.userInteractionEnabled = YES;
    [bgimage addSubview:infoImage];
    [infoImage release];
    
    
    
    UIScrollView * myScrtollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
    myScrtollView.backgroundColor = [UIColor clearColor];
    myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 520);
    [infoImage addSubview:myScrtollView];
    [myScrtollView release];
    
    UIImageView * bgimaa = [[UIImageView alloc] initWithFrame:CGRectMake(1, 10, 264, 29)];
    [infoImage addSubview:bgimaa];
    
    bgimaa.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [bgimaa release];
    
    UIImageView * bgima = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0.2, 264, 38)];
    [infoImage addSubview:bgima];
    [bgima.layer setCornerRadius:7];
    bgima.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [bgima release];

    
    NSArray * teamarray = [pkbetdata.team componentsSeparatedByString:@","];
    NSLog(@"team = %@", pkbetdata.team);
    if ([teamarray count] < 4) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    
    UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(25, 4, 89, 20)];
    zhuLable.text = [teamarray objectAtIndex:0];
    if ([zhuLable.text length] > 5) {
        zhuLable.text = [zhuLable.text substringToIndex:5];
    }
    
    zhuLable.text = [NSString stringWithFormat:@"%@(客队)",zhuLable.text];
    
    
    zhuLable.textAlignment = NSTextAlignmentLeft;
    zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhuLable.font = [UIFont boldSystemFontOfSize:11];
    zhuLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:zhuLable];
    [zhuLable release];
    
    UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(125, 4, 20, 20)];
    VSLable.textAlignment = NSTextAlignmentCenter;
    VSLable.text = @"vs";
    VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLable.font = [UIFont boldSystemFontOfSize:11];
    VSLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:VSLable];
    [VSLable release];
    
    
    UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(152, 4, 89, 20)];
    keLable.text = [teamarray objectAtIndex:1];
    if ([keLable.text length] > 5) {
        keLable.text = [keLable.text substringToIndex:5];
    }
     keLable.text = [NSString stringWithFormat:@"%@(主队)",keLable.text];
    keLable.textAlignment = NSTextAlignmentRight;
    keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    keLable.font = [UIFont boldSystemFontOfSize:11];
    keLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:keLable];
    [keLable release];
    
    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(25, 20, 50, 20)];
    opeiLable.textAlignment = NSTextAlignmentLeft;
    opeiLable.text = @"澳门让分";
    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    opeiLable.font = [UIFont boldSystemFontOfSize:11];
    opeiLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable];
    [opeiLable release];
    
    NSArray * oupeiarr  = [pkbetdata.aomenoupei componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 2) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"", nil];
    }
    
//    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 50, 20)];
//    opeiLable1.textAlignment = NSTextAlignmentCenter;
//    opeiLable1.text = [oupeiarr objectAtIndex:0];
//    opeiLable1.textColor = [UIColor  lightGrayColor];
//    opeiLable1.font = [UIFont boldSystemFontOfSize:11];
//    opeiLable1.backgroundColor = [UIColor clearColor];
//    [myScrtollView addSubview:opeiLable1];
//    [opeiLable1 release];
    
    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 50, 20)];
    opeiLable2.textAlignment = NSTextAlignmentCenter;
    opeiLable2.text = [oupeiarr objectAtIndex:0];
    opeiLable2.textColor = [UIColor  lightGrayColor];
    opeiLable2.font = [UIFont boldSystemFontOfSize:11];
    opeiLable2.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable2];
    [opeiLable2 release];
    
    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(155, 20, 50, 20)];
    opeiLable3.textAlignment = NSTextAlignmentCenter;
    opeiLable3.text = [oupeiarr objectAtIndex:1];
    opeiLable3.textColor = [UIColor  lightGrayColor];
    opeiLable3.font = [UIFont boldSystemFontOfSize:11];
    opeiLable3.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable3];
    [opeiLable3 release];
    
    
    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 39, 264, 2)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla2];
    [hengla2 release];
    
    
    
    int width = 53;
    int hight = 33;
    int tagbut = 0;
    
    for (int i = 0; i < 2; i++) {//主胜 主负
        UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
        shangbut.tag = tagbut;
        
        shangbut.frame = CGRectMake(29+(i*87)+(i*40), 85, 87, 33);
        
        
        [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * labbifen = [[UILabel alloc] initWithFrame:shangbut.bounds];
        labbifen.backgroundColor = [UIColor clearColor];
        labbifen.textAlignment = NSTextAlignmentCenter;
        labbifen.textColor = [UIColor whiteColor];
        labbifen.font = [UIFont systemFontOfSize:9];
        NSLog(@"tag = %d", tagbut);
        labbifen.tag = 9;
        if (i == 0) {
           labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut], [pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }else{
            labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut], [pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }
        if ([[pkbetdata.oupeiarr objectAtIndex:tagbut] isEqualToString:@"-"]) {
            shangbut.enabled = NO;
             labbifen.textColor = [UIColor lightGrayColor];
        }else{
            shangbut.enabled = YES;
             labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        }
        
       
        if (buffer[tagbut] == 1) {
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen_1.png") forState:UIControlStateNormal];
            
        }else{
            
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen.png") forState:UIControlStateNormal];
            
        }
        
        tagbut += 1;
        [shangbut addSubview:labbifen];
        [labbifen release];
        [myScrtollView addSubview:shangbut];
    }
    
    for (int i = 0; i < 2; i++) {//让主胜 让主负
        UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
        shangbut.tag = tagbut;
        
        shangbut.frame = CGRectMake(29+(i*87)+(i*40), 164, 87, 33);
        
        
        [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * labbifen = [[UILabel alloc] initWithFrame:shangbut.bounds];
        labbifen.backgroundColor = [UIColor clearColor];
        labbifen.textAlignment = NSTextAlignmentCenter;
        labbifen.textColor = [UIColor whiteColor];
        labbifen.font = [UIFont systemFontOfSize:9];
        NSLog(@"tag = %d", tagbut);
        labbifen.tag = 9;
        if (i == 0) {
            labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut], [pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }else{
            labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut], [pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }
        
        
//        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        if ([[pkbetdata.oupeiarr objectAtIndex:tagbut] isEqualToString:@"-"]) {
            shangbut.enabled = NO;
            labbifen.textColor = [UIColor lightGrayColor];
        }else{
            shangbut.enabled = YES;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        }
        if (buffer[tagbut] == 1) {
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen_1.png") forState:UIControlStateNormal];
            
        }else{
            
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen.png") forState:UIControlStateNormal];
            
        }
        
        tagbut += 1;
        [shangbut addSubview:labbifen];
        [labbifen release];
        [myScrtollView addSubview:shangbut];
    }
//    NSString * rangstr = @"";
    
//    NSArray * rangarr = [rangstr componentsSeparatedByString:@","];
    
    UILabel * rangFenLabel = [[UILabel alloc] initWithFrame:CGRectMake(29+87, 164, 40, 33)];//让主胜 让分
    rangFenLabel.backgroundColor = [UIColor clearColor];
    rangFenLabel.textAlignment = NSTextAlignmentCenter;
    rangFenLabel.textColor = [UIColor redColor];
    rangFenLabel.font = [UIFont systemFontOfSize:9];
    if ([teamarray count] > 2) {
        if ([teamarray objectAtIndex:2] || ![[teamarray objectAtIndex:2] isEqualToString:@""]) {
            rangFenLabel.text = [teamarray objectAtIndex:2];
        }else{
            rangFenLabel.text = @"-";
        }
        if ([rangFenLabel.text isEqualToString:@"null"]) {
            rangFenLabel.text = @"-";
        }
        
    }
    
    
   
    [myScrtollView addSubview:rangFenLabel];
    [rangFenLabel release];
    
    for (int i = 0; i < 2; i++) {//大小分
        UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
        shangbut.tag = tagbut;
        
        shangbut.frame = CGRectMake(29+(i*87)+(i*40), 240, 87, 33);
        
        
        [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * labbifen = [[UILabel alloc] initWithFrame:shangbut.bounds];
        labbifen.backgroundColor = [UIColor clearColor];
        labbifen.textAlignment = NSTextAlignmentCenter;
        labbifen.textColor = [UIColor whiteColor];
        labbifen.font = [UIFont systemFontOfSize:9];
        NSLog(@"tag = %d", tagbut);
        labbifen.tag = 9;
        if (i == 0) {
            labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut],[pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }else{
            labbifen.text = [NSString stringWithFormat:@"%@ %@", [bifenarr objectAtIndex:tagbut], [pkbetdata.oupeiarr objectAtIndex:tagbut]];
        }
        
        if ([[pkbetdata.oupeiarr objectAtIndex:tagbut] isEqualToString:@"-"]) {
            shangbut.enabled = NO;
            labbifen.textColor = [UIColor lightGrayColor];
        }else{
            shangbut.enabled = YES;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        }
//        labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
        if (buffer[tagbut] == 1) {
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen_1.png") forState:UIControlStateNormal];
            
        }else{
            
            [shangbut setImage:UIImageGetImageFromName(@"lanqiuhuntoubifen.png") forState:UIControlStateNormal];
            
        }
        
        tagbut += 1;
        [shangbut addSubview:labbifen];
        [labbifen release];
        [myScrtollView addSubview:shangbut];
    }
 
    UILabel * rangFenLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(29+87, 240, 40, 33)];//让主胜 让分
    rangFenLabel2.backgroundColor = [UIColor clearColor];
    rangFenLabel2.textAlignment = NSTextAlignmentCenter;
    rangFenLabel2.textColor = [UIColor colorWithRed:0 green:98/255.0 blue:2/255.0 alpha:1];
    rangFenLabel2.font = [UIFont systemFontOfSize:9];
    
    if ([teamarray count] > 3) {
        if ([teamarray objectAtIndex:3] || ![[teamarray objectAtIndex:3] isEqualToString:@""]) {
            rangFenLabel2.text = [teamarray objectAtIndex:3];
        }else{
            rangFenLabel2.text = @"-";
        }
        
        if ([rangFenLabel2.text isEqualToString:@"null"]) {
            rangFenLabel2.text = @"-";
        }
        
    }
    
    
    [myScrtollView addSubview:rangFenLabel2];
    [rangFenLabel2 release];
    
    for (int i = 0; i < 4; i++) {//胜分差 赔率颠倒 主胜在前
        for (int j = 0; j < 3; j++) {
//            if (i == 3 && j == 1){
//                break;
//            }
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+29+(j*26), i*hight+318+(i*11), width, hight);
            
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.textColor = [UIColor whiteColor];
            labbifen.font = [UIFont systemFontOfSize:9];
            NSLog(@"tag = %d", tagbut);
            labbifen.tag = 9;
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
            peilula.tag = 10;
            peilula.textColor = [UIColor whiteColor];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                if (tagbut < 12) {
                   
                    if ([pkbetdata.oupeiarr count] > tagbut+6) {
                         peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut+6];
                    }
                   
                }else{
                    if ([pkbetdata.oupeiarr count] >= tagbut-6) {
                        peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut-6];
                    }
                    
                }
                
            }
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
//            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if ([peilula.text isEqualToString:@"-"]) {
                shangbut.enabled = NO;
                peilula.textColor = [UIColor lightGrayColor];
            }else{
                shangbut.enabled = YES;
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            }
            NSInteger bagcount = 0;
//            bagcount = tagbut;
            if (tagbut < 12) {
                bagcount = tagbut+6;
            }else{
                bagcount = tagbut-6;
            }
            if (buffer[bagcount] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
                
            }else{
                
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
                
            }
            
            tagbut += 1;
            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];
            [myScrtollView addSubview:shangbut];
        }
        
    }
    
    NSLog(@"tag = %d", tagbut);
    
    
    UIImageView *titleChoseImage = [[UIImageView alloc] init];
    titleChoseImage.frame = CGRectMake(7, 53, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage];
    titleChoseImage.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage release];
    UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage addSubview:choseTitle];
    choseTitle.shadowColor = [UIColor whiteColor];//阴影
    choseTitle.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle.font = [UIFont systemFontOfSize:11];
    choseTitle.textAlignment = NSTextAlignmentCenter;
    choseTitle.backgroundColor = [UIColor clearColor];
    choseTitle.text = @"胜负";
    [choseTitle release];
    UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 74.5, 264, 2)];
    hengla.backgroundColor = [UIColor clearColor];
    hengla.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla];
    [hengla release];
    
    
    UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
    titleChoseImage2.frame = CGRectMake(7, 130, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage2];
    titleChoseImage2.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage2 release];
    UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage2 addSubview:choseTitle2];
    choseTitle2.shadowColor = [UIColor whiteColor];//阴影
    choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle2.font = [UIFont systemFontOfSize:11];
    choseTitle2.textAlignment = NSTextAlignmentCenter;
    choseTitle2.backgroundColor = [UIColor clearColor];
    choseTitle2.text = @"让分胜负";
    [choseTitle2 release];
    UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 151.5, 264, 2)];
    hengla21.backgroundColor = [UIColor clearColor];
    hengla21.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla21];
    [hengla21 release];
    
    
    UIImageView *titleChoseImage3 = [[UIImageView alloc] init];
    titleChoseImage3.frame = CGRectMake(7, 209, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage3];
    titleChoseImage3.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage3 release];
    UILabel *choseTitle3 = [[UILabel alloc] initWithFrame:titleChoseImage3.bounds];
    [titleChoseImage3 addSubview:choseTitle3];
    choseTitle3.shadowColor = [UIColor whiteColor];//阴影
    choseTitle3.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle3.font = [UIFont systemFontOfSize:11];
    choseTitle3.textAlignment = NSTextAlignmentCenter;
    choseTitle3.backgroundColor = [UIColor clearColor];
    choseTitle3.text = @"大小分";
    [choseTitle3 release];
    UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 230.5, 264, 2)];
    hengla3.backgroundColor = [UIColor clearColor];
    hengla3.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla3];
    [hengla3 release];
    
    UIImageView *titleChoseImage4 = [[UIImageView alloc] init];
    titleChoseImage4.frame = CGRectMake(7, 286, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage4];
    titleChoseImage4.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage4 release];
    UILabel *choseTitle4 = [[UILabel alloc] initWithFrame:titleChoseImage3.bounds];
    [titleChoseImage4 addSubview:choseTitle4];
    choseTitle4.shadowColor = [UIColor whiteColor];//阴影
    choseTitle4.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle4.font = [UIFont systemFontOfSize:11];
    choseTitle4.textAlignment = NSTextAlignmentCenter;
    choseTitle4.backgroundColor = [UIColor clearColor];
    choseTitle4.text = @"胜分差";
    [choseTitle4 release];
    UIImageView * hengla4 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 307.5, 264, 2)];
    hengla4.backgroundColor = [UIColor clearColor];
    hengla4.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla4];
    [hengla4 release];
    
    
    NSLog(@"tag = %d", tagbut);
    CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(24, 405, 120, 34)];
    [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
    cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.buttonName.textColor = [UIColor whiteColor];
    cancelButton.buttonName.shadowColor = [UIColor blackColor];
    cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    cancelButton.buttonName.frame = cancelButton.bounds;
    cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
    
    CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(156, 405, 120, 34)];
    [quedingbut loadButonImage:@"TYD960.png" LabelName:@"确定"];
    quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
    quedingbut.buttonName.textColor = [UIColor whiteColor];
    quedingbut.buttonName.shadowColor = [UIColor blackColor];
    quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    quedingbut.buttonName.frame = cancelButton.bounds;
    quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
    [bgview addSubview:bgimage];
    [bgimage release];
    
#ifdef isCaiPiaoForIPad
    //    bgimage
    
    bgimage.frame = CGRectMake( (768-300)/2,(1024-410)/2, 300, 410);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [bgimage.layer addAnimation:rotationAnimation forKey:@"run"];
    bgimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#endif
    
    [appDelegate.window addSubview:bgview];

}


- (void)pressBiFenButton:(UIButton *)sender{
    for (int i = 0; i < 31; i++) {
        buffer[i] = 0;
    }
    for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
    }
    
           NSMutableArray * bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
    // NSArray * oupeiarr = [pkbetdata.oupeistr componentsSeparatedByString:@" "];
   
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
   bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 300, 449)];
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.userInteractionEnabled = YES;
    bgimage.image = UIImageGetImageFromName(@"TYHBG960-1.png");//
    bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
    
    
    
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
    titleImage.frame = CGRectMake(87.5, 2, 125, 30);
    [bgimage addSubview:titleImage];
    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
    lable.text = @"投注选择";
    [titleImage addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.shadowColor = [UIColor whiteColor];//阴影
    lable.shadowOffset = CGSizeMake(0, 1.0);
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    [titleImage release];
    
    UIImageView *infoImage = [[UIImageView alloc] init];
    infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    infoImage.frame = CGRectMake(17, 40, 266, 358);
    infoImage.userInteractionEnabled = YES;
    [bgimage addSubview:infoImage];
    [infoImage release];

    UIScrollView * myScrtollView = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
    myScrtollView.backgroundColor = [UIColor clearColor];
    myScrtollView.contentSize = CGSizeMake(infoImage.frame.size.width, 600);
    [infoImage addSubview:myScrtollView];
    [myScrtollView release];
    
    
    UIImageView * bgimaa = [[UIImageView alloc] initWithFrame:CGRectMake(1, 10, 264, 29)];
    [infoImage addSubview:bgimaa];
   
    bgimaa.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [bgimaa release];
    
    UIImageView * bgima = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0.2, 264, 38)];
    [infoImage addSubview:bgima];
    [bgima.layer setCornerRadius:7];
    bgima.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [bgima release];
    
    NSArray * teamarray = [pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    
    UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 4, 70, 20)];
    zhuLable.text = [teamarray objectAtIndex:0];
    if ([zhuLable.text length] > 5) {
        zhuLable.text = [zhuLable.text substringToIndex:5];
    }
    
    zhuLable.textAlignment = NSTextAlignmentLeft;
    zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhuLable.font = [UIFont boldSystemFontOfSize:11];
    zhuLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:zhuLable];
    [zhuLable release];
    
    UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(125, 4, 20, 20)];
    VSLable.textAlignment = NSTextAlignmentCenter;
    VSLable.text = @"vs";
    VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLable.font = [UIFont boldSystemFontOfSize:11];
    VSLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:VSLable];
    [VSLable release];
    
    
    UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 4, 70, 20)];
    keLable.text = [teamarray objectAtIndex:1];
    if ([keLable.text length] > 5) {
        keLable.text = [keLable.text substringToIndex:5];
    }
    keLable.textAlignment = NSTextAlignmentRight;
    keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    keLable.font = [UIFont boldSystemFontOfSize:11];
    keLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:keLable];
    [keLable release];
    
    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 50, 20)];
    opeiLable.textAlignment = NSTextAlignmentLeft;
    opeiLable.text = @"欧赔";
    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    opeiLable.font = [UIFont boldSystemFontOfSize:11];
    opeiLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable];
    [opeiLable release];
    
    NSArray * oupeiarr  = [pkbetdata.oupeiPeilv componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 3) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
    
    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(83, 20, 50, 20)];
    opeiLable1.textAlignment = NSTextAlignmentCenter;
    opeiLable1.text = [oupeiarr objectAtIndex:0];
    opeiLable1.textColor = [UIColor  lightGrayColor];
    opeiLable1.font = [UIFont boldSystemFontOfSize:11];
    opeiLable1.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable1];
    [opeiLable1 release];
    
    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(138, 20, 50, 20)];
    opeiLable2.textAlignment = NSTextAlignmentCenter;
    opeiLable2.text = [oupeiarr objectAtIndex:1];
    opeiLable2.textColor = [UIColor  lightGrayColor];
    opeiLable2.font = [UIFont boldSystemFontOfSize:11];
    opeiLable2.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable2];
    [opeiLable2 release];
    
    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(192, 20, 50, 20)];
    opeiLable3.textAlignment = NSTextAlignmentCenter;
    opeiLable3.text = [oupeiarr objectAtIndex:2];
    opeiLable3.textColor = [UIColor  lightGrayColor];
    opeiLable3.font = [UIFont boldSystemFontOfSize:11];
    opeiLable3.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable3];
    [opeiLable3 release];
    
    
    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 39, 264, 2)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla2];
    [hengla2 release];
    
    
    
    int width = 53;
    int hight = 33;
    int tagbut = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 3 && j == 1){
                break;
            }
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+11+(j*11), i*hight+89+(i*11), width, hight);
            
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.textColor = [UIColor whiteColor];
            labbifen.font = [UIFont systemFontOfSize:9];
             NSLog(@"tag = %d", tagbut);
            labbifen.tag = 9;
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
            peilula.tag = 10;
            peilula.textColor = [UIColor whiteColor];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
            }
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if (buffer[tagbut] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
                
            }else{
                
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
                
            }
            
            tagbut += 1;
            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];
            [myScrtollView addSubview:shangbut];
        }
       
    }
    
    NSLog(@"tag = %d", tagbut);
        for (int i = 0; i < 2; i++) {
            
            for (int j = 0; j < 4; j++) {
                
                if (i == 1 && j == 1){
                    break;
                }
                
                UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
                shangbut.frame = CGRectMake(0, 0, 0, 0);
                shangbut.tag = tagbut;
                
                shangbut.frame = CGRectMake(j*width+11+(j*11), i*hight+300+(i*11), width, hight);
                
                
                [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
                labbifen.backgroundColor = [UIColor clearColor];
                labbifen.textAlignment = NSTextAlignmentCenter;
                labbifen.font = [UIFont systemFontOfSize:9];
                labbifen.textColor = [UIColor whiteColor];
                labbifen.text = [bifenarr objectAtIndex:tagbut];
                labbifen.tag = 9;
                UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
                peilula.backgroundColor = [UIColor clearColor];
                peilula.textAlignment = NSTextAlignmentCenter;
                peilula.font = [UIFont systemFontOfSize:9];
                peilula.tag = 10;
                peilula.textColor = [UIColor whiteColor];
                labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
                if ([pkbetdata.oupeiarr count] > tagbut) {
                    peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
                }
                if (buffer[tagbut] == 1) {
                    [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
                    
                }else{
                    
                    [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
                   
                }
                
                tagbut += 1;
                [shangbut addSubview:labbifen];
                [shangbut addSubview:peilula];
                [peilula release];
                [labbifen release];
                
                [myScrtollView addSubview:shangbut];
            }
            
            
            
           
        }
        
    
    NSLog(@"tag = %d", tagbut);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 3 && j == 1){
                break;
            }
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+11+(j*11), i*hight+421+(i*11), width, hight);
            

            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.font = [UIFont systemFontOfSize:9];
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            labbifen.textColor = [UIColor whiteColor];
            labbifen.tag = 9;
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textColor = [UIColor whiteColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
            peilula.tag = 10;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
            }
            if (buffer[tagbut] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
                
            }else{
                
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
                
            }
            
            tagbut += 1;
            NSLog(@"tag = %d", tagbut);

            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];

            [myScrtollView addSubview:shangbut];
        }
        
    }
    
    
    UIImageView *titleChoseImage = [[UIImageView alloc] init];
    titleChoseImage.frame = CGRectMake(7, 55, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage];
    titleChoseImage.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage release];
    UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage addSubview:choseTitle];
    choseTitle.shadowColor = [UIColor whiteColor];//阴影
    choseTitle.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle.font = [UIFont systemFontOfSize:11];
    choseTitle.textAlignment = NSTextAlignmentCenter;
    choseTitle.backgroundColor = [UIColor clearColor];
    choseTitle.text = @"主胜";
    [choseTitle release];
    UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 76.5, 264, 2)];
    hengla.backgroundColor = [UIColor clearColor];
    hengla.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla];
    [hengla release];

    
    UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
    titleChoseImage2.frame = CGRectMake(7, 267, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage2];
    titleChoseImage2.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage2 release];
    UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage2 addSubview:choseTitle2];
    choseTitle2.shadowColor = [UIColor whiteColor];//阴影
    choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle2.font = [UIFont systemFontOfSize:11];
    choseTitle2.textAlignment = NSTextAlignmentCenter;
    choseTitle2.backgroundColor = [UIColor clearColor];
    choseTitle2.text = @"平局";
    [choseTitle2 release];
    UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 288.5, 264, 2)];
    hengla21.backgroundColor = [UIColor clearColor];
    hengla21.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla21];
    [hengla21 release];
    
    
    UIImageView *titleChoseImage3 = [[UIImageView alloc] init];
    titleChoseImage3.frame = CGRectMake(7, 388, 70.5, 21.5);
    [myScrtollView addSubview:titleChoseImage3];
    titleChoseImage3.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage3 release];
    UILabel *choseTitle3 = [[UILabel alloc] initWithFrame:titleChoseImage3.bounds];
    [titleChoseImage3 addSubview:choseTitle3];
    choseTitle3.shadowColor = [UIColor whiteColor];//阴影
    choseTitle3.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle3.font = [UIFont systemFontOfSize:11];
    choseTitle3.textAlignment = NSTextAlignmentCenter;
    choseTitle3.backgroundColor = [UIColor clearColor];
    choseTitle3.text = @"客胜";
    [choseTitle3 release];
    UIImageView * hengla3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 409.5, 264, 2)];
    hengla3.backgroundColor = [UIColor clearColor];
    hengla3.image = UIImageGetImageFromName(@"SZTG960.png");
    [myScrtollView addSubview:hengla3];
    [hengla3 release];
    
    
    NSLog(@"tag = %d", tagbut);
    CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(24, 405, 120, 34)];
    [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
    cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.buttonName.textColor = [UIColor whiteColor];
    cancelButton.buttonName.shadowColor = [UIColor blackColor];
    cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    cancelButton.buttonName.frame = cancelButton.bounds;
    cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
  
    CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(156, 405, 120, 34)];
    [quedingbut loadButonImage:@"TYD960.png" LabelName:@"确定"];
    quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
    quedingbut.buttonName.textColor = [UIColor whiteColor];
    quedingbut.buttonName.shadowColor = [UIColor blackColor];
    quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    quedingbut.buttonName.frame = cancelButton.bounds;
    quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
    [bgview addSubview:bgimage];
    [bgimage release];
    
#ifdef isCaiPiaoForIPad
    //    bgimage
    
    bgimage.frame = CGRectMake( (768-300)/2,(1024-410)/2, 300, 410);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [bgimage.layer addAnimation:rotationAnimation forKey:@"run"];
    bgimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#endif
    
    [appDelegate.window addSubview:bgview];
  //  [bgview release];
}

- (void)pressShengFenChaButton:(UIButton *)sender{
    for (int i = 0; i < 31; i++) {
        buffer[i] = 0;
    }
    for (int  i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        buffer[i] = [[pkbetdata.bufshuarr objectAtIndex:i] intValue];
    }

    NSMutableArray * bifenarr = [NSMutableArray arrayWithObjects:@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+", nil];
    // NSArray * oupeiarr = [pkbetdata.oupeistr componentsSeparatedByString:@" "];
    
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 300, 396)];
    bgimage.backgroundColor = [UIColor clearColor];
    bgimage.userInteractionEnabled = YES;
//    bgimage.image = UIImageGetImageFromName(@"shengfuchacell.png");
    bgimage.image = UIImageGetImageFromName(@"TYHBG960-1.png");//
    bgimage.image = [bgimage.image imageFromImage:bgimage.image inRect:bgimage.bounds];
    
    UIImageView * titleImage = [[UIImageView alloc] init];
    titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
    titleImage.frame = CGRectMake(87.5, -1, 125, 30);
    [bgimage addSubview:titleImage];
    UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
    lable.text = @"投注选择";
    [titleImage addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.shadowColor = [UIColor whiteColor];//阴影
    lable.shadowOffset = CGSizeMake(0, 1.0);
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    [titleImage release];
    
    UIImageView *infoImage = [[UIImageView alloc] init];
    infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    infoImage.frame = CGRectMake(17, 43, 266, 292);
    infoImage.userInteractionEnabled = YES;
    [bgimage addSubview:infoImage];
    [infoImage release];
    
    NSArray * teamarray = [pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count] < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    UILabel *zhuLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 4, 70, 20)];
    zhuLable.text = [teamarray objectAtIndex:0];
    if ([zhuLable.text length] > 5) {
        zhuLable.text = [zhuLable.text substringToIndex:5];
    }
    
    zhuLable.textAlignment = NSTextAlignmentLeft;
    zhuLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhuLable.font = [UIFont boldSystemFontOfSize:11];
    zhuLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:zhuLable];
    [zhuLable release];
    
    UILabel *VSLable = [[UILabel alloc] initWithFrame:CGRectMake(125, 4, 20, 20)];
    VSLable.textAlignment = NSTextAlignmentCenter;
    VSLable.text = @"vs";
    VSLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLable.font = [UIFont boldSystemFontOfSize:11];
    VSLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:VSLable];
    [VSLable release];
    
    
    UILabel *keLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 4, 70, 20)];
    keLable.text = [teamarray objectAtIndex:1];
    if ([keLable.text length] > 5) {
        keLable.text = [keLable.text substringToIndex:5];
    }
    keLable.textAlignment = NSTextAlignmentRight;
    keLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    keLable.font = [UIFont boldSystemFontOfSize:11];
    keLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:keLable];
    [keLable release];
    
//    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 50, 20)];
//    opeiLable.textAlignment = NSTextAlignmentLeft;
//    opeiLable.text = @"欧赔";
//    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    opeiLable.font = [UIFont boldSystemFontOfSize:11];
//    opeiLable.backgroundColor = [UIColor clearColor];
//    [infoImage addSubview:opeiLable];
//    [opeiLable release];
//    
//    NSArray * oupeiarr  = [pkbetdata.oupeiPeilv componentsSeparatedByString:@" "];
//    if ([oupeiarr count] < 3) {
//        oupeiarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
//    }
//    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(83, 20, 50, 20)];
//    opeiLable1.textAlignment = NSTextAlignmentCenter;
//    opeiLable1.text = [oupeiarr objectAtIndex:0];
//    opeiLable1.textColor = [UIColor  lightGrayColor];
//    opeiLable1.font = [UIFont boldSystemFontOfSize:11];
//    opeiLable1.backgroundColor = [UIColor clearColor];
//    [infoImage addSubview:opeiLable1];
//    [opeiLable1 release];
//    
//    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(138, 20, 50, 20)];
//    opeiLable2.textAlignment = NSTextAlignmentCenter;
//    opeiLable2.text = [oupeiarr objectAtIndex:1];
//    opeiLable2.textColor = [UIColor  lightGrayColor];
//    opeiLable2.font = [UIFont boldSystemFontOfSize:11];
//    opeiLable2.backgroundColor = [UIColor clearColor];
//    [infoImage addSubview:opeiLable2];
//    [opeiLable2 release];
//    
//    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(193, 20, 50, 20)];
//    opeiLable3.textAlignment = NSTextAlignmentCenter;
//    opeiLable3.text = [oupeiarr objectAtIndex:2];
//    opeiLable3.textColor = [UIColor  lightGrayColor];
//    opeiLable3.font = [UIFont boldSystemFontOfSize:11];
//    opeiLable3.backgroundColor = [UIColor clearColor];
//    [infoImage addSubview:opeiLable3];
//    [opeiLable3 release];
//
    UILabel *opeiLable = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 50, 20)];
    opeiLable.textAlignment = NSTextAlignmentLeft;
    opeiLable.text = @"澳门让分";
    opeiLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    opeiLable.font = [UIFont boldSystemFontOfSize:11];
    opeiLable.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable];
    [opeiLable release];
    
    NSArray * oupeiarr  = [pkbetdata.aomenoupei componentsSeparatedByString:@" "];
    if ([oupeiarr count] < 2) {
        oupeiarr = [NSArray arrayWithObjects:@"",@"", nil];
    }
    
    //    UILabel *opeiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 50, 20)];
    //    opeiLable1.textAlignment = NSTextAlignmentCenter;
    //    opeiLable1.text = [oupeiarr objectAtIndex:0];
    //    opeiLable1.textColor = [UIColor  lightGrayColor];
    //    opeiLable1.font = [UIFont boldSystemFontOfSize:11];
    //    opeiLable1.backgroundColor = [UIColor clearColor];
    //    [myScrtollView addSubview:opeiLable1];
    //    [opeiLable1 release];
    
    UILabel *opeiLable2 = [[UILabel alloc] initWithFrame:CGRectMake(103, 20, 50, 20)];
    opeiLable2.textAlignment = NSTextAlignmentCenter;
    opeiLable2.text = [oupeiarr objectAtIndex:0];
    opeiLable2.textColor = [UIColor  lightGrayColor];
    opeiLable2.font = [UIFont boldSystemFontOfSize:11];
    opeiLable2.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable2];
    [opeiLable2 release];
    
    UILabel *opeiLable3 = [[UILabel alloc] initWithFrame:CGRectMake(158, 20, 50, 20)];
    opeiLable3.textAlignment = NSTextAlignmentCenter;
    opeiLable3.text = [oupeiarr objectAtIndex:1];
    opeiLable3.textColor = [UIColor  lightGrayColor];
    opeiLable3.font = [UIFont boldSystemFontOfSize:11];
    opeiLable3.backgroundColor = [UIColor clearColor];
    [infoImage addSubview:opeiLable3];
    [opeiLable3 release];
    
    UIImageView * hengla21 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 39, 264, 2)];
    hengla21.backgroundColor = [UIColor clearColor];
    hengla21.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla21];
    [hengla21 release];
   
    int width = 53;
    int hight = 33;
    int tagbut = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+29+(j*26), i*hight+84+(i*11), width, hight);
            if (buffer[tagbut] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
            }else{
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
            }
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.font = [UIFont systemFontOfSize:9];
            labbifen.tag = 9;
//            labbifen.textColor = [UIColor whiteColor];
            NSLog(@"tag = %d", tagbut);
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
//            peilula.textColor = [UIColor whiteColor];
            peilula.tag = 10;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
            }
            
            
            tagbut += 1;
            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];
            [infoImage addSubview:shangbut];
        }
        
    }
    
    NSLog(@"tag = %d", tagbut);
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            
            UIButton * shangbut = [UIButton buttonWithType:UIButtonTypeCustom];
            shangbut.tag = tagbut;
            
            shangbut.frame = CGRectMake(j*width+29+(j*26), i*hight+202+(i*11), width, hight);
            if (buffer[tagbut] == 1) {
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
            }else{
                [shangbut setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
            }
            
            [shangbut addTarget:self action:@selector(pressShangButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * labbifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 16.5)];
            labbifen.backgroundColor = [UIColor clearColor];
            labbifen.textAlignment = NSTextAlignmentCenter;
            labbifen.font = [UIFont systemFontOfSize:9];
//            labbifen.textColor = [UIColor whiteColor];
            labbifen.tag = 9;
            
            NSLog(@"tag = %d", tagbut);
            labbifen.text = [bifenarr objectAtIndex:tagbut];
            
            UILabel * peilula = [[UILabel alloc] initWithFrame:CGRectMake(0, 16.5, width, 16.5)];
            peilula.backgroundColor = [UIColor clearColor];
            peilula.textAlignment = NSTextAlignmentCenter;
            peilula.font = [UIFont systemFontOfSize:9];
//            peilula.textColor = [UIColor whiteColor];
            peilula.tag = 10;
            labbifen.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            peilula.textColor = [UIColor colorWithRed:9/255.0 green:39/255.0 blue:48/255.0 alpha:1];
            if ([pkbetdata.oupeiarr count] > tagbut) {
                peilula.text = [pkbetdata.oupeiarr objectAtIndex:tagbut];
            }
            
            
            tagbut += 1;
            [shangbut addSubview:labbifen];
            [shangbut addSubview:peilula];
            [peilula release];
            [labbifen release];
            [infoImage addSubview:shangbut];
        }
        
    }
    
    
    
    UIImageView *titleChoseImage = [[UIImageView alloc] init];
    titleChoseImage.frame = CGRectMake(7, 52, 70.5, 21.5);
    [infoImage addSubview:titleChoseImage];
    titleChoseImage.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage release];
    UILabel *choseTitle = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage addSubview:choseTitle];
    choseTitle.shadowColor = [UIColor whiteColor];//阴影
    choseTitle.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle.font = [UIFont systemFontOfSize:11];
    choseTitle.textAlignment = NSTextAlignmentCenter;
    choseTitle.backgroundColor = [UIColor clearColor];
    choseTitle.text = @"客胜";
    [choseTitle release];
    UIImageView * hengla = [[UIImageView alloc] initWithFrame:CGRectMake(1, 73.5, 264, 2)];
    hengla.backgroundColor = [UIColor clearColor];
    hengla.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla];
    [hengla release];
    
    
    UIImageView *titleChoseImage2 = [[UIImageView alloc] init];
    titleChoseImage2.frame = CGRectMake(7, 169, 70.5, 21.5);
    [infoImage addSubview:titleChoseImage2];
    titleChoseImage2.image = UIImageGetImageFromName(@"SSSFBG960.png");
    [titleChoseImage2 release];
    UILabel *choseTitle2 = [[UILabel alloc] initWithFrame:titleChoseImage.bounds];
    [titleChoseImage2 addSubview:choseTitle2];
    choseTitle2.shadowColor = [UIColor whiteColor];//阴影
    choseTitle2.shadowOffset = CGSizeMake(0, 1.0);
    choseTitle2.font = [UIFont systemFontOfSize:11];
    choseTitle2.textAlignment = NSTextAlignmentCenter;
    choseTitle2.backgroundColor = [UIColor clearColor];
    choseTitle2.text = @"主胜";
    [choseTitle2 release];
    UIImageView * hengla2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 169+21.5, 264, 2)];
    hengla2.backgroundColor = [UIColor clearColor];
    hengla2.image = UIImageGetImageFromName(@"SZTG960.png");
    [infoImage addSubview:hengla2];
    [hengla2 release];

    CP_PTButton *cancelButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(24, 348, 120, 34)];
    [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
    cancelButton.buttonName.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.buttonName.textColor = [UIColor whiteColor];
    cancelButton.buttonName.shadowColor = [UIColor blackColor];
    cancelButton.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    cancelButton.buttonName.frame = cancelButton.bounds;
    cancelButton.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cancelButton addTarget:self action:@selector(pressquxiaobutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:cancelButton];
    [cancelButton release];
    
    
    CP_PTButton *quedingbut = [[CP_PTButton alloc] initWithFrame:CGRectMake(156, 348, 120, 34)];
    [quedingbut loadButonImage:@"TYD960.png" LabelName:@"确定"];
    quedingbut.buttonName.font = [UIFont boldSystemFontOfSize:17];
    quedingbut.buttonName.textColor = [UIColor whiteColor];
    quedingbut.buttonName.shadowColor = [UIColor blackColor];
    quedingbut.buttonName.shadowOffset = CGSizeMake(0, 1.0);
    
    quedingbut.buttonName.frame = cancelButton.bounds;
    quedingbut.buttonImage.image = [cancelButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [quedingbut addTarget:self action:@selector(pressbifenqueding:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:quedingbut];
    [quedingbut release];
    
    [bgview addSubview:bgimage];
    [bgimage release];
#ifdef isCaiPiaoForIPad
    //    bgimage
    
    bgimage.frame = CGRectMake((768-300)/2,(1024-286)/2,  300, 286);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [bgimage.layer addAnimation:rotationAnimation forKey:@"run"];
    bgimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
#endif
    
    [appDelegate.window addSubview:bgview];
    //  [bgview release];
}


- (void)pressquxiaobutton:(UIButton *)sender{
    
    [bgview removeFromSuperview];
    [bgview release];
}

- (void)pressbifenqueding:(UIButton *)sender{
    NSLog(@"begin");
    NSInteger jici = 0;
    if (matchenumcell == matchEnumHunTouGuoGuanCell) {
        jici = 6;
    }else{
        jici = 31;
    }
    
    NSMutableArray * muarr1 = [[NSMutableArray alloc] initWithCapacity:0];
    for (int  i = 0;  i< jici; i++) {
        [muarr1 addObject:[NSString stringWithFormat:@"%d", buffer[i]]];
    }
    // [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
    
    [muarr1 release];

    
    NSMutableArray * muarr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < jici; i++) {
        [muarr addObject:[NSString stringWithFormat:@"%d", buffer[i]]];
    }
    pkbetdata.bufshuarr = nil;
    pkbetdata.bufshuarr = muarr;
    NSLog(@"bufshuarr = %@", pkbetdata.bufshuarr);
    [self returnbifenCellInfo:count shuzu:muarr dan:dandan];
    [muarr  release];
    
    
    if (matchenumcell == matchEnumBiFenDanGuanCell || matchenumcell == matchEnumZongJinQiuDanGuanCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        
        dan.hidden = YES;
        
    }else if (matchenumcell == matchEnumBiFenGuoguanCell || matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumHunTouGuoGuanCell){
        for (int i = 0; i < [pkbetdata.bufshuarr count]; i++) {
            if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                dan.hidden = NO;
                boldan = YES;
                break;
            }else{
                dan.hidden = YES;
                boldan = NO;
            }
        }

    }
    NSLog(@"bol = %d", boldan);
    NSMutableArray * bifenarr;
    if (matchenumcell == matchEnumBiFenGuoguanCell || matchenumcell == matchEnumBiFenDanGuanCell) {
         bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
    }else if(matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell){
        bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];

    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumZongJinQiuDanGuanCell){
        bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
    
    }else if(matchenumcell == matchEnumShengFenChaDanDuanCell || matchenumcell == matchEnumShengFenChaGuoGuanCell){
        bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
    }else if(matchenumcell == matchEnumHunTouGuoGuanCell){
    
        bifenarr = [NSMutableArray arrayWithObjects:@"胜", @"平", @"负", @"让球胜", @"让球平", @"让球负", nil];
    }else if(matchenumcell == matchEnumLanqiuHunTouCell){
        bifenarr = [NSMutableArray arrayWithObjects:@"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小", @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",nil];
    }
            
    NSString * strbi = @"";
    for (int i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        
            
            if (matchenumcell == matchEnumLanqiuHunTouCell) {
                
                if (i == 18) {
                    break;
                }
                NSInteger bagcount = 0;
//                 bagcount = i;
                if (i > 5 && i < 12) {
                    bagcount = i + 6;
                }else if(i >= 12){
                    bagcount = i  - 6;
                }else{
                    bagcount = i;
                }
                
                if ([[pkbetdata.bufshuarr objectAtIndex:bagcount] isEqualToString:@"1"]) {
                    
                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:bagcount]];
                    
                    
                }
                
            }else{
                if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
               
                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:i]];
                
                    
                }
            }
            
            
            
       
    }
    pkbetdata.cellstring = nil;
    if ([strbi length] > 0) {
        strbi =  [strbi substringToIndex:[strbi length] -1];
         pkbetdata.cellstring = strbi;
        
    }else{
        pkbetdata.cellstring= @"请选择投注选项";
    }
    
   

    
    
    [bgview removeFromSuperview];
    [bgview release];NSLog(@"end");
}

//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

- (void)donghuaxizi{
    if (donghua == 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.52f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:bgimagevv cache:YES];
        [UIView commitAnimations];
        
        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:2];
        
    }
}

- (void)setPkbetdata:(GC_BetData *)_pkbetdata{
    if (pkbetdata != _pkbetdata) {
        [pkbetdata release];
        pkbetdata = [_pkbetdata retain];
    }
    
    eventLabel.text = _pkbetdata.event;
   
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
    
     timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
    teamLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.team ];
    pkbetdata.but1 = @"";
    pkbetdata.but2= @"";
    pkbetdata.but3 = @"";
    butLabel1.text = pkbetdata.but1;
    butLabel2.text = pkbetdata.but2;
    butLabel3.text = pkbetdata.but3;
    if (matchenumcell == matchEnumBiFenGuoguanCell || matchenumcell == matchEnumBiFenDanGuanCell) {
        [bifenbutton removeTarget:self action:@selector(pressLanQiuHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton addTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
    }else if(matchenumcell == matchEnumZongJinQiuCell || matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumZongJinQiuDanGuanCell || matchenumcell == matchEnumBanQuanChangDanGuanCell){
        [bifenbutton removeTarget:self action:@selector(pressLanQiuHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton addTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
    }else if(matchenumcell == matchEnumShengFenChaDanDuanCell || matchenumcell == matchEnumShengFenChaGuoGuanCell){
        [bifenbutton removeTarget:self action:@selector(pressLanQiuHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton addTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
    }else if(matchenumcell == matchEnumHunTouGuoGuanCell){
         [bifenbutton removeTarget:self action:@selector(pressLanQiuHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton addTarget:self action:@selector(pressHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
    }else if(matchenumcell == matchEnumLanqiuHunTouCell){
         [bifenbutton removeTarget:self action:@selector(pressHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressZongJinQiuButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton removeTarget:self action:@selector(pressShengFenChaButton:) forControlEvents:UIControlEventTouchUpInside];
        [bifenbutton addTarget:self action:@selector(pressLanQiuHunTouButton:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    NSLog(@"opestr = %@", _pkbetdata.oupeistr);
    NSLog(@"dan = %d", _pkbetdata.dandan);
    NSLog(@"ddd = %@", _pkbetdata.bufshuarr);
    
    
    changhaola.text = [_pkbetdata.numzhou substringWithRange:NSMakeRange(2, 3)];
   
    
    
    
     bifenlabel.text = pkbetdata.cellstring;
    
      
    NSLog(@"bifenla = %@", bifenlabel.text);
    donghua = _pkbetdata.donghuarow;
    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    if (teamarray.count < 3) {
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
   
    homeduiLabel.text = [teamarray objectAtIndex:0];
    keduiLabel.text = [teamarray objectAtIndex:1];
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
    
    
    if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
        rangqiulabel.text = [teamarray objectAtIndex:2];
        if ([rangqiulabel.text isEqualToString:@"0"]) {
            rangqiulabel.hidden = YES;
//            rangqiulabel.text = @"vs";
            vsImage.hidden = NO;
        }else{
            rangqiulabel.hidden = NO;
            vsImage.hidden = YES;
        }
    }else{
//        rangqiulabel.text = @"vs";
        vsImage.hidden = NO;
    }
    
    
    if (matchenumcell == matchEnumLanqiuHunTouCell) {
        
        
        if ([bifenlabel.text isEqualToString:@"请选择投注选项"]) {
            bifenlabel.hidden = YES;
            cgbgImage.hidden = YES;
             vsImage.hidden = NO;
            homeduiLabel.frame = CGRectMake(0, 18, 90, 14);
            vsImage.frame = CGRectMake(90, 18, 18, 15);
            keduiLabel.frame = CGRectMake(108, 18, 90, 14);
        }else{
            homeduiLabel.frame = CGRectMake(0, 10, 90, 14);
            vsImage.frame = CGRectMake(90, 10, 18, 15);
            keduiLabel.frame = CGRectMake(108, 10, 90, 14);
            cgbgImage.hidden = NO;
            bifenlabel.hidden = NO;
             vsImage.hidden = YES;
            CGSize labelWith = [bifenlabel.text sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(bifenlabel.frame.size.width, bifenlabel.frame.size.height)];
            //178
            if (labelWith.width > bifenlabel.frame.size.width) {
                labelWith.width = bifenlabel.frame.size.width;
            }
            cgbgImage.frame = CGRectMake((198 - labelWith.width)/2-3 , bifenlabel.frame.origin.y+2, labelWith.width + 6, bifenlabel.frame.size.height-4);
            cgbgImage.image = [UIImageGetImageFromName(@"caiguobeijingimage.png") stretchableImageWithLeftCapWidth:25 topCapHeight:7];
            
        }
        if (self.butonScrollView.hidden == NO) {
//            XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght_1.png");
            xibutton.hidden = YES;
        }else{
//            XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght.png");
            xibutton.hidden = NO;
        }
    }else{
    
        if ([bifenlabel.text isEqualToString:@"请选择投注选项"]) {
            bifenlabel.hidden = YES;
            [bifenbutton setImage:UIImageGetImageFromName(@"zucaidaanniu.png") forState:UIControlStateNormal];
            
            homeduiLabel.frame = CGRectMake(10, 19, 90, 14);
            keduiLabel.frame = CGRectMake(144, 19, 91, 14);
            rangqiulabel.frame = CGRectMake(93, 19, 64, 14);
            bifenlabel.frame = CGRectMake(0, 28, 251, 24);
            //         vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(116.5, 19, 18, 15)];
            vsImage.frame = CGRectMake(116.5, 19, 18, 15);
            bifenlabel.textColor = [UIColor grayColor];
            
            jiantou.image = UIImageGetImageFromName(@"JTD960.png");
            if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
                rangqiulabel.text = [teamarray objectAtIndex:2];
                if ([rangqiulabel.text isEqualToString:@"0"]) {
                    rangqiulabel.hidden = YES;
                    vsImage.hidden = NO;
                }else{
                    rangqiulabel.hidden = NO;
                    vsImage.hidden = YES;
                }
            }else{
                vsImage.hidden = NO;
            }
        }else{
            [bifenbutton setImage:UIImageGetImageFromName(@"zucaidaanniu_1.png") forState:UIControlStateNormal];
            jiantou.image = UIImageGetImageFromName(@"JTD960bai.png");
            
            bifenlabel.hidden = NO;
            
            bifenlabel.textColor = [UIColor whiteColor];
            vsImage.frame = CGRectMake(116.5, 12, 18, 15);
            
            homeduiLabel.frame = CGRectMake(10, 12, 90, 14);
            keduiLabel.frame = CGRectMake(144, 12, 91, 14);
            rangqiulabel.frame = CGRectMake(93, 12, 64, 14);
            bifenlabel.frame = CGRectMake(0, 23, 251, 24);
            if (matchenumcell == matchEnumBanQuanChangCell || matchenumcell == matchEnumBanQuanChangDanGuanCell) {
                rangqiulabel.text = [teamarray objectAtIndex:2];
                if ([rangqiulabel.text isEqualToString:@"0"]) {
                    rangqiulabel.hidden = YES;
                    vsImage.hidden = YES;
                }else{
                    rangqiulabel.hidden = NO;
                    vsImage.hidden = YES;
                }
            }else{
                vsImage.hidden = YES;
            }
        }
    }
    
   

   // rangqiulabel.text = [teamarray objectAtIndex:2];
    
    selection1 = _pkbetdata.selection1;
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    
    if (matchenumcell == matchEnumLanqiuHunTouCell) {
        if (_pkbetdata.dandan) {
            headimage.image = UIImageGetImageFromName(@"lanqiuhuntouhead_1.png");
            changhaola.textColor  = [UIColor whiteColor];
             UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");

        }else{
            changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            headimage.image = UIImageGetImageFromName(@"lanqiuhuntouhead.png");
            UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        }
    }else{
        if (_pkbetdata.dandan) {
            UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
            
            headimage.image = UIImageGetImageFromName(@"zucaihead_1.png");
            changhaola.textColor  = [UIColor whiteColor];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
            
            
        }else{
            headimage.image = UIImageGetImageFromName(@"zucaihead.png");
            changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        }
    }
    
    
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(donghuaxizi) object:nil];
    if (donghua == 0) {
        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:2];
    }
    
    
    dan.hidden = YES;
    if (matchenumcell == matchEnumBiFenDanGuanCell || matchenumcell == matchEnumZongJinQiuDanGuanCell || matchenumcell == matchEnumBanQuanChangDanGuanCell || matchenumcell == matchEnumShengFenChaDanDuanCell) {
        dan.hidden = YES;
    }else{
    for (int i = 0; i < [pkbetdata.bufshuarr count]; i++) {
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            dan.hidden = NO;
            if (panduan) { //判断胆是否被选
                dan.tag = 1;
                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_06.png");
                danzi.textColor = [UIColor whiteColor];
                break;
            }else{
                dan.tag = 0;
                danzi.textColor = [UIColor blackColor];
                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
            }
            
        }
    }
    }

    if (chaobool) {
        dan.hidden = YES;
    }
    
    if (self.butonScrollView.hidden == NO) {

        [xidanButton setImage:UIImageGetImageFromName(@"xidanimagebg_1.png") forState:UIControlStateNormal];
        
    }else{
       
        [xidanButton setImage:UIImageGetImageFromName(@"xidanimagebg.png") forState:UIControlStateNormal];
    }
    
    if (wangqibool) {
        zhegaiview.hidden = NO;
        NSLog(@"scores = %@",_pkbetdata.bifen);
        bifenlabel.hidden = NO;
        bifenlabel.textColor = [UIColor redColor];
        [bifenbutton setImage:UIImageGetImageFromName(@"wqda.png") forState:UIControlStateNormal];
        if (matchenumcell == matchEnumShengFenChaDanDuanCell || matchenumcell == matchEnumShengFenChaGuoGuanCell || matchenumcell == matchEnumLanqiuHunTouCell || matchenumcell == matchEnumLanqiuHunTouCell) {
            if (_pkbetdata.bifen) {
                timeLabel.text = _pkbetdata.bifen;
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
                bifenlabel.text = _pkbetdata.caiguo;
            }else{
                timeLabel.text = @"-";
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
                bifenlabel.text = @"";
            }
        }else{
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]) {
                NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
                //            _pkbetdata.caiguo
                if (scores.count < 4) {
                    scores = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
                }
                timeLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
                bifenlabel.text = _pkbetdata.caiguo;
            }else{
                timeLabel.text = @"-";
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
                bifenlabel.text = @"";
            }
        }
        
        
    }else{
        if ([bifenlabel.text isEqualToString:@"请选择投注选项"]){
            bifenlabel.hidden = YES;
        }else{
            bifenlabel.hidden = NO;
        }
        zhegaiview.hidden = YES;
        
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        timeLabel.font = [UIFont systemFontOfSize:8];
    }
    
    
    if (wangqibool) {
        jiantou.hidden = YES;
    }else{
        jiantou.hidden = NO;
    }
       
    
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellmatchenum:(MatchEnumCell)fenzhongcell{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self.contentView addSubview:[self tableViewCell]];
//        //self.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        
//        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        panduan = NO;
//    }
//    return self;
//}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol matchenumType:(MatchEnumCell)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        chaobool = chaobol;
      
        matchenumcell = type;
        
        [self.contentView addSubview:[self tableViewCell]];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        panduan = NO;
    }
    return self;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        chaobool = chaobol;
        
        
        
        [self.contentView addSubview:[self tableViewCell]];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        panduan = NO;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        
        [self.contentView addSubview:[self tableViewCell]];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        panduan = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    if (selected) {
//        if ([delegate respondsToSelector:@selector(openCellbifen:)]) {
//            [delegate openCellbifen:self];
//        }
//    }
    
    // Configure the view for the selected state
}

- (UIView *)tableViewCell{
    self.backImageView.image = nil;
    self.butonScrollView.backgroundColor = [UIColor clearColor];
    //返回给cell的view
    view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 66)] autorelease];
    
#ifdef isCaiPiaoForIPad
    view.frame = CGRectMake(0, 0, 390, 66);
#endif
    
    headimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 49, 50)];
    headimage.backgroundColor = [UIColor clearColor];
    headimage.image = UIImageGetImageFromName(@"zucaihead.png");
    headimage.userInteractionEnabled = YES;
    UIButton * headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = headimage.bounds;
    [headButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [headimage addSubview:headButton];
    [view addSubview:headimage];
    [headimage release];
    
    changhaola = [[UILabel alloc] initWithFrame:CGRectMake(7, 2, 38, 17)];
    changhaola.backgroundColor = [UIColor clearColor];
    changhaola.textAlignment = NSTextAlignmentCenter;
    changhaola.font = [UIFont systemFontOfSize:9];
   changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headimage addSubview:changhaola];
    [changhaola release];
    
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 49, 13)];
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor blackColor];
    [headimage addSubview:eventLabel];

    
   
    //时间****
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 35-30, 49, 10)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:8];
    timeLabel.backgroundColor = [UIColor clearColor];
     timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headimage addSubview:timeLabel];

       
    //哪个队对哪个队
    teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 5, 245, 20)];
    teamLabel.textAlignment = NSTextAlignmentCenter;
    teamLabel.font = [UIFont systemFontOfSize:14];
    teamLabel.backgroundColor = [UIColor clearColor];
    
    bifenbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    bifenbutton.frame = CGRectMake(59, 0, 251, 50);
    [bifenbutton setImage:UIImageGetImageFromName(@"zucaidaanniu.png") forState:UIControlStateNormal];
    [bifenbutton addTarget:self action:@selector(pressBiFenButton:) forControlEvents:UIControlEventTouchUpInside];

    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 19, 90, 14)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    [bifenbutton addSubview:homeduiLabel];
    [homeduiLabel release];
    
    //让球
    rangqiulabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 19, 64, 14)];
    rangqiulabel.textAlignment = NSTextAlignmentCenter;
    rangqiulabel.font = [UIFont boldSystemFontOfSize:14];
    rangqiulabel.backgroundColor = [UIColor clearColor];
    rangqiulabel.textColor = [UIColor blackColor];
    [bifenbutton addSubview:rangqiulabel];
    [rangqiulabel release];
    
    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(116.5, 19, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    vsImage.hidden = YES;
    [bifenbutton addSubview:vsImage];
    [vsImage release];
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 19, 91, 14)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    [bifenbutton addSubview:keduiLabel];
    [keduiLabel release];
    
       
    
    
    dan = [UIButton buttonWithType:UIButtonTypeCustom];
    dan.hidden = YES;
    dan.frame = CGRectMake(270, 16, 40, 30);
    [dan addTarget:self action:@selector(pressdandown:) forControlEvents:UIControlEventTouchDown];
    [dan addTarget:self action:@selector(pressDan:) forControlEvents:UIControlEventTouchUpInside];
    danimge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
    [dan addSubview:danimge];
    
    
    danzi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    danzi.text = @"胆";
    danzi.font = [UIFont systemFontOfSize:12];
    danzi.textColor = [UIColor blackColor];
    danzi.textAlignment = NSTextAlignmentCenter;
    danzi.backgroundColor = [UIColor clearColor];
    [dan addSubview:danzi];
    
    
    
   
   
    
    
    if (chaodanbool) {
        [self performSelector:@selector(pressBiFenButton:) withObject:nil afterDelay:0];
        
    }
    
    cgbgImage = [[UIImageView alloc] init];
    cgbgImage.backgroundColor = [UIColor clearColor];
//    cgbgImage.image = UIImageGetImageFromName(@"");
    cgbgImage.hidden = YES;
    [bifenbutton addSubview:cgbgImage];
    [cgbgImage release];
    
    bifenlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 251, 24)];
    bifenlabel.backgroundColor = [UIColor clearColor];
    bifenlabel.font = [UIFont boldSystemFontOfSize:13];
    bifenlabel.textColor = [UIColor grayColor];
    bifenlabel.textAlignment = NSTextAlignmentCenter;
    bifenlabel.text = @"请选择投注选项";
    [bifenbutton addSubview:bifenlabel];
    
    
    xibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xibutton.frame = CGRectMake(245, 0, 60, 24);
    [xibutton addTarget:self action:@selector(pressxibutton:) forControlEvents:UIControlEventTouchUpInside];
    
    // [xibutton setImage:UIImageGetImageFromName(@"gc_xl_12.png") forState:UIControlStateNormal];
    
    
    bgimagevv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 18, 17)];
    
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
    [xibutton addSubview:bgimagevv];
    [xibutton addTarget:self action:@selector(touchxibutton:) forControlEvents:UIControlEventTouchDown];
    [xibutton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
    [xibutton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    //  [xibutton setTitle:@"析" forState:UIControlStateNormal];
    xizi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    xizi.text = @"析";
    xizi.font = [UIFont systemFontOfSize:12];
    xizi.textColor = [UIColor whiteColor];
    xizi.textAlignment = NSTextAlignmentCenter;
    xizi.backgroundColor = [UIColor clearColor];
    // [xibutton addSubview:xizi];
    
    
    [button1 addSubview:datal1];
    [button2 addSubview:datal2];
    [button3 addSubview:datal3];
    
       
  
  
   
   
    
    
    

    [view addSubview:xibutton];
  
    [view addSubview:dan];
    
    [view addSubview:bifenbutton];
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(59, 0, 251, 50);
//    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 309-59, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
//    [zhegaiview release];
    
    
    jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(288, 18, 8, 13)];

    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"JTD960.png");
    [view addSubview:jiantou];
    [jiantou release];
    
    
#ifdef isCaiPiaoForIPad
    jiantou.frame = CGRectMake(288+35, 18, 8, 13);
    headimage.frame = CGRectMake(10+35, 0, 49, 50); 
    zhegaiview.frame = CGRectMake(59+35, 0, 251, 40);
    bifenbutton.frame = CGRectMake(59+35, 0, 251, 50);
    xibutton.frame = CGRectMake(251+59+15, 0, 60, 24);

    //    zhegaiview.frame = CGRectMake(59+35, 0, 251, 50);
    bgimagevv.frame = CGRectMake(20, 0, 30, 31);
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");

#endif
    
  
        if (matchenumcell == matchEnumLanqiuHunTouCell) {
            
            headimage.image = UIImageGetImageFromName(@"headimagematch.png");//lanqiuhuntouhead
            headimage.frame = CGRectMake(10, 0, 50, 51);
            bifenbutton.frame = CGRectMake(60, 0, 198, 51);
            [bifenbutton setImage:UIImageGetImageFromName(@"lqhuntouimage.png") forState:UIControlStateNormal];
            
            xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            xidanButton.frame = CGRectMake(60+198, 0, 52, 51);
            [xidanButton setImage:UIImageGetImageFromName(@"xidanimagebg") forState:UIControlStateNormal];
            [xidanButton addTarget:self action:@selector(pressXiDanButton:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:xidanButton];
            
            homeduiLabel.frame = CGRectMake(0, 10, 90, 14);
            vsImage.frame = CGRectMake(90, 10, 18, 15);
            keduiLabel.frame = CGRectMake(108, 10, 90, 14);
            bifenlabel.frame = CGRectMake(10, 28, 178, 24);
            bifenlabel.textColor = [UIColor whiteColor];
            
           [view insertSubview:xibutton atIndex:10000];
            xibutton.frame = CGRectMake(320-30, 0, 30, 24);
            bgimagevv.frame = CGRectMake(0, 0, 18, 17);
            
        }
    
    
    
    
    return view;
}

- (void)pressXiDanButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(openCellbifen:)]) {
        [delegate openCellbifen:self];
    }
    [xidanButton setImage:UIImageGetImageFromName(@"xidanimagebg_1.png") forState:UIControlStateNormal];
}

- (void)pressHeadButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(openCellbifen:)]) {
        [delegate openCellbifen:self];
    }
}
- (void)TouchCancel{
#ifdef isCaiPiaoForIPad
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
#else
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
#endif
    
}

- (void)TouchDragExit{
#ifdef isCaiPiaoForIPad
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
#else
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
#endif
}

- (void)pressdandown:(UIButton *)sender{
    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_03.png");
}

- (void)buttonTouchDown:(UIButton *)sender{
    if (sender.tag == 3) {
        //  buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2.png");
        [button1 setImage:UIImageGetImageFromName(@"gc_betbtn2.png") forState:UIControlStateNormal];
    }
    if (sender.tag == 1) {
        //  buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2.png");
        [button2 setImage:UIImageGetImageFromName(@"gc_betbtn2.png") forState:UIControlStateNormal];
    }
    if (sender.tag == 0) {
        //  buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2.png");
        [button3 setImage:UIImageGetImageFromName(@"gc_betbtn2.png") forState:UIControlStateNormal];
    }
}


- (void)pressDan:(UIButton *)sender{
    NSLog(@"dan");
    NSLog(@"nengyong = %d", nengyong);
    dbool = NO;
    
    if (sender.tag == 0) {
        //        if (dandan) {
        //            return;
        //        }
        if (nengyong) {
            sender.tag = 1;
            danimge.image = UIImageGetImageFromName(@"gc_dan_xl_06.png");
            danzi.textColor = [UIColor whiteColor];
            dbool = YES;
            cout++;
        }
        
    }else{
        danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
        danzi.textColor = [UIColor blackColor];
        dbool = NO;
        sender.tag = 0;
        cout--;
    }
    [self returnBoolDanbifen:dbool row:row];
}

- (void)touchxibutton:(UIButton *)sender{

#ifdef isCaiPiaoForIPad
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage_1.png");
#else
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12.png");
#endif
    xizi.textColor = [UIColor blackColor];
}
- (void)pressxibutton:(UIButton *)sender{
    NSLog(@"xi");
    [self returncellrownumbifen:row];
    xizi.textColor = [UIColor whiteColor];
    //  bgimagevv.image = UIImageGetImageFromName(@"gc_dot4.png");
#ifdef isCaiPiaoForIPad
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
#else
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
#endif
}

//第一个按钮的触发函数
- (void)pressButton1:(UIButton *)button{
    NSLog(@"button 333333333");
    // NSLog(@"count  =  %d", count);
    if (!selection1) {
        //   buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        [button1 setImage:UIImageGetImageFromName(@"gc_betbtn2_0.png") forState:UIControlStateNormal];
        butLabel1.textColor = [UIColor whiteColor];
        datal1.textColor = [UIColor whiteColor];
        selection1 = YES;
        // boldan1 = YES;
    }else{
        //    buttonImage.image = UIImageGetImageFromName(@"gc_xxx.png");
        [button1 setImage:UIImageGetImageFromName(@"gc_xxx.png") forState:UIControlStateNormal];
        //  [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        datal1.textColor = [UIColor blackColor];
        butLabel1.textColor = [UIColor blackColor];
        selection1 = NO;
        //  boldan1 = NO;
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
    }
//    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
    
}

//第二个按钮的触发函数
- (void)pressButtonTwo:(UIButton *)button{
    NSLog(@"button 1111111111");
    if (!selection2) {
        //   buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        [button2 setImage:UIImageGetImageFromName(@"gc_betbtn2_0.png") forState:UIControlStateNormal];
        butLabel2.textColor = [UIColor whiteColor];
        datal2.textColor = [UIColor whiteColor];
        selection2 = YES;
        //        boldan2 = YES;
    }else{
        //     buttonImage2.image = UIImageGetImageFromName(@"gc_xxx.png");
        [button2 setImage:UIImageGetImageFromName(@"gc_xxx.png") forState:UIControlStateNormal];
        datal2.textColor = [UIColor blackColor];
        butLabel2.textColor = [UIColor blackColor];
        selection2 = NO;
        //        boldan2 = NO;
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
    }
 //   [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
    
}

//第三个按钮的触发函数
- (void)pressButtonthree:(UIButton *)button{
    NSLog(@"button 00000000000");
    if (!selection3) {
        // buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        [button3 setImage:UIImageGetImageFromName(@"gc_betbtn2_0.png") forState:UIControlStateNormal];
        butLabel3.textColor = [UIColor whiteColor];
        datal3.textColor = [UIColor whiteColor];
        selection3 = YES;
        //        boldan3 = YES;
    }else{
        //  buttonImage3.image = UIImageGetImageFromName(@"gc_xxx.png");
        [button3 setImage:UIImageGetImageFromName(@"gc_xxx.png") forState:UIControlStateNormal];
        datal3.textColor = [UIColor blackColor];
        butLabel3.textColor = [UIColor blackColor];
        selection3 = NO;
        //        boldan3 = NO;
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
    }
 //   [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
    
}

- (void)returncellrownumbifen:(NSIndexPath *)num{
    if ([delegate respondsToSelector:@selector(returncellrownumbifen:)]) {
        [delegate returncellrownumbifen:num];
    }
    //    NSLog(@"num = %d", num);
}
//
- (void)returnBoolDanbifen:(BOOL)danbool row:(NSIndexPath *)num{
//    if ([delegate respondsToSelector:@selector(returnBoolDanbifen:row:)]) {
//        [delegate returnBoolDanbifen:danbool row:num];
//    }
}
//
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        NSMutableArray * bufshu = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSInteger cishu = 0;
        if (matchenumcell == matchEnumHunTouGuoGuanCell) {
            cishu = 6;
        }else {
            cishu = 31;
        }
        for (int i = 0; i < cishu; i++) {
            [bufshu addObject:[NSString stringWithFormat:@"%d", buffer[i]]];
        }

       [delegate returnbifenCellInfo:index shuzu:bufshu dan:boldan ];
        [bufshu release];

    }

    
}

- (void)dealloc{
    [bifenlabel release];
    [danzi release];
    [danimge release];
    [matcinfo release];


    [buttonImage release];
    [buttonImage2 release];
    [buttonImage3 release];
    
    [datal1 release];
    [datal2 release];
    [datal3 release];
//    [view release];
    [eventLabel release];

    [timeLabel release];
    [teamLabel release];
    [butLabel1 release];
    [butLabel2 release];
    [butLabel3 release];
    [pkbetdata release];
    [bgimagevv release];
    [xizi release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
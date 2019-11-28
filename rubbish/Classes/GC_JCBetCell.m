//
//  PKBetCell.m
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_JCBetCell.h"
#import "NewAroundViewController.h"


@implementation GC_JCBetCell
@synthesize eventLabel;

@synthesize timeLabel;

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
@synthesize keduiLabel, butTitle, XIDANImageView;
@synthesize rangqiulabel, lanqiucell, buttonBool, duckImageOne, duckImageTwo, duckImageThree;
@synthesize panduan, donghua, danguanbool, typeCell, wangqiTwoBool, hhChaBool, typeButtonArray;
- (void)headShowFunc{
    
    if (panduan) {
        changhaoImage.hidden = YES;
        seletChanghaoImage.hidden =  NO;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

//        changhaola.textColor  = [UIColor whiteColor];
    }else{
        seletChanghaoImage.hidden = YES;
        changhaoImage.hidden = NO;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
}
//数据的get
- (void)duckViewAnimations{
    
    if (duckImageOne.hidden == NO) {
        duckImageOne.frame = CGRectMake(0, 51, 83.5, 30);
    }
    if (duckImageTwo.hidden == NO) {
        duckImageTwo.frame = CGRectMake(0, 51, 83.5, 30);
    }
    if (duckImageThree.hidden == NO) {
        duckImageThree.frame = CGRectMake(0, 51, 83.5, 30);
    }
    
    [UIView beginAnimations:@"xxx" context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
//    jccell.duckImageOne.frame = CGRectMake(0, 0, 82, 51);
    
    NSArray * zhongArr = [pkbetdata.zhongzu componentsSeparatedByString:@"-"];
    NSString * caiguo = nil;
    if ([zhongArr count] >= 1) {
        caiguo = [zhongArr objectAtIndex:0];
    }
    NSInteger hight = 0;
    if (caiguo) {
        
        if ([caiguo intValue] == 5) {
            hight = 71-8;
        }else if ([caiguo intValue] == 4) {
            hight = 61-8;
        }else if ([caiguo intValue] <= 3) {
            hight = 51-8;
        }
    
    }
    if (duckImageOne.hidden == NO) {
        duckImageOne.frame = CGRectMake(0, 51 - hight, 83.5, hight);
    }
    if (duckImageTwo.hidden == NO) {
        duckImageTwo.frame = CGRectMake(0, 51 - hight, 83.5, hight);
    }
    if (duckImageThree.hidden == NO) {
        duckImageThree.frame = CGRectMake(0, 51 - hight, 83.5, hight);
    }
    
    [UIView commitAnimations];
    
//    if (duckImageOne.hidden == NO || duckImageTwo.hidden == NO || duckImageThree == NO) {
//      [self performSelector:@selector(duckViewAnimations:) withObject:nil afterDelay:1.5];
//    }
   
    if (delegate&&[delegate respondsToSelector:@selector(duckImageCell:)]) {
        [delegate duckImageCell:self];
    }

    
    
}

- (void)btnClicle:(UIButton *)sender{
    [super btnClicle:sender];
    
    if ([[self.allTitleArray objectAtIndex:sender.tag] isEqualToString:@"专家推荐"]) {
        
        NSArray * zhongArr = [pkbetdata.zhongzu componentsSeparatedByString:@"-"];
        NSString * caiguo = nil;
        if ([zhongArr count] >= 2) {
            caiguo = [zhongArr objectAtIndex:1];
        }
        
        if (caiguo) {
            
            for (int i = 0; i < [caiguo length]; i++) {
                  NSString * cg = nil;//截取推荐的彩果
                if (i <= [caiguo length]) {
                    cg = [caiguo substringWithRange:NSMakeRange(i, 1)];//截取推荐的彩果
                }
                if (cg) {
                    if ([cg isEqualToString:@"3"]) {
                        duckImageOne.hidden = NO;
                    }else if ([cg isEqualToString:@"1"]){
                        duckImageTwo.hidden = NO;
                        
                    }else if ([cg isEqualToString:@"0"]){
                        duckImageThree.hidden = NO;
                        
                    }
                }
               
            }
            
            duckImageOne.frame = CGRectMake(0, 21, 83.5, 30);
            duckImageTwo.frame = CGRectMake(0, 21, 83.5, 30);
            duckImageThree.frame = CGRectMake(0, 21, 83.5, 30);
            [self duckViewAnimations];
            
        }
        
      
//        duckImageOne.hidden = NO;
//        duckImageTwo.hidden = NO;
//        duckImageThree.hidden = NO;
        
        
    }

}

//- (void)panDuanZuLanCai{
//    
//    
//#ifdef isCaiPiaoForIPad
//    
//    headimage.frame =   CGRectMake(45, 0, 49, 50);
//    if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
//    
//        button1.frame = CGRectMake(59+35, 0, 125, 50);
//        button2.frame = CGRectMake(184+35, 0, 126, 50);
//        button3.hidden = YES;
//        datal1.text = @"主负";
//        datal2.text = @"主胜";
//        datal1.frame = CGRectMake(0, 0, 50, 23);
//        datal2.frame = CGRectMake(0, 0, 50, 23);
//        butLabel1.frame = CGRectMake(0, 31, 125, 16);
//        butLabel2.frame = CGRectMake(0, 31, 126, 16);
//        homeduiLabel.frame = CGRectMake(0, 11, 125, 14);
//        keduiLabel.frame = CGRectMake(0, 11, 126, 14);
//        winImage1.frame = CGRectMake(5, 5, 15, 15);
//        winImage2.frame = CGRectMake(5, 5, 15, 15);
//    }else if(lanqiucell == matchEnumDaXiaoFenCell){
//        
//        
//        button1.frame = CGRectMake(58+35, 0, 125, 50);
//        button2.frame = CGRectMake(184+35, 0, 126, 50);
//        button3.hidden = YES;
//        datal1.text = @"大";
//        datal2.text = @"小";
//        datal1.frame = CGRectMake(0, 0, 50, 23);
//        datal2.frame = CGRectMake(0, 0, 50, 23);
//        butLabel1.frame = CGRectMake(0, 31, 125, 16);
//        butLabel2.frame = CGRectMake(0, 31, 126, 16);
//        homeduiLabel.frame = CGRectMake(0, 11, 125, 14);
//        keduiLabel.frame = CGRectMake(0, 11, 126, 14);
//        winImage1.frame = CGRectMake(5, 5, 15, 15);
//        winImage2.frame = CGRectMake(5, 5, 15, 15);
//        
//    }else{
//        
//        button1.frame = CGRectMake(59+35, 0, 90, 50);
//        button2.frame = CGRectMake(149+35, 0, 69, 50);
//        button3.hidden = NO;
//        button3.frame = CGRectMake(218+35, 0, 91, 50);
//        datal1.text = @"3";
//        datal2.text = @"1";
//        datal1.frame = CGRectMake(0, 0, 30, 23);
//        datal2.frame = CGRectMake(0, 0, 30, 23);
//        butLabel1.frame = CGRectMake(0, 33, 90, 14);
//        butLabel2.frame = CGRectMake(0, 33, 69, 14);
//        homeduiLabel.frame = CGRectMake(0, 11, 90, 14);
//        keduiLabel.frame = CGRectMake(0, 11, 91, 14);
//        
//    }
//
//#else
//    if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
//        
//        
//        
//        button1.frame = CGRectMake(59, 0, 125, 50);
//        button2.frame = CGRectMake(184, 0, 126, 50);
//        button3.hidden = YES;
//        datal1.text = @"主负";
//        datal2.text = @"主胜";
//        datal1.frame = CGRectMake(0, 0, 50, 23);
//        datal2.frame = CGRectMake(0, 0, 50, 23);
//        butLabel1.frame = CGRectMake(0, 31, 125, 16);
//        butLabel2.frame = CGRectMake(0, 31, 126, 16);
//        homeduiLabel.frame = CGRectMake(0, 11, 125, 14);
//        keduiLabel.frame = CGRectMake(0, 11, 126, 14);
//        winImage1.frame = CGRectMake(5, 5, 15, 15);
//        winImage2.frame = CGRectMake(5, 5, 15, 15);
//        if (lanqiucell == matchEnumRangFenShengFucell) {
//            keduiLabel.frame = CGRectMake(0, 11, 106, 14);
//             butLabel2.frame = CGRectMake(0, 31, 106, 16);
//        }
//    }else if(lanqiucell == matchEnumDaXiaoFenCell){
//        
//        
//        button1.frame = CGRectMake(58, 0, 125, 50);
//        button2.frame = CGRectMake(183, 0, 126, 50);
//        button3.hidden = YES;
//        datal1.text = @"大";
//        datal2.text = @"小";
//        datal1.frame = CGRectMake(0, 0, 50, 23);
//        datal2.frame = CGRectMake(0, 0, 50, 23);
//        butLabel1.frame = CGRectMake(0, 31, 125, 16);
//        butLabel2.frame = CGRectMake(0, 31, 126, 16);
//        homeduiLabel.frame = CGRectMake(0, 11, 125, 14);
//        keduiLabel.frame = CGRectMake(0, 11, 126, 14);
//        winImage1.frame = CGRectMake(5, 5, 15, 15);
//        winImage2.frame = CGRectMake(5, 5, 15, 15);
//        
//    }else{
//        
//        
//        if ([typeCell isEqualToString:@"1"]) { // 胜平负新界面
//            
//            view.frame = CGRectMake(0, 20, 300, 109-43);
//            changhaoImage.frame = CGRectMake(6, 5, 25, 12);
//            zhegaiview.frame=  CGRectMake(0, 0, 300, 50);
//            changhaola.frame = changhaoImage.bounds;
//            eventLabel.frame = CGRectMake(35, 5, 49, 13);
//            eventLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
//            eventLabel.textAlignment = NSTextAlignmentLeft;
//            homeduiLabel.frame  = CGRectMake(65, 16, 83, 14);
//            vsImage.frame = CGRectMake(164, 16, 18, 15);
//            keduiLabel.frame = CGRectMake(195,16, 73, 14);
//            button1.frame = CGRectMake(0, 0, 82, 51);
//            button2.frame = CGRectMake(82, 0, 82, 51);
//            button3.frame = CGRectMake(164, 0, 82, 51);
//
//            ////世界杯 界面
//            if (pkbetdata.worldCupBool) {
//                self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 53, self.butonScrollView.frame.size.width, 71);
//                headimage.image = UIImageGetImageFromName(@"spfheadwcimage.png");
//                headimage.frame = CGRectMake(10, 0, 300, 73);
//                yearImageView.frame = CGRectMake(14, 46, 33, 17);
//                homeBannerImageView.frame = CGRectMake(90 - 12, 73 - 26 - 10, 47, 26);//35 20  12 6
//                worldCupLogo.hidden = NO;
//                guestBannerImageView.frame = CGRectMake(220,  73 - 26 - 10, 47, 26);
//                
//                
//                homeBannerImageView.image = UIImageGetImageFromName(pkbetdata.homeBannerImage);
//                guestBannerImageView.image = UIImageGetImageFromName(pkbetdata.guestBannerImage);
//            }else{
//                 self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23, self.butonScrollView.frame.size.width, 71);
//                headimage.frame = CGRectMake(10, 0, 300, 43);
//                headimage.image = UIImageGetImageFromName(@"hunheduiming.png");
//                worldCupLogo.hidden = YES;
//                yearImageView.frame = CGRectMake(0, 0, 0, 0);
//                homeBannerImageView.frame = CGRectMake(0, 0, 0, 0);
//               
//                guestBannerImageView.frame = CGRectMake(0, 0, 0, 0);
//                homeBannerImageView.image = nil;
//                guestBannerImageView.image = nil;
//
//            }
//            
//            
//            
//        }else{
//        
//            button1.frame = CGRectMake(59, 0, 90, 50);
//            button2.frame = CGRectMake(149, 0, 69, 50);
//            button3.hidden = NO;
//            datal1.text = @"3";
//            datal2.text = @"1";
//            datal1.frame = CGRectMake(0, 0, 30, 23);
//            datal2.frame = CGRectMake(0, 0, 30, 23);
//            butLabel1.frame = CGRectMake(0, 33, 90, 14);
//            butLabel2.frame = CGRectMake(0, 33, 69, 14);
//            homeduiLabel.frame = CGRectMake(0, 11, 90, 14);
//            keduiLabel.frame = CGRectMake(0, 11, 91, 14);
//        
//        }
//        
//       
//        
//    }
//
//#endif
//       
//
//}

- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

//- (void)donghuaxizi{
// if (donghua == 0) {
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.52f];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:bgimagevv cache:YES];
//    [UIView commitAnimations];
//   
//        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:2];
//
//    }
//}
- (void)playVsTypeFunc{
    
    if ([pkbetdata.macthType isEqualToString:@"overtime"]) {
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(156, 18, 34, 12);
        vsImage.image = UIImageGetImageFromName(@"spfyijiezhi.png");
        vsImage.hidden = NO;
        
        NSArray * timedata = [pkbetdata.macthTime componentsSeparatedByString:@" "];
        if ([timedata count] >= 2) {
            timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
            //            timeLabel.font = [UIFont systemFontOfSize:11];
            //            timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        }else{
            timeLabel.text = @"-";
        }
        
        
    }else  if ([pkbetdata.macthType isEqualToString:@"onLive"]) {
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(153, 18, 41, 12);
        vsImage.image = UIImageGetImageFromName(@"spfzhibozhong.png");
        vsImage.hidden = NO;
        NSArray * timedata = [pkbetdata.macthTime componentsSeparatedByString:@" "];
        if ([timedata count] >= 2) {
            timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
        }else{
            timeLabel.text = @"-";
        }
        
    }else  if ([pkbetdata.macthType isEqualToString:@"gameover"]) {
        bifenLabel.hidden = NO;
        timeLabel.text = @"完";
        //        timeLabel.font = [UIFont systemFontOfSize:11];
        //        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        
        
        
    }else if ([pkbetdata.macthType isEqualToString:@"delay"]){
        
        bifenLabel.hidden = YES;
        vsImage.frame = CGRectMake(161, 18, 23, 12);
        vsImage.image = UIImageGetImageFromName(@"yanqiimagespf.png");
        vsImage.hidden = NO;
        timeLabel.text = @"延期";
        
        
    }else if([pkbetdata.macthType isEqualToString:@"playvs"]){
        //        timeLabel.text = @"-";
        //        timeLabel.font = [UIFont systemFontOfSize:11];
        //        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        vsImage.frame = CGRectMake(164, 16, 18, 15);
        vsImage.image = UIImageGetImageFromName(@"vsimage.png");
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", pkbetdata.time ];
        bifenLabel.hidden = YES;
        
    }
}
- (void)setPkbetdata:(GC_BetData *)_pkbetdata{
    if (pkbetdata != _pkbetdata) {
        [pkbetdata release];
        pkbetdata = [_pkbetdata retain];
    }
    
    if (self.butonScrollView.contentOffset.x != 0||wangqibool) {
        
        if (buttonBool) {
            
            [UIView beginAnimations:@"nddd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
             NSLog(@"!@5555555555555555555");
            self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            buttonBool = NO;
        }else{
         NSLog(@"!@6666666666666666666");
             self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
        }
        
    }
     NSLog(@"!@7777777777777777777");
    self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
    XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
    
    eventLabel.text = _pkbetdata.event;
    
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
    

    


    
    donghua = _pkbetdata.donghuarow;
    
    changhaola.text = [_pkbetdata.numzhou substringWithRange:NSMakeRange(2, 3)];
    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    
    
   
        homeduiLabel.text = [teamarray objectAtIndex:0];
        keduiLabel.text = [teamarray objectAtIndex:1];
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }


   
    rangqiulabel.text = [teamarray objectAtIndex:2];
    lanqiurangfen.text = [teamarray objectAtIndex:2];
    sfclqRangFenLabel.text = [teamarray objectAtIndex:2];


        rangqiulabel.hidden = YES;
        lanqiurangfen.hidden= YES;
//        rangqiulabel.frame = CGRectMake(0, 11, 69, 14);
//        rangqiulabel.font = [UIFont systemFontOfSize:14];
        vslabel.frame = CGRectMake(155, 11, 20, 14);
        if ([rangqiulabel.text isEqualToString:@"0"] || [rangqiulabel.text integerValue] == 0) {

            rangqiulabel.hidden = YES;
            vsImage.hidden = NO;
        }else{
            rangqiulabel.hidden = NO;
            vsImage.hidden = YES;
        }
        

        sfclqRangFenLabel.hidden = YES;

    if (hhChaBool) {//拆分胜平负混合过关数据
        
        if ([pkbetdata.bufshuarr count] < 6) {
            pkbetdata.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0", nil];
        }
        self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr] ;
        if ([_pkbetdata.onePlural rangeOfString:@" 0,"].location != NSNotFound || [_pkbetdata.onePlural rangeOfString:@" 15, 1,"].location != NSNotFound|| [_pkbetdata.onePlural rangeOfString:@" 1, 15,"].location != NSNotFound) {//判断 是否是单复式
            onePluralImage.hidden = YES;
        
        }else if ([_pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
            
            onePluralImage.hidden = NO;
            
//            rangqiulabel.text = [teamarray objectAtIndex:2];
            
            if ([_pkbetdata.bufshuarr count] > 5) {
                
                if ([[_pkbetdata.bufshuarr objectAtIndex:3] isEqualToString:@"1"]) {
                    selection1 = YES;
                }else{
                    selection1 = NO;
                }
                if ([[_pkbetdata.bufshuarr objectAtIndex:4] isEqualToString:@"1"]) {
                    selection2 = YES;
                }else{
                    selection2 = NO;
                }
                if ([[_pkbetdata.bufshuarr objectAtIndex:5] isEqualToString:@"1"]) {
                    selection3 = YES;
                }else{
                    selection3 = NO;
                }
                
                
            }
            if ([_pkbetdata.oupeiarr count] > 5) {
                butLabel1.text = [_pkbetdata.oupeiarr objectAtIndex:3];
                butLabel2.text = [_pkbetdata.oupeiarr objectAtIndex:4];
                butLabel3.text = [_pkbetdata.oupeiarr objectAtIndex:5];
            }
             rangqiulabel.hidden = NO;
            rangqiulabel.text = [NSString stringWithFormat:@"(%@)", [teamarray objectAtIndex:2]  ];
            CGSize labelSize = [butLabel1.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            CGSize rangSize = [rangqiulabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            butLabel1.frame = CGRectMake((button1.frame.size.width - labelSize.width - rangSize.width)/2, 0, labelSize.width, 50.5);
            rangqiulabel.frame = CGRectMake(butLabel1.frame.origin.x+butLabel1.frame.size.width, 17, rangSize.width, 20);
            if ([[teamarray objectAtIndex:2] intValue] > 0) {
                rangqiulabel.textColor = [UIColor redColor];
            }else{
                rangqiulabel.textColor =  [UIColor colorWithRed:51/255.0 green:103/255.0 blue:0/255.0 alpha:1];
            }
            
        }else if ([_pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
            onePluralImage.hidden = NO;
           rangqiulabel.text = @"0";
             rangqiulabel.hidden = YES;
            if ([_pkbetdata.bufshuarr count] > 2) {
                if ([[_pkbetdata.bufshuarr objectAtIndex:0] isEqualToString:@"1"]) {
                    selection1 = YES;
                }else{
                    selection1 = NO;
                }
                if ([[_pkbetdata.bufshuarr objectAtIndex:1] isEqualToString:@"1"]) {
                    selection2 = YES;
                }else{
                    selection2 = NO;
                }
                if ([[_pkbetdata.bufshuarr objectAtIndex:2] isEqualToString:@"1"]) {
                    selection3 = YES;
                }else{
                    selection3 = NO;
                }
            }
            
            if ([_pkbetdata.oupeiarr count] > 2) {
                butLabel1.text = [_pkbetdata.oupeiarr objectAtIndex:0];
                butLabel2.text = [_pkbetdata.oupeiarr objectAtIndex:1];
                butLabel3.text = [_pkbetdata.oupeiarr objectAtIndex:2];
            }
           
        }else{
            
            onePluralImage.hidden = YES;
          
        }
        
        
        
    }else{
        butLabel1.text = [NSString stringWithFormat:@"%@", _pkbetdata.but1 ];
        butLabel2.text = [NSString stringWithFormat:@"%@", _pkbetdata.but2 ];
        butLabel3.text = [NSString stringWithFormat:@"%@", _pkbetdata.but3 ];
        selection1 = _pkbetdata.selection1;
        selection2 = _pkbetdata.selection2;
        selection3 = _pkbetdata.selection3;
        if ([_pkbetdata.onePlural rangeOfString:@" 0,"].location == NSNotFound && [_pkbetdata.onePlural rangeOfString:@" 1,"].location == NSNotFound   ) {//判断 是否是单复式
            if (danguanbool) {
                onePluralImage.hidden = YES;
            }else{
                onePluralImage.hidden = NO;
            }
            
            
        }else {
            
            onePluralImage.hidden = YES;
        }
    }
    
    
    
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    
    
    if (_pkbetdata.dandan) {
        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");

    }else{
        
        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
    }
    
   
    
    UIImageView * but1image = (UIImageView *)[button1 viewWithTag:12];
    UIImageView * but2image = (UIImageView *)[button1 viewWithTag:13];
    
    if (selection1) {

        if (panduan) {
            but1image.hidden = YES;
            but2image.hidden = NO;
        }else{
            but1image.hidden = NO;
            but2image.hidden = YES;
        }
        
        butLabel1.textColor = [UIColor whiteColor];
         butLabel1.font = [UIFont boldSystemFontOfSize:14];
    }
    else {

        but1image.hidden = YES;
        but2image.hidden = YES;
        homeduiLabel.textColor = [UIColor blackColor];
        butLabel1.textColor = [UIColor blackColor];
         butLabel1.font = [UIFont systemFontOfSize:14];
    }
    
    
    UIImageView * but1image2 = (UIImageView *)[button2 viewWithTag:12];
    UIImageView * but2image2 = (UIImageView *)[button2 viewWithTag:13];
    if (selection2) {

        if (panduan) {
            but1image2.hidden = YES;
            but2image2.hidden = NO;
        }else{
            but1image2.hidden = NO;
            but2image2.hidden = YES;
        }
        butLabel2.textColor = [UIColor whiteColor];
         butLabel2.font = [UIFont boldSystemFontOfSize:14];

        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
            
             keduiLabel.textColor = [UIColor blackColor];
        }else if(lanqiucell == matchEnumDaXiaoFenCell){
             keduiLabel.textColor = [UIColor blackColor];
        }

    }
    else {

        but1image2.hidden = YES;
        but2image2.hidden = YES;
        
            if ([rangqiulabel.text isEqualToString:@"0"]) {
                vsImage.hidden = NO;
                rangqiulabel.hidden = YES;
            }else{
                vsImage.hidden = YES;
                rangqiulabel.hidden = NO;
            }

        butLabel2.textColor = [UIColor blackColor];
         butLabel2.font = [UIFont systemFontOfSize:14];
        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
            
            keduiLabel.textColor = [UIColor blackColor];
        }else if(lanqiucell == matchEnumDaXiaoFenCell){
            keduiLabel.textColor = [UIColor blackColor];
        }
    }
   
    UIImageView * but1image3 = (UIImageView *)[button3 viewWithTag:12];
    UIImageView * but2image3 = (UIImageView *)[button3 viewWithTag:13];
        if (selection3) {
            
            if (panduan) {
                but1image3.hidden = YES;
                but2image3.hidden = NO;
            }else{
                but1image3.hidden = NO;
                but2image3.hidden = YES;
            }
            butLabel3.textColor = [UIColor whiteColor];
            butLabel3.font = [UIFont boldSystemFontOfSize:14];
            keduiLabel.textColor = [UIColor blackColor];
        }
        else {
            
            but1image3.hidden = YES;
            but2image3.hidden = YES;
            butLabel3.textColor = [UIColor blackColor];
            butLabel3.font = [UIFont systemFontOfSize:14];
            keduiLabel.textColor = [UIColor blackColor];
        }


        if (panduan) {
            changhaoImage.hidden = YES;
            seletChanghaoImage.hidden = NO;
            eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];
        }else{
            changhaoImage.hidden = NO;
            seletChanghaoImage.hidden = YES;
            eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        }


    
    dan.hidden = YES;
    if (danguanbool) {
        dan.hidden = YES;
    }else{
        if (selection1 || selection2 || selection3) {
            dan.hidden = NO;
            if (panduan) { //判断胆是否被选
                dan.tag = 1;
                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_06.png");
                danzi.textColor = [UIColor whiteColor];
            }else{
                dan.tag = 0;
                danzi.textColor = [UIColor blackColor];
                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
            }
            
        }
    }
    
    
    if (chaobool) {
        dan.hidden = YES;
    }
    
    
    
    if ([cellType isEqualToString:@"1"]) {
        vsImage.image = UIImageGetImageFromName(@"vsimage.png");
        vsImage.frame = CGRectMake(164, 16, 18, 15);
    }

    if (wangqibool || wangqiTwoBool) {
        zhegaiview.hidden = NO;
       
        
    
        if ([cellType isEqualToString:@"1"]) {
            vsImage.hidden = YES;
            homeduiLabel.textColor = [UIColor blackColor];
            keduiLabel.textColor = [UIColor blackColor];
            timeLabel.text = @"完";
            timeLabel.font = [UIFont systemFontOfSize:11];
            timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
             bifenLabel.hidden = NO;
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]&& ![_pkbetdata.bifen isEqualToString:@"null"]) {
                NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
                if ([scores count] > 3) {
                    bifenLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
                }else{
                     bifenLabel.text = @"-";
                }
               
                
                
            }else{
                bifenLabel.text = @"-";
               
                
            }
            
          
//            if ([pkbetdata.macthType isEqualToString:@"overtime"]) {
//                bifenLabel.hidden = YES;
//                 vsImage.frame = CGRectMake(156, 18, 34, 12);
//                vsImage.image = UIImageGetImageFromName(@"spfyijiezhi.png");
//                vsImage.hidden = NO;
//                
//                 NSArray * timedata = [pkbetdata.macthTime componentsSeparatedByString:@" "];
//                if ([timedata count] >= 2) {
//                    timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
//                    timeLabel.font = [UIFont systemFontOfSize:11];
//                    timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
//                }else{
//                    timeLabel.text = @"-";
//                }
//                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                
//            }else  if ([pkbetdata.macthType isEqualToString:@"onLive"]) {
//                bifenLabel.hidden = YES;
//                vsImage.frame = CGRectMake(153, 18, 41, 12);
//                vsImage.image = UIImageGetImageFromName(@"spfzhibozhong.png");
//                vsImage.hidden = NO;
//                NSArray * timedata = [pkbetdata.macthTime componentsSeparatedByString:@" "];
//                if ([timedata count] >= 2) {
//                    timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
//                }else{
//                    timeLabel.text = @"-";
//                }
//                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//            }else  if ([pkbetdata.macthType isEqualToString:@"gameover"]) {
//                bifenLabel.hidden = NO;
//                 timeLabel.text = @"完";
//                timeLabel.font = [UIFont systemFontOfSize:11];
//                timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
//                
//                if (![_pkbetdata.caiguo isEqualToString:@"胜"] && ![_pkbetdata.caiguo isEqualToString:@"平"]&& ![_pkbetdata.caiguo isEqualToString:@"负"]) {
//                    butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                    butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                    butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                }
//
//            }else if ([pkbetdata.macthType isEqualToString:@"delay"]){
//            
//                bifenLabel.hidden = YES;
//                vsImage.frame = CGRectMake(161, 18, 23, 12);
//                vsImage.image = UIImageGetImageFromName(@"yanqiimagespf.png");
//                vsImage.hidden = NO;
//                timeLabel.text = @"延期";
//                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//            
//            }else if([pkbetdata.macthType isEqualToString:@"playvs"]){
//                timeLabel.text = @"-";
//                timeLabel.font = [UIFont systemFontOfSize:11];
//                timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
//                bifenLabel.hidden = YES;
//                butLabel1.textColor = [UIColor blackColor];
//                butLabel2.textColor = [UIColor blackColor];
//                butLabel3.textColor = [UIColor blackColor];
//                winImage3.hidden = YES;
//                winImage2.hidden = YES;
//                winImage1.hidden = YES;
//            }
            
            
            
        }
        
        
       
            NSLog(@"caiguo = %@", _pkbetdata.caiguo);
            if ([_pkbetdata.caiguo isEqualToString:@"胜"]) {
                winImage1.hidden = NO;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                homeduiLabel.textColor = [UIColor blackColor];
                butLabel1.textColor = [UIColor redColor];
                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                rangqiulabel.textColor = [UIColor blackColor];
                
            }else if ([_pkbetdata.caiguo isEqualToString:@"平"]) {
                winImage2.hidden = NO;
                winImage1.hidden = YES;
                winImage3.hidden = YES;
                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                butLabel2.textColor = [UIColor redColor];
                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                rangqiulabel.textColor = [UIColor redColor];
                
            }else if ([_pkbetdata.caiguo isEqualToString:@"负"]) {
                winImage3.hidden = NO;
                winImage2.hidden = YES;
                winImage1.hidden = YES;
                butLabel3.textColor = [UIColor redColor];
                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                keduiLabel.textColor = [UIColor blackColor];
//                rangqiulabel.textColor = [UIColor blackColor];
            }else{
                winImage3.hidden = YES;
                winImage2.hidden = YES;
                winImage1.hidden = YES;
                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                keduiLabel.textColor = [UIColor blackColor];
                homeduiLabel.textColor = [UIColor blackColor];
                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
//                rangqiulabel.textColor = [UIColor blackColor];
            }
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]&& ![_pkbetdata.bifen isEqualToString:@"null"]) {
                NSLog(@"_pkbetdata.bifen = %@", _pkbetdata.bifen);
                NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
                
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
                if ([scores count] > 3) {
                    timeLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
                }else{
                    timeLabel.text = @"-";
                    timeLabel.textColor = [UIColor redColor];
                    timeLabel.font = [UIFont boldSystemFontOfSize:8];
                }
            }else{
                timeLabel.text = @"-";
                timeLabel.textColor = [UIColor redColor];
                timeLabel.font = [UIFont boldSystemFontOfSize:8];
            }
            
            
      
    }else{

        bifenLabel.hidden = YES;
        zhegaiview.hidden = YES;
        winImage1.hidden= YES;
        winImage2.hidden = YES;
        winImage3.hidden = YES;
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        timeLabel.font = [UIFont systemFontOfSize:8];
//        rangqiulabel.textColor = [UIColor redColor];
        if (selection1) {
            homeduiLabel.textColor = [UIColor blackColor];
            butLabel1.textColor = [UIColor whiteColor];
            butLabel1.font = [UIFont boldSystemFontOfSize:14];
        }
        else {
           
            homeduiLabel.textColor = [UIColor blackColor];
            butLabel1.textColor = [UIColor blackColor];
            butLabel1.font = [UIFont systemFontOfSize:14];
        }
        
     
        if (selection2) {

            butLabel2.textColor = [UIColor whiteColor];
            butLabel2.font = [UIFont boldSystemFontOfSize:14];
            
            
            
            
            
        }
        else {
            
            butLabel2.textColor = [UIColor blackColor];
            butLabel2.font = [UIFont systemFontOfSize:14];
            if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
                
                keduiLabel.textColor = [UIColor blackColor];
            }else if(lanqiucell == matchEnumDaXiaoFenCell){
                keduiLabel.textColor = [UIColor blackColor];
            }
        }

       
            if (selection3) {

                butLabel3.textColor = [UIColor whiteColor];
                butLabel3.font = [UIFont boldSystemFontOfSize:14];
                keduiLabel.textColor = [UIColor blackColor];
            }
            else {
                

                butLabel3.textColor = [UIColor blackColor];
                butLabel3.font = [UIFont systemFontOfSize:14];
                keduiLabel.textColor = [UIColor blackColor];
            }
     
        
        
    }
    
    
    if ([cellType isEqualToString:@"1"]) {
        duckImageOne.hidden = YES;
        duckImageTwo.hidden = YES;
        duckImageThree.hidden = YES;
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        if ([pkbetdata.oneMacth isEqualToString:@"1"] && wangqibool == NO && wangqiTwoBool == NO) {
            datal1.hidden = NO;
            datal2.hidden = NO;
            datal3.hidden = NO;
            if (selection1) {
               datal1.textColor = [UIColor whiteColor];
            }else{
                datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }
            if (selection2) {
                datal2.textColor = [UIColor whiteColor];
            }else{
                datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }
            if (selection3) {
                datal3.textColor = [UIColor whiteColor];
            }else{
                datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }
            
        }else{
            datal1.hidden = YES;
            datal2.hidden = YES;
            datal3.hidden = YES;
        }
    }
    
    [self playVsTypeFunc];
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier matchLanQiu:(MatchLanQiuCell)lanqiu caodan:(BOOL)caobool cellType:(NSString *)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:type];
    if (self) {
        typeCell = type;
        // Initialization code
        lanqiucell = lanqiu;
        chaobool = caobool;
        self.butonScrollView.delegate = self;
        [self.butonScrollView addSubview:[self tableViewCell]];
       
        UIImageView * scrollViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(309, 3, 240, 64)];
        scrollViewBack.tag = 1102;
        scrollViewBack.backgroundColor = [UIColor clearColor];
        scrollViewBack.userInteractionEnabled = YES;
        [self.butonScrollView addSubview:scrollViewBack];
        [scrollViewBack release];
        
        view.frame = CGRectMake(0, view.frame.origin.y+20, view.frame.size.width, view.frame.size.height);
//        view.backgroundColor = [UIColor redColor];
        self.butonScrollView.pagingEnabled = YES;
        self.butonScrollView.showsHorizontalScrollIndicator = NO;
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        panduan = NO;
        
    
        
        
        self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23+3, self.butonScrollView.frame.size.width, 71);
//        self.butonScrollView.backgroundColor = [UIColor redColor];
        [self.contentView insertSubview:self.butonScrollView atIndex:10000];
//        self.butonScrollView.backgroundColor = [UIColor redColor];
//        xibutton.backgroundColor = [UIColor blueColor];
        xibutton.frame = CGRectMake(xibutton.frame.origin.x, xibutton.frame.origin.y, xibutton.frame.size.width, 43);
        [self.contentView insertSubview:xibutton atIndex:10001];
        
        UIImageView * lineImage = (UIImageView *)[self.contentView viewWithTag:1890];
        [self.contentView bringSubviewToFront:lineImage];
        
        UIImageView * hengImage = (UIImageView *)[self.contentView viewWithTag:1655];
        [self.contentView bringSubviewToFront:hengImage];
        
        
        if ([type isEqualToString:@"1"]) {
            worldCupLogo = [UIButton buttonWithType:UIButtonTypeCustom];
            worldCupLogo.frame = CGRectMake(175,   73 - 26 - 10, 15, 26);
            worldCupLogo.hidden = YES;
            [worldCupLogo setBackgroundImage:UIImageGetImageFromName(@"dalishenbeispf.png") forState:UIControlStateNormal];
            [worldCupLogo addTarget:self action:@selector(pressWorldCupLogo:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView insertSubview:worldCupLogo atIndex:10002];
        }
       

    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier matchLanQiu:(MatchLanQiuCell)lanqiu caodan:(BOOL)caobool{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lanqiucell = lanqiu;
        chaobool = caobool;
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
- (void)contenOffSetXYFunc{
    NSInteger xcount = 0;
    if ([[self.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
        xcount =  35+ ([self.allTitleArray count]-1)*70;
    }else {
        xcount = [self.allTitleArray count]*70;
        
    }
    if (self.butonScrollView.contentOffset.x >= xcount) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            
            
            NSIndexPath * path = nil;
            //            if (wangqibool) {
            path = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            //            }else{
            //                path = [NSIndexPath indexPathForRow:row.row inSection:row.section+2];
            //            }
            
            [delegate returnCellContentOffsetString:path remove:NO];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
    }else if (self.butonScrollView.contentOffset.x <= 0) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            //            NSLog(@"a = %d, b= %d", count.row , count.section);
            NSIndexPath * path = nil;
            //            if (wangqibool) {
            path = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            //            }else{
            //                path = [NSIndexPath indexPathForRow:row.row inSection:row.section+2];
            //            }
            
            [delegate returnCellContentOffsetString:path remove:YES];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
    }
    
}

- (void)pressHeadButton:(UIButton *)sender{
//    [self contenOffSetXYFunc];
    if ([delegate respondsToSelector:@selector(openCell:)]) {
        [delegate openCell:self];
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
//    if (selected) {
//        if ([delegate respondsToSelector:@selector(openCell:)]) {
//            [delegate openCell:self];
//        }
//    }

    // Configure the view for the selected state
}

- (UIView *)tableViewCell{
    self.backImageView.image = nil;
    self.butonScrollView.backgroundColor = [UIColor clearColor];
    //返回给cell的view
    view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 309, 97)] autorelease];
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
    
    changhaola = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaola.backgroundColor = [UIColor clearColor];
    changhaola.textAlignment = NSTextAlignmentCenter;
    changhaola.font = [UIFont systemFontOfSize:9];
    changhaola.textColor  = [UIColor whiteColor];
    //    [headimage addSubview:changhaola];
    
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 49, 13)];
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];
    [headimage addSubview:eventLabel];
    
    
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 49, 10)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headimage addSubview:timeLabel];
    
    //哪个队对哪个队
    teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 5, 245, 20)];
    teamLabel.textAlignment = NSTextAlignmentCenter;
    teamLabel.font = [UIFont systemFontOfSize:14];
    teamLabel.backgroundColor = [UIColor clearColor];
    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 90, 14)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    //让球
    rangqiulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    rangqiulabel.textAlignment = NSTextAlignmentCenter;
    rangqiulabel.font = [UIFont systemFontOfSize:11];
    rangqiulabel.backgroundColor = [UIColor clearColor];
    rangqiulabel.textColor = [UIColor redColor];
    
    
    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(25.5, 10, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    vsImage.hidden = YES;
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 91, 14)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    
    
    
    
    //第一个button上的小数字
    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 90, 15)];
    butLabel1.textAlignment = NSTextAlignmentCenter;
    butLabel1.backgroundColor = [UIColor clearColor];
    butLabel1.font = [UIFont systemFontOfSize:14];
    
    //第二个button上的小数字
    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 69, 15)];
    butLabel2.textAlignment = NSTextAlignmentCenter;
    butLabel2.backgroundColor = [UIColor clearColor];
    butLabel2.font = [UIFont systemFontOfSize:14];
    
    //第三个button上的小数字
    butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 91, 15)];
    butLabel3.textAlignment = NSTextAlignmentCenter;
    butLabel3.backgroundColor = [UIColor clearColor];
    butLabel3.font = [UIFont systemFontOfSize:14];
    
    
    
    //第一个按钮
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(0.5, 0, 83.5, 51);
    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * linebutton = [[UIView alloc] initWithFrame:CGRectMake(84, 0, 0.5, 51)];
    linebutton.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
   
    
    //第二个按钮
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(84.5, 0, 83.5, 51);
    [button2 addTarget:self action:@selector(pressButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(168, 0, 0.5, 51)];
    linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    
    
    //第三个按钮
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(168.5, 0, 83.5, 51);
    [button3 addTarget:self action:@selector(pressButtonthree:) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
//    [button2 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
//    [button3 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    button3.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    
    UIView * linebutton3 = [[UIView alloc] initWithFrame:CGRectMake(252, 0, 0.5, 51)];
    linebutton3.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    
    
    for (int i = 0; i < 3; i++) {
        UIImageView * bgimage = [[UIImageView alloc] initWithFrame:button1.bounds];
        bgimage.tag = 12;
        bgimage.hidden = YES;
        bgimage.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
//        bgimage.image = UIImageGetImageFromName(@"rqspfbgxuan.png");
        
        
        UIImageView * bgimage2 = [[UIImageView alloc] initWithFrame:button1.bounds];
        bgimage2.tag = 13;
        bgimage2.hidden = YES;
        bgimage2.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
//        bgimage2.image=  UIImageGetImageFromName(@"rqspfbgxuandan.png");
        
       
        
        
        if (i == 0) {
            [button1 addSubview:bgimage];
            [bgimage release];
            [button1 addSubview:bgimage2];
            [bgimage2 release];
            
            
        }else if (i == 1){
            [button2 addSubview:bgimage];
            [bgimage release];
            [button2 addSubview:bgimage2];
            [bgimage2 release];
           
            
        }else if (i == 2){
            [button3 addSubview:bgimage];
            [bgimage release];
            [button3 addSubview:bgimage2];
            [bgimage2 release];
           
            
        }
        
        
    }
    
    
    
    
//    dan = [UIButton buttonWithType:UIButtonTypeCustom];
//    dan.hidden = YES;
//    dan.frame = CGRectMake(270, 16, 40, 30);
//    [dan addTarget:self action:@selector(pressdandown:) forControlEvents:UIControlEventTouchDown];
//    [dan addTarget:self action:@selector(pressDan:) forControlEvents:UIControlEventTouchUpInside];
//    danimge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
//    [dan addSubview:danimge];
//    danzi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    danzi.text = @"胆";
//    danzi.font = [UIFont systemFontOfSize:12];
//    danzi.textColor = [UIColor blackColor];
//    danzi.textAlignment = NSTextAlignmentCenter;
//    danzi.backgroundColor = [UIColor clearColor];
//    [dan addSubview:danzi];
    
    
    
    
    
    //    //升降图片
    //    sjImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 82-6-5, 34, 6, 8)];
    //    sjImageView.backgroundColor = [UIColor clearColor];
    //
    //    sjImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake( 82-6-5, 34, 6, 8)];
    //    sjImageView2.backgroundColor = [UIColor clearColor];
    //
    //    sjImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake( 82-6-5, 34, 6, 8)];
    //    sjImageView3.backgroundColor = [UIColor clearColor];
    
    
    
    [button2 addSubview:vsImage];
    [vsImage release];
    [button1 addSubview:butLabel1];
    [button1 addSubview:rangqiulabel];
    [button2 addSubview:butLabel2];
    [button3 addSubview:butLabel3];
    [rangqiulabel release];
    
    
    //    [button1 addSubview:sjImageView];
    //    [button2 addSubview:sjImageView2];
    //    [button3 addSubview:sjImageView3];
    
    
    
    
    
    winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
    winImage1.backgroundColor = [UIColor clearColor];
    winImage1.hidden = YES;
    winImage1.image=  UIImageGetImageFromName(@"winImage.png");
    [button1 addSubview:winImage1];
    [winImage1 release];
    
    winImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
    winImage2.backgroundColor = [UIColor clearColor];
    winImage2.hidden = YES;
    winImage2.image = UIImageGetImageFromName(@"winImage.png");
    [button2 addSubview:winImage2];
    [winImage2 release];
    
    winImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
    winImage3.backgroundColor = [UIColor clearColor];
    winImage3.hidden = YES;
    winImage3.image = UIImageGetImageFromName(@"winImage.png");
    [button3 addSubview:winImage3];
    [winImage3 release];
    
    
//    [view addSubview:dan];
    
    [view addSubview:button1];
    [view addSubview:button2];
    [view addSubview:button3];
    [view addSubview:linebutton];
    [linebutton release];
    [view addSubview:linebutton2];
    [linebutton2 release];
    [view addSubview:linebutton3];
    [linebutton3 release];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20, 14)];
    bifenLabel.textAlignment = NSTextAlignmentCenter;
    bifenLabel.font = [UIFont boldSystemFontOfSize:14];
    bifenLabel.backgroundColor = [UIColor clearColor];
    bifenLabel.textColor = [UIColor blackColor];
    bifenLabel.hidden = YES;
    [headimage addSubview:bifenLabel];
    [bifenLabel release];
    
    XIDANImageView = [[UIImageView alloc] initWithFrame:CGRectMake(252.5, 0, 56, 51)];
    XIDANImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    XIDANImageView.hidden = YES;
    XIDANImageView.userInteractionEnabled = YES;
    XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
    
    xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xidanButton.frame = XIDANImageView.bounds;
    [xidanButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [XIDANImageView addSubview:xidanButton];
    xidanButton.hidden = YES;
    
    
    butTitle = [[UILabel alloc] init];
    butTitle.frame = CGRectMake(0, 51-22, 56, 20);
    butTitle.font = [UIFont systemFontOfSize:11];
    butTitle.textAlignment = NSTextAlignmentCenter;
    butTitle.textColor = [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
    butTitle.backgroundColor = [UIColor clearColor];
    [XIDANImageView addSubview:butTitle];
    [butTitle release];
    
    [view addSubview:XIDANImageView];
    [XIDANImageView release];
    
    
    changhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaoImage.backgroundColor = [UIColor clearColor];
    changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
    [headimage addSubview:changhaoImage];
    [changhaoImage release];
    
    seletChanghaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    seletChanghaoImage.backgroundColor = [UIColor clearColor];
    seletChanghaoImage.image = UIImageGetImageFromName(@"changhaodan.png");
    seletChanghaoImage.hidden = YES;
    [headimage addSubview:seletChanghaoImage];
    [seletChanghaoImage release];
    
    [headimage addSubview:changhaola];
    
    
    timeLabel.frame = CGRectMake(5, 26, 59, 14);
    timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:11];
    eventLabel.frame = CGRectMake(35, 5, 49, 13);
//    eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];
    eventLabel.textAlignment = NSTextAlignmentLeft;
    homeduiLabel.frame  = CGRectMake(65, 16, 83, 14);
    vsImage.frame = CGRectMake(164, 16, 18, 15);
    
    keduiLabel.frame = CGRectMake(195,16, 73, 14);
    [headimage addSubview:homeduiLabel];
    [headimage addSubview:keduiLabel];
    
    
    
    [headimage addSubview:vsImage];
    
    
    xidanButton.hidden = NO;
    XIDANImageView.hidden = NO;
    
    
    butLabel1.frame = CGRectMake(0, 0, 83.5, 51);
    butLabel2.frame = CGRectMake(0, 0, 83.5, 51);
    butLabel3.frame = CGRectMake(0, 0, 83.5, 51);
    
    
    winImage1.frame = CGRectMake(1, 1, 10, 10);
    winImage1.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage2.frame = CGRectMake(1, 1, 10, 10);
    winImage2.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage3.frame = CGRectMake(1, 1, 10, 10);
    winImage3.image = UIImageGetImageFromName(@"hongnew.png");
    
    
    datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    //    datal1.text = @"3";
    datal1.font = [UIFont systemFontOfSize:15];
    datal1.textAlignment = NSTextAlignmentCenter;
    datal1.backgroundColor = [UIColor clearColor];
    //    datal1.textColor = [UIColor blackColor];
    datal1.userInteractionEnabled = NO;
    //按钮上显示1
    datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    //    datal2.text = @"1";
    datal2.font = [UIFont systemFontOfSize:15];
    datal2.textAlignment = NSTextAlignmentCenter;
    datal2.backgroundColor = [UIColor clearColor];
    //    datal2.textColor = [UIColor blackColor];
    datal2.userInteractionEnabled = NO;
    
    //按钮上显示0
    datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    //    datal3.text = @"0";
    datal3.font = [UIFont systemFontOfSize:15];
    datal3.textAlignment = NSTextAlignmentCenter;
    datal3.backgroundColor = [UIColor clearColor];
    //    datal3.textColor = [UIColor blackColor];
    datal3.userInteractionEnabled = NO;
    
    [button1 addSubview:datal1];
    [button2 addSubview:datal2];
    [button3 addSubview:datal3];
    //
    datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal1.frame = CGRectMake(4, 15, 15, 21);
    datal2.frame = CGRectMake(4, 15, 15, 21);
    datal3.frame = CGRectMake(4, 15, 15, 21);
    datal1.font = [UIFont systemFontOfSize:10];
    datal2.font = [UIFont systemFontOfSize:10];
    datal3.font = [UIFont systemFontOfSize:10];
    datal1.text = @"胜";
    datal2.text = @"平";
    datal3.text = @"负";
    
    
    
    duckImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83.5, 0)];//鸭子图片
    duckImageOne.backgroundColor = [UIColor clearColor];
    duckImageOne.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageOne.hidden = YES;
    [button1 addSubview:duckImageOne];
    [duckImageOne release];
    
    duckImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83.5, 0)];//鸭子图片
    duckImageTwo.backgroundColor = [UIColor clearColor];
    duckImageTwo.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageTwo.hidden = YES;
    [button2 addSubview:duckImageTwo];
    [duckImageTwo release];
    
    duckImageThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83.5, 0)];//鸭子图片
    duckImageThree.backgroundColor = [UIColor clearColor];
    duckImageThree.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageThree.hidden = YES;
    [button3 addSubview:duckImageThree];
    [duckImageThree release];
    
    
    
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(0, 0, 309-56, 51);
    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
    //    [zhegaiview release];
    //    [view addSubview:xibutton];
    
    
    
    
    
    
    
    UIImageView * shuImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 0.5, 95)];
    shuImage.tag = 1890;
    shuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
//    shuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:shuImage];
   
    [shuImage release];
    
    UIImageView * hengImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 93.5+3, 309, 1.5)];
    hengImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
//    hengImage.image = UIImageGetImageFromName(@"rqspfheng.png");
    hengImage.tag = 1655;
    [self.contentView addSubview:hengImage];
    [hengImage release];
    
    UIImageView * houshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(308.5+5.5, 3, 0.5, 95)];
    houshuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    
//    houshuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:houshuImage];
    [houshuImage release];
    
    onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 4, 4)];
    onePluralImage.hidden = YES;
    onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
    [view addSubview:onePluralImage];
    [onePluralImage release];
    
    
    return view;
}

- (void)presszhegaiviewButton:(UIButton *)sender{

}

//- (UIView *)tableViewCell{
//    //返回给cell的view
//    self.backImageView.image = nil;
//    self.butonScrollView.backgroundColor = [UIColor clearColor];
//    if ([typeCell isEqualToString:@"1"]) {
//        
//    }else{
//        UIImageView * scrbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 295, 50)];
//        scrbg.backgroundColor = [UIColor clearColor];
//        scrbg.image = UIImageGetImageFromName(@"");
//        [self.butonScrollView addSubview:scrbg];
//        [scrbg release];
//        
//        UIImageView * bianbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 295, 6)];
//        bianbg.backgroundColor = [UIColor clearColor];
//        bianbg.image = UIImageGetImageFromName(@"");
//        [self.butonScrollView addSubview:bianbg];
//        [bianbg release];
//    }
//    
//   
//    
//    
//    view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 66)] autorelease];
//    view.tag = 1101;
//    
//    
//   
//    
//#ifdef isCaiPiaoForIPad
//    view.frame = CGRectMake(0, 0, 390, 66);
//#endif
//    headimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 49, 50)];
//    headimage.backgroundColor = [UIColor clearColor];
//    headimage.image = UIImageGetImageFromName(@"zucaihead.png");
//    headimage.userInteractionEnabled = YES;
//    
//    UIButton * headButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    headButton.frame = headimage.bounds;
//    [headButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
//    [headimage addSubview:headButton];
//    
//    changhaola = [[UILabel alloc] initWithFrame:CGRectMake(7, 2, 38, 17)];
//    changhaola.backgroundColor = [UIColor clearColor];
//    changhaola.textAlignment = NSTextAlignmentCenter;
//    changhaola.font = [UIFont systemFontOfSize:9];
//    changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    
//    
//  
//    //德甲还是什么..
//    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 49, 13)];
//    eventLabel.textAlignment = NSTextAlignmentCenter;
//    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
//    eventLabel.backgroundColor = [UIColor clearColor];
//    eventLabel.textColor = [UIColor blackColor];
//    [headimage addSubview:eventLabel];
//    
//
//   
//
//    //时间
//    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 49, 10)];
//    timeLabel.textAlignment = NSTextAlignmentCenter;
//    timeLabel.font = [UIFont systemFontOfSize:8];
//    timeLabel.backgroundColor = [UIColor clearColor];
//    timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    [headimage addSubview:timeLabel];
//    
//
//    
//    
//    //主队
//    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 90, 14)];
//    homeduiLabel.textAlignment = NSTextAlignmentCenter;
//    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
//    homeduiLabel.backgroundColor = [UIColor clearColor];
//    homeduiLabel.textColor = [UIColor blackColor];
//    //让球
//    rangqiulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 69, 14)];
//    rangqiulabel.textAlignment = NSTextAlignmentCenter;
//    rangqiulabel.font = [UIFont boldSystemFontOfSize:14];
//    rangqiulabel.backgroundColor = [UIColor clearColor];
//    rangqiulabel.textColor = [UIColor blackColor];
//    
//    
//   
//    
//    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(25.5, 10, 18, 15)];
//    vsImage.backgroundColor = [UIColor clearColor];
//    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
//    vsImage.hidden = YES;
//    
//   
//    
//    //篮球让分
//    lanqiurangfen = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 69, 14)];
//    lanqiurangfen.textAlignment = NSTextAlignmentCenter;
//    lanqiurangfen.font = [UIFont systemFontOfSize:14];
//    lanqiurangfen.backgroundColor = [UIColor clearColor];
//    lanqiurangfen.textColor = [UIColor redColor];
//    lanqiurangfen.hidden = YES;
//    
//
//    sfclqRangFenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 69, 14)];
//    sfclqRangFenLabel.textAlignment = NSTextAlignmentCenter;
//    sfclqRangFenLabel.font = [UIFont systemFontOfSize:14];
//    sfclqRangFenLabel.backgroundColor = [UIColor clearColor];
//    sfclqRangFenLabel.textColor = [UIColor redColor];
//    sfclqRangFenLabel.hidden = YES;
//    
//     vslabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 11, 20, 14)];
//    vslabel.textAlignment = NSTextAlignmentCenter;
//    vslabel.font = [UIFont systemFontOfSize:14];
//    vslabel.backgroundColor = [UIColor clearColor];
//    vslabel.text = @"vs";
//    vslabel.textColor = [UIColor redColor];
//    
//    //客队
//    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 91, 14)];
//    keduiLabel.textAlignment = NSTextAlignmentCenter;
//    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
//    keduiLabel.backgroundColor = [UIColor clearColor];
//    keduiLabel.textColor = [UIColor blackColor];
//    
//    
//    //第一个button上的小数字
//    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 90, 14)];
//    butLabel1.textAlignment = NSTextAlignmentCenter;
//    butLabel1.backgroundColor = [UIColor clearColor];
//    butLabel1.font = [UIFont systemFontOfSize:14];
//    
//    //第二个button上的小数字
//    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 69, 14)];
//    butLabel2.textAlignment = NSTextAlignmentCenter;
//    butLabel2.backgroundColor = [UIColor clearColor];
//    butLabel2.font = [UIFont systemFontOfSize:14];
//    
//    //第三个button上的小数字
//    butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 91, 14)];
//    butLabel3.textAlignment = NSTextAlignmentCenter;
//    butLabel3.backgroundColor = [UIColor clearColor];
//    butLabel3.font = [UIFont systemFontOfSize:14];
//
//
//    
//    //第一个按钮
//    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    button1.frame = CGRectMake(59, 0, 90, 50);
////    button1.tag = 3;
//    [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
// 
//    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
//   
//    
//    
//    //第二个按钮
//     button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    
//    button2.frame = CGRectMake(149, 0, 69, 50);
////    button2.tag = 1;
//    [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(pressButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
//
//    
//    //第三个按钮
//    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    button3.frame = CGRectMake(218, 0, 91, 50);
////    button3.tag = 0;
//    [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
//    [button3 addTarget:self action:@selector(pressButtonthree:) forControlEvents:UIControlEventTouchUpInside];
//
//    
//    
//
//    
//    //按钮上显示3
//    datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    datal1.text = @"3";
//    datal1.font = [UIFont systemFontOfSize:15];
//    datal1.textAlignment = NSTextAlignmentCenter;
//    datal1.backgroundColor = [UIColor clearColor];
////    datal1.textColor = [UIColor blackColor];
//    datal1.userInteractionEnabled = NO;
//    //按钮上显示1
//    datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    datal2.text = @"1";
//    datal2.font = [UIFont systemFontOfSize:15];
//    datal2.textAlignment = NSTextAlignmentCenter;
//    datal2.backgroundColor = [UIColor clearColor];
////    datal2.textColor = [UIColor blackColor];
//    datal2.userInteractionEnabled = NO;
//
//    //按钮上显示0
//    datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    datal3.text = @"0";
//    datal3.font = [UIFont systemFontOfSize:15];
//    datal3.textAlignment = NSTextAlignmentCenter;
//    datal3.backgroundColor = [UIColor clearColor];
////    datal3.textColor = [UIColor blackColor];
//    datal3.userInteractionEnabled = NO;
//    
//    
//    
//    
//    dan = [UIButton buttonWithType:UIButtonTypeCustom];
//    dan.hidden = YES;
//    dan.frame = CGRectMake(270, 16, 40, 30);
//    [dan addTarget:self action:@selector(pressdandown:) forControlEvents:UIControlEventTouchDown];
//    [dan addTarget:self action:@selector(pressDan:) forControlEvents:UIControlEventTouchUpInside];
//    danimge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
//    [dan addSubview:danimge];
//    danzi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    danzi.text = @"胆";
//    danzi.font = [UIFont systemFontOfSize:12];
//    danzi.textColor = [UIColor blackColor];
//    danzi.textAlignment = NSTextAlignmentCenter;
//    danzi.backgroundColor = [UIColor clearColor];
//    [dan addSubview:danzi];
//
//    
//    
//    xibutton = [UIButton buttonWithType:UIButtonTypeCustom];
//     xibutton.frame = CGRectMake(275, 0, 60, 66);
//    
//#ifdef isCaiPiaoForIPad
//    xibutton.frame = CGRectMake(324, 0, 60, 66);
//#endif
//    [xibutton addTarget:self action:@selector(pressxibutton:) forControlEvents:UIControlEventTouchUpInside];
//    
//   // [xibutton setImage:UIImageGetImageFromName(@"gc_xl_12.png") forState:UIControlStateNormal];
//    
//    
//    bgimagevv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
//    
//    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
//    [xibutton addSubview:bgimagevv];
//    [xibutton addTarget:self action:@selector(touchxibutton:) forControlEvents:UIControlEventTouchDown];
//    [xibutton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
//    [xibutton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
//    
////    [self addTarget:self action:@selector(TouchUpInside) forControlEvents:UIControlEventTouchUpInside];
////    [self addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
////    [self addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
////    [self addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
//    
//  //  [xibutton setTitle:@"析" forState:UIControlStateNormal];
//    xizi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    xizi.text = @"析";
//    xizi.font = [UIFont systemFontOfSize:12];
//    xizi.textColor = [UIColor whiteColor];
//    xizi.textAlignment = NSTextAlignmentCenter;
//    xizi.backgroundColor = [UIColor clearColor];
////    [xibutton addSubview:xizi];
//    
//    
//        [button2 addSubview:rangqiulabel];
//   
//    [button1 addSubview:lanqiurangfen];
//    [lanqiurangfen release];
//    [button2 addSubview:sfclqRangFenLabel];
//    [sfclqRangFenLabel release];
//    [rangqiulabel release];
//    
//    
//    [button1 addSubview:butLabel1];
//    [button2 addSubview:butLabel2];
//    [button3 addSubview:butLabel3];
//    
//    
//    
//   
//   
//   
//   
//    
//    
//    
//    winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
//    winImage1.backgroundColor = [UIColor clearColor];
//    winImage1.hidden = YES;
//    winImage1.image=  UIImageGetImageFromName(@"winImage.png");
//    [button1 addSubview:winImage1];
//    [winImage1 release];
//    
//    winImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
//    winImage2.backgroundColor = [UIColor clearColor];
//    winImage2.hidden = YES;
//    winImage2.image = UIImageGetImageFromName(@"winImage.png");
//    [button2 addSubview:winImage2];
//    [winImage2 release];
//    
//    winImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
//    winImage3.backgroundColor = [UIColor clearColor];
//    winImage3.hidden = YES;
//    winImage3.image = UIImageGetImageFromName(@"winImage.png");
//    [button3 addSubview:winImage3];
//    [winImage3 release];
//   
//    
//    
//    [view addSubview:vslabel];
//    [vslabel release];
//
//    
//    
//
//        
//    
//    
//    if (lanqiucell == matchEnumShengFuCell) {
//        rangqiulabel.hidden = YES;
//        lanqiurangfen.hidden= YES;
//    }else if (lanqiucell == matchEnumDaXiaoFenCell || lanqiucell == matchEnumRangFenShengFucell) {
//        rangqiulabel.hidden = YES;
//        lanqiurangfen.hidden= NO;
//        lanqiurangfen.frame = CGRectMake(90, 13, 28, 13);
//        lanqiurangfen.font = [UIFont systemFontOfSize:8];
//        vslabel.frame = CGRectMake(163, 11, 20, 14);
//    }else{
//        rangqiulabel.hidden = NO;
//        lanqiurangfen.hidden= YES;
//        rangqiulabel.frame = CGRectMake(0, 11, 69, 14);
//        rangqiulabel.font = [UIFont systemFontOfSize:14];
//         vslabel.frame = CGRectMake(155, 11, 20, 14);
//        
//    }
//    
//    if (lanqiucell == matchEnumRangFenShengFucell) {
//        sfclqRangFenLabel.frame = CGRectMake(95, 13, 28, 13);
//        sfclqRangFenLabel.font = [UIFont systemFontOfSize:8];
//        sfclqRangFenLabel.hidden = NO;
//        lanqiurangfen.hidden= YES;
//    }
//    
//    
////    [view addSubview:changhaola];
//    
//    [view addSubview:dan];
//       
//    [view addSubview:button1];
//    [view addSubview:button2];
//    [view addSubview:button3];
//    
//    
//    XIDANImageView = [[UIImageView alloc] initWithFrame:CGRectMake(246, 0, 54, 51)];
//    XIDANImageView.backgroundColor = [UIColor clearColor];
//    XIDANImageView.hidden = YES;
//    XIDANImageView.userInteractionEnabled = YES;
//    XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew1.png");
//    
//    xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    xidanButton.frame = XIDANImageView.bounds;
//    [xidanButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
//    [XIDANImageView addSubview:xidanButton];
//    xidanButton.hidden = YES;
//    
//    
//    butTitle = [[UILabel alloc] init];
//    butTitle.frame = CGRectMake(0, 51-22, 54, 20);
//    butTitle.font = [UIFont systemFontOfSize:11];
//    butTitle.textAlignment = NSTextAlignmentCenter;
//    butTitle.textColor = [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
//    butTitle.backgroundColor = [UIColor clearColor];
//    [XIDANImageView addSubview:butTitle];
//    [butTitle release];
//    
//    [view addSubview:XIDANImageView];
//    [XIDANImageView release];
//    
//    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20, 14)];
//    bifenLabel.textAlignment = NSTextAlignmentCenter;
//    bifenLabel.font = [UIFont boldSystemFontOfSize:14];
//    bifenLabel.backgroundColor = [UIColor clearColor];
//    bifenLabel.textColor = [UIColor blackColor];
//    bifenLabel.hidden = YES;
//    //    bifenLabel.text = @"234:234";
//    [headimage addSubview:bifenLabel];
//    [bifenLabel release];
//    
//    
//    
//    
//    if ([typeCell isEqualToString:@"1"]) { // 胜平负新界面
//        view.frame = CGRectMake(0, 20, 300, 109-43);
//        headimage.frame = CGRectMake(11, 0, 289, 43);
//        headimage.image = UIImageGetImageFromName(@"bjbeidan.png");
//        [self.contentView addSubview:headimage];
//        
//        changhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 38, 12)];
//        changhaoImage.backgroundColor = [UIColor clearColor];
//        changhaoImage.image = UIImageGetImageFromName(@"");
//        [headimage addSubview:changhaoImage];
//        [changhaoImage release];
//        
//        [changhaoImage addSubview:changhaola];
//        changhaola.frame = changhaoImage.bounds;
//        
//        timeLabel.frame = CGRectMake(5, 26, 59, 14);
//        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
//        timeLabel.font = [UIFont systemFontOfSize:11];
//        eventLabel.frame = CGRectMake(35, 5, 49, 13);
//        eventLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
//        eventLabel.textAlignment = NSTextAlignmentLeft;
//        homeduiLabel.frame  = CGRectMake(65, 16, 83, 14);
//        vsImage.frame = CGRectMake(164, 16, 18, 15);
//        
//        keduiLabel.frame = CGRectMake(195,16, 73, 14);
//        [headimage addSubview:homeduiLabel];
//        [headimage addSubview:keduiLabel];
//        
//         button1.frame = CGRectMake(0, 0, 82, 51);
//        
//        
//        button2.frame = CGRectMake(82, 0, 82, 51);
//        //    button2.tag = 1;
//   
//        
//        button3.frame = CGRectMake(164, 0, 82, 51);
//        //    button3.tag = 0;
//        [button1 setImage:UIImageGetImageFromName(@"spfzuoimage.png") forState:UIControlStateNormal];
//        [button2 setImage:UIImageGetImageFromName(@"spfzhongimage.png") forState:UIControlStateNormal];
//        [button3 setImage:UIImageGetImageFromName(@"spfyouimage.png") forState:UIControlStateNormal];
//        [headimage addSubview:vsImage];
//        
//         xibutton.frame = CGRectMake(259, 0, 60, 66);
//         bgimagevv.frame = CGRectMake(20, 13, 20, 20);
//        
////        [headimage addSubview:xibutton];
//        xidanButton.hidden = NO;
//        XIDANImageView.hidden = NO;
//        
//        
//        butLabel1.frame = CGRectMake(0, 0, 82, 51);
//        butLabel2.frame = CGRectMake(0, 0, 82, 51);
//        butLabel3.frame = CGRectMake(0, 0, 82, 51);
//        butLabel1.font = [UIFont systemFontOfSize:18];
//        butLabel2.font = [UIFont systemFontOfSize:18];
//        butLabel3.font = [UIFont systemFontOfSize:18];
//        
//        winImage1.frame = CGRectMake(3, 3, 10, 10);
//        winImage1.image = UIImageGetImageFromName(@"hongnew.png");
//        
//        winImage2.frame = CGRectMake(3, 3, 10, 10);
//        winImage2.image = UIImageGetImageFromName(@"hongnew.png");
//        
//        winImage3.frame = CGRectMake(3, 3, 10, 10);
//        winImage3.image = UIImageGetImageFromName(@"hongnew.png");
//        
////        butLabel1.textAlignment = NSTextAlignmentCenter;
////        butLabel1.backgroundColor = [UIColor clearColor];
////        butLabel1.font = [UIFont systemFontOfSize:14];
////        
////        //第二个button上的小数字
////        butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 69, 14)];
////        butLabel2.textAlignment = NSTextAlignmentCenter;
////        butLabel2.backgroundColor = [UIColor clearColor];
////        butLabel2.font = [UIFont systemFontOfSize:14];
////        
////        //第三个button上的小数字
////        butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 91, 14)];
////        butLabel3.textAlignment = NSTextAlignmentCenter;
////        butLabel3.backgroundColor = [UIColor clearColor];
////        butLabel3.font = [UIFont systemFontOfSize:14];
//        
//        [button1 addSubview:datal1];
//        [button2 addSubview:datal2];
//        [button3 addSubview:datal3];
//        
//        datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        datal1.frame = CGRectMake(4, 15, 15, 21);
//        datal2.frame = CGRectMake(4, 15, 15, 21);
//        datal3.frame = CGRectMake(4, 15, 15, 21);
//        datal1.font = [UIFont systemFontOfSize:10];
//        datal2.font = [UIFont systemFontOfSize:10];
//        datal3.font = [UIFont systemFontOfSize:10];
//        datal1.text = @"胜";
//        datal2.text = @"平";
//        datal3.text = @"负";
//      
//        duckImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 82, 0)];//鸭子图片
//        duckImageOne.backgroundColor = [UIColor clearColor];
//        duckImageOne.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
//        duckImageOne.hidden = YES;
//        [button1 addSubview:duckImageOne];
//        [duckImageOne release];
//        
//        duckImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 82, 0)];//鸭子图片
//        duckImageTwo.backgroundColor = [UIColor clearColor];
//        duckImageTwo.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
//        duckImageTwo.hidden = YES;
//        [button2 addSubview:duckImageTwo];
//        [duckImageTwo release];
//        
//        duckImageThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 82, 0)];//鸭子图片
//        duckImageThree.backgroundColor = [UIColor clearColor];
//        duckImageThree.image = [UIImageGetImageFromName(@"shengpingfuyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
//        duckImageThree.hidden = YES;
//        [button3 addSubview:duckImageThree];
//        [duckImageThree release];
//dddd
//     
//        yearImageView = [[UIImageView alloc] init];
//        yearImageView.frame = CGRectMake(0, 0, 0, 0);
//        yearImageView.image = UIImageGetImageFromName(@"year2014spf.png");
//        yearImageView.backgroundColor = [UIColor clearColor];
//        [headimage addSubview:yearImageView];
//        [yearImageView release];
//        
//        homeBannerImageView = [[UIImageView alloc] init];
//        homeBannerImageView.frame = CGRectMake(0, 0, 0, 0);
//        homeBannerImageView.backgroundColor = [UIColor clearColor];
//        [headimage addSubview:homeBannerImageView];
//        [homeBannerImageView release];
//        
////        worldCupLogo = [[UIImageView alloc] init];
////        worldCupLogo.frame = CGRectMake(0, 0, 0, 0);
////        worldCupLogo.backgroundColor = [UIColor clearColor];
////        worldCupLogo.image = UIImageGetImageFromName(@"dalishenbeispf.png");
////        [headimage addSubview:worldCupLogo];
////        [worldCupLogo release];
//        
//        
//        
//        
//        guestBannerImageView = [[UIImageView alloc] init];
//        guestBannerImageView.frame = CGRectMake(0, 0, 0, 0);
//        guestBannerImageView.backgroundColor = [UIColor clearColor];
//        [headimage addSubview:guestBannerImageView];
//        [guestBannerImageView release];
//        
//        
//        
//    }else{
//        [view addSubview:headimage];
//        [headimage addSubview:changhaola];
//        [button1 addSubview:homeduiLabel];
//        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell) {
//            
//            [button1 addSubview:homeduiLabel];
//            [button2 addSubview:keduiLabel];
//            
//        }else if(lanqiucell == matchEnumDaXiaoFenCell){
//            [button1 addSubview:homeduiLabel];
//            [button2 addSubview:keduiLabel];
//        }else{
//             [button3 addSubview:keduiLabel];
//            
//        }
//       
//        [button2 addSubview:vsImage];
//        [view addSubview:xibutton];
//        
//    }
//     [vsImage release];
//     [headimage release];
//    
//    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
//    [zhegaiview addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
//    zhegaiview.frame=  CGRectMake(59, 0, 251, 50);
////    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
//#ifdef isCaiPiaoForIPad
//    zhegaiview.frame = CGRectMake(59+35, 0, 251, 50);
//    bgimagevv.frame = CGRectMake(20, 0, 30, 31);
//    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
//#endif
//    zhegaiview.backgroundColor = [UIColor clearColor];
//    zhegaiview.hidden= YES;
//    [view addSubview:zhegaiview];
////    [zhegaiview release];
////    
////    if (lanqiucell == matchEnumDaXiaoFenCell || lanqiucell == matchEnumRangFenShengFucell || lanqiucell == matchEnumShengFuCell) {
////        
////    }else{
//    
////    }
//
//    [self panDuanZuLanCai];
//
//    return view;
//}

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
        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
            
            [button1 setImage:UIImageGetImageFromName(@"zucaizzuo_1.png") forState:UIControlStateNormal];
            
        }else {
            
            [button1 setImage:UIImageGetImageFromName(@"zucaizuo_1.png") forState:UIControlStateNormal];
        }

    }
    if (sender.tag == 1) {
        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
            
             [button2 setImage:UIImageGetImageFromName(@"zucaizzhong_1.png") forState:UIControlStateNormal];
            
        }else {
             [button2 setImage:UIImageGetImageFromName(@"zucaizhong_1.png") forState:UIControlStateNormal];
        }

       
    }
    if (sender.tag == 0) {
      //  buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2.png");
        
        [button3 setImage:UIImageGetImageFromName(@"zucaiyou_1.png") forState:UIControlStateNormal];
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
            NSLog(@"bbbbbb");
        }
       
    }else{
        danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
        danzi.textColor = [UIColor blackColor];
        dbool = NO;
        sender.tag = 0;
        cout--;
        NSLog(@"aaaaaaaaaaa");
    }
    NSLog(@"dbool = %d", dbool);
    [self returnBoolDan:dbool row:row];
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
    duckImageThree.hidden = YES;
    duckImageTwo.hidden = YES;
    duckImageOne.hidden = YES;
    
    if (hhChaBool) {
        [self returncellrownumbifen:row CP_CanOpenCell:self];
    }else{
        [self returncellrownum:row cell:self];
    }
    
    
    
    xizi.textColor = [UIColor whiteColor];
  //  bgimagevv.image = UIImageGetImageFromName(@"gc_dot4.png");
    
#ifdef isCaiPiaoForIPad
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
#else
    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
#endif
}

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        [delegate returnbifenCellInfo:index shuzu:bufshuzu dan:booldan ];
        
    }
    
    
}
- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell{
    if ([delegate respondsToSelector:@selector(returncellrownumbifen:CP_CanOpenCell:)]) {
        [delegate returncellrownumbifen:num CP_CanOpenCell:self];
    }
    //    NSLog(@"num = %d", num);
}

//第一个按钮的触发函数
- (void)pressButton1:(UIButton *)button{
    NSLog(@"button 333333333");
    if ([pkbetdata.but1 isEqualToString:@"-"]){
        return;
    }
    UIImageView * selectImage = (UIImageView *)[button viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button viewWithTag:13];
    // NSLog(@"count  =  %d", count);
    if (!selection1) {
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        butLabel1.textColor = [UIColor whiteColor];
        rangqiulabel.textColor = [UIColor whiteColor];
        //        butLabel1.font = [UIFont boldSystemFontOfSize:14];
        
        
        selection1 = YES;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:3 withObject:@"1"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:0 withObject:@"1"];
            }
            
        }
        
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        butLabel1.textColor = [UIColor blackColor];
        rangqiulabel.textColor = [UIColor redColor];
        //         butLabel1.font = [UIFont systemFontOfSize:14];
        selection1 = NO;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:3 withObject:@"0"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:0 withObject:@"0"];
            }
            
        }
        
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
        panduan = NO;
    }
//    [self jianThouShowFunc];
    [self headShowFunc];
    
    if (hhChaBool) {
        [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:panduan];
    }else{
        [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    }
    
    
    
}

//第二个按钮的触发函数
- (void)pressButtonTwo:(UIButton *)button{
    if ([pkbetdata.but2 isEqualToString:@"-"]){
        return;
    }
    NSLog(@"button 1111111111");
    UIImageView * selectImage = (UIImageView *)[button viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button viewWithTag:13];
    if (!selection2) {
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        
        butLabel2.textColor = [UIColor whiteColor];
        //         butLabel2.font = [UIFont boldSystemFontOfSize:14];
        vsImage.hidden = YES;
        selection2 = YES;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:4 withObject:@"1"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:1 withObject:@"1"];
            }
            
        }
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel2.textColor = [UIColor blackColor];
        //         butLabel2.font = [UIFont systemFontOfSize:14];
        selection2 = NO;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:4 withObject:@"0"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:1 withObject:@"0"];
            }
            
        }
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
        panduan = NO;
    }
//    [self jianThouShowFunc];
    [self headShowFunc];
    
    if (hhChaBool) {
        [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:panduan];
    }else{
        [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    }
}

//第三个按钮的触发函数
- (void)pressButtonthree:(UIButton *)button{
    NSLog(@"button 00000000000");
    if ([pkbetdata.but3 isEqualToString:@"-"]){
        return;
    }
    UIImageView * selectImage = (UIImageView *)[button viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button viewWithTag:13];
    
    if (!selection3) {
        
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        butLabel3.textColor = [UIColor whiteColor];
        //         butLabel3.font = [UIFont boldSystemFontOfSize:14];
        
        selection3 = YES;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:5 withObject:@"1"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:2 withObject:@"1"];
            }
            
        }
    }else{
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel3.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        //         butLabel3.font = [UIFont systemFontOfSize:14];
        selection3 = NO;
        if (hhChaBool) {
            if ([pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:5 withObject:@"0"];
            }else if ([pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
                [self.typeButtonArray replaceObjectAtIndex:2 withObject:@"0"];
            }
            
        }
        
    }
    if (selection1 || selection2 || selection3) {
        dan.hidden = NO;
        boldan = YES;
    }else{
        dan.hidden = YES;
        boldan = NO;
        panduan = NO;
    }
    
//    [self jianThouShowFunc];
    [self headShowFunc];
    
    if (hhChaBool) {
        [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:panduan];
    }else{
        [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    }
   
    
}

////第一个按钮的触发函数
//- (void)pressButton1:(UIButton *)button{
//    NSLog(@"button 333333333");
//   // NSLog(@"count  =  %d", count);
//    if (!selection1) {
//     //   buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
//            
//            [button1 setImage:UIImageGetImageFromName(@"zucaizzuo_1.png") forState:UIControlStateNormal];
//            
//        }else {
//            if ([cellType isEqualToString:@"1"]) {
//                 [button1 setImage:UIImageGetImageFromName(@"spfxuanzhongimage.png") forState:UIControlStateNormal];
//            }else{
//                 [button1 setImage:UIImageGetImageFromName(@"zucaizuo_1.png") forState:UIControlStateNormal];
//            }
//           
//        }
//        butLabel1.textColor = [UIColor whiteColor];
//         butLabel1.font = [UIFont boldSystemFontOfSize:14];
////        datal1.textColor = [UIColor whiteColor];
//        selection1 = YES;
//       // boldan1 = YES;
//    }else{
//        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
//            
//            [button1 setImage:UIImageGetImageFromName(@"zucaizzuo.png") forState:UIControlStateNormal];
//            
//        }else {
//            if ([cellType isEqualToString:@"1"]) {
//                [button1 setImage:UIImageGetImageFromName(@"spfzuoimage.png") forState:UIControlStateNormal];
//            }else{
//                [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
//            }
//
//            
//        }
//      //  [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
////        datal1.textColor = [UIColor blackColor];
//        butLabel1.textColor = [UIColor blackColor];
//         butLabel1.font = [UIFont systemFontOfSize:14];
//        selection1 = NO;
//      //  boldan1 = NO;
//    }
//    if (danguanbool) {
//        dan.hidden = YES;
//    }else{
//        if (selection1 || selection2 || selection3) {
//            dan.hidden = NO;
//            boldan = YES;
//        }else{
//            dan.hidden = YES;
//            boldan = NO;
//        }
//
//    }
//    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
//     
//}
//
////第二个按钮的触发函数
//- (void)pressButtonTwo:(UIButton *)button{
//    NSLog(@"button 1111111111");
//    if (!selection2) {
//     //   buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
//            
//            [button2 setImage:UIImageGetImageFromName(@"zucaizyou_1.png") forState:UIControlStateNormal];
//            
//        }else {
//            if ([cellType isEqualToString:@"1"]) {
//                [button2 setImage:UIImageGetImageFromName(@"spfxuanzhongimage.png") forState:UIControlStateNormal];
//            }else{
//                [button2 setImage:UIImageGetImageFromName(@"zucaizhong_1.png") forState:UIControlStateNormal];
//            }
//            
//            vsImage.hidden = YES;
//        }
//        butLabel2.textColor = [UIColor whiteColor];
////        datal2.textColor = [UIColor whiteColor];
//         butLabel2.font = [UIFont boldSystemFontOfSize:14];
//        selection2 = YES;
////        boldan2 = YES;
//    }else{
//   //     buttonImage2.image = UIImageGetImageFromName(@"gc_xxx.png");
//        if (lanqiucell == matchEnumShengFuCell || lanqiucell == matchEnumRangFenShengFucell ||lanqiucell == matchEnumDaXiaoFenCell) {
//            
//            [button2 setImage:UIImageGetImageFromName(@"zucaizyou.png") forState:UIControlStateNormal];
//            
//        }else {
//            if ([cellType isEqualToString:@"1"]) {
//                [button2 setImage:UIImageGetImageFromName(@"spfzhongimage.png") forState:UIControlStateNormal];
//            }else{
//                [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
//            }
//           
//            if ([rangqiulabel.text isEqualToString:@"0"]) {
//                vsImage.hidden = NO;
//                rangqiulabel.hidden = YES;
//            }else{
//                vsImage.hidden = YES;
//                rangqiulabel.hidden = NO;
//            }
//        }
////        datal2.textColor = [UIColor blackColor];
//         butLabel2.font = [UIFont systemFontOfSize:14];
//        butLabel2.textColor = [UIColor blackColor];
//        
//        selection2 = NO;
////        boldan2 = NO;
//    }
//    
//    if (danguanbool) {
//        dan.hidden = YES;
//    }else{
//        if (selection1 || selection2 || selection3) {
//            dan.hidden = NO;
//            boldan = YES;
//        }else{
//            dan.hidden = YES;
//            boldan = NO;
//        }
//    }
//    
//    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
//     
//}
//
////第三个按钮的触发函数
//- (void)pressButtonthree:(UIButton *)button{
//    NSLog(@"button 00000000000");
//    if (!selection3) {
//       // buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        
//        if ([cellType isEqualToString:@"1"]) {
//            [button3 setImage:UIImageGetImageFromName(@"spfxuanzhongimage.png") forState:UIControlStateNormal];
//        }else{
//            [button3 setImage:UIImageGetImageFromName(@"zucaiyou_1.png") forState:UIControlStateNormal];
//        }
//        butLabel3.textColor = [UIColor whiteColor];
//         butLabel3.font = [UIFont boldSystemFontOfSize:14];
////        datal3.textColor = [UIColor whiteColor];
//        selection3 = YES;
////        boldan3 = YES;
//    }else{
//      //  buttonImage3.image = UIImageGetImageFromName(@"gc_xxx.png");
//       
//        if ([cellType isEqualToString:@"1"]) {
//            [button3 setImage:UIImageGetImageFromName(@"spfyouimage.png") forState:UIControlStateNormal];
//        }else{
//            [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
//        }
////        datal3.textColor = [UIColor blackColor];
//        butLabel3.textColor = [UIColor blackColor];
//         butLabel3.font = [UIFont systemFontOfSize:14];
//        selection3 = NO;
////        boldan3 = NO;
//    }
//    if (danguanbool) {
//        dan.hidden = YES;
//    }else{
//        if (selection1 || selection2 || selection3) {
//            dan.hidden = NO;
//            boldan = YES;
//        }else{
//            dan.hidden = YES;
//            boldan = NO;
//        }
//    }
//    
//    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
//    
//}

- (void)returncellrownum:(NSIndexPath *)num cell:(CP_CanOpenCell *)cell{
    if ([delegate respondsToSelector:@selector(returncellrownum:cell:)]) {
        [delegate returncellrownum:num cell:self];
    }
    
    
//    NSLog(@"num = %d", num);
}

- (void)returnBoolDan:(BOOL)danbool row:(NSIndexPath *)num{
//    if ([delegate respondsToSelector:@selector(returnBoolDan:row:)]) {
//        [delegate returnBoolDan:danbool row:num];
//    }
}

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnCellInfo:buttonBoll1:buttonBoll:buttonBoll:dan:)]) {
        [delegate returnCellInfo:index buttonBoll1:select1 buttonBoll:select2 buttonBoll:select3 dan:boldan ];
       // NSLog(@"index = %d", index);
    }
//    NSLog(@"deleaaaaaaaaaaaaaaaa");
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    NSInteger xcount = 0;
    if ([[self.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
        xcount =  35+ ([self.allTitleArray count]-1)*70;
    }else {
        xcount = [self.allTitleArray count]*70;
        
    }
    if (self.butonScrollView.contentOffset.x >= xcount || self.butonScrollView.contentOffset.x <= 0) {
         [self contenOffSetXYFunc];
    }
   
}

- (void)pressWorldCupLogo:(UIButton *)sender{
    if (delegate && [delegate respondsToSelector:@selector(pressWorldCupLogoDelegate)]) {
        [delegate pressWorldCupLogoDelegate];
    }
}

- (void)dealloc{
    [typeButtonArray release];
    [changhaola release];
    [danzi release];
    [danimge release];
    [matcinfo release];
    



  
//    [buttonImage release];
//    [buttonImage2 release];
//    [buttonImage3 release];

    
    [datal1 release];
    [datal2 release];
    [datal3 release];
//    [view release];
    [eventLabel release];
 
    [timeLabel release];
  
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
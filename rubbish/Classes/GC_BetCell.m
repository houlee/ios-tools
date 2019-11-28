//
//  PKBetCell.m
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_BetCell.h"
#import "NewAroundViewController.h"
#import "caiboAppDelegate.h"


@implementation GC_BetCell
@synthesize eventLabel;

@synthesize timeLabel;
@synthesize wangqibool;
@synthesize butLabel1;
@synthesize butLabel2;
@synthesize butLabel3;
@synthesize view;
@synthesize count;
@synthesize selection1;
@synthesize selection2;
@synthesize selection3;
@synthesize row;

@synthesize delegate;
@synthesize playid;
@synthesize matcinfo;
@synthesize homeduiLabel;
@synthesize keduiLabel;

@synthesize cout;
@synthesize nengyong, XIDANImageView;
@synthesize dandan, panduan, boldan, renjiubool,danTuoBool, butTitle;
- (void)headShowFunc{
    
    if (panduan) {
        changhaoImage.hidden = YES;
        seletChanghaoImage.hidden =  NO;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

//        changhaola.textColor  = [UIColor whiteColor];
    }else{
        seletChanghaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        changhaoImage.hidden = NO;
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
}
//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}


//- (void)donghuaxizi{
//    if (donghua == 0) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.52f];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:bgimagevv cache:YES];
//        [UIView commitAnimations];
//        
//        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:2];
//        
//    }
//}

- (void)setPkbetdata:(GC_BetData *)_pkbetdata{
    if (pkbetdata != _pkbetdata) {
        [pkbetdata release];
        pkbetdata = [_pkbetdata retain];
    }
    if (self.butonScrollView.contentOffset.x != 0||wangqibool) {
        
//        if (buttonBool) {
//        
//            [UIView beginAnimations:@"nddd" context:NULL];
//            [UIView setAnimationDuration:.3];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            NSLog(@"!@5555555555555555555");
//            self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
//            [UIView commitAnimations];
//            buttonBool = NO;
//        }else{
            NSLog(@"!@6666666666666666666");
            self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
//        }
        
    }
    NSLog(@"!@7777777777777777777");
    self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
    XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
    eventLabel.text = _pkbetdata.event;
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }

    
    timeLabel.text = [NSString stringWithFormat:@"%@ %@", _pkbetdata.date, _pkbetdata.time ];
 
    butLabel1.text = [NSString stringWithFormat:@"%@", _pkbetdata.but1 ];
    butLabel2.text = [NSString stringWithFormat:@"%@", _pkbetdata.but2 ];
    butLabel3.text = [NSString stringWithFormat:@"%@", _pkbetdata.but3 ];
    selection1 = _pkbetdata.selection1;
    
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
//    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    dandan = _pkbetdata.dandan;
    
    changhaola.text = [NSString stringWithFormat:@"%d", (int)row+1];
    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    homeduiLabel.text = [teamarray objectAtIndex:0];
    keduiLabel.text = [teamarray objectAtIndex:1];
  
    
    
    
     donghua = _pkbetdata.donghuarow;
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(donghuaxizi) object:nil];
//    if (donghua == 0) {
//        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:3];
//    }

    
    UIImageView * selectImage = (UIImageView *)[button1 viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button1 viewWithTag:13];
    
    if (selection1) {
      //  buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        [button1 setImage:UIImageGetImageFromName(@"zucaizuo_1.png") forState:UIControlStateNormal];
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        butLabel1.textColor = [UIColor whiteColor];
//        rangqiulabel.textColor = [UIColor whiteColor];
//        datal1.textColor = [UIColor whiteColor];
        butLabel1.textColor = [UIColor whiteColor];
//        homeduiLabel.textColor = [UIColor whiteColor];
         butLabel1.font = [UIFont boldSystemFontOfSize:14];
    }
    else {
//        [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
       // buttonImage.image = UIImageGetImageFromName(@"gc_xxx.png");
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
//        butLabel1.textColor = [UIColor blackColor];
//        rangqiulabel.textColor = [UIColor redColor];

//        datal1.textColor = [UIColor blackColor];
        homeduiLabel.textColor = [UIColor blackColor];
        butLabel1.textColor = [UIColor blackColor];
         butLabel1.font = [UIFont systemFontOfSize:14];
    }
    
    selection2 = _pkbetdata.selection2;
    UIImageView * selectImage2 = (UIImageView *)[button2 viewWithTag:12];
    UIImageView * danSelectImage2 = (UIImageView *)[button2 viewWithTag:13];
    if (selection2) {
        if (panduan) {
            selectImage2.hidden = YES;
            danSelectImage2.hidden = NO;
        }else{
            selectImage2.hidden = NO;
            danSelectImage2.hidden = YES;
        }

//        [button2 setImage:UIImageGetImageFromName(@"zucaizhong_1.png") forState:UIControlStateNormal];

    //    buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        datal2.textColor = [UIColor whiteColor];
        butLabel2.textColor = [UIColor whiteColor];
         butLabel2.font = [UIFont boldSystemFontOfSize:14];
//        vsImage.hidden = YES;
    }
    else {
        selectImage2.hidden = YES;
        danSelectImage2.hidden = YES;
//        [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
      //  buttonImage2.image = UIImageGetImageFromName(@"gc_xxx.png");
//        datal2.textColor = [UIColor blackColor];
        butLabel2.textColor = [UIColor blackColor];
         butLabel2.font = [UIFont systemFontOfSize:14];
//        vsImage.hidden = NO;
    }
    selection3 = _pkbetdata.selection3;
    UIImageView * selectImage3 = (UIImageView *)[button3 viewWithTag:12];
    UIImageView * danSelectImage3 = (UIImageView *)[button3 viewWithTag:13];
    if (selection3) {
//        [button3 setImage:UIImageGetImageFromName(@"zucaiyou_1.png") forState:UIControlStateNormal];
        
            
            if (panduan) {
                selectImage3.hidden = YES;
                danSelectImage3.hidden = NO;
            }else{
                selectImage3.hidden = NO;
                danSelectImage3.hidden = YES;
            }
     //  buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
//        datal3.textColor = [UIColor whiteColor];
        butLabel3.textColor = [UIColor whiteColor];
//        keduiLabel.textColor = [UIColor whiteColor];
         butLabel3.font = [UIFont boldSystemFontOfSize:14];
    }
    else {
        selectImage3.hidden = YES;
        danSelectImage3.hidden = YES;
//        [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
    //    buttonImage3.image = UIImageGetImageFromName(@"gc_xxx.png");
//        datal3.textColor = [UIColor blackColor];
        keduiLabel.textColor = [UIColor blackColor];
        butLabel3.textColor = [UIColor blackColor];
         butLabel3.font = [UIFont systemFontOfSize:14];
    }
    [self headShowFunc];
//    if(panduan){
//        headimage.image = UIImageGetImageFromName(@"zucaihead_1.png");
//        changhaola.textColor  = [UIColor whiteColor];
//    }else{
//        headimage.image = UIImageGetImageFromName(@"zucaihead.png");
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    }
    
    dan.hidden = YES;
    if (renjiubool) {
//        if (selection1 || selection2 || selection3) {
            UIButton * cellbutton = (UIButton *)[self.butonScrollView viewWithTag:1];
//            UIImageView * btnImage = (UIImageView *)[cellbutton viewWithTag:10];
        
            if (_pkbetdata.nengdan) {
                
              
                cellbutton.hidden = NO;
                dan.hidden = NO;
            }else{
               
                cellbutton.hidden = NO;
                dan.hidden = YES;
            }
            
            if (panduan) { //判断胆是否被选
//                cellbutton.backgroundColor = [UIColor redColor];
               
//                btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
//                 btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
                dan.tag = 1;
//                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_06.png");
                danzi.textColor = [UIColor whiteColor];
            }else{
//                cellbutton.backgroundColor = [UIColor blackColor];
//                btnImage.image = UIImageGetImageFromName(@"danzucai.png");
//                 btnImage.image = UIImageGetImageFromName(@"danzucai.png");
                dan.tag = 0;
                danzi.textColor = [UIColor blackColor];
//                danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
            }
            
//        }
    }
    
    
    
//    bgimagevv.frame = CGRectMake(0, 7, 18, 17);
//    xibutton.frame = CGRectMake(245, 6, 60, 26);
 

//    
//    eventLabel.frame = CGRectMake(0, 22, 49, 13);
//    timeLabel.frame = CGRectMake(1, 35, 49, 10);
  
    
//#ifdef isCaiPiaoForIPad
//    headimage.frame = CGRectMake(10+35, 0, 49, 50);
//    button1.frame = CGRectMake(59+35, 0, 90, 50);
//    button2.frame = CGRectMake(149+35, 0, 69, 50);
//    button3.frame = CGRectMake(218+35, 0, 91, 50);
//    xibutton.frame = CGRectMake(324, 0, 60, 66);
//    zhegaiview.frame = CGRectMake(59+35, 0, 251, 50); 
//#else
//    button1.frame = CGRectMake(59, 0, 90, 50);
//    button2.frame = CGRectMake(149, 0, 69, 50);
//    button3.frame = CGRectMake(218, 0, 91, 50);
//#endif
    
    

        if (wangqibool) {
//            rangqiulabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            zhegaiview.hidden = NO;
            
            NSLog(@"caiguo = %@", _pkbetdata.caiguo);
            if ([_pkbetdata.caiguo isEqualToString:@"3"]) {
                winImage1.hidden = NO;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                butLabel1.textColor = [UIColor redColor];
                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                //            rangqiulabel.textColor = [UIColor blackColor];
                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                
                
            }else if ([_pkbetdata.caiguo isEqualToString:@"1"]) {
                winImage2.hidden = NO;
                winImage1.hidden = YES;
                winImage3.hidden = YES;
                butLabel2.textColor = [UIColor redColor];
                //            rangqiulabel.textColor = [UIColor redColor];
                
                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                
                butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                
                
            }else if ([_pkbetdata.caiguo isEqualToString:@"0"]) {
                winImage3.hidden = NO;
                winImage2.hidden = YES;
                winImage1.hidden = YES;
                butLabel3.textColor = [UIColor redColor];
                
                butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                //            rangqiulabel.textColor = [UIColor blackColor];
            }else if([_pkbetdata.caiguo isEqualToString:@"取消"]){
                winImage1.hidden = YES;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                bifenLabel.text = @"取消";
                timeLabel.text = @"";
                
            }else{
                winImage1.hidden = YES;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
            }
            
            vsImage.hidden = YES;
            if (![_pkbetdata.caiguo isEqualToString:@"取消"]) {
                if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]) {

                    if([_pkbetdata.bifen length] > 0){
                        bifenLabel.text = _pkbetdata.bifen;
                        timeLabel.text = @"完";
                        vsImage.hidden = YES;
                         timeLabel.font = [UIFont systemFontOfSize:11];
                         timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
                    }else{
                        bifenLabel.text = @"";
//                        timeLabel.text = @"";
                        vsImage.hidden = NO;

                        timeLabel.font = [UIFont systemFontOfSize:8];
                        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    }
//                    else{
//                    }
                    

                   
                }else{
                    bifenLabel.text = @"-";
                    timeLabel.text = @"...";
                     timeLabel.font = [UIFont systemFontOfSize:11];
                     timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
                }
                
            }else{
                winImage1.hidden = YES;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                bifenLabel.text = @"取消";
                timeLabel.text = @"";
                 timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
                 timeLabel.font = [UIFont systemFontOfSize:11];
            }
            
            
            bifenLabel.hidden = NO;
           
           
            bifenLabel.hidden = NO;
            
        }else{
            bifenLabel.hidden = YES;
            zhegaiview.hidden = YES;
            winImage1.hidden= YES;
            winImage2.hidden = YES;
            winImage3.hidden = YES;
//            timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
            timeLabel.text = [NSString stringWithFormat:@"%@ %@", _pkbetdata.date, _pkbetdata.time ];
            timeLabel.font = [UIFont systemFontOfSize:8];
            timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            

    }
    

}

    
    
    
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:type];
    if (self) {
        
        
        
        
        
        self.backgroundColor = [UIColor clearColor];
        
        
        self.butonScrollView.delegate = self;
        [self.butonScrollView addSubview:[self tableViewCell]];
        
        UIImageView * scrollViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(309, 5, 240, 64)];
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
        
        
        
        
        self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23+5, self.butonScrollView.frame.size.width, 71);
        
        self.butonScrollView.backgroundColor = [UIColor clearColor];
        
        
        
        
        
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        [self.contentView addSubview:[self tableViewCell]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        

    }
    return self;
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
    headimage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 5, 309, 43)];
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
//    rangqiulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    rangqiulabel.textAlignment = NSTextAlignmentCenter;
//    rangqiulabel.font = [UIFont systemFontOfSize:11];
//    rangqiulabel.backgroundColor = [UIColor clearColor];
//    rangqiulabel.textColor = [UIColor redColor];
    
    
    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(25.5, 10, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
//    vsImage.hidden = YES;
    
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
//    [button1 addSubview:rangqiulabel];
    [button2 addSubview:butLabel2];
    [button3 addSubview:butLabel3];
//    [rangqiulabel release];
    
    
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
    
    
    [view addSubview:dan];
    
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
    XIDANImageView.backgroundColor = [UIColor clearColor];
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
//    eventLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
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
    
    
//    datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    //    datal1.text = @"3";
//    datal1.font = [UIFont systemFontOfSize:15];
//    datal1.textAlignment = NSTextAlignmentCenter;
//    datal1.backgroundColor = [UIColor clearColor];
//    //    datal1.textColor = [UIColor blackColor];
//    datal1.userInteractionEnabled = NO;
//    //按钮上显示1
//    datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    //    datal2.text = @"1";
//    datal2.font = [UIFont systemFontOfSize:15];
//    datal2.textAlignment = NSTextAlignmentCenter;
//    datal2.backgroundColor = [UIColor clearColor];
//    //    datal2.textColor = [UIColor blackColor];
//    datal2.userInteractionEnabled = NO;
//    
//    //按钮上显示0
//    datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//    //    datal3.text = @"0";
//    datal3.font = [UIFont systemFontOfSize:15];
//    datal3.textAlignment = NSTextAlignmentCenter;
//    datal3.backgroundColor = [UIColor clearColor];
//    //    datal3.textColor = [UIColor blackColor];
//    datal3.userInteractionEnabled = NO;
//    
//    [button1 addSubview:datal1];
//    [button2 addSubview:datal2];
//    [button3 addSubview:datal3];
//    //
//    datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    datal1.frame = CGRectMake(4, 15, 15, 21);
//    datal2.frame = CGRectMake(4, 15, 15, 21);
//    datal3.frame = CGRectMake(4, 15, 15, 21);
//    datal1.font = [UIFont systemFontOfSize:10];
//    datal2.font = [UIFont systemFontOfSize:10];
//    datal3.font = [UIFont systemFontOfSize:10];
//    datal1.text = @"胜";
//    datal2.text = @"平";
//    datal3.text = @"负";
    
    
    
    
    
    
    
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(0, 0, 310-56, 51);
    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
    //    [zhegaiview release];
    //    [view addSubview:xibutton];
    
    
    UIImageView * shuImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 5, 0.5, 95)];
    shuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    shuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:shuImage];
    [shuImage release];
    
    UIImageView * hengImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 93.5+5, 309, 1.5)];
    hengImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    hengImage.image = UIImageGetImageFromName(@"rqspfheng.png");
    [self.contentView addSubview:hengImage];
    [hengImage release];
    
    UIImageView * houshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(308.5+5.5, 5, 0.5, 95)];
    houshuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    houshuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:houshuImage];
    [houshuImage release];
    
    
    
    
    return view;
}
- (void)pressHeadButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(openCell:)]) {
        [delegate openCell:self];
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

- (void)pressdandown:(UIButton *)sender{
    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_03.png");
}

- (void)presszhegaiviewButton:(UIButton *)sender{
    
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
    [self returncellrownum:row];
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
    if ([pkbetdata.but1 isEqualToString:@"-"]){
        return;
    }
    UIImageView * selectImage = (UIImageView *)[button viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button viewWithTag:13];
    // NSLog(@"count  =  %d", count);
    if (!selection1) {
        if (danTuoBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            return;
        }
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        butLabel1.textColor = [UIColor whiteColor];
//        rangqiulabel.textColor = [UIColor whiteColor];
        //        butLabel1.font = [UIFont boldSystemFontOfSize:14];
        
        
        selection1 = YES;
        
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        butLabel1.textColor = [UIColor blackColor];
//        rangqiulabel.textColor = [UIColor redColor];
        //         butLabel1.font = [UIFont systemFontOfSize:14];
        selection1 = NO;
        
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
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    
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
        if (danTuoBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            return;
        }
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        
        butLabel2.textColor = [UIColor whiteColor];
        //         butLabel2.font = [UIFont boldSystemFontOfSize:14];
//        vsImage.hidden = YES;
        selection2 = YES;
        
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel2.textColor = [UIColor blackColor];
        //         butLabel2.font = [UIFont systemFontOfSize:14];
        selection2 = NO;
        
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
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    
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
        if (danTuoBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            return;
        }
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
        
    }else{
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel3.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        //         butLabel3.font = [UIFont systemFontOfSize:14];
        selection3 = NO;
        
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
    
    
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
    
}



- (void)returncellrownum:(NSInteger)num{
    if ([delegate respondsToSelector:@selector(returncellrownum:)]) {
        [delegate returncellrownum:num];
    }
}

- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnCellInfo:buttonBoll1:buttonBoll:buttonBoll:dan:)]) {
        [delegate returnCellInfo:index buttonBoll1:select1 buttonBoll:select2 buttonBoll:select3 dan:dandan];
       // NSLog(@"index = %d", index);
    }
    NSLog(@"deleaaaaaaaaaaaaaaaa");
    
}

- (void)hidenXieBtn {
    xibutton.hidden = YES;
    donghua = 0;
}

- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num{
    if ([delegate respondsToSelector:@selector(returnBoolDan:row:)]) {
        [delegate returnBoolDan:danbool row:num];
    }
}

- (void)contenOffSetXYFunc{
    NSInteger xcount = 0;
//    if ([[self.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//        xcount =  35+ ([self.allTitleArray count]-1)*70;
//    }else {
        xcount = [self.allTitleArray count]*70;
        
//    }
    if (self.butonScrollView.contentOffset.x >= xcount) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            
            
            NSIndexPath * path = nil;
            //            if (wangqibool) {
            path = [NSIndexPath indexPathForRow:row inSection:0];
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
            path = [NSIndexPath indexPathForRow:row inSection:0];
            //            }else{
            //                path = [NSIndexPath indexPathForRow:row.row inSection:row.section+2];
            //            }
            
            [delegate returnCellContentOffsetString:path remove:YES];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    NSInteger xcount = 0;
//    if ([[self.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//        xcount =  35+ ([self.allTitleArray count]-1)*70;
//    }else {
        xcount = [self.allTitleArray count]*70;
        
//    }
    if (self.butonScrollView.contentOffset.x >= xcount || self.butonScrollView.contentOffset.x <= 0) {
        [self contenOffSetXYFunc];
    }
    
}

- (void)dealloc{
    [changhaola release];
//    [danimge release];
//    [danzi release];
//    [matcinfo release];


//    [datal1 release];
//    [datal2 release];
//    [datal3 release];
//    [view release];
    [eventLabel release];
    
    [timeLabel release];

    [butLabel1 release];
    [butLabel2 release];
    [butLabel3 release];
    [pkbetdata release];
//    [bgimagevv release];
//    [xizi release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
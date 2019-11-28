//
//  PK_TableCell.m
//  caibo
//
//  Created by houchenguang on 14-7-18.
//
//
 #import "NewAroundViewController.h"
#import "caiboAppDelegate.h"
#import "PK_TableCell.h"


@implementation PK_TableCell
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
@synthesize nengyong;
@synthesize dandan, panduan, boldan, renjiubool,danTuoBool;

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
    if ([teamarray count] > 1) {
        homeduiLabel.text = [teamarray objectAtIndex:0];
        keduiLabel.text = [teamarray objectAtIndex:1];
    }else{
        homeduiLabel.text = @"";
        keduiLabel.text = @"";
    }
   
    
    
    
    
    donghua = _pkbetdata.donghuarow;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(donghuaxizi) object:nil];
    if (donghua == 0) {
        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:3];
    }
    
    
    
    
    if (selection1) {
        //  buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        [button1 setImage:UIImageGetImageFromName(@"zucaizuo_1.png") forState:UIControlStateNormal];
        
        datal1.textColor = [UIColor whiteColor];
        butLabel1.textColor = [UIColor whiteColor];
        //        homeduiLabel.textColor = [UIColor whiteColor];
        butLabel1.font = [UIFont boldSystemFontOfSize:14];
    }
    else {
        [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
        // buttonImage.image = UIImageGetImageFromName(@"gc_xxx.png");
        datal1.textColor = [UIColor blackColor];
        homeduiLabel.textColor = [UIColor blackColor];
        butLabel1.textColor = [UIColor blackColor];
        butLabel1.font = [UIFont systemFontOfSize:14];
    }
    
    selection2 = _pkbetdata.selection2;
    if (selection2) {
        [button2 setImage:UIImageGetImageFromName(@"zucaizhong_1.png") forState:UIControlStateNormal];
        
        //    buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        datal2.textColor = [UIColor whiteColor];
        butLabel2.textColor = [UIColor whiteColor];
        butLabel2.font = [UIFont boldSystemFontOfSize:14];
        vsImage.hidden = YES;
    }
    else {
        [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
        //  buttonImage2.image = UIImageGetImageFromName(@"gc_xxx.png");
        datal2.textColor = [UIColor blackColor];
        butLabel2.textColor = [UIColor blackColor];
        butLabel2.font = [UIFont systemFontOfSize:14];
        vsImage.hidden = NO;
    }
    selection3 = _pkbetdata.selection3;
    if (selection3) {
        [button3 setImage:UIImageGetImageFromName(@"zucaiyou_1.png") forState:UIControlStateNormal];
        
        //  buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        datal3.textColor = [UIColor whiteColor];
        butLabel3.textColor = [UIColor whiteColor];
        //        keduiLabel.textColor = [UIColor whiteColor];
        butLabel3.font = [UIFont boldSystemFontOfSize:14];
    }
    else {
        [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
        //    buttonImage3.image = UIImageGetImageFromName(@"gc_xxx.png");
        datal3.textColor = [UIColor blackColor];
        keduiLabel.textColor = [UIColor blackColor];
        butLabel3.textColor = [UIColor blackColor];
        butLabel3.font = [UIFont systemFontOfSize:14];
    }
    
    if(panduan){
        headimage.image = UIImageGetImageFromName(@"zucaihead_1.png");
        changhaola.textColor  = [UIColor whiteColor];
    }else{
        headimage.image = UIImageGetImageFromName(@"zucaihead.png");
        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    dan.hidden = YES;
    if (renjiubool) {
        //        if (selection1 || selection2 || selection3) {
        UIButton * cellbutton = (UIButton *)[self.butonScrollView viewWithTag:1];
        UIImageView * btnImage = (UIImageView *)[cellbutton viewWithTag:10];
        
        if (_pkbetdata.nengdan) {
            
            
            cellbutton.hidden = NO;
            dan.hidden = NO;
        }else{
            
            cellbutton.hidden = NO;
            dan.hidden = YES;
        }
        
        if (panduan) { //判断胆是否被选
            //                cellbutton.backgroundColor = [UIColor redColor];
            
            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
            dan.tag = 1;
            danimge.image = UIImageGetImageFromName(@"gc_dan_xl_06.png");
            danzi.textColor = [UIColor whiteColor];
        }else{
            //                cellbutton.backgroundColor = [UIColor blackColor];
            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            dan.tag = 0;
            danzi.textColor = [UIColor blackColor];
            danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
        }
        
        //        }
    }
    
    
    
    //    bgimagevv.frame = CGRectMake(0, 7, 18, 17);
    //    xibutton.frame = CGRectMake(245, 6, 60, 26);
    
    
    
    eventLabel.frame = CGRectMake(0, 22, 49, 13);
    timeLabel.frame = CGRectMake(1, 35, 49, 10);
    
    
#ifdef isCaiPiaoForIPad
    headimage.frame = CGRectMake(10+35, 0, 49, 50);
    button1.frame = CGRectMake(59+35, 0, 90, 50);
    button2.frame = CGRectMake(149+35, 0, 69, 50);
    button3.frame = CGRectMake(218+35, 0, 91, 50);
    xibutton.frame = CGRectMake(324, 0, 60, 66);
    zhegaiview.frame = CGRectMake(59+35, 0, 251, 50);
#else
    button1.frame = CGRectMake(59, 0, 90, 50);
    button2.frame = CGRectMake(149, 0, 69, 50);
    button3.frame = CGRectMake(218, 0, 91, 50);
#endif
    
    
    
    if (wangqibool) {
        
        zhegaiview.hidden = NO;
        
        [button1 setImage:UIImageGetImageFromName(@"wqxiaozuohui.png") forState:UIControlStateNormal];
        [button2 setImage:UIImageGetImageFromName(@"wqxiaozhonghui.png") forState:UIControlStateNormal];
        [button3 setImage:UIImageGetImageFromName(@"wqxiaoyouhui.png") forState:UIControlStateNormal];
        NSLog(@"caiguo = %@", _pkbetdata.caiguo);
        if ([_pkbetdata.caiguo isEqualToString:@"3"]) {
            winImage1.hidden = NO;
            winImage2.hidden = YES;
            winImage3.hidden = YES;
            homeduiLabel.textColor = [UIColor redColor];
            butLabel1.textColor = [UIColor redColor];
            
        }else if ([_pkbetdata.caiguo isEqualToString:@"1"]) {
            winImage2.hidden = NO;
            winImage1.hidden = YES;
            winImage3.hidden = YES;
            butLabel2.textColor = [UIColor redColor];
            //                rangqiulabel.textColor = [UIColor redColor];
            
        }else if ([_pkbetdata.caiguo isEqualToString:@"0"]) {
            winImage3.hidden = NO;
            winImage2.hidden = YES;
            winImage1.hidden = YES;
            butLabel3.textColor = [UIColor redColor];
            keduiLabel.textColor = [UIColor redColor];
            
        }else{
            winImage3.hidden = YES;
            winImage2.hidden = YES;
            winImage1.hidden = YES;
        }
        
        
        
        timeLabel.text = _pkbetdata.bifen;
        timeLabel.textColor = [UIColor redColor];
        timeLabel.font = [UIFont boldSystemFontOfSize:8];
        
        
        
        
        
    }else{
        zhegaiview.hidden = YES;
        winImage1.hidden= YES;
        winImage2.hidden = YES;
        winImage3.hidden = YES;
        timeLabel.text = [NSString stringWithFormat:@"%@ %@", _pkbetdata.date, _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
        timeLabel.font = [UIFont systemFontOfSize:8];
    }
    
}




//}

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
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 66)];
#ifdef isCaiPiaoForIPad
    view.frame = CGRectMake(0, 0, 390, 66);
#endif
    view.backgroundColor = [UIColor clearColor];
    
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
    changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    changhaola.font  = [UIFont systemFontOfSize:9];
    [headimage addSubview:changhaola];
    
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 49, 13)];
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor blackColor];
    [headimage addSubview:eventLabel];
    
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 49, 10)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:8];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headimage addSubview:timeLabel];
    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 90, 14)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    
    
    //    UILabel * vslabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 69, 14)];
    //    vslabel.textAlignment = NSTextAlignmentCenter;
    //    vslabel.font = [UIFont systemFontOfSize:14];
    //    vslabel.backgroundColor = [UIColor clearColor];
    //    vslabel.text = @"vs";
    //    vslabel.textColor = [UIColor redColor];
    
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
    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 90, 14)];
    butLabel1.textAlignment = NSTextAlignmentCenter;
    butLabel1.backgroundColor = [UIColor clearColor];
    butLabel1.font = [UIFont systemFontOfSize:14];
    
    //第二个button上的小数字
    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 69, 14)];
    butLabel2.textAlignment = NSTextAlignmentCenter;
    butLabel2.backgroundColor = [UIColor clearColor];
    butLabel2.font = [UIFont systemFontOfSize:14];
    
    //第三个button上的小数字
    butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 91, 14)];
    butLabel3.textAlignment = NSTextAlignmentCenter;
    butLabel3.backgroundColor = [UIColor clearColor];
    butLabel3.font = [UIFont systemFontOfSize:14];
    
    //第一个按钮
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame = CGRectMake(57, 0, 90, 50);
    button1.tag = 3;
    [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第二个按钮
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button2.frame = CGRectMake(147, 0, 69, 50);
    button2.tag = 1;
    [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pressButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第三个按钮
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button3.frame = CGRectMake(216, 0, 91, 50);
    button3.tag = 0;
    [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pressButtonthree:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //按钮上显示3
    datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    datal1.text = @"3";
    datal1.font = [UIFont systemFontOfSize:15];
    datal1.textAlignment = NSTextAlignmentRight;
    datal1.backgroundColor = [UIColor clearColor];
    datal1.textColor = [UIColor blackColor];
    
    //按钮上显示1
    datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    datal2.text = @"1";
    datal2.font = [UIFont systemFontOfSize:15];
    datal2.textAlignment = NSTextAlignmentRight;
    datal2.backgroundColor = [UIColor clearColor];
    datal2.textColor = [UIColor blackColor];
    
    //按钮上显示0
    datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    datal3.text = @"0";
    datal3.font = [UIFont systemFontOfSize:15];
    datal3.textAlignment = NSTextAlignmentRight;
    datal3.backgroundColor = [UIColor clearColor];
    datal3.textColor = [UIColor blackColor];
    
    xibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xibutton.frame = CGRectMake(275, 0, 60, 66);
    
    //  [xibutton setImage:UIImageGetImageFromName(@"gc_xl_12.png") forState:UIControlStateNormal];
    [xibutton addTarget:self action:@selector(pressxibutton:) forControlEvents:UIControlEventTouchUpInside];
    bgimagevv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
    
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
    
    
    dan = [UIButton buttonWithType:UIButtonTypeCustom];
    dan.hidden = YES;
    dan.frame = CGRectMake(270, 36, 0, 0);
    [dan addTarget:self action:@selector(pressdandown:) forControlEvents:UIControlEventTouchDown];
    [dan addTarget:self action:@selector(pressDan:) forControlEvents:UIControlEventTouchUpInside];
    danimge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_09.png");
    [dan addSubview:danimge];
    danzi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    danzi.text = @"胆";
    danzi.font = [UIFont systemFontOfSize:12];
    danzi.textColor = [UIColor blackColor];
    danzi.textAlignment = NSTextAlignmentCenter;
    danzi.backgroundColor = [UIColor clearColor];
    [dan addSubview:danzi];
    
    
    
    
    
    
    
    [button1 addSubview:homeduiLabel];
    [button3 addSubview:keduiLabel];
    [button2 addSubview:vsImage];
    [vsImage release];
    [button1 addSubview:butLabel1];
    [button2 addSubview:butLabel2];
    [button3 addSubview:butLabel3];
    winImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
    winImage1.backgroundColor = [UIColor clearColor];
    winImage1.hidden = YES;
    winImage1.image=  UIImageGetImageFromName(@"winImage.png");
    [button1 addSubview:winImage1];
    [winImage1 release];
    
    winImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
    winImage2.backgroundColor = [UIColor clearColor];
    winImage2.hidden = YES;
    winImage2.image = UIImageGetImageFromName(@"winImage.png");
    [button2 addSubview:winImage2];
    [winImage2 release];
    
    winImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
    winImage3.backgroundColor = [UIColor clearColor];
    winImage3.hidden = YES;
    winImage3.image = UIImageGetImageFromName(@"winImage.png");
    [button3 addSubview:winImage3];
    [winImage3 release];
    [view addSubview:button1];
    [view addSubview:button2];
    [view addSubview:button3];
    
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(59, 0, 251, 50);
    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
    //    [zhegaiview release];
    
    
    
    //    [vslabel release];
    
    
    [view addSubview:dan];
    [view addSubview:xibutton];
    
#ifdef isCaiPiaoForIPad
    //    zhegaiview.frame = CGRectMake(59+35, 0, 251, 50);
    bgimagevv.frame = CGRectMake(20, 0, 30, 31);
    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
#endif
    
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
    // NSLog(@"count  =  %d", count);
    if (!selection1) {
        
        if (danTuoBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            return;
        }
        
        [button1 setImage:UIImageGetImageFromName(@"zucaizuo_1.png") forState:UIControlStateNormal];
        // buttonImage.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        butLabel1.textColor = [UIColor whiteColor];
        //        homeduiLabel.textColor = [UIColor whiteColor];
        datal1.textColor = [UIColor whiteColor];
        butLabel1.font = [UIFont boldSystemFontOfSize:14];
        selection1 = YES;
    }else{
        [button1 setImage:UIImageGetImageFromName(@"zucaizuo.png") forState:UIControlStateNormal];
        //   buttonImage.image = UIImageGetImageFromName(@"gc_xxx.png");
        //   [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        datal1.textColor = [UIColor blackColor];
        homeduiLabel.textColor = [UIColor blackColor];
        butLabel1.textColor = [UIColor blackColor];
        butLabel1.font = [UIFont systemFontOfSize:14];
        selection1 = NO;
        
    }
    if (renjiubool) {
        if (selection1 || selection2 || selection3) {
            dan.hidden = NO;
            boldan = YES;
        }else{
            dan.hidden = YES;
            boldan = NO;
        }
    }
    
    
    
    
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
}

//第二个按钮的触发函数
- (void)pressButtonTwo:(UIButton *)button{
    NSLog(@"button 1111111111");
    if (!selection2) {
        if (danTuoBool) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            return;
        }
        [button2 setImage:UIImageGetImageFromName(@"zucaizhong_1.png") forState:UIControlStateNormal];
        //    buttonImage2.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        butLabel2.textColor = [UIColor whiteColor];
        datal2.textColor = [UIColor whiteColor];
        butLabel2.font = [UIFont boldSystemFontOfSize:14];
        vsImage.hidden = YES;
        selection2 = YES;
    }else{
        [button2 setImage:UIImageGetImageFromName(@"zucaizhong.png") forState:UIControlStateNormal];
        // buttonImage2.image = UIImageGetImageFromName(@"gc_xxx.png");
        datal2.textColor = [UIColor blackColor];
        butLabel2.textColor = [UIColor blackColor];
        butLabel2.font = [UIFont systemFontOfSize:14];
        selection2 = NO;
        vsImage.hidden = NO;
    }
    if (renjiubool) {
        if (selection1 || selection2 || selection3) {
            dan.hidden = NO;
            boldan = YES;
        }else{
            dan.hidden = YES;
            boldan = NO;
        }
        
    }
    
    
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
}

//第三个按钮的触发函数
- (void)pressButtonthree:(UIButton *)button{
    NSLog(@"button 00000000000");
    if (!selection3) {
        if (danTuoBool) {
            
            //            胆拖投注已截期，不可进行投注九场以上的比赛
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此投注方式已截期，建议选择9场进行复式投注"];
            
            
            
            return;
        }
        [button3 setImage:UIImageGetImageFromName(@"zucaiyou_1.png") forState:UIControlStateNormal];
        //    buttonImage3.image = UIImageGetImageFromName(@"gc_betbtn2_0.png");
        butLabel3.textColor = [UIColor whiteColor];
        //        keduiLabel.textColor = [UIColor whiteColor];
        datal3.textColor = [UIColor whiteColor];
        
        butLabel3.font = [UIFont boldSystemFontOfSize:14];
        selection3 = YES;
    }else{
        [button3 setImage:UIImageGetImageFromName(@"zucaiyou.png") forState:UIControlStateNormal];
        //   buttonImage3.image = UIImageGetImageFromName(@"gc_xxx.png");
        datal3.textColor = [UIColor blackColor];
        keduiLabel.textColor = [UIColor blackColor];
        butLabel3.textColor = [UIColor blackColor];
        butLabel3.font = [UIFont systemFontOfSize:14];
        selection3 = NO;
    }
    if (renjiubool) {
        if (selection1 || selection2 || selection3) {
            dan.hidden = NO;
            boldan = YES;
        }else{
            dan.hidden = YES;
            boldan = NO;
        }
    }
    
    
    
    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:dandan];
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

- (void)dealloc{
    [changhaola release];
    [danimge release];
    [danzi release];
    [matcinfo release];
    
    
    [datal1 release];
    [datal2 release];
    [datal3 release];
    [view release];
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
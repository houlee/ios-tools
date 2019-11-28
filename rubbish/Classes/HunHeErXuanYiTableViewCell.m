//
//  HunHeErXuanYiTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-7-6.
//
//

#import "HunHeErXuanYiTableViewCell.h"
#import "NewAroundViewController.h"

@implementation HunHeErXuanYiTableViewCell

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
@synthesize panduan, XIDANImageView, butTitle;
//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

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
    
    eventLabel.text = _pkbetdata.event;
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
    
//    changhaola.text = _pkbetdata.bdnum;
    if ([_pkbetdata.numzhou length] >= 5) {
        changhaola.text = [_pkbetdata.numzhou substringWithRange:NSMakeRange(2, 3)];
    }else{
        changhaola.text = @"";
    }
   
    self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
    
    
    timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
    
    
    //    if ([_pkbetdata.but1 length] > 4) {
    //        butLabel1.text = [NSString stringWithFormat:@"%@", _pkbetdata.but1 ];
    //    }else{
    //        butLabel1.text = _pkbetdata.but1;
    //    }
    //    if ([_pkbetdata.but2 length] > 4) {
    //        butLabel2.text = [NSString stringWithFormat:@"%@", _pkbetdata.but2 ];
    //    }else{
    //        butLabel2.text = _pkbetdata.but2;
    //    }
    //    if ([_pkbetdata.but3 length] > 4) {
    //        butLabel3.text = [NSString stringWithFormat:@"%@", _pkbetdata.but3 ];
    //    }else{
    //        butLabel3.text = _pkbetdata.but3;
    //    }
//    if ( _pkbetdata.but1) {
//        butLabel1.text = [NSString stringWithFormat:@"%@", _pkbetdata.but1 ];
//    }else{
//        butLabel1.text = @"";
//    }
//    if (_pkbetdata.but2) {
//        butLabel2.text = [NSString stringWithFormat:@"%@", _pkbetdata.but2];
//    }else{
//        butLabel2.text = @"";
//    }
//    if (_pkbetdata.but3) {
//        butLabel3.text = [NSString stringWithFormat:@"%@", _pkbetdata.but3];
//    }else{
//        butLabel3.text = @"";
//    }
    
    
    //    if ([_pkbetdata.but1 isEqualToString:@"-"]) {
    //        button1.enabled = NO;
    //    }else{
    //        button1.enabled = YES;
    //    }
    //    if ([_pkbetdata.but2 isEqualToString:@"-"]) {
    //        button2.enabled = NO;
    //    }else{
    //        button2.enabled = YES;
    //    }
    //    if ([_pkbetdata.but3 isEqualToString:@"-"]) {
    //        button3.enabled = NO;
    //    }else{
    //        button3.enabled = YES;
    //    }
   

    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count] < 3) {
        teamarray = [NSArray arrayWithObjects:@"", @"", @"", nil];
    }
    homeduiLabel.text = [teamarray objectAtIndex:0];
    keduiLabel.text = [teamarray objectAtIndex:1];
    NSString * rangqiuString = @"";
    if ([teamarray count] > 2) {
        rangqiuString = [teamarray objectAtIndex:2];
    }
    
    
//    if (_pkbetdata.dandan) {
//        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
//        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//        btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
//        
//    }else{
//        
//        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
//        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
//    }
    if ([rangqiuString intValue] > 0) {
        
        if ([pkbetdata.oupeiarr count] > 3) {
            butLabel1.text = [pkbetdata.oupeiarr objectAtIndex:3];
        }
        if ([pkbetdata.oupeiarr count] > 2) {
            butLabel2.text = [pkbetdata.oupeiarr objectAtIndex:2];
        }
        noLableOne.text = @"不败";
        noLableTwo.text = @"胜";
        
    }else{
        
        if ([pkbetdata.oupeiarr count] > 0) {
            butLabel1.text = [pkbetdata.oupeiarr objectAtIndex:0];
        }
        if ([pkbetdata.oupeiarr count] > 5) {
            butLabel2.text = [pkbetdata.oupeiarr objectAtIndex:5];
        }
        noLableOne.text = @"胜";
        noLableTwo.text = @"不败";
        
    }
    
//    if ([[teamarray objectAtIndex:2] intValue] == 0) {
//        rangqiulabel.text = @"";
//        butLabel1.frame=  button1.bounds;
    
//    }else{
//        rangqiulabel.text = [NSString stringWithFormat:@"(%d)", [[teamarray objectAtIndex:2] intValue] ];
//        CGSize labelSize = [butLabel1.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
//        CGSize rangSize = [rangqiulabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
//        
//        
//        butLabel1.frame = CGRectMake((button1.frame.size.width - labelSize.width - rangSize.width)/2, 0, labelSize.width, 50.5);
//        rangqiulabel.frame = CGRectMake(butLabel1.frame.origin.x+butLabel1.frame.size.width, 17, rangSize.width, 20);
//    }
    
    
    
    vsImage.hidden = NO;
    
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
    
    
    selection1 = _pkbetdata.selection1;
    selection2 = _pkbetdata.selection2;
    selection3 = _pkbetdata.selection3;
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    donghua = _pkbetdata.donghuarow;
    
    UIImageView * selectImage = (UIImageView *)[button1 viewWithTag:12];
    UIImageView * danSelectImage = (UIImageView *)[button1 viewWithTag:13];
    
    if (_pkbetdata.selection1) {
        
        
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        butLabel1.textColor = [UIColor whiteColor];
         noLableOne.textColor = [UIColor whiteColor];
//        rangqiulabel.textColor = [UIColor whiteColor];
        
    }
    else {
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel1.textColor = [UIColor blackColor];
         noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
//        rangqiulabel.textColor = [UIColor redColor];
    }
    
    UIImageView * selectImage2 = (UIImageView *)[button2 viewWithTag:12];
    UIImageView * danSelectImage2 = (UIImageView *)[button2 viewWithTag:13];
    if (_pkbetdata.selection2) {
        
        if (panduan) {
            selectImage2.hidden = YES;
            danSelectImage2.hidden = NO;
        }else{
            selectImage2.hidden = NO;
            danSelectImage2.hidden = YES;
        }
        butLabel2.textColor = [UIColor whiteColor];
        noLableTwo.textColor = [UIColor whiteColor];
        
    }
    else {
        
        
        butLabel2.textColor = [UIColor blackColor];
        noLableTwo.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        selectImage2.hidden = YES;
        danSelectImage2.hidden = YES;
    }
//    UIImageView * selectImage3 = (UIImageView *)[button3 viewWithTag:12];
//    UIImageView * danSelectImage3 = (UIImageView *)[button3 viewWithTag:13];
//    if (_pkbetdata.selection3) {
//        
//        if (panduan) {
//            selectImage3.hidden = YES;
//            danSelectImage3.hidden = NO;
//        }else{
//            selectImage3.hidden = NO;
//            danSelectImage3.hidden = YES;
//        }
//        butLabel3.textColor = [UIColor whiteColor];
//        
//    }
//    else {
//        selectImage3.hidden = YES;
//        danSelectImage3.hidden = YES;
//        
//        butLabel3.textColor = [UIColor blackColor];
//        
//    }
    
    dan.hidden = YES;
    
    [self headShowFunc];
//    [self jianThouShowFunc];
    
    
    if (wangqibool) {
//        rangqiulabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        zhegaiview.hidden = NO;
        
        NSLog(@"caiguo = %@", _pkbetdata.caiguo);
        
        
        
        
        
        if ([_pkbetdata.caiguo rangeOfString:noLableOne.text].location != NSNotFound) {
            winImage1.hidden = NO;
            winImage2.hidden = YES;
            winImage3.hidden = YES;
            butLabel1.textColor = [UIColor redColor];
            noLableOne.textColor = [UIColor redColor];
            butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            //            rangqiulabel.textColor = [UIColor blackColor];
            butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            
            
        }else if ([_pkbetdata.caiguo rangeOfString:noLableTwo.text].location != NSNotFound) {
            winImage2.hidden = NO;
            winImage1.hidden = YES;
            winImage3.hidden = YES;
            butLabel2.textColor = [UIColor redColor];
            noLableTwo.textColor = [UIColor redColor];
            //            rangqiulabel.textColor = [UIColor redColor];
            
            butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            
            butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            
            
        }else if([_pkbetdata.caiguo isEqualToString:@"取消"]){
            winImage1.hidden = YES;
            winImage2.hidden = YES;
            winImage3.hidden = YES;
            bifenLabel.text = @"取消";
            timeLabel.text = @"";
            butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            
        }else{
            winImage1.hidden = YES;
            winImage2.hidden = YES;
            winImage3.hidden = YES;
            butLabel1.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            butLabel2.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
            butLabel3.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
        }
        
        
        if (![_pkbetdata.caiguo isEqualToString:@"取消"]) {
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]) {
                NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
                
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
            
        }
        
        vsImage.hidden = YES;
        bifenLabel.hidden = NO;
        //        rangqiulabel.hidden = YES;
        
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        bifenLabel.hidden = NO;
        
    }else{
        bifenLabel.hidden = YES;
        if ( ![_pkbetdata.macthType isEqualToString:@"playvs"]) {
            zhegaiview.hidden = NO;
        }else{
            zhegaiview.hidden = YES;
        }
       
        winImage1.hidden= YES;
        winImage2.hidden = YES;
        winImage3.hidden = YES;
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
    }

  
    [self playVsTypeFunc];
    
    
    
    
}

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
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
    vsImage.hidden = YES;
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 91, 14)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    
    
    
    
    //第一个button上的小数字
    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 82, 51)];
    butLabel1.textAlignment = NSTextAlignmentCenter;
    butLabel1.backgroundColor = [UIColor clearColor];
    butLabel1.font = [UIFont systemFontOfSize:14];
    
    //第二个button上的小数字
    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(125.5-82, 0, 82, 51)];
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
    button1.frame = CGRectMake(0.5, 0, 125.5, 51);
    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    UIView * linebutton = [[UIView alloc] initWithFrame:CGRectMake(126, 0, 0.5, 51)];
    linebutton.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    
    //第二个按钮
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(126.5, 0, 125.5, 51);
    [button2 addTarget:self action:@selector(pressButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(126.5+125.5, 0, 0.5, 51)];
    linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //第三个按钮
//    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button3.frame = CGRectMake(174, 0, 82, 50.5);
//    [button3 addTarget:self action:@selector(pressButtonthree:) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
//    [button2 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
//    [button3 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    for (int i = 0; i < 2; i++) {
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
        
        UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(82 - 5 - 7, (50.5 - 7)/2+1, 7, 7)];
        jiantou.tag =  1000;
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.hidden = YES;
        jiantou.image = UIImageGetImageFromName(@"gc_shang.png");
        
        
        UIImageView * jiantou2 = [[UIImageView alloc] initWithFrame:CGRectMake(82 - 5 - 7, (50.5 - 7)/2+1, 7, 7)];
        jiantou2.backgroundColor = [UIColor clearColor];
        jiantou2.tag = 1001;
        jiantou2.image = UIImageGetImageFromName(@"gc_xiangxia.png");
        jiantou2.hidden = YES;
        
        UIImageView * jiantou3 = [[UIImageView alloc] initWithFrame:CGRectMake(82 - 5 - 7, (50.5 - 7)/2+1, 7, 7)];
        jiantou3.backgroundColor = [UIColor clearColor];
        jiantou3.tag = 1002;
        jiantou3.hidden = YES;
        jiantou3.image = UIImageGetImageFromName(@"baijiantous.png");
        
        
        UIImageView * jiantou4 = [[UIImageView alloc] initWithFrame:CGRectMake(82 - 5 - 7, (50.5 - 7)/2+1, 7, 7)];
        jiantou4.backgroundColor = [UIColor clearColor];
        jiantou4.tag =  1003;
        jiantou4.hidden = YES;
        jiantou4.image = UIImageGetImageFromName(@"baijiantoux.png");
        
        
        if (i == 0) {
            [button1 addSubview:bgimage];
            [bgimage release];
            [button1 addSubview:bgimage2];
            [bgimage2 release];
            [button1 addSubview:jiantou];
            [jiantou release];
            [button1 addSubview:jiantou2];
            [jiantou2 release];
            [button1 addSubview:jiantou3];
            [jiantou3 release];
            [button1 addSubview:jiantou4];
            [jiantou4 release];
            
        }else if (i == 1){
            [button2 addSubview:bgimage];
            [bgimage release];
            [button2 addSubview:bgimage2];
            [bgimage2 release];
            [button2 addSubview:jiantou];
            [jiantou release];
            [button2 addSubview:jiantou2];
            [jiantou2 release];
            [button2 addSubview:jiantou3];
            [jiantou3 release];
            [button2 addSubview:jiantou4];
            [jiantou4 release];
            
        }
        
        
    }
    
    noLableOne = [[UILabel alloc] initWithFrame:CGRectMake(82, (50.5- 16)/2.0, 30, 16)];
    noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    noLableOne.backgroundColor = [UIColor clearColor];
//    noLableOne.tag = tagInt*10;
    noLableOne.font = [UIFont fontWithName:@"TRENDS" size:13];//@"时尚中黑简体" Academy Engraved LET
    [button1 addSubview:noLableOne];
    [noLableOne release];
    
    noLableTwo = [[UILabel alloc] initWithFrame:CGRectMake(22, (50.5- 16)/2.0, 30, 16)];
    noLableTwo.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    noLableTwo.backgroundColor = [UIColor clearColor];
    //    noLableOne.tag = tagInt*10;
    noLableTwo.font = [UIFont fontWithName:@"TRENDS" size:13];//@"时尚中黑简体" Academy Engraved LET
    [button2 addSubview:noLableTwo];
    [noLableTwo release];
    
    
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
//    [button3 addSubview:butLabel3];
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
    
//    winImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
//    winImage3.backgroundColor = [UIColor clearColor];
//    winImage3.hidden = YES;
//    winImage3.image = UIImageGetImageFromName(@"winImage.png");
//    [button3 addSubview:winImage3];
//    [winImage3 release];
    
    
//    [view addSubview:dan];
    
    [view addSubview:button1];
    [view addSubview:button2];
    [view addSubview:linebutton];
    [linebutton release];
    [view addSubview:linebutton2];
    [linebutton2 release];
//    [view addSubview:button3];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20, 14)];
    bifenLabel.textAlignment = NSTextAlignmentCenter;
    bifenLabel.font = [UIFont boldSystemFontOfSize:14];
    bifenLabel.backgroundColor = [UIColor clearColor];
    bifenLabel.textColor = [UIColor blackColor];
    bifenLabel.hidden = YES;
    [headimage addSubview:bifenLabel];
    [bifenLabel release];
    
    XIDANImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 252.5, 0, 56, 51)];
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
    
    
//    butLabel1.frame = CGRectMake(0, 0, 82, 50.5);
//    butLabel2.frame = CGRectMake(0, 0, 82, 50.5);
//    butLabel3.frame = CGRectMake(0, 0, 82, 50.5);
    
    
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
    //
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

- (void)pressdandown:(UIButton *)sender{
    danimge.image = UIImageGetImageFromName(@"gc_dan_xl_03.png");
}
- (void)TouchCancel{
    
    
}

- (void)TouchDragExit{
    
}
- (void)presszhegaiviewButton:(UIButton *)sender{
    
}



- (void)pressDan:(UIButton *)sender{
    NSLog(@"dan");
    NSLog(@"nengyong = %d", nengyong);
    
    
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
    [self returnBoolDan:dbool row:row];
}

- (void)touchxibutton:(UIButton *)sender{
    
    
}
- (void)pressxibutton:(UIButton *)sender{
    NSLog(@"xi");
    [self returncellrownum:row];
    
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
         noLableOne.textColor = [UIColor whiteColor];
//        rangqiulabel.textColor = [UIColor whiteColor];
        //        butLabel1.font = [UIFont boldSystemFontOfSize:14];
        
        
        selection1 = YES;
        
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        butLabel1.textColor = [UIColor blackColor];
         noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
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
        if (panduan) {
            selectImage.hidden = YES;
            danSelectImage.hidden = NO;
        }else{
            selectImage.hidden = NO;
            danSelectImage.hidden = YES;
        }
        
        butLabel2.textColor = [UIColor whiteColor];
        noLableTwo.textColor = [UIColor whiteColor];
        //         butLabel2.font = [UIFont boldSystemFontOfSize:14];
        vsImage.hidden = YES;
        selection2 = YES;
        
    }else{
        
        selectImage.hidden = YES;
        danSelectImage.hidden = YES;
        
        butLabel2.textColor = [UIColor blackColor];
        noLableTwo.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
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


- (void)returncellrownum:(NSIndexPath *)num{
    if ([delegate respondsToSelector:@selector(returncellrownum:)]) {
        [delegate returncellrownum:num];
    }
    //    NSLog(@"num = %d", num);
}

- (void)returnBoolDan:(BOOL)danbool row:(NSIndexPath *)num{
    
}

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnCellInfo:buttonBoll1:buttonBoll:buttonBoll:dan:)]) {
        [delegate returnCellInfo:index buttonBoll1:select1 buttonBoll:select2 buttonBoll:select3 dan:boldan ];
        // NSLog(@"index = %d", index);
    }
    //    NSLog(@"deleaaaaaaaaaaaaaaaa");
    
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
- (void)dealloc{
    [changhaola release];
    //    [row release];
    //    [count release];
    //    [sjImageView release];
    //    [sjImageView2 release];
    //    [sjImageView3 release];
    [danzi release];
    [danimge release];
    [matcinfo release];
    
    
    
    //    [view release];
    [eventLabel release];
    
    [timeLabel release];
    [teamLabel release];
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
//
//  BasketballTwoButtonCell.m
//  caibo
//
//  Created by houchenguang on 14-7-8.
//
//

#import "BasketballTwoButtonCell.h"
#import "caiboAppDelegate.h"
#import "SharedDefine.h"
#import "SharedMethod.h"

@implementation BasketballTwoButtonCell

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
@synthesize panduan, XIDANImageView, butTitle, typeButtonArray;

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

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        
        [delegate returnbifenCellInfo:index shuzu:bufshuzu dan:booldan];
    }
    
}

- (void)sleepfunc{
    
    [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:boldan];
}

- (NSInteger)typeCell{
    return typeCell;
}

- (void)setTypeCell:(NSInteger)_typeCell{
    typeCell = _typeCell;
    
    
    if (typeCell == 1) {
        noLableOne.text = @"⒊}";
        noLableTwo.text = @"⒊{";
    }else if (typeCell == 2){
        noLableOne.text = @"⒊}";
        noLableTwo.text = @"⒊{";
    }else if (typeCell == 3){
        noLableOne.text = @"⒌";
        noLableTwo.text = @"⒍";
    }else if(typeCell == 4){
        noLableOne.text = @"⒋{";
        noLableTwo.text = @"⒊{";
    
    }else{
        noLableOne.text = @"";
        noLableTwo.text = @"";
    
    }
    
    
}
//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

- (void)headShowFunc{
    
    if (panduan) {
        changhaoImage.hidden = YES;
        seletChanghaoImage.hidden =  NO;
//        changhaola.textColor  = [UIColor whiteColor];
    }else{
        seletChanghaoImage.hidden = YES;
        changhaoImage.hidden = NO;
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
}


- (void)setPkbetdata:(GC_BetData *)_pkbetdata{
    if (pkbetdata != _pkbetdata) {
        [pkbetdata release];
        pkbetdata = [_pkbetdata retain];
    }
    selection1 = _pkbetdata.selection1;
    selection2 = _pkbetdata.selection2;
    selection3 = _pkbetdata.selection3;
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    donghua = _pkbetdata.donghuarow;
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
    
    

    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count ] > 1) {
        homeduiLabel.text = [teamarray objectAtIndex:0];
        keduiLabel.text = [teamarray objectAtIndex:1];
    }else{
        teamarray = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
    
//    NSString * rangqiuString = @"";
//    if ([teamarray count] > 2) {
//        rangqiuString = [teamarray objectAtIndex:2];
//    }
    
    


    if (typeCell == 4) {
        rangqiulabel.text = @"";
        butLabel1.textColor = [UIColor whiteColor];
        butLabel2.textColor = [UIColor whiteColor];
       
        
        if ([pkbetdata.bufshuarr count] < 12) {
            pkbetdata.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0", nil];
        }
        
        self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr] ;
        
        NSArray * caiguo = [NSArray arrayWithObjects:@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",@"1-5", @"6-10", @"11-15", @"16-20", @"21-25", @"26+",  nil];
        
        NSString * keshengString = @"";
        NSString * zhushengString = @"";
        NSInteger keshengCount = 0;
        NSInteger zhushengCount = 0;
        
        for (int i = 0; i < [self.typeButtonArray count]; i++) {
            
            if ([[self.typeButtonArray objectAtIndex:i] isEqualToString:@"1"]) {
                if (i < 6) {
                    if (keshengCount < 2) {
                         keshengString = [NSString stringWithFormat:@"%@%@,", keshengString, [caiguo objectAtIndex:i]];
                    }
                    keshengCount +=1;
                    
                }else{
                    if (zhushengCount < 2) {
                        zhushengString = [NSString stringWithFormat:@"%@%@,", zhushengString, [caiguo objectAtIndex:i]];
                    }
                    zhushengCount +=1;
                }
                
            }
            
            
        }
        
        if ([zhushengString length] > 0) {
            zhushengString = [zhushengString substringToIndex:[zhushengString length] - 1];
        }
        if ([keshengString length] > 0) {
            keshengString = [keshengString substringToIndex:[keshengString length] - 1];
        }
        
        butLabel1.text = keshengString;
        butLabel2.text = zhushengString;
        
        UIImageView * selectBG = (UIImageView *)[button1 viewWithTag:12];
        UIImageView * danselectBG = (UIImageView *)[button1 viewWithTag:13];
        UIImageView * selectBGTwo = (UIImageView *)[button2 viewWithTag:12];
        UIImageView * danselectBGTwo = (UIImageView *)[button2 viewWithTag:13];
        
        if ([keshengString length] > 0) {
//            keshengString = [keshengString substringToIndex:[keshengString length]-1];
            CGSize labelSize = [noLableOne.text sizeWithFont:noLableOne.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            CGSize rangSize = [butLabel1.text sizeWithFont:butLabel1.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            
            noLableOne.frame = CGRectMake((button1.frame.size.width - labelSize.width - rangSize.width - 5)/2, 0, labelSize.width, 50.5);
            butLabel1.frame = CGRectMake(noLableOne.frame.origin.x + noLableOne.frame.size.width + 5, 0, rangSize.width + 2, 50.5);
            
            
            if (panduan) {
                
                selectBG.hidden = YES;
                danselectBG.hidden = NO;
            }else{
                selectBG.hidden = NO;
                danselectBG.hidden = YES;
            }
            noLableOne.textColor = [UIColor whiteColor];
            butLabel1.textColor = [UIColor whiteColor];
            
        }else{
            selectBG.hidden = YES;
            danselectBG.hidden = YES;
            noLableOne.frame = button1.bounds;
            noLableOne.textAlignment = NSTextAlignmentCenter;
            butLabel1.textColor = [UIColor blackColor];
            noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        }
        
        if ([zhushengString length] > 0) {
//            zhushengString = [zhushengString substringToIndex:[zhushengString length]-1];
            CGSize labelSize = [noLableTwo.text sizeWithFont:noLableTwo.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            CGSize rangSize = [butLabel2.text sizeWithFont:butLabel2.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
            
            noLableTwo.frame = CGRectMake((button2.frame.size.width - labelSize.width - rangSize.width - 5)/2, 0, labelSize.width, 50.5);
            butLabel2.frame = CGRectMake(noLableTwo.frame.origin.x + noLableTwo.frame.size.width + 5, 0, rangSize.width+2, 50.5);
            if (panduan) {
                
                selectBGTwo.hidden = YES;
                danselectBGTwo.hidden = NO;
            }else{
                selectBGTwo.hidden = NO;
                danselectBGTwo.hidden = YES;
            }
            noLableTwo.textColor = [UIColor whiteColor];
            butLabel2.textColor = [UIColor whiteColor];
        }else{
            selectBGTwo.hidden = YES;
            danselectBGTwo.hidden = YES;
            noLableTwo.frame = button2.bounds;
            noLableTwo.textAlignment = NSTextAlignmentCenter;
            butLabel2.textColor = [UIColor blackColor];
            noLableTwo.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        }
        
        diandianLabelOne.hidden = NO;
        diandianLabelTwo.hidden = NO;
        if (zhushengCount > 2) {
            diandianLabelTwo.hidden = NO;
        }else{
            diandianLabelTwo.hidden = YES;
        }
//
        if (keshengCount > 2) {
            diandianLabelOne.hidden = NO;
        }else{
            diandianLabelOne.hidden = YES;
        }
        
        
    }else{
        rangqiulabel.textAlignment = NSTextAlignmentCenter;
        rangqiulabel.font = [UIFont systemFontOfSize:11];
        
        butLabel1.text = [NSString stringWithFormat:@"%@", _pkbetdata.but1 ];
        butLabel2.text = [NSString stringWithFormat:@"%@", _pkbetdata.but2 ];
        if (typeCell == 1) {
            rangqiulabel.text = @"";
        }else
            if (typeCell == 2) {
                if ([[teamarray objectAtIndex:2] floatValue] == 0.0) {
                    rangqiulabel.text = @"";
                    
                    
                }else{
                    rangqiulabel.text = [NSString stringWithFormat:@"%@", [teamarray objectAtIndex:2]  ];
                    CGSize labelSize = [butLabel1.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    CGSize rangSize = [rangqiulabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    butLabel2.frame = CGRectMake(123-84 + (82 - labelSize.width - rangSize.width)/2, 0, labelSize.width + 2, 50.5);
                    rangqiulabel.frame = CGRectMake(keduiLabel.frame.origin.x+keduiLabel.frame.size.width, 12, headimage.frame.size.width - (keduiLabel.frame.origin.x+keduiLabel.frame.size.width), 20);
                    rangqiulabel.font = [UIFont systemFontOfSize:11];
                    rangqiulabel.textAlignment = 1;
                }
                
            }else
                if (typeCell == 3) {
                    if ([[teamarray objectAtIndex:2] floatValue] == 0.0) {
                        rangqiulabel.text = @"";
                        
                        
                    }else{
                        rangqiulabel.text =  [teamarray objectAtIndex:2];
                    }
                    
                    rangqiulabel.frame = CGRectMake(ORIGIN_X(button1), 0, 50, 50.5);
                    rangqiulabel.textAlignment = 1;
                    rangqiulabel.font = [UIFont systemFontOfSize:12];
                    
                    butLabel1.frame = CGRectMake(123-84 - 10, 0, 82, 50.5);
                    butLabel2.frame = CGRectMake(123-84 - 10, 0, 82, 50.5);

                }
        
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
    
    }
   
    
    
    
    
    
    
   
    
    vsImage.hidden = NO;
    
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
    
    
   
    
   

    
    dan.hidden = YES;
    
    [self headShowFunc];
 
    
    
    if (wangqibool) {

        
        
        NSLog(@"caiguo = %@", _pkbetdata.caiguo);
        
        
        
        if (typeCell == 4) {
            zhegaiview.hidden = YES;
            
            
            
            
            
            if([_pkbetdata.caiguo isEqualToString:@"取消"]){
                winImage1.hidden = YES;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                bifenLabel.text = @"取消";
                timeLabel.text = @"";
                
            }else{
                
                
                if ([_pkbetdata.caiguo rangeOfString:@"客胜"].location != NSNotFound) {
                    
                    butLabel1.text = [_pkbetdata.caiguo stringByReplacingOccurrencesOfString:@"客胜" withString:@""];
                    CGSize labelSize = [noLableOne.text sizeWithFont:noLableOne.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    CGSize rangSize = [butLabel1.text sizeWithFont:butLabel1.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    noLableOne.frame = CGRectMake((button1.frame.size.width - labelSize.width - rangSize.width - 5)/2, 0, labelSize.width, 50.5);
                    butLabel1.frame = CGRectMake(noLableOne.frame.origin.x + noLableOne.frame.size.width + 5, 0, rangSize.width + 2, 50.5);
                    noLableOne.textColor = [UIColor redColor];
                    butLabel1.textColor = [UIColor redColor];

                    
                }else{
                    butLabel1.text = @"";
                    butLabel1.textColor = [UIColor blackColor];
                    noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                }
                
                if ([_pkbetdata.caiguo rangeOfString:@"主胜"].location != NSNotFound) {
                    butLabel2.text = [_pkbetdata.caiguo stringByReplacingOccurrencesOfString:@"主胜" withString:@""];
                    CGSize labelSize = [noLableTwo.text sizeWithFont:noLableTwo.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    CGSize rangSize = [butLabel2.text sizeWithFont:butLabel2.font constrainedToSize:CGSizeMake(80, 50) lineBreakMode:NSLineBreakByWordWrapping];
                    noLableTwo.frame = CGRectMake((button2.frame.size.width - labelSize.width - rangSize.width - 5)/2, 0, labelSize.width, 50.5);
                    butLabel2.frame = CGRectMake(noLableTwo.frame.origin.x + noLableTwo.frame.size.width + 5, 0, rangSize.width + 2, 50.5);
                    noLableTwo.textColor = [UIColor redColor];
                    butLabel2.textColor = [UIColor redColor];
                }else{
                    butLabel2.text = @"";
                    butLabel2.textColor = [UIColor blackColor];
                    noLableTwo.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                }
            }
            
        }else{
            zhegaiview.hidden = NO;
            
            NSString * onecgStr = @"";
            NSString * twocgStr = @"";
            
            if (typeCell == 1) {
                onecgStr = @"主负";
                twocgStr = @"主胜";
            }else if (typeCell == 2){
                onecgStr = @"主负";
                twocgStr = @"主胜";
            }else if (typeCell == 3){
                onecgStr = @"大";
                twocgStr = @"小";
            }
            
            if ([_pkbetdata.caiguo rangeOfString:onecgStr].location != NSNotFound) {
                winImage1.hidden = NO;
                winImage2.hidden = YES;
//                winImage3.hidden = YES;
                butLabel1.textColor = [UIColor redColor];
                noLableOne.textColor = [UIColor redColor];
                butLabel2.textColor = [UIColor blackColor];
                //            rangqiulabel.textColor = [UIColor blackColor];
//                butLabel3.textColor = [UIColor blackColor];
                
                
            }else if ([_pkbetdata.caiguo rangeOfString:twocgStr].location != NSNotFound) {
                winImage2.hidden = NO;
                winImage1.hidden = YES;
//                winImage3.hidden = YES;
                butLabel2.textColor = [UIColor redColor];
                noLableTwo.textColor = [UIColor redColor];
                //            rangqiulabel.textColor = [UIColor redColor];
                
                butLabel1.textColor = [UIColor blackColor];
                
//                butLabel3.textColor = [UIColor blackColor];
                
                
            }else if([_pkbetdata.caiguo isEqualToString:@"取消"]){
                winImage1.hidden = YES;
                winImage2.hidden = YES;
                winImage3.hidden = YES;
                bifenLabel.text = @"取消";
                timeLabel.text = @"";
                
            }
        
        }
        
       
        
        
        if (![_pkbetdata.caiguo isEqualToString:@"取消"]) {
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]) {

                bifenLabel.text = _pkbetdata.bifen;
                timeLabel.text = @"完";
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
        zhegaiview.hidden = YES;
        winImage1.hidden= YES;
        winImage2.hidden = YES;
        winImage3.hidden = YES;
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
        if ( ![_pkbetdata.macthType isEqualToString:@"playvs"]) {
            zhegaiview.hidden = NO;
        }else{
            zhegaiview.hidden = YES;
        }
        
    }
    
    
    if (typeCell == 1) {//1是胜负 2是让分胜负 3是大小分 4是胜分差  显示 是否是单关
        if ([_pkbetdata.pluralString rangeOfString:@" 11,"].location != NSNotFound || [_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
 
        }else {
            
            onePluralImage.hidden = YES;
        }

    }else if (typeCell == 2){
        if ([_pkbetdata.pluralString rangeOfString:@" 12,"].location != NSNotFound || [_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
            
        }else {
            
            onePluralImage.hidden = YES;
        }
    }else if (typeCell == 3){
        if ([_pkbetdata.pluralString rangeOfString:@" 14,"].location != NSNotFound || [_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
            
        }else {
            
            onePluralImage.hidden = YES;
        }
    }else if (typeCell == 4){
        if ([_pkbetdata.pluralString rangeOfString:@" 13,"].location != NSNotFound || [_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
            
        }else {
            
            onePluralImage.hidden = YES;
        }
    
    }
    
   
    [self playVsTypeFunc];
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan cellType:(NSInteger)typec
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:type];
    if (self) {
        
        self.typeCell = typec;
        
        
        
        self.backgroundColor = [UIColor clearColor];
        
        
        self.butonScrollView.delegate = self;
        [self.butonScrollView addSubview:[self tableViewCell]];
        
        UIImageView * scrollViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(309, 3, 240, 64)];
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
        
        
        
        
        self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23+3, self.butonScrollView.frame.size.width, 71);
        
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
    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(125.5-84, 0, 82, 51)];
    butLabel1.textAlignment = NSTextAlignmentCenter;
    butLabel1.backgroundColor = [UIColor clearColor];
    butLabel1.font = [UIFont systemFontOfSize:14];
    
    //第二个button上的小数字
    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(125.5-84, 0, 82, 51)];
    butLabel2.textAlignment = NSTextAlignmentCenter;
    butLabel2.backgroundColor = [UIColor clearColor];
    butLabel2.font = [UIFont systemFontOfSize:14];
    
    //第三个button上的小数字
//    butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 91, 15)];
//    butLabel3.textAlignment = NSTextAlignmentCenter;
//    butLabel3.backgroundColor = [UIColor clearColor];
//    butLabel3.font = [UIFont systemFontOfSize:14];
    
    
    
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
//    //    [button3 setImage:UIImageGetImageFromName(@"rqspfbg.png") forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
    
    if (typeCell == 3) {
        linebutton.hidden= YES;
        
        button1.frame = CGRectMake(0, 0, 101, 51);
        button2.frame = CGRectMake(151, 0, 101, 51);
        rangqiulabel.backgroundColor = [SharedMethod getColorByHexString:@"eeeae3"];
        
        UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 51)] autorelease];
        line.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [rangqiulabel addSubview:line];
        
        UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(49.5, 0, 0.5, 51)] autorelease];
        line1.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        line1.tag = 1010110;
        [rangqiulabel addSubview:line1];
    }
    
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
            
            
        }
        
        
    }
    
    noLableOne = [[UILabel alloc] initWithFrame:CGRectMake(18, (50.5- 16)/2.0, 30, 16)];
    noLableOne.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    noLableOne.backgroundColor = [UIColor clearColor];
    //    noLableOne.tag = tagInt*10;
    noLableOne.font = [UIFont fontWithName:@"TRENDS" size:13];//@"时尚中黑简体" Academy Engraved LET
    [button1 addSubview:noLableOne];
    [noLableOne release];
    
    noLableTwo = [[UILabel alloc] initWithFrame:CGRectMake(18, (50.5- 16)/2.0, 30, 16)];
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
    
    if (typeCell == 1) {
        [button2 addSubview:rangqiulabel];
    }else if (typeCell == 2){
        [headimage addSubview:rangqiulabel];
    }else if (typeCell == 3){
        [view addSubview:rangqiulabel];
    }else if (typeCell == 4){
        [button2 addSubview:rangqiulabel];
        
//        rangqiulabel.frame = CGRectMake(18, 0, 100, 20);
        diandianLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(18, 30, 100, 20)];
        diandianLabelOne.textAlignment = NSTextAlignmentRight;
        diandianLabelOne.font = [UIFont systemFontOfSize:10];
        diandianLabelOne.backgroundColor = [UIColor clearColor];
        diandianLabelOne.textColor = [UIColor whiteColor];
        diandianLabelOne.text = @"...";
        diandianLabelOne.hidden = YES;
//        [button1 addSubview:diandianLabelOne];
        [button1 insertSubview:diandianLabelOne atIndex:1000];
        [diandianLabelOne release];
        
        diandianLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(18, 30, 100, 20)];
        diandianLabelTwo.textAlignment = NSTextAlignmentRight;
        diandianLabelTwo.font = [UIFont systemFontOfSize:10];
        diandianLabelTwo.backgroundColor = [UIColor clearColor];
        diandianLabelTwo.textColor = [UIColor whiteColor];
        diandianLabelTwo.text = @"...";
        diandianLabelTwo.hidden = YES;
        [button2 insertSubview:diandianLabelTwo atIndex:1000];
        [diandianLabelTwo release];
        
    }
    
    [rangqiulabel release];
    
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
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20+5, 14)];
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
    
    
    
    
    butTitle = [[UILabel alloc] init];
    butTitle.frame = CGRectMake(0, 51-22, 56, 20);
    butTitle.font = [UIFont systemFontOfSize:11];
    butTitle.textAlignment = NSTextAlignmentCenter;
    butTitle.textColor = [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
    butTitle.backgroundColor = [UIColor clearColor];
    [XIDANImageView addSubview:butTitle];
    [butTitle release];
    
    xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xidanButton.frame = XIDANImageView.bounds;
    [xidanButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [XIDANImageView addSubview:xidanButton];
    xidanButton.hidden = YES;
    
    [view addSubview:XIDANImageView];
//    [view bringSubviewToFront:XIDANImageView];
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
    
    keduiLabel.frame = CGRectMake(200,16, 73, 14);
    [headimage addSubview:homeduiLabel];
    [headimage addSubview:keduiLabel];
    
    
    
    [headimage addSubview:vsImage];
    
    
    xidanButton.hidden = NO;
    XIDANImageView.hidden = NO;
    
    
    winImage1.frame = CGRectMake(1, 1, 10, 10);
    winImage1.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage2.frame = CGRectMake(1, 1, 10, 10);
    winImage2.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage3.frame = CGRectMake(1, 1, 10, 10);
    winImage3.image = UIImageGetImageFromName(@"hongnew.png");
    
    
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(0, 0, 310-56, 51);
    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [view addSubview:zhegaiview];
    //    [zhegaiview release];
    //    [view addSubview:xibutton];
    
    
    UIImageView * shuImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 0.5, 95)];
    shuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    shuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:shuImage];
    [shuImage release];
    
    UIImageView * hengImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 93.5+3, 309, 1.5)];
    hengImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    hengImage.image = UIImageGetImageFromName(@"rqspfheng.png");
    [self.contentView addSubview:hengImage];
    [hengImage release];
    
    UIImageView * houshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(308.5+5.5, 3, 0.5, 95)];
    houshuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    houshuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:houshuImage];
    [houshuImage release];
    
    

    if (typeCell == 2) {
        homeduiLabel.frame = CGRectMake(75, 16, 83, 14);
        vsImage.frame = CGRectMake(164, 16, 18, 15);
        keduiLabel.frame = CGRectMake(190, 16, 73, 14);
    }
    onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 4, 4)];
    onePluralImage.hidden = YES;
    onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
    [view addSubview:onePluralImage];
    [onePluralImage release];
    
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
    
    
    if (typeCell == 4) {//胜分差
//         [self performSelector:@selector(sleepfunc) withObject:nil afterDelay:0.1];
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        if (!ballBox) {
            
            ballBox = [[SFCBoxView alloc] initWithFrame:app.window.bounds betData:self.pkbetdata wangQi:wangqibool celltype:1];
            ballBox.delegate = self;
        }
        ballBox.viewType = 1;
        ballBox.wangqiBool = wangqibool;
        ballBox.betData = self.pkbetdata;
        [app.window addSubview:ballBox];
        
        return;
    }
    
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
    
    
    if (typeCell == 4) {//胜分差
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        if (!ballBox) {
            
            ballBox = [[SFCBoxView alloc] initWithFrame:app.window.bounds betData:self.pkbetdata wangQi:wangqibool celltype:2];
            ballBox.delegate = self;
        }
        ballBox.viewType = 2;
        ballBox.wangqiBool = wangqibool;
        ballBox.betData = self.pkbetdata;
        [app.window addSubview:ballBox];
        
        return;
    }

    
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
//- (void)pressButtonthree:(UIButton *)button{
//    NSLog(@"button 00000000000");
//    if ([pkbetdata.but3 isEqualToString:@"-"]){
//        return;
//    }
//    UIImageView * selectImage = (UIImageView *)[button viewWithTag:12];
//    UIImageView * danSelectImage = (UIImageView *)[button viewWithTag:13];
//    
//    if (!selection3) {
//        
//        if (panduan) {
//            selectImage.hidden = YES;
//            danSelectImage.hidden = NO;
//        }else{
//            selectImage.hidden = NO;
//            danSelectImage.hidden = YES;
//        }
//        butLabel3.textColor = [UIColor whiteColor];
//        //         butLabel3.font = [UIFont boldSystemFontOfSize:14];
//        
//        selection3 = YES;
//        
//    }else{
//        selectImage.hidden = YES;
//        danSelectImage.hidden = YES;
//        
//        butLabel3.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//        //         butLabel3.font = [UIFont systemFontOfSize:14];
//        selection3 = NO;
//        
//    }
//    if (selection1 || selection2 || selection3) {
//        dan.hidden = NO;
//        boldan = YES;
//    }else{
//        dan.hidden = YES;
//        boldan = NO;
//        panduan = NO;
//    }
//    
//    //    [self jianThouShowFunc];
//    [self headShowFunc];
//    
//    
//    [self returnCellInfo:count buttonBoll1:selection1 buttonBoll:selection2 buttonBoll:selection3 dan:panduan];
//    
//}


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

- (void)ballBoxDelegateReturnData:(GC_BetData *)bd{
    self.pkbetdata = bd;
    [self setPkbetdata:bd];
    [self performSelector:@selector(sleepfunc) withObject:nil afterDelay:0.1];
}

- (void)dealloc{
    if (ballBox) {
        [ballBox release];
    }
    [typeButtonArray release];
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
//    [butLabel3 release];
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
//
//  BigHunTouCell.m
//  caibo
//
//  Created by houchenguang on 14-7-9.
//
//

#import "BigHunTouCell.h"
#import "caiboAppDelegate.h"

@implementation BigHunTouCell

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
//@synthesize rangqiulabel;
@synthesize panduan, XIDANImageView, butTitle, typeButtonArray,hunType;
//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

- (void)headShowFunc{
//    UIImageView * basketballImageBg1 = (UIImageView *)[button1 viewWithTag:77];
//    UIImageView * basketballImageBg2 = (UIImageView *)[button1 viewWithTag:78];
//    UIImageView * basketballImageBg3 = (UIImageView *)[button1 viewWithTag:79];
//    UIImageView * basketballImageBg4 = (UIImageView *)[button1 viewWithTag:80];
    if (panduan) {
        changhaoImage.hidden = YES;
        seletChanghaoImage.hidden =  NO;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

//        changhaola.textColor  = [UIColor whiteColor];
//        basketballImageBg1.image = UIImageGetImageFromName(@"selectHuntouzi.png");
//        basketballImageBg2.image = UIImageGetImageFromName(@"selectHuntouzi.png");
//        basketballImageBg3.image = UIImageGetImageFromName(@"selectHuntouzi.png");
//        basketballImageBg4.image = UIImageGetImageFromName(@"selectHuntouzi.png");
    }else{
        seletChanghaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        changhaoImage.hidden = NO;
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        basketballImageBg1.image = UIImageGetImageFromName(@"selectHuntoulan.png");
//        basketballImageBg2.image = UIImageGetImageFromName(@"selectHuntoulan.png");
//        basketballImageBg3.image = UIImageGetImageFromName(@"selectHuntoulan.png");
//        basketballImageBg4.image = UIImageGetImageFromName(@"selectHuntoulan.png");
    }
    
    
}

- (void)cellButtonTypeShow{//篮球大混投

//    butLabel1.text = @"胜";
//    butLabel2.text = @"让";
//    butLabel3.text = @"大小";
//    butLabel4.text = @"分差";
//    butLabel5.text = @"";
//    NSArray * bifenarr = [NSArray arrayWithObjects:@"⒊}", @"⒊{",@"⒅⒇⒊}", @"⒅⒇⒊{", @"⒌", @"⒍",@"⒊{1-5", @"⒊{6-10", @"⒊{11-15", @"⒊{16-20", @"⒊{21-25", @"⒊{26+",  @"⒋{1-5", @"⒋{6-10", @"⒋{11-15", @"⒋{16-20", @"⒋{21-25", @"⒋{26+", nil];
     NSArray * bifenarr = [NSArray arrayWithObjects:@"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+",  @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
    
    NSInteger sumCount = 0;
    NSInteger sumCountTwo = 0;
    NSInteger sumCountThree = 0;
    NSInteger sumCountFore = 0;
    butLabel1.text = @"";
    butLabel2.text = @"";
    butLabel3.text = @"";
    butLabel4.text = @"";
    //第一个
    
    NSInteger enabledShengButton = 0;
    butLabel1.text = @"";
    for (int i = 0; i < 2; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButton += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            sumCount += 1;
            butLabel1.text = [NSString stringWithFormat:@"%@%@\n", butLabel1.text, [bifenarr objectAtIndex:i]];
        }
        
    }
    
    if ([butLabel1.text length] > 1) {
        butLabel1.text = [butLabel1.text substringToIndex:[butLabel1.text length] - 1];
    }else{
        butLabel1.text = @"胜";
    }
    
   
    
    //第二个
    NSInteger enabledShengButtonTwo = 0;
    for (int i = 2; i < 4; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonTwo += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            
            sumCountTwo += 1;
            butLabel2.text = [NSString stringWithFormat:@"%@%@\n", butLabel2.text, [bifenarr objectAtIndex:i]];
        }
        
    }
    
    if ([butLabel2.text length] > 1) {
        butLabel2.text = [butLabel2.text substringToIndex:[butLabel2.text length] - 1];
    }else{
        butLabel2.text = @"让";
    }
    
   
    //第三个
    NSInteger enabledShengButtonThree = 0;
    for (int i = 4; i < 6; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonThree += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            sumCountThree += 1;
            butLabel3.text = [NSString stringWithFormat:@"%@%@\n", butLabel3.text, [bifenarr objectAtIndex:i]];
        }
        
    }
    
    if ([butLabel3.text length] > 1) {
        butLabel3.text = [butLabel3.text substringToIndex:[butLabel3.text length] - 1];
    }else{
        butLabel3.text = @"大小";
    }
    
    
    
    //第四个
    NSInteger enabledShengButtonTour = 0;
    NSInteger caicount = 0;
    for (int i = 6; i < 18; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonTour += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            sumCountFore += 1;
            if (caicount < 2) {
                butLabel4.text = [NSString stringWithFormat:@"%@%@\n", butLabel4.text, [bifenarr objectAtIndex:i]];
            }
            caicount += 1;
        }
        
    }
    UILabel * dianLabel = (UILabel *)[button1 viewWithTag:1231];
    if (caicount > 2) {
        
        dianLabel.hidden = NO;
    }else{
        dianLabel.hidden = YES;
    }
    
    if ([butLabel4.text length] > 1) {
        butLabel4.text = [butLabel4.text substringToIndex:[butLabel4.text length] - 1];
    }else{
        butLabel4.text = @"分差";
    }
    UIImageView * basketballImageBg1 = (UIImageView *)[button1 viewWithTag:77];
    UIImageView * basketballImageBg2 = (UIImageView *)[button2 viewWithTag:78];
    UIImageView * basketballImageBg3 = (UIImageView *)[button3 viewWithTag:79];
    UIImageView * basketballImageBg4 = (UIImageView *)[button4 viewWithTag:80];
    
   
    if (sumCount > 0) {
        butLabel1.textColor =  [UIColor whiteColor];
        
        
        
        
        if (panduan) {
            basketballImageBg1.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
            
        }else{
            
            basketballImageBg1.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
            
        }
    }else{
        basketballImageBg1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        
    }
    if (sumCountTwo > 0) {
        butLabel2.textColor =  [UIColor whiteColor];
        
        
        
        
        if (panduan) {
            basketballImageBg2.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
            
        }else{
            basketballImageBg2.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
            
        }
    }else{
        basketballImageBg2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        
    }
    if (sumCountThree > 0) {
        butLabel3.textColor =  [UIColor whiteColor];
        
        
        
        
        if (panduan) {
            basketballImageBg3.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
            
        }else{
            basketballImageBg3.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
            
        }
    }else{
        basketballImageBg3.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        
    }
    if (sumCountFore > 0) {
        butLabel4.textColor =  [UIColor whiteColor];
        
        
        
        
        if (panduan) {
            basketballImageBg4.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
            
        }else{
            basketballImageBg4.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
            
        }
    }else{
        basketballImageBg4.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        
    }
    UILabel * dianLabel1 = (UILabel *)[button4 viewWithTag:120];
    if (sumCountFore > 2) {
        
        dianLabel1.hidden = NO;
    }else{
        dianLabel1.hidden = YES;
    }
    
    if (enabledShengButton == 2) {//说明没有赔率 不能点击
        butLabel1.textColor = [UIColor lightGrayColor];
        button1.enabled = NO;
    }else{
        button1.enabled = YES;
    }
    if (enabledShengButtonTwo == 2) {//说明没有赔率 不能点击
        butLabel2.textColor = [UIColor lightGrayColor];
        button2.enabled = NO;
    }else {
        button2.enabled = YES;
    }
    if (enabledShengButtonThree == 2) {//说明没有赔率 不能点击
        butLabel3.textColor = [UIColor lightGrayColor];
        button3.enabled = NO;
    }else{
        button3.enabled = YES;
    }
    if (enabledShengButtonTour == 12) {//说明没有赔率 不能点击
        butLabel4.textColor = [UIColor lightGrayColor];
        button4.enabled = NO;
    }else{
        button4.enabled = YES;
    }
    
    
}

- (void)footBallButtonTypeShow{

// NSArray * bifenarr = [NSArray arrayWithObjects:@"{", @"|", @"}", @"⒅{", @"⒅|", @"⒅}",
//                       @"⑩", @"①",@"②", @"③", @"④", @"⑤", @"⑥", @"⑦+",
//                       @"①;⑩", @"②;⑩", @"②;①", @"③;⑩", @"③;①", @"③;②", @"④;⑩", @"④;①", @"④;②",@"⑤;⑩",@"⑤;①",@"⑤;②",@"胜其他",
//                       @"⑩;⑩", @"①;①", @"②;②", @"③;③",@"平其他",
//                       @"⑩;①", @"⑩;②", @"①;②", @"⑩;③", @"①;③", @"②;③", @"⑩;④", @"①;④", @"②;④",@"⑩;⑤",@"①;⑤",@"②;⑤",@"负其他", @"{{", @"{|", @"{}", @"|{", @"||", @"|}", @"}{", @"}|", @"}}", nil];
   NSArray * bifenarr = [NSArray arrayWithObjects:@"胜", @"平", @"负", @"让胜", @"让平", @"让负",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负",  nil];

    
//    @"①;⑩", @"②;⑩", @"②;①", @"③;⑩", @"③;①", @"③;②", @"④;⑩", @"④;①", @"④;②", @"胜其他", @"⑩;⑩", @"①;①", @"②;②", @"③;③", @"平其他", @"⑩;①", @"⑩;②", @"①;②", @"⑩;③", @"①;③", @"②;③", @"⑩;④", @"①;④", @"②;④",  @"负其他",
    
    butLabel1.text = @"";
    butLabel2.text = @"";
    butLabel3.text = @"";
    butLabel4.text = @"";
    butLabel5.text = @"";
//    NSInteger sumCount = 0;
    
    UILabel * oneText = (UILabel *)[button1 viewWithTag:107];
    UILabel * twoText = (UILabel *)[button2 viewWithTag:107];
    UILabel * threeText = (UILabel *)[button3 viewWithTag:107];
    UILabel * fourText = (UILabel *)[button4 viewWithTag:107];
    UILabel * fiveText = (UILabel *)[button5 viewWithTag:107];
//    if (count.row == 0) {
    
        oneText.hidden = NO;
        twoText.hidden = NO;
        threeText.hidden = NO;
        fourText.hidden = NO;
        fiveText.hidden = NO;
        if (wangqibool) {
            oneText.textColor = [UIColor lightGrayColor];
            twoText.textColor = [UIColor lightGrayColor];
            threeText.textColor = [UIColor lightGrayColor];
            fourText.textColor = [UIColor lightGrayColor];
            fiveText.textColor = [UIColor lightGrayColor];
            
        }else{
            oneText.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
            twoText.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
            threeText.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
            fourText.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
            fiveText.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
           
        }
        butLabel1.frame = CGRectMake(0, - 5, button1.frame.size.width, button1.frame.size.height);
        butLabel2.frame = CGRectMake(0, - 5, button2.frame.size.width, button2.frame.size.height);
        butLabel3.frame = CGRectMake(0, - 5, button3.frame.size.width, button3.frame.size.height);
        butLabel4.frame = CGRectMake(0, - 5, button4.frame.size.width, button4.frame.size.height);
        butLabel5.frame = CGRectMake(0, - 5, button5.frame.size.width, button5.frame.size.height);
        
//    }else{
//        oneText.hidden = YES;
//        twoText.hidden = YES;
//        threeText.hidden = YES;
//        fourText.hidden = YES;
//        fiveText.hidden = YES;
//        butLabel1.frame = button1.bounds;
//        butLabel2.frame = button2.bounds;
//        butLabel3.frame = button3.bounds;
//        butLabel4.frame = button4.bounds;
//        butLabel5.frame = button5.bounds;
//    }
    
    
    //第一个
    NSInteger caicountone =  0;
    NSInteger enabledShengButton = 0;
    butLabel1.text = @"";
    for (int i = 0; i < 3; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButton += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
//            sumCount += 1;
            if (caicountone < 2) {
                butLabel1.text = [NSString stringWithFormat:@"%@%@\n", butLabel1.text, [bifenarr objectAtIndex:i]];
            }
            caicountone +=1;
        }
        
    }
    UILabel * dianLabel1 = (UILabel *)[button1 viewWithTag:120];
    if (caicountone > 2) {
        
        dianLabel1.hidden = NO;
    }else{
        dianLabel1.hidden = YES;
    }
    
    if ([butLabel1.text length] > 1) {
        butLabel1.text = [butLabel1.text substringToIndex:[butLabel1.text length] - 1];
        butLabel1.frame = button1.bounds;
        oneText.hidden = YES;
        
    }else{
        butLabel1.text = @"胜";
        oneText.hidden = NO;
        butLabel1.frame = CGRectMake(0, - 5, button1.frame.size.width, button1.frame.size.height);
        
    }
    UIImageView * basketballImageBg1 = (UIImageView *)[button1 viewWithTag:12];
    UIImageView * basketballImageBg2 = (UIImageView *)[button1 viewWithTag:13];
    
    
    if (caicountone > 0) {
        butLabel1.textColor =  [UIColor whiteColor];
        
        
        
        if (panduan) {
            
            basketballImageBg1.hidden = YES;
            basketballImageBg2.hidden = NO;
            
        }else{
            basketballImageBg1.hidden = NO;
            basketballImageBg2.hidden = YES;
        }
    }else{
        basketballImageBg1.hidden = YES;
        basketballImageBg2.hidden = YES;
    }
    
    
    //第二个
    
    NSInteger caicounttwo =  0;
    NSInteger enabledShengButtonTwo = 0;
    for (int i = 3; i < 6; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonTwo += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            
            
            if (caicounttwo < 2) {
                butLabel2.text = [NSString stringWithFormat:@"%@%@\n", butLabel2.text, [bifenarr objectAtIndex:i]];

            }
            caicounttwo += 1;
        }
        
    }
    UILabel * dianLabel2 = (UILabel *)[button2 viewWithTag:120+1];
    if (caicounttwo > 2) {
        
        dianLabel2.hidden = NO;
    }else{
        dianLabel2.hidden = YES;
    }
    
    if ([butLabel2.text length] > 1) {
        butLabel2.text = [butLabel2.text substringToIndex:[butLabel2.text length] - 1];
        butLabel2.frame = button2.bounds;
        twoText.hidden = YES;
    }else{
        butLabel2.text = @"让";
        twoText.hidden = NO;
        butLabel2.frame = CGRectMake(0, - 5, button2.frame.size.width, button2.frame.size.height);
    }
    
    UIImageView * basketballImageBg11 = (UIImageView *)[button2 viewWithTag:12];
    UIImageView * basketballImageBg22 = (UIImageView *)[button2 viewWithTag:13];
    if (caicounttwo > 0) {
        butLabel2.textColor =  [UIColor whiteColor];
        
        
        
        if (panduan) {
            
            basketballImageBg11.hidden = YES;
            basketballImageBg22.hidden = NO;
            
        }else{
            basketballImageBg11.hidden = NO;
            basketballImageBg22.hidden = YES;
        }
    }else{
        basketballImageBg11.hidden = YES;
        basketballImageBg22.hidden = YES;
    }
    
    //第三个
    
    NSInteger caicountthree = 0;
    NSInteger enabledShengButtonThree = 0;
    for (int i = 6; i < 14; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonThree += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
           
            if (caicountthree < 2) {
                butLabel3.text = [NSString stringWithFormat:@"%@%@\n", butLabel3.text, [bifenarr objectAtIndex:i]];
            }
            caicountthree += 1;
        }
        
    }
    UILabel * dianLabel3 = (UILabel *)[button3 viewWithTag:120+2];
    if (caicountthree > 2) {
        
        dianLabel3.hidden = NO;
    }else{
        dianLabel3.hidden = YES;
    }
    if ([butLabel3.text length] > 1) {
        butLabel3.text = [butLabel3.text substringToIndex:[butLabel3.text length] - 1];
        butLabel3.frame = button3.bounds;
        threeText.hidden = YES;
    }else{
        butLabel3.text = @"总";
        threeText.hidden = NO;
        butLabel3.frame = CGRectMake(0, - 5, button3.frame.size.width, button3.frame.size.height);
    }
    UIImageView * basketballImageBg13 = (UIImageView *)[button3 viewWithTag:12];
    UIImageView * basketballImageBg23 = (UIImageView *)[button3 viewWithTag:13];
    if (caicountthree > 0) {
        butLabel3.textColor =  [UIColor whiteColor];
        
        
        
        if (panduan) {
            
            basketballImageBg13.hidden = YES;
            basketballImageBg23.hidden = NO;
            
        }else{
            basketballImageBg13.hidden = NO;
            basketballImageBg23.hidden = YES;
        }
    }else{
        basketballImageBg13.hidden = YES;
        basketballImageBg23.hidden = YES;
    }
    
    //第四个
    NSInteger enabledShengButtonTour = 0;
    NSInteger caicount = 0;
    for (int i = 14; i < 45; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonTour += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
           
            if (caicount < 2) {
                butLabel4.text = [NSString stringWithFormat:@"%@%@\n", butLabel4.text, [bifenarr objectAtIndex:i]];
            }
            caicount += 1;
        }
        
    }
    UILabel * dianLabel4 = (UILabel *)[button4 viewWithTag:120+3];
    if (caicount > 2) {
        
        dianLabel4.hidden = NO;
    }else{
        dianLabel4.hidden = YES;
    }
    
    if ([butLabel4.text length] > 1) {
        butLabel4.text = [butLabel4.text substringToIndex:[butLabel4.text length] - 1];
        butLabel4.frame = button4.bounds;
        fourText.hidden = YES;
    }else{
        butLabel4.text = @"分";
        fourText.hidden = NO;
        butLabel4.frame = CGRectMake(0, - 5, button4.frame.size.width, button4.frame.size.height);
    }
    UIImageView * basketballImageBg14 = (UIImageView *)[button4 viewWithTag:12];
    UIImageView * basketballImageBg24 = (UIImageView *)[button4 viewWithTag:13];
    if (caicount > 0) {
        butLabel4.textColor =  [UIColor whiteColor];
        
        
        
        if (panduan) {
            
            basketballImageBg14.hidden = YES;
            basketballImageBg24.hidden = NO;
            
        }else{
            basketballImageBg14.hidden = NO;
            basketballImageBg24.hidden = YES;
        }
    }else{
        basketballImageBg14.hidden = YES;
        basketballImageBg24.hidden = YES;
    }
    
    //第五个
    NSInteger enabledShengButtonFive = 0;
    NSInteger caicountFive = 0;
    for (int i = 45; i < 54; i++) {
        if ([pkbetdata.oupeiarr count] > i) {
            if ([pkbetdata.oupeiarr objectAtIndex:i]) {
                if ([[pkbetdata.oupeiarr objectAtIndex:i] isEqualToString:@"-"]) {
                    enabledShengButtonFive += 1;
                }
            }
        }
        
        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
            
            if (caicountFive < 2) {
                butLabel5.text = [NSString stringWithFormat:@"%@%@\n", butLabel5.text, [bifenarr objectAtIndex:i]];
            }
            caicountFive += 1;
        }
        
    }

    UILabel * dianLabel5 = (UILabel *)[button5 viewWithTag:120+4];
    if (caicountFive > 2) {
        
        dianLabel5.hidden = NO;
    }else{
        dianLabel5.hidden = YES;
    }
    
    if ([butLabel5.text length] > 1) {
        butLabel5.text = [butLabel5.text substringToIndex:[butLabel5.text length] - 1];
        butLabel5.frame = button5.bounds;
        fiveText.hidden = YES;
    }else{
        butLabel5.text = @"半";
        butLabel5.frame = CGRectMake(0, - 5, button5.frame.size.width, button5.frame.size.height);
        fiveText.hidden = NO;
    }
    UIImageView * basketballImageBg15 = (UIImageView *)[button5 viewWithTag:12];
    UIImageView * basketballImageBg25 = (UIImageView *)[button5 viewWithTag:13];
    if (caicountFive > 0) {
        butLabel5.textColor =  [UIColor whiteColor];
        
        
        
        if (panduan) {
            
            basketballImageBg15.hidden = YES;
            basketballImageBg25.hidden = NO;
            
        }else{
            basketballImageBg15.hidden = NO;
            basketballImageBg25.hidden = YES;
        }
    }else{
        basketballImageBg15.hidden = YES;
        basketballImageBg25.hidden = YES;
    }
    
    
    if (enabledShengButton == 3) {//说明没有赔率 不能点击
        butLabel1.textColor = [UIColor lightGrayColor];
        oneText.textColor = [UIColor lightGrayColor];
        button1.enabled = NO;
    }else{
        button1.enabled = YES;
    }
    if (enabledShengButtonTwo == 3) {//说明没有赔率 不能点击
        butLabel2.textColor = [UIColor lightGrayColor];
        twoText.textColor = [UIColor lightGrayColor];
        button2.enabled = NO;
    }else{
        button2.enabled = YES;
    }
    if (enabledShengButtonThree == 8) {//说明没有赔率 不能点击
        butLabel3.textColor = [UIColor lightGrayColor];
        threeText.textColor = [UIColor lightGrayColor];
        button3.enabled = NO;
        
    }else{
        button3.enabled = YES;
    }
    if (enabledShengButtonTour == 31) {//说明没有赔率 不能点击
        butLabel4.textColor = [UIColor lightGrayColor];
        fourText.textColor = [UIColor lightGrayColor];
        button4.enabled = NO;
    }else{
        button4.enabled = YES;
    }
    if (enabledShengButtonFive == 9) {//说明没有赔率 不能点击
        butLabel5.textColor = [UIColor lightGrayColor];
        fiveText.textColor = [UIColor lightGrayColor];
        button5.enabled = NO;
    }else{
        button5.enabled = YES;
    }
    
    
    if ( ![pkbetdata.macthType isEqualToString:@"playvs"]) {
        
//        button1.enabled = NO;
//        button2.enabled = NO;
//        button3.enabled = NO;
//        button4.enabled = NO;
//        button5.enabled = NO;
        butLabel1.textColor = [UIColor lightGrayColor];
        butLabel2.textColor = [UIColor lightGrayColor];
        butLabel3.textColor = [UIColor lightGrayColor];
        butLabel4.textColor = [UIColor lightGrayColor];
        butLabel5.textColor = [UIColor lightGrayColor];
        oneText.textColor = [UIColor lightGrayColor];
        twoText.textColor = [UIColor lightGrayColor];
        threeText.textColor = [UIColor lightGrayColor];
        fourText.textColor = [UIColor lightGrayColor];
        fiveText.textColor = [UIColor lightGrayColor];
        
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
    
    selection1 = _pkbetdata.selection1;
    selection2 = _pkbetdata.selection2;
    selection3 = _pkbetdata.selection3;
    boldan = _pkbetdata.booldan;
    nengyong = _pkbetdata.nengyong;
    dandan = _pkbetdata.dannengyong;
    panduan = _pkbetdata.dandan;
    donghua = _pkbetdata.donghuarow;
    if (hunType == 1) {
        if ([pkbetdata.bufshuarr count] < 18) {
            pkbetdata.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",@"0",nil];
        }
    }else{
        if ([pkbetdata.bufshuarr count] < 54) {
            pkbetdata.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", @"0",
                                 @"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",
                                 @"0", @"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",
                                 @"0",@"0",@"0", @"0",@"0",@"0",@"0", @"0",@"0",@"0",
                                 @"0",@"0",@"0",@"0",@"0", @"0",@"0",@"0",@"0",@"0",
                                 @"0",@"0",@"0",@"0",nil];
        }
    }
   
    
    self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr] ;
    
    eventLabel.text = _pkbetdata.event;
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
    
    if ([_pkbetdata.numzhou length] >= 5) {
        changhaola.text = [_pkbetdata.numzhou substringWithRange:NSMakeRange(2, 3)];
    }else{
         changhaola.text = @"";
    }
    
    
    
    self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
    
    
    timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
    
    if (hunType == 1){
        butLabel1.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        butLabel2.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        butLabel3.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        butLabel4.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        butLabel5.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    }else{
        butLabel1.textColor =  [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
        butLabel2.textColor =  [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
        butLabel3.textColor =  [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
        butLabel4.textColor =  [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
        butLabel5.textColor =  [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
    }
   
    
    
    NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    if (teamarray.count < 2) {
        teamarray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    homeduiLabel.text = [teamarray objectAtIndex:0];
    keduiLabel.text = [teamarray objectAtIndex:1];
    
    
    
    vsImage.hidden = NO;
    
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
    
    
    
    

    dan.hidden = YES;
    
    [self headShowFunc];
    if (hunType == 1) {
        
        [self cellButtonTypeShow];//篮球大混投
        
        UIImageView * onePluralImage = (UIImageView *)[button1 viewWithTag:82];
        UIImageView * twoPluralImage = (UIImageView *)[button2 viewWithTag:83];
        UIImageView * threePluralImage = (UIImageView *)[button3 viewWithTag:84];
        UIImageView * fourPluralImage = (UIImageView *)[button4 viewWithTag:85];
        
        
        if ([_pkbetdata.pluralString rangeOfString:@" 11,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
            
        }else {
            
            onePluralImage.hidden = YES;
        }
        if ([_pkbetdata.pluralString rangeOfString:@" 12,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            twoPluralImage.hidden = NO;
            
        }else {
            
            twoPluralImage.hidden = YES;
        }

        if ([_pkbetdata.pluralString rangeOfString:@" 14,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            threePluralImage.hidden = NO;
            
        }else {
            
            threePluralImage.hidden = YES;
        }
        if ([_pkbetdata.pluralString rangeOfString:@" 13,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            fourPluralImage.hidden = NO;
            
        }else {
            
            fourPluralImage.hidden = YES;
        }
        
        
    }else if (hunType == 2){
        
        [self footBallButtonTypeShow];//足球大混投
        
        UIImageView * onePluralImage = (UIImageView *)[button1 viewWithTag:82];
        UIImageView * twoPluralImage = (UIImageView *)[button2 viewWithTag:83];
        UIImageView * threePluralImage = (UIImageView *)[button3 viewWithTag:84];
        UIImageView * fourPluralImage = (UIImageView *)[button4 viewWithTag:85];
         UIImageView * fivePluralImage = (UIImageView *)[button5 viewWithTag:86];
        if ([_pkbetdata.pluralString rangeOfString:@" 1,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            onePluralImage.hidden = NO;
            
        }else {
            
            onePluralImage.hidden = YES;
        }
        if ([_pkbetdata.pluralString rangeOfString:@" 15,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            twoPluralImage.hidden = NO;
            
        }else {
            
            twoPluralImage.hidden = YES;
        }
        
        if ([_pkbetdata.pluralString rangeOfString:@" 3,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            threePluralImage.hidden = NO;
            
        }else {
            
            threePluralImage.hidden = YES;
        }
        if ([_pkbetdata.pluralString rangeOfString:@" 2,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            fourPluralImage.hidden = NO;
            
        }else {
            
            fourPluralImage.hidden = YES;
        }
        if ([_pkbetdata.pluralString rangeOfString:@" 4,"].location != NSNotFound ||[_pkbetdata.pluralString isEqualToString:@""]) {//判断 是否是单复式
            
            fivePluralImage.hidden = NO;
            
        }else {
            
            fivePluralImage.hidden = YES;
        }

    }
    
    
    if (wangqibool) {

        
        NSLog(@"caiguo = %@", _pkbetdata.caiguo);
        
        
        if (![_pkbetdata.caiguo isEqualToString:@"取消"]) {
            if (_pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]&& ![_pkbetdata.bifen isEqualToString:@"null"]) {

                if (hunType == 2) {//竞彩混投的 比分
                    
                    NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
                    
                   
                    if ([scores count] > 3) {
                        bifenLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
                        timeLabel.text = @"完";
                    }else{
                        bifenLabel.text = @"";
                        timeLabel.text = @"";
                        
                    }
                    butLabel1.text = @"胜";
                    butLabel2.text = @"让";
                    butLabel3.text = @"总";
                    butLabel4.text = @"分";
                    butLabel5.text = @"半";
                    butLabel1.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                    butLabel2.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                    butLabel3.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                    butLabel4.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                    butLabel5.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
                    if (_pkbetdata.caiguo) {
                        NSArray * caiguoArray = [_pkbetdata.caiguo componentsSeparatedByString:@"]-"];
                        if ([caiguoArray count] >= 5) {
                            
                            butLabel1.text = [caiguoArray objectAtIndex:0];
                            butLabel1.text = [butLabel1.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel1.text = [butLabel1.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            
                            butLabel2.text = [caiguoArray objectAtIndex:1];
                            butLabel2.text = [butLabel2.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel2.text = [butLabel2.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            butLabel2.text = [butLabel2.text stringByReplacingOccurrencesOfString:@"_" withString:@""];
                            
                            butLabel3.text = [caiguoArray objectAtIndex:2];
                            butLabel3.text = [butLabel3.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel3.text = [butLabel3.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            
                             butLabel4.text = [caiguoArray objectAtIndex:3];
                            butLabel4.text = [butLabel4.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel4.text = [ butLabel4.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            
                             butLabel5.text = [caiguoArray objectAtIndex:4];
                            butLabel5.text = [butLabel5.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel5.text = [butLabel5.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            
                           
                            butLabel1.textColor = [UIColor redColor];
                            butLabel2.textColor = [UIColor redColor];
                            butLabel3.textColor = [UIColor redColor];
                            butLabel4.textColor = [UIColor redColor];
                            butLabel5.textColor = [UIColor redColor];
                        }

                    }
                    
                }else{//竞彩篮球的 比分
                    if ([_pkbetdata.bifen length ]>0 && ![_pkbetdata.bifen isEqualToString:@"-"]) {
                        bifenLabel.text = _pkbetdata.bifen;
                        timeLabel.text = @"完";
                        
                        NSArray * caiguoArray = [_pkbetdata.caiguo componentsSeparatedByString:@","];
                        if ([caiguoArray count] >= 4) {
                            butLabel1.text = [caiguoArray objectAtIndex:0];
                            butLabel2.text = [caiguoArray objectAtIndex:1];
                            butLabel2.text = [butLabel2.text stringByReplacingOccurrencesOfString:@"[" withString:@""];
                            butLabel2.text = [butLabel2.text stringByReplacingOccurrencesOfString:@"]" withString:@""];
                            butLabel3.text = [caiguoArray objectAtIndex:2];
                            butLabel4.text = [caiguoArray objectAtIndex:3];
                            butLabel1.textColor = [UIColor redColor];
                            butLabel2.textColor = [UIColor redColor];
                            butLabel3.textColor = [UIColor redColor];
                            butLabel4.textColor = [UIColor redColor];
                        }
                    }else{
                        bifenLabel.text = @"";
                        timeLabel.text = @"";
                    }
                    
                }
                
               
                
                
                
            }else{
                bifenLabel.text = @"-";
                timeLabel.text = @"...";
            }
            
        }else{
            bifenLabel.text = @"取消";
            timeLabel.text = @"";
        
        }
        
        vsImage.hidden = YES;
        bifenLabel.hidden = NO;
        //        rangqiulabel.hidden = YES;
        
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        bifenLabel.hidden = NO;
        
    }else{
        bifenLabel.hidden = YES;
//        zhegaiview.hidden = YES;
        winImage1.hidden= YES;
        winImage2.hidden = YES;
        winImage3.hidden = YES;
        timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
        timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
    }
    
//    if (hunType == 2){
        [self playVsTypeFunc];
    
//    }
    
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan cellType:(NSInteger)typeCell
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:type];
    if (self) {
        
        
        
        self.hunType = typeCell;
    
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

- (void)uiLabelButtonTextWithButton:(UIButton *)sender type:(NSInteger)type{

    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, sender.frame.size.height - 20, sender.frame.size.width , 20)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.tag = 107;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:9];
    textLabel.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    [sender addSubview:textLabel];
    [textLabel release];
    
    if (type == 1) {
        textLabel.text = @"胜平负";
    }else if (type == 2){
        textLabel.text = @"胜平负";
    }else if (type == 3){
        textLabel.text = @"总进球";
    }else if (type == 4){
    textLabel.text = @"比  分";
    }else if (type == 5){
    textLabel.text = @"半全场";
    }

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
    butLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    butLabel1.textAlignment = NSTextAlignmentCenter;
    butLabel1.backgroundColor = [UIColor clearColor];
//    butLabel1.font = [UIFont fontWithName:@"TRENDS" size:12];
    butLabel1.font = [UIFont systemFontOfSize:12];
    butLabel1.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    butLabel1.lineBreakMode = NSLineBreakByWordWrapping;
    butLabel1.numberOfLines = 0;
    
    //第二个button上的小数字
    butLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    butLabel2.textAlignment = NSTextAlignmentCenter;
    butLabel2.backgroundColor = [UIColor clearColor];
//    butLabel2.font = [UIFont fontWithName:@"TRENDS" size:12];
    butLabel2.font = [UIFont systemFontOfSize:12];
     butLabel2.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    butLabel2.lineBreakMode = NSLineBreakByWordWrapping;
    butLabel2.numberOfLines = 0;
    
    //第三个button上的小数字
    butLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    butLabel3.textAlignment = NSTextAlignmentCenter;
    butLabel3.backgroundColor = [UIColor clearColor];
//    butLabel3.font = [UIFont fontWithName:@"TRENDS" size:12];
    butLabel3.font = [UIFont systemFontOfSize:12];
     butLabel3.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    butLabel3.lineBreakMode = NSLineBreakByWordWrapping;
    butLabel3.numberOfLines = 0;
    //第四个button上的小数字
    butLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    butLabel4.textAlignment = NSTextAlignmentCenter;
    butLabel4.backgroundColor = [UIColor clearColor];
//    butLabel4.font = [UIFont fontWithName:@"TRENDS" size:12];
    butLabel4.font = [UIFont systemFontOfSize:12];
    butLabel4.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    butLabel4.lineBreakMode = NSLineBreakByWordWrapping;
    butLabel4.numberOfLines = 0;
    //第五个button上的小数字
    butLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    butLabel5.textAlignment = NSTextAlignmentCenter;
    butLabel5.backgroundColor = [UIColor clearColor];
//    butLabel5.font = [UIFont fontWithName:@"TRENDS" size:12];
    butLabel5.font = [UIFont systemFontOfSize:12];
    butLabel5.textColor =  [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
    butLabel5.lineBreakMode = NSLineBreakByWordWrapping;
    butLabel5.numberOfLines = 0;
    
    
    
    //第一个按钮
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor clearColor];
    button1.frame = CGRectMake(0, 0, 0, 0);
    [button1 addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第二个按钮
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 0, 0);
    [button2 addTarget:self action:@selector(pressButton2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //第三个按钮
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(0, 0, 0, 0);
    [button3 addTarget:self action:@selector(pressButton3:) forControlEvents:UIControlEventTouchUpInside];
    
    //第四个按钮
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(0, 0, 0, 0);
    [button4 addTarget:self action:@selector(pressButton4:) forControlEvents:UIControlEventTouchUpInside];
    
    //第五个按钮
    button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(0, 0, 0, 0);
    [button5 addTarget:self action:@selector(pressButton5:) forControlEvents:UIControlEventTouchUpInside];
    

    NSInteger countFor = 0;
    if (hunType == 1) {
        countFor = 4;
        button1.frame = CGRectMake(0.5, 0, 62.5, 51);
        button2.frame = CGRectMake(63.5, 0, 62.5, 51);
        button3.frame = CGRectMake(126.5, 0, 62.5, 51);
        button4.frame = CGRectMake(189.5, 0, 62.5, 51);
        butLabel5.frame = CGRectMake(0, 0, 0, 0);
        
//        [button1 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateNormal];
//        [button2 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateNormal];
//        [button3 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateNormal];
//        [button4 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateNormal];
//       
//        [button1 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateDisabled];
//        [button2 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateDisabled];
//        [button3 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateDisabled];
//        [button4 setImage:UIImageGetImageFromName(@"lanqiuhunnew.png") forState:UIControlStateDisabled];
        button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button3.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button4.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        
        
    }else if (hunType == 2){
        countFor = 5;
        button1.frame = CGRectMake(0.5, 0, 49.9, 51);
        button2.frame = CGRectMake(50.9, 0, 49.9, 51);
        button3.frame = CGRectMake(101.3, 0, 49.9, 51);
        button4.frame = CGRectMake(151.7, 0, 49.9, 51);
        button5.frame = CGRectMake(202.1, 0, 49.9, 51);
        button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button3.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button4.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        button5.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
//        [button1 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateNormal];
//        [button2 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateNormal];
//        [button3 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateNormal];
//        [button4 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateNormal];
//        [button5 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateNormal];
//        [button1 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateDisabled];
//        [button2 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateDisabled];
//        [button3 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateDisabled];
//        [button4 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateDisabled];
//        [button5 setImage:UIImageGetImageFromName(@"zuqiuhunnew.png") forState:UIControlStateDisabled];
        
    }
    
    for (int i = 0; i < countFor; i++) {
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
        
        if (hunType == 1) {
            
            
            UIImageView * basketballImageBg = [[UIImageView alloc] init];
            basketballImageBg.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
            basketballImageBg.tag = 77 + i;
//            basketballImageBg.image = UIImageGetImageFromName(@"lanqiuhunnew.png");
//            [button1 addSubview:basketballImageBg];
//            [basketballImageBg release];
            
            [basketballImageBg addSubview:bgimage];
            [bgimage release];
            [basketballImageBg addSubview:bgimage2];
            [bgimage2 release];
            
            if (i == 0) {
                basketballImageBg.frame = button1.bounds;
                [button1 addSubview:basketballImageBg];
                butLabel1.frame = button1.bounds;
                [button1 addSubview:butLabel1];
                UIImageView * onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
                onePluralImage.hidden = YES;
                onePluralImage.tag = 82+i;
                onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
                [button1 addSubview:onePluralImage];
                [onePluralImage release];
            }else if (i == 1){
                basketballImageBg.frame = button2.bounds;
                [button2 addSubview:basketballImageBg];
                butLabel2.frame = button2.bounds;
                [button2 addSubview:butLabel2];
                UIImageView * onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
                onePluralImage.hidden = YES;
                onePluralImage.tag = 82+i;
                onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
                [button2 addSubview:onePluralImage];
                [onePluralImage release];
            }else if (i == 2){
                basketballImageBg.frame = button3.bounds;
                [button3 addSubview:basketballImageBg];
                butLabel3.frame = button3.bounds;
                [button3 addSubview:butLabel3];
                UIImageView * onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
                onePluralImage.hidden = YES;
                onePluralImage.tag = 82+i;
                onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
                [button3 addSubview:onePluralImage];
                [onePluralImage release];
            }else if (i == 3){
                basketballImageBg.frame = button4.bounds;
                [button4 addSubview:basketballImageBg];
                butLabel4.frame = button4.bounds;
                [button4 addSubview:butLabel4];
                
                UILabel *  diandian = [[UILabel alloc] initWithFrame:CGRectMake(17, 30, 40, 20)];
                diandian.textAlignment = NSTextAlignmentRight;
                diandian.tag = 120;
                diandian.hidden = YES;
                diandian.text = @"...";
                diandian.backgroundColor = [UIColor clearColor];
                diandian.font = [UIFont systemFontOfSize:14];
                diandian.textColor =  [UIColor whiteColor];
                [button4 addSubview:diandian];
                [diandian release];
                UIImageView * onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
                onePluralImage.hidden = YES;
                onePluralImage.tag = 82+i;
                onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
                [button4 addSubview:onePluralImage];
                [onePluralImage release];
            }
            [basketballImageBg release];
            
            UILabel *  diandian = [[UILabel alloc] initWithFrame:CGRectMake(142, 30, 100, 20)];
            diandian.textAlignment = NSTextAlignmentRight;
            diandian.tag = 1231;
            diandian.hidden = YES;
            diandian.text = @"...";
            diandian.backgroundColor = [UIColor clearColor];
            diandian.font = [UIFont systemFontOfSize:14];
            diandian.textColor =  [UIColor whiteColor];
            [button1 addSubview:diandian];
            [diandian release];
            
            
        }else if (hunType == 2) {
            
            UILabel *  diandian = [[UILabel alloc] initWithFrame:CGRectMake(7, 30, 40, 20)];
            diandian.textAlignment = NSTextAlignmentRight;
            diandian.tag = 120+i;
            diandian.hidden = YES;
            diandian.text = @"...";
            diandian.backgroundColor = [UIColor clearColor];
            diandian.font = [UIFont systemFontOfSize:14];
            diandian.textColor =  [UIColor whiteColor];
            
            UIImageView * onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
            onePluralImage.hidden = YES;
            onePluralImage.tag = 82+i;
            onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
            
            
            if (i == 0) {
                [button1 addSubview:bgimage];
                [bgimage release];
                [button1 addSubview:bgimage2];
                [bgimage2 release];
                butLabel1.frame = button1.bounds;
                [button1 addSubview:butLabel1];
                [self uiLabelButtonTextWithButton:button1 type:1];
                [button1 addSubview:diandian];
                [diandian release];
                onePluralImage.frame = CGRectMake(1.5, 0, 4, 4);
                [button1 addSubview:onePluralImage];
                
            }else if (i == 1){
                [button2 addSubview:bgimage];
                [bgimage release];
                [button2 addSubview:bgimage2];
                [bgimage2 release];
                butLabel2.frame = button2.bounds;
                [button2 addSubview:butLabel2];
                [self uiLabelButtonTextWithButton:button2 type:2];
                [button2 addSubview:diandian];
                [diandian release];
                [button2 addSubview:onePluralImage];
            }else if (i == 2){
                [button3 addSubview:bgimage];
                [bgimage release];
                [button3 addSubview:bgimage2];
                [bgimage2 release];
                butLabel3.frame = button3.bounds;
                [button3 addSubview:butLabel3];
                [self uiLabelButtonTextWithButton:button3 type:3];
                [button3 addSubview:diandian];
                [diandian release];
                [button3 addSubview:onePluralImage];
            }else if (i == 3){
                [button4 addSubview:bgimage];
                [bgimage release];
                [button4 addSubview:bgimage2];
                [bgimage2 release];
                butLabel4.frame = button4.bounds;
                [button4 addSubview:butLabel4];
                [self uiLabelButtonTextWithButton:button4 type:4];
                [button4 addSubview:diandian];
                [diandian release];
                [button4 addSubview:onePluralImage];
            }else if (i == 4){
                [button5 addSubview:bgimage];
                [bgimage release];
                [button5 addSubview:bgimage2];
                [bgimage2 release];
                butLabel5.frame = button5.bounds;
                [button5 addSubview:butLabel5];
                [self uiLabelButtonTextWithButton:button5 type:5];
                [button5 addSubview:diandian];
                [diandian release];
                [button5 addSubview:onePluralImage];
            }
            [onePluralImage release];
            
        }
        
        
        
        
    }
    
    
    
    
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
    [view addSubview:button4];
    [view addSubview:button5];
    
    
    if (hunType == 1) {
        UIView * linebutton1 = [[UIView alloc] initWithFrame:CGRectMake(63, 0, 0.5, 51)];
        linebutton1.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton1];
        [linebutton1 release];
        
        UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(126, 0, 0.5, 51)];
        linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton2];
        [linebutton2 release];
        
        UIView * linebutton3 = [[UIView alloc] initWithFrame:CGRectMake(189, 0, 0.5, 51)];
        linebutton3.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton3];
        [linebutton3 release];
        
        UIView * linebutton4 = [[UIView alloc] initWithFrame:CGRectMake(252, 0, 0.5, 51)];
        linebutton4.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton4];
        [linebutton4 release];
        
    }else if (hunType == 2){
    
        UIView * linebutton1 = [[UIView alloc] initWithFrame:CGRectMake(50.4, 0, 0.5, 51)];
        linebutton1.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton1];
        [linebutton1 release];
        UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(100.8, 0, 0.5, 51)];
        linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton2];
        [linebutton2 release];
        UIView * linebutton3 = [[UIView alloc] initWithFrame:CGRectMake(151.2, 0, 0.5, 51)];
        linebutton3.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton3];
        [linebutton3 release];
        UIView * linebutton4 = [[UIView alloc] initWithFrame:CGRectMake(201.6, 0, 0.5, 51)];
        linebutton4.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton4];
        [linebutton4 release];
        UIView * linebutton5 = [[UIView alloc] initWithFrame:CGRectMake(252, 0, 0.5, 51)];
        linebutton5.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
        [view addSubview:linebutton5];
        [linebutton5 release];
    }
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20+5, 14)];
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
    
    keduiLabel.frame = CGRectMake(200,16, 73, 14);
    [headimage addSubview:homeduiLabel];
    [headimage addSubview:keduiLabel];
    
    
    
    [headimage addSubview:vsImage];
    
    [vsImage release];
    
    xidanButton.hidden = NO;
    XIDANImageView.hidden = NO;
    
    

    
    
    winImage1.frame = CGRectMake(1, 1, 10, 10);
    winImage1.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage2.frame = CGRectMake(1, 1, 10, 10);
    winImage2.image = UIImageGetImageFromName(@"hongnew.png");
    
    winImage3.frame = CGRectMake(1, 1, 10, 10);
    winImage3.image = UIImageGetImageFromName(@"hongnew.png");
    
    
//    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
//    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
//    zhegaiview.frame=  CGRectMake(10, 0, 300-54, 50);
//    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
//    zhegaiview.backgroundColor = [UIColor clearColor];
//    zhegaiview.hidden= YES;
//    [view addSubview:zhegaiview];
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





- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        
        [delegate returnbifenCellInfo:index shuzu:bufshuzu dan:booldan];
    }
    
}
- (void)sleepfunc{
    
    [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:boldan];
}


- (void)footballBoxFunc:(BigHunTouBoxType)type {

    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    
        
    BigHunTouBox * footBox = [[BigHunTouBox alloc] initWithType:type wangqin:wangqibool];
    footBox.delegate = self;
    
    footBox.wangqibool = wangqibool;
    
    if (!(type == shengfuType || type == rangfenshengfuType || type == shengfenchaType || type == daxiaofenType)) {
        if ( ![pkbetdata.macthType isEqualToString:@"playvs"]) {
            footBox.wangqibool = YES;
        }
    }
    
    
    footBox.betData = self.pkbetdata;
    [app.window addSubview:footBox];
    [footBox release];

}

//第一个按钮的触发函数
- (void)pressButton1:(UIButton *)button{
   
//    if (hunType == 1) {
//        
//        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
//        if (!ballBox) {
//            
//            ballBox = [[HTbasketballBoxView alloc] initWithFrame:app.window.bounds betData:self.pkbetdata wangQi:wangqibool];
//            ballBox.delegate = self;
//        }
//        ballBox.wangqiBool = wangqibool;
//        ballBox.betData = self.pkbetdata;
//        [app.window addSubview:ballBox];
//       
//    }else{
//    
//        [self footballBoxFunc:0 footOrBasketBall:footballType];
//    }
    
    if (hunType == 1) {
        
        [self footballBoxFunc:shengfuType ];
        
    }else{
        
        [self footballBoxFunc:shengpingfuType];
    }
}

//第二个按钮的触发函数
- (void)pressButton2:(UIButton *)button{
    if (hunType == 1) {
        
        [self footballBoxFunc:rangfenshengfuType];
        
    }else{
        [self footballBoxFunc:rangqiushengpingfuType];
    }
    
}
//第三个按钮的触发函数
- (void)pressButton3:(UIButton *)button{
    
    if (hunType == 1) {
        
        [self footballBoxFunc:daxiaofenType];
        
    }else{
        [self footballBoxFunc:zongjinqiuType];
    }
    
}
//第四个按钮的触发函数
- (void)pressButton4:(UIButton *)button{
    if (hunType == 1) {
        
        [self footballBoxFunc:shengfenchaType];
        
    }else{
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        
        if (!scoreBall) {
            scoreBall = [[ScoreBallView alloc] initWithFrame:app.window.bounds betData:self.pkbetdata wangQi:wangqibool];
        }
        
        scoreBall.delegate = self;
        scoreBall.bigHunTou = YES;
        scoreBall.wangqiBool = wangqibool;
        if ( ![pkbetdata.macthType isEqualToString:@"playvs"]) {
            scoreBall.wangqiBool = YES;
        }
        scoreBall.betData = self.pkbetdata;
        [app.window addSubview:scoreBall];
    }
    
    
}
//第五个按钮的触发函数
- (void)pressButton5:(UIButton *)button{
    if (hunType == 1) {
        
        
        
    }else{
        [self footballBoxFunc:banquanchangType];
    }
    
    
}


- (void)ballBoxDelegateReturnData:(GC_BetData *)bd{
    self.pkbetdata = bd;
    [self setPkbetdata:bd];
    [self performSelector:@selector(sleepfunc) withObject:nil afterDelay:0.1];
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
    if (ballBox) {
        [ballBox release];
    }
    if (scoreBall) {
        [scoreBall release];
    }
    
    [typeButtonArray release];
    [changhaola release];

    [danzi release];
    [danimge release];
    [matcinfo release];

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
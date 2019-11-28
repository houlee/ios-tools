//
//  JJYHTouCell.m
//  caibo
//
//  Created by yaofuyu on 13-7-11.
//
//

#import "JJYHTouCell.h"

@implementation JJYHTouCell

@synthesize count,pkbetdata,caizhong, zhuihouBool;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self tableViewCell]];
        btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(70, 30, 68, 15);
        
        [view addSubview:btn1];
        [btn1 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn1 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(140, 30, 68, 15);
        [view addSubview:btn2];
        [btn2 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn2 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(210, 30, 68, 15);
        [view addSubview:btn3];
        [btn3 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn3 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame = CGRectMake(70, 47, 68, 15);
        [view addSubview:btn4];
        [btn4 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn4 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn5.frame = CGRectMake(140, 47, 68, 15);
        [view addSubview:btn5];
        [btn5 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn5 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn6.frame = CGRectMake(210, 47, 68, 15);
        [view addSubview:btn6];
        [btn6 setImage:UIImageGetImageFromName(@"JJYH1.png") forState:UIControlStateNormal];
        [btn6 setImage:UIImageGetImageFromName(@"JJYH2.png") forState:UIControlStateSelected];
        
        //第一个button上的小数字
        butLabel1 = [[UILabel alloc] initWithFrame:btn1.bounds];
        butLabel1.textAlignment = NSTextAlignmentCenter;
        butLabel1.backgroundColor = [UIColor clearColor];
        butLabel1.font = [UIFont systemFontOfSize:8];
        butLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn1 addSubview:butLabel1];
        [butLabel1 release];
        
        //第二个button上的小数字
        butLabel2 = [[UILabel alloc] initWithFrame:btn2.bounds];
        butLabel2.textAlignment = NSTextAlignmentCenter;
        butLabel2.backgroundColor = [UIColor clearColor];
        butLabel2.font = [UIFont systemFontOfSize:8];
        butLabel2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn2 addSubview:butLabel2];
        [butLabel2 release];
        
        //第三个button上的小数字
        butLabel3 = [[UILabel alloc] initWithFrame:btn3.bounds];
        butLabel3.textAlignment = NSTextAlignmentCenter;
        butLabel3.backgroundColor = [UIColor clearColor];
        butLabel3.font = [UIFont systemFontOfSize:8];
        butLabel3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn3 addSubview:butLabel3];
        [butLabel3 release];
        
        //第一个button上的小数字
        butLabel4 = [[UILabel alloc] initWithFrame:btn4.bounds];
        butLabel4.textAlignment = NSTextAlignmentCenter;
        butLabel4.backgroundColor = [UIColor clearColor];
        butLabel4.font = [UIFont systemFontOfSize:8];
        butLabel4.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn4 addSubview:butLabel4];
        [butLabel4 release];
        
        //第二个button上的小数字
        butLabel5 = [[UILabel alloc] initWithFrame:btn5.bounds];
        butLabel5.textAlignment = NSTextAlignmentCenter;
        butLabel5.backgroundColor = [UIColor clearColor];
        butLabel5.font = [UIFont systemFontOfSize:8];
        butLabel5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn5 addSubview:butLabel5];
        [butLabel5 release];
        
        //第三个button上的小数字
        butLabel6 = [[UILabel alloc] initWithFrame:btn6.bounds];
        butLabel6.textAlignment = NSTextAlignmentCenter;
        butLabel6.backgroundColor = [UIColor clearColor];
        butLabel6.font = [UIFont systemFontOfSize:8];
        butLabel6.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        [btn6 addSubview:butLabel6];
        [butLabel6 release];
        
//        //按钮上显示3
//        datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//        datal1.text = @"胜";
//        datal1.font = [UIFont boldSystemFontOfSize:12];
//        datal1.textAlignment = NSTextAlignmentRight;
//        datal1.backgroundColor = [UIColor clearColor];
//        datal1.textColor = [UIColor blackColor];
//        [btn1 addSubview:datal1];
//        [datal1 release];
//        
//        //按钮上显示1
//        datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//        datal2.text = @"平";
//        datal2.font = [UIFont boldSystemFontOfSize:12];
//        datal2.textAlignment = NSTextAlignmentRight;
//        datal2.backgroundColor = [UIColor clearColor];
//        datal2.textColor = [UIColor blackColor];
//        [btn2 addSubview:datal2];
//        [datal2 release];
//        
//        //按钮上显示0
//        datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
//        datal3.text = @"负";
//        datal3.font = [UIFont boldSystemFontOfSize:12];
//        datal3.textAlignment = NSTextAlignmentRight;
//        datal3.backgroundColor = [UIColor clearColor];
//        datal3.textColor = [UIColor blackColor];
//        [btn3 addSubview:datal3];
//        [datal3 release];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPkbetdata:(GC_YHTouInfo *)_pkbetdata {
    [pkbetdata release];
    pkbetdata = [_pkbetdata retain];
    if (caizhong == jingcaipiao) {
        btn1.hidden = NO;
        btn2.hidden = NO;
        btn3.hidden = NO;
        btn4.hidden = YES;
        btn5.hidden = YES;
        btn6.hidden = YES;
        view.frame = CGRectMake(10, 0, 300, 56);
        if (zhuihouBool) {
            xiaImageV.frame = CGRectMake(-10, view.frame.size.height - 0.5, 320, 0.5);
        }else{
            xiaImageV.frame = CGRectMake(5, view.frame.size.height - 0.5, 320-5, 0.5);
        }
    }
    else if (caizhong == jingcaihuntou) {
        btn1.hidden = NO;
        btn2.hidden = NO;
        btn3.hidden = NO;
        btn4.hidden = NO;
        btn5.hidden = NO;
        btn6.hidden = NO;
        view.frame = CGRectMake(10, 0, 300, 71);
        headimage.frame = CGRectMake(0, 0, 49, 63) ;
//        headimage.image = UIImageGetImageFromName(@"jjyh9.png");
        
        chImage.frame = CGRectMake(7, 11, 38, 15);
        eventLabel.frame = CGRectMake(0, 27, 49, 13);
        timeLabel.frame = CGRectMake(1, 40, 49, 10);
        if (zhuihouBool) {
            
            xiaImageV.frame = CGRectMake(-10, view.frame.size.height - 0.5, 320, 0.5);
        }else{
            xiaImageV.frame = CGRectMake(5, view.frame.size.height - 0.5, 320-5, 0.5);
        }
        
    }
    else if (caizhong == jingcaihuntouerxuanyi) {
        btn1.hidden = NO;
        btn2.hidden = YES;
        btn3.hidden = NO;
        btn4.hidden = YES;
        btn5.hidden = YES;
        btn6.hidden = YES;
        view.frame = CGRectMake(10, 0, 300, 56);
        if (zhuihouBool) {
            xiaImageV.frame = CGRectMake(-10, view.frame.size.height - 0.5, 320, 0.5);
        }else{
            xiaImageV.frame = CGRectMake(5, view.frame.size.height - 0.5, 320-5, 0.5);
        }
    }
    timeLabel.text = pkbetdata.endTime;
    changhaola.text = pkbetdata.identifier;
    eventLabel.text = pkbetdata.leagueName;
    homeduiLabel.text = pkbetdata.home;
    if ([pkbetdata.assignCount intValue] != 0) {
        rangLabel.text = pkbetdata.assignCount;
    }
    else {
        rangLabel.text = @"";
    }
    
    keduiLabel.text = pkbetdata.away;
    NSArray *arrayzong  = [pkbetdata.eurPei componentsSeparatedByString:@","];
    NSArray *array = nil;
    NSArray *array2 = nil;
    if ([arrayzong count]) {
        array = [[arrayzong objectAtIndex:0] componentsSeparatedByString:@" "];
    }
    if ([arrayzong count] >= 2) {
        array2 = [[arrayzong objectAtIndex:1] componentsSeparatedByString:@" "];
    }
    
    
    if ([array count] >= 3) {
        if ([[array objectAtIndex:0] rangeOfString:@"#"].location == NSNotFound) {
            btn1.selected = NO;
            butLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        }
        else {
            btn1.selected = YES;
            butLabel1.textColor = [UIColor whiteColor];
        }


        
        if ([[array objectAtIndex:1] rangeOfString:@"#"].location == NSNotFound) {
            btn2.selected = NO;
            butLabel2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        }
        else {
            btn2.selected = YES;
            butLabel2.textColor = [UIColor whiteColor];
        }

        
        if ([[array objectAtIndex:2] rangeOfString:@"#"].location == NSNotFound) {
            btn3.selected = NO;
            butLabel3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        }
        else {
            btn3.selected = YES;
            butLabel3.textColor = [UIColor whiteColor];
        }

        if (caizhong == jingcaipiao) {
            butLabel1.text = [NSString stringWithFormat:@"胜 %@",[[array objectAtIndex:0] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            butLabel2.text = [NSString stringWithFormat:@"平 %@",[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            butLabel3.text = [NSString stringWithFormat:@"负 %@",[[array objectAtIndex:2] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
        }
        else if (caizhong == jingcaihuntouerxuanyi) {
            if ([array2 count] >= 3) {
                if ([pkbetdata.assignCount intValue] >0) {
                    butLabel1.text = [NSString stringWithFormat:@"主不败 %@",[[array2 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                    butLabel3.text = [NSString stringWithFormat:@"客胜 %@",[[array objectAtIndex:2] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                    if ([[array2 objectAtIndex:0] rangeOfString:@"#"].location == NSNotFound) {
                        btn1.selected = NO;
                        butLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    else {
                        btn1.selected = YES;
                        butLabel1.textColor = [UIColor whiteColor];
                    }
                    
                    if ([[array objectAtIndex:2] rangeOfString:@"#"].location == NSNotFound) {
                        btn3.selected = NO;
                        butLabel3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    else {
                        btn3.selected = YES;
                        butLabel3.textColor = [UIColor whiteColor];
                    }
                }
                else if ([pkbetdata.assignCount intValue] < 0) {
                    butLabel1.text = [NSString stringWithFormat:@"主胜 %@",[[array objectAtIndex:0] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                    butLabel3.text = [NSString stringWithFormat:@"客不败 %@",[[array2 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                    if ([[array objectAtIndex:0] rangeOfString:@"#"].location == NSNotFound) {
                        btn1.selected = NO;
                        butLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    else {
                        btn1.selected = YES;
                        butLabel1.textColor = [UIColor whiteColor];
                    }
                    
                    if ([[array2 objectAtIndex:2] rangeOfString:@"#"].location == NSNotFound) {
                        btn3.selected = NO;
                        butLabel3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                    }
                    else {
                        btn3.selected = YES;
                        butLabel3.textColor = [UIColor whiteColor];
                    }
                }
            }
            
        }
        else if (caizhong == jingcaihuntou) {
            butLabel1.text = [NSString stringWithFormat:@"胜 %@",[[array objectAtIndex:0] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            butLabel2.text = [NSString stringWithFormat:@"平 %@",[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            butLabel3.text = [NSString stringWithFormat:@"负 %@",[[array objectAtIndex:2] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
            if ([array2 count] >= 3) {
                butLabel4.text = [NSString stringWithFormat:@"让胜 %@",[[array2 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                butLabel5.text = [NSString stringWithFormat:@"让平 %@",[[array2 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                butLabel6.text = [NSString stringWithFormat:@"让负 %@",[[array2 objectAtIndex:2] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
                if ([[array2 objectAtIndex:0] rangeOfString:@"#"].location == NSNotFound) {
                    btn4.selected = NO;
                    butLabel4.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                }
                else {
                    btn4.selected = YES;
                    butLabel4.textColor = [UIColor whiteColor];
                }
                
                if ([[array2 objectAtIndex:1] rangeOfString:@"#"].location == NSNotFound) {
                    btn5.selected = NO;
                    butLabel5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                }
                else {
                    btn5.selected = YES;
                    butLabel5.textColor = [UIColor whiteColor];
                }
                
                
                if ([[array2 objectAtIndex:2] rangeOfString:@"#"].location == NSNotFound) {
                    btn6.selected = NO;
                    butLabel6.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                }
                else {
                    btn6.selected = YES;
                    butLabel6.textColor = [UIColor whiteColor];
                }
            }
        }

    }
}

- (UIView *)tableViewCell{
    //返回给cell的view
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    view.userInteractionEnabled = YES;
//    view.image = UIImageGetImageFromName(@"jjyh7.png");
    view.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:238/255.0 alpha:1];
    
    headimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 56)];
    headimage.backgroundColor = [UIColor clearColor];
//    headimage.image = UIImageGetImageFromName(@"jjyh9.png");
    headimage.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:238/255.0 alpha:1];
    headimage.userInteractionEnabled = YES;
    [view addSubview:headimage];
    [headimage release];
    
    
    chImage = [[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 38, 15)];
    chImage.backgroundColor = [UIColor clearColor];
    chImage.image = UIImageGetImageFromName(@"jjyhchanghaoimage.png");
    [headimage addSubview:chImage];
    [chImage release];
    
    changhaola = [[UILabel alloc] initWithFrame:chImage.bounds];
    changhaola.backgroundColor = [UIColor clearColor];
    changhaola.textAlignment = NSTextAlignmentCenter;
    changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    changhaola.font  = [UIFont systemFontOfSize:9];
    [chImage addSubview:changhaola];
    [changhaola release];
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 49, 13)];
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont boldSystemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor blackColor];
    [headimage addSubview:eventLabel];
    
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 39, 49, 10)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:8];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headimage addSubview:timeLabel];
    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 0, 90, 30)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    
    rangLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 69, 30)];
    rangLabel.backgroundColor = [UIColor clearColor];
    rangLabel.textAlignment = NSTextAlignmentCenter;
    rangLabel.textColor = [UIColor redColor];
    [view addSubview:rangLabel];
    
    UIImageView *vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(164, 8, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 0, 91, 30)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
        
    [view addSubview:homeduiLabel];
    [view addSubview:keduiLabel];
    [view addSubview:vsImage];
    [vsImage release];
    
    
    xiaImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 0, 0)];
    xiaImageV.backgroundColor = [UIColor colorWithRed:180/255.0 green:174/255.0 blue:158/255.0 alpha:1];
    [view addSubview:xiaImageV];
    [xiaImageV release];
    
    
    return view;
}

- (void)dealloc {
    self.pkbetdata = nil;
    [view release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
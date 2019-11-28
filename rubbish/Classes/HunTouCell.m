//
//  HunTouCell.m
//  caibo
//
//  Created by houchenguang on 13-9-23.
//
//

#import "HunTouCell.h"

@implementation HunTouCell
@synthesize row;
@synthesize count;
@synthesize delegate;
@synthesize wangqibool;
@synthesize dan, buttonBool, butTitle, typeButtonArray;
@synthesize duckImageTwo, duckImageOne, duckImageThree,wangqiTwoBool, XIDANImageView;

- (void)dealloc{
    [typeButtonArray release];
    [pkbetdata release];
    [super dealloc];
}
- (void)duckViewAnimations{//鸭子动画
    
    if (duckImageOne.hidden == NO) {
        duckImageOne.frame = CGRectMake(0, 32, 75, 25);
    }
    if (duckImageTwo.hidden == NO) {
        duckImageTwo.frame = CGRectMake(0, 32, 75, 25);
    }
    if (duckImageThree.hidden == NO) {
        duckImageThree.frame = CGRectMake(0, 32, 75, 25);
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
            hight = 52-8;
        }else if ([caiguo intValue] == 4) {
            hight = 45-8;
        }else if ([caiguo intValue] <= 3) {
            hight = 39-8;
        }
        
    }
    if (duckImageOne.hidden == NO) {
        duckImageOne.frame = CGRectMake(0, 32 - hight, 75, hight);
    }
    if (duckImageTwo.hidden == NO) {
        duckImageTwo.frame = CGRectMake(0, 32 - hight, 75, hight);
    }
    if (duckImageThree.hidden == NO) {
        duckImageThree.frame = CGRectMake(0, 32 - hight, 75, hight);
    }
    
    [UIView commitAnimations];
    
    //    if (duckImageOne.hidden == NO || duckImageTwo.hidden == NO || duckImageThree == NO) {
    //      [self performSelector:@selector(duckViewAnimations:) withObject:nil afterDelay:1.5];
    //    }
    if (delegate&&[delegate respondsToSelector:@selector(duckImageCell:)]) {
        [delegate duckImageCellHunTou:self];
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
            
            duckImageOne.frame = CGRectMake(0, 2, 75, 30);
            duckImageTwo.frame = CGRectMake(0, 2, 75, 30);
            duckImageThree.frame = CGRectMake(0, 2, 75, 30);
            [self duckViewAnimations];
            
        }
        
        
        
        
        
    }
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier type:@"1"];
    if (self) {
        // Initialization code
     
        [self.butonScrollView addSubview:[self tableViewCellView]];
        self.butonScrollView.delegate = self;
//        self.butonScrollView.backgroundColor = [UIColor redColor];
        self.butonScrollView.frame = CGRectMake(self.butonScrollView.frame.origin.x, 23+3, self.butonScrollView.frame.size.width, 109-45+21);
        UIImageView * scrollViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(309, 3, 240, 64.5)];
        scrollViewBack.tag = 1102;
        scrollViewBack.backgroundColor = [UIColor clearColor];
        scrollViewBack.userInteractionEnabled = YES;
        [self.butonScrollView addSubview:scrollViewBack];
        [scrollViewBack release];
        
        
        self.butonScrollView.pagingEnabled = YES;
        self.butonScrollView.showsHorizontalScrollIndicator = NO;
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
 
        [self.contentView insertSubview:self.butonScrollView atIndex:10000];
        
        UIImageView * lineImage = (UIImageView *)[self.contentView viewWithTag:1890];
        [self.contentView bringSubviewToFront:lineImage];
        
        
        UIImageView * hengImage = (UIImageView *)[self.contentView viewWithTag:1762];
        [self.contentView bringSubviewToFront:hengImage];
        
        
//        self.butonScrollView.backgroundColor = [UIColor redColor];
//        xiButton.backgroundColor = [UIColor blueColor];
        
//        xiButton.frame = CGRectMake(xiButton.frame.origin.x, xiButton.frame.origin.y, xiButton.frame.size.width, 43);
//        [self.contentView insertSubview:xiButton atIndex:10001];
        
       
        
    }
    return self;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:[self tableViewCellView]];
    }
    return self;
}

- (UIView *)tableViewCellView{

    UIView * cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 309, 109-42+0.5)] autorelease];//整个cell的view
    cellView.backgroundColor = [UIColor clearColor];
    cellView.userInteractionEnabled = YES;
    cellView.tag = 1101;
    
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 309, 43)];
//    headImage.image = UIImageGetImageFromName(@"bjbeidan.png");
    headImage.backgroundColor = [UIColor whiteColor];
    headImage.userInteractionEnabled = YES;
    [self.contentView addSubview:headImage];
    [headImage release];
    
    UIView * oneHeadImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 309, 0.5)];
    oneHeadImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [headImage addSubview:oneHeadImage];
    [oneHeadImage release];
    
    UIView * twoHeadImage = [[UIView alloc] initWithFrame:CGRectMake(0, 42.5, 309, 0.5)];
    twoHeadImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [headImage addSubview:twoHeadImage];
    [twoHeadImage release];
    
    
    
    changhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaoImage.backgroundColor = [UIColor clearColor];
    changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
    [headImage addSubview:changhaoImage];
    [changhaoImage release];
    
    seletChanghaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    seletChanghaoImage.backgroundColor = [UIColor clearColor];
    seletChanghaoImage.image = UIImageGetImageFromName(@"changhaodan.png");
    seletChanghaoImage.hidden = YES;
    [headImage addSubview:seletChanghaoImage];
    [seletChanghaoImage release];
    
    changhaola = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, 25, 12)];
    changhaola.backgroundColor = [UIColor clearColor];
    changhaola.textAlignment = NSTextAlignmentCenter;
    changhaola.font = [UIFont systemFontOfSize:9];
    //    changhaola.text = @"233";
    changhaola.textColor  = [UIColor whiteColor];
    [headImage addSubview:changhaola];
    [changhaola release];
    
    //德甲还是什么..
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 49, 13)];
    eventLabel.textAlignment = NSTextAlignmentLeft;
    eventLabel.font = [UIFont systemFontOfSize: 9];
    eventLabel.backgroundColor = [UIColor clearColor];
    eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];
    [headImage addSubview:eventLabel];
    [eventLabel release];
    
    //时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 26, 59, 14)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [headImage addSubview:timeLabel];
    [timeLabel release];
    
    
    //主队
    homeduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 16, 83, 14)];
    homeduiLabel.textAlignment = NSTextAlignmentCenter;
    homeduiLabel.font = [UIFont boldSystemFontOfSize:14];
    homeduiLabel.backgroundColor = [UIColor clearColor];
    homeduiLabel.textColor = [UIColor blackColor];
    [headImage addSubview:homeduiLabel];
    [homeduiLabel release];
    
    vsImage = [[UIImageView alloc] initWithFrame:CGRectMake(164, 16, 18, 15)];
    vsImage.backgroundColor = [UIColor clearColor];
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    [headImage addSubview:vsImage];
    [vsImage release];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 16, 205-138 - 20, 14)];
    bifenLabel.textAlignment = NSTextAlignmentCenter;
    bifenLabel.font = [UIFont boldSystemFontOfSize:14];
    bifenLabel.backgroundColor = [UIColor clearColor];
    bifenLabel.textColor = [UIColor blackColor];
    bifenLabel.hidden = YES;
//    bifenLabel.text = @"234:234";
    [headImage addSubview:bifenLabel];
    [bifenLabel release];
    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(195,16, 73, 14)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    [headImage addSubview:keduiLabel];
    [keduiLabel release];
    
    
    
    
    UIImageView * rangImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.5, 0, 20, 32)];
    rangImage.backgroundColor = [UIColor colorWithRed:223/255.0 green:182/255.0 blue:216/255.0 alpha:1];
//    rangImage.image = UIImageGetImageFromName(@"hhfrqimage.png");
    [cellView  addSubview:rangImage];
    [rangImage release];
    
    UIImageView * rangImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0.5, 32.5, 20, 32)];
    rangImage2.backgroundColor = [UIColor colorWithRed:181/255.0 green:220/255.0 blue:223/255.0 alpha:1];
//    rangImage2.image = UIImageGetImageFromName(@"hhrqimage.png");
    [cellView  addSubview:rangImage2];
    [rangImage2 release];

    
    UILabel * frqLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 2, 10, 29)];
    frqLabel.font = [UIFont systemFontOfSize:7];
    frqLabel.backgroundColor = [UIColor clearColor];
    frqLabel.textAlignment = NSTextAlignmentCenter;
    frqLabel.textColor = [UIColor colorWithRed:160/255.0 green:68/255.0 blue:142/255.0 alpha:1];
    frqLabel.lineBreakMode = NSLineBreakByWordWrapping;
    frqLabel.numberOfLines = 0;
    frqLabel.text = @"非让球";
    [rangImage addSubview:frqLabel];
    [frqLabel release];
    
    UILabel * rqLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 2, 10, 29)];
    rqLabel.font = [UIFont systemFontOfSize:7];
    rqLabel.textAlignment = NSTextAlignmentCenter;
    rqLabel.backgroundColor = [UIColor clearColor];
    rqLabel.textColor = [UIColor colorWithRed:61/255.0 green:111/255.0 blue:115/255.0 alpha:1];
    rqLabel.lineBreakMode = NSLineBreakByWordWrapping;
    rqLabel.numberOfLines = 0;
    rqLabel.text = @"让球";
    [rangImage2 addSubview:rqLabel];
    [rqLabel release];
//
//
    
    
    matchImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 0, 232.5, 64.5)];
    matchImage.backgroundColor = [UIColor clearColor];
    matchImage.userInteractionEnabled = YES;
//    matchImage.image = UIImageGetImageFromName(@"matchbgImage.png");
    [cellView addSubview:matchImage];
    [matchImage release];
    
    NSInteger tagInt = 1;
    for (int i = 0; i < 6; i++) {
        
        UIButton * matchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
//        [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateDisabled];
        matchButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:247/255.0 alpha:1];
        [matchButton addTarget:self action:@selector(pressItemButton:) forControlEvents:UIControlEventTouchUpInside];
        matchButton.tag = tagInt;
        if (i < 3) {
            matchButton.frame = CGRectMake((i*77) + (i*0.5), 0, 77, 32);
        }else{
            matchButton.frame = CGRectMake(((i-3)*77) + ((i-3)*0.5), 32, 77,33);
        }
        [matchImage addSubview:matchButton];
        
       
        
        UIImageView * bgimage = [[UIImageView alloc] initWithFrame:matchButton.bounds];
        bgimage.tag = tagInt * 12;
        bgimage.hidden = YES;
        bgimage.backgroundColor = [UIColor colorWithRed:38/255.0 green:149/255.0 blue:254/255.0 alpha:1];
//        bgimage.image = UIImageGetImageFromName(@"yibanxuanzhong.png");
        [matchButton addSubview:bgimage];
        [bgimage release];
        
        UIImageView * bgimage2 = [[UIImageView alloc] initWithFrame:matchButton.bounds];
        bgimage2.tag = tagInt * 13;
        bgimage2.hidden = YES;
        bgimage2.backgroundColor = [UIColor colorWithRed:125/255.0 green:0 blue:189/255.0 alpha:1];
//        bgimage2.image=  UIImageGetImageFromName(@"shedanxuanzhogn.png");
        [matchButton addSubview:bgimage2];
        [bgimage2 release];
        
        
        UILabel * matchLabel = [[UILabel alloc] initWithFrame:matchButton.bounds];
        matchLabel.font = [UIFont systemFontOfSize:13];
        matchLabel.textAlignment = NSTextAlignmentCenter;
        matchLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        matchLabel.backgroundColor = [UIColor clearColor];
        matchLabel.tag = (i+1)*100;
        [matchButton addSubview:matchLabel];
        [matchLabel release];
        
        if (i == 3) {
            UILabel * rangLabel = [[UILabel alloc] initWithFrame:matchButton.bounds];//让球
            rangLabel.font = [UIFont systemFontOfSize:11];
            rangLabel.textAlignment = NSTextAlignmentCenter;
            rangLabel.textColor = [UIColor colorWithRed:51/255.0 green:103/255.0 blue:0/255.0 alpha:1];
            rangLabel.backgroundColor = [UIColor clearColor];
            rangLabel.tag = 1001;
            [matchButton addSubview:rangLabel];
            [rangLabel release];
        }
        
        UIImageView * winIma = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 10, 10)];
        winIma.backgroundColor = [UIColor clearColor];
        winIma.tag = (i+1)*1000;
        winIma.hidden = YES;
        winIma.image=  UIImageGetImageFromName(@"hongnew.png");
        [matchButton addSubview:winIma];
        [winIma release];
        
        tagInt+=1;
    }
    

    
    XIDANImageView = [[UIImageView alloc] initWithFrame:CGRectMake(253.5, 0, 55, 64.5)];
    XIDANImageView.backgroundColor = [UIColor clearColor];
    
    XIDANImageView.userInteractionEnabled = YES;
    XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
    
    UIButton * xidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xidanButton.frame = XIDANImageView.bounds;
    [xidanButton addTarget:self action:@selector(pressHeadButton:) forControlEvents:UIControlEventTouchUpInside];
    [XIDANImageView addSubview:xidanButton];

    
    butTitle = [[UILabel alloc] init];
    butTitle.frame = CGRectMake(0, 42, 55, 20);
    butTitle.font = [UIFont systemFontOfSize:11];
    butTitle.textAlignment = NSTextAlignmentCenter;
    butTitle.textColor = [UIColor colorWithRed:36/255.0 green:96/255.0 blue:114/255.0 alpha:1];
    butTitle.backgroundColor = [UIColor clearColor];
    [XIDANImageView addSubview:butTitle];
    [butTitle release];
    
    [cellView addSubview:XIDANImageView];
    [XIDANImageView release];
    
    zhegaiview = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhegaiview addTarget:self action:@selector(presszhegaiviewButton:) forControlEvents:UIControlEventTouchUpInside];
    zhegaiview.frame=  CGRectMake(0, 0, 309 - 55,  109-43);
    //    zhegaiview  = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 251, 50)];
    zhegaiview.backgroundColor = [UIColor clearColor];
    zhegaiview.hidden= YES;
    [cellView addSubview:zhegaiview];
    
    
   
    //按钮上显示3
    datal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
   
    datal1.font = [UIFont systemFontOfSize:15];
    datal1.textAlignment = NSTextAlignmentCenter;
    datal1.backgroundColor = [UIColor clearColor];

    //按钮上显示1
    datal2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    datal2.text = @"1";
    datal2.font = [UIFont systemFontOfSize:15];
    datal2.textAlignment = NSTextAlignmentCenter;
    datal2.backgroundColor = [UIColor clearColor];
    
    //按钮上显示0
    datal3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    datal3.text = @"0";
    datal3.font = [UIFont systemFontOfSize:15];
    datal3.textAlignment = NSTextAlignmentCenter;
    datal3.backgroundColor = [UIColor clearColor];

    datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    datal1.frame = CGRectMake(3, 0, 15, 32);
    datal2.frame = CGRectMake(3, 0, 15, 32);
    datal3.frame = CGRectMake(3, 0, 15, 32);
    datal1.font = [UIFont systemFontOfSize:10];
    datal2.font = [UIFont systemFontOfSize:10];
    datal3.font = [UIFont systemFontOfSize:10];
    datal1.text = @"胜";
    datal2.text = @"平";
    datal3.text = @"负";
    UIButton * mbut = (UIButton *)[matchImage viewWithTag:1];
    UIButton * mbut2 = (UIButton *)[matchImage viewWithTag:2];
    UIButton * mbut3 = (UIButton *)[matchImage viewWithTag:3];
    [mbut addSubview:datal1];
    [mbut2 addSubview:datal2];
    [mbut3 addSubview:datal3];
    [datal1 release];
    [datal2 release];
    [datal3 release];
    
    
    duckImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 0)];//鸭子图片
    duckImageOne.backgroundColor = [UIColor clearColor];
    duckImageOne.image = [UIImageGetImageFromName(@"huntouyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageOne.hidden = YES;
    [mbut addSubview:duckImageOne];
    [duckImageOne release];
    
    duckImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 0)];//鸭子图片
    duckImageTwo.backgroundColor = [UIColor clearColor];
    duckImageTwo.image = [UIImageGetImageFromName(@"huntouyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageTwo.hidden = YES;
    [mbut2 addSubview:duckImageTwo];
    [duckImageTwo release];
    
    duckImageThree = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 0)];//鸭子图片
    duckImageThree.backgroundColor = [UIColor clearColor];
    duckImageThree.image = [UIImageGetImageFromName(@"huntouyazi.png") stretchableImageWithLeftCapWidth:20 topCapHeight:28];
    duckImageThree.hidden = YES;
    [mbut3 addSubview:duckImageThree];
    [duckImageThree release];

    

//    UIImageView * yinying = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 300, 2)];
//    yinying.backgroundColor = [UIColor clearColor];
//    yinying.image= [UIImageGetImageFromName(@"yinyinghuntou.png") stretchableImageWithLeftCapWidth:6 topCapHeight:1];
//    [cellView insertSubview:yinying atIndex:1000];
//    [yinying release];
    
    UIView * linebutton = [[UIView alloc] initWithFrame:CGRectMake(0, 32, 253.5, 0.5)];
    linebutton.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [cellView addSubview:linebutton];
    [linebutton release];
    
    UIView * linebutton2 = [[UIView alloc] initWithFrame:CGRectMake(20.5, 0, 0.5, 64.5)];
    linebutton2.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [cellView addSubview:linebutton2];
    [linebutton2 release];
    
    UIView * linebutton3 = [[UIView alloc] initWithFrame:CGRectMake(77, 0, 0.5, 64.5)];
    linebutton3.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [matchImage addSubview:linebutton3];
    [linebutton3 release];
    
    UIView * linebutton4 = [[UIView alloc] initWithFrame:CGRectMake(154.5, 0, 0.5, 64.5)];
    linebutton4.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [matchImage addSubview:linebutton4];
    [linebutton4 release];
    
    UIView * linebutton5 = [[UIView alloc] initWithFrame:CGRectMake(232, 0, 0.5, 64.5)];
    linebutton5.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    [matchImage addSubview:linebutton5];
    [linebutton5 release];
    
    
    UIImageView * shuImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 3, 0.5, 108.5)];
    shuImage.tag = 1890;
    shuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    shuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:shuImage];

    [shuImage release];
    
    UIImageView * hengImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 107.5+3, 309, 1.5)];
    hengImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    hengImage.tag = 1762;
    //    hengImage.image = UIImageGetImageFromName(@"rqspfheng.png");
    [self.contentView addSubview:hengImage];
    
    [hengImage release];
    
    UIImageView * houshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(308.5+5.5, 3, 0.5, 108.5)];
    houshuImage.backgroundColor = [UIColor colorWithRed:96/255.0 green:175/255.0 blue:199/255.0 alpha:1];
    //    houshuImage.image = UIImageGetImageFromName(@"rqspfshu.png");
    [self.contentView addSubview:houshuImage];
    [houshuImage release];
    
    
    
    
    onePluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    onePluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
    [matchImage addSubview:onePluralImage];
    [onePluralImage release];
    
    twoPluralImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 4, 4)];
    twoPluralImage.backgroundColor = [UIColor colorWithRed:122/255.0 green:192/255.0 blue:211/255.0 alpha:1];
    [matchImage addSubview:twoPluralImage];
    [twoPluralImage release];
    
    return cellView;
}

- (void)presszhegaiviewButton:(UIButton *)sender{

}

- (void)headShowType{
    
    if (boldan) {
//        changhaola.textColor  = [UIColor whiteColor];
        //        changhaoImage.image = UIImageGetImageFromName(@"changhaodan.png");
        seletChanghaoImage.hidden = NO;
        changhaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

    }else{
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        seletChanghaoImage.hidden = YES;
        changhaoImage.hidden = NO;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

        
        //        changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
        
    }
}

- (void)buttonShowType:(BOOL)ynbool button:(UIButton *)sender{
    //    if ([self.typeButtonArray count] < sender.tag-1 ||[betData.jiantouArray count] < sender.tag -1  ) {
    //        return;
    //    }
    UILabel * imageItem = (UILabel *)[sender viewWithTag:sender.tag*10];
    UILabel * labelItem = (UILabel *)[sender viewWithTag:sender.tag*100];
    UIImageView * bgimage = (UIImageView *)[sender viewWithTag:sender.tag*12];
    UIImageView * bgimage2 = (UIImageView *)[sender viewWithTag:sender.tag*13];

    
    if (ynbool) {
        [self.typeButtonArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
        if (pkbetdata.dandan) {
            
            bgimage.hidden = YES;
            bgimage2.hidden = NO;
         
        }else{
            bgimage.hidden = NO;
            bgimage2.hidden = YES;
                    }
        
        imageItem.textColor = [UIColor whiteColor];
        labelItem.textColor = [UIColor whiteColor];
        

        
    }else{
        
       
        bgimage.hidden = YES;
        bgimage2.hidden = YES;
        [self.typeButtonArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
        
        imageItem.textColor = [UIColor colorWithRed:92/255.0 green:150/255.0 blue:167/255.0 alpha:1];
        labelItem.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
        
          }
    
}
- (void)pressItemButton:(UIButton *)sender{
    
    
    
    if ([[self.typeButtonArray objectAtIndex:sender.tag - 1] isEqualToString:@"1"]) {
        [self buttonShowType:NO button:sender];
    }else{
        [self buttonShowType:YES button:sender];
        
    }
    
    BOOL yesOrNO = NO;
    for (int i = 0; i < [self.typeButtonArray count]; i++) {
        if ([[self.typeButtonArray objectAtIndex:i] isEqualToString:@"1"]) {
            yesOrNO = YES;
            break;
        }
    }
    
    if (yesOrNO == NO) {
        pkbetdata.dandan = NO;
        boldan = NO;
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        seletChanghaoImage.hidden = YES;
        changhaoImage.hidden = NO;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

    }else{
        
        [self headShowType];
    }
    
    [self performSelector:@selector(sleepfunc) withObject:nil afterDelay:0.1];
    
}
- (void)sleepfunc{
    
    [self returnbifenCellInfo:row shuzu:self.typeButtonArray dan:boldan];
}


//- (void)touchxibutton:(UIButton *)sender{
//    
//#ifdef isCaiPiaoForIPad
//    bgimagevv.image = UIImageGetImageFromName(@"padxiimage_1.png");
//#else
//    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12.png");
//#endif
//
//}
//- (void)TouchCancel{
//#ifdef isCaiPiaoForIPad
//    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
//#else
//    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
//#endif
//    
//    
//}
//
//- (void)TouchDragExit{
//#ifdef isCaiPiaoForIPad
//    bgimagevv.image = UIImageGetImageFromName(@"padxiimage.png");
//#else
//    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
//#endif
//    
//}

- (void)pressMatchButton:(UIButton *)sender{
    
    UILabel * matchLabel = (UILabel *)[sender viewWithTag:sender.tag*10];
    if (sender.selected == NO) {
        sender.selected = YES;
        matchLabel.textColor = [UIColor whiteColor];
        [sender setImage:UIImageGetImageFromName(@"duimingimage_1.png") forState:UIControlStateNormal];
    }else{
        sender.selected = NO;
        matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
        [sender setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
    }
    
    NSMutableArray * muarr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 6; i++) {
        UIButton * matchtButton = (UIButton *)[matchImage viewWithTag:(i+1)*10];
        [muarr addObject:[NSString stringWithFormat:@"%d", matchtButton.selected]];
    }
    pkbetdata.bufshuarr = nil;
    pkbetdata.bufshuarr = muarr;
    
//    [NSThread detachNewThreadSelector:@selector(threadFunc:) toTarget:self withObject:muarr];
    [self returnbifenCellInfo:count shuzu:muarr dan:dan];
    
    [muarr release];
    
}

- (void)threadFunc:(NSMutableArray *)array{

    [self returnbifenCellInfo:count shuzu:array dan:dan];
}

- (void)pressXiButton:(UIButton *)sender{
    duckImageOne.hidden = YES;
    duckImageTwo.hidden = YES;
    duckImageThree.hidden = YES;

        [self returncellrownumbifen:row CP_CanOpenCell:self];


//    bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
}
//数据的get
- (GC_BetData *)pkbetdata{
    return pkbetdata;
}

- (void)setPkbetdata:(GC_BetData *)_pkbetdata{
    if (pkbetdata != _pkbetdata) {
        [pkbetdata release];
        pkbetdata = [_pkbetdata retain];
    }
    if ([pkbetdata.bufshuarr count] < 6) {
        pkbetdata.bufshuarr = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0", nil];
    }
     boldan = _pkbetdata.dandan;
    self.typeButtonArray = [NSMutableArray arrayWithArray:pkbetdata.bufshuarr] ;
    duckImageOne.hidden = YES;
    duckImageTwo.hidden = YES;
    duckImageThree.hidden = YES;
    
    if (self.butonScrollView.contentOffset.x != 0) {
        
        if (buttonBool) {
            
            [UIView beginAnimations:@"nddd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            buttonBool = NO;
        }else{
            
            self.butonScrollView.contentOffset = CGPointMake(0, self.butonScrollView.contentOffset.y);
        }
        XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
    }
    
    timeLabel.text = [NSString stringWithFormat:@"%@ 截止", _pkbetdata.time ];
    dan = _pkbetdata.booldan;
    pkbetdata.but1 = @"";
    pkbetdata.but2= @"";
    pkbetdata.but3 = @"";
    changhaola.text = [_pkbetdata.numzhou substringWithRange:NSMakeRange(2, 3)];
    eventLabel.text = _pkbetdata.event;
    xidancount = _pkbetdata.xidanCount;
     donghua = _pkbetdata.donghuarow;
    
    NSLog(@"_pkbetdata.onePlural = %@", _pkbetdata.onePlural);
    if ([_pkbetdata.onePlural rangeOfString:@" 0,"].location != NSNotFound || [_pkbetdata.onePlural rangeOfString:@" 15, 1,"].location != NSNotFound|| [_pkbetdata.onePlural rangeOfString:@" 1, 15,"].location != NSNotFound) {//判断 是否是单复式
        onePluralImage.hidden = YES;
        twoPluralImage.hidden = YES;
        
    }else if ([_pkbetdata.onePlural rangeOfString:@" 1,"].location != NSNotFound){
        onePluralImage.hidden = YES;
        twoPluralImage.hidden = NO;
    }else if ([_pkbetdata.onePlural rangeOfString:@" 15,"].location != NSNotFound){
        onePluralImage.hidden = NO;
        twoPluralImage.hidden = YES;
    }else{
        onePluralImage.hidden = YES;
        twoPluralImage.hidden = YES;
    }
    
    
    if (_pkbetdata.dandan) {
//        changhaoImage.image = UIImageGetImageFromName(@"changhaoimage_1.png");
        seletChanghaoImage.hidden = NO;
        changhaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:146/255.0 green:12/255.0 blue:202/255.0 alpha:1];

//        changhaola.textColor  = [UIColor whiteColor];
    }else{
        changhaoImage.hidden = NO;
        seletChanghaoImage.hidden = YES;
        eventLabel.textColor = [UIColor colorWithRed:82/255.0 green:160/255.0 blue:71/255.0 alpha:1];

//        changhaoImage.image = UIImageGetImageFromName(@"changhaoimage.png");
//        changhaola.textColor  = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    if (_pkbetdata.dandan) {
        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
        
    }else{
        
        UIButton * danbutton = (UIButton *) [self.butonScrollView viewWithTag:1];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
    }
    
    if ([eventLabel.text length] > 5) {
        eventLabel.text = [eventLabel.text substringToIndex:5];
    }
     NSArray * teamarray = [_pkbetdata.team componentsSeparatedByString:@","];
    if ([teamarray count] < 3) {
        teamarray = [NSArray arrayWithObjects:@"", @"", @"", nil];
    }
    homeduiLabel.text = [teamarray objectAtIndex:0];
    keduiLabel.text = [teamarray objectAtIndex:1];
    
    if ([homeduiLabel.text length] > 5) {
        homeduiLabel.text = [homeduiLabel.text substringToIndex:5];
    }
//    homeduiLabel.text = @"的事发地点";
    if ([keduiLabel.text length] > 5) {
        keduiLabel.text = [keduiLabel.text substringToIndex:5];
    }
//     keduiLabel.text = @"的事发地点";
//    if (self.butonScrollView.hidden == NO) {
//        XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght_1.png");
//        xiButton.hidden = YES;
//    }else{
        XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
//        xiButton.hidden = NO;
//    }

    
   
    
    
    
   
   
    
    vsImage.image = UIImageGetImageFromName(@"vsimage.png");
    vsImage.frame = CGRectMake(164, 16, 18, 15);
    zhegaiview.hidden = YES;
    NSInteger peilvKong = 100;
    if (wangqibool || wangqiTwoBool) {
        zhegaiview.hidden = NO;
        bifenLabel.hidden = NO;
        vsImage.hidden = YES;
        timeLabel.text = @"完";
        
        if (pkbetdata.bifen&&![_pkbetdata.bifen isEqualToString:@"-"]) {
//            bifenLabel.text = pkbetdata.bifen;
            NSArray *scores = [_pkbetdata.bifen componentsSeparatedByString:@","];
            //            _pkbetdata.caiguo
            if ([scores count] >= 4) {
                bifenLabel.text = [NSString stringWithFormat:@"%@:%@", [scores objectAtIndex:2], [scores objectAtIndex:3]];
            }
            
        }else{
            bifenLabel.text = @"-";
        }
        
       
        if ([pkbetdata.macthType isEqualToString:@"overtime"]) {
            bifenLabel.hidden = YES;
            vsImage.frame = CGRectMake(156, 18, 34, 12);
            vsImage.image = UIImageGetImageFromName(@"spfyijiezhi.png");
            vsImage.hidden = NO;
            NSArray * timedata = [pkbetdata.macthTime componentsSeparatedByString:@" "];
            if ([timedata count] >= 2) {
                timeLabel.text = [NSString stringWithFormat:@"%@ 开赛", [timedata objectAtIndex:1] ];
                timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
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
                timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
            }else{
                timeLabel.text = @"-";
            }
        }else  if ([pkbetdata.macthType isEqualToString:@"gameover"]) {
            bifenLabel.hidden = NO;
            timeLabel.text = @"完";
            timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
            
        }else if ([pkbetdata.macthType isEqualToString:@"delay"]){
            
            bifenLabel.hidden = YES;
            vsImage.frame = CGRectMake(161, 18, 23, 12);
            vsImage.image = UIImageGetImageFromName(@"yanqiimagespf.png");
            vsImage.hidden = NO;
            timeLabel.text = @"延期";
            
        }else if ([pkbetdata.macthType isEqualToString:@"playvs"]){
        
            timeLabel.text = @"-";
            timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
            bifenLabel.hidden = YES;
        }
        
        if (pkbetdata.caiguo) {
            NSArray * caiguoArr = [pkbetdata.caiguo componentsSeparatedByString:@"]-["];
            NSString * caiGuoOne = @"";
            NSString * caiGuoTwo = @"";
            if ([caiguoArr count] > 1) {
              caiGuoOne = [[caiguoArr objectAtIndex:0] substringWithRange:NSMakeRange(1, 1)];
                NSLog(@"caiguo one = %@", caiGuoOne);
              caiGuoTwo  = [[caiguoArr objectAtIndex:1] substringWithRange:NSMakeRange(2, 1)];
                NSLog(@"caiguo two = %@", caiGuoTwo);
            }
            
                

                
                
                NSArray * caiArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", [caiGuoOne isEqualToString:@"胜"]], [NSString stringWithFormat:@"%d", [caiGuoOne isEqualToString:@"平"]], [NSString stringWithFormat:@"%d", [caiGuoOne isEqualToString:@"负"]],[NSString stringWithFormat:@"%d", [caiGuoTwo isEqualToString:@"胜"]], [NSString stringWithFormat:@"%d", [caiGuoTwo isEqualToString:@"平"]], [NSString stringWithFormat:@"%d", [caiGuoTwo isEqualToString:@"负"]], nil];//拼彩果
                
                NSMutableArray * mutableCaiArr = [[NSMutableArray alloc] initWithCapacity:0];
                [mutableCaiArr addObjectsFromArray:caiArr];
                
                pkbetdata.bufshuarr = mutableCaiArr;
                [mutableCaiArr release];
                
                NSLog(@"xxx = %@", pkbetdata.bufshuarr);
                
                for (int i = 0;  i < 6; i++) {//按钮上的label赔率的赋值
                    UIButton * matchButton = (UIButton *)[matchImage  viewWithTag:i+1];
                    UILabel * matchLabel = (UILabel *)[matchButton viewWithTag:(i+1)*100];
                    UIImageView * winImage = (UIImageView *)[matchButton viewWithTag:(i+1)*1000];//(i+1)*1000
                    UIImageView * bgimage = (UIImageView *)[matchButton viewWithTag:matchButton.tag*12];
                    UIImageView * bgimage2 = (UIImageView *)[matchButton viewWithTag:matchButton.tag*13];
                    bgimage.hidden = YES;
                    bgimage2.hidden = YES;
//                    UIButton * matchButton = (UIButton *)[matchImage  viewWithTag:(i+1)*10];
                     matchButton.enabled = NO;
                    matchButton.selected = NO;
//                    UILabel * matchLabel = (UILabel *)[matchButton viewWithTag:(i+1)*100];
//                    UIImageView * winImage = (UIImageView *)[matchButton viewWithTag:(i+1)*1000];
                    winImage.hidden = YES;
                    if ([pkbetdata.oupeiarr count] > i) {
                        matchLabel.text = [pkbetdata.oupeiarr objectAtIndex:i];
                    }
                    if ([matchLabel.text isEqualToString:@"-"]) {//判断是否有赔率
                        matchLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//                        matchButton.enabled = NO;
//                        matchButton.selected = NO;
                        
                        
                    }else{
                        
//                        matchButton.enabled = YES;
                        matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                        
                    }
                    
                    
                    if ([pkbetdata.bufshuarr count] > i) { // 初始化赋值
                        if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
//                            [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
                            if (![pkbetdata.macthType isEqualToString:@"playvs"]){
                                matchLabel.textColor = [UIColor redColor];
                                winImage.hidden = NO;
                            }
                            
                        }else{
//                            [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
                           matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                            
                            winImage.hidden = YES;
                            if ([pkbetdata.macthType isEqualToString:@"onLive"] ||[pkbetdata.macthType isEqualToString:@"overtime"]||[pkbetdata.macthType isEqualToString:@"gameover"]||[pkbetdata.macthType isEqualToString:@"delay"]) {
                                BOOL shifou = NO;
                                for (int i = 0; i < [pkbetdata.bufshuarr count]; i++) {
                                    if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                                        shifou = YES;
                                        break;
                                    }
                                }
                                if (shifou) {
                                    matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                                }else{
                                    matchLabel.textColor = [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
                                }
                                
                            }
                            
                        }
                    }else{
//                        [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];

                        matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                    }
                    
                    
                }
            caiArr = [NSArray arrayWithObjects:@"0", @"0", @"0",@"0",  @"0", @"0", nil];//拼彩果
            
            NSMutableArray * mutableCaiArr1 = [[NSMutableArray alloc] initWithCapacity:0];
            [mutableCaiArr1 addObjectsFromArray:caiArr];
            pkbetdata.bufshuarr = mutableCaiArr1;
            [mutableCaiArr1 release];
           
        }
        
        
        if ([pkbetdata.oupeiarr count] > 3) {
            if ([[pkbetdata.oupeiarr objectAtIndex:0] isEqualToString:@"-"]) {
                onePluralImage.hidden = YES;
            }
            if ([[pkbetdata.oupeiarr objectAtIndex:3] isEqualToString:@"-"]) {
                twoPluralImage.hidden = YES;
            }
        }
        
        
    }else{
        bifenLabel.hidden = YES;
        vsImage.hidden = NO;
        
        for (int i = 0;  i < 6; i++) {//按钮上的label赔率的赋值
            UIButton * matchButton = (UIButton *)[matchImage  viewWithTag:i+1];
            UILabel * matchLabel = (UILabel *)[matchButton viewWithTag:(i+1)*100];
            UIImageView * winImage = (UIImageView *)[matchButton viewWithTag:(i+1)*1000];//(i+1)*1000
            UIImageView * bgimage = (UIImageView *)[matchButton viewWithTag:matchButton.tag*12];
            UIImageView * bgimage2 = (UIImageView *)[matchButton viewWithTag:matchButton.tag*13];
            winImage.hidden = YES;
            if ([pkbetdata.oupeiarr count] > i) {
                matchLabel.text = [pkbetdata.oupeiarr objectAtIndex:i];
            }
            if ([matchLabel.text isEqualToString:@"-"]) {//判断是否有赔率
                matchLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                matchButton.enabled = NO;
                matchButton.selected = NO;
                peilvKong = i;
                
            }else{
                
                matchButton.enabled = YES;
                matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                
            }

           
            
            if ([pkbetdata.bufshuarr count] > i) { // 初始化赋值
                if ([[pkbetdata.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
//                    [matchButton setImage:UIImageGetImageFromName(@"duimingimage_1.png") forState:UIControlStateNormal];
                    
                    if (boldan) {
                        bgimage.hidden = YES;
                        bgimage2.hidden = NO;
                    }else{
                        bgimage2.hidden = YES;
                        bgimage.hidden = NO;
                    }
                    
                    matchButton.selected = YES;
                    matchLabel.textColor = [UIColor whiteColor];
                    
                }else{
                    bgimage.hidden = YES;
                    bgimage2.hidden = YES;
//                    [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
                    matchButton.selected = NO;
                    matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
                    
                }
            }else{
                bgimage.hidden = YES;
                bgimage2.hidden = YES;

                [matchButton setImage:UIImageGetImageFromName(@"duimingimage.png") forState:UIControlStateNormal];
                matchButton.selected = NO;
                matchLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
            }
            
            
        }
        
        if (peilvKong <= 2) {
            
            onePluralImage.hidden = YES;
        }else if (peilvKong > 2 && peilvKong < 6){
            
            twoPluralImage.hidden = YES;
        
        }
        
    }
    
    
    
    
    UIButton * matButton = (UIButton *)[matchImage  viewWithTag:4];
    UILabel * rangqiuLabel = (UILabel *)[matButton viewWithTag:1001];
    if ([teamarray count] > 2) {
        rangqiuLabel.text = [NSString stringWithFormat:@"(%@)", [teamarray objectAtIndex:2]];
    }
    UILabel * matlabel = (UILabel *)[matButton viewWithTag:4*100];
    CGSize labelSize = [matlabel.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(50, 32)];
    CGSize rangQiuSize = [rangqiuLabel.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(30, 32)];
    
    
    matlabel.frame = CGRectMake((69-labelSize.width - rangQiuSize.width)/2, 0, labelSize.width, 32);
    rangqiuLabel.frame = CGRectMake((69-labelSize.width - rangQiuSize.width)/2 + labelSize.width+2, 0, rangQiuSize.width, 32);
    if ([[teamarray objectAtIndex:2] intValue] > 0) {
        rangqiuLabel.textColor = [UIColor redColor];
    }else{
        rangqiuLabel.textColor =  [UIColor colorWithRed:51/255.0 green:103/255.0 blue:0/255.0 alpha:1];
    }
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(donghuaxizi) object:nil];
//    if (donghua == 0) {
//        [self performSelector:@selector(donghuaxizi) withObject:nil afterDelay:2];
//    }
   
    if ([pkbetdata.oneMacth isEqualToString:@"1"] && wangqibool == NO && wangqiTwoBool == NO) {
        datal1.hidden = NO;
        datal2.hidden = NO;
        datal3.hidden = NO;
        if ([pkbetdata.bufshuarr count] > 3) {
            if ([[pkbetdata.bufshuarr objectAtIndex:0] isEqualToString:@"1"]) {
                datal1.textColor = [UIColor whiteColor];
            }else{
                datal1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }
            if ([[pkbetdata.bufshuarr objectAtIndex:1] isEqualToString:@"1"]) {
                datal2.textColor = [UIColor whiteColor];
            }else{
                datal2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }
            if ([[pkbetdata.bufshuarr objectAtIndex:2] isEqualToString:@"1"]) {
                datal3.textColor = [UIColor whiteColor];
            }else{
                datal3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            }

        }
        
    }else{
        datal1.hidden = YES;
        datal2.hidden = YES;
        datal3.hidden = YES;
    }
    
    

    
    
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
- (void)contenOffSetXYFunc{
    NSInteger xcount = 0;
    if ([[self.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
        xcount =  35+ ([self.allTitleArray count]-1)*70;
    }else {
        xcount = [self.allTitleArray count]*70;
        
    }
    if (self.butonScrollView.contentOffset.x >= xcount) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            
            
            NSIndexPath * path  = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            
            [delegate returnCellContentOffsetString:path remove:NO];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"dakaixidanimage.png");
    }else if (self.butonScrollView.contentOffset.x <= 0) {
        if (delegate && [delegate respondsToSelector:@selector(returnCellContentOffsetString:remove:)]) {
            
            NSIndexPath * path = [NSIndexPath indexPathForRow:row.row inSection:row.section];
            
            [delegate returnCellContentOffsetString:path remove:YES];
        }
        XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
    }
    
}
- (void)pressHeadButton:(UIButton *)sender{

//    [self contenOffSetXYFunc];
    if ([delegate respondsToSelector:@selector(openCellHunTou:)]) {
        [delegate openCellHunTou:self];
    }
//    [xiButton setImage:UIImageGetImageFromName(@"xidanimage.png") forState:UIControlStateNormal];
//    xidancount = 0;
   
//    if ([delegate respondsToSelector:@selector(xiDanReturn:type:buttonType:)]) {
//        [delegate xiDanReturn:self type:3 buttonType:xidancount];
//    }
}
- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell{
    if ([delegate respondsToSelector:@selector(returncellrownumbifen:CP_CanOpenCell:)]) {
        [delegate returncellrownumbifen:num CP_CanOpenCell:self];
    }
    //    NSLog(@"num = %d", num);
}

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    if ([delegate respondsToSelector:@selector(returnbifenCellInfo:shuzu:dan:)]) {
        [delegate returnbifenCellInfo:index shuzu:bufshuzu dan:booldan ];
        
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




@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
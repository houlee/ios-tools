//
//  footballLotteryCell.m
//  caibo
//
//  Created by houchenguang on 13-6-19.
//
//

#import "footballLotteryCell.h"
#import "footButtonData.h"
#import "allOddsData.h"

@implementation footballLotteryCell
@synthesize fbTypeCell;
@synthesize lottery;
@synthesize delegate;
@synthesize selectButton;
@synthesize selectIndexPath;
@synthesize saveButton;


- (footballLotterData *)footBallData{
    
    return footBallData;
}


- (void)setFootBallData:(footballLotterData *)_footBallData{
    
    if (footBallData != _footBallData) {
        [footBallData release];
        footBallData = [_footBallData retain];
    }
    
    score.text = footBallData.bifen;
    guestTeam.text = footBallData.matchGuest;
    homeTeam.text = footBallData.matchHome;
    leagueMatches.text = footBallData.shortMatchName;
    endTime.text = footBallData.timeString;
    weekLabel.text = footBallData.weekString;
    matchNum.text = footBallData.numString;
    
    concedePoints.text = [NSString stringWithFormat:@"(%@)", footBallData.rq];
    if ([concedePoints.text isEqualToString:@"()"]) {
        concedePoints.hidden = YES;
//        homeTeam.frame = CGRectMake(78, 5, 50, 20);
        homeTeam.frame = CGRectMake(58, 15, 75, 20);
    }else{
        concedePoints.hidden = NO;
//        homeTeam.frame =CGRectMake(65, 5, 50, 20);
        homeTeam.frame =CGRectMake(45, 15, 75, 20);
    }
    if (lottery == jingcailanqiuType) {
        concedePoints.hidden = YES;
        guestTeam.text = footBallData.matchHome;
        homeTeam.text = footBallData.matchGuest;
    }else{
        concedePoints.hidden = NO;
    }
    
    //footballLotterData 包footButtonData 包 allOddsData
    self.saveButton = [NSMutableArray arrayWithArray: footBallData.saveButton ];
    
    if ([self.saveButton count] > 0) {
        
        
        for (int i = 0; i < [self.saveButton count]; i++) {
            
            UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:i+10];
            UILabel * caiguoLabel = (UILabel *)[footButton viewWithTag:i+20];
            UILabel * peilvLabel = (UILabel *)[footButton viewWithTag:i+30];
            UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:i+40];
            UIImageView * xiangxia = (UIImageView *)[footButton viewWithTag:i+50];
            btnbg.image = [UIImageGetImageFromName(@"zucailan.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];//让所有button都变成蓝色
            
            footButtonData * ballData = [footBallData.buttonArray objectAtIndex:i];
            if (ballData.footButtonArray&&[ballData.footButtonArray count] > 0) {
                
                xiangxia.hidden= NO;
                
            }else{
                caiguoLabel.text = ballData.bifen;
                xiangxia.hidden = YES;
            }
            
            allOddsData * allodd = [self.saveButton objectAtIndex:i];
            caiguoLabel.text = allodd.caiguo;
            peilvLabel.text = ballData.peilv;
            
            if ([caiguoLabel.text rangeOfString:@"@"].location != NSNotFound) {
                //                caiguoLabel.text = [caiguoLabel.text e]
                NSArray * atArr = [caiguoLabel.text componentsSeparatedByString:@"@"];
                if ([atArr count] > 1) {
                    caiguoLabel.text = [NSString stringWithFormat:@"%@%@", [atArr objectAtIndex:0], [atArr objectAtIndex:1]];
                }
                else {
                    caiguoLabel.text = @"";
                }
                
                
                
            }
        }
        
        
        
    }else{
        
        [self.saveButton removeAllObjects];
        for (int i = 0 ; i < [footBallData.buttonArray count]; i++) {
            
            UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:i+10];
            UILabel * caiguoLabel = (UILabel *)[footButton viewWithTag:i+20];
            UILabel * peilvLabel = (UILabel *)[footButton viewWithTag:i+30];
            UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:i+40];
            UIImageView * xiangxia = (UIImageView *)[footButton viewWithTag:i+50];
            
            if (i == 0) {
//                btnbg.image = [UIImageGetImageFromName(@"WhiteColor_Left.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
            }else if(i == footBallData.buttonArray.count - 1){
//                btnbg.image = [UIImageGetImageFromName(@"WhiteColor_Right.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
            }else{
//                btnbg.image = [UIImageGetImageFromName(@"WhiteColor_Middle.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
            }//让所有button都变成蓝色
            btnbg.image = [UIImageGetImageFromName(@"zucailan.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
            
            [(UIImageView *)[footButton viewWithTag:i + 60] setImage:[UIImage imageNamed:@"HuiHengXian.png"]];
            
//            [(UILabel *)[footButton viewWithTag:i + 20] setTextColor:[UIColor colorWithRed:62/255.0 green:114/255.0 blue:159/255.0 alpha:1]];
            
//            [(UILabel *)[footButton viewWithTag:i + 30] setTextColor:[UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1]];
            
            allOddsData * saveData = [[allOddsData alloc] init];
            
            footButtonData * ballData = [footBallData.buttonArray objectAtIndex:i];
            
            peilvLabel.text = ballData.peilv;
            saveData.peilv = ballData.peilv;
            saveData.caiguo = ballData.bifen;
            
            
            if (ballData.footButtonArray&&[ballData.footButtonArray count] > 0) {
                allOddsData * allodd = [ballData.footButtonArray objectAtIndex:0];
                caiguoLabel.text = allodd.caiguo;
                saveData.caiguo = allodd.caiguo;
                saveData.savepei = allodd.peilv;
                xiangxia.hidden= NO;
                
            }else{
                caiguoLabel.text = ballData.bifen;
                saveData.caiguo = ballData.bifen;
                xiangxia.hidden = YES;
            }
            
            if ([caiguoLabel.text rangeOfString:@"@"].location != NSNotFound) {
//                caiguoLabel.text = [caiguoLabel.text e]
                NSArray * atArr = [caiguoLabel.text componentsSeparatedByString:@"@"];
                if ([atArr count] > 1) {
                    caiguoLabel.text = [NSString stringWithFormat:@"%@%@", [atArr objectAtIndex:0], [atArr objectAtIndex:1]];
                }
                else {
                    caiguoLabel.text = @"";
                }
                
                
                
            }
            
            [self.saveButton addObject:saveData];
            [saveData release];
            
        }
        
    }
    
    
    if ([selectButton isEqualToString:@"1"]) {//根据判断 来判断哪一列的按钮是红色的
        
        UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:10];
        UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:40];
//        btnbg.image = [UIImageGetImageFromName(@"Red_Left.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        btnbg.image = [UIImageGetImageFromName(@"zucaihong.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        [(UIImageView *)[footButton viewWithTag:([selectButton intValue] + 59)] setImage:[UIImage imageNamed:@"BaiHengXian.png"]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 19)] setTextColor:[UIColor whiteColor]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 29)] setTextColor:[UIColor whiteColor]];

    }else if([selectButton isEqualToString:@"2"]){
        
        UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:11];
        UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:41];
//        btnbg.image = [UIImageGetImageFromName(@"Red_Middle.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        btnbg.image = [UIImageGetImageFromName(@"zucaihong.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        [(UIImageView *)[footButton viewWithTag:([selectButton intValue] + 59)] setImage:[UIImage imageNamed:@"BaiHengXian.png"]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 19)] setTextColor:[UIColor whiteColor]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 29)] setTextColor:[UIColor whiteColor]];
        
    }else if([selectButton isEqualToString:@"3"]){
        
        UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:12];
        UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:42];
//        btnbg.image = [UIImageGetImageFromName(@"Red_Middle.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        btnbg.image = [UIImageGetImageFromName(@"zucaihong.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        [(UIImageView *)[footButton viewWithTag:([selectButton intValue] + 59)] setImage:[UIImage imageNamed:@"BaiHengXian.png"]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 19)] setTextColor:[UIColor whiteColor]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 29)] setTextColor:[UIColor whiteColor]];
        
    }else if([selectButton isEqualToString:@"4"]){
        
        UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:13];
        UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:43];
        if ([footBallData.buttonArray count] > [selectButton intValue]) {
//            btnbg.image = [UIImageGetImageFromName(@"Red_Middle.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        }else{
//            btnbg.image = [UIImageGetImageFromName(@"Red_Right.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        }
        btnbg.image = [UIImageGetImageFromName(@"zucaihong.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        
        [(UIImageView *)[footButton viewWithTag:([selectButton intValue] + 59)] setImage:[UIImage imageNamed:@"BaiHengXian.png"]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 19)] setTextColor:[UIColor whiteColor]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 29)] setTextColor:[UIColor whiteColor]];
        
    }else if([selectButton isEqualToString:@"5"]){
        
        UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:14];
        UIImageView * btnbg = (UIImageView *)[footButton viewWithTag:44];
//        btnbg.image = [UIImageGetImageFromName(@"Red_Right.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        btnbg.image = [UIImageGetImageFromName(@"zucaihong.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        [(UIImageView *)[footButton viewWithTag:([selectButton intValue] + 59)] setImage:[UIImage imageNamed:@"BaiHengXian.png"]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 19)] setTextColor:[UIColor whiteColor]];
//        [(UILabel *)[footButton viewWithTag:([selectButton intValue] + 29)] setTextColor:[UIColor whiteColor]];
        
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier lotterType:(lotteryTypex)lotype{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *lineIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, 104.5, 320, 0.5)];
        lineIma.image=[UIImage imageNamed:@"HuiHengXian.png"];
        [self.contentView addSubview:lineIma];
        [lineIma release];
        
        lottery = lotype;
        kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
        caiguoArray = [[NSMutableArray alloc] initWithCapacity:0];
        allPeiArray = [[NSMutableArray alloc] initWithCapacity:0];
//        saveButton  = [[NSMutableArray alloc] initWithCapacity:0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
//        cellbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 69)]
        cellbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 105)];;
        cellbgImage.backgroundColor = [UIColor clearColor];
//        cellbgImage.image = UIImageGetImageFromName(@"beidancellbg.png");
        cellbgImage.userInteractionEnabled = YES;
        [self.contentView addSubview:cellbgImage];
        [cellbgImage release];
        
        
//        weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 38, 12)];
        weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 38, 15)];
        weekLabel.backgroundColor = [UIColor clearColor];
//        weekLabel.font = [UIFont boldSystemFontOfSize:10];
        weekLabel.font = [UIFont boldSystemFontOfSize:12];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        //        weekLabel.text = @"周五";
        [cellbgImage addSubview:weekLabel];
        [weekLabel release];
        
//        matchNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 38, 12)];
        matchNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 38, 20)];
        matchNum.backgroundColor = [UIColor clearColor];
//        matchNum.font = [UIFont boldSystemFontOfSize:10];
        matchNum.font = [UIFont boldSystemFontOfSize:12];
        matchNum.textAlignment = NSTextAlignmentCenter;
        matchNum.textColor=[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        //        matchNum.text = @"010";
        [cellbgImage addSubview:matchNum];
        [matchNum release];
        
        UIImageView *quanIma=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 38, 20)];
        quanIma.backgroundColor=[UIColor clearColor];
        quanIma.image=[UIImage imageNamed:@"kaijianglanquan.png"];
        [cellbgImage addSubview:quanIma];
        
//        leagueMatches = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, 38, 12)];
        leagueMatches = [[UILabel alloc] initWithFrame:CGRectMake(-5, 55, 50, 15)];
        leagueMatches.backgroundColor = [UIColor clearColor];
//        leagueMatches.font = [UIFont boldSystemFontOfSize:10];
        leagueMatches.font = [UIFont boldSystemFontOfSize:12];
        leagueMatches.textAlignment = NSTextAlignmentCenter;
        //        leagueMatches.text = @"大师傅地方";
        [cellbgImage addSubview:leagueMatches];
        [leagueMatches release];
        
//        endTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 46, 38, 12)];
        endTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 38, 15)];
        endTime.backgroundColor = [UIColor clearColor];
//        endTime.font = [UIFont boldSystemFontOfSize:10];
        endTime.font = [UIFont boldSystemFontOfSize:12];
        endTime.textAlignment = NSTextAlignmentCenter;
        //        endTime.text = @"23:34";
        [cellbgImage addSubview:endTime];
        [endTime release];
        
        
//        if (lottery == beijingdanchangType) {
//            weekLabel.hidden = NO;
//            matchNum.frame = CGRectMake(0, 22-6, 38, 12);
//            leagueMatches.frame = CGRectMake(0, 34-6, 38, 12);
//            endTime.frame = CGRectMake(0, 46-6, 38, 12);
//        }
        
        
//        homeTeam = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 50, 20)];
        homeTeam = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 70, 20)];
        homeTeam.backgroundColor = [UIColor clearColor];
//        homeTeam.font = [UIFont boldSystemFontOfSize:10];
        homeTeam.font = [UIFont boldSystemFontOfSize:11];
        homeTeam.textAlignment = NSTextAlignmentRight;
        //        homeTeam.text = @"撒旦法士大";
        [cellbgImage addSubview:homeTeam];
        [homeTeam release];
        
//        concedePoints = [[UILabel alloc] initWithFrame:CGRectMake(116, 5, 40, 20)];
        concedePoints = [[UILabel alloc] initWithFrame:CGRectMake(121, 15, 40, 20)];
        concedePoints.backgroundColor = [UIColor clearColor];
        concedePoints.font = [UIFont boldSystemFontOfSize:10];
        concedePoints.textAlignment = NSTextAlignmentLeft;
        //        concedePoints.text = @"(-23)";
        concedePoints.textColor = [UIColor lightGrayColor];
        [cellbgImage addSubview:concedePoints];
        [concedePoints release];
        
//        UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 5, 40, 20)];
        UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 15, 40, 20)];
        vsLabel.backgroundColor = [UIColor clearColor];
//        vsLabel.font = [UIFont boldSystemFontOfSize:10];
        vsLabel.font = [UIFont boldSystemFontOfSize:12];
        vsLabel.textAlignment = NSTextAlignmentLeft;
        vsLabel.text = @"vs";
        [cellbgImage addSubview:vsLabel];
        [vsLabel release];
        
//        guestTeam = [[UILabel alloc] initWithFrame:CGRectMake(166, 5, 50, 20)];
        guestTeam = [[UILabel alloc] initWithFrame:CGRectMake(160, 15, 70, 20)];
        guestTeam.backgroundColor = [UIColor clearColor];
//        guestTeam.font = [UIFont boldSystemFontOfSize:10];
        guestTeam.font = [UIFont boldSystemFontOfSize:11];
        guestTeam.textAlignment = NSTextAlignmentLeft;
        //        guestTeam.text = @"阿斯顿发的";
        [cellbgImage addSubview:guestTeam];
        [guestTeam release];
        
//        score = [[UILabel alloc] initWithFrame:CGRectMake(225, 5, 60, 20)];
        score = [[UILabel alloc] initWithFrame:CGRectMake(230, 15, 60, 20)];
        score.backgroundColor = [UIColor clearColor];
//        score.font = [UIFont boldSystemFontOfSize:10];
        score.font = [UIFont boldSystemFontOfSize:12];
        score.textAlignment = NSTextAlignmentLeft;
        //        score.text = @"5:5(-233)";
        score.textColor = [UIColor redColor];
        [cellbgImage addSubview:score];
        [score release];
        
        NSInteger count = 4;
        if (lottery == jingcaizuqiuType || lottery == beijingdanchangType) {
            count = 5;
        }
        
        for (int i = 0; i < count; i++) {
            
            UIButton * scoreButton = [UIButton buttonWithType:UIButtonTypeCustom];//cell上的button
            if (count == 4) {
//                scoreButton.frame = CGRectMake(48+60*i, 28, 60, 32);
                scoreButton.frame = CGRectMake(48+60*i, 40, 55, 50);
            }else{
//                scoreButton.frame = CGRectMake(50+47*i, 28, 47, 32);
                scoreButton.frame = CGRectMake(50+47*i, 40, 42, 50);
            }
            [scoreButton addTarget:self action:@selector(pressScoreButton:) forControlEvents:UIControlEventTouchUpInside];
            scoreButton.tag = i+10;
            [cellbgImage addSubview:scoreButton];
            
            UIImageView * buttonBg = [[UIImageView alloc] initWithFrame:scoreButton.bounds];//button上的图片
            buttonBg.backgroundColor = [UIColor clearColor];
            buttonBg.tag = i+40;
//            buttonBg.image = [UIImageGetImageFromName(@"kaijiangbuttonblue.png") stretchableImageWithLeftCapWidth:13 topCapHeight:0];
            
            
            [scoreButton addSubview:buttonBg];
            
            
            
//            UILabel * scoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonBg.frame.size.width, 16)] autorelease];//比分的label
            UILabel * scoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonBg.frame.size.width, 25)] autorelease];
            scoreLabel.backgroundColor = [UIColor clearColor];
//            scoreLabel.font = [UIFont boldSystemFontOfSize:8];
            scoreLabel.font = [UIFont boldSystemFontOfSize:10];
            scoreLabel.textColor=[UIColor whiteColor];
            scoreLabel.textAlignment = NSTextAlignmentCenter;
            //            scoreLabel.text = @"5:5";
            scoreLabel.tag = i+20;
            [scoreButton addSubview:scoreLabel];
            
//            UILabel * peilvLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 16, buttonBg.frame.size.width, 16)] autorelease];//赔率的label
            UILabel * peilvLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 25, buttonBg.frame.size.width, 25)] autorelease];
            peilvLabel.backgroundColor = [UIColor clearColor];
//            peilvLabel.font = [UIFont boldSystemFontOfSize:8];
            peilvLabel.font = [UIFont boldSystemFontOfSize:10];
            peilvLabel.textAlignment = NSTextAlignmentCenter;
            peilvLabel.textColor=[UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1];
            //            peilvLabel.text = @"5.342";
            peilvLabel.tag = i+30;
            [scoreButton addSubview:peilvLabel];

//            UIImageView * horizontalLine = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 15.7, buttonBg.frame.size.width, 0.5)] autorelease];
            UIImageView * horizontalLine = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 24.7, buttonBg.frame.size.width, 0.5)] autorelease];
//            [scoreButton addSubview:horizontalLine];
            horizontalLine.userInteractionEnabled = YES;
            horizontalLine.tag = i+60;

            if (i < count -1) {
                UIImageView * verticalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HuiShuXian.png"]];
                verticalLine.frame = CGRectMake(buttonBg.frame.size.width-0.5, 0, 1, buttonBg.frame.size.height);
//                [scoreButton addSubview:verticalLine];
                verticalLine.userInteractionEnabled = YES;
                [verticalLine release];
            }
            
            
            UIImageView * xialaiamge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 7)];
            
            if (count == 4) {
                
                xialaiamge.frame = CGRectMake(46, 4, 8, 7);
            }else{
                
                xialaiamge.frame = CGRectMake(32, 4, 8, 7);
            }
            
            xialaiamge.backgroundColor = [UIColor clearColor];
//            xialaiamge.image = UIImageGetImageFromName(@"lanqiuxialaimage.png");
            xialaiamge.image = UIImageGetImageFromName(@"SanJiao.png");
            xialaiamge.tag = i+50;
            xialaiamge.hidden = YES;
            [scoreButton addSubview:xialaiamge];
            [xialaiamge release];
        }
        
    }
    return self;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

- (void)pressScoreButton:(UIButton *)sender{
    
    
    [self selectButtonReturn:sender mutableArray:self.saveButton index:selectIndexPath];
    
   
    buttonTag = sender.tag;
    footButtonData * ballData = [footBallData.buttonArray objectAtIndex:sender.tag-10];
    
    allOddsData * allodd = [ballData.footButtonArray objectAtIndex:0];
    
    if ([ballData.footButtonArray count]>1) {
        
        NSMutableArray * array = [NSMutableArray array];
        
        
        NSString * str = @"  ";
        
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"title", caiguoArray,@"choose", nil];
        
        
        
        
        [caiguoArray removeAllObjects];
        [allPeiArray removeAllObjects];
        for (int i = 0; i < [ballData.footButtonArray count]; i++) {
            
            allOddsData * allodd2 = [ballData.footButtonArray objectAtIndex:i];
            [caiguoArray addObject:allodd2.peilv];
            [allPeiArray addObject:allodd2];
            
        }
        
        
      
        
        if ([kongzhiType count] == 0 ) {
            NSMutableArray * issarr = [NSMutableArray array];
            for (int i = 0; i < [caiguoArray count]; i++) {
                NSString * str = [caiguoArray objectAtIndex:i];
                if ([str isEqualToString:allodd.peilv]) {
                    [issarr addObject:@"1"];
                }else{
                    [issarr addObject:@"0"];
                }
                
            }
            
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
            [kongzhiType removeAllObjects];
            [kongzhiType addObject:type1];
            
        }else{
         allOddsData * allodd3 = [self.saveButton objectAtIndex:buttonTag-10];
            NSLog(@"all = %@", allodd3.savepei);
            NSMutableArray * issarr = [NSMutableArray array];
            for (int i = 0; i < [caiguoArray count]; i++) {
                NSString * str = [caiguoArray objectAtIndex:i];
               
                if ([str isEqualToString:allodd3.savepei]) {
                    [issarr addObject:@"1"];
                }else{
                    [issarr addObject:@"0"];
                }
                
            }
            
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
            [kongzhiType removeAllObjects];
            [kongzhiType addObject:type1];
            
            
            
        }
        
        
        [array addObject:dic];
        
        
        
        NSString * strr = @"";
        
        
        if (lottery == jingcailanqiuType) {
            if (buttonTag == 11) {
                strr = @"大小分";
            }else if(buttonTag == 12){
                strr = @"让分";
            }
        }
        
        
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:strr ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType titleName:ballData];
        alert2.delegate = self;
        alert2.tag = 20;
        [alert2 show];
        [alert2 release];
    }
    
    
    
    //    footButtonData * ballData = [footBallData.buttonArray objectAtIndex:sender.tag-10];
    //
    //    allOddsData * allodd = [ballData.footButtonArray objectAtIndex:0];
    //     UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:sender.tag+10];
    //    UILabel * caiguoLabel = (UILabel *)[footButton viewWithTag:sender.tag+20];
    //    caiguoLabel.text = allodd.caiguo;
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if ([returnarry count] > 0) {
        NSArray * isar = [returnarry objectAtIndex:0];
        if ([isar count] > 0) {
            NSString * peilv = [isar objectAtIndex:0];
            
            for (int i = 0; i < [allPeiArray count]; i++) {
                allOddsData * allodd = [allPeiArray objectAtIndex:i];
                if ([peilv isEqualToString:allodd.peilv]) {
                    UIButton * footButton = (UIButton *)[cellbgImage viewWithTag:buttonTag];
                    UILabel * caiguoLabel = (UILabel *)[footButton viewWithTag:buttonTag -10+ 20];
                    caiguoLabel.text = allodd.caiguo;
                    
                    allOddsData * savedata = [saveButton objectAtIndex:buttonTag - 10];
                    savedata.caiguo = allodd.caiguo;
                    savedata.peilv = allodd.peilv;
                    NSLog(@"ccc= %@, ddd= %@", allodd.peilv, allodd.savepei);
                    savedata.savepei = savedata.peilv;
                    [self selectButtonReturn:footButton mutableArray:saveButton index:selectIndexPath];
                    
                    break;
                }
            }
        }
    }
    
    
    
}


- (void)selectButtonReturn:(UIButton *)sender mutableArray:(NSMutableArray *)array index:(NSIndexPath *)index{
    
    if ([delegate respondsToSelector:@selector(selectButtonReturn:mutableArray:index:)]) {
        [delegate selectButtonReturn:sender mutableArray:self.saveButton index:selectIndexPath];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
    
}

- (void)dealloc{
    [saveButton release];
    [allPeiArray release];
    [caiguoArray release];
    [kongzhiType release];
    [footBallData release];
    [selectButton release];
    [super dealloc];
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
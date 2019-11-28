//
//  FootballForecastViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-20.
//
//

#import "FootballForecastViewController.h"
#import "Info.h"
#import "YCMatchViewController.h"
#import "CombatGainsView.h"
#import "IntegralAlertView.h"
#import "caiboAppDelegate.h"
#import "BFYCIntroViewController.h"
#import "TopicThemeListViewController.h"
#import "GC_HttpService.h"
#import "NetURL.h"
#import "JSON.h"
#import <stdlib.h>
#import "UIIntegralView.h"
#import "MyWebViewController.h"
#import "CP_UIAlertView.h"


@interface FootballForecastViewController ()

@end

@implementation FootballForecastViewController
@synthesize matchShowType, analyzeDictionary, oddsDictionary;
@synthesize betData, gcIndexPath, delegate, httpRequest, numString, integralString;
@synthesize lotteryType;

- (void)alertViewFunc{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒"
                                                          message:@"暂无相关信息"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles: nil];
    
    [alert show];
    [alert release];
}

- (void)dealloc{
    [IntegralView release];
    [proportionView release];
    [twoIntegral release];
    [oneIntegral release];
    [rankingBulletinViewHead release];
    [rankingDictionary release];
    [bulletinDictionary release];
    [macthView release];
    [integralString release];
    [analyzeDictionary release];
    [oddsDictionary release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [betData release];
    [gcIndexPath release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doBack{
    if (typeBack == 1 || typeBack == 2) {
        if (delegate && [delegate respondsToSelector:@selector(footballForecastBetData:withType:indexPath:)]) {
            [delegate footballForecastBetData:self.betData withType:typeBack indexPath:gcIndexPath];
        }
    }
   

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectButtonShowFunc{ //选择按钮
    analyzeBool = YES;
    UIView * selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, self.mainView.frame.size.width, 61)];
    selectView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
    selectView.tag = 99;
    [segmentView addSubview:selectView];
    [selectView release];
    
    UIImageView * oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 162, 37)];
    oneImageView.backgroundColor = [UIColor clearColor];
    oneImageView.tag = 6;
    oneImageView.userInteractionEnabled = YES;
    oneImageView.image = [UIImageGetImageFromName(@"oupeidaxiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [selectView addSubview:oneImageView];
    [oneImageView release];
    
    UIButton * allShowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allShowButton.selected = YES;
    allShowButton.frame = CGRectMake(0, 0, 63, 37);
    allShowButton.tag = 1;
    [allShowButton setBackgroundImage:[UIImageGetImageFromName(@"xzzuoce.png") stretchableImageWithLeftCapWidth:7 topCapHeight:15] forState:UIControlStateSelected];
    [allShowButton addTarget:self action:@selector(pressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [oneImageView addSubview:allShowButton];
    
    UILabel * allShowLabel = [[UILabel alloc] initWithFrame:allShowButton.bounds];
    allShowLabel.backgroundColor = [UIColor clearColor];
    allShowLabel.textAlignment = NSTextAlignmentCenter;
    allShowLabel.font = [UIFont systemFontOfSize:13];
    allShowLabel.textColor = [UIColor whiteColor];
    allShowLabel.tag = 10;
    allShowLabel.text = @"全部显示";
    [allShowButton addSubview:allShowLabel];
    [allShowLabel release];
    
    
    UIButton * homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(63, 0, (163 - 63)/2, 37);
    homeButton.tag = 2;
    [homeButton setBackgroundImage:[UIImageGetImageFromName(@"xzzhognjian.png") stretchableImageWithLeftCapWidth:4 topCapHeight:15] forState:UIControlStateSelected];
    [homeButton addTarget:self action:@selector(pressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [oneImageView addSubview:homeButton];
    
    UILabel * homeLabel = [[UILabel alloc] initWithFrame:homeButton.bounds];
    homeLabel.backgroundColor = [UIColor clearColor];
    homeLabel.textAlignment = NSTextAlignmentCenter;
    homeLabel.font = [UIFont systemFontOfSize:13];
    homeLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    homeLabel.text = @"主场";
    homeLabel.tag = 10;
    [homeButton addSubview:homeLabel];
    [homeLabel release];
    
    UIButton * guestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    guestButton.frame = CGRectMake(63+(163 - 63)/2, 0, (163 - 63)/2, 37);
    guestButton.tag = 3;
    [guestButton setBackgroundImage:[UIImageGetImageFromName(@"xxyouce.png") stretchableImageWithLeftCapWidth:4 topCapHeight:15] forState:UIControlStateSelected];
    [guestButton addTarget:self action:@selector(pressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [oneImageView addSubview:guestButton];
    
    UILabel * guestLabel = [[UILabel alloc] initWithFrame:guestButton.bounds];
    guestLabel.backgroundColor = [UIColor clearColor];
    guestLabel.textAlignment = NSTextAlignmentCenter;
    guestLabel.font = [UIFont systemFontOfSize:13];
    guestLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    guestLabel.text = @"客场";
    guestLabel.tag = 10;
    [guestButton addSubview:guestLabel];
    [guestLabel release];
    
    
    UIImageView * twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 10 - 127, 12, 127, 37)];
    twoImageView.backgroundColor = [UIColor clearColor];
    twoImageView.tag = 7;
    twoImageView.userInteractionEnabled = YES;
    twoImageView.image = [UIImageGetImageFromName(@"oupeidaxiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [selectView addSubview:twoImageView];
    [twoImageView release];
    
    UIButton * allMatchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allMatchButton.frame = CGRectMake(0, 0, 127/2, 37);
    allMatchButton.tag = 4;
    allMatchButton.selected = YES;
   [allMatchButton setBackgroundImage:[UIImageGetImageFromName(@"xzzuoce.png") stretchableImageWithLeftCapWidth:7 topCapHeight:15] forState:UIControlStateSelected];
    [allMatchButton addTarget:self action:@selector(pressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [twoImageView addSubview:allMatchButton];
    
    UILabel * allMatchLabel = [[UILabel alloc] initWithFrame:allMatchButton.bounds];
    allMatchLabel.backgroundColor = [UIColor clearColor];
    allMatchLabel.textAlignment = NSTextAlignmentCenter;
    allMatchLabel.font = [UIFont systemFontOfSize:13];
    allMatchLabel.textColor = [UIColor whiteColor];
    allMatchLabel.text = @"全部赛事";
    allMatchLabel.tag = 10;
    [allMatchButton addSubview:allMatchLabel];
    [allMatchLabel release];
    
    UIButton * matchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    matchButton.frame = CGRectMake(127/2, 0, 127/2, 37);
    matchButton.tag = 5;
    [matchButton setBackgroundImage:[UIImageGetImageFromName(@"xxyouce.png") stretchableImageWithLeftCapWidth:4 topCapHeight:15] forState:UIControlStateSelected];
    [matchButton addTarget:self action:@selector(pressSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [twoImageView addSubview:matchButton];
    
    UILabel * matchLabel = [[UILabel alloc] initWithFrame:matchButton.bounds];
    matchLabel.backgroundColor = [UIColor clearColor];
    matchLabel.textAlignment = NSTextAlignmentCenter;
    matchLabel.font = [UIFont systemFontOfSize:13];
    matchLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    matchLabel.text = @"本赛事";
    matchLabel.tag = 10;
    [matchButton addSubview:matchLabel];
    [matchLabel release];
    
    UIButton * peilvButton = [UIButton buttonWithType:UIButtonTypeCustom];
    peilvButton.frame =  CGRectMake(320, 12, 38, 37);//320 - 48
    [peilvButton setBackgroundImage:[UIImageGetImageFromName(@"oupeidaxiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15]
                           forState:UIControlStateNormal];
    [peilvButton addTarget:self action:@selector(pressPeilvButtonButton:) forControlEvents:UIControlEventTouchUpInside];
    peilvButton.tag = 12;
    [selectView addSubview:peilvButton];
    UILabel * peilvLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 34, 37)];
    peilvLabel.backgroundColor = [UIColor clearColor];
    peilvLabel.textAlignment = NSTextAlignmentCenter;
    peilvLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    peilvLabel.font = [UIFont systemFontOfSize:13];
    peilvLabel.text = @"赔率中心";
    peilvLabel.numberOfLines = 0;
    peilvLabel.tag = 100;
    peilvLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [peilvButton addSubview:peilvLabel];
    [peilvLabel release];

    
    UIImageView * lineView22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 1)];
    lineView22.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [selectView addSubview:lineView22];
    [lineView22 release];
    
    allHight += 108;
}


- (void)pressSelectButton:(UIButton *)sender{ //选择按钮点击事件 分析中新的筛选
    
    UIView * selectView = (UIView *)[self.mainView viewWithTag:99];
    UIButton * allShowButton = (UIButton *)[selectView viewWithTag:1];
    UIButton * homeButton = (UIButton *)[selectView viewWithTag:2];
    UIButton * guestButton = (UIButton *)[selectView viewWithTag:3];
    UIButton * allMatchButton = (UIButton *)[selectView viewWithTag:4];
    UIButton * matchButton = (UIButton *)[selectView viewWithTag:5];
    
    UILabel * allShowLabel = (UILabel *)[allShowButton viewWithTag:10];
    UILabel * homeLabel = (UILabel *)[homeButton viewWithTag:10];
    UILabel * guestLabel = (UILabel *)[guestButton viewWithTag:10];
    UILabel * allMatchLabel = (UILabel *)[allMatchButton viewWithTag:10];
    UILabel * matchLabel = (UILabel *)[matchButton viewWithTag:10];
    if (sender.tag < 4) {
        allShowButton.selected = NO;
        homeButton.selected = NO;
        guestButton.selected = NO;
        allShowLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
        homeLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
        guestLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
        
    }else {
        allMatchButton.selected = NO;
        matchButton.selected = NO;
        allMatchLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
        matchLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    }
    sender.selected = YES;
    UILabel * senderLabel = (UILabel *)[sender viewWithTag:10];
    senderLabel.textColor = [UIColor whiteColor];
    
    
    NSDictionary * dataDictionary = nil;
    
    self.numString = @"";
    NSString * teamType = @"";
    NSInteger matchType = 0;
    if (allShowButton.selected && allMatchButton.selected) { // 全部显示和 全部赛事
        self.numString = @"1";
        matchType = 0;
        teamType = @"";
    }else if (homeButton.selected && allMatchButton.selected){//主场 和 全部赛事
        self.numString = @"2";
        matchType = 0;
        teamType = @"host";
    }else if (guestButton.selected && allMatchButton.selected){//客场 和 全部赛事
        self.numString = @"3";
        matchType = 0;
        teamType = @"guest";
    }else if (allShowButton.selected && matchButton.selected){//全部显示 和 本赛事
        self.numString = @"4";
        matchType = 1;
        teamType = @"";
    }else if (homeButton.selected && matchButton.selected){//主场 和 本赛事
        self.numString = @"5";
        matchType = 1;
        teamType = @"host";
    }else if (guestButton.selected && matchButton.selected){//客场 和 本赛事
        self.numString = @"6";
        matchType = 1;
        teamType = @"guest";
        
    }
     dataDictionary = [analyzeDictionary objectForKey:self.numString];
    if (!dataDictionary || [dataDictionary count] == 0) {
        
        
        [self zhanJiRequestWithTeamType:teamType matchType:matchType ];
        
    }else{
        
        CombatGainsView * oneCombat = (CombatGainsView *)[combatScrollView viewWithTag:100];
        oneCombat.homeOrguest = 1;
        oneCombat.analyzeDictionary = [analyzeDictionary objectForKey:self.numString];
        CombatGainsView * twoCombat = (CombatGainsView *)[combatScrollView viewWithTag:101];
        twoCombat.homeOrguest = 2;
        twoCombat.analyzeDictionary = [analyzeDictionary objectForKey:self.numString];
        NSArray * homeArray = [[analyzeDictionary objectForKey:self.numString] objectForKey:@"hostLeaguePlay"];
        
        NSArray * guestArray = [[analyzeDictionary objectForKey:self.numString] objectForKey:@"guestLeaguePlay"];
        
        UILabel * notAvailable = (UILabel *)[combatScrollView viewWithTag:1290];
        UILabel * notAvailableTwo = (UILabel *)[combatScrollView viewWithTag:1291];
        
        if ([homeArray count] == 0 && [guestArray count] == 0) {
            notAvailable.hidden = NO;
            notAvailableTwo.hidden = NO;
            trendType = allType;
        }else{
            combatScrollView.scrollEnabled = YES;
            notAvailable.hidden = YES;
            notAvailableTwo.hidden = YES;
            
        }
        
         [self combatScrollViewScrollEnabledFunc:homeArray array:guestArray];
        
        ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
        ListViewScrollView * twoListView = (ListViewScrollView *)[analyzeView viewWithTag:222];
        ListViewScrollView * threeListView = (ListViewScrollView *)[analyzeView viewWithTag:223];
        oneListView.keyString = self.numString;
        twoListView.keyString = self.numString;
        threeListView.keyString = @"1";
        oneListView.analyzeDictionary = analyzeDictionary;
        twoListView.analyzeDictionary = analyzeDictionary;
        threeListView.analyzeDictionary = analyzeDictionary;
        NSDictionary * dictone = [analyzeDictionary objectForKey:self.numString];
        if ([[dictone objectForKey:@"hostRecentPlay"] count] == 0) {
            oneListView.userInteractionEnabled = NO;
        }else{
            oneListView.userInteractionEnabled = YES;
        }
        NSDictionary * dicttwo = [analyzeDictionary objectForKey:self.numString];
        if ([[dicttwo objectForKey:@"guestRecentPlay"] count] == 0) {
            twoListView.userInteractionEnabled = NO;
        }else{
            twoListView.userInteractionEnabled = YES;
        }
        NSDictionary * dictthree = [analyzeDictionary objectForKey:@"1"];
        if ([[dictthree objectForKey:@"playvs"] count] == 0) {
            threeListView.userInteractionEnabled = NO;
        }else{
            threeListView.userInteractionEnabled = YES;
        }
        [self analyzeHightFunc];
//        oneListView.frame = CGRectMake(0, allHight, self.mainView.frame.size.width, oneListView.frame.size.height);
//        twoListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, twoListView.frame.size.height);
//        threeListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, threeListView.frame.size.height);
//        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//        
//        analyzeView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
    }
   
    
    
    
//    zhanJiRequest
}

- (void)pressOddsOupeiButton:(UIButton *)sender{ //选择按钮点击事件 赔率中新的筛选
    
    UIView * selectView = (UIView *)[self.mainView viewWithTag:88];
    UIButton * oupeiButton = (UIButton *)[selectView viewWithTag:1];
    UIButton * yapeiButton = (UIButton *)[selectView viewWithTag:2];
    UIButton * daxiaoButton = (UIButton *)[selectView viewWithTag:3];
    
    UILabel * oupeiLabel = (UILabel *)[oupeiButton viewWithTag:10];
    UILabel * yapeiLabel = (UILabel *)[yapeiButton viewWithTag:10];
    UILabel * daxiaoLabel = (UILabel *)[daxiaoButton viewWithTag:10];
    
    oupeiLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    yapeiLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    daxiaoLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    
    oupeiButton.selected = NO;
    yapeiButton.selected = NO;
    daxiaoButton.selected = NO;
    
    sender.selected = YES;
    UILabel * senderLabel = (UILabel *)[sender viewWithTag:10];
    senderLabel.textColor = [UIColor whiteColor];
    
    if (sender.tag == 1) {
        oddsInteger = 1;
    }else if (sender.tag == 2){
        oddsInteger = 2;
    }else if (sender.tag == 3){
        oddsInteger = 3;
    }
    [oddsTabelView reloadData];
    [self oddsHightFunc];
}

- (void)combatInfoFunc{

    infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 146, 211+14)];
    infoView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
    [combatScrollView addSubview:infoView];
    [infoView release];
    
    UILabel * jialabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 141 - 50, 25, 14)];
    jialabel.backgroundColor = [UIColor clearColor];
    jialabel.text = @"“+”";
    jialabel.textColor = [UIColor colorWithRed:251/255.0 green:0 blue:30/255.0 alpha:1];
    jialabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:jialabel];
    [jialabel release];
    
    UILabel * beilabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 141- 50, 64, 14)];
    beilabel.backgroundColor = [UIColor clearColor];
    beilabel.text = @"代表杯赛/友谊赛";
    beilabel.textColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    beilabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:beilabel];
    [beilabel release];
    
    UILabel * shulabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 155- 50, 25, 14)];
    shulabel.backgroundColor = [UIColor clearColor];
    shulabel.text = @"“数字”";
    shulabel.textColor = [UIColor colorWithRed:251/255.0 green:0 blue:30/255.0 alpha:1];
    shulabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:shulabel];
    [shulabel release];
    
    UILabel * lunlabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 155- 50, 64, 14)];
    lunlabel.backgroundColor = [UIColor clearColor];
    lunlabel.text = @"代表轮次";
    lunlabel.textColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    lunlabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:lunlabel];
    [lunlabel release];
    
    UIImageView * fangImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 171- 50, 8, 8)];
    fangImage.backgroundColor = [UIColor clearColor];
    fangImage.image = UIImageGetImageFromName(@"infofang.png");
    [infoView addSubview:fangImage];
    [fangImage release];
    
    UILabel * kelabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 169- 50, 64, 14)];
    kelabel.backgroundColor = [UIColor clearColor];
    kelabel.text = @"代表客场";
    kelabel.textColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    kelabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:kelabel];
    [kelabel release];
    
    UIImageView * yuanImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 185- 50, 8, 8)];
    yuanImage.backgroundColor = [UIColor clearColor];
    yuanImage.image = UIImageGetImageFromName(@"infoyuan.png");
    [infoView addSubview:yuanImage];
    [yuanImage release];
    
    UILabel * zhulabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 183- 50, 64, 14)];
    zhulabel.backgroundColor = [UIColor clearColor];
    zhulabel.text = @"代表主场";
    zhulabel.textColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    zhulabel.font = [UIFont systemFontOfSize:8];
    [infoView addSubview:zhulabel];
    [zhulabel release];
    
    
    

}


- (void)combatGainsFunc{

    combatView = [[UIView alloc] initWithFrame:CGRectMake(0, allHight, self.mainView.frame.size.width,211+14*2 + 37)];
    combatView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
    [analyzeView addSubview:combatView];
    [combatView release];
    
    
    
    combatScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width,211+14*2)];
    combatScrollView.backgroundColor = [UIColor clearColor];
    combatScrollView.showsHorizontalScrollIndicator = NO;
    combatScrollView.showsVerticalScrollIndicator = NO;
    combatScrollView.bounces = NO;
    combatScrollView.delegate = self;
    combatScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width * 2+146, combatView.frame.size.height-37);
    [combatView addSubview:combatScrollView];
    [combatScrollView release];
    combatScrollView.contentOffset = CGPointMake(self.mainView.frame.size.width+146, 0);
    
   
    
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(146, 0, self.mainView.frame.size.width*2, 30)];
    bgimage.backgroundColor = [UIColor whiteColor];
    [combatScrollView addSubview:bgimage];
    [bgimage release];
    
    combatLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    combatLabel.backgroundColor = [UIColor clearColor];
    combatLabel.font = [UIFont systemFontOfSize:13];
    combatLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
//    combatLabel.text = [NSString stringWithFormat:@"%@-战绩走势(更早的10场)", macthView.homeLabel.text];
    [bgimage addSubview:combatLabel];
    [combatLabel release];
    
    combatTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width+20, 0, 300, 30)];
    combatTwoLabel.backgroundColor = [UIColor clearColor];
    combatTwoLabel.font = [UIFont systemFontOfSize:13];
    combatTwoLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
//    combatTwoLabel.text = [NSString stringWithFormat:@"%@-战绩走势", macthView.homeLabel.text];
    [bgimage addSubview:combatTwoLabel];
    [combatTwoLabel release];
    
    UIImageView * shouOneImage = [[UIImageView alloc] initWithFrame:CGRectMake(bgimage.frame.size.width - 19, (bgimage.frame.size.height - 17)/2, 13, 17)];
    shouOneImage.image = UIImageGetImageFromName(@"shoushilan.png");
    [bgimage addSubview:shouOneImage];
    [shouOneImage release];
    
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(146, 30, self.mainView.frame.size.width*2, 1.5)];
    lineImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
    [combatScrollView addSubview:lineImageView];
    [lineImageView release];
    
    UIImageView * twobgimage = [[UIImageView alloc] initWithFrame:CGRectMake(146, 105+14, self.mainView.frame.size.width*2, 30)];
    twobgimage.backgroundColor = [UIColor whiteColor];
    [combatScrollView addSubview:twobgimage];
    [twobgimage release];
    
    oneCombatLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    oneCombatLabel.backgroundColor = [UIColor clearColor];
    oneCombatLabel.font = [UIFont systemFontOfSize:13];
    oneCombatLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
//    oneCombatLabel.text = [NSString stringWithFormat:@"%@-战绩走势(更早的10场)", macthView.guestLabel.text];
    [twobgimage addSubview:oneCombatLabel];
    [oneCombatLabel release];
    
    
    twoCombatLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width+20, 0, 300, 30)];
    twoCombatLabel.backgroundColor = [UIColor clearColor];
    twoCombatLabel.font = [UIFont systemFontOfSize:13];
    twoCombatLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
//    twoCombatLabel.text = [NSString stringWithFormat:@"%@-战绩走势", macthView.guestLabel.text];
    [twobgimage addSubview:twoCombatLabel];
    [twoCombatLabel release];
    
    UIImageView * twoLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(146, 135+14, self.mainView.frame.size.width*2, 1.5)];
    twoLineImageView.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
    [combatScrollView addSubview:twoLineImageView];
    [twoLineImageView release];
    
    UIImageView * shouTwoImage = [[UIImageView alloc] initWithFrame:CGRectMake(twobgimage.frame.size.width - 19, (twobgimage.frame.size.height - 17)/2, 13, 17)];
    shouTwoImage.image = UIImageGetImageFromName(@"shoushicheng.png");
    [twobgimage addSubview:shouTwoImage];
    [shouTwoImage release];
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView * shuImageView = [[UIImageView alloc] initWithFrame: CGRectMake(self.mainView.frame.size.width - 25.5 - 0.5, 31.5, 0.5, 60)];
        shuImageView.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [combatView addSubview:shuImageView];
        [shuImageView release];
        
        UIImageView * combg = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 31.5, 25.5, 60+14)];
        combg.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        [combatView addSubview:combg];
        [combg release];
        
        UIImageView * shengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 31.5, 25.5, 19.5)];
        shengImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        [combatView addSubview:shengImageView];
        [shengImageView release];
        
        UILabel * shengLabel = [[UILabel alloc] initWithFrame:shengImageView.bounds];
        shengLabel.backgroundColor = [UIColor clearColor];
        shengLabel.font = [UIFont systemFontOfSize:10];
        shengLabel.textColor = [UIColor whiteColor];
        shengLabel.text = @"胜";
        shengLabel.textAlignment = NSTextAlignmentCenter;
        [shengImageView addSubview:shengLabel];
        [shengLabel release];
        
        UIImageView * shenglineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 31.5+19.5, 25.5, 0.5)];
        shenglineImageView.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [combatView addSubview:shenglineImageView];
        [shenglineImageView release];
        
        UIImageView * pingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 51.5, 25.5, 19.5)];
        pingImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        [combatView addSubview:pingImageView];
        [pingImageView release];
        
        UILabel * pingLabel = [[UILabel alloc] initWithFrame:pingImageView.bounds];
        pingLabel.backgroundColor = [UIColor clearColor];
        pingLabel.font = [UIFont systemFontOfSize:10];
        pingLabel.textColor = [UIColor whiteColor];
        pingLabel.text = @"平";
        pingLabel.textAlignment = NSTextAlignmentCenter;
        [pingImageView addSubview:pingLabel];
        [pingLabel release];
        
        UIImageView * pinglineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 51.5+19.5, 25.5, 0.5)];
        pinglineImageView.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [combatView addSubview:pinglineImageView];
        [pinglineImageView release];
        
        UIImageView * fuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 71.5, 25.5, 19.5)];
        fuImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        [combatView addSubview:fuImageView];
        [fuImageView release];
        
        UILabel * fuLabel = [[UILabel alloc] initWithFrame:fuImageView.bounds];
        fuLabel.backgroundColor = [UIColor clearColor];
        fuLabel.font = [UIFont systemFontOfSize:10];
        fuLabel.textColor = [UIColor whiteColor];
        fuLabel.text = @"负";
        fuLabel.textAlignment = NSTextAlignmentCenter;
        [fuImageView addSubview:fuLabel];
        [fuLabel release];
        
        UIImageView * fulineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 25.5, 71.5+19.5, 25.5, 0.5)];
        fulineImageView.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [combatView addSubview:fulineImageView];
        [fulineImageView release];
        
        
        CombatGainsView * zoushiView = [[CombatGainsView alloc] initWithFrame:CGRectMake(146, 31.5, self.mainView.frame.size.width*2 - 26, 60+14)];// 走势图
        zoushiView.tag = 100+i;
        zoushiView.backgroundColor =[UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];//[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [combatScrollView addSubview:zoushiView];
        [zoushiView release];
        
        
        
//        UILabel * notAvailable = (UILabel *)[combatScrollView viewWithTag:1290];
//        UILabel * notAvailableTwo = (UILabel *)[combatScrollView viewWithTag:1291];
        
        UILabel * notAvailable = [[UILabel alloc] initWithFrame:CGRectMake(146+ 320 + (320 - 91)/2+5, 32+15, 87, 29)];
        notAvailable.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        notAvailable.textAlignment = NSTextAlignmentCenter;
        notAvailable.hidden = YES;
        notAvailable.tag = 1290+i;
        notAvailable.font = [UIFont systemFontOfSize:13];
        notAvailable.text = @"暂无";
        notAvailable.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
        [combatScrollView addSubview:notAvailable];
        [notAvailable release];
        
        
        if (i == 1) {
            combg.frame =CGRectMake(self.mainView.frame.size.width - 25.5, 136.5+14, 25.5, 60+14);

            zoushiView.frame = CGRectMake(146, 136.5+14, self.mainView.frame.size.width*2 - 26, 60+14);
            notAvailable.frame = CGRectMake(146+320 + (320 - 91)/2+5, 137+15+14, 87, 29);
            zoushiView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
            shuImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5 - 0.5, 136.5+14, 0.5, 60);
            
            shengImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 136.5+14, 25.5, 19.5);
            shengImageView.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            shenglineImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 136.5+19.5+14, 25.5, 0.5);
            
            pingImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 156.5+14, 25.5, 19.5);
            pingImageView.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            pinglineImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 156.5+19.5+14, 25.5, 0.5);
            
            fuImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 176.5+14, 25.5, 19.5);
            fuImageView.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
            fulineImageView.frame = CGRectMake(self.mainView.frame.size.width - 25.5, 176.5+19.5+14, 25.5, 0.5);
        }
    }
    
     [self combatInfoFunc];
    
    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(0, combatView.frame.size.height - 23, 118, 1)];
    lineview.backgroundColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [combatView addSubview:lineview];
    [lineview release];
    
    UILabel * zhanlabel = [[UILabel alloc] initWithFrame:CGRectMake(118 , combatView.frame.size.height - 33, combatView.frame.size.width - 118*2, 20)];
    zhanlabel.backgroundColor = [UIColor clearColor];
    zhanlabel.text = @"近期战绩";
    zhanlabel.textAlignment = NSTextAlignmentCenter;
    zhanlabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    zhanlabel.font = [UIFont systemFontOfSize:15];
    [combatView addSubview:zhanlabel];
    [zhanlabel release];
    
    UIView * twoLineview = [[UIView alloc] initWithFrame:CGRectMake(combatView.frame.size.width - 118, combatView.frame.size.height - 23, 118, 1)];
    twoLineview.backgroundColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [combatView addSubview:twoLineview];
    [twoLineview release];
   
    allHight = allHight + combatView.frame.size.height;
    
}

- (void)tableViewShowFunc{// 对阵 历史交锋

    ListViewScrollView * oneListView = [[ListViewScrollView alloc] initWithFrame:CGRectMake(0, allHight, self.mainView.frame.size.width, 98)];
    oneListView.tag = 221;
    oneListView.delegate = self;
    oneListView.delegateList = self;

    oneListView.listType = homeTeamListViewType;
    [analyzeView addSubview:oneListView];
    [oneListView release];
    

    
    ListViewScrollView * twoListView = [[ListViewScrollView alloc] initWithFrame:CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, 98)];
    twoListView.tag = 222;
    twoListView.delegate = self;
    twoListView.delegateList = self;
  
    twoListView.listType = guestTeamListViewType;
    [analyzeView addSubview:twoListView];
    [twoListView release];
    

    
    ListViewScrollView * threeListView = [[ListViewScrollView alloc] initWithFrame:CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, 98)];
    threeListView.tag = 223;
    threeListView.delegate = self;
    threeListView.delegateList = self;
  
    threeListView.listType = historyListViewType;
    [analyzeView addSubview:threeListView];
    [threeListView release];

    [self analyzeHightFunc];
//    oneListView.frame = CGRectMake(0, allHight, self.mainView.frame.size.width, oneListView.frame.size.height);
//    twoListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, twoListView.frame.size.height);
//    threeListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, threeListView.frame.size.height);
//    
//    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//    analyzeView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//    oddsView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+50);
    
    
}

- (void)oddsViewAllViewFunc{//赔率中心的页面创建
    
    oddsViewBool = YES;
    UIView * oddsSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, self.mainView.frame.size.width, 61)];
    oddsSelectView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
    oddsSelectView.tag = 88;
    [segmentView addSubview:oddsSelectView];
    [oddsSelectView release];
    
    UIImageView * oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 300, 37)];
    oneImageView.backgroundColor = [UIColor clearColor];
    oneImageView.tag = 4;
    oneImageView.userInteractionEnabled = YES;
    oneImageView.image = [UIImageGetImageFromName(@"oupeidaxiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [oddsSelectView addSubview:oneImageView];
    [oneImageView release];
    
    UIButton * oupeiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oupeiButton.frame = CGRectMake(10, 12, 100, 37);
    oupeiButton.tag = 1;
    oupeiButton.selected = YES;
    [oupeiButton setBackgroundImage:[UIImageGetImageFromName(@"xzzuoce.png") stretchableImageWithLeftCapWidth:7 topCapHeight:15] forState:UIControlStateSelected];
    [oupeiButton addTarget:self action:@selector(pressOddsOupeiButton:) forControlEvents:UIControlEventTouchUpInside];
    [oddsSelectView addSubview:oupeiButton];
    
    UILabel * oupeiLabel = [[UILabel alloc] initWithFrame:oupeiButton.bounds];
    oupeiLabel.backgroundColor = [UIColor clearColor];
    oupeiLabel.textAlignment = NSTextAlignmentCenter;
    oupeiLabel.font = [UIFont systemFontOfSize:13];
    oupeiLabel.textColor = [UIColor whiteColor];
    oupeiLabel.tag = 10;
    oupeiLabel.text = @"欧赔";
    [oupeiButton addSubview:oupeiLabel];
    [oupeiLabel release];
    
    UIButton * yapeiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yapeiButton.frame = CGRectMake(110, 12, 100, 37);
    yapeiButton.tag = 2;
    [yapeiButton setBackgroundImage:[UIImageGetImageFromName(@"xzzhognjian.png") stretchableImageWithLeftCapWidth:4 topCapHeight:15] forState:UIControlStateSelected];
    [yapeiButton addTarget:self action:@selector(pressOddsOupeiButton:) forControlEvents:UIControlEventTouchUpInside];
    [oddsSelectView addSubview:yapeiButton];
    
    UILabel * yapeiLabel = [[UILabel alloc] initWithFrame:yapeiButton.bounds];
    yapeiLabel.backgroundColor = [UIColor clearColor];
    yapeiLabel.textAlignment = NSTextAlignmentCenter;
    yapeiLabel.font = [UIFont systemFontOfSize:13];
    yapeiLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    yapeiLabel.text = @"亚赔";
    yapeiLabel.tag = 10;
    [yapeiButton addSubview:yapeiLabel];
    [yapeiLabel release];
    
    UIButton * daxiaopeiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    daxiaopeiButton.frame = CGRectMake(210, 12, 100, 37);
    daxiaopeiButton.tag = 3;
    [daxiaopeiButton setBackgroundImage:[UIImageGetImageFromName(@"xxyouce.png") stretchableImageWithLeftCapWidth:7 topCapHeight:15] forState:UIControlStateSelected];
    [daxiaopeiButton addTarget:self action:@selector(pressOddsOupeiButton:) forControlEvents:UIControlEventTouchUpInside];
    [oddsSelectView addSubview:daxiaopeiButton];
    
    UILabel * daxiaoLabel = [[UILabel alloc] initWithFrame:daxiaopeiButton.bounds];
    daxiaoLabel.backgroundColor = [UIColor clearColor];
    daxiaoLabel.textAlignment = NSTextAlignmentCenter;
    daxiaoLabel.font = [UIFont systemFontOfSize:13];
    daxiaoLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    daxiaoLabel.text = @"大小";
    daxiaoLabel.tag = 10;
    [daxiaopeiButton addSubview:daxiaoLabel];
    [daxiaoLabel release];
    
    
    UIButton * peilvButton = [UIButton buttonWithType:UIButtonTypeCustom];
    peilvButton.frame =  CGRectMake(320, 12, 38, 37);//320 - 48
    [peilvButton setBackgroundImage:[UIImageGetImageFromName(@"oupeidaxiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15]
                           forState:UIControlStateNormal];
    [peilvButton addTarget:self action:@selector(pressPeilvButtonButton:) forControlEvents:UIControlEventTouchUpInside];
    peilvButton.tag = 11;
    [oddsSelectView addSubview:peilvButton];
    UILabel * peilvLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 34, 37)];
    peilvLabel.backgroundColor = [UIColor clearColor];
    peilvLabel.textAlignment = NSTextAlignmentCenter;
    peilvLabel.textColor = [UIColor colorWithRed:22/255.0 green:137/255.0 blue:197/255.0 alpha:1];
    peilvLabel.font = [UIFont systemFontOfSize:12];
    peilvLabel.text = @"分析中心";
    peilvLabel.numberOfLines = 0;
    peilvLabel.tag = 100;
    peilvLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [peilvButton addSubview:peilvLabel];
    [peilvLabel release];
    
   
    UIImageView * lineView22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 1)];
    lineView22.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [oddsSelectView addSubview:lineView22];
    [lineView22 release];
    
//    oddsHight += oddsSelectView.frame.size.height;
    oddsHight += 108;
    oddsTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, oddsHight, self.mainView.frame.size.width, 0) style:UITableViewStylePlain];
    oddsTabelView.delegate = self;
    oddsTabelView.dataSource = self;
    oddsTabelView.backgroundColor = [UIColor clearColor];
    oddsTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    oddsTabelView.showsVerticalScrollIndicator = NO;
    oddsTabelView.scrollEnabled = NO;
    [oddsView addSubview:oddsTabelView];
    [oddsTabelView release];
    
    
//   oddsHight = oddsHight + 129*10;
    
//    oddsView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, oddsHight+50+129*10);
//    myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, oddsHight+50+129*10);
//    NSLog(@"myScrollView.hight = %f", oddsHight+50+129*10);
}

- (void)matchBetViewButtonTag:(NSInteger)tag{//赔率中心 分析中心
    
    if (oddsViewBool == NO && tag == 2) {
      
        [self oddsViewAllViewFunc];
        [self oddsCenterRequest];
        [self oddsHightFunc];
//        [self selectViewAnimationFunc:88];
//        UIView * selectView = (UIView *)[self.mainView viewWithTag:88];
//        selectView.frame = CGRectMake(selectView.frame.origin.x, macthView.frame.size.height, selectView.frame.size.width, selectView.frame.size.height);

        
    }else if (analyzeBool == NO && tag == 1){
    
        [self analyzeShow];
    }
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.52f];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.mainView cache:YES];
//    [UIView commitAnimations];
    
    if (tag == 1) {
        UIView * selectView = (UIView *)[self.mainView viewWithTag:88];
        UIView * selectViewTwo = (UIView *)[self.mainView viewWithTag:99];
        selectView.hidden = YES;
        selectViewTwo.hidden = NO;
        analyzeOrOdds = NO;
        oddsView.hidden = YES;
        analyzeView.hidden = NO;
        myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, analyzeView.frame.size.height);
//        NSLog(@"myScrollView.hight = %f", oddsHight+50+129*10);
       
        
       
        selectViewTwo.frame = CGRectMake(selectViewTwo.frame.origin.x, selectView.frame.origin.y, selectViewTwo.frame.size.width, selectViewTwo.frame.size.height);
        
        UIButton * peilvButton = (UIButton *)[selectView viewWithTag:11];
        
        if (peilvButton.frame.origin.x == 320 ) {
            [self AnimationShowAndHidden:NO];
        }else{
            [self AnimationShowAndHidden:YES];
        }
      
        
        
//        macthView.peilvLabel.text = @"赔率中心";
        [self analyzeHightFunc];
 
    }else{
//        UIView * selectView = (UIView *)[self.mainView viewWithTag:88];
//        UIView * selectViewTwo = (UIView *)[self.mainView viewWithTag:99];
//        selectView.hidden = NO;
//        selectViewTwo.hidden = YES;
        analyzeOrOdds = YES;
        oddsView.hidden = NO;
        analyzeView.hidden = YES;
        myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, oddsView.frame.size.height);
        
//        selectView.frame = CGRectMake(selectView.frame.origin.x, selectViewTwo.frame.origin.y, selectView.frame.size.width, selectView.frame.size.height);
        
//       UIButton *  peilvButton = (UIButton *)[selectViewTwo viewWithTag:12];
//        if (peilvButton.frame.origin.x == 320 ) {
//            [self AnimationShowAndHidden:NO];
//        }else{
//            [self AnimationShowAndHidden:YES];
//        }
//        macthView.peilvLabel.text = @"分析中心";
        [self oddsHightFunc];
    }
    
    
}

- (void)pressPeilvButtonButton:(UIButton *)sender{
    NSInteger tag = 0;
    if (sender.tag == 11) {
//        macthView.peilvButton.tag = 1;
        tag = 1;
    }else{
        tag = 2;
//        macthView.peilvButton.tag = 2;
    }
    [self matchBetViewButtonTag:tag];
    
    
}


//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
//    [allimage addObject:@"saiqianjianjie.png"];
    [allimage addObject:@"dignzhifbyc.png"];
//    [allimage addObject:@"weibotaolun.png"];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
//    [alltitle addObject:@"赛事简析"];
    [alltitle addObject:@"定制"];
//    [alltitle addObject:@"微博讨论"];
    
    
    caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//    }
    tln.delegate = self;
    [self.view addSubview:tln];
    [tln show];
    [tln release];

    [allimage release];
    [alltitle release];
}

- (void)returnSelectIndex:(NSInteger)index{

//    if (index == 0) {
//       
//        
//       //playid = self.betData.saishiid
//        
//        
//        BFYCIntroViewController * infoView = [[BFYCIntroViewController alloc] init];
//        infoView.playid = self.betData.saishiid;
//        infoView.title = [NSString stringWithFormat:@"%@ VS %@",macthView.homeLabel.text, macthView.guestLabel.text];
//        [self.navigationController pushViewController:infoView animated:YES];
//        [infoView release];
//        
//    }else
    
    if (index == 0){
        
         NSArray * wanArray = [[NSArray alloc] initWithObjects:@"分析中心",@"赔率中心",nil];
        
        CP_KindsOfChoose *alert2 =   [[CP_KindsOfChoose alloc] initWithTitle:@"定制" withChuanNameArray:wanArray andChuanArray:nil];
        alert2.bfycBool = YES;
        alert2.duoXuanBool = NO;
        alert2.delegate = self;
        alert2.tag = 101;
        [alert2 show];
        for (CP_XZButton *btn in alert2.backScrollView.subviews) {
            if ([btn isKindOfClass:[UIButton class]] && btn.tag == [[[NSUserDefaults standardUserDefaults] objectForKey:@"bfycCustomization"] intValue]) {
                btn.selected = YES;
            }
        }
        [alert2 release];
        [wanArray release];
    
    }else if (index == 1){
    
//        TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:[NSString stringWithFormat:@"#%@VS%@#",macthView.homeLabel.text, macthView.guestLabel.text]];
//        
//        topicThemeListVC.cpsanliu = CpSanLiuWuyes;
//        [self.navigationController pushViewController:topicThemeListVC animated:YES];
//        [topicThemeListVC release];
    }
    
}
#pragma mark -
#pragma mark CP_KindsOfChooseDelegate
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    if (chooseView.tag == 101) {
        if (buttonIndex == 1) {
            
            if ([returnarry count] == 1) {
                NSString *wanfaname = [returnarry objectAtIndex:0];
                NSLog(@"wanfaname = %@", wanfaname);
                if ([wanfaname isEqualToString:@"赔率中心"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"bfycCustomization"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"bfycCustomization"];
                }
                
                
                
            }
            
            
        }
    }
    
    
}

- (void)analyzeRequest{//分析中心数据请求

    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getBFYCAnalyzeWithPlayid:self.betData.saishiid ZhanjiSize:10 ZSTlenght:20]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(analyzeFinish:)];
     [httpRequest setDidFailSelector:@selector(failFunc:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
}


- (void)analysisFuncWhitDictionary:(NSDictionary *)dict analyzeOrOdds:(BOOL)yesorno forKey:(NSString *)key{
    NSDictionary * playinfo = [dict objectForKey:@"playinfo"];
    
    UILabel * twoLabel = (UILabel *)[teamTitleView viewWithTag:100];
    UILabel * threeLabel = (UILabel *)[teamTitleView viewWithTag:101];
    
    if ([playinfo objectForKey:@"GuestTeamName"] && [playinfo objectForKey:@"HostTeamName"]) {
         twoLabel.text = [NSString stringWithFormat:@"%@ VS %@", [playinfo objectForKey:@"HostTeamName"], [playinfo objectForKey:@"GuestTeamName"]];
    }
    
    
   
   
    
    
    macthView.homeLabel.text = [playinfo objectForKey:@"HostTeamName"];
    macthView.homeNumber.text = [playinfo objectForKey:@"HostOrder"];
//    NSArray * fafi = [[playinfo objectForKey:@"HostOrder"] componentsSeparatedByString:@" "];
//    if ([fafi count] >= 2) {
//        macthView.homeNumber.text = [fafi objectAtIndex:1];
//    }else{
//        macthView.homeNumber.text = @"";
//    }
    
    
    CGSize homeSize = [macthView.homeLabel.text sizeWithFont:macthView.homeLabel.font constrainedToSize:CGSizeMake(117, 30) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize homeNumberSize = [macthView.homeNumber.text sizeWithFont:macthView.homeNumber.font constrainedToSize:CGSizeMake(117, 13) lineBreakMode:NSLineBreakByWordWrapping];
    
    macthView.homeLabel.frame = CGRectMake((117 - homeSize.width - homeNumberSize.width - 3)/2, 23, homeSize.width, 30);
    macthView.homeNumber.frame = CGRectMake(macthView.homeLabel.frame.origin.x + macthView.homeLabel.frame.size.width + 3, 37, homeNumberSize.width, 13);
    macthView.guestLabel.text = [playinfo objectForKey:@"GuestTeamName"];
    macthView.guestNumber.text =[playinfo objectForKey:@"GuestOrder"];

//    NSArray * fafi2 = [[playinfo objectForKey:@"GuestOrder"] componentsSeparatedByString:@" "];
//    if ([fafi2 count] >= 2) {
//        macthView.guestNumber.text = [fafi2 objectAtIndex:1];
//    }else{
//        macthView.guestNumber.text = @"";
//    }

    
    CGSize guestSize = [macthView.guestLabel.text sizeWithFont:macthView.guestLabel.font constrainedToSize:CGSizeMake(117, 30) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize guestNumberSize = [macthView.guestNumber.text sizeWithFont:macthView.guestNumber.font constrainedToSize:CGSizeMake(117, 13) lineBreakMode:NSLineBreakByWordWrapping];
    
    macthView.guestNumber.frame = CGRectMake(203 + (117 - guestSize.width - guestNumberSize.width - 3)/2, 37, guestNumberSize.width, 13);
    macthView.guestLabel.frame = CGRectMake(macthView.guestNumber.frame.origin.x + macthView.guestNumber.frame.size.width + 3, 23, guestSize.width, 30);
    
    
    if ([playinfo objectForKey:@"liansailc"]) {
        if ([[playinfo objectForKey:@"liansailc"] isEqualToString:@""]) {
            macthView.competitionLabel.text = [playinfo objectForKey:@"lb"];
        }else{
            macthView.competitionLabel.text = [NSString stringWithFormat:@"%@%@轮", [playinfo objectForKey:@"lb"], [playinfo objectForKey:@"liansailc"] ];
            
        }
    }else{
        macthView.competitionLabel.text = [playinfo objectForKey:@"lb"];
    }
    
    
    
    
    
//    if ([[playinfo objectForKey:@"isGjd"] integerValue] == 1) {
//        macthView.CompetitionButton.userInteractionEnabled = NO;
//        [macthView.CompetitionButton setImage:nil forState:UIControlStateNormal];
//        [macthView.CompetitionButton setImage:nil forState:UIControlStateHighlighted];
//        macthView.competitionLabel.textColor = [UIColor blackColor];
//    }else{
//        macthView.CompetitionButton.userInteractionEnabled = YES;
//        macthView.competitionLabel.textColor = [UIColor whiteColor];
//        [macthView.CompetitionButton setImage:UIImageGetImageFromName(@"dingduanliansai.png") forState:UIControlStateNormal];
//        [macthView.CompetitionButton setImage:UIImageGetImageFromName(@"dingduanliansai_1.png") forState:UIControlStateHighlighted];
//    }
    
    
    
    NSArray * timeArray = [[playinfo objectForKey:@"PlayTime"] componentsSeparatedByString:@" "];
    if ([timeArray count] >= 2) {
        NSArray * dateArray = [[timeArray objectAtIndex:0] componentsSeparatedByString:@"-"];
        NSArray * twoArray = [[timeArray objectAtIndex:1] componentsSeparatedByString:@":"];
        if ([dateArray count] >= 3 && [twoArray count] >= 3) {
            
            if ([[playinfo objectForKey:@"Weather"] length] > 0){
                macthView.timeLabel.text = [NSString stringWithFormat:@"%@月%@日  %@:%@开赛  %@", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2], [twoArray objectAtIndex:0], [twoArray objectAtIndex:1], [playinfo objectForKey:@"Weather"]];
            }else{
                macthView.timeLabel.text = [NSString stringWithFormat:@"%@月%@日  %@:%@开赛", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2], [twoArray objectAtIndex:0], [twoArray objectAtIndex:1]];
            }
            if (lotteryType == shengfucaitype) {
                threeLabel.text = [NSString stringWithFormat:@"%d场 %@:%@开赛", (int)gcIndexPath.row+1,[twoArray objectAtIndex:0], [twoArray objectAtIndex:1]];
            }else if (lotteryType == beidantype) {
                threeLabel.text = [NSString stringWithFormat:@"%@%@场 %@:%@开赛", self.betData.numzhou, self.betData.bdnum,[twoArray objectAtIndex:0], [twoArray objectAtIndex:1]];
            } else{
                threeLabel.text = [NSString stringWithFormat:@"%@场 %@:%@开赛", self.betData.numzhou,[twoArray objectAtIndex:0], [twoArray objectAtIndex:1]];
            }
            
        }
    }
    
    if (yesorno) {//yes 说明是分析中心的数据解析 或 获取战绩的数据解析
        combatLabel.text = [NSString stringWithFormat:@"%@-战绩走势(更早的10场)", macthView.homeLabel.text];
        combatTwoLabel.text = [NSString stringWithFormat:@"%@-战绩走势", macthView.homeLabel.text];
        oneCombatLabel.text = [NSString stringWithFormat:@"%@-战绩走势(更早的10场)", macthView.guestLabel.text];
        twoCombatLabel.text = [NSString stringWithFormat:@"%@-战绩走势", macthView.guestLabel.text];
        
        [analyzeDictionary setObject:dict forKey:key];
//        ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
//        ListViewScrollView * twoListView = (ListViewScrollView *)[analyzeView viewWithTag:222];
//        ListViewScrollView * threeListView = (ListViewScrollView *)[analyzeView viewWithTag:223];
//
//        oneListView.analyzeDictionary = analyzeDictionary;
//        twoListView.analyzeDictionary = analyzeDictionary;
//        threeListView.analyzeDictionary = analyzeDictionary;
    }
    

}

- (void)combatScrollViewScrollEnabledFunc:(NSArray *)homeArray array:(NSArray *)guestArray{
    combatScrollView.contentOffset = CGPointMake(self.mainView.frame.size.width+146, 0);
    if ([homeArray count] > 10 || [guestArray count] > 10) {
        combatScrollView.scrollEnabled = YES;
        infoView.frame = CGRectMake(0, 0, 146, 211+14);
        trendType = commonType;
        
    }else if ([homeArray count] > 0 || [guestArray count] > 0) {
       combatScrollView.scrollEnabled = YES;
        infoView.frame = CGRectMake(self.mainView.frame.size.width - 28, 0, 146, 211+14);
        trendType = halfType;
    }
}

- (void)analyzeFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
     NSString *responseStr = [request responseString];
    NSLog(@"analyzeFinish = %@", responseStr);
    if (responseStr && ![responseStr isEqualToString:@"fail"]) {
        
        NSDictionary * dict = [responseStr JSONValue];
        [self analysisFuncWhitDictionary:dict analyzeOrOdds:YES forKey:@"1"];
        CombatGainsView * oneCombat = (CombatGainsView *)[combatScrollView viewWithTag:100];
        oneCombat.homeOrguest = 1;
        oneCombat.analyzeDictionary = [analyzeDictionary objectForKey:@"1"];
        CombatGainsView * twoCombat = (CombatGainsView *)[combatScrollView viewWithTag:101];
        twoCombat.homeOrguest = 2;
        twoCombat.analyzeDictionary = [analyzeDictionary objectForKey:@"1"];
        
        
        UILabel * notAvailable = (UILabel *)[combatScrollView viewWithTag:1290];
        UILabel * notAvailableTwo = (UILabel *)[combatScrollView viewWithTag:1291];
        
        if ([[oneCombat.analyzeDictionary objectForKey:@"hostLeaguePlay"] count] == 0 && [[twoCombat.analyzeDictionary objectForKey:@"guestLeaguePlay"] count] == 0) {
            notAvailable.hidden = NO;
            notAvailableTwo.hidden = NO;
            trendType = allType;
            combatScrollView.scrollEnabled = NO;
        }else{
            
            notAvailable.hidden = YES;
            notAvailableTwo.hidden = YES;
        
        }

       
        
        
        NSArray * homeArray = [[analyzeDictionary objectForKey:@"1"] objectForKey:@"hostLeaguePlay"];
        
        NSArray * guestArray = [[analyzeDictionary objectForKey:@"1"] objectForKey:@"guestLeaguePlay"];
        
        [self combatScrollViewScrollEnabledFunc:homeArray array:guestArray];
        

        
        ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
        ListViewScrollView * twoListView = (ListViewScrollView *)[analyzeView viewWithTag:222];
        ListViewScrollView * threeListView = (ListViewScrollView *)[analyzeView viewWithTag:223];
        oneListView.keyString = @"1";
        twoListView.keyString = @"1";
        threeListView.keyString = @"1";
        oneListView.analyzeDictionary = analyzeDictionary;
        twoListView.analyzeDictionary = analyzeDictionary;
        threeListView.analyzeDictionary = analyzeDictionary;
        NSDictionary * dictone = [analyzeDictionary objectForKey:@"1"];
        if ([[dictone objectForKey:@"hostRecentPlay"] count] == 0) {
            oneListView.userInteractionEnabled = NO;
        }else{
            oneListView.userInteractionEnabled = YES;
        }
        NSDictionary * dicttwo = [analyzeDictionary objectForKey:@"1"];
        if ([[dicttwo objectForKey:@"guestRecentPlay"] count] == 0) {
            twoListView.userInteractionEnabled = NO;
        }else{
            twoListView.userInteractionEnabled = YES;
        }
        NSDictionary * dictthree = [analyzeDictionary objectForKey:@"1"];
        if ([[dictthree objectForKey:@"playvs"] count] == 0) {
            threeListView.userInteractionEnabled = NO;
        }else{
            threeListView.userInteractionEnabled = YES;
        }
        [self analyzeHightFunc];
//        oneListView.frame = CGRectMake(0, allHight, self.mainView.frame.size.width, oneListView.frame.size.height);
//        twoListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, twoListView.frame.size.height);
//        threeListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, threeListView.frame.size.height);
//        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//        analyzeView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
        
    }
    
}

- (void)oddsCenterRequest{//赔率中心数据请求
    oddsInteger = 1;
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getBFYCOddsCenterWithPlayid:self.betData.saishiid playSize:10]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(oddsCenterFinish:)];
     [httpRequest setDidFailSelector:@selector(failFunc:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];

}

- (void)analyzeHightFunc{
    
    ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
    ListViewScrollView * twoListView = (ListViewScrollView *)[analyzeView viewWithTag:222];
    ListViewScrollView * threeListView = (ListViewScrollView *)[analyzeView viewWithTag:223];
    oneListView.frame = CGRectMake(0, allHight, self.mainView.frame.size.width, oneListView.frame.size.height);
    twoListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, twoListView.frame.size.height);
    threeListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, threeListView.frame.size.height);
    
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
    analyzeView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);

}

- (void)oddsHightFunc{

    NSArray * dataArray = nil;
    if (oddsInteger == 1) {
        
        dataArray = [oddsDictionary objectForKey:@"euro"];
    }else if (oddsInteger == 2){
        
        dataArray = [oddsDictionary objectForKey:@"asia"];
    }else if (oddsInteger == 3){
        
        dataArray = [oddsDictionary objectForKey:@"ball"];
    }
    
    CGFloat hight = 0.0;
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary * daDict = [dataArray objectAtIndex:i];
        if (buf[i] == 1) {
            hight = hight + 129+ 50*[[daDict objectForKey:@"change"] count];
        }else{
            hight = hight + 129;
        }
    }
    
    oddsView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, oddsHight+hight+50);
    myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, oddsHight+hight+ 50);
    oddsTabelView.frame = CGRectMake(oddsTabelView.frame.origin.x, oddsTabelView.frame.origin.y, oddsTabelView.frame.size.width, oddsHight+hight+50);
    

}

- (void)oddsCenterFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    NSString *responseStr = [request responseString];
    NSLog(@"oddsCenterFinish = %@", responseStr);
    if (responseStr) {
        NSDictionary * dict = [responseStr JSONValue];
        [oddsDictionary setValuesForKeysWithDictionary:dict];
        [self analysisFuncWhitDictionary:dict analyzeOrOdds:NO forKey:@"0"];
        
    }
    [oddsTabelView reloadData];
    
    [self oddsHightFunc];
    
}

- (void)zhanJiRequestWithTeamType:(NSString *)teamType matchType:(NSInteger)matchType{// 获取战绩
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getBFYCZhanjiWithPlayid:self.betData.saishiid zhanjiSize:10 teamType:teamType matchType:matchType]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(zhanJiFinish:)];
    [httpRequest setDidFailSelector:@selector(failFunc:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];

}

- (void)failFunc:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}

- (void)zhanJiFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
     NSString *responseStr = [request responseString];
    NSLog(@"zhanJiFinish = %@", responseStr);
    if (responseStr) {
        
        NSDictionary * dict = [responseStr JSONValue];
        [analyzeDictionary setObject:dict forKey:self.numString];
        
        CombatGainsView * oneCombat = (CombatGainsView *)[combatScrollView viewWithTag:100];
        oneCombat.homeOrguest = 1;
        oneCombat.analyzeDictionary = [analyzeDictionary objectForKey:self.numString];
        CombatGainsView * twoCombat = (CombatGainsView *)[combatScrollView viewWithTag:101];
        twoCombat.homeOrguest = 2;
        twoCombat.analyzeDictionary = [analyzeDictionary objectForKey:self.numString];
        
        NSArray * homeArray = [[analyzeDictionary objectForKey:self.numString] objectForKey:@"hostLeaguePlay"];
        
        NSArray * guestArray = [[analyzeDictionary objectForKey:self.numString] objectForKey:@"guestLeaguePlay"];
        
        UILabel * notAvailable = (UILabel *)[combatScrollView viewWithTag:1290];
        UILabel * notAvailableTwo = (UILabel *)[combatScrollView viewWithTag:1291];
        
        if ([homeArray count] == 0 && [guestArray count] == 0) {
            notAvailable.hidden = NO;
            notAvailableTwo.hidden = NO;
            trendType = allType;
            combatScrollView.scrollEnabled = NO;
        }else{
            combatScrollView.scrollEnabled = YES;
            notAvailable.hidden = YES;
            notAvailableTwo.hidden = YES;
            
        }
        
        
        
         [self combatScrollViewScrollEnabledFunc:homeArray array:guestArray];
        
        ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
        ListViewScrollView * twoListView = (ListViewScrollView *)[analyzeView viewWithTag:222];
        ListViewScrollView * threeListView = (ListViewScrollView *)[analyzeView viewWithTag:223];
        oneListView.keyString = self.numString;
        twoListView.keyString = self.numString;
        threeListView.keyString = @"1";
        oneListView.analyzeDictionary = analyzeDictionary;
        twoListView.analyzeDictionary = analyzeDictionary;
        threeListView.analyzeDictionary = analyzeDictionary;
        
        NSDictionary * dictone = [analyzeDictionary objectForKey:self.numString];
        if ([[dictone objectForKey:@"hostRecentPlay"] count] == 0) {
            oneListView.userInteractionEnabled = NO;
        }else{
             oneListView.userInteractionEnabled = YES;
        }
        NSDictionary * dicttwo = [analyzeDictionary objectForKey:self.numString];
        if ([[dicttwo objectForKey:@"guestRecentPlay"] count] == 0) {
            twoListView.userInteractionEnabled = NO;
        }else{
            twoListView.userInteractionEnabled = YES;
        }
        NSDictionary * dictthree = [analyzeDictionary objectForKey:@"1"];
        if ([[dictthree objectForKey:@"playvs"] count] == 0) {
            threeListView.userInteractionEnabled = NO;
        }else{
            threeListView.userInteractionEnabled = YES;
        }
        

        
        
        
        [self analyzeHightFunc];
        
//        oneListView.frame = CGRectMake(0, allHight, self.mainView.frame.size.width, oneListView.frame.size.height);
//        twoListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height, self.mainView.frame.size.width, twoListView.frame.size.height);
//        threeListView.frame = CGRectMake(0, allHight+oneListView.frame.size.height+twoListView.frame.size.height, self.mainView.frame.size.width, threeListView.frame.size.height);
//        
//        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//        analyzeView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, allHight+oneListView.frame.size.height+ twoListView.frame.size.height+threeListView.frame.size.height + 50);
//        [self analysisFuncWhitDictionary:dict analyzeOrOdds:YES forKey:self.numString];
        
    }
}


- (void)jiFenBangRequest:(NSString * )playid{
    [self.httpRequest clearDelegatesAndCancel];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getBFYCJiFenBangWithPlayid:playid]];//@"1835515"]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(jifenbangFinish:)];
     [httpRequest setDidFailSelector:@selector(failFunc:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
}

- (void)jifenbangFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    NSString *responseStr = [request responseString];
    NSLog(@"jifenbangFinish = %@", responseStr);
    if (responseStr) {
        NSDictionary * dict = [responseStr JSONValue];
        
        if (dict && [[dict objectForKey:@"code"] integerValue] == 1){
            if ([dict objectForKey:@"datas"] && [[dict objectForKey:@"datas"] count] > 0) {
                
               
                
                
                NSDictionary * daDict = [dict objectForKey:@"datas"];
                if (rankingTabelView && rankingTabelView.hidden == NO && [rankingDictionary count] == 0) {
                    [rankingDictionary setValuesForKeysWithDictionary:daDict];
                    
                    if ([analyzeDictionary count] > 0) {
                        NSDictionary * playinfo = [[analyzeDictionary objectForKey:@"1"] objectForKey:@"playinfo"];
                        self.integralString = [NSString stringWithFormat:@"%@ %@", [playinfo objectForKey:@"HostTeamId"], [playinfo objectForKey:@"GuestTeamId"]];
                    }
                    
                    if ([oddsDictionary count] > 0) {
                        NSDictionary * playinfo = [oddsDictionary objectForKey:@"playinfo"];
                        self.integralString = [NSString stringWithFormat:@"%@ %@", [playinfo objectForKey:@"HostTeamId"], [playinfo objectForKey:@"GuestTeamId"]];
                    }
                    
                    
                    
                    
                    
                    
                    NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
                    
                    if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                        if (!oneIntegral) {
                            oneIntegral = [[IntegralAlertView alloc] initWithType:1 showType:1];
                            oneIntegral.interalString = self.integralString;
                            oneIntegral.dataDictionary = rankingDictionary;
                        }
                       
                        
                    }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                        if (!twoIntegral) {
                            twoIntegral = [[IntegralAlertView alloc] initWithType:2 showType:1];
                            twoIntegral.interalString = self.integralString;
                            twoIntegral.dataDictionary = rankingDictionary;
                        }
                        
                        
                    }
                    [rankingTabelView reloadData];
                     [self selectViewAnimationFunc:rankingTabelView];
                    
                    return;
                }
                NSDictionary * playDict = [daDict objectForKey:@"play"];
                
                if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                    
                    IntegralAlertView * alert = [[IntegralAlertView alloc] initWithType:1 showType:0];
                    alert.interalString = self.integralString;
                    alert.dataDictionary = daDict;
                    [alert show];
                    [alert release];
                }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                    
                    IntegralAlertView * alert = [[IntegralAlertView alloc] initWithType:2 showType:0];
                    alert.interalString = self.integralString;
                    alert.dataDictionary = daDict;
                    [alert show];
                    [alert release];
                }
            }
        }else{
            if (rankingTabelView&&rankingTabelView.hidden == NO ){
                return;
                
            }
            [self alertViewFunc];
        
        }
        
        
        
        
        
    }
    
}

#pragma mark -
#pragma mark 四个界面的初始化和切换函数

- (void)rankingBulletinViewHeadInitFunc{

    if (!rankingBulletinViewHead) {
        rankingBulletinViewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, macthView.frame.size.height + 49)];
        rankingBulletinViewHead.backgroundColor = [UIColor whiteColor];
    }
    
    
}

- (void)rankingShowFunc{//排名初始化

    [self rankingBulletinViewHeadInitFunc];
    
    
    if (!rankingTabelView) {
        
        
        rankingTabelView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
        rankingTabelView.delegate = self;
        rankingTabelView.dataSource = self;
        rankingTabelView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        rankingTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rankingTabelView.showsVerticalScrollIndicator = NO;
        rankingTabelView.bounces = NO;
        [self.mainView addSubview:rankingTabelView];
        [self.mainView sendSubviewToBack:rankingTabelView];
        [rankingTabelView release];
        
        
        
    }
    if (!IntegralView) {
         IntegralView = [[UIIntegralView alloc] init];
    }
   
//    IntegralView.dataDictionary = rankingDictionary;


    
    if ([rankingDictionary count] == 0) {
    
        [self jiFenBangRequest:self.betData.saishiid];
        
    }
    
}

- (void)bulletinShowFunc{//简报初始化
    
     [self rankingBulletinViewHeadInitFunc];
    if (!bulletinTabelView) {
        bulletinTabelView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
        bulletinTabelView.delegate = self;
        bulletinTabelView.dataSource = self;
        bulletinTabelView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        bulletinTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        bulletinTabelView.bounces = NO;
        bulletinTabelView.showsVerticalScrollIndicator = NO;
        [self.mainView addSubview:bulletinTabelView];
        [self.mainView sendSubviewToBack:bulletinTabelView];
        [bulletinTabelView release];
    }
    if ([bulletinDictionary count] == 0) {
        [self aboutRequest];
    }
    
    
    
    
    

}

-(void)oddsCenterShow{//赔率初始化
    
    [self matchBetViewButtonTag:2];
    oddsView.hidden = NO;
    analyzeView.hidden = YES;
//    [self selectViewAnimationFunc:88];
    if ([oddsDictionary count] == 0) {
        [self oddsCenterRequest];
    }else{
        [self oddsHightFunc];
    }
 
}

- (void)analyzeShow{//战绩初始化函数
    oddsView.hidden = YES;
    analyzeView.hidden = NO;
//    [self selectButtonShowFunc]; //选择按钮
    if (!combatView) {
        [self combatGainsFunc];//战绩走势图
    }
    ListViewScrollView * oneListView = (ListViewScrollView *)[analyzeView viewWithTag:221];
    if (!oneListView) {
        [self tableViewShowFunc];// 对阵 历史交锋
    }
    
    if ([analyzeDictionary count] == 0) {
        [self analyzeRequest];
    }else{
        
        [self analyzeHightFunc];
    }
    

}

- (void)aboutRequest{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL bfycAboutWithPlayid:self.betData.saishiid]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(aboutRequestFinished:)];
    [httpRequest setTimeOutSeconds:10];
    [httpRequest startAsynchronous];
}

- (void)aboutRequestFinished:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    NSString *responseStr = [request responseString];
    NSLog(@"aboutRequestFinished = %@", responseStr);
    if (responseStr) {
        
        
//        responseStr = @"";
        NSDictionary * dict = [responseStr JSONValue];
        if ([[dict objectForKey:@"code"] intValue] == 1) {
            [bulletinDictionary setValuesForKeysWithDictionary:dict];
            
            if (!proportionView) {
                 proportionView = [[UIProportionView alloc] init];
            }
            if (!ynopsisView) {
               
                ynopsisView = [[UIynopsisView alloc] initWithDictionary:bulletinDictionary];
                ynopsisView.delegate = self;
            }
            
            [bulletinTabelView reloadData];
            
        }
        
        
    
    }
}

#pragma mark -
#pragma mark segment 选择点击函数 切换
- (void)pressSegmenButton:(UIButton *)sender{//segment 选择点击函数

    
    for (int i = 0; i < 4; i++) {
        UIButton * segmenButton = (UIButton *)[segmentView viewWithTag:i+1];
//        segmenButton.selected = NO;
        UILabel * segmenLabel = (UILabel *)[segmenButton viewWithTag:i+5];
        segmenLabel.textColor = [UIColor colorWithRed:94/255.0 green:91/255.0 blue:91/255.0 alpha:1];
        
    }
//    sender.selected = YES;
    UILabel * senderLabel = (UILabel *)[sender viewWithTag:sender.tag + 5 - 1];
    senderLabel.textColor = [UIColor colorWithRed:15/255.0 green:115/255.0 blue:238/255.0 alpha:1];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    UIImageView * lineImageView = (UIImageView *)[segmentView viewWithTag:1000];
    lineImageView.frame = CGRectMake(sender.frame.origin.x, lineImageView.frame.origin.y, lineImageView.frame.size.width, lineImageView.frame.size.height);
    [UIView commitAnimations];
    
    [macthView removeFromSuperview];
    
    if (sender.tag == 1) {//战绩
        if (rankingTabelView) {
            rankingTabelView.hidden = YES;
        }
        if (bulletinTabelView) {
            bulletinTabelView.hidden = YES;
        }
        
        myScrollView.hidden = NO;
        [myScrollView addSubview:macthView];
        UIView * selectView = (UIView *)[segmentView viewWithTag:99];
        selectView.hidden = NO;
        UIView * selectViewTwo = (UIView *)[segmentView viewWithTag:88];
        selectViewTwo.hidden = YES;
        segmentView.frame = CGRectMake(segmentView.frame.origin.x, segmentView.frame.origin.y, segmentView.frame.size.width, 108);
        [self analyzeShow];
        [self selectViewAnimationFunc:myScrollView];
    }else if (sender.tag == 2){//排名
        
        if (bulletinTabelView) {
            bulletinTabelView.hidden = YES;
        }
        myScrollView.hidden = YES;
        UIView * selectView = (UIView *)[segmentView viewWithTag:99];
        selectView.hidden = YES;
        UIView * selectViewTwo = (UIView *)[segmentView viewWithTag:88];
        selectViewTwo.hidden = YES;
        segmentView.frame = CGRectMake(segmentView.frame.origin.x, segmentView.frame.origin.y, segmentView.frame.size.width, 48);
        [self rankingShowFunc];
        if (rankingTabelView) {
            rankingTabelView.hidden = NO;
        }
        [bulletinTabelView setTableHeaderView:nil];
        [rankingTabelView setTableHeaderView:nil];
        
        [rankingBulletinViewHead addSubview:macthView];
        
        [rankingTabelView setTableHeaderView:rankingBulletinViewHead];

        [self selectViewAnimationFunc:rankingTabelView];
        
    }else if (sender.tag == 3){//赔率
        if (rankingTabelView) {
            rankingTabelView.hidden = YES;
        }
        if (bulletinTabelView) {
            bulletinTabelView.hidden = YES;
        }
        myScrollView.hidden = NO;
        [myScrollView addSubview:macthView];
        UIView * selectView = (UIView *)[segmentView viewWithTag:99];
        selectView.hidden = YES;
        UIView * selectViewTwo = (UIView *)[segmentView viewWithTag:88];
        selectViewTwo.hidden = NO;
        segmentView.frame = CGRectMake(segmentView.frame.origin.x, segmentView.frame.origin.y, segmentView.frame.size.width, 108);
        
        
        [self oddsCenterShow];
        
        [self selectViewAnimationFunc:myScrollView];
        
    }else if (sender.tag == 4){//简报
        if (rankingTabelView) {
            rankingTabelView.hidden = YES;
        }
                myScrollView.hidden = YES;
        UIView * selectView = (UIView *)[segmentView viewWithTag:99];
        selectView.hidden = YES;
        UIView * selectViewTwo = (UIView *)[segmentView viewWithTag:88];
        selectViewTwo.hidden = YES;
        segmentView.frame = CGRectMake(segmentView.frame.origin.x, segmentView.frame.origin.y, segmentView.frame.size.width, 48);
        [self bulletinShowFunc];
        if (bulletinTabelView) {
            bulletinTabelView.hidden = NO;
        }
        [rankingTabelView setTableHeaderView:nil];
        [bulletinTabelView setTableHeaderView:nil];
        
        [rankingBulletinViewHead addSubview:macthView];
        
        [bulletinTabelView setTableHeaderView:rankingBulletinViewHead];
        [self selectViewAnimationFunc:bulletinTabelView];
        
    }
    
    

}

- (void)segmentFunc{//战绩 排名 赔率 简报 切换按钮

    
    segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, allHight, self.mainView.frame.size.width, 108)];
    segmentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
    [self.mainView addSubview:segmentView];
    [segmentView release];
    
    
    for (int i = 0; i < 4; i++) {
        UIButton * segmenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        segmenButton.frame = CGRectMake(i*80, 0, 80, 48);
        segmenButton.tag = i+1;
        [segmenButton setBackgroundImage:UIImageGetImageFromName(@"zhanjipaiming.png") forState:UIControlStateNormal];
        [segmenButton addTarget:self action:@selector(pressSegmenButton:) forControlEvents:UIControlEventTouchUpInside];
        [segmentView addSubview:segmenButton];
        
        
        UILabel * segmenLabel = [[UILabel alloc] initWithFrame:segmenButton.bounds];
        segmenLabel.tag = i+5;
        segmenLabel.textAlignment = NSTextAlignmentCenter;
        segmenLabel.textColor = [UIColor colorWithRed:94/255.0 green:91/255.0 blue:91/255.0 alpha:1];
        segmenLabel.backgroundColor = [UIColor clearColor];
        segmenLabel.font = [UIFont systemFontOfSize:16];
        [segmenButton addSubview:segmenLabel];
        [segmenLabel release];
        
        if (i == 0) {
           segmenLabel.text = @"战绩";
        }else if (i == 1){
            segmenLabel.text = @"排名";
        }else if (i == 2){
            segmenLabel.text = @"赔率";
        }else if (i == 3){
            segmenLabel.text = @"简报";
        }
        
        
    }
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 80, 2)];
    lineImageView.tag = 1000;
    lineImageView.backgroundColor = [UIColor colorWithRed:15/255.0 green:115/255.0 blue:238/255.0 alpha:1];
    [segmentView addSubview:lineImageView];
    [lineImageView release];
    
    [self selectButtonShowFunc];
    [self oddsViewAllViewFunc];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    char* str = "ab"; //16进制转换为10进制
//    long sum = strtol(str,&str,16);
//    NSLog(@"a = %ld",  sum);
    
//    [self.CP_navigation.layer setMasksToBounds:YES];
    allHight = 0.0;
    analyzeDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    oddsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    bulletinDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    rankingDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    UIView * oneTitleView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 270, 44)];
    oneTitleView.backgroundColor = [UIColor clearColor];
    [oneTitleView.layer setMasksToBounds:YES];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    if (lotteryType == shengfucaitype) {
        titleLabel.text = [NSString stringWithFormat:@"赛事分析-%d",(int) gcIndexPath.row+1];
    }else if (lotteryType == beidantype) {
         titleLabel.text = [NSString stringWithFormat:@"赛事分析-%@%@", self.betData.numzhou, self.betData.bdnum];
    } else{
        titleLabel.text = [NSString stringWithFormat:@"赛事分析-%@", self.betData.numzhou];
    }
//    bdnum
    
    [oneTitleView addSubview:titleLabel];
    [titleLabel release];
    
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 180, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    [titleView release];
    
    
    teamTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 180, 40)];
    teamTitleView.backgroundColor = [UIColor clearColor];
    teamTitleView.hidden = YES;
    [oneTitleView addSubview:teamTitleView];
    [teamTitleView release];
    
    UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 180, 20)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.tag = 100;
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont boldSystemFontOfSize:18];
    twoLabel.textColor = [UIColor whiteColor];
    
//     NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
    
//    twoLabel.text = [NSString stringWithFormat:@"%@ VS %@",[teamarray objectAtIndex:0], [teamarray objectAtIndex:1]];
    [teamTitleView addSubview:twoLabel];
    [twoLabel release];
    
    
    UILabel *threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 180, 20)];
    threeLabel.backgroundColor = [UIColor clearColor];
    threeLabel.textAlignment = NSTextAlignmentCenter;
    threeLabel.tag = 101;
    threeLabel.font = [UIFont boldSystemFontOfSize:13];
    threeLabel.textColor = [UIColor whiteColor];
//    NSArray * timedata = [self.betData.macthTime componentsSeparatedByString:@" "];
//    if ([timedata count] >= 2) {
//        threeLabel.text = [NSString stringWithFormat:@"%@场 %@开赛", self.betData.numzhou, [timedata objectAtIndex:1]];
//    }
    
    threeLabel.text = @"";
    
    [teamTitleView addSubview:threeLabel];
    [threeLabel release];

    
    
    
    self.CP_navigation.titleView = oneTitleView;
    [oneTitleView release];
    
    
    
    

    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 0, 40, 44);
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.bounces = NO;
    myScrollView.delegate = self;
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
    analyzeView = [[UIView alloc] initWithFrame:self.mainView.bounds];
    analyzeView.backgroundColor  = [UIColor clearColor];
    [myScrollView addSubview:analyzeView];
    [analyzeView release];
    
    oddsView = [[UIView alloc] initWithFrame:self.mainView.bounds];
    oddsView.backgroundColor  = [UIColor clearColor];
    oddsView.hidden = YES;
    [myScrollView addSubview:oddsView];
    [oddsView release];
    
    macthView = [[MatchBetView alloc] init]; // 最上面的对名
    macthView.betData = self.betData;
    macthView.delegate = self;
    macthView.buttonType = matchShowType;
    [myScrollView addSubview:macthView];
    
    
    allHight += macthView.frame.size.height;//暂时的
    oddsHight += macthView.frame.size.height;

    
    NSLog(@"oddsHight = %f", oddsHight);
    
    [self segmentFunc];//战绩 排名 赔率 简报 切换按钮
    
    
   
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"bfycCustomization"] intValue] == 1) {//暂存记录
       UIButton * segmenButton = (UIButton *)[segmentView viewWithTag:3];
        [self pressSegmenButton:segmenButton];
//        [self oddsCenterShow];
    }else{
        UIButton * segmenButton = (UIButton *)[segmentView viewWithTag:1];
        [self pressSegmenButton:segmenButton];
//        [self analyzeShow];
    }
    
   
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)cellHightFunc{
    
    if (rankingDictionary) {
        
        NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
        
        NSInteger alertType = 0;
        if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
            
            alertType = 1;
            
        }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
            
            alertType = 2;
        }
        
        if (alertType == 1) {
            
            if ([rankingDictionary objectForKey:@"league"] ) {
                
                
                return [[rankingDictionary objectForKey:@"league"] count];
                
                
            }else{
                return 0;
            }
            
        }else{
            if ([rankingDictionary objectForKey:@"guest_league"] && [rankingDictionary objectForKey:@"host_league"]) {
                
                if ([[rankingDictionary objectForKey:@"guest_league"] count] >= [[rankingDictionary objectForKey:@"host_league"] count]) {
                    return [[rankingDictionary objectForKey:@"guest_league"] count];
                }else{
                    return [[rankingDictionary objectForKey:@"host_league"] count];
                }
                
            }else{
                return 0;
            }
        }
        
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (tableView == rankingTabelView || tableView == bulletinTabelView) {
        UIImageView * bgimage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 30)] autorelease];
        bgimage.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        
        
        UILabel * headTitle = [[UILabel alloc] initWithFrame:bgimage.bounds];
        headTitle.backgroundColor = [UIColor clearColor];
        headTitle.textAlignment = NSTextAlignmentCenter;
        headTitle.font = [UIFont systemFontOfSize:16];
//        headTitle.text = @"sadfsadsdfasdf";
        if (tableView == rankingTabelView) {
            BOOL numb = NO;
            if ([rankingDictionary count] > 0) {
                NSArray * leagueHost = [rankingDictionary objectForKey:@"leagueHost"];
                NSArray * leagueGuest = [rankingDictionary objectForKey:@"leagueGuest"];
                
                if ([leagueHost count] >0 || [leagueGuest count] > 0) {
                    numb = YES;
                }
                
            }
            if (numb) {
                if (section == 0) {
                    headTitle.text = @"积分排名";
                }else if (section == 1){
                    if ([rankingDictionary count] > 0) {
                        
                        
                        
                        NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
                        
                        
                        if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                            
//                            headTitle.text = [NSString stringWithFormat:@"%@%@  %@VS%@", [playDict objectForKey:@"league_name"], [playDict objectForKey:@"season"], [playDict objectForKey:@"host_name"], [playDict objectForKey:@"guest_name"]];//@"英超13/14  曼联VS切尔西";
                            
                            headTitle.text = [NSString stringWithFormat:@"%@%@积分榜", [playDict objectForKey:@"league_name"],[playDict objectForKey:@"allLc"]];//@"英超13/14  曼联VS切尔西";
                            
                        }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                            
                            headTitle.text = @"积分榜";
                        }
                        
                        
                        
                    }
                }
            }else{
            
                if ([rankingDictionary count] > 0) {
                    
                    
                    
                    NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
                    
                    
                    if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                        
//                        headTitle.text = [NSString stringWithFormat:@"%@%@  %@VS%@", [playDict objectForKey:@"league_name"], [playDict objectForKey:@"season"], [playDict objectForKey:@"host_name"], [playDict objectForKey:@"guest_name"]];//@"英超13/14  曼联VS切尔西";
                         headTitle.text = [NSString stringWithFormat:@"%@%@积分榜", [playDict objectForKey:@"league_name"],[playDict objectForKey:@"allLc"]];//@"英超13/14  曼联VS切尔西";
                        
                    }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                        
                        headTitle.text = @"积分榜";
                    }
                    
                    
                    
                }
            }
            
            
        }
        
        
       

        [bgimage addSubview:headTitle];
        [headTitle release];
        
        
        if (tableView == bulletinTabelView) {
            if (section == 0) {
                headTitle.text = @"投注比例";
            }else if (section == 1){
                headTitle.text = @"赛前简析";
            }
            bgimage.backgroundColor = [UIColor colorWithRed:253/255.0 green:252/255.0 blue:249/255.0 alpha:1];
            UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 1)];
            lineImage.backgroundColor = [UIColor colorWithRed:177/255.0 green:167/255.0 blue:151/255.0 alpha:1];
            [bgimage addSubview:lineImage];
            [lineImage release];
        }
        
        
        return bgimage;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == rankingTabelView ) {
        return 30;
    }
    if (tableView == bulletinTabelView) {
        return 31;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView ==  rankingTabelView ) {
        if ([rankingDictionary count] > 0) {
            NSArray * leagueHost = [rankingDictionary objectForKey:@"leagueHost"];
            NSArray * leagueGuest = [rankingDictionary objectForKey:@"leagueGuest"];
            
            if ([leagueHost count] >0 || [leagueGuest count] > 0) {
                return 2;
            }
            
        }else{
            return 0;
        }
        return 1;
    }
    if (tableView == bulletinTabelView) {
        if ([bulletinDictionary count] > 0) {
            return 2;
        }
        return 0;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView ==  rankingTabelView ) {
        if (indexPath.section == 0) {
            if ([rankingDictionary count] > 0) {
                NSArray * leagueHost = [rankingDictionary objectForKey:@"leagueHost"];
                NSArray * leagueGuest = [rankingDictionary objectForKey:@"leagueGuest"];
                
                if ([leagueHost count] >0 || [leagueGuest count] > 0) {
                    return 255;
                }
                
            }
            NSInteger cout = [self cellHightFunc];
            return cout*32+32+20;

        }else{
            NSInteger cout = [self cellHightFunc];
            return cout*32+32+20;
        }
        
    }
    if (tableView == bulletinTabelView) {
        if (indexPath.section == 0) {
            return 253;
        }else if (indexPath.section == 1){
            return ynopsisView.frame.size.height;
        }
    }

    
    
    if (buf[indexPath.row] == 1) {
        
        NSArray * dataArray = nil;
        if (oddsInteger == 1) {
            
            dataArray = [oddsDictionary objectForKey:@"euro"];
        }else if (oddsInteger == 2){
            
            dataArray = [oddsDictionary objectForKey:@"asia"];
        }else if (oddsInteger == 3){
            
            dataArray = [oddsDictionary objectForKey:@"ball"];
        }
        if (dataArray && [dataArray count] > indexPath.row) {
            NSDictionary * daDict = [dataArray objectAtIndex:indexPath.row];
            if ([daDict objectForKey:@"change"]) {
                return  129+ 50*[[daDict objectForKey:@"change"] count];
            }
        }
        
       
        return 129;
    }
    return 129;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView ==  rankingTabelView ) {
        if ([rankingDictionary count] > 0) {
            return 1;
        }
        return 0;
    }
    if (tableView == bulletinTabelView) {
        if ([bulletinDictionary count ]> 0) {
            return 1;
        }
        return 0;
    }
    
    if (oddsInteger == 1) {
        
        if ([oddsDictionary objectForKey:@"euro"] ) {
            return [[oddsDictionary objectForKey:@"euro"] count];
        }
        
    }else if (oddsInteger == 2){
        
        if ([oddsDictionary objectForKey:@"asia"] ) {
            return [[oddsDictionary objectForKey:@"asia"] count];
        }
    
    }else if (oddsInteger == 3){
        
        if ([oddsDictionary objectForKey:@"ball"] ) {
            return [[oddsDictionary objectForKey:@"ball"] count];
        }
    
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==  rankingTabelView) {
        
        static NSString *CellIdentifier = @"SCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            
        }
        
        if ([rankingDictionary count] > 0) {
            NSArray * leagueHost = [rankingDictionary objectForKey:@"leagueHost"];
            NSArray * leagueGuest = [rankingDictionary objectForKey:@"leagueGuest"];
            
            if ([leagueHost count] >0 || [leagueGuest count] > 0) {
                if (indexPath.section == 0) {
                    
                    
                    [cell.contentView addSubview:IntegralView];
                    
                    
                }else{
                    if (rankingDictionary) {
                        NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
                        
                        if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                            
                            [cell addSubview:oneIntegral];
                            
                        }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                            
                            [cell addSubview:twoIntegral];
                        }
                    }
                    
                    
                    
                }
            }else{
                if (rankingDictionary) {
                    NSDictionary * playDict = [rankingDictionary objectForKey:@"play"];
                    
                    if ([[playDict objectForKey:@"is_league"] integerValue] == 1) {
                        
                        [cell addSubview:oneIntegral];
                        
                    }else if([[playDict objectForKey:@"is_league"] integerValue] == 2){
                        
                        [cell addSubview:twoIntegral];
                    }
                }
            }
            
        }
       
        
        IntegralView.dataDictionary = rankingDictionary;
        return cell;
        
    }else
        
    if (tableView == bulletinTabelView) {
        
        static NSString *CellIdentifier = @"SCell12";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            cell.contentView.userInteractionEnabled = YES;
            if (indexPath.section == 0) {
                if (proportionView) {
                     [cell.contentView addSubview:proportionView];
                }
               
            }else if (indexPath.section == 1){
                if (ynopsisView) {
                    [cell.contentView addSubview:ynopsisView];
                }
                
                
            }
        }
        
       
        if (indexPath.section == 0) {
            if (proportionView) {
                proportionView.dataDictionary = bulletinDictionary;
            }
            
        }else if (indexPath.section == 1){
            if (ynopsisView) {
                ynopsisView.dataDictionary = bulletinDictionary;
            }
            
            
            
        }
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"SCell";
        
        OddsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[OddsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.delegate = self;
        cell.indexOdds = indexPath;
        
        cell.oddsInteger = oddsInteger;
        cell.oddsDictionary = oddsDictionary;
        if (buf[indexPath.row] == 0) {
            cell.opencellBool = NO;
        }else{
            cell.opencellBool = YES;
        }
        
        return cell;
    
    }
    
    return nil;
    
}

- (void)OddsTableViewCellDelegateButtonTag:(NSInteger)tag indexPath:(NSIndexPath *)indexPath{
    
    if (tag == 1) {
        buf[indexPath.row] = 0;
        
        
    }else{
        buf[indexPath.row] = 1;
    }
    
    [oddsTabelView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"oddsTabelView = %f", oddsTabelView.contentSize.height);
    
    [self oddsHightFunc];
//    if (buf[indexPath.row] == 0) {
//        oddsView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height- 500);
//        myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height- 500);
//        oddsTabelView.frame = CGRectMake(oddsTabelView.frame.origin.x, oddsTabelView.frame.origin.y, oddsTabelView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height - 500);
//    }else{
//        oddsView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height+500);
//        myScrollView.contentSize= CGSizeMake(self.mainView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height+ 500);
//        oddsTabelView.frame = CGRectMake(oddsTabelView.frame.origin.x, oddsTabelView.frame.origin.y, oddsTabelView.frame.size.width, oddsHight+50+oddsTabelView.frame.size.height + 500);
//    }
    
}
#pragma mark -
#pragma mark 点击赛事名

- (void)listViewScrollView:(ListViewScrollView *)listView macthTouch:(BOOL)macthBool teamButtonTouch:(BOOL)teamBool name:(NSString *)name dict:(NSDictionary *)dictData{

    
    if (macthBool && teamBool == NO) {//点击赛事名
        
        YCMatchViewController * ycMatch = [[YCMatchViewController alloc] init];
        if (name) {
            ycMatch.title = name;
        }else{
            ycMatch.title = nil;
        }
        if (dictData) {
            ycMatch.analyzeDictionary = dictData;
        }
        [self.navigationController pushViewController:ycMatch animated:YES];
        [ycMatch release];
        
        
    }else{//点击对阵
    
    
    }
    

}
#pragma mark -
#pragma mark 点击对阵

- (void)listViewScrollView:(ListViewScrollView *)listView selectIndexPatch:(NSIndexPath *)indexPath viewType:(ListViewType)listType withNum:(NSString *)num{//点击对阵
    
    
    NSDictionary * dict = [listView.analyzeDictionary objectForKey:num];
    NSArray * teamArray = nil;
    if (listView.listType == homeCellType) {
        teamArray = [dict objectForKey:@"hostRecentPlay"];
    }else if (listView.listType == guestCellType){
        teamArray = [dict objectForKey:@"guestRecentPlay"];
    }else if (listView.listType == historyCellType){
        teamArray = [dict objectForKey:@"playvs"];
    }
    if (teamArray && [teamArray count] > indexPath.row) {
        
        NSDictionary * twoDict = [teamArray objectAtIndex:indexPath.row];
        if ([[twoDict objectForKey:@"isGjd"] intValue] == 1){
        //不可弹框 国家队
            
        }else{
            
            self.integralString = [NSString stringWithFormat:@"%@ %@", [twoDict objectForKey:@"hostid"], [twoDict objectForKey:@"guestid"]];
            [self jiFenBangRequest:[twoDict objectForKey:@"playid"]];
        }
        
        
    }
   
    
    
    
    
    

}

- (void)matchAlertButton{//点击联赛名
    NSDictionary * dict = nil;
    NSDictionary * dictTwo = nil;
    if (analyzeOrOdds) {
       
        dictTwo = [oddsDictionary objectForKey:@"playinfo"];
    }else{
        dict = [analyzeDictionary objectForKey:@"1"];
        dictTwo = [dict objectForKey:@"playinfo"];
    }
    
    
    
    if ([[dictTwo objectForKey:@"isGjd"] integerValue] == 1) {
        
    }else{
        
        self.integralString = [NSString stringWithFormat:@"%@ %@", [dictTwo objectForKey:@"HostTeamId"], [dictTwo objectForKey:@"GuestTeamId"]];
        [self jiFenBangRequest:self.betData.saishiid];
    
    }
    
    
    
//    IntegralAlertView * alert = [[IntegralAlertView alloc] initWithType:1];
//    [alert show];
//    [alert release];

}

- (void)AnimationShowAndHidden:(BOOL)yesOrNo{

    UIView * selectView = nil;
    UIButton * peilvButton = nil;
    
    if (analyzeOrOdds) {//analyzeOrOdds 为yes 是赔率中心
        
        selectView = (UIView *)[self.mainView viewWithTag:88];
        peilvButton = (UIButton *)[selectView viewWithTag:11];
    }else{
        selectView = (UIView *)[self.mainView viewWithTag:99];
        peilvButton = (UIButton *)[selectView viewWithTag:12];
    }
    if (analyzeOrOdds) {
        UIImageView * oneImageView = (UIImageView *)[selectView viewWithTag:4];
        UIButton * oupeiButton = (UIButton *)[selectView viewWithTag:1];
        UIButton * yapeiButton = (UIButton *)[selectView viewWithTag:2];
        UIButton * daxiaoButton = (UIButton *)[selectView viewWithTag:3];
        
        UILabel * oupeiLabel = (UILabel *)[oupeiButton viewWithTag:10];
        UILabel * yapeiLabel = (UILabel *)[yapeiButton viewWithTag:10];
        UILabel * daxiaoLabel = (UILabel *)[daxiaoButton viewWithTag:10];
        
        if (yesOrNo) {
            oneImageView.frame = CGRectMake(10, (61-37)/2, 252, 37);
            oupeiButton.frame =  CGRectMake(10, (61-37)/2, 252/3.0, 37);
            yapeiButton.frame = CGRectMake(10+252/3.0, (61-37)/2,252/3.0, 37);
            daxiaoButton.frame = CGRectMake(10+252/3.0 *2, (61-37)/2, 252/3.0, 37);
            peilvButton.frame = CGRectMake(320 - 48, (61-37)/2, 38, 37);
            
        }else{
            oneImageView.frame = CGRectMake(10, 12, 300, 37);
            daxiaoButton.frame = CGRectMake(210, 12, 100, 37);
            yapeiButton.frame = CGRectMake(110, 12, 100, 37);
            oupeiButton.frame = CGRectMake(10, 12, 100, 37);
            peilvButton.frame = CGRectMake(320, (61-37)/2, 38, 37);
        }
        
        oupeiLabel.frame = oupeiButton.bounds;
        yapeiLabel.frame = yapeiButton.bounds;
        daxiaoLabel.frame = daxiaoButton.bounds;
        
        
       
    }else{
        UIImageView * oneImageView = (UIImageView *)[selectView viewWithTag:6];
        UIImageView * twoImageView = (UIImageView *)[selectView viewWithTag:7];
        UIButton * allShowButton = (UIButton *)[selectView viewWithTag:1];
        UIButton * homeButton = (UIButton *)[selectView viewWithTag:2];
        UIButton * guestButton = (UIButton *)[selectView viewWithTag:3];
        UIButton * allMatchButton = (UIButton *)[selectView viewWithTag:4];
        UIButton * matchButton = (UIButton *)[selectView viewWithTag:5];
        
        UILabel * allShowLabel = (UILabel *)[allShowButton viewWithTag:10];
        UILabel * homeLabel = (UILabel *)[homeButton viewWithTag:10];
        UILabel * guestLabel = (UILabel *)[guestButton viewWithTag:10];
        UILabel * allMatchLabel = (UILabel *)[allMatchButton viewWithTag:10];
        UILabel * matchLabel = (UILabel *)[matchButton viewWithTag:10];
        
        if (yesOrNo) {
            
            oneImageView.frame = CGRectMake(10, (61-37)/2, 140, 37);
            allShowButton.frame = CGRectMake(0, 0, 58, 37);
            homeButton.frame = CGRectMake(58, 0, (140 - 58)/2, 37);
            guestButton.frame = CGRectMake(58+(140 - 58)/2, 0, (140 - 58)/2, 37);
            
            twoImageView.frame = CGRectMake(159, (61-37)/2, 104, 37);
            allMatchButton.frame = CGRectMake(0, 0, 59.5, 37);
            matchButton.frame = CGRectMake(59.5, 0, 104 - 59.5, 37);
            
            peilvButton.frame = CGRectMake(320 - 48, (61-37)/2, 38, 37);
        }else{
            
            
            oneImageView.frame = CGRectMake(10, 12, 162, 37);
            allShowButton.frame = CGRectMake(0, 0, 63, 37);
            homeButton.frame = CGRectMake(63, 0, (163 - 63)/2, 37);
            guestButton.frame = CGRectMake(63+(163 - 63)/2, 0, (163 - 63)/2, 37);
            
            twoImageView.frame = CGRectMake(320 - 10 - 127, 12, 127, 37);
            allMatchButton.frame = CGRectMake(0, 0, 127/2, 37);
            matchButton.frame = CGRectMake(127/2, 0, 127/2, 37);
            
            peilvButton.frame = CGRectMake(320, (61-37)/2, 38, 37);
        }
        
        allShowLabel.frame = allShowButton.bounds;
        homeLabel.frame = homeButton.bounds;
        guestLabel.frame = guestButton.bounds;
        allMatchLabel.frame = allMatchButton.bounds;
        matchLabel.frame = matchButton.bounds;
        
    }

}

- (void)uiviewDidStopfunc{
    titleLabel.hidden = YES;
    teamTitleView.hidden = NO;

}

- (void)uiviewDidStopTwofunc{
    titleLabel.hidden = NO;
    teamTitleView.hidden = YES;

}

- (void)oddsViewButtonAnimationShow{
    
    if ( titleLabel.frame.origin.y != -64) {
        teamTitleView.hidden = NO;
        teamTitleView.frame = CGRectMake(0, 64, 180, 40);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(uiviewDidStopfunc)];

        titleLabel.frame = CGRectMake(0, -64, 180, 34);
        teamTitleView.frame = CGRectMake(0, 2, 180, 40);
        
        titleLabel.alpha = 0;
        teamTitleView.alpha = 1;
        [UIView commitAnimations];
    }
    
        

    


}


- (void)oddsViewButtonAnimationhidden{
    
    if (titleLabel.frame.origin.y != 5) {
        titleLabel.hidden = NO;
        titleLabel.frame = CGRectMake(0, -64, 180, 34);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(uiviewDidStopTwofunc)];

        titleLabel.frame = CGRectMake(0, 5, 180, 34);
        teamTitleView.frame = CGRectMake(0, 64, 180, 40);
        titleLabel.alpha = 1;
        teamTitleView.alpha = 0;
        [UIView commitAnimations];
    }
    

    
    
    
}


- (void)selectViewAnimationFunc:(UIScrollView *)scrollView{
    
 
    segmentView.frame = CGRectMake(segmentView.frame.origin.x, macthView.frame.size.height - scrollView.contentOffset.y, segmentView.frame.size.width, segmentView.frame.size.height);
    
    
    
    if (scrollView == rankingTabelView ) {
        
        
        if ((rankingTabelView.frame.origin.y == 49)  && (rankingTabelView.contentOffset.y < macthView.frame.size.height + 49)) {
            if (rankingTwoBool == NO) {
                rankingTwoBool = YES;
                if (rankingTabelView.hidden == NO) {
                    rankingTabelView.frame = CGRectMake(rankingTabelView.frame.origin.x,  0, rankingTabelView.frame.size.width, self.mainView.frame.size.height);
                    rankingTabelView.contentOffset = CGPointMake(0, macthView.frame.size.height);
                }
                
            }
            
        }
        
        
    }
    
    if ( scrollView == bulletinTabelView) {
        
        if ((bulletinTabelView.frame.origin.y == 49)  && (bulletinTabelView.contentOffset.y < macthView.frame.size.height + 49)) {
            if (bulletinTwoBool == NO) {
                bulletinTwoBool = YES;
                if (bulletinTabelView.hidden == NO) {
                    bulletinTabelView.frame = CGRectMake(bulletinTabelView.frame.origin.x,  0, bulletinTabelView.frame.size.width, self.mainView.frame.size.height);
                    bulletinTabelView.contentOffset = CGPointMake(0, macthView.frame.size.height);
                }
               
            }
            
        }
    }
    
    
    if (segmentView.frame.origin.y <= 0) {
        segmentView.frame = CGRectMake(segmentView.frame.origin.x, 0, segmentView.frame.size.width, segmentView.frame.size.height);
        [self oddsViewButtonAnimationShow];
        
        if (scrollView == rankingTabelView) {
            
            if (rankingOneBool == NO) {
                rankingOneBool = YES;
                rankingTwoBool = NO;
                if (rankingTabelView.hidden == NO) {
                    rankingTabelView.frame = CGRectMake(rankingTabelView.frame.origin.x, 49, rankingTabelView.frame.size.width, rankingTabelView.frame.size.height - 49);
                    rankingTabelView.contentOffset = CGPointMake(0, macthView.frame.size.height + 49);
                }
                
            }
            
            
           
        }
        
        if (scrollView == bulletinTabelView) {
            
            if (bulletinOneBool == NO) {
                bulletinOneBool = YES;
                bulletinTwoBool = NO;
                if (bulletinTabelView.hidden == NO) {
                    bulletinTabelView.frame = CGRectMake(bulletinTabelView.frame.origin.x, 49, bulletinTabelView.frame.size.width, bulletinTabelView.frame.size.height - 49);
                    bulletinTabelView.contentOffset = CGPointMake(0, macthView.frame.size.height + 49);
                }
                
            }
            
            
            
        }
        
        
    }else if (segmentView.frame.origin.y > 0){
        [self oddsViewButtonAnimationhidden];
        if (scrollView == rankingTabelView) {
            rankingOneBool = NO;
            if (rankingTabelView.hidden == NO) {
                rankingTabelView.frame = CGRectMake(rankingTabelView.frame.origin.x,  0, rankingTabelView.frame.size.width, self.mainView.frame.size.height);
            }
            
        
        }
        if (scrollView == bulletinTabelView) {
            bulletinOneBool = NO;
            if (bulletinTabelView.hidden == NO) {
                bulletinTabelView.frame = CGRectMake(bulletinTabelView.frame.origin.x,  0, bulletinTabelView.frame.size.width, self.mainView.frame.size.height);
            }
            
        }
        

    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    if (scrollView == myScrollView || scrollView == bulletinTabelView || scrollView == rankingTabelView) {
//        if (analyzeOrOdds) {
            [self selectViewAnimationFunc:scrollView];
//        }else{
//            [self selectViewAnimationFunc:99];
//            
//        }
    }else if (scrollView.tag == 221 || scrollView.tag == 222 || scrollView.tag == 223){
        
        ListViewScrollView * listScrollView = (ListViewScrollView *)[analyzeView viewWithTag:scrollView.tag];
         listScrollView.titleImageView.frame = CGRectMake(listScrollView.contentOffset.x, listScrollView.titleImageView.frame.origin.y, listScrollView.titleImageView.frame.size.width, listScrollView.titleImageView.frame.size.height);
        
    }else if (scrollView == combatScrollView){
    
        if (trendType == halfType){
            if (combatScrollView.contentOffset.x <= combatScrollView.contentSize.width - (self.mainView.frame.size.width + 146) - 28) {
                combatScrollView.contentOffset = CGPointMake(combatScrollView.contentSize.width - (self.mainView.frame.size.width + 146)-28, combatScrollView.contentOffset.y);
            }
            
        }
        
    }
   
    


}

- (void)matchBetViewWithBetData:(GC_BetData *)_betData withType:(NSInteger)type{

    self.betData = _betData;
    typeBack = type;
    
//    if (delegate && [delegate respondsToSelector:@selector(footballForecastBetData:withType:)]) {
//        [delegate footballForecastBetData:_betData withType:type];
//    }
}
#pragma mark -
#pragma mark 赛事简析 url 点击回调
- (void)clikeOrderIdURLReturnString:(NSString *)strUrl{

    MyWebViewController *myWeb=[[MyWebViewController alloc]init];
    myWeb.webTitle=@"赛前简析";
    [myWeb LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
//    myWeb.url = strUrl;
    [self.navigationController pushViewController:myWeb animated:YES];
    [myWeb release];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
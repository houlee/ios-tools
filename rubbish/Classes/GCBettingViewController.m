//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCBettingViewController.h"
#import "GC_BetInfo.h"
#import "GC_IssueInfo.h"
#import "GC_IssueList.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "GC_FootballMatch.h"
#import "caiboAppDelegate.h"
#import "NewAroundViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_LotteryUtil.h"
#import "GC_ExplainViewController.h"
#import "NSStringExtra.h"
#import "GC_NewAlgorithm.h"
#import "GC_JCalgorithm.h"
#import "Xieyi365ViewController.h"
#import "CP_KindsOfChoose.h"
//#import "GC_JCBetCell.h"
#import "GCHeMaiInfoViewController.h"
#import "GuoGuanViewController.h"
#import "ChongZhiData.h"
#import "NSDate-Helper.h"
#import "MobClick.h"


//投注界面
@implementation GCBettingViewController
@synthesize request;
@synthesize betArray;
@synthesize dataArray;
@synthesize httpRequest;
@synthesize matchList;
@synthesize issueDetails;
@synthesize bettingstype;
@synthesize issString;
@synthesize isHemai, chaodanbool;
@synthesize betrecorinfo;
@synthesize jiezhistring;
@synthesize saveDangQianIssue, sysTimeSave, retArray, kongArray, sysTime;
- (void)NewAroundViewShowFunc:(GC_BetData *)betdata indexPath:(NSIndexPath *)indexPath{//八方预测
    
    FootballForecastViewController * forecast = [[FootballForecastViewController alloc] init];
    forecast.delegate =self;
    forecast.lotteryType = shengfucaitype;
    forecast.betData = betdata;
    forecast.gcIndexPath = indexPath;
    
    if (castButton.enabled == NO) {
        forecast.matchShowType = fjieqiType;
    }else{
        if ([betdata.zlcString rangeOfString:@"-"].location != NSNotFound) {
            
            if ([betdata.zlcString rangeOfString:@"True"].location != NSNotFound) {
                forecast.matchShowType = fzhonglichangType;
            }else{
                forecast.matchShowType = fjiaohuanType;
            }
            
        }else{
            
            forecast.matchShowType = fsfcshengpingfuType;
            
        }
    }
    
    
    [self.navigationController pushViewController:forecast animated:YES];
    [forecast release];
    
}

#pragma mark -
#pragma mark Initialization
- (NSString *)objectKeyStringSaveDuiZhen{//生成钥匙
    NSString * keystring = @"";
    if (bettingstype == bettingStypeRenjiu) {
        keystring = [NSString stringWithFormat:@"301%@DZ", issString];//@"301";
    }else   if (bettingstype == bettingStypeShisichang) {
        keystring = [NSString stringWithFormat:@"300%@DZ", issString];//@"300";
    }
    
    return keystring;
}

- (NSString *)objectKeyStringSaveHuanCun{//生成钥匙
    NSString * keystring = @"";
    if (bettingstype == bettingStypeRenjiu) {
        keystring = [NSString stringWithFormat:@"301%@HC", issString];//@"301";
    }else   if (bettingstype == bettingStypeShisichang) {
        keystring = [NSString stringWithFormat:@"300%@HC", issString];//@"300";
    }
    
    return keystring;
}


#pragma mark 保存数据和读取数据
/////////////  保存数据和读取数据

- (void)clearSaveFunc{
    
    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
    [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:[self objectKeyString]];
    [saveArray release];
}

- (NSString *)objectKeyString{//生成钥匙
    NSString * keystring = @"";
    if (bettingstype == bettingStypeRenjiu) {
        keystring = [NSString stringWithFormat:@"301%@", issString];//@"301";
    }else   if (bettingstype == bettingStypeShisichang) {
        keystring = [NSString stringWithFormat:@"300%@", issString];//@"300";
    }
    
    return keystring;
}


- (void)sysTimeFunc{//系统时间请求
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
    [httpRequest startAsynchronous];
}
- (void)returnSysTime:(ASIHTTPRequest *)mrequest{//系统时间请求回调
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        self.sysTimeSave = chongzhi.systime;
        
        [chongzhi release];
        
        [self saveDataFunc];
        
    }
}

- (void)sendButtonFunc:(NSMutableArray * )returnarry kongArray:(NSMutableArray *)kongt{

    NSArray * isar = [returnarry objectAtIndex:0];
    NSString * issues = [isar objectAtIndex:0];
    NSLog(@"iss = %@", issues);
    
    NSLog(@"ississString = %@", issString);
    
    
   
    self.issString = issues;
    
    for (int i = 0; i < [issueArray count]; i++) {
        NSString * _issue = [issueArray objectAtIndex:i];
        if ([_issue isEqualToString:issues]) {
            self.issString = [issueArray objectAtIndex:i];
        }
    }
    [self getFootballMatchRequest:issues];
    [self pressQingButton:nil];
    
    NSLog(@"isst = %@", issString);
    
//    for (int i = 0; i < 14; i++) {
//        zhankai[i] = 0;
//    }
    
    [kongzhiType removeAllObjects];
    [kongzhiType addObjectsFromArray:kongt];
    [self stopTimeUpData];
}

- (void)saveDataFunc{//保存选择的数据
    
    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger selectionCount = 0;
    
    for (int i = 0; i < [bettingArray count]; i++) {
                  
            GC_BetData * pkbet = [bettingArray objectAtIndex:i];
            
            
                
                
                
//                if (pkbet.selection1 == YES || pkbet.selection2 == YES || pkbet.selection3 == YES) {
                    
                    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//                    [dataDict setObject:pkbet.changhao forKey:@"changhao"];
                    
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection1] forKey:@"selection1"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection2] forKey:@"selection2"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection3] forKey:@"selection3"];
                    [dataDict setObject:self.sysTimeSave forKey:@"systimesave"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.dandan] forKey:@"dandan"];
                     [dataDict setObject:issString forKey:@"issue"];
                    
                    [saveArray addObject:dataDict];
                    [dataDict release];
//                }
        
                
        if (pkbet.selection1 == YES || pkbet.selection2 == YES || pkbet.selection3 == YES) {
            selectionCount +=1;
        }
        
            
            
            
            
        
    }
    
    if (selectionCount > 0) {
         [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:[self objectKeyString]];
    }else{
        if (judgeBool) {
            judgeBool = NO;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请先选择比赛"];

        }
                
        
        [self clearSaveFunc];
    
    }
    
    [saveArray release];
    
    
    
    if (sendBool) {
        sendBool = NO;
        [self sendButtonFunc:self.retArray kongArray:self.kongArray];
    }
    
    
}

- (void)stopTimeUpData{

    if (bettingstype == bettingStypeRenjiu) {
        
        BOOL danYN = NO;
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * bet = [bettingArray objectAtIndex:i];
            if (bet.dandan) {
                danYN = YES;
                break;
            }
        }
        
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:issString]) {
                xcont = i;
                break;
            }
        }
        IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        
        if (one == 14) {
            
            jiezhistring = isdetail.stopTime;
            jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
        }else if (danYN){
            
            jiezhistring = isdetail.danTuoTime;
            jiezhilabel.textColor = [UIColor redColor];
            
        }else {
            
            jiezhistring = isdetail.stopTime;
             jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
        }
        
        NSArray * zongArr = [jiezhistring componentsSeparatedByString:@" "];
        NSArray * nianArr = [[zongArr objectAtIndex:0] componentsSeparatedByString:@"-"];
        if (nianArr.count < 3) {
            nianArr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        NSArray * shiArr = [[zongArr objectAtIndex:1] componentsSeparatedByString:@":"];
        if (shiArr.count < 2) {
            shiArr = [NSArray arrayWithObjects:@"",@"", nil];
        }
        NSString * stringText = [NSString stringWithFormat:@"%@期截止 %@月%@日 %@:%@", issString, [nianArr objectAtIndex:1], [nianArr objectAtIndex:2], [shiArr objectAtIndex:0], [shiArr objectAtIndex:1]];
        
        jiezhilabel.text = stringText;
        
    }else{
    
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:issString]) {
                xcont = i;
                break;
            }
        }
        IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        
                   
            jiezhistring = isdetail.stopTime;
           jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
     
        
        NSArray * zongArr = [jiezhistring componentsSeparatedByString:@" "];
        NSArray * nianArr = [[zongArr objectAtIndex:0] componentsSeparatedByString:@"-"];
        if (nianArr.count < 3) {
            nianArr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        NSArray * shiArr = [[zongArr objectAtIndex:1] componentsSeparatedByString:@":"];
        if (shiArr.count < 2) {
            shiArr = [NSArray arrayWithObjects:@"",@"", nil];
        }
        
        
        NSString * stringText = [NSString stringWithFormat:@"%@期截止 %@月%@日 %@:%@", issString, [nianArr objectAtIndex:1], [nianArr objectAtIndex:2], [shiArr objectAtIndex:0], [shiArr objectAtIndex:1]];
        
        jiezhilabel.text = stringText;
    }

}

- (void)upDateFunc{
    two = 1;
    one = 0;
    if (bettingstype == bettingStypeShisichang) {
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
            
            two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
        }
        
        
    }else if(bettingstype == bettingStypeRenjiu){
        
        
        
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
        }
        if (one == 9) {//9场的金额算法
            for (GC_BetData * pkb in bettingArray) {
                if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                    two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
                }
            }
            
        }else {
            two = 0;
        }
        
        
    }
    
    
    
    
    if (bettingstype == bettingStypeRenjiu) {
        zhongjiecount = countchang;
        countchang = 0;
        for (int j = 0; j < [bettingArray count]; j++) {
            GC_BetData * pkb = [bettingArray objectAtIndex:j];
            if (pkb.selection1) {
                countchang += 1;
            }
            if (pkb.selection2) {
                countchang += 1;
            }
            if (pkb.selection3) {
                countchang += 1;
            }
            if (pkb.selection1 || pkb.selection2 || pkb.selection3) {
                if (one > 9) {
                    pkb.nengdan = YES;
                    
                    
                    
                }else if(one == 9){
                    //   oneLabel.text =
                    fieldLable.text = @"注";
                    pkb.nengdan = NO;
                }else{
                    pkb.nengdan = NO;
                    
                    oneLabel.text = [NSString stringWithFormat:@"%d", one];
                    twoLabel.text = @"0";
                    fieldLable.text = @"场";
                    
                    
                    
                }
            }
            
            [bettingArray replaceObjectAtIndex:j withObject:pkb];
            int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
            // NSString * string = [string stringByAppendingFormat:@"%d", gc];
            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
            
        }
        if (one > 9) {
            for (int j = 0; j < [bettingArray count]; j++) {
                GC_BetData * be = [bettingArray objectAtIndex:j];
                be.nengyong = YES;
                be.nengdan = YES;
                [bettingArray replaceObjectAtIndex:j withObject:be];
            }
        }
        
        //        if (countchang != butcount) {
        //            for (int j = 0; j < [bettingArray count]; j++) {
        //                GC_BetData * pkb = [bettingArray objectAtIndex:j];
        //                pkb.dandan = NO;
        //                [bettingArray replaceObjectAtIndex:j withObject:pkb];
        //            }
        //
        //        }
        
        if(one == 0){
            
            
            
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            twoLabel.text = @"0";
            fieldLable.text = @"场";
            
        }
        
        
        if (one <= 9) {
            
            for (int j = 0; j < [bettingArray count]; j++) {
                GC_BetData * bet = [bettingArray objectAtIndex:j];
                bet.dandan = NO;
                bet.nengdan = NO;
                [bettingArray replaceObjectAtIndex:j withObject:bet];
            }
            
            //  NSLog(@"two = %d", one);
            
        }
        if (one > 9) {
            [self pressChuanJiuGongGe ];
        }
        
    }
    
    
    if (bettingstype == bettingStypeRenjiu) {
        if (one  == 9) {
            oneLabel.text = [NSString stringWithFormat:@"%d", two];
            twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
        }
        
    }else{
        if (one < 14) {
            oneLabel.text = @"0";
            twoLabel.text = @"0";
        }else{
            oneLabel.text = [NSString stringWithFormat:@"%d", two];
            twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
        }
        
    }
    
    
    
  
    [self stopTimeUpData];
    
    
}

- (void)readDataFunc{//读取选择的数据
    
    NSMutableArray * readArray = [[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyString]];
    
    NSMutableDictionary * Dictionary = [readArray objectAtIndex:0];
    NSString * timeString = [Dictionary objectForKey:@"systimesave"];
    
    NSTimeInterval interval = [[NSDate dateFromString:self.sysTimeSave] timeIntervalSinceDate:[NSDate dateFromString:timeString]];
    NSLog(@"interval = %f", interval);
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"huancunzancun"] intValue] == 1) {
        
        if (interval > 60*60*24) {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
            [self clearSaveFunc];
            return;
        }
        
    }else{
        
        if (interval > 60*60) {
            [self clearSaveFunc];
            return;
        }
        
    }
    
    
    
    
    
    for (int n = 0; n < [readArray count]; n++) {
        
        NSMutableDictionary * readDict = [readArray objectAtIndex:n];
        
        NSString * macthid = [readDict objectForKey:@"issue"];
        
       
                GC_BetData * pkbet = [bettingArray objectAtIndex:n];
                if ([issString isEqualToString:macthid]) {
            
                    
                        if ([[readDict objectForKey:@"selection1"] isEqualToString:@"1"]) {
                            pkbet.selection1 = YES;
                        }else{
                            pkbet.selection1 = NO;
                        }
                        
                        if ([[readDict objectForKey:@"selection2"] isEqualToString:@"1"]) {
                            pkbet.selection2 = YES;
                        }else{
                            pkbet.selection2 = NO;
                        }
                        
                        if ([[readDict objectForKey:@"selection3"] isEqualToString:@"1"]) {
                            pkbet.selection3 = YES;
                        }else{
                            pkbet.selection3 = NO;
                        }
                        
                    if ([[readDict objectForKey:@"dandan"] isEqualToString:@"1"]) {
                        pkbet.dandan = YES;
                    }else{
                        pkbet.dandan = NO;
                    }
                        
                        
                        
                                       
                    
                }
                
                
            
        
    }
    
    
    
    
        
//        [self calculateMoney];
        castButton.enabled = YES;
        castButton.alpha = 1;
    [self upDateFunc];
    [myTableView  reloadData];
   
}
    
    
    
    
    


- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            [self readDataFunc];
        }else{
            [self clearSaveFunc];
        }
        
    }
}



/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef  isCaiPiaoForIPad
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
#else
    return NO;
#endif
}

- (void)doBack{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle
- (void)loadingIphone{
    diyici = YES;
    countjishuqi = 0;
    chaocount = 0;
    zhongjiecount = 0;
    countchao = 0;
    ContentOffDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    saveDangQianIssue = issString;
    //  self.title = @"pk赛投注";
    betInfo = [[GC_BetInfo alloc] init];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    bettingArray = [[NSMutableArray alloc] initWithCapacity:0];
    staArray = [[NSMutableArray alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
    }else{
        //        [self.CP_navigation setHidesBackButton:YES];
        //
        //        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        
        
    }
	
	
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 2, 320, self.mainView.bounds.size.height -46) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    [self getIssueListRequest];
    //
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    if (chaodanbool) {
        titleButton.enabled= NO;
    }else{
        titleButton.enabled = YES;
    }
    
    
    
    [titleButton addSubview:titleLabel];
//    sanjiaolabel = [[UILabel alloc] init];
//    sanjiaolabel.backgroundColor = [UIColor clearColor];
//    sanjiaolabel.textAlignment = NSTextAlignmentCenter;
//    sanjiaolabel.font = [UIFont systemFontOfSize:14];
//    sanjiaolabel.text = @"▼";
//    sanjiaolabel.textColor = [UIColor whiteColor];
//    sanjiaolabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    sanjiaolabel.shadowOffset = CGSizeMake(0, 1.0);
//    [titleButton addSubview:sanjiaolabel];
//    [sanjiaolabel release];
    
    [titleView addSubview:titleButton];
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    
    
    
    //玩法等按钮菜单
    //    UIButton *titleButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    titleButton2.frame = CGRectMake(210, 5, 50, 44);
    //    titleButton2.backgroundColor = [UIColor clearColor];
    //
    //    UIImageView *butbg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 23, 23)];
    //
    //    [titleButton2 addSubview:butbg2];
    //    [butbg2 release];
    //        if (chaodanbool) {
    //            [titleButton2 addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    //
    //            butbg2.image = UIImageGetImageFromName(@"HC_gouwuche.png");
    //
    //        }else{
    //            [titleButton2 addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    //            butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    //        }
    //
    //
    //
    //    [titleView addSubview:titleButton2];
    
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
    if (chaodanbool) {
        [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:UIImageGetImageFromName(@"HC_gouwuche.png") forState:UIControlStateNormal];
        //        butbg2.image = UIImageGetImageFromName(@"HC_gouwuche.png");
        
    }else{
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];

        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
        //        butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    }
    //    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
    
//    UIImageView *  upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
//     upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
//    [self.mainView addSubview:upimageview];
//    [upimageview release];
//    
//    UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 26)];
//    saishila.backgroundColor = [UIColor clearColor];
//    saishila.font = [UIFont systemFontOfSize:13];
//    saishila.textColor = [UIColor whiteColor];
//    saishila.textAlignment = NSTextAlignmentCenter;
//    saishila.text = @"赛事";
//    [upimageview addSubview:saishila];
//    [saishila release];
//    
//    
//    UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 6, 1, 14)];
//    shuimage.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage];
//    [shuimage release];
//    
//    UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 89, 26)];
//    shengla.backgroundColor = [UIColor clearColor];
//    shengla.font = [UIFont systemFontOfSize:13];
//    shengla.textColor = [UIColor whiteColor];
//    shengla.textAlignment = NSTextAlignmentCenter;
//    shengla.text = @"3";
//    [upimageview addSubview:shengla];
//    [shengla release];
//    
//    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149, 6, 1, 15)];
//    shuimage2.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage2];
//    [shuimage2 release];
//    
//    UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 68, 26)];
//    pingla.backgroundColor = [UIColor clearColor];
//    pingla.font = [UIFont systemFontOfSize:13];
//    pingla.textColor = [UIColor whiteColor];
//    pingla.textAlignment = NSTextAlignmentCenter;
//    pingla.text = @"1";
//    [upimageview addSubview:pingla];
//    [pingla release];
//    
//    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 6, 1, 14)];
//    shuimage3.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage3];
//    [shuimage3 release];
//
//    UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219, 0, 320-229, 26)];
//    fula.backgroundColor = [UIColor clearColor];
//    fula.font = [UIFont systemFontOfSize:13];
//    fula.textColor = [UIColor whiteColor];
//    fula.textAlignment = NSTextAlignmentCenter;
//    fula.text = @"0";
//    [upimageview addSubview:fula];
//    [fula release];
    
    titleJieqi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    titleJieqi.backgroundColor = [UIColor colorWithRed:10/255.0 green:117/255.0 blue:193/255.0 alpha:1];
    
    
    jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 320, 20)];
    jiezhilabel.font = [UIFont systemFontOfSize:15];
    jiezhilabel.textAlignment = NSTextAlignmentCenter;
    jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    jiezhilabel.backgroundColor = [UIColor clearColor];
    jiezhilabel.text = jiezhistring;
    [titleJieqi addSubview:jiezhilabel];
    [jiezhilabel release];
    
    
    
    UILabel * numlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabel.font = [UIFont systemFontOfSize:17];
    numlabel.textAlignment = NSTextAlignmentCenter;
    numlabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabel.backgroundColor = [UIColor clearColor];
    numlabel.text = @"3";
    [titleJieqi addSubview:numlabel];
    [numlabel release];
    
    UILabel * zhulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabel.font = [UIFont systemFontOfSize:12];
    zhulabel.textAlignment = NSTextAlignmentCenter;
    zhulabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabel.backgroundColor = [UIColor clearColor];
    zhulabel.text = @"主队胜";
    [titleJieqi addSubview:zhulabel];
    [zhulabel release];

    
    CGSize oneSize = [numlabel.text sizeWithFont:numlabel.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSize = [zhulabel.text sizeWithFont:zhulabel.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabel.frame = CGRectMake(10+(82 - oneSize.width - twoSize.width - 3)/2, 29, oneSize.width, 20);
    zhulabel.frame = CGRectMake(numlabel.frame.origin.x + numlabel.frame.size.width+3, 30, twoSize.width, 20);
    
    
    UIImageView * shuimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(92, 30, 0.5, 17)];
    shuimage1.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage1];
    [shuimage1 release];

    
    
    UILabel * numlabeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabeltwo.font = [UIFont systemFontOfSize:17];
    numlabeltwo.textAlignment = NSTextAlignmentCenter;
    numlabeltwo.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabeltwo.backgroundColor = [UIColor clearColor];
    numlabeltwo.text = @"1";
    [titleJieqi addSubview:numlabeltwo];
    [numlabeltwo release];
    
    UILabel * zhulabeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabeltwo.font = [UIFont systemFontOfSize:12];
    zhulabeltwo.textAlignment = NSTextAlignmentCenter;
    zhulabeltwo.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabeltwo.backgroundColor = [UIColor clearColor];
    zhulabeltwo.text = @"两队平";
    [titleJieqi addSubview:zhulabeltwo];
    [zhulabeltwo release];
    
    
    CGSize oneSizetwo = [numlabeltwo.text sizeWithFont:numlabeltwo.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSizetwo = [zhulabeltwo.text sizeWithFont:zhulabeltwo.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabeltwo.frame = CGRectMake(92+(82 - oneSizetwo.width - twoSizetwo.width - 3)/2, 29, oneSizetwo.width, 20);
    zhulabeltwo.frame = CGRectMake(numlabeltwo.frame.origin.x + numlabeltwo.frame.size.width+3, 30, twoSizetwo.width, 20);
    
    
    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(174, 30, 0.5, 17)];
    shuimage2.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage2];
    [shuimage2 release];
    
    
    UILabel * numlabelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabelthree.font = [UIFont systemFontOfSize:17];
    numlabelthree.textAlignment = NSTextAlignmentCenter;
    numlabelthree.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabelthree.backgroundColor = [UIColor clearColor];
    numlabelthree.text = @"0";
    [titleJieqi addSubview:numlabelthree];
    [numlabelthree release];
    
    UILabel * zhulabelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabelthree.font = [UIFont systemFontOfSize:12];
    zhulabelthree.textAlignment = NSTextAlignmentCenter;
    zhulabelthree.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabelthree.backgroundColor = [UIColor clearColor];
    zhulabelthree.text = @"主队负";
    [titleJieqi addSubview:zhulabelthree];
    [zhulabelthree release];
    
    
    CGSize oneSizethree = [numlabelthree.text sizeWithFont:numlabelthree.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSizethree = [zhulabelthree.text sizeWithFont:zhulabelthree.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabelthree.frame = CGRectMake(174+(82 - oneSizethree.width - twoSizethree.width - 3)/2, 29, oneSizethree.width, 20);
    zhulabelthree.frame = CGRectMake(numlabelthree.frame.origin.x + numlabelthree.frame.size.width+3, 30, twoSizethree.width, 20);
    
    
    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(174+82, 30, 0.5, 17)];
    shuimage3.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage3];
    [shuimage3 release];
    
    UILabel * zhulabelfour = [[UILabel alloc] initWithFrame:CGRectMake(174+82, 30, 54, 20)];
    zhulabelfour.font = [UIFont systemFontOfSize:12];
    zhulabelfour.textAlignment = NSTextAlignmentCenter;
    zhulabelfour.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabelfour.backgroundColor = [UIColor clearColor];
    zhulabelfour.text = @"分析";
    [titleJieqi addSubview:zhulabelfour];
    [zhulabelfour release];
    
    [self.mainView addSubview:titleJieqi];
    [titleJieqi release];
    
    myTableView.frame = CGRectMake(0, 52, 320, self.mainView.bounds.size.height - 71-52+28);
    
    
    

}

- (void)loadingIpad{
    diyici = YES;
    countjishuqi = 0;
    chaocount = 0;
    zhongjiecount = 0;
    countchao = 0;
//    saveDangQianIssue = issString;
    //  self.title = @"pk赛投注";
    betInfo = [[GC_BetInfo alloc] init];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    bettingArray = [[NSMutableArray alloc] initWithCapacity:0];
    staArray = [[NSMutableArray alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
    }else{
        //        [self.CP_navigation setHidesBackButton:YES];
        //
        //        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        
        
    }
	
	
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bg.image= UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bg];
    [bg release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 2, 320, self.mainView.bounds.size.height -46) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    [self getIssueListRequest];
    //
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60+35, 0, 260, 44)];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    if (chaodanbool) {
        titleButton.enabled= NO;
    }else{
        titleButton.enabled = YES;
    }
    
    
    
    [titleButton addSubview:titleLabel];
//    sanjiaolabel = [[UILabel alloc] init];
//    sanjiaolabel.backgroundColor = [UIColor clearColor];
//    sanjiaolabel.textAlignment = NSTextAlignmentCenter;
//    sanjiaolabel.font = [UIFont systemFontOfSize:14];
//    sanjiaolabel.text = @"▼";
//    sanjiaolabel.textColor = [UIColor whiteColor];
//    sanjiaolabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    sanjiaolabel.shadowOffset = CGSizeMake(0, 1.0);
//    [titleButton addSubview:sanjiaolabel];
//    [sanjiaolabel release];
    
    [titleView addSubview:titleButton];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    
    
    
    //玩法等按钮菜单
    //    UIButton *titleButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    titleButton2.frame = CGRectMake(210, 5, 50, 44);
    //    titleButton2.backgroundColor = [UIColor clearColor];
    //
    //    UIImageView *butbg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 23, 23)];
    //
    //    [titleButton2 addSubview:butbg2];
    //    [butbg2 release];
    //        if (chaodanbool) {
    //            [titleButton2 addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    //
    //            butbg2.image = UIImageGetImageFromName(@"HC_gouwuche.png");
    //
    //        }else{
    //            [titleButton2 addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    //            butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    //        }
    //
    //
    //
    //    [titleView addSubview:titleButton2];
    
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
    if (chaodanbool) {
        [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:UIImageGetImageFromName(@"HC_gouwuche.png") forState:UIControlStateNormal];
        //        butbg2.image = UIImageGetImageFromName(@"HC_gouwuche.png");
        
    }else{
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];

        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
        //        butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    }
    //    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
    
//    UIImageView *  upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 390, 26)];
////    upimageview.backgroundColor = [UIColor clearColor];
////    upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
//     upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
//    [self.mainView addSubview:upimageview];
//    [upimageview release];
    
//    UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 59, 26)];
//    saishila.backgroundColor = [UIColor clearColor];
//    saishila.font = [UIFont systemFontOfSize:13];
//    saishila.textColor = [UIColor whiteColor];
//    saishila.textAlignment = NSTextAlignmentCenter;
//    saishila.text = @"赛事";
//    [upimageview addSubview:saishila];
//    [saishila release];
//    
//    
//    UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59+35, 6, 1, 14)];
//    shuimage.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage];
//    [shuimage release];
//    
//    UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60+35, 0, 89, 26)];
//    shengla.backgroundColor = [UIColor clearColor];
//    shengla.font = [UIFont systemFontOfSize:13];
//    shengla.textColor = [UIColor whiteColor];
//    shengla.textAlignment = NSTextAlignmentCenter;
//    shengla.text = @"3";
//    [upimageview addSubview:shengla];
//    [shengla release];
//    
//    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149+35, 6, 1, 15)];
//    shuimage2.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage2];
//    [shuimage2 release];
//    
//    UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150+35, 0, 68, 26)];
//    pingla.backgroundColor = [UIColor clearColor];
//    pingla.font = [UIFont systemFontOfSize:13];
//    pingla.textColor = [UIColor whiteColor];
//    pingla.textAlignment = NSTextAlignmentCenter;
//    pingla.text = @"1";
//    [upimageview addSubview:pingla];
//    [pingla release];
//    
//    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218+35, 6, 1, 14)];
//    shuimage3.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage3];
//    [shuimage3 release];
//    
//    UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219+35, 0, 320-229, 26)];
//    fula.backgroundColor = [UIColor clearColor];
//    fula.font = [UIFont systemFontOfSize:13];
//    fula.textColor = [UIColor whiteColor];
//    fula.textAlignment = NSTextAlignmentCenter;
//    fula.text = @"0";
//    [upimageview addSubview:fula];
//    [fula release];
    
//    if (chaodanbool) {

//    }else{
    
        titleJieqi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 390, 20)];
        titleJieqi.backgroundColor = [UIColor clearColor];
        
        
        UIImageView * xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 37-28, 49+35, 2)];
        xian1.backgroundColor = [UIColor clearColor];
        xian1.image = UIImageGetImageFromName(@"SZTG960.png");
        [titleJieqi addSubview:xian1];
        [xian1 release];
        
        jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(70+35, 0, 180, 20)];
        jiezhilabel.font = [UIFont systemFontOfSize:12];
        jiezhilabel.textAlignment = NSTextAlignmentCenter;
        jiezhilabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        jiezhilabel.backgroundColor = [UIColor clearColor];
        jiezhilabel.text = jiezhistring;
        [titleJieqi addSubview:jiezhilabel];
        [jiezhilabel release];
        
        UIImageView * xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(260+35, 37-28, 49+35, 2)];
        xian2.backgroundColor = [UIColor clearColor];
        xian2.image = UIImageGetImageFromName(@"SZTG960.png");
        [titleJieqi addSubview:xian2];
        [xian2 release];
        
        [self.mainView addSubview:titleJieqi];
        [titleJieqi release];
        
        myTableView.frame = CGRectMake(0, 52, 390, self.mainView.bounds.size.height - 71-52+28);
        
//    }


}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    issueTypeArray = [[NSMutableArray alloc] initWithCapacity:0];
#ifdef isCaiPiaoForIPad
    [self loadingIpad];
   
#else
     [self loadingIphone];
#endif
    
    
}

- (void)otherLottoryViewController:(NSInteger)indexd title:(NSString *)titleStr lotteryType:(NSInteger)lotype lotteryId:(NSString *)loid{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfo.title = titleStr;
    hemaiinfo.lotteryType = lotype;
    hemaiinfo.lotteryId = loid;
    hemaiinfo.paixustr = @"DD";
    
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.title = titleStr;
    hemaiinfotwo.lotteryType = lotype;
    hemaiinfotwo.lotteryId = loid;
    hemaiinfotwo.paixustr = @"AD";
    
    GCHeMaiInfoViewController * hongren = [[GCHeMaiInfoViewController alloc] init];
    hongren.title = titleStr;
    hongren.lotteryType = lotype;
    hongren.lotteryId = loid;
    hongren.paixustr = @"HR";
    
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:hemaiinfo, hemaiinfotwo,hongren, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"最新"];
    [labearr addObject:@"人气"];
    [labearr addObject:@"红人榜"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggzx.png"];
    [imagestring addObject:@"ggrq.png"];
    [imagestring addObject:@"gghrb.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggzx_1.png"];
    [imageg addObject:@"ggrq_1.png"];
    [imageg addObject:@"gghrb_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [hemaiinfo release];
    [hemaiinfotwo release];
    [hongren release];
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
//    [allimage addObject:@"15.png"];
    [allimage addObject:@"shijianxuanzhe.png"];
    [allimage addObject:@"menuggtj.png"];
//    [allimage addObject:@"menuhmdt.png"];
    [allimage addObject:@"gc_zancunimage.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
//    [alltitle addObject:@"联赛筛选"];
    [alltitle addObject:@"期号选择"];
    [alltitle addObject:@"中奖排行"];
//    [alltitle addObject:@"合买大厅"];
    [alltitle addObject:@"暂存"];
    [alltitle addObject:@"玩法说明"];
    
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

- (void)ggOtherLottoryViewController:(NSInteger)indexd{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    GuoGuanViewController *my = [[GuoGuanViewController alloc] init];
    my.ggType = shengFuCaiType;
    
    GuoGuanViewController *my2 = [[GuoGuanViewController alloc] init];
    my2.ggType = renXuanJiuType;
    
    GuoGuanViewController * my3 = [[GuoGuanViewController alloc] init];
    my3.ggType = WoDeGuoGuanType;
    if (indexd == 0) {
        my3.renorsheng = shengfu;
    }else if(indexd == 1){
        my3.renorsheng = renjiu;
    }
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, my3, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"胜负彩"];
    [labearr addObject:@"任选9"];
    [labearr addObject:@"我的中奖"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];

    [imagestring addObject:@"ggssc.png"];
    [imagestring addObject:@"ggrxq.png"];
    [imagestring addObject:@"ggwdcp.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggssc_1.png"];
    [imageg addObject:@"ggrxq_1.png"];
    [imageg addObject:@"ggwdcp_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    tabc.backgroundImage = nil;
    
    
    
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my3 release];
    [my release];
}

- (void)returnSelectIndex:(NSInteger)index{
   if(index == 0){
       
//       if (bettingstype == bettingStypeRenjiu) {
//           [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:@"任选9"];
//       }
//       else {
//           [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:
//            @"胜负彩"];
//       }
       
        [self pressTitleButton:nil];
        
    }else if(index == 3){
        
        if (bettingstype == bettingStypeRenjiu) {
            [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:@"任选9"];
        }else{
            [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:@"胜负彩"];
        }
        [self pressHelpButton:nil];
    }else if(index == 1){
        if (bettingstype == bettingStypeShisichang) {
            [MobClick event:@"event_goucai_zulancai_zhongjiangpaihang" label:@"胜负彩"];
            [self ggOtherLottoryViewController:0];
        }else{
            [MobClick event:@"event_goucai_zulancai_zhongjiangpaihang" label:@"任选9"];
            [self ggOtherLottoryViewController:1];
        }
    }
//    else if(index == 2){
//        if (bettingstype == bettingStypeShisichang) {
//            [MobClick event:@"event_goucai_hemaidating_caizhong" label:@"胜负彩"];
//             [self otherLottoryViewController:0 title:@"胜负彩合买" lotteryType:13 lotteryId:@"300"];
//        }else{
//            [MobClick event:@"event_goucai_hemaidating_caizhong" label:@"任选9"];
//            [self otherLottoryViewController:0 title:@"任选九合买" lotteryType:14 lotteryId:@"301"];
//            
//        }
//    }
    else if(index == 2){
        if (bettingstype == bettingStypeRenjiu) {
            [MobClick event:@"event_goucai_zancun_caizhong" label:@"任选九"];
        }
        else {
            [MobClick event:@"event_goucai_zancun_caizhong" label:@"胜负彩"];
        }
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"huancunzancun"];
        judgeBool = YES;
        [self sysTimeFunc];
    }
}


- (void)pressTitleButton1:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao_selected.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    
}
- (void)pressTitleButton2:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
}
//选择期数的ui
- (void)pressTitleButton:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"期号",@"title", issueArray,@"choose", nil];
    
    
    if ([kongzhiType count] == 0) {
        NSMutableArray * issarr = [NSMutableArray array];
        for (int i = 0; i < [issueArray count]; i++) {
            NSString * str = [issueArray objectAtIndex:i];
            if ([str isEqualToString:issString]) {
                [issarr addObject:@"1"];
            }else{
                [issarr addObject:@"0"];
            }
            
        }
        
        NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
              
        [kongzhiType addObject:type1];
        
    }
    
    
    [array addObject:dic];

    

    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"期号选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
   




    
    
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (buttonIndex == 1) {
        sendBool = YES;
        self.retArray = returnarry;
        self.kongArray = kongt;
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
        [self sysTimeFunc];
       
//        [self sendButtonFunc:returnarry kongArray:kongt];
    }
    

}


//九宫格按钮
- (void)pressjiugongge:(UIButton *)sender{
    if (sender.tag > [issueArray count]) {
        return;
    }
    
    
    //   if (but[sender.tag] == 0) {
    UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
    image.hidden = NO;
    UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
    imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
    //   sender.backgroundColor  = [UIColor blueColor];
    but[sender.tag] = 1;
    for (int i = 1; i < [issueArray count]; i++) {
        if (i == sender.tag) {
            
            continue;
        }
        //             UIButton * vi = (UIButton *)[imgev viewWithTag:i];
        //            vi.enabled = NO;
        
    }
    [self performSelector:@selector(pressBgButton:) withObject:nil afterDelay:.0];
    
    //   }
    //    }else{
    //        for (int i = 1; i < 13; i++) {
    //
    //            UIButton * vi = (UIButton *)[imgev viewWithTag:i];
    //            vi.enabled = YES;
    //        }
    //        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
    //        image.hidden = YES;
    //        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
    //        imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
    //      //  sender.backgroundColor = [UIColor whiteColor];
    //        but[sender.tag] = 0;
    //    }
    
}
//选择期数 和背景点击消失
- (void)pressBgButton:(UIButton *)sender{
    
    int n;
    for (int i = 1; i < 13; i++) {
        if (but[i] == 1) {
            n = i;
            NSLog(@"i = %d", i);
            break;
        }
    }
    NSLog(@"n = %d", n);
    
    if ((n-1) < [issueArray count]) {
        if (bettingstype == bettingStypeRenjiu) {
            titleLabel.text =[NSString stringWithFormat:@"任选九%@期", [issueArray objectAtIndex:n-1]];
        }
        if (bettingstype == bettingStypeShisichang) {
            titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:n-1]];
        }
        UIFont * font = titleLabel.font;
        CGSize  size = CGSizeMake(180, 34);
        CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//        sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
        
        [self getFootballMatchRequest:[issueArray objectAtIndex:n-1]];
        [self pressQingButton:nil];
        self.issString = [issueArray objectAtIndex:n-1];
        
        NSLog(@"iss = %@", issString);
        but[n] = 0;
    }
    [bgview performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.4];
    
    // [bgview removeFromSuperview];
}

//请求期号
- (void)getIssueListRequest
{
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    int lotteryType = 14;
    if (betInfo.lotteryType == TYPE_ZC_BANQUANCHANG) {
        lotteryType = 6;
    } else if (betInfo.lotteryType == TYPE_ZC_JINQIUCAI) {
        lotteryType = 4;
    }
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetZucaiJingcaiIssueList:lotteryType];
    NSLog(@"lotter = %d", lotteryType);
    NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setPostBody:postData];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqIssueListFinished:)];
    [httpRequest startAsynchronous];
    
    
}

- (void)reqIssueListFinished:(ASIHTTPRequest*)_request
{
    
    
    if ([_request responseData]) {
        GC_IssueList *issuelist = [[GC_IssueList alloc] initWithResponseData:[_request responseData]WithRequest:_request];
        self.issueDetails = issuelist.details;
        if (self.issString) {
            if ([self.issString length] <= 0 ) {
                self.issString = issuelist.defaultIssue;
            }
        }
        
        NSLog(@"%@", issuelist.details);
        if (issuelist.returnId == 3000) {
            [issuelist release];
            return;
        }
        
       
        
        if (issuelist.issueCount == 0) {
            [bettingArray removeAllObjects];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"赛程更新中，请稍后再试"];
            [myTableView reloadData];
        }
        
        if (issuelist.issueCount > 0 && [issuelist.details count] == 0) {
            if (countjishuqi < 3) {
                countjishuqi += 1;
                [self getIssueListRequest];
               
            }else{
                countjishuqi = 0;
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"网络原因，请稍后再试"];
                [myTableView reloadData];
            }
            [issuelist release];
             return;
        
        }
        
        
        if (issuelist.details.count > 0) {
            // NSMutableArray *issues = [NSMutableArray arrayWithCapacity:issuelist.details.count];
            [issueTypeArray removeAllObjects];
            for (IssueDetail *_detail in issuelist.details) {
                
                // if ([_detail.status isEqualToString:@"1"]) {
                [issueArray addObject:_detail.issue];
                [staArray addObject:_detail.status];
                [issueTypeArray addObject:_detail];
                //  }
                
                if (![_detail.status isEqualToString:@"1"]) {//如果不是当前期的 清一下缓存
                    
                    NSString * keystring = @"";
                    if (bettingstype == bettingStypeRenjiu) {
                        keystring = [NSString stringWithFormat:@"301%@", _detail.issue];//@"301";
                    }else   if (bettingstype == bettingStypeShisichang) {
                        keystring = [NSString stringWithFormat:@"300%@", _detail.issue];//@"300";
                    }
                   
                    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
                    [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:keystring];
                    [saveArray release];
                }
               
                
                NSLog(@"issue = %@", _detail.issue);
                NSLog(@"id = %@", _detail.stopTime);
                NSLog(@"idsd = %@", _detail.status);
            }
            
//            if (isHemai) {
                for (IssueDetail *_detail in issuelist.details) {
                    
                    if ([_detail.status isEqualToString:@"1"]) {
                        self.issString = _detail.issue;
                        saveDangQianIssue = issString;
                    }
                    
                }
                
//            }
            
            //  issueComboBox.popUpBoxDatasource = issues;
            //  issueComboBox.text = issuelist.defaultIssue;
            //        [self updateStopTimeLabel];
            //  //暂时
            //            [self getFootballMatchRequest:[issueArray objectAtIndex:0]];//传入期次 要传当前期 如果没有的话 就传最近预售期
            //            titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:0]];
            
            //正式的
            //            issString = nil;
            //            [issueArray removeAllObjects];
            if (!issString||[issString isEqualToString:@""]||[issString isEqualToString:@"null"]||[issString length]==0||issString == nil||![issString isAllNumber]) {
                [self getFootballMatchRequest:[issueArray objectAtIndex:0]];
                titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:0]];
                UIFont * font = titleLabel.font;
                CGSize  size = CGSizeMake(180, 34);
                CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
                sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//                sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
				self.issString = [issueArray objectAtIndex:0];
                
                
//                titleJieqi.hidden = NO;

                
                if (![[staArray objectAtIndex:0] isEqualToString:@"1"]) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"本期不能购买"];
                    castButton.enabled = NO;
                    castButton.alpha = 0.5;
//                    titleJieqi.hidden = YES;
//#ifdef isCaiPiaoForIPad

//#endif
                    
                }
                
            }else{
                NSLog(@"iss = %@", issString);
                castButton.enabled = YES;
                castButton.alpha = 1;
                
                
//                NSInteger xcont = 0;
//                for (int i = 0; i < [ issueTypeArray count]; i++) {
//                    IssueDetail * detail = [issueTypeArray objectAtIndex:i];
//                    if ([detail.issue isEqualToString:issString]) {
//                        xcont = i;
//                        break;
//                    }
//                }
//                IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
//                jiezhistring = isdetail.stopTime;
//                jiezhilabel.text = jiezhistring;
                
                [self stopTimeUpData];
                
                [self getFootballMatchRequest:issString];//传入期次 要传当前期 如果没有的话 就传最近预售期
                if (bettingstype == bettingStypeRenjiu) {
                    titleLabel.text =[NSString stringWithFormat:@"任选九%@期", issString];
                }
                if (bettingstype == bettingStypeShisichang) {
                    titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", issString];
                }
                UIFont * font = titleLabel.font;
                CGSize  size = CGSizeMake(180, 34);
                CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
                sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//                sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
//                titleJieqi.hidden = NO;

            }
            
            [myTableView reloadData];
            
            
        }
        [issuelist release];
    }else{
        
        [self getIssueListRequest];
    }
}



//请求比赛
- (void)getFootballMatchRequest:(NSString *)_issue
{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    NSLog(@"iss = %@", _issue);
    if (!_issue || _issue.length <= 0) return;
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    int lotteryType = 13;
    if (betInfo.lotteryType == TYPE_ZC_BANQUANCHANG) {
        lotteryType = 6;
    } else if (betInfo.lotteryType == TYPE_ZC_JINQIUCAI) {
        lotteryType = 4;
    }
    //    BOOL youfoubool = NO;
    NSString *issueStatus = nil;
    for (IssueDetail *issueDetail in self.issueDetails) {
        if ([issueDetail.issue isEqualToString:_issue]) {
            // if ([issueStatus isEqualToString:@"1"]) {
            issueStatus = issueDetail.status;
            //   }
            //            youfoubool = YES;
            NSLog(@"status = %@", issueStatus);
            NSLog(@"_issue = %@", _issue);
        }
        
        
    }
    // issueStatus = nil;
    //测试
    // issueStatus = @"1";
    
    
    if (![issueStatus isEqualToString:@"1"]) {
//        titleJieqi.hidden = YES;

        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"本期不能购买"];
        castButton.enabled = NO;
        castButton.alpha = 0.5;
        if (!issueStatus) {
            IssueDetail *issueDetail = [self.issueDetails objectAtIndex:1];
            issueStatus = issueDetail.status;
            _issue = issueDetail.issue;
            self.issString = _issue;
            
        }
        //        IssueDetail * iss = [self.issueDetails objectAtIndex:0];
        //        issueStatus = iss.issue;
        //        issString = iss.issue;
        
        
        //        if (!youfoubool) {
        //            IssueDetail *issueDetail = [self.issueDetails objectAtIndex:1];
        //            issueStatus = issueDetail.status;
        //            _issue = issueDetail.issue;
        //            issString = _issue;
        //        }
        
        
       
        
        
    }else{
        castButton.enabled = YES;
        castButton.alpha = 1;
//        titleJieqi.hidden = NO;

        
    }
    
    if (bettingstype == bettingStypeRenjiu) {
        titleLabel.text =[NSString stringWithFormat:@"任选九%@期", _issue];
    }
    if (bettingstype == bettingStypeShisichang) {
        titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", _issue];
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
//    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    NSLog(@"iss = %@, issueStatus = %@", _issue, issueStatus);
    
    
    NSString * hcDateKey = nil;
    
   
    if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]) {
        hcDateKey = [NSString stringWithFormat:@"%@@%@", _issue,[[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]];
    }else{
            
        hcDateKey = [NSString stringWithFormat:@"%@@", _issue];
            
    }
    
    self.issString = _issue;
    
    NSLog(@"hcdate = %@", hcDateKey);
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetZucaiJingcaiMatch:lotteryType issue:hcDateKey isStop:@"-" match:@"-"];
    
    if (chaodanbool == NO) {
        
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:_issue]) {
                xcont = i;
                break;
            }
        }
        IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        if ([isdetail.status isEqualToString:@"1"]) {
//            titleJieqi.hidden = NO;
            jiezhilabel.hidden = NO;
            
//#ifdef isCaiPiaoForIPad
//            myTableView.frame = CGRectMake(0, 20, 390, self.mainView.bounds.size.height - 71-52+28);
//#else
//            myTableView.frame = CGRectMake(0, 20, 320, self.mainView.bounds.size.height - 71-52+28);
//#endif
            
        }else{
            jiezhilabel.hidden = YES;
//            titleJieqi.hidden = YES;
//#ifdef isCaiPiaoForIPad
//            myTableView.frame = CGRectMake(0, 0, 390, self.mainView.bounds.size.height - 71+28);
//
//#else
//            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 71+28);
//
//#endif
            
        }
        [self stopTimeUpData];
    }
   
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqFootballMatchFinished:)];
    [httpRequest setDidFailSelector:@selector(requestFailed:)];
    [httpRequest setUserInfo:[NSDictionary dictionaryWithObject:issueStatus forKey:@"issue"]];
    [httpRequest startAsynchronous];
}
- (void)requestFailed:(ASIHTTPRequest *)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }

}
- (void)chaodanshuzu{
    for (int i = 0; i < [betrecorinfo.betContentArray count]; i++) {
        NSLog(@"201 = %@", [betrecorinfo.betContentArray objectAtIndex:i]);
    }
    NSLog(@"jine = %@  %@", betrecorinfo.betsNum, betrecorinfo.programAmount);
    //   bettingArray尤　文
    
    
    for (int i = 0; i < [betrecorinfo.betContentArray count]; i++) {
        NSString * teamstr = [betrecorinfo.betContentArray objectAtIndex:i];
        NSArray * arrte = [teamstr componentsSeparatedByString:@";"];
        
        GC_BetData * pkb = [bettingArray objectAtIndex:i];
        if (arrte.count < 2) {
            arrte = [NSArray arrayWithObjects:@"",@"", nil];
        }
        NSString * spfstr = [arrte objectAtIndex:2];
        NSLog(@"spfstr = %@", spfstr);
        if ([spfstr length] == 1) {
            NSLog(@"qian = %@", spfstr);
            if ([spfstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
                
            }else if([spfstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([spfstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            
        }else if([spfstr length] == 2){
            NSString * qianstr = [spfstr substringToIndex:1];
            NSString * houstr = [spfstr substringWithRange:NSMakeRange(1, 1)];
            NSLog(@"qian = %@, hou = %@", qianstr, houstr);
            if ([qianstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
            }else if([qianstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([qianstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            if ([houstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
            }else if([houstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([houstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            
            
            
        }else if([spfstr length] == 3){
            
            NSString * qianstr = [spfstr substringToIndex:1];
            NSString * zhongstr = [spfstr substringWithRange:NSMakeRange(1, 1)];
            NSString * houstr = [spfstr substringWithRange:NSMakeRange(2, 1)];
            NSLog(@"qian = %@, zhong = %@, hou = %@", qianstr, zhongstr, houstr);
            if ([qianstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
            }else if([qianstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([qianstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            
            if ([zhongstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
            }else if([zhongstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([zhongstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            
            if ([houstr isEqualToString:@"3"]) {
                pkb.selection1 = YES;
            }else if([houstr isEqualToString:@"1"]){
                pkb.selection2 = YES;
            }else if([houstr isEqualToString:@"0"]){
                pkb.selection3 = YES;
            }
            
        }
        
        
        
        
    }
    
    
    
    
    
    two = 1;
    one = 0;
    if (bettingstype == bettingStypeShisichang) {
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
            
            two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
        }
        
    }else if(bettingstype == bettingStypeRenjiu){
        
        
        
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
        }
        if (one == 9) {
            for (GC_BetData * pkb in bettingArray) {
                if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                    two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
                }
            }
            
        }else {
            two = 0;
        }
        
        
    }
    NSLog(@"two = %d", one);
    oneLabel.text = [NSString stringWithFormat:@"%d", two];
    twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
    
    
}

- (void)reqFootballMatchFinished:(ASIHTTPRequest*)_request
{
    [bettingArray removeAllObjects];
    NSLog(@"reqFootballMatchFinished = %@", [_request responseData]);
    if ([_request responseData]) {
        GC_FootballMatch *footballMatch = [[GC_FootballMatch alloc] initWithResponseData:[_request responseData]WithRequest:request];
        
         NSString *issueStatus = [_request.userInfo objectForKey:@"issue"];
        
        NSString *issueS = nil;
        for (IssueDetail *issueDetail in self.issueDetails) {
            if ([issueDetail.issue isEqualToString:issString]) {
                // if ([issueStatus isEqualToString:@"1"]) {
                issueS = issueDetail.status;
                //   }
                //            youfoubool = YES;
                NSLog(@"status = %@", issueS);
//                NSLog(@"_issue = %@", issueStatus);
            }
            
            
        }

        if ([issueS isEqualToString:@"1"]) {
            
            if (footballMatch.update == 1) {
                
                
                [[NSUserDefaults standardUserDefaults] setValue:footballMatch.dateString forKey:[self  objectKeyStringSaveHuanCun]];
                [[NSUserDefaults standardUserDefaults] setValue:[_request responseData] forKey:[self  objectKeyStringSaveDuiZhen]];
                
            }
            
            if (footballMatch.update == 0) {
                
                    NSLog(@"xxxx = %@", [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]]);
                    NSData *responseData2 = [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]] ;
                    
                    GC_FootballMatch *duizhen2 = [[GC_FootballMatch alloc] initWithResponseData:responseData2 WithRequest:request];
                    self.matchList = duizhen2.matchList;
                    [duizhen2 release];
                    
             
            }else{
            
                self.matchList = footballMatch.matchList;
            
            }

        
        
        }else{
            self.matchList = footballMatch.matchList;
        }
        
        
       
        self.sysTime = footballMatch.systemTime;
        self.sysTimeSave = footballMatch.systemTime;
        NSLog(@"footballmatch = %@", self.matchList);
        [footballMatch release];
        NSLog(@"fotballmatch ");
       
        for (GC_MatchInfo *matchInfo in self.matchList) {
            matchInfo.issueStatus = issueStatus;
            NSLog(@"%@", self.matchList);
            GC_BetData * betdata = [[GC_BetData alloc] init];
            betdata.event = matchInfo.leagueName;
            betdata.bifen = matchInfo.endScore;
            betdata.caiguo = matchInfo.caiguo;
            betdata.zlcString = matchInfo.zlcString;
//            betdata.zlcString = @"-sdd";
            
            NSLog(@"event = %@", betdata.event);
            NSArray * timedata = [matchInfo.startTime componentsSeparatedByString:@" "];
            if (timedata.count < 2) {
                timedata = [NSArray arrayWithObjects:@"",@"", nil];
            }
            betdata.date = [timedata objectAtIndex:0];
            NSLog(@"date = %@",betdata.date);
            betdata.time = [timedata objectAtIndex:1];
            betdata.team = [NSString stringWithFormat:@"%@,%@,%@", matchInfo.home, matchInfo.away, matchInfo.assignCount];
            betdata.saishiid = matchInfo.identifier;
            NSLog(@"team = %@", betdata.team);
            NSLog(@"eurpei = %@", matchInfo.eurPei);
            if ([matchInfo.eurPei length] > 1) {
                NSRange  kongge = [matchInfo.eurPei rangeOfString:@" "];
                if (kongge.location != NSNotFound) {
                    NSArray * butarray = [matchInfo.eurPei componentsSeparatedByString:@" "];//ccc
                    if (butarray.count > 2) {
                        betdata.but1 = [butarray objectAtIndex:0];//ccc
                        // NSLog(@"but = %@", betdata.but1);
                        betdata.but2 = [butarray objectAtIndex:1];
                        betdata.but3 = [butarray objectAtIndex:2];//ccc
                    }
                }
                
            }
            
            [bettingArray addObject:betdata];
            [betdata release];
        }
        //  if (matchList.count > 0) [self updateUI];
        
        

        
    }
    if (chaodanbool) {
        if(chaocount == 0){
            [self chaodanshuzu];
        }
        chaocount++;
        
    }
    [myTableView reloadData];
//    if (diyici) {
//        diyici = NO;
//        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"zucaiyemian"] intValue]) {
//            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"zucaiyemian"];
//           
////             = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPhat];
//            if ([bettingArray count] > 0) {
//                 NSIndexPath * indexPhat = [NSIndexPath indexPathForRow:0 inSection:0];
////                zhankai[0] = 1;
//                [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPhat] withRowAnimation:UITableViewRowAnimationNone];
//                CP_CanOpenCell *cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPhat];
//                [cell hidenButonScollWithAnime:NO];
//                [cell showButonScollWithAnime:YES];
//
//            }
//            
//            
//        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"zucaiyemian"] intValue] > 0 && [[[NSUserDefaults standardUserDefaults] objectForKey:@"zucaiyemian"] intValue] < 10){
//            NSInteger countcishu = [[[NSUserDefaults standardUserDefaults] objectForKey:@"zucaiyemian"] intValue]+1;
//            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", countcishu] forKey:@"zucaiyemian"];
//           
////            CP_CanOpenCell *cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPhat];
//            if ([bettingArray count] > 0) {
//                 NSIndexPath * indexPhat = [NSIndexPath indexPathForRow:0 inSection:0];
////                zhankai[0] = 1;
//                [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPhat] withRowAnimation:UITableViewRowAnimationNone];
//                CP_CanOpenCell *cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPhat];
//                [cell hidenButonScollWithAnime:NO];
//                [cell showButonScollWithAnime:YES];
//            }
//            
//            
//        }
//    }
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }

    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyString]]) {
        NSMutableArray * readArray = [[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyString]];
        if (chaodanbool == NO && [readArray count] > 0) {
            
            
            NSMutableArray * readArray = [[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyString]];
            
            NSMutableDictionary * Dictionary = [readArray objectAtIndex:0];
            NSString * timeString = [Dictionary objectForKey:@"systimesave"];
            
            NSTimeInterval interval = [[NSDate dateFromString:self.sysTimeSave] timeIntervalSinceDate:[NSDate dateFromString:timeString]];
            NSLog(@"interval = %f", interval);
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"huancunzancun"] intValue] == 1) {
                
                if (interval > 60*60*24) {
                    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
                    [self clearSaveFunc];
                    return;
                }
                
            }else{
                
                if (interval > 60*60) {
                    [self clearSaveFunc];
                    return;
                }
                
            }
            
            
            NSInteger xcont = 0;
            for (int i = 0; i < [ issueTypeArray count]; i++) {
                IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                if ([detail.issue isEqualToString:issString]) {
                    xcont = i;
                    break;
                }
            }
            IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
            
            if (![isdetail.status isEqualToString:@"1"]) {
                [self clearSaveFunc];
                return;
            }
            
            
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                                  message:@"是否恢复上次投注内容"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                        otherButtonTitles:@"确定", nil];
            alert.tag = 2;
            alert.delegate = self;
            [alert show];
            [alert release];
            
            
            //            [self readDataFunc];
            
            
        }
    }
    
}


- (void)pressRightButton:(id)sender{
    PKGameExplainViewController * pkevc = [[PKGameExplainViewController alloc] init];
    [self.navigationController pushViewController:pkevc animated:YES];
    [pkevc release];
    
}

- (void)tabBarView{
#ifdef isHaoLeCai
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 392, 320, 44)];
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 480, 320, 44);
    }
#else
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 44)];
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 460, 320, 44);
    }
#endif
#ifdef isCaiPiaoForIPad
     tabView.frame = CGRectMake(0, 660, 390, 44);
#endif
    
    UIImageView * tabBack = [[UIImageView alloc] initWithFrame:tabView.bounds];
//    tabBack.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    tabBack.backgroundColor = [UIColor blackColor];
    
    //已选
    UILabel * pitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    pitchLabel.text = @"";
    pitchLabel.textAlignment = NSTextAlignmentCenter;
    pitchLabel.font = [UIFont systemFontOfSize:9];
    pitchLabel.backgroundColor = [UIColor clearColor];
    
    //已投
    UILabel * castLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 20, 10)];
    castLabel.text = @"";
    castLabel.textAlignment = NSTextAlignmentCenter;
    castLabel.font = [UIFont systemFontOfSize:9];
    castLabel.backgroundColor = [UIColor clearColor];
    
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(pressQingButton:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel * qinglabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
//    qinglabel.text = @"清";
//    qinglabel.font = [UIFont boldSystemFontOfSize:15];
//    qinglabel.textAlignment = NSTextAlignmentCenter;
//    qinglabel.backgroundColor = [UIColor clearColor];
//    qinglabel.textColor = [UIColor colorWithRed:25/255.0 green:114/255.0 blue:176/255.0 alpha:1];
//    
//    
//    [qingbutton addSubview:qinglabel];
//    [qinglabel release];
    
    
    
    //放图片 图片上放label 显示投多少场
    
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 8, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    
    
    
    
    //放图片 图片上放label 显示投多少场
    //    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 12, 25, 10)];
    //    imageView1.image = UIImageGetImageFromName(@"b_03.png");
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 40, 13)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:12];
    oneLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];;
    //   oneLabel.text = @"14";
    
    [zhubg addSubview:oneLabel];
    
    //放图片 图片上放label 显示投多少注
    //    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 27, 25, 10)];
    //    imageView2.image = UIImageGetImageFromName(@"b_03.png");
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 16, 40, 13)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:12];
    twoLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
//    twoLabel.hidden = YES;
    //  twoLabel.text = @"512";
    
    [zhubg addSubview:twoLabel];
    
    //场字
    fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 1, 20, 13)];
    fieldLable.text = @"注";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:12];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [zhubg addSubview:fieldLable];
    //注字
    UILabel * pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 20, 13)];
    pourLable.text = @"元";
//    pourLable.hidden = YES;
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:12];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
    [zhubg addSubview:pourLable];
    
    //投注按钮背景
    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,63, 30)];
    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");
    
    
    //    UILabel * buttonLabel2 = [[UILabel alloc] initWithFrame:backButton2.bounds];
    //    buttonLabel2.text = @"玩 法";
    //    buttonLabel2.textAlignment = NSTextAlignmentCenter;
    //    buttonLabel2.backgroundColor = [UIColor clearColor];
    
    
    //投注按钮
    castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
//    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
//    chuanimage1.backgroundColor = [UIColor clearColor];
//    chuanimage1.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [castButton addSubview:chuanimage1];
//    [chuanimage1 release];
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
//    [castButton setImage:UIImageGetImageFromName(@"gc_jcxuan.png") forState:UIControlStateNormal];
    //[castButton setImage:UIImageGetImageFromName(@"gc_footerBtn.png") forState:UIControlStateHighlighted];
    //玩法按钮
//    UIButton * helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    helpButton.frame = CGRectMake(282, 11, 26, 29);
//    [helpButton addTarget:self action:@selector(pressHelpButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // [castButton addSubview:backButton];
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor =  [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    //  buttonLabel1.textColor = [UIColor whiteColor];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:22];
    
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
//    [helpButton addSubview:backButton2];
    [castButton addSubview:buttonLabel1];
    // [helpButton addSubview:buttonLabel2];
    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    //  [buttonLabel2 release];
    
    [tabView addSubview:tabBack];
    [tabView addSubview:pitchLabel];
    [tabView addSubview:castLabel];
//    [tabView addSubview:fieldLable];
//    [tabView addSubview:pourLable];
//    [tabView addSubview:imageView1];
//    [tabView addSubview:imageView2];
     [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
//    [tabView addSubview:helpButton];
    [tabView addSubview:qingbutton];
    [self.mainView addSubview:tabView];
    
    
    [pitchLabel release];
    [castLabel release];
    [fieldLable release];
    [pourLable release];
//    [imageView1 release];
//    [imageView2 release];
    [tabBack release];
    
    
#ifdef  isCaiPiaoForIPad
   
    qingbutton.frame = CGRectMake(12+34, 8, 30, 30);
    zhubg.frame = CGRectMake(52+34, 7, 62, 30);
    castButton.frame = CGRectMake(230+34, 6, 80, 33);
    
#endif
    
}
- (void)pressQingButton:(UIButton *)sender{
    
    for (int i = 0; i < [bettingArray count]; i++) {
        GC_BetData * bet = [bettingArray objectAtIndex:i];
        bet.selection1 = NO;
        bet.selection2 = NO;
        bet.selection3 = NO;
        bet.dandan = NO;
        [bettingArray replaceObjectAtIndex:i withObject:bet];
    }
    
    oneLabel.text = @"0";
    twoLabel.text = @"0";
    one = 0;
    two = 0;
    
    
    [zhushuDic removeAllObjects];
    [myTableView reloadData];
}


- (void)pressCastButton:(UIButton *)button{
    
    
    
    if (bettingstype == bettingStypeShisichang) {
        NSLog(@"one = %d", one);
        [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:@"300"]];
        if (one < 14) {
            
            //            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"至少需要对14场比赛进行投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            [alert show];
            //            [alert release];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少需要对14场比赛进行投注"];
            
        }else if([twoLabel.text intValue] > 1500000){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"投注总金额不能超过150万"];
            
        }else
            
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
            [self sysTimeFunc];
            //      int st = [self.betArray count] - 1;
            
            NSString * string = @"";
            for (GC_BetData * data in bettingArray) {
                if (data.selection1) {
                    string = [string stringByAppendingFormat:@"3"];
                }
                if (data.selection2) {
                    string = [string stringByAppendingFormat:@"1"];
                }
                if (data.selection3) {
                    string = [string stringByAppendingFormat:@"0"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            string = [string substringToIndex:[string length] - 1];
            NSLog(@"string = %@", string);
            
            //      int bets = [GC_LotteryUtil getBets:string LotteryType:betInfo.lotteryType ModeType:fushi];
            //  DD_LOG(@"注数：%i", bets);
            betInfo.modeType = (two > 1) ? fushi:danshi;
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            betInfo.bets = two;
            betInfo.price = two * 2;
            NSLog(@"jine = %i", betInfo.price);
            
            if (betInfo.modeType == fushi) {
                string = [NSString stringWithFormat:@"02#%@", string];
            }else if(betInfo.modeType == danshi){
                string = [NSString stringWithFormat:@"01#%@", string];
            }
            betInfo.zhuihaoType = 0;
            betInfo.betNumber = string;
            
            NSLog(@"%i", two);
            //            NSString * issstr = [issString substringWithRange:NSMakeRange(2, 5)];//ccc
            //            betInfo.issue = issstr;//ccc
            NSLog(@"%@", issString);
            betInfo.issue = issString;//ccc
            betInfo.lotteryType = TYPE_CAIZHONG14;
            betInfo.caizhong = @"300";
            betInfo.wanfa = @"01";
            
            betInfo.stopMoney = @"0";
            // if (betInfo.bets > 0) {
            //     if (betInfo.price <= 20000) {
            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
            sheng.title = [NSString stringWithFormat:@"胜负彩%@期", issString];
            sheng.bettingArray = bettingArray;
            sheng.saveKey = [self objectKeyString];
            sheng.issString = issString;
            sheng.chaodanbool = chaodanbool;
            sheng.moneynum = twoLabel.text;
            sheng.zhushu = oneLabel.text;
            sheng.fenzhong = shisichangpiao;
            sheng.isHeMai = self.isHemai;
            if (isHemai) {
                sheng.hemaibool = YES;
            }else{
                sheng.hemaibool = NO;
            }
            [self.navigationController pushViewController:sheng animated:YES];
            [sheng release];
            //    }
            
            //   }
        }
        
    }else if(bettingstype == bettingStypeRenjiu){
        [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:@"301"]];
        
        if (one < 9 ) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"至少需要对9场比赛进行投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
            
        }
//        else if(one > 9){
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"任选九最多能选择9场比赛" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            [alert release];
//        }
        else if([twoLabel.text intValue] > 1500000){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"投注总金额不能超过150万"];
            
        }else
            
        {
            //      int st = [self.betArray count] - 1;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
            [self sysTimeFunc];
            
            NSString * string = @"";
            for (GC_BetData * data in bettingArray) {
                if (data.selection1 || data.selection2 || data.selection3) {
                    if (data.selection1) {
                        string = [string stringByAppendingFormat:@"3"];
                    }
                    if (data.selection2) {
                        string = [string stringByAppendingFormat:@"1"];
                    }
                    if (data.selection3) {
                        string = [string stringByAppendingFormat:@"0"];
                    }
                    
                }else{
                    string = [string stringByAppendingFormat:@"4"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            
                        
            string = [string substringToIndex:[string length] - 1];
            
            if (one > 9) {
                if (shedan) {
                    string = [string stringByAppendingFormat:@"@"];
                    for (int i = 0; i < [bettingArray count]; i++) {
                        GC_BetData * data = [bettingArray objectAtIndex:i];
                        
                        if (data.dandan) {
                            string = [string stringByAppendingFormat:@"%d*", i+1];
                        }
                    }
                    string = [string substringToIndex:[string length] - 1];

                }
            }

            
            NSLog(@"string = %@", string);
            
            //      int bets = [GC_LotteryUtil getBets:string LotteryType:betInfo.lotteryType ModeType:fushi];
            //  DD_LOG(@"注数：%i", bets);
           
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            if (one > 9) {
                betInfo.bets = [oneLabel.text intValue];
                betInfo.price = [twoLabel.text intValue];
//                int danfushi = 1;
//                for (int i = 0; i < [bettingArray count]; i++) {
//                    GC_BetData * betda = [bettingArray objectAtIndex:i];
//                    if(betda.selection1 || betda.selection2 || betda.selection3){
//                        danfushi = danfushi * (betda.selection1 + betda.selection2 + betda.selection3);
//                    }
//                   
//                }
//                if (danfushi > 1) {
//                    betInfo.modeType = fushi;
//                }else{
//                    betInfo.modeType = danfushi;
//                }
//                betInfo.modeType = 3;
                
                
            }else{
                betInfo.bets = two;
                betInfo.price = two * 2;
                betInfo.modeType = (two > 1) ? fushi:danshi;
            }
            
            NSLog(@"jine = %i", betInfo.price);
            betInfo.zhuihaoType = 0;
//            if (betInfo.modeType == fushi) {
//                string = [NSString stringWithFormat:@"02#%@", string];
//            }else if(betInfo.modeType == danshi){
//                string = [NSString stringWithFormat:@"01#%@", string];
//            }else{
//                string = [NSString stringWithFormat:@"03#%@", string];
//            }
            if (shedan) {
                string = [NSString stringWithFormat:@"03#%@", string];
            }else{
                
                if (one == 9) {
                    if (betInfo.bets == 1) {
                        string = [NSString stringWithFormat:@"01#%@", string];
                    }else if(betInfo.bets > 1){
                        string = [NSString stringWithFormat:@"02#%@", string];
                    }

                }else{
                    string = [NSString stringWithFormat:@"03#%@", string];
                
                }
                
            }
            
            
         
            betInfo.betNumber = string;
            
            NSLog(@"%i", two);
            
            //            NSString * issstr = [issString substringWithRange:NSMakeRange(2, 5)];//cccc
            //            NSLog(@"issstr = %@", issstr);
            //            betInfo.issue = issstr;
            betInfo.issue = issString;//ccccc
            betInfo.lotteryType = TYPE_CAIZHONG9;
            betInfo.caizhong = @"301";
            betInfo.wanfa = @"02";
           
            betInfo.stopMoney = @"0";
            // if (betInfo.bets > 0) {
            //     if (betInfo.price <= 20000) {
            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
            sheng.title = [NSString stringWithFormat:@"任选九%@期", issString];
            sheng.fenzhong = renjiupiao;
            sheng.saveKey = [self objectKeyString];
            sheng.issString = issString;
            sheng.chaodanbool = chaodanbool;
            sheng.bettingArray = bettingArray;
            sheng.moneynum = twoLabel.text;
            sheng.zhushu = oneLabel.text;
            sheng.isHeMai = self.isHemai;
            [self.navigationController pushViewController:sheng animated:YES];
            [sheng release];
        }
    }
}

//    int bets = [GC_LotteryUtil getBets:selectNumber LotteryType:betInfo.lotteryType ModeType:fushi];
//  //  DD_LOG(@"注数：%i", bets);
//    betInfo.modeType = (bets > 1) ? fushi:danshi;
//  //  DD_LOG(@"玩法：%i", betInfo.modeType);
//    betInfo.bets = bets;
//    betInfo.price = bets * 2;
//    betInfo.betNumber = selectNumber;
//    betInfo.issue = issueComboBox.text;
//    if (betInfo.bets > 0) {
//        if (betInfo.price <= 20000) {
//            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
//            sheng.bettingArray = bettingArray;
//            sheng.moneynum = twoLabel.text;
//            sheng.zhushu = oneLabel.text;
//            [self.navigationController pushViewController:sheng animated:YES];
//            [sheng release];
//
//
//        } else {
//           // [[MessageCenter defaultCenter] postAlertWithMessage:@"单票金额不能超过20000元！"];
//        }
//    } else {
//        if (betInfo.lotteryType == TYPE_ZC_RENXUAN9) {
//       //     [[MessageCenter defaultCenter] postAlertWithMessage:@"请对任意9场赛事进行选号投注！"];
//      //      DD_LOG(@"type = %d", betInfo.lotteryType);
//        } else {
//        //    [[MessageCenter defaultCenter] postAlertWithMessage:@"请对所有的赛事进行选号投注！"];
//        //    DD_LOG(@"type = %d", betInfo.lotteryType);
//        }
//    }
//




//- (void)pkDidFinishSelector:(ASIHTTPRequest *)mrequest{
//    NSString * str = [mrequest responseString];
//    NSDictionary * dict = [str JSONValue];
//    NSLog(@"dict = %@", dict);
//
//    NSString * strstr = [dict objectForKey:@"msg"];
//
//    NSString * string = [NSString stringWithFormat:@"%d",[dict objectForKey:@"code"] ];
//
//    if ([string isEqualToString:@"0"]) {
//        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert1 show];
//        alert1.tag = 101;
//        [alert1 release];
//    }
//    else {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//        [alert release];
//    }
//
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my" object:self];
    }
}

- (void)pressHelpButton:(UIButton *)button{    
    
    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];
  
    if (bettingstype == renjiupiao) {
        exp.ALLWANFA = RenXuanJiu;
//        exp.infoText.text = @"“胜负任选9场”是以中国足球彩票胜负玩法所选择的足球比赛场次为竞猜对象，购买“胜负任选9场”时，由购买者从中国足球彩票胜负玩法选择的所有竞猜场次中的任意9场竞猜场次中每场比赛在全场90分钟（含伤情补时）比赛的胜平负的结果进行投注，对于所选竞猜场次的比赛成绩均只选择1种预测结果为单式投注，对于某一竞猜场次的比赛成绩选择2种（含）以上的预测结果为复式投注。购买者可对其选定的结果进行多倍投注，投注倍数范围为2-99倍。";
    }else{
        exp.ALLWANFA = ShenFuCai;
//        exp.infoText.text = @"       选定1场比赛,对主队在全场90分钟(含伤停补时)的“胜”、“平”、“负”结果进行投注。竞彩胜平负时用3、1、0分别代表主队胜、主客战平和主队负。\n       当两只球队实力悬殊较大时,采取让球的方式确定双方胜平负关系.让球的数量确定后将维持不变。";
    }
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];

    
    
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return NO;
 }
 */


#pragma mark -
#pragma mark Table view data source
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 0;
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([bettingArray count] > 14) {
        return 14;
    }
    return [bettingArray count];
    //  return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (zhankai[indexPath.row] == 1) {
//        return 55+56;
//    }
	return 101 ;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //    if (indexPath.row == 0) {
//    //        return 90;
//    //    }
//    return 66;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    GC_BetCell *cell = (GC_BetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GC_BetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO] autorelease];
        
//        if (bettingstype == bettingStypeShisichang) {
//             [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
//            cell.butTitle.text = @"析";
//        }else if (bettingstype == bettingStypeRenjiu){
//         [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil]];
//            cell.butTitle.text = @"析  胆";
//        }
        
        
        cell.cp_canopencelldelegate = self;
#ifdef isCaiPiaoForIPad
        cell.xzhi  = 9.5+35;
#else
        cell.xzhi = 9.5;
#endif
        
        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        cell.normalHight = 50;
        cell.selectHight = 50+56;
        cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
    }
    
    if (castButton.enabled == NO) {
        cell.wangqibool = YES;
        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
        cell.butTitle.text = @"析";
    }else{
        if (bettingstype == bettingStypeShisichang) {
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
            cell.butTitle.text = @"析";
        }else if (bettingstype == bettingStypeRenjiu){
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil]];
            cell.butTitle.text = @"析  胆";
        }

        cell.wangqibool = NO;
    }
    cell.backgroundColor = [UIColor clearColor];
     UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];
//    if (one <= 9) {
//       
//        cellbutton.hidden = YES;
//    }else{
//        cellbutton.hidden = NO;
//    }
    if (castButton.enabled == NO) {
        cell.wangqibool = YES;
        cellbutton.hidden = YES;
    }else{
        cell.wangqibool = NO;
    }
//    if (zhankai[indexPath.row] == 1) {
//        [cell showButonScollWithAnime:NO];
//    }
//    if (zhankai[indexPath.row] == 0) {
//        [cell hidenButonScollWithAnime:NO];
//    }
    // Configure the cell...
    cell.row = indexPath.row;
    //    cell.pkbetdata = [dataArray objectAtIndex:indexPath.row];
    cell.count = indexPath.row;
    cell.delegate = self;
    GC_BetData * pkbet = [bettingArray objectAtIndex:indexPath.row];
    pkbet.donghuarow = indexPath.row;
    cell.pkbetdata = pkbet;
    if(bettingstype == bettingStypeRenjiu){
        cell.renjiubool = YES;
        
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:issString]) {
                xcont = i;
                break;
            }
        }
         IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        NSTimeInterval interval = [[NSDate dateFromString:self.sysTime] timeIntervalSinceDate:[NSDate dateFromString:isdetail.danTuoTime]];
        NSLog(@"interval = %f  a = %@ , b = %@", interval, self.sysTime, isdetail.danTuoTime);
        if (interval > 0) {
            if (one >= 9) {
                cell.danTuoBool = YES;
            }else{
                cell.danTuoBool = NO;
            }
        }
        
    }else{
        cell.renjiubool = NO;
    }
    
    
    //self.matchList
    
    return cell;
}

- (void)neutralityMatchViewDelegate:(NeutralityMatchView *)view withBetData:(GC_BetData *)be{

    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
    //        sachet.playID = @"234028"; //传入这两个对比赛的id
    
    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
    [self.navigationController pushViewController:sachet animated:YES];
#endif
    [sachet release];
}


- (void)returncellrownum:(NSInteger)num{
    
    
    
    
     GC_BetData * be = [bettingArray objectAtIndex:num];
//    if (castButton.enabled == YES) {
//        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
//            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:[NSString stringWithFormat:@"%d", num+1]] ;
//            
//            neutrality.delegate = self;
//            [neutrality show];
//            [neutrality release];
//            return;
//        }
//    }
    
   
    
    [self NewAroundViewShowFunc:be indexPath:[NSIndexPath indexPathForRow:num inSection:0]];
    
//    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
//    //        sachet.playID = @"234028"; //传入这两个对比赛的id
//   
//    sachet.playID = be.saishiid;
//#ifdef isCaiPiaoForIPad
//    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
//#else
//    [self.navigationController pushViewController:sachet animated:YES];
//#endif
//    [sachet release];
}

//串的九宫格
- (void)pressChuanJiuGongGe{
   
    
    [shedanArr removeAllObjects];
    [m_shedanArr removeAllObjects];
    shedan  = NO;
        for (int i = 0; i < [bettingArray count]; i++) {
            
            
            
            GC_BetData * pkb = [bettingArray objectAtIndex:i];
            
            if (pkb.selection1 || pkb.selection2 || pkb.selection3) {
                if (pkb.dandan) {
                    [shedanArr addObject:[NSNumber numberWithInt:1]];
                    shedan = YES;
                }else{
                    [shedanArr addObject:[NSNumber numberWithInt:0]];
                }
            }

            
            
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {

                int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
            }

        }
    
    NSInteger currtCount;
    NSInteger selecount;
    NSNumber * currtnum;
    NSNumber * countnum;
    //  NSNumber * countnum2;
    //  NSNumber * countnum3;
    NSInteger selecout2;
    NSInteger selecout3;
    NSMutableDictionary * diction = [NSMutableDictionary dictionaryWithCapacity:0];
    selecount = 0;
   selecout2 = 0;
    selecout3 = 0;
        for (GC_BetData * pkb in bettingArray) {
            if ((pkb.selection1 && pkb.selection2 == NO && pkb.selection3 == NO)|| (pkb.selection2 && pkb.selection1 == NO && pkb.selection3 == NO) ||(pkb.selection3 && pkb.selection1 == NO && pkb.selection2 == NO)) {
                
                selecount++;
            }
            if ((pkb.selection1 && pkb.selection2 && pkb.selection3 == NO)||(pkb.selection1 && pkb.selection2== NO && pkb.selection3 )||(pkb.selection1== NO && pkb.selection2 && pkb.selection3 )) {
                selecout2++;
            }
            if (pkb.selection1 && pkb.selection2 && pkb.selection3) {
                selecout3++;
            }

        }
        if (selecount != 0) {
            currtCount = 1;
            currtnum = [NSNumber numberWithInteger:selecount];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        
        
        
//        for (GC_BetData * pkb in bettingArray) {
//            if ((pkb.selection1 && pkb.selection2 && pkb.selection3 == NO)||(pkb.selection1 && pkb.selection2== NO && pkb.selection3 )||(pkb.selection1== NO && pkb.selection2 && pkb.selection3 )) {
//                selecout2++;
//            }
//        }
    
        if (selecout2 != 0) {
            currtCount = 2;
            currtnum = [NSNumber numberWithInteger:selecout2];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        
//        for (GC_BetData * pkb in bettingArray) {
//            if (pkb.selection1 && pkb.selection2 && pkb.selection3) {
//                selecout3++;
//            }
//        }
    
        if (selecout3 != 0) {
            currtCount = 3;
            currtnum = [NSNumber numberWithInteger:selecout3];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        

    
    if (shedan) {// 设胆 情况
        
            [shedanArr removeAllObjects];
           

                
                for (int i = 0; i < [bettingArray count]; i++) {
                    GC_BetData * pkb = [bettingArray objectAtIndex:i];
                    
                    
                    if (pkb.selection1 || pkb.selection2 || pkb.selection3) {
                        if (pkb.dandan) {
                            [shedanArr addObject:[NSNumber numberWithInt:1]];
                        }else{
                            [shedanArr addObject:[NSNumber numberWithInt:0]];
                        }
                    }

                    
                    if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                        
                        int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                       
                        [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                    }

                }
                
                
            

        
        GC_NewAlgorithm *newAlgorithm = [[GC_NewAlgorithm alloc] init];
        [newAlgorithm countAlgorithmWithArray:m_shedanArr chuanGuan:@"9串1" changCi:[m_shedanArr count] sheDan:(NSArray *)shedanArr];
        
        long long total = newAlgorithm.reTotalNumber;
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];

        
        [zhushuDic  removeAllObjects];
        [zhushuDic setObject:longNum forKey:@"9串1"];

        [longNum release];
        [newAlgorithm release];
       
        
    }else{// 未设胆情况
        
        GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
        
        [jcalgorithm passData:diction gameCount:[bettingArray count] chuan:@"9串1"];
        long long  total =[jcalgorithm  totalZhuShuNum];
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
        [zhushuDic setObject:longNum forKey:@"9串1"];
        [longNum release];
        
    }
    
    NSArray * ar = [zhushuDic allKeys];
    
       
    NSInteger n=0;
    for (int i = 0; i < [ar count]; i++) {
        NSLog(@"ar = %@",[ar objectAtIndex:i]);
        if ([ar objectAtIndex:i] != nil || [[ar objectAtIndex:i] isEqualToString:@""]) {
            NSNumber * numq = [zhushuDic objectForKey:[ar objectAtIndex:i]];
            
            n = n + [numq intValue];
        }
        
        
    }
    oneLabel.text = [NSString stringWithFormat:@"%d", (int)n];
    twoLabel.text = [NSString stringWithFormat:@"%d", (int)n * 2];
    // labelch.text = vi.text;
    
       
}

- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    //    NSLog(@"666666666666666");
    //    NSLog(@"index6666 = %d", index);
    GC_BetData  * da = [bettingArray objectAtIndex:index];
    da.count = index;
    da.selection1 = selection1;
    da.selection2 = selection2;
    da.selection3 = selection3;
    da.dandan = booldan;
//    if (selection1 == NO || selection2 == NO || selection3 == NO) {
//         da.dandan = NO;
//    }
    if (selection1 == NO && selection2 == NO && selection3 == NO) {
        da.dandan = NO;
    }

    [bettingArray replaceObjectAtIndex:index withObject:da];
    
    two = 1;
    one = 0;
    [m_shedanArr removeAllObjects];
    
    [self upDateFunc];
    
   
    
   
    [myTableView reloadData];
    
    
}

- (void)deleteContentOff:(NSString *)equal{
    
    NSArray * keys = [ContentOffDict allKeys];
    if (keys > 0) {
        for (NSString * keyStr in keys) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            if ([strarr count] < 2) {
                return;
            }
            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
            
            if (![keyStr isEqualToString:equal]) {
                [UIView beginAnimations:@"ndd" context:NULL];
                [UIView setAnimationDuration:.3];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
                cell2.butonScrollView.contentOffset = CGPointMake(0, cell2.butonScrollView.contentOffset.y);
                [UIView commitAnimations];
                
                
//                GC_JCBetCell * jccell = (GC_JCBetCell *)cell2;
//                if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
//                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
//                }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
//                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
//                    
//                }
                //                if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang) {
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
                //                }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                //
                //                }else if (matchType == MatchRangQiuShengPingFu){
                //
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage.png");
                //                }else if (matchType == MatchShengFuGuoGan) {
                //
                //                }
            }
            
            
            
        }
        [ContentOffDict removeAllObjects];
    }
    
}
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn{
    
    //    [ContentOffArray addObject:index];
    GC_BetCell *cell2 = (GC_BetCell *)[myTableView cellForRowAtIndexPath:index];
    NSString * str = @"";
    if (cell2.wangqibool) {
        str = [NSString stringWithFormat:@"%d %d", (int)index.section, (int)index.row];
    }else{
        str = [NSString stringWithFormat:@"%d %d", (int)index.section, (int)index.row];
    }
    
    if (yn == NO) {
        [self deleteContentOff:str];
        [ContentOffDict setObject:@"1" forKey:str];
        
    }else{
        [ContentOffDict removeObjectForKey:str];
    }
    
    
    
}

- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
    
    if (bettingstype == bettingStypeRenjiu) {
//        if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//            xcount = 35+ ([cell.allTitleArray count]-1)*70;
//        }else {
            xcount =[cell.allTitleArray count]*70;
            
//        }
    }else{
        xcount =[cell.allTitleArray count]*70;
    }
    
    
    NSLog(@"!11111111111111111");
    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
    [UIView commitAnimations];
    
//    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//    if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan ) {
//        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
//    }
    //    if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    //    }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"dakaixidanimage.png");
    //
    //    }else if (matchType == MatchRangQiuShengPingFu){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
    //    }else if (matchType == MatchShengFuGuoGan){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage_1.png");
    //    }
}


- (void)openCell:(CP_CanOpenCell *)cell{
    
    NSLog(@"6666666666666666");
    if (cell.butonScrollView.contentOffset.x > 0) {
        //        buttonBool = YES;
        NSLog(@"%f,%f",cell.butonScrollView.contentSize.width,cell.butonScrollView.contentSize.height);
        
        //            if ([cell.allTitleArray count] > 2) {
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        NSLog(@"!@222222222222222222222");
        cell.butonScrollView.contentOffset = CGPointMake( 0, cell.butonScrollView.contentOffset.y);
        [UIView commitAnimations];
        
//        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//        
//        if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
//            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
//        }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
//            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
//            
//        }
        
        
        //        if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        //        }else if (matchType == MatchShangXiaDanShuang|| matchType == MatchBiFen ){
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
        //
        //        }else if (matchType == MatchRangQiuShengPingFu){
        //
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        //        }else if (matchType == MatchShengFuGuoGan){
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage.png");
        //
        //        }
        
    }else{
        [self performSelector:@selector(sleepOpenCell:) withObject:cell afterDelay:0.1];
    }
    return;
    
}


- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell{
    NSLog(@"danbool = %d", danbool);
    
    
    
      GC_BetCell * jccell = (GC_BetCell *)openCell;
    GC_BetData * gcbe = [bettingArray objectAtIndex:jccell.row];
    if (gcbe.selection1 == NO && gcbe.selection2 == NO && gcbe.selection3 == NO) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请在当前对阵中选择您看好的结果"];
        danbool = NO;
    }
    gcbe.dandan = danbool;
    [bettingArray replaceObjectAtIndex:jccell.row withObject:gcbe];
    //
    NSInteger coutt = 0;
    for (int j = 0; j < [bettingArray count]; j++) {
        GC_BetData * be = [bettingArray objectAtIndex:j];
        if (be.dandan) {
            
            coutt++;
        }
        
    }
    
    
   
    
    if (coutt >= 9) {
        panduanbool = NO;
    }else if(coutt < 9){
        panduanbool = YES;
    }
    
    if ( panduanbool == NO){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"最多可以设8个胆"];
    }
    panduanzhongjie = panduanbool;
    
    if (coutt <= (one-2) || (coutt == 0 && one - 2 == 0)) {
        //        for (int i = 0; i < [duixiangarr count]; i++) {
        //            GC_BetData * bet = [duixiangarr objectAtIndex:i];
        //            bet.nengyong = YES;
        //
        //            [duixiangarr replaceObjectAtIndex:i withObject:bet];
        
        for (int j = 0; j < [bettingArray count]; j++) {
            GC_BetData * be = [bettingArray objectAtIndex:j];
            be.nengyong = YES;
            [bettingArray replaceObjectAtIndex:j withObject:be];
        }
        
        GC_BetCell * cbe = [bettingArray objectAtIndex:jccell.row];
        if (danbool && cbe.nengyong) {
            
            UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//            danbutton.backgroundColor = [UIColor redColor];
//            [danbutton setImage:UIImageGetImageFromName(@"danzucai_1.png") forState:UIControlStateNormal];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
            
        }else{
            UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//            danbutton.backgroundColor = [UIColor blackColor];
//            [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            
        }
        
        
    }else{
        //        for (int i = 0; i < [duixiangarr count]; i++) {
        //            GC_BetData * bet = [duixiangarr objectAtIndex:i];
        //            bet.nengyong = NO;
        //
        //            [duixiangarr replaceObjectAtIndex:i withObject:bet];
        //        }
        if (danbool) {
            coutt+=1;
            if (coutt > one-2 && one > 2) {
                if (one == 10 && coutt == 10) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"最多可以设8个胆"];
                }else{
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"当前只能设置(选择场次数-2)个胆"];
                }
               
            }
            
//            coutt-=1;
        }
        for (int j = 0; j < [bettingArray count]; j++) {
            GC_BetData * be = [bettingArray objectAtIndex:j];
            be.nengyong = NO;
            [bettingArray replaceObjectAtIndex:j withObject:be];
        }
        UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//        danbutton.backgroundColor = [UIColor blackColor];
//        [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        GC_BetData * gcbe = [bettingArray objectAtIndex:jccell.row];
        gcbe.dandan = NO;
        [bettingArray replaceObjectAtIndex:jccell.row withObject:gcbe];
        
        
    }
    if (panduanbool == NO) {
    
        for (int j = 0; j < [bettingArray count]; j++) {
            GC_BetData * be = [bettingArray objectAtIndex:j];
            be.nengyong = NO;
            [bettingArray replaceObjectAtIndex:j withObject:be];
        }
        UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//        danbutton.backgroundColor = [UIColor blackColor];
//        [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        GC_BetData * gcbe = [bettingArray objectAtIndex:jccell.row];
        gcbe.dandan = NO;
        [bettingArray replaceObjectAtIndex:jccell.row withObject:gcbe];
    }
    [self pressChuanJiuGongGe];
    
    [myTableView reloadData];
    [self stopTimeUpData];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate
- (void)yanchiHiden:(NSIndexPath *)index {
    oldshowButnIndex = 0;
    UITableViewCell *cell= [myTableView cellForRowAtIndexPath:index];
    if (cell) {
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
        CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
        
        [cell2 hidenButonScollWithAnime:YES];
    }
}

//- (void)openCell:(CP_CanOpenCell *)cell{
//    
//    NSIndexPath *indexPath = nil;
//    GC_BetCell * jccell = (GC_BetCell *)cell;
//   
//        indexPath = [NSIndexPath indexPathForRow:jccell.row inSection:0];
//    
//    
//    cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//    if (cell.butonScrollView.hidden == NO) {
//        
//        zhankai[indexPath.row] = 0;
//        [cell showButonScollWithAnime:NO];
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell showButonScollWithAnime:NO];
//        [cell hidenButonScollWithAnime:YES];
//    }
//    else {
//        
//        zhankai[indexPath.row] = 1;
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell hidenButonScollWithAnime:NO];
//        [cell showButonScollWithAnime:YES];
//    }
//    return;
//    
//    
//}

#pragma mark - CP_CanOpenCellDelegate

- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index {
    
    
    
   
    GC_BetCell * jccell = (GC_BetCell *)cell;
    if (cell.butonScrollView.contentOffset.x > 0) {
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        NSLog(@"!666666666666666666666666666666");
        cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
        [UIView commitAnimations];
        GC_BetCell * jccell = (GC_BetCell *)cell;
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        
        
    }
    if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"八方预测"]) {
        
        
        if (bettingstype == bettingStypeRenjiu) {
            [MobClick event:@"event_goucai_xidan_bangfangyuce" label:@"任选9"];
        }else{
            [MobClick event:@"event_goucai_xidan_bangfangyuce" label:@"胜负彩"];
        }
        
        GC_BetData * be = [bettingArray objectAtIndex:jccell.row];
        [self NewAroundViewShowFunc:be indexPath:[NSIndexPath indexPathForRow:jccell.row inSection:0]];
        
        
        
    }
    else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"胆"]) {
        
        
        if (one > 9) {
            
            GC_BetData * be = [bettingArray objectAtIndex:jccell.row];
            if (be.dandan == YES) {
                be.dandan = NO;
//                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:Index];
//                //            danbutton.backgroundColor = [UIColor blackColor];
//                //            [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
//                UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//                btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            }else{
                
                be.dandan = YES;
                
                
            }
            
            [self returnBoolDan:be.dandan row:Index selctCell:cell];
        }else{
        
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"需要选择10场以上比赛，才可以进行设胆操作。"];
 
        
        }
        
        
        
    }
    
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [ContentOffDict release];
    //[selectedItemsDic release];
    [issueTypeArray release];
    [kongzhiType release];
    [zhushuDic release];
    [m_shedanArr release];
    [shedanArr release];
    [staArray release];
    [titleLabel release];
    [bettingArray release];
    [issueArray release];
    [imgev release];
    [bgview release];
    [httpRequest clearDelegatesAndCancel]; [httpRequest release];
    [tabView release];
    [dataArray release];
    [betArray release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    
    [oneLabel release];
    [twoLabel release];
    [myTableView release];
    //[pkArray release];
    // [betdata release];
    [sanjiaoImageView release];
    [super dealloc];
}
-(void)footballForecastBetData:(GC_BetData *)_betData withType:(NSInteger)type indexPath:(NSIndexPath *)fIndexPatch{
    
//    if (type == 1) {
        [self returnCellInfo:fIndexPatch.row buttonBoll1:_betData.selection1 buttonBoll:_betData.selection2 buttonBoll:_betData.selection3 dan:_betData.dandan];
//    }else if(type == 2){
//        [self returnbifenCellInfo:fIndexPatch shuzu:_betData.bufshuarr dan:_betData.dandan];
//        
//        
//    }
    
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
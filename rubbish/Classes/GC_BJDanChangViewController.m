
//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GC_BJDanChangViewController.h"
#import "GC_ExplainViewController.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "GC_UserInfo.h"
#import "GC_JiangCaiIssue.h"
#import "GC_JiangCaiMatch.h"
#import "GC_JingCaiDuizhenChaXun.h"
#import "GC_FootballMatch.h"

#import "GC_JingCaiDuizhenResult.h"
#import "GC_JCBetCell.h"
#import "NewAroundViewController.h"
#import "GC_PassTypeUtils.h"
#import "GC_JCalgorithm.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_NewAlgorithm.h"
#import "YuJiJinE.h"
#import "GC_BJDanChangChuanFa.h"
#import "Xieyi365ViewController.h"
#import "GC_IssueList.h"
#import "NSStringExtra.h"
#import "CP_KindsOfChoose.h"
#import "NSDate-Helper.h"
#import "ChongZhiData.h"
#import "GCHeMaiInfoViewController.h"
#import "LanQiuAroundViewController.h"
#import "MobClick.h"

//投注界面
@implementation GC_BJDanChangViewController
//@synthesize request;
@synthesize matchType;
@synthesize betArray;
@synthesize retArray, kongArray;
@synthesize dataArray;
//@synthesize issString;
@synthesize lotteryID;
@synthesize httprequest;
@synthesize resultList;
@synthesize selectedItemsDic;
@synthesize danDic;
@synthesize yujirequest;
@synthesize isHeMai, chaodanbool, sysTimeSave, httpRequest, kindChoose;
@synthesize betrecorinfo, httprequest150, qtissueString, sfissueString, wfNameString;

//@synthesize totalZhuShuWithDanDic;
#pragma mark -
#pragma mark Initialization


#pragma mark 保存数据和读取数据
/////////////  保存数据和读取数据

-(void)setIssString:(NSString *)_issString{
    
    if (issString != _issString) {
        [issString release];
        issString = [_issString retain];
    }
    self.qtissueString = issString;
    self.sfissueString = issString;
    if (matchType == MatchShengFuGuoGan) {
        
        bdwfBool = YES;
    }else{
       
        bdwfBool = NO;
    }
}

- (NSString *)issString{
    return issString;
}

- (void)clearSaveFunc{
    
    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
    [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:[self objectKeyString]];
    [saveArray release];
}

- (NSString *)objectKeyString{//生成钥匙
    NSString * keystring = @"";
    if (matchType == MatchRangQiuShengPingFu) {
        keystring = [NSString stringWithFormat:@"400%@", issString];
    }else if (matchType == MatchJinQiuShu){
        keystring = [NSString stringWithFormat:@"4001%@", issString];
    }else if (matchType == MatchShangXiaDanShuang){
        keystring = [NSString stringWithFormat:@"4002%@", issString];
    }else if (matchType == MatchBiFen){
        keystring = [NSString stringWithFormat:@"4003%@", issString];
    }else if (matchType == matchBanQuanChang){
        keystring = [NSString stringWithFormat:@"4004%@", issString];
    }else if (matchType == MatchShengFuGuoGan){
        keystring = [NSString stringWithFormat:@"4006%@", issString];
    }
    
    
    
    
    
    return keystring;
}

- (void)sendButtonFunc:(NSMutableArray * )returnarry kongArray:(NSMutableArray *)kongt cpChooseView:(CP_KindsOfChoose*)chooseView{
    
    NSArray * naarr = [returnarry objectAtIndex:0];
    NSString * namestr = [naarr objectAtIndex:0];
    [self matchNamePlayKey:namestr];
    
    [kongzhiType removeAllObjects];
    
    
    //    [duoXuanArr removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", matchType] forKey:@"wanfajiyibeidan"];
    
    
    NSArray * isar = [returnarry objectAtIndex:1];
    NSString * issues = [isar objectAtIndex:0];
    NSInteger countiss = 0;
    if (bdwfBool) {
        for (int i = 0; i < [sfIssueArray count]; i++) {
            IssueDetail * detail = [sfIssueArray objectAtIndex:i];
            if ( [detail.issue isEqualToString:issues]) {
                countiss = i;
                break;
            }
        }
    }else{
        for (int i = 0; i < [issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ( [detail.issue isEqualToString:issues]) {
                countiss = i;
                break;
            }
        }
    }
    
    
    IssueDetail * detail = [issueTypeArray objectAtIndex:countiss];
    if (bdwfBool) {
        detail = [sfIssueArray objectAtIndex:countiss];
    }
    //    if (matchType == MatchShengFuGuoGan) {
    //        detail = [sfIssueArray objectAtIndex:0];
    //    }
    self.issString = detail.issue;
    if (![detail.status isEqualToString:@"1"]) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"本期不能购买"];
        [myTableView reloadData];
        castButton.enabled = NO;
        castButton.alpha = 0.5;
        benqiboo = YES;
    }else{
        benqiboo = NO;
    }
    
    
    NSLog(@"iss = %@", issString);
    timebool = NO;
    titleLabel.text = [NSString stringWithFormat:@"%@%@期", namestr,issString];
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 9.5, 17, 17);
    [self pressQingButton];
    [self  requestBeiJingDanChangDuiZhen];//对阵
    if (matchType == MatchShengFuGuoGan) {
        [sfKongzhiType removeAllObjects];
        [sfKongzhiType addObjectsFromArray:kongt];
    }else{
        [kongzhiType removeAllObjects];
        [kongzhiType addObjectsFromArray:kongt];
    }
    
    
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

- (void)saveDataFunc{//保存选择的数据
    
    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger selectionCount = 0;
    for (int i = 0; i < [kebianzidian count]; i++) {
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:i];
        for (int k = 0; k < [mutarr count]; k++) {
            
            GC_BetData * pkbet = [mutarr objectAtIndex:k];
            
            
            if (matchType == MatchRangQiuShengPingFu||matchType == MatchShengFuGuoGan) {
                if (pkbet.selection1 == YES || pkbet.selection2 == YES || pkbet.selection3 == YES) {
                    selectionCount+= 1;
                    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [dataDict setObject:pkbet.changhao forKey:@"changhao"];
                    [dataDict setObject:issString forKey:@"issue"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection1] forKey:@"selection1"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection2] forKey:@"selection2"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.selection3] forKey:@"selection3"];
                    [dataDict setObject:self.sysTimeSave forKey:@"systimesave"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.dandan] forKey:@"dandan"];
                    
                    [saveArray addObject:dataDict];
                    [dataDict release];
                }
                
            }else{
                BOOL zhongjiebool = NO;
                for (int h = 0; h < [pkbet.bufshuarr count]; h++) {
                    NSString * bstr = [pkbet.bufshuarr objectAtIndex:h];
                    
                    if ([bstr isEqualToString:@"1"]) {
                        zhongjiebool = YES;
                        selectionCount +=1;
                        break;
                    }
                }
                
                if (zhongjiebool) {
                    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [dataDict setObject:pkbet.changhao forKey:@"changhao"];
                    [dataDict setObject:issString forKey:@"issue"];
                    [dataDict setObject:pkbet.bufshuarr forKey:@"bufshuarr"];
                    [dataDict setObject:self.sysTimeSave forKey:@"systimesave"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.dandan] forKey:@"dandan"];
                    [saveArray addObject:dataDict];
                    [dataDict release];
                    
                    
                }
            }
            
            
            
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
        [self sendButtonFunc:self.retArray kongArray:self.kongArray cpChooseView:kindChoose];
    }
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
    
    BOOL danBool = NO;
    int  countSelect = 0;
    
    
    for (int n = 0; n < [readArray count]; n++) {
        
        NSMutableDictionary * readDict = [readArray objectAtIndex:n];
        NSString * issuestr = [readDict objectForKey:@"issue"];
        NSString * macthid = [readDict objectForKey:@"changhao"];
        if ([issString isEqualToString:issuestr]) {
            for (int i = 0; i < [kebianzidian count]; i++) {
                NSMutableArray * mutarr = [kebianzidian objectAtIndex:i];
                for (int k = 0; k < [mutarr count]; k++) {
                    GC_BetData * pkbet = [mutarr objectAtIndex:k];
                    if ([pkbet.changhao isEqualToString:macthid]) {
                        
                        countSelect+=1;
                        
                        if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
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
                                danBool = YES;
                            }else{
                                pkbet.dandan = NO;
                            }
                        }else{
                            pkbet.bufshuarr = [readDict objectForKey:@"bufshuarr"];
                            if ([[readDict objectForKey:@"dandan"] isEqualToString:@"1"]) {
                                pkbet.dandan = YES;
                                danBool = YES;
                            }else{
                                pkbet.dandan = NO;
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
        }
        
        
        
    }
    
    if (countSelect < [readArray count] || countSelect == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"未能全部恢复"];
        
    }
    
    [myTableView  reloadData];
    
    NSInteger countmatch = 0;
    if (matchType == MatchBiFen) {
        countmatch = 3;
    }else{
        countmatch =4;
    }
    
    [m_shedanArr removeAllObjects];
    if ((countSelect > countmatch || countSelect <1)&& danBool == NO){
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", countSelect];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
        if (countSelect <= 1) {
            castButton.enabled = NO;
            chuanButton1.enabled = NO;
            castButton.alpha = 0.5;
            chuanButton1.alpha = 0.5;
        }else{
            castButton.enabled = YES;
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
        }
        one = countSelect;
        
    }else{
        
        UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        senbutton.tag = 1;
        if (danBool || (matchType == MatchShengFuGuoGan && countSelect < 4 && danBool == YES)) {
            
            labelch.text = @"串法";
            oneLabel.text = [NSString stringWithFormat:@"%d", countSelect];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            addchuan = 0;
            if (countSelect == 1|| (matchType == MatchShengFuGuoGan && countSelect < 4)) {
                castButton.enabled = NO;
                chuanButton1.enabled = NO;
                castButton.alpha = 0.5;
                chuanButton1.alpha = 0.5;
            }else{
                castButton.enabled = YES;
                chuanButton1.enabled = YES;
                castButton.alpha = 1;
                chuanButton1.alpha = 1;
            }
            
            one = countSelect;
            
        }else{
            if (matchType == MatchShengFuGuoGan) {
                
                if (countSelect > 2) {
                    senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", countSelect];
                }
            }else{
                if (countSelect == 1) {
                    senbutton.titleLabel.text = @"单关";
                    
                    NSMutableDictionary * readDict = [readArray objectAtIndex:0];
                    
                    NSInteger gc = 0;
                    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
                        if ([[readDict objectForKey:@"selection1"] isEqualToString:@"1"]) {
                            gc+=1;
                        }
                        if ([[readDict objectForKey:@"selection2"] isEqualToString:@"1"]) {
                            gc+=1;
                        }
                        if ([[readDict objectForKey:@"selection3"] isEqualToString:@"1"]) {
                            gc+=1;
                        }
                    }else{
                        NSMutableArray * arr = [readDict objectForKey:@"bufshuarr"];
                        for (int i = 0; i < [arr count]; i++) {
                            if ([[arr objectAtIndex:i] isEqualToString:@"1"]) {
                                gc+=1;
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    // NSString * string = [string stringByAppendingFormat:@"%d", gc];
                    [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                }else{
                    
                    senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", countSelect];
                }
            }
            
            if (matchType == MatchShengFuGuoGan) {
                if (one >= 1) {
                    castButton.enabled = YES;
                    castButton.alpha = 1;
                    
                }
            }
            
            
            [self pressChuanJiuGongGe:senbutton];
            one = countSelect;
            castButton.enabled = YES;
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
            one = countSelect;
            
        }
        
    }
    
    
    
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


//排序函数
- (void)shaixuanzidian:(NSMutableArray *)arrayce{
    if ([arrayce count] == 0) {
        return;
    }
    
    GC_BetData * bet = [arrayce objectAtIndex:0];//取第一个截止时间
    
    NSArray * timeArray = [bet.timeSort componentsSeparatedByString:@"_"];
    NSString * endtime = [timeArray objectAtIndex:0];
    NSLog(@"endtime = %@", endtime);
    NSMutableArray * pxDataArray = nil;
    
    for (int i = 0; i < [arrayce count]; i++) {
        GC_BetData * gcdata = [arrayce objectAtIndex:i];
        NSArray * gctimeArray = [gcdata.timeSort componentsSeparatedByString:@"_"];
        NSString * gcendtime = [gctimeArray objectAtIndex:0];
        if ([gcendtime isEqualToString:endtime]) {
            
            if (!pxDataArray) {//再起一个新数组来存放
                pxDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            }
            [pxDataArray addObject:gcdata];
            
        }else{
            if(pxDataArray){
                [kebianzidian addObject:pxDataArray];
                
            }
            [pxDataArray release];
            pxDataArray = nil;
            
            if (!pxDataArray) {//再起一个新数组来存放
                pxDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            }
            [pxDataArray addObject:gcdata];
            NSArray * xtimeArray = [gcdata.timeSort componentsSeparatedByString:@"_"];
            endtime = [xtimeArray objectAtIndex:0];
            
        }
        
    }
    
    if (pxDataArray) {
        [kebianzidian addObject:pxDataArray];
        [pxDataArray release];
        pxDataArray = nil;
    }
    
    
    
}
//- (void)shaixuanzidian:(NSMutableArray *)arrayce{
//    if ([arrayce count] == 0) {
//        return;
//    }
//    GC_BetData * tistr = [arrayce objectAtIndex:0];
//
//    NSMutableArray * timesarrstr = [[NSMutableArray alloc] initWithCapacity:0];
//    NSString * timebijiao = tistr.bdzhou;//[tistr.numzhou substringToIndex:2];
//
//    [timesarrstr addObject:timebijiao];
//    //                int timecout = 0;
//
//    for (int i = 0; i < [arrayce count]; i++) {
//
//        GC_BetData * betstr = [arrayce objectAtIndex:i];
//        NSString * zhouji = betstr.bdzhou;//[betstr.numzhou substringToIndex:2];
//        BOOL yiybool = NO;
//        for (int j = 0; j < [timesarrstr count]; j++) {
//            NSString * namezou = [timesarrstr objectAtIndex:j];
//            if ([namezou isEqualToString:zhouji]) {
//                yiybool = YES;
//            }
//        }
//        if (![timebijiao isEqualToString:zhouji]) {
//            if (yiybool == NO) {
//                timebijiao = betstr.bdzhou;//[betstr.numzhou substringToIndex:2];
//
//                [timesarrstr addObject:timebijiao];
//
//            }
//
//        }
//
//
//    }
//    //   NSMutableArray * arrtimezou = [[NSMutableArray alloc] initWithCapacity:0];
//
//
//    //    NSMutableArray * timecountarr = [[NSMutableArray alloc] initWithCapacity:0];
//    NSLog(@"time = %d", [timesarrstr count]);
//    for (int i = 0;  i < [timesarrstr count]; i++) {
//        NSLog(@"tinme = %@", [timesarrstr objectAtIndex:i]);
//        NSMutableArray * dicarr = [[NSMutableArray alloc] initWithCapacity:0];
//        NSString * timestin = [timesarrstr  objectAtIndex:i];
//
//        for (int j = 0; j < [arrayce count]; j++) {
//
//            GC_BetData * betstr = [arrayce objectAtIndex:j];
//            NSString * zhouji = betstr.bdzhou;//[betstr.numzhou substringToIndex:2];
//            if ([timestin isEqualToString:zhouji]) {
//                //                            timecout += 1;
//                [dicarr addObject:betstr];
//            }
//
//        }
//        if ([dicarr count] > 0) {
//            NSLog(@"timestin = %@", timestin);
//            //  [kebianzidian setObject:dicarr forKey:timestin];
//            [kebianzidian addObject:dicarr];
//
//
//        }
//        [dicarr release];
//        //                    [timecountarr addObject:[NSString stringWithFormat:@"%d", timecout]];
//
//    }
//    NSLog(@"time arr = %@", timesarrstr);
//
//    [timesarrstr release];
//
//
//}
- (void)NewAroundViewShowFunc:(GC_BetData *)betdata indexPath:(NSIndexPath *)indexPath{//八方预测
    
    
    
    
    
    FootballForecastViewController * forecast = [[FootballForecastViewController alloc] init];
    forecast.lotteryType = beidantype;
    forecast.delegate = self;
    forecast.betData = betdata;
    forecast.gcIndexPath = indexPath;
    if (benqiboo) {
        forecast.matchShowType = fjieqiType;
    }else{
        
        
        if ([betdata.zlcString rangeOfString:@"-"].location != NSNotFound) {
            
            if ([betdata.zlcString rangeOfString:@"True"].location != NSNotFound) {
                forecast.matchShowType = fzhonglichangType;
            }else{
                forecast.matchShowType = fjiaohuanType;
            }
            
        }else{
            if ([betdata.zlcString rangeOfString:@"-"].location != NSNotFound) {
                
                if ([betdata.zlcString rangeOfString:@"True"].location != NSNotFound) {
                    forecast.matchShowType = fzhonglichangType;
                }else{
                    forecast.matchShowType = fjiaohuanType;
                }
                
            }else{
                
                if (matchType == MatchRangQiuShengPingFu) {
                    forecast.matchShowType = fbdRangqiushengpingfuType;
                }else if (matchType == MatchJinQiuShu){
                    forecast.matchShowType = fbdJinqiushuType;
                }else if (matchType == MatchShangXiaDanShuang){
                    forecast.matchShowType = fbdShangxiadanshuangType;
                }else if (matchType == MatchBiFen){
                    forecast.matchShowType = fbdBifenType;
                }else if (matchType == matchBanQuanChang){
                    forecast.matchShowType = fbdBanquanchangType;
                }else if (matchType == MatchShengFuGuoGan ){
                    forecast.matchShowType = fbdShengfuguoguanType;
                }
            }
            
        }
        
        
    }
    
    
    [self.navigationController pushViewController:forecast animated:YES];
    [forecast release];
    
    //    if (matchType == MatchShengFuGuoGan) {
    //        if ([pkbet.zhongzu isEqualToString:@"足球"] || [pkbet.zhongzu isEqualToString:@"篮球"]) {
    
}

- (id)initWithLotteryID:(NSInteger)lotteryId {
    self = [super init];
    if (self) {
        self.lotteryID = lotteryId;
        matchType = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wanfajiyibeidan"] intValue];
        
        if (lotteryId == 10919) {
            self.lotteryID = 1;
            matchType = MatchShengFuGuoGan;
        }
        
    }
    return self;
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestBeiJingDanChangDuiZhen150) object:nil];
}
- (void)pressWorldCupButton1:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx_down.png");
}
- (void)pressWorldCupButton2:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
    
}
- (void)pressWorldCupButton:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
    
    [MobClick event:@"event_goucai_saishicaixuan_caizhong" label:@"北京单场"];
    NSMutableArray *array = [NSMutableArray array];
    
    if (matchType == MatchRangQiuShengPingFu) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
        
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        
        if ([duoXuanArr count] == 0) {
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
            
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            [duoXuanArr addObject:type1];
            
            [duoXuanArr addObject:type3];
        }
        
        [array addObject:dic];
        
        [array addObject:dic3];
    }else if(matchType == MatchShengFuGuoGan){
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"类型选择",@"title",sfMatchArray,@"choose", nil];
        
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        
        if ([duoXuanArr count] == 0) {
            NSMutableArray * countarr1 = [NSMutableArray array];
            for (int i = 0; i < [sfMatchArray count]; i++) {
                [countarr1 addObject:@"0"];
            }
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",countarr1,@"choose", nil];
            
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            [duoXuanArr addObject:type1];
            
            [duoXuanArr addObject:type3];
        }
        
        [array addObject:dic];
        
        [array addObject:dic3];
        
    }else{
        
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        
        if ([duoXuanArr count] == 0) {
            
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            [duoXuanArr addObject:type3];
        }
        
        
        
        [array addObject:dic3];
    }
    
    
    NSLog(@"duo = %@", duoXuanArr);
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
    alert2.allButtonBool = allButtonBool;
    alert2.fiveButtonBool = fiveButtonBool;
    if (matchType == MatchShengFuGuoGan) {
        alert2.bdsfBool = YES;
    }
    alert2.delegate = self;
    alert2.tag = 30;
    alert2.duoXuanBool = YES;
    [alert2 show];
    
    //    for (UIView *view in alert2.backScrollView.subviews) {
    //
    //        if([view isKindOfClass:[UIView class]] && view.tag == 1000){
    //
    //            for(CP_PTButton *btn in view.subviews){
    //
    //                if ([btn isKindOfClass:[UIButton class]] && btn.tag == 0) {
    //                    btn.selected = YES;
    //                    btn.buttonName.textColor = [UIColor whiteColor];
    //                }
    //            }
    //        }
    //
    //    }
    
    
    self.mainView.userInteractionEnabled = NO;
    [alert2 release];
    
    
}


#pragma mark -
#pragma mark View lifecycle
- (void)pressIssueButton{
    //选择期数的ui
    
    NSMutableArray * array = [NSMutableArray array];
    
    NSMutableArray * issuearr = [[NSMutableArray alloc] initWithCapacity:0];
    if (matchType == MatchShengFuGuoGan) {
        for (int i = 0; i < [sfIssueArray   count]; i++) {
            IssueDetail * detail = [sfIssueArray objectAtIndex:i];
            [issuearr addObject:detail.issue];
        }
    }else{
        for (int i = 0; i < [issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            [issuearr addObject:detail.issue];
        }
    }
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"期号",@"title", issuearr,@"choose", nil];
    [issuearr release];
    
    if ([kongzhiType count] == 0) {
        NSMutableArray * issarr = [NSMutableArray array];
        if (matchType == MatchShengFuGuoGan) {
            for (int i = 0; i < [sfIssueArray count]; i++) {
                IssueDetail * detail = [sfIssueArray objectAtIndex:i];
                NSString * str = detail.issue;
                if ([str isEqualToString:issString]) {
                    [issarr addObject:@"1"];
                }else{
                    [issarr addObject:@"0"];
                }
                
            }
        }else{
            for (int i = 0; i < [issueTypeArray count]; i++) {
                IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                NSString * str = detail.issue;
                if ([str isEqualToString:issString]) {
                    [issarr addObject:@"1"];
                }else{
                    [issarr addObject:@"0"];
                }
                
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

- (void)wfNameStringFunc{
    
    if (matchType == MatchRangQiuShengPingFu) {
        self.wfNameString = @"让球胜平负";
    }else if (matchType == MatchJinQiuShu){
        self.wfNameString = @"进球数";
    }else if (matchType == MatchShangXiaDanShuang){
        self.wfNameString = @"上下单双";
    }else if (matchType == MatchBiFen){
        self.wfNameString = @"比分";
    }else if (matchType == matchBanQuanChang){
        self.wfNameString = @"半全场胜平负";
    }else if (matchType == MatchShengFuGuoGan){
        self.wfNameString = @"胜负过关";
    }
}

- (void)loadingIphone{
    addchuan = 0;
    diyici = YES;
    chaocount = 0;
    countchao = 0;
    countjishuqi = 0;
    tagbao = 2;
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    ContentOffDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (chaodanbool){
        for (int i = 0; i < 100; i++) {
            buffer[i] = 1;
        }
    }else{
        buffer[0] = 1;
    }
    
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    chuantype = [[NSMutableArray alloc] initWithCapacity:0];
    danbutDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    selebutarr = [[NSMutableArray alloc] initWithCapacity:0];
    chuanfadic= [[NSMutableDictionary alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *_danDic = [NSMutableDictionary dictionary];
    self.danDic = _danDic;
    allcellarr = [[NSMutableArray alloc] initWithCapacity:0];
    qihaoArray = [[NSMutableArray alloc] initWithCapacity:0];
    saishiArray = [[NSMutableArray alloc] initWithCapacity:0];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    kebianzidian = [[NSMutableArray alloc] initWithCapacity:0];
    betInfo = [[GC_BetInfo alloc] init];
    wanArray = [[NSArray alloc] initWithObjects: @"让球胜平负", @"进球数", @"上下单双", @"比分", @"半全场胜平负", @"胜负过关", nil];
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];
    betInfo.caizhong = @"400";
    betInfo.wanfa = @"01";
    
    betInfo.stopMoney = @"0";
    
    //  self.title = @"pk赛投注";
    //    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    //    staArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
    }else{
        
    }
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // [self requestHttpQingqiu];
    if (chaodanbool == NO) {
        
        [self wfNameStringFunc];
    }
    [self getIssueListRequest];//网络请求
    
    
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height -69+26) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    //
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = @"让球胜平负";
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
    
    [titleView addSubview:titleButton];
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 9.5, 17, 17);
    
    UIButton * worldCupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    worldCupButton.frame = CGRectMake(175, 0, 44, 44);
    worldCupButton.backgroundColor = [UIColor clearColor];
    [worldCupButton addTarget:self action:@selector(pressWorldCupButton:) forControlEvents:UIControlEventTouchUpInside];
    [worldCupButton addTarget:self action:@selector(pressWorldCupButton1:) forControlEvents:UIControlEventTouchDown];
    [worldCupButton addTarget:self action:@selector(pressWorldCupButton2:) forControlEvents:UIControlEventTouchCancel];
    
    
    
    sxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 20,20)];
    sxImageView.backgroundColor = [UIColor clearColor];
    sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
    [worldCupButton addSubview:sxImageView];
    [sxImageView release];
    
    [titleView addSubview:worldCupButton];
    
    self.CP_navigation.titleView = titleView;
    
    [titleView release];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
    if (chaodanbool) {
        [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:UIImageGetImageFromName(@"HC_gouwuche1.png") forState:UIControlStateNormal];
        //        butbg2.image = UIImageGetImageFromName(@"HC_gouwuche.png");
        
    }else{
        //        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
}

- (void)loadingIpad{
    addchuan = 0;
    diyici = YES;
    chaocount = 0;
    countchao = 0;
    countjishuqi = 0;
    tagbao = 2;
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    if (chaodanbool){
        for (int i = 0; i < 100; i++) {
            buffer[i] = 1;
        }
    }else{
        buffer[0] = 1;
    }
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    chuantype = [[NSMutableArray alloc] initWithCapacity:0];
    danbutDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    selebutarr = [[NSMutableArray alloc] initWithCapacity:0];
    chuanfadic= [[NSMutableDictionary alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *_danDic = [NSMutableDictionary dictionary];
    self.danDic = _danDic;
    allcellarr = [[NSMutableArray alloc] initWithCapacity:0];
    qihaoArray = [[NSMutableArray alloc] initWithCapacity:0];
    saishiArray = [[NSMutableArray alloc] initWithCapacity:0];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    kebianzidian = [[NSMutableArray alloc] initWithCapacity:0];
    betInfo = [[GC_BetInfo alloc] init];
    wanArray = [[NSArray alloc] initWithObjects: @"让球胜平负", @"进球数", @"上下单双", @"比分", @"半全场胜平负",@"胜负过关", nil];
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bg.image= UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bg];
    [bg release];
    betInfo.caizhong = @"400";
    betInfo.wanfa = @"01";
    
    betInfo.stopMoney = @"0";
    
    //  self.title = @"pk赛投注";
    //    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    //    staArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
    }else{
        
    }
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // [self requestHttpQingqiu];
    [self getIssueListRequest];//网络请求
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 390, self.mainView.bounds.size.height -69) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60+35, 0, 260, 44)];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = @"让球胜平负";
    titleLabel.textColor = [UIColor whiteColor];
    //    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    //    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressIssueButton) forControlEvents:UIControlEventTouchUpInside];
    if (chaodanbool) {
        titleButton.enabled= NO;
    }else{
        titleButton.enabled = YES;
    }
    
    
    
    [titleButton addSubview:titleLabel];
    [titleView addSubview:titleButton];
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 9.5, 17, 17);
    
    self.CP_navigation.titleView = titleView;
    [titleView release];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 60, 44);
    
    if (chaodanbool) {
        [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:UIImageGetImageFromName(@"HC_gouwuche1.png") forState:UIControlStateNormal];
        
    }else{
        //        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chandancaidan2.png") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([kebianzidian count] > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestBeiJingDanChangDuiZhen150) object:nil];
        if (benqiboo == NO) {
            [self performSelector:@selector(requestBeiJingDanChangDuiZhen150) withObject:nil afterDelay:150];
        }
    }
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestBeiJingDanChangDuiZhen150) object:nil];
}


- (NSMutableDictionary *)jiyiMatchNameFunc{
    [kongzhiType removeAllObjects];
    
    
    NSMutableDictionary * type1 = nil;
    if ([self.wfNameString isEqualToString:@"让球胜平负"]) {
        //        titleLabel.text = [NSString stringWithFormat:@"让球胜平负%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",@"0",@"0",@"0",@"0",nil],@"choose", nil];
    }else if ([self.wfNameString isEqualToString:@"进球数"]){
        //        titleLabel.text = [NSString stringWithFormat:@"进球数%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",@"0",nil],@"choose", nil];
    }else if([self.wfNameString isEqualToString:@"上下单双"]){
        //        titleLabel.text = [NSString stringWithFormat:@"上下单双%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"1",@"0",@"0",@"0",nil],@"choose", nil];
        
    }else if ([self.wfNameString isEqualToString:@"比分"]){
        //        titleLabel.text = [NSString stringWithFormat:@"比分%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"1",@"0",@"0",nil],@"choose", nil];
    }else if ([self.wfNameString isEqualToString:@"半全场胜平负"]){
        //        titleLabel.text = [NSString stringWithFormat:@"半全场%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"1",@"0",nil],@"choose", nil];
    }else if ([self.wfNameString isEqualToString:@"胜负过关"]){
        //        titleLabel.text = [NSString stringWithFormat:@"胜负过关%@期", issString];
        type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"1",nil],@"choose", nil];
    }
    
    return type1;
}

- (void)pressTitleButton1:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao_selected.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
}
- (void)pressTitleButton2:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
}
- (void)pressTitleButton:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    
    //    if (bdwfBool) {
    //
    //    }else{
    //
    //    }
    [kongzhiType removeAllObjects];
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"玩法",@"title",[NSArray arrayWithObjects: @"让球胜平负", @"进球数", @"上下单双",@"比分",@"半全场胜平负",@"胜负过关",nil],@"choose", nil];
    NSMutableArray * issuearr = [[NSMutableArray alloc] initWithCapacity:0];
    if (bdwfBool) {
        
        for (int i = 0; i < [sfIssueArray count] ; i++) {
            IssueDetail * detail = [sfIssueArray objectAtIndex:i];
            [issuearr addObject:detail.issue];
        }
        
    }else{
        
        for (int i = 0; i < [issueTypeArray count] ; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            [issuearr addObject:detail.issue];
        }
        
    }
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"期号选择",@"title",issuearr,@"choose", nil];
    [issuearr release];
    
    if ([kongzhiType count] == 0 ) {
        NSMutableArray *isarr = [NSMutableArray array];
        
        if (bdwfBool) {
            for(int i = 0; i < [sfIssueArray count]; i++){
                IssueDetail * detail = [sfIssueArray objectAtIndex:i];
                if ([self.sfissueString isEqualToString:detail.issue]) {
                    [isarr addObject:@"1"];
                }else{
                    [isarr addObject:@"0"];
                }
                
            }
        }else{
            
            for(int i = 0; i < [issueTypeArray count]; i++){
                IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                if ([self.qtissueString isEqualToString:detail.issue]) {
                    [isarr addObject:@"1"];
                }else{
                    [isarr addObject:@"0"];
                }
                
            }
            
        }
        
        
        
        
        NSMutableDictionary * type1 = [self jiyiMatchNameFunc];
        
        NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",isarr,@"choose", nil];
        
        
        [kongzhiType addObject:type1];
        [kongzhiType addObject:type2];
        
        
    }
    
    //    if ([sfKongzhiType count] == 0) {
    //        NSMutableArray *isarr = [NSMutableArray array];
    //
    //            for(int i = 0; i < [sfIssueArray count]; i++){
    //                IssueDetail * detail = [sfIssueArray objectAtIndex:i];
    //                if ([self.sfissueString isEqualToString:detail.issue]) {
    //                    [isarr addObject:@"1"];
    //                }else{
    //                    [isarr addObject:@"0"];
    //                }
    //
    //            }
    //
    //
    //
    //        NSMutableDictionary * type1 = [self jiyiMatchNameFunc];
    //        NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",isarr,@"choose", nil];
    //
    //
    //        [sfKongzhiType addObject:type1];
    //        [sfKongzhiType addObject:type2];
    //
    //    }
    
    
    [array addObject:dic];
    [array addObject:dic2];
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    kongzhiBool = NO;
    
    alert2.jingcaiBool = beidan;
    alert2.bdwfBool = YES;
    //    if (matchType == MatchShengFuGuoGan) {
    //        alert2.bjdcType = 2;
    //        alert2.sfIssueArray = sfIssueArray;
    //        alert2.issueTypeArray = issueTypeArray;
    //        alert2.sfissueString = self.sfissueString;
    //        alert2.qtissueString = self.qtissueString;
    //    }else{
    //        alert2.bjdcType = 1;
    //    }
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
    
    
}

- (void)shengfuFuncReturn:(BOOL)yesorno chooseView:(CP_KindsOfChoose *)chooseView kongzhiType:(NSMutableArray *)kong name:(NSString *)name{
    
    
    if (chooseView) {
        [chooseView removeFromSuperview];
        chooseView = nil;
    }
    if ([name length] > 0) {
        self.wfNameString = name;
    }else{
        self.wfNameString = @"让球胜平负";
    }
    if (yesorno) {
        bdwfBool = YES;
        
    }else{
        
        bdwfBool = NO;
        
    }
    
    //    BOOL sforqibool = NO;
    //    if ([kong count] > 0) {
    //        NSMutableDictionary * dictkong = [kongzhiType objectAtIndex:0];
    //        NSMutableArray * kongtypearr = [dictkong objectForKey:@"choose" ];
    //        if ([kongtypearr count] >= 6) {
    //            if ([[kongtypearr objectAtIndex:6] isEqualToString:@"1"]) {
    //                sforqibool = YES;
    //            }
    //        }
    //    }
    //    if (sforqibool) {
    //        [sfKongzhiType removeAllObjects];
    //        [sfKongzhiType addObjectsFromArray:kong];
    //    }else{
    //        [kongzhiType removeAllObjects];
    //        [kongzhiType addObjectsFromArray:kong];
    //    }
    
    [self pressTitleButton:nil];
    
    
}

- (void)matchNamePlayKey:(NSString *)name{
    
    if ([name isEqualToString:@"让球胜平负"]) {
        matchType = MatchRangQiuShengPingFu;
        
    }else if ([name isEqualToString:@"进球数"]){
        matchType = MatchJinQiuShu;
        
    }else if ([name isEqualToString:@"上下单双"]){
        matchType = MatchShangXiaDanShuang;
        
    }else if ([name isEqualToString:@"比分"]){
        matchType = MatchBiFen;
        
    }else if ([name isEqualToString:@"半全场胜平负"]){
        matchType = matchBanQuanChang;
        
    }else if ([name isEqualToString:@"胜负过关"]){
        matchType = MatchShengFuGuoGan;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fiveButtonBool = NO;
    allButtonBool = YES;
    shengfuTypeArray = [[NSMutableArray alloc] initWithCapacity:0];
    issueTypeArray = [[NSMutableArray alloc] initWithCapacity:0];
    sfIssueArray = [[NSMutableArray alloc] initWithCapacity:0];
    sfMatchArray = [[NSMutableArray alloc] initWithCapacity:0];
    sfKongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    //    allIssueArray = [[NSMutableArray alloc] initWithCapacity:0];
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
    [allimage addObject:@"caidansssx.png"];
//    [allimage addObject:@"menuhmdt.png"];
    [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
    [allimage addObject:@"gc_zancunimage.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"赛事筛选"];
//    [alltitle addObject:@"合买大厅"];
    [alltitle addObject:@"玩法选择"];
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





- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        NSMutableArray *array = [NSMutableArray array];
        
        if (matchType == MatchRangQiuShengPingFu) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
            
            
            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            
            if ([duoXuanArr count] == 0) {
                NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
                
                
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    [countarr addObject:@"1"];
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                [duoXuanArr addObject:type1];
                
                [duoXuanArr addObject:type3];
            }
            
            [array addObject:dic];
            
            [array addObject:dic3];
        }else if(matchType == MatchShengFuGuoGan){
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"类型选择",@"title",sfMatchArray,@"choose", nil];
            
            
            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            
            if ([duoXuanArr count] == 0) {
                NSMutableArray * countarr1 = [NSMutableArray array];
                for (int i = 0; i < [sfMatchArray count]; i++) {
                    [countarr1 addObject:@"0"];
                }
                NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",countarr1,@"choose", nil];
                
                
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    [countarr addObject:@"1"];
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                [duoXuanArr addObject:type1];
                
                [duoXuanArr addObject:type3];
            }
            
            [array addObject:dic];
            
            [array addObject:dic3];
            
        }else{
            
            
            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            
            if ([duoXuanArr count] == 0) {
                
                
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    [countarr addObject:@"1"];
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                [duoXuanArr addObject:type3];
            }
            
            
            
            [array addObject:dic3];
        }
        
        
        NSLog(@"duo = %@", duoXuanArr);
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
        alert2.allButtonBool = allButtonBool;
        alert2.fiveButtonBool = fiveButtonBool;
        if (matchType == MatchShengFuGuoGan) {
            alert2.bdsfBool = YES;
        }
        alert2.delegate = self;
        alert2.tag = 30;
        alert2.duoXuanBool = YES;
        [alert2 show];
        self.mainView.userInteractionEnabled = NO;
        [alert2 release];
        
        
        
        
    }
    
    else if(index == 1){
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:@"北京单场"];
        [self pressTitleButton:nil];
    }else if(index == 3){
        [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:@"北京单场"];
        [self pressHelpButton:nil];
        
    }
//    else if(index == 1){
//        [MobClick event:@"event_goucai_hemaidating_caizhong" label:@"北京单场"];
//        if (matchType == MatchRangQiuShengPingFu) {
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:200 lotteryId:@"400"];
//        }else if (matchType == MatchJinQiuShu){
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:230 lotteryId:@"400"];
//        }else if (matchType == MatchShangXiaDanShuang){
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:210 lotteryId:@"400"];
//        }else if (matchType == MatchBiFen){
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:250 lotteryId:@"400"];
//        }else if (matchType == matchBanQuanChang){
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:240 lotteryId:@"400"];
//        }else if (matchType == MatchShengFuGuoGan){
//            [self otherLottoryViewController:0 title:@"北单合买" lotteryType:270 lotteryId:@"400"];
//        }
//        
//        
//    }
    else if(index == 2){
        [MobClick event:@"event_goucai_zancun_caizhong" label:@"北单"];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"huancunzancun"];
        judgeBool = YES;
        [self sysTimeFunc];
        
        
    }
}

- (void)shengFuGuoGanScreenFunc:(NSMutableArray *)returnarry{
    
    [cellarray removeAllObjects];
    
    if ([returnarry count] == 0) {
        
        [kebianzidian removeAllObjects];
        [self shaixuanzidian:allcellarr];
        [myTableView reloadData];
        return;
    }
    
    BOOL zuqiuBool = NO;
    for (int i = 0; i < [returnarry count]-1; i++) {
        NSMutableArray *screenArray = [returnarry objectAtIndex:i];
        for (int j = 0; j < [screenArray count]; j++) {
            NSArray * logoArr = [[screenArray objectAtIndex:j] componentsSeparatedByString:@"("];
            if ([[logoArr objectAtIndex:0] isEqualToString:@"足球"]) {
                zuqiuBool = YES;
            }
        }
    }
    
    
    
    
    if (zuqiuBool == NO) {
        for (int i = 0; i < [allcellarr count]; i++) {
            
            BOOL yesorno = NO;
            GC_BetData * btd = [allcellarr objectAtIndex:i];
            for (int j = 0; j < [returnarry count]-1; j++) {
                NSMutableArray *screenArray = [returnarry objectAtIndex:j];
                for (int n = 0; n < [screenArray count]; n++) {
                    
                    NSArray * logoArr = [[screenArray objectAtIndex:n] componentsSeparatedByString:@"("];
                    if ([btd.matchLogo isEqualToString:[logoArr objectAtIndex:0]]) {
                        yesorno = YES;
                    }
                    
                }
            }
            if (yesorno) {
                //                yesorno = NO;
                [cellarray addObject:btd];
            }
            
            
        }
        
    }else{
        for (int i = 0; i < [allcellarr count]; i++) {
            
            BOOL yesorno = NO;
            GC_BetData * btd = [allcellarr objectAtIndex:i];
            for (int j = 0; j < [returnarry count]-1; j++) {
                NSMutableArray *screenArray = [returnarry objectAtIndex:j];
                for (int n = 0; n < [screenArray count]; n++) {
                    
                    NSArray * logoArr = [[screenArray objectAtIndex:n] componentsSeparatedByString:@"("];
                    if (![[logoArr objectAtIndex:0] isEqualToString:@"足球"]) {
                        if ([btd.matchLogo isEqualToString:[logoArr objectAtIndex:0]]) {
                            yesorno = YES;
                        }
                        
                    }else{
                        if ([returnarry count] >= 2) {
                            NSMutableArray *twoArray = [returnarry objectAtIndex:1];
                            if ([twoArray count] > 0) {
                                for (int k = 0; k <[twoArray count]; k++) {
                                     NSString * saishi1 = [btd.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                                    if ([saishi1 isEqualToString:[twoArray objectAtIndex:k]]) {
                                        yesorno = YES;
                                    }
                                }
                            }else{
                                if ([btd.matchLogo isEqualToString:@"足球"]) {
                                    yesorno = YES;
                                }
                                
                            }
                            
                        }else{
                            yesorno = YES;
                        }
                        
                        
                    }
                    
                    
                }
            }
            if (yesorno) {
                //                yesorno = NO;
                [cellarray addObject:btd];
            }
            
            
        }
        
    }
    
    
    
    
    [kebianzidian removeAllObjects];
    if ([cellarray count] == 0) {
        [self shaixuanzidian:allcellarr];
    }else{
        [self shaixuanzidian:cellarray];
    }
    
    
    
    [myTableView reloadData];
    
}
-(void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnKongZhiType:(NSInteger)_type
{
}
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (chooseView.tag == 30) {
        
        if (buttonIndex == 1) {
            [duoXuanArr removeAllObjects];
            [duoXuanArr addObjectsFromArray:kongt];
            allButtonBool = chooseView.allButtonBool;
            fiveButtonBool = chooseView.fiveButtonBool;
            if (matchType == MatchShengFuGuoGan) {
                
                [shengfuTypeArray removeAllObjects];
                [shengfuTypeArray addObjectsFromArray:returnarry];
                [self shengFuGuoGanScreenFunc:returnarry];//胜负过关的赛事筛选
                return;
            }
            
            
            NSInteger zcount = 0;
            NSInteger diyicount = 0;
            NSInteger diercount = 0;
            NSInteger disancount = 0;
            NSInteger rangfeirang1 = 0;
            NSInteger rangfenrang2 = 0;
            
            NSMutableArray * tiaojianarr = [NSMutableArray array];
            
            
            for (int i = 0; i < [chooseView.dataArray count]; i++) {
                NSDictionary *data = [chooseView.dataArray objectAtIndex:i];
                UIView * bottonview = (UIView *)[chooseView.backScrollView viewWithTag:i+1000];
                NSMutableArray *chooseArray = [data objectForKey:@"choose"];
                BOOL xuanbool = NO;
                if (matchType == MatchRangQiuShengPingFu) {
                    for (int k = 0; k < [chooseArray count]; k++) {
                        CP_XZButton * but1 = (CP_XZButton *)[bottonview viewWithTag: k + [chooseArray count]];
                        if (but1.selected == YES) {
                            if (k == 0 && i == 0) {
                                rangfeirang1 = 1;
                            }
                            if (i == 0 && k == 1){
                                rangfenrang2 = 1;
                            }
                            
                            
                            
                            xuanbool = YES;
                            [tiaojianarr addObject:but1.buttonName.text];
                        }
                        
                    }
                    
                }
                
                if (xuanbool == NO) {
                    if (i == 0) {
                        diyicount += 1;
                    }else if(i == 1){
                        diercount += 1;
                    }else if(i == 2){
                        disancount += 1;
                    }
                    zcount += 1;
                    for (int n = 0; n < [chooseArray count]; n++) {
                        CP_XZButton * but2 = (CP_XZButton *)[bottonview viewWithTag: n + [chooseArray count]];
                        [tiaojianarr addObject:but2.buttonName.text];
                        
                    }
                }
                
                
            }
            
            
            
            NSLog(@"log = %@", tiaojianarr);
            
            
            [cellarray removeAllObjects];
            
            NSArray * arrayz = [returnarry objectAtIndex:[returnarry count]-1];
            NSMutableArray * zhongjiecell = [NSMutableArray array];
            if ([arrayz count] == 0) {
                [zhongjiecell addObjectsFromArray:allcellarr];
            }else{
                
                for (int i = 0; i < [allcellarr count]; i++) {
                    GC_BetData * btd = [allcellarr objectAtIndex:i];
                    for (int k = 0; k < [arrayz count]; k++) {
                        NSLog(@"btd.event = %@, cell = %@", btd.event, [arrayz objectAtIndex:k]);
                        NSString * saishi1 = [btd.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                        NSString * saishi2 = [[arrayz objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                        if ([saishi1 isEqualToString:saishi2]) {
                            [zhongjiecell addObject:btd];
                        }
                        
                    }
                }
                
                
            }
            
            
            
            if (zcount == 2) {
                [cellarray addObjectsFromArray:zhongjiecell];
            }else{
                NSMutableArray * rangarrsha = [NSMutableArray array];
                if ((rangfeirang1 == 0 && rangfenrang2 == 0)||(rangfeirang1 == 1 && rangfenrang2 == 1)) {
                    
                    [rangarrsha addObjectsFromArray:zhongjiecell];
                    
                }else if(rangfeirang1 == 1 && rangfenrang2 != 1){
                    
                    for (int i = 0; i < [zhongjiecell count]; i++) {
                        
                        GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                        NSArray * teamarray = [shuju.team componentsSeparatedByString:@","];
                        if ([teamarray count] >2) {
                            
                            if ([[teamarray objectAtIndex:2] floatValue] != 0) {
                                [rangarrsha addObject:shuju];
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                }else if(rangfeirang1 != 1 && rangfenrang2 == 1){
                    
                    for (int i = 0; i < [zhongjiecell count]; i++) {
                        
                        GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                        NSArray * teamarray = [shuju.team componentsSeparatedByString:@","];
                        if ([teamarray count] >2) {
                            
                            if ([[teamarray objectAtIndex:2] floatValue] == 0) {
                                [rangarrsha addObject:shuju];
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
                [cellarray addObjectsFromArray:rangarrsha];
                
            }
            
            
            
            
            
            
            
            NSLog(@"cell = %@", cellarray);
            [kebianzidian removeAllObjects];
            [self shaixuanzidian:cellarray];
            
            
            [myTableView reloadData];
            
            
            
        }
        
        
    }else if (chooseView.tag == 8) {
        addchuan = 0;
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 100; i++) {
            buf[i] = 0;
        }
        
        for (int i = 0; i < [returnarry count];i++) {
            NSString * str = [returnarry objectAtIndex:i];
            NSLog(@"st = %@", str);
            UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            senbutton.tag = i + 1;
            senbutton.titleLabel.text = str;
            [self pressChuanJiuGongGe:senbutton];
            
            
            
            
        }
        
        
        
        
    }else{
        
        
        if (buttonIndex == 1) {
            NSLog(@"kongt = %@", kongt);
            sendBool = YES;
            self.retArray = returnarry;
            self.kongArray = kongt;
            self.kindChoose = chooseView;
            judgeBool = NO;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
            [self sysTimeFunc];
            allButtonBool = YES;
            fiveButtonBool = NO;
            
            
        }
        
    }
    
    
}

-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView
{
    self.mainView.userInteractionEnabled = YES;
}

- (NSString *)getSystemTodayTime
{
    // 2012-03-07 11:17:48 星期三
    // 02-27 星期一 14:50
    NSString *systime = [[GC_UserInfo sharedInstance] get_system_today_time];
    NSArray *v = [systime componentsSeparatedByString:@" "];
    NSMutableString *time = nil;
    if (v.count == 3) {
        NSString *ymd = [v objectAtIndex:0];
        NSString *hms = [v objectAtIndex:1];
        
        NSArray *v0 = [ymd componentsSeparatedByString:@"-"];
        if (v0.count == 3) {
            time = [NSMutableString stringWithString:[v0 objectAtIndex:1]];
            [time appendString:@"-"];
            [time appendString:[v0 objectAtIndex:2]];
        }
        [time appendString:@" "];
        [time appendString:[v objectAtIndex:2]];
        
        NSArray *v1 = [hms componentsSeparatedByString:@":"];
        if (v1.count == 3) {
            [time appendString:@" "];
            [time appendString:[v1 objectAtIndex:0]];
            [time appendString:@":"];
            [time appendString:[v1 objectAtIndex:1]];
        }
    }
    return time;
}


//下拉的函数
- (void)handleSwipeFrom:(UIButton *)recognizer{
    
    
    
    // if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
    
    NSLog(@"swipe down");
    bgviewdown = [[UIView alloc] initWithFrame:self.mainView.bounds];
    bgviewdown.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIButton * downbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    downbutton.frame = self.mainView.bounds;
    downbutton.backgroundColor = [UIColor clearColor];
    [downbutton addTarget:self action:@selector(pressdownbutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgviewdown addSubview:downbutton];
    
    bgimagedown = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    
    
    bgimagedown.image = [UIImageGetImageFromName(@"gc_titBg_7.png") stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    
    UILabel * textl = [[UILabel alloc] initWithFrame:CGRectMake(106, 193, 106, 20)];
    textl.textAlignment = NSTextAlignmentCenter;
    textl.font = [UIFont systemFontOfSize:12];
    textl.backgroundColor = [UIColor clearColor];
    textl.text = @"确定";
    [bgimagedown addSubview:textl];
    [textl release];
    
    UIButton * quedingbut = [UIButton buttonWithType:UIButtonTypeCustom];
    quedingbut.frame = textl.bounds;
    [quedingbut addTarget:self action:@selector(pressdownbutton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimagedown addSubview:quedingbut];
    
    
    NSString *systemTime = [self getSystemTodayTime];
    NSString *remainingTimeLabelStr = [NSString stringWithFormat:@"当前时间：%@", systemTime];
    // NSLog(@"REMAINING = %@", remainingTimeLabelStr);
    NSArray * timearray = [remainingTimeLabelStr componentsSeparatedByString:@" "];
    NSString * datestr = [timearray objectAtIndex:0];
    NSArray * dateatt = [datestr componentsSeparatedByString:@"间："];
    
    if (dateatt.count < 2) {
        dateatt = [NSArray arrayWithObjects:@"",@"", nil];
    }
    if (timearray.count < 2) {
        timearray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    NSString * timestring = [NSString stringWithFormat:@"%@ %@", [dateatt objectAtIndex:1], [timearray objectAtIndex:1]];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(212, 193, 106, 20)];
    timeLabel.text = timestring;
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [bgimagedown addSubview:timeLabel];
    [timeLabel release];
    
    
    [bgviewdown addSubview:bgimagedown];
    
    
    
    imagevv = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 0)];
    imagevv.backgroundColor = [UIColor clearColor];
    imagevv.alpha = 1;
    
    UIImageView * sibgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 195)];
    sibgimage.image = [UIImageGetImageFromName(@"gc_jggbg.png") stretchableImageWithLeftCapWidth:50 topCapHeight:20];
    sibgimage.backgroundColor = [UIColor clearColor];
    [imagevv addSubview:sibgimage];
    [sibgimage release];
    
    [bgviewdown addSubview:imagevv];
    bgviewdown.frame = CGRectMake(0, 0, 320, 0);
    [self.mainView addSubview:bgviewdown];
    
    imagevv.frame = CGRectMake(20, 4, 280, 195);
    bgimagedown.frame = CGRectMake(0, 0, 320, 228);
    bgviewdown.frame = self.mainView.bounds;
    
    
    int tag = 1;
    int index = 0;
    int width = 66;
    int height = 26;
    int cishu = 0;
    if ([saishiArray count]%4 == 0) {
        cishu = (int)[saishiArray count]/4;
        
    }else{
        cishu = (int)[saishiArray count]/4+1;
    }
    
    for (int i = 0; i < cishu; i ++) {
        for (int j = 0; j < 4; j++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImageView * butbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            butbgimage.backgroundColor = [UIColor clearColor];
            butbgimage.tag = tag * 1000;
            butbgimage.image = UIImageGetImageFromName(@"gc_jgg.png");
            [button addSubview:butbgimage];
            [butbgimage release];
            
            UIImageView * dotimg = [[UIImageView alloc] initWithFrame:CGRectMake(41, 0, 19, 19)];
            dotimg.image = UIImageGetImageFromName(@"gc_dot6.png");
            dotimg.tag = tag * 10;
            dotimg.hidden = YES;
            
            button.frame = CGRectMake(8+j*width, 15+i*height, width, height);
            
            
            
            if ([saishiArray count] >= tag) {
                
                UILabel * buttontext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
                buttontext.textAlignment = NSTextAlignmentCenter;
                buttontext.backgroundColor = [UIColor clearColor];
                //传值text
                buttontext.text = [saishiArray objectAtIndex:index];
                buttontext.font = [UIFont systemFontOfSize:12];
                [button addSubview:buttontext];
                [buttontext release];
            }else{
                [dotimg release];
                break;
            }
            button.tag  = tag;
            if (tag != 1) {
                if (butt[tag] == 1) {
                    butbgimage.image = UIImageGetImageFromName(@"gc_hover4.png");
                    dotimg.hidden = NO;
                }
            }
            
            [button addSubview:dotimg];
            [dotimg release];
            
            index++;
            tag++;
            [button addTarget:self action:@selector(pressSaiShi:) forControlEvents:UIControlEventTouchUpInside];
            [imagevv addSubview:button];
        }
    }
    
    
    
    if ([saishiArray count]%4 == 0) {
        imagevv.frame = CGRectMake(20, 0, 280, 31*([saishiArray count]/4+1));
        sibgimage.frame = CGRectMake(0, 0, 280, 31*([saishiArray count]/4+1));
        bgimagedown.frame = CGRectMake(0, 0, 320, 31*([saishiArray count]/4)+70);
    }else if([saishiArray count]/4 == 0&& [saishiArray count]>4){
        imagevv.frame = CGRectMake(20, 0, 280, 38*([saishiArray count]/4+1));
        sibgimage.frame = CGRectMake(0, 0, 280, 38*([saishiArray count]/4+1));
        bgimagedown.frame = CGRectMake(0, 0, 320, 38*([saishiArray count]/4+1)+40);
        
    }if ([saishiArray count] < 4){
        imagevv.frame = CGRectMake(20, 0, 280, 58*([saishiArray count]/4+1));
        sibgimage.frame = CGRectMake(0, 0, 280, 58*([saishiArray count]/4+1));
        bgimagedown.frame = CGRectMake(0, 0, 320, 58*([saishiArray count]/4+1)+70);
        
    }else{
        imagevv.frame = CGRectMake(20, 0, 280, 27*([saishiArray count]/4+2));
        sibgimage.frame = CGRectMake(0, 0, 280, 27*([saishiArray count]/4+2));
        bgimagedown.frame = CGRectMake(0, 0, 320, 27*([saishiArray count]/4)+101);
    }
    
    textl.frame = CGRectMake(106, bgimagedown.frame.size.height - 35, 106, 20);
    timeLabel.frame = CGRectMake(212,  bgimagedown.frame.size.height - 35, 106, 20);//确定 和 时间
    //  }
}

//赛事
- (void)pressSaiShi:(UIButton *)sender{
    
    if (butt[sender.tag] == 0) {
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        
        // NSLog(@"count = %d", [saishiArray count]);
        if (sender.tag == 1) {
            for (int i = 1; i <= [saishiArray count]; i++) {
                if (i == 1) {
                    UIImageView * imagebg2 = (UIImageView *)[imagevv viewWithTag:i * 1000];
                    imagebg2.image = nil;
                    UIImageView * image2 = (UIImageView *)[imagevv viewWithTag:i* 10];
                    image2.hidden = YES;
                    butt[i] = 1;
                }else{
                    
                    UIImageView * imagebg = (UIImageView *)[imagevv viewWithTag:i * 1000];
                    imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
                    UIImageView * image = (UIImageView *)[imagevv viewWithTag:i* 10];
                    image.hidden = NO;
                    butt[i] = 1;
                }
                
                
                
                
                
                
                if (i == sender.tag) {
                    continue;
                }
                
            }
            
            
        }else{
            
            
            
            butt[sender.tag] = 1;
            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 1000];
            imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
            
            
        }
        
    }else{
        
        
        if (sender.tag == 1) {
            for (int i = 1; i <= [saishiArray count]; i++) {
                UIImageView * imagebg = (UIImageView *)[imagevv viewWithTag:i * 1000];
                imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
                UIImageView * image = (UIImageView *)[imagevv viewWithTag:i* 10];
                image.hidden = YES;
                butt[i] = 0;
                //                if (i == sender.tag) {
                //                    continue;
                //                }
                UIButton * vi = (UIButton *)[imagevv viewWithTag:i];
                vi.enabled = YES;
            }
        }else{
            
            for (int i = 1; i <= [saishiArray count]; i++) {
                
                UIButton * vi = (UIButton *)[imgev viewWithTag:i];
                vi.enabled = YES;
            }
            UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
            image.hidden = YES;
            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 1000];
            imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
            butt[sender.tag] = 0;
            butt[1] = 0;
            
        }
        
        
    }
    
}


- (void)pressdownbutton:(UIButton *)sender{
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:0];
    int saishicount = 0;
    for (int i = 1; i <= [saishiArray count]; i++) {
        if (butt[i] == 1) {
            NSLog(@"i = %d", i);
            NSString * name = [saishiArray objectAtIndex:i-1];
            NSLog(@"name = %@", name);
            [arr addObject:name];
            saishicount++;
        }
    }
    
    
    if (saishicount == 0) {
        
    }else{
        textlabel.text = [NSString stringWithFormat:@"赛事筛选(%d)", saishicount];
    }
    
    [cellarray removeAllObjects];
    [kebianzidian removeAllObjects];
    
    
    for (NSString * st in arr) {
        
        if ([arr count] == 0 || [st isEqualToString:@"全部"]) {
            for (GC_BetData * d in allcellarr) {
                [cellarray addObject:d];
                
            }
            textlabel.text = @"赛事筛选(全部)";
            
            break;
        }else{
            
            
            
            for (GC_BetData * da in allcellarr) {
                NSString * saishi1 = [da.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString * saishi2 = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
                if ([saishi1 isEqualToString:saishi2]) {
                    [cellarray addObject:da];
                }
            }
            
        }
        
    }
    
    if ([arr count] > 0) {
        //   textlabel.text = @"赛事筛选(全部)";
        if ([textlabel.text isEqualToString:@"赛事筛选(全部)"]) {
            [self shaixuanzidian:allcellarr];
        }else{
            for (int i = 0; i < [cellarray count]; i++) {
                for (int j = 0; j < [cellarray count]; j++) {
                    GC_BetData * betdata = [cellarray objectAtIndex:i];
                    
                    NSString * waistr = betdata.numzhou; //substringWithRange:NSMakeRange(2, 3)];
                    NSLog(@"waistr = %@", waistr);
                    
                    GC_BetData * bet = [cellarray objectAtIndex:j];
                    
                    NSString * neistr = bet.numzhou;//[bet.numzhou substringWithRange:NSMakeRange(2, 3)];
                    if ([waistr intValue]  < [neistr intValue]) {
                        [cellarray exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                }
            }
            
            [self shaixuanzidian:cellarray];
        }
        
    }else{
        [self shaixuanzidian:allcellarr];
        textlabel.text = @"赛事筛选(全部)";
    }
    for (int i = 0; i < 100; i++) {
        buffer[i] = 1;
    }
    [myTableView reloadData];
    [bgviewdown removeFromSuperview];
    [bgviewdown release];
    [bgimagedown release];
    [arr removeAllObjects];
    [arr release];
}





//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    if (sender.tag == 1) {
        [bgview removeFromSuperview];
    }else if(sender.tag != 1 && sender.tag != 6){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"稍后上线,敬请关注"];
    }
    
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
    tabBack.image =nil;
    tabBack.backgroundColor = [UIColor blackColor];
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(pressQingButton) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 8, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 40, 13)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:12];
    oneLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [zhubg addSubview:oneLabel];
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 16, 40, 13)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:12];
    twoLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
    twoLabel.hidden = YES;
    
    [zhubg addSubview:twoLabel];
    
    //场字
    fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 1, 20, 13)];
    fieldLable.text = @"场";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:12];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];;
    //注字
    pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 20, 13)];
    pourLable.text = @"元";
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:12];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
    pourLable.hidden = YES;
    
    //投注按钮背景
    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,63, 30)];
    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");
    
    //投注按钮
    castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
    //    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
    //    chuanimage1.backgroundColor = [UIColor clearColor];
    //    chuanimage1.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //    [castButton addSubview:chuanimage1];
    //    [chuanimage1 release];
    
    if (one < 1) {
        castButton.enabled = NO;
        castButton.alpha = 0.5;
    }else{
        castButton.enabled = YES;
        castButton.alpha = 1;
    }
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //串法
    chuanButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [chuanButton1 setImage:UIImageGetImageFromName(@"gc_jcchuan.png") forState:UIControlStateNormal];
    if (one < 1) {
        chuanButton1.enabled = NO;
        chuanButton1.alpha = 0.5;
    }else{
        chuanButton1.enabled = YES;
        chuanButton1.alpha = 1;
    }
    
    chuanButton1.frame = CGRectMake(130, 8, 68, 30);
    [chuanButton1 addTarget:self action:@selector(pressChuanButton) forControlEvents:UIControlEventTouchUpInside];
    [chuanButton1 setBackgroundImage:UIImageGetImageFromName(@"chuanbgimage.png") forState:UIControlStateNormal];
    [chuanButton1 setBackgroundImage:UIImageGetImageFromName(@"chuanbgimage_1.png") forState:UIControlStateHighlighted];
    
    
    
    labelch = [[UILabel alloc] initWithFrame:chuanButton1.bounds];
    labelch.text = @"串法";
    labelch.textAlignment = NSTextAlignmentCenter;
    labelch.backgroundColor = [UIColor clearColor];
    labelch.font = [UIFont boldSystemFontOfSize:15];
    labelch.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [chuanButton1 addSubview:labelch];
    //[labelch release];
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    //buttonLabel1.textColor = [UIColor whiteColor];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:22];
    [castButton addSubview:buttonLabel1];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    [tabView addSubview:tabBack];
    [zhubg addSubview:fieldLable];
    [zhubg addSubview:pourLable];
    [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
    [tabView addSubview:chuanButton1];
    [tabView addSubview:qingbutton];
    [self.mainView addSubview:tabView];
    [fieldLable release];
    [pourLable release];
    [tabBack release];
#ifdef isCaiPiaoForIPad
    qingbutton.frame = CGRectMake(12+34, 8, 30, 30);
    zhubg.frame = CGRectMake(52+34, 7, 62, 30);
    chuanButton1.frame = CGRectMake(130+34, 6, 60, 33);
    castButton.frame = CGRectMake(230+34, 6, 80, 33);
#endif
}

- (void)pressQingButton{
    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * cear = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [cear count]; j++) {
                GC_BetData  * da = [cear objectAtIndex:j];
                da.selection1 = NO;
                da.selection2 = NO;
                da.selection3 = NO;
                da.dandan = NO;
                [cear replaceObjectAtIndex:j withObject:da];
            }
            
        }
        
        for (int i = 0; i < [allcellarr count]; i++) {
            GC_BetData  * da = [allcellarr objectAtIndex:i];
            da.selection1 = NO;
            da.selection2 = NO;
            da.selection3 = NO;
            da.dandan = NO;
            [allcellarr replaceObjectAtIndex:i withObject:da];
            
        }
    }else {
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * cear = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [cear count]; j++) {
                GC_BetData  * da = [cear objectAtIndex:j];
                da.dandan = NO;
                
                NSMutableArray * musarr = [[NSMutableArray alloc] initWithCapacity:0];
                for (int  m = 0; m < [da.bufshuarr count]; m++) {
                    [musarr addObject:@"0"];
                    
                }
                da.bufshuarr = musarr;
                [musarr release];
                [cear replaceObjectAtIndex:j withObject:da];
            }
        }
        for(int i = 0; i < [allcellarr count]; i++){
            GC_BetData  * da = [allcellarr objectAtIndex:i];
            for (int m = 0; m < [da.bufshuarr count]; m++) {
                //                    NSString * stns = [da.bufshuarr objectAtIndex:m];
                NSString *stns = @"0";
                [da.bufshuarr replaceObjectAtIndex:m withObject:stns];
            }
            
            da.dandan = NO;
            [allcellarr replaceObjectAtIndex:i withObject:da];
            
        }
    }
    
    
    
    [myTableView reloadData];
    
    one = 0;
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    fieldLable.text = @"场";
    pourLable.hidden = YES;
    twoLabel.hidden = YES;
    labelch.text = @"串法";
    [chuantype removeAllObjects];
    addchuan = 0;
    [zhushuDic removeAllObjects];
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    chuanButton1.enabled = NO;
    castButton.enabled = NO;
    castButton.alpha = 0.5;
    chuanButton1.alpha = 0.5;
}




//串的ui
- (void)pressChuanButton{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    
    
    shedan  = NO;
    NSInteger dancout = 0;
    NSInteger changci = 0;//计算选多少场
    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
        for (GC_BetData * da in cellarray) {
            
            if (da.selection1 || da.selection2 || da.selection3) {
                changci++;
            }
            
            if (da.dandan) {
                dancout++;
            }
        }
        
    }else{
        for (GC_BetData * da in cellarray) {
            for (int i = 0; i < [da.bufshuarr count]; i++) {
                
                if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    changci++;
                    break;
                }
                
                
                
                
            }
        }
        
        for (GC_BetData * da in cellarray) {
            for (int i = 0; i < [da.bufshuarr count]; i++) {
                if (da.dandan) {
                    
                    dancout++;
                    break;
                    
                }
                
                
            }
        }
        
        
        
    }
    
    if (dancout != 0) {//判断是否设胆
        shedan = YES;
    }
    
    
    
    
    NSMutableArray * array = nil;
    
    
    
    if (matchType == MatchRangQiuShengPingFu) {
        if (shedan) {
            array =  (NSMutableArray *)[GC_BJDanChangChuanFa danLotteryId:lotteryID GameCount:one type:0];
            
        }else{
            
            array = (NSMutableArray *)[GC_BJDanChangChuanFa lotteryId:lotteryID GameCount:one type:0];//[resultList count]
            
        }
    }else if(matchType == MatchJinQiuShu || matchType == matchBanQuanChang || matchType == MatchShangXiaDanShuang){
        
        if (shedan) {
            array =  (NSMutableArray *)[GC_BJDanChangChuanFa danLotteryId:lotteryID GameCount:one type:1];
            
        }else{
            
            array = (NSMutableArray *)[GC_BJDanChangChuanFa lotteryId:lotteryID GameCount:one type:1];//[resultList count]
            
        }
    }else if (matchType == MatchBiFen){
        
        if (shedan) {
            array =  (NSMutableArray *)[GC_BJDanChangChuanFa danLotteryId:lotteryID GameCount:one type:4];
            
        }else{
            
            array = (NSMutableArray *)[GC_BJDanChangChuanFa lotteryId:lotteryID GameCount:one type:4];//[resultList count]
            
        }
    }else if (matchType == MatchShengFuGuoGan){
        
        if (shedan) {
            array =  (NSMutableArray *)[GC_BJDanChangChuanFa danLotteryId:lotteryID GameCount:one type:6];
            
        }else{
            
            array = (NSMutableArray *)[GC_BJDanChangChuanFa lotteryId:lotteryID GameCount:one type:6];//[resultList count]
            
        }
        
    }
    
    if (matchType == MatchShengFuGuoGan && dancout == changci - 1) {
        
        [array removeAllObjects];
        [array addObject:[NSString stringWithFormat:@"%d串1", (int)changci]];
        
    }else{
        if (dancout != 0) {//设胆的情况 下 根据胆的个数 来删掉不能用的串法
            int countno = 0;
            if (matchType == MatchShengFuGuoGan){
                countno = 2;
            }else{
                countno = 1;
            }
            for (int i = countno; i <= dancout; i++) {
                if (i != countno) {
                    [array removeObjectAtIndex:0];
                    
                }
            }
            
            //选几场 如果设有胆  那么 几串一就不能用 删掉
            for (int i = 0; i < [array count]; i++) {
                NSString * st = [array objectAtIndex:i];
                NSString * chuanstr = @"2串1";
                if (matchType == MatchShengFuGuoGan) {
                    chuanstr = @"3串1";
                }
                if (![st isEqualToString:chuanstr]) {
                    if ([st isEqualToString:[NSString stringWithFormat:@"%ld串1", (long)changci]]) {
                        [array removeObjectAtIndex:i];
                    }
                }
                
            }
            
        }
    }
    
    
    if(!chaodanbool || countchao != 0){
        if ([chuantype count] != [array count]) {
            [chuantype removeAllObjects];
            for (int i = 0; i < [array count]; i++) {
                [chuantype addObject:@"0"];
            }
        }
        if ([labelch.text isEqualToString:@"串法"] || ![labelch.text isEqualToString:@"多串..."]) {
            
            BOOL youwuxuanzhong = NO;
            for (int i = 0; i < [chuantype count]; i++) {
                if ([[chuantype objectAtIndex:i] isEqualToString:@"1"]) {
                    youwuxuanzhong = YES;
                    break;
                }
            }
            if (youwuxuanzhong == NO) {
                for (int i = 0; i < [array count]; i++) {
                    if (one == 1) {
                        if ([[array objectAtIndex:i] isEqualToString:@"单关"]) {
                            [chuantype replaceObjectAtIndex:i withObject:@"1"];
                        }
                    }else{
                        if ([[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d串1", one]]) {
                            [chuantype replaceObjectAtIndex:i withObject:@"1"];
                        }
                    }
                    
                }
                
            }
            
        }
        [MobClick event:@"event_goucai_touzhu_guoguanfangshi_caizhong" label:@"北京单场"];
        CP_KindsOfChoose *alert =[[CP_KindsOfChoose alloc] initWithTitle:@"过关方式选择" withChuanNameArray:array andChuanArray:chuantype];
        alert.delegate = self;
        alert.duoXuanBool = YES;
        alert.tag = 8;
        [alert show];
        self.mainView.userInteractionEnabled = NO;
        [alert release];
        
    }
    
    if (countchao == 0) {
        if (chaodanbool) {
            [chuantype removeAllObjects];
            for (int i = 0; i < [array count]; i++) {
                [chuantype addObject:@"0"];
            }
            
            NSInteger mm = 0;
            NSRange chuanfa = [betrecorinfo.guguanWanfa rangeOfString:@","];
            if (chuanfa.location != NSNotFound) {
                NSArray * chuanfarr = [betrecorinfo.guguanWanfa componentsSeparatedByString:@","];
                
                mm = [chuanfarr count];
                for (int x = 0; x < mm; x++) {
                    //NSArray * arrchuan = [[chuanfarr objectAtIndex:x] componentsSeparatedByString:@"x"];
                    NSString * strchuan = [chuanfarr objectAtIndex:x];
                    
                    for (int y = 0; y < [array count]; y++) {
                        UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                        senbutton.tag = y+1;
                        senbutton.titleLabel.text = strchuan;
                        if ([[array objectAtIndex:y] isEqualToString:strchuan]) {
                            [chuantype replaceObjectAtIndex:y withObject:@"1"];
                            
                            [self pressChuanJiuGongGe:senbutton];
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }else {
                // mm = 1;
                //NSArray * arrchuan = [betrecorinfo.guguanWanfa componentsSeparatedByString:@"x"];
                NSString * strchuan = betrecorinfo.guguanWanfa;
                for (int y = 0; y < [array count]; y++) {
                    UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    senbutton.tag = y+1;
                    senbutton.titleLabel.text = strchuan;
                    if ([[array objectAtIndex:y] isEqualToString:strchuan]) {
                        [chuantype replaceObjectAtIndex:y withObject:@"1"];
                        
                        [self pressChuanJiuGongGe:senbutton];
                        break;
                        
                    }
                }
                
            }
            
            
        }
        
    }
    
    countchao++;
    
}

#pragma mark _KindsOfChooseViewDelegate


- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton *)sender{
    NSLog(@"st = %@", sender.buttonName.text);
    NSInteger jishuchuan = 0;
    for (CP_XZButton *v in chooseView.backScrollView.subviews) {
        if ([v isKindOfClass:[CP_XZButton class]]) {
            NSLog(@"bu = %@", v.buttonName.text);
            if (v.selected == YES) {
                jishuchuan += 1;
            }
        }
    }
    if (jishuchuan >5) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"组合串关不能超过5个"];
        sender.selected = NO;
        
    }
    
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex typeArrya:(NSMutableArray *)sender{
    NSLog(@"sender = %@", sender);
    if (buttonIndex == 1) {
        
        BOOL shifouquanling = NO;
        for (int i = 0; i < [sender count]; i++) {
            if ([[sender objectAtIndex:i] isEqualToString:@"1"]) {
                shifouquanling = YES;
            }
        }
        if (shifouquanling == NO) {
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            labelch.text = @"串法";
            addchuan = 0;
            [chuantype removeAllObjects];
            [zhushuDic removeAllObjects];
            
            
        }
        
        [chuantype removeAllObjects];
        
        [chuantype addObjectsFromArray:sender];
        
        [duoXuanArr removeAllObjects];
    }else{
        
        
    }
    
    
}

- (void)pressQueDingBut:(UIButton *)sender{
    
    
    [cbgview removeFromSuperview];
    
}

// 选择 总数
- (long long)totalItemsNum {
    long long totalNum = 0;
    if (selectedItemsDic&&selectedItemsDic.count) {
        NSArray *keys = [selectedItemsDic allKeys];
        for(id key in keys){
            NSNumber *keyNum = (NSNumber*)key;
            NSInteger _key = [keyNum integerValue];
            NSNumber *valueNum  = [selectedItemsDic objectForKey:keyNum];
            NSInteger _value = [valueNum integerValue];
            totalNum+=_key*_value;
        }
    }
    return totalNum;
}

- (void)chuanwuzhihou:(UIButton *)sender{
    
    UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
    image.hidden = YES;
    UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
    imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
    buf[sender.tag] = 0;
    //  addchuan = 5;
}
//串的九宫格

- (void)pressChuanJiuGongGe:(UIButton *)sender{
    [cellarray removeAllObjects];
    
    [cellarray addObjectsFromArray:allcellarr];
    
    if (buf[sender.tag] == 0) {
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_chuanhover.png");
        //   sender.backgroundColor  = [UIColor blueColor];
        
        addchuan +=1;
        if (addchuan > 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"组合串关不能超过5个"];
            addchuan -= 1;
            [self performSelector:@selector(chuanwuzhihou:) withObject:sender afterDelay:1];
            
        }else{
            buf[sender.tag] = 1;
        }
        
        
        for (int i = 1; i < 160; i++) {
            if (i == sender.tag) {
                continue;
            }
            
        }
        
    }else{
        
        
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = YES;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
        
        buf[sender.tag] = 0;
        addchuan -= 1;
    }
    
    UILabel * vi = sender.titleLabel;
    NSInteger currtCount;
    NSInteger selecount;
    NSNumber * currtnum;
    NSNumber * countnum;
    
    NSInteger selecout2;
    NSInteger selecout3;
    NSMutableDictionary * diction = [NSMutableDictionary dictionaryWithCapacity:0];
    selecount = 0;
    selecout2 = 0;
    selecout3 = 0;
    if (matchType == MatchRangQiuShengPingFu|| matchType == MatchShengFuGuoGan) {
        for (GC_BetData * pkb in cellarray) {
            if ((pkb.selection1 && pkb.selection2 == NO && pkb.selection3 == NO)|| (pkb.selection2 && pkb.selection1 == NO && pkb.selection3 == NO) ||(pkb.selection3 && pkb.selection1 == NO && pkb.selection2 == NO)) {
                
                selecount++;
            }
            
            
        }
        
        
        
        if (selecount != 0) {
            currtCount = 1;
            currtnum = [NSNumber numberWithInteger:selecount];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        
        for (GC_BetData * pkb in cellarray) {
            if ((pkb.selection1 && pkb.selection2 && pkb.selection3 == NO)||(pkb.selection1 && pkb.selection2== NO && pkb.selection3 )||(pkb.selection1== NO && pkb.selection2 && pkb.selection3 )) {
                selecout2++;
            }
        }
        
        if (selecout2 != 0) {
            currtCount = 2;
            currtnum = [NSNumber numberWithInteger:selecout2];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        
        for (GC_BetData * pkb in cellarray) {
            if (pkb.selection1 && pkb.selection2 && pkb.selection3) {
                selecout3++;
            }
        }
        
        if (selecout3 != 0) {
            currtCount = 3;
            currtnum = [NSNumber numberWithInteger:selecout3];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
    }else{
        
        for (int m = 0; m < 50; m++) {
            
            selecount = 0;
            
            
            //            for (GC_BetData * pkb in cellarray) {
            for (int q = 0; q < [cellarray count]; q++) {
                GC_BetData * pkb = [cellarray objectAtIndex:q];
                
                int jishuqi = 0;
                for (int i = 0; i < [pkb.bufshuarr count]; i++) {
                    if ([[pkb.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                        jishuqi += 1;
                    }
                }
                
                if (jishuqi == m+1) {
                    selecount++;
                }
                
                
            }
            
            currtCount = m+1;
            
            if (selecount != 0) {
                
                currtnum = [NSNumber numberWithInteger:selecount];
                countnum = [NSNumber numberWithInteger:currtCount];
                [diction setObject:currtnum forKey:countnum];
                
            }
            
        }
        
    }
    
    if ([[vi text] isEqualToString:@"单关"]) {
        int xxcout = 0;
        if ([m_shedanArr count] == 0) {
            for (int i = 0; i < [kebianzidian count]; i++) {
                NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
                for (int j = 0; j < [mutaarr count]; j++) {
                    GC_BetData * pkb = [mutaarr objectAtIndex:j];
                    
                    if (matchType == MatchRangQiuShengPingFu) {
                        if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                            int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                        }
                    }else{
                        NSInteger countpkb = 0;
                        for (int i = 0; i < [pkb.bufshuarr count]; i++) {
                            if ([[pkb.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                                
                                countpkb += 1;
                                
                            }
                        }
                        [m_shedanArr addObject:[NSNumber numberWithInteger:countpkb]];
                    }
                    
                }
            }
            
        }
        
        
        for (int i = 0; i < [m_shedanArr count]; i++) {
            NSNumber * xxxx = [m_shedanArr objectAtIndex:i];
            xxcout += [xxxx intValue];
        }
        
        
        NSLog(@"m_shedanarr = %@", m_shedanArr);
        
        if (buf[sender.tag] == 1) {
            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:xxcout];
            [zhushuDic setObject:longNum forKey:vi.text];
            [longNum release];
        }else{
            if ([zhushuDic objectForKey:vi.text]) {
                [zhushuDic removeObjectForKey:vi.text];
            }
            
        }
        
    }else{
        if (shedan) {// 设胆 情况
            
            if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
                [shedanArr removeAllObjects];
                
                for (GC_BetData * bed in cellarray) {
                    if (bed.selection1 || bed.selection2 || bed.selection3) {
                        if (bed.dandan) {
                            [shedanArr addObject:[NSNumber numberWithInteger:1]];
                        }else{
                            [shedanArr addObject:[NSNumber numberWithInteger:0]];
                        }
                    }
                    
                    
                }
                if ([m_shedanArr count] == 0) {
                    for (int i = 0; i < [kebianzidian count]; i++) {
                        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
                        for (int j = 0; j < [mutaarr count]; j++) {
                            GC_BetData * pkb = [mutaarr objectAtIndex:j];
                            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                                int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                                [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                            }
                            
                            
                        }
                    }
                    
                }
                
            }else{
                
                [shedanArr removeAllObjects];
                for (GC_BetData * bed in cellarray) {
                    BOOL xuanzebool = NO;
                    for (int i = 0; i< [bed.bufshuarr count]; i++) {
                        if ([[bed.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            xuanzebool = YES;
                            
                        }
                    }
                    if (xuanzebool) {
                        if (bed.dandan) {
                            [shedanArr addObject:[NSNumber numberWithInteger:1]];
                        }else{
                            [shedanArr addObject:[NSNumber numberWithInteger:0]];
                        }
                    }
                    
                }
                
                if ([m_shedanArr count] == 0) {
                    
                    for (int i = 0; i < [kebianzidian count]; i++) {
                        NSMutableArray * xxarr = [kebianzidian objectAtIndex:i];
                        for (int j = 0; j < [xxarr count]; j++) {
                            GC_BetData * pkb = [xxarr objectAtIndex:j];
                            int gc = 0;
                            for (int  m = 0; m < [pkb.bufshuarr count]; m++) {
                                NSString * bufzi = [pkb.bufshuarr objectAtIndex:m];
                                if ([bufzi isEqualToString:@"1"]) {
                                    gc += 1;
                                }
                            }
                            if (gc != 0) {
                                [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                            }
                        }
                    }
                    
                    
                }
            }
            NSLog(@"m_shedanarr = %@", m_shedanArr);
            NSLog(@"vi text = %@", [vi  text]);
            NSLog(@"cout = %lu", (unsigned long)[m_shedanArr count]);
            NSLog(@"shedanarr = %@", shedanArr);
            
            GC_NewAlgorithm *newAlgorithm = [[GC_NewAlgorithm alloc] init];
            [newAlgorithm countAlgorithmWithArray:m_shedanArr chuanGuan:[vi text] changCi:[m_shedanArr count] sheDan:(NSArray *)shedanArr];
            long long total = newAlgorithm.reTotalNumber;
            [newAlgorithm release];
            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
            if (buf[sender.tag] == 1) {
                [zhushuDic setObject:longNum forKey:vi.text];
            }else{
                if ([zhushuDic objectForKey:vi.text]) {
                    [zhushuDic removeObjectForKey:vi.text];
                }
                
            }
            [longNum release];
            
        }else{// 未设胆情况
            
            GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
            //            NSArray *keys = [selectedItemsDic allKeys];
            
            //            for (NSString* stri in keys) {
            //                NSLog(@"stri = %@", stri);
            //            }
            
            [jcalgorithm passData:diction gameCount:[cellarray count] chuan:[vi text]];
            long long  total =[jcalgorithm  totalZhuShuNum];
            NSLog(@"total = %lld", total);
            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
            if (buf[sender.tag] == 1) {
                [zhushuDic setObject:longNum forKey:vi.text];
            }else{
                if ([zhushuDic objectForKey:vi.text]) {
                    [zhushuDic removeObjectForKey:vi.text];
                }
                
            }
            [longNum release];
            
        }
        
        
    }
    
    
    
    NSArray * ar = [zhushuDic allKeys];
    
    for (NSString * st in ar) {
        NSLog(@"st = %@", st);
    }
    
    int n=0;
    for (int i = 0; i < [ar count]; i++) {
        if ([ar objectAtIndex:i] != nil || [[ar objectAtIndex:i] isEqualToString:@""]) {
            NSNumber * numq = [zhushuDic objectForKey:[ar objectAtIndex:i]];
            
            n = n + [numq intValue];
        }
        
        
    }
    oneLabel.text = [NSString stringWithFormat:@"%d", n];
    twoLabel.text = [NSString stringWithFormat:@"%d", n * 2];
    NSArray * arrr = [zhushuDic allKeys];
    
    if ([arrr count] > 1) {
        labelch.text = @"多串...";
        
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
    }else if([arrr count] == 1){
        labelch.text = [arrr objectAtIndex:0];
        
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
    }else if([arrr count] == 0){
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
    }else {
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
    }
    
}




- (void)pressChuanBgButton:(UIButton *)sender{
    [cbgview removeFromSuperview];
}

- (void)pressCastButton:(UIButton *)button{
    
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
    [self sysTimeFunc];
    
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:@"400"]];
    if (matchType == MatchShengFuGuoGan) {
        
        if (one < 3) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请至少选择3场比赛"];
            return;
        }
        NSInteger dancount = 0;
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            if (da.dandan) {
                dancount+=1;
            }
        }
        if (one == 3 && dancount > 0) {
            return;
        }
        
    }
    
    
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    
    
    NSArray * ar = [zhushuDic allKeys];
    if ([ar count] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请选择过关方式"];
        
        [self pressChuanButton];
    }else if(one < 1){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"至少选择1场比赛"];
    }else if([twoLabel.text intValue] > 20000){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"单注投注金额不能超过2万"];
        
    }else{
        //竞彩投注
        [self requestYujiJangjin];
        
    }
    
    
}

- (void)beiDanTouZhu{
    GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
    sheng.title = @"竞彩足球胜平负(过关)";
    sheng.saveKey = [self objectKeyString];
    NSLog(@"%d", two);
    
    sheng.danfushi = 1;
    
    
    sheng.bettingArray = cellarray;
    if (matchType == MatchRangQiuShengPingFu) {
        sheng.fenzhong = beijingdanchang;
    }else if (matchType == MatchJinQiuShu){
        sheng.fenzhong = beidanjinqiushu;
    }else if (matchType == MatchShangXiaDanShuang){
        sheng.fenzhong = beidanshangxiadanshuang;
    }else if (matchType == MatchBiFen){
        sheng.fenzhong = beidanbifen;
    }else if (matchType == matchBanQuanChang){
        sheng.fenzhong = beidanbanquanchang;
    }else if (matchType == MatchShengFuGuoGan){
        sheng.fenzhong = beidanshengfuguoguan;
    }
    
    sheng.moneynum = twoLabel.text;
    sheng.zhushu = [NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
    sheng.beidanbool = YES;
    sheng.zhushudict = zhushuDic;
    sheng.issString = issString;
    sheng.isHeMai = self.isHeMai;
    
    if (isHeMai) {
        sheng.hemaibool = YES;
    }else{
        sheng.hemaibool = NO;
    }
    
    [self.navigationController pushViewController:sheng animated:YES];
    [sheng release];
    
    
}


- (void)requestYujiJangjin{
    NSMutableString *strshedan = [[[NSMutableString alloc] init] autorelease];
    
    NSInteger zongchangci = 0;
    
    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            if (da.selection1 || da.selection2 || da.selection3) {
                zongchangci++;
            }
            if (da.dandan) {
                [strshedan appendFormat:@"%@,",da.changhao];
            }
        }
        NSLog(@"%@", strshedan);
        if ([strshedan length] != 0) {
            [strshedan setString:[strshedan substringToIndex:[strshedan length] - 1]];
        }else{
            [strshedan appendString:@"0"];
        }
        
    }else{
        
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            BOOL zhongjiebool = NO;
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    zhongjiebool = YES;
                    break;
                }
            }
            if (zhongjiebool) {
                zongchangci++;
            }
            if (da.dandan) {
                [strshedan appendFormat:@"%@,",da.changhao];
            }
        }
        
        if ([strshedan length] != 0) {
            [strshedan setString:[strshedan substringToIndex:[strshedan length] - 1]];
        }else{
            [strshedan appendString:@"0"];
        }
        
        
        //        for (int i = 0; i < [cellarray count]; i++) {
        //            GC_BetData * da = [cellarray objectAtIndex:i];
        //            if (da.selection1 || da.selection2 || da.selection3) {
        //                zongchangci++;
        //            }
        //            if (da.dandan) {
        //                [strshedan appendFormat:@"%@,",da.changhao];
        //            }
        //        }
        //        NSLog(@"%@", strshedan);
        //        if ([strshedan length] != 0) {
        //            [strshedan setString:[strshedan substringToIndex:[strshedan length] - 1]];
        //        }else{
        //            [strshedan appendString:@"0"];
        //        }
    }
    
    
    
    NSArray * arr = [zhushuDic allKeys];
    NSString *passTypeSet = @"";
    
    for (int i = 0; i < [arr count]; i++) {
        if ([[arr objectAtIndex:i] isEqualToString:@"单关"]) {
            passTypeSet = [NSString stringWithFormat:@"%@单关;" ,passTypeSet];
        }else{
            if (i!=arr.count-1){
                NSString * com = [arr objectAtIndex:i];
                NSArray * nsar = [com componentsSeparatedByString:@"串"];
                if (nsar.count < 2) {
                    nsar = [NSArray arrayWithObjects:@"",@"" ,nil];
                }
                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                
            }else{
                NSString * com = [arr objectAtIndex:i];
                NSArray * nsar = [com componentsSeparatedByString:@"串"];
                if (nsar.count < 2) {
                    nsar = [NSArray arrayWithObjects:@"",@"" ,nil];
                }
                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                
            }
            
            
        }
    }
    passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
    passTypeSet = [NSString stringWithFormat:@"%@@iphone", passTypeSet];
    NSLog(@"fangshi = %@", passTypeSet);
    
    
    NSString * playStr = @"";
    
    if (matchType == MatchRangQiuShengPingFu) {
        playStr = @"01";
    }else if (matchType == MatchRangQiuShengPingFu){
        playStr = @"03";
    }else if (matchType == MatchShangXiaDanShuang){
        playStr = @"02";
    }else if (matchType == MatchBiFen){
        playStr = @"05";
    }else if (matchType == matchBanQuanChang){
        playStr = @"04";
    }else if (matchType == MatchShengFuGuoGan){
        playStr =  @"06";
    }
    
    
    
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] reqGetIssueInfo:[self issueInfoReturn] cishu:zongchangci fangshi:passTypeSet shedan:strshedan beishu:1 touzhuxuanxiang:[self touzhuOpeiReturn] lottrey:@"400" play:playStr];
    
    [yujirequest clearDelegatesAndCancel];
    
    self.yujirequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [yujirequest setRequestMethod:@"POST"];
    [yujirequest addCommHeaders];
    [yujirequest setPostBody:postData];
    [yujirequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yujirequest setDelegate:self];
    [yujirequest setDidFinishSelector:@selector(yujiJiangjinRequest:)];
    [yujirequest setDidFailSelector:@selector(yujiFail:)];
    [yujirequest startAsynchronous];
    
}
- (void)yujiFail:(ASIHTTPRequest *)mrequest{
    
}
- (void)yujiJiangjinRequest:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
        sheng.chaodanbool = chaodanbool;
        sheng.saveKey = [self objectKeyString];
        sheng.title = @"竞彩足球胜平负(过关)";
        NSLog(@"%d", two);
        sheng.danfushi = 1;
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"";
        }
        
        sheng.bettingArray = cellarray;
        if (matchType == MatchRangQiuShengPingFu) {
            sheng.fenzhong = beijingdanchang;
        }else if (matchType == MatchJinQiuShu){
            sheng.fenzhong = beidanjinqiushu;
        }else if (matchType == MatchShangXiaDanShuang){
            sheng.fenzhong = beidanshangxiadanshuang;
        }else if (matchType == MatchBiFen){
            sheng.fenzhong = beidanbifen;
        }else if (matchType == matchBanQuanChang){
            sheng.fenzhong = beidanbanquanchang;
        }else if (matchType == MatchShengFuGuoGan){
            sheng.fenzhong = beidanshengfuguoguan;
        }
        sheng.moneynum = twoLabel.text;
        sheng.zhushu = [NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
        sheng.beidanbool = YES;
        sheng.zhushudict = zhushuDic;
        sheng.issString = issString;
        sheng.maxmoneystr = yuji.maxmoney;
        sheng.minmoneystr = yuji.minmoney;
        sheng.isHeMai = self.isHeMai;
        [yuji release];
        
        if (isHeMai) {
            sheng.hemaibool = YES;
        }else{
            sheng.hemaibool = NO;
        }
        
        [self.navigationController pushViewController:sheng animated:YES];
        [sheng release];
        
    }
    
}

//投注欧赔
- (NSString *)touzhuOpeiReturn{
    NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
    
    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            if (da.selection1 || da.selection2 || da.selection3) {
                
                [str appendString:da.changhao];
                [str appendString:@":"];
                
                if (da.selection1 && da.selection2 == NO && da.selection3 == NO) {
                    [str appendFormat:@"%@;", da.but1];
                }
                if (da.selection2 && da.selection1 == NO && da.selection3 == NO) {
                    [str appendFormat:@"%@;", da.but2];
                }
                if (da.selection3 && da.selection2 == NO && da.selection1 == NO) {
                    [str appendFormat:@"%@;", da.but3];
                }
                if (da.selection1 && da.selection2 && da.selection3 == NO) {
                    [str appendFormat:@"%@,%@;", da.but1, da.but2];
                }
                if (da.selection1==NO && da.selection2 && da.selection3 ) {
                    // [str appendString:@"平,负"];
                    [str appendFormat:@"%@,%@;", da.but2, da.but3];
                }
                if (da.selection1 && da.selection2==NO && da.selection3) {
                    [str appendFormat:@"%@,%@;", da.but1, da.but3];
                }
                if (da.selection1 && da.selection2 && da.selection3) {
                    [str appendFormat:@"%@,%@,%@;", da.but1, da.but2, da.but3];
                }
                
            }
        }
    }else{
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            BOOL zhongjieb = NO;
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    zhongjieb = YES;
                }
            }
            
            if(zhongjieb){
                [str appendString:da.changhao];
                [str appendString:@":"];
                for (int m = 0; m < [da.bufshuarr count]; m++) {
                    if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                        if([da.oupeiarr count]-1 < m){
                            break;
                        }
                        [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                    }
                }
                
                [str setString:[str substringToIndex:[str length] - 1]];
                [str appendString:@";"];
                
            }
            
        }
        
    }
    
    [str setString:[str substringToIndex:[str length] - 1]];
    NSLog(@"str = %@", str);
    return str;
}

- (NSString *)issueInfoReturn{
    if (cellarray&&cellarray.count) {
        NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
        if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                NSLog(@"da.sele = %d  %d  %d", da.selection1, da.selection2, da.selection3);
                
                if (da.selection1 || da.selection2 || da.selection3) {
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                    [str appendFormat:@"1"];
                    
                    [str appendString:@";"];
                    
                }
                
                
                
            }
        }else{
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                BOOL zhonjieb = NO;
                for (int j = 0; j < [da.bufshuarr count]; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        zhonjieb = YES;
                        break;
                    }
                }
                if (zhonjieb) {
                    [str appendString:da.changhao];
                    //[str appendString:@":"];
                    //[str appendString:da.numzhou];
                    [str appendString:@":"];
                    //[str appendString:@"["];
                    
                    [str appendFormat:@"1"];
                    
                    [str appendString:@";"];
                }
                
                
            }
            
            
            
        }
        
        [str setString:[str substringToIndex:[str length] - 1]];
        NSLog(@"str = %@", str);
        return str;
    }
    
    
    return nil;
}


- (void)chaodanshuzu{
    for (int i = 0; i < [betrecorinfo.betContentArray count]; i++) {
        NSLog(@"201 = %@", [betrecorinfo.betContentArray objectAtIndex:i]);
    }
    NSLog(@"guoguanwanfa = %@, wan = %@", betrecorinfo.guguanWanfa, betrecorinfo.wanfaId);//wan = 01
    
    
    oneLabel.text = betrecorinfo.betsNum;
    twoLabel.text = betrecorinfo.programAmount;
    NSLog(@"jine = %@  %@", betrecorinfo.betsNum, betrecorinfo.programAmount);
    one = (int)[betrecorinfo.betContentArray count];
    NSRange chuanfa = [betrecorinfo.guguanWanfa rangeOfString:@","];
    if (chuanfa.location != NSNotFound) {
        labelch.text = @"多串...";
    }else{
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            
            
            labelch.text = @"单关";
        }else{
            
            
            labelch.text = betrecorinfo .guguanWanfa;
        }
        
    }
    chuanButton1.enabled = YES;
    castButton.enabled = YES;
    castButton.alpha = 1;
    chuanButton1.alpha = 1;    //
    for (int m = 0; m < [betrecorinfo.betContentArray count]; m++) {
        NSString * contentstr = [betrecorinfo.betContentArray objectAtIndex:m];
        NSArray * contarr = [contentstr componentsSeparatedByString:@";"];
        if (contarr.count < 4) {
            contarr = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
        }
        NSString * danstr = [contarr objectAtIndex:3];
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * kebianarr = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [kebianarr count]; j++) {
                GC_BetData * be = [kebianarr objectAtIndex:j];
                if ([be.numbermatch isEqualToString:[contarr objectAtIndex:1]]) {
                    NSString *shengpingfustr = [contarr objectAtIndex:7];
                    NSRange douhao = [shengpingfustr rangeOfString:@","];
                    if (douhao.location != NSNotFound) {
                        NSArray * spfarr = [shengpingfustr componentsSeparatedByString:@","];
                        
                        for (int n = 0; n < [spfarr count]; n++) {
                            NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                    be.selection1 = YES;
                                    
                                }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                    be.selection2 = YES;
                                    
                                }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                    be.selection3 = YES;
                                }
                            }else {
                                if ([[spfarr objectAtIndex:n] isEqualToString:@"胜"]) {
                                    be.selection1 = YES;
                                    
                                }else if([[spfarr objectAtIndex:n] isEqualToString:@"平"]){
                                    be.selection2 = YES;
                                    
                                }else if([[spfarr objectAtIndex:n] isEqualToString:@"负"]){
                                    be.selection3 = YES;
                                }
                            }
                            
                        }
                        
                        
                        
                    }else {
                        
                        NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                        
                        if (spfzi.location != NSNotFound) {
                            NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                            if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                be.selection1 = YES;
                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                be.selection2 = YES;
                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                be.selection3 = YES;
                            }
                            
                        }else {
                            if ([shengpingfustr isEqualToString:@"胜"]) {
                                be.selection1 = YES;
                            }else if([shengpingfustr isEqualToString:@"平"]){
                                be.selection2 = YES;
                            }else if([shengpingfustr isEqualToString:@"负"]){
                                be.selection3 = YES;
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    if ([danstr isEqualToString:@"1"]) {
                        be.dandan = YES;
                    }
                    
                }
                
            }
        }
        
    }
    
    [self pressChuanButton];
    [cbgview removeFromSuperview];
    
}


- (void)pkDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    
    NSString * strstr = [dict objectForKey:@"msg"];
    
    NSString * string = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"code"] intValue] ];
    
    if ([string isEqualToString:@"0"]) {
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert1 show];
        alert1.tag = 101;
        [alert1 release];
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my" object:self];
        //        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestBeiJingDanChangDuiZhen150) object:nil];
    }
}

- (void)pressHelpButton:(UIButton *)button{
    
    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];
    if (matchType == MatchRangQiuShengPingFu) {
        exp.ALLWANFA = BeiJingDanChang;
    }else if (matchType == MatchJinQiuShu){
        exp.ALLWANFA = bdzongjinqiu;
    }else if (matchType == matchBanQuanChang){
        exp.ALLWANFA = bdbanquanchang;
    }else if (matchType == MatchBiFen){
        exp.ALLWANFA = bdbifen;
    }else if (matchType == MatchShangXiaDanShuang){
        exp.ALLWANFA = bdshangxiadanshuang;
    }else if (matchType == MatchShengFuGuoGan){
        exp.ALLWANFA = beidanshengfu;
    }
    
    
    
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];
}





- (void)requestHttpQingqiu{
    
    
    
    [httprequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance]reqJingCaiIssue:2];
    self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest addCommHeaders];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest appendPostData:postData];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObject:@"issue" forKey:@"key"]];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest startAsynchronous];
    
}

-(void)requestFailed:(ASIHTTPRequest*)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
}



#pragma mark -
#pragma mark Table view data source
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 0;
 }
 */
- (void)pressBgHeader:(UIButton *)sender{
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
        
        
        // [sender setImage:UIImageGetImageFromName(@"zhankai_0.png") forState:UIControlStateNormal];
    }else{
        buffer[sender.tag] = 0;
        
        
        
        // [sender setImage:UIImageGetImageFromName(@"weizhankai.png") forState:UIControlStateNormal];
    }
    
    [myTableView reloadData];
    
    if (buffer[sender.tag] == 1) {
        [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (NSString *)updataTime:(NSDate *)timeDate betData:(GC_BetData *)betda{
    NSString * weekstr = @"";
    NSLog(@"444444444 = %@", timeDate);
    NSInteger week = [timeDate weekday];
    
    if (week == 2) {
        weekstr = @"星期一";
    }else if(week == 3){
        weekstr = @"星期二";
    }else if(week == 4){
        weekstr = @"星期三";
    }else if(week == 5){
        weekstr = @"星期四";
    }else if(week == 6){
        weekstr = @"星期五";
    }else if(week == 7){
        weekstr = @"星期六";
    }else if(week == 1){
        weekstr = @"星期日";
    }
    
    
    
    //    NSString * zoujione = @"";//[weekstr substringWithRange:NSMakeRange(2, 1)];
    //    NSString * zoujitwo = @"";//[betda.numzhou substringWithRange:NSMakeRange(1, 1)];
    //    if ([weekstr length] >= 3) {
    //        zoujione = [weekstr substringWithRange:NSMakeRange(2, 1)];
    //    }
    //    if ([betda.numzhou length] >= 2) {
    //        zoujitwo = [betda.numzhou substringWithRange:NSMakeRange(1, 1)];
    //    }
    
    
    //    if ([zoujitwo isEqualToString:zoujione]) {
    
    NSString * timestring = [timeDate string];
    if ([timestring rangeOfString:@" "].location != NSNotFound) {
        NSArray * weekarr = [timestring componentsSeparatedByString:@" "];
        
        weekstr = [NSString stringWithFormat:@"%@ %@", [weekarr objectAtIndex:0], weekstr];
    }
    
    return weekstr;
    //    }
    //    else{
    //        for (int i = 0; i < 7; i++) {
    //
    //            NSString * weekstring = [NSString stringWithFormat:@"%@ 12:00:00",betda.numtime];
    //
    //
    //
    //
    //            NSDate * earDate = [[NSDate alloc] initWithTimeInterval:-60*60*(i+1)*24 sinceDate:timeDate];//[[NSDate dateFromString:weekstring] earlierDate:[NSDate dateFromString:weekstring]];
    //            NSLog(@"weekstring = %@, weeks = %@", weekstring, earDate);
    //
    //            NSInteger weeks = [earDate weekday];
    //
    //            if (weeks == 2) {
    //                weekstring = @"星期一";
    //            }else if(weeks == 3){
    //                weekstring = @"星期二";
    //            }else if(weeks == 4){
    //                weekstring = @"星期三";
    //            }else if(weeks == 5){
    //                weekstring = @"星期四";
    //            }else if(weeks == 6){
    //                weekstring = @"星期五";
    //            }else if(weeks == 7){
    //                weekstring = @"星期六";
    //            }else if(weeks == 1){
    //                weekstring = @"星期日";
    //            }
    //
    //
    //
    //            NSString * zoujione2 = [weekstring substringWithRange:NSMakeRange(2, 1)];
    //            NSString * zoujitwo2 = [betda.numzhou substringWithRange:NSMakeRange(1, 1)];
    //            NSString * timestring = [NSString stringWithFormat:@"%@", earDate];
    //            [earDate release];
    //            if ([zoujione2 isEqualToString:zoujitwo2]) {
    //
    //                if ([timestring rangeOfString:@" "].location != NSNotFound) {
    //                    NSArray * weekarr = [timestring componentsSeparatedByString:@" "];
    //                    weekstring = [NSString stringWithFormat:@"%@ %@", [weekarr objectAtIndex:0], weekstring];
    //                }
    //                return weekstring;
    //            }
    //
    //        }
    //
    //    }
    
    //    NSString * timestring = [NSString stringWithFormat:@"%@", timeDate];
    //
    //    if ([timestring rangeOfString:@" "].location != NSNotFound) {
    //        NSArray * weekarr = [timestring componentsSeparatedByString:@" "];
    //        weekstr = [NSString stringWithFormat:@"%@ %@", [weekarr objectAtIndex:0], weekstr];
    //    }
    //
    //    return weekstr;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIButton * bgheader = [UIButton buttonWithType:UIButtonTypeCustom];//[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 28)] autorelease];
    bgheader.tag = section;
#ifdef isCaiPiaoForIPad
    bgheader.frame = CGRectMake(0, 0, 390, 44);
#else
    bgheader.frame = CGRectMake(0, 0, 320, 44);
#endif
    bgheader.backgroundColor = [UIColor clearColor];
    
    UIImageView * buttonbg = [[UIImageView alloc] initWithFrame:bgheader.bounds];
    buttonbg.backgroundColor = [UIColor clearColor];
    buttonbg.image = [UIImageGetImageFromName(@"bdheadbg.png") stretchableImageWithLeftCapWidth:8 topCapHeight:10];
    [bgheader addSubview:buttonbg];
    [buttonbg release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(293, (44-9)/2, 12.5, 9)];
    
    if (buffer[section] == 0) {
        im.image =UIImageGetImageFromName(@"bdheadguanbi.png");
        
        //        [bgheader setImage:im.image forState:UIControlStateNormal];
    }else{
        im.image = UIImageGetImageFromName(@"bdheaddakai.png");
        //        [bgheader setImage:im.image forState:UIControlStateNormal];
    }
    [bgheader addSubview:im];
    [im release];
    [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
    //  bgheader.image = UIImageGetImageFromName(@"weizhankai.png");
    
    
    
    
    NSMutableArray * keys = [kebianzidian objectAtIndex:section];
    GC_BetData * betdata = [keys objectAtIndex:0];
    
    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 294, 44)];
    timelabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textAlignment = NSTextAlignmentLeft;
    timelabel.font = [UIFont boldSystemFontOfSize:13];
    
    
    NSArray * timeArray = [betdata.timeSort componentsSeparatedByString:@"_"];
    NSString * nianyueri = [timeArray objectAtIndex:0];
    NSString * xingqiji = [timeArray objectAtIndex:1];
    
    
    if([nianyueri rangeOfString:@"-"].location != NSNotFound && [nianyueri length]>5){
        NSArray * nianarr = [nianyueri componentsSeparatedByString:@"-"];
        if (nianarr.count < 3) {
            nianarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        nianyueri = [NSString stringWithFormat:@"%@月%@日", [nianarr objectAtIndex:1], [nianarr objectAtIndex:2]];
    }
    
#ifdef isCaiPiaoForIPad
    timelabel.text = [NSString stringWithFormat:@"  %@  %@  %d场比赛",nianyueri, xingqiji, [keys count]];
#else
    timelabel.text = [NSString stringWithFormat:@" %@ %@ %lu场比赛",nianyueri, xingqiji, (unsigned long)[keys count]];
#endif
    
    [bgheader addSubview:timelabel];
    [timelabel release];
    
    
    UILabel * la   = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 274, 44)];
#ifdef isCaiPiaoForIPad
    la.frame = CGRectMake(5, 0, 340, 28);
#endif
    la.backgroundColor = [UIColor clearColor];
    la.textAlignment = NSTextAlignmentRight;
    la.textColor = [UIColor blackColor];
    la.font = [UIFont systemFontOfSize:13];
    
    [bgheader addSubview:la];
    [la release];
    NSInteger xuanzhongcount = 0;
    for (int i = 0; i < [keys count]; i++) {
        GC_BetData * betd= [keys objectAtIndex:i];
        if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
            if (betd.selection1 || betd.selection2 || betd.selection3) {
                xuanzhongcount += 1;
            }
            
        }else{
            for (int j = 0; j < [betd.bufshuarr count]; j++) {
                if ([[betd.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    xuanzhongcount += 1;
                    break;
                }
            }
        }
        
    }
    
    
    la.text = [NSString stringWithFormat:@"%ld/%lu", (long)xuanzhongcount, (unsigned long)[keys count]];
    
    
    
    //    if (buffer[section] == 0) {
    //        timelabel.textColor = [UIColor blackColor];
    //        la.textColor = [UIColor blackColor];
    //    }else{
    //        timelabel.textColor = [UIColor whiteColor];
    //        la.textColor = [UIColor whiteColor];
    //    }
    
    
    return bgheader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //    if ([dataArray count] > 14) {
    //        return 14;
    //    }
    
    if (buffer[section] == 1) {
        //        NSArray * allke = [kebianzidian allKeys];
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:section];
        
        
        
        return  [duixiangarr count];
    }else{
        return 0;
    }
    
    
    return 0;
    
    //  return [cellarray count];
    //  return 14;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [kebianzidian count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (zhankai[indexPath.section][indexPath.row] == 1) {
    //        return 55+56;
    //    }
    if (matchType == MatchRangQiuShengPingFu) {
        return 101;
    }else if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang){
        
        return 148;
    }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
        
        return 113;
    }else if ( matchType == MatchShengFuGuoGan){
        return 101;
    }
    return 55.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (matchType == MatchRangQiuShengPingFu) {
        static NSString *CellIdentifier = @"Cell";
        
        GC_BJdcCell *cell = (GC_BJdcCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[GC_BJdcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO] autorelease];
            
            
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
        if (benqiboo) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            cell.butTitle.text = @"析";
        }else{
            cell.wangqibool = NO;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
            cell.butTitle.text = @"析  胆";
        }
        
        cell.row = indexPath;
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        pkbet.donghuarow = indexPath.row;
        
        cell.pkbetdata = pkbet;
        cell.count = indexPath;
        cell.delegate = self;
        
        
        return cell;
    }else if (matchType == MatchJinQiuShu){
        
        static NSString *CellIdentifier = @"Cellidaaaa";
        
        GoalsForCell *cell = (GoalsForCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[GoalsForCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"3" chaodan:NO] autorelease];
            cell.cp_canopencelldelegate = self;
            cell.xzhi = 9.5;
            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
            cell.normalHight = 50;
            cell.selectHight = 50+56;
            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
            
            
        }
        cell.row = indexPath;
        if (benqiboo) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            cell.butTitle.text = @"析";
        }else{
            cell.wangqibool = NO;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
            cell.butTitle.text = @"析  胆";
        }
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        cell.betData = pkbet;
        cell.delegate = self;
        return cell;
        
        
    }else if (matchType == MatchShangXiaDanShuang){
        
        static NSString *CellIdentifier = @"Cellidxx";
        
        OneDoubleCell *cell = (OneDoubleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[OneDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"4" chaodan:NO] autorelease];
            cell.cp_canopencelldelegate = self;
            cell.xzhi = 9.5;
            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
            cell.normalHight = 50;
            cell.selectHight = 50+56;
            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
            
            
        }
        
        cell.row = indexPath;
        cell.delegate = self;
        
        if (benqiboo) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            cell.butTitle.text = @"析";
        }else{
            cell.wangqibool = NO;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
            cell.butTitle.text = @"析  胆";
        }        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        cell.betData = pkbet;
        
        return cell;
        
        
        
    }else if (matchType == matchBanQuanChang){
        
        static NSString *CellIdentifier = @"Cellid11";
        
        BDHalfCell *cell = (BDHalfCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[BDHalfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"3" chaodan:NO] autorelease];
            cell.cp_canopencelldelegate = self;
            cell.xzhi = 9.5;
            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
            cell.normalHight = 50;
            cell.selectHight = 50+56;
            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
            
            
        }
        
        
        cell.row = indexPath;
        cell.delegate = self;
        if (benqiboo) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            cell.butTitle.text = @"析";
        }else{
            cell.wangqibool = NO;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
            cell.butTitle.text = @"析  胆";
        }
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        cell.betData = pkbet;
        
        return cell;
        
        
    }else if (matchType == MatchBiFen){
        
        static NSString *CellIdentifier = @"Cellid1122";
        
        BDScoreCell *cell = (BDScoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[BDScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"4" chaodan:NO] autorelease];
            cell.cp_canopencelldelegate = self;
            cell.xzhi = 9.5;
            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
            cell.normalHight = 50;
            cell.selectHight = 50+56;
            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
            
            
        }
        
        
        cell.row = indexPath;
        cell.delegate = self;
        if (benqiboo) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            cell.butTitle.text = @"析";
        }else{
            cell.wangqibool = NO;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
            cell.butTitle.text = @"析  胆";
        }
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        cell.betData = pkbet;
        
        return cell;
        
        
    }else if (matchType == MatchShengFuGuoGan){
        
        static NSString *CellIdentifier = @"Cell121";
        
        VictoryOrDefeatTableViewCell *cell = (VictoryOrDefeatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[VictoryOrDefeatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"6" chaodan:NO] autorelease];
            
            
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
        cell.row = indexPath;
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        if (benqiboo) {
            cell.wangqibool = YES;
            
            if (matchType == MatchShengFuGuoGan) {
                if ([pkbet.matchLogo isEqualToString:@"足球"] || [pkbet.matchLogo isEqualToString:@"篮球"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                    cell.butTitle.text = @"析";
                }else{
                    [cell setButonImageArray:[NSMutableArray arrayWithCapacity:0] TitileArray:[NSMutableArray arrayWithCapacity:0]];
                    cell.butTitle.text = @"";
                    
                }
            }
            
            
        }else{
            cell.wangqibool = NO;
            if (matchType == MatchShengFuGuoGan) {
                if ([pkbet.matchLogo isEqualToString:@"足球"] || [pkbet.matchLogo isEqualToString:@"篮球"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
                    cell.butTitle.text = @"析  胆";
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",nil]];
                    cell.butTitle.text = @"胆";
                }
            }
            
        }
        
        
        pkbet.donghuarow = indexPath.row;
        
        cell.pkbetdata = pkbet;
        cell.count = indexPath;
        cell.delegate = self;
        
        
        return cell;
        
        
    }
    
    return nil;
}


#pragma mark celldelegate
- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index {
    
    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
    
    
    if (cell.butonScrollView.contentOffset.x > 0) {
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        NSLog(@"!666666666666666666666666666666");
        cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
        [UIView commitAnimations];
        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
        
        if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang) {
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
            
        }else if (matchType == MatchRangQiuShengPingFu){
            
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        }
    }
    
    
    if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"八方预测"]) {
        
        [MobClick event:@"event_goucai_xidan_bangfangyuce" label:@"北京单场"];
        
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
        
        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
        
        if (matchType == MatchShengFuGuoGan) {
            if ([be.matchLogo isEqualToString:@"篮球"]) {
                if (benqiboo == NO) {
                    
                    NSString * changhaostr = be.numzhou;
                    
                    if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                        NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                        neutrality.delegate = self;
                        [neutrality show];
                        [neutrality release];
                        return;
                    }
                }
                
                
                LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
                
                NSLog(@"%@", be.saishiid);
                sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
                [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
                [self.navigationController pushViewController:sachet animated:YES];
#endif
                [sachet release];
            }else if ([be.matchLogo isEqualToString:@"足球"]) {
                [self NewAroundViewShowFunc:be indexPath:jccell.row];
            }
        }else{
            [self NewAroundViewShowFunc:be indexPath:jccell.row];
        }
        
        
        
        
    }
    else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"胆"]) {
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
        if (be.dandan == YES) {
            be.dandan = NO;
            
        }else{
            
            be.dandan = YES;
            
            
        }
        //        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:be];
        [self returnBoolDan:be.dandan row:Index selctCell:cell];
        
        
    }
    
    
}


- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell{
    NSLog(@"danbool = %d", danbool);
    GC_JCBetCell * jccell = (GC_JCBetCell *)openCell;
    //    NSArray * allke = [kebianzidian allKeys];
    
    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
    
    labelch.text = @"串法";
    [zhushuDic removeAllObjects];
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    //    twoLabel.text = @"0";
    //    oneLabel.text = @"0";
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    fieldLable.text = @"场";
    pourLable.hidden = YES;
    twoLabel.hidden = YES;
    
    [chuantype removeAllObjects];
    addchuan = 0;
    
    //    [shedanArr replaceObjectAtIndex:num withObject:[NSNumber numberWithInteger:danbool]];
    
    GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
    
    
    if (matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan) {
        if (gcbe.selection1 == NO && gcbe.selection2 == NO && gcbe.selection3 == NO) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请在当前对阵中选择您看好的结果"];
            danbool = NO;
        }
    }else{
        NSInteger allbu = 0;
        for (int  k = 0; k < [gcbe.bufshuarr count]; k++) {
            NSString * bufzi = [gcbe.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                allbu++;
                break;
            }
            
        }
        
        
        if (allbu == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请在当前对阵中选择您看好的结果"];
            danbool = NO;
        }
        
    }
    
    gcbe.dandan = danbool;
    [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    //
    NSInteger coutt = 0;
    
    //
    //    for (GC_BetData * be in duixiangarr) {
    //        if (be.dandan) {
    //
    //            coutt++;
    //        }
    //    }
    
    for (int i = 0; i < [allcellarr count]; i++) {
        
        GC_BetData * be = [allcellarr objectAtIndex:i];
        if (be.dandan) {
            
            coutt++;
        }
        
        
    }
    
    NSInteger dancount = 0;
    if (matchType == MatchRangQiuShengPingFu) {
        dancount = 8;
    }else if(matchType == MatchJinQiuShu || matchType == MatchShangXiaDanShuang || matchType == matchBanQuanChang){
        dancount = 6;
    }else if (matchType == MatchBiFen){
        dancount = 3;
    }else if (matchType == MatchShengFuGuoGan){
        dancount = 15;
    }
    
    
    if (coutt >= dancount) {
        panduanbool = NO;
    }else if(coutt < dancount){
        panduanbool = YES;
    }
    
    if ( panduanbool == NO){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        if (matchType == MatchRangQiuShengPingFu) {
            [cai showMessage:@"最多可以设7个胆"];
        }else if(matchType == MatchJinQiuShu || matchType == MatchShangXiaDanShuang || matchType == matchBanQuanChang){
            [cai showMessage:@"最多可以设5个胆"];
        }else if (matchType == MatchBiFen){
            [cai showMessage:@"最多可以设2个胆"];
        }else if (matchType == MatchShengFuGuoGan){
            [cai showMessage:@"最多可以设14个胆"];
        }
        
    }
    panduanzhongjie = panduanbool;
    
    int oneCount = 2;
    BOOL pdbool = NO;
    if (matchType == MatchShengFuGuoGan) {
        
        oneCount = 1;
        if (coutt <= (one-oneCount) || (coutt == 1 && one - coutt > 1)) {
            pdbool = YES;
        }
    }else{
        if (coutt <= (one-oneCount) || (coutt == 1 && one - oneCount == 0)) {
            pdbool = YES;
        }
    }
    
    if (pdbool) {
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = YES;
                [arrkebian replaceObjectAtIndex:j withObject:be];
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        
    }else{
        
        
        if (danbool) {
            coutt+=1;
            if (coutt > one-oneCount && one > oneCount) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:[NSString stringWithFormat:@"当前只能设置(选择场次数-%d)个胆", oneCount]];
            }
            
            coutt-=1;
        }
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = NO;
                [arrkebian replaceObjectAtIndex:j withObject:be];
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        
        GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
        gcbe.dandan = NO;
        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
        
    }
    
    
    
    if (panduanbool == NO) {
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = NO;
                [arrkebian replaceObjectAtIndex:j withObject:be];
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        
        GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
        gcbe.dandan = NO;
        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    }
    
    if (matchType == MatchShengFuGuoGan) {
        
        if ((coutt == 1 && one == 3) || one < 3) {
            chuanButton1.enabled = NO;
            castButton.enabled = NO;
            castButton.alpha = 0.5;
            chuanButton1.alpha = 0.5;
            
        }else {
            
            
            castButton.enabled = YES;
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
            if (benqiboo) {
                castButton.enabled = NO;
                castButton.alpha = 0.5;
                //  chuanButton1.enabled = NO;
            }
            
        }
//        if (one >= 1) {
//            castButton.alpha = 1;
//            castButton.enabled = YES;
//        }
        
    }else{
        if (one == 1 && danbool == NO) {
            castButton.enabled = YES;
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
            UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            senbutton.tag = 1;
            
            senbutton.titleLabel.text = @"单关";
            
            [self pressChuanJiuGongGe:senbutton];
        }
    }
    
    
    [myTableView reloadData];
    
}

- (void)returncellrownum:(NSIndexPath *)num{
    [self deleteContentOff:@""];
    
    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
    
    GC_BetData * be = [duixiangarr objectAtIndex:num.row];
    if (matchType == MatchShengFuGuoGan) {
        if ([be.matchLogo isEqualToString:@"篮球"]) {
            if (benqiboo == NO) {
                
                NSString * changhaostr = be.numzhou;
                
                if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                    NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                    neutrality.delegate = self;
                    [neutrality show];
                    [neutrality release];
                    return;
                }
            }
            
            
            LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
            
            NSLog(@"%@", be.saishiid);
            sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
            [self.navigationController pushViewController:sachet animated:YES];
#endif
            [sachet release];
        }else if ([be.matchLogo isEqualToString:@"足球"]) {
            [self NewAroundViewShowFunc:be indexPath:num];
        }
    }else{
        [self NewAroundViewShowFunc:be indexPath:num];
        
    }
    
    
    
    //    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
    //
    //    GC_BetData * be = [duixiangarr objectAtIndex:num.row];
    //    if (benqiboo == NO) {
    ////        NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
    //        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
    //            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:be.bdnum] ;
    //            neutrality.delegate = self;
    //            [neutrality show];
    //            [neutrality release];
    //            return;
    //        }
    //    }
    
    //    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
    //
    //    NSLog(@"%@", be.saishiid);
    //    sachet.playID = be.saishiid;
    //#ifdef isCaiPiaoForIPad
    //    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
    //#else
    //    [self.navigationController pushViewController:sachet animated:YES];
    //#endif
    //
    //
    //    [sachet release];
    
}

- (void)calculateMoney{
    
    int zcount = 0;
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * pkb = [allcellarr objectAtIndex:j];
        for (int  k = 0; k < [pkb.bufshuarr count]; k++) {
            NSString * bufzi = [pkb.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                
                zcount += 1;
            }
            
        }
        
        
    }
    fieldLable.text = @"注";
    pourLable.hidden = NO;
    twoLabel.hidden = NO;
    //     }
    oneLabel.text = [NSString stringWithFormat:@"%d", zcount];
    twoLabel.text = [NSString stringWithFormat:@"%d", zcount*2];
    
    
}

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    
    
    
    
    NSMutableArray * beaar = [kebianzidian objectAtIndex:index.section];
    GC_BetData  * betbif = [beaar objectAtIndex:index.row];
    betbif.bufshuarr = bufshuzu;
    betbif.dandan = booldan;
    [beaar replaceObjectAtIndex:index.row withObject:betbif];
    
    twocount = two;
    onecont = one;
    two = 1;
    one = 0;
    [m_shedanArr removeAllObjects];
    
    NSInteger  buttoncout = 0;
    
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * pkb = [allcellarr objectAtIndex:j];
        for (int  k = 0; k < [pkb.bufshuarr count]; k++) {
            NSString * bufzi = [pkb.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                one++;
                buttoncout++;
                break;
            }
            
        }
        int gc = 0;
        for (int  m = 0; m < [pkb.bufshuarr count]; m++) {
            NSString * bufzi = [pkb.bufshuarr objectAtIndex:m];
            if ([bufzi isEqualToString:@"1"]) {
                gc += 1;
            }
        }
        
        if (gc != 0) {
            two = two *gc;
        }
        
        
        if (gc != 0) {
            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
        }
        
        
    }
    
    NSInteger allbu = 0;
    
    hasDanBool = NO;
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        
        for (int  k = 0; k < [bet.bufshuarr count]; k++) {
            NSString * bufzi = [bet.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                allbu++;
            }
            if (bet.dandan) {
                hasDanBool = YES;
            }
            
        }
        
    }
    NSInteger changcishu = 0;
    
    changcishu = 15;
    
    if (buttoncout > changcishu) {
        
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        
        [cai showMessage:@"不能超过15场"];
        //            oneLabel.text = @"15";
        one = 15;
        if ([oneLabel.text integerValue] > 15&& [fieldLable.text isEqualToString:@"场"]) {
            oneLabel.text = @"15";
        }
        
        
        NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
        GC_BetData * dabet = [daarray objectAtIndex:index.row];
        NSMutableArray * musarr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int  m = 0; m < [dabet.bufshuarr count]; m++) {
            [musarr addObject:@"0"];
            
            
        }
        
        
        dabet.bufshuarr = musarr;
        [daarray replaceObjectAtIndex:index.row withObject:dabet];
        [musarr release];
        //        [self calculateMoney];
        
        
        [myTableView reloadData];
        
        
        
        return;
    }
    
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    if (allbutcount != allbu) {
        labelch.text = @"串法";
        addchuan = 0;
        [zhushuDic removeAllObjects];
        [chuantype removeAllObjects];
        //        for (int i = 0; i < 160; i++) {
        //            buf[i] = 0;
        //        }
        
        
    }
    
    
    allbutcount = allbu;
    
    
    
    
    //如果再多选的话 清一下
    if (buttoncout > butcount) {
        labelch.text = @"串法";
        
        addchuan = 0;
        
        [zhushuDic removeAllObjects];
        //        for (int i = 0; i < 160; i++) {
        //            buf[i] = 0;
        //        }
        
        [chuantype removeAllObjects];
        
    }
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        BOOL bebool = NO;
        for ( int m = 0; m < [bet.bufshuarr count]; m++) {
            NSString * bufzi = [bet.bufshuarr objectAtIndex:m];
            if ([bufzi isEqualToString:@"1"]) {
                bebool = YES;
                break;
            }
        }
        if (bebool == NO) {
            
            
            bet.dandan = NO;
        }
        [allcellarr replaceObjectAtIndex:j withObject:bet];
        
    }
    butcount = buttoncout;
    
    if (one < 1 || (hasDanBool&& one == 1)) {
        chuanButton1.enabled = NO;
        castButton.enabled = NO;
        castButton.alpha = 0.5;
        chuanButton1.alpha = 0.5;
        
    }else {
        castButton.enabled = YES;
        chuanButton1.enabled = YES;
        castButton.alpha = 1;
        chuanButton1.alpha = 1;
        
    }
    
    if (one == 0) {
        labelch.text = @"串法";
        [chuantype removeAllObjects];
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
        [chuantype removeAllObjects];
    }
    
    
    //如果比以前少的话 清一下
    if (one < onecont || two < twocount) {
        labelch.text = @"串法";
        addchuan = 0;
        [chuantype removeAllObjects];
        [zhushuDic removeAllObjects];
        //        for (int i = 0; i < 160; i++) {
        //            buf[i] = 0;
        //        }
        
    }
    
    
    [self calculateMoney];
    if (one > 1) {
        
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * be = [allcellarr objectAtIndex:j];
            be.nengyong = YES;
            [allcellarr replaceObjectAtIndex:j withObject:be];
        }
        
    }
    
    [myTableView reloadData];
    NSInteger countmatch = 0;
    if (matchType == MatchBiFen) {
        countmatch = 3;
    }else{
        countmatch =4;
    }
    
    if (hasDanBool || one > countmatch) {
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        labelch.text = @"串法";
        [chuantype removeAllObjects];
        addchuan = 0;
        [chuantype removeAllObjects];
    }else{
        if (one > 0 && one <= countmatch) {
            UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            senbutton.tag = 1;
            if (one == 1) {
                senbutton.titleLabel.text = @"单关";
            }else{
                senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", one];
            }
            
            [self pressChuanJiuGongGe:senbutton];
        }
    }
    
    
    
    
    
}

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    
    
    
    
    
    
    
    
    
    NSMutableArray * daaa = [kebianzidian objectAtIndex:index.section];
    GC_BetData  * da = [daaa objectAtIndex:index.row];
    
    
    da.count = index.row;
    //    da.booldan1 = selection1;
    //    da.booldan2 = selection2;
    //    da.booldan3 = selection3;
    da.selection1 = selection1;
    da.selection2 = selection2;
    da.selection3 = selection3;
    da.booldan = booldan;
    [daaa replaceObjectAtIndex:index.row withObject:da];
    //   [kebianzidian setObject:daaa forKey:[[kebianzidian allKeys] objectAtIndex:index.section]];
    twocount = two;
    onecont = one;
    two = 1;
    one = 0;
    [m_shedanArr removeAllObjects];
    NSInteger  buttoncout = 0;
    
    
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * pkb = [allcellarr objectAtIndex:j];
        if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
            one++;
            buttoncout++;
            two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
            int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
            // NSString * string = [string stringByAppendingFormat:@"%d", gc];
            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
        }
        
        
    }
    //  }
    NSLog(@"aaa = %@", m_shedanArr);
    if (buttoncout > 15) {
        //  NSLog(@"aaaaaaaaaa");
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"不能超过15场"];
        one = 15;
        if ([oneLabel.text integerValue] > 15&& [fieldLable.text isEqualToString:@"场"]) {
            oneLabel.text = @"15";
        }
        
        //  NSString * indstr = [NSString stringWithFormat:@"%d", index];
        //   [self performSelector:@selector(dayushiwuchang) withObject:indstr afterDelay:1];
        
        //  for (int i = 15; i < [cellarray count]; i++) {
        
        NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
        GC_BetData * dabet = [daarray objectAtIndex:index.row];
        dabet.selection1 = NO;
        dabet.selection2 = NO;
        dabet.selection3 = NO;
        //   }
        
        [myTableView reloadData];
        return;
    }
    NSInteger allbu = 0;
    //    NSArray * keys = [kebianzidian allKeys];
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        
        if (bet.selection1) {
            allbu++;
        }
        if (bet.selection2) {
            allbu++;
        }
        if (bet.selection3) {
            allbu++;
        }
        
        //        bet.dandan = NO;
        //
        //        [cellarray replaceObjectAtIndex:i withObject:bet];
    }
    // }
    
    if (allbutcount != allbu) {
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
        [chuantype removeAllObjects];
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
        //            for (int j = 0; j < [allcellarr count]; j++) {
        //                GC_BetData * bet = [allcellarr objectAtIndex:j];
        //                bet.dandan = NO;
        //
        //                [allcellarr replaceObjectAtIndex:j withObject:bet];
        //            }
        
        
    }
    
    
    allbutcount = allbu;
    
    
    //如果再多选的话 清一下
    if (buttoncout > butcount) {
        labelch.text = @"串法";
        //        twoLabel.text = @"0";
        //        oneLabel.text = @"0";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        [chuantype removeAllObjects];
        addchuan = 0;
        
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        //            for (int j = 0; j < [allcellarr count]; j++) {
        //                GC_BetData * bet = [allcellarr objectAtIndex:j];
        //                bet.dandan = NO;
        //
        //                [allcellarr replaceObjectAtIndex:j withObject:bet];
        //            }
        
        // [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
        //  }
        
    }
    NSLog(@"two = %d", two);
    //   oneLabel.text = [NSString stringWithFormat:@"%d", one];
    //    int beishu = [beiShuLabel.text longLongValue]/([zhuShuLabel.text longLongValue]*2);
    
    //   twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    
    
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
    hasDanBool = NO;
    NSInteger dancountx = 0;
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
            
            
            bet.dandan = NO;
        }else{
            if (bet.dandan) {
                dancountx+=1;
            }
        }
        if (bet.dandan) {
            hasDanBool = YES;
        }
        
        [allcellarr replaceObjectAtIndex:j withObject:bet];
        
    }
    //    [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
    //}
    
    butcount = buttoncout;
    //    if (one < 2) {
    //        chuanButton1.enabled = NO;
    //        castButton.enabled = NO;
    //
    //    }else {
    //        castButton.enabled = YES;
    //        chuanButton1.enabled = YES;
    //    }
    //    if (one == 0) {
    //        labelch.text = @"串法";
    //        twoLabel.text = @"0";
    //        oneLabel.text = @"0";
    //        addchuan = 0;
    //    }
    int matchCount = 0;
    BOOL pdbool = NO;
    if (matchType == MatchShengFuGuoGan) {
        matchCount = 3;
        if (one < matchCount || (one == 3 && dancountx == 1)) {
            pdbool = YES;
        }
    }else{
        matchCount = 1;
        if (one < matchCount ) {
            pdbool = YES;
        }
    }
    
    
    
    if (pdbool) {
        chuanButton1.enabled = NO;
        castButton.enabled = NO;
        castButton.alpha = 0.5;
        chuanButton1.alpha = 0.5;
        
    }else {
        
        
        castButton.enabled = YES;
        chuanButton1.enabled = YES;
        castButton.alpha = 1;
        chuanButton1.alpha = 1;
        if (benqiboo) {
            castButton.enabled = NO;
            castButton.alpha = 0.5;
            //  chuanButton1.enabled = NO;
        }
        
    }
    
//    if (matchType == MatchShengFuGuoGan) {
//        if (one >= 1) {
//            castButton.enabled = YES;
//            castButton.alpha = 1;
//            
//        }
//    }
    
    if (matchType == MatchShengFuGuoGan) {
        if (one < 3 || (one == 3 && dancountx == 1)) {
            labelch.text = @"串法";
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
            addchuan = 0;
        }
    }else{
        if (one == 0) {
            labelch.text = @"串法";
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
            addchuan = 0;
        }
    }
    
    
    
    //如果比以前少的话 清一下
    if (one < onecont || two < twocount) {
        labelch.text = @"串法";
        //        twoLabel.text = @"0";
        //        oneLabel.text = @"0";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        [chuantype removeAllObjects];
        addchuan = 0;
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        //            for (int j = 0; j < [allcellarr count]; j++) {
        //
        //                GC_BetData * bet = [allcellarr objectAtIndex:j];
        //                bet.dandan = NO;
        //
        //                [allcellarr replaceObjectAtIndex:j withObject:bet];
        //            }
        // [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
    }
    // }
    [myTableView reloadData];
    
    if (hasDanBool || one > 4) {
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
        [chuantype removeAllObjects];
    }else{
        int oneCount = 0;
        if (matchType == MatchShengFuGuoGan) {
            oneCount = 2;
        }else{
            oneCount = 0;
        }
        if (one > oneCount && one < 5) {
            
            UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            senbutton.tag = 1;
            if (one == 1) {
                senbutton.titleLabel.text = @"单关";
            }else{
                senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", one];
            }
            
            [self pressChuanJiuGongGe:senbutton];
        }
    }
    
    
}

- (void)sfmatchFunc{
    
    if (matchType == MatchShengFuGuoGan) {
        for (int i = 0; i < [sfMatchArray count]; i++) {
            NSInteger macthcount = 0;
            for (int  j = 0; j < [allcellarr count]; j++) {
                
                GC_BetData * begc = [allcellarr objectAtIndex:j];
                if ([begc.matchLogo isEqualToString:[sfMatchArray objectAtIndex:i]]) {
                    macthcount+=1;
                }
                
            }
            [sfMatchArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@(%ld场)", [sfMatchArray objectAtIndex:i], (long)macthcount]];
        }
    }
}

-(void)requestSuccess:(ASIHTTPRequest*)mrequest {
    NSDictionary *dic = [mrequest userInfo];
    NSLog(@"dic = %@", dic);
    NSString *obj;
    obj = [dic objectForKey:@"key"];
    NSLog(@"obj = %@", obj);
    NSData *responseData = [mrequest responseData];
    
    if (responseData) {
        if (obj&&[obj isEqualToString:@"issue"]) {  // 期号项
            GC_JiangCaiIssue *issue = [[GC_JiangCaiIssue alloc] initWithResponseData:responseData WithRequest:mrequest];
            if (issue) {
                for (NSString * is in issue.issueData) {
                    NSString * stris = is;
                    NSLog(@"issue = %@", stris);
                    [qihaoArray addObject:stris];
                    
                }
                
                //                issueComboBox.popUpBoxDatasource = issue.issueData;
                //                [issueComboBox.popUpBoxTableView reloadData];
                //                issueComboBox.textField.text = [issue.issueData objectAtIndex:0];
            }
            [issue  release];
            self.issString = [qihaoArray objectAtIndex:0];//暂时
            //  [self requestBeiDanSaiShi];//赛事
        }else if(obj&&[obj isEqualToString:@"match"]){// 赛事选择项
            GC_JiangCaiMatch *match  = [[GC_JiangCaiMatch alloc] initWithResponseData:responseData WithRequest:mrequest];
            if (match) {
                //                matchComboBox.popUpBoxDatasource = match.matchList;
                //                [matchComboBox.popUpBoxTableView  reloadData];
                //                NSString *initDatas = [match.matchList objectAtIndex:0];
                //                matchComboBox.textField.text = initDatas;
                for (NSString * st in match.matchList) {
                    NSString * stri = st;
                    NSLog(@"stri = %@", stri);
                    
                    
                    NSString * saishi = [stri stringByReplacingOccurrencesOfString:@" " withString:@""];
                    [saishiArray addObject:saishi];
                    
                }
            }
            
            [self  requestBeiJingDanChangDuiZhen];//对阵
            
            timeopen = [NSTimer scheduledTimerWithTimeInterval:150 target:self selector:@selector(requestBeiJingDanChangDuiZhen) userInfo:nil repeats:YES];
            
            [timeopen fire];
            [match release];
        }else if(obj&&[obj isEqualToString:@"duizhen"]){// 对阵列表
            
            GC_JingCaiDuizhenChaXun *duizhen = [[GC_JingCaiDuizhenChaXun alloc] initWithResponseData:responseData WithRequest:mrequest];
            self.sysTimeSave = duizhen.sysTimeString;
            if(duizhen.returnId == 3000){
                [duizhen release];
                return;
            }
            if (duizhen&&duizhen.count == 0) {
                [kebianzidian removeAllObjects];
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"赛程更新中，请稍后再试"];
                
                
                if (!recordImage) {
                    recordImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.mainView.frame.size.width - 97)/2, (self.mainView.frame.size.height - 97)/2 - 60, 97, 97)];
                    recordImage.backgroundColor = [UIColor clearColor];
                    recordImage.image = UIImageGetImageFromName(@"zaiwubisaiimage.png");
                    [self.mainView addSubview:recordImage];
                    [recordImage release];
                    
                }
                
                if (!recordLabel) {
                    recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.mainView.frame.size.height - 97)/2 - 60 + 97 + 10, self.mainView.frame.size.width, 20)];
                    recordLabel.backgroundColor = [UIColor clearColor];
                    recordLabel.font = [UIFont systemFontOfSize:16];
                    recordLabel.text = @"暂无比赛信息";
                    recordLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    recordLabel.textAlignment = NSTextAlignmentCenter;
                    [self.mainView addSubview:recordLabel];
                    [recordLabel release];
                }
                recordImage.hidden = NO;
                recordLabel.hidden = NO;
                myTableView.hidden = YES;
                //                upimageview.hidden = YES;
                
                
                [myTableView reloadData];
            }else{
                recordImage.hidden = YES;
                recordLabel.hidden = YES;
                myTableView.hidden = NO;
                //                upimageview.hidden = NO;
            }
            
            if (duizhen.count > 0 && [duizhen.listData count] == 0) {
                
                if (countjishuqi < 3) {
                    countjishuqi += 1;
                    [self getIssueListRequest];
                    
                }else{
                    countjishuqi = 0;
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"网络原因，请稍后再试"];
                    [myTableView reloadData];
                }
                [duizhen release];
                return;
            }
            if (duizhen&&duizhen.listData) {
                self.resultList = duizhen.listData;
                // mTableView.hidden = NO;
                // [mTableView reloadData];
                if (timebool) {
                    NSMutableArray * peiarray = [[NSMutableArray alloc] initWithCapacity:0];
                    for (GC_JingCaiDuizhenResult * gc in self.resultList) {
                        GC_BetData * be = [[GC_BetData alloc] init];
                        if ([gc.odds length] > 1) {
                            
                            
                            
                            
                            if (matchType == MatchJinQiuShu || matchType == MatchShangXiaDanShuang || matchType == matchBanQuanChang || matchType == MatchBiFen) {
                                NSArray * butarray = [gc.odds componentsSeparatedByString:@","];
                                
                                NSMutableArray * jianArr = [[NSMutableArray alloc] initWithCapacity:0];
                                NSMutableArray * ouprarr = [[NSMutableArray alloc] initWithCapacity:0];
                                for (int i = 0; i < [butarray count]; i++) {
                                    NSString * peistr1 = [butarray  objectAtIndex:i];
                                    
                                    NSRange rangeLeft = [peistr1 rangeOfString:@"a"];
                                    NSRange rangecur = [peistr1 rangeOfString:@"d"];
                                    
                                    if (rangeLeft.location != NSNotFound) {
                                        [jianArr addObject:@"1"];
                                        peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                        [ouprarr addObject:peistr1];
                                    }else if (rangecur.location != NSNotFound){
                                        [jianArr addObject:@"2"];
                                        peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                        [ouprarr addObject:peistr1];
                                    }else{
                                        [jianArr addObject:@"3"];
                                        [ouprarr addObject:peistr1];
                                    }
                                    
                                }
                                be.oupeiarr = ouprarr;
                                be.jiantouArray = jianArr;
                                [ouprarr release];
                                [jianArr release];
                            }else{
                                
                                NSArray * butarray = [gc.odds componentsSeparatedByString:@","];
                                if (butarray.count < 2) {
                                    butarray = [NSArray arrayWithObjects:@"",@"", nil];
                                }
                                NSString * peistr1 = [butarray objectAtIndex:0];
                                NSString * peistr2 = [butarray objectAtIndex:1];
                                NSString * peistr3 = @"";
                                if (matchType != MatchShengFuGuoGan) {
                                    if (butarray.count < 3) {
                                        butarray = [NSArray arrayWithObjects:@"",@"",@"", nil];
                                    }
                                    peistr3 = [butarray objectAtIndex:2];
                                }
                                
                                
                                NSRange rangeLeft = [peistr1 rangeOfString:@"a"];
                                NSRange rangecur = [peistr1 rangeOfString:@"d"];
                                if (rangeLeft.location != NSNotFound) {
                                    be.xianshi1 = @"1";
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                }else if(rangecur.location != NSNotFound){
                                    be.xianshi1 = @"2";
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                }else{
                                    be.xianshi1 = @"3";
                                }
                                
                                NSRange rangeLeft2 = [peistr2 rangeOfString:@"a"];
                                NSRange rangecur2 = [peistr2 rangeOfString:@"d"];
                                if (rangeLeft2.location != NSNotFound) {
                                    be.xianshi2 = @"1";
                                    peistr2 = [peistr2 substringToIndex:[peistr2 length] - 1];
                                }else if(rangecur2.location != NSNotFound){
                                    be.xianshi2 = @"2";
                                    peistr2 = [peistr2 substringToIndex:[peistr2 length] - 1];
                                }else{
                                    be.xianshi2 = @"3";
                                }
                                
                                NSRange rangeLeft3 = [peistr3 rangeOfString:@"a"];
                                NSRange rangecur3 = [peistr3 rangeOfString:@"d"];
                                if (rangeLeft3.location != NSNotFound) {
                                    be.xianshi3 = @"1";
                                    peistr3 = [peistr3 substringToIndex:[peistr3 length] - 1];
                                }else if(rangecur3.location != NSNotFound){
                                    be.xianshi3 = @"2";
                                    peistr3 = [peistr3 substringToIndex:[peistr3 length] - 1];
                                }else{
                                    be.xianshi3 = @"3";
                                }
                                
                                NSLog(@"perstr = %@   %@    %@", peistr1, peistr2, peistr3);
                                be.but1 = peistr1;
                                // NSLog(@"but = %@", betdata.but1);
                                be.but2 = peistr2;
                                be.but3 = peistr3;
                                
                            }
                            
                            
                        }
                        [peiarray addObject:be];
                        [be release];
                    }
                    
                    for (int i = 0; i < [allcellarr count]; i++) {
                        GC_BetData * cellbet = [allcellarr objectAtIndex:i];
                        if (i < [peiarray count]) {
                            GC_BetData * peibet = [peiarray objectAtIndex:i];
                            cellbet.xianshi1 = peibet.xianshi1;
                            cellbet.xianshi2 = peibet.xianshi2;
                            cellbet.xianshi3 = peibet.xianshi3;
                            cellbet.but1 = peibet.but1;
                            cellbet.but2 = peibet.but2;
                            cellbet.but3 = peibet.but3;
                            cellbet.oupeiarr = peibet.oupeiarr;
                            cellbet.jiantouArray = peibet.jiantouArray;
                        }
                        [allcellarr replaceObjectAtIndex:i withObject:cellbet];
                    }
                    
                    [peiarray release];
                }else{
                    [cellarray removeAllObjects];
                    [allcellarr removeAllObjects];
                    for (GC_JingCaiDuizhenResult * gc in self.resultList) {
                        GC_BetData * be = [[GC_BetData alloc] init];
                        be.event = gc.match;
                        NSLog(@"be.event = %@", gc.match);
                        NSArray * timedata = [gc.deathLineTime componentsSeparatedByString:@" "];
                        if (timedata.count < 2) {
                            timedata = [NSArray arrayWithObjects:@"",@"", nil];
                        }
                        be.date = [timedata objectAtIndex:0];
                        be.time = [timedata objectAtIndex:1];
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", gc.homeTeam,gc.vistorTeam, gc.rangQiu];
                        be.saishiid = gc.bicaiid;
                        be.bifen = gc.score;
                        be.caiguo = gc.lotteryResult;
                        be.oupeiPeilv = gc.europeOdds;
                        be.numzhou = gc.bdzhouji;//num
                        be.bdnum = gc.num;
                        NSArray * nutimearr = [gc.datetime componentsSeparatedByString:@" "];
                        be.numtime = [nutimearr objectAtIndex:0];
                        be.changhao = gc.matchId;
                        be.numbermatch = gc.num;
                        be.matchLogo = gc.zhongzu;
                        be.zlcString = gc.macthType;
                        be.datetime = gc.datetime;
                        be.timeSort = gc.macthTime;
                        //                        be.zlcString = @"-True";
                        NSMutableArray * arrayButton = [[NSMutableArray alloc] initWithCapacity:0];
                        NSArray * buttonType = nil;
                        if (matchType == MatchJinQiuShu) {
                            buttonType = [NSArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
                        }else if (matchType == MatchShangXiaDanShuang){
                            buttonType = [NSArray arrayWithObjects:@"0", @"0",@"0",@"0", nil];
                        }else if (matchType == matchBanQuanChang){
                            buttonType = [NSArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
                        }else if (matchType == MatchBiFen){
                            buttonType = [NSArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
                        }
                        [arrayButton addObjectsFromArray:buttonType];
                        be.bufshuarr = arrayButton;
                        [arrayButton release];
                        NSLog(@"id = %@", gc.bicaiid);
                        
                        if (matchType == MatchBiFen||matchType == MatchJinQiuShu||matchType == MatchShangXiaDanShuang || matchType == matchBanQuanChang) {
                            
                            
                            NSArray * butarray = [gc.odds componentsSeparatedByString:@","];
                            
                            NSMutableArray * jianArr = [[NSMutableArray alloc] initWithCapacity:0];
                            NSMutableArray * ouprarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int i = 0; i < [butarray count]; i++) {
                                NSString * peistr1 = [butarray  objectAtIndex:i];
                                
                                NSRange rangeLeft = [peistr1 rangeOfString:@"a"];
                                NSRange rangecur = [peistr1 rangeOfString:@"d"];
                                
                                if (rangeLeft.location != NSNotFound) {
                                    [jianArr addObject:@"1"];
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                    [ouprarr addObject:peistr1];
                                }else if (rangecur.location != NSNotFound){
                                    [jianArr addObject:@"2"];
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                    [ouprarr addObject:peistr1];
                                }else{
                                    [jianArr addObject:@"3"];
                                    [ouprarr addObject:peistr1];
                                }
                                
                            }
                            
                            be.oupeiarr = ouprarr;
                            
                            //                            be.oupeiarr = buttonType;//测试 假数据
                            
                            be.jiantouArray = jianArr;
                            [ouprarr release];
                            [jianArr release];
                            
                            
                            
                        }else if(matchType == MatchRangQiuShengPingFu || matchType == MatchShengFuGuoGan){
                            if ([gc.odds length] > 1) {
                                
                                NSArray * butarray = [gc.odds componentsSeparatedByString:@","];
                                NSLog(@"buarr = %@", butarray);
                                NSString * peistr1 = @"";
                                NSString * peistr2 = @"";
                                NSString * peistr3 = @"";
                                if ([butarray count] >= 2) {
                                    peistr1 = [butarray objectAtIndex:0];
                                    peistr2 = [butarray objectAtIndex:1];
                                    if (matchType != MatchShengFuGuoGan) {
                                        peistr3 = [butarray objectAtIndex:2];
                                    }
                                    
                                }
                                
                                
                                NSRange rangeLeft = [peistr1 rangeOfString:@"a"];
                                NSRange rangecur = [peistr1 rangeOfString:@"d"];
                                if (rangeLeft.location != NSNotFound) {
                                    be.xianshi1 = @"1";
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                }else if(rangecur.location != NSNotFound){
                                    be.xianshi1 = @"2";
                                    peistr1 = [peistr1 substringToIndex:[peistr1 length] - 1];
                                }else{
                                    be.xianshi1 = @"3";
                                }
                                
                                NSRange rangeLeft2 = [peistr2 rangeOfString:@"a"];
                                NSRange rangecur2 = [peistr2 rangeOfString:@"d"];
                                if (rangeLeft2.location != NSNotFound) {
                                    be.xianshi2 = @"1";
                                    peistr2 = [peistr2 substringToIndex:[peistr2 length] - 1];
                                }else if(rangecur2.location != NSNotFound){
                                    be.xianshi2 = @"2";
                                    peistr2 = [peistr2 substringToIndex:[peistr2 length] - 1];
                                }else{
                                    be.xianshi2 = @"3";
                                }
                                
                                NSRange rangeLeft3 = [peistr3 rangeOfString:@"a"];
                                NSRange rangecur3 = [peistr3 rangeOfString:@"d"];
                                if (rangeLeft3.location != NSNotFound) {
                                    be.xianshi3 = @"1";
                                    peistr3 = [peistr3 substringToIndex:[peistr3 length] - 1];
                                }else if(rangecur3.location != NSNotFound){
                                    be.xianshi3 = @"2";
                                    peistr3 = [peistr3 substringToIndex:[peistr3 length] - 1];
                                }else{
                                    be.xianshi3 = @"3";
                                }
                                
                                NSLog(@"perstr = %@   %@    %@", peistr1, peistr2, peistr3);
                                be.but1 = peistr1;
                                // NSLog(@"but = %@", betdata.but1);
                                be.but2 = peistr2;
                                be.but3 = peistr3;
                            }
                            
                        }
                        
                        
                        be.bdzhou = gc.bdzhouji;
                        
                        NSLog(@"saishi = %@", gc.match);
                        NSLog(@"zhu dui = %@", gc.homeTeam);
                        NSLog(@"ke dui = %@", gc.vistorTeam);
                        NSLog(@"shijian = %@", gc.deathLineTime);
                        NSLog(@"ou pei = %@", gc.odds);
                        // [cellarray addObject:be];
                        [allcellarr addObject:be];
                        [be release];
                        
                        
                        
                        
                        timebool = YES;
                    }
                    
                    
                    
                }
                [kebianzidian removeAllObjects];
                [saishiArray removeAllObjects];
                [sfMatchArray removeAllObjects];
                
                GC_BetData * betda = [allcellarr objectAtIndex:0];
                
                
                NSString * saishi = [betda.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                [saishiArray addObject:saishi];
                if (matchType == MatchShengFuGuoGan) {//添加比赛类型
                    //                     [sfMatchArray addObject:@"足球(1)"];
                    [sfMatchArray addObject:betda.matchLogo];
                }
                
                
                for (int i = 0; i < [allcellarr count]; i++) {
                    BOOL xiangtong = NO;
                    BOOL macthBool = NO;
                    GC_BetData * begc = [allcellarr objectAtIndex:i];
                    
                    if (matchType == MatchShengFuGuoGan) {
                        for (int j = 0; j < [sfMatchArray count]; j++) {
                            
                            NSString * macth1 = [sfMatchArray objectAtIndex:j];
                            NSString * macth2 = begc.matchLogo;
                            if ([macth1 isEqualToString:macth2]) {
                                macthBool = YES;
                            }
                            
                        }
                        
                        if ( macthBool != YES) {
                            [sfMatchArray addObject:begc.matchLogo];
                        }
                    }else{
                        for (int j = 0; j < [saishiArray count]; j++) {
                            
                            NSString * sai = [saishiArray objectAtIndex:j];
                            NSString * saishi1 = [begc.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            NSString * saishi2 = [sai stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if ([saishi1 isEqualToString:saishi2]) {
                                xiangtong = YES;
                            }
                            
                            
                        }
                        if (xiangtong != YES) {
                            NSString * saishi = [begc.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            [saishiArray addObject:saishi];
                        }
                        
                    }
                    
                    
                    
                    
                    
                }
                
                [self sfmatchFunc];
                
                
                [self shaixuanzidian:allcellarr];
                
                if (chaocount == 0) {
                    if (chaodanbool) {
                        [self chaodanshuzu];
                    }
                }
                chaocount++;
                
                //      [self pressQingButton];
                
                if ([kebianzidian count] > 1) {
                    NSMutableArray * mutarr = [kebianzidian objectAtIndex:0];
                    if ([mutarr count] <= 4 ) {
                        buffer[1] = 1;
                    }
                }
                [myTableView reloadData];
                
                
                
            }else{
                [self.resultList removeAllObjects];
                [cellarray removeAllObjects];
                [allcellarr removeAllObjects];
                [myTableView reloadData];
            }
            [saishiArray removeAllObjects];
            
            BOOL bijiaobool;
            for (int i = 0; i < [self.resultList count]; i++) {
                bijiaobool = NO;
                GC_JingCaiDuizhenResult * be = [self.resultList objectAtIndex:i];
                NSLog(@"math = %@", be.match);
                for (int j = 0; j < [saishiArray count]; j++) {
                    NSString * saishi1 = [[saishiArray objectAtIndex:j] stringByReplacingOccurrencesOfString:@" " withString:@""];
                    NSString * saishi2 = [be.match stringByReplacingOccurrencesOfString:@" " withString:@""];
                    if ([saishi1 isEqualToString:saishi2]) {
                        bijiaobool = YES;
                    }
                }
                if (bijiaobool == NO) {
                    if (matchType == MatchShengFuGuoGan) {
                        
                        //                        [saishiArray addObject:@"xxxx"];
                        
                        if ([be.zhongzu isEqualToString:@"足球"]) {
                            NSString * saishi = [be.match stringByReplacingOccurrencesOfString:@" " withString:@""];
                            [saishiArray addObject:saishi];
                        }
                    }else{
                        NSString * saishi = [be.match stringByReplacingOccurrencesOfString:@" " withString:@""];
                        [saishiArray addObject:saishi];
                    }
                    
                    
                }
            }
            if ([saishiArray count] == 1) {
                [saishiArray removeAllObjects];
            }
            
            
            [duizhen release];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestBeiJingDanChangDuiZhen150) object:nil];
            if (benqiboo == NO) {
                [self performSelector:@selector(requestBeiJingDanChangDuiZhen150) withObject:nil afterDelay:150];
            }
            
            if (matchType == MatchShengFuGuoGan) {
                [self shengFuGuoGanScreenFunc:shengfuTypeArray];//胜负过关的赛事筛选
            }
            
        }
        
        
        
        
    }else{
        
        [self requestHttpQingqiu];
    }
    
    
    //请求对阵
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    
    if (request150Bool == NO) {
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
                if (matchType == MatchShengFuGuoGan) {
                    for (int i = 0; i < [ sfIssueArray count]; i++) {
                        IssueDetail * detail = [sfIssueArray objectAtIndex:i];
                        if ([detail.issue isEqualToString:issString]) {
                            xcont = i;
                            break;
                        }
                    }
                    IssueDetail * isdetail = [sfIssueArray objectAtIndex:xcont];
                    
                    if (![isdetail.status isEqualToString:@"1"]) {
                        [self clearSaveFunc];
                        return;
                    }
                }else{
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
    
    
    
    
    
    
}

//北单期号
- (void)getIssueListRequest
{
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    //    NSInteger issueType = 1;
    //    if (matchType == MatchShengFuGuoGan) {
    //        issueType = 2;
    //    }
    NSMutableData *postData = [[GC_HttpService sharedInstance] beiDanreqGetZucaiJingcaiIssueList:2];
    
    NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest setRequestMethod:@"POST"];
    [httprequest addCommHeaders];
    [httprequest setPostBody:postData];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(reqIssueListFinished:)];
    [httprequest startAsynchronous];
}

- (void)reqIssueListFinished:(ASIHTTPRequest*)_request
{
    
    if ([_request responseData]) {
        GC_IssueList *issuelist = [[GC_IssueList alloc] initWithResponseData:[_request responseData] WithRequest:_request];
        qihaoArray = issuelist.details;
        NSLog(@"%@", issuelist.details);
        if (issuelist.details.count > 0) {
            [issueTypeArray removeAllObjects];
            [sfIssueArray removeAllObjects];
            for (IssueDetail *_detail in issuelist.details) {
                
                if ([issueTypeArray count] < 6) {
                    [issueTypeArray addObject:_detail];
                }
                
                
                
                
                if (![_detail.status isEqualToString:@"1"]) {//如果不是当前期的 清一下缓存
                    
                    
                    NSString * keystring = [NSString stringWithFormat:@"400%@", _detail.issue];
                    
                    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
                    [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:keystring];
                    [saveArray release];
                }
                
                
                NSLog(@"issue = %@", _detail.issue);
                NSLog(@"id = %@", _detail.stopTime);
                NSLog(@"idsd = %@", _detail.status);
            }
            
            for (IssueDetail *_detail in issuelist.sfDetails ) {
                if ([sfIssueArray count] < 6) {
                    if ([_detail.status isEqualToString:@"1"]) {
                        self.issString = _detail.issue;
                    }
                    [sfIssueArray addObject:_detail];
                }
            }
            
            
            
            
            if (!issString||[issString isEqualToString:@""]||[issString isEqualToString:@"null"]||[issString length]==0||self.issString == nil||![issString isAllNumber]|| matchType == MatchShengFuGuoGan) {
                
                IssueDetail * detail = [issueTypeArray objectAtIndex:0];
                
                //                if (matchType == MatchShengFuGuoGan) {
                //                    detail = [sfIssueArray objectAtIndex:0];
                //                    self.sfissueString = detail.issue;
                //
                //                }else{
                //                    self.qtissueString = detail.issue;
                //
                //                }
                
                
                
                NSString * issueStr = @"";
                if (matchType == MatchShengFuGuoGan) {
                    self.qtissueString = detail.issue;
                    detail = [sfIssueArray objectAtIndex:0];
                    self.sfissueString = detail.issue;
                    issueStr = detail.issue;
                    
                }else{
                    issueStr = detail.issue;
                    self.qtissueString = detail.issue;
                    detail = [sfIssueArray objectAtIndex:0];
                    self.sfissueString = detail.issue;
                    
                }
                
                self.issString = issueStr;
                
                [self requestBeiJingDanChangDuiZhen];
                if (![detail.status isEqualToString:@"1"]) {
                    benqiboo = YES;
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"本期不能购买"];
                    [myTableView reloadData];
                    //  castButton.enabled = NO;
                }else{
                    benqiboo = NO;
                }
                
            }else{
                //  castButton.enabled = YES;
                [self requestBeiJingDanChangDuiZhen];//传入期次 要传当前期 如果没有的话 就传最近预售期
            }
            
            
        }
        //  [self requestBeiDanSaiShi];//赛事
        [issuelist release];
    }else{
        
        [self getIssueListRequest];
    }
    if (matchType == MatchRangQiuShengPingFu) {
        titleLabel.text = [NSString stringWithFormat:@"让球胜平负%@期", issString];
    }else if (matchType == MatchJinQiuShu){
        titleLabel.text = [NSString stringWithFormat:@"进球数%@期", issString];
    }else if(matchType == MatchShangXiaDanShuang){
        titleLabel.text = [NSString stringWithFormat:@"上下单双%@期", issString];
    }else if (matchType == MatchBiFen){
        titleLabel.text = [NSString stringWithFormat:@"比分%@期", issString];
    }else if (matchType == matchBanQuanChang){
        titleLabel.text = [NSString stringWithFormat:@"半全场胜平负%@期", issString];
    }else if (matchType == MatchShengFuGuoGan){
        
        titleLabel.text = [NSString stringWithFormat:@"胜负过关%@期", issString];
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 9.5, 17, 17);
}




- (NSInteger)playNameIDNo{
    
    if (matchType == MatchRangQiuShengPingFu) {
        return 5;
    }else if (matchType == MatchJinQiuShu){
        return 7;
    }else if (matchType == MatchShangXiaDanShuang){
        return 6;
    }else if (matchType == MatchBiFen){
        return 9;
    }else if (matchType == matchBanQuanChang){
        return 8;
        
    }else if (matchType == MatchShengFuGuoGan){
        return 10;
    }
    return 0;
}


//北单对阵
- (void)requestBeiJingDanChangDuiZhen{
    //issString = @"2070";
    request150Bool = NO;
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSLog(@"isstring = %@", issString);
    [httprequest clearDelegatesAndCancel];
    
    
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] reBeiJingDanChangLotteryType:2 wanfa:[self playNameIDNo] isStop:@"-" match:@"-" issue:issString];
    self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest addCommHeaders];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest appendPostData:postData];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest setDidFailSelector:@selector(requestFailed:)];
    [httprequest startAsynchronous];
    
    
}

- (void)requestBeiJingDanChangDuiZhen150{
    request150Bool = YES;
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSLog(@"isstring = %@", issString);
    [httprequest150 clearDelegatesAndCancel];
    
    
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] reBeiJingDanChangLotteryType:2 wanfa:[self playNameIDNo] isStop:@"-" match:@"-" issue:issString];
    self.httprequest150 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest150 addCommHeaders];
    [httprequest150 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest150 appendPostData:postData];
    [httprequest150 setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [httprequest150 setDelegate:self];
    [httprequest150 setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest150 setDidFailSelector:@selector(requestFailed:)];
    [httprequest150 startAsynchronous];
    
    
}



//查询 这个比赛和期数的比赛信息
- (void)sendRequest:(NSString*)isEnded match:(NSString*)match chaxunQiShu:(NSString*)qishu
{
    [httprequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] jingcaiDuizhenChaXun:1 wanfa:(int)lotteryID isEnded:isEnded macth:match chaXunQiShu:qishu danOrGuo:@"gg"];
    self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest addCommHeaders];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest appendPostData:postData];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest startAsynchronous];
}


- (void)deleteContentOff:(NSString *)equal{
    
    NSArray * keys = [ContentOffDict allKeys];
    if (keys > 0) {
        for (NSString * keyStr in keys) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            if (strarr.count > 1) {
                NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
                
                if (![keyStr isEqualToString:equal]) {
                    [UIView beginAnimations:@"ndd" context:NULL];
                    [UIView setAnimationDuration:.3];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
                    cell2.butonScrollView.contentOffset = CGPointMake(0, cell2.butonScrollView.contentOffset.y);
                    [UIView commitAnimations];
                    
                    
                    GC_BJdcCell * jccell = (GC_BJdcCell *)cell2;
                    if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang) {
                        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
                    }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
                        jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                        
                    }else if (matchType == MatchRangQiuShengPingFu){
                        
                        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
                    }else if (matchType == MatchShengFuGuoGan) {
                        
                    }
                }

            }
            
            
        }
        [ContentOffDict removeAllObjects];
    }
    
}
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn{
    
    //    [ContentOffArray addObject:index];
    
    NSString * str = [NSString stringWithFormat:@"%ld %ld", (long)index.section, (long)index.row];
    if (yn == NO) {
        [self deleteContentOff:str];
        [ContentOffDict setObject:@"1" forKey:str];
        
    }else{
        [ContentOffDict removeObjectForKey:str];
    }
    
    
    
}

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
        
        GC_BJdcCell * jccell = (GC_BJdcCell *)cell;
        if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        }else if (matchType == MatchShangXiaDanShuang|| matchType == MatchBiFen ){
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
            
        }else if (matchType == MatchRangQiuShengPingFu){
            
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        }else if (matchType == MatchShengFuGuoGan){
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
            
        }
        
        //            }
        //            return;
    }else{
        [self performSelector:@selector(sleepOpenCell:) withObject:cell afterDelay:0.1];
    }
    return;
    
}

- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
    
//    if (matchType == MatchRangQiuShengPingFu||matchType == MatchShengFuGuoGan) {
//        if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//            xcount = 35+ ([cell.allTitleArray count]-1)*70;
//        }else {
//            xcount =[cell.allTitleArray count]*70;
//            
//        }
//    }else{
        xcount =[cell.allTitleArray count]*70;
//    }
    
    
    NSLog(@"!11111111111111111");
    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
    [UIView commitAnimations];
    
    GC_BJdcCell * jccell = (GC_BJdcCell *)cell;
    
    if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"dakaixidanimage.png");
        
    }else if (matchType == MatchRangQiuShengPingFu){
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
    }else if (matchType == MatchShengFuGuoGan){
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
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
    [shengfuTypeArray release];
    [wfNameString release];
    [sfKongzhiType release];
    [qtissueString release];
    [sfissueString release];
    [sfMatchArray release];
    [sfIssueArray release];
    [httprequest150 clearDelegatesAndCancel];
    [httprequest150 release];
    [ContentOffDict release];
    [issueTypeArray release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [duoXuanArr release];
    [betrecorinfo release];
    [chuantype release];
    [kongzhiType release];
    [kebianzidian release];
    
    //    [issueArray release];
    //    [staArray release];
    [betInfo release];
    [yujirequest clearDelegatesAndCancel];
    [yujirequest release];
    [danbutDic release];
    [selebutarr release];
    [m_shedanArr release];
    [shedanArr release];
    [textlabel release];
    [labelch release];
    [danDic release];
    [selectedItemsDic release];
    //    [qihaoArray release];
    [saishiArray release];
    [wanArray release];
    [resultList release];
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    [networkQueue reset];
    [networkQueue release];
    [cimgev release];
    [cbgview release];
    //   [bgimagedown release];
    //   [bgviewdown release];
    
    [titleLabel release];
    [tabView release];
    [dataArray release];
    [betArray release];
    //    [request clearDelegatesAndCancel];
    //    self.request = nil;
    
    [oneLabel release];
    [twoLabel release];
    //    [myTableView release];
    //[pkArray release];
    [pkbetdata release];
    [sanjiaoImageView release];
    [super dealloc];
}
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


-(void)footballForecastBetData:(GC_BetData *)_betData withType:(NSInteger)type indexPath:(NSIndexPath *)fIndexPatch{
    
    if (type == 1) {
        [self returnCellInfo:fIndexPatch buttonBoll1:_betData.selection1 buttonBoll:_betData.selection2 buttonBoll:_betData.selection3 dan:_betData.dandan];
    }else if(type == 2){
        [self returnbifenCellInfo:fIndexPatch shuzu:_betData.bufshuarr dan:_betData.dandan];
        
    }
    
}

- (void)neutralityMatchViewDelegate:(NeutralityMatchView *)view withBetData:(GC_BetData *)be{
    
    //    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
    //
    //    NSLog(@"%@", be.saishiid);
    //    sachet.playID = be.saishiid;
    //#ifdef isCaiPiaoForIPad
    //    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
    //#else
    //    [self.navigationController pushViewController:sachet animated:YES];
    //#endif
    //    [sachet release];
    
    LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
    
    NSLog(@"%@", be.saishiid);
    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
    [self.navigationController pushViewController:sachet animated:YES];
#endif
    
    [sachet release];
    
    
    
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
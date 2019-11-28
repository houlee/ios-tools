//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCJCBetViewController.h"
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
#import "Xieyi365ViewController.h"
#import "CP_KindsOfChoose.h"
#import "NSDate-Helper.h"
#import "GCHeMaiInfoViewController.h"
#import "ChongZhiData.h"
#import "LanQiuAroundViewController.h"
#import "MatchDetailViewController.h"
#import "FootballHintView.h"
#import "MobClick.h"
#import "PermutationAndCombination.h"
//#import "FootballForecastViewController.h"

//投注界面
@implementation GCJCBetViewController
//@synthesize request;
@synthesize timezhongjie, gcdgBool, dgType,beginTime,beginInfo;
@synthesize betrecorinfo;
@synthesize betArray;
@synthesize dataArray;
@synthesize issString;
@synthesize lotteryID;
@synthesize httprequest;
@synthesize resultList;
@synthesize selectedItemsDic;
@synthesize danDic;
@synthesize yujirequest, httpRequest, retArray, kongArray;
@synthesize isHeMai, chaodanbool, matchenum, lanqiubool, systimestr,sysTimeSave;
@synthesize lunboBool;
- (void)pressWorldCupButton1:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx_down.png");
}
- (void)pressWorldCupButton2:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
    
}
- (void)pressWorldCupButton:(UIButton *)sender{
    sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
    
    if (lanqiubool) {
        [MobClick event:@"event_goucai_saishicaixuan_caizhong" label:@"竞彩篮球"];
    }
    else {
        [MobClick event:@"event_goucai_saishicaixuan_caizhong" label:@"竞彩足球"];
    }
    NSMutableArray *array = [NSMutableArray array];
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
        
        
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSArray arrayWithObjects:@"1.5以下", @"1.5-2.0", @"2.0以上",nil],@"choose", nil];
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        
        
        
        if ([duoXuanArr count] == 0) {
            
            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                if (onlyDG) {
                    [countarr addObject:@"0"];
                }else{
                    [countarr addObject:@"1"];
                }
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            [duoXuanArr addObject:type2];
            [duoXuanArr addObject:type3];
            
        }
        
        
        [array addObject:dic2];
        [array addObject:dic3];
        
    }else{
        if(lanqiubool){
            
            if (matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan) {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让分",@"title",[NSArray arrayWithObjects:@"客队让分", @"主队让分",nil],@"choose", nil];
                
                
                
                NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选", @"仅单关",nil ], @"kongzhi", saishiArray,@"choose", nil];
                
                if ([duoXuanArr count] == 0) {
                    NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
                    
                    
                    NSMutableArray * countarr = [NSMutableArray array];
                    for (int i = 0; i < [saishiArray count]; i++) {
                        if (onlyDG) {
                            [countarr addObject:@"0"];
                        }else{
                            [countarr addObject:@"1"];
                        }
                    }
                    
                    NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                    
                    [duoXuanArr addObject:type1];
                    
                    [duoXuanArr addObject:type3];
                }
                
                [array addObject:dic];
                
                [array addObject:dic3];
            }else{
                NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选", @"仅单关",nil ], @"kongzhi", saishiArray,@"choose", nil];
                if ([duoXuanArr count] == 0) {
                    NSMutableArray * countarr = [NSMutableArray array];
                    for (int i = 0; i < [saishiArray count]; i++) {
                        if (onlyDG) {
                            [countarr addObject:@"0"];
                        }else{
                            [countarr addObject:@"1"];
                        }
                    }
                    
                    NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                    [duoXuanArr addObject:type3];
                }
                [array addObject:dic3];
                
            }
            
            
        }else{
            
            NSDictionary *dic3 = nil;
            
            
            if (matchenum == matchEnumHunHeGuoGuan) {
                dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            }else{
                if (matchenum == matchEnumHunHeErXuanYi) {
                    dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                }else{
                    dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                }
                
            }
            
            
            
            if ([duoXuanArr count] == 0) {
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    if (onlyDG) {
                        [countarr addObject:@"0"];
                    }else{
                        [countarr addObject:@"1"];
                    }
                    
                    
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                [duoXuanArr addObject:type3];
                
            }
            [array addObject:dic3];
            
        }
        
        
    }
    
    
    
    CP_KindsOfChoose  *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
    alert2.allButtonBool = allButtonBool;
    alert2.fiveButtonBool = fiveButtonBool;
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeGuoGuan) {
        alert2.zhuanjiaBool = zhuanjiaBool;
    }
    if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumBigHunHeGuoGan) {
        alert2.doubleBool = YES;
        alert2.onlyDG = onlyDG;
    }
    alert2.delegate = self;
    alert2.isSaiShiShaixuan = YES;
    
    alert2.tag = 30;
    alert2.duoXuanBool = YES;
    [alert2 show];
    self.mainView.userInteractionEnabled = NO;
    [alert2 release];
    
}

- (void)setWorldCupBool:(BOOL)_worldCupBool{
    worldCupBool = _worldCupBool;
    
    if (worldCupBool) {
        
        if (!worldCupButton) {
            worldCupButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
            
        }
        worldCupButton.hidden = NO;
        
    }
}

- (BOOL)worldCupBool{
    return worldCupBool;
}


//@synthesize totalZhuShuWithDanDic;
#pragma mark -
#pragma mark Initialization

- (void)sortFunc:(NSString *)type{//场号排序
    
    //    GC_BetData * tistr = [arrayce objectAtIndex:0];
    GC_BetData * tistr = nil;
    for (int k = 0; k < [kebianzidian count]; k++) {//当前数据排序
        NSMutableArray * keArray = [kebianzidian objectAtIndex:k];
        for (int i = 0; i < [keArray count]; i++) {
            
            for (int j = 0; j < [keArray count]; j++) {
                
                GC_BetData * oneData = [keArray objectAtIndex:i];
                oneData.oneMacth = @"0";
                GC_BetData * twoData = [keArray objectAtIndex:j];
                twoData.oneMacth = @"0";
                if ([type isEqualToString:@"1"]) {
                    NSString * oneString =  [oneData.numzhou substringWithRange:NSMakeRange(2, 3)];
                    NSString * twoString =  [twoData.numzhou substringWithRange:NSMakeRange(2, 3)];
                    if ([oneString intValue] < [twoString intValue]) {
                        
                        //                        [keArray exchangeObjectAtIndex:j withObjectAtIndex:i];
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [keArray replaceObjectAtIndex:i withObject:oneData];
                        [keArray replaceObjectAtIndex:j withObject:twoData];
                        
                    }
                }else if ([type isEqualToString:@"3"]){
                    double oneFloat = 0;
                    double twoFloat = 0;
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        oneFloat =  [[oneData.oupeiarr objectAtIndex:0] doubleValue] - [[oneData.oupeiarr objectAtIndex:2] doubleValue];
                        twoFloat =  [[twoData.oupeiarr objectAtIndex:0] doubleValue] - [[twoData.oupeiarr objectAtIndex:2] doubleValue];
                    }else{
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =  [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    }
                    
                    if (fabs(oneFloat) > fabs(twoFloat)) {
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [keArray replaceObjectAtIndex:i withObject:oneData];
                        [keArray replaceObjectAtIndex:j withObject:twoData];
                        
                    }
                    
                }else if ([type isEqualToString:@"2"]){
                    double oneFloat = 0;
                    double twoFloat = 0;
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        oneFloat =  [[oneData.oupeiarr objectAtIndex:0] doubleValue] - [[oneData.oupeiarr objectAtIndex:2] doubleValue];
                        twoFloat =   [[twoData.oupeiarr objectAtIndex:0] doubleValue] - [[twoData.oupeiarr objectAtIndex:2] doubleValue];
                    }else{
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =   [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    }
                    
                    if (fabs(oneFloat) < fabs(twoFloat)) {
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [keArray replaceObjectAtIndex:i withObject:oneData];
                        [keArray replaceObjectAtIndex:j withObject:twoData];
                        
                    }
                }
                
                
            }
            
        }
        
        
    }
    BOOL continuebool = NO;
    for (int i = 0; i < [kebianzidian count]; i++) {
        NSMutableArray * dataArr = [kebianzidian objectAtIndex:i];
        
        for (int j = 0; j < [dataArr count]; j++) {
            
            GC_BetData * dataBegin = [dataArr objectAtIndex:j];
            if ([dataBegin.macthType isEqualToString:@"playvs"]) {
                dataBegin.oneMacth = @"1";
                continuebool = YES;
                break;
            }
            
        }
        if (continuebool) {
            break;
        }
    }
    tistr = nil;
    for (int k = 0; k < 2; k++) { // 往期数据排序
        NSMutableArray * keArray = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", k]];
        NSMutableArray * allArr = [[NSMutableArray alloc] initWithCapacity:0];
        [allArr addObjectsFromArray:keArray];
        for (int i = 0; i < [allArr count]; i++) {
            
            for (int j = 0; j < [allArr count]; j++) {
                GC_BetData * oneData = [allArr objectAtIndex:i];
                GC_BetData * twoData = [allArr objectAtIndex:j];
                oneData.oneMacth = @"0";
                twoData.oneMacth = @"0";
                if ([type isEqualToString:@"1"]) {
                    NSString * oneString =  [oneData.numzhou substringWithRange:NSMakeRange(2, 3)];
                    NSString * twoString =  [twoData.numzhou substringWithRange:NSMakeRange(2, 3)];
                    if ([oneString intValue] < [twoString intValue]) {
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [allArr replaceObjectAtIndex:i withObject:oneData];
                        [allArr replaceObjectAtIndex:j withObject:twoData];
                        //                        [wangqiArray setObject:keArray forKey:[NSString stringWithFormat:@"%d", k]];
                        
                    }
                }else if ([type isEqualToString:@"3"]){
                    
                    double oneFloat = 0;
                    double twoFloat = 0;
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        oneFloat =  [[oneData.oupeiarr objectAtIndex:0] doubleValue] - [[oneData.oupeiarr objectAtIndex:2] doubleValue];
                        twoFloat =  [[twoData.oupeiarr objectAtIndex:0] doubleValue] - [[twoData.oupeiarr objectAtIndex:2] doubleValue];
                    }else{
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =  [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    }
                    if (fabs(oneFloat) > fabs(twoFloat)) {
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [allArr replaceObjectAtIndex:i withObject:oneData];
                        [allArr replaceObjectAtIndex:j withObject:twoData];
                        
                        //                         [wangqiArray setObject:keArray forKey:[NSString stringWithFormat:@"%d", k]];
                    }
                    
                }else if ([type isEqualToString:@"2"]){
                    NSLog(@"%@  %@", oneData.but1, twoData.but1);
                    double oneFloat = 0;
                    double twoFloat = 0;
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        oneFloat =  [[oneData.oupeiarr objectAtIndex:0] doubleValue]  -  [[oneData.oupeiarr objectAtIndex:2] doubleValue];
                        twoFloat =   [[twoData.oupeiarr objectAtIndex:0] doubleValue] - [[twoData.oupeiarr objectAtIndex:2] doubleValue];
                    }else{
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =   [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    }
                    if (fabs(oneFloat) < fabs(twoFloat)) {
                        
                        tistr = oneData;
                        oneData = twoData;
                        twoData = tistr;
                        [allArr replaceObjectAtIndex:i withObject:oneData];
                        [allArr replaceObjectAtIndex:j withObject:twoData];
                        //                        [wangqiArray setObject:keArray forKey:[NSString stringWithFormat:@"%d", k]];
                    }
                }
                
            }
            
        }
        [wangqiArray setObject:allArr forKey:[NSString stringWithFormat:@"%d", k]];
        [allArr release];
        
    }
    
    
    
}

- (void)openCloseCell{
    //////////////////////////////////////////////////选择排序后 有一个打开 关闭的一个效果
    BOOL wangqi = NO;
    
    NSInteger bufCount = 0;
    for ( int i = 0; i <[[wangqiArray allKeys] count]; i++) {
        if (buffer[i] == 1) {
            wangqi = YES;
            bufCount = i;
            break;
        }
    }
    BOOL dangqianBool = NO;
    if (wangqi == NO) {
        for (int i = 0; i < [kebianzidian count]; i++) {
            
            if (buffer[i+2] == 1) {
                bufCount = i+2;
                dangqianBool = YES;
                break;
            }
            
        }
    }
    if (dangqianBool == NO && wangqi == NO) {
        //        buffer[2] = 0;
        [myTableView reloadData];
        tableViewCellBool = NO;
        [self performSelector:@selector(sleepfunck:) withObject:[NSString stringWithFormat:@"%d", 2] afterDelay:0.5];
    }else{
        //        buffer[bufCount] = 0;
        [myTableView reloadData];
        tableViewCellBool = NO;
        [self performSelector:@selector(sleepfunck:) withObject:[NSString stringWithFormat:@"%d", (int)bufCount] afterDelay:0.5];
    }
    
}


- (void)NewAroundViewShowFunc:(GC_BetData *)betdata indexPath:(NSIndexPath *)indexPath history:(BOOL)historyBool{//八方预测
    
    FootballForecastViewController * forecast = [[FootballForecastViewController alloc] init];
    forecast.lotteryType = jingcaitype;
    forecast.delegate =self;
    forecast.betData = betdata;
    forecast.gcIndexPath = indexPath;
    
    if (matchenum == matchEnumBigHunHeGuoGan) {
        forecast.matchShowType = fjieqiType;
    }else{
        if (historyBool) {
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
                    
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        forecast.matchShowType = fjcHunheguoguanType;
                    }else if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan){
                        forecast.matchShowType = fjcShengpingfuType;
                    }else if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
                        forecast.matchShowType = fjcZongjinqiuType;
                    }else if (matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
                        forecast.matchShowType = fjcBanchangshengpingfuType;
                    }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                        forecast.matchShowType = fjcBifenType;
                    }else if (matchenum == matchEnumHunHeErXuanYi ){
                        forecast.matchShowType = fjcHunheerxuanyiType;
                    }
                }
                
            }
            
        }
    }
    
    
    
    
    [self.navigationController pushViewController:forecast animated:YES];
    [forecast release];
    
}

- (void)sleepfunck:(NSString *)count{//关闭cell
    buffer[[count intValue]] = 1;
    [myTableView reloadData];
}

- (void)sortViewDidData:(UISortView *)sortView select:(NSInteger)index{//排序点击回调函数
    
    sortCount = index;
    tableViewCellBool = YES;
    
    if (index == 1) {
        [MobClick event:@"event_goucai_zulancai_jingcai_changcihao"];
        [self sortFunc:@"1"];// 场号排序
        
    }else if (index == 2){
        
        [MobClick event:@"event_goucai_zulancai_jingcai_zuipingjun"];
        
        [self sortFunc:@"2"];//最平均
        
    }else if (index == 3){
        [MobClick event:@"event_goucai_zulancai_jingcai_zhukecha"];
        [self sortFunc:@"3"];//主客差
    }
    [self openCloseCell];
}


- (NSString *)objectKeyStringSaveDuiZhen{//生成钥匙
    NSString * keystring = @"";
    if (matchenum == matchEnumBiFenGuoguan) {
        
        keystring = @"2012ggDZ";
    }else if(matchenum == matchEnumShengPingFuGuoGuan){
        
        keystring = @"2011ggDZ";
    }else if(matchenum == matchenumBanQuanChang){
        
        keystring = @"2014ggDZ";
    }else if(matchenum == matchenumZongJinQiuShu){
        
        keystring = @"2013ggDZ";
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        
        keystring = @"2013dgDZ";
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        
        keystring = @"2014dgDZ";
    }else if(matchenum == matchEnumBiFenDanGuan){
        
        keystring = @"2012dgDZ";
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        
        keystring = @"2011dgDZ";
    }else if(matchenum == matchEnumShengFuGuoguan){//、、、、篮球
        keystring = @"20011ggDZ";
        
    }else if(matchenum == matchEnumRangFenShengFuGuoguan){
        keystring = @"20012ggDZ";
        
    }else if(matchenum == matchEnumShengFenChaGuoguan){
        keystring = @"20013ggDZ";
        
    }else if(matchenum == matchEnumDaXiaFenGuoguan){
        keystring = @"20014ggDZ";
        
    }else if(matchenum == matchEnumShengFuDanGuan){
        keystring = @"20011dgDZ";
        
    }else if(matchenum == matchEnumRangFenShengFuDanGuan){
        keystring = @"20012dgDZ";
        
    }else if(matchenum == matchEnumShengFenChaDanGuan){
        keystring = @"20013dgDZ";
        
    }else if(matchenum == matchEnumDaXiaoFenDanGuan){
        keystring = @"20014dgDZ";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        
        keystring = @"20115ggDZ";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        keystring = @"20115dgDZ";
    }else if(matchenum == matchEnumHunHeGuoGuan){
        
        keystring = @"2016ggDZ";
    }else if(matchenum == matchEnumHunHeErXuanYi){
        keystring = @"2016eyggDZ";
    }else if(matchenum == MatchEnumLanqiuHunTou){
        keystring = @"20018lqhtDZ";
    }else if (matchenum == matchEnumBigHunHeGuoGan){
        keystring = @"20019dhtDZ";
    }
    
    
    return keystring;
}

- (NSString *)objectKeyStringSaveHuanCun{//生成钥匙
    NSString * keystring = @"";
    if (matchenum == matchEnumBiFenGuoguan) {
        
        keystring = @"2012ggHC";
    }else if(matchenum == matchEnumShengPingFuGuoGuan){
        
        keystring = @"2011ggHC";
    }else if(matchenum == matchenumBanQuanChang){
        
        keystring = @"2014ggHC";
    }else if(matchenum == matchenumZongJinQiuShu){
        
        keystring = @"2013ggHC";
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        
        keystring = @"2013dgHC";
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        
        keystring = @"2014dgHC";
    }else if(matchenum == matchEnumBiFenDanGuan){
        
        keystring = @"2012dgHC";
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        
        keystring = @"2011dgHC";
    }else if(matchenum == matchEnumShengFuGuoguan){//、、、、篮球
        keystring = @"20011ggHC";
        
    }else if(matchenum == matchEnumRangFenShengFuGuoguan){
        keystring = @"20012ggHC";
        
    }else if(matchenum == matchEnumShengFenChaGuoguan){
        keystring = @"20013ggHC";
        
    }else if(matchenum == matchEnumDaXiaFenGuoguan){
        keystring = @"20014ggHC";
        
    }else if(matchenum == matchEnumShengFuDanGuan){
        keystring = @"20011dgHC";
        
    }else if(matchenum == matchEnumRangFenShengFuDanGuan){
        keystring = @"20012dgHC";
        
    }else if(matchenum == matchEnumShengFenChaDanGuan){
        keystring = @"20013dgHC";
        
    }else if(matchenum == matchEnumDaXiaoFenDanGuan){
        keystring = @"20014dgHC";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        
        keystring = @"20115ggHC";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        keystring = @"20115dgHC";
    }else if(matchenum == matchEnumHunHeGuoGuan){
        
        keystring = @"20016ggHC";
    }else if(matchenum == matchEnumHunHeErXuanYi){
        
        keystring = @"20016eyggHC";
    }else if(matchenum == MatchEnumLanqiuHunTou){
        keystring = @"20018lqhtHC";
    }else if (matchenum == matchEnumBigHunHeGuoGan){
        keystring = @"20019dhtHC";
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
    if (matchenum == matchEnumBiFenGuoguan) {
        
        keystring = @"2012gg";
    }else if(matchenum == matchEnumShengPingFuGuoGuan){
        
        keystring = @"2011gg";
    }else if(matchenum == matchenumBanQuanChang){
        
        keystring = @"2014gg";
    }else if(matchenum == matchenumZongJinQiuShu){
        
        keystring = @"2013gg";
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        
        keystring = @"2013dg";
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        
        keystring = @"2014dg";
    }else if(matchenum == matchEnumBiFenDanGuan){
        
        keystring = @"2012dg";
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        
        keystring = @"2011dg";
    }else if(matchenum == matchEnumShengFuGuoguan){//、、、、篮球
        keystring = @"20011gg";
        
    }else if(matchenum == matchEnumRangFenShengFuGuoguan){
        keystring = @"20012gg";
        
    }else if(matchenum == matchEnumShengFenChaGuoguan){
        keystring = @"20013gg";
        
    }else if(matchenum == matchEnumDaXiaFenGuoguan){
        keystring = @"20014gg";
        
    }else if(matchenum == matchEnumShengFuDanGuan){
        keystring = @"20011dg";
        
    }else if(matchenum == matchEnumRangFenShengFuDanGuan){
        keystring = @"20012dg";
        
    }else if(matchenum == matchEnumShengFenChaDanGuan){
        keystring = @"20013dg";
        
    }else if(matchenum == matchEnumDaXiaoFenDanGuan){
        keystring = @"20014dg";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        
        keystring = @"20115gg";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        keystring = @"20115dg";
    }else if(matchenum == matchEnumHunHeGuoGuan){
        keystring = @"20016dg";
    }else if(matchenum == matchEnumHunHeErXuanYi){
        keystring = @"20016eydg";
    }else if(matchenum == MatchEnumLanqiuHunTou){
        keystring = @"20018lqht";
    }else if (matchenum == matchEnumBigHunHeGuoGan){
        keystring = @"20019dht";
    }
    
    
    return keystring;
}


- (void)classify:(GC_BetData *)be{//分类
    
    NSMutableArray * bifenarr = nil;
    if (matchenum == matchEnumBiFenGuoguan|| matchenum == matchEnumBiFenDanGuan) {
        bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
    }else if(matchenum == matchenumBanQuanChang||matchenum == matchEnumBanQuanChangDanGuan){
        bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
    }else if(matchenum == matchenumZongJinQiuShu||matchenum == matchEnumZongJinQiuShuDanGuan){
        bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
    }else if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
        bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
    }else if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
        
        bifenarr = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
        
    }else if(matchenum == matchEnumHunHeGuoGuan){
        bifenarr = [NSMutableArray arrayWithObjects:@"胜", @"平", @"负", @"让球胜", @"让球平", @"让球负", nil];
    }else if(matchenum == MatchEnumLanqiuHunTou){
        bifenarr = [NSMutableArray arrayWithObjects:@"主负", @"主胜", @"让分主负", @"让分主胜",@"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",nil];
    }
    
    NSString * strbi = @"";
    for (int q = 0; q < [be.bufshuarr count]; q++) {
        
        
        if (matchenum == MatchEnumLanqiuHunTou) {
            
            if (q == 18) {
                break;
            }
            NSInteger bagcount = 0;
            //
            //            if (q > 5 && q < 12) {
            //                bagcount = q + 6;
            //            }else if(q >= 12){
            //                bagcount = q  - 6;
            //            }else{
            bagcount = q;
            //            }
            
            if ([[be.bufshuarr objectAtIndex:bagcount] isEqualToString:@"1"]) {
                
                strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:bagcount]];
                
                
            }
            
        }else{
            if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                
                strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                NSLog(@"bi = %@", strbi);
                
            }
            
        }
        
        
        
    }
    
    if ([strbi length] > 0) {
        strbi =  [strbi substringToIndex:[strbi length] -1];
        be.cellstring = strbi;
    }else{
        be.cellstring = @"请选择投注选项";
    }
    
    
}

- (void)sendButtonFunc:(NSMutableArray * )returnarry kongArray:(NSMutableArray *)kongt{
    
    
    
    NSMutableArray * array1 = [returnarry objectAtIndex:0];
    NSString * rangstring = [array1 objectAtIndex:0];
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (lanqiubool) {
        //        NSMutableArray * array2 = [returnarry objectAtIndex:1];
        //        NSString * guostring = [array2 objectAtIndex:0];
        if ([rangstring isEqualToString:@"胜负"]) {
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 2;
            //            }else{
            //                button1.tag = 3;
            //            }
            
        }else if ([rangstring isEqualToString:@"让分胜负"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 5;
            //            }else{
            //                button1.tag = 6;
            //            }
        }else if ([rangstring isEqualToString:@"胜分差"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 8;
            //            }else{
            //                button1.tag = 9;
            //            }
        }else if ([rangstring isEqualToString:@"大小分"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 11;
            //            }else{
            //                button1.tag = 12;
            //            }
            
        }else if ([rangstring isEqualToString:@"混合过关"]){
            
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 14;
            //            }else {
            //                button1.tag = 14;//没有单关
            //            }
        }
    }else{
        if ([rangstring isEqualToString:@"胜平负"]) {
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 14;
            //            }else{
            //                button1.tag = 15;
            //            }
            
        }else if ([rangstring isEqualToString:@"总进球数"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 5;
            //            }else{
            //                button1.tag = 6;
            //            }
        }else if ([rangstring isEqualToString:@"半全场胜平负"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 8;
            //            }else{
            //                button1.tag = 9;
            //            }
        }else if ([rangstring isEqualToString:@"比分"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 11;
            //            }else{
            //                button1.tag = 12;
            //            }
            
        }
        else if([rangstring isEqualToString:@"混合二选一"]){
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 16;
            //            }else {
            //                button1.tag = 16;
            //            }
        }
        else if([rangstring isEqualToString:@"胜平负混合"]){
            
            
            
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 2;
            //            }else {
            //                button1.tag = 3;//没有单关
            //            }
            
            
            
            
        }else if ([rangstring isEqualToString:@"混合过关"]){
            
            //            if ([guostring isEqualToString:@"串关"]) {
            button1.tag = 18;
            
            //            }else {
            //                button1.tag = 18;//没有单关
            //            }
        }
    }
    
    for (int i = 0; i < 50; i++) {
        for (int k = 0; k < 200; k++) {
            zhankai[i][k] = 0;
        }
    }
    
    
    allbutcount = 0;
    buffer[0] = 0;
    buffer[1] = 0;
    biaoshi = 0;
    showButnIndex = 0;
    oldshowButnIndex = 0;
    
    onlyDG = NO;
    allButtonBool = YES;
    fiveButtonBool = NO;
    
    NSMutableArray * arr1 = [wangqiArray objectForKey:@"0"];
    NSMutableArray   * arr2 = [wangqiArray objectForKey:@"1"];
    [arr1 removeAllObjects];
    [arr2 removeAllObjects];
    self.timezhongjie = systimestr;
    [duoXuanArr removeAllObjects];
    [self pressjiugongge:button1];
    [kongzhiType removeAllObjects];
    [kongzhiType addObjectsFromArray:kongt];
    
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
            
            if(matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan|| matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumShengFuDanGuan||matchenum == matchEnumDaXiaoFenDanGuan||matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumRangFenShengFuDanGuan||matchenum == matchEnumRangFenShengFuGuoguan){
                
                
                if (pkbet.selection1 == YES || pkbet.selection2 == YES || pkbet.selection3 == YES) {
                    selectionCount +=1;
                    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [dataDict setObject:pkbet.changhao forKey:@"changhao"];
                    
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
                    [dataDict setObject:pkbet.bufshuarr forKey:@"bufshuarr"];
                    [dataDict setObject:self.sysTimeSave forKey:@"systimesave"];
                    [dataDict setObject:[NSString stringWithFormat:@"%d", pkbet.dandan] forKey:@"dandan"];
                    [saveArray addObject:dataDict];
                    [dataDict release];
                    
                    
                }
                
                
                
            }
            
            
            
            
            
        }
    }
    
    NSLog(@"keystring = %@", [self objectKeyString]);
    
    if (selectionCount > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:[self objectKeyString]];
    }else{
        
        if (judgeBool) {
            judgeBool = NO;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请先选择比赛"];
        }
        //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //        [cai showMessage:@"请先选择比赛"];
        
        
        [self clearSaveFunc];
        
    }
    
    //     [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:[self objectKeyString]];
    [saveArray release];
    
    
    if (sendBool) {
        sendBool = NO;
        [self sendButtonFunc:self.retArray kongArray:self.kongArray];
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
    NSInteger countSelect = 0;
    for (int n = 0; n < [readArray count]; n++) {
        
        NSMutableDictionary * readDict = [readArray objectAtIndex:n];
        
        NSString * macthid = [readDict objectForKey:@"changhao"];
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * mutarr = [kebianzidian objectAtIndex:i];
            for (int k = 0; k < [mutarr count]; k++) {
                GC_BetData * pkbet = [mutarr objectAtIndex:k];
                if ([pkbet.changhao isEqualToString:macthid]) {
                    countSelect+=1;
                    if(matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumShengFuDanGuan||matchenum == matchEnumDaXiaoFenDanGuan||matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumRangFenShengFuDanGuan||matchenum == matchEnumRangFenShengFuGuoguan){
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
                        
                        [self classify:pkbet];
                        
                        if (matchenum == MatchEnumLanqiuHunTou) {
                            BOOL sfcb = NO;
                            
                            NSInteger coutt = 0;
                            for (int j = 0; j < [allcellarr count]; j++) {
                                
                                GC_BetData * bet = [allcellarr objectAtIndex:j];
                                if (bet.dandan) {
                                    
                                    coutt++;
                                }
                                
                                
                                for (int  k = 0; k < [bet.bufshuarr count]; k++) {
                                    
                                    if (matchenum == MatchEnumLanqiuHunTou) {//判断是否有胜分差玩法
                                        
                                        if (k >= 6 && k < 18) {
                                            if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                                                sfcb = YES;
                                                
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            sfcBool = sfcb;
                            sfcDanCount = coutt;
                            
                            
                        }else if (matchenum == matchEnumBigHunHeGuoGan){
                            
                            
                            
                            //                            BOOL oneMark = NO;
                            BOOL twoMark = NO;
                            BOOL threeMark = NO;
                            
                            for (int j = 0; j < [allcellarr count]; j++) {
                                GC_BetData * bet = [allcellarr objectAtIndex:j];
                                
                                for (int  k = 0; k < [bet.bufshuarr count]; k++) {
                                    
                                    
                                    if(matchenum == matchEnumBigHunHeGuoGan){
                                        
                                        if (k >= 0 && k < 6) {
                                            if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                                                
                                                //                                                oneMark = YES;
                                            }
                                            
                                        }else if (k >= 6 && k < 14) {
                                            if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                                                
                                                twoMark = YES;
                                            }
                                            
                                        }else{
                                            if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                                                
                                                threeMark = YES;
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            if (matchenum == matchEnumBigHunHeGuoGan) {
                                if (threeMark == YES) {
                                    markBigHunTou = 3;
                                }else if (threeMark == NO && twoMark == YES ) {
                                    markBigHunTou = 2;
                                }else if (threeMark == NO && twoMark == NO){
                                    markBigHunTou = 1;
                                }
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
    int qhhbool = 0;
    int hhhbool = 0;
    int oneP = 0;
    int twop = 0;
    int threep = 0;
    int fourp = 0;
    int fivep = 0;
    BOOL dgbool = NO;
    if( matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan){
        
        [self calculateMoney];
        castButton.enabled = YES;
        qingbutton.enabled = YES;
        [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
        
        castButton.alpha = 1;
        //         one = [readArray count];
        one = (int)countSelect;
        
    }else{
        
        NSInteger hhcount = 2;
        
        if (countSelect == 1 &&  (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == rangfenshengfuType || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumBigHunHeGuoGan)) {
            
            
            for (int i = 0; i < [kebianzidian count]; i++) {
                NSMutableArray * mutarr = [kebianzidian objectAtIndex:i];
                for (int k = 0; k < [mutarr count]; k++) {
                    GC_BetData * pkbet = [mutarr objectAtIndex:k];
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        for (int m = 0;  m < [pkbet.bufshuarr count]; m++) {
                            if ([[pkbet.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                                if ([pkbet.onePlural rangeOfString:@" 1,"].location != NSNotFound  && m > 2) {
                                    
                                    if (hhhbool == 0 || hhhbool == 1) {
                                        hhhbool = 1;
                                    }
                                    
                                }else{
                                    hhhbool = 2;
                                }
                                
                                if ([pkbet.onePlural rangeOfString:@" 15,"].location != NSNotFound && m < 3){
                                    if (qhhbool == 0 || qhhbool == 1) {
                                        qhhbool = 1;
                                    }
                                    
                                }else{
                                    qhhbool = 2;
                                }
                                
                                
                            }
                            
                            
                        }
                    }else if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
                        
                        for (int m = 0;  m < [pkbet.bufshuarr count]; m++) {
                            if ([[pkbet.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                                if (matchenum == MatchEnumLanqiuHunTou) {
                                    if ([pkbet.pluralString isEqualToString:@""]) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                        if (fourp == 0 || fourp == 1) {
                                            fourp = 1;
                                        }
                                    }else{
                                        if ([pkbet.pluralString rangeOfString:@" 11,"].location != NSNotFound  && m < 2) {
                                            if (oneP == 0 || oneP == 1) {
                                                oneP = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 11,"].location == NSNotFound  && m < 2) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                            }
                                            
                                        }
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 12,"].location != NSNotFound  && (m > 1 && m < 4)) {
                                            if (twop == 0 || twop == 1) {
                                                twop = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 12,"].location == NSNotFound  && (m > 1 && m < 4)) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                            }
                                        }
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 14,"].location != NSNotFound  && (m > 3 && m < 6)) {
                                            if (threep == 0 || threep == 1) {
                                                threep = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 14,"].location == NSNotFound  && (m > 3 && m < 6)) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                            }
                                            
                                        }
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 13,"].location != NSNotFound  && m > 5) {
                                            if (fourp == 0 || fourp == 1) {
                                                fourp = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 13,"].location == NSNotFound  && m > 5) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                            }
                                        }
                                        
                                    }
                                }else{
                                    
                                    if ([pkbet.pluralString isEqualToString:@""]) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                        if (fourp == 0 || fourp == 1) {
                                            fourp = 1;
                                        }
                                        if (fivep == 0 || fivep == 1) {
                                            fivep = 1;
                                        }
                                    }else{
                                        if ([pkbet.pluralString rangeOfString:@" 1,"].location != NSNotFound  && m < 3) {
                                            if (oneP == 0 || oneP == 1) {
                                                oneP = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 1,"].location == NSNotFound  && m < 3) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                                fivep = 2;
                                            }
                                            
                                        }
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 15,"].location != NSNotFound  && (m > 2 && m < 6)) {
                                            if (twop == 0 || twop == 1) {
                                                twop = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 15,"].location == NSNotFound  && (m> 2 && m < 6)) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                                fivep = 2;
                                            }
                                            
                                            
                                        }
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 3,"].location != NSNotFound  && (m > 5 && m < 14 )) {
                                            if (threep == 0 || threep == 1) {
                                                threep = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 3,"].location == NSNotFound  && (m > 5 && m < 14)) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                                fivep = 2;
                                            }
                                            
                                            
                                        }
                                        if ([pkbet.pluralString rangeOfString:@" 2,"].location != NSNotFound  && (m > 13 && m < 45 )) {
                                            if (threep == 0 || threep == 1) {
                                                fourp = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 2,"].location == NSNotFound  && (m > 13 && m < 45)) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                                fivep = 2;
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        if ([pkbet.pluralString rangeOfString:@" 4,"].location != NSNotFound  && m > 44) {
                                            if (fourp == 0 || fourp == 1) {
                                                fivep = 1;
                                            }
                                        }else{
                                            if ([pkbet.pluralString rangeOfString:@" 4,"].location == NSNotFound  && m > 44) {
                                                oneP = 2;
                                                twop = 2;
                                                threep = 2;
                                                fourp = 2;
                                                fivep = 2;
                                            }
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    else if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan ){
                        if (pkbet.selection1 || pkbet.selection2 || pkbet.selection1) {
                            if (matchenum == matchEnumShengPingFuGuoGuan) {
                                if ([pkbet.onePlural rangeOfString:@" 1,"].location == NSNotFound && [pkbet.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                    dgbool = YES;
                                }
                            }else if (matchenum == matchEnumShengFuGuoguan){
                                if ([pkbet.pluralString rangeOfString:@" 11,"].location != NSNotFound || [pkbet.pluralString isEqualToString:@""]) {
                                    dgbool = YES;
                                }
                            }else if (matchenum == matchEnumRangFenShengFuGuoguan){
                                if ([pkbet.pluralString rangeOfString:@" 12,"].location != NSNotFound || [pkbet.pluralString isEqualToString:@""]) {
                                    dgbool = YES;
                                }
                            }else if (matchenum == matchEnumDaXiaFenGuoguan){
                                if ([pkbet.pluralString rangeOfString:@" 14,"].location != NSNotFound || [pkbet.pluralString isEqualToString:@""]) {
                                    dgbool = YES;
                                }
                            }
                            
                        }
                    }else{
                        
                        for (int m = 0;  m < [pkbet.bufshuarr count]; m++) {
                            if ([[pkbet.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                                if ([[pkbet.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                                    
                                    if (matchenum == matchenumZongJinQiuShu) {
                                        if ([pkbet.onePlural rangeOfString:@" 3,"].location == NSNotFound && [pkbet.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                            dgbool = YES;
                                        }
                                    }else if (matchenum == matchenumBanQuanChang){
                                        if ([pkbet.onePlural rangeOfString:@" 4,"].location == NSNotFound && [pkbet.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                            dgbool = YES;
                                        }
                                    }else if (matchenum == matchEnumBiFenGuoguan){
                                        if ([pkbet.onePlural rangeOfString:@" 2,"].location == NSNotFound && [pkbet.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                            dgbool = YES;
                                        }
                                    }else if (matchenum == matchEnumShengFenChaGuoguan){
                                        if ([pkbet.pluralString rangeOfString:@" 13,"].location != NSNotFound || [pkbet.pluralString isEqualToString:@""]) {
                                            dgbool = YES;
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            if (hhhbool == 1 ||  qhhbool == 1 || dgbool || oneP == 1 || twop == 1 || threep == 1 || fourp == 1 || fivep == 1) {
                hhcount = 1;
            }
            
        }
        
        
        if (countSelect > 4 || countSelect < hhcount){
            
            labelch.text = @"串法";
            oneLabel.text = [NSString stringWithFormat:@"%d", (int)countSelect];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            addchuan = 0;
            if (countSelect <= 1) {
                
                chuanButton1.enabled = NO;
                
                chuanButton1.alpha = 0.5;
            }else{
                
                chuanButton1.enabled = YES;
                
                chuanButton1.alpha = 1;
            }
            if (one < 1) {
                castButton.enabled = NO;
                castButton.alpha = 0.5;
                qingbutton.enabled = NO;
                [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
                
            }else{
                castButton.enabled = YES;
                castButton.alpha = 1;
                qingbutton.enabled = YES;
                [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
                
            }
            
            one = (int)countSelect;
            
            
            
            
        }else{
            
            UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            senbutton.tag = 1;
            
            if (danBool) {
                labelch.text = @"串法";
                oneLabel.text = [NSString stringWithFormat:@"%d", (int)countSelect];
                fieldLable.text = @"场";
                pourLable.hidden = YES;
                twoLabel.hidden = YES;
                addchuan = 0;
                castButton.enabled = YES;
                qingbutton.enabled = YES;
                [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
                
                chuanButton1.enabled = YES;
                castButton.alpha = 1;
                chuanButton1.alpha = 1;
                one = (int)countSelect;
            }else{
                senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", (int)countSelect];
                
                if ((((qhhbool == 1 || hhhbool == 1 ) && matchenum == matchEnumHunHeGuoGuan) || ((oneP == 1 || twop == 1 || threep == 1 || fourp == 1) && matchenum == MatchEnumLanqiuHunTou)||((fivep == 1 ||oneP == 1 || twop == 1 || threep == 1 || fourp == 1) && matchenum == matchEnumBigHunHeGuoGan)) && countSelect == 1) {
                    senbutton.titleLabel.text = [NSString stringWithFormat:@"单关"];
                }else{
                    if (countSelect == 1 && dgbool == YES &&(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan)) {
                        senbutton.titleLabel.text = [NSString stringWithFormat:@"单关"];
                    }
                }
                
                
                
                [self pressChuanJiuGongGe:senbutton];
                
                castButton.enabled = YES;
                chuanButton1.enabled = YES;
                qingbutton.enabled = YES;
                [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
                
                castButton.alpha = 1;
                chuanButton1.alpha = 1;
                one = (int)countSelect;
            }
            
            
            
            
        }
        
        if (one < 1) {
            castButton.enabled = NO;
            qingbutton.enabled = NO;
            castButton.alpha = 0.5;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
            
        }else{
            castButton.enabled = YES;
            qingbutton.enabled = YES;
            castButton.alpha = 1;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
            
            
        }
        if (matchenum == matchEnumHunHeGuoGuan && (qhhbool == 1 || hhhbool == 1) && one == 1) {
            castButton.enabled = YES;
            qingbutton.enabled = YES;
            castButton.alpha = 1;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
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
    }else if (alertView.tag == 111) {
        canShow = NO;
        [self pressCastButton:nil];
    }
}

////////////////////////////


- (void)shaixuanzidian:(NSMutableArray *)arrayce{
    if ([arrayce count] == 0) {
        return;
    }
    
    
    for (int i = 0; i < [arrayce count]; i++) {
        GC_BetData * gcdata = [arrayce objectAtIndex:i];
        NSArray * gctimeArray = [gcdata.timeSort componentsSeparatedByString:@"_"];
        NSString * gcendtime = [gctimeArray objectAtIndex:0];
        BOOL shifoubool = NO;
        for (int j = 0; j < [kebianzidian count]; j++) {
            NSMutableArray * pxDataArray = [kebianzidian objectAtIndex:j];
            if ([pxDataArray count] > 0) {
                GC_BetData * gcdata2 = [pxDataArray objectAtIndex:0];
                NSArray * gctimeArray2 = [gcdata2.timeSort componentsSeparatedByString:@"_"];
                NSString * gcendtime2 = [gctimeArray2 objectAtIndex:0];
                if ([gcendtime isEqualToString:gcendtime2]) {
                    [pxDataArray addObject:gcdata];
                    shifoubool = YES;
                }
            }
        }
        if (shifoubool == NO) {
            NSMutableArray * newArray = [[NSMutableArray alloc] initWithCapacity:0];
            [newArray addObject:gcdata];
            [kebianzidian addObject:newArray];
            [newArray release];
        }
        
        
    }
    
    
    
    
    
    
}

//- (void)shaixuanzidian:(NSMutableArray *)arrayce{
//    if ([arrayce count] == 0) {
//        return;
//    }
//
//
//    //datetime  2014-06-15 23:55  11:30之前为前一天 11：30之后为当天
//
//    GC_BetData * bet = [arrayce objectAtIndex:0];//取第一个截止时间
//    NSArray * timeArray = [bet.datetime componentsSeparatedByString:@" "];
//    NSString * endtime = [NSString stringWithFormat:@"%@ 11:30", [timeArray objectAtIndex:0]];
//
//    NSMutableArray * pxDataArray = nil;
//
//
//    for (int i = 0; i < [arrayce count]; i++) {
//        GC_BetData * gcdata = [arrayce objectAtIndex:i];
//        NSArray * gcDataArray = [gcdata.datetime componentsSeparatedByString:@" "];
//
//        if ([[gcDataArray objectAtIndex:0] isEqualToString:[timeArray objectAtIndex:0]]) {//比较日期是否一样 如果一样的话
//
//
//            NSDate *earlierDate = [[NSDate jcDateFromString:endtime] earlierDate:[NSDate jcDateFromString:gcdata.datetime]];//比较时间
//
//            NSLog(@"nowtime = %@  dif = %@  zz = %@", endtime, gcdata.datetime, [earlierDate jcString]);
//
//            if (earlierDate) {//如果不为nil的话
//
//                if ([endtime isEqualToString:[earlierDate jcString]]) {//如果返回最早的时间和当前拼的时间一样说明是11:30之后的比赛 说明是当天的数据
//                    if (!pxDataArray) {//再起一个新数组来存放
//                        pxDataArray = [[NSMutableArray alloc] initWithCapacity:0];
//                    }
//                    [pxDataArray addObject:gcdata];
//
//                }else{//前一天的数据
//
//                    NSDate * agoTimeDate = [[NSDate alloc] initWithTimeInterval:-60*60*24 sinceDate:[NSDate jcDateFromString:gcdata.datetime]];
//                    NSArray * agoArray = [[agoTimeDate string] componentsSeparatedByString:@" "];
//                    BOOL yesOrNo = NO;
//                    for (int n = 0; n < [kebianzidian count];  n++) {//先循环看之前有没有这个日期
//                        NSMutableArray * gcarray = [kebianzidian objectAtIndex:n];
//                        GC_BetData * agoData = [gcarray objectAtIndex:0];
//                        NSArray * diffArray = [agoData.datetime componentsSeparatedByString:@" "];
//                        if ([[diffArray objectAtIndex:0] isEqualToString:[agoArray objectAtIndex:0]]) {//如果有的话 放到这个日期里
//                            NSMutableArray * kebianArray = [kebianzidian objectAtIndex:n];
//                            [kebianArray addObject:agoData];
//                            [kebianzidian replaceObjectAtIndex:n withObject:kebianArray];
//                            yesOrNo = YES;
//                        }
//
//                    }
//                    if (yesOrNo == NO) {
//
//                        [kebianzidian addObject:pxDataArray];
//                        [pxDataArray release];
//                        pxDataArray = nil;
//
//                        if (!pxDataArray) {//再起一个新数组来存放
//                            pxDataArray = [[NSMutableArray alloc] initWithCapacity:0];
//                        }
//                        [pxDataArray addObject:gcdata];
//                        timeArray = [gcdata.datetime componentsSeparatedByString:@" "];
//                        endtime = [NSString stringWithFormat:@"%@ 11:30", [timeArray objectAtIndex:0]];
//                    }
//
//                    [agoTimeDate release];
//                }
//
//
//            }
//        }else{//如果日期不一样的话
//
//            [kebianzidian addObject:pxDataArray];
//            [pxDataArray release];
//            pxDataArray = nil;
//
//            if (!pxDataArray) {//再起一个新数组来存放
//                pxDataArray = [[NSMutableArray alloc] initWithCapacity:0];
//            }
//            [pxDataArray addObject:gcdata];
//            timeArray = [gcdata.datetime componentsSeparatedByString:@" "];
//            endtime = [NSString stringWithFormat:@"%@ 11:30", [timeArray objectAtIndex:0]];
//
//        }
//
//
//
//
//    }
//
//
//
//
//}


//排序函数
//- (void)shaixuanzidian:(NSMutableArray *)arrayce{
//    if ([arrayce count] == 0) {
//        return;
//    }
//
//    GC_BetData * tistr = [arrayce objectAtIndex:0];
//
//    NSMutableArray * timesarrstr = [[NSMutableArray alloc] initWithCapacity:0];
//    NSString * timebijiao = [tistr.numzhou substringToIndex:2];
//
//    [timesarrstr addObject:timebijiao];
//
//
//    for (int i = 0; i < [arrayce count]; i++) {
//
//        GC_BetData * betstr = [arrayce objectAtIndex:i];
//        NSString * zhouji = [betstr.numzhou substringToIndex:2];
//        BOOL yiybool = NO;
//        for (int j = 0; j < [timesarrstr count]; j++) {
//            NSString * namezou = [timesarrstr objectAtIndex:j];
//            if ([namezou isEqualToString:zhouji]) {
//                yiybool = YES;
//            }
//        }
//        if (![timebijiao isEqualToString:zhouji]) {
//            if (yiybool == NO) {
//                timebijiao = [betstr.numzhou substringToIndex:2];
//
//                [timesarrstr addObject:timebijiao];
//
//            }
//
//        }
//
//
//    }
//       NSLog(@"time = %d", [timesarrstr count]);
//    for (int i = 0;  i < [timesarrstr count]; i++) {
//        NSLog(@"tinme = %@", [timesarrstr objectAtIndex:i]);
//        NSMutableArray * dicarr = [[NSMutableArray alloc] initWithCapacity:0];
//        NSString * timestin = [timesarrstr  objectAtIndex:i];
//
//        for (int j = 0; j < [arrayce count]; j++) {
//
//            GC_BetData * betstr = [arrayce objectAtIndex:j];
//            NSString * zhouji = [betstr.numzhou substringToIndex:2];
//            if ([timestin isEqualToString:zhouji]) {
//
//                [dicarr addObject:betstr];
//            }
//
//        }
//        if ([dicarr count] > 0) {
//            NSLog(@"timestin = %@", timestin);
//
//            [kebianzidian addObject:dicarr];
//
//
//        }
//        [dicarr release];
//
//
//    }
//    NSLog(@"time arr = %@", timesarrstr);
//
//    [timesarrstr release];
//
//
//}

- (id)initWithLotteryID:(NSInteger)lotteryId {
    self = [super init];
    if (self) {//篮球或足球
        
        if (lotteryId == 1) {
            self.lotteryID = lotteryId;
            matchenum = matchEnumHunHeGuoGuan;
        }else{
            self.lotteryID = 1;
            matchenum = matchEnumRangFenShengFuGuoguan;
        }
        //        if (gcdgBool) {
        //
        //            self.lotteryID = 1;
        //            matchenum = matchEnumShengPingFuGuoGuan;
        //        }
        self.sysTimeSave = @"";
    }
    //    NSLog(@"betrecorinfo = %@", betrecorinfo.betContentArray);
    return self;
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle

- (void)titleTextName{
    
    [kongzhiType removeAllObjects];
    
    
    
    
    if (lanqiubool) {
        
        if (matchenum == matchEnumRangFenShengFuGuoguan){
            titleLabel.text = @"让分胜负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == matchEnumRangFenShengFuDanGuan){
            titleLabel.text = @"让分胜负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == matchEnumShengFuGuoguan){
            titleLabel.text = @"胜负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",@"0",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == matchEnumShengFuDanGuan){
            titleLabel.text = @"胜负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",@"0",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if(matchenum == matchEnumShengFenChaGuoguan){
            titleLabel.text = @"胜分差";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"1",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if(matchenum == matchEnumShengFenChaDanGuan){
            titleLabel.text = @"胜分差";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"1",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == matchEnumDaXiaFenGuoguan){
            titleLabel.text = @"大小分";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"1",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == matchEnumDaXiaoFenDanGuan){
            titleLabel.text = @"大小分";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"1",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }else if (matchenum == MatchEnumLanqiuHunTou){
            titleLabel.text = @"混合过关";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"1",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }
    }else{
        
        if (matchenum == matchEnumBigHunHeGuoGan) {
            titleLabel.text = @"混合过关";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"1", nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumHunHeGuoGuan) {
            titleLabel.text = @"胜平负混合";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects: @"1",@"0",@"0",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumShengPingFuGuoGuan){
            titleLabel.text = @"胜平负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if(matchenum == matchEnumShengPingFuDanGuan){
            titleLabel.text = @"胜平负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if(matchenum == matchenumZongJinQiuShu){
            titleLabel.text = @"总进球数";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"1",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumZongJinQiuShuDanGuan){
            titleLabel.text = @"总进球数";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"1",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchenumBanQuanChang){
            titleLabel.text = @"半全场胜平负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"1",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumBanQuanChangDanGuan){
            titleLabel.text = @"半全场胜平负";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"1",@"0",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumBiFenGuoguan){
            titleLabel.text = @"比分";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"1",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if(matchenum == matchEnumBiFenDanGuan){
            titleLabel.text = @"比分";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"1",@"0",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }else if (matchenum == matchEnumHunHeErXuanYi){
            titleLabel.text = @"混合二选一";
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",@"0",@"0",@"1",@"0",nil],@"choose", nil];
            //            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"串关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            //            [kongzhiType addObject:type2];
        }
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 17, 17);
}



- (void)loadingIphone{
    //    diyici = NO;
    addchuan = 0;
    chaocount = 0;
    sortCount = 1;
    celldanbool = YES;
    countchao = 0;
    self.timezhongjie = systimestr;
    biaoshi = 0;
    duckDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    ContentOffDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    wangqiArray = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray * muta1 = [NSMutableArray array];
    NSMutableArray * muta2 = [NSMutableArray array];
    [wangqiArray setObject:muta1 forKey:@"0"];
    [wangqiArray setObject:muta2 forKey:@"1"];
    //    chuanfadict = [[NSMutableDictionary alloc] initWithCapacity:0];
    chuantype = [[NSMutableArray alloc] initWithCapacity:0];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    countjishuqi = 0;
    tagbao = 2;
    if (chaodanbool){
        for (int i = 2; i < 10; i++) {
            buffer[i] = 1;
        }
    }else{
        buffer[2] = 1;
    }
    kebianzidian = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"betrecorinfo = %@", betrecorinfo.betContentArray);
    
    
    
    danbutDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    selebutarr = [[NSMutableArray alloc] initWithCapacity:0];
    chuanfadic= [[NSMutableDictionary alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    //    NSMutableDictionary *_danDic = [NSMutableDictionary dictionary];
    //    self.danDic = _danDic;
    allcellarr = [[NSMutableArray alloc] initWithCapacity:0];
    qihaoArray = [[NSMutableArray alloc] initWithCapacity:0];
    saishiArray = [[NSMutableArray alloc] initWithCapacity:0];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (lanqiubool) {//篮球或足球
        wanArray = [[NSArray alloc] initWithObjects:@"胜负", @"串关", @"单关",@"让分胜负", @"串关", @"单关", @"胜分差",  @"串关", @"单关",@"大小分", @"串关", @"单关", nil];
    }else{
        wanArray = [[NSArray alloc] initWithObjects:@"胜平负", @"串关", @"单关",@"总进球数", @"串关", @"单关", @"半全场胜平负",  @"串关", @"单关",@"比分", @"串关", @"单关", nil];
    }
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];
    
    //  self.title = @"pk赛投注";
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
        
    }else{
        
    }
    
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    //    [self myTableViewHeadView];
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 26, 320, self.mainView.bounds.size.height -69) style:UITableViewStylePlain];
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
    
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
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
    
    
    
    titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    //    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    //    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    
    
    if (lanqiubool) {
        titleLabel.text = @"让分胜负(串关)";
    }else{
        titleLabel.text = @"胜平负混合";
    }
    
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleButton addSubview:titleLabel];
    
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    
    [titleView addSubview:titleButton];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 17, 17);
    
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
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
        //        butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    }
    //    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    if (lanqiubool) {
        if ((matchenum != matchEnumShengFenChaDanGuan) && (matchenum  != matchEnumShengFenChaGuoguan) ) {
            upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
            upimageview.backgroundColor = [UIColor colorWithRed:10/255.0 green:117/255.0 blue:193/255.0 alpha:1];
            [self.mainView addSubview:upimageview];
            [upimageview release];
            
            UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 124, 26)];
            shengla.backgroundColor = [UIColor clearColor];
            shengla.font = [UIFont systemFontOfSize:13];
            shengla.textColor = [UIColor colorWithRed:146/255.0 green:204/255.0 blue:245/255.0 alpha:1];
            shengla.textAlignment = NSTextAlignmentCenter;
            shengla.tag = 11118;
            [upimageview addSubview:shengla];
            [shengla release];
            
            UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 6, 1, 15)];
            shuimage2.backgroundColor = [UIColor colorWithRed:146/255.0 green:204/255.0 blue:245/255.0 alpha:1];
            [upimageview addSubview:shuimage2];
            [shuimage2 release];
            
            UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 136, 26)];
            pingla.backgroundColor = [UIColor clearColor];
            pingla.font = [UIFont systemFontOfSize:13];
            pingla.textColor = [UIColor colorWithRed:146/255.0 green:204/255.0 blue:245/255.0 alpha:1];
            pingla.textAlignment = NSTextAlignmentCenter;
            pingla.tag = 11119;
            [upimageview addSubview:pingla];
            [pingla release];
            
            if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == MatchEnumLanqiuHunTou) {
                shengla.text = @"客队";
                pingla.text = @"主队";
            }else if(matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                shengla.text = @"大";
                pingla.text = @"小";
            }
            
            
            myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height - 69);
        }else{
            
            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69 + 26);
            
        }
        
        
        
        
    }else{
        
        
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69+ 26);
        
        
        
        
    }
    
    
    
    
    if (!chaodanbool) {//chaodanbool
        if (lanqiubool) {
            
            if (dgType == dgMatchShengfu){
                matchenum = matchEnumShengFuGuoguan;
            }else{
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"wanfajiyilanqiu"] && !lunboBool) {
                    
                    matchenum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wanfajiyilanqiu"] intValue];
                    
                }
            }
            
            
            [self titleTextName];
            
        }else
        {
            if (dgType == dgMatchBifen) {
                matchenum = matchEnumBiFenGuoguan;
            }
            
            else if (gcdgBool) {
                
                matchenum = matchEnumHunHeGuoGuan;
            }
            else{
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"wanfajiyizuqiu"] && !lunboBool) {
                    
                    matchenum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wanfajiyizuqiu"] intValue];
                    
                    
                }
            }
            
            [self titleTextName];
            
        }
        
    }
    
    [self requestHttpQingqiu];//请求
    
}

- (void)loadingIpad{
    //    diyici = YES;
    addchuan = 0;
    chaocount = 0;
    celldanbool = YES;
    countchao = 0;
    self.timezhongjie = systimestr;
    biaoshi = 0;
    
    wangqiArray = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray * muta1 = [NSMutableArray array];
    NSMutableArray * muta2 = [NSMutableArray array];
    [wangqiArray setObject:muta1 forKey:@"0"];
    [wangqiArray setObject:muta2 forKey:@"1"];
    //    chuanfadict = [[NSMutableDictionary alloc] initWithCapacity:0];
    chuantype = [[NSMutableArray alloc] initWithCapacity:0];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    countjishuqi = 0;
    tagbao = 2;
    if (chaodanbool){
        for (int i = 2; i < 10; i++) {
            buffer[i] = 1;
        }
    }else{
        buffer[2] = 1;
    }
    kebianzidian = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"betrecorinfo = %@", betrecorinfo.betContentArray);
    
    
    
    danbutDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    selebutarr = [[NSMutableArray alloc] initWithCapacity:0];
    chuanfadic= [[NSMutableDictionary alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    //    NSMutableDictionary *_danDic = [NSMutableDictionary dictionary];
    //    self.danDic = _danDic;
    allcellarr = [[NSMutableArray alloc] initWithCapacity:0];
    qihaoArray = [[NSMutableArray alloc] initWithCapacity:0];
    saishiArray = [[NSMutableArray alloc] initWithCapacity:0];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (lanqiubool) {//篮球或足球
        wanArray = [[NSArray alloc] initWithObjects:@"胜负", @"串关", @"单关",@"让分胜负", @"串关", @"单关", @"胜分差",  @"串关", @"单关",@"大小分", @"串关", @"单关", nil];
    }else{
        wanArray = [[NSArray alloc] initWithObjects:@"胜平负", @"串关", @"单关",@"总进球数", @"串关", @"单关", @"半全场胜平负",  @"串关", @"单关",@"比分", @"串关", @"单关", nil];
    }
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];
    
    //  self.title = @"pk赛投注";
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (chaodanbool == NO) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = leftItem;
        
    }else{
        //        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        //        [self.CP_navigation setHidesBackButton:YES];
    }
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 26, 320, self.mainView.bounds.size.height -69) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
    //    NSString *systemTime = [self getSystemTodayTime];
    //    NSString *remainingTimeLabelStr = [NSString stringWithFormat:@"当前时间：%@", systemTime];
    //    NSLog(@"REMAINING = %@", remainingTimeLabelStr);
    //    NSArray * timearray = [remainingTimeLabelStr componentsSeparatedByString:@" "];
    //    NSString * datestr = [timearray objectAtIndex:0];
    //    NSArray * dateatt = [datestr componentsSeparatedByString:@"间："];
    
    
    //    NSString * timestring = [NSString stringWithFormat:@"%@ %@", [dateatt objectAtIndex:1], [timearray objectAtIndex:1]];
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    //
    
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(60+35, 0, 260, 44)];
    
    
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    if (chaodanbool) {
        titleButton.enabled= NO;
    }else{
        titleButton.enabled = YES;
    }
    
    
    
    titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    //    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    //    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    
    
    if (lanqiubool) {
        titleLabel.text = @"胜负(串关)";
    }else{
        titleLabel.text = @"胜平负";
    }
    
    titleLabel.textColor = [UIColor whiteColor];
    
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
    
    wanfaLabel = [[UILabel alloc] init];
    wanfaLabel.backgroundColor = [UIColor clearColor];
    wanfaLabel.textAlignment = NSTextAlignmentCenter;
    wanfaLabel.font = [UIFont systemFontOfSize:8];
    if (lanqiubool) {
        wanfaLabel.text = @"";
    }else{
        wanfaLabel.text = @"玩法选择";
    }
    
    wanfaLabel.textColor = [UIColor whiteColor];
    //    wanfaLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    //    wanfaLabel.shadowOffset = CGSizeMake(0, 1.0);
    [titleButton addSubview:wanfaLabel];
    [wanfaLabel release];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 17, 17);
    //    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    wanfaLabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+10, 4, 50, 34);
    
    //玩法等按钮菜单
    //    UIButton *titleButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    titleButton2.frame = CGRectMake(210, 5, 50, 44);
    //    titleButton2.backgroundColor = [UIColor clearColor];
    //    UIImageView *butbg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 23, 23)];
    //    butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    //    [titleButton2 addSubview:butbg2];
    //    [butbg2 release];
    
    
    
    
    //    [titleView addSubview:titleButton2];
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
        //        butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    }
    //    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
    if (lanqiubool) {
        if ((matchenum != matchEnumShengFenChaDanGuan) && (matchenum  != matchEnumShengFenChaGuoguan) ) {
            upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 390, 26)];
            upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
            [self.mainView addSubview:upimageview];
            [upimageview release];
            
            //            UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 59, 26)];
            //            saishila.backgroundColor = [UIColor clearColor];
            //            saishila.font = [UIFont systemFontOfSize:13];
            //            saishila.textColor = [UIColor whiteColor];
            //            saishila.textAlignment = NSTextAlignmentCenter;
            //            saishila.text = @"赛事";
            //            [upimageview addSubview:saishila];
            //            [saishila release];
            //
            //
            //            UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59+35, 6, 1, 14)];
            //            shuimage.backgroundColor = [UIColor whiteColor];
            //            [upimageview addSubview:shuimage];
            //            [shuimage release];
            
            UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60+35, 0, 124, 26)];
            shengla.backgroundColor = [UIColor clearColor];
            shengla.font = [UIFont systemFontOfSize:13];
            shengla.textColor = [UIColor whiteColor];
            shengla.textAlignment = NSTextAlignmentCenter;
            shengla.tag = 11118;
            [upimageview addSubview:shengla];
            [shengla release];
            
            UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(184+35, 6, 1, 15)];
            shuimage2.backgroundColor = [UIColor whiteColor];
            [upimageview addSubview:shuimage2];
            [shuimage2 release];
            
            UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(185+35, 0, 136, 26)];
            pingla.backgroundColor = [UIColor clearColor];
            pingla.font = [UIFont systemFontOfSize:13];
            pingla.textColor = [UIColor whiteColor];
            pingla.textAlignment = NSTextAlignmentCenter;
            pingla.tag = 11119;
            [upimageview addSubview:pingla];
            [pingla release];
            
            if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == MatchEnumLanqiuHunTou) {
                shengla.text = @"客队";
                pingla.text = @"主队";
            }else if(matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                shengla.text = @"大";
                pingla.text = @"小";
            }
            
            
            myTableView.frame = CGRectMake(0, 26, 390, self.mainView.bounds.size.height - 69);
        }else{
            
            myTableView.frame = CGRectMake(0, 0, 390, self.mainView.bounds.size.height - 69 + 26);
            
        }
        
        
        
        
    }else{
        if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
            upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 390, 26)];
            //            upimageview.backgroundColor = [UIColor clearColor];
            //            upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
            upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
            [self.mainView addSubview:upimageview];
            [upimageview release];
            
            UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 59, 26)];
            saishila.backgroundColor = [UIColor clearColor];
            saishila.font = [UIFont systemFontOfSize:13];
            saishila.textColor = [UIColor whiteColor];
            saishila.textAlignment = NSTextAlignmentCenter;
            saishila.text = @"赛事";
            [upimageview addSubview:saishila];
            [saishila release];
            
            
            UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59+35, 6, 1, 14)];
            shuimage.backgroundColor = [UIColor whiteColor];
            [upimageview addSubview:shuimage];
            [shuimage release];
            
            UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60+35, 0, 89, 26)];
            shengla.backgroundColor = [UIColor clearColor];
            shengla.font = [UIFont systemFontOfSize:13];
            shengla.textColor = [UIColor whiteColor];
            shengla.textAlignment = NSTextAlignmentCenter;
            shengla.text = @"胜";
            [upimageview addSubview:shengla];
            [shengla release];
            
            UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149+35, 6, 1, 15)];
            shuimage2.backgroundColor = [UIColor whiteColor];
            [upimageview addSubview:shuimage2];
            [shuimage2 release];
            
            UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150+35, 0, 68, 26)];
            pingla.backgroundColor = [UIColor clearColor];
            pingla.font = [UIFont systemFontOfSize:13];
            pingla.textColor = [UIColor whiteColor];
            pingla.textAlignment = NSTextAlignmentCenter;
            pingla.text = @"平(让球)";
            [upimageview addSubview:pingla];
            [pingla release];
            
            UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218+35, 6, 1, 14)];
            shuimage3.backgroundColor = [UIColor whiteColor];
            [upimageview addSubview:shuimage3];
            [shuimage3 release];
            
            UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219+35, 0, 320-229, 26)];
            fula.backgroundColor = [UIColor clearColor];
            fula.font = [UIFont systemFontOfSize:13];
            fula.textColor = [UIColor whiteColor];
            fula.textAlignment = NSTextAlignmentCenter;
            fula.text = @"负";
            [upimageview addSubview:fula];
            [fula release];
            myTableView.frame = CGRectMake(0, 26, 390, self.mainView.bounds.size.height - 69);
        }else{
            
            myTableView.frame = CGRectMake(0, 0, 390, self.mainView.bounds.size.height - 69+ 26);
            
        }
        
        
    }
    
    
    
    
    
    
    [self requestHttpQingqiu];//请求
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    fiveButtonBool = NO;
    allButtonBool = YES;
    canShow = YES;
    
        NSMutableArray * perArray = [[NSMutableArray alloc] initWithCapacity:0];
//        NSMutableArray * onearr = [[NSMutableArray alloc] initWithCapacity:0];
//        NSMutableArray * twoarr = [[NSMutableArray alloc] initWithCapacity:0];
//        NSMutableArray * threearr = [[NSMutableArray alloc] initWithCapacity:0];
    
        [perArray addObject:@"001|胜"];
        [perArray addObject:@"001|平"];
        [perArray addObject:@"001|负"];
        [perArray addObject:@"002|胜"];
        [perArray addObject:@"002|平"];
        [perArray addObject:@"002|负"];
        [perArray addObject:@"003|胜"];
        [perArray addObject:@"003|平"];
        [perArray addObject:@"003|负"];
    
//        [perArray addObject:onearr];
//        [perArray addObject:twoarr];
//        [perArray addObject:threearr];
    
        PermutationAndCombination * pandc = [[PermutationAndCombination alloc] init];
        [pandc combinationWhithMatchArray:perArray chuanCount:@"2"];
    NSMutableArray *asd = [pandc chaifenArray];
    
#ifdef isCaiPiaoForIPad
    [self loadingIpad];
#else
    [self loadingIphone];
#endif
    self.worldCupBool = YES;
    
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

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (matchenum == matchEnumBigHunHeGuoGan) {
        [allimage addObject:@"caidansssx.png"];
//        [allimage addObject:@"menuhmdt.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"gc_zancunimage.png"];
        //        [allimage addObject:@"GC_sanjiShuoming.png"];
    }else{
        [allimage addObject:@"caidansssx.png"];
//        [allimage addObject:@"menuhmdt.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"gc_zancunimage.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
    }
    
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    if (matchenum == matchEnumBigHunHeGuoGan) {
        [alltitle addObject:@"赛事筛选"];
//        [alltitle addObject:@"合买大厅"];
        [alltitle addObject:@"玩法选择"];
        [alltitle addObject:@"暂存"];
    }else{
        [alltitle addObject:@"赛事筛选"];
//        [alltitle addObject:@"合买大厅"];
        [alltitle addObject:@"玩法选择"];
        [alltitle addObject:@"暂存"];
        [alltitle addObject:@"玩法说明"];
    }
    
    
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

- (void)returnSelectIndex:(NSInteger)index{
    tln = nil;
    NSInteger wcint = 0;
    //    if (worldCupButton) {
    //        wcint = 1;
    //    }
    
    if (index == 0 - wcint) {
        
        
        
        NSMutableArray *array = [NSMutableArray array];
        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
            //            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
            
            NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSArray arrayWithObjects:@"1.5以下", @"1.5-2.0", @"2.0以上",nil],@"choose", nil];
            
            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            
            //            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"串关",nil],@"choose", nil];
            
            if ([duoXuanArr count] == 0) {
                //                NSMutableDictionary * type1 = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
                NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
                //                NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"1", @"1",nil],@"choose", nil];
                
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    if (onlyDG) {
                        [countarr addObject:@"0"];
                    }else{
                        [countarr addObject:@"1"];
                    }
                    
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                //                [duoXuanArr addObject:type1];
                [duoXuanArr addObject:type2];
                [duoXuanArr addObject:type3];
                
            }
            
            //            [array addObject:dic];
            [array addObject:dic2];
            [array addObject:dic3];
            
        }else{
            if(lanqiubool){
                
                if (matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan) {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让分",@"title",[NSArray arrayWithObjects:@"客队让分", @"主队让分",nil],@"choose", nil];
                    
                    
                    
                    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose", nil];
                    
                    if ([duoXuanArr count] == 0) {
                        NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
                        
                        
                        NSMutableArray * countarr = [NSMutableArray array];
                        for (int i = 0; i < [saishiArray count]; i++) {
                            if (onlyDG) {
                                [countarr addObject:@"0"];
                            }else{
                                [countarr addObject:@"1"];
                            }
                        }
                        
                        NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                        
                        [duoXuanArr addObject:type1];
                        
                        [duoXuanArr addObject:type3];
                    }
                    
                    [array addObject:dic];
                    
                    [array addObject:dic3];
                }else{
                    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose", nil];
                    if ([duoXuanArr count] == 0) {
                        NSMutableArray * countarr = [NSMutableArray array];
                        for (int i = 0; i < [saishiArray count]; i++) {
                            if (onlyDG) {
                                [countarr addObject:@"0"];
                            }else{
                                [countarr addObject:@"1"];
                            }
                        }
                        
                        NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                        [duoXuanArr addObject:type3];
                    }
                    [array addObject:dic3];
                    
                }
                
                
            }else{
                
                NSDictionary *dic3 = nil;
                //                if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
                
                if (matchenum == matchEnumHunHeGuoGuan) {
                    dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                }else{
                    if (matchenum == matchEnumHunHeErXuanYi) {
                        dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                    }else{
                        dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                    }
                    
                }
                
                //                }else{
                //                    dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",@"仅单关",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
                //                }
                
                if ([duoXuanArr count] == 0) {
                    NSMutableArray * countarr = [NSMutableArray array];
                    
                    for (int i = 0; i < [saishiArray count]; i++) {
                        if (onlyDG) {
                            [countarr addObject:@"0"];
                        }else{
                            [countarr addObject:@"1"];
                        }
                        
                    }
                    
                    
                    NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                    [duoXuanArr addObject:type3];
                    
                    
                    
                }
                [array addObject:dic3];
                
                
            }
            
            
        }
        
        
        
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
        alert2.allButtonBool = allButtonBool;
        alert2.fiveButtonBool = fiveButtonBool;
        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeGuoGuan) {
            alert2.zhuanjiaBool = zhuanjiaBool;
        }
        if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumBigHunHeGuoGan) {
            alert2.doubleBool = YES;
            alert2.onlyDG = onlyDG;
        }
        alert2.delegate = self;
        alert2.isSaiShiShaixuan = YES;
        alert2.tag = 30;
        alert2.duoXuanBool = YES;
        [alert2 show];
        [alert2 release];
        
        
    }else if(index == 1 - wcint){
        if (lanqiubool) {
            [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:@"竞猜篮球"];
        }
        else {
            [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:@"竞猜足球"];
        }
        
        [self pressTitleButton:nil];
        
        
    }else if(index == 2 - wcint){
        if (lanqiubool) {
            [MobClick event:@"event_goucai_zancun_caizhong" label:@"竞彩篮球"];
        }else{
            [MobClick event:@"event_goucai_zancun_caizhong" label:@"竞彩足球"];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"huancunzancun"];
        judgeBool = YES;
        [self sysTimeFunc];
        
    }else if(index == 3 - wcint){
        if (lanqiubool) {
            [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:@"竞彩篮球"];
        }else{
            [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:@"竞彩足球"];
        }
        
        [self pressHelpButton:nil];
    }
//    else if(index == 1 - wcint){
//        if (lanqiubool) {
//            [MobClick event:@"event_goucai_hemaidating_caizhong" label:@"竞彩篮球"];
//        }else{
//            [MobClick event:@"event_goucai_hemaidating_caizhong" label:@"竞彩足球"];
//        }
//        if (lanqiubool) {
//            if (matchenum == MatchEnumLanqiuHunTou) {
//                [self otherLottoryViewController:0 title:@"竞彩篮球合买" lotteryType:2223 lotteryId:@"203"];
//            }else{
//                [self otherLottoryViewController:0 title:@"竞彩篮球合买" lotteryType:105 lotteryId:@"200"];
//            }
//            
//        }else{
//            if (matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumHunHeErXuanYi) {
//                [self otherLottoryViewController:0 title:@"竞彩足球合买" lotteryType:2222 lotteryId:@"202"];
//            }else{
//                [self otherLottoryViewController:0 title:@"竞彩足球合买" lotteryType:106 lotteryId:@"201"];
//            }
//            
//        }
//        
//    }
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
    
    //    int shengxiabut = 0;
    for (int i = 0; i < cishu; i ++) {
        //        if (i == cishu-1) {
        //            shengxiabut = [saishiArray count]%4;
        //        }else{
        //            shengxiabut = 4;
        //        }
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
                // NSLog(@"button text = %@", buttontext.text);
                buttontext.font = [UIFont systemFontOfSize:12];
                [button addSubview:buttontext];
                [buttontext release];
                // [button setTitle:[saishiArray objectAtIndex:index] forState:UIControlStateNormal];
            }else{
                //                button.enabled = NO;
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
        
        imagevv.frame = CGRectMake(20, 0, 280, 38*([saishiArray count]/4+1));
        sibgimage.frame = CGRectMake(0, 0, 280, 38*([saishiArray count]/4+1));
        bgimagedown.frame = CGRectMake(0, 0, 320, 38*([saishiArray count]/4)+70);
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
                //                UIButton * vi = (UIButton *)[imagevv viewWithTag:i];
                //                vi.enabled = NO;
            }
            
            
        }else{
            
            
            
            butt[sender.tag] = 1;
            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 1000];
            imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
            
            
        }
        
        //        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        //        imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
        //
        
        
        // gc_jgg
        
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
            //  sender.backgroundColor = [UIColor whiteColor];
            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 1000];
            //  UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 1000];
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
            //  butt[i] = 0;///////////////////////
            saishicount++;
        }
    }
    
    
    if (saishicount == 0) {
        
    }else{
        textlabel.text = [NSString stringWithFormat:@"赛事筛选(%d)", saishicount];
    }
    
    //if ([arr count] != 0) {
    [cellarray removeAllObjects];
    [kebianzidian removeAllObjects];
    // }
    
    
    
    for (NSString * st in arr) {
        
        if ([arr count] == 0 || [st isEqualToString:@"全部"]) {
            for (GC_BetData * d in allcellarr) {
                [cellarray addObject:d];
                
            }
            //  [self shaixuanzidian:allcellarr];
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
            
            
            //            [self shaixuansaishi:allcellarr saishi:st];
            
        }
        
    }
    
    if ([arr count] > 0) {
        
        
        [self shaixuanzidian:cellarray];
        //  [self pressQingButton:nil];
    }else{
        [self shaixuanzidian:allcellarr];
        textlabel.text = @"赛事筛选(全部)";
    }
    
    for (int i = 0; i < 10; i++) {
        buffer[i] = 1;
    }
    
    // [self pressQingButton:nil];
    [myTableView reloadData];
    
    //  bgimagedown.frame = CGRectMake(0, 0, 320, 0);
    
    [bgviewdown removeFromSuperview];
    [bgviewdown release];
    [arr removeAllObjects];
    [arr release];
}
//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    

    NSLog(@"button tag = %d",(int) sender.tag);

    
    if (sender.tag == 2) {
        
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumShengFuGuoguan;
            
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜负";
            
        }else{
            
            matchenum = matchEnumHunHeGuoGuan;
            
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜平负混合";
        }
        
        
        
        
        
        
        
    }
    
    
    else if(sender.tag == 11){
        
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumDaXiaFenGuoguan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"大小分";
            
        }else{
            matchenum = matchEnumBiFenGuoguan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"比分";
            
        }
        
        
        
        
        
        
        
    }else if(sender.tag == 5){
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumRangFenShengFuGuoguan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"让分胜负";
        }else{
            matchenum = matchenumZongJinQiuShu;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"总进球数";
        }
        
        
        
        
        //
        
    }else if(sender.tag == 8){
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumShengFenChaGuoguan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜分差";
        }else{
            matchenum = matchenumBanQuanChang;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"半全场胜平负";
        }
        
        
        
        
        
        
    }else if(sender.tag == 3){
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumShengFuDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜负";
        }else{
            //            matchenum = matchEnumShengPingFuDanGuan;
            //            [self xuanzhonganniu:sender];
            //            titleLabel.text = @"";
            //            qqqqqqqqqqqqqqqqqqqqqq
        }
        
        
        
    }else if(sender.tag == 6){
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumRangFenShengFuDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"让分胜负";
        }else{
            matchenum = matchEnumZongJinQiuShuDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"总进球数";
        }
        
        
        
        
    }else if(sender.tag == 9){
        
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumShengFenChaDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜分差";
            
        }else{
            matchenum = matchEnumBanQuanChangDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"半全场胜平负";
            
        }
        
        
    }else if(sender.tag == 12){
        
        if (lanqiubool) {//篮球或足球
            matchenum = matchEnumDaXiaoFenDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"大小分";
        }else{
            matchenum = matchEnumBiFenDanGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"比分";
        }
        
        
        
    }else if(sender.tag == 14){
        if (lanqiubool) {
            matchenum = MatchEnumLanqiuHunTou;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"混合过关";
        }else{
            matchenum = matchEnumShengPingFuGuoGuan;
            [self xuanzhonganniu:sender];
            titleLabel.text = @"胜平负";
        }
        
        
        
    }else if(sender.tag == 15){
        matchenum = matchEnumShengPingFuDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"胜平负";
        
    }else if(sender.tag == 16){
        
        matchenum = matchEnumHunHeErXuanYi;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"混合二选一";
        
        
    }else if (sender.tag == 18){
        
        matchenum = matchEnumBigHunHeGuoGan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"混合过关";
        
    }
    
    
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width-20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 17, 17);
    //    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    //    wanfaLabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+10, 4, 50, 34);
    
    //    [self pressQingButton:nil];
    
    buffer[2] = 1;
    
    if (lanqiubool) {
        
        if (matchenum == matchEnumShengFenChaDanGuan || matchenum  == matchEnumShengFenChaGuoguan) {
            
            upimageview.hidden = YES;
#ifdef isCaiPiaoForIPad
            myTableView.frame = CGRectMake(0, 0, 390, self.mainView.bounds.size.height - 69+ 26);
#else
            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69+ 26);
#endif
            
        }else{
            upimageview.hidden = NO;
            
#ifdef isCaiPiaoForIPad
            myTableView.frame = CGRectMake(0, 26, 390, self.mainView.bounds.size.height - 69 );
#else
            myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height - 69 );
#endif
            
            
        }
        if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == MatchEnumLanqiuHunTou) {
            UILabel *  shengla = (UILabel *)[upimageview viewWithTag:11118];
            UILabel * pingla = (UILabel *)[upimageview viewWithTag:11119];
            shengla.text = @"客队";
            pingla.text = @"主队";
        }else if(matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
            UILabel *  shengla = (UILabel *)[upimageview viewWithTag:11118];
            UILabel * pingla = (UILabel *)[upimageview viewWithTag:11119];
            shengla.text = @"大";
            pingla.text = @"小";
        }
        
        
    }else{
        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
            
            upimageview.hidden = YES;
            
            
            //#ifdef isCaiPiaoForIPad
            //            myTableView.frame = CGRectMake(0, 26, 390, self.mainView.bounds.size.height - 69);
            //#else
            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69+26);
            //#endif
            
        }else if(matchenum == matchEnumHunHeErXuanYi){
            
        }else if (matchenum == matchEnumHunHeGuoGuan){
            
            upimageview.hidden = YES;
            
            
            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69+26);
            
            
            
            
        }else{
            upimageview.hidden = YES;
#ifdef isCaiPiaoForIPad
            myTableView.frame = CGRectMake(0, 0, 390, self.mainView.bounds.size.height - 69 + 26);
#else
            myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69 + 26);
#endif
            
            
        }
    }
    if (lanqiubool) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", matchenum] forKey:@"wanfajiyilanqiu"];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", matchenum] forKey:@"wanfajiyizuqiu"];
        
    }
    
    
    
    
}

#pragma mark _KindsOfChooseViewDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex typeArrya:(NSMutableArray *)sender{
    
    //    NSLog(@"sender = %@", sender);
    
    if (buttonIndex == 1) {
        
        
        //        for (int i = 0; i < [chooseView.chuanArray count]; i++) {
        //                  }
        //
        BOOL shifouquanling = NO;
        for (int i = 0; i < [sender count]; i++) {
            if ([[sender objectAtIndex:i] isEqualToString:@"1"]) {
                shifouquanling = YES;
            }
        }
        if (shifouquanling == NO) {
            //            oneLabel.text = @"0";
            //            twoLabel.text = @"0";
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
    }else{
        
        
    }
    
    
    
}

- (void)gcdgFunc{
    
    [cellarray removeAllObjects];
    for (int i = 0; i < [allcellarr count]; i++) {
        GC_BetData * btd = [allcellarr objectAtIndex:i];
        
        
        if (matchenum == matchEnumHunHeGuoGuan) {
            
            
            if (![btd.hhonePlural isEqualToString:@"0"]) {
                
                
                [cellarray addObject:btd];
            }
            
            
        }else if (matchenum == matchenumZongJinQiuShu){
            
            if ([btd.onePlural rangeOfString:@" 3,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                [cellarray addObject:btd];
            }
            
            
        }else if (matchenum == matchenumBanQuanChang){
            
            if ([btd.onePlural rangeOfString:@" 4,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                [cellarray addObject:btd];
            }
            
            
        }else if (matchenum == matchEnumBiFenGuoguan){
            
            
            if ([btd.onePlural rangeOfString:@" 2,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                [cellarray addObject:btd];
            }
            
        }else if (matchenum == matchEnumShengPingFuGuoGuan){
            if ([btd.onePlural rangeOfString:@" 1,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                [cellarray addObject:btd];
            }
        }else if (matchenum == MatchEnumLanqiuHunTou){
            
            if ([btd.pluralString rangeOfString:@" 0,"].location == NSNotFound ) {
                
                
                [cellarray addObject:btd];
            }
        }else if (matchenum == matchEnumShengFuGuoguan){
            if ([btd.pluralString rangeOfString:@" 11,"].location != NSNotFound || [btd.pluralString isEqualToString:@""]) {
                [cellarray addObject:btd];
            }
            
        }else if (matchenum == matchEnumRangFenShengFuGuoguan){
            if ([btd.pluralString rangeOfString:@" 12,"].location != NSNotFound || [btd.pluralString isEqualToString:@""]) {
                [cellarray addObject:btd];
            }
            
        }else if (matchenum == matchEnumShengFenChaGuoguan){
            if ([btd.pluralString rangeOfString:@" 13,"].location != NSNotFound || [btd.pluralString isEqualToString:@""]) {
                [cellarray addObject:btd];
            }
            
        }else if (matchenum == matchEnumDaXiaFenGuoguan){
            if ([btd.pluralString rangeOfString:@" 14,"].location != NSNotFound || [btd.pluralString isEqualToString:@""]) {
                [cellarray addObject:btd];
            }
            
        }else if (matchenum == matchEnumBigHunHeGuoGan){
            
            if ([btd.pluralString rangeOfString:@" 0,"].location == NSNotFound ) {
                
                
                [cellarray addObject:btd];
            }
        }
        
        
        
    }
    [kebianzidian removeAllObjects];
    [self shaixuanzidian:cellarray];
    [self sortFunc:[NSString stringWithFormat:@"%d", (int)sortCount]];
    [myTableView reloadData];
    
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    //    NSMutableArray * array1 = [returnarry objectAtIndex:0];
    //    NSString * xxx = [array1 objectAtIndex:0];
    //    NSLog(@"%@",xxx);
    
    if (chooseView.tag == 10) {
        if (buttonIndex == 1) {
            
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
            
            
            
        }
    }else if(chooseView.tag == 20){
        if (buttonIndex == 1) {
            sendBool = YES;
            judgeBool = NO;
            self.retArray = returnarry;
            self.kongArray = kongt;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
            //            [headView removeFromSuperview];
            //            headView = nil;
            //            tabhead = nil;
            zhuanjiaBool = NO;
            onlyDG = NO;
            allButtonBool = YES;
            fiveButtonBool = NO;
            [self sysTimeFunc];
            
            
            
        }
        
        
    }else if(chooseView.tag == 30){
        if (buttonIndex == 1) {
            NSLog(@"kongt = %@", kongt);
            [duoXuanArr removeAllObjects];
            [duoXuanArr addObjectsFromArray:kongt];
            
            zhuanjiaBool = chooseView.zhuanjiaBool;
            onlyDG = chooseView.onlyDG;
            allButtonBool = chooseView.allButtonBool;
            fiveButtonBool = chooseView.fiveButtonBool;
            
            if ((matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan)&& chooseView.zhuanjiaBool ) {
                
                [cellarray removeAllObjects];
                for (int i = 0; i < [allcellarr count]; i++) {
                    GC_BetData * btd = [allcellarr objectAtIndex:i];
                    if (![btd.zhongzu isEqualToString:@"-"]) {
                        [cellarray addObject:btd];
                    }
                }
                [kebianzidian removeAllObjects];
                [self shaixuanzidian:cellarray];
                [self sortFunc:[NSString stringWithFormat:@"%d", (int)sortCount]];
                [myTableView reloadData];
                
                return;
            }
            
            if ((matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumBigHunHeGuoGan) && chooseView.onlyDG) {
                
                [self gcdgFunc];
                
                
                return;
            }
            
            
            if (matchenum != matchEnumRangQiuShengPingFuGuoGuan && matchenum != matchEnumRangQiuShengPingFuDanGuan&&matchenum != matchEnumShengPingFuDanGuan && matchenum != matchEnumShengPingFuGuoGuan && matchenum != matchEnumRangFenShengFuDanGuan && matchenum != matchEnumRangFenShengFuGuoguan) {
                [cellarray removeAllObjects];
                
                
                
                NSArray * arrayz = [returnarry objectAtIndex:[returnarry count]-1];
                NSMutableArray * zhongjiecell = [NSMutableArray array];
                //                NSInteger countint = 0;
                //                if (matchenum == matchEnumHunHeGuoGuan) {
                //                    countint = 1;
                //                }
                
                if ([arrayz count] == 0) {
                    [zhongjiecell addObjectsFromArray:allcellarr];
                }else{
                    
                    for (int i = 0; i < [allcellarr count]; i++) {
                        GC_BetData * btd = [allcellarr objectAtIndex:i];
                        for (int k = 0; k < [arrayz count]; k++) {
                            NSString * saishi1 = [btd.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            NSString * saishi2 = [[arrayz objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if ([saishi1 isEqualToString:saishi2]) {
                                [zhongjiecell addObject:btd];
                            }
                            
                        }
                    }
                    
                    
                }
                
                [cellarray addObjectsFromArray:zhongjiecell];

                NSLog(@"zhongjiecell = %d", (int)[zhongjiecell count]);

                
            }else{
                
                
                
                
                NSInteger zcount = 0;
                NSInteger diyicount = 0;
                NSInteger diercount = 0;
                NSInteger disancount = 0;
                NSInteger rangfeirang1 = 0;
                NSInteger rangfenrang2 = 0;
                NSInteger peilv1 = 0;
                NSInteger peilv2 = 0;
                NSInteger peilv3 = 0;
                
                NSMutableArray * tiaojianarr = [NSMutableArray array];
                
                
                for (int i = 0; i < [chooseView.dataArray count]; i++) {
                    NSDictionary *data = [chooseView.dataArray objectAtIndex:i];
                    UIView * bottonview = (UIView *)[chooseView.backScrollView viewWithTag:i+1000];
                    NSMutableArray *chooseArray = [data objectForKey:@"choose"];
                    BOOL xuanbool = NO;
                    for (int k = 0; k < [chooseArray count]; k++) {
                        CP_XZButton * but1 = (CP_XZButton *)[bottonview viewWithTag: k + [chooseArray count]];
                        if (but1.selected == YES) {
                            if (k == 0 && i == 0) {
                                rangfeirang1 = 1;
                            }
                            if (i == 0 && k == 1){
                                rangfenrang2 = 1;
                            }
                            
                            if (k == 0 && i == 0) {
                                peilv1 = 1;
                            }
                            if(k == 1 && i == 0){
                                peilv2 = 1;
                            }
                            if(k == 2 && i ==0){
                                peilv3 =1;
                            }
                            
                            xuanbool = YES;
                            [tiaojianarr addObject:but1.buttonName.text];
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
                NSInteger counttag = [returnarry count] - 1;
                
                if (matchenum == matchEnumShengPingFuGuoGuan) {
                    if ([returnarry count] > 2) {
                        counttag = [returnarry count] - 2;
                    }
                    
                }
                
                NSArray * arrayz = [returnarry objectAtIndex:counttag];
                NSMutableArray * zhongjiecell = [NSMutableArray array];
                if ([arrayz count] == 0) {
                    [zhongjiecell addObjectsFromArray:allcellarr];
                }else{
                    
                    for (int i = 0; i < [allcellarr count]; i++) {
                        GC_BetData * btd = [allcellarr objectAtIndex:i];
                        for (int k = 0; k < [arrayz count]; k++) {
                            NSString * saishi1 = [btd.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            NSString * saishi2 = [[arrayz objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if ([saishi1 isEqualToString:saishi2]) {
                                [zhongjiecell addObject:btd];
                            }
                            
                        }
                    }
                    
                    
                }
                
                

                NSLog(@"zhongjiecell = %d", (int)[zhongjiecell count]);
                
                

                if(matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
                    if (zcount == 2) {
                        [cellarray addObjectsFromArray:zhongjiecell];
                    }else{
                        NSMutableArray * rangarrsha = [NSMutableArray array];
                        if ((rangfeirang1 == 0 && rangfenrang2 == 0)||(rangfeirang1 == 1 && rangfenrang2 == 1)) {
                            
                            [rangarrsha addObjectsFromArray:zhongjiecell];
                            
                        }else if(rangfeirang1 != 1 && rangfenrang2 == 1){
                            
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                NSArray * teamarray = [shuju.team componentsSeparatedByString:@","];
                                if ([teamarray count] >2) {
                                    
                                    if ([[teamarray objectAtIndex:2] floatValue] < 0) {
                                        [rangarrsha addObject:shuju];
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            
                            
                        }else if(rangfeirang1 == 1 && rangfenrang2 != 1){
                            
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                NSArray * teamarray = [shuju.team componentsSeparatedByString:@","];
                                if ([teamarray count] >2) {
                                    
                                    if ([[teamarray objectAtIndex:2] floatValue] > 0) {
                                        [rangarrsha addObject:shuju];
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        [cellarray addObjectsFromArray:rangarrsha];
                        
                    }
                }else{
                    if (zcount == 2) {
                        [cellarray addObjectsFromArray:zhongjiecell];
                    }else{
                        
                        NSMutableArray * peilvarr = [NSMutableArray array];
                        if ((peilv1 == 0 && peilv2 == 0 && peilv3 == 0)||(peilv1 == 1 && peilv2 == 1 && peilv3 == 1)) {
                            [peilvarr addObjectsFromArray:zhongjiecell];
                        }else if(peilv1 == 1 && peilv2 != 1&& peilv3 != 1){
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if ([shuju.but1 floatValue] < 1.5) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                        }else if(peilv1 != 1 && peilv2 == 1 && peilv3 != 1){
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if (([shuju.but1 floatValue] >= 1.5) && ([shuju.but1 floatValue] < 2.0)) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                        }else  if(peilv1 != 1 && peilv2 != 1 && peilv3 == 1){
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if ([shuju.but1 floatValue] >= 2.0) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                            
                        }else  if(peilv1 == 1 && peilv2 == 1&& peilv3 != 1){
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if (([shuju.but1 floatValue] < 1.5) || (([shuju.but1 floatValue] >= 1.5) && ([shuju.but1 floatValue] < 2.0))) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                            
                        }else if(peilv1 != 1 && peilv2 ==1 && peilv3 == 1){
                            
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if (([shuju.but1 floatValue] >= 2.0)||(([shuju.but1 floatValue] >= 1.5) && ([shuju.but1 floatValue] < 2.0))) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                            
                        }else if(peilv1  == 1 && peilv2 != 1 && peilv3 == 1){
                            for (int i = 0; i < [zhongjiecell count]; i++) {
                                GC_BetData * shuju = [zhongjiecell objectAtIndex:i];
                                if (([shuju.but1 floatValue] >= 2.0)||([shuju.but1 floatValue] < 1.5)) {
                                    [peilvarr addObject: shuju];
                                }
                            }
                        }
                        
                        
                        
                        
                        [cellarray addObjectsFromArray:peilvarr];
                        
                        
                        
                        
                        
                        
                    }
                }
                
                
                
                
            }
            
            
            

            
            NSLog(@"cellcount = %d", (int)[cellarray count]);
            

            [kebianzidian removeAllObjects];
            [self shaixuanzidian:cellarray];
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumHunHeGuoGuan) {
                [self sortFunc:[NSString stringWithFormat:@"%d", (int)sortCount]];
            }
            
            [myTableView reloadData];
        }
        
        
    }
    
}
-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView
{
    self.mainView.userInteractionEnabled =YES;
}
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton *)sender{
    NSLog(@"st = %@", sender.buttonName.text);
    //    UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    senbutton.tag = sender.tag + 1;
    //    senbutton.titleLabel.text = sender.buttonName.text;
    //    [self pressChuanJiuGongGe:senbutton];
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

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chooseButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry{
    //    NSLog(@"%@",returnarry);
    //    NSMutableArray * array1 = [returnarry objectAtIndex:0];
    //    NSString * xxx = [array1 objectAtIndex:0];
    //    NSLog(@"%@",xxx);
    
    
    if (chooseView.tag == 10) {
        if (buttonIndex == 1) {
            //            pressChuanJiuGongGe
            
        }
        
    }else if(chooseView.tag == 20){
        if (buttonIndex == 1) {
            
        }
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
//玩法选择
- (void)pressTitleButton:(UIButton *)sender{
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (lanqiubool) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"玩法",@"title",[NSArray arrayWithObjects:@"胜负", @"让分胜负",@"胜分差",@"大小分",@"混合过关",nil],@"choose", nil];
        
        if ([kongzhiType count] == 0) {
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",@"0",@"0",@"0",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
        }

        NSLog(@"%d", (int)[kongzhiType count]);

        
        [array addObject:dic];
        
    }else{
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"玩法",@"title",[NSArray arrayWithObjects: @"胜平负混合", @"胜平负", @"总进球数",@"半全场胜平负",@"比分", @"混合二选一",@"混合过关",nil],@"choose", nil];
        
        if ([kongzhiType count] == 0) {
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"1", @"0",@"0",@"0",@"0",@"0",@"0",nil],@"choose", nil];
            [kongzhiType addObject:type1];
        }

        NSLog(@"%d", (int)[kongzhiType count]);

        
        [array addObject:dic];
        
    }
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    if (lanqiubool) {
        alert2.jingcaiBool = jingcailanqiuwf;
    }else{
        alert2.jingcaiBool = jingcaizuqiuwf;
    }
    if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang) {
        alert2.doubleBool = YES;
    }
    
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
    
    
    
    
    
}

- (void)xuanzhonganniu:(UIButton *)sender{
//    if (but[sender.tag] == 0) {
        but[tagbao] = 0;
        but[sender.tag] = 1;
        // titleLabel.text = @"竞彩足球比分(过关)";
        for (int i = 0; i < 160; i++) {
            butt[i] = 0;
        }
        
        
        textlabel.text = @"赛事筛选(全部)";
        // matchenum = matchEnumBiFenGuoguan;
        
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
        tagbao = sender.tag;
        [self performSelector:@selector(pressQingButton:) withObject:nil withObject:0];
        [self requestHttpQingqiu];
        [bgview removeFromSuperview];
//    }else{
//        [bgview removeFromSuperview];
//    }
    
    
    
}

//选择玩法 和背景点击消失
- (void)pressBgButton:(UIButton *)sender{
    
    int n = 0;
    for (int i = 1; i < 17; i++) {
        if (but[i] == 1) {
            n = i;
            NSLog(@"i = %d", i);
            break;
        }
    }
    NSLog(@"n = %d", n);
    
    if ((n-1) < [issueArray count]) {
        //      titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:n-1]];
        //      [self getFootballMatchRequest:[issueArray objectAtIndex:n-1]];
        issString = [issueArray objectAtIndex:n-1];
        NSLog(@"iss = %@", issString);
        but[n] = 0;
    }
    
    [bgview removeFromSuperview];
}


//- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
//    NSString * str = [mrequest responseString];
//    NSDictionary * dict = [str JSONValue];
//    NSLog(@"dict = %@", dict);
//    NSArray * array = [dict objectForKey:@"data"];
//    for (NSDictionary * di in array) {
//        GC_BetData * pkbet = [[GC_BetData alloc] initWithDuc:di];
//        [dataArray addObject:pkbet];
//        [pkbet release];
//    }
//    [myTableView reloadData];
//}

//- (void)pressRightButton:(id)sender{
//    PKGameExplainViewController * pkevc = [[PKGameExplainViewController alloc] init];
//    [self.navigationController pushViewController:pkevc animated:YES];
//    [pkevc release];
//
//}

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
    
    
    //已选
    //    UILabel * pitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    //    pitchLabel.text = @"已选";
    //    pitchLabel.textAlignment = NSTextAlignmentCenter;
    //    pitchLabel.font = [UIFont systemFontOfSize:9];
    //    pitchLabel.backgroundColor = [UIColor clearColor];
    //
    //    //已投
    //    UILabel * castLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 20, 10)];
    //    castLabel.text = @"已投";
    //    castLabel.textAlignment = NSTextAlignmentCenter;
    //    castLabel.font = [UIFont systemFontOfSize:9];
    //    castLabel.backgroundColor = [UIColor clearColor];
    
    
    
    qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    twoLabel.hidden = YES;
    //  twoLabel.text = @"512";
    
    [zhubg addSubview:twoLabel];
    
    //场字
    fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 1, 20, 13)];
    fieldLable.text = @"场";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:12];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [zhubg addSubview:fieldLable];
    //注字
    pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 20, 13)];
    pourLable.text = @"元";
    pourLable.hidden = YES;
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
    //230, 7, 80, 33//175, 11, 80, 29
    if (one < 2) {
        
        castButton.alpha = 0.5;
    }else{
        
        castButton.alpha = 1;
    }
    if (one < 1) {
        castButton.enabled = NO;
        qingbutton.enabled = NO;
        [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
    }else{
        castButton.enabled = YES;
        qingbutton.enabled = YES;
        [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
        
    }
    
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [castButton addSubview:buttonLabel1];
    //    [buttonLabel1 release];
    //玩法按钮
    //    UIButton * helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    helpButton.frame = CGRectMake(282, 11, 26, 29);
    //    //  [helpButton setImage:UIImageGetImageFromName(<#__POINTER#>) forState:UIControlStateNormal];
    //    [helpButton addTarget:self action:@selector(pressHelpButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //串法
    chuanButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [chuanButton1 setImage:UIImageGetImageFromName(@"gc_jcchuan.png") forState:UIControlStateNormal];
    if (one < 2) {
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
    labelch.font = [UIFont boldSystemFontOfSize:20];
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
    
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    //  [castButton addSubview:backButton];
    //    [helpButton addSubview:backButton2];
    [castButton addSubview:buttonLabel1];
    //[helpButton addSubview:buttonLabel2];
    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    // [buttonLabel2 release];
    
    [tabView addSubview:tabBack];
    //[tabView addSubview:pitchLabel];
    // [tabView addSubview:castLabel];
    //    [tabView addSubview:fieldLable];
    //    [tabView addSubview:pourLable];
    //    [tabView addSubview:imageView1];
    //    [tabView addSubview:imageView2];
    [tabView addSubview:zhubg];
    [tabView addSubview:castButton];
    //    [tabView addSubview:helpButton];
    [tabView addSubview:chuanButton1];
    
    [tabView addSubview:qingbutton];
    
    [self.mainView addSubview:tabView];
    
    
    
    //  [pitchLabel release];
    //  [castLabel release];
    [zhubg release];
    [fieldLable release];
    [pourLable release];
    //    [imageView1 release];
    //    [imageView2 release];
    [tabBack release];
#ifdef isCaiPiaoForIPad
    qingbutton.frame = CGRectMake(12+34, 8, 30, 30);
    zhubg.frame = CGRectMake(52+34, 7, 62, 30);
    chuanButton1.frame = CGRectMake(130+34, 6, 60, 33);
    castButton.frame = CGRectMake(230+34, 6, 80, 33);
#endif
}

- (void)pressQingButton:(UIButton *)sender{
    //篮球或足球
    if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan|| matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
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
        //篮球或足球
    }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan||matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan||matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
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
                da.cellstring = @"请选择投注选项";
                
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
            da.cellstring = @"请选择投注选项";
            da.dandan = NO;
            [allcellarr replaceObjectAtIndex:i withObject:da];
            
        }
        
    }
    //    NSArray * allkeys = [kebianzidian allKeys];
    
    [myTableView reloadData];
    one = 0;
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = @"0";
    labelch.text = @"串法";
    fieldLable.text = @"场";
    pourLable.hidden = YES;
    twoLabel.hidden = YES;
    addchuan = 0;
    [zhushuDic removeAllObjects];
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    chuanButton1.enabled = NO;
    castButton.enabled = NO;
    qingbutton.enabled = NO;
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
    
    castButton.alpha = 0.5;
    chuanButton1.alpha = 0.5;
    shedan = NO;
}

//串的ui//串法//篮球或足球
- (void)pressChuanButton{
    
    if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
        
        NSInteger coutt = 0;
        for (int j = 0; j < [allcellarr count]; j++) {
            
            GC_BetData * bet = [allcellarr objectAtIndex:j];
            if (bet.dandan) {
                
                coutt++;
            }
        }
        sfcDanCount = coutt;
        
        if (matchenum == MatchEnumLanqiuHunTou) {
            if ( sfcBool && sfcDanCount > 3) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"您的投注包含胜分差玩法, 最多只能设3个胆"];
                return;
            }
        }else{
            if (markBigHunTou == 3 && sfcDanCount > 3) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"您的投注包含半全场胜平负、比分玩法, 最多只能设3个胆"];
                return;
            }else if (markBigHunTou == 2 && sfcDanCount > 5){
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"您的投注包含总进球数玩法, 最多只能设5个胆"];
                return;
            }else if(sfcDanCount > 7){
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"最多可以设7个胆"];
                return;
            }
        }
        
        
        
        
        
    }
    
    
    if (lanqiubool) {
        [MobClick event:@"event_goucai_touzhu_guoguanfangshi_caizhong" label:@"竞彩篮球"];
    }
    else {
        [MobClick event:@"event_goucai_touzhu_guoguanfangshi_caizhong" label:@"竞彩足球"];
    }
    
    [cellarray removeAllObjects];
    
    [cellarray addObjectsFromArray:allcellarr];
    
    shedan  = NO;
    NSInteger dancout = 0;
    
    int changci = 0;//计算选多少场
    int danshiCount = 0;//计数 多少个单关
    int sumcount = 0;//篮球混投 足球小混投 判断是否全是单关
    int dfcount = 0;//篮球混投 足球小混投 判断是否全是单关
    //篮球或足球
    if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan||matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan) {
        for (GC_BetData * da in cellarray) {
            
            if (da.selection1 || da.selection2 || da.selection3) {
                changci++;
                
                if (matchenum == matchEnumShengPingFuGuoGuan) {
                    if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                        danshiCount +=1;
                    }
                }else if (matchenum == matchEnumShengFuGuoguan){
                    if ([da.pluralString rangeOfString:@" 11,"].location != NSNotFound || [da.pluralString isEqualToString:@""]){
                        danshiCount +=1;
                    }
                }else if (matchenum == matchEnumRangFenShengFuGuoguan){
                    if ([da.pluralString rangeOfString:@" 12,"].location != NSNotFound || [da.pluralString isEqualToString:@""]){
                        danshiCount +=1;
                    }
                }else if (matchenum == matchEnumDaXiaFenGuoguan){
                    if ([da.pluralString rangeOfString:@" 14,"].location != NSNotFound || [da.pluralString isEqualToString:@""]){
                        danshiCount +=1;
                    }
                }
                
                
                
            }
            
            
            if (da.dandan) {
                
                dancout++;
                
            }
            
        }
        //篮球或足球
    }else if (matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan||matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
        
        
        
        if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumBigHunHeGuoGan) {
            
            for (GC_BetData * da in cellarray) {
                BOOL selectBool = NO;
                for (int i = 0; i < [da.bufshuarr count]; i++) {
                    
                    if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                        selectBool = YES;
                        sumcount += 1;
                        if (matchenum == matchEnumHunHeGuoGuan){
                            if ([da.onePlural rangeOfString:@" 1,"].location != NSNotFound && i > 2) {
                                //                        hhhbool = YES;
                                
                                dfcount += 1;
                                
                            }
                            if ([da.onePlural rangeOfString:@" 15,"].location != NSNotFound && i < 3){
                                //                        qhhbool = YES;
                                
                                dfcount += 1;
                                
                            }
                        }
                        else if (matchenum == MatchEnumLanqiuHunTou){
                            
                            if ([da.pluralString isEqualToString:@""]) {
                                
                                dfcount += 1;
                            }else{
                                if ([da.pluralString rangeOfString:@" 11,"].location != NSNotFound  && i < 2){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 12,"].location != NSNotFound  && (i > 1 && i < 4)){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 14,"].location != NSNotFound  &&  (i > 3 && i < 6)){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 13,"].location != NSNotFound  && (i > 5)){
                                    
                                    dfcount += 1;
                                }
                            }
                            
                        }
                        else if (matchenum == matchEnumBigHunHeGuoGan){
                            
                            if ([da.pluralString isEqualToString:@""]) {
                                
                                dfcount += 1;
                            }else{
                                if ([da.pluralString rangeOfString:@" 1,"].location != NSNotFound  && i < 3){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 15,"].location != NSNotFound  && (i > 2 && i < 6)){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 3,"].location != NSNotFound  &&  (i > 5 && i < 14)){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 2,"].location != NSNotFound  && (i > 13 && i < 45)){
                                    
                                    dfcount += 1;
                                }
                                if ([da.pluralString rangeOfString:@" 4,"].location != NSNotFound  && (i > 44)){
                                    
                                    dfcount += 1;
                                }
                            }
                            
                        }
                    }
                    
                    
                }
                if (selectBool) {
                    changci++;
                    selectBool = NO;
                }
                
            }
            
            
            
        }else{
            for (GC_BetData * da in cellarray) {
                for (int i = 0; i < [da.bufshuarr count]; i++) {
                    
                    if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                        changci++;
                        
                        
                        if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang||matchenum == matchEnumBiFenGuoguan|| matchenum == matchEnumShengFenChaGuoguan ) {
                            if (matchenum == matchenumZongJinQiuShu) {
                                if ([da.onePlural rangeOfString:@" 3,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                    danshiCount += 1;
                                }
                            }else if (matchenum == matchenumBanQuanChang){
                                if ([da.onePlural rangeOfString:@" 4,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                    danshiCount += 1;
                                }
                            }else if (matchenum == matchEnumBiFenGuoguan){
                                if ([da.onePlural rangeOfString:@" 2,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                    danshiCount += 1;
                                }
                            }else if ([da.pluralString rangeOfString:@" 13,"].location != NSNotFound || [da.pluralString isEqualToString:@""]){
                                danshiCount +=1;
                            }
                            
                        }
                        
                        break;
                        
                    }
                    
                    
                    
                    
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
    

    NSLog(@"dancout = %d, changci = %d", (int)dancout, changci);
    

    if (dancout != 0) {//判断是否设胆
        shedan = YES;
    }
    
    
    NSLog(@"dancout = %d", one);
    
    
    NSMutableArray * array = [NSMutableArray array];
    
    //设胆 和未设胆 计算出来的串法 ssssssss
    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumShengFenChaGuoguan) {
        if (shedan) {
            array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:2 GameCount:one];
            
        }else{
            
            
            if (changci > 1) {
                array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:2 GameCount:one];
            }
            if (changci == danshiCount) {
                [array insertObject:@"单关" atIndex:0];
            }
            
            
            
            
            
        }
        
    }else if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
        if (shedan) {
            if (matchenum == MatchEnumLanqiuHunTou) {
                
                if (sfcBool) {
                    array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:20318 GameCount:one];//20318代表 里面含有胜负差玩法
                }else{
                    array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:lotteryID GameCount:one];
                }
                
            }else if(matchenum == matchEnumBigHunHeGuoGan){
                
                if (markBigHunTou == 3) {
                    array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:20318 GameCount:one];
                }else if (markBigHunTou == 2){
                    array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:6 GameCount:one];
                }else{
                    array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:20019 GameCount:one];
                }
                
            }else{
                array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:lotteryID GameCount:one];
            }
            
            
        }else{
            if (matchenum == MatchEnumLanqiuHunTou) {
                if (sfcBool) {//包含胜分差
                    if (changci > 1) {
                        array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:20318 GameCount:one];//[resultList count]
                        
                    }
                    if (sumcount == dfcount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                }else{//没包含胜分差
                    if (changci > 1) {
                        array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:lotteryID GameCount:one];//[resultList count]
                    }
                    
                    
                    if (sumcount == dfcount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                    
                    
                }
                
            }else if (matchenum == matchEnumBigHunHeGuoGan){
                if (markBigHunTou == 3) {
                    
                    
                    if (changci > 1) {
                        array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:20318 GameCount:one];
                        
                    }
                    if (sumcount == dfcount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                    
                }else if (markBigHunTou == 2){
                    if (changci > 1) {
                        array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:6 GameCount:one];
                        
                    }
                    if (sumcount == dfcount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                    
                }else{
                    if (changci > 1) {
                        array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:20019 GameCount:one];
                        
                    }
                    if (sumcount == dfcount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                    
                }
            }else if(matchenum == matchEnumHunHeGuoGuan){
                
                if (changci > 1) {
                    array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:lotteryID GameCount:one];
                }
                
                
                if (sumcount == dfcount) {
                    [array insertObject:@"单关" atIndex:0];
                }
                
            }else{
                
                if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan) {
                    if (changci > 1) {
                        array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:lotteryID GameCount:one];//[resultList count]
                    }
                    if (changci == danshiCount) {
                        [array insertObject:@"单关" atIndex:0];
                    }
                }else{
                    
                    array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:lotteryID GameCount:one];//[resultList count]
                    
                }
                
                
                
                
            }
            
            
            
        }
        
    }else if(matchenum == matchenumBanQuanChang){
        
        if (shedan) {
            array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:5 GameCount:one];
            
        }else{
            
            if (changci > 1) {
                array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:5 GameCount:one];//[resultList count]
            }
            if (changci == danshiCount) {
                [array insertObject:@"单关" atIndex:0];
            }
            
        }
        
    }else if(matchenum == matchenumZongJinQiuShu){
        
        if (shedan) {
            array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:6 GameCount:one];
            
        }else{
            if (changci > 1) {
                array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:6 GameCount:one];//[resultList count]
            }
            
            if (changci == danshiCount) {
                [array insertObject:@"单关" atIndex:0];
            }
            
            
            
            
        }
        
    }
    
    
    if (dancout != 0) {//设胆的情况 下 根据胆的个数 来删掉不能用的串法
        
        for (int i = 1; i <= dancout; i++) {
            if (i != 1) {
                if ([array count] > 0) {
                    [array removeObjectAtIndex:0];
                }
                
                
            }
        }
        
        
        //选几场 如果设有胆  那么 几串一就不能用 删掉
        for (int i = 0; i < [array count]; i++) {
            NSString * st = [array objectAtIndex:i];
            if (![st isEqualToString:@"2串1"]) {
                if ([st isEqualToString:[NSString stringWithFormat:@"%d串1", (int)changci]]) {
                    [array removeObjectAtIndex:i];
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
                    
                    
                    if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
                        
                        if (([[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"单关"]] && [labelch.text isEqualToString:@"单关"]) || [[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d串1", one]]) {
                            [chuantype replaceObjectAtIndex:i withObject:@"1"];
                        }else{
                            [chuantype replaceObjectAtIndex:i withObject:@"0"];
                        }
                        
                    }else{
                        if ([[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d串1", one]]) {
                            [chuantype replaceObjectAtIndex:i withObject:@"1"];
                        }
                    }
                    
                }
                
            }
        }
        
        CP_KindsOfChoose *alert = [[CP_KindsOfChoose alloc] initWithTitle:@"过关方式选择" withChuanNameArray:array andChuanArray:chuantype];
        alert.delegate = self;
        if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang||matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumBigHunHeGuoGan) {
            alert.doubleBool = YES;
        }
        alert.duoXuanBool = YES;
        //    alert.chuancount = [[zhushuDic allKeys] count];
        alert.tag = 10;
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
            NSLog(@"wanfa = %@", betrecorinfo.guguanWanfa);
            NSRange chuanfa = [betrecorinfo.guguanWanfa rangeOfString:@","];
            if (chuanfa.location != NSNotFound) {
                NSArray * chuanfarr = [betrecorinfo.guguanWanfa componentsSeparatedByString:@","];
                
                mm = [chuanfarr count];
                for (int x = 0; x < mm; x++) {
                    NSArray * arrchuan = [[chuanfarr objectAtIndex:x] componentsSeparatedByString:@"x"];
                    NSString * strchuan = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
                    
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
                //mm = 1;
                [chuantype removeAllObjects];
                for (int i = 0; i < [array count]; i++) {
                    [chuantype addObject:@"0"];
                }
                NSArray * arrchuan = [betrecorinfo.guguanWanfa componentsSeparatedByString:@"x"];
                NSString * strchuan = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
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
    //    NSArray * keys = [kebianzidian allKeys];
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
    //        for (int j = 0; j < [mutaarr count]; j++) {
    //            [cellarray addObject:[mutaarr objectAtIndex:j]];
    //        }
    //    }
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
        
        
        //        for (int i = 1; i < 160; i++) {
        //            if (i == sender.tag) {
        //                continue;
        //            }
        //            UIButton * vi = (UIButton *)[cimgev viewWithTag:i];
        //            vi.enabled = NO;
        //        }
        
    }else{
        
        //        for (int i = 1; i < 160; i++) {
        
        //            UIButton * vi = (UIButton *)[cimgev viewWithTag:i];
        //            vi.enabled = YES;
        //        }
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = YES;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
        //  sender.backgroundColor = [UIColor whiteColor];
        buf[sender.tag] = 0;
        addchuan -= 1;
    }
    
    UILabel * vi = sender.titleLabel;// (UILabel *)[sender viewWithTag:sender.tag* 1000];
    NSLog(@"vi = %@", vi.text);
    //    NSString * sss= @"1";
    //    NSNumber * ddd = [NSNumber numberWithInt:0];
    //    [selectedItemsDic setObject:sss forKey:ddd];
    
    
    int currtCount;
    int selecount;
    NSNumber * currtnum;
    NSNumber * countnum;
    //  NSNumber * countnum2;
    //  NSNumber * countnum3;
    int selecout2;
    int selecout3;
    NSMutableDictionary * diction = [NSMutableDictionary dictionaryWithCapacity:0];
    selecount = 0;
    selecout2 = 0;
    //姚福玉添加，把小混投单独计算
    NSMutableArray *selectArray = [NSMutableArray array];
    if (matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan) {
        
        for (GC_BetData * pkb in cellarray) {
            if ((pkb.selection1 && pkb.selection2 == NO)|| (pkb.selection2 && pkb.selection1 == NO)) {
                
                selecount++;
            }
            
            
        }
        for (GC_BetData * pkb in cellarray) {
            if (pkb.selection1 && pkb.selection2) {
                
                selecout2++;
            }
            
            
        }
        if (selecount != 0) {
            currtCount = 1;
            currtnum = [NSNumber numberWithInteger:selecount];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        if (selecout2 != 0) {
            currtCount = 2;
            currtnum = [NSNumber numberWithInteger:selecout2];
            countnum = [NSNumber numberWithInteger:currtCount];
            [diction setObject:currtnum forKey:countnum];
        }
        
        
    }else if (matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchEnumHunHeErXuanYi) {
        
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
        selecout3 = 0;
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
        
    }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan|| matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumShengFenChaGuoguan|| matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
        
        
        for (int m = 0; m < 50; m++) {
            
            selecount = 0;
            
            
            for (GC_BetData * pkb in cellarray) {
                int jishuqi = 0;
                
                //姚福玉添加，用来计算小混投数量，让球数和非让球数数量选择的数量
                int frangqiu = 0;
                int rangqiu = 0;
                

                for (int i = 0; i < [pkb.bufshuarr count]; i++) {
                    if ([[pkb.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                        jishuqi += 1;
                        //姚福玉添加，记录让球数和非让球数
                        if (matchenum == matchEnumHunHeGuoGuan) {
                            if (i < 3) {
                                frangqiu += 1;
                            }
                            else {
                                rangqiu += 1;
                            }
                        }
                    }
                }
                
                if (jishuqi == m+1) {
                    selecount++;
                    //姚福玉添加，记录让球数和非让球数
                    if (matchenum == matchEnumHunHeGuoGuan) {
                        NSMutableArray *itemArray = [NSMutableArray array];
                        if (frangqiu > 0) {
                            [itemArray addObject:[NSString stringWithFormat:@"%d",frangqiu]];
                        }
                        if (rangqiu > 0) {
                            [itemArray addObject:[NSString stringWithFormat:@"%d",rangqiu]];
                        }
                        if ([itemArray count] > 0) {
                            [selectArray addObject:itemArray];
                        }
                    }
                }
                
                
            }
            NSLog(@"m = %d, selecount = %ld", m, (long)selecount);
            
            currtCount = m+1;
            NSLog(@"curr = %ld, sele = %ld", (long)currtCount, (long)selecount);
            
            if (selecount != 0) {
                
                currtnum = [NSNumber numberWithInteger:selecount];
                countnum = [NSNumber numberWithInteger:currtCount];
                [diction setObject:currtnum forKey:countnum];
                
            }
            
        }
        
    }
    
    
    
    
    //    NSLog(@"dict = %@", diction);
    
    
    if (shedan) {// 设胆 情况
        
        //        GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
        //        NSArray *keys = [selectedItemsDic allKeys];
        //
        //        for (NSNumber * stri in keys) {
        //            NSNumber * dd = [selectedItemsDic objectForKey:keys];
        //            NSLog(@"stri = %d", [dd intValue]);
        //        }
        //        [jcalgorithm passData:diction gameCount:[cellarray count] chuan:[vi text]];
        
        
        
        
        if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumRangFenShengFuGuoguan) {
            [shedanArr removeAllObjects];
            for (GC_BetData * bed in cellarray) {
                
                if (bed.selection1 || bed.selection2 || bed.selection3) {
                    if (bed.dandan) {
                        [shedanArr addObject:[NSNumber numberWithInt:1]];
                    }else{
                        [shedanArr addObject:[NSNumber numberWithInt:0]];
                    }
                }
                
                
            }
            if ([m_shedanArr count] == 0) {
                for (int i = 0; i < [kebianzidian count]; i++) {
                    NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
                    for (int j = 0; j < [mutaarr count]; j++) {
                        GC_BetData * pkb = [mutaarr objectAtIndex:j];
                        if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                            //   one++;
                            //   buttoncout++;
                            //   two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
                            int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                            // NSString * string = [string stringByAppendingFormat:@"%d", gc];
                            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                        }
                        
                        
                    }
                }
                
            }
            
        }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan|| matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumShengFenChaGuoguan||matchenum ==MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
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
                        [shedanArr addObject:[NSNumber numberWithInt:1]];
                    }else{
                        [shedanArr addObject:[NSNumber numberWithInt:0]];
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
                        NSLog(@"gc = %d", gc);
                        //                        if (gc != 0) {
                        //                            two = two *gc;
                        //                        }
                        
                        //int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
                        // NSString * string = [string stringByAppendingFormat:@"%d", gc];
                        if (gc != 0) {
                            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
                        }
                    }
                }
                
                
            }
            
        }
        
        
        
        //        NSLog(@"m_shidanarr = %@", m_shedanArr);
        //        NSArray * allk = [danbutDic allKeys];
        //        NSLog(@"allk = %@", allk);
        //        NSLog(@"shedan = %@", shedanArr);
        
        
        NSLog(@"m_shedanarr = %@", m_shedanArr);
        NSLog(@"vi text = %@", [vi  text]);
        NSLog(@"cout = %lu", (unsigned long)[m_shedanArr count]);
        NSLog(@"shedanarr = %@", shedanArr);
        
        GC_NewAlgorithm *newAlgorithm = [[GC_NewAlgorithm alloc] init];
        [newAlgorithm countAlgorithmWithArray:m_shedanArr chuanGuan:[vi text] changCi:[m_shedanArr count] sheDan:(NSArray *)shedanArr];
        
        //  long long  total =[jcalgorithm  totalZhuShuNum];
        long long total = newAlgorithm.reTotalNumber;
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
        
        NSLog(@"longnum = %d, text = %@", [longNum intValue], vi.text);
        
        
        
        //       [totalZhuShuWithDanDic setObject:longNum forKey:[button text]];
        // twoLabel.text= [NSString stringWithFormat:@"%d", [longNum intValue]];
        
        //        if (buf[sender.tag] == 1) {
        [zhushuDic setObject:longNum forKey:vi.text];
        //        }else{
        //            if ([zhushuDic objectForKey:vi.text]) {
        //                [zhushuDic removeObjectForKey:vi.text];
        //            }
        //
        //        }
        [longNum release];
        //        NSNumber * numq = [zhushuDic objectForKey:vi.text];
        //        NSLog(@"%lld", [numq longLongValue]);
        
    }else{// 未设胆情况
        
        GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
        NSLog(@"button text = %@", [vi text]);
        
        //        NSArray *keys = [selectedItemsDic allKeys];
        
        //        for (NSString* stri in keys) {
        //   NSNumber * dd = [selectedItemsDic objectForKey:keys];
        //            NSLog(@"stri = %@", stri);
        //        }
        
        NSLog(@"dict = %@", diction);
        NSLog(@"cell count = %lu", (unsigned long)[cellarray    count]);
        
        //姚福玉添加用新方法计算数目
        BOOL ischuan1 = YES;//是不是串1玩法，只有非串1才走；
        NSArray *array = [[vi text] componentsSeparatedByString:@"串"];
        if ([array count] == 2) {
            if ([[array objectAtIndex:1] integerValue] != 1) {
                ischuan1 = NO;
            }
        }
        if (matchenum == matchEnumHunHeGuoGuan && !ischuan1) {
            [jcalgorithm chaiHunArray:selectArray chuan:[vi text]];
        }
        else {
            [jcalgorithm passData:diction gameCount:[cellarray count] chuan:[vi text]];
        }
        long long  total =[jcalgorithm  totalZhuShuNum];
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
        //  twoLabel.text= [NSString stringWithFormat:@"%d", [longNum longLongValue]];
        
        //        if (buf[sender.tag] == 1) {
        NSLog(@"long = %d vi = %@", [longNum intValue], vi.text);
        
        if ([vi.text isEqualToString:@"单关"]) {
            
            long long jishu = 0;
            
            if (matchenum == matchEnumShengPingFuGuoGuan ||  matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumRangFenShengFuGuoguan ) {
                for (GC_BetData * pkb in cellarray) {
                    
                    if (pkb.selection1 ) {
                        jishu += 1;
                    }
                    if (pkb.selection2 ) {
                        jishu += 1;
                    }
                    if (pkb.selection3 ) {
                        jishu += 1;
                    }
                    
                    
                }
            }else if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou   ||matchenum == matchEnumBigHunHeGuoGan ){
                for (GC_BetData * pkb in cellarray) {
                    
                    for (int i = 0; i < [pkb.bufshuarr count]; i++) {
                        if ([[pkb.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            jishu += 1;
                        }
                    }
                    
                    
                    
                }
                
            }
            
            
            NSNumber *longNum1 = [[NSNumber alloc] initWithLongLong:jishu];
            [zhushuDic setObject:longNum1 forKey:@"单关"];
        }else{
            [zhushuDic setObject:longNum forKey:vi.text];
        }
        
        
        //        }else{
        //            if ([zhushuDic objectForKey:vi.text]) {
        //                [zhushuDic removeObjectForKey:vi.text];
        //            }
        //
        //        }
        
        //     [totalZhuShuDic setObject:longNum forKey:[button text]];
        [longNum release];
        
    }
    
    NSArray * ar = [zhushuDic allKeys];
    
    //    for (NSString * st in ar) {
    //        NSLog(@"st = %@", st);
    //    }

    int n=0;

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
    
    NSArray * arrr = [zhushuDic allKeys];
    
    if ([arrr count] > 1) {
        labelch.text = @"多串...";
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
        chuanButton1.enabled = YES;
        castButton.alpha = 1;
        chuanButton1.alpha = 1;
    }else if([arrr count] == 1){
        labelch.text = [arrr objectAtIndex:0];
        
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
        chuanButton1.enabled = YES;
        castButton.alpha = 1;
        chuanButton1.alpha = 1;
    }else if([arrr count] == 0){
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        chuanButton1.enabled = NO;
        
    }else {
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        chuanButton1.enabled = NO;
        twoLabel.hidden = YES;
    }
    
    //    if ([arrr count] > 5) {
    //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    //        [cai showMessage:@"组合串关不能超过5个"];
    //    }
    
}




- (void)pressChuanBgButton:(UIButton *)sender{
    [cbgview removeFromSuperview];
}




-(void)determineChuPiaoTime
{
    NSString * titleStr = @"";
    if (matchenum == matchEnumRangFenShengFuGuoguan) {
        titleStr = [NSString stringWithFormat:@"让分以出票时为准(%@后)",beginTime];
    }else if (matchenum == matchEnumDaXiaFenGuoguan) {
        titleStr = [NSString stringWithFormat:@"大小总分以出票时为准(%@后)",beginTime];
    }
    NSString * msg = @"";
    if (beginInfo && [beginInfo isKindOfClass:[NSString class]]) {
        msg = beginInfo;
    }
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:titleStr message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    alert.alertTpye = basketballChuPiaoType;
    alert.tag = 111;
    [alert show];
    [alert release];
}

- (void)pressCastButton:(UIButton *)button{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"huancunzancun"];
    [self sysTimeFunc];
    
    [cellarray removeAllObjects];
    //    NSArray * keys = [kebianzidian allKeys];
    for (int i = 0; i < [kebianzidian count]; i++) {
        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [mutaarr count]; j++) {
            
            [cellarray addObject:[mutaarr objectAtIndex:j]];
        }
    }
    if (lanqiubool) {
        [MobClick event:@"event_goucai_xuanhaole_caizhong" label:@"竞彩篮球"];
    }
    else {
        [MobClick event:@"event_goucai_xuanhaole_caizhong" label:@"竞彩足球"];
    }
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan||matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan|| matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumDaXiaoFenDanGuan) {
        
        //        NSArray * ar = [zhushuDic allKeys];
        //        if ([ar count] == 0) {
        
        //            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //            [cai showMessage:@"请选择过关方式"];
        //
        //            [self pressChuanButton];
        //        }else
        
        [zhushuDic removeAllObjects];
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[twoLabel.text longLongValue]];
        [zhushuDic setObject:longNum forKey:@"单关"];
        
        
        if(one < 1){
            //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"至少选择2场比赛" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //        [alert show];
            //        [alert release];
            
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择1场比赛"];
        }else if([twoLabel.text intValue] > 20000){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"单注投注金额不能超过2万"];
            
        }else {
            
            //竞彩投注
            [self requestYujiJangjin];
            
        }
        [longNum release];
        
    }else{
        int qhhbool = 0;
        int hhhbool = 0;
        int allDFS = 0;
        
        int oneP = 0;
        int twop = 0;
        int threep = 0;
        int fourp = 0;
        int fivep = 0;
        if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumBigHunHeGuoGan) {
            
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                
                if (matchenum == matchEnumShengFuGuoguan) {
                    if (da.selection1 || da.selection2 ){
                        if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@"11"].location != NSNotFound) {
                            
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                            
                        }else{
                            allDFS = 2;
                        }
                    }
                    
                } else if (matchenum == matchEnumRangFenShengFuGuoguan ) {
                    if (da.selection1 || da.selection2 ){
                        if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@"12"].location != NSNotFound) {
                            
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                            
                        }else{
                            allDFS = 2;
                        }
                    }
                } else if (matchenum == matchEnumDaXiaFenGuoguan) {
                    if (da.selection1 || da.selection2 ){
                        if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@"14"].location != NSNotFound) {
                            
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                            
                        }else{
                            allDFS = 2;
                        }
                    }
                    
                } else if (matchenum == matchEnumShengPingFuGuoGuan){
                    
                    if (da.selection1 || da.selection2 || da.selection3) {
                        if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                        }else {
                            allDFS = 2;
                        }
                    }
                    
                }else{
                    
                    for (int j = 0; j < [da.bufshuarr count]; j++) {
                        if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                            if (matchenum == matchEnumHunHeGuoGuan) {
                                if ([da.onePlural rangeOfString:@" 1,"].location != NSNotFound && j > 2) {
                                    
                                    if (hhhbool == 0 || hhhbool == 1) {
                                        hhhbool = 1;
                                    }
                                    
                                }else{
                                    if ([da.onePlural rangeOfString:@" 15,"].location == NSNotFound ) {
                                        hhhbool = 2;
                                    }
                                }
                                
                                if ([da.onePlural rangeOfString:@" 15,"].location != NSNotFound && j < 3){
                                    if (qhhbool == 0 || qhhbool == 1) {
                                        qhhbool = 1;
                                    }
                                    
                                }else{
                                    if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound) {
                                        qhhbool = 2;
                                    }
                                    
                                }
                            } else if (matchenum == MatchEnumLanqiuHunTou){
                                
                                
                                if ([da.pluralString isEqualToString:@""]) {
                                    if (oneP == 0 || oneP == 1) {
                                        oneP = 1;
                                    }
                                    if (twop == 0 || twop == 1) {
                                        twop = 1;
                                    }
                                    if (threep == 0 || threep == 1) {
                                        threep = 1;
                                    }
                                    if (fourp == 0 || fourp == 1) {
                                        fourp = 1;
                                    }
                                }else{
                                    if ([da.pluralString rangeOfString:@" 11,"].location != NSNotFound  && j < 2) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 11,"].location == NSNotFound  && j < 2) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 12,"].location != NSNotFound  && (j > 1 && j < 4)) {
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 12,"].location == NSNotFound  && (j > 1 && j < 4)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 14,"].location != NSNotFound  && (j > 3 && j < 6)) {
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 14,"].location == NSNotFound  && (j > 3 && j < 6)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            
                                        }
                                        
                                    }
                                    
                                    
                                    if ([da.pluralString rangeOfString:@" 13,"].location != NSNotFound  && j > 5) {
                                        if (fourp == 0 || fourp == 1) {
                                            fourp = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 13,"].location == NSNotFound  && j > 5) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                    }
                                    
                                }
                                
                                
                                
                                
                            }else if (matchenum == matchEnumBigHunHeGuoGan){
                                if ([da.pluralString isEqualToString:@""]) {
                                    if (oneP == 0 || oneP == 1) {
                                        oneP = 1;
                                    }
                                    if (twop == 0 || twop == 1) {
                                        twop = 1;
                                    }
                                    if (threep == 0 || threep == 1) {
                                        threep = 1;
                                    }
                                    if (fourp == 0 || fourp == 1) {
                                        fourp = 1;
                                    }
                                    if (fivep == 0 || fivep == 1) {
                                        fivep = 1;
                                    }
                                }else{
                                    if ([da.pluralString rangeOfString:@" 1,"].location != NSNotFound  && j < 3) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 1,"].location == NSNotFound  && j < 3) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 15,"].location != NSNotFound  && (j > 2 && j < 6)) {
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 15,"].location == NSNotFound  && (j > 2 && j < 6)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 3,"].location != NSNotFound  && (j > 5 && j < 14 )) {
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 3,"].location == NSNotFound  && (j > 5 && j < 14)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    if ([da.pluralString rangeOfString:@" 2,"].location != NSNotFound  && (j > 13 && j < 45 )) {
                                        if (threep == 0 || threep == 1) {
                                            fourp = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 2,"].location == NSNotFound  && (j > 13 && j < 45)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    if ([da.pluralString rangeOfString:@" 4,"].location != NSNotFound  && j > 44) {
                                        if (fourp == 0 || fourp == 1) {
                                            fivep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 4,"].location == NSNotFound  && j > 44) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                    }
                                    
                                }
                                
                            }else{
                                
                                if (matchenum == matchenumZongJinQiuShu) {
                                    if ([da.onePlural rangeOfString:@" 3,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                        if (allDFS == 0 || allDFS == 1) {
                                            allDFS = 1;
                                        }
                                    }else{
                                        allDFS = 2;
                                    }
                                }else if (matchenum == matchenumBanQuanChang){
                                    if ([da.onePlural rangeOfString:@" 4,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                        if (allDFS == 0 || allDFS == 1) {
                                            allDFS = 1;
                                        }
                                    }else{
                                        allDFS = 2;
                                    }
                                }else if (matchenum == matchEnumBiFenGuoguan){
                                    if ([da.onePlural rangeOfString:@" 2,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                        if (allDFS == 0 || allDFS == 1) {
                                            allDFS = 1;
                                        }
                                    }else{
                                        allDFS = 2;
                                    }
                                }else if (matchenum == matchEnumShengFenChaGuoguan){
                                    if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@"13"].location != NSNotFound) {
                                        if (allDFS == 0 || allDFS == 1) {
                                            allDFS = 1;
                                        }
                                    }else{
                                        allDFS = 2;
                                    }
                                }
                                
                                
                            }
                            
                            
                            
                        }
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        
        if (one < 2 && !(matchenum == matchEnumBigHunHeGuoGan && (fivep == 1 || oneP == 1 || twop == 1 || threep == 1 || fourp == 1)) &&  !(matchenum == MatchEnumLanqiuHunTou && (oneP == 1 || twop == 1 || threep == 1 || fourp == 1)) && !((matchenum == matchEnumHunHeGuoGuan && (hhhbool == 1 || qhhbool == 1))) && !((matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumShengFenChaGuoguan ||matchenum == matchEnumShengPingFuGuoGuan  || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang) && allDFS == 1)) {
            
            if ( (matchenum == matchEnumBigHunHeGuoGan && (!(oneP == 1 || twop == 1 || threep == 1 || fourp == 1 || fivep == 1)))||(matchenum == MatchEnumLanqiuHunTou && (!(oneP == 1 || twop == 1 || threep == 1 || fourp == 1))) ||   (matchenum == matchEnumHunHeGuoGuan && (!( qhhbool == 1 || hhhbool == 1))) || ((matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFenChaGuoguan ||matchenum == matchEnumDaXiaFenGuoguan ) && allDFS != 1)) {
                
                //弹框
                FootballHintView * hintView = [[FootballHintView alloc] initType:betShowType];
                [hintView show];
                [hintView release];
                return;
            }else{
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"至少选择2场比赛"];
                return;
                
                
                
            }
            
        }
        
        
        
        
        NSArray * ar = [zhushuDic allKeys];
        
        if (matchenum == MatchEnumLanqiuHunTou && sfcBool && sfcDanCount > 3) {
            [self pressChuanButton];
            return;
        }
        
        if ([ar count] == 0) {
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请选择过关方式"];
            [self pressChuanButton];
            
            
            
        }else if(one < 2  && !(matchenum == matchEnumBigHunHeGuoGan && (fivep == 1 ||oneP == 1 || twop == 1 || threep == 1 || fourp == 1))  && !(matchenum == MatchEnumLanqiuHunTou && (oneP == 1 || twop == 1 || threep == 1 || fourp == 1))  &&!((matchenum == matchEnumHunHeGuoGuan && (qhhbool == 1 ||  hhhbool == 1))) && !((matchenum == matchEnumShengPingFuGuoGuan  || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumDaXiaFenGuoguan) && allDFS == 1)){
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择2场比赛"];
        }else if([twoLabel.text intValue] > 20000){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"单注投注金额不能超过2万"];
            
        }else {
            castButton.enabled = NO;
            
            if (beginTime && [beginTime length] && canShow) {
                [self determineChuPiaoTime];
                return;
            }
            
            canShow = YES;
            
            //竞彩投注
            [self requestYujiJangjin];
            
        }
        
        
    }
}
- (NSArray *)bigHuntouInfoStringFunc{
    
    NSString * str = @"";//拼投注的选项
    NSString * ddMatchStr = @"";//拼单关选中的场次
    NSString * ddInfoStr = @"";//拼单关选中的赔率
    


    
    if (matchenum == matchEnumHunHeGuoGuan) {
        NSArray * caiArray = [NSArray arrayWithObjects:@"胜", @"平", @"负", @"让胜", @"让平", @"让负",  nil];
        
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
                
                str = [NSString stringWithFormat:@"%@%@:", str, da.changhao];
                
               
                
                BOOL oneSelect = NO;//第一段
                NSString * oneStr = @"";
                NSString * oneDdInfoString = @"";
                for (int a = 0; a < 3; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        
                        oneSelect = YES;
                        oneStr = [NSString stringWithFormat:@"%@%@|%@,", oneStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 1,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            oneDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", oneDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                }
                if ([oneStr length] > 0) {
                    oneStr = [oneStr substringToIndex:[oneStr length] - 1];
                }
                
                if ([oneDdInfoString length] > 0) {
                    oneDdInfoString = [oneDdInfoString substringToIndex:[oneDdInfoString length] - 1];
                    
                }
                
                BOOL twoSelect = NO;//第二段
                NSString * twoStr = @"";
                NSString * twoDdInfoString = @"";
                for (int a = 3; a < 6; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        twoSelect = YES;
                        NSArray * teamarray = [da.team componentsSeparatedByString:@","];
                        NSString * rang = @"";
                        if ([teamarray count] >= 3) {
                            rang = [teamarray objectAtIndex:2];
                        }
                        twoStr = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoStr, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 15,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            
                            twoDdInfoString = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoDdInfoString, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        }
                    }
                    
                }
                
                if ([twoDdInfoString length] > 0) {
                    twoDdInfoString = [twoDdInfoString substringToIndex:[twoDdInfoString length] - 1];
                    
                }
                
                if ([twoStr length] > 0) {
                    twoStr = [twoStr substringToIndex:[twoStr length] - 1];
                }
                
                
                
                if (oneSelect) {
                    
                    str = [NSString stringWithFormat:@"%@10_%@-", str, oneStr];
                    
                }
                
                if (twoSelect) {
                    
                    str = [NSString stringWithFormat:@"%@01_%@-", str, twoStr];
                }
                
                NSString * zjstr = @"";
                if ([oneDdInfoString length] > 0 || [twoDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@:", da.changhao];
                }
                if ([oneDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@10_%@-", zjstr, oneDdInfoString];
                }
                if ([twoDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@10_%@-", zjstr, twoDdInfoString];
                }
                if ([zjstr length] > 0) {
                    ddInfoStr = [NSString stringWithFormat:@"%@%@", ddInfoStr, zjstr];
                    NSString * ddMatchString = [NSString stringWithFormat:@"%@:1", da.changhao];
                    ddMatchStr = [NSString stringWithFormat:@"%@%@;", ddMatchStr, ddMatchString];
                }
                
                if ([ddInfoStr length] > 0) {
                    
                    ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
                    ddInfoStr = [NSString stringWithFormat:@"%@/", ddInfoStr];
                    
                }
                
                if ([str length] > 0 &&(oneSelect || twoSelect )) {
                    str = [str substringToIndex:[str length] - 1];
                    str = [NSString stringWithFormat:@"%@/", str];
                }
                
                
                
                
                
            }
            
            
        }
        
        if ([str length] > 0) {
            str = [str substringToIndex:[str length] - 1];
            
        }
        if ([ddInfoStr length] > 0) {
            ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
        }
        if ([ddMatchStr length] > 0) {
            ddMatchStr = [ddMatchStr substringToIndex:[ddMatchStr length] - 1];
        }
        
        NSLog(@"bighuntou = %@", str);
        NSLog(@"ddMatchStr = %@", ddMatchStr);
        NSLog(@"ddInfoStr = %@", ddInfoStr);
        
        
        
        NSArray * returnArr = [NSArray arrayWithObjects:str, ddMatchStr,ddInfoStr, nil];
        
        return returnArr;
    }
    else if (matchenum == matchEnumBigHunHeGuoGan){
        NSArray * caiArray = [NSArray arrayWithObjects:@"胜", @"平", @"负", @"让胜", @"让平", @"让负",@"0", @"1",@"2", @"3", @"4", @"5", @"6", @"7+",@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", @"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负",  nil];
        
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
                
                str = [NSString stringWithFormat:@"%@%@:", str, da.changhao];
                
                NSString * oneDdInfoString = @"";
                
                BOOL oneSelect = NO;//第一段
                NSString * oneStr = @"";
                for (int a = 0; a < 3; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        
                        oneSelect = YES;
                        oneStr = [NSString stringWithFormat:@"%@%@|%@,", oneStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 1,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            oneDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", oneDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                }
                if ([oneStr length] > 0) {
                    oneStr = [oneStr substringToIndex:[oneStr length] - 1];
                }
                if ([oneDdInfoString length] > 0) {
                    oneDdInfoString = [oneDdInfoString substringToIndex:[oneDdInfoString length] - 1];
                    
                }
                
                BOOL twoSelect = NO;//第二段
                NSString * twoStr = @"";
                NSString * twoDdInfoString = @"";
                for (int a = 3; a < 6; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        twoSelect = YES;
                        NSArray * teamarray = [da.team componentsSeparatedByString:@","];
                        NSString * rang = @"";
                        if ([teamarray count] >= 3) {
                            rang = [teamarray objectAtIndex:2];
                        }
                        twoStr = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoStr, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 15,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            twoDdInfoString = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoDdInfoString, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        }
                    }
                    
                }
                if ([twoStr length] > 0) {
                    twoStr = [twoStr substringToIndex:[twoStr length] - 1];
                }
                if ([twoDdInfoString length] > 0) {
                    twoDdInfoString = [twoDdInfoString substringToIndex:[twoDdInfoString length] - 1];
                    
                }
                
                BOOL threeSelect = NO;//第三段
                NSString * threeStr = @"";
                NSString * threeDdInfoString = @"";
                for (int a = 6; a < 14; a++) {
                    
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        threeSelect = YES;
                        threeStr = [NSString stringWithFormat:@"%@%@|%@,", threeStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 3,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            threeDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", threeDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                    
                }
                if ([threeStr length] > 0) {
                    threeStr = [threeStr substringToIndex:[threeStr length] - 1];
                }
                if ([threeDdInfoString length] > 0) {
                    threeDdInfoString = [threeDdInfoString substringToIndex:[threeDdInfoString length] - 1];
                }
                BOOL fourSelect = NO;//第四段
                NSString * fourStr = @"";
                NSString * fourDdInfoString = @"";
                for (int a = 14; a < 45; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        fourSelect = YES;
                        fourStr = [NSString stringWithFormat:@"%@%@|%@,", fourStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 2,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            fourDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", fourDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                }
                if ([fourStr length] > 0) {
                    fourStr = [fourStr substringToIndex:[fourStr length] - 1];
                }
                if ([fourDdInfoString length] > 0) {
                    fourDdInfoString = [fourDdInfoString substringToIndex:[fourDdInfoString length] - 1];
                }

                
                BOOL fiveSelect = NO;//第五段
                NSString * fiveStr = @"";
                NSString * fiveDdInfoString = @"";
                for (int a = 45; a < 54; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        fiveSelect = YES;
                        fiveStr = [NSString stringWithFormat:@"%@%@|%@,", fiveStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 4,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            fiveDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", fiveDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                }
                
                
                if ([fiveDdInfoString length] > 0) {
                     fiveDdInfoString = [fiveDdInfoString substringToIndex:[fiveDdInfoString length] - 1];
                }
                
                if ([fiveStr length] > 0) {
                    fiveStr = [fiveStr substringToIndex:[fiveStr length] - 1];
                }
                NSLog(@"one = %@     two = %@    three = %@     four = %@     five = %@", oneStr, twoStr, threeStr, fourStr, fiveStr );
                
                if (oneSelect) {
                    
                    str = [NSString stringWithFormat:@"%@10_%@-", str, oneStr];
                    
                }
                
                if (twoSelect) {
                    
                    str = [NSString stringWithFormat:@"%@01_%@-", str, twoStr];
                }
                
                if (threeSelect) {
                    
                    str = [NSString stringWithFormat:@"%@03_%@-", str, threeStr];
                    
                }
                
                if (fourSelect) {
                    
                    str = [NSString stringWithFormat:@"%@05_%@-", str, fourStr];
                    
                }
                
                if (fiveSelect) {
                    
                    str = [NSString stringWithFormat:@"%@04_%@-", str, fiveStr];
                    
                }
                
                NSString * zjstr = @"";
                if ([oneDdInfoString length] > 0 || [twoDdInfoString length] > 0 || [threeDdInfoString length] > 0 || [fourDdInfoString length] > 0 || [fiveDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@:", da.changhao];
                }
                
                if ([oneDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@10_%@-", zjstr, oneDdInfoString];
                }
                if ([twoDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@01_%@-", zjstr, twoDdInfoString];
                }
                if ([threeDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@03_%@-", zjstr, threeDdInfoString];
                }
                if ([fourDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@05_%@-", zjstr, fourDdInfoString];
                }
                if ([fiveDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@04_%@-", zjstr, fiveDdInfoString];
                }
                if ([zjstr length] > 0) {
                    ddInfoStr = [NSString stringWithFormat:@"%@%@", ddInfoStr, zjstr];
                    NSString * ddMatchString = [NSString stringWithFormat:@"%@:1", da.changhao];
                    ddMatchStr = [NSString stringWithFormat:@"%@%@;", ddMatchStr, ddMatchString];
                }
                if ([ddInfoStr length] > 0) {
                    
                    ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
                    ddInfoStr = [NSString stringWithFormat:@"%@/", ddInfoStr];
                    
                    
                }
                
               
                if ([str length] > 0 &&(oneSelect || twoSelect || threeSelect || fourSelect || fiveSelect)) {
                    str = [str substringToIndex:[str length] - 1];
                    str = [NSString stringWithFormat:@"%@/", str];
                }
                
            }
            
            
        }
        
        if ([str length] > 0) {
            str = [str substringToIndex:[str length] - 1];
            
        }
        if ([ddInfoStr length] > 0) {
            ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
        }
        if ([ddMatchStr length] > 0) {
            ddMatchStr = [ddMatchStr substringToIndex:[ddMatchStr length] - 1];
        }
        
        NSLog(@"bighuntou = %@", str);
        NSLog(@"ddMatchStr = %@", ddMatchStr);
        NSLog(@"ddInfoStr = %@", ddInfoStr);
         NSArray * returnArr = [NSArray arrayWithObjects:str, ddMatchStr,ddInfoStr, nil];
        return returnArr;
    }
    else if (matchenum == MatchEnumLanqiuHunTou){
        
        NSArray * caiArray = [NSArray arrayWithObjects:@"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1#5", @"主胜6#10", @"主胜11#15", @"主胜16#20", @"主胜21#25", @"主胜26+",  @"客胜1#5", @"客胜6#10", @"客胜11#15", @"客胜16#20", @"客胜21#25", @"客胜26+", nil];
        
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
                NSString * oneDdInfoString = @"";
                str = [NSString stringWithFormat:@"%@%@:", str, da.changhao];
                
                
                
                BOOL oneSelect = NO;//第一段
                NSString * oneStr = @"";
                for (int a = 0; a < 2; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        
                        oneSelect = YES;
                        oneStr = [NSString stringWithFormat:@"%@%@|%@,", oneStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 11,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                           
                            oneDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", oneDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }

                    }
                    
                    
                }
                if ([oneStr length] > 0) {
                    oneStr = [oneStr substringToIndex:[oneStr length] - 1];
                }
                if ([oneDdInfoString length] > 0) {
                    oneDdInfoString = [oneDdInfoString substringToIndex:[oneDdInfoString length] - 1];
                }
                
                BOOL twoSelect = NO;//第二段
                NSString * twoStr = @"";
                NSString * twoDdInfoString = @"";
                for (int a = 2; a < 4; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        twoSelect = YES;
                        NSArray * teamarray = [da.team componentsSeparatedByString:@","];
                        NSString * rang = @"";
                        if ([teamarray count] >= 3) {
                            rang = [teamarray objectAtIndex:2];
                        }
                        twoStr = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoStr, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        
                        
                        if ([da.pluralString rangeOfString:@" 12,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                         
                            twoDdInfoString = [NSString stringWithFormat:@"%@%@(%@)|%@,", twoDdInfoString, [caiArray objectAtIndex:a], rang,[da.oupeiarr objectAtIndex:a]];
                        }
                    }
                    
                    
                    
                }
                if ([twoStr length] > 0) {
                    twoStr = [twoStr substringToIndex:[twoStr length] - 1];
                }
                if ([twoDdInfoString length] > 0) {
                    twoDdInfoString = [twoDdInfoString substringToIndex:[twoDdInfoString length] - 1];
                }
                
                BOOL threeSelect = NO;//第三段
                NSString * threeStr = @"";
                NSString * threeDdInfoString = @"";
                for (int a = 4; a < 6; a++) {
                    
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        threeSelect = YES;
                        NSString * rang = @"";
                        NSArray * teamarray = [da.team componentsSeparatedByString:@","];
                        if ([teamarray count] > 3) {
                            rang = [teamarray objectAtIndex:3];
                        }
                        threeStr = [NSString stringWithFormat:@"%@%@(%@)|%@,", threeStr, [caiArray objectAtIndex:a], rang, [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 14,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            threeDdInfoString = [NSString stringWithFormat:@"%@%@(%@)|%@,", threeDdInfoString, [caiArray objectAtIndex:a], rang, [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                    
                }
                if ([threeStr length] > 0) {
                    threeStr = [threeStr substringToIndex:[threeStr length] - 1];
                }
                if ([threeDdInfoString length] > 0) {
                    threeDdInfoString = [threeDdInfoString substringToIndex:[threeDdInfoString length] - 1];
                }
                
                BOOL fourSelect = NO;//第四段
                NSString * fourStr = @"";
                NSString * fourDdInfoString = @"";
                for (int a = 6; a < 18; a++) {
                    if ([[da.bufshuarr objectAtIndex:a] isEqualToString:@"1"]) {
                        fourSelect = YES;
                        fourStr = [NSString stringWithFormat:@"%@%@|%@,", fourStr, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        if ([da.pluralString rangeOfString:@" 13,"].location != NSNotFound || [da.pluralString isEqualToString:@""]) {
                            
                            fourDdInfoString = [NSString stringWithFormat:@"%@%@|%@,", fourDdInfoString, [caiArray objectAtIndex:a], [da.oupeiarr objectAtIndex:a]];
                        }
                    }
                }
                if ([fourStr length] > 0) {
                    fourStr = [fourStr substringToIndex:[fourStr length] - 1];
                }
                
               
              
                if ([fourDdInfoString length] > 0) {
                    fourDdInfoString = [fourDdInfoString substringToIndex:[fourDdInfoString length] - 1];
                    
                }
                
                NSLog(@"one = %@     two = %@    three = %@     four = %@  ", oneStr, twoStr, threeStr, fourStr );
                
                if (oneSelect) {
                    
                    str = [NSString stringWithFormat:@"%@06_%@-", str, oneStr];
                    
                }
                
                if (twoSelect) {
                    
                    str = [NSString stringWithFormat:@"%@07_%@-", str, twoStr];
                }
                
                if (threeSelect) {
                    
                    str = [NSString stringWithFormat:@"%@09_%@-", str, threeStr];
                    
                }
                
                if (fourSelect) {
                    
                    str = [NSString stringWithFormat:@"%@08_%@-", str, fourStr];
                    
                }
                NSString * zjstr = @"";
                if ([oneDdInfoString length] > 0 || [twoDdInfoString length] > 0 || [threeDdInfoString length] > 0 || [fourDdInfoString length] > 0 ) {
                    zjstr = [NSString stringWithFormat:@"%@:", da.changhao];
                }
             
                if ([oneDdInfoString length] > 0) {
                     zjstr = [NSString stringWithFormat:@"%@06_%@-", zjstr, oneDdInfoString];
                }
                if ([twoDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@07_%@-", zjstr, twoDdInfoString];
                }
                if ([threeDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@09_%@-", zjstr, threeDdInfoString];
                }
                if ([fourDdInfoString length] > 0) {
                    zjstr = [NSString stringWithFormat:@"%@08_%@-", zjstr, fourDdInfoString];
                }
                if ([zjstr length] > 0) {
                    ddInfoStr = [NSString stringWithFormat:@"%@%@", ddInfoStr, zjstr];
                    NSString * ddMatchString = [NSString stringWithFormat:@"%@:1", da.changhao];
                    ddMatchStr = [NSString stringWithFormat:@"%@%@;", ddMatchStr, ddMatchString];
                }
                if ([ddInfoStr length] > 0) {
                    
                    ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
                    ddInfoStr = [NSString stringWithFormat:@"%@/", ddInfoStr];
                   
                }
                
                if ([str length] > 0 &&(oneSelect || twoSelect || threeSelect || fourSelect )) {
                    str = [str substringToIndex:[str length] - 1];
                    str = [NSString stringWithFormat:@"%@/", str];
                }
                

                
            }
            
            
        }
        
        if ([ddInfoStr length] > 0) {
            ddInfoStr = [ddInfoStr substringToIndex:[ddInfoStr length] - 1];
        }
        if ([ddMatchStr length] > 0) {
            ddMatchStr = [ddMatchStr substringToIndex:[ddMatchStr length] - 1];
        }
        
        if ([str length] > 0) {
            str = [str substringToIndex:[str length] - 1];
            
        }
        
        NSLog(@"bighuntou = %@", str);
        NSLog(@"ddMatchStr = %@", ddMatchStr);
        NSLog(@"ddInfoStr = %@", ddInfoStr);
        NSArray * returnArr = [NSArray arrayWithObjects:str, ddMatchStr,ddInfoStr, nil];
        return returnArr;
    }
    
    return nil;
}


- (void)hunHeGuoGuanFunc{
    int qhhbool = 0;
    int hhhbool = 0;
    BOOL qplayBool = NO;
    BOOL hplayBool = NO;
    for (int i = 0; i < [cellarray count]; i++) {
        GC_BetData * da = [cellarray objectAtIndex:i];
        for (int j = 0; j < [da.bufshuarr count]; j++) {
            
            if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                if ([da.onePlural rangeOfString:@" 1,"].location != NSNotFound && j > 2) {
                    
                    if (hhhbool == 0 || hhhbool == 1) {
                        hhhbool = 1;
                    }
                    
                }else{
                    if ([da.onePlural rangeOfString:@" 15,"].location == NSNotFound) {
                        hhhbool = 2;
                    }
                    
                }
                
                if ([da.onePlural rangeOfString:@" 15,"].location != NSNotFound && j < 3){
                    if (qhhbool == 0 || qhhbool == 1) {
                        qhhbool = 1;
                    }
                    
                }else{
                    if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound) {
                        qhhbool = 2;
                    }
                    
                }
                
                if (j > 2) {
                    hplayBool = YES;
                }else if(j < 3){
                    qplayBool = YES;
                }
            }
            
            
        }
        
    }
    
    if (qhhbool == 1 || hhhbool == 1) {
        
        oneDoubleBool = YES;
        
        
    }else{
        oneDoubleBool = NO;
    }
    
    if ((hplayBool == YES && qplayBool == NO) || (hplayBool == NO && qplayBool == YES)) {
        onePlayingBool = YES;
        if (hplayBool == NO && qplayBool == YES) {
            oneSPFCount = 1;
        }else if (hplayBool == YES && qplayBool == NO){
            oneSPFCount = 2;
        }
    }else{
        onePlayingBool = NO;
    }
    
    
}

- (void)requestYujiJangjin{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    
    
    NSMutableString *strshedan = [[[NSMutableString alloc] init] autorelease];
    NSInteger zongchangci = 0;
    
    if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan) {
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
        
    }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan  || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan|| matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
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
        
        
        
    }
    
    
    NSLog(@"strshedan = %@", strshedan);
    
    NSArray * arr = [zhushuDic allKeys];
    NSString *passTypeSet = @"";
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumDaXiaoFenDanGuan) {
        passTypeSet = @"单关";
        
    }else if(matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumHunHeGuoGuan||matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
        for (int i = 0; i < [arr count]; i++) {
            NSLog(@"chuan = %@", [arr objectAtIndex:i]);
            
            
            if (i!=arr.count-1){
                NSString * com = [arr objectAtIndex:i];
                if ([com isEqualToString:@"单关"]) {
                    passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                }else{
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                    passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                }
                
                
            }else{
                
                NSString * com = [arr objectAtIndex:i];
                if ([com isEqualToString:@"单关"]) {
                    passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                }else{
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                    passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                }
                
                
            }
        }
        
        passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
        
    }
    
    
    
    passTypeSet = [NSString stringWithFormat:@"%@@iphone", passTypeSet];
    NSLog(@"fangshi = %@", passTypeSet);
    
    
    if (matchenum == matchEnumHunHeGuoGuan || matchenum == MatchEnumLanqiuHunTou) {
        strshedan = [NSMutableString stringWithFormat:@"%@@huntou", strshedan];
    }
    
    NSMutableData * postData = nil;
    
    
    NSString * lotteryStr = @"";
    if ( matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan) {
        lotteryStr = @"200";
    }else if(matchenum == matchEnumBigHunHeGuoGan||matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumHunHeErXuanYi ){
        lotteryStr = @"202";
        
    }else if(matchenum == MatchEnumLanqiuHunTou){
        lotteryStr = @"203";
        
    }else{
        lotteryStr = @"201";
    }
    
    NSString * playStr = @"";
    
    if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan) {
        playStr = @"05";
    }else if(matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan){
        playStr = @"10";
    }else if(matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
        playStr = @"03";
    }else if(matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
        playStr = @"04";
    }else if(matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan){
        playStr = @"06";
    }else if(matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan){
        playStr = @"07";
    }else if(matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumShengFenChaDanGuan){
        playStr = @"08";
    }else if(matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
        playStr = @"09";
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        playStr = @"01";
    }else if(matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumHunHeErXuanYi || matchenum == matchEnumBigHunHeGuoGan){
        playStr = @"01";
        if (matchenum == matchEnumHunHeGuoGuan) {
            
            [self hunHeGuoGuanFunc];
            
            if (onePlayingBool) { //如果都为一种 胜平负 或 让球胜平负
                
                //                if (oneDoubleBool) { // 如果为单关
                
                if (oneSPFCount == 1) {
                    playStr = @"01";
                }else if (oneSPFCount == 2){
                    playStr = @"10";
                }
                
                //                }
                
            }
        }
    }else if(matchenum == MatchEnumLanqiuHunTou){
        //    ddddd
        playStr = @"01";
        
    }
    
    NSArray * infoArr = [self bigHuntouInfoStringFunc] ;
    NSString * infoStr1 = @"";
    NSString * infoStr2 = @"";
    NSString * infoStr3 = @"";
    if ([infoArr count] > 2) {
        infoStr1 = [infoArr objectAtIndex:0];
        infoStr2 = [infoArr objectAtIndex:1];
        infoStr3 = [infoArr objectAtIndex:2];
    }
    
    if (matchenum == matchEnumBigHunHeGuoGan || matchenum == matchEnumHunHeGuoGuan || matchenum == MatchEnumLanqiuHunTou) {
        postData = [[GC_HttpService sharedInstance] bigHunToureqGetIssueInfo:[self issueInfoReturn] cishu:zongchangci fangshi:passTypeSet shedan:strshedan beishu:1 touzhuInfo:infoStr1 lottery:lotteryStr play:playStr ddInfo:infoStr2 ddpvInfo:infoStr3];//真正的请求
        
        
    }else{
        postData = [[GC_HttpService sharedInstance] reqGetIssueInfo:[self issueInfoReturn] cishu:zongchangci fangshi:passTypeSet shedan:strshedan beishu:1 touzhuxuanxiang:[self touzhuOpeiReturn] lottrey:lotteryStr play:playStr];
    }
    
    
    
    [yujirequest clearDelegatesAndCancel];
    
    self.yujirequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [yujirequest setRequestMethod:@"POST"];
    [yujirequest addCommHeaders];
    [yujirequest setPostBody:postData];
    [yujirequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yujirequest setDelegate:self];
    [yujirequest setDidFinishSelector:@selector(yujiJiangjinRequest:)];
    [yujirequest setDidFailSelector:@selector(yujiJiangjinFailRequest:)];
    [yujirequest startAsynchronous];
}

- (void)yujiJiangjinFailRequest:(ASIHTTPRequest *)mrequest
{
    castButton.enabled = YES;
}


- (void)yujiJiangjinRequest:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        //投注界面
        
        GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
        sheng.chaodanbool = chaodanbool;
        sheng.saveKey = [self objectKeyString];
        sheng.title = @"竞彩足球胜平负";
        NSLog(@"%d", two);
        
        //        if (two == 1) {
        //            sheng.danfushi = 0;
        //        } else{
        sheng.danfushi = 1;
        //        }
        
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"";
        }
        
        sheng.bettingArray = allcellarr;
        if (matchenum  == matchEnumShengPingFuGuoGuan){
            
            sheng.fenzhong = jingcaipiao;
            //  sheng.danguanbool = NO;
            
            NSArray * chuanarr = [zhushuDic allKeys];
            sheng.isxianshiyouhuaBtn = YES;
            if ([chuanarr count] == 1) {
                if ([[chuanarr objectAtIndex:0] isEqualToString:@"2串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"3串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"4串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"5串1"]) {
                    
                    if (one <= 5) {
                        sheng.youhuaBool = YES;
                    }
                    if (allbutcount <= 12) {
                        sheng.youhuaZhichi = YES;
                    }
                    
                }
            }
            
            
        }else if(matchenum == matchEnumBiFenGuoguan){
            
            sheng.fenzhong = jingcaibifen;
            //  sheng.danguanbool = NO;
        }else if(matchenum == matchenumBanQuanChang){
            
            sheng.fenzhong = banquanchangshengpingfu;
            //  sheng.danguanbool = NO;
        }else if(matchenum == matchenumZongJinQiuShu){
            
            sheng.fenzhong = zongjinqiushu;
            //  sheng.danguanbool = NO;
        }else if(matchenum == matchEnumShengPingFuDanGuan){
            
            sheng.fenzhong = jingcaipiao;
        }else if(matchenum == matchEnumBanQuanChangDanGuan){
            
            sheng.fenzhong = banquanchangshengpingfu;
            // sheng.danguanbool = YES;
            
        }else if(matchenum == matchEnumBiFenDanGuan){
            
            sheng.fenzhong = jingcaibifen;
            //  sheng.danguanbool = YES;
        }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
            
            sheng.fenzhong = zongjinqiushu;
            //  sheng.danguanbool = YES;
        }else if(matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan){
            sheng.fenzhong = jingcailanqiushengfu;
        }else if(matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
            sheng.fenzhong = jingcailanqiurangfenshengfu;
        }else if(matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumShengFenChaDanGuan){
            sheng.fenzhong = jingcailanqiushengfencha;
        }else if(matchenum == MatchEnumLanqiuHunTou){
            sheng.fenzhong = lanqiuhuntou;
        }else if(matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan){
            sheng.fenzhong = jingcailanqiudaxiaofen;
        }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan){
            sheng.fenzhong = jingcairangfenshengfu;
            if (matchenum == matchEnumRangQiuShengPingFuGuoGuan) {
                NSArray * chuanarr = [zhushuDic allKeys];
                sheng.isxianshiyouhuaBtn = YES;
                if ([chuanarr count] == 1) {
                    if ([[chuanarr objectAtIndex:0] isEqualToString:@"2串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"3串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"4串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"5串1"]) {
                        
                        if (one <= 5) {
                            sheng.youhuaBool = YES;
                        }
                        if (allbutcount <= 12) {
                            sheng.youhuaZhichi = YES;
                        }
                        
                    }
                }
            }
        }else if(matchenum == matchEnumHunHeGuoGuan){
            sheng.fenzhong = jingcaihuntou;
            NSArray * chuanarr = [zhushuDic allKeys];
            sheng.isxianshiyouhuaBtn = YES;
            if ([chuanarr count] == 1) {
                if ([[chuanarr objectAtIndex:0] isEqualToString:@"2串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"3串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"4串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"5串1"]) {
                    
                    if (one <= 5) {
                        sheng.youhuaBool = YES;
                    }
                    if (allbutcount <= 12) {
                        sheng.youhuaZhichi = YES;
                    }
                    
                }
            }
            
            sheng.oneSPFCount = oneSPFCount;
            sheng.onePlayingBool = onePlayingBool;
            sheng.oneDoubleBool = oneDoubleBool;
            
        }else if(matchenum == matchEnumHunHeErXuanYi){
            sheng.fenzhong = jingcaihuntouerxuanyi;
            NSArray * chuanarr = [zhushuDic allKeys];
            sheng.isxianshiyouhuaBtn = YES;
            if ([chuanarr count] == 1) {
                if ([[chuanarr objectAtIndex:0] isEqualToString:@"2串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"3串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"4串1"]||[[chuanarr objectAtIndex:0] isEqualToString:@"5串1"]) {
                    
                    if (one <= 5) {
                        sheng.youhuaBool = YES;
                    }
                    if (allbutcount <= 12) {
                        sheng.youhuaZhichi = YES;
                    }
                    
                }
            }
        }else if (matchenum == matchEnumBigHunHeGuoGan){
            sheng.fenzhong = jingcaidahuntou;
            
        }
        
        sheng.moneynum = twoLabel.text;
        sheng.zhushu = [NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
        sheng.jingcai = YES;
        sheng.zhushudict = zhushuDic;
        
        
        //        if (matchenum == matchEnumShengFenChaDanGuan||matchenum == matchEnumBiFenDanGuan) {
        //            sheng.maxmoneystr = [NSString stringWithFormat:@"%f", [yuji.maxmoney floatValue]*2];//yuji.maxmoney;
        //            sheng.minmoneystr = [NSString stringWithFormat:@"%f", [yuji.minmoney floatValue]*2];//yuji.minmoney;
        //        }else{
        sheng.maxmoneystr = yuji.maxmoney;
        sheng.minmoneystr = yuji.minmoney;
        //        }
        
        sheng.isHeMai = self.isHeMai;
        //  NSLog(@"zhushu = %@", zhushuDic);
        
        if (isHeMai) {
            sheng.hemaibool = YES;
        }else{
            sheng.hemaibool = NO;
        }
        
        [self.navigationController pushViewController:sheng animated:YES];
        [sheng release];
        [yuji release];
        
        castButton.enabled = YES;
    }
    
}

//投注欧赔
- (NSString *)touzhuOpeiReturn{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    
    
    NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
    
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan ||  matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan) {
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
                    //  [str appendString:@"平,负"];
                    [str appendFormat:@"%@,%@;", da.but2, da.but3];
                }
                if (da.selection1 && da.selection2==NO && da.selection3) {
                    [str appendFormat:@"%@,%@;", da.but1, da.but3];
                }
                if (da.selection1 && da.selection2 && da.selection3) {
                    [str appendFormat:@"%@,%@,%@;", da.but1, da.but2, da.but3];
                }
                
                
                // [str appendFormat:@"%@,%@,%@;", da.but1, da.but2, da.but3];
                
            }
        }
        
    }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
        
        
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            if (matchenum == matchEnumHunHeGuoGuan) {
                
                BOOL oneBool = NO;
                BOOL twoBool = NO;
                if ([da.bufshuarr count] >= 3) {
                    for (int j = 0; j < 3; j++) {
                        if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                            oneBool = YES;
                        }
                        
                    }
                }
                if ([da.bufshuarr count] >= 6) {
                    for (int j = 3; j <6 ; j++) {
                        if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                            twoBool = YES;
                        }
                    }
                    
                }
                
                if(oneBool){
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                    for (int m = 0; m < 3; m++) {
                        if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                            
                            [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                        }
                    }
                    
                    [str setString:[str substringToIndex:[str length] - 1]];
                    [str appendString:@";"];
                    
                }
                if(twoBool){
                    
                    
                    if(oneBool){
                        [str setString:[str substringToIndex:[str length] - 1]];
                        NSLog(@"str = %@", str);
                        [str setString:[NSString stringWithFormat:@"%@|",str]];
                    }else{
                        [str appendString:da.changhao];
                        [str appendString:@":"];
                    }
                    
                    
                    for (int m = 3; m < 6; m++) {
                        if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                            NSLog(@"%@", str);
                            NSLog(@"%@", [da.oupeiarr objectAtIndex:m]);
                            [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                        }
                    }
                    
                    [str setString:[str substringToIndex:[str length] - 1]];
                    [str appendString:@";"];
                    
                    
                    
                    
                    
                }
            }else{
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
                            
                            [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                        }
                    }
                    
                    [str setString:[str substringToIndex:[str length] - 1]];
                    [str appendString:@";"];
                    
                }
            }
            
            
            
        }
        
        
    }else if(matchenum == MatchEnumLanqiuHunTou){
        
        
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            
            
            BOOL oneBool = NO;
            BOOL twoBool = NO;
            BOOL threeBool = NO;
            BOOL fourBool = NO;
            if ([da.bufshuarr count] >= 2) {
                for (int j = 0; j < 2; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        oneBool = YES;
                        
                    }
                    
                }
            }
            if ([da.bufshuarr count] >= 4) {
                for (int j = 2; j < 4 ; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        twoBool = YES;
                        
                    }
                }
                
            }
            if ([da.bufshuarr count] >= 6) {
                for (int j = 4; j < 6 ; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        threeBool = YES;
                        
                    }
                }
                
            }
            if ([da.bufshuarr count] >= 18) {
                for (int j = 6; j < 18 ; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        fourBool = YES;
                        
                    }
                }
                
            }
            
            
            
            if(oneBool){
                [str appendString:da.changhao];
                [str appendString:@":"];
                for (int m = 0; m < 2; m++) {
                    if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                        
                        [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                    }
                }
                
                [str setString:[str substringToIndex:[str length] - 1]];
                [str appendString:@";"];
                
            }
            if(twoBool){
                
                if(oneBool){
                    [str setString:[str substringToIndex:[str length] - 1]];
                    NSLog(@"str = %@", str);
                    [str setString:[NSString stringWithFormat:@"%@|",str]];
                }else{
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                }
                
                
                for (int m = 2; m < 4; m++) {
                    if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                        NSLog(@"%@", str);
                        NSLog(@"%@", [da.oupeiarr objectAtIndex:m]);
                        [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                    }
                }
                
                [str setString:[str substringToIndex:[str length] - 1]];
                [str appendString:@";"];
                
            }
            
            if(threeBool){
                
                if(oneBool||twoBool){
                    [str setString:[str substringToIndex:[str length] - 1]];
                    NSLog(@"str = %@", str);
                    [str setString:[NSString stringWithFormat:@"%@|",str]];
                }else{
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                }
                
                
                for (int m = 4; m < 6; m++) {
                    if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                        NSLog(@"%@", str);
                        NSLog(@"%@", [da.oupeiarr objectAtIndex:m]);
                        [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                    }
                }
                
                [str setString:[str substringToIndex:[str length] - 1]];
                [str appendString:@";"];
                
            }
            if(fourBool){
                
                if(oneBool||twoBool||threeBool){
                    [str setString:[str substringToIndex:[str length] - 1]];
                    NSLog(@"str = %@", str);
                    [str setString:[NSString stringWithFormat:@"%@|",str]];
                }else{
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                }
                
                
                for (int m = 6; m < 18; m++) {
                    if ([[da.bufshuarr objectAtIndex:m] isEqualToString:@"1"]) {
                        NSLog(@"%@", str);
                        NSLog(@"%@", [da.oupeiarr objectAtIndex:m]);
                        [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m]];
                        //                        if (m >= 6 && m<= 11) {
                        //                            [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m+6]];
                        //                        }else if (m >= 12 && m <= 17){
                        //                            [str appendFormat:@"%@,", [da.oupeiarr objectAtIndex:m-6]];
                        //                        }
                        
                    }
                }
                
                [str setString:[str substringToIndex:[str length] - 1]];
                [str appendString:@";"];
                
            }
            
        }
        
        
    }else if(matchenum == matchEnumHunHeErXuanYi){
        
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            NSArray * teamarray = [da.team componentsSeparatedByString:@","];
            
            NSString * rangqiuString = @"";
            if ([teamarray count] > 2) {
                rangqiuString = [teamarray objectAtIndex:2];
            }
            
            if (da.selection1 || da.selection2) {
                
                [str appendString:da.changhao];
                [str appendString:@":"];
                
                
                
                if (da.selection1 && da.selection2 == NO) {
                    
                    if ([rangqiuString intValue] > 0) {
                        
                        if ([da.oupeiarr count] > 3) {
                            [str appendFormat:@"%@;", [da.oupeiarr objectAtIndex:3]];
                        }
                        
                    }else{
                        
                        if ([da.oupeiarr count] > 0) {
                            [str appendFormat:@"%@;", [da.oupeiarr objectAtIndex:0]];
                        }
                        
                    }
                    
                }else if(da.selection1 == NO && da.selection2){
                    
                    if ([rangqiuString intValue] > 0) {
                        
                        if ([da.oupeiarr count] > 2) {
                            [str appendFormat:@"%@;", [da.oupeiarr objectAtIndex:2]];
                        }
                        
                    }else{
                        
                        if ([da.oupeiarr count] > 5) {
                            [str appendFormat:@"%@;", [da.oupeiarr objectAtIndex:5]];
                        }
                        
                    }
                    
                }else if(da.selection1 && da.selection2){
                    
                    
                    if ([rangqiuString intValue] > 0) {
                        
                        if ([da.oupeiarr count] > 3) {
                            [str appendFormat:@"%@,%@;", [da.oupeiarr objectAtIndex:3], [da.oupeiarr objectAtIndex:2]];
                        }
                        
                        
                        
                    }else{
                        
                        if ([da.oupeiarr count] > 5) {
                            [str appendFormat:@"%@,%@;", [da.oupeiarr objectAtIndex:0], [da.oupeiarr objectAtIndex:5]];
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
        }
        
        
    }
    [str setString:[str substringToIndex:[str length] - 1]];
    NSLog(@"str = %@", str);
    return str;
}

- (NSString *)issueInfoReturn{
    
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    
    if (cellarray&&cellarray.count) {
        NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
        
        
        if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan) {
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                NSLog(@"da.sele = %d  %d  %d", da.selection1, da.selection2, da.selection3);
                
                if (da.selection1 || da.selection2 || da.selection3) {
                    [str appendString:da.changhao];
                    //[str appendString:@":"];
                    //[str appendString:da.numzhou];
                    [str appendString:@":"];
                    //[str appendString:@"["];
                    
                    [str appendFormat:@"1"];
                    
                    [str appendString:@";"];
                    
                }
            }
            
        }else if(matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan|| matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan){
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
        NSLog(@"str = %@", str);
        [str setString:[str substringToIndex:[str length] - 1]];
        NSLog(@"str = %@", str);
        return str;
    }
    
    
    return nil;
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
    }
}

//玩法介绍
- (void)pressHelpButton:(UIButton *)button{
    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];
    // exp.title = @"玩法";
    if (matchenum == matchEnumShengPingFuGuoGuan) {
        exp.ALLWANFA = JingCaiZuQiu;
    }else if(matchenum == matchEnumBiFenGuoguan){
        
        exp.ALLWANFA = JingCaiZuQiuBF;
        
    }else if(matchenum == matchenumZongJinQiuShu){
        exp.ALLWANFA = JingCaiZuQiuZJQS;
        
    }else if(matchenum == matchenumBanQuanChang){
        
        exp.ALLWANFA = JingCaiZuQiuBCSPF;
        
        
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        exp.ALLWANFA = JingCaiZuQiu;
    }else if(matchenum == matchEnumBiFenDanGuan){
        exp.ALLWANFA = JingCaiZuQiuBF;
        
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        exp.ALLWANFA = JingCaiZuQiuZJQS;
        
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        exp.ALLWANFA = JingCaiZuQiuBCSPF;
        
    }else if(matchenum == matchEnumShengFuGuoguan ||matchenum == matchEnumShengFuDanGuan){
        
        exp.ALLWANFA = JingCaiLanQiuSF;
        
    }else if(matchenum == matchEnumRangFenShengFuGuoguan ||matchenum == matchEnumRangFenShengFuDanGuan){
        
        exp.ALLWANFA = JingCaiLanQiuRFSF;
        
    }else if(matchenum == matchEnumShengFenChaGuoguan ||matchenum == matchEnumShengFenChaDanGuan){
        
        exp.ALLWANFA = JingCaiLanQiuSFC;
        
        
    }else if(matchenum == matchEnumDaXiaFenGuoguan ||matchenum == matchEnumDaXiaoFenDanGuan){
        
        exp.ALLWANFA = JingCaiLanQiuDXF;
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan ||matchenum == matchEnumRangQiuShengPingFuDanGuan){
        
        exp.ALLWANFA = JingCaiZuQiuRQSPF;
        
    }else if(matchenum == matchEnumHunHeGuoGuan){
        
        exp.ALLWANFA = huntou;
        
    }else if(matchenum == matchEnumHunHeErXuanYi){
        
        //混合二选一
        exp.ALLWANFA = hunTouErXuanYi;
    }else if(matchenum == MatchEnumLanqiuHunTou){
        exp.ALLWANFA = lanqiuhuntouwf;
    }
    
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];
}


- (void)myTableViewHeadView{
    
    
    tabhead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    [myTableView setTableHeaderView:tabhead];
    [tabhead release];
    
    headView = [[UISortView  alloc] initWithFrame:CGRectMake(0, -43, 320, 43)];
    headView.delegate = self;
    //    [myTableView setTableHeaderView:headView];
    [self.mainView addSubview:headView];
    [headView release];
    
    sortCount = 1;
    
    myTableView.contentOffset = CGPointMake(myTableView.contentOffset.x, 43);
    
}



- (void)requestHttpQingqiu{
    
    
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    //    if (self.resultList) return;
    if (matchenum != matchEnumShengPingFuGuoGuan && matchenum != matchEnumShengPingFuDanGuan && matchenum != matchEnumHunHeGuoGuan){
        myTableView.tableHeaderView = nil;
        [headView removeFromSuperview];
        headView = nil;
        tabhead = nil;
        //        myTableView.tableHeaderView.hidden = YES;
        
    }
    
    NSString * dgorgg = @"";
    if (matchenum == matchEnumBiFenGuoguan) {
        lotteryID = 2;
        dgorgg = @"gg";
    }else if(matchenum == matchEnumShengPingFuGuoGuan){
        if (tabhead) {
            [myTableView setTableHeaderView:tabhead];
        }else{
            [self myTableViewHeadView];
        }
        lotteryID = 1;
        dgorgg = @"gg";
    }else if(matchenum == matchenumBanQuanChang){
        lotteryID = 4;
        dgorgg = @"gg";
    }else if(matchenum == matchenumZongJinQiuShu){
        lotteryID = 3;
        dgorgg = @"gg";
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        lotteryID = 3;
        dgorgg = @"dg";
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        lotteryID = 4;
        dgorgg = @"dg";
    }else if(matchenum == matchEnumBiFenDanGuan){
        lotteryID = 2;
        dgorgg = @"dg";
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        if (tabhead) {
            [myTableView setTableHeaderView:tabhead];
        }else{
            [self myTableViewHeadView];
        }
        lotteryID = 1;
        dgorgg = @"dg";
    }else if(matchenum == matchEnumShengFuGuoguan){//、、、、篮球
        dgorgg = @"gg";
        lotteryID = 11;
    }else if(matchenum == matchEnumRangFenShengFuGuoguan){
        dgorgg = @"gg";
        lotteryID = 12;
    }else if(matchenum == matchEnumShengFenChaGuoguan){
        dgorgg = @"gg";
        lotteryID = 13;
    }else if(matchenum == matchEnumDaXiaFenGuoguan){
        dgorgg = @"gg";
        lotteryID = 14;
    }else if(matchenum == matchEnumShengFuDanGuan){
        dgorgg = @"dg";
        lotteryID = 11;
    }else if(matchenum == matchEnumRangFenShengFuDanGuan){
        dgorgg = @"dg";
        lotteryID = 12;
    }else if(matchenum == matchEnumShengFenChaDanGuan){
        dgorgg = @"dg";
        lotteryID = 13;
    }else if(matchenum == matchEnumDaXiaoFenDanGuan){
        dgorgg = @"dg";
        lotteryID = 14;
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        dgorgg = @"gg";
        lotteryID = 15;
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        dgorgg = @"dg";
        lotteryID = 15;
    }else if(matchenum == matchEnumHunHeGuoGuan){
        
        if (tabhead) {
            [myTableView setTableHeaderView:tabhead];
        }else{
            [self myTableViewHeadView];
        }
        dgorgg = @"gg";
        lotteryID = 16;
    }else if(matchenum == matchEnumHunHeErXuanYi){
        
        dgorgg = @"gg";
        lotteryID = 17;
        
    }else if(matchenum == MatchEnumLanqiuHunTou){
        dgorgg = @"gg";
        lotteryID = 18;
    }else if (matchenum == matchEnumBigHunHeGuoGan){
        dgorgg = @"gg";
        lotteryID = 19;
        
    }
    
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBiFenDanGuan|| matchenum == matchEnumZongJinQiuShuDanGuan|| matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan||matchenum == matchEnumShengFenChaDanGuan||matchenum == matchEnumDaXiaoFenDanGuan) {
        chuanButton1.hidden = YES;
        castButton.frame = CGRectMake(230, 6, 80, 33);//120,11,80,29
    }else {
        chuanButton1.hidden = NO;
        castButton.frame = CGRectMake(230, 6, 80, 33);
    }
#ifdef isCaiPiaoForIPad
    castButton.frame = CGRectMake(230+34, 6, 80, 33);
#endif
    
    NSMutableData *postData;
    NSLog(@"systimestr = %@", timezhongjie);
    NSString * ended = @"";
    if (biaoshi == 1 || biaoshi == 2) {
        ended = @"-";
    }else{
        ended = @"";
    }
    NSString * hcDateKey  = nil;
    
    //    self.timezhongjie = @"2013-10-25";//假数据
    
    if (biaoshi == 1||biaoshi == 2) {
        hcDateKey = self.timezhongjie;
    }else{
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]) {
            hcDateKey = [NSString stringWithFormat:@"%@@%@", self.timezhongjie,[[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]];
        }else{
            
            hcDateKey = [NSString stringWithFormat:@"%@@", self.timezhongjie];
            
        }
    }
    
    //    hcDateKey = @"2013-10-25";//假
    //    ended = @"-";//假
    //    NSLog(@"hcdate = %@", hcDateKey);
    
    
    [httprequest clearDelegatesAndCancel];
    postData = [[GC_HttpService sharedInstance] jingcaiDuizhenChaXun:1 wanfa:(int)lotteryID isEnded:ended macth:@"-" chaXunQiShu:hcDateKey danOrGuo:dgorgg];
    self.httprequest = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest addCommHeaders];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest appendPostData:postData];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest setDidFailSelector:@selector(requestFailed:)];
    [httprequest startAsynchronous];
    
    
}

-(void)requestFailed:(ASIHTTPRequest*)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    self.gcdgBool = NO;
    
}



#pragma mark -
#pragma mark Table view data source

- (void)pressBgHeader:(UIButton *)sender{
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
        
        if (sender.tag ==  0 || sender.tag == 1) {
            
            if ([allcellarr count] >= 1) {
                GC_BetData * betdata = [allcellarr objectAtIndex:0];
                biaoshi =  sender.tag+1;
                NSArray * timearr = [betdata.timeSort componentsSeparatedByString:@"_"];
                NSString * timenow = @"";
                NSString * systimeString = @"";
                if ([timearr count] > 1) {
                    timenow = [NSString stringWithFormat:@"%@ 12:00:00",[timearr objectAtIndex:0]];
                }
                NSArray * sysTimeArr = [self.sysTimeSave componentsSeparatedByString:@" "];
                if ([sysTimeArr count] > 1) {
                    systimeString = [NSString stringWithFormat:@"%@ 12:00:00",[sysTimeArr objectAtIndex:0]];
                }
                NSTimeInterval _oneDate = [[NSDate dateFromString:systimeString] timeIntervalSince1970]*1;
                NSTimeInterval _twoDate = [[NSDate dateFromString:timenow] timeIntervalSince1970]*1;
                
                NSString * lastTime = @"";
                if (_oneDate < _twoDate) {
                    lastTime = systimeString;//self.sysTimeSave;
                }else{
                    lastTime = timenow;
                }
                
                NSString * aftertime = @"";
                //                NSString * weekstr = @"";
                if (sender.tag == 0) {
                    //                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                    aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:lastTime] dateAfterDay:(int)[self upDateWangQi:nil duanTou:0]] ];
                    
                }else if(sender.tag == 1){
                    
                    //                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                    aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:lastTime] dateAfterDay:(int)[self upDateWangQi:nil duanTou:1]] ];
                }
                
                
                
                
                
                if ([aftertime rangeOfString:@" "].location != NSNotFound && [aftertime length] > 5 ) {
                    NSArray * timearr = [aftertime componentsSeparatedByString:@" "];
                    self.timezhongjie = [timearr objectAtIndex:0];
                }
                NSMutableArray * wangqiarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)sender.tag]];
                if ([wangqiarr count] == 0) {
                    //                    if (sender.tag == 0) {
                    //                        if (oneHead) {
                    //
                    //                        }else{
                    //                            [self requestHttpQingqiu];
                    //                        }
                    //                    }else if(sender.tag == 1){
                    //                        if (twoHead) {
                    //
                    //                        }else{
                    [self requestHttpQingqiu];
                    //                        }
                    //                    }
                    
                }
                
            }
            
        }
        
        
        // [sender setImage:UIImageGetImageFromName(@"zhankai_0.png") forState:UIControlStateNormal];
    }else{
        buffer[sender.tag] = 0;
        
        
        
        // [sender setImage:UIImageGetImageFromName(@"weizhankai.png") forState:UIControlStateNormal];
    }
    
    [myTableView reloadData];
    
    if (buffer[sender.tag] == 1) {
        if (sender.tag == 0 || sender.tag == 1) {
            NSMutableArray * listarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)sender.tag]];
            if ([listarr count] > 0) {
                [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }else{
            
            [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            
            
        }
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    //    if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
    
    return 44;
    //    }
    //    if (buffer[section] == 0) {
    //        return 28;
    //    }else if (buffer[section] == 1) {
    //        return 30;
    //    }
    //    return 28;
}

- (NSString *)updataTime:(NSDate *)timeDate betData:(GC_BetData *)betda{
    NSString * weekstr = @"";
    
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


- (NSInteger)upDateWangQi:(GC_BetData *)betda duanTou:(NSInteger)section{
    
    //    if ([betda.time rangeOfString:@":"].location != NSNotFound) {
    //        NSArray * timearr = [betda.time componentsSeparatedByString:@":"];
    //        if ([[timearr objectAtIndex:0] intValue] < 11 || ([[timearr objectAtIndex:0] intValue] == 11 && [[timearr objectAtIndex:1] intValue] < 30)) {
    //
    //            if (section == 0) {
    //                return -3;
    //            }else if(section == 1){
    //                return -2;
    //            }
    //
    //        }else{
    //            if (section == 0) {
    //                return -2;
    //            }else if(section == 1){
    //                return -1;
    //            }
    //        }
    //    }
    if (section == 0) {
        return -2;
    }else if(section == 1){
        return -1;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIButton * bgheader = [UIButton buttonWithType:UIButtonTypeCustom];//[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 28)] autorelease];
    bgheader.tag = section;
    
    bgheader.frame = CGRectMake(0, 0, 320, 44);
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
    
    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 294, 28)];
    timelabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:132/2la55.0 green:132/255.0 blue:132/255.0 alpha:1];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textAlignment = NSTextAlignmentLeft;
    timelabel.font = [UIFont boldSystemFontOfSize:13];
    [bgheader addSubview:timelabel];
    [timelabel release];
    
    UILabel * la   = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 274, 28)];
    
    la.backgroundColor = [UIColor clearColor];
    la.textAlignment = NSTextAlignmentRight;
    la.textColor = [UIColor blackColor];
    la.font = [UIFont systemFontOfSize:13];
    
    [bgheader addSubview:la];
    [la release];
    
    bgheader.frame = CGRectMake(0, 0, 320, 44);
    timelabel.frame = CGRectMake(5, 0, 294, 44);
    la.frame = CGRectMake(5, 0, 274, 44);
    //    BOOL sjbBool = NO;
    
    if (section == 0 || section == 1) {//往期
        if ([allcellarr count] >= 1) {
            
            GC_BetData * betdata = [allcellarr objectAtIndex:0];
            NSArray * timearr = [betdata.timeSort componentsSeparatedByString:@"_"];
            NSString * timenow = @"";
            NSString * systimeString = @"";
            if ([timearr count] > 1) {
                timenow = [NSString stringWithFormat:@"%@ 12:00:00",[timearr objectAtIndex:0]];
            }
            NSArray * sysTimeArr = [self.sysTimeSave componentsSeparatedByString:@" "];
            if ([sysTimeArr count] > 1) {
                systimeString = [NSString stringWithFormat:@"%@ 12:00:00",[sysTimeArr objectAtIndex:0]];
            }
            NSTimeInterval _oneDate = [[NSDate dateFromString:systimeString] timeIntervalSince1970]*1;
            NSTimeInterval _twoDate = [[NSDate dateFromString:timenow] timeIntervalSince1970]*1;
            
            NSString * lastTime = @"";
            if (_oneDate < _twoDate) {
                lastTime = systimeString;//self.sysTimeSave;
            }else{
                lastTime = timenow;
            }
            
            NSString * aftertime = @"";
            NSString * weekstr = @"";
            if (section == 0) {
                //                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:lastTime] dateAfterDay:(int)[self upDateWangQi:nil duanTou:0]] ];
                
            }else if(section == 1){
                
                //                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:lastTime] dateAfterDay:(int)[self upDateWangQi:nil duanTou:1]] ];
            }
            
            
            
            if ([aftertime rangeOfString:@" "].location != NSNotFound && [aftertime length] > 5 ) {
                NSArray * timearr = [aftertime componentsSeparatedByString:@" "];
                
                NSString * timenow1 = [NSString stringWithFormat:@"%@ 12:00:00",[timearr objectAtIndex:0]];
                NSInteger week = [[NSDate dateFromString:timenow1] weekday];
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
                
                
                if ([[timearr objectAtIndex:0] rangeOfString:@"-"].location != NSNotFound && [[timearr objectAtIndex:0] length] > 5) {
                    NSArray * allarr = [[timearr objectAtIndex:0] componentsSeparatedByString:@"-"];
                    aftertime = [NSString stringWithFormat:@"%@月%@日", [allarr objectAtIndex:1], [allarr objectAtIndex:2]];
                }
            }
            
#ifdef isCaiPiaoForIPad
            timelabel.text = [NSString stringWithFormat:@"  %@  %@",aftertime, weekstr];
#else
            timelabel.text = [NSString stringWithFormat:@" %@ %@",aftertime, weekstr];
#endif
            //扁平化
            timelabel.textColor = [UIColor colorWithRed:22/255.0 green:50/255.0 blue:56/255.0 alpha:1.0];
            
            
            
            
        }
        
        
        
        
        
        
    }else{
        
        NSMutableArray * keys = [kebianzidian objectAtIndex:section-2];
        GC_BetData * betdata = [keys objectAtIndex:0];
        
        NSArray * timeArray = [betdata.timeSort componentsSeparatedByString:@"_"];
        NSString * nianyueri = @"";
        if (timeArray.count) {
            nianyueri = [timeArray objectAtIndex:0];
        }
        NSString * xingqiji = @"";
        if (timeArray.count > 1) {
            xingqiji = [timeArray objectAtIndex:1];
        }
        if([nianyueri rangeOfString:@"-"].location != NSNotFound && [nianyueri length]>5){
            NSArray * nianarr = [nianyueri componentsSeparatedByString:@"-"];
            nianyueri = [NSString stringWithFormat:@"%@月%@日", [nianarr objectAtIndex:1], [nianarr objectAtIndex:2]];
        }
        
#ifdef isCaiPiaoForIPad
        timelabel.text = [NSString stringWithFormat:@"  %@  %@  %d场比赛",nianyueri, xingqiji, (int)[keys count]];
        //         UILabel * la   = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 274, 28)];
        la.frame = CGRectMake(5, 0, 340, 28);
#else
        timelabel.text = [NSString stringWithFormat:@" %@ %@ %d场比赛",nianyueri, xingqiji, (int)[keys count]];
#endif
        
        
        
        
        
        NSInteger xuanzhongcount = 0;
        if (matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan) {
            for (int i = 0; i < [keys count]; i++) {
                GC_BetData * betd= [keys objectAtIndex:i];
                //                if (lanqiubool == NO) {
                //                    if ([self gcbetDataFiltrateFunc:betd]) {
                //                        sjbBool = YES;
                //                    }
                //
                //                }
                
                if (betd.selection1 || betd.selection2 || betd.selection3) {
                    xuanzhongcount += 1;
                }
            }
        }else{
            
            for (int  i =0 ; i < [keys count]; i++) {
                GC_BetData * betd= [keys objectAtIndex:i];
                //                if (lanqiubool == NO) {
                //                    if ([self gcbetDataFiltrateFunc:betd]) {
                //                        sjbBool = YES;
                //                    }
                //
                //                }
                for (int k = 0; k < [betd.bufshuarr count]; k++) {
                    if ([[betd.bufshuarr objectAtIndex:k] isEqualToString:@"1"]) {
                        xuanzhongcount +=1;
                        break;
                    }
                }
            }
        }
        
        
        la.text = [NSString stringWithFormat:@"%d/%d", (int)xuanzhongcount, (int)[keys count]];
    }
    
    
    //    UIImageView * jiantouImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 10 - 18, (44 - 18)/2.0, 18, 18)];
    //    jiantouImage.backgroundColor = [UIColor clearColor];
    //    jiantouImage.image  = nil;
    //    [bgheader addSubview:jiantouImage];
    //    [jiantouImage release];
    //
    //    [self filtrateFunc:sjbBool imageView:im section:section jiantouImage:jiantouImage label:la timeLabel:timelabel];
    
    return bgheader;
    
    
}

- (BOOL)gcbetDataFiltrateFunc:(GC_BetData *)be{//看这个段有没有世界杯
    
    NSString * saishi = [be.event stringByReplacingOccurrencesOfString:@" " withString:@""];
    BOOL yseOrNo = NO;
    if ([saishi rangeOfString:@"世界杯"].location != NSNotFound) {
        
        yseOrNo = YES;
    }
    return yseOrNo;
}

- (void)filtrateFunc:(BOOL)yesOrNo imageView:(UIImageView *)imageView section:(NSInteger)section jiantouImage:(UIImageView *)jiantouImage label:(UILabel *)label timeLabel:(UILabel *)timeLabel{//显示断头的图片
    
    
    
    if (yesOrNo) {
        
        
        imageView.image = UIImageGetImageFromName(@"jcheadimage.png");
        timeLabel.textColor = [UIColor colorWithRed:250/255.0 green:226/255.0 blue:12/255.0 alpha:1];
        label.textColor = [UIColor colorWithRed:250/255.0 green:226/255.0 blue:12/255.0  alpha:1];
        if (buffer[section] == 0) {
            jiantouImage.image   = UIImageGetImageFromName(@"shijiebeishouqi.png");
            
        }else{
            jiantouImage.image   = UIImageGetImageFromName(@"shijiebeizhankai.png");
            
        }
        
    }else{
        jiantouImage.image = nil;
        label.textColor = [UIColor blackColor];
        timeLabel.textColor = [UIColor blackColor];
        if (buffer[section] == 0) {
            imageView.image =[UIImageGetImageFromName(@"pingshinew.png") stretchableImageWithLeftCapWidth:2 topCapHeight:0];
            
        }else{
            imageView.image =[UIImageGetImageFromName(@"xialanew.png") stretchableImageWithLeftCapWidth:2 topCapHeight:0];
            
        }
        
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (self.sysTimeSave && [self.sysTimeSave length] == 0) {
        return 0;
    }
    return [kebianzidian count]+2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //    if ([dataArray count] > 14) {
    //        return 14;
    //    }
    
    if (tableViewCellBool) {
        return 0;
    }
    
    if (section == 0 || section == 1) {
        if (buffer[section] == 1) {
            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)section]];
            return [duixiangarr count];
        }else{
            return 0;
        }
        
        
    }else{
        if (buffer[section] == 1) {
            //        NSArray * allke = [kebianzidian allKeys];
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:section-2];
            
            
            
            return  [duixiangarr count];
        }else{
            return 0;
        }
    }
    
    
    
    
    return 0;
    
    //  return [cellarray count];
    //  return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (  matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
        
        return 101 ;//+30
    }
    if (matchenum == matchEnumHunHeGuoGuan) {
//        if (zhankai[indexPath.section][indexPath.row] == 1) {
//            return 114+56;
//        }
        if (onlyDG) {
            if (indexPath.section == 0 || indexPath.section == 1) {
                return 114;
            }
            return 101;
        }
        return 114;
    }else if(matchenum == matchEnumHunHeErXuanYi){
        
        return 101;
    }
    if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan) {
        return 148;
    }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
        return 113;
    }
    
    
    return 0;
    
}

- (HunTouCell *)spfHunTouFunc:(UITableView *)tableView ellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Celldad";
    
    HunTouCell *cell = (HunTouCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[HunTouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier chaodan:chaobool] autorelease];
        
        cell.cp_canopencelldelegate = self;
#ifdef isCaiPiaoForIPad
        cell.xzhi  = 10+35;
#else
        cell.xzhi = 10;
#endif
        
        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        cell.normalHight = 108;
        cell.selectHight = 108+56;
        cell.xialabianImge.image = UIImageGetImageFromName(@"diduanxian99.png");
        cell.xialabianImge.frame = CGRectMake(cell.xialabianImge.frame.origin.x, cell.xialabianImge.frame.origin.y, cell.xialabianImge.frame.size.width, 3);
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        
        if (![pkbet.zhongzu isEqualToString:@"-"]) {
            
            
            
            
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐",@"比分直播", @"八方预测",nil] newType:0];
                cell.butTitle.text = @"析  荐";
            }else{
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐", @"八方预测",nil] newType:0];
                cell.butTitle.text = @"析  荐";
            }
        }else{
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] newType:0];
                cell.butTitle.text = @"析  分";
            }else{
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] newType:0];
                cell.butTitle.text = @"析";
            }
            
            
            
        }
        
    }else{
        NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
        GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
        
        if (![pkbet.zhongzu isEqualToString:@"-"]) {
            
            
            
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐",@"比分直播", @"八方预测",nil] newType:0];
                cell.butTitle.text = @"析  荐";
            }else{
                
                if (![pkbet.macthType isEqualToString:@"playvs"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐",@"八方预测", nil] newType:0];
                    cell.butTitle.text = @"析  荐";
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"专家推荐",@"八方预测", nil] newType:0];
                    cell.butTitle.text = @"析  荐";
                }
                
            }
            
        }else{
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] newType:0];
                cell.butTitle.text = @"析  分";
            }else{
                if (![pkbet.macthType isEqualToString:@"playvs"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] newType:0];
                    cell.butTitle.text = @"析";
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] newType:0];
                    cell.butTitle.text = @"析  胆";
                }
            }
            
        }
        
        
    }
    if (preDanBool) {
        NSInteger scrollViewX = 0;
//        if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//            scrollViewX = 35+ ([cell.allTitleArray count]-1)*70;
//        }else{
            scrollViewX = ([cell.allTitleArray count]-1)*70;
//        }
        NSLog(@"!99999999999999");
        cell.butonScrollView.contentOffset = CGPointMake(scrollViewX, cell.butonScrollView.contentOffset.y);
        HunTouCell * jccell = (HunTouCell *)cell;
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght2.png");
        
    }
    cell.buttonBool = buttonBool;
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        //            UIButton * v = [cell.butonScrollView.subviews objectAtIndex:3];
        //            v.hidden = YES;
        cell.row = indexPath;
        cell.count = indexPath;
        NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
        cell.wangqibool = YES;
        
        
        cell.wangqiTwoBool = YES;
        
        
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        pkbet.donghuarow = indexPath.row;
        cell.pkbetdata = pkbet;
        
    }else{
        //            UIButton * v = [cell.butonScrollView.subviews objectAtIndex:3];
        //            v.hidden = NO;
        
        indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
        
        cell.row = indexPath;
        cell.count = indexPath;
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        cell.wangqibool = NO;
        cell.wangqiTwoBool = NO;
        
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        if (![pkbet.macthType isEqualToString:@"playvs"]) {
            cell.wangqiTwoBool = YES;
        }
        pkbet.donghuarow = indexPath.row;
        cell.pkbetdata = pkbet;
        
    }
    
    cell.count = indexPath;
    cell.delegate = self;
    
    
    return cell;
}

- (GC_JCBetCell *)spfandRfspfFunc:(UITableView *)tableView ellForRowAtIndexPath:(NSIndexPath *)indexPath hunheOrspf:(BOOL)yesOrNo{
    static NSString *CellIdentifier = @"Cell000";
    
    GC_JCBetCell *cell = (GC_JCBetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    
    if (cell == nil) {
//        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
            cell = [[[GC_JCBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier matchLanQiu:matchEnumQiTaCell caodan:chaobool cellType:@"1"] autorelease];
            
//        }

        
        cell.cp_canopencelldelegate = self;
#ifdef isCaiPiaoForIPad
        cell.xzhi  = 9.5+35;
#else
        cell.xzhi = 9.5;
#endif
        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
        cell.normalHight = 50;
        cell.selectHight = 50+56;
        if (indexPath.section == 0 || indexPath.section == 1) {
            cell.wangqibool = YES;
        }else{
            cell.wangqibool = NO;
        }
    }
//    if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
    
        
        if (indexPath.section == 0 || indexPath.section == 1) {
            
            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
            
            if (![pkbet.zhongzu isEqualToString:@"-"]) {
                
                
                if (yesOrNo && [pkbet.onePlural rangeOfString:@" 1,"].location != NSNotFound) {//单关 而且 是让球 不能有专家推荐
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil]];
                        cell.butTitle.text = @"析  分";
                    }else{
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                        cell.butTitle.text = @"析";
                    }
                }else{
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐",@"比分直播", @"八方预测",nil]];
                        cell.butTitle.text = @"析  荐";
                    }else{
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐", @"八方预测",nil]];
                        cell.butTitle.text = @"析  荐";
                    }
                }
                
                
            }else{
                if ([pkbet.macthType isEqualToString:@"onLive"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil]];
                    cell.butTitle.text = @"析  分";
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
                    cell.butTitle.text = @"析";
                }
                
                
                
            }
            
        }else{
            NSIndexPath * indexP =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
            NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexP.section];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexP.row];
            
            
            if (![pkbet.zhongzu isEqualToString:@"-"]) {
                
                if (yesOrNo && [pkbet.onePlural rangeOfString:@" 1,"].location != NSNotFound) {//单关 而且 是让球 不能有专家推荐
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"比分直播", @"八方预测",nil]];
                        cell.butTitle.text = @"析  分";
                    }else{
                        if ( matchenum == matchEnumShengPingFuDanGuan) {
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                            cell.butTitle.text = @"析";
                        }else{
                            
                            if (![pkbet.macthType isEqualToString:@"playvs"]) {
                                [cell setButonImageArray:[NSArray arrayWithObjects: @"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测",nil]];
                                cell.butTitle.text = @"析";
                            }else{
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png", @"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
                                cell.butTitle.text = @"析  胆";
                            }
                            
                        }
                        
                        
                    }
                
                }else{
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"专家推荐",@"比分直播", @"八方预测",nil]];
                        cell.butTitle.text = @"析  荐";
                    }else{
                        if ( matchenum == matchEnumShengPingFuDanGuan) {
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png", @"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"专家推荐",@"八方预测",nil]];
                            cell.butTitle.text = @"析  荐";
                        }else{
                            
                            if (![pkbet.macthType isEqualToString:@"playvs"]) {
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png", @"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"专家推荐",@"八方预测",nil]];
                                cell.butTitle.text = @"析  荐";
                            }else{
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png", @"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"专家推荐",@"八方预测",nil]];
                                cell.butTitle.text = @"析  荐";
                            }
                            
                        }
                        
                        
                    }
                
                }
                
                
            }else{
                if ([pkbet.macthType isEqualToString:@"onLive"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil]];
                    cell.butTitle.text = @"析  分";
                }else{
                    if ( matchenum == matchEnumShengPingFuDanGuan) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                        cell.butTitle.text = @"析";
                    }else{
                        if (![pkbet.macthType isEqualToString:@"playvs"]) {
                            
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                            cell.butTitle.text = @"析";
                            
                        }else{
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
                            cell.butTitle.text = @"析  胆";
                        }
                        
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        
//    }
    cell.backgroundColor = [UIColor clearColor];
//    UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];
    
//    if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan ) {
//        cellbutton.hidden = YES;
//    }else{
//        cellbutton.hidden = NO;
//    }
    
//    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
        if (preDanBool) {
            NSInteger scrollViewX = 0;
            if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
                scrollViewX = ([cell.allTitleArray count]-1)*70;
            }else{
//                if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                    scrollViewX = 35+ ([cell.allTitleArray count]-1)*70;
//                }else{
                    scrollViewX = ([cell.allTitleArray count]-1)*70;
//                }
            }
            
            NSLog(@"!888888888888888");
            cell.butonScrollView.contentOffset = CGPointMake(scrollViewX, cell.butonScrollView.contentOffset.y);
            
            
            GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
            
        }
        cell.buttonBool = buttonBool;
        
//    }
    cell.hhChaBool = yesOrNo;
    if (indexPath.section == 0 || indexPath.section == 1) {
//        if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
//            
//        }else{
//            UIButton * v = [cell.butonScrollView.subviews objectAtIndex:1];
//            v.hidden = YES;
//        }
        
        cell.row = indexPath;
        NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
//        if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
            cell.wangqiTwoBool = YES;
//        }
        
        cell.wangqibool = YES;
        
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        pkbet.donghuarow = indexPath.row;
        cell.pkbetdata = pkbet;
        cell.count = indexPath;
        cell.delegate = self;
        
    }else{
        indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
        cell.row = indexPath;
        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
        
        
        
        cell.wangqibool = NO;
        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
        
//        if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
            cell.wangqiTwoBool = NO;
            if (![pkbet.macthType isEqualToString:@"playvs"]) {
                cell.wangqiTwoBool = YES;
            }
//        }
        
        pkbet.donghuarow = indexPath.row;
        if (matchenum == matchEnumShengPingFuDanGuan) {
            cell.danguanbool = YES;
        }else{
            cell.danguanbool = NO;
        }
        cell.pkbetdata = pkbet;
        cell.count = indexPath;
        cell.delegate = self;
        
    }
    
    
    
    
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan)  {
        cell.danguanbool = YES;
    }else{
        cell.danguanbool = NO;
    }
    return cell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (matchenum == matchEnumHunHeErXuanYi ) {
        static NSString *CellIdentifier = @"Cellidaaddaa";
        
        HunHeErXuanYiTableViewCell *cell = (HunHeErXuanYiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[HunHeErXuanYiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO] autorelease];
            cell.cp_canopencelldelegate = self;
            cell.xzhi = 9.5;
            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
            cell.normalHight = 50;
            cell.selectHight = 50+56;
            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
            
            
        }
        if (indexPath.section == 0 || indexPath.section == 1) {
            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
            
            
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] ];
                cell.butTitle.text = @"析  分";
            }else{
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                cell.butTitle.text = @"析";
            }
            
            
            
            
            
        }else{
            NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
            NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
            
            
            if ([pkbet.macthType isEqualToString:@"onLive"]) {
                
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] ];
                cell.butTitle.text = @"析  分";
                
            }else{
                
                if (![pkbet.macthType isEqualToString:@"playvs"]) {
                    
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                    
                    cell.butTitle.text = @"析";
                    
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] ];
                    cell.butTitle.text = @"析  胆";
                }
                
            }
            
        }
        
        
        if (indexPath.section == 0 || indexPath.section == 1) {
            cell.wangqibool = YES;
            
            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
            NSLog(@"pkbet = %@", pkbet.oupeiarr);
            pkbet.donghuarow = indexPath.row;
            
            cell.count = indexPath;
            cell.row = indexPath;
            cell.pkbetdata = pkbet;
        }else{
            cell.wangqibool = NO;
            
            indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
            cell.row = indexPath;
            NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
            NSLog(@"pkbet = %@", pkbet.oupeiarr);
            pkbet.donghuarow = indexPath.row;
            cell.count = indexPath;
            cell.pkbetdata = pkbet;
            cell.row = indexPath;
            
        }
        
        
        
        
        cell.delegate = self;
        return cell;
    }else
        
        if (matchenum == matchenumZongJinQiuShu||matchenum == matchEnumZongJinQiuShuDanGuan) {
            static NSString *CellIdentifier = @"Cellisdaaaa";
            
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
            //        cell.row = indexPath;
            cell.jcbool = YES;
            
            if (matchenum == matchEnumZongJinQiuShuDanGuan) {
                cell.danguanbool = YES;
            }else{
                cell.danguanbool = NO;
            }
            
            if (indexPath.section == 0 || indexPath.section == 1) {
                NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                
                
                if ([pkbet.macthType isEqualToString:@"onLive"]) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] ];
                    cell.butTitle.text = @"析  分";
                }else{
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                    cell.butTitle.text = @"析";
                }
                
                
                
                
                
            }else{
                NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
                
                
                if ([pkbet.macthType isEqualToString:@"onLive"]) {
                    
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] ];
                    cell.butTitle.text = @"析  分";
                    
                }else{
                    
                    if (![pkbet.macthType isEqualToString:@"playvs"]) {
                        
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                        
                        cell.butTitle.text = @"析";
                        
                    }else{
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] ];
                        cell.butTitle.text = @"析  胆";
                    }
                    
                }
                
            }
            
            if (matchenum == matchEnumZongJinQiuShuDanGuan) {
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测",nil]];
                cell.butTitle.text = @"析";
            }
            
            
            if (indexPath.section == 0 || indexPath.section == 1) {
                cell.wangqibool = YES;
                
                NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                NSLog(@"pkbet = %@", pkbet.oupeiarr);
                pkbet.donghuarow = indexPath.row;
                cell.betData = pkbet;
                cell.row = indexPath;
                //            cell.count = indexPath;
                
            }else{
                cell.wangqibool = NO;
                
                indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                cell.row = indexPath;
                NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                NSLog(@"pkbet = %@", pkbet.oupeiarr);
                pkbet.donghuarow = indexPath.row;
                cell.betData = pkbet;
                cell.row = indexPath;
                //            cell.count = indexPath;
                
            }
            
            
            
            
            cell.delegate = self;
            return cell;
            
            
            
        }else
            
            if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan) {
                
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
                
                cell.jcbool = YES;
                if (matchenum == matchEnumBiFenDanGuan) {
                    cell.danguanbool = YES;
                }else{
                    cell.danguanbool = NO;
                }
                if (indexPath.section == 0 || indexPath.section == 1) {
                    NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                    
                    
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] ];
                        cell.butTitle.text = @"析  分";
                    }else{
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                        cell.butTitle.text = @"析";
                    }
                    
                    
                    
                    
                    
                }else{
                    NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                    NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
                    GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
                    
                    
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] ];
                        cell.butTitle.text = @"析  分";
                        
                    }else{
                        
                        if (![pkbet.macthType isEqualToString:@"playvs"]) {
                            
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                            
                            cell.butTitle.text = @"析";
                            
                        }else{
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] ];
                            cell.butTitle.text = @"析  胆";
                        }
                        
                    }
                    
                }
                
                if (matchenum == matchEnumBiFenDanGuan) {
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测",nil]];
                    cell.butTitle.text = @"析";
                }
                if (indexPath.section == 0 || indexPath.section == 1) {
                    cell.wangqibool = YES;
                    
                    NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                    pkbet.donghuarow = indexPath.row;
                    cell.betData = pkbet;
                    cell.row = indexPath;
                    
                }else{
                    cell.wangqibool = NO;
                    
                    //            }
                    indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                    cell.row = indexPath;
                    NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                    pkbet.donghuarow = indexPath.row;
                    cell.betData = pkbet;
                    cell.row = indexPath;
                    
                }
                
                
                
                
                cell.delegate = self;
                
                return cell;
                
                
                
            }else
                
                if (matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan) {
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
                    
                    cell.jcbool = YES;
                    if (matchenum == matchEnumBanQuanChangDanGuan) {
                        cell.danguanbool = YES;
                    }else{
                        cell.danguanbool = NO;
                    }
                    if (indexPath.section == 0 || indexPath.section == 1) {
                        NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                        
                        
                        if ([pkbet.macthType isEqualToString:@"onLive"]) {
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] ];
                            cell.butTitle.text = @"析  分";
                        }else{
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                            cell.butTitle.text = @"析";
                        }
                        
                        
                        
                        
                        
                    }else{
                        NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
                        GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
                        
                        
                        if ([pkbet.macthType isEqualToString:@"onLive"]) {
                            
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] ];
                            cell.butTitle.text = @"析  分";
                            
                        }else{
                            
                            if (![pkbet.macthType isEqualToString:@"playvs"]) {
                                
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                                
                                cell.butTitle.text = @"析";
                                
                            }else{
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] ];
                                cell.butTitle.text = @"析  胆";
                            }
                            
                        }
                        
                    }
                    
                    if (matchenum == matchEnumBanQuanChangDanGuan) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测",nil]];
                        cell.butTitle.text = @"析";
                    }
                    if (indexPath.section == 0 || indexPath.section == 1) {
                        cell.wangqibool = YES;
                        
                        NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                        NSLog(@"pkbet = %@", pkbet.oupeiarr);
                        pkbet.donghuarow = indexPath.row;
                        cell.betData = pkbet;
                        cell.row = indexPath;
                        
                    }else{
                        cell.wangqibool = NO;
                        
                        indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                        cell.row = indexPath;
                        NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
                        GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                        NSLog(@"pkbet = %@", pkbet.oupeiarr);
                        pkbet.donghuarow = indexPath.row;
                        cell.betData = pkbet;
                        cell.row = indexPath;
                        
                    }
                    
                    
                    
                    
                    cell.delegate = self;
                    
                    return cell;
                }else
                    
                    
                    if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan) {
                        
                        
                        
                        static NSString *CellIdentifier = @"Ceallidaaddaa";
                        if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan) {
                            CellIdentifier = @"Cellidaawea";
                        }else if (matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
                            CellIdentifier = @"Cellidasd";
                        }else if (matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                            CellIdentifier = @"Cellidaadda223";
                        }else if (matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                            CellIdentifier = @"shengfencha222";
                        }
                        
                        BasketballTwoButtonCell *cell = (BasketballTwoButtonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (cell == nil) {
                            if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan) {
                                cell = [[[BasketballTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO cellType:1] autorelease];
                            }else if (matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
                                cell = [[[BasketballTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO cellType:2] autorelease];
                            }else if (matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                                cell = [[[BasketballTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO cellType:3] autorelease];
                            }else if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                                cell = [[[BasketballTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO cellType:4] autorelease];
                            }
                            
                            cell.cp_canopencelldelegate = self;
                            cell.xzhi = 9.5;
                            cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
                            cell.normalHight = 50;
                            cell.selectHight = 50+56;
                            cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
                            
                            
                        }
                        //        cell.row = indexPath;
                        
                        if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan) {
                            cell.typeCell = 1;
                        }else if (matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
                            cell.typeCell = 2;
                        }else if (matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                            cell.typeCell = 3;
                        }else if (matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                            cell.typeCell = 4;
                        }
                        
                        if (indexPath.section == 0 || indexPath.section == 1) {
                            cell.wangqibool = YES;
                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                            cell.butTitle.text = @"析";
                            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                            NSLog(@"pkbet = %@", pkbet.oupeiarr);
                            pkbet.donghuarow = indexPath.row;
                            cell.row = indexPath;
                            cell.count = indexPath;
                            cell.pkbetdata = pkbet;
                        }else{
                            cell.wangqibool = NO;
                            
                            if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                                cell.butTitle.text = @"析";
                            }else{
                                
                                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
                                cell.butTitle.text = @"析  胆";
                            }
                            
                            
                            
                            indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                            cell.row = indexPath;
                            NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
                            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                            NSLog(@"pkbet = %@", pkbet.oupeiarr);
                            pkbet.donghuarow = indexPath.row;
                            cell.count = indexPath;
                            cell.pkbetdata = pkbet;
                            
                            
                        }
                        
                        
                        
                        
                        cell.delegate = self;
                        return cell;
                        
                        
                    }else
                        
                        
                        if(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan  ){
                          return [self spfandRfspfFunc:tableView ellForRowAtIndexPath:indexPath hunheOrspf:NO];
                            
                        }else if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
                            
                            static NSString *CellIdentifier = @"Cellidaaddaa";
                            if (matchenum == matchEnumBigHunHeGuoGan) {
                                CellIdentifier = @"asdfsdfwfwqef";
                            }
                            
                            BigHunTouCell *cell = (BigHunTouCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                            if (cell == nil) {
                                if (matchenum == matchEnumBigHunHeGuoGan) {
                                    cell = [[[BigHunTouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"7" chaodan:NO cellType:2] autorelease];
                                }else{
                                    cell = [[[BigHunTouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"7" chaodan:NO cellType:1] autorelease];
                                }
                                
                                cell.cp_canopencelldelegate = self;
                                cell.xzhi = 9.5;
                                cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
                                cell.normalHight = 50;
                                cell.selectHight = 50+56;
                                cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
                                
                                
                            }
                            //        cell.row = indexPath;
                            
                            
                            if (matchenum == matchEnumBigHunHeGuoGan) {
                                if (indexPath.section == 0 || indexPath.section == 1) {
                                    NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                                    
                                    
                                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播", @"八方预测",nil] ];
                                        cell.butTitle.text = @"析  分";
                                    }else{
                                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                                        cell.butTitle.text = @"析";
                                    }
                                    
                                    cell.wangqibool = YES;
                                    
                                    
                                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                                    pkbet.donghuarow = indexPath.row;
                                    cell.row = indexPath;
                                    cell.count = indexPath;
                                    cell.pkbetdata = pkbet;
                                    
                                    
                                    
                                }else{
                                    NSIndexPath * indexp =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                                    NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexp.section];
                                    GC_BetData * pkbet = [mutarr objectAtIndex:indexp.row];
                                    
                                    
                                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                                        
                                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"比分直播",@"八方预测", nil] ];
                                        cell.butTitle.text = @"析  分";
                                        
                                    }else{
                                        
                                        if (![pkbet.macthType isEqualToString:@"playvs"]) {
                                            
                                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil] ];
                                            
                                            cell.butTitle.text = @"析";
                                            
                                        }else{
                                            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil] ];
                                            cell.butTitle.text = @"析  胆";
                                        }
                                        
                                    }
                                    
                                    cell.wangqibool = NO;
                                    
                                    indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                                    cell.row = indexPath;
                                    pkbet.donghuarow = indexPath.row;
                                    cell.count = indexPath;
                                    cell.pkbetdata = pkbet;
                                    
                                }
                            }else{
                                if (indexPath.section == 0 || indexPath.section == 1) {
                                    cell.wangqibool = YES;
                                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                                    cell.butTitle.text = @"析";
                                    NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                                    pkbet.donghuarow = indexPath.row;
                                    cell.row = indexPath;
                                    cell.count = indexPath;
                                    cell.pkbetdata = pkbet;
                                }else{
                                    cell.wangqibool = NO;
                                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆", @"八方预测",nil]];
                                    cell.butTitle.text = @"析  胆";
                                    indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
                                    cell.row = indexPath;
                                    NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
                                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                                    pkbet.donghuarow = indexPath.row;
                                    cell.count = indexPath;
                                    cell.pkbetdata = pkbet;
                                    
                                    
                                }
                                
                            }
                            
                            
                            
                            
                            
                            
                            cell.delegate = self;
                            return cell;
                            
                            
                        }
                        else if (matchenum == matchEnumHunHeGuoGuan){
                            
                            
                            if (onlyDG == NO) {
                                return [self spfHunTouFunc:tableView ellForRowAtIndexPath:indexPath];
                            }else{
                                if (indexPath.section == 0 || indexPath.section == 1) {
                                    return [self spfHunTouFunc:tableView ellForRowAtIndexPath:indexPath];
                                }else{
                                    return [self spfandRfspfFunc:tableView ellForRowAtIndexPath:indexPath hunheOrspf:YES];
                                }
                                
                            }
                           
                        }
    
    
    
    return nil;
}






- (void)returnBoolDanbifen:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;{
    
    
    if (matchenum == matchEnumHunHeGuoGuan ) {
        
        buttonBool = YES;
    }else{
        buttonBool = NO;
    }
    
    
    GC_JCBetCell * jccell = (GC_JCBetCell *)openCell;
    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
    
    labelch.text = @"串法";
    [zhushuDic removeAllObjects];
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    //    twoLabel.text = @"0";
    //    oneLabel.text = @"0";
    addchuan = 0;
    [chuantype removeAllObjects];
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    fieldLable.text = @"场";
    pourLable.hidden = YES;
    twoLabel.hidden = YES;
    
    GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
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
    gcbe.dandan = danbool;
    [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    
    //
    NSInteger coutt = 0;
    
    for (int i = 0; i < [kebianzidian count]; i++) {
        NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [arrkebian count]; j++) {
            GC_BetData * be = [arrkebian objectAtIndex:j];
            if (be.dandan) {
                
                coutt++;
            }
            
        }
    }
    
    if (coutt == 4) {
        sfcDanCount = 3;
    }else{
        sfcDanCount = coutt;
    }
    if (matchenum == matchEnumHunHeGuoGuan || (matchenum == MatchEnumLanqiuHunTou && sfcBool == NO) || (matchenum == matchEnumBigHunHeGuoGan  &&  markBigHunTou == 1)) {
        
        if (coutt == 8) {
            panduanbool = NO;
        }else if(coutt < 8){
            panduanbool = YES;
        }
        panduanzhongjie = panduanbool;
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设7个胆"];
        }
        
        
    }else if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumShengFenChaGuoguan || (matchenum == MatchEnumLanqiuHunTou && sfcBool) ||(matchenum == matchEnumBigHunHeGuoGan  &&  markBigHunTou == 3)) {
        if (coutt == 4) {
            panduanbool = NO;
        }else if(coutt < 4){
            panduanbool = YES;
        }
        
        panduanzhongjie = panduanbool;
        if (panduanzhongjie == NO && panduanbool == NO){
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设3个胆"];
            
            
        }
        if (matchenum == MatchEnumLanqiuHunTou && sfcBool && coutt > 4) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设3个胆"];
            panduanzhongjie = NO;
            panduanbool = NO;
        }
        
        
        
    }else if(matchenum == matchenumZongJinQiuShu ||(matchenum == matchEnumBigHunHeGuoGan  &&  markBigHunTou == 2)){
        if (coutt == 6) {
            panduanbool = NO;
        }else if(coutt < 6){
            panduanbool = YES;
        }
        panduanzhongjie = panduanbool;
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设5个胆"];
        }
        
        
    }else if(matchenum == matchenumBanQuanChang){
        if (coutt == 4) {
            panduanbool = NO;
        }else if(coutt < 4){
            panduanbool = YES;
        }
        panduanzhongjie = panduanbool;
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设3个胆"];
        }
        
        
    }else if (matchenum == matchEnumBigHunHeGuoGan){
        panduanbool = YES;
    }
    
    //    if (changcout-2 <= coutt) {
    //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    //        [cai showMessage:@"当前只能设置（选择场次数-2）个胆"];
    //    }
    
    if (coutt <= (one-2) || (coutt == 1 && one - 2 == 0)) {
        
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
            if (coutt > one-2 && one > 2) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"当前只能设置(选择场次数-2)个胆"];
            }
            
            
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
        
        if (one == 1 && allbu != 0) {
            
            //弹框
            FootballHintView * hintView = [[FootballHintView alloc] initType:danShowType];
            [hintView show];
            [hintView release];
        }
        
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
    
    
    if (preDanBool) {
        
        
        buttonBool = YES;
        //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
        
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        buttonBool = NO;
        preDanBool = NO;
        
        
    }else{
        [myTableView reloadData];
        buttonBool = NO;
    }
}

- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell{
    
    
    if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan ) {
        //        [self deleteContentOff];
        buttonBool = YES;
    }else{
        buttonBool = NO;
    }
    
    
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
    addchuan = 0;
    [chuantype removeAllObjects];
    
    GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
    
    if (gcbe.selection1 == NO && gcbe.selection2 == NO && gcbe.selection3 == NO) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请在当前对阵中选择您看好的结果"];
        danbool = NO;
    }
    
    gcbe.dandan = danbool;
    [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    //
    NSInteger coutt = 0;
    
    
    for (int i = 0; i < [allcellarr count]; i++) {
        
        GC_BetData * be = [allcellarr objectAtIndex:i];
        if (be.dandan) {
            
            coutt++;
        }
        
        
    }
    
    if (coutt == 8) {
        panduanbool = NO;
    }else if(coutt < 8){
        panduanbool = YES;
    }
    panduanzhongjie = panduanbool;
    
    if (panduanzhongjie == NO && panduanbool == NO){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"最多可以设7个胆"];
    }
    NSLog(@"%d", one);
    if (coutt <= (one-2) || (coutt == 1 && one - 2 == 0)) {
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = YES;
                //                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:j];
                //                danbutton.enabled = YES;
                //                celldanbool = YES;
                [arrkebian replaceObjectAtIndex:j withObject:be];
                
                
                
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        GC_BetData * cbe = [duixiangarr objectAtIndex:jccell.row.row];
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
        
        if (danbool) {
            coutt+=1;
            if (coutt > one-2 && one > 2) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"当前只能设置(选择场次数-2)个胆"];
                
            }
            
            //            coutt-=1;
        }
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = NO;
                //                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:j];
                //                danbutton.enabled = YES;
                //                celldanbool = NO;
                [arrkebian replaceObjectAtIndex:j withObject:be];
                
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
        //        danbutton.backgroundColor = [UIColor blackColor];
        //        [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
        gcbe.dandan = NO;
        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
        
        
    }
    
    if (one == 1 && (gcbe.selection1 || gcbe.selection2 || gcbe.selection3)) {
        
        //弹框
        FootballHintView * hintView = [[FootballHintView alloc] initType:danShowType];
        [hintView show];
        [hintView release];
    }
    
    if (panduanbool == NO) {
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [arrkebian count]; j++) {
                GC_BetData * be = [arrkebian objectAtIndex:j];
                be.nengyong = NO;
                [arrkebian replaceObjectAtIndex:j withObject:be];
                //                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:j];
                //                danbutton.enabled = YES;
                //                celldanbool = NO;
            }
            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        }
        UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
        //        danbutton.backgroundColor = [UIColor blackColor];
        //        [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
        gcbe.dandan = NO;
        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    }
    
    
    if (preDanBool) {
        
        
        buttonBool = YES;
        //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
        
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        buttonBool = NO;
        preDanBool = NO;
        
        
    }else{
        [myTableView reloadData];
        buttonBool = NO;
    }
    
    
}

- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell{
    
    if (matchenum == matchEnumHunHeGuoGuan) {
        [self deleteContentOff:@""];
    }
    HunTouCell * jccell = (HunTouCell *)hunCell;
    if (jccell.wangqibool == YES) {
        if (self.lanqiubool) {
            LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            NSLog(@"%@", be.saishiid);
            sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
            [self.navigationController pushViewController:sachet animated:YES];
#endif
            [sachet release];
        }
        else {
            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            [self NewAroundViewShowFunc:be indexPath:jccell.row history:YES];
            //            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", jccell.row.section]];
            //             GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            //
            //
            //
            //            NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
            //            //        sachet.playID = @"234028"; //传入这两个对比赛的id
            //            //    NSArray * allke = [kebianzidian allKeys];
            //
            //
            //            NSLog(@"%@", be.saishiid);
            //            sachet.playID = be.saishiid;
            //#ifdef isCaiPiaoForIPad
            //            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
            //#else
            //            [self.navigationController pushViewController:sachet animated:YES];
            //#endif
            //            [sachet release];
        }
        
        
    }else{
        
        
        if (self.lanqiubool) {
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
            
            if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                neutrality.delegate = self;
                [neutrality show];
                [neutrality release];
                return;
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
        }
        else {
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
            
            
            //            NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
            //            //        sachet.playID = @"234028"; //传入这两个对比赛的id
            //            //    NSArray * allke = [kebianzidian allKeys];
            //
            //            NSLog(@"%@", be.saishiid);
            //            sachet.playID = be.saishiid;
            //#ifdef isCaiPiaoForIPad
            //            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
            //#else
            //            [self.navigationController pushViewController:sachet animated:YES];
            //#endif
            //            [sachet release];
        }
        
    }
}

- (void)returncellrownumbifen:(NSIndexPath *)num{
    //    [self deleteContentOff];d
    if (lanqiubool) {
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
        GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
            neutrality.delegate = self;
            [neutrality show];
            [neutrality release];
            return;
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
    }
    else {
        if (num.section == 0 || num.section == 1) {
            NSMutableArray * duixiangarr =[wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)num.section]];
            GC_BetData * be = [duixiangarr objectAtIndex:num.row];
            [self NewAroundViewShowFunc:be indexPath:num history:YES];
            
        }else{
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
            GC_BetData * be = [duixiangarr objectAtIndex:num.row];
            [self NewAroundViewShowFunc:be indexPath:num history:NO];
            
        }
        
        //        if (num.section == 0 || num.section == 1) {
        //
        //        }else{
        //            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
        //            GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        //            NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
        //            if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
        //                NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
        //                neutrality.delegate = self;
        //                [neutrality show];
        //                [neutrality release];
        //                return;
        //            }
        //        }
        
        
        //        NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
        //
        //        if (num.section == 0 || num.section == 1) {
        //            NSMutableArray * duixiangarr =[wangqiArray objectForKey:[NSString stringWithFormat:@"%d", num.section]];
        //            GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        //            sachet.playID = be.saishiid;
        //        }else{
        //            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
        //            GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        //            sachet.playID = be.saishiid;
        //        }
        //
        //
        //#ifdef isCaiPiaoForIPad
        //        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
        //#else
        //        [self.navigationController pushViewController:sachet animated:YES];
        //#endif
        //        [sachet release];
    }
    
}

- (void)returncellrownum:(NSIndexPath *)num cell:(CP_CanOpenCell *)cell{
    
    if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
        [self deleteContentOff:@""];
    }
    
    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
    if (jccell.wangqibool == YES) {
        if (self.lanqiubool) {
            LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            NSLog(@"%@", be.saishiid);
            sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
            [self.navigationController pushViewController:sachet animated:YES];
#endif
            [sachet release];
        }
        else {
            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d",(int)jccell.row.section]];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            
            [self NewAroundViewShowFunc:be indexPath:jccell.row history:YES];
            //            NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", jccell.row.section]];
            //            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            //
            //
            //            NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
            //            //        sachet.playID = @"234028"; //传入这两个对比赛的id
            //            //    NSArray * allke = [kebianzidian allKeys];
            //
            //            NSLog(@"%@", be.saishiid);
            //            sachet.playID = be.saishiid;
            //#ifdef isCaiPiaoForIPad
            //            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
            //#else
            //            [self.navigationController pushViewController:sachet animated:YES];
            //#endif
            //            [sachet release];
        }
        
        
    }else{
        
        
        
        if (self.lanqiubool) {
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
            if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                neutrality.delegate = self;
                [neutrality show];
                [neutrality release];
                return;
            }
            LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
            //            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            //
            //            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            NSLog(@"%@", be.saishiid);
            sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
            [self.navigationController pushViewController:sachet animated:YES];
#endif
            [sachet release];
        }
        else {
            
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            
            [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
            
            
            
            
            //            NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
            //            //        sachet.playID = @"234028"; //传入这两个对比赛的id
            //            //    NSArray * allke = [kebianzidian allKeys];
            //
            //            NSLog(@"%@", be.saishiid);
            //            sachet.playID = be.saishiid;
            //#ifdef isCaiPiaoForIPad
            //            [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
            //#else
            //            [self.navigationController pushViewController:sachet animated:YES];
            //#endif
            //            [sachet release];
        }
        
    }
    
    
}


- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    if (matchenum == matchEnumHunHeGuoGuan ) {
        //        [self deleteContentOff];
        buttonBool = YES;
    }else{
        buttonBool = NO;
    }
    
    NSMutableArray * beaar = [kebianzidian objectAtIndex:index.section];
    GC_BetData  * betbif = [beaar objectAtIndex:index.row];
    betbif.bufshuarr = bufshuzu;
    [beaar replaceObjectAtIndex:index.row withObject:betbif];
    
    
    NSMutableArray * daaa = [kebianzidian objectAtIndex:index.section];
    GC_BetData  * da = [daaa objectAtIndex:index.row];
    da.count = index.row;
    da.bufshuarr = bufshuzu;
    da.booldan = booldan;
    [daaa replaceObjectAtIndex:index.row withObject:da];
    
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
    BOOL sfcb = NO;
    markBigHunTou = 0;
    
    //    BOOL oneMark = NO;
    BOOL twoMark = NO;
    BOOL threeMark = NO;
    
    NSInteger markbing = 0;
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        
        for (int  k = 0; k < [bet.bufshuarr count]; k++) {
            NSString * bufzi = [bet.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                allbu++;
            }
            if (matchenum == MatchEnumLanqiuHunTou) {//判断是否有胜分差玩法
                
                if (k >= 6 && k < 18) {
                    if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                        sfcb = YES;
                        
                        
                        
                    }
                }
                
            }else if(matchenum == matchEnumBigHunHeGuoGan){
                
                if (k >= 0 && k < 6) {
                    if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                        
                        //                        oneMark = YES;
                    }
                    
                }else if (k >= 6 && k < 14) {
                    if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                        
                        twoMark = YES;
                    }
                    
                }else{
                    if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                        
                        threeMark = YES;
                    }
                }
                
                
            }
            
            
        }
        
        
    }
    if (matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
        
        
        if (matchenum == matchEnumBigHunHeGuoGan) {
            if (threeMark == YES) {
                markbing = 3;
            }else if (threeMark == NO && twoMark == YES ) {
                markbing = 2;
            }else if (threeMark == NO && twoMark == NO){
                markbing = 1;
            }
        }
        if ((sfcBool == NO && sfcb) || (markBigHunTou != 0 && markBigHunTou != markbing)) {
            if (![labelch.text isEqualToString:@"串法"]) {
                oneLabel.text = [NSString stringWithFormat:@"%d", one];
                twoLabel.text = @"0";
                labelch.text = @"串法";
                fieldLable.text = @"场";
                pourLable.hidden = YES;
                twoLabel.hidden = YES;
                addchuan = 0;
                [zhushuDic removeAllObjects];
                for (int i = 0; i < 160; i++) {
                    buf[i] = 0;
                }
                
            }
        }
    }
    
    sfcBool = sfcb;
    markBigHunTou = markbing;
    NSLog(@"sfcbool = %d", sfcBool);
    
    
    
    
    
    if (allbutcount != allbu) {
        labelch.text = @"串法";
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
            
        }else{
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
        }
        
        addchuan = 0;
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
        //        for (int j = 0; j < [allcellarr count]; j++) {
        //            GC_BetData * bet = [allcellarr objectAtIndex:j];
        //            bet.dandan = NO;
        //
        //            [allcellarr replaceObjectAtIndex:j withObject:bet];
        //        }
        
        
    }
    
    
    allbutcount = allbu;
    
    
    
    NSInteger changcishu = 0;
    if (lanqiubool || matchenum == matchEnumHunHeGuoGuan) {
        changcishu = 10;
    }else {
        changcishu = 15;
    }
    if (buttoncout > changcishu) {
        
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        if (lanqiubool|| matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumHunHeErXuanYi || matchenum == MatchEnumLanqiuHunTou) {
            [cai showMessage:@"不能超过10场"];
            //            oneLabel.text = @"10";
            
            one = 10;
            if ([oneLabel.text integerValue] > 10 && [fieldLable.text isEqualToString:@"场"]) {
                oneLabel.text = @"10";
            }
        }else{
            [cai showMessage:@"不能超过15场"];
            //            oneLabel.text = @"15";
            one = 15;
            if ([oneLabel.text integerValue] > 15&& [fieldLable.text isEqualToString:@"场"]) {
                oneLabel.text = @"15";
            }
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
        [self calculateMoney];
        [myTableView reloadData];
        buttonBool = NO;
        if (matchenum == MatchEnumLanqiuHunTou) {
            BOOL sfcb = NO;
            for (int j = 0; j < [allcellarr count]; j++) {
                GC_BetData * bet = [allcellarr objectAtIndex:j];
                
                for (int  k = 0; k < [bet.bufshuarr count]; k++) {
                    if (matchenum == MatchEnumLanqiuHunTou) {//判断是否有胜分差玩法
                        
                        if (k >= 6 && k < 18) {
                            if ([[bet.bufshuarr objectAtIndex:k] isEqualToString:@"1"] ) {
                                sfcb = YES;
                                
                                
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
                
            }
            sfcBool = sfcb;
        }
        
        
        return;
    }
    
    
    //如果再多选的话 清一下
    if (buttoncout > butcount) {
        labelch.text = @"串法";
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
            
        }else{
            //            twoLabel.text = @"0";
            //            oneLabel.text = @"0";
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
        }
        
        addchuan = 0;
        
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
        
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
        if (bebool == NO || one == 1) {
            
            
            bet.dandan = NO;
        }
        [allcellarr replaceObjectAtIndex:j withObject:bet];
        
    }
    butcount = buttoncout;
    
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
        if (one < 1) {
            chuanButton1.enabled = NO;
            castButton.enabled = NO;
            qingbutton.enabled = NO;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
            
            castButton.alpha = 0.5;
            chuanButton1.alpha = 0.5;
            
        }else {
            castButton.enabled = YES;
            qingbutton.enabled = YES;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
            
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
        }
    }else{
        if (one < 2) {
            chuanButton1.enabled = NO;
            
            chuanButton1.alpha = 0.5;
            
        }else {
            
            chuanButton1.enabled = YES;
            
            chuanButton1.alpha = 1;
        }
        if (one < 1) {
            castButton.enabled = NO;
            qingbutton.enabled = NO;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
            
            castButton.alpha = 0.5;
        }else{
            castButton.enabled = YES;
            qingbutton.enabled = YES;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
            
            castButton.alpha = 1;
        }
    }
    
    if (one == 0) {
        labelch.text = @"串法";
        
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
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
            
        }else{
            
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
        }
        
        addchuan = 0;
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
        
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
    buttonBool = NO;
    
    if (matchenum == matchEnumHunHeGuoGuan||matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang||matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou||matchenum == matchEnumBigHunHeGuoGan  ) {
        
        
        
        
        
        
        
        if (one == 1 && (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu|| matchenum == matchEnumShengFenChaGuoguan|| matchenum == MatchEnumLanqiuHunTou||matchenum == matchEnumBigHunHeGuoGan) ) {
            int qhhbool = 0;
            int hhhbool = 0;
            int allDFS = 0;
            //            NSInteger zcount = 0;
            int oneP = 0;
            int twop = 0;
            int threep = 0;
            int fourp = 0;
            int fivep = 0;
            for (GC_BetData * da in allcellarr) {
                
                if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan) {
                    if (da.selection1 || da.selection2 || da.selection3) {
                        if (matchenum == matchEnumShengPingFuGuoGuan) {
                            if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                                if (allDFS == 0 || allDFS == 1) {
                                    allDFS = 1;
                                }
                                
                            }else{
                                allDFS = 2;
                            }
                        }else if (matchenum == matchEnumShengFuGuoguan){
                            if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@" 1,"].location != NSNotFound) {
                                if (allDFS == 0 || allDFS == 1) {
                                    allDFS = 1;
                                }
                            }else{
                                allDFS = 2;
                            }
                        }else if (matchenum == matchEnumRangFenShengFuGuoguan){
                            if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@" 12,"].location != NSNotFound) {
                                if (allDFS == 0 || allDFS == 1) {
                                    allDFS = 1;
                                }
                            }else{
                                allDFS = 2;
                            }
                        }else if (matchenum == matchEnumDaXiaFenGuoguan){
                            if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@" 14,"].location != NSNotFound) {
                                if (allDFS == 0 || allDFS == 1) {
                                    allDFS = 1;
                                }
                            }else{
                                allDFS = 2;
                            }
                        }
                        
                    }
                }else{
                    for (int i = 0; i < [da.bufshuarr count]; i++) {
                        
                        if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                            if (matchenum == matchEnumHunHeGuoGuan) {
                                if ([da.onePlural rangeOfString:@" 1,"].location != NSNotFound && i > 2) {
                                    
                                    if (hhhbool == 0 || hhhbool == 1) {
                                        hhhbool = 1;
                                    }
                                    
                                }else{
                                    if ([da.onePlural rangeOfString:@" 15,"].location == NSNotFound ) {
                                        hhhbool = 2;
                                    }
                                    
                                }
                                
                                if ([da.onePlural rangeOfString:@" 15,"].location != NSNotFound && i < 3){
                                    if (qhhbool == 0 || qhhbool == 1) {
                                        qhhbool = 1;
                                    }
                                    
                                }else{
                                    if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound ) {
                                        qhhbool = 2;
                                    }
                                    
                                }
                            }else if (matchenum == MatchEnumLanqiuHunTou){
                                if ([da.pluralString isEqualToString:@""]) {
                                    if (oneP == 0 || oneP == 1) {
                                        oneP = 1;
                                    }
                                    if (twop == 0 || twop == 1) {
                                        twop = 1;
                                    }
                                    if (threep == 0 || threep == 1) {
                                        threep = 1;
                                    }
                                    if (fourp == 0 || fourp == 1) {
                                        fourp = 1;
                                    }
                                }else{
                                    if ([da.pluralString rangeOfString:@" 11,"].location != NSNotFound  && i < 2) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 11,"].location == NSNotFound  && i < 2) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 12,"].location != NSNotFound  && (i > 1 && i < 4)) {
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 12,"].location == NSNotFound  && (i > 1 && i < 4)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 14,"].location != NSNotFound  && (i > 3 && i < 6)) {
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 14,"].location == NSNotFound  && (i > 3 && i < 6)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 13,"].location != NSNotFound  && i > 5) {
                                        if (fourp == 0 || fourp == 1) {
                                            fourp = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 13,"].location == NSNotFound  && i > 5) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                        }
                                        
                                    }
                                    
                                }
                                
                            }else if (matchenum == matchEnumBigHunHeGuoGan){
                                if ([da.pluralString isEqualToString:@""]) {
                                    if (oneP == 0 || oneP == 1) {
                                        oneP = 1;
                                    }
                                    if (twop == 0 || twop == 1) {
                                        twop = 1;
                                    }
                                    if (threep == 0 || threep == 1) {
                                        threep = 1;
                                    }
                                    if (fourp == 0 || fourp == 1) {
                                        fourp = 1;
                                    }
                                    if (fivep == 0 || fivep == 1) {
                                        fivep = 1;
                                    }
                                }else{
                                    if ([da.pluralString rangeOfString:@" 1,"].location != NSNotFound  && i < 3) {
                                        if (oneP == 0 || oneP == 1) {
                                            oneP = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 1,"].location == NSNotFound  && i < 3) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 15,"].location != NSNotFound  && (i > 2 && i < 6)) {
                                        if (twop == 0 || twop == 1) {
                                            twop = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 15,"].location == NSNotFound  && (i > 2 && i < 6)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    if ([da.pluralString rangeOfString:@" 3,"].location != NSNotFound  && (i > 5 && i < 14 )) {
                                        if (threep == 0 || threep == 1) {
                                            threep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 3,"].location == NSNotFound  && (i > 5 && i < 14)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    if ([da.pluralString rangeOfString:@" 2,"].location != NSNotFound  && (i > 13 && i < 45 )) {
                                        if (threep == 0 || threep == 1) {
                                            fourp = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 2,"].location == NSNotFound  && (i > 13 && i < 45)) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    if ([da.pluralString rangeOfString:@" 4,"].location != NSNotFound  && i > 44) {
                                        if (fourp == 0 || fourp == 1) {
                                            fivep = 1;
                                        }
                                    }else{
                                        if ([da.pluralString rangeOfString:@" 4,"].location == NSNotFound  && i > 44) {
                                            oneP = 2;
                                            twop = 2;
                                            threep = 2;
                                            fourp = 2;
                                            fivep = 2;
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else if (matchenum == matchenumZongJinQiuShu){
                                if ([da.onePlural rangeOfString:@" 3,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                                    if (allDFS == 0 || allDFS == 1) {
                                        allDFS = 1;
                                    }
                                    
                                }else{
                                    allDFS = 2;
                                }
                            }else if (matchenum == matchenumBanQuanChang){
                                if ([da.onePlural rangeOfString:@" 4,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                                    if (allDFS == 0 || allDFS == 1) {
                                        allDFS = 1;
                                    }
                                    
                                }else{
                                    allDFS = 2;
                                }
                            }else if (matchenum == matchEnumBiFenGuoguan){
                                if ([da.onePlural rangeOfString:@" 2,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                    if (allDFS == 0 || allDFS == 1) {
                                        allDFS = 1;
                                    }
                                    
                                }else{
                                    allDFS = 2;
                                }
                            }else if (matchenum == matchEnumShengFenChaGuoguan){
                                if ([da.pluralString isEqualToString:@""] || [da.pluralString rangeOfString:@" 13,"].location != NSNotFound) {
                                    if (allDFS == 0 || allDFS == 1) {
                                        allDFS = 1;
                                    }
                                }else{
                                    allDFS = 2;
                                }
                            }
                            
                            
                            
                        }
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            if (qhhbool == 1 ||  hhhbool == 1 || allDFS == 1 || oneP == 1 || twop == 1 || threep == 1 || fourp == 1 || fivep == 1) {
                [chuantype removeAllObjects];
                UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                senbutton.tag = 1;
                senbutton.titleLabel.text = [NSString stringWithFormat:@"单关"];
                [self pressChuanJiuGongGe:senbutton];
                
            }else{
                
                labelch.text = @"串法";
                
                oneLabel.text = [NSString stringWithFormat:@"%d", one];
                fieldLable.text = @"场";
                pourLable.hidden = YES;
                twoLabel.hidden = YES;
                addchuan = 0;
                [chuantype removeAllObjects];
            }
            
        }else if (one > 1 && one < 5) {
            BOOL danboolx = NO;
            for (GC_BetData * da in allcellarr) {
                
                if (da.dandan) {
                    
                    danboolx = YES;
                    break;
                }
                
                
            }
            if (danboolx) {
                
                
                labelch.text = @"串法";
                
                oneLabel.text = [NSString stringWithFormat:@"%d", one];
                fieldLable.text = @"场";
                pourLable.hidden = YES;
                twoLabel.hidden = YES;
                addchuan = 0;
                [chuantype removeAllObjects];
                //                }
                
            }else{
                
                
                
                [chuantype removeAllObjects];
                UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                senbutton.tag = 1;
                senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", one];
                [self pressChuanJiuGongGe:senbutton];
            }
            
        }
        
        
    }
    
    
    
    
    
}

- (void)calculateMoney{
    if(matchenum == matchEnumRangQiuShengPingFuDanGuan|| matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan){
        int dancount = 0;
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * pkb = [allcellarr objectAtIndex:j];
            if (pkb.selection1) {
                dancount += 1;
            }
            if (pkb.selection2) {
                dancount += 1;
            }
            if (pkb.selection3) {
                dancount += 1;
            }
            
            
        }
        //  }
        
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
        twoLabel.text = [NSString stringWithFormat:@"%d", dancount*2];
        oneLabel.text = [NSString stringWithFormat:@"%d", dancount];
        
    }
    
    if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengFenChaDanGuan) {
        int zcount = 0;
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
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
    
}

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    
    
    
    if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
        
        buttonBool = YES;
    }else{
        buttonBool = NO;
    }
    
    
    
    //  NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", index, selection1, selection2, selection3);
    //  GC_BetData  * da = [cellarray objectAtIndex:index];
    
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
    
    
    
    NSInteger allbu = 0;
    
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
        
    }
    //   }
    
    if (allbutcount != allbu) {
        labelch.text = @"串法";
        //        twoLabel.text = @"0";
        //        oneLabel.text = @"0";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
        
    }
    // }
    
    allbutcount = allbu;
    //    }
    
    
    //NSLog(@"aaa = %d", buttoncout);
    if (lanqiubool||matchenum == matchEnumHunHeErXuanYi) {
        if (buttoncout > 10) {
            //  NSLog(@"aaaaaaaaaa");
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"不能超过10场"];
            //  NSString * indstr = [NSString stringWithFormat:@"%d", index];
            //   [self performSelector:@selector(dayushiwuchang) withObject:indstr afterDelay:1];
            
            //  for (int i = 15; i < [cellarray count]; i++) {
            //            oneLabel.text = @"10";
            
            one = 10;
            
            if ([oneLabel.text integerValue] > 10&& [fieldLable.text isEqualToString:@"场"]) {
                oneLabel.text = @"10";
            }
            NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
            GC_BetData * dabet = [daarray objectAtIndex:index.row];
            dabet.selection1 = NO;
            dabet.selection2 = NO;
            dabet.selection3 = NO;
            //   }
            [self calculateMoney];
            
            
            
            
            //            NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:index.row inSection:index.section+2];
            //            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [myTableView reloadData];
            buttonBool = NO;
            return;
        }
    }else{
        
        if (buttoncout > 15) {
            //  NSLog(@"aaaaaaaaaa");
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"不能超过15场"];
            //  NSString * indstr = [NSString stringWithFormat:@"%d", index];
            //   [self performSelector:@selector(dayushiwuchang) withObject:indstr afterDelay:1];
            
            //  for (int i = 15; i < [cellarray count]; i++) {
            //            oneLabel.text = @"15";
            one = 15;
            if ([oneLabel.text integerValue] > 15&& [fieldLable.text isEqualToString:@"场"]) {
                oneLabel.text = @"15";
            }
            NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
            GC_BetData * dabet = [daarray objectAtIndex:index.row];
            dabet.selection1 = NO;
            dabet.selection2 = NO;
            dabet.selection3 = NO;
            //   }
            [self calculateMoney];
            //            NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:index.row inSection:index.section+2];
            //            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [myTableView reloadData];
            buttonBool = NO;
            return;
        }
    }
    
    
    
    //如果再多选的话 清一下
    if (buttoncout > butcount) {
        labelch.text = @"串法";
        if( matchenum != matchEnumShengPingFuDanGuan && matchenum != matchEnumRangQiuShengPingFuDanGuan){
            //            twoLabel.text = @"0";
            //            oneLabel.text = @"0";
            oneLabel.text = [NSString stringWithFormat:@"%d", one];
            fieldLable.text = @"场";
            pourLable.hidden = YES;
            twoLabel.hidden = YES;
            [chuantype removeAllObjects];
        }
        
        addchuan = 0;
        
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
        
    }
    
    //  }
    NSLog(@"two = %d", two);
    
    
    butcount = buttoncout;
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumRangFenShengFuDanGuan) {
        if (one < 1) {
            chuanButton1.enabled = NO;
            castButton.enabled = NO;
            qingbutton.enabled = NO;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
            
            
            castButton.alpha = 0.5;
            chuanButton1.alpha = 0.5;
            
        }else {
            castButton.enabled = YES;
            qingbutton.enabled = YES;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
            
            chuanButton1.enabled = YES;
            castButton.alpha = 1;
            chuanButton1.alpha = 1;
        }
        
    }else{
        if (one < 2) {
            chuanButton1.enabled = NO;
            
            chuanButton1.alpha = 0.5;
            
        }else {
            
            chuanButton1.enabled = YES;
            
            chuanButton1.alpha = 1;
        }
        if (one < 1) {
            castButton.enabled = NO;
            castButton.alpha = 0.5;
            qingbutton.enabled = NO;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
            
        }else{
            castButton.enabled = YES;
            castButton.alpha = 1;
            qingbutton.enabled = YES;
            [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
            
        }
        
        
    }
    if (one == 0) {
        labelch.text = @"串法";
        //        twoLabel.text = @"0";
        //        oneLabel.text = @"0";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        fieldLable.text = @"场";
        pourLable.hidden = YES;
        twoLabel.hidden = YES;
        addchuan = 0;
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
        
    }
    int allDFS = 0;
    for (int j = 0; j < [allcellarr count]; j++) {
        
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        if ((!bet.selection1 && !bet.selection2 && !bet.selection3 ) || one == 1) {
            
            
            bet.dandan = NO;
        }
        
        [allcellarr replaceObjectAtIndex:j withObject:bet];
        
        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan) {
            if (bet.selection1 || bet.selection2 || bet.selection3) {
                if (matchenum == matchEnumShengPingFuGuoGuan) {
                    if ([bet.onePlural rangeOfString:@" 1,"].location == NSNotFound && [bet.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                        if (allDFS == 0 || allDFS == 1) {
                            allDFS = 1;
                        }
                        
                    }else{
                        allDFS = 2;
                    }
                }else if (matchenum == matchEnumShengFuGuoguan){
                    if ([bet.pluralString isEqualToString:@""] || [bet.pluralString rangeOfString:@" 11,"].location != NSNotFound) {
                        if (allDFS == 0 || allDFS == 1) {
                            allDFS = 1;
                        }
                    }else{
                        allDFS = 2;
                    }
                }else if (matchenum == matchEnumRangFenShengFuGuoguan){
                    if ([bet.pluralString isEqualToString:@""] || [bet.pluralString rangeOfString:@" 12,"].location != NSNotFound) {
                        if (allDFS == 0 || allDFS == 1) {
                            allDFS = 1;
                        }
                    }else{
                        allDFS = 2;
                    }
                }else if (matchenum == matchEnumDaXiaFenGuoguan){
                    if ([bet.pluralString isEqualToString:@""] || [bet.pluralString rangeOfString:@" 14,"].location != NSNotFound) {
                        if (allDFS == 0 || allDFS == 1) {
                            allDFS = 1;
                        }
                    }else{
                        allDFS = 2;
                    }
                }
                
            }
        }
    }
    
    //  }
    [self calculateMoney];
    
    if (one > 1) {
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * be = [allcellarr objectAtIndex:j];
            be.nengyong = YES;
            [allcellarr replaceObjectAtIndex:j withObject:be];
        }
        //            [kebianzidian replaceObjectAtIndex:i withObject:arrkebian];
        //        }
        
    }
    
    //    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:index.row inSection:index.section+2];
    //    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [myTableView reloadData];
    buttonBool = NO;
    
    
    if( matchenum == matchEnumHunHeErXuanYi || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan){
        
        if ((matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan)&& allDFS == 1 && one == 1) {
            
            
            if (allDFS == 1) {
                [chuantype removeAllObjects];
                UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                senbutton.tag = 1;
                senbutton.titleLabel.text = [NSString stringWithFormat:@"单关"];
                [self pressChuanJiuGongGe:senbutton];
                
            }
        }else {
            if (one > 1 && one < 5) {
                BOOL danboolx = NO;
                for (GC_BetData * da in allcellarr) {
                    if (da.dandan) {
                        danboolx = YES;
                        break;
                    }
                    
                }
                if (danboolx) {
                    
                    
                    labelch.text = @"串法";
                    
                    oneLabel.text = [NSString stringWithFormat:@"%d", one];
                    fieldLable.text = @"场";
                    pourLable.hidden = YES;
                    twoLabel.hidden = YES;
                    addchuan = 0;
                    [chuantype removeAllObjects];
                    //                }
                    
                }else{
                    
                    [chuantype removeAllObjects];
                    UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    senbutton.tag = 1;
                    senbutton.titleLabel.text = [NSString stringWithFormat:@"%d串1", one];
                    [self pressChuanJiuGongGe:senbutton];
                    
                }
                
            }
        }
        
        
        
    }
    
}



- (void)chaodanshuzu{
    for (int i = 0; i < [betrecorinfo.betContentArray count]; i++) {
        NSLog(@"201 = %@", [betrecorinfo.betContentArray objectAtIndex:i]);
    }
    NSLog(@"guoguanwanfa = %@", betrecorinfo.guguanWanfa);
    if ([betrecorinfo.wanfaId isEqualToString:@"05"]) {
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumBiFenDanGuan;
            tagbao = 12;
            titleLabel.text = @"比分";
        }else{
            matchenum = matchEnumBiFenGuoguan;
            tagbao = 11;
            titleLabel.text = @"比分";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"10"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumShengPingFuDanGuan;
            tagbao = 3;
            titleLabel.text = @"胜平负";
        }else{
            matchenum = matchEnumShengPingFuGuoGuan;
            tagbao = 2;
            titleLabel.text = @"胜平负";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"04"]){
        
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumBanQuanChangDanGuan;
            tagbao = 9;
            titleLabel.text = @"半全场胜平负";
        }else{
            matchenum = matchenumBanQuanChang;
            tagbao = 8;
            titleLabel.text = @"半全场胜平负";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"03"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumZongJinQiuShuDanGuan;
            tagbao = 4;
            titleLabel.text = @"总进球数";
        }else{
            matchenum = matchenumZongJinQiuShu;
            tagbao = 3;
            titleLabel.text = @"总进球数";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"06"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumShengFuDanGuan;
            tagbao = 3;
            titleLabel.text = @"胜负";
        }else{
            matchenum = matchEnumShengFuGuoguan;
            tagbao = 2;
            titleLabel.text = @"胜负";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"07"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumRangFenShengFuDanGuan;
            tagbao = 6;
            titleLabel.text = @"让分胜负";
        }else{
            matchenum = matchEnumRangFenShengFuGuoguan;
            tagbao = 5;
            titleLabel.text = @"让分胜负";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"08"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumShengFenChaDanGuan;
            tagbao = 9;
            titleLabel.text = @"胜分差";
        }else{
            matchenum = matchEnumShengFenChaGuoguan;
            tagbao = 8;
            titleLabel.text = @"胜分差";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"09"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumDaXiaoFenDanGuan;
            tagbao = 12;
            titleLabel.text = @"大小分";
        }else{
            matchenum = matchEnumDaXiaFenGuoguan;
            tagbao = 11;
            titleLabel.text = @"大小分";
        }
        
    }else if([betrecorinfo.wanfaId isEqualToString:@"01"]){
        if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
            matchenum = matchEnumRangQiuShengPingFuDanGuan;
            tagbao = 15;
            titleLabel.text = @"让球胜平负";
        }else{
            matchenum = matchEnumRangQiuShengPingFuGuoGuan;
            tagbao = 14;
            titleLabel.text = @"让球胜平负";
        }
        
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width-20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 17, 17);
    //    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width,2, 20, 34);
    //    wanfaLabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+10, 4, 50, 34);
    
    oneLabel.text = betrecorinfo.betsNum;
    twoLabel.text = betrecorinfo.programAmount;
    NSLog(@"jine = %@  %@", betrecorinfo.betsNum, betrecorinfo.programAmount);
    one = (int)[betrecorinfo.betContentArray count];
    if (![betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
        chaobool = NO;
        NSRange chuanfa = [betrecorinfo.guguanWanfa rangeOfString:@","];
        if (chuanfa.location != NSNotFound) {
            labelch.text = @"多串...";
        }else{
            NSArray * arrchuan = [betrecorinfo.guguanWanfa componentsSeparatedByString:@"x"];
            
            labelch.text = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
        }
        
    }else{
        labelch.text = @"单关";
        chaobool = YES;
    }
    chuanButton1.enabled = YES;
    castButton.enabled = YES;
    qingbutton.enabled = YES;
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    
    castButton.alpha = 1;
    chuanButton1.alpha = 1;
    
    //
    for (int m = 0; m < [betrecorinfo.betContentArray count]; m++) {
        NSString * contentstr = [betrecorinfo.betContentArray objectAtIndex:m];
        NSArray * contarr = [contentstr componentsSeparatedByString:@";"];
        NSString * danstr = [contarr objectAtIndex:3];
        
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * kebianarr = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [kebianarr count]; j++) {
                GC_BetData * be = [kebianarr objectAtIndex:j];
                if ([be.changhao isEqualToString:[contarr objectAtIndex:7]]) {
                    NSString *shengpingfustr = [contarr objectAtIndex:8];
                    NSRange douhao = [shengpingfustr rangeOfString:@","];
                    if (douhao.location != NSNotFound) {
                        NSArray * spfarr = [shengpingfustr componentsSeparatedByString:@","];
                        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan ||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan|| matchenum ==matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan) {
                            
                            
                            if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
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
                            }else if(matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan){
                                
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }else if(matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan){
                                
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"让分主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"让分主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }else if(matchenum ==matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                                
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"大"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"小"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }else if(matchenum == matchEnumBiFenGuoguan ||  matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan||matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou){
                            NSMutableArray * bifenarr = nil;
                            if (matchenum == matchEnumBiFenGuoguan|| matchenum == matchEnumBiFenDanGuan) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if(matchenum == matchenumBanQuanChang||matchenum == matchEnumBanQuanChangDanGuan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if(matchenum == matchenumZongJinQiuShu||matchenum == matchEnumZongJinQiuShuDanGuan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                            }else if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                            }else if(matchenum == MatchEnumLanqiuHunTou){
                                bifenarr = [NSMutableArray arrayWithObjects: @"主负", @"主胜",@"让分主负", @"让分主胜", @"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
                            }
                            
                            
                            NSMutableArray * shuarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int s = 0; s < [bifenarr count]; s++) {
                                [shuarr addObject:@"0"];
                            }
                            
                            for (int a = 0; a < [spfarr count]; a++) {
                                
                                //                                NSString * qianstr = [[spfarr objectAtIndex:a] substringToIndex:1];
                                //                                NSString * houstr = [[spfarr objectAtIndex:a] substringWithRange:NSMakeRange(1, 1)];
                                //                                NSString * zongstr = [NSString stringWithFormat:@"%@:%@", qianstr, houstr];
                                NSString * zongstr = [spfarr objectAtIndex:a];
                                NSRange ssp = [zongstr rangeOfString:@" "];
                                if (ssp.location != NSNotFound) {
                                    NSArray * kongs = [zongstr componentsSeparatedByString:@" "];
                                    zongstr = [kongs objectAtIndex:0];
                                }
                                NSLog(@"zong = %@", zongstr);
                                if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou){
                                    NSArray * bifenarr1 = nil;
                                    if (matchenum == MatchEnumLanqiuHunTou) {
                                        bifenarr = [NSMutableArray arrayWithObjects:@"主负", @"主胜", @"让分主负", @"让分主胜",@"大", @"小",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", @"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+", nil];
                                    }else{
                                        bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
                                    }
                                    
                                    for (int b = 0; b < [bifenarr count]; b++) {
                                        if ([zongstr isEqualToString:[bifenarr objectAtIndex:b]]||[zongstr isEqualToString:[bifenarr1 objectAtIndex:b]]) {
                                            
                                            [shuarr replaceObjectAtIndex:b withObject:@"1"];
                                            break;
                                            // [be.bufshuarr replaceObjectAtIndex:b withObject:@"1"];
                                            //                                        [kebianarr replaceObjectAtIndex:j withObject:be];
                                            //                                        [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        }
                                    }
                                    
                                    
                                }else{
                                    
                                    for (int b = 0; b < [bifenarr count]; b++) {
                                        if ([zongstr isEqualToString:[bifenarr objectAtIndex:b]]) {
                                            
                                            [shuarr replaceObjectAtIndex:b withObject:@"1"];
                                            break;
                                            // [be.bufshuarr replaceObjectAtIndex:b withObject:@"1"];
                                            //                                        [kebianarr replaceObjectAtIndex:j withObject:be];
                                            //                                        [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        }
                                    }
                                    
                                    
                                }
                                
                            }
                            NSLog(@"arr = %@", shuarr);
                            be.bufshuarr = shuarr;
                            [shuarr release];
                            
                            
                            
                            
                            NSString * strbi = @"";
                            for (int q = 0; q < [be.bufshuarr count]; q++) {
                                if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                                    
                                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                                    NSLog(@"bi = %@", strbi);
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                            
                            NSLog(@"becell = %@", be.cellstring);
                        }
                        
                        
                    }else {
                        if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan|| matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan|| matchenum ==matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                            if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
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
                            }else if(matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan){
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                                
                                
                                
                            }else if(matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan){
                                
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"让分主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"让分主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                                
                                
                            }else if(matchenum ==matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan){
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                        be.selection2 = YES;
                                    }
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"大"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"小"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                                
                            }
                            
                            
                        }else if(matchenum == matchEnumBiFenGuoguan ||  matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan||matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan ){
                            NSMutableArray * bifenarr = nil;
                            if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if(matchenum == matchenumBanQuanChang||matchenum == matchEnumBanQuanChangDanGuan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if(matchenum == matchenumZongJinQiuShu|| matchenum == matchEnumZongJinQiuShuDanGuan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                            }else if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                            }
                            NSMutableArray * shuarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int s = 0; s < [bifenarr count]; s++) {
                                [shuarr addObject:@"0"];
                            }
                            NSRange ssp = [shengpingfustr rangeOfString:@" "];
                            if (ssp.location != NSNotFound) {
                                NSArray * kongs = [shengpingfustr componentsSeparatedByString:@" "];
                                shengpingfustr = [kongs objectAtIndex:0];
                            }
                            if(matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan){
                                NSArray * bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
                                for (int a = 0; a < [bifenarr count]; a++) {
                                    
                                    
                                    
                                    if ([[bifenarr objectAtIndex:a] isEqualToString:shengpingfustr]||[[bifenarr1 objectAtIndex:a] isEqualToString:shengpingfustr]) {
                                        //  [be.bufshuarr replaceObjectAtIndex:a withObject:@"1"];
                                        [shuarr replaceObjectAtIndex:a withObject:@"1"];
                                        //                                    [kebianarr replaceObjectAtIndex:j withObject:be];
                                        //                                    [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        //
                                    }
                                }
                            }else{
                                
                                for (int a = 0; a < [bifenarr count]; a++) {
                                    
                                    
                                    
                                    if ([[bifenarr objectAtIndex:a] isEqualToString:shengpingfustr]) {
                                        //  [be.bufshuarr replaceObjectAtIndex:a withObject:@"1"];
                                        [shuarr replaceObjectAtIndex:a withObject:@"1"];
                                        //                                    [kebianarr replaceObjectAtIndex:j withObject:be];
                                        //                                    [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        //
                                    }
                                }
                                
                            }
                            
                            be.bufshuarr = shuarr;
                            NSLog(@"shuarr = %@", shuarr);
                            [shuarr release];
                            NSString * strbi = @"";
                            for (int q = 0; q < [be.bufshuarr count]; q++) {
                                if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                                    
                                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                                    NSLog(@"bi = %@", strbi);
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                            NSLog(@"becell = %@", be.cellstring);
                        }
                        
                        
                    }
                    
                    if ([danstr isEqualToString:@"1"]) {
                        be.dandan = YES;
                    }
                    
                }
                [kebianarr replaceObjectAtIndex:j withObject:be];
                [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                
            }
        }
        
    }
    //   [myTableView reloadData];
    //[daaa replaceObjectAtIndex:index.row withObject:da];
    if ([betrecorinfo.guguanWanfa isEqualToString:@"单关"]) {
        [self calculateMoney];
    }else{
        [self pressChuanButton];
    }
    
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * kebianarr = [kebianzidian objectAtIndex:i];
    //        for (int j = 0; j < [kebianarr count]; j++) {
    //            GC_BetData * be = [kebianarr objectAtIndex:j];
    //
    //            NSLog(@"be.cell = %@", be.cellstring);
    //        }
    //    }
    
    [cbgview removeFromSuperview];
    
}


- (void)dayushiwuchang{
    
    
    for (int i = 15; i < [cellarray count]; i++) {
        GC_BetData * dabet = [cellarray objectAtIndex:i];
        dabet.selection1 = NO;
        dabet.selection2 = NO;
        dabet.selection3 = NO;
    }
    
    [myTableView reloadData];
}

-(void)requestSuccess:(ASIHTTPRequest*)mrequest {
    NSDictionary *dic = [mrequest userInfo];
    
    NSString *obj;
    obj = [dic objectForKey:@"key"];
    NSLog(@"obj = %@", obj);
    NSData *responseData = [mrequest responseData];
    NSInteger scrollto = 0;//滚到第0行
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
        }else if(obj&&[obj isEqualToString:@"match"]){// 赛事选择项
            [saishiArray removeAllObjects];
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
            [match release];
        }else if(obj&&[obj isEqualToString:@"duizhen"]){// 对阵列表
            
            if (lanqiubool) {
                //                if (matchenum == matchEnumShengFuGuoguan) {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneDoubleBasketball"] intValue] == 0) {
                    
                    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"BasketballShakeGuide"] isEqualToString:@"1"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"oneDoubleBasketball"];
                        
                        //弹框
                        FootballHintView * hintView = [[FootballHintView alloc] initType:oneShowType];
                        [hintView show];
                        [hintView release];
                    }
                }
                //                }
            }else{
                //                if (matchenum == matchEnumHunHeGuoGuan) {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneDoubleFootball"] intValue] == 0) {
                    
                    
                    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"FootballShakeGuide"] isEqualToString:@"1"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"oneDoubleFootball"];
                        
                        //弹框
                        FootballHintView * hintView = [[FootballHintView alloc] initType:oneShowType];
                        [hintView show];
                        [hintView release];
                    }
                    
                }
                //                }
            }
            
            
            
            
            GC_JingCaiDuizhenChaXun *duizhen = [[GC_JingCaiDuizhenChaXun alloc] initWithResponseData:responseData WithRequest:mrequest];
            self.beginTime = duizhen.beginTime;
            self.beginInfo = duizhen.beginInfo;
            if (duizhen.returnId == 3000) {
                [duizhen release];
                //                [self requestHttpQingqiu];
                
                if (loadview) {
                    [loadview stopRemoveFromSuperview];
                    loadview = nil;
                }
                
                return;
            }
            
            if (duizhen&&duizhen.count == 0 && duizhen.updata == 1) {
                if (biaoshi == 1 || biaoshi == 2) {
                    
                }else{
                    [kebianzidian removeAllObjects];
                }
                if (biaoshi != 1 && biaoshi != 2) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"暂无赛事信息，请选择其他彩种进行购买"];
                    
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
                        recordLabel.text = @"暂无赛事信息，请选择其他彩种进行购买";
                        recordLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                        recordLabel.textAlignment = NSTextAlignmentCenter;
                        [self.mainView addSubview:recordLabel];
                        [recordLabel release];
                    }
                    recordImage.hidden = NO;
                    recordLabel.hidden = NO;
                    myTableView.hidden = YES;
                    upimageview.hidden = YES;
                    
                    
                }
                
                [myTableView reloadData];
                [loadview stopRemoveFromSuperview];
                loadview = nil;
                return;
            }
            recordImage.hidden = YES;
            recordLabel.hidden = YES;
            myTableView.hidden = NO;
            
            
            if (duizhen.count > 0 && [duizhen.listData count] == 0 && duizhen.updata == 1) {
                
                if (countjishuqi < 3) {
                    countjishuqi += 1;
                    [self requestHttpQingqiu];
                    
                }else{
                    countjishuqi = 0;
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"网络原因，请稍后再试"];
                    [myTableView reloadData];
                    [loadview stopRemoveFromSuperview];
                    loadview = nil;
                    return;
                }
                [duizhen release];
                return;
                
            }
            
            if (duizhen.updata == 1 && duizhen.count > 0) {//保存时间戳
                
                
                [[NSUserDefaults standardUserDefaults] setValue:duizhen.dateString forKey:[self  objectKeyStringSaveHuanCun]];
                //                [[NSUserDefaults standardUserDefaults] setValue:duizhen.listData forKey:[self  objectKeyStringSaveDuiZhen]];
                [[NSUserDefaults standardUserDefaults] setValue:responseData forKey:[self  objectKeyStringSaveDuiZhen]];
            }
            
            
            self.sysTimeSave  = duizhen.sysTimeString;
            
            if ((duizhen&&duizhen.listData)|| duizhen.updata == 0) {
                
                if (duizhen.updata == 0 && biaoshi != 1&&biaoshi != 2) {
                    NSLog(@"xxxx = %@", [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]]);
                    NSData *responseData2 = [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]] ;
                    
                    GC_JingCaiDuizhenChaXun *duizhen2 = [[GC_JingCaiDuizhenChaXun alloc] initWithResponseData:responseData2 WithRequest:mrequest];
                    self.resultList = duizhen2.listData;
                    [duizhen2 release];
                    
                }else{
                    self.resultList = duizhen.listData;
                }
                
                
                // mTableView.hidden = NO;
                // [mTableView reloadData];
                if (biaoshi == 1 || biaoshi == 2) {
                    
                }else{
                    [allcellarr removeAllObjects];
                }
                //                NSInteger adsasdf = 0;
                for (GC_JingCaiDuizhenResult * gc in self.resultList) {
                    GC_BetData * be = [[GC_BetData alloc] init];
                    be.event = gc.match;
                    NSArray * timedata = [gc.deathLineTime componentsSeparatedByString:@" "];
                    be.date = [timedata objectAtIndex:0];
                    be.time = [timedata objectAtIndex:1];
                    if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan|| matchenum == matchEnumShengFenChaGuoguan ||matchenum == matchEnumShengFenChaDanGuan|| matchenum == MatchEnumLanqiuHunTou) {
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", gc.vistorTeam, gc.homeTeam,gc.rangQiu];
                        NSLog(@"team = %@", gc.rangQiu);
                    }else{
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", gc.homeTeam,gc.vistorTeam, gc.rangQiu];
                    }
                    
                    be.saishiid = gc.bicaiid;
                    be.numzhou = gc.num;
                    be.changhao = gc.matchId;
                    be.bifen = gc.score;
                    be.caiguo = gc.lotteryResult;
                    be.oupeiPeilv = gc.europeOdds;
                    be.aomenoupei = gc.aomenoupei;
                    be.zhongzu = gc.zhongzu;
                    be.macthTime = gc.macthTime;
                    be.macthType = gc.macthType;
                    be.datetime = gc.datetime;
                    be.zlcString =  gc.zlcString;
                    be.timeSort = gc.timeSort;
                    be.onePlural = gc.onePlural;
                    be.hhonePlural = gc.hhonePlural;
                    be.pluralString = gc.pluralString;
                    be.hostName = gc.homeTeam;
                    be.guestName = gc.vistorTeam;
                    
                    NSArray * nutimearr = [gc.datetime componentsSeparatedByString:@" "];
                    be.numtime = [nutimearr objectAtIndex:0];
                    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan ||  matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengPingFuDanGuan|| matchenum == matchEnumShengFenChaDanGuan|| matchenum == matchEnumShengFenChaGuoguan || matchenum == MatchEnumLanqiuHunTou) {
                        be.oupeistr = gc.odds;
                        NSLog(@"ddddd= %@", be.oupeistr);
                    }
                    
                    NSLog(@"id = %@", gc.bicaiid);
                    if ([gc.odds length] > 1) {
                        NSArray * butarray = [gc.odds componentsSeparatedByString:@" "];
                        
                        if ( matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan||matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan ||  matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengFenChaGuoguan|| matchenum == matchEnumShengFenChaDanGuan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
                            
                            NSArray * oepei = [gc.odds componentsSeparatedByString:@" "];
                            
                            if (matchenum == MatchEnumLanqiuHunTou) {//篮球混投的时候 后面胜分差转一下
                                
                                if ([oepei count] > 17) {
                                    NSMutableArray * oupArr = [NSMutableArray array];
                                    for (int b = 0; b < [oepei count]; b++) {
                                        if (b < 6) {
                                            [oupArr addObject:[oepei objectAtIndex:b]];
                                        }
                                        if (b > 5 && b < 12) {
                                            [oupArr addObject:[oepei objectAtIndex:b+6]];
                                        }
                                        if (b > 11) {
                                            [oupArr addObject:[oepei objectAtIndex:b - 6]];
                                        }
                                    }
                                    be.oupeiarr = oupArr;
                                    
                                    
                                }
                                
                            }else{
                                be.oupeiarr = oepei;
                            }
                            
                            
                            be.but1 = [butarray objectAtIndex:0];
                            // NSLog(@"but = %@", betdata.but1);
                            be.but2 = [butarray objectAtIndex:1];
                            be.but3 = [butarray objectAtIndex:2];
                        }
                        if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan) {
                            NSArray * oepei = [gc.odds componentsSeparatedByString:@" "];
                            
                            
                            be.oupeiarr = oepei;
                            be.but1 = [butarray objectAtIndex:0];
                            // NSLog(@"but = %@", betdata.but1);
                            be.but2 = [butarray objectAtIndex:1];
                            
                        }
                        if (matchenum == matchEnumHunHeGuoGuan || matchenum == matchEnumHunHeErXuanYi) {
                            
                            
                            NSArray * caiarr = [gc.odds componentsSeparatedByString:@","];
                            NSArray * caionearr = [[caiarr objectAtIndex:0] componentsSeparatedByString:@" "];
                            NSArray * caitwoarr = [[caiarr objectAtIndex:1] componentsSeparatedByString:@" "];
                            
                            be.oupeiarr = [NSArray arrayWithObjects:[caionearr objectAtIndex:0], [caionearr objectAtIndex:1],[caionearr objectAtIndex:2],[caitwoarr objectAtIndex:0], [caitwoarr objectAtIndex:1],[caitwoarr objectAtIndex:2], nil];
                            
                            
                            
                            //                            be.oupeiarr = [NSArray arrayWithObjects:@"23", @"32", @"13", @"-", @"-", @"-", nil];
                        }
                        
                        
                    }
                    
                    be.cellstring = @"请选择投注选项";
                    
                    
                    NSLog(@"saishi = %@", gc.match);
                    NSLog(@"zhu dui = %@", gc.homeTeam);
                    NSLog(@"ke dui = %@", gc.vistorTeam);
                    NSLog(@"shijian = %@", gc.deathLineTime);
                    NSLog(@"ou pei = %@", gc.odds);
                    NSLog(@"num = %@", gc.deathLineTime);
                    NSLog(@"caiguo = %@", be.caiguo);
                    // [cellarray addObject:be];
                    
                    if (self.zhuanjiaDic) {
                        for (NSDictionary *dic in [self.zhuanjiaDic valueForKey:@"contentInfo"]) {
                            if (dic) {
                                if ([gc.bicaiid isEqualToString:[dic valueForKey:@"playId"]]) {
                                    NSString *recommendContent = [dic valueForKey:@"recommendContent"];//专家投注内容
                                    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
                                    if ([[dic valueForKey:@"playTypeCode"] isEqualToString:@"10"]) {//胜平负
                                        if([recommendContent rangeOfString:@"胜"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:0 withObject:@"1"];
                                        }
                                        if([recommendContent rangeOfString:@"平"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:1 withObject:@"1"];
                                        }
                                        if([recommendContent rangeOfString:@"负"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:2 withObject:@"1"];
                                        }
                                        
                                    }
                                    else {
                                        if([recommendContent rangeOfString:@"胜"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:3 withObject:@"1"];
                                        }
                                        if([recommendContent rangeOfString:@"平"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:4 withObject:@"1"];
                                        }
                                        if([recommendContent rangeOfString:@"负"].location !=NSNotFound){
                                            [array replaceObjectAtIndex:5 withObject:@"1"];
                                        }
                                    }
                                    be.bufshuarr = array;
                                    scrollto = [allcellarr count];
                                }
                            }
                        }
                    }
                    if (self.cc_id) {
                        if ([gc.num isEqualToString:self.cc_id]) {
                            scrollto = [allcellarr count];
                        }
                    }
                    
                    if (biaoshi == 1) {
                        NSMutableArray * cellarraytime = [wangqiArray objectForKey:@"0"];
                        [cellarraytime addObject:be];
                        NSLog(@"cellarr = %@", cellarraytime);
                    }else if(biaoshi == 2){
                        NSMutableArray * cellarraytime = [wangqiArray objectForKey:@"1"];
                        [cellarraytime addObject:be];
                        NSLog(@"cellarr = %@", cellarraytime);
                    }else{
                        [allcellarr addObject:be];
                    }
                    
                    
                    
                    NSLog(@"wangqi = %@", wangqiArray);
                    
                    
                    [be release];
                }
                
                
                
                
                
                if (biaoshi == 1 || biaoshi == 2) {//第一段和第二段
                    
                    //                    NSMutableArray * cellarraytime = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", biaoshi-1]];
                    //                    if ([cellarraytime count] > 0) {
                    //                        GC_BetData * betime = [cellarraytime objectAtIndex:0];
                    //                        //                        timezhongjie
                    //                        NSString * timeone = betime.date;
                    //                        NSArray * arrtime = [self.timezhongjie componentsSeparatedByString:@"-"];
                    //                        NSString * timetwo = [NSString stringWithFormat:@"%@-%@", [arrtime objectAtIndex:1], [arrtime objectAtIndex:2]];
                    //                        NSLog(@"dd = %@ xxx = %@", timeone, timetwo);
                    //
                    //                        if (![timeone isEqualToString:timetwo]) {
                    //                            //                            [cellarraytime removeAllObjects];
                    //                            if (biaoshi == 1) {
                    //                                oneHead = YES;
                    //                            }else{
                    //                                twoHead = YES;
                    //                            }
                    //                        }else{
                    //                            if (biaoshi == 1) {
                    //                                oneHead = NO;
                    //                            }else{
                    //                                twoHead = NO;
                    //                            }
                    //                        }
                    //
                    //                    }
                    
                    
                    
                    
                    
                }else{
                    [kebianzidian removeAllObjects];
                    [self shaixuanzidian:allcellarr];
                    
                    if (chaocount == 0) {
                        if (chaodanbool) {
                            [self chaodanshuzu];
                        }
                    }
                    chaocount++;
                    
                    
                    [saishiArray removeAllObjects];
                    //赛事筛选
                    GC_BetData * betda = [allcellarr objectAtIndex:0];
                    if ([betda.event length] >5) {
                        betda.event = [betda.event substringToIndex:5];
                    }
                    NSString * saishi = [betda.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                    [saishiArray addObject:saishi];
                    
                    
                    for (int i = 0; i < [allcellarr count]; i++) {
                        BOOL xiangtong = NO;
                        GC_BetData * begc = [allcellarr objectAtIndex:i];
                        if ([begc.event length] >5) {
                            begc.event = [begc.event substringToIndex:5];
                        }
                        for (int j = 0; j < [saishiArray count]; j++) {
                            
                            NSString * sai = [saishiArray objectAtIndex:j];
                            NSString * saishi1 = [begc.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            NSString * saishi2 = [sai stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if ([saishi1 isEqualToString:saishi2]) {
                                xiangtong = YES;
                            }
                        }
                        if (xiangtong != YES) {
                            if ([begc.event length] >5) {
                                begc.event = [begc.event substringToIndex:5];
                            }
                            NSString * saishi = [begc.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                            [saishiArray addObject:saishi];
                            
                        }
                        
                        
                    }
                    if ([kebianzidian count] > 1) {
                        NSMutableArray * mutarr = [kebianzidian objectAtIndex:0];
                        if ([mutarr count] <= 4 ) {
                            buffer[3] = 1;
                        }
                    }
                    
                }
                
                if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumHunHeGuoGuan) {
                    [self sortFunc:[NSString stringWithFormat:@"%d", (int)sortCount]];///////排序
                }
                
                
                
                
                [myTableView reloadData];
                ////////////////////////////////////////////////////////////////////////查找第一个能够购买的对阵
                
                
                if (lanqiubool == NO) {
                    
                    if (gcdgBool) {///////////////// 购彩大厅点击 单关进来
                        
                        onlyDG = YES;
                        [self gcdgFunc];
                        
                    }
                    
                    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    if (biaoshi != 1 && biaoshi != 2) {
                        BOOL continuebool = NO;
                        for (int i = 0; i < [kebianzidian count]; i++) {
                            NSMutableArray * dataArr = [kebianzidian objectAtIndex:i];
                            
                            for (int j = 0; j < [dataArr count]; j++) {
                                
                                GC_BetData * dataBegin = [dataArr objectAtIndex:j];
                                if ([dataBegin.macthType isEqualToString:@"playvs"]) {
                                    indexPath = [NSIndexPath indexPathForRow:j inSection:i+2];
                                    continuebool = YES;
                                    //                                dataBegin.oneMacth = @"1";
                                    break;
                                }
                                
                            }
                            if (continuebool) {
                                break;
                            }
                        }
                        
                        if (continuebool) {//////如果有的话 滑动到那一行  如果没有 就保持原来的样子
                            
                            buffer[indexPath.section] = 1;
                            [myTableView reloadData];
                            if ([kebianzidian count]+2 > indexPath.section) {
                                NSMutableArray * daarr = [kebianzidian objectAtIndex:indexPath.section-2];
                                if ([daarr count] > 0) {
                                    [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                                }
                            }
                            
                            
                        }
                        
                    }
                }
                
                
                
                /////////////////////////////////////////////////////////////////////////
            }
            [duizhen release];
            
            if(chaodanbool){
                [myTableView reloadData];
            }
            if (scrollto) {
                [myTableView reloadData];
                if (scrollto < [myTableView numberOfRowsInSection:2]) {
                    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scrollto inSection:2] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                }
                else {
                    buffer[3] = 1;
                    [myTableView reloadData];
                    if (scrollto < [myTableView numberOfRowsInSection:2] + [myTableView numberOfRowsInSection:3]) {
                        
                        [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scrollto - [myTableView numberOfRowsInSection:2] inSection:3] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    }
                }
                
            }
            
            
            
            
        }
        
        
        
        
        
    }else{
        
        [self requestHttpQingqiu];
    }
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    NSLog(@"keystring = %@", [self objectKeyString]);
    
    
    
    
    
    
    
    
    if (gcdgBool == NO) {//购彩大厅单关过来 不读缓存
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyString]] && biaoshi != 1 && biaoshi != 2) {
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
    self.gcdgBool = NO;
    
}

- (void)yinDaoButtonEnabled:(UIButton *)sender{
    sender.enabled = YES;
}
- (void)pressYinDaoButton{
    [yindaoview removeFromSuperview];
    
    
}




#pragma mark -
#pragma mark Table view delegate

- (void)duckImageCellHunTou:(CP_CanOpenCell *)cell{//混合的鸭子
    
    HunTouCell * cell2 = (HunTouCell *)cell;
    NSString * str  = nil;
    if (cell2.wangqibool) {
        str = [NSString stringWithFormat:@"%d %d", (int)cell2.row.section, (int)cell2.row.row];
    }else{
        str = [NSString stringWithFormat:@"%d %d", (int)cell2.row.section+2, (int)cell2.row.row];
    }
    NSArray * strarr = [duckDictionary allKeys];
    for (NSString * keyStr in strarr) {
        if (![keyStr isEqualToString:str]) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
            
            HunTouCell *cell3 = (HunTouCell *)[myTableView cellForRowAtIndexPath:index];
            cell3.duckImageOne.hidden = YES;
            cell3.duckImageTwo.hidden = YES;
            cell3.duckImageThree.hidden = YES;
            [duckDictionary removeObjectForKey:keyStr];
        }
        
    }
    
    
    [duckDictionary setObject:cell forKey:str];
    
}
- (void)duckImageCell:(CP_CanOpenCell *)cell{//胜平负的鸭子
    
    GC_JCBetCell * cell2 = (GC_JCBetCell *)cell;
    NSString * str  = nil;
    if (cell2.wangqibool) {
        str = [NSString stringWithFormat:@"%d %d", (int)cell2.row.section, (int)cell2.row.row];
    }else{
        str = [NSString stringWithFormat:@"%d %d", (int)cell2.row.section+2, (int)cell2.row.row];
    }
    NSArray * strarr = [duckDictionary allKeys];
    for (NSString * keyStr in strarr) {
        if (![keyStr isEqualToString:str]) {
            
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
            
            GC_JCBetCell *cell3 = (GC_JCBetCell *)[myTableView cellForRowAtIndexPath:index];
            cell3.duckImageOne.hidden = YES;
            cell3.duckImageTwo.hidden = YES;
            cell3.duckImageThree.hidden = YES;
            [duckDictionary removeObjectForKey:keyStr];
        }
        
        
    }
    
    
    [duckDictionary setObject:cell forKey:str];
    
}

- (void)deleteContentOff:(NSString *)equal{
    
    NSArray * keys = [ContentOffDict allKeys];
    if (keys > 0) {
        for (NSString * keyStr in keys) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
            
            if (![keyStr isEqualToString:equal]) {
                [UIView beginAnimations:@"ndd" context:NULL];
                [UIView setAnimationDuration:.3];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
                cell2.butonScrollView.contentOffset = CGPointMake(0, cell2.butonScrollView.contentOffset.y);
                [UIView commitAnimations];
                
                
                GC_BJdcCell * jccell = (GC_BJdcCell *)cell2;
                if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
                }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                    
                }
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

//- (void)deleteContentOff:(NSString *)equal{
//
//    NSArray * keys = [ContentOffDict allKeys];
//    if (keys > 0) {
//        for (NSString * keyStr in keys) {
//            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
//
//            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
//
//            if (![keyStr isEqualToString:equal]) {
//                [UIView beginAnimations:@"ndd" context:NULL];
//                [UIView setAnimationDuration:.3];
//                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
//                cell2.butonScrollView.contentOffset = CGPointMake(0, cell2.butonScrollView.contentOffset.y);
//                [UIView commitAnimations];
//                if (matchenum == matchEnumHunHeGuoGuan) {
//
//                    HunTouCell * jccell = (HunTouCell *)cell2;
//                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght1.png");
//
//                }else if(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan){
//
//                    GC_JCBetCell * jccell = (GC_JCBetCell *)cell2;
//                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew1.png");
//                }
//            }
//
//
//
//        }
//        [ContentOffDict removeAllObjects];
//    }
//
//}


- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn{
    
    //    [ContentOffArray addObject:index];
    GC_BJdcCell *cell2 = (GC_BJdcCell *)[myTableView cellForRowAtIndexPath:index];
    NSString * str = @"";
    if (cell2.wangqibool) {
        str = [NSString stringWithFormat:@"%d %d", (int)index.section, (int)index.row];
    }else{
        str = [NSString stringWithFormat:@"%d %d", (int)index.section+2, (int)index.row];
    }
    
    if (yn == NO) {
        [self deleteContentOff:str];
        [ContentOffDict setObject:@"1" forKey:str];
        
    }else{
        [ContentOffDict removeObjectForKey:str];
    }
    
    
    
}

- (void)yanchiHiden:(NSIndexPath *)index {
    oldshowButnIndex = 0;
    UITableViewCell *cell= [myTableView cellForRowAtIndexPath:index];
    if (cell) {
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
        CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
        
        [cell2 hidenButonScollWithAnime:YES];
    }
}


- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
    
    if (matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumDaXiaoFenDanGuan|| matchenum == matchEnumShengFenChaGuoguan || matchenum == matchEnumShengFenChaDanGuan || matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumHunHeGuoGuan   ) {
        if (matchenum == MatchEnumLanqiuHunTou|| matchenum == matchEnumBigHunHeGuoGan) {
            xcount =[cell.allTitleArray count]*70;
        }else{
//            if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                xcount = 35+ ([cell.allTitleArray count]-1)*70;
//            }else {
                xcount =[cell.allTitleArray count]*70;
                
//            }
        }
        
    }else{
        xcount =[cell.allTitleArray count]*70;
    }
    
    
    NSLog(@"!11111111111111111");
    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
    [UIView commitAnimations];
    
    GC_BJdcCell * jccell = (GC_BJdcCell *)cell;
    if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan ) {
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    }
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
        
        GC_BJdcCell * jccell = (GC_BJdcCell *)cell;
        
        if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
            
        }
        
        
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


- (void)openCellbifen:(CP_CanOpenCell *)cell{
    if (matchenum == matchEnumHunHeGuoGuan) {
        buttonBool = NO;
        if (cell.butonScrollView.contentOffset.x > 0) {
            buttonBool = YES;
            NSLog(@"%f,%f",cell.butonScrollView.contentSize.width,cell.butonScrollView.contentSize.height);
            
            //            if ([cell.allTitleArray count] > 2) {
            [UIView beginAnimations:@"ndd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            NSLog(@"!22222222222222222");
            cell.butonScrollView.contentOffset = CGPointMake( 0, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            
            HunTouCell * jccell = (HunTouCell *)cell;
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght1.png");
            
            //            }
            //            return;
        }else{
            [UIView beginAnimations:@"nddd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            NSInteger xcount = 0;
//            if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                xcount = 35+ ([cell.allTitleArray count]-1)*70;
//            }else {
                xcount =[cell.allTitleArray count]*70;
                
//            }
            NSLog(@"!3333333333333333333");
            cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            
            
            HunTouCell * jccell = (HunTouCell *)cell;
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght2.png");
            
            
        }
        return;
    }
    
    NSIndexPath *indexPath = nil;
    GC_BiFenCell * jccell = (GC_BiFenCell *)cell;
    
    if (jccell.wangqibool) {
        indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section];
    }else{
        indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
        
    }
    
    
    cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
    if (cell.butonScrollView.hidden == NO) {
        
        zhankai[indexPath.section][indexPath.row] = 0;
        [cell showButonScollWithAnime:NO];
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [cell showButonScollWithAnime:NO];
        [cell hidenButonScollWithAnime:YES];
    }
    else {
        
        zhankai[indexPath.section][indexPath.row] = 1;
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [cell hidenButonScollWithAnime:NO];
        [cell showButonScollWithAnime:YES];
    }
    return;
}

- (void)xiDanReturn:(CP_CanOpenCell *)hunCell type:(NSInteger)type buttonType:(NSInteger)countType{
    
    
    
    
    NSIndexPath *indexPath = nil;
    HunTouCell * jccell = (HunTouCell *)hunCell;
    
    //    NSMutableArray * mutarr = [kebianzidian objectAtIndex:jccell.row.section];
    //    GC_BetData * pkbet = [mutarr objectAtIndex:jccell.row.row];
    //    pkbet.xidanCount = countType;
    
    
    indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
    hunCell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
    if (type >= 2) {
        
        zhankai[indexPath.section][indexPath.row] = 0;
        [hunCell showButonScollWithAnime:NO];
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        hunCell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [hunCell showButonScollWithAnime:NO];
        [hunCell hidenButonScollWithAnime:YES];
    }
    else if (type == 1){
        
        zhankai[indexPath.section][indexPath.row] = 1;
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        hunCell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [hunCell hidenButonScollWithAnime:NO];
        [hunCell showButonScollWithAnime:YES];
    }
}
- (void)sleepOpenCellHuntou:(CP_CanOpenCell *)cell{
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
//    if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//        xcount = 35+ ([cell.allTitleArray count]-1)*70;
//    }else {
        xcount =[cell.allTitleArray count]*70;
        
//    }
    NSLog(@"!5555555555555555555");
    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
    [UIView commitAnimations];
    HunTouCell * jccell = (HunTouCell *)cell;
    jccell.XIDANImageView.image = UIImageGetImageFromName(@"dakaixidanimage.png");
}
- (void)openCellHunTou:(CP_CanOpenCell *)cell{
    
    if (matchenum == matchEnumHunHeGuoGuan) {
        buttonBool = NO;
        if (cell.butonScrollView.contentOffset.x > 0) {
            buttonBool = YES;
            NSLog(@"%f,%f",cell.butonScrollView.contentSize.width,cell.butonScrollView.contentSize.height);
            
            //            if ([cell.allTitleArray count] > 2) {
            
            [UIView beginAnimations:@"ndd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            NSLog(@"!4444444444444444444");
            cell.butonScrollView.contentOffset = CGPointMake( 0, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            HunTouCell * jccell = (HunTouCell *)cell;
            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanimagebght1.png");
            //          /  }
            //            return;
        }else{
            [self performSelector:@selector(sleepOpenCellHuntou:) withObject:cell afterDelay:0.1];
        }
        return;
    }
    
    NSIndexPath *indexPath = nil;
    HunTouCell * jccell = (HunTouCell *)cell;
    
    indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
    
    cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
    if (cell.butonScrollView.hidden == NO) {
        //        pkbet.xidanCount = 0;
        zhankai[indexPath.section][indexPath.row] = 0;
        [cell showButonScollWithAnime:NO];
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [cell showButonScollWithAnime:NO];
        [cell hidenButonScollWithAnime:YES];
        
    }
    else {
        //        pkbet.xidanCount = 1;
        zhankai[indexPath.section][indexPath.row] = 1;
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [cell hidenButonScollWithAnime:NO];
        [cell showButonScollWithAnime:YES];
        
    }
    //    [myTableView reloadData];
    return;
}




#pragma mark - CP_CanOpenCellDelegate


- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index {
    //    [self deleteContentOff];
    
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumHunHeErXuanYi|| matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan ||  matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan||matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan||matchenum == MatchEnumLanqiuHunTou || matchenum == matchEnumBigHunHeGuoGan) {
        buttonBool = YES;
        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
        
        
        
        if (cell.butonScrollView.contentOffset.x > 0) {
            [UIView beginAnimations:@"ndd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            NSLog(@"!666666666666666666666666666666");
            cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
            if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
            }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                
            }else{
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
            }
            
        }
        
        
        if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"八方预测"]) {
            
            if (lanqiubool) {
                [MobClick event:@"event_goucai_xidan_bangfangyuce" label:@"竞彩篮球"];
            }else{
                [MobClick event:@"event_goucai_xidan_bangfangyuce" label:@"竞彩足球"];
            }
            
            NSIndexPath *indexPath = nil;
            if (jccell.wangqibool) {
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section];
            }else{
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
                
            }
            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (jccell.wangqibool == YES) {
                if (lanqiubool) {
                    LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSLog(@"%@", be.saishiid);
                    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
                    [self.navigationController pushViewController:sachet animated:YES];
#endif
                    [sachet release];
                }
                else {
                    
                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    
                    [self NewAroundViewShowFunc:be indexPath:jccell.row history:YES];
                    
                    //                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", jccell.row.section]];
                    //                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    //
                    //
                    //                    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
                    //                    //        sachet.playID = @"234028"; //传入这两个对比赛的id
                    //                    //    NSArray * allke = [kebianzidian allKeys];
                    //                    
                    //                    NSLog(@"%@", be.saishiid);
                    //                    sachet.playID = be.saishiid;
                    //#ifdef isCaiPiaoForIPad
                    //                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
                    //#else
                    //                    [self.navigationController pushViewController:sachet animated:YES];
                    //#endif
                    //                    [sachet release];
                }
                
            }else{
                
                if (lanqiubool) {
                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
                    if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                        NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                        neutrality.delegate = self;
                        [neutrality show];
                        [neutrality release];
                        return;
                    }
                    LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
                    //                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    //                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSLog(@"%@", be.saishiid);
                    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
                    [self.navigationController pushViewController:sachet animated:YES];
#endif
                    [sachet release];
                }
                else {
                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    
                    [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO] ;
                    
                    
                    
                    
                    
                    //                    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
                    //                    //        sachet.playID = @"234028"; //传入这两个对比赛的id
                    //                    //    NSArray * allke = [kebianzidian allKeys];
                    //                   
                    //                    NSLog(@"%@", be.saishiid);
                    //                    sachet.playID = be.saishiid;
                    //#ifdef isCaiPiaoForIPad
                    //                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
                    //#else
                    //                    [self.navigationController pushViewController:sachet animated:YES];
                    //#endif
                    //                    [sachet release];
                }
                
                
            }
            
            
            
            
        }
        else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"胆"]) {
            preDanBool = YES;
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            if (be.dandan == YES) {
                be.dandan = NO;
                //                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:Index];
                //                UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
                //                btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            }else{
                
                be.dandan = YES;
                
                
            }
            if(matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumRangFenShengFuGuoguan){
                [self returnBoolDan:be.dandan row:Index selctCell:cell];
            }else{
                [self returnBoolDanbifen:be.dandan row:Index selctCell:cell];
            }
            
        }else if([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"专家推荐"]){
            
            //            if (jccell.duckImageOne.hidden == YES) {
            //                jccell.duckImageOne.hidden = NO;
            //            }else{
            //            
            //                jccell.duckImageOne.hidden = YES;
            //            }
            //            
            //            
            //            [self duckViewAnimations:cell];
            if (lanqiubool) {
                [MobClick event:@"event_goucai_xidan_zhuanjia" label:@"竞彩篮球"];
            }else{
                [MobClick event:@"event_goucai_xidan_zhuanjia" label:@"竞彩足球"];
            }
            
            
            
            [UIView beginAnimations:@"ndd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            NSLog(@"!77777777777777");
            cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            
            
            if (matchenum == matchEnumHunHeGuoGuan) {
                
                HunTouCell * jccell = (HunTouCell *)cell;
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                
            }else if(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeErXuanYi || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumShengFuDanGuan ||  matchenum == matchEnumRangFenShengFuGuoguan || matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan||matchenum == matchEnumShengFenChaDanGuan || matchenum == matchEnumShengFenChaGuoguan||matchenum == MatchEnumLanqiuHunTou){
                
                GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
            }else  if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
            }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                
            }
            
            
            
        }else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"比分直播"]){
            
            GC_BetData * be = nil;
            NSIndexPath *indexPath = nil;
            if (jccell.wangqibool) {
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section];
                NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
                be = [duixiangarr objectAtIndex:jccell.row.row];
            }else{
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
                NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                be = [duixiangarr objectAtIndex:jccell.row.row];
                
            }
            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            
            
            MatchDetailViewController *matchDetailVC = [[MatchDetailViewController alloc] initWithNibName: @"MatchDetailViewController" bundle: nil];
            matchDetailVC.matchId = be.saishiid;
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
                matchDetailVC.lotteryId = @"201";
            }else if ( matchenum == matchEnumHunHeGuoGuan){
                matchDetailVC.lotteryId = @"202";
            }
            
            matchDetailVC.issue = be.numtime;
            matchDetailVC.shouldShowSwitch = NO;
            matchDetailVC.start = @"1";
            NSLog(@"111111111111111111 %@, %@, %@, %@", matchDetailVC.matchId,  matchDetailVC.lotteryId, matchDetailVC.issue,  matchDetailVC.start );
            [self.navigationController pushViewController:matchDetailVC animated:YES];
            [matchDetailVC release];
            
            
            
            
            
        } else if (Index == 101){//收起
            [self openCellHunTou:cell];
            
            
        }
        buttonBool = NO;
    }else{
        
        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
        if (Index == 0) {
            
            if (jccell.wangqibool == YES) {
                if (lanqiubool) {
                    LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSLog(@"%@", be.saishiid);
                    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
                    [self.navigationController pushViewController:sachet animated:YES];
#endif
                    [sachet release];
                }
                else {
                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    
                    [self NewAroundViewShowFunc:be indexPath:jccell.row history:YES];
                    //                    NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", jccell.row.section]];
                    //                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    //                   
                    //                    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
                    //                    //        sachet.playID = @"234028"; //传入这两个对比赛的id
                    //                    //    NSArray * allke = [kebianzidian allKeys];
                    //                    
                    //                    NSLog(@"%@", be.saishiid);
                    //                    sachet.playID = be.saishiid;
                    //#ifdef isCaiPiaoForIPad
                    //                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
                    //#else
                    //                    [self.navigationController pushViewController:sachet animated:YES];
                    //#endif
                    //                    [sachet release];
                }
                
            }else{
                
                if (lanqiubool) {
                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
                    if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
                        NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
                        neutrality.delegate = self;
                        [neutrality show];
                        [neutrality release];
                        return;
                    }
                    LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
                    //                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    //                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    NSLog(@"%@", be.saishiid);
                    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
                    [self.navigationController pushViewController:sachet animated:YES];
#endif
                    [sachet release];
                }
                else {
                    
                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    
                    [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
                    
                    
                    
                    
                    
                    //                    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
                    //                    //        sachet.playID = @"234028"; //传入这两个对比赛的id
                    //                    //    NSArray * allke = [kebianzidian allKeys];
                    //                    
                    //                    NSLog(@"%@", be.saishiid);
                    //                    sachet.playID = be.saishiid;
                    //#ifdef isCaiPiaoForIPad
                    //                    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
                    //#else
                    //                    [self.navigationController pushViewController:sachet animated:YES];
                    //#endif
                    //                    [sachet release];
                }
                
                
            }
            
            
            
            
        }
        else if (Index == 1) {
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            if (be.dandan == YES) {
                be.dandan = NO;
                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:Index];
                //            danbutton.backgroundColor = [UIColor blackColor];
                //            [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
                UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
                btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            }else{
                
                be.dandan = YES;
                
                
            }
            if(matchenum == matchEnumHunHeErXuanYi||matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengFuGuoguan || matchenum == matchEnumDaXiaFenGuoguan || matchenum == matchEnumRangFenShengFuGuoguan){
                [self returnBoolDan:be.dandan row:Index selctCell:cell];
            }else{
                [self returnBoolDanbifen:be.dandan row:Index selctCell:cell];
            }
            
        }else if (Index == 101){//收起
            [self openCellHunTou:cell];
            
            
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
    NSLog(@"aaaaaaaaaaaaaaa888888888888888888");
    //    self.beginTime = nil;
    [duckDictionary release];
    [ContentOffDict release];
    //    [chuanfadict release];
    [wangqiArray release];
    self.zhuanjiaDic = nil;
    self.cc_id = nil;
    
    [duoXuanArr release];
    [kongzhiType release];
    [betrecorinfo release];
    [chuantype release];
    [kebianzidian release];
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
    [qihaoArray release];
    [saishiArray release];
    [wanArray release];
    [resultList release];
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    [networkQueue reset];
    [networkQueue release];
    [cimgev release];
    [cbgview release];
    [bgimagedown release];
    
    [titleLabel release];
    [tabView release];
    [dataArray release];
    [betArray release];
    //    [request clearDelegatesAndCancel];
    //    self.request = nil;
    
    [oneLabel release];
    [twoLabel release];
    [myTableView release];
    //[pkArray release];
    [pkbetdata release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
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

- (void)pressWorldCupLogoDelegate{
    
    CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"现在购买世界杯比赛,可赢取国旗哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aler show];
    [aler release];
    
}

- (void)neutralityMatchViewDelegate:(NeutralityMatchView *)view withBetData:(GC_BetData *)be{
    
    
    if (self.lanqiubool) {
        LanQiuAroundViewController * sachet = [[LanQiuAroundViewController alloc] init];
        
        
        
        sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
        [self.navigationController pushViewController:sachet animated:YES];
#endif
        [sachet release];
    }
    else {
        //        //            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
        //        //            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
        //        //            [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
        
        
        //        NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
        //        //        sachet.playID = @"234028"; //传入这两个对比赛的id
        //        //    NSArray * allke = [kebianzidian allKeys];
        //        
        //        NSLog(@"%@", be.saishiid);
        //        sachet.playID = be.saishiid;
        //#ifdef isCaiPiaoForIPad
        //        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
        //#else
        //        [self.navigationController pushViewController:sachet animated:YES];
        //#endif
        //        [sachet release];
    }
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrollView.y = %f", myTableView.contentOffset.y);
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeGuoGuan){
        
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 43) {
            
            
            headView.frame = CGRectMake(0, -43 + (43 - scrollView.contentOffset.y) , 320, 43);
            
            
        }else{
            
            if (scrollView.contentOffset.y < 0) {
                headView.frame = CGRectMake(0, 0, 320, 43);
            }
            
            if (scrollView.contentOffset.y > 43) {
                headView.frame = CGRectMake(0, -43, 320, 43);
            }
        }
    }
    
    
}
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewDidEndScrollingAnimation");
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumHunHeGuoGuan){
//    
//        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 21) {
//            
//            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 43);
//            headView.frame = CGRectMake(0, -43, 320, 43);
//        }else if (scrollView.contentOffset.y > 21 && scrollView.contentOffset.y <= 43){
//        
//            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//            headView.frame = CGRectMake(0, 0, 320, 43);
//        }
//        else {
//        
//            if (scrollView.contentOffset.y < 0) {
//                headView.frame = CGRectMake(0, 0, 320, 43);
//                scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//            }
//            
//            if (scrollView.contentOffset.y > 43) {
//                headView.frame = CGRectMake(0, -43, 320, 43);
//                scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 43);
//            }
//        }
//    }
//
//}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
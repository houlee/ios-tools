//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCPLBetViewController.h"
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
#import "NetURL.h"
#import "Info.h"
#import "JSON.h"
#import "GC_NewAlgorithm.h"
#import "TopicThemeListViewController.h"
#import "Xieyi365ViewController.h"
#import "NSDate-Helper.h"
#import "YuJiJinE.h"
#import "GCHeMaiInfoViewController.h"
#import "MatchDetailViewController.h"
#import "FootballHintView.h"

//投注界面
@implementation GCPLBetViewController
@synthesize requestt;
@synthesize betArray;
@synthesize dataArray;
@synthesize issString;
@synthesize lotteryID;
@synthesize httprequest;
@synthesize resultList;
@synthesize selectedItemsDic;
@synthesize danDic, systimestr;

//@synthesize totalZhuShuWithDanDic;
- (void)pressWorldCupButton:(UIButton *)sender{
    
    NSMutableArray *array = [NSMutableArray array];
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
        //            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
        
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSArray arrayWithObjects:@"1.5以下", @"1.5-2.0", @"2.0以上",nil],@"choose", nil];
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"串关",nil],@"choose", nil];
        
        if ([duoXuanArr count] == 0) {
            //                NSMutableDictionary * type1 = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"1", @"1",nil],@"choose", nil];
            //                [duoXuanArr addObject:type1];
            [duoXuanArr addObject:type2];
            [duoXuanArr addObject:type3];
            
            if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumShengPingFuGuoGuan){
                
                [duoXuanArr addObject:type1];
            }
        }
        NSLog(@"%lu", (unsigned long)[duoXuanArr count]);
        
        //            [array addObject:dic];
        [array addObject:dic2];
        [array addObject:dic3];
        if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumShengPingFuGuoGuan){
            
            [array addObject:dic];
        }

    }else{
        
        NSDictionary *dic = nil;
        NSDictionary *dic3 = nil;
        if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
            
            dic = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"串关",nil],@"choose", nil];
            
            dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        }else{
            dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
        }
        
        if ([duoXuanArr count] == 0) {
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saishiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"1", @"1",nil],@"choose", nil];
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            [duoXuanArr addObject:type3];
            
            if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
                
                [duoXuanArr addObject:type1];
                
            }
        }
        [array addObject:dic3];
        
        if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
            
            [array addObject:dic];
        }
        
        
    }
    
    
    
    CP_KindsOfChoose  *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan ) {
        alert2.zhuanjiaBool = zhuanjiaBool;
    }
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang) {
        alert2.doubleBool = YES;
    }

    alert2.delegate = self;
    alert2.tag = 30;
    alert2.duoXuanBool = YES;
    [alert2 show];
    [alert2 release];
    
}
//- (void)pressWorldCupButton:(UIButton *)sender{
//        
//        NSMutableArray *array = [NSMutableArray array];
//        
//        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
//            
//            //                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
//            
//            NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSArray arrayWithObjects:@"1.5以下", @"1.5-2.0", @"2.0以上",nil],@"choose", nil];
//            
//            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英  超",@"德  甲",@"西  甲",@"意  甲",@"法  甲",nil] ,@"仅五大联赛", nil];
//            
//            if ([duoXuanArr count] == 0) {
//                //                    NSMutableDictionary * type1 = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
//                NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
//                
//                NSMutableArray * countarr = [NSMutableArray array];
//                for (int i = 0; i < [saishiArray count]; i++) {
//                    [countarr addObject:@"0"];
//                }
//                
//                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
//                
//                //                    [duoXuanArr addObject:type1];
//                [duoXuanArr addObject:type2];
//                [duoXuanArr addObject:type3];
//            }
//            NSLog(@"%d", [duoXuanArr count]);
//            
//            //                [array addObject:dic];
//            [array addObject:dic2];
//            [array addObject:dic3];
//        }else{
//            
//            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英  超",@"德  甲",@"西  甲",@"意  甲",@"法  甲",nil] ,@"仅五大联赛", nil];
//            
//            if ([duoXuanArr count] == 0) {
//                NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
//                NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
//                
//                NSMutableArray * countarr = [NSMutableArray array];
//                for (int i = 0; i < [saishiArray count]; i++) {
//                    [countarr addObject:@"0"];
//                }
//                
//                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
//                
//                [duoXuanArr addObject:type1];
//                [duoXuanArr addObject:type2];
//                [duoXuanArr addObject:type3];
//            }
//            NSLog(@"%d", [duoXuanArr count]);
//            
//            
//            [array addObject:dic3];
//            
//        }
//        
//        
//        
//        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
//        alert2.delegate = self;
//        alert2.tag = 30;
//        alert2.duoXuanBool = YES;
//        [alert2 show];
//        [alert2 release];
//        
//        
//    
//    
//}

- (void)setWorldCupBool:(BOOL)_worldCupBool{
    worldCupBool = _worldCupBool;
    
    if (worldCupBool) {
        
        if (!worldCupButton) {
            worldCupButton = [UIButton buttonWithType:UIButtonTypeCustom];
            worldCupButton.frame = CGRectMake(175, 0, 44, 44);
            worldCupButton.backgroundColor = [UIColor clearColor];
            [worldCupButton addTarget:self action:@selector(pressWorldCupButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView * sxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 20,20)];
            sxImageView.backgroundColor = [UIColor clearColor];
            sxImageView.image = UIImageGetImageFromName(@"caidansssx.png");
            [worldCupButton addSubview:sxImageView];
            [sxImageView release];
            
            [titleView addSubview:worldCupButton];
        }
        
        
    }
}

- (BOOL)worldCupBool{
    return worldCupBool;
}


#pragma mark -
#pragma mark Initialization

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
- (void)NewAroundViewShowFunc:(GC_BetData *)betdata indexPath:(NSIndexPath *)indexPath history:(BOOL)historyBool{//八方预测
    
    FootballForecastViewController * forecast = [[FootballForecastViewController alloc] init];
    forecast.lotteryType = jingcaitype;
    forecast.delegate =self;
    forecast.betData = betdata;
    forecast.gcIndexPath = indexPath;
    
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
            
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan){
                forecast.matchShowType = fjcShengpingfuType;
            }else if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
                forecast.matchShowType = fjcZongjinqiuType;
            }else if (matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
                forecast.matchShowType = fjcBanchangshengpingfuType;
            }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                forecast.matchShowType = fjcBifenType;
            }

        }
        
    }
    
    
    [self.navigationController pushViewController:forecast animated:YES];
    [forecast release];
    
}
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
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =  [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    
                    
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
                   
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =   [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    
                    
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
                    
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =  [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    
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
                    
                        oneFloat =  [oneData.but1 doubleValue] - [oneData.but3 doubleValue];
                        twoFloat =   [twoData.but1 doubleValue] - [twoData.but3 doubleValue];
                    
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
        buffer[2] = 0;
        [myTableView reloadData];
        [self performSelector:@selector(sleepfunck:) withObject:[NSString stringWithFormat:@"%d", 2] afterDelay:0.5];
    }else{
        buffer[bufCount] = 0;
        [myTableView reloadData];
        [self performSelector:@selector(sleepfunck:) withObject:[NSString stringWithFormat:@"%ld", (long)bufCount] afterDelay:0.5];
    }
    
}

- (void)sleepfunck:(NSString *)count{//关闭cell
    buffer[[count intValue]] = 1;
    [myTableView reloadData];
}

- (void)sortViewDidData:(UISortView *)sortView select:(NSInteger)index{//排序点击回调函数
    
    NSLog(@"select = %ld", (long)index);
    sortCount = index;
    
    
    if (index == 1) {
        
        [self sortFunc:@"1"];// 场号排序
        
    }else if (index == 2){
        
        [self sortFunc:@"2"];//最平均
        
    }else if (index == 3){
        
        [self sortFunc:@"3"];//主客差
    }
    [self openCloseCell];
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
    
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        
        keystring = @"20115ggHC";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        keystring = @"20115dgHC";
    }
    
    
    return keystring;
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
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
        
        keystring = @"20115ggDZ";
        
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        keystring = @"20115dgDZ";
    }
    
    
    return keystring;
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
//    
//    GC_BetData * tistr = [arrayce objectAtIndex:0];
//    
//    NSMutableArray * timesarrstr = [[NSMutableArray alloc] initWithCapacity:0];
//    NSString * timebijiao = [tistr.numzhou substringToIndex:2];
//    
//    [timesarrstr addObject:timebijiao];
//    //                int timecout = 0;
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
//            NSString * zhouji = [betstr.numzhou substringToIndex:2];
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
//    
//    //    for (int i = 0; i < [kebianzidian count]; i++) {
//    //        NSMutableArray * muarr = [kebianzidian objectAtIndex:i];
//    //        GC_BetData * betd = [muarr objectAtIndex:0];
//    //        NSArray * timarr = [betd.numtime componentsSeparatedByString:@"-"];
//    //        NSString * timstr = [timarr objectAtIndex:1];
//    //        NSString * rid = [timarr objectAtIndex:2];
//    //        NSString * nianstr = [timarr objectAtIndex:0];
//    //         for (int j = 0; j < [kebianzidian count]; j++) {
//    //            NSMutableArray * mur = [kebianzidian objectAtIndex:j];
//    //            GC_BetData * databet = [mur objectAtIndex:0];
//    //            NSArray * timarrma = [databet.numtime componentsSeparatedByString:@"-"];
//    //            NSString * nians = [timarrma objectAtIndex:0];
//    //            NSString * timstrma = [timarrma objectAtIndex:1];
//    //            if ([nianstr isEqualToString:nians]) {
//    //                if ([timstr isEqualToString:timstrma]) {
//    //                    NSLog(@"sss");
//    //                    NSString * ridat = [timarrma objectAtIndex:2];
//    //                    NSLog(@"a = %d, b = %d", [rid intValue], [ridat intValue]);
//    //                    if ([rid intValue] < [ridat intValue]) {
//    //                        [kebianzidian exchangeObjectAtIndex:i withObjectAtIndex:j];
//    //                    }
//    //                }else{
//    //                    if ([timstr intValue] < [timstrma intValue]) {
//    //                        [kebianzidian exchangeObjectAtIndex:i withObjectAtIndex:j];
//    //                    }
//    //
//    //                    NSLog(@"aaaa");
//    //
//    //
//    //                }
//    //
//    //            } else{
//    //                if ([nianstr intValue] < [nians intValue]) {
//    //                    [kebianzidian exchangeObjectAtIndex:i withObjectAtIndex:j];
//    //                }
//    //            }
//    //        }
//    //    }
//    
//}


- (id)initWithLotteryID:(NSInteger)lotteryId {
    self = [super init];
    if (self) {
        self.lotteryID = lotteryId;
    }
    return self;
}
- (void)doBack{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    addchuan = 0;
    countjishuqi = 0;
    tagbao = 2;
    timezhongjie = systimestr;
    biaoshi = 0;
     ContentOffDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    wangqiArray = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableArray * muta1 = [NSMutableArray array];
    NSMutableArray * muta2 = [NSMutableArray array];
    [wangqiArray setObject:muta1 forKey:@"0"];
    [wangqiArray setObject:muta2 forKey:@"1"];
    buffer[2] = 1;
    chuantype = [[NSMutableArray alloc] initWithCapacity:0];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"isune = %@", issString);
    issuestr = issString;
    matchenum = matchEnumShengPingFuGuoGuan;
    kebianzidian = [[NSMutableArray alloc] initWithCapacity:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    m_shedanArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    chuanfadic= [[NSMutableDictionary alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableDictionary *_danDic = [NSMutableDictionary dictionary];
    self.danDic = _danDic;
    allcellarr = [[NSMutableArray alloc] initWithCapacity:0];
    qihaoArray = [[NSMutableArray alloc] initWithCapacity:0];
    saishiArray = [[NSMutableArray alloc] initWithCapacity:0];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    wanArray = [[NSArray alloc] initWithObjects:@"胜平负", @"过关", @"单关",@"总进球数", @"过关", @"单关", @"半全场胜平负",  @"过关", @"单关",@"比分", @"过关", @"单关", nil];
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];
    
    //  self.title = @"pk赛投注";
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
   
    
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height -110+26) style:UITableViewStylePlain];
    //  myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
     [self requestHttpQingqiu];
    
    [self tabBarView];//下面长方块view 确定投注的view
    
//    NSString *systemTime = [self getSystemTodayTime];
//    NSString *remainingTimeLabelStr = [NSString stringWithFormat:@"当前时间：%@", systemTime];
//    NSLog(@"REMAINING = %@", remainingTimeLabelStr);
//    NSArray * timearray = [remainingTimeLabelStr componentsSeparatedByString:@" "];
//    NSString * datestr = [timearray objectAtIndex:0];
//    NSArray * dateatt = [datestr componentsSeparatedByString:@"间："];
//    
//    
//    NSString * timestring = [NSString stringWithFormat:@"%@ %@", [dateatt objectAtIndex:1], [timearray objectAtIndex:1]];
//    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    //
    
    

    
   
    
   titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    
    
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
       
    
    titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
        titleLabel.text = @"胜平负(过关)";

    
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleButton addSubview:titleLabel];
    
    
    [titleView addSubview:titleButton];
    
    //玩法等按钮菜单
//    UIButton *titleButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleButton2.frame = CGRectMake(210, 5, 50, 44);
//    titleButton2.backgroundColor = [UIColor clearColor];
//    [titleButton2 addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *butbg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 23, 23)];
//    butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
//    [titleButton2 addSubview:butbg2];
//    [butbg2 release];
//    
//    [titleView addSubview:titleButton2];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
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
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    [titleView addSubview:titleButton];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 10, 17, 17);
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
   
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.ong") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
   
//    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
//        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
//            upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
//            upimageview.backgroundColor = [UIColor clearColor];
//            upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
//            [self.mainView addSubview:upimageview];
//            [upimageview release];
//            
//            UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 26)];
//            saishila.backgroundColor = [UIColor clearColor];
//            saishila.font = [UIFont systemFontOfSize:13];
//            saishila.textColor = [UIColor whiteColor];
//            saishila.textAlignment = NSTextAlignmentCenter;
//            saishila.text = @"赛事";
//            [upimageview addSubview:saishila];
//            [saishila release];
//            
//            
//            UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 6, 1, 14)];
//            shuimage.backgroundColor = [UIColor whiteColor];
//            [upimageview addSubview:shuimage];
//            [shuimage release];
//            
//            UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 89, 26)];
//            shengla.backgroundColor = [UIColor clearColor];
//            shengla.font = [UIFont systemFontOfSize:13];
//            shengla.textColor = [UIColor whiteColor];
//            shengla.textAlignment = NSTextAlignmentCenter;
//            shengla.text = @"胜";
//            [upimageview addSubview:shengla];
//            [shengla release];
//            
//            UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149, 6, 1, 15)];
//            shuimage2.backgroundColor = [UIColor whiteColor];
//            [upimageview addSubview:shuimage2];
//            [shuimage2 release];
//            
//            UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 68, 26)];
//            pingla.backgroundColor = [UIColor clearColor];
//            pingla.font = [UIFont systemFontOfSize:13];
//            pingla.textColor = [UIColor whiteColor];
//            pingla.textAlignment = NSTextAlignmentCenter;
//            pingla.text = @"平(让球)";
//            [upimageview addSubview:pingla];
//            [pingla release];
//            
//            UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 6, 1, 14)];
//            shuimage3.backgroundColor = [UIColor whiteColor];
//            [upimageview addSubview:shuimage3];
//            [shuimage3 release];
//            
//            UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219, 0, 320-229, 26)];
//            fula.backgroundColor = [UIColor clearColor];
//            fula.font = [UIFont systemFontOfSize:13];
//            fula.textColor = [UIColor whiteColor];
//            fula.textAlignment = NSTextAlignmentCenter;
//            fula.text = @"负";
//            [upimageview addSubview:fula];
//            [fula release];
//    
//        
//        
//    }

    
    
    
    txtImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height-81, 320, 44)];
    txtImage.image = UIImageGetImageFromName(@"gc_titBg7.png");
    txtImage.backgroundColor = [UIColor clearColor];
    
    fbTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, self.mainView.bounds.size.height-76, 280, 30)];
    fbTextView.borderStyle = UITextBorderStyleRoundedRect;
    fbTextView.delegate = self;
    [fbTextView setReturnKeyType:UIReturnKeyDone];
    fbTextView.placeholder = @"写预测";
    [self.mainView addSubview:txtImage];
    [self.mainView addSubview:fbTextView];
    self.worldCupBool = YES;
}
//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
//    if (worldCupBool) {
//        [allimage addObject:@"menuhmdt.png"];
//        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
//        [allimage addObject:@"GC_sanjiShuoming.png"];
//
//    }else{
        [allimage addObject:@"caidansssx.png"];
//        [allimage addObject:@"menuhmdt.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
//    }
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
//    if (worldCupBool) {
//        [alltitle addObject:@"合买大厅"];
//        [alltitle addObject:@"玩法选择"];
//        [alltitle addObject:@"玩法说明"];
//    }else{
        [alltitle addObject:@"赛事筛选"];
//        [alltitle addObject:@"合买大厅"];
        [alltitle addObject:@"玩法选择"];
        [alltitle addObject:@"玩法说明"];
//    }
    
    
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
    NSLog(@"index = %ld", (long)index);
    
    NSInteger wcint = 0;
//    if (worldCupBool) {
//        wcint = 1;
//    }
    
    if (index == 0 - wcint) {
        
        
        NSMutableArray *array = [NSMutableArray array];
        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
            //            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
            
            NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSArray arrayWithObjects:@"1.5以下", @"1.5-2.0", @"2.0以上",nil],@"choose", nil];
            
            NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"串关",nil],@"choose", nil];
            
            if ([duoXuanArr count] == 0) {
                //                NSMutableDictionary * type1 = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
                NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"赔率",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil],@"choose", nil];
                NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"1", @"1",nil],@"choose", nil];
                
                NSMutableArray * countarr = [NSMutableArray array];
                for (int i = 0; i < [saishiArray count]; i++) {
                    [countarr addObject:@"1"];
                }
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                
                //                [duoXuanArr addObject:type1];
                [duoXuanArr addObject:type2];
                [duoXuanArr addObject:type3];
                if(matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan){
                    
                    [duoXuanArr addObject:type1];
                }
            }
            NSLog(@"%lu", (unsigned long)[duoXuanArr count]);
            
            //            [array addObject:dic];
            [array addObject:dic2];
            [array addObject:dic3];
            if(matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan){
                [array addObject:dic];
            }

        }else{
           
            NSDictionary *dic = nil;
            NSDictionary *dic3 = nil;
            if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
                dic = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"串关",nil],@"choose", nil];
                
                dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛", @"专家推荐",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            }else{
                dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saishiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",nil] ,@"仅五大联赛", nil];
            }
            
            if ([duoXuanArr count] == 0) {
                NSMutableArray * countarr = [NSMutableArray array];
                
                for (int i = 0; i < [saishiArray count]; i++) {
                    [countarr addObject:@"1"];
                }
                
                
                NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
                [duoXuanArr addObject:type3];
                
                if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan){
                    
                    NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"1", @"1",nil],@"choose", nil];
                    [duoXuanArr addObject:type1];
                    
                    
                }
                
            }
            [array addObject:dic3];
            if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan){
                [array addObject:dic];
                
            }

            
            
            
        }
        
        
        
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan ) {
            alert2.zhuanjiaBool = zhuanjiaBool;
        }
        if ( matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang) {
            alert2.doubleBool = YES;
        }
        alert2.delegate = self;
        alert2.tag = 30;
        alert2.duoXuanBool = YES;
        [alert2 show];
        [alert2 release];
        
        
    }else  if(index == 1- wcint){
        
        [self pressTitleButton:nil];
        
    }else if(index == 2- wcint){
        [self pressHelpButton:nil];
    }
//    else if(index == 1- wcint){
//       
//            
//            [self otherLottoryViewController:0 title:@"竞彩足球合买" lotteryType:106 lotteryId:@"201"];
//     
//
//    }
}


- (void)keyboardNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             //       [self.view setFrame:CGRectMake(0, -216, 320, 460)];
                             //  myTableView.frame = CGRectMake(11, -216, 290, 280);
                             
                             NSValue * kvalue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
                             CGSize keysize = [kvalue CGRectValue].size;
//                             myTableView.frame = CGRectMake(11, 27, 298, self.mainView.bounds.size.height -110);
                             txtImage.frame = CGRectMake(0, self.mainView.frame.size.height - keysize.height - 37, 320, 44);
                             fbTextView.frame = CGRectMake(20, self.mainView.frame.size.height - keysize.height - 32, 280, 30);
//                             myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height -keysize.height - 44 - 22);
                             
                             if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
                                 
//                                 upimageview.hidden = NO;
                                myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height -keysize.height - 44 - 22+26);
                             }else{
//                                 upimageview.hidden = YES;
                                 myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height -keysize.height - 44 - 22+26);
                                 
                             }

                             
                         } completion:NULL];
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             //            [self.view setFrame:CGRectMake(0, 0, 320, 460)];
//                             myTableView.frame  = CGRectMake(11, 27, 298, self.mainView.bounds.size.height -115);
                             txtImage.frame = CGRectMake(0, self.mainView.bounds.size.height-81, 320, 44);
                             fbTextView.frame = CGRectMake(20, self.mainView.bounds.size.height-76, 280, 30);
                             //    txtImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 337, 320, 44)];
//                              myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height -44 - 44 - 22);
                             
                             
                             if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
                                 
//                                 upimageview.hidden = NO;
                                 myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height -44 - 44 - 22+26);
//                                 myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height - 69);
                             }else{
//                                 upimageview.hidden = YES;
                                 myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 60-26);
                                 
                             }

                         } completion:NULL];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (void) keyboardWillDisapper
{
    //[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    //    CGRect frame = self.view.frame;
    //    frame.origin.y +=216;  //216
    //    frame.size. height -=216;
    // self.view.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.mainView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height -20);
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper) name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void) keyboardWillShow:(id)sender
{
	//[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    //   CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    
    //    CGRect frame = self.view.frame;
    //    frame.origin.y -=216;
    //    frame.size.height +=216;
    //  self.view.frame = frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.mainView.frame = CGRectMake(0, -216, 320, [UIScreen mainScreen].bounds.size.height -20);
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
    if (timearray.count < 2) {
        timearray = [NSArray arrayWithObjects:@"",@"", nil];
    }
    NSString * datestr = [timearray objectAtIndex:0];
    NSArray * dateatt = [datestr componentsSeparatedByString:@"间："];
    if (dateatt.count < 2) {
        dateatt = [NSArray arrayWithObjects:@"",@"", nil];
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

////下拉的函数
//- (void)handleSwipeFrom:(UIButton *)recognizer{
//
//    // if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
//
//    NSLog(@"swipe down");
//    bgviewdown = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    bgviewdown.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//
//    UIButton * downbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    downbutton.frame = CGRectMake(0, 0, 320, 480);
//    downbutton.backgroundColor = [UIColor clearColor];
//    [downbutton addTarget:self action:@selector(pressdownbutton:) forControlEvents:UIControlEventTouchUpInside];
//    [bgviewdown addSubview:downbutton];
//
//    bgimagedown = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
//    bgimagedown.image = UIImageGetImageFromName(@"gc_titBg_6.png");
//
//    UILabel * textl = [[UILabel alloc] initWithFrame:CGRectMake(106, 193, 106, 20)];
//    textl.textAlignment = NSTextAlignmentCenter;
//    textl.font = [UIFont systemFontOfSize:12];
//    textl.backgroundColor = [UIColor clearColor];
//    textl.text = @"确定";
//    [bgimagedown addSubview:textl];
//    [textl release];
//    NSString *systemTime = [self getSystemTodayTime];
//    NSString *remainingTimeLabelStr = [NSString stringWithFormat:@"当前时间：%@", systemTime];
//    NSLog(@"REMAINING = %@", remainingTimeLabelStr);
//    NSArray * timearray = [remainingTimeLabelStr componentsSeparatedByString:@" "];
//    NSString * datestr = [timearray objectAtIndex:0];
//    NSArray * dateatt = [datestr componentsSeparatedByString:@"间："];
//
//
//    NSString * timestring = [NSString stringWithFormat:@"%@ %@", [dateatt objectAtIndex:1], [timearray objectAtIndex:1]];
//
//    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(212, 193, 106, 20)];
//    timeLabel.text = timestring;
//    timeLabel.backgroundColor = [UIColor clearColor];
//    timeLabel.textAlignment = NSTextAlignmentCenter;
//    timeLabel.font = [UIFont systemFontOfSize:12];
//    [bgimagedown addSubview:timeLabel];
//    [timeLabel release];
//
//
//    [bgviewdown addSubview:bgimagedown];
//
//
//
//    imagevv = [[UIView alloc] initWithFrame:CGRectMake(20, 15, 280, 0)];
//    imagevv.backgroundColor = [UIColor clearColor];
//    imagevv.alpha = 1;
//
//    UIImageView * sibgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 180)];
//    sibgimage.image = UIImageGetImageFromName(@"gc_sibg.png");
//    sibgimage.backgroundColor = [UIColor clearColor];
//    [imagevv addSubview:sibgimage];
//    [sibgimage release];
//
//    [bgviewdown addSubview:imagevv];
//    bgviewdown.frame = CGRectMake(0, 0, 320, 0);
//    [self.view addSubview:bgviewdown];
//
//    imagevv.frame = CGRectMake(20, 15, 280, 180);
//    bgimagedown.frame = CGRectMake(0, 0, 320, 228);
//    bgviewdown.frame = CGRectMake(0, 0, 320, 480);
//
//
//    int tag = 1;
//    int index = 0;
//    int width = 68;
//    int height = 41;
//    for (int i = 0; i < 4; i ++) {
//        for (int j = 0; j < 4; j++) {
//            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//
//            UIImageView * butbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
//            butbgimage.backgroundColor = [UIColor clearColor];
//            butbgimage.tag = tag * 101;
//            [button addSubview:butbgimage];
//            [butbgimage release];
//
//            UIImageView * dotimg = [[UIImageView alloc] initWithFrame:CGRectMake(41, 0, 19, 19)];
//            dotimg.image = UIImageGetImageFromName(@"gc_dot6.png");
//            dotimg.tag = tag * 10;
//            dotimg.hidden = YES;
//            [button addSubview:dotimg];
//            [dotimg release];
//            button.frame = CGRectMake(4+j*width, 4+i*height, width, height);
//
//
//
//            if ([saishiArray count] >= tag) {
//
//                UILabel * buttontext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
//                buttontext.textAlignment = NSTextAlignmentCenter;
//                buttontext.backgroundColor = [UIColor clearColor];
//                //传值text
//                buttontext.text = [saishiArray objectAtIndex:index];
//                NSLog(@"button text = %@", buttontext.text);
//                buttontext.font = [UIFont systemFontOfSize:12];
//                [button addSubview:buttontext];
//                [buttontext release];
//                // [button setTitle:[saishiArray objectAtIndex:index] forState:UIControlStateNormal];
//            }else{
//                button.enabled = NO;
//            }
//            button.tag  = tag;
//            if (tag != 1) {
//                if (butt[tag] == 1) {
//                    butbgimage.image = UIImageGetImageFromName(@"gc_hover4.png");
//                    dotimg.hidden = NO;
//                }
//            }
//
//
//
//            index++;
//            tag++;
//            [button addTarget:self action:@selector(pressSaiShi:) forControlEvents:UIControlEventTouchUpInside];
//            [imagevv addSubview:button];
//        }
//    }
//
//
//
//
//    //  }
//}

//赛事
- (void)pressSaiShi:(UIButton *)sender{
    NSLog(@"button tag = %ld", (long)sender.tag);
    
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
////赛事
//- (void)pressSaiShi:(UIButton *)sender{
//    NSLog(@"button tag = %d", sender.tag);
//
//    if (butt[sender.tag] == 0) {
//        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
//        image.hidden = NO;
//
//
//        if (sender.tag == 1) {
//            for (int i = 1; i <= [saishiArray count]; i++) {
//                if (i == 1) {
//                    UIImageView * imagebg2 = (UIImageView *)[imagevv viewWithTag:i * 101];
//                    imagebg2.image = nil;
//                    UIImageView * image2 = (UIImageView *)[imagevv viewWithTag:i* 10];
//                    image2.hidden = YES;
//                    butt[i] = 1;
//                }else{
//
//                    UIImageView * imagebg = (UIImageView *)[imagevv viewWithTag:i * 101];
//                    imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
//                    UIImageView * image = (UIImageView *)[imagevv viewWithTag:i* 10];
//                    image.hidden = NO;
//                    butt[i] = 1;
//                }
//
//
//
//
//
//
//                if (i == sender.tag) {
//                    continue;
//                }
//                //                UIButton * vi = (UIButton *)[imagevv viewWithTag:i];
//                //                vi.enabled = NO;
//            }
//
//
//        }else{
//
//
//
//            butt[sender.tag] = 1;
//            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 101];
//            imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
//
//
//        }
//
//        //        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
//        //        imagebg.image = UIImageGetImageFromName(@"gc_hover4.png");
//        //
//
//
//
//
//    }else{
//
//
//        if (sender.tag == 1) {
//            for (int i = 1; i <= [saishiArray count]; i++) {
//                UIImageView * imagebg = (UIImageView *)[imagevv viewWithTag:i * 101];
//                imagebg.image = nil;
//                UIImageView * image = (UIImageView *)[imagevv viewWithTag:i* 10];
//                image.hidden = YES;
//                butt[i] = 0;
//                //                if (i == sender.tag) {
//                //                    continue;
//                //                }
//                UIButton * vi = (UIButton *)[imagevv viewWithTag:i];
//                vi.enabled = YES;
//            }
//        }else{
//
//            for (int i = 1; i < 17; i++) {
//
//                UIButton * vi = (UIButton *)[imgev viewWithTag:i];
//                vi.enabled = YES;
//            }
//            UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
//            image.hidden = YES;
//            //  sender.backgroundColor = [UIColor whiteColor];
//            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 101];
//            imagebg.image = nil;
//            butt[sender.tag] = 0;
//            butt[1] = 0;
//
//        }
//
//
//    }
//
//}
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
    
    
    
    //    //if ([arr count] != 0) {
    //        [cellarray removeAllObjects];
    //        [kebianzidian removeAllObjects];
    //   // }
    //    NSLog(@"dd = %d", [arr count]);
    //
    //    if([arr count] == 0){
    //        for (GC_BetData * d in allcellarr) {
    //            [cellarray addObject:d];
    //
    //        }
    //        //  [self shaixuanzidian:allcellarr];
    //        textlabel.text = @"赛事筛选(全部)";
    //    }
    //
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
                if ([da.event isEqualToString:st]) {
                    [cellarray addObject:da];
                }
            }
            
            
            //            [self shaixuansaishi:allcellarr saishi:st];
            
        }
        
    }
    
    if ([arr count] > 0) {
        
        
        [self shaixuanzidian:cellarray];
    }else{
        [self shaixuanzidian:allcellarr];
        textlabel.text = @"赛事筛选(全部)";
    }
    
    
    
    //    [shedanArr removeAllObjects];
    //    for (int u = 0; u < [cellarray count]; u++) {
    //        [shedanArr addObject:[NSNumber numberWithInteger:0]];
    //    }
    //    buffer[0] = 1;
    for (int i = 0; i < 10; i++) {
        buffer[i] = 1;
    }
    
  //   [self pressQingButton:nil];
    [myTableView reloadData];
    
    //  bgimagedown.frame = CGRectMake(0, 0, 320, 0);
    [bgviewdown removeFromSuperview];
    [bgviewdown release];
    [arr removeAllObjects];
    [arr release];
}

//- (void)pressdownbutton:(UIButton *)sender{
//
//    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:0];
//    int saishicount = 0;
//    for (int i = 1; i < 17; i++) {
//        if (butt[i] == 1) {
//            NSLog(@"i = %d", i);
//            NSString * name = [saishiArray objectAtIndex:i-1];
//            NSLog(@"name = %@", name);
//            [arr addObject:name];
//            //  butt[i] = 0;///////////////////////
//            saishicount++;
//        }
//    }
//
//
//    if (saishicount == 0) {
//
//    }else{
//        textlabel.text = [NSString stringWithFormat:@"赛事筛选(%d)", saishicount];
//    }
//
//    //if ([arr count] != 0) {
//    [cellarray removeAllObjects];
//    [kebianzidian removeAllObjects];
//    // }
//
//
//
//    //    //if ([arr count] != 0) {
//    //        [cellarray removeAllObjects];
//    //        [kebianzidian removeAllObjects];
//    //   // }
//    //    NSLog(@"dd = %d", [arr count]);
//    //
//    //    if([arr count] == 0){
//    //        for (GC_BetData * d in allcellarr) {
//    //            [cellarray addObject:d];
//    //
//    //        }
//    //        //  [self shaixuanzidian:allcellarr];
//    //        textlabel.text = @"赛事筛选(全部)";
//    //    }
//    //
//    for (NSString * st in arr) {
//
//        if ([arr count] == 0 || [st isEqualToString:@"全部"]) {
//            for (GC_BetData * d in allcellarr) {
//                [cellarray addObject:d];
//
//            }
//            //  [self shaixuanzidian:allcellarr];
//            textlabel.text = @"赛事筛选(全部)";
//
//            break;
//        }else{
//
//
//
//            for (GC_BetData * da in allcellarr) {
//                if ([da.event isEqualToString:st]) {
//                    [cellarray addObject:da];
//                }
//            }
//
//
//            //            [self shaixuansaishi:allcellarr saishi:st];
//
//        }
//
//    }
//
//    if ([arr count] > 0) {
//
//
//        [self shaixuanzidian:cellarray];
//    }else{
//        [self shaixuanzidian:allcellarr];
//        textlabel.text = @"赛事筛选(全部)";
//    }
//
//
//
//    //    [shedanArr removeAllObjects];
//    //    for (int u = 0; u < [cellarray count]; u++) {
//    //        [shedanArr addObject:[NSNumber numberWithInteger:0]];
//    //    }
//    //    buffer[0] = 1;
//    for (int i = 0; i < 10; i++) {
//        buffer[i] = 1;
//    }
//
//
//    [myTableView reloadData];
//
//    //  bgimagedown.frame = CGRectMake(0, 0, 320, 0);
//    [bgviewdown removeFromSuperview];
//    [bgviewdown release];
//    [arr removeAllObjects];
//    [arr release];
//}
//
//- (void)pressdownbutton:(UIButton *)sender{
//
//    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:0];
//    int saishicount = 0;
//    for (int i = 1; i < 17; i++) {
//        if (butt[i] == 1) {
//            NSLog(@"i = %d", i);
//            NSString * name = [saishiArray objectAtIndex:i-1];
//            NSLog(@"name = %@", name);
//            [arr addObject:name];
//            //  butt[i] = 0;///////////////////////
//            saishicount++;
//        }
//    }
//
//
//    if (saishicount == 0) {
//
//    }else{
//        textlabel.text = [NSString stringWithFormat:@"赛事筛选(%d)", saishicount];
//    }
//
//    if ([arr count] != 0) {
//        [cellarray removeAllObjects];
//        [kebianzidian removeAllObjects];
//    }
//
//    for (NSString * st in arr) {
//
//        if ([arr count] == 0 || [st isEqualToString:@"全部"]) {
//            for (GC_BetData * d in allcellarr) {
//                [cellarray addObject:d];
//
//            }
//            //  [self shaixuanzidian:allcellarr];
//            textlabel.text = @"赛事筛选(全部)";
//
//            break;
//        }else{
//
//
//
//            for (GC_BetData * da in allcellarr) {
//                if ([da.event isEqualToString:st]) {
//                    [cellarray addObject:da];
//                }
//            }
//
//
//            //            [self shaixuansaishi:allcellarr saishi:st];
//
//        }
//
//    }
//
//    if ([arr count] > 0) {
//        [self shaixuanzidian:cellarray];
//    }
//
//
//
//    //    [shedanArr removeAllObjects];
//    //    for (int u = 0; u < [cellarray count]; u++) {
//    //        [shedanArr addObject:[NSNumber numberWithInteger:0]];
//    //    }
//    for (int i = 0; i < 10; i++) {
//        buffer[i] = 1;
//    }
//
//
//
//    [myTableView reloadData];
//
//    bgimagedown.frame = CGRectMake(0, 0, 320, 0);
//    [bgviewdown removeFromSuperview];
//
//    [arr removeAllObjects];
//    [arr release];
//}

//玩法选择
- (void)pressTitleButton:(UIButton *)sender{
    
    
    NSMutableArray *array = [NSMutableArray array];
    
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"玩法",@"title",[NSArray arrayWithObjects:@"胜平负", @"总进球数",@"半全场胜平负",@"比分",nil],@"choose", nil];
        
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSArray arrayWithObjects:@"单关", @"过关",nil],@"choose", nil];
        
        if ([kongzhiType count] == 0) {
            NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0",nil],@"choose", nil];
            NSMutableDictionary *type2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"过关",@"title",[NSMutableArray arrayWithObjects:@"0", @"1",nil],@"choose", nil];
            
            [kongzhiType addObject:type1];
            [kongzhiType addObject:type2];
        }
        NSLog(@"%lu", (unsigned long)[kongzhiType count]);
        
        [array addObject:dic];
        [array addObject:dic2];
        
 
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    alert2.jingcaiBool = jingcaipinglun;
    
    
    if (  matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang) {
        alert2.doubleBool = YES;
    }
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
    
    
    
    //    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    //
    //    bgview = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    //    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //
    //
    //    UIButton * bgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    bgbutton.frame = appDelegate.window.bounds;
    //    bgbutton.backgroundColor = [UIColor clearColor];
    //    // bgbutton.alpha = 0.5;
    //    //bgbutton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //    [bgbutton addTarget:self action:@selector(pressBgButton:) forControlEvents:UIControlEventTouchUpInside];
    //    //  [self.view addSubview:bgbutton];
    //    [bgview addSubview:bgbutton];
    //
    //
    //    imgev = [[UIView alloc] initWithFrame:CGRectMake(33, 175, 256, 129)];
    //    imgev.backgroundColor = [UIColor clearColor];
    //    imgev.alpha = 1;
    //
    //    UIImageView * imagevie = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 256, 129)];
    //    imagevie.backgroundColor = [UIColor clearColor];
    //    imagevie.image = UIImageGetImageFromName(@"gc_jiugongge.png");
    //    [imgev addSubview:imagevie];
    //    [imagevie  release];
    //
    //
    //    //   imgev.backgroundColor = [UIColor whiteColor];
    //    int tag = 1;
    //    int index = 0;
    //    int width = 83;
    //    int height = 30;
    //    for (int i = 0; i < 4; i ++) {
    //        for (int j = 0; j < 3; j++) {
    //            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //            button.backgroundColor = [UIColor clearColor];
    //            UIImageView * dotimg = [[UIImageView alloc] initWithFrame:CGRectMake(61, 0, 19, 19)];
    //            dotimg.image = UIImageGetImageFromName(@"gc_dot6.png");
    //            dotimg.tag = tag * 10;
    //            dotimg.hidden = YES;
    //
    //
    //            // button.enabled = NO;
    //
    //            UIImageView * butbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    //            butbgimage.backgroundColor = [UIColor clearColor];
    //            butbgimage.tag = tag * 100;
    //
    //            [button addSubview:butbgimage];
    //
    //
    //            button.frame = CGRectMake(4+j*width, 4+i*height, width, height);
    //            if ([wanArray count] >= tag) {
    //                UILabel * buttontext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    //                buttontext.textAlignment = NSTextAlignmentCenter;
    //                buttontext.backgroundColor = [UIColor clearColor];
    //                buttontext.font = [UIFont systemFontOfSize:12];
    //                buttontext.text = [wanArray objectAtIndex:index];//传数据
    //
    //                [button addSubview:buttontext];
    //                [buttontext release];
    //                //[button setTitle:[issueArray objectAtIndex:index] forState:UIControlStateNormal];
    //            }
    //
    //            if (tag > 1) {
    //                butbgimage.image = UIImageGetImageFromName(@"gc_hover_0.png");
    //            }
    //            //if (tag == 10 || tag == 11 || tag == 2 || tag == 4|| tag == 5 || tag == 7 || tag == 8) {
    //                butbgimage.image = nil;
    //            //}
    //            if (tag == tagbao) {
    //                dotimg.hidden = NO;
    //                butbgimage.image = UIImageGetImageFromName(@"gc_hover.png");
    //            }
    //
    //
    //            [butbgimage release];
    //            button.tag  = tag;
    //            index++;
    //            tag++;
    //            [button addSubview:dotimg];
    //            [dotimg release];
    //            [button addTarget:self action:@selector(pressjiugongge:) forControlEvents:UIControlEventTouchUpInside];
    //            [imgev addSubview:button];
    //        }
    //    }
    //    
    //    [bgview addSubview:imgev];
    //    
    //    
    //    [appDelegate.window addSubview:bgview];
    //    
    //    UIButton * vi = (UIButton *)[imgev viewWithTag:1];
    //    vi.enabled = YES;
    //    UIButton * vi2 = (UIButton *)[imgev viewWithTag:2];
    //    vi2.enabled = YES;
}
- (void)xuanzhonganniu:(UIButton *)sender{
    if (but[sender.tag] == 0) {
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
    }else{
        [bgview removeFromSuperview];
    }
    
    
    
}

//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    
    NSLog(@"button tag = %ld", (long)sender.tag);
    
    
    
    if (sender.tag == 2) {
        
        matchenum = matchEnumShengPingFuGuoGuan;
        
        [self xuanzhonganniu:sender];
        titleLabel.text = @"胜平负(过关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        UIFont * font = titleLabel.font;
        CGSize  size = CGSizeMake(180, 34);
        CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 10, 17, 17);
        
        
        
        
        
    }
    //    else if (sender.tag != 1&&sender.tag !=2&&sender.tag !=4&&sender.tag !=7&&sender.tag !=10 && sender.tag != 11 && sender.tag != 5 && sender.tag != 8)  {
    //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    //        [cai showMessage:@"稍后上线,敬请关注"];
    //    }
    else if(sender.tag == 11){
        
        matchenum = matchEnumBiFenGuoguan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"比分(过关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        
        
        
        
        
    }else if(sender.tag == 5){
        matchenum = matchenumZongJinQiuShu;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"总进球数(过关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        
        
        //
        
    }else if(sender.tag == 8){
        matchenum = matchenumBanQuanChang;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"半全场胜平负(过关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        //            }
        
        
        
        
        
    }else if(sender.tag == 3){
        matchenum = matchEnumShengPingFuDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"胜平负(单关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        
    }else if(sender.tag == 6){
        matchenum = matchEnumZongJinQiuShuDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"总进球数(单关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        
        
    }else if(sender.tag == 9){
        
        matchenum = matchEnumBanQuanChangDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"半全场胜平负(单关)";
//        titleLabel.font = [UIFont systemFontOfSize:17];
        
    }else if(sender.tag == 12){
        matchenum = matchEnumBiFenDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"比分(单关)";
//        titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else if(sender.tag == 15){
        matchenum = matchEnumRangQiuShengPingFuDanGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"让球胜平负(单关)";
        //        titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else if(sender.tag == 14){
        matchenum = matchEnumRangQiuShengPingFuGuoGuan;
        [self xuanzhonganniu:sender];
        titleLabel.text = @"让球胜平负(过关)";
        //        titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 10, 17, 17);
    buffer[2] = 1;
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum  == matchEnumShengPingFuDanGuan) {
        
//        upimageview.hidden = NO;
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69+26);
    }else{
//        upimageview.hidden = YES;
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 69-12);
        
    }

    //    }else{
    //        for (int i = 1; i < 13; i++) {
    //            if (i == 1 || i == 2) {
    //                UIButton * vi = (UIButton *)[imgev viewWithTag:i];
    //                vi.enabled = YES;
    //
    //            }else{
    //                UIButton * vi = (UIButton *)[imgev viewWithTag:i];
    //                vi.enabled = NO;
    //            }
    //        }
    //        if (sender.tag < 3) {
    //
    //
    //            UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
    //            image.hidden = YES;
    //            UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
    //            imagebg.image = nil;
    //            //  sender.backgroundColor = [UIColor whiteColor];
    //            but[sender.tag] = 0;
    //        }
    //    }
    
}
//选择玩法 和背景点击消失
- (void)pressBgButton:(UIButton *)sender{
    
    int n = 0;
    for (int i = 1; i < 13; i++) {
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
//    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 40, 13)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:12];
    oneLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    //   oneLabel.text = @"14";
    
    [zhubg addSubview:oneLabel];
    
    //放图片 图片上放label 显示投多少注
//    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 27, 25, 10)];
//    imageView2.image = UIImageGetImageFromName(@"b_03.png");
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 18, 40, 13)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:12];
    twoLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
    twoLabel.hidden = YES;
    //  twoLabel.text = @"512";
    
    [zhubg addSubview:twoLabel];
    
    //场字
     fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 20, 13)];
    fieldLable.text = @"场";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:12];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];;
    //注字
    pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, 20, 13)];
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

    
//    UIImageView * chuanimage = [[UIImageView alloc] initWithFrame:chuanButton1.bounds];
//    chuanimage.backgroundColor = [UIColor clearColor];
//    chuanimage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [chuanButton1 addSubview:chuanimage];
//    [chuanimage release];
    
    labelch = [[UILabel alloc] initWithFrame:chuanButton1.bounds];
    labelch.text = @"串法";
    labelch.textAlignment = NSTextAlignmentCenter;
    labelch.backgroundColor = [UIColor clearColor];
    labelch.font = [UIFont boldSystemFontOfSize:15];
    labelch.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];;
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
    [zhubg addSubview:fieldLable];
    [zhubg addSubview:pourLable];
    [tabView addSubview:zhubg];
    [zhubg release];
//    [tabView addSubview:imageView1];
//    [tabView addSubview:imageView2];
    [tabView addSubview:castButton];
//    [tabView addSubview:helpButton];
    [tabView addSubview:chuanButton1];
    
    [tabView addSubview:qingbutton];
    
    [self.mainView addSubview:tabView];
    
    
    //  [pitchLabel release];
    //  [castLabel release];
    [fieldLable release];
    [pourLable release];
//    [imageView1 release];
//    [imageView2 release];
    [tabBack release];
}

- (void)pressQingButton:(UIButton *)sender{
    
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan){
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

        
    }else if(matchenum == matchEnumBiFenGuoguan||matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan){
        for (int i = 0; i < [kebianzidian count]; i++) {
            NSMutableArray * cear = [kebianzidian objectAtIndex:i];
            for (int j = 0; j < [cear count]; j++) {
                GC_BetData  * da = [cear objectAtIndex:j];
                for (int m = 0; m < [da.bufshuarr count]; m++) {
                    //NSString * stns = [da.bufshuarr objectAtIndex:m];
                    NSString *stns = @"0";
                    [da.bufshuarr replaceObjectAtIndex:m withObject:stns];
                }
                da.cellstring = @"请选择投注选项";
                da.dandan = NO;
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
//    oneLabel.text = @"0";
//    twoLabel.text = @"0";
    one = 0;
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    fieldLable.text = @"场";
    pourLable.hidden = YES;
    twoLabel.hidden = YES;
    labelch.text = @"串法";
    addchuan = 0;
    [zhushuDic removeAllObjects];
    for (int i = 0; i < 160; i++) {
        buf[i] = 0;
    }
    chuanButton1.enabled = NO;
    castButton.enabled = NO;
    qingbutton.enabled = NO;
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960_1.png") forState:UIControlStateNormal];
    chuanButton1.alpha = 0.5;
    castButton.alpha = 0.5;
}
//串的ui
- (void)pressChuanButton{
    [cellarray removeAllObjects];
    //    NSArray * keys = [kebianzidian allKeys];
//    for (int i = 0; i < [kebianzidian count]; i++) {
//        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
//        for (int j = 0; j < [mutaarr count]; j++) {
//            [cellarray addObject:[mutaarr objectAtIndex:j]];
//        }
//    }
     [cellarray addObjectsFromArray:allcellarr];
    
//    NSMutableArray * chuancopy = (NSMutableArray *)[zhushuDic allKeys];
//    NSLog(@"chuancopy %d",[chuancopy count]);
    //////////////////////////////////
    //   [zhushuDic removeAllObjects];
    //    for (int i = 0; i < 160; i++) {
    //        buf[i] = 0;
    //    }
    shedan  = NO;
    NSInteger dancout = 0;
    
    NSInteger changci = 0;//计算选多少场
    
    NSInteger danshiCount = 0;//计数 多少个单关
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan) {
        for (GC_BetData * da in cellarray) {
            
            if (da.selection1 || da.selection2 || da.selection3) {
                changci++;
                if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                    danshiCount +=1;
                }
            }
            
            
            if (da.dandan) {
                //     shedan = YES;
                dancout++;
                //   break;
            }
            //        else{
            //            shedan = NO;
            //        }
        }
        
    }else if (matchenum == matchEnumBiFenGuoguan||matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu){
        for (GC_BetData * da in cellarray) {
            for (int i = 0; i < [da.bufshuarr count]; i++) {
                
                if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    changci++;
                    if (matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang||matchenum == matchEnumBiFenGuoguan) {
                        danshiCount += 1;
                        
                    }
                    break;
                }
                
                
                
                
            }
        }
        
        for (GC_BetData * da in cellarray) {
            for (int i = 0; i < [da.bufshuarr count]; i++) {
                if (da.dandan) {
                    //     shedan = YES;
                    dancout++;
                    break;
                }
                
                
                
                
                
            }
        }
        
        
        
    }
    
    NSLog(@"dancout = %ld, changci = %ld", (long)dancout, (long)changci);
    
    if (dancout != 0) {//判断是否设胆
        shedan = YES;
    }
    
    
    NSLog(@"dancout = %d", one);
    
    
    NSMutableArray * array = nil;
    
    //设胆 和未设胆 计算出来的串法
    if (matchenum == matchEnumBiFenGuoguan) {
        if (shedan) {
            array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:2 GameCount:one];
            
        }else{
            
            
            if (matchenum == matchEnumBiFenGuoguan ) {
                if (changci > 1) {
                    array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:2 GameCount:one];
                }
                if (changci == danshiCount) {
                    [array insertObject:@"单关" atIndex:0];
                }
            }else{
                array = (NSMutableArray *)[GC_PassTypeUtils lotteryId:2 GameCount:one];
            }
            
        }
        
    }else if (matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan){
        if (shedan) {
            array =  (NSMutableArray *)[GC_PassTypeUtils danLotteryId:lotteryID GameCount:one];
            
        }else{
            if (matchenum == matchEnumShengPingFuGuoGuan) {
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
                [array removeObjectAtIndex:0];
                
            }
        }
        
        
        //选几场 如果设有胆  那么 几串一就不能用 删掉
        for (int i = 0; i < [array count]; i++) {
            NSString * st = [array objectAtIndex:i];
            if (![st isEqualToString:@"2串1"]) {
                if ([st isEqualToString:[NSString stringWithFormat:@"%ld串1", (long)changci]]) {
                    [array removeObjectAtIndex:i];
                }
            }
            
        }
        
    }
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
                if ([[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d串1", one]]) {
                    [chuantype replaceObjectAtIndex:i withObject:@"1"];
                }
            }
        }
    }

    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"过关方式选择" withChuanNameArray:array andChuanArray:chuantype];
    alert2.delegate = self;
    alert2.duoXuanBool = YES;
    if ( matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang) {
        alert2.doubleBool = YES;
    }
    alert2.tag = 10;
    [alert2 show];
    self.mainView.userInteractionEnabled = NO;
    [alert2 release];



    
    
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
    
    NSLog(@"addchuan = %ld", (long)addchuan);
    if (buf[sender.tag] == 0) {
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_chuanhover.png");
        //   sender.backgroundColor  = [UIColor blueColor];
        
        addchuan +=1;
        NSLog(@"2 add chuan = %ld", (long)addchuan);
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
            //            UIButton * vi = (UIButton *)[cimgev viewWithTag:i];
            //            vi.enabled = NO;
        }
        
    }else{
        
        for (int i = 1; i < 160; i++) {
            
            //            UIButton * vi = (UIButton *)[cimgev viewWithTag:i];
            //            vi.enabled = YES;
        }
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = YES;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_jgg.png");
        //  sender.backgroundColor = [UIColor whiteColor];
        buf[sender.tag] = 0;
        addchuan -= 1;
    }
    
    UILabel * vi = sender.titleLabel;
    //   NSLog(@"vi = %@", vi.text);
    //    NSString * sss= @"1";
    //    NSNumber * ddd = [NSNumber numberWithInt:0];
    //    [selectedItemsDic setObject:sss forKey:ddd];
    
    
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
    if (matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan) {
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
        
        
        selecout2 = 0;
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
        
    }else if(matchenum == matchEnumBiFenGuoguan|| matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu){
        
        
        for (int m = 0; m < [cellarray  count]; m++) {
            
            selecount = 0;
            
            
            for (GC_BetData * pkb in cellarray) {
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
        
        
        
        
        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan) {
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
            
        }else if(matchenum == matchEnumBiFenGuoguan|| matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu){
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
        
        NSLog(@"longnum = %d", [longNum intValue]);
        
        
        
        //       [totalZhuShuWithDanDic setObject:longNum forKey:[button text]];
        // twoLabel.text= [NSString stringWithFormat:@"%d", [longNum intValue]];
        
        if (buf[sender.tag] == 1) {
            [zhushuDic setObject:longNum forKey:vi.text];
        }else{
            if ([zhushuDic objectForKey:vi.text]) {
                [zhushuDic removeObjectForKey:vi.text];
            }
            
        }
        [longNum release];
        //        NSNumber * numq = [zhushuDic objectForKey:vi.text];
        //        NSLog(@"%lld", [numq longLongValue]);
        
    }else{// 未设胆情况
        
        GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
        NSLog(@"button text = %@", [vi text]);
        
        NSArray *keys = [selectedItemsDic allKeys];
        
        for (NSString* stri in keys) {
            //   NSNumber * dd = [selectedItemsDic objectForKey:keys];
            NSLog(@"stri = %@", stri);
        }
        
        NSLog(@"dict = %@", diction);
        NSLog(@"cell count = %lu", (unsigned long)[cellarray    count]);
        
        [jcalgorithm passData:diction gameCount:[cellarray count] chuan:[vi text]];
        long long  total =[jcalgorithm  totalZhuShuNum];
        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
        //  twoLabel.text= [NSString stringWithFormat:@"%d", [longNum longLongValue]];
        
        if (buf[sender.tag] == 1) {
            if ([vi.text isEqualToString:@"单关"]) {
                
                long long jishu = 0;
                
                if (matchenum == matchEnumShengPingFuGuoGuan) {
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
                }else if ( matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan){
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
        }else{
            if ([zhushuDic objectForKey:vi.text]) {
                [zhushuDic removeObjectForKey:vi.text];
            }
            
        }
        
        //     [totalZhuShuDic setObject:longNum forKey:[button text]];
        [longNum release];
        
    }
    
    NSArray * ar = [zhushuDic allKeys];
    
//    for (NSString * st in ar) {
//        NSLog(@"st = %@", st);
//    }
    
    NSInteger n=0;
    for (int i = 0; i < [ar count]; i++) {
        NSLog(@"ar = %@",[ar objectAtIndex:i]);
        if ([ar objectAtIndex:i] != nil || [[ar objectAtIndex:i] isEqualToString:@""]) {
            NSNumber * numq = [zhushuDic objectForKey:[ar objectAtIndex:i]];
            
            n = n + [numq intValue];
        }
        
        
    }
    oneLabel.text = [NSString stringWithFormat:@"%d", (int)n];
    twoLabel.text = [NSString stringWithFormat:@"%d",(int) n * 2];
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
        twoLabel.hidden = YES;
        chuanButton1.enabled = NO;
    }
    
    //    if ([arrr count] > 5) {
    //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    //        [cai showMessage:@"组合串关不能超过5个"];
    //    }
    
}





- (void)pressChuanBgButton:(UIButton *)sender{
    [cbgview removeFromSuperview];
}

-(NSString*)chosedGameSet{
    
    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan) {
        NSMutableArray * bifenarr;
        if (matchenum == matchEnumBiFenGuoguan||matchenum == matchEnumBiFenDanGuan) {
            bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
        }else if(matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
            bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
            
        }else if(matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
            bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
            
        }
        
        
        NSString * pinchuan = @"";
        for (GC_BetData * be in cellarray) {
            BOOL zhongjiebool = NO;
            NSString * strpin = @"";
            for (int i = 0; i < [be.bufshuarr count]; i++) {
                if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                    zhongjiebool = YES;
                    break;
                }
            }
            
            
            if (zhongjiebool) {
                
                strpin = [NSString stringWithFormat:@"%@:%@:[", be.changhao, be.numzhou];
                
                for (int i = 0; i < [be.bufshuarr count]; i++) {
                    if ([[be.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                        strpin = [NSString stringWithFormat:@"%@%@,", strpin, [bifenarr objectAtIndex:i]];
                    }
                }
                
                if ([strpin length] > 0) {
                    strpin = [strpin substringToIndex:[strpin length]-1];
                }
                strpin = [NSString stringWithFormat:@"%@]/", strpin];
                NSLog(@"strping = %@", strpin);
                
                
                
            }
            pinchuan = [NSString stringWithFormat:@"%@%@", pinchuan, strpin];
            
            
        }
        pinchuan = [pinchuan substringToIndex:[pinchuan length] - 1];
        NSLog(@"strpin = %@", pinchuan);
        return pinchuan;
        
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan){
        if (cellarray&&cellarray.count) {
            NSMutableString * str = [[[NSMutableString alloc] init] autorelease] ;
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                if (da.selection1 || da.selection2 || da.selection3) {
                    [str appendString:da.changhao];
                    [str appendString:@":"];
                    [str appendString:da.numzhou];
                    [str appendString:@":"];
                    [str appendString:@"["];
                    if (da.selection1) {
                        [str appendString:@"胜"];
                    }
                    if (da.selection2) {
                        [str appendString:@"平"];
                    }
                    if (da.selection3) {
                        [str appendString:@"负"];
                    }
                    [str appendString:@"]"];
                    
                    [str appendString:@"/"];
                    
                }
            }
            [str setString:[str substringToIndex:[str length] - 1]];
            NSLog(@"str = %@", str);
            return str;
        }
        
        
    }
    
    
    
    
    return nil;
    
}
-(int)maxGameID{
    if (cellarray&&cellarray.count) {
        int max = 0;
        for (int i= 0; i<cellarray.count; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            if ([da.changhao intValue] > max) {
                max = [da.changhao intValue];
            }
        }
        return max;
    }
    return 0;
    
}


-(int)minGameID{
    if (cellarray&&cellarray.count) {
        int min = 99999999;
        for (int i= 0; i<cellarray.count; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            
            if ([da.changhao intValue] < min) {
                min = [da.changhao intValue];
            }
        }
        return min;
    }
    return 0;
}

- (NSString*)passTypeSetAndchosedGameSet
{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    NSInteger zong = 0;
    for (GC_BetData * bee in cellarray) {
        if (bee.selection1 || bee.selection2 || bee.selection3) {
            zong++;
        }
    }
    int zongchang = 0;
    for (GC_BetData * bie in cellarray) {
        if (bie.selection1) {
            zongchang++;
        }
        if (bie.selection2) {
            zongchang++;
        }
        if (bie.selection3) {
            zongchang++;
        }
    }
    NSLog(@"%d", zongchang);
    
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    NSInteger lotterType = TYPE_JINGCAI_ZQ_2;
    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan) {
        lotterType = TYPE_JINGCAI_ZQ_2;
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan){
        lotterType = TYPE_JINGCAI_ZQ_1;
    }else if(matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
        lotterType = TYPE_JINGCAI_ZQ_4;
    }else if(matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
        lotterType = TYPE_JINGCAI_ZQ_3;
    }
    
    
    NSArray * arr = [zhushuDic allKeys];
    NSString *passTypeSet = @"";
    for (int i = 0; i < [arr count]; i++) {
        NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        if (i!=arr.count-1){
            NSString * com = [arr objectAtIndex:i];
            NSArray * nsar = [com componentsSeparatedByString:@"串"];
            if (nsar.count < 2) {
                nsar = [NSArray arrayWithObjects:@"",@"", nil];
            }
            com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
            passTypeSet = [NSString stringWithFormat:@"%@%@,",passTypeSet, com];
            
        }else{
            
            
            NSString * com = [arr objectAtIndex:i];
            if ([com isEqualToString:@"单关"]) {
                passTypeSet = @"单关^";
            }else{
                NSArray * nsar = [com componentsSeparatedByString:@"串"];
                if (nsar.count < 2) {
                    nsar = [NSArray arrayWithObjects:@"",@"", nil];
                }
                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                passTypeSet = [NSString stringWithFormat:@"%@%@^",passTypeSet, com];
            }
            
            
        }
    }
    
    
    
    
    
    NSString *items = [self chosedGameSet];
    int min = [self minGameID];
    NSLog(@"min = %d", min);
    
    int max = [self maxGameID];
    int beishu = 1;
    
    [str appendFormat:@"%d", (int)lotterType];
    [str appendString:@"^"];
    [str appendFormat:@"%d",0];
    [str appendString:@"^"];
    [str appendString:passTypeSet];
    [str appendString:items];
    [str appendString:@"^"];
    [str appendString:[NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2 ]];
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)beishu];
    [str appendString:@"^"];
    NSString * app = [NSString stringWithFormat: @"%d", 1* [twoLabel.text intValue]/2 *2];
    NSLog(@"app = %@", app);
    [str appendString:app];
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)zongchang];
    [str appendFormat:@"^"];
    [str appendFormat:@"%d",(int)zong];
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)min];
    [str appendString:@"^"];
    [str appendFormat:@"%d",(int)max];
    [str appendString:@"^"];
    //    if (dan)
    //        [str appendString:[self danGameIdSet]];
    //    else
    NSString * danstrss = @"";
    for (GC_BetData * bata in cellarray) {
        if (bata.dandan) {
            //[str appendFormat:@"%@^",bata.changhao];
            danstrss = [NSString stringWithFormat:@"%@%@,", danstrss, bata.changhao];
        }
    }
    if ([danstrss length] > 0) {
        danstrss =  [danstrss substringToIndex:[danstrss length] -1];
        [str appendFormat:@"%@^", danstrss];
    }
    //    [str setString:[str substringToIndex:[str length] - 1]];
    [str appendFormat:@"%d",0];
    [str appendString:@"^"];
    [str appendFormat:@"%d",0];
    NSLog(@"str = %@", str);
    
    NSLog(@"str ==== %@", str);
    return str;
}


- (void)pressCastButton:(UIButton *)button{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:allcellarr];
    NSLog(@"isune = %@", issuestr);
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan||matchenum == matchEnumZongJinQiuShuDanGuan) {
        
        
        
        //        NSArray * ar = [zhushuDic allKeys];
        //        if ([ar count] == 0) {
        //            //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择过关方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            //        [alert show];
        //            //        [alert release];
        //            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //            [cai showMessage:@"请选择过关方式"];
        //
        //            [self pressChuanButton];
        //
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
        }else
            //        if([twoLabel.text intValue] >= 20000){
            //        //        UIAlertView * alertTwo = [[UIAlertView alloc] initWithTitle:nil message:@"单票金额不能超过20000元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //        //        [alertTwo show];
            //        //        [alertTwo release];
            //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //        [cai showMessage:@"单票金额不能超过20000元"];
            //    } else
        {
            if (fbTextView.text == nil) {
                fbTextView.text = @"";
            }
            NSString * stringstr = @"";
            NSString * wanstr =@"";
            if (matchenum == matchEnumShengPingFuDanGuan) {
                wanstr = @"22";
                stringstr = [NSString stringWithFormat:@"#竞彩胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if (matchenum == matchEnumBiFenDanGuan){
                wanstr = @"23";
                stringstr = [NSString stringWithFormat:@"#竞彩比分_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
                wanstr = @"24";
                stringstr = [NSString stringWithFormat:@"#竞彩总进球数_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchEnumBanQuanChangDanGuan){
                wanstr = @"25";
                stringstr = [NSString stringWithFormat:@"#竞彩半全场胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
                wanstr = @"49";
                stringstr = [NSString stringWithFormat:@"#竞彩让球胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName], fbTextView.text];
            }
            NSString * etime = @"";
            for (int i = 0; i < [cellarray count]; i++ ) {
                GC_BetData * betd = [cellarray objectAtIndex:i];

                if (matchenum == matchEnumBiFenDanGuan  || matchenum == matchEnumBanQuanChangDanGuan||matchenum == matchEnumZongJinQiuShuDanGuan){
                    for (int j = 0; j < [betd.bufshuarr count]; j++) {
                        NSString * nystr = [betd.bufshuarr objectAtIndex:j];
                        if ([nystr isEqualToString:@"1"]) {
                            etime = betd.nyrstr;
                            NSLog(@"endtime = %@", betd.nyrstr);
                            break;
                        }
                    }
                }else if(matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumRangQiuShengPingFuDanGuan){
                    if (betd.selection1||betd.selection2||betd.selection3) {
                        etime = betd.nyrstr;
                        NSLog(@"endtime = %@", betd.nyrstr);
                        break;
                    }
                    

                }
                
                
            }

            
            NSLog(@"xxxxxxxxxxxx = %@", stringstr);
            NSLog(@"url = %@", [NetURL CPThreeSendPreditTopicIssue:issuestr userid:[[Info getInstance] userId] lotteryId:wanstr lotteryNumber:[self passTypeSetAndchosedGameSet] content:stringstr endtime:etime]);
            [requestt clearDelegatesAndCancel];
            self.requestt = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:issuestr userid:[[Info getInstance] userId] lotteryId:wanstr lotteryNumber:[self passTypeSetAndchosedGameSet] content:stringstr endtime:etime]];
            [requestt setDefaultResponseEncoding:NSUTF8StringEncoding];
            [requestt setDelegate:self];
            [requestt setTimeOutSeconds:20.0];
            [requestt startAsynchronous];
            
            [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
            [ProgressBar getProgressBar].mDelegate = self;
            
        }
        [longNum release];
        
        
    }else{
        
        
        int allDFS = 0;
        if ( matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan) {
            
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                
                if (matchenum == matchEnumShengPingFuGuoGuan){
                    
                    if (da.selection1 || da.selection2 || da.selection3) {
                        if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                        }else{
                            allDFS = 2;
                        }
                    }
                    
                }else{
                    
                    for (int j = 0; j < [da.bufshuarr count]; j++) {
                        if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                           
                                
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
                                }
                                
                                
                            }
                            
                            
                            
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        if (one < 2 && !((matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang) && allDFS == 1)) {
            
            if ( (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang) && allDFS != 1) {
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
        if ([ar count] == 0) {
            //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择过关方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //        [alert show];
            //        [alert release];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请选择过关方式"];
            
            [self pressChuanButton];
            
        }else if(one < 2){
            //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"至少选择2场比赛" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //        [alert show];
            //        [alert release];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择2场比赛"];
        }else
            //        if([twoLabel.text intValue] >= 20000){
            //        //        UIAlertView * alertTwo = [[UIAlertView alloc] initWithTitle:nil message:@"单票金额不能超过20000元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //        //        [alertTwo show];
            //        //        [alertTwo release];
            //        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //        [cai showMessage:@"单票金额不能超过20000元"];
            //    } else
        {
            if (fbTextView.text == nil) {
                fbTextView.text = @"";
            }
            NSString * stringstr = @"";
            NSString * wanstr =@"";
            if (matchenum == matchEnumShengPingFuGuoGuan) {
                wanstr = @"22";
                stringstr = [NSString stringWithFormat:@"#竞彩胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if (matchenum == matchEnumBiFenGuoguan){
                wanstr = @"23";
                stringstr = [NSString stringWithFormat:@"#竞彩比分_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchenumZongJinQiuShu){
                wanstr = @"24";
                stringstr = [NSString stringWithFormat:@"#竞彩总进球数_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchenumBanQuanChang){
                wanstr = @"25";
                stringstr = [NSString stringWithFormat:@"#竞彩半全场胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName],fbTextView.text];
            }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
                wanstr = @"49";
                stringstr = [NSString stringWithFormat:@"#竞彩让球胜平负_%@预测# #竞彩预测# #%@预测#%@", issuestr, [[Info getInstance] nickName], fbTextView.text];
            }
            NSString * etime = @"";
            for (int i = 0; i < [cellarray count]; i++ ) {
                GC_BetData * betd = [cellarray objectAtIndex:i];
                if (matchenum == matchEnumBiFenGuoguan  || matchenum == matchenumBanQuanChang||matchenum == matchenumZongJinQiuShu){
                    for (int j = 0; j < [betd.bufshuarr count]; j++) {
                        NSString * nystr = [betd.bufshuarr objectAtIndex:j];
                        if ([nystr isEqualToString:@"1"]) {
                            etime = betd.nyrstr;
                            NSLog(@"endtime = %@", betd.nyrstr);
                            break;
                        }
                    }
                }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan){
                    if (betd.selection1||betd.selection2||betd.selection3) {
                        etime = betd.nyrstr;
                        NSLog(@"endtime = %@", betd.nyrstr);
                        break;
                    }
                    
                }
                
                if ([etime length] > 1) {
                    break;
                }

            }

            
            NSLog(@"endtime = %@", etime);
            
            NSLog(@"xxxaaaaaa = %@", stringstr);
            NSLog(@"url = %@", [NetURL CPThreeSendPreditTopicIssue:issuestr userid:[[Info getInstance] userId] lotteryId:wanstr lotteryNumber:[self passTypeSetAndchosedGameSet] content:stringstr endtime:etime]);
            [requestt clearDelegatesAndCancel];
            self.requestt = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:issuestr userid:[[Info getInstance] userId] lotteryId:wanstr lotteryNumber:[self passTypeSetAndchosedGameSet] content:stringstr endtime:etime]];
            [requestt setDefaultResponseEncoding:NSUTF8StringEncoding];
            [requestt setDelegate:self];
            [requestt setTimeOutSeconds:20.0];
            [requestt startAsynchronous];
            
            [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
            [ProgressBar getProgressBar].mDelegate = self;
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)mrequest {
    NSString *result = [mrequest responseString];
    NSDictionary *resultDict = [result JSONValue];
    
    if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
        [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
        [NSTimer scheduledTimerWithTimeInterval:0.8
                                         target:self
                                       selector:@selector(onTimer:)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }else {
        [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
        [NSTimer scheduledTimerWithTimeInterval:0.8
                                         target:self
                                       selector:@selector(ontimerTwo)
                                       userInfo:nil
                                        repeats:NO];
    }
    
}

- (void)ontimerTwo{
    [[ProgressBar getProgressBar] dismiss];
    [self dismissSelf:YES];
}

- (void) onTimer : (id) sender {
    [[ProgressBar getProgressBar] dismiss];
    [self dismissSelf:YES];
    
    
    NSString * stringstr = @"";
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
        
        stringstr = [NSString stringWithFormat:@"#竞彩胜平负_%@预测#", issuestr];
        
    }else if (matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan){
        
        stringstr = [NSString stringWithFormat:@"#竞彩比分_%@预测#", issuestr];
        
    }else if(matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan){
        stringstr = [NSString stringWithFormat:@"#竞彩总进球数_%@预测#", issuestr];
        
    }else if(matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan){
        
        stringstr = [NSString stringWithFormat:@"#竞彩半全场胜平负_%@预测#", issuestr];
        
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan){
    
        stringstr = [NSString stringWithFormat:@"#竞彩让球胜平负_%@预测#", issuestr];
    }
    
    
    
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:stringstr];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    topicThemeListVC.jinnang = YES;
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
    
}
- (void)dismissSelf:(BOOL)animated {
    [self dismissViewControllerAnimated: animated completion:nil];
    
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

- (void)FaBiaoDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSString * ss = [dict objectForKey:@"code"];
    if ([ss isEqualToString:@"0"]) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my" object:self];
    }
}

- (void)pressHelpButton:(UIButton *)button{
    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];
    //exp.title = @"玩法";
    if (matchenum == matchEnumShengPingFuGuoGuan) {
        exp.ALLWANFA = JingCaiZuQiu;
        //exp.infoText.text = @"       选定1场比赛,对主队在全场90分钟(含伤停补时)的“胜”、“平”、“负”结果进行投注。竞彩胜平负时用3、1、0分别代表主队胜、主客战平和主队负。\n\n       当两只球队实力悬殊较大时,采取让球的方式确定双方胜平负关系.让球的数量确定后将维持不变。竞彩足球胜平负玩法最大可以选择15场比赛进行过关投注。";
    }else if(matchenum == matchEnumBiFenGuoguan){
        exp.ALLWANFA = JingCaiZuQiuBF;
        //exp.infoText.text = @"彩民选定1场比赛，对该场比赛在全场90分钟（含伤停补时）的具体比分结果进行投注。如果彩民能竞猜正确，则中奖。\n\n本游戏共设置31种比分结果选项，具体如下：\n\n       （1）主队获胜的比分：“1：0“、“2：0“、“2：1“、“3：0“、“3：1“、“3：2“、“4：0“、“4：1“、“4：2“、“5：0“、“5：1“、“5：2“以及“胜其它“（除去上述比分以外，主队获胜的其它比分，如“5：3“或“6：1“）；\n\n       （2）主队和客队打平比分：“0：0“、“1：1“、“2：2“、“3：3“以及“平其它“（除去上述比分以外，主客队打平的其它比分，如“4：4“）；\n\n       （3）“0：1“、“0：2“、“1：2“、“0：3“、“1：3“、“2：3“、“0：4“、“1：4“、“2：4“、“0：5“、“1：5“、“2：5“以及“负其它“（除去上述比分以外，主队落败的其它比分，如“4：5“或“0：8“）。";
    }else if(matchenum == matchenumZongJinQiuShu){
        exp.ALLWANFA = JingCaiZuQiuZJQS;
        //exp.infoText.text = @"       彩民选定1场比赛，对该场比赛在全场90分钟（含伤停补时）比赛双方的进球总数结果进行投注。如果彩民能竞猜正确，则中奖。\n\n       本游戏共设置8种总进球数结果选项，分别为：”0“、”1“、”2“、”3“、”4“、”5“、”6“以及”7+“，分别表示主客队的总进球数为0个、1个、2个、3个、4个、5个、6个以及7个或7个以上。";
        
        
    }else if(matchenum == matchenumBanQuanChang){
        
        exp.ALLWANFA = JingCaiZuQiuBCSPF;
        //exp.infoText.text = @"       彩民选定1场比赛，对主队在上半场45分钟（含伤停补时）和全场90分钟（含伤停补时）的“胜”、“平”、“负”结果分别进行投注。如果彩民能竞猜正确，则中奖。本游戏共设置9种比赛结果选项，分别为：\n\n    （1）“胜胜”：即上半场主队胜，全场主队胜；\n\n    （2）“胜平”：即上半场主队胜，全场主队平；\n\n    （3）“胜负”：即上半场主队胜，全场主队负；\n\n    （4）“平胜”：即上半场主队平，全场主队胜；\n\n    （5）“平平”：即上半场主队平，全场主队平；\n\n    （6）“平负”：即上半场主队平，全场主队负；\n\n    （7）“负胜”：即上半场主队负，全场主队胜；\n\n    （8）“负平”：即上半场主队负，全场主队平；\n\n    （9）“负负”：即上半场主队负，全场主队负";
        
        
    }else if(matchenum == matchEnumShengPingFuDanGuan){
        exp.ALLWANFA = JingCaiZuQiu;
        //exp.infoText.text = @"       选定1场比赛,对主队在全场90分钟(含伤停补时)的“胜”、“平”、“负”结果进行投注。竞彩胜平负时用3、1、0分别代表主队胜、主客战平和主队负。\n\n       当两只球队实力悬殊较大时,采取让球的方式确定双方胜平负关系.让球的数量确定后将维持不变。竞彩足球胜平负玩法最大可以选择6场比赛进行过关投注。\n\n       单关投注：任意选择其中一场或多个单场进行投注，一场比赛可投注多种比赛结果，每个比赛结果构成一注。\n\n       过关投注：选择2场或2场以上比赛进行串联投注的为过关投注。结果全中即中奖，在过关投注中，所选比赛的结果全部竞猜正确才能中奖。";
    }else if(matchenum == matchEnumBiFenDanGuan){
        exp.ALLWANFA = JingCaiZuQiuBF;
        //exp.infoText.text = @"彩民选定1场比赛，对该场比赛在全场90分钟（含伤停补时）的具体比分结果进行投注。如果彩民能竞猜正确，则中奖。\n\n本游戏共设置31种比分结果选项，具体如下：\n\n       （1）主队获胜的比分：“1：0“、“2：0“、“2：1“、“3：0“、“3：1“、“3：2“、“4：0“、“4：1“、“4：2“、“5：0“、“5：1“、“5：2“以及“胜其它“（除去上述比分以外，主队获胜的其它比分，如“5：3“或“6：1“）；\n\n       （2）主队和客队打平比分：“0：0“、“1：1“、“2：2“、“3：3“以及“平其它“（除去上述比分以外，主客队打平的其它比分，如“4：4“）；\n\n       （3）“0：1“、“0：2“、“1：2“、“0：3“、“1：3“、“2：3“、“0：4“、“1：4“、“2：4“、“0：5“、“1：5“、“2：5“以及“负其它“（除去上述比分以外，主队落败的其它比分，如“4：5“或“0：8“）。\n\n       单关投注：任意选择其中一场或多个单场进行投注，一场比赛可投注多种比赛结果，每个比赛结果构成一注。\n\n       过关投注：选择2场或2场以上比赛进行串联投注的为过关投注。结果全中即中奖，在过关投注中，所选比赛的结果全部竞猜正确才能中奖。";
        
    }else if(matchenum == matchEnumZongJinQiuShuDanGuan){
        exp.ALLWANFA = JingCaiZuQiuZJQS;
        //exp.infoText.text = @"       彩民选定1场比赛，对该场比赛在全场90分钟（含伤停补时）比赛双方的进球总数结果进行投注。如果彩民能竞猜正确，则中奖。\n\n       本游戏共设置8种总进球数结果选项，分别为：”0“、”1“、”2“、”3“、”4“、”5“、”6“以及”7+“，分别表示主客队的总进球数为0个、1个、2个、3个、4个、5个、6个以及7个或7个以上。\n\n       单关投注：任意选择其中一场或多个单场进行投注，一场比赛可投注多种比赛结果，每个比赛结果构成一注。\n\n       过关投注：选择2场或2场以上比赛进行串联投注的为过关投注。结果全中即中奖，在过关投注中，所选比赛的结果全部竞猜正确才能中奖。";
        
        
    }else if(matchenum == matchEnumBanQuanChangDanGuan){
        
        exp.ALLWANFA = JingCaiZuQiuBCSPF;
        //exp.infoText.text = @"       彩民选定1场比赛，对主队在上半场45分钟（含伤停补时）和全场90分钟（含伤停补时）的“胜”、“平”、“负”结果分别进行投注。如果彩民能竞猜正确，则中奖。本游戏共设置9种比赛结果选项，分别为：\n\n    （1）“胜胜”：即上半场主队胜，全场主队胜；\n\n    （2）“胜平”：即上半场主队胜，全场主队平；\n\n    （3）“胜负”：即上半场主队胜，全场主队负；\n\n    （4）“平胜”：即上半场主队平，全场主队胜；\n\n    （5）“平平”：即上半场主队平，全场主队平；\n\n    （6）“平负”：即上半场主队平，全场主队负；\n\n    （7）“负胜”：即上半场主队负，全场主队胜；\n\n    （8）“负平”：即上半场主队负，全场主队平；\n\n    （9）“负负”：即上半场主队负，全场主队负\n\n       单关投注：任意选择其中一场或多个单场进行投注，一场比赛可投注多种比赛结果，每个比赛结果构成一注。\n\n       过关投注：选择2场或2场以上比赛进行串联投注的为过关投注。结果全中即中奖，在过关投注中，所选比赛的结果全部竞猜正确才能中奖。";
    }else if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumBiFenGuoguan) {
    
        exp.ALLWANFA = JingCaiZuQiuRQSPF;
    }
    
    //exp.infoText.font = [UIFont boldSystemFontOfSize:13];
    
    // GC_ExplainViewController * exp = [[GC_ExplainViewController  alloc] init];
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];
}



//-(void)viewWillAppear:(BOOL)animated{
//    [fbTextView resignFirstResponder];
//    [super viewWillAppear:animated];
//  [Skin sunShine:[self.view viewWithTag:999] speed:3.0];
- (void)requestHttpQingqiu{
    if (!loadview) {
         loadview = [[UpLoadView alloc] init];
    }
   
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    if (matchenum != matchEnumShengPingFuGuoGuan && matchenum != matchEnumShengPingFuDanGuan ){
        myTableView.tableHeaderView = nil;
        [headView removeFromSuperview];
        headView = nil;
        tabhead = nil;
        //        myTableView.tableHeaderView.hidden = YES;
        
    }
    //    if (self.resultList) return;
    
    NSString * dgorgg = @"";
    if (matchenum == matchEnumBiFenGuoguan) {
        lotteryID = 2;
        dgorgg = @"gg";
    }else if(matchenum == matchEnumShengPingFuGuoGuan){
        if (tabhead) {
            [myTableView setTableHeaderView:headView];
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
    }else if(matchenum == matchEnumRangQiuShengPingFuGuoGuan){
    
        lotteryID = 15;
        dgorgg = @"gg";
    }else if(matchenum == matchEnumRangQiuShengPingFuDanGuan){
        lotteryID = 15;
        dgorgg = @"dg";
    }
    
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBiFenDanGuan|| matchenum == matchEnumZongJinQiuShuDanGuan) {
        chuanButton1.hidden = YES;
       castButton.frame = CGRectMake(230, 6, 80, 33);
    }else {
        chuanButton1.hidden = NO;
        castButton.frame = CGRectMake(230, 6, 80, 33);
    }
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	[networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestSuccess:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setMaxConcurrentOperationCount:1];
	[networkQueue setDelegate:self];
    
    
//    ASIHTTPRequest *request;
    NSMutableData *postData;
    
//    postData = [[GC_HttpService sharedInstance]reqJingCaiIssue:1];
//    request = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//    [request addCommHeaders];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [request appendPostData:postData];
//    [request setUserInfo:[NSDictionary dictionaryWithObject:@"issue" forKey:@"key"]];
//    [networkQueue addOperation:request];
    
    //    postData = [[GC_HttpService sharedInstance]reqJingcaiMatch:1 wanfa:lotteryID];
    //    request = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    //    [request addCommHeaders];
    //    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //    [request appendPostData:postData];
    //    [request setUserInfo:[NSDictionary dictionaryWithObject:@"match" forKey:@"key"]];
    //    [networkQueue addOperation:request];
    NSString * ended = @"";
    if (biaoshi == 1 || biaoshi == 2) {
        ended = @"-";
    }else{
        ended = @"";
    }
     NSString * hcDateKey = @"";
//    hcDateKey = [self  objectKeyStringSaveHuanCun];
    
    if (biaoshi == 1||biaoshi == 2) {
        hcDateKey = timezhongjie;
    }else{
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]) {
            hcDateKey = [NSString stringWithFormat:@"%@@%@", timezhongjie,[[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]];
        }else{
            
            hcDateKey = [NSString stringWithFormat:@"%@@", timezhongjie];
            
        }
    }
    
    
    NSLog(@"hcdate = %@", hcDateKey);
    

    
    [httprequest clearDelegatesAndCancel];
    postData = [[GC_HttpService sharedInstance] jingcaiDuizhenChaXun:1 wanfa:(int)lotteryID isEnded:ended macth:@"-" chaXunQiShu:timezhongjie danOrGuo:dgorgg];
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // [self keyboardWillDisapper];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
    [fbTextView resignFirstResponder];
}

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
- (void)pressBgHeader:(UIButton *)sender{
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
        if (sender.tag ==  0 || sender.tag == 1) {
            if ([allcellarr count] >= 1) {
               
//                    NSMutableArray * keys = [kebianzidian objectAtIndex:0];
                    GC_BetData * betdata = [allcellarr objectAtIndex:0];
                NSString * aftertime = @"";
                biaoshi =  sender.tag+1;
                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                if (sender.tag == 0) {
                    aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:timenow] dateAfterDay:(int)[self upDateWangQi:betdata duanTou:0]]];
                }else if (sender.tag == 1){
                    aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:timenow] dateAfterDay:(int)[self upDateWangQi:betdata duanTou:1]] ];
                }
                
                
                
                
                
                if ([aftertime rangeOfString:@" "].location != NSNotFound && [aftertime length] > 5 ) {
                    NSArray * timearr = [aftertime componentsSeparatedByString:@" "];
                    timezhongjie = [timearr objectAtIndex:0];
                }
                NSMutableArray * wangqiarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)sender.tag]];
                if ([wangqiarr count] == 0) {
                    [self requestHttpQingqiu];
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
           return 44;
    
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
//    
//    if ([zoujitwo isEqualToString:zoujione]) {
    
        NSString * timestring = [timeDate string];
        if ([timestring rangeOfString:@" "].location != NSNotFound) {
            NSArray * weekarr = [timestring componentsSeparatedByString:@" "];
            weekstr = [NSString stringWithFormat:@"%@ %@", [weekarr objectAtIndex:0], weekstr];
        }
        
        return weekstr;
//    }else{
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
//    
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
    
    if ([betda.time rangeOfString:@":"].location != NSNotFound) {
        NSArray * timearr = [betda.time componentsSeparatedByString:@":"];
        if (timearr.count < 2) {
            timearr = [NSArray arrayWithObjects:@"",@"", nil];
        }
        if ([[timearr objectAtIndex:0] intValue] < 11 || ([[timearr objectAtIndex:0] intValue] == 11 && [[timearr objectAtIndex:1] intValue] < 30)) {
            
            if (section == 0) {
                return -3;
            }else if(section == 1){
                return -2;
            }
            
        }else{
            if (section == 0) {
                return -2;
            }else if(section == 1){
                return -1;
            }
        }
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
    //  bgheader.image = UIImageGetImageFromName(@"weizhankai.png");
    
    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 294, 28)];
    timelabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textAlignment = NSTextAlignmentLeft;
    timelabel.font = [UIFont boldSystemFontOfSize:11];
    [bgheader addSubview:timelabel];
    [timelabel release];
    
    UILabel * la   = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 274, 28)];
    
    la.backgroundColor = [UIColor clearColor];
    la.textAlignment = NSTextAlignmentRight;
    la.textColor = [UIColor blackColor];
    la.font = [UIFont systemFontOfSize:11];
    
    [bgheader addSubview:la];
    [la release];
    
   
        
        bgheader.frame = CGRectMake(0, 0, 320, 44);
        timelabel.frame = CGRectMake(5, 0, 294, 44);
        la.frame = CGRectMake(5, 0, 274, 44);

//     BOOL sjbBool = NO;
    if (section == 0 || section == 1) {//往期
        if ([allcellarr count] >= 1) {
//            NSMutableArray * keys = [kebianzidian objectAtIndex:0];
            GC_BetData * betdata = [allcellarr objectAtIndex:0];
            NSString * aftertime = @"";
            NSString * weekstr = @"";
            if (section == 0) {
                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:timenow] dateAfterDay:(int)[self upDateWangQi:betdata duanTou:0] ]];
                
            }else if(section == 1){
                
                NSString * timenow = [NSString stringWithFormat:@"%@ 12:00:00",betdata.numtime];
                aftertime =  [NSString stringWithFormat:@"%@", [[NSDate dateFromString:timenow] dateAfterDay:(int)[self upDateWangQi:betdata duanTou:1]] ];
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
                    if (allarr.count < 3) {
                        allarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
                    }
                    aftertime = [NSString stringWithFormat:@"%@月%@日", [allarr objectAtIndex:1], [allarr objectAtIndex:2]];
                }
            }
            
            
            
            timelabel.text = [NSString stringWithFormat:@" %@ %@",aftertime, weekstr];
            
        }
        
    }else{
        NSMutableArray * keys = [kebianzidian objectAtIndex:section-2];
        GC_BetData * betdata = [keys objectAtIndex:0];
        
        NSArray * timeArray = [betdata.timeSort componentsSeparatedByString:@"_"];
        if (timeArray.count < 2) {
            timeArray = [NSArray arrayWithObjects:@"",@"", nil];
        }
        NSString * nianyueri = [timeArray objectAtIndex:0];
        NSString * xingqiji = [timeArray objectAtIndex:1];
        
        
        if([nianyueri rangeOfString:@"-"].location != NSNotFound && [nianyueri length]>5){
            NSArray * nianarr = [nianyueri componentsSeparatedByString:@"-"];
            if (nianarr.count < 3) {
                nianarr = [NSArray arrayWithObjects:@"",@"",@"", nil];
            }
            nianyueri = [NSString stringWithFormat:@"%@月%@日", [nianarr objectAtIndex:1], [nianarr objectAtIndex:2]];
        }
        
        
        timelabel.text = [NSString stringWithFormat:@" %@ %@ %d场比赛",nianyueri, xingqiji, (int)[keys count]];
        
        
        NSInteger xuanzhongcount = 0;
        if (matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan ) {
            for (int i = 0; i < [keys count]; i++) {
                GC_BetData * betd= [keys objectAtIndex:i];
//                if ([self gcbetDataFiltrateFunc:betd]) {
//                    sjbBool = YES;
//                }
                if (betd.selection1 || betd.selection2 || betd.selection3) {
                    xuanzhongcount += 1;
                }
            }
        }else{
            
            for (int  i =0 ; i < [keys count]; i++) {
                GC_BetData * betd= [keys objectAtIndex:i];
//                if ([self gcbetDataFiltrateFunc:betd]) {
//                    sjbBool = YES;
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
    return [kebianzidian count]+2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //    if ([dataArray count] > 14) {
    //        return 14;
    //    }
    
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

- (void)yanchiHiden:(NSIndexPath *)index {
    oldshowButnIndex = 0;
    UITableViewCell *cell= [myTableView cellForRowAtIndexPath:index];
    if (cell) {
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
        CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
        
        [cell2 hidenButonScollWithAnime:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row == 0) {
    //        return 90;
    //    }
    
    if (  matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
//        GC_BetData * pkbet = nil;
//        if (indexPath.section == 0 || indexPath.section == 1) {
//            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", indexPath.section]];
//            pkbet = [mutarr objectAtIndex:indexPath.row];
//        }else{
//            indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
//            NSMutableArray * mutarr = [kebianzidian objectAtIndex:indexPath.section];
//            pkbet = [mutarr objectAtIndex:indexPath.row];
//            
//        }
//        if (pkbet.worldCupBool) {
//            return 129;
//        }
        return 99;
    }
    
    if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumBanQuanChang || matchenum == matchEnumBanQuanChangDanGuan) {
        return 143;
    }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
        return 113;
    }
    
//    if (zhankai[indexPath.section][indexPath.row] == 1) {
//        return 55+56;
//    }
	return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (matchenum == matchenumZongJinQiuShu||matchenum == matchEnumZongJinQiuShuDanGuan) {
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
        //        cell.row = indexPath;
        cell.jcbool = YES;
        if (indexPath.section == 0 || indexPath.section == 1) {
            cell.wangqibool = YES;
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
            
            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
            NSLog(@"pkbet = %@", pkbet.oupeiarr);
            pkbet.donghuarow = indexPath.row;
            cell.betData = pkbet;
            cell.row = indexPath;
            
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
            cell.betData = pkbet;
            cell.row = indexPath;
            
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
            if (indexPath.section == 0 || indexPath.section == 1) {
                cell.wangqibool = YES;
                [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                
                NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                NSLog(@"pkbet = %@", pkbet.oupeiarr);
                pkbet.donghuarow = indexPath.row;
                cell.betData = pkbet;
                cell.row = indexPath;
                
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
                if (indexPath.section == 0 || indexPath.section == 1) {
                    cell.wangqibool = YES;
                    [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects: @"八方预测",nil]];
                    
                    NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                    GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                    NSLog(@"pkbet = %@", pkbet.oupeiarr);
                    pkbet.donghuarow = indexPath.row;
                    cell.betData = pkbet;
                    cell.row = indexPath;
                    
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
                    cell.betData = pkbet;
                    cell.row = indexPath;
                    
                }
                
                
                
                
                cell.delegate = self;
                
                return cell;
            }else
    
    
    if(matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan ){
        static NSString *CellIdentifier = @"Cell";
        
        GC_JCBetCell *cell = (GC_JCBetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        
        
        if (cell == nil) {
            if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
                cell = [[[GC_JCBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier matchLanQiu:matchEnumQiTaCell caodan:chaobool cellType:@"1"] autorelease];
                
            }
            if (matchenum == matchEnumRangQiuShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuGuoGuan ) {
                
                cell = [[[GC_JCBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier matchLanQiu:matchEnumQiTaCell caodan:chaobool] autorelease];
                
            }
            
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
        if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
            
            
            if (indexPath.section == 0 || indexPath.section == 1) {
                
                NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
                GC_BetData * pkbet = [mutarr objectAtIndex:indexPath.row];
                
                if (![pkbet.zhongzu isEqualToString:@"-"]) {
                    
                    
                    
                    
                    if ([pkbet.macthType isEqualToString:@"onLive"]) {
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐",@"比分直播", @"八方预测",nil]];
                        cell.butTitle.text = @"析  荐";
                    }else{
                        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"专家推荐", @"八方预测",nil]];
                        cell.butTitle.text = @"析  荐";
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
            
            
        }else{
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测",@"胆", nil]];
        }
        
        
        cell.backgroundColor = [UIColor clearColor];
       
        UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];
        
        if (matchenum == matchEnumRangQiuShengPingFuDanGuan) {
            cellbutton.hidden = YES;
        }else{
            cellbutton.hidden = NO;
        }
        
        if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
//            if (preDanBool) {
//                NSInteger scrollViewX = 0;
//                if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                    scrollViewX = 35+ ([cell.allTitleArray count]-1)*70;
//                }else{
//                    scrollViewX = ([cell.allTitleArray count]-1)*70;
//                }
//                NSLog(@"!888888888888888");
//                cell.butonScrollView.contentOffset = CGPointMake(scrollViewX, cell.butonScrollView.contentOffset.y);
//                
//                
//                GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//                jccell.XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew2.png");
//                
//            }
//            cell.buttonBool = buttonBool;
            
        }else{
            if (zhankai[indexPath.section][indexPath.row] == 1) {
                [cell showButonScollWithAnime:NO];
            }
            if (zhankai[indexPath.section][indexPath.row] == 0) {
                [cell hidenButonScollWithAnime:NO];
            }
            
        }
        
        if (indexPath.section == 0 || indexPath.section == 1) {
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
                //                UIButton * v = [cell.butonScrollView.subviews objectAtIndex:3];
                //                v.hidden = YES;
            }else{
                UIButton * v = [cell.butonScrollView.subviews objectAtIndex:1];
                v.hidden = YES;
            }
            
            cell.row = indexPath;
            NSMutableArray * mutarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
                cell.wangqiTwoBool = YES;
            }
            
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
            
            if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
                cell.wangqiTwoBool = NO;
                if (![pkbet.macthType isEqualToString:@"playvs"]) {
                    cell.wangqiTwoBool = YES;
                }
            }
            
            pkbet.donghuarow = indexPath.row;
            cell.pkbetdata = pkbet;
            cell.count = indexPath;
            cell.delegate = self;
            
            //            indexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section -2];
        }
        
        
        
        
//        if (matchenum == matchEnumShengFuDanGuan || matchenum == matchEnumShengFuGuoguan) {
//            cell.lanqiucell = matchEnumShengFuCell;
//        }else if(matchenum == matchEnumRangFenShengFuDanGuan || matchenum == matchEnumRangFenShengFuGuoguan){
//            
//            cell.lanqiucell = matchEnumRangFenShengFucell;
//        }else if(matchenum == matchEnumDaXiaoFenDanGuan || matchenum == matchEnumDaXiaFenGuoguan){
//            cell.lanqiucell = matchEnumDaXiaoFenCell;
//        }
        
        
        
        if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumShengPingFuDanGuan )  {
            cell.danguanbool = YES;
        }else{
            cell.danguanbool = NO;
        }
        return cell;
        
    }
    return nil;
}
#pragma mark _KindsOfChooseViewDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex typeArrya:(NSMutableArray *)sender{
    NSLog(@"sender = %@", sender);
    
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
             zhuanjiaBool = NO;
            NSMutableArray * array1 = [returnarry objectAtIndex:0];
            NSString * rangstring = [array1 objectAtIndex:0];
            NSMutableArray * array2 = [returnarry objectAtIndex:1];
            NSString * guostring = [array2 objectAtIndex:0];
            
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
                if ([rangstring isEqualToString:@"胜平负"]) {
                    if ([guostring isEqualToString:@"过关"]) {
                        button1.tag = 2;
                    }else{
                        button1.tag = 3;
                    }
                    
                }else if ([rangstring isEqualToString:@"总进球数"]){
                    if ([guostring isEqualToString:@"过关"]) {
                        button1.tag = 5;
                    }else{
                        button1.tag = 6;
                    }
                }else if ([rangstring isEqualToString:@"半全场胜平负"]){
                    if ([guostring isEqualToString:@"过关"]) {
                        button1.tag = 8;
                    }else{
                        button1.tag = 9;
                    }
                }else if ([rangstring isEqualToString:@"比分"]){
                    if ([guostring isEqualToString:@"过关"]) {
                        button1.tag = 11;
                    }else{
                        button1.tag = 12;
                    }
                    
                }else if([rangstring isEqualToString:@"让球胜平负"]){
                    if ([guostring isEqualToString:@"过关"]) {
                        button1.tag = 14;
                    }else{
                        button1.tag = 15;
                    }                }
      
            
            buffer[0] = 0;
            buffer[1] = 0;
            allbutcount = 0;
            biaoshi = 0;
            for (int i = 0; i < 50; i++) {
                for (int k = 0; k < 200; k++) {
                    zhankai[i][k] = 0;
                }
            }
            NSMutableArray * arr1 = [wangqiArray objectForKey:@"0"];
            NSMutableArray   * arr2 = [wangqiArray objectForKey:@"1"];
            [arr1 removeAllObjects];
            [arr2 removeAllObjects];
            timezhongjie = systimestr;
            [duoXuanArr removeAllObjects];
            [self pressjiugongge:button1];
            [kongzhiType removeAllObjects];
            [kongzhiType addObjectsFromArray:kongt];
        }
        
        
    }else if(chooseView.tag == 30){
        if (buttonIndex == 1) {
            if (buttonIndex == 1) {
                NSLog(@"kongt = %@", kongt);
                [duoXuanArr removeAllObjects];
                [duoXuanArr addObjectsFromArray:kongt];
                
                zhuanjiaBool = chooseView.zhuanjiaBool;
                
                if (( matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan)&& chooseView.zhuanjiaBool ) {
                    
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
                
                if (matchenum != matchEnumRangQiuShengPingFuDanGuan && matchenum != matchEnumRangQiuShengPingFuGuoGuan&&matchenum != matchEnumShengPingFuDanGuan && matchenum != matchEnumShengPingFuGuoGuan) {
                    [cellarray removeAllObjects];
                    
                  
                    
                    if ( matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang) {
                        
                        NSMutableArray * zhongjiecellone = [NSMutableArray array];
                        
                        [zhongjiecellone addObjectsFromArray:allcellarr];
                        
                        for (int i = 0; i < [returnarry count] ; i++) {
                            NSArray * arrayz = [returnarry objectAtIndex:[returnarry count]-(i+1)];
                            NSMutableArray * zhongjiecell = [NSMutableArray array];
                            
                            if ([arrayz count] == 0  || (i == 0 && [arrayz count] == 2)) {
                                [zhongjiecell removeAllObjects];
                                [zhongjiecell addObjectsFromArray:allcellarr];
                            }else{
                                
                                //                            [zhongjiecell addObjectsFromArray:allcellarr];
                                
                                for (int i = 0; i < [zhongjiecellone count]; i++) {
                                    GC_BetData * btd = [zhongjiecellone objectAtIndex:i];
                                    for (int k = 0; k < [arrayz count]; k++) {
                                        NSString * saishi1 = [btd.event stringByReplacingOccurrencesOfString:@" " withString:@""];
                                        NSString * saishi2 = [[arrayz objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                                        
                                        
                                        if (matchenum == matchenumZongJinQiuShu){
                                            if ([saishi2 isEqualToString:@"单关"]) {
                                                if ([btd.onePlural rangeOfString:@" 3,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else if ([saishi2 isEqualToString:@"串关"]){
                                                if (!([btd.onePlural rangeOfString:@" 3,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound)) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else{
                                                if ([saishi1 isEqualToString:saishi2]) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }
                                        }else if (matchenum == matchenumBanQuanChang){
                                            if ([saishi2 isEqualToString:@"单关"]) {
                                                if ([btd.onePlural rangeOfString:@" 4,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else if ([saishi2 isEqualToString:@"串关"]){
                                                if (!([btd.onePlural rangeOfString:@" 4,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound)) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else{
                                                if ([saishi1 isEqualToString:saishi2]) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }
                                        }else if (matchenum == matchEnumBiFenGuoguan){
                                            if ([saishi2 isEqualToString:@"单关"]) {
                                                if ([btd.onePlural rangeOfString:@" 2,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else if ([saishi2 isEqualToString:@"串关"]){
                                                if (!([btd.onePlural rangeOfString:@" 2,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound)) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }else{
                                                if ([saishi1 isEqualToString:saishi2]) {
                                                    [zhongjiecell addObject:btd];
                                                }
                                            }
                                        }
                                        
                                        
                                        
                                        
                                    }
                                }
                                [zhongjiecellone removeAllObjects];
                                [zhongjiecellone addObjectsFromArray:zhongjiecell];
                                [zhongjiecell removeAllObjects];
                            }
                        }
                        
                        
                        
                        [cellarray addObjectsFromArray:zhongjiecellone];
                        NSLog(@"zhongjiecell = %d", (int)[zhongjiecellone count]);
                        
                    }else{
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
                    }
                }else{
                    NSInteger zcount = 0;
                    NSInteger diyicount = 0;
                    NSInteger diercount = 0;
                    NSInteger disancount = 0;
//                    NSInteger rangfeirang1 = 0;
//                    NSInteger rangfenrang2 = 0;
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
//                                    rangfeirang1 = 1;
                                }
                                if (i == 0 && k == 1){
//                                    rangfenrang2 = 1;
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
                    
                    
                    
                    //            for (NSMutableArray * strarr in returnarry) {
                    //
                    //                for (NSString * str in strarr) {
                    //                    NSLog(@"sttttt = %@", str);
                    //                    [tiaojianarr addObject:str];
                    //                }
                    //
                    //            }
                    //
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
                                
                                if ([btd.event isEqualToString:[arrayz objectAtIndex:k]]) {
                                    [zhongjiecell addObject:btd];
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                    
                    NSLog(@"zhongjiecell = %d", (int)[zhongjiecell count]);
                    
                    if (zcount == 2) {
                        [cellarray addObjectsFromArray:zhongjiecell];
                    }else{

//                        
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
                        
                        if (matchenum == matchEnumShengPingFuGuoGuan) {
                            NSArray * arrayz5 = [returnarry objectAtIndex:[returnarry count] -1];
                            NSMutableArray * zhongjiecell5 = [NSMutableArray array];
                            if ([arrayz5 count] == 0 || [arrayz count] == 2) {
                                [zhongjiecell5 addObjectsFromArray:peilvarr];
                            }else{
                                
                                for (int i = 0; i < [peilvarr count]; i++) {
                                    GC_BetData * btd = [peilvarr objectAtIndex:i];
                                    for (int k = 0; k < [arrayz5 count]; k++) {
                                        
                                        NSString * saishi5 = [[arrayz5 objectAtIndex:k] stringByReplacingOccurrencesOfString:@" " withString:@""];
                                        
                                        if ([saishi5 isEqualToString:@"单关"]) {
                                            if ([btd.onePlural rangeOfString:@" 1,"].location == NSNotFound && [btd.onePlural rangeOfString:@" 0,"].location == NSNotFound) {
                                                [zhongjiecell5 addObject:btd];
                                            }
                                        }else if ([saishi5 isEqualToString:@"串关"]){
                                            if ([btd.onePlural rangeOfString:@" 1,"].location != NSNotFound || [btd.onePlural rangeOfString:@" 0,"].location != NSNotFound) {
                                                [zhongjiecell5 addObject:btd];
                                            }
                                        }else{
                                            
                                            [zhongjiecell5 addObject:btd];
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                }
                                
                                
                            }
                            [cellarray addObjectsFromArray:zhongjiecell5];
                        }else{
                            [cellarray addObjectsFromArray:peilvarr];
                        }
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                [kebianzidian removeAllObjects];
                [self shaixuanzidian:cellarray];
                if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan ) {
                    [self sortFunc:(int)[NSString stringWithFormat:@"%d", (int)sortCount]];
                }

                [myTableView reloadData];
            }
            
            
            
        }
        
        
    }
    
}
-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView
{
    self.mainView.userInteractionEnabled = YES;
}
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton *)sender{
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
            for (NSString * str in returnarry) {
                NSLog(@"st = %@", str);
            }
            
        }
        
    }else if(chooseView.tag == 20){
        if (buttonIndex == 1) {
            
        }
    }
}

- (void)returnBoolDanbifen:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell;{
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
    int allbu = 0;
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
    int coutt = 0;
    
    for (int i = 0; i < [kebianzidian count]; i++) {
        NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [arrkebian count]; j++) {
            GC_BetData * be = [arrkebian objectAtIndex:j];
            if (be.dandan) {
                
                coutt++;
            }
            
        }
    }
    
    if (matchenum == matchEnumBiFenGuoguan ) {
        if (coutt == 4) {
            panduanbool = NO;
        }else if(coutt < 4){
            panduanbool = YES;
        }
        
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设3个胆"];
        }
        panduanzhongjie = panduanbool;
        
        
    }else if(matchenum == matchenumZongJinQiuShu){
        if (coutt == 6) {
            panduanbool = NO;
        }else if(coutt < 6){
            panduanbool = YES;
        }
        
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设5个胆"];
        }
        panduanzhongjie = panduanbool;
        
    }else if(matchenum == matchenumBanQuanChang){
        NSLog(@"cccccccc  = %d", coutt );
        if (coutt == 4) {
            panduanbool = NO;
        }else if(coutt < 4){
            panduanbool = YES;
        }
        
        if (panduanzhongjie == NO && panduanbool == NO){
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"最多可以设3个胆"];
        }
        panduanzhongjie = panduanbool;
        
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
        
//        GC_BetData * cbe = [duixiangarr objectAtIndex:jccell.row.row];
//        if (danbool && cbe.nengyong) {
//            
//            UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//            //           danbutton.backgroundColor = [UIColor redColor];
//            //           [danbutton setImage:UIImageGetImageFromName(@"danzucai_1.png") forState:UIControlStateNormal];
//            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//            btnImage.image = UIImageGetImageFromName(@"danzucai_1.png");
//            
//        }else{
//            UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//            //           danbutton.backgroundColor = [UIColor blackColor];
//            //           [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
//            UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//            btnImage.image = UIImageGetImageFromName(@"danzucai.png");
//            
//        }
        
    }else{
        
        if (danbool) {
            coutt+=1;
            if (coutt > one-2 && one > 2) {
                NSLog(@"dan = %d, one = %d", coutt, one-2);
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
//        UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:1];
//        //        danbutton.backgroundColor = [UIColor blackColor];
//        //        [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
//        UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
//        btnImage.image = UIImageGetImageFromName(@"danzucai.png");
        GC_BetData * gcbe = [duixiangarr objectAtIndex:jccell.row.row];
        gcbe.dandan = NO;
        [duixiangarr replaceObjectAtIndex:jccell.row.row withObject:gcbe];
    }
    
    
    [myTableView reloadData];
}

- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num selctCell:(CP_CanOpenCell *)openCell{
    NSLog(@"danbool = %d", danbool);
    GC_JCBetCell * jccell = (GC_JCBetCell *)openCell;
    //    NSArray * allke = [kebianzidian allKeys];
    NSLog(@"row = %d, se = %d", (int)jccell.row.row,(int) jccell.row.section);
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
    
    if (panduanzhongjie == NO && panduanbool == NO){
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"最多可以设7个胆"];
    }
    panduanzhongjie = panduanbool;
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
                NSLog(@"dan = %d, one = %d", (int)coutt, one-2);
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
    
    
    
    [myTableView reloadData];
    
}
- (void)returncellrownumbifen:(NSIndexPath *)num{
    if (num.section == 0 || num.section == 1) {
        NSMutableArray * duixiangarr =[wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)num.section]];
        GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        [self NewAroundViewShowFunc:be indexPath:num history:YES];
        
        //            sachet.playID = be.saishiid;
    }else{
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
        GC_BetData * be = [duixiangarr objectAtIndex:num.row];
        [self NewAroundViewShowFunc:be indexPath:num history:NO];
        
        //            sachet.playID = be.saishiid;
    }

//    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:num.section];
//    GC_BetData * be = [duixiangarr objectAtIndex:num.row];
//    if (num.section == 0 || num.section == 1) {
//        
//    }else{
//        NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
//        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
//            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
//            neutrality.delegate = self;
//            [neutrality show];
//            [neutrality release];
//            return;
//        }
//    }
//   
//    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
//    
//    sachet.playID = be.saishiid;
//#ifdef isCaiPiaoForIPad
//    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
//#else
//    [self.navigationController pushViewController:sachet animated:YES];
//#endif
//    [sachet release];
    
}

- (void)calculateMoney{
    if(matchenum == matchEnumRangQiuShengPingFuDanGuan|| matchenum == matchEnumShengPingFuDanGuan ){
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
    
    if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan) {
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
     //   }
        fieldLable.text = @"注";
        pourLable.hidden = NO;
        twoLabel.hidden = NO;
        oneLabel.text = [NSString stringWithFormat:@"%d", zcount];
        twoLabel.text = [NSString stringWithFormat:@"%d", zcount*2];
        
    }
    
}

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
       
       
    
    
    //  NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", index, selection1, selection2, selection3);
    //  GC_BetData  * da = [cellarray objectAtIndex:index];
    
    NSMutableArray * daaa = [kebianzidian objectAtIndex:index.section];
    GC_BetData  * da = [daaa objectAtIndex:index.row];
    
    //    if (da.selection1 || da.selection2 ||da.selection3) {
    //        [danbutDic setObject:[NSNumber numberWithInt:booldan] forKey:[NSString stringWithFormat:@"%d", index]];
    //
    //    }
    
    
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
//    }
    
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
        
        //        NSArray * keys = [kebianzidian allKeys];
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * bet = [allcellarr objectAtIndex:j];
            if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
                bet.dandan = NO;
            }
            
            [allcellarr replaceObjectAtIndex:j withObject:bet];
        }
        //            [kebianzidian setObject:mutaarr forKey:[keys objectAtIndex:i]];
        
    }
    // }
    
    allbutcount = allbu;

   
    
    //NSLog(@"aaa = %d", buttoncout);
    if (buttoncout > 15) {
        //  NSLog(@"aaaaaaaaaa");
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"不能超过15场"];
        oneLabel.text = @"15";
        one = 15;
        //  NSString * indstr = [NSString stringWithFormat:@"%d", index];
        //   [self performSelector:@selector(dayushiwuchang) withObject:indstr afterDelay:1];
        
        //  for (int i = 15; i < [cellarray count]; i++) {
        
        NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
        GC_BetData * dabet = [daarray objectAtIndex:index.row];
        dabet.selection1 = NO;
        dabet.selection2 = NO;
        dabet.selection3 = NO;
        //   }
        [self calculateMoney];
        
        [myTableView reloadData];
        return;
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
        }
        
        addchuan = 0;
        
        [zhushuDic removeAllObjects];
        for (int i = 0; i < 160; i++) {
            buf[i] = 0;
        }
//        for (int i = 0; i < [kebianzidian count]; i++) {
//            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
//            for (int j = 0; j < [allcellarr count]; j++) {
//                GC_BetData * bet = [allcellarr objectAtIndex:j];
//                if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
//                    bet.dandan = NO;
//                }
//                
//                [allcellarr replaceObjectAtIndex:j withObject:bet];
//            }
        
            // [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
        }
        
  //  }
    NSLog(@"two = %d", two);
    //   oneLabel.text = [NSString stringWithFormat:@"%d", one];
    //    int beishu = [beiShuLabel.text longLongValue]/([zhuShuLabel.text longLongValue]*2);
    
    //   twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    
    
//    for (int i = 0; i < [kebianzidian count]; i++) {
//        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * bet = [allcellarr objectAtIndex:j];
            if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
                
                
                if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
                    bet.dandan = NO;
                }
            }
            [allcellarr replaceObjectAtIndex:j withObject:bet];
            
        }
        //    [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
 //   }
    
    butcount = buttoncout;
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan) {
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
        if (!bet.selection1 && !bet.selection2 && !bet.selection3) {
            
            
            bet.dandan = NO;
        }
        
        [allcellarr replaceObjectAtIndex:j withObject:bet];
        
        if (matchenum == matchEnumShengPingFuGuoGuan) {
            if (bet.selection1 || bet.selection2 || bet.selection3) {
                if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                    if (allDFS == 0 || allDFS == 1) {
                        allDFS = 1;
                    }
                    
                }else{
                    allDFS = 2;
                }
            }
        }
    }
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
    

    [myTableView reloadData];
    
    if(matchenum == matchEnumRangQiuShengPingFuGuoGuan || matchenum == matchEnumShengPingFuGuoGuan){
        if (matchenum == matchEnumShengPingFuGuoGuan && allDFS == 1 && one == 1) {
            
            
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
                for (GC_BetData * da in cellarray) {
                    
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
#pragma mark - CP_CanOpenCellDelegate




- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index {
    //    [self deleteContentOff];
    
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan  || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang || matchenum == matchEnumBiFenGuoguan || matchenum == matchEnumBiFenDanGuan ) {
//        buttonBool = YES;
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
            NSIndexPath *indexPath = nil;
            if (jccell.wangqibool) {
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section];
            }else{
                indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
                
            }
            [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
          
            NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
            
            GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
            
            [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO] ;
            
            
            
        }
        else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"胆"]) {
//            preDanBool = YES;
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
            if(matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan ){
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
            
            
            [UIView beginAnimations:@"ndd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            NSLog(@"!77777777777777");
            cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
            [UIView commitAnimations];
            
            
             if(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan ){
                
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
            }
            
            matchDetailVC.issue = be.numtime;
            matchDetailVC.shouldShowSwitch = NO;
            matchDetailVC.start = @"1";
            NSLog(@"111111111111111111 %@, %@, %@, %@", matchDetailVC.matchId,  matchDetailVC.lotteryId, matchDetailVC.issue,  matchDetailVC.start );
            [self.navigationController pushViewController:matchDetailVC animated:YES];
            [matchDetailVC release];
            
            
            
            
            
        } else if (Index == 101){//收起
//            [self openCellHunTou:cell];
            
            
        }
//        buttonBool = NO;
    }else{
        
        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
        if (Index == 0) {
            
            if (jccell.wangqibool == YES) {
              
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
                
                
            }else{
                
                
                    
                    NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
                    
                    GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
                    
                    [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
                
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
            if(matchenum == matchEnumRangQiuShengPingFuGuoGuan||matchenum == matchEnumShengPingFuGuoGuan ){
                [self returnBoolDan:be.dandan row:Index selctCell:cell];
            }else{
                [self returnBoolDanbifen:be.dandan row:Index selctCell:cell];
            }
            
        }else if (Index == 101){//收起
//            [self openCellHunTou:cell];
            
            
        }
    }
    
    
    
    
}




- (void)returncellrownum:(NSIndexPath *)num cell:(CP_CanOpenCell *)cell{
    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
    if (jccell.wangqibool == YES) {
        NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", (int)jccell.row.section]];
        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];

        [self NewAroundViewShowFunc:be indexPath:jccell.row history:YES];
        
        
//        NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
//        //        sachet.playID = @"234028"; //传入这两个对比赛的id
//        //    NSArray * allke = [kebianzidian allKeys];
//        NSMutableArray * duixiangarr = [wangqiArray objectForKey:[NSString stringWithFormat:@"%d", jccell.row.section]];
//        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
//        NSLog(@"%@", be.saishiid);
//        sachet.playID = be.saishiid;
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
//#else
//        [self.navigationController pushViewController:sachet animated:YES];
//#endif
//        [sachet release];
        
    }else{
        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
        
        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];

        [self NewAroundViewShowFunc:be indexPath:jccell.row history:NO];
        
//        NSMutableArray * duixiangarr = [kebianzidian objectAtIndex:jccell.row.section];
//        
//        GC_BetData * be = [duixiangarr objectAtIndex:jccell.row.row];
//        NSString * changhaostr = [be.numzhou substringWithRange:NSMakeRange(2, 3)];
//        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
//            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:changhaostr] ;
//            neutrality.delegate = self;
//            [neutrality show];
//            [neutrality release];
//            return;
//        }
//        
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

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan{
    
    
    
    
    
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
    
    
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
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
        NSLog(@"gc = %d", gc);
        if (gc != 0) {
            two = two *gc;
        }
        
        //int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
        // NSString * string = [string stringByAppendingFormat:@"%d", gc];
        if (gc != 0) {
            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
        }
        
        NSLog(@"aaa = %@", m_shedanArr);
        
    }
    //  }
    NSInteger allbu = 0;
    
    for (int j = 0; j < [allcellarr count]; j++) {
        GC_BetData * bet = [allcellarr objectAtIndex:j];
        
        for (int  k = 0; k < [bet.bufshuarr count]; k++) {
            NSString * bufzi = [bet.bufshuarr objectAtIndex:k];
            if ([bufzi isEqualToString:@"1"]) {
                allbu++;
            }
            
        }
        
        //        bet.dandan = NO;
        //
        //        [cellarray replaceObjectAtIndex:i withObject:bet];
    }
    //  }
    
    if (allbutcount != allbu) {
        labelch.text = @"串法";
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan ) {
            
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
        
        //        NSArray * keys = [kebianzidian allKeys];
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
//        for (int j = 0; j < [allcellarr count]; j++) {
//            GC_BetData * bet = [allcellarr objectAtIndex:j];
//            bet.dandan = NO;
//            
//            [allcellarr replaceObjectAtIndex:j withObject:bet];
//        }
        //            [kebianzidian setObject:mutaarr forKey:[keys objectAtIndex:i]];
        
    }
    //  }
    
    allbutcount = allbu;
    
    
    
    NSInteger changcishu = 0;
    
        changcishu = 15;
    
    if (buttoncout > changcishu) {
        //  NSLog(@"aaaaaaaaaa");
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        
            [cai showMessage:@"不能超过15场"];
            oneLabel.text = @"15";
        one = 15;
        
        //  NSString * indstr = [NSString stringWithFormat:@"%d", index];
        //   [self performSelector:@selector(dayushiwuchang) withObject:indstr afterDelay:1];
        
        //  for (int i = 15; i < [cellarray count]; i++) {
        
        NSMutableArray * daarray = [kebianzidian objectAtIndex:index.section];
        GC_BetData * dabet = [daarray objectAtIndex:index.row];
        NSMutableArray * musarr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int  m = 0; m < [dabet.bufshuarr count]; m++) {
            [musarr addObject:@"0"];
            
            
        }
        dabet.bufshuarr = musarr;
        [daarray replaceObjectAtIndex:index.row withObject:dabet];
        [musarr release];
        //        dabet.selection1 = NO;
        //        dabet.selection2 = NO;
        //        dabet.selection3 = NO;
        //   }
        [self calculateMoney];
        [myTableView reloadData];
        return;
    }
    
    
    //如果再多选的话 清一下
    if (buttoncout > butcount) {
        labelch.text = @"串法";
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan ) {
            
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
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
//        for (int j = 0; j < [allcellarr count]; j++) {
//            GC_BetData * bet = [allcellarr objectAtIndex:j];
//            bet.dandan = NO;
//            
//            [allcellarr replaceObjectAtIndex:j withObject:bet];
//        }
        
        // [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
    }
    
    //  }
    NSLog(@"two = %d", two);
    //   oneLabel.text = [NSString stringWithFormat:@"%d", one];
    //    int beishu = [beiShuLabel.text longLongValue]/([zhuShuLabel.text longLongValue]*2);
    
    //   twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    
    
    
    //    for (int i = 0; i < [kebianzidian count]; i++) {
    //        NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
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
    //    [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
    //   }
    
    butcount = buttoncout;
    
    if (matchenum == matchEnumRangQiuShengPingFuDanGuan||matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan ) {
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
        //        twoLabel.text = @"0";
        //        oneLabel.text = @"0";
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
        if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumBanQuanChangDanGuan ) {
            
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
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * mutaarr = [kebianzidian objectAtIndex:i];
//        for (int j = 0; j < [allcellarr count]; j++) {
//            
//            GC_BetData * bet = [allcellarr objectAtIndex:j];
//            bet.dandan = NO;
//            
//            [allcellarr replaceObjectAtIndex:j withObject:bet];
//        }
        // [kebianzidian setObject:mutaarr forKey:[[kebianzidian allKeys] objectAtIndex:i]];
    }
    // }
    
    
    [self calculateMoney];
    if (one > 1) {
        //        for (int i = 0; i < [kebianzidian count]; i++) {
        //            NSMutableArray * arrkebian = [kebianzidian objectAtIndex:i];
        for (int j = 0; j < [allcellarr count]; j++) {
            GC_BetData * be = [allcellarr objectAtIndex:j];
            be.nengyong = YES;
            [allcellarr replaceObjectAtIndex:j withObject:be];
        }
        //[kebianzidian replaceObjectAtIndex:j withObject:arrkebian];
    }
    
    //  }
    
    [myTableView reloadData];
    
    
    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumZongJinQiuShu || matchenum == matchenumBanQuanChang) {
        
        if (one == 1 && ( matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu)) {
            int qhhbool = 0;
            int hhhbool = 0;
            int allDFS = 0;
            //            NSInteger zcount = 0;
            for (GC_BetData * da in allcellarr) {
                
                if (matchenum == matchEnumShengPingFuGuoGuan) {
                    if (da.selection1 || da.selection2 || da.selection3) {
                        if ([da.onePlural rangeOfString:@" 1,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                            if (allDFS == 0 || allDFS == 1) {
                                allDFS = 1;
                            }
                            
                        }else{
                            allDFS = 2;
                        }
                    }
                }else{
                    for (int i = 0; i < [da.bufshuarr count]; i++) {
                        
                        if ([[da.bufshuarr objectAtIndex:i] isEqualToString:@"1"]) {
                             if (matchenum == matchenumZongJinQiuShu){
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
                                if ([da.onePlural rangeOfString:@" 2,"].location == NSNotFound && [da.onePlural rangeOfString:@" 0,"].location == NSNotFound ) {
                                    if (allDFS == 0 || allDFS == 1) {
                                        allDFS = 1;
                                    }
                                    
                                }else{
                                    allDFS = 2;
                                }
                            }
                            
                            
                            
                        }
                    }
                    
                    
                    
                    //                    if ([[da.bufshuarr objectAtIndex:i] intValue] == 1) {
                    //                        if ([da.onePlural intValue] == 1 && i > 2) {
                    //                            hhhbool = YES;
                    //                            zcount += 1;
                    //                        }else if ([da.onePlural intValue] == 15 && i < 3){
                    //                            qhhbool = YES;
                    //                            zcount += 1;
                    //                        }
                    //
                    //
                    //                    }
                }
                //                if (hhbool ) {
                //                    break;
                //                }
                
            }
            
            if (qhhbool == 1 ||  hhhbool == 1 || allDFS == 1) {
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
            for (GC_BetData * da in cellarray) {
                
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
            GC_JiangCaiMatch *match  = [[GC_JiangCaiMatch alloc] initWithResponseData:responseData WithRequest:mrequest];
            if (match) {
                //                matchComboBox.popUpBoxDatasource = match.matchList;
                //                [matchComboBox.popUpBoxTableView  reloadData];
                //                NSString *initDatas = [match.matchList objectAtIndex:0];
                //                matchComboBox.textField.text = initDatas;
                for (NSString * st in match.matchList) {
                    NSString * stri = st;
                    NSLog(@"stri = %@", stri);
                    [saishiArray addObject:stri];
                }
            }
            [match release];
        }else if(obj&&[obj isEqualToString:@"duizhen"]){// 对阵列表
           
            if (biaoshi == 1 || biaoshi == 2) {
                
            }else{
                 [cellarray removeAllObjects];
            }
            GC_JingCaiDuizhenChaXun *duizhen = [[GC_JingCaiDuizhenChaXun alloc] initWithResponseData:responseData WithRequest:mrequest];
            if (duizhen&&duizhen.count == 0&& duizhen.updata == 1) {
                if (biaoshi == 1 || biaoshi == 2) {
                    
                }else{
                    [kebianzidian removeAllObjects];
                }
                
                if (biaoshi != 1 && biaoshi != 2) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"赛程更新中，请稍后再试"];
                }
//                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//                [cai showMessage:@"赛程更新中，请稍后再试"];
                [myTableView reloadData];
                if (loadview) {
                    [loadview stopRemoveFromSuperview];
                    loadview = nil;
                }
                return;
            }
            
            if (duizhen.count > 0 && [duizhen.listData count] == 0 && duizhen.updata == 1) {
                
                if (countjishuqi < 3) {
                    countjishuqi += 1;
                    [self requestHttpQingqiu];
                    
                }else{
                    countjishuqi = 0;
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"网络原因，请稍后再试"];
                    [myTableView reloadData];
                    if (loadview) {
                        [loadview stopRemoveFromSuperview];
                        loadview = nil;
                    }
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
                // [mTableView reloadData];
                if (biaoshi == 1 || biaoshi == 2) {
                    
                }else{
                    [allcellarr removeAllObjects];
                }
                for (GC_JingCaiDuizhenResult * gc in self.resultList) {
                    GC_BetData * be = [[GC_BetData alloc] init];
                    be.event = gc.match;
                    NSArray * timedata = [gc.deathLineTime componentsSeparatedByString:@" "];
                    if (timedata.count < 2) {
                        timedata = [NSArray arrayWithObjects:@"",@"", nil];
                    }
                    be.date = [timedata objectAtIndex:0];
                    be.time = [timedata objectAtIndex:1];
                    be.team = [NSString stringWithFormat:@"%@,%@,%@", gc.homeTeam,gc.vistorTeam, gc.rangQiu];
                    be.saishiid = gc.bicaiid;
                    be.nyrstr = gc.nyrstr;
                    be.numzhou = gc.num;
                    be.changhao = gc.matchId;
                    be.bifen = gc.score;
                    be.caiguo = gc.lotteryResult;
                    be.oupeiPeilv = gc.europeOdds;
                     be.zhongzu = gc.zhongzu;
                    be.macthTime = gc.macthTime;
                    be.macthType = gc.macthType;
                    be.datetime = gc.datetime;
                    be.zlcString =  gc.zlcString;
                    be.timeSort = gc.timeSort;
                    be.onePlural = gc.onePlural;

//                    be.zlcString = @"-True";
//                    NSString * saishi = [be.event stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    
//                    if ([saishi rangeOfString:@"世界杯"].location != NSNotFound) {
//                        if (biaoshi != 1 && biaoshi != 2) {//第一段和第二段
//                            self.worldCupBool = YES;
//                        }
//                    }
//                    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan) {
//                        NSString * saishi = [be.event stringByReplacingOccurrencesOfString:@" " withString:@""];
//                        
//                        if ([saishi rangeOfString:@"世界杯"].location != NSNotFound) {
//                            //teamFlag
//                            NSString * path = [[NSBundle mainBundle] pathForResource:@"teamInfo" ofType:@"plist"];
//                            NSDictionary * teamInfoDic =[NSDictionary dictionaryWithContentsOfFile:path];
//                            
//                            NSInteger banneCount = 0;
//                            if ([teamInfoDic objectForKey:gc.homeTeamNum]) {
//                                NSDictionary * bannerDic = [teamInfoDic objectForKey:gc.homeTeamNum];
//                                be.homeBannerImage = [bannerDic objectForKey:@"teamFlag"];
//                                banneCount += 1;
//                            }
//                            
//                            if ([teamInfoDic objectForKey:gc.vistorTeamNum]) {
//                                NSDictionary * bannerDic = [teamInfoDic objectForKey:gc.vistorTeamNum];
//                                be.guestBannerImage = [bannerDic objectForKey:@"teamFlag"];
//                                banneCount += 1;
//                            }
//                            
//                            if (banneCount == 2) {
//                                be.worldCupBool = YES;
//                            }else{
//                                be.worldCupBool = NO;
//                            }
//                            
//                        }
//                        
//                    }
                    NSArray * nutimearr = [gc.datetime componentsSeparatedByString:@" "];
                    be.numtime = [nutimearr objectAtIndex:0];
                    if (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan ||  matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumRangQiuShengPingFuDanGuan) {
                        be.oupeistr = gc.odds;
                        NSLog(@"ddddd= %@", be.oupeistr);
                    }
                    
                    NSLog(@"id = %@", gc.bicaiid);
                    if ([gc.odds length] > 1) {
                        NSArray * butarray = [gc.odds componentsSeparatedByString:@" "];
                        
                        if (matchenum == matchEnumBiFenGuoguan || matchenum == matchenumBanQuanChang || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBanQuanChangDanGuan ||  matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumRangQiuShengPingFuDanGuan) {
                            
                            
                            NSArray * oepei = [gc.odds componentsSeparatedByString:@" "];
                            
                            be.oupeiarr = oepei;
                            
                        }
                        
                        be.but1 = [butarray objectAtIndex:0];
                        // NSLog(@"but = %@", betdata.but1);
                        be.but2 = [butarray objectAtIndex:1];
                        be.but3 = [butarray objectAtIndex:2];
                        
                    }
                    
                    be.cellstring = @"请选择投注选项";
                    
                    
                    NSLog(@"saishi = %@", gc.match);
                    NSLog(@"zhu dui = %@", gc.homeTeam);
                    NSLog(@"ke dui = %@", gc.vistorTeam);
                    NSLog(@"shijian = %@", gc.deathLineTime);
                    NSLog(@"ou pei = %@", gc.odds);
                    NSLog(@"num = %@", gc.deathLineTime);
                    if (biaoshi == 1) {
                        NSMutableArray * cellarraytime = [wangqiArray objectForKey:@"0"];
                        [cellarraytime addObject:be];
                    }else if(biaoshi == 2){
                        NSMutableArray * cellarraytime = [wangqiArray objectForKey:@"1"];
                        [cellarraytime addObject:be];
                    }else{
                        [cellarray addObject:be];
                        [allcellarr addObject:be];
                    }
                    
                    
                    
                    
                    
                    [be release];
                }
                if (biaoshi == 1 || biaoshi == 2) {
                    
                }else{

                
                [kebianzidian removeAllObjects];
                [self shaixuanzidian:allcellarr];
                    
                [saishiArray removeAllObjects];
//                [saishiArray addObject:@"全部"];dddd
                    
                    
                GC_BetData * betda = [allcellarr objectAtIndex:0];
                    if ([betda.event length] > 5) {
                        betda.event = [betda.event substringToIndex:5];
                    }
                [saishiArray addObject:betda.event];
                
                
                for (int i = 0; i < [allcellarr count]; i++) {
                    BOOL xiangtong = NO;
                    GC_BetData * begc = [allcellarr objectAtIndex:i];
                    if ([betda.event length] > 5) {
                        betda.event = [betda.event substringToIndex:5];
                    }
                    for (int j = 0; j < [saishiArray count]; j++) {
                        
                        NSString * sai = [saishiArray objectAtIndex:j];
                        if ([begc.event isEqualToString:sai]) {
                            xiangtong = YES;
                        }
                    }
                    if (xiangtong != YES) {
                        if ([begc.event length] > 5) {
                            begc.event = [begc.event substringToIndex:5];
                        }
                        [saishiArray addObject:begc.event];
                    }
                    
                    
                    
                    if ([kebianzidian count] > 1) {
                        NSMutableArray * mutarr = [kebianzidian objectAtIndex:0];
                        if ([mutarr count] <= 4 ) {
                            buffer[3] = 1;
                        }
                    }
                    
                }
                
                }
                if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
                     [self sortFunc:[NSString stringWithFormat:@"%d", (int)sortCount]];
                }
                [myTableView reloadData];
                
                
                
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
                            NSLog(@"dd = %d", (int)indexPath.section);
                            buffer[indexPath.section] = 1;
                            [myTableView reloadData];
                            if ([kebianzidian count]+2 > indexPath.section) {
                                NSMutableArray * daarr = [kebianzidian objectAtIndex:indexPath.section-2];
                                if ([daarr count] > 0) {
                                   [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                                }
                            }
                            
                            
                        }
                        
                    }
                
                
                
                
            }
            [duizhen release];
        }
    }else{
        
        [self requestHttpQingqiu];
    }
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}



//查询 这个比赛和期数的比赛信息
- (void)sendRequest:(NSString*)isEnded match:(NSString*)match chaxunQiShu:(NSString*)qishu
{
    [httprequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] jingcaiDuizhenChaXun:1 wanfa:(int)lotteryID isEnded:isEnded macth:match chaXunQiShu:qishu danOrGuo:@"gg"];
    self.httprequest = [ASIFormDataRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httprequest addCommHeaders];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest appendPostData:postData];
    [httprequest setUserInfo:[NSDictionary dictionaryWithObject:@"duizhen" forKey:@"key"]];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(requestSuccess:)];
    [httprequest startAsynchronous];
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

- (void)deleteContentOff:(NSString *)equal{
    
    NSArray * keys = [ContentOffDict allKeys];
    if (keys > 0) {
        for (NSString * keyStr in keys) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            if (strarr.count < 2) {
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
- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
    
    if (matchenum == matchEnumShengPingFuDanGuan||matchenum == matchEnumShengPingFuGuoGuan ) {
        if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
            xcount = 35+ ([cell.allTitleArray count]-1)*70;
        }else {
            xcount =[cell.allTitleArray count]*70;
            
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

#pragma mark -
#pragma mark Table view delegate

//- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
//    
//    [UIView beginAnimations:@"nddd" context:NULL];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//    NSInteger xcount = 0;
//    if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//        xcount = 35+ ([cell.allTitleArray count]-1)*70;
//    }else {
//        xcount =[cell.allTitleArray count]*70;
//        
//    }
//    NSLog(@"!11111111111111111");
//    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
//    [UIView commitAnimations];
//    
//   if(matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan){
//        
//        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//        jccell.XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew2.png");
//    }
//    
//}


//- (void)openCell:(CP_CanOpenCell *)cell{
//    
//    if (matchenum == matchEnumShengPingFuDanGuan || matchenum == matchEnumShengPingFuGuoGuan) {
////        buttonBool = NO;
//        NSLog(@"6666666666666666");
//        if (cell.butonScrollView.contentOffset.x > 0) {
////            buttonBool = YES;
//            NSLog(@"%f,%f",cell.butonScrollView.contentSize.width,cell.butonScrollView.contentSize.height);
//            
//            //            if ([cell.allTitleArray count] > 2) {
//            [UIView beginAnimations:@"ndd" context:NULL];
//            [UIView setAnimationDuration:.3];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            NSLog(@"!@222222222222222222222");
//            cell.butonScrollView.contentOffset = CGPointMake( 0, cell.butonScrollView.contentOffset.y);
//            [UIView commitAnimations];
//            
//            GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//            jccell.XIDANImageView.image = UIImageGetImageFromName(@"shengpingfunew1.png");
//            
//            
//            //            }
//            //            return;
//        }else{
//            [self performSelector:@selector(sleepOpenCell:) withObject:cell afterDelay:0.1];
//        }
//        return;
//    }
//    
//    NSIndexPath *indexPath = nil;
//    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
//    if (jccell.wangqibool) {
//        indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section];
//    }else{
//        indexPath = [NSIndexPath indexPathForRow:jccell.row.row inSection:jccell.row.section+2];
//        
//    }
//    
//    
//    cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//    if (cell.butonScrollView.hidden == NO) {
//        
//        zhankai[indexPath.section][indexPath.row] = 0;
//        [cell showButonScollWithAnime:NO];
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell showButonScollWithAnime:NO];
//        [cell hidenButonScollWithAnime:YES];
//    }
//    else {
//        
//        zhankai[indexPath.section][indexPath.row] = 1;
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell hidenButonScollWithAnime:NO];
//        [cell showButonScollWithAnime:YES];
//    }
//    return;
//    
//    
//}

- (void)openCellbifen:(CP_CanOpenCell *)cell{
   
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
    [chuantype release];
    [duoXuanArr release];
    [kongzhiType release];
    [kebianzidian release];
    [labelch release];
    [txtImage release];
    [textlabel release];
    [fbTextView release];
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
    [requestt clearDelegatesAndCancel];
    self.requestt = nil;
    
    [oneLabel release];
    [twoLabel release];
    [myTableView release];
    //[pkArray release];
    [pkbetdata release];
    [sanjiaoImageView release];
    [super dealloc];
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
    
        NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
        
        NSLog(@"%@", be.saishiid);
        sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
        [self.navigationController pushViewController:sachet animated:YES];
#endif
        [sachet release];
  
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrollView.y = %f", myTableView.contentOffset.y);
    if (matchenum == matchEnumShengPingFuGuoGuan || matchenum == matchEnumShengPingFuDanGuan ){
        
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

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
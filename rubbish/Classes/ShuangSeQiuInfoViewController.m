//
//  ShuangSeQiuInfoViewController.m
//  caibo
//
//  Created by yao on 12-5-22.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ShuangSeQiuInfoViewController.h"
#import "GC_HttpService.h"
#import "Info.h"
#import "GouCaiShuZiCell.h"
#import "GouCaiTiCaiCell.h"
#import "ChongZhiData.h"
#import "ColorView.h"
#import "caiboAppDelegate.h"
#import "ColorView.h"
#import "GC_UserInfo.h"
#import "Xieyi365ViewController.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GCJCBetViewController.h"
#import "GCBettingViewController.h"
#import "GC_BJDanChangViewController.h"
#import "HeMaiRenListViewController.h"
#import "GCHeMaiSendViewController.h"
#import "NewPostViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_BetData.h"
#import "GC_BetRecord.h"
#import "PKBetData.h"
#import "YuJiJinE.h"
#import "PreJiaoDianTabBarController.h"
#import "MyLottoryViewController.h"
#import "CP_UIAlertView.h"
#import "EidteBaoMiJieXie.h"
#import "Info.h"
#import "JiangLIJieXi.h"
#import "KFMessageBoxView.h"
#import "FAQView.h"
#import "TouzhujiqiaoViewController.h"
#import "ChedaJiexi.h"
#import "singletonData.h"
#import "scoreLiveTelecastViewController.h"
#import "LiveScoreViewController.h"
#import "GouCaiChaiCell.h"
#import "MatchDetailViewController.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "CheDanData.h"
#import "NSStringExtra.h"
#import "MobClick.h"
#import "QuestionViewController.h"
#import "SendMicroblogViewController.h"
#import "SharedDefine.h"
#import "HorseRaceViewController.h"

#define isHorse [BetInfo.lotteryName isEqualToString:Lottery_Name_Horse]

@implementation ShuangSeQiuInfoViewController
@synthesize BetInfo;
@synthesize BetDetailInfo;
@synthesize httpRequest;
@synthesize blueArray;
@synthesize redArray;
@synthesize isMine;
@synthesize guoguanme;
@synthesize hemaibool;
@synthesize issure,orderId,lottoryName,bendaZhongJiangJinE;
@synthesize canBack;
//@synthesize myTimer;
@synthesize shishiTimer;
@synthesize isJiangli;
@synthesize waibubool;
@synthesize chuanzhuihao;
@synthesize nikeName;
@synthesize myMatchInfo;
@synthesize delegate;
@synthesize yuE;
@synthesize isFromFlashAdAndLogin;
@synthesize isHongrenBang;
@synthesize canBuyAgain;

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

- (id)init {
    self = [super init];
    if (self) {
        canBack = YES;
        fengeArray = [[NSMutableArray alloc] init];
        isJiangli = NO;
        isJJYH = NO;
        isShishi = NO;
        isHongrenBang = NO;
        isLoading = NO;
        
        wanFaTitleArr = [[NSMutableArray alloc] initWithCapacity:10];
        modeArray = [[NSMutableArray alloc] initWithCapacity:10];
        
        canBuyAgain = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Balls

//判断是否为球号
- (BOOL)compareWithString:(NSString *)str
{
	NSString *lotteryId = self.BetDetailInfo.lotteryId;
	if ([lotteryId isEqualToString:@"001"]||[lotteryId isEqualToString:@"01"]){//双色球
		return (![str isEqualToString:@","] && ![str isEqualToString:@"@"]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"113"]){//大乐透
		return (![str isEqualToString:@"_"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"002"]){//3d
		return (![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"110"]){//七星彩
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"003"]){//七乐彩
		return (![str isEqualToString:@"_"]&&![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"111"]){//22选5
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"108"]){//排列3
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"109"]){//排列5
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
    else if ([lotteryId isEqualToString:@"010"]){//两步彩
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"006"]||[lotteryId isEqualToString:@"014"]){//时时彩
		return (![str isEqualToString:@"^"] && ![str isEqualToString:@","] ) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"123"] || [lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]){//11选5
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
    else if ([lotteryId isEqualToString:@"121"]){//广东11选5
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"016"]){//快乐8
		return (![str isEqualToString:@"|"]) ? YES: NO;
	}
	else if ([lotteryId isEqualToString:@"017"]){//PK拾
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
    else if([lotteryId isEqualToString:@"011"]){//快乐十分
        
        
        return (![str isEqualToString:@"-"] && ![str isEqualToString:@","]&&![str isEqualToString:@"|"]) ? YES: NO;
    }
    else if([lotteryId isEqualToString:@"122"]){//快乐扑克
        return YES;
    }
	return NO;
}

//提取分割线
- (void)getfenGe:(NSString *)str {
    
    //    return ;//暂时去除 屏蔽后可见
    NSString *lotteryId = self.BetDetailInfo.lotteryId;
    NSMutableArray *array = [NSMutableArray array];
    if ([lotteryId isEqualToString:@"001"]||[lotteryId isEqualToString:@"01"]){//双色球
        NSArray *array2 = [str componentsSeparatedByString:@"+"];
        NSArray *array3 =[[array2 objectAtIndex:0] componentsSeparatedByString:@"@"];
        if ([array3 count] > 1) {
            [array addObject:[NSString stringWithFormat:@"%i",(int)[[array3 objectAtIndex:0] length]/3 + 1]];
        }
        
	}
	else if ([lotteryId isEqualToString:@"113"]){//大乐透
        NSArray *array2 = [str componentsSeparatedByString:@"_:_"];
        for (int a = 0; a < [array2 count]; a ++) {
            NSArray *array3 = [[array2 objectAtIndex:a] componentsSeparatedByString:@"_,_"];
            if ([array3 count] > 1) {
                for (int i = 0; i<[array3 count]; i++) {
                    if (i == 0 && a == 0) {
                        [array addObject:[NSString stringWithFormat:@"%i",(int)[[array3 objectAtIndex:i] length]/3 + 1]];
                    }
                    else {
                        if (i == [array3 count]-1 && a == [array2 count] - 1) {
                            
                        }
                        else {
                            if ([[[array2 objectAtIndex:0] componentsSeparatedByString:@"_,_"] count] > 1) {
                                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array3 objectAtIndex:i] length]/3 +1 +(int)[[array lastObject] intValue]]];
                            }
                            else {
                                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array3 objectAtIndex:i] length]/3 +1 +(int)[[[array2 objectAtIndex:0] componentsSeparatedByString:@"_"] count]]];
                            }
                            
                        }
                    }
                    
                }
            }
        }
        if ([array count] >= 3) {
            [array removeObjectAtIndex:1];
        }
	}
	else if ([lotteryId isEqualToString:@"002"]){//3d
        
        
        NSArray *array2 = [str componentsSeparatedByString:@","];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]+[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
        
	}
	else if ([lotteryId isEqualToString:@"110"]){//七星彩
        NSArray *array2 = [str componentsSeparatedByString:@"*"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]+[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
        
	}
	else if ([lotteryId isEqualToString:@"003"]){//七乐彩
        NSArray *array2 = [str componentsSeparatedByString:@"_,_"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]/3 + 1]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]/3 + 1+[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
        
	}
	else if ([lotteryId isEqualToString:@"111"]){//22选5
        
	}
	else if ([lotteryId isEqualToString:@"108"]){//排列3
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
            NSArray *array2 = [str componentsSeparatedByString:@"*"];
            for (int i = 0; i<[array2 count]-1; i++) {
                if (i == 0) {
                    [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
                }
                else {
                    [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]+[[array objectAtIndex:i-1] intValue]]];
                }
                
            }
        }
        
	}
	else if ([lotteryId isEqualToString:@"109"]){//排列5
        NSArray *array2 = [str componentsSeparatedByString:@"*"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]+[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
        
	}else if([lotteryId isEqualToString:@"011"]){//快乐十分
        
        NSArray *array2 = [str componentsSeparatedByString:@"|"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]+[[array objectAtIndex:i-1] intValue]]];
            }
        }
    }
    else if ([lotteryId isEqualToString:@"010"]){//两步彩
        
	}
	else if ([lotteryId isEqualToString:@"006"] || [lotteryId isEqualToString:@"014"]){//时时彩
        NSArray *array2 = [str componentsSeparatedByString:@","];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                
                NSString * zifustr = [array2 objectAtIndex:i];
                if ([zifustr rangeOfString:@"^"].location != NSNotFound) {
                    NSArray * zifuarr = [zifustr componentsSeparatedByString:@"^"];
                    [array addObject:[NSString stringWithFormat:@"%i",(int)[zifuarr count]]];
                }else{
                    [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
                }
                
                
            }
            else {
                
                NSString * zifustr = [array2 objectAtIndex:i];
                if ([zifustr rangeOfString:@"^"].location != NSNotFound) {
                    NSArray * zifuarr = [zifustr componentsSeparatedByString:@"^"];
                    if ([array count] > 0) {
                        [array addObject:[NSString stringWithFormat:@"%i",(int)[zifuarr count]+(int)[[array objectAtIndex:[array count]-1] intValue]]];
                    }else{
                        [array addObject:[NSString stringWithFormat:@"%i",(int)[zifuarr count]]];
                    }
                    
                }else{
                    
                    
                    if ([array count] > 0) {
                        [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]+(int)[[array objectAtIndex:[array count]-1] intValue]]];
                    }else{
                        [array addObject:[NSString stringWithFormat:@"%i",(int)[[array2 objectAtIndex:i] length]]];
                    }
                    
                    
                }
                
            }
            
        }
	}
	else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"121"] || [lotteryId isEqualToString:@"123"] || [lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]){//11选5
        
        NSArray *array2 = [str componentsSeparatedByString:@"|"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]+(int)[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
		
	}
	else if ([lotteryId isEqualToString:@"016"]){//快乐8
		
	}
	else if ([lotteryId isEqualToString:@"017"]){//PK拾
		
	}
    else if ([lotteryId isEqualToString:@"012"] || [lotteryId isEqualToString:@"013"] || [lotteryId isEqualToString:@"019"] || [lotteryId isEqualToString:LOTTERY_ID_JILIN] || [lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//快3 江苏快三
        NSArray *array2 = [str componentsSeparatedByString:@"|"];
        for (int i = 0; i<[array2 count]-1; i++) {
            if (i == 0) {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]]];
            }
            else {
                [array addObject:[NSString stringWithFormat:@"%i",(int)[[[array2 objectAtIndex:i] componentsSeparatedByString:@","] count]+(int)[[array objectAtIndex:i-1] intValue]]];
            }
            
        }
    }
    //    array = nil;
    [fengeArray addObject:array];
    
}


//提取号码 时时彩 下划线变空格
- (NSMutableArray *)shiShiReArrayWithNumber:(NSString *)strNumber lenOfNumber:(NSInteger)len
{
	NSMutableArray *arrayBall = [[[NSMutableArray alloc] init] autorelease];
	NSRange rang;
	rang.location = 0;
    NSInteger i= 0;
    
	while (rang.location < ([strNumber length]-(len-1))) {
		rang.length = 1;
		NSString *rStr = [strNumber substringWithRange:rang];
		if ([self compareWithString:rStr]) {
			rang.length = len;
			NSString *s = [strNumber substringWithRange:rang];
            if ([s isEqualToString:@"_"]) {
                s = @" ";
            }
			[arrayBall addObject:s];
			rang.location += len;
            i++;
		}
		else {
			rang.location += 1;
		}
	}
	return arrayBall;
}

//提取号码
- (NSMutableArray *)reArrayWithNumber:(NSString *)strNumber lenOfNumber:(NSInteger)len
{
	NSMutableArray *arrayBall = [[[NSMutableArray alloc] init] autorelease];
	NSRange rang;
	rang.location = 0;
    NSInteger i= 0;
    
    if (strNumber && [strNumber length]) {
        while (rang.location < ([strNumber length]-(len-1))) {
            rang.length = 1;
            NSString *rStr = [strNumber substringWithRange:rang];
            if ([self compareWithString:rStr]) {
                rang.length = len;
                NSString *s = [strNumber substringWithRange:rang];
                [arrayBall addObject:s];
                rang.location += len;
                i++;
            }
            else {
                rang.location += 1;
            }
        }
    }
	
	return arrayBall;
}

- (void)checkisShuziOrNot {
	isShuZi = YES;
	NSString *lotteryId = self.BetDetailInfo.lotteryId;
	if ([lotteryId isEqualToString:@"001"]||[lotteryId isEqualToString:@"01"]) {//双色球
		isShuZi = YES;
	}
	else if ([lotteryId isEqualToString:@"113"]) {//大乐透
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"002"]) {//3d
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"110"]) {//七星彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"003"]) {//七乐彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"111"]) {//22选5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"108"]) {//排列3
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"109"]) {//排列5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"010"]) {//两步彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"006"] ||[lotteryId isEqualToString:@"014"]) {//时时彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"011"] || [lotteryId isEqualToString:@"123"] || [lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {//11选5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"016"]) {//快乐8
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"017"]) {//PK拾
		isShuZi = YES;
		
	}
    else if ([lotteryId isEqualToString:@"012"]) {//快3
		isShuZi = YES;
		
	}
    else if ([lotteryId isEqualToString:@"013"]) {//江苏快3
		isShuZi = YES;
		
	}
    else if ([lotteryId isEqualToString:@"122"]) {//快乐扑克
        isShuZi = YES;
    }
    else if ([lotteryId isEqualToString:@"121"]) {//广东11选5
        isShuZi = YES;
    }
    else if ([lotteryId isEqualToString:@"019"]) {//湖北快3
		isShuZi = YES;
	}
    else if ([lotteryId isEqualToString:LOTTERY_ID_JILIN]) {//吉林快3
        isShuZi = YES;
    }
    else if ([lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//吉林快3
        isShuZi = YES;
    }
	else {
		isShuZi = NO;
		return;
	}
}

- (void)getBallArrayForm:(NSArray *)betContentArray {
	if (self.redArray != nil || self.blueArray != nil) {
		self.redArray = nil;
		self.blueArray = nil;
	}
	NSMutableArray *redSecArray = [[NSMutableArray alloc] init];
	NSMutableArray *blueSecArray = [[NSMutableArray alloc] init];
	NSString *lotteryId = self.BetDetailInfo.lotteryId;
    [fengeArray removeAllObjects];
    
    [wanFaTitleArr removeAllObjects];
    [modeArray removeAllObjects];
    
	for (int i = 0; i < [betContentArray count]; i++) {
		NSString *strBall = [betContentArray objectAtIndex:i];//1个4+n
		
		NSArray *secArray = [strBall componentsSeparatedByString:@";"];
        if (isHorse) {
            secArray = [strBall componentsSeparatedByString:@"^"];
        }
		
		for (int j = 0; j < [secArray count]; j++) {
			NSString *strBet = [secArray objectAtIndex:j];//1注
			NSLog(@"%@",strBet);
			NSArray *array = [strBet componentsSeparatedByString:@"-"];
            NSString *ball = @"";//除去注数的球号(包括符号)
            if ([array count] >= 1) {
                ball = [array objectAtIndex:0];//除去注数的球号(包括符号)
            }
			
			[self getfenGe:ball];
			if ([lotteryId isEqualToString:@"001"]||[lotteryId isEqualToString:@"01"]) {//双色球
				
				NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
                if ([numberArray count] > 1) {
                    NSString *redNumber = [[numberArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
                    NSString *blueNumber = [[numberArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:2];
                    [redSecArray addObject:arrayRed];//存 红球
                    
                    NSArray *arrayBlue = [blueNumber componentsSeparatedByString:@","];
                    [blueSecArray addObject:arrayBlue];//存 蓝球
                }
                else if (isDanShi) {//单式
                    NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
                    if ([arrayRed count] == 7) {
                        NSMutableArray *arrayBlue = [NSMutableArray arrayWithObjects:[arrayRed objectAtIndex:6], nil];
                        [arrayRed removeLastObject];
                        [redSecArray addObject:arrayRed];//存 红球
                        [blueSecArray addObject:arrayBlue];//存 蓝球
                    }
                    
                    
                }

			}
			else if ([lotteryId isEqualToString:@"113"]&&([self.BetDetailInfo.wanfaId isEqualToString:@"00" ]||[self.BetDetailInfo.wanfaId isEqualToString:@"01" ])) {//大乐透
				
				NSArray *numberArray = [ball componentsSeparatedByString:@"_:_"];
                if ([numberArray count] > 1) {
                    NSString *redNumber = [numberArray objectAtIndex:0];
                    NSString *blueNumber = [numberArray objectAtIndex:1];
                    NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:2];
                    [redSecArray addObject:arrayRed];
                    
                    NSMutableArray *arrayBlue = [self reArrayWithNumber:blueNumber lenOfNumber:2];
                    [blueSecArray addObject:arrayBlue];
                }
                else if (isDanShi) {//单式
                    NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
                    if ([arrayRed count] == 7) {
                        NSMutableArray *arrayBlue = [NSMutableArray arrayWithObjects:[arrayRed objectAtIndex:5],[arrayRed objectAtIndex:6], nil];
                        [arrayRed removeObjectsInArray:arrayBlue];
                        [redSecArray addObject:arrayRed];//存 红球
                        [blueSecArray addObject:arrayBlue];//存 蓝球
                    }
                    
                    
                }

			}
			else if ([lotteryId isEqualToString:@"002"]) {//3d
				if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    NSMutableArray *arrayRed = [NSMutableArray arrayWithObject:ball];
                    [redSecArray addObject:arrayRed];
                }
                else {
                    NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
                    [redSecArray addObject:arrayRed];
                }
				
				
			}
			else if ([lotteryId isEqualToString:@"110"]) {//七星彩
				
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:@"003"]) {//七乐彩
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:@"111"]) {//22选5
				
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:@"108"]) {//排列3
				
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
                if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"] && [arrayRed count] > 1) {
                    arrayRed = [NSMutableArray arrayWithArray:[ball componentsSeparatedByString:@","]];
                }
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:@"109"]) {//排列5
				
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:@"010"]) {//两步彩
				
				NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
                if ([numberArray count] >= 1) {
                    NSString *redNumber = [numberArray objectAtIndex:0];
                    NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:1];
                    [redSecArray addObject:arrayRed];//存 红球
                }
				
				
				
				if ([numberArray count] > 1) {
					NSString *blueNumber = [numberArray objectAtIndex:1];
					NSArray *arrayBlue = [blueNumber componentsSeparatedByString:@"|"];
					[blueSecArray addObject:arrayBlue];//存 蓝球
				}
			}
			else if ([lotteryId isEqualToString:@"006"] ||[lotteryId isEqualToString:@"014"]) {//时时彩
				
				NSMutableArray *arrayRed = [self shiShiReArrayWithNumber:ball lenOfNumber:1];
				[redSecArray addObject:arrayRed];
				
			}
			else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"123"] || [lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {//11选5
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
				
                if (isHorse && [BetInfo.mode isEqualToString:@"0"]) {
                    NSString * wanFaStr = @"";
                    if (array.count > 1) {
                        wanFaStr = [[array objectAtIndex:1] substringToIndex:2];
                        [modeArray addObject:wanFaStr];
                        if ([wanFaStr isEqualToString:@"01"]) {
                            wanFaStr = @"独赢";
                        }else if ([wanFaStr isEqualToString:@"11"]) {
                            wanFaStr = @"连赢";
                        }else if ([wanFaStr isEqualToString:@"12"]) {
                            wanFaStr = @"单T";
                        }else{
                            wanFaStr = @"";
                        }
                        if ([wanFaTitleArr containsObject:wanFaStr]) {
                            [wanFaTitleArr addObject:@""];
                        }else{
                            [wanFaTitleArr addObject:wanFaStr];
                        }
                    }
                }
			}
            else if ([lotteryId isEqualToString:@"011"]) {//快乐十分
                NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
            }
            else if ([lotteryId isEqualToString:@"121"]) {//广东11选5
                NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
            }
			else if ([lotteryId isEqualToString:@"016"]) {//快乐8
				
				NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
				[redSecArray addObject:arrayRed];
				
				//飞盘号
				NSMutableArray *arrayBlue = [[NSMutableArray alloc] init];
				NSString *feipan = [array objectAtIndex:1];
				NSArray *fArray = [feipan componentsSeparatedByString:@"+"];
				if ([fArray count] < 2) {
					[arrayBlue addObject:@"0"];
				}
				else {
					NSString *fp = @"";
                    if ([fArray count] >1) {
                        fp = [fArray objectAtIndex:1];
                    }
					[arrayBlue addObject:fp];
				}
				[blueSecArray addObject:arrayBlue];
                [arrayBlue release];
			}
			else if ([lotteryId isEqualToString:@"017"]) {//PK拾
				
				NSArray *arrayRed = [ball componentsSeparatedByString:@"|"];
				[redSecArray addObject:arrayRed];
			}
            else if ([lotteryId isEqualToString:@"012"] || [lotteryId isEqualToString:@"013"] || [lotteryId isEqualToString:@"019"] || [lotteryId isEqualToString:LOTTERY_ID_JILIN] || [lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//快3 ，江苏快3
				
				NSArray *arrayRed = [[ball stringByReplacingOccurrencesOfString:@"|" withString:@","] componentsSeparatedByString:@","];
				[redSecArray addObject:arrayRed];
			}
            else if ([lotteryId isEqualToString:@"122"]) {//快乐扑克
                NSArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
                //                NSRange rang;
                //                rang.location = 0;
                //                NSInteger i= 0;
                //
                //                while (rang.location < [ball length]- 2) {
                //                    rang.length = 2;
                //                    NSString *rStr = [ball substringWithRange:rang];
                //                    if ([self compareWithString:rStr]) {
                //                        rang.length = 2;
                //                        NSString *s = [ball substringWithRange:rang];
                //                        [arrayRed addObject:s];
                //                        rang.location += 2;
                //                        i++;
                //                    }
                //                    else {
                //                        rang.location += 1;
                //                    }
                //                }
				[redSecArray addObject:arrayRed];
            }
			else {
				[redSecArray release];
				[blueSecArray release];
				return;
			}
			
		}
	}
    self.redArray = nil;
    self.blueArray = nil;
    NSLog(@"redsec = %@", redSecArray);
	self.redArray = (NSArray *)redSecArray;
	self.blueArray = (NSArray *)blueSecArray;
    NSLog(@"redarr = %@", self.redArray);
	[redSecArray release];
	[blueSecArray release];
}

- (TiCaiType)getTiCaiMoban:(NSString *)lottory {
	if ([lottory  isEqualToString:@"301"]||[lottory isEqualToString:@"300"]||[lottory  isEqualToString:@"302"]||[lottory  isEqualToString:@"303"]) {
		return ShengFuCai;
	}
	else if ([lottory  isEqualToString:@"400"]){
		return BeiDan;
	}
    else if ([lottory  isEqualToString:@"40006"]) {
        return AoYun1;
    }
    else if ([lottory  isEqualToString:@"40007"]) {
        return AoYun2;
    }
    else if ([lottory  isEqualToString:@"40008"]) {
        return AoYun3;
    }
    else if ([lottory isEqualToString:@"200"]) {
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]) {
            return LanQiuRangfen;
        }
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
            return LanQiuShengfu;
            
        }
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"09"]) {
            return LanQiuDaxiafen;
            
        }
        
        return LanQiufencha;
        
    }
    else if ([lottory isEqualToString:@"203"]) {
        return LanQiuHunTou;
    }
    else if ([lottory isEqualToString:@"200"]||[lottory isEqualToString:@"201"]) {
        return JingCaiZuqiu;
    }
    else if ([lottory isEqualToString:@"202"]){
        if ([self.BetDetailInfo.OutorderId rangeOfString:@"2x1"].location != NSNotFound) {
            return JingCaiZuqiu;
        }
        return ZuQiuDahunTou;
    }
    
	return Unsuort;
}

#pragma mark -
#pragma mark Action

- (void)setTitTile:(UIView *)heardView Heigt:(NSInteger)height {
    if (isShuZi) {
        UIImageView *v = [[UIImageView alloc] init];
        v.frame = CGRectMake(10, 0, 300, height + 31);
        [heardView addSubview:v];
        v.image = UIImageGetImageFromName(@"XQCELlBG960.png");
        UIImageView *v2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 29, 298, 2)];
        v2.image = [UIImageGetImageFromName(@"FGX.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        [v addSubview:v2];
        [v2 release];
        [v release];
        UILabel *touzhuLabel = [[UILabel alloc] init];
        touzhuLabel.frame = CGRectMake(20, height + 7, 120, 17);
        touzhuLabel.backgroundColor = [UIColor clearColor];
        touzhuLabel.font = [UIFont boldSystemFontOfSize:15];
        touzhuLabel.text = @"投注";
        touzhuLabel.textColor = [UIColor colorWithRed:33/255.0 green:53/255.0 blue:66/255.0 alpha:1];
        [heardView addSubview:touzhuLabel];
        [touzhuLabel release];
        height = height + 31;
        heardView.frame = CGRectMake(0, 0, 320, height);
    }
    return;
    //	UIImageView *titleImageM = [[UIImageView alloc] init];
    //	titleImageM.frame = CGRectMake(7, height , 305, 18);
    //	titleImageM.image = UIImageGetImageFromName(@"GC_texBg2_m.png");
    //	[heardView addSubview:titleImageM];
    //
    //	UILabel *label1 = [[UILabel alloc] init];
    //	label1.backgroundColor = [UIColor clearColor];
    //	label1.textColor = [UIColor blueColor];
    //	label1.textAlignment = NSTextAlignmentCenter;
    //	label1.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label1];
    //
    //	UILabel *label2 = [[UILabel alloc] init];
    //	label2.backgroundColor = [UIColor clearColor];
    //	label2.textColor = [UIColor blueColor];
    //	label2.textAlignment = NSTextAlignmentCenter;
    //	label2.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label2];
    //
    //	UILabel *label3 = [[UILabel alloc] init];
    //	label3.backgroundColor = [UIColor clearColor];
    //	label3.textColor = [UIColor blueColor];
    //	label3.textAlignment = NSTextAlignmentCenter;
    //	label3.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label3];
    //
    //	UILabel *label4 = [[UILabel alloc] init];
    //	label4.backgroundColor = [UIColor clearColor];
    //	label4.textColor = [UIColor blueColor];
    //	label4.textAlignment = NSTextAlignmentCenter;
    //	label4.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label4];
    //
    //	UILabel *label5 = [[UILabel alloc] init];
    //	label5.backgroundColor = [UIColor clearColor];
    //	label5.textColor = [UIColor blueColor];
    //	label5.textAlignment = NSTextAlignmentCenter;
    //	label5.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label5];
    //
    //	UILabel *label6 = [[UILabel alloc] init];
    //	label6.backgroundColor = [UIColor clearColor];
    //	label6.textColor = [UIColor blueColor];
    //	label6.textAlignment = NSTextAlignmentCenter;
    //	label6.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label6];
    //
    //	UILabel *label7 = [[UILabel alloc] init];
    //	label7.backgroundColor = [UIColor clearColor];
    //	label7.textColor = [UIColor blueColor];
    //	label7.textAlignment = NSTextAlignmentCenter;
    //	label7.font = [UIFont systemFontOfSize:13];
    //	[titleImageM addSubview:label7];
    //
    //	switch (ticaiType) {
    //		case ShengFuCai:
    //		{
    //			label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //			label2.frame = CGRectMake(30, 0, 89, 16);
    //			label2.text = @"对阵";
    //
    //			label3.frame = CGRectMake(119, 0, 65, 16);
    //			label3.text = @"时间";
    //
    //			label4.frame = CGRectMake(184, 0, 29, 16);
    //			label4.text = @"比分";
    //
    //			label5.frame = CGRectMake(213, 0, 32, 16);
    //			label5.text = @"彩果";
    //
    //			label6.frame = CGRectMake(245, 0, 34, 16);
    //			label6.text = @"投注";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //		}
    //			break;
    //
    //		case JingCaiZuqiu:
    //		{
    //			label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //			label2.frame = CGRectMake(30, 0, 89, 16);
    //			label2.text = @"对阵";
    //
    //			label3.frame = CGRectMake(119, 0, 33, 16);
    //			label3.text = @"让球";
    //
    //			label4.frame = CGRectMake(152, 0, 32, 16);
    //			label4.text = @"比分";
    //
    //			label5.frame = CGRectMake(184, 0, 32, 16);
    //			label5.text = @"彩果";
    //
    //			label6.frame = CGRectMake(216, 0, 63, 16);
    //			label6.text = @"投注赔率";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //		}
    //			break;
    //
    //		case BeiDan:
    //		{
    //			label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //			UILabel *label8 = [[UILabel alloc] init];
    //			label8.backgroundColor = [UIColor clearColor];
    //			label8.textColor = [UIColor blueColor];
    //			label8.textAlignment = NSTextAlignmentCenter;
    //			label8.font = [UIFont systemFontOfSize:13];
    //			[titleImageM addSubview:label8];
    //			label8.text = @"对阵";
    //			label8.frame = CGRectMake(30, 0, 56, 16);
    //
    //			UIImageView *image7 = [[UIImageView alloc] init];
    //			image7.backgroundColor = [UIColor clearColor];
    //			image7.image = UIImageGetImageFromName(@"GC_shu08.png");
    //			image7.frame = CGRectMake(label8.frame.origin.x, -6, 1, 24);
    //			[titleImageM addSubview:image7];
    //			[image7 release];
    //
    //			[label8 release];
    //
    //			label2.frame = CGRectMake(86, 0, 33, 16);
    //			label2.text = @"让球";
    //
    //			label3.frame = CGRectMake(119, 0, 33, 16);
    //			label3.text = @"比分";
    //
    //			label4.frame = CGRectMake(152, 0, 32, 16);
    //			label4.text = @"彩果";
    //
    //			label5.frame = CGRectMake(184, 0, 32, 16);
    //			label5.text = @"投注";
    //
    //			label6.frame = CGRectMake(216, 0, 63, 16);
    //			label6.text = @"最终赔率";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //		}
    //			break;
    //        case AoYun1:{
    //            label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //			label2.frame = CGRectMake(30, 0, 50, 16);
    //			label2.text = @"比赛";
    //
    //			label3.frame = CGRectMake(80, 0, 75, 16);
    //			label3.text = @"对阵";
    //
    //			label4.frame = CGRectMake(155, 0, 35, 16);
    //			label4.text = @"赔率";
    //
    //			label5.frame = CGRectMake(190, 0, 35, 16);
    //			label5.text = @"彩果";
    //
    //			label6.frame = CGRectMake(225, 0, 54, 16);
    //			label6.text = @"投注";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"让球";
    //        }
    //            break;
    //        case AoYun2:{
    //            label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //			label2.frame = CGRectMake(30, 0, 130, 16);
    //			label2.text = @"比赛简称";
    //
    //			label3.frame = CGRectMake(160, 0, 40, 16);
    //			label3.text = @"彩果";
    //
    //			label4.frame = CGRectMake(200, 0, 60, 16);
    //			label4.text = @"投注";
    //
    //			label5.frame = CGRectMake(260, 0, 60, 16);
    //			label5.text = @"最终赔率";
    //
    //        }
    //            break;
    //        case AoYun3:{
    //            label1.frame = CGRectMake(0, 0, 30, 16);
    //            label1.text = @"场次";
    //
    //            label2.frame = CGRectMake(30, 0, 140, 16);
    //            label2.text = @"比赛简称";
    //
    //            label3.frame = CGRectMake(170, 0, 50, 16);
    //            label3.text = @"彩果";
    //
    //            label4.frame = CGRectMake(220, 0, 100, 16);
    //            label4.text = @"投注";
    //
    //        }
    //            break;
    //        case LanQiufencha:
    //		{
    //			label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //
    //			label3.frame = CGRectMake(149, 0, 33, 16);
    //
    //            label3.text = @"比分";
    //
    //			label4.frame = CGRectMake(182, 0, 32, 16);
    //			label4.text = @"彩果";
    //
    //			label5.frame = CGRectMake(214, 0, 65, 16);
    //			label5.text = @"投注";
    //
    //			label6.frame = CGRectMake(30, 0, 119, 16);
    //			label6.text = @"对阵";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //		}
    //			break;
    //        case LanQiuRangfen: {
    //            label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //
    //			label2.frame = CGRectMake(96, 0, 53, 16);
    //
    //            if ([self.BetDetailInfo.wanfaId isEqualToString:@"09"]) {
    //                label2.text = @"预设总分";
    //            }
    //            else {
    //                label2.text = @"让分";
    //            }
    //
    //			label3.frame = CGRectMake(149, 0, 33, 16);
    //
    //            if ([self.BetDetailInfo.wanfaId isEqualToString:@"09"]) {
    //                label3.text = @"总分";
    //            }
    //            else {
    //                label3.text = @"比分";
    //            }
    //
    //			label4.frame = CGRectMake(182, 0, 45, 16);
    //			label4.text = @"彩果";
    //
    //			label5.frame = CGRectMake(227, 0, 52, 16);
    //			label5.text = @"投注";
    //
    //			label6.frame = CGRectMake(30, 0, 66, 16);
    //			label6.text = @"对阵";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //        }
    //            break;
    //
    //        case LanQiuShengfu:
    //		{
    //			label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //
    //			label3.frame = CGRectMake(149, 0, 33, 16);
    //            label3.text = @"比分";
    //
    //			label4.frame = CGRectMake(182, 0, 32, 16);
    //			label4.text = @"彩果";
    //
    //			label5.frame = CGRectMake(214, 0, 65, 16);
    //			label5.text = @"投注";
    //
    //			label6.frame = CGRectMake(30, 0, 119, 16);
    //			label6.text = @"对阵";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //		}
    //			break;
    //
    //        case LanQiuDaxiafen: {
    //            label1.frame = CGRectMake(0, 0, 30, 16);
    //			label1.text = @"场次";
    //
    //
    //			label2.frame = CGRectMake(96, 0, 53, 16);
    //
    //            label2.text = @"预设总分";
    //
    //			label3.frame = CGRectMake(149, 0, 33, 16);
    //
    //
    //            label3.text = @"总分";
    //
    //			label4.frame = CGRectMake(182, 0, 45, 16);
    //			label4.text = @"彩果";
    //
    //			label5.frame = CGRectMake(227, 0, 52, 16);
    //			label5.text = @"投注";
    //
    //			label6.frame = CGRectMake(30, 0, 66, 16);
    //			label6.text = @"对阵";
    //
    //			label7.frame = CGRectMake(279, 0, 26, 16);
    //			label7.text = @"胆";
    //        }
    //            break;
    //		default:
    //			break;
    //	}
    //
    //	UIImageView *image1 = [[UIImageView alloc] init];
    //	image1.backgroundColor = [UIColor clearColor];
    //	image1.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image1.frame = CGRectMake(label2.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image1];
    //
    //	UIImageView *image2 = [[UIImageView alloc] init];
    //	image2.backgroundColor = [UIColor clearColor];
    //	image2.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image2.frame = CGRectMake(label3.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image2];
    //
    //	UIImageView *image3 = [[UIImageView alloc] init];
    //	image3.backgroundColor = [UIColor clearColor];
    //	image3.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image3.frame = CGRectMake(label4.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image3];
    //
    //	UIImageView *image4 = [[UIImageView alloc] init];
    //	image4.backgroundColor = [UIColor clearColor];
    //	image4.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image4.frame = CGRectMake(label5.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image4];
    //
    //	UIImageView *image5 = [[UIImageView alloc] init];
    //	image5.backgroundColor = [UIColor clearColor];
    //	image5.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image5.frame = CGRectMake(label6.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image5];
    //
    //	UIImageView *image6 = [[UIImageView alloc] init];
    //	image6.backgroundColor = [UIColor clearColor];
    //	image6.image = UIImageGetImageFromName(@"GC_shu08.png");
    //	image6.frame = CGRectMake(label7.frame.origin.x, -6, 1, 24);
    //	[titleImageM addSubview:image6];
    //
    //	[image1 release];
    //	[image2 release];
    //	[image3 release];
    //	[image4 release];
    //	[image5 release];
    //	[image6 release];
    //
    //	[label1 release];
    //	[label2 release];
    //	[label3 release];
    //	[label4 release];
    //	[label5 release];
    //	[label6 release];
    //	[label7 release];
    //	//		UILabel *
    //	[titleImageM release];
    //    heardView.frame = CGRectMake(0, 0, 320, height);
	
}

- (void)resetHeadViewHeightWithHight:(CGFloat)height clickeView:(UIView *)sender {
    UIView *v = tableheadView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, v.frame.size.width, height + v.frame.size.height);
    myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
    for (UIView *sv in [v subviews]) {
        if (([sv isKindOfClass:[CPZhanKaiView class]] && sv.tag > sender.tag)||sv.tag == 1123) {
            sv.frame = CGRectMake(sv.frame.origin.x, sv.frame.origin.y + height, sv.frame.size.width, sv.frame.size.height);
        }
    }
    [UIView commitAnimations];
    //    [myTableView setTableHeaderView:v];
}


- (NSString *)getImageByZhanji:(NSInteger)i {
    switch (i) {
        case 0:
            return @"gc_jg.png";
            break;
        case 1:
            return @"gc_zs.png";
            break;
        case 2:
            return @"gc_jx.png";
            break;
        case 3:
            return @"gc_lg.png";
            break;
        case 4:
            return @"gc_ls.png";
            break;
        case 5:
            return @"gc_lx.png";
            break;
            
        default:
            break;
    }
    return @"";
}

//上面 中奖情况
- (void)setHeadView {
	isBaomi = NO;
	//    ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	//    coloview.backgroundColor = [UIColor whiteColor];
	//    coloview.text = self.BetDetailInfo.zhongjiangInfo;
	//    [self.mainView addSubview:coloview];
	//    [coloview release];
    
	tableheadView = [[UIView alloc] init];
    tableheadView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
	NSInteger height = 0;
    
    if ([self.BetDetailInfo.other isEqualToString:@"1"]) {
        CPZhanKaiView *zhanKaiView = [[CPZhanKaiView alloc] init];
        zhanKaiView.frame = CGRectMake(10, height, 300, 45);
        zhanKaiView.normalHeight = 45;
        zhanKaiView.zhankaiHeight = 99;
        zhanKaiView.zhankaiDelegate = self;
        zhanKaiView.tag = 0;
        zhanKaiView.canZhanKaiByTouch = NO;
        
        UIImageView *imageView = [[UIImageView alloc] init];
		[tableheadView addSubview:imageView];
		imageView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        imageView.frame = CGRectMake(0, 0, 300, 44);
        [zhanKaiView addSubview:imageView];
        [imageView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 200, 13)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:10];
        label.textColor = [UIColor redColor];
        [zhanKaiView addSubview:label];
        label.text = @"因为您在足彩中的优秀表现，本站给予奖励";
        [label release];
        
        lingJiangBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [zhanKaiView addSubview:lingJiangBtn];
        [tableheadView addSubview:zhanKaiView];
        [lingJiangBtn addTarget:self action:@selector(lingJiang) forControlEvents:UIControlEventTouchUpInside];
        lingJiangBtn.frame = CGRectMake(210, 9, 76, 27);
        [lingJiangBtn loadButonImage:@"TYD960.png" LabelName:@"领取奖励"];
        lingJiangBtn.buttonName.shadowColor = [UIColor grayColor];
        lingJiangBtn.buttonName.shadowOffset = CGSizeMake(0, 1);
        lingJiangBtn.buttonName.textColor = [UIColor whiteColor];
        [zhanKaiView release];
        
        UIImageView *imageView3 = [[UIImageView alloc] init];
		[tableheadView addSubview:imageView3];
        zhanKaiView.fengeImageView = imageView3;
        imageView3.frame = CGRectMake(0, 40, 300, 5);
        [zhanKaiView addSubview:imageView3];
        [imageView3 release];
        
        height = height + 45 + 10;
    }
    
	if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"]) {
        UIView *zhongView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 94)];
        zhongView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [tableheadView addSubview:zhongView];
        zhongView.tag = 1;
        [zhongView release];
        if ([self.BetDetailInfo.jiangMoney floatValue] && ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"])) {
            if (![self.BetDetailInfo.zhongjiangInfo isEqualToString:BetDetailInfo.jiangMoney] && [self.BetDetailInfo.zhongjiangInfo length] &&![self.BetDetailInfo.zhongjiangInfo isEqualToString:@"null"]) { //交税
                ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 13, 150, 40)];
                coloview.backgroundColor = [UIColor clearColor];
                coloview.userInteractionEnabled = NO;
                coloview.font = [UIFont systemFontOfSize:24];
                coloview.colorfont = [UIFont boldSystemFontOfSize:30];
                coloview.pianyiHeight = 5;
                coloview.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
                
                [zhongView addSubview:coloview];
                [coloview release];
                if ([self.BetInfo.lotteryMoney floatValue]) {//有本单奖金的
                    coloview.frame = CGRectMake(5, 20, 150, 40);
                    coloview.font = [UIFont systemFontOfSize:12];
                    coloview.colorfont = [UIFont boldSystemFontOfSize:16];
                    if ([BetDetailInfo.zhongjiangInfo floatValue]) {
                        coloview.text = [NSString stringWithFormat:@"本单中奖 <%.2f> 元",[self.BetInfo.lotteryMoney floatValue] * [BetDetailInfo.jiangMoney floatValue] / [BetDetailInfo.zhongjiangInfo floatValue]];
                    }
                    else {
                        coloview.text = [NSString stringWithFormat:@"本单中奖 <-> 元"];
                    }
                    
                    coloview.frame = CGRectMake(5, 20, 150 , 40);
                    coloview.font = [UIFont systemFontOfSize:12];
                    coloview.pianyiHeight = 3;
                    coloview.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview.colorfont = [UIFont systemFontOfSize:16];
                    ColorView * coloview2 = [[ColorView alloc] initWithFrame:CGRectMake(5, 45, 150, 40)];
                    coloview2.backgroundColor = [UIColor clearColor];
                    coloview2.userInteractionEnabled = NO;
                    coloview2.font = [UIFont systemFontOfSize:10];
                    coloview2.colorfont = [UIFont boldSystemFontOfSize:12];
                    coloview2.pianyiHeight = 0;
                    coloview2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview2.text = [NSString stringWithFormat:@"税后本单 <%@> 元",self.BetInfo.lotteryMoney];
                    [zhongView addSubview:coloview2];
                    [coloview2 release];
                    
                    ColorView * coloview3 = [[ColorView alloc] initWithFrame:CGRectMake(165, 20, 150, 40)];
                    coloview3.backgroundColor = [UIColor clearColor];
                    coloview3.userInteractionEnabled = NO;
                    coloview3.font = [UIFont systemFontOfSize:12];
                    coloview3.colorfont = [UIFont boldSystemFontOfSize:16];
                    coloview3.pianyiHeight = 3;
                    coloview3.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview3.text = [NSString stringWithFormat:@"总奖金 <%@> 元",self.BetDetailInfo.jiangMoney];
                    [zhongView addSubview:coloview3];
                    [coloview3 release];
                    
                    ColorView * coloview4 = [[ColorView alloc] initWithFrame:CGRectMake(165, 45, 150, 40)];
                    coloview4.backgroundColor = [UIColor clearColor];
                    coloview4.userInteractionEnabled = NO;
                    coloview4.font = [UIFont systemFontOfSize:10];
                    coloview4.colorfont = [UIFont boldSystemFontOfSize:12];
                    coloview4.pianyiHeight = 0;
                    coloview4.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview4.text = [NSString stringWithFormat:@"税后总奖金 <%@> 元",self.BetDetailInfo.zhongjiangInfo];
                    [zhongView addSubview:coloview4];
                    [coloview4 release];
                    
                }
                else {//没有本单奖金的
                    coloview.text = [NSString stringWithFormat:@"总奖金 <%@> 元",self.BetDetailInfo.jiangMoney];
                    coloview.frame = CGRectMake(155 - [coloview.text sizeWithFont:coloview.font].width/2, 25, [coloview.text sizeWithFont:coloview.font].width + 30 , 40);
                    ColorView * coloview2 = [[ColorView alloc] initWithFrame:CGRectMake(0, 60, 200, 40)];
                    coloview2.backgroundColor = [UIColor clearColor];
                    coloview2.userInteractionEnabled = NO;
                    coloview2.font = [UIFont systemFontOfSize:12];
                    coloview2.colorfont = [UIFont boldSystemFontOfSize:12];
                    coloview2.pianyiHeight = 0;
                    coloview2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview2.text = [NSString stringWithFormat:@"税后总奖金为 <%@> 元",self.BetDetailInfo.zhongjiangInfo];
                    [zhongView addSubview:coloview2];
                    [coloview2 release];
                    coloview2.frame = CGRectMake(155 - [coloview2.text sizeWithFont:coloview2.font].width/2, 60, [coloview2.text sizeWithFont:coloview2.font].width + 30 , 40);
                }
                height = height + 98;
            }
            else {//不交税
                ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 13, 150, 40)];
                coloview.backgroundColor = [UIColor clearColor];
                coloview.userInteractionEnabled = NO;
                coloview.font = [UIFont systemFontOfSize:24];
                coloview.colorfont = [UIFont boldSystemFontOfSize:30];
                coloview.pianyiHeight = 5;
                coloview.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
                coloview.text = [NSString stringWithFormat:@"本单中奖 <%@> 元",self.BetInfo.lotteryMoney];
                [zhongView addSubview:coloview];
                [coloview release];
                if ([self.BetInfo.lotteryMoney floatValue]) {//有本单奖金的
                    
                    coloview.frame = CGRectMake(155 - [coloview.text sizeWithFont:coloview.font].width/2, 16, [coloview.text sizeWithFont:coloview.font].width + 30 , 40);
                    ColorView * coloview2 = [[ColorView alloc] initWithFrame:CGRectMake(0, 55, 200, 40)];
                    coloview2.backgroundColor = [UIColor clearColor];
                    coloview2.userInteractionEnabled = NO;
                    coloview2.font = [UIFont systemFontOfSize:12];
                    coloview2.colorfont = [UIFont boldSystemFontOfSize:12];
                    coloview2.pianyiHeight = 0;
                    coloview2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                    coloview2.text = [NSString stringWithFormat:@"总奖金为 <%@> 元",self.BetDetailInfo.jiangMoney];
                    [zhongView addSubview:coloview2];
                    [coloview2 release];
                    coloview2.frame = CGRectMake(155 - [coloview2.text sizeWithFont:coloview2.font].width/2, 55, [coloview2.text sizeWithFont:coloview2.font].width + 30 , 40);
                    
                }
                else {//没有本单奖金的
                    coloview.text = [NSString stringWithFormat:@"方案总奖金为 <%@> 元",self.BetDetailInfo.jiangMoney];
                    coloview.frame = CGRectMake(155 - [coloview.text sizeWithFont:coloview.font].width/2, 25, [coloview.text sizeWithFont:coloview.font].width + 30 , 40);
                }
                height = height + 80;
            }
        }
        else {
            
            ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 13, 150, 40)];
            coloview.backgroundColor = [UIColor clearColor];
            coloview.userInteractionEnabled = NO;
            coloview.font = [UIFont systemFontOfSize:24];
            coloview.colorfont = [UIFont boldSystemFontOfSize:30];
            coloview.pianyiHeight = 5;
            coloview.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
            coloview.text = [NSString stringWithFormat:@"中奖 <%@> 元",self.BetDetailInfo.jiangMoney];
            if (isHorse) {
                coloview.text = [NSString stringWithFormat:@"中奖 <%@> 积分",self.BetDetailInfo.jiangMoney];
            }
            [zhongView addSubview:coloview];
            [coloview release];

            
            if (![self.BetDetailInfo.zhongjiangInfo isEqualToString:BetDetailInfo.jiangMoney] && [self.BetDetailInfo.zhongjiangInfo length] &&![self.BetDetailInfo.zhongjiangInfo isEqualToString:@"null"] && !isHorse) {//交税
                coloview.frame = CGRectMake(155 - [coloview.text sizeWithFont:coloview.font].width/2, 16, [coloview.text sizeWithFont:coloview.font].width + 30 , 40);
                ColorView * coloview2 = [[ColorView alloc] initWithFrame:CGRectMake(0, 55, 200, 40)];
                coloview2.backgroundColor = [UIColor clearColor];
                coloview2.userInteractionEnabled = NO;
                coloview2.font = [UIFont systemFontOfSize:12];
                coloview2.colorfont = [UIFont boldSystemFontOfSize:12];
                coloview2.pianyiHeight = 0;
                coloview2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                coloview2.text = [NSString stringWithFormat:@"税后奖金为 <%@> 元",self.BetDetailInfo.zhongjiangInfo];
                [zhongView addSubview:coloview2];
                [coloview2 release];
                coloview2.frame = CGRectMake(150 - [coloview2.text sizeWithFont:coloview2.font].width/2, 55, [coloview2.text sizeWithFont:coloview2.font].width + 30 , 40);
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([coloview.text sizeWithFont:coloview.font].width + 2, 15, 40, 20)];
                label.text = @"（税前）";
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
                [coloview addSubview:label];
                label.font = [UIFont systemFontOfSize:10];
                [label release];
                height = height + 98;
                
            }
            else {
                coloview.frame = CGRectMake(155 - [coloview.text sizeWithFont:coloview.font].width/2, 25, [coloview.text sizeWithFont:coloview.font].width + 30 , 40);
                height = height + 80;
                
            }
        }
        
//        CPZhanKaiView *zhanKaiView = [[CPZhanKaiView alloc] init];
//        zhanKaiView.frame = CGRectMake(10, height, 300, 45);
//        zhanKaiView.normalHeight = 45;
//        zhanKaiView.zhankaiHeight = 99;
//        zhanKaiView.zhankaiDelegate = self;
//        zhanKaiView.tag = 1;
//        
//		UIImageView *imageView = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageView];
//		imageView.image = UIImageGetImageFromName(@"XQCYHMSSBG960.png");
//        imageView.frame = CGRectMake(0, 0, 300, 44);
//        imageView.userInteractionEnabled = YES;
//        [zhanKaiView addSubview:imageView];
//        
//        ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 13, 150, 40)];
//		coloview.backgroundColor = [UIColor clearColor];
//        coloview.userInteractionEnabled = NO;
//        coloview.font = [UIFont systemFontOfSize:12];
//        coloview.colorfont = [UIFont boldSystemFontOfSize:12];
//        coloview.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//		coloview.text = [NSString stringWithFormat:@"中奖 <%@> 元",self.BetDetailInfo.jiangMoney];
//		[imageView addSubview:coloview];
//
//        
//        UIButton *faqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        faqBtn.frame = CGRectMake(200, 0, 40, 40);
//        faqBtn.backgroundColor = [UIColor clearColor];
//        [faqBtn addTarget:self action:@selector(pressFaq2) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIImageView *faqIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 11, 11)];
//        faqIma.backgroundColor = [UIColor clearColor];
//        faqIma.image = UIImageGetImageFromName(@"faq-wenhao.png");
//        [faqBtn addSubview:faqIma];
//        [faqIma release];
//        
//        
//        if ([self.BetInfo.lotteryMoney floatValue] && ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"])) {
//            coloview.frame = CGRectMake(145 - [coloview.text sizeWithFont:coloview.font].width, 16, [coloview.text sizeWithFont:coloview.font].width +5 , 20);
//            ColorView * coloview2 = [[ColorView alloc] initWithFrame:CGRectMake(0, 4, 150, 40)];
//            coloview2.backgroundColor = [UIColor clearColor];
//            coloview2.userInteractionEnabled = NO;
//            coloview2.font = [UIFont systemFontOfSize:12];
//            coloview2.colorfont = [UIFont boldSystemFontOfSize:18];
//            coloview2.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
//            coloview2.text = [NSString stringWithFormat:@"本单 <%@> 元",self.BetInfo.lotteryMoney];
//            coloview2.frame  = CGRectMake(150, 10, 150, 20);
//            [imageView addSubview:coloview2];
//            [coloview2 release];
//            
//            faqBtn.frame = CGRectMake(250, 0, 40, 40);
//        }
//        else {
//            coloview.frame = CGRectMake(150 - [coloview.text sizeWithFont:coloview.font].width /2 , 15, [coloview.text sizeWithFont:coloview.font].width +5 , 20);
//        }
//        if (isMine) {
//            [imageView addSubview:faqBtn];
//        }
//        
//		[coloview release];
//        [imageView release];
//        
//        UIImageView *imageView2 = [[UIImageView alloc] init];
//		imageView2.image = UIImageGetImageFromName(@"XQCYHMSBG960.png");
//        imageView2.frame = CGRectMake(0, 32, 300, 67);
//        [zhanKaiView insertSubview:imageView2 belowSubview:imageView];
//        [imageView2 release];
//        
//        ColorView * coloview3 = [[ColorView alloc] initWithFrame:CGRectMake(10, 15, 280, 40)];
//		coloview3.backgroundColor = [UIColor clearColor];
//        coloview3.font = [UIFont systemFontOfSize:9];
//        coloview3.colorfont = [UIFont systemFontOfSize:12];
//        if ([self.BetDetailInfo.zhongjiangInfo isEqualToString:BetDetailInfo.jiangMoney] || [self.BetDetailInfo.zhongjiangInfo length] == 0 || [self.BetDetailInfo.zhongjiangInfo isEqualToString:@"null"])  {
//            if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
//                if ([self.BetInfo.lotteryMoney floatValue]) {
//                    coloview3.text = [NSString stringWithFormat:@"方案总奖金为<%@>元,本单总奖金是<%@>元",self.BetDetailInfo.jiangMoney,self.BetInfo.lotteryMoney];
//                }
//                else {
//                    coloview3.text = [NSString stringWithFormat:@"方案总奖金为<%@>元",self.BetDetailInfo.jiangMoney];
//                }
//            }
//            else {
//                coloview3.text = [NSString stringWithFormat:@"方案总奖金为<%@>元",self.BetDetailInfo.jiangMoney];
//            }
//        }
//        else {
//            if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
//                if ([self.BetInfo.lotteryMoney floatValue]) {
//                    coloview3.text = [NSString stringWithFormat:@"方案税前总奖金为<%@>元,税后总奖金为<%@>元,本单总奖金是<%@>元",self.BetDetailInfo.jiangMoney,self
//                                      .BetDetailInfo.zhongjiangInfo,self.BetInfo.lotteryMoney];
//                }
//                else {
//                    coloview3.text = [NSString stringWithFormat:@"方案税前总奖金为<%@>元,税后总奖金为<%@>元",self.BetDetailInfo.jiangMoney,self
//                                      .BetDetailInfo.zhongjiangInfo];
//                }
//            }
//            else {
//                if ([self.BetInfo.lotteryMoney floatValue]) {
//                    coloview3.text = [NSString stringWithFormat:@"方案税前总奖金为<%@>元,税后总奖金为<%@>元,本单总奖金是<%@>元",self.BetDetailInfo.jiangMoney,self
//                                      .BetDetailInfo.zhongjiangInfo,self.BetInfo.lotteryMoney];
//                }
//                else {
//                    coloview3.text = [NSString stringWithFormat:@"方案税前总奖金为<%@>元,税后总奖金为<%@>元",self.BetDetailInfo.jiangMoney,self
//                                      .BetDetailInfo.zhongjiangInfo];
//                }
//            }
//            
//        }
//        coloview3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//		[imageView2 addSubview:coloview3];
//		
//		CGSize maxSize = CGSizeMake(280, 1000);
//		CGSize expectedSize = [coloview3.text sizeWithFont:coloview3.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
//        zhanKaiView.zhankaiHeight = 45 + expectedSize.height + 15;
//		[coloview3 release];
//        
//        UIImageView *imageView3 = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageView3];
//		imageView3.image = UIImageGetImageFromName(@"XQCYHMSBG-1960.png");
//        zhanKaiView.fengeImageView = imageView3;
//        imageView3.frame = CGRectMake(0, 40, 300, 5);
//        [zhanKaiView addSubview:imageView3];
//        [imageView3 release];
//        
//		height = height + 45 +10;
//        [tableheadView addSubview:zhanKaiView];
//        [zhanKaiView release];
	}
    else if ([self.BetDetailInfo.yuceJiangjin length] > 0 || ([self.BetDetailInfo.yujiTime length] > 0 && [self.BetDetailInfo.betContentArray count])) {
        UIView *zhongView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 45)];
        zhongView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [tableheadView addSubview:zhongView];
        tableheadView.tag = 1;
        [zhongView release];
//        CPZhanKaiView *zhanKaiView = [[CPZhanKaiView alloc] init];
//        zhanKaiView.frame = CGRectMake(10, height, 300, 45);
//        zhanKaiView.normalHeight = 45;
//        zhanKaiView.zhankaiHeight = 99;
//        zhanKaiView.userInteractionEnabled = NO;
//        zhanKaiView.zhankaiDelegate = self;
//        zhanKaiView.tag = 1;
//        
//		UIImageView *imageView = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageView];
//		imageView.image = UIImageGetImageFromName(@"XQCYHMSSBG960.png");
//        imageView.frame = CGRectMake(0, 0, 300, 44);
//        [zhanKaiView addSubview:imageView];
        
        ColorView * coloview = [[ColorView alloc] initWithFrame:CGRectMake(0, 13, 150, 40)];
		coloview.backgroundColor = [UIColor clearColor];
        coloview.userInteractionEnabled = NO;
        coloview.font = [UIFont systemFontOfSize:12];
        coloview.colorfont = [UIFont boldSystemFontOfSize:12];
        coloview.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
        if ([self.BetDetailInfo.yuceJiangjin length] > 0 && [self.BetDetailInfo.yuceJiangjin floatValue] > 0) {
            if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"])
            {
                coloview.text = [NSString stringWithFormat:@"预计总奖金 <%@> 元",self.BetDetailInfo.yuceJiangjin];
            }
            else{
                coloview.text = [NSString stringWithFormat:@"预计奖金 <%@> 元",self.BetDetailInfo.yuceJiangjin];
            }
        }
        
		coloview.frame = CGRectMake(120 - [self.BetDetailInfo.yuceJiangjin length] * 3, 13, 180, 40);
		[zhongView addSubview:coloview];
        if ([self.BetDetailInfo.yujiTime length] && [self.BetDetailInfo.betContentArray count]) {
            coloview.frame = CGRectMake(coloview.frame.origin.x, 8, coloview.frame.size.width, 20);
            UILabel *lable2 = [[UILabel alloc] init];
            NSString *sysyTime = [[[self.BetDetailInfo.systemTime stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""];
            NSString *yuji = [[[self.BetDetailInfo.yujiTime stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""];
            lable2.frame = CGRectMake(0, 20, 320, 20);
            if ([self.BetDetailInfo.yuceJiangjin length] == 0 || [self.BetDetailInfo.yuceJiangjin floatValue] == 0) {
                lable2.frame = CGRectMake(0, 11, 320, 20);
            }
            lable2.backgroundColor = [UIColor clearColor];
            if ([yuji doubleValue] < [sysyTime doubleValue]) {
                lable2.text = @"等待官方派奖";
            }
            else {
                lable2.text = [NSString stringWithFormat:@"预计派奖时间 %@",self.BetDetailInfo.yujiTime];
            }
            
            lable2.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0];
            lable2.font = [UIFont systemFontOfSize:10];
            lable2.textAlignment = NSTextAlignmentCenter;
            [zhongView addSubview:lable2];
            [lable2 release];
        }
        [coloview release];
        height = height + 45;
        
    }
    if (1) {
        
        UIView *zhongView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 67)];
        zhongView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        [tableheadView addSubview:zhongView];
        tableheadView.tag = 2;
        [zhongView release];
        
        UIView *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [zhongView addSubview:line1];
        [line1 release];
        
        UIView *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, 320, 0.5)];
        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [zhongView addSubview:line2];
        [line2 release];
        UILabel *lable1 = [[UILabel alloc] init];
        lable1.frame = CGRectMake(15, 15, 80, 14);
        lable1.backgroundColor = [UIColor clearColor];
        lable1.font = [UIFont systemFontOfSize:12];
        lable1.text = nil;
        lable1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [zhongView addSubview:lable1];
        [lable1 release];
        if ([self.BetInfo.mode length] > 1) {//玩法
            lable1.text = self.BetInfo.mode;
        }
        else {
            lable1.text = [GC_LotteryType wanfaNameWithLotteryID:self.BetDetailInfo.lotteryId WanFaId:self.BetDetailInfo.wanfaId];
            if ([self.BetDetailInfo.OutorderId rangeOfString:@"2x1"].location != NSNotFound) {
                lable1.text = @"混合二选一";
            }
        }
        if (isHorse) {
            if ([BetInfo.mode isEqualToString:@"0"]) {
                lable1.text = @"多玩法";
            }
            else if ([BetInfo.mode isEqualToString:@"01"]) {
                lable1.text = @"独赢";
            }
            else if ([BetInfo.mode isEqualToString:@"11"]) {
                lable1.text = @"连赢";
            }
            else if ([BetInfo.mode isEqualToString:@"12"]) {
                lable1.text = @"单T";
            }
        }
        UILabel *lable2 = [[UILabel alloc] init];
        lable2.frame = CGRectMake(95, 15, 150, 14);
        if (![lable1.text length]) {
            lable2.frame = CGRectMake(15, 15, 150, 14);
        }
        lable2.backgroundColor = [UIColor clearColor];
        lable2.font = [UIFont systemFontOfSize:12];
        lable2.text = [NSString stringWithFormat:@"%@ %@ 倍    共 %@ 注",self.BetDetailInfo.betStyle,self.BetDetailInfo.multiplenNum,self.BetDetailInfo.betsNum];
        if (isHorse) {
            lable2.text = [NSString stringWithFormat:@"共 %@ 注    %@ 倍 ",self.BetDetailInfo.betsNum,self.BetDetailInfo.multiplenNum];
        }
        lable2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [zhongView addSubview:lable2];
        [lable2 release];
        
        if (self.BetDetailInfo.guguanWanfa &&[self.BetDetailInfo.guguanWanfa length]) {
            UILabel *lable3 = [[UILabel alloc] init];
            lable3.frame = CGRectMake(90, 40, 150, 14);
            lable3.backgroundColor = [UIColor clearColor];
            lable3.font = [UIFont boldSystemFontOfSize:12];
            lable3.text = [NSString stringWithFormat:@"%@",[[self.BetDetailInfo.guguanWanfa stringByReplacingOccurrencesOfString:@"x" withString:@"串"] stringByReplacingOccurrencesOfString:@","withString:@" "]];
            lable3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [zhongView addSubview:lable3];
            [lable3 release];
            if (![lable1.text length]) {
                lable3.frame = CGRectMake(15, 40, 150, 14);
            }
            
        }
        else {
            zhongView.frame = CGRectMake(0, height, 320, 46);
            line2.frame = CGRectMake(0, 45, 320, 0.5);
        }
        
        UILabel *moneyLable = [[UILabel alloc] init];
        [zhongView addSubview:moneyLable];
        moneyLable.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:1 alpha:1.0];
        moneyLable.textAlignment = NSTextAlignmentRight;
        moneyLable.frame = CGRectMake(165, 13, 125, 18);
        moneyLable.text = self.BetDetailInfo.programAmount;
        moneyLable.backgroundColor = [UIColor clearColor];
        moneyLable.font = [UIFont boldSystemFontOfSize:18];
        [moneyLable release];
        
        UILabel *moneyLable2 = [[UILabel alloc] init];
        [zhongView addSubview:moneyLable2];
        moneyLable2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        moneyLable2.font = [UIFont systemFontOfSize:12];
        moneyLable2.textAlignment = NSTextAlignmentRight;
        moneyLable2.text = @"元";
        moneyLable2.frame = CGRectMake(285, 16, 20, 14);
        if (isHorse) {
            moneyLable2.text = @"积分";
            moneyLable2.frame = CGRectMake(290, 16, 25, 14);
        }
        moneyLable2.backgroundColor = [UIColor clearColor];
        [moneyLable2 release];


        
		height = height + zhongView.frame.size.height;
    }
    
	
	if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
        
        UIView *zhongView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 163)];
        zhongView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [tableheadView addSubview:zhongView];
        tableheadView.tag = 3;
        [zhongView release];
        
        UIView *line1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 42, 320, 0.5)];
        line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [zhongView addSubview:line1];
        [line1 release];
        
        ColorView *colorView5 = [[ColorView alloc] initWithFrame:CGRectMake(15, 12, 150, 20)];
        colorView5.font = [UIFont boldSystemFontOfSize:15];
        colorView5.backgroundColor = [UIColor clearColor];
        colorView5.colorfont = [UIFont boldSystemFontOfSize:15];
        colorView5.changeColor =[UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
        colorView5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        colorView5.text = [NSString stringWithFormat:@"合买进度  <%@>",self.BetDetailInfo.projectSchedule];
        [zhongView addSubview:colorView5];
        [colorView5 release];
        
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame = CGRectMake(190, 7, 116, 30);
        [Btn setImage:UIImageGetImageFromName(@"fananxiangqingcanyu.png") forState:UIControlStateNormal];
        
        UIImageView *image1 = [[UIImageView alloc] init];
        [Btn addSubview:image1];
        image1.frame = CGRectMake(90, 4, 22, 22);
        image1.image = UIImageGetImageFromName(@"faxqjiantou.png");
        [image1 release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [Btn addSubview:label];
        label.text = [NSString stringWithFormat:@"%@人认购",self.BetDetailInfo.subscriptionNum];
        [label release];
        [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
        [zhongView addSubview:Btn];


//        CPZhanKaiView *zhanKaiView = [[CPZhanKaiView alloc] init];
//        zhanKaiView.frame = CGRectMake(10, height, 300, 45);
//        zhanKaiView.normalHeight = 45;
//        zhanKaiView.tag = 3;
//        zhanKaiView.zhankaiHeight = 115;
//        zhanKaiView.zhankaiDelegate = self;
//        
//		UIImageView *imageView = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageView];
//		imageView.image = UIImageGetImageFromName(@"XQCYHMSSBG960.png");
//        imageView.frame = CGRectMake(0, 0, 300, 44);
//        [zhanKaiView addSubview:imageView];
//        
//        
//        UIImageView *imageViewleft = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageViewleft];
//		imageViewleft.image = UIImageGetImageFromName(@"TZFAXQTCL960.png");
//        imageViewleft.frame = CGRectMake(0, 0, 63, 44);
//        
//        UILabel *titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 63, 20)];
//        [imageViewleft addSubview:titleLabe];
//        titleLabe.text = @"合    买";
//        titleLabe.font = [UIFont boldSystemFontOfSize:12];
//        titleLabe.textAlignment = NSTextAlignmentCenter;
//        titleLabe.backgroundColor = [UIColor clearColor];
//        titleLabe.shadowOffset = CGSizeMake(1, 1);
//        titleLabe.shadowColor = [UIColor blackColor];
//        titleLabe.textColor = [UIColor whiteColor];
//        [titleLabe release];
//        
//        [zhanKaiView addSubview:imageViewleft];
//        [imageViewleft release];
//        
//        if (self.BetDetailInfo.voiceLong > 0 || self.voiceLong > 0) {
//            
//            UIImageView *imge2 = [[UIImageView alloc] init];
//            imge2.image = UIImageGetImageFromName(@"GCSZVoice.png");
//            imge2.frame = CGRectMake(195, 17, 10, 14);
//            [imageView addSubview:imge2];
//            [imge2 release];
//        }
//        
//        CP_PTButton *Btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        Btn.frame = CGRectMake(211, 8, 75, 27);
//        [Btn loadButonImage:nil LabelName:[NSString stringWithFormat:@"%@人认购",self.BetDetailInfo.subscriptionNum]];
//        [Btn setBackgroundImage:[UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//        [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
//        [imageView addSubview:Btn];
//        imageView.userInteractionEnabled = YES;
//        
//        ColorView *colorView5 = [[ColorView alloc] initWithFrame:CGRectMake(83, 10, 110, 20)];
//        colorView5.font = [UIFont boldSystemFontOfSize:10];
//        colorView5.backgroundColor = [UIColor clearColor];
//        colorView5.colorfont = [UIFont boldSystemFontOfSize:18];
//        colorView5.pianyiHeight = 6;
//        colorView5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        colorView5.text = [NSString stringWithFormat:@"进度<%@>%%",[self.BetDetailInfo.projectSchedule stringByReplacingOccurrencesOfString:@"%" withString:@""]];
//        [imageView addSubview:colorView5];
//        if (![self.BetDetailInfo.projectSchedule isEqualToString:@"100%"]) {
//            zhanKaiView.frame = CGRectMake(10, height, 300, 115);
//            height = height +60;
//            zhanKaiView.isOpen = YES;
//        }
//        [colorView5 release];
//
//        
//        [imageView release];
//        
        UIView *imageView2 = [[UIView alloc] init];
        imageView2.frame = CGRectMake(0, 42, 320, 120);
        [zhongView addSubview:imageView2];
        [imageView2 release];
//
        UILabel *lable1 = [[UILabel alloc] init];
        lable1.frame = CGRectMake(15, 93, 60, 14);
        lable1.backgroundColor = [UIColor clearColor];
        lable1.font = [UIFont systemFontOfSize:13];
        lable1.text = @"方案宣言";
        lable1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [imageView2 addSubview:lable1];
        [lable1 release];
        imageView2.userInteractionEnabled = YES;
            UILabel *lable2 = [[UILabel alloc] init];
            lable2.frame = CGRectMake(70, 93, 200, 14);
            lable2.backgroundColor = [UIColor clearColor];
            lable2.font = [UIFont systemFontOfSize:13];
            lable2.tag = 1008;
            lable2.textAlignment = NSTextAlignmentLeft;
            lable2.text = self.BetDetailInfo.programDeclaration;
            lable2.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
            [imageView2 addSubview:lable2];
            [lable2 release];
        
        
        UILabel *lable3 = [[UILabel alloc] init];
        lable3.frame = CGRectMake(15, 66, 100, 14);
        lable3.backgroundColor = [UIColor clearColor];
        lable3.textAlignment = NSTextAlignmentLeft;
        lable3.font = [UIFont systemFontOfSize:13];
        lable3.text = @"自购              元";
        lable3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [imageView2 addSubview:lable3];
        [lable3 release];
        
        UILabel *lable4 = [[UILabel alloc] init];
        lable4.frame = CGRectMake(18, 66, 65, 14);
        lable4.backgroundColor = [UIColor clearColor];
        lable4.font = [UIFont systemFontOfSize:13];
        lable4.textAlignment = NSTextAlignmentRight;
        lable4.text = [NSString stringWithFormat:@"%d",(int)[self.BetDetailInfo.sponsorsAmount integerValue]];
        lable4.textColor = [UIColor colorWithRed:17/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        [imageView2 addSubview:lable4];
        [lable4 release];
        
        
        ColorView * coloview4 = [[ColorView alloc] initWithFrame:CGRectMake(125, 66, 100, 20)];
		coloview4.backgroundColor = [UIColor clearColor];
        
		coloview4.text = [NSString stringWithFormat:@"提成 <%.0f> %%",[self.BetDetailInfo.percentage floatValue] *100];
        coloview4.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        coloview4.font = [UIFont systemFontOfSize:13];
        coloview4.colorfont = [UIFont systemFontOfSize:13];
		[imageView2 addSubview:coloview4];
        [coloview4 release];
        
        ColorView * coloview5 = [[ColorView alloc] initWithFrame:CGRectMake(200, 66, 100, 20)];
		coloview5.backgroundColor = [UIColor clearColor];
        
		coloview5.text = [NSString stringWithFormat:@"保底 <%d> 元",(int)[self.BetDetailInfo.baseAmount integerValue]];
        coloview5.changeColor = [UIColor colorWithRed:17/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        coloview5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        coloview5.font = [UIFont systemFontOfSize:13];
        coloview5.colorfont = [UIFont systemFontOfSize:13];
		[imageView2 addSubview:coloview5];
        [coloview5 release];
        
        UILabel *lable5 = [[UILabel alloc] init];
        lable5.frame = CGRectMake(15, 14, 40, 14);
        lable5.backgroundColor = [UIColor clearColor];
        lable5.font = [UIFont systemFontOfSize:13];
        lable5.text = @"发起人";
        lable5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [imageView2 addSubview:lable5];
        [lable5 release];
        
        UILabel *lable6 = [[UILabel alloc] init];
        lable6.frame = CGRectMake(60, 14, 100, 14);
        lable6.backgroundColor = [UIColor clearColor];
        lable6.font = [UIFont systemFontOfSize:13];
        lable6.textAlignment = NSTextAlignmentLeft;
        lable6.text = self.BetDetailInfo.sponsorsName;
        lable6.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        [imageView2 addSubview:lable6];
        [lable6 release];
        
        //        战绩
        float with = [lable6.text sizeWithFont:lable6.font].width;
        NSArray *zhanjiArray = [self.BetDetailInfo.zhanji componentsSeparatedByString:@"#"];
        int count = 0;
        for (int i = 0; i < [zhanjiArray count]; i++) {
            if ([[zhanjiArray objectAtIndex:i] isAllNumber]) {
                if ([[zhanjiArray objectAtIndex:i] isEqualToString:@"0"]) {
                    
                }else{
                    UIImageView *level1 = [[UIImageView alloc] init];
                    level1.backgroundColor = [UIColor clearColor];
                    NSString *imageName = [self getImageByZhanji:i];
                    
                    level1.image = UIImageGetImageFromName(imageName);
                    level1.frame = CGRectMake(60 + with + (count*18), 14, 11, 11);
                    [imageView2 addSubview:level1];
                    UILabel *labelzhanji = [[UILabel alloc]init];
                    labelzhanji.backgroundColor = [UIColor clearColor];
                    labelzhanji.frame = CGRectMake(5, 5, 10, 10);
                    labelzhanji.font = [UIFont systemFontOfSize:6];
                    [level1 addSubview:labelzhanji];
                    labelzhanji.textAlignment = NSTextAlignmentRight;
                    labelzhanji.text = [zhanjiArray objectAtIndex:i];
                    [labelzhanji release];
                    [level1 release];
                    count++;
                }
                
            }
            
        }
        
        
        UILabel *lable7 = [[UILabel alloc] init];
        lable7.frame = CGRectMake(15, 40, 55, 14);
        lable7.backgroundColor = [UIColor clearColor];
        lable7.font = [UIFont systemFontOfSize:13];
        lable7.text = @"截止时间";
        lable7.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [imageView2 addSubview:lable7];
        [lable7 release];
        
        UILabel *lable8 = [[UILabel alloc] init];
        lable8.frame = CGRectMake(15+60, 40, 140, 14);
        lable8.backgroundColor = [UIColor clearColor];
        lable8.font = [UIFont systemFontOfSize:13];
        lable8.textAlignment = NSTextAlignmentLeft;
        lable8.text = self.BetDetailInfo.endTime;
        lable8.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        [imageView2 addSubview:lable8];
        [lable8 release];
//
//        
//        
//        
//        
//        
//        UIImageView *imageView3 = [[UIImageView alloc] init];
//		[tableheadView addSubview:imageView3];
//		imageView3.image = UIImageGetImageFromName(@"XQCYHMSBG-1960.png");
//        zhanKaiView.fengeImageView = imageView3;
//        imageView3.frame = CGRectMake(0, zhanKaiView.frame.size.height - 5, 300, 5);
//        [zhanKaiView addSubview:imageView3];
//        [imageView3 release];
//
		height = height + zhongView.frame.size.height;
        UIView *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, height, 320, 0.5)];
        line3.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [tableheadView addSubview:line3];
        [line3 release];
//        [tableheadView addSubview:zhanKaiView];
//        [zhanKaiView release];
        
	}
    if (isDanShi) {
        UILabel *touzhuLabel = [[UILabel alloc] init];
        touzhuLabel.frame = CGRectMake(0,height, 320, 45);
        touzhuLabel.textAlignment = NSTextAlignmentCenter;
        touzhuLabel.backgroundColor = [UIColor clearColor];
        touzhuLabel.font = [UIFont boldSystemFontOfSize:16];
        touzhuLabel.text = @"单式上传";
        touzhuLabel.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
        [tableheadView addSubview:touzhuLabel];
        [touzhuLabel release];
        
        if (!isShuZi) {
            touzhuLabel.frame = CGRectMake(0,height, 320, 150);
            height = height + 150;
        }
        else {
            height = height + 45;
        }
        isBaomi = YES;
    }
    //    else if (isJJYH) {
    //        UIImageView *im = [[UIImageView alloc] init];
    //        im.frame = CGRectMake(10, height , 300, 37);
    //        im.image = UIImageGetImageFromName(@"XQCELlBG960.png");
    //        im.tag = 1123;
    //        [tableheadView addSubview:im];
    //        [im release];
    //        UILabel *touzhuLabel = [[UILabel alloc] init];
    //        touzhuLabel.frame = CGRectMake(50,14, 200, 17);
    //        touzhuLabel.textAlignment = NSTextAlignmentCenter;
    //        touzhuLabel.backgroundColor = [UIColor clearColor];
    //        touzhuLabel.font = [UIFont boldSystemFontOfSize:15];
    //        touzhuLabel.text = @"奖金优化方案暂时不支持显示";
    //        touzhuLabel.textColor = [UIColor blackColor];
    //        [im addSubview:touzhuLabel];
    //        [touzhuLabel release];
    //        height = height + 31;
    //        isBaomi = YES;
    //    }
	else if (!isMine || [self.BetInfo.betStyle isEqualToString:@"1"]||[self.BetInfo.buyStyle isEqualToString:@"参与合买"]) {
        if (!isMine && [self.BetDetailInfo.secretType isEqualToString:@"1"] )	{
			
			UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height, 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"保密方案";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            isBaomi = YES;
		}
		else if (!isMine && [self.BetDetailInfo.secretType isEqualToString:@"2"] && ![self.BetDetailInfo.endTime isEqualToString:@"已截期"]){
			UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height, 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"截止后公开";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            isBaomi =YES;
		}
		
		else if (!isMine && ([self.BetDetailInfo.secretType isEqualToString:@"3"] && self.BetDetailInfo.betContentArray.count == 0)){
			UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height , 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"仅对跟单者公开";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            isBaomi =YES;
		}
		
		else if (!isMine && ([self.BetDetailInfo.secretType isEqualToString:@"4"])){
			UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height , 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"隐藏方案";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            isBaomi = YES;
		}
		else if (!isMine &&[self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"]) {
			UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height , 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"未截期，暂不公开！";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            isBaomi = YES;
		}
		
        else         if (!isMine && [self.BetDetailInfo.lotteryId isEqualToString:@"113"] && [self.BetDetailInfo.wanfaId isEqualToString:@"02"]) {
            UILabel *touzhuLabel = [[UILabel alloc] init];
			touzhuLabel.frame = CGRectMake(0, height , 320, 150);
			touzhuLabel.textAlignment = NSTextAlignmentCenter;
			touzhuLabel.backgroundColor = [UIColor clearColor];
			touzhuLabel.font = [UIFont systemFontOfSize:17];
			touzhuLabel.text = @"未截期，暂不公开！";
			touzhuLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
			[tableheadView addSubview:touzhuLabel];
			[touzhuLabel release];
			height = height + 150;
            
        }
		
		else {
            if (isShuZi) {
                UIImageView *touImage = [[UIImageView alloc] init];
                [tableheadView addSubview:touImage];
                [touImage release];
                touImage.image = UIImageGetImageFromName(@"xqbiaoqian.png");
                touImage.frame = CGRectMake(15, height, 75, 25);
                UILabel *lable8 = [[UILabel alloc] init];
                lable8.frame = touImage.bounds;
                lable8.backgroundColor = [UIColor clearColor];
                lable8.font = [UIFont boldSystemFontOfSize:15];
                lable8.textAlignment = NSTextAlignmentCenter;
                lable8.textColor = [UIColor whiteColor];
                lable8.text = @"投注号码";
                [touImage addSubview:lable8];
                [lable8 release];
                height = height + 30;
            }

		}
        
	}
	
	else {
        
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"113"] && [self.BetDetailInfo.wanfaId isEqualToString:@"02"]) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, height , 200, 150)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
            label.text = @"暂不支持此玩法显示";
            [tableheadView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
            height = height + 150;
        }
        if (isShuZi) {
            UIImageView *touImage = [[UIImageView alloc] init];
            [tableheadView addSubview:touImage];
            [touImage release];
            touImage.image = UIImageGetImageFromName(@"xqbiaoqian.png");
            touImage.frame = CGRectMake(15, height, 75, 25);
            UILabel *lable8 = [[UILabel alloc] init];
            lable8.frame = touImage.bounds;
            lable8.backgroundColor = [UIColor clearColor];
            lable8.font = [UIFont boldSystemFontOfSize:15];
            lable8.textAlignment = NSTextAlignmentCenter;
            lable8.textColor = [UIColor whiteColor];
            lable8.text = @"投注号码";
            [touImage addSubview:lable8];
            [lable8 release];
            height = height + 30;
        }
	}
    if ([myTableView numberOfRowsInSection:0] != 0 && [self.BetDetailInfo.shishibifen isEqualToString:@"1"] &&(ticaiType == ShengFuCai || ticaiType == JingCaiZuqiu || ticaiType == BeiDan || ticaiType == ZuQiuDahunTou)) {
        shishiBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [tableheadView addSubview:shishiBtn];
        shishiBtn.frame = CGRectMake(10, height + 7.5, 300, 34);
        if (!isShishi) {
            [shishiBtn loadButonImage:@"tongyonganniulanse.png" LabelName:@"开启比分直播"];
        }
        else {
            [shishiBtn loadButonImage:@"tongyonganniulanse.png" LabelName:@"关闭比分直播"];
        }
        shishiBtn.buttonName.font = [UIFont systemFontOfSize:16];
        shishiBtn.buttonName.textColor = [UIColor colorWithRed:17/255.0 green:163/255.0 blue:255.0/255.0 alpha:1.0];
        
        [shishiBtn addTarget:self action:@selector(changeShiShi) forControlEvents:UIControlEventTouchUpInside];
        height = height + 48;
    }
    if (!isShuZi && [myTableView numberOfSections] && [myTableView numberOfRowsInSection:0] && (ticaiType < LanQiufencha || ticaiType > LanQiuHunTou) && ![self.BetDetailInfo.lotteryId isEqualToString:@"301"] && !([self.BetDetailInfo.lotteryId isEqualToString:@"201"] && ([self.BetDetailInfo.wanfaId isEqualToString:@"06"] ||[self.BetDetailInfo.wanfaId isEqualToString:@"07"])) && !([self.BetDetailInfo.wanfaId isEqualToString:@"04"] && [self.BetDetailInfo.lotteryId isEqualToString:@"303"])) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, height + 5, 310, 28)];
        [tableheadView addSubview:imageV];
        imageV.image = [UIImageGetImageFromName(@"zhuce-tongyixiyikuang_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        imageV.backgroundColor = [UIColor colorWithRed:231/255.0 green:229/255.0 blue:219/255.0 alpha:1.0];
        [imageV release];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 28)];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = @"主队";
        label1.textAlignment = NSTextAlignmentCenter;
        [imageV addSubview:label1];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 70, 28)];
        label2.backgroundColor = [UIColor clearColor];
        label2.text = @"客队";
        [imageV addSubview:label2];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:14];
        label2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [label2 release];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(170, 0, 0.5, 28)];
        line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [imageV addSubview:line1];
        [line1 release];
        
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(175, 6, 70, 20)];
        label3.backgroundColor = [UIColor clearColor];
        label3.text = @"90分钟";
        [imageV addSubview:label3];
        label3.textAlignment = NSTextAlignmentLeft;
        label3.font = [UIFont systemFontOfSize:9];
        label3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [label3 release];
        
        UILabel *label31 = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 65, 28)];
        label31.backgroundColor = [UIColor clearColor];
        label31.text = @"赛果";
        [imageV addSubview:label31];
        label31.textAlignment = NSTextAlignmentRight;
        label31.font = [UIFont systemFontOfSize:14];
        label31.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [label31 release];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 0.5, 28)];
        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [imageV addSubview:line2];
        [line2 release];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 70, 28)];
        label4.backgroundColor = [UIColor clearColor];
        label4.text = @"投注";
        [imageV addSubview:label4];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.font = [UIFont systemFontOfSize:14];
        label4.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        [label4 release];
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"302"]) {
            label1.frame = CGRectMake(50, 0, 65, 28);
            label2.frame = CGRectMake(135, 0, 65, 28);
            label3.frame = CGRectMake(200, 0, 40, 28);
            label4.frame = CGRectMake(240, 0, 70, 28);
        }
        height = height +28;
        
    }
	tableheadView.frame = CGRectMake(0, 0, 320, height);
//    [backScrollView addSubview:tableheadView];
    [myTableView setTableHeaderView:tableheadView];
    [tableheadView release];
    
    //	[heardView release];
}

- (void)setFootView {
    
    if ( [self.BetDetailInfo.awardNum isEqualToString:@"预投方案"]||(isShuZi &&[self.BetDetailInfo.awardNum isEqualToString:@"-"])) {
        return;
    }
	NSInteger footHeight = 5;
	UIView *footView = [[UIView alloc] init];
	footView.backgroundColor = [UIColor clearColor];
    [footView.layer setMasksToBounds:YES];
	if (isBaomi) {
	}
	else {
        //		UIImageView *footImage = [[UIImageView alloc] init];
        //		footImage.frame = CGRectMake(7, 0, 305, 6);
        //		footImage.image = UIImageGetImageFromName(@"GC_texBg2_b.png");
        //		[footView addSubview:footImage];
        //		[footImage release];
        //		footHeight = footHeight + 6;
	}
	if (isShuZi) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, footHeight, 320, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [footView addSubview:line];
        [line release];
        UIImageView *touImage = [[UIImageView alloc] init];
        [footView addSubview:touImage];
        [touImage release];
        touImage.image = UIImageGetImageFromName(@"xqbiaoqian.png");
        touImage.frame = CGRectMake(15, footHeight, 75, 25);
		UILabel *kaijiangLabel = [[UILabel alloc] init];
		kaijiangLabel.frame = touImage.bounds;
		kaijiangLabel.backgroundColor = [UIColor clearColor];
		kaijiangLabel.font = [UIFont boldSystemFontOfSize:15];
		kaijiangLabel.text = @"开奖号码";
        kaijiangLabel.textAlignment = NSTextAlignmentCenter;
		kaijiangLabel.textColor = [UIColor whiteColor];
		[touImage addSubview:kaijiangLabel];
		[kaijiangLabel release];
		footHeight = footHeight + 31;
		
		
		GouCaiShuZiCell *cell = [[GouCaiShuZiCell alloc] initWithFrame:CGRectMake(0, footHeight , 320, 45)];
        cell.mylotteryId = self.BetDetailInfo.lotteryId;
        cell.wanfa = self.BetDetailInfo.wanfaId;
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"001"] && [self.BetDetailInfo.zanNum intValue] > 0 && [self.BetDetailInfo.zanNum length] == 2) {
            cell.luckyBall = self.BetDetailInfo.zanNum;
        }
        
        if ([self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"]||[self.BetDetailInfo.awardNum isEqualToString:@"等待开奖"]) {
            if ([self.BetDetailInfo.kaiJiangTime length] != 0) {
                
                [cell LoadNum:[NSString stringWithFormat:@"距离开奖还有%@",self.BetDetailInfo.kaiJiangTime] LottoryID:self.BetInfo.lotteryNum WithBall:YES];
            }
            else {
                [cell LoadNum:self.BetDetailInfo.awardNum LottoryID:self.BetDetailInfo.lotteryId WithBall:YES];
            }
            
        }
        else {
            [cell LoadNum:self.BetDetailInfo.awardNum LottoryID:self.BetDetailInfo.lotteryId WithBall:YES];
        }
        
		cell.backImage.image = nil;
		UIImageView *cellBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, footHeight, 320, 45)];
        cellBack.image = nil;
		cell.backgroundColor = [UIColor clearColor];
		[cellBack addSubview:cell];
		[footView addSubview:cellBack];
		footView.frame = CGRectMake(0, footHeight + 11, 320, 36);
        if (![self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"] && ![self.BetDetailInfo.awardNum isEqualToString:@"等待开奖"]) {
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"122"]) {
                cellBack.frame = CGRectMake(10, footHeight + 11, 300, 65);
                cell.frame = CGRectMake(0, 10, 320, 65);
                footHeight = footHeight + 30;
            }
        }
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"003"]) {
            if (![self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"] && ![self.BetDetailInfo.awardNum isEqualToString:@"等待开奖"]) {
                cellBack.frame = CGRectMake(0, footHeight , 300, 80);
                cell.frame = CGRectMake(0, 0, 320, 80);
            }
        }
        
		[cell release];
		[cellBack release];
        
		footHeight = footHeight + 60;
	}
    else {
    }
    NSInteger footheight1 = 0;
//    if (ticaiType == BeiDan || ticaiType == JingCaiZuqiu || ticaiType == ZuQiuDahunTou) {
//        UILabel *lable1 = [[UILabel alloc] init];
//        lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 14);
//        lable1.backgroundColor = [UIColor clearColor];
//        lable1.font = [UIFont systemFontOfSize:12];
//        lable1.text = @"开奖结果不包含加时赛及点球大战";
//        lable1.numberOfLines = 0;
//        lable1.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
//        [footView addSubview:lable1];
//        [lable1 release];
//        footheight1 = footheight1 + 20;
//    }
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"001"] && [self.BetDetailInfo.zanNum length] > 1&& [self.BetDetailInfo.zanNum integerValue] > 0) {
        UILabel *label = [[UILabel alloc] init];
        [footView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"幸运蓝球仅在二等奖派奖期间有效,具体规则请关注派奖公告";
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        label.frame = CGRectMake(10, footHeight + 35, 300, 30);
        footheight1 = footheight1 + 30;
        [label release];
    }
    if (ticaiType == BeiDan || ticaiType == JingCaiZuqiu || ticaiType == ZuQiuDahunTou) {
        BOOL isQuxai = NO;
        for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i ++) {
            if ([[self.BetDetailInfo.betContentArray objectAtIndex:i] rangeOfString:@"取消"].location != NSNotFound) {
                isQuxai = YES;
            }
        }
        if (isQuxai) {
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 14);
            lable1.backgroundColor = [UIColor clearColor];
            lable1.font = [UIFont systemFontOfSize:12];
            lable1.text = @"取消、延期的比赛,一般情况下彩果按猜中计算,赔率为1";
            lable1.numberOfLines = 0;
            lable1.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            [footView addSubview:lable1];
            [lable1 release];
            footheight1 = footheight1 + 20;
        }

    }
    if ((ticaiType == LanQiuRangfen || ticaiType == LanQiuDaxiafen)&& ([self.BetDetailInfo.jackpot isEqualToString:@"未中奖"]||[self.BetDetailInfo.jackpot isEqualToString:@"中奖"])) {
        UILabel *lable1 = [[UILabel alloc] init];
        lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 30);
        lable1.backgroundColor = [UIColor clearColor];
        lable1.font = [UIFont systemFontOfSize:13];
        lable1.text = @"实际大小总分、让分分数以出票时数据为准";
        lable1.numberOfLines = 0;
        lable1.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [footView addSubview:lable1];
        [lable1 release];
        footheight1 = footheight1 + 35;
    }
    if (ticaiType == BeiDan && ([self.BetDetailInfo.jackpot isEqualToString:@"未中奖"]||[self.BetDetailInfo.jackpot isEqualToString:@"中奖"])) {
        UILabel *lable1 = [[UILabel alloc] init];
        lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 60);
        lable1.backgroundColor = [UIColor clearColor];
        lable1.font = [UIFont systemFontOfSize:13];
        lable1.text = @"SP值 由于单场官方采用的奖池型玩法规则,会在开奖时 根据实际投注金额计算彩果的“开奖SP值”,所以会跟您 在投注时看到的“即时SP值”有一定差异,导致与您的预 计奖金不完全相符。";
        lable1.numberOfLines = 0;
        lable1.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [footView addSubview:lable1];
        [lable1 release];
        footheight1 = footheight1 + 65;
        if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"] && ![self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
            footheight1 = footheight1 + 5;
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 40);
            lable1.backgroundColor = [UIColor clearColor];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.text = @"北京单场奖金计算公式\n2元×[所选场次的单场开奖SP值(SP)连乘]×65%.";
            lable1.numberOfLines = 0;
            lable1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [footView addSubview:lable1];
            [lable1 release];
            footheight1 = footheight1 + 40;
        }
        else if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"] && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 18);
            lable1.backgroundColor = [UIColor clearColor];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.text = @"奖金计算: 2 X 出票赔率 X 倍数 X 65%";
            lable1.numberOfLines = 0;
            lable1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [footView addSubview:lable1];
            [lable1 release];
            footheight1 = footheight1 + 20;
            
        }
    }
    if (ticaiType == JingCaiZuqiu || ticaiType == ZuQiuDahunTou) {
        if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"] && ![self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
            footheight1 = footheight1 + 5;
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 35);
            lable1.backgroundColor = [UIColor clearColor];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.text = @"竞彩足球(过关)奖金按照出票赔率值计算 \n过关奖金 = 所选场次赔率值连乘×2元×倍数";
            lable1.numberOfLines = 0;
            lable1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [footView addSubview:lable1];
            [lable1 release];
            footheight1 = footheight1 + 40;
        }
        else if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"] && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
            UILabel *lable1 = [[UILabel alloc] init];
            lable1.frame = CGRectMake(5, footHeight + footheight1, 310, 18);
            lable1.backgroundColor = [UIColor clearColor];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.text = @"奖金计算: 2 X 出票赔率 X 倍数";
            lable1.numberOfLines = 0;
            lable1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            [footView addSubview:lable1];
            [lable1 release];
            footheight1 = footheight1 + 20;
            
        }
    }
    if (footheight1 < 80) {
        footheight1 = 80;
    }
    footHeight = footHeight + footheight1;
    
    if (isMine && !isDanShi) {
        if ([self.BetDetailInfo.drawerState isEqualToString:@"已出票"]&&[self.BetDetailInfo.jackpot isEqualToString:@"等待开奖"]) {
            BOOL caiguo = YES;
            if (isShuZi) {
                if (![self.BetDetailInfo.awardNum length] || [self.BetDetailInfo.awardNum isEqualToString:@"等待开奖"]) {
                    caiguo = NO;
                }
                
            }
            else {
                NSInteger caiguoNum = 4;
                switch (ticaiType) {
                    case ShengFuCai:
                        caiguoNum = 4;
                        break;
                    case JingCaiZuqiu:
                        caiguoNum = 5;
                        break;
                    case BeiDan:
                        caiguoNum = 5;
                        break;
                    case ZuQiuDahunTou:
                        caiguoNum = 5;
                        break;
                    default:
                        caiguoNum = 3;
                        break;
                }
                for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                    
                    NSString *sheng = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                    NSArray *arrcont = [sheng componentsSeparatedByString:@";"];
                    if ([arrcont count] >= caiguoNum) {
                        if ([[arrcont objectAtIndex:caiguoNum] length] == 0 || [[arrcont objectAtIndex:caiguoNum] isEqualToString:@"-"]) {
                            caiguo = NO;
                        }
                    }
                    
                    
                }
            }
            
            if (caiguo) {
                UILabel *ts = [[UILabel alloc] initWithFrame:CGRectMake(227, footHeight +10, 80, 20)];
                ts.backgroundColor = [UIColor clearColor];
                ts.text = @"奖金未到账";
                ts.font = [UIFont systemFontOfSize:12];
                ts.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
                [footView addSubview:ts];
                [ts release];
                
                UIButton *faqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                faqBtn.frame = CGRectMake(280, footHeight  +10, 40, 40);
                faqBtn.backgroundColor = [UIColor clearColor];
                [faqBtn addTarget:self action:@selector(pressFaq3) forControlEvents:UIControlEventTouchUpInside];
                [footView addSubview:faqBtn];
                UIImageView *faqIma = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
                faqIma.backgroundColor = [UIColor clearColor];
                faqIma.image = UIImageGetImageFromName(@"faxqwenhao.png");
                [faqBtn addSubview:faqIma];
                [faqIma release];
                footHeight = footHeight + 40;
            }
            
        }
        else if ([self.BetDetailInfo.jackpot isEqualToString:@"未中奖"] &&![self.BetDetailInfo.lotteryId isEqualToString:@"111"] &&![self.BetDetailInfo.lotteryId isEqualToString:@"122"] && !isHorse){
            UILabel *ts = [[UILabel alloc] initWithFrame:CGRectMake(237, footHeight + 10, 60, 20)];
            ts.backgroundColor = [UIColor clearColor];
            ts.text = @"玩法技巧";
            ts.font = [UIFont systemFontOfSize:15];
            ts.textColor = [UIColor colorWithRed:19.0/255.0 green:179.0/255.0 blue:255.0/255.0 alpha:1];
            [footView addSubview:ts];
            [ts release];
            
            UIButton *faqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            faqBtn.frame = CGRectMake(237, footHeight + 10, 60, 20);
            faqBtn.backgroundColor = [UIColor clearColor];
            [faqBtn addTarget:self action:@selector(pressWanfajiqiao) forControlEvents:UIControlEventTouchUpInside];
            [footView addSubview:faqBtn];
            footHeight = footHeight + 40;
        }
        
    }
        
    UIView *imageView2 = [[UIView alloc] initWithFrame:CGRectMake(0, footHeight, 320, 90)];
    [footView addSubview:imageView2];
    [imageView2 release];
    
    UIView *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [imageView2 addSubview:line1];
    [line1 release];
    
    UILabel *lable1 = [[UILabel alloc] init];
    lable1.frame = CGRectMake(15, 6, 45, 14);
    lable1.backgroundColor = [UIColor clearColor];
    lable1.font = [UIFont systemFontOfSize:13];
    lable1.text = @"订单号";
    if (isHorse) {
        lable1.text = @"无订单号";
        lable1.frame = CGRectMake(15, 6, 60, 14);
    }
    lable1.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    [imageView2 addSubview:lable1];
    [lable1 release];
    
    UILabel *lable2 = [[UILabel alloc] init];
    lable2.frame = CGRectMake(63, 6, 100, 14);
    lable2.backgroundColor = [UIColor clearColor];
    lable2.font = [UIFont systemFontOfSize:13];
    lable2.textAlignment = NSTextAlignmentLeft;
    if (!isHorse) {
        lable2.text = self.BetDetailInfo.programNumber;
    }
    lable2.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    [imageView2 addSubview:lable2];
    [lable2 release];
    
    UILabel *lable4 = [[UILabel alloc] init];
    lable4.frame = CGRectMake(144, 6, 140, 14);
    lable4.backgroundColor = [UIColor clearColor];
    lable4.font = [UIFont systemFontOfSize:13];
    lable4.textAlignment = NSTextAlignmentLeft;
    lable4.text = self.BetDetailInfo.beginTime;
    lable4.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    [imageView2 addSubview:lable4];
    [lable4 release];
    
    
    //出票状态
    UILabel *drawerStateLabel = [[UILabel alloc] init];
    drawerStateLabel.frame = CGRectMake(15, 32, 100, 14);
    drawerStateLabel.backgroundColor = [UIColor clearColor];
    drawerStateLabel.font = [UIFont systemFontOfSize:13];
    drawerStateLabel.text = self.BetDetailInfo.drawerState;
    if (isHorse) {
        drawerStateLabel.hidden = YES;
    }
    drawerStateLabel.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    drawerStateLabel.textAlignment = NSTextAlignmentLeft;
    [imageView2 addSubview:drawerStateLabel];
    [drawerStateLabel release];
    
    if ([self.BetDetailInfo.drawerState isEqualToString:@"出票中"] || [self.BetDetailInfo.drawerState isEqualToString:@"已出票"]) {
        drawerStateLabel.text = [NSString stringWithFormat:@"投注站%@",self.BetDetailInfo.drawerState];
    }
    
//    if ([self.BetDetailInfo.drawerState isEqualToString:@"待出票"]||[self.BetDetailInfo.drawerState isEqualToString:@"出票中"]) {
//        UIButton *faqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        faqBtn.frame = CGRectMake(59, 22, 40, 40);
//        faqBtn.backgroundColor = [UIColor clearColor];
//        [faqBtn addTarget:self action:@selector(pressFaq) forControlEvents:UIControlEventTouchUpInside];
//        [imageView2 addSubview:faqBtn];
//        UIImageView *faqIma = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 20, 20)];
//        faqIma.backgroundColor = [UIColor clearColor];
//        faqIma.image = UIImageGetImageFromName(@"faxqwenhao.png");
//        [faqBtn addSubview:faqIma];
//        [faqIma release];
//    }
    
    //中奖状态
    UILabel *jackpotLabel = [[UILabel alloc] init];
    jackpotLabel.frame = CGRectMake(144, 32, 55, 14);
    if (isHorse) {
        jackpotLabel.frame = CGRectMake(15, 32, 55, 14);
    }
    jackpotLabel.backgroundColor = [UIColor clearColor];
    jackpotLabel.font = [UIFont systemFontOfSize:13];
    jackpotLabel.text = self.BetDetailInfo.jackpot;
    jackpotLabel.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    jackpotLabel.textAlignment = NSTextAlignmentLeft;
    [imageView2 addSubview:jackpotLabel];
    [jackpotLabel release];
    
    
    if(![self.BetDetailInfo.zhuihaoqingkong isEqualToString:@""] || waibubool){
        UILabel *lable7 = [[UILabel alloc] init];
        lable7.frame = CGRectMake(244, 32, 30, 14);
        lable7.backgroundColor = [UIColor clearColor];
        lable7.font = [UIFont systemFontOfSize:13];
        lable7.textAlignment = NSTextAlignmentRight;
        //        lable7.text = self.BetDetailInfo.sponsorsName;
        lable7.text = @"追号 ";
        lable7.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [imageView2 addSubview:lable7];
        [lable7 release];
        
        UILabel *lable8 = [[UILabel alloc] init];
        lable8.frame = CGRectMake(274, 32, 95, 14);
        lable8.backgroundColor = [UIColor clearColor];
        lable8.font = [UIFont systemFontOfSize:13];
        lable8.textAlignment = NSTextAlignmentLeft;
        //        lable7.text = self.BetDetailInfo.sponsorsName;
        if(waibubool){
            lable8.text = chuanzhuihao;
            lable8.text = [lable8.text stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
        }else{
            lable8.text = self.BetDetailInfo.zhuihaoqingkong;
            lable8.text = [lable8.text stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
        }
        //            lable8.text = @"50/50";
        
        lable8.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [imageView2 addSubview:lable8];
        [lable8 release];
    }
    
    
//    if (isMine && [self.BetDetailInfo.lotterySeqNum length] && !isHorse) {
//        UILabel *xuelieLabel = [[UILabel alloc] init];
//        xuelieLabel.frame = CGRectMake(15, 58, 70, 17);
//        xuelieLabel.backgroundColor = [UIColor clearColor];
//        xuelieLabel.font = [UIFont systemFontOfSize:12];
//        xuelieLabel.text = @"彩票序列号";
//        xuelieLabel.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
//        [imageView2 addSubview:xuelieLabel];
//        [xuelieLabel release];
//        
//        UILabel *xuelieLabel2 = [[UILabel alloc] init];
//        xuelieLabel2.frame = CGRectMake(99, 40, 210, 17);
//        xuelieLabel2.backgroundColor = [UIColor clearColor];
//        xuelieLabel2.font = [UIFont systemFontOfSize:13];
//        xuelieLabel2.text = [self.BetDetailInfo.lotterySeqNum stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
//        
//        xuelieLabel2.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
//        xuelieLabel2.numberOfLines = 0;
//        xuelieLabel2.lineBreakMode = UILineBreakModeTailTruncation;
//        CGSize maxSize = CGSizeMake(210, 1000);
//        CGSize expectedSize = [xuelieLabel2.text sizeWithFont:xuelieLabel2.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
//        [imageView2 addSubview:xuelieLabel2];
//        if (expectedSize.height > 35) {
//            expectedSize.height = 35;
//        }
//        xuelieLabel2.frame = CGRectMake(99, 58, 210, expectedSize.height);
//        [xuelieLabel2 release];
//        imageView2.frame = CGRectMake(0, footHeight, 320, 90 + expectedSize.height + 10);
//    }
    
    UILabel *lableinfo = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView2.frame.size.height - 25, 290, 15)];
    lableinfo.backgroundColor = [UIColor clearColor];
    if (!isHorse) {
        lableinfo.text = @"大奖专人通知，小奖直接派送到账户,可随时提款";
    }
    lableinfo.font = [UIFont systemFontOfSize:12];
    [imageView2 addSubview:lableinfo];
    if ([self.BetDetailInfo.jackpot isEqualToString:@"中奖"]) {
        lableinfo.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    }
    else {
        lableinfo.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
    }
    
    [lableinfo release];
    
	footHeight = footHeight + imageView2.bounds.size.height;
	footView.frame = CGRectMake(0, 0, 320, footHeight);
	
	[myTableView setTableFooterView:footView];
	[footView release];
}

- (void)doBack {
    for (GouCaiShuZiInfoViewController *con1 in self.navigationController.viewControllers) {
        if ([con1 isKindOfClass:[GouCaiShuZiInfoViewController class]] || [con1 isKindOfClass:[GC_ShengfuInfoViewController class]]) {
            if ([con1 isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                [con1 clearBetArray];
            }
            
            NSInteger index = [self.navigationController.viewControllers indexOfObject:con1];
            if (index > 1) {
                UIViewController *con2 = [self.navigationController.viewControllers objectAtIndex:index - 1];
                [self.navigationController popToViewController:con2 animated:YES];
                return;
            }
        }
    }
    
    if(self.isFromFlashAdAndLogin)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(buySuccess:)]) {
        [delegate buySuccess:yuE];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)quxiao {
    [self hidenJianPan];
    if (tanchuView.hidden == NO) {
        tanchuView.hidden = YES;
        con.enabled = NO;
    }
}


//进入常用问题界面
- (void)pressFaq {
    
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = Weichupiao;
//#ifdef isCaiPiaoForIPad
//    [faq Show:self];
//#else
//    [faq Show];
//#endif
//    
//    [faq release];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = WeichupiaoType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
}
- (void)pressFaq2 {
    
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = Zhongjiang;
//#ifdef isCaiPiaoForIPad
//    [faq Show:self];
//#else
//    [faq Show];
//#endif
//    [faq release];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = ZhongjiangType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
}

- (void)pressFaq3 {
    
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = Paijiangqian;
//#ifdef isCaiPiaoForIPad
//    [faq Show:self];
//#else
//    [faq Show];
//#endif
//    [faq release];
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = PaijiangqianType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
}

- (void)pressWanfajiqiao {
    Caizhong cz = 0;
    NSLog(@"cz=%@",self.BetDetailInfo.lotteryId);
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"001"]) {
        cz = shuangsheqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"113"]) {
        cz = daletou;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"110"]) {
        cz = qixincai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"108"]) {
        cz = pai3;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"109"]) {
        cz = pai5;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]) {
        cz = bjdanchang;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"202"]) {
        cz = jincaizuqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"200"] || [self.BetDetailInfo.lotteryId isEqualToString:@"203"]) {
        cz = jingcailanqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"002"]) {
        cz = fucai3d;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"003"]) {
        cz = qilecai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"006"]||[self.BetDetailInfo.lotteryId isEqualToString:@"014"]) {
        cz = shishicai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [self.BetDetailInfo.lotteryId isEqualToString:@"119"] || [self.BetDetailInfo.lotteryId isEqualToString:@"121"] || [self.BetDetailInfo.lotteryId isEqualToString:@"123"] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {
        cz = shiyixuan5;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"011"]) {
        cz = kuaileshifen;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]) {
        cz = ticai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]) {
        cz = ticai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"012"] || [self.BetDetailInfo.lotteryId isEqualToString:@"013"] || [self.BetDetailInfo.lotteryId isEqualToString:@"019"] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
        cz = k3;
    }
    else {
        [[caiboAppDelegate getAppDelegate] showMessage:@"暂无技巧"];
        return;
    }
    
    
    
    TouzhujiqiaoViewController *jq = [[TouzhujiqiaoViewController alloc] init];
    [self.navigationController pushViewController:jq animated:YES];
    [jq Jiqiao:cz];
    [jq release];
}

- (void)pressChongZhi{
    if (cheDanBool) {
        return;
    }
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    //    [allimage addObject:@"caidansssx.png"];
    //    [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
    //    [allimage addObject:@"GC_sanjiShuoming.png"];
    //
    //    [alltitle addObject:@"联赛筛选"];
    //    [alltitle addObject:@"玩法选择"];
    //    [alltitle addObject:@"玩法说明"];
    
    
    
    //    if (!tanchuView) {
    //        con.enabled = YES;
    //        tanchuView = [[UIImageView alloc] init];
    //        [self.mainView addSubview:tanchuView];
    //        tanchuView.image = [UIImageGetImageFromName(@"GC_chaodanbg.png") stretchableImageWithLeftCapWidth:0 topCapHeight:20];
    //        tanchuView.userInteractionEnabled = YES;
    //        [tanchuView release];
    
    
    if ([myTableView numberOfRowsInSection:0]!= 0 && !isDanShi) {
        if (isShuZi || (![self.BetDetailInfo.endTime isEqualToString:@"已截期"] && !([self.BetDetailInfo.betStyle isEqualToString:@"胆拖"] && [self.BetDetailInfo.lotteryId isEqualToString:@"301"]))) {
            if (!isJJYH) {
                NSLog(@"%d  %d", ticaiType == JingCaiZuqiu, ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]));
                
                if (!(ticaiType == JingCaiZuqiu && ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"])) &&  !([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"] && [self.BetDetailInfo.lotteryId isEqualToString:@"201"]) && !([self.BetDetailInfo.wanfaId isEqualToString:@"01"] && [self.BetDetailInfo.lotteryId isEqualToString:@"201"])) {
                    
                    [allimage addObject:@"GC_chaodan.png"];
                    [alltitle addObject:@"抄单购买"];
                    
                }
                
            }
            
            //                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //                [btn addTarget:self action:@selector(chaodan) forControlEvents:UIControlEventTouchUpInside];
            //                btn.frame = CGRectMake(0, 14+37*[tanchuView.subviews count], 161, 37);
            //                [tanchuView addSubview:btn];
            //
            //                UIImageView *imageV = [[UIImageView alloc] init];
            //                [btn addSubview:imageV];
            //                imageV.frame = CGRectMake(15, 10, 18.5,17);
            //                imageV.image = UIImageGetImageFromName(@"GC_chaodan.png");
            //                [imageV release];
            //
            //                UILabel *label = [[UILabel alloc] init];
            //                label.backgroundColor = [UIColor clearColor];
            //                label.frame = CGRectMake (45,10,140,17);
            //                label.textColor = [UIColor whiteColor];
            //                label.text = @"抄单购买";
            //                label.font = [UIFont systemFontOfSize:13];
            //                [btn addSubview:label];
            //                [label release];
            
        }
    }
    if ([allimage count] == 0) {
        [allimage addObject:@"GC_chaodan.png"];
        [alltitle addObject:@"无法抄单"];
    }
    if (isMine) {
        
        [allimage addObject:@"GC_fangAnsetting.png"];
        [alltitle addObject:@"方案设置"];
        
        //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //            [btn addTarget:self action:@selector(eidteFanAn) forControlEvents:UIControlEventTouchUpInside];
        //
        //            btn.frame = CGRectMake(0, 14+37*[tanchuView.subviews count], 161, 37);
        //
        //            if ([tanchuView.subviews count] != 0) {
        //                UIImageView *imageLine = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_bgline.png")];
        //                [btn addSubview:imageLine];
        //                imageLine.frame = CGRectMake(0, 0, 161, 2);
        //                [imageLine release];
        //            }
        //            [tanchuView addSubview:btn];
        //            UIImageView *imageV = [[UIImageView alloc] init];
        //            [btn addSubview:imageV];
        //            imageV.frame = CGRectMake(15, 10, 18.5,17);
        //            imageV.image = UIImageGetImageFromName(@"GCFASet.png");
        //            [imageV release];
        //
        //            UILabel *label = [[UILabel alloc] init];
        //            label.backgroundColor = [UIColor clearColor];
        //            label.frame = CGRectMake (45,10,140,17);
        //            label.textColor = [UIColor whiteColor];
        //            label.text = @"方案设置";
        //            label.font = [UIFont systemFontOfSize:13];
        //            [btn addSubview:label];
        //            [label release];
        
    }
    
    if (isMine && !isShuZi &&!([self.BetDetailInfo.jackpot isEqualToString:@"未中奖"]||[self.BetDetailInfo.jackpot isEqualToString:@"中奖"] )) {
        if (![self.BetDetailInfo.jackpot isEqualToString:@"未开奖"]) {
//            if (![self.BetDetailInfo.lotteryId isEqualToString:@"200"]) {
                [allimage addObject:@"GC_zhibo.png"];
                [alltitle addObject:@"比分直播"];
//            }
            
            //                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //                [btn addTarget:self action:@selector(bifenzhibo) forControlEvents:UIControlEventTouchUpInside];
            //
            //                btn.frame = CGRectMake(0, 14+37*[tanchuView.subviews count], 161, 37);
            //
            //                if ([tanchuView.subviews count] != 0) {
            //                    UIImageView *imageLine = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_bgline.png")];
            //                    [btn addSubview:imageLine];
            //                    imageLine.frame = CGRectMake(0, 0, 161, 2);
            //                    [imageLine release];
            //                }
            //                [tanchuView addSubview:btn];
            //                UIImageView *imageV = [[UIImageView alloc] init];
            //                [btn addSubview:imageV];
            //                imageV.frame = CGRectMake(15, 10, 18.5,17);
            //                imageV.image = UIImageGetImageFromName(@"GC_zhibo.png");
            //                [imageV release];
            //
            //                UILabel *label = [[UILabel alloc] init];
            //                label.backgroundColor = [UIColor clearColor];
            //                label.frame = CGRectMake (45,10,140,17);
            //                label.textColor = [UIColor whiteColor];
            //                label.text = @"比分直播";
            //                label.font = [UIFont systemFontOfSize:13];
            //                [btn addSubview:label];
            //                [label release];
            
        }
    }
    
    
    if (!isShuZi &&(![self.BetDetailInfo.endTime isEqualToString:@"已截期"]&&[myTableView numberOfRowsInSection:0]!=0 && ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]))) {
//        [allimage addObject:@"GC_yaoqing.png"];
//        [alltitle addObject:@"邀请他人"];
        //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //            [btn addTarget:self action:@selector(yaoqing) forControlEvents:UIControlEventTouchUpInside];
        //
        //
        //            btn.frame = CGRectMake(0, 14+37*[tanchuView.subviews count], 161, 37);
        //
        //            if ([tanchuView.subviews count] != 0) {
        //                UIImageView *imageLine = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_bgline.png")];
        //                [btn addSubview:imageLine];
        //                imageLine.frame = CGRectMake(0, 0, 154.5, 2);
        //                [imageLine release];
        //            }
        //            [tanchuView addSubview:btn];
        //            UIImageView *imageV = [[UIImageView alloc] init];
        //            [btn addSubview:imageV];
        //            imageV.frame = CGRectMake(15, 10, 18.5,17);
        //            imageV.image = UIImageGetImageFromName(@"GC_yaoqing.png");
        //            [imageV release];
        //
        //            UILabel *label = [[UILabel alloc] init];
        //            label.backgroundColor = [UIColor clearColor];
        //            label.frame = CGRectMake (45,10,140,17);
        //            label.textColor = [UIColor whiteColor];
        //            label.text = @"邀请他人参与";
        //            label.font = [UIFont systemFontOfSize:13];
        //            [btn addSubview:label];
        //            [label release];
    }
    //        if ([myTableView numberOfRowsInSection:0]!= 0 && !isShuZi) {
    //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //            [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //
    //
    //            btn.frame = CGRectMake(0, 14+37*[tanchuView.subviews count], 161, 37);
    //
    //            if ([tanchuView.subviews count] != 0) {
    //                UIImageView *imageLine = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_bgline.png")];
    //                [btn addSubview:imageLine];
    //                imageLine.frame = CGRectMake(0, 0, 161, 2);
    //                [imageLine release];
    //            }
    //            [tanchuView addSubview:btn];
    //            UIImageView *imageV = [[UIImageView alloc] init];
    //            [btn addSubview:imageV];
    //            imageV.frame = CGRectMake(15, 10, 18.5,17);
    //            imageV.image = UIImageGetImageFromName(@"GC_share.png");
    //            [imageV release];
    //
    //            UILabel *label = [[UILabel alloc] init];
    //            label.backgroundColor = [UIColor clearColor];
    //            label.frame = CGRectMake (45,10,140,17);
    //            label.textColor = [UIColor whiteColor];
    //            [btn addSubview:label];
    //            label.font = [UIFont systemFontOfSize:13];
    //            label.text = @"分享到新浪微博";
    //            [label release];
    //        }
    //        tanchuView.frame = CGRectMake(158, 0, 161, 17+37*[tanchuView.subviews count]);
    //    }
    //    else {
    //        tanchuView.hidden = !tanchuView.hidden;
    //        con.enabled = !tanchuView.hidden;
    //        }
    if (isMine &&([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) &&![self.BetDetailInfo.endTime isEqualToString:@"已截期"]&&![self.BetDetailInfo.drawerState isEqualToString:@"撤单"] && ![self.BetDetailInfo.projectSchedule isEqualToString:@"100%"]) {
        [allimage addObject:@"revocationImge.png"];
        [alltitle addObject:@"撤单"];
        
    }
    
    if (isMine && [self.BetDetailInfo.shishibifen intValue] == 2) {
        
        [allimage addObject:@"revocationImge.png"];
        [alltitle addObject:@"撤单"];
        
    }
    
    
//    [allimage addObject:@"fenxangxiangqing.png"];
//    [alltitle addObject:@"分享"];    
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
    
    //    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    //
    //    [httpRequest clearDelegatesAndCancel];
    //    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    //    [httpRequest setRequestMethod:@"POST"];
    //    [httpRequest addCommHeaders];
    //    [httpRequest setPostBody:postData];
    //    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    //    [httpRequest setDelegate:self];
    //    [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
    //    [httpRequest startAsynchronous];
	
	// NSLog(@"url = %@", [[GC_HttpService sharedInstance] reChangeUrl]);
	//[[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrl]];
}

- (void)returnSelectButton:(UIButton *)sender{
    
    UILabel * labelbut = (UILabel *)[sender viewWithTag:10];
    
    if ([labelbut.text isEqualToString:@"抄单购买"]) {
        
        [self chaodan];
        
    }else if ([labelbut.text isEqualToString:@"方案设置"]) {
        
        [self eidteFanAn];
        
    }else if ([labelbut.text isEqualToString:@"比分直播"]) {
        
        [self bifenzhibo];
        
    }else if ([labelbut.text isEqualToString:@"邀请他人"]) {
        
        [self yaoqing];
        
    }else if ([labelbut.text isEqualToString:@"刷新"]) {
        
        
        [self getDetailInfo];
        
    }else if([labelbut.text isEqualToString:@"分享"]){
        if (self.isHongrenBang) {
            [MobClick event:@"event_gonglue_fanxiangqingfenxiang"];
        }
        [MobClick event:@"event_fanganxiangqing_fenxiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId]];
        CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        lb2.delegate = self;
        lb2.tag = 103;
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            lb2.weixinBool = YES;
            [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到新浪微博",@"分享到腾讯微博", @"彩民微博",@"分享到微信朋友圈(未安装)",nil]];
        }else{
            lb2.weixinBool = NO;
            [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到微信朋友圈",@"分享到新浪微博",@"分享到腾讯微博", @"彩民微博",nil]];
        }
        
        
        lb2.isSelcetType = YES;
        [lb2 show];
        [lb2 release];
        
    }
    else if([labelbut.text isEqualToString:@"撤单"]) {
        
        if ([self.BetDetailInfo.shishibifen intValue] == 2) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"确认撤销订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            [alert show];
            alert.tag = 199;
            [alert release];
        }else{
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"确认撤销订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            [alert show];
            alert.tag = 101;
            [alert release];
        }
        
    }
    
}

- (NSString *)urlFaxqFunc{

    NSString * urlString = @"";
    
    NSString * modeString = @"";
    if (self.BetInfo.mode && [self.BetInfo.mode length] > 1 && ![self.BetInfo.mode isEqualToString:@"(null)"]) {//玩法
        modeString = self.BetInfo.mode;
    }
    else {
        modeString = [GC_LotteryType wanfaNameWithLotteryID:self.BetDetailInfo.lotteryId WanFaId:self.BetDetailInfo.wanfaId];
        if ([self.BetDetailInfo.OutorderId rangeOfString:@"2x1"].location != NSNotFound) {
            modeString = @"混合二选一";
        }
    }
    
    if (modeString == nil || [modeString length] == 0) {
        modeString = @"";
    }
    
    urlString = [NSString stringWithFormat:@"%@%@~ http://caipiao365.com/faxq=%@ ", [GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId], modeString, self.BetDetailInfo.programNumber];
    return urlString;
}


- (void)sinaShareFunc{//新浪分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:myTableView bottomY:myTableView.contentSize.height  titleBool:YES];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.infoShare = YES;
//    publishController.lotteryID = self.BetDetailInfo.programNumber;
//    publishController.mSelectImage = screenImage;
//    publishController.publishType = kNewTopicController;
//    publishController.shareTo = @"1";
//    publishController.title = @"分享微博";
//#ifdef isCaiPiaoForIPad
//    //     publishController.publishType = KShareController;
//    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//    [publishController release];
//#else
//    [self.navigationController pushViewController:publishController animated:YES];
//    [publishController release];
//    
//#endif
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
 
    publishController.infoShare = YES;
    publishController.lotteryID = self.BetDetailInfo.programNumber;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.shareTo = @"1";
    publishController.faxqUlr = [self urlFaxqFunc];
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
    
    [self.CP_navigation clearMarkLabel];
    
}

- (void)qqZoneShareFunc{//qq空间分享
    
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:myTableView bottomY:myTableView.contentSize.height  titleBool:YES];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    //            [publishController setMStatus: mStatus];
//    //            publishController.isShare = YES;
//    publishController.mSelectImage = screenImage;
//    publishController.lotteryID = self.BetDetailInfo.programNumber;
//    publishController.infoShare = YES;
//    publishController.publishType = kNewTopicController;
//    publishController.shareTo = @"3";
//    publishController.title = @"分享微博";
//#ifdef isCaiPiaoForIPad
//    //     publishController.publishType = KShareController;
//    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//    [publishController release];
//#else
//   
//    [self.navigationController pushViewController:publishController animated:YES];
//    [publishController release];
//#endif
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.mSelectImage = screenImage;
    publishController.lotteryID = self.BetDetailInfo.programNumber;
    publishController.infoShare = YES;
    publishController.microblogType = NewTopicController;
    publishController.shareTo = @"3";
    publishController.faxqUlr = [self urlFaxqFunc];
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
    [self.CP_navigation clearMarkLabel];
}


- (void)qqWeiboShareFunc{//qq微博分享
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:myTableView bottomY:myTableView.contentSize.height  titleBool:YES];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.lotteryID = self.BetDetailInfo.programNumber;
//    //            [publishController setMStatus: mStatus];
//    publishController.infoShare = YES;
//    publishController.mSelectImage = screenImage;
//    publishController.publishType = kNewTopicController;
//    publishController.shareTo = @"2";
//    publishController.title = @"分享微博";
//#ifdef isCaiPiaoForIPad
//    //     publishController.publishType = KShareController;
//    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//    [publishController release];
//#else
//    
//    [self.navigationController pushViewController:publishController animated:YES];
//    [publishController release];
//#endif
    
    
   
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.lotteryID = self.BetDetailInfo.programNumber;
    //            [publishController setMStatus: mStatus];
    publishController.infoShare = YES;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.shareTo = @"2";
    publishController.faxqUlr = [self urlFaxqFunc];
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
    
    [self.CP_navigation clearMarkLabel];
    
}

- (void)cmwbShareFunc{
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:myTableView bottomY:myTableView.contentSize.height  titleBool:YES];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    
    
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.lotteryID = self.BetDetailInfo.programNumber;
//    //            [publishController setMStatus: mStatus];
//    publishController.infoShare = YES;
//    publishController.mSelectImage = screenImage;
//    publishController.publishType = kNewTopicController;
//    publishController.title = @"分享微博";
//    //    publishController.shareTo = @"0";
//#ifdef isCaiPiaoForIPad
//    //     publishController.publishType = KShareController;
//    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//    [publishController release];
//#else
// 
//    [self.navigationController pushViewController:publishController animated:YES];
//    [publishController release];
//#endif
//    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.lotteryID = self.BetDetailInfo.programNumber;
    //            [publishController setMStatus: mStatus];
    publishController.infoShare = YES;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.faxqUlr = [self urlFaxqFunc];
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
    [self.CP_navigation clearMarkLabel];
}

- (void)shareWeiXin{//微信分享
//    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//    UIImage * screenImage =  [appcaibo imageWithScreenContents];
//    [MobClick event:@"event_wodecaipiao_weixinfenxiang"];
//    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//    [appcaibo sendImageContent:screenImage];
//    [self.CP_navigation clearMarkLabel];
//
    
//    NSLog(@"backScrollView = %f,  %f", myTableView.contentSize.width, myTableView.contentSize.height);
    
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:myTableView bottomY:myTableView.contentSize.height  titleBool:YES];
    [MobClick event:@"event_wodecaipiao_weixinfenxiang"];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    [appcaibo sendImageContent:screenImage];
    [self.CP_navigation clearMarkLabel];
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (liebiaoView.tag == 103) {
        if ([nikeName isEqualToString:@""] || !nikeName) {
            self.nikeName = self.BetDetailInfo.sponsorsName;
        }
        [self.CP_navigation markNavigationViewUserName:nikeName];
        if (liebiaoView.weixinBool) {
            if (buttonIndex == 3) {//微信
                
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
                
                
                
            }
            else if (buttonIndex == 0) {//新浪微博
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
                
                
            }
            else if(buttonIndex == 1){//腾讯微博
                
                [self performSelector:@selector(qqWeiboShareFunc) withObject:nil afterDelay:0.3];
                
                
            }else if(buttonIndex == 2){//彩民微博
                
                [self performSelector:@selector(cmwbShareFunc) withObject:nil afterDelay:0.3];
                
            }
            
        }
        else {
            if (buttonIndex == 0) {//微信
                
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
                
                
                
            }
            else if (buttonIndex == 1) {//新浪微博
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
                
                
            }
            else if(buttonIndex == 2){//腾讯微博
                
                [self performSelector:@selector(qqWeiboShareFunc) withObject:nil afterDelay:0.3];
                
                
            }else if(buttonIndex == 3){//彩民微博
                
                [self performSelector:@selector(cmwbShareFunc) withObject:nil afterDelay:0.3];
                
            }
        }
        
        
    }
    
}



- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
}
- (void)getDetailInfo {
    isLoading = YES;
	[self.httpRequest clearDelegatesAndCancel];
    if (isShishi) {
        [self refreshBifen];
        return;
    }
    NSMutableData *postData = nil;
    if (self.BetInfo) {
        NSString *jiangli = @"0";
        if (isJiangli) {
            jiangli = @"1";
        }
        if (self.BetInfo.yuliustring && [self.BetInfo.yuliustring length] > 0) {
            jiangli = [NSString stringWithFormat:@"%@&%@",jiangli   ,self.BetInfo.yuliustring];
        }else{
            jiangli = [NSString stringWithFormat:@"%@&",jiangli   ];
        }
        if ([self.BetInfo.lotteryNum isEqualToString:@"202"]||[self.BetInfo.lotteryNum isEqualToString:@"203"]) {
            jiangli = @"huntou";
        }
        NSLog(@"jiangli = %@", jiangli);
        postData  = [[GC_HttpService sharedInstance] reBetRecordInfor:self.BetInfo.programNumber Issue:self.BetInfo.issue numberOfPage:50 Page:1 IsJIangli:jiangli];
    }
    else {
        NSString *jiangli = @"0";
        if (isJiangli) {
            jiangli = @"1";
        }
        if (self.BetInfo.yuliustring && [self.BetInfo.yuliustring length] > 0) {
            jiangli = [NSString stringWithFormat:@"%@&%@",jiangli   ,self.BetInfo.yuliustring];
        }else{
            jiangli = [NSString stringWithFormat:@"%@&",jiangli   ];
        }
        NSLog(@"jiangli = %@", jiangli);
        //       / jiangli = [NSString stringWithFormat:@"&%@", self.BetInfo.yuliustring];
        postData  = [[GC_HttpService sharedInstance] reBetRecordInfor:self.orderId Issue:self.issure numberOfPage:50 Page:1 IsJIangli:jiangli];
    }
    if (isHorse) {
        postData  = [[GC_HttpService sharedInstance] req_GetPKDetail:BetInfo.programNumber];
    }
	[httpRequest clearDelegatesAndCancel];
	self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[httpRequest setRequestMethod:@"POST"];
	[httpRequest addCommHeaders];
	[httpRequest setPostBody:postData];
	[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[httpRequest setDelegate:self];
	[httpRequest setDidFinishSelector:@selector(reBetRecordDetailFinished:)];
	[httpRequest startAsynchronous];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[rengouText resignFirstResponder];
}

- (void)pressaddbutton:(UIButton *)sender {
	if ([rengouText.text intValue] >= [self.BetDetailInfo.subscriptionAmount intValue]) {
		rengouText.text = [NSString stringWithFormat:@"%@",self.BetDetailInfo.subscriptionAmount];
	}
	else {
		rengouText.text = [NSString stringWithFormat:@"%d",[rengouText.text intValue] + 1];
	}
	yingfuLable.text = [NSString stringWithFormat:@"应支付<%@>元",rengouText.text];
}

- (void)pressjianbutton:(UIButton *)sender {
	if ([rengouText.text intValue] <= 1 ) {
		rengouText.text = @"1";
	}
	else {
		rengouText.text = [NSString stringWithFormat:@"%d",[rengouText.text intValue] - 1];
	}
	yingfuLable.text = [NSString stringWithFormat:@"应支付<%@>元",rengouText.text];
}

- (void)wanfaInfo {
    [MobClick event:@"event_goucai_fananxiangqing_hemaiFAQ" label:[GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId]];
    Caizhong cz = 0;
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"001"]) {
        cz = shuangsheqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"113"]) {
        cz = daletou;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"110"]) {
        cz = qixincai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"108"]) {
        cz = pai3;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"109"]) {
        cz = pai5;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]) {
        cz = bjdanchang;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"202"]) {
        cz = jincaizuqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"200"] || [self.BetDetailInfo.lotteryId isEqualToString:@"203"]) {
        cz = jingcailanqiu;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"002"]) {
        cz = fucai3d;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"003"]) {
        cz = qilecai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"006"]||[self.BetDetailInfo.lotteryId isEqualToString:@"014"]) {
        cz = shishicai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [self.BetDetailInfo.lotteryId isEqualToString:@"119"] || [self.BetDetailInfo.lotteryId isEqualToString:@"121"] || [self.BetDetailInfo.lotteryId isEqualToString:@"123"] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {
        cz = shiyixuan5;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"011"]) {
        cz = kuaileshifen;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]) {
        cz = ticai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]) {
        cz = ticai;
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"012"] || [self.BetDetailInfo.lotteryId isEqualToString:@"013"] || [self.BetDetailInfo.lotteryId isEqualToString:@"019"] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
        cz = k3;
    }
    
    
    
	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = HeMai;
    xie.caizhongJQ = cz;
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
}

- (void)send {
    
    
	[self hidenJianPan];
    if ([rengouText.text intValue] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"认购份数不能为0" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
        
        return;
    }
    [MobClick event:@"event_goucai_fanganxiangqing_canyuhemai" label:[GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId]];
#ifdef isYueYuBan
    if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < [rengouText.text floatValue] || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
        aler.tag = 109;
        [aler show];
        [aler release];
        
        return;
    }
    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 119;
    [aler show];
    [aler release];
    return;
    
#else
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < [rengouText.text floatValue] || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
            
            return;
        }
    }else{
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < [rengouText.text floatValue] && [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] != 0) {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
            
            return;
        }
    }
    
    [self getBuyLotteryRequest];
#endif
}

- (void)getBuyLotteryRequest{
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqBuyTogether:self.BetDetailInfo.lotteryId schemeNumber:[self.BetDetailInfo.programNumber intValue] buyCount:[rengouText.text intValue] amount:[rengouText.text intValue] reSend:[[Info getInstance] caipaocount]];
	
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[self.httpRequest setDidFinishSelector:@selector(requestBuyTogetherFinished:)];
	[self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[self.httpRequest setRequestMethod:@"POST"];
	[self.httpRequest setPostBody:postData];
	[self.httpRequest setDelegate:self];
	[self.httpRequest addCommHeaders];
	[self.httpRequest startAsynchronous];
}

- (void)goHome {
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)eidteFanAn {
    [self quxiao];
    
    if (!editeView) {
        //        CP_UIAlertView
        editeView = [[UIView alloc] initWithFrame:[caiboAppDelegate getAppDelegate].window.bounds];
        editeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        UIImageView *backImageV = [[UIImageView alloc] init];
        backImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG1.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
        backImageV.frame = CGRectMake(24, 130, 272, 260);
        backImageV.center = editeView.center;
        backImageV.userInteractionEnabled = YES;
        [editeView addSubview:backImageV];

        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, backImageV.frame.size.width, 40)];
        lable.text = @"方案设置";
        [backImageV addSubview:lable];
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:17];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor clearColor];
        [lable release];
//        [titleImage release];
        
        if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
            
//            titleImage.frame = CGRectMake(87.5, 1, 125, 30);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, ORIGIN_Y(lable), 100, 30)];
            label.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:label];
            label.font = [UIFont systemFontOfSize:15];
            label.text  = @"方案宣言";
            label.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:128/255.0];
            [label release];
            
            UIImageView *xuanim = [[UIImageView alloc] initWithFrame:CGRectMake(label.frame.origin.x, ORIGIN_Y(label) + 8, backImageV.frame.size.width - label.frame.origin.x * 2, 30)];
            [backImageV addSubview:xuanim];
            xuanim.userInteractionEnabled = YES;
            xuanim.image = [UIImageGetImageFromName(@"XuanYanBG.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            [xuanim release];
            
//            recoderBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//            recoderBtn.frame = xuanim.frame;
//            [recoderBtn loadButonImage:@"CP_PTButton" LabelName:@"按住录音"];
////            [recoderBtn setBackgroundImage:[UIImageGetImageFromName(@"zhuceanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
//            [recoderBtn setBackgroundImage:[UIImageGetImageFromName(@"zhuceanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
//            [recoderBtn addTarget:self action:@selector(recorderBegin) forControlEvents:UIControlEventTouchDown];
//            [recoderBtn addTarget:self action:@selector(recorderEnd) forControlEvents:UIControlEventTouchCancel];
//            [recoderBtn addTarget:self action:@selector(recorderEnd) forControlEvents:UIControlEventTouchUpInside];
//            [backImageV addSubview:recoderBtn];
//            recoderBtn.buttonName.textColor = [UIColor whiteColor];
//            recoderBtn.buttonName.shadowColor = [UIColor clearColor];
//            recoderBtn.backgroundColor=[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1];
//            recoderBtn.layer.masksToBounds=YES;
//            recoderBtn.layer.cornerRadius=5.0;
//            
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"VoiceIcon.png")];
//            imageView.frame = CGRectMake(10, 12, 7, 7);
//            recoderBtn.otherImage = imageView;
//            recoderBtn.otherImage.hidden = YES;
//            [imageView release];

            
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(4, 0, xuanim.frame.size.width - 5, xuanim.frame.size.height)];
            scrollView.backgroundColor = [UIColor clearColor];
            [xuanim addSubview:scrollView];
            [scrollView release];
            
            xuanyanText = [[UITextField alloc] init];
            xuanyanText.delegate = self;
            xuanyanText.text = self.BetDetailInfo.programDeclaration;
            xuanyanText.frame = scrollView.bounds;
            xuanyanText.font = [UIFont systemFontOfSize:12];
            xuanyanText.textAlignment = NSTextAlignmentCenter;
            xuanyanText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            xuanyanText.textAlignment = 0;
            xuanyanText.backgroundColor = [UIColor clearColor];
            [scrollView addSubview:xuanyanText];
//            xuanyanText.superview.superview.hidden = YES;
            [xuanyanText release];
            
            placeholderLabel = [[UILabel alloc] initWithFrame:scrollView.bounds];
            placeholderLabel.textAlignment = 0;
            placeholderLabel.text = @"我出方案你受益，跟的多中的多";
            placeholderLabel.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
            placeholderLabel.font = [UIFont systemFontOfSize:12];
            placeholderLabel.backgroundColor = [UIColor clearColor];
            [scrollView addSubview:placeholderLabel];
            if ([xuanyanText.text length]) {
                placeholderLabel.hidden = YES;
            }
            
//            deleteBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//            deleteBtn.frame = CGRectMake(ORIGIN_X(xuanim), xuanim.frame.origin.y - 12, 50, 50);
//            [backImageV addSubview:deleteBtn];
//            [deleteBtn addTarget:self action:@selector(recorderDelete) forControlEvents:UIControlEventTouchUpInside];
//            [deleteBtn loadButonImage:@"tongyongxuanzhong.png" LabelName:nil];
//            deleteBtn.buttonImage.frame = CGRectMake(0, 0, 30, 30);
//            UIImageView *other = [[UIImageView alloc] init];
//            other.frame = CGRectMake(0, 0, 18, 22);
//            deleteBtn.otherImage = other;
//            [other release];
//            deleteBtn.buttonImage.center = CGPointMake(25, 25);
//            deleteBtn.otherImage.center =CGPointMake(25, 25);
//            deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaibi.png");
            
//            if (self.BetDetailInfo.voiceLong == 0 &&!isGoodVoice) {
//                GoovoiceType = yuyinwithnone;
////                [self recorderDelete];
//                VoiceIsChange = NO;
//            }
//            else {
//                recoderBtn.buttonName.text = [NSString stringWithFormat:@"%d\"   ",self.BetDetailInfo.voiceLong];
//                if (self.BetDetailInfo.voiceLong != 0) {
//                    recoderBtn.buttonName.text = [NSString stringWithFormat:@"%d\"   ",self.BetDetailInfo.voiceLong];
//                }
//                else {
//                    recoderBtn.buttonName.text = [NSString stringWithFormat:@"%d\"   ",self.voiceLong];
//                }
//                recoderBtn.buttonName.textAlignment = NSTextAlignmentRight;
//                recoderBtn.otherImage.hidden = NO;
//                deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaidelete.png");
//                GoovoiceType = hasyuyin;
//            }
        }
        else {
            backImageV.frame = CGRectMake(backImageV.frame.origin.x, backImageV.frame.origin.y, backImageV.frame.size.width, backImageV.frame.size.height - 60);
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(23.5, ORIGIN_Y(lable) + 5, 100, 20)];
            label2.backgroundColor = [UIColor clearColor];
            [backImageV addSubview:label2];
            label2.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:146/255.0];
            label2.font = [UIFont systemFontOfSize:15];
            label2.text  = @"保密";
            [label2 release];
        }
        
        if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
            mySegment = [[CP_UISegement alloc] initWithItems:[NSArray arrayWithObjects:@"公开",@"保密",@"截止后公开",@"跟单公开", nil]];
            mySegment.frame = CGRectMake(6, ORIGIN_Y(lable) + 90, 260, 40);
        }
        else {
            mySegment = [[CP_UISegement alloc] initWithItems:[NSArray arrayWithObjects:@"公开",@"保密",@"截止后公开",@"隐藏", nil]];
            mySegment.frame = CGRectMake(12.5, ORIGIN_Y(lable) + 40, 247, 40);
        }
        
        [mySegment setBackgroudImage:UIImageGetImageFromName(@"SegementBG.png")];
        [backImageV addSubview:mySegment];
        [mySegment release];
        
        CP_PTButton *btn1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [btn1 loadButonImage:nil LabelName:@"取消"];
        btn1.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        [btn1 addTarget:self action:@selector(quxiaoBianji) forControlEvents:UIControlEventTouchUpInside];
        btn1.frame = CGRectMake(0, backImageV.frame.size.height - 44, backImageV.frame.size.width/2, 44);
        [backImageV addSubview:btn1];

        
        CP_PTButton *btn2 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [btn2 loadButonImage:nil LabelName:@"确定"];
        btn2.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        [btn2 addTarget:self action:@selector(finishBianji) forControlEvents:UIControlEventTouchUpInside];
        [backImageV addSubview:btn2];
        btn2.frame = CGRectMake(backImageV.frame.size.width/2, backImageV.frame.size.height - 44, backImageV.frame.size.width/2, 44);

//        titleImage2.frame = CGRectMake(22, 38, 256, height - 100);
        
        [backImageV release];
        
#ifdef isCaiPiaoForIPad
        editeView.frame = CGRectMake(0, 0, 390, 748);
        backImageV.frame = CGRectMake(10 + 35, 180, 300, height);
        [self.view addSubview:editeView];
#else
        [[caiboAppDelegate getAppDelegate].window addSubview:editeView];
#endif
        
    }
    else {
#ifdef isCaiPiaoForIPad
        editeView.frame = CGRectMake(0, 0, 390, 748);
        [self.view addSubview:editeView];
#else
        [[caiboAppDelegate getAppDelegate].window addSubview:editeView];
#endif
        
    }
    if ([self.BetDetailInfo.secretType intValue] == 4) {
        mySegment.selectIndex = [self.BetDetailInfo.secretType intValue] - 1;
    }
    else {
        mySegment.selectIndex = [self.BetDetailInfo.secretType intValue];
    }
    
    editeView.alpha = 1;
    
}

//领奖
- (void)lingJiang {
    [httpRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] getJiangLiWithOrderId:self.BetDetailInfo.longprogramNumber NickName:[[Info  getInstance] nickName] Other:@""];
	
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[self.httpRequest setDidFinishSelector:@selector(getJiangli:)];
	[self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[self.httpRequest setRequestMethod:@"POST"];
	[self.httpRequest setPostBody:postData];
	[self.httpRequest setDelegate:self];
	[self.httpRequest addCommHeaders];
	[self.httpRequest startAsynchronous];
}

- (void)quxiaoBianji {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    editeView.alpha = 0;
    [UIView commitAnimations];
    [editeView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (void) finishBianji {
    [httpRequest clearDelegatesAndCancel];
    NSString *xuanyan = @"";
        xuanyan = xuanyanText.text;
        if ([xuanyan length] == 0) {
            xuanyan = placeholderLabel.text;
        }
    NSString *baomi = [NSString stringWithFormat:@"%d",(int)mySegment.selectIndex];
    if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
        
    }
    else {
        if (mySegment.selectIndex == 3) {
            baomi = @"4";
        }
    }
    NSMutableData *postData = [[GC_HttpService sharedInstance] EditBaomiWithOrderId:self.BetDetailInfo.longprogramNumber UserName:[[Info getInstance] userName] Baomi:baomi XuanYan:xuanyan Other:@""];
	
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[self.httpRequest setDidFinishSelector:@selector(XiuGaiLeiXIngJiJiangJin:)];
	[self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[self.httpRequest setRequestMethod:@"POST"];
	[self.httpRequest setPostBody:postData];
	[self.httpRequest setDelegate:self];
	[self.httpRequest addCommHeaders];
	[self.httpRequest startAsynchronous];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    editeView.alpha = 0;
    [UIView commitAnimations];
    [editeView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    
}


#pragma mark 比分直播

//时时比分
- (void)changeShiShi {
    isShishi = !isShishi;
    if (!isShishi) {
        [shishiBtn loadButonImage:@"tongyonganniulanse.png" LabelName:@"开启比分直播"];
        [self.shishiTimer invalidate];
        self.shishiTimer = nil;
        [myTableView reloadData];
        
    }
    else {
        [shishiBtn loadButonImage:@"tongyonganniulanse.png" LabelName:@"关闭比分直播"];
        self.shishiTimer = [NSTimer scheduledTimerWithTimeInterval:60 target: self selector: @selector(refreshBifen) userInfo: nil repeats: YES];
        [self.shishiTimer fire];
    }
}

- (void)refreshBifen {
    NSString *matchId = nil;
    NSMutableArray *matchIdArray = [NSMutableArray array];
    [self.httpRequest clearDelegatesAndCancel];
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"202"]) {
        for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i ++) {
            NSArray *array = [[self.BetDetailInfo.betContentArray objectAtIndex:i] componentsSeparatedByString:@";"];
            if ([self.BetDetailInfo.OutorderId rangeOfString:@"ht"].location != NSNotFound) {
                if ([array count] >  13) {
                    if ([[array objectAtIndex:11] length] && ![[array objectAtIndex:11] isEqual:@"null"]) {
                        [matchIdArray addObject:[array objectAtIndex:11]];
                    }
                }
            }
            else {
                if ([array count] > 15) {
                    if ([[array objectAtIndex:15] length] && ![[array objectAtIndex:15] isEqual:@"null"]) {
                        [matchIdArray addObject:[array objectAtIndex:15]];
                    }
                }
            }
        }
        matchId = [matchIdArray componentsJoinedByString:@","];
        if ([matchId length] <= 4) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"获取实时比分失败"];
            return;
        }
        NSString *time = [[self.BetDetailInfo.beginTime componentsSeparatedByString:@" "] objectAtIndex:0];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getLiveMatchListByID:matchId Lotteryid:self.BetDetailInfo.lotteryId Issue:time]];
        //matchId
    }
    else if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]) {
        for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i ++) {
            NSArray *array = [[self.BetDetailInfo.betContentArray objectAtIndex:i] componentsSeparatedByString:@";"];
            if ([array count] > 14) {
                if ([[array objectAtIndex:14] length] && ![[array objectAtIndex:14] isEqual:@"null"]) {
                    [matchIdArray addObject:[array objectAtIndex:14]];
                }
                
            }
        }
        matchId = [matchIdArray componentsJoinedByString:@","];
        if ([matchId length] <= 4) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"获取实时比分失败"];
            return;
        }
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getLiveMatchListByID:matchId Lotteryid:self.BetDetailInfo.lotteryId Issue:self.BetInfo.issue]];
    }
    else if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]||[self.BetDetailInfo.lotteryId isEqualToString:@"301"]) {
        for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i ++) {
            NSArray *array = [[self.BetDetailInfo.betContentArray objectAtIndex:i] componentsSeparatedByString:@";"];
            if ([array count] > 12) {
                if ([[array objectAtIndex:12] length] && ![[array objectAtIndex:12] isEqual:@"null"]) {
                    [matchIdArray addObject:[array objectAtIndex:12]];
                }
                
            }
        }
        matchId = [matchIdArray componentsJoinedByString:@","];
        if ([matchId length] <= 4) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"获取实时比分失败"];
            return;
        }
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getLiveMatchListByID:matchId Lotteryid:self.BetDetailInfo.lotteryId Issue:self.BetInfo.issue]];
    }
    if ([matchId length] == 0) {
        return;
    }
    
    [self.httpRequest setTimeOutSeconds:300.0];
    [self.httpRequest setDidFinishSelector:@selector(reciveBifen:)];
    [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [self.httpRequest setDelegate:self];
    [self.httpRequest startAsynchronous];
}

- (void)reciveBifen:(ASIHTTPRequest *)request {
    requstFaildCount = 0;
    NSLog(@"%@",[[request responseString] JSONValue]);
    MatchInfo *matchinfo = [[MatchInfo alloc] initParserWithString:[request responseString]];
    if (!self.myMatchInfo) {
        self.myMatchInfo = matchinfo;
    }
    else {
        for (int i = 0; i < [self.myMatchInfo.matchList count] && i < [matchinfo.matchList count]; i ++) {
            MatchInfo *info1 = [self.myMatchInfo.matchList objectAtIndex:i];
            MatchInfo *info2 = [matchinfo.matchList objectAtIndex:i];
            [MatchInfo replaceMatch:info1 NewMatch:info2 WithSound:NO];
        }
    }
    
    [matchinfo release];
    [myTableView reloadData];
}

- (void) colorReset:(MatchInfo*)match
{
    match.isColorNeedChange = NO;
    if (match.isScoreHostChange)
    {
        match.isScoreHostChange = NO;
    }
    if (match.isAwayHostChange)
    {
        match.isAwayHostChange = NO;
    }
    [myTableView reloadData];
}

- (void)gobifenzhibo:(UIButton *)sender {
    GouCaiTiCaiCell *cell = (GouCaiTiCaiCell *)[myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    if (!cell.myMatchInfo) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"暂无时实比分信息"];
        return;
    }
    MatchDetailViewController *matchDetailVC = [[MatchDetailViewController alloc] initWithNibName: @"MatchDetailViewController" bundle: nil];
    matchDetailVC.matchId = cell.myMatchInfo.matchId;
    matchDetailVC.lotteryId = cell.myMatchInfo.lotteryId;
    matchDetailVC.issue = self.myMatchInfo.curIssue;
    matchDetailVC.shouldShowSwitch = NO;
    matchDetailVC.start = cell.myMatchInfo.start;
    [self.navigationController pushViewController:matchDetailVC animated:YES];
    [matchDetailVC release];
}

#pragma mark 录音
//- (void)deleteVoice {
//    
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSMutableString *path = [pathArray objectAtIndex:0];
//    NSString *detailPath = [path stringByAppendingPathComponent:@"reverseme.pcm"];
//    [[NSFileManager defaultManager] removeItemAtPath:detailPath error:nil];
//    [[caiboAppDelegate getAppDelegate] upLoadGoodVoiceWithOrderID:self.BetDetailInfo.longprogramNumber Path:nil Type:3 Time:0];
//    VoiceIsChange = NO;
//}

//- (void)recoderPrepare {
//    AVAudioSession *avSession = [AVAudioSession sharedInstance];
//    [avSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//    [avSession setActive:YES error:nil];
//    
//    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
//                              [NSNumber numberWithFloat:8000.0], AVSampleRateKey,
//                              [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
//                              [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
//                              [NSNumber numberWithInt:1], AVNumberOfChannelsKey,nil];
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSMutableString *path = [pathArray objectAtIndex:0];
//    NSString *detailPath = [path stringByAppendingPathComponent:@"reverseme.pcm"];
//    [[NSFileManager defaultManager] removeItemAtPath:detailPath error:nil];
//    NSURL *recordUrl = [NSURL URLWithString:detailPath];
//    NSError *error;
//    avRecorder = [[AVAudioRecorder alloc] initWithURL:recordUrl
//                                             settings:settings
//                                                error:&error];
//    [avRecorder prepareToRecord];
//    [avRecorder peakPowerForChannel:0];
//    avRecorder.delegate = self;
//    
//    NSLog(@"%@",[error description]);
//    //    [avRecorder performSelector:@selector(stop) withObject:nil afterDelay:4];
//    NSLog(@"22");
//    
//}

//- (void)timego {
//    recorderTime ++;
//    if (recorderTime > 60) {
//        [avRecorder stop];
//        [[caiboAppDelegate getAppDelegate] showMessage:@"60秒录制结束。"];
//        [self.myTimer invalidate];
//        self.myTimer = nil;
//    }
//}

//- (void)recorderBegin {
//    if (GoovoiceType == yuyinwithnone) {
//        [avRecorder release];
//        [self recoderPrepare];
//        [avRecorder prepareToRecord];
//        [avRecorder record];
//        [self.myTimer invalidate];
//        recorderTime = 0;
//        
//        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(timego) userInfo: nil repeats: YES];
//        [self.myTimer fire];
//    }
//    else if (GoovoiceType == hasyuyin) {
//        if (infoPlayer == nil)
//        {
//            if (avRecorder) {
//                NSError *playerError;
//                NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                NSMutableString *path = [pathArray objectAtIndex:0];
//                NSString *detailPath = [path stringByAppendingPathComponent:@"reverseme.pcm"];
//                NSURL *url = [NSURL URLWithString:detailPath];
//                if (url) {
//                    infoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerError];
//                }
//                else {
//                    infoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[avRecorder url] error:&playerError];
//                }
//                infoPlayer.meteringEnabled = YES;
//                infoPlayer.delegate = self;
//                if (infoPlayer == nil)
//                {
//                    NSLog(@"ERror creating player: %@", [playerError description]);
//                }
//                infoPlayer.delegate = self;
//            }
//            else {
//                [self showPlyerBackgroud];
//                voicePlayer.hidden = YES;
//                return;
//            }
//        }
//        if (infoPlayer.isPlaying) {
//            [infoPlayer pause];
//        }
//        else {
//            UInt32 propertySize = sizeof(CFStringRef);
//            CFStringRef state = nil;
//            AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
//                                    ,&propertySize,&state);
//            //return @"Headphone" or @"Speaker" and so on.
//            //根据状态判断是否为耳机状态
//            
//            if ([(NSString *)state rangeOfString:@"Headphone"].location != NSNotFound || [(NSString *)state rangeOfString:@"HeadsetInOut"].location != NSNotFound ) {
//                UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_None;
//                AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
//            }else{
//                UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//                AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
//            }
//            [infoPlayer play];
//        }
//        
//        //        [avRecorder ]
//    }
//}
//
//- (void)recorderEnd {
//    if (GoovoiceType == yuyinwithnone) {
//        [avRecorder stop];
//        
//    }
//    [self.myTimer invalidate];
//    
//}

//- (void)recorderDelete {
//    //UILabel *lable = (UILabel *)[recoderBtn viewWithTag:101];
//    if (avRecorder&&avRecorder.isRecording == YES) {
//        return;
//    }
//    VoiceIsChange = YES;
//    isGoodVoice = NO;
//    if (GoovoiceType == hasyuyin) {
//        CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否删除好声音" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//        [alet show];
//        alet.tag = 303;
//        [alet release];
//        return;
//    }
//    else if (GoovoiceType == yuyinwithnone) {
//        GoovoiceType = wenzi;
//        recoderBtn.hidden = YES;
//        xuanyanText.superview.superview.hidden = NO;
//        recoderBtn.otherImage.hidden = YES;
//        deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaihuatong.png");
//    }
//    else {
//        GoovoiceType = yuyinwithnone;
//        recoderBtn.hidden = NO;
//        xuanyanText.superview.superview.hidden = YES;
//        recoderBtn.otherImage.hidden = YES;
//        deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaibi.png");
//    }
//}


#pragma mark -
#pragma mark 抄单

- (BOOL)isChaoEnable {
    if (isMine) {
        return YES;
    }
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"40006"]||[self.BetDetailInfo.lotteryId isEqualToString:@"40007"]||[self.BetDetailInfo.lotteryId isEqualToString:@"40008"]) {
        return NO;
    }
    if ([myTableView numberOfRowsInSection:0]!= 0 && isShuZi) {
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"111"]) {//22选5禁止抄单
            return NO;
        }
        return YES;
    }
    if (!isShuZi) {
        if ([self.BetDetailInfo.endTime isEqualToString:@"已截期"]) {
            return NO;
        }
        return YES;
    }
    if ([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)issueInfoReturn{
    if (cellarray&&cellarray.count) {
        NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
        
        
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
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
            
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
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


- (NSString *)yujitouzhuxuanxiang{
    NSString * returnstr = @"";
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]||[self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * bet = [cellarray objectAtIndex:i];
            if (bet.selection1 || bet.selection2 || bet.selection3) {
                returnstr = [NSString stringWithFormat:@"%@%@:", returnstr, bet.changhao];
                if (bet.selection1) {
                    returnstr = [NSString stringWithFormat:@"%@0,", returnstr];
                    
                }
                if (bet.selection2) {
                    returnstr = [NSString stringWithFormat:@"%@1,", returnstr];
                    
                }
                if (bet.selection3) {
                    returnstr = [NSString stringWithFormat:@"%@2,", returnstr];
                    
                }
                returnstr = [returnstr substringToIndex:[returnstr length]-1];
                returnstr = [NSString stringWithFormat:@"%@;", returnstr];
            }
        }
        returnstr = [returnstr substringToIndex:[returnstr length]-1];
    }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * bet = [cellarray objectAtIndex:i];
            BOOL zhongjie = NO;
            for (int j = 0; j < [bet.bufshuarr count]; j++) {
                NSString * bufstr = [bet.bufshuarr objectAtIndex:j];
                if ([bufstr isEqualToString:@"1"]) {
                    zhongjie = YES;
                    break;
                }
            }
            if (zhongjie) {
                returnstr = [NSString stringWithFormat:@"%@%@:", returnstr, bet.changhao];
            }
            
            for (int m = 0; m < [bet.bufshuarr count]; m++) {
                NSString * stringbuf = [bet.bufshuarr objectAtIndex:m];
                if ([stringbuf isEqualToString:@"1"]) {
                    
                    returnstr = [NSString stringWithFormat:@"%@%d,", returnstr, m];
                    
                }
            }
            if (zhongjie) {
                returnstr = [returnstr substringToIndex:[returnstr length]-1];
                returnstr = [NSString stringWithFormat:@"%@;", returnstr];
            }
            
            
            
        }
        
    }
    
    
    
    
    return returnstr;
}



//预计奖金
- (void)chaoDanYuJiJiangJin{
    
    NSMutableString *strshedan = [[[NSMutableString alloc] init] autorelease];
    NSInteger zongchangci = 0;
    
    if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.lotteryId isEqualToString:@"400"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
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
        
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
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
    NSString *passTypeSet = @"";
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]) {
        NSArray * arr = [zhushuDic allKeys];
        NSLog(@"arr = %@", arr);
        NSLog(@"self.guguan = %@", self.BetDetailInfo.guguanWanfa);
        
        
        for (int i = 0; i < [arr count]; i++) {
            //   NSLog(@"chuan = %@", [arr objectAtIndex:i]);
            if ([[arr objectAtIndex:i] isEqualToString:@"单关"]) {
                passTypeSet = [NSString stringWithFormat:@"%@单关;" ,passTypeSet];
            }else{
                if (i!=arr.count-1){
                    NSString * com = [arr objectAtIndex:i];
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    if ([nsar count] >= 2) {
                        com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                        passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                    }
                    
                    
                }else{
                    NSString * com = [arr objectAtIndex:i];
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    if ([nsar count] >= 2) {
                        com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                        passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                    }
                    
                    
                }
                
                
            }
        }
        // if (![passTypeSet isEqualToString:@"单关"]) {
        passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"200"]){
        //        NSLog(@"strshedan = %@", strshedan);
        //
        //        NSArray * arr = [zhushuDic allKeys];
        //        NSLog(@"arr = %@", arr);
        //        NSLog(@"self.guguan = %@", self.BetDetailInfo.guguanWanfa);
        //
        //
        //        for (int i = 0; i < [arr count]; i++) {
        //            NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        //            if (i!=arr.count-1){
        //                NSString * com = [arr objectAtIndex:i];
        //                NSArray * nsar = [com componentsSeparatedByString:@"串"];
        //                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
        //                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
        //
        //            }else{
        //                NSString * com = [arr objectAtIndex:i];
        //                NSArray * nsar = [com componentsSeparatedByString:@"串"];
        //                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
        //                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
        //
        //            }
        //        }
        //
        //        passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
        
        
        NSRange douhao = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
        if (douhao.location != NSNotFound) {
            NSArray * arrdou = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
            
            for (int i = 0; i < [arrdou count]; i++) {
                passTypeSet = [NSString stringWithFormat:@"%@%@;", passTypeSet, [arrdou objectAtIndex:i]];
            }
            passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
        }else{
            passTypeSet = self.BetDetailInfo.guguanWanfa;
        }
        
    }
    
    
    NSLog(@"fangshi = %@", passTypeSet);
    
    NSInteger caizhong = 1;
    NSInteger wanfa = 1;
    NSString * issuestr=@"";
    if([self.BetDetailInfo.lotteryId isEqualToString:@"200"]){
        caizhong = 1;
        issuestr =  self.BetInfo.issue;
        
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
            wanfa = 11;
        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
            wanfa = 12;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
            wanfa = 13;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
            wanfa = 14;
        }
        
    }else if([self.BetDetailInfo.lotteryId isEqualToString:@"201"]){
        caizhong = 1;
        issuestr =  self.BetInfo.issue;;
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
            wanfa = 1;
        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]){
            wanfa = 2;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
            wanfa = 3;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
            wanfa = 4;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
            wanfa = 15;
        }
        
        
    } else if([self.BetDetailInfo.lotteryId isEqualToString:@"400"]){
        caizhong = 2;
        wanfa = 5;
        issuestr = self.BetInfo.issue;
    }
    
    
    
    [httpRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] chaoDanYuJiChangCi:[self issueInfoReturn] guoGuanCiShu:zongchangci fangShi:passTypeSet sheDanChangCi:strshedan beishu:1 touzhuxuanxiang:[self yujitouzhuxuanxiang] caizhong:caizhong wanfa:wanfa issue:issuestr];
	
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[self.httpRequest setDidFinishSelector:@selector(yuJiJiangJin:)];
	[self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[self.httpRequest setRequestMethod:@"POST"];
	[self.httpRequest setPostBody:postData];
	[self.httpRequest setDelegate:self];
	[self.httpRequest addCommHeaders];
	[self.httpRequest startAsynchronous];
}

- (void)beidanchaodan{
    GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
    sheng.chaodanbool = YES;
    //    BOOL danbool = NO;
    
    //    for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
    //        NSString * sheng = [self.BetDetailInfo.betContentArray objectAtIndex:i];
    //        NSArray * arrcont = [sheng componentsSeparatedByString:@";"];
    //        if ([[arrcont objectAtIndex:7] length] > 1) {
    //            danbool = YES;
    //
    //        }
    //    }
    
    //    if (!danbool) {
    //        sheng.danfushi = 0;
    //    } else{
    sheng.danfushi = 1;
    //    }
    sheng.fenzhong = beijingdanchang;
    if ([self.BetDetailInfo.multiplenNum isEqualToString:@"1"]) {
        sheng.moneynum = self.BetDetailInfo.programAmount;
    }else{
        sheng.moneynum = [NSString stringWithFormat:@"%d",[self.BetDetailInfo.programAmount intValue]/[self.BetDetailInfo.multiplenNum intValue] ];
    }
    sheng.BetDetailInfo = self.BetDetailInfo;
    sheng.zhushu = self.BetDetailInfo.betsNum;
    sheng.beidanbool = YES;
    sheng.bettingArray = cellarray;
    sheng.zhushudict = zhushuDic;
    sheng.issString = self.BetInfo.issue;
    NSLog(@"qihaobeidan = %@", self.BetInfo.issue);
    sheng.qihaostring = self.BetInfo.issue;
    sheng.maxmoneystr = maxmoney;
    sheng.minmoneystr = minmoney;
    sheng.bianjibool = YES;
    sheng.hemaibool = NO;
    
    if ([sheng.bettingArray count] != 0) {
        [self.navigationController pushViewController:sheng animated:YES];
    }
    [sheng release];
    
}

- (void)jingcaichaodan{
    GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
    NSLog(@"sys = %@", self.BetDetailInfo.systemTime);
    NSArray * arr = [self.BetDetailInfo.systemTime componentsSeparatedByString:@" "];
    if ([arr count] >= 1) {
        sheng.systimestr = [arr  objectAtIndex:0];
    }else{
        sheng.systimestr = @"";
    }
    
    NSLog(@"sys = %@", self.BetDetailInfo.systemTime);
    sheng.chaodanbool = YES;
    // sheng.title = @"竞彩足球胜平负(过关)";
    // NSLog(@"%d", two);
    
    //            if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
    //                yuji.maxmoney = @"";
    //            }
    //            if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
    //                yuji.minmoney = @"";
    //            }
    //    BOOL danbool = NO;
    
    
    //    for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
    //        NSString * sheng = [self.BetDetailInfo.betContentArray objectAtIndex:i];
    //        NSArray * arrcont = [sheng componentsSeparatedByString:@";"];
    //        if ([[arrcont objectAtIndex:8] length] > 1) {
    //            NSString *shengpingfustr = [arrcont objectAtIndex:8];
    //            NSRange douhao = [shengpingfustr rangeOfString:@","];
    //            if (douhao.location != NSNotFound) {
    //                danbool = YES;
    //            }
    //
    //
    //        }
    //    }
    
    //    if (!danbool) {
    //        sheng.danfushi = 0;
    //    } else{
    sheng.danfushi = 1;
    //    }
    if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
        sheng.fenzhong = jingcaibifen;
    }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
        sheng.fenzhong = jingcaipiao;
        NSInteger changci = [self.BetDetailInfo.betContentArray count];
        NSInteger caiguo = 0;
        for (NSString *st in self.BetDetailInfo.betContentArray) {
            NSArray *array = [st componentsSeparatedByString:@";"];
            if ([array count] >= 9) {
                caiguo = caiguo + [[[array objectAtIndex:8] componentsSeparatedByString:@","] count];
            }
        }
        if ([self.BetDetailInfo.guguanWanfa rangeOfString:@"x"].location != NSNotFound) {
            sheng.isxianshiyouhuaBtn = YES;
            if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"2x1"]||[self.BetDetailInfo.guguanWanfa isEqualToString:@"3x1"]||[self.BetDetailInfo.guguanWanfa isEqualToString:@"4x1"]||[self.BetDetailInfo.guguanWanfa isEqualToString:@"5x1"]) {
                if (changci <= 5) {
                    sheng.youhuaBool = YES;
                }
                if (caiguo <= 12) {
                    sheng.youhuaZhichi = YES;
                }
            }
        }
        
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
        sheng.fenzhong = zongjinqiushu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
        sheng.fenzhong = banquanchangshengpingfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"06"]){
        sheng.fenzhong = jingcailanqiushengfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
        sheng.fenzhong = jingcailanqiurangfenshengfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
        sheng.fenzhong = jingcailanqiushengfencha;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
        sheng.fenzhong = jingcailanqiudaxiaofen;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
        sheng.fenzhong = jingcairangfenshengfu;
    }
    
    if ([self.BetDetailInfo.multiplenNum isEqualToString:@"1"]) {
        sheng.moneynum = self.BetDetailInfo.programAmount;
    }else{
        sheng.moneynum = [NSString stringWithFormat:@"%d",[self.BetDetailInfo.programAmount intValue]/[self.BetDetailInfo.multiplenNum intValue] ];
    }
    
    
    sheng.zhushu = self.BetDetailInfo.betsNum;//[NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
    
    sheng.jingcai = YES;
    sheng.BetDetailInfo = self.BetDetailInfo;
    sheng.bianjibool = YES;
    sheng.bettingArray = cellarray;
    sheng.zhushudict = zhushuDic;
    if ((sheng.fenzhong == jingcailanqiushengfencha && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) || (sheng.fenzhong == jingcaibifen && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"])) {
        sheng.maxmoneystr = [NSString stringWithFormat:@"%f", [maxmoney floatValue]*2];//yuji.maxmoney;
        sheng.minmoneystr = [NSString stringWithFormat:@"%f", [minmoney floatValue]*2];//yuji.minmoney;
    }else{
        sheng.maxmoneystr = maxmoney;
        sheng.minmoneystr = minmoney;
    }
    //    sheng.maxmoneystr = maxmoney;
    //    sheng.minmoneystr = minmoney;
    NSLog(@"zhushumax = %@, min = %@", maxmoney, minmoney);
    //            sheng.isHeMai = self.isHeMai;
    //  NSLog(@"zhushu = %@", zhushuDic);
    
    //            if (isHeMai) {
    //                sheng.hemaibool = YES;
    //            }else{
    sheng.hemaibool = NO;
    //    }
    
    if ([sheng.bettingArray count] != 0) {
        [self.navigationController pushViewController:sheng animated:YES];
    }
    [sheng release];
    
    
}

- (void)yuJiJiangJin:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        maxmoney = @"0";
        minmoney = @"0";
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"0";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"0";
        }
        maxmoney = yuji.maxmoney;
        minmoney = yuji.minmoney;
        NSLog(@"max = %@, min = %@", maxmoney, minmoney);
        
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"200"] ) {
            [self jingcaichaodan];
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"400"]){
            [self beidanchaodan];
        }
        [yuji release];
        
        
        
    }
    
    
    
    
}



//抄单
- (void)chaodan {
    [self quxiao];
    if (isShuZi) {
        //数字彩
        if (isDanShi) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持单式上传抄单"];
            return;
        }
        if (isHorse) {
            HorseRaceViewController * high = [[[HorseRaceViewController alloc] init] autorelease];
            [self.navigationController pushViewController:high animated:YES];
            return;
        }
        if ([GC_LotteryType lotteryTypeWithLotteryID:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId] == TYPE_UNSUPPT) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此彩种抄单"];
            return;
        }
        if ([GC_LotteryType changeWanfaToModeTYPE:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId] == ModeTYPE_UNSUPPOT) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此玩法抄单"];
            return;
        }
        if ([self.BetDetailInfo.betStyle isEqualToString:@"胆拖"]) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此玩法抄单"];
            return;
        }
        
        GouCaiShuZiInfoViewController *infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
		infoViewController.isHeMai = NO;
        
        infoViewController.betInfo.lotteryId = self.BetDetailInfo.lotteryId;
		//infoViewController.betInfo.issue = self.BetInfo.issue;
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"001"]) {//双色球
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                infoViewController.lotteryType = [GC_LotteryType lotteryTypeWithLotteryID:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId];
                
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([array count] >= 1) {
                    NSRange rang = [[array objectAtIndex:0] rangeOfString:@"@"];
                    if (rang.length) {
                        st = [NSString stringWithFormat:@"03#%@",[array objectAtIndex:0]];
                        infoViewController.modeType = Shuangseqiudantuo;
                    }
                    else if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                        st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                    }
                    else {
                        st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                    }
                    [infoViewController.dataArray addObject:st];
                }
               
            }
        }
        else if ([self.BetDetailInfo.lotteryId isEqualToString:@"002"]){//3D
            infoViewController.lotteryType = [GC_LotteryType lotteryTypeWithLotteryID:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId];
            infoViewController.modeType = [GC_LotteryType changeWanfaToModeTYPE:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId];
            if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
                if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = ThreeDzhixuanhezhi;
                }else{
                    infoViewController.modeType = ThreeDzhixuanfushi;
                }
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"02"]) {
                if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = ThreeDzusanHezhi;
                }
                else if ([self.BetDetailInfo.betStyle isEqualToString:@"单式"]) {
                    infoViewController.modeType = ThreeDzusandanshi;
                }
                else{
                    infoViewController.modeType = ThreeDzusanfushi;
                }
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                infoViewController.modeType = ThreeDzhixuandantuo;
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                //组六
                if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = ThreeDzuliuHezhi;
                }else{
                    infoViewController.modeType = ThreeDzuliufushi;
                }
            }
            else {
                [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此玩法抄单"];
                [infoViewController release];
                return;
            }
            
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeFuCai3D;
            //infoViewController.betInfo.issue = self.BetInfo.issue;
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];

                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([array count] < 2) {
                    array = [NSArray arrayWithObjects:@"", @"", nil];
                }
                if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    st = [NSString stringWithFormat:@"04#%@",[array objectAtIndex:0]];
                }
                else if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                    st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                    st = [st stringByReplacingOccurrencesOfString:@"," withString:@""];
                }
                else {
                    if ([self.BetDetailInfo.wanfaId isEqualToString:@"04"]) {
                        st = [NSString stringWithFormat:@"03#%@",[array objectAtIndex:0]];
                    }
                    else {
                        st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                    }
                    
                }
                NSLog(@"%@",st);
                
                [infoViewController.dataArray addObject:st];
            }
            
        }
        else if ([self.BetDetailInfo.lotteryId isEqualToString:@"113"]){//大乐透
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeDaleTou;
            infoViewController.lotteryType = TYPE_DALETOU;
            NSString *num = [self.BetDetailInfo.betContentArray objectAtIndex:0];
            if ([num rangeOfString:@"_,_"].location != NSNotFound) {
                infoViewController.modeType = Daletoudantuo;
            }
            else {
                infoViewController.modeType = Daletoufushi;
            }
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if (infoViewController.modeType == Daletoufushi) {
                    if ([array count] > 1) {
                        if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                            st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                        }
                        else {
                            st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                        }
                    }
                    
                }
                else {
                    if ([array count] >= 1) {
                        st = [NSString stringWithFormat:@"03#%@",[array objectAtIndex:0]];

                    }else{
                        st = @"";
                    }
                    
                }
                
                NSLog(@"%@",st);
                
                [infoViewController.dataArray addObject:st];
            }
        }
        else if ([self.BetDetailInfo.lotteryId isEqualToString:@"119"]){//11选5
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiXuanWu;
            infoViewController.lotteryType = [GC_LotteryType lotteryTypeWithLotteryID:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId];
            infoViewController.modeType = [GC_LotteryType changeWanfaToModeTYPE:self.BetDetailInfo.lotteryId Wanfa:self.BetDetailInfo.wanfaId];
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([array count] < 2) {
                    array = [NSArray arrayWithObjects:@"", @"", nil];
                }
                if ([self.BetDetailInfo.betStyle isEqualToString:@"胆拖"]) {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此玩法抄单"];
                    [infoViewController release];
                    return;
                }
                else if ([[array objectAtIndex:1] intValue] == 1) {
                    st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                }
                else if (infoViewController.lotteryType == TYPE_11XUAN5_Q2ZHI ||infoViewController.lotteryType == TYPE_11XUAN5_Q3ZHI) {
                    st = [NSString stringWithFormat:@"05#%@",[array objectAtIndex:0]];
                }
                else {
                    st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                }
                
                if ([st rangeOfString:@"e"].location == NSNotFound) {
                    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:st,@"Num",[array objectAtIndex:1],@"ZhuShu",[NSString stringWithFormat:@"%d",infoViewController.lotteryType],@"lotterytype",nil];
                    [infoViewController.dataArray addObject:dic];
                    [dic release];
                }
            }
        }
        else  if([self.BetDetailInfo.lotteryId isEqualToString:@"109"]){//排列5
            
            
            infoViewController.lotteryType = TYPE_PAILIE5;
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypePaiLie5;
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([array count] > 1) {
                    if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                        st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                    else {
                        st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                }
                
                NSLog(@"%@",st);
                
                [infoViewController.dataArray addObject:st];
            }
            
            
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"110"]){//七星彩
            
            infoViewController.lotteryType = TYPE_QIXINGCAI;
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiXingCai;
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([array count] > 1) {
                    if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                        st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                    else {
                        st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                }
                
                NSLog(@"%@",st);
                
                [infoViewController.dataArray addObject:st];
            }
            
            
            
            
        }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"003"]){//七乐彩
            
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiLeCai;
            
            NSLog(@"wanfa = %@", self.BetDetailInfo.wanfaId);
            infoViewController.lotteryType = TYPE_7LECAI;
            infoViewController.modeType = Qilecaifushi;
            for(int i = 0;i < [self.BetDetailInfo.betContentArray count];i++) {
                NSRange rang = [[self.BetDetailInfo.betContentArray objectAtIndex:i] rangeOfString:@"_,_"];
                if (rang.location != NSNotFound) {
                    infoViewController.modeType = Qilecaidantuo;
                }
                i = (int)[self.BetDetailInfo.betContentArray count];
            }
            
            
            
            
            
            
            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSRange douhao = [st rangeOfString:@","];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if (douhao.location == NSNotFound) {
                    if ([array count] > 1) {
                        if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                            st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                            // st = [st stringByReplacingOccurrencesOfString:@"," withString:@""];
                        }
                        else {
                            st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                        }
                    }
                    
                    infoViewController.modeType = Qilecaidanshi;
                }else{
                    
                    st = [NSString stringWithFormat:@"03#%@",[array objectAtIndex:0]];
                    // st = [st stringByReplacingOccurrencesOfString:@"," withString:@""];
                    infoViewController.modeType = Qilecaidantuo;
                    
                }
                NSLog(@"%@",st);
                
                [infoViewController.dataArray addObject:st];
            }
            
        }
        else if ([self.BetDetailInfo.lotteryId isEqualToString:@"108"]){
            
            infoViewController.lotteryType = TYPE_PAILIE3;

            if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
                if ([BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = Array3zhixuanHezhi;
                }else{
                    infoViewController.modeType = Array3zhixuanfushi;
                }
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                if ([BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = Array3zusanHezhi;
                }else{
                    infoViewController.modeType = Array3zusanfushi;
                }
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                if ([BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    infoViewController.modeType = Array3zuliuHezhi;
                }else{
                    infoViewController.modeType = Array3zuliufushi;
                }
            }
            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"02"]){
                infoViewController.modeType = Array3zuxuandanshi;
            }
            
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypePaiLie3;
            //infoViewController.betInfo.issue = self.BetInfo.issue;

            for (int i = 0;i <[self.BetDetailInfo.betContentArray count];i++) {
                NSString *st = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray *array = [st componentsSeparatedByString:@"-"];
                if ([BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                    if ([array count] >= 1) {
                        st = [NSString stringWithFormat:@"04#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                    
                }
                else if ([[array objectAtIndex:1] isEqualToString:@"1"]) {
                    if ([array count] >= 1) {
                        st = [NSString stringWithFormat:@"01#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                    
                }
                else {
                    if ([array count] >= 1) {
                        st = [NSString stringWithFormat:@"02#%@",[array objectAtIndex:0]];
                        st = [st stringByReplacingOccurrencesOfString:@"*" withString:@"*"];
                    }
                    
                }
                [infoViewController.dataArray addObject:st];
            }
        }
        else {
            [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此彩种抄单"];
            [infoViewController release];
            return;
        }
        infoViewController.canBack = NO;
        [self.navigationController pushViewController:infoViewController animated:YES];
        
        [infoViewController.navigationItem setHidesBackButton:YES];
        [infoViewController release];
    }else {
        //体彩
        if (isJJYH) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"奖金优化方案暂不支持抄单"];
            return;
        }
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]||[self.BetDetailInfo.lotteryId isEqualToString:@"301"]){//胜负彩
            GC_BetInfo * betInfo = [[GC_BetInfo alloc] init];
            int two = [self.BetDetailInfo.betsNum intValue];
            betInfo.modeType = (two > 1) ? fushi:danshi;
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            betInfo.bets = two;
            betInfo.price = two * 2;
            NSMutableArray * bettingArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                NSString * teamstr = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSLog(@"teamstr = %@", teamstr);
                NSArray * arrte = [teamstr componentsSeparatedByString:@";"];
                GC_BetData * pkb = [[GC_BetData alloc] init];
                if ([arrte count] >= 11) {
                    pkb.event = [arrte objectAtIndex:11];
                }else{
                    pkb.event = @"";
                }
                
                NSString * strdui = @"";
                if ([arrte count] > 1) {
                    strdui = [arrte objectAtIndex:1];
                }
                NSArray * duiarr = [strdui componentsSeparatedByString:@"VS"];
                if ([duiarr count] >= 2) {
                     pkb.team = [NSString stringWithFormat:@"%@,%@,%@", [duiarr objectAtIndex:0], [duiarr objectAtIndex:1], @"0"];
                }else{
                     pkb.team = [NSString stringWithFormat:@"%@,%@,%@", @"", @"", @"0"];
                }
               
                
                
                NSString * spfstr = @"";
                if ([arrte count] > 2) {
                    spfstr = [arrte objectAtIndex:2];
                }
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
                
                
                [bettingArray addObject:pkb];
                [pkb release];
                
            }
            
            
            
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
                if (!data.selection1&&!data.selection2&&!data.selection3) {
                    string = [string stringByAppendingFormat:@"4"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            string = [string substringToIndex:[string length] - 1];
            NSLog(@"string = %@", string);
            
            
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
            betInfo.issue = self.BetInfo.issue;//ccc
            
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]) {
                betInfo.lotteryType = TYPE_CAIZHONG14;
                betInfo.caizhong = @"300";
                betInfo.wanfa = @"01";
            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
                betInfo.lotteryType = TYPE_CAIZHONG9;
                betInfo.caizhong = @"301";
                betInfo.wanfa = @"02";
            }
            
            
            
            
            betInfo.stopMoney = @"0";
            // if (betInfo.bets > 0) {
            //     if (betInfo.price <= 20000) {
            
            
            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
            sheng.title = [NSString stringWithFormat:@"胜负彩%@期", self.BetInfo.issue];
            
            
            
            sheng.bettingArray = bettingArray;
            [bettingArray release];
            sheng.BetDetailInfo = self.BetDetailInfo;
            sheng.chaodanbool = YES;
            if ([self.BetDetailInfo.multiplenNum isEqualToString:@"1"]) {
                sheng.moneynum = self.BetDetailInfo.programAmount;
            }else{
                sheng.moneynum = [NSString stringWithFormat:@"%d",[self.BetDetailInfo.programAmount intValue]/[self.BetDetailInfo.multiplenNum intValue] ];
            }
            sheng.zhushu = self.BetDetailInfo.betsNum;
            sheng.bianjibool = YES;
            sheng.issString = self.BetInfo.issue;
            NSLog(@"iss = %@  , slef = %@", self.BetInfo.issue, self.issure);
            sheng.qihaostring = self.BetInfo.issue;
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
                
                sheng.fenzhong = renjiupiao;
            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"300"]){
                
                sheng.fenzhong = shisichangpiao;
            }
            
            
            //            sheng.isHeMai = self.isHemai;
            //            if (isHemai) {
            //                sheng.hemaibool = YES;
            //            }else{
            sheng.hemaibool = NO;
            //}
            if ([sheng.bettingArray count] != 0) {
                [self.navigationController pushViewController:sheng animated:YES];
            }
            
            [sheng release];
            
            [betInfo release];
            
            
            
            //multiplenNum beitou
            
            //            NSLog(@"ddaaaaaaaaaddd");
            //            NSLog(@"ddaaaaaaaaaddd = %@", self.BetDetailInfo.betContentArray);
            //            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            //            bet.betrecorinfo = self.BetDetailInfo;
            //            bet.issString = self.BetInfo.issue;
            //            if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
            //             bet.bettingstype = bettingStypeRenjiu;
            //            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"300"]){
            //            bet.bettingstype = bettingStypeShisichang;
            //            }
            //
            //            bet.chaodanbool = YES;
            //
            //           // NSString * str = [NSString stringWithFormat:@"20%@",cell.myrecord.curIssue];
            //          //  bet.issString = str;//期号
            //            [self.navigationController pushViewController:bet animated:YES];
            //            [bet release];
            
            
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"200"]){//竞彩
            
            //            for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
            //                NSLog(@"ddd = %@", [self.BetDetailInfo.betContentArray objectAtIndex:i]);
            //            }
            NSLog(@"chuanfa = %@", self.BetDetailInfo.guguanWanfa);
            NSLog(@"xxx = %@", self.BetDetailInfo.wanfaId);
            
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"200"]) {
                if  ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
                    NSMutableArray * lanqiuarr = [[NSMutableArray alloc] initWithCapacity:0];
                    for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                        
                        NSArray * nsarr = [[self.BetDetailInfo.betContentArray objectAtIndex:i] componentsSeparatedByString:@";"];
                        NSString * lanstring = @"";
                        if ([nsarr count] >= 14) {
                            lanstring = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@;%@;%@;%@; ; ; ; ;%@", [nsarr objectAtIndex:0], @" ", @" ", [nsarr objectAtIndex:5], @" ", @" ", @" ", [nsarr objectAtIndex:7], [nsarr objectAtIndex:4], [nsarr objectAtIndex:1],[nsarr objectAtIndex:14]];
                        }
                        
                        [lanqiuarr addObject:lanstring];
                        
                    }
                    [self.BetDetailInfo.betContentArray removeAllObjects];
                    [self.BetDetailInfo.betContentArray addObjectsFromArray:lanqiuarr];
                    [lanqiuarr release];
                    
                }
            }
            
            
            //            BOOL danguanbool = NO;
            //            NSRange chuanfa = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
            //            if (chuanfa.location != NSNotFound) {
            //                NSArray * chuanarr = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
            //                for (int i = 0; i < [chuanarr count]; i++) {
            //                    if ([[chuanarr objectAtIndex:i] isEqualToString:@"单关"]) {
            //                        danguanbool = YES;
            //                    }
            //                }
            //
            //            }else{
            //                if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
            //                    danguanbool = YES;
            //                }
            //            }
            //
            
            
            if  (([self.BetDetailInfo.wanfaId isEqualToString:@"01"] || [self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"])){
                
                [cellarray removeAllObjects];
                
                
                //  cellarray = [[NSMutableArray alloc] initWithCapacity:0];
                
                
                for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                    NSString * contenstr = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                    NSArray * arrcont = [contenstr componentsSeparatedByString:@";"];
                    
                    GC_BetData * be = [[GC_BetData alloc] init];
                    if ([arrcont count] >= 14) {
                        be.event = [arrcont objectAtIndex:14];
                    }else{
                        be.event = @"";
                    }
                    
                    //be.event = gc.match;
                    //  NSArray * timedata = [gc.deathLineTime componentsSeparatedByString:@" "];
                    //  be.date = [timedata objectAtIndex:0];
                    //  be.time = [timedata objectAtIndex:1];
                    NSString * strdui = [arrcont objectAtIndex:9];
                    NSArray * duiarr = [strdui componentsSeparatedByString:@"vs"];
                    if ([duiarr count] >= 2) {
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", [duiarr objectAtIndex:0], [duiarr objectAtIndex:1], @"0"];
                    }else{
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", @"", @"", @"0"];
                    }
                    
                    //                    be.saishiid = gc.bicaiid;
                    if ([arrcont count] >= 1) {
                         be.numzhou = [arrcont objectAtIndex:0];
                    }else{
                         be.numzhou = @"";
                    }
                    if ([arrcont count] >= 7) {
                        be.changhao = [arrcont objectAtIndex:7];
                    }else{
                        be.changhao = @"";
                    }
                    
                    NSString * danstr = @"";
                    if ([arrcont count] >= 3) {
                        danstr = [arrcont objectAtIndex:3];
                    }
                    // NSArray * nutimearr = [gc.datetime componentsSeparatedByString:@" "];
                    // be.numtime = [nutimearr objectAtIndex:0];
                    if ([danstr isEqualToString:@"1"]) {
                        be.dandan = YES;
                    }
                    NSString *shengpingfustr = @"";
                    if ([arrcont count] >= 8) {
                        shengpingfustr = [arrcont objectAtIndex:8];
                    }
                    
                    NSRange douhao = [shengpingfustr rangeOfString:@","];
                    if (douhao.location != NSNotFound) {
                        NSArray * spfarr = [shengpingfustr componentsSeparatedByString:@","];
                        
                        if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]) {
                            for (int n = 0; n < [spfarr count]; n++) {
                                NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }else {
                                    if ([[spfarr objectAtIndex:n] isEqualToString:@"让分主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                        
                                    }else if([[spfarr objectAtIndex:n] isEqualToString:@"让分主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]){
                                        be.selection2 = YES;
                                        
                                    }
                                }
                                
                            }
                            
                        }else  if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
                            for (int n = 0; n < [spfarr count]; n++) {
                                NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                    if ([arrspf count]>= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }else {
                                    if ([[spfarr objectAtIndex:n] isEqualToString:@"主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                        
                                    }else if([[spfarr objectAtIndex:n] isEqualToString:@"主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                        
                                    }
                                }
                                
                            }
                            
                        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"09"]) {
                            for (int n = 0; n < [spfarr count]; n++) {
                                NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }else {
                                    if ([[spfarr objectAtIndex:n] isEqualToString:@"大"]) {
                                        be.selection1 = YES;
                                        
                                    }else if([[spfarr objectAtIndex:n] isEqualToString:@"小"]){
                                        be.selection2 = YES;
                                        
                                    }
                                }
                                
                            }
                            
                        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
                            for (int n = 0; n < [spfarr count]; n++) {
                                NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                            be.selection2 = YES;
                                            
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                            be.selection3 = YES;
                                        }
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
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                            
                            NSMutableArray * bifenarr = nil;
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                                
                                
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                                //                                bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
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
                                    if ([kongs count] >=1 ) {
                                        zongstr = [kongs objectAtIndex:0];
                                    }else{
                                        zongstr = @"";
                                    }
                                    
                                }
                                
                                NSLog(@"zong = %@", zongstr);
                                if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                    NSArray * bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
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
                                    
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                            
                            
                        }
                        
                        
                    }else {
                        if([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
                            NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                if ([arrspf count] >= 1) {
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                            }else {
                                if ([shengpingfustr isEqualToString:@"让分主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                    be.selection1 = YES;
                                }else if([shengpingfustr isEqualToString:@"让分主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                    be.selection2 = YES;
                                }
                            }
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"06"]){
                            NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                if ([arrspf count] >= 1) {
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                            }else {
                                if ([shengpingfustr isEqualToString:@"主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                    be.selection1 = YES;
                                }else if([shengpingfustr isEqualToString:@"主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                    be.selection2 = YES;
                                }
                            }
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
                            NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                if ([arrspf count] >= 1) {
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                                
                            }else {
                                if ([shengpingfustr isEqualToString:@"大"]) {
                                    be.selection1 = YES;
                                }else if([shengpingfustr isEqualToString:@"小"]){
                                    be.selection2 = YES;
                                }
                            }
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
                            NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                if ([arrspf count] >= 1) {
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                        be.selection1 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                        be.selection2 = YES;
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                        be.selection3 = YES;
                                    }
                                    
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
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"] || [self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                            
                            NSMutableArray * bifenarr = nil;
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                                
                                
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                            }
                            
                            NSRange ssp = [shengpingfustr rangeOfString:@" "];
                            if (ssp.location != NSNotFound) {
                                NSArray * kongs = [shengpingfustr componentsSeparatedByString:@" "];
                                if ([kongs count] >= 1) {
                                    shengpingfustr = [kongs objectAtIndex:0];
                                }else{
                                    shengpingfustr = @"";
                                }
                                
                            }
                            NSLog(@"zong = %@", shengpingfustr);
                            
                            
                            NSMutableArray * shuarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int s = 0; s < [bifenarr count]; s++) {
                                [shuarr addObject:@"0"];
                            }
                            
                            if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
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
                            [shuarr release];
                            NSString * strbi = @"";
                            for (int q = 0; q < [be.bufshuarr count]; q++) {
                                if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                                    
                                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                                    
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                            NSLog(@"str = %@", strbi);
                            
                        }
                        
                        
                    }
                    
                    [cellarray addObject:be];
                    [be release];
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                //            if (matchenum  == matchEnumShengPingFuGuoGuan){
                //                sheng.fenzhong = jingcaipiao;
                //            }else{
                //                sheng.fenzhong = jingcaibifen;
                //            }
                //zhushuDic = [[NSMutableDictionary  alloc] initWithCapacity:0];
                [zhushuDic removeAllObjects];
                NSRange chuanfa = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
                if (chuanfa.location != NSNotFound) {
                    // labelch.text = @"多串...";
                    NSArray * douarr = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
                    for (int i = 0; i < [douarr count]; i++) {
                        NSArray * arrchuan = [[douarr objectAtIndex:i] componentsSeparatedByString:@"x"];
                        if ([arrchuan count] >= 2) {
                            NSString * chuanfastr = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
                            if (i == [douarr count]-1) {
                                NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                                [zhushuDic setObject:longNum forKey:chuanfastr];
                                [longNum release];
                                
                            }else{
                                NSNumber *longNum = [[NSNumber alloc] initWithLongLong:0];
                                [zhushuDic setObject:longNum forKey:chuanfastr];
                                [longNum release];
                            }

                        }
                        
                    }
                    
                    
                }else{
                    if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                        
                        
                        NSString * chuanfastr = @"单关";
                        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                        [zhushuDic setObject:longNum forKey:chuanfastr];
                        [longNum release];
                        
                    }else{
                        NSArray * arrchuan = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@"x"];
                        if ([arrchuan count] >= 2) {
                            NSString * chuanfastr = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
                            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                            [zhushuDic setObject:longNum forKey:chuanfastr];
                            [longNum release];
                        }
                       
                        
                    }
                    
                    
                }
                
                //                alldict = zhushuDic;
                //                allcellarr = cellarray;
                [self chaoDanYuJiJiangJin];
                
                
                //            [yuji release];
                
                
            }else{
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"暂不支持此彩种抄单"];
            }
            
            
            
            
            
            
            
            
            
            //            NSLog(@"wanfa = %@", self.BetDetailInfo.wanfaId);
            //            if  ([self.BetDetailInfo.wanfaId isEqualToString:@"01"] || [self.BetDetailInfo.wanfaId isEqualToString:@"05"]){
            //                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            //                gcjc.chaodanbool = YES;
            //                gcjc.betrecorinfo = self.BetDetailInfo;
            //                [self.navigationController pushViewController:gcjc animated:YES];
            //                [gcjc release];
            //            }else{
            //                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //                [cai showMessage:@"稍后上线"];
            //            }
            //
            //
            //         NSLog(@"cccccc");
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"400"]){
            NSLog(@"chuanfa = %@", self.BetDetailInfo.guguanWanfa );
            NSLog(@"400 = %@", self.BetDetailInfo.betContentArray);
            if  ([self.BetDetailInfo.wanfaId isEqualToString:@"01"] ) {
                
                //                sheng.title = @"竞彩足球胜平负(过关)";
                //                NSLog(@"%d", two);
                //                if (two == 1) {
                //                    sheng.danfushi = 0;
                //                } else{
                //                    sheng.danfushi = 1;
                //                }
                
                //                if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
                //                    yuji.maxmoney = @"";
                //                }
                //                if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
                //                    yuji.minmoney = @"";
                //                }
                // cellarray = [[NSMutableArray  alloc] initWithCapacity:0];
                [cellarray removeAllObjects];
                for (int m = 0; m < [self.BetDetailInfo.betContentArray count]; m++) {
                    NSString * contentstr = [self.BetDetailInfo.betContentArray objectAtIndex:m];
                    NSArray * contarr = [contentstr componentsSeparatedByString:@";"];
                    NSString * danstr = @"";
                    if ([contarr count] >= 3) {
                        danstr = [contarr objectAtIndex:3];
                    }
                    GC_BetData * be = [[GC_BetData alloc] init];
                    NSString * strdui = @"";
                    if ([contarr count] >= 1) {
                        strdui = [contarr objectAtIndex:0];
                    }
                    NSArray * duiarr = [strdui componentsSeparatedByString:@"VS"];
                    
                    if ([contarr count] >= 13) {
                        be.event = [contarr objectAtIndex:13];
                    }else{
                        be.event = @"";
                    }
                    if ([duiarr count] >= 2) {
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", [duiarr objectAtIndex:0], [duiarr objectAtIndex:1], @"0"];
                    }else{
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", @"", @"", @"0"];
                    }
                    
                    
                    if ([contarr count] >= 1) {
                        be.changhao = [contarr objectAtIndex:1];
                    }else{
                        be.changhao = @"";
                    }
                    
                    NSString *shengpingfustr = @"";
                    if ([contarr count] >= 7) {
                        shengpingfustr = [contarr objectAtIndex:7];
                    }
                    NSRange douhao = [shengpingfustr rangeOfString:@","];
                    if (douhao.location != NSNotFound) {
                        NSArray * spfarr = [shengpingfustr componentsSeparatedByString:@","];
                        
                        for (int n = 0; n < [spfarr count]; n++) {
                            NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                            
                            if (spfzi.location != NSNotFound) {
                                NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                if ([arrspf count] >= 1) {
                                    if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                        be.selection1 = YES;
                                        
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                        be.selection2 = YES;
                                        
                                    }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                        be.selection3 = YES;
                                    }
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
                            if ([arrspf count] >= 1) {
                                if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                    be.selection1 = YES;
                                }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                    be.selection2 = YES;
                                }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                    be.selection3 = YES;
                                }
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
                    
                    
                    
                    
                    [cellarray addObject:be];
                    [be release];
                    
                }
                
                
                
                [zhushuDic removeAllObjects];
                // zhushuDic = [[NSMutableDictionary  alloc] initWithCapacity:0];
                NSRange chuanfa = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
                if (chuanfa.location != NSNotFound) {
                    // labelch.text = @"多串...";
                    NSArray * douarr = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
                    for (int i = 0; i < [douarr count]; i++) {
                        //                        NSArray * arrchuan = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@"x"];
                        //                        NSLog(@"chuanfa = %@", self.BetDetailInfo.guguanWanfa );
                        NSString * chuanfastr = [douarr objectAtIndex:i] ;
                        if (i == [douarr count]-1) {
                            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                            [zhushuDic setObject:longNum forKey:chuanfastr];
                            [longNum release];
                            
                        }else{
                            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:0];
                            [zhushuDic setObject:longNum forKey:chuanfastr];
                            [longNum release];
                            
                        }
                    }
                    
                    
                }else{
                    //NSArray * arrchuan = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@"x"];
                    
                    NSString * chuanfastr = self.BetDetailInfo.guguanWanfa;
                    
                    NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                    [zhushuDic setObject:longNum forKey:chuanfastr];
                    [longNum release];
                }
                //                allcellarr = cellarray;
                //                alldict = zhushuDic;
                
                [self chaoDanYuJiJiangJin];
                
                
                
                
                
                
                NSLog(@"zhushumax = %@, min = %@", maxmoney, minmoney);
                
                
                
                
                
            }else{
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"暂不支持此彩种抄单"];
            }
            
            
            NSLog(@"ddddddd");
            //                GC_BJDanChangViewController * bjdanchang = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
            //                bjdanchang.chaodanbool = YES;
            //                bjdanchang.issString = self.BetInfo.issue;
            //                bjdanchang.betrecorinfo = self.BetDetailInfo;
            //                [self.navigationController pushViewController:bjdanchang animated:YES];
            //                [bjdanchang release];
            
        }else{
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"暂不支持此彩种抄单"];
        }
        
        
    }
}
- (void)scoreLiveFunc{
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    LiveScoreViewController *lsViewController = [[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil];
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"203"] || [self.BetDetailInfo.lotteryId isEqualToString:@"200"]) {
        lsViewController.liveType = 4;
    }
    
	[self.navigationController pushViewController:lsViewController animated:YES];
    [lsViewController release];
    return;
}


//比分直播
- (void)bifenzhibo {
    [self quxiao];
    //    LiveScoreViewController *lsViewController = [[LiveScoreViewController alloc] initWithNibName: @"LiveScoreViewController" bundle: nil];
    //	[self.navigationController pushViewController:lsViewController animated:YES];
    //    [lsViewController release];
    [self scoreLiveFunc];
}


// 邀请参与
- (void)yaoqing {
//    [self quxiao];
    //    if (ticaiType >= LanQiufencha) {
    //        [[caiboAppDelegate getAppDelegate] showMessage:@"稍后上线"];
    //        return;
    //    }
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//    if (self.BetDetailInfo.longprogramNumber) {
//        publishController.orderID = self.BetDetailInfo.longprogramNumber;
//    }
//    else {
//        publishController.orderID = self.BetInfo.programNumber;
//    }
//    publishController.play = self.BetDetailInfo.wanfaId;
//    NSLog(@"%@,%@",self.BetDetailInfo.lotteryId,publishController.orderID);
//    publishController.lottery_id = self.BetDetailInfo.lotteryId;
//#ifdef isCaiPiaoForIPad
//    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:publishController];
//#else
//    [self.navigationController pushViewController:publishController animated:YES];
//    
//#endif
//    [publishController release];
    
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    if (self.BetDetailInfo.longprogramNumber) {
        publishController.orderID = self.BetDetailInfo.longprogramNumber;
    }
    else {
        publishController.orderID = self.BetInfo.programNumber;
    }
    publishController.play = self.BetDetailInfo.wanfaId;
    NSLog(@"%@,%@",self.BetDetailInfo.lotteryId,publishController.orderID);
    publishController.lottery_id = self.BetDetailInfo.lotteryId;
    publishController.faxqUlr = [self urlFaxqFunc];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
}

// 分享
- (void)share {
    [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持新浪分享"];
}

//跟单者
- (void)GenDan {
    HeMaiRenListViewController *he = [[HeMaiRenListViewController alloc] init];
    if ([self.BetDetailInfo.longprogramNumber length]) {
        he.programNum = self.BetDetailInfo.longprogramNumber;
    }
    else {
        he.programNum = self.BetInfo.programNumber;
    }
    
    [self.navigationController pushViewController:he animated:YES];
    [he release];
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
		[httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpRequest startAsynchronous];
    }
}


#pragma mark -
#pragma mark View lifecycle

- (void)LoadIphoneView {
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height)];
    [self.mainView addSubview:backScrollView];
    backScrollView.scrollEnabled = NO;
    [backScrollView release];
}

- (void)LoadIpadView {
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(35, 0, 320, self.mainView.bounds.size.height)];
    [self.mainView addSubview:backScrollView];
    [backScrollView release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self checkisShuziOrNot];
    cellarray = [[NSMutableArray alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary  alloc] initWithCapacity:0];
    if (isHorse) {
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
    }
    else if (canBack) {
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(20, 0, 40, 44);
        [btn addTarget:self action:@selector(pressChongZhi) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        rightItem.enabled = YES;
        [self.CP_navigation setRightBarButtonItem:rightItem];
        [rightItem release];
    }
    else {
        self.CP_navigation.leftBarButtonItem = nil;
#ifndef isCaiPiaoForIPad
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 60, 44)];
        [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
#endif
    }
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    self.CP_navigation.title = @"方案详情";
    
    self.mainView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
	myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 300, self.mainView.bounds.size.height -60)];
	myTableView.backgroundColor = [UIColor clearColor];
	myTableView.delegate = self;
	myTableView.dataSource = self;
    myTableView.scrollEnabled = YES;
	[backScrollView addSubview:myTableView];
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
	
	if (!self.BetDetailInfo) {
		[self getDetailInfo];
	}
    con = [[UIControl alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:con];
    con.enabled = NO;
    [con addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [con release];
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!refreshHeaderView)
    {
		refreshHeaderView = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainView.frame.size.height, 320, self.mainView.frame.size.height)];
		refreshHeaderView.delegate = self;
		[myTableView addSubview:refreshHeaderView];
		[refreshHeaderView release];
		
	}
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDetailInfo) name:@"BecomeActive" object:nil];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ((ticaiType == ShengFuCai || ticaiType == BeiDan || ticaiType == JingCaiZuqiu) && isShishi && self.myMatchInfo) {
        self.shishiTimer = [NSTimer scheduledTimerWithTimeInterval:60 target: self selector: @selector(refreshBifen) userInfo: nil repeats: YES];
        [self.shishiTimer fire];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[rengouText resignFirstResponder];
    [self.shishiTimer invalidate];
    self.shishiTimer = nil;
    
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (isJJYH && (ticaiType == ZuQiuDahunTou || ticaiType == ShengFuCai || ticaiType == JingCaiZuqiu || ticaiType == BeiDan) && [self.BetDetailInfo.betContentArray count]) {
        return 2;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 1) {
        if ([self.BetDetailInfo.chaiInfoArray count] >= 108) {
            return 109;
        }
        return [self.BetDetailInfo.chaiInfoArray count];
    }
    if ([self.BetDetailInfo.betContentArray count] == 0) {
        return 0;
    }
    if (isDanShi && isShuZi) {
        return [self.redArray count] + 1;
    }
    if (isDanShi && !isShuZi) {
        return 0;
    }
    if (isMine) {
        if ([self.redArray count] == 50) {
            return 51;
        }
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"302"]) {
            return [self.BetDetailInfo.betContentArray count]/2;
        }
        if (!isShuZi) {
            if (ticaiType == Unsuort) {
                return 0;
            }
            if (ticaiType >= LanQiufencha && ticaiType <= LanQiuHunTou) {
                return [self.BetDetailInfo.betContentArray count] + 1;
            }
            return [self.BetDetailInfo.betContentArray count];
        }
        return [self.redArray count];
    }
	if (!isMine || [self.BetInfo.betStyle isEqualToString:@"1"]||[self.BetInfo.buyStyle isEqualToString:@"参与合买"]) {
        if ([self.BetDetailInfo.secretType isEqualToString:@"1"] )	{
			return 0;
		}
		else if ([self.BetDetailInfo.secretType isEqualToString:@"2"] && ![self.BetDetailInfo.endTime isEqualToString:@"已截期"]){
            return 0;
		}
		
		else if (([self.BetDetailInfo.secretType isEqualToString:@"3"] && self.BetDetailInfo.betContentArray.count == 0)){
            return 0;
		}
		
		else if (([self.BetDetailInfo.secretType isEqualToString:@"4"])){
            return 0;
        }
		else if ([self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"]) {
            return 0;
		}
	}
	if ([self.redArray count] == 50) {
		return 51;
	}
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"302"]) {
        return [self.BetDetailInfo.betContentArray count]/2;
    }
	if (!isShuZi) {
        if (ticaiType >= LanQiufencha && ticaiType <= LanQiuHunTou) {
            return [self.BetDetailInfo.betContentArray count] + 1;
        }
		return [self.BetDetailInfo.betContentArray count];
	}
    return [self.redArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!isShuZi) {
        if (indexPath.section == 1) {
            if (indexPath.row == 108) {
                return 35;
            }
            NSArray *infoA = [[self.BetDetailInfo.chaiInfoArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"||"];
            NSString * comstr = @"";
            if ([infoA count]>= 1) {
                comstr = [infoA objectAtIndex:1];
            }
            NSArray *array = [comstr componentsSeparatedByString:@"x"];
            if (indexPath.row == 0) {
                return 65 +[array count] * 20;
            }
            else {
                return 40 +[array count] * 20;
            }
        }
        NSInteger height = 70;
        NSArray *infoArray = nil;
        NSString *_text = nil;
        NSString *_caiguo = nil;
		switch (ticaiType) {
			case ShengFuCai:
                infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 2) {
                     _text = [[infoArray objectAtIndex:2] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                }else{
                    _text = @"";
                }
               
                CGSize maxSize = CGSizeMake(70, 1000);
                CGSize expectedSize = [_text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                if (height <expectedSize.height + 4) {
                    height = expectedSize.height +4;
                }
                if ([self.BetDetailInfo.lotteryId isEqualToString:@"302"]) {
                    return 95;
                }
				return height +5;
                
				break;
			case JingCaiZuqiu:
			{
                infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@";"];
                if (infoArray.count > 8) {
                    _text = [[infoArray objectAtIndex:8] stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
                }
                CGSize maxSize = CGSizeMake(70, 1000);
                CGSize expectedSize = [_text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                if (height <expectedSize.height + 4) {
                    height = expectedSize.height +4;
                }
				return height +5;
			}
            case ZuQiuDahunTou:
			{
                infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 14) {
                    NSArray *touzhuArray = [[infoArray objectAtIndex:13] componentsSeparatedByString:@"^"];
                    NSMutableArray *arrayTouZhu = [NSMutableArray array];
                    NSMutableArray *caiguoArray = [NSMutableArray array];
                    NSMutableArray *tureOrWrong = [NSMutableArray array];
                    for (int i = 0; i < [touzhuArray count]; i ++ ) {
                        NSArray *arrayT = [[touzhuArray objectAtIndex:i] componentsSeparatedByString:@"|"];
                        if ([arrayT count] >=3) {
                            [arrayTouZhu addObject:[arrayT objectAtIndex:0]];
                            [caiguoArray addObject:[arrayT objectAtIndex:1]];
                            [tureOrWrong addObject:[arrayT objectAtIndex:2]];
                        }
                    }
                    
                    NSInteger touzhuHeight = 0;
                    for (int i = 0; i < [arrayTouZhu count]; i ++) {
                        
                        CGSize maxSize = CGSizeMake(70, 1000);
                        CGSize expectedSize = [[arrayTouZhu objectAtIndex:i] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
                        
                        if ([touzhuArray count] == 1) {
                            if (touzhuHeight <expectedSize.height + 4) {
                                touzhuHeight = expectedSize.height +4;
                            }
                            if (touzhuHeight < height) {
                                touzhuHeight = height;
                            }
                        }
                        else {
                            if (expectedSize.height < 40) {
                                expectedSize.height = 40;
                            }
                            touzhuHeight = touzhuHeight + expectedSize.height + 5;
                            
                        }
                    }
                    height = touzhuHeight;
                    
                }
                return height +5;
			}
			case BeiDan:
			{
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@";"];
                if (infoArray.count > 7) {
                    _text = [infoArray objectAtIndex:7];
                }
			}
				break;
            case AoYun1:{
                height = 18;
                infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row]
                             componentsSeparatedByString:@";"];
             
                if ([infoArray count] >= 2) {
                    _text = [infoArray objectAtIndex:2];
                }else{
                    _text = @"";
                }
                
            }
				break;
            case AoYun2: {
                infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row]
                             componentsSeparatedByString:@";"];
                if ([infoArray count] >= 3) {
                        _text = [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                }
                
            }
                break;
            case AoYun3: {
                return 54;
            }
            case LanQiufencha: {
                if (indexPath.row == 0) {
                    return 30;
                }
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row -1] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 4) {
                    _text = [infoArray objectAtIndex:4];
                    _caiguo= [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                    _caiguo= @"";
                }
            }
                break;
            case LanQiuRangfen: {
                if (indexPath.row == 0) {
                    return 30;
                }
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row - 1] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 4) {
                    _text = [infoArray objectAtIndex:4];
                    _caiguo= [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                    _caiguo= @"";
                }
				
            }
                break;
            case LanQiuShengfu: {
                if (indexPath.row == 0) {
                    return 30;
                }
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row -1] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 4) {
                    _text = [infoArray objectAtIndex:4];
                    _caiguo= [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                    _caiguo= @"";
                }
				
            }
                break;
            case LanQiuDaxiafen: {
                if (indexPath.row == 0) {
                    return 30;
                }
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row -1] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 4) {
                    _text = [infoArray objectAtIndex:4];
                    _caiguo= [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                    _caiguo= @"";
                }
				
            }
                break;
            case LanQiuHunTou: {
                if (indexPath.row == 0) {
                    return 30;
                }
				infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row -1] componentsSeparatedByString:@";"];
                if ([infoArray count] >= 4) {
                    _text = [infoArray objectAtIndex:4];
                    _caiguo= [infoArray objectAtIndex:3];
                }else{
                    _text = @"";
                    _caiguo= @"";
                }
				
            }
                break;
			default:
				break;
		}
        CGSize maxSize = CGSizeMake(70, 1000);
        _text = [_text stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        CGSize expectedSize = [_text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
        _caiguo= [_caiguo stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
        CGSize expectedSize2 = [_caiguo sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
        if (ticaiType == BeiDan) {
            if (height <expectedSize.height + 4) {
                height = expectedSize.height +4;
            }
        }
        else {
            if (height <expectedSize.height + 30) {
                height = expectedSize.height + 30;
            }
            if (height < 2 * expectedSize2.height + 30) {
                height = 2 *expectedSize2.height +30;
            }
        }
        
        return height +5;
	}
	if (indexPath.row != 50) {
        if (indexPath.row >= [self.redArray count] && isDanShi) {
            return 54;
        }
		if (indexPath.row <[self.blueArray count]) {
            NSMutableArray * redarr = [self.redArray objectAtIndex:indexPath.row];
            NSMutableArray * houarr = [self.blueArray objectAtIndex:indexPath.row];
            if (indexPath.row < [fengeArray count]) {
                
                return ([redarr count]+ [houarr count] + [(NSArray *)[fengeArray objectAtIndex:indexPath.row] count])/8 *36 +  45;
            }
			return ([redarr count]+ [houarr count])/8 *36 +  45;
		}
		NSMutableArray * xiaarr = [self.redArray objectAtIndex:indexPath.row];
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"122"]) {
            if ([self.BetDetailInfo.wanfaId intValue] == 3 || [self.BetDetailInfo.wanfaId intValue] == 4) {
                return ([xiaarr count] - 1)/2 *36 +54;
            }
            if ([self.BetDetailInfo.wanfaId intValue] == 5 ) {
                return ([xiaarr count] - 1)/3 *36 + 54;
            }
            return ([xiaarr count] - 1)/8 *36 +54;
        }
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"012"] || [self.BetDetailInfo.lotteryId isEqualToString:@"013"] || [self.BetDetailInfo.lotteryId isEqualToString:@"019"] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.BetDetailInfo.lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//内蒙古和江苏快三
            if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]) {
                return  ([xiaarr count] - 1)/3 *36 + 54;
            }

            else if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
                
                if ([(NSArray *)[fengeArray objectAtIndex:indexPath.row] count] > 0) {
                    return ([xiaarr count] + [[[fengeArray objectAtIndex:indexPath.row] objectAtIndex:0] intValue] * 2 -1)/ 8 * 36 + 50;
                }
            }
            
        }
        if (indexPath.row < [fengeArray count]) {
            
            return ([xiaarr count] -1 + [(NSArray *)[fengeArray objectAtIndex:indexPath.row] count])/8 *36 + 54;
        }
		return ([xiaarr count] -1 + [fengeArray count])/8 *36 + 54;
	}
	else {
		return 54;
	}
	
	return 44;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    
    if (isShuZi) {
		static NSString *Cell1Identifier = @"CellShuzi";
		GouCaiShuZiCell *cell1 = (GouCaiShuZiCell *)[tableView dequeueReusableCellWithIdentifier:Cell1Identifier];
		if (cell1 == nil) {
			cell1 = [[[GouCaiShuZiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell1Identifier] autorelease];
            cell1.wanfa = self.BetDetailInfo.wanfaId;
            cell1.mylotteryId = self.BetDetailInfo.lotteryId;
            if ([self.BetDetailInfo.betStyle isEqualToString:@"和值"]) {
                cell1.isHeZhi = YES;
            }
            cell1.isDanshi = isDanShi;
            if (isHorse) {
                cell1.isHorseCell = YES;
                if ([BetInfo.mode isEqualToString:@"0"]) {
                    cell1.isHorseDuoWanFa = YES;
                }
            }
		}
        if (indexPath.row == 0) {
            cell1.isFirst = YES;
        }
        else {
            cell1.isFirst = NO;
        }
        if (!isDanShi) {
            cell1.zhongjiang = self.BetDetailInfo.awardNum;
        }
        
		if (indexPath.row == [self.redArray count]) {
            static NSString *Cell1Identifier = @"CellShuziMore";
            GouCaiShuZiCell *cell1 = (GouCaiShuZiCell *)[tableView dequeueReusableCellWithIdentifier:Cell1Identifier];
            if (cell1 == nil) {
                cell1 = [[[GouCaiShuZiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell1Identifier] autorelease];
                UILabel *cellLabel = [[UILabel alloc] init];
                [cell1.contentView addSubview:cellLabel];
                cellLabel.backgroundColor = [UIColor clearColor];
                cellLabel.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
                cellLabel.font = [UIFont systemFontOfSize:14];
                cellLabel.frame = CGRectMake(0, 0, 320, 40);
                cellLabel.tag = 121;
                [cellLabel release];
            }
            UILabel *cellLabel = (UILabel *)[cell1.contentView viewWithTag:121];
            cell1.backImage1.image = nil;
            if (isDanShi) {
                UIView *line = (UIView *)[cell1.contentView viewWithTag:101];
                if (!line) {
                    line = [[UIView alloc] init];
                    [cell1.contentView addSubview:line];
                    line.backgroundColor = [UIColor lightGrayColor];
                    line.frame = CGRectMake(0, 0, 320, 0.5);
                    [line release];
                }
                cellLabel.text = [NSString stringWithFormat:@"预览%d条，共计%d条",(int)[self.redArray count],(int)self.BetDetailInfo.betLenght];
                cellLabel.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            }
            else {
                cellLabel.text = @"更多方案请到网页版查看";
            }
			
			cellLabel.font = [UIFont systemFontOfSize:13];
			cellLabel.textAlignment = NSTextAlignmentCenter;
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
			return cell1;
		}
        if (isHorse) {
            cell1.wanfa = BetInfo.mode;
            
            if ([BetInfo.mode isEqualToString:@"0"]) {
                cell1.wanfa = [modeArray objectAtIndex:indexPath.row];
            }
        }
        
        NSArray *array = nil,*array2 = nil;
        if (indexPath.row <[self.blueArray count]) {
            array = [self.blueArray objectAtIndex:indexPath.row];
        }
        if ([fengeArray count]>indexPath.row) {
            array2 = [fengeArray objectAtIndex:indexPath.row];
        }
        if (self.redArray.count > indexPath.row) {
            [cell1 LoadRedArray:[self.redArray objectAtIndex:indexPath.row] BlueArray:array FenGeArrag:array2];
        }
        else {
            [cell1 LoadRedArray:nil BlueArray:nil FenGeArrag:nil];
        }
        
        if ([BetInfo.mode isEqualToString:@"0"] && isHorse) {
            NSString * titleStr = [wanFaTitleArr objectAtIndex:indexPath.row];
            if ([titleStr length]) {
                UILabel * titleLabel = (UILabel *)[cell1 viewWithTag:666];
                titleLabel.text = titleStr;
                titleLabel.superview.hidden = NO;
            }
        }
        
        return cell1;
	}
	else {
        if (indexPath.section == 0) {
            static NSString *Cell1Identifier = @"CellTi";
            GouCaiTiCaiCell *cell1 = (GouCaiTiCaiCell *)[tableView dequeueReusableCellWithIdentifier:Cell1Identifier];
            if (cell1 == nil) {
                cell1 = [[[GouCaiTiCaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell1Identifier] autorelease];
            }
            cell1.wanfa = self.BetDetailInfo.wanfaId;
            cell1.chuanfa = self.BetDetailInfo.guguanWanfa;
            cell1.isJJYH = isJJYH;
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"302"]) {
                if (self.BetDetailInfo.betContentArray.count > 2*indexPath.row + 1) {
                    [cell1 LoadData:[self.BetDetailInfo.betContentArray objectAtIndex:2*indexPath.row] Info:[self.BetDetailInfo.betContentArray objectAtIndex:2*indexPath.row + 1] LottoryType:ticaiType];
                }
                else {
                    [cell1 LoadData:nil Info:nil LottoryType:ticaiType];
                }
                
            }
            else {
                if (ticaiType >= LanQiufencha && ticaiType <= LanQiuHunTou) {
                    if (indexPath.row == 0) {
                        [cell1 LoadData:nil Info:nil LottoryType:ticaiType];
                    }
                    else {
                        if (self.BetDetailInfo.betContentArray.count > indexPath.row - 1) {
                            [cell1 LoadData:[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row - 1] Info:nil LottoryType:ticaiType];
                        }
                        else {
                            [cell1 LoadData:nil Info:nil LottoryType:ticaiType];
                        }
                        
                    }
                    
                }
                else {
                    if (self.BetDetailInfo.betContentArray.count > indexPath.row) {
                        [cell1 LoadData:[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] Info:nil LottoryType:ticaiType];
                    }
                    else {
                        [cell1 LoadData:nil Info:nil LottoryType:ticaiType];
                    }
                    
                }
                
            }
            
            //时时比分
            if ((ticaiType == ShengFuCai || ticaiType == BeiDan || ticaiType == JingCaiZuqiu || ticaiType == ZuQiuDahunTou) && isShishi) {
                [cell1 LoadMatchInfo:self.myMatchInfo];
                if (cell1.myMatchInfo) {
                    cell1.shishiBtn.tag = indexPath.row;
                    [cell1.shishiBtn addTarget:self action:@selector(gobifenzhibo:) forControlEvents:UIControlEventTouchUpInside];
                    if (cell1.myMatchInfo.isColorNeedChange) {
                        [self performSelector:@selector(colorReset:) withObject:cell1.myMatchInfo afterDelay:10];
                    }
                    
                }
                
            }
            
            return cell1;
        }
        else if (indexPath.section == 1) {
            if (indexPath.row >= 108) {
                static NSString *Cell1Identifier = @"CellShuziMore";
                GouCaiShuZiCell *cell1 = (GouCaiShuZiCell *)[tableView dequeueReusableCellWithIdentifier:Cell1Identifier];
                if (cell1 == nil) {
                    cell1 = [[[GouCaiShuZiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell1Identifier] autorelease];
                }
                cell1.backImage1.image = nil;
                cell1.textLabel.text = @"更多方案请到网页版查看";
                cell1.textLabel.font = [UIFont systemFontOfSize:13];
                cell1.textLabel.textAlignment = NSTextAlignmentCenter;
                [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell1;
            }else {
                static NSString *Cell1Identifier = @"CellChai";
                GouCaiChaiCell *cell1 = (GouCaiChaiCell *)[tableView dequeueReusableCellWithIdentifier:Cell1Identifier];
                if (cell1 == nil) {
                    cell1 = [[[GouCaiChaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell1Identifier] autorelease];
                }
                cell1.Index = indexPath.row;
                if (self.BetDetailInfo.chaiInfoArray.count > indexPath.row) {
                    [cell1 setMyinfo:[self.BetDetailInfo.chaiInfoArray objectAtIndex:indexPath.row]];
                }
                else {
                    [cell1 setMyinfo:nil];
                }
                
                return cell1;
            }
            
        }
	}
	
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
    if (isShuZi) {
        return;
    }
    if (indexPath.row != 0 && indexPath.row - 1 < self.BetDetailInfo.betContentArray.count) {
        if (ticaiType >= LanQiufencha && ticaiType <= LanQiuHunTou) {
            if (indexPath.row > 0 && self.BetDetailInfo.betContentArray.count > indexPath.row - 1) {
                NSArray *array = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row - 1] componentsSeparatedByString:@";"];
                if ([array count] > 15 && [[array objectAtIndex:15] rangeOfString:@"dg"].location != NSNotFound) {
                    CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:@"有此标注的是单关哦" message:@"  \n   \n   \n    \n  \n   \n  \n   \n   \n  \n  \n  \n" delegate:self cancelButtonTitle:@"知道啦"otherButtonTitles:nil];
                    [alet show];
                    [alet release];
                    
                    UIImageView *imagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 238, 182.5)];
                    imagV.image = UIImageGetImageFromName(@"faxqdanguan2.png");
                    imagV.backgroundColor = [UIColor clearColor];
                    [alet addSubview:imagV];
                    imagV.center = alet.center;
                    [imagV release];
                }
                
            }
            return;
        }
        
    }
    if (indexPath.row > self.BetDetailInfo.betContentArray.count) {
        return;
    }
    NSArray *array = [[self.BetDetailInfo.betContentArray objectAtIndex:indexPath.row] componentsSeparatedByString:@";"];

    if ((ticaiType == JingCaiZuqiu && [array count] > 16 && [[array objectAtIndex:16] isEqualToString:@"dg"]) || (ticaiType == ZuQiuDahunTou && [array count] > 13 && [[array objectAtIndex:13] rangeOfString:@"dg"].location != NSNotFound )) {
        
            
            CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:@"有此标注的是单关哦" message:@"  \n   \n   \n    \n  \n   \n  \n   \n   \n  \n  \n  \n" delegate:self cancelButtonTitle:@"知道啦"otherButtonTitles:nil];
        [alet show];
            [alet release];
            
            UIImageView *imagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 238, 182.5)];
            imagV.image = UIImageGetImageFromName(@"faxqdanguan.png");
            imagV.backgroundColor = [UIColor clearColor];
            [alet addSubview:imagV];
            imagV.center = alet.center;
            [imagV release];
            
        }
    
}

- (void)removeDan:(UIButton *) sender {
    [sender.superview removeFromSuperview];
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
    [[caiboAppDelegate getAppDelegate] clearuploadDelegate];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [editeView release];
    [cellarray release];
    [fengeArray release];
//    [infoPlayer release];
    [zhushuDic release];
	self.BetInfo = nil;
	self.BetDetailInfo = nil;
	self.redArray = nil;
	self.blueArray = nil;
    self.lottoryName = nil;
    self.orderId = nil;
    self.myMatchInfo = nil;
    self.bendaZhongJiangJinE = nil;
	[httpRequest clearDelegatesAndCancel];
	[httpRequest release];
	[myTableView release];
    self.issure = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    
    [placeholderLabel release];
    
    [wanFaTitleArr release];
    [modeArray release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            [GC_UserInfo sharedInstance].accountManage = aManage;
            zhanghuLable.text = [NSString stringWithFormat:@"账户余额<%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
            if (!yuE) {
                self.yuE = zhanghuLable.text;
            }else{
                if (![yuE isEqualToString:zhanghuLable.text]) {
                    self.yuE = @"success";
                }
            }
        }
		[aManage release];
    }
}

- (void)reChedanFinished:(ASIHTTPRequest*)request{
    if ([request responseData]) {
        ChedaJiexi *jiexi = [[ChedaJiexi alloc] initWithResponseData:request.responseData WithRequest:request];
        if (jiexi.returnId != 3000) {
            
            if ([jiexi.code isEqualToString:@"1"]) {
                
                //                self.CP_navigation.rightBarButtonItem.enabled = NO;
                cheDanBool = YES;
                
                UIButton * but =  (UIButton *)self.CP_navigation.rightBarButtonItem;
                but.enabled = NO;
                
                CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:nil message:@"撤单成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alet show];
                [alet release];
                if (isShishi) {
                    [self changeShiShi];
                }
                [self getDetailInfo];
            }
            else {
                CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:nil message:jiexi.msgString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alet show];
                [alet release];
            }
            
            //            else {
            //                CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"撤单失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            //                [alet show];
            //                [alet release];
            //            }
        }
        [jiexi release];
    }
}

- (void)reBetRecordDetailFinished:(ASIHTTPRequest*)request
{
    isLoading = NO;
    [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    NSString * lotnum = @"";
    requstFaildCount = 0;
    myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
    if ([request responseData]) {
        BetRecordDetailType type = BetRecordDetailPK;
        if (isHorse) {
            type = BetRecordDetailHorse;
        }
		GC_BetRecordDetail *brd = [[GC_BetRecordDetail alloc] initWithResponseData:[request responseData] WithRequest:request betRecordDetailType:type];
        if (isHorse) {
            GC_PKDetailData *br = [[[GC_PKDetailData alloc]initWithResponseData:request.responseData WithRequest:request type:PKDetailHorse] autorelease];
            brd.returnId = br.returnId;
            brd.programAmount = br.betMoney;
            brd.betsNum = br.zhuShu;
            brd.multiplenNum = br.beiShu;
            brd.issue = br.qici;
            
            NSString * kaiJiangNum = @"";
            for (int i = 0; i < br.kaijiangNum.length/2; i++) {
                if ([kaiJiangNum length]) {
                    kaiJiangNum = [kaiJiangNum stringByAppendingString:@","];
                }
                kaiJiangNum = [kaiJiangNum stringByAppendingString:[br.kaijiangNum substringWithRange:NSMakeRange(i * 2, 2)]];
            }
            brd.awardNum = kaiJiangNum;
            
            if (!br.kaijiangNum || ![br.kaijiangNum length]) {
                brd.awardNum = br.statue;
            }
            brd.beginTime = br.orderTime;
            brd.jackpot = br.statue;
            brd.jiangMoney = br.getMoney;
            
            NSString * contentStr = br.touzhuContent;
            if (br.touzhuContent && [br.touzhuContent length] && [[br.touzhuContent substringFromIndex:[br.touzhuContent length] - 1] isEqualToString:@";"]) {
                contentStr = [br.touzhuContent substringToIndex:[br.touzhuContent length] - 1];
            }
            brd.betContentArray = [NSMutableArray arrayWithArray:[contentStr componentsSeparatedByString:@";"]];
            
            BetInfo.mode = br.wanfa;
            
            brd.lotteryId = LOTTERY_ID_SHANDONG_11;
        }
        if (brd == nil) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"此方案不存在"];
            self.CP_navigation.rightBarButtonItem = nil;
            [brd release];
            return;
        }
		if (brd.returnId != 3000) {
			self.BetDetailInfo = brd;
            if ([self.BetDetailInfo.secretType isEqualToString:@"4"] && [self.BetDetailInfo.betContentArray count] == 0) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"此方案不存在"];
                self.CP_navigation.rightBarButtonItem = nil;
                [brd release];
                return;
            }
            if (!nikeName || [nikeName isEqualToString:@""]) {
                self.nikeName = self.BetDetailInfo.sponsorsName;
            }
            
            
		}
        else {
            
            [brd release];
            return;
        }
        if (!self.BetInfo) {
            BetRecordInfor *info = [[BetRecordInfor alloc] init];
            self.BetInfo = info;
            [info release];
            self.BetInfo.lotteryNum = self.BetDetailInfo.lotteryId;
            self.BetInfo.betAmount = self.BetDetailInfo.programAmount;
            self.BetInfo.betStyle = self.BetDetailInfo.betStyle;
            self.BetInfo.buyStyle = self.BetDetailInfo.buyWay;
            self.BetInfo.programState = self.BetDetailInfo.drawerState;
            self.BetInfo.awardState = self.BetDetailInfo.jackpot;
            self.BetInfo.programNumber = self.orderId;
            self.BetInfo.baomiType = self.BetDetailInfo.secretType;
            //            self.BetInfo.issue = self.issure;
            
            NSLog(@"xxx= %@", self.issure);
        }
        if (![self.orderId length]) {
            self.orderId = self.BetDetailInfo.programNumber;
        }
        if (![self.BetInfo.programNumber length]) {
            self.BetInfo.programNumber = self.BetDetailInfo.programNumber;
        }
        if ([self.BetDetailInfo.alertInfo length] > 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:self.BetDetailInfo.alertInfo];
        }
        if ([self.BetDetailInfo.issue length] > 3 && ![self.BetDetailInfo.issue isEqualToString:@"null"]) {
            self.BetInfo.issue = self.BetDetailInfo.issue;
        }
        else if ([self.issure length]) {
            self.BetInfo.issue = self.issure;
        }
        
        lotnum = brd.awardNum;
        //        if (self.BetDetailInfo.returnId == 0) {
        //            [self.navigationController popViewControllerAnimated:YES];
        //        }
		[brd release];
        if ([self.BetDetailInfo.sponsorsName isEqualToString:[[Info getInstance] nickName]]) {
            isMine = YES;
        }
		isDanShi = NO;
        [self checkisShuziOrNot];
        NSLog(@"betarray = %@", self.BetDetailInfo.betContentArray);
		
		if ([self.BetDetailInfo.betContentArray count] != 0) {
			NSString  *info  = [self.BetDetailInfo.betContentArray objectAtIndex:0];
			if ([info hasPrefix:@"http:"]) {
				isDanShi = YES;
			}
            else if ([info hasPrefix:@"jjyh"]) {
                isJJYH = YES;
            }
		}
        if ([self.BetDetailInfo.jiangjinyouhua isEqualToString:@"jjyh"]) {
            isJJYH = YES;
        }
		if (!isDanShi) {
			[self getBallArrayForm:self.BetDetailInfo.betContentArray];
			if (!isShuZi) {
				ticaiType = [self getTiCaiMoban:self.BetDetailInfo.lotteryId];
			}
		}
        else {
            if (isShuZi) {
                self.BetDetailInfo.betContentArray = [NSMutableArray arrayWithArray:[self.BetDetailInfo.danshiInfo componentsSeparatedByString:@";"]];
                [self.BetDetailInfo.betContentArray removeObject:@""];
                [self getBallArrayForm:self.BetDetailInfo.betContentArray];
            }

        }
        //        self.CP_navigation.title = [GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId];
        if (!self.CP_navigation.titleView) {
            UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            self.CP_navigation.titleView = titleV;
            titleV.backgroundColor = [UIColor clearColor];
            UILabel *nameLable = [[UILabel alloc] init];
            nameLable.backgroundColor = [UIColor clearColor];
            
            NSLog(@"namelabele = %@", nameLable.text);
            nameLable.textColor = [UIColor whiteColor];
            
            nameLable.font = [UIFont systemFontOfSize:20];
            [titleV addSubview:nameLable];
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]) {
                if ([self.BetDetailInfo.betContentArray count] && ([self.BetDetailInfo.wanfaId isEqualToString:@"06"] || [self.BetDetailInfo.wanfaId isEqualToString:@"07"])) {
                    NSArray *infoArray = [[self.BetDetailInfo.betContentArray objectAtIndex:0] componentsSeparatedByString:@";"];
                    if ([infoArray count] >= 15) {
                        nameLable.text = [infoArray objectAtIndex:14];
                    }
                }
            }
            if ([nameLable.text length]) {
                nameLable.frame = CGRectMake(0, 0, 320, 44);
                nameLable.textAlignment = NSTextAlignmentCenter;
            }
            else if (isHorse) {
                nameLable.text = [NSString stringWithFormat:Lottery_Name_Horse];
                
                UILabel *issLabel = [[UILabel alloc] init];
                issLabel.backgroundColor = [UIColor clearColor];
                NSString *iss = self.BetInfo.issue;
                issLabel.text = [NSString stringWithFormat:@"%@场",iss];
                issLabel.textColor = [UIColor whiteColor];
                issLabel.font = [UIFont systemFontOfSize:13];
                issLabel.frame = CGRectMake(162, 18, 100, 15);
                [titleV addSubview:issLabel];
                [issLabel release];

                
                NSString * str2 = issLabel.text;
                UIFont * font2 = [UIFont systemFontOfSize:13];
                CGSize  size2 = CGSizeMake(100, 15);
                CGSize labelSize2 = [str2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:UILineBreakModeWordWrap];
                
                NSString * str = nameLable.text;
                UIFont * font = [UIFont systemFontOfSize:20];
                CGSize  size = CGSizeMake(200, 22);
                CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                
                nameLable.frame = CGRectMake((320-labelSize.width)/2 - (labelSize2.width/2), 11, labelSize.width, 22);
                issLabel.frame = CGRectMake(nameLable.frame.origin.x + nameLable.frame.size.width+2, 18, labelSize2.width, 15);

            }
            else {
                nameLable.text = [GC_LotteryType lotteryNameWithLotteryID:self.BetDetailInfo.lotteryId];
                if ([nameLable.text isEqualToString:@"竞彩足球"] ||[nameLable.text isEqualToString:@"竞彩篮球"]) {
                    nameLable.text = @"竞彩";
                }
                if ([self.BetInfo.issue length]>2 ||[self.issure length] > 2) {
                    
                    nameLable.textAlignment = NSTextAlignmentRight;
                    
                    UILabel *issLabel = [[UILabel alloc] init];
                    issLabel.backgroundColor = [UIColor clearColor];
                    NSString *iss = self.BetInfo.issue;
                    if ([self.issure length] ) {
                        iss = self.issure;
                    }
                    issLabel.text = [NSString stringWithFormat:@"%@期",iss];
                    if (guoguanme) {
                        issLabel.text = [NSString stringWithFormat:@"%@",iss];
                    }
                    issLabel.textColor = [UIColor whiteColor];
                    
                    issLabel.font = [UIFont systemFontOfSize:13];
                    issLabel.frame = CGRectMake(162, 18, 100, 15);
                    [titleV addSubview:issLabel];
                    [issLabel release];
                    
                    NSString * str2 = issLabel.text;
                    UIFont * font2 = [UIFont systemFontOfSize:13];
                    CGSize  size2 = CGSizeMake(100, 15);
                    CGSize labelSize2 = [str2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:UILineBreakModeWordWrap];
                    
                    NSString * str = nameLable.text;
                    UIFont * font = [UIFont systemFontOfSize:20];
                    CGSize  size = CGSizeMake(200, 22);
                    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    
                    
                    
                    
                    nameLable.frame = CGRectMake((320-labelSize.width)/2 - (labelSize2.width/2), 11, labelSize.width, 22);
                    issLabel.frame = CGRectMake(nameLable.frame.origin.x + nameLable.frame.size.width+2, 18, labelSize2.width, 15);
                    
                }
                else {
                    nameLable.frame = CGRectMake(0, 0, 320, 44);
                    nameLable.textAlignment = NSTextAlignmentCenter;
                }
            }
            
            [nameLable release];
            [titleV release];
        }
        
		NSLog(@"lotnum = %@", lotnum);
        if (!hemaibool) {
            if ([lotnum isEqualToString:@"未截期，暂不公开！"]&&!isMine) {
				
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"未截期，暂不公开！"];
            }
        }
        
		if (hemaiView) {
            [hemaiView removeFromSuperview];
            hemaiView = nil;
            footZhankaiV= nil;
            rengouText= nil;
        }
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, 0, 320, self.mainView.bounds.size.height);
        if (([self.BetDetailInfo.buyWay isEqualToString:@"发起合买"]||[self.BetDetailInfo.buyWay isEqualToString:@"参与合买"])
			&&[self.BetDetailInfo.subscriptionAmount intValue] != 0
            &&!([self.BetDetailInfo.lotteryId isEqualToString:@"113"] && [self.BetDetailInfo.wanfaId isEqualToString:@"02"])
			&&![self.BetDetailInfo.endTime isEqualToString:@"已截期"]&&![self.BetDetailInfo.drawerState isEqualToString:@"撤单"]) {
			myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height -88);
            backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, 0, 320, self.mainView.bounds.size.height -88);
			if (!hemaiView) {
				hemaiView = [[UIView alloc] init];
				hemaiView.frame = CGRectMake(0, self.mainView.bounds.size.height -88, self.mainView.bounds.size.width, 88);
                hemaiView.backgroundColor = [UIColor whiteColor];
				[self.mainView addSubview:hemaiView];
				[hemaiView release];
                
                
                footZhankaiV = [[CPZhanKaiView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.bounds.size.width, 44)];
                footZhankaiV.canZhanKaiByTouch = NO;
                footZhankaiV.frame = CGRectMake(0, 0, self.mainView.bounds.size.width, 44);
                footZhankaiV.normalHeight = 44;
                footZhankaiV.zhankaiHeight = 154;
                [hemaiView addSubview:footZhankaiV];
                [footZhankaiV release];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
                [hemaiView addSubview:line];
                line.backgroundColor = [UIColor lightGrayColor];
                [line release];
                
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.backgroundColor = [UIColor whiteColor];
                imageView1.frame = CGRectMake(0, 0, self.mainView.bounds.size.width, 44);
                [footZhankaiV addSubview:imageView1];
                imageView1.userInteractionEnabled = YES;
                [imageView1 release];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.image = nil;
                imageView2.frame = CGRectMake(0, 44, self.mainView.bounds.size.width, 110);
                [footZhankaiV addSubview:imageView2];
                imageView2.userInteractionEnabled = YES;
                [imageView2 release];
                
                for (int i = 0; i < 12; i ++) {
                    CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
                    [imageView2 addSubview:btn];
                    int a = i/6;
                    int b = i%6;
                    btn.frame = CGRectMake(17 + b * 51, 12 + a *51, 39, 39);
                    [btn loadButonImage:@"jianpan-queding-zhengchang_1.png" LabelName:[NSString stringWithFormat:@"%d",i]];
                    if (i == 10) {
                        btn.buttonName.text = nil;
                        [btn loadButonImage:@"jianpan-shanchu-zhengchang.png" LabelName:@""];
                    }
                    
                    else if (i == 11) {
                        [btn loadButonImage:@"jianpan-queding-zhengchang_1.png" LabelName:@"确定"];
//                        btn.buttonName.text = @"完成";
                    }
                    
                    btn.tag = i;
                    [btn addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
                }
                
				ColorView *infoLable = [[ColorView alloc] initWithFrame:CGRectMake(15, 4, 130, 20)];
				infoLable.backgroundColor = [UIColor clearColor];
				infoLable.text = [NSString stringWithFormat:@"此方案剩 <%@> 份",self.BetDetailInfo.subscriptionAmount];
				[imageView1 addSubview:infoLable];
				infoLable.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
                infoLable.font = [UIFont systemFontOfSize:10];
                infoLable.colorfont = [UIFont systemFontOfSize:10];
				infoLable.changeColor = [UIColor redColor];
				[infoLable release];
				
                UIButton *rengouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                rengouBtn.frame = CGRectMake(120, 7, 80, 30);
                [imageView1 addSubview:rengouBtn];
                [rengouBtn addTarget:self action:@selector(rengouSelcte) forControlEvents:UIControlEventTouchUpInside];
                [rengouBtn setBackgroundImage:[UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
                [rengouBtn setBackgroundImage:[UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
                
				rengouText = [[UITextField alloc] init];
				rengouText.delegate = self;
				rengouText.text = @"1";
                rengouText.textColor = [UIColor grayColor];
                rengouText.userInteractionEnabled = NO;
				rengouText.keyboardType = UIKeyboardTypeNumberPad;
				rengouText.frame = CGRectMake(120, 12, 60, 20);
				rengouText.textAlignment = NSTextAlignmentCenter;
				rengouText.backgroundColor = [UIColor clearColor];
				[imageView1 addSubview:rengouText];
				[rengouText release];
                
				UILabel *label11 = [[UILabel alloc] init];
				label11.frame = CGRectMake(180, 13, 20, 20);
				[imageView1 addSubview:label11];
				label11.text = @"份";
                label11.font = [UIFont systemFontOfSize:14];
				label11.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
				label11.backgroundColor = [UIColor clearColor];
				[label11 release];
                
				CP_PTButton * addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
				addbutton.frame = CGRectMake(215, 7, 45, 30);
                [addbutton loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
                [addbutton setHightImage:UIImageGetImageFromName(@"zhuihaojia_selected.png")];
				[addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
                
				CP_PTButton * jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
				jianbutton.frame = CGRectMake(261, 7, 45, 30);
                [jianbutton loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
                [jianbutton setHightImage:UIImageGetImageFromName(@"zhuihaojian_selected.png")];
				[jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
				[imageView1 addSubview:addbutton];
				[imageView1 addSubview:jianbutton];
				
				zhanghuLable = [[ColorView alloc] initWithFrame:CGRectMake(15, 25, 150, 20)];
				zhanghuLable.text = [NSString stringWithFormat:@"账户余额 <%.2f> 元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
                [self getAccountInfoRequest];
				zhanghuLable.backgroundColor = [UIColor clearColor];
				zhanghuLable.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
				zhanghuLable.font = [UIFont systemFontOfSize:10];
                zhanghuLable.colorfont = [UIFont systemFontOfSize:10];
				zhanghuLable.changeColor = [UIColor redColor];
				[imageView1 addSubview:zhanghuLable];
				zhanghuLable.userInteractionEnabled = NO;
				[zhanghuLable release];
                
                UIView *diView = [[UIView alloc] init];
                [hemaiView addSubview:diView];
                diView.frame = CGRectMake(0, hemaiView.frame.size.height - 44, 320 , 44);
                diView.backgroundColor = [UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1.0];
                [diView release];
                
				sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
				[diView addSubview:sendBtn];
				sendBtn.frame = CGRectMake(95, 7, 130, 30);
				[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
                [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                if (hemaibool) {
                    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:sendBtn.bounds];
                    buttonLabel1.text = @"参与合买";
                    buttonLabel1.textAlignment = NSTextAlignmentCenter;
                    buttonLabel1.backgroundColor = [UIColor clearColor];
                    buttonLabel1.textColor = [UIColor blackColor];
                    buttonLabel1.font = [UIFont boldSystemFontOfSize:18];
                    
                    [sendBtn addSubview:buttonLabel1];
                    [buttonLabel1 release];
                }else{
					UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:sendBtn.bounds];
                    buttonLabel1.text = @"参与合买";
                    buttonLabel1.textAlignment = NSTextAlignmentCenter;
                    buttonLabel1.backgroundColor = [UIColor clearColor];
                     buttonLabel1.textColor = [UIColor blackColor];
                    buttonLabel1.font = [UIFont boldSystemFontOfSize:18];
                    [sendBtn addSubview:buttonLabel1];
                    [buttonLabel1 release];
                    //[sendBtn setImage:UIImageGetImageFromName(@"gc_tzbtn14.png") forState:UIControlStateNormal];
                }
				
				UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
				[btn2 addTarget:self action:@selector(wanfaInfo) forControlEvents:UIControlEventTouchUpInside];
				btn2.frame = CGRectMake(280, 7, 30, 30);
				[btn2 setImage:UIImageGetImageFromName(@"faxqwenhao.png") forState:UIControlStateNormal];
				[diView addSubview:btn2];
#ifdef isCaiPiaoForIPad
                infoLable.frame = CGRectMake(10 + 35, 4, 130, 20);
                rengouBtn.frame = CGRectMake(120 + 35, 7, 80, 30);
                label11.frame = CGRectMake(180 + 35, 13, 20, 20);
                addbutton.frame = CGRectMake(210 + 35, 7, 45, 30);
                jianbutton.frame = CGRectMake(260 + 35, 7, 45, 30);
                rengouText.frame = CGRectMake(120 + 35, 12, 60, 20);
                zhanghuLable.frame = CGRectMake(10 + 35, 25, 150, 20);
                sendBtn.frame = CGRectMake(105 + 35, 7, 80, 30);
                btn2.frame = CGRectMake(280 + 35, 7, 30, 30);
                
#endif
			}
		}
        else {
            if (hemaiView) {
                [hemaiView removeFromSuperview];
                hemaiView = nil;
                rengouText = nil;
            }
        }
        [myTableView reloadData];
        //再次购买
        if ([myTableView numberOfRowsInSection:0]!= 0 && canBuyAgain) {
            if (isShuZi && !([self.BetDetailInfo.awardNum isEqualToString:@"未截期，暂不公开！"]||[self.BetDetailInfo.awardNum isEqualToString:@"等待开奖"]) && !isDanShi) {
                if (!isJJYH) {
                    if (BuyAgain) {
                        [BuyAgain removeFromSuperview];
                    }
                    myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 44);
                    backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, 0, 320, self.mainView.bounds.size.height -40);
                    BuyAgain = [UIButton buttonWithType:UIButtonTypeCustom];
                    BuyAgain.frame = CGRectMake(0, self.mainView.bounds.size.height - 44, 330, 44);
                    BuyAgain.backgroundColor = [UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1.0];
                    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 7, 130, 30)];
                    [BuyAgain addSubview:backView];
                    backView.userInteractionEnabled = NO;
                    backView.image = [UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
                    [backView release];
                    [BuyAgain addTarget:self action:@selector(chaodan) forControlEvents:UIControlEventTouchUpInside];
                    [self.mainView addSubview:BuyAgain];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:BuyAgain.bounds];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor blackColor];
                    [BuyAgain addSubview:label];
                    label.font = [UIFont systemFontOfSize:18];
                    if (isMine) {
                        label.text = @"再次购买";
                    }
                    else {
                        label.text = @"抄单购买";
                    }
                    [label release];
                }
            }
        }
        tableheadView = nil;
		[self setHeadView];
		[self setFootView];
//        backScrollView.contentSize = CGSizeMake(320, myTableView.contentSize.height +10);
        NSLog(@"1111");
        
        if (!isHorse) {
            if ([self isChaoEnable]&&[myTableView numberOfRowsInSection:0]!=0) {
                if (!canBack) {
#ifndef isCaiPiaoForIPad
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setBounds:CGRectMake(0, 0, 60, 44)];
                    [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
                    //    [btn setImage:UIImageGetImageFromName(@"IZL-960-1.png") forState:UIControlStateHighlighted];
                    [btn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
                    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
                    self.CP_navigation.rightBarButtonItem = barBtnItem;
                    [barBtnItem release];
#else
                    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(goHome) ImageName:@"kf-quxiao2.png"];
#endif
                }
                else {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
                    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
                    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
                    btn.frame = CGRectMake(20, 0, 40, 44);
                    [btn addTarget:self action:@selector(pressChongZhi) forControlEvents:UIControlEventTouchUpInside];
                    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
                    rightItem.enabled = YES;
                    if (!cheDanBool) {
                        [self.CP_navigation setRightBarButtonItem:rightItem];
                    }
                    
                    [rightItem release];
                }
                
            }
        }
	}
    
}

- (void)requestBuyTogetherFinished:(ASIHTTPRequest *)req {
    if ([req responseData]) {
        NSInteger resalut = 0;
#ifdef isYueYuBan
        
        resalut = 0;
        GC_BuyLottery *buyResult = [[GC_BuyLottery alloc]initWithResponseData:[req responseData] newWithRequest:req];
#else
        
        resalut = 1;
        GC_BuyLottery *buyResult = [[GC_BuyLottery alloc]initWithResponseData:[req responseData] newNotYYWithRequest:req];
#endif
        buyResult.lotteryId = self.BetDetailInfo.lotteryId;
        if (buyResult.returnValue == resalut) {
            if (resalut == 0) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"购买成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setFloat:[buyResult.bettingMoney floatValue] forKey:@"cya"];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
                [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
                [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
            }
            
        }
#ifdef isYueYuBan
        else  if(buyResult.returnValue == 6){
            
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
            
            
            
        }
        else if (buyResult.returnValue == 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 105;
            [alert show];
            [alert release];
        }else {
            
            [[caiboAppDelegate getAppDelegate] showMessage:buyResult.betResultInfo];
            
        }
#else
        else{
            [[caiboAppDelegate getAppDelegate] showMessage:buyResult.betResultInfo];
            
        }
#endif
        
        [buyResult release];
    }
}

- (void)XiuGaiLeiXIngJiJiangJin:(ASIHTTPRequest *)request {
    if ([request responseData]) {
        EidteBaoMiJieXie *jiexi = [[EidteBaoMiJieXie alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (jiexi.returnId == 3000) {
            [jiexi release];
            return;
        }
        if ([jiexi.code intValue] == 1) {
            NSString *xuanyan = @"";
                xuanyan = xuanyanText.text;
                if ([xuanyan length] == 0) {
                    xuanyan = placeholderLabel.text;
                }
            self.BetDetailInfo.programDeclaration = xuanyan;
            [self setHeadView];
            self.BetDetailInfo.secretType = [NSString stringWithFormat:@"%d",(int)mySegment.selectIndex];
            [[caiboAppDelegate getAppDelegate] showMessage:jiexi.msg];
        }
        else {
            CP_UIAlertView *aler = [[CP_UIAlertView alloc] initWithTitle:nil message:jiexi.msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [aler show];
            [aler release];
        }
        [jiexi release];
    }
}

- (void)getJiangli:(ASIHTTPRequest *)request {
    JiangLIJieXi *jiexi = [[JiangLIJieXi alloc] initWithResponseData:[request responseData] WithRequest:request];
    if (jiexi.returnId == 3000) {
        [jiexi release];
        return;
    }
    if ([jiexi.code isEqualToString:@"1"]) {
        UIView *v = tableheadView;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        
        v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y, v.frame.size.width, v.frame.size.height - 60);
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
        for (UIView *sv in [v subviews]) {
            if ([sv isKindOfClass:[CPZhanKaiView class]]) {
                if (sv.tag == 0) {
                    [sv removeFromSuperview];
                }
                else {
                    sv.frame = CGRectMake(sv.frame.origin.x, sv.frame.origin.y - 60, sv.frame.size.width, sv.frame.size.height);
                }
                
            }
        }
        [UIView commitAnimations];
        
    }
    [[caiboAppDelegate getAppDelegate] showMessage:jiexi.msg];
    [jiexi release];
}


- (void)requestFailed:(ASIHTTPRequest *)request {
    isLoading = NO;
    requstFaildCount ++;
    if (requstFaildCount > 5) {
        return;
    }
	if (!self.BetDetailInfo) {
        if (isShishi) {
            [self changeShiShi];
        }
		[self getDetailInfo];
	}
}

//跳转其他浏览器
- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == xuanyanText) {
        return;
    }
	//self.mainView.frame = CGRectMake(0, -150, 320, self.mainView.bounds.size.height);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == xuanyanText) {
        if ([xuanyanText.text sizeWithFont:xuanyanText.font].width < 180) {
            xuanyanText.frame = CGRectMake(0, 0, 180, xuanyanText.frame.size.height);
        }
        else {
            xuanyanText.frame = CGRectMake(0, 0, [xuanyanText.text sizeWithFont:xuanyanText.font].width, xuanyanText.frame.size.height);
        }
        UIScrollView *scr = (UIScrollView *)[xuanyanText superview];
        if ([scr isKindOfClass:[UIScrollView class]]) {
            scr.contentSize = CGSizeMake(xuanyanText.bounds.size.width, xuanyanText.bounds.size.height);
        }
        return;
    }
	if ([rengouText.text intValue] <= 0) {
		rengouText.text = @"0";
	}
	else if ([rengouText.text intValue] >[self.BetDetailInfo.subscriptionAmount intValue]){
		rengouText.text = [NSString stringWithFormat:@"%@",self.BetDetailInfo.subscriptionAmount];
	}
	
    //	self.mainView.frame = self.mainView.bounds;
	yingfuLable.text = [NSString stringWithFormat:@"应支付<%@>元",rengouText.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([textField.text length] == 1 && ![string length]) {
        placeholderLabel.hidden = NO;
    }else if ([textField.text length] || [string length]) {
        placeholderLabel.hidden = YES;
    }else{
        placeholderLabel.hidden = NO;
    }
    return YES;
}


#pragma mark -
#pragma marl UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 103) {
        
        
        [self doBack];
    }
    
    else if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            [self getBuyLotteryRequest];
        }
    }
    
    else if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            [[Info getInstance] setCaipaocount:[[Info getInstance] caipaocount]+ 1];
            [self getBuyLotteryRequest];
        }
        
    }
    
    else if (alertView.tag == 109) {
        if (buttonIndex == 1) {
//#ifdef isYueYuBan
            //            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
            //                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
            //                upmpView.chongZhiType = ChongZhiTypeZhiFuBao;
            //                [self.navigationController pushViewController:upmpView animated:YES];
            //                [upmpView release];
            //            }else{
            GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
            [self.navigationController pushViewController:toUp animated:YES];
            [toUp release];
            //            }
//#else
//            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
//            
//            [httpRequest clearDelegatesAndCancel];
//            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//            [httpRequest setRequestMethod:@"POST"];
//            [httpRequest addCommHeaders];
//            [httpRequest setPostBody:postData];
//            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [httpRequest setDelegate:self];
//            [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
//            [httpRequest startAsynchronous];
//            
//#endif
            
        }
    }
}

#pragma mark 增加数字键盘 done按钮

- (void)doneButton:(UIButton *)btn {
    
    
    [rengouText resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    
    // create custom button
    //    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    doneButton.frame = CGRectMake(0, 163, 106, 53);
    //    doneButton.adjustsImageWhenHighlighted = NO;
    //    //    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    //    //    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    //    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    //    doneButton.backgroundColor = [UIColor clearColor];
    //
    //    UILabel * quedingla = [[UILabel alloc] initWithFrame:doneButton.bounds];
    //    quedingla.backgroundColor = [UIColor clearColor];
    //    quedingla.text = @"确定";
    //    quedingla.textAlignment = NSTextAlignmentCenter;
    //    quedingla.textColor = [UIColor blackColor];
    //    quedingla.font = [UIFont systemFontOfSize:15];
    //    [doneButton addSubview:quedingla];
    //    [quedingla release];
    
    
    // locate keyboard view
    //    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    //    UIView* keyboard;
    //    for(int i=0; i<[tempWindow.subviews count]; i++) {
    //        keyboard = [tempWindow.subviews objectAtIndex:i];
    //        // keyboard view found; add the custom button to it
    //        //if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)// OS 3.0
    //        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||(([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)))
    //            [keyboard addSubview:doneButton];
    //        return;
    //    }
    
    
}

#pragma mark CPZhankaiViewDelegte

- (void)ZhankaiViewClicke:(CPZhanKaiView *)_zhankaiView {
    if (_zhankaiView.isOpen) {
        [self resetHeadViewHeightWithHight:_zhankaiView.zhankaiHeight - _zhankaiView.normalHeight clickeView:_zhankaiView];
    }
    else {
        [self resetHeadViewHeightWithHight: _zhankaiView.normalHeight - _zhankaiView.zhankaiHeight clickeView:_zhankaiView];
    }
    backScrollView.contentSize = CGSizeMake(320, myTableView.contentSize.height +10);
}

#pragma mark _ 录音委托


//-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
//{
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSMutableString *path = [pathArray objectAtIndex:0];
//    NSString *detailPath = [path stringByAppendingPathComponent:@"reverseme.pcm"];
//    if ( [[NSFileManager defaultManager] fileExistsAtPath:detailPath]) {
//        if (recorderTime <= 1) {
//            recorderTime = 0;
//            [[caiboAppDelegate getAppDelegate] showMessage:@"时间太短"];
//            return;
//        }
//        recoderBtn.buttonName.text = [NSString stringWithFormat:@"%d\"   ",recorderTime - 1];
//        recoderBtn.buttonName.textAlignment = NSTextAlignmentRight;
//        recoderBtn.otherImage.hidden = NO;
//        VoiceIsChange = YES;
//        deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaidelete.png");
//        GoovoiceType = hasyuyin;
//    }
//    else {
//    }
//    
//    
//}

//- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    if (flag) {
//        [infoPlayer release];
//        infoPlayer = nil;
//    }
//}

#pragma mark _ 赞代理
- (void)returnVoicePlayerZanCount:(NSInteger)zancount selectRow:(NSInteger)row {
    self.BetDetailInfo.zanNum = [NSString stringWithFormat:@"%d",(int)zancount];
    self.BetDetailInfo.isZan = @"1";
}

- (void)hidenJianPan {
    zhedanView.hidden = YES;
    con.enabled = NO;
    footZhankaiV.isOpen = YES;
    [footZhankaiV openByTouch];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    hemaiView.frame = CGRectMake(0, self.mainView.bounds.size.height -88, hemaiView.frame.size.width, 88);
    sendBtn.superview.frame = CGRectMake(0, hemaiView.frame.size.height - 44, sendBtn.superview.frame.size.width, 44);
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

- (void)jianPanClicke:(UIButton *)sender {
    if (sender.tag == 11) {
        [self hidenJianPan];
    
    }
    else if (sender.tag == 10) {
        rengouText.text = [NSString stringWithFormat:@"%d",[rengouText.text intValue]/10];
    }
    else {
        if ([rengouText.textColor isEqual:[UIColor grayColor]]) {
            rengouText.text = [NSString stringWithFormat:@"%ld", (long)sender.tag];
        }
        else {
            rengouText.text = [NSString stringWithFormat:@"%d",[rengouText.text intValue] * 10 + (int)sender.tag];
        }
        
    }
    rengouText.textColor = [UIColor blackColor];
    [self textFieldDidEndEditing:rengouText];
}

- (void)rengouSelcte {
    con.enabled = YES;
    if (!zhedanView) {
        
        zhedanView = [[UIView alloc] initWithFrame:CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height)];
        [self.mainView insertSubview:zhedanView belowSubview:con];
        [self.view bringSubviewToFront:self.mainView];
        zhedanView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [zhedanView release];
    }
    zhedanView.hidden = NO;
    footZhankaiV.isOpen = NO;
    [footZhankaiV openByTouch];
    if (footZhankaiV.isOpen) {
        rengouText.text=0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        hemaiView.frame = CGRectMake(0, self.mainView.frame.size.height - 198, hemaiView.frame.size.width, 198);
        sendBtn.superview.frame = CGRectMake(0, hemaiView.frame.size.height - 44, sendBtn.superview.frame.size.width, 44);
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView commitAnimations];
    }
    else {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        hemaiView.frame = CGRectMake(0, self.mainView.frame.size.height - 88, hemaiView.frame.size.width, 88);
        sendBtn.superview.frame = CGRectMake(0, hemaiView.frame.size.height - 44, sendBtn.superview.frame.size.width, 44);
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            NSMutableData *postData  = [[GC_HttpService sharedInstance] ChedanByFananID:self.BetDetailInfo.programNumber];
            [httpRequest clearDelegatesAndCancel];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [httpRequest setRequestMethod:@"POST"];
            [httpRequest addCommHeaders];
            [httpRequest setPostBody:postData];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest setDidFinishSelector:@selector(reChedanFinished:)];
            [httpRequest startAsynchronous];
        }
    }
    if(alertView.tag == 1234)
    {
        if(buttonIndex == 1)
        {
            [self send];
        }
    }
    if (alertView.tag == 199) {
        if (buttonIndex == 1) {
            NSLog(@"hhhhhhhhhhhh = %@", self.orderId);
            NSMutableData *postData = [[GC_HttpService sharedInstance] chedanWithID:self.orderId type:1];
            SEL Finish = @selector(cheDanFinsh:);
            [httpRequest clearDelegatesAndCancel];
            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [httpRequest setRequestMethod:@"POST"];
            [httpRequest addCommHeaders];
            [httpRequest setPostBody:postData];
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest setDidFinishSelector:Finish];
            [httpRequest startAsynchronous];
            
            
        }
    }
    if (alertView.tag == 1999) {
        [self.navigationController popViewControllerAnimated:YES];
        if (typeAnswer == 1) {
            if (delegate && [delegate respondsToSelector:@selector(returnTypeAnswer:)]) {
                [delegate returnTypeAnswer:typeAnswer];
            }
        }
        
    }
//    if (alertView.tag == 303) {
//        if (buttonIndex == 1) {
//            recoderBtn.otherImage.hidden = YES;
//            recoderBtn.buttonName.text = @"按住录音";
//            recoderBtn.buttonName.textAlignment = NSTextAlignmentCenter;
//            GoovoiceType = yuyinwithnone;
//            [infoPlayer release];
//            infoPlayer = nil;
//            deleteBtn.otherImage.image = UIImageGetImageFromName(@"hemaibi.png");
//            //            [self deleteVoice];
//        }
//    }
}

- (void)cheDanFinsh:(ASIHTTPRequest *)request{
    
    if ([request responseData]) {
		CheDanData *br = [[CheDanData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (br.sysid == 3000) {
            [br release];
            return;
        }
        typeAnswer = br.chedan;
        if (br.chedan == 1) {//成功
            cheDanBool = YES;
            
            UIButton * but =  (UIButton *)self.CP_navigation.rightBarButtonItem;
            but.enabled = NO;
            
            CP_UIAlertView *alet = [[CP_UIAlertView alloc] initWithTitle:nil message:@"撤单成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alet.tag = 1999;
            [alet show];
            [alet release];
            if (isShishi) {
                [self changeShiShi];
            }
            [self getDetailInfo];
            
        }else{
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:br.msgchedan delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.delegate = self;
            [alert show];
            [alert release];
        }
        
        [br release];
    }
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
		if (!isLoading){
            [self getDetailInfo];
		}
		
		
	}
	
	[refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

// 在这边 发送  刷新 请求

- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
	
	
	[refreshHeaderView setState:CBPullRefreshLoading];
    
	myTableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
	
	[self getDetailInfo];
	
	// 模拟 延迟 三秒  完成接收
	
	
	
}

- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view {
    return isLoading;
}


-(void)doneLoadedTableViewData{
	
	isLoading = NO;
	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
	
	
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
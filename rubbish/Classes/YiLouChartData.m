//
//  YiLouChartData.m
//  CPgaopin
//
//  Created by GongHe on 14-2-13.
//
//

#import "YiLouChartData.h"
#import "SharedMethod.h"

@implementation YiLouChartData
//@synthesize k3YiLouArray;
@synthesize lotteryNumArr;
@synthesize issueNumber;
@synthesize andValues;
@synthesize sameNumber;
@synthesize andValuesArr;
@synthesize lotteryNumber;
@synthesize daXiaoArray;
@synthesize jiOuArray;
@synthesize zhiHeArray;
@synthesize n115YiLouArray;
@synthesize qianLotteryNumber;
@synthesize qianLotteryNumArr;
@synthesize n115QianOneArr;
@synthesize n115QianTwoArr;
@synthesize n115QianThreeArr;
@synthesize dataArray;
@synthesize redSame;
@synthesize redYiLou;
@synthesize blueSame;
@synthesize blueYiLou;
@synthesize k3ErBuTongArr;
@synthesize k3ErTongArr;
@synthesize k3SanLianArr;
@synthesize k3SanTongArr;
@synthesize k3SanBuTongArr;
@synthesize threeDThreeArr;
@synthesize threeDTwoArr;
@synthesize threeDOneArr;
@synthesize threeDBasicArr;
@synthesize threeDTypeArr;
@synthesize threeDDaXiaoJiOuArray;
@synthesize happyYiLouArray;

- (void)dealloc
{
//    [k3YiLouArray release];
    [lotteryNumArr release];
    [andValuesArr release];
    [k3ErBuTongArr release];
    [k3ErTongArr release];
    [k3SanLianArr release];
    [k3SanTongArr release];
    
    [n115YiLouArray release];
    [daXiaoArray release];
    [jiOuArray release];
    [zhiHeArray release];
    [qianLotteryNumArr release];
    [n115QianOneArr release];
    [n115QianTwoArr release];
    [n115QianThreeArr release];
    
    [threeDOneArr release];
    [threeDTwoArr release];
    [threeDThreeArr release];
    
    [happyYiLouArray release];
    [super dealloc];
}

-(id)initWith3DDictionary:(NSDictionary *)dictionary
{
//    sortSameCount = 0;
    
    self = [super init];
    if (self) {
        NSArray * lotteryArray = [[dictionary valueForKey:@"result"] componentsSeparatedByString:@","];
        //    [lotteryArray sortedArrayUsingFunction:numSortType context:nil];
        
        NSDictionary * sortedDic = [SharedMethod getSortedArrayInfoByArray:lotteryArray];
        NSDictionary * dwtDic = [dictionary objectForKey:@"dwt"];
        
        NSArray * wordArr = @[@"一",@"二",@"三"];
        for (int i = 0; i < wordArr.count; i++) {
            NSMutableArray * yiLouArray = [[NSMutableArray alloc] initWithCapacity:10];
            
            NSDictionary * typeDic = [dwtDic objectForKey:[wordArr objectAtIndex:i]];
            
            for (int j = 0; j < [typeDic count]; j++) {
                NSDictionary * dic = [typeDic valueForKey:[NSString stringWithFormat:@"%d",j]];
                [yiLouArray addObject:[dic valueForKey:@"yl"]];
            }
            if (i == 0) {
                self.threeDOneArr = yiLouArray;
            }
            else if (i == 1) {
                self.threeDTwoArr = yiLouArray;
            }
            else{
                self.threeDThreeArr = yiLouArray;
            }
            [yiLouArray release];
        }
        
        NSMutableArray * yiLouArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        NSDictionary * rtDic = [dictionary objectForKey:@"rt"];
        NSString * sameNum = @"";
        
        for (int j = 0; j < [rtDic count]; j++) {
            NSDictionary * dic = [rtDic valueForKey:[NSString stringWithFormat:@"%d",j]];
            [yiLouArray addObject:[dic valueForKey:@"yl"]];
            
            if (sameNum.length) {
                sameNum = [sameNum stringByAppendingString:@"|"];
            }
            if ([[dic valueForKey:@"yl"] integerValue] == 0) {
                sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",j + 1]];
                sameNum = [sameNum stringByAppendingString:@"#"];
                if (j == [[sortedDic valueForKey:@"sameNumber"] integerValue]) {
                    sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",[[sortedDic valueForKey:@"sameCount"] intValue] + 1]];
                }else{
                    sameNum = [sameNum stringByAppendingString:[sortedDic valueForKey:@"sameCount"]];
                }
            }else{
                sameNum = [sameNum stringByAppendingString:@" "];
            }
        }
        
        self.sameNumber = sameNum;
        self.threeDBasicArr = yiLouArray;
        
        
        self.issueNumber = [SharedMethod getLastThreeStr:[dictionary objectForKey:@"periodNumber"]];
        
        NSMutableArray * lotteryNumberArray = [[[NSMutableArray alloc] init] autorelease];
        NSString * lotteryString = @"";
        for (int i = 0; i < lotteryArray.count; i++) {
            [lotteryNumberArray addObject:[NSString stringWithFormat:@"%d",[[lotteryArray objectAtIndex:i] intValue]]];
            lotteryString = [lotteryString stringByAppendingString:[lotteryNumberArray lastObject]];
            if (i != lotteryArray.count - 1) {
                lotteryString = [lotteryString stringByAppendingString:@"."];
            }
        }
        self.lotteryNumArr = lotteryNumberArray;
        self.lotteryNumber = lotteryString;
        
        NSMutableArray * chongArray = [[NSMutableArray alloc] initWithCapacity:10];
        if ([dictionary objectForKey:@"formyl"]) {
            for (NSString * str in [dictionary objectForKey:@"formyl"]) {
                [chongArray addObject:str];
            }
        }else{
            [chongArray addObject:@""];
            [chongArray addObject:@""];
            [chongArray addObject:@""];
        }
        if ([dictionary objectForKey:@"hzh"]) {
            [chongArray addObject:[dictionary objectForKey:@"hzh"]];
        }else{
            [chongArray addObject:@""];
        }
        if ([dictionary objectForKey:@"kd"]) {
            [chongArray addObject:[dictionary objectForKey:@"kd"]];
        }else{
            [chongArray addObject:@""];
        }
        self.threeDTypeArr = chongArray;
        [chongArray release];
        
        NSMutableArray * dxjoArray = [[NSMutableArray alloc] initWithCapacity:10];
        if ([dictionary objectForKey:@"dxbyl"]) {
            for (NSString * str in [dictionary objectForKey:@"dxbyl"]) {
                [dxjoArray addObject:str];
            }
        }else{
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
        }
        if ([dictionary objectForKey:@"jobyl"]) {
            for (NSString * str in [dictionary objectForKey:@"jobyl"]) {
                [dxjoArray addObject:str];
            }
        }else{
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
            [dxjoArray addObject:@""];
        }
        self.threeDDaXiaoJiOuArray = dxjoArray;
        
        [dxjoArray release];
    }
    
    
    return self;
}

- (id)initWithHappyDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableArray * array = [NSMutableArray array];
        NSDictionary * dic = [dictionary objectForKey:@"rt"];
        for (int i = 0; i < dic.count; i++) {
            if (i + 1 < 10) {
                [array addObject:[[dic valueForKey:[NSString stringWithFormat:@"0%d",i + 1]] valueForKey:@"yl"]];
            }else{
                [array addObject:[[dic valueForKey:[NSString stringWithFormat:@"%d",i + 1]] valueForKey:@"yl"]];
            }
        }
        self.happyYiLouArray = array;
        self.issueNumber = [SharedMethod getLastThreeStr:[dictionary objectForKey:@"periodNumber"]];
        self.lotteryNumArr = [[dictionary objectForKey:@"result"] componentsSeparatedByString:@","];
    }
    return self;
}

- (id)initWithN115Dictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableArray * array = [NSMutableArray array];
        NSDictionary * dic = [dictionary objectForKey:@"rt"];

        for (int i = 0; i < dic.count; i++) {
            if (i + 1 < 10) {
                [array addObject:[[dic valueForKey:[NSString stringWithFormat:@"0%d",i + 1]] valueForKey:@"yl"]];
            }else{
                [array addObject:[[dic valueForKey:[NSString stringWithFormat:@"%d",i + 1]] valueForKey:@"yl"]];
            }
        }
        self.n115YiLouArray = array;

        NSArray * biZhiNameArray = @[@"dxbyl",@"jobyl",@"zhhbyl"];
        NSArray * biZhiNumArray = @[@"0:5",@"1:4",@"2:3",@"3:2",@"4:1",@"5:0"];
        
        NSString * ylStr = @"";
        NSMutableArray * daXiaoArr = [NSMutableArray array];
        NSMutableArray * jiOuArr = [NSMutableArray array];
        NSMutableArray * zhiHeArr = [NSMutableArray array];

        for (int i = 0; i < biZhiNameArray.count; i++) {
            for (int j = 0; j < biZhiNumArray.count; j++) {
                ylStr = [[[[dictionary valueForKey:[biZhiNameArray objectAtIndex:i]] valueForKey:[biZhiNumArray objectAtIndex:j]] valueForKey:@"yl"] description];
                if (i == 0) {
                    [daXiaoArr addObject:ylStr];
                }else if (i == 1) {
                    [jiOuArr addObject:ylStr];
                }else if (i == 2) {
                    [zhiHeArr addObject:ylStr];
                }
            }
        }
        
        self.daXiaoArray = daXiaoArr;
        self.jiOuArray = jiOuArr;
        self.zhiHeArray = zhiHeArr;
        
        NSDictionary * qianDic = [dictionary objectForKey:@"qst"];
        NSArray * keyArray = @[@"一",@"二",@"三"];
        
        NSMutableArray * qianAllArr = [NSMutableArray array];
        
        for (int i = 0; i < keyArray.count; i++) {
            NSMutableArray * qianArray = [NSMutableArray array];
            for (int j = 0; j < [[qianDic valueForKey:[keyArray objectAtIndex:i]] count]; j++) {
                if (j + 1 < 10) {
                    [qianArray addObject:[[[qianDic valueForKey:[keyArray objectAtIndex:i]] valueForKey:[NSString stringWithFormat:@"0%d",j + 1]] valueForKey:@"yl"]];
                }else{
                    [qianArray addObject:[[[qianDic valueForKey:[keyArray objectAtIndex:i]] valueForKey:[NSString stringWithFormat:@"%d",j + 1]] valueForKey:@"yl"]];
                }
            }
            [qianAllArr addObject:qianArray];
        }
        
        self.n115QianOneArr = [qianAllArr objectAtIndex:0];
        self.n115QianTwoArr = [qianAllArr objectAtIndex:1];
        self.n115QianThreeArr = [qianAllArr objectAtIndex:2];
        
        self.issueNumber = [SharedMethod getLastTwoStr:[dictionary valueForKey:@"periodNumber"]];
        self.lotteryNumArr = [[dictionary valueForKey:@"result"] componentsSeparatedByString:@","];
        
    }
    return self;
}

- (id)initWithKuaiSanDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.issueNumber = [SharedMethod getLastTwoStr:[dictionary objectForKey:@"periodNumber"]];
        self.lotteryNumArr = [[dictionary valueForKey:@"result"] componentsSeparatedByString:@","];
        self.andValues = [dictionary valueForKey:@"hzh"];
        
        NSMutableArray * heZhiArray = [NSMutableArray array];
        NSDictionary * heZhiDic = [dictionary objectForKey:@"hzhyl"];
        for (int i = 3; i < heZhiDic.count + 3; i++) {
            [heZhiArray addObject:[[heZhiDic valueForKey:[NSString stringWithFormat:@"%d",i]] valueForKey:@"yl"]];
        }
        self.andValuesArr = heZhiArray;
        
        NSDictionary * sanTongDic = [dictionary objectForKey:@"forma"];
        NSArray * sanTongKeyArray = @[@"st",@"sb",@"et",@"eb"];
        NSMutableArray * sanTongArray = [NSMutableArray array];
        for (int i = 0; i < sanTongKeyArray.count; i++) {
            [sanTongArray addObject:[[sanTongDic valueForKey:[sanTongKeyArray objectAtIndex:i]] valueForKey:@"yl"]];
        }
        self.k3SanTongArr = sanTongArray;

        NSDictionary * erTongDic = [dictionary objectForKey:@"etfsyl"];
        NSMutableArray * erTongArray = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            [erTongArray addObject:[[erTongDic valueForKey:[NSString stringWithFormat:@"%d%d",i+1,i+1]] valueForKey:@"yl"]];
        }
        self.k3ErTongArr = erTongArray;

        NSDictionary * sanLianDic = [dictionary objectForKey:@"sbyl"];
        NSArray * sanLianKeyArray = @[@"123",@"234",@"345",@"456"];
        NSMutableArray * sanLianArray = [NSMutableArray array];
        for (int i = 0; i < sanLianKeyArray.count; i++) {
            [sanLianArray addObject:[[sanLianDic valueForKey:[sanLianKeyArray objectAtIndex:i]] valueForKey:@"yl"]];
        }
        self.k3SanLianArr = sanLianArray;

        
        NSDictionary * sanBuDic = [dictionary objectForKey:@"rt"];
        NSMutableArray * sanBuArray = [NSMutableArray array];
        for (int i = 0; i < sanBuDic.count; i++) {
            [sanBuArray addObject:[[sanBuDic valueForKey:[NSString stringWithFormat:@"%d",i + 1]] valueForKey:@"yl"]];
        }
        self.k3SanBuTongArr = sanBuArray;
        
        NSDictionary * sortedDic = [SharedMethod getSortedArrayInfoByArray:lotteryNumArr];
        NSMutableArray * yiLouArray = [NSMutableArray array];
        NSDictionary * rtDic = [dictionary objectForKey:@"rt"];
        NSString * sameNum = @"";
        for (int j = 0; j < [rtDic count]; j++) {
            NSDictionary * dic = [rtDic valueForKey:[NSString stringWithFormat:@"%d",j + 1]];
            [yiLouArray addObject:[dic valueForKey:@"yl"]];
            
            if (sameNum.length) {
                sameNum = [sameNum stringByAppendingString:@"|"];
            }
            if ([[dic valueForKey:@"yl"] integerValue] == 0) {
                sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",j + 1]];
                sameNum = [sameNum stringByAppendingString:@"#"];
                if (j + 1 == [[sortedDic valueForKey:@"sameNumber"] integerValue]) {
                    sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",[[sortedDic valueForKey:@"sameCount"] intValue] + 1]];
                }else{
                    sameNum = [sameNum stringByAppendingString:[sortedDic valueForKey:@"sameCount"]];
                }
            }else{
                sameNum = [sameNum stringByAppendingString:@" "];
            }
        }
        self.sameNumber = sameNum;

        NSDictionary * erBuDic = [dictionary objectForKey:@"ebyl"];
        NSArray * erBuKeyArray = @[@"12",@"13",@"14",@"15",@"16",@"23",@"24",@"25",@"26",@"34",@"35",@"36",@"45",@"46",@"56"];
        NSMutableArray * erBuArray = [NSMutableArray array];
        for (int i = 0; i < erBuKeyArray.count; i++) {
            [erBuArray addObject:[[erBuDic valueForKey:[erBuKeyArray objectAtIndex:i]] valueForKey:@"yl"]];
        }
        self.k3ErBuTongArr = erBuArray;

    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSArray * lotteryArray = [[dictionary objectForKey:@"bonusNumber"] componentsSeparatedByString:@","];
        NSMutableArray * lotteryNumberArray = [[[NSMutableArray alloc] init] autorelease];
        NSString * lotteryString = @"";
        for (int i = 0; i < lotteryArray.count; i++) {
            [lotteryNumberArray addObject:[NSString stringWithFormat:@"%d",[[lotteryArray objectAtIndex:i] intValue]]];
            lotteryString = [lotteryString stringByAppendingString:[lotteryNumberArray lastObject]];
            if (i == 2) {
                self.qianLotteryNumber = lotteryString;
                self.qianLotteryNumArr = lotteryNumberArray;
            }
            if (i != lotteryArray.count - 1) {
                lotteryString = [lotteryString stringByAppendingString:@"."];
            }
        }
        self.lotteryNumArr = lotteryNumberArray;
        self.lotteryNumber = lotteryString;
        self.issueNumber = [SharedMethod getLastTwoStr:[dictionary objectForKey:@"issue"]];
//        self.andValues = [NSString stringWithFormat:@"%d", [[dictionary objectForKey:@"andValues"] intValue]];
//        self.sameNumber = [dictionary objectForKey:@"sameNumber"];

        if ([[dictionary objectForKey:@"rt"] count]) {
            NSArray * wordArr = @[@"rt",@"lt"];
            for (int i = 0; i < wordArr.count; i++) {
                NSMutableArray * yiLouArray = [[NSMutableArray alloc] initWithCapacity:10];
                NSString * sameNum = @"";
                
                NSDictionary * typeDic = [dictionary objectForKey:[wordArr objectAtIndex:i]];
                NSDictionary * dic;
                for (int j = 0; j < [typeDic count]; j++) {
                    if (j < 9) {
                        dic = [typeDic valueForKey:[NSString stringWithFormat:@"0%d",j + 1]];
                    }else{
                        dic = [typeDic valueForKey:[NSString stringWithFormat:@"%d",j + 1]];
                    }
                    
                    [yiLouArray addObject:[dic valueForKey:@"yl"]];
                    if (sameNum.length) {
                        sameNum = [sameNum stringByAppendingString:@"|"];
                    }
                    if ([[dic valueForKey:@"yl"] integerValue] == 0) {
                        sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",j + 1]];
                        sameNum = [sameNum stringByAppendingString:@"#"];
                        sameNum = [sameNum stringByAppendingString:[NSString stringWithFormat:@"%d",[[dic valueForKey:@"n"] intValue] + 1]];
                    }else{
                        sameNum = [sameNum stringByAppendingString:@" "];
                    }
                }
                if (i == 0) {
                    self.redSame = sameNum;
                    self.redYiLou = yiLouArray;
                }else{
                    self.blueSame = sameNum;
                    self.blueYiLou = yiLouArray;
                }
                [yiLouArray release];
            }
        }
        
        NSMutableArray * dataSSQArr = [[NSMutableArray alloc] initWithCapacity:0];
        if ([dictionary objectForKey:@"hzh"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"hzh"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        if ([dictionary objectForKey:@"wh"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"wh"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        if ([dictionary objectForKey:@"dxb"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"dxb"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        if ([dictionary objectForKey:@"job"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"job"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        if ([dictionary objectForKey:@"lqhzh"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"lqhzh"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        if ([dictionary objectForKey:@"lqwh"]) {
            [dataSSQArr addObject:[dictionary objectForKey:@"lqwh"]];
        }else{
            [dataSSQArr addObject:@""];
        }
        self.dataArray = dataSSQArr;
        [dataSSQArr release];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
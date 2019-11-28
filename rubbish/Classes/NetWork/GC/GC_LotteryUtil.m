//
//  LotteryUtil.m
//  Lottery
//
//  Created by Kiefer on 11-12-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_LotteryUtil.h"
#import "StringUtil.h"
#import "GC_JCalgorithm.h"

@implementation GC_LotteryUtil

/**
 * 阶乘，n限于正整数
 * 
 * @param n
 * @return
 */
+ (NSInteger)factorial:(NSInteger)n 
{
    int total = 1;
    for (int i = 1; i <= n; i++) {
        total = total * i;
    }
    return total;
}

/**
 * 计算start到stop阶乘 正整数
 * 
 * @param start
 * @param stop
 * @return
 */
+ (long long)factorial:(long long)start :(long long)stop 
{
    long long total = 1;
    for (long long i = start; i <= stop; i++) {
        total = total * i;
    }
    return total;
}

/**
 * 排列
 * 
 * @param m
 * @param n
 * @return
 */
+ (NSInteger)permutation:(NSInteger)m :(NSInteger)n
{
    if (m < n) {
        return 0;
    } else {
        return [GC_LotteryUtil factorial:m] / [GC_LotteryUtil factorial:(m - n)];
    }
}

/**
 * 组合 从m中选出n个
 * 
 * @param m
 * @param n
 * @return
 */
+ (long long)combination:(long long)m :(long long)n 
{
    if (m < n) {
        return 0;
    } else {
        return [GC_LotteryUtil factorial:(m - n + 1) :m] / [GC_LotteryUtil factorial:1 :n];
    }
}

/**
 * 3D直选胆拖的注数计算
 * 
 * @param dan
 *            胆码个数
 * @param tuo
 *            拖码个数
 * @return
 */
+ (NSInteger)get3DDantuo:(NSInteger)dan :(NSInteger)tuo
{
//    if (dan < 1 || dan > 2 || tuo < 1 || dan + tuo < 3)
//        return 0;
//    NSInteger invest = [GC_LotteryUtil combination:tuo :3 - dan] * 6;
//    return invest;
    
    if (dan != 1 || tuo < 1)
        return 0;
    NSInteger invest = [GC_LotteryUtil combination:tuo :1] * 2;
    return invest;
}

/**
 * 排列3组选单式的注数计算
 * 
 * @param n
 *            选球个数
 * @return
 */
+ (int)getZuxuanDanshi:(int)n 
{
    if (n == 5)
        return 1;
    else
        return 0;
}

+ (int)get3DZuLiuHezhi:(int)n
{
    if (n == 3)
        return 1;
    else if (n == 4)
        return 1;
    else if (n == 5)
        return 2;
    else if (n == 6)
        return 3;
    else if (n == 7)
        return 4;
    else if (n == 8)
        return 5;
    else if (n == 9)
        return 7;
    else if (n == 10)
        return 8;
    else if (n == 11)
        return 9;
    else if (n == 12)
        return 10;
    else if (n == 13)
        return 10;
    else if (n == 14)
        return 10;
    else if (n == 15)
        return 10;
    else if (n == 16)
        return 9;
    else if (n == 17)
        return 8;
    else if (n == 18)
        return 7;
    else if (n == 19)
        return 5;
    else if (n == 20)
        return 4;
    else if (n == 21)
        return 3;
    else if (n == 22)
        return 2;
    else if (n == 23)
        return 1;
    else if (n == 24)
        return 1;
    return 0;
}

+ (int)get3DZuSanHezhi:(int)n
{
    if (n == 1)
        return 1;
    else if (n == 2)
        return 2;
    else if (n == 3)
        return 1;
    else if (n == 4)
        return 3;
    else if (n == 5)
        return 3;
    else if (n == 6)
        return 3;
    else if (n == 7)
        return 4;
    else if (n == 8)
        return 5;
    else if (n == 9)
        return 4;
    else if (n == 10)
        return 5;
    else if (n == 11)
        return 5;
    else if (n == 12)
        return 4;
    else if (n == 13)
        return 5;
    else if (n == 14)
        return 5;
    else if (n == 15)
        return 4;
    else if (n == 16)
        return 5;
    else if (n == 17)
        return 5;
    else if (n == 18)
        return 4;
    else if (n == 19)
        return 5;
    else if (n == 20)
        return 4;
    else if (n == 21)
        return 3;
    else if (n == 22)
        return 3;
    else if (n == 23)
        return 3;
    else if (n == 24)
        return 1;
    else if (n == 25)
        return 2;
    else if (n == 26)
        return 1;
    return 0;
}

+ (int)get3Dhezhi:(int)n {
    if (n == 0)
        return 1;
    else if (n == 1)
        return 3;
    else if (n == 2)
        return 6;
    else if (n == 3)
        return 10;
    else if (n == 4)
        return 15;
    else if (n == 5)
        return 21;
    else if (n == 6)
        return 28;
    else if (n == 7)
        return 36;
    else if (n == 8)
        return 45;
    else if (n == 9)
        return 55;
    else if (n == 10)
        return 63;
    else if (n == 11)
        return 69;
    else if (n == 12)
        return 73;
    else if (n == 13)
        return 75;
    else if (n == 14)
        return 75;
    else if (n == 15)
        return 73;
    else if (n == 16)
        return 69;
    else if (n == 17)
        return 63;
    else if (n == 18)
        return 55;
    else if (n == 19)
        return 45;
    else if (n == 20)
        return 36;
    else if (n == 21)
        return 28;
    else if (n == 22)
        return 21;
    else if (n == 23)
        return 15;
    else if (n == 24)
        return 10;
    else if (n == 25)
        return 6;
    else if (n == 26)
        return 3;
    else if (n == 27) return 1;//黑龙江要求去掉
    return 0;
}


/**
 * 排列3直选组合胆拖的注数计算
 * 
 * @param dan
 *            胆码个数
 * @param tuo
 *            拖码个数
 * @return
 */
+ (NSInteger)getZhixuanZuheDantuo:(NSInteger)dan :(NSInteger)tuo
{
    if (dan < 1 || dan > 2 || tuo < 1 || dan + tuo < 4)
        return 0;
    NSInteger invest = [GC_LotteryUtil combination:tuo :(3 - dan)] * 6;
    return invest;
}

/**
 * 排列3组选：组三胆拖的注数计算
 * 
 * @param dan
 *            胆码个数
 * @param tuo
 *            拖码个数
 * @return
 */
+ (NSInteger)getZuxuanZu3Dantuo:(NSInteger)dan :(NSInteger)tuo
{
    if (dan != 1 || tuo < 1)
        return 0;
    NSInteger invest = [GC_LotteryUtil combination:tuo :1] * 2;
    return invest;
}

/**
 * 排列3组选：组六胆拖的注数计算
 * 
 * @param dan
 *            胆码个数
 * @param tuo
 *            拖码个数
 * @return
 */
+ (NSInteger)getZuxuanZu6Dantuo:(NSInteger)dan :(NSInteger)tuo
{
    if (dan < 1 || dan > 2 || tuo == 0 || dan + tuo < 2)
        return 0;
    NSInteger invest = [GC_LotteryUtil combination:tuo :(2 - dan)] * 2;
    return invest;
}

// 得到复式金额 m:red n:blue
+ (NSInteger)getfushiMoney:(NSInteger)m :(NSInteger)n 
{ 
    int s1 = 1;
    int s2 = 1;
    int s3 = (int)[GC_LotteryUtil factorial:6];
    int money;
    
    for (int i = 1; i < m + 1; i++) {
        s1 = s1 * i;
    }
    for (int j = 1; j < m - 5; j++) {
        s2 = s2 * j;
    }
    money = s1 / (s2 * s3) * (int)n * 2;
    return money;
}

/**
 * 计算任选2～任选7复式的注数，start=base；前二前三直选的复式，start=2
 * 
 * @param n
 * @param base
 * @return
 */
+(int)getTotal1:(int)n :(int)base : (int)start
{
    double total = 0;
    if (n >= base) {
        total = 1;
        for (int i = start; i <= n; i++)
            total *= i;
        for (int i = 2; i <= (n - base); i++)
            total = total / i;
    }
    return total;
}


/**
 * 计算2个集合里重复球的个数
 * 
 * @param v0
 * @param v1
 * @return
 */
+(int)count2:(NSArray *)v0 :(NSArray *)v1
{
    if (nil == v0 || nil == v1) {
        return 0;
    }
    int n0 = (int)[v0 count], n1 = (int)[v1 count];
    NSArray *tmp0 = v0;
    NSArray *tmp1 = v1;
    if (n0 > n1) {
        tmp0 = v1;
        tmp1 = v0;
    }
    int repeat = 0; // 2个集合里重复球的个数
    for (int i = 0; i < [tmp0 count]; i++) {
        NSObject *obj = [tmp0 objectAtIndex:i];
        if ([tmp1 containsObject:obj]) {
            repeat++;
        }
    }
    return repeat;
}

/**
 * 计算3个集合里重复球的个数
 * 
 * @param v0
 * @param v1
 * @param v2
 * @return
 */
+ (int)count3:(NSArray *)v0 :(NSArray *)v1 :(NSArray *)v2
{
    if (nil == v0 || nil == v1 || nil == v2) {
        return 0;
    }
    int repeat = 0; // 计算3个集合里重复球的个数
    NSString *s1 = @"";
    NSString *s2 = @"";
    NSString *s3 = @"";
    for (int i = 0; i < [v0 count]; i++) {
        s1 = [v0 objectAtIndex:i];
        if ([s1 isEqualToString:@""])
            s1 = @"*";
        for (int j = 0; j < [v1 count]; j++) {
            s2 = [v1 objectAtIndex:j];
            if ([s2 isEqualToString:@""])
                s2 = @"$";
            for (int k = 0; k < [v2 count]; k++) {
                s3 = [v2 objectAtIndex:k];
                if ([s3 isEqualToString:@""])
                {s3 = @"&";}
                if ([s1 isEqualToString:s2]||[s2 isEqualToString:s3]||[s1 isEqualToString:s3]) {
                    repeat++;
                }
            }
        }
    }
    return repeat;
}

/**
 * 计算胆拖的注数
 * 
 * @param dan
 * @param tuo
 * @param base
 * @return
 */
+ (int)getDantuo:(int)dan :(int)tuo :(int)base
{
    return (int)[self combination:tuo :(base - dan)];
}

+ (int)getPK10FushiBets:(NSString*)betnumber LotteryType:(LotteryTYPE)lotteryType
{
    int bets = 0;
    NSMutableArray *v = [betnumber SplitStringByChar:@"|"];
    if (![v containsObject:@"e"]) {
        if (lotteryType == TYPE_PK10_PUTONGXUAN1) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                bets += 1;
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN2 || lotteryType == TYPE_PK10_JINGQUEXUAN2) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    bets += 1;
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN3 || lotteryType == TYPE_PK10_JINGQUEXUAN3) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        bets += 1;
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN4 || lotteryType == TYPE_PK10_JINGQUEXUAN4) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            bets += 1;
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN5) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                bets += 1;
                            }
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN6) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                NSMutableArray *v5 = [[v objectAtIndex:5] SplitStringByChar:@","];
                                [v5 removeObject:[v0 objectAtIndex:j0]];
                                [v5 removeObject:[v1 objectAtIndex:j1]];
                                [v5 removeObject:[v2 objectAtIndex:j2]];
                                [v5 removeObject:[v3 objectAtIndex:j3]];
                                [v5 removeObject:[v4 objectAtIndex:j4]];
                                for (int j5 = 0; j5 < v5.count; j5++) {
                                    if (bets > 10000) break;
                                    bets += 1;
                                }
                            }
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN7) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                NSMutableArray *v5 = [[v objectAtIndex:5] SplitStringByChar:@","];
                                [v5 removeObject:[v0 objectAtIndex:j0]];
                                [v5 removeObject:[v1 objectAtIndex:j1]];
                                [v5 removeObject:[v2 objectAtIndex:j2]];
                                [v5 removeObject:[v3 objectAtIndex:j3]];
                                [v5 removeObject:[v4 objectAtIndex:j4]];
                                for (int j5 = 0; j5 < v5.count; j5++) {
                                    if (bets > 10000) break;
                                    NSMutableArray *v6 = [[v objectAtIndex:6] SplitStringByChar:@","];
                                    [v6 removeObject:[v0 objectAtIndex:j0]];
                                    [v6 removeObject:[v1 objectAtIndex:j1]];
                                    [v6 removeObject:[v2 objectAtIndex:j2]];
                                    [v6 removeObject:[v3 objectAtIndex:j3]];
                                    [v6 removeObject:[v4 objectAtIndex:j4]];
                                    [v6 removeObject:[v5 objectAtIndex:j5]];
                                    for (int j6 = 0; j6 < v6.count; j6++) {
                                        if (bets > 10000) break;
                                        bets += 1;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN8) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                NSMutableArray *v5 = [[v objectAtIndex:5] SplitStringByChar:@","];
                                [v5 removeObject:[v0 objectAtIndex:j0]];
                                [v5 removeObject:[v1 objectAtIndex:j1]];
                                [v5 removeObject:[v2 objectAtIndex:j2]];
                                [v5 removeObject:[v3 objectAtIndex:j3]];
                                [v5 removeObject:[v4 objectAtIndex:j4]];
                                for (int j5 = 0; j5 < v5.count; j5++) {
                                    if (bets > 10000) break;
                                    NSMutableArray *v6 = [[v objectAtIndex:6] SplitStringByChar:@","];
                                    [v6 removeObject:[v0 objectAtIndex:j0]];
                                    [v6 removeObject:[v1 objectAtIndex:j1]];
                                    [v6 removeObject:[v2 objectAtIndex:j2]];
                                    [v6 removeObject:[v3 objectAtIndex:j3]];
                                    [v6 removeObject:[v4 objectAtIndex:j4]];
                                    [v6 removeObject:[v5 objectAtIndex:j5]];
                                    for (int j6 = 0; j6 < v6.count; j6++) {
                                        if (bets > 10000) break;
                                        NSMutableArray *v7 = [[v objectAtIndex:7] SplitStringByChar:@","];
                                        [v7 removeObject:[v0 objectAtIndex:j0]];
                                        [v7 removeObject:[v1 objectAtIndex:j1]];
                                        [v7 removeObject:[v2 objectAtIndex:j2]];
                                        [v7 removeObject:[v3 objectAtIndex:j3]];
                                        [v7 removeObject:[v4 objectAtIndex:j4]];
                                        [v7 removeObject:[v5 objectAtIndex:j5]];
                                        [v7 removeObject:[v6 objectAtIndex:j6]];
                                        for (int j7 = 0; j7 < v7.count; j7++) {
                                            if (bets > 10000) break;
                                            bets += 1;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN9) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                NSMutableArray *v5 = [[v objectAtIndex:5] SplitStringByChar:@","];
                                [v5 removeObject:[v0 objectAtIndex:j0]];
                                [v5 removeObject:[v1 objectAtIndex:j1]];
                                [v5 removeObject:[v2 objectAtIndex:j2]];
                                [v5 removeObject:[v3 objectAtIndex:j3]];
                                [v5 removeObject:[v4 objectAtIndex:j4]];
                                for (int j5 = 0; j5 < v5.count; j5++) {
                                    if (bets > 10000) break;
                                    NSMutableArray *v6 = [[v objectAtIndex:6] SplitStringByChar:@","];
                                    [v6 removeObject:[v0 objectAtIndex:j0]];
                                    [v6 removeObject:[v1 objectAtIndex:j1]];
                                    [v6 removeObject:[v2 objectAtIndex:j2]];
                                    [v6 removeObject:[v3 objectAtIndex:j3]];
                                    [v6 removeObject:[v4 objectAtIndex:j4]];
                                    [v6 removeObject:[v5 objectAtIndex:j5]];
                                    for (int j6 = 0; j6 < v6.count; j6++) {
                                        if (bets > 10000) break;
                                        NSMutableArray *v7 = [[v objectAtIndex:7] SplitStringByChar:@","];
                                        [v7 removeObject:[v0 objectAtIndex:j0]];
                                        [v7 removeObject:[v1 objectAtIndex:j1]];
                                        [v7 removeObject:[v2 objectAtIndex:j2]];
                                        [v7 removeObject:[v3 objectAtIndex:j3]];
                                        [v7 removeObject:[v4 objectAtIndex:j4]];
                                        [v7 removeObject:[v5 objectAtIndex:j5]];
                                        [v7 removeObject:[v6 objectAtIndex:j6]];
                                        for (int j7 = 0; j7 < v7.count; j7++) {
                                            if (bets > 10000) break;
                                            NSMutableArray *v8 = [[v objectAtIndex:8] SplitStringByChar:@","];
                                            [v8 removeObject:[v0 objectAtIndex:j0]];
                                            [v8 removeObject:[v1 objectAtIndex:j1]];
                                            [v8 removeObject:[v2 objectAtIndex:j2]];
                                            [v8 removeObject:[v3 objectAtIndex:j3]];
                                            [v8 removeObject:[v4 objectAtIndex:j4]];
                                            [v8 removeObject:[v5 objectAtIndex:j5]];
                                            [v8 removeObject:[v6 objectAtIndex:j6]];
                                            [v8 removeObject:[v7 objectAtIndex:j7]];
                                            for (int j8 = 0; j8 < v8.count; j8++) {
                                                if (bets > 10000) break;
                                                bets += 1;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else if (lotteryType == TYPE_PK10_PUTONGXUAN10) {
            NSMutableArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@","];
            for (int j0 = 0; j0 < v0.count; j0++) {
                if (bets > 10000) break;
                NSMutableArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@","];
                [v1 removeObject:[v0 objectAtIndex:j0]];                
                for (int j1 = 0; j1 < v1.count; j1++) {
                    if (bets > 10000) break;
                    NSMutableArray *v2 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    [v2 removeObject:[v0 objectAtIndex:j0]];
                    [v2 removeObject:[v1 objectAtIndex:j1]];
                    for (int j2 = 0; j2 < v2.count; j2++) {
                        if (bets > 10000) break;
                        NSMutableArray *v3 = [[v objectAtIndex:3] SplitStringByChar:@","];
                        [v3 removeObject:[v0 objectAtIndex:j0]];
                        [v3 removeObject:[v1 objectAtIndex:j1]];
                        [v3 removeObject:[v2 objectAtIndex:j2]];
                        for (int j3 = 0; j3 < v3.count; j3++) {
                            if (bets > 10000) break;
                            NSMutableArray *v4 = [[v objectAtIndex:4] SplitStringByChar:@","];
                            [v4 removeObject:[v0 objectAtIndex:j0]];
                            [v4 removeObject:[v1 objectAtIndex:j1]];
                            [v4 removeObject:[v2 objectAtIndex:j2]];
                            [v4 removeObject:[v3 objectAtIndex:j3]];
                            for (int j4 = 0; j4 < v4.count; j4++) {
                                if (bets > 10000) break;
                                NSMutableArray *v5 = [[v objectAtIndex:5] SplitStringByChar:@","];
                                [v5 removeObject:[v0 objectAtIndex:j0]];
                                [v5 removeObject:[v1 objectAtIndex:j1]];
                                [v5 removeObject:[v2 objectAtIndex:j2]];
                                [v5 removeObject:[v3 objectAtIndex:j3]];
                                [v5 removeObject:[v4 objectAtIndex:j4]];
                                for (int j5 = 0; j5 < v5.count; j5++) {
                                    if (bets > 10000) break;
                                    NSMutableArray *v6 = [[v objectAtIndex:6] SplitStringByChar:@","];
                                    [v6 removeObject:[v0 objectAtIndex:j0]];
                                    [v6 removeObject:[v1 objectAtIndex:j1]];
                                    [v6 removeObject:[v2 objectAtIndex:j2]];
                                    [v6 removeObject:[v3 objectAtIndex:j3]];
                                    [v6 removeObject:[v4 objectAtIndex:j4]];
                                    [v6 removeObject:[v5 objectAtIndex:j5]];
                                    for (int j6 = 0; j6 < v6.count; j6++) {
                                        if (bets > 10000) break;
                                        NSMutableArray *v7 = [[v objectAtIndex:7] SplitStringByChar:@","];
                                        [v7 removeObject:[v0 objectAtIndex:j0]];
                                        [v7 removeObject:[v1 objectAtIndex:j1]];
                                        [v7 removeObject:[v2 objectAtIndex:j2]];
                                        [v7 removeObject:[v3 objectAtIndex:j3]];
                                        [v7 removeObject:[v4 objectAtIndex:j4]];
                                        [v7 removeObject:[v5 objectAtIndex:j5]];
                                        [v7 removeObject:[v6 objectAtIndex:j6]];
                                        for (int j7 = 0; j7 < v7.count; j7++) {
                                            if (bets > 10000) break;
                                            NSMutableArray *v8 = [[v objectAtIndex:8] SplitStringByChar:@","];
                                            [v8 removeObject:[v0 objectAtIndex:j0]];
                                            [v8 removeObject:[v1 objectAtIndex:j1]];
                                            [v8 removeObject:[v2 objectAtIndex:j2]];
                                            [v8 removeObject:[v3 objectAtIndex:j3]];
                                            [v8 removeObject:[v4 objectAtIndex:j4]];
                                            [v8 removeObject:[v5 objectAtIndex:j5]];
                                            [v8 removeObject:[v6 objectAtIndex:j6]];
                                            [v8 removeObject:[v7 objectAtIndex:j7]];
                                            for (int j8 = 0; j8 < v8.count; j8++) {
                                                if (bets > 10000) break;
                                                NSMutableArray *v9 = [[v objectAtIndex:9] SplitStringByChar:@","];
                                                [v9 removeObject:[v0 objectAtIndex:j0]];
                                                [v9 removeObject:[v1 objectAtIndex:j1]];
                                                [v9 removeObject:[v2 objectAtIndex:j2]];
                                                [v9 removeObject:[v3 objectAtIndex:j3]];
                                                [v9 removeObject:[v4 objectAtIndex:j4]];
                                                [v9 removeObject:[v5 objectAtIndex:j5]];
                                                [v9 removeObject:[v6 objectAtIndex:j6]];
                                                [v9 removeObject:[v7 objectAtIndex:j7]];
                                                [v9 removeObject:[v8 objectAtIndex:j8]];
                                                for (int j9 = 0; j9 < v9.count; j9++) {
                                                    if (bets > 10000) break;
                                                    bets += 1;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } 
    }
    return bets;
}

// 返回足彩对阵未选择比赛场数
+ (NSInteger)getFourCount:(NSString *)selectNumber
{
    int count = 0;
    if (selectNumber) {
        NSArray *v = [selectNumber SplitStringByChar:@"*"];
        for (NSString *str in v) {
            if ([str isEqualToString:four]) {
                count += 1;
            }
        }
    }
    return count;
}

/**
 * 计算注数
 * 
 * @param betnumber
 *            号码
 * @param lotteryType
 *            彩种
 * @param modeType
 *            玩法
 * @return
 */
+ (NSInteger)getBets:(NSString *)betnumber LotteryType:(LotteryTYPE)lotteryType ModeType:(ModeTYPE)modeType
{
    int bets = 0;
    if ([GC_LotteryType isZucai:lotteryType]) {
        if (betnumber && betnumber.length > 0) {
            NSArray *v = [betnumber SplitStringByChar:@"*"];
            if (lotteryType == TYPE_ZC_RENXUAN9) {
                int fourCount = (int)[self getFourCount:betnumber];
                if(fourCount == (14 - 9)){
                    bets = 1;
                    for (NSString *str in v) {
                        bets *= str.length;
                    }
                }
            } else {
                if (![v containsObject:four]) {
                    bets = 1;
                    for (NSString *str in v) {
                        bets *= str.length;
                    }
                }
            }
        }
    } else if (lotteryType == TYPE_SHUANGSEQIU) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == Shuangseqiudanshi || modeType == Shuangseqiufushi) {
                NSArray *v = [betnumber SplitStringByChar:@"+"];
                if (![v containsObject:@"e"]) {
                    NSArray *red = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *blue = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = (int)[GC_LotteryUtil combination:(int)[red count] :6] * (int)[blue count];
                }
            } else if (modeType == Shuangseqiudantuo) {
                NSArray *v = [betnumber SplitStringByChar:@"+"];
                if (![v containsObject:@"e"]) {
                    NSArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@"@"];
                    if (![v0 containsObject:@"e"]) {
                        NSArray *blue = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        NSArray *redDan = [[v0 objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *redTuo = [[v0 objectAtIndex:1] SplitStringByChar:@","];
                        
                        NSUInteger c = [GC_LotteryUtil combination:[redTuo count] :(6 - [redDan count])];
                        bets = (int)c * (int)[blue count];
                    }
                }
            }
        }
    } else if (lotteryType == TYPE_DALETOU) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == Daletoudanshi || modeType == Daletoufushi) {
                NSArray *v = [betnumber SplitStringByChar:@"_:_"];
                if (![v containsObject:@"e"]) {
                    NSArray *red = [[v objectAtIndex:0] SplitStringByChar:@"_"];
                    NSArray *blue = [[v objectAtIndex:1] SplitStringByChar:@"_"];
                    bets = (int)[GC_LotteryUtil combination:(int)[red count] :5] * (int)[GC_LotteryUtil combination:(int)[blue count] :2];
                }
            } else if (modeType == Daletoudantuo) {
                NSArray *v = [betnumber SplitStringByChar:@"_:_"];
                if (![v containsObject:@"e"] && [v count] > 1) {
                    NSArray *red = [[v objectAtIndex:0] SplitStringByChar:@"_,_"];
                    NSArray *blue = [[v objectAtIndex:1] SplitStringByChar:@"_,_"];
                    if (red.count == 2 && blue.count == 2) {
                        NSArray *redDan = [[red objectAtIndex:0] SplitStringByChar:@"_"];
                        NSArray *redTuo = [[red objectAtIndex:1] SplitStringByChar:@"_"];
                        NSArray *blueTuo = [[blue objectAtIndex:1] SplitStringByChar:@"_"];
                        if ((redDan.count + redTuo.count) < 6) return 0;
                        bets = (int)[GC_LotteryUtil combination:(int)redTuo.count :(5 - (int)redDan.count)] * (int)blueTuo.count;
                    }
                    else {
                        if (([red count] < 2 || [blue count] < 2) && !(red.count == 1 && blue.count == 1) && red.count > 0 && blue.count > 0) {
                            if ([red count] == 1) {
                                NSArray *redTuo = [[red objectAtIndex:0] SplitStringByChar:@"_"];
                                NSArray *blueTuo = [[blue objectAtIndex:1] SplitStringByChar:@"_"];
                                if (redTuo.count < 5) {
                                    return 0;
                                }
                                else {
                                    bets = (int)[GC_LotteryUtil combination:(int)[redTuo count] :5] * (int)blueTuo.count;
                                }
                            }
                            else if ([blue count] == 1) {
                                NSArray *redDan = [[red objectAtIndex:0] SplitStringByChar:@"_"];
                                NSArray *redTuo = [[red objectAtIndex:1] SplitStringByChar:@"_"];
                                NSArray *blueTuo = [[blue objectAtIndex:0] SplitStringByChar:@"_"];
                                if (blueTuo.count < 2) {
                                    return 0;
                                }
                                else {
                                    bets = (int)[GC_LotteryUtil combination:(int)redTuo.count :(5 - (int)redDan.count)] * (int)[GC_LotteryUtil combination:(int)blueTuo.count :2];
                                }
                            }
                        }
                    }
                }
            }
        }
    } else if (lotteryType == TYPE_PAILIE3) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == Array3zhixuanzuhe) {
                bets = (int)[GC_LotteryUtil permutation:[betnumber length] :3];
            } else {
                NSArray *v = [betnumber SplitStringByChar:@"*"];
                if (![v containsObject:@"e"]) {
                    if (modeType == Array3zusandanshi || modeType == Array3zuliudanshi) {
                        bets = [GC_LotteryUtil getZuxuanDanshi:(int)[v count]];
                    } else if (modeType == Array3zusanfushi) {
                        bets = (int)[GC_LotteryUtil permutation:(int)[v count] :2];//yaofuyu修改
                        //bets = [GC_LotteryUtil permutation:[betnumber length] :2];
                    } else if (modeType == Array3zuliufushi) {
                        bets = (int)[GC_LotteryUtil combination:(int)[v count] :3];//yaofuyu修改
                        //bets = [GC_LotteryUtil combination:[betnumber length] :3];
                    } else if (modeType == Array3zuhedantuo) {// 组合胆拖
                        bets = (int)[GC_LotteryUtil getZhixuanZuheDantuo:(int)[[v objectAtIndex:0] length] :[[v objectAtIndex:1] length]];
                    } else if (modeType == Array3zusandantuo) {// 组三胆拖
                        
                        bets = (int)[GC_LotteryUtil getZuxuanZu3Dantuo:[[v objectAtIndex:0] length] :[[v objectAtIndex:1] length]];
                    } else if (modeType == Array3zuliudantuo) {// 组六胆拖
                        bets = (int)[GC_LotteryUtil getZuxuanZu6Dantuo:[[v objectAtIndex:0] length] :[[v objectAtIndex:1] length]];
                    }
                    
                    else if (modeType == Array3zhixuanHezhi || modeType == Array3zusanHezhi || modeType == Array3zuliuHezhi) {
                        NSArray *v = [betnumber SplitStringByChar:@"%04#"];
                        for (NSString *s in v) {
                            if (modeType == Array3zhixuanHezhi) {
                                bets = bets + [GC_LotteryUtil get3Dhezhi:[s intValue]];
                            }
                            else if (modeType == Array3zusanHezhi) {
                                bets = bets + [GC_LotteryUtil get3DZuSanHezhi:[s intValue]];
                            }
                            else if (modeType == Array3zuliuHezhi) {
                                bets = bets + [GC_LotteryUtil get3DZuLiuHezhi:[s intValue]];
                            }
                        }
                    }
                    
                    else {
                        NSLog(@"~~%@",v);
                        bets = 1;
                        for (NSString *s in v) {
                            bets = bets * (int)[s length];
                        }
                    }
                }
            }
        }
    } else if (lotteryType == TYPE_PAILIE5 || lotteryType == TYPE_QIXINGCAI) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            NSArray *v = [betnumber SplitStringByChar:@"*"];
            if (![v containsObject:@"e"]) {
                bets = 1;
                for (NSString *s in v) {
                    bets = bets * (int)[s length];
                }
            }
        }
    } else if (lotteryType == TYPE_7LECAI) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == Qilecaidanshi || modeType == Qilecaifushi) {
                NSArray *v = [betnumber SplitStringByChar:@"_"];
                bets = (int)[GC_LotteryUtil combination:[v count] :7];
            } else {
                NSArray *v = [betnumber SplitStringByChar:@"_,_"];
                if (![v containsObject:@"e"]) {                    
                    NSArray *v0 = [[v objectAtIndex:0] SplitStringByChar:@"_"];
                    NSArray *v1 = [[v objectAtIndex:1] SplitStringByChar:@"_"];
                    bets = (int)[GC_LotteryUtil combination:[v1 count] :(7 - [v0 count])];
                    bets = (bets == 1 ? 0 : bets);
                }
            }
        }
    } else if (lotteryType == TYPE_22XUAN5) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            NSArray *v = [betnumber SplitStringByChar:@"*"];
            bets = (int)[GC_LotteryUtil combination:[v count] :5];
        }
    } else if (lotteryType == TYPE_3D) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == ThreeDzhixuandanshi || modeType == ThreeDzusandanshi || modeType == ThreeDzuliudanshi) {
                NSRange r = [betnumber rangeOfString:@"e"];
                if (r.length <= 0) {
                    bets = [GC_LotteryUtil getZuxuanDanshi:(int)[betnumber length]];
                }
            } else if (modeType == ThreeDzusanfushi) {
                bets = (int)[GC_LotteryUtil permutation:[betnumber length] :2];
            } else if (modeType == ThreeDzuliufushi) {
                if ([betnumber length] >= 3) bets = (int)[GC_LotteryUtil combination:[betnumber length] :3];
            } else if (modeType == ThreeDzhixuanhezhi || modeType == ThreeDzusanHezhi || modeType == ThreeDzuliuHezhi){
                NSRange r = [betnumber rangeOfString:@"e"];
                if (r.length <= 0) {
                     NSArray *v = [betnumber SplitStringByChar:@"%04#"];
                    bets = 0;
                    for (NSString *s in v) {
                        if (modeType == ThreeDzhixuanhezhi) {
                            bets = bets + [GC_LotteryUtil get3Dhezhi:[s intValue]];
                        }
                        else if (modeType == ThreeDzusanHezhi) {
                            bets = bets + [GC_LotteryUtil get3DZuSanHezhi:[s intValue]];
                        }
                        else if (modeType == ThreeDzuliuHezhi) {
                            bets = bets + [GC_LotteryUtil get3DZuLiuHezhi:[s intValue]];
                        }
                    }
                }
            }
            else {
                NSArray *v = [betnumber SplitStringByChar:@","];
                if (![v containsObject:@"e"]&& [v count]>=2) {
                    if (modeType == ThreeDzusanDantuo || modeType == ThreeDzuliuDantuo) {
                        NSLog(@"3d胆拖~~~~~~~~");
                        NSUInteger dan = [[v objectAtIndex:0] length];
                        NSUInteger tuo = [[v objectAtIndex:1] length];
                        bets = (int)[GC_LotteryUtil get3DDantuo:dan :tuo];
                    } else {
                        bets = 1;
                        for (NSString *s in v) {
                            bets = bets * (int)[s length];
                        }
                    }
                }
            }
        }
    } else if (lotteryType == TYPE_SHISHICAI || lotteryType == TYPE_CQShiShi) {
		if (modeType > 21 && modeType < 26) {
			bets = modeType%20;
		}
        else if (modeType>= SSCrenxuanyi && modeType <= SSCrenxuansan){
            if (betnumber && ![betnumber isEqualToString:@"e"]) {
                betnumber = [betnumber stringByReplacingOccurrencesOfString:@"_" withString:@""];
                NSArray *v = [betnumber SplitStringByChar:@","];
                GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                int totleChose = 0;
                for (int i = 0; i < v.count; i++) {
                    NSNumber *key;
                    int choseCout = 0;
                    
                            choseCout = choseCout + (int)[[v objectAtIndex:i] length];
                            totleChose = totleChose +(int)[[v objectAtIndex:i] length];
                    
                    key = [NSNumber numberWithInt:choseCout];
                    if ([key intValue] != 0) {
                        int value = [[dic objectForKey:key] intValue];
                        value = value +1;
                        [dic setObject:[NSNumber numberWithInt:value] forKey:key];
                    }
                }
                switch (modeType) {
                    case SSCrenxuanyi:
                        bets =totleChose;
                        break;
                    case SSCrenxuaner:
                        [jcalgorithm passData:dic gameCount:[v count] chuan:@"2串1"];
                        bets = (int)jcalgorithm.totalZhuShuNum;
                        break;
                    case SSCrenxuansan:
                        [jcalgorithm passData:dic gameCount:[v count] chuan:@"3串1"];
                        bets = (int)jcalgorithm.totalZhuShuNum;
                        break;
                    default:
                        break;
                }
                
            }
            
        }
		else {
			if (betnumber && ![betnumber isEqualToString:@"e"]) {
				NSArray *v = [betnumber SplitStringByChar:@","];
				if (![v containsObject:@"e"]) {
					bets = 1;
					for (int i = 0; i < v.count; i++) {
						bets = bets * (int)[[v objectAtIndex:i] length];
					}
				}
			}
		}
    } else if (lotteryType >= TYPE_11XUAN5_1 && lotteryType <= TYPE_11XUAN5_Q3DaTuo) {
        int base = 0;
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (lotteryType == 31) {
                bets = 1;
            } else if (lotteryType == 38) {
                base = lotteryType - 30;
                NSArray *v = [betnumber SplitStringByChar:@","];
//                if ([v count] == 8) bets = 1;
                bets = [self getTotal1:(int)[v count] :base :(base + 1)];
            } else if (lotteryType >= 32 && lotteryType <= 37) {
                base = lotteryType - 30;
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        int dan = (int)[v1 count];
                        int tuo = (int)[v2 count];
                        bets = (int)[self combination:tuo :(base - dan)];
                    }
                } else {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :base :(base + 1)];
                }
            } else if (lotteryType == 39) {
                if (modeType == 1) { // 复试
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int repeat = [self count2:v1 :v2];
                        bets = n1 * n2 - repeat;
                    }
                }
            } else if (lotteryType == 40) {
                if (modeType == 1) {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 2) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int n3 = (int)[v3 count];
                        int repeat = [self count3:v1 :v2 :v3];
                        bets = n1*n2*n3 - repeat;
                    }
                }
            } else if (lotteryType == 41) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :3];
                }
            }
            else if (lotteryType == 42) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R4DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R5DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
        }
    }
    else if (lotteryType >= TYPE_GD11XUAN5_1 && lotteryType <= TYPE_GD11XUAN5_Q3DaTuo) {
        lotteryType =lotteryType - TYPE_GD11XUAN5_1 + TYPE_11XUAN5_1;//转换成山东11选五
        int base = 0;
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (lotteryType == 31) {
                bets = 1;
            } else if (lotteryType == 38) {
                base = lotteryType - 30;
                NSArray *v = [betnumber SplitStringByChar:@","];
//                if ([v count] == 8) bets = 1;
                bets = [self getTotal1:(int)[v count] :base :(base + 1)];
            } else if (lotteryType >= 32 && lotteryType <= 37) {
                base = lotteryType - 30;
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        int dan = (int)[v1 count];
                        int tuo = (int)[v2 count];
                        bets = (int)[self combination:tuo :(base - dan)];
                    }
                } else {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :base :(base + 1)];
                }
            } else if (lotteryType == 39) {
                if (modeType == 1) { // 复试
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int repeat = [self count2:v1 :v2];
                        bets = n1 * n2 - repeat;
                    }
                }
            } else if (lotteryType == 40) {
                if (modeType == 1) {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 2) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int n3 = (int)[v3 count];
                        int repeat = [self count3:v1 :v2 :v3];
                        bets = n1*n2*n3 - repeat;
                    }
                }
            } else if (lotteryType == 41) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :3];
                }
            } else if (lotteryType == 42) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R4DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R5DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
        }
    }
    else if (lotteryType >= TYPE_JX11XUAN5_1 && lotteryType <= TYPE_JX11XUAN5_Q3DaTuo) {
        lotteryType =lotteryType - TYPE_JX11XUAN5_1 + TYPE_11XUAN5_1;//转换成山东11选五
        int base = 0;
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (lotteryType == 31) {
                bets = 1;
            } else if (lotteryType == 38) {
                base = lotteryType - 30;
                NSArray *v = [betnumber SplitStringByChar:@","];
                //                if ([v count] == 8) bets = 1;
                bets = [self getTotal1:(int)[v count] :base :(base + 1)];
            } else if (lotteryType >= 32 && lotteryType <= 37) {
                base = lotteryType - 30;
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        int dan = (int)[v1 count];
                        int tuo = (int)[v2 count];
                        bets = (int)[self combination:tuo :(base - dan)];
                    }
                } else {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :base :(base + 1)];
                }
            } else if (lotteryType == 39) {
                if (modeType == 1) { // 复试
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int repeat = [self count2:v1 :v2];
                        bets = n1 * n2 - repeat;
                    }
                }
            } else if (lotteryType == 40) {
                if (modeType == 1) {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 2) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int n3 = (int)[v3 count];
                        int repeat = [self count3:v1 :v2 :v3];
                        bets = n1*n2*n3 - repeat;
                    }
                }
            } else if (lotteryType == 41) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :3];
                }
            } else if (lotteryType == 42) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R4DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R5DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
        }
    }
    else if (lotteryType >= TYPE_HB11XUAN5_1 && lotteryType <= TYPE_HB11XUAN5_Q3DaTuo) {
        lotteryType =lotteryType - TYPE_HB11XUAN5_1 + TYPE_11XUAN5_1;//转换成山东11选五

        int base = 0;
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (lotteryType == 31) {
                bets = 1;
            } else if (lotteryType == 38) {
                base = lotteryType - 30;
                NSArray *v = [betnumber SplitStringByChar:@","];
                //                if ([v count] == 8) bets = 1;
                bets = [self getTotal1:(int)[v count] :base :(base + 1)];
            } else if (lotteryType >= 32 && lotteryType <= 37) {
                base = lotteryType - 30;
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        int dan = (int)[v1 count];
                        int tuo = (int)[v2 count];
                        bets = (int)[self combination:tuo :(base - dan)];
                    }
                } else {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :base :(base + 1)];
                }
            } else if (lotteryType == 39) {
                if (modeType == 1) { // 复试
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int repeat = [self count2:v1 :v2];
                        bets = n1 * n2 - repeat;
                    }
                }
            } else if (lotteryType == 40) {
                if (modeType == 1) {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 2) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int n3 = (int)[v3 count];
                        int repeat = [self count3:v1 :v2 :v3];
                        bets = n1*n2*n3 - repeat;
                    }
                }
            } else if (lotteryType == 41) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :3];
                }
            }
            else if (lotteryType == 42) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R4DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R5DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
        }
    }
    else if (lotteryType >= TYPE_ShanXi11XUAN5_1 && lotteryType <= TYPE_ShanXi11XUAN5_Q3DaTuo) {
        lotteryType =lotteryType - TYPE_ShanXi11XUAN5_1 + TYPE_11XUAN5_1;//转换成山东11选五
        
        int base = 0;
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (lotteryType == 31) {
                bets = 1;
            } else if (lotteryType == 38) {
                base = lotteryType - 30;
                NSArray *v = [betnumber SplitStringByChar:@","];
                //                if ([v count] == 8) bets = 1;
                bets = [self getTotal1:(int)[v count] :base :(base + 1)];
            } else if (lotteryType >= 32 && lotteryType <= 37) {
                base = lotteryType - 30;
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        int dan = (int)[v1 count];
                        int tuo = (int)[v2 count];
                        bets = (int)[self combination:tuo :(base - dan)];
                    }
                } else {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :base :(base + 1)];
                }
            } else if (lotteryType == 39) {
                if (modeType == 1) { // 复试
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int repeat = [self count2:v1 :v2];
                        bets = n1 * n2 - repeat;
                    }
                }
            } else if (lotteryType == 40) {
                if (modeType == 1) {
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :2];
                } else { // 定位/机选
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 2) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                        
                        int n1 = (int)[v1 count];
                        int n2 = (int)[v2 count];
                        int n3 = (int)[v3 count];
                        int repeat = [self count3:v1 :v2 :v3];
                        bets = n1*n2*n3 - repeat;
                    }
                }
            } else if (lotteryType == 41) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :2 :3];
                }
            }
            else if (lotteryType == 42) {
                if (modeType == 2) { // 胆拖
                    NSArray *v = [betnumber SplitStringByChar:@"|"];
                    if ([v count] > 1) {
                        NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                        NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                } else { // 复式/机选
                    NSArray *v = [betnumber SplitStringByChar:@","];
                    bets = [self getTotal1:(int)[v count] :3 :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R4DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_R5DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q2DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
            else if (lotteryType == TYPE_11XUAN5_Q3DaTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
        }
    }
    else if ([GC_LotteryType isHappy8:lotteryType]) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            NSArray *v = [betnumber SplitStringByChar:@"|"];
            if (modeType == 1) {
                if (v.count == lotteryType - 50) {
                    bets = 1;
                } 
            } else {
                bets = (int)[self combination:v.count :(lotteryType - 50)];
            }
        }
    } else if ([GC_LotteryType isPK10:lotteryType]) {
        return [self getPK10FushiBets:betnumber LotteryType:lotteryType];
    }
    else if (lotteryType == TYPE_HappyTen) {
        if (betnumber && ![betnumber isEqualToString:@"e"]) {
            if (modeType == HappyTenRen2Zhi) {//不兼容重复投注的
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v containsObject:@"e"]) {
                    return 0;
                }
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    
                    int n1 = (int)[v1 count];
                    int n2 = (int)[v2 count];
                    bets = n1*n2;
                }
            }
            else if (modeType == HappyTenRen3Zhi) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v containsObject:@"e"]) {
                    return 0;
                }
                if ([v count] > 2) {
                    
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    NSArray *v3 = [[v objectAtIndex:2] SplitStringByChar:@","];
                    int n1 = (int)[v1 count];
                    int n2 = (int)[v2 count];
                    int n3 = (int)[v3 count];
                    bets = n1*n2*n3;
                }
                
            }
            else if (modeType >= HappyTenRen2DanTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v containsObject:@"e"]) {
                    return 0;
                }
                if ([v count] > 1) {
                    
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    
                    if (modeType == HappyTenRen2DanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                    else if (modeType == HappyTenRen2ZuDanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                    }
                    else if (modeType == HappyTenRen3DanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                    else if (modeType == HappyTenRen3ZuDanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                    }
                    else if (modeType == HappyTenRen4DanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :4];
                    }
                    else if (modeType == HappyTenRen5DanTuo) {
                        bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :5];
                    }
                }
            }
            else {
                int base = 1;
                if (modeType == HappyTenRen3 || modeType == HappyTenRen3Zu){
                    base = 3;
                }
                else if (modeType == HappyTenRen4) {
                    base = 4;
                }
                else if (modeType == HappyTenRen5) {
                    base = 5;
                }
                else if (modeType == HappyTenRen2 || modeType == HappyTenRen2Zu) {
                    base = 2;
                }
                NSArray *v = [betnumber SplitStringByChar:@","];
                if (modeType == HappyTenDa || modeType == HappyTenDan) {
                    v = [betnumber SplitStringByChar:@";"];
                }
                bets = [self getTotal1:(int)[v count] :base :base+1];
            }
        }
        else {
            bets = 0;
        }
    
    }
    else if (lotteryType == TYPE_KuaiSan || lotteryType == TYPE_JSKuaiSan || lotteryType == TYPE_HBKuaiSan || lotteryType == TYPE_JLKuaiSan || lotteryType == TYPE_AHKuaiSan) {//内蒙古快三江苏快三
        if (betnumber && [betnumber rangeOfString:@"e"].location == NSNotFound) {
            if (modeType == KuaiSanHezhi) {//不兼容重复投注的
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = (int)[v count];
            }
            else if (modeType == KuaiSanSantongTong) {
                bets = 1;
            }
            else if (modeType == KuaiSanSantongDan) {
                NSArray *v = [betnumber SplitStringByChar:@";"];
                bets = (int)[v count];
            }
            else if (modeType == KuaiSanErtongDan) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] >=2) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = (int)[v1 count] * (int)[v2 count];
                }
            }
            else if (modeType == KuaiSanErTongFu) {
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = (int)[v count];
            }
            else if (modeType == KuaiSanSanBuTong) {
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = [self getTotal1:(int)[v count] :3 :3+1];
            }
            else if (modeType == KuaiSanErButong) {
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = [self getTotal1:(int)[v count] :2 :2+1];
            }
            else if (modeType == KuaiSanSanLianTong){
                bets = 1;
            }
            else if (modeType == KuaiSanSanBuTongDanTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :3];
                }
            }
            else if (modeType == KuaiSanErBuTongDanTuo) {
                NSArray *v = [betnumber SplitStringByChar:@"|"];
                if ([v count] > 1) {
                    NSArray *v1 = [[v objectAtIndex:0] SplitStringByChar:@","];
                    NSArray *v2 = [[v objectAtIndex:1] SplitStringByChar:@","];
                    bets = [self getDantuo:(int)[v1 count] :(int)[v2 count] :2];
                }
            }
        }
        else {
            bets = 0;
        }
    }
    else if (lotteryType == TYPE_KuaiLePuKe) {
        if (betnumber && [betnumber rangeOfString:@"e"].location == NSNotFound) {
            if (modeType >= KuaiLePuKeRen1 && modeType <= KuaiLePuKeRen6) {
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = [self getTotal1:(int)[v count] :modeType - KuaiLePuKeRen1 + 1 :modeType - KuaiLePuKeRen1 + 2];
            }
            else if (modeType >= KuaiLePuKeTongHua && modeType <= KuaiLePuKeDuiZi) {
                NSArray *v = [betnumber SplitStringByChar:@","];
                bets = (int)[v count];
            }
        }
    }
    
    return bets;
}

+ (NSMutableArray *)getCanSameRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum
{
    if(numItems <= 0) return nil;
    NSMutableArray *randBalls = [NSMutableArray arrayWithCapacity:numItems];
    while ([randBalls count] < numItems) {
        NSString *rs = [GC_LotteryUtil randNumber:_start maxnum:_maxnum];
        if (rs) {
			if ([randBalls count] == 0 ||[rs intValue] > [[randBalls lastObject] intValue]) {
                [randBalls addObject:rs];
			}
			else {
				int a=0;
				for (int i = 0; i < [randBalls count] -1; i++) {
					if ([rs intValue]>[[randBalls objectAtIndex:i] intValue] &&[rs intValue]<[[randBalls objectAtIndex:i + 1] intValue]) {
						a= i+1 ;
						i = (int)[randBalls count];
					}
				}
				[randBalls insertObject:rs atIndex:a];
			}
            
        }
    }
    return randBalls;
}

+ (NSMutableArray *)getRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum IsRanged:(BOOL) isRange {
    if(numItems <= 0) return nil;
    NSMutableArray *randBalls = [NSMutableArray arrayWithCapacity:numItems];
    while ([randBalls count] < numItems) {
        NSString *rs = [GC_LotteryUtil randNumber:_start maxnum:_maxnum];
        if (rs && ![randBalls containsObject:rs]) {
			if ([randBalls count] == 0 ||[rs intValue] > [[randBalls lastObject] intValue]) {
                [randBalls addObject:rs];
			}
			else {
                if (isRange) {
                    int a=0;
                    for (int i = 0; i < [randBalls count] -1; i++) {
                        if ([rs intValue]>[[randBalls objectAtIndex:i] intValue] &&[rs intValue]<[[randBalls objectAtIndex:i + 1] intValue]) {
                            a= i+1 ;
                            i = (int)[randBalls count];
                        }
                    }
                    [randBalls insertObject:rs atIndex:a];
                }
                else {
                    [randBalls addObject:rs];
                }

			}
            
        }
    }
    return randBalls;
}

+ (NSMutableArray *)getRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum
{
    if(numItems <= 0) return nil;
    NSMutableArray *randBalls = [NSMutableArray arrayWithCapacity:numItems];
    while ([randBalls count] < numItems) {
        NSString *rs = [GC_LotteryUtil randNumber:_start maxnum:_maxnum];
        if (rs && ![randBalls containsObject:rs]) {
			if ([randBalls count] == 0 ||[rs intValue] > [[randBalls lastObject] intValue]) {
                [randBalls addObject:rs];
			}
			else {
                int a=0;
                for (int i = 0; i < [randBalls count] -1; i++) {
                    if ([rs intValue]>[[randBalls objectAtIndex:i] intValue] &&[rs intValue]<[[randBalls objectAtIndex:i + 1] intValue]) {
                        a= i+1 ;
                        i = (int)[randBalls count];
                    }
                }
                [randBalls insertObject:rs atIndex:a];
			}
            
        }
    }
    return randBalls;
}

+ (NSMutableArray *)getLuckyBalls:(long long)luckNum //随机数
                            start:(NSUInteger)_start //最小数
                           maxnum:(NSUInteger)_maxnum //最大数
                            balls:(NSUInteger)totlnum //随机多少个
                          canSame:(BOOL)iscanSame    //是否能相同
                       shouldRank:(BOOL)shouldRanked    //是否需要排序
{
    NSMutableArray *randBalls = [NSMutableArray arrayWithCapacity:totlnum];
    NSString *longNum = [NSString stringWithFormat:@"%lli",luckNum];
    while ([randBalls count] < totlnum) {
        NSString *num = @"00";
        if (([longNum length] - 2 *[randBalls count] -2 ) <= 0) {
            num = [longNum substringFromIndex:0];
        }
        else {
            num = [longNum substringFromIndex:[longNum length] - [randBalls count]*2 -2];
        }
        
        num = [num substringToIndex:2];
        NSString *rs = nil;
        if (_start == 0) {
            
            rs = [NSString stringWithFormat:@"%i",(int)([num integerValue]%(_maxnum+1))];
        }
        else {
            rs = [NSString stringWithFormat:@"%i",(int)([num integerValue]%(_maxnum))+(int)_start];
        }
        if (_maxnum >9 && [rs integerValue]<10) {
            rs = [NSString stringWithFormat:@"0%@",rs];
        }
        BOOL isCunzai = YES;
        while (isCunzai == YES) {
            if (rs && (![randBalls containsObject:rs] || iscanSame)) {
                if ([randBalls count] == 0 ||[rs intValue] > [[randBalls lastObject] intValue]|| iscanSame) {
                    [randBalls addObject:rs];
                }
                else {
                    if (shouldRanked) {
                        int a=0;
                        for (int i = 0; i < [randBalls count] -1; i++) {
                            if ([rs intValue]>[[randBalls objectAtIndex:i] intValue] &&[rs intValue]<[[randBalls objectAtIndex:i + 1] intValue]) {
                                a= i+1 ;
                                i = (int)[randBalls count];
                            }
                        }
                        [randBalls insertObject:rs atIndex:a];
                    }
                    else {
                        [randBalls addObject:rs];
                    }
                    
                }
                isCunzai = NO;
                
            }
            else {
                num = [NSString stringWithFormat:@"%i",(int)[num integerValue]+1];
                if (_start == 0) {
                    rs = [NSString stringWithFormat:@"%i",(int)([num integerValue] % (_maxnum+1))];
                }
                else {
                    rs = [NSString stringWithFormat:@"%i",(int)([num integerValue] % (_maxnum))+(int)_start];
                };
                
                if (_maxnum >9 && [rs integerValue]<10) {
                    rs = [NSString stringWithFormat:@"0%@",rs];
                }
                isCunzai = YES;
            }
        }
    
    }
    
    return randBalls;
}

+ (NSString *)randNumber:(NSUInteger)_start maxnum:(NSUInteger)_maxnum
{
    NSUInteger rn; 
    if (_start == 0) {
        rn = arc4random() % (_maxnum + 1);
    } else {
        rn = arc4random() % (_maxnum - _start + 1) + _start;
    }
    if (_maxnum > 9 && rn < 10) {
        return [NSString stringWithFormat:@"0%u", (int)rn];
    }
    return [NSString stringWithFormat:@"%u", (int)rn];
}

+ (NSMutableArray *)getRandNumber:(NSUInteger)count LotteryType:(LotteryTYPE)lotteryType
{
    NSMutableArray *vec = [NSMutableArray arrayWithCapacity:count];
    NSMutableString *number = [NSMutableString string];
    for (int i = (int)count; i > 0; i--) {
        switch (lotteryType) {
            case TYPE_SHUANGSEQIU:
            {
                NSArray *redBalls = [GC_LotteryUtil getRandBalls:6 start:1 maxnum:33];
                redBalls = [redBalls sortedArrayUsingSelector:@selector(compareNumeric:)];
                [number appendString:[redBalls componentsJoinedByString:@","]];
                [number appendString:@"+"];
                [number appendString:[GC_LotteryUtil randNumber:1 maxnum:16]];
            }
                break;
            case TYPE_DALETOU:
            {
                NSArray *qianquBalls = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:35];
                qianquBalls = [qianquBalls sortedArrayUsingSelector:@selector(compareNumeric:)];
                [number appendString:[qianquBalls componentsJoinedByString:@"_"]];
                [number appendString:@"_:_"];
                NSArray *houquBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:12];
                houquBalls = [houquBalls sortedArrayUsingSelector:@selector(compareNumeric:)];
                [number appendString:[houquBalls componentsJoinedByString:@"_"]];
            }
                break;
            case TYPE_PAILIE3:
            {
                for (NSUInteger j = 3; j > 0; j--) {
                    [number appendString:[GC_LotteryUtil randNumber:0 maxnum:9]];
                    if (j!= 1) {
                        [number appendString:@"*"];
                    }
                }
            }
                break;
            case TYPE_PAILIE5:
            {
                for (NSUInteger j = 5; j > 0; j--) {
                    [number appendString:[GC_LotteryUtil randNumber:0 maxnum:9]];
                    if (j!= 1) {
                        [number appendString:@"*"];
                    }
                }
            }
                break;
            case TYPE_QIXINGCAI:
            {
                for (NSUInteger j = 7; j > 0; j--) {
                    [number appendString:[GC_LotteryUtil randNumber:0 maxnum:9]];
                    if (j!= 1) {
                        [number appendString:@"*"];
                    }
                }
            }
                break;
            case TYPE_7LECAI:
            {
                NSArray *nums = [GC_LotteryUtil getRandBalls:7 start:1 maxnum:30];
                nums = [nums sortedArrayUsingSelector:@selector(compareNumeric:)];
                [number appendString:[nums componentsJoinedByString:@"_"]];
            }
                break;
            case TYPE_22XUAN5:
            {
                NSArray *nums = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:22];
                nums = [nums sortedArrayUsingSelector:@selector(compareNumeric:)];
                [number appendString:[nums componentsJoinedByString:@"*"]];
            }
                break;
            case TYPE_3D:
            {
                for (NSUInteger j = 3; j > 0; j--) {
                    [number appendString:[GC_LotteryUtil randNumber:0 maxnum:9]];
                }
            }
                break;
            default:
                break;
        }
        if (number && [number length] > 0) {
            [vec addObject:number];
        }
    }
    return vec;
}

@end

@interface NSString(NSNumericSearch)

- (NSComparisonResult)compareNumeric:(NSString *)aString;

@end

@implementation NSString(NSNumericSearch)

// 比较大小排序
- (NSComparisonResult)compareNumeric:(NSString *)aString
{
    return [self compare:aString options:NSNumericSearch];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
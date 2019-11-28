//
//  LotteryUtil.h
//  Lottery
//
//  Created by Kiefer on 11-12-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_LotteryType.h"

@interface GC_LotteryUtil : NSObject 
{
    
}

+ (long long)combination:(long long)m :(long long)n ;
+ (NSInteger)getBets:(NSString*)betnumber LotteryType:(LotteryTYPE)lotteryType ModeType:(ModeTYPE)modeType;
+ (NSMutableArray *)getRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum;
+ (NSMutableArray *)getRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum IsRanged:(BOOL) isRange;//add by姚福玉 随机数是否从小到大排列；
+ (NSMutableArray *)getCanSameRandBalls:(NSUInteger)numItems start:(NSUInteger)_start maxnum:(NSUInteger)_maxnum;//yaofuyu添加，获取随机数能重复
+ (NSMutableArray *)getLuckyBalls:(long long)luckNum //随机数
                            start:(NSUInteger)_start //最小数
                           maxnum:(NSUInteger)_maxnum //最大数
                            balls:(NSUInteger)totlnum //随机多少个
                          canSame:(BOOL)iscanSame    //是否能相同
                       shouldRank:(BOOL)shouldRanked;    //是否需要排序
+ (NSString *)randNumber:(NSUInteger)_start maxnum:(NSUInteger)_maxnum;
+ (NSMutableArray *)getRandNumber:(NSUInteger)count LotteryType:(LotteryTYPE)lotteryType;

+ (int)get3DZuSanHezhi:(int)n;
+ (int)get3DZuLiuHezhi:(int)n;

@end

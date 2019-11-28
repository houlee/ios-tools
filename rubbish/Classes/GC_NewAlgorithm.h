//
//  NewAlgorithm.h
//  Lottery
//
//  Created by j on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//竞彩 设胆的算法
@interface GC_NewAlgorithm : NSObject {
    
    NSInteger totalNum, bValue;//计算所得注数
    NSMutableArray *m_arr;//除设胆后的场
}

@property (nonatomic, assign) NSInteger totalNum;
//@property (nonatomic, retain) NSMutableArray *m_arr;


- (void)countAlgorithmWithArray:(NSMutableArray *)algArray chuanGuan:(NSString *)chuanGuan changCi:(NSInteger)changCi sheDan:(NSArray *)sArray;

- (void)totalNumByYuSelChangCi:(NSInteger)selChang yuArr:(NSMutableArray *)yuArr;

- (NSInteger)reLoopValue:(NSArray *)array baseValue:(NSInteger)baseValue;

- (NSMutableArray *)subArrayFromIndex:(NSInteger)index aboutArray:(NSArray *)arr;

- (long long)reTotalNumber;

@end

//
//  JCalgorithm.h
//  Lottery
//
//  Created by Jacob Chiang on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_JCalgorithm : NSObject{
    NSMutableDictionary *passTypeRuleDic;
    NSMutableDictionary *diguiDic;
    // 保存 第二次 递归 数据
    NSMutableDictionary *secondDiguiDic;
    NSMutableArray *newFangZhiArray;//放置拆分好的数组，姚福玉添加，比如将，让球非让球都选择的拆成只选择一种方法的
}

- (void)chaiHunArray:(NSMutableArray *)hunArray chuan:(NSString *)_chuan;//姚福玉添加计算新方法

+(GC_JCalgorithm*)shareJCalgorithmManager;
-(NSMutableDictionary*)dicWithPassType;
-(NSArray*)passTypeRuleArry:(NSString*)key;
-(void)passData:(NSMutableDictionary*)selectedItems gameCount:(NSInteger)count chuan:(NSString*)chuan;
//-(void)diGuiRule:(NSMutableDictionary*)selectedItems keys:(NSArray*)keys  key:(NSNumber*)key value:(NSNumber*)value index:(NSInteger)index k:(NSInteger)k;
-(void)putDiguiInfoToDic:(NSInteger)key currentVaule:(NSInteger)currentVaule oldValue:(NSInteger)oldValue itemsCount:(NSInteger)itemsCount;
//-(void)putDiguiInfoToList:(NSInteger)key currentVaule:(NSInteger)currentVaule oldValue:(NSInteger)oldValue itemsCount:(NSInteger)itemsCount;
-(void)putDiguiInfoToList:(NSInteger)key currentVaule:(NSInteger)currentVaule oldValue:(NSInteger)oldValue itemsCount:(NSInteger)itemsCount  gameCount:(NSInteger)count chuan:(NSString*)chuan;
-(void)diGuiRule:(NSMutableDictionary*)selectedItems keys:(NSArray*)keys  key:(NSNumber*)key value:(NSNumber*)value index:(NSInteger)index k:(NSInteger)k gameCount:(NSInteger)count chuan:(NSString*)chuan;
-(long long)totalZhuShu:(NSMutableDictionary*)dic keysAfterOder:(NSArray*)keys;
-(long long)totalZhuShuNum;

// 二次 递归
-(void)secondDiguiRule:(NSMutableDictionary*)secondItemsDic keys:(NSArray*)keys key:(NSNumber*)key  value:(NSInteger)value index:(NSInteger)index k:(NSInteger)k oldCanChooseCount:(NSInteger)oldCanChooseCount chuan:(NSString*)chuan itemsCount:(NSInteger)itemsCount;

-(void)secondPutDiguiInfoToDic:(NSInteger)key currentValue:(NSInteger)currentValue  oldValue:(NSInteger)oldValue fristCanChooseCount:(NSInteger)fristCanChooseCount 

                    itemsCount:(NSInteger)itemsCount;

-(void)secondPutdiguiInfoTolist:(NSInteger)key currentValue:(NSInteger)currentValue oldValue:(NSInteger)oldValue fristCanChooseCount:(NSInteger)fristCanChooseCount itemsCount:(NSInteger)itemsCount chuan:(NSString*)chuan;
-(long long)secondtotalZhuShu:(NSMutableDictionary*)dic keysAfterOder:(NSArray*)keys;

@end

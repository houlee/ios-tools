//
//  JCDiGuiInfo.h
//  Lottery
//
//  Created by Jacob Chiang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_JCDiGuiInfo : NSObject{
    long long currentValue;
    long long oldValue;
    long long itemsCount;
    long long  canChooseCount;
    long long  fristCanChooseCount;// 二次递归 时候 保存 第一次时候的 数据
}

@property(nonatomic,assign) long long currentValue;
@property(nonatomic,assign)long long oldValue;
@property(nonatomic,assign)long long itemsCount;
@property(nonatomic,assign)long long canChooseCount;
@property(nonatomic,assign)long long fristCanChooseCount;

-(long long)canChooseCount:(long long)moldValue  currentValue:(long long)mcurrentValue;
-(long long)itemsReslut:(long long)itemsCount currentValue:(long long)mcurrentValue;


@end

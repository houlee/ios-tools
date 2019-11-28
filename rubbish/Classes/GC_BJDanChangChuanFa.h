//
//  GC_BJDanChangChuanFa.h
//  caibo
//
//  Created by houchenguang on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_BJDanChangChuanFa : NSObject

+(NSMutableArray*)lotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount type:(NSInteger)type;

+(NSMutableArray*)danLotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount type:(NSInteger)type;

+(NSString*)passTypeChange:(NSString*)passType;

@end
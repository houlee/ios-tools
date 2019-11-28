//
//  PassTypeUtils.h
//  Lottery
//
//  Created by Jacob Chiang on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_PassTypeUtils : NSObject

+(NSMutableArray*)lotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount;

+(NSMutableArray*)danLotteryId:(NSInteger)lotteryID GameCount:(NSInteger)gameCount;

+(NSString*)passTypeChange:(NSString*)passType;

@end

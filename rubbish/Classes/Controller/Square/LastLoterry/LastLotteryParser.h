//
//  LastLotteryParser.h
//  caibo
//
//  Created by user on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LastLotteryParser : NSObject {
	NSMutableArray *lotteries;
	NSMutableDictionary *typeLottery;
	NSMutableArray *welfareLottery;
	NSMutableArray *highfrequencyLottery;
	NSMutableArray *sportsLottery;
	NSMutableArray *footballLottery;
}
@property(nonatomic, retain)NSMutableArray *lotteries;
@property(nonatomic, retain)NSMutableDictionary *typeLottery;
@property(nonatomic, retain)NSMutableArray *welfareLottery;
@property(nonatomic, retain)NSMutableArray *highfrequencyLottery;
@property(nonatomic, retain)NSMutableArray *sportsLottery;
@property(nonatomic, retain)NSMutableArray *footballLottery;


+(NSArray*)parseWithResponseString:(NSString*)response;

@end

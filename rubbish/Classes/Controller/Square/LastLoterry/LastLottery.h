//
//  LastLottery.h
//  caibo
//
//  Created by user on 11-10-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LastLottery : NSObject {
	NSString *lotteryNo;
	NSString *issue;
	NSString *picurl;
	NSString *ernieDate;
	NSString *openNumber;
	NSString *lotteryName;
    NSString *ernieDateNew;
    NSString *weekday;
    NSString * region;//地区
    NSString * Luck_blueNumber;//幸运蓝球
}
@property(nonatomic, retain)NSString *lotteryNo;
@property(nonatomic, retain)NSString *issue;
@property(nonatomic, retain)NSString *picurl;
@property(nonatomic, retain)NSString *ernieDate;
@property(nonatomic, retain)NSString *openNumber;
@property(nonatomic, retain)NSString *lotteryName;
@property(nonatomic, retain)NSString *ernieDateNew;
@property (nonatomic,retain)NSString *weekday;
@property (nonatomic, retain)NSString * region;
@property (nonatomic,retain)NSString *tryoutNumber, * Luck_blueNumber;


- (UIImageView *)numViewWithStr:(NSString *)str inColor:(NSString*)color;
-(NSArray*)imagesWithNumber;
-(NSArray*)imagesWithKuaiLeShiFen;
@end

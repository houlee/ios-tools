//
//  LotteryList.h
//  caibo
//
//  Created by sulele on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LotteryList : NSObject {
	NSString *maxPage;     //总页数
	NSString *lotteryId;   //彩种编号
	NSString *pageSize;    //每行页数
	NSString *currentPage; //当前页
	NSString *relist;      //返回结果
	NSString *lotteryNumber;//开奖号码
	NSString *issue;        //彩期
	NSString *ernie_date;   //开奖时间
	NSString *lotteryName;  //彩种
    NSString * Luck_blueNumber;//幸运蓝球
	NSArray *reListArray;

}
@property (nonatomic, retain)NSString *maxPage,*lotteryId,*pageSize,*currentPage;
@property (nonatomic, retain)NSString *relist,*lotteryNumber,*issue,*ernie_date,*lotteryName, * Luck_blueNumber;
@property (nonatomic, retain)NSArray *reListArray;

- (id)initWithParse:(NSString *)jsonString;
- (id)paserWithDictionary:(NSDictionary *)dic;

- (UIImageView *)numViewWithStr:(NSString *)str inColor:(NSString*)color;
-(NSArray*)imagesWithNumber:(NSString *)num;

-(NSArray*)imagesWithKuaiLeShiFen:(NSString *)num;

-(NSArray*)imagesWithKuaiSan:(NSString *)num;

-(NSArray*)imagesWithNumber2:(NSString *)num;
-(NSArray*)imagesWithKuaiLeShiFen2:(NSString *)num;

-(NSArray*)imagesWithHorseNumber:(NSString *)num;

@end

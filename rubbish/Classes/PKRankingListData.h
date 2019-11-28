//
//  PKRankingListData.h
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import <Foundation/Foundation.h>

@interface PKRankingListData : NSObject
{
    NSString * rank;//排名
    NSString * userName;//用户名
    NSString * earnings;//收益
    NSString * winnings;//奖金
}

@property (nonatomic, retain)NSString * rank;
@property (nonatomic, retain)NSString * userName;
@property (nonatomic, retain)NSString * earnings;
@property (nonatomic, retain)NSString * winnings;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

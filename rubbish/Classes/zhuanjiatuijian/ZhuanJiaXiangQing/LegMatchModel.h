//
//  LegMatchModel.h
//  caibo
//
//  Created by zhoujunwang on 16/1/21.
//
//

#import <Foundation/Foundation.h>

@interface LegMatchModel : NSObject

+(instancetype)legMatchModelWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@property(nonatomic,copy)NSString * leagueName;
@property(nonatomic,copy)NSString * leagueTotalRecommend;
@property(nonatomic,copy)NSString * leagueHitNum;
@property(nonatomic,copy)NSString * leagueHitRate;

@end

@interface PurchaseMdl : NSObject

+(instancetype)purchaseMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * explain;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * pic;
@property(nonatomic,copy)NSString * is_buy;

@end
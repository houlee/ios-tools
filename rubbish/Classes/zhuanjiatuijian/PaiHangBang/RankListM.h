//
//  RankListM.h
//  caibo
//
//  Created by zhoujunwang on 16/1/20.
//
//

#import <Foundation/Foundation.h>

@interface RankListM : NSObject

+(instancetype)RankListMWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@property(nonatomic,copy)NSString * expertsNickName;//专家昵称
@property(nonatomic,copy)NSString * expertsIntroduction;//专家简介
@property(nonatomic,assign)NSInteger totalRecommend;//推荐总数
@property(nonatomic,assign)NSInteger totalHitRate;//总命中率
@property(nonatomic,assign)NSInteger radioRecommend;//单选推荐总数
@property(nonatomic,assign)NSInteger radioRecommendHitRate;//单选命中率
@property(nonatomic,assign)NSInteger star;//专家星级
@property(nonatomic,copy)NSString * headPortait;//头像
@property(nonatomic,assign)NSInteger source;//来源(0:网站专家,1:用户专家,9:足球报)
@property(nonatomic,assign)NSInteger heat;//人气度
@property(nonatomic,assign)NSInteger rewardRate;//回报率
@property(nonatomic,assign)NSInteger continuousHit;//连中次数
@property(nonatomic,assign)NSInteger currentRank;//当前排名
@property(nonatomic,assign)NSInteger lastRank;//上一次排名
@property(nonatomic,copy)NSString * expertsName;//专家帐号
@property(nonatomic,copy)NSString * expertsClassCode;//专家类型
@property(nonatomic,copy)NSString * lotteyClassCode;//彩种

@end

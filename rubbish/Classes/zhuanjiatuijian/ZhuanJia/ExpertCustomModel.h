//
//  ExpertCustomModel.h
//  Experts
//
//  Created by v1pin on 15/11/11.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertCustomModel : NSObject

@property(nonatomic,copy)NSString * EXPERTS_NAME;//专家账号
@property(nonatomic,copy)NSString * EXPERTS_STATUS;//专家状态
@property(nonatomic,copy)NSString * HAS_FOCUS;//是否已经关注
@property(nonatomic,copy)NSString * HEAD_PORTRAIT;//头像
@property(nonatomic,assign)NSInteger NEW_RECOMMEND_NUM;//新推荐方案数
@property(nonatomic,copy)NSString * REAL_NAME;//真实姓名
@property(nonatomic,copy)NSString * SOURCE_EXPERTS_ID;//专家编号
@property(nonatomic,copy)NSString * STAR;//星级
@property(nonatomic,copy)NSString * EXPERTS_CODE_ARRAY;//专家类型
@property(nonatomic,copy)NSString * EXPERTS_NICK_NAME;//专家昵称

+(instancetype)expertCustomWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end

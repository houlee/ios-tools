//
//  BuyPlanModel.h
//  Experts
//
//  Created by V1pin on 15/11/11.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyPlanModel : NSObject

@property(nonatomic,strong)NSString * EXPERTS_NICK_NAME;// ----专家昵称
@property(nonatomic,strong)NSString * HEAD_PORTRAIT;//头像
@property(nonatomic,strong)NSString * STAR;//----星级
@property(nonatomic,strong)NSString * SOURCE;//---来源(0:网站专家,1:用户专家,11指定专家9:足球报) 只有0带V
@property(nonatomic,strong)NSString * CLOSE_STATUS;//方案结期状态0初始状态1未结期2截止购买3已结期
@property(nonatomic,strong)NSString * HOME_NAME;//主队名称
@property(nonatomic,strong)NSString * HOME_NAME2;//主队名称
@property(nonatomic,strong)NSString * AWAY_NAME;//--客队名称
@property(nonatomic,strong)NSString * AWAY_NAME2;//--客队名称
@property(nonatomic,strong)NSString * MATCH_TIME;//----开赛时间
@property(nonatomic,strong)NSString * MATCH_TIME2;//----开赛时间
@property(nonatomic,strong)NSString * CREATE_TIME;// 购买时间
@property(nonatomic,strong)NSString * HIT_STATUS;//命中状态 0:初始值,1:命中,2:未命中,3:取消
@property(nonatomic,strong)NSString * AMOUNT;//--- 交易金额

@property(nonatomic,assign)NSInteger FREE_STATUS;//是否支持不中退款

@property(nonatomic,strong)NSString * LOTTEY_CLASS_CODE;//球的种类
@property(nonatomic,strong)NSString * ER_ISSUE;//- 期次号

@property(nonatomic,strong)NSString * ER_AGINT_ORDER_ID; //--方案ID

@property(nonatomic,strong)NSString * ASIAN_RESULT_STATUS;//亚盘命中情况(0:初始值,1:命中,2:未命中,3:取消,4:走盘)

@property(nonatomic,assign)NSInteger SD_STATUS;//约彩还是神单方案

@property(nonatomic,strong)NSString * SD_EXPLAIN;//神单说明

@property(nonatomic,strong)NSString * LEAGUE_NAME;//
@property(nonatomic,strong)NSString * LEAGUE_NAME2;//
@property(nonatomic,strong)NSString * MATCHES_ID;//
@property(nonatomic,strong)NSString * MATCHES_ID2;//
@property(nonatomic,strong)NSString * PLAY_ID;//
@property(nonatomic,strong)NSString * PLAY_ID2;//

@property(nonatomic,strong)NSString * RN;//
@property(nonatomic,strong)NSString * USER_NAME;//
@property(nonatomic,strong)NSString * EXPERTS_CLASS_CODE;//
@property(nonatomic,strong)NSString * EXPERTS_NAME;//
@property(nonatomic,strong)NSString * GOLDDISCOUNTPRICE;//
@property(nonatomic,strong)NSString * REFUND_STATUS;//

//篮球
@property(nonatomic,strong)NSString * PLAY_TYPE_CODE; //27让分胜负  29大小分
@property(nonatomic,strong)NSString * HOSTRQ; //

@end

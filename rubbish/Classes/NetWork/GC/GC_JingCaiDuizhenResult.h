//
//  JingCaiDuizhenResult.h
//  Lottery
//
//  Created by Jacob Chiang on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/***
 *
 * 4.109	竞彩对阵查询（新）（1449） 返回 结果 再解析
 ****/

#import <Foundation/Foundation.h>

@interface GC_JingCaiDuizhenResult : NSObject{
   
    NSString *num;// 序号
    NSString *match;// 赛事
    NSString *homeTeam;//主队
    NSString *homeTeamNum;//主队编号
    NSString *vistorTeam;//客队
    NSString *vistorTeamNum;//客队编号
    NSString *time;//剩余时间
    NSString *deathLineTime;//截止时间
    NSString *odds;//赔率
    NSString *europeOdds;//欧赔
    NSString *rangQiu;//让分
    NSString *score;// 比分
    NSString *state;//状态
    NSString *lotteryResult;//彩果
    NSString *matchId;//赛事编号
    
    NSArray *oddsList;// 赔率 截取之后 数据 列表
    NSMutableDictionary *selectedDic;// 保存 选择项；
    NSMutableArray *afterInoderList;// 保存 排序之后的数据
    NSInteger danState;// 胆的状态，0 = 设胆，1 = 未设胆
    NSString * bicaiid;//id
    NSString * datetime;
    NSString * nyrstr;
    NSString * bdzhouji;
    NSString * aomenoupei;//澳门欧赔
    NSString * zhongzu;//中足推荐
    NSString * macthTime;//比赛时间（ 截止时间 /开赛时间）
    NSString * macthType;//比赛状态
    NSString * zlcString;//中立场
    NSString * timeSort;//时间排序
    NSString * onePlural;//单负式
    NSString * hhonePlural;//混合胜平负 是否包含单关
    NSString * pluralString;
}
@property (nonatomic, retain)NSString * bicaiid, *datetime, *nyrstr;
@property(nonatomic,retain) NSString *num, *match,*homeTeam,*homeTeamNum,*vistorTeam,*vistorTeamNum,*time,*deathLineTime,*odds,*europeOdds,*rangQiu,*score,*state,*lotteryResult,*matchId,* bdzhouji, * macthTime, *macthType, * hhonePlural;
@property(nonatomic,retain)NSArray *oddsList;
@property(nonatomic,retain) NSMutableDictionary *selectedDic;
@property(nonatomic,retain) NSMutableArray *afterInoderList;// 保存 排序之后的数据
@property(nonatomic,assign)NSInteger danState;
@property (nonatomic, retain)NSString * aomenoupei, *zhongzu, *zlcString, * timeSort, * onePlural, * pluralString;


- (id)initWithResult:(NSString*)result;
-(NSString*)reusltString:(NSArray*)keys;


@end

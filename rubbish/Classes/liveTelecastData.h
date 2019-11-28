//
//  liveTelecastData.h
//  caibo
//
//  Created by houchenguang on 13-6-26.
//
//

#import <Foundation/Foundation.h>

@interface liveTelecastData : NSObject{


    NSString * isAttention;
    NSString * home;
    NSString * hostcard;//1_0 红牌是1 皇牌是0
    NSString * xh;//序号
    NSString * leagueName;
    NSString * matchstartTime;
    NSString * status;
    NSString * lotteryId;
    NSString * caiguo;
    NSString * menuStr;//这一期次显示的名称  分割日期显示名称
    NSString * issue;//期次
    NSString * rangqiu;
    NSString * matchTime;//时间
    NSString * pos;
    NSString * away;
    NSString * scoreHost; //比分
    NSString * start;//状态
    NSString * matchId;
    NSString * splitDate;//分割日期
    NSString * awaycard;
    NSString * awayHost;
    NSString * ASIA_cp_p;
    NSString * bcbf;
    NSString * section_id;//pptv
}
@property (nonatomic, retain)NSString * isAttention, * home, * hostcard, * xh, * leagueName, * matchstartTime, * status, * lotteryId, * caiguo, * menuStr, * issue, * rangqiu, * matchTime, * pos, * away, * scoreHost, * start, * matchId,* splitDate, * awaycard, * awayHost, * ASIA_cp_p, * bcbf, * section_id;

@end

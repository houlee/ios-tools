//
//  BiFenZhiBoLanQiuData.h
//  caibo
//
//  Created by yaofuyu on 13-10-23.
//
//

#import <Foundation/Foundation.h>

@interface BiFenZhiBoLanQiuData : NSObject {
    NSString *matchStartTime; //比赛开始时间
    NSString *guestName; //客队名
    NSString *status;               //比赛状态
    NSString *state;    //状态 比赛状态0表示未开始。1表示进行中，2表示完成
    NSString *liansainame;//联赛状态
    NSString *playId;  //比赛编号
    NSString *hostflg; //主队旗帜
    NSString *matchNo; //赛事编号
    NSString *Hostscore; //主队得分
    NSString *guestflg;//客队旗帜
    NSString *Guestscore;//客队得分
    NSString *bcbf;//半场比分
    NSString *hostName;//主队名称
    NSString *curIssue;//当前期次
    NSString *refreshtime;//刷新次数；
    NSMutableArray *matchList; // 比赛列表
    BOOL isColorNeedChange;//需要变艳色；
    BOOL isScoreHostChange;//主队变化
    BOOL isAwayHostChange;//客队变化
    
    
}
@property(nonatomic,retain)NSString *matchStartTime,*guestName,*status,*state,*liansainame,*playId,*hostflg,*matchNo,*Hostscore,*guestflg,*Guestscore,*bcbf,*hostName,*curIssue,*refreshtime;
@property (nonatomic,retain)NSMutableArray *matchList; // 比赛列表
@property (nonatomic)BOOL isColorNeedChange,isScoreHostChange,isAwayHostChange;
- (id)initWithDic:(NSDictionary *)dic;
- (id)initParserWithString:(NSString *)str;
// 旧的比赛中部分属性值变化更新
+ (void)replaceMatch:(BiFenZhiBoLanQiuData*)match NewMatch:(BiFenZhiBoLanQiuData*)newMatch;

@end

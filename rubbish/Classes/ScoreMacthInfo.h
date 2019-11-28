//
//  ScoreMacthInfo.h
//  caibo
//
//  Created by yaofuyu on 13-7-3.
//
//

#import <Foundation/Foundation.h>

@interface ScoreMacthInfo : NSObject {
    
    
    NSString *home;                //主队
    NSString *away;                //客队
    
    NSString *leagueName;          //联赛名
    NSString *matchTime;           //开赛时间
    
    NSString *asianHome;           //亚盘主队
    NSString *asianRangqiu;        //亚盘让球
    NSString *asianAway;           //亚盘客队
    
    NSString *eurWin;              //欧盘主胜
    NSString *eurDraw;             //欧盘平
    NSString *eurLost;             //欧盘客胜
    
    NSString *spWin;              //胜平负胜赔率
    NSString *spEqual;             //胜平负平赔率
    NSString *spLose;             //胜平负负赔率
    
    NSString *scoreHost;           //主队进球数
    NSString *awayHost;            //客队进球数
    
    NSMutableArray *eventArray;  //事件数组

        
    NSString *lotteryId;           //彩种类型
    NSInteger isGoalNotice;        //是否进球通知
    NSString *status;               //比赛状态
    NSString *GuestTeamFlag;        //客队旗帜
    
    NSString *HostTeamFlag;         //主队旗帜
    
    //篮球中新增数据
    NSString *state;            //比赛状态0为开始，1进行中，2已结束
    NSString *totleScroe;       //总分
    NSString *fencha;           //分差
    NSString *yushezongfen;     //预设总分
    NSString *actiontxt;        //文字比分
    NSDictionary *asianDic;     //亚赔让分数据
    NSDictionary *over_downDic;  //大小数据
    NSDictionary *europeDic;       //欧赔数据
    NSDictionary *asian_changeDic;     //亚赔让分变化数据
    NSDictionary *over_down_changeDic;  //大小变化数据
    NSDictionary *europe_changeDic;       //欧赔变化数据
    NSString *refreshtime;             //刷新时间
}

@property (nonatomic, retain) NSString *leagueName, *matchTime;
@property (nonatomic, retain) NSString *asianHome, *asianRangqiu, *asianAway;
@property (nonatomic, retain) NSString *eurWin, *eurDraw, *eurLost,*spWin,*spEqual,*spLose;
@property (nonatomic, retain) NSString *home, *away, *scoreHost, *awayHost,*status,*GuestTeamFlag,*HostTeamFlag,*totleScroe,*fencha,*yushezongfen,*actiontxt,*state,*refreshtime;

@property (nonatomic, retain) NSMutableArray *eventArray;


@property (nonatomic, retain) NSString *lotteryId;
@property (nonatomic, assign) NSInteger isGoalNotice;
@property (nonatomic, retain) NSDictionary *asianDic,*over_downDic,*europeDic,*asian_changeDic,*over_down_changeDic,*europe_changeDic;

//解析赛事详情
- (id)initWithParse: (NSString*)responseString;
- (id)initWithLanQiuParse:(NSString*)responseString;
+ (void)replaceOlde:(ScoreMacthInfo *)oldInfo WithNew:(ScoreMacthInfo *)newInfo;

@end


//比赛事件
@interface MacthEvent : NSObject {
    NSInteger teamType;         //主客队类型
    NSInteger eventType;          //比赛中主队球员所判类型
    NSString *name;            //球员姓名 或者是篮球中的节数
    NSString *mins;            //球员被判时时间
    NSString *scroe;           //篮球中的比分
}

@property(nonatomic,retain)NSString *name,*mins,*scroe;
@property(nonatomic,assign)NSInteger teamType,eventType;
- (id)initWithDic:(NSDictionary *)dic;

@end

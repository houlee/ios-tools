//
//  JiangJinYouHuaJX.h
//  caibo
//
//  Created by yaofuyu on 13-7-9.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface JiangJinYouHuaJX : NSObject {
    NSInteger returnId;              //返回消息id
    NSString *systemTime;            //系统时间
    NSString *YHKey;                //优化后key值
    NSString *minMoney;             //最小奖金
    NSString *maxMoney;             //最大奖金
    NSString *randNum;              //优化方案随机数
    NSString *YHStueNum;            //优化状态码
    NSString *YHMsg;                //优化信息
    NSInteger  betLenght;           //投注内容长度
    NSMutableArray *betArray;       //投注内容
    NSInteger chaiLenght;           //拆分内容长度
    NSMutableArray *chaiArray;      //拆分内容
    
}

@property (nonatomic, retain)NSString *systemTime,*YHKey,*minMoney,*maxMoney,*randNum,*YHStueNum,*YHMsg;
@property (nonatomic)NSInteger returnId,betLenght,chaiLenght;
@property (nonatomic,retain)NSMutableArray *betArray,*chaiArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;


@end

@interface GC_YHTouInfo : NSObject
{
    NSString *identifier; //比赛序号
    NSString *leagueName; //赛事名称
    NSString *leagueID; //赛事ID
    NSString *home; //主队
	NSString *away; //客队
    NSString *endTime; //截至时间
    NSString *assignCount; //让球
    NSString *eurPei; //赔率
    NSString *playID;//比赛id
}

@property(nonatomic, copy) NSString *identifier, *leagueName, *leagueID,*home,*away,*endTime,*assignCount,*eurPei,*playID;

@end

@interface GC_YHChaiInfo : NSObject
{
    NSString *identifier; //比赛序号
    NSString *betInfo; //投注内容
    NSString *betNum; //注数
    NSString *danJiang; //单注奖金
	NSString *zongJiang; //总奖金
}

@property(nonatomic, copy) NSString *identifier, *betInfo, *betNum,*danJiang,*zongJiang;

@end

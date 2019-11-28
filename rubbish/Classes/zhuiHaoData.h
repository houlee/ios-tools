//
//  zhuiHaoData.h
//  caibo
//
//  Created by houchenguang on 13-12-12.
//
//

#import <Foundation/Foundation.h>
#import "GC_BetRecord.h"
#import "ASIHTTPRequest.h"

@interface zhuiHaoData : NSObject{

    NSInteger sysId;//消息id
    NSString * sysTime;//系统时间
    NSInteger sumPage;//总页数
    NSInteger currPage;//当前页
    NSInteger recordCount;//返回条数
    NSMutableArray * infoList;//信息的数组
    ///////////////////////////////////////////////一下是详情页的数据
    NSString * lotteryName;//彩种名称
    NSString * lotteryID;//彩种编号
    NSString * playName;//玩法名称
    NSString * playID;//玩法编号
    NSString * zhuihaoMoney;//追号方案金额
    NSString * yiFuAmount;//已付金额
    NSString * betTime;//投注时间
    NSString * zhuiHaoType;//追号状态
    NSString * awardType;//中奖状态
    NSString * awardAmount;//中奖金额
    NSInteger awarIssue;//中奖期数
    NSInteger yiZhuiIssue;//已追期数
    NSInteger zhuiHaoIssue;//追号期数
    NSInteger zhuiHaoJiLu;//显示追号记录数
    NSInteger shengyu;//剩余追号记录数
  
     NSString * zhuiHaoTypeString;//追号状态文字
    
    
}
@property (nonatomic, retain)NSString *sysTime, * lotteryName, * lotteryID, * playName, * playID, *zhuihaoMoney, *yiFuAmount, *betTime, * zhuiHaoType, * awardType, * awardAmount, * zhuiHaoTypeString;
@property (nonatomic, assign)NSInteger sysId, currPage, recordCount, sumPage, yiZhuiIssue, zhuiHaoIssue, zhuiHaoJiLu, awarIssue, shengyu;
@property (nonatomic, retain)NSMutableArray * infoList;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request type:(NSInteger)type;//0是我的追号 1是我的追号详情
@end



//合买信息格式定义
@interface zhuiHaoDataInfo : NSObject {
	
	
    NSString * betDate;            //投注时间
    NSString * lotteryName;//彩种名称
    NSString * lotteryNumber;//彩种编号
    NSString * playName;//玩法名称
    NSString * playNumber;//玩法编号
    NSString * betAmount;//投注金额
    NSString * lotteryIssue;//期号      详情期号
    NSInteger  zhuiHaoSet;//追号设置
    NSString * stopAmount;//停追金额
    NSString * zhuiHaoID;//追号方案编号   详情方案编号
    NSInteger awardIssue;//中奖期数     详情状态
    NSInteger yiZhuiIssue;//已追期数
    NSInteger zhuiHaoIssue;//追号期数
    NSString * awardAmount;//中奖金额    详情金额
    NSString * yuliu;//预留字段
    
    
    /////////////////////////////////////////////////一下是方案详情里的数据
    
    // NSString * lotteryIssue;//期号      详情 期号
    NSString * awardType;//中奖期数     详情 中奖状态
    // NSString * awardAmount;//中奖金额    详情 中奖金额
//      NSString * zhuiHaoID;//追号方案编号   详情方案编号
    NSString *  fanganMoney;//详情方案金额
    NSString * secrecyType;//保密类型
    NSString * fanganType;//详情方案状态
    NSString * fangantypeString;//详情方案状态  字
    
    
    
}

@property (nonatomic, retain)NSString * betDate, * lotteryName, * lotteryNumber, *playName, * playNumber, * betAmount, * lotteryIssue, * stopAmount, * zhuiHaoID, * awardAmount, * yuliu, * secrecyType, *fanganType ,*awardType, *fanganMoney, *fangantypeString;
@property (nonatomic, assign)NSInteger zhuiHaoSet, awardIssue, yiZhuiIssue, zhuiHaoIssue;
@end
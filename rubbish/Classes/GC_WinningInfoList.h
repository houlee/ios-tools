//
//  ZhongJiangMingDan.h
//  WorldCup
//
//  Created by yaofuyu on 14-2-17.
//  Copyright (c) 2014年 Vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum{
    POINT_WINNING_TYPE,//积分中奖名单
    MYPOINT_MES_TYPE,   //我的积分详情
    WORLDCUP_WINNING_TYPE, //世界杯国旗活动获奖名单
    CANEXCHANGE_CaiJin_TYPE,//可兑换彩金项
    CANEXCHANGE_YHM_TYPE,//可兑换优惠码
    
}WinningListType;

@interface GC_WinningInfoList : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSInteger curPage;          //当前页
    NSInteger curCount;         //当前页人数
    NSMutableArray *zhongjiangArray;    //参与数组  奖品包
    NSMutableArray *zhongjiangArray1;  //参与数组1  优惠码
    
    NSString *mouthHuoDePoint; //月内获得积分数
    NSString *mouthXiaoHaoPoint;//月内消耗积分数
    
    
    NSString *flagCode;
    NSString *flagMsg;
    
    int JXCount; //奖项数目
    


    
}
@property(nonatomic,retain)NSMutableArray *zhongjiangArray;
@property(nonatomic,retain)NSMutableArray *zhongjiangArray1;

@property(nonatomic)NSInteger curPage,curCount,returnId;
@property(nonatomic,copy)NSString *systemTime;
@property (nonatomic,copy)NSString *mouthHuoDePoint;
@property (nonatomic, copy)NSString *mouthXiaoHaoPoint;
@property (nonatomic)int JXCount;
@property (nonatomic, copy) NSString *flagCode,*flagMsg;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request andlistType:(WinningListType)listtype;

- (id)initWithResponseString:(NSString *)_responseString WithRequest:(ASIHTTPRequest *)request;

//-(id)initWithMyPointResponseString:(NSString *)_responseString WithRequest:(ASIHTTPRequest *)request;


@end
//积分中奖名单
@interface ZhongJiangRen : NSObject {
    NSString *name;                 //用户名
    NSString *zhongJiangInfo;        //中奖内容
    NSString *ZhongJiangTime;       //中奖时间
    NSString *zhongJiangType;       //中奖种类，即单位
}

@property (nonatomic,copy)NSString *name,*zhongJiangInfo,*ZhongJiangTime;
@end

//我的积分详情（获取、消耗）
@interface MyPointMessage : NSObject
{
    NSString *pointTime; //积分时间
    NSString *pointType; //积分获取类型
    NSString *getPoint;   //获得积分
    NSString *xiaohaoPoint; //消耗积分

}
@property (nonatomic, copy)NSString *pointTime,*pointType,*getPoint,*xiaohaoPoint;
@end


//世界杯中奖名单
@interface WorldCupWinningList : NSObject
{
    NSString *name;       //中奖人
    NSString *winningTime;  //获奖时间
    NSString *flagCount;   //国旗数
    NSString *caijin;     //彩金
}
@property (nonatomic, copy) NSString *name,*winningTime,*flagCount,*caijin;
@end

//可兑换彩金项
@interface CanExChangeCaiJinList : NSObject
{
    NSString *caijinJE;//彩金金额
    NSString *needPoint;//所需积分
    NSString *alreadyExchangePeople;//已兑换人数
}
@property (nonatomic, copy) NSString *caijinJE,*needPoint,*alreadyExchangePeople;
@end

//可兑换优惠码
@interface CanExChangeYHMList : NSObject
{
    NSString *chong;//充多少
    NSString *de;//得多少
    NSString *code;//优惠码code
    NSString *needPoint;//所需积分
    NSString *alreadyExchangePeople;//已兑换人数
}
@property (nonatomic, copy) NSString *chong,*de,*code,*needPoint,*alreadyExchangePeople;
@end



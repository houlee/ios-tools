//
//  AoyunJiexi.h
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-7-24.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AoyunJiexi : NSObject {
	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSInteger reRecordNum;		// 返回记录数
	NSMutableArray *MatchInfoArray;
}

@property (nonatomic, assign) NSInteger returnId,reRecordNum;
@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, retain) NSMutableArray *MatchInfoArray;

- (id)initWithResponseData:(NSData *)_responseData;

@end

//场次信息格式定义
@interface AoyunMatchInfo : NSObject {
	
	
	NSString *matchName;              //比赛名称
	NSString *matchImageURL;         //比赛图片地址
	NSString *matchTime;               //比赛时间
    NSInteger matchNum;         //比赛序号
    NSInteger playerNum;        //比赛选手个数；
    NSMutableArray *playerArray;      //比赛选手数组
    BOOL isZhankai;
    NSString *selectNum;      //选择的比赛  传递参数用
}

@property (nonatomic,copy)NSString *matchName,*matchImageURL,*matchTime,*selectNum;
@property (nonatomic)NSInteger matchNum,playerNum;
@property (nonatomic,retain)NSMutableArray *playerArray;
@property (nonatomic)BOOL isZhankai;

@end

@interface AoyunPlayer : NSObject {
    NSString *name;         //选手姓名
    NSString *country;      //选手国家
    NSString *imageName;    //选手国家图片
    NSInteger playerId;     //选手序列号
    NSString *peilv;        //选手赔率
    BOOL isJIn;             //选择金牌
    BOOL isYin;             //选择银牌
    BOOL isTong;            //选择铜牌
}

@property (nonatomic,copy)NSString *name,*country,*imageName,*peilv;
@property (nonatomic)NSInteger playerId;
@property (nonatomic) BOOL isJin,isYin,isTong;

@end
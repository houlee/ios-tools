//
//  PKBetData.h
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//pk投注数据接口
#import <Foundation/Foundation.h>

@interface GC_BetData : NSObject{
    NSString * datetime;//节期时间
    NSString * event;//赛事
    NSString * date;//日期
    NSString * time;//时间
    NSString * tram;//哪个队对哪个队
    NSString * but1;
    NSString * but2;
    NSString * but3;
    BOOL selection1;
    BOOL selection2;
    BOOL selection3;
    NSInteger count;
    NSString * guestName;
    NSString * hostName;
    NSString * timeText;
    NSString * monynum;
    NSString * saishiid;
    BOOL booldan;
    BOOL booldan2;
    BOOL booldan3;
    NSString * numzhou;
    NSString * changhao;
    BOOL dandan;//存胆值
    BOOL nengyong;
    BOOL dannengyong;
    UIImage * danimage;
    NSString * xianshi1;
    NSString * xianshi2;
    NSString * xianshi3;
    NSString * bisaibiaoti;
    NSString * guoqilefturl;
    NSString * guoqirighturl;
    NSString * yundongurl;
    NSInteger donghuarow;
    NSString * numtime;
    NSArray * oupeiarr;
    NSString * oupeistr;
    NSMutableArray * bufshuarr;//比分一类的上的数据
    NSString * cellstring;
    NSString * numbermatch;
    NSString * nyrstr;
    NSString * bdzhou;
    NSString * bifen;//比分
    NSString * caiguo;//彩果
    NSString *  bdnum;
    BOOL nengdan;
    NSString * oupeiPeilv;//欧赔
    NSInteger xidanCount;//析胆按钮的状态
    NSString * aomenoupei;//澳门欧赔
    NSString * zhongzu;//中足推荐
    NSString * macthType;//比赛状态
    NSString * macthTime;//比赛时间（截止时间/开赛时间）
    NSString * oneMacth;//第一个能够买的比赛
    NSMutableArray * jiantouArray;
    NSString * matchLogo;
    
    BOOL worldCupBool;//是否是世界杯
    NSString * homeBannerImage;
    NSString * guestBannerImage;
    NSString * zlcString;//中立场标志
    NSString * timeSort;
    NSString * onePlural;//是否是单负式 0是不是 1是
    NSString * hhonePlural;//胜平负混合 是否包含单关 0为不包含
    NSString * pluralString;//包含单关的玩法；
}
-(id)initWithDic:(NSDictionary *)dic;
@property (nonatomic, retain)NSMutableArray * bufshuarr, * jiantouArray;
@property (nonatomic, retain)NSArray * oupeiarr;
@property (nonatomic, retain)UIImage * danimage;
@property (nonatomic)BOOL dannengyong, worldCupBool;
@property (nonatomic, retain)NSString * changhao,*nyrstr, * bisaibiaoti, * guoqilefturl, * guoqirighturl, * yundongurl, *zhongzu, *macthType, *macthTime,  * homeBannerImage, *guestBannerImage ;
@property (nonatomic, retain)NSString * numzhou,* oupeistr, * cellstring, * numbermatch ,*bdzhou ,* bifen, * caiguo, * bdnum, * oneMacth, * matchLogo, * zlcString, * timeSort, * hhonePlural, * pluralString;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL booldan;
@property (nonatomic)BOOL booldan2;
@property (nonatomic)BOOL booldan3, nengdan;
@property (nonatomic, retain)NSString * saishiid;
@property (nonatomic, retain)NSString * monynum;
@property (nonatomic, retain)NSString * timeText;
@property (nonatomic, retain)NSString * hostName;
@property (nonatomic, retain)NSString * guestName, * aomenoupei;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)BOOL selection1;
@property (nonatomic, assign)BOOL selection2;
@property (nonatomic, assign)BOOL selection3;
@property (nonatomic, retain)NSString * event, * onePlural;
@property (nonatomic, retain)NSString * date;
@property (nonatomic, retain)NSString * time;
@property (nonatomic, retain)NSString * team;
@property (nonatomic, retain)NSString * but1;
@property (nonatomic, retain)NSString * but2;
@property (nonatomic, retain)NSString * but3, * xianshi1, * xianshi2, * xianshi3, * numtime, * datetime;
@property (nonatomic)NSInteger donghuarow,xidanCount;
@property (nonatomic, retain) NSString * oupeiPeilv;//欧赔
@end

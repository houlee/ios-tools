//
//  HttpService.h
//  Lottery
//
//  Created by Kiefer on 11-12-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_LotteryType.h"
#import "GC_BuyLottery.h"
#import "GC_ASIHTTPRequest+Header.h"


//@property (nonatomic,retain)NSString *testHost,*testwapURL,*testwap_pay,*testRechage,*testTixian,*testBangdingurl,*testipURL,*testhost2,*testpkweburl,*testcheckNew,*testbuylotter,*testverify;

//可变测试环境
//#define GC_testModle_1     1
//#define GC_HOST_URL         [[Info getInstance] testHost]
//#define wap_URL        [[Info getInstance] testwapURL]
//#define base_wap_payURL      [[Info getInstance] testwap_pay]
//#define Rechange_URL [[Info getInstance] testRechage]
//#define TiXian_URL [[Info getInstance] testTixian]


//测试环境
//#define GC_testModle_1    0
//#define GC_HOST_URL       @"http://moapi.zcw.com/servlet/LotteryService" // 测试地址
//#define wap_URL        @"http://wap.zcw.com/wap/csj/charge/zfb/index.jsp" //测试wap地址
//#define base_wap_payURL      @"http://192.168.5.23:8080/wap/csj/openapi/check.jsp" //测试支付Url
//#define Rechange_URL @"http://192.168.5.23:8080/wap/csj/charge/phone/index2.jsp"//充值地址
//#define TiXian_URL @"http://192.168.5.23:8080/wap/csj/tixian/login.jsp"//提现

//公网测试
//#define  GC_testModle_1  1
//#define GC_HOST_URL       @"http://tmoapi.cmwb.com/servlet/LotteryService" // 测试地址
//#define wap_URL        @"http://tm.cmwb.com/wap/csj/charge/zfb/index.jsp" //测试wap地址
//#define base_wap_payURL      @"http://tm.cmwb.com/wap/csj/openapi/check.jsp" //测试支付Url
//#define Rechange_URL @"http://tm.cmwb.com/wap/csj/charge/phone/index2.jsp"//充值地址
//#define TiXian_URL @"http://tm.cmwb.com/wap/csj/tixian/login.jsp"//提现


//正式测试1
//#define GC_testModle_1    0
//#define GC_HOST_URL         @"http://211.151.37.57:8082/servlet/LotteryService" // 正式地址
//#define wap_URL        @"http://wap.dingdingcai.com/wap/csj/charge/zfb/index.jsp" //wap地=
//#define base_wap_payURL      @"http://tm.cmwb.com/wap/csj/openapi/check.jsp" //测试支付Url
//#define Rechange_URL @"http://wap.dingdingcai.com/wap/csj/charge/phone/index2.jsp"
//#define TiXian_URL @"http://wap.dingdingcai.com/wap/csj/tixian/login.jsp"


// 正式
#define GC_testModle_1     0
#define GC_HOST_URL         @"http://moapi.dingdingcai.com/servlet/LotteryService" // 正式地址
#define wap_URL        @"http://wap.dingdingcai.com/wap/csj/charge/zfb/index.jsp" //wap地=
#define base_wap_payURL      @"http://wap.dingdingcai.com/wap/csj/openapi/check.jsp" //支付Url
#define Rechange_URL @"http://wap.dingdingcai.com/wap/csj/charge/phone/index2.jsp"
#define TiXian_URL @"http://wap.dingdingcai.com/wap/csj/tixian/login.jsp"



#define MD5Key         @"signkey@aiclient" // MD5 key
#define AESKey         @"ai@cellphone.com" // AES key
#define newVersionKey  @"ios_2.8"     //代码版本号，每个版本都需要增加
#define keyclientType @"tongcheng" //客户端类型

#define platformType   20 // 接入平台类型：10为WAP，20为手机客户端，30为PC客户端，40为企业投注
#define mobilePlatform @"iphone" // 手机平台
#define clientID       @"400820820" // 客户端ID：默认为0,如果是手机客户端，传递手机的IMEI码
#define sysVersion     @"6225" // 系统版本
#define clientVersion  @"" // 客户端版本
#define keyresolution     @"320x480" // 分辨率
#define vendor         @"{'vendor':'','type':''}" // 手机制造商
#define myclient         @"000000"
//////////////////////////////


#define KHD_Version @"3.0"


/*********requestID*********/
#define reqID_verCheck 1101   //4.1 版本检测（1101）
#define reqID_login 1413
#define reqID_register 1414
#define reqID_heartInfo 1103 //4.3 心跳消息(1103)不带返回消息 
#define reqID_lotteryTime 1201
 
#define reqID_buyTegetherDetail 1242
#define reqID_BTLotteryNumber 1464// 获取合买方案详情投注内容
#define reqID_resetPassword 1105 // 修改密码
#define reqID_personalData 1107 // 查询个人信息
#define reqID_reSetpersonalData 1415 // 补充个人资料

    #ifdef isYueYuBan
        #define reqID_buyLottery 1332 //4.123购买彩票，数字彩代购（新）（1531）  北京单场投注
        #define reqID_zhuihaoLottry 1564//追号的投注接口
        #define reqID_startTogetherBuy 1539 //4.124合买-发起合买（1540）（福彩、体彩、足彩）
        #define reqID_jingcaiBetting 1228 //1528 //4.122 竞彩-投注- （1526）
        #define reqID_buyTegether 1241 //参与合买
    #else
        #define reqID_zhuihaoLottry 1565//追号的投注接口
        #define reqID_buyLottery 1532 //4.123购买彩票，数字彩代购（新）（1531）  北京单场投注
        #define reqID_startTogetherBuy 1542 //4.124合买-发起合买（1540）（福彩、体彩、足彩）
        #define reqID_jingcaiBetting  1528 //4.122 竞彩-投注- （1526）
        #define reqID_buyTegether 1541//参与合买
    #endif

#define reqID_getIssueInfo 1626 // 4.81	获取彩期信息（新） 买彩票1420  1582
#define reqID_getKaiJiangInfo 1442 // 4.103	开奖信息（新）（1442）
#define reqID_getHallLottery 1432 // 4.93	开奖大厅（新）（1432）
#define reqID_jingcaiDuizhen  1049//1449 // 4.109	竞彩对阵查询（新）（1449）
#define reqID_getIssueList 1446 // 4.107 获取期次列表（新）（1446）
#define reqID_getFootballMatch 1447 // 4.108 胜负彩（新）（1447）

#define reqID_accountmanager 1423 //4.84 账户全览/管理（新）（1423）
#define reqID_accountmanager_New 1567 //4.147获取余额（新）（1567）

#define reqID_bonusDis 1422 //4.83 奖金派送（新）（1422）
#define reqID_amountDetail 1424 //4.85 奖励详情（新）（1424）
#define reqID_freezeDetail 1421 //4.82 查询冻结金额（新）（1421）
#define reqID_rechangeRecord 1425 //4.86 充值记录（新）（1425）
#define reqID_withdrawals 1404 //4.65 提现记录（1404）
#define reqID_alipaySend 1450 //4.111支付宝充值发起（1450）
#define reqID_alipayReturn 1451 //4.112支付宝充值同步返回（1451）
#define reqID_rechange 1125 //4.22 充值（1125）
#define reqID_caishitong 1118 //4.15 彩视通充值卡充值(1118) 
#define reqID_withdrawalsRequest 1417 //4.78 提现请求（新）（1417）
#define reqID_getUserInfor 1416 //4.77 获取用户提款资料（新）（1416）
#define reqID_idBindAndCheck 1457 //4.117身份证信息绑定及验证（1457）
#define reqID_bankList 1456 //4.116开户行列表（1456）
#define reqID_betRecord 1570 //4.87 投注记录（新）（1426） 356是1026
//#define reqID_betRecordInfor 1027 //4.88 投注记录明细（新）（1427）
#define reqID_betRecordInfor 1571 //4.88 投注记录明细（新）（1427）
#define reqID_danBetNumber 1461 //4.118单式上传投注号码（1461）
#define reqID_chaseNumberList 1428 //4.89 追号列表（新）（1428）
#define reqID_chaseDetailInfor 1429 //4.90 追号明细（新）（1429）
#define reqID_chaseCancle 1458 //4.118追号-追号撤单（1458）（福彩、体彩、足彩）
#define reqID_customizedSigSearch 1433 //4.94 定制跟单搜索（新）（1433）
#define reqID_myCustomizedSingle 1436 //4.97 我定制的人（新）（1436）
#define reqID_customizedMe 1440 //4.101 定制我的人（新）（1440）
#define reqID_cusMeDetil 1462 //4.119定制我的人明细（新）（1462）
#define reqID_cusMeDetilRecord 1463 //4.120定制我的人明细（新）（1463）
#define reqID_recommendation 1445 //4.106 推荐（新）（1445）
#define reqID_popularCusList 1441 //4.102 人气定制排行榜（新）（1441）
#define reqID_saleLauPro 1444 //4.105 在售的发起方案（新）（1444）
#define reqID_saleSigPro 1443 //4.104 在售的跟单方案（新）（1443）
#define reqID_awardsRecord 1434 //4.95 大奖战绩（新）（1434）
#define reqID_earningsStatistics 1435 //4.96 盈利统计（新）（1435）
#define reqID_customEdit 1437 //4.98 定制编辑查询（新）（1437）
#define reqID_customSave 1438 //4.99 定制编辑保存（新）（1438）
#define reqID_customDelete 1439 //4.100 定制删除（新）（1439）

#define reqID_jingcaiIssue 1448 //4.109获取竞彩，北单期数（新）（1448）
#define reqID_jingcaiMatch 1430 //4.91 竞彩单场赛事列表（新）（1430）

#define reqID_getZucaiJingcaiMatch 1555 //4.114 足彩、竞彩对阵查询（新）（1454）
#define reqID_getZucaiJingcaiIssueList 1585 //4.115 获取足彩竞彩，北单期数（新）（1455）（1554）（1585）
#define reqid_beidanmatch 1454//北单对阵 
#define reqid_beidanissue 1585//北单期号 1554  

#define reqID_getAdvertisement 1130 //4.27 获取广告(1130)

#define reqID_xianjinliushui 1025//现金流水
#define reqID_systime 1534//系统时间
#define reqID_yuji 1535//获取预测奖金
#define reqID_guoguan 1559//胜负彩 过关统计
#define reqID_hemaileibiao 1603//合买列表 1577
#define reqID_Hemai 1576//合买查询

#define reqID_WangQiKaiJiang 1544//往期开奖查询
#define reqID_WangQiZhongJiang 1550//往期开奖查询
#define reqID_BeiDanDuiZhen 1545//北京单场对阵信息

#define AY_qicihuoqu 1549//奥运彩票期次获取
#define AY_shengfuduizhen 1546//奥运胜负对阵
#define AY_diyiAndjinyin 1547//奥运第一名和金银铜
#define reqID_guoGuanTongJi 1549//4.148 过关统计信息
#define reqID_JiangChiChaXun 1548//奖池查询
#define huoyue_info 1551//活跃界面
#define reqID_GenDan 1556//跟单用户
#define ChaoDanYuJi 1558//获取预测奖金（抄单）
#define reqSessionIDByUserName 1560 //获取session
#define dangqianqi 1561//4.141判断是否是当前期次

#define zuihaohuoque 1563//4.143获取追号期数（新）（1563）
#define ShiJiHao 1566//4.146 试机号 
#define yonghuxinxisheding 1578//完善用户信息并赠送奖金


#define SaveGoodVocie 1572 //保存好声音
#define DownLoadVoice 1573 //下载好声音
#define ZanGoodVoice  1574 //赞好声音
#define editeBaomi     1575//修改保密类型
#define maxIssue   1581//4.161获取可追号最大期数（新）（1581）
#define reqLingJiang 1579 // 领奖接口

#define reqID_JiaJiang 1580 //加奖列表

#define reqCaiZhongInfo 1583//获取彩种信息

#define reqID_CheDan 1584//撤单

#define reqID_upmp 1586//1.22	TCL银联无卡支付
#define reqID_zhifuBao 1450// 4.111 支付宝充值

#define reqID_JJYH  1588//奖金优化

#define reqID_TGDXSZ 1589//1.73	推广短信设置（1589）

#define RECHARGE_SEQUENCE 1658//1.76	充值列表顺序  （1592）
#define MYZHUIHAO 1594//1.78	我的追号记录（1594）
#define ZHUIHAOINFO 1595//1.79	追号明细（1595）
#define ALLCHEDAN 1596//1.80	追号、合买撤单（1596）
#define reqID_lianlianYiTong 1604  //4.90 连连支付

#define reqID_umpay 1562//4.19	联动优势  信用卡快捷支付 （1562）
#define CJBYearEarnings 1605// 4.91	彩金宝年化收益接口 （1605）
#define CJBEarningsInfo 1606//4.92	彩金宝收益详情 （1606）

#define reqID_choujiang    1598 //1.83 抽奖

#define reqID_chouMingDan    1600 //1.85	中奖名单（1600）

#define reqID_ChouJiangCiShu 1601 //1.86	用户积分主界面（1601）
#define GYMATCHID 1608

#define reqID_PointMessage 1610 //4.96  积分详情(1610)

#define reqID_Dizhi         1602 //1.87	用户中奖领取地址（1602）
#define reqID_DuiHuanCaiJin 1612 //4.99 积分兑换彩金 (1612)
#define reqID_CanDuiHuanCaiJin 1611 //4.98 可兑换彩金项 (1611)
#define reqID_WeiXinChongZhi 1616  //4.102 微信充值
#define redID_newyuji 1618//4.104	大混投获取预测奖金 投注站 （1618）


//*********************************提现添加银行卡*********************************

#define reqID_userBankCardList  1620  //4.106 用户的银行卡列表
#define reqID_yinLianBackInfo   1619  //4.105 银联回拨是否成功
#define reqID_addBankCard       1621  //4.107 添加提现银行卡
#define reqID_setDefaultBankCard  1622   //4.108 设置默认银行卡

//*********************************提现添加银行卡*********************************

#define reqID_FangChenMiMessage 1623  //4.109 用户防沉迷状态信息
#define reqID_QQPay  1627   //qq充值

#define reqID_PrepaidOrderIsSucc 1634 //4.120 充值订单是否成功

#define reqID_GetUserYHMList 1635 //4.122 获取用户优惠码 (1635)
#define reqID_GetMyPrize 1638 //4.125 我的奖品包(1638)
#define reqID_DuiHuanYHM  1637 //4.124积分兑换优惠码 （1637）
#define reqID_UseYHM 1636 //4.123使用优惠码 (1636)

//********************************* PK赛 *********************************

#define reqID_jiFenBuyLottery 1640 //4.126	 Pk赛积分投注（1640）
#define reqID_GetPKList 1639 //4.125 Pk赛赛程（1639）
#define reqID_GetPKMyRecord 1641 //4.127 Pk赛投注记录（1641）
#define reqID_GetPKRanking 1643 //4.129 Pk赛排行榜（1643）
#define reqID_GetPKDetail 1642 //4.128	Pk赛积方案详情（1642）
#define reqID_GetPKBaoMingCanSai 1644 //4.130  Pk赛报名参赛（1644）
#define reqID_GetPKQici 1645 //4.130  Pk赛报名参赛（1645）

#define reqID_GetFocusMatch 1664 // 4.24 焦点赛事对阵查询（1664）



@class ASIHTTPRequest, GC_BetInfo,JiFenBetInfo;
@interface GC_HttpService : NSObject 

@property (nonatomic, copy) NSString *HzfSID, *sessionId, * Version;
@property (nonatomic, readonly) NSURL *hostUrl;
@property (nonatomic, assign) BOOL isAgain;
@property (nonatomic, retain) ASIHTTPRequest *httpRequest;

+ (GC_HttpService *)sharedInstance;

- (void)startHeartInfoTimer; //启动心跳消息定时器
- (void)stopHeartInfoTimer; //关闭心跳消息定时器
- (void)sendAdvertisementRequest; //发送广告请求
- (void)getPersonalInfoRequest; //查询个人资料

- (NSURL *)payUrlWith:(GC_BuyLottery *)_buyLottery;
- (NSURL *)payUrlWith:(GC_BuyLottery *)_buyLottery WithVoiceID:(NSString *)voicid;
- (NSURL *)reChangeUrlSysTime:(NSString *)systime;
- (NSURL *)getMoneyUrlSysTime:(NSString *)systime withMoney:(NSString *)_money;

- (NSURL *)reChangeUrlSysTimew:(NSString *)systime Type:(NSString *)type;
- (NSURL *)reChangeUrlSysTimeChongzhi:(NSString *)systime Type:(NSString *)type;


- (NSMutableData *)reqRegisterData:(NSString *)username passWord:(NSString *)password;
- (NSMutableData *)reqLoginData:(NSString *)username passWord:(NSString *)password;
- (NSMutableData *)reqHeartInfo;

- (NSMutableData *)reqLotteryTime:(UInt16)lotteryType;
- (NSMutableData *)reqBuyTogetherData:(NSString *)lotteryType issue:(NSString *)issue amountType:(UInt16)amountType baodi:(UInt16)baodi eachMoney:(UInt16)eachMoney isFull:(UInt16)isFull speed:(UInt16)speed recordCount:(UInt16)recordCount page:(int)page schemeType:(UInt16)schemeType sortWay:(NSString *)sortWay;

//4.5	修改密码（1105）
- (NSMutableData *)reSetPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;
- (NSMutableData *)personalData;

- (NSMutableData*)reSetPersonalData:(NSString*)trueName identNum:(NSString*)identNum phoneNum:(NSString*)phoneNum email:(NSString*)email sex:(int)sex address:(NSString*)address postalCode:(NSString*)postalCode telepone:(NSString*)telepone QQ:(NSString*)qqNum;

- (NSMutableData *)reqBuyLotteryData:(GC_BetInfo *)_betInfo reSend:(NSInteger) sendNum;
- (NSMutableData *)reqGetIssueInfo:(NSInteger)lotterytype;
- (NSMutableData *)reqGetKaiJiangInfo:(NSString *)lotterytype recordCount:(int)count;
- (NSMutableData *)reqGetHallLottery;
//竞彩对阵查询
// 竞彩对阵查询(新) 1449
-(NSMutableData*)jingcaiDuizhenChaXun:(int)lotteryType wanfa:(int)wanfa isEnded:(NSString*)isEnded macth:(NSString*)match chaXunQiShu:(NSString*)chaXunQiShu danOrGuo:(NSString *)dgORgg;


// 4.84	账户全览（新）(即 账户管理)（1423）
- (NSMutableData *)reqAccountManager:(NSString *)userName;
//4.147获取余额（新）（1567）
- (NSMutableData *)reqAccountManagerNew:(NSString *)userName;
// 4.83	奖金派送（新）（1422）
- (NSMutableData *)reBonusDistribution:(int)countOfPage currentPage:(int)currentPage;
//4.85 奖励详情（新）（1424）
- (NSMutableData *)reAmountDetail:(NSString *)userName type:(NSString *)type startTime:(NSString *)startTime endTime:(NSString *)endTime pageNum:(int)pageNum pageSize:(int)pageSize;
//4.82 查询冻结金额（新）（1421）
- (NSMutableData *)refreezeDetail:(int)countOfPage currentPage:(int)currentPage;
//4.86 充值记录（新）（1425）
- (NSMutableData *)reRechangeRecord:(int)curTime countOfPage:(int)countOfPage currentPage:(int)currentPage;
//4.65 提现记录（1404）
- (NSMutableData *)reWithdrawals:(int)way state:(int)state startTime:(NSString *)startTime endTime:(NSString *)endTime sortField:(NSString *)sortField sortStyle:(NSString *)sortStyle countOfPage:(int)countOfPage currentPage:(int)currentPage;
//4.111支付宝充值发起（1450）
- (NSMutableData *)reAlipaySend:(NSString *)userName rechangeAmount:(NSString *)rechangeAmount;
//4.112支付宝充值同步返回（1451）
- (NSMutableData *)reAlipayReturn:(NSString *)reInfor;
//4.22 充值（1125）
- (NSMutableData *)reRechange:(int)iOperator card:(NSString *)card cardSecret:(NSString *)cardSecret rechangeAmount:(NSString *)rechangeAmount YHMCode:(NSString *)code;
//4.15 彩视通充值卡充值(1118) 
- (NSMutableData *)reCaiShiTong:(int)iOperator card:(NSString *)card cardSecret:(NSString *)cardSecret;
//4.78 提现请求（新）（1417）
- (NSMutableData *)reWithdrawalsRequest:(NSString *)name code:(NSString *)code amount:(NSString *)amount bankId:(NSString *)bankId bankAddr:(NSString *)bankAddr city:(NSString *)city bankName:(NSString *)bankName bankNumber:(NSString *)bankNumber numberAgain:(NSString *)numberAgain;
//4.77 获取用户提款资料（新）（1416）
- (NSMutableData *)reGetUserInfor:(NSString *)userName;
//4.117身份证信息绑定及验证（1457）
- (NSMutableData *)reIdBindAndCheck:(NSString *)operType name:(NSString *)name idCode:(NSString *)idCode;
//4.116开户行列表（1456）
- (NSMutableData *)reBankList:(NSString *)bankName provice:(NSString *)provice city:(NSString *)city;
//4.87 投注记录（新）（1426）
//- (NSMutableData *)reBetRecord:(NSString *)lotteryId countOfPage:(int)countOfPage currentPage:(int)currentPage;
// 365
- (NSMutableData *)reBetRecord:(NSString *)lotteryId 
				   countOfPage:(int)countOfPage 
				   currentPage:(int)currentPage
						  name:(NSString *)userId
					   isJiang:(NSString *)isjiang;
//4.88 投注记录明细（新）（1427）
- (NSMutableData *)reBetRecordInfor:(NSString *)programNumber;
//投注站 1027
- (NSMutableData *)reBetRecordInfor:(NSString *)programNumber Issue:(NSString *)issue numberOfPage:(int)num Page:(int)page IsJIangli:(NSString *)isJiangli;

//4.118单式上传投注号码（1461）
- (NSMutableData *)reDanBetNumber:(NSString *)programAddress countOfPage:(int)countOfPage currentPage:(int)currentPage;
//4.89 追号列表（新）（1428）
- (NSMutableData *)reChaseNumberList:(int)lotteryId state:(int)state isRecord:(int)isRecord startTime:(NSString *)startTime endTime:(NSString *)endTime countOfPage:(int)countOfPage curPage:(int)curPage;
//4.90 追号明细（新）（1429）
- (NSMutableData *)reChaseDetailInfor:(NSString *)programNum;
//4.118追号-追号撤单（1458）（福彩、体彩、足彩）
- (NSMutableData *)reChaseCancle:(NSString *)programNum buyType:(NSString *)buyType;
//4.94 定制跟单搜索（新）（1433）
- (NSMutableData *)reCustomizedSigSearch:(NSString *)userName;
//4.97 我定制的人（新）（1436）
- (NSMutableData *)reMyCustomizedSingle:(int)countOfPage page:(int)page;
//4.101 定制我的人（新）（1440）
- (NSMutableData *)reCustomizedMe:(int)countOfPage currentPage:(int)currentPage;
//4.119定制我的人明细（新）（1462）
- (NSMutableData *)reCusMeDetial:(NSString *)lotteryId countOfPage:(int)countOfPage currentPage:(int)currentPage;
//4.120定制我的人明细（新）（1463）
- (NSMutableData *)reCusMeDetilRecord:(NSString *)lotteryId buyPerson:(NSString *)buyPerson countOfPage:(int)countOfPage currentPage:(int)currentPage;
//4.106 推荐（新）（1445）
- (NSMutableData *)reRecommendation:(NSString *)lotteryType countOfPage:(int)countOfPage;
//4.102 人气定制排行榜（新）（1441）
- (NSMutableData *)rePopularCusList:(int)recordNum;
//4.105	在售的发起方案（新）（1444）
- (NSMutableData *)reSaleLauPro:(NSString *)userName gameName:(NSString *)gameName buyType:(NSString *)buyType pageSize:(int)pageSize currentPage:(int)currentPage;
//4.104 在售的跟单方案（新）（1443）
- (NSMutableData *)reSaleSigPro:(NSString *)userName gameName:(NSString *)gameName buyType:(NSString *)buyType pageSize:(int)pageSize currentPage:(int)currentPage;
//4.95 大奖战绩（新）（1434）
- (NSMutableData *)reAwardsRecord:(NSString *)userName lotteryType:(int)lotteryType;
//4.96 盈利统计（新）（1435）
- (NSMutableData *)reEarningsStatistics:(NSString *)userName startTime:(NSString *)startTime endTime:(NSString *)endTime currentPage:(int)currentPage countOfPage:(int)countOfPage;
//4.98 定制编辑查询（新）（1437）
- (NSMutableData *)reCustomEdit:(NSString *)promoters lotteryId:(NSString *)lotteryId;
//4.99 定制编辑保存（新）（1438）
- (NSMutableData *)reCustomSave:(NSString *)attUid lotteryId:(NSString *)lotteryId customRelation:(int)customRelation sigProAmount:(NSString *)sigProAmount caps:(NSString *)caps isSubscribe:(int)isSubscribe customOrder:(int)customOrder orderNum:(int)orderNum amountGuarantee:(NSString *)amountGuarantee;
//4.100 定制删除（新）（1439）
- (NSMutableData *)reCustomDelete:(NSString *)attUid lotteryId:(NSString *)lotteryId;

- (NSMutableData *)reqGetIssueList:(int)lotteryId count:(int)count;
- (NSMutableData *)reqGetFootballMatch:(int)lotteryId issue:(NSString *)issue;

// 4.109获取竞彩，北单期数（新）（1448）
-(NSMutableData*)reqJingCaiIssue:(int)lotteryId;
//4.91	竞彩单场赛事列表（新）（1430）
-(NSMutableData*)reqJingcaiMatch:(int)lottery wanfa:(int)wanfa;

// 4.53	合买-发起合买（1240）（福彩、体彩、足彩）
- (NSMutableData*)reqStartTogetherBuy:(GC_BetInfo *)_betInfo Resend:(NSInteger)sendNum;
- (NSMutableData *)reqBuyTogether:(NSString *)lottery schemeNumber:(int)schemeNumber buyCount:(int)buyCount amount:(int)amount reSend:(NSInteger)resendNum;

// 4.114 足彩、竞彩对阵查询（新）（1454）
- (NSMutableData *)reqGetZucaiJingcaiMatch:(int)lotteryType issue:(NSString *)issue isStop:(NSString *)isstop match:(NSString *)match;
// 4.115 获取足彩竞彩，北单期数（新）（1455）
- (NSMutableData *)reqGetZucaiJingcaiIssueList:(int)lotteryId;

// 4.27	获取广告 (1130)
- (NSMutableData *)reqGetAdvertisement;

//4.48	竞彩-投注-1226
- (NSMutableData*)reqJingcaiBetting:(NSString*)key baomi:(NSInteger)baomi danfushi:(NSInteger)danfushi betData:(GC_BetInfo *)_betInfo;

// 4.121 获取合买方案详情投注内容
- (NSMutableData *)reqGetBTLotteryNumber:(int)schemeNumber issue:(NSString*)issue lotteryType:(NSString*)lotteryType;

//4.129 现金流水
- (NSMutableData *)reqGetXianJinLiuShuitiaoshu:(int)tiaoshu page:(int)page;

//4.136 系统时间
- (NSMutableData *)reqReturnSysTime;
//4.1 版本检测（1101）
- (NSMutableData *)reqVersionCheck;


//4.137 获取预测奖金
- (NSMutableData *)reqGetIssueInfo:(NSString *)changciInfo cishu:(NSInteger)cishu fangshi:(NSString *)fangshi shedan:(NSString *)shedan beishu:(NSInteger)beishu touzhuxuanxiang:(NSString *)touzhuxuanxiang lottrey:(NSString *)lottery  play:(NSString * )play;

//4.138 胜负彩 过关统计
- (NSMutableData *)reqGuoGuanTongJiUserName:(NSString *)username caizhong:(NSString *)caizhong issue:(NSString *)issue wanfa:(NSString *)wanfa meiyejilushu:(NSInteger)tiaoshu dangqianye:(NSInteger)page;

//4.140合买列表
- (NSMutableData *)HMreqBuyTogetherData:(NSString *)lotteryType issue:(NSString *)issue amountType:(UInt16)amountType baodi:(UInt16)baodi eachMoney:(UInt16)eachMoney isFull:(UInt16)isFull speed:(UInt16)speed recordCount:(UInt16)recordCount page:(int)page schemeType:(UInt16)schemeType sortWay:(NSString *)sortWay;

//查询某人合买
- (NSMutableData *)reHemaiWithLottery:(NSString *)lotteryId 
						  countOfPage:(int)countOfPage 
						  currentPage:(int)currentPage
								 name:(NSString *)userId;

//4.144 往期开奖号码查询
- (NSMutableData *)reWangqiWithLottery:(NSString *)lotteryId 
						  countOfPage:(int)countOfPage;

//4.143 中奖及投注消息

- (NSMutableData *)reZhongjiangWithLottery:(NSString *)lotteryId 
									   iss:(NSString *)iss
							   countOfPage:(int)countOfPage;

//北京单场对阵信息
- (NSMutableData *)reBeiJingDanChangLotteryType:(NSInteger)lotteryType wanfa:(NSInteger)wanfa isStop:(NSString *)isstop match:(NSString *)match issue:(NSString *)issue;

//奥运彩票期次获取
- (NSMutableData *)YaoYunQiCiWanFa:(NSString *)wanfa;
//奥运胜负对阵
- (NSMutableData *)yaoyunDuiZhenIssue:(NSString *)issue;

// 奥运金银铜和第一名
- (NSMutableData *)AoYunDiyiAndJinyin:(NSString *)wanfa Issue:(NSString *)issue;

//4.148 过关统计信息
- (NSMutableData *)guoGuanXinXiCaiZhong:(NSString *)caizhong issue:(NSString *)issue fenzhong:(NSString *)fenzhong;

//奖池查询
- (NSMutableData *)JiangChi:(NSString *)caizhong other:(NSString *)other;

//活跃界面
- (NSMutableData *)huoYueJieMianInfo;

//跟单用户
- (NSMutableData *)getGenDanPersonWith:(NSString *)FanganHao 
                               PageNum:(NSInteger)Num 
                               OnePage:(NSInteger)onePage
                                 other:(NSString *)other;


//北单期号
- (NSMutableData *)beiDanreqGetZucaiJingcaiIssueList:(int)lotteryId;
//北单对阵
- (NSMutableData *)beiDanreqGetZucaiJingcaiMatch:(int)lotteryType issue:(NSString *)issue isStop:(NSString *)isstop match:(NSString *)match;
//获取预测奖金（抄单）
- (NSMutableData *)chaoDanYuJiChangCi:(NSString *)changciInfo guoGuanCiShu:(NSInteger)cishu fangShi:(NSString *)fangshi sheDanChangCi:(NSString *)danchangci beishu:(NSInteger)beishu touzhuxuanxiang:(NSString *)xuanxiang caizhong:(NSInteger)caizhong wanfa:(NSInteger)wanfa issue:(NSString *)issue;

//获取session
- (NSMutableData *)getSessionByUserName:(NSString *)userName;

//4.141判断是否是当前期次
- (NSMutableData *)panDuanDangQianQiIssue:(NSString *)issues caizhong:(NSString *)caiz ;

//4.143获取追号期数（新）（1563）
- (NSMutableData *)huoQuQiHaoLotteryId:(NSString *)lotid shuliang:(NSInteger)countlot;

//4.146 试机号
- (NSMutableData *)getShiJiHaoByCaiZhong:(NSString *)lotteryId issue:(NSString *)issue Other:(NSString *)other;
- (NSMutableData *)zhuihaoreqBuyLotteryData:(GC_BetInfo *)_betInfo;

//4.148完善用户信息并赠送奖金
- (NSMutableData *)wanShanUseridcard:(NSString *)idcard userid:(NSString *)uid trueName:(NSString *)name mobile:(NSString *)mobile;

//4.152 保存好声音
- (NSMutableData *)SaveGoodVoiceWithOrderId:(NSString *)orderid Type:(NSInteger)type Data:(NSData *)data Time:(NSInteger)time UserName:(NSString *)username Other:(NSString *)other;

//4.153 下载好声音接口
- (NSMutableData *)DownLoadGoodVoiceWithOrderId:(NSString *)orderid Other:(NSString *)other;

//4.154 赞好声音接口
- (NSMutableData *)ZanGoodVoiceWithOrderId:(NSString *)orderid VocieID:(NSString *)voiceid UserName:(NSString *)username Other:(NSString *)other;

//4.155 修改方案保密类型  （1575）
- (NSMutableData *)EditBaomiWithOrderId:(NSString *)orderid UserName:(NSString *)username Baomi:(NSString *)baomi XuanYan:(NSString *)xuanyan Other:(NSString *)other;

//4.161获取可追号最大期数（新）（1581）
- (NSMutableData *)maxIssueLotteryId:(NSString *)lotterId;


//领取奖励
- (NSMutableData *)LingQuJiangLi:(NSString *)lotteryId
				   countOfPage:(int)countOfPage
				   currentPage:(int)currentPage
						  name:(NSString *)userId isJiang:(NSString *)isjiang JiaJiang:(NSString *)jiajiang;


//4.159 领取奖励接口 （1579）
- (NSMutableData *)getJiangLiWithOrderId:(NSString *)orderid NickName:(NSString *)nickname Other:(NSString *)other;

//彩种信息接口1583
- (NSMutableData *)getCaiZhongInfo:(NSString *)lotteryID;

//4.56	合买-合买撤单（1243）
- (NSMutableData *)ChedanByFananID:(NSString *)fananID;

//1.22	TCL银联无卡支付

- (NSMutableData *)upmpMoney:(NSString * )money userName:(NSString *)name YHMCode:(NSString *)code;

// 2.111 支付宝充值
- (NSMutableData *)ZhiFuBaoMoney:(NSString * )money userName:(NSString *)name YHMCode:(NSString *)code;

//1.72 奖金优化
- (NSMutableData *)JJYHWithBetInfo:(GC_BetInfo *)_betInfo Type:(NSInteger) type;

//1.73	推广短信设置（1589）

- (NSMutableData *)TGDXSZWithUserName:(NSString *)username type:(NSString *)type operateType:(NSString *)operate;

//1.76	充值列表顺序  （1592）
-(NSMutableData *)rechargeSequence;

//1.78	我的追号记录（1594）
- (NSMutableData *)myLotteryZhuiHaoWithCount:(NSString *)count page:(NSString *)page userName:(NSString *)user;
//1.79	追号明细（1595）
- (NSMutableData *)ZhuihaoInfoWithID:(NSString *)infoID showType:(NSInteger)type count:(NSInteger)count page:(NSInteger)page;
//1.80	追号、合买撤单（1596）
- (NSMutableData *)chedanWithID:(NSString *)fanganid type:(NSInteger)type;

//第三方浏览器打开调用方法
- (NSURL *)changeURLToTheOther:(NSURL *)oldURL;

//连连支付
- (NSMutableData *)reqLianlianYintong:(NSString *)money YHMCode:(NSString *)code;

//4.19	联动优势  信用卡快捷支付 （1562）
- (NSMutableData *)umpayMoney:(NSString * )money YHMCode:(NSString *)code;

//4.91	彩金宝年化收益接口 （1605）
- (NSMutableData *)yearEarningsWithUserName:(NSString *)userName;

//4.92	彩金宝收益详情 （1606）

- (NSMutableData *)earningsInfoWithUserName:(NSString *)userName date:(NSInteger)countDate;

//1.85 中奖名单（1600)

- (NSMutableData *)ZhongJiangMingDan:(NSInteger)pageNum PageCount:(NSInteger)pageCount;

//1.86	用户积分主界面（1601）
- (NSMutableData *)chouCiShuWithUserId:(NSString *)userid;

//1.83 抽奖 (1598)

- (NSMutableData *)choujiangWithUserId:(NSString *)userid;

//4.96 积分详情 (1610)

- (NSMutableData *)pointMessageWithUserID:(NSString *)userName andcurPage:(NSInteger)page pageCount:(NSInteger)pagecount;


//4.94	冠军、冠亚军玩法赛程（1608）
- (NSMutableData *)championWithLotteryId:(NSString *)lottery;

//1.87	用户中奖领取地址（1602）
- (NSMutableData *)ZhongJiangDiZhiWithUserId:(NSString *)userid Name:(NSString *)name Mobile:(NSString *)mobile Addreas:(NSString *)addreas YouBian:(NSString *)youbian Other:(NSString *)other;

//4.99 积分兑换彩金 (1612)
-(NSMutableData *)pointDuiHuanCaiJinWithUserName:(NSString *)username andCaiJin:(NSString *)caijin point:(NSString *)point;

//4.98 可兑换彩金项 (1611)
-(NSMutableData *)canExchangeWithType:(NSString *)_type;

// 4.101 微信充值 （1616）
- (NSMutableData *)reqWeiXinChongZhi:(NSString *)money withYHMCode:(NSString *)code;

- (NSMutableData *)bigHunToureqGetIssueInfo:(NSString *)changciInfo cishu:(NSInteger)cishu fangshi:(NSString *)fangshi shedan:(NSString *)shedan beishu:(NSInteger)beishu touzhuInfo:(NSString *)touzhuxuanxiang lottery:(NSString *)lottery play:(NSString * )play ddInfo:(NSString * )ddInfo ddpvInfo:(NSString *)ddpvInfo;

//4.106 查询用户银行卡信息 (1620)
- (NSMutableData *)getUserBankCardList;

//4.105 银联回拨是否成功   (1619)
- (NSMutableData *)yinLianBackIsSucc;

//4.107 添加提现银行卡    (1621)
- (NSMutableData *)addBankCardWithTrueName:(NSString *)_trueName idCard:(NSString *)_idCard bankNum:(NSString *)_banknum bankPro:(NSString *)_pro bankCity:(NSString *)_city bankID:(NSString *)_bankid bankAllName:(NSString *)_bankname;

//4.108  设置默认银行卡  (1622)
- (NSMutableData *)setDefaultBankCardWithBankID:(NSString *)_bankid;


//4.109  用户防沉迷状态信息 (1623)
- (NSMutableData *)getUSerFangChenMiMessage;

//4.113	手机QQ钱包支付
- (NSMutableData *)reqQQpay:(NSString *)money withYHMCode:(NSString *)code;
//4.120 充值订单是否成功
- (NSMutableData *)reqPrepaidOrder:(NSString *)orderNum;
//4.122 获取用户优惠码(1635)
- (NSMutableData *)reqGetUserYHMListStatus:(NSString *)status pageNum:(NSInteger)pagenum pageCount:(NSInteger)pagecount;
//4.124 我的奖品包(1638)
- (NSMutableData *)req_GetMyPrizeMes:(NSString *)username pageNum:(NSInteger)pagenum pageSize:(NSInteger)pagesize;
//4.123积分兑换优惠码 （1637）
- (NSMutableData *)req_pointExChangeYHM:(NSString *)userName withCode:(NSString *)code;
//4.123使用优惠码 (1636)
- (NSMutableData *)req_useYHMWithOrderNum:(NSString *)order YHMCode:(NSString *)code;

//4.126	 Pk赛积分投注（1640）
- (NSMutableData *)reqJiFenBuyJiFenInfo:(JiFenBetInfo *)jiFenInfo;

//4.125 Pk赛赛程（1639）
-(NSMutableData *)req_GetPKList:(NSString *)qici;
//4.127	Pk赛投注记录（1641）
-(NSMutableData *)req_GetPKMyRecordUser:(NSString *)username recordType:(NSString *)type caizhongId:(NSString *)caiId pageNum:(NSInteger)pagenum pageCount:(NSInteger)pagecount;
//4.129 Pk赛排行榜（1643）
-(NSMutableData *)req_GetPKRanking:(NSString *)type caizhongId:(NSString *)caiId qici:(NSString *)qici;
//4.128	Pk赛积方案详情（1642）
-(NSMutableData *)req_GetPKDetail:(NSString *)code;
//4.130  Pk赛报名参赛（1644）
-(NSMutableData *)req_GetPKBaomingCansai;
//4.131	Pk赛期次（1645）
-(NSMutableData *)req_GetPKQiciCaizhong:(NSString *)caizhong;

// 4.24 焦点赛事对阵查询（1664）
-(NSMutableData*)getFocusMatch;

@end

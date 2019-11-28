//
//  GC_LotteryType.h
//  Lottery
//
//  Created by Kiefer on 11-12-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define four @"4"

typedef enum {
	TYPE_SHUANGSEQIU = 1,
	TYPE_3D = 2,
	TYPE_7LECAI = 3,
	TYPE_DALETOU = 4,
	TYPE_PAILIE3 = 5,
	TYPE_PAILIE5 = 6,
	TYPE_QIXINGCAI = 7,
	TYPE_22XUAN5 = 8,
	TYPE_DALETOU_ZHUIJIA = 10,
	TYPE_DALETOU_SHENGXIAOLE = 11,
	TYPE_SHISHICAI = 21,
    TYPE_HappyTen = 401,
    TYPE_KuaiSan = 402,  //内蒙古快三
    TYPE_KuaiLePuKe = 403,//快乐扑克
    TYPE_JSKuaiSan = 404,//江苏快三
    TYPE_CQShiShi = 405,//重庆时时彩
    TYPE_HBKuaiSan = 406,//湖北快三
    TYPE_JLKuaiSan = 407,//吉林快三
    TYPE_AHKuaiSan = 408,//安徽快三

    //山东11选5
    TYPE_11XUAN5_1 = 31,
	TYPE_11XUAN5_2 = 32,
	TYPE_11XUAN5_3 = 33,
	TYPE_11XUAN5_4 = 34,
	TYPE_11XUAN5_5 = 35,
	TYPE_11XUAN5_6 = 36,
	TYPE_11XUAN5_7 = 37,
	TYPE_11XUAN5_8 = 38,
	TYPE_11XUAN5_Q2ZHI = 39,
	TYPE_11XUAN5_Q3ZHI = 40,
	TYPE_11XUAN5_Q2ZU = 41,
	TYPE_11XUAN5_Q3ZU = 42,
    TYPE_11XUAN5_R2DaTuo = 43,
    TYPE_11XUAN5_R3DaTuo = 44,
    TYPE_11XUAN5_R4DaTuo = 45,
    TYPE_11XUAN5_R5DaTuo = 46,
    TYPE_11XUAN5_Q2DaTuo = 47,
    TYPE_11XUAN5_Q3DaTuo = 48,
    
    TYPE_ZC_SHENGFUCAI = 13,
	TYPE_ZC_RENXUAN9 = 14,
	TYPE_ZC_BANQUANCHANG = 15,
	TYPE_ZC_JINQIUCAI = 16,
    
	TYPE_JINGCAI_ZQ_1 = 22,
	TYPE_JINGCAI_ZQ_2 = 23,
	TYPE_JINGCAI_ZQ_3 = 24,
	TYPE_JINGCAI_ZQ_4 = 25,
    
	TYPE_JINGCAI_LQ_1 = 26, // 竞彩篮球胜负
	TYPE_JINGCAI_LQ_2 = 27, // 竞彩篮球让分胜负
	TYPE_JINGCAI_LQ_3 = 28, // 竞彩篮球胜分差
	TYPE_JINGCAI_LQ_4 = 29, // 竞彩篮球大小分
    
    TYPE_BJDC_SPF = 200, // 单场胜平负
	TYPE_BJDC_SXP = 210, // 单场上下盘单双
    TYPE_BJDC_ZJQ = 230, // 单场总进球数
    TYPE_BJDC_BQC = 240, // 单场半全场胜平负
    TYPE_BJDC_BF = 250, // 单场比分
    TYPE_BJDC_SFGG = 270, // 单场胜负过关
    
    
    TYPE_11XUAN5 = 100, // 11选5 总类别
    TYPE_HAPPY8 = 101, // 快乐8 总类别
	TYPE_PK10 = 102, // PK10 总类别
//    TYPE_ZC = 103, // 足彩 总类别
//    TYPE_JINGCAI = 104, // 竞彩 总类别
	TYPE_JINGCAI_LQ = 105, // 竞彩篮球 总类别
	TYPE_JINGCAI_ZQ = 106, // 竞彩足球 总类别
    TYPE_JINGCAI_HUNTOU = 2222,//竞彩混投
    TYPE_LANQIU_HUNTOU = 2223,//篮球混投
    TYPE_BJDC = 107, // 北京单场 总类别
    TYPE_SHENGGU_HEMAI = 108, // 足彩合买大厅 总类别

	TYPE_FUCAI = 109, // 福彩
	TYPE_TICAI = 110, // 体彩
	TYPE_GPC = 111, // 高频彩
	TYPE_DFC = 112, // 地方彩
    
	TYPE_HAPPY8_XUAN1 = 51, // 快乐8选1
	TYPE_HAPPY8_XUAN2 = 52, // 快乐8选2
	TYPE_HAPPY8_XUAN3 = 53, // 快乐8选3
	TYPE_HAPPY8_XUAN4 = 54, // 快乐8选4
	TYPE_HAPPY8_XUAN5 = 55, // 快乐8选5
	TYPE_HAPPY8_XUAN6 = 56, // 快乐8选6
	TYPE_HAPPY8_XUAN7 = 57, // 快乐8选7
	TYPE_HAPPY8_XUAN8 = 58, // 快乐8选8
	TYPE_HAPPY8_XUAN9 = 59, // 快乐8选9
	TYPE_HAPPY8_XUAN10 = 60, // 快乐8选10
    
	TYPE_PK10_PUTONGXUAN1 = 61, // PK10普通选1
	TYPE_PK10_PUTONGXUAN2 = 62, // PK10普通选2
	TYPE_PK10_PUTONGXUAN3 = 63, // PK10普通选3
	TYPE_PK10_PUTONGXUAN4 = 64, // PK10普通选4
	TYPE_PK10_PUTONGXUAN5 = 65, // PK10普通选5
	TYPE_PK10_PUTONGXUAN6 = 66, // PK10普通选6
	TYPE_PK10_PUTONGXUAN7 = 67, // PK10普通选7
	TYPE_PK10_PUTONGXUAN8 = 68, // PK10普通选8
	TYPE_PK10_PUTONGXUAN9 = 69, // PK10普通选9
	TYPE_PK10_PUTONGXUAN10 = 70, // PK10普通选10
	TYPE_PK10_JINGQUEXUAN2 = 72, // PK10精确选2
	TYPE_PK10_JINGQUEXUAN3 = 73, // PK10精确选3
	TYPE_PK10_JINGQUEXUAN4 = 74, // PK10精确选4
    
    //广东11选5
    TYPE_GD11XUAN5_1 = 1031,
	TYPE_GD11XUAN5_2 = 1032,
	TYPE_GD11XUAN5_3 = 1033,
	TYPE_GD11XUAN5_4 = 1034,
	TYPE_GD11XUAN5_5 = 1035,
	TYPE_GD11XUAN5_6 = 1036,
	TYPE_GD11XUAN5_7 = 1037,
	TYPE_GD11XUAN5_8 = 1038,
	TYPE_GD11XUAN5_Q2ZHI = 1039,
	TYPE_GD11XUAN5_Q3ZHI = 1040,
	TYPE_GD11XUAN5_Q2ZU = 1041,
	TYPE_GD11XUAN5_Q3ZU = 1042,
    TYPE_GD11XUAN5_R2DaTuo = 1043,
    TYPE_GD11XUAN5_R3DaTuo = 1044,
    TYPE_GD11XUAN5_R4DaTuo = 1045,
    TYPE_GD11XUAN5_R5DaTuo = 1046,
    TYPE_GD11XUAN5_Q2DaTuo = 1047,
    TYPE_GD11XUAN5_Q3DaTuo = 1048,
    
    //江西11选5
    TYPE_JX11XUAN5_1 = 2031,
    TYPE_JX11XUAN5_2 = 2032,
    TYPE_JX11XUAN5_3 = 2033,
    TYPE_JX11XUAN5_4 = 2034,
    TYPE_JX11XUAN5_5 = 2035,
    TYPE_JX11XUAN5_6 = 2036,
    TYPE_JX11XUAN5_7 = 2037,
    TYPE_JX11XUAN5_8 = 2038,
    TYPE_JX11XUAN5_Q2ZHI = 2039,
    TYPE_JX11XUAN5_Q3ZHI = 2040,
    TYPE_JX11XUAN5_Q2ZU = 2041,
    TYPE_JX11XUAN5_Q3ZU = 2042,
    TYPE_JX11XUAN5_R2DaTuo = 2043,
    TYPE_JX11XUAN5_R3DaTuo = 2044,
    TYPE_JX11XUAN5_R4DaTuo = 2045,
    TYPE_JX11XUAN5_R5DaTuo = 2046,
    TYPE_JX11XUAN5_Q2DaTuo = 2047,
    TYPE_JX11XUAN5_Q3DaTuo = 2048,
    
    //河北11选5
    TYPE_HB11XUAN5_1 = 3031,
    TYPE_HB11XUAN5_2 = 3032,
    TYPE_HB11XUAN5_3 = 3033,
    TYPE_HB11XUAN5_4 = 3034,
    TYPE_HB11XUAN5_5 = 3035,
    TYPE_HB11XUAN5_6 = 3036,
    TYPE_HB11XUAN5_7 = 3037,
    TYPE_HB11XUAN5_8 = 3038,
    TYPE_HB11XUAN5_Q2ZHI = 3039,
    TYPE_HB11XUAN5_Q3ZHI = 3040,
    TYPE_HB11XUAN5_Q2ZU = 3041,
    TYPE_HB11XUAN5_Q3ZU = 3042,
    TYPE_HB11XUAN5_R2DaTuo = 3043,
    TYPE_HB11XUAN5_R3DaTuo = 3044,
    TYPE_HB11XUAN5_R4DaTuo = 3045,
    TYPE_HB11XUAN5_R5DaTuo = 3046,
    TYPE_HB11XUAN5_Q2DaTuo = 3047,
    TYPE_HB11XUAN5_Q3DaTuo = 3048,
    
    //陕西11选5
    TYPE_ShanXi11XUAN5_1 = 4031,
    TYPE_ShanXi11XUAN5_2 = 4032,
    TYPE_ShanXi11XUAN5_3 = 4033,
    TYPE_ShanXi11XUAN5_4 = 4034,
    TYPE_ShanXi11XUAN5_5 = 4035,
    TYPE_ShanXi11XUAN5_6 = 4036,
    TYPE_ShanXi11XUAN5_7 = 4037,
    TYPE_ShanXi11XUAN5_8 = 4038,
    TYPE_ShanXi11XUAN5_Q2ZHI = 4039,
    TYPE_ShanXi11XUAN5_Q3ZHI = 4040,
    TYPE_ShanXi11XUAN5_Q2ZU = 4041,
    TYPE_ShanXi11XUAN5_Q3ZU = 4042,
    TYPE_ShanXi11XUAN5_R2DaTuo = 4043,
    TYPE_ShanXi11XUAN5_R3DaTuo = 4044,
    TYPE_ShanXi11XUAN5_R4DaTuo = 4045,
    TYPE_ShanXi11XUAN5_R5DaTuo = 4046,
    TYPE_ShanXi11XUAN5_Q2DaTuo = 4047,
    TYPE_ShanXi11XUAN5_Q3DaTuo = 4048,
    
    TYPE_AGREEMENT = 10000, //用户协议
    TYPE_CAIZHONG9 = 301,
    TYPE_CAIZHONG14 = 300,
    
    TYPE_UNSUPPT =  99999//暂不支持的彩种
} LotteryTYPE;

typedef enum {
    // 双色球
    Shuangseqiudanshi = 0, // 双色球单式
    Shuangseqiufushi = 43, // 双色球复式
    Shuangseqiudantuo = 3, // 双色球胆拖
    
    // 大乐透
    Daletoudanshi = 0, // 大乐透单式
    Daletoufushi = 1, // 大乐透复式
    Daletoudantuo = 2, // 大乐透胆拖
    
    // 排列3
    Array3zhixuandanshi = 0, // 直选单式
    Array3zhixuanfushi = 1, // 直选复式
    Array3zhixuanzuhe = 7, // 直选组合
    Array3zuhedantuo = 8, // 组合胆拖
    Array3zuxuandanshi = 3, // 组选单式
    Array3zusandanshi = 503, // 组三单式
	Array3zusanfushi = 5, // 组三复式
	Array3zusandantuo = 9, // 组三胆拖
    Array3zuliudanshi = 504, // 组六单式
	Array3zuliufushi = 4, // 组六复式
	Array3zuliudantuo = 10, // 组六胆拖
            //姚福玉添加组三组六直选和值
    Array3zhixuanHezhi = 11,//直选和值
    Array3zusanHezhi = 12,//组三和值
    Array3zuliuHezhi = 13,//组六和值
    
    // 七乐彩
    Qilecaidanshi = 0, // 单式
	Qilecaifushi = 441, // 复式
	Qilecaidantuo = 442, // 胆拖
	Qilecaifushidantuo = 44, // 复式/胆拖
    
    // 福彩3D
    ThreeDzhixuandanshi = 1, // 直选单式
    ThreeDzhixuanfushi = 12, // 直选复式
    ThreeDzhixuandantuo = 94, // 直选胆拖
    ThreeDzhixuanhezhi = 95,//直选和值
    ThreeDzusandanshi = 3, // 组三单式
    ThreeDzusanfushi = 98, // 组三复式
    ThreeDzuliudanshi = 5, // 组六单式
	ThreeDzuliufushi = 99, // 组六复式
    //姚福玉添加
    ThreeDzusanHezhi = 100,// 组三和值
    ThreeDzuliuHezhi = 101,// 组六和值
    ThreeDzusanDantuo = 102,//组三胆拖
    ThreeDzuliuDantuo = 103,//组六胆拖
    
    
    // 排列5 七星彩 22选5 足彩
    danshi = 0, 
    fushi = 1, 
    
    // 时时彩 和重庆时时彩共用
    SSCdaxiaodanshuang = 20, // 大小单双
	SSCyixingdanshi = 11, // 一星单式
	SSCerxingdanshi = 12, // 二星单式
	SSCsanxingdanshi = 13, // 三星单式
	SSCsixingdanshi = 14, // 四星单式
	SSCwuxingdanshi = 15, // 五星单式
	SSCyixingfushi = 31, // 一星复式
	SSCerxingfushi = 32, // 二星复式
	SSCsanxingfushi = 33, // 三星复式
	SSCsixingfushi = 34, // 四星复式
	SSCwuxingfushi = 35, // 五星复式
	SSCerxingfuxuan = 22, // 二星复选
	SSCsanxingfuxuan = 23, // 三星复选
	SSCsixingfuxuan = 24, // 四星复选
	SSCwuxingfuxuan = 25, // 五星复选
	SSCerxingzuxuan = 40, // 二星组选
	SSCerxingzuxuandantuo = 50, // 二星组选胆拖
	SSCwuxingtongxuan = 45, // 五星通选
    SSCrenxuanyi = 60,//任选一新加玩法
    SSCrenxuaner = 61,//任选一新加玩法
    SSCrenxuansan = 62,//任选一新加玩法
    
    // 快乐10分 姚福玉添加，买彩票中没有，只是为了格式统一
    HappyTen1Shu = 101,
    HappyTen1Hong = 102,
    HappyTenRen2 = 103,
    HappyTenRen2Zhi = 104,
    HappyTenRen2Zu = 105,
    HappyTenRen3 = 106,
    HappyTenRen3Zhi = 107,
    HappyTenRen3Zu = 108,
    HappyTenRen4 = 109,
    HappyTenRen5 = 110,
    HappyTenDa = 111,
    HappyTenDan = 112,
    HappyTenQuan = 113,
    HappyTenRen2DanTuo = 114,
    HappyTenRen3DanTuo = 115,
    HappyTenRen4DanTuo = 116,
    HappyTenRen5DanTuo = 117,
    HappyTenRen2ZuDanTuo = 118,
    HappyTenRen3ZuDanTuo = 119,

    
    //快三  姚福玉添加，买彩票中没有，只是为了格式统一  内蒙古、江苏共用
    KuaiSanHezhi = 131,
    KuaiSanSantongTong = 132,
    KuaiSanSantongDan = 133,
    KuaiSanErtongDan = 134,
    KuaiSanErTongFu = 135,
    KuaiSanSanBuTong = 136,
    KuaiSanErButong = 137,
    KuaiSanSanLianTong =138,
    KuaiSanSanBuTongDanTuo = 139,
    KuaiSanErBuTongDanTuo = 140,
    
    //快乐扑克 姚福玉,买彩票中没有，只是为了格式统一
    KuaiLePuKeRen1 = 161,//任选1
    KuaiLePuKeRen2 = 162,//任选2
    KuaiLePuKeRen3 = 163,//任选3
    KuaiLePuKeRen4 = 164,//任选4
    KuaiLePuKeRen5 = 165,//任选5
    KuaiLePuKeRen6 = 166,//任选6
    KuaiLePuKeTongHua = 167,//同花
    KuaiLePuKeTongHuaShun = 168,//同花顺
    KuaiLePuKeShunZi = 169,//顺子
    KuaiLePuKeBaoZi = 170,//豹子
    KuaiLePuKeDuiZi = 171,//对子
    
	//PK10
    PK10putongxuandanshi = 1, // 普通选单式
	PK10putongxuanfushi = 0, // 普通选复式
	PK10jingquexuandanshi = 2, // 精确选单式
	PK10jingquexuanfushi = 3, // 精确选复式
	
	//快乐8
	HAPPY8putongxuandanshi = 1, //单式
	HAPPY8putongxuanfushi = 2, //复式
	
	//11选5
	M11XUAN5danshi = 0, //单式
	M11XUAN5fushi = 1, //复式
	M11XUAN5dingwei = 3, //定位
    M11XUAN5dantuo = 2, //胆拖
    
    ModeTYPE_UNSUPPOT = 99999//暂不支持的玩法
} ModeTYPE;

@interface GC_LotteryType : NSObject 
{
    
}

+ (BOOL)isJiXuan:(LotteryTYPE)lotteryType modeType:(ModeTYPE)modeType;
+ (BOOL)is11xuan5:(LotteryTYPE)_lotteryType;
+ (BOOL)isHappy8:(LotteryTYPE)_lotteryType;
+ (BOOL)isPK10:(LotteryTYPE)_lotteryType;
+ (BOOL)isGaopincai:(LotteryTYPE)_lotteryType;
+ (BOOL)isZucai:(LotteryTYPE)_lotteryType;
+ (BOOL)isJingcai:(LotteryTYPE)_lotteryType;
+ (NSString *)logoImageName:(LotteryTYPE)type;
+ (NSString *)logoNameWithLotteryID:(NSString *)lotteryID;
+ (NSString *)logoTextWithLotteryID:(NSString *)lotteryID;
+ (NSString *)wanfaNameWithLotteryID:(NSString *)lotteryID WanFaId:(NSString *)wanfa;
+ (NSString *)lotteryNameWithLotteryID:(NSString *)lotteryID;
+ (LotteryTYPE)lotteryTypeWithLotteryID:(NSString *)lotteryID Wanfa:(NSString *)wanfa;
+ (NSString *)lotteryIDWithLotteryType:(LotteryTYPE)lotteryType;
+ (NSString *)lotteryNameWithLotteryType:(LotteryTYPE)lotteryType;
+ (NSString *)changeLotteryTYPEToWanfa:(LotteryTYPE)_lotteryType modeType:(ModeTYPE)_modeType;
+ (ModeTYPE ) changeWanfaToModeTYPE:(NSString *)caizhong Wanfa:(NSString *)wanfa;
+ (LotteryTYPE) shiyixuanwuChangeWanfaToLotteryType:(NSString *)caizhong Wanfa:(NSString *)wanfa;

@end

//
//  LotteryType.m
//  Lottery
//
//  Created by Kiefer on 11-12-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_LotteryType.h"
#import "SharedDefine.h"

@implementation GC_LotteryType

/**彩种编号
 300 ： 14场胜负彩
 301 ： 任选九
 303 ： 4场进球彩
 302 ： 6场半全场
 400 ： 足球单场
 200 ： 竞彩篮球
 201 ： 竞彩足球
 001 ： 双色球
 002 ： 福彩3D
 009 ： 北京3D
 003 ： 七乐彩
 010 ： 两步彩
 113 ： 超级大乐透
 110 ： 七星彩
 108 ： 排列3
 109 ： 排列5
 111 ： 22选5 
 107 ： 11选5
 119 ： 新11选5
 006 ： 时时彩
 016 ： 快乐8
 017 ： PK拾
 ******/

+ (BOOL)isJiXuan:(LotteryTYPE)lotteryType modeType:(ModeTYPE)modeType
{
    if (lotteryType == TYPE_SHUANGSEQIU&&modeType == Shuangseqiudanshi) {
        return YES;
    } else if (lotteryType == TYPE_DALETOU&&modeType == Daletoudanshi) {
        return YES;
    } else if (lotteryType == TYPE_PAILIE3&&modeType == Array3zhixuandanshi) {
        return YES;
    } else if ((lotteryType == TYPE_PAILIE5||lotteryType == TYPE_QIXINGCAI||lotteryType == TYPE_22XUAN5)&&modeType == danshi) {
        return YES;
    } else if (lotteryType == TYPE_7LECAI&&modeType == Qilecaidanshi) {
        return YES;
    } else if (lotteryType == TYPE_3D&&modeType == ThreeDzhixuandanshi) {
        return YES;
    } else if (lotteryType == TYPE_SHISHICAI) {
        if (modeType == SSCdaxiaodanshuang) {
            return YES;
        } else if (modeType == SSCyixingdanshi) {
            return YES;
        } else if (modeType == SSCerxingdanshi||modeType == SSCerxingfuxuan) {
            return YES;
        } else if (modeType == SSCsanxingdanshi||modeType == SSCsanxingfuxuan) {
            return YES;
        } else if (modeType == SSCsixingdanshi||modeType == SSCsixingfuxuan) {
            return YES;
        } else if (modeType == SSCwuxingdanshi||modeType == SSCwuxingfuxuan||modeType ==SSCwuxingtongxuan) {
            return YES;
        }
    } else if ([GC_LotteryType is11xuan5:lotteryType]&&(modeType == M11XUAN5danshi||modeType == M11XUAN5dingwei)) {
        return YES;
    } else if ([GC_LotteryType isHappy8:lotteryType]&&modeType == HAPPY8putongxuandanshi) {
        return YES;
    } else if ([GC_LotteryType isPK10:lotteryType]&&(modeType == PK10putongxuandanshi||modeType == PK10jingquexuandanshi)) {
        return YES;
    }
    return NO;
}

+ (BOOL)is11xuan5:(LotteryTYPE)_lotteryType
{
    if (_lotteryType == TYPE_11XUAN5||(_lotteryType >= TYPE_11XUAN5_1 && _lotteryType <= TYPE_11XUAN5_Q3DaTuo)) {
        return YES;
    }
    return NO;
}

+ (BOOL)isHappy8:(LotteryTYPE)_lotteryType
{
    if (_lotteryType == TYPE_HAPPY8||(_lotteryType >= TYPE_HAPPY8_XUAN1 && _lotteryType <= TYPE_HAPPY8_XUAN10)) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPK10:(LotteryTYPE)_lotteryType
{
    if (_lotteryType == TYPE_PK10||(_lotteryType >= TYPE_PK10_PUTONGXUAN1 && _lotteryType <= TYPE_PK10_JINGQUEXUAN4)) {
        return YES;
    }
    return NO;
}

+ (BOOL)isGaopincai:(LotteryTYPE)_lotteryType
{
    if (_lotteryType == TYPE_SHISHICAI||[GC_LotteryType is11xuan5:_lotteryType]||[GC_LotteryType isHappy8:_lotteryType]||[GC_LotteryType isPK10:_lotteryType]) {
        return YES;
    }
	return NO;
}

+ (BOOL)isZucai:(LotteryTYPE)_lotteryType
{
	if (_lotteryType == TYPE_ZC_SHENGFUCAI || _lotteryType == TYPE_ZC_RENXUAN9 || _lotteryType == TYPE_ZC_BANQUANCHANG || _lotteryType == TYPE_ZC_JINQIUCAI) {
		return YES;
	}
	return NO;
}

+ (BOOL)isJingcai:(LotteryTYPE)_lotteryType
{    
	if (_lotteryType == TYPE_JINGCAI_ZQ || _lotteryType == TYPE_JINGCAI_ZQ_1 || _lotteryType == TYPE_JINGCAI_ZQ_2 || _lotteryType == TYPE_JINGCAI_ZQ_3 || _lotteryType == TYPE_JINGCAI_ZQ_4 ||
        _lotteryType == TYPE_JINGCAI_LQ || _lotteryType == TYPE_JINGCAI_LQ_1 || _lotteryType == TYPE_JINGCAI_LQ_2 || _lotteryType == TYPE_JINGCAI_LQ_3 || _lotteryType == TYPE_JINGCAI_LQ_4 ) {
		return YES;
	}
	return NO;
}

+ (NSString *)logoImageName:(LotteryTYPE)type
{
    NSString *logoName = @"logo_11xuan5";
    if (type == TYPE_SHUANGSEQIU) {
        logoName = @"logo_shuangseqiu";
    } else if (type == TYPE_3D) {
        logoName = @"logo_3d";
    } else if (type == TYPE_7LECAI) {
        logoName = @"logo_7lecai";
    } else if (type == TYPE_DALETOU || type == TYPE_DALETOU_ZHUIJIA
               || type == TYPE_DALETOU_SHENGXIAOLE) {
        logoName = @"logo_daletou";
    } else if (type == TYPE_PAILIE3) {
        logoName = @"logo_array3";
    } else if (type == TYPE_PAILIE5) {
        logoName = @"logo_array5";
    } else if (type == TYPE_QIXINGCAI) {
        logoName = @"logo_7xingcai";
    } else if (type == TYPE_22XUAN5) {
        logoName = @"logo_22xuan5";
    } else if (type == TYPE_SHISHICAI) {
        logoName = @"logo_shishicai";
    } else if ((type >= TYPE_ZC_SHENGFUCAI && type <= TYPE_ZC_JINQIUCAI) || type == TYPE_SHENGGU_HEMAI) {
        logoName = @"logo_shengfucai";
    } else if ((type >= TYPE_JINGCAI_LQ_1 && type <= TYPE_JINGCAI_LQ_4)
               || type == TYPE_JINGCAI_LQ) {
        logoName = @"logo_jingcai";
    } else if ((type >= TYPE_JINGCAI_ZQ_1 && type <= TYPE_JINGCAI_ZQ_4)
               || type == TYPE_JINGCAI_ZQ) {
        logoName = @"logo_jingcai";
    } else if ((type >= TYPE_BJDC_SPF && type <= TYPE_BJDC_BF)
               || type == TYPE_BJDC) {
        logoName = @"logo_bjdc";
    } else if ((type >= TYPE_11XUAN5_1 && type <= TYPE_11XUAN5_Q3ZU)
               || type == TYPE_11XUAN5) {
        logoName = @"logo_11xuan5";
    } else if ((type >= TYPE_HAPPY8_XUAN1 && type <= TYPE_HAPPY8_XUAN10) || type == TYPE_HAPPY8) {
        logoName = @"logo_happy8";
    } else if ((type >= TYPE_PK10_PUTONGXUAN1 && type <= TYPE_PK10_JINGQUEXUAN4) || type == TYPE_PK10) {
        logoName = @"logo_pk10";
    }
    return logoName;
}

+ (NSString *)logoNameWithLotteryID:(NSString *)lotteryID
{
    return [NSString stringWithFormat:@"lottery_logo_%@", lotteryID];
}

+ (NSString *)logoTextWithLotteryID:(NSString *)lotteryID
{
    return [NSString stringWithFormat:@"lottery_text_%@", lotteryID];
}

+(NSString *)wanfaNameWithLotteryID:(NSString *)lotteryID WanFaId:(NSString *)wanfa {
    if ([@"300" isEqualToString:lotteryID]) {
        return @"胜负彩";
    } else if ([@"301" isEqualToString:lotteryID]) {
        return @"任选九";
    } else if ([@"302" isEqualToString:lotteryID]) {
        return @"半全场";
    } else if ([@"303" isEqualToString:lotteryID]) {
        return @"进球彩";
    } else if ([@"400" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return@"胜平负";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return@"上下盘单双";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return@"总进球";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return@"半全场胜平负";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return@"比分";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return@"胜负过关";
        }
    } else if ([@"200" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"06"]) {
            return@"胜负";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return@"让分胜负";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return@"胜分差";
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return@"大小分";
        }
    } else if ([@"201" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return@"让球胜平负";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return@"比分";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return@"总进球数";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return@"半场胜平负";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return@"冠军";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return@"冠亚军";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return@"一场决胜";
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return@"胜平负";
        }
    }
    else if ([@"202" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"足球混合过关";
        }
    }
    else if ([@"203" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"篮球混合过关";
        }
    }
    else if ([@"011" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"选一数投";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"选一红投";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"选二连组";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"选二连直";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"选三前组";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return @"选三前直";
        }else if ([wanfa isEqualToString:@"07"]) {
            return @"任选二";
        }else if ([wanfa isEqualToString:@"08"]) {
            return @"任选三";
        }else if ([wanfa isEqualToString:@"09"]) {
            return @"任选四";
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return @"任选五";
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return @"猜大数";
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return @"猜单数";
        }
        else if ([wanfa isEqualToString:@"13"]) {
            return @"猜全数";
        }
        
    }
    else if ([@"001" isEqualToString:lotteryID]) {
        
    } else if ([@"002" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"直选";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"组三";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"组六";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return  @"组选";
        }
    } else if ([@"009" isEqualToString:lotteryID]) {
         // 北京3D
        if ([wanfa isEqualToString:@"01"]) {
            return @"直选";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"组三";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"组六";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return  @"组选";
        }
    } else if ([@"003" isEqualToString:lotteryID]) {
        
    } else if ([@"010" isEqualToString:lotteryID]) {
         // 两步彩
    } else if ([@"113" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return  @"追加";
        }
//        return TYPE_DALETOU;
    } else if ([@"110" isEqualToString:lotteryID]) {
        
    } else if ([@"108" isEqualToString:lotteryID]) {
//        return TYPE_PAILIE3;
        if ([wanfa isEqualToString:@"01"]) {
            return @"直选";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"组三";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"组六";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return  @"组选";
        }
    } else if ([@"109" isEqualToString:lotteryID]) {
//        return TYPE_PAILIE5;
    } else if ([@"111" isEqualToString:lotteryID]) {
//        return TYPE_22XUAN5;
    } else if ([LOTTERY_ID_JIANGXI_11 isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"02"]) {
            return @"任选二";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"任选三";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"任选四";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"任选五";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return @"任选六";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return @"任选七";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return @"任选八";
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return @"前二直选";
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return @"前三直选";
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return @"前一直选";
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return @"前二组选";
        }
        else if ([wanfa isEqualToString:@"13"]) {
            return @"前三组选";
        }
    }else if ([@"121" isEqualToString:lotteryID]||[lotteryID isEqualToString:@"119"]||[lotteryID isEqualToString:@"123"]||[lotteryID isEqualToString:LOTTERY_ID_SHANXI_11]) {
        if ([wanfa isEqualToString:@"02"]) {
            return @"任选二";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"任选三";
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"任选四";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"任选五";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return @"任选六";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return @"任选七";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return @"任选八";
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return @"前二直选";
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return @"前三直选";
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return @"前一直选";
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return @"前二组选";
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return @"前三组选";
        }
    } else if ([@"006" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"03"]) {
            return  @"三星";
        }
        else if ([wanfa isEqualToString:@"23"]){
            return  @"大小单双";
        }
        else if ([wanfa isEqualToString:@"01"]){
            return  @"一星直选";
        }
        else if ([wanfa isEqualToString:@"02"]){
            return  @"二星直选";
        }
        else if ([wanfa isEqualToString:@"06"]){
            return  @"二星组选";
        }
        else if ([wanfa isEqualToString:@"04"]){
            return  @"四星直选";
        }
        else if ([wanfa isEqualToString:@"05"]){
            return  @"五星直选";
        }
        else if ([wanfa isEqualToString:@"14"]){
            return  @"五星通选";
        }
        else if ([wanfa isEqualToString:@"20"]){
            return  @"任选一";
        }
        else if ([wanfa isEqualToString:@"21"]){
            return  @"任选二";
        }
        else if ([wanfa isEqualToString:@"22"]){
            return  @"任选三";
        }
    }
    else if ([@"012" isEqualToString:lotteryID] || [@"013" isEqualToString:lotteryID] || [@"019" isEqualToString:lotteryID] || [LOTTERY_ID_JILIN isEqualToString:lotteryID] || [LOTTERY_ID_ANHUI isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"和值";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"三同号单选";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"三连号通选";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"三同号通选";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"三不同号";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return @"二同号单选";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return @"二同号复选";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return @"二不同号";
        }
    }
    else if ([@"014" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"01"]) {
            return @"一星直选";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"二星直选";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"三星直选";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"五星直选";
        }
        else if ([wanfa isEqualToString:@"14"]) {
            return @"五星通选";
        }
        else if ([wanfa isEqualToString:@"23"]) {
            return @"大小单双";
        }
    }
    else if ([@"122" isEqualToString:lotteryID]) {//快乐扑克
        if ([wanfa isEqualToString:@"01"]) {
            return @"同花";
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return @"同花顺";
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return @"顺子";
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return @"豹子";
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return @"对子";
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return @"任一";
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return @"任二";
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return @"任三";
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return @"任四";
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return @"任五";
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return @"任六";
        }
    }
    return nil;
}

+ (NSString *)lotteryNameWithLotteryID:(NSString *)lotteryID
{
    if ([@"300" isEqualToString:lotteryID]) {
        return @"胜负彩";
    } else if ([@"301" isEqualToString:lotteryID]) {
        return @"任选9";
    } else if ([@"303" isEqualToString:lotteryID]) {
        return @"进球彩";
    } else if ([@"302" isEqualToString:lotteryID]) {
        return @"半全场";
    } else if ([@"400" isEqualToString:lotteryID]) {
        return @"北京单场";
    }
    else if([@"200" isEqualToString:lotteryID]||[@"203" isEqualToString:lotteryID]){
        
        return @"竞彩篮球";
    
    }else if ([@"201" isEqualToString:lotteryID]||[@"202" isEqualToString:lotteryID]){
        return @"竞彩足球";
    }
//    else if ([@"200" isEqualToString:lotteryID]||[@"201" isEqualToString:lotteryID]||[@"202" isEqualToString:lotteryID] || [@"203" isEqualToString:lotteryID]) {
//        return @"竞彩";
//    }
    else if ([@"001" isEqualToString:lotteryID]) {
        return @"双色球";
    } else if ([@"002" isEqualToString:lotteryID]) {
        return @"福彩3D";
    } else if ([@"009" isEqualToString:lotteryID]) {
        return @"北京3D";
    } else if ([@"003" isEqualToString:lotteryID]) {
        return @"七乐彩";
    } else if ([@"010" isEqualToString:lotteryID]) {
        return @"两步彩";
    } else if ([@"113" isEqualToString:lotteryID]) {
        return @"大乐透";
    } else if ([@"110" isEqualToString:lotteryID]) {
        return @"七星彩";
    } else if ([@"108" isEqualToString:lotteryID]) {
        return @"排列3";
    } else if ([@"109" isEqualToString:lotteryID]) {
        return @"排列5";
    } else if ([@"111" isEqualToString:lotteryID]) {
        return @"22选5";
    } else if ([lotteryID isEqualToString:@"119"]) {
        return @"山东11选5";
    }
    else if ([lotteryID isEqualToString:@"123"]) {
        return @"河北11选5";
    }
    else if ([lotteryID isEqualToString:LOTTERY_ID_SHANXI_11]) {
        return @"新11选5";
    }
    else if ([lotteryID isEqualToString:LOTTERY_ID_JIANGXI_11]) {
        return @"江西11选5";
    }else if ([@"121" isEqualToString:lotteryID]) {
        return @"广东11选5";
    }else if ([@"006" isEqualToString:lotteryID]) {
        return @"黑龙江时时彩";
    } else if ([@"016" isEqualToString:lotteryID]) {
        return @"快乐8";
    } else if ([@"017" isEqualToString:lotteryID]) {
        return @"PK拾";
    }
    else if ([@"011" isEqualToString:lotteryID]) {
        return @"快乐十分";
    }
    else if ([@"012" isEqualToString:lotteryID]) {
        return @"内蒙古快三";
    }
    else if ([@"013" isEqualToString:lotteryID]) {
        return @"江苏快三";
    }
    else if ([@"019" isEqualToString:lotteryID]) {
        return @"湖北快三";
    }
    else if ([LOTTERY_ID_JILIN isEqualToString:lotteryID]) {
        return @"吉林快三";
    }
    else if ([LOTTERY_ID_ANHUI isEqualToString:lotteryID]) {
        return @"新快三";
    }
    else if ([@"122" isEqualToString:lotteryID]) {
        return @"快乐扑克";
    }
    else if ([@"014" isEqualToString:lotteryID]) {
        return @"老时时彩";
    }
    
    return @"";
}


+ (LotteryTYPE)lotteryTypeWithLotteryID:(NSString *)lotteryID Wanfa:(NSString *)wanfa
{
    if ([@"300" isEqualToString:lotteryID]) {
        return TYPE_ZC_SHENGFUCAI;
    } else if ([@"301" isEqualToString:lotteryID]) {
        return TYPE_ZC_RENXUAN9;
    } else if ([@"302" isEqualToString:lotteryID]) {
        return TYPE_ZC_BANQUANCHANG;
    } else if ([@"303" isEqualToString:lotteryID]) {
        return TYPE_ZC_JINQIUCAI;
    } else if ([@"400" isEqualToString:lotteryID]) {
        return TYPE_BJDC; // 北京单场
    } else if ([@"200" isEqualToString:lotteryID]) {
        return TYPE_JINGCAI_LQ;
    } else if ([@"201" isEqualToString:lotteryID]) {
        return TYPE_JINGCAI_ZQ;
    } else if ([@"001" isEqualToString:lotteryID]) {
        return TYPE_SHUANGSEQIU;
    } else if ([@"002" isEqualToString:lotteryID]) {
        return TYPE_3D;
    } else if ([@"009" isEqualToString:lotteryID]) {
        return 0; // 北京3D
    } else if ([@"003" isEqualToString:lotteryID]) {
        return TYPE_7LECAI;
    } else if ([@"010" isEqualToString:lotteryID]) {
        return 0; // 两步彩
    } else if ([@"113" isEqualToString:lotteryID]) {
        return TYPE_DALETOU;
    } else if ([@"110" isEqualToString:lotteryID]) {
        return TYPE_QIXINGCAI;
    } else if ([@"108" isEqualToString:lotteryID]) {
        return TYPE_PAILIE3;
    } else if ([@"109" isEqualToString:lotteryID]) {
        return TYPE_PAILIE5;
    } else if ([@"111" isEqualToString:lotteryID]) {
        return TYPE_22XUAN5;
    }
    else if ([lotteryID isEqualToString:@"119"]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_11XUAN5_Q3ZU;
        }
    }
    else if ([lotteryID isEqualToString:@"123"]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_HB11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_HB11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_HB11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_HB11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_HB11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_HB11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_HB11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_HB11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_HB11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_HB11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_HB11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_HB11XUAN5_Q3ZU;
        }
    }
    else if ([lotteryID isEqualToString:LOTTERY_ID_SHANXI_11]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_ShanXi11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_ShanXi11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_ShanXi11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_ShanXi11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_ShanXi11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_ShanXi11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_ShanXi11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_ShanXi11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_ShanXi11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_ShanXi11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_ShanXi11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_ShanXi11XUAN5_Q3ZU;
        }
    }
    else if ([lotteryID isEqualToString:LOTTERY_ID_JIANGXI_11]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_JX11XUAN5_2;
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_JX11XUAN5_3;
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_JX11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_JX11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_JX11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_JX11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_JX11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_JX11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_JX11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_JX11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_JX11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"13"]) {
            return TYPE_JX11XUAN5_Q3ZU;
        }
    }
    else if ([@"121" isEqualToString:lotteryID]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_GD11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_GD11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_GD11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_GD11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_GD11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_GD11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_GD11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_GD11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_GD11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_GD11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_GD11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_GD11XUAN5_Q3ZU;
        }
    } else if ([@"006" isEqualToString:lotteryID]) {
        return TYPE_SHISHICAI;
    } else if ([@"016" isEqualToString:lotteryID]) {
        return TYPE_HAPPY8;
    } else if ([@"017" isEqualToString:lotteryID]) {
        return TYPE_PK10;
    } else if ([@"012" isEqualToString:lotteryID]) {
        return TYPE_KuaiSan;
    }
    else if ([@"013" isEqualToString:lotteryID]) {
        return TYPE_JSKuaiSan;
    }
    else if ([@"019" isEqualToString:lotteryID]) {
        return TYPE_HBKuaiSan;
    }
    else if ([LOTTERY_ID_JILIN isEqualToString:lotteryID]) {
        return TYPE_JLKuaiSan;
    }
    else if ([LOTTERY_ID_ANHUI isEqualToString:lotteryID]) {
        return TYPE_AHKuaiSan;
    }
    else if ([@"014" isEqualToString:lotteryID]) {
        return TYPE_CQShiShi;
    }
    
    return TYPE_UNSUPPT;
}

+ (NSString *)lotteryIDWithLotteryType:(LotteryTYPE)lotteryType
{
    if (lotteryType == TYPE_ZC_SHENGFUCAI) {
        return @"300";
    } else if (lotteryType == TYPE_ZC_RENXUAN9) {
        return @"301";
    } else if (lotteryType == TYPE_ZC_BANQUANCHANG) {
        return @"302";
    } else if (lotteryType == TYPE_ZC_JINQIUCAI) {
        return @"303";
    } else if (lotteryType == TYPE_SHUANGSEQIU) {
        return @"001";
    } else if (lotteryType == TYPE_DALETOU) {
        return @"113";
    } else if (lotteryType == TYPE_3D) {
        return @"002";
    } else if (lotteryType == TYPE_QIXINGCAI) {
        return @"110";
    } else if (lotteryType == TYPE_7LECAI) {
        return @"003";
    } else if (lotteryType == TYPE_PAILIE3) {
        return @"108";
    } else if (lotteryType == TYPE_PAILIE5) {
        return @"109";
    } else if (lotteryType == TYPE_JINGCAI_LQ) {
        return @"200";
    } else if (lotteryType == TYPE_JINGCAI_ZQ) {
        return @"201";
    } else if (lotteryType == TYPE_22XUAN5) {
        return @"111";
    }
    else if (lotteryType >= TYPE_11XUAN5_1 && lotteryType <= TYPE_11XUAN5_Q3DaTuo) {
        return @"119";
    }
    else if (lotteryType >= TYPE_GD11XUAN5_1 && lotteryType <= TYPE_GD11XUAN5_Q3DaTuo) {
        return @"121";
    }
    else if (lotteryType >= TYPE_JX11XUAN5_1 && lotteryType <= TYPE_JX11XUAN5_Q3DaTuo) {
        return @"107";
    }
    else if (lotteryType >= TYPE_HB11XUAN5_1 && lotteryType <= TYPE_HB11XUAN5_Q3DaTuo) {
        return @"123";
    }
    else if (lotteryType >= TYPE_ShanXi11XUAN5_1 && lotteryType <= TYPE_ShanXi11XUAN5_Q3DaTuo) {
        return LOTTERY_ID_SHANXI_11;
    }
    else if (lotteryType == TYPE_SHISHICAI) {
        return @"006";
    } else if (lotteryType == TYPE_PK10) {
        return @"017";
    } else if (lotteryType == TYPE_HAPPY8) {
        return @"016";
    } else if (lotteryType == TYPE_HappyTen) {
        return @"011";
    }
    else if (lotteryType == TYPE_KuaiSan) {
        return @"012";
    }
    else if (lotteryType == TYPE_JSKuaiSan) {
        return @"013";
    }
    else if (lotteryType == TYPE_HBKuaiSan){
        return @"019";
    }
    else if (lotteryType == TYPE_JLKuaiSan){
        return LOTTERY_ID_JILIN;
    }
    else if (lotteryType == TYPE_AHKuaiSan){
        return LOTTERY_ID_ANHUI;
    }
    else if(lotteryType == TYPE_JINGCAI_HUNTOU){
        return @"202";
    }
    else if(lotteryType == TYPE_LANQIU_HUNTOU){
        return @"203";
    }
    else if (lotteryType == TYPE_BJDC_SPF||lotteryType == TYPE_BJDC_SXP || lotteryType == TYPE_BJDC_ZJQ || lotteryType == TYPE_BJDC_BQC||lotteryType == TYPE_BJDC_BF) {
        return @"400";
    }
    else if (lotteryType == TYPE_KuaiLePuKe) {
        return @"122";
    }
    else if (lotteryType == TYPE_CQShiShi) {
        return @"014";
    }else if (lotteryType == TYPE_BJDC_SFGG){
        return @"270";
    }
    
    return @"";
}

+ (NSString *)lotteryNameWithLotteryType:(LotteryTYPE)lotteryType
{
    NSString *lotteryID = [GC_LotteryType lotteryIDWithLotteryType:lotteryType];
    return [GC_LotteryType lotteryNameWithLotteryID:lotteryID];
}

+ (NSString *)changeLotteryTYPEToWanfa:(LotteryTYPE)_lotteryType modeType:(ModeTYPE)_modeType {
    if (_lotteryType == TYPE_SHUANGSEQIU) {
        if (_modeType == Shuangseqiudanshi||_modeType == Shuangseqiufushi||_modeType == Shuangseqiudantuo) {
            return @"00";
        }
    }
    else if (_lotteryType == TYPE_DALETOU) {
        if ( _modeType == Daletoufushi || _modeType == Daletoudanshi ||_modeType == Daletoudantuo) {
            return  @"00";
        }
    }
    else if (_lotteryType == TYPE_3D) {
        if (_modeType == ThreeDzhixuanfushi  ){
            return  @"01";
        }
        else if (_modeType == ThreeDzusanfushi) {
            return  @"02";
        }
        else if (_modeType == ThreeDzuliufushi) {
            return  @"03";
        }
        else if (_modeType == ThreeDzhixuandantuo) {
            return  @"04";
        }
        else if (_modeType == ThreeDzhixuanhezhi) {
            return  @"01";
        }
        else if (_modeType == ThreeDzusanHezhi) {
            return  @"02";
        }
        else if (_modeType == ThreeDzuliuHezhi) {
            return  @"03";
        }
        else if (_modeType == ThreeDzusanDantuo) {
            return  @"02";
        }
        else if (_modeType == ThreeDzuliuDantuo) {
            return  @"03";
        }
        else if (_modeType == ThreeDzusandanshi) {
            return  @"02";
        }
    }
    else if (_lotteryType == TYPE_7LECAI) {
        if (_modeType ==Qilecaifushi) {
            return  @"00";
        }
        else if (_modeType ==Qilecaidantuo) {
            return  @"00";
        }
    }
    else if (_lotteryType == TYPE_SHISHICAI) {
        if (_modeType == SSCsanxingfushi) {
            return  @"03";
        }
        else if (_modeType == SSCdaxiaodanshuang){
            return  @"23";
        }
        else if (_modeType == SSCyixingfushi){
            return  @"01";
        }
        else if (_modeType == SSCerxingfushi){
            return  @"02";
        }
        else if (_modeType == SSCerxingzuxuan){
            return  @"06";
        }
        else if (_modeType == SSCerxingzuxuandantuo){
            return  @"06";
        }
        else if (_modeType == SSCsixingfushi){
            return  @"04";
        }
        else if (_modeType == SSCwuxingfushi){
            return  @"05";
        }
        else if (_modeType == SSCwuxingtongxuan){
            return  @"14";
        }
        else if (_modeType == SSCrenxuanyi){
            return  @"20";
        }
        else if (_modeType == SSCrenxuaner){
            return  @"21";
        }
        else if (_modeType == SSCrenxuansan){
            return  @"22";
        }
    }
    else if (_lotteryType == TYPE_CQShiShi) {
        if (_modeType == SSCsanxingfushi) {
            return  @"03";
        }
        else if (_modeType == SSCdaxiaodanshuang){
            return  @"23";
        }
        else if (_modeType == SSCyixingfushi){
            return  @"01";
        }
        else if (_modeType == SSCerxingfushi){
            return  @"02";
        }
        else if (_modeType == SSCerxingzuxuan){
            return  @"06";
        }
        else if (_modeType == SSCerxingzuxuandantuo){
            return  @"06";
        }
        else if (_modeType == SSCsixingfushi){
            return  @"04";
        }
        else if (_modeType == SSCwuxingfushi){
            return  @"05";
        }
        else if (_modeType == SSCwuxingtongxuan){
            return  @"14";
        }
        else if (_modeType == SSCrenxuanyi){
            return  @"20";
        }
        else if (_modeType == SSCrenxuaner){
            return  @"21";
        }
        else if (_modeType == SSCrenxuansan){
            return  @"22";
        }
    }
    else if (_lotteryType ==  TYPE_PAILIE3) {
        if (_modeType == Array3zhixuanfushi){
            
            return  @"01";
        }
        else if (_modeType == Array3zusanfushi){
            
            return  @"03";
        }
        else if (_modeType == Array3zuliufushi){
            
            return  @"04";
        }
        else if (_modeType == Array3zuxuandanshi){
            
            return  @"02";
        }
        else if (_modeType == Array3zhixuanHezhi){
            
            return  @"01";
        }
        else if (_modeType == Array3zusanHezhi){
            
            return  @"03";
        }
        else if (_modeType == Array3zuliuHezhi){
            
            return  @"04";
        }
        else if (_modeType == Array3zusandantuo){
            
            return  @"03";
        }
        else if (_modeType == Array3zuliudantuo){
            
            return  @"04";
        }
        
    }
    else if (_lotteryType == TYPE_22XUAN5){
        if (_modeType == danshi || _modeType == fushi) {
            return @"00";
        }
    }
    else if (_lotteryType == TYPE_PAILIE5 ) {
        if (_modeType == danshi || _modeType == fushi) {
            return @"00";
        }
    }
    else if (_lotteryType == TYPE_QIXINGCAI) {
        if (_modeType == danshi || _modeType == fushi) {
            return @"00";
        }
    }
    else if (_lotteryType >= TYPE_11XUAN5_1 && _lotteryType <= TYPE_11XUAN5_Q3DaTuo) {
        if (_lotteryType == TYPE_11XUAN5_1) {
            return  @"01";
        }
        if (_lotteryType == TYPE_11XUAN5_2 ||_lotteryType == TYPE_11XUAN5_R2DaTuo) {
            return  @"02";
        }
        if (_lotteryType == TYPE_11XUAN5_3 ||_lotteryType == TYPE_11XUAN5_R3DaTuo) {
            return  @"03";
        }
        if (_lotteryType == TYPE_11XUAN5_4 ||_lotteryType == TYPE_11XUAN5_R4DaTuo) {
            return  @"04";
        }
        if (_lotteryType == TYPE_11XUAN5_5 ||_lotteryType == TYPE_11XUAN5_R5DaTuo) {
            return  @"05";
        }
        if (_lotteryType == TYPE_11XUAN5_6) {
            return  @"06";
        }
        if (_lotteryType == TYPE_11XUAN5_7) {
            return  @"07";
        }
        if (_lotteryType == TYPE_11XUAN5_8) {
            return  @"08";
        }
        if (_lotteryType == TYPE_11XUAN5_Q2ZHI) {
            return  @"09";
        }
        if (_lotteryType == TYPE_11XUAN5_Q3ZHI) {
            return  @"10";
        }
        if (_lotteryType == TYPE_11XUAN5_Q2ZU ||_lotteryType == TYPE_11XUAN5_Q2DaTuo) {
            return  @"11";
        }
        if (_lotteryType == TYPE_11XUAN5_Q3ZU ||_lotteryType == TYPE_11XUAN5_Q3DaTuo) {
            return  @"12";
        }
    }
    else if (_lotteryType >= TYPE_HB11XUAN5_1 && _lotteryType <= TYPE_HB11XUAN5_Q3DaTuo) {
        if (_lotteryType == TYPE_HB11XUAN5_1) {
            return  @"01";
        }
        if (_lotteryType == TYPE_HB11XUAN5_2 ||_lotteryType == TYPE_HB11XUAN5_R2DaTuo) {
            return  @"02";
        }
        if (_lotteryType == TYPE_HB11XUAN5_3 ||_lotteryType == TYPE_HB11XUAN5_R3DaTuo) {
            return  @"03";
        }
        if (_lotteryType == TYPE_HB11XUAN5_4 ||_lotteryType == TYPE_HB11XUAN5_R4DaTuo) {
            return  @"04";
        }
        if (_lotteryType == TYPE_HB11XUAN5_5 ||_lotteryType == TYPE_HB11XUAN5_R5DaTuo) {
            return  @"05";
        }
        if (_lotteryType == TYPE_HB11XUAN5_6) {
            return  @"06";
        }
        if (_lotteryType == TYPE_HB11XUAN5_7) {
            return  @"07";
        }
        if (_lotteryType == TYPE_HB11XUAN5_8) {
            return  @"08";
        }
        if (_lotteryType == TYPE_HB11XUAN5_Q2ZHI) {
            return  @"09";
        }
        if (_lotteryType == TYPE_HB11XUAN5_Q3ZHI) {
            return  @"10";
        }
        if (_lotteryType == TYPE_HB11XUAN5_Q2ZU ||_lotteryType == TYPE_HB11XUAN5_Q2DaTuo) {
            return  @"11";
        }
        if (_lotteryType == TYPE_HB11XUAN5_Q3ZU ||_lotteryType == TYPE_HB11XUAN5_Q3DaTuo) {
            return  @"12";
        }
    }
    else if (_lotteryType >= TYPE_ShanXi11XUAN5_1 && _lotteryType <= TYPE_ShanXi11XUAN5_Q3DaTuo) {
        if (_lotteryType == TYPE_ShanXi11XUAN5_1) {
            return  @"01";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_2 ||_lotteryType == TYPE_ShanXi11XUAN5_R2DaTuo) {
            return  @"02";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_3 ||_lotteryType == TYPE_ShanXi11XUAN5_R3DaTuo) {
            return  @"03";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_4 ||_lotteryType == TYPE_ShanXi11XUAN5_R4DaTuo) {
            return  @"04";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_5 ||_lotteryType == TYPE_ShanXi11XUAN5_R5DaTuo) {
            return  @"05";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_6) {
            return  @"06";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_7) {
            return  @"07";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_8) {
            return  @"08";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_Q2ZHI) {
            return  @"09";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_Q3ZHI) {
            return  @"10";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_Q2ZU ||_lotteryType == TYPE_ShanXi11XUAN5_Q2DaTuo) {
            return  @"11";
        }
        if (_lotteryType == TYPE_ShanXi11XUAN5_Q3ZU ||_lotteryType == TYPE_ShanXi11XUAN5_Q3DaTuo) {
            return  @"12";
        }
    }
    else if (_lotteryType >= TYPE_GD11XUAN5_1 && _lotteryType <= TYPE_GD11XUAN5_Q3DaTuo) {
        if (_lotteryType == TYPE_GD11XUAN5_1) {
			return  @"01";
		}
		if (_lotteryType == TYPE_GD11XUAN5_2 ||_lotteryType == TYPE_GD11XUAN5_R2DaTuo) {
			return  @"02";
		}
		if (_lotteryType == TYPE_GD11XUAN5_3 ||_lotteryType == TYPE_GD11XUAN5_R3DaTuo) {
			return  @"03";
		}
		if (_lotteryType == TYPE_GD11XUAN5_4 ||_lotteryType == TYPE_GD11XUAN5_R4DaTuo) {
			return  @"04";
		}
		if (_lotteryType == TYPE_GD11XUAN5_5 ||_lotteryType == TYPE_GD11XUAN5_R5DaTuo) {
			return  @"05";
		}
		if (_lotteryType == TYPE_GD11XUAN5_6) {
			return  @"06";
		}
		if (_lotteryType == TYPE_GD11XUAN5_7) {
			return  @"07";
		}
		if (_lotteryType == TYPE_GD11XUAN5_8) {
			return  @"08";
		}
		if (_lotteryType == TYPE_GD11XUAN5_Q2ZHI) {
			return  @"09";
		}
		if (_lotteryType == TYPE_GD11XUAN5_Q3ZHI) {
			return  @"10";
		}
        if (_lotteryType == TYPE_GD11XUAN5_Q2ZU ||_lotteryType == TYPE_GD11XUAN5_Q2DaTuo) {
			return  @"11";
		}
        if (_lotteryType == TYPE_GD11XUAN5_Q3ZU ||_lotteryType == TYPE_GD11XUAN5_Q3DaTuo) {
			return  @"12";
		}
    }
    else if (_lotteryType >= TYPE_JX11XUAN5_1 && _lotteryType <= TYPE_JX11XUAN5_Q3DaTuo) {
        if (_lotteryType == TYPE_JX11XUAN5_1) {
            return  @"09";
        }
        if (_lotteryType == TYPE_JX11XUAN5_2 ||_lotteryType == TYPE_JX11XUAN5_R2DaTuo) {
            return  @"02";
        }
        if (_lotteryType == TYPE_JX11XUAN5_3 ||_lotteryType == TYPE_JX11XUAN5_R3DaTuo) {
            return  @"03";
        }
        if (_lotteryType == TYPE_JX11XUAN5_4 ||_lotteryType == TYPE_JX11XUAN5_R4DaTuo) {
            return  @"04";
        }
        if (_lotteryType == TYPE_JX11XUAN5_5 ||_lotteryType == TYPE_JX11XUAN5_R5DaTuo) {
            return  @"05";
        }
        if (_lotteryType == TYPE_JX11XUAN5_6) {
            return  @"06";
        }
        if (_lotteryType == TYPE_JX11XUAN5_7) {
            return  @"07";
        }
        if (_lotteryType == TYPE_JX11XUAN5_8) {
            return  @"08";
        }
        if (_lotteryType == TYPE_JX11XUAN5_Q2ZHI) {
            return  @"10";
        }
        if (_lotteryType == TYPE_JX11XUAN5_Q3ZHI) {
            return  @"11";
        }
        if (_lotteryType == TYPE_JX11XUAN5_Q2ZU ||_lotteryType == TYPE_JX11XUAN5_Q2DaTuo) {
            return  @"12";
        }
        if (_lotteryType == TYPE_JX11XUAN5_Q3ZU ||_lotteryType == TYPE_JX11XUAN5_Q3DaTuo) {
            return  @"13";
        }
    }
    else if (_lotteryType == TYPE_HappyTen) {
        if (_modeType == HappyTen1Shu){
            return  @"01";
        }
        else if (_modeType == HappyTen1Hong){
            return  @"02";
        }
        else if (_modeType == HappyTenRen2 || _modeType == HappyTenRen2DanTuo){
            return  @"07";
        }
        else if (_modeType == HappyTenRen2Zu || _modeType == HappyTenRen2ZuDanTuo){
            return  @"03";
        }
        else if (_modeType == HappyTenRen2Zhi){
            return  @"04";
        }
        else if (_modeType == HappyTenRen3 || _modeType == HappyTenRen3DanTuo){
            return  @"08";
        }
        else if (_modeType == HappyTenRen3Zu || _modeType == HappyTenRen3ZuDanTuo){
            return  @"05";
        }
        else if (_modeType == HappyTenRen3Zhi){
            return  @"06";
        }
        else if (_modeType == HappyTenRen4 || _modeType == HappyTenRen4DanTuo){
            return  @"09";
        }
        else if (_modeType == HappyTenRen5 || _modeType == HappyTenRen5DanTuo){
            return  @"10";
        }
        else if (_modeType == HappyTenDa){
            return  @"11";
        }
        else if (_modeType == HappyTenDan){
            return  @"12";
        }
        else if (_modeType == HappyTenQuan){
            return  @"13";
        }

    }
    else if (_lotteryType == TYPE_KuaiSan || _lotteryType == TYPE_JSKuaiSan || _lotteryType == TYPE_HBKuaiSan || _lotteryType == TYPE_JLKuaiSan || _lotteryType == TYPE_AHKuaiSan) {
        if (_modeType == KuaiSanHezhi) {
            return @"01";
        }
        else if (_modeType == KuaiSanSantongTong) {
            return @"04";
        }
        else if (_modeType == KuaiSanSantongDan) {
            return @"02";
        }
        else if (_modeType == KuaiSanErtongDan) {
            return @"06";
        }
        else if (_modeType == KuaiSanErTongFu) {
            return @"07";
        }
        else if (_modeType == KuaiSanSanBuTong || _modeType == KuaiSanSanBuTongDanTuo) {
            return @"05";
        }
        else if (_modeType == KuaiSanErButong || _modeType == KuaiSanErBuTongDanTuo) {
            return @"08";
        }
        else if (_modeType == KuaiSanSanLianTong) {
            return @"03";
        }
    }
    else if (_lotteryType == TYPE_KuaiLePuKe) {
        if (_modeType == KuaiLePuKeRen1) {
            return @"06";
        }
        else if (_modeType == KuaiLePuKeRen2){
            return @"07";
        }
        else if (_modeType == KuaiLePuKeRen3){
            return @"08";
        }
        else if (_modeType == KuaiLePuKeRen4){
            return @"09";
        }
        else if (_modeType == KuaiLePuKeRen5){
            return @"10";
        }
        else if (_modeType == KuaiLePuKeRen6){
            return @"11";
        }
        else if (_modeType == KuaiLePuKeTongHua){
            return @"01";
        }
        else if (_modeType == KuaiLePuKeTongHuaShun){
            return @"02";
        }
        else if (_modeType == KuaiLePuKeShunZi) {
            return @"03";
        }
        else if (_modeType == KuaiLePuKeBaoZi) {
            return @"04";
        }
        else if (_modeType == KuaiLePuKeDuiZi) {
            return @"05";
        }
    }
    return @"";
}
+ (LotteryTYPE) shiyixuanwuChangeWanfaToLotteryType:(NSString *)caizhong Wanfa:(NSString *)wanfa{

    if ([caizhong isEqualToString:@"119"]) {
        //山东11选5
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_11XUAN5_Q3ZU;
        }
        
        
    }
    if ([caizhong isEqualToString:@"123"]) {
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_HB11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_HB11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_HB11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_HB11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_HB11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_HB11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_HB11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_HB11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_HB11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_HB11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_HB11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_HB11XUAN5_Q3ZU;
        }
        
        
    }
    if ([caizhong isEqualToString:LOTTERY_ID_SHANXI_11]) {
        //陕西11选5
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_ShanXi11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_ShanXi11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_ShanXi11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_ShanXi11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_ShanXi11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_ShanXi11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_ShanXi11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_ShanXi11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_ShanXi11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_ShanXi11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_ShanXi11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_ShanXi11XUAN5_Q3ZU;
        }
        
        
    }
    else if ([@"121" isEqualToString:caizhong]) {
        
        //广东11选5
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_GD11XUAN5_2;
            
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_GD11XUAN5_3;
            
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_GD11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_GD11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_GD11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_GD11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_GD11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_GD11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_GD11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"01"]) {
            return TYPE_GD11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_GD11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_GD11XUAN5_Q3ZU;
        }
        
    }
    else if ([LOTTERY_ID_JIANGXI_11 isEqualToString:caizhong]) {
        
        //江西11选5
        if ([wanfa isEqualToString:@"02"]) {
            return TYPE_JX11XUAN5_2;
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return TYPE_JX11XUAN5_3;
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return TYPE_JX11XUAN5_4;
        }
        else if ([wanfa isEqualToString:@"05"]) {
            return TYPE_JX11XUAN5_5;
        }
        else if ([wanfa isEqualToString:@"06"]) {
            return TYPE_JX11XUAN5_6;
        }
        else if ([wanfa isEqualToString:@"07"]) {
            return TYPE_JX11XUAN5_7;
        }
        else if ([wanfa isEqualToString:@"08"]) {
            return TYPE_JX11XUAN5_8;
        }
        else if ([wanfa isEqualToString:@"10"]) {
            return TYPE_JX11XUAN5_Q2ZHI;
        }
        else if ([wanfa isEqualToString:@"11"]) {
            return TYPE_JX11XUAN5_Q3ZHI;
        }
        else if ([wanfa isEqualToString:@"09"]) {
            return TYPE_JX11XUAN5_1;
        }
        else if ([wanfa isEqualToString:@"12"]) {
            return TYPE_JX11XUAN5_Q2ZU;
        }
        else if ([wanfa isEqualToString:@"13"]) {
            return TYPE_JX11XUAN5_Q3ZU;
        }
        
    }
    return TYPE_UNSUPPT;

}
+ (ModeTYPE ) changeWanfaToModeTYPE:(NSString *)caizhong Wanfa:(NSString *)wanfa {

    if ([@"300" isEqualToString:caizhong]) {
        //胜负彩

    }
    else if ([@"301" isEqualToString:caizhong]) {
        //任选九

    }
    else if ([@"302" isEqualToString:caizhong]) {

    }
    else if ([@"303" isEqualToString:caizhong]) {

    }
    else if ([@"400" isEqualToString:caizhong]) {
        // 北京单场
        
    }
    else if ([@"200" isEqualToString:caizhong]) {
        //竞彩篮球

    }
    else if ([@"201" isEqualToString:caizhong]) {
        //竞彩足球
        
    }
    else if ([@"001" isEqualToString:caizhong]) {
        //双色球
        if ([wanfa isEqualToString:@"00"]) {
            return Shuangseqiufushi;
        }
    }
    else if ([@"002" isEqualToString:caizhong]) {
        //福彩3D
        if ([wanfa isEqualToString: @"01"]) {
            return ThreeDzhixuanfushi;//和值也是01；
        }
        if ([wanfa isEqualToString: @"02"]) {
            return ThreeDzusanfushi;
        }
        if ([wanfa isEqualToString: @"03"]) {
            return ThreeDzuliufushi;
        }

    }
    else if ([@"009" isEqualToString:caizhong]) {
        // 北京3D
    }
    else if ([@"003" isEqualToString:caizhong]) {
        if ([wanfa isEqualToString:@"00"]) {
            return Qilecaidanshi;
        }
    }
    else if ([@"010" isEqualToString:caizhong]) {
        // 两步彩
    }
    else if ([@"113" isEqualToString:caizhong]) {
        if ([wanfa isEqualToString:@"01"]) {
            return Daletoufushi;//胆拖复式玩法都是01
        }
        if ([wanfa isEqualToString:@"00"]) {
            return Daletoufushi;//胆拖复式玩法都是01
        }
    }
    else if ([@"110" isEqualToString:caizhong]) {
        if ([wanfa isEqualToString:@"00"]) {//七星彩
            return fushi;
        }
    }
    else if ([@"108" isEqualToString:caizhong]) {
        if ([wanfa isEqualToString:@"01"]) {//排列三
            return Array3zhixuanfushi;
        }
        else if ([wanfa isEqualToString:@"02"]) {
            return Array3zuxuandanshi;
        }
        else if ([wanfa isEqualToString:@"03"]) {
            return Array3zusanfushi;
        }
        else if ([wanfa isEqualToString:@"04"]) {
            return Array3zuliufushi;
        }
    }
    else if ([@"109" isEqualToString:caizhong]) {//排列5
        if ([wanfa isEqualToString:@"00"]) {
            return fushi;
        }
    }
    else if ([@"111" isEqualToString:caizhong]) {//22选5
        if ([wanfa isEqualToString:@"00"]) {
            return fushi;
        }
    }
    else if ([@"014" isEqualToString:caizhong]) {
        //重庆时时彩
        if([wanfa isEqualToString:@"01"]){
        
            return SSCyixingfushi;
        }
        else if([wanfa isEqualToString:@"02"]){
        
            return SSCerxingfushi;
        }
        else if([wanfa isEqualToString:@"03"]){
            
            return SSCsanxingfushi;
        }
        else if([wanfa isEqualToString:@"05"]){
            
            return SSCwuxingfushi;
        }
        else if([wanfa isEqualToString:@"06"]){
            
            return SSCerxingzuxuan;
        }
        else if([wanfa isEqualToString:@"14"]){
            
            return SSCwuxingtongxuan;
        }
        else if([wanfa isEqualToString:@"23"]){
            
            return SSCdaxiaodanshuang;
        }

        
    }
    else if ([@"006" isEqualToString:caizhong]) {
        if ([wanfa isEqualToString:@"03"]) {
            return  SSCsanxingfushi;
        }
        else if ([wanfa isEqualToString:@"23"]){
            return  SSCdaxiaodanshuang;
        }
        else if ([wanfa isEqualToString:@"01"]){
            return  SSCyixingfushi;
        }
        else if ([wanfa isEqualToString:@"02"]){
            return  SSCerxingfushi;
        }
        else if ([wanfa isEqualToString:@"06"]){
            return  SSCerxingzuxuan;
        }
        else if ([wanfa isEqualToString:@"06"]){
            return  SSCerxingzuxuandantuo;//二星组选胆拖需要进一步判断
        }
        else if ([wanfa isEqualToString:@"04"]){
            return  SSCsixingfushi;
        }
        else if ([wanfa isEqualToString:@"05"]){
            return  SSCwuxingfushi;
        }
        else if ([wanfa isEqualToString:@"14"]){
            return  SSCwuxingtongxuan;
        }
        else if ([wanfa isEqualToString:@"20"]){
            return  SSCrenxuanyi;
        }
        else if ([wanfa isEqualToString:@"21"]){
            return  SSCrenxuaner;
        }
        else if ([wanfa isEqualToString:@"22"]){
            return  SSCrenxuansan;
        }
    }
    else if ([@"122" isEqualToString:caizhong]){
    
        //快乐扑克
        if([wanfa isEqualToString:@"06"]){
        
            return KuaiLePuKeRen1;
        }
        else if([wanfa isEqualToString:@"07"]){
        
            return KuaiLePuKeRen2;
        }
        else if([wanfa isEqualToString:@"08"]){
            
            return KuaiLePuKeRen3;
        }
        else if([wanfa isEqualToString:@"09"]){
            
            return KuaiLePuKeRen4;
        }
        else if([wanfa isEqualToString:@"10"]){
            
            return KuaiLePuKeRen5;
        }
        else if([wanfa isEqualToString:@"11"]){
            
            return KuaiLePuKeRen6;
        }
        else if([wanfa isEqualToString:@"01"]){
            
            return KuaiLePuKeTongHua;
        }
        else if([wanfa isEqualToString:@"02"]){
            
            return KuaiLePuKeTongHuaShun;
        }
        else if([wanfa isEqualToString:@"03"]){
            
            return KuaiLePuKeShunZi;
        }
        else if([wanfa isEqualToString:@"04"]){
            
            return KuaiLePuKeBaoZi;
        }
        else if([wanfa isEqualToString:@"05"]){
            
            return KuaiLePuKeDuiZi;
        }
        
        
    }
    else if ([@"012" isEqualToString:caizhong] || [@"013" isEqualToString:caizhong] || [@"018" isEqualToString:caizhong] || [@"019" isEqualToString:caizhong] || [LOTTERY_ID_ANHUI isEqualToString:caizhong]){
    
        if([wanfa isEqualToString:@"01"]){
        
            return KuaiSanHezhi;
        }
        else if([wanfa isEqualToString:@"02"]){
        
            return KuaiSanSantongDan;
        }
        else if([wanfa isEqualToString:@"03"]){
            
            return KuaiSanSanLianTong;
        }
        else if([wanfa isEqualToString:@"04"]){
            
            return KuaiSanSantongTong;
        }
        else if([wanfa isEqualToString:@"05"]){
            
            return KuaiSanSanBuTong;
        }
        else if([wanfa isEqualToString:@"06"]){
            
            return KuaiSanErtongDan;
        }
        else if([wanfa isEqualToString:@"07"]){
            
            return KuaiSanErTongFu;
        }
        else if([wanfa isEqualToString:@"08"]){
            
            return KuaiSanErButong;
        }
    }
    else if ([@"011" isEqualToString:caizhong]){
    
        if([wanfa isEqualToString:@"01"]){
        
            return HappyTen1Shu;
        }
        else if([wanfa isEqualToString:@"02"]){
        
            return HappyTen1Hong;
        }
        else if([wanfa isEqualToString:@"03"]){
            
            return HappyTenRen2Zu;
        }
        else if([wanfa isEqualToString:@"04"]){
            
            return HappyTenRen2Zhi;
        }
        else if([wanfa isEqualToString:@"05"]){
            
            return HappyTenRen3Zu;
        }
        else if([wanfa isEqualToString:@"06"]){
            
            return HappyTenRen3Zhi;
        }
        else if([wanfa isEqualToString:@"07"]){
            
            return HappyTenRen2;
        }
        else if([wanfa isEqualToString:@"08"]){
            
            return HappyTenRen3;
        }
        else if([wanfa isEqualToString:@"09"]){
            
            return HappyTenRen4;
        }
        else if([wanfa isEqualToString:@"10"]){
            
            return HappyTenRen5;
        }
        else if([wanfa isEqualToString:@"11"]){
            
            return HappyTenDa;
        }
        else if([wanfa isEqualToString:@"12"]){
            
            return HappyTenDan;
        }
        else if([wanfa isEqualToString:@"13"]){
            
            return HappyTenQuan;
        }
    }
    
    
    
    return ModeTYPE_UNSUPPOT;
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
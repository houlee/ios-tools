//
//  HttpService.m
//  Lottery
//
//  Created by Kiefer on 11-12-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "GC_NSData+AESCrypt.h"
#import "GC_NSString+AESCrypt.h"
#import "GC_DataWriteStream.h"
#import "GC_DataReadStream.h"
#import "GC_Advertisement.h"
#import "GC_PersonalData.h"
#import "GC_HeartInfo.h"
#import "GC_BetInfo.h"
#import "KFMD5.h"
#import <CommonCrypto/CommonDigest.h>
#import "caiboAppDelegate.h"
#import "Info.h"
#import "UserInfo.h"
#import "UDIDFromMac.h"
#import "NetURL.h"

#define ADVersionKey @"ADVersion"

@implementation GC_HttpService

@synthesize HzfSID, sessionId, isAgain, Version;
@synthesize httpRequest;

- (void)dealloc
{
    [httpRequest clearDelegatesAndCancel]; [httpRequest release];
    [HzfSID release];
    [sessionId release];
    [super dealloc];
}

static GC_HttpService *mInstance;
+ (GC_HttpService *)sharedInstance 
{  
    @synchronized(mInstance) {  
        if (mInstance == nil) {  
            mInstance = [[GC_HttpService alloc] init];  
        }
    }  
    return mInstance; 
}


- (id)init 
{
    if ((self = [super init])) {
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSLog(@"info = %@", infoDict);
        self.HzfSID = [infoDict objectForKey:@"SID"];
        self.Version = [infoDict objectForKey:@"CFBundleVersion"];
        NSLog(@"%@", self.Version);
        self.sessionId = nil;
    }
    return self;
}

- (NSURL *)hostUrl
{
    NSMutableString *requestUrl = [NSMutableString string];
    [requestUrl appendString:GC_HOST_URL];
    
    if (sessionId) {
        [requestUrl appendString:@";"];
        [requestUrl appendFormat:@"jsessionid=%@",sessionId];
        [requestUrl appendFormat:@"?realsessionId=%@",sessionId];
		NSLog(@"%@",sessionId);
    }
    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}

- (NSString *)stringWithKey:(NSString*)key value:(NSString*)value
{
    return [NSString stringWithFormat:@"%@=%@", key, value];
}

- (NSString *)stringWithKey:(NSString*)key AES256Value:(NSString*)value
{
    NSData *plainData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptCaiPiao365WithKey:AESKey];
    NSString *encryptedString = [NSString stringWithFormat:@"%@", encryptedData];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    encryptedString = [encryptedString stringByTrimmingCharactersInSet:characterSet];
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    encryptedString = [encryptedString uppercaseString];
    
    //NSLog(@"encryptedString = %@", encryptedString);
    return [self stringWithKey:key value:encryptedString];
}

- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}
//投注
- (NSURL *)payUrlWith:(GC_BuyLottery *)_buyLottery
{            
    NSLog(@"_buyLottery.totalMoney = %@", _buyLottery.totalMoney);
    NSLog(@"_buyLottery.bettingMoney = %@", _buyLottery.bettingMoney);
    NSLog(@"_buyLottery.betInfoID = %@", _buyLottery.betInfoID);

    NSMutableString *parameters = [[NSMutableString alloc] init];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"totalMoney" AES256Value:_buyLottery.totalMoney]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"bettingMoney" AES256Value:_buyLottery.bettingMoney]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"id" AES256Value:_buyLottery.betInfoID]];    
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSString *sign = [[self md5:strParam] lowercaseString];
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    if ([_buyLottery.lotteryId length]) {
        [parameters appendString:@"&lotteryId="];
        [parameters appendString:_buyLottery.lotteryId];
    }
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", base_wap_payURL, parameters];
    NSLog(@"%@",base_wap_payURL);
    [parameters release];
    
    NSLog(@"支付链接 %@", urlstring);
    return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

//好声音投注
- (NSURL *)payUrlWith:(GC_BuyLottery *)_buyLottery WithVoiceID:(NSString *)voicid;
{
    NSLog(@"_buyLottery.totalMoney = %@", _buyLottery.totalMoney);
    NSLog(@"_buyLottery.bettingMoney = %@", _buyLottery.bettingMoney);
    NSLog(@"_buyLottery.betInfoID = %@", _buyLottery.betInfoID);
    
    NSMutableString *parameters = [[NSMutableString alloc] init];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"totalMoney" AES256Value:_buyLottery.totalMoney]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"bettingMoney" AES256Value:_buyLottery.bettingMoney]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"id" AES256Value:_buyLottery.betInfoID]];
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSString *sign = [[self md5:strParam] lowercaseString];
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    if (voicid && [voicid length]) {
        [parameters appendString:[NSString stringWithFormat:@"&voicid=%@",voicid]];
    }
    if (_buyLottery.lotteryId && [_buyLottery.lotteryId length]) {
        [parameters appendString:[NSString stringWithFormat:@"&lotteryId=%@",_buyLottery.lotteryId]];
    }
    
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", base_wap_payURL, parameters];
    
    [parameters release];
    
    NSLog(@"支付链接 %@", urlstring);
    NSLog(@"%@",[NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}
//充值卡
- (NSURL *)reChangeUrlSysTimeChongzhi:(NSString *)systime Type:(NSString *)type{
    NSMutableString *parameters = [[NSMutableString alloc] init];
    NSString *username = [[Info getInstance] userName];
    if ([username length] ==0) {
        username = [[[Info getInstance] mUserInfo] user_name];
    }
    NSLog(@"username = %@", username);
    [parameters appendString:[self stringWithKey:@"username" AES256Value:username]];
    
    NSString * timesys = systime;
    [parameters appendString:@"&"];
    //  [parameters appendString:[self stringWithKey:@"password" AES256Value:password]]
    [parameters appendString:[self stringWithKey:@"flag" AES256Value:timesys]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    NSLog(@"%@",[GC_HttpService sharedInstance].sessionId);
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSLog(@"signKey = %@", MD5Key);
    NSLog(@"strParam = %@", strParam);
    NSString *sign = [[self md5:strParam] lowercaseString];
    NSLog(@"sign = %@", sign);
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    int canopenYL = 0;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uppay://"]]) {
        canopenYL = 1;
    }
    [parameters appendString:[NSString stringWithFormat:@"&uppay=%d",canopenYL]];
    
    if (type)
    {
        
        [parameters appendString:[NSString stringWithFormat:@"&chargeMode=%@",type]];
        
        
    }
    
    
    
    NSLog(@"parameters = %@", parameters);
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", Rechange_URL, parameters];
    
    [parameters release];
    
    NSLog(@"充值链接 %@", urlstring);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
        return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dingdingcai.com/wap/csj/charge/phone/login.jsp?sid=%@&uppay=%d",HzfSID,canopenYL]];
    return url;
}



//跳转类型充值信用卡
- (NSURL *)reChangeUrlSysTimew:(NSString *)systime Type:(NSString *)type{
    NSMutableString *parameters = [[NSMutableString alloc] init];
    NSString *username = [[Info getInstance] userName];
    if ([username length] ==0) {
        username = [[[Info getInstance] mUserInfo] user_name];
    }
    NSLog(@"username = %@", username);
    [parameters appendString:[self stringWithKey:@"username" AES256Value:username]];
    
    NSString * timesys = systime;
    [parameters appendString:@"&"];
    //  [parameters appendString:[self stringWithKey:@"password" AES256Value:password]]
    [parameters appendString:[self stringWithKey:@"flag" AES256Value:timesys]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    NSLog(@"%@",[GC_HttpService sharedInstance].sessionId);
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSLog(@"signKey = %@", MD5Key);
    NSLog(@"strParam = %@", strParam);
    NSString *sign = [[self md5:strParam] lowercaseString];
    NSLog(@"sign = %@", sign);
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    NSInteger canopenYL = 0;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uppay://"]]) {
        canopenYL = 1;
    }
    [parameters appendString:[NSString stringWithFormat:@"&uppay=%d",(int)canopenYL]];
   
    if (type)
    {

        [parameters appendString:[NSString stringWithFormat:@"&chargeMode=%@",type]];
        

    }

    
    
    NSLog(@"============parameters = %@", parameters);
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", Rechange_URL, parameters];
    
    [parameters release];
    
    NSLog(@"充值链接 %@", urlstring);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
        return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dingdingcai.com/wap/csj/charge/phone/login.jsp?sid=%@&uppay=%d",HzfSID,(int)canopenYL]];
    return url;
}

//充值 目前用的
- (NSURL *)reChangeUrlSysTime:(NSString *)systime{
    NSMutableString *parameters = [[NSMutableString alloc] init];
    NSString *username = [[Info getInstance] userName];
    if ([username length] ==0) {
        username = [[[Info getInstance] mUserInfo] user_name];
    }
    NSLog(@"username = %@", username);
    [parameters appendString:[self stringWithKey:@"username" AES256Value:username]];
    
    NSString * timesys = systime;
    [parameters appendString:@"&"];
  //  [parameters appendString:[self stringWithKey:@"password" AES256Value:password]]
    [parameters appendString:[self stringWithKey:@"flag" AES256Value:timesys]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    NSLog(@"%@",[GC_HttpService sharedInstance].sessionId);
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSLog(@"signKey = %@", MD5Key);
    NSLog(@"strParam = %@", strParam);
    NSString *sign = [[self md5:strParam] lowercaseString];
    NSLog(@"sign = %@", sign);
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    NSInteger canopenYL = 0;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uppay://"]]) {
        canopenYL = 1;
    }
    [parameters appendString:[NSString stringWithFormat:@"&uppay=%d",(int)canopenYL]];
    
    NSLog(@"parameters = %@", parameters);
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", Rechange_URL, parameters];
    
    [parameters release];

    NSLog(@"充值链接 %@", urlstring);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
        return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dingdingcai.com/wap/csj/charge/phone/login.jsp?sid=%@&uppay=%d",HzfSID,(int)canopenYL]];
    return url;
}

//wap提现

- (NSURL *)getMoneyUrlSysTime:(NSString *)systime withMoney:(NSString *)_money{
    NSMutableString *parameters = [[NSMutableString alloc] init];
    NSString *username = [[Info getInstance] userName];
    NSLog(@"username = %@", username);
    if ([username length] ==0) {
        username = [[[Info getInstance] mUserInfo] user_name];
    }
    [parameters appendString:[self stringWithKey:@"username" AES256Value:username]];
    
    NSString * timesys = systime;
    [parameters appendString:@"&"];
    //  [parameters appendString:[self stringWithKey:@"password" AES256Value:password]]
    [parameters appendString:[self stringWithKey:@"flag" AES256Value:timesys]];
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sid" value:HzfSID]];
    [parameters appendString:@"&"];
    NSLog(@"%@",[GC_HttpService sharedInstance].sessionId);
    [parameters appendString:[self stringWithKey:@"jsessionid" AES256Value:[GC_HttpService sharedInstance].sessionId]];
    
    NSMutableString *strParam = [NSMutableString stringWithString:parameters];
    [strParam appendString:[NSString stringWithFormat:@"&signKey=%@", MD5Key]];
    NSLog(@"signKey = %@", MD5Key);
    NSLog(@"strParam = %@", strParam);
    NSString *sign = [[self md5:strParam] lowercaseString];
    NSLog(@"sign = %@", sign);
    
    [parameters appendString:@"&"];
    [parameters appendString:[self stringWithKey:@"sign" AES256Value:sign]];
    [parameters appendString:@"&"];

    [parameters appendString:[self stringWithKey:@"money" AES256Value:_money]];
    
    
    
    NSLog(@"parameters = %@", parameters);
    NSString *urlstring = [NSString stringWithFormat:@"%@?%@", TiXian_URL, parameters];
    
    [parameters release];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
        return [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dingdingcai.com/wap/csj/tixian/loginNew.jsp?sid=%@",HzfSID]];
    
}

/**
 * MD5签名
 * 
 * @param dws
 * @return
 */
- (GC_DataWriteStream *)MD5:(GC_DataWriteStream *)_dws
{
    GC_DataWriteStream *_dws2 = [[GC_DataWriteStream alloc] initWithDataWriteStream:_dws];
    [_dws appendString1n:MD5Key];
    
    NSLog(@"add key md5:%@    leng:%d" , _dws.data ,(int)[_dws length]);
    
    
  
    UInt8 *sign = MD5WithData(_dws.data).bytes;
    UInt8 sign_len = 16;
    [_dws2.data appendBytes:&sign_len length:sizeof(sign_len)];
    [_dws2.data appendBytes:sign length:sign_len];
    
    
    
    return [_dws2 autorelease];
}

// 启动心跳消息定时器
static NSTimer *sessionIdTimer;
- (void)startHeartInfoTimer
{   
    if (sessionIdTimer) {
        [sessionIdTimer invalidate];
        sessionIdTimer = nil;
    }
	[self performSelector:@selector(onTimer:) withObject:self];
//    sessionIdTimer = [NSTimer scheduledTimerWithTimeInterval:120
//                                                      target:self
//                                                    selector:@selector(onTimer:) // 回调函数
//                                                    userInfo:nil
//                                                     repeats:YES];
}
// 关闭心跳消息定时器
- (void)stopHeartInfoTimer
{
    if (sessionIdTimer) {
        [sessionIdTimer invalidate];
        sessionIdTimer = nil;
    }
}

- (void)onTimer:(id)sender
{
	NSMutableData *postData = [[GC_HttpService sharedInstance] reqHeartInfo];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
	[httpRequest setShouldContinueWhenAppEntersBackground:YES];
    [httpRequest setDidFinishSelector:@selector(reqHeartInfoFinished:)];
    [httpRequest setDidFailSelector:@selector(reqHeartInfoFail:)];
    [httpRequest startAsynchronous];
	NSLog(@"%@",httpRequest);
}

- (void)reqHeartInfoFinished:(ASIHTTPRequest*)request
{
	NSLog(@"%@",httpRequest);
    if ([request responseData]) {
        GC_HeartInfo *heartInfo = [[GC_HeartInfo alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (heartInfo.returnId == 3000) {
            [[GC_HttpService sharedInstance] stopHeartInfoTimer];
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai LogInBySelf];
        }
        [heartInfo release];
    }
}

- (void)reqHeartInfoFail:(ASIHTTPRequest *)request {
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"needRelogin"];
}

// 获取广告
- (void)sendAdvertisementRequest
{
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetAdvertisement];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:GC_HOST_URL]];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqAdvertisementFinished:)];
    [httpRequest startAsynchronous];
}

- (void)reqAdvertisementFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_Advertisement *ad = [[GC_Advertisement alloc] initWithResponseData:[request responseData]WithRequest:request];
        [ad release];
    }
}

//查询个人信息
- (void)getPersonalInfoRequest
{
    NSMutableData *postData = [[GC_HttpService sharedInstance] personalData];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqPersonalInfoFinished:)];
    [httpRequest startAsynchronous];
}

- (void)reqPersonalInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[request responseData]WithRequest:request];
        [personalData release];
    }
}

/********************************/
/************发送数据包************/
/********************************/

- (NSMutableData *)reqRegisterData:(NSString *)username passWord:(NSString *)password
{    
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_register];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username aes256EncryptKey:AESKey];
    [dws appendString1n:password aes256EncryptKey:AESKey];
    [dws appendString1n:password aes256EncryptKey:AESKey];
    [dws writeByte:platformType]; 
    [dws appendString1n:mobilePlatform];
    [dws appendString1n:clientID];
    [dws appendString1n:sysVersion];
    [dws appendString1n:clientVersion];
    [dws appendString1n:keyresolution];
    [dws appendString1n:vendor];
        
    dws = [self MD5:dws];
    return dws.data;
}

- (NSMutableData *)reqLoginData:(NSString *)username passWord:(NSString *)password
{    
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_login];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username aes256EncryptKey:AESKey];
    [dws appendString1n:password aes256EncryptKey:AESKey];
    [dws writeByte:platformType];
    [dws appendString1n:mobilePlatform];
    [dws appendString1n:clientID];
    [dws appendString1n:sysVersion];
    [dws appendString1n:clientVersion];
    [dws appendString1n:keyresolution];
    [dws appendString1n:myclient];
    
    dws = [self MD5:dws];
    return dws.data;
}

// 4.3	心跳消息(1103)不带返回消息 
- (NSMutableData *)reqHeartInfo
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_heartInfo];
    [dws appendString1n:HzfSID];
    dws = [self MD5:dws];
    return dws.data;
}

// 《4.28开奖时间查询》
- (NSMutableData *)reqLotteryTime:(UInt16)lotteryType {
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_lotteryTime];
    [dws appendString1n:HzfSID];
    [dws writeShort:lotteryType];
        
    dws = [self MD5:dws];
    return dws.data;
}

// 《4.54合买-参与合买》
- (NSMutableData *)reqBuyTogether:(NSString *)lottery schemeNumber:(int)schemeNumber buyCount:(int)buyCount amount:(int)amount reSend:(NSInteger)resendNum{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_buyTegether];
    [dws appendString1n:HzfSID];
#ifdef isYueYuBan
    [dws appendString2n:[lottery stringByAppendingFormat:@"@%d",resendNum]];
#else
    [dws appendString2n:lottery];
#endif
    [dws writeInt:schemeNumber];
    [dws writeInt:buyCount];
    [dws writeInt:amount];
	NSLog(@"彩种Id%@",lottery);
	NSLog(@"方案编号%d",schemeNumber);
	NSLog(@"购买份数%d",buyCount);
	NSLog(@"购买金额%d",amount);
    dws = [self MD5:dws];
    
    return dws.data;
}

// 《4.55合买-合买信息》
- (NSMutableData *)reqBuyTogetherData:(NSString *)lotteryType issue:(NSString *)issue amountType:(UInt16)amountType baodi:(UInt16)baodi eachMoney:(UInt16)eachMoney isFull:(UInt16)isFull speed:(UInt16)speed recordCount:(UInt16)recordCount page:(int)page schemeType:(UInt16)schemeType sortWay:(NSString *)sortWay {   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_buyTegetherDetail];
    [dws appendString1n:HzfSID];
    [dws appendString2n:lotteryType];   // 彩种
    [dws appendString1n:issue];         // 期号
    [dws writeByte:amountType];         // 方案金额    —— 0：全部，1：3000元以上，2：500-3000元，3：100-500元，4：100元以内
    [dws writeByte:baodi];              // 保底       —— 0：全部，1：保底，2：不保底
    [dws writeByte:eachMoney];          // 每份金额    —— 0：全部，1：1元以上，2：2元以上，5：5元以上
    [dws writeByte:isFull];             // 是否满员    —— 0：全部；1：满员；2未满员
    [dws writeByte:speed];              // 进度       —— 0：全部，1：90%以上，2：50%--90%，3：50%以下
    [dws writeByte:recordCount];        // 每页条数
    [dws writeShort:page];              // 请求页
    [dws writeByte:schemeType];         // 方案类型
    [dws appendString1n:sortWay];       // 排序方式
    NSLog(@"请求id %i", reqID_buyTegetherDetail);
    NSLog(@"HzfSID %@", HzfSID);
    NSLog(@"彩种 %@", lotteryType);
    NSLog(@"期号 %@", issue);
    NSLog(@"方案金额 %i", amountType);
    NSLog(@"保底 %i", baodi);
    NSLog(@"每份金额 %i", eachMoney);
    NSLog(@"是否满员 %i", isFull);
    NSLog(@"进度 %i", speed);
    NSLog(@"每页条数 %i", recordCount);
    NSLog(@"请求页 %i", page);
    NSLog(@"方案类型 %i", schemeType);
    NSLog(@"排序方式 %@", sortWay);
    dws = [self MD5:dws];
    return dws.data;
}
//4.140合买列表
- (NSMutableData *)HMreqBuyTogetherData:(NSString *)lotteryType issue:(NSString *)issue amountType:(UInt16)amountType baodi:(UInt16)baodi eachMoney:(UInt16)eachMoney isFull:(UInt16)isFull speed:(UInt16)speed recordCount:(UInt16)recordCount page:(int)page schemeType:(UInt16)schemeType sortWay:(NSString *)sortWay {   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_hemaileibiao];
    [dws appendString1n:HzfSID];
    [dws appendString2n:lotteryType];   // 彩种
    [dws appendString1n:issue];         // 期号
    [dws writeByte:amountType];         // 方案金额    —— 0：全部，1：3000元以上，2：500-3000元，3：100-500元，4：100元以内
    [dws writeByte:baodi];              // 保底       —— 0：全部，1：保底，2：不保底
    [dws writeByte:eachMoney];          // 每份金额    —— 0：全部，1：1元以上，2：2元以上，5：5元以上
    [dws writeByte:isFull];             // 是否满员    —— 0：全部；1：满员；2未满员
    [dws writeByte:speed];              // 进度       —— 0：全部，1：90%以上，2：50%--90%，3：50%以下
    [dws writeByte:recordCount];        // 每页条数
    [dws writeShort:page];              // 请求页
    [dws writeByte:schemeType];         // 方案类型
    [dws appendString1n:sortWay];       // 排序方式
    NSLog(@"请求id %i", reqID_hemaileibiao);
    NSLog(@"HzfSID %@", HzfSID);
    NSLog(@"彩种 %@", lotteryType);
    NSLog(@"期号 %@", issue);
    NSLog(@"方案金额 %i", amountType);
    NSLog(@"保底 %i", baodi);
    NSLog(@"每份金额 %i", eachMoney);
    NSLog(@"是否满员 %i", isFull);
    NSLog(@"进度 %i", speed);
    NSLog(@"每页条数 %i", recordCount);
    NSLog(@"请求页 %i", page);
    NSLog(@"方案类型 %i", schemeType);
    NSLog(@"排序方式 %@", sortWay);
    dws = [self MD5:dws];
    return dws.data;
}


//4.5	修改密码（1105）
-(NSMutableData*)reSetPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword
{    
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_resetPassword];
    [dws appendString1n:HzfSID];
    [dws appendString1n:oldPassword aes256EncryptKey:AESKey];
    [dws appendString1n:newPassword aes256EncryptKey:AESKey];
    
    dws = [self MD5:dws];
    return dws.data;
}

// 4.7	查询个人资料（1107）
- (NSMutableData *)personalData {
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_personalData];
    [dws appendString1n:HzfSID];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.76	补充个人资料（新）（1415）（文档时间：2011-12-01）
- (NSMutableData*)reSetPersonalData:(NSString*)trueName identNum:(NSString*)identNum phoneNum:(NSString*)phoneNum email:(NSString*)email sex:(int)sex address:(NSString*)address postalCode:(NSString*)postalCode telepone:(NSString*)telepone QQ:(NSString*)qqNum
{	
    if (!address||[address isEqualToString:@""]) {
        address = @"-";
    }
    if (!postalCode||[postalCode isEqualToString:@""]) {
        postalCode = @"-";
    }
    if (!telepone||[telepone isEqualToString:@""]) {
        telepone = @"-";
    }
    if (!qqNum||[qqNum isEqualToString:@""]) {
        qqNum = @"-";
    }
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_reSetpersonalData];
    [dws appendString1n:HzfSID];
    [dws appendString1n:trueName aes256EncryptKey:AESKey];
    [dws appendString1n:identNum aes256EncryptKey:AESKey];
    [dws appendString1n:phoneNum aes256EncryptKey:AESKey];
    [dws  appendString1n:email];
    [dws writeByte:sex];
    [dws appendString1n:address];
    [dws appendString1n:postalCode];
    [dws appendString1n:telepone];
    [dws appendString1n:qqNum];
    
    dws = [self MD5:dws];
    return dws.data;
}


// 追号投注
- (NSMutableData *)zhuihaoreqBuyLotteryData:(GC_BetInfo *)_betInfo
{
	
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_zhuihaoLottry];
    [dws appendString1n:HzfSID];
    
    [dws appendString1n:_betInfo.caizhong];
    [dws appendString1n:_betInfo.wanfa];
    
    [dws appendString4n:_betInfo.betNumber];
    [dws writeInt:_betInfo.payMoney];
    [dws writeByte:_betInfo.zhuihaoType];
    [dws appendString1n:_betInfo.stopMoney];
	[dws writeInt:(int)_betInfo.betlist.count];
    
    
    if (_betInfo.betlist.count > 0) {
        for (NSString *mul in _betInfo.betlist) {
            [dws appendString1n:mul];
            NSLog(@"投注倍数 %@", mul);
        }
    }
    
    [dws writeByte:_betInfo.baomiType];
    
    
    NSLog(@"期号:%@", _betInfo.issue);
    NSLog(@"购买彩票请求id %i", reqID_zhuihaoLottry);
    NSLog(@"Hzf SID %@", HzfSID);
    NSLog(@"彩种 %@", _betInfo.caizhong);
    NSLog(@"玩法 %@", _betInfo.wanfa);
    NSLog(@"投注号码 %@", _betInfo.betNumber);
    NSLog(@"投注总金额 %i", _betInfo.payMoney);
    NSLog(@"追号设置 %d", _betInfo.zhuihaoType);
	NSLog(@"中奖多少金额后停追%@",_betInfo.stopMoney);
    NSLog(@"追号期数 %i", (int)_betInfo.betlist.count);
    
    NSLog(@"保密: %d", _betInfo.baomiType);
    dws = [self MD5:dws];
    
    return dws.data;
}

// 4.92	购买彩票，数字彩代购（新）（1431） 北京单场  投注
- (NSMutableData *)reqBuyLotteryData:(GC_BetInfo *)_betInfo reSend:(NSInteger) sendNum
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_buyLottery];
    [dws appendString1n:HzfSID];
    NSString * caizong = @"";
    if ([_betInfo.lastMatch length] > 0) {
        caizong = [NSString stringWithFormat:@"%@$%@", _betInfo.caizhong, _betInfo.lastMatch];
    }else{
        caizong = _betInfo.caizhong;
    }
    [dws appendString1n:caizong];
    NSLog(@"dws appendString1n:caizong = %@", caizong);
    [dws appendString1n:_betInfo.wanfa];    
    //期次
#ifdef isYueYuBan
    if (_betInfo.issue) {
        [dws appendString1n:[_betInfo.issue stringByAppendingFormat:@"@%d",sendNum]];
    }
    else {
        [dws appendString1n:[NSString stringWithFormat:@"@%d",sendNum]];
    }
#else
    if (_betInfo.issue) {
        [dws appendString1n:_betInfo.issue];
    }
    else {
        [dws appendString1n:@""];
    }
    
#endif
    
    
    [dws appendString4n:_betInfo.betNumber];
    [dws writeInt:_betInfo.payMoney];
    [dws writeByte:_betInfo.zhuihaoType];
	 [dws appendString1n:_betInfo.stopMoney];
	[dws writeInt:(int)_betInfo.betlist.count];
    
    
    if (_betInfo.betlist.count > 0) {
        for (NSNumber *mul in _betInfo.betlist) {
            [dws writeShort:[mul integerValue]];
            NSLog(@"投注倍数 %i", [mul intValue]);
        }
    }
    
    [dws writeByte:_betInfo.baomiType];
    
    
    NSLog(@"期号:%@", _betInfo.issue);
    NSLog(@"购买彩票请求id %i", reqID_buyLottery);
    NSLog(@"Hzf SID %@", HzfSID);
    NSLog(@"彩种 %@", _betInfo.caizhong);
    NSLog(@"玩法 %@", _betInfo.wanfa);
    NSLog(@"投注号码 %@", _betInfo.betNumber);
    NSLog(@"投注总金额 %i", _betInfo.payMoney);
    NSLog(@"追号设置 %d", _betInfo.zhuihaoType);
	NSLog(@"中奖多少金额后停追%@",_betInfo.stopMoney);
    NSLog(@"追号期数 %i", (int)_betInfo.betlist.count);
    	
     NSLog(@"保密: %d", _betInfo.baomiType);
    dws = [self MD5:dws];
    
    return dws.data;
}

// 4.81	获取彩期信息（新）（1420）
- (NSMutableData *)reqGetIssueInfo:(NSInteger)lotterytype
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getIssueInfo];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotterytype];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.103 开奖信息（新）（1442）
- (NSMutableData *)reqGetKaiJiangInfo:(NSString *)lotterytype recordCount:(int)count
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getKaiJiangInfo];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lotterytype];
    [dws writeByte:count];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.93	开奖大厅（新）（1432）[Version floatValue]
- (NSMutableData *)reqGetHallLottery
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getHallLottery];
    [dws appendString1n:HzfSID];
    dws = [self MD5:dws];
    return dws.data;
}

// 竞彩对阵查询(新) 1449
-(NSMutableData*)jingcaiDuizhenChaXun:(int)lotteryType wanfa:(int)wanfa isEnded:(NSString*)isEnded macth:(NSString*)match chaXunQiShu:(NSString*)chaXunQiShu danOrGuo:(NSString *)dgORgg{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_jingcaiDuizhen];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryType];
    [dws writeByte:wanfa];
    [dws appendString1n:isEnded];
    [dws appendString1n:match];
    if ([chaXunQiShu rangeOfString:@"null"].location != NSNotFound) {
        chaXunQiShu = @"";
    }
    [dws appendString1n:chaXunQiShu];
    [dws appendString1n:dgORgg];
//    [dws appendString1n:@""];
//    [dws appendString1n:@""];
    
    NSLog(@"lotteryType = %d", lotteryType);
    NSLog(@"wanfa = %d", wanfa);
    NSLog(@"isEnded = %@", isEnded);
    NSLog(@"match = %@", match);
    NSLog(@"chaXunQiShu = %@", chaXunQiShu);
    NSLog(@"dgORgg = %@", dgORgg);
    dws = [self MD5:dws];
    return dws.data;
}

// 4.84	账户全览（新）（1423）
- (NSMutableData *)reqAccountManager:(NSString *)userName
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_accountmanager];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.147获取余额（新）（1567）
- (NSMutableData *)reqAccountManagerNew:(NSString *)userName
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_accountmanager_New];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    dws = [self MD5:dws];
    return dws.data;
}

//4.83 奖金派送（新）（1422）
- (NSMutableData *)reBonusDistribution:(int)countOfPage currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_bonusDis];
	[dws appendString1n:HzfSID];
	[dws writeByte:countOfPage];
	[dws writeByte:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.85 奖励详情（新）（1424）
- (NSMutableData *)reAmountDetail:(NSString *)userName type:(NSString *)type startTime:(NSString *)startTime endTime:(NSString *)endTime pageNum:(int)pageNum pageSize:(int)pageSize
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_amountDetail];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws appendString1n:type];
	[dws appendString1n:startTime];
	[dws appendString1n:endTime];
	[dws writeShort:pageNum];
	[dws writeByte:pageSize];
	dws = [self MD5:dws];
	return dws.data;
}

//4.82 查询冻结金额（新）（1421）
- (NSMutableData *)refreezeDetail:(int)countOfPage currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_freezeDetail];
	[dws appendString1n:HzfSID];
	[dws writeShort:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.86 充值记录（新）（1425）
- (NSMutableData *)reRechangeRecord:(int)curTime countOfPage:(int)countOfPage currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_rechangeRecord];
	[dws appendString1n:HzfSID];
	[dws writeByte:curTime];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.65 提现记录（1404）
- (NSMutableData *)reWithdrawals:(int)way state:(int)state startTime:(NSString *)startTime endTime:(NSString *)endTime sortField:(NSString *)sortField sortStyle:(NSString *)sortStyle countOfPage:(int)countOfPage currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_withdrawals];
	[dws appendString1n:HzfSID];
	[dws writeByte:way];
	[dws writeByte:state];
	[dws appendString1n:startTime];
	[dws appendString1n:endTime];
	[dws appendString1n:sortField];
	[dws appendString1n:sortStyle];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.111支付宝充值发起（1450）
- (NSMutableData *)reAlipaySend:(NSString *)userName rechangeAmount:(NSString *)rechangeAmount
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_alipaySend];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws appendString1n:rechangeAmount];
	dws = [self MD5:dws];
	return dws.data;
}

//4.112支付宝充值同步返回（1451）
- (NSMutableData *)reAlipayReturn:(NSString *)reInfor
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_alipayReturn];
	[dws appendString1n:HzfSID];
	[dws appendString4n:reInfor];
	dws = [self MD5:dws];
	return dws.data;
}

//4.22 充值（1125）
- (NSMutableData *)reRechange:(int)iOperator card:(NSString *)card cardSecret:(NSString *)cardSecret rechangeAmount:(NSString *)rechangeAmount YHMCode:(NSString *)code
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_rechange];
	[dws appendString1n:HzfSID];
	[dws writeByte:iOperator];
	[dws appendString1n:card aes256EncryptKey:AESKey];
	[dws appendString1n:cardSecret aes256EncryptKey:AESKey];
	[dws appendString1n:rechangeAmount];
    [dws appendString1n:code];
	dws = [self MD5:dws];
	return dws.data;
}

//4.15 彩视通充值卡充值(1118) 
- (NSMutableData *)reCaiShiTong:(int)iOperator card:(NSString *)card cardSecret:(NSString *)cardSecret
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_caishitong];
	[dws appendString1n:HzfSID];
	[dws writeByte:iOperator];
	[dws appendString1n:card aes256EncryptKey:AESKey];
	[dws appendString1n:cardSecret aes256EncryptKey:AESKey];
	dws = [self MD5:dws];
	return dws.data;
}

//4.78 提现请求（新）（1417）
- (NSMutableData *)reWithdrawalsRequest:(NSString *)name code:(NSString *)code amount:(NSString *)amount bankId:(NSString *)bankId bankAddr:(NSString *)bankAddr city:(NSString *)city bankName:(NSString *)bankName bankNumber:(NSString *)bankNumber numberAgain:(NSString *)numberAgain
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_withdrawalsRequest];
	[dws appendString1n:HzfSID];
	[dws appendString1n:name aes256EncryptKey:AESKey];
	[dws appendString1n:code aes256EncryptKey:AESKey];
	[dws appendString1n:amount aes256EncryptKey:AESKey];
	[dws appendString1n:bankId];
	[dws appendString1n:bankAddr];
	[dws appendString1n:city];
	[dws appendString1n:bankName];
	[dws appendString1n:bankNumber aes256EncryptKey:AESKey];
	[dws appendString1n:numberAgain aes256EncryptKey:AESKey];
	dws = [self MD5:dws];
	return dws.data;
}

//4.77 获取用户提款资料（新）（1416）
- (NSMutableData *)reGetUserInfor:(NSString *)userName
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_getUserInfor];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	dws = [self MD5:dws];
	return dws.data;
}

//4.117身份证信息绑定及验证（1457）
- (NSMutableData *)reIdBindAndCheck:(NSString *)operType name:(NSString *)name idCode:(NSString *)idCode
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_idBindAndCheck];
	[dws appendString1n:HzfSID];
	[dws appendString1n:operType];
	[dws appendString1n:name aes256EncryptKey:AESKey];
	[dws appendString1n:idCode aes256EncryptKey:AESKey];
	dws = [self MD5:dws];
	return dws.data;
}

//4.116开户行列表（1456）
- (NSMutableData *)reBankList:(NSString *)bankName provice:(NSString *)provice city:(NSString *)city
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_bankList];
	[dws appendString1n:HzfSID];
	[dws appendString2n:bankName aes256EncryptKey:AESKey];
	[dws appendString2n:provice aes256EncryptKey:AESKey];
	[dws appendString2n:city aes256EncryptKey:AESKey];
	dws = [self MD5:dws];
	return dws.data;
}

//4.87 投注记录（新）（1426）
- (NSMutableData *)reBetRecord:(NSString *)lotteryId 
				   countOfPage:(int)countOfPage 
				   currentPage:(int)currentPage
						  name:(NSString *)userId
					   isJiang:(NSString *)isjiang
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_betRecord];
	[dws appendString1n:HzfSID];
	[dws appendString2n:lotteryId];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	[dws appendString1n:userId];
	[dws appendString1n:isjiang];
	dws = [self MD5:dws];
	return dws.data;
}

//加奖方案列表
- (NSMutableData *)LingQuJiangLi:(NSString *)lotteryId
                     countOfPage:(int)countOfPage
                     currentPage:(int)currentPage
                            name:(NSString *)userId isJiang:(NSString *)isjiang JiaJiang:(NSString *)jiajiang {

    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_JiaJiang];
	[dws appendString1n:HzfSID];
	[dws appendString2n:lotteryId];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	[dws appendString1n:userId];
	[dws appendString1n:isjiang];
    [dws appendString1n:jiajiang];
	dws = [self MD5:dws];
	return dws.data;
}

//4.88 投注记录明细（新）（1427）
- (NSMutableData *)reBetRecordInfor:(NSString *)programNumber
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_betRecordInfor];
	[dws appendString1n:HzfSID];
	[dws appendString2n:programNumber];
	dws = [self MD5:dws];
	return dws.data;
}

- (NSMutableData *)reBetRecordInfor:(NSString *)programNumber Issue:(NSString *)issue numberOfPage:(int)num Page:(int)page IsJIangli:(NSString *)isJiangli
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_betRecordInfor];
	[dws appendString1n:HzfSID];
    if (programNumber) {
        [dws appendString2n:[NSString stringWithFormat:@"%@jjyh",programNumber]];
    }
    else {
        [dws appendString2n:[NSString stringWithFormat:@"jjyh"]];
    }
	
	[dws appendString1n:issue];
	[dws writeByte:page];
	[dws writeByte:num];
    [dws appendString1n:isJiangli];
	dws = [self MD5:dws];
	return dws.data;
}


//4.118单式上传投注号码（1461）
- (NSMutableData *)reDanBetNumber:(NSString *)programAddress countOfPage:(int)countOfPage currentPage:(int)currentPage
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_danBetNumber];
	[dws appendString1n:HzfSID];
	[dws appendString1n:programAddress];
    [dws writeShort:countOfPage];
    [dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.89 追号列表（新）（1428）
- (NSMutableData *)reChaseNumberList:(int)lotteryId state:(int)state isRecord:(int)isRecord startTime:(NSString *)startTime endTime:(NSString *)endTime countOfPage:(int)countOfPage curPage:(int)curPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_chaseNumberList];
	[dws appendString1n:HzfSID];
	[dws writeShort:lotteryId];
	[dws writeByte:state];
	[dws writeByte:isRecord];
	[dws appendString1n:startTime];
	[dws appendString1n:endTime];
	[dws writeByte:countOfPage];
	[dws writeShort:curPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.90 追号明细（新）（1429）
- (NSMutableData *)reChaseDetailInfor:(NSString *)programNum
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_chaseDetailInfor];
	[dws appendString1n:HzfSID];
	[dws appendString1n:programNum];
	dws = [self MD5:dws];
	return dws.data;
}

//4.118追号-追号撤单（1458）（福彩、体彩、足彩）
- (NSMutableData *)reChaseCancle:(NSString *)programNum buyType:(NSString *)buyType
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_chaseDetailInfor];
	[dws appendString1n:HzfSID];
	[dws appendString1n:programNum];
	[dws appendString1n:buyType];
	dws = [self MD5:dws];
	return dws.data;
}

//4.94 定制跟单搜索（新）（1433）
- (NSMutableData *)reCustomizedSigSearch:(NSString *)userName
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_customizedSigSearch];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	dws = [self MD5:dws];
	return dws.data;
}

//4.97 我定制的人（新）（1436）
- (NSMutableData *)reMyCustomizedSingle:(int)countOfPage page:(int)page
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_myCustomizedSingle];
	[dws appendString1n:HzfSID];
	[dws writeByte:countOfPage];
	[dws writeShort:page];
	dws = [self MD5:dws];
	return dws.data;
}

//4.101 定制我的人（新）（1440）
- (NSMutableData *)reCustomizedMe:(int)countOfPage currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_customizedMe];
	[dws appendString1n:HzfSID];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.119定制我的人明细（新）（1462）
- (NSMutableData *)reCusMeDetial:(NSString *)lotteryId countOfPage:(int)countOfPage currentPage:(int)currentPage
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_cusMeDetil];
	[dws appendString1n:HzfSID];
    [dws appendString1n:lotteryId];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.120定制我的人明细（新）（1463）
- (NSMutableData *)reCusMeDetilRecord:(NSString *)lotteryId buyPerson:(NSString *)buyPerson countOfPage:(int)countOfPage currentPage:(int)currentPage
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_cusMeDetilRecord];
	[dws appendString1n:HzfSID];
    [dws appendString1n:lotteryId];
    [dws appendString1n:buyPerson];
	[dws writeByte:countOfPage];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.106 推荐（新）（1445）
- (NSMutableData *)reRecommendation:(NSString *)lotteryType countOfPage:(int)countOfPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_recommendation];
	[dws appendString1n:HzfSID];
	[dws appendString1n:lotteryType];
	[dws writeByte:countOfPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.102 人气定制排行榜（新）（1441）
- (NSMutableData *)rePopularCusList:(int)recordNum
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_popularCusList];
	[dws appendString1n:HzfSID];
	[dws writeByte:recordNum];
	dws = [self MD5:dws];
	return dws.data;
}

//4.105	在售的发起方案（新）（1444）
- (NSMutableData *)reSaleLauPro:(NSString *)userName gameName:(NSString *)gameName buyType:(NSString *)buyType pageSize:(int)pageSize currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_saleLauPro];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws appendString1n:gameName];
	[dws appendString1n:buyType];
	[dws writeByte:pageSize];
	[dws writeShort:currentPage];
    
	dws = [self MD5:dws];
	return dws.data;
}

//4.104 在售的跟单方案（新）（1443）
- (NSMutableData *)reSaleSigPro:(NSString *)userName gameName:(NSString *)gameName buyType:(NSString *)buyType pageSize:(int)pageSize currentPage:(int)currentPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_saleSigPro];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws appendString1n:gameName];
	[dws appendString1n:buyType];
	[dws writeByte:pageSize];
	[dws writeShort:currentPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.95 大奖战绩（新）（1434）
- (NSMutableData *)reAwardsRecord:(NSString *)userName lotteryType:(int)lotteryType
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_awardsRecord];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws writeByte:lotteryType];
	dws = [self MD5:dws];
	return dws.data;
}

//4.96 盈利统计（新）（1435）
- (NSMutableData *)reEarningsStatistics:(NSString *)userName startTime:(NSString *)startTime endTime:(NSString *)endTime currentPage:(int)currentPage countOfPage:(int)countOfPage
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_earningsStatistics];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userName];
	[dws appendString1n:startTime];
	[dws appendString1n:endTime];
	[dws writeShort:currentPage];
	[dws writeByte:countOfPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.98 定制编辑查询（新）（1437）
- (NSMutableData *)reCustomEdit:(NSString *)promoters lotteryId:(NSString *)lotteryId
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_customEdit];
	[dws appendString1n:HzfSID];
	[dws appendString1n:promoters];
	[dws appendString1n:lotteryId];
	dws = [self MD5:dws];
	return dws.data;
}

//4.99 定制编辑保存（新）（1438）
- (NSMutableData *)reCustomSave:(NSString *)attUid 
					  lotteryId:(NSString *)lotteryId 
				 customRelation:(int)customRelation 
				   sigProAmount:(NSString *)sigProAmount 
						   caps:(NSString *)caps 
					isSubscribe:(int)isSubscribe 
					customOrder:(int)customOrder 
					   orderNum:(int)orderNum 
				amountGuarantee:(NSString *)amountGuarantee
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_customSave];
	[dws appendString1n:HzfSID];
	[dws appendString1n:attUid];
	[dws appendString1n:lotteryId];
	[dws writeByte:customRelation];
	[dws appendString1n:sigProAmount];
	[dws appendString1n:caps];
	[dws writeByte:isSubscribe];
	[dws writeByte:customOrder];
	[dws writeByte:orderNum];
	[dws appendString1n:amountGuarantee];
	dws = [self MD5:dws];
	return dws.data;
}

//4.100 定制删除（新）（1439）
- (NSMutableData *)reCustomDelete:(NSString *)attUid lotteryId:(NSString *)lotteryId
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_customDelete];
	[dws appendString1n:HzfSID];
	[dws appendString1n:attUid];
	[dws appendString1n:lotteryId];
	dws = [self MD5:dws];
	return dws.data;
}

// 4.107 获取期次列表（新）（1446）
- (NSMutableData *)reqGetIssueList:(int)lotteryId count:(int)count
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getIssueList];
    [dws appendString1n:HzfSID];
    [dws writeShort:lotteryId];
    [dws writeByte:count];
    dws = [self MD5:dws];
    
    return dws.data;
}

// 4.108 胜负彩（新）（1447）
- (NSMutableData *)reqGetFootballMatch:(int)lotteryId issue:(NSString *)issue
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getFootballMatch];
    [dws appendString1n:HzfSID];
    [dws writeShort:lotteryId];
    [dws appendString1n:issue];
    dws = [self MD5:dws];
    
    return dws.data;
}

// 4.109获取竞彩，北单期数（新）（1448）
- (NSMutableData *)reqJingCaiIssue:(int)lotteryId
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_jingcaiIssue];
    [dws appendString1n:HzfSID];
    NSLog(@"hzf = %@", HzfSID);
    [dws writeByte:lotteryId];
    NSLog(@"lotterid = %d", lotteryId);
    dws = [self MD5:dws];
    return dws.data;
}


//4.91	竞彩单场赛事列表（新）（1430）
-(NSMutableData*)reqJingcaiMatch:(int)lottery wanfa:(int)wanfa
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_jingcaiMatch];
    [dws appendString1n:HzfSID];
    [dws writeByte:lottery];
    [dws writeByte:wanfa];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.53	合买-发起合买（1240）（福彩、体彩、足彩）
- (NSMutableData*)reqStartTogetherBuy:(GC_BetInfo *)_betInfo Resend:(NSInteger)sendNum
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_startTogetherBuy];
    [dws appendString1n:HzfSID];
	NSString * caizhong = @"";
    if ([_betInfo.lastMatch length] > 0) {
        caizhong = [NSString stringWithFormat:@"%@$%@", _betInfo.caizhong, _betInfo.lastMatch];
    }else{
        caizhong = _betInfo.caizhong;
    }
    
    [dws appendString2n:[NSString stringWithFormat:@"%@", caizhong]];
#ifdef isYueYuBan    
    if (_betInfo.issue) {
        [dws appendString1n:[_betInfo.issue stringByAppendingFormat:@"@%d",sendNum]];
    }
    else {
        [dws appendString1n:[NSString stringWithFormat:@"@%d",sendNum]];
    }
#else
    [dws appendString1n:_betInfo.issue];
#endif
    
    [dws appendString1n:[NSString stringWithFormat:@"%@", _betInfo.wanfa]];
    if ([_betInfo.caizhong isEqualToString:@"202"]||[_betInfo.caizhong isEqualToString:@"200"] ||[_betInfo.caizhong isEqualToString:@"201" ]||[_betInfo.caizhong isEqualToString:@"400" ]||[_betInfo.caizhong isEqualToString:@"300" ] ||[_betInfo.caizhong isEqualToString:@"301" ]) {
        if (_betInfo.modeType == 0) {
            [dws appendString1n:@"01"];
        }
        else {
            [dws appendString1n:@"02"];
        }
    }else{
        if (_betInfo.bets == 1) {
            [dws appendString1n:@"01"];
        }
        else {
            [dws appendString1n:@"02"];
        }
    }
	

    [dws appendString4n:_betInfo.betNumber];
    [dws writeInt:_betInfo.price];
    [dws writeShort:_betInfo.multiple];
    [dws writeInt:_betInfo.totalParts];
    [dws writeInt:_betInfo.rengouParts];
    [dws writeInt:_betInfo.baodiParts];
    [dws writeByte:_betInfo.tichengPercentage];
    [dws writeByte:_betInfo.secrecyType];
    [dws appendString1n:_betInfo.endTime];
    [dws appendString4n:_betInfo.schemeTitle];
    [dws appendString4n:_betInfo.schemeDescription];
	
	NSLog(@"发起合买请求id %i", reqID_startTogetherBuy);
    NSLog(@"Hzf SID %@", HzfSID);
    NSLog(@"彩种 %@", _betInfo.caizhong);
    NSLog(@"玩法 %@", _betInfo.wanfa);
    NSLog(@"期号 %@", [_betInfo.issue stringByAppendingFormat:@"@%d",(int)sendNum]);
    NSLog(@"投注号码 %@", _betInfo.betNumber);
    NSLog(@"方案金额（单倍）%i", _betInfo.price);
    NSLog(@"投注倍数 %i", _betInfo.multiple);
    NSLog(@"总份数 %i", _betInfo.totalParts);
    NSLog(@"认购份数 %i", _betInfo.rengouParts);
    NSLog(@"保底份数 %i", _betInfo.baodiParts);
    NSLog(@"提成比例 %i", _betInfo.tichengPercentage);
    NSLog(@"保密类型 %i", _betInfo.secrecyType);
    NSLog(@"方案截止日期 %@", _betInfo.endTime);
    NSLog(@"方案标题 %@", _betInfo.schemeTitle);
    NSLog(@"方案描述 %@", _betInfo.schemeDescription);
    
    dws = [self MD5:dws];
    return dws.data;
}


//北单对阵
- (NSMutableData *)beiDanreqGetZucaiJingcaiMatch:(int)lotteryType issue:(NSString *)issue isStop:(NSString *)isstop match:(NSString *)match{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqid_beidanmatch];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryType];
    [dws appendString1n:issue];
    [dws appendString1n:isstop];
    [dws appendString1n:match];
    
    dws = [self MD5:dws];
    return dws.data;

}
//北单期号
- (NSMutableData *)beiDanreqGetZucaiJingcaiIssueList:(int)lotteryId
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqid_beidanissue];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryId];
    dws = [self MD5:dws];
    return dws.data;
}


// 4.114 足彩、竞彩对阵查询（新）（1454）
- (NSMutableData *)reqGetZucaiJingcaiMatch:(int)lotteryType issue:(NSString *)issue isStop:(NSString *)isstop match:(NSString *)match
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getZucaiJingcaiMatch];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryType];
    [dws appendString1n:issue];
    [dws appendString1n:isstop];
    [dws appendString1n:match];
        
    dws = [self MD5:dws];
    return dws.data;
}

// 4.115 获取足彩竞彩，北单期数（新）（1455）
- (NSMutableData *)reqGetZucaiJingcaiIssueList:(int)lotteryId
{   
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getZucaiJingcaiIssueList];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryId];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.27	获取广告 (1130)
- (NSMutableData *)reqGetAdvertisement
{   
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:ADVersionKey];
    
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_getAdvertisement];
    [dws appendString1n:HzfSID];
    [dws writeInt:[number intValue]];
    [dws appendString1n:mobilePlatform];
    [dws appendString1n:keyresolution]; 

    dws = [self MD5:dws];
    return dws.data;
}

// 4.122竞彩-投注- （1526）
- (NSMutableData*)reqJingcaiBetting:(NSString*)key baomi:(NSInteger)baomi danfushi:(NSInteger)danfushi betData:(GC_BetInfo *)_betInfo{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_jingcaiBetting];
    [dws appendString1n:HzfSID];
    NSString * caizhong = @"";
    if ([_betInfo.lastMatch length] > 0) {
        caizhong = [NSString stringWithFormat:@"%@$%@", key,_betInfo.lastMatch];
    }else{
        caizhong = key;
    }
    
    [dws appendString2n:caizhong];
    [dws writeByte:baomi];
    [dws writeByte:danfushi];
    dws = [self MD5:dws];
    NSLog(@"id = %d", reqID_jingcaiBetting);
    NSLog(@"hzfsid = %@", HzfSID);
    NSLog(@"key = %@", key);
    NSLog(@"baomi = %d", (int)baomi);
    NSLog(@"dan shi  fu shi = %d", (int)danfushi);
    return dws.data;
}

// 4.121 获取合买方案详情投注内容
- (NSMutableData *)reqGetBTLotteryNumber:(int)schemeNumber issue:(NSString*)issue lotteryType:(NSString*)lotteryType 
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_BTLotteryNumber];
	[dws appendString1n:HzfSID];
	[dws appendString1n:[NSString stringWithFormat:@"%d",schemeNumber]];
    [dws appendString1n:issue];
    [dws writeByte:0]; 
    [dws appendString2n:lotteryType];
    
	dws = [self MD5:dws];
	return dws.data;
}

//4.129 现金流水
- (NSMutableData *)reqGetXianJinLiuShuitiaoshu:(int)tiaoshu page:(int)page{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_xianjinliushui];
	[dws appendString1n:HzfSID];
	[dws writeByte:tiaoshu];
	//[dws writeByte:tiaoshu];
    [dws writeShort:page];
	dws = [self MD5:dws];
	return dws.data;
}


//4.136 系统时间
- (NSMutableData *)reqReturnSysTime{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_systime];
    [dws appendString1n:HzfSID];
    dws = [self MD5:dws];
    return dws.data;
}

//4.1 版本检测（1101）
- (NSMutableData *)reqVersionCheck {
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_verCheck];
    [dws appendString1n:HzfSID];
   // [dws appendString1n:@"27009000000"];
    NSString * str = [NSString  stringWithFormat:@"%f", [Version floatValue]*100];
    [dws writeInt:[str intValue]];//[KHD_Version intValue]*100];//200];//
    [dws appendString1n:mobilePlatform];
    [dws appendString1n:sysVersion];
    [dws appendString1n:keyresolution];
    NSLog(@"[Version intValue]*100] = %d", [str intValue]);
    NSLog(@"请求id %d", reqID_verCheck);
    NSLog(@"HzfSID %@", HzfSID);
//    NSLog(@"客户端版本 %@", KHD_Version);
    //NSLog(@"接入平台类型 %d", platformType);
    NSLog(@"系统版本 %@", sysVersion);
    NSLog(@"分辨率 %@", keyresolution);
    NSLog(@"%d", [str intValue]);
    NSLog(@"%@", mobilePlatform);
    dws = [self MD5:dws];
    return dws.data;
}

- (NSMutableData *)bigHunToureqGetIssueInfo:(NSString *)changciInfo cishu:(NSInteger)cishu fangshi:(NSString *)fangshi shedan:(NSString *)shedan beishu:(NSInteger)beishu touzhuInfo:(NSString *)touzhuxuanxiang lottery:(NSString *)lottery play:(NSString * )play ddInfo:(NSString * )ddInfo ddpvInfo:(NSString *)ddpvInfo{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:redID_newyuji];
    [dws appendString1n:HzfSID];
    [dws appendString2n:changciInfo];
    [dws writeByte:cishu];
    [dws appendString1n:fangshi];
    [dws appendString1n:shedan];
    [dws writeByte:beishu];
    [dws appendString2n:touzhuxuanxiang];
    [dws appendString1n:lottery];
    [dws appendString1n:play];
    [dws appendString1n:ddInfo];
    [dws appendString2n:ddpvInfo];
    
    NSLog(@"id = %d", redID_newyuji);
    NSLog(@"hzfsid = %@", HzfSID);
    NSLog(@"chang ci info = %@", changciInfo);
    NSLog(@"ci shu  = %d", (int)cishu);
    NSLog(@"fang shi = %@", fangshi);
    NSLog(@"she dan = %@", shedan);
    NSLog(@"bei shu = %d", (int)beishu);
    NSLog(@"tou zhu xuang xiang = %@", touzhuxuanxiang);
    NSLog(@"lottery = %@", lottery);
    NSLog(@"ddInfo = %@", ddInfo);
    NSLog(@"play = %@",play);
    NSLog(@"ddpvInfo = %@", ddpvInfo);
    dws = [self MD5:dws];
    
    
    return dws.data;

    
}

//4.137 获取预测奖金
- (NSMutableData *)reqGetIssueInfo:(NSString *)changciInfo cishu:(NSInteger)cishu fangshi:(NSString *)fangshi shedan:(NSString *)shedan beishu:(NSInteger)beishu touzhuxuanxiang:(NSString *)touzhuxuanxiang lottrey:(NSString *)lottery  play:(NSString * )play {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_yuji];
    [dws appendString1n:HzfSID];
    [dws appendString2n:changciInfo];
    [dws writeByte:cishu];
    [dws appendString1n:fangshi];
    [dws appendString1n:shedan];
    [dws writeByte:beishu];
    [dws appendString2n:touzhuxuanxiang];
    [dws appendString1n:lottery];
    [dws appendString1n:play];
   
    
    NSLog(@"id = %d", reqID_yuji);
    NSLog(@"hzfsid = %@", HzfSID);
    NSLog(@"chang ci info = %@", changciInfo);
    NSLog(@"ci shu  = %d", (int)cishu);
    NSLog(@"fang shi = %@", fangshi);
    NSLog(@"she dan = %@", shedan);
    NSLog(@"bei shu = %d", (int)beishu);
    NSLog(@"tou zhu xuang xiang = %@", touzhuxuanxiang);
    
    
    dws = [self MD5:dws];

    
    return dws.data;
}
//4.138 胜负彩 过关统计
- (NSMutableData *)reqGuoGuanTongJiUserName:(NSString *)username caizhong:(NSString *)caizhong issue:(NSString *)issue wanfa:(NSString *)wanfa meiyejilushu:(NSInteger)tiaoshu dangqianye:(NSInteger)page{
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_guoguan];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username];
    [dws appendString1n:caizhong];
    [dws appendString1n:issue];
    [dws appendString1n:wanfa];
    [dws writeByte:tiaoshu];
    [dws writeByte:page];
    
    dws = [self MD5:dws];
    return dws.data;
}

//4.139他的合买列表查询

- (NSMutableData *)reHemaiWithLottery:(NSString *)lotteryId 
						  countOfPage:(int)countOfPage 
						  currentPage:(int)currentPage
								 name:(NSString *)userId
{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_Hemai];
	[dws appendString1n:HzfSID];
	[dws appendString1n:userId];
	[dws appendString1n:lotteryId];
	[dws writeByte:currentPage];
	[dws writeByte:countOfPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.144 往期开奖号码查询
- (NSMutableData *)reWangqiWithLottery:(NSString *)lotteryId 
						  countOfPage:(int)countOfPage{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_WangQiKaiJiang];
	[dws appendString1n:HzfSID];
	[dws appendString1n:lotteryId];
	[dws writeByte:countOfPage];
	dws = [self MD5:dws];
	return dws.data;
}

//4.143 中奖及投注消息

- (NSMutableData *)reZhongjiangWithLottery:(NSString *)lotteryId 
									   iss:(NSString *)iss
							   countOfPage:(int)countOfPage{
	GC_DataWriteStream *dws = [GC_DataWriteStream stream];
	[dws writeShort:reqID_WangQiZhongJiang];
	[dws appendString1n:HzfSID];
	[dws appendString1n:lotteryId];
	[dws appendString1n:iss];
	[dws writeByte:countOfPage];
	dws = [self MD5:dws];
	return dws.data;
}

//北京单场对阵信息
- (NSMutableData *)reBeiJingDanChangLotteryType:(NSInteger)lotteryType wanfa:(NSInteger)wanfa isStop:(NSString *)isstop match:(NSString *)match issue:(NSString *)issue{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_BeiDanDuiZhen];
    [dws appendString1n:HzfSID];
    [dws writeByte:lotteryType];
    [dws writeByte:wanfa];
    [dws appendString1n:isstop];
    [dws appendString1n:match];
    [dws appendString1n:issue];
    
    NSLog(@"lotteryType = %d", (int)lotteryType);
    NSLog(@"wanfa = %d", (int)wanfa);
    NSLog(@"isstop = %@", isstop);
    NSLog(@"match = %@", match);
    NSLog(@"issue = %@", issue);
    
    dws = [self MD5:dws];
    return dws.data;

}
//奥运彩票期次获取
- (NSMutableData *)YaoYunQiCiWanFa:(NSString *)wanfa{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:AY_qicihuoqu];
    [dws appendString1n:HzfSID];
    [dws appendString1n:wanfa];
    dws = [self MD5:dws];
    return dws.data;

}
//奥运胜负对阵
- (NSMutableData *)yaoyunDuiZhenIssue:(NSString *)issue{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:AY_shengfuduizhen];
    [dws appendString1n:HzfSID];
    NSLog(@"%@", HzfSID);
    [dws appendString1n:issue];
    dws = [self MD5:dws];
    return dws.data;
}

// 奥运第一名和金银铜 

- (NSMutableData *)AoYunDiyiAndJinyin:(NSString *)wanfa Issue:(NSString *)issue {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:AY_diyiAndjinyin];
    [dws appendString1n:HzfSID];
    
    [dws appendString1n:wanfa];
    [dws appendString1n:issue];
    dws = [self MD5:dws];
    return dws.data;
    
}

//4.148 过关统计信息
- (NSMutableData *)guoGuanXinXiCaiZhong:(NSString *)caizhong issue:(NSString *)issue fenzhong:(NSString *)fenzhong;{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_guoGuanTongJi];
    [dws appendString1n:HzfSID];
    [dws appendString1n:caizhong];
    [dws appendString1n:issue];
    [dws appendString1n:fenzhong];
    dws = [self MD5:dws];
    
    NSLog(@"caizhong = %@", caizhong);
    NSLog(@"issue = %@", issue);
    
    return dws.data;
}

// 奖池查询
- (NSMutableData *)JiangChi:(NSString *)caizhong other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_JiangChiChaXun];
    [dws appendString1n:HzfSID];
    [dws appendString1n:caizhong];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    
    NSLog(@"caizhong = %@", caizhong);
    
    return dws.data;
}

//活跃界面
- (NSMutableData *)huoYueJieMianInfo{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:huoyue_info];
    [dws appendString1n:HzfSID];
    [dws appendString1n:@""];
     dws = [self MD5:dws];
    return dws.data;
}

//跟单用户
- (NSMutableData *)getGenDanPersonWith:(NSString *)FanganHao 
                               PageNum:(NSInteger)Num 
                               OnePage:(NSInteger)onePage
                                 other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GenDan];
    [dws appendString1n:HzfSID];
    [dws appendString1n:FanganHao];
    [dws writeByte:Num];
    [dws writeByte:onePage];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
    
}

//获取预测奖金（抄单）
- (NSMutableData *)chaoDanYuJiChangCi:(NSString *)changciInfo guoGuanCiShu:(NSInteger)cishu fangShi:(NSString *)fangshi sheDanChangCi:(NSString *)danchangci beishu:(NSInteger)beishu touzhuxuanxiang:(NSString *)xuanxiang caizhong:(NSInteger)caizhong wanfa:(NSInteger)wanfa issue:(NSString *)issue{
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:ChaoDanYuJi];
    [dws appendString1n:HzfSID];
    [dws appendString2n:changciInfo];
    [dws writeByte:cishu];
    [dws appendString1n:fangshi];
    [dws appendString1n:danchangci];
    [dws writeByte:beishu];
    [dws appendString2n:xuanxiang];
    [dws writeByte:caizhong];
    [dws writeByte:wanfa];
    [dws appendString1n:issue];
    
    NSLog(@"changci %@", changciInfo);
     NSLog(@"cishu %d", (int)cishu);
     NSLog(@"fangshi %@", fangshi);
    NSLog(@"danchangci %@", danchangci);
    NSLog(@"beishu %d", (int)beishu);
    NSLog(@"xuanxiang %@", xuanxiang);
    NSLog(@"caizhong %d", (int)caizhong);
    NSLog(@"wanfa %d",(int) wanfa);
    NSLog(@"issue %@", issue);
    
    dws = [self MD5:dws];
    return dws.data;
}

// 获取session
- (NSMutableData *)getSessionByUserName:(NSString *)userName {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqSessionIDByUserName];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    dws = [self MD5:dws];
    return dws.data;
}

//4.141判断是否是当前期次
- (NSMutableData *)panDuanDangQianQiIssue:(NSString *)issues caizhong:(NSString *)caiz {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:dangqianqi];
    [dws appendString1n:HzfSID];
    [dws appendString1n:issues];
    [dws appendString1n:caiz];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    
    NSLog(@"issue = %@", issues);
    NSLog(@"caizhong = %@", caiz);
    
    return dws.data;
}

//4.143获取追号期数（新）（1563）
- (NSMutableData *)huoQuQiHaoLotteryId:(NSString *)lotid shuliang:(NSInteger)countlot{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:zuihaohuoque];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lotid];
    [dws writeByte:countlot];
    dws = [self MD5:dws];
    
    NSLog(@"LotteryId = %@", lotid);
    NSLog(@"caizhong = %d", (int)countlot);
    
    return dws.data;
}

- (NSMutableData *)getShiJiHaoByCaiZhong:(NSString *)lotteryId issue:(NSString *)issue Other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:ShiJiHao];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lotteryId];
    [dws appendString1n:issue];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    
    NSLog(@"LotteryId = %@", lotteryId);
    NSLog(@"期号 = %@", issue);
    
    return dws.data;
}


//4.148完善用户信息并赠送奖金
- (NSMutableData *)wanShanUseridcard:(NSString *)idcard userid:(NSString *)uid trueName:(NSString *)name mobile:(NSString *)mobile{
    
    NSLog(@"idcard = %@", idcard);
    NSLog(@"uid = %@", uid);
    NSLog(@"name = %@", name);
    NSLog(@"mobile = %@", mobile);
    NSLog(@"UDIDFromMac = %@", [UDIDFromMac uniqueGlobalDeviceIdentifier]);
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:yonghuxinxisheding];
    [dws appendString1n:HzfSID];
    [dws appendString2n:idcard aes256EncryptKey:AESKey];
    [dws appendString1n:uid];
    [dws appendString1n:name aes256EncryptKey:AESKey];
    [dws appendString1n:mobile aes256EncryptKey:AESKey];
    [dws appendString1n:[UDIDFromMac uniqueGlobalDeviceIdentifier]];
    [dws appendString1n:kSouse];
     dws = [self MD5:dws];
    return dws.data;
}

//4.152 保存好声音
- (NSMutableData *)SaveGoodVoiceWithOrderId:(NSString *)orderid Type:(NSInteger)type Data:(NSData *)data Time:(NSInteger)time UserName:(NSString *)username Other:(NSString *)other {
    NSLog(@"orderid = %@, username = %@", orderid, username);
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:SaveGoodVocie];
    [dws appendString1n:HzfSID];
    [dws appendString1n:orderid];
    [dws writeByte:type];
    if (data) {
        [dws addFieldInt:data];
    }
    else {
        [dws addFieldInt:[NSData data]];
    }
    
    [dws writeByte:time];
    [dws appendString1n:username];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
}

//4.153  下载好声音
- (NSMutableData *)DownLoadGoodVoiceWithOrderId:(NSString *)orderid Other:(NSString *)other{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    NSLog(@"orderid = %@\n other = %@",orderid,other);
    [dws writeShort:DownLoadVoice];
    [dws appendString1n:HzfSID];
    [dws appendString1n:orderid];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
}

//5.154  赞好声音
- (NSMutableData *)ZanGoodVoiceWithOrderId:(NSString *)orderid
                                   VocieID:(NSString *)voiceid
                                  UserName:(NSString *)username
                                     Other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:ZanGoodVoice];
    [dws appendString1n:HzfSID];
    [dws appendString1n:voiceid];
    [dws appendString1n:orderid];
    [dws appendString1n:username];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
}

//4.155 修改方案保密类型  （1575）
- (NSMutableData *)EditBaomiWithOrderId:(NSString *)orderid UserName:(NSString *)username Baomi:(NSString *)baomi XuanYan:(NSString *)xuanyan Other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:editeBaomi];
    [dws appendString1n:HzfSID];
    [dws appendString1n:orderid];
    [dws appendString1n:baomi];
    [dws appendString1n:username];
    [dws appendString2n:xuanyan];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
}

//4.161获取可追号最大期数（新）（1581）
- (NSMutableData *)maxIssueLotteryId:(NSString *)lotterId{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:maxIssue];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lotterId];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    return dws.data;
}

//4.159领取奖励 1579
- (NSMutableData *)getJiangLiWithOrderId:(NSString *)orderid NickName:(NSString *)nickname Other:(NSString *)other{
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqLingJiang];
    [dws appendString1n:orderid];
    [dws appendString1n:nickname];
    [dws appendString1n:other];
    dws = [self MD5:dws];
    return dws.data;
}

//彩种信息 1583
- (NSMutableData *)getCaiZhongInfo:(NSString *)lotteryID {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqCaiZhongInfo];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lotteryID];
    dws = [self MD5:dws];
    return dws.data;
}

//4.56	合买-合买撤单（1243）
- (NSMutableData *)ChedanByFananID:(NSString *)fananID {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_CheDan];
    [dws appendString1n:HzfSID];
    [dws appendString1n:fananID];
    [dws appendString1n:[[Info getInstance] userName]];
    dws = [self MD5:dws];
    return dws.data;
}

//1.22	TCL银联无卡支付
- (NSMutableData *)upmpMoney:(NSString * )money userName:(NSString *)name YHMCode:(NSString *)code{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_upmp];
    [dws appendString1n:HzfSID];
    [dws appendString1n:money];
    [dws appendString1n:name];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;

}
// 2.111 支付宝充值
- (NSMutableData *)ZhiFuBaoMoney:(NSString * )money userName:(NSString *)name YHMCode:(NSString *)code{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_zhifuBao];
    [dws appendString1n:HzfSID];
//    if (name) {
//        name = [NSString stringWithFormat:@"%@_jijian",name];
//    }
    [dws appendString1n:name];
    [dws appendString1n:money];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;
}

//1.72 奖金优化
- (NSMutableData *)JJYHWithBetInfo:(GC_BetInfo *)_betInfo Type:(NSInteger) type {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_JJYH];
    [dws appendString1n:HzfSID];
    [dws appendString1n:_betInfo.lotteryId];
    [dws appendString2n:_betInfo.betNumber];
    [dws writeByte:type];
    [dws appendString1n:[NSString stringWithFormat:@"%d",_betInfo.prices]];
    [dws appendString1n:_betInfo.wanfa];
    NSLog(@"lotteryId = %@",_betInfo.lotteryId);
    NSLog(@"betNumber = %@",_betInfo.betNumber);
    NSLog(@"type = %d",(int)type);
    NSLog(@"prices = %d",_betInfo.prices);
    NSLog(@"wanfa = %@",_betInfo.wanfa);
    dws = [self MD5:dws];
    return dws.data;
}

//1.73	推广短信设置（1589）

- (NSMutableData *)TGDXSZWithUserName:(NSString *)username type:(NSString *)type operateType:(NSString *)operate{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_TGDXSZ];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username];
    [dws appendString1n:type];
    [dws appendString1n:operate];
    
    NSLog(@"username = %@",username);
    NSLog(@"type = %@",type);
    NSLog(@"operate = %@",operate);
  
    dws = [self MD5:dws];
    return dws.data;
}

//1.76	充值列表顺序  （1592）
-(NSMutableData *)rechargeSequence
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:RECHARGE_SEQUENCE];
    [dws appendString1n:HzfSID];
    [dws appendString1n:@"1_1"];
    [dws appendString1n:[[Info getInstance] userName]];
    dws = [self MD5:dws];
    return dws.data;
}

//1.78	我的追号记录（1594）
- (NSMutableData *)myLotteryZhuiHaoWithCount:(NSString *)count page:(NSString *)page userName:(NSString *)user{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:MYZHUIHAO];
    [dws appendString1n:HzfSID];
    [dws writeByte:[count intValue]];
    [dws writeByte:[page intValue]];
    [dws appendString1n:user];
    
    NSLog(@"条数 %@", count);
    NSLog(@"页数 %@", page);
    NSLog(@"用户名 %@", user);
    
    dws = [self MD5:dws];
    return dws.data;
    
    

}

//1.79	追号明细（1595）
- (NSMutableData *)ZhuihaoInfoWithID:(NSString *)infoID showType:(NSInteger)type count:(NSInteger)count page:(NSInteger)page{
    
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:ZHUIHAOINFO];
    [dws appendString1n:HzfSID];
    [dws appendString1n:infoID];
    [dws writeByte:type];
    [dws writeByte:count];
    [dws writeByte:page];
    NSLog(@"方案id %@", infoID);
    NSLog(@"显示状态 %d", (int)type);
    NSLog(@"每页条数%d  当前页%d", (int)count,(int) page);
    dws = [self MD5:dws];
    return dws.data;
}
//1.80	追号、合买撤单（1596）
- (NSMutableData *)chedanWithID:(NSString *)fanganid type:(NSInteger)type{//0, 追号方案整体撤单；1，单个追号方案2，合买方案撤单
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:ALLCHEDAN];
    [dws appendString1n:HzfSID];
    [dws appendString1n:fanganid];
    [dws writeByte:type];
    NSLog(@"方案id %@", fanganid);
    NSLog(@"状态 %d",(int) type);
    dws = [self MD5:dws];
    return dws.data;
}

//第三方浏览器打开调用方法
- (NSURL *)changeURLToTheOther:(NSURL *)oldURL{
    if (!oldURL) {
        return nil;
    }
    NSString *urlstring = [NSString stringWithFormat:@"%@",oldURL];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]]) {
        urlstring = [NSString stringWithFormat:@"ucbrowser://%@",urlstring];
    }
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"dolphin://"]]) {
        urlstring = [NSString stringWithFormat:@"dolphin://%@",urlstring];
    }
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) {
        urlstring = [NSString stringWithFormat:@"googlechrome://%@",[urlstring stringByReplacingOccurrencesOfString:@"http://" withString:@""]];
    }
//    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"360://"]]) {
//        urlstring = [NSString stringWithFormat:@"360://%@",urlstring];
//    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlstring]]) {
        return [NSURL URLWithString:urlstring];
    }
    return nil;
    
}

//连连支付
- (NSMutableData *)reqLianlianYintong:(NSString *)money YHMCode:(NSString *)code{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_lianlianYiTong];
    [dws appendString1n:HzfSID];
    [dws appendString1n:money];
    [dws appendString1n:[[Info getInstance] userName]];
    [dws appendString1n:@"2"];//appType ios 是2
    [dws appendString1n:code];
    NSLog(@"充值金额 %@", money);
    dws = [self MD5:dws];
    return dws.data;
}

//4.19	联动优势  信用卡快捷支付 （1562）
- (NSMutableData *)umpayMoney:(NSString * )money YHMCode:(NSString *)code
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_umpay];
    [dws appendString1n:HzfSID];
    [dws appendString1n:money];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;
}

//4.91	彩金宝年化收益接口 （1605）
- (NSMutableData *)yearEarningsWithUserName:(NSString *)userName{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:CJBYearEarnings];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    dws = [self MD5:dws];
    return dws.data;

}

//4.92	彩金宝收益详情 （1606）

- (NSMutableData *)earningsInfoWithUserName:(NSString *)userName date:(NSInteger)countDate{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:CJBEarningsInfo];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    [dws writeByte:countDate];
    dws = [self MD5:dws];
    return dws.data;

}

//1.83 抽奖 (1598)
- (NSMutableData *)choujiangWithUserId:(NSString *)userid {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_choujiang];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userid];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    return dws.data;
}
//1.85 中奖名单（1600)
- (NSMutableData *)ZhongJiangMingDan:(NSInteger)pageNum PageCount:(NSInteger)pageCount {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_chouMingDan];
    [dws appendString1n:HzfSID];
    [dws writeByte:pageCount];
    [dws writeByte:pageNum];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    return dws.data;
}
//1.86	用户积分主界面（1601）
- (NSMutableData *)chouCiShuWithUserId:(NSString *)userid {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_ChouJiangCiShu];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userid];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    return dws.data;
}
//4.94	冠军、冠亚军玩法赛程（1608）
- (NSMutableData *)championWithLotteryId:(NSString *)lottery{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:GYMATCHID];
    [dws appendString1n:HzfSID];
    [dws appendString1n:lottery];
    dws = [self MD5:dws];
    return dws.data;
}
//4.96 积分详情 (1610)

- (NSMutableData *)pointMessageWithUserID:(NSString *)userName andcurPage:(NSInteger)page pageCount:(NSInteger)pagecount
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_PointMessage];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    [dws writeByte:page];
    [dws writeByte:pagecount];
    dws = [self MD5:dws];
    return dws.data;
}

//1.87	用户中奖领取地址（1602）
- (NSMutableData *)ZhongJiangDiZhiWithUserId:(NSString *)userid Name:(NSString *)name Mobile:(NSString *)mobile Addreas:(NSString *)addreas YouBian:(NSString *)youbian Other:(NSString *)other {
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_Dizhi];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userid];
    [dws appendString1n:name];
    [dws appendString1n:mobile];
    [dws appendString2n:addreas];
    [dws appendString1n:youbian];
    [dws appendString1n:@""];
    dws = [self MD5:dws];
    return dws.data;
}
//4.99 积分兑换彩金 (1612)
-(NSMutableData *)pointDuiHuanCaiJinWithUserName:(NSString *)username andCaiJin:(NSString *)caijin point:(NSString *)point
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_DuiHuanCaiJin];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username];
    [dws appendString1n:caijin];
    [dws appendString1n:point];
    dws = [self MD5:dws];
    return dws.data;
}
//4.98 可兑换彩金项 (1611)
-(NSMutableData *)canExchangeWithType:(NSString *)_type
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_CanDuiHuanCaiJin];
    [dws appendString1n:HzfSID];
    [dws appendString1n:_type];
    dws = [self MD5:dws];
    return dws.data;
}

// 4.101 微信充值 （1616）
- (NSMutableData *)reqWeiXinChongZhi:(NSString *)money  withYHMCode:(NSString *)code{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_WeiXinChongZhi];
    [dws appendString1n:HzfSID];
    [dws appendString1n:money];
    [dws appendString1n:[[Info getInstance] userName]];
    [dws appendString1n:@"2"];//appType ios 是2
    [dws appendString1n:code];
    NSLog(@"充值金额 %@", money);
    NSLog(@"优惠码code %@",code);
    dws = [self MD5:dws];
    return dws.data;
}

//4.106 查询用户银行卡信息 (1620)

- (NSMutableData *)getUserBankCardList
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_userBankCardList];
    [dws appendString1n:HzfSID];
    [dws appendString1n:@"2"];//appType ios 是2
    dws = [self MD5:dws];
    return dws.data;
}
//4.105 银联回拨是否成功   (1619)
- (NSMutableData *)yinLianBackIsSucc
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_yinLianBackInfo];
    [dws appendString1n:HzfSID];
    [dws appendString1n:@"2"];//appType ios 是2
    dws = [self MD5:dws];
    return dws.data;
}
//4.107 添加提现银行卡    (1621)
- (NSMutableData *)addBankCardWithTrueName:(NSString *)_trueName idCard:(NSString *)_idCard bankNum:(NSString *)_banknum bankPro:(NSString *)_pro bankCity:(NSString *)_city bankID:(NSString *)_bankid bankAllName:(NSString *)_bankname
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_addBankCard];
    [dws appendString1n:HzfSID];
    [dws appendString1n:_trueName];
    [dws appendString1n:@"2"];//appType ios 是2
    [dws appendString1n:_idCard];
    [dws appendString1n:_banknum];
    [dws appendString1n:_pro];
    [dws appendString1n:_city];
    [dws appendString1n:_bankid];
    [dws appendString1n:_bankname];
    dws = [self MD5:dws];
    return dws.data;
}

//4.108  设置默认银行卡  (1622)
- (NSMutableData *)setDefaultBankCardWithBankID:(NSString *)_bankid
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_setDefaultBankCard];
    [dws appendString1n:HzfSID];
    [dws appendString1n:_bankid];
    [dws appendString1n:@"2"];//appType ios 是2
    dws = [self MD5:dws];
    return dws.data;
}
//4.109  用户防沉迷状态信息 (1623)
- (NSMutableData *)getUSerFangChenMiMessage
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_FangChenMiMessage];
    [dws appendString1n:HzfSID];
    [dws appendString1n:[[Info getInstance] userName]];
    [dws appendString1n:@"2"];
    dws = [self MD5:dws];
    return dws.data;
}

//4.113	手机QQ钱包支付
- (NSMutableData *)reqQQpay:(NSString *)money withYHMCode:(NSString *)code{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_QQPay];
    [dws appendString1n:HzfSID];
    [dws appendString1n:[[Info getInstance] userName]];
    [dws appendString1n:money];
    [dws appendString1n:code];
    [dws appendString1n:@"2"];//appType ios 是2
    NSLog(@"充值金额 %@", money);
    dws = [self MD5:dws];
    return dws.data;
}

//4.120 充值订单是否成功
- (NSMutableData *)reqPrepaidOrder:(NSString *)orderNum{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_PrepaidOrderIsSucc];
    [dws appendString1n:HzfSID];
    [dws appendString1n:orderNum];
    NSLog(@"充值单号:%@",orderNum);
    dws = [self MD5:dws];
    return dws.data;
}
//4.122 获取用户优惠码 1635
- (NSMutableData *)reqGetUserYHMListStatus:(NSString *)status pageNum:(NSInteger)pagenum pageCount:(NSInteger)pagecount{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetUserYHMList];
    [dws appendString1n:HzfSID];
    [dws appendString1n:status];
    [dws writeShort:pagenum];
    [dws writeShort:pagecount];
    dws = [self MD5:dws];
    return dws.data;
    
}
//4.124 我的奖品包(1638)
- (NSMutableData *)req_GetMyPrizeMes:(NSString *)username pageNum:(NSInteger)pagenum pageSize:(NSInteger)pagesize{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetMyPrize];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username];
    [dws writeByte:pagenum];
    [dws writeByte:pagesize];
    dws = [self MD5:dws];
    return dws.data;
}
//4.123积分兑换优惠码 （1637）
- (NSMutableData *)req_pointExChangeYHM:(NSString *)userName withCode:(NSString *)code{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_DuiHuanYHM];
    [dws appendString1n:HzfSID];
    [dws appendString1n:userName];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;
}
//4.123使用优惠码 (1636)
- (NSMutableData *)req_useYHMWithOrderNum:(NSString *)order YHMCode:(NSString *)code{

    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_UseYHM];
    [dws appendString1n:HzfSID];
    [dws appendString1n:order];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;
}

//4.126	 Pk赛积分投注（1640）
- (NSMutableData *)reqJiFenBuyJiFenInfo:(JiFenBetInfo *)jiFenInfo
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_jiFenBuyLottery];
    [dws appendString1n:HzfSID];
    [dws appendString1n:[[Info getInstance] userName]];
    [dws appendString1n:jiFenInfo.caiZhong];
    [dws appendString1n:jiFenInfo.wanFa];
    [dws appendString1n:jiFenInfo.touZhu];
    [dws appendString1n:jiFenInfo.guoGuan];
    [dws appendString1n:jiFenInfo.beiShu];
    [dws appendString1n:jiFenInfo.payJiFen];
    [dws appendString1n:jiFenInfo.betNumber];
    [dws appendString1n:jiFenInfo.peiLv];
    if (jiFenInfo.issue) {
        [dws appendString1n:jiFenInfo.issue];
    }
    else {
        [dws appendString1n:@""];
    }
    
    NSLog(@"购买彩票请求id %i", reqID_jiFenBuyLottery);
    NSLog(@"Hzf SID %@", HzfSID);
    NSLog(@"用户名 %@", [[Info getInstance] userName]);
    NSLog(@"彩种 %@", jiFenInfo.caiZhong);
    NSLog(@"玩法 %@", jiFenInfo.wanFa);
    NSLog(@"投注方式 %@", jiFenInfo.touZhu);
    NSLog(@"过关方式 %@", jiFenInfo.guoGuan);
    NSLog(@"倍数 %@", jiFenInfo.beiShu);
    NSLog(@"投注积分 %@", jiFenInfo.payJiFen);
    NSLog(@"投注内容 %@", jiFenInfo.betNumber);
    NSLog(@"赔率 %@", jiFenInfo.peiLv);
    NSLog(@"期号:%@", jiFenInfo.issue);
    
    dws = [self MD5:dws];
    
    return dws.data;
}

//4.125 Pk赛赛程（1639）
-(NSMutableData *)req_GetPKList:(NSString *)qici
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKList];
    [dws appendString1n:HzfSID];
    [dws appendString1n:qici];
    dws = [self MD5:dws];
    return dws.data;
}
//4.127	Pk赛投注记录（1641）
-(NSMutableData *)req_GetPKMyRecordUser:(NSString *)username recordType:(NSString *)type caizhongId:(NSString *)caiId pageNum:(NSInteger)pagenum pageCount:(NSInteger)pagecount
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKMyRecord];
    [dws appendString1n:HzfSID];
    [dws appendString1n:username];
    [dws appendString1n:type];
    [dws appendString1n:caiId];
    [dws writeShort:pagenum];
    [dws writeShort:pagecount];
    dws = [self MD5:dws];
    return dws.data;
}
//4.129 Pk赛排行榜（1643）
-(NSMutableData *)req_GetPKRanking:(NSString *)type caizhongId:(NSString *)caiId qici:(NSString *)qici
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKRanking];
    [dws appendString1n:HzfSID];
    [dws appendString1n:type];
    [dws appendString1n:caiId];
    [dws appendString1n:qici];
    dws = [self MD5:dws];
    return dws.data;
}
//4.128	Pk赛积方案详情（1642）
-(NSMutableData *)req_GetPKDetail:(NSString *)code
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKDetail];
    [dws appendString1n:HzfSID];
    [dws appendString1n:code];
    dws = [self MD5:dws];
    return dws.data;
}
//4.130  Pk赛报名参赛（1644）
-(NSMutableData *)req_GetPKBaomingCansai
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKBaoMingCanSai];
    [dws appendString1n:HzfSID];
    [dws appendString1n:[[Info getInstance] userName]];
    dws = [self MD5:dws];
    return dws.data;
}
//4.131	Pk赛期次（1645）
-(NSMutableData *)req_GetPKQiciCaizhong:(NSString *)caizhong
{
    GC_DataWriteStream * dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetPKQici];
    [dws appendString1n:HzfSID];
    [dws appendString1n:caizhong];
    dws = [self MD5:dws];
    return dws.data;
}


// 4.24 焦点赛事对阵查询（1664）
-(NSMutableData*)getFocusMatch
{
    GC_DataWriteStream *dws = [GC_DataWriteStream stream];
    [dws writeShort:reqID_GetFocusMatch];
    [dws appendString1n:HzfSID];
    [dws writeByte:1];
    [dws writeByte:1];
    [dws appendString1n:@"-"];
    [dws appendString1n:@"-"];
    [dws appendString1n:@"-"];
    [dws appendString1n:@"dg"];

    dws = [self MD5:dws];
    return dws.data;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
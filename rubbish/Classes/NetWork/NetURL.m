//
//  HttpService.m
//  caibo
//
//  Created by jacob on 11-5-27.
//  Copyright 2011 __MyCompanyName__. All righfts reserved.
//
//  yao

#import "NetURL.h"
#import "UDIDFromMac.h"
#import <CommonCrypto/CommonDigest.h>
#import "Info.h"
#include <sys/types.h>
#import "GC_NSString+AESCrypt.h"
#include <sys/sysctl.h>

@implementation NetURL

+ (NSString *)accesstokenFunc{
    NSString * accesstokenString = @"";
    NSString * infosave = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
    if (infosave) {
        NSArray * infoarr = [infosave componentsSeparatedByString:@";"];
        if ([infoarr count] >= 12) {
            accesstokenString = [infoarr objectAtIndex:11];
            
        }
        
    }
    return accesstokenString;
}

+ (NSMutableString *)loginReturnPublicUse:(NSMutableString *)requestUrl{//每个接口必须传的4个参数
    NSString * allString = @"";
//    NSString * userNameString = @"";
//    if ([[[Info getInstance] userName] length] > 0) {//判断用户名是否为nil
//        userNameString = [NSString encodeToPercentEscapeString:[[Info getInstance] userName]];
//    }else{
//        userNameString =[NSString encodeToPercentEscapeString:@""];
//    }
    NSDate * date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];//时间戳
    //    NSString * secretString  = [[NSString stringWithFormat:@"%@_%@", timeSp, userNameString] AES256EncryptWithKey:clientSecretKey];//secret拼串 时间戳+_+用户名 加密
    //    secretString = [NSString encodeToPercentEscapeString:secretString];
    //    NSString * accesstokenString =[[Info getInstance] accesstoken];
    //    NSLog(@"qqqqqqqqqqqqqqqqqqqqqqqqqqqqq = %@", accesstokenString);
    //    if (!accesstokenString) {
    //
    //
    //        accesstokenString = [self accesstokenFunc];
    //
    //    }else{
    //
    //        if ([accesstokenString length] == 0) {
    //            accesstokenString = [self accesstokenFunc];
    //        }
    //
    //    }
    //    accesstokenString = [NSString encodeToPercentEscapeString:accesstokenString];
    allString = [NSString stringWithFormat:@"&version=%@&source=%@&accesstoken=&secret=", [[Info getInstance] cbVersion],kSouse];//四个必须带的参数
    
    //    NSLog(@"ddddddddddddddddddddddddddddd========== %@", allString);
    [requestUrl appendString:allString];//把原来的url字符串和四个必带的参数加在一起
    
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", requestUrl);
    allString = [requestUrl stringByReplacingOccurrencesOfString:HOST_URL withString:@""];//截取主机地址
    //    allString = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    allString = [NSString encodeToPercentEscapeString:allString];
    //    NSString * a = @"杨光495";
    //      a = [NSString encodeToPercentEscapeString:a];
    //    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", a);
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    allString = [NSString stringWithFormat:@"%@_%@", timeSp, allString];
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    
    allString = [allString AES256EncryptWithKey:AllparaSecretKey];//aes256加密
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    //     allString = [allString encodeURL:allString];
    allString = [NSString encodeToPercentEscapeString:allString];
    //    allString = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    [requestUrl setString:HOST_URL];//重新拼串
    [requestUrl appendString:@"accessSecretData="];//userNameString的value就是加密后的值
    [requestUrl appendFormat:@"%@", allString];
    
    NSLog(@"requestUrl = %@", requestUrl);
    
    return requestUrl;
}


+ (NSMutableString *)returnPublicUse:(NSMutableString *)requestUrl{//每个接口必须传的4个参数
    NSString * allString = @"";
    NSString * userNameString = @"";
    if ([[[Info getInstance] userName] length] > 0) {//判断用户名是否为nil
        userNameString = [NSString encodeToPercentEscapeString:[[Info getInstance] userName]];
    }else{
        userNameString =[NSString encodeToPercentEscapeString:@""];
    }
    NSDate * date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];//时间戳
    NSString * secretString  = [[NSString stringWithFormat:@"%@_%@", timeSp, userNameString] AES256EncryptWithKey:clientSecretKey];//secret拼串 时间戳+_+用户名 加密
    secretString = [NSString encodeToPercentEscapeString:secretString];
    NSString * accesstokenString =[[Info getInstance] accesstoken];
    if (!accesstokenString) {
        
       
       accesstokenString = [self accesstokenFunc];
        
    }else{
    
        if ([accesstokenString length] == 0) {
           accesstokenString = [self accesstokenFunc];
        }
        
    }
    accesstokenString = [NSString encodeToPercentEscapeString:accesstokenString];
    allString = [NSString stringWithFormat:@"&version=%@&source=%@&accesstoken=%@&secret=%@", [[Info getInstance] cbVersion],kSouse,accesstokenString,secretString];//四个必须带的参数
    
    NSLog(@"ddddddddddddddddddddddddddddd========== %@", allString);
    [requestUrl appendString:allString];//把原来的url字符串和四个必带的参数加在一起
    
     NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", requestUrl);
    allString = [requestUrl stringByReplacingOccurrencesOfString:HOST_URL withString:@""];//截取主机地址
//    allString = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      allString = [NSString encodeToPercentEscapeString:allString];
//    NSString * a = @"杨光495";
//      a = [NSString encodeToPercentEscapeString:a];
//    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", a);
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    allString = [NSString stringWithFormat:@"%@_%@", timeSp, allString];
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);

    allString = [allString AES256EncryptWithKey:AllparaSecretKey];//aes256加密
    NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
//     allString = [allString encodeURL:allString];
    allString = [NSString encodeToPercentEscapeString:allString];
//    allString = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"aaaaaaaabbbbbbbbbbbbcccccccc========== %@", allString);
    [requestUrl setString:HOST_URL];//重新拼串
    [requestUrl appendString:@"accessSecretData="];//userNameString的value就是加密后的值
    [requestUrl appendFormat:@"%@", allString];
    
    NSLog(@"requestUrl = %@", requestUrl);
    
    return requestUrl;
}


+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid istoppic:(NSString *)istop{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	
	[requestUrl appendFormat:@"function=%@",klistytTopicac];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    [requestUrl appendFormat:@"&istoppic=%@", istop];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&mode=1"];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.1 广场首页
+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	
	[requestUrl appendFormat:@"function=%@",klistYtTopic];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&mode=1"];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid topickID:(NSString *)topickID
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	
	[requestUrl appendFormat:@"function=%@",klistYtTopicNew];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&mode=1"];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    if (topickID) {
        [requestUrl appendFormat:@"&max_topic_id=%@",topickID];
    }
    
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	
	NSLog(@"NetURL CBlistYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//3.1 客户端初始化机器码统计接口
+ (NSURL*)initMacCode:(NSString*)macCode Sid:(NSString*)sid Time:(NSString *)time
{
	NSString *code = [NSString stringWithFormat:@"%@%@%@%@%@",macCode,sid,time,kSouse,@"jfjlkel9wkdmchy28kdgz"];
	const char *cStr = [code UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	code =[NSString stringWithFormat:
		   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
		   result[0], result[1], result[2], result[3],
		   result[4], result[5], result[6], result[7],
		   result[8], result[9], result[10], result[11],
		   result[12], result[13], result[14], result[15]
		   ];
	code = [code lowercaseString];
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", @"initMacCode"];
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&sid=%@", sid];
    time = [NSString encodeToPercentEscapeString:time];
	[requestUrl appendFormat:@"&time=%@", time];
    [requestUrl appendFormat:@"&keySource=%@", kSouse];
    [requestUrl appendFormat:@"&code=%@", code];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    //    [requestUrl appendFormat:@"&version=%@",[[Info getInstance] cbVersion]];
    [requestUrl appendFormat:@"&idfa=%@",[UDIDFromMac IDFA]];
//	NSLog(@"idfa = %@", [UDIDFromMac IDFA]);
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	[requestUrl release];
    
    NSLog(@"机器码 %@", url);
	return url;
	
}
// 2.24 注册
+ (NSURL*)CBregister:(NSString*)nickname passWord:(NSString*)password
{
    NSString *sid = [[Info getInstance] cbSID];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kregister];
    NSString * userNameString = @"";
    
    if (nickname) {//判断用户名是否为nil
        userNameString = [NSString encodeToPercentEscapeString:nickname];
    }else{
        userNameString = [NSString encodeToPercentEscapeString:@""];
    }
    NSDate * date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];//时间戳
    NSString * secretString  = [NSString stringWithFormat:@"%@_%@", timeSp, userNameString];//secret拼串 时间戳+_+用户名
    secretString = [secretString AES256EncryptWithKey:clientParaKey];
    secretString = [NSString  encodeToPercentEscapeString:secretString];
    
    NSString * passwordString = [NSString encodeToPercentEscapeString:password];
    passwordString = [NSString   stringWithFormat:@"%@_%@", timeSp, passwordString];
    passwordString = [passwordString AES256EncryptWithKey:clientParaKey];
    passwordString = [NSString encodeToPercentEscapeString:passwordString];
    
	[requestUrl appendFormat:@"&password=%@", passwordString];
	[requestUrl appendFormat:@"&sid=%@", sid];
	[requestUrl appendFormat:@"&nickName=%@", secretString];
    [requestUrl appendFormat:@"&mobleId=%@", macCode];
	if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    //    [requestUrl appendFormat:@"&version=%@",[[Info getInstance] cbVersion]];
    [requestUrl appendFormat:@"&idfa=%@",[UDIDFromMac IDFA]];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	[requestUrl release];
    
    NSLog(@"2.24 注册 %@", url);
	return url;
    
}



// 2.25 登录
+ (NSURL*)CBlogin:(NSString*)username passWord:(NSString*)password
{
	
    if([password rangeOfString:@" "].location != NSNotFound){
    
        password = [password stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    NSString *version = [[Info getInstance] cbVersion];//;
    NSString *sid = [[Info getInstance] cbSID];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", klogin];
    [requestUrl appendFormat:@"&sid=%@", sid];
    
    NSString * userNameString = @"";
    if (username) {//判断用户名是否为nil
        userNameString = [NSString encodeToPercentEscapeString:username];
    }else{
        userNameString = [NSString encodeToPercentEscapeString:@""];
    }
    NSDate * date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];//时间戳
    NSString * secretString  = [NSString stringWithFormat:@"%@_%@", timeSp, userNameString];//secret拼串 时间戳+_+用户名
    secretString = [secretString AES256EncryptWithKey:clientParaKey];
    secretString = [NSString  encodeToPercentEscapeString:secretString];
    
    NSString * passwordString = [NSString encodeToPercentEscapeString:password];
    passwordString = [NSString   stringWithFormat:@"%@_%@", timeSp, passwordString];
    passwordString = [passwordString AES256EncryptWithKey:clientParaKey];
    passwordString = [NSString encodeToPercentEscapeString:passwordString];
    
	[requestUrl appendFormat:@"&userName=%@", secretString];
	[requestUrl appendFormat:@"&password=%@", passwordString];
    [requestUrl appendFormat:@"&system=iOS"];
    [requestUrl appendFormat:@"&sysVersion=5.0"];
    
    [requestUrl appendFormat:@"&vision=%@", version];
    [requestUrl appendFormat:@"&resolution=640*960"];
    [requestUrl appendFormat:@"&clientId=%@", macCode];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
    [requestUrl appendFormat:@"&macCode=%@", macCode];
    
    
	
   	NSURL *url = [NSURL URLWithString:[self loginReturnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.25 登录 %@",url);
	return url;
}

//// 2.25 登录
//+ (NSURL*)CBlogin:(NSString*)username passWord:(NSString*)password
//{
//	// NSString *source =  @"1";
//	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
//    NSString *version = [[Info getInstance] cbVersion];//;
//    NSString *sid = [[Info getInstance] cbSID];
//    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//	
//	NSMutableString *requestUrl = [[NSMutableString alloc] init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@", klogin];
//    [requestUrl appendFormat:@"&sid=%@", sid];
//	[requestUrl appendFormat:@"&userName=%@", username];
//	[requestUrl appendFormat:@"&password=%@", password];
//    [requestUrl appendFormat:@"&system=iOS"];
//    [requestUrl appendFormat:@"&sysVersion=5.0"];
//    //    [requestUrl appendFormat:@"&version=%@", version];
//    [requestUrl appendFormat:@"&vision=%@", version];
//    [requestUrl appendFormat:@"&resolution=640*960"];
//    [requestUrl appendFormat:@"&clientId=%@", macCode];
//    if ([deviceToken length]>10) {
//		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
//	}
//    [requestUrl appendFormat:@"&macCode=%@", macCode];
//    
//    [requestUrl appendFormat:@"&source=%@", kSouse];
//	
//   	NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//	[requestUrl release];
//    
//    NSLog(@"2.25 登录 %@",url);
//	return url;
//}


+ (NSURL*)CBgetSessionIdbyUL:unionId UserName:(NSString *)userName Partnerid:(NSString *)partnerid {
	NSString *vilidata = [NSString stringWithFormat:@"%@%@ly-365",userName,unionId];
	const char *cStr = [vilidata UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	vilidata =[NSString stringWithFormat:
               @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
               result[0], result[1], result[2], result[3],
               result[4], result[5], result[6], result[7],
               result[8], result[9], result[10], result[11],
               result[12], result[13], result[14], result[15]
               ];
	vilidata = [vilidata lowercaseString];
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kgetSessionIdbyUL];
	[requestUrl appendFormat:@"&userName=%@", userName];
	[requestUrl appendFormat:@"&vilidata=%@", vilidata];
	[requestUrl appendFormat:@"&unionId=%@", unionId];
	if (partnerid && ![partnerid isEqualToString:@"null"]) {
		[requestUrl appendFormat:@"&partnerid=%@", partnerid];
	}
	else {
		[requestUrl appendFormat:@"&partnerid=%@", @"300"];
	}
    
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	[requestUrl release];
	return url;
}


// 2.22 找回密码第一步：获取验证码
+ (NSURL*)CBforgetPassFristStep:(NSString *)phone
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kForgetPassStep1];
	[requestUrl appendFormat:@"&phone=%@", phone];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	
    NSLog(@"2.22 找回密码第一步：获取验证码:%@",url);
	return url;
}


// 2.23 找回密码第二步：重置密码
+ (NSURL*)CBResetPassword:(NSString*)phone PassCode:(NSString*)passcode PassWord:(NSString*)password RePassWord:(NSString*)repassword
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kResetPassword];
	[requestUrl appendFormat:@"&phone=%@", phone];
    NSLog(@"验证码 = %@", passcode);
	[requestUrl appendFormat:@"&passCode=%@", passcode];
    password = [NSString encodeToPercentEscapeString:password];
	[requestUrl appendFormat:@"&password=%@", password];
    repassword = [NSString encodeToPercentEscapeString:repassword];
	[requestUrl appendFormat:@"&repassword=%@", repassword];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
    [requestUrl release];
	
	NSLog(@"2.23 找回密码第二步：重置密码%@",url);
	return url;
}

// 2.3 发帖/转帖
+ (NSURL*)CBSaveYtTopic:(NSString *)fwTopicId
				content:(NSString *)content
			 attachType:(NSString *)attachType
				 attach:(NSString *)attach
				  type : (NSString*) type
				 userId:(NSString *)userId
				 source:(NSString *)source
			  orignalId:(NSString *)orignalId
			 is_comment:(NSString *)is_comment
				  share:(NSString *)share
           shareorderId:(NSString *)shareorderId
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", ksaveYtTopic];
	[requestUrl appendFormat:@"&fwTopicId=%@",fwTopicId];
    content = [NSString encodeToPercentEscapeString:content];
	[requestUrl appendFormat:@"&content=%@",content];
	[requestUrl appendFormat:@"&attachType=%@",attachType];
    attach = [NSString encodeToPercentEscapeString:attach];
    [requestUrl appendFormat:@"&attach=%@",attach];
    [requestUrl appendFormat:@"&type=%@",type];
    [requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&orignalId=%@",orignalId];
    [requestUrl appendFormat:@"&is_comment=%@",is_comment];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    if (!shareorderId) {
        shareorderId = @"";
    }
    [requestUrl appendFormat:@"&shareorderId=%@", shareorderId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	if (share) {
		[requestUrl appendFormat:@"&%@", share];
	}
     NSLog(@"2.3发帖/转帖:%@",requestUrl);
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
   
	[requestUrl release];
    
	return url;
}

//+orderId（2012/8/30添加）	长方案号	（邀请合买才用）
//lottery_id（2012/8/30添加）	彩种ID	新彩种（邀请合买才用）
//play（2012/8/30添加）	玩法	（邀请合买才用）

+ (NSURL*)CBSaveYtTopic:(NSString *)fwTopicId
				content:(NSString *)content
			 attachType:(NSString *)attachType
				 attach:(NSString *)attach
				  type : (NSString*) type
				 userId:(NSString *)userId
				 source:(NSString *)source
			  orignalId:(NSString *)orignalId
			 is_comment:(NSString *)is_comment
				  share:(NSString *)share
                orderId:(NSString *)orderId
             lottery_id:(NSString *)lottery_id
                   play:(NSString *)play
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", ksaveYtTopic];
	[requestUrl appendFormat:@"&fwTopicId=%@",fwTopicId];
    content = [NSString encodeToPercentEscapeString:content];
	[requestUrl appendFormat:@"&content=%@",content];
	[requestUrl appendFormat:@"&attachType=%@",attachType];
    attach = [NSString encodeToPercentEscapeString:attach];
    [requestUrl appendFormat:@"&attach=%@",attach];
    [requestUrl appendFormat:@"&type=%@",type];
    [requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&orignalId=%@",orignalId];
    [requestUrl appendFormat:@"&is_comment=%@",is_comment];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&orderId=%@", orderId];
    [requestUrl appendFormat:@"&lottery_id=%@", lottery_id];
    [requestUrl appendFormat:@"&play=%@", play];
	if (share) {
		[requestUrl appendFormat:@"&%@", share];
	}
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    NSLog(@"2.3发帖/转帖:%@",url);
	[requestUrl release];
    
	return url;
}


// 2.4 评论
+ (NSURL*)CBsaveYtComment:(NSString *)topicId
				  content:(NSString *)content
				   userId:(NSString *)userId
		   is_trans_topic:(NSString *)is_trans_topic
				   source:(NSString *)source
					share:(NSString *)share
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksaveYtComment];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
    content = [NSString encodeToPercentEscapeString:content];
	[requestUrl appendFormat:@"&content=%@",content];
	[requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&is_trans_topic=%@",is_trans_topic];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	if (share) {
		[requestUrl appendFormat:@"&%@", share];
	}
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//    NSURL * url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSLog(@"NetURL CBsaveYtComment  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//2.5关注人 发帖列表 （首页 列表）
+ (NSURL*)CBlistAttentionYtTopic:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistAttentionYtTopic];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistAttentionYtTopic  url =%@",url);
	[requestUrl release];
    
	return url;
}



// 2.69 推送消息
+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kpushMessageList];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBpushMessageList  url =%@",url);
	[requestUrl release];
    
	return url;
}
+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize maxTopicId:(NSString *)maxTopicId userId:(NSString*)userid{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kpushMessageList];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    [requestUrl appendFormat:@"&maxTopicId=%@",maxTopicId];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBpushMessageList  url =%@",url);
	[requestUrl release];
    
	return url;
}

+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid mode:(NSString*)mode{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kpushMessageList];
	[requestUrl appendFormat:@"&userId=%@",userid];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&mode=%@",mode];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBpushMessageList  url =%@",url);
	[requestUrl release];
    
	return url;
}



//2.6 获取用户信息（userId）
+ (NSURL*)CBgetUserInfoWithUserId:(NSString*)userId
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetUserInfo];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&loginId=%@", [[Info getInstance] userId]];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"NetURL CBgetUserInfoWithUserId url =%@",url);
	return url;
}

//2.6 获取用户信息（userId）世界杯
//+ (NSURL*)CBWCgetUserInfoWithUserId:(NSString*)userId
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",kgetUserInfo];
//	[requestUrl appendFormat:@"&userId=%@",userId];
//    [requestUrl appendFormat:@"&worldCupFlag=ios"];
//	[requestUrl appendFormat:@"&loginId=%@", [[Info getInstance] userId]];
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}

//2.6 获取用户信息（nickName）
+ (NSURL*)CBgetUserInfoWithNickName:(NSString*)nickName
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetUserInfo];
    nickName = [NSString encodeToPercentEscapeString:nickName];
	[requestUrl appendFormat:@"&nickName=%@",nickName];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"NetURL CBgetUserInfoWithNickName url =%@",url);
	return url;
}

//2.6 获取用户信息（nickName）世界杯
//+ (NSURL*)CBWCgetUserInfoWithNickName:(NSString*)nickName
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",kgetUserInfo];
//    nickName = [NSString encodeToPercentEscapeString:nickName];
//	[requestUrl appendFormat:@"&nickName=%@",nickName];
//    [requestUrl appendFormat:@"&worldCupFlag=ios"];
//    NSString *userId = [[Info getInstance] userId];
//	if ([userId length]) {
//		[requestUrl appendFormat:@"&loginId=%@", userId];
//	}
//    //    [requestUrl appendFormat:@"&source=%@", kSouse];
//    
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//    NSLog(@"NetURL CBgetUserInfoWithNickName url =%@",url);
//	return url;
//}


// 2.7 用户发帖列表
+(NSURL*)CBlistYtTopicByUserId:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistYtTopicByUserId];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&loginId=%@", [[Info getInstance] userId]];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistYtTopicByUserId  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.8  获取评论
+(NSURL*)CBgetCommentList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pageSize{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetCommentList];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pageSize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetCommentList  url =%@",url);
	
	[requestUrl release];
	
	return url;
	
}

// 2.8  获取评论
+(NSURL*)CBgetYtTopicCommentList:(NSString *)userId topicId:(NSString *)topicId pageNum:(NSString *)pagenum pageSize:(NSString *)pageSize {
    
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetYtTopicCommentList];
    if ([userId length] !=0) {
        [requestUrl appendFormat:@"&userId=%@",userId];
        [requestUrl appendFormat:@"&loginId=%@", userId];
    }
    else {
        [requestUrl appendFormat:@"&userId=%@",@"0"];
        [requestUrl appendFormat:@"&loginId=%@", @"0"];
    }
    [requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pageSize];
	
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetYtTopicCommentList  url =%@",url);
	[requestUrl release];
    
	return url;
}


// 2.10添加关注
+(NSURL*)CBsaveAttention:(NSString*)userId attUserId:(NSString*)attUserId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksaveAttention];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&attUserId=%@",attUserId];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBsaveAttention  url =%@",url);
	
	[requestUrl release];
	
	return url;
	
	
}

// 2.13 取消关注
+(NSURL*)CBcancelAttention:(NSString*)userId attUserId:(NSString*)attUserId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kcancelAttention];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&attUserId=%@",attUserId];
	
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBcancelAttention  url =%@",url);
	
	[requestUrl release];
	
	return url;
	
}

//2.17 获取用户ID
+(NSURL*)CBgetUserId:(NSString *)username Password:(NSString*)password
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetUserIdByName];
	[requestUrl appendFormat:@"&userName=%@",(username)];
	[requestUrl appendFormat:@"&password=%@",(password)];
    
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBcancelAttention  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//md5加密
+(NSString *)EncryptWithMD5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];//32位
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSString *encryptStr = [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    NSLog(@"encryptStr = %@", encryptStr);
    encryptStr = [encryptStr lowercaseString];
    return encryptStr;
}

//2.18 我的粉丝列表
+(NSURL*)CBgetMyFansList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize myUserId:(NSString*)myUserId{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetMyFansList];
	[requestUrl appendFormat:@"&userId=%@",userId];
    if ([myUserId length]==0) {
        myUserId = [[Info getInstance] userId];
    }
	[requestUrl appendFormat:@"&myUserId=%@",myUserId];
    
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetMyFansList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//2.19 关注列表
//2.19 关注列表
+(NSURL*)CBgetMyAttenList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize myUserId:(NSString*)myUserId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetMyAttenList];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&myUserId=%@",myUserId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
	[requestUrl appendFormat:@"&loginId=%@", myUserId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetMyAttenList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//2.20 获取和指定用户的关系
+(NSURL*)CBgetRelationByUserId:(NSString*)userId himId:(NSString*)himId
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:(HOST_URL)];
    [requestUrl appendFormat:@"function=%@",kgetRelationByUserId];
    [requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&himId=%@",himId];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    NSLog(@"NetURL CBgetRelationByUserId URL = %@", url);
    
    return url;
}

// 2.26 收藏
+(NSURL*)CBsaveFavorite:(NSString*)topicId userId:(NSString*)userId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksaveFavorite];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&userId=%@",userId];
	
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"2.26 收藏 %@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.28 用户收藏帖子列表
+(NSURL*)CBlistFavoYtTopicByUserId:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistFavoYtTopicByUserId];
	
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"2.28 用户收藏帖子列表 %@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.30 获取话题
+(NSURL*)CBlistYtTheme: (NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistYtTheme];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"2.30 获取话题 %@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.31 获取话题列表
+(NSURL*)CBgetThemetYtTipic: (NSString*)userID themeName:(NSString*)themeName pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetThemetYtTipic];
    if ([userID length] == 0) {
        userID = @"1111";
    }
	[requestUrl appendFormat:@"&userId=%@",userID];
    themeName = [NSString encodeToPercentEscapeString:themeName];
	[requestUrl appendFormat:@"&themeName=%@",themeName];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"2.31 获取话题列表 %@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.34 获取热门转发
+(NSURL*)CBlistHotYtTopic
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistHotYtTopic];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistHotYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

+(NSURL*)CBlistHotYtTopic:(NSString*)userID pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistHotYtTopic];
	[requestUrl appendFormat:@"&userId=%@",userID];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistHotYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.35 获取热门评论
+(NSURL*)CBlistHotYtComment
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistHotYtComent];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistHotYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


+(NSURL*)CBlistHotYtComment:(NSString*)userID pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",klistHotYtComent];
	[requestUrl appendFormat:@"&userId=%@",userID];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistHotYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.36 我的黑名单列表
+ (NSURL*)CBgetBlackUserList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kgetBlackUserList];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&pageNum=%@", pagenum];
	[requestUrl appendFormat:@"&pageSize=%@", pagesize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	
    NSLog(@"2.36 我的黑名单列表 %@", url);
    
	return url;
}

// 2.37 添加黑名单
+(NSURL*)CBsaveBlackUser:(NSString*)userId taUserId:(NSString*)taUserId
{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksaveBlackUser];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&taUserId=%@",taUserId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"NetURL CBsaveBlackUser Url = %@", url);
    
	return url;
}

// 2.38 解除黑名单
+(NSURL*)CBdeleteBlackUser:(NSString*)userId taUserId:(NSString*)taUserId
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kdeleteBlackUser];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&taUserId=%@", taUserId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"NetURL CBdeleteBlackUser Url = %@", url);
    
	return url;
}
// 2.39 发私信
+(NSURL*)CBsendMail:(NSString*)userId taUserId:(NSString*)taUserId content:(NSString*)content imageUrl:(NSString *)imageurl
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksendMail];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&taUserId=%@",taUserId];
    content = [NSString encodeToPercentEscapeString:content];
	[requestUrl appendFormat:@"&content=%@",content];
    imageurl = [NSString encodeToPercentEscapeString:imageurl];
    [requestUrl appendFormat:@"&pic_url=%@",imageurl];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBsendMail  url = %@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.67获取私信列表
+(NSURL*)CBgetMailList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",knewMailList];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetMailList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.42 获取@博主帖子列表
+(NSURL*)CBgetAtmeTopicList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetAtmeTopicList];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetAtmeTopicList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.43 搜索帖子列表
+(NSURL*)CBsearchTopicList:(NSString*)keywords pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{   NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksearchTopicList];
	[requestUrl appendFormat:@"&keywords=%@",keywords];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	
	NSLog(@"NetURL CBsearchTopicList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.44 搜索人列表
+(NSURL*)CBsearchUserList:(NSString*)keywords pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksearchUserList];
	[requestUrl appendFormat:@"&keywords=%@",keywords];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBsearchUserList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


// 2.45 官方微博发帖列表
+(NSURL*)CBgetOrganizationYtTopicList:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetOrganizationYtTopicList];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetOrganizationYtTopicList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}


//2.46 分享帖子
+(NSURL*)CBshareYtTopic:(NSString*)userId topicId:(NSString*)topicId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kshareYtTopic];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBshareYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.47 @博主
+(NSURL*)CBatmeUser:(NSString*)userId topicId:(NSString*)topicId content:(NSString*)content
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",katmeUser];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&content=%@",content];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBatmeUser  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.48 检查更新
+(NSURL*)CBcheckUpdate:(NSString*)version identity:(NSString*)identity{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",katmeUser];
    //	[requestUrl appendFormat:@"&version=%@",version];
	[requestUrl appendFormat:@"&identity=%@",identity];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBcheckUpdate  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

//2.49 新评论、新私信 新粉丝提醒
+(NSURL*)CBnewUpdateTime:(NSString*)userId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",knewUpdateTime];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBnewUpdateTime  url =%@",url);
	
	[requestUrl release];
	
	return url;
}
// 2.77 新问题反馈
+(NSURL*)CBqA:(NSString*)userId Content:(NSString*)content AttachType:(unsigned short)attachType Attach:(NSString*)attach
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kqA];
    [requestUrl appendFormat:@"&type=%d", 1];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&content=%@", content];
    [requestUrl appendFormat:@"&attachType=%d", attachType];// 0文字，1图片附件
    [requestUrl appendFormat:@"&attach=%@", attach];// 附件地址
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.77 新问题反馈 %@",url);
    
	return url;
}
// 2.52 获取我和某人的黑名单关系
+ (NSURL*)CBgetBlackRelation:(NSString*)userId himId:(NSString*)himId
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:(HOST_URL)];
    [requestUrl appendFormat:@"function=%@", kgetBlackRelation];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&attUserId=%@", himId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.52 获取我和某人的黑名单关系 %@", url);
    
    return url;
}
// 2.54 查看分组
+(NSURL*)CBgetUserGroupList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize
{
	
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetUserGroupList];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBgetUserGroupList  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

// 2.56 编辑个人资料
+ (NSURL*)CbEditPerInfo:(NSInteger)userId Province:(NSInteger)province City:(NSInteger)city Sex:(NSInteger)sex Signatures:(NSString*)signatures ImageUrl:(NSString*)imageUrl
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kEditPerInfo];
    [requestUrl appendFormat:@"&userId=%d", (int)userId];
    [requestUrl appendFormat:@"&province=%d", (int)province];
    [requestUrl appendFormat:@"&city=%d", (int)city];
    [requestUrl appendFormat:@"&sex=%d", (int)sex];
    [requestUrl appendFormat:@"&signatures=%@", signatures];
    [requestUrl appendFormat:@"&sma_image=%@", imageUrl];
	[requestUrl appendFormat:@"&loginId=%d", (int)userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.56 编辑个人资料 %@",url);
    
    return url;
}


// 2.57 未读的推送消息数（广场）
+ (NSURL*)CbGetUnreadPushNum:(NSString*)userId
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:checkNew_URL];
    [requestUrl appendFormat:@"function=%@", kGetUnreadPushNum];
    [requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    if([[[Info getInstance] userName] length]){
    
        [requestUrl appendFormat:@"&username=%@",[[Info getInstance] userName]];
    }
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&type=1"];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.57 未读的推送消息数（广场）%@",url);
    
    return url;
}
// 2.59 新密码找回
+ (NSURL*)CBgetPassword:(NSInteger)type NickName:(NSString*)nickName
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kGetPassword];
    [requestUrl appendFormat:@"&type=%d", (int)type];
    nickName = [NSString encodeToPercentEscapeString:nickName];
	[requestUrl appendFormat:@"&nickName=%@",nickName];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.59 新密码找回 %@", url);
    
	return url;
}

// 2.60 新查询用户绑定状态接口
+(NSURL*)CBgetBindState:(NSString*)nickName
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kGetBindState];
	[requestUrl appendFormat:@"&nickName=%@",nickName];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"新查询用户绑定状态接口  %@", url);
    
	return url;
}

// 2.61 邮箱绑定
+ (NSURL*)CbbindMail:(NSString*)mailNum NickName:(NSString*)nickName
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kbindMail];
    mailNum = [NSString encodeToPercentEscapeString:mailNum];
    [requestUrl appendFormat:@"&mail=%@", mailNum];
    nickName = [NSString encodeToPercentEscapeString:nickName];
    [requestUrl appendFormat:@"&nickName=%@", nickName];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.61 邮箱绑定 %@",url);
    
    return url;
}

// 2.62 获取手机验证码
+ (NSURL*)CbgetPassCode:(NSString*)phoneNum NickName:(NSString*)nickName
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetPassCode];
    [requestUrl appendFormat:@"&phone=%@", phoneNum];
    nickName = [NSString encodeToPercentEscapeString:nickName];
    [requestUrl appendFormat:@"&nickName=%@", nickName];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.62 获取手机验证码 %@",url);
    
    return url;
}

// 2.63 发送验证码
+ (NSURL*)CbbindPhone:(NSString*)nickName PassCode:(NSString*)passCode verify:(NSString *)verify
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kbindPhone];
    [requestUrl appendFormat:@"&nickName=%@", nickName];
    [requestUrl appendFormat:@"&passCode=%@", passCode];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    [requestUrl appendFormat:@"&verifyCode=%@", verify];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    NSLog(@"2.63 发送验证码 %@", url);
    
    return url;
}

// 2.65 获取关注话题
+(NSURL*)CBlistYtThemeGz:(NSString *)userId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", klistYtThemeGz];
    [requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"2.65 获取关注话题 %@", url);
    
    return url;
}

// 2.64 获取帖子详情
+(NSURL*)CBgetTopicListById:(NSString*)topicId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetTopicListById];
    [requestUrl appendFormat:@"&topicId=%@", topicId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSLog(@"NetURL CBgetTopicListById Url =%@", requestUrl);
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    
    
    return url;
}


// 2.51 评论回复
+(NSURL*)CBsendComment:(NSString*)userId content:(NSString*)content topicId:(NSString*)topicId source:(NSString*)source totop:(NSString*)totop{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksendComment];
    userId = [NSString encodeToPercentEscapeString:userId];
	[requestUrl appendFormat:@"&userId=%@",userId];
    content = [NSString encodeToPercentEscapeString:content];
	[requestUrl appendFormat:@"&content=%@",content];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
    //	[requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&totop=%@",totop];
	[requestUrl appendFormat:@"&loginId=%@", userId];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"2.51 评论回复 %@", url);
    
    return url;
}

// 2.29  专家
+(NSURL*)CBlistYtTopicByZhuanjia:(NSString *)pagenum pageSize:(NSString *)pagesize userId:(NSString*)userid;{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", klistYtTopicByZhuanjia];
	
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&userId=%@",userid];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBlistYtTopicByZhuanjia Url =%@", url);
    
    return url;
}

// 2.58 其他信息
+(NSURL*)CBlistYtTopicByOther:(NSString *)pagenum pageSize:(NSString *)pagesize para:(NSString*)para userId:(NSString*)userid; {
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", klistYtTopicByOther];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&para=%@",para];
	[requestUrl appendFormat:@"&userId=%@",userid];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBlistYtTopicByOther Url =%@", url);
    
    return url;
}


// 2.66 分组帖子列表
+(NSURL*)CBgetTopicListByGroupId:(NSString *)userId groupId:(NSString*)groupid pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetTopicListByGroupId];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&groupId=%@",groupid];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBgetTopicListByGroupId Url =%@", url);
    
    return url;
	
	
	
}

// 2.70 删除自己评论
+ (NSURL *) CBdeleteCommentById:(NSString *)userId commentId:(NSString *)commentId {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdeleteCommentById];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&commentId=%@",commentId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBdeleteCommentById Url =%@", url);
    
    return url;
}
+(NSURL*)CBusersMailList:(NSString*)userId
				 userId2:(NSString*)userid2
				 pageNum:(NSString*)pagenum
				pageSize:(NSString*)pagesize
				mailType:(NSString*)mailtype
					mode:(NSString*)mode
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kusersMailList];
	[requestUrl appendFormat:@"&userId1=%@",userId];
	[requestUrl appendFormat:@"&userId2=%@",userid2];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&mailType=%@",mailtype];
	[requestUrl appendFormat:@"&mode=%@",mode];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBusersMailList Url =%@", url);
    
    return url;
	
}

+(NSURL*)KFCBusersMailList:(NSString*)userId
                   userId2:(NSString*)userid2
                   pageNum:(NSString*)pagenum
                  pageSize:(NSString*)pagesize
                  mailType:(NSString*)mailtype
                      mode:(NSString*)mode{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kefuMailList];
	[requestUrl appendFormat:@"&userId1=%@",userId];
	[requestUrl appendFormat:@"&userId2=%@",userid2];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&mailType=%@",mailtype];
	[requestUrl appendFormat:@"&mode=%@",mode];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBusersMailList Url =%@", url);
    
    return url;
    
}

+(NSURL*)CBusersMailList:(NSString*)userId userId2:(NSString*)userid2 pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize{
	
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kusersMailList];
	[requestUrl appendFormat:@"&userId1=%@",userId];
	[requestUrl appendFormat:@"&userId2=%@",userid2];
	[requestUrl appendFormat:@"&pageNum=%@",pagenum];
	[requestUrl appendFormat:@"&pageSize=%@",pagesize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBusersMailList Url =%@", url);
    
    return url;
}

// 2.71 取消收藏
+ (NSURL *) CBdeleteUserTopicById:(NSString *)userId topicId:(NSString *)topicId {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdeleteUserTopicById];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"2.71 取消收藏 %@", url);
    
    return url;
}

// 2.72 删除一对一私信
+(NSURL*)CBdelUsersMailList:(NSString*)userId1 userId2:(NSString*)userId2{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdelUsersMailList];
	[requestUrl appendFormat:@"&userId1=%@",userId1];
	[requestUrl appendFormat:@"&userId2=%@",userId2];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBdelUsersMailList Url =%@", url);
    
    return url;
}


// 2.74获取相互关注私信列表人
+(NSURL *) CBgetMaillist1:(NSString *)userId pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetMailList1];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&=pageNum%@",pageNum];
    [requestUrl appendFormat:@"&=pageSize%@",pageSize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBgetMaillist1 Url =%@", url);
    
    return url;
}

// 2.75 删除自己微博
+ (NSURL *) CBdelTopic:(NSString *)userId topicId:(NSString *)topicId {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdelTopic];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&topicId=%@",topicId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
	[requestUrl release];
    
    NSLog(@"NetURL CBdelTopic Url =%@", url);
    
    return url;
}


// 2.78 新举报
+(NSURL*)CBreport:(NSString*)userId content:(NSString*)content topicId:(NSString*)topicid
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kreport];
    [requestUrl appendFormat:@"&type=%d", 1]; // 平台
	[requestUrl appendFormat:@"&userId=%@", userId];
    content = [NSString encodeToPercentEscapeString:content];
    [requestUrl appendFormat:@"&content=%@", content];
	[requestUrl appendFormat:@"&topicId=%@", topicid];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.78 新举报%@", url);
    
    return url;
}
+(NSURL*)CBdelUsersMailById:(NSString*)noticeId userId:(NSString*)userId{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdelUsersMailById];
	[requestUrl appendFormat:@"&id=%@",noticeId];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"NetURL CBdelUsersMailById Url =%@", url);
    
    return url;
}


// 2.79 话题收藏
+(NSURL*)CBcollectTheme:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId
{
    NSLog(@"themeId = %@", themeId);
    NSLog(@"theme = %@", theme);
    if (themeId)
    {
        theme = @"";
    }
    else
    {
        themeId = @"";
    }
    
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kcollectTheme];
	[requestUrl appendFormat:@"&themeId=%@", themeId];
    theme = [NSString encodeToPercentEscapeString:theme];
    [requestUrl appendFormat:@"&theme=%@", theme];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.79 热门话题收藏 %@", url);
	
	return url;
}

// 2.80 取消话题收藏
+(NSURL*)CBdelCollectionTheme:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId
{
    NSLog(@"themeId = %@", themeId);
    NSLog(@"theme = %@", theme);
    if (themeId)
    {
        theme = @"";
    }
    else
    {
        themeId = @"";
    }
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kdelCollectionTheme];
	[requestUrl appendFormat:@"&themeId=%@", themeId];
    theme = [NSString encodeToPercentEscapeString:theme];
    [requestUrl appendFormat:@"&theme=%@", theme];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.80 取消话题收藏 %@", url);
	
	return url;
}

// 2.81 话题收藏状态接口
+(NSURL*)CBgetThemeStatus:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId
{
    NSLog(@"themeId = %@", themeId);
    NSLog(@"theme = %@", theme);
    if (themeId)
    {
        theme = @"";
    }
    else
    {
        themeId = @"";
    }
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kgetThemeStatus];
	[requestUrl appendFormat:@"&themeId=%@", themeId];
    theme = [NSString encodeToPercentEscapeString:theme];
    [requestUrl appendFormat:@"&theme=%@", theme];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.81 话题收藏状态接口 %@", url);
	
	return url;
}

// 2.82 比分关注和结束比赛
+ (NSURL *)CBgetAttentionMatchList
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetAttentionMatchList];
    NSString *userId = [[Info getInstance] userId];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&lotteryId=%@", @""];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.82 比分关注和结束比赛 %@", url);
    
    return url;
}

// 2.83 获取比赛信息
+ (NSURL *)CBgetMatchInfo:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetMatchInfo];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&matchId=%@", matchId];
    [requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSLog(@"2.83 获取比赛信息 %@", requestUrl);
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
//    NSLog(@"2.83 获取比赛信息 %@", url);
    
    return url;
}



// 2.84 关注比赛
+ (NSURL *)CBattentionMatch:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kattentionMatch];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&matchId=%@", matchId];
    [requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.84 关注比赛 %@", url);
    
    return url;
}

// 2.85 取消关注比赛
+ (NSURL *)CBcancelAttentionMatch:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kcancelAttentionMatch];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&matchId=%@", matchId];
    [requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.85 取消关注比赛 %@", url);
    
    return url;
}


// 2.86 获取比赛的赛事列表
+ (NSURL *)CBgetLeagueList
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetLeagueList];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.86 获取比赛的赛事列表 %@", url);
    
    return url;
}

// 2.87 获取比赛的彩种列表
+ (NSURL *)CBgetLotteryTypeList
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetLotteryTypeList];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.87 获取比赛的彩种列表 %@",url);
    
	return url;
}

// 2.88 根据彩种获取比赛列表
+ (NSURL *)CBgetMatchList:(NSString*)lotteryId Issue:(NSString*)issue UserId:(NSString*)userId PageNum:(NSString*)pageNum PageSize:(NSString*)pageSize
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetMatchListByLotteryType];
    [requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&pageNum=%@", pageNum];
    [requestUrl appendFormat:@"&pageSize=%@", pageSize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl a、ppendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.88 根据彩种获取比赛列表 %@", url);
    
    return url;
}


// 81 篮球比分直播
+ (NSURL *)CBgetLanQiuMatchListWithIssue:(NSString*)issue UserId:(NSString*)userId PageNum:(NSString*)pageNum PageSize:(NSString*)pageSize Type:(NSString *)type{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kLanqiuLiveMatchList];
    [requestUrl appendFormat:@"&page=%@", pageNum];
    [requestUrl appendFormat:@"&perpagenum=%@", pageSize];
	[requestUrl appendFormat:@"&loginId=%@", userId];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&type=%@", type];
    if (issue) {
        [requestUrl appendFormat:@"&issue=%@", issue];
    }
    
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"81 篮球比赛列表 %@", url);
    
    return url;
}

//82 篮球比分直播刷新

+ (NSURL *)CBrefreshLanQiuMatchListWithIssue:(NSString*)issue PlayId:playid{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksynLanqiuLiveMatchList];
    playid = [NSString encodeToPercentEscapeString:playid];
    [requestUrl appendFormat:@"&playids=%@", playid];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"82 篮球比赛刷新 %@", url);
    
    return url;
}

// 83 篮球比分直播详情
+ (NSURL *)CBlanqiuLiveMatchDetailWithIssue:(NSString*)issue PlayId:playid{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kLanqiuLiveMatchDetail];
    [requestUrl appendFormat:@"&playid=%@", playid];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&issue=%@", issue];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"83 篮球比赛详情 %@", url);
    
    return url;
}

// 84 篮球比分直播详情刷新
+ (NSURL *)CBsynlanqiuLiveMatchDetailWithIssue:(NSString*)issue PlayId:playid{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksynLanqiuLiveMatchDetai];
    [requestUrl appendFormat:@"&playid=%@", playid];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&issue=%@", issue];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"84 篮球比赛详情刷新 %@", url);
    
    return url;
}


// 2.89 根据彩种彩期列表
+ (NSURL *)CBgetIssueList:(NSString*)lotteryId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetIssueList];
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.89 根据彩种彩期列表 %@", url);
    
    return url;
}

// 2.90 根据赛事获取比赛列表
+ (NSURL *)CBgetMatchList:(NSString*)leagueId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetMatchListByLotteryType];
	[requestUrl appendFormat:@"&leagueId=%@", leagueId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.90 根据赛事获取比赛列表 %@", url);
    
    return url;
}

// 2.91 添加进球通知
+ (NSURL *)CBaddGoalNotice: (NSString *)userId MatchId: (NSString *)matchId lotteryId: (NSString *)lotteryId issue: (NSString *)issue
{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kaddGoalNotice];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&matchId=%@", matchId];
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
	[requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.91 添加进球通知 %@", url);
    
    return url;
}

// 2.92 取消进球通知
+ (NSURL *)CBcancelGoalNotice:(NSString*)userId MatchId:(NSString*)matchId lotteryId: (NSString *)lotteryId issue: (NSString *)issue
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kcancelGoalNotice];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&matchId=%@", matchId];
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
	[requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.92 取消进球通知 %@", url);
    
    return url;
}



// 2.93 关注列表数据更新接口
+ (NSMutableString *)getCBAutoRefreshMyAttUrl
{
    NSString *userId = [[Info getInstance] userId];
	NSMutableString *requestUrl = [[[NSMutableString alloc] init] autorelease];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kautoRefreshMyAtt];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
//    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
    
//    NSLog(@"2.93 关注列表数据更新接口 %@", url);
    
    return requestUrl;
}

// 2.94 彩种列表数据更新接口
+ (NSMutableString *)CBAutoRefreshLottery:(NSString*)lotteryId Issue:(NSString*)issue
{
    NSString *userId = [[Info getInstance] userId];
	NSMutableString *requestUrl = [[[NSMutableString alloc] init] autorelease];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kautoRefreshLottery];
	[requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
//    NSURL * url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//     NSLog(@"2.94 彩种列表数据更新接口 %@", url);
//    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//     NSLog(@"2.94 彩种列表数据更新接口 %@", url);
//	[requestUrl release];
    
   
    
    return requestUrl;
}

// 2.95 欢迎图片检查更新
+ (NSURL *)CBUpdateWelcomePage
{
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kwelcomePageUpdate];
    //	NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"welcomePicVersion"];
    //	[requestUrl appendFormat:@"&version=%@", version];
	[requestUrl appendFormat:@"&identity=%@", kiosIdetity];
	NSString *sid = [[Info getInstance] cbSID];
	[requestUrl appendFormat:@"&sid=%@", sid];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.95 欢迎图片检查更新 %@", url);
	return url;
}

//2.96 广告位图片检查更新
+ (NSURL *)CBADvertisementPic{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kadvertisementPic];
	
    //	NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"ADVPicVersion"];
	
    //	[requestUrl appendFormat:@"&version=%@", version];
	[requestUrl appendFormat:@"&identity=%@", kiosIdetity];
	NSString *sid = [[Info getInstance] cbSID];
	[requestUrl appendFormat:@"&sid=%@", sid];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.96 广告位图片检查更新 %@", url);
	return url;
	
}

// 2.97 开奖大厅 [[Info getInstance] cbVersion]
+ (NSURL *)CBsynLotteryHall
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksynLotteryHall];
    //    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
    [requestUrl appendFormat:@"&version_code=6"];//应该传1
	[requestUrl appendFormat:@"&userId=%@",[[Info getInstance] userId]];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"2.97 开奖大厅 %@", url);
    
    return url;
}


// 2.98 开奖详情
+ (NSURL *)synLotteryDetails:(NSString *)lotteryId issue:(NSString *)issue status:(NSString *)status userId:(NSString *)userId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksynLotteryDetails];
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
	[requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&status=%@", status];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	[requestUrl release];
    
    NSLog(@"2.98 开奖详情 %@", url);
    
    return url;
}

// 2.99 开奖列表
+ (NSURL *)CBsynLotteryList:(NSString *)lotteryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize userId:(NSString *)userId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksynLotteryList];
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
	[requestUrl appendFormat:@"&pageNo=%@", pageNo];
	[requestUrl appendFormat:@"&pageSize=%@", pageSize];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"2.99 开奖列表 %@", url);
    return url;
}

// 3.3 特殊用户数据列表接口
+ (NSURL *)CBgetSpUsersList:(NSString *)type pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize userId:(NSString *)userId
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetSpUsersList];
	[requestUrl appendFormat:@"&type=%@", type];
	[requestUrl appendFormat:@"&pageNum=%@", pageNo];
	[requestUrl appendFormat:@"&pageSize=%@", pageSize];
	[requestUrl appendFormat:@"&myUserId=%@", userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"2.99 开奖列表 %@", url);
    return url;
}

//3.4 关注多人
+ (NSURL *)CBsaveMoreAttentions:(NSString *)userIDs userId:(NSString *)userId {
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksaveMoreAttentions];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&attUserIds=%@",userIDs];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&loginId=%@", userId];
	
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	return url;
}

//推送信息
+ (NSURL *)CBgetPushStatus:(NSString *)userId
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kgetPushStatus];
    
    
    
    [requestUrl appendFormat:@"&userId=%@", userId];
    
    
    NSURL *url = [NSURL URLWithString: [self returnPublicUse:requestUrl]];
    [requestUrl release];
    NSLog(@"3.4 获取推送设置url: %@", url);
    return  url;
}

//设置推送通知
+ (NSURL *)CBsetPushStatus:(NSString *)userId kj:(NSMutableArray *)kj zj:(NSString *)zj
{
	
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksetPushStatus];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&zj=%@", zj];
	if ([kj count] >= 8) {
		[requestUrl appendFormat:@"&ssqkj=%@", [kj objectAtIndex:0]];
		[requestUrl appendFormat:@"&sdkj=%@", [kj objectAtIndex:1]];
		[requestUrl appendFormat:@"&qlckj=%@", [kj objectAtIndex:2]];
		[requestUrl appendFormat:@"&dltkj=%@", [kj objectAtIndex:3]];
		[requestUrl appendFormat:@"&pskj=%@", [kj objectAtIndex:4]];
		[requestUrl appendFormat:@"&qxckj=%@", [kj objectAtIndex:5]];
		[requestUrl appendFormat:@"&eekj=0"];
		[requestUrl appendFormat:@"&zckj=%@", [kj objectAtIndex:6]];
        [requestUrl appendFormat:@"&lcbqckj=%@", [kj objectAtIndex:7]];
        [requestUrl appendFormat:@"&scjqkj=%@", [kj objectAtIndex:8]];
        
	}
    NSLog(@"3.5 向服务器发送推送设置url: %@", requestUrl);
    NSURL *url = [NSURL URLWithString: [self returnPublicUse:requestUrl]];
    [requestUrl release];
    NSLog(@"3.5 向服务器发送推送设置url: %@", url);
    return  url;
}

//中奖设置推送通知
+ (NSURL *)CBsetPushStatustwo:(NSString *)userId kj:(NSMutableArray *)kj zj:(NSString *)zj
{
	
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ksetPushStatus];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&zj=%@", zj];
	if ([kj count] >= 12) {
		[requestUrl appendFormat:@"&ssqkj=%@", [kj objectAtIndex:10]];
		[requestUrl appendFormat:@"&sdkj=%@", [kj objectAtIndex:8]];
		[requestUrl appendFormat:@"&qlckj=%@", [kj objectAtIndex:3]];
		[requestUrl appendFormat:@"&dltkj=%@", [kj objectAtIndex:7]];
        if ([[kj objectAtIndex:5] isEqualToString:@"1"] || [[kj objectAtIndex:6] isEqualToString:@"1"]) {
            [requestUrl appendFormat:@"&pskj=%@", @"1"];
        }else if([[kj objectAtIndex:5] isEqualToString:@"0"] || [[kj objectAtIndex:6] isEqualToString:@"0"]) {
            [requestUrl appendFormat:@"&pskj=%@", @"0"];
        }
		
		[requestUrl appendFormat:@"&qxckj=%@", [kj objectAtIndex:11]];
		[requestUrl appendFormat:@"&eekj=%@", [kj objectAtIndex:4]];
		[requestUrl appendFormat:@"&zckj=%@", [kj objectAtIndex:0]];
        [requestUrl appendFormat:@"&lcbqckj=%@", [kj objectAtIndex:1]];
        [requestUrl appendFormat:@"&scjqkj=%@", [kj objectAtIndex:2]];
	}
    
    NSURL *url = [NSURL URLWithString: [self returnPublicUse:requestUrl]];
    [requestUrl release];
    NSLog(@"3.5 向服务器发送推送设置url: %@", url);
    return  url;
}


//
+ (NSURL *)CBgetLotteryStation:(NSMutableDictionary *)parameterDictionary
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",kgetLotteryStaion];
    [requestUrl appendFormat:@"&userId=%@",[parameterDictionary objectForKey:@"userId"]];
    [requestUrl appendFormat:@"&longtitude=%@",[parameterDictionary objectForKey:@"longtitude"]];
    [requestUrl appendFormat:@"&latitude=%@",[parameterDictionary objectForKey:@"latitude"]];
    [requestUrl appendFormat:@"&region=%@",[parameterDictionary objectForKey:@"region"]];
    [requestUrl appendFormat:@"&pageNum=%@",[parameterDictionary objectForKey:@"pageNum"]];
    [requestUrl appendFormat:@"&pageSize=%@",[parameterDictionary objectForKey:@"pageSize"]];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
	
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    
    return url;
}
//3.8彩票喜好设置
+ (NSURL *)CBsetLikeLotteryByUserId:(NSString *)userId lotteryTypes:(NSString *)lotteryTypes
{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",kSetLikeLotteryByUserId];
    [requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&lotteryTypes=%@",lotteryTypes];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//4.4获取彩票喜欢设置

+ (NSURL *)CBgetLikeLotteryByUserId:(NSString *)userId{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",kgetLikeLotteryByUserId];
    [requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//4.5 合作用户登录连接
+ (NSURL *)CBUnitonLogin:(NSString *)loginSource {
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    [requestUrl appendString:BangdingURL];
    [requestUrl appendFormat:@"sid=%@",[[Info getInstance] cbSID]];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
	[requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&loginSource=%@",loginSource];
    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[requestUrl release];
	return url;
	
}
//+ (NSURL *)CBUnitonLogin:(NSString *)loginSource {
//	NSMutableString *requestUrl = [[NSMutableString alloc] init];
//	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
//    [requestUrl appendString:BangdingURL];
//    [requestUrl appendFormat:@"sid=%@",[[Info getInstance] cbSID]];
//    if ([deviceToken length]>10) {
//		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
//	}
//	[requestUrl appendFormat:@"&macCode=%@", macCode];
//	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
//    //	[requestUrl appendFormat:@"&source=%@", kSouse];
//	[requestUrl appendFormat:@"&loginSource=%@",loginSource];
//    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//	return url;
//	
//}
+ (NSURL *)CBBangDing:(NSString *)BangdingType; {
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    [requestUrl appendString:BangdingURL];
    [requestUrl appendFormat:@"sid=%@",[[Info getInstance] cbSID]];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	[requestUrl appendFormat:@"&type=%@",@"1"];
	[requestUrl appendFormat:@"&userId=%@",[[Info getInstance] userId]];
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
	[requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&loginSource=%@",BangdingType];
    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[requestUrl release];
	return url;
	
}

//+ (NSURL *)CBBangDing:(NSString *)BangdingType; {
//	
//	NSMutableString *requestUrl = [[NSMutableString alloc] init];
//	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
//    [requestUrl appendString:BangdingURL];
//    [requestUrl appendFormat:@"sid=%@",[[Info getInstance] cbSID]];
//    if ([deviceToken length]>10) {
//		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
//	}
//	[requestUrl appendFormat:@"&type=%@",@"1"];
//	[requestUrl appendFormat:@"&userId=%@",[[Info getInstance] userId]];
//	[requestUrl appendFormat:@"&macCode=%@", macCode];
//	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
//    //	[requestUrl appendFormat:@"&source=%@", kSouse];
//	[requestUrl appendFormat:@"&loginSource=%@",BangdingType];
//    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//	return url;
//	
//}

+ (NSURL *)CBPPTVLoginWithUserName:(NSString *)username Password:(NSString *)passWord{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",@"pptvlogin"];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
    //	[requestUrl appendFormat:@"&source=%@", @"1"];
	[requestUrl appendFormat:@"&loginSource=%@",kSouse];
    username = [NSString encodeToPercentEscapeString:username];
    [requestUrl appendFormat:@"&username=%@",username];
    passWord = [NSString encodeToPercentEscapeString:passWord];
    [requestUrl appendFormat:@"&password=%@",passWord];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	return url;
}
//4.7合作用户补充昵称接口
+ (NSURL *)CBsetNickNameForUnionUser:(NSString *)unionId NickName:(NSString *)nickName Status:(NSString *)status Partnerid:(NSString *)partnerid LoginSoure:(NSString *)loginSoure{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",ksetNickNameForUnionUser];
	[requestUrl appendFormat:@"&unionId=%@",unionId];
    nickName = [NSString encodeToPercentEscapeString:nickName];
	[requestUrl appendFormat:@"&nickName=%@",nickName];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
	[requestUrl appendFormat:@"&loginSource=%@",loginSoure];
    //	[requestUrl appendFormat:@"&source=%@", kSouse];
	[requestUrl appendFormat:@"&status=%@", status];
    [requestUrl appendFormat:@"&partnerid=%@",partnerid];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
	
	return url;
}

//pptv 完善昵称
+ (NSURL *)CBsetNickNameForPPTVUnionUser:(NSString *)unionId NickName:(NSString *)nickName UserName:(NSString *)user_name Partnerid:(NSString *)partnerid Password:(NSString *)password{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",kaddPPTVuserInfo];
	[requestUrl appendFormat:@"&unionId=%@",unionId];
    nickName = [NSString encodeToPercentEscapeString:nickName];
	[requestUrl appendFormat:@"&nick_name=%@",nickName];
    user_name = [NSString encodeToPercentEscapeString:user_name];
    [requestUrl appendFormat:@"&username=%@",user_name];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    if ([deviceToken length]>10) {
		[requestUrl appendFormat:@"&deviceToken=%@", deviceToken];
	}
	[requestUrl appendFormat:@"&macCode=%@", macCode];
	[requestUrl appendFormat:@"&vision=%@", [[Info getInstance] cbVersion]];
	[requestUrl appendFormat:@"&loginSource=%@",kSouse];
    //	[requestUrl appendFormat:@"&source=%@", @"1"];
    [requestUrl appendFormat:@"&partnerid=%@",partnerid];
    password = [NSString encodeToPercentEscapeString:password];
    [requestUrl appendFormat:@"&password=%@",password];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//4.8合作用户设置同步接口
+ (NSURL *)CBsetSysBlogForUnionUser:(NSString *)userId LoginSource:(NSString *)loginSource Status:(NSString *)status {
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",ksetSysBlogForUnionUser];
	[requestUrl appendFormat:@"&loginSource=%@",loginSource];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&status=%@",status];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
	return url;
	
}


//4.9获取合作用户同步设置接口

+ (NSURL *)CBgetSysBlogForUnionUser:(NSString *)userId LoginSource:(NSString *)loginSource {
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kgetSysBlogForUnionUser];
	[requestUrl appendFormat:@"&loginSource=%@",loginSource];
	[requestUrl appendFormat:@"&userId=%@",userId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	return url;
}

//5.0 清除app应用消息
+ (NSURL *)CBdelAppMsg:(NSString *)token {
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kdelAppMsg];
	[requestUrl appendFormat:@"&deviceToken=%@",token];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
	return url;
}
//5.1 设定用户实名信息
+ (NSURL *)CBauthentication:(NSString *)id_card UserID:(NSString *)userId True_name:(NSString *)true_name Mobile:(NSString *)mobile {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",kauthentication];
	[requestUrl appendFormat:@"&user_id_card=%@",id_card];
    [requestUrl appendFormat:@"&userId=%@",userId];
    [requestUrl appendFormat:@"&true_name=%@",true_name];
    [requestUrl appendFormat:@"&mobile=%@",mobile];
    [requestUrl appendFormat:@"&maccode=%@", [UDIDFromMac uniqueGlobalDeviceIdentifier]];
    
    
    NSString *code = [NSString stringWithFormat:@"%@%@", userId, @"ly.(132"];
	const char *cStr = [code UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	code =[NSString stringWithFormat:
		   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
		   result[0], result[1], result[2], result[3],
		   result[4], result[5], result[6], result[7],
		   result[8], result[9], result[10], result[11],
		   result[12], result[13], result[14], result[15]
		   ];
	code = [code lowercaseString];
    [requestUrl appendFormat:@"&verify=%@", code];
    
	//[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"url = %@", url);
	return url;
    
}


/******pk赛*******/
//pk赛排行等级
+ (NSURL *)PKMatchGrade:(NSString *)type{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",pkgRade];
    [requestUrl appendFormat:@"&type=%@", type];
    
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//查询在售/往期期次列表
+ (NSURL *)pkIssueList:(NSString *)issueNumber{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkIssue];
    if (issueNumber != nil) {
        [requestUrl appendFormat:@"&issueNumber=%@", issueNumber];
    }
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//查询pk赛的投注记录
+ (NSURL *)pkBetRecordIssue:(NSString *)issue pageNum:(NSString *)page{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkRecord];
    [requestUrl appendFormat:@"&issue=%@", issue];
    [requestUrl appendFormat:@"&pageNum=%@", page];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
    [requestUrl release];
    return url;
}

//我的pk赛的投注记录
+ (NSURL *)myPkBetRecordUseId:(NSString *)useId pageNum:(NSString *)page{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", myRecord];
    [requestUrl appendFormat:@"&userId=%@", useId];
    [requestUrl appendFormat:@"&pageNum=%@", page];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}
//过关统计
+ (NSURL *)pkguoGuanIssue:(NSString *)issue pageNum:(NSString *)page{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkStatistics];
    [requestUrl appendFormat:@"&issue=%@", issue];
    [requestUrl appendFormat:@"&pageNum=%@", page];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//pk赛方案详情
+ (NSURL *)pkorderDetailOrderId:(NSString *)orderId{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkDetails];
    [requestUrl appendFormat:@"&orderId=%@", orderId];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//pk搜索
+ (NSURL *)pkSearchSearchKey:(NSString *)searchKey{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkSearch];
    searchKey = [NSString encodeToPercentEscapeString:searchKey];
   
    [requestUrl appendFormat:@"&searchKey=%@", searchKey];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//pk赛对阵信息
+ (NSURL *)pkMatchInfo:(NSString *)issue{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkInfo];
    [requestUrl appendFormat:@"&issue=%@", issue];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//pk投注
//+ (NSURL *)pkBuyLotterybetNumber:(NSString *)betNuber userid:(NSString *)userId betCount:(NSString *)count issue:(NSString *)issue{
//    NSMutableString * requestUrl = [[NSMutableString alloc] init];
//    [requestUrl appendString:pkweb_URL];
//    [requestUrl appendFormat:@"function=%@", pkBet];
//    betNuber = [NSString encodeToPercentEscapeString:betNuber];
//    [requestUrl appendFormat:@"&betNumber=%@", betNuber];
//    [requestUrl appendFormat:@"&userId=%@", userId];
//    [requestUrl appendFormat:@"&betCount=%@", count];
//    [requestUrl appendFormat:@"&issue=%@", issue];
//	[requestUrl appendFormat:@"&loginId=%@", userId];
//        [requestUrl appendFormat:@"&source=%@", kSouse];
//    NSString *timeStamp =[NSString stringWithFormat:@"%ld", time(nil)];
//    
//    [requestUrl appendFormat:@"&id=%@",timeStamp];
//    
//    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//    [requestUrl release];
//    return url;
//}
//pk投注
+ (NSURL *)pkBuyLotterybetNumber:(NSString *)betNuber userid:(NSString *)userId betCount:(NSString *)count issue:(NSString *)issue{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:pkweb_URL];
    [requestUrl appendFormat:@"function=%@", pkBet];
    [requestUrl appendFormat:@"&betNumber=%@", betNuber];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&betCount=%@", count];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSString *timeStamp =[NSString stringWithFormat:@"%ld", time(nil)];
    
    [requestUrl appendFormat:@"&id=%@",timeStamp];
    
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    NSURL * url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [requestUrl release];
    return url;
}


//pk直接投注
+ (NSURL *)pkZhiJieBuyLotterybetNumber:(NSString *)betNuber userid:(NSString *)userId betCount:(NSString *)count issue:(NSString *)issue{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", pkBet];
    betNuber = [NSString encodeToPercentEscapeString:betNuber];
    [requestUrl appendFormat:@"&betNumber=%@", betNuber];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&betCount=%@", count];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//投注站 话题
+(NSURL *)cpSanLiuWu{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", cpsanliuwu];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//彩种期次
+ (NSURL *)caipiaolottery{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", cplottery];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//红人榜
+ (NSURL *)caipiaoRedRequest{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", cpred];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//投注站搜索
+(NSURL *)cpthreeSearchSearchKey:(NSString *)searchKey{
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", cpthreesearch];
    [requestUrl appendFormat:@"&searchKey=%@", searchKey];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

// 帖子投注详情
+(NSURL *)CBtopicBetInfo:(NSString *)topicId {
	NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", ktopicBetInfo];
    [requestUrl appendFormat:@"&topicId=%@", topicId];
	NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
        [requestUrl appendFormat:@"&userId=%@",userId];
	}
    else {
        [requestUrl appendFormat:@"&userId=0"];
    }
    NSString *userName = [[Info getInstance] userName];
    if (userName) {
        userName = [NSString encodeToPercentEscapeString:userName];
        [requestUrl appendFormat:@"&userName=%@",userName];
    }
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}


//365八方预测
+(NSURL *)CBgetBFYC:(NSString *)playId {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", kgetBFYC];
	[requestUre appendFormat:@"&playId=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

+(NSURL *)refreshEURO:(NSString *)playId {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", krefreshEURO];
	[requestUre appendFormat:@"&playId=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}
+(NSURL *)refreshASIA:(NSString *)playId {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", krefreshASIA];
	[requestUre appendFormat:@"&playId=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}


+(NSURL *)refreshBall:(NSString *)playId {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", KrefreshBall];
	[requestUre appendFormat:@"&playId=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

//篮球八方预测
+(NSURL *)CBgetLanQiuBFYC:(NSString *)playId{
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", kgetLanqiuBFYC];
	[requestUre appendFormat:@"&playid=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
//    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

//篮球八方预测排名kgetLanqiuBFYCPHB

+(NSURL *)CBgetLanQiuBFYCHB:(NSString *)playId{
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", kgetLanqiuBFYCPHB];
	[requestUre appendFormat:@"&playid=%@", playId];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
//    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}


//遗漏图
+(NSURL *)CBgetYL:(NSString *)lottery Item:(NSString *)item {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    if ([lottery isEqualToString:@"3d"]) {
        [requestUre appendFormat:@"function=%@", kl10fen];
    }else{
        [requestUre appendFormat:@"function=%@", kgetYL];
    }
	[requestUre appendFormat:@"&lottery=%@", lottery];
	[requestUre appendFormat:@"&item=%@", item];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

//快3走势图
+(NSURL *)kuai3YiLouTuo:(NSString *)lottery Item:(NSString *)item {
	NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", kgetYL_K3];
	[requestUre appendFormat:@"&lottery=%@", lottery];
	[requestUre appendFormat:@"&item=%@", item];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

//获取用户信息投注站
+ (NSURL *)CPThreeGetAuthentication:(NSString *)username userpassword:(NSString *)password type:(NSString *)type{
    NSMutableString * requestUre = [[NSMutableString alloc] init];
    [requestUre appendString:HOST_URL];
    [requestUre appendFormat:@"function=%@", cpthreeAuthentication];
    username = [NSString encodeToPercentEscapeString:username];
    [requestUre appendFormat:@"&userName=%@", username];
    password = [NSString encodeToPercentEscapeString:password];
    [requestUre appendFormat:@"&password=%@", password];
    [requestUre appendFormat:@"&type=%@", type];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requestUre appendFormat:@"&loginId=%@", userId];
	}
    //    [requestUre appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUre]];
    [requestUre release];
    return url;
}

//新问题反馈
+ (NSURL *)CPThreeQAtwouserid:(NSString *)userid content:(NSString *)content mobile:(NSString *)mobile mail:(NSString *)mail{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cpthreeqa];
    [requesturl appendFormat:@"&userId=%@", userid];
    content = [NSString encodeToPercentEscapeString:content];
    [requesturl appendFormat:@"&content=%@", content];
    [requesturl appendFormat:@"&mobile=%@", mobile];
    [requesturl appendFormat:@"&mail=%@", mail];
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString * verstr = [infoDict objectForKey:@"CFBundleVersion"];
    //    [requesturl appendFormat:@"&version=%@", verstr];
//    NSLog(@"verstr = %@", verstr);
    [requesturl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    [requesturl appendFormat:@"&sysVsersion=%@", @"5.1"];
    NSString *userId = [[Info getInstance] userId];
	if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
    
}
//我来预测发送
+(NSURL *)CPThreeSendPreditTopicIssue:(NSString *)issue userid:(NSString *)userid lotteryId:(NSString *)lotteryId lotteryNumber:(NSString *)lotteryNumber content:(NSString *)content endtime:(NSString *)endt{
    
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cpthreesend];
    [requesturl appendFormat:@"&issue=%@", issue];
    [requesturl appendFormat:@"&userId=%@", userid];
    [requesturl appendFormat:@"&lotteryId=%@", lotteryId];
    lotteryNumber = [NSString encodeToPercentEscapeString:lotteryNumber];
    [requesturl appendFormat:@"&lotteryNumber=%@", lotteryNumber];
   
    content = [NSString encodeToPercentEscapeString:content];
    [requesturl appendFormat:@"&content=%@", content];
    endt = [NSString encodeToPercentEscapeString:endt];
    [requesturl appendFormat:@"&endtime=%@", endt];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    NSLog(@"lottid = %@", lotteryId);
    NSLog(@"num = %@", lotteryNumber);
    NSLog(@"content = %@", url );
    return url;
    
}
//开奖话题
+(NSURL *)cpthreeKaiJiangHuaTiLotteryId:(NSString *)lotteryId userid:(NSString *)userId pageSize:(NSString *)pagesize PageNum:(NSString *)pagenum issue:(NSString *)issue themeName:(NSString *)name{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cpthreehuati];
    [requesturl appendFormat:@"&lotteryId=%@", lotteryId];
    [requesturl appendFormat:@"&userId=%@", userId];
    [requesturl appendFormat:@"&pageSize=%@", pagesize];
    [requesturl appendFormat:@"&PageNum=%@", pagenum];
    [requesturl appendFormat:@"&issue=%@", issue];
    name = [NSString encodeToPercentEscapeString:name];
    [requesturl appendFormat:@"&themeName=%@", name];
    NSString *userId1 = [[Info getInstance] userId];
    if ([userId1 length]) {
		[requesturl appendFormat:@"&loginId=%@", userId1];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
}
// 八方视频
+ (NSURL *)baFangShiPing{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", bafangshipin];
    NSString *userId1 = [[Info getInstance] userId];
    if ([userId1 length]) {
		[requesturl appendFormat:@"&loginId=%@", userId1];
	}
    NSLog(@"%@", [[Info getInstance] cbVersion]);
    //	[requesturl appendFormat:@"&version=%@",[[Info getInstance] cbVersion]];
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
    
}

+ (NSURL *)sendTopicMessageToMqtopicId:(NSString *)topicId ShareSource:(NSString *)shareSource Content:(NSString *)content orderID:(NSString *)lotteryid{
	
	NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", ksendTopicMessageToMq];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
		[requesturl appendFormat:@"&userId=%@", userId];
	}
	[requesturl appendFormat:@"&topicId=%@", topicId];
	[requesturl appendFormat:@"&shareSource=%@", shareSource];
	[requesturl appendFormat:@"&content=%@", content];
    if (!lotteryid) {
        lotteryid = @"";
    }
    [requesturl appendFormat:@"&shareorderId=%@", lotteryid];
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
}

//合买红人榜
+(NSURL *)hemaihongrenbangLotteryId:(NSString *)lotteryId page:(NSString *)page{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", hemaihongrenbang];
    [requesturl appendFormat:@"&lotteryId=%@", lotteryId];
    [requesturl appendFormat:@"&pagenum=%@", page];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
    
}



//新闻列表
+ (NSURL *)CPThreeNewsPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cpthreeNews];
    [requesturl appendFormat:@"&pageSize=%@", pageSize];
    [requesturl appendFormat:@"&pageNum=%@", pageNum];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl] ];
    [requesturl release];
    return url;
}

//获取app应用列表
+(NSURL *)CPgetAppInfoList:(NSString *)userid pageNum:(NSString *)pagenum app_type:(NSString *)appType pageSize:(NSString *)pagesize {
    
    NSMutableString *requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kgetAppInfoList];
    [requesturl appendFormat:@"&userId=%@",userid];
    [requesturl appendFormat:@"&pageNum=%@", pagenum];
    [requesturl appendFormat:@"&app_type=%@",appType];
    [requesturl appendFormat:@"&pageSize=%@", pagesize];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
    
}

//奖励活动列表
+ (NSURL *)CPQueryActivtyListPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum{
    
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kqueryActivtyList];
    [requesturl appendFormat:@"&pageSize=%@", pageSize];
    [requesturl appendFormat:@"&pageNum=%@", pageNum];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
    
    
}
//通过username来获取userid
+ (NSURL *)cpThreeUserName:(NSString *)userNameStr{
    
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cphreeuserid];
    userNameStr = [NSString encodeToPercentEscapeString:userNameStr];
    [requesturl appendFormat:@"&username=%@", userNameStr];
    
    
    NSString *code = [NSString stringWithFormat:@"%@%@", userNameStr, @"ly-16478jklk"];
	const char *cStr = [code UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result );
	code =[NSString stringWithFormat:
		   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
		   result[0], result[1], result[2], result[3],
		   result[4], result[5], result[6], result[7],
		   result[8], result[9], result[10], result[11],
		   result[12], result[13], result[14], result[15]
		   ];
	code = [code lowercaseString];
    
    [requesturl appendFormat:@"&verify=%@", code];
    
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    
    return url;
    
}


//保存登录信息登录
+(NSURL *)cpLoginSaveUserName:(NSString *)uname{
    NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
//    NSString *version = [[Info getInstance] cbVersion];//;
    NSString *sid = [[Info getInstance] cbSID];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", cploginsave];
    [requesturl appendFormat:@"&sid=%@", sid];
    
    NSString * userNameString = @"";
    if (uname) {//判断用户名是否为nil
        userNameString = [NSString encodeToPercentEscapeString:uname];
    }else{
        userNameString =[NSString  encodeToPercentEscapeString:@""];
    }
    NSDate * date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];//时间戳
    NSString * secretString  = [NSString stringWithFormat:@"%@_%@", timeSp, userNameString];//secret拼串 时间戳+_+用户名
    secretString = [secretString AES256EncryptWithKey:clientParaKey];
    secretString = [NSString encodeToPercentEscapeString:secretString];
    [requesturl appendFormat:@"&userName=%@", secretString];
    
//    [requesturl appendFormat:@"&vision=%@", version];
    
    
    
    if ([deviceToken length]>10) {
		[requesturl appendFormat:@"&deviceToken=%@", deviceToken];
	}
    [requesturl appendFormat:@"&macCode=%@", macCode];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    NSLog(@"url = %@", url);
    [requesturl release];
    return url;
    
}

////保存登录信息登录
//+(NSURL *)cpLoginSaveUserName:(NSString *)uname{
//    NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
//    NSString *version = [[Info getInstance] cbVersion];//;
//    NSString *sid = [[Info getInstance] cbSID];
//    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//    
//    NSMutableString * requesturl = [[NSMutableString alloc] init];
//    [requesturl appendString:HOST_URL];
//    [requesturl appendFormat:@"function=%@", cploginsave];
//    [requesturl appendFormat:@"&sid=%@", sid];
//    [requesturl appendFormat:@"&userName=%@", uname];
//    //    [requesturl appendFormat:@"&version=%@", version];
//    [requesturl appendFormat:@"&vision=%@", version];
//    [requesturl appendFormat:@"&source=%@", kSouse];
//    //    [requesturl appendFormat:@"&clientId=%@", macCode];
//    
//    if ([deviceToken length]>10) {
//		[requesturl appendFormat:@"&deviceToken=%@", deviceToken];
//	}
//    [requesturl appendFormat:@"&macCode=%@", macCode];
//    NSString *userId = [[Info getInstance] userId];
//    if ([userId length]) {
//		[requesturl appendFormat:@"&loginId=%@", userId];
//	}
//    
//    NSURL * url = [NSURL URLWithString:[requesturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"url = %@", url);
//    [requesturl release];
//    return url;
//    
//}


//邀请好友
+ (NSURL *)CBInviteFriend:(NSString *)userid type:(NSString *)Type success:(NSString *)yesorno typeId:(NSString *)typeids
{
    
	
    NSString *sid = [[Info getInstance] cbSID];
    
	
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@", kInviteFriend];
    [requestUrl appendFormat:@"&userId=%@", userid];
    [requestUrl appendFormat:@"&type=%@", Type];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
	[requestUrl appendFormat:@"&success=%@", yesorno];
	[requestUrl appendFormat:@"&typeId=%@", typeids];
    [requestUrl appendFormat:@"&sid=%@", sid];
    
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requestUrl appendFormat:@"&loginId=%@", userId];
	}
    
    
	
   	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@" 邀请好友 %@",url);
	return url;
    
    
}

//客服私信
+(NSURL *)keFuSiXinUserID:(NSString *)userstr{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kefusixin];
    if ([userstr length]) {
        [requestUrl appendFormat:@"&userID=%@", userstr];
    }else{
        [requestUrl appendFormat:@"&userID=%@", @""];
    }
    //     [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"客服私信 %@",url);
	return url;
}


//版本检查更新
+(NSURL *)checkUpDateFunc{
//     NSString *version = [[Info getInstance] cbVersion];//;
    NSString *sid = [[Info getInstance] cbSID];
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",kcheckUpdate];
    [requestUrl appendFormat:@"&identity=%@",identityNum];
    [requestUrl appendFormat:@"&sid=%@",sid];
    [requestUrl appendFormat:@"&source=%@", kSouse];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"jian cha geng xin = %@", url);
    return url;
}



//好声音
+(NSURL *)cpQueryVoice{
    NSString *sid = [[Info getInstance] cbSID];
    NSMutableString * requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",cpqueryVoice];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&sid=%@",sid];
    NSString * userna = @"0";
    if ([[[Info getInstance] userName] length] > 0) {
        userna = [[Info getInstance] userName];
    }
    [requestUrl appendFormat:@"&user_name=%@",userna];
    //     [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"hao sheng yin = %@", url);
    return url;
}

//11选5遗漏图
+(NSURL *)yiLouTuLottery:(NSString *)lottery item:(NSString *)item category:(NSString *)cate{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", n11xuan5];
    [requesturl appendFormat:@"&lottery=%@", lottery];
    [requesturl appendFormat:@"&item=%@", item];
    [requesturl appendFormat:@"&category=%@", cate];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    NSLog(@"yilou = %@", url);
    return url;
}

//快乐十分
+(NSURL *)klsfLouTuLottery:(NSString *)lottery item:(NSString *)item category:(NSString *)cate{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kl10fen];
    [requesturl appendFormat:@"&lottery=%@", lottery];
    [requesturl appendFormat:@"&item=%@", item];
    [requesturl appendFormat:@"&category=%@", cate];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    NSLog(@"yilou = %@", url);
    return url;
    
    
}

//找回密码之获取用户信息
+(NSURL *)FindpasswordUserInfo:(NSString *)userstr {
    
    NSLog(@"%@",userstr);
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    //    NSString *version = [[Info getInstance] cbVersion];
    NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", FindPasswordgetUserInfo];
    if ([userstr length]) {
        userstr = [NSString encodeToPercentEscapeString:userstr];
        [requestUrl appendFormat:@"&nick_name=%@", userstr];
    }else{
        [requestUrl appendFormat:@"&nick_name=%@", @""];
    }
    //    [requestUrl appendFormat:@"&source=%@",kSouse];
    //    [requestUrl appendFormat:@"&version=%@",version];
    [requestUrl appendFormat:@"&Maccode=%@",macCode];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
    
}
//找回密码之获取验证码
+(NSURL *)FindpasswordGetJiaoyanma:(NSString *)nickname mobile:(NSString *)mobil {
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", FindPasswordgetJiaoyanma];
    if ([nickname length]) {
        nickname = [NSString encodeToPercentEscapeString:nickname];
        [requestUrl appendFormat:@"&nick_name=%@", nickname];
    }else{
//        nickname = [NSString encodeToPercentEscapeString:nickname];
        [requestUrl appendFormat:@"&nick_name=%@", @""];
    }
    mobil = [NSString encodeToPercentEscapeString:mobil];
    [requestUrl appendFormat:@"&mobile=%@",mobil];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
    
}
//找回密码之输入验证码
+(NSURL *)FindpasswordInputJiaoyanma:(NSString *)nickname Id:(NSString *)idstr Code:(NSString *)codes {
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", FindPasswordInputJiaoyanma];
    if ([nickname length]) {
        nickname = [NSString encodeToPercentEscapeString:nickname];
        [requestUrl appendFormat:@"&nick_name=%@", nickname];
    }else{
        [requestUrl appendFormat:@"&nick_name=%@", @""];
    }
    [requestUrl appendFormat:@"&id=%@",idstr];
    [requestUrl appendFormat:@"&code=%@",codes];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
    
}
//找回密码之修改密码
+(NSURL *)FindpasswordChangePassword:(NSString *)nickname Uuid:(NSString *)uuidstr Password:(NSString *)pasw {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
	[requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", FindPasswordChangePassword];
    if ([nickname length]) {
        nickname = [NSString encodeToPercentEscapeString:nickname];
        [requestUrl appendFormat:@"&nick_name=%@", nickname];
    }else{
        [requestUrl appendFormat:@"&nick_name=%@", @""];
    }
    [requestUrl appendFormat:@"&uuid=%@",uuidstr];
    [requestUrl appendFormat:@"&password=%@",pasw];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl] ];
	[requestUrl release];
    
	return url;
    
}

// 监测能否分享
+(NSURL *)queryUnionshareBlogStatus:(NSString *)user_name Type:(NSString *)type {
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", KqueryUnionshareBlogStatus];
    [requesturl appendFormat:@"&type=%@", type];
    [requesturl appendFormat:@"&user_name=%@", user_name];
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    NSLog(@"yilou = %@", url);
    return url;
}

//官方开奖 足彩北单篮彩
+(NSURL *)footballLotteryDatailType:(NSString *)type iussueString:(NSString *)issue{
    
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", footballLotteryDatail];
    [requesturl appendFormat:@"&type=%@", type];
    [requesturl appendFormat:@"&isDg=%@", @"1"];//0是复试 1是单关 默认是复试
    [requesturl appendFormat:@"&issue=%@", issue];
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    NSLog(@"足彩北单篮彩 = %@", url);
    return url;
}

//64. 我的关注的比赛
+(NSURL *)scoreLiveMyAttentionNew:(NSString *)lotterId{
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", myAttentionNew];
    NSString *userId = [[Info getInstance] userId];
	[requestUrl appendFormat:@"&userId=%@", userId];
	[requestUrl appendFormat:@"&lotteryId=%@", lotterId];
	[requestUrl appendFormat:@"&loginId=%@", userId];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"我的关注的比赛 %@", url);
    
    return url;
    
}

//63 获取比分直播列表（足彩竟彩北单）
+(NSURL *)scoreLiveLotteryId:(NSString *)lotteryId issue:(NSString *)issue userId:(NSString *)userId matchestate:(NSString *)matchestate{
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", getMacthTypeNew];
    
	[requestUrl appendFormat:@"&lotteryId=%@", lotteryId];
    [requestUrl appendFormat:@"&issue=%@", issue];
	[requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&matchestate=%@",matchestate];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"获取比分直播列表 %@", url);
    
    return url;
    
    
}

//66 未登录的推送
+(NSURL *)unLoginDevicenToken:(NSString *)Token {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kunLogin];
    //    NSString *version = [[Info getInstance] cbVersion];
	NSString *macCode = [UDIDFromMac uniqueGlobalDeviceIdentifier];
	
    //	[requestUrl appendFormat:@"&version=%@", version];
    [requestUrl appendFormat:@"&maccode=%@", macCode];
    [requestUrl appendFormat:@"&deviceToken=%@", Token];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"获取比分直播列表 %@", url);
    
    return url;
}

+(NSURL *)getLiveMatchListByID:(NSString *)playid Lotteryid:(NSString *)lotteryid Issue:(NSString *)issue {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kLiveMatchListByID];
	[requestUrl appendFormat:@"&lotteryid=%@", lotteryid];
    playid = [NSString encodeToPercentEscapeString:playid];
    [requestUrl appendFormat:@"&playid=%@", playid];
    
    [requestUrl appendFormat:@"&issue=%@", issue];
    [requestUrl appendFormat:@"&userId=%@", [[Info getInstance] userId]];
    //    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSLog(@" request11111111111111111111111 = %@", requestUrl);
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"获取比分直播列表 %@", url);
    
    return url;
}

//51 管理员删除用户
+(NSURL *)deleteUserUserid:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdeleteUserByMan];
    [requestUrl appendFormat:@"&deleteid=%@", deleteid];
    username = [NSString encodeToPercentEscapeString:username];
    [requestUrl appendFormat:@"&username=%@", username];
    password = [NSString encodeToPercentEscapeString:password];
    [requestUrl appendFormat:@"&password=%@", password];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 管理员删除用户 %@", url);
    
    return url;
}
//52 管理员删除帖子
+(NSURL *)deleteTopic:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", kdeleteTopicByMan];
    [requestUrl appendFormat:@"&deleteid=%@", deleteid];
    username = [NSString encodeToPercentEscapeString:username];
    [requestUrl appendFormat:@"&username=%@", username];
    password = [NSString encodeToPercentEscapeString:password];
    [requestUrl appendFormat:@"&password=%@", password];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 管理员删除帖子 %@", url);
    
    return url;
}

//53 管理员删除评论
+(NSURL *)deleteCommon:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", kdeleteCommonByMan];
    [requestUrl appendFormat:@"&deleteid=%@", deleteid];
    username = [NSString encodeToPercentEscapeString:username];
    [requestUrl appendFormat:@"&username=%@", username];
    password = [NSString encodeToPercentEscapeString:password];
    [requestUrl appendFormat:@"&password=%@", password];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 管理员删除评论 %@", url);
    
    return url;
}

//56管理员获取用户信息
+(NSURL *)getUserInfo:(NSString *)userId Username:(NSString *)username Password:(NSString *)password {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", kgetUserInfoByMan];
    [requestUrl appendFormat:@"&userId=%@", userId];
    [requestUrl appendFormat:@"&username=%@", username];
    [requestUrl appendFormat:@"&password=%@", password];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 管理员获取用户信息 %@", url);
    
    return url;
}

//之完善用户信息
+(NSURL *)getUserInfoCard:(NSString *)card userId:(NSString *)userId trueName:(NSString *)truename mobile:(NSString *)mobile{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", userAuthentication];
    [requestUrl appendFormat:@"&user_id_card=%@", card];
    [requestUrl appendFormat:@"&userId=%@", userId];
    truename = [NSString encodeToPercentEscapeString:truename];
    [requestUrl appendFormat:@"&true_name=%@", truename];
    [requestUrl appendFormat:@"&mobile=%@", mobile];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 完善信息 %@", url);
    
    return url;


}

//77检测能否参加“7天免费领彩票”活动
+(NSURL *)CheckAchieveActivMon {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", kCheckAchieveActivMon];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&userId=%@", [[Info getInstance] userId]];
    [requestUrl appendFormat:@"&sign=%@", [NetURL EncryptWithMD5:[NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@%@c0b89a87a41d9fd56904c1b91cf59cbb",[[Info getInstance] userId],kSouse,[[Info getInstance] cbVersion]]]]];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@" 检测能否参加“7天免费领彩票”活动 %@", url);
    
    return url;
}

//76关于用户“7天免费领彩票”活动
+(NSURL *)achieveActivMon:(NSString *)type {
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", kachieveActivMon];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    [requestUrl appendFormat:@"&type=%@", type];
//    [requestUrl appendFormat:@"&version=%@", [[Info getInstance] cbVersion]];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&userId=%@", [[Info getInstance] userId]];
    [requestUrl appendFormat:@"&sign=%@", [NetURL EncryptWithMD5:[NetURL EncryptWithMD5:[NSString stringWithFormat:@"%@%@%@f56ec5555bcc2d33ddb7faf004ec6bf1",[[Info getInstance] userId],kSouse,[[Info getInstance] cbVersion]]]]];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    NSLog(@"7天免费领彩票 %@", url);
    
    return url;
}

//91.微信分享送彩金活动
+ (NSURL *)shareBlogActivityRequest:(NSString *)orderID{

    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"&function=%@", SHAREBLOG];
    NSString * userNameString = @"";
    if ([[[Info getInstance] userName] length] > 0) {//判断用户名是否为nil
        userNameString = [[Info getInstance] userName];
    }
    [requestUrl appendFormat:@"&user_name=%@", userNameString];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    
    [requestUrl appendFormat:@"&orderID=%@", orderID];
    NSString * sign = [NSString stringWithFormat:@"%@%@%@%@%@%@", userNameString, kSouse,[[Info getInstance] cbSID],[[Info getInstance] cbVersion],orderID, @"67A13ACA26500F4789574CCBB349DED4"];
    
    
    
    [requestUrl appendFormat:@"&sign=%@",[NetURL EncryptWithMD5:[NetURL EncryptWithMD5:sign] ]];
    
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    [requestUrl release];
    return url;
}

//96获取预测列表
+ (NSURL *)getForecastContentWithPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum
{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", forecastContent];
    [requesturl appendFormat:@"&pageSize=%@", pageSize];
    [requesturl appendFormat:@"&pageNum=%@", pageNum];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl] ];
    [requesturl release];
    return url;
}

//72．获取推广活动详情
+(NSURL *)activityInfoType:(NSString *)type{
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", activityInfo];
	[requestUrl appendFormat:@"&type=%@", type];
    NSString *sid = [[Info getInstance] cbSID];
    [requestUrl appendFormat:@"&sid=%@", sid];
//    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&userId=%@", [[Info getInstance] userId]];
    
//    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
    NSLog(@"获取推广活动详情 %@", url);
    
    return url;
}

//天天竞彩内容
+ (NSURL *)getEverydayContentWithIssue:(NSString *)issue
{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", everydayContent];
    [requesturl appendFormat:@"&issue=%@", issue];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
}

//天天竞彩期次
+ (NSURL *)getEverydayIssue
{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", everydayIssue];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl] ];
    [requesturl release];
    return url;
}

//95获取公告列表queryGonggao
+ (NSURL *)getGonggao
{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", queryGonggao];
    NSString *userId = [[Info getInstance] userId];
    if ([userId length]) {
		[requesturl appendFormat:@"&loginId=%@", userId];
	}
    //    [requesturl appendFormat:@"&source=%@", kSouse];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl] ];
    [requesturl release];
   
    return url;
}

//97第三方授权后登录cmwb接口

+ (NSURL *)loginUnionWithloginSource:(NSString *)loginSource unionId:(NSString *)unionId token:(NSString *)token tokenSecret:(NSString *)tokenSecret openid:(NSString *)openid userId:(NSString *)userId {
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kUnionLogin1];
    [requesturl appendFormat:@"&loginSource=%@", loginSource];
    [requesturl appendFormat:@"&macCode=%@",[UDIDFromMac uniqueGlobalDeviceIdentifier]];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if ([deviceToken length]) {
        [requesturl appendFormat:@"&deviceToken=%@",deviceToken];
    }
    [requesturl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    [requesturl appendFormat:@"&unionId=%@",unionId];
    [requesturl appendFormat:@"&token=%@",token];
    [requesturl appendFormat:@"&tokenSecret=%@",tokenSecret];
    [requesturl appendFormat:@"&openid=%@",openid];
    if (userId) {
        [requesturl appendFormat:@"&userId=%@",userId];
    }
    
    
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl] ];
    [requesturl release];
    
    return url;
}

//101预测奖金
+ (NSURL *)JiangJinJiSuanWithlotteryid:(NSString *)lotteryid t_h:(NSString *)t_h t_l:(NSString *)t_l z_h:(NSString *)z_h z_l:(NSString *)z_l playtype:(NSString *)playtype issue:(NSString *)issue {
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kJisuanjiangjin];
    [requesturl appendFormat:@"&lotteryid=%@",lotteryid];
    [requesturl appendFormat:@"&t_h=%@",t_h];
    [requesturl appendFormat:@"&t_l=%@",t_l];
    [requesturl appendFormat:@"&z_h=%@",z_h];
    [requesturl appendFormat:@"&z_l=%@",z_l];
    [requesturl appendFormat:@"&playtype=%@",playtype];
    [requesturl appendFormat:@"&issue=%@",issue];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    
    return url;
}

//102支付宝插件登陆第一步获取参数
+ (NSURL *)alipayCanshu {
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", kpreAlipayLogin];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    
    return url;
}

//104红人榜日榜（按天）
+(NSURL *)rankingListDateRequest{

    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", RankingListDate];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    
    return url;
}

//103红人榜总榜
+(NSURL *)rankingListCountRequest{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", RankingListCount];
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    
    return url;
}

+(NSURL *)ssqAndddtLotteryid:(NSString *)lotterId itemNum:(NSString *)num issue:(NSString *) issue cacheable:(BOOL)cach
{
    NSMutableString * requesturl = [[NSMutableString alloc] init];
    [requesturl appendString:HOST_URL];
    [requesturl appendFormat:@"function=%@", SSQAndDLT];
    if ([issue length]) {
        [requesturl appendFormat:@"&issue=%@", issue];
    }
    [requesturl appendFormat:@"&lotteryid=%@", lotterId];
    [requesturl appendFormat:@"&item_num=%@", num];
    [requesturl appendFormat:@"&cacheable=%d", cach];

    NSLog(@"~~~%@",requesturl);
    NSURL * url = [NSURL URLWithString:[self returnPublicUse:requesturl]];
    [requesturl release];
    return url;
}

+(NSURL *)ssqAndddtLotteryid:(NSString *)lotterId itemNum:(NSString *)num issue:(NSString *) issue{
    return [self ssqAndddtLotteryid:lotterId itemNum:num issue:issue cacheable:NO];
}

//84 获取用户在第三方的昵称
+(NSURL *)getUnionNickNameWithUserId{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", getUnionName];
	
    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&userid=%@", [[Info getInstance] userId]];
    
    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[requestUrl release];
    
    NSLog(@"获取用户在第三方的昵称 %@", url);
    
    return url;
    
}

//85 删除用户向第三方分享
+(NSURL *)deleteUnionUserShareWithType:(NSString *)type{//1新浪2腾讯微博3qq
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", deleteUnion];
	
    [requestUrl appendFormat:@"&source=%@", kSouse];
    [requestUrl appendFormat:@"&type=%@", type];
    [requestUrl appendFormat:@"&userid=%@", [[Info getInstance] userId]];
    
    NSURL *url = [NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[requestUrl release];
    
    NSLog(@"删除用户向第三方分享 %@", url);
    
    return url;
}
//6.3 国旗活动获奖列表
//+(NSURL *)getFlagPrize_WinnerListWithCurPage:(int)page andPageSize:(int)pagesize
//{
//    NSMutableString *requestUrl = [[NSMutableString alloc] init];
//    [requestUrl appendString:HOST_URL];
//    [requestUrl appendFormat:@"function=%@",getFlagPrize_Winner];
//    [requestUrl appendFormat:@"&curPage=%d",page];
//    [requestUrl appendFormat:@"&pageSize=%d",pagesize];
//    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//    [requestUrl release];
//    NSLog(@"国旗活动获奖列表 %@",url);
//    return url;
//    
//}

//6.0 世界杯活动报名
//+ (NSURL*)worldCupSignUp
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",SignUpFlagActive];
//	[requestUrl appendFormat:@"&userName=%@",[[Info getInstance] userName]];
//    NSLog(@"%@",[[Info getInstance] userName]);
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}

//6.1获得的国旗列表
//+ (NSURL*)worldCupGetFlagItem
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",GetFlagItem];
//	[requestUrl appendFormat:@"&userName=%@",[[Info getInstance] userName]];
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}

//+ (NSURL*)worldCupGetFlagItemByUserName:(NSString *)userName
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",GetFlagItem];
//	[requestUrl appendFormat:@"&userName=%@",userName];
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}


//6.2 抢彩金接口
//+ (NSURL*)worldCupGetBonusWithCupType:(NSString *)cupType
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",GetBonusbyFlag];
//	[requestUrl appendFormat:@"&userName=%@",[[Info getInstance] userName]];
//    [requestUrl appendFormat:@"&cupType=%@",cupType];
//    NSLog(@"%@",[[Info getInstance] userName]);
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}

//6.4刷新报名状态
//+ (NSURL*)worldCupGetSignUpStatus
//{
//	NSMutableString *requestUrl = [[NSMutableString alloc]init];
//	[requestUrl appendString:HOST_URL];
//	[requestUrl appendFormat:@"function=%@",GetSignUpStatus];
//	[requestUrl appendFormat:@"&userName=%@",[[Info getInstance] userName]];
//    NSLog(@"%@",[[Info getInstance] userName]);
//	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
//	[requestUrl release];
//    
//	return url;
//}

//112世界杯期间购彩按钮的状态
+ (NSURL*)getWorldCupDate
{
	NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",GetWorldCupDate];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}


//108 新版足球八方预测主接口-分析中心
+ (NSURL *)getBFYCAnalyzeWithPlayid:(NSString *)playid ZhanjiSize:(NSInteger)count ZSTlenght:(NSInteger)length{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",GetBFYCAnalyze];
	[requestUrl appendFormat:@"&playid=%@",playid];
    [requestUrl appendFormat:@"&zhanjiSize=%d",(int)count];
    [requestUrl appendFormat:@"&ZSTlenght=%d",(int)length];
   
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;

}

//110 赔率中心
+ (NSURL *)getBFYCOddsCenterWithPlayid:(NSString *)playid playSize:(NSInteger)count{

    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",GetBFYCOddsCenter];
	[requestUrl appendFormat:@"&playid=%@",playid];
    [requestUrl appendFormat:@"&playSize=%d",(int)count];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}

//109 获取战绩
+ (NSURL *)getBFYCZhanjiWithPlayid:(NSString *)playid  zhanjiSize:(NSInteger)count teamType:(NSString *)teamType matchType:(NSInteger)matchType{

    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",GetBFYCZhanji];
	[requestUrl appendFormat:@"&playid=%@",playid];
    [requestUrl appendFormat:@"&zhanjiSize=%d",(int)count];
    [requestUrl appendFormat:@"&teamType=%@",teamType];
    [requestUrl appendFormat:@"&matchType=%d",(int)matchType];
    NSLog(@"zhanjirequestUrl = %@", requestUrl);
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;

}

//114足球八方预测-联赛/杯赛的所有轮次的对阵
+ (NSURL *)getBFYCLCWithleague:(NSString *)league season:(NSString *)season seasonType:(NSString *)type lun:(NSString *)lun{
    
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",getBFYCLc];
	[requestUrl appendFormat:@"&league_id=%@",league];
    [requestUrl appendFormat:@"&season=%@",season];
    [requestUrl appendFormat:@"&season_type=%@",type];
    [requestUrl appendFormat:@"&lun=%@",lun];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}

//113足球八方预测-联赛积分榜
+ (NSURL *)getBFYCJiFenBangWithPlayid:(NSString *)playid{
    
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",GetBFYCJiFenBang];
	[requestUrl appendFormat:@"&playid=%@",playid];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}
//107自动回复经典问题和近期问题
+ (NSURL *)getAutoResponseListWithType:(NSString *)type
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",getAutoResponseList];
	[requestUrl appendFormat:@"&type=%@",type];
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}

//应用内弹窗
+(NSURL *)getAppActiveWindowWithUserid:(NSString *)userid
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	[requestUrl appendFormat:@"function=%@",getAppActiveWindow];
    [requestUrl appendFormat:@"&uerId=%@",userid];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if(deviceToken.length > 10)
    {
        [requestUrl appendFormat:@"&deviceID=%@",deviceToken];
    }
    [requestUrl appendFormat:@"&channelNo=%@",[[Info getInstance] cbSID]];
    
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    
	return url;
}

// 115 足彩八方预测-赛前简报
+(NSURL*)BFgetDescriptionByPlayID:(NSString*)playID
{
	NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", GetDescription];
    [requestUrl appendFormat:@"&playid=%@", playID];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    return url;
}

//117推广短信
+(NSURL *)setSmsStateWithState:(NSString *)type{

    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", SetSmState];

    if ([[[Info getInstance] userName] length] > 0) {//判断用户名是否为nil
        [requestUrl appendFormat:@"&userName=%@", [[Info getInstance] userName]];
    }else{
       [requestUrl appendFormat:@"&userName="];
    }
    [requestUrl appendFormat:@"&channel=%@",[[Info getInstance] cbSID]];
    [requestUrl appendFormat:@"&state=%@", type];
    
    NSLog(@"requestUrl = %@", requestUrl);
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    return url;

}

//115足彩八方预测-赛前简报
+(NSURL *)bfycAboutWithPlayid:(NSString *)playid{
    
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@", newBFYCjb];
    [requestUrl appendFormat:@"&playid=%@", playid];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	[requestUrl release];
    return url;

}

//118.微博类型列表
+(NSURL*)getYtTopicTypelistByByBlogtype:(NSString *)blogtype pageNum:(NSString*)pageNum pageSize:(NSString*)pageSize
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
	[requestUrl appendString:HOST_URL];
	
	[requestUrl appendFormat:@"function=%@",klistytTopicType];
    [requestUrl appendFormat:@"&blogtype=%@",blogtype];
	[requestUrl appendFormat:@"&pageSize=%@",pageSize];
    [requestUrl appendFormat:@"&pageNum=%@",pageNum];
	
	NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
	
	NSLog(@"NetURL CBlistYtTopic  url =%@",url);
	
	[requestUrl release];
	
	return url;
}

+(NSURL*)weiBoLikeByTopicId:(NSString *)topicId praisestate:(NSString *)praisestate
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",WeiBoLike];
    [requestUrl appendFormat:@"&userId=%@",[[Info getInstance] userId]];
    [requestUrl appendFormat:@"&topicId=%@",topicId];
    [requestUrl appendFormat:@"&praisestate=%@",praisestate];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
}

+(NSURL*) sendCaiJinBySid {
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",KsidSendMonto];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
}

//123客户端加载启动图接口
+ (NSURL *)getStartPicInfoWithVersion:(NSString *)version{

    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",StartPicInfo];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    [requestUrl appendFormat:@"&sversion=%@", version];
    [requestUrl appendFormat:@"&servertype=ios"];
    NSString * screenSize = @"";
    if (IS_IPHONE_5) {
        screenSize = @"640*1136";
    }else{
        screenSize = @"640*960";
    }
    [requestUrl appendFormat:@"&screenSize=%@", screenSize];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
    
}
+ (NSURL *)getMycaipiaoImage{

    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",MycaipiaoImg];
    [requestUrl appendFormat:@"&sid=%@",[[Info getInstance] cbSID]];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;

}

+(NSURL *)getRefillRemindRequest{
    
    NSMutableString *requestStr = [[NSMutableString alloc] init];
    [requestStr appendString:HOST_URL];
    [requestStr appendFormat:@"function=%@",getRefillRemind];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestStr]];
    
    [requestStr release];
    
    return url;
}

//48、 客户端打补丁接口
+ (NSURL *)getrepairPatch{
    NSMutableString *requestUrl = [[NSMutableString alloc] init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",keyrepairPatch];
    
    
    [requestUrl appendFormat:@"&newVersion=%@",newVersionKey];
    [requestUrl appendFormat:@"&servertype=%@",@"ios"];
    [requestUrl appendFormat:@"&sid=%@", [[Info getInstance] cbSID]];
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
}

//专家申请
+(NSURL *)expertApplyByPicUrl:(NSString *)picUrl parameterStr:(NSString *)parameterStr
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",ExpertApply];
    [requestUrl appendFormat:@"&url=%@",picUrl];
    [requestUrl appendFormat:@"&serviceName=%@",@"zjtjIndexService"];
    [requestUrl appendFormat:@"&methodName=%@",@"zjtjExpertApply"];
    [requestUrl appendFormat:@"&parameters=%@",parameterStr];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
    
}

//专家推荐常见问题
+(NSURL *)expertCommonProblem
{
    NSMutableString *requestUrl = [[NSMutableString alloc]init];
    [requestUrl appendString:HOST_URL];
    [requestUrl appendFormat:@"function=%@",ExpertCommonProblem];
    
    NSURL *url = [NSURL URLWithString:[self returnPublicUse:requestUrl]];
    
    [requestUrl release];
    
    return url;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  NSStringExtra.m
//  caibo
//
//  Created by jacob on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSStringExtra.h"
#import "Info.h"
#import "RegexKitLite.h"
#import "YtTopic.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSStringExtra)


//url地址解析

-(NSString *)urlParseWithString:(NSString *)_url{

    if(_url){
    
        NSError *error;
        NSString *regulaStr = @"http://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!＠#￥％^&*+?:_/=<>]*)?";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *arrayOfAllMatches = [regex matchesInString:_url options:0 range:NSMakeRange(0, [_url length])];
        
        for(NSTextCheckingResult *match in arrayOfAllMatches){
            
            _url = [_url substringWithRange:match.range];
        }
        
        if(_url && _url.length){
        
            return _url;
        }
    }

    return nil;
}

- (BOOL)isUseFulUrl{

    if(self && ![self isEqualToString:@""]){
    
        NSString *url = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2?4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#￥％^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#￥％^&*+?:_/=<>]*)?)";
        return [self isMatchedByRegex:url];
    }
    
    return NO;
}

//判断15位身份证

- (BOOL)shenfenzheng15{
    if (self && ![self isEqualToString:@"0"]) {
        NSString * id15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
        return [self isMatchedByRegex:id15];
    }
    return NO;
}

//判断手机号
- (BOOL)isPhoneNumber
{
    if (self && ![self isEqualToString:@""]) {
        NSString *regex = @"^(10|11|12|13|14|15|16|17|18|19){1}[0-9]{9}$";
        return [self isMatchedByRegex:regex];
    }
    return NO;
}

//中英文字符串长度
- (NSInteger)zifuLong {
    if (self) {
        return [self lengthOfBytesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    }
    return 0;
}

//判断全汉字
- (BOOL)isMatchWithRegexString:(NSString *)regexString {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString] evaluateWithObject:self];
}


- (BOOL)isallaz{
    
    if (self && ![self isEqualToString:@""]) {
        
        
        NSString * regex = @"^[a-z]+$";
        return [self isMatchedByRegex:regex];
    }
    return NO;
}

// 判断字符串全是数字
- (BOOL)isAllNumber
{
    if (self && ![self isEqualToString:@""]) 
    {
        NSString *regex = @"^[0-9]+$";
        return [self isMatchedByRegex:regex];
    }
    return NO;
}

// 判断是否含有符号
- (BOOL)isContainSign
{
    if (self && ![self isEqualToString:@""]) 
    {
        NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5_]+$";
        return [self isMatchedByRegex:regex]? NO:YES;
    }
    return NO;
}

// 判断密码是否符合要求
- (BOOL)isConform
{
    if (self && ![self isEqualToString:@""]) 
    {
        NSString *regex = @"^[a-z0-9_]+$";
        return [self isMatchedByRegex:regex];
    }
    return NO;
}

// 判断是否含有大写字母
- (BOOL)isContainCapital
{
    if (self && ![self isEqualToString:@""]) 
    {
        NSString *regex = @"^.*[A-Z].*$";
        return [self isMatchedByRegex:regex];
    }
    return NO;
}




//字符串转换为:距离目前时间的间隔
//- (NSString*)dateStringToTimeInterval {
//	
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//		
//    NSDate *date = [formatter dateFromString:self];
//	
//		
//	NSTimeInterval timeInterval = [date timeIntervalSinceNow];
//		
//	NSInteger minute = fabs(timeInterval/60);
//	
//	if (minute == 0) {
//		
//        
//        [formatter release];
//		return [NSString stringWithFormat:@"%d分钟前", 1];		
//		
//	}else if (minute >= 60) {
//		
//		NSDate* nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
//		
//		NSString *now = [formatter stringFromDate:nowDate];
//		
//		NSRange range = {0,10};
//		
//		NSRange yearRange = {0,4};
//        
//        [formatter release];
//		
//		if (![[self substringWithRange:yearRange] isEqualToString:[now substringWithRange:yearRange]]) {
//		  
//			NSRange	ymd = {0,10};
//			
//		 return [NSString stringWithFormat:@"%@", [self substringWithRange:ymd]];
//			
//			
//		}else if ([[self substringWithRange:range] isEqualToString:[now substringWithRange:range]] ) {
//			NSRange timerange = {10,6};
//						
//			return [NSString stringWithFormat:@"今天%@", [self substringWithRange:timerange]];
//			
//		}else {
//			NSRange dayrange = {5,11};
//
//			return [NSString stringWithFormat:@"%@", [self substringWithRange:dayrange]];
//
//		}
//
//		
//	}else {
//		
//        [formatter release];
//		return [NSString stringWithFormat:@"%d分钟前", minute];
//	}
//	
//	 
//
//}

//字符串转换为TimeInterval
- (NSString *)stringToDateTimeInterval {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	NSDate *date = [formatter dateFromString:self];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	[formatter release];
	
	return [NSString stringWithFormat:@"%ld", (long)timeInterval];
}

 
// html  除去标签

- (NSString *)flattenHTML:(NSString *)html {
	
    NSScanner *theScanner;
    NSString *text = nil;
	
    theScanner = [NSScanner scannerWithString:html];
	
    while ([theScanner isAtEnd] == NO) {
		
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
		
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
		
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@>", text]
											   withString:@" "];
		
    } // while //
    
    return html;
	
	
}

// 处理标签 和表情 并且带@标志
-(NSString*)flattenColorPartHTML:(NSString*)html{
    NSLog(@"htmlbbb = %@", html);
    
    
    
    // 去除换行
    NSString *mTmp = [NSString stringWithFormat:@"%c",'\n'];
    html = [html stringByReplacingOccurrencesOfString:mTmp withString:@""];
    
    NSString* regexString=@"<a(.+?)>";
    NSString*   regexString2 =@"</a>";
    NSString *regexImg = @"(<img(.+?)/faces/)|(.gif\"/>)";
    html = [html stringByReplacingOccurrencesOfRegex:regexString withString:@"["];
    html = [html stringByReplacingOccurrencesOfRegex:regexString2 withString:@"]"];
    NSInteger len = [html length];
    html = [html stringByReplacingOccurrencesOfRegex:regexImg withString:@"|"];
    //NSLog(@"html-->%@",html );
    NSInteger len2 =[html length];
    
    if(len != len2)
    {
        NSArray* arr =  [html componentsSeparatedByString:@"|"];
        //        NSInteger count = [arr count];
        NSLog(@"aaa html-->%@",arr );
        if( arr  )
        {
            // NSInteger len  = [arr count];
            NSInteger tmp = 0 ;
            BOOL isDv = FALSE;
//            BOOL isDiv = FALSE;
            //NSMutableString *faceappen = [[NSMutableString alloc] init];
            NSMutableString* faceappen = [NSMutableString string];
            for (NSString *pic in arr)
            {
                NSLog(@"aapic = %@",pic);
                if ( [pic length] !=0 )
                {
                    
                    if(isDv)
                    {
                        [faceappen appendString:@"["];
                        //						pic=[pic faceTestChange];
                        [faceappen appendString:pic];
                        [faceappen appendString:@"]"];
//                        isDv = FALSE;
                    }else
                    {
                        if( tmp == 0 )
                        {
                            [faceappen appendString:pic];
                        }else
                        {
                            //                            if( tmp == count-1 || isDiv )
                            //                            {
                            //                                [faceappen appendString:@"["];
                            //                                [faceappen appendString:pic];
                            //                                [faceappen appendString:@"]"];
                            //                                isDiv = FALSE;
                            //                            }
                            //                            else
                            //                            {
                            //                               [faceappen appendString:@"["];
                            //								pic=[pic faceTestChange];
                            [faceappen appendString:pic];
                            //                                [faceappen appendString:@"]"];
                            //                                isDiv = TRUE;
                            //                            }
                        }
                    }
                    
                }else{
                    
//                    isDiv = FALSE;
                }
                
                if( tmp%2 == 0)
                {
                    isDv = TRUE;
                }else
                {
                    //todo
                    isDv = FALSE;
                }
                
                tmp = tmp + 1;
                //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, filename] error:nil];
            }
            //NSLog(@"pic->%@ ", faceappen );
            
            //         html = [faceappen retain];
            //         [faceappen release];
            return faceappen;
        }
        
        return html;
    }
    
//    NSArray *array = [html componentsSeparatedByString:@"详见"];
//    if(array.count == 2)
//    {
//        html = [NSString stringWithFormat:@"%@详见\n%@",[array objectAtIndex:0],[array objectAtIndex:1]];
//    }
    
    return html;
}


// 处理标签 和表情
-(NSString*)flattenPartHTML:(NSString*)html{
    NSLog(@"htmlbbb = %@", html);
    
    
    
    // 去除换行
    NSString *mTmp = [NSString stringWithFormat:@"%c",'\n'];
    html = [html stringByReplacingOccurrencesOfString:mTmp withString:@""];
    
    NSString* regexString=@"<a(.+?)>|</a>";
    NSString *regexImg = @"(<img(.+?)/faces/)|(.gif\"/>)";
    html = [html stringByReplacingOccurrencesOfRegex:regexString withString:@""];
    
    NSInteger len = [html length];
    html = [html stringByReplacingOccurrencesOfRegex:regexImg withString:@"|"];
    //NSLog(@"html-->%@",html );
    NSInteger len2 =[html length];
    
    if(len != len2)
    {       
        NSArray* arr =  [html componentsSeparatedByString:@"|"];
//        NSInteger count = [arr count];
    NSLog(@"aaa html-->%@",arr );
        if( arr  )
        {
           // NSInteger len  = [arr count];
            NSInteger tmp = 0 ;
            BOOL isDv = FALSE;
//            BOOL isDiv = FALSE;
            //NSMutableString *faceappen = [[NSMutableString alloc] init];
            NSMutableString* faceappen = [NSMutableString string];
            for (NSString *pic in arr) 
            {
            NSLog(@"aapic = %@",pic);
                if ( [pic length] !=0 )
                {
                     
                    if(isDv)
                    {
                        [faceappen appendString:@"["];
//						pic=[pic faceTestChange];
                        [faceappen appendString:pic];
                        [faceappen appendString:@"]"];
//                        isDv = FALSE;
                    }else
                    {
                        if( tmp == 0 )
                        {
                            [faceappen appendString:pic];
                        }else
                        {
//                            if( tmp == count-1 || isDiv )
//                            {
//                                [faceappen appendString:@"["];
//                                [faceappen appendString:pic];
//                                [faceappen appendString:@"]"];
//                                isDiv = FALSE;
//                            }
//                            else
//                            {
//                               [faceappen appendString:@"["];
//								pic=[pic faceTestChange];
                                [faceappen appendString:pic];
//                                [faceappen appendString:@"]"];
//                                isDiv = TRUE;
//                            }
                        }
                    }
                     
                }else{
                    
//                    isDiv = FALSE;
                }
                
                if( tmp%2 == 0)
                {
                    isDv = TRUE;
                }else
                {
                //todo 
                isDv = FALSE;
                }
                 
                tmp = tmp + 1;
            //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, filename] error:nil];
            }
        //NSLog(@"pic->%@ ", faceappen );
             
//         html = [faceappen retain];
//         [faceappen release];
            return faceappen;
        }
        
        return html;
    }
    
        
     return html;
}

-(NSString *)stringToFace {
	NSString *face;
/*	
	if (self) {
		if ([self isEqualToString:@"微笑"]) {
			
			face=@"F01";
			
		}else if ([self isEqualToString:@"撇嘴"]) {
			
			face =@"F02";
			
		}else if ([self isEqualToString:@"色"]) {
			
			face =@"F03";
			
		}else if ([self isEqualToString:@"发呆"]) {
			
			face =@"F04";
			
		}else if ([self isEqualToString:@"得意"]) {
			
			face =@"F05";
			
		}else if ([self isEqualToString:@"流泪"]) {
			
			face =@"F06";
			
		}else if ([self isEqualToString:@"害羞"]) {
			
			face =@"F07";
			
		}else if ([self isEqualToString:@"睡觉"]) {
			
			face =@"F08";
			
		}else if ([self isEqualToString:@"尴尬"]) {
			
			face =@"F09";
			
		}else if ([self isEqualToString:@"呲牙"]) {
			
			face =@"F10";
			
		}else if ([self isEqualToString:@"惊讶"]) {
			
			face =@"F11";
			
		}else if ([self isEqualToString:@"难过"]) {
			
			face =@"F12";
			
		}else if ([self isEqualToString:@"抓狂"]) {
			
			face =@"F13";
			
		}else if ([self isEqualToString:@"偷笑"]) {
			
			face =@"F14";
			
		}else if ([self isEqualToString:@"可爱"]) {
			
			face =@"F15";
			
		}else if ([self isEqualToString:@"傲慢"]) {
			
			face =@"F16";
			
		}else if ([self isEqualToString:@"困"]) {
			
			face =@"F17";
			
		}else if ([self isEqualToString:@"流汗"]) {
			
			face =@"F18";
			
		}else if ([self isEqualToString:@"大兵"]) {
			
			face =@"F19";
			
		}else if ([self isEqualToString:@"生气"]) {
			
			face =@"F20";
			
		}else if ([self isEqualToString:@"折磨"]) {
			
			face =@"F21";
			
		}else if ([self isEqualToString:@"衰"]) {
			
			face =@"F22";
			
		}else if ([self isEqualToString:@"冷汗"]) {
			
			face =@"F23";
			
		}else if ([self isEqualToString:@"抠鼻"]) {
			
			face =@"F24";
			
		}else if ([self isEqualToString:@"鼓掌"]) {
			
			face =@"F25";
			
		}else if ([self isEqualToString:@"坏笑"]) {
			
			face =@"F26";
			
		}else if ([self isEqualToString:@"左哼哼"]) {
			
			face =@"F27";
			
		}else if ([self isEqualToString:@"右哼哼"]) {
			
			face =@"F28";
			
		}else if ([self isEqualToString:@"委屈"]) {
			
			face =@"F29";
			
		}else if ([self isEqualToString:@"F30"]) {
			
			face =@"F30";
			
		}else if ([self isEqualToString:@"阴险"]) {
			
			face =@"F31";
			
		}else if ([self isEqualToString:@"亲亲"]) {
			
			face =@"F32";
			
		}else if ([self isEqualToString:@"可怜"]) {
			
			face =@"F33";
			
        }else if ([self isEqualToString:@"足球"]) {
			
			face =@"F34";
        }else if ([self isEqualToString:@"红包"]) {
			
			face =@"F35";
        }else if ([self isEqualToString:@"红牌"]) {
			
			face =@"F36";
        }else if ([self isEqualToString:@"黄牌"]) {
			
			face =@"F37";
        }else if ([self isEqualToString:@"萌"]) {
			
			face =@"F38";
        }else if ([self isEqualToString:@"加油"]) {
			
			face =@"F39";
        }else if ([self isEqualToString:@"实习"]) {
			
			face =@"F40";
        }else if ([self isEqualToString:@"浮云"]) {
			
			face =@"F41";
        }else if ([self isEqualToString:@"神马"]) {
			
			face =@"F42";
        }else if ([self isEqualToString:@"哨子"]) {
			
			face =@"F43";
        }else if ([self isEqualToString:@"同意"]) {
			
			face =@"F44";
        }else if ([self isEqualToString:@"织"]) {
			
			face =@"F45";
        }else if ([self isEqualToString:@"好可怜"]) {
			
			face =@"F46";
        }else if ([self isEqualToString:@"围观"]) {
			
			face =@"F47";
        }else if ([self isEqualToString:@"饭饭"]) {
			
			face =@"F48";
        }else if ([self isEqualToString:@"国旗"]) {
			
			face =@"F49";
        }else if ([self isEqualToString:@"囧"]) {
			
			face =@"F50";
        }else if ([self isEqualToString:@"有钱"]) {
			
			face =@"F51";
        }else if ([self isEqualToString:@"赞"]) {
			
			face =@"F52";
        }else if ([self isEqualToString:@"示爱"]) {
			
			face =@"F53";
        }else if ([self isEqualToString:@"干杯"]) {
			
			face =@"F54";
        }else if ([self isEqualToString:@"钟"]) {
			
			face =@"F55";
        }else if ([self isEqualToString:@"玫瑰"]) {
			
			face =@"F56";
        }else if ([self isEqualToString:@"热吻"]) {
			
			face =@"F57";
        }else if ([self isEqualToString:@"拜拜"]) {
			
			face =@"F58";
        }else if ([self isEqualToString:@"鄙视"]) {
			
			face =@"F59";
        }else if ([self isEqualToString:@"钱"]) {
			
			face =@"F60";
        }else if ([self isEqualToString:@"礼物"]) {
			
			face =@"F61";
        }else if ([self isEqualToString:@"Good"]) {
			
			face =@"F62";
        }else if ([self isEqualToString:@"最差"]) {
			
			face =@"F63";
        }else if ([self isEqualToString:@"不要"]) {
			
			face =@"F64";
        }else if ([self isEqualToString:@"拳头"]) {
			
			face =@"F65";
        }else if ([self isEqualToString:@"OK"]) {
			
			face =@"F66";
        }else if ([self isEqualToString:@"弱"]) {
			
			face =@"F67";
        }else if ([self isEqualToString:@"握手"]) {
			
			face =@"F68";
        }else if ([self isEqualToString:@"耶"]) {
			
			face =@"F69";
        }else if ([self isEqualToString:@"来"]) {
			
			face =@"F70";
        }else if ([self isEqualToString:@"拍照"]) {
			
			face =@"F71";
        }else if ([self isEqualToString:@"咖啡"]) {
			
			face =@"F72";
        }
        else {
			
			return self;
		}
	}
 */
    if (self) {
		if ([self isEqualToString:@"织"]) {
			
			face=@"F45";
			
		}else if ([self isEqualToString:@"围观"]) {
			
			face =@"F47";
			
		}else if ([self isEqualToString:@"威武"]) {
			
			face =@"F79";
			
		}else if ([self isEqualToString:@"奥特曼"]) {
			
			face =@"F78";
			
		}else if ([self isEqualToString:@"以心换心"]) {
			
			face =@"F74";
			
		}else if ([self isEqualToString:@"围脖"]) {
			
			face =@"F75";
			
		}else if ([self isEqualToString:@"温暖帽子"]) {
			
			face =@"F73";
            
        }else if ([self isEqualToString:@"手套"]) {
			
			face =@"F76";

			
		}else if ([self isEqualToString:@"雪花"]) {
			
			face =@"F77";
			
		}else if ([self isEqualToString:@"雪人"]) {
			
			face =@"F80";
			
		}else if ([self isEqualToString:@"微风"]) {
			
			face =@"F81";
			
		}else if ([self isEqualToString:@"拍照"]) {
			
			face =@"F71";
			
		}else if ([self isEqualToString:@"神马"]) {
			
			face =@"F42";
			
		}else if ([self isEqualToString:@"浮云"]) {
			
			face =@"F41";
			
		}else if ([self isEqualToString:@"微笑"]) {
			
			face =@"F01";
			
		}else if ([self isEqualToString:@"呲牙"]) {
			
			face =@"F10";
			
		}else if ([self isEqualToString:@"坏笑"]) {
			
			face =@"F26";
			
		}else if ([self isEqualToString:@"折磨"]) {
			
			face =@"F21";
			
		}else if ([self isEqualToString:@"困"]) {
			
			face =@"F17";
			
		}else if ([self isEqualToString:@"流泪"]) {
			
			face =@"F06";
			
		}else if ([self isEqualToString:@"害羞"]) {
			
			face =@"F07";
			
		}else if ([self isEqualToString:@"抓狂"]) {
			
			face =@"F13";
			
		}else if ([self isEqualToString:@"冷汗"]) {
			
			face =@"F23";
			
		}else if ([self isEqualToString:@"可爱"]) {
			
			face =@"F15";
			
		}else if ([self isEqualToString:@"尴尬"]) {
			
			face =@"F09";
			
		}else if ([self isEqualToString:@"流汗"]) {
			
			face =@"F18";
			
		}else if ([self isEqualToString:@"亲亲"]) {
			
			face =@"F32";
			
		}else if ([self isEqualToString:@"难过"]) {
			
			face =@"F12";
			
		}else if ([self isEqualToString:@"钱"]) {
			
			face =@"F60";
			
		}else if ([self isEqualToString:@"偷笑"]) {
			
			face =@"F14";
			
		}else if ([self isEqualToString:@"得意"]) {
			
			face =@"F05";
			
		}else if ([self isEqualToString:@"衰"]) {
			
			face =@"F22";
			
		}else if ([self isEqualToString:@"惊讶"]) {
			
			face =@"F11";
			
		}else if ([self isEqualToString:@"生气"]) {
			
			face =@"F20";
			
        }else if ([self isEqualToString:@"鄙视"]) {
			
			face =@"F29";
        }else if ([self isEqualToString:@"抠鼻"]) {
			
			face =@"F24";
        }else if ([self isEqualToString:@"色"]) {
			
			face =@"F03";
        }else if ([self isEqualToString:@"鼓掌"]) {
			
			face =@"F25";
        }else if ([self isEqualToString:@"撇嘴"]) {
			
			face =@"F02";
        }else if ([self isEqualToString:@"发呆"]) {
			
			face =@"F04";
        }else if ([self isEqualToString:@"睡觉"]) {
			
			face =@"F08";
        }else if ([self isEqualToString:@"傲慢"]) {
			
			face =@"F16";
        }else if ([self isEqualToString:@"大兵"]) {
			
			face =@"F19";
        }else if ([self isEqualToString:@"左哼"]) {
			
			face =@"F27";
        }else if ([self isEqualToString:@"右哼"]) {
			
			face =@"F28";
        }else if ([self isEqualToString:@"委屈"]) {
			
			face =@"F30";
        }else if ([self isEqualToString:@"阴险"]) {
			
			face =@"F31";
        }else if ([self isEqualToString:@"同意"]) {
			
			face =@"F44";
        }else if ([self isEqualToString:@"可怜"]) {
			
			face =@"F33";
        }else if ([self isEqualToString:@"红包"]) {
			
			face =@"F35";
        }else if ([self isEqualToString:@"红牌"]) {
			
			face =@"F36";
        }else if ([self isEqualToString:@"黄牌"]) {
			
			face =@"F37";
        }else if ([self isEqualToString:@"握手"]) {
			
			face =@"F68";
        }else if ([self isEqualToString:@"足球"]) {
			
			face =@"F34";
        }else if ([self isEqualToString:@"加油"]) {
			
			face =@"F39";
        }else if ([self isEqualToString:@"实习"]) {
			
			face =@"F40";
        }else if ([self isEqualToString:@"好可怜"]) {
			
			face =@"F46";
        }else if ([self isEqualToString:@"饭饭"]) {
			
			face =@"F48";
        }else if ([self isEqualToString:@"国旗"]) {
			
			face =@"F49";
        }else if ([self isEqualToString:@"有有钱"]) {
			
			face =@"F51";
        }else if ([self isEqualToString:@"赞"]) {
			
			face =@"F52";
        }else if ([self isEqualToString:@"示爱"]) {
			
			face =@"F53";
        }else if ([self isEqualToString:@"干杯"]) {
			
			face =@"F54";
        }else if ([self isEqualToString:@"钟"]) {
			
			face =@"F55";
        }else if ([self isEqualToString:@"玫瑰"]) {
			
			face =@"F56";
        }else if ([self isEqualToString:@"拳头"]) {
			
			face =@"F65";
        }else if ([self isEqualToString:@"OK"]) {
			
			face =@"F66";
        }else if ([self isEqualToString:@"弱"]) {
			
			face =@"F67";
        }else if ([self isEqualToString:@"月亮"]) {
			
			face =@"F82";
        }else if ([self isEqualToString:@"耶"]) {
			
			face =@"F69";
        }else if ([self isEqualToString:@"来"]) {
			
			face =@"F70";
        }else if ([self isEqualToString:@"咖啡"]) {
			
			face =@"F72";
        }else if ([self isEqualToString:@"给力"]) {
			
			face =@"F59";
        }else if ([self isEqualToString:@"Good"]) {
			
			face =@"F62";
        }else if ([self isEqualToString:@"最差"]) {
			
			face =@"F63";
        }else if ([self isEqualToString:@"不要"]) {
			
			face =@"F64";
        }else if ([self isEqualToString:@"萌"]) {
			
			face =@"F38";
        }else if ([self isEqualToString:@"熊猫"]) {
			
			face =@"F83";
        }else if ([self isEqualToString:@"囧"]) {
			
			face =@"F50";
        }else if ([self isEqualToString:@"兔子"]) {
			
			face =@"F84";
        }else if ([self isEqualToString:@"礼物"]) {
			
			face =@"F61";
        }else if([self isEqualToString:@"哨子"]){
            
            face = @"F43";
            
        }else if([self isEqualToString:@"拜拜"]){
            
            face = @"F57";
            
        }else if([self isEqualToString:@"热吻"]){
            
            face = @"F58";
            
        }

        else {
			
			return self;
		}
	}

	return face;
}


// 表情转换 
-(NSString*)faceTestChange{
	
	NSString *face;
    if (self) {
		if ([self isEqualToString:@"F45"]) {
			
			face=@"织";
            	
			
		}else if ([self isEqualToString:@"F47"]) {
			
			face =@"围观";
            
		}else if ([self isEqualToString:@"F79"]) {
			
			face =@"威武";
            
        }else if ([self isEqualToString:@"F76"]) {
			
			face =@"手套";

			
		}else if ([self isEqualToString:@"F78"]) {
			
			face =@"奥特曼";
			
		}else if ([self isEqualToString:@"F74"]) {
			
			face =@"以心换心";
			
		}else if ([self isEqualToString:@"F75"]) {
			
			face =@"围脖";
			
		}else if ([self isEqualToString:@"F73"]) {
			
			face =@"温暖帽子";
			
		}else if ([self isEqualToString:@"F77"]) {
			
			face =@"雪花";
			
		}else if ([self isEqualToString:@"F80"]) {
			
			face =@"雪人";
			
		}else if ([self isEqualToString:@"F81"]) {
			
			face =@"微风";
			
		}else if ([self isEqualToString:@"F71"]) {
			
			face =@"拍照";
			
		}else if ([self isEqualToString:@"F42"]) {
			
			face =@"神马";
			
		}else if ([self isEqualToString:@"F41"]) {
			
			face =@"浮云";
			
		}else if ([self isEqualToString:@"F01"]) {
			
			face =@"微笑";
			
		}else if ([self isEqualToString:@"F10"]) {
			
			face =@"呲牙";
			
		}else if ([self isEqualToString:@"F26"]) {
			
			face =@"坏笑";
			
		}else if ([self isEqualToString:@"F21"]) {
			
			face =@"折磨";
			
		}else if ([self isEqualToString:@"F17"]) {
			
			face =@"困";
			
		}else if ([self isEqualToString:@"F06"]) {
			
			face =@"流泪";
			
		}else if ([self isEqualToString:@"F07"]) {
			
			face =@"害羞";
			
		}else if ([self isEqualToString:@"F13"]) {
			
			face =@"抓狂";
			
		}else if ([self isEqualToString:@"F23"]) {
			
			face =@"冷汗";
			
		}else if ([self isEqualToString:@"F15"]) {
			
			face =@"可爱";
			
		}else if ([self isEqualToString:@"F09"]) {
			
			face =@"尴尬";
			
		}else if ([self isEqualToString:@"F18"]) {
			
			face =@"流汗";
			
		}else if ([self isEqualToString:@"F32"]) {
			
			face =@"亲亲";
			
		}else if ([self isEqualToString:@"F12"]) {
			
			face =@"难过";
			
		}else if ([self isEqualToString:@"F60"]) {
			
			face =@"钱";
			
		}else if ([self isEqualToString:@"F14"]) {
			
			face =@"偷笑";
			
		}else if ([self isEqualToString:@"F05"]) {
			
			face =@"得意";
			
		}else if ([self isEqualToString:@"F22"]) {
			
			face =@"衰";
			
		}else if ([self isEqualToString:@"F11"]) {
			
			face =@"惊讶";
			
		}else if ([self isEqualToString:@"F20"]) {
			
			face =@"生气";
			
        }else if ([self isEqualToString:@"F29"]) {
			
			face =@"鄙视";
        }else if ([self isEqualToString:@"F24"]) {
			
			face =@"抠鼻";
        }else if ([self isEqualToString:@"F03"]) {
			
			face =@"色";
        }else if ([self isEqualToString:@"F25"]) {
			
			face =@"鼓掌";
        }else if ([self isEqualToString:@"F02"]) {
			
			face =@"撇嘴";
        }else if ([self isEqualToString:@"F04"]) {
			
			face =@"发呆";
        }else if ([self isEqualToString:@"F08"]) {
			
			face =@"困";
        }else if ([self isEqualToString:@"F16"]) {
			
			face =@"傲慢";
        }else if ([self isEqualToString:@"F19"]) {
			
			face =@"大兵";
        }else if ([self isEqualToString:@"F27"]) {
			
			face =@"左哼";
        }else if ([self isEqualToString:@"F28"]) {
			
			face =@"右哼";
        }else if ([self isEqualToString:@"F30"]) {
			
			face =@"委屈";
        }else if ([self isEqualToString:@"F31"]) {
			
			face =@"阴险";
        }else if ([self isEqualToString:@"F44"]) {
			
			face =@"同意";
        }else if ([self isEqualToString:@"F33"]) {
			
			face =@"可怜";
        }else if ([self isEqualToString:@"F35"]) {
			
			face =@"红包";
        }else if ([self isEqualToString:@"F36"]) {
			
			face =@"红牌";
        }else if ([self isEqualToString:@"F37"]) {
			
			face =@"黄牌";
        }else if ([self isEqualToString:@"F68"]) {
			
			face =@"握手";
        }else if ([self isEqualToString:@"F34"]) {
			
			face =@"足球";
        }else if ([self isEqualToString:@"F39"]) {
			
			face =@"加油";
        }else if ([self isEqualToString:@"F40"]) {
			
			face =@"实习";
        }else if ([self isEqualToString:@"F46"]) {
			
			face =@"好可怜";
        }else if ([self isEqualToString:@"F48"]) {
			
			face =@"饭饭";
        }else if ([self isEqualToString:@"F49"]) {
			
			face =@"国旗";
        }else if ([self isEqualToString:@"F51"]) {
			
			face =@"有有钱";
        }else if ([self isEqualToString:@"F52"]) {
			
			face =@"赞";
        }else if ([self isEqualToString:@"F53"]) {
			
			face =@"示爱";
        }else if ([self isEqualToString:@"F54"]) {
			
			face =@"干杯";
        }else if ([self isEqualToString:@"F55"]) {
			
			face =@"钟";
        }else if ([self isEqualToString:@"F56"]) {
			
			face =@"玫瑰";
        }else if ([self isEqualToString:@"F65"]) {
			
			face =@"拳头";
        }else if ([self isEqualToString:@"F66"]) {
			
			face =@"OK";
        }else if ([self isEqualToString:@"F67"]) {
			
			face =@"弱";
        }else if ([self isEqualToString:@"F82"]) {
			
			face =@"月亮";
        }else if ([self isEqualToString:@"F69"]) {
			
			face =@"耶";
        }else if ([self isEqualToString:@"F70"]) {
			
			face =@"来";
        }else if ([self isEqualToString:@"F72"]) {
			
			face =@"咖啡";
        }else if ([self isEqualToString:@"F59"]) {
			
			face =@"给力";
        }else if ([self isEqualToString:@"F62"]) {
			
			face =@"Good";
        }else if ([self isEqualToString:@"F63"]) {
			
			face =@"最差";
        }else if ([self isEqualToString:@"F64"]) {
			
			face =@"不要";
        }else if ([self isEqualToString:@"F38"]) {
			
			face =@"萌";
        }else if ([self isEqualToString:@"F83"]) {
			
			face =@"熊猫";
        }else if ([self isEqualToString:@"F50"]) {
			
			face =@"囧";
        }else if ([self isEqualToString:@"F84"]) {
			
			face =@"兔子";
        }else if ([self isEqualToString:@"F61"]) {
			
			face =@"礼物";
        }else if([self isEqualToString:@"F43"]){
            face = @"哨子";
        }else if([self isEqualToString:@"F57"]){
            face = @"拜拜";
        }else if([self isEqualToString:@"F58"]){
            face = @"热吻";
        }
        else {
			
			return self;
		}
	}
	/*
	if (self) {
		if ([self isEqualToString:@"F01"]) {
			
			face=@"织";

			
		}else if ([self isEqualToString:@"F02"]) {
			
			face =@"撇嘴";
		
		}else if ([self isEqualToString:@"F03"]) {
			
			face =@"色";
			
		}else if ([self isEqualToString:@"F04"]) {
			
			face =@"发呆";
			
		}else if ([self isEqualToString:@"F05"]) {
			
			face =@"得意";
			
		}else if ([self isEqualToString:@"F06"]) {
			
			face =@"流泪";
			
		}else if ([self isEqualToString:@"F07"]) {
			
			face =@"害羞";
			
		}else if ([self isEqualToString:@"F08"]) {
			
			face =@"睡觉";
			
		}else if ([self isEqualToString:@"F09"]) {
			
			face =@"尴尬";
			
		}else if ([self isEqualToString:@"F10"]) {
			
			face =@"呲牙";
			
		}else if ([self isEqualToString:@"F11"]) {
			
			face =@"惊讶";
			
		}else if ([self isEqualToString:@"F12"]) {
			
			face =@"难过";
			
		}else if ([self isEqualToString:@"F13"]) {
			
			face =@"抓狂";
			
		}else if ([self isEqualToString:@"F14"]) {
			
			face =@"偷笑";
			
		}else if ([self isEqualToString:@"F15"]) {
			
			face =@"可爱";
			
		}else if ([self isEqualToString:@"F16"]) {
			
			face =@"傲慢";
			
		}else if ([self isEqualToString:@"F17"]) {
			
			face =@"困";
			
		}else if ([self isEqualToString:@"F18"]) {
			
			face =@"流汗";
			
		}else if ([self isEqualToString:@"F19"]) {
			
			face =@"大兵";
			
		}else if ([self isEqualToString:@"F20"]) {
			
			face =@"生气";
			
		}else if ([self isEqualToString:@"F21"]) {
			
			face =@"折磨";
			
		}else if ([self isEqualToString:@"F22"]) {
			
			face =@"衰";
			
		}else if ([self isEqualToString:@"F23"]) {
			
			face =@"冷汗";
			
		}else if ([self isEqualToString:@"F24"]) {
			
			face =@"抠鼻";
			
		}else if ([self isEqualToString:@"F25"]) {
			
			face =@"鼓掌";
			
		}else if ([self isEqualToString:@"F26"]) {
			
			face =@"坏笑";
			
		}else if ([self isEqualToString:@"F27"]) {
			
			face =@"左哼哼";
			
		}else if ([self isEqualToString:@"F28"]) {
			
			face =@"右哼哼";
			
		}else if ([self isEqualToString:@"F29"]) {
			
			face =@"鄙视";
			
		}else if ([self isEqualToString:@"F30"]) {
			
			face =@"委屈";
			
		}else if ([self isEqualToString:@"F31"]) {
			
			face =@"阴险";
			
		}else if ([self isEqualToString:@"F32"]) {
			
			face =@"亲亲";
			
		}else if ([self isEqualToString:@"F33"]) {
			
			face =@"可怜";
			
        }else if ([self isEqualToString:@"F34"]) {
			
			face =@"足球";
        }else if ([self isEqualToString:@"F35"]) {
			
			face =@"红包";
        }else if ([self isEqualToString:@"F36"]) {
			
			face =@"红牌";
        }else if ([self isEqualToString:@"F37"]) {
			
			face =@"黄牌";
        }else if ([self isEqualToString:@"F38"]) {
			
			face =@"萌";
        }else if ([self isEqualToString:@"F39"]) {
			
			face =@"加油";
        }else if ([self isEqualToString:@"F40"]) {
			
			face =@"实习";
        }else if ([self isEqualToString:@"F41"]) {
			
			face =@"浮云";
        }else if ([self isEqualToString:@"F42"]) {
			
			face =@"神马";
        }else if ([self isEqualToString:@"F43"]) {
			
			face =@"哨子";
        }else if ([self isEqualToString:@"F44"]) {
			
			face =@"同意";
        }else if ([self isEqualToString:@"F45"]) {
			
			face =@"织";
        }else if ([self isEqualToString:@"F46"]) {
			
			face =@"好可怜";
        }else if ([self isEqualToString:@"F47"]) {
			
			face =@"围观";
        }else if ([self isEqualToString:@"F48"]) {
			
			face =@"饭饭";
        }else if ([self isEqualToString:@"F49"]) {
			
			face =@"国旗";
        }else if ([self isEqualToString:@"F50"]) {
			
			face =@"囧";
        }else if ([self isEqualToString:@"F51"]) {
			
			face =@"有钱";
        }else if ([self isEqualToString:@"F52"]) {
			
			face =@"赞";
        }else if ([self isEqualToString:@"F53"]) {
			
			face =@"示爱";
        }else if ([self isEqualToString:@"F54"]) {
			
			face =@"干杯";
        }else if ([self isEqualToString:@"F55"]) {
			
			face =@"钟";
        }else if ([self isEqualToString:@"F56"]) {
			
			face =@"玫瑰";
        }else if ([self isEqualToString:@"F57"]) {
			
			face =@"热吻";
        }else if ([self isEqualToString:@"F58"]) {
			
			face =@"拜拜";
        }else if ([self isEqualToString:@"F59"]) {
			
			face =@"鄙视";
        }else if ([self isEqualToString:@"F60"]) {
			
			face =@"钱";
        }else if ([self isEqualToString:@"F61"]) {
			
			face =@"礼物";
        }else if ([self isEqualToString:@"F62"]) {
			
			face =@"Good";
        }else if ([self isEqualToString:@"F63"]) {
			
			face =@"最差";
        }else if ([self isEqualToString:@"F64"]) {
			
			face =@"不要";
        }else if ([self isEqualToString:@"F65"]) {
			
			face =@"拳头";
        }else if ([self isEqualToString:@"F66"]) {
			
			face =@"OK";
        }else if ([self isEqualToString:@"F67"]) {
			
			face =@"弱";
        }else if ([self isEqualToString:@"F68"]) {
			
			face =@"握手";
        }else if ([self isEqualToString:@"F69"]) {
			
			face =@"耶";
        }else if ([self isEqualToString:@"F70"]) {
			
			face =@"来";
        }else if ([self isEqualToString:@"F71"]) {
			
			face =@"拍照";
        }else if ([self isEqualToString:@"F72"]) {
			
			face =@"咖啡";
        }
        else {
			
			return self;
		}
	}
     */
    
    
    
    
	return face;
}


// 判断是否 是 用户本人
- (BOOL)isUserself
{	
	return [self isEqualToString:[[Info getInstance]userId]];
}

- (NSString *)lotteryIdChange {
	if ([self isEqualToString:@"22"]) {
		return @"竞彩胜平负";
	}
    else if ([self isEqualToString:@"49"]){
        return @"竞彩让球胜平负";
    }
	else if ([self isEqualToString:@"23"]) {
		return @"竞彩比分";
		
	}
	else if ([self isEqualToString:@"24"]) {
		return @"竞彩总进球数";
	}
	else if ([self isEqualToString:@"25"]) {
		return @"竞彩半全场胜平负";
	}
	
	else if ([self isEqualToString:@"200"]) {
		return @"单场胜平负";
	}
	else if ([self isEqualToString:@"210"]) {
		return @"单场上下盘单双";
	}
	else if ([self isEqualToString:@"230"]){
		return @"单场总进球数";
	}
	else if ([self isEqualToString:@"240"]){
		return @"单场半全场胜平负";
	}
	else if ([self isEqualToString:@"250"]){
		return @"单场比分";
	}
	
	else if([self isEqualToString:@"13"]) {
		return @"足彩14场胜负彩";
	}
	else if([self isEqualToString:@"14"]) {
		return @"足彩胜负彩任9场";
	}
	else if([self isEqualToString:@"15"]) {
		return @"足彩六场半全场";
	}
    else if([self isEqualToString:@"16"]) {
		return @"足彩四场进球";
	}
	else if([self isEqualToString:@"29"]) {
		return @"竞彩篮球大小分";
	}
    else if([self isEqualToString:@"27"]) {
		return @"竞彩篮球让分胜负";
	}
    else if([self isEqualToString:@"26"]) {
		return @"竞彩篮球胜负";
	}
    else if([self isEqualToString:@"28"]) {
		return @"竞彩篮球胜分差";
	}

	return self;
}

// 如果是用户本人 则nickname改成“我”
- (NSString*)nickName:(NSString*)userID
{
	NSString *nickname;	
	if ([userID isUserself]) 
    {
		nickname = @"我";
	}
    else 
    {
		nickname = self;
	}
	return nickname;
}


//GC_
/**
 * 以splitchar符号分割字符串txt
 * 
 * @param txt
 * @param splitchar
 * @return vector
 */

- (NSMutableArray*)SplitStringByChar:(NSString *)splitchar
{
    NSMutableArray *v = [[NSMutableArray alloc] init];
    while (self != nil && [self length] > 0) {
        NSRange range = [self rangeOfString:splitchar];
        if ((range.location == 0 || range.location > 0) && range.location <= [self length]) {
            NSString *str = [self substringWithRange:NSMakeRange(0, range.location)];
            [v addObject:str];
            self = [self substringFromIndex:(range.location + range.length)];
        } else {
            break;
        }
    }
    if (self != nil && [self length] > 0) {
        [v addObject:self];
    }
    return [v autorelease];
}

- (NSString *)concat:(NSString *)obj1 obj2:(NSInteger)obj2
{
    NSMutableString *mStr = [NSMutableString stringWithString:self];
    [mStr appendString:obj1];
    [mStr appendString:[NSString stringWithFormat:@"%li", (long)obj2]];
    return mStr;
}

//MD5加密
- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (unsigned int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
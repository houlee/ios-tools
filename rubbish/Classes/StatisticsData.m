//
//  StatisticsData.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "StatisticsData.h"
#import <CoreText/CoreText.h>
@implementation StatisticsData

@synthesize use;
@synthesize money;
@synthesize number;
@synthesize right;
@synthesize fieldNum;
@synthesize allNum;
@synthesize image;
@synthesize time;
@synthesize timeNum;
@synthesize rightField;
@synthesize orderId;
@synthesize userID;
@synthesize timestr;
@synthesize attributedText;


-(void)parserSendText:(NSString *)text withAry:(NSMutableArray *)mary
{
    NSRange rangeLeft = [text rangeOfString:@"<em>"];
    NSRange rangeRight = [text rangeOfString:@"</em>"];
    //  if([text hasPrefix:@"["]&&[text hasPrefix:@"]"]) //判断是否为一个完整的表情
	if (rangeLeft.location != NSNotFound&&rangeRight.location != NSNotFound) 
        {
        if (rangeLeft.location > 0) // 说明文字在先           
            {
            NSString *temStr = [text substringToIndex:rangeLeft.location]; //截取文本
            [mary addObject:temStr];//添加文本
			temStr = [[text substringFromIndex:rangeLeft.location] substringToIndex:rangeRight.location -rangeLeft.location+5];
            // temStr = [text substringWithRange:NSMakeRange(rangeLeft.location, (rangeRight.location - rangeLeft.location +1))];// 截取表情
            if ([temStr length]>1) {
                NSRange left2 = [[temStr substringFromIndex:4] rangeOfString:@"<em>"];
                if (left2.location == NSNotFound) {
                    [mary addObject:temStr]; //添加表情
                    NSString *newString = [text substringFromIndex:rangeLeft.location + (rangeRight.location - rangeLeft.location +5 )];  // 获得新的字符串
                    [self parserSendText:newString withAry:mary];
                }
                else {
                    [self parserSendText:temStr withAry:mary];
                }
            }
            else {
                [mary addObject:temStr];
            }
            
            }
        else
            {
            NSString *temStr = [text substringWithRange:NSMakeRange(rangeLeft.location, (rangeRight.location - rangeLeft.location +5))]; // 截取表情
			if ([temStr length]>2) {
				NSRange left2 = [[temStr substringFromIndex:4] rangeOfString:@"<em>"];
				if (left2.location !=NSNotFound) {
					//NSString *temStr = [text substringToIndex:left2.location];
					[mary addObject:@"<em>"];
					temStr = [text substringFromIndex:4];
					[self parserSendText:temStr withAry:mary];
				}
				else if (![temStr isEqualToString:@""])
                    {
					//NSLog(@"temStr ------>%@",temStr);
					[mary addObject:temStr];
					temStr = [text substringFromIndex:rangeLeft.location + (rangeRight.location - rangeLeft.location +5)]; // 获得新的字符串
					//NSLog(@"newString ---->>>%@",temStr);
					[self parserSendText:temStr withAry:mary];
                    }
				else
                    {
					return;
                    }
			}
			else {
				[mary addObject:temStr];
				temStr = [text substringFromIndex:rangeRight.location+5]; // 获得新的字符串
				[self parserSendText:temStr withAry:mary];
				return;
			}
            
			
            }
        
        }
    else //  在字符串中，没发现有表情符号
        {
        if (![text isEqualToString:@""])
            [mary addObject:text];
        }
    
}

-(id)initWithDuc:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.money = [dic objectForKey:@"awardMoney"];
        self.number = [dic objectForKey:@"betCount"];
        self.allNum = [NSString stringWithFormat:@" %@",[[[dic objectForKey:@"betNumber"] stringByReplacingOccurrencesOfString:@"<em>" withString:@"<"] stringByReplacingOccurrencesOfString:@"</em>" withString:@">"]];
        NSLog(@"all num = %@", self.allNum);
    //    self.time = [dic objectForKey:@"betTime"];
        self.use = [dic objectForKey:@"nickName"];
        self.orderId = [dic objectForKey:@"orderId"];
        self.right = [dic objectForKey:@"rightBetCount"];
        self.rightField = [dic objectForKey:@"rightMatchCount"];
        self.userID = [dic objectForKey:@"userId"];
        self.timestr = [dic objectForKey:@"betTime"];
        self.timeNum = [dic objectForKey:@"issue"];
        NSArray * array = [self.timestr componentsSeparatedByString:@" "];
        NSString * str1 = @"";
        if ([array count]>=1) {
            str1 = [array objectAtIndex:0];
        }
        
        NSArray * arraydata = [str1 componentsSeparatedByString:@"-"];
        NSString * str2 = @"";
        NSString * str3 = @"";
        if ([arraydata count] >= 3) {
            str2 = [arraydata objectAtIndex:1];
            str3 = [arraydata objectAtIndex:2];
        }
       
        NSString * str7 = [NSString stringWithFormat:@"%@-%@", str2, str3];
        
        
        NSString * str4 = [array objectAtIndex:1];
        NSArray * arraystr = [str4 componentsSeparatedByString:@":"];
        NSString * str5 = @"";
        NSString * str6 = @"";
        if ([arraystr count] >= 2) {
            str5 = [arraystr objectAtIndex:0];
            str6 = [arraystr objectAtIndex:1];
        }
       
        NSString * str8 = [NSString stringWithFormat:@"%@:%@", str5, str6];
        
        self.time = [NSString stringWithFormat:@"%@ %@", str7, str8];
        
        
//        NSString *st = [[self.allNum stringByReplacingOccurrencesOfString:@"<em>" withString:@""] stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
//        attributedText = [[NSMutableAttributedString alloc] initWithString:st];
//        NSMutableArray *arrayaa = [[NSMutableArray alloc] init];
//        [self parserSendText:self.allNum withAry:arrayaa];
//        NSMutableArray *array2 =[[NSMutableArray alloc] init];
//        if ([arrayaa count] > 0 && [[arrayaa objectAtIndex:0] hasPrefix:@"<em>"]) {
//            for (int i = 0; i<[arrayaa count]; i++) {
//                
//                NSLog(@"arrayaa = %@", [arrayaa objectAtIndex:i]);
//                
//                if (i == 0) {
//                    [array2 addObject:[NSString stringWithFormat:@"0"]];
//					if ([[array2 objectAtIndex:i] intValue] +1 <[attributedText length]) {
//						[attributedText addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor redColor]CGColor] range:NSMakeRange([[array2 objectAtIndex:i] intValue],1)];
//					}
//                }
//                else {
//                    if (![[arrayaa objectAtIndex:i] hasPrefix:@"<em>"]) {
//                        [array2 addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:i-1]intValue]+[[arrayaa objectAtIndex:i] length]]];
//						if ([[array2 objectAtIndex:i] intValue] +1 <[attributedText length]) {
//							[attributedText addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor redColor]CGColor] range:NSMakeRange([[array2 objectAtIndex:i] intValue],1)];
//						}
//                    }
//                    else {
//                        [array2 addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:i-1]intValue]+1]];
//                    }
//                    
//                }
//            }
//        }
//        else{
//            for (int i = 0; i<[arrayaa count]; i++) {
//                if ([array2 count] == 0) {
//                    [array2 addObject:[NSString stringWithFormat:@"%d",[[arrayaa objectAtIndex:i] length]]];
//					if ([[array2 objectAtIndex:i] intValue] +1 <[attributedText length]) {
//						[attributedText addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor redColor]CGColor] range:NSMakeRange([[array2 objectAtIndex:i] intValue],1)];
//					}
//                }
//                else {
//                    if (![[arrayaa objectAtIndex:i] hasPrefix:@"<em>"]) {
//                        [array2 addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:i-1]intValue]+[[arrayaa objectAtIndex:i] length]]];
//						if ([[array2 objectAtIndex:i] intValue]  <[attributedText length]) {
//							[attributedText addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[[UIColor redColor]CGColor] range:NSMakeRange([[array2 objectAtIndex:i] intValue],1)];
//						}
//                    }
//                    else {
//                        [array2 addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:i-1]intValue]+1]];
//                        NSLog(@"%d", [[array2 objectAtIndex:i-1]intValue]+1);
//                    }
//                }
//            }
//        }
//		[array2 release];
//		[arrayaa release];
        
    }
    return self;
}



- (void)dealloc{
    
    [attributedText release];
    [timestr release];
    [userID release];
    [orderId release];
    [rightField release];
    [timeNum release];
    [time release];
    [use release];
    [money release];
    [number release];
    [right release];
    [fieldNum release];
    [allNum release];
    [image release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
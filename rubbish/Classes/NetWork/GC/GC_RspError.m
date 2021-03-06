//
//  RspError.m
//  Lottery
//
//  Created by Kiefer on 11-12-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GC_RspError.h"
#import "GC_AlertViewCenter.h"
#import "GC_UserInfo.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "GC_HttpService.h"

@implementation GC_RspError

+ (BOOL)parserError:(GC_DataReadStream *)_drs returnId:(NSInteger)_returnId WithRequest:request
{
    if (_returnId == 3000) {
		NSString *systemTime = [_drs readComposString1];
        int errorCode = [_drs readByte];
        NSString *errorDetail = [_drs readComposString1];
        if (systemTime) {
            NSLog(@"systemTime%@错误代码%d 描述%@",systemTime,errorCode,errorDetail);
        }
		
        /******
        1.用户未登录
        2.sign校验失败
        3.未有数据返回(保留)
        4.参数错误：这里写上具体的参数和错误
        100.其他异常
        ******/
        if (errorCode == 1) {
            Info *info = [Info getInstance];
            if (![[Info getInstance] requestArray]) {
                NSMutableArray *array = [NSMutableArray array];
                info.requestArray = array;
            }
            if (request && [[info userId] intValue] != 0) {
                ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                request2.url = [request url];
                [request2 setRequestMethod:[request requestMethod]];
                [request2 addCommHeaders];
                [request2 setPostBody:[request postBody]];
                [request2 setDefaultResponseEncoding:NSUTF8StringEncoding];
                [request2 setDelegate:[request delegate]];
                [request2 setShouldContinueWhenAppEntersBackground:YES];
                [request2 setDidFinishSelector:[request didFinishSelector]];
                [request2 setDidFailSelector:[request didFailSelector]];
                [request2 setUserInfo:[request userInfo]];
                [info.requestArray addObject:request2];
            }
            
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai LogInBySelfWithIncreace];
            
            
            //[[GC_UserInfo sharedInstance] showNotloginAlertView];
        } else if (errorCode == 2) {
            [GC_AlertViewCenter alertViewWithTitle:nil message:@"无记录返回！" cancelButtonTitle:@"确定"];
        } else if (errorCode == 3) {
            [GC_AlertViewCenter alertViewWithTitle:nil message:@"暂无数据！" cancelButtonTitle:@"确定"];
        } else if (errorCode == 100) {
            [GC_AlertViewCenter alertViewWithTitle:nil message:errorDetail cancelButtonTitle:@"确定"];
        }
		else if(errorCode == 19) {
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai LogInBySelfWithIncreace];
		}
        else if (errorCode == 200) {
            [GC_AlertViewCenter alertViewWithTitle:nil message:@"获取详情失败" cancelButtonTitle:@"确定"];
        }

		else {
//			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//			[cai LogInBySelf];
		}

        return YES;
    }
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
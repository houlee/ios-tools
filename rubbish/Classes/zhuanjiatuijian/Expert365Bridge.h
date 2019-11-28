//
//  Expert365Bridge.h
//  caibo
//
//  Created by GongHe on 15/11/25.
//
//

#import <Foundation/Foundation.h>

@interface Expert365Bridge : NSObject

//跳充值
-(void)toRechargeFromController:(UIViewController *)controller;
//跳提现
-(void)toWithdrawalFromController:(UIViewController *)controller;
//数字彩投注
-(void)betShuZiFromController:(UIViewController *)controller lotteryID:(NSString *)lotteryID;
//竞彩投注
-(void)betJingCaiFromController:(UIViewController *)controller competeGoBetDic:(NSDictionary *)competeGoBetDic;
//验证是否实名
-(BOOL)validateRealNameFormController:(UIViewController *)controller;
//去登录
-(void)toLoginFormController:(UIViewController *)controller;
//气泡
-(void)showMessage:(NSString *)message;

//懂个球验证实名
- (BOOL)goWanshanXinxi:(UIViewController *)controller;

@end

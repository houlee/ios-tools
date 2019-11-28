//
//  InsertView.h
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LotteryDetail;

@interface InsertView : NSObject {
	
}

//初始化标签
+ (UILabel *)initLableWithFrame:(CGRect)rect fontSize:(NSInteger)size;

//返回开奖号码单个图片
+ (UIImageView *)numViewWithStr:(NSString *)str type:(NSString *)typeStr;

//返回开奖号码视图
+ (UIImageView *)numViewWithLottery:(NSString *)lotteryNumber;

//设置开奖详情顶部视图
+ (UIImageView *)insertLottery:(NSString *)lotteryName issue:(NSString *)issue;

//设置开奖详情号码、时间、销量、滚存等视图
+ (UIImageView *)insertdate:(LotteryDetail *)detail;

//设置开奖详情奖项视图
+ (UIImageView *)insertAwards:(NSArray *)array;

//添加本期对阵表标签
+ (UIImageView *)insertAgainstName:(NSString *)againstName;

//设置本期对阵表视图
+ (UIImageView *)insertAgainstNamesList:(NSArray *)againstNamesList againstList:(NSArray *)reAgainstList;

@end

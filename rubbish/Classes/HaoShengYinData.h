//
//  HaoShengYinData.h
//  caibo
//
//  Created by houchenguang on 13-1-17.
//
//

#import <Foundation/Foundation.h>

@interface HaoShengYinData : NSObject{

    NSString * headImage;//头像的url
    NSString * zhanji;//战绩
    NSString * nickName;//呢称
    NSString * userName;//用户名
    NSString * zan;//赞
    NSString * time;//声音的长度
    NSString * ordered;//方案号
    NSString * changeTime;//最后修改时间
    NSString * bonus;//奖励奖金
    NSString * lotteryid; // 彩钟id
    NSString * issue; //期数 竞彩返回为空
    NSString * iszan; // 0表示 没赞过 1表示赞过
    NSString * voiceid;//声音id
}
@property (nonatomic, retain)NSString * headImage, * zhanji, * nickName, * userName, * zan, *time, * ordered, * changeTime, * bonus, * iszan, * lotteryid, * issue, *voiceid;
@end

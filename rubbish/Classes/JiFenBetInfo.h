//
//  JiFenBetInfo.h
//  caibo
//
//  Created by GongHe on 15-3-12.
//
//

#import <Foundation/Foundation.h>

@interface JiFenBetInfo : NSObject
{
    NSString * caiZhong;//彩种
    NSString * wanFa;//玩法
    NSString * touZhu;//投注方式
    NSString * guoGuan;//过关方式
    NSString * beiShu;//倍数
    NSString * payJiFen;//投注积分
    NSString * betNumber;//投注内容
    NSString * peiLv;//赔率
    NSString * issue;//期次
}

@property (nonatomic, retain)NSString * caiZhong;
@property (nonatomic, retain)NSString * wanFa;
@property (nonatomic, retain)NSString * touZhu;
@property (nonatomic, retain)NSString * guoGuan;
@property (nonatomic, retain)NSString * beiShu;
@property (nonatomic, retain)NSString * payJiFen;
@property (nonatomic, retain)NSString * betNumber;
@property (nonatomic, retain)NSString * peiLv;
@property (nonatomic, retain)NSString * issue;

@end

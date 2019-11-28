//
//  YiLouChartData.h
//  CPgaopin
//
//  Created by GongHe on 14-2-13.
//
//

#import <Foundation/Foundation.h>

@interface YiLouChartData : NSObject
{
//    NSArray * k3YiLouArray;
    NSArray * lotteryNumArr;
    NSString * issueNumber;
    NSString * andValues;
    NSString * sameNumber;
    NSArray * andValuesArr;
    NSString * lotteryNumber;
    NSArray * k3ErBuTongArr;
    NSArray * k3ErTongArr;
    NSArray * k3SanLianArr;
    NSArray * k3SanTongArr;
    NSArray * k3SanBuTongArr;
    
    NSArray * n115YiLouArray;
    NSArray * daXiaoArray;
    NSArray * jiOuArray;
    NSArray * zhiHeArray;
    NSString * qianLotteryNumber;
    NSArray * qianLotteryNumArr;
    NSArray * n115QianOneArr;
    NSArray * n115QianTwoArr;
    NSArray * n115QianThreeArr;
    
    NSMutableArray * dataArray;//数据遗漏
    NSString * redSame;
    NSMutableArray * redYiLou;
    NSString * blueSame;
    NSMutableArray * blueYiLou;

    NSArray * threeDOneArr;//3d百位遗漏
    NSArray * threeDTwoArr;//3d十位遗漏
    NSArray * threeDThreeArr;//3d个位遗漏
    NSArray * threeDBasicArr;//3d基本遗漏
    NSMutableArray * threeDTypeArr;//3d重号类型
    NSMutableArray * threeDDaXiaoJiOuArray;//3d大小比奇偶比

    NSMutableArray * happyYiLouArray;
}

//@property(nonatomic,retain)NSArray * k3YiLouArray;//快三遗漏值
@property(nonatomic,retain)NSArray * lotteryNumArr;//开奖号码数组
@property(nonatomic,retain)NSString * issueNumber;//期次
@property(nonatomic,retain)NSString * andValues;//和值
@property(nonatomic,retain)NSString * sameNumber;//相同个数
@property(nonatomic,retain)NSArray * andValuesArr;//和值数组
@property(nonatomic,retain)NSString * lotteryNumber;//开奖号码

@property(nonatomic,retain)NSArray * k3ErBuTongArr;//快三二不同遗漏值
@property(nonatomic,retain)NSArray * k3ErTongArr;//快三二同遗漏值
@property(nonatomic,retain)NSArray * k3SanLianArr;//快三三连号遗漏值
@property(nonatomic,retain)NSArray * k3SanTongArr;//快三三同号遗漏值
@property(nonatomic,retain)NSArray * k3SanBuTongArr;//快三三不同号遗漏值

@property(nonatomic,retain)NSArray * n115YiLouArray;//十一选五遗漏值
@property(nonatomic,retain)NSArray * daXiaoArray;//大小比遗漏
@property(nonatomic,retain)NSArray * jiOuArray;//奇偶比遗漏
@property(nonatomic,retain)NSArray * zhiHeArray;//质合比遗漏
@property(nonatomic,retain)NSString * qianLotteryNumber;//前三位开奖号码
@property(nonatomic,retain)NSArray * qianLotteryNumArr;//前三位开奖号码数组
@property(nonatomic,retain)NSArray * n115QianOneArr;//前三定位第一位遗漏
@property(nonatomic,retain)NSArray * n115QianTwoArr;//前三定位第二位遗漏
@property(nonatomic,retain)NSArray * n115QianThreeArr;//前三定位第三位遗漏

@property (nonatomic, retain)NSMutableArray * dataArray;//双色球 大乐透 数据
@property(nonatomic,retain)NSString * redSame;//双色球 大乐透 红球相同号码
@property (nonatomic, retain)NSMutableArray * redYiLou;//双色球 大乐透 红球遗漏
@property(nonatomic,retain)NSString * blueSame;//双色球 大乐透 蓝球相同号码
@property (nonatomic, retain)NSMutableArray * blueYiLou;//双色球 大乐透 蓝球遗漏

@property(nonatomic,retain)NSArray * threeDOneArr;//3d百位遗漏
@property(nonatomic,retain)NSArray * threeDTwoArr;//3d十位遗漏
@property(nonatomic,retain)NSArray * threeDThreeArr;//3d个位遗漏
@property(nonatomic,retain)NSArray * threeDBasicArr;//3d基本遗漏
@property(nonatomic,retain)NSMutableArray * threeDTypeArr;//3d重号类型
@property (nonatomic, retain)NSMutableArray * threeDDaXiaoJiOuArray;//3d大小比奇偶比

@property(nonatomic,retain)NSMutableArray * happyYiLouArray;//快乐十分基本遗漏

- (id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWith3DDictionary:(NSDictionary *)dictionary;//3d调用方法
- (id)initWithN115Dictionary:(NSDictionary *)dictionary;//11选5
- (id)initWithHappyDictionary:(NSDictionary *)dictionary;//快乐十分
- (id)initWithKuaiSanDictionary:(NSDictionary *)dictionary;//快三


@end

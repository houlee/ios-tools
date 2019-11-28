//
//  RechargeSequenceData.h
//  caibo
//
//  Created by GongHe on 13-10-25.
//
//

#import <Foundation/Foundation.h>

@interface RechargeSequenceData : NSObject
{
    int ID;
    NSString *time,* sequence,* description;//系统时间，状态值，状态描述
    NSString * changeContent;//改变的内容
    NSString * kaigguan;
    NSString * changeContent2;//改变内容2
    NSString * methodYHM; //使用优惠码的充值方式
    NSString * H5Type;//H5跳转充值代码
    NSMutableArray *chongzhiTypeList;//充值列表信息
}

@property(nonatomic,assign)int ID;
@property(nonatomic,retain)NSString *time,* sequence,*description;
@property(nonatomic,retain)NSString * changeContent,*changeContent2, *kaigguan,*methodYHM,*H5Type;
@property(nonatomic,retain)NSMutableArray *chongzhiTypeList;

- (id)initWithResponseData:(NSData *)responseData;

@end


@interface RechargeTypeData : NSObject
{
//    1	充值code
//    2	充值logo
//    3	充值名称
//    4	充值活动内容
//    5	免手续费内容
//    6	是否使用优惠码
//    7	是否跳转wap
    
}
@property (nonatomic, copy)NSString *code,* logourl, * name, * huodong, * feeInfo,*Youhuima,*wapurl, * other1, * other2;
@end

//
//  HongBaoInfo.h
//  caibo
//
//  Created by cp365dev on 15/2/2.
//
//

#import <Foundation/Foundation.h>

@interface HongBaoInfo : NSObject
{
    NSString *type;     //红包类型
    NSString *showType; //展示方式 1文本 2红包
    NSString *awardInfo;//红包信息
    NSString *buttonInfo;//按钮信息
    NSString *state;    //红包状态
    NSString *code;     //红包code
    NSString *function; //确认
    
    NSString *returnType; //跳转方式  1充值 2完善信息  3我的彩票 4 购彩 5活动 6微博
    NSString *topicID;    //微博id
    NSString *lotteryID;  //彩种id
}
-(id)initWithResponseString:(NSString *)responseString;

@property (nonatomic,copy) NSString *type,*showType,*awardInfo,*state,*code,*function,*returnType,*buttonInfo,*topicID,*lotteryID;
@end

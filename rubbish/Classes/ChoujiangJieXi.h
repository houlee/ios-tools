//
//  ChoujiangJieXi.h
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

@interface ChoujiangJieXi : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;          // 系统时间
    NSString *ZhongJiaState;    //中奖状态
    NSString *ZhongJiaMsg;      //中奖信息；
    NSString *JiangPinID; //奖品名称
    NSString *AllName;      //所有奖品
    NSInteger jiangpinleixing;  //奖品类型 1实物，2虚拟
    NSString *jifen;        //积分
    NSInteger cishu;        //抽奖次数
}
@property(nonatomic)NSInteger returnId,jiangpinleixing,cishu;
@property(nonatomic,copy)NSString *systemTime,*ZhongJiaState,*ZhongJiaMsg,*JiangPinID,*AllName,*jifen;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
//
//  GC_MyPrizeInfo.h
//  caibo
//
//  Created by cp365dev on 15/1/22.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_MyPrizeInfo : NSObject
{
    
    NSInteger returnId;  //返回系统消息ID
    NSString *systemTime;   //系统时间
    NSInteger pageCount;  //单页数量
    NSInteger prizeCount;//奖品数量
    NSMutableArray *prizeArray;//奖品数组
    
}
@property (nonatomic) NSInteger returnId,prizeCount,pageCount;
@property (nonatomic,copy) NSString *systemTime;
@property (nonatomic,retain) NSMutableArray *prizeArray;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


@interface PrizeInfo : NSObject {
    NSString *prize_info;       //奖品内容
    NSString *get_type;         //获得类型
    NSString *prize_time;       //奖品时间
    NSString *prize_type;       //奖品类型
    
    NSString *prize_info_type;//单位 ps:彩金、积分
    NSString *prize_info_count;//数量 ps:50  20
    NSString *prize_info_count1;//数量的单位 元
}

@property (nonatomic,copy)NSString *prize_info,*prize_time,*prize_type,*get_type,*prize_info_type,*prize_info_count,*prize_info_count1;
@end

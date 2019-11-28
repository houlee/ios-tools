//
//  ChampionData.h
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@interface ChampionData : NSObject{
    NSInteger returnId; // 返回消息id
    NSString * systemTime; // 系统时间
    NSString * endTime;//截止时间
    NSString * matchName; // 赛事名称
    NSString * teamInfo;//球队信息
    NSString * teamNum;//各个球队序号
    NSString * endNum;//停售场
    NSString * matchNo;//matchNo
    NSString * timeRemaining;//time remaining
    NSString * matchId;
    NSString * odds;//欧赔
    NSMutableArray * typeArray;
}



@property(nonatomic) NSInteger returnId;
@property (nonatomic, retain)NSString * systemTime, * endTime, * matchName, * teamInfo, * teamNum,* endNum, * matchNo, * timeRemaining, * matchId, *odds;
@property (nonatomic , retain) NSMutableArray * typeArray;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

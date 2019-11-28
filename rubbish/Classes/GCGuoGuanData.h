//
//  GCGuoGuanData.h
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GCGuoGuanData : NSObject{
    NSInteger sysid;
    NSString * systime;
    NSInteger jilushu;
    NSMutableArray * allArray;
}
@property (nonatomic, retain)NSString * systime;
@property (nonatomic, assign)NSInteger sysid, jilushu;
@property (nonatomic, retain)NSMutableArray * allArray;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end



@interface GCGuoGuanDataDetail : NSObject {
    NSInteger mzchangci;//命中场次数
    NSInteger  allright;//全对注数
    NSInteger fazzs;//方案总注数
    NSInteger  cyzs;//错一注数
    NSString * zhanji;//战绩
    NSString * fanganbianh;//方案编号
    NSString * username;//用户名
    NSString * nickName;//呢称
    NSString * baomi;//保密
    NSString * userid;//用户id
}

@property (nonatomic, retain)NSString   * zhanji, * fanganbianh , * username, * nickName, * baomi, * userid;
@property (nonatomic, assign)NSInteger fazzs, mzchangci, allright, cyzs;

@end
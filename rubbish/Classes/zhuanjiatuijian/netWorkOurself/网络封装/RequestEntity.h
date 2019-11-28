


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "RestAPICommon.h"

@interface RequestEntity : NSObject

//字典转换成json
+ (NSString*)dictionaryToJson:(NSDictionary *)bigDic;

//数据请求
+ (void)requestDatapartWithJsonBodyDic:(id )BodyDic success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (NSString *)requestStringWithJsonBodyDic:(id)BodyDic;

#pragma mark --------------上传单张图片-------------

//+ (void)requestSingeImageDatapartNSArrayImage:(NSArray *)imageArr jsonBodyDic:(id )BodyDic success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

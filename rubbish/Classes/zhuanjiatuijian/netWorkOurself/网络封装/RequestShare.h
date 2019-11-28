//
//  RequestShare.h
//  叮当Mall
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 eyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestShare : NSObject

#pragma mark -----------请求服务器数据-----------

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark ------------上传单张图片------------

+ (void)POSTSingImageUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

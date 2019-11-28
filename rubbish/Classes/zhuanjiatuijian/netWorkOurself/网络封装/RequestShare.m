//
//  RequestShare.m
//  叮当Mall
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 eyue. All rights reserved.
//

#import "RequestShare.h"
#import "AFNetworking.h"
#import "Info.h"
#import "UDIDFromMac.h"
#import "NetURL.h"
#import "GC_HttpService.h"
#import "MBProgressHUD+MJ.h"

@implementation RequestShare

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

#pragma mark -------------------请求服务器--------------------

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *ResponseSerializer = [AFHTTPResponseSerializer serializer];

    manger.responseSerializer = ResponseSerializer;
    manger.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json",nil];
    NSString *Name = kSouse;
    
    
#ifdef isYueYuBan
    Name = [NSString stringWithFormat:@"%@_1",Name];
#else
    Name = [NSString stringWithFormat:@"%@_0",Name];
#endif
    [manger.requestSerializer setValue:[UDIDFromMac uniqueGlobalDeviceIdentifier] forHTTPHeaderField:@"macCode"];
    [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",Name,[[Info getInstance] cbVersion]] forHTTPHeaderField:@"versinoNum"];
    [manger.requestSerializer setValue:newVersionKey forHTTPHeaderField:@"newVersion"];
    [manger.requestSerializer setValue:keyclientType forHTTPHeaderField:@"clientType"];
    [manger.requestSerializer setValue:[[Info getInstance] cbVersion] forHTTPHeaderField:@"version"];
    [manger.requestSerializer setValue:[[Info getInstance] cbSID] forHTTPHeaderField:@"sid"];
    
    [manger POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSString *successStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (successStr==nil||successStr.length==0) {
                //防崩处理 lizhongfei
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器无此人数据" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
                NSDictionary *successDic =  [self parseJSONStringToNSDictionary:successStr];
                success(successDic);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"error%@--",error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络请求超时,请检查你的网络"];
        }
    }];
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *ResponseSerializer = [AFHTTPResponseSerializer serializer];
    
    manger.responseSerializer = ResponseSerializer;
    manger.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json",nil];
    NSString *Name = kSouse;
    
    
#ifdef isYueYuBan
    Name = [NSString stringWithFormat:@"%@_1",Name];
#else
    Name = [NSString stringWithFormat:@"%@_0",Name];
#endif
    [manger.requestSerializer setValue:[UDIDFromMac uniqueGlobalDeviceIdentifier] forHTTPHeaderField:@"macCode"];
    [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",Name,[[Info getInstance] cbVersion]] forHTTPHeaderField:@"versinoNum"];
    [manger.requestSerializer setValue:newVersionKey forHTTPHeaderField:@"newVersion"];
    [manger.requestSerializer setValue:keyclientType forHTTPHeaderField:@"clientType"];
    [manger.requestSerializer setValue:[[Info getInstance] cbVersion] forHTTPHeaderField:@"version"];
    [manger.requestSerializer setValue:[[Info getInstance] cbSID] forHTTPHeaderField:@"sid"];
    
    [manger GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSString *successStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (successStr==nil||successStr.length==0) {
                //防崩处理 lizhongfei
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器无此人数据" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
                NSDictionary *successDic =  [self parseJSONStringToNSDictionary:successStr];
                success(successDic);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"error%@--",error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络请求超时,请检查你的网络"];
        }
    }];
}

#pragma mark --------------上传图片方法----------------

+ (void)POSTSingImageUrl:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *ResponseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer setValue: [NSString stringWithFormat:@"multipart/form-data"] forHTTPHeaderField:@"Content-Type"];
    manger.responseSerializer = ResponseSerializer;
    manger.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *Name = kSouse;
    
    
#ifdef isYueYuBan
    Name = [NSString stringWithFormat:@"%@_1",Name];
#else
    Name = [NSString stringWithFormat:@"%@_0",Name];
#endif
    [manger.requestSerializer setValue:[UDIDFromMac uniqueGlobalDeviceIdentifier] forHTTPHeaderField:@"macCode"];
    [manger.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",Name,[[Info getInstance] cbVersion]] forHTTPHeaderField:@"versinoNum"];
    [manger.requestSerializer setValue:newVersionKey forHTTPHeaderField:@"newVersion"];
//    [manger.requestSerializer setValue:keyclientType forHTTPHeaderField:@"clientType"];
    [manger.requestSerializer setValue:[[Info getInstance] cbVersion] forHTTPHeaderField:@"version"];
    [manger.requestSerializer setValue:[[Info getInstance] cbSID] forHTTPHeaderField:@"sid"];
    [manger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDictionary *dic = parameters;
        NSArray *arrImage = dic[@"photo"];
        NSData  *dataImge = arrImage[0];
        //        NSData *dataImage;
        //        for (NSData *dataImage in arrImage) {
        //         for (int i = 0; i < arrImage.count; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmsss";
        NSString  *str = [formatter stringFromDate:[NSDate date]];
        NSString  *fileName = [NSString stringWithFormat:@"%@.png",str];
        //            dataImage = arrImage[i];
        [formData appendPartWithFileData:dataImge name:@"photo" fileName:fileName mimeType:@"image/png"];
        //        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *successPicStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *successPicDic =  [self parseJSONStringToNSDictionary:successPicStr];
        success(successPicDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络请求超级,请检查您的网络"];
        failure(error);
    }];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
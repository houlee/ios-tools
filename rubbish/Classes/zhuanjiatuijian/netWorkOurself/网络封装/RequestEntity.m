

#import "RequestEntity.h"
#import "RequestShare.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "GC_NSString+AESCrypt.h"
#import "MBProgressHUD+MJ.h"

@implementation RequestEntity

//字典转成字符串
+ (NSString*)dictionaryToJson:(NSMutableDictionary *)bigDic
{
    NSDictionary *dicStr = [[NSDictionary  alloc]init];
    dicStr = bigDic;
    NSLog(@"dicStr--%@",dicStr);
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicStr options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

+ (NSString *)requestStringWithJsonBodyDic:(id)BodyDic {
    
    NSLog(@"传入的字典：%@",BodyDic);
    //转成字符串
    NSString  *parameterStr = [self dictionaryToJson:BodyDic];
    NSLog(@"字典转成字符串为：%@",parameterStr);
    
    NSDate * date=[NSDate date];
    NSString * timeSp=[NSString stringWithFormat:@"%d",(int)[date timeIntervalSince1970]];//时间戳
    parameterStr=[NSString stringWithFormat:@"%@_%@",timeSp,parameterStr];
    NSLog(@"加密前的字符串：%@",parameterStr);
    //加密
    parameterStr=[parameterStr AES256EncryptWithKey:AllparaSecretKey];
    parameterStr=[NSString encodeToPercentEscapeString:parameterStr];
    return parameterStr;
}

//数据请求
+ (void)requestDatapartWithJsonBodyDic:(id)BodyDic success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    //把parameters参数的字典转成字符串处理一下再放到BodyDic
    //    NSDictionary * parametersDic=[BodyDic objectForKey:@"parameters"];
    //    NSString * parameters=[self dictionaryToJson:parametersDic];
    //    [BodyDic setObject:parameters forKey:@"parameters"];
    //    NSLog(@"处理传入字典之后的字典：%@",BodyDic);

    NSMutableDictionary * parametersDic= [NSMutableDictionary dictionaryWithDictionary:[BodyDic objectForKey:@"parameters"]];
    if (parametersDic) {
        [parametersDic setValue:[[Info getInstance] cbSID] forKey:@"sid"];
        [parametersDic setValue:[[Info getInstance] cbVersion] forKey:@"version"];
        #if defined YUCEDI || defined DONGGEQIU || defined CRAZYSPORTS
        if ([[caiboAppDelegate getAppDelegate] isShenhe]) {
            [parametersDic setValue:@"1" forKey:@"isInCheck"];
        }
        else {
            [parametersDic setValue:@"0" forKey:@"isInCheck"];
        }
        #endif
        BodyDic = [NSMutableDictionary dictionaryWithDictionary:BodyDic];
        [BodyDic setValue:parametersDic forKey:@"parameters"];
    }
    
    NSLog(@"传入的字典：%@",BodyDic);
    //转成字符串
    NSString  *parameterStr = [self dictionaryToJson:BodyDic];
    NSLog(@"字典转成字符串为：%@",parameterStr);
    
    NSDate * date=[NSDate date];
    NSString * timeSp=[NSString stringWithFormat:@"%d",(int)[date timeIntervalSince1970]];//时间戳
    parameterStr=[NSString stringWithFormat:@"%@_%@",timeSp,parameterStr];
    NSLog(@"加密前的字符串：%@",parameterStr);
    //加密
    parameterStr=[parameterStr AES256EncryptWithKey:AllparaSecretKey];
    parameterStr=[NSString encodeToPercentEscapeString:parameterStr];
    NSLog(@"加密后的字符串：%@",parameterStr);
    //最终传给终端的字典
    NSMutableDictionary * postDic=[NSMutableDictionary dictionary];
    [postDic setObject:parameterStr forKey:@"accessSecretData"];
    [RequestShare POST:BaseAPI parameters:postDic success:^(id responseObject) {
        
//        if (GC_testModle_1 && info.shouldShowLogInfo) {
//            [[caiboAppDelegate getAppDelegate] printLog:[NSString stringWithFormat:@"%@\n\n%@\n\n",BodyDic,responseObject]];
//        }
        success(responseObject);
    } failure:^(NSError *error) {
//        if (GC_testModle_1 && info.shouldShowLogInfo) {
//            [[caiboAppDelegate getAppDelegate] printLog:[NSString stringWithFormat:@"%@\n\nerror:%@\n\n",BodyDic,error]];
//        }
        failure(error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络请求超时,请检查你的网络"];
    }];
}

#pragma mark -----------------上传单张图片--------------------

//+ (void)requestSingeImageDatapartNSArrayImage:(NSArray *)imageArr jsonBodyDic:(id )BodyDic success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    //上传图片函数待定
//    NSString  *parameterStr = [self dictionaryToJson:BodyDic];
//    //    NSDate * date=[NSDate date];
//    //    NSString * timeSp=[NSString stringWithFormat:@"%d",(int)[date timeIntervalSince1970]];//时间戳
//    //    parameterStr=[NSString stringWithFormat:@"%@_%@",timeSp,parameterStr];
//    //        //加密
//    //    [parameterStr AES256EncryptWithKey:EncryptWithKey];
//    //    parameterStr=[NSString encodeToPercentEscapeString:parameterStr];
//    
//    //参数和hashToken 封装字典传到服务器
//    NSMutableDictionary *paramerDic= [NSMutableDictionary dictionary];
//    [paramerDic setObject:parameterStr forKey:@"json_parameters"];
//    [paramerDic setObject:imageArr forKey:@"photo"];
//    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BaseH5,@"/expertApply"];
//    
//    [RequestShare POSTSingImageUrl:urlStr parameters:paramerDic success:^(id responseObject) {
//        success(responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showError:@"网络请求超级,请检查您的网络"];
//    }];
//}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
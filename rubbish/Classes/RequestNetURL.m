//
//  RequestNetURL.m
//  caibo
//
//  Created by houchenguang on 14-11-27.
//
//

#import "RequestNetURL.h"
#import "UDIDFromMac.h"
#import "Info.h"
#import "GC_HttpService.h"

@implementation RequestNetURL
@synthesize idDelegate,failDelegate;
@synthesize selectorFunc, failSelector;

- (void)dealloc{
    [completeData release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code
        
        completeData = [[NSMutableData alloc] init];
        
        
    }
    return self;
}



- (void)requestBodyFunc:(NSMutableURLRequest *)request{

    [request setValue:[UDIDFromMac uniqueGlobalDeviceIdentifier] forHTTPHeaderField:@"macCode"];
    
    NSString *Name = kSouse;
#ifdef isYueYuBan
    Name = [NSString stringWithFormat:@"%@_1",Name];
#else
    Name = [NSString stringWithFormat:@"%@_0",Name];
#endif
    [request setValue:[NSString stringWithFormat:@"%@_%@",Name,[[Info getInstance] cbVersion]] forHTTPHeaderField:@"versinoNum"];
    [request setValue:newVersionKey forHTTPHeaderField:@"newVersion"];
    [request setValue:@"text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2" forHTTPHeaderField:@"Accept"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    
    
    urlConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [urlConnection start];
    
}
#pragma mark 文件下载
- (void)requestNetWithFileUpDataUrl:(NSURL *)URLString{

   
    NSURLRequest *request = [NSURLRequest requestWithURL:URLString];
    NSMutableData *data = [[NSMutableData alloc] init];
  
    [data release];
    urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
  

}


//#pragma mark 文件上传
//- (void)requestNetWithFileUrl:(NSURL *)URLString bodyData:(NSMutableData *)data{
//    
//   
//    
//}

#pragma mark 图片上传
- (void)requestNetWithImageUrl:(NSURL *)URLString bodyData:(NSMutableData *)data{
    
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[HEADER dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[IMAGE_CONTNET dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[CONTENTTYPE dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];//图片数据
    [body appendData:[END dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableURLRequest  *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:URLString];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    [self requestBodyFunc:request];

}


#pragma mark post请求
- (void)requestNetWithPostUrl:(NSURL *)URLString bodyData:(NSMutableData *)data{

    
    NSMutableURLRequest  *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:URLString];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [self requestBodyFunc:request];
}
#pragma mark get请求
- (void)requestNetGetWithUrl:(NSURL *)URLString{
    
    NSMutableURLRequest  *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:URLString];
    [request setHTTPMethod:@"GET"];
    [self requestBodyFunc:request];
    
}

#pragma mark 成功回调的传参
- (void)didFinishWithObject:(id)idobject selector:(SEL)aSelector{

    self.idDelegate = idobject;
    self.selectorFunc = aSelector;
}
#pragma mark 失败回调的传参
- (void)didFailWithbject:(id)idobject selector:(SEL)aSelector{
    self.failDelegate = idobject;
    self.failSelector = aSelector;
}


#pragma mark 取消请求
- (void)clearDelegatesAndCancel{
    [urlConnection cancel];
}
#pragma mark NSURLConnectionDelegate
//网络返回数据开始
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"网络返回数据开始~~~~~~~~");
    [completeData setLength:0];
}
//重复调用，返回数据处理
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"重复调用，返回数据处理~~~~~~~~");
    [completeData appendData:data];
}
//返回数据结束
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"返回数据结束~~~~~~~~");
//    NSString *jsonStr=[[NSString alloc]initWithData:completeData encoding:NSUTF8StringEncoding];
    [self.idDelegate performSelector:self.selectorFunc withObject:completeData];
//    [jsonStr release];
    
}
//发生错误处理方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"发生错误处理方法~~~~~~~~");
//    NSString *jsonStr=[[NSString alloc]initWithData:completeData encoding:NSUTF8StringEncoding];
    [self.failDelegate performSelector:self.failSelector withObject:completeData];
//    [jsonStr release];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
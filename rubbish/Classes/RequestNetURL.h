//
//  RequestNetURL.h
//  caibo
//
//  Created by houchenguang on 14-11-27.
//
//

#import <Foundation/Foundation.h>
#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
#define HEADER          @"\r\n-----------------------------0x0x0x0x0x0x0x0x\r\n"
#define IMAGE_CONTNET   @"Content-Disposition: form-data; name=\"userfile\"; filename=\"image.jpg\"\r\n"
//“userfile”是服务上的文件域，类似上传后的保存路径可以这样理解；”image.jpg“是自定义的不是上传目标的名称。
#define CONTENTTYPE     @"Content-Type: application/octet-stream\r\n\r\n"
//上传类型，是必要的
#define MULTIPART       @"multipart/form-data; boundary=---------------------------0x0x0x0x0x0x0x0x"
//报头
#define END             @"\r\n-----------------------------0x0x0x0x0x0x0x0x--\r\n"


@interface RequestNetURL : NSObject<NSURLConnectionDataDelegate>{
    
    NSURLConnection *urlConnection;
    id idDelegate;
    SEL selectorFunc;
    NSMutableData * completeData;
    id failDelegate;
    SEL failSelector;
}
@property (nonatomic, assign)id idDelegate, failDelegate;
@property (nonatomic, assign)SEL selectorFunc, failSelector;

- (void)requestNetGetWithUrl:(NSURL *)URLString;//get请求
- (void)requestNetWithPostUrl:(NSURL *)URLString bodyData:(NSMutableData *)data;//post请求
- (void)requestNetWithImageUrl:(NSURL *)URLString bodyData:(NSMutableData *)data;//上传图片
- (void)requestNetWithFileUpDataUrl:(NSURL *)URLString;//文件下载

@end

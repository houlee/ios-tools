//
//  下载图片
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"

@interface ImageDownloader : NSObject {
    ASINetworkQueue *mNetworkQueue;
    BOOL mFailed;
    
    NSMutableDictionary *mImages;// 存放程序运行时已下载完成的图片
    NSMutableDictionary *mDelegates;// 存放delegate，下载完成后回调delegate设置图片
}

+ (UIImage *)defaultProfileImage : (BOOL) big;
- (UIImage *) fetchImage : (NSString *) imageUrl Delegate : (id) delegate Big : (BOOL) big;
- (UIImage *) fetchImage:(NSString *)imageUrl Delegate:(id)delegate DefautImage:(UIImage *)defautImage;
- (void)removeDelegate:(id)delegate forURL: (NSString*) imageUrl;

@end
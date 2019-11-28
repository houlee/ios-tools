//
//  ImageStoreReceiver.m
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageStoreReceiver.h"

@implementation ImageStoreReceiver

@synthesize imageContainer;

// 图片获取成功回调方法
- (void)imageDidFetchSuccess:(UIImage*)image 
{
    if (imageContainer) 
    {
        if ([imageContainer respondsToSelector:@selector(updateImage:)]) 
        {
            [imageContainer performSelector:@selector(updateImage:) withObject:image];
        }
    }
}

- (void)dealloc {
    
    imageContainer = nil;
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
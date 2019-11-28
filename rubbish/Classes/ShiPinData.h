//
//  ShiPinData.h
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShiPinData : NSObject{
    NSString * content;//内容
    NSString * time;//时间
    NSString * islive;//是否直播
    NSString * urlstring;//url
    
    NSString *jc;
    NSString *jcmatchid;
    NSString *lcmatchid;
    NSString *zc;
    NSString *status;
    NSString *end_time;
    NSString *zcissue;
    NSString *section_id;
}

@property (nonatomic, retain)NSString * content,* time,* islive, * urlstring;
@property (nonatomic, retain)NSString *jc,*jcmathid,*lcmatchid,*zc,*status,*end_time,*zcissue,*section_id;
@end

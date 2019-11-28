//
//  GC_shengfudata.h
//  caibo
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GC_shengfudata : NSObject{
    NSString * leftStr;
    NSString * cuStr;
    UIImage * rightImage;
    NSString * changci;
    NSString * jiancheng;
    NSString * yinstr;
    NSString * tongstr;
    NSString * jinstr;
    BOOL dandan;
    NSInteger row;
    BOOL zuihou;
}
@property (nonatomic, retain)NSString * changci, *jiancheng, * yinstr, * tongstr, * jinstr;;
@property (nonatomic, retain)NSString * leftStr;
@property (nonatomic, retain)NSString * cuStr;
@property (nonatomic, retain)UIImage * rightImage;
@property (nonatomic, assign)BOOL dandan, zuihou;
@property (nonatomic, assign)NSInteger row;
@end

//
//  BlackUser.h
//  caibo
//
//  Created by Kiefer on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BlackUser : NSObject 
{    
    NSString *userName;
    NSString *image;
    NSString *nickName;
    NSString *userId;
}

@property(nonatomic, retain) NSString *userName;
@property(nonatomic, retain) NSString *image;
@property(nonatomic, retain) NSString *nickName;
@property(nonatomic, retain) NSString *userId;

// 黑名单列表解析
+ (NSMutableArray*)parserWithString:(NSString *)str;
// 初始化 （NSDictionary）
- (id)initWithDic:(NSDictionary*)dic;


@end

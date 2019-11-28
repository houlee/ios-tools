//
//  ResultForSuccOrFail.h
//  caibo
//
//  Created by jacob on 11-5-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*** 解析 所有 字段 只返回  result 的 接口 ***/

// 2.51  接口在 整合 在这边解析
 
#import <Foundation/Foundation.h>

@interface Result : NSObject {
	
	NSString *result;
	
	NSString *commentId;

}

@property(nonatomic,retain)NSString *result;

@property(nonatomic,retain)NSString*commentId;


-(id)initWithParse:(NSString*)responseString;



@end

//
//  YtTheme.h
//  caibo
//
//  Created by jeff.pluto on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YtTheme : NSObject 
{    
	NSMutableArray *arrayList;
    
    NSString *createtime;
    NSString *ytThemeId;
    NSString *order_num;
    NSString *name;
    NSString *isCc;
    
	// 处理之后的话题
	NSString *ytname;
}

@property (nonatomic, retain) NSMutableArray *arrayList;
@property (nonatomic, retain) NSString *createtime, *ytThemeId, *order_num, *name, *isCc;
@property (nonatomic, retain)NSString *ytname;

-(NSMutableArray*) arrayWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;

@end
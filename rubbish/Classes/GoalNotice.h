//
//  GoalNotice.h
//  caibo
//
//  Created by user on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoalNotice : NSObject {
	
	NSString *goalNoticeStatus;  //进球通知返回状态
}

@property (nonatomic, retain) NSString *goalNoticeStatus;

- (id) initWithParse:(NSString *)jsonString;

@end

//
//  UserGroupList.h
//  caibo
//
//  Created by jacob on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/***
 * 2.54  查看分组 接口解析
 
 **/

@interface UserGroupList : NSObject {
	
	
	NSMutableArray *arryList;
	
	NSString *pageCount;
	
	NSString *groupId;
	
	NSString *userid;
	
	NSString *name;
	
	NSString *createTime;
	
	NSString *pageNum;
	
	

}

@property(nonatomic,retain)NSMutableArray *arryList;

@property(nonatomic,retain)NSString *pageCount,*groupId,*userid,*name,*createTime,*pageNum;

-(id)initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;



@end

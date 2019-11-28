//
//  MailList.h
//  caibo
//
//  Created by jacob on 11-6-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
 *2.67 新私信列表
 *
 *
 *******/


#import <Foundation/Foundation.h>


@interface MailList : NSObject {
	
	NSMutableArray *arryList;
	
	NSString *pageCount;
	
	NSString *pageNum;
	
	
	NSString *ytMailId;
	
	NSString *senderId;
	
	NSString *recieverId;
	
	NSString*content;
	
	NSString *createDate;
    NSString *date;
	
	NSString *status;
	
	NSString *type;
	
	NSString *senderHead;
	
	NSString *recieverHead;
	
	NSString *nickName;
	
	NSString *vip;
	
	// 处理后数据
	NSString *mcontent;
	
	NSString * img_url;
}

@property(nonatomic,retain)NSMutableArray *arryList;

@property(nonatomic,retain)NSString *pageCount,*pageNum,*ytMailId,*senderId,*recieverId,*content,*createDate,*status,*type,*senderHead,*recieverHead,*nickName,*vip,*date, *img_url;


@property(nonatomic,retain)NSString *mcontent;

-(id)initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;

@end

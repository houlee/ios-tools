//
//  MailList.m
//  caibo
//
//  Created by jacob on 11-6-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MailList.h"

#import "SBJSON.h"
#import "NSStringExtra.h"


@implementation MailList


@synthesize arryList;
@synthesize pageCount,pageNum,senderId,ytMailId,recieverId,content,createDate,status,type,senderHead,recieverHead,nickName,vip,date,img_url;

@synthesize mcontent;

-(id)initWithParse:(NSString*)responseString{
	if (responseString==nil) {
		return NULL;
	}
	if((self=[super init])) {
		SBJSON *jsonParse  = [[SBJSON alloc]init];
		NSArray *arry = [jsonParse objectWithString:responseString];
		if(arry){
			NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			for (int i = 0; i < [arry count]; i++) {
				NSDictionary *dic = [arry objectAtIndex:i];	
				MailList *mList = [self paserWithDictionary:dic];
				[dateList insertObject:mList atIndex:i];
			}
			self.arryList = dateList;
            
			[dateList release];
		}
		[jsonParse release];
	}
	return self;
}



-(id) paserWithDictionary:(NSDictionary*)dic{
	
	MailList *mlist = [[[MailList alloc] init] autorelease];
	
   if (dic) {
	   
	  	   
	   mlist.ytMailId = [[dic valueForKey:@"ytMailId"]stringValue];
	   
	   mlist.senderId = [[dic valueForKey:@"senderId"]stringValue];
	   
	   mlist.recieverId = [[dic valueForKey:@"recieverId"]stringValue];
	   
	   mlist.content = [dic valueForKey:@"content"];
       
       mlist.img_url = [dic valueForKey:@"img_url"];
	          
       if (mlist.content) {
           mlist.mcontent = [mlist.content flattenPartHTML:mlist.content];
       }
	
       mlist.date = [dic valueForKey:@"createDate"];
	   
	   mlist.createDate = [dic valueForKey:@"createDate"];
	   
	   mlist.status = [dic valueForKey:@"status"];
	   
	   mlist.type = [dic valueForKey:@"type"];
	   
	   mlist.senderHead = [dic valueForKey:@"senderHead"];
	   
	   if(![mlist.senderHead hasPrefix:@"http"]){
		   
		   NSMutableString *senderImage = [[NSMutableString alloc] init];
		   
		   [senderImage appendString:@"http://t.diyicai.com/"];
		   
		   [senderImage appendString:mlist.senderHead];
		   
		   mlist.senderHead = senderImage;
		   
		   [senderImage release];
	   }
	   mlist.recieverHead = [dic valueForKey:@"recieverHead"];
	   
	   if(![ mlist.recieverHead hasPrefix:@"http"]){
		   NSMutableString *senderImage = [[NSMutableString alloc] init];
		   [senderImage appendString:@"http://t.diyicai.com/"];
		   [senderImage appendString: mlist.recieverHead];
		    mlist.recieverHead = senderImage;
		   [senderImage release];
	   }   
	   mlist.nickName = [dic valueForKey:@"nickName"];
	   
	   mlist.vip = [dic valueForKey:@"vip"];
   }
	return mlist;
}

-(void)dealloc{
    [img_url release];
	[arryList release];
	[pageCount release];
	[pageNum release];
	[ytMailId release];
	[senderId release];
	[recieverId release];
	[content release];
	[createDate release];
    [date release];
	[status release];
	[type release];
	[senderHead release];
	[recieverHead release];
	[nickName release];
	[vip release];
	[mcontent release];

	[super dealloc];
}
		

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  CommentList.m
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommentList.h"
#import "SBJSON.h"
#import "NSStringExtra.h"
#import "YtTopic.h"
#import "Info.h"

@implementation CommentList

@synthesize arrayList;

@synthesize userId,content,nick_name,vip,topicid,timeformate,colormcontent,colormcontent_text,content_text,mid_image,date_created,sma_image,attach_type,count_dz,praisestate;

@synthesize ycid;

@synthesize orignal_id;

@synthesize mcontent,mcontent_text;

@synthesize sma_image_ref,comcount,mid_image_ref,date_created_ref,id_ref,replyid,nick_name_ref,content_ref;

@synthesize isauto;

-(id)initWithParse:(NSString*)responseString
{
	
	if(responseString ==nil)
		
		return NULL;
	
	if(self =[super init]){
	
		SBJSON *jsonParse = [[SBJSON alloc]init];
		
		NSArray *arry = [jsonParse objectWithString:responseString];
		
				
		if(arry){
			
			NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			
			for (int i = 0; i < [arry count]; i++) {
				
				NSDictionary *dic = [arry objectAtIndex:i];	
				
				CommentList *commentlist = [self paserWithDictionary:dic];
                
                YtTopic *topic = [[[YtTopic alloc] init] autorelease];
                topic.userid = commentlist.userId;
                topic.nick_name = commentlist.nick_name;
                topic.vip = commentlist.vip;
                topic.mcontent = commentlist.mcontent;
                topic.orignalText = commentlist.mcontent_text;
                topic.timeformate = commentlist.date_created;
                topic.mid_image = commentlist.mid_image;
                topic.caiboType = CAIBO_TYPE_COMMENT;
                topic.colorcontent_ref = commentlist.colormcontent_text;
                topic.colorcontentl = commentlist.colormcontent;
                topic.content = commentlist.content;
                topic.topicid = commentlist.topicid;
                topic.orignal_id = commentlist.topicid;
                topic.count_dz = commentlist.count_dz;
                topic.praisestate = commentlist.praisestate;
                [topic calcTextBounds];
                
				[dateList insertObject:topic atIndex:i];
			}
			
			self.arrayList = dateList;
			
			[dateList release];
			
			
		}
		
		[jsonParse release];
		
		
	}
	
	return self;
	
	
	}





-(id) paserWithDictionary:(NSDictionary*)dic
{
	CommentList *commentlist = [[[CommentList alloc] init] autorelease];
    
    
	if(dic){
	
		commentlist.userId = [dic valueForKey:@"id"];
		
		commentlist.topicid = [dic valueForKey:@"topicid"];
		
		commentlist.nick_name = [dic valueForKey:@"nick_name"];
		
		commentlist.vip = [dic valueForKey:@"vip"];
		
		commentlist.nick_name = [commentlist.nick_name nickName:commentlist.userId];
		
		commentlist.content = [dic valueForKey:@"content"];
        
        if (commentlist.content && [commentlist.content rangeOfString:@">http://caipiao365.com/faxq="].location !=NSNotFound) {
            NSArray * newContentArr = [commentlist.content componentsSeparatedByString:@">http://caipiao365.com/faxq="];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                if ([newContentStr rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound || i == newContentArr.count - 1) {
                    if (i == 0) {
                        newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                    }else if (i == newContentArr.count - 1) {
                        NSRange range = [newContentStr rangeOfString:@"</a>"];
                        newContentStr = [NSString stringWithFormat:@"方案详情%@",[newContentStr substringFromIndex:range.location]];
                    }else if ([newContentStr rangeOfString:@"</a>"].location !=NSNotFound) {
                        NSRange range = [newContentStr rangeOfString:@"</a>"];
                        newContentStr = [NSString stringWithFormat:@"方案详情%@>",[newContentStr substringFromIndex:range.location]];
                    }else{
                        newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                    }
                    
                    finalString = [finalString stringByAppendingString:newContentStr];
                }
            }
            commentlist.content = finalString;
        }
        
		if (commentlist.content) {
			
			commentlist.mcontent = [commentlist.content flattenPartHTML:commentlist.content];
            commentlist.colormcontent = [commentlist.content flattenColorPartHTML:commentlist.content];
		}
        
        if (commentlist.content && [commentlist.content rangeOfString:@"]"].location !=NSNotFound) {
            NSArray * newContentArr = [commentlist.content componentsSeparatedByString:@"]"];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                NSRange range = [newContentStr rangeOfString:@"["];
                if (range.location != NSNotFound) {
                    NSString * faceStr = [[newContentStr substringFromIndex:range.location + 1] stringToFace];
                    UIImage * image = [UIImage imageNamed:faceStr];
                    
                    if (image) {
                        newContentStr = [NSString stringWithFormat:@"%@<img src=\"http://t.diyicai.com/style/images/faces/%@.gif\"/>",[newContentStr substringToIndex:range.location],faceStr];
                    }else{
                        if (i == newContentArr.count - 1) {
                            if ([commentlist.content hasSuffix:@"]"]) {
                                newContentStr = [newContentStr stringByAppendingString:@"]"];
                            }
                        }else{
                            newContentStr = [newContentStr stringByAppendingString:@"]"];
                        }
                    }
                }
                else if (i != newContentArr.count - 1) {
                    newContentStr = [newContentStr stringByAppendingString:@"]"];
                }
                finalString = [finalString stringByAppendingString:newContentStr];
            }
            commentlist.content = finalString;
        }
		
		commentlist.content_text = [dic valueForKey:@"content_text"];
		if ([[dic objectForKey:@"oriDelFlag"]intValue] == 2) {
			commentlist.content_text = [dic objectForKey:@"oriDelMsg"];
            commentlist.colormcontent_text = [commentlist.content_text flattenColorPartHTML:commentlist.content_text];
		}
		
		if (commentlist.content_text&&![commentlist.content_text isEqualToString:@""]) {
			
//			commentlist.content_text = [commentlist.content_text flattenPartHTML:commentlist.content_text];
			
			NSMutableString *str = [[NSMutableString alloc] init];
			
			[str appendString:@"回复我的彩博："];
			
			[str appendFormat:@"%@",commentlist.content_text];
			
			commentlist.mcontent_text = str;
			
			[str release];
			
		}
		
		
		commentlist.date_created = [dic valueForKey:@"timeformate"];
		
		
		commentlist.mid_image = [dic valueForKey:@"mid_image"];
		
		commentlist.sma_image = [dic valueForKey:@"sma_image"];
		
		commentlist.date_created = [dic valueForKey:@"date_created"];
		
		commentlist.attach_type = [dic valueForKey:@"attach_type"];
		
		commentlist.ycid= [dic valueForKey:@"ycid"];
		commentlist.orignal_id = [dic valueForKey:@"orignal_id"];

		if (![commentlist.replyid isEqualToString:@"0"]) {
			
			commentlist.id_ref = [dic valueForKey:@"id_ref"];
			
			commentlist.nick_name_ref = [dic valueForKey:@"nick_name_ref"];
			
			commentlist.mid_image_ref = [dic valueForKey:@"mid_image_ref"];
			
			commentlist.sma_image_ref = [dic valueForKey:@"sma_image_ref"];
			
			commentlist.date_created_ref =[dic valueForKey:@"date_created_ref"];
			
			commentlist.content_ref = [dic valueForKey:@"content_ref"];
			if ([[dic objectForKey:@"oriDelFlag"]intValue] == 2) {
				commentlist.content_ref = [dic objectForKey:@"oriDelMsg"];
			}

			if (commentlist.content_ref&&![commentlist.content_ref isEqualToString:@""]) {
				
				NSMutableString *str = [[NSMutableString alloc] init];
				
				[str appendString:@"回复我的评论："];
				
				[str appendFormat:@"%@",commentlist.content_ref];
				
				commentlist.mcontent_text = str;
				
				[str release];
				
				
			}
			
			
		}
        
        if (commentlist.mcontent_text && [commentlist.mcontent_text rangeOfString:@"]"].location !=NSNotFound) {
            NSArray * newContentArr = [commentlist.mcontent_text componentsSeparatedByString:@"]"];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                NSRange range = [newContentStr rangeOfString:@"["];
                if (range.location != NSNotFound) {
                    NSString * faceStr = [[newContentStr substringFromIndex:range.location + 1] stringToFace];
                    UIImage * image = [UIImage imageNamed:faceStr];
                    
                    if (image) {
                        newContentStr = [NSString stringWithFormat:@"%@<img src=\"http://t.diyicai.com/style/images/faces/%@.gif\"/>",[newContentStr substringToIndex:range.location],faceStr];
                    }else{
                        if (i == newContentArr.count - 1) {
                            if ([commentlist.mcontent_text hasSuffix:@"]"]) {
                                newContentStr = [newContentStr stringByAppendingString:@"]"];
                            }
                        }else{
                            newContentStr = [newContentStr stringByAppendingString:@"]"];
                        }
                    }
                }
                else if (i != newContentArr.count - 1) {
                    newContentStr = [newContentStr stringByAppendingString:@"]"];
                }
                finalString = [finalString stringByAppendingString:newContentStr];
            }
            commentlist.mcontent_text = finalString;
        }
        
        if([commentlist.nick_name isEqualToString:@"活动管理员"] && [commentlist.content rangeOfString:@"http://"].location != NSNotFound)
        {
            commentlist.isauto = YES;
        }
        else{
            commentlist.isauto = NO;

        }
        
        if ([[[Info getInstance] userId] intValue] == 0) {
            commentlist.count_dz = [dic valueForKey:@"count_dz"];
            commentlist.praisestate = [dic valueForKey:@"praisestate"];
        }else{
            NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
            
            if ([weiBoLikeDic valueForKey:commentlist.topicid]) {
                commentlist.count_dz = [[weiBoLikeDic valueForKey:commentlist.topicid] objectAtIndex:0];
                commentlist.praisestate = [[weiBoLikeDic valueForKey:commentlist.topicid] objectAtIndex:1];
                
            }else{
                commentlist.count_dz = [dic valueForKey:@"count_dz"];
                commentlist.praisestate = [dic valueForKey:@"praisestate"];
                
                if (commentlist.count_dz) {
                    [weiBoLikeDic setObject:@[commentlist.count_dz,commentlist.praisestate] forKey:commentlist.topicid];
                    [[NSUserDefaults standardUserDefaults] setValue:weiBoLikeDic forKey:@"weiBoLike"];
                }
            }
        }

	}

   return commentlist;
	
}

-(void)dealloc{
	
	[arrayList release];
	
	[userId release];
	
	[content release];
	
    [nick_name release];
	
	[vip release];
	
	[topicid release];
	
	[timeformate release];
	
	[content_text release];
	
	[mid_image release];
	
	[date_created release];
	
	[sma_image release];
	
	[attach_type release];
	
	[ycid release];
	
	[orignal_id release];
	
	[mcontent release];
	
	[mcontent_text release];
	
	
	[sma_image_ref release];
	
	[comcount release];
	
	[mid_image_ref release];
	
	[date_created_ref release];
	
	[id_ref release];
	
	[replyid release];
	
	[nick_name_ref release];
	
	[content_ref release];
	

	[super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
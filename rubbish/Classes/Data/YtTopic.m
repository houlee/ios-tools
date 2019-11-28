//
//  YtTopic.m
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YtTopic.h"
#import "SBJSON.h"
#import "NSStringExtra.h"
#import "datafile.h"
#import "caiboAppDelegate.h"
#import "SharedDefine.h"
#import "ColorLabel.h"
#import "Info.h"

@implementation YtTopic

@synthesize arrayList,region,site,attach_small,topicid,lottery_id,count_zf,isNewComond,newstitle,
userid,mid_image,image,count_sc,date_created,count_pl,city,nick_name,vip,oriDelFlag,
content,timeformate,attach,orignal_id,project_id,province,sma_image,is_attention,lottery_id_ref,
attach_type,source,nick_name_ref, content_ref, count_pl_ref,count_zf_ref,isCc, orignalText, mcontent, mcontent_ref,colorcontentl,colorcontent_ref, type, cellHeight, textBounds, orignalTextBounds, isBubbleTheme, caiboType, hasImage, attach_ref, attach_type_ref, attach_small_ref,blogtype, blogCount,count_dz, praisestate;
@synthesize isAuto;
@synthesize reRequest;

@synthesize indexPath;
@synthesize mcontentHeight;
@synthesize mcontentRefHeight;
@synthesize tableView;

-(id)initWithParse:(NSString*)responseString
{	
	if(responseString == nil)
		return NULL;	
	if((self = [super init])){		
		SBJSON *jsonParse = [[SBJSON alloc] init];
		NSArray *arry = [jsonParse objectWithString:responseString];
		if(arry){
            NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			for (int i = 0; i < [arry count]; i++) {				
				NSDictionary *dic = [arry objectAtIndex:i];	
				YtTopic *ytTopic = [self paserWithDictionary:dic];				
				[dateList insertObject:ytTopic atIndex:i];
			}
            self.arrayList = dateList;
			[dateList release];
		}
		[jsonParse release];
	}
	return (self);
}

-(id)initWithHomeParse:(NSString*)responseString homeBool:(BOOL)yesOrNo
{
	if(responseString == nil)
		return NULL;
	if((self = [super init])){
		SBJSON *jsonParse = [[SBJSON alloc] init];
        
        NSDictionary * dict = [jsonParse objectWithString:responseString];
        
		NSArray *arry = [dict objectForKey:@"topicList"];
		if(arry){
            NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			for (int i = 0; i < [arry count]; i++) {
				NSDictionary *dic = [arry objectAtIndex:i];
				YtTopic *ytTopic = [self paserWithDictionary:dic];
				[dateList insertObject:ytTopic atIndex:i];
			}
            self.arrayList = dateList;
			[dateList release];
		}
		[jsonParse release];
	}
	return (self);
}

- (BOOL)isMacth {
	if ([self.lottery_id isEqualToString:@"301"]||
		[self.lottery_id isEqualToString:@"302"]||
		[self.lottery_id isEqualToString:@"303"]||
		[self.lottery_id isEqualToString:@"201"]||
		[self.lottery_id isEqualToString:@"300"]||
		[self.lottery_id isEqualToString:@"400"]) {
		return YES;
	}
	if ([self.lottery_id_ref isEqualToString:@"301"]||
		[self.lottery_id_ref isEqualToString:@"302"]||
		[self.lottery_id_ref isEqualToString:@"303"]||
		[self.lottery_id_ref isEqualToString:@"201"]||
		[self.lottery_id_ref isEqualToString:@"300"]||
		[self.lottery_id_ref isEqualToString:@"400"]) {
		return YES;
	}
	return NO;
}

- (BOOL)isZhiChiBiSai:(NSString *)_lottryid {
    if([_lottryid isEqualToString:@"200"]||[_lottryid isEqualToString:@"300"]||[_lottryid isEqualToString:@"301"]||[_lottryid isEqualToString:@"302"]||[_lottryid isEqualToString:@"303"]||[_lottryid isEqualToString:@"201"]||[_lottryid isEqualToString:@"400"]||[_lottryid isEqualToString:@""]){
        return YES;
    }
//    if (||[_lottryid isEqualToString:@"22"]||[_lottryid isEqualToString:@"210"]||[_lottryid isEqualToString:@""]||[_lottryid isEqualToString:@"14"]||[_lottryid isEqualToString:@"15"]||[_lottryid isEqualToString:@"23"]||
//        [_lottryid isEqualToString:@"16"]) {
//        return  YES;
//    }
    if ([self.attach_type isEqualToString:@"15"]) {
        return YES;
    }
    if (!_lottryid) {
        return YES;
    }
    return NO;
}


//8 发起合买，9代购，,10参与和买,12，预测，15抄单
- (BOOL) isFangan:(NSString *)_attach_type {
    if ([_attach_type isEqualToString:@"8"]||[_attach_type isEqualToString:@"9"]||[_attach_type isEqualToString:@"10"]||[_attach_type isEqualToString:@"12"]||[_attach_type isEqualToString:@"15"]) {
        return YES;
    }
    
    return  NO;
}

- (int) calcTextBounds : (YtTopic*) status {
    status.cellHeight = 0;
    
    caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];

    // 原帖
	if(status.mcontent) {
        int fontNum = 19;
        
        CGSize textSize = [status.mcontent sizeWithFont:[UIFont systemFontOfSize:fontNum] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];

        status.textBounds = CGRectMake(WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, WEIBO_ZHENGWEN_WIDTH, textSize.height);
        
        
        if ([status.content rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
            textSize = [status.mcontent sizeWithFont:[UIFont systemFontOfSize:fontNum] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH - 60 - 12, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
            
            if (textSize.height < 60) {
                textSize.height = 60;
            }
  
            status.textBounds = CGRectMake(60 + 12 + WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, WEIBO_ZHENGWEN_WIDTH - 60 - 12, textSize.height);
        }
        
        status.cellHeight += WEIBO_ZHENGWEN_Y + textSize.height + WEIBO_LINESPACE;
	}
    
    // 转发帖
	if(status.orignalText) {

        NSString * orignalStr = @"";
        if (status.caiboType == CAIBO_TYPE_COMMENT) {
            orignalStr = status.orignalText;
        }else{
            orignalStr = status.mcontent_ref;
        }
        
        orignalStr = [NSString stringWithFormat:@"@%@:%@",status.nick_name_ref,orignalStr];
        
		CGSize textSize = [orignalStr sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];

        
        status.orignalTextBounds = CGRectMake(WEIBO_ZHENGWEN_X, status.cellHeight + WEIBO_YUANTIE_TOP, WEIBO_ZHENGWEN_WIDTH, textSize.height);
        
        if ([status.orignalText rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
            textSize = [orignalStr sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH - 60 - 12, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];

            
            if (textSize.height < 60) {
                textSize.height = 60;
            }
            
            status.orignalTextBounds = CGRectMake(60 + 12 + WEIBO_ZHENGWEN_X, status.cellHeight + WEIBO_YUANTIE_TOP, WEIBO_ZHENGWEN_WIDTH - 60 - 12, textSize.height);
        }
        
        status.cellHeight += WEIBO_YUANTIE_TOP * 2 + textSize.height;
	}
    
    // 预览图模式
    if ([delegate.readingMode isEqualToString:PREVIEW_MODEL]) {
        if (([status.attach_type isEqualToString:@"1"] && status.attach_small && [status.attach_small length] > 0 && [status.orignal_id isEqualToString:@"0"]) || ([status.attach_type_ref isEqualToString:@"1"] && status.attach_small_ref && [status.attach_small_ref length] > 0)) {
            status.hasImage = YES;
            if (status.orignalText) {
                status.cellHeight += WEIBO_IMAGE_MAX + WEIBO_YUANTIE_TOP;
            }else{
                status.cellHeight += WEIBO_IMAGE_MAX + WEIBO_LINESPACE;
            }
        } else {
            status.hasImage = NO;
        }
    } else {
        status.hasImage = NO;
    }
    
    if (status.caiboType == CAIBO_TYPE_COMMENT) {
        status.cellHeight += WEIBO_CELL_SPACE + 10;
        if (status.isAuto) {
            status.cellHeight += 10 + 30;
        }
    }else{
        status.cellHeight += WEIBO_BOTTOMBUTTON_HEIGHT + WEIBO_CELL_SPACE;
    }
    
    if (([status isFangan:status.attach_type]&&[status isZhiChiBiSai:status.lottery_id])||(([status isFangan:status.attach_type_ref]&&[status isZhiChiBiSai:status.lottery_id_ref]))) {
		status.cellHeight += 48;
	}
    
    return status.cellHeight;
}

-(float)getContentHeightWithText:(NSString *)text width:(float)width
{
    ColorLabel *label = [[ColorLabel alloc] initWithText:text hombol:YES];
    label.frame = CGRectMake(WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, width,20);
    while (label.isHidden) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[[NSDate date] dateByAddingTimeInterval:1]];
    }
    float height = [label getHtmlHeight];
    [label release];
    return height;
}

- (int)calcTextBounds
{
    cellHeight = 0;
    
    caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];
    
    if(mcontent) {
        
        mcontentHeight = [self getContentHeightWithText:self.content width:WEIBO_ZHENGWEN_WIDTH] + 10;
        
//        CGSize textSize = [mcontent sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];

//        textSize.height = mcontentHeight +10;
        self.textBounds = CGRectMake(WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, WEIBO_ZHENGWEN_WIDTH, mcontentHeight);
        
        if ([self.content rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
//            textSize = [self.mcontent sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH - 60 - 12, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
            
            mcontentHeight = [self getContentHeightWithText:self.content width:WEIBO_ZHENGWEN_WIDTH - 60 - 12] + 10;

            
            if (mcontentHeight < 60) {
                mcontentHeight = 60;
            }
            
            self.textBounds = CGRectMake(60 + 12 + WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, WEIBO_ZHENGWEN_WIDTH - 60 - 12, mcontentHeight);
        }
        self.cellHeight += WEIBO_ZHENGWEN_Y + mcontentHeight + WEIBO_LINESPACE;
    }
    
    // 转发帖
    if(orignalText) {
        NSString * orignalStr = @"";
        if (nick_name_ref && [nick_name_ref length]) {
            orignalStr = [NSString stringWithFormat:@"<a href=\"/goto/gotoMention.action?wd=%@\">@%@:</a>%@",nick_name_ref,nick_name_ref,orignalText];
        }else{
            orignalStr = orignalText;
        }

        mcontentRefHeight = [self getContentHeightWithText:orignalStr width:WEIBO_ZHENGWEN_WIDTH] + 10;
        
//        CGSize textSize = [mcontent_ref sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];

//        textSize.height = mcontentRefHeight+ 10;
        
        orignalTextBounds = CGRectMake(WEIBO_ZHENGWEN_X, cellHeight + WEIBO_YUANTIE_TOP, WEIBO_ZHENGWEN_WIDTH, mcontentRefHeight);
        
        if ([orignalText rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
//            textSize = [orignalStr sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(WEIBO_ZHENGWEN_WIDTH - 60 - 12, INT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
            
            mcontentRefHeight = [self getContentHeightWithText:orignalText width:WEIBO_ZHENGWEN_WIDTH - 60 - 12] + 10;

            
            if (mcontentRefHeight < 60) {
                mcontentRefHeight = 60;
            }
            
            orignalTextBounds = CGRectMake(60 + 12 + WEIBO_ZHENGWEN_X, cellHeight + WEIBO_YUANTIE_TOP, WEIBO_ZHENGWEN_WIDTH - 60 - 12, mcontentRefHeight);
        }
        
        cellHeight += WEIBO_YUANTIE_TOP * 2 + mcontentRefHeight;
        
    }
    
    if ([delegate.readingMode isEqualToString:PREVIEW_MODEL]) {
        if (([self.attach_type isEqualToString:@"1"] && attach_small && [attach_small length] > 0 && [orignal_id isEqualToString:@"0"]) || ([self.attach_type_ref isEqualToString:@"1"] && self.attach_small_ref && [self.attach_small_ref length] > 0)) {
            self.hasImage = YES;
            if (self.orignalText) {
                self.cellHeight += WEIBO_IMAGE_MAX + WEIBO_YUANTIE_TOP;
            }else{
                self.cellHeight += WEIBO_IMAGE_MAX + WEIBO_LINESPACE;
            }
        } else {
            self.hasImage = NO;
        }
    } else {
        self.hasImage = NO;
    }
    
    if (self.caiboType == CAIBO_TYPE_COMMENT) {
        self.cellHeight += WEIBO_CELL_SPACE + 10;
        if (self.isAuto) {
            self.cellHeight += 10 + 30;
        }
    }
    else{
        self.cellHeight += WEIBO_BOTTOMBUTTON_HEIGHT + WEIBO_CELL_SPACE;
    }
    
    if (([self isFangan:attach_type]&&[self isZhiChiBiSai:lottery_id])||(([self isFangan:self.attach_type_ref]&&[self isZhiChiBiSai:self.lottery_id_ref]))) {
        self.cellHeight += 48;
    }
    
    return self.cellHeight;
}

- (id)paserWithDictionary:(NSDictionary*)dic
{
	YtTopic *ytTopic = [[[YtTopic alloc] init] autorelease];
	if(dic)
    {
		ytTopic.region = [dic valueForKey:@"region"];
		ytTopic.site = [dic valueForKey:@"site"];
		ytTopic.attach_small = [dic valueForKey:@"attach_small"];
        
		ytTopic.topicid = [dic valueForKey:@"topicid"];
        if (!ytTopic.topicid) 
        {
            ytTopic.topicid = [dic valueForKey:@"id"]; //针对推送新闻字段不同解决方案
        }
        
        ytTopic.userid = [dic valueForKey:@"userid"];
        if (!ytTopic.userid) 
        {
            ytTopic.userid = [dic valueForKey:@"userId"]; //针对推送新闻字段不同解决方案
        }
        
		ytTopic.lottery_id = [dic valueForKey:@"lottery_id"];
		ytTopic.lottery_id_ref = [dic valueForKey:@"lottery_id_ref"];
		ytTopic.count_zf = [dic valueForKey:@"count_zf"];
        if (!ytTopic.count_zf || [ytTopic.count_zf length] <= 0) {
            ytTopic.count_zf = @"0";
        }
		ytTopic.mid_image = [dic valueForKey:@"mid_image"];
		if(![ytTopic.mid_image hasPrefix:@"http"])
        {
			NSMutableString *senderImage = [[NSMutableString alloc] init];
			[senderImage appendString:@"http://t.diyicai.com/"];
			[senderImage appendFormat:@"%@",ytTopic.mid_image];
			ytTopic.mid_image = senderImage;
			[senderImage release];
		}
		
		ytTopic.image = [dic valueForKey:@"image"];
		ytTopic.count_sc = [dic valueForKey:@"count_sc"];		
		ytTopic.date_created = [dic valueForKey:@"date_created"];		
		ytTopic.count_pl = [dic valueForKey:@"count_pl"];
        if (!ytTopic.count_pl || [ytTopic.count_pl length] <= 0) {
            ytTopic.count_pl = @"0";
        }
		ytTopic.city = [dic valueForKey:@"city"];		
		ytTopic.nick_name = [dic valueForKey:@"nick_name"];		
		ytTopic.nick_name = [ytTopic.nick_name nickName:ytTopic.userid];	
		ytTopic.vip = [dic valueForKey:@"vip"];
		ytTopic.content = [[[[dic valueForKey:@"content"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"》"] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        
        if (ytTopic.content && [ytTopic.content rangeOfString:@">http://caipiao365.com/faxq="].location !=NSNotFound) {
            NSArray * newContentArr = [ytTopic.content componentsSeparatedByString:@">http://caipiao365.com/faxq="];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                if ([newContentStr rangeOfString:@"http://caipiao365.com/faxq="].location != NSNotFound || i == newContentArr.count - 1) {
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
            ytTopic.content = finalString;
        }
        
        
        if (ytTopic.content && [ytTopic.content rangeOfString:@">http://cmwb.com/"].location !=NSNotFound) {
            NSArray * newContentArr = [ytTopic.content componentsSeparatedByString:@">http://cmwb.com/"];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                if ([newContentStr rangeOfString:@"<a href=\"http://"].location !=NSNotFound || i == newContentArr.count - 1) {
                    if (i == 0) {
                        newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                    }else if (i == newContentArr.count - 1) {
                        NSRange range = [newContentStr rangeOfString:@"</a>"];
                        newContentStr = [NSString stringWithFormat:@"链接%@",[newContentStr substringFromIndex:range.location]];
                    }else if ([newContentStr rangeOfString:@"</a>"].location !=NSNotFound) {
                        NSRange range = [newContentStr rangeOfString:@"</a>"];
                        newContentStr = [NSString stringWithFormat:@"链接%@>",[newContentStr substringFromIndex:range.location]];
                    }else{
                        newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                    }
                    
                    finalString = [finalString stringByAppendingString:newContentStr];
                }
            }
            ytTopic.content = finalString;
        }
        
        if (ytTopic.content && [ytTopic.content rangeOfString:@"]"].location !=NSNotFound) {
            NSArray * newContentArr = [ytTopic.content componentsSeparatedByString:@"]"];
            
            NSString * finalString = @"";
            
            for (int i = 0; i < newContentArr.count; i++) {
                NSString * newContentStr = @"";
                newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                
                NSRange range = [newContentStr rangeOfString:@"["];
                if (range.location != NSNotFound) {
                    NSString * faceStr = [[newContentStr substringFromIndex:range.location + 1] stringToFace];
                    UIImage * faceImage = [UIImage imageNamed:faceStr];
                    
                    if (faceImage) {
                        newContentStr = [NSString stringWithFormat:@"%@<img src=\"http://t.diyicai.com/style/images/faces/%@.gif\"/>",[newContentStr substringToIndex:range.location],faceStr];
                    }else{
                        if (i == newContentArr.count - 1) {
                            if ([ytTopic.content hasSuffix:@"]"]) {
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
            ytTopic.content = finalString;
        }

		ytTopic.type = [[dic valueForKey:@"type"] stringValue];
		ytTopic.oriDelFlag = [dic objectForKey:@"oriDelFlag"];
		
		if ([ytTopic.type isEqualToString:@"0"]&&!ytTopic.content) 
        {
			ytTopic.content = [[[[dic valueForKey:@"rec_content"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"》"] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
		}
		if (ytTopic.content) 
        {
			ytTopic.mcontent = [ytTopic.content flattenPartHTML:ytTopic.content];
            ytTopic.colorcontentl = [ytTopic.content flattenColorPartHTML:ytTopic.content];
		}
		ytTopic.timeformate = [dic valueForKey:@"timeformate"];
        if (!ytTopic.timeformate || [ytTopic.timeformate length] <= 0) {
            ytTopic.timeformate = @"18-20 02:40";
        }
		ytTopic.attach = [dic valueForKey:@"attach"];
		ytTopic.orignal_id = [dic valueForKey:@"orignal_id"];
        if (!ytTopic.orignal_id || [ytTopic.orignal_id length] <= 0) {
            ytTopic.orignal_id = @"0";
        }
		
		if (ytTopic.orignal_id &&![ytTopic.orignal_id  isEqualToString:@"0"]) 
        {
			ytTopic.nick_name_ref = [dic valueForKey:@"nick_name_ref"];
			ytTopic.content_ref = [[[[dic valueForKey:@"content_ref"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"》"]stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];	
			
			if ([[dic objectForKey:@"oriDelFlag"]intValue] == 2) {
                ytTopic.content_ref = [dic objectForKey:@"oriDelMsg"];
            }
            else {
                ytTopic.attach_type_ref = [dic valueForKey:@"attach_type_ref"];
                ytTopic.attach_small_ref = [dic valueForKey:@"attach_small_ref"];
                ytTopic.attach_ref = [dic valueForKey:@"attach_ref"];
            }
		
			if(ytTopic.content_ref)
            {
                if (ytTopic.content_ref && [ytTopic.content_ref rangeOfString:@">http://caipiao365.com/faxq="].location !=NSNotFound) {
                    NSArray * newContentArr = [ytTopic.content_ref componentsSeparatedByString:@">http://caipiao365.com/faxq="];
                    
                    NSString * finalString = @"";
                    
                    for (int i = 0; i < newContentArr.count; i++) {
                        NSString * newContentStr = @"";
                        newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                        
                        if ([newContentStr rangeOfString:@"http://caipiao365.com/faxq="].location != NSNotFound || i == newContentArr.count - 1) {
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
                    ytTopic.content_ref = finalString;
                }
                
                
                if (ytTopic.content_ref && [ytTopic.content_ref rangeOfString:@">http://cmwb.com/"].location !=NSNotFound) {
                    NSArray * newContentArr = [ytTopic.content_ref componentsSeparatedByString:@">http://cmwb.com/"];
                    
                    NSString * finalString = @"";
                    
                    for (int i = 0; i < newContentArr.count; i++) {
                        NSString * newContentStr = @"";
                        newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                        
                        if ([newContentStr rangeOfString:@"<a href=\"http://"].location !=NSNotFound || i == newContentArr.count - 1) {
                            if (i == 0) {
                                newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                            }else if (i == newContentArr.count - 1) {
                                NSRange range = [newContentStr rangeOfString:@"</a>"];
                                newContentStr = [NSString stringWithFormat:@"链接%@",[newContentStr substringFromIndex:range.location]];
                            }else if ([newContentStr rangeOfString:@"</a>"].location !=NSNotFound) {
                                NSRange range = [newContentStr rangeOfString:@"</a>"];
                                newContentStr = [NSString stringWithFormat:@"链接%@>",[newContentStr substringFromIndex:range.location]];
                            }else{
                                newContentStr = [NSString stringWithFormat:@"%@>",newContentStr];
                            }
                            
                            finalString = [finalString stringByAppendingString:newContentStr];
                        }
                    }
                    ytTopic.content_ref = finalString;
                }
                
                if (ytTopic.content_ref && [ytTopic.content_ref rangeOfString:@"]"].location !=NSNotFound) {
                    NSArray * newContentArr = [ytTopic.content_ref componentsSeparatedByString:@"]"];
                    
                    NSString * finalString = @"";
                    
                    for (int i = 0; i < newContentArr.count; i++) {
                        NSString * newContentStr = @"";
                        newContentStr = [newContentStr stringByAppendingString:[newContentArr objectAtIndex:i]];
                        
                        NSRange range = [newContentStr rangeOfString:@"["];
                        if (range.location != NSNotFound) {
                            NSString * faceStr = [[newContentStr substringFromIndex:range.location + 1] stringToFace];
                            UIImage * faceImage = [UIImage imageNamed:faceStr];
                            
                            if (faceImage) {
                                newContentStr = [NSString stringWithFormat:@"%@<img src=\"http://t.diyicai.com/style/images/faces/%@.gif\"/>",[newContentStr substringToIndex:range.location],faceStr];
                            }else{
                                if (i == newContentArr.count - 1) {
                                    if ([ytTopic.content_ref hasSuffix:@"]"]) {
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
                    ytTopic.content_ref = finalString;
                }
                
				NSString * text = @"";
				if (ytTopic.nick_name_ref) {
                    text = [NSString stringWithFormat:@"<a href=\"/goto/gotoMention.action?wd=%@\">@%@:</a>",ytTopic.nick_name_ref,ytTopic.nick_name_ref];
				}
                text = [text stringByAppendingString:ytTopic.content_ref];
				ytTopic.orignalText = [text copy];

                if (ytTopic.content_ref)
                {
                    ytTopic.mcontent_ref = [ytTopic.content_ref flattenPartHTML:ytTopic.content_ref];
                    ytTopic.colorcontent_ref = [ytTopic.content_ref flattenColorPartHTML:ytTopic.content_ref];
                }
            }
		}
		ytTopic.project_id = [dic valueForKey:@"project_id"];
		ytTopic.province = [dic valueForKey:@"province"];
		ytTopic.sma_image = [dic valueForKey:@"sma_image"];
		ytTopic.is_attention = [dic valueForKey:@"is_attention"];
		ytTopic.attach_type = [dic valueForKey:@"attach_type"];
		ytTopic.source = [dic valueForKey:@"source"];
        if (!ytTopic.source || [ytTopic.source length] <= 0) {
            ytTopic.source = @"来自第一彩博";
        } else {
            ytTopic.source = [@"来自" stringByAppendingString:ytTopic.source];
        }
        
        ytTopic.count_zf_ref = [dic valueForKey:@"count_zf_ref"];
        if (!ytTopic.count_zf_ref || [ytTopic.count_zf_ref length] <= 0) {
            ytTopic.count_zf_ref = @"0";
        }
        ytTopic.count_pl_ref = [dic valueForKey:@"count_pl_ref"];
        if (!ytTopic.count_pl_ref || [ytTopic.count_pl_ref length] <= 0) {
            ytTopic.count_pl_ref = @"0";
        }
        ytTopic.isCc = [dic valueForKey:@"isCc"];
	
        
        ytTopic.caiboType = CAIBO_TYPE_HOME;
        ytTopic.isNewComond = NO;
//        [self calcTextBounds:ytTopic];
//            NSLog(@"dic = %@", dic);
        
        ytTopic.blogtype = [dic valueForKey:@"blogtype"];
        ytTopic.blogCount = [dic valueForKey:@"blogCount"];
//        ytTopic.topicid
        
        
        if ([[[Info getInstance] userId] intValue] == 0) {
            ytTopic.count_dz = [dic valueForKey:@"count_dz"];
            ytTopic.praisestate = [dic valueForKey:@"praisestate"];
        }else{
            NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
            
            if ([weiBoLikeDic valueForKey:ytTopic.topicid]) {
                ytTopic.count_dz = [[weiBoLikeDic valueForKey:ytTopic.topicid] objectAtIndex:0];
                ytTopic.praisestate = [[weiBoLikeDic valueForKey:ytTopic.topicid] objectAtIndex:1];
                
            }else{
                ytTopic.count_dz = [dic valueForKey:@"count_dz"];
                ytTopic.praisestate = [dic valueForKey:@"praisestate"];
                
                if (ytTopic.count_dz) {
                    [weiBoLikeDic setObject:@[ytTopic.count_dz,ytTopic.praisestate] forKey:ytTopic.topicid];
                    [[NSUserDefaults standardUserDefaults] setValue:weiBoLikeDic forKey:@"weiBoLike"];
                }
            }
        }
	}
    [ytTopic calcTextBounds];
	return ytTopic;
}


-(void) dealloc 
{
    [newstitle release];
    [arrayList release];
	[region release];
	[site release];
	[attach_small release];
	[topicid release];
	[lottery_id release];
	[count_zf release];
	[userid release];
	[mid_image release];
	[image release];
	[count_sc release];
	[date_created release];
	[count_pl release];
	[city release];
	[nick_name release];
	[vip release];
	[content release];
	[timeformate release];
	[attach release];
	[orignal_id release];
	[project_id release];
	[province release];
	[sma_image release];
	[is_attention release];
	[attach_type release];
	[source release];
    [count_zf_ref release];
    [count_pl_ref release];
	[type release];
    [content_ref release];
    [nick_name_ref release];
	[orignalText release];
	[mcontent release];
	[mcontent_ref release];
    [isCc release];
    [attach_ref release];
    [attach_type_ref release];
    [attach_small_ref release];
    [blogtype release];
    [blogCount release];
    [indexPath release];
    
	[super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
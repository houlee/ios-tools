//
//  HotYtThemeViewController.h
//  caibo
//
//  Created by jacob on 11-6-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MoreLoadCell.h"

@class ASIHTTPRequest;

@interface HotYtThemeViewController : UITableViewController {
	
	
	ASIHTTPRequest *request;
	
	NSMutableArray *hotYtThemeListarry;
	
	MoreLoadCell *moreCell;
	
	NSInteger topicLoadCount;
	
	BOOL fristLoading;
	
	BOOL topicLoadedEnd;

}

@property (nonatomic,retain) NSMutableArray *hotYtThemeListarry;

@property(nonatomic,retain)ASIHTTPRequest *request;


// 计算 点击 “更多 ”次数
-(NSString*)loadedCount;

@end

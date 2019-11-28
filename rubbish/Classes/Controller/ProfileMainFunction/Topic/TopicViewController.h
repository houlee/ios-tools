//
//  TopicViewController.h
//  caibo
//
//  Created by jacob on 11-6-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@class ASIHTTPRequest;

// 用户 话题列表 界面 需要传入 userId

@interface TopicViewController : CPViewController<UITableViewDataSource, UITableViewDelegate>
{
	ASIHTTPRequest *request;
    NSMutableArray *themeVec;
    BOOL result;
    NSString *userID;
    UITableView * myTableview;
}

@property (nonatomic,retain)NSMutableArray *themeVec;
@property (nonatomic,retain)NSString *userID;
@property (nonatomic,retain)ASIHTTPRequest *request;

@end

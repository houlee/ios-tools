//
//  CPThreeMyDataViewController.h
//  caibo
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "ASIHTTPRequest.h"

@interface CPThreeMyDataViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView * myTabelView;
    ASIHTTPRequest *request;
}
//@property(nonatomic, retain) UserInfo *mUserInfo;
@property (nonatomic,retain)ASIHTTPRequest *request;
-(void)sendCommentListRequest:(NSString*)pageNum pageSize:(NSString*)pigeSize;
@end

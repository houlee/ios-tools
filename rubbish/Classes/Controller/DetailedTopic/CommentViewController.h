//
//  CommentViewController.h
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
#import "ASIHTTPRequestDelegate.h"
#import "YtTopic.h"
#import "LoadCell.h"
#import "MoreLoadCell.h"
#import "ProgressBar.h"

@interface CommentViewController : UITableViewController <CBRefreshTableHeaderDelegate, ASIHTTPRequestDelegate, UIActionSheetDelegate ,PrograssBarBtnDelegate> {
    CBRefreshTableHeaderView *mRefreshView;
    BOOL mReloading;// 是否正在更新数据
    
    YtTopic *mStatus;
    NSMutableArray *mCommentArray;
    int mSection;// 当前选中的位置
    
    ASIHTTPRequest *mRequest;
    
    int index;
    MoreLoadCell *moreCell;
    LoadCell *loadCell;
    
    CGFloat autoHeight;
}

@property (nonatomic,retain) YtTopic *mStatus;
@property (nonatomic,retain) ASIHTTPRequest *mRequest;
@property (nonatomic,retain) NSMutableArray *mCommentArray;
@property (nonatomic,assign) CGFloat autoHeight;
- (id) initWithMessage : (YtTopic *) message;

@end
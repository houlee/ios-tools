//
//  评论列表界面
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FolloweeCellView.h"
#import "TopicComment.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
@interface CommentView : FolloweeCellView<ASIHTTPRequestDelegate, CP_UIAlertViewDelegate> {
    TopicComment *mComment;
    ASIHTTPRequest *myRequest;
    NSString * passWord;
    NSMutableArray *mutableArray;
}

@property(nonatomic, retain) TopicComment *mComment;
@property(nonatomic, retain) ASIHTTPRequest *myRequest;
@property (nonatomic, retain)NSString * passWord;
@property (nonatomic, retain)NSMutableArray *mutableArray;
@end
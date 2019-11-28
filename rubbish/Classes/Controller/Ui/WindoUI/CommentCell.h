//
//  CommentCell.h
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
#import "TopicComment.h"

@interface CommentCell : UITableViewCell <UIActionSheetDelegate>{
    CommentView *cellView;
    UIImageView * xian;
    BOOL isAutoReport; //是否为自动回复
    UIImageView *grayView;
}
@property (nonatomic, assign) BOOL isAutoReport;
- (void) setComment : (TopicComment *) comment;

@end
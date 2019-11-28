//
//  HomeCell.h
//  caibo
//
//  Created by jacob on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailedView.h"
#import "ProfileImageCell.h"
#import "YtTopic.h"
//#import "BubbleView.h"
@class HomeCell;

@protocol HomeCellDelegate <NSObject>

-(void)touchHomeCellBottomButton:(UIButton *)bottomButton homeCell:(HomeCell *)homeCell ytTopic:(YtTopic *)ytTopic;

-(void)touchColorViewByYtTopic:(YtTopic *)ytTopic;

@end

@interface HomeCell : ProfileImageCell <UIActionSheetDelegate,HomeDetailedViewDelegate>{
    YtTopic *status;
//    BubbleView *bubble;
	HomeDetailedView * detailedView;
	//UIImageView *pImageView;
    UIImageView *xian;//线
    BOOL ishome;
    
    UIImageView *grayView;
    
    UIView * bottomView;//转 评 赞
    
    id <HomeCellDelegate> homeCellDelegate;
}

@property(nonatomic,assign)id <HomeCellDelegate> homeCellDelegate;

@property (nonatomic, retain) YtTopic *status;
//@property (nonatomic, retain) UIImageView *pImageView;
@property (nonatomic, assign)BOOL ishome;
@property (nonatomic, retain)UIImageView *xian;
- (void) update : (UITableView *)tableView;

@end
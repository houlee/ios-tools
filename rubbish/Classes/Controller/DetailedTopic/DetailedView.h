//
//  帖子详细信息界面
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"
#import "YtTopic.h"
#import "ColorLabel.h"
#import "ForwardView.h"
#import "ASIHTTPRequest.h"
#import "GifView.h"
#import "CP_UIAlertView.h"

@protocol DetailedViewDelegate
@optional
- (void)showSegmentOneAction;
- (void)showSegmentTwoAction;
- (void)reloadDataView:(UIView *)view;
- (void)returnYtTopic:(YtTopic *)sstatuss;
- (void)zhengwenyttopic:(YtTopic *)stat;


@end


@interface DetailedView : UIView<ASIHTTPRequestDelegate,ColorLabelDelegate, ForwardViewDelegate, CP_UIAlertViewDelegate> {
    NSString *imageUrl;
    ImageStoreReceiver *receiver;
    
    YtTopic *mStatus;
	ASIHTTPRequest *request;
    ASIHTTPRequest *guanliRequest;
    
    UIButton *mForwardBtn;
    UIButton *mCommentBtn;
    UIButton *mImageViewBtn;
    GifView *gifView;
    
	UIButton *matchVSBtn;
    
    ForwardView *mForwardView;
    UISegmentedControl *segmentedControl;
	id <DetailedViewDelegate> detaildelegate;
    BOOL homebool;
	UIImageView *jinduImage;
    UIButton *bentieButton;
    UIButton *yuantieButton;
    UILabel *yuantieLabel;
    UILabel *bentieLabel;
    UIImageView *xian;
    UIImageView *line2;
    UIView *SegmentView;
    NSString * passWord;
}
@property (nonatomic, assign)BOOL homebool;
@property (nonatomic, assign) id <DetailedViewDelegate> detaildelegate;
@property (nonatomic, retain) YtTopic *mStatus;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) ASIHTTPRequest *request,*guanliRequest;
@property (nonatomic, retain)NSString * passWord;
//- (id) initWithMessage : (YtTopic *) message;
- (void) actionShowPhoto : (id) sender;
- (void) actionRefresh : (YtTopic *) status;
- (void)returnYtTopic:(YtTopic *)sstatuss;
- (void)zhengwenyttopic:(YtTopic *)stat;
- (id) initWithMessage:(YtTopic *)message homebol:(BOOL)hobol;

@end
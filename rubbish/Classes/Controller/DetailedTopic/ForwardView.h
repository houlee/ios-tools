//
//  帖子详情列表原帖视图
//  caibo
//
//  Created by jeff.pluto on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YtTopic.h"
#import "ColorLabel.h"
#import "ImageStoreReceiver.h"
#import "ASIHTTPRequest.h"
#import "GifView.h"

@protocol ForwardViewDelegate <NSObject>

- (void)returnYtTopicData:(YtTopic *)yttopic;
@end


@interface ForwardView : UIView<ColorLabelDelegate> {
    NSString *imageUrl;
    ImageStoreReceiver *receiver;
    
    YtTopic *mStatus;
    UIButton *mImageViewBtn;
    GifView *gifView;
    
    UIButton *mForwardBtn;
    UIButton *mCommentBtn;
    UIButton * butfor;
    id<ForwardViewDelegate>delegatea;
    BOOL homebool;
    ASIHTTPRequest * mRequest;
    UIImageView *jinduImage;

}
@property (nonatomic, assign)BOOL homebool;
@property (nonatomic, retain)UIButton * butfor;
@property (nonatomic, retain) YtTopic *mStatus;
@property (nonatomic, retain)ASIHTTPRequest * mRequest;
@property (nonatomic, assign)id<ForwardViewDelegate>delegatea;
- (id) initWithMessage : (YtTopic *) message;
- (void) actionRefresh : (YtTopic *) status;
- (void)returnYtTopicData:(YtTopic *)yttopic;
- (id)initWithMessage:(YtTopic *)message homebol:(BOOL)hobol;
//- (id) initWithMessage:(YtTopic *)message;

@end
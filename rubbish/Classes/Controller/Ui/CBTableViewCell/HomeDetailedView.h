//
//  HomeDetailedView.h
//  caibo
//
//  Created by jacob on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "YtTopic.h"
#import "ProfileImageCell.h"
#import "CP_PopupView.h"
#import "ChatView.h"

@protocol HomeDetailedViewDelegate <NSObject>

-(void)touchWebViewByYtTopic:(YtTopic *)ytTopic;

@end

@interface HomeDetailedView : UIView<ColorLabelDelegate>
{
	YtTopic *status;
    
    // 微博图片
    UIImage  *caiboImage;
    UIButton *caiboImageBtn;
    NSString *imageUrl;
    ImageStoreReceiver *receiver;
    
    //原贴内容背景图片
//    UIImageView *ytImage;
    
    UILabel *contentLabel;
//    ColorLabel *orignalText;
    CP_PopupView *imageView;
//    ChatView *contentView;
	
	UIButton *matchVSBtn;
    id <HomeDetailedViewDelegate> delegate;
    
}

@property(nonatomic,assign)id <HomeDetailedViewDelegate> delegate;

@property(nonatomic, retain) YtTopic *status;
@property(nonatomic, retain) UIImage *caiboImage;
//@property(nonatomic, retain) ChatView *contentView;
@property(nonatomic, retain) UIButton *matchVSBtn;

@end
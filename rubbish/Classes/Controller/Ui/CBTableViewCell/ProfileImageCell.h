//
//  ProfileImageCell.h
//  caibo
//
//  Created by jacob on 11-6-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"

#define IMAGE_WIDTH 40.0// 头像 宽度
#define IMAGE_HEIGTH 40.0// 头像 高度
#define TOP  30
#define LEFT 5.0
#define CELL_WIDTH (320 - IMAGE_WIDTH - LEFT * 3 - 71)
#define CELL_WIDTH_PAD (390 - IMAGE_WIDTH - LEFT * 3 - 71)
#define NICKMAME_WIDTH 150.0
#define TEXT_HEIRTH 20.0
#define MESSAGE_LINEBREAKWIDTH 230.0 // 微博正文 默认 分段 宽度
#define ORIGINALTOPICTEXT_LINEBREAKWIDTH 250.0 // 原帖 分段 默认 宽度

@interface ProfileImageCell : UITableViewCell {
    NSString            *imageUrl;
    ImageStoreReceiver  *receiver;
    UIButton            *imageButton;
	UIImageView *pImageView;
}

@property (nonatomic, readonly) UIButton *imageButton;
@property (nonatomic, retain) UIImageView *pImageView;

- (void) fetchProfileImage:(NSString *)url;

@end
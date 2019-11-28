//
//  PopupView.h
//  caibo
//
//  Created by jeff.pluto on 11-8-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"

@interface CP_PopupView : UIView {
    NSString *imageUrl;
    ImageStoreReceiver *receiver;
    UIImageView *imageView;
    BOOL IsGif;
    NSString *bigImageURL;
}

- (id) initWithUrl : (NSString *) url;
- (void) setImage : (UIImage *) image;
- (void) show;
- (void) dismiss;
@property (nonatomic)BOOL IsGif;
@property (nonatomic,copy)NSString *bigImageURL;

@end
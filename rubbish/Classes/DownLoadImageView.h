//
//  DownLoadImageView.h
//  caibo
//
//  Created by yao on 12-5-3.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"

@interface DownLoadImageView : UIImageView {
	ImageStoreReceiver *reciver;
    NSString *_imageURL;
}
@property (nonatomic,copy)NSString *imageURL;


- (void)setImageWithURL:(NSString *)imageURL; 
- (void)setImageWithURL:(NSString *)imageURL DefautImage:(UIImage *)image1;



@end

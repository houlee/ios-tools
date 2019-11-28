//
//  MicroblogPictureViewController.h
//  caibo
//
//  Created by houchenguang on 14-10-31.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@interface MicroblogPictureViewController : CPViewController{

    UIImage * selectImage;
    UIImageView * pictureImageView;
    BOOL showBool;
    id delegate;

}

@property (nonatomic, retain)UIImage * selectImage;
@property (nonatomic, assign)id delegate;


@end


@protocol MicroblogPictureDelegate

- (void)microblogPictureDelegateFunc;


@end
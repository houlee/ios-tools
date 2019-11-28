//
//  CPPhotoView.h
//  caibo
//
//  Created by houchenguang on 14-11-13.
//
//

#import <UIKit/UIKit.h>

@interface CPPhotoView : UIView<UIScrollViewDelegate>{

    UIScrollView * myScrollerView;
    UIImageView * myImageView;

}
- (id)initWithUrl:(NSURL *)photoURL;
@end

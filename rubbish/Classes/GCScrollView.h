//
//  GCScrollView.h
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import <UIKit/UIKit.h>

@protocol GCScrollViewDelegate <NSObject>
@optional
- (void)touchesBeganFunc;
-(void)btnTouchesBegan;
-(void)btnTouchesCancel;
@end

@interface GCScrollView : UIScrollView{
    id<GCScrollViewDelegate>delegatea;
}

@property (nonatomic, assign)id<GCScrollViewDelegate>delegatea;


@end

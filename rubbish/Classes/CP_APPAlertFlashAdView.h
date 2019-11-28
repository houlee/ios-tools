//
//  CP_APPAlertFlashAdView.h
//  caibo
//
//  Created by cp365dev on 14-5-27.
//
//

#import <UIKit/UIKit.h>

@interface CP_APPAlertFlashAdView : UIView
{
    UIView *grayView;

    id delegate;
}

@property (nonatomic, assign) id delegate;
- (id)initWithFrame:(CGRect)frame andFlashAdImage:(UIImage *)image;
@end

@protocol CP_AppAlertFlashViewDelegate

-(void)clickAppAlertFlashAdViewDelegate;

@end
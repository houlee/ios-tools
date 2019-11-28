//
//  CP_HiddenAlertView.h
//  caibo
//
//  Created by cp365dev on 14-5-23.
//
//

#import <UIKit/UIKit.h>

@interface CP_HiddenAlertView : UIView
{
    UIView *grayView;
    
    NSString *mTitle;
    NSString *mImageName;
    NSString *mMessage;
    NSString *mEndMessage;
    
    id delegate;
    
    BOOL isCanBack;
    
    BOOL alreadyPress; //已经点击灰色背景后，不调用自动隐藏
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mImageName;
@property (nonatomic, retain) NSString *mMessage;
@property (nonatomic, retain) NSString *mEndMessage;

-(id)initWithTitle:(NSString *)title delegate:(id)delegates andTitleImage:(NSString *)imageName andMessage:(NSString *)message andEndMessage:(NSString *)endMessage;

-(void)showAndHiddenAfter:(NSTimeInterval)time isBack:(BOOL)isback;


@end
@protocol CP_HiddenAlertViewDelegate

-(void)disMissCP_HiddenAlertAndIsAutoBack:(BOOL)isback;

@end
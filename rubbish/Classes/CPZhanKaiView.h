//
//  CPZhanKaiView.h
//  caibo
//
//  Created by yaofuyu on 13-1-17.
//
//

#import <UIKit/UIKit.h>

@class CPZhanKaiView;

@protocol CPZhanKaiViewDelegate

@optional
- (void)ZhankaiViewClicke:(CPZhanKaiView *)_zhankaiView;

@end

@interface CPZhanKaiView : UIView {
    id _zhankaiDelegate;
    CGFloat _normalHeight;
    CGFloat _zhankaiHeight;
    BOOL _isOpen;
    UIImageView *_fengeImageView;
    BOOL _canZhanKaiByTouch;
}

@property (nonatomic,assign)id zhankaiDelegate;
@property (nonatomic)CGFloat normalHeight;
@property (nonatomic)CGFloat zhankaiHeight;
@property (nonatomic)BOOL isOpen,canZhanKaiByTouch;
@property (nonatomic,retain)UIImageView *fengeImageView;

- (void)openByTouch;

@end

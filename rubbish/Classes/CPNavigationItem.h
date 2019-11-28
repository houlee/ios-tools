//
//  CPNavigationItem.h
//  caibo
//
//  Created by yaofuyu on 12-12-12.
//
//

#import <UIKit/UIKit.h>

@interface CPNavigationItem : UIImageView {
    NSString *_title;
    UIView   *_titleView;
    BOOL hidesBackButton;
    UIBarButtonItem *_leftBarButtonItem;
    UIBarButtonItem *_rightBarButtonItem;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UILabel *_titleLabel;
}

@property(nonatomic,copy)   NSString        *title;             // Title when topmost on the stack. default is nil
@property(nonatomic,retain) UIView          *titleView;         // Custom view to use in lieu of a title. May be sized horizontally. Only used when item is topmost on the stack.

@property(nonatomic,assign) BOOL hidesBackButton; // If YES, this navigation item will hide the back button when it's on top of the stack.

@property(nonatomic,retain) UIBarButtonItem *leftBarButtonItem;
@property(nonatomic,retain) UIBarButtonItem *rightBarButtonItem;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain) UIImageView * barImage;
@property(nonatomic,retain)UIView *lineView;
- (void)markNavigationViewUserName:(NSString *)name;//添加标记
- (void)clearMarkLabel;//消除标记
- (void)changeRightTo:(CGRect)rect;//改右边的按钮
- (void)changeleftTo:(CGRect)rect;//改左边的按钮
@end

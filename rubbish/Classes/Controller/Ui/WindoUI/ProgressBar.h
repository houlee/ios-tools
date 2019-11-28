//
//  发布微博时底部状态条
//  caibo
//
//  Created by jeff.pluto on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PrograssBarBtnDelegate;

@protocol PrograssBarBtnDelegate <NSObject>

@optional

- (void)prograssBarBtnDeleate:(NSInteger) type;

@end


@interface ProgressBar : UIActionSheet {
    UIButton *mCancel;
    UIActivityIndicatorView *mRefreshBar;
    
    id<PrograssBarBtnDelegate> mDelegate;
}

@property (nonatomic,readonly) UIActivityIndicatorView *mRefreshBar;

@property(nonatomic,assign) id<PrograssBarBtnDelegate> mDelegate;

+ (ProgressBar *) getProgressBar;

- (void) show : (NSString *)text view : (UIView *) view;

- (void) show : (NSString *)text view : (UIView *) view delegate:(BOOL) isDelegate;


- (void) dismiss;
-(IBAction) doCancel:(id) sender;

@end
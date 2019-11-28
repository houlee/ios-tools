//
//  EditText.h
//  caibo
//
//  Created by jeff.pluto on 11-7-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowingTextView.h"
#import "CP_PTButton.h"

@protocol CBKeyBoardShowDelegate;

@interface EditText : UIImageView{
    UIButton *showFaceBtn;
    CP_PTButton *sendBtn;
    UIButton *mDeleteText;
    GrowingTextView *editText;
    UIImageView *nrImage;
    
    id _delegate;
}

@property (nonatomic, readonly) UIButton *showFaceBtn;
@property (nonatomic, readonly) UIButton *sendBtn;
@property (nonatomic, readonly) UIButton *mDeleteText;
@property (nonatomic, readonly) GrowingTextView *editText;

@property (nonatomic, assign) id<CBKeyBoardShowDelegate> delegate;

- (void) setContentOffset : (CGPoint) offset;
- (void) resumeDefaultAndKeyBoardIsShow : (BOOL) isShow;

@end

@protocol CBKeyBoardShowDelegate

@optional
- (void) keyBoardShow;
- (void) keyBoardDismiss;
@end
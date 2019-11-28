//
//  InputViewController.h
//  caibo
//
//  Created by Kiefer on 11-6-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol PassValueDelegate <NSObject>
@optional

- (void)passValue:(NSInteger)typeId Value:(NSString*)value;

@end

@interface InputViewController : UIViewController <PassValueDelegate, UIActionSheetDelegate, UITextViewDelegate>
{
    UITextView *inputText;
    UILabel *lbTextNum;
    UIButton *btnClear;
    
    NSObject<PassValueDelegate> *delegate;
}

@property(nonatomic, retain) UITextView *inputText;
@property(nonatomic, retain) UILabel *lbTextNum;
@property(nonatomic, retain) UIButton *btnClear;
@property(nonatomic, assign) NSObject<PassValueDelegate> *delegate;

// 初始化
- (id)initWithText:(NSString *)text;
// 返回上级界面
- (void)doBack;
// 存储
- (void)doSave;
// 清除
- (void)doClear;

@end



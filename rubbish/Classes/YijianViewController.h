//
//  YijianViewController.h
//  caibo
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface YijianViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate, UITextViewDelegate>{
    UITextView * textview;
    UIView * baview;
    UITextField * textmail;
    UITextField * textmobile;
    BOOL keybool;
    ASIHTTPRequest * request;
    UILabel * textnum;
    UIButton * bgbutton;
    UIBarButtonItem *rightItem;
    NSInteger hightsi;
}
@property (nonatomic, retain)ASIHTTPRequest * request;
- (void) changeTextCount : (NSString *) text;
//- (void)textViewDidChange:(UITextView *)textView;
- (BOOL)doCheckMailNum;
- (void)requestFasong;
@end

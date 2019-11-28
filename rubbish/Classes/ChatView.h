//
//  ChatView.h
//  caibo
//
//  Created by Yinrongbin on 11-12-30.
//  Copyright (c) 2011年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatView : UIView
{
    NSString *_text;
    NSMutableArray *_emojis;
    NSString * strstring ;
    BOOL kaijbool;
    UIColor *_textColor;
    UIColor *_changeColor;
}

@property (nonatomic, retain) NSMutableArray *emojis;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign)BOOL kaijbool;
@property (nonatomic, retain)UIColor *textColor;
@property (nonatomic, retain)UIColor *changeColor;

@end

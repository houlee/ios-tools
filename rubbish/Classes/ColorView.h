//
//  ColorView.h
//  caibo
//
//  Created by  on 12-6-14.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorView : UIView
{
    NSString *_text;
    NSMutableArray *_emojis;
    NSString * strstring ;
	UIFont *_font;// 字体
	UIColor *_textColor;//字体颜色
	UIColor *_changeColor;//改变字体的颜色
	UIFont *_colorfont; //变色字体
    NSTextAlignment textAlignment;
    CGFloat _pianyiHeight;//第一行距离上边界的距离，（指的是默认字体，变色字体距离不定）
    CGFloat _jianjuHeight;//默认间距
    CGFloat _wordWith;
    NSString *_huanString;//换行符单个字母;
    CGFloat pianyiy;//变色变大后的字 偏移值
    CGFloat textSumWith;//总共字体宽度 包含变色字体
    
    BOOL isN;
}
@property (nonatomic, assign)NSTextAlignment textAlignment;
@property (nonatomic, retain) NSMutableArray *emojis;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain)UIColor *textColor;
@property (nonatomic, retain)UIColor *changeColor;
@property(nonatomic,retain) UIFont    *font;
@property (nonatomic,retain)UIFont *colorfont;
@property (nonatomic,retain)NSString *huanString;
@property (nonatomic)CGFloat pianyiHeight;
@property (nonatomic)CGFloat jianjuHeight;
@property (nonatomic)CGFloat wordWith, pianyiy, textSumWith;
@property (nonatomic,assign)BOOL isN;
@end

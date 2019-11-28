//
//  GrowingTextView.h
//  caibo
//
//  Created by jeff.pluto on 11-7-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GrowingTextView;
@class TextViewInternal;

@protocol GrowingTextViewDelegate

@optional
- (BOOL)growingTextViewShouldBeginEditing:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldEndEditing:(GrowingTextView *)growingTextView;

- (void)growingTextViewDidBeginEditing:(GrowingTextView *)growingTextView;
- (void)growingTextViewDidEndEditing:(GrowingTextView *)growingTextView;

- (BOOL)growingTextView:(GrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)growingTextViewDidChange:(GrowingTextView *)growingTextView;

- (void)growingTextView:(GrowingTextView *)growingTextView willChangeHeight:(float)height;
- (void)growingTextView:(GrowingTextView *)growingTextView didChangeHeight:(float)height;

- (void)growingTextViewDidChangeSelection:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldReturn:(GrowingTextView *)growingTextView;
@end

@interface GrowingTextView : UIView <UITextViewDelegate> {
	TextViewInternal *internalTextView;	
	
	int minHeight;
	int maxHeight;
	
	int maxNumberOfLines;
	int minNumberOfLines;
	
	BOOL animateHeightChange;
	
	NSObject <GrowingTextViewDelegate> *delegate;
	NSString *text;
	UIFont *font;
	UIColor *textColor;
	NSTextAlignment textAlignment;
	NSRange selectedRange;
	BOOL editable;
	UIDataDetectorTypes dataDetectorTypes;
	UIReturnKeyType returnKeyType;
}

@property int maxNumberOfLines;
@property int minNumberOfLines;
@property BOOL animateHeightChange;
@property (retain) UITextView *internalTextView;	

@property(assign) NSObject<GrowingTextViewDelegate> *delegate;
@property(nonatomic,assign) NSString *text;
@property(nonatomic,assign) UIFont *font;
@property(nonatomic,assign) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) NSRange selectedRange;
@property(nonatomic,getter=isEditable) BOOL editable;
@property(nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic) UIReturnKeyType returnKeyType;


- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;
- (void)confirmMaxNumberOfLines:(int)n;
@end

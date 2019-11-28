//
//  带有颜色高亮标记的特殊文本
//  caibo
//
//  Created by jeff.pluto on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YtTopic;
@class ASIHTTPRequest;
@class ColorLabel;

@protocol ColorLabelDelegate
@optional
- (void)clikeOrderIdURL:(NSURLRequest *)request;
- (void)loadFinished:(ColorLabel *)label;
@end

@interface ColorLabel : UIWebView <UIWebViewDelegate> {
    NSString *mText;
    CGFloat labelHeight;
    int mMaxWidth;
	id<ColorLabelDelegate> colorLabeldelegate;
    BOOL homebool;
    BOOL reyibool;
    NSString *finalStr;
    
    YtTopic * myYtTopic;
    ASIHTTPRequest * mRequest;
    
    BOOL canPush;
}

@property (nonatomic, retain)ASIHTTPRequest * mRequest;

@property (nonatomic, assign)BOOL homebool, reyibool;
@property(nonatomic, retain) NSString *mText;
@property (nonatomic,assign)id<ColorLabelDelegate> colorLabeldelegate;
@property (nonatomic,assign) BOOL isOriginal;

- (id)initWithText:(NSString *)txt;
- (id)initWithText:(NSString *)txt hombol:(BOOL)hobl;

-(void)setText:(NSString *)txt hombol:(BOOL)hobl;

- (id)initWithText:(NSString *)txt ytTopic:(YtTopic *)topic;
- (id)initWithText:(NSString *)txt hombol:(BOOL)hobl ytTopic:(YtTopic *)topic;

-(void)setText:(NSString *)txt hombol:(BOOL)hobl ytTopic:(YtTopic *)topic;


- (void) setMaxWidth : (int) maxWidth;
- (id) initWithTextReyi: (NSString *) txt tihuanhuati:(NSString *)huati name:(NSString *)namestr;

- (float)getHtmlHeight;

@end
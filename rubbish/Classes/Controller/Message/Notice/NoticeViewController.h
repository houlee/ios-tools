//
//  NoticeViewController.h
//  caibo
//
//  Created by jacob on 11-7-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressBar.h"
#import "ColorLabel.h"
#import "CPViewController.h"

@class MailList;
@class ASIHTTPRequest;


@interface NoticeViewController : CPViewController<UIActionSheetDelegate,PrograssBarBtnDelegate,ColorLabelDelegate> {
	
	MailList *mlist;
	
	UITextView *textView;
	
	ASIHTTPRequest *request;
    
    NSString *nickName;
	
    ColorLabel *colorLabel;

}

@property(nonatomic,retain)MailList *mlist;

@property(nonatomic,retain)IBOutlet UITextView *textView;

@property (nonatomic,retain)ASIHTTPRequest *request;

@property (nonatomic, retain)NSString *nickName;

@property (nonatomic, retain)ColorLabel *colorLabel;
-(id)initWithNoticeMessage:(MailList*)list;

- (void)handleNickName:(NSString *)content;
@end

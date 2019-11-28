//
//  ReportViewController.h
//  caibo
//
//  Created by jacob on 11-7-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ProgressBar.h"
#import "YtTopic.h"

@interface ReportViewController : UIViewController<UITextViewDelegate,PrograssBarBtnDelegate,UIActionSheetDelegate> {
	
	UITextView *textView;
	ASIHTTPRequest *request;
	YtTopic *sataus;
}

@property(nonatomic,retain)IBOutlet UITextView *textView;
@property(nonatomic,retain)ASIHTTPRequest *request;
@property(nonatomic,retain)YtTopic *sataus;

-(id)initWithYtTopic:(YtTopic*)ytTopic;

@end
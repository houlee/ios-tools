//
//  UserListMailController.h
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MailList.h"
#import "EditText.h"
#import "Face.h"
#import "CPViewController.h"

@class ASIHTTPRequest;

@interface UserListMailController : CPViewController <UITableViewDelegate,UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate,CBKeyBoardShowDelegate, CBClickFaceDelegate, GrowingTextViewDelegate> {
	
	ASIHTTPRequest *request;
	
	UITableView *mTableView;
	NSMutableArray *mailListArry;
	
	NSString *senderId;
	
	MailList *mList;
    
    EditText *mBackground;
    Face *faceSystem;
    BOOL isShow;
    
    CGFloat followKeybord;
}

//@property (retain) IBOutlet UITableView *mTableView;
@property (nonatomic,retain) NSMutableArray *mailListArry;
@property (nonatomic,retain) NSString*senderId;
@property (nonatomic,retain) MailList *mList;
@property (nonatomic, assign) CGFloat followKeybord;
@property(nonatomic,retain)ASIHTTPRequest *request;

-(void)sendRequest;

@end
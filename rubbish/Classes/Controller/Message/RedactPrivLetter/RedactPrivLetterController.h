//
//  RedactPrivLetterController.h
//  caibo
//
//  Created by jeff.pluto on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditText.h"
#import "Face.h"
#import "ASIHTTPRequestDelegate.h"
#import "CPViewController.h"

@interface RedactPrivLetterController : CPViewController <UITextViewDelegate, UIActionSheetDelegate, ASIHTTPRequestDelegate, CBKeyBoardShowDelegate, CBClickFaceDelegate, GrowingTextViewDelegate>{
    
    UIButton *mLinkMan;
    UIButton  *addBtn;
    IBOutlet UILabel *linLabel;
    NSString *mHimId;
    UITextView *infoText;
    EditText *mBackground;
    Face *faceSystem;
    
    UIImageView *pzImage;
    UIButton *pzButton;
    UIButton *fxButton;
    UIButton *htButton;
    UIButton *tjButon;
    UIButton *faButton;
    
}

@property (nonatomic, retain) NSString *mHimId;

- (void) changeTextCount : (NSString *) text;
- (void) actionSendMail : (id) sender;
- (IBAction) actionAddLinkMan:(UIButton *)sender;
- (IBAction) actionCancel : (id) sender;

@property (nonatomic, retain) NSString *nickName;

@end
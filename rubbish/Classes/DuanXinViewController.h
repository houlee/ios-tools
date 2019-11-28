//
//  DuanXinViewController.h
//  caibo
//
//  Created by zhang on 9/14/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ASIHTTPRequest.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CPViewController.h"


@interface DuanXinViewController : CPViewController<UITextFieldDelegate,UITextViewDelegate,MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate>
{
   
    UILabel *titleLabel;
    UIImageView *inputImage;
    UITextView *inputField;
    UIImageView *bbx;
    UIImageView *sjrImage;
    CGSize keysize;
    NSString *name;
    NSString *email;
    NSString *contactsAdd;
    UITextField *nameTextField;
    UITextView *sjrField;
    //UITextView *sjrField;
    NSMutableArray *sjr;
    
    ASIHTTPRequest * yaorequest;
}

@property (nonatomic, retain)ASIHTTPRequest * yaorequest;

@end

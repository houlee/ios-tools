//
//  FindPasswordViewController.h
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
@interface FindPasswordViewController : CPViewController <UITextFieldDelegate,UIActionSheetDelegate> {

    UITextField *YPTextField;
    ASIHTTPRequest *httprequest;
    NSString *codestr;
    NSString *mobilestr;
    NSString *msgstr;
}
@property (nonatomic,retain)ASIHTTPRequest *httprequest;

@end

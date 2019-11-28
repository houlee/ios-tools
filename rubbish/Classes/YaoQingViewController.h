//
//  YaoQingViewController.h
//  caibo
//
//  Created by zhang on 9/19/12.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_UIAlertView.h"


@interface YaoQingViewController : CPViewController<UITextFieldDelegate, CP_UIAlertViewDelegate >
{
//    UITextField *textF;
    ASIHTTPRequest *httpRequest;
    BOOL isTixian;
    NSString * passWord;
}
@property (nonatomic,retain)ASIHTTPRequest *httpRequest;
@property (nonatomic, retain)NSString * passWord;
@end

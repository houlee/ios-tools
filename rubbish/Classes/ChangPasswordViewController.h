//
//  ChangPasswordViewController.h
//  caibo
//
//  Created by zhang on 1/17/13.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "ChangePasswordJieXi.h"
#import "CPViewController.h"

@interface ChangPasswordViewController : CPViewController<UITextFieldDelegate> {

    UIImageView *CPBGima;
    UITextField *YPTextField;
    UITextField *NewPTextField;
    UITextField *QRPTextField;
    UIButton *QDButton;
    UIImageView *Low;
    UIImageView *Mid;
    UIImageView *Hig;
    
    ASIHTTPRequest *myHttpRequest;
    UIWindow *tempWindow;
    CGRect keybordFrame;
}
@property (nonatomic, retain)ASIHTTPRequest *myHttpRequest;
@end

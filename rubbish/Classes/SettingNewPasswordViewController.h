//
//  SettingNewPasswordViewController.h
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"

@interface SettingNewPasswordViewController : CPViewController<UITextFieldDelegate> {

    UITextField *NewPTextField;
    UITextField *QRPTextField;
    UIImageView *Low;
    UIImageView *Mid;
    UIImageView *Hig;
    CGRect keybordFrame;
    UIWindow *tempWindow;
    
    NSString *Nicknamestr;
    NSString *Uuidstr;
    NSString *codestr;
    ASIHTTPRequest *httprequest;
}
@property (nonatomic,retain)NSString *Nicknamestr,*Uuidstr;
@property (nonatomic,retain)ASIHTTPRequest *httprequest;
@end

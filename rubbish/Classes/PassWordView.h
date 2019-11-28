//
//  PassWordView.h
//  caibo
//
//  Created by houchenguang on 14-2-27.
//
//

#import <UIKit/UIKit.h>
#import "SPLockScreen.h"
#import "CP_UIAlertView.h"
#import "ASIHTTPRequest.h"

@interface PassWordView : UIView<LockScreenDelegate, CP_UIAlertViewDelegate>{

    NSInteger markCount;
    ASIHTTPRequest * httpRequest;
//    UIViewController * viewController;
    BOOL alertBool;
}

@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
//@property (nonatomic, retain)UIViewController * viewController;

@end

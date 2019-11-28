//
//  CPSetpwViewController.h
//  caibo
//
//  Created by houchenguang on 14-2-28.
//
//

#import <UIKit/UIKit.h>
#import "CP_SWButton.h"
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "ASIHTTPRequest.h"

@interface CPSetpwViewController : CPViewController<CP_UIAlertViewDelegate>{

    CP_SWButton * switchyn;
    ASIHTTPRequest * httpRequest;
    NSString * passWord;
    BOOL switchynBool;
}

@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSString * passWord;
- (void)passWordOpenUrl;
@end

//
//  PPTVLoginViewController.h
//  caibo
//
//  Created by yaofuyu on 12-10-24.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface PPTVLoginViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate> {
    UITextField *nameText;
    UITextField *passWordText;
    ASIHTTPRequest *myHttpRequest;
}
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;

@end

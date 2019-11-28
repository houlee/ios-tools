//
//  UntionAddNickViewController.h
//  caibo
//
//  Created by yaofuyu on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface UntionAddNickViewController : UIViewController<ASIHTTPRequestDelegate,UITextFieldDelegate> {
    NSString *name;
    UITextField *nameText;
    UITextField *passWordText;
    UITextField *passWordAgainText;
    ASIHTTPRequest *myHttpRequest;
    NSDictionary *dataDic;
    UIButton *btn;
    
}
@property (nonatomic,copy)NSString *name;
@property (nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;

@end

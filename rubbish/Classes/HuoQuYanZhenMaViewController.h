//
//  HuoQuYanZhenMaViewController.h
//  caibo
//
//  Created by zhang on 4/9/13.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"

@interface HuoQuYanZhenMaViewController : CPViewController<UITextFieldDelegate,UIActionSheetDelegate> {

    UITextField *YPTextField;
    ASIHTTPRequest *httprequest;
    ASIHTTPRequest *httprequest2;
    NSString *codestr;
    NSString *msgstr;
    NSString *idstr;
    UILabel *telLabel;
    NSString *telstring;
    NSString *Nickname;
    
    NSString *msgstr2;
    NSString *uuidstr;
    NSString *codestr2;
    
    CGRect keybordFrame;
    UIImageView *CPBGima;

}
@property (nonatomic,retain)ASIHTTPRequest *httprequest,*httprequest2;
@property (nonatomic, retain)NSString *telstring;
@property (nonatomic, retain)NSString *Nickname;
@property (nonatomic,retain)NSString *idstr,*codestr,*codestr2,*msgstr2;
@end

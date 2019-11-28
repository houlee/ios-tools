//
//  BFYCIntroViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-27.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@class ASIHTTPRequest;

@interface BFYCIntroViewController : CPViewController<UIWebViewDelegate>{

    NSString * playid;
    ASIHTTPRequest * httpRequest;
}

@property (nonatomic, retain)NSString * playid;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end

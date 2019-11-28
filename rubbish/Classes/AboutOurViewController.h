//
//  AboutOurViewController.h
//  caibo
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@class ASIHTTPRequest;
@interface AboutOurViewController : CPViewController<UIActionSheetDelegate>
{
    ASIHTTPRequest * httprequest;
    ASIHTTPRequest * httpRequest;

}

@property (nonatomic, retain)ASIHTTPRequest * httprequest;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSString * urlVersion;

@end

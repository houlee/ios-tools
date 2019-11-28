//
//  CommonProblemViewController.h
//  Experts
//
//  Created by V1pin on 15/11/12.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
@class ASIHTTPRequest;

@interface CommonProblemViewController : V1PinBaseViewContrllor
{
    ASIHTTPRequest * commonRequest;
}

@property(nonatomic,strong)NSString *sourceFrom;

@property(nonatomic,retain)UIWebView * webView;

@property(nonatomic,strong)NSString * nsUrl;

@property (nonatomic, retain) ASIHTTPRequest * commonRequest;

@end

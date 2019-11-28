//
//  CJBNoActivateViewController.h
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "UpLoadView.h"
#import "New_PageControl.h"

@interface CJBNoActivateViewController : CPViewController<UIScrollViewDelegate>{

    ASIHTTPRequest * httpRequest;
    UILabel * yearLabel;
    UILabel * yearLabel2;
    UILabel * yearLabel3;
    UILabel * yearLabel4;
    UILabel * yearLabel5;
    UpLoadView * loadview;
    UIScrollView * myScrollView;
    New_PageControl * myPageControl;
}

@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end

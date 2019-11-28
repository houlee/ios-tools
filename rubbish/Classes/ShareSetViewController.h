//
//  ShareSetViewController.h
//  CPgaopin
//
//  Created by houchenguang on 13-9-11.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"
#import "CP_UIAlertView.h"
@interface ShareSetViewController : CPViewController<CP_UIAlertViewDelegate>{
    UILabel * typeLabelw;
    UILabel * typeLabels;
    UILabel * typeLabelz;
    UILabel * typeLabelx;
    ASIHTTPRequest * httpRequest;
     UpLoadView * loadview;
    NSInteger  typeSorce;//请求的是哪一个
}
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end

//
//  CJBActivateViewController.h
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "UIStatisticsView.h"
#import "UpLoadView.h"

@interface CJBActivateViewController : CPViewController{

    ASIHTTPRequest * httpRequest;
    UILabel * generalAssetsLabel;//总资产
    UILabel * yesterdayLabel;
    UILabel * historyLabel;
    UILabel * myriadLabel;
    UILabel * bonusLabel;
    UIStatisticsView * statisticsView;
    UpLoadView * loadview;
    UILabel * nhLabel;
    UILabel * jjrLabel;
    
}

@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end

//
//  DetailsViewController.h
//  caibo
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 vodone. All rights reserved.
//方案详情

#import <UIKit/UIKit.h>
#import "DetailsCell.h"
#import "DetailsData.h"
#import "Info.h"
#import "PKGameExplainViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NetURL.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"

@interface DetailsViewController : CPViewController <UITableViewDelegate, UITableViewDataSource,CP_ThreeLevelNavDelegate>{
    
    UITableView * myTabelView;
    NSMutableArray * detailsArray;
    ASIHTTPRequest * request;
    NSString * orderId;
    NSMutableArray * detaDataArray;
    NSMutableArray *buyArray;
}
@property (nonatomic, retain)NSMutableArray * detaDataArray;
@property (nonatomic, retain)NSString * orderId;
@property (nonatomic, retain)NSMutableArray * detailsArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic, retain)NSMutableArray *buyArray;

@end

//
//  MyForecastViewController.h
//  caibo
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastData.h"
#import "ASIHTTPRequest.h"

@interface MyForecastViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView * myTableView;
    NSMutableArray * dataArray;
    ASIHTTPRequest * request;
}
@property (nonatomic, retain)ASIHTTPRequest * request;
@end

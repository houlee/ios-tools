//
//  LotteryPreferenceViewController.h
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YrbSectionHeaderView.h"
#import "LotteryPreferenceView.h"
#import "ASIHTTPRequest.h"
@interface LotteryPreferenceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YrbSectionHeaderViewDelegate,LotteryPreferenceViewDelegate>

{
    NSMutableArray *lists;
    UITableView *lpTableView;
    NSMutableDictionary *typeDictionary;
    ASIHTTPRequest *request;
    
    NSMutableArray *keepIndex;
}

@property (nonatomic, retain)NSMutableArray *lists;
@property (nonatomic, retain)UITableView *lpTableView;
@property (nonatomic, retain)NSMutableDictionary *typeDictionary;
@property (nonatomic, retain)ASIHTTPRequest *request;
@property (nonatomic, retain)NSMutableArray *keepIndex;

- (void)loadPreferenceData;
- (void)reloadPreferenceData;
@end

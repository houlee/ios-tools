//
//  GC_BaFangShiPingViewController.h
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ShiPinData.h"
#import "GC_BetData.h"
#import "CPViewController.h"

@interface GC_BaFangShiPingViewController : CPViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView * myTableView;
    UITableView *pptvTableView;
    ASIHTTPRequest * request;
    NSMutableDictionary * allDict;
    NSMutableDictionary *pptvDict;
    ShiPinData * shipindata;
    NSMutableArray * dateArray;
//    UIImageView * zhiImage;//头上直播图片
    int buffer[160];
    int but[100];
    NSMutableArray *kebianzidian;
}
@property (nonatomic, retain)ASIHTTPRequest * request;
- (void)returnTabelViewHeadView;
@end

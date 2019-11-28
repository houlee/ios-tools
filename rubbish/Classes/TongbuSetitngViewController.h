//
//  TongbuSetitngViewController.h
//  caibo
//
//  Created by yao on 12-3-13.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@interface TongbuSetitngViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	UITableView *myTableView;
	NSArray *dataArray;
	ASIHTTPRequest *mRequest;
	BOOL sinaBlind;
}
@property (nonatomic ,retain)ASIHTTPRequest *mRequest;

@end

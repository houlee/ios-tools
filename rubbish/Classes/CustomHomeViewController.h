//
//  CustomHomeViewController.h
//  caibo
//
//  Created by yao on 11-12-9.
//  Copyright 2011 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	
	UITableView *mTableView;
	NSMutableArray *dataArray;
}
@property (nonatomic,retain)UITableView *mTableView;
@property (nonatomic,retain)NSMutableArray *dataArray;

@end

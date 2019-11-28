//
//  tuisongtongzhiButtonController.h
//  caibo
//
//  Created by user on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"
#import "ASIHTTPRequest.h"
#import "CP_NTableView.h"
#import "CPViewController.h"

@class PickerView;

@interface TuisongtongzhiButtonController : CPViewController
<UITableViewDelegate, UITableViewDataSource, PassValueDelegate,CP_NTableDelegate>{
	NSArray *listData;
	UITableView *myTableView;
	NSMutableArray *kaiJiangData;
	NSMutableArray *statusData;// 推送通知设置状态
	NSString *string;
	PickerView *pView;
    NSString *sw1value;
    NSString *sw2value;
	BOOL isPushZj;//中奖

    ASIHTTPRequest *mrequest;
    ASIHTTPRequest *asirequest;
    CP_NTableView * ntableview;
    NSMutableArray * switchArray;
    NSMutableArray * alltitle;
    ASIHTTPRequest * chekrequest;
}
@property (nonatomic, retain)ASIHTTPRequest *asirequest, *chekrequest;
@property (nonatomic, retain)ASIHTTPRequest *mrequest;
@property (nonatomic, retain) NSArray *listData;
@property (nonatomic,retain) IBOutlet UITableView *myTableView;
@property (nonatomic,retain) NSArray *statusData;
@property (nonatomic,retain) NSArray *kaiJiangData;
@property (nonatomic, retain) NSString *string;
@property (nonatomic, retain) NSString *sw1value;
@property (nonatomic, retain) NSString *sw2value;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil SwitchArray:(NSMutableArray *)sarray;
- (void)setButtonStyle: (UIButton *)button style: (NSInteger)n;
- (IBAction)cancel: (id)sender;
- (IBAction)done: (id)sender;
- (void)switchChanged: (UISwitch*)mswitch;
- (void)updata_time: (NSString *)time;
- (void)getPushStatus;
@end

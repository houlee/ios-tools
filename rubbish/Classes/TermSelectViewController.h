//
//  TermSelectViewController.h
//  caibo
//
//  Created by lxzhh on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiveScoreViewController;

@interface TermSelectViewController : UIViewController
	<UIPickerViewDelegate,UIPickerViewDataSource> {
		IBOutlet UIView *topView;
		NSMutableArray *issues;
		LiveScoreViewController *settingConroller;	
		NSString *selectIssue;
		UIPickerView *myPicker;
        IBOutlet UIToolbar *mybar;
        UIView *myPickerBGView;
}
@property(nonatomic, retain)NSMutableArray* issues;
@property(nonatomic, assign)LiveScoreViewController *settingConroller;
@property(nonatomic, retain)NSString *selectIssue;
@property(nonatomic, retain)UIToolbar *mybar;
@property(nonatomic, retain)IBOutlet UIView *topView;
@property(nonatomic, retain)IBOutlet UIPickerView *myPicker;
@property (retain, nonatomic) IBOutlet UIView *myPickerBGView;

- (void)colorChange;
- (void)dismiss;
- (IBAction)cancel;
- (IBAction)confirm;
- (id)initWithSettingController:(LiveScoreViewController*)controller;
@end

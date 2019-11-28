//
//  PickerView.h
//  caibo
//
//  Created by user on 11-7-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@class TuisongtongzhiButtonController;


@interface PickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate, PassValueDelegate>
{
	NSArray *list;
	NSMutableString *time1;
	NSMutableString *time2;
    
    UIBarButtonItem *completeButton;
	
	NSObject<PassValueDelegate> *delegate;	
}

@property (nonatomic, retain) NSArray *list;
@property (nonatomic, retain) NSMutableString *time1;
@property (nonatomic, retain) NSMutableString *time2;

@property (nonatomic, retain) UIBarButtonItem *completeButton;

@property(nonatomic, assign) NSObject<PassValueDelegate> *delegate;

+ (PickerView *)getInstance;

- (void) show;

- (void)disappear;

- (void) finishclick: (id)sender;

@end
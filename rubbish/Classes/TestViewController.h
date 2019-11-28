//
//  TestViewController.h
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLockScreen.h"
#import "CPViewController.h"

typedef enum {
	InfoStatusFirstTimeSetting = 0,
	InfoStatusConfirmSetting,
	InfoStatusFailedConfirm,
	InfoStatusNormal,
	InfoStatusFailedMatch,
	InfoStatusSuccessMatch
}	InfoStatus;


@interface TestViewController : CPViewController{

    BOOL twoBool;
    NSString * passWordString;
}
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet SPLockScreen *lockScreenView;
@property (nonatomic) InfoStatus infoLabelStatus;
@property (nonatomic, assign)BOOL twoBool;
@property (nonatomic, retain)NSString * passWordString;

@end

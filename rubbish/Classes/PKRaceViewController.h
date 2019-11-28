//
//  PKRaceViewController.h
//  caibo
//
//  Created by cp365dev6 on 15/1/16.
//
//

#import "CPViewController.h"
#import "Info.h"
#import "CP_PTButton.h"
#import "PKNewUserHelpViewController.h"
#import "PKJoinRaceViewController.h"
#import "PKMyRecordViewController.h"
#import "PKRuleViewController.h"
#import "User.h"
#import "ProvingViewCotroller.h"
#import "UserInfo.h"

@interface PKRaceViewController : CPViewController<CP_UIAlertViewDelegate,ASIHTTPRequestDelegate>
{
    ASIHTTPRequest * dateRequest;
    NSMutableArray * buyArray;//可买的期数
}
@property (nonatomic, retain)ASIHTTPRequest * dateRequest;
@property (nonatomic, retain)NSMutableArray * buyArray;
@property (nonatomic, copy)NSString *passWord;
@property (nonatomic, assign)NSInteger curCount,returnId,returnId1,statue;
@property (nonatomic, copy)NSString * sysTimeString,*sysTimeString1,*tishiMessage;
@property (nonatomic, retain)NSMutableArray * listArym;

@end

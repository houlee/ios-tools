//
//  IpadRootViewController.h
//  caibo
//
//  Created by houchenguang on 13-4-23.
//
//

#import <UIKit/UIKit.h>
#import "CP_TabBarViewController.h"
#import "CP_TabBarViewController.h"
#import "StatePopupView.h"
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"
#import "CP_PrizeView.h"
@interface IpadRootViewController : UIViewController<CP_TabBarConDelegate,CP_TabBarConDelegate,CP_PrizeViewDelegate>{

    UIImageView * selectImage ;
    UIView * menuView;
    CP_TabBarViewController * tab;
    int  selectedTab;
    int con;
     NSInteger counhaoyou;
     NSInteger counttag;
    UIImageView * weiboNew;
    ASIHTTPRequest * chekrequest;
    StatePopupView *statepop;
    UpLoadView * loadview;
}

@property(nonatomic, retain)ASIHTTPRequest * chekrequest;
- (void)pressMenuButton:(UIButton *)sender;
@end

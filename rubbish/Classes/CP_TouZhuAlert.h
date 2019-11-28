//
//  CP_TouZhuAlert.h
//  caibo
//
//  Created by yaofuyu on 14-3-14.
//
//

#import <UIKit/UIKit.h>
#import "GC_BuyLottery.h"

@interface CP_TouZhuAlert : UIView {
    NSString *title;
    UIScrollView *backScrollView;
    GC_BuyLottery *buyResult;
    id delegate;
}

@property (nonatomic,copy)NSString *title;
@property (nonatomic,retain)UIScrollView *backScrollView;
@property (nonatomic,retain)GC_BuyLottery *buyResult;
@property (nonatomic,assign)id delegate;

- (void)show;

@end

@protocol CP_TouZhuAlertDelegate

@optional
- (void)CP_TouZhuAlert:(CP_TouZhuAlert *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

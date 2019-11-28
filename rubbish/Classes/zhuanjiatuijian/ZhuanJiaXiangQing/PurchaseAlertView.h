//
//  PurchaseAlertView.h
//  caibo
//
//  Created by zhoujunwang on 16/8/5.
//
//

#import <UIKit/UIKit.h>
@class SMGDetailViewController;

@interface PurchaseAlertView : UIView

@property (nonatomic,weak)SMGDetailViewController *smgVc;
@property (nonatomic,assign)id delegate;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSMutableArray *customButtons;
@property (nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSMutableArray *btnArr;

- (id)initWithTitle:(NSString *)title delegate:(id )delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)show:(NSArray *)arr;

@end

@protocol PurchaseAlertViewDelegate

@optional

- (void)purchaseAlertView:(PurchaseAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)purchaseAlertView:(PurchaseAlertView *)alertView clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender;

@end


@interface ShenDanAlertCell : UIView

@property(nonatomic,strong)UIButton *optBtn;
@property(nonatomic,strong)UIButton *planBtn;
@property(nonatomic,strong)UILabel *upLab;
@property(nonatomic,strong)UILabel *downLab;
@property(nonatomic,strong)NSString *btnTag;

-(id)initWithFrame:(CGRect)frame indexPath:(NSInteger)indexPath;

-(void)isBuy:(NSString *)isBuy upText:(NSString *)upText downText:(NSString *)downText nameText:(NSString *)nameText;

@end

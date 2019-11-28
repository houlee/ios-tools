//
//  BallBoxView.h
//  caibo
//
//  Created by houchenguang on 14-3-10.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@protocol BallBoxViewDelegate <NSObject>


@optional
- (void)ballBoxDelegateReturnData:(GC_BetData *)bd;
- (void)ballBoxDelegateRemove;
- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd;
@end


@interface BallBoxView : UIView{

    NSMutableArray * typeButtonArray;
    GC_BetData * betData;
    id<BallBoxViewDelegate>delegate;
    BOOL wangqiBool;
    UIScrollView * myScrtollView ;
    UIImageView * iteamImage;
    UIImageView *infoImage;
    UIView * allButtonView;
    BOOL bfycBool;//八方预测过来的
}
@property (nonatomic, retain) NSMutableArray * typeButtonArray;
@property (nonatomic, assign)id<BallBoxViewDelegate>delegate;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)BOOL wangqiBool, bfycBool;

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi;


@end

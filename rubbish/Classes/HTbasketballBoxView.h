//
//  HTbasketballBoxView.h
//  caibo
//
//  Created by houchenguang on 14-7-9.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@protocol BHTbasketballDelegate <NSObject>


@optional
- (void)ballBoxDelegateReturnData:(GC_BetData *)bd;
- (void)ballBoxDelegateRemove;
- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd;
@end

@interface HTbasketballBoxView : UIView{

    NSMutableArray * typeButtonArray;
    GC_BetData * betData;
    id<BHTbasketballDelegate>delegate;
    BOOL wangqiBool;
    UIScrollView * myScrtollView ;
//    UIImageView * iteamImage;
//    UIImageView *infoImage;
//    UIView * allButtonView;
    BOOL bfycBool;//八方预测过来的
    UIImageView * bgimage;
}
@property (nonatomic, retain) NSMutableArray * typeButtonArray;
@property (nonatomic, assign)id<BHTbasketballDelegate>delegate;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)BOOL wangqiBool, bfycBool;

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi;


@end


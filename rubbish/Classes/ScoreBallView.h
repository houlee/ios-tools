//
//  ScoreBallView.h
//  caibo
//
//  Created by houchenguang on 14-7-12.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@protocol ScoreBallDelegate <NSObject>


@optional
- (void)ballBoxDelegateReturnData:(GC_BetData *)bd;
- (void)ballBoxDelegateRemove;
- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd;
@end
@interface ScoreBallView : UIView{
    
    NSMutableArray * typeButtonArray;
    GC_BetData * betData;
    id<ScoreBallDelegate>delegate;
    BOOL wangqiBool;
    UIScrollView * myScrtollView ;
    //    UIImageView * iteamImage;
    //    UIImageView *infoImage;
    //    UIView * allButtonView;
    BOOL bfycBool;//八方预测过来的
    UIImageView * bgimage;
    BOOL bigHunTou;
}
@property (nonatomic, retain) NSMutableArray * typeButtonArray;
@property (nonatomic, assign)id<ScoreBallDelegate>delegate;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)BOOL wangqiBool, bfycBool,bigHunTou;


- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi;


@end
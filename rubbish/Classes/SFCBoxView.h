//
//  SFCBoxView.h
//  caibo
//
//  Created by houchenguang on 14-7-11.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@protocol SFCBoxViewDelegate <NSObject>


@optional
- (void)ballBoxDelegateReturnData:(GC_BetData *)bd;
- (void)ballBoxDelegateRemove;
- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd;
@end

@interface SFCBoxView : UIView{
    
    NSMutableArray * typeButtonArray;
    GC_BetData * betData;
    id<SFCBoxViewDelegate>delegate;
    BOOL wangqiBool;
//    UIScrollView * myScrtollView ;
    //    UIImageView * iteamImage;
    //    UIImageView *infoImage;
    //    UIView * allButtonView;
    BOOL bfycBool;//八方预测过来的
    UIImageView * bgimage;
    NSInteger viewType;
    
}
@property (nonatomic, retain) NSMutableArray * typeButtonArray;
@property (nonatomic, assign)id<SFCBoxViewDelegate>delegate;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)BOOL wangqiBool, bfycBool;
@property (nonatomic, assign)NSInteger viewType;

- (id)initWithFrame:(CGRect)frame betData:(GC_BetData *)pkbetdata wangQi:(BOOL)wangqi celltype:(NSInteger)type;


@end
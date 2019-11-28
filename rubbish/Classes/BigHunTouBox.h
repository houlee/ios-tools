//
//  BigHunTouBox.h
//  caibo
//
//  Created by houchenguang on 14-7-30.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@protocol BigHunTouBoxDelegate <NSObject>


@optional
- (void)ballBoxDelegateReturnData:(GC_BetData *)bd;
- (void)ballBoxDelegateRemove;
- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd;
@end

typedef enum{
    
    shengpingfuType,
    rangqiushengpingfuType,
    zongjinqiuType,
    banquanchangType,
    shengfuType,
    rangfenshengfuType,
    daxiaofenType,
    shengfenchaType,
    
    
} BigHunTouBoxType;



@interface BigHunTouBox : UIView{

    BigHunTouBoxType showTye;
    GC_BetData * betData;
    BOOL wangqibool;
    UIImageView * bgimage;
    id<BigHunTouBoxDelegate>delegate;
    NSMutableArray * typeButtonArray;
    UILabel * teamLabel;
    UILabel * rangLabel;
 
    
}
@property (nonatomic, retain) NSMutableArray * typeButtonArray;
@property (nonatomic, assign)BigHunTouBoxType showTye;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)BOOL wangqibool;
@property (nonatomic, assign)id<BigHunTouBoxDelegate>delegate;

- (id)initWithType:(BigHunTouBoxType)type wangqin:(BOOL)wangqi ;

@end

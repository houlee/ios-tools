//
//  BFYCBoxView.h
//  caibo
//
//  Created by houchenguang on 14-5-27.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "BallBoxView.h"
#import "ScoreBallView.h"

typedef enum{
    
    jczongjinqiuboxtype,
    jcbanquanchangboxtype,
    jcbifenboxtype,
    bdbifenboxtype,

} BoxType;

@interface BFYCBoxView : UIView<BallBoxViewDelegate, ScoreBallDelegate>{

    BoxType boxType;
    GC_BetData * betData;
    BallBoxView * ballBox;
    ScoreBallView * scoreBall;
    id delegate;
     NSMutableArray * typeButtonArray;
}

@property (nonatomic, assign)BoxType boxType;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)id delegate;
@property (nonatomic, retain)NSMutableArray * typeButtonArray;

@end


@protocol BFYCBoxViewDelegate <NSObject>
@optional
- (void)bfycBoxView:(BFYCBoxView *)boxView whithBetData:(GC_BetData *)_betData;

@end
//
//  NeutralityMatchView.h
//  caibo
//
//  Created by houchenguang on 14-6-6.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"

@interface NeutralityMatchView : UIView{

    id delegate;
    GC_BetData * betData;
  
    
}
@property (nonatomic, assign)id delegate;
@property (nonatomic, retain)GC_BetData * betData;


- (void)show;
- (id)initWithBetData:(GC_BetData *)_betData number:(NSString *)number;
@end



@protocol NeutralityMatchViewDelegate <NSObject>
@optional

- (void)neutralityMatchViewDelegate:(NeutralityMatchView *)view withBetData:(GC_BetData *)be;

@end
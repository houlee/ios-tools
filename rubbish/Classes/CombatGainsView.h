//
//  CombatGainsView.h
//  caibo
//
//  Created by houchenguang on 14-5-22.
//
//

#import <UIKit/UIKit.h>

@interface CombatGainsView : UIView{
    
    NSInteger homeOrguest;
    NSDictionary * analyzeDictionary;
}
@property (nonatomic, assign)NSInteger homeOrguest;
@property (nonatomic, retain)NSDictionary * analyzeDictionary;

@end

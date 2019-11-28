//
//  PermutationAndCombination.h
//  caibo
//
//  Created by houchenguang on 15/1/12.
//
//

#import <Foundation/Foundation.h>

@interface PermutationAndCombination : NSObject{
    
    NSMutableArray * pernutationArray;
//    NSMutableArray * allMatchArray;
//    NSInteger countSum;
    NSMutableArray *chaifenSaishiArym;
}
- (NSMutableArray *)chaifenArray;
- (void)combinationWhithMatchArray:(NSMutableArray *)matchArray chuanCount:(NSString *)countSum;

@end

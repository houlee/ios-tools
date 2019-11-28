//
//  RankListCell.h
//  caibo
//
//  Created by zhoujunwang on 16/1/6.
//
//

#import <UIKit/UIKit.h>

#define HITAG 301
#define HEATAG 302
#define RETURNTAG 303

@interface RankListCell : UITableViewCell

+(id)rankListCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)potrait:(NSString *)potrait name:(NSString *)name rank:(NSInteger)rank recomNo:(NSString *)recomNo hitPbablity:(NSString *)hitPbablity singleRecNo:(NSString *)singleRecNo singleHitRate:(NSString *)singleHitRate order:(NSInteger)order tableTag:(NSInteger)tableTag lotryType:(NSString *)lotryType;
- (void)potrait:(NSString *)potrait name:(NSString *)name rank:(NSInteger)rank recomNo:(NSString *)recomNo hitPbablity:(NSString *)hitPbablity singleRecNo:(NSString *)singleRecNo singleHitRate:(NSString *)singleHitRate order:(NSInteger)order tableTag:(NSInteger)tableTag lotryType:(NSString *)lotryType ;

@end

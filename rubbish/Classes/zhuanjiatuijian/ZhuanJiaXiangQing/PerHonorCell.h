//
//  PerHonorCell.h
//  caibo
//
//  Created by zhoujunwang on 16/1/4.
//
//

#import <UIKit/UIKit.h>

@interface PerHonorCell : UITableViewCell

+(id)perhonorCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)hitRateWeek:(NSString *)hitRateWeek hitRateMouth:(NSString *)hitRateMouth returnRankWeek:(NSString *)returnRankWeek returnRankMouth:(NSString *)returnRankMouth popularRankWeek:(NSString *)popularRankWeek popularRankMouth:(NSString *)popularRankMouth;

@end

@interface NSString(perhonor)

+ (NSString *)setDataNo:(NSString *)str;

@end


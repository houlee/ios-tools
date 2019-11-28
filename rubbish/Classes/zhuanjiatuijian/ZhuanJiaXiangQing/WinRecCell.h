//
//  WinRecCell.h
//  caibo
//
//  Created by zhoujunwang on 16/1/5.
//
//

#import <UIKit/UIKit.h>

@interface WinRecCell : UITableViewCell

- (void)configUI:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSArray *leagueMatchArr;

@end

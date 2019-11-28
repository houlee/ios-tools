//
//  ClassifyCell.h
//  caibo
//
//  Created by zhoujunwang on 16/1/11.
//
//

#import <UIKit/UIKit.h>

@interface ClassifyCell : UITableViewCell

@property(nonatomic,strong) UILabel *txtLabel;

@property(nonatomic,strong) UIImageView *selectImgV;

+(id)classifyCellWithTView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

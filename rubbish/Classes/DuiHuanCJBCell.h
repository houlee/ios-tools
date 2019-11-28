//
//  DuiHuanCJBCell.h
//  caibo
//
//  Created by cp365dev on 15/1/14.
//
//

#import <UIKit/UIKit.h>

@interface DuiHuanCJBCell : UITableViewCell
{
    UILabel *moneyLabel;
    UIImageView *yuanImage;
    
    UILabel *needPoints;
    UILabel *people;
    UILabel *yiduihuan;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)LoadData:(NSString *)_money points:(NSString *)_jifen people:(NSString *)_ren;

@end

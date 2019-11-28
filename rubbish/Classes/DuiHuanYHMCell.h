//
//  DuiHuanYHMCell.h
//  caibo
//
//  Created by cp365dev on 15/1/14.
//
//

#import <UIKit/UIKit.h>

@interface DuiHuanYHMCell : UITableViewCell
{
    UILabel *youhuimaLabel1;
    UILabel *needpoints;
    UILabel *people;
    UILabel *people1;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)LoadData:(NSString *)_chong getM:(NSString *)_de points:(NSString *)_jifen people:(NSString *)_ren;
@end

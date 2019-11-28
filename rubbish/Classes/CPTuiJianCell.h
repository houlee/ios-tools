//
//  CPTuiJianCell.h
//  CPgaopin
//
//  Created by yaofuyu on 13-11-27.
//
//

#import <UIKit/UIKit.h>
//#import "CP_PTButton.h"
#import "GCBallView.h"

@protocol CPTuiJianCellDelegate

@optional
- (void)BtnClick:(GCBallView *)btn WithCell:(UITableViewCell *)cell;

@end

@interface CPTuiJianCell : UITableViewCell {
//    UIImageView *backImageView;
    GCBallView *btn1;
    GCBallView *btn2;
    GCBallView *btn3;
    UILabel *nameLabel;
    id tuijianCellDelegate;
}

@property (nonatomic,assign)id<CPTuiJianCellDelegate>tuijianCellDelegate;
@property (nonatomic,retain)GCBallView *btn1,*btn2,*btn3;


- (void)LoadData:(NSString *)data;
- (void)LoadName:(NSString *)name;

@end

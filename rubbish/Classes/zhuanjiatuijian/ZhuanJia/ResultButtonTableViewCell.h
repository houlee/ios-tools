//
//  ResultButtonTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/12/26.
//
//

#import <UIKit/UIKit.h>

typedef void(^ResultButtonAction)(UIButton *button);

@interface ResultButtonTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *resultLab;//
@property (nonatomic, strong) UIImageView *lineIma;//
@property (nonatomic, strong) UIButton *leftBtn;//
@property (nonatomic, strong) UIButton *rightBtn;//
@property (nonatomic, strong) UILabel *middleLab;//
@property (nonatomic, copy) ResultButtonAction buttonBlcok;

-(void)loadAppointInfo:(NSDictionary *)dict;

@end

//
//  ExpertButtonInfoTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(UIButton *button);

@interface ExpertButtonInfoTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *leftLab;//
@property (nonatomic, strong) UIImageView *btnBGIma;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *switchBtn;

@property (nonatomic, copy) ButtonAction buttonBlcok;

-(void)loadAppointInfo:(NSDictionary *)dict WithSeletArray:(NSArray *)seletArray;
@end

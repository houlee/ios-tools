//
//  ExpertHornTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/30.
//
//

#import <UIKit/UIKit.h>

@interface ExpertHornTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UIImageView *hornIma;
@property (nonatomic, strong) UILabel *hornLab1;//
@property (nonatomic, strong) UILabel *hornLab2;//

-(void)loadAppointInfo:(NSString *)dict;

@end

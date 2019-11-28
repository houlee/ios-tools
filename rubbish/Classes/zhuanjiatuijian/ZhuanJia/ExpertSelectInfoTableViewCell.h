//
//  ExpertSelectInfoTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import <UIKit/UIKit.h>

@interface ExpertSelectInfoTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *leftLab;//
@property (nonatomic, strong) UILabel *rightLab;//
@property (nonatomic, strong) UIImageView *arrowIma;//

-(void)loadAppointInfo:(NSDictionary *)dict;
@end

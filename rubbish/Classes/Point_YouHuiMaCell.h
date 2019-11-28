//
//  Point_YouHuiMaCell.h
//  caibo
//
//  Created by cp365dev on 15/1/6.
//
//

#import <UIKit/UIKit.h>

typedef enum{

    UsableType,//可用
    UsedType,  //已用
    ExpireType,//过期

}Point_YouHuiMaType;

@interface Point_YouHuiMaCell : UITableViewCell
{
    Point_YouHuiMaType youhuimaType;
    UIImageView *bgImg;
    UILabel *youxiaoqiLabel;
    UILabel *youhuimaLabel1;
}

@property (nonatomic, assign) Point_YouHuiMaType youhuimaType;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)LoadData:(NSString *)_cellType WithMes:(NSString *)_mes andTime:(NSString *)_time;
@end

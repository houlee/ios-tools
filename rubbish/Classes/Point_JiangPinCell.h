//
//  Point_JiangPinCell.h
//  caibo
//
//  Created by cp365dev on 15/1/6.
//
//

#import <UIKit/UIKit.h>


typedef enum{

    ExChangeType, //兑换
    RandType,     //抽奖
    
    
}GetJiangPinMethod;

@interface Point_JiangPinCell : UITableViewCell
{
    GetJiangPinMethod jiangpinMethod;
    UIImageView *bgImage;
    UILabel *kindsLabel;
    UILabel *methodLabel;
    UILabel *timeLabel;
    
    UILabel *numLabel;
    UILabel *unitLabel;
    
    UILabel *cp365Label;
}
@property (nonatomic, assign) GetJiangPinMethod jiangpinMethod;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)LoadData:(NSString *)getType prizeType:(NSString *)prizeType numString:(NSString *)num unitString:(NSString *)unit andKindsName:(NSString *)_name andTime:(NSString *)_time;
@end

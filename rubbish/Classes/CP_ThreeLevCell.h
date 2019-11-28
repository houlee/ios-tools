//
//  CP_ThreeLevCell.h
//  kongjiantabbat
//
//  Created by houchenguang on 12-12-3.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    commonMenu,//普通的
    KuaiSanMenu,//快三
    PuKeMenu,//扑克
}MenuType;

@protocol CP_ThreeLevDelegate <NSObject>
@optional
- (void)threeLevelSelectIndex:(NSInteger)index;
- (void)threeLevelSelectButton:(UIButton *)sender;

@end

@interface CP_ThreeLevCell : UITableViewCell{
    UILabel * titleLabel;
    UIImageView * headImage;
    id<CP_ThreeLevDelegate>delegate;
    NSInteger row;
    UIImageView * line;
    UIImageView * zhezhaoimage;
    
    MenuType menuType;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(MenuType)type;

@property (nonatomic, assign)id<CP_ThreeLevDelegate>delegate;
@property (nonatomic, retain)UIImageView * headImage;
@property (nonatomic, retain)UILabel * titleLabel;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, retain)UIImageView * line;

- (void)threeLevelSelectIndex:(NSInteger)index;
- (void)threeLevelSelectButton:(UIButton *)sender;

@end

//
//  CP_ThreeLevelNavigationView.h
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-30.
//
//

#import <UIKit/UIKit.h>
#import "CP_ThreeLevCell.h"

@protocol CP_ThreeLevelNavDelegate <NSObject>
@optional
- (void)returnSelectIndex:(NSInteger)index;//代理函数 返回选择的第几个

- (void)returnSelectButton:(UIButton *)sender;//代理函数 返回点击的button

@end

@interface CP_ThreeLevelNavigationView : UIView<UITableViewDataSource, UITableViewDelegate, CP_ThreeLevDelegate>{

    UITableView * myTableView;
    NSMutableArray * imageArr;
    NSMutableArray * titleArr;
    UIImageView * bgimage;
    id<CP_ThreeLevelNavDelegate>delegate;
    UIImageView * bgtwoImage;
    MenuType menuType;
    UIImage * gsimage;
}
@property (nonatomic, assign)id<CP_ThreeLevelNavDelegate>delegate;
@property (nonatomic, retain)NSMutableArray * titleArr;
@property (nonatomic, retain)UIImage * gsimage;
- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle;//初始化函数 传入所有图片的名字 和 所有label的名字 frame传入的是window的frame

- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle bgName:(NSString *)bgName;

- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle type:(MenuType)type;


- (void)returnSelectIndex:(NSInteger)index;
- (void)returnSelectButton:(UIButton *)sender;

-(void)show;

@end
//如果放到window上的话 在没有消失的情况下 应该把此view remov掉
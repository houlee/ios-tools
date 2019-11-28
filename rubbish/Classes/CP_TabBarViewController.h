//
//  CP_TabBarViewController.h
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-28.
//
//
@protocol CP_TabBarConDelegate <NSObject>
@optional
- (void)cpTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;//回调
-(void)cpTabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;//回调

- (void)cpViewWillDisappear:(BOOL)animated;//即将消失
- (void)cpViewWillAppear:(BOOL)animated;//即将出现
@end

#import <UIKit/UIKit.h>

@interface CP_TabBarViewController : UITabBarController<UITabBarControllerDelegate>{
    
    NSInteger controllerCount;
    NSMutableArray * imageStringArr;//未选择的图片
    NSMutableArray * LabelStringArr;//所有label的名字
    NSMutableArray * selectdImageArr;//选中的图片
    CGRect zongCGrect;
    CGRect tabbarrect;
    UITabBar * myTabBar;
    UIImageView * backgroundImage;
    NSMutableArray * stateArray;
    id<CP_TabBarConDelegate>delegateCP;
    BOOL loginyn;
    BOOL diyicideng;
    BOOL goucaibool;//购彩页面的判断
    BOOL showXuanZheZhao;//显示现在的遮罩
}
@property (nonatomic, assign)BOOL loginyn, goucaibool,showXuanZheZhao;
@property (nonatomic, retain)UIImageView * backgroundImage ;//tabbar的背景图片
@property (nonatomic, retain) NSMutableArray * stateArray;//所有图标的条数 用字符串类型
@property (nonatomic, assign)id<CP_TabBarConDelegate>delegateCP;
- (id)initWithFrame:(CGRect)frames tabBarFrame:(CGRect)tabFrame Controllers:(NSMutableArray *)controller allButtonImageName:(NSMutableArray *)namearr allLabelString:(NSMutableArray *)labelname allSelectImageName:(NSMutableArray *)selectarr;//初始化 内容显示的frame tabbar的frame  可以一下传入多个controller
- (void)cpTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;//回调
-(void)cpTabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;//回调

- (void)cpViewWillDisappear:(BOOL)animated;//即将消失
- (void)cpViewWillAppear:(BOOL)animated;//即将出现
@end



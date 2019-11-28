//
//  CP_SecondNavigationView.h
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-30.
//
//

#import <UIKit/UIKit.h>
@protocol CP_SecondDelegate <NSObject>

@optional

- (void)secondDelegateSelectedIndex:(NSInteger)index;//返回当前选的是第几个

@end


@interface CP_SecondNavigationView : UIView{

    UIImageView * bgImgeView;//背景图
//    UIImageView * tiaoImageView;//下滑条
   
    NSInteger selectedIndex;//选择第几个
    
    NSMutableArray * markArray;//所有标记的状态 传字符串1为显示 其他字符串则不显示
    
    NSInteger buttonCount;//统计有多个button
    id<CP_SecondDelegate>delegate;
    bool panduandiyici;
    
    NSArray * myImageArray;
    NSArray * mySelectImageArray;
}


@property (nonatomic, assign)id<CP_SecondDelegate>delegate;
@property (nonatomic, retain)NSMutableArray * markArray;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, retain)UIImageView * bgImgeView;//背景图
//@property (nonatomic, retain)UIImageView * tiaoImageView;

@property (nonatomic, retain)NSArray * myImageArray;
@property (nonatomic, retain)NSArray * mySelectImageArray;

- (id)initWithFrame:(CGRect)frame buttonImageName:(NSArray *)imageArray selectImageName:(NSArray *)selectImageArray;//初始化方法 传所有的图片名字/选中图片的名字
//- (void)animationFunc:(NSInteger)sender;//动画功能
- (void)secondDelegateSelectedIndex:(NSInteger)index;//代理函数

@end

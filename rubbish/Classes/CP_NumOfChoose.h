//
//  CP_NumOfChoose.h
//  caibo
//
//  Created by yaofuyu on 14-3-12.
//
//

#import <UIKit/UIKit.h>


@interface CP_NumOfChoose : UIView {
    id inputLable;//输入框
    NSString *title;
    NSMutableArray *customButtons;//按钮数组
    UIScrollView *backScrollView;
    int minNum;
    int maxNum;
    UIImage *selectImage;
    UIImage *norImage;
    id delegate;
}

- (void)show;
- (id)initWithTitle:(NSString *)title MaxNum:(NSInteger )max MinNum:(NSInteger)min cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

@property (nonatomic, assign)id inputLable;//输入框
@property (nonatomic,copy)NSString *title;
@property (nonatomic, readonly)int minNum;//最小数字
@property (nonatomic, readonly)int maxNum;//最大数字
@property (nonatomic,retain)NSMutableArray *customButtons;
@property (nonatomic,retain)UIImage *norImage,*selectImage;
@property (nonatomic,retain)UIScrollView *backScrollView;
@property (nonatomic, assign)id delegate;

@end

@protocol CP_NumDelegate

@optional
- (void)CP_NumOfChooseView:(CP_NumOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

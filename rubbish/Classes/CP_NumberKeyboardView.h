//
//  CP_NumberKeyboardView.h
//  kongjiantabbat
//
//  Created by houchenguang on 12-12-3.
//
//

#import <UIKit/UIKit.h>
#import "CP_SWButton.h"

@protocol CP_NumberDelegate <NSObject>

- (void)numberKeyBoarViewReturnText:(NSString *)text returnBool:(BOOL)rbool;//返回数字 和开关的值

@end

typedef enum {
    
    CP_NumberKeyboarsSwitchtyle,//带开关按钮的
    CP_NumberKeyboarNormaltyle,//不带开关的
    
}CP_NumberKeyboartyle;



@interface CP_NumberKeyboardView : UIView<UITextFieldDelegate>{

    UITextField*  textfield;
    UIImageView * keybg;
    UIImageView * bgimage;
    UILabel * stopLabel;
    CP_SWButton * sw;
    UIButton * quxiaoButton;
    UIButton * quedingbutton;
    UIImageView * kuangimage;
    id<CP_NumberDelegate>delegate;
    NSString * titleString;
    NSString * fieldTitle;
    NSString * switchTitle;
    UILabel * labelTitle;
    UILabel * issueLabel;
    NSInteger maxValue;
    NSInteger minValue;
    UIImageView * qishuimage;
    UIImageView * titleImage;
    NSInteger textcount;//保存text的值
    UIImageView * zhongview;
    UIImageView * xiaview;
    CP_NumberKeyboartyle numberKeyboarTyle;
}
@property (nonatomic, assign)NSInteger maxValue , minValue;//加减的最大数和最小数
@property (nonatomic, retain)NSString * titleString;//此页面的title的字符串
@property (nonatomic, retain)NSString * fieldTitle;//textfield 前面的字符串
@property (nonatomic, retain)NSString * switchTitle;//开完前的标题
//@property (nonatomic, assign) CP_NumberKeyboartyle numberKeyboarTyle;//风格 是否带开关
@property (nonatomic, assign)id<CP_NumberDelegate>delegate;
- (void)numberKeyBoarViewReturnText:(NSString *)text returnBool:(BOOL)rbool;
- (id)initWithFrame:(CGRect)frame textValue:(NSString *)text switchValue:(BOOL)sbool cpNumberKeyboarTyle:(CP_NumberKeyboartyle)Keyboartyle;//初始化方法
@end

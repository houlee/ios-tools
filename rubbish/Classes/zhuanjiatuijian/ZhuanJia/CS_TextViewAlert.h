//
//  CS_TextViewAlert.h
//  caibo
//
//  Created by cp365dev6 on 2017/1/16.
//
//

#import <UIKit/UIKit.h>

typedef void(^SureButtonAction)(NSString *message);

@interface CS_TextViewAlert : UIView<UITextFieldDelegate>
{
    CGSize size;
}
@property (nonatomic, copy) SureButtonAction sureAction;

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIButton *sureBtn;
@property (nonatomic, retain) UIView *alertView;

-(void)showChangeNicknameAlert;
-(void)showRedbagAlert;

@end

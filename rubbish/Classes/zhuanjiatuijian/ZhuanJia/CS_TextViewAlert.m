//
//  CS_TextViewAlert.m
//  caibo
//
//  Created by cp365dev6 on 2017/1/16.
//
//

#import "CS_TextViewAlert.h"
#import "SharedMethod.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"

@implementation CS_TextViewAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        size = [UIScreen mainScreen].bounds.size;
        
        UIView *blackView = [[UIView alloc]init];
        blackView.frame = frame;
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.6;
        [self addSubview:blackView];
        
//        _alertView = [[UIView alloc]init];
//        _alertView.frame = CGRectMake(15, (size.height - 180)/2.0, size.width-30, 180);
//        _alertView.backgroundColor = [SharedMethod getColorByHexString:@"f5f5f5"];
//        [self addSubview:_alertView];
//        _alertView.layer.masksToBounds = YES;
//        _alertView.layer.cornerRadius = 7;
//        
//        UILabel *titleLab = [[UILabel alloc]init];
//        titleLab.frame = CGRectMake(0, 10, _alertView.frame.size.width, 25);
//        titleLab.backgroundColor = [UIColor clearColor];
//        titleLab.text = @"修改昵称";
//        titleLab.font = [UIFont systemFontOfSize:17];
//        titleLab.textColor = BLACK_EIGHTYSEVER;
//        titleLab.textAlignment = NSTextAlignmentCenter;
//        [_alertView addSubview:titleLab];
//        
//        UILabel *titleLab1 = [[UILabel alloc]init];
//        titleLab1.frame = CGRectMake(0, 35, _alertView.frame.size.width, 20);
//        titleLab1.backgroundColor = [UIColor clearColor];
//        titleLab1.text = @"大侠，起一个霸气的昵称吧！";
//        titleLab1.font = [UIFont systemFontOfSize:14];
//        titleLab1.textColor = BLACK_EIGHTYSEVER;
//        titleLab1.textAlignment = NSTextAlignmentCenter;
//        [_alertView addSubview:titleLab1];
//        
//        _textField = [[UITextField alloc]init];
//        _textField.frame = CGRectMake(25, 60, _alertView.frame.size.width-50, 30);
//        _textField.backgroundColor = [UIColor whiteColor];
//        _textField.font = [UIFont systemFontOfSize:17];
//        _textField.delegate = self;
//        _textField.textColor = BLACK_EIGHTYSEVER;
//        [_alertView addSubview:_textField];
//        
//        UILabel *tishiLab = [[UILabel alloc]init];
//        tishiLab.frame = CGRectMake(25, 90, _alertView.frame.size.width-50, 40);
//        tishiLab.backgroundColor = [UIColor clearColor];
//        tishiLab.text = @"提示:昵称一经确认不可修改，并且可用作用户名登录账号";
//        tishiLab.font = [UIFont systemFontOfSize:11];
//        tishiLab.textColor = BLACK_EIGHTYSEVER;
//        tishiLab.numberOfLines = 0;
//        [_alertView addSubview:tishiLab];
//        
//        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sureBtn.frame = CGRectMake((_alertView.frame.size.width - 110)/2.0, 135, 110, 30);
//        _sureBtn.backgroundColor = [SharedMethod getColorByHexString:@"1da3ff"];
//        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
//        _sureBtn.layer.masksToBounds = YES;
//        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
//        _sureBtn.layer.cornerRadius = 3;
//        _sureBtn.enabled = NO;
//        [_alertView addSubview:_sureBtn];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(textChanged)
//                                                     name:UITextFieldTextDidChangeNotification
//                                                   object:_textField];
    }
    return self;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(15, 100, size.width-30, 180);
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.frame = CGRectMake(15, (size.height - 180)/2.0, size.width-30, 180);
    }];
}
-(void)textChanged{
    
    if(_textField.text.length > 0){
        _sureBtn.enabled = YES;
    }else{
        _sureBtn.enabled = NO;
    }
}

-(void)sureAction:(UIButton *)button{
    [self endEditing:YES];
    NSString *nickNameStr = _textField.text;
    NSStringEncoding gb2312 = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    unsigned short nickNameStrLen = [nickNameStr lengthOfBytesUsingEncoding:(gb2312)];
    if(_textField.text.length == 0){
        [[caiboAppDelegate getAppDelegate] showMessage:@"昵称不能为空"];
        return;
    }
    else if([_textField.text isAllNumber])
    {
        [[caiboAppDelegate getAppDelegate] showMessage:@"昵称不能全部为数字"];
        return;
    }
    else if ([_textField.text isContainSign])
    {
        [[caiboAppDelegate getAppDelegate] showMessage:@"昵称不能包含特殊字符"];
        return;
    }
    else if (nickNameStrLen < 6||nickNameStrLen > 16)
    {
        [[caiboAppDelegate getAppDelegate] showMessage:@"昵称长度不符"];
        return;
    }
    
    if(self.sureAction){
        self.sureAction(_textField.text);
    }
    [self removeFromSuperview];
}
-(void)showChangeNicknameAlert{
    
    _alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(15, (size.height - 180)/2.0, size.width-30, 180);
    _alertView.backgroundColor = [SharedMethod getColorByHexString:@"f5f5f5"];
    [self addSubview:_alertView];
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 7;
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake(0, 10, _alertView.frame.size.width, 25);
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"修改昵称";
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = BLACK_EIGHTYSEVER;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:titleLab];
    
    UILabel *titleLab1 = [[UILabel alloc]init];
    titleLab1.frame = CGRectMake(0, 35, _alertView.frame.size.width, 20);
    titleLab1.backgroundColor = [UIColor clearColor];
    titleLab1.text = @"大侠，起一个霸气的昵称吧！";
    titleLab1.font = [UIFont systemFontOfSize:14];
    titleLab1.textColor = BLACK_EIGHTYSEVER;
    titleLab1.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:titleLab1];
    
    _textField = [[UITextField alloc]init];
    _textField.frame = CGRectMake(25, 60, _alertView.frame.size.width-50, 30);
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.delegate = self;
    _textField.textColor = BLACK_EIGHTYSEVER;
    [_alertView addSubview:_textField];
    
    UILabel *tishiLab = [[UILabel alloc]init];
    tishiLab.frame = CGRectMake(25, 90, _alertView.frame.size.width-50, 40);
    tishiLab.backgroundColor = [UIColor clearColor];
    tishiLab.text = @"提示:昵称一经确认不可修改，并且可用作用户名登录账号";
    tishiLab.font = [UIFont systemFontOfSize:11];
    tishiLab.textColor = BLACK_EIGHTYSEVER;
    tishiLab.numberOfLines = 0;
    [_alertView addSubview:tishiLab];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake((_alertView.frame.size.width - 110)/2.0, 135, 110, 30);
    _sureBtn.backgroundColor = [SharedMethod getColorByHexString:@"1da3ff"];
    
#ifdef CRAZYSPORTS
    _sureBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
    
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    _sureBtn.layer.masksToBounds = YES;
    [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.enabled = NO;
    [_alertView addSubview:_sureBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChanged)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_textField];
}
-(void)showRedbagAlert{
    
    UIImageView *redBagIma = [[UIImageView alloc]init];
    redBagIma.frame = CGRectMake((size.width-270)/2.0, (size.height-355)/2.0, 270, 355);
    redBagIma.backgroundColor = [UIColor clearColor];
    redBagIma.image = [UIImage imageNamed:@"CS_Redbag_image.png"];
    redBagIma.userInteractionEnabled = YES;
    [self addSubview:redBagIma];
    
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getBtn.frame = CGRectMake(95, 180, 80, 80);
    getBtn.backgroundColor = [UIColor clearColor];
    getBtn.tag = 1;
    [getBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(redbagAction:) forControlEvents:UIControlEventTouchUpInside];
    [redBagIma addSubview:getBtn];
    
    UIButton *offBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    offBtn.frame = CGRectMake(10, 10, 20, 20);
    offBtn.backgroundColor = [UIColor clearColor];
    offBtn.tag = 2;
    [offBtn setBackgroundImage:[UIImage imageNamed:@"CS_Redbag_off.png"] forState:UIControlStateNormal];
    [offBtn addTarget:self action:@selector(redbagAction:) forControlEvents:UIControlEventTouchUpInside];
    [redBagIma addSubview:offBtn];
    
}
-(void)redbagAction:(UIButton *)button{
    
    if(button.tag == 1){
        
        if(self.sureAction){
            self.sureAction(@"");
        }
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
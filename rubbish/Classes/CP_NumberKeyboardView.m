//
//  CP_NumberKeyboardView.m
//  kongjiantabbat
//
//  Created by houchenguang on 12-12-3.
//
//

#import "CP_NumberKeyboardView.h"
#import "QuartzCore/QuartzCore.h"

@implementation CP_NumberKeyboardView
@synthesize delegate;
@synthesize maxValue, minValue;
//@synthesize numberKeyboarTyle;

- (void)dealloc{
    [titleString release];
    [fieldTitle release];
    
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [super dealloc];
}
#pragma mark 此页面的title 和 textfield前面的title 的 get set方法

- (NSString *)switchTitle{
    return switchTitle;
}

- (void)setSwitchTitle:(NSString *)_switchTitle{
    if (switchTitle != _switchTitle) {
        [switchTitle release];
        switchTitle = [_switchTitle retain];
    }
    stopLabel.text = _switchTitle;
}

- (NSString *)titleString{
    return titleString;
}

- (NSString *)fieldTitle{
    return fieldTitle;
}

- (void)setFieldTitle:(NSString *)_fieldTitle{
    if (fieldTitle != _fieldTitle) {
        [fieldTitle release];
        fieldTitle = [_fieldTitle retain];
    }
    
    
     issueLabel.text = fieldTitle;
    
}

- (void)setTitleString:(NSString *)_titleString{
    
    if (titleString != _titleString) {
        [titleString release];
        titleString = [_titleString retain];
    }
    
    labelTitle.text = titleString;
}


#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame textValue:(NSString *)text switchValue:(BOOL)sbool cpNumberKeyboarTyle:(CP_NumberKeyboartyle)Keyboartyle;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        numberKeyboarTyle = Keyboartyle;
       self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 313)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        
       // bgimage.image = [UIImage imageNamed:@"TSBG960.png"];
        
        UIImageView * shangimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 97)];
        shangimage.backgroundColor = [UIColor clearColor];
        shangimage.image = [UIImage imageNamed:@"shang123.png"];
        [bgimage addSubview:shangimage];
        [shangimage release];
        
        zhongview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 93, 300, 0)];
        zhongview.image = [UIImage imageNamed:@"zhongjian7.png"];
        zhongview.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:zhongview];
        [zhongview release];
        
       
        xiaview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 93, 300, 106)];
        xiaview.image = [UIImage imageNamed:@"xia456.png"];
        xiaview.backgroundColor = [UIColor clearColor];
        [bgimage addSubview:xiaview];
        [xiaview release];
        
        titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(85, -1, 124, 30)];
        titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
        titleImage.backgroundColor = [UIColor  clearColor];
        [bgimage addSubview:titleImage];
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 114, 30)];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        labelTitle.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        labelTitle.font = [UIFont boldSystemFontOfSize:12];
        labelTitle.shadowColor = [UIColor whiteColor];//阴影
        labelTitle.shadowOffset = CGSizeMake(0, 1.0);
        [titleImage addSubview:labelTitle];
        [labelTitle release];
        
        
         kuangimage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 35, 256, 108)];
        kuangimage.backgroundColor = [UIColor clearColor];
        kuangimage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20];
        [bgimage addSubview:kuangimage];
        
        
        quxiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoButton.frame = CGRectMake(25, 153, 120, 35);
        //[quxiaoButton setImage:[UIImage imageNamed:@"TYD960.png"] forState:UIControlStateNormal];
        [quxiaoButton addTarget:self action:@selector(pressquxiao:) forControlEvents:UIControlEventTouchUpInside];
        [quxiaoButton setBackgroundImage:[[UIImage imageNamed:@"TYD960.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:34] forState:UIControlStateNormal];
        //[quxiaoButton setTitle:@"取消" forState:UIControlStateNormal];
        
        UILabel * labelQuxiao = [[UILabel alloc] initWithFrame:quxiaoButton.bounds];
        labelQuxiao.backgroundColor = [UIColor clearColor];
        labelQuxiao.textAlignment = NSTextAlignmentCenter;
        labelQuxiao.text = @"取消";
        labelQuxiao.textColor = [UIColor  whiteColor];
        labelQuxiao.font = [UIFont boldSystemFontOfSize:13];
        labelQuxiao.shadowColor = [UIColor blackColor];//阴影
        labelQuxiao.shadowOffset = CGSizeMake(0, 1.0);
        [quxiaoButton addSubview:labelQuxiao];
        [labelQuxiao release];
        
        
        [bgimage addSubview:quxiaoButton];
        
        quedingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        quedingbutton.frame = CGRectMake(155, 153, 120, 35);
        //[quxiaoButton setImage:[UIImage imageNamed:@"TYD960.png"] forState:UIControlStateNormal];
        [quedingbutton addTarget:self action:@selector(pressquedingbutton:) forControlEvents:UIControlEventTouchUpInside];
        [quedingbutton setBackgroundImage:[[UIImage imageNamed:@"TYD960.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:34] forState:UIControlStateNormal];
       // [quedingbutton setTitle:@"确定" forState:UIControlStateNormal];
        UILabel * labelQueding = [[UILabel alloc] initWithFrame:quedingbutton.bounds];
        labelQueding.backgroundColor = [UIColor clearColor];
        labelQueding.textAlignment = NSTextAlignmentCenter;
        labelQueding.text = @"完成";
        labelQueding.textColor = [UIColor  whiteColor];
        labelQueding.font = [UIFont boldSystemFontOfSize:13];
        labelQueding.shadowColor = [UIColor blackColor];//阴影
        labelQueding.shadowOffset = CGSizeMake(0, 1.0);
        [quedingbutton addSubview:labelQueding];
        [labelQueding release];
        
        [bgimage addSubview:quedingbutton];
        
        
        qishuimage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, 130, 30)];
        qishuimage.backgroundColor =  [UIColor clearColor];
        qishuimage.userInteractionEnabled = YES;
        qishuimage.image = [[UIImage imageNamed:@"TXWZBG960.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:15];
        [bgimage addSubview:qishuimage];
        [qishuimage release];
        
        
        issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 40, 30)];
        issueLabel.backgroundColor = [UIColor clearColor];
        issueLabel.textAlignment = NSTextAlignmentLeft;
       
        issueLabel.textColor = [UIColor  colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        issueLabel.font = [UIFont systemFontOfSize:12];
//        issueLabel.shadowColor = [UIColor blackColor];//阴影
//        issueLabel.shadowOffset = CGSizeMake(0, 1.0);
        [qishuimage addSubview:issueLabel];
        [issueLabel release];
        
        textfield = [[UITextField alloc] initWithFrame:CGRectMake(32,8, 90, 20)];
        textfield.autocorrectionType = UITextAutocorrectionTypeYes;
        textfield.textAlignment = NSTextAlignmentCenter;
       // textfield.returnKeyType = UIReturnKeyDone;
        textfield.text = text;
        [textfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:12];
        [qishuimage addSubview:textfield];
        [textfield release];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillShow:)
//                                                     name:UIKeyboardDidShowNotification
//                                                   object:nil];
        
        UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        addbutton.frame = CGRectMake(165, 50, 49, 29);
        [addbutton addTarget:self action:@selector(pressAddButton:) forControlEvents:UIControlEventTouchUpInside];
        [addbutton setBackgroundImage:[[UIImage imageNamed:@"TYX960.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
      //  [addbutton setTitle:@"+" forState:UIControlStateNormal];
        UILabel * jia = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 49, 29)];
        jia.backgroundColor = [UIColor clearColor];
        jia.textAlignment = NSTextAlignmentCenter;
        jia.text = @"+";
        jia.textColor = [UIColor  whiteColor];
        jia.font = [UIFont boldSystemFontOfSize:16];
        jia.shadowColor = [UIColor blackColor];//阴影
        jia.shadowOffset = CGSizeMake(0, 1.0);
        [addbutton addSubview:jia];
        [jia release];

        
        [bgimage addSubview:addbutton];
        
        
        UIButton * jianbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        jianbutton.frame = CGRectMake(217, 50, 49, 29);
         [jianbutton addTarget:self action:@selector(pressJianbutton:) forControlEvents:UIControlEventTouchUpInside];
        [jianbutton setBackgroundImage:[[UIImage imageNamed:@"TYX960.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
     //   [jianbutton setTitle:@"-" forState:UIControlStateNormal];
        UILabel * jianl = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, 49, 29)];
        jianl.backgroundColor = [UIColor clearColor];
        jianl.textAlignment = NSTextAlignmentCenter;
        jianl.text = @"-";
        jianl.textColor = [UIColor  whiteColor];
        jianl.font = [UIFont boldSystemFontOfSize:16];
        jianl.shadowColor = [UIColor blackColor];//阴影
        jianl.shadowOffset = CGSizeMake(0, 1.0);
        [jianbutton addSubview:jianl];
        [jianl release];
        [bgimage addSubview:jianbutton];
        
        
        [self addSubview:bgimage];
        [bgimage release];
        [titleImage release];
        [kuangimage release];
        
        
        UIImageView * lineimage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 91, 256, 1)];
        lineimage.backgroundColor = [UIColor clearColor];
        lineimage.image = [UIImage imageNamed:@"SSSSFGX960.png"];
        [bgimage addSubview:lineimage];
        [lineimage release];
        
        
//        baifenLabel.font = [UIFont boldSystemFontOfSize:8];
//        baifenLabel.shadowColor = [UIColor blackColor];//阴影
//        baifenLabel.shadowOffset = CGSizeMake(0, 1.0);
        
        if (numberKeyboarTyle == CP_NumberKeyboarsSwitchtyle) {
            stopLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 108, 120, 20)];
            stopLabel.backgroundColor = [UIColor clearColor];
            stopLabel.textAlignment = NSTextAlignmentLeft;
            
            stopLabel.textColor = [UIColor  colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
            stopLabel.font = [UIFont systemFontOfSize:12];
            //        stopLabel.shadowColor = [UIColor blackColor];//阴影
            //        stopLabel.shadowOffset = CGSizeMake(0, 1.0);
            [bgimage addSubview:stopLabel];
            [stopLabel release];
            
            
            sw = [[CP_SWButton alloc] initWithFrame:CGRectMake(180, 105, 77, 27)];
            sw.onImageName = @"heji2-640_10.png";
            sw.offImageName = @"heji2-640_11.png";
            sw.on = sbool;
            [sw addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged];
            [bgimage addSubview:sw];
            [sw release];
            

        }
               
        
        keybg = [[UIImageView alloc] initWithFrame:CGRectMake(22, 91, 256, 0)];
        keybg.backgroundColor = [UIColor clearColor];
        keybg.userInteractionEnabled = YES;
        keybg.image = UIImageGetImageFromName(@"ZHBBG960.png");
        [keybg.layer setMasksToBounds:YES];
        //CGRectMake(22, 98, 256, 110)
        
        float width = 39;
        float height = 39;
        NSInteger tagcount = 0;
        for (int i = 0; i < 2; i++) {
            for (int a = 0; a < 6; a++) {
                UIButton * dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
                dataButton.frame = CGRectMake(a*width+2.5*a+5, i*height+11+2.5*i, width, height);
                [dataButton setImage:UIImageGetImageFromName(@"ZHBANBG960.png") forState:UIControlStateNormal];
                dataButton.tag = tagcount;
                [dataButton addTarget:self action:@selector(pressDataButton:) forControlEvents:UIControlEventTouchUpInside];
                if (tagcount <= 9 || tagcount == 11) {
                    
                    
                    UILabel * buttonTitle = [[UILabel alloc] initWithFrame:dataButton.bounds];
                    buttonTitle.backgroundColor = [UIColor clearColor];
                    buttonTitle.textAlignment = NSTextAlignmentCenter;
                    buttonTitle.textColor = [UIColor  whiteColor];
                    buttonTitle.font = [UIFont boldSystemFontOfSize:13];
                    buttonTitle.shadowColor = [UIColor blackColor];//阴影
                    buttonTitle.shadowOffset = CGSizeMake(0, 1.0);
                    if (tagcount <= 9) {
                        buttonTitle.text = [NSString stringWithFormat:@"%ld", (long)tagcount];
                    }else if(tagcount == 11){
                        buttonTitle.text = @"完成";
                    }
                    [dataButton addSubview:buttonTitle];
                    [buttonTitle release];
                    
                }else if(tagcount == 10){
                
                    UIImageView * buttonBg = [[UIImageView alloc] initWithFrame:CGRectMake((width-24)/2, (height-14)/2, 24, 14)];
                    buttonBg.backgroundColor = [UIColor clearColor];
                    buttonBg.image = [UIImage imageNamed:@"ZHBANX960.png"];
                    [dataButton addSubview:buttonBg];
                    [buttonBg release];
                    
                }
                tagcount += 1;
                [keybg addSubview:dataButton];
                
            }
        }
        
        
        [bgimage addSubview:keybg];
        [keybg release];
        
#ifdef isCaiPiaoForIPad
        bgimage.frame = CGRectMake(45, 230, 300, 313);
#endif
        
    }
    return self;
}


- (void)keyboardWillShow:(NSNotification *)note
{
    
    // create custom button
//    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    doneButton.frame = CGRectMake(0, 163, 106, 53);
//    doneButton.adjustsImageWhenHighlighted = NO;
//    //    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
//    //    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    doneButton.backgroundColor = [UIColor clearColor];
//    
//    UILabel * quedingla = [[UILabel alloc] initWithFrame:doneButton.bounds];
//    quedingla.backgroundColor = [UIColor clearColor];
//    quedingla.text = @"确定";
//    quedingla.textAlignment = NSTextAlignmentCenter;
//    quedingla.textColor = [UIColor blackColor];
//    quedingla.font = [UIFont systemFontOfSize:15];
//    [doneButton addSubview:quedingla];
//    [quedingla release];
    
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
      //  keyhiegh = keyboard.frame.size.height;
        //if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)// OS 3.0
        NSLog(@"xkey = %@", [keyboard description]);
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||(([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES))){
            
            keyboard.hidden = YES;
            
            
        }
        

        
        return;
    }
    
    
}

- (void)keyshow{
   // titleImage.frame = CGRectMake(85, -2, 124, 30);
  //  bgimage.image = [UIImage imageNamed:@"TYHBG960-1.png"];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  //  bgimage.frame = CGRectMake(10, 100, 300, 313);
  //   titleImage.frame = CGRectMake(85, -1, 124, 30);
     xiaview.frame = CGRectMake(0, 200, 300, 106);
    zhongview.frame = CGRectMake(0, 93, 300, 110);
    qishuimage.image = [[UIImage imageNamed:@"XWZBG960_1.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:15];
    quedingbutton.frame = CGRectMake(155, 262, 120, 35);
    quxiaoButton.frame = CGRectMake(25, 262, 120, 35);
    stopLabel.frame = CGRectMake(35, 218, 120, 20);
    sw.frame = CGRectMake(180, 215, 77, 27);
    kuangimage.frame = CGRectMake(21, 35, 256, 218);
    keybg.frame = CGRectMake(21, 91, 256, 102);
}

- (void)keyhidden{
  //   titleImage.frame = CGRectMake(85, 2, 124, 30);
  //  bgimage.image = [UIImage imageNamed:@"TSBG960.png"];
    [UIView beginAnimations:@"ndd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    zhongview.frame = CGRectMake(0, 93, 300, 0);
     xiaview.frame = CGRectMake(0, 93, 300, 106);
  //  bgimage.frame = CGRectMake(10, 100, 300, 203);
  //   titleImage.frame = CGRectMake(85, -1, 124, 30);
    qishuimage.image = [[UIImage imageNamed:@"TXWZBG960.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:15];
    quedingbutton.frame = CGRectMake(155, 153, 120, 35);
    quxiaoButton.frame = CGRectMake(25, 153, 120, 35);
    stopLabel.frame = CGRectMake(35, 108, 120, 20);
    sw.frame = CGRectMake(180, 105, 77, 27);
    kuangimage.frame = CGRectMake(21, 35, 256, 108);
    keybg.frame = CGRectMake(21, 91, 256, 0);
    
    [UIView commitAnimations];
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
   // [self resignKeyBoardInView:self];
    if (textField.tag == 0) {
        textcount =  [textfield.text intValue];
        textfield.text =  @"";
        [self keyshow];
        [UIView commitAnimations];
        textField.tag = 1;
    }else{
        if ([textfield.text isEqualToString:@""]) {
            textfield.text = [NSString stringWithFormat:@"%ld", (long)textcount];
        }
        textField.tag = 0;
        [self keyhidden];
    }
    
    
    
    
    return NO;
}
#pragma mark 按钮的触发事件
- (void)pressDataButton:(UIButton *)sender{
    
    if (sender.tag <= 9) {
        if ([textfield.text length] == 0) {
            textfield.text = @"";
        }
        textfield.text = [NSString stringWithFormat:@"%@%ld", textfield.text, (long)sender.tag];
        
    }else if (sender.tag == 10) {
        if ([textfield.text length]>1) {
            textfield.text = [textfield.text substringToIndex:[textfield.text length] -1];
        }else{
            textfield.text = @"";
        }
        
        
    }else if (sender.tag == 11) {
        
        if (textfield.tag == 1) {
            if ([textfield.text isEqualToString:@""]) {
                textfield.text = [NSString stringWithFormat:@"%ld", (long)textcount];
            }
            
            [self keyhidden];
            
            [UIView commitAnimations];
        }
        textfield.tag = 0;
    }
    
    if ([textfield.text length] > 1) {
        if ([textfield.text intValue] >= maxValue) {
            textfield.text = [NSString stringWithFormat:@"%ld", (long)maxValue];
        }
        if ([textfield.text intValue] <= minValue) {
            textfield.text = [NSString stringWithFormat:@"%ld", (long)minValue];
        }
    }
   

}

- (void)pressSwitch:(UISwitch *)sender{
    //sw.on = sender.on;

}

- (void)pressJianbutton:(UIButton *)sender{

    if ([textfield.text intValue] <= minValue) {
        textfield.text = [NSString stringWithFormat:@"%ld", (long)minValue];
    }else{
        textfield.text = [NSString stringWithFormat:@"%d",[textfield.text intValue]-1];
    }
}

- (void)pressAddButton:(UIButton *)sender{
    if ([textfield.text intValue] >= maxValue) {
        textfield.text = [NSString stringWithFormat:@"%ld", (long)maxValue];
    }else{
        textfield.text = [NSString stringWithFormat:@"%d",[textfield.text intValue]+1];
    }

}

- (void)pressquxiao:(UIButton *)sender{
    [self removeFromSuperview];
    
}

- (void)pressquedingbutton:(UIButton *)sender{
    [self numberKeyBoarViewReturnText:textfield.text returnBool:sw.on];
    [self removeFromSuperview];
    

}

#pragma mark  此view的delegate
- (void)numberKeyBoarViewReturnText:(NSString *)text returnBool:(BOOL)rbool{

    if ([delegate respondsToSelector:@selector(numberKeyBoarViewReturnText:returnBool:)]) {
        [delegate numberKeyBoarViewReturnText:text returnBool:rbool];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  EditText.m
//  caibo
//
//  Created by jeff.pluto on 11-7-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EditText.h"
#import "QuartzCore/QuartzCore.h"
#import "UserListMailController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "ProgressBar.h"
#import "Info.h"
#import "JSON.h"

@implementation EditText

@synthesize delegate = _delegate;
@synthesize editText,showFaceBtn,sendBtn,mDeleteText;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setUserInteractionEnabled:YES];
        [self setImage:UIImageGetImageFromName(@"wb19.png")];
        
        //内容输入框背景
        nrImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 7, 220, 30)];
//        nrImage.image = UIImageGetImageFromName(@"TXWZBG960.png");
        nrImage.image = [nrImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        nrImage.userInteractionEnabled = YES;
        [self addSubview:nrImage];
        // [nrImage insertSubview:self.editText aboveSubview:0];
        [nrImage release];

                
        // 添加表情按钮
        showFaceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [showFaceBtn setFrame:CGRectMake(3, 8, 25, 25)];
        [showFaceBtn setFrame:CGRectMake(5, 10, 25, 25)];
        //[showFaceBtn setImage:UIImageGetImageFromName(@"addFace_gray.png") forState:(UIControlStateNormal)];
        //[showFaceBtn setImage:UIImageGetImageFromName(@"addFace_orin.png") forState:(UIControlStateSelected)];
        [showFaceBtn setImage:UIImageGetImageFromName(@"wb5.png") forState:UIControlStateNormal];
        [showFaceBtn addTarget:self action:@selector(actionShowFaceSystemOrKeyboard:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 发送按钮
        sendBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setEnabled:NO];
        [sendBtn setFrame:CGRectMake(263, 7, 52, 31)];
//        [sendBtn loadButonImage:@"TYD960.png" LabelName:@"发送"];
        [sendBtn loadButonImage:@"tongyonglan.png" LabelName:@"发送"];
        sendBtn.buttonName.textColor=[UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
        
//        sendBtn.buttonName.font = [UIFont boldSystemFontOfSize:15];
        sendBtn.buttonName.font = [UIFont systemFontOfSize:15];
        sendBtn.buttonImage.frame = sendBtn.bounds;
        sendBtn.buttonImage.image = [sendBtn.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        //[sendBtn setImage:UIImageGetImageFromName(@"btn_send_blue_btn.png") forState:(UIControlStateNormal)];
        
        // 输入框控件
//        editText = [[GrowingTextView alloc] initWithFrame:CGRectMake(3, -2, 210, 31)];
        editText = [[GrowingTextView alloc] initWithFrame:CGRectMake(5, 0, 210, 31)];
        editText.minNumberOfLines = 1;
        editText.maxNumberOfLines = 5;
        editText.font = [UIFont fontWithName:@"Helvetica" size:17];
        editText.delegate = _delegate;
        //[editText.layer setBackgroundColor:[[UIColor clearColor] CGColor]];
//        [editText.layer setBorderColor:[[UIColor grayColor] CGColor]];
//        [editText.layer setBorderWidth:1.0];
//        [editText.layer setCornerRadius:16.0];
        [editText.layer setMasksToBounds:YES];
        [editText setClipsToBounds:YES];
        
                
        // 清除文字按钮
        mDeleteText = [UIButton buttonWithType:UIButtonTypeCustom];
        [mDeleteText setHidden:YES];
        [mDeleteText setFrame: CGRectMake(255, 7, 45, 14)];
        [mDeleteText setTitle:@"300" forState:(UIControlStateNormal)];
        [mDeleteText setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, -90))];
        [mDeleteText setImage:UIImageGetImageFromName(@"kbd_crossBtn.png") forState:(UIControlStateNormal)];
        
        [self addSubview:sendBtn];
        [nrImage addSubview:editText];
        [self addSubview:showFaceBtn];
        [self addSubview:mDeleteText];
        
#ifdef isCaiPiaoForIPad
       
        nrImage.frame = CGRectMake(70, 7, 220, 30);// = [[UIImageView alloc] initWithFrame:CGRectMake(35, 7, 220, 30)];
//        editText.frame = CGRectMake(38, -2, 210, 31);// = [[GrowingTextView alloc] initWithFrame:CGRectMake(3, -2, 210, 31)];
        [sendBtn setFrame:CGRectMake(263+35, 7, 52, 31)];
        [showFaceBtn setFrame:CGRectMake(38, 8, 25, 25)];
#endif
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    nrImage.frame = CGRectMake(35, 7, 220, frame.size.height - 14);
#ifdef isCaiPiaoForIPad
    nrImage.frame = CGRectMake(70, 7, 220, frame.size.height - 14);
#endif
}

// 实现偏移动画
- (void) setContentOffset:(CGPoint)offset {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [self setCenter:offset];
    [UIView commitAnimations];
}

// 显示键盘或者表情
- (IBAction) actionShowFaceSystemOrKeyboard:(UIButton *)sender {
//    CGPoint tmpPoint;
    if(showFaceBtn.selected) {
        [showFaceBtn setSelected:NO];
        [editText.internalTextView becomeFirstResponder];
        if ([_delegate respondsToSelector:@selector(keyBoardShow)]) {
            [_delegate performSelector:@selector(keyBoardShow)];
		}
//        tmpPoint = CGPointMake(160, 178);
    } else {
        [showFaceBtn setSelected:YES];
        [editText.internalTextView resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(keyBoardDismiss)]) {
			[_delegate performSelector:@selector(keyBoardDismiss)];
		}
//        tmpPoint = CGPointMake(160, 222);
    }
////    CGPoint tmpPoint = CGPointMake(160, 178);
//    [self setContentOffset:tmpPoint];
}

// 将该控件恢复到初始状态
- (void) resumeDefaultAndKeyBoardIsShow:(BOOL)isShow {
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    CGRect r = self.frame;
//    if (isShow == 5) {
//        r.origin.y = 199;
//    } else
    if (isShow) {
        r.origin.y = app.window.frame.size.height - 64 - 44 - 216;//156;
    } else {
        r.origin.y = app.window.frame.size.height - 64 - 44;//372;
    }
    r.size.height = 44;
    [self setFrame:r];
    
    [editText setFrame:CGRectMake(43, 7, 210, 31)];
    [nrImage setFrame:CGRectMake(35, 7, 220, 30)];
    [editText.internalTextView setText:@""];
//    editText.frame = CGRectMake(3, -2, 210, 31);
    editText.frame = CGRectMake(5, 0, 210, 31);
//    [showFaceBtn setFrame:CGRectMake(3, 8, 32, 32)];
    [showFaceBtn setFrame:CGRectMake(5, 10, 32, 32)];
    [sendBtn setFrame:CGRectMake(263, 7, 52, 31)];
    
    [mDeleteText setTitle:@"300" forState:(UIControlStateNormal)];
    sendBtn.enabled = false;
    mDeleteText.hidden = YES;
#ifdef isCaiPiaoForIPad
    [editText resignFirstResponder];
    [nrImage setFrame:CGRectMake(70, 7, 220, 30)];
    
    [sendBtn setFrame:CGRectMake(263+35, 7, 52, 31)];
    [showFaceBtn setFrame:CGRectMake(38, 8, 25, 25)];
    

#endif
}

- (void) dealloc {
    [editText release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
//
//  CP_NumOfChoose.m
//  caibo
//
//  Created by yaofuyu on 14-3-12.
//
//

#import "CP_NumOfChoose.h"
#import "CP_PTButton.h"
#import "UIImageExtra.h"
#import "caiboAppDelegate.h"
#import "ImageUtils.h"

@implementation CP_NumOfChoose
@synthesize inputLable;
@synthesize title;
@synthesize minNum,maxNum;
@synthesize customButtons;
@synthesize selectImage;
@synthesize norImage;
@synthesize backScrollView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    return self;
}

- (void)alertViewclickButton:(UIButton *)sender  {
    if (delegate && [delegate respondsToSelector:@selector(CP_NumOfChooseView:didDismissWithButtonIndex:)]) {
        [delegate CP_NumOfChooseView:self didDismissWithButtonIndex:sender.tag];
    }
    if (sender.tag == 1) {
        if (inputLable && [inputLable isKindOfClass:[UILabel class]]) {
            for (CP_PTButton *btn in backScrollView.subviews) {
                if ([btn isKindOfClass:[CP_PTButton class]] && btn.selected) {
                    [(UILabel *)inputLable setText:btn.buttonName.text];
                    break;
                }
            }
            
        }
    }
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (id)initWithTitle:(NSString *)_title MaxNum:(NSInteger )max MinNum:(NSInteger)min cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];;
        self.title = _title;
        maxNum = (int)max;
        minNum = (int)min;
        if (cancelButtonTitle || otherButtonTitle) {
            self.customButtons = [NSMutableArray array];
            int i = 0;
            if (cancelButtonTitle) {
                
                CP_PTButton *canclebutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                [canclebutton setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];

                canclebutton.tag =i;
                i++;
                canclebutton.backgroundColor = [UIColor clearColor];
                // @"TYD960.png"
                [canclebutton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
                [canclebutton loadButonImage:nil LabelName:cancelButtonTitle];
                canclebutton.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
                [canclebutton addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:canclebutton];
                [canclebutton release];
            }
            if(otherButtonTitle)
            {
                
                
                CP_PTButton *button =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                button.tag =i;
                i++;
                button.backgroundColor = [UIColor clearColor];
                [button loadButonImage:nil LabelName:otherButtonTitle];
                button.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
                [button setBackgroundImage:UIImageGetImageFromName(@"alert_right_highlight.png") forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(alertViewclickButton:) forControlEvents:UIControlEventTouchUpInside];
                [customButtons addObject:button];
                [button release];
            }
        }

        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)selectCickeChuan:(CP_PTButton *)sender {
    
    sender.buttonName.textColor = [UIColor whiteColor];
    for (CP_PTButton *btn in backScrollView.subviews) {
        if ([btn isKindOfClass:[CP_PTButton class]] ) {
            btn.buttonName.textColor = [UIColor blackColor];
            btn.selected = NO;
        }
            
    }
    sender.buttonName.textColor = [UIColor  whiteColor];
    sender.selected = YES;
}

- (void)show {
    UIImageView *backImageV = [[UIImageView alloc] init];
    // huntoukuangnew.png
    // backImageV.image = UIImageGetImageFromName(@"TYHBG960-1.png");
    backImageV.frame = CGRectMake(10, 100, 270, 195 + 30);
    backImageV.userInteractionEnabled = YES;
    // backImageV.center = self.center;
    backImageV.image = [UIImageGetImageFromName(@"huntoukuangnew_1.png") stretchableImageWithLeftCapWidth:150 topCapHeight:15];
    [self addSubview:backImageV];
    
    
    float backHeight = 15;
    if (self.title) {

        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, backImageV.frame.size.width, 20)];
        lable.text = self.title;
        [backImageV addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        lable.font = [UIFont systemFontOfSize:17];
        lable.backgroundColor = [UIColor clearColor];
        [lable release];
        backHeight = backHeight + 20;
    }
    
        UIImageView *infoImage = [[UIImageView alloc] init];
        infoImage.backgroundColor = [UIColor clearColor];
        if (maxNum - minNum <= 14) {
            infoImage.frame = CGRectMake(0, 38+20-10 , 270, ((maxNum - minNum )/3 + 1) *45+5 );
            backHeight = backHeight + ((maxNum - minNum)/3 + 1) *45  + 5;
        }else {
            infoImage.frame = CGRectMake(0, 38 + 20-10, 270, 260+9 );
            backHeight = backHeight + 270;
        }
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        [infoImage release];
        UIScrollView *backScrollView1 = [[UIScrollView alloc] initWithFrame:infoImage.bounds];
        backScrollView1.contentSize = CGSizeMake(256, ((maxNum - minNum)/3 + 1) *45+20 );
        [infoImage addSubview:backScrollView1];
        self.backScrollView = backScrollView1;
        [backScrollView1 release];
        for (int i = 0; i<= maxNum - minNum; i++) {
            int a = i%3;
            int b = i/3;
            CP_PTButton *testBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
            testBtn.frame = CGRectMake(21+79 *a, 18 + b*45, 67, 30);
            testBtn.tag = i;

            [testBtn loadButonImage:@"btn_gray_selected.png"  LabelName:[NSString stringWithFormat:@"%d",i + minNum]];
            
            if (selectImage) {
                testBtn.selectImage = self.selectImage;
                testBtn.buttonName.textColor = [UIColor whiteColor];
            }
            
            if (self.norImage) {

                testBtn.buttonName.textColor = [UIColor blackColor];
            }
            
//            testBtn.buttonName.textColor = [UIColor whiteColor];ddddd
//            if (testBtn.tag == 0) {
//                testBtn.buttonName.textColor = [UIColor whiteColor];
//            }else {
                testBtn.buttonName.textColor = [UIColor blackColor];
//            }
            [testBtn addTarget:self action:@selector(selectCickeChuan:) forControlEvents:UIControlEventTouchUpInside];
            [backScrollView addSubview:testBtn];
        }
    
    if ([customButtons count]) {
        float btnWith = 270.0/[customButtons count];
        for (int i = 0; i < [self.customButtons count]; i++) {
            CP_PTButton *btn = [customButtons objectAtIndex:i];
            if(i==0){
                btn.frame = CGRectMake(0, backHeight + 14, btnWith-1, 44);

            }
            else{
                btn.frame = CGRectMake(btnWith*i+1, backHeight + 14, btnWith, 44);

            }
            btn.buttonName.frame = btn.bounds;
            // btn.buttonImage.image = [btn.buttonImage.image stretchableImageWithLeftCapWidth:11 topCapHeight:17];
            [backImageV addSubview:btn];
        }
        backHeight = backHeight +48;
    }
    backImageV.frame = CGRectMake(10, 100, 270, backHeight + 10);
//    backImageV.image = [backImageV.image imageFromImage:backImageV.image inRect:backImageV.bounds];
    backImageV.image = [UIImageGetImageFromName(@"huntoukuangnew_1.png") stretchableImageWithLeftCapWidth:150 topCapHeight:15];

    backImageV.center = self.center;
//    if (backHeight >300) {
//        titleImage.frame = CGRectMake(87.5,  0, 125, 30);
//    }
//    else if (backHeight > 250) {
//        titleImage.frame = CGRectMake(87.5,  -1, 125, 30);
//    }
//    else if (backHeight > 200) {
//        titleImage.frame = CGRectMake(87.5,  -2, 125, 30);
//    }
//    else {
//        titleImage.frame = CGRectMake(87.5,  -1, 125, 30);
//    }
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
     [backImageV release];
}

- (void)dealloc {
    self.backScrollView = nil;
    self.norImage = nil;
    self.selectImage = nil;
    self.customButtons = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    
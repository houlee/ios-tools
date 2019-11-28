//
//  GC_UIkeyView.m
//  caibo
//
//  Created by houchenguang on 14-9-11.
//
//

#import "GC_UIkeyView.h"
#import "caiboAppDelegate.h"

@implementation GC_UIkeyView

@synthesize delegate;
@synthesize keyType;
@synthesize hightFloat;

- (void)dealloc{
//    if (bgButton) {
//        [bgButton removeFromSuperview];
//        bgButton = nil;
//    }
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withType:(GC_UIkeyType)uikeyType
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        keyType = uikeyType;
        [self.layer setMasksToBounds:YES];
//        caiboAppDelegate * caibo = [caiboAppDelegate getAppDelegate];//frame.size.height - 54*4-2.5
        mainFrame = frame;
        self.frame = CGRectMake(0, frame.size.height, frame.size.width, 54*4);
        self.userInteractionEnabled = YES;
        CGFloat widthFloat = frame.size.width / 3;
        CGFloat sizehight = (54*4)/4.0;
        self.backgroundColor = [UIColor whiteColor];
        NSInteger tagcount = 1;
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                
                float xf = widthFloat*j;
                
                UIButton * numButton = [UIButton buttonWithType:UIButtonTypeCustom];
                numButton.frame = CGRectMake(xf, sizehight*i, widthFloat, sizehight);//CGRectMake(xf, 0.5+54*i+0.5*i, widthFloat, 54);
                //                [numButton setBackgroundImage:nil forState:UIControlStateNormal];
                numButton.tag = tagcount;
                [numButton addTarget:self action:@selector(pressNumButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:numButton];
                numButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                numButton.titleLabel.font = [UIFont systemFontOfSize:24];
                
                
                if (tagcount == 10) {
                    numButton.tag = 11;
                    //                   numButton.titleLabel.textColor = [UIColor blackColor];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhuqueding.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhuqueding_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                    [numButton setTitle:@"确定" forState:UIControlStateNormal];
                    [numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }else if (tagcount == 11) {
                    numButton.tag = 0;
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                    [numButton setTitle:@"0" forState:UIControlStateNormal];
                    [numButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                   
                }else if (tagcount == 12) {
                    
                    UIImageView * deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake((widthFloat - 24)/2, (sizehight - 16)/2, 24, 16)];
                    deleteImage.backgroundColor = [UIColor clearColor];
                    deleteImage.image = UIImageGetImageFromName(@"deleteimagekey.png");
                    [numButton addSubview:deleteImage];
                    [deleteImage release];
                    numButton.tag = 10;
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhudelete.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhudelete_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                    [numButton setTitle:@"" forState:UIControlStateNormal];
                    
                }else{
//                   numButton.titleLabel.textColor = [UIColor blackColor];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                    [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                    [numButton setTitle:[NSString stringWithFormat:@"%d", (int)tagcount] forState:UIControlStateNormal];
                    [numButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

                }
                tagcount += 1;
            }
            
        }
        
            
        
        if (keyType == downShowKey) {
            self.frame = CGRectMake(0, 80, frame.size.width, 0);
        }
 
    }
    return self;
}

- (void)pressNumButton:(UIButton *)sender{

    if (delegate && [delegate respondsToSelector:@selector(keyViewDelegateView:jianPanClicke:)]) {
        [delegate keyViewDelegateView:self jianPanClicke:sender.tag];
    }
}

- (void)pressBGButton:(UIButton *)sender{
    if (delegate && [delegate respondsToSelector:@selector(buttonRemovButton:)]) {
        [delegate buttonRemovButton:self];
    }
    
}

- (void)showKeyFunc{
    
    self.hidden = NO;
    bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.tag = 99;
    
    [bgButton addTarget:self action:@selector(pressBGButton:) forControlEvents:UIControlEventTouchUpInside];
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    if (keyType == downShowKey) {
         bgButton.frame = CGRectMake(0, hightFloat+80+54*4, mainFrame.size.width,app.window.frame.size.height - 54*4 - 80 - hightFloat);
         bgButton.backgroundColor = [UIColor clearColor];
    }else{
         bgButton.frame = CGRectMake(0, 0, mainFrame.size.width,app.window.frame.size.height - 54*4 - hightFloat);
        if (keyType == blankShowKey) {
            bgButton.backgroundColor = [UIColor clearColor];
        }else{
            bgButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        }
        
    }
   
    [app.window addSubview:bgButton];
    
    [UIView beginAnimations:@"ndd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (keyType == downShowKey) {
        self.frame = CGRectMake(0, 80, mainFrame.size.width, 54*4);
        
        upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upButton.backgroundColor = [UIColor clearColor];
        [upButton addTarget:self action:@selector(pressBGButton:) forControlEvents:UIControlEventTouchUpInside];
        upButton.frame = CGRectMake(0, 0, mainFrame.size.width,hightFloat+80);
        [app.window addSubview:upButton];
    }else{
        self.frame = CGRectMake(0, mainFrame.size.height - 54*4, mainFrame.size.width, 54*4);
    }
        
    [UIView commitAnimations];
}

- (void)hiddenFunc{
    self.hidden = YES;
}

- (void)dissKeyFunc{
    [UIView beginAnimations:@"ndd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(hiddenFunc)];
    
    if (keyType == downShowKey) {
        self.frame = CGRectMake(0, 80, mainFrame.size.width, 0);
        if (upButton) {
            [upButton removeFromSuperview];
            upButton = nil;
        }

    }else{
        self.frame = CGRectMake(0, mainFrame.size.height, mainFrame.size.width, 54*4);
    }
    
    
    [UIView commitAnimations];
    
    if (bgButton) {
        [bgButton removeFromSuperview];
        bgButton = nil;
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
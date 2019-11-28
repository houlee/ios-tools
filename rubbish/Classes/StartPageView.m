//
//  StartPageView.m
//  caibo
//
//  Created by cp365dev on 14-8-25.
//
//

#import "StartPageView.h"
#import <QuartzCore/QuartzCore.h>

@interface StartPageView ()
{
    UIImageView *bgImage;
    
    UIImageView *logoImage;
    
    UIImageView *textImage;
}
@end

@implementation StartPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        bgImage = [[UIImageView alloc] initWithFrame:frame];
        bgImage.backgroundColor = [UIColor clearColor];
        
        if(IS_IPHONE_5){
            [bgImage setImage:UIImageGetImageFromName(@"startpage_bg_5.png")];
        }else{
            [bgImage setImage:UIImageGetImageFromName(@"startpage_bg_4.png")];

        }
        [self addSubview:bgImage];

        
        logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(51.5, 200, 217, 97.5)];
        [logoImage setImage:UIImageGetImageFromName(@"startpage_logo.png")];
        logoImage.alpha = 0;
        [bgImage addSubview:logoImage];

        
        textImage = [[UIImageView alloc] initWithFrame:CGRectMake(42, 195, 236.5, 68.5)];
        textImage.image = UIImageGetImageFromName(@"startpage_text.png");
        textImage.alpha = 0;
        [bgImage addSubview:textImage];

        
        
        
        
    }
    return self;
}
-(void)show
{
//    [UIImageView animateWithDuration:0.7 animations:^{
//        
//        logoImage.frame =CGRectMake(51.5, 95, 217, 97.5);
//        logoImage.alpha = 1;
//        
//    } completion:^(BOOL finish){
//        
////        [self performSelector:@selector(textShow) withObject:nil afterDelay:0.6];
//        [self textShow];
//    }];
    
     NSLog(@"show1");
    [UIView animateWithDuration:0.7f animations:^{
    
         NSLog(@"show2");
        logoImage.frame =CGRectMake(51.5, 95, 217, 97.5);
        logoImage.alpha = 1.0;
        
    } completion:^(BOOL finished){
        NSLog(@"show3");
        
        [self performSelector:@selector(textShow) withObject:nil afterDelay:0.6f];
        
//        [UIView animateWithDuration:0.7f delay:0.0f options:UIViewAnimationCurveEaseOut animations:^{
//        
//            
//            textImage.frame = CGRectMake(42, 195, 236.5, 68.5);
//
//            textImage.alpha = 1.0;
//        
//        } completion:^(BOOL finished){
//        
//            NSLog(@"动画完成");
//        }];

    
    }];

}

-(void)textShow{

    
    NSLog(@"textShow");
    
    [UIView animateWithDuration:0.7f animations:^{
    
        textImage.alpha = 1.0;
    
    }];
    
    
//    [UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:.7];
//    textImage.alpha = 1;
//	[UIView commitAnimations];

}

-(void)dealloc
{
    
    [bgImage release];
    [logoImage release];
    [textImage release];
    [super dealloc];
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
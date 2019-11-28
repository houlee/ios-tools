//
//  UpLoadView.m
//  Experts
//
//  Created by v1pin on 15/11/4.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1UpLoadView.h"
#import <QuartzCore/QuartzCore.h>


@implementation V1UpLoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)animationView{
//    
//    loadImage.frame = CGRectMake(5, 5, 114, 110);
//    loadImage.image =[UIImage imageNamed:@"刷新.png"];
//    [UIView beginAnimations:@"nddd" context:NULL];
//    [UIView setAnimationDuration:4];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//
//    loadImage.layer.masksToBounds = YES;
//    loadImage.frame = CGRectMake(5, 5, 114, 0);
//    
//    [UIView commitAnimations];
//}
//
- (id)init{
    self = [super init];
    if (self) {
//        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        self.frame = appDelegate.window.bounds;
        
//        UIView *background = [[UIView alloc]init];
//        background.frame = CGRectMake((self.frame.size.width - 136 )/ 2, (self.frame.size.height - 78 )/ 2, 136, 78);
//        background.alpha = 0.88;
//        background.backgroundColor = [UIColor whiteColor];
//        [self addSubview:background];
        
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
//            backgroundIma.alpha=0.88;
//        }else{
//            backgroundIma.alpha=1;
//        }

        UIImageView * loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20 )/ 2, (self.frame.size.height - 20 )/ 2, 20, 20)];
        loadImageView.image=[UIImage imageNamed:@"刷新.png"];
        loadImageView.backgroundColor=[UIColor clearColor];
        [self addSubview:loadImageView];
        
        CABasicAnimation *rotationAnimation =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI)*60];
        rotationAnimation.duration = 60;
        rotationAnimation.repeatCount = 0;
        rotationAnimation.speed = 0.7;
        
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [loadImageView.layer addAnimation:rotationAnimation forKey:@"run"];
        loadImageView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
        
    }
    return self;
}

- (void)stopRemoveFromSuperview{
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
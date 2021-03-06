//
//  UpLoadView.m
//  caibo
//
//  Created by houchenguang on 13-2-26.
//
//

#import "UpLoadView.h"
#import "caiboAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation UpLoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)animationView{
#ifdef isHaoLeCai
    jzImage2.frame = CGRectMake(5.5, 5, 114, 110);
    
    jzImage2.image = [UIImageGetImageFromName(@"jiazaizhezhao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    jzImage2.layer.masksToBounds = YES;
    jzImage2.frame = CGRectMake(5.5, 5, 114, 0);
    
    [UIView commitAnimations];
#else
     jzImage2.frame = CGRectMake(5, 5, 114, 110);
    
    jzImage2.image = UIImageGetImageFromName(@"jiazaizhezhao.png");
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
   jzImage2.layer.masksToBounds = YES;
    jzImage2.frame = CGRectMake(5, 5, 114, 0);
    
    [UIView commitAnimations];
#endif
   
    
}

- (id)init{
    self = [super init];
    if (self) {
       self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.frame = appDelegate.window.bounds;
        
        UIImageView *backgroundIma = [[UIImageView alloc]init];
        backgroundIma.frame = CGRectMake((self.frame.size.width - 136 )/ 2, (self.frame.size.height - 78 )/ 2, 136, 78);
        backgroundIma.alpha = 0.88;
        backgroundIma.image = [UIImage imageNamed:@"yezibeijing2.png"];
        backgroundIma.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundIma];
        [backgroundIma release];

        
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
            
            backgroundIma.alpha=0.88;
//            backgroundIma.alpha=1;
        }
        else{
            
            backgroundIma.alpha=1;
        }
        
        
        UIView *huiseView = [[UIView alloc]init];
        huiseView.backgroundColor=[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1];
//        huiseView.layer.masksToBounds=YES;
//        huiseView.layer.cornerRadius = 39.5/2;
        huiseView.frame = CGRectMake((backgroundIma.frame.size.width - 34 )/ 2, (backgroundIma.frame.size.height - 34 )/ 2, 34, 34);
        [backgroundIma addSubview:huiseView];
        [huiseView release];
        
        
        
        UIView *middleView = [[UIView alloc]init];
        middleView.frame = CGRectMake(((backgroundIma.frame.size.width - 35 )/ 2)+8.5, ((backgroundIma.frame.size.height - 35 )/ 2)+8.5, 17, 17);
        middleView.backgroundColor = [UIColor clearColor];
        [backgroundIma addSubview:middleView];
        UIImageView *middleIma = [[UIImageView alloc]init];
        middleIma.frame = CGRectMake(3, 3, 14, 14);
        middleIma.alpha=0.8;
        middleIma.image = [UIImage imageNamed:@"yeziqiu.png"];
        middleIma.backgroundColor = [UIColor clearColor];
        [middleView addSubview:middleIma];
        [middleView release];
        [middleIma release];
        
        
        UIImageView * loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundIma.frame.size.width - 35 )/ 2, (backgroundIma.frame.size.height - 35 )/ 2, 35, 35)];
        loadImageView.image=[UIImage imageNamed:@"yeziheise.png"];
        loadImageView.backgroundColor=[UIColor clearColor];
        [backgroundIma addSubview:loadImageView];
        [loadImageView release];
        
        
        
        
        
        
        CABasicAnimation *rotationAnimation1 =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation1.toValue = [NSNumber numberWithFloat:(2 * -M_PI)*60];
        rotationAnimation1.duration = 60;
        rotationAnimation1.repeatCount = 0;
        rotationAnimation1.autoreverses = NO;
        rotationAnimation1.speed = 0.7;
        rotationAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [middleView.layer addAnimation:rotationAnimation1 forKey:@"run"];
        middleView.layer.transform = CATransform3DMakeRotation([rotationAnimation1.toValue floatValue],0.0,0.0,1.0);
        [middleView.layer setAnchorPoint:CGPointMake(1, 1)];
        
        CABasicAnimation *rotationAnimation =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI)*60];
        rotationAnimation.duration = 60;
        rotationAnimation.repeatCount = 0;
        rotationAnimation.speed = 0.7;

        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [loadImageView.layer addAnimation:rotationAnimation forKey:@"run"];
        loadImageView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
        
        CABasicAnimation *rotationAnimation2 =
        [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation2.toValue = [NSNumber numberWithFloat:(2 * M_PI)*60];
        rotationAnimation2.duration = 60;
        rotationAnimation2.repeatCount = 0;
        rotationAnimation2.speed = 0.7;

        rotationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [huiseView.layer addAnimation:rotationAnimation2 forKey:@"run"];
        huiseView.layer.transform = CATransform3DMakeRotation([rotationAnimation2.toValue floatValue],0.0,0.0,1.0);

        
    }
    return self;
}



- (void)stopRemoveFromSuperview{

    [timerstar invalidate];
    [self removeFromSuperview];
}

- (void)dealloc{
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
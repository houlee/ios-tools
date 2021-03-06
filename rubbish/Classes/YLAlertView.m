//
//  YLAlertView.m
//  caibo
//
//  Created by cp365dev on 15/3/9.
//
//

#import "YLAlertView.h"
#import "newHomeViewController.h"
@implementation YLAlertView

-(id)initYLAlertView{

    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    self.alpha = 0;
    
    if(self){
        
        UITapGestureRecognizer *_tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clostAlert:)];
        [self addGestureRecognizer:_tapGestureRec];
        [_tapGestureRec release];

        UIImageView *bgview = [[UIImageView alloc] initWithFrame:self.frame];
        bgview.image = [UIImage imageNamed:@"ylalert_bgview.png"];
        bgview.userInteractionEnabled = YES;
        [self addSubview:bgview];
        [bgview release];
        
        //攻略
        saishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saishiBtn setFrame:CGRectMake(41+29, (self.frame.size.height-206)/2.0+25, 58, 50)];
        saishiBtn.tag = 100;
        saishiBtn.alpha = 0.3;
        [saishiBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [saishiBtn setBackgroundImage:[UIImage imageNamed:@"ylalert_btngl.png"] forState:UIControlStateNormal];
        [bgview addSubview:saishiBtn];

        
        //pk赛
        glBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [glBtn setFrame:CGRectMake(163+29, (self.frame.size.height-206)/2.0+25, 58, 50)];
        glBtn.tag = 101;
        glBtn.alpha = 0.3;
        glBtn.hidden = YES;
        [glBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [glBtn setBackgroundImage:[UIImage imageNamed:@"ylalert_btnpk.png"] forState:UIControlStateNormal];
        [bgview addSubview:glBtn];
        
        //赛事直播
        weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiboBtn setFrame:CGRectMake(41+29, (self.frame.size.height-206)/2.0 + 106+25, 58, 50)];
        weiboBtn.alpha = 0.3;
        weiboBtn.tag = 102;
        weiboBtn.hidden = YES;
        [weiboBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [weiboBtn setBackgroundImage:[UIImage imageNamed:@"ylalert_btnsszb.png"] forState:UIControlStateNormal];
        [bgview addSubview:weiboBtn];
        
        //关于
        ylBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ylBtn setFrame:CGRectMake(163+29, (self.frame.size.height-206)/2.0 + 106+25, 58, 50)];
        ylBtn.tag = 103;
        ylBtn.alpha = 0.3;
        ylBtn.hidden = YES;
        [ylBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [ylBtn setBackgroundImage:[UIImage imageNamed:@"ylalert_btnabout.png"] forState:UIControlStateNormal];
        [bgview addSubview:ylBtn];

        //关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setFrame:CGRectMake(0, self.frame.size.height-80, 80, 80)];
        [closeBtn addTarget:self action:@selector(clostAlert:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:closeBtn];
        
        UIImageView *closeimg = [[UIImageView alloc] initWithFrame:CGRectMake(33, 33, 15, 15)];
        closeimg.backgroundColor = [UIColor clearColor];
        closeimg.image = [UIImage imageNamed:@"newhomegojia.png"];
        [closeBtn addSubview:closeimg];
        [closeimg release];
        
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/4];
        rotationAnimation.duration = 0.0f;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [closeBtn.layer addAnimation:rotationAnimation forKey:@"run"];
        closeBtn.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
        
    }
    return self;
}

-(void)btnPress:(UIButton *)sender{
    
    UINavigationController *a = (UINavigationController *)self.window.rootViewController;
    NSArray * views = a.viewControllers;
    UIViewController * newhome = [views objectAtIndex:0];
    
    
    //攻略
    if(sender.tag == 100){


        if ([newhome isKindOfClass:[newHomeViewController class]]) {
            [(newHomeViewController *)newhome  performSelector:@selector(pressGonglue:) withObject:nil];
        }

    }
    //PK赛
    else if(sender.tag == 101){
        
        
        if ([newhome isKindOfClass:[newHomeViewController class]]) {
            [(newHomeViewController *)newhome  performSelector:@selector(pressOldPkbut:) withObject:nil];
        }
    
    }
    //赛事直播
    else if(sender.tag == 102){
        
        
        if ([newhome isKindOfClass:[newHomeViewController class]]) {
            [(newHomeViewController *)newhome  performSelector:@selector(pressbfsp:) withObject:nil];
        }
    
    }
    //关于
    else if(sender.tag == 103){
        
        
        if ([newhome isKindOfClass:[newHomeViewController class]]) {
            [(newHomeViewController *)newhome  performSelector:@selector(goAbout:) withObject:nil];
        }
    
    }
    
    [self removeAlertFromSuperview];
}
-(void)show{
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
    [self performSelector:@selector(show1) withObject:nil afterDelay:0];
    [self performSelector:@selector(show2) withObject:nil afterDelay:0.05];
    [self performSelector:@selector(show3) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(show4) withObject:nil afterDelay:0.15];
    
}
-(void)show1{
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.alpha = 1;
        saishiBtn.alpha = 0.7;
        saishiBtn.frame = CGRectMake(41, (self.frame.size.height-206)/2.0, 116, 100);
        
    }];
    
}
-(void)show2{
    
    [UIView animateWithDuration:0.15 animations:^{
        
        glBtn.alpha = 0.7;
        glBtn.hidden = NO;
        [glBtn setFrame:CGRectMake(163, (self.frame.size.height-206)/2.0, 116, 100)];
        
    }];
}
-(void)show3{
    
    [UIView animateWithDuration:0.15 animations:^{
        
        weiboBtn.alpha = 0.7;
        weiboBtn.hidden = NO;
        [weiboBtn setFrame:CGRectMake(41, (self.frame.size.height-206)/2.0 + 106, 116, 100)];
        
    }];
}
-(void)show4{
    
    [UIView animateWithDuration:0.15 animations:^{
        
        ylBtn.alpha = 0.7;
        ylBtn.hidden = NO;
        [ylBtn setFrame:CGRectMake(163, (self.frame.size.height-206)/2.0 + 106, 116, 100)];
        
    }];
}


-(void)clostAlert:(UIButton *)sender{
    
    [self removeAlertFromSuperview];
    
}

-(void)removeAlertFromSuperview{
    
    
    if(self.superview != nil){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished){
            
            [self removeFromSuperview];
            
        }];
        
        
    }
}@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    